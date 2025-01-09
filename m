Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E05E77188
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 02:24:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D37AF80690;
	Thu,  9 Jan 2025 03:23:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bPklqxP1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96F78805EA; Thu,  9 Jan 2025 03:23:32 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::61e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 991BD8066C
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 03:23:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ogMPG3av/7MTti4HfFb6smz6BqK/jwG8xkEd2d6Ag6rGzQ5Hn0gYY9Wph71XAj6HCnWRBiPOJSKODETsieWIiRkWNqWjM0YlH1HPeLI1oQia7SrzRLlfEyJUNqbUs6REPU8SdekY8VRGV8b6Iljz+zYyxMQ+xsxDecPp8X02QpQw6HclmJSn3paRVJ2oZdQZetNgSwM6ebz3IL6iBeax8njB0i2L+eHr0Z7wsNewW5CTCYy95XrxfVxB4TDrKiaKaWdnPsHhh7SM5e3vtMJLDNybbbL0U+L9kb68st+A0nNIYzCLvbZINKU49dTpFLo126c3QAJe2ZuB+WDmk3Ugjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YEB9ihrqm9PJDnbh3dm3neenJHjfYtnY2UOZrdQ6No=;
 b=D22tF6JUk/3dgOQda+HC4vtNW8ecJjEkX6d+Jy2+6MaHC/SCo1xB1T1VdiaqZTt/cHgrlzAyJManQdlDxektbYL2HkE+zDROR3u8tNJBwytHKTrSQdv5Ws3dnVbNG/pSnN1ALxjj3wJuasTEi3N9kfEKxF9vfXBSO1F0g/HCw//zPIV20L0neEfyDSQJ7iWagAbn6OKiJI2fDzujXS4F/0qoJJ+MEEeSiH9Zxi1dO4t3YSLqb8VgnnPfqdDITuUCEMUn4OsiURkl2jlcXQkNb/xjAJTD0aDfD16w4DBwZueFITTkPCZPHX5O5m4ddMwjxQsaJzAbYuGbz/9/G7JNgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YEB9ihrqm9PJDnbh3dm3neenJHjfYtnY2UOZrdQ6No=;
 b=bPklqxP1Gnp0j6/inRoQovD/u1hCTimUp2WRa+83iIWXetx7+J7EBnz3ExY3dWni53P0ppGV7vQuompv+zZprFpuiczcuBOEzKBqlDI2OegdBEo68FVdAsDBcHxCnW2uPrAKH9GuOEEir4mY+lpe2ipSRCdiC3ENLr/NHcEZZCX0N0o5McE3wfLuDWxMLLdMRzTvIXK4c3YryuC+vZoU196DskgFofv8ARTtAoew6Fy1btWEeEchR7kfEh9UImLSPl4gnw4rErKXDkE+Iej3qmCoJcz2Myjr1yMKTDBatX0BcIGhgzRfuC+kJSNkGW61KWVan4T1i0bBNWdOOcSQuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by DB9PR04MB9355.eurprd04.prod.outlook.com (2603:10a6:10:36b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 02:23:28 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 02:23:28 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 09 Jan 2025 11:29:09 +0800
Subject: [PATCH v3 08/17] imx: imx8mn_evk: Enable dynamic settings to
 mmcdev and mmcroot
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-imx-bootstd-v3-8-16e5fc0baecf@nxp.com>
References: <20250109-imx-bootstd-v3-0-16e5fc0baecf@nxp.com>
In-Reply-To: <20250109-imx-bootstd-v3-0-16e5fc0baecf@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SGAP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::32)
 To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|DB9PR04MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: f44e3513-695d-4762-e79e-08dd30549ab0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXNTWnIrV1dYY25hVk9nbklNVmZEWkh4OEJBVC9aVFVwcmQvV0U3ZU5qL1Fu?=
 =?utf-8?B?dVVQU1E4b1JUNzk5dFhFL2NYb1ppMFlUNFBuVnZDZTdZSEU3TXB4NHRyR0hT?=
 =?utf-8?B?NFFtbUUvNm1yUE9hMVFGWnh5YzVibXVjT0lJVVMxbktGZ1Vqd0pISktSM3I5?=
 =?utf-8?B?UitMNzhvdDBXTUJTZ3VKYy80OXNMOVlQdjgrM3hPTmRRblBvQ29WaVVNMFdr?=
 =?utf-8?B?VzNObnYrMDJ5MUVTc2VlK2srNE1hcmRpWkcybzRoN05UcFhmeWE4Rmtma3J4?=
 =?utf-8?B?blJtczFqU1Baa0tDZGVEbnN3d3lnaWxKbmowMnlsSjNXYkVOaExlMEtkN3l6?=
 =?utf-8?B?c1QxTndWaWxZT2tiMGQvU20vajRJQUtIUlcvZHV2dlVJc0MycjZrZXhvcnB3?=
 =?utf-8?B?b2FYQVc5eXNISUhTd0VYVWNIUkZxZDdqWDhtQ05ZbmtSaE5sSFg2ZmJONUlY?=
 =?utf-8?B?ZVJYdzdRckNGL2Rxa3Zaa3U0NVQ2K3pZUHh4RzlRRzlJMVJjWHA5UmwxenFN?=
 =?utf-8?B?SkZGK0g2U0YxTVd4ektlK0hnb3E0OXYrR1l5bThRbDM1UzNVaUpDeTBJeGs3?=
 =?utf-8?B?cUswcndBQU5hWFRLU1FoeUFVV1pBcE9pYVpLai93eHVsSy95dkgvUVIvUWUw?=
 =?utf-8?B?WkVoa0U4NzdmWUtmRkRnMFZqOGdFNmF3d25kQ3E3alovam91S3RxS3hxcHg4?=
 =?utf-8?B?OU8wek5DL0svVFphQkxtdmFmUG4yMFptRGxDWHBvU25yaEcvd1N1V1BHT3Mw?=
 =?utf-8?B?VDkwVjdRUUF6WW5QcmtkN3lFNkdZRmUxcWc1U25mZHFVMnd0VzNpaGlqWUlG?=
 =?utf-8?B?NnhoYW9ydmVzNjhWOWM1NzdhWU9pdFZwbzBWSTJvejVqU2lGMGFVMzVnVktk?=
 =?utf-8?B?TWJOcHdIY00rU2pJS3J3dFdITEg4TUo4U3RSeHhmYzBmVHF6ZkhaeHdqcXZP?=
 =?utf-8?B?dExVQ1gvVEpvK1kyUHl5cTdsZUVCekFCTEFXVFNqbjBzbWFueTNGUldYNVBV?=
 =?utf-8?B?Q3p3ZW9Db0lEVlN4eXJvZ2QxaFd3Q3RqQzhEN0pJcG5QT3lzRWVKbG5kZGlF?=
 =?utf-8?B?M0RvMlk2L1pGMjJLU3VPdlNFMldIK2I0ZkVzYXRGZG40TWI5a1Q5NWNhTkhD?=
 =?utf-8?B?NmZaS2RGUUNjcTA4bTFzS0hLemUzK3dmOGRoTmdnaytsUWNoK2JWU1hkc0Zh?=
 =?utf-8?B?ZDdGUllIRXIvZjB5TndLdXBhV3VHYkJ5ZVZjdWFzME8wclBXazBXOUVKd09m?=
 =?utf-8?B?OGU5dWdRUUNRN1JYcEZZN25CSEpQSXovcEhKWHN5aXJ4K2F0Ylg0K2pDR1Ji?=
 =?utf-8?B?ZnhzOUNQb083Z0JwTVg3bmJ4WkRhcDZMTE1adkUwSXQ2ZnMra05aSGJkcjZC?=
 =?utf-8?B?cDBsbHQ2K0Nvc1BGVUpIaXRjd2JyZkM1amhrbFIyN0VNSEpDazVLcHdhTllP?=
 =?utf-8?B?MXk1Z0tZKzYzcFMxRTQ5enp4L0lwWGhCL0lzcXI1VGxGN3hUS0VRTFNDYXc0?=
 =?utf-8?B?Z3VVSEhUUWlYbVl5WWJFTXUyUW1BS0czclN1TkZTY2JuOUxkT3R2c1ZubkFP?=
 =?utf-8?B?VVU0MnhrRURqbTJmQ0YxTjhLMk9PS1ZucGswUTdtbnR3NkxnU3UyallEd1JK?=
 =?utf-8?B?VGloUlV6WUlxRCtJOTdmS3M1WWc3djkzZkJEenNvMnRsSE9PNWxRVC9qYUNU?=
 =?utf-8?B?V2lnY0w4Wnh5TmFTVXFGd29vNE15blBYbXg3MGpsN1hNcU5CWVNRNnRZeG84?=
 =?utf-8?B?eTlHU2pWWDh1aENMZUNSK3A5bXRKM3JrUVl0b3NtWXZudkZidzBMbE9tZDF5?=
 =?utf-8?B?d1FNVndaU3N0Q2RWQjY2NWlmd05EbkF4RjhmdWNsQ1hkM2N1VzF3NWdjVnFh?=
 =?utf-8?B?dlluVVBTNTBVM3B6ZWRUUHBobXhCMWNiTTZlMktzRkJyMWZubU9uemRUYjNG?=
 =?utf-8?Q?MpGleyMoiYiYnlR4Uv3krDqmQxS+AVFU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnRNR3FEUFI1VXN6SnkxcG5vRVJMcHh1YUpIVDQ1bWVvOTZWTnZ3aVdBYTJP?=
 =?utf-8?B?dnl0YUhKYTFzZkFCZlc0QzBGSERNUHFZQlVUQ0MxaUY0WDNJSWpPYk81WDZK?=
 =?utf-8?B?YmNnenNTbzA1bFpMUEpGSXloenlpQ1NWQnZraGJENXJVRncyaGx3VnVSd2hl?=
 =?utf-8?B?Q0pqOW9Uenp1eUpoSUFVcThLWmR4ZERXSS8yN09ObXZycjdDWDI0RUgzM2Ro?=
 =?utf-8?B?RXVLMlNWTi8zM040Tk4wSUhIQlNTVC9aaTBXVnhvRDEvRUxod1lMai9aWFd5?=
 =?utf-8?B?M3g4ZFNERnRPVVh2ZXZ1anRWREYweDc4QmQwUUsvSXhWTTZFSTRCM0M1RmRa?=
 =?utf-8?B?TGNzUTk3Uk80YWlGL3VCMGQ2amQ4STFOMzlOTDRFUngrZ0paR1RJVjFRRUFy?=
 =?utf-8?B?Z0VnRWpLZVl3YTVwc0VQQy9JdHJabWNhWHhTWUw3TkNXMzg2aUhIODJSZnRH?=
 =?utf-8?B?VERRdVJ2aFYyV0Y0S2MvNTBxSTFDcTEzS0xoa2N6T2RjMERVbFl5bzdzS3Zk?=
 =?utf-8?B?MFR1WmxHZEg4THJlMXU3WFJZZy9SRW4raHVJRXBSamJKeWg1SEY5ZWF4MHZE?=
 =?utf-8?B?dmZaSDY5YVlGRUg2dmlFeVRsMkhFdXllN1VWMlVseUo2Z2tpQnhXWmtUV2Fz?=
 =?utf-8?B?dTJXQ3ZLQU00UDNwdnAzZ3ViR002UldsREhQNjcwc2JHekdCSGFWN25uS0hx?=
 =?utf-8?B?RHR1WGQ3dU9TVS9WLzNibWlsZ3NvS0V3aDJ5dlJBVmVhOGFKZWkzdnVaVmpG?=
 =?utf-8?B?RkF5SkJOWmJhTTNKYUU5RlI3eTRXazJVWkI4dnZsd2EzSGlXOFVSdVo3VjY2?=
 =?utf-8?B?VDg5WHB5R0x6RlZYd3BRMlBvVDcwQjFRVzBUZnp1cklpTzhFQ1VOY291TG02?=
 =?utf-8?B?dExWYmFNc09uUHp3d1hFQ0k3V1BvV1ZVRUtUZXBBRWlWR3lyZGZ5K1FlajJO?=
 =?utf-8?B?bUt3WHJGMitjaGVKZ1BmZHBDcGEzd1pwaWl6Q3pNVXJ0elc3RzJpTlZnZmpi?=
 =?utf-8?B?V3dFaSt3SjZWRkgwSnU4UGwvc3J2MFNDZ1BrN3U3dnc5cE80ZGxvalJPUVdP?=
 =?utf-8?B?eUlwZU9TVVIwRkdoNHRkOUt4OTJtM2VlOWJhRkdkbyt2QlpsZmEwMDM5bGQw?=
 =?utf-8?B?VDZQSFVrTGQ5a2Rhb2x2enEzTHVDOUJUUlZzNFFrRDJiOWtweUFqYkVwWVRl?=
 =?utf-8?B?TGZ0MS9keGxsR011enBGcDh5K1NmdDdIa0JnSnN1OWxjd1dCc0lyRzQ0Vldp?=
 =?utf-8?B?WWdYOG55QnJCS3drMzdNcUx3OURCQnJkM3NyZGNveWsxdUhrUTZtZlFVdXlC?=
 =?utf-8?B?T2FBMU1BSW5RSUlWRnFKbjg3Z2QzSDBTRjIwZFRyd0NtSThzMWhXTHlLWmdh?=
 =?utf-8?B?UVhiblQzZ1h2NTQvcStqUDRvckJaTm1QYzVmU2g4QlpqenN3MDJjbzMwanMy?=
 =?utf-8?B?OXhnQlJ3WkNQLzlmRkhCYmNnSGwxbWVqZk1GWFdjREFEaVo1NXE4NzRIdmJy?=
 =?utf-8?B?amRZYndmb3REVE9iZU5mejdPSnh0UmxBZ1FJaDBGRDlzZFdyVVBSZ1huRU4x?=
 =?utf-8?B?SGYrQTN6eEZ1SVMzaUZhM3MzMVM1WUd6YVZISnVNM3pzTmQvRXRLZEw1Mzhq?=
 =?utf-8?B?WXdOZXZLejZBVi92YWtSckFvLzJuRGduQ3FpbVozaGpOdnkwdHp2TEN4ZC9F?=
 =?utf-8?B?UWg3SDROMVFSUWE5enNVMENBcFlHNG81TEJiMUw0OTE2V29QQVhxcTNPbS83?=
 =?utf-8?B?RDJhQnhGeG5wYnV6RDZXdFl4dmJNeTJmYitwMHZLR1J2Si9SbmRuTFM5ejhC?=
 =?utf-8?B?bDNSdmtUYmUvNXc1UXZyWk5nK2hvOGlUNjRPWERROHA1aFlqeXhnUzA0N1Qy?=
 =?utf-8?B?R2VmbGlRbUE5YnRHaVVGdVNRN1ZKaXJMc1NzU2tKeUh5bklva2VXNTc2YktB?=
 =?utf-8?B?L1dYejlXL01oZkZOWUVaUDlZZGx3WWJjOE1kVUkzMFhnb3k5OWk5alJiejYz?=
 =?utf-8?B?cWduUGswQWk1Sm1PMTl4R2RpUitrOHhqVUJqOVprNmdST0doMGVqeVRJeUJN?=
 =?utf-8?B?eTdwZ2RBaUM4MzFQK3hEUjhGQjNaWXZnVWxmVGFBbytFdjl4L0tXN3kxZlE3?=
 =?utf-8?Q?pCp8tdRIj/8ColobOeIYXP2Fn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f44e3513-695d-4762-e79e-08dd30549ab0
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 02:23:28.8171 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sueRUgvmxyW/ydctlW76cWIEJBNIlonm3IlIzy8vuJ/WM2DisV3rKv2cUvkPIO29kDexWBk1Bp7+l0giO9i/+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9355
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

From: Peng Fan <peng.fan@nxp.com>

Enable dynamic settings to mmcdev and mmcroot for i.MX8MN-EVK

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx8mn_evk/imx8mn_evk.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/board/freescale/imx8mn_evk/imx8mn_evk.c b/board/freescale/imx8mn_evk/imx8mn_evk.c
index 1b9dc51978b555256532f22e1cfd317bacee5b37..c62d7a47e21b77918af85e966ac2bf8f58a75df4 100644
--- a/board/freescale/imx8mn_evk/imx8mn_evk.c
+++ b/board/freescale/imx8mn_evk/imx8mn_evk.c
@@ -3,6 +3,7 @@
  * Copyright 2019 NXP
  */
 
+#include <asm/arch/sys_proto.h>
 #include <asm/io.h>
 #include <env.h>
 #include <init.h>
@@ -30,6 +31,10 @@ int board_init(void)
 
 int board_late_init(void)
 {
+#if CONFIG_IS_ENABLED(ENV_IS_IN_MMC)
+	board_late_mmc_env_init();
+#endif
+
 #ifdef CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG
 	env_set("board_name", "DDR4 EVK");
 	env_set("board_rev", "iMX8MN");

-- 
2.35.3

