Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D97C4828F
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 14:12:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E99387DFC;
	Thu,  8 Feb 2024 15:12:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TJOBKisJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E8C787E45; Thu,  8 Feb 2024 15:12:53 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9621687CED
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 15:12:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40fe59b22dbso14719645e9.3
 for <u-boot@lists.denx.de>; Thu, 08 Feb 2024 06:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707401564; x=1708006364;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FPW1bIv/ylbR7Cw+5sNT64Vk9P8FTXuIQE+/7GVOhfU=;
 b=TJOBKisJW59z76jAk6hPIMQoOSAwEFDRAg0bxk+Bl1uOtLFERRslPlvu4s13n5cqbp
 O0rV95O65E1kIov+qwqtcgAHyL4GymP3kw3Rpf+oRI5A/ASv+Y0z2rgEY4IZdsheyjFH
 9Z/j6lPEyLn2daWjvbhpJF33Nb1RID52UISFdlGYUQ6wKlbMMycUwt7GlA7rOeZLgMv8
 9o+w3EGsensi2p/tDINi06HJM9LyTOnQ/a1SY+RQBx2Jf/aGpOtpslZOasBERJ4t3vuA
 V9CfcHVKmuH0Tb6Q5iWJ1bmoXllMMm/cFw4Lh73lZf4url0UGwD/3rLRPpklDzdD/INY
 i6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707401564; x=1708006364;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FPW1bIv/ylbR7Cw+5sNT64Vk9P8FTXuIQE+/7GVOhfU=;
 b=aJX15YbErzqryDgvAFA+rThO3EuDfFNJuT0cyJ6fDNilH80cbt7QAs+aKIHKHinXav
 Z3RM4Lv5diiubaE5Nf+49vPVSaFDhhaS9loYYOg952ea6n68wSnHInWTxTnvAiLyAGDt
 Ip6UA8sfWs79rqaxCvJoUPUMxhnH2stOmdE2BdfZg0UBi8YX4dl7WDA9PEPcI4L4g/6o
 WBnfpRAstvoZQeHkvNOidtzOsjsyPCXlygbpG1mA6jEN+C7Vb9k1jhsKrgkuVKkhGxzE
 edHrbUZeo/6rZAfZpIBSudrQdVet0JXGEUGvJtH2X2aDjbIj49+3y/zU0/8juQK7xYHw
 uOEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvR9EV4Ha2j1rskoo7rzrIHqw1ZruwEMfcjWdU/BFLJwepa2nYe3lhqeUi9vAa+Ep4SgEiuH8mpyPqOsWIvX6x/fVAZQ==
X-Gm-Message-State: AOJu0YwsLJuI5EvaBQXniD55y+0AaFakXQS0kUMKGE2L3E9O4ZNnR/fI
 3pYEYm90aiNtButEBAKF9BLwb6F7ebEmmqCodR2xvmBS+fuv8qFBTi/Ax4VnI+E=
X-Google-Smtp-Source: AGHT+IEu1qe3dcrC6bMM4bLIHSiu15d7EvVzmVMQ/zXyWLsHMriH3z+8t03iFFTeM2hMWNMH3AzwNA==
X-Received: by 2002:a05:600c:4f05:b0:40f:4e0a:4ead with SMTP id
 l5-20020a05600c4f0500b0040f4e0a4eadmr6858665wmq.26.1707401563976; 
 Thu, 08 Feb 2024 06:12:43 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCX38YmqAfUJXrOZ0kv11Lzm/Kfa7BuqRJtQbiXlUZZygF1sX/KkseNXOj8hMxh3TNMNFJ+vIgfyFEyjG8LdunpGobdPyTXDgB7hsDs3jmx8g9F6qL/t44WA
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 q13-20020a5d61cd000000b0033b4341eb78sm3683617wrv.1.2024.02.08.06.12.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Feb 2024 06:12:43 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@foundries.io>, u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1 7/7] doc: android: avb: add slot_suffix param details
In-Reply-To: <20240206223153.3060433-8-igor.opaniuk@foundries.io>
References: <20240206223153.3060433-1-igor.opaniuk@foundries.io>
 <20240206223153.3060433-8-igor.opaniuk@foundries.io>
Date: Thu, 08 Feb 2024 15:12:42 +0100
Message-ID: <87zfwbhwo5.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Igor,

Thank you for the patch.

On mar., f=C3=A9vr. 06, 2024 at 23:31, Igor Opaniuk <igor.opaniuk@foundries=
.io> wrote:

> From: Igor Opaniuk <igor.opaniuk@gmail.com>
>
> Add info about slot_suffix param for avb verify.
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
> ---
>
>  doc/android/avb2.rst | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/doc/android/avb2.rst b/doc/android/avb2.rst
> index a072119574f..c0b2bedb831 100644
> --- a/doc/android/avb2.rst
> +++ b/doc/android/avb2.rst
> @@ -39,15 +39,17 @@ Provides CLI interface to invoke AVB 2.0 verification=
 + misc. commands for
>  different testing purposes::
>=20=20
>      avb init <dev> - initialize avb 2.0 for <dev>
> -    avb verify - run verification process using hash data from vbmeta st=
ructure
> +    avb verify [slot_suffix] - run verification process using hash data
> +        from vbmeta structure. Provide [slot_suffix] if vbmeta partition
> +        is slotted

Any particular reason for this to not be exactly the wording as in cmd/avb.=
c?

	"avb verify [slot_suffix] - run verification process using hash data\n"
	"    from vbmeta structure\n"
	"    [slot_suffix] - _a, _b, etc (if vbmeta partition is slotted)\n"

It looks good, but I think it would be better if both are the same for
consistency, since both texts are user facing.

>      avb read_rb <num> - read rollback index at location <num>
>      avb write_rb <num> <rb> - write rollback index <rb> to <num>
>      avb is_unlocked - returns unlock status of the device
>      avb get_uuid <partname> - read and print uuid of partition <partname>
>      avb read_part <partname> <offset> <num> <addr> - read <num> bytes fr=
om
> -    partition <partname> to buffer <addr>
> +        partition <partname> to buffer <addr>
>      avb write_part <partname> <offset> <num> <addr> - write <num> bytes =
to
> -    <partname> by <offset> using data from <addr>
> +        <partname> by <offset> using data from <addr>
>=20=20
>  Partitions tampering (example)
>  ------------------------------
> --=20
> 2.34.1
