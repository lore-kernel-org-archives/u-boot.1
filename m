Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A40C48297
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 18:28:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB1AA87E7B;
	Fri,  9 Feb 2024 19:28:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jYrBc62k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 194E887E70; Fri,  9 Feb 2024 19:28:00 +0100 (CET)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDD4087E7B
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 19:27:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mr.bossman075@gmail.com
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6e09143c7bdso602098b3a.3
 for <u-boot@lists.denx.de>; Fri, 09 Feb 2024 10:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707503273; x=1708108073; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ew1LfcWec84eStzxOS40oAGEqVyBKpDahcrhU8PvNQM=;
 b=jYrBc62ks2J4ByrCWdjmqR/8zCGQ7pyzLWkdRocPE25/gDRwRDh8CciZ0d5g9aY+G7
 K9jv9bTO7hQ7xK4kZ3aekOAWr1rgqkQgJys4t1zQ9fYnE2Chx4SmrhIOxDo1EL7CqDqj
 +gFDQ1z41RTvVMqBYwTd79jb28/exRfN4UBPPgKDryZQcGj/W+ZQrffebTAEHpBVmGVc
 d/e9WYIDpVgVehCmez02N8jbnE3kAcTEqALu/FTJBuw/MjtplJH2PLHT5YsQhiyMVAPl
 QkOF315Zgxzaq8j/kuuhTMusuBezYc75iZhGrkF/FPUgyrFQI8M2+R4d0AbuVwpHMP2x
 qS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707503273; x=1708108073;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ew1LfcWec84eStzxOS40oAGEqVyBKpDahcrhU8PvNQM=;
 b=M+sHZgx8eAo/UcodpqG6D/lvMF/1+1fexwzwHxihwDcWhFTq3+wuf+cKDkuGgIcic2
 LxioH5zGp0vvRMVPO6D6/iAHMadlz6twXuaTvUC38IAgMzOWsVJBECfyQR6JDncw2PZR
 ejh6hLi9DaDaP82tteseLNo5v58d6i1+uVUZQyN3VO2USc7F/eNNH6Ut6w3e3YKc4EbP
 SCkk61EpWG0EyZL7xNltJTyP4w6nXE9M5wpJuNkBPJQXNzsi6c6eAXG1Lm6cIAL6t5FT
 IP9WPU5z3Prg4DM5e+YpWX/xYsAwoU383z5E5unZY3HKXyYC/8kb6tTii1J6yS6Jemsm
 3WEQ==
X-Gm-Message-State: AOJu0YzKhd2Cc7vIcXQdeurSRtsRG20wS9k3eArgGXLSUy74dME0s6Id
 SoF++VBQBWPIiCuHxLhB8qmEYeesvVOpBtTBgV7b/3r8FqvDujRqH2GSZxU6JKsZBtQFagReXIW
 7l3sobvr5LaWb5DHKUgYKPUfMSZg=
X-Google-Smtp-Source: AGHT+IERKYtUAPhvgzD/R40cyahK7nPc3AhPK4kh3rZTgLzZev+xDYzHYzXj52Co/QokCniFwi9eh1jwiA14upBtHbA=
X-Received: by 2002:a05:6a20:9e48:b0:19e:a353:81b0 with SMTP id
 mt8-20020a056a209e4800b0019ea35381b0mr2988372pzb.11.1707503273555; Fri, 09
 Feb 2024 10:27:53 -0800 (PST)
MIME-Version: 1.0
References: <20240206164008.1620933-1-Mr.Bossman075@gmail.com>
 <CAOMZO5CHMYZ5LFz9xCukrZ_BeF-Knt=Pbe9Qs7wrOnr0-ZSP_A@mail.gmail.com>
In-Reply-To: <CAOMZO5CHMYZ5LFz9xCukrZ_BeF-Knt=Pbe9Qs7wrOnr0-ZSP_A@mail.gmail.com>
From: Jesse T <mr.bossman075@gmail.com>
Date: Fri, 9 Feb 2024 13:27:17 -0500
Message-ID: <CAJFTR8Q_D361vUu5vQ1zHjwG0A6V+9zKj_w5P-x9LFqVch+QsQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] imx: imxrt1050-evk: Add support for SPI flash
 booting
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, 
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Stefano Babic <sbabic@denx.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
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

On Thu, Feb 8, 2024 at 8:08=E2=80=AFAM Fabio Estevam <festevam@gmail.com> w=
rote:
>
> Hi Jesse,
>
> On Tue, Feb 6, 2024 at 1:40=E2=80=AFPM Jesse Taube <mr.bossman075@gmail.c=
om> wrote:
> >
> > Add support for booting the imxrt1050-evk from spi.
> > Add imximage config and the ability for SPL to boot from NOR.
> >
> > Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
>
> This causes the following build failure when building imxrt1020-evk_defco=
nfig:

These errors also happen on master.
I will submit a patch to fix these soon.

>
> arm: + imxrt1020-evk
> 1221+binman: Device tree 'u-boot.dtb' does not have a 'binman' node
> 1222+make[1]: *** [Makefile:1125: .binman_stamp] Error 1
> 1223+make: *** [Makefile:177: sub-make] Error 2
> 1224w+arch/arm/dts/imxrt1170-evk.dtb: Warning (reg_format):
> /memory/ocram@20240000:reg: property has invalid length (8 bytes)
> (#address-cells =3D=3D 2, #size-cells =3D=3D 1)
> 1225w+arch/arm/dts/imxrt1170-evk.dtb: Warning (reg_format):
> /memory/sdram@80000000:reg: property has invalid length (8 bytes)
> (#address-cells =3D=3D 2, #size-cells =3D=3D 1)
> 1226w+arch/arm/dts/imxrt1170-evk.dtb: Warning
> (avoid_default_addr_size): /memory/ocram@20240000: Relying on default
> #address-cells value
> 1227w+arch/arm/dts/imxrt1170-evk.dtb: Warning
> (avoid_default_addr_size): /memory/ocram@20240000: Relying on default
> #size-cells value
> 1228w+arch/arm/dts/imxrt1170-evk.dtb: Warning
> (avoid_default_addr_size): /memory/sdram@80000000: Relying on default
> #address-cells value
> 1229w+arch/arm/dts/imxrt1170-evk.dtb: Warning
> (avoid_default_addr_size): /memory/sdram@80000000: Relying on default
> #size-cells value
> 1230 arm: w+ topic_miamiplus
>
> Please fix and resend.
>
> Also, there was a whitespace warning when applying this series.

I don't get any when applying to master(a4650bf65e)
>
> Please make sure to run checkpatch on the patches.

I did....

Thanks,
Jesse Taube
