Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E06CD37AC
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 00:41:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 045418341A;
	Thu, 14 May 2026 02:41:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="o2If2hNx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97C188341A; Thu, 14 May 2026 02:41:07 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40BA1800AE
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 02:41:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7dbe07d3ec3so3905887a34.0
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 17:41:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778719264; cv=none;
 d=google.com; s=arc-20240605;
 b=Yl29o6Y8863LQXPrxxJS1Jq6H+qOb2vn8hMIxzoe8344etHbKarFSBiSmR0lk0C2WG
 iQ9SXz7E0mWVTTzhrxIUn73iq5zC2UfbbVWDhLWtJw9N/PSrM5/xu/sX7woPzQaqxkfI
 pF/8Qq5bEiLWjWYmJzbdxmTzLZbFN6u8BbRXwfMJFLODjGXdP/Kg07hPZvBOUfqd7i7f
 4pwVwqkpQh3mUWuYSgcJCPZbFSlNlc5JBsaWAwKuBt+FAebloep+X4RBasx43tE3GOQZ
 W4dbnAfZwjktLbE1obwPIkjcCScfiMohbq1yZDVI2CUTMdxyBgKlYyF3ReL5pj5B5xU+
 Q2qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mWW82G0jL7qPFUy34+zIIOQwUwVAytKgIQE4UzXVUTs=;
 fh=gY8vf0MZ/WI6+etoEbv8Sy0jtSRnd/4dp1m+lysTAZo=;
 b=lnrOkearHMpDWAzXeFDIUkjBZ4Hxoc/enWyLJzOjMFygeqPZFATlgDShia51rXiNJl
 zgUS8Am0Hj34TpuVFuLCRucNZFNR/6dsSmnRHTw+wBp0hXAOErzXB1Big66OOBrRhVnc
 hWIIL1cQse5W+0EDf4vXsN0/bLW+0+N3wgVY0FHaRZ/kg4JMFFqspvcBID32UAONLzym
 1LFbCLPwZcKd56OCvc63x/535055ubPB9XGt+L1YTQdVmVex9chIDjv3XT4RQg2luP0z
 LaHmup5n8BVIWgVRVGkUehpJlGHJh4iIQNzB/BrZh506Ph6FKanyl3RdFDyrw7sDvNK/
 P31A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778719264; x=1779324064; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mWW82G0jL7qPFUy34+zIIOQwUwVAytKgIQE4UzXVUTs=;
 b=o2If2hNxL9Mvtc5dFngulRASp0KUxdhhcBrOMd92/8rEq/qZXR2XonVuvJWEhX8QIZ
 tD5f5/RrTRv5OVU7l04iM9v2lodTFwxKmGz/blk9qBhWJTIrvqGk1/DxSc943Wo8Iic6
 VeC/t9gQE/cXIT/wTskw+3MtZMlpJqmt6jVx9OHitCk2/wwbtkPUvTwWa3rUr7AKPP4Y
 buGlpnHN1Rv78IGfSiPNqbINBRZEvyQGHbbry3ROb3i0CN3USZ2eAPXzCcEysJPzAefJ
 1ZokafKfHFtIus2QnCDSJjmZWaeJrJXMssm6B1zdxGxE837lZxUSowCr8j/dEUPHp1cp
 bzpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778719264; x=1779324064;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mWW82G0jL7qPFUy34+zIIOQwUwVAytKgIQE4UzXVUTs=;
 b=c/Scnr13xBYhGokKcBfvRkMOVypeOYDhX/M0eJg4sptDdbMd+AOb5gcBMNLaGLNmUe
 ZIpTU+70hTQBJ0WSC8xe2JYieCby4tmDv/kCiMUUspAbHGpPDBxDssZtJsrlnH78Qz65
 pebVJpaKyjJbMol1tvVaa7RrAN6N9a0ytBh7DdqAbLLcxxME5emX3FPCVinZ015BL+kg
 I5S5XfhM58wWVn1XbXRfZ+6qQlRYS9TZiEgyVGdB/pt4vbNoYqaRgTh9LKHp9W8N1Fhc
 Vshogno0Tmby6nPEwtHFjxL2p/B3zsgSVR1ZaGYdjbsHv2JodVs/kfUNRntdnzeBsEb4
 sQLw==
X-Gm-Message-State: AOJu0YzLX7e81qy2Img6bO3DDtZoi33NmNjs4GTp/T8hHjAJErgO/LeD
 jo876xuYLd92nbZ4vpOlNI/Qt6xrT3dCS9O4v9MZOy/47el+YIDvAEUaXucpp2gHPhPxtcFzglK
 VN63fNr9Gdj3953NCQ4tv5FTB/IPAl3M=
X-Gm-Gg: Acq92OFqyiVZsp653pl4yZtwDFDh9d7HOGxDQcLYbvNkqLajIl+Bu8Ne0HsM8C80sbj
 3N6JaMw2CqRHx7KeqxM205o56JnfAhxGKlg0HoEU8eYfVhKB1S2t8QUhreVpFFhZUQpTV4t/GD6
 Qq7LPFuf1IDRdCQCXvhGB0wjXgoBeRTgvzJUEYQ26fbNGEqPb1G7XVxR3hhfa9NLaHhBysfAr1W
 PqxDGbrQxOvnpaG01ngNdK7QLF1NY/m2tnAfg5gdftQQ0at2PofFy2TDRkYG5BCTjdZu6gjgk2r
 RIKZJUAy2nTrxUlwSxg=
X-Received: by 2002:a05:6830:f95:b0:7dc:c620:aa12 with SMTP id
 46e09a7af769-7e3da4f794dmr3495035a34.20.1778719263907; Wed, 13 May 2026
 17:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260512064957.32497-1-alif.zakuan.yuslaimi@altera.com>
 <20260512064957.32497-2-alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <20260512064957.32497-2-alif.zakuan.yuslaimi@altera.com>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 14 May 2026 08:40:53 +0800
X-Gm-Features: AVHnY4Kc647DeTWFii3_5JdOxH_Mh0SjyzGZ8YjFjX9EbMX5qzDmO8ie84Aa9ic
Message-ID: <CAN7C2SDCM0rvnumHC7yK1JJcMmtk1AN3qYOcKs+7J6ZAwDJwtA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] arm: socfpga: Consolidate dram_bank_mmu_setup()
To: alif.zakuan.yuslaimi@altera.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On Tue, May 12, 2026 at 2:50=E2=80=AFPM <alif.zakuan.yuslaimi@altera.com> w=
rote:
>
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> Relocate the dram_bank_mmu_setup() implementation from misc_arria10.c to
> the common socfpga misc.c and update the function to correctly handle bot=
h
> pre-relocation and post-relocation cases for DRAM cache enabling for
> consistent MMU/dcache setup across Arria10 and CycloneV platforms.
>
> These changes help to improve maintainability and consistency of DRAM
> initialization as well as MMU configuration for Arria10 and CycloneV
> platforms.
>
> New Kconfig is introduced to enable this implementation only on the defau=
lt
> Arria10 and CycloneV boards as this will increase the SPL size which
> will exceed some Gen5 devices' SPL size limit.
>
> Fixes: e26ecebc684b ("socfpga: arria10: Allow dcache_enable before reloca=
tion")
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>
> Changes in v3:
> - Removed 'select SPL_CACHE if SPL' Kconfig guard from this patch and
>   applied this condition alongside SOCFPGA_ECC_SUPPORT on patch 3
>
> Changes in v2:
> - Shared dram_bank_mmu_setup() is set as optional via Kconfig and default=
ed
>   on only for the reference Arria10/CycloneV boards to avoid SPL overflow=
s
>   on size-limited Gen5 defconfigs.
>
>  arch/arm/mach-socfpga/misc.c         | 31 ++++++++++++++++++++++++++++
>  arch/arm/mach-socfpga/misc_arria10.c | 26 -----------------------
>  2 files changed, 31 insertions(+), 26 deletions(-)
>
> diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c
> index 1eef7893e54..80b054dcae9 100644
> --- a/arch/arm/mach-socfpga/misc.c
> +++ b/arch/arm/mach-socfpga/misc.c

Tested-by: Brian Sune <briansune@gmail.com>

Testing environment:
- Latest repository
- Custom board 2G max capacity SoCFPGA Cyclone V can handle.
- SDMMC Boot

Both cold warm reset shows no issue:

Boot log:
U-Boot SPL 2026.07-rc2-00016-g36d4c6535808-dirty (May 14 2026 - 08:24:01 +0=
800)
DDRCAL: Scrubbing ECC RAM (2048 MiB).
DDRCAL: SDRAM-ECC initialized success with 1053 ms
Trying to boot from MMC1


U-Boot 2026.07-rc2-00016-g36d4c6535808-dirty (May 14 2026 - 08:24:01 +0800)

Thanks,
Brian

>
