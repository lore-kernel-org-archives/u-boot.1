Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6965CAC5A7
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 01:52:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0520A83211;
	Mon, 22 Sep 2025 03:52:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AkaodPNK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F366D833D0; Mon, 22 Sep 2025 03:52:53 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4FB88317B
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 03:52:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qzbByeizyjFN/JgZYGubCfZY6o+zZlZ1TcmuQgkd1ur0cuPG8DV30dRZ1jA/Fc6nRZGzj1zpbSwKOi1HtmvPITtmd5w+Q027CqjELUaAL2O1VcoUclIKAkZwrIBe0U7pYQnGcPKaYChlhfb+BCsQHY+3cG7q8freg6zFzDdL7jmLK6DjwIjnjTYPiUiR1CxZ/fCOvRY1azknzJr6CF0w1bzPMOJ+Vo59F9FUwpLdFQ373Sq5vMi0WhKrgBd6g1w1eFHNIhzY0awrgIh95lh/1JmiZMi+/mbDJZfWuf6xnGBH2BHhXoejU3ybKPv2qNlZYKYwMQafD58ydy+/MjgXGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zKvo19LNSpqlt7PZU9f5wbgYV+4D38EeQIqBdHcYbQ=;
 b=evivME5PQ/lgleCcgjLm+/cp2OtArZ1U9SkeSi8pTDRDWk72pJckZcnYzxsb5NfTFjhmogfAj1ihXTfUagJMVoP7unEscTVDkcZ2yLlMfPz/G8gNyU0SfBminW3PRs5DpqWh5g5viJ5Cg0xVM2qnoG9zPZVd9oRhZfojn5XDLjvX8tuuHOxijIZ9EsxwaKuAL3O1gz/BrbYRZeMVA5B1032LMXKlBsoFH0KtmvUpmYpjxKrg6XSyHrEIWudgmm7CsNbXUUv2sFmvnAq45UlCwomhSMABWvgFAHWbxjPJkOQg+MyQSWP0yXHqTWrfJorNrMBc+751bffVc07Y3/a0vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zKvo19LNSpqlt7PZU9f5wbgYV+4D38EeQIqBdHcYbQ=;
 b=AkaodPNK24C5dYUoo8twdnA5ZKPNtstxpL2QT7Phme0NvihP2Jl1Rt8kd7yykmcs50/1vLNgfBF4Zn0a0pkQ4SsF97IVclGvocyH/N1TWfP7+QXR53KFxolDANWvA3zcGC10TUk5U5+N8uwG9VfS6qZuY1Nj7RmNR4IQ1C44Abmd1qz89A3sGRTO58bQuof9GTlxP2FYIl/3XzLuSRmNBaEIvQRranztWnqh+q1uo4v6fVX2RCEC7Wgr/3B8bHXJJBcG7CEkjBhGrTtFuWoAaZc/buuKj6ZjanLD7JxAVgr1kh4758SZV6/gWjRXEyMKB3rwD+uBo+wlZLmR8JVEJg==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 01:52:48 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 01:52:48 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>
CC: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, E Shattow <e@freeshell.de>,
 Stefano Babic <sbabic@nabladev.com>, dl-uboot-imx <uboot-imx@nxp.com>, Alice
 Guo <alice.guo@nxp.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Ye Li
 <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbRVhUXSBSZTogW1BBVENIIHYxIDQvOF0gaW14OTogc2NtaTog?=
 =?utf-8?B?VXBkYXRlIHRoZSBmaWxlcyB1bmRlciBhcmNoL2FybS9tYWNoLWlteC9pbXg5?=
 =?utf-8?Q?/scmi/_to_support_i.MX94?=
Thread-Topic: [EXT] Re: [PATCH v1 4/8] imx9: scmi: Update the files under
 arch/arm/mach-imx/imx9/scmi/ to support i.MX94
Thread-Index: AQHcIq4sAVH8wXY8eE+tHSEPIIcXyrSNOU4AgABPyQCAEBRzgIAAQIiAgACjVrA=
Date: Mon, 22 Sep 2025 01:52:48 +0000
Message-ID: <PAXPR04MB96449A9DD2B555CFBD35368DE212A@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250901-imx94-v1-0-c85ae7cdd95c@oss.nxp.com>
 <20250901-imx94-v1-4-c85ae7cdd95c@oss.nxp.com>
 <5ce9ad71-2d24-408b-ba55-cd87bf96afb1@freeshell.de>
 <PAXPR04MB96448A9D96B04749D3E882FBE209A@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <CAOMZO5CmBuOBT7snFVV_KLw_jJJ_b1-BGUk+pVAEYC6JMOFBRw@mail.gmail.com>
 <20250921160641.GZ124814@bill-the-cat>
In-Reply-To: <20250921160641.GZ124814@bill-the-cat>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|DU0PR04MB9563:EE_
x-ms-office365-filtering-correlation-id: abe10205-1890-4519-c496-08ddf97abb90
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?cWNZaHQ4b3paQzFJSngwbVVPSDhiNG5hSFVVdkhrU1QwV0dOd0FvT3Y5WnZo?=
 =?utf-8?B?QzhyYld4Qi9RSTlCUW1HNVRSaFgwTVE4OGNQbllsWjdMc1RWUHcvQlpwb0kx?=
 =?utf-8?B?SVlGbURzaGNVR2RHeGVhTXVISXNFODZPS3pQV09XYW5NWXcxTTUzWFR2dE5T?=
 =?utf-8?B?NWd6VzROeVNTRXk1SDVqVmo0aUYxN3p2TGh3SUlERVowRndwd0JndXFFMGI4?=
 =?utf-8?B?dEtpUnMzRHFKeEFvNzVpYmFxaEh2TEJ5eHkvK3d6cmpHOUgxbWVRWStSaWNU?=
 =?utf-8?B?d25CUkdKT0I2TlVkd3l4THp5Y2JvaDFET25BeWMwMkZxNy9Rdk1xcUw5aWlu?=
 =?utf-8?B?ckpRbDdTWVJ6dFRhT3dBQWs5aEhzWndQSlRCS3gxVGJWZGNvN2lJSTdGNzhD?=
 =?utf-8?B?VTdIUXB4ek1QbnlNRUhxNW9nS2RVa3pWdWpTZUZWZGh5T1JKaGdKNXFpVnlx?=
 =?utf-8?B?ajZJZzJBNkMxdHJnME5PdHpNajFhWEg2V20wZlBxa01vTEpkWHBYSC8yQUlZ?=
 =?utf-8?B?TUQ0VDJwOUhPdk1GK0VMTFRLbDRuT3Z3TDltcnRWQXEwSXlRc00zaGl1RVph?=
 =?utf-8?B?N0U1d2hqUTNDRjg4eWNJVWVvQlBLTWhRdHFBLzFOa0dtYy8wQTdiVVlpM3Jl?=
 =?utf-8?B?TkkxTlI5V1NiQWlLZWdZaklOL1JRU2N4ZHlCYnRWNHcyUjk0WjZkYzFyaTJU?=
 =?utf-8?B?ZzEyOFNjZnNOL1hiOUhxQndHaWV2SjRGaVZRek9xNFdlVTFCRjVjVjloVE9Y?=
 =?utf-8?B?UXp1L2htcnZoV09NV29CODJTTTBEQ0VtTXd1bTV2bVFVWDFlV251ZDZtOFJW?=
 =?utf-8?B?c3l4UXRnWTJpa2NUYUpFWUtKVHhia1dyY2p2bCtyWm84TFhiZ1NML0lJdS9G?=
 =?utf-8?B?cWpLeEpqYTRUZWZ5bFRPYURTVmlRMndXTEZVc0xTNU0yY1ZOck1Da2RPWVBN?=
 =?utf-8?B?Nyt3VzVxZGZ0RllPeXBGQ01VVVRJWlZkK3g0KzFxRllIZENpUFlzQ251Ulll?=
 =?utf-8?B?SWU4UEZUbnFUMWlURHhRRlFRZ1poTSswZmE0My85YnpjZzZ3V1UvSC9ZTHZH?=
 =?utf-8?B?bEMvSFFqZDl6SW1SWW1mQVJuM0tkSkUrVERSSEVEbkdkVzRaRHJLZ2RUdXlx?=
 =?utf-8?B?aGZUeXh4cWhmZllBYzdxbys2NjhtT3hUYmFuTzBlb25Bb0tqZUlyTXh4Y0RC?=
 =?utf-8?B?Y1kwOVZQRG5KaUxNM3RpMUNIT3BYM3BxOGI2bTBsZEcwY2RTdnJpcVhDRXVy?=
 =?utf-8?B?Z1VnRmE3dWFiRVkwVGxmQTRFQUttYk9HeENHdnlnSmxvUjVmdjliTG9vbVMw?=
 =?utf-8?B?TTJnV0tIVlNTZkxrSGFmbE5uYU41Vmk5dUVVVXB5TC92TFlIcUhvOVRsTjVL?=
 =?utf-8?B?K2p6elZ0NXBTV0VHQUthaXlkUzFBSTZENDlYUU9XQ21HajVUS1VZeXo5YVJI?=
 =?utf-8?B?QURHb01ma2MyUE5VRCtla2VIVlBJM3I1LzJaWGNScW9GOElWaDU2dThPRnN3?=
 =?utf-8?B?a3lxT3c2anlZcGJWbVBpODk4aGl6aUZvRmZsRzF4S1NmMmpmZ2RwYkpZS3No?=
 =?utf-8?B?b1RYZzZ2OGFsWHdFZlc3UHNnd2sxVEZyZnFPbXdpUmFYajNZWDdha1FYUVF3?=
 =?utf-8?B?QnVucEd1MGFEdzg3QUY1T1lwTzQ2bFF0clFpU0cwZXdUQllUNExZVndnWGlM?=
 =?utf-8?B?Qm1NcEtQWXV5WTQrSkZuRnFjTzhMbENwWkJDNi9SSU0ydFFDb3JWRnZrSDdE?=
 =?utf-8?B?Vkt5STkybDdMSzhaNXd3WGNHcERtQitvNGlBT0VrZ3cyR1NxQVo0cVFOSmlU?=
 =?utf-8?B?SWdyRE55bmdDcCtPeEloR09JTnBMbm9NTm9DM2FwWnZ5dW4xQ0g5dElaQ0hM?=
 =?utf-8?B?R2kzRStWMHMzckpLWWJ4cjZVZExsZGVRVHo0SGppWTVqOEdOVU9wLyt6eUFS?=
 =?utf-8?B?amNUTTlTVmNCeVFTcGFhQlYwenVyaXAwVlhHRXQ2bEdmUjdINnBoUG9MWGZJ?=
 =?utf-8?B?cXJub0dqeGFRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTFsQUxHSUJHZEFqTFBQOWJoT3BpUFQyY05sOCtreDA2RjMzMnlUQUN5Vy9Z?=
 =?utf-8?B?RWI0aHhyM0pVOXRGZnplUzVrdWNpaHdlY3VUaGpDUUpSZUtHZmFLZjFQVEtN?=
 =?utf-8?B?L05wR3M0T3NOckdSaGtCNGxia1BGMVBBa29lNTZ2Tko1TG5RY09BdHMxdkE5?=
 =?utf-8?B?clVKL2VQcXlDVmh3a251WW5UVis4dnJ0ektmWnNjV2hCeGZHRmI4bklKWUN5?=
 =?utf-8?B?dGhRRnI2Qzczc0VYK3RJUEhoaTFvVGhPRXkvM3pIakJGajhSZnRHRkp6a1Bk?=
 =?utf-8?B?aThRaktqbUY5SXRCY1ZHa1F6TTBVSlB6ZWR2ZUN6bkZCc3NlVXBRaWgzQlRy?=
 =?utf-8?B?Ulc4NkY2OE9CUDRVZWJrbVlJV0F2aitjM3hIdWt6OGlhUkxPWXB6VFhHTHIy?=
 =?utf-8?B?cTByM1FqUy9zWUsyeVZrRXQybmV4VjZQSUo4UG0rcEttZytrMXJtRGI5NHRN?=
 =?utf-8?B?d1VkSzZpbWZQOHViRWZma1htUm9FU0QreWk5VUlHM01CYk02dmdteDkyZkx4?=
 =?utf-8?B?KzNLSGJHcmwxUTlZckg3bDVoTWNZaHUrUStuK3puNjdLOXJUSW9jcmx0T2J4?=
 =?utf-8?B?L2JzWHRvWW1XZEgrbEsxZUVmdXI4THl1WERnWGZhOGZ5aW1yUFpHRzluZWIx?=
 =?utf-8?B?YXlmZTdveHNMa1g0S09YNG9TVThoVi9uOUZMOE5uVElGcTQwQTlLSVRrTTNJ?=
 =?utf-8?B?SmFweTNOWktXYTJHNnRZYXdLTmVwLy9LdXo4cGtjMVpNdG8zMEx1V3RWNlBC?=
 =?utf-8?B?MC8vRXBrVGhMNjhISFVpS3JQWkpmd3pHL2d5T2dPZkM0S1p5VFdsY3pBTnJz?=
 =?utf-8?B?TkxncVFvS3hZdCs3K2FMbkczZHFVYTJrWmEwSWIyV0h0UlpxbW92TGkwdXR5?=
 =?utf-8?B?a0oyYndYbnJKQmlrZlRwMmZEQWhIWDU3VnFNRHRYTUQweFY2ZHhHSHp0MGhh?=
 =?utf-8?B?ZUNvdWxibjU0Yi9VRWw2SnRucE1pNGVFcmFRWVR3ZnFhZjYrUXFQRkhUdzhF?=
 =?utf-8?B?WG9VRFFLVXNlMjZnVlY0VmNKS21UZXFmTEh3djRtTDZTZzdkMUJlZ2RzTjNq?=
 =?utf-8?B?bVQ5dW1xelJrNFVQbER2ck1aSFJLUFMvRnluTkVuOU5mcFVEa0dURkZGWkxH?=
 =?utf-8?B?TFZVUCtMYTRkejgyQWViK0dxNS9UT3NGeXp3VUlaNTRMRUV5R0JxZWR0NDVL?=
 =?utf-8?B?dVp1NDFicFZ6aEZsb0NZWm50ckpPZHl6VHpBOEZSdFBibWYxWFdJOG5kYmNG?=
 =?utf-8?B?Sko2QWhWOEswdWU5cWJ3MVZEcGRhTW4vVWdWd3VMRlFqZnl0R1FFTk8wcGxx?=
 =?utf-8?B?NW54VFA2S3RMKy85cGdMVWtIcGw5U0Rod0RuNFlKaDcvdGIrZGxiWW1kME13?=
 =?utf-8?B?b1RFd2xxR3AxTFNrSFdma3htaHlkODZXVC8rcmFmOUVxR3hPM3o2eGg4MitN?=
 =?utf-8?B?TUU5bkNScnRLaWNMODRoMkVmZFVsa2wxV2NYMkoyd0Y2TWF0a3c3ZlN1L3pO?=
 =?utf-8?B?N1JReWZDcGRtdllQMmoyMnkvbVZ3MkZYNjBEa3pRbUpMa3FwbXY1RUMvblRJ?=
 =?utf-8?B?NUcrWTIyZW5tVFB3K3ZDU0RrazB3VW9QT1JUdXdGRzFJVW8rdG02Mm1VdkxB?=
 =?utf-8?B?elQvUHRhQ0hPb3hYS1VycHhEdUJMbEhmMDFBbUN3b1hFa1lGVkF2Z045VUxS?=
 =?utf-8?B?MHlGUEpjbUFvVGVpamRNYUlNZFpXZ20rTVFTcm5xVk02WjVoVGh6SUZCR2lW?=
 =?utf-8?B?cjd4VE5reUJ4VnhBVUpMeGJEcHdWL281MVExVjYzWnJSUDRWMWRMYm5ITjAz?=
 =?utf-8?B?dzlnd1pBQVBRWWhDR3B0Sytzb3QxUzNRNFNWQ0U1SDBTZGVlb3ZibmNZWVFu?=
 =?utf-8?B?aHg3dVZKZm5seHlqOXcyNGoxMDhycEZQMjZnR1BuVzloME52dXRiSHVreWZN?=
 =?utf-8?B?MmIxbTR1cmNydkZIY1RwZHpwenpjSjdUT1g2aHJ0Q1ZWV3dZZDhMandNWUNK?=
 =?utf-8?B?MURCaS9DemE5MWlVRW1kc0hCNy8zS3lrY08ydFRFNFdQdC9QQ3BkUnIxSGJs?=
 =?utf-8?B?aDJwMElkdGhXRlNSNkYzQzVNNmkycTdlYjIyc1c3aTZ1anhHVlFwSW1nUHdC?=
 =?utf-8?Q?bOhA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abe10205-1890-4519-c496-08ddf97abb90
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2025 01:52:48.4247 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gna7u0fMLj2dDeSAoXEEJP59Ng/w50XdXVuRatg9HjDQbHV91rj6SJKSn8e+RgOWooocPNwgot0rZ19HNoCygA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9563
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogVG9tIFJpbmkgPHRyaW5pQGtv
bnN1bGtvLmNvbT4NCj4g5Y+R6YCB5pe26Ze0OiAyMDI15bm0OeaciDIy5pelIDA6MDcNCj4g5pS2
5Lu25Lq6OiBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+DQo+IOaKhOmAgTogQWxp
Y2UgR3VvIChPU1MpIDxhbGljZS5ndW9Ab3NzLm54cC5jb20+OyBFIFNoYXR0b3cgPGVAZnJlZXNo
ZWxsLmRlPjsNCj4gU3RlZmFubyBCYWJpYyA8c2JhYmljQG5hYmxhZGV2LmNvbT47IGRsLXVib290
LWlteCA8dWJvb3QtaW14QG54cC5jb20+Ow0KPiBBbGljZSBHdW8gPGFsaWNlLmd1b0BueHAuY29t
PjsgdS1ib290QGxpc3RzLmRlbnguZGU7IFllIExpIDx5ZS5saUBueHAuY29tPjsNCj4gUGVuZyBG
YW4gPHBlbmcuZmFuQG54cC5jb20+OyBKYWNreSBCYWkgPHBpbmcuYmFpQG54cC5jb20+DQo+IOS4
u+mimDogUmU6IFtFWFRdIFJlOiBbUEFUQ0ggdjEgNC84XSBpbXg5OiBzY21pOiBVcGRhdGUgdGhl
IGZpbGVzIHVuZGVyDQo+IGFyY2gvYXJtL21hY2gtaW14L2lteDkvc2NtaS8gdG8gc3VwcG9ydCBp
Lk1YOTQNCj4gDQo+IE9uIFN1biwgU2VwIDIxLCAyMDI1IGF0IDA5OjE1OjQzQU0gLTAzMDAsIEZh
YmlvIEVzdGV2YW0gd3JvdGU6DQo+ID4gSGkgQWxpY2UsDQo+ID4NCj4gPiBPbiBUaHUsIFNlcCAx
MSwgMjAyNSBhdCAzOjQy4oCvQU0gQWxpY2UgR3VvIChPU1MpIDxhbGljZS5ndW9Ab3NzLm54cC5j
b20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gPiA+ID4gICNpbmNsdWRlDQo+ICIuLi8uLi8uLi8uLi8u
Li9kdHMvdXBzdHJlYW0vc3JjL2FybTY0L2ZyZWVzY2FsZS9pbXg5NS1jbG9jay5oIg0KPiA+ID4g
Pg0KPiA+ID4gPiBXaGF0IGlzIHRoaXM/IEkgYXNrZWQgYW5kIGl0IHdhcyBzdWdnZXN0ZWQgdG8g
c2VuZCBhIHBhdGNoDQo+ID4gPiA+IHVwc3RyZWFtLCBidXQgdGhleSBzYWlkIG5vLiBSZWY6DQo+
ID4gLi4uDQo+ID4gPiBUaGlzIGxpbmUgb2YgY29kZSBpcyB1bm5lY2Vzc2FyeSBhbmQgY2FuIGJl
IGRlbGV0ZWQuDQo+ID4NCj4gPiA+ID4gQWdhaW4gdGhpcyB3ZWlyZCBpbmNsdWRlIHJlbGF0aXZl
LWdsb2JhbCBwYXRoLi4uIG5vdCBnb29kLg0KPiA+ID4gPg0KPiA+ID4gPiBJIGRvbid0IGtub3cg
d2hhdCBpdCBzaG91bGQgYmUsIHNvcnJ5LiBJdCBpcyBmcmFnaWxlIGFuZCB3ZSBzaG91bGQNCj4g
PiA+ID4gZG8gc29tZXRoaW5nIGJldHRlci4NCj4gPiA+ID4NCj4gPiA+DQo+ID4gPiBUaGVzZSBm
aWxlcyBhcmUgZGVyaXZlZCBmcm9tIHRoZSBMaW51eCBzb3VyY2UgY29kZS4NCj4gPg0KPiA+IFBs
ZWFzZSBhZGRyZXNzIEUgU2hhdHRvdydzIGNvbW1lbnRzIGFuZCBzZW5kIGEgdjIgdGhhdCBhbHNv
IGNvbnRhaW5zDQo+ID4gdGhlIGlteDk0LWV2ayBzdXBwb3J0Lg0KPiA+DQo+ID4gVGhpcyB3YXks
IHdlIGNhbiBhY2hpZXZlIGJ1aWxkIGNvdmVyYWdlIGZvciB0aGUgZW50aXJlIHNlcmllcy4NCj4g
DQo+IFRoZXJlIHdhcyBzb21lIGRpc2N1c3Npb24gb2YgdGhpcyBvbiBJUkMgYXMgd2VsbCwgYW5k
IHRoZSBpc3N1ZSBpcyB0aGF0IChmb3Igbm93PykNCj4gdGhpcyBoZWFkZXIgaW4gdGhlIGtlcm5l
bCBpcyBzdXBwb3NlZCB0byBiZSB3aXRoIHRoZSBkdHMgZmlsZXMgYW5kIG5vdCBkdC1iaW5kaW5n
cw0KPiBhbmQgc28gaXQncyBub3QgaW4gYSBub3JtYWwgc2VhcmNoIHBhdGguDQo+IA0KPiBJIHRo
aW5rIHRoYXQgZm9yIHVzIHRoYXQgbWVhbnMgd2Ugc2hvdWxkIGRvIHNvbWUgTWFrZWZpbGUgZ2Ft
ZXMgaW4gdGhhdA0KPiBkaXJlY3RvcnkgYW5kIGFkZCBhIC1JJChzcmN0cmVlKS9kdHMvLi4uIGFu
ZCBjb21tZW50IGluIHRoZSBjb2RlIHRvIHNheSB0aGlzIGlzIGENCj4gRFQgaGVhZGVyIGZpbGUu
DQo+IA0KPiAtLQ0KPiBUb20NCg0KSGkgVG9tLA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgc3VnZ2Vz
dGlvbi4gSSB3aWxsIGFkZHJlc3MgdGhpcyBpc3N1ZSBieSBtb2RpZnlpbmcgdGhlIE1ha2VmaWxl
IGluIHRoZSBuZXh0IHZlcnNpb24uDQoNCkJlc3QgcmVnYXJkcywNCkFsaWNlIEd1bw0K
