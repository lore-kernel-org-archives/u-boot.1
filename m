Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A91E9129A
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 15:17:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D627683C30;
	Thu,  5 Feb 2026 16:16:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="B3q/AILg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A458A83B95; Thu,  5 Feb 2026 16:16:38 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 132FA83C5E
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 16:16:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHjfL/zd5ZYj9xEeGBVndv44afdDQex750dnXbx87BQNaV3y31rH85uNZ/ZoS66+cFhmHK1K4XroCvQjxzmf8WTAjtkDpPdRKvRmbmILQ/wpciY5R99Ih8pv9d7o+J6kDBNhQBIcBCcCtNkPg64xBBqJO0EPfQz5oNhgF+k1wGZnzDfMOl+GyuwtS28Uoxcszy2+JFCAalIQ0+6Vvq/JIVF25RzdVGDIJApB8QNDHw/eJK/rgG1mjtW4H3Iup9Efv14POEyg3mQBgEBR0xA2xwXzVUPmAe9v0tBgAoveVY0XmY5Yo6DIZjFGT1D03xJQnG40EmWvC0aMEzx8pOAKaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXxoVa3PW5agXEODqu5U7G/M0WNASxqM9/aNYvwexVs=;
 b=IRJvSm1XbiZ7zh5olL1y5LPTjuR22xLlg2ORr9F/0idYPkj1aCSj5fW5R2CPm3/cD6QJgJsjHnIaXq61lpc+u5yY7dbiYaeeJJ/afOPgCJOO1gxAXOiw5GXF3bWT9eDTivYIj5cxbAotzBSIh+lQPPgSUQTEVOdXOn1PIopJAabKF/wV92h52CIpWmisHqR/oc68CdqS6brrZIbDtQA8ysIfdsKcw1zi7D0kxPovAgBGnIjOo9R5wHamjCWvNQrnr6LGxVaW/iNLOgPn1S2eB0JjoP8bbTb/fymRQRpyEGqF4cuXine1xdQ5UGRrBiz0Llesnlj2nj3xpZ6kBx53qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXxoVa3PW5agXEODqu5U7G/M0WNASxqM9/aNYvwexVs=;
 b=B3q/AILgcbuMpiqSGirwm0r49IjsSZcwgmZCCBMcb/+63joDd6+E04HksDcfclLhfLDW8oYj94hl4twqoxTFqgmYQ+0lfbHZZCaFuLljlCkEaevdkbuGPJbV2nGUGYXa8+8U6vPPTsk9v8dtQfF2loNSCUbOVr6DcEwtQqdLontC7GmkXCC74pqoxsFdbnOXgxjpCGwgY1LqxfuwFa0Mqet2Ksvhx5c0YTO/DSaRWp5D/UKmisskPsYIZpvZ1c4R/R4nZ6FxNogYQBylZjgyXgl9bXjNN2gWi94iFTC87pvBF3l3p/h4Rp2WOAtTA4zsOupofEDsGTXBDbsByOyGSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV1PR04MB11038.eurprd04.prod.outlook.com (2603:10a6:150:211::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Thu, 5 Feb
 2026 15:16:32 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 15:16:32 +0000
From: alice.guo@oss.nxp.com
Date: Thu, 05 Feb 2026 21:55:17 +0800
Subject: [PATCH v1 11/12] arm: dts: Add U-Boot device tree for i.MX952 EVK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-imx952-v1-11-2103d0222a0b@nxp.com>
References: <20260205-imx952-v1-0-2103d0222a0b@nxp.com>
In-Reply-To: <20260205-imx952-v1-0-2103d0222a0b@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Jindong Yue <jindong.yue@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Fedor Ross <fedor.ross@ifm.com>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Valentin Caron <valentin.caron@foss.st.com>, 
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>, 
 Ji Luo <ji.luo@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Adam Ford <aford173@gmail.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 David Zang <davidzangcs@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Marek Vasut <marex@nabladev.com>, 
 Joseph Guo <qijian.guo@nxp.com>, Tim Harvey <tharvey@gateworks.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|GV1PR04MB11038:EE_
X-MS-Office365-Filtering-Correlation-Id: 033fba5e-e419-4286-629e-08de64c98b39
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SEFKNFI2b0lkdTU1RFhTQ0J0TmFaeVlRVHhNRU9IQktNOHd5Y21pVGl1OTRt?=
 =?utf-8?B?UUo5bG5kc0R5OUIvRFhDTm9rWXd0ODZ4RVRRa1VyYXYrQjhDcTlDRVU1OERU?=
 =?utf-8?B?NExSYlBqYXhSN0djNzRuZlpaaWI0YzVEZ0tGdVAvenA5QjI2bXRtUGM1cjll?=
 =?utf-8?B?K2ozdVhvNkVWakVWeVpXTitXNEw2L0tOZnV6d2o0RSswNUZaTlRvdEdJK0dz?=
 =?utf-8?B?cUtHQTF3TW9rMHBFZXdDQ0s3RkVCN0FPMkFyTHhaMHJ3L0lwdi9WVHJ2MTFZ?=
 =?utf-8?B?NXE5M3lLU2ppVDlZQk9LU3ZsUExsK1VnUDdRMFI1RS9xN205QzVzYTVWRjlE?=
 =?utf-8?B?S2NqRTJOaGgvdEhNTE8yQmZHWTBJZ2d5V1hrUGFOZGplcHhUVm85Z0Iza21Z?=
 =?utf-8?B?UFR3Zy9KZTlKeGl6OVVyWDM4UndyL0Y1N0lDRVRDb3JneWYxdUtQRlRHTlho?=
 =?utf-8?B?bUdpNmxlTHVoejkrSmpSTEcvaklWSHBmQ0xHZ1R6TUl6Y1l2ODU2K3dYNXpk?=
 =?utf-8?B?S3lhUnZqMVRsd1pHa3RFSGlwSzlBQWZkZjdKVTVONmgvMmRycVRZQitqWVRr?=
 =?utf-8?B?WGlJb3JpaHFsOHNVL1g0Qk0waUc2cG41b0hRNStzU3NicUt4UUJuVndKZGs2?=
 =?utf-8?B?MlNLa0g5Vnc0YjJWUS9tVlltc3RPTkQ0aXd2eFF0YUtFL3pocnJsZTkxOXdD?=
 =?utf-8?B?Y0l5cDBMSWJ2d2dkTTlVcW1MdkhoZC9hUzVma0dpM3pUcEowL2MraTAvRnZY?=
 =?utf-8?B?d2VpK0ZXbE9oaTZ4VEFiNHVKRWFLYVNkbWZnekZHRjl1bHRyVEVyTzA1QlMr?=
 =?utf-8?B?QTAyUkZNNGxHQkNrbndmT016RHdnU3g1MzJxL2hicURFTFZXNEMxblFNUGE0?=
 =?utf-8?B?dUg3bW9nN0doSzM0VEIwZDJvdW4rcDcyTUxndjlhTHdHMWpxRUpPVG9UdGhx?=
 =?utf-8?B?Tkdab054RkI3TWxSNmpBZmxBOXdsdXRlTmlEYXVjbHNMNUtlOHJvYkRKaVJh?=
 =?utf-8?B?VUlMdmM4NWhIOVZ2MzlrdkJOOTJ2WkVBK3Q0Ulczd2VwLzI5OHR6SThrbmZE?=
 =?utf-8?B?WmRlZ2FLSjhRcmFvSERwSzFITGphN0RDYkFOUUFTOCs1Y3l3ZVpmWGxkWWlt?=
 =?utf-8?B?M3JDQTlLQ3RmRFFwSURFdm1WZEJodFJaWmtnd2p4VHdLODRFN1U0NjRpYUUz?=
 =?utf-8?B?MFROZ2YvMTdwQmFocUlpMzEwN2lES0ZvTjBXOUY0ZEtFbTBVMStvYm50M2Fk?=
 =?utf-8?B?UHhPMUdoWk5EQVRVVFJudDlwUFovWVJWejc2ZHdoRDF3aU83V1NQU0ZYRXpv?=
 =?utf-8?B?MGhxdmdvUUZScStObkF4cWdrS1JyWXNZTjhxaHRlYTRmbVBiWWdteElpNzZ3?=
 =?utf-8?B?ck82MldaRVlQaDB0NDZxNHZlejFyT2hPc3lpVDJWeGpSaitRNEdaQWtKMjFV?=
 =?utf-8?B?bzlsTU4wVlZNcE9IMjhpQ1l0SnRVNXo0Rk1QUk9uVTVkMG5GdGoxdEVVd2ZY?=
 =?utf-8?B?V2traWQ3NFhBTHhQSGl1a1hiRDNZdHZTUnFTSm5KZUcwOFJ0Uk03bCs2K09B?=
 =?utf-8?B?dEV0bjg5Qk5LZUx2Z1NreVlTbmh4S0E3N1VkMTQwc05Fa1I3RVRyNDdqZkhG?=
 =?utf-8?B?WWVoZTMzRzk1aEJyakdpMVV0RnBrcm1pb3dBSEhxZVpiVEtqTnJYMmVOME9o?=
 =?utf-8?B?TUVFUURJUjBiSWFMcVlLRldHQUVTc1FHOG92M21WejNmWkhWTjNtLzFGTkZ1?=
 =?utf-8?B?Tk1kbVRFaElFem92cVdLK2tjcllHVmhtb0pXeU0zQTArVmk2b2wyVzl4QUFq?=
 =?utf-8?B?VHFXM0NrK2diSUdtSi9kY1B5VWFkQUVuSlJCdnEvZGpjYzFWS05qN3NQeG9x?=
 =?utf-8?B?UEZ3ckk5SHhncXg3eW5lZ3NhZllJRmNRb0lmamlDMTRTQi9FQUxmR1pmM1RT?=
 =?utf-8?B?NUFHU0RZT0hPS3JQcWpDODNQK1psNHBETE9KUkV1OTcxcnlVelFXZS9PeDZx?=
 =?utf-8?B?N3ZTM2M0WWVneklTSDBOc1lXQWk0Nmg1RWxKZTI0Q0VmUXFxd05vVUQ1UHdX?=
 =?utf-8?B?Yk1jNnQyb0pLOTF2cWlQcytLUVVQUFFjaVY0Z2w4NUQyMjhST3BpWmh0bW44?=
 =?utf-8?B?MlltMHZYSmFSdDdyU1NhUVRpNDZJeHY5VGE3NUNFZ2JCSmFvbXJXNmtLeUNU?=
 =?utf-8?Q?5HVoIxeyI9NkRu436xu1P88=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUs0WFlNMnBVdUZ6SE9DSWk4TXZMKzJ3alkxSkhhbUVrSHJyNUZWSkJTMGVR?=
 =?utf-8?B?VHAyYVl6elcvVHk1eVZzbU1IWHVaMndwTTJham5wM1VENDVDK3dEaHV1VnBJ?=
 =?utf-8?B?MXdjSGI5Q0QwZlZObkRNUlFzYUVxcEc1UjJvdm9IL0hnSDBNSVpVMERWY3VF?=
 =?utf-8?B?dXVWWnlNdzluT1ZzZGFFenIwOWxtQXdiYWVJblBLMU9hNGdnVVZTOTRIWkhZ?=
 =?utf-8?B?YkNJTVF4cERoZk1MM3ROQWM3djE3NDN1bFJrZkdGRFZBRThNRUNwb1JCVWp5?=
 =?utf-8?B?MzJsWnFVZFhFODdzVGlSZXlXMnhROWdUbEdKemphNjJaZWhvOVNHeXpiTU9q?=
 =?utf-8?B?b1I1cTJybHdpdGJqeUh3TGRZOWwrZm95Zzg0amhYWGxhUWNPNUpZUiszNk5N?=
 =?utf-8?B?UlFuWDZ1cndVckRGVUt5TVBTTTZHc2xLZGZOS05XY0JzTC8xTmk5WS8wejJo?=
 =?utf-8?B?UkpEQisxT216dFBPTG9yOEh4UERrblRhRGJoZDlzZW4wOGEvbklaRkswVldJ?=
 =?utf-8?B?L2s5amZ2V3dCeUF4eUNXejRJNklDNkdHckduZ3ZtbVRJQ2p2NlAxR3dZMjhD?=
 =?utf-8?B?ZmZrQ1JOMG91OVdyVy9GT2hYNk1iNlRtZHpma05ibVd1K2JDTW93V2szeFhq?=
 =?utf-8?B?SFdrakkyRUZ5V3NQRlVHaW03ekNpY2pYTmo5QzNOM1dPY1hsb0JQWXprQmtE?=
 =?utf-8?B?b3p4SldVekdaNU05MnVhWW15NGVESTNlUGZLRnZOc296cnE1UE1BRmdUMG85?=
 =?utf-8?B?bEpwUHZrNjlMWUNCM1BITWtWL0F3bm9NYkMyTGFvRFN1dnlyZXZUOEVvVytz?=
 =?utf-8?B?RUNBK3dhekJuOTRNeVRRZGFxQ3dEcWg4Mk80K2tQZzZtZmlWcEw4dkFmV0pU?=
 =?utf-8?B?THZGVG9pNE9GTSt5VEJaVVR1K1VlUzd4eUhObTRBS1hsUm1OOEh2aTcrSDhE?=
 =?utf-8?B?SVlJOElHbGdkVEZwZDQxOEZaaEhodzBtcGgwV0srSGNIMFJKa0lQbWpRTU5Y?=
 =?utf-8?B?UlZzZGw2RVdTVG9qNHV2eWNYWnVtbm9PRmt3UWZXcjdWc0pqUHZzM3o1UEN0?=
 =?utf-8?B?VmdDUVVvSDVCemx1ZzEyVmNQUHhpcGQ1Y0VjUEZnekx5bUM5YmVVTzR6RTVm?=
 =?utf-8?B?NERjUmZjcDA4bjFYUUZCMElhbnJ1SitqVzI4MU5tRFhBWFhNenB4RExCTjIr?=
 =?utf-8?B?YnJCNWNRT256RWM1REpXL1BFcUZQY0ZLamllV3FMWHBoUjZ6QVRLUHNsSEpJ?=
 =?utf-8?B?emlSall3NFlkYlhHc3lyQlEvakQyZEpGWHEwYjNnQXA0ellMLzdOV3RwdGVo?=
 =?utf-8?B?dEhzdnIraXhabSs0TG1oNWlxVmcrOE9JVlkrL1QxcVlkbU5XR29vaU5UNzdT?=
 =?utf-8?B?WnVLdVJxNEpCYkptY293N2FGcVJYaXJCZU05V2FHVVFYSkdNUnBsa1diYjl4?=
 =?utf-8?B?aGltRk5uN2s2ejdQQlAvOFJ1bGxtOGdQY2NlMmZEOFZ3NlpGdnVGLzBuOGpz?=
 =?utf-8?B?WmxEaUo1UlRuTFRHanhlbkZlcHlLczA0aDFnMGVCY1VuZXBRNkRYRm9sNWVB?=
 =?utf-8?B?NXArV0cxKzcyUlZhYmhzTWRvalBiYU5zdnJNSzgzYTV0bWtkYW9NTWphQWVG?=
 =?utf-8?B?U3crVE11S3pNZ0tjRkx5NTg0eWo1UktUNkFiMFpzbWcwT1BzTXpRUGExTWti?=
 =?utf-8?B?cWcwSnZoako0d2dncnZ4OTRMSU5Ia084U21uTm1xbUNEaGVEdUJmR2VuSGl0?=
 =?utf-8?B?MHJySnNqUi9HZU5VOHFmMURtMEExL3JLNDVhN1dWQmsrVGZBRmNSNWNLa3Jx?=
 =?utf-8?B?VlZJQTIyZGtRWU5udW5MVmdDZjc0cDAwN1FtTTQwMFZuVjcrYnV6d0wrb0gy?=
 =?utf-8?B?RG8zV0U3QkNzV3d4OFErWHBCZnhjTXdiMmVwREFPT3ZncmJmN0IvZkp4TEVx?=
 =?utf-8?B?MGJOUFN3WU9LTWJqYVRtd1prclhZOEQ4S3pIYjJSWW5GYXI3Z2tFZzVZNlJv?=
 =?utf-8?B?VmkvSXZySFlFaWxiOGl3VTYrSm92akJ5QjV0ZlhvWWhiVEp5T256c0VJN0xH?=
 =?utf-8?B?Y05ObUtHWUcxd0ZJTTFKcElkcDlIc3I3WjczZmlWQzZuVFNMSy90WkZLUU83?=
 =?utf-8?B?MjJWb1ludEtiWEkvK0RXYklZTWxsdVkxRTk4VFRUeDZMYXpJUVlyVi96czB3?=
 =?utf-8?B?alNSSVFkZXNHVHZFWVVHbVlDd000T2YxcDdNWDc2L3FmK1dwRGIxRFJBT3h3?=
 =?utf-8?B?cHIyK2g1ZFNlNGEvUVRWRVJYbnZ5dVVmUUdrZi9jUG02WGJ0M0JCUmxGQ0o0?=
 =?utf-8?B?cTF4bTlHb1ptYWN5Q1hkUCtHNkdtZUsraFl0S3hGdnMxdzF3WnMyUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 033fba5e-e419-4286-629e-08de64c98b39
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 15:16:32.2241 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rHexp1xf/b4ndyMdtW+/nJsyxPvCUh935tmZBFZUP/PWUOFlv3z9aCIaMxCeMbCwzBsHg6RgRj/+7ZU7Bpfteg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11038
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

From: Alice Guo <alice.guo@nxp.com>

Add U-Boot specific device tree configuration for i.MX952 EVK board.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx952-evk-u-boot.dtsi |  58 +++++++
 arch/arm/dts/imx952-u-boot.dtsi     | 327 ++++++++++++++++++++++++++++++++++++
 2 files changed, 385 insertions(+)

diff --git a/arch/arm/dts/imx952-evk-u-boot.dtsi b/arch/arm/dts/imx952-evk-u-boot.dtsi
new file mode 100644
index 00000000000..1b2c314a41b
--- /dev/null
+++ b/arch/arm/dts/imx952-evk-u-boot.dtsi
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 NXP
+ */
+
+#include "imx952-u-boot.dtsi"
+
+&i2c3_pcal6408 {
+	compatible = "ti,tca6408";
+	label = "i2c3_io";
+};
+
+&i2c4_pcal6408 {
+	compatible = "ti,tca6408";
+	label = "i2c4_io";
+};
+
+&pcal6416 {
+	compatible = "ti,tca6416";
+	label = "i2c6_io";
+};
+
+&pcal6524 {
+	label = "i2c7_io";
+};
+
+&usb1 {
+	compatible = "fsl,imx8mm-usb", "fsl,imx7d-usb";
+	/delete-property/power-domains;
+	bootph-pre-ram;
+	extcon = <&ptn5110>;
+};
+
+&usb2 {
+	compatible = "fsl,imx8mm-usb", "fsl,imx7d-usb";
+	/delete-property/power-domains;
+	bootph-pre-ram;
+};
+
+&usbmisc1 {
+	bootph-pre-ram;
+};
+
+&usbmisc2 {
+	bootph-pre-ram;
+};
+
+&usbphynop1 {
+	bootph-pre-ram;
+};
+
+&usbphynop2 {
+	bootph-pre-ram;
+};
+
+&wdog3 {
+	status = "disabled";
+};
diff --git a/arch/arm/dts/imx952-u-boot.dtsi b/arch/arm/dts/imx952-u-boot.dtsi
new file mode 100644
index 00000000000..208931ba884
--- /dev/null
+++ b/arch/arm/dts/imx952-u-boot.dtsi
@@ -0,0 +1,327 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 NXP
+ */
+
+/ {
+	binman {
+		multiple-images;
+
+		m33-oei-ddrfw {
+			pad-byte = <0x00>;
+			align-size = <0x8>;
+			filename = "m33-oei-ddrfw.bin";
+
+			oei-m33-ddr {
+				align-size = <0x4>;
+				filename = "oei-m33-ddr.bin";
+				type = "blob-ext";
+			};
+
+			imx-lpddr {
+				type = "nxp-header-ddrfw";
+
+				imx-lpddr-imem {
+					filename = "lpddr4x_imem_v202409.bin";
+					type = "blob-ext";
+				};
+
+				imx-lpddr-dmem {
+					filename = "lpddr4x_dmem_v202409.bin";
+					type = "blob-ext";
+				};
+			};
+
+			imx-lpddr-qb {
+				type = "nxp-header-ddrfw";
+
+				imx-lpddr-imem-qb {
+					filename = "lpddr4x_imem_qb_v202409.bin";
+					type = "blob-ext";
+				};
+
+				imx-lpddr-dmem-qb {
+					filename = "lpddr4x_dmem_qb_v202409.bin";
+					type = "blob-ext";
+				};
+			};
+		};
+
+		imx-boot {
+			filename = "flash.bin";
+			pad-byte = <0x00>;
+
+			spl {
+				type = "nxp-imx9image";
+				cfg-path = "spl/u-boot-spl.cfgout";
+				args;
+
+				cntr-version = <2>;
+				boot-from = "sd";
+				soc-type = "IMX9";
+				append = "mx952a0-ahab-container.img";
+				container;
+				dummy-ddr;
+				image0 = "oei", "m33-oei-ddrfw.bin", "0x1ffc0000";
+				hold = <0x10000>;
+				image1 = "m33", "m33_image.bin", "0x1ffc0000";
+				image2 = "a55", "spl/u-boot-spl.bin", "0x20480000";
+				dummy-v2x = <0x8b000000>;
+			};
+
+			u-boot {
+				type = "nxp-imx9image";
+				cfg-path = "u-boot-container.cfgout";
+				args;
+
+				cntr-version = <2>;
+				boot-from = "sd";
+				soc-type = "IMX9";
+				container;
+				image0 = "a55", "bl31.bin", "0x8a200000";
+				image1 = "a55", "u-boot.bin", "0x90200000";
+			};
+		};
+	};
+
+	chosen {
+		bootargs = "console=ttyLP0,115200 earlycon";
+	};
+
+	aliases {
+		usb_gadget0 = &usbg1;
+		usb_gadget1 = &usbg2;
+	};
+
+	usbg1: usbg1 {
+		compatible = "fsl,imx27-usb-gadget";
+		dr_mode = "peripheral";
+		chipidea,usb = <&usb1>;
+		bootph-pre-ram;
+		status = "okay";
+	};
+
+	usbg2: usbg2 {
+		compatible = "fsl,imx27-usb-gadget";
+		dr_mode = "peripheral";
+		chipidea,usb = <&usb2>;
+		bootph-pre-ram;
+		status = "okay";
+	};
+
+	reg_m2_pwr: regulator-m2-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "M.2-power";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pcal6524 20 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		/*
+		 * M.2 device only can be enabled(W_DISABLE1#) after all Power
+		 * Rails reach their minimum operating voltage (PCI Express M.2
+		 * Specification r5.1 3.1.4 Power-up Timing).
+		 * Set a delay equal to the max value of Tsettle here.
+		 */
+		startup-delay-us = <5000>;
+	};
+};
+
+&A55_0 {
+	clocks = <&scmi_clk IMX952_CLK_ARMPLL_PFD0>;
+	/delete-property/ power-domains;
+};
+
+&A55_1 {
+	clocks = <&scmi_clk IMX952_CLK_ARMPLL_PFD0>;
+	/delete-property/ power-domains;
+};
+
+&A55_2 {
+	clocks = <&scmi_clk IMX952_CLK_ARMPLL_PFD0>;
+	/delete-property/ power-domains;
+};
+
+&A55_3 {
+	clocks = <&scmi_clk IMX952_CLK_ARMPLL_PFD0>;
+	/delete-property/ power-domains;
+};
+
+&aips1 {
+	bootph-all;
+};
+
+&aips2 {
+	bootph-all;
+};
+
+&aips3 {
+	bootph-all;
+};
+
+&clk_ext1 {
+	bootph-all;
+};
+
+&clk_dummy {
+	bootph-all;
+};
+
+&clk_osc_24m {
+	bootph-all;
+};
+
+&elemu1 {
+	status = "okay";
+	bootph-all;
+};
+
+&elemu3 {
+	status = "okay";
+	bootph-all;
+};
+
+&{/firmware} {
+	bootph-all;
+};
+
+&{/firmware/scmi} {
+	bootph-all;
+};
+
+&{/firmware/scmi/protocol@11} {
+	bootph-all;
+};
+
+&{/firmware/scmi/protocol@13} {
+	bootph-all;
+};
+
+&{/firmware/scmi/protocol@14} {
+	bootph-all;
+};
+
+&{/firmware/scmi/protocol@15} {
+	bootph-all;
+};
+
+&{/firmware/scmi/protocol@19} {
+	bootph-all;
+};
+
+&gpio1 {
+	reg = <0 0x47400000 0 0x1000>, <0 0x47400040 0 0x40>;
+};
+
+&gpio2 {
+	reg = <0 0x43810000 0 0x1000>, <0 0x43810040 0 0x40>;
+	bootph-pre-ram;
+	/*
+	 * Use one SPL/U-Boot for mx952evk and mx952evkrpmsg, since GPIO2
+	 * is assigned to M7, disable gpio2 here
+	 */
+	status = "disabled";
+};
+
+&gpio3 {
+	reg = <0 0x43820000 0 0x1000>, <0 0x43820040 0 0x40>;
+	bootph-pre-ram;
+};
+
+&gpio4 {
+	reg = <0 0x43840000 0 0x1000>, <0 0x43840040 0 0x40>;
+	bootph-pre-ram;
+};
+
+&gpio5 {
+	reg = <0 0x43850000 0 0x1000>, <0 0x43850040 0 0x40>;
+	bootph-pre-ram;
+};
+
+&lpuart1 {
+	bootph-pre-ram;
+};
+
+&mu2 {
+	bootph-all;
+};
+
+&reg_usdhc2_vmmc {
+	bootph-pre-ram;
+};
+
+&scmi_buf0 {
+	reg = <0x0 0x400>;
+	bootph-all;
+};
+
+&scmi_buf1 {
+	bootph-all;
+};
+
+&{/soc} {
+	bootph-all;
+};
+
+&sram0 {
+	bootph-all;
+};
+
+&usdhc1 {
+	bootph-pre-ram;
+};
+
+&usdhc2 {
+	bootph-pre-ram;
+};
+
+&scmi_iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_hog: hoggrp {
+		bootph-pre-ram;
+
+		fsl,pins = <
+			IMX952_PAD_XSPI1_SS1_B__WAKEUPMIX_TOP_GPIO5_IO_11	0x3fe
+			IMX952_PAD_GPIO_IO12__WAKEUPMIX_TOP_TPM3_CH2		0x51e
+			IMX952_PAD_CCM_CLKO1__WAKEUPMIX_TOP_GPIO3_IO_26		0x3fe
+			IMX952_PAD_CCM_CLKO2__WAKEUPMIX_TOP_GPIO3_IO_27		0x3fe
+		>;
+	};
+};
+
+&pinctrl_uart1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1_100mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1_200mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_100mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_200mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_gpio {
+	bootph-pre-ram;
+};
+
+&pinctrl_reg_usdhc2_vmmc {
+	bootph-pre-ram;
+};

-- 
2.43.0

