Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486EDC52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 14:01:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D50C88E01;
	Wed, 21 Aug 2024 16:00:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cfpUtg5o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F4D688DFF; Wed, 21 Aug 2024 16:00:15 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A001B88E01
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 16:00:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6bf705959f1so6718136d6.1
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 07:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724248809; x=1724853609; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=etZfyujbkXPb60eEaOkoW8GA2SbeF1hvht9OVZ+C4Xo=;
 b=cfpUtg5o062B6cPjeM4s4eox1NlMfj28uUNiEZA9OEU4iKadYrstCO4dS7qA6YmWhU
 zYBfCE6QoDmtieBWFzcHV8xtSbeLvTn590Vstvi4Y/eSTP9NappBcTNQyIt9RMJjHfM2
 9Vdgf8XkisU7P1YG3rNxT2w2xQMki8Kdvt8Qg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724248809; x=1724853609;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=etZfyujbkXPb60eEaOkoW8GA2SbeF1hvht9OVZ+C4Xo=;
 b=CUHeGRWsWurDcKDYq8ydvqvTIXY3VlaEX1MTRhZWjdW0r3Or0mTkzyXnsBjKoBrI1v
 sBkqRM/kJ+YSKXRN+zNB1DfUx4ZMHG1YtESs1QHhhIxHTwx+XTj8peaR4YmJtpKCQDut
 2/qnL05KyOOvtMX5zsth7F276U3oa/e1PPD7wBN6ODTBJEA69P/jZ3qvbldlh1nBC/tJ
 h2/fIoK5N58qgVLHhArEoTGFTKxbclq/Ib6seVP3pAfNUZmwGhVsQDZsWF6BTL2fhCnV
 +O57mazgn4DnIihQjttAOVvjlsXHJKTOzYMC+P0CtS0F9Yth/z5I+bFDo+EndcV1Oqyb
 y0wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVJ4qdZVK+uPu6dzsh8P+lYosRfnE7wLrhwKmAuTKMyP5DzUYkgL62anzu97UqDYNRzNy/C0E=@lists.denx.de
X-Gm-Message-State: AOJu0YxBRpolzuFmt8bzFlZz4AxhUPQRoB4Nyy239VGsss3aSDr2KXrl
 Umuhxm+Rqu5TEgBw99OjzZU4SOd6wU9/k1w6jeXG3h8/xEGBLehGdWehT4bA4aLjjtEHuiu9kY0
 g6eb0RH7Cpy2+ok6KwgMeBniwa6Ks9pku84vn
X-Google-Smtp-Source: AGHT+IGf2Peuo9mxz050MoyPYOnn/WKzR7cf8hdTJ9m0h46Ov0Sdiq0pu3IX698FXo6Vr/Iqz6wpdU9Yt20yD7iUU0g=
X-Received: by 2002:a05:6214:4b07:b0:6bf:968d:158d with SMTP id
 6a1803df08f44-6c1571c8b2cmr45918946d6.18.1724248809157; Wed, 21 Aug 2024
 07:00:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240821-b4-rb3gen2-v2-0-49b07633f3a8@linaro.org>
 <20240821-b4-rb3gen2-v2-7-49b07633f3a8@linaro.org>
In-Reply-To: <20240821-b4-rb3gen2-v2-7-49b07633f3a8@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 21 Aug 2024 07:59:57 -0600
Message-ID: <CAFLszTiqrqVF69sXfE18UpDtp9GFNUb-TsxMqJ=Qrf6PswVgQQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] doc: board/qualcomm: document rb3gen2
 building/flashing
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Wed, 21 Aug 2024 at 07:43, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> The process here is almost identical to the Dragonboard 410c, we've come
> full circle!
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  doc/board/qualcomm/index.rst   |  1 +
>  doc/board/qualcomm/rb3gen2.rst | 53 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
