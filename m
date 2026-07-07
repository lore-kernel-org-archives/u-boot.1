Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1959C43602
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 08:36:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D62A846B4;
	Tue,  7 Jul 2026 10:36:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="FaNrhC5P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A15E801A9; Tue,  7 Jul 2026 10:36:47 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7807E8497A
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 10:36:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raphael.gallais-pou@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+7x+UM9EWY0SaiBVAtV6mJmlhv/Y4ls2Ukj9cXrRr1ofcX+HyzS0O2Sl+W+9NbhIWzdszUktDtEfj60MqrMWevwiqoikuySJsy/9B0Su1QIxWL1LA+Os/3Qefqmd4kathi8UFlXjNc+x5csZu9mo/GsD3iBE7qv4Qe2JYS20wR8NukJktId9HX4kO7O5MmVOM6s6J8v4bQYZSjgLudShDa2Lj6E/fDyVlV0xx0LbW3tYHqWTRtgwtteV5UtTzYqxvjISuuK6T3oC0DWaFMMCYfUh4PnNuon7XMN+Bl4l2h8FKotNWWiBV/y2NMcLv4AyfMpe89mpe9rNRwdXAgqcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJ8q8t1Ul1tF317VB0KKqFzMr5F+EhO3e+uhVuhegQ4=;
 b=OVS8aMpS3f0VNtjXURjdhIPdh8xbrGTERyb9nIKTpukUYn9dSMqk4vGs1zZBea468ck0vP7dVuEMMUAVIgFq1ZQk4Nv3WoCTyITemznOCEXXKvm01x7D4HTrhOsZlLJm1hIVDebj6y2jtVay8YwvhalTyzkvTjY4r0XFum2aS1dYkt/8LarXDsGzb08A2MA9lHTPD0z2CpJY762qQuKHqVFzoecNnAVhzONPY3rWgzH3+k22iH7XkD9ZFkB4YL3j3CCwCzPMQpvVu2PbEzhctXd7vl6D53b8V4dW3vtbNFNZMdAFX3Yg3zW/nwM3YsO7/AHVNe13TJoH1O3O1W+bIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=oss.nxp.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJ8q8t1Ul1tF317VB0KKqFzMr5F+EhO3e+uhVuhegQ4=;
 b=FaNrhC5PP2Md4xRzAb7S8iAJHVc9XTEgk4CadZsxLPu20KTcodVavdbxIZ84J6E+KZnxjgLJ+7PtqW7bjXr7mxCzcMJzr+1HxdkHZXLa8wNl+eegQgyU3Sbuv6r5gYpZCiVL7O3GPomgBrmJ/RW+LxmiNEXb+kiFTRCwOa7F36oEUW+H/KwUwB2j9sDHdBPB9xJJfBgdK2IGtiKYSBQu41c4VHlC6ELxOyXHMW4/uvVxQPgnEjyNGzeBUF3is6ADGvR1SbdKFit0qGskj6kwEN60g2YW4uYwGZ6RHKZMVv4awxlvtLON8FdGs+tBTOCFnNvrCNkx8YDkoY0zwd/LAw==
Received: from AS4P195CA0013.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5e2::16)
 by PA1PR10MB9783.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:564::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 08:36:40 +0000
Received: from AMS0EPF000001B6.eurprd05.prod.outlook.com
 (2603:10a6:20b:5e2:cafe::1d) by AS4P195CA0013.outlook.office365.com
 (2603:10a6:20b:5e2::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Tue, 7
 Jul 2026 08:36:40 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS0EPF000001B6.mail.protection.outlook.com (10.167.16.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 08:36:40 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 7 Jul
 2026 10:41:29 +0200
Received: from [10.130.76.182] (10.130.76.182) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 7 Jul
 2026 10:36:38 +0200
Message-ID: <960564c4-6b6a-4c0b-a328-774b5b14b32c@foss.st.com>
Date: Tue, 7 Jul 2026 10:36:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] dm: core: Correct calloc arguments
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, <u-boot@lists.denx.de>, "Simon
 Glass" <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: Rasmus Villemoes <ravi@prevas.dk>, Casey Connolly
 <casey.connolly@linaro.org>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Romain Gantois <romain.gantois@bootlin.com>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Markus Schneider-Pargmann <msp@baylibre.com>, Yannick Fertre
 <yannick.fertre@foss.st.com>, Peng Fan <peng.fan@nxp.com>
References: <20260703-dm-core-v1-0-076d395bded4@nxp.com>
 <20260703-dm-core-v1-3-076d395bded4@nxp.com>
Content-Language: en-US
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <20260703-dm-core-v1-3-076d395bded4@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.130.76.182]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B6:EE_|PA1PR10MB9783:EE_
X-MS-Office365-Filtering-Correlation-Id: 44d8d3f9-dcde-4696-4baa-08dedc02de08
X-LD-Processed: 75e027c9-20d5-47d5-b82f-77d7cd041e8f,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|36860700016|376014|23010399003|1800799024|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: u8oura/SV+FgenNLrl2ZC09DEv69UsimFV8inu9baccF6+f8fYHyKahpUyDTJAHCjRrl8mZq6Wlo6cIDFPH+gu/bT9mSsxWsx3sSu7tKQBohu8DUvxRRIDUHdzso26CfKy+VMSn7fUTrzsyE4c6F5WDzzAbXk4vZx9N4Z1O9kV/aloU5CspmQLZj7PXJOnFgv3GP7U2HjMxu0DJDiTOX+P/QDypurjRvOfH5NtKutp71SaTBIM9cZFw97Aj6qImuhc2ble0kjRbfzCr1ekg1MSqLO7Zb/6hoiYhYl+YvwWugNZghpZKVCsXK/0zkfVmm8QWIYYnXg/J1YnPI0APolBPo3fGb5bq9B8eb7j2KoESeNuLzCEFLtOGhSvRFtt4iJtkU4opbU9kR3kKO6nF7aD9Juf7AI6oYAv6vbITYQ7lsKNBaqkDVXv+1XUs4y5+cjTrYb5cxYzmxsgyeFa+8pSOWona9Ihjaxdny6VcQ1+Bg05NHdeknmJ7seRm2jNPhT8g0OjTCHLT/EpKvNAQV/ro/GfJK1hcEWzkfj9zB2KNYZYeEpddOXzo7t5ksrDyKGQrahjXQazGS+Ek4glkb2I9+IkrjwBeym1YMgnl6bGf83Iq60Bhk1joBmR1Ia2Q+hB5NGjGvPU1DZ9TbuxmUG1+EzVbFtL3Vq4VMaQns+Feu5V8cEsdTMQQcNkLGK2SQJVRLIBpK1QDbW7pmk4fXSA==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(36860700016)(376014)(23010399003)(1800799024)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MZoE6yMNppKxtCwxfv+YFHWix0PYV2piaqF6MLa2z8alqRmSSbSsD9d1p10srKWbQA2EZxzdJ+ScayulffSa7V54amB2bQtsqqA+vYmY3ap97nhUcqdFzC/c0PZOPakb0XdTDAfnbVGTpJ1nJwNTiV8H3jvZi0NIy0HbyKtW+qSfrUykzZWpCCF8gtJ6JReHJgxmxjD2A94PCormKBRk+SPywHy8rLokOplLCjOYKuQuPxIwDt8o8HGwWbRV0xbRdXxTYrEG05MCCjkrCBmNzaXPUjtOFEtbOg0oRzGYuLpIztL8x97EUO0HHg02XwU9SC8DcHmC4Bt3XeWc5/j7phadJqmKQxFzNKOZwY0vjqDLA439aluPrxMAXdh/YLOQKvadEcjBbSdk3Wxmp3m8V3IMSzexP5KKaDoqy5HILIlk+2RH8GLwh8HxmJXORwqR
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:36:40.5480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d8d3f9-dcde-4696-4baa-08dedc02de08
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001B6.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9783
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



On 7/3/26 11:11, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>Every other calloc in drivers/core uses
> calloc(count, size) with count first. Fix the two reversed calloc(sizeof, 1)
> calls for consistency. Signed-off-by: Peng Fan <peng.fan@nxp.com>---

Hi,

Reviewed-by: Raphaël Gallais-Pou <raphael.gallais-pou@foss.st.com>

Best regards,
Raphaël
