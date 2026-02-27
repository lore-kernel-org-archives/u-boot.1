Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F5E3FD5332
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 10:05:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 043E283AA9;
	Fri, 27 Feb 2026 11:05:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nvhavyLR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22B8083642; Fri, 27 Feb 2026 11:05:34 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33D2B83AA9
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 11:05:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GDwHA9uec0GAPstipDTeIOmK3VSXrvzvpa0275jhMw/De9p/86/ZROSTjhcEq3gMkNZBtB57757dxfk4ZHggaP0CkYsiNTsPW/XRzrzfepABvlzmLBxRX9rqE+oDtcgkDF2eyGvICXg07NEWZ26EYC7+UGXRXn259seIvpa/oLvYv1c8MRROsnDUEsRXOhmvwHIaKnr6FBllo14ov+hk6gB1F+CO7hDb18o+Fqcc+rWrXhfUa1n9AAgX1RZh5B41+KdzaV7fvVyG6wTF/1NlucXzjpaqqYSYeHETnO55H8v/umOeVxBNYxtlR0KhTPFXOcaUlaIleys5ehbFp0DbKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zy2PXwZArfagM32SktJMqERp8ERK1NJyC9SrpLoObNw=;
 b=OQvgl4N4y1Qo8jqT3JzAteM3yRONcnz1PLySUC3pI7OPg5WGUinOTZbKZcSlRxtzsDL4AlQkqBbvNGRsxIQX2bRr5R0W/XWUeXuwOE7el6T1vpdpOOWN0swO54/yn4cAuVwNVTU26R3kDaXkBM6c7H9xK25EZPTnZumgdDD6kBadwN6oZ7C00DZPDi4ZWwxwtWN55XmNRiX+c3/1s0VV8xPO+BX9YsCrsFxG0poFhj21f5yg7GkA2RSnC9WA5vJ9ZXYyt4a7OYLwnGJi9VzdO6uIKsnOMP0F1tPqyexD8nfHTZmq7iplmGtk73+JtYybFgMHl7/igxHAtq/TTE6Ucw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zy2PXwZArfagM32SktJMqERp8ERK1NJyC9SrpLoObNw=;
 b=nvhavyLRztgsfrbEwytR+rvPWl1RAB/4gsnrT/ZHdWGZiTeOgfao982693Vj83I0sdn5qYDZL2Wpv8QlS8y7E8yA3o+9dTLBA9PfG+RLVKEVTBigsdgyQafQORCaarUqf9uQ6cn4g7ys5znmAzeh1AZApQuA+d/DUyjZQ5b1yGQ=
Received: from SJ2PR07CA0003.namprd07.prod.outlook.com (2603:10b6:a03:505::26)
 by SJ0PR10MB5566.namprd10.prod.outlook.com (2603:10b6:a03:3d0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Fri, 27 Feb
 2026 10:05:28 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:a03:505:cafe::6e) by SJ2PR07CA0003.outlook.office365.com
 (2603:10b6:a03:505::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Fri,
 27 Feb 2026 10:05:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 10:05:25 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 04:05:10 -0600
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 04:05:10 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 27 Feb 2026 04:05:10 -0600
Received: from [172.24.18.150] (ltpw0g6znt.dhcp.ti.com [172.24.18.150])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61RA56tY4043692;
 Fri, 27 Feb 2026 04:05:06 -0600
Message-ID: <d294af17-246e-427f-ae0d-59af249dee96@ti.com>
Date: Fri, 27 Feb 2026 15:35:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 4/4] arm: dts: k3: am62x/am62px: Enable tifs-rm-cfg in
 binman
To: Sparsh Kumar <sparsh-kumar@ti.com>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>, <vigneshr@ti.com>, <praneeth@ti.com>, <bb@ti.com>
CC: <afd@ti.com>, <vishalm@ti.com>, <sebin.francis@ti.com>, <d-gole@ti.com>,
 <a-kaur@ti.com>
References: <20260225132425.3096103-1-sparsh-kumar@ti.com>
 <20260225132425.3096103-5-sparsh-kumar@ti.com>
Content-Language: en-US
From: "Francis, Neha" <n-francis@ti.com>
In-Reply-To: <20260225132425.3096103-5-sparsh-kumar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|SJ0PR10MB5566:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a635da1-27f8-470f-acf2-08de75e7ba87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|34020700016|36860700013; 
X-Microsoft-Antispam-Message-Info: txN9tvE6crlpKxoq8/MnZWbOZ76DySyXsRazCWzTW8yHOgG2BuCSbcZgDQRKYGf8G8AN05+b3BbGTPN3t30HyYDMYpA4+QrynqOvD9+vQk5qry/l/hnrmayq7TLwZP3jvtRng+bsHQEX8/8PDoDLlCPWYCqiY6eygBwELa6gCjFu6cxd4UybXnpIC1ydnM/If6LDc5PN/MyPLyllW2jmudQRmVgu34CaxXni6X1QhbDpUvq6fUG0haac4gCQJkyHfVrsHjczoGMjbE7l00231BQt+VWLOofumdyaNcbba2e8RnVAK5P13gx0QYFO4UubXAPaOeaM65R6fwtiaE+wZYBxcCBfTZHfBTUd/PYk/1mxmLLK/SUQc4CdCu5rdg//PgVMxY5NvHbM+BRb81lKbmT0NkucYQoncQfttEJ4b2TrhLGccAXztLq8kIo5f7/78oJKa+2kC8UU0dmY8yx+BGYYqQXJHYP5/3JirTgQzHaX80PN2honExbg9YcbeesTi3WIpicHvuLRGs8O3Avm07IiAaBC4zJdMYkvpVXf1RVBcI70MCQLe2KyUwjwaRNBKNdpKeq4wJyUurH6HEnDZLXSMwCcsyAWKIkwONnxiLRVJtD5t/faCwdSJf5RJsrkEEoTsKAxC368LQtm0ufubjYgKynIVF5v7g8uL5VChl3ISXmtXd6uOGCulweEATrvE4ultxA52D7uTYE+a4VWciPCWvTZ1N0hzHTNlGPmxFhjzcwATFmA/yfvu5kM8czu4V6FFJkZpB2xx1RCGwuq2n6fk2hzQXuSxsjp8En4roJ00zjGE1i5D3bYXVxNznM+wWyfCIA3UxkpVV5sjGvJgA==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(34020700016)(36860700013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FtW4hOMORUenQKltfgBPI4gmsUoRdQSnwuBHpAY9lep4B1vdg0K5kqFYKFByKJKVI0FlPmH77kaXb+J5EWmGByCst9qJ7nKQNClA/EqH8B27DgUNSyB4feWLpW9jkJQ5mK+5A9mcQpu34GzVh8dUMgXTvhizbsOOurTnvqTXuOfL8J1lNSynl78aEASHcd7H6sK2K78nFiO3su/mEcopQdtyE05ZnAvn3KwGnA0aiMuPk5y0p+P1gm/n47LWdG+Dc3kxjpS9nOOerICZs9xU3LOZhleUJYGNTLhCVNjM2yutsLMoZaMwhThamFSlKGg/JbmvNmSYpdhElcb/o3FOnA9WiHkASyyMBZJ1LKuaO+OAChrJ0R1Ibz5CvvLSIsOtzQyWF/PwDKbT+eOyu912qLyLQ17QCTtoJpQpu5WBr7tANIUqzS5ZwXQnpLbvKYqP
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 10:05:25.9198 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a635da1-27f8-470f-acf2-08de75e7ba87
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5566
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

Oops looks like I replied on an older thread

On 2/25/2026 6:54 PM, Sparsh Kumar wrote:
> Add rcfg_yaml_tifs node override to use tifs-rm-cfg.yaml instead of
> the default rm-cfg.yaml for am625-sk and am62p-sk platforms.
> 
> This enables binman to include the tifs-rm-cfg.yaml configuration
> when building tiboot3 images, bringing these platforms in line with
> other K3 devices like am62a-sk that already use tifs-rm-cfg.yaml.
> 
> This builds on the tifs-rm-cfg files added/updated earlier in this series.
> 
> Signed-off-by: Sparsh Kumar <sparsh-kumar@ti.com>
> ---
>  arch/arm/dts/k3-am625-sk-binman.dtsi | 4 ++++
>  arch/arm/dts/k3-am62p-sk-binman.dtsi | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/arch/arm/dts/k3-am625-sk-binman.dtsi b/arch/arm/dts/k3-am625-sk-binman.dtsi
> index 8d6015e44a9..ba29a047406 100644
> --- a/arch/arm/dts/k3-am625-sk-binman.dtsi
> +++ b/arch/arm/dts/k3-am625-sk-binman.dtsi
> @@ -7,6 +7,10 @@
>  
>  #ifdef CONFIG_TARGET_AM625_R5_EVM
>  
> +&rcfg_yaml_tifs {
> +	config = "tifs-rm-cfg.yaml";
> +};
> +
>  &binman {
>  	tiboot3-am62x-hs-evm.bin {
>  		filename = "tiboot3-am62x-hs-evm.bin";
> diff --git a/arch/arm/dts/k3-am62p-sk-binman.dtsi b/arch/arm/dts/k3-am62p-sk-binman.dtsi
> index 603487341d2..cca56b76d69 100644
> --- a/arch/arm/dts/k3-am62p-sk-binman.dtsi
> +++ b/arch/arm/dts/k3-am62p-sk-binman.dtsi
> @@ -7,6 +7,10 @@
>  
>  #if IS_ENABLED(CONFIG_TARGET_AM62P5_R5_EVM)
>  
> +&rcfg_yaml_tifs {
> +	config = "tifs-rm-cfg.yaml";
> +};
> +
>  &binman {
>  	tiboot3-am62px-hs-fs-evm.bin {
>  		filename = "tiboot3-am62px-hs-fs-evm.bin";

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis

