Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1435FFED2C4
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 03:31:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1580283FBC;
	Thu, 12 Mar 2026 04:31:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uTH/t2TO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63A2183FED; Thu, 12 Mar 2026 04:31:31 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DB598352B
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 04:31:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zLKklGBgz9/9n13EtKxi5v0ojW1xq7rS5iax6wA1bT5vIqvWb5G1esAZ29djfKPXApBesUEzRzAT+Oxw9S65fEpDFVjyHW4vKovF8K2vDF/WTvrDw62lQ6PglOqcuR6Xxl454YhHBfkNMVnUxg0reQsJhmuDKcYQJoqocBZEWfgLux8j5AOGMfhzyNww1vtV5JFnhHf07FSXLA9XPlgKIY7THAN1SRz5yu914daJ25n/UR3vEJdFdOGkU3P/Kt5dCY9sJJEkEew8NkjKTaVvjdC9h+9fc5yN0BQMJzZV9BqvKg/I8XzPSuzHf8j+KKDkLL3NFonKElK8EjMyFVHDzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmoE8lTdUPB9+Ctka0MmkwwRbTqwoEWr+y8OoQJ5zz0=;
 b=QbKICdXPOOjKTDPTpbDBBuv26eiWL7cmlUAwWzleV4Il6VdXmXuWq6686/vfiuTaIwxVNNCpqu+uyzXgJGzWBtDu9AXtiN/k5nJ0E0IVqmIW5Jq3maGXAZIIGuyUWzuwInpi85xvVgKY4tGhnvaGgBdPagRHqo6WlBZYRGuB9cP/Lqm0riqTVv+yKQQq6Xtai5o8cr7S5QldubYOl4TxfazeXhULu0Y4ALFFIObEUcF33VE1q3/ptYNHUi/VUHMrHCZI26B19vtw2s4/3REJl2OIOHjM9zZvAdDIIEOztWqNtCGQdX0EEoIW83fqyiWJrucphPkH3xnWzB5Qjrdg2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=toradex.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmoE8lTdUPB9+Ctka0MmkwwRbTqwoEWr+y8OoQJ5zz0=;
 b=uTH/t2TOurqTP7ZPIndtod8PT5kgB5ORLynUqUpXcd46qNXMETEBUAKDFGZMA+Z8jrA4FuXds8euWHNUDi3sD3vmbK5Z618oJACj4sFy4tBUhfXsj64/O5BsKbL8zPc/5XCMfLSrT/V29PjrI97m9agiJGXilz68wF3QJ1wvAdk=
Received: from BY1P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::6)
 by SN4PR10MB5654.namprd10.prod.outlook.com (2603:10b6:806:20d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.13; Thu, 12 Mar
 2026 03:31:25 +0000
Received: from MWH0EPF000C6188.namprd02.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::7e) by BY1P220CA0017.outlook.office365.com
 (2603:10b6:a03:5c3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Thu,
 12 Mar 2026 03:31:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MWH0EPF000C6188.mail.protection.outlook.com (10.167.249.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 03:31:24 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 22:31:15 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 22:31:15 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Mar 2026 22:31:15 -0500
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62C3VESU1563027;
 Wed, 11 Mar 2026 22:31:15 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 12 Mar 2026 09:01:14 +0530
Message-ID: <DH0HIS3XKGZQ.34HE6IPZACBKW@ti.com>
CC: Tom Rini <trini@konsulko.com>, Suhaas Joshi <s-joshi@ti.com>, "Neha Malcom
 Francis" <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Bryan Brattlof
 <bb@ti.com>, Dhruva Gole <d-gole@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Daniel Schultz <d.schultz@phytec.de>,
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>
Subject: Re: [PATCH next v2] arm: mach-k3: use Kconfig options for ATF/OPTEE
 size
From: Anshul Dalal <anshuld@ti.com>
To: "Chawdhry, Manorit" <m-chawdhry@ti.com>, Anshul Dalal <anshuld@ti.com>,
 <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260311-tfa_tee_addr_kconfig_refactor-v2-1-d66bbdb36a3e@ti.com>
 <186dd71f-e329-40d3-88d2-5a4dc811acb8@ti.com>
In-Reply-To: <186dd71f-e329-40d3-88d2-5a4dc811acb8@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6188:EE_|SN4PR10MB5654:EE_
X-MS-Office365-Filtering-Correlation-Id: cd315141-5f30-4d7f-8d55-08de7fe7d697
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: xu/6jQHOvN3z225142MkkWXWCsLHxRaU8F+FmgLlHfuZYa2Cmj3EV9zfQb2LorbnbsjhZDYGAgLMDKBEbFpp/iwEA1vmax949xZ6bpU6duI/bC1inbtYPz6BQuQ8JJVpgFBPvklFYifD9WTtEr8lZY5uO0W+KQrUMvHRgKfJF4NMfmXk3QNA69X2yAl5hw61uWkCUJPFfE1SwHh04J2DO1UZESY4gXu8TyN5sKHZEMrkYKVM5+5LwNjrAOS/n+s45ecl+y60epA9q+QU85Cwy/ZGaxVrW2zU+Xz4ERVwHn9fzQjBO+dl7WB6vBoRkpoU8fKcizXnPykGu4O93QZoUkISHnB6+nsGlSYA3neBOqs4x0z1RZ2Wji+FmimCjFAIQZlrZe8r7dO+hjqatNkxeBFXjpEWEYuAiOUMFM+Dx/ch49GuXTsVdEz5j0agSPFRSYPMqN+eoRUqFeD84vZDjvBqjoL8D3AWzdVXgGb7gSjqSKjI4FT1LcO0/94+vOfVeXPbR3m4EplvV9nAlXothkMFb+zV8qtjpV8l+GDIWqMwdILrTDS3uG5JQmxbtzOd1tmSk50rGZzaE7ThP+pb9XOw/hR7jOiS5t2ZoPiYj3084H241eIFEd6cT6oat8UtAyTB5F4zv/b1ACCYcSW7akO+3qHo5dE8HWpgBzklPsh2jSP5AZnW77ZpKDkRlqgvMnP/ZRQvGJJ+Y2JBI9LMkWX0hUytPtz5o7dYM4ZL2yDvcfaFONbBr5xGIn5RCVZdt45EN3yGmgwiiuo46quWfA==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vU7moFEYYcu018f1FHxsf3Z6Zo5otQ+I6sJDu7WpFSJp3NrJo/O0e4CVDwwnIaEVUYU7BfENAE4trg+IawYTQXquoVfxiMe1vLXMVI2rz6qFa1HpvyDUVUs8B6SzMk4gMynAGO9zP+IZHNIdYWS01wMqI0XTTPzq6AwhYkapZAWUjmCcAcCrqTwJ9OHqltAOwEnEY55C4+/pN8X19E2Njs8uGtnTiZmzTcy2PS1AWh3a6Lfdv78iLjzfp4Y/Mggx94Cj1xeVSL3+f9Z9XskoGzUt+XRk2lDZ7QDTawK2r46b6KkHk8tEd7qxtOm90d/iEYViBCPlQ4x7Pn0zwgyYj96KypkWziDGj8tbC5vRSJkoM7RdSpKh+BYcNbfigaWmuY5Sw0Z9UDMMpX9h1EuMBCdhIZXX56WfPquwhuzC07VL9oi6bhAAjd+57yK3e6RH
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 03:31:24.6241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd315141-5f30-4d7f-8d55-08de7fe7d697
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6188.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5654
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

On Wed Mar 11, 2026 at 10:52 PM IST, Manorit Chawdhry wrote:
> Hi Anshul,
>
> On 3/11/2026 5:42 PM, Anshul Dalal wrote:
>> The reserved memory sizes for ATF and OPTEE were hard-coded for K3
>> devices, this patch replaces them with a Kconfig option allowing for
>> easier modifications.
>>
>> Acked-by: Andrew Davis <afd@ti.com>
>> Reviewed-by: Dhruva Gole <d-gole@ti.com>
>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>> ---
>> Changes in v2:
>> - Update help text to mention firewall configuration
>> - Pick R/Ack-by tags
>> - Link to v1: https://lore.kernel.org/r/20260310-tfa_tee_addr_kconfig_re=
factor-v1-1-d24abbca82ee@ti.com
>> ---
>>   arch/arm/dts/k3-binman.dtsi   |  4 ++--
>>   arch/arm/mach-k3/Kconfig      | 17 +++++++++++++++++
>>   arch/arm/mach-k3/common_fdt.c |  5 +++--
>>   3 files changed, 22 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
>> index 0fd93f9536a..ad127663d03 100644
>> --- a/arch/arm/dts/k3-binman.dtsi
>> +++ b/arch/arm/dts/k3-binman.dtsi
>> @@ -477,7 +477,7 @@
>>   						FWPERM_SECURE_PRIV_RWCD |
>>   						FWPERM_SECURE_USER_RWCD)>;
>>   		start_address =3D <0x0 CONFIG_K3_ATF_LOAD_ADDR>;
>> -		end_address =3D <0x0 (CONFIG_K3_ATF_LOAD_ADDR + 0x1ffff)>;
>> +		end_address =3D <0x0 (CONFIG_K3_ATF_LOAD_ADDR + CONFIG_K3_ATF_RESERVE=
D_SIZE - 1)>;
>>   	};
>>   	firewall_armv8_optee_fg: template-8 {
>>   		control =3D <(FWCTRL_EN | FWCTRL_LOCK |
>> @@ -486,7 +486,7 @@
>>   						FWPERM_SECURE_PRIV_RWCD |
>>   						FWPERM_SECURE_USER_RWCD)>;
>>   		start_address =3D <0x0 CONFIG_K3_OPTEE_LOAD_ADDR>;
>> -		end_address =3D <0x0 (CONFIG_K3_OPTEE_LOAD_ADDR + 0x17fffff)>;
>> +		end_address =3D <0x0 (CONFIG_K3_OPTEE_LOAD_ADDR + CONFIG_K3_OPTEE_RES=
ERVED_SIZE - 1)>;
>>   	};
>>  =20
>>   	ti_falcon_template: template-9 {
>> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
>> index 1b8c0b1eb96..e7ef35ed2cd 100644
>> --- a/arch/arm/mach-k3/Kconfig
>> +++ b/arch/arm/mach-k3/Kconfig
>> @@ -130,6 +130,15 @@ config K3_ATF_LOAD_ADDR
>>   	  The load address for the ATF image. This value is used to build the
>>   	  FIT image header that places ATF in memory where it will run.
>>  =20
>> +config K3_ATF_RESERVED_SIZE
>> +	hex "Reserved DDR size for ATF"
>
> Not every device has ATF running through DDR, maybe keeping it generic=20
> might be good like "memory size"
>

Good catch, I'll incorporate it in the next revision.

Thanks for the review,
Anshul

>> +	default 0x80000 if (SOC_K3_AM625 || SOC_K3_AM62A7 || SOC_K3_AM62P5 || =
SOC_K3_J722S)
>> +	default 0x20000
>> +	help
>> +	  The runtime DDR size reserved for ATF. This value is used to fixup t=
he
> Same here
>> +	  kernel device-tree's reserved-memory node for ATF and configure the
>> +	  firewall.
>> +
>>   config K3_OPTEE_LOAD_ADDR
>>   	hex "Load address of OPTEE image"
>>   	default 0x9e800000
>> @@ -137,6 +146,14 @@ config K3_OPTEE_LOAD_ADDR
>>   	  The load address for the OPTEE image. This value defaults to 0x9e80=
0000
>>   	  if not provided in the board defconfig file.
>>  =20
>> +config K3_OPTEE_RESERVED_SIZE
>> +	hex "Reserved DDR size for OPTEE"
>> +	default 0x1800000
>> +	help
>> +	  The runtime DDR size reserved for OPTEE. This value is used to fixup=
 the
>> +	  kernel device-tree's reserved-memory node for OPTEE and configure th=
e
>> +	  firewall.
>> +
>>   config K3_DM_FW
>>   	bool "Separate DM firmware image"
>>   	depends on CPU_V7R && !SOC_K3_AM642 && !SOC_K3_AM654 && !CLK_TI_SCI &=
& !TI_SCI_POWER_DOMAIN
>> diff --git a/arch/arm/mach-k3/common_fdt.c b/arch/arm/mach-k3/common_fdt=
.c
>> index cb0fb8274a5..39cb00c3f43 100644
>> --- a/arch/arm/mach-k3/common_fdt.c
>> +++ b/arch/arm/mach-k3/common_fdt.c
>> @@ -173,12 +173,13 @@ int fdt_fixup_reserved(void *blob)
>>   	int ret;
>>  =20
>>   	ret =3D fdt_fixup_reserved_memory(blob, "tfa", CONFIG_K3_ATF_LOAD_ADD=
R,
>> -					0x80000);
>> +					CONFIG_K3_ATF_RESERVED_SIZE);
>>   	if (ret)
>>   		return ret;
>>  =20
>>   	return fdt_fixup_reserved_memory(blob, "optee",
>> -					 CONFIG_K3_OPTEE_LOAD_ADDR, 0x1800000);
>> +					 CONFIG_K3_OPTEE_LOAD_ADDR,
>> +					 CONFIG_K3_OPTEE_RESERVED_SIZE);
>>   }
>>  =20
>>   static int fdt_fixup_critical_trips(void *blob, int zoneoffset, int ma=
xc)
>>
>> ---
>> base-commit: 8bc2a5196c1c0bb5dbdaca073323da0015a0de37
>> change-id: 20260310-tfa_tee_addr_kconfig_refactor-2bf77949df0f
>>
>> Best regards,
>
> With that addressed,
>
> Reviewed-by: Manorit Chawdhry <m-chawdhry@ti.com>
>
> Regards,
> Manorit

