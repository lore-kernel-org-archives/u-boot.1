Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D7EC71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 12:49:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A130C82BCD;
	Wed, 18 Jun 2025 14:49:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KvdHwLkX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FA9282CBC; Wed, 18 Jun 2025 14:49:28 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E14EE82B20
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 14:49:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55ICnNdg309866;
 Wed, 18 Jun 2025 07:49:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1750250963;
 bh=zr+kywgpbBeHtwN6pxpMZ5XqzatN+MjqXJ5g4sAPNdU=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=KvdHwLkXAgyJeW0eGUDBF7jnsIA/VxzDXTuCPNG2NHiXbqH8lN7+KJGIEKXQJf2bv
 waCdvai3oXOo1Li9lnvEtIrbu0DJxWlXc4bmiisigHwIMlwpMYg09YQocvq1FIXQki
 5b9YzOOOiyLAvZHuTksDTZC4ne0VcEpIEdBIufsc=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55ICnNxv381996
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 18 Jun 2025 07:49:23 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 18
 Jun 2025 07:49:22 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 18 Jun 2025 07:49:22 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55ICnM9l3491956;
 Wed, 18 Jun 2025 07:49:22 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 18 Jun 2025 18:18:42 +0530
Message-ID: <DAPO65QJ47IV.1AX9GYAWDCG67@ti.com>
From: Anshul Dalal <anshuld@ti.com>
To: Anshul Dalal <anshuld@ti.com>, <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <afd@ti.com>, <m-chawdhry@ti.com>,
 <n-francis@ti.com>, <b-liu@ti.com>, <nm@ti.com>, <bb@ti.com>,
 <u-kumar1@ti.com>
Subject: Re: [PATCH v3 1/2] mach-k3: add runtime memory carveouts for MMU table
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250617135844.2873701-1-anshuld@ti.com>
In-Reply-To: <20250617135844.2873701-1-anshuld@ti.com>
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

On Tue Jun 17, 2025 at 7:28 PM IST, Anshul Dalal wrote:
> In u-boot we only provide a single MMU table for all k3 platforms,
> this does not scale for devices with reserved memory outside the range
> 0x9e780000 - 0xa0000000 (eg j722s[1]) or for devices with < 2GiB of
> memory (eg am62-SIP with 512MiB of RAM).
>
> To properly configure the MMU on various k3 platforms, the
> reserved-memory regions need to be queried at runtime from the
> device-tree and the MMU table should be updated accordingly.
>
> This patch adds the required fixups to the MMU table (during proper
> U-boot stage) by marking the reserved regions as non cacheable and
> keeping the remaining area as cacheable.
>
> For the A-core SPL, the 128MiB region starting from SPL_TEXT_BASE
> is marked as cacheable i.e 0x80080000 to 0x88080000.
>
> The 128MiB size is chosen to allow for future use cases such as falcon
> boot from the A-Core SPL which would require loading kernel image from
> the SPL stage. This change also ensures the reserved memory regions that
> all exist past 0x88080000 are non cacheable preventing speculative
> accesses to those addresses.
>
> [1]:
> https://git.ti.com/cgit/ti-u-boot/ti-u-boot/tree/arch/arm/mach-k3/arm64/a=
rm64-mmu.c?h=3Dti-u-boot-2025.01-next#n54
>
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
> Changes for v3:
>  - Remove unused memory regions in SPL's map
>  - Add runtime addition of MMU entry for the framebuffer in SPL
>  - Refactor k3_mem_map_init to use standard u-boot APIs
>  - Unmap reserved-memory regions instead of keeping them uncached
> v2: https://lore.kernel.org/u-boot/20250610160833.1705534-1-anshuld@ti.co=
m/
>
> Changes in v2:
> - Removed dependency to:
>   https://lore.kernel.org/u-boot/20250522150941.563959-1-anshuld@ti.com/
>
> v1: https://lore.kernel.org/u-boot/20250602120054.1466951-1-anshuld@ti.co=
m/
> ---

[snip]

Superseded by v4:
https://lore.kernel.org/u-boot/20250618124210.1936140-1-anshuld@ti.com/
