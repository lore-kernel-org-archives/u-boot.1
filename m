Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B5DD2C11B
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 15:12:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D291F891C7;
	Tue,  5 Nov 2024 16:12:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MVhl2lSE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77E76891C3; Tue,  5 Nov 2024 16:12:51 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82344891AF
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 16:12:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a9a628b68a7so861320666b.2
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 07:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730819569; x=1731424369; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ktKaUKxPcCrrJfnjpvzxlAkgu3O1U7/stBHTHfbWEsw=;
 b=MVhl2lSEqz5pD21KICXa3VW3V2iaGKGgwVrISDEnDqMPe+dvz+wle/wthh+xu0zOTZ
 Fp6jOvwAhcXEP4O7ln6LcC2r0c7JtHD6ttI3wwNy7HrM3lxjx3vH4cqhX2WyEDzvMHgq
 whgpp48jy7oRQ/PjWg7D8GL25IcrtHHjzvQw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730819569; x=1731424369;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ktKaUKxPcCrrJfnjpvzxlAkgu3O1U7/stBHTHfbWEsw=;
 b=dvQh+3zI4j4Y19+jQ2mi2SUOFrth0WIh5WT48ezVDyeF+Zp9UiNVUanQcLkE1tqQH1
 3sCe4cx1Pjl/ZlYuvcf3pv33YAzCRKzfhXFbeVbJ3bt+RFd7MM1BglBxLDMNIIRgXaPd
 pozUwWnrygKUvUSWrAyLUr60ELZ0LxBFAVWf+6cCBsaNKjjd6xBPuScZa4wvV0TtH9SO
 hJA2Rbr1SbgNkGdqYdYKLb+Kq5yYDbnQ/u+uVNCsJZF08ke/L582u6In/5c1l3Z4jAoE
 O1+z1SPdyWpBKjzjEYsct4+4kq8EicJ1wkOkMTEtiSuBBr/h3jc4V7jONsawUpheJ3N8
 2ZOQ==
X-Gm-Message-State: AOJu0YwVReJeVNLPCBTvDt3hHZl6Yi/6uxd3mWPzXPQL8BJnAQWfsubW
 a6wrswOYPAzkXFsGeA0Uh0KpQYoqpzQ80QhPDf/4KSLrHKzSop94zQ2XIaUVAorjgp09Hrk6SND
 SpqFJIP+Rq0P6TO2p6Dh1w0UJm/oKOGAvYRI7
X-Google-Smtp-Source: AGHT+IGNtSv/SqtfG/+IAb70lvDzHkQGBsb1+e8fj8NtyGHJafKOD4KcN30yeC/w1GThA+6vgzlZPgUwcbdmFkxmg3g=
X-Received: by 2002:a17:907:6d29:b0:a9a:4aa3:728b with SMTP id
 a640c23a62f3a-a9e657fcd36mr1528411666b.53.1730819568810; Tue, 05 Nov 2024
 07:12:48 -0800 (PST)
MIME-Version: 1.0
References: <20241105120653.99438-1-jerome.forissier@linaro.org>
In-Reply-To: <20241105120653.99438-1-jerome.forissier@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 5 Nov 2024 08:12:37 -0700
Message-ID: <CAFLszThT7hmuNmkq7y_sC8pzn0JWVZVqrM+cU0sMTvVN1eG8ag@mail.gmail.com>
Subject: Re: [PATCH] test/cmd/wget.c: move net_test_wget() to the cmd test
 suite
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Yasuharu Shibata <yasuharu.shibata@gmail.com>
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

On Tue, 5 Nov 2024 at 05:07, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Since net_test_wget() is testing a command and is in test/cmd it
> should be in the 'cmd' test suite, not 'lib'.
>
> Reported-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  test/cmd/wget.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
