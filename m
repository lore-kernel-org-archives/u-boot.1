Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63129CA0EED
	for <u-boot@archiver.kernel.org>; Fri, 22 Aug 2025 11:38:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2FF280548;
	Fri, 22 Aug 2025 13:38:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="A/oppR1a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C71C881D5D; Fri, 22 Aug 2025 13:38:31 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 997038006D
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 13:38:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57MBcQpV717094;
 Fri, 22 Aug 2025 06:38:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1755862706;
 bh=RubpowqBmrX9JBaEDjgbhy2SHDD8pEdNiu/TGMgLX00=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=A/oppR1apjfu4xqFGLdHnK1PrabK8vsVed0zam25+NvG/3c23mJcX97UiC/dg4EX+
 TJrZkAS2dSj1DPOf1miBbQ74shaymmuJc8O4jMAwZSnsbxcfE85uycxcfb0Tq85LLC
 KzTj0d+n3IQ46oPJFxUa99pYNRZ6Tn7T5SIDdUKw=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57MBcQ5x3571383
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 22 Aug 2025 06:38:26 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 22
 Aug 2025 06:38:26 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 22 Aug 2025 06:38:26 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57MBcOtQ3769548;
 Fri, 22 Aug 2025 06:38:25 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 22 Aug 2025 17:07:15 +0530
Message-ID: <DC8XCV7VF4V7.2DK03WE5W9DPX@ti.com>
CC: <vigneshr@ti.com>, <praneeth@ti.com>, <nm@ti.com>
Subject: Re: [PATCH v1] remoteproc: k3: update compatible for am654 syscon
From: Anshul Dalal <anshuld@ti.com>
To: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250814152145.2853307-1-anshuld@ti.com>
 <175581002909.928164.4782059063073591013.b4-ty@konsulko.com>
In-Reply-To: <175581002909.928164.4782059063073591013.b4-ty@konsulko.com>
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

Hi Tom,

CC+: Nishanth

On Fri Aug 22, 2025 at 2:30 AM IST, Tom Rini wrote:
> On Thu, 14 Aug 2025 20:51:43 +0530, Anshul Dalal wrote:
>
>> The existing compatible name for U-Boot's k3 system controller driver
>> i.e "ti,am625-system-controller" has been added to linux[1] device-tree.
>> This compatible in kernel is meant for configuring the Control Module
>> registers (CTRL_MMR0).
>>=20
>> However in U-Boot, the matching driver was being used to load the system
>> firmware on the secure M-cores by the R5 SPL and therefore must be
>> updated to a different compatible to avoid conflicts.
>>=20
>> [...]
>
> Applied to u-boot/next, thanks!
>
> [1/1] remoteproc: k3: update compatible for am654 syscon
>       commit: 2792cbf5d281b519692c546849638b2141046a4e

Actually the patch was meant for master since upstream u-boot's broken
for AM65 right now. Could you merge it to master as well?

As for upstreaming the new compatible, it might not get accepted since
it represents the same hardware block as the existing "ti,k2g-sci" but
before tifs has been loaded to it.

Down the line I'll see if we can merge the two nodes or the drivers so
we won't need this new compatible to begin with.

Regards,
Anshul
