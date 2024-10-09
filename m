Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFFDCED614
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 07:27:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFD8489124;
	Wed,  9 Oct 2024 09:27:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TuWJKTRx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0A9089122; Wed,  9 Oct 2024 09:27:18 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55FEF89124
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 09:27:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fzy2sJ2dmf0luX/ikMIOYzRV3+0577OqOuRQ29wjAzEMLbzM049XUzTK7hV8rJMPCSrf5nMbgsiShUIl5rPtPUnJwUlaA4KSFXIjo/azPbst5nwRIUqdxeWN0ZPSd7ewUT4vNHn6cegAaW8jGJJvuGoOAEdxA+PuwLZrnhRWAd25NpY2zPa7fhE83VpsY9W1bZS5v9HCUoJmrATpqHdF4dzWhsIM/HSBX2bCD7knP68TwSPwNdIPmgZPi0gGqzuYaYDpQNIFfcU3aM87/Ffb7F9ZBTT2YejBJaUFaxBQeX+IJ5W2kAvCaAosQOyEi5t9HxtqxAO205qYr8XKf/ASEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gp6OBXbK2fmR8+ZrPiYr8SozEgQPh0HpqkSNILDAsPs=;
 b=swg316vrmXGRocIMgJz9E7+iwC5cKjOPlMNUJzhNUztstzk2QNKWwNFtSGJ/Kt7Q+qpvul2Rfi9QeUM8+Ta7Ha6+7kCs2pHeSImsWVZa9PcQfl2BKKpjVoSfY0FWYqHV2gObQ9U2SyJ/gK8Xw2EhcO/svW69TJxzpGhx/Ijz6cbdy9WTOgB9BLHkSDwbA4OENHGctcVJ4zhpYdJmMmxohX02Wec+R7rIcaFrMD+pO0rSOZONy59pukpa7kRIO6nM5AM7RP3IZihAHkoLU7IEtgcufT3ePeYeYSMaRnSth+yqb1gfx1CK684ALnhVYjd91Nkl+P4+ZXmK5gKNotSMaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gp6OBXbK2fmR8+ZrPiYr8SozEgQPh0HpqkSNILDAsPs=;
 b=TuWJKTRxmLveXs+aOUJLI7LD4L1oWXS7fC3VN+OLdOWG6FUlI8dVZZJPfKfD2ynEz4ul3flH4F3K094vhPmEgr3iPGqLuyYUnuQFt3HGC+aU1ipd4Mtk37Dl4E4lRZZiOZ7HK3w05itmPOMh2bU8qvjBEh5HbulHAS5iYU/FanYZ8rys/bocknLzTvaAvqYKJlPVtQqsTU8eK5GXQKPzaYSd54uQ6xsF2A16eeZHzr69qmxImYS2BCPNCoAVShe4qWKC4irlfA/h+fhN3VPuxQHmK9vnbJU58zuxM+pEzQm0UhJ23CgcGiisZxDKStPOijPSP+f6rSmxT3LLKLC1jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8438.eurprd04.prod.outlook.com (2603:10a6:20b:411::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 07:27:13 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 07:27:13 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/2] imx: Add i.MX93 9x9 QSB board
Date: Wed, 09 Oct 2024 16:31:01 +0800
Message-Id: <20241009-imx93qsb-v1-0-50a4ac53ccc4@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEU/BmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDAwNL3czcCkvjwuIk3RSDFHMzy8SUVMs0CyWg8oKi1LTMCrBR0bG1tQB
 1btLEWgAAAA==
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SI2PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::20) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8438:EE_
X-MS-Office365-Filtering-Correlation-Id: ec3246b7-6438-4e86-f6f1-08dce833cb67
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N1VGb2tvZExLYWh0K2NOckFpNVdSV3R3VnRtTzdPRGlGUWJtZDlaNUFKcFov?=
 =?utf-8?B?U3djbmNnL0lGZklkcTBpU0NWQzhvcy9sajJFQWcwZG9qSUY3bVBEYmVlRUVz?=
 =?utf-8?B?cVVaY2NDeUdlYm95aFBNZEhhbkU3Q2VYTGIySUxKQkxKVlJBc1VkQ0FWWmE1?=
 =?utf-8?B?UmdPS2xaVWJJdGdBWUVja2pGQkFCTjI3ampnaStVQlQzaDZlcElJd1dNTm1B?=
 =?utf-8?B?UmZHcXhLNUsvZThaSFJhWXZCd3RudDU3M1U5bHNJZEdndmM4cGkvU0ZFcmJW?=
 =?utf-8?B?NlYzOXFzV3l4T3IydEFNWDhBR3lpeEFoaE13RzRGcEVuR1VQNXlYQ0t4ZFpI?=
 =?utf-8?B?WUNidUEzUU1PNHNhUmtUdEFTOGZuOEo3QTYvbllISnIyWGJmekZsd3dTYzNM?=
 =?utf-8?B?OHlxMnFBQWlFSm9wRVJ3ZThUT2FnalcybHFhc3EvVHlnV1dwRnBtT0pJNzRk?=
 =?utf-8?B?OVZGM3graEJTOENucGZ6bGFKWDYyTnBycjBXa0lQa3V1ZWpNUEJSY2tCUzhR?=
 =?utf-8?B?dkZqM2Z0MXZ0bEZuL2tKUnM0VTRFdks5VFFLcng0Qzg4ZzRFTDNrWEZWbko4?=
 =?utf-8?B?aTBOQ0RxTGlvcVZWekRhZ1JEUXhkcnRsM012SXNQbXQwWWdCUThheG1JTkVN?=
 =?utf-8?B?blBWL0hJUWJnNWJNN2R2L3ZMYlFWUE1mSUZ0ZGx5cWZGTy9qOW9GWjE1K2J2?=
 =?utf-8?B?cGcyL2Y4T2I1ZXY5Ui9ENVVDYTlEMXNvQlErT1czN3JGS1l1MFg2VnBkb1pM?=
 =?utf-8?B?VEljejlwVDZCN1dVZkhiWDV0RDRBVkltdmNvSGhSSWFxUmUyV3VDSGZFMnZ6?=
 =?utf-8?B?QTNNMlFwY3oySHVpUDFSRWpvWm1hanhBRFVHbmM5RzA0eG1KRU5ubUNwcnc0?=
 =?utf-8?B?UVhWTmFBZmsrZXUrQzd5QlNIOFRtUlEyWHNkV1h5N3JVQ1JZdDQzODdnQnpY?=
 =?utf-8?B?ZCtRWmtSMDljU3FwQXIwRVFrMTBNNmlHZFZKa1FNdnZlWW1HTVhwTGk0c0Zv?=
 =?utf-8?B?M1dJT2c5bFRFbXNra2dPeVlaVHlmWWJadlhnRVl5Vk15b291TjVrVHQvS2U1?=
 =?utf-8?B?RG1jQWl6bzg2anJrNkdrWTZ3YUlVZnp5SGcyaGtuNTg0T3hNK0hhNFlTMVBU?=
 =?utf-8?B?ZmJMQ2ttRDBMSW5mSDl5V01UOHZCdHNtSTJqQU5VdGtPTlpmZVR5Q0hFTGdi?=
 =?utf-8?B?TERTNmp2ZXBlYnRkNnVkOTNXU2ZoUXZhWlFzN1BsWE9pTXhVdEt1eTlUcXFi?=
 =?utf-8?B?R3VRNjRmZUFjNUlmQWxZSG43WVYxdmtVcDByejdXWjJvdU5jVDRmMzBmWXdn?=
 =?utf-8?B?dWRsQUlYMTkzSC9lKzBGa2pxYWJ1eFJ0K0djWEJKYlFkbDlqamI0TE9Od2lD?=
 =?utf-8?B?MEFObmxZbVcraFBLam9wK3dFTWJqNzVCbGdZdm04aFprZUM5TG4yd2lISTZm?=
 =?utf-8?B?ZldkL1BMeFlDSS9KWklpN3NDcW5tamZ2THpOeEVYdjdqRVpkM0dzRFM4NURq?=
 =?utf-8?B?blVoS2thVktWRnFiQXpGcW5vRWd3MitCZXJHYnIyNWRqallha3hTZnVzWktL?=
 =?utf-8?B?RThKYXV2OFZ1RFF5OFVVSjMzY2dja3p6ZlVqV1JYdjdMSCtPNjgrTTBIV0JT?=
 =?utf-8?B?eFFhVzh6TFNsYkpEbDJBYkxJVXIvL0pLdHFlTmgybTRpTjJFMkx0N3huTy9R?=
 =?utf-8?B?V0hudzJtNHhXV2lNQjJiYnZIZkRzS1RBeFJObk82d2FsczByM3A4Z2V0L0Yz?=
 =?utf-8?B?V2Y2a2J0NEVRbG9wYm5EUE11ZXUzQ1dUdDhJeSthQWhibEsyWVBtcFB6NWdq?=
 =?utf-8?B?UWx6UFYrVHQ4Vm1VZDQzdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFZ0TldoVW4yaUxsUG1tWTlKSlI5QVZ3REVGREQvRElPc3hiR09MYWhONHhS?=
 =?utf-8?B?ellrMzdqdExrSllxYnRuZ1V1emVVb3pwVHVLVFlsY1NDd01BMG9SRjhoYlN4?=
 =?utf-8?B?ZXg2ZWthY0s2R0k1SVZMdytOcU12WFVMaGJUR2ZVNmd6K1JCcUlxR29KRTdu?=
 =?utf-8?B?RnRtd3paUmJhbGlVUTNZTHh1engrbVBtU0F5M0lMM2kzeU1zSW5IYlVBQmQ0?=
 =?utf-8?B?eGx2VTNnWnZHMXZzaTZCc3JjWWx3cnU1c1FDVmk1VTJsd0YwbjhWZXBwWi9I?=
 =?utf-8?B?UVNPOWtjSCtVTForTG40Tmk3TWVSK010clpJMW9KOTh2SFpuTEJFMDlLeDFm?=
 =?utf-8?B?RkIyamtjT3RWdkhGcWMvYk9ZdFphdFFXNHhDenptQy8zZkJNRHUzZkZoQnA1?=
 =?utf-8?B?M3Zsb1RpTk4rMUVieTBBN0dIQVRqWWsxM3RpVU95THBEMzYvK0QvbCtCQlJH?=
 =?utf-8?B?TjFxYjNWQjNodDlrN3R5elBkdFpTSTh0c2dqUGhlbktxSm1ueWJKQzgwRks4?=
 =?utf-8?B?YlptWlNUUUJLZ3J1d2lIaW8xRXBETTBtNkNZTE9WKzdWcWNTOStiaDZIYjZi?=
 =?utf-8?B?bGNMTVdQOHkxTzFFNWFnRUF5ZUtxcjVsd2J4SWppNm1yREVMM0UrRTN6NGNT?=
 =?utf-8?B?OSsxaEFSS2Y5d0JSR3N4dzgvTENUUWFIK3VsWEJqZjFwRnl5NStVdUltcWlI?=
 =?utf-8?B?TURBVTI5M092V1JUaWNEQmFITHhFekhtVEV3NU83WXl0VGpsRDBBMlVFMEFq?=
 =?utf-8?B?TTZMamU2d2xSZlNNUGxyZkJubXpCZFB4UkgxcHJOMnNTSG5nSXk3YU5FU0lJ?=
 =?utf-8?B?SEw1eFdObVdESWlEcFpiWVdCQkYyZnAwVnhuQkNnWHRESkIwc1ZlMFZpQ3p5?=
 =?utf-8?B?aWNtUVJrdUk4TkJaQmcvTGZ4czF2OWxhYzlvUFRna2hkSk5HSHA5d0dQdWI1?=
 =?utf-8?B?WjhXRnlxaUFUUC95MFo1aUVsWit1dTJYbjErbks2UXByYzY0MEw4OW1OYkZB?=
 =?utf-8?B?UDlZVzVsalpsNmxkWE5DYzdHcmJpaysvYWd6K3V6a2pGY09pVkJySDBuUGt0?=
 =?utf-8?B?YXp3T25nR1cxZ2s1dEl1M21kdm1RTlNCbk9kZTBiQVJWSlJ2N3BuR2FYVTAz?=
 =?utf-8?B?bS9FSWUzdVN6NkZLblhJVVFHbC9jWVB5bEx5L2Q3enZiWityT1c4ekY3aVRR?=
 =?utf-8?B?SUs4VGM4a3RLY2Z5RzcycFVZYlFGRHBOc2FSZDY2Ty9YK1U0V2xXSjhHdlUv?=
 =?utf-8?B?UVFIU0ExOUJWVEt2RVF6bjB2aTd4QTZaa0FUTDJ5WnJ5KzBuY0RkNzloZkt5?=
 =?utf-8?B?TUFQZ0ZsNDM4N2l0SWljTXNaOERLRmlHT0c5THFsY3NlNG51a2xiK1JWUnFo?=
 =?utf-8?B?RFgzamx2SU5ZKzVaZlFBdW1RQXpCZDBMZk5GakpNd3JWUkpSS2t0ZmV3R2Vr?=
 =?utf-8?B?ZVdkZFVHQXZra3E4ejVaOEFnR20rSlZwMUx0Z0FpZG90WjBrNzdCbEpsZTNh?=
 =?utf-8?B?eTlEd0h1MzcxYTVQM3Zpaks5Z3BueTB6c3BTYThDUm90K0JEMHpwbVRTTFBO?=
 =?utf-8?B?em5PMHRwNlFUS2djSUtTU0RaaFVDN2EzemcyQW1GM3VjTHVmU002UnNiU3hS?=
 =?utf-8?B?Rm5yL1FaamJycW1CZ0dzZ3JyempxZkNHQXdTNksrWCtWbXNUbFRndEpsZ2Fl?=
 =?utf-8?B?bld3YTNlMjAvNTNZNUdHK0lFTTk5TUtja3cvRlVyNzVwTjVOS1pzV3pycmh1?=
 =?utf-8?B?UGVUN2NPQXMrMHRGcTJSVVF1eVhtd2ltVnNEdXZ3ZEhkL1c2TVkwRXg3akNi?=
 =?utf-8?B?NVcyTFBaclpGK0FtRnh0S2Z0T21lZkZPRGNIRk9kVWc1UEhvUTN5dmNNTTNN?=
 =?utf-8?B?bUloUmVsTlFTUEpGT0JuZWxaMXdZenNRdjFKTzhGVUNoSUp3NFFlZHp6MXY5?=
 =?utf-8?B?cEJ1akROSlViS0FzbWlidmpTVHdtRlRCVVM0TkN5dFZwK2JqVlBPUTZxRU5L?=
 =?utf-8?B?TEl5NFZCeEVZTTFXL0xVNC9MU3UwTWV5QW1qMzBzaVdPcE1DK043eFA1cGxy?=
 =?utf-8?B?TjdrT004UUNIR0h2ZUZWcFhCZ2N1dnJRWThwdno0UnRMdklHc2orZlBDd0ps?=
 =?utf-8?Q?os661a+Y2dYsnEH6bRtTEUPOE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec3246b7-6438-4e86-f6f1-08dce833cb67
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 07:27:13.4250 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8hQBzjXW9EkLuipWMQ4QmqjzZh/tiaWRe1StC4d9Uy2X0K+RyEnzvl4fsZSI0ifSniYb/H1W6BNxR3MrN5iIbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8438
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

The i.MX 93 quick start evaluation kit provides a low-cost platform to
evaluate the i.MX 93 applications processors in a 9x9mm package.

Patch 1 is to add a new pll entry for 3200MTS
Patch 2 is to add the board support.

Patchset is based on imx/next tag:u-boot-imx-next-20241005

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (2):
      imx9: clock: Add 800MHz fracpll entry
      imx: Support i.MX93 9X9 QSB board

 arch/arm/dts/imx93-9x9-qsb-u-boot.dtsi        |  163 ++
 arch/arm/mach-imx/imx9/Kconfig                |    8 +
 arch/arm/mach-imx/imx9/clock.c                |    1 +
 board/freescale/imx93_qsb/Kconfig             |   12 +
 board/freescale/imx93_qsb/MAINTAINERS         |    7 +
 board/freescale/imx93_qsb/Makefile            |   16 +
 board/freescale/imx93_qsb/imx93_qsb.c         |   67 +
 board/freescale/imx93_qsb/lpddr4_timing.c     | 1995 +++++++++++++++++++++++++
 board/freescale/imx93_qsb/lpddr4_timing_ecc.c | 1995 +++++++++++++++++++++++++
 board/freescale/imx93_qsb/spl.c               |  174 +++
 configs/imx93_9x9_qsb_defconfig               |  139 ++
 configs/imx93_9x9_qsb_inline_ecc_defconfig    |  140 ++
 doc/board/nxp/imx93_9x9_qsb.rst               |   68 +
 doc/board/nxp/index.rst                       |    1 +
 drivers/ddr/imx/imx9/Kconfig                  |    6 +
 include/configs/imx93_qsb.h                   |  138 ++
 16 files changed, 4930 insertions(+)
---
base-commit: ef815d75514da91dd98f9e3278d810439fd1f1ea
change-id: 20241009-imx93qsb-d0d769ade9f8

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

