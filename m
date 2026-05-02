Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 699D3CD3423
	for <u-boot@archiver.kernel.org>; Sat,  2 May 2026 12:53:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A374283642;
	Sat,  2 May 2026 14:53:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RUvYeSPZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E805F83693; Sat,  2 May 2026 14:53:33 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B80F280F0E
 for <u-boot@lists.denx.de>; Sat,  2 May 2026 14:53:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-67bc8609a9bso2214709a12.0
 for <u-boot@lists.denx.de>; Sat, 02 May 2026 05:53:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777726411; cv=none;
 d=google.com; s=arc-20240605;
 b=T1ANlxT5qBwWQa/2gWp+IMnODzOkYluuvOef5cn1ZVv2atQCB2o3UmTMo1UV6GEpI0
 NUsFqb4hPAIa4+pwFPaD919W/jQd2XTpq4ZHEpR1r/UukYZ6JAXiFb8z4obQCmtlZ5/F
 vybUzzmy0xqdtKohvMYnpiu0cptB2KlU8WtbU8EjnVRCvpXehwRdY5KzZgoiWS8nYxUD
 Dry15om1nE6K4mX9ovF33TEsIWZReZLELd14wisz7Pjht/5VAjUh7V6ekCUmqVDCjjpf
 MY1yUWjZ0r9jcuiENwbg59PSzCrjgsPw3KECNQ6i82h6BdaOYvR76uAgI916+kOmPkg7
 QfvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XKfl4+7CuVLFmtaydWZzrplyvbmiZznGc9MdSGUvP3Q=;
 fh=lZqAeOhyRklMgzXBK2XO3q47UzoZZQV+k+ZpJ8Gw8pg=;
 b=GBxCKGBj03aZLQf6yaoA0Be1SzLFH/p1jdbaCduNr7g686tL9aJNhkOUfHgZ4r+19v
 mHsadat67ASTQ3D++g7oOnrvluNrlhwvkhkWO6N65oGWxSfBJ7CALtN5WAX3lu+CHCKg
 DhT+rGzTARgfzrJsa89m30JtfXdMtLsmp7gEkZD41s4kW29UdYrR+2Ohz6nVDbsyT1Fs
 Q0B/MS239tdCK165Wa5e3MHgc3bzMXbUQYHmZmJ62i09hITkwAor8iolNBeTCqwEbIPD
 GyRseGUSAsuQToZr2gGQ8wtFWLRXvq1SVpwDSUS6QEjJcFRan+XLE3wxnvn3X39Vl6P7
 ShVQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777726411; x=1778331211; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XKfl4+7CuVLFmtaydWZzrplyvbmiZznGc9MdSGUvP3Q=;
 b=RUvYeSPZD1cuDC98RbVtCzEGZ+bkDKFbsZWN5DDr39Wi0R/uVyq412UUKfUOb9iHR5
 VwE10BZQi/GeoDhZRH5F63jxwfFldKJMR+1z1Iqhsk/aRe5Bouu7XMBQYjizOCkDNQWQ
 ZSkwyjwO4mvMGnjqUOLPP0q/SyzLdWAp1wwI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777726411; x=1778331211;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XKfl4+7CuVLFmtaydWZzrplyvbmiZznGc9MdSGUvP3Q=;
 b=J4Hl9a4DR4OgcFqjjNpjg5mrZnxlp3ZbmPDa79KrBCl5MnE4t1bQEDfoHOgSJcskrm
 sZ3U1NBJr0sctMTRZJWxV6cTuWEpsnyvMV6YCVtAFGT/K8+PZBeULO7Q7N5zk0+BJ20C
 FkCwx+RpRbOlCs5teEIKHiOmgk3SHzbDn/2Z+mP3JGvGucbt8+KGLGrAl445QDqtSOV6
 XcGLetAZD1+/mqcXs5s3PbCmMdvZ7JqB3xXImf4HDOpvDo4OhUo+n035uTcpzB4oQ0vX
 0AWVkeFusH+VtsRUeDySvlj4a3Kfp225E1f4vz9ZRhO+3PJ6eUDTNoSJmsfwHJyto4ze
 c1tw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8WreaR0CaOnu8DYTbejxM9WYIGgMDOCmb7xfyilbBJ6iH1kjIqROanyar3V/GZSeJ+unJnUqA=@lists.denx.de
X-Gm-Message-State: AOJu0YzxOFXtgxtK6zKmoW0xwhiIwwEdUgcnRZZjzv53XzJCL7xMgCLy
 eTAuDb9PTYe1Q+g4SwWJYYT68mziSZiG/UfdqFXahLKZu3UTMrroAsB71PHOyYkH/xtLpdo84f1
 RYJuG1wpxdVfTfABQ0mhflZlTeeNZUrXOn87FG7jz
X-Gm-Gg: AeBDiesNCe0EyiLuVzE5/CDlE4VdgcaX8uXEmeldiYp0BF/mWAysiVPKZbd/Q/kuaVT
 9R5MDkZnC+Zdp62+rL7WXCqxDykgZgodtjptpv/wnraDYbfvyS0PLdUcIF27y9JOGLWhHfx+WX+
 U5BZkAWkZGt0w/BpLPy4Wn5++l9aQOaF0VqD0vXGT/1ysE/KIJ2+xzfSa+WhMz7IXYXQ5rWK1cu
 YXnjBHpIeS3gCkd97dku5axWZbmr0KG9Kj3mji1aXRmPchp718aetFuRTMMWiS+yzY7RbG5gojw
 qS6SfcmfH4JWkbjpvHUQ0/rUG0w=
X-Received: by 2002:a17:906:fe04:b0:bab:8238:63ba with SMTP id
 a640c23a62f3a-bbff64df965mr138585666b.0.1777726411162; Sat, 02 May 2026
 05:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260429165629.104063-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260429165629.104063-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 May 2026 06:53:18 -0600
X-Gm-Features: AVHnY4IT7vwPV8v7OKLYsKcsI8063T2W7unPvw2dxBwGZ2GEFCTFKj2KA5HGL54
Message-ID: <CAFLszThCYP4wd37QB4Lc7EJUZBfu4P5UQNaF9WWf4PKCBiifQw@mail.gmail.com>
Subject: Re: [PATCH 1/1] cmd: eficonfig: adjust struct eficonfig_entry,
 field key
To: heinrich.schuchardt@canonical.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
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

On 2026-04-29T16:56:29, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> cmd: eficonfig: adjust struct eficonfig_entry, field key
>
> The number EFICONFIG_ENTRY_NUM_MAX - 1 must be printable
> to field key of struct eficonfig_entry.
>
> Fixes: 1f0583beeb32 ("eficonfig: set EFICONFIG_ENTRY_NUM_MAX to INT_MAX - 1")
> Fixes: 23aa0502a4b9 ("eficonfig: increase the number of menu entries")
> Addresses-Coverity-ID: 583414 - Out-of-bounds write
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> include/efi_config.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
