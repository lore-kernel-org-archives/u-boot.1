Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC2BD29FB8
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 08:43:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F0D088F20;
	Wed,  6 Nov 2024 09:43:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="GMp3aFrZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEDDC88F20; Wed,  6 Nov 2024 09:43:23 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 834C688D09
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 09:43:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6cbe3e99680so34628756d6.3
 for <u-boot@lists.denx.de>; Wed, 06 Nov 2024 00:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1730882600; x=1731487400;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cljDrPjnrruh7nj+BGn+P59WpeBROa2gwg4IX7uhahM=;
 b=GMp3aFrZG2umIJEJvSLGc8dw/WxP1eNsuv8Zb+YhvFx4f/vxgGIZtye4ZLSjBDKcIT
 g5828YT5MUUDOIshz56PWpfaMK5xG4F7I7D0k52gaIhQ8iCBUJ1KkDtu23PqjZpO8Q02
 1PAvYcfje5qFoc3Vhp+D15ObzRHIL3a0CI7rcJsdLfikPWuIaqnWJD29QO2SkevGEprf
 eqZyBiV4xZDdqXjIcr8XwLmdJ0gefg4zWoNIR+ZbXm9afxresmgRIGqKtuiwJ1DXTHYM
 eBvG1/Ht3og7/GQHrEkjtwhVVKQmKQP4YfDlKwy8oDNjE9pvMqH93owL8LPtWMCzy5LJ
 xcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730882600; x=1731487400;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cljDrPjnrruh7nj+BGn+P59WpeBROa2gwg4IX7uhahM=;
 b=tXJpGaWt90HDo5SbFhXRbB6wZFlbeTa/1o4asZUDnqHJqi3+UeDjzN0YIivavhjLM5
 T4ToyUKLFt+9ZQHjomWMu4DonEk5GTZuNKwaggyc1GgXr7eaSW29zfrSqDIJD/PQ0Ns3
 Xu/5F+eLa0juV9v0j0JM/+dqAd90la2y45KxfFTeM4ARX9dc38x2au0pqCUmnZhveUvQ
 7W/TTGCoJXqMRNUcQQB828mhXCJDAwDU2btRl+nhICgryIHOLNGcNpq23lbA10HYnlS5
 M0j7Dkve8ZEXrUTyzmP4y8h65pA6aidUQYGMflanuvShq6Z4HEIJX6jvSiACYnGR8PD0
 kDLg==
X-Gm-Message-State: AOJu0YwYSkiXSIGwlFC3Jh335PVPHVvizA+uJO6El+mM2ke8S1tj5qmh
 trmFJbPAsT+RaAqBf+/2wIvXl/T+L7gnKFFXoySB6JitKlXqGEMvErjRvzNNnOUSpcy0bTRpBzW
 j2bSCQpV8pR+AoaMzOshzprgpdqBEIys0715b
X-Google-Smtp-Source: AGHT+IHJhOnTuWzI6CPeCLamQHa56kfSj5pZvyhDUhwUw/J+HhCUxxC7/Y/hQgSQ8vRLCgoRNHCHDEoWX6fDR//jvNw=
X-Received: by 2002:a05:6214:2f81:b0:6cb:c9bc:1a23 with SMTP id
 6a1803df08f44-6d1856ea81dmr464885246d6.24.1730882600308; Wed, 06 Nov 2024
 00:43:20 -0800 (PST)
MIME-Version: 1.0
References: <8c1a5d6148c5e6c46790b725e8148a4e12d393ba.1729857366.git.michal.simek@amd.com>
In-Reply-To: <8c1a5d6148c5e6c46790b725e8148a4e12d393ba.1729857366.git.michal.simek@amd.com>
From: Michal Simek <monstr@monstr.eu>
Date: Wed, 6 Nov 2024 09:43:09 +0100
Message-ID: <CAHTX3d+pJzAAKjkHtfTXz1un9wzBreHS=tdnGqkxdruaBUVyTQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: versal: Do not define do_reset() if sysreset
 is enabled
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, Tom Rini <trini@konsulko.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
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

p=C3=A1 25. 10. 2024 v 13:56 odes=C3=ADlatel Michal Simek <michal.simek@amd=
.com> napsal:
>
> If sysreset is enabled reset_cpu is defined in sysreset uclass that's why
> it can't be in platform/board code.
> The same change was done by commit f1bc214b0024 ("arm64: zynqmp: Do not
> define do_reset() if sysreset is enabled").
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
>  board/xilinx/versal/board.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
> index 39474674cca2..27c1cfc6558a 100644
> --- a/board/xilinx/versal/board.c
> +++ b/board/xilinx/versal/board.c
> @@ -301,9 +301,11 @@ int dram_init(void)
>         return 0;
>  }
>
> +#if !CONFIG_IS_ENABLED(SYSRESET)
>  void reset_cpu(void)
>  {
>  }
> +#endif
>
>  #if defined(CONFIG_ENV_IS_NOWHERE)
>  enum env_location env_get_location(enum env_operation op, int prio)
> --
> 2.43.0
>

Applied.
M

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
