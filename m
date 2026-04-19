Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10735EA71AD
	for <u-boot@archiver.kernel.org>; Sun, 19 Apr 2026 23:23:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23899839D9;
	Mon, 20 Apr 2026 01:23:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FcPGPBBD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41D1883B99; Mon, 20 Apr 2026 01:23:30 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48062836AC
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 01:23:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b9c603ec2dfso313432766b.1
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 16:23:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776641008; cv=none;
 d=google.com; s=arc-20240605;
 b=jCZYS3tTPHNtXQ1njvHc8I6hIBrsgNw6vgx96b6AihvGaesoKudkntLu0eJTQxvJU1
 a4hXH4S+HWwxoKyt/muBvLt+CQS3yqbvl9+9dhFYuRein+Fwz50/jVmBXSQ2NoPGbLii
 57ZlKMswGJ9gzgVoyCDzN9SD93aq+zqs2R0ONDHRDns30Smv2wdaXuGEk2W7DEBSDVCS
 5LuG13hWjD0usuebVVQ3W+ApOFIG5eOt7M6lyEZAK4mq0BuVezCpDXOIOri+t950bn+V
 m7kzkFwE8L0dzmedd2GHAthQ+m7BYeh9nz+iPGIfvDmUa+1tcF4dQfLx5ewPHBrP7aYp
 IJLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=04GUQTFsL0bMlc5Kj/5hBTZ+s4VBYZijHBEK6WNfYVc=;
 fh=u6NliCaUHpdmhtHQ7RN55ZaPuVxM36FJI+H9eXJCyU4=;
 b=RM9J1hNFUrGJMh4Avp+qA10aZg8J+tiJh5xfUwcHFQSpzbKUOd4Lqn1CRi0HyRVFmK
 D1s4k+sx9CkwjMkJAtFvOvFtiYB9lBv2fNsYeofHuvMY8AwfFb6Bz2NQu3nr/2Ib+cVR
 pfj/wtTT7fBzJAXin/1czG7OLnV2U2qoojP/0OQEMGFSSDxgoy/C5wJ662azXwuT2zjd
 hgPqQ1DrciGpMSbbfdhSZbsD7MEmyys7gKVxEwEbYkQWmgcAMxednL8xKrM6VkMUqWYP
 LEh/M7ecJgTWYTfOQYt9lEdcw/HlTM3pFbYGuDC/Mmqg9HRAGU63MqsMMZMI23qgpQXt
 LNiA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776641008; x=1777245808; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=04GUQTFsL0bMlc5Kj/5hBTZ+s4VBYZijHBEK6WNfYVc=;
 b=FcPGPBBD/es2IrXBwl9EaMZLPbB8xZ5JcvC+svFbA2dXOmdbZe5f3laClWTqu7mpYx
 2a65/mLAiuBE1GgNiQMQuKl5T1LZC3IQN1yHfHPSCiiVbU4kKn1ml9ugQaUczq55dxt/
 P3NSjK/MuTPc/P2ZvjmIb43f+ePIjfr42Xxws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776641008; x=1777245808;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=04GUQTFsL0bMlc5Kj/5hBTZ+s4VBYZijHBEK6WNfYVc=;
 b=Nt5Vh3kP8NUNACJVckq1lDfIPz0Lmm3qeKjKWcMSU/CXdId0DwcpbSM8sMr6nT/P3y
 YiO0oDa+jTFqU4c/YVgNW2tukbR+C8uI3rUrgB98/FiO8i41bk0bMJfrS3skqE8eZ39f
 n42jWm9ULcJEe4nJqQjWaH5hpVEirVN/cin9moW+1704Ly6JlAHSf38pRLaJp0DFsiYE
 8dsP/r0CEZTRrqfL5MFDO2IJb0eE//XZyZe4WNLbZW3heEXFoUt0rnMroLd8bytif8CH
 8ncKtWNwAa3wKd0dQZzq1S4RZvzzwPVSnLlfQd5TYGZB8JxpgVbPCC6iztkn8tPWSoB5
 277g==
X-Gm-Message-State: AOJu0Yzkbsv86g8oU5z1CfOqwpIUTDGXCsYkWhCy6PklMlcgWpvujk3h
 3+q+NwACbgti0rnBPw2B0KDL+/ckq9aaeWer6Mfbt0fvycCyFvu6QCGcKuboqrA+OeNGhBcmhfq
 nxs795x4AW7XbhS+Ll2O+CnX1mrVaVp7Fu31aJ4GH
X-Gm-Gg: AeBDietGTiRH56idbgl7jKdrSJdcvMysCdmw4iSCy1ovwowh44JQGLTHGolxqCZoJyG
 hJs/k4Qr28mkkEWEqzZUXz94VtwaT97oV15PuWhqdY9lxnFAEKEz/PGP2aJ7MzJr33UwahRq7mW
 nGUawuPzOVQ7Ism35Kf3g2RjTTxbqAzAK/1nUkz5MitC1sWdv3A+p3qzVs9DHkApw+KVwiNLORI
 7fzsg8IvLUNxBY77LUcPPXuSLuf43Mpe9gWoRnkOcDA9fH2nSQv/AB+Rl8m4w8GPw/pzK6TF5W0
 FOTgRUFUfHPscTzxJmuy
X-Received: by 2002:a17:907:806:b0:b9b:4519:7914 with SMTP id
 a640c23a62f3a-ba41a82618emr500533966b.33.1776641007713; Sun, 19 Apr 2026
 16:23:27 -0700 (PDT)
MIME-Version: 1.0
References: <a1cd73a2-582b-447b-bb3c-e88afcf99545@proton.me>
 <20260224170908.GZ3233182@bill-the-cat>
 <37429ec3-d174-44d3-b113-bf6ce6d71096@proton.me>
 <20260224193312.GB3233182@bill-the-cat>
 <02e49242-da72-4bcd-a428-f7e8c9aee742@proton.me>
 <20260225004838.GA1593142@bill-the-cat>
 <20260225020042.20823-1-krotti83@proton.me>
 <20260225020042.20823-2-krotti83@proton.me>
In-Reply-To: <20260225020042.20823-2-krotti83@proton.me>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 11:23:16 +1200
X-Gm-Features: AQROBzCGyCbLO2CeglxninHLwAQ1jV5JKPojtmwAvhwF7Mhk1KkjPiw6PGfA_TE
Message-ID: <CAFLszTiH0T56YgWhjp6hiXMTswcgu-yp-ivSKS3u4JoPMJDBKA@mail.gmail.com>
Subject: Re: [PATCH 1/1] doc: emulation: qemu-arm: add secure state steps
To: krotti83@proton.me
Cc: u-boot@lists.denx.de, trini@konsulko.com, tuomas.tynkkynen@iki.fi
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

Hi Johannes,

On 2026-02-25T02:01:39, Johannes Krottmayer <krotti83@proton.me> wrote:
> doc: emulation: qemu-arm: add secure state steps
>
> Add build steps for building U-Boot in secure state with
> TF-A and OP-TEE. It includes the full steps for building
> OP-TEE and TF-A to use with U-Boot. Also a short
> description how to invoke QEMU with enabled EL3 and EL2.
> EL3 (machine option secure=on) is required to run TF-A.
>
> Signed-off-by: Johannes Krottmayer <krotti83@proton.me>
> Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
> Cc: Tom Rini <trini@konsulko.com>
>
> doc/board/emulation/qemu-arm.rst | 86 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 82 insertions(+), 4 deletions(-)

> +OT-TEE
> +^^^^^^

Typo: OP-TEE.

> +Building (none-secure)
> +----------------------

I suspect this should be non-secure is the conventional spelling -
same for 'Running U-Boot (none-secure)' below.

> +The following file is at least created with TF-A v2.14.0 and can directly passed
> +with the '-bios' option to QEMU::

can be directly passed

> +If the single file doesn't exists 'bl1.bin' and 'fip.bin' can be concatenated with the

doesn't exist

> +    dd if=bl1.bin of=flash.bin bs=4096 conv=notrunc
> +    dd if=fip.bin of=flash.bin seek=64 bs=4096 conv=notrunc

Where does flash.bin come from?

Regards,
Simon
