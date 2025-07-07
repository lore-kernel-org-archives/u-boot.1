Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD06C71130
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 16:36:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E0B98319C;
	Mon,  7 Jul 2025 18:36:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="t1U/f66J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8B8E8319F; Mon,  7 Jul 2025 18:36:32 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E77F8318E
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 18:36:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 567GaR9s272240;
 Mon, 7 Jul 2025 11:36:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1751906187;
 bh=ZLFdrWg5gWxXYOopp7DrbZ0m6ApOEYAyzrLB8zRao7I=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=t1U/f66J5LWxbfMnRHHBjXfE4PG5suosvEMOY5zRL4BGQ0HQPAsEKslEaV67k2sid
 YBqFFH/3WSmfixmPNv8j74ZNWf4Dm7NnBZ+iyZPNR1e0rwjJ9ZAtiXKXw2gCw9o0Z2
 802zwvyJwuObMMSxqVOc13JEiG+FNvc4U+AlG79E=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 567GaRGm177878
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 7 Jul 2025 11:36:27 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 7
 Jul 2025 11:36:26 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 7 Jul 2025 11:36:26 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 567GaQN1225604;
 Mon, 7 Jul 2025 11:36:26 -0500
Date: Mon, 7 Jul 2025 11:36:26 -0500
From: Bryan Brattlof <bb@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>, <vigneshr@ti.com>,
 <vaishnav.a@ti.com>, <j-choudhary@ti.com>, <afd@ti.com>, <u-kumar1@ti.com>
Subject: Re: [PATCH v2] board: ti: Clean up formatting in rm-cfg.yaml
Message-ID: <20250707163626.4trdbcgiuzlibm6x@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250704091234.3218906-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250704091234.3218906-1-n-francis@ti.com>
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

On July  4, 2025 thus sayeth Neha Malcom Francis:
> Move to using the latest generated RM YAML configuration files generated
> by the K3 Resource Partitioning Tool which updates them to have standard
> formatting with respect to indentation.
> 
> These files were generated from the untagged commit 41718bd5f915 ("docs: Update
> docs and move them to docs folder") of the K3 Resource Partitioning tool. This
> tool is packaged as a part of the public SDK and is not otherwise
> publicly available.
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
> Changes since v1:
> https://lore.kernel.org/all/20250702105533.1533178-1-n-francis@ti.com/
> - commit message changed to include the generated tool commit (Udit)
> 
> Boot logs:
> https://gist.github.com/nehamalcom/73c1c66d674c32f71a6ade8049c97d21
> 
>  board/ti/am64x/rm-cfg.yaml      | 2416 +++++++-------
>  board/ti/j7200/rm-cfg.yaml      | 3554 ++++++++++----------
>  board/ti/j721e/rm-cfg.yaml      | 5498 +++++++++++++++----------------
>  board/ti/j722s/rm-cfg.yaml      |   66 +-
>  board/ti/j722s/tifs-rm-cfg.yaml | 1552 ++++-----
>  5 files changed, 6543 insertions(+), 6543 deletions(-)

Are only these boards affected or should we do this for all the 
reference boards?

~Bryan
