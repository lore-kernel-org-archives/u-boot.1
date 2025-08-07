Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971CDC87FCA
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 11:32:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03422844E8;
	Thu,  7 Aug 2025 13:32:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SLZwTZZp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9145844FF; Thu,  7 Aug 2025 13:31:59 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFA3983C46
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 13:31:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-55b7e35a452so969968e87.2
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 04:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754566317; x=1755171117; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9aubrj+zyO1LArpyRhnsYyyW32aiT1C76cm8lTrX6w8=;
 b=SLZwTZZpmbtAOy63ZV5aLX3eyDv17nOT/8cJsh30F3LK/NskSL8sYB9VGbWnoa8Mzh
 TxmSd7GoxRUyox6+Dx+baX7AOgiuKWLSKCaUZkJrNdVRJDBQuC5SezEcQc+Knk46K3Kw
 AJQZt3l+13uQJ74MKASG3YwgGWOZV5DGTlmY64oa3XG0n1ni+Bi8RzmHU2HqhjzPeCdQ
 PD7Pvy/n5B7UcbS82oEKtlGyXNk/vp8TgCX7wBjai35Qo6hS8gZjWB0RSF5VH7r00n6+
 gZqfWN7q2fsrhzIWuSgJ39asVZ8vqCUGxVu8epyIzdpvPESx5vDneadDSo7A7eKAEod1
 IEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754566317; x=1755171117;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9aubrj+zyO1LArpyRhnsYyyW32aiT1C76cm8lTrX6w8=;
 b=lV7iB/ucWyGckgYLiCcCVrDl5+lj/xfS9O+PGvNThBuoxw2+4RTFvOhLkp9NL5+vvk
 RS4sc0EaAVxOWGH0CKv5XabNVSwBYmYjvnit4AsTJDhMa2MwpnFn5NPEhVQkPON3WQyu
 44bqLQL6/cA6B21QXoC+1HcwuWutNlRayasICNKVwwR9z497nDo4lSLG4p++4g8JxdzA
 j3e8ZUyQn0XgxVR21Pl9uzwGH2zQoHJEquQ+HhaqCEcTgxvRaPQqYJ49dKGSPRxciP+q
 oAJQHx8WX5XwxtJtfd5fz/gwtlmCoaIlJ9M07COnfnsxf0dHUx2x/7lixSn/Jo2zY1JE
 Op3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOzYRr4G9XTBROKqmVLR0jwY25OUNdA5r66fhSw5oXEHIT8dfcVcCuG+pAD1VjUqLLNqUl6EI=@lists.denx.de
X-Gm-Message-State: AOJu0YxPEiEJd/xJtmjI2RBR9Y4jOv3S6zLT/5Av2nFIbQ31YfDzWYxO
 ukLh4m99YCaYBnqGVTPZPkdS9cRKhqhJ48/44QC7e8+e08KqUvvrO8VWH8uf/2DAP/w/Wmj75My
 sUnEiVPXPZ/gOD7X0SYQWHFRj1mVkKJw=
X-Gm-Gg: ASbGnctgW8XQgs3n5fiE13F4DtXTy0CIfop0Dulsoq9HWs72VznARZqnWiwQ/aN7jrv
 z+9FuvrxJ9CTeM/l841/q0A+sFt0MX7PuborImdSs1p+HChkLDRpRr6XdmSqdR01pDwFKgFj0s+
 mfiHd/wcq6gqFsW1SET2CicYOqAnyph47jg41Xbi6wW8dA/IH8ZegUn8xCV3bioC3cdSjJWRbEh
 DrkRrWdEvux4SyQu529PJzSsM26lOJJ8zJ6cNynAqm6BjrUEA==
X-Google-Smtp-Source: AGHT+IHT/mZ8pw7UEHEr9XGMFal0be6hOr5IQgcylx0j9Xb7INBZxJ+agBQ5iS09KGzmj2OG0ua1HOxl0NOZsxCq9g4=
X-Received: by 2002:a05:6512:32c7:b0:55b:941d:bde3 with SMTP id
 2adb3069b0e04-55cb673adbdmr732817e87.10.1754566316760; Thu, 07 Aug 2025
 04:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250728-imx95b0-v1-0-5cdae3764d21@oss.nxp.com>
 <20250728-imx95b0-v1-2-5cdae3764d21@oss.nxp.com>
In-Reply-To: <20250728-imx95b0-v1-2-5cdae3764d21@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 7 Aug 2025 08:31:45 -0300
X-Gm-Features: Ac12FXzrm22YYTbfBbEA0v2i7FUbJjKWk2FT6YGZ9r7wjqzEpQIDgThu6T_BFtY
Message-ID: <CAOMZO5ATbHrjceR4cXQEmvzFgXL8+V6gc_DaTs_BcZi89tZypg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] imx95_evk: Restore support for i.MX95 A0 silicon
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>, Tim Harvey <tharvey@gateworks.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Stefano Babic <sbabic@nabladev.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 u-boot@lists.denx.de
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

Hi Alice,

On Wed, Aug 6, 2025 at 9:40=E2=80=AFAM Alice Guo (OSS) <alice.guo@oss.nxp.c=
om> wrote:
>
> From: Alice Guo <alice.guo@nxp.com>
>
> This patch is used to restore support for i.MX95 A0 silicon. To avoid
> duplicating defconfig, imx95.config is added and can be shared between
> imx95_a0_19x19_evk_defconfig and imx95_19x19_evk_defconfig.
>
> container.cfg and imximage.cfg are used to created .cfgout files that
> are be passed to mkimage with -n to build flash.bin. Now they have been
> deleted and replaced by adding their content to the property cfg-content
> of node which type is nxp-config under binman node.
>
> Fixes: 9936724aa9b ("imx95_evk: Add i.MX95 B0 support")
>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
>  arch/arm/dts/imx95-u-boot.dtsi            |  48 ++++++++++
>  arch/arm/mach-imx/Makefile                |   5 +
>  arch/arm/mach-imx/imx9/Kconfig            |   5 +-
>  arch/arm/mach-imx/imx9/scmi/container.cfg |  11 ---
>  arch/arm/mach-imx/imx9/scmi/imximage.cfg  |  16 ----
>  configs/imx95.config                      | 150 ++++++++++++++++++++++++=
+++++

In v3, please call it configs/imx95_evk.config

Thanks
