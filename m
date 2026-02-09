Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A70E7E0BB
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 10:24:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EEE7839A5;
	Mon,  9 Feb 2026 11:24:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PTmVPjC6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42F2183BDD; Mon,  9 Feb 2026 11:24:36 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CA408397D
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 11:24:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NNoaEfHEklqB8pkUDh1kUIyOm9Hjg+aWKUvh8ZHZQRRJG5QiVZJ8aH54P9IeVmMPkVMaCwHODtn+E4+LHRrINXpe/14rkK2B9XufiYtyWbNL6iFrMS+jQiBL/SnxPVgEG0UOsWnvPToaA1DxTOFZ1keDjaySSfNBsbR8JbbPATidPfRUBzExG010uGmP5Dx9Zt0UXVfKpy61rwyBY143ghFKDJR+DGIbDC1A4skVsWaa63iVorj0EtiQkIJt6zff8vzC0WifryXhzryNQefNo/UwBCDWoMuPBaF5uDrEv2CDtlnivbTFDUHxYmxHOupOK7z8TwSY2pm6xMBERd8cPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJZhqUr2P+TX8/ADRKS+EDh0u+2DuHff+OQeSbFh0Qk=;
 b=O6WHOE04wYHLrHxU7dAlTJiVcQHifJl7pm7qm8zGIKt7Swrinz7zwz8uNaDnHX3Cm1OmskeLIH9jpi2KGuhvv71LGr5JCoKJJ2jBpgJk2T2MzybHg9MSqjJBiZyWj3GmF5g4NGQD0evLA/Gb3trljxJtzDYoCg+e7G/YidU5QMed9On/fz2/mv2SG/gI5+ngi9pbuSRWZuM8pEGHO7mDJxcMOl5TGxOluEH0LtC1+3AW2Lm4o2GPihH8xAc0K2CFwp0KwOH2zleSifEkhaKcVc4+B5Ln4Ip6zR3F5UHNOiHX9k1W09D5jShSlKOCpdsgJWERcMCcOvFkO6ed8WNpJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJZhqUr2P+TX8/ADRKS+EDh0u+2DuHff+OQeSbFh0Qk=;
 b=PTmVPjC6MN+DwYg2bOcXiM3qH6Vd11W6HE/t7GJZ4SPREApu3edUK75CqvRx6bDAkxOzAhEN79q3BtDJI75LtdxwAuL88SwjqAdYIfMsAahLAtMJRK6wGip41KrhmdbUpfRd6igvlWU2EGNmXVgFf9e1styos+3n8YZlO9u2L7GQ7kHZctSj0Ais0Hpj6hIqbjY6doIm4RQ3ZBgpXu1jgYNFst+H2mFc6M7TV4yWoE4FaLAxuQy+jQm8NOjaN2Du+gG1NHElXe+JIseY839Scu5wpnHMxvkz9cXRiaHdkpluN8uYw7ZJqH25xiC391KELEZL5EbvdHXwYqTbPgLs9Q==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV1PR04MB10893.eurprd04.prod.outlook.com (2603:10a6:150:209::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Mon, 9 Feb
 2026 10:24:28 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 10:24:28 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>
CC: dl-uboot-imx <uboot-imx@nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Stefano Babic <sbabic@nabladev.com>, Tom Rini
 <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Jindong Yue <jindong.yue@nxp.com>, Jacky Bai <ping.bai@nxp.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes <ravi@prevas.dk>, "Ross,
 Fedor" <fedor.ross@ifm.com>, =?utf-8?B?Sm/Do28gUGF1bG8gR29uw6dhbHZlcw==?=
 <joao.goncalves@toradex.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>, Vinh Nguyen
 <vinh.nguyen.xz@renesas.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, Ji Luo <ji.luo@nxp.com>, 
 Frank Li <frank.li@nxp.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, Adam
 Ford <aford173@gmail.com>, Frieder Schrempf <frieder.schrempf@kontron.de>,
 David Zang <davidzangcs@gmail.com>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, Sumit Garg <sumit.garg@kernel.org>, Marek Vasut
 <marex@nabladev.com>, Joseph Guo <qijian.guo@nxp.com>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>, Alice Guo
 <alice.guo@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjEgMDcvMTJdIGFybTogaW14OTUyOiBBZGQgd2F0?=
 =?utf-8?Q?chdog_base_address_definitions?=
Thread-Topic: [PATCH v1 07/12] arm: imx952: Add watchdog base address
 definitions
Thread-Index: AQHcma5FUOwE+aBv502kNACrVRdlCQ==
Date: Mon, 9 Feb 2026 10:24:28 +0000
Message-ID: <PAXPR04MB964454F2F0129B7B70FB9E88E265A@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20260205-imx952-v1-0-2103d0222a0b@nxp.com>
 <20260205-imx952-v1-7-2103d0222a0b@nxp.com>
 <CAOMZO5C1KB+PyQ2Kgr58uCKLE9sJPtws+OYwShe4fgkm_ZdTSg@mail.gmail.com>
In-Reply-To: <CAOMZO5C1KB+PyQ2Kgr58uCKLE9sJPtws+OYwShe4fgkm_ZdTSg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|GV1PR04MB10893:EE_
x-ms-office365-filtering-correlation-id: 86fa7679-ee8c-45a4-2917-08de67c567e7
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|19092799006|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?V1lwWVhoNkFwSGlvb1lXSTFiSjBYb2d5Y0pObVdLL2FkVkU1ak1JN0xLYmZt?=
 =?utf-8?B?eG05UkpnQ3VtTlVpdmI5ajlKYkFBSEpUWDVDOWVDU0s5SzYrTjFlbmJldW53?=
 =?utf-8?B?bzJhZzRLSTJrdzRrT1FpZ015RExDNjM5MkFmVkRIRWVYbkNTM3l4ODAzTjBY?=
 =?utf-8?B?WjUwNE1peFZ1TkNUMkEvRm0yNVdYWDVKZHRGTk5Na29xSEZmWi9uSk5UaGly?=
 =?utf-8?B?YjNKcVhZUVZFS1A1WjlPU3lqN2pteVF5ejBFQVRZTnRvZDZldXkyc0cxZFNE?=
 =?utf-8?B?VkI4K2VxQTlTdFBpZmZsUmNRNUtqYTNjOTZCR0RFbmFOVlhzT0VPQ1FkYXk2?=
 =?utf-8?B?THMwNE15NDUyQzZFdUtsc2tha3Y1SFZEak1xTHFadDN6Zlg3ZXhmMHVxWlVa?=
 =?utf-8?B?Wm05UWFsY0RTaEJGVWp5cXRlZnp2YWdkcmFBVXNmQktTWnpYK052cUFvQWN0?=
 =?utf-8?B?Y3hMVnNzbVI3QzZ1VGVEdHI0c0NYUG14SzN0V0FaZFl3QlI2WXVmYlZCaSs0?=
 =?utf-8?B?ZnQwU25abDR4R3lxUXR3eERYaHVxeVM3eGRqcGh4Y0wzL09lckpIWlhtai80?=
 =?utf-8?B?Y0cvMHl4MFMyK041U1Y2UHhycW0vYzBpbGZFUmE0KythMTkrMEhtMGdWa2VI?=
 =?utf-8?B?WXh1RVN4bldoTEUzajdHcmRPUDhzaFhCbFNWS3lqcXR5ajVPY1Jja3pqbGlz?=
 =?utf-8?B?M1huTWZFVzBwaStWMUVmWkMwRTY0VlRSa2FpQUZ6VG5zcnpCcENiaTV5a1pk?=
 =?utf-8?B?R2RQQklpMmFBa0R6aHhpa1VOR1hVQkYxS3c3YklPc3cyU1o3aUsxc3piWjFS?=
 =?utf-8?B?R2pvYjdhZ2pBWXlhanlCU2RmZ2YwL0RZT1VsQXR6OXpvdEwyYytUVFVDNkJ1?=
 =?utf-8?B?dmRaRFVoSmN1cWxSRk9vOGI4NFhNcWlFSUxFWTAwTUhvNlhTZXdQdU5OMENB?=
 =?utf-8?B?QjFKRm5YN3BsSEU3Y1pxVDZvaFFFZmJja2tJbncyaGZZOHFCL3BTeUJWbXFU?=
 =?utf-8?B?UnpGTmdiVExVZ0pXWFpucmFzTGhYQ0JySzdhNHJEdjFPN0RoY282UTRVQXYy?=
 =?utf-8?B?YVdyQXdkQ1NnZW1OZ1RYaVdzQ3lKK0NnemJFWlBYT3dKVGJBdkV3aWNJNDBr?=
 =?utf-8?B?RVc4TS8wZll2d2JldHN4U2dQMEFiZ0Vrb1ZseVAvL0xLbVJrL25SblFVZWZm?=
 =?utf-8?B?RzBOREJhRmhHSm4yYUVPZTQzTWZhbWVyTFBLK3RYM1RUZVJWT2hPSDI5STlr?=
 =?utf-8?B?OS9VRWxDTlJVbUxsaldFb0ZzTEUxMXFVdTB0WTRydWJmRU1nZ0FPb2dEVW1Z?=
 =?utf-8?B?bVlUSVFRczQ4RXU5MkxpYVgyQVgxYm5TNkNlV2dYKytNRjZIbjJ3MXB4dlhj?=
 =?utf-8?B?MElZOEhkZHZRMWN2OTZFT0FUQXN1OTQ1ZDlFMTIreXRCbGVPenAwNGc0OUNa?=
 =?utf-8?B?QXoyNEM5cXozQittdE5MaEJ6K2tjVEdxQVNtVmtCVjBsOHN2ZnBlOEkvQmtu?=
 =?utf-8?B?cU9RSFlJMmxaUXJ6blp5dDRhVjJYWjNseSttT08yWm92Rzl3NzJvZWJmaVpW?=
 =?utf-8?B?bmxxdzdBWDRLWTFHUmR5dHZTQTcrdUlubE8weGZ6V3hqZ3k5dU5oMjhTbVFa?=
 =?utf-8?B?KzZzaExGU1BWcGNnZHhYcHhmdjdZdHZUMk5tVEI4R3VuM2ZVSFAydWxLU0Ra?=
 =?utf-8?B?UU4vUkRPRllGMU5HYjI4YVAzcnR2Tk51Y29LaGxwTGlRZVgxTFpETS9jMGRP?=
 =?utf-8?B?UlhzQno5SFB0em9Rcnd5KzNJclFnSkpYMERwWllkRFNSZFhZVWpSRWRsOE5l?=
 =?utf-8?B?dXdIT1JyK2UvdGxTVHI3bVZ2c2NmaW9INmJPdUhmZHVnMHdlTHlIelF1N09p?=
 =?utf-8?B?eEhYcXZEUXJadVpsOXVpQnpHejB3QS9pVEJQeXRMNmJwdzNyRWJGaWZOaWoz?=
 =?utf-8?B?d3BnM0lyaDlCOUlyMzFEV0R5MmxtZGdaVHNjazR4Nys2NGFUcXVZU1gwOFZ0?=
 =?utf-8?B?c3kzZHNNNjhlL3VtRW1QNGpmcDYyaG9uTnZZNWIrZHdyMHkxWVl2dlY2bFZ0?=
 =?utf-8?B?QTh6SXZLVjMva3ZLZmw0NjZZeDZqMW5NSlNYL1cyc3ljR3J4cSs3bG90Y2Zx?=
 =?utf-8?B?ZGJxVmVoaXVINkhOYXNZS0VqMFdKZ0FhbzVVQ3B1cVl6WldkWFNrZ0Z0UkJN?=
 =?utf-8?Q?CpiNL17TshFE0TfPcB50Mis=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(19092799006)(376014)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3U0WlltcUNWaldDcXNRalBTcTBXZ0ZrUlNHN1BVdWxqUnFwWTFFMXQvdUkx?=
 =?utf-8?B?MnhMellNNXpaR3FTY25EdWVGWTAwMjh1L1VFUkJyMG9DcHNzWFN3Q1BZUEpH?=
 =?utf-8?B?Z2N2aGloVHQyK3NOcGI3S0RGYjhOclpieU1aaHljSThEdnZITzZ2Qmx5bEI2?=
 =?utf-8?B?N3k3cmxtVEpnbDJSUFVUMHJMckwxd2VsL0Joa2krdjFkL0RVT2g4REJwK25z?=
 =?utf-8?B?dnZWQjQwalF1cE82RUpWWDh2QW1ZZUlwL29wRUU3WUQ4dGF0ZzBDQjg2K3JO?=
 =?utf-8?B?TnVPVmd3VmVYQ0JlOUYySmhhbFhMcHJMUzI1N1RCazA3SnNNL0RJTkdJVlZ0?=
 =?utf-8?B?NE1GSDJDMmd2b1BKT0lsRWsza3RtSWRwbkIva3o4V21Bb3pTRXErc3NVOHlC?=
 =?utf-8?B?ekdwKzVteE92eFA0SjFwRENhUlVvQnhMTkRzMnROdjdhTk44RXJyUVh3N1VT?=
 =?utf-8?B?SEtXTGg1aFNqVjhmY2pDUTdwQnhoLzhudmdEZHNUNWx3SDAvK1o3S1Q0dVZp?=
 =?utf-8?B?bnFaSTd4L20zOUNUQkpnUUpncW9EdEVWOFhXR0pGS2NXRytXT2g5WlBOZmYy?=
 =?utf-8?B?UmRCNjNWbldSdXZiSmZ2WXc3MlZXRVliZ09pUXVoeEJRb2k5ejQ2OWU4N2E0?=
 =?utf-8?B?eWcvSW9NOXM1dzhjL0RHeWhKWEdvUWg0V1dnSW1XdUp0MjdBTzBkbHpDOWxj?=
 =?utf-8?B?dElGYzVScWtaZ0VsSmdaZkM5UjhmMXA3MHJ4cGJCNjd1WDdRZDlPS1B3bGM0?=
 =?utf-8?B?M3VUTzl1bEIrcnlMdWpVK1F0akVRai9ERXhGUnZSdXRBY1lNaU4xUVpFSGQ0?=
 =?utf-8?B?aWlHV1VTc2J6Tml4b0VHYTZud2J2MitiZHdJRE8vTkpCdTcwQ05DUkpkbk94?=
 =?utf-8?B?K2djQW85LzgyM3pldmtlMWRNckl2MkkzeGo2aFN5Y0NxWG5saUxyTDNDV1RS?=
 =?utf-8?B?RzNmTjhjQ2xFck5aZjdlLzYyclVEdUVxc1MwVVNvTHRoUVpRWWtVSHRnajNr?=
 =?utf-8?B?TEIzRXFZTVo4ZDRtajViUmJZdU42akVRQkIxbFBJTG1tQXlhOTlHYUhWSEJ2?=
 =?utf-8?B?MlJJT2RjcVBZYXVFaEJma2VmVW44dUVYSE1SdHVEOVJjanRIRnd6OXFoS1hy?=
 =?utf-8?B?d0RiK2xoa3J5YjNPTDQra3R4Tjd5T0g0MFdlNnRNK2VrRWR2K3BwdHMyQVBu?=
 =?utf-8?B?a3RabVI4OW5wVFpJbEx4RjRjemVueWQyazFsL0tsNy9WMUtLTUcwVzBBUVNv?=
 =?utf-8?B?R2lqTFBsN1ltZjNOdVVUOXJuTjg0cThZcjAwSXNVdmUyT0M1RUVBcVI1MG5I?=
 =?utf-8?B?UWthNm5hUitEbHBtZVlxOFhqNFd5Y1E5Vzd6OTNMZDFnRzZFcjZYSm5mbXFF?=
 =?utf-8?B?MDB1dFVkRmFzekJUL2hlbGpHRWk4Snh0Zit3Yi9CQlBnTzkyK0RoRDFnemhz?=
 =?utf-8?B?QkNkcnBielJhK2czZlp1VkJ6d0wwckV4cXE3K1hoaHRzUHBFR1g0MkF1MEZs?=
 =?utf-8?B?Q2c0L0pqWGdSYlhlUXBLN2xFME9xeHVRTWw5UjdBblFBR0VRTjZNWGhEUWFJ?=
 =?utf-8?B?VkxxZGdWbmptWUh2cUFFbTB3QVp3a05kS29DbGs5cjZZWDlKT2Y2eHVLazg1?=
 =?utf-8?B?OEpMKysyRHRPdkNJbU1HWFNUaUMzaElibzVJS2xCUGNKRGVpaTA4WmpSVGJv?=
 =?utf-8?B?Tm1POVdJcm9TcDdYTUJWTmRaT3RFa0VjVEtmVFRkTkxJTVhYbDQzTy8yVitN?=
 =?utf-8?B?RjF0cGxMMGdGL3RuQlpYdWZHeGZza3ZrMkVseHRWck45U3IwRXVqckl1a2wz?=
 =?utf-8?B?OGtxcmFrTDRWNDFleFRsbHNkM3NZY2hCSU5DVkJkSmozUDFhY2RrbmJLZGdH?=
 =?utf-8?B?R2M3TFczdUZoV212ZElIYU1HUk9uTDZ5aFpNamFzS09UazJ5S29uSS8wTzFq?=
 =?utf-8?B?SVFwNXE3ODUvekU4LzFmSTVPekVqb0RORUg2ZTFMbzJWQTFQRFQ0UitHNHoy?=
 =?utf-8?B?cFp6b1liaHdKZWdXYXN3ZmNaQTl1b1lncWV5enJFcjVqTnpQQmhWL0JKQS8x?=
 =?utf-8?B?TkNTdnR3Zk44VGd5QTY4N0JzcjExT3JRTWJqeldOUDl3Y1dkcytDZjJOQzRw?=
 =?utf-8?B?c3VmeW5jUWtQejJudVNjWjBPWTUzbEtFOTR6cFVzMEFmb1NCVkxVTzFEVlFu?=
 =?utf-8?B?d1JZSVMxa3VHeWxDakxKTmJSY2czSFREKzErTVBEZGlHOFhkdlBiWC9vZkVo?=
 =?utf-8?B?ZUpESlYyOEdFZDM0ZGQybmNCTm5Lam10a3RMb3FGWXo2NVBiNCthaDh3bU92?=
 =?utf-8?Q?nr3zNlV+ZnUgk8YiL0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86fa7679-ee8c-45a4-2917-08de67c567e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 10:24:28.2045 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2NYsqp4sd9CEeslttRSxzPRktZ6veIKVbTk+/ZC1o89pUtuqPJWe1wqIrN/nD/gIbZSahHd4+wMjXBcOb94pyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10893
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogRmFiaW8gRXN0ZXZhbSA8ZmVz
dGV2YW1AZ21haWwuY29tPg0KPiDlj5HpgIHml7bpl7Q6IDIwMjblubQy5pyINuaXpSAxMTo1OQ0K
PiDmlLbku7bkuro6IEFsaWNlIEd1byAoT1NTKSA8YWxpY2UuZ3VvQG9zcy5ueHAuY29tPg0KPiDm
ioTpgIE6IGRsLXVib290LWlteCA8dWJvb3QtaW14QG54cC5jb20+OyB1LWJvb3RAbGlzdHMuZGVu
eC5kZTsgU3RlZmFubw0KPiBCYWJpYyA8c2JhYmljQG5hYmxhZGV2LmNvbT47IFRvbSBSaW5pIDx0
cmluaUBrb25zdWxrby5jb20+OyBQZW5nIEZhbg0KPiA8cGVuZy5mYW5AbnhwLmNvbT47IFllIExp
IDx5ZS5saUBueHAuY29tPjsgSmluZG9uZyBZdWUNCj4gPGppbmRvbmcueXVlQG54cC5jb20+OyBK
YWNreSBCYWkgPHBpbmcuYmFpQG54cC5jb20+OyBNYXJlayBWYXN1dA0KPiA8bWFyZWsudmFzdXQr
cmVuZXNhc0BtYWlsYm94Lm9yZz47IFJhc211cyBWaWxsZW1vZXMgPHJhdmlAcHJldmFzLmRrPjsN
Cj4gUm9zcywgRmVkb3IgPGZlZG9yLnJvc3NAaWZtLmNvbT47IEpvw6NvIFBhdWxvIEdvbsOnYWx2
ZXMNCj4gPGpvYW8uZ29uY2FsdmVzQHRvcmFkZXguY29tPjsgUGF0cmljZSBDaG90YXJkDQo+IDxw
YXRyaWNlLmNob3RhcmRAZm9zcy5zdC5jb20+OyBWYWxlbnRpbiBDYXJvbiA8dmFsZW50aW4uY2Fy
b25AZm9zcy5zdC5jb20+Ow0KPiBWaW5oIE5ndXllbiA8dmluaC5uZ3V5ZW4ueHpAcmVuZXNhcy5j
b20+OyBTYW0gUHJvdHNlbmtvDQo+IDxzZW1lbi5wcm90c2Vua29AbGluYXJvLm9yZz47IFJhbmph
bmkgVmFpZHlhbmF0aGFuDQo+IDxyYW5qYW5pLnZhaWR5YW5hdGhhbkBueHAuY29tPjsgSmkgTHVv
IDxqaS5sdW9AbnhwLmNvbT47IEZyYW5rIExpDQo+IDxmcmFuay5saUBueHAuY29tPjsgU3VtaXQg
R2FyZyA8c3VtaXQuZ2FyZ0Bvc3MucXVhbGNvbW0uY29tPjsgQWRhbQ0KPiBGb3JkIDxhZm9yZDE3
M0BnbWFpbC5jb20+OyBGcmllZGVyIFNjaHJlbXBmDQo+IDxmcmllZGVyLnNjaHJlbXBmQGtvbnRy
b24uZGU+OyBEYXZpZCBaYW5nIDxkYXZpZHphbmdjc0BnbWFpbC5jb20+Ow0KPiBBbmRyZXcgR29v
ZGJvZHkgPGFuZHJldy5nb29kYm9keUBsaW5hcm8ub3JnPjsgU3VtaXQgR2FyZw0KPiA8c3VtaXQu
Z2FyZ0BrZXJuZWwub3JnPjsgTWFyZWsgVmFzdXQgPG1hcmV4QG5hYmxhZGV2LmNvbT47IEpvc2Vw
aCBHdW8NCj4gPHFpamlhbi5ndW9AbnhwLmNvbT47IHRoYXJ2ZXlAZ2F0ZXdvcmtzLmNvbTsgQWxp
Y2UgR3VvDQo+IDxhbGljZS5ndW9AbnhwLmNvbT4NCj4g5Li76aKYOiBSZTogW1BBVENIIHYxIDA3
LzEyXSBhcm06IGlteDk1MjogQWRkIHdhdGNoZG9nIGJhc2UgYWRkcmVzcw0KPiBkZWZpbml0aW9u
cw0KPiANCj4gSGkgQWxpY2UsDQo+IA0KPiBPbiBUaHUsIEZlYiA1LCAyMDI2IGF0IDEyOjE24oCv
UE0gPGFsaWNlLmd1b0Bvc3MubnhwLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBBbGljZSBH
dW8gPGFsaWNlLmd1b0BueHAuY29tPg0KPiA+DQo+ID4gQWRkIFdERzMsIFdERzQgYW5kIFdERzUg
YmFzZSBhZGRyZXNzZXMgZm9yIGkuTVg5NTIuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGlj
ZSBHdW8gPGFsaWNlLmd1b0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNoL2FybS9pbmNsdWRl
L2FzbS9hcmNoLWlteDkvaW14LXJlZ3MuaCB8IDYgKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCA2IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9pbmNsdWRl
L2FzbS9hcmNoLWlteDkvaW14LXJlZ3MuaA0KPiBiL2FyY2gvYXJtL2luY2x1ZGUvYXNtL2FyY2gt
aW14OS9pbXgtcmVncy5oDQo+ID4gaW5kZXggMmQwODRlNTIyN2EuLjdjN2EzNGY3NGFmIDEwMDY0
NA0KPiA+IC0tLSBhL2FyY2gvYXJtL2luY2x1ZGUvYXNtL2FyY2gtaW14OS9pbXgtcmVncy5oDQo+
ID4gKysrIGIvYXJjaC9hcm0vaW5jbHVkZS9hc20vYXJjaC1pbXg5L2lteC1yZWdzLmgNCj4gPiBA
QCAtMTcsNiArMTcsMTEgQEANCj4gPg0KPiA+ICAjZGVmaW5lIEFOQVRPUF9CQVNFX0FERFIgICAg
MHg0NDQ4MDAwMFVMDQo+ID4NCj4gPiArI2lmZGVmIENPTkZJR19JTVg5NTINCj4gPiArI2RlZmlu
ZSBXREczX0JBU0VfQUREUiAgICAgIDB4NDIwYjAwMDBVTA0KPiA+ICsjZGVmaW5lIFdERzRfQkFT
RV9BRERSICAgICAgMHg0MjBjMDAwMFVMDQo+ID4gKyNkZWZpbmUgV0RHNV9CQVNFX0FERFIgICAg
ICAweDQyMGQwMDAwVUwNCj4gPiArI2Vsc2UNCj4gPiAgI2lmZGVmIENPTkZJR19JTVg5NA0KPiA+
ICAjZGVmaW5lIFdERzNfQkFTRV9BRERSICAgICAgMHg0OTIyMDAwMFVMDQo+ID4gICNkZWZpbmUg
V0RHNF9CQVNFX0FERFIgICAgICAweDQ5MjMwMDAwVUwNCj4gPiBAQCAtMjUsNiArMzAsNyBAQA0K
PiA+ICAjZGVmaW5lIFdERzRfQkFTRV9BRERSICAgICAgMHg0MjRhMDAwMFVMDQo+ID4gICNlbmRp
Zg0KPiA+ICAjZGVmaW5lIFdERzVfQkFTRV9BRERSICAgICAgMHg0MjRiMDAwMFVMDQo+ID4gKyNl
bmRpZg0KPiANCj4gQ2FuIHdlIGltcHJvdmUgdGhpcyBhbmQgcmV0cmlldmUgdGhlIHdhdGNoZG9n
IGJhc2UgYWRkcmVzcyBmcm9tIHRoZQ0KPiBkZXZpY2V0cmVlPw0KDQpIaSBGYWJpbywNCg0KVGhh
bmtzIGZvciB0aGUgc3VnZ2VzdGlvbi4gVXNpbmcgdGhlIGRldmljZSB0cmVlIHdvdWxkIGJlIGNs
ZWFuZXIsIGJ1dCB0aGlzIHBhdGNoIGZvbGxvd3MgdGhlIGV4aXN0aW5nIGkuTVg5IGlteC1yZWdz
LmggcGF0dGVybi4gSSBzdWdnZXN0IHdlIG1lcmdlIHRoaXMgcGF0Y2ggdG8ga2VlcCBjb25zaXN0
ZW5jeSB3aXRoIHRoZSBjdXJyZW50IGNvZGViYXNlLiBUaG91Z2h0cz8NCg0KQmVzdCByZWdhcmRz
LA0KQWxpY2UgR3VvDQo=
