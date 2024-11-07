Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A9FD5AE60
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 06:06:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BE7B89021;
	Thu,  7 Nov 2024 07:06:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h9rL625U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CB62891BC; Thu,  7 Nov 2024 07:06:02 +0100 (CET)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2406::610])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5137589021
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 07:06:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rtvkuZnX1Sf0Sm+VS/dReETKwSq9mQtYbx2Rkq96+rvfmm3ScZW3FVKRJSElyOihyYcBNVzT744TPdc8Qfr8ytAzFhQxgyhSyS/thxq8yDNFj877lu3BsoNVlrwSMaaf074NqcT7vsZoraW5bXP5DrtBFclzRQUFA7oFT2X45Ju2LkRf1tHQOnnwE2+1z3C9fkzdsuBggK6+rPp86jm+x1Un/ZmqeLhN/zZnZ+fFgbXA/jLPchtE/uZbpRA3FrWP9t+17FAIAmljJKNOW5qPvPeN5Zxu0vIrvUfTYFGFEJSEzWXZ+jPeBaVmFsjPobdfAzdR3R7iizMP+oc3xFwDFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kiogW77h9NP4JY5kbxWFN+ylllsl4IHsirRDI/WhQU=;
 b=Dm9AY9oBs9HPMSwSgNeLw4Xup0bJKj80qblmJHIV0dQd2SKTLjqbh9Z9aqXzb+NfR4EeMH/A2KsN+vY2QY3pwNYZ4OUG8mVmRoOlQDiLx3IYlxFC2IE/d28TzV9da0OiRxKXNlbmdamopkaC7JvNnxCH5op5vBvP63kgCgL5xLBs1cdR5Cuw2FEzsO1ZtvTqpdzMnYRHAdBfL/F7gA9Cm4nWnNdbl73tzDuXxPCl3yv4znZIvbyfvLgDtEv97sGBXl1pcmNffFP/DfJnRDfq2aE++HzYH0ZD1Aqepc6pIhgn/b1MSd4gktox/8ZtYO2YXicTsdgj3k1LIQBhKMTKRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kiogW77h9NP4JY5kbxWFN+ylllsl4IHsirRDI/WhQU=;
 b=h9rL625URMOKrobrO6Xs6n9qUEtY497Nz1Tt0gsCqCkP3SWxU94qQkfGuE4eNuTL81wgfoBeZFTcyw4xBpeMBamQiIb2p4Jj7pkYWsLDYub8WatU/DLF6sZbbFIE8BbMuzd1JqFubq3YF6YRtb3WvTp1iLkvs/BLbHY58BgeG2k=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by CH3PR12MB9022.namprd12.prod.outlook.com (2603:10b6:610:171::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 06:05:53 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%7]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 06:05:53 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "Simek, Michal" <michal.simek@amd.com>, "fabrice.gasnier@foss.st.com"
 <fabrice.gasnier@foss.st.com>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v9 1/7] usb: onboard-hub: Add reset-gpio support
Thread-Topic: [PATCH v9 1/7] usb: onboard-hub: Add reset-gpio support
Thread-Index: AQHbKpcVpfPIrXu5KEqMzJJz4qTDabKpcgUAgAHuzuA=
Date: Thu, 7 Nov 2024 06:05:53 +0000
Message-ID: <SA1PR12MB869760E4493442CBBFFE6D41985C2@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20241030064314.28604-1-venkatesh.abbarapu@amd.com>
 <20241030064314.28604-2-venkatesh.abbarapu@amd.com>
 <1ab82f5b-6e89-4c1d-990e-3936c8ffa489@denx.de>
In-Reply-To: <1ab82f5b-6e89-4c1d-990e-3936c8ffa489@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|CH3PR12MB9022:EE_
x-ms-office365-filtering-correlation-id: 68a1a656-c2b7-4cc0-2835-08dcfef23ce1
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NENpbUpsWUZNK1FFQ1Q1ZVR6SVQwb3VrVnFTdkFOKzNieWlDSHc0eWlUZm5F?=
 =?utf-8?B?Z2ViZXU1M0lZdDNuL3BNbXUrSlNMRlBVa3BsaU1OOUZLNjFpRjBpRHdyNDNH?=
 =?utf-8?B?UktDdHlHc1lLck8ycTB6VGo3Tmh3SlJWdWk1dDdMQnlJVFA1MnFBQkpmbmR0?=
 =?utf-8?B?Y2ZRbmI2Z2laL04xZkRwYzVvNlplVjgvMTRZSmtRcHdsSlcveUMyTG9qdllz?=
 =?utf-8?B?S3ZVN1RMdEVmT2xJdmdGLytseTJiaU85V3lrK0MzcDhVNWh2Vjc1TXplNWpk?=
 =?utf-8?B?Mm1rNzJ6Y01DQUVYRkpaOXFudy9lOWFHalUxbURnT3lpZzlsYnpFbGQ5UmN1?=
 =?utf-8?B?UzFzVzZhRndITGlVczk1Vy9pQko4SW1PSUZqMWNSME9ZSzhkZkVhQXRpaERo?=
 =?utf-8?B?Y1NQcGhoRWFkVHRWTU1YcFdOeFR5TnlBeFlIMWFoeEptcExHTjV1RUFYbzd2?=
 =?utf-8?B?LzMwUUVPTHBGT0w5OWFWR0FRb2oyMG9ROWtEMmdTdlQ0bmo2dlFRVGhTNXFL?=
 =?utf-8?B?aHpPaWFxMGZOQUJpbkI5ZFZCNXVlSnhockpWblZnZUI3cnNHQktGYk9IRGcx?=
 =?utf-8?B?OGlYTlVMTDhaSTdiYXdFVjUrN2hEblRMUEcyeGxZZnJ5ZGlPRWh0TTdUQWwy?=
 =?utf-8?B?elRoTGNsQXF4aWt0K1U4WjhlcVQycUU4ekFzM2ZwUW9US2VFRzd3elkvMkov?=
 =?utf-8?B?ZkxpUXllbGc3bkdDSFRqbW9uS2FzMTcxcHlJWldTVXppdUR3SHNITWgzYlhQ?=
 =?utf-8?B?UU1hUkhIS0FKT2kvRWNOdURiTURacDRKMEczMUo1Vi82ZGh5d2VSOUtxMllr?=
 =?utf-8?B?NjJQY3RDSXJZenpOUmUyNDJKbzlQYmtETEFweGhCbERSb0NtYnZPR245N0px?=
 =?utf-8?B?eHBuWTVSYURteHVreHlUS3hMN3o2L1h1d0ZocTc2MlliMTNOSnphLzdRcld0?=
 =?utf-8?B?Y1krUU5jc1QrMGNpYVdHSEQrUXlJT0NuRndsbGhvLzBpbDdpQTFZZ3lEQnU4?=
 =?utf-8?B?clFaKzdLZlEwdjNZTW9xZWN4cG9DVjBJVFZPN0F6ZVVVcTJQeXlwd25zSW9r?=
 =?utf-8?B?dmowamNOT05hTEd5MWZXd3oxMWZCMS9BR2VyblFteDlyYU1PaDRFYTZXRktC?=
 =?utf-8?B?SmM0Szc1V0FOQThUU3dtd0xjVUlaY3Y5Ull4TUQ1eXJxQ2NmUGh0b3hHdEdj?=
 =?utf-8?B?bzJvUCtDR3pQTzhwV3pYZnBhSWduQlhna2J1Z3dNTVkrUFBma3h4RkN3ZThU?=
 =?utf-8?B?clRvUXVoWnMza3llb1ZyT0lTWGl0M0lzTlhhZHpaN0dKSHA1RlUwdHFjc1Vz?=
 =?utf-8?B?Z0xONElrYys5aTBDenMrZlBuQzlvSUVHQm1mQ1J2UTQybkxYUi8wdEsvRUM0?=
 =?utf-8?B?UFRlaDBVTDIvVVdnTVMrQmZMclRzL05SYWtKZzVBQURvcGxzanU5K1BySzE2?=
 =?utf-8?B?QitXMGx5aVBIakduNDdQeUV2NzBRNyt3dlNNRlpMamwvWlRqUTNocVFxbWRO?=
 =?utf-8?B?MG0yZjYwc0xDSGwrbnJZRlF4S2VjNXF0a3BPN1BRT2RUNEZDTDdRN3dsNUcr?=
 =?utf-8?B?NXdIcW5yNDVqTjNpaWYxSEhzbkkzZTlzSzRIWlBRcUt0WXI4R0gyNmc4QkZ2?=
 =?utf-8?B?Z0N1Z2JPbGJhSVYwcmVjSmM2TWhsQTRMTnJUUnZsa3VvNTJQa1VGK2pKMmdv?=
 =?utf-8?B?LzlhTENnK3NVSCtSU2xFL255WTc2R04zRTQ4ei9XK1ZsWDVOVmh4VFZ3Unlp?=
 =?utf-8?B?cTBkK3dRemJmOEd0TWVJbktxYkM2ME5vTUI1d244bWZIcHNNNmNpTjJwcGgy?=
 =?utf-8?Q?7l7rMRC6e/V1k+CShb7jbCXPWCnQ5HB9eQPLI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFR6NFlacVd0WFgzSWJ3bllYU1hZMFM1ZFVBbVdIVktPay9HSGJqV21Vcy84?=
 =?utf-8?B?c2ZDdXlvV2VyOHNMdUJuemdVUTJrZkVMb2RZS2dTUnBnbVlSWXVnTkJaenkw?=
 =?utf-8?B?WVQ0a2t3blR0QTAvNGRueTNzbXh2RUVCOGgwWlZ5emJ2bU8raGhCS0RmSGJW?=
 =?utf-8?B?WjgwcGFzTkNkQkx2bUN1UkJNUGJVZjViTFdORzg3VzF5c1hKTk1hZmp5YXl2?=
 =?utf-8?B?UFZBZjY3SXdwZVVzMDBxcWpvNGJSd1hFcWsxdFZ4Y2tQU0VTRGZRSk5ka0VJ?=
 =?utf-8?B?c3ZCM0tCZTlSSnpZK2J5Ym4xM2NvWHp4OGh5Uktqdlp1YkJNZUVBcHkyMnRV?=
 =?utf-8?B?NnE4MXhXQUJYd2Flckl0WEF0TG40bXdhZ0NMdUVFdVFHR0xmWlU1dVBGMVZu?=
 =?utf-8?B?NjNHUWlCUktiMTRUMGlxazJtL2JlWStSZmU4dVk3R0ZFcVVUQjhmdmt2eUgw?=
 =?utf-8?B?MmZib0dQRE5xME5EcVlWYTdHcnk4dURLSDBIM1pJUXZ6T1pjeXc5bTlOME5t?=
 =?utf-8?B?R1BMeEdsZDZaOVg2aFZpTFAyY2ZqaEs2SDB5d25GeS8raGh1RUlWUW44TEFq?=
 =?utf-8?B?OXU3cVlrWjRpWGU0N2RvSkxBZHVvSTU5NmVZajhnN0k4cTFnbzVjU2ZnV0gr?=
 =?utf-8?B?bHcxcVhYYk1iTlhvRFUvMk15YkdRU3NuZXhiQUg0Zm83eEVHVHZwS2IxSTdI?=
 =?utf-8?B?UStXZ1ZxOWVJTGlibkJvUTBGSHdaZ1FONis4bVplcVN3bUFJUDV4Z2RxcHk1?=
 =?utf-8?B?MnEvL0dzRHdrTVdwNGtMTUZnb0loVS9HSnVlTktCb05LSDFvS2dydUNydFFL?=
 =?utf-8?B?ZGpuZDVHMVdDbjdLVFJZMWdoeEY5UStjZkdMWTVDYzZrbVF0ZU9LV0hYa1VQ?=
 =?utf-8?B?U2hmdE9acTA2NEVXWEVnaUNnSTdnR3l3b0hUczBOWHJIWlViY1RQTE94TGZV?=
 =?utf-8?B?RHBMd2QxejQvaFRUZmRiRFF4emptb2YxVVF6cXJ1WXRHdlY0UHZXeWl0TkRE?=
 =?utf-8?B?cjdyWSs0OUVMY3BaMUI0RndkUDNUd2FVMk0yOHhDNkI3QlRzUGhLRnRWbUYv?=
 =?utf-8?B?eEVnUk5jYlR2VG1kZVdiSWpoNlhxWVRXSzlzR3Vxa1RqeDlVV1BQQ1pzRUYw?=
 =?utf-8?B?ZDZQY25KQWRBRzRKVzNTL2Z2VDY1VllFMUZvWlJncmpleE9rUE5WanpMejBG?=
 =?utf-8?B?M0V0eXRMRjU2SklYUXNrQk04bVZab1RvbSs5V3UxU0xEV3ZYRlY4cFB1RTdR?=
 =?utf-8?B?NHJWRllKQ0MyUFNVSFZrVXVlNVFjbnJWYnZQL0hzK0ZrQ0JUdkFLUC81QU54?=
 =?utf-8?B?L1VUUXByMVNVR2ZlTEM2Q29MSHNiM2FyS0ZaWVplS2FSYURveTVyNW1iL2F6?=
 =?utf-8?B?aHB4SnBUeHNPUGNTZ2V2bE5FUkNJRmJLbXhreWpqOGZrWXpqSC9NYUVaczRK?=
 =?utf-8?B?dENIcnlTaHgyS3dTdTczNnA0M3BRZlpnbTEwOUpjV0c0VFNRWGNuZGorTURn?=
 =?utf-8?B?VnpxdUV6NWQrQlhjYnpNMHZoNWxtZTZOeHBvT3NTQTZOSGZ0Z0RONmRON1pw?=
 =?utf-8?B?K2FlVmsxc3BncmRCNHNyQ2hkelhrcjdlMlBZaVZCSGJJMWpFQUI2d0xjZkth?=
 =?utf-8?B?a1dpTHFheTBIM0M2cHR6MGVoSEc1bHl3cDI3akZCRXFwclJZS3gxSE9RNEdG?=
 =?utf-8?B?QUNOUEFrTDNYTHBEam13MXp6Njd4a3k0OEU3WFlwZ2lSVmhVcE1RTFpOTWpY?=
 =?utf-8?B?c01rUXhhcEN2ZU5KdkYrZXA1dHRNeXQxSzZMWkRzS1IxOGVCbm54TDNENEV1?=
 =?utf-8?B?aUoza1NIVGhlTVNmbTFuWU1Hck9lK04rWXR5ZzFOME5PSnZRT3Bkckp3aFl5?=
 =?utf-8?B?SkVDRUdTVUlMeHV2d1pIUWh0TGVaQ0I2MFQwbjFJcGZQSTdGN3g2T0xZdEUx?=
 =?utf-8?B?TWhJUEN1S0E2eGQzSjNWTzhHSjFDTEZkaVkrM2RlbXJoYlFEZ1B3TmlSL0x3?=
 =?utf-8?B?ZFpEN1lUS3FLVElwcGVNNHgwV0grYVpFRC9lNEpuZVNmYnQ4MTcrS2FrWEhS?=
 =?utf-8?B?djRnV1ZzRWQ4TFYvY2xwTlVDVk0zSzkxTndzVDJMMjIySGhiWlJxV0FYR05G?=
 =?utf-8?Q?7iTw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a1a656-c2b7-4cc0-2835-08dcfef23ce1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 06:05:53.6189 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R765P4ueE1YK5N/a0QhUZ1A8yBaBJ0j5h3kuUaXPT9fb3tL2zjLUueUCNOeTfybsm32li5BE4ehsK6d9uoXY6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9022
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

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyZWsgVmFzdXQg
PG1hcmV4QGRlbnguZGU+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgNiwgMjAyNCA2OjA0
IEFNDQo+IFRvOiBBYmJhcmFwdSwgVmVua2F0ZXNoIDx2ZW5rYXRlc2guYWJiYXJhcHVAYW1kLmNv
bT47IHUtYm9vdEBsaXN0cy5kZW54LmRlDQo+IENjOiBTaW1laywgTWljaGFsIDxtaWNoYWwuc2lt
ZWtAYW1kLmNvbT47IGZhYnJpY2UuZ2FzbmllckBmb3NzLnN0LmNvbTsgZ2l0DQo+IChBTUQtWGls
aW54KSA8Z2l0QGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjkgMS83XSB1c2I6IG9u
Ym9hcmQtaHViOiBBZGQgcmVzZXQtZ3BpbyBzdXBwb3J0DQo+IA0KPiBPbiAxMC8zMC8yNCA3OjQz
IEFNLCBWZW5rYXRlc2ggWWFkYXYgQWJiYXJhcHUgd3JvdGU6DQo+ID4gQXMgcGFydCBvZiB0aGUg
cmVzZXQsIHNldHMgdGhlIGRpcmVjdGlvbiBvZiB0aGUgcGluIHRvIG91dHB1dCBiZWZvcmUNCj4g
PiB0b2dnbGluZyB0aGUgcGluLiBEZWxheSBvZiBtaWxsaXNlY29uZCBpcyBhZGRlZCBpbiBiZXR3
ZWVuIGxvdyBhbmQNCj4gPiBoaWdoIHRvIG1lZXQgdGhlIHNldHVwIGFuZCBob2xkIHRpbWUgcmVx
dWlyZW1lbnQgb2YgdGhlIHJlc2V0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogVmVua2F0ZXNo
IFlhZGF2IEFiYmFyYXB1IDx2ZW5rYXRlc2guYWJiYXJhcHVAYW1kLmNvbT4NCj4gPiBSZXZpZXdl
ZC1ieTogTWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+DQo+ID4gLS0tDQo+ID4gICBjb21tb24v
dXNiX29uYm9hcmRfaHViLmMgfCA0Mg0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKystDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNDEgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2NvbW1vbi91c2Jfb25ib2FyZF9odWIuYyBi
L2NvbW1vbi91c2Jfb25ib2FyZF9odWIuYyBpbmRleA0KPiA+IDY4YTA0YWMwNDEuLjQxNzQ1NzU4
OTMgMTAwNjQ0DQo+ID4gLS0tIGEvY29tbW9uL3VzYl9vbmJvYXJkX2h1Yi5jDQo+ID4gKysrIGIv
Y29tbW9uL3VzYl9vbmJvYXJkX2h1Yi5jDQo+ID4gQEAgLTcsMTQgKzcsNTEgQEANCj4gPiAgICAq
IE1vc3RseSBpbnNwaXJlZCBieSBMaW51eCBrZXJuZWwgdjYuMSBvbmJvYXJkX3VzYl9odWIgZHJp
dmVyDQo+ID4gICAgKi8NCj4gPg0KPiA+ICsjaW5jbHVkZSA8YXNtL2dwaW8uaD4NCj4gPiAgICNp
bmNsdWRlIDxkbS5oPg0KPiA+ICAgI2luY2x1ZGUgPGRtL2RldmljZV9jb21wYXQuaD4NCj4gPiAr
I2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+DQo+ID4gICAjaW5jbHVkZSA8cG93ZXIvcmVndWxhdG9y
Lmg+DQo+ID4NCj4gPiAgIHN0cnVjdCBvbmJvYXJkX2h1YiB7DQo+ID4gICAJc3RydWN0IHVkZXZp
Y2UgKnZkZDsNCj4gPiArCXN0cnVjdCBncGlvX2Rlc2MgKnJlc2V0X2dwaW87DQo+ID4gICB9Ow0K
PiA+DQo+ID4gK3N0cnVjdCBvbmJvYXJkX2h1Yl9kYXRhIHsNCj4gPiArCXVuc2lnbmVkIGxvbmcg
cmVzZXRfdXM7DQo+ID4gKwl1bnNpZ25lZCBsb25nIHBvd2VyX29uX2RlbGF5X3VzOw0KPiA+ICt9
Ow0KPiA+ICsNCj4gPiAraW50IHVzYl9vbmJvYXJkX2h1Yl9yZXNldChzdHJ1Y3QgdWRldmljZSAq
ZGV2KSB7DQo+ID4gKwlzdHJ1Y3Qgb25ib2FyZF9odWJfZGF0YSAqZGF0YSA9DQo+ID4gKwkJKHN0
cnVjdCBvbmJvYXJkX2h1Yl9kYXRhICopZGV2X2dldF9kcml2ZXJfZGF0YShkZXYpOw0KPiA+ICsJ
c3RydWN0IG9uYm9hcmRfaHViICpodWIgPSBkZXZfZ2V0X3ByaXYoZGV2KTsNCj4gPiArCWludCBy
ZXQ7DQo+ID4gKw0KPiA+ICsJaHViLT5yZXNldF9ncGlvID0gZGV2bV9ncGlvZF9nZXRfb3B0aW9u
YWwoZGV2LCAicmVzZXQiLA0KPiA+ICsJCQkJCQkgIEdQSU9EX0lTX09VVCB8DQo+IEdQSU9EX0FD
VElWRV9MT1cpOw0KPiBJcyB0aGUgcmVzZXQgR1BJTyBhbHdheXMgYWN0aXZlIGxvdyBvciBzaG91
bGQgdGhpcyByZXNwZWN0IHRoZSBHUElPIGZsYWdzIGluIERUDQo+IGluc3RlYWQgPw0KWWVzLi4u
dGhlIHJlc2V0IEdQSU8gaXMgYWx3YXlzIGFjdGl2ZSBsb3cuDQoNClRoYW5rcw0KVmVua2F0ZXNo
DQo=
