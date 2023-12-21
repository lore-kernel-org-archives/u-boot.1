Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D322C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 14:48:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD7B1876A5;
	Thu, 21 Dec 2023 15:48:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="OZ9gSr5r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B3E4876C6; Thu, 21 Dec 2023 15:48:46 +0100 (CET)
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com
 [IPv6:2607:f8b0:4864:20::930])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8D538785D
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 15:48:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-7cbeffc600aso275792241.1
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 06:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1703170122; x=1703774922;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z8WO0MKj6esIao9cLsxbQ70e0Ea8TcP+vBTtnkw37qk=;
 b=OZ9gSr5rGZXYjRHKfS5w/4LFpDrjRLCRigcrGSALzooe1XxxYsgFTeuLNhzrGLONcj
 cITQJYLzeJlkdlFD7NzIE/tPx5d/sOkJdk/d2FPN7LHOdkfp2AEcDrT0rdsGkdvmBV/n
 zCGsuCW4cerrBqiFv0bpf0BHg/B0v3d4ZHdhNxOVR1dsq3x1wVLabL1zzoPoUdL/NaJ7
 mQDhuqhSNT9/aFHP5CT1eBnj8b/66pIfVpGNtY7/YC4O5YDNFTOsC6bx5VHE8fT+Zger
 cq3rEusUqoHLMb/3frFc4MLTGcjiJMC6X1RgjKMAGpGLQFdgZm0/9+LbKIukI70hp1pr
 k8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703170122; x=1703774922;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z8WO0MKj6esIao9cLsxbQ70e0Ea8TcP+vBTtnkw37qk=;
 b=bHsN3BJdCpGOr+gMy68ZjyZkBYzJ7DT6mBcv9w2l1msLs+QDU7sz86GB8/ll/1mC+C
 skNPwlF6EJi1C2Irvwz3Cs8DIBLxtap579wxUqTUvvgmz4BmOvy3ts9cByL5lpf2N7V9
 3jZGceKYmRlhpT5iMyrpBAW3+iiGH9NVM+W9Xo26TE5+JsEJs8MgF1LhZMjL2WjB2uA5
 yjj1/hcyVXdoxbZbeynb2L23mHx2cGNArsINdgVVLN1OyIgmItGtd498twaCyLQW1nPh
 t/sofAaRHnEAM36Zia7glTc9GBYIGkSWc9KPobuyzEyWJ3yVqEU/aPH+ZzkOrAgDdHTm
 37NA==
X-Gm-Message-State: AOJu0YzN9nlrJY5uLkTbdDCGu9rhNvNmeEHn/JVfzssl+bvL+2qxDVps
 McESG67vn+qLwkvqnZX4oly0NUXu+CabBk/gh/+XErPoNOunR6+xPYs=
X-Google-Smtp-Source: AGHT+IFbxaq2PHqZY1mybm92TnAmwx6RcDP1GBcwOckbFnO+ytU9ZXPjDiJl/0fh+zrGiGlFct9iPUd2FKgapiVP8u4=
X-Received: by 2002:a05:6122:98d:b0:4b6:ba52:ca7a with SMTP id
 g13-20020a056122098d00b004b6ba52ca7amr953228vkd.6.1703170122640; Thu, 21 Dec
 2023 06:48:42 -0800 (PST)
MIME-Version: 1.0
References: <20231218162618.GI2513409@bill-the-cat>
In-Reply-To: <20231218162618.GI2513409@bill-the-cat>
From: Shantur Rathore <i@shantur.com>
Date: Thu, 21 Dec 2023 14:48:31 +0000
Message-ID: <CABEcMwUrEdD87fG-qf3YFOYgVp7yMdJ+MWaq6iwxMTFTqHRGfg@mail.gmail.com>
Subject: Re: [tom.rini@gmail.com: Fwd: New Defects reported by Coverity Scan
 for Das U-Boot]
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

On Mon, Dec 18, 2023 at 4:26=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> Here's the latest report.
>
> ---------- Forwarded message ---------
> From: <scan-admin@coverity.com>
> Date: Mon, Dec 18, 2023 at 8:42=E2=80=AFAM
> Subject: New Defects reported by Coverity Scan for Das U-Boot
> To: <tom.rini@gmail.com>
>
>
> Hi,
>
> Please find the latest report on new defect(s) introduced to Das
> U-Boot found with Coverity Scan.
>
> 1 new defect(s) introduced to Das U-Boot found with Coverity Scan.
>
>
> New defect(s) Reported-by: Coverity Scan
> Showing 1 of 1 defect(s)
>
>
> ** CID 470930:  Uninitialized variables  (UNINIT)
> /boot/bootmeth_efi.c: 465 in distro_efi_boot()
>
>
> _________________________________________________________________________=
_______________________________
> *** CID 470930:  Uninitialized variables  (UNINIT)
> /boot/bootmeth_efi.c: 465 in distro_efi_boot()
> 459              */
> 460             if (bflow->flags & BOOTFLOWF_USE_BUILTIN_FDT) {
> 461                     log_debug("Booting with built-in fdt\n");
> 462                     snprintf(cmd, sizeof(cmd), "bootefi %lx", kernel)=
;
> 463             } else {
> 464                     log_debug("Booting with external fdt\n");
> >>>     CID 470930:  Uninitialized variables  (UNINIT)
> >>>     Using uninitialized value "fdt" when calling "snprintf". [Note: T=
he source code implementation of the function has been overridden by a buil=
tin model.]
> 465                     snprintf(cmd, sizeof(cmd), "bootefi %lx %lx",
> kernel, fdt);
> 466             }
> 467
> 468             if (run_command(cmd, 0))
> 469                     return log_msg_ret("run", -EINVAL);
> 470
>

The code in question is

if (!bootmeth_uses_network(bflow)) {
  // snip
  if (bflow->flags & ~BOOTFLOWF_USE_BUILTIN_FDT)
    fdt =3D bflow->fdt_addr;
} else {
  // snip
  fdt =3D env_get_hex("fdt_addr_r", 0);
}
//snip
if (bflow->flags & BOOTFLOWF_USE_BUILTIN_FDT) {
  log_debug("Booting with built-in fdt\n");
  snprintf(cmd, sizeof(cmd), "bootefi %lx", kernel);
} else {
  log_debug("Booting with external fdt\n");
  snprintf(cmd, sizeof(cmd), "bootefi %lx %lx", kernel, fdt);
}

I am unsure in which case is fdt uninitialised.
Unless the tool is being thrown off by different version of
bflow->flags & BOOTFLOWF_USE_BUILTIN_FDT
check, I don't see the problem.

Please let me know if you see it.

Kind regards,
Shantur

>
> --
> Tom
