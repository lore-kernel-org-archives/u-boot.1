Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C4C5EF48E6
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 08:45:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2024B83015;
	Fri, 13 Feb 2026 09:45:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RqVszJ4d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52E2283AA9; Fri, 13 Feb 2026 09:44:59 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2B0580FA1
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 09:44:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d1959ba05cso264917a34.2
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 00:44:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770972295; cv=none;
 d=google.com; s=arc-20240605;
 b=BVZGUFu5Lnzi62P/lqQglcCUSFfJZJ/PkgZ8Bm5M/K8MNnEq/Ssh6c6Ow2NVj9mY9b
 kH3lpJ42+//eYDO8X9Bqf7QY1s3a0Ivj9AkoDAezmiJgXECpYMncIyQ7Pb4/vpRHQOqr
 1v81lrMuHxGetBUGQ3lAYFO4yj7MoVuTp3J1nT8A4yvOyyjl9HxuFNJ6R3JIe29BrJvv
 VSlvEhFBLt8ku+w5nXUMd/jq8jg6HJXxGRa6BOlDldwJK2gb7uzVE6rM2IamLQg87Jz7
 IQzgnwuO+wa2S3N6szxYM0FEi0E3KTtlchNXrB+fS+Vbxjj/VGXNK1QSygCZhOvx1uvv
 kH3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mezlfNvXgddQvnF8PVNgE71GoudjrPrM30jW/dmESWQ=;
 fh=eEi8Xo/lKegsBCPHHmDPcf4jaXl0OXhlbgpBC2bs1Eg=;
 b=ZfcHbmuimMFuSf5vwI1lLIVSVf3Fx5/SvT+hWkri8S0otXnWjJKrKCspUzEhBuv6Ik
 KdYywGvBFLXb+n8t2BjUoKrJjoPMChVjxgbWQe2XbX9XKwi2Y3KwOiyUHt8teS2l0X6d
 E+uCdiJxR3AQx/+3LBB6wA7mhUYlAphzw1UsrpzLA4I9W7rEwo5vs5UVri1XlIMklFfw
 SWle0gltZuqE9O/W1bZNHKwNq2qGiUAdNd+Amrc6Iua65UyQ2JXhqqkxSckThP/DDGBF
 ntWqOzDdFFgoI9piCC9RuLILEn6h3eNpg/glTPYL2Qq0l6RuDv+19iONg2smADM8/bWu
 plqQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770972295; x=1771577095; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mezlfNvXgddQvnF8PVNgE71GoudjrPrM30jW/dmESWQ=;
 b=RqVszJ4dfoXmRTGUYFDs1/ZLqa5fGcRXePrBHP7eLHnDKHrXXpI4FgiMtaFeiiANjl
 9lEg4pE5j74bLskuT7wTuvaNdhcbBVrcQ0ZC/bLR4/9hn9EFDuz1dqxFFXXRjgGJvXPu
 X8zDMMbTI/Q+2kNS3FAjFCqOgqr+2VYjE4Hgr9JVsdxpSPR14Vc2WTd09npagW7OHMh4
 Q/uGYVB7IGXS8VDb0bE7ejUqPW9uYPZIt2c2tZohjItshh8/iuxJB/dVzvxvSq/mdMp7
 HfggS3VXJMpmafxenixWl6AVdFDizuJ2K0XbHgmbLxaU2W9Fdg9cfGyBTtCKHoTW4+dn
 5uHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770972295; x=1771577095;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mezlfNvXgddQvnF8PVNgE71GoudjrPrM30jW/dmESWQ=;
 b=uXKt6OYEy6NGOoy0/ZuzxHFRXwq5+AzNLeXPI1hABXsefuqvvloi39ZNy42DZqAzuW
 z7cG7OL54GlSkddEPMtYYRKsjJeCkt6/txS4HDr4Ga8T2jhF/M+xm+OPAZfioMBE0wuc
 NPXwe51ryfYCYpzzA3w9S3sr86qqFOmv3Gfait4YRXKWFDwhCtx/CBBVokV90oBM2bkb
 XU2kfli4Echk8O2cAXfSA/XxGOM3V4q8mG+oNwxBL4pLCNocetI0I/d1h4HbTiRLYL7k
 iHrxHU9egCx3nks+hlWb1VpPiFYWjblfGrHZfCM54l0/kGbzYT7xtLq9hKGoRrSKcVL1
 rVAg==
X-Gm-Message-State: AOJu0YzH7X4sGzKc2xM9K1zw9IMB16tuLEKjyojUliHDYv/8jb127+Mr
 pnk2g98SYuwCksA4dsVLN5LVdvzsey/V/+UKiKeN4phM+VcIxkhuS8KSfoMtuPKXCSrrHkKdCLV
 uV+UUW74GKXfuzJRYHKstGB8ruFb367A=
X-Gm-Gg: AZuq6aKjxFXgw69iM+3Ib3AVz+KWoHUAOZjhThbQo5xWN3uyT8vMeNkfmyuyzQ4MZqx
 edkQMfdzVVSF0jZHNi1zfQ4qqtAaZU29riXx+4ZtX/3ZzeiMVpdbDmvSw/aZ6HXVAtusBLTzCC0
 euq6IsYSbFASpampK9nyALlwRX6/GwTJhRwbCJo6U2JsjZxj2B3K7WiLBZVDEZ0eX/jtJUnsGg+
 T0vl5VtELYqDhBhdLle6MhWmFaA8kKYZqp0VXG7jcY8rz+hifEhVy2qyC+kmVxh6u/PWnzVgcdW
 9oqzwoom
X-Received: by 2002:a05:6830:6314:b0:7b0:826e:4002 with SMTP id
 46e09a7af769-7d4c4ac919amr646579a34.20.1770972294999; Fri, 13 Feb 2026
 00:44:54 -0800 (PST)
MIME-Version: 1.0
References: <CAN7C2SC4GTf004JyBeeVtnBPo=BvqorCy87ZFTNV4RkWFOJKbA@mail.gmail.com>
 <b25f6c14-7db2-4517-a3ab-e2c55a52818c@altera.com>
In-Reply-To: <b25f6c14-7db2-4517-a3ab-e2c55a52818c@altera.com>
From: Sune Brian <briansune@gmail.com>
Date: Fri, 13 Feb 2026 16:44:44 +0800
X-Gm-Features: AZwV_Qi0XbDHkFmXV53_deXez0oqCCyc1JktPXNanQPE-krQd29VNJmEhf33DFc
Message-ID: <CAN7C2SCC9L30S2BNYUzRE1jRJeQ2H1d6fq_Hgsu7uPge_QgsYw@mail.gmail.com>
Subject: Re: [PATCH v1] arm: socfpga: Add call to
 socfpga_sdram_apply_static_cfg()
To: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
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

On Fri, Feb 13, 2026 at 3:18=E2=80=AFPM Yuslaimi, Alif Zakuan
<alif.zakuan.yuslaimi@altera.com> wrote:
>
> Hi Brian,
>
> On 6/2/2026 11:09 pm, Sune Brian wrote:
> > [CAUTION: This email is from outside your organization. Unless you trus=
t the sender, do not click on links or open attachments as it may be a frau=
dulent email attempting to steal your information and/or compromise your co=
mputer.]
> >
> > Hi Alif,
> >
> > Since 2025.05 to the latest master.
> > I do not have any issue as you mentioned in this patch.
> > Both RD/WR are used on the FPGA2SDRAM SDRAM2FPGA.
> > I tested 256 AXI3 or split 128 AXI3 x2 which is the maximum
> > that GEN5 Cyclone can support.
> >
> > Not too sure what is missing from first place?
> >
> > Thanks,
> > Brian
>
> Based on the CycloneV address map which can be found here -
> https://www.intel.com/content/www/us/en/programmable/hps/cyclone-v/hps.ht=
ml#sfo1411577374877.html.
>
> Bit 3 of staticcfg register has to be set to apply all the settings
> loaded in SDR registers to the memory interface, in this case the patch
> ensures the SDRAM controller applies the latest configuration after
> disabling FPGA SDRAM access.
>
> This is a safety and correctness fix for re-initializing the memory
> controller in the proper sequence during FPGA reconfiguration.
>

Hi Alif,

Before I plan to undergo a test we got to understand why w/o this patch
SDRAM2FPGA works properly w/o issue.

> If you have the time, can you help to test this patch with your setup?
> Although unlikely, we want to be sure that this patch will not break any
> existing GEN5 boards out there.

I might be wrong, I think static cfg has been done already?
Does the code here if not wrongly understood already finished that static c=
fg?

---> Quote start
void socfpga_sdram_apply_static_cfg(void)
{
const u32 applymask =3D 0x8;
u32 val =3D readl(&sdr_ctrl->static_cfg) | applymask;

/*
* SDRAM staticcfg register specific:
* When applying the register setting, the CPU must not access
* SDRAM. Luckily for us, we can use i-cache here to help us
* circumvent the SDRAM access issue. The idea is to make sure
* that the code is in one full i-cache line by branching past
* it and back. Once it is in the i-cache, we execute the core
* of the code and apply the register settings.
*
* The code below uses 7 instructions, while the Cortex-A9 has
* 32-byte cachelines, thus the limit is 8 instructions total.
*/
asm volatile(".align 5 \n"
     " b 2f \n"
     "1: str %0, [%1] \n"
     " dsb \n"
     " isb \n"
     " b 3f \n"
     "2: b 1b \n"
     "3: nop \n"
    : : "r"(val), "r"(&sdr_ctrl->static_cfg) : "memory", "cc");
}
Quote end<---

Thanks,
Brian

>
> Thanks,
> Alif
>
>
>
