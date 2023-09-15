Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8E6EE6457
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 11:32:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C36D864EE;
	Fri, 15 Sep 2023 13:32:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FquCC6VV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36BBE86545; Fri, 15 Sep 2023 13:32:27 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::612])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4022864EC
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 13:32:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nzPChS0807akO20lLaycFJaCpZWnoINadt/S/Z7oZUg4a/0ml7WYvTfPjtDKn5TT0QW0++j7b/gH2I2RARxn3Xff/KDCYaCe9Q+IerXirkyOychPIFzQ2NTlU7ce3PEwaS9taHolZ2VHICrb/HBoxSzgRbEY8v0MNE+4mYKx5ZRHOud0P6/9LJ7bHFOLf/mnt2Ydi+30TFNSXBP4HlylZrl0b6Ngx7arhuxpVU0UMLMh3lsf6zMEGHTfXoHiHzs+pWUZSQ4vMYjASDyhYiHWG9Y1OCSxbnLnQhTFBhTxhqk0pTHuaQ8ArSZlcwMo9NlzTnY/J/GoZ5rraFH4DNnJNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55JOODjUODXTF3yCkZsmDMJXpn63EcH1xw/UphH0U4A=;
 b=P/kktk6D2DFNzgfSrOmxDlAZVzYg3biLhi+DpQMf5ZXTWZxTLWo7E1AzGMv47uCOkv/2uW7wUKExmJkJPoW5cqHpO+vsl5i3fT/zj4vWPtFAvNltHTGpTz3y1E3CryASeW0Y78PViT0VkSonrmyp+o8s5h2bWDRVzup/rl/uyBwPD/ibyunAocy/PGIVyFgiCui26VXA+deVTqUi0F+gs4H3Jg2V6sIpwIulzOH3oFS0Jt2dXlZTCB6rgUDrA3lF2AxggxlZqBkLYVWrUxIuJ1/4bEkeSGLL4h3Q1EYIT5LHwd6YMAREG8JuYgg+eotn2kixBQ5B3BbxtYpLYOiSEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=weidmueller.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55JOODjUODXTF3yCkZsmDMJXpn63EcH1xw/UphH0U4A=;
 b=FquCC6VVSyxwX7ASjvko0dAZOrWLWEIyNlKKlIru+DuV6xhJhq5u4PwVUErkbbwEMwRT3dY4jvcyAV7EZDkEQTnJ+KmAQjTfudvxI99X6tBhB4TcSAhWovZWZHEuxz1ohDJ4LfVYZ4ga13qQyucrV1xUfT3ydpfttpYQppvWJRo=
Received: from MW4PR03CA0150.namprd03.prod.outlook.com (2603:10b6:303:8c::35)
 by SN7PR12MB6981.namprd12.prod.outlook.com (2603:10b6:806:263::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.33; Fri, 15 Sep
 2023 11:32:20 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:8c:cafe::f1) by MW4PR03CA0150.outlook.office365.com
 (2603:10b6:303:8c::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 11:32:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023 11:32:18 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 06:32:17 -0500
Message-ID: <4becd24a-125a-4fb3-aebb-c3315f301830@amd.com>
Date: Fri, 15 Sep 2023 13:32:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Corrected pcap_prog register address
Content-Language: en-US
To: <lukas.funke-oss@weidmueller.com>, <u-boot@lists.denx.de>
CC: Lukas Funke <lukas.funke@weidmueller.com>
References: <20230915093901.1062825-1-lukas.funke-oss@weidmueller.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20230915093901.1062825-1-lukas.funke-oss@weidmueller.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|SN7PR12MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: 3de5d4c8-99a3-4781-af79-08dbb5df6b77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u+h2KCPKZSPNwTPxonoWHmxi73tJ+tHZHBrCobFeNQKO5FYs7MD0x0yKXwX9KvABXHxL2ttuKyH8BHqMsS6T7GvpFv9FySDViofmjw4kIBREJ+M+8XvlpcsWznuRuRq6T+HhYoF5qwkZGPdo22a6Nce7CKoQU9saeryvAuni2nbAUuTtZpunjW+LPTkfraeKB0dXmc8g0BY0s4PU8nd7XY4oeStWh4StxgNdRnHeeWm69IqYcbGSC2HwJ8b2wslXILxzRhvlf0NRQZ+jVzW7oC1GunnuPaCDsV4jEr6xmS6rYoKCwzTzP1JHIKubLjQuzj6AvsSTXSlt+ADfWx3cyYVOaPpogDyeHZixPt6cNWt+BKcBjSxMNdbowTzgOFvHaVaWXKdXj5XHujv80TrGPViWfv178NG0UUmTT/pxo3uXCKEzPe1BSXliKyrdUoYWOxrM8ogBRXamTyjsVy7qluiDCJUB7Pmr9N8dUZUvQQVWMu0A04DJXedeAxSYwEuAvoMoPpwUuvOpHLxQaBeHTGcAolUlr0Ggr40l+tMNgw3YA4J0GEZKy8wlqUmdFJVJD+QZzZNXoLqs/R8mqkX4bgEyKCQJ67nMva+/Si5gQ669EkCxyNFVklE0EeFeNDgU+bySzD/h2QioytV3LykQR4X+jRlCltY9JdYiaWf5FzAxVIYobGGih6hymF3Seki3lvP0N2ILRglVBg61Ay0qSMNn7nsWEm5+lPgvjP0VT/advE30hQuKVWAFz01bQ+eSFNcWZFjGsy0RsJWMHqQtBflcanX16eweLPIexcprAJ0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(396003)(39860400002)(136003)(186009)(1800799009)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(70586007)(966005)(316002)(110136005)(16576012)(8676002)(70206006)(36756003)(478600001)(47076005)(26005)(2616005)(356005)(83380400001)(426003)(53546011)(82740400003)(86362001)(31696002)(81166007)(40480700001)(36860700001)(16526019)(40460700003)(2906002)(44832011)(336012)(31686004)(4744005)(41300700001)(5660300002)(8936002)(4326008)(43740500002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 11:32:18.6834 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de5d4c8-99a3-4781-af79-08dbb5df6b77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6981
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



On 9/15/23 11:39, lukas.funke-oss@weidmueller.com wrote:
> From: Lukas Funke <lukas.funke@weidmueller.com>
> 
> Currently the pcap_prog struct variable is pointing to 0x3004 which is
> incorrect according to [1]. The variable should point to 0x3000.
> 
> [1] https://www.xilinx.com/htmldocs/registers/ug1087/ug1087-zynq-ultrascale-registers.html#csu___pcap_prog.html
> 
> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> ---
> 
>   arch/arm/mach-zynqmp/include/mach/hardware.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-zynqmp/include/mach/hardware.h b/arch/arm/mach-zynqmp/include/mach/hardware.h
> index 634bf169c6..8cb6494e52 100644
> --- a/arch/arm/mach-zynqmp/include/mach/hardware.h
> +++ b/arch/arm/mach-zynqmp/include/mach/hardware.h
> @@ -166,7 +166,7 @@ struct csu_regs {
>   	u32 jtag_dap_cfg;
>   	u32 idcode;
>   	u32 version;
> -	u32 reserved2[3055];
> +	u32 reserved2[3054];
>   	u32 pcap_prog;
>   };
>   

Good catch.
Applied.
M
