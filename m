Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0AA7C5B555
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 13:33:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24EFE80F9C;
	Tue,  3 Jun 2025 15:33:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mEfdoFg1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89B6A82103; Tue,  3 Jun 2025 15:33:53 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8861F8091A
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 15:33:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 553DXZvQ3524709;
 Tue, 3 Jun 2025 08:33:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1748957615;
 bh=zFLDDuT9oZZFhHZX8AV+iSmVhwUVPK2hGVE1JyRbSro=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=mEfdoFg1/XEMveY3i6vkAg5JCdtvzhDaVinYqHG6laW0Xn0jtohjzw/lxQIwMwFxh
 RIC0MtkMjVtEteJuTLx46wAIRNcsTIhlfZtGx+tIChPHs4dH8WKwAuXqDBfMk50iYu
 N4om2dJDjmBnZ9n/0oP4IceOHEajnlmAIJHSV3PE=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 553DXZAY3637429
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 3 Jun 2025 08:33:35 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Jun 2025 08:33:35 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Jun 2025 08:33:35 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 553DXYY7406922;
 Tue, 3 Jun 2025 08:33:34 -0500
Date: Tue, 3 Jun 2025 08:33:34 -0500
From: Bryan Brattlof <bb@ti.com>
To: Moteen Shah <m-shah@ti.com>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <sjg@chromium.org>,
 <d-gole@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>
Subject: Re: [PATCH 6/6] arm: mach-k3: Print version of DM firmware during
 boot process
Message-ID: <20250603133334.yr5lpzd65gukiegu@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250528080519.677750-1-m-shah@ti.com>
 <20250528080519.677750-7-m-shah@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250528080519.677750-7-m-shah@ti.com>
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

On May 28, 2025 thus sayeth Moteen Shah:
> Print DM firmware's version in the boot up process of K3 devices.
> 
> Signed-off-by: Moteen Shah <m-shah@ti.com>
> ---
>  arch/arm/mach-k3/am62ax/am62a7_init.c | 4 ++++
>  arch/arm/mach-k3/am62px/am62p5_init.c | 4 ++++
>  arch/arm/mach-k3/am62x/am625_init.c   | 4 ++++
>  arch/arm/mach-k3/am64x/am642_init.c   | 4 ++++
>  arch/arm/mach-k3/am65x/am654_init.c   | 4 ++++

The AM64 and AM65 use DMSC firmware. Can they ever have a different DM 
version than what is reported by the SYSFW call?

>  arch/arm/mach-k3/j721e/j721e_init.c   | 4 ++++
>  arch/arm/mach-k3/j721s2/j721s2_init.c | 4 ++++
>  arch/arm/mach-k3/j722s/j722s_init.c   | 4 ++++
>  arch/arm/mach-k3/j784s4/j784s4_init.c | 4 ++++

~Bryan
