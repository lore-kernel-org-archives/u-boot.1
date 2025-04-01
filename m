Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD5AC36014
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 13:22:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7015C8211F;
	Tue,  1 Apr 2025 15:22:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZBPmOMYu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C5B982139; Tue,  1 Apr 2025 15:22:48 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::614])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66A738210E
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 15:22:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8V6OCMFNJrNNxUzVRk9FKjbwONe2twIuaZpu3bFBWi+BLQdMbSfWTzxITJW54E9RNz89f6TCn9ori+AAiFNErLnoReYiKl8ZjaDkJ/pJjMCcS3dVYViVeI9MtA7JGsYuu8rbUYCS1yKZUjSbaJbCLn8TfbRM3DdI1KT3+A2jLPEEn5UXw8HVH172b69SZrwNo8nGykAOWrVQ5rVgkyuM//IhvekohDa4/IupAtD+DyPFNbtx2CFvICg+T2or4zxnCYrdMfik7ofUAT86lu/077VSksOKjS6B1xumr5R38IDWgrLsqdyRS6pWb+YlH4HRSl8IgglazXiEABt55tQog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yp6i2xb8VyQmse47WfRqayXieEjL8OC47PUgseqZ05k=;
 b=OshRlyDjG2Vs1vepohjeFvp1uSaEkoIbCB1x2+2Aoft/lCnH+mC8Y5sHYIhmwxZUf40dsd2cnWNfUlyhAO20TVEAZQsGZlOOK86dXdNGP5yn1f+omWUt9PoL93dEsyNHe5SeT3apXiI3DLgvPlEFCzJi77g0IGvpUp5O2WkcRfya5QYcJkaQIgsSuQcX8biaM9FNawUVKoiUyHayccpfz877dJv0dFrsPJPI4oMUhowFkY8pRNJnDAiPP2GXmcNwW7/zknVnvCVfFz9JJFHyHsn2X4b9oMqFXL3aRm2ZN0mi6sG9SLRZIsk7EOED/C9EGEUYotG/QgvdiLs/hIbuRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yp6i2xb8VyQmse47WfRqayXieEjL8OC47PUgseqZ05k=;
 b=ZBPmOMYuhMvn4orecSxnpjmACyGSwcvibkLg7GFJ17YtAw+fiZLPTPZ0cS6BEqGl/mDTp0CvXsgIv8tFK/GTqCnTKm5Ol2Kkw76FTaiRvrkw1QqKq/Fqc0b1x/WuWfDK4cho5viqBog/311tcZ7qlYX9pHWcofh12r0XD0xHhDTx7mQ81ARmOJWN18mljmOs91Yjqyj9L50jvhvGLIeKSjlC+74WxkZwdCsUD3itKYiQpXa/0qBzaJBfm21YHwt1kxamUd+w2gbSuMtZ6La5rIv6B7twCOdJ9PvDM4KqzInJzKA+8pLl3jYlPMHgvGyrKIIqhT87t6a7vugpIvr7sg==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU0PR04MB9370.eurprd04.prod.outlook.com (2603:10a6:10:359::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 13:22:43 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8534.043; Tue, 1 Apr 2025
 13:22:41 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marex@denx.de>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>
CC: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Simon
 Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>, dl-uboot-imx
 <uboot-imx@nxp.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo
 <alice.guo@nxp.com>, =?utf-8?B?TG90aGFyIFdhw59tYW5u?=
 <LW@karo-electronics.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, Ye Li <ye.li@nxp.com>,
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSCB2OCAwMi8xOV0gcGluY3RybDogbnhw?=
 =?utf-8?B?OiBhZGQgYSBwaW4gY29udHJvbGxlciBkcml2ZXIgYmFzZWQgb24gU0NNSSBw?=
 =?utf-8?Q?in_control_protocol?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjggMDIvMTldIHBpbmN0cmw6IG54cDogYWRkIGEg?=
 =?utf-8?B?cGluIGNvbnRyb2xsZXIgZHJpdmVyIGJhc2VkIG9uIFNDTUkgcGluIGNvbnRy?=
 =?utf-8?Q?ol_protocol?=
Thread-Index: AQHbmjEZPZpAH2ZEOUK/fGtZCzozwLN+Uy8AgAUx/ACAASH9AIAAB9UAgAATGYCAAD4KAIACAPkAgAe0UQCAACA8AIAAB4sw
Date: Tue, 1 Apr 2025 13:22:41 +0000
Message-ID: <PAXPR04MB9644421AD7D6DAE73C98BF3DE2AC2@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
 <20250321-imx95-v1-2-f2c8ba815f89@oss.nxp.com>
 <a180b7e6-6978-4814-97ff-05e34223938f@denx.de>
 <20250325080614.GC27303@nxa18884-linux>
 <a84f63fb-61c2-4f0e-89ed-8046e8eeed85@denx.de>
 <PAXPR04MB8459808C7CC6C16DB43B973388A62@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <bc232085-3efb-43fb-b176-eaf43e52f1f8@denx.de>
 <PAXPR04MB8459F46041C7EFF7191F8EFD88A62@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <bbb8ecca-789d-40cc-93a8-e7284e1af840@denx.de>
 <PAXPR04MB96445CAACB6E8413A03CA386E2AC2@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <a3007174-30a8-4dc2-ab7f-da1c1de52440@denx.de>
In-Reply-To: <a3007174-30a8-4dc2-ab7f-da1c1de52440@denx.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|DU0PR04MB9370:EE_
x-ms-office365-filtering-correlation-id: 217b3670-5649-4333-b133-08dd712047ba
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bEhhQ1pzY3c4RktZaWFZaFlmaVVqdmVSTkxrbjFUVTkrek9xUGE1ZEpuTFFs?=
 =?utf-8?B?dnhON3dvUW5tWFprNGMvUWxlUHNnZTRYTTlrRzFtZVVLem0vd0Q3U1loeW5J?=
 =?utf-8?B?TExxdHhmYzQ0VEExVFpsRHhkSlF5ZkdQR2lJdWRlRmJ3cytIdHdIekIvaGEx?=
 =?utf-8?B?aHhwWEJ5K2E2b011VzhvSTBhWC8yYmM3UU1weDdXWXRyeUNhN0piOEsyMG40?=
 =?utf-8?B?OWlpQ0doODFBUi9yOWVvMEY2SVZPd3g4ZDE1R2YxcGJ6SG5aUTZObE05RVZ2?=
 =?utf-8?B?WU1nbFRVMlZVdnFONWdsTGxqN2RpWFQwNzYyNisyUUc0ZkxWTkNHUjNmMzZS?=
 =?utf-8?B?UUFnR3pPbExWRnJac0FEaWZ0ek1nMER0Nm9YN21FRE5TQWYxQzYrZTNWQnlv?=
 =?utf-8?B?S3Bqakp6b2F3QTlmOFNZTGk1OGxNNnVBS2tuREhYVDR2cnUwd1FkMGpvTHZO?=
 =?utf-8?B?NWdoYTZsZGFnemlhTEhxMU9yRi9XTk51ZWFCcy9JK2drWFpLcHZ1ZnlSYTQ0?=
 =?utf-8?B?SnRIbitmc1dFVVp3UDVjYnc4VkN0bnoyT2xqNk1iZjZ3WjVJNS9yWEU0bmto?=
 =?utf-8?B?c1F3Rlhtc1JGZ0IwbkdBQ2hmeEZxMXBGbFZSKytKK29kbERaMzJ2MHdSemt2?=
 =?utf-8?B?MWxzQitxZnl6RFJ6Q2V0eldyMW9LWEFwaUh0K09HZ1laeldpTGlSTkZNMER2?=
 =?utf-8?B?cjNKWHo5dTl6UHhGQVFzYlpsUTZDb0FrNFhlMzhpTUJDemllSFdCbDlycnRn?=
 =?utf-8?B?b3l0VTBSem9mVWVJVEFHVEQ4bDhobG5jVFhBZE1jKzFCcmlVSzJwQmd2U0Fm?=
 =?utf-8?B?V0xEZFM3RGZCM3l0ZGVSZ1RYYkoxRlBmdGU0Ym1NTzRoVW9Hb3hiSU43cWxi?=
 =?utf-8?B?YVNrckZXZDdYQkVrMTM1NW9ZaDBzYlNQMENJS1JLbklEOEtLaVNFSHFGV3dz?=
 =?utf-8?B?MFRycGJhOXJ3VGw5cW50WUNYaDkyUGpBMExITWtNSmFBRlAyeGoxM0MyZjM4?=
 =?utf-8?B?Qm1lVFhseU9uLzFCWFl6ZldjUTNJSVhTdXJvR2ZFWDZrVWY1VG5kOGd1MVpa?=
 =?utf-8?B?MzdLRXg1TWNsZFpCSWlXVy9vWDNrRE9CUEtucExFSVpUd2hnLyt6UGJnU1Zu?=
 =?utf-8?B?V3NZVFRDcTdYU0J1MVBpUmIvOTViNXg1WlR5M0FQWEhrT29LUG4xaVRFdHNM?=
 =?utf-8?B?eVdYaENqMWNTRXpjNm1YaGRTeFpHMzM5SzZZSjF4ekgyTGdaQkJEb2ZOWTJG?=
 =?utf-8?B?ZHVzU2JJZkE3TTNjc21yZE5WbTkzMDJNbXBnUDByOXhCQS9PV3dYamxqK1Vj?=
 =?utf-8?B?VFo3VUY1WFU0UFR0L3IrV0U4SG5MekM5Mkx5a1lDVGNoaFRGU2VzT0dxeHNV?=
 =?utf-8?B?NEN2WGRFSHBrN3NaSThEb1lHaC9GVjdUQ0pQdEZxNVVzVmNlOVppZkd3QWVB?=
 =?utf-8?B?TytsNEZWVVBkZnFsZFFGaThiSStQWW90dHlwWjRvQnNOVzZZQllDZU5qUVFU?=
 =?utf-8?B?WEZSd1pyVGhrSUlIL2haR2NBYUwzLzFvTWQydFpjMXJHTVUvUDY5bDlCcG5j?=
 =?utf-8?B?VXlva1o5cTd6SzNYTUxsYnk2TVJCZ24yV3RHOXhtc2NNVnBybUN0cXBUdTdT?=
 =?utf-8?B?NjE2TG5BZk1YdHlUWHdZSzVGMC9zN1RsZkRaenRBTTBlNThvb3NUY0RDZGs4?=
 =?utf-8?B?SzNiamd0K1FxdTJ5Vmt5SGZRY1NWZTQxS2lzcjVOWE5HTTVOWktFRm1HTTRi?=
 =?utf-8?B?WW5iVEV0Tld4OVY1d3pPdERlbUYwSWhMTDVsMENaZU05TU4zVDA1bVNVOXBL?=
 =?utf-8?B?WFZEdVU1bE9UczNrT2xTcXVxendKbUFaUERxQzNadzNsTnBYR291bHE1MENV?=
 =?utf-8?Q?+YSVKXL5Q3qhI?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UG1ZTVR4WkZlRjJtZ0FpUHVDb08xQWlOanBQcFUyMWVDSDFpc0hCYVNwbHFJ?=
 =?utf-8?B?cmJIa1pDTFYxWDhvWU9Ob2RwQmlkT2xZZmM3dGRVQXlvL1doQTlzZDczYVpi?=
 =?utf-8?B?aFdnYm5WWjJzU0RzUnloVUw1YkFsaG13cDMrQzZTUExyRXpYbUFGMHhSd0ZR?=
 =?utf-8?B?ck11aW5BWVhYczdoNzI1azIzZXd3UFpGNlZ2TTc3ODFWb2dYbmRmVXVlVUxY?=
 =?utf-8?B?MmtEWnpKc0JDeVQ2WnJRcFEyTW9wY1hYTDNnNTNXN1FuTFBRWDFZcDhraW9y?=
 =?utf-8?B?MStoM1JlRjdLdmhva2UvNWEwdWhLcTVjZHVyczkreGJUN1BDYU5vK0wxZnNT?=
 =?utf-8?B?U1JueExLZ2hoaFY5WkRJZTdTMldxcWViUm1zS1daMEZhWkI5TUEvT0RlTEMx?=
 =?utf-8?B?K2JWcFFiKys2TDMrMDNORnpnQ2FMbEhSNHd5TEJEQUdOMUNKcG96ZWxyYUl0?=
 =?utf-8?B?THdSN1JvczBnMU9sN2EzZ0ZjaUI5VWhyWlVnc2haMzcrTy9WS1Y3cExKYTRr?=
 =?utf-8?B?dm1iR1BKZnBZVXRlVXdXSUNUdWsrR3hobU13aHVtQzRuRllEMUZaY1IvZ2FS?=
 =?utf-8?B?RGhuR2dGVlRzdy90M0RvTWVDbVArRU44K0d4cCtaRCtsNkRIcnFXKzNDTUdB?=
 =?utf-8?B?MjhSejBYR05uMHdBRU5tTys3VGVObVg5QTBpSERPZ080MVZEaXpZVm1jcFp2?=
 =?utf-8?B?UDZQdE9nb0ZXYXFZY0pHZmhSTEVubEUvTkZjdU92dG4rUWw2bXdST1pLaHNM?=
 =?utf-8?B?VDVkcXpDdEFxUWk2Vy8zbFpUQ0xxVnowQm9Xd1BVZ3VWN1dtU1hFeFN1SW5p?=
 =?utf-8?B?YWtuNkU4Qlc2RHhXa0RGV043Rnc4TlY0cWxycTFvcERwRkVPRjNMK3NlRkk1?=
 =?utf-8?B?YVZBRmhCRG4xUy9XU2JxOGx5dDlFcnE1MUJTMUR6U0x3UFF2aDRWM0VKVnRG?=
 =?utf-8?B?TDIvM1lDSEU3ejBiL2JnTmd2OUkxVlNNRVQrVGhlUlMxd1dCMzFUaU9tVDR1?=
 =?utf-8?B?a3BWUGJ2NlhveHJUMDJSaU4zOEd5dGVSWTVGbzNqUlFlN0pYUER6RVVpcWE3?=
 =?utf-8?B?R0s3RkVvSzRodHJ4VmNuRk1vZ3hadUdrU1VqY096VTVFUGtsR1V4RW1PZjl1?=
 =?utf-8?B?L3owREJYN0ZyR3ErUWo1YkRuNjRMRWg4akxuRGkvMkhsclQ1aWtaVmx1K1pZ?=
 =?utf-8?B?Mk1jREVBZG1aOGFuUWs1UmdYU3ZTeStmOUVOanN6NHBCVys5R1BleWJRc0sr?=
 =?utf-8?B?NWd5a0hPUkpJT1JmVExjNXBwWHZ1ekQ1RFhsdDRzZkpHandKdHk4djgvRWlO?=
 =?utf-8?B?TWtFMjNBck5XSWtyS2FlZkI3aHk1Ni9OSThRajNERjk0c0Z0VTRSV3dtMDhP?=
 =?utf-8?B?WEVnSmFOMnhGYU1pTGZpdFUwUTNxMTBiWmpMeURrZUxMVzFSc241YWR0djBH?=
 =?utf-8?B?V2hKUUFCQ3dFYk9MKzJaeVFEY2NCSHNIT1hxdG14RHM5STVsRzFiVjZzMDZ4?=
 =?utf-8?B?eWpLR2MxRWNOUDFBUmJwOXJ6bWx6dy9oVlVqcHlZV2JZYSs1N09vQmkzOWRY?=
 =?utf-8?B?M21vQ0VhY0k1TFZoUWVQaWxqYmVvL2h4OFZUTU8rSHM1S3JWYkxOS2RNMG03?=
 =?utf-8?B?YWhGRi91ejhnMDNKNEVNYTBYMkFZYWIwb05qdXNNUlc5WkMwTEZMMXkwaVJG?=
 =?utf-8?B?NTZ5cjBzZURLVkNpYmpZRDNqc2hkSkpqWXg0WXI3WWlnV2hEYk5LelduamFl?=
 =?utf-8?B?cmZXQnRhS3FNUFFZYlFhMWVjcXpRR3AxcmVBc1AyWHF4dGUvNHVITkg5by9y?=
 =?utf-8?B?aGxERnRxL251b3pwcXRMeWZjRGJISExSSjNLaGd1ODBjZldKbmVzbVJhTzEx?=
 =?utf-8?B?OFp1TllMdGlxR2ZtQStUSFpSRFBnYUIvZjBZUDUxQU55T3d0aFRDSXlxM3Z2?=
 =?utf-8?B?QTJqYkYyY3F3R1FkNGswQUVTU1BMeHd5RWVJenZRWk5iS2huZ1BOUkxQOE9I?=
 =?utf-8?B?QXhURUQxTzJMUUJnVXJ1YWJXa0hzNFFTZXBMeUtPZ2dxOC9wN0tZYmFadDlQ?=
 =?utf-8?B?VFo3ODJBdko1SzIxTSs3Y3cwam9MNjhaNDUwVUZrcUFiUWt4SGVmRDZmZVhP?=
 =?utf-8?Q?36r8zOXA+Pf33iBIZw14LU2lC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 217b3670-5649-4333-b133-08dd712047ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2025 13:22:41.2332 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WpO6LRL33lYCsGr+t6ru/tskaaiks5vYnr237WUvbgQtZ3RgrSIKz5ZI5fIORdg1dWL8vyhuE5JjbkG08RCdcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9370
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogTWFyZWsgVmFzdXQgPG1hcmV4
QGRlbnguZGU+DQo+IOWPkemAgeaXtumXtDogMjAyNeW5tDTmnIgx5pelIDIwOjUzDQo+IOaUtuS7
tuS6ujogQWxpY2UgR3VvIChPU1MpIDxhbGljZS5ndW9Ab3NzLm54cC5jb20+OyBGYWJpbyBFc3Rl
dmFtDQo+IDxmZXN0ZXZhbUBnbWFpbC5jb20+OyBUb20gUmluaSA8dHJpbmlAa29uc3Vsa28uY29t
Pg0KPiDmioTpgIE6IEx1a2FzeiBNYWpld3NraSA8bHVrbWFAZGVueC5kZT47IFNlYW4gQW5kZXJz
b24NCj4gPHNlYW5nYTJAZ21haWwuY29tPjsgU2ltb24gR2xhc3MgPHNqZ0BjaHJvbWl1bS5vcmc+
OyBQZW5nIEZhbg0KPiA8cGVuZy5mYW5AbnhwLmNvbT47IGRsLXVib290LWlteCA8dWJvb3QtaW14
QG54cC5jb20+OyBBbHBlciBOZWJpIFlhc2FrDQo+IDxhbHBlcm5lYml5YXNha0BnbWFpbC5jb20+
OyBBbGljZSBHdW8gPGFsaWNlLmd1b0BueHAuY29tPjsgTG90aGFyDQo+IFdhw59tYW5uIDxMV0Br
YXJvLWVsZWN0cm9uaWNzLmRlPjsgdS1ib290QGxpc3RzLmRlbnguZGU7IFJhbmphbmkNCj4gVmFp
ZHlhbmF0aGFuIDxyYW5qYW5pLnZhaWR5YW5hdGhhbkBueHAuY29tPjsgWWUgTGkgPHllLmxpQG54
cC5jb20+OyBQZW5nDQo+IEZhbiAoT1NTKSA8cGVuZy5mYW5Ab3NzLm54cC5jb20+DQo+IOS4u+mi
mDogUmU6IOWbnuWkjTogW1BBVENIIHY4IDAyLzE5XSBwaW5jdHJsOiBueHA6IGFkZCBhIHBpbiBj
b250cm9sbGVyIGRyaXZlcg0KPiBiYXNlZCBvbiBTQ01JIHBpbiBjb250cm9sIHByb3RvY29sDQo+
IA0KPiBPbiA0LzEvMjUgMTI6NTcgUE0sIEFsaWNlIEd1byAoT1NTKSB3cm90ZToNCj4gDQo+IEhl
bGxvIEFsaWNlLA0KPiANCj4gPj4+Pj4gQm90aCB1c2Ugc2FtZSBJRCAweDE5Lg0KPiA+Pj4+Pg0K
PiA+Pj4+PiBJdCBpcyBmaW5lIHRvIHVzZSBiZWxvdywgaWYgaXQgaXMgZmluZSB0byB5b3UuDQo+
ID4+Pj4+IFNDTUlfUFJPVE9DT0xfSURfUElOQ1RSTF9JTVggPSAweDE5Lg0KPiA+Pj4+IEhvdyBk
b2VzIHRoZSBrZXJuZWwgZGlzY2VybiB3aGljaCBkcml2ZXIgaXQgc2hvdWxkIHVzZSB0bw0KPiA+
Pj4+IGNvbW11bmljYXRlIHdpdGggdGhlIFNDTUkgcHJvdmlkZXIgaWYgYm90aCBkcml2ZXJzIGFy
ZSBjb21waWxlZCBpbnRvDQo+IHRoZSBrZXJuZWwgPw0KPiA+Pj4NCj4gPj4+IFRoZXJlIGlzIGEg
Y2hlY2sgaW4gZHJpdmVycyBwcm9iZS4gT25seSBvbmUgd2lsbCBzdWNjZWVkLg0KPiA+Pg0KPiA+
PiBJIGhhdmUgdG8gYWRtaXQsIHRoaXMgaXMganVzdCAuLi4gdWhoaCA6KA0KPiA+Pg0KPiA+PiBC
dXQgSSB0aGluayBub3csIHdlIHNob3VsZCBhbHNvIGhhdmUgYSBkcml2ZXItc2lkZSBjaGVjayBh
bmQgdHdvDQo+ID4+IHNlcGFyYXRlIGRyaXZlcnMsIHNpbWlsYXIgdG8gdGhpcyBwYXRjaDoNCj4g
Pj4NCj4gPj4gW1BBVENIXSBwb3dlcjogcmVndWxhdG9yOiBzY21pOiBNb3ZlIHJlZ3VsYXRvciBz
dWJub2RlIGhhY2sgdG8NCj4gPj4gc2NtaV9yZWd1bGF0b3INCj4gPg0KPiA+IEhpIE1hcmVrLA0K
PiA+DQo+ID4gV2hlbiB3aWxsIHRoaXMgcGF0Y2ggIltQQVRDSF0gcG93ZXI6IHJlZ3VsYXRvcjog
c2NtaTogTW92ZSByZWd1bGF0b3INCj4gc3Vibm9kZSBoYWNrIHRvIHNjbWlfcmVndWxhdG9yIiBi
ZSBhcHBsaWVkIHRvIHRoZSB1Ym9vdCBuZXh0IGJyYW5jaD8gSSBoYXZlDQo+IGFscmVhZHkgbWFk
ZSB0aGUgbmV4dCB2ZXJzaW9uIHBhdGNoIHNldCBiYXNlZCBvbiB0aGlzIHBhdGNoLg0KPiBGYWJp
by9Ub20gPw0KDQpVLUJvb3Qgc291cmNlIGNvZGUgSSB1c2VkIGlzIGNsb25lZCBieSBnaXQgY2xv
bmUgaHR0cHM6Ly9zb3VyY2UuZGVueC5kZS91LWJvb3QvdS1ib290LmdpdA0K
