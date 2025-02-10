Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7499CC0219D
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 13:09:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E476C80AE6;
	Mon, 10 Feb 2025 14:09:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ngWBwErX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 591F380B98; Mon, 10 Feb 2025 14:09:01 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC6BE803B5
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 14:08:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21f48ab13d5so67282525ad.0
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 05:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739192937; x=1739797737; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t3HUUD28orGGETrKf5PVUSHlA3UHTq+KSTDoDniuW/c=;
 b=ngWBwErX8qEhMhRwZ/PDSx0hoqMogAwCHnOTv8MSB53J8eHay0QvGSVeR1q4qWHciz
 79Hkbtscpu5OAbfu1i6phq3+6PKYv9NnNQl0IpcvATIMDVtJEpntjWexJsA+m/DD5ilJ
 L6PX27zs51gI9NqaVoZ21O2pBAmB07+iB9xzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739192937; x=1739797737;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t3HUUD28orGGETrKf5PVUSHlA3UHTq+KSTDoDniuW/c=;
 b=tWF0FPv1zyXhFfJQjS3XpF2BYl0eaS9DugdY28qZYJ7Wdeve/ToJ3y5wbRDzOhlbwr
 lxI+E3UFxb0t8pv+PNWxPPuZK3ftd6Y+m0Txva13FNSrSPLbeaHtxDDTGoejs8HRANnm
 vJFwev1zPh1HXecvGxy8FnQlRX/3ItBRd+p25zliBpDgOe954HdKn31nOltmEhEIKa/K
 kQuPah+dBjoKSsibdhhF2ptbs8A3SROH3Mxfq7Q96yprGppG3q8afOQ/Yk9L0xypGsKf
 hYo5qd1SbONHHEYHVz7vCrHMtL0/E2o0NG3xvPMZENKu9fMd2+H+4LTMTaOSaRCpvqmJ
 OU1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKH6FQrxtNMMfLmDWrxLCllMonmT+C40vkftyflmfKAUHbA+Q4qorR8d9rzQkBSRLiO3uy318=@lists.denx.de
X-Gm-Message-State: AOJu0YwHog4Xc4W8Bv0ZlXTqf2dyPwUFFkCobK118I82nfHNPGMJk1bd
 KixGfyatz2O1BoOvbrES4TuoXzcIsMJyAJFQITY1pwXggzcmsSYlsqYf71M/efg7PpPMFQ2yOnX
 rk5R4tJwIg7PfhyI2IOX9NZ+SFkWAeeVwEluK
X-Gm-Gg: ASbGnctow1x88Pv919OqEYmRX2pGvaM7EPpoi1z5ZxVpj5EJDdHcfhTlMZqRz45zYV8
 9ZIwdJHFoo7GSUrGwSFVqz3Fese4jMYHCYMrZyiydcb+CeyOofmt/EV11XhZ8bzhpIXH3f0MnFA
 ==
X-Google-Smtp-Source: AGHT+IEuw5YI/YWjiwKpG5Ryjbc9RT2xQsBVFqNxvaihuifUNJh22BF5tZO0YSezHYjzfdmYVG4i/oXrS7xi0wUoodU=
X-Received: by 2002:a05:6a00:3ccb:b0:72d:8d98:c256 with SMTP id
 d2e1a72fcca58-7305d44fbe4mr21743703b3a.6.1739192937295; Mon, 10 Feb 2025
 05:08:57 -0800 (PST)
MIME-Version: 1.0
References: <20250129-binman_faked_optional-v1-0-a4534bc67cbb@phytec.de>
 <20250129-binman_faked_optional-v1-6-a4534bc67cbb@phytec.de>
In-Reply-To: <20250129-binman_faked_optional-v1-6-a4534bc67cbb@phytec.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 10 Feb 2025 06:08:39 -0700
X-Gm-Features: AWEUYZmrxVSIhn5vNw869snaFDEcMVCf8-ubaDSdtamiMZ97j_xipICedYVsOWg
Message-ID: <CAFLszTgFvp_YYHZ5GzvZAfLmWeGmoTW5_vhM88ebd7RoA3Mo=g@mail.gmail.com>
Subject: Re: [PATCH RFC 6/6] binman: doc: update Optional entries
To: Yannic Moog <y.moog@phytec.de>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Tim Harvey <tharvey@gateworks.com>, 
 Benjamin Hahn <b.hahn@phytec.de>, Teresa Remmet <t.remmet@phytec.de>, 
 Yashwanth Varakala <y.varakala@phytec.de>, upstream@lists.phytec.de,
 u-boot@lists.denx.de
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

On Wed, 29 Jan 2025 at 03:30, Yannic Moog <y.moog@phytec.de> wrote:
>
> The binman documentation of Optional entries is not accurate in the
> sense that it does not cover blobs entry type. As this is also the most
> widely used type to have the optional entry, document the interaction
> with faking blobs.
>
> Signed-off-by: Yannic Moog <y.moog@phytec.de>
> ---
>  tools/binman/binman.rst | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
> index 990fc295770..2bafa6ca408 100644
> --- a/tools/binman/binman.rst
> +++ b/tools/binman/binman.rst
> @@ -1145,7 +1145,14 @@ called on all entries.
>  It is not possible for an entry to mark itself absent at any other point in the
>  processing. It must happen in the ObtainContents() method.
>
> -The effect is as if the entry had never been present at all, since the image
> +The effect depends on the type of entry.
> +
> +Blobs
> +~~~~~
> +For blobs, the effect depends on whether --fake-ext-blobs is passed
> +to binman. (This is the case by default)
> +In case --fake-ext-blobs is set, any missing entries will be faked.
> +If not set, it is as if the entry had never been present at all, since the image
>  is packed without it and it disappears from the list of entries.

I'm not quite following this. The text seems OK but your heading
implies that things other than blobs can be faked. All of this
functionality is only for blobs.

Regards,
Simon
