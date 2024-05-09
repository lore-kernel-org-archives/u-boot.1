Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B0EC10F1A
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 12:29:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14293880D2;
	Thu,  9 May 2024 14:29:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Tg4yT3j5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A18F880F8; Thu,  9 May 2024 14:29:09 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A22B880D6
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 14:29:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 449CT35a121626;
 Thu, 9 May 2024 07:29:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1715257743;
 bh=nK3vMldq4TZ+lI0D3BzEKlVxTC/5+/rrTzzfe64YD78=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Tg4yT3j5MCRhFeqn88vG7nPKkMJNs7K+XzS3hH0Dto0tBvnhJilr2E1u3k6qQoac8
 x6yxlrmm394fzP0wE6pv3ozE2F4mLaMtzzhu69awSMtjAO68UAWuAyNuufuIGCfYUR
 Losi/rQPWOMs+A0cg/awze64EJZddBaWyIxaatXU=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 449CT3Ji029332
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 9 May 2024 07:29:03 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 9
 May 2024 07:29:02 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 9 May 2024 07:29:02 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 449CT2If006305;
 Thu, 9 May 2024 07:29:02 -0500
Date: Thu, 9 May 2024 07:29:02 -0500
From: Nishanth Menon <nm@ti.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Alper Nebi
 Yasak <alpernebiyasak@gmail.com>, <u-boot@lists.denx.de>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Aniket Limaye <a-limaye@ti.com>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH v2 3/6] arch: arm: dts: k3-am68-sk-r5: Sync with J721s2
 R5 file
Message-ID: <20240509122902.vxlct6cqhe57cwzk@jawed>
References: <20240509-b4-upstream-j721s2-of-upstream-v2-0-149563cd4901@ti.com>
 <20240509-b4-upstream-j721s2-of-upstream-v2-3-149563cd4901@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240509-b4-upstream-j721s2-of-upstream-v2-3-149563cd4901@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 15:23-20240509, Manorit Chawdhry wrote:
> Currently AM68 SK boots with J721s2 R5 DTS and then later changes to
> AM68 SK DT during runtime.
> 
> To split the support of J721s2 and AM68, sync AM68 R5 DT with J721s2 R5
> DT as that contains some essential node changes for booting up AM68
> using AM68 R5 DT.
> 
> secure_proxy_mcu and secure_proxy_sa3 node changes are required for
> establishing contact with TIFS running on M4 core, and the addition of

s/TIFS/ROM and TIFS - you need sa2 sproxy for ROM and mcu sproxy for
TIFS.

M4 Core is generic - SMS M4 core will clarify.

> new power domain helps in holding A72 in reset for configuration of
> firewalls.

s/A72/A72 Cluster/


[...]

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
