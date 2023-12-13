Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A13C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 08:31:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E375C87463;
	Wed, 13 Dec 2023 09:31:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FNa71EjX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 862C5877D8; Wed, 13 Dec 2023 09:31:27 +0100 (CET)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DF5E871D7
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 09:31:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5906d0c38c3so3844588eaf.3
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 00:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702456284; x=1703061084; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cUMFpbFXPiPg/pwkbM7vUldInUxC4CbnDI/Ln/FriCE=;
 b=FNa71EjX2ANNeb1EFPfB2QBTp6UY/AHCMuljU7xvgNNJYD5ok0NZeNZBhn8Kp6yJ2R
 5a4g7WctHZNaLaTXhg67B0iPsOgLF3V9PEhVFOrN8kfKkmT5ekk6sDr+kprLKAI/78xR
 JMpOu1QrAP0oaLJNqEw87Bh/HsXOsZAUp/uT0JEScV4qssKXdDLyEbElLf141hLlFlY2
 Tq/Zwi+/OefUy1rv+ySpAQr7uL31tCWjM7zeEp6kUjnCECD1y68Bhp97A+iv1ltmWTB8
 aOaKnn6RnTKUa9Ppe/xaiSkJLWLMT+KscfmeAqokv8z8ff4ixCPrnRQ/mG1cU09/cBDp
 nwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702456284; x=1703061084;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cUMFpbFXPiPg/pwkbM7vUldInUxC4CbnDI/Ln/FriCE=;
 b=sp1QB72IzKoDjbyN8G8eDAdJDqfDXTEBCu0PO/Rl5PV3L+ISwfkXwfEabEZX5vyZ93
 CuEhnuIv8vZ4Zzqrbq9wbXxM9aSVqy7dFXml2qanH4lVVIPpfl1tGLiQwy+wXPssmuIp
 BDU8zzeQl4ptu85Os6HMAwNJQtu3idA38TY/zNGy2EFekp0wwNlMnMgXy7wdKoF+kEco
 RqoH6HjsTMMSlfOLBkX0zGbKRhXh4vgCYYrB9YcJq26wceet2KMpJrmJSlj9YavZuCvr
 FMcmZNAaqGwoBejzF8PbLyOC5Mnc7eLQThWnOj/oNuJzWXr70V3GG8lrZMkICGkeSujH
 tmjQ==
X-Gm-Message-State: AOJu0Ywu89+m4+4iPGbGhtPHWSofDzBr+GwU/iLZRKjjG6FwiRBn8Ai1
 tSq0fqbrMpnDFKBzk2eTbSWFyR8fOqkxWAfzGsE=
X-Google-Smtp-Source: AGHT+IEP1WRJ1eBjbsWkTQj26M2MGBMdBJ8gPlXB3+BRjuVatoNSVIRGglmJTV8Z/i1BR9bV7kJlYaFRNMbRs77ZK4E=
X-Received: by 2002:a05:6820:1503:b0:590:92bd:d3e9 with SMTP id
 ay3-20020a056820150300b0059092bdd3e9mr7541974oob.14.1702456283700; Wed, 13
 Dec 2023 00:31:23 -0800 (PST)
MIME-Version: 1.0
References: <20231127182609.4663-1-stefan_b@posteo.net>
In-Reply-To: <20231127182609.4663-1-stefan_b@posteo.net>
From: Minkyu Kang <promsoft@gmail.com>
Date: Wed, 13 Dec 2023 17:31:12 +0900
Message-ID: <CALrBrZ07WDM89w0vNRM_hcNxyTjBuqsqHLrtqdBOV_mRYszeeg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] arm: s5p4418: fix relocation
To: Stefan Bosch <stefan_b@posteo.net>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi,


2023=EB=85=84 11=EC=9B=94 28=EC=9D=BC (=ED=99=94) 03:46, Stefan Bosch <stef=
an_b@posteo.net>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

>
> Fix relocation of u-boot for s5p4418-SoC. I.e. use __image_copy_start
> instead of _start to calculate the monitor length. Furthermore use an
> adapted version of relocate_vectors for the s5p4418-SoC. Background:
> The header (NSIH) used by the 2nd-bootloader (included at the begin of
> u-boot.bin) is not loaded into RAM. Therefore _start has to be after
> the header and therefore is not equal to __image_copy_start which is
> at the begin of the header.
>
> Changes in v2:
> - Cosmetic: Fix spelling mistake in commit message
>
> Stefan Bosch (2):
>   common: board_f: change calculation of gd->mon_len to fix s5p4418
>     reloc
>   arm: s5p4418: fix relocation of vectors
>
>  arch/arm/cpu/armv7/s5p4418/Makefile   |  3 +++
>  arch/arm/cpu/armv7/s5p4418/relocate.S | 24 ++++++++++++++++++++++++
>  common/board_f.c                      |  2 +-
>  3 files changed, 28 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/cpu/armv7/s5p4418/relocate.S
>
> --
> 2.17.1
>

applied to u-boot-samsung.

Thanks,
Minkyu Kang.
