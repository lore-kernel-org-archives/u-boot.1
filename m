Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5352BD172B3
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 01:43:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D5A783C23;
	Mon,  2 Feb 2026 02:43:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UuC65SDi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CF7183C2B; Mon,  2 Feb 2026 02:43:03 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94A2C83B5E
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 02:43:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZbNwQS8YysCZCsg0/EQsHTxLZDsAJ58rQ35C4KYR/8g7nZLCYUpNzSPS+yhk089Z6vRMf2ZZ7+4RZmBXBo4TLSdDvv+Ty9BAs38vVQiz419hZuVWXyNrP31tjArfCMtEBUgvN5uoU7M+3tEyOpFKlp1sp3DVy32mFnQv5UkHpJqM0L/95RRTFp8JK60sQb1sAdHLojjy5qSViV4JiqMGNQeUvLDlA+XcnWzfWX3fvrc4CweitPPiMFLr2ByYTw5fw+X+3k6n2EcjK7wVqJyjyvlj+4YWhvz2ZFgvDmP7uyh8XpDwGne+DnSM7WN1HkWaydggBGYI0l9heWKRVgiyrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWgdTNDvSc2NzHHD91wA70MkqlmN46TV9RrwHZiZdfQ=;
 b=lEqwLWXFdyXAlwJzmfLiHTSO3imKX4Q0VQBmbVnb+0cAeRSh7uevuzG3XIdzUaEj+UJBXN0lyW/3I1C92sxsL+fWWHN43ZlUObYx0531vmbpELh2nwR75+nYae9maRaASqowqXtMf4oyTwMHnF2w+FJD+xPwT1zxkE6MHMCgclPghKEViSCLXUPPWup4qSuvuO9N0d6Q38AY3qSURn/t2PIztk4VNXF3T5Vikw0CKB6CAI85ZjuoeZggFhey9sgLPs97Un2G3oe8jSKRfJ6WY+ubRKY71YdniDzryrtDDH58jhv4RejuHec2qoOXt+aCdDP6Jl3uaQ/Id2cCTE7DLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWgdTNDvSc2NzHHD91wA70MkqlmN46TV9RrwHZiZdfQ=;
 b=UuC65SDiIVtObNI1PLgIJhUvYbZZBy6nIlABEozG6i5GE5WPNc74Wuq3YLdQ6udyWu/bj/vWC8WMsHRBiWhb9QotcpdtVpLUTzTmmtn5qP06hYNDp3K/q/Bsq/gA50HjGE6rFjqkoAhtU/9c79kfqLqzUe9xCKHmGb+juaa/F58EGJXcl6fuUDqDW7aUHoXeiaBlhut7oPCEAv5XoV07u4uw+13xhocmjiWftS3mTpjxfDcFIu6eLF2xvSXV5wOw5aAdynDR+U+l/s1VpW7L605prR03+myJ8Rsj/EEQmsGqu0u0gmbdsMOuGEcD8gjGJeIoOleL3ciu9fpPhhxsPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB11483.eurprd04.prod.outlook.com (2603:10a6:800:2cb::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 01:42:56 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Mon, 2 Feb 2026
 01:42:56 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v2 0/4] remoteproc: support i.MX95
Date: Mon, 02 Feb 2026 10:57:43 +0800
Message-Id: <20260202-imx95-rproc-v2-0-b85fc7db23fc@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKcSgGkC/23MQQ7CIBCF4as0s3YMUKm2K+9hunAotbNoIWAIp
 uHuYtcu/5e8b4doA9sIQ7NDsIkju62GOjVgluf2sshTbVBCdUKqHnnNvcbggzNIkjptbqQvhqA
 +fLAz50N7jLUXjm8XPgee5G/97ySJAkWrSU00t1Zf71v2Z+NWGEspX9EyXPukAAAA
X-Change-ID: 20260129-imx95-rproc-b1b65c8b54cb
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SGBP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::19)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB11483:EE_
X-MS-Office365-Filtering-Correlation-Id: aa47693d-39ce-46f6-424f-08de61fc631e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1VmYncwa1JHcy91K21WMVpRN05wUVFSR2Z2OUNzRkdLRVhYNEd1dGN1VEQ3?=
 =?utf-8?B?eUNldzlvWTA1ck5CdkhJY2o2d011MkJtb2dIbThvQzBoSWEvK1FqalMyTkdG?=
 =?utf-8?B?RkNBRUliZVRESkN4QWVnemxMaUVWaXFXWHVmaUc1OEtOWkE0Q1Bka3BEajhT?=
 =?utf-8?B?UG5xd0o1UjVkUkkwWWxwcVFNV3p5bVZDSmoyUjZDYm5jclNhNUYxTzVZS09F?=
 =?utf-8?B?d1V0ZnFtSmZGcW1jTmhHNE45YlR0T3ZBSjlwSHRkQ0ptanpQZ1EvTzljSVNE?=
 =?utf-8?B?aU1aVytCWmV4MWlpSHdaQUwvQWlVZGJpbFIyMTJXZ24vUXlMRmJNL2E4UmZo?=
 =?utf-8?B?SmNDcmNOQUx1STBPRCt1QWl4M1VNYVoybzc2dTgrNXg2MUZkNHZBeDZkNGV6?=
 =?utf-8?B?VVU2SGtsayt1b1FzZUxNYXV4cHZ6aG1hRnYvTnJLSW1YKyttU2RMSDUvbnZm?=
 =?utf-8?B?SVVQUXM3S2QvY1F3LzVLMVFBV05vMzNUTWlVcUpra3BYMWc0eGc5RkNGSVlu?=
 =?utf-8?B?SmdzYmZONTdOdGVjK1FIODNaZ2RZR1RuWTFQUUEwT2FGZS9vWkdRN0NWbmdn?=
 =?utf-8?B?dEVMOHZTd2lXUzYxeDQvb1JNVnV5MEpqeXJqOTJ3Qkk0MnhFK1FBeC95UXBm?=
 =?utf-8?B?RmJZWUluTEcrWVJ6SlNDbVZiSTFqSVlBT3pjQ29uU3FnSEZTZUpMSjdlcXJF?=
 =?utf-8?B?QmNhdllhWTl5UzNMazhnZUowcTkzSWgxNUsvUGNVbGMwSFVldHZKZjVLZlFx?=
 =?utf-8?B?OC9McCt4a3E5MEFmdWw5eDBlbk5oZnp0bnFPa0FZMDVzbHBLQmxMa25Kd2Ju?=
 =?utf-8?B?L0hPUG1QNTFQT2lka3lURHpUTUJSYnNkWk50RlZVYi83THFwb1RzcXU1QUc3?=
 =?utf-8?B?NUMyUWRTcm1DRURlUFRpMkFnSExhdEZ6ZFVPanczbUdTZlBiK0lzaS9lOWUw?=
 =?utf-8?B?dDRzdWM2cVlaUzAveEU3Znlzc0lTKzlVWG0zVWRxeTQ4QzZweUFoSmxrZkRp?=
 =?utf-8?B?em1SOFVsZnVWNVFjdXVJYWUzeTFtSFQvaDhIb3JCUUdDK1hqcHpZQ3JDcW8r?=
 =?utf-8?B?Rmt1d2RtZ052dldQMDBXUjl3SHlKTDJsUUNkYmtIbFBhWW9QYmI1Y3RreGRk?=
 =?utf-8?B?TzlUbUJUUzNYOUd0UFRad2pJVzRQNEZzQnFHcTliYkpOdnFPRDF5REJhaDI2?=
 =?utf-8?B?ejYwVm56Tm5ZdFl3bXpUQWtYN2VEcXBBNWs0K2tTcVZ2dDNVOER5UHZSVmFP?=
 =?utf-8?B?aFg0NVVHLzlvVHhFam1jTVp2dXBQR2Qxc0lIOG9BQjErVjliR0F0Q29HT1Rn?=
 =?utf-8?B?bzlWUUVCbkNpck5tQkpCNXJuaHhMZUw1ZzRSRUh1Mi9jQkZ0TlpmLzJJQnNn?=
 =?utf-8?B?cWZTMkdvWWR0RkR5aVBIMlhPanZPSU5rcHZQenNhQ3hjMExPK3ZWSFBteFZt?=
 =?utf-8?B?b1ZCVmFxbGRXRHBLM0VwUUkxWU1kczdxU2dmVHN4cnhwUlJpaDNXQTdrZ1Nj?=
 =?utf-8?B?ckt2RjVCMm1wemlNeHB2ZlM4MXcrQU9oUDJyZGluRTUxbkhVaFliV1hOUU9a?=
 =?utf-8?B?N3BwVWE5c0ZTK2dPOFJCeGZvdzlTdWQ2UWlrUDNXQmlNa3E5aDlUMHM3S0Ft?=
 =?utf-8?B?ZHdQSThMNGRETEVGUGdxOC9RVW1ISXNhZS8vdjBmYUEwNkFzS3ZVRzNFZ0NT?=
 =?utf-8?B?MUhyM3FXNE1XVXlzeWlKVjcwempwZGJ3aS9FN2gwRHdOTHA5djk2bXl4b1lT?=
 =?utf-8?B?TEVkY0NaMi85d2E3ZG5hVVNNNnIrZi9ZeVBFdVoway9Rc001OG4wYlIzNnZk?=
 =?utf-8?B?cVU2Z2JBT1BLTjEvV3JjRWM0YXk3ZzA2NE40eG1oWlVTNEdSZklIaVMweUJp?=
 =?utf-8?B?dHNHeVZqUFA0ekNxNkE2RnY3WmZqcmEvVHJ4R1ZoSk83a1Bsd1E1dFZFSEJP?=
 =?utf-8?B?Si9OYXhLYkU2RDFxQzVyeHoyMlBRREk0ZzB1azNSbHh3cDlsalU0aHh0dnlM?=
 =?utf-8?B?QWxUdTUxYmhPdHFTWFUrVStTSlZTV3I3ZlkrakFIb1MvZ3dvQ2NyaDBGVldI?=
 =?utf-8?B?SmpNVU5jWFZqQVIrSTYyYUZhek5GV3VMYjh3RkQ0Q05wQzc0NFFPbHpEeUhB?=
 =?utf-8?B?aWk4bkJxOC9wMG1rN2NYTFR5NUpQQUd5cE40MVNWbDFUY21uZGw1aGhjM3c4?=
 =?utf-8?Q?qXDg1oyqOE3trM6XmkUPLMo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVVXQXpTTWg4cXJuUjk4UlNBVEswcEdQWEw5RVd4WGJxb0IxNS92bkszWE1P?=
 =?utf-8?B?RCtFWGFwS2RvMjJFMTh6MmdhVTFqSUFvb3BFVGkwdC9FL0wxakFkM2lvOEVo?=
 =?utf-8?B?UUdJUDlNZ3pjdS9kSHhKZFZEeE15YzhKckhoS3FkY3NnTUxCVDhlTXlKYTI3?=
 =?utf-8?B?c01TVHFWS3FJOEFJZVZ1SzRUdU1KclhWMHBxak9xTFJwM0k3VUVmZlNWUHc1?=
 =?utf-8?B?RkhKWmpHT3ZTOG1wdm4wMmYyMElZdy9VdWl1U1A3clNtOUMzVnpJSkQwdGls?=
 =?utf-8?B?Z3VXS2g4dHVRelRMUnpUUTd4T1RmbGZFK0w4Y0Y2RDhJYWl2MlZzTnZrdDFk?=
 =?utf-8?B?NWtMUlRIQ2FGTFBHaDI3Sloza2hXSGhWc2t2T2NpMCtBMEFVSHlFZ1RjN0Rj?=
 =?utf-8?B?Q0dwd05mUXNlRHhXUEcyQXNrakJLMjJiYzNHZkk3ekluekM3VFR6MWhGYWlP?=
 =?utf-8?B?VFJVYkpqa0lXRFNRV3kvenFoVXRyVjdLR25wcnBjWmoxQWtMWHJNWWovRTNt?=
 =?utf-8?B?cmhwTkw3eklycjZYY1poa0p1VGQ4S3h6bGpCM1pYUUc3L2t1Ujg1WUxEbk5q?=
 =?utf-8?B?WFY2Ry9FZy9hVXhjR1hTcHBpbGtzZUpITm5sT1RORHJkcE5qaDN5M2FReHN3?=
 =?utf-8?B?dkxaVnJxcU16SWc2Qk14Z0hMemMrdnhMM2IvR0lCcG11U3haS2FSZlp2UG8z?=
 =?utf-8?B?dkxsb2VsVnh5dU8zTHdMOWZ2TnFybDR2c3NnSzJjK3EvNzdCN3BxRkZYSjZt?=
 =?utf-8?B?R0tuc04zNC9FSVo5ZEtEL2E0ckpFU2E1NFNhQzFkVHVrbmpYbWdOZ05XQ1l6?=
 =?utf-8?B?V3pOZ2NucFdiam5mOVdmSDFZYk10Q0R2N0lPNGZGOEJSVktOd0RxRE82SndF?=
 =?utf-8?B?YkNhUEVsanc3Y3lkMmdtZ0RqcGozRjZmZEVOZUl3eGFzU2M1MkR4YVM2Mmwy?=
 =?utf-8?B?Lzlna1FScUN3Njg1ZUQvN0lCa09rdDVNQkJ3NC9qazlDTmN6VkRlNE5XUmdt?=
 =?utf-8?B?bzU4bnVWbWpCbGJ4dVpneXhqT1YxeHdzQkRraFljOWxBZmR5eVlXZXBNVUYy?=
 =?utf-8?B?OEhKT0NGbDNWTEZ4LzhSSUtoam9TVWhTQ0NucGNpWDlxU2dGQW8yR1Rma0d4?=
 =?utf-8?B?Z21BcmZOTkp1cDhzZjFnUzRRSHlkaTdaTjRsZ3RMbmM5aEdtdDZNYkhWZ0VP?=
 =?utf-8?B?eGZ4ZFhEaVpUZXBjWDkwR0xadnB4MVFaekdsNTlaMEVZdkxoQkk2ZWp3ZENz?=
 =?utf-8?B?M1VocG13TXIxcjUraldwSGVsS0pGYTVWNjJLN1BIZkM4bXczT1pEZ2VDMnM4?=
 =?utf-8?B?ckV2VlpHbmYvMVNUdHRySDlJeU00UmQyS2owalQyeTRaelpCWkREcVIvYXVL?=
 =?utf-8?B?ZUlraEIveUtiSWxtdXdHclhUYTNsdlI0bTRSRHBFcnlNRWI4M0lmMUJKV3Mz?=
 =?utf-8?B?M2tubXV3ckhscksyUno4YVV3WU5UU05kcHFHVW5vRm4xMFdFVzlmQWxSOWVR?=
 =?utf-8?B?aitMc2NzbTV0VkxHY3I5aHd4eEtCcVFvdnFzMlIxR2REekFwRVduMDZEOUZ6?=
 =?utf-8?B?QUhHS1VjcXJLdzlKdHJ1SGFNNTZmbkFWVk1MN0UvUGJJZkpOakxBdW1GSEFn?=
 =?utf-8?B?QlVDWll0SGt5RHVmcndCY0VhdTJSeXdGMlNDVUp2emdHaDBqc0phN3hRczg1?=
 =?utf-8?B?RmxCV2RuL3FiWmVvbHZSVzdsSlI5eWlNTkk5WXVMbmZ3UUZjckxOSjNVYjNQ?=
 =?utf-8?B?V3k5eHR5dytISE44bjE5RjlGRzhFOTdwcXh0VFNSNi84OWxBNDhFSWtZSVRo?=
 =?utf-8?B?cy9zdUpRVU56Sy83QUR5Zk9yWGNkYU1HQzRFNkJjNzhZamE4M1M1RlR4VGhL?=
 =?utf-8?B?TXEzb3YyWTZmdDNXRUNJRFc2bkV3dHVnNlljdk5FZGFaNm9BbldwajI5b1Ni?=
 =?utf-8?B?L3JMc0M5WUFod3cyU0ZZYkRwNE15aEhWMTlhOC83Q25VTWtwWitKam01L1dt?=
 =?utf-8?B?aW9ZMEY3STcwSTlmNTNKNXdONG5YWnlZdzNSTVhXZHJ5bHJ1eUtWZi95VUFk?=
 =?utf-8?B?MXZXWCt0aDltVkozQlRGZUh6cDdYWFA1bk9GOFA0OFBTeXRlMWY1M2g5bGlI?=
 =?utf-8?B?V25pV2I3OUJkYXBoTXRadjc2ZTYvUnJVSTIzWHdyMWhjYWswdGJCRlVybklm?=
 =?utf-8?B?QlFPUk9LdDFPcDJSYWplY0RuS2xscEFUNkRGY2VUQ0thT1lNOWwwbnFFL1RH?=
 =?utf-8?B?RzR6ZjRXV0JrYkVJR3Q0UWkrRVhCcC95dGZMYkxQalVuVGFCUVBvWXlTQXli?=
 =?utf-8?B?QXBTOGs5ckhYVmxJa20wSk5mcHlFTWJnODFnRitsbWRxamlpUFNLdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa47693d-39ce-46f6-424f-08de61fc631e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 01:42:55.8046 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Um2HkRUuysUPcl2DLYLH+/A8EcXl0QarZXOUbgda7TYF8wcXK+51uLtOdhDfiM3paCFuobJGbho80yj874T1/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11483
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

Support i.MX95 remoteproc. i.MX95 use SCMI Vendor protocol to manage
remote cores.

There are three cases for M7:
(1) M7 in a separate Logical Machine(LM) that Linux couldn't control it.
(2) M7 in a separate Logical Machine that Linux could control it using
    LMM protocol
(3) M7 runs in same Logical Machine as A55, so Linux could control it
    using CPU protocol

And because needs to do ECC initialization, patch 1 introduces a new
flag ATT_ECC to indicate whether the area needs to be cleared for ECC
initialization

In patch 2:
The current setup only targets for (2) and (3) to let U-Boot start
CM7. Need to extend the driver to using LMM and CPU protocol to manage the M7
core.
 - Compare linux LM ID(got using scmi_imx_lmm_info) and M7 LM ID(the ID
   is fixed as 1 in SM firmware if M7 is in a separate LM),
   if Linux LM ID is not same as M7 LM ID(linux and M7 in same LM), use
   LMM protocol to start/stop. Whether using CPU or LMM protocol to start/stop,
   the M7 status detection could use CPU protocol to detect started or not. So
   in imx_rproc_is_running, use scmi_imx_cpu_started to check the
   status of M7.
 - For above case (2), Use scmi_imx_lmm_power_boot to detect whether
   the M7 LM is under control of A55 LM.
 - For above case , after using SCMI_IMX_LMM_POWER_ON to check
   permission, scmi_imx_lmm_shutdown API should be called to shutdown
   the M7 LM.

patch 3 and 4 is for enabling remoteproc for i.MX95 EVK. The compatible
string is in linux-next tree, after it was added to linux upstream
imx95.dtsi, we could remove the changes in patch 3 in future.

CI build pass.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v2:
- Moved the config option to defconfig in patch 4
- Updated doc in patch 4
- Explained adding node in imx95-u-boot.dtsi in patch 3 commit log.
- Link to v1: https://lore.kernel.org/r/20260129-imx95-rproc-v1-0-035b2dbf3e57@nxp.com

---
Peng Fan (4):
      remoteproc: imx: Support ECC initialization
      remoteproc: imx: Add i.MX95 support
      arm: dts: imx95: Add cm7 node
      imx95_evk: Enable remoteproc for i.MX95 EVK

 arch/arm/dts/imx95-u-boot.dtsi    |   4 +
 configs/imx95_15x15_evk_defconfig |   4 +
 configs/imx95_evk.config          |   4 +
 doc/board/nxp/rproc.rst           |  13 +++
 drivers/remoteproc/imx_rproc.c    | 189 +++++++++++++++++++++++++++++++++++++-
 drivers/remoteproc/imx_rproc.h    |   3 +
 6 files changed, 212 insertions(+), 5 deletions(-)
---
base-commit: 6a1bdb7e952d5841f42742fefa907cae5dc8d50a
change-id: 20260129-imx95-rproc-b1b65c8b54cb

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

