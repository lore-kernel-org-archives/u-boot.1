Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805A9CA0EED
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 13:50:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6C2C8328F;
	Thu, 28 Aug 2025 15:50:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AwW5+cKA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69412832C8; Thu, 28 Aug 2025 15:50:14 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 949E1831C2
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 15:50:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57SDo9DU1536101;
 Thu, 28 Aug 2025 08:50:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756389009;
 bh=qwh4ksaM46Nv60NZBa6X9JfgPveHqrnVKdPNdCY6TFc=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=AwW5+cKAISJqhl3hkwye1lNNS2D1EGxe5ZW9Ks33HFJ6T9+S/RbPNG6EK0neeYvIq
 PbKtRErFD/3ha6qJlBoQ0pp+0Wp9NV5aKheEtcmVz/dEe3BsDLtGBpqyreKUlMpZi2
 gY2LdZl5+bX7QslRGQQAhdu+Kfn+zdLpIBFoE49I=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57SDo9I33271810
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 28 Aug 2025 08:50:09 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 28
 Aug 2025 08:50:08 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 28 Aug 2025 08:50:08 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57SDo7R1427454;
 Thu, 28 Aug 2025 08:50:08 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 28 Aug 2025 19:18:53 +0530
Message-ID: <DCE3WWVDTYNE.R7JSUVWETMLO@ti.com>
CC: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 0/3] memtest performance improvements
From: Anshul Dalal <anshuld@ti.com>
To: Rasmus Villemoes <ravi@prevas.dk>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250822181848.3325832-1-ravi@prevas.dk>
In-Reply-To: <20250822181848.3325832-1-ravi@prevas.dk>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi Rasmus,

On Fri Aug 22, 2025 at 11:48 PM IST, Rasmus Villemoes wrote:
> The first two patches make memtest run ~40x faster (when, as it should
> be, dcache is disabled), with the second patch being responsible for
> most of that. At least on the beagleboneblack which I used for
> testing; other boards and configurations will likely see different
> numbers.
>
> This is for CONFIG_SYS_ALT_MEMTEST=3Dy and
> CONFIG_SYS_ALT_MEMTEST_BITFLIP=3Dn; one could probably get a similar
> improvement in the bitflip case since that also has a schedule() call
> in the inner loop.
>
> Rasmus Villemoes (3):
>   memtest: don't volatile-qualify local variables
>   memtest: only call schedule() once for every 256 words
>   memtest: remove use of vu_long typedef in mem_test_alt
>
>  cmd/mem.c | 40 +++++++++++++++++++++-------------------
>  1 file changed, 21 insertions(+), 19 deletions(-)

For the entire series:
Tested-by: Anshul Dalal <anshuld@ti.com>

Tested on TI AM62P EVM, with ~10x improvment.

Patch:

	diff --git a/configs/am62px_evm_a53_defconfig b/configs/am62px_evm_a53_def=
config
	index fa857e51137..896e98fb7ca 100644
	--- a/configs/am62px_evm_a53_defconfig
	+++ b/configs/am62px_evm_a53_defconfig
	@@ -150,6 +150,9 @@ CONFIG_SPL_USB_HOST=3Dy
	 CONFIG_SPL_USB_STORAGE=3Dy
	 CONFIG_FS_FAT_MAX_CLUSTSIZE=3D16384
	 CONFIG_EFI_SET_TIME=3Dy
	+CONFIG_CMD_MEMTEST=3Dy
	+CONFIG_SYS_ALT_MEMTEST=3Dy
	+CONFIG_SYS_ALT_MEMTEST_BITFLIP=3Dn

	 #include <configs/k3_efi_capsule.config>
	 #include <configs/am62x_a53_usbdfu.config>

Results:

Before:
	=3D> dcache off
	=3D> time mtest 0x81000000 0x82000000 0 1
	Testing 81000000 ... 82000000:
	Iteration:      1
	Tested 1 iteration(s) with 0 errors.

	time: 10.848 seconds

After:
	=3D> dcache off
	=3D> time mtest 0x81000000 0x82000000 0 1
	Testing 81000000 ... 82000000:
	Iteration:      1
	Tested 1 iteration(s) with 0 errors.

	time: 1.054 seconds

Regards,
Anshul
