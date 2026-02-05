Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01632E91298
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 15:15:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2E5B83693;
	Thu,  5 Feb 2026 16:15:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="A9g5+BGc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 650F183AA4; Thu,  5 Feb 2026 16:15:16 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69E2F8341A
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 16:15:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cAzzITGR0w9LpYYPO93cvfsHR1wY569tQ49k9B3oxlpet42Qulu/xgmKnMO/IYyT8jHneAH5a5D5E31wyXB+6pbNDuVenXZbKO8aaUX9FSftERZNFpR3FajPH7yMHAsWN9VY4UEhpqRf7T4BSUTyhHz8f0cxV4Wm92+z7BbYviRcIaR+BDHkGPOc08r56otHt26ocel6Qfb054mFkOL8qZt1C8zRUbHQryOErpI6vFnCLAE1G05i3AqvCNyEBFS+7J2xXRlVHf0TeW/6AotTWNGGvkAI1ftRFdEc9yGM347kc+pvUrDy9ZZZR0CyZGFa/Ec2i1M7uRpY8aWObkbpcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqlceRU9IUiBnAqVuEhSivhJandkNb9qi6oRnv39ONE=;
 b=TBZb6d2duvZxEhCTc26qffo2RGGj9ilvHMHq7S3t/zSGzOU/2mRRsQMmgyeD1TZoBB01i3mgPadsFx3fXHtluKlO+Ay7ffSDGrM2RwTVWRkDEUBsoU1GSZ9MxU6MTAdMIojYcfyRC0WzmNkkhO02xvT7UuHrmf+C6fOVOoF7Vh6rHHXxy1WoVF4dJZeTE73GJdJCifrifQFD+MkJQKhdErMznKYSY6LoQoa1jPa+JNXGnoDy0+nGpbhi36cj678n7uuOMEWGrLBCZRz9Ms8KpOgLDh4qWZgOOJAx0kOTbxw1Hgi2BdTaJB472w/naGNv9QmGGVtblkXwgeJ2Ao1q8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqlceRU9IUiBnAqVuEhSivhJandkNb9qi6oRnv39ONE=;
 b=A9g5+BGcmq2q5Tue2CDpZQVJOKfKDyJFwSaRbBWIOigtI0f2CN489J6fKNUWjRfcVm0WEku5iv8Fl+MxfM8vabMOnHIQH/S6qqQpvfQDhUmz8DJ0uuZZx51p+3H44Cn69hdpq8+sfvLCWvJyWP/YkTEUU1hBf4cQSfFLWk7UjkUfZsPNZTmtNJ2YcSa2etPecMv9d6wehqmstOCyU5ZJYeK92cZgoAuIF5inksXCj8OlDNLFNpElInJ9NLq5dPinDS7AKEWJgsq4OOFGprdkFZIkcxjEkAKNXkpW9b0ETmqZDDbNaXJM1Hj2i1xHlZ/vkvynbkiS5IqsMjVJWZE2oQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7233.eurprd04.prod.outlook.com (2603:10a6:20b:1df::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 15:15:11 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 15:15:11 +0000
From: alice.guo@oss.nxp.com
Date: Thu, 05 Feb 2026 21:55:07 +0800
Subject: [PATCH v1 01/12] imx9: scmi: Get DDR size through SM SCMI API
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-imx952-v1-1-2103d0222a0b@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM8PR04MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e16955b-8b35-4425-e535-08de64c95b40
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|19092799006|1800799024|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dldIb1cvSlNSYzFLMmI2VzNzRDJjdVdUV3VWS0xoUlE5T3B2ZjdJQ1RqOFlH?=
 =?utf-8?B?MXdNWkFaN1ZOeExrZjEvSlNQcjdjK05BSW8rQWJOQnpVS0RvZmdLd3FhV25D?=
 =?utf-8?B?b0hLYmkzRmRuQzlEUnZNTElNdjcxeCsxcGxUeXlsL3E0dmtibTNKNzN1OHM0?=
 =?utf-8?B?TGFpOWVldFFzQXRteGI0OEhrV3pEckpSc1pmaGU4b0NqdG1oa2svQVI2S1hq?=
 =?utf-8?B?VzlUZ2FyNGpOUDdDQkNnUVZ3R0drazFzSjhVZksyOVNISTZIK2tscXhlNkND?=
 =?utf-8?B?Mmp4NzFMbUVrcXNlQmFKMjcyS1oyeTB4b2xmQThKNytHVVViMUhGSUh0QzRj?=
 =?utf-8?B?VXY4cS9YL3ZWQk1abW5hakhmNG5yeUN6bXhLV21rVk5LWFo0UXZDS3ROM3Qw?=
 =?utf-8?B?SVd0dkplVWlUbXNTem1lNEZkb0xKR2w5SjIrM3F3SWZWQ3Fib1l4QUI1TlA3?=
 =?utf-8?B?Tkp6UUU3aEZ2OUpNWDNpSW9McldIS3U0WGt3ZGRubEphRjl4ZWlXdU9EKytB?=
 =?utf-8?B?bVZVRDd6cVprcVY0Z2xqVzFWMFRSQkx5SHpFT0xQZk4zRDRuVTlQSjFCY0lN?=
 =?utf-8?B?K1hzS05hU2krME1BTCtBZFdKOThLMVM1THVhWGtiYmRBcDgxby84N1ZZd0Q2?=
 =?utf-8?B?Ny9IeDhKVXl0cEhtK1dTenhidFRnaTlhMmVPajZtZU1uOWkxMXZZRzhPNGx1?=
 =?utf-8?B?NSs3UVQ1Skd5N1g2cDJXNWNUZThrVTJ2UkljZERablJnZ3dwa08xV3pvMmZp?=
 =?utf-8?B?S0JxMUpSc1RCNGc2T2E5VU01cTlVaGVaOUI4cnhWZzg1WkZlcGtlVEluNlZC?=
 =?utf-8?B?T1l5T0hpK2gzTXozUksya3FnaUhBWmFJaXEwK0hTekpYVkRtck8xRmVuS2Z0?=
 =?utf-8?B?WEpET0U5SFlOM3crdm9oY3hvREE4azFLVWpCMHZua3lUK3dwUTJ3dERJVGMx?=
 =?utf-8?B?YkNHMEs0UE54N1hiOTFyeW0wcyszNVZXVy9sa3p4UmV0YjJhZFQ1MTFVTFhD?=
 =?utf-8?B?NUhYVHpBTXlUL0NzbzFweTdjeUNNNFVnWU5oTEp4N3FtY3JRajZMUVJDUlAz?=
 =?utf-8?B?SmJsTFRZSTBTZjN4SU1ZMDZ6T0k3RkVlVUNTLzA0NkZNOEZMNFlEbVB3RDdV?=
 =?utf-8?B?WVA2bWl6enBCU2gxOVJ5ckRZV0JLYmoyTlQ4RFArMUU2eVd2N2p4SXZWVjlt?=
 =?utf-8?B?ZENJRDZteG9IVVlURkRCdnhvM2JEMFFTam9ORjhEck51b0c1aHQzKzRlbVpX?=
 =?utf-8?B?SXB1V0VIUnlySWZhQ29aSmxVYkpmUzNkMGdab1FKYlpCWlhuOVU3TkJPMW5a?=
 =?utf-8?B?VmMwV0dZazVOQ0tobG1FVHcxY1oyd3NoeU42dEtlMUJuLzBmVVJheUdKSXoz?=
 =?utf-8?B?U3ZnaVFkMU1pSkFhU0VrWHhuRXRySmEyZ3AzR0kzWWk5NzhCQnhGMHM5cUs2?=
 =?utf-8?B?aUFXL0FsVERGdm83UEpKZnJJSHUvMERiSitQcmFmVG1NZU81aTM2cld6TE0r?=
 =?utf-8?B?NjNaL0RtQ3hvdXA0SXYxY2hZL3lxdW9JbGtocGtad3k1YWhkbWc3WmxBc05E?=
 =?utf-8?B?S1g1cHpiYTcySVY3TzU1QmszUzl0Y2dJeUJlUzcvaGxEanhkY21IQkdOMzZ3?=
 =?utf-8?B?RnlzZDBYM2RRYkhuUmJJaHBCU3JYTVRobGVOczJpbEFGbDAzOGt1SEJ4MGk5?=
 =?utf-8?B?b1VxaEcrMjQ0azZ6NjlYSGdvN0xpY2FyUS9LaEs0V2tTTVdvcXV5Q2pwQXYx?=
 =?utf-8?B?a1NWckFUTGowcGVlNGNoTGZuTCtQajFGMStjUndlU2MyaHIzdTY1QUpucEQ2?=
 =?utf-8?B?anBLVTROT1hRRWx5Z1htb3ZOMTdyT1pUTlF3NHlQYTdnbnh2czNZdC90S21J?=
 =?utf-8?B?VUdmOXlhVDEza0liSklHb0tzSGJSSkVDM1d6eWNsbDhQYWEyVDY3REl1TGxi?=
 =?utf-8?B?bW0wL2R3UjB3LzQ1SjU4MjBSZ1dRRWZ3YXRMRnJPZThTTHBWei9SNjFROFhG?=
 =?utf-8?B?L2UwN1BBS1hMS0p1S1hMa0JMaytJVkRwaVVhWnhsU0x4WnIyZnJQeXF5MXV4?=
 =?utf-8?B?Mk9jYm5jMXZqMUY2SnprckNzWTZLTUlnQ2wxem96QUF0WTV2TG9OK3F5eFcv?=
 =?utf-8?B?NllPdlhhMGZ3TlBoRVNOUUpUeitUa0t5ODJMdTdOYmcvaXFybDIxcTFoOHc1?=
 =?utf-8?Q?MwoFQ7w16RkCWExDKQZW9cw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(19092799006)(1800799024)(376014)(7416014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnFmYVFNbnZXc3lpempJRjhWSWxXekx2K2VoVTlPNXN1a3gvaTI1cXdUeUtx?=
 =?utf-8?B?ZUdPVWlGMHZHMXA0REN3cWxORjNKditocnR3c1BrODdScXVzYVVERWl4aW5H?=
 =?utf-8?B?eVB5MlgzYW41b05RdHRvV3U0Z2pOa0NYS29KUlFidTNuR2R6ZVp1alZ2S0Y4?=
 =?utf-8?B?MHJhTVY2NnNHL1paRWVMVHh4YVU0c2VJWXZRcEI4SUt0cWxkc280TllZYzJP?=
 =?utf-8?B?cjhIdTYwUFBQOW81QzNvcmYwOEgwelFpUWxYL0RJbkMvWXVMSUYyam9HSmVL?=
 =?utf-8?B?K2p4VFF4a2Fwa2lUUXZBWFJlZE5wVjQ1VzJRMUVtZEVFZjZpNndpQi83U0FD?=
 =?utf-8?B?V3NudjdGV3Y0dlhIbnZFTXlLRCtXUUlHUXgwNHNNSVNZNkF5Z05ac3h0OTMz?=
 =?utf-8?B?cHllTEYxTWZyblhwMWhNNHA3Ui94RmZtc2tJVUZBcnJvL2hxMDJ1RW9VK0l5?=
 =?utf-8?B?SXg5TWxXMGVxRmRwRG5sb3hZZ3EvcUZnQ2pKTGtBVDkxc1ZnMVVuRVA2aGFO?=
 =?utf-8?B?b2ZkQlVyN1lZRU1XZmVSSnE3cW1vOU1rOXp4akpCdkc5ZmxQM0Z2cG9UYVNs?=
 =?utf-8?B?MmRGb0NnNGJWdkhwN2Jva0dJU2cvOGoyekRXbEt4Vk5xN0NIcTFRUjJTVjMv?=
 =?utf-8?B?U3NWMVRJazU2WFJEVzRkTlY1SVJtS2tmUUFqUnVRSnlvcHlVb1IrU3diZ1kw?=
 =?utf-8?B?cUtaZlVqeFA1THJnRXB1eGJUVHJsMjJBM2pwckc2VHorQ1dzVzlrR0xYQ1NM?=
 =?utf-8?B?M2VMQjVCNnlOeStvekN0amI0Y0Y5Y20xNGdGbENnRWgweVJZcU1PWGhBQWo4?=
 =?utf-8?B?c2ZoR1M5MnM1Q29sMysxSHRnMWw0bmN5ZU9ISC8xRHlLc2k5Z0hqdko3TldH?=
 =?utf-8?B?UUVobkN0K09kdjZVNjNuNFdrVFZuZGhqNHFyQkt0c25BZGxaeTByWjVtdWhj?=
 =?utf-8?B?WkQwUTEvZzJtbHkzL1E5Y0hrbzdBQzc3c2VzK3FzbndXMkpMRzh3aUlSU1Bm?=
 =?utf-8?B?Q3pMcnE5RkI4YURMZ2Uyd2dTb3ZBOWN4enlmNGNqYVYrRVRYSnMvNjRONGln?=
 =?utf-8?B?VGtQUFRsUmZseWF1UHpjNFBIc1RqbVY1VE8zaHdkSXJNV1JtQzBtQ3lkZ2sz?=
 =?utf-8?B?bjZsWGtsSldjRFVjQVlLTWxmSkRjOXJ0cFd2a0dyTWt3ZnlTREYzS3hxOGoy?=
 =?utf-8?B?MUhKc0dKSHlIMTBhT2FiaGFrMEdGUHB2RmFSalF2allYSGJhZGk5OE9WWVRQ?=
 =?utf-8?B?S09ZdnpvZ0doUEUyNHRkeEpoL3ZzSFlrc0ozQ1F6ZkhUZVlsK00zWkZpYVRR?=
 =?utf-8?B?cmtFOHY1dFhKdC9jd1pMaHRhejh2WE82VVgrSFJYNHJNMlZSbTJjY1RNODZR?=
 =?utf-8?B?bkhzemVCNjVENTdRWHl6bjhsSnRyYVB3a1dneFJzb1RGNVh1ZFoxS0MrYXZE?=
 =?utf-8?B?MHJRc1pna2RmTC9IOGVYRis2K0l2dzAvTGxLckc2dGFiRDFrc2IyeWwxZjJy?=
 =?utf-8?B?ZkEzZlA0Zk9DOXpGZ0VCQjZQaHNWU21CbnJqNGEwTjVEU1g3UDlkUmk2L3ZK?=
 =?utf-8?B?NW5zRUZsQ2M0TUprK1lHT3VGd1JsQUU4YjJEOVNjUEJTYUFsSkVoK3crUUZV?=
 =?utf-8?B?czAycnZheXdYaE8vRnhYL0h1enpwdUJFZGV2U1ExdkdZZWpBeHhCTDRYdkJM?=
 =?utf-8?B?RTNUSk5VWDBmZ1YwNXE4elVOS1MwVTFnWkNEQzZjWFNiNjg3bWhSWFQ4UzJ2?=
 =?utf-8?B?N1JFeldKSWQ3N1dlTWpzUXYxdlF3STVFUU5qcnlUTDBiV2V0bHFoZ3lHQ1Zm?=
 =?utf-8?B?MVhQRXppQk84M1hSU1NtbHNMOGNwQjc5OHF3QU9OYzAwYXdrYjNpV1A1MVdp?=
 =?utf-8?B?TFpGQ29UcmdJNStPYVBYNlVodVZFeXcvenY4TlkrTHJSRzU5Z1ExNnlNdllQ?=
 =?utf-8?B?c3AyZnJXUjhRQnpMOWxlbXNQSEdBRHVkME5EaU9jSXlsaTc3ckpuRFZxeE84?=
 =?utf-8?B?QTdKOHl1YUdnYnZlbFJPYVJ3MEx0N1NPOVpFT0w2NjJVNXV4dGZwdFlLYno5?=
 =?utf-8?B?cDdnUmZXRStNMGt6MVJDZ1REV1RsYkZyVjQyVjZMbTlHNlQyeForODNKbUMy?=
 =?utf-8?B?SllyVEdwOEFQY1B4eXBibFNBc2pwZ3FHRm1mbEI4ZGZ1L0tudlRMd1hwSy9t?=
 =?utf-8?B?UHVWaDJ5dkhaZjd1NG1BbDVDZUQ3S09zWW1UempPMTNLWEh6VzFRN0ZuZGEy?=
 =?utf-8?B?Vm4rTGhXSE1uekNCV1BVTFJ1RFgrb1ErMFM4d2MybnNvdG9HMDUxVkhuZU9B?=
 =?utf-8?B?VzVhZVdYZ1FlYW9oN0VOL2RweWxmUFdncTNrN0JxeW94UGd0UUM0Zz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e16955b-8b35-4425-e535-08de64c95b40
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 15:15:11.7370 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: REJE6cvW0v3gTXnjk8gGymCyxCX2s/JbCWRkxZwMMj8lqQ4iLztq9drhFcKY3asXKM4FNbBZjI2OjbZQsD9Itw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7233
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

From: Ye Li <ye.li@nxp.com>

SM has implemented MISC protocol for get DDR info. Using this API, u-boot
could get DDR size instead of static configs. This will facilitate the DDR
ECC enabled case which has 1/8 DDR size reserved by ECC data. SM get DDR info
API provides the reduced DDR size.
To be compatible with old SM, if calling this API failed, will fall back
to static configs.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/include/asm/mach-imx/sys_proto.h | 10 ++++
 arch/arm/mach-imx/imx9/scmi/soc.c         | 76 +++++++++++++++++++++++++------
 include/scmi_protocols.h                  |  3 +-
 3 files changed, 74 insertions(+), 15 deletions(-)

diff --git a/arch/arm/include/asm/mach-imx/sys_proto.h b/arch/arm/include/asm/mach-imx/sys_proto.h
index 46da7a1eff5..6c8bd6c9085 100644
--- a/arch/arm/include/asm/mach-imx/sys_proto.h
+++ b/arch/arm/include/asm/mach-imx/sys_proto.h
@@ -254,6 +254,16 @@ struct scmi_rom_passover_get_out {
 	u32 passover[(sizeof(rom_passover_t) + 8) / 4];
 };
 
+struct scmi_ddr_info_out {
+	s32 status;
+	u32 attributes;
+	u32 mts;
+	u32 startlow;
+	u32 starthigh;
+	u32 endlow;
+	u32 endhigh;
+};
+
 #endif
 
 /* For i.MX ULP */
diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index c1458ccca3c..e573736825c 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -58,6 +58,35 @@ uint32_t scmi_get_rom_data(rom_passover_t *rom_data)
 	return 0;
 }
 
+int scmi_misc_ddrinfo(u32 ddrc_id, struct scmi_ddr_info_out *out)
+{
+	u32 in = ddrc_id;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_IMX_MISC,
+		.message_id = SCMI_MISC_DDR_INFO_GET,
+		.in_msg = (u8 *)&in,
+		.in_msg_sz = sizeof(in),
+		.out_msg = (u8 *)out,
+		.out_msg_sz = sizeof(*out),
+	};
+	int ret;
+	struct udevice *dev;
+
+	memset(out, 0, sizeof(*out));
+	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
+	if (ret)
+		return ret;
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret != 0 || out->status != 0) {
+		printf("Failed to get ddr cfg, scmi_err = %d\n",
+		       out->status);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 #if IS_ENABLED(CONFIG_ENV_IS_IN_MMC)
 __weak int board_mmc_get_env_dev(int devno)
 {
@@ -335,25 +364,44 @@ void enable_caches(void)
 
 __weak int board_phys_sdram_size(phys_size_t *size)
 {
+	struct scmi_ddr_info_out ddr_info;
+	int ret;
+	u32 ddrc_id = 0, ddrc_num = 1;
 	phys_size_t start, end;
-	phys_size_t val;
 
 	if (!size)
 		return -EINVAL;
 
-	val = readl(REG_DDR_CS0_BNDS);
-	start = (val >> 16) << 24;
-	end   = (val & 0xFFFF);
-	end   = end ? end + 1 : 0;
-	end   = end << 24;
-	*size = end - start;
-
-	val = readl(REG_DDR_CS1_BNDS);
-	start = (val >> 16) << 24;
-	end   = (val & 0xFFFF);
-	end   = end ? end + 1 : 0;
-	end   = end << 24;
-	*size += end - start;
+	*size = 0;
+	do {
+		ret = scmi_misc_ddrinfo(ddrc_id++, &ddr_info);
+		if (ret) {
+			/* if get DDR info failed, fall to default config */
+			*size = PHYS_SDRAM_SIZE;
+#ifdef PHYS_SDRAM_2_SIZE
+			*size += PHYS_SDRAM_2_SIZE;
+#endif
+			return 0;
+		} else {
+			ddrc_num = ((ddr_info.attributes >> 16) & 0x3);
+			start = ddr_info.starthigh;
+			start <<= 32;
+			start += ddr_info.startlow;
+
+			end = ddr_info.endhigh;
+			end <<= 32;
+			end += ddr_info.endlow;
+
+			*size += end + 1 - start;
+
+			debug("ddr info attr 0x%x, start 0x%x 0x%x, end 0x%x 0x%x, mts %u\n",
+			      ddr_info.attributes, ddr_info.starthigh, ddr_info.startlow,
+			      ddr_info.endhigh, ddr_info.endlow, ddr_info.mts);
+		}
+	} while (ddrc_id < ddrc_num);
+
+	/* SM reports total DDR size, need remove secure memory */
+	*size -= PHYS_SDRAM - 0x80000000;
 
 	return 0;
 }
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index ecab021b472..555ffa0a61b 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -54,7 +54,8 @@ enum scmi_discovery_id {
 };
 
 enum scmi_imx_misc_message_id {
-	SCMI_MISC_ROM_PASSOVER_GET = 0x7
+	SCMI_MISC_ROM_PASSOVER_GET = 0x7,
+	SCMI_MISC_DDR_INFO_GET = 0x22,
 };
 
 /*

-- 
2.43.0

