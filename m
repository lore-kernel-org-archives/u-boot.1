Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9223CA0FE6
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 06:32:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4793B8679F;
	Fri,  1 Sep 2023 08:32:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2KKh7NnJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0B2C86564; Fri,  1 Sep 2023 08:32:12 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::61b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3806D867A0
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 08:32:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNN8As75NReckhbtCxLiW0PTOZ9ZxyZNkCHsX4ohBCE+3Ku9fNdgNF32kxmQsofI3+nS9LTxFJvoJ/QiAa8//K3m8NqcxHRhrd0F4fTt5TgzUgAl+EAY8gT+MgWZP76ORl8dmOUA+sBph0ZB+0vm6D4B0cxz52XiiqufcRgMUXvMRXOcxOkfwmW/6XEhdrHbDiPqYPb8XTRwHwals3K44Tk+kqeN12qu1SqrIliNIyjDt+iqcZed15tJaEKnkqTRdgvdOHtwmu8vqCjUtQXC85zVeCSVWQZbeRKUUtDrStRp4Rw7n4ZzZvNpStUf2Qqag0ebWCC64oA20DI5AIDPGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qV9CgKnwx4BuKuqoY9VlsuQfY/6gq+mo04es38ApEGQ=;
 b=HZCv9GwiV/GAj9P8b97uAIV1r1gib/nhHfilmItmQrqCdwpS0bpC6mkaefleo0QEa0rDBAimjpNG/5kVC5zBMC1Np6vjrTbt+ERD4GoHF1TKm/YZ7dG+ODY8MBx/p6EcQu5WYl6k8JMi84grDjhpxdoc1SeQM5AGBt/iohPbaclLWbsq3IUyIMDlF7m3t4rc7qmE1b9pdratZiAwnEQqsXY+wohacX9aqomgKfAoFiDY9PCCAniUeFsXH5AggBAa9OW/uAZxZndDiGv32+sIskihWY4Q7rC4ROm/N/ASQ6EVH3h8Hltg3XCO8cyrBvDVrSbAtJ0QKCofN05VYyuM+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qV9CgKnwx4BuKuqoY9VlsuQfY/6gq+mo04es38ApEGQ=;
 b=2KKh7NnJG2IW29Ugryv0rReflQp+4Y/M62p1Wo4wZEkn84TPJSnnTxTHMeHjPSor//7YDC/tWpYden09n1zAAnrJkY4H63o7PNWsjsa6Xx4yo3AnP6bW9gtabSAcLjlXwT3zAf3Q/Te+QpvD9oVxVi7pjByZn+XMiwWD0Do7+50=
Received: from BYAPR03CA0014.namprd03.prod.outlook.com (2603:10b6:a02:a8::27)
 by PH0PR12MB5631.namprd12.prod.outlook.com (2603:10b6:510:144::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Fri, 1 Sep
 2023 06:32:06 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::6) by BYAPR03CA0014.outlook.office365.com
 (2603:10b6:a02:a8::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.23 via Frontend
 Transport; Fri, 1 Sep 2023 06:32:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Fri, 1 Sep 2023 06:32:06 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 1 Sep
 2023 01:32:04 -0500
Message-ID: <f2827380-e79e-3ad6-7b2c-31514153331c@amd.com>
Date: Fri, 1 Sep 2023 08:32:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] arm64: zynqmp: Setup default si570 frequency to 156.25MHz
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
References: <c052ddf39e392e97f87f1c57ea06f3508733c672.1692947486.git.michal.simek@amd.com>
In-Reply-To: <c052ddf39e392e97f87f1c57ea06f3508733c672.1692947486.git.michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|PH0PR12MB5631:EE_
X-MS-Office365-Filtering-Correlation-Id: 78505fee-a6d8-4482-744e-08dbaab52970
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MDEafM4H69uHr8N8p8tXBOPU3Ormr7uyYRhvhNiM2h2Ttk7Rp4eo2pDslB9DgGIisxJvVjoDE9tdo3NktbeIShrLrvrWAOaaMqEpQEjUFPrebBUWiBIBIMMwxirpVlEE7Q3QtAqzH9R0F4AlmqLHga9u80Sl3zDK4zbKdJNi4neLh1Hwyus8UadhUXm7tVzAqnIZPp6upiSKwofW4mh0b+4TNDpFpVVg4Aw0yD2TomZWFPeyU8/xUiMoO6gdUm/3PWLglMJHORP3ZEqfbM8jh93FYan92yCjXWioUsomNeIIUsF1Y+N2P1SxPxb28Bdd83A35jsJPr3NZQMD82WpOOPz2DrkBHIQRMlUwjWYyXETmnhwxgUaXlNMwblOkMscoVkq9DyRpt04qALQ+qr9TFn3td6JU0l/WKWHrfX8HdfvvIkRbSc2DDrSt30cxr4zy0mM+kLW/VU/g9ejsoDJ7NkGtliyPrdjqulrVYGgt+kKvXVb2UUO+o/VUkrwnTfCse8iQDO1FJFj0hhCJiwJcF6aHiHAxA1Ob6RBUL3frw9mit2lBHz+NKv/+vkcvdfev5BoXjZDJ9SsOsX4zcOtgIAQ9IRFT53U6Xnv85zddzu5bfzJInxLjxfaYIwBwNa0acOw0drRuuR9ukwd8iwaCtOTRJEhPlpCLwwDnvzUrH/IZZVaI9qZLrmStcWPRNxZRB+D453YK2YvEuTpOgL0S2EVTnrlARJyoaGonAzf6EDD5lXvcquAKLdMLtceSkObbJIRTnfA5RSklFdaO/PkrJhBb6l8WdNjYSF+FDzk1pfS0NHud46tJbgVgbJDrnPS
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199024)(1800799009)(186009)(82310400011)(40470700004)(46966006)(36840700001)(31696002)(53546011)(110136005)(2616005)(40480700001)(8936002)(5660300002)(70206006)(86362001)(41300700001)(70586007)(316002)(16576012)(36756003)(8676002)(44832011)(40460700003)(2906002)(356005)(83380400001)(82740400003)(478600001)(81166007)(36860700001)(47076005)(26005)(426003)(336012)(31686004)(16526019)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 06:32:06.2689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78505fee-a6d8-4482-744e-08dbaab52970
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5631
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



On 8/25/23 09:11, Michal Simek wrote:
> All si570 mgt chips have factory default 156.25MHz but DT changed it to
> 148.5MHz. After tracking it is pretty much c&p fault taken from Zynq
> zc702/zc706 boards where 148.5MHz was setup as default because it was
> requirement for AD7511 chip available on these boards.
> ZynqMP board don't contain this chip that's why factory default frequency
> can be used.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp-zcu102-revA.dts | 2 +-
>   arch/arm/dts/zynqmp-zcu106-revA.dts | 2 +-
>   arch/arm/dts/zynqmp-zcu208-revA.dts | 2 +-
>   arch/arm/dts/zynqmp-zcu216-revA.dts | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/dts/zynqmp-zcu102-revA.dts b/arch/arm/dts/zynqmp-zcu102-revA.dts
> index 79d67c495dee..0f7230b9526e 100644
> --- a/arch/arm/dts/zynqmp-zcu102-revA.dts
> +++ b/arch/arm/dts/zynqmp-zcu102-revA.dts
> @@ -602,7 +602,7 @@
>   				reg = <0x5d>;
>   				temperature-stability = <50>; /* copy from zc702 */
>   				factory-fout = <156250000>;
> -				clock-frequency = <148500000>;
> +				clock-frequency = <156250000>;
>   				clock-output-names = "si570_mgt";
>   			};
>   		};
> diff --git a/arch/arm/dts/zynqmp-zcu106-revA.dts b/arch/arm/dts/zynqmp-zcu106-revA.dts
> index 7a8094a16b79..f8019c592a7f 100644
> --- a/arch/arm/dts/zynqmp-zcu106-revA.dts
> +++ b/arch/arm/dts/zynqmp-zcu106-revA.dts
> @@ -592,7 +592,7 @@
>   				reg = <0x5d>;
>   				temperature-stability = <50>; /* copy from zc702 */
>   				factory-fout = <156250000>;
> -				clock-frequency = <148500000>;
> +				clock-frequency = <156250000>;
>   				clock-output-names = "si570_mgt";
>   			};
>   		};
> diff --git a/arch/arm/dts/zynqmp-zcu208-revA.dts b/arch/arm/dts/zynqmp-zcu208-revA.dts
> index 9b3ae67bff12..0c1f50943ac0 100644
> --- a/arch/arm/dts/zynqmp-zcu208-revA.dts
> +++ b/arch/arm/dts/zynqmp-zcu208-revA.dts
> @@ -489,7 +489,7 @@
>   				reg = <0x5d>;
>   				temperature-stability = <50>;
>   				factory-fout = <156250000>;
> -				clock-frequency = <148500000>;
> +				clock-frequency = <156250000>;
>   				clock-output-names = "si570_mgt";
>   			};
>   		};
> diff --git a/arch/arm/dts/zynqmp-zcu216-revA.dts b/arch/arm/dts/zynqmp-zcu216-revA.dts
> index 43eeaec5b15b..8ca01f01a3ab 100644
> --- a/arch/arm/dts/zynqmp-zcu216-revA.dts
> +++ b/arch/arm/dts/zynqmp-zcu216-revA.dts
> @@ -499,7 +499,7 @@
>   				reg = <0x5d>;
>   				temperature-stability = <50>;
>   				factory-fout = <156250000>;
> -				clock-frequency = <148500000>;
> +				clock-frequency = <156250000>;
>   				clock-output-names = "si570_mgt";
>   			};
>   		};

Applied.
M
