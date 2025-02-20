Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB518C021B1
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 10:07:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40D4C80EC0;
	Thu, 20 Feb 2025 11:07:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="P/+vQ46N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DBA980F53; Thu, 20 Feb 2025 11:07:11 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00E9480C98
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 11:07:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51KA76AV2119608
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Feb 2025 04:07:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1740046026;
 bh=/JtxvCZ7/Hyy8O5KdNvWC6b1ZRxkEWTyP+oINbrRHG4=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=P/+vQ46NvibXg9H1G6GWFrn/6z8n3fIDXkq8y9B9lZ2Wfwd4ts0jkToUT3m6YpL+L
 JMo6XAIl/YbGLwUMPk1P0LXhmjPNSay/lXJdJtKtargJzCcF+R4qGXLeqCw7NtROQm
 FeM7RaMsFXq4krCCEroDd2lje4KpKUDMYquy0gqA=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51KA76eu115864
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 20 Feb 2025 04:07:06 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 20
 Feb 2025 04:07:06 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 20 Feb 2025 04:07:06 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.113])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51KA74ak047341;
 Thu, 20 Feb 2025 04:07:05 -0600
Date: Thu, 20 Feb 2025 15:37:04 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Hrushikesh Salunke <h-salunke@ti.com>
CC: <trini@konsulko.com>, <n-francis@ti.com>, <s-k6@ti.com>, <kamlesh@ti.com>, 
 <a-shenai@ti.com>, <u-boot@lists.denx.de>, <s-vadapalli@ti.com>,
 <danishanwar@ti.com>, <srk@ti.com>
Subject: Re: [PATCH] configs: am65x_evm_r5_usbdfu_defconfig: Fix USB DFU boot
Message-ID: <eeukfc5m5esycykdggjk7qbcyhh4dspgjq5izqsuefp2waolbu@rc4c4xpha5xs>
References: <20250220100241.1170993-1-h-salunke@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250220100241.1170993-1-h-salunke@ti.com>
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

On Thu, Feb 20, 2025 at 03:32:41PM +0530, Hrushikesh Salunke wrote:
> Increase the size of malloc region allocated before relocation, as
> current size is insufficient for dfu boot causing it to overflow and
> corrupt the stack.
> 
> Enable the fixed regulator configs required by vtt_supply which is used
> by "am654_ddrss" driver. Without it during DFU boot DDRSS initialization
> is failing. These configs are enabled in "am65x_evm_r5_defconfig" but
> are missing from "am65x_evm_r5_usbdfu_defconfig".
> 
> Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Regards,
Siddharth.
