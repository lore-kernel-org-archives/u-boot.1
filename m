Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A9DECAC59A
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 05:58:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F9D080B9B;
	Tue, 16 Sep 2025 07:58:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EutQkU74";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F399481E13; Tue, 16 Sep 2025 07:58:15 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 862E880422
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 07:58:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58G5w7oV1299561;
 Tue, 16 Sep 2025 00:58:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758002287;
 bh=FSjKFzfuL17/fhMU0wXvs/qdL0baGLwh4kP1CWSoQVQ=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=EutQkU74cU1X0NNWZmsv5omDLRdQyHAtrbkmBh5LiOn5cF4t+x4jL00lU0/cUu2zs
 GP3Xt6xC2MkRILg1XiEQAfuk3jIhp9BMFLLd2CpXudOw+105UtLgZOUjH3ExXVWyCC
 q7E9/VH8EQ/cekCFzXrPstEldy258WL1PcJy7vKI=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58G5w7jl304125
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 16 Sep 2025 00:58:07 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 16
 Sep 2025 00:58:06 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 16 Sep 2025 00:58:06 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58G5w5CB1132736;
 Tue, 16 Sep 2025 00:58:06 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 16 Sep 2025 11:28:05 +0530
Message-ID: <DCTZSSLLIB7W.85DPC6Y0J696@ti.com>
CC: Anshul Dalal <anshuld@ti.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Harsha Vardhan V M <h-vm@ti.com>, "Jerome Forissier"
 <jerome.forissier@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, Simon Glass
 <sjg@chromium.org>, "Venkatesh Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH v2] doc: usage: Add File System section and Ext4
 documentation
From: Anshul Dalal <anshuld@ti.com>
To: Tony Dinh <mibodhi@gmail.com>, Tom Rini <trini@konsulko.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250914205807.22817-1-mibodhi@gmail.com>
In-Reply-To: <20250914205807.22817-1-mibodhi@gmail.com>
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

On Mon Sep 15, 2025 at 2:26 AM IST, Tony Dinh wrote:
> Create doc/usage/filesystems/ section.
> Convert doc/README.ext4 to rST format and move it to the new section.
> Update documentation to add configuration instruction for Ext4 Write
> when using large partitions.
>
> Note that this patch depends on this previous patch:
> https://patchwork.ozlabs.org/project/uboot/patch/20250910215702.15576-1-m=
ibodhi@gmail.com/
>
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>

Reviewed-by: Anshul Dalal <anshuld@ti.com>

Thanks for the patch!

Regards,
Anshul
