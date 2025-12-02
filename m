Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 930B7D116F6
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 12:25:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAE6C83E28;
	Tue,  2 Dec 2025 13:25:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="IB4LIaww";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26FCA83E3A; Tue,  2 Dec 2025 13:25:33 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6ACB83CAA
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 13:25:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 3890bfad-cf7a-11f0-ad1a-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 3890bfad-cf7a-11f0-ad1a-005056999439;
 Tue, 02 Dec 2025 13:27:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=C7B24UQv4eEHPW3D/Peitc7BzRmvnpqrrmSZVa//CbA=;
 b=IB4LIawwlNviE1Ew/UHKvPCkjoFn1Pkf6yxHPxSHp2WGgjl5yQngUJhaBGnaiAeiW5oQ8zX9xvO0+
 MHvh+WgGUhN3YOTTu24gsVILnqumJPsWR1WEQiP4VKjdo6H/9svsA0ggzQsojedXs9MOF79MFnb8fp
 KvTU5u0KILJ0pHl5lGn8nQpicCk6R+z9TvwDqzSasZvpiJVqZ382I2FpidutcxL4tZcgdohCWY2JBi
 YdCiuB1Gd9K4D4auf3OcOv++lE9wXMWSKQN9Jpoh7Zj08jigTKKsOUCNTWTz1V2pP9Q9bQ/fAWcACR
 rRIJshjNFSvvYVqgKvmhox4BnkrAQzQ==
X-KPN-MID: 33|Inocgw6cQyD2jdNVJmbLePZ7ntaq7dyVI6M2Mb1o/q4CAurnFit2RRjcUQIFmfy
 5SzQde4SqfrHkCNhTsgxZ5ocTvBq5wn2H5Ce9exJdePQ=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|pjKvbq2DRQ1nA0fbu/vZUonLs0K9+52QcyJOjtT0YnHY/61gaVOFk+yTMPTUlGN
 WIfvAVBXXfBZtg9jqFyt8lg==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id fc5b9680-cf79-11f0-bff1-00505699772e;
 Tue, 02 Dec 2025 13:25:28 +0100 (CET)
Date: Tue, 02 Dec 2025 13:25:27 +0100
Message-Id: <87bjkhax54.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: rick@andestech.com, ycliang@andestech.com, ziyao@disroot.org,
 e@freeshell.de, hal.feng@starfivetech.com,
 mchitale@ventanamicro.com, minda.chen@starfivetech.com,
 u-boot@lists.denx.de, zfsdt@canonical.com
In-Reply-To: <20251201174705.652626-1-zfsdt@canonical.com> (message from
 Heinrich Schuchardt on Mon, 1 Dec 2025 18:47:03 +0100)
Subject: Re: [PATCH 0/2] RISC-V: implement private GCC library
References: <20251201174705.652626-1-zfsdt@canonical.com>
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

> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Date: Mon,  1 Dec 2025 18:47:03 +0100
> 
> We currently include libgcc.a when building for the RISC-V architecture.
> For instance lib/mbedtls/external/mbedtls/library/bignum.c uses __ctzdi2().
> 
> At least the Ubuntu Linux distribution has switched to building libgcc.a
> for the RVA23S64 profile. Using this library on RVA20 systems results in
> crashes. We therefore need a private replacement library.

Sound like the real problem here is using a native toolchain instead
of a toolchain for the target at hand.

That said, the solution a sensible one.

> With the series a private GCC library and unit tests are provided for
> 64-bit RISC-V. This is enough to build for CONFIG_WGET_HTTPS as suggested
> in E's patch
> 
> [PATCH] configs: starfive: enable wget https
> https://lore.kernel.org/u-boot/20251112005451.41285-1-e@freeshell.de/
> 
> Heinrich Schuchardt (2):
>   RISC-V: implement private GCC library
>   test: provide unit tests for the RISC-V private GCC library
> 
>  arch/Kconfig            |   1 +
>  arch/riscv/lib/Makefile |   2 +
>  arch/riscv/lib/clz.c    | 105 ++++++++++++++++++++++++++++++++++++++++
>  arch/riscv/lib/ctz.c    |  97 +++++++++++++++++++++++++++++++++++++
>  lib/Kconfig             |   2 +-
>  test/lib/Makefile       |   4 ++
>  test/lib/test_clz.c     |  53 ++++++++++++++++++++
>  test/lib/test_ctz.c     |  53 ++++++++++++++++++++
>  8 files changed, 316 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/lib/clz.c
>  create mode 100644 arch/riscv/lib/ctz.c
>  create mode 100644 test/lib/test_clz.c
>  create mode 100644 test/lib/test_ctz.c
> 
> -- 
> 2.51.0
> 
> 
