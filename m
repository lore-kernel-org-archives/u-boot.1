Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A98EB28F4
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 08:51:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAA638382A;
	Fri,  6 Feb 2026 09:51:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Qq1ehoCr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47CC383AA7; Fri,  6 Feb 2026 09:51:54 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84868836D3
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 09:51:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=inN8FwccjkOk5EMjaJbIhDiMxDPDVj9igm2pWAQrGjlUsjw0Cnh+W6aHek6btcoOaecI4rQMQxvMa03FnPHMDztwXApDdOC3zd3KZC9YTxryC7EWSZww61x/vNtDKqXKF9R3sCLRYG7N767BDum0CWhbG9LPsT4ZUhOadl510j/evcXEy0h5EqVL3G2mVdOM6vCDYOQWLpN4pusGWJ8c3QlNM/yTeZsntLBuVU0rVHKFFdI2NwfS54A3nM4Ws/AhxRP6mBP5MarJ/mrGJJinQQGJNpxdz1ByA33DDbjjUknON25g1Qxt8GCschFTMmu3myu207xnxogsMzUR/sPY7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODwYXWkFBCI04Zq6JrJdr3mu2KaJwgyXLgcu9hPrMhw=;
 b=ShSA6UmvGKcFlKRvcVh8f8LTZQ+KPd0iBNhurjdx61154TFAhp6blfQ92nI8UZ4QcZEhi7WHEiWfkE/UhJEioDO6om+P0/F4c8aQJi3rPAL0yJ50UE0mMglzTbSnALAp6PzpO+boj4lwA6NkEKg3/GPkxC5SjnWd8pr8RO4w+972xYEDYSesk96kwQfFIoFi7FNs0GJ7HWQvRAhmQCQ5yMb1mW0qwBwX/JYgp1c3C5MyGICiaeKosBcn+bMcn9IfHrboLHXNTB+7AAv9t3GxOjsbilgihqvTSXVlCf1toec8/Ryk7iHhK26LsJYgwATh8NUEFN/fNOz/nHSmMV7vkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODwYXWkFBCI04Zq6JrJdr3mu2KaJwgyXLgcu9hPrMhw=;
 b=Qq1ehoCrXE65GP5cYBCdqK7QxxHumUWxVhcM1L8n2DYv2v+Pc6bpFIFEAWJISKJMOGlSmqagGEdURhqHzWVuBpRDzT+793MUKgTNZJK9ls5oHnXQQeB+AGNHAW2b8nB+8Nr5ZPrLku7fokblGKO/zxC89+i9fVaiRwPG70SHyGw=
Received: from SJ0PR03CA0164.namprd03.prod.outlook.com (2603:10b6:a03:338::19)
 by BL3PR10MB6235.namprd10.prod.outlook.com (2603:10b6:208:38e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 08:51:49 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::9f) by SJ0PR03CA0164.outlook.office365.com
 (2603:10b6:a03:338::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Fri,
 6 Feb 2026 08:51:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 08:51:48 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 02:51:47 -0600
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 02:51:47 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 6 Feb 2026 02:51:47 -0600
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6168pjYb920035;
 Fri, 6 Feb 2026 02:51:46 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 6 Feb 2026 14:21:45 +0530
Message-ID: <DG7R1O5LCYFC.1KC2KEH9FBYV4@ti.com>
From: Anshul Dalal <anshuld@ti.com>
To: Bryan Brattlof <bb@ti.com>, Anshul Dalal <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, Vignesh Raghavendra <vigneshr@ti.com>, Tom Rini
 <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>, "Mattijs
 Korpershoek" <mkorpershoek@kernel.org>, "Guillaume La Roque (TI.com)"
 <glaroque@baylibre.com>, Jonathan Humphreys <j-humphreys@ti.com>, "Sam
 Protsenko" <semen.protsenko@linaro.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Martyn Welch <martyn.welch@collabora.com>,
 Dhruva Gole <d-gole@ti.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] board: ti: am64,j721*: use correct fdt if eeprom
 detection fails
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260203-eeprom_fdt_detection_refactor-v1-1-276eecbbe398@ti.com>
 <20260203141322.kkqgyp4jtdfomz3e@bryanbrattlof.com>
In-Reply-To: <20260203141322.kkqgyp4jtdfomz3e@bryanbrattlof.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|BL3PR10MB6235:EE_
X-MS-Office365-Filtering-Correlation-Id: 13ae213c-98a6-4559-ba14-08de655cf6ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QnZma3pRdTJLT3dNenVLWDNUKzlXcVdlNXdRU01GdjhWTnF1TjhWMkdBc1d6?=
 =?utf-8?B?cHRvayttalpFMlBzdWY3YVJxWTBhb3pBWnVTeDBQUmZ4MEQ0bG04WHIwY21H?=
 =?utf-8?B?cG1WWFpQSmY1THBYZVFsQVN4aGlIVHV0dmpQWlFkUWRMTWlXczVNRmprdnpC?=
 =?utf-8?B?K3JORklQbkh3Z1V3NkU3RmZuNEFWNlZSaFBEbE1yWEJSdXROVnRsbVl4WHRJ?=
 =?utf-8?B?S1hHemxVeXJsU1Y5Q09PbVZtWkkyVE9UY2lNYVcvckNPZGpaaFhJdC96Vjc0?=
 =?utf-8?B?TENoSExWNzNuTmFzMUVrZTQ5cEJCcnRLLzFUNFhFa1ZRYU96eGhNNmpKNHVl?=
 =?utf-8?B?dHNqR2RLN0FEWG1Rb09veWRPbkt1d1FUYUNhUE16QnFzdHlvSzdEcVJsMW5Q?=
 =?utf-8?B?L0haeUFjaUhJWU00WXZZeklFZmpFcWhOdXpHRUwwVFRyVkN3OFRqamNHY1Vz?=
 =?utf-8?B?ZFNBc1NiMjBEYUpCUUVBcFlnZVIwMm9LN2ljWVQrdTM0aVdSU3ZPR2VmTVFB?=
 =?utf-8?B?Mm93UHpUQUlESUkvMWZJci9lZU5MeDRhNHhBSDloSm12UHE2amF0eC9aTjA4?=
 =?utf-8?B?VTJ5cC9sSFFGanlDblpDZ0R0djBjK3UyS1FyUXFHMTdicnJralNvTTFhbGpT?=
 =?utf-8?B?ZUZEMVlXQzhyb2ZFM01IaUZRMjl3YXVnQks1Qk1yNFZwMndaaTBnZDFxNk5y?=
 =?utf-8?B?VWlXL2U2RnNqTyswWEpxSUs3VXBRZGV6TGcvQkxQTDhRTDRKcS9KR0g0SW5U?=
 =?utf-8?B?QUFHY0ZCVDhwQ1YrdnZ5ME5WRWRGTzVuUHByNnA2TDVXL2JtaXY3bWkyRnVm?=
 =?utf-8?B?RlBnbUo1VW94NzY5ZHpxRkwzUHJzbFNRZ0Z5Rk5MMmttT0VqZ3k5alFRcXpF?=
 =?utf-8?B?M0J3M2ZnVW4zd2M3RGJWcm9xdUhQaFFlYjd2anQrcVVRN1B1UUNHVkNIeEtr?=
 =?utf-8?B?VndTeFhOQ3lsZ0gvZVRMclVXTUdQTVBqUGk1elNwcUxuZzNJWVNVRWV1c29q?=
 =?utf-8?B?TEFOMEF2UjU3bjAwbVV0OWlKRDU1clNsK0w0QWVOMFNoQXhWcldPYU5KN21V?=
 =?utf-8?B?WEprY3BoaGtJQlphUEhBVHc1S2N2UHNuMmxVYmIwYnFxYkVSN3B3MFkxeHQx?=
 =?utf-8?B?OWVHTzl5Q2tjcXJ6d1FkMUZSZ1Y3Z0xKZzZuZUdSejd0cUtBaHM2YUVDMENW?=
 =?utf-8?B?bVZ5TUVLSXNmS2FvYU1NQ0lGcW9iRm4rZnhXRGhKZG55U0loSk5qaHlBeW5x?=
 =?utf-8?B?OFpteDJ2Ykx6TnBwS1ZmdUNtM1Z4TzQzT1pQOVJmSWp6anF5c3ZBci9PeDVj?=
 =?utf-8?B?QjlZOUVoUEJYRVBvMjRCWGcxZTJuUEgvd0YwS0VWT2piOW4xT3FzWlNKdFBP?=
 =?utf-8?B?Vkw1U3lmcHpYdUhlTkE3L2RlNWhTVlJRSCt5eDQvSEtsSEJZYkx4QitWS3Bl?=
 =?utf-8?B?Ulk0anZYMDlCcmROM0ZmcW1HTjhKRkV6bncweG1xYWloSFk3N0l0WExTZSt6?=
 =?utf-8?B?TVc4cmpiM1lYYnYzUmFWL0VNYTQzcWc5S2k5dTJ5eVh0VytpRGR4dDRramFv?=
 =?utf-8?B?MHpRVmlCYlFqYWNjZk5MVjVhcUVXYTQ1dUp0S1EvdWpVOGk0M1cvUTRYamVK?=
 =?utf-8?B?QVJ2QWVGREQ1TUt5UGxsWndONGg0aXUrN2VrL0xBZGRSQUVhditIYmlwaXVU?=
 =?utf-8?B?NkRNQThXVUtyVUx6b2ZmQThYZG9mYjBqNmMyVG1JWGdiTVh4RnN6UFg0V0dw?=
 =?utf-8?B?QkFoUjBZSWZjY1dpdHJZMkFRSnAyUnp5OHJtUVRvVzNEaENwUGloS0hDbDh5?=
 =?utf-8?B?bUEzcnQyZkFNVzI0ZHpXOFgySFFpN2VLcmxsb05wUGllTXJtVGR6Si9BN3dt?=
 =?utf-8?B?eHBwK2paMWtnSmNGd1pKNnNINHZ1VWJpL3Q5eXF0VVB2QllIRFZzK1c4LzFn?=
 =?utf-8?B?Q1RIb3FyL1hVWm5ReXVxRUNEZUkzWWtyMmVSSUE5eXZpc1FKNVJIQytTa1FW?=
 =?utf-8?B?MUhKZ2ZhRWJwN2RPZU00OWRXSVd5cWVqVWxGUDZDaDFkSExoRWNSVFlKTkta?=
 =?utf-8?B?SVFKZ2hvUUpIbU1pWGRPRERjdE4wYW9ELy80Zjg3V0hhaHVvcmRjamdrSlI3?=
 =?utf-8?B?VTQvTitVMTd6ZXVqd0JENHlxVm9KeXBwR0tNampBakNmTDV4T0NNbXFPbU5k?=
 =?utf-8?B?N0R0VWZ5dGthZFlDU1ZxSHMwclRwUFhLK0I0NmV4aFlmS2VUWVJCK3NzVVlm?=
 =?utf-8?B?N0VzYXZ0N3MwUVR0aHo1bFo3djl3PT0=?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WmL+MjgllvuGgTfZkvFYAcEhApAc7qPotWQ4rudjb/WpXVxOFMsiVGLTHHEBfV11YFU8w1aXFJkyutEgrlsb4QfGc+h0AFw/uP/SMA+nyzlJyq6S7VFujP+wfMslz2UmnJR3hsR11+cgEANK3LjBSLXx7u9KOqIcATMB43wk/uPMimCi5FutmPBzJsnPkjZ2KD4/WCpaGdXIIjELM8yh7fX6KrlsJAgNCcjpxzAy5IPA8Y5pcK5pf1i6DOH/IdkfiicO4px2NFqxBdGIYvl6iKZpTSwSDl0xt3qnzQTCAv7XfViy0o0AU0tUh6gHn84oVloinh60ILU8bAjHPpes7HR7Zr9b23Sjc0YOGYM287qul6zqix92FJQIOUwrxMXAgjxuX6VYO3zOutuFGL6MGD0/4Whw5N5XDdqmeq1FuaBrCC8IFwnobWtCeh7esBqa
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 08:51:48.5969 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ae213c-98a6-4559-ba14-08de655cf6ec
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6235
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

On Tue Feb 3, 2026 at 7:43 PM IST, Bryan Brattlof wrote:
> On February  3, 2026 thus sayeth Anshul Dalal:
>> We currently provide default board names for each board in their
>> respective evm.c file. However for custom boards, this behaviour
>> overwrites the default DT as set in the defconfig
>> (CONFIG_DEFAULT_FDT_FILE or CONFIG_DEFAULT_DEVICE_TREE).
>
> Are people using the TI_I2C_BOARD_DETECT logic on their custom boards?

Users are expected to not use TI_I2C_BOARD_DETECT for custom boards but
the correct behaviour should be to fallback to what's configured in the
.config regardless.

>
>>=20
>> This patch changes the default name to be NULL which prevents this
>> overwrite and allows ti_set_fdt_env to instead fallback to the correct
>> DT as set in Kconfig.
>>=20
>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>> ---
>>  board/ti/am64x/evm.c  | 2 +-
>>  board/ti/j721e/evm.c  | 2 +-
>>  board/ti/j721s2/evm.c | 2 +-
>>  3 files changed, 3 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/board/ti/am64x/evm.c b/board/ti/am64x/evm.c
>> index 25076a8a588..c6ddc44d14c 100644
>> --- a/board/ti/am64x/evm.c
>> +++ b/board/ti/am64x/evm.c
>> @@ -138,7 +138,7 @@ static struct ti_fdt_map ti_am64_evm_fdt_map[] =3D {
>> =20
>>  static void setup_board_eeprom_env(void)
>>  {
>> -	char *name =3D "am64x_gpevm";
>> +	char *name =3D NULL;
>
> Would it make sense to add this default to the else case?
>

I assume you're suggesting something like the following:

	diff --git a/board/ti/am64x/evm.c b/board/ti/am64x/evm.c
	index 25076a8a588..7d59e5c376c 100644
	--- a/board/ti/am64x/evm.c
	+++ b/board/ti/am64x/evm.c
	@@ -147,9 +147,11 @@ static void setup_board_eeprom_env(void)
			name =3D "am64x_gpevm";
		else if (board_is_am64x_skevm())
			name =3D "am64x_skevm";
	-       else
	+       else {
	+               name =3D NULL;
			printf("Unidentified board claims %s in eeprom header\n",
			       board_ti_get_name());
	+       }

	 invalid_eeprom:
		set_board_info_env_am6(name);


We could do so but it would be functionally identical except for the
cases where do_board_detect fails and we still fallback to presuming a
GP board.

> If I understand the problem correctly we still get the benefit of the=20
> default for boards we don't have a match for in eeprom but if=20
> do_board_detect() fails we pass the NULL to ti_set_fdt_env()?
>

IMO passing NULL to set_board_info_env_am6 and especially ti_set_fdt_env
is the correct behavior here as my patch originally intends to.

For set_board_info_env_am6, it ensures the "board_name" in env is set to
"unknown" instead of the default GP board which might not be correct.
And for ti_set_fdt_env it allows the user to specify the DT from .config
instead of having to modify ti_fdt_map.

> ~Bryan

