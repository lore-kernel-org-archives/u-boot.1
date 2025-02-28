Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F81DC19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 08:03:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD8C8808B6;
	Fri, 28 Feb 2025 09:03:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="iLi1OJJ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B96E80FE1; Fri, 28 Feb 2025 09:03:17 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E93AE807D7
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 09:03:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51S83DPl2600510
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 28 Feb 2025 02:03:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1740729793;
 bh=iVRnL7ySDpJCgIWEqrSbeoZj+3mnZ9r54rDUs3LOQ94=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=iLi1OJJ48l2DW4MZRSppnye+hVFmk8gM9AoRmEDx2u2AqADffLo/z9ncI15g8NgqQ
 Sp1ixbANhv0VM9XcO2eukzulJqhSWno+hHy5QIVcEZYHxy7Qs+vqtZ0DENCMy7mHek
 COBDlZaDX8ncCU8M10RP34IpvjR4SRUPK9+OMKx4=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51S83DrY028927;
 Fri, 28 Feb 2025 02:03:13 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Feb 2025 02:03:12 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Feb 2025 02:03:12 -0600
Received: from [172.24.20.42] (lt5cd2489kgj.dhcp.ti.com [172.24.20.42])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51S83ADm109553;
 Fri, 28 Feb 2025 02:03:11 -0600
Message-ID: <2657448e-ab5f-4cbb-b004-bdbbb59b90d4@ti.com>
Date: Fri, 28 Feb 2025 13:33:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] board: ti: j784s4: Update Resource Management configs
To: Neha Malcom Francis <n-francis@ti.com>, <trini@konsulko.com>
CC: <vaishnav.a@ti.com>, <u-boot@lists.denx.de>
References: <20250228054222.2852694-1-n-francis@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250228054222.2852694-1-n-francis@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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


On 2/28/2025 11:12 AM, Neha Malcom Francis wrote:
> From: Vaishnav Achath <vaishnav.a@ti.com>
>
> Update rm-cfg.yaml and tifs-rm-cfg.yaml to account for the
> changes added in the K3 Resource Partitioning Tool v1.18
>
> The change enables resource sharing between A72_2 and MAIN_0_R5_0
> for the BCDMA CSI RX and TX channels, J784S4 supports upto 12
> CSI cameras and 16 channels would not be enough for all such use
> cases for RTOS and Linux, thus sharing of resources in needed. Resource
> sharing between A72 and R5 for BCDMA CSI channels allow Linux to use 32
> channels at a time.
>
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> [n-francis@ti.com: rebased and sent on behalf]
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---


Reviewed-by: Udit Kumar <u-kumar1@ti.com>


> Sanity boot log:
> https://gist.github.com/nehamalcom/ef40be06080cb5bc4d1be881690aaebb
>
> Changes since v1:
> [..]
