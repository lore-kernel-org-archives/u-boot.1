Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93C9CAC5B3
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 11:37:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CB8E80B9B;
	Wed, 24 Sep 2025 13:37:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rK6QmW1A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54C9C82998; Wed, 24 Sep 2025 13:37:49 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F2BC80107
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 13:37:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58OBbXFP1688860;
 Wed, 24 Sep 2025 06:37:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758713853;
 bh=jJtELfHIpObUMtBGCLGNR7ioGcmFzoreCyRVYm+AUzI=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=rK6QmW1AVr3JuiHMkajYQgiC0mZ4AMQOXLHxUa2/7lCACLEKbCfGm22UBxZdLfJxC
 nabaDDiwdMBFZqMXsOobjLD08wU/EevMOCYvrBW1BRQ/wL/ZKWkRCQktn5nEeJiL7m
 VBuzgtsMO/nlhgvVBTqIctAQC6opeTWN1rTwJQUI=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58OBbXkY2723586
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 24 Sep 2025 06:37:33 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 24
 Sep 2025 06:37:33 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 24 Sep 2025 06:37:33 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58OBbXYb1939718;
 Wed, 24 Sep 2025 06:37:33 -0500
Date: Wed, 24 Sep 2025 06:37:33 -0500
From: Nishanth Menon <nm@ti.com>
To: Aristo Chen <jj251510319013@gmail.com>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <sjg@chromium.org>,
 <alpernebiyasak@gmail.com>, <al.kochet@gmail.com>,
 <paul.henrys_ext@softathome.com>, <bb@ti.com>, <y.moog@phytec.de>,
 <w.egorov@phytec.de>, <francesco.dolcini@toradex.com>,
 <ggiordano@phytec.com>, <n-francis@ti.com>, <afd@ti.com>,
 <d.schultz@phytec.de>, <d-gole@ti.com>, <ravi@prevas.dk>,
 <carlos.lopezr4096@gmail.com>, <quentin.schulz@cherry.de>,
 <alice.guo@nxp.com>, Aristo Chen <aristo.chen@canonical.com>
Subject: Re: [PATCH v2 0/7] mkimage: Detect FIT image load address overlaps
 and fix related test/DTS issues
Message-ID: <20250924113733.uz6hozszbuynemtc@giddy>
References: <20250914110021.4103-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250914110021.4103-1-aristo.chen@canonical.com>
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

On 10:59-20250914, Aristo Chen wrote:
> This patch series enhances FIT image robustness by adding **memory
> region overlap detection** to `mkimage` and fixing existing overlaps
> in DTS files and `binman` tests.
> 
> The primary goal is to prevent runtime memory corruption from
> conflicting load addresses in FIT images.
> 
> Key Changes:
> 
> 1.  `mkimage` Overlap Detection: A new validation in
>     `tools/fit_image.c` checks for overlapping load addresses
>     within FIT configurations. `mkimage` now errors out with 
>     detailed info on conflicts, preventing bad FIT image creation.
> 
> 2.  New Test Case: A Python test verifies the new detection.
>     It intentionally creates an overlap (kernel and FDT)
>     to confirm correct error handling.
> 
> 3.  Fixes for Existing Overlaps:
>     * Board DTS (k3-am6xx): Adjusted load addresses for TI
>       firmware stubs to prevent conflicts. This resolves
>       previously undetected overlaps.
>     * `binman` Tests: Fixed several tests. U-Boot load
>       addresses were shifted to avoid ATF conflicts. A new
>       linker script for TEE ELF sections ensures distinct
>       memory layouts.
> 
> 4.  Documentation: Added guidance for developers on how to
>     determine ELF load addresses using readelf, linker scripts,
>     and objdump when working with binman FIT images.
> 
> Impact:
> 
> This series improves FIT image reliability by catching overlaps
> at build time, helping developers resolve issues before runtime
> failures.
> 
> ### Changes in v2:
> - Fixed typo in test case name (testFitSignNoSignatureNodes)
> - Added fixes for additional k3-am642 DTS files
> - Added comprehensive documentation for ELF load address determination
> - Enhanced copyright notice in elf_sections_tee.lds
> 
> Aristo Chen (7):
>   binman: Fix typo for the test case name
>   binman: Fix FIT image overlap issues
>   binman: Fix FIT image overlap issues for testFitSplitElf
>   arm: dts: k3-am6xx: Fix FIT image memory overlap in binman
>     configurations
>   tools: mkimage: detect overlapping load regions in FIT configurations
>   test: Add test case for FIT image load address overlap detection
>   doc: binman: Add guidance for determining ELF load addresses
> 
>  arch/arm/dts/k3-am625-phycore-som-binman.dtsi | 22 ++---
>  arch/arm/dts/k3-am625-sk-binman.dtsi          | 16 ++--
>  .../dts/k3-am625-verdin-wifi-dev-binman.dtsi  | 16 ++--
>  arch/arm/dts/k3-am62a-phycore-som-binman.dtsi | 10 +--
>  arch/arm/dts/k3-am62a-sk-binman.dtsi          |  4 +-
>  arch/arm/dts/k3-am642-phycore-som-binman.dtsi |  6 +-
>  test/py/tests/test_fit_mkimage_validate.py    | 65 ++++++++++++++
>  tools/binman/entries.rst                      | 18 ++++
>  tools/binman/ftest.py                         |  4 +-
>  .../test/276_fit_firmware_loadables.dts       |  4 +-
>  tools/binman/test/340_fit_signature.dts       |  4 +-
>  tools/binman/test/342_fit_signature.dts       |  4 +-
>  tools/binman/test/Makefile                    |  6 +-
>  tools/binman/test/elf_sections_tee.c          |  1 +
>  tools/binman/test/elf_sections_tee.lds        | 32 +++++++
>  tools/fit_image.c                             | 90 ++++++++++++++++++-
>  tools/mkimage.c                               |  3 +-
>  17 files changed, 257 insertions(+), 48 deletions(-)
>  create mode 120000 tools/binman/test/elf_sections_tee.c
>  create mode 100644 tools/binman/test/elf_sections_tee.lds
> 
> -- 
> 2.43.0
> 

Looks like i see a build regression in linux-next after this series.

https://gist.github.com/nmenon/b2fc9e7680cc296062c7dced94105f76

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource
