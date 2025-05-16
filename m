Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BC9C3ABD8
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 05:31:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F1808288D;
	Fri, 16 May 2025 07:31:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Mx1LKVwS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC8208294C; Fri, 16 May 2025 07:31:00 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ADBA8277D
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 07:30:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 54G5Usm9198124
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 May 2025 00:30:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1747373454;
 bh=/KSpIQNsxAocRc2zXoKsS3xlr7vcMBQLv7ouRgq6BBk=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Mx1LKVwSQFsF01uosgQGRlpk2eguilRCMMWZMWeIOjsG0XHTDrhcO3vihfEXWBOhB
 I1Y42u25S8ujeLxAMJzKJc4dzjd7+J+mngkYh64DETapLd0CN5UTbYfngyse6tsjpA
 dr3bAN0/ZxO3x7+VBISy8X3QlDaHMcwdZqR/sLsU=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 54G5Us3H013596
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 16 May 2025 00:30:54 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 16
 May 2025 00:30:54 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 16 May 2025 00:30:54 -0500
Received: from [10.24.69.37]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54G5UpJq082790;
 Fri, 16 May 2025 00:30:52 -0500
Message-ID: <e8385d97-cfd3-4e6b-89e9-b353fcb19a08@ti.com>
Date: Fri, 16 May 2025 11:00:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Print Reset Reason for K3 based devices
To: Wadim Egorov <w.egorov@phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <bb@ti.com>,
 <ilias.apalodimas@linaro.org>
References: <20250515111554.2916254-1-w.egorov@phytec.de>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20250515111554.2916254-1-w.egorov@phytec.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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

Hi Wadim

On 15/05/25 16:45, Wadim Egorov wrote:
> Although AM62x, AM62Ax, AM64x, and AM62Px share the same register for
> reset reason, not all TRMs document this consistently. To avoid relying
> on undocumented behavior, introduce SoC-specific implementations for
> now. If TI confirms all SoCs share the same register, this can be moved to
> common.c for reuse.

Just checked the J7200 documentation, and seems like we have the same
register (CTRLMMR_WKUP_RESET_SRC_STAT) however it looks like the
register bit description is different from what is patched here. So
looks like the code cannot be common.

> 
> It will be mostly copy&paste for the mentioned devices.
> 
> Also, I am not sure how this Register operates exactly. I noticed that
> two bits can be set at once, so I started to check for set bits instead
> of having a switch/case logic.
> 
> Wadim Egorov (2):
>   arm: mach-k3: Detect and print reset reason
>   arm: mach-k3: am62x: Implement get_reset_reason()
> 
>  arch/arm/mach-k3/am62x/boot.c                 | 40 +++++++++++++++++++
>  arch/arm/mach-k3/common.c                     | 10 +++++
>  arch/arm/mach-k3/include/mach/am62_hardware.h | 19 +++++++++
>  arch/arm/mach-k3/include/mach/hardware.h      |  1 +
>  4 files changed, 70 insertions(+)
> 

-- 
Thanking You
Neha Malcom Francis
