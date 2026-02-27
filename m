Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A7CFEFB4F
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 13:46:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 267B683E76;
	Fri, 27 Feb 2026 14:46:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AzztuwTd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 846BE83E81; Fri, 27 Feb 2026 14:46:30 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DACF83CDF
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 14:46:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kamlesh@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qw0ISnMbFrOvVoE3QLPeQONLTKhkMkN2mA50tgkAUTylFON2RwSGfVHj0IYA+9jtbMuK4XUzKOcxKuJIcxNLbETh+EePsP+oLp8ISgMx34fTKOx9jG30897e6Terrp0AblSNiFstlGO8ufy3jSu48X4vryIMvEyIHRN+cV/BvTbRTvMMxZgDF+61zg7lyuRojyx5E/44baovMPI7KWUaBVvh4Vva7gsxQaLvreyiKcMjjbsvfllNRJ2vc59lxd1l1827DEGFeTKfUbJQCqPybAtTGZ4RSGM0oQBvj48orQE9Rrtkl2iYO5p/mZ6ZyQcTjz9jCSrkcz1UWpNohiK64g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDg1H/M29AmhLIoGqF0Oh93h4G2xC+AZAsplcXMmlnY=;
 b=a3TM5aKnvZI8IzUHnWT62dDfqrV053ZkSJCzTnSGp9V0+grJT69dRt6Pbf9DzUY1z1o3FEzX/EeYsU7OPhk4f0fR498h6bXoirilK6YeOQGpTLTavomS0o3S4NYf1Y2MChVHZJjCy7bjVrgBN5aQIsyD84he/MnUxtx7gUx3fB54GFIcK7lmbvfqd2HUDfJ/7R8qeUHd8rBw8bMz5lrQt4ZZt6sCHEXW1rRIHHjcDTLy6vFK3ZgxvRlLUYoNUhtW5Mk9aFRIGWUeC2afdKB6Fg5lreUXa6lXNHhoLlRjvqzXQIbXuHObFb8THQz/nLiwoo2Q0v7ZS2rH0UsPHnLKoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=foss.st.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDg1H/M29AmhLIoGqF0Oh93h4G2xC+AZAsplcXMmlnY=;
 b=AzztuwTdLeTJQ3PuST8e/2zhpH9EAZEr5IsxwTQhL/8eVbl7LEvwxnFWnCS2wCF9DSadgAK2m7ReFXI20s6akU+LZzQxJcagMIbYAu4FFWvSOOWP40OllPf2CgZv/scm16DIMN5KaJuDIxkjQ+Waun6/l37Qo31Q2Ksnlb7Li2U=
Received: from CY5PR15CA0080.namprd15.prod.outlook.com (2603:10b6:930:18::32)
 by CH3PR10MB7611.namprd10.prod.outlook.com (2603:10b6:610:176::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 13:46:23 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:18:cafe::e9) by CY5PR15CA0080.outlook.office365.com
 (2603:10b6:930:18::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.27 via Frontend Transport; Fri,
 27 Feb 2026 13:46:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 13:46:22 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 07:46:21 -0600
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 07:46:21 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 27 Feb 2026 07:46:21 -0600
Received: from localhost (kamlesh.dhcp.ti.com [172.24.233.19])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61RDkKbx3826165;
 Fri, 27 Feb 2026 07:46:20 -0600
From: Kamlesh Gurudasani <kamlesh@ti.com>
To: Marek Vasut <marek.vasut@mailbox.org>, <u-boot@lists.denx.de>
CC: Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>, Tom Rini
 <trini@konsulko.com>, Patrice Chotard <patrice.chotard@foss.st.com>, "Alice
 Guo" <alice.guo@nxp.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>, <anshuld@ti.com>,
 <vigneshr@ti.com>
Subject: Re: [PATCH] clk: scmi: Fix protocol version fetch for non-CCF
 platforms
In-Reply-To: <b131c7fd-dde7-41ec-8012-1bc829e2ba1a@mailbox.org>
References: <20260227-ccf-v1-1-a22c19460b74@ti.com>
 <b131c7fd-dde7-41ec-8012-1bc829e2ba1a@mailbox.org>
Date: Fri, 27 Feb 2026 19:16:19 +0530
Message-ID: <87pl5qz4d0.fsf@kamlesh.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|CH3PR10MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: af5cf208-57c0-4def-24bf-08de76069848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|34020700016|36860700013; 
X-Microsoft-Antispam-Message-Info: ltwPGZQFuI8T4Ybd9MEsm1Wlwi1CKfseWW5yzSvzdJTuubA9NRTdv64feU1vfd82RTyzEI3qWB916io/ek1cYV4US6ihz4DYOXW4il2o9xxRquGUmw4ag4wOFn12T3vciOmSYyB22jPCsBisKPaUnbYrEJQ8uF47m2W7TzTPJmjhmFeJ1Z6plDcpJEz3Lq2u/NxuIWZNr1j2jmU76cEsZ2nRmfXMfL3AUjJDy8gENOO3prDKxdEi+sJUWJvIxTET1h1CqbkJLG3iTa3+C0F33INHwYkGUiGesxm8BNUyB6tkPDfTLekvEUqRP3DG4bkgYyX9jkBY3aon6FZH3sDYNxmAm1ve++iALNFOp2KYf7RKKXxh3G5C3B4yawQauauc78aMCb+ROwNMVCQa5h0aGs6JzqhooMrWRBWXe8AV9CAkyE2y6kovqfcV/A4GTTl53M3WIBPNL6bEJy7isMRayUBYtzfJxW38IGvkJWBTpDfadN6SMhAKK8fVAIgTyGBpstoUrlHnHliRqDZ68PMAl85wOVKnlDWL9LgVuwepeVWXWdv15p2kh58XqpdqjIlwdqie0+Vj2q+LOwKwcUJJj2uLedSAFRQNej8v+1qkdcSvfdRSGqV0ro/z1DO4YYY4TA5Yfb3KMUYVo053t87iR8ZE66t4wrTS3x6FVTDRez9pI4e1DfTO6pKG3OHof8+TwcjzUXW1UJGIFPoJRmHbDzNPW0J6sqi3ahz3mrLDPBbHepOkOakP9MYLNYLc5V8XqR+lXu1xVEmxzDYEEsTILSVbborWYkPjNPgUEHFX+2/P9LoKMAOxPzBzJyzbPmCtvkN0nnHy6QRdqgoSMn8ClA==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(34020700016)(36860700013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ViDRikM8Od02ycgeqodv7Us2OYvC9qRoC2n9wFuIMC4VcU9HCgfFDoyiRmQc1vrdIPAxR4eekJ8sg2Xp3+bArLkw1TipK6gTIZ0FiUUNmlzWBZzl+JvaDIIKZiUNhA/QuMlUl1TKkgSFpnQ6im/QVJLv7ZH6ZCv3Ueo5rVsX2RGYa0k5LfA0w7908RQWSe7Wshbo5s4xZRcY0xxg81rJyygwEAvvxMC4HdZiNKgATN/Q6Vk74IYVo94IjaKqZWfJLTjQ55okAMMeLy+TEqtf2KXPDeRR8SWTHEh0JuQTs5dBlKO+60JSlghpEVoCigXEeJao2VF26ZYvsLz7k3/UO6PvSwQj8U5ezl9u/zIktI40QVkaEbalDAPMRr6XwKK9MGy00qFd0l+WlL0BVX+jk0Cc6GEGjNELlsHOCMfxpfG9KsI1zgL47eIZ+QHadJvT
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 13:46:22.9128 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af5cf208-57c0-4def-24bf-08de76069848
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7611
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

Marek Vasut <marek.vasut@mailbox.org> writes:

> On 2/27/26 1:07 PM, Kamlesh Gurudasani wrote:
>> The SCMI clock protocol version was only being fetched when CLK_CCF
>> was enabled. On non-CCF platforms, the probe function returned early
>> without fetching the version, leaving priv->version as 0.
>> 
>> This caused issues because code paths like scmi_clk_gate() and
>> scmi_clk_get_permissions() depend on priv->version to determine
>> which protocol message format to use, even in non-CCF mode.
>> 
>> Fix this by moving the scmi_generic_protocol_version() call before
>> the CLK_CCF check, ensuring the version is fetched for both CCF and
>> non-CCF platforms.
> Which platforms are these non-CCF platforms you refer to ? Which 
> platforms are broken right now ? Those details should be included in the 
> CM .
We noticed this on am62lx_evm which is yet to be upstreamed.

It should fail for all "CONFIG_SCMI_FIRMWARE" "~CONFIG_CLK_CCF"

But the failure case "0" is favoring the devices which are using scmi
clock protocol version less than 0x20001 (or 0x30000).

I can't really say if following devices use SCMI Server version greater
than 0x20001 and are getting affected by this. 

As am62lx_evm is not upstreamed yet, not sure if I should add that in
commit message. Let me know what you think.

Devices with "CONFIG_SCMI_FIRMWARE" "~CONFIG_CLK_CCF":
am62lx_evm cm3588-nas-rk3588 coolpi-4b-rk3588s coolpi-cm5-evb-rk3588
coolpi-cm5-genbook-rk3588 evb-rk3588 gameforce-ace-rk3588s
generic-rk3588 jaguar-rk3588 khadas-edge2-rk3588s mnt-reform2-rk3588
nanopc-t6-rk3588 nanopi-r6c-rk3588s nanopi-r6s-rk3588s neu6a-io-rk3588
neu6b-io-rk3588 nova-rk3588s odroid-m2-rk3588s orangepi-5-max-rk3588
orangepi-5-plus-rk3588 orangepi-5-rk3588s orangepi-5-ultra-rk3588
quartzpro64-rk3588 rock-5-itx-rk3588 rock-5c-rk3588s
rock5a-rk3588s rock5b-rk3588 sige7-rk3588 stm32mp15-odyssey stm32mp15
stm32mp15_trusted tiger-rk3588 toybrick-rk3588 turing-rk1-rk3588

Regards,
Kamlesh

