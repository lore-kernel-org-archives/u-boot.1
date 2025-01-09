Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B103E77199
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 12:37:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D47E7801F5;
	Thu,  9 Jan 2025 13:37:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kDvVr1Gj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4526D80602; Thu,  9 Jan 2025 13:37:23 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 083F38005B
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 13:37:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aa6c0d1833eso198368966b.1
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 04:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736426240; x=1737031040; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BlC1Vszyd7ItOd0IMAPNpKih3vpg9+J32hWsBMXAqPw=;
 b=kDvVr1Gj5lFJTENQPgnj/Dub9D11k1ArlBc14Q3ifBvXpaOE/t/UY7HEDK4I2zXed8
 gw4/m+jA826xSO7HhahNUlVO7G148v2Ggj6eb36Clm6p/mojEXcFjKBot3ROEyfTAgxZ
 uL5iu8hWb83AqUIgjMartN225bDQRqI09lg1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736426240; x=1737031040;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BlC1Vszyd7ItOd0IMAPNpKih3vpg9+J32hWsBMXAqPw=;
 b=fBB6mQ3mQUwQbv52cYjkI++yP0iXi+TQrLgbhZu1OyWzLOAUTns7YjZnOX0XwnCZ09
 qrhZEKSP9T27VRCJQ9cdRH972LGMCrwienUnri7mylZqYAWGsktioyGCmbuiIGuO2cs5
 VP5ud9r9Zy5Adtd0Oz99ngShNQxK+XFfJCwDe9WI/oFWbU3XMyIjUodD0gozWiEIkMqF
 +LxNHkmkkPq1uCy+fHBfAcldNlUShO3Urobg4SRHIifwgENxNDv8yirAep8b8kb7mJBR
 2zDz5enNP0zoOt5Ibb7ZmjWztO0+7/MezLU+ElctOeJuABi/UJOJtWJDEFoPh5W8I3am
 OrzA==
X-Gm-Message-State: AOJu0YwSULOHS6UJX9quX4m97w0KnmURtBUL5BH+zBUVYelLLkx82e5f
 CFjObTv3haMN+CHJSLFTgSSlP4GMgJg8bN4fVsrznyAD7YYm+ry6Ms24pQGGqptMfUlMZxlwcU2
 PiMxGm1R7HMzwKL389hso/otDgwATNCKaui+c
X-Gm-Gg: ASbGncvwcWBEKfSd8dvUj+FiKq5KMSbb9OtQkEUdbEGerSYIVLrnhLkHoNT+rG+qNE2
 CJAIabyFARogkhE/4an+MQnBjsjzaVjMmP/AzgxY=
X-Google-Smtp-Source: AGHT+IEuCohVZhiSY7naIB2Nffrc7kZj2kzktakhzVU6odrO1c4Rc62CWD+PbBfJ7v/St6932Gcr7m16heFGCWLIdD0=
X-Received: by 2002:a17:906:f58a:b0:aa6:b473:8500 with SMTP id
 a640c23a62f3a-ab2abcaafb9mr514238766b.42.1736426240406; Thu, 09 Jan 2025
 04:37:20 -0800 (PST)
MIME-Version: 1.0
References: <20250106143229.3023771-1-sjg@chromium.org>
 <20250106143229.3023771-13-sjg@chromium.org>
 <20250108183345.GO3476@bill-the-cat>
In-Reply-To: <20250108183345.GO3476@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 9 Jan 2025 05:37:08 -0700
X-Gm-Features: AbW1kvb4wHpbLOizm7ILyDqP9lE4XoV5vuK33F4vWA9ZvJl5883t3LVUPdEgR50
Message-ID: <CAFLszTjJVB4C-LG2oNxDtvdG1xzfsWhk=4ByBBQDwBeDRqVjfA@mail.gmail.com>
Subject: Re: [PATCH v2 12/33] ofnode: Use 4K for a default tree-size
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>
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

Hi Tom,

On Wed, 8 Jan 2025 at 11:33, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Jan 06, 2025 at 07:32:08AM -0700, Simon Glass wrote:
>
> > At some point it would be nice to have the ofnode API automatically
> > expand the tree as required, to accommodate new nodes. For now, expand
> > the default size so that UPL can be supported.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  drivers/core/ofnode.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Why not have oftree_new take a size parameter?

Well, the real solution is as in the commit message. This commit is
just kicking it down the road, but we need to make progress on
livetree, as the logic to automatically expand a flattree could be a
bit painful. I'm not sure if someone other than me is interested in
working on it.

I just felt that 1K was a bit small to be useful.

Regards,
Simon
