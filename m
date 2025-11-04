Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1247FCCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 10:06:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C6FA8144A;
	Tue,  4 Nov 2025 11:06:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="fyOTRHRU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA7A782A9E; Tue,  4 Nov 2025 11:06:21 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AB728004F
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 11:06:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uS3yAbO9Sg41+Vmld1w9OwJquptNuFAKUQDoo8X/4pjDX4/MwuIFOA5bSLjsNRLqCrorphwSyJJ0HmXXZEEhaJTRL/LbMIXlagZw5wHObzH97u8vTAy2iAwRpHPtAvFVPjLCZuh06iGCET6TOUhudyGUyW3EA2K8JCmDo8JJ3XtlEzhb9pPpfWLQrwKi1ma08GayjgS0HM1mIRbsWhpJ2l+U73JjYBYrrlw9eiqLaBgG4SibkbxX8KJmlwxjgB6UL/MSOn5XbfdICr4SRPpJzMwN63PxjAGEHoyr3i6f9sebd16bhPVs2MdeiXNwROEVWOhYkm6VHHB2e2qvMnLmRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0eN+SIvgWMM+yqPhnlnwZBdTcKfFAhiAXfAnPWGtI4=;
 b=E4Z6i+WgwRNc8cgjAV9GKGYqw2SDKkl0bkyak1cLbMR94EJjUmp1AqLjE76xmL1QIheIVqMgB5QZ6rxkUXGtmpVLKwk/wMn6IKmu4wINkMMDaFJkjmFiuqMW3vntpS1QGBLBunX5TiUK3OWh/gNkeI+SRW2dd8Q2cHuwchpZkeiPsZ/BMYkruxJbIfiXD4q4MNhAgDJlt49THTFyPbf8LBVnQWwKtEwMXMwLfDw3WMiA3XubC2bIBZtsMRQ7uQSheR8Wj2pAMPqHsI5frWZr3yBvDZx1b+zlv2yqDLQK/fNJ5KEjWfbnnZF5oxgD5KItmiZ0lORPDKoBejE77IFWJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0eN+SIvgWMM+yqPhnlnwZBdTcKfFAhiAXfAnPWGtI4=;
 b=fyOTRHRUPxjCSkyhhojXlwBkx50T7fmoZuZDg8+VqX/P033JNkNoh27Ect/4fWrG8Ba72lV8stkmylsIGx2h1mY2qnphVolThWo+L9mIC1xiJE7zeb2CnAHAxoFd67bI5owfnTIiE07N2ul+b88qznKEwSY9yYF4dYYntLH2aKAOLG6DPLjmBskHzW+T5Ty9XGwD/8sLwdPA7ehCvt1VgNXL+v30DqDUYpIEaS4inb5XFSDVBo0jpZtRRzbD9upUYxrrFX6JQTzgUZU2Lkj5wLsoUiFXyKBj8KTqIeELqtln4uQcd/TByDrbq+Rzb9tSgX4/2BwF/6QzzOIYhXKdlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS5PR04MB9969.eurprd04.prod.outlook.com (2603:10a6:20b:67c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 10:06:15 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 10:06:15 +0000
From: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v4 00/12] remoteproc: Add support for i.MX8M[M/N/P/Q] and
 i.MX93
Date: Tue, 04 Nov 2025 18:05:49 +0800
Message-Id: <20251104-imx-rproc-v4-v4-0-8bbc7b886737@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAP7PCWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHQUlJIzE
 vPSU3UzU4B8JSMDI1NDQwNj3czcCt2igqL8ZN0yE11jkzQLU0tzA1ML8xQloJaCotS0zAqwcdG
 xtbUAIEcOBV4AAAA=
X-Change-ID: 20251103-imx-rproc-v4-34f85970587d
To: u-boot@lists.denx.de, uboot-stm32@st-md-mailman.stormreply.com, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Beleswar Padhi <b-padhi@ti.com>, Udit Kumar <u-kumar1@ti.com>, 
 Andrew Davis <afd@ti.com>, Judith Mendez <jm@ti.com>, 
 Ryan Eatmon <reatmon@ti.com>, Hari Nagalla <hnagalla@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762250765; l=3696;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=EtnHgnPwg+QCi19rdI5HsjHpn/2/ljTj+w4KYApYpXk=;
 b=HYTWGXymNOqqh+sk9fgU9Ch/NwSuQW8PcbaURJmnWULP+nqWPfke+Qm3fQzoI3u9MDa0JClS7
 zwP+nj3HouEAGnHOaQyH/IONC5NTMSuAdGJyvC7cVqvcKjbJLjpCdiV
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::20) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS5PR04MB9969:EE_
X-MS-Office365-Filtering-Correlation-Id: b2bad989-b635-4d00-bc1e-08de1b89ca79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|376014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TEFINi8vdGdndFdMMHFIN0ZNbUlhT21XbU03cmF4eWlJck9RQlpPQ3lOQ2RM?=
 =?utf-8?B?YjBSUDFpK3lCSXhqazBldzhTdWxyZitYU3lPRUhENDZ4Q0JFQ2lLU29zVFRy?=
 =?utf-8?B?cUc3aW5haWFJdFRqd0dCUmJxL0ZQOEVrSzFnNTdUdHMrRXZBd2NXNHRoQnVa?=
 =?utf-8?B?aTdvcVRnWFViYytLdUN4Ym1HUlptU2dBU1hWcEdXYXRjdUhiWXlTTmFPQ2lN?=
 =?utf-8?B?STlUR29LUWlmam03WEo0UEJOTmYzYkFKSjlIWlFhOGcvanh5OW9GU01lV3lW?=
 =?utf-8?B?TU51TFdMY0lXajJtRnlabGs3TUxIQUFLeGFNbzA5dUhaekNwWk5BeHFlL20r?=
 =?utf-8?B?VGpvdE5rQTVNMEVxd0dZVEVHZXo2SU8xZzl6N1Q5cWlQc1g1dXJuV2o2WUl5?=
 =?utf-8?B?dlVpS2d6NE1XNVhVOGZQUU1LeE5OdUFyeDZ6QXl6NWlpci9zdXhNcGIyT3Zn?=
 =?utf-8?B?aXBESmFyb1Ria1FnS3BnSWh1dk84dG5EbjFPWERoMlRUZWQ0eEVQb2xkNEdR?=
 =?utf-8?B?RU1tbm81dm4rSHlGblJNTmI0SVR1eWttY3JHNUJzN0MvQWtidTlpNGg1M09v?=
 =?utf-8?B?T2g4bmQ1VnUwd0hKM0szWExNNzRZOXZtODYyOFNQRmRCcDk4ejRSRHlsemJ3?=
 =?utf-8?B?QXdIaWVFaHZmNjFHcGJuK1F1VDRVb2h5VDFxRkpTaDFLaGFoSFdaR0NVTllB?=
 =?utf-8?B?b3RxbEFGREp5bWJDazJFTHkzQ1ZscDF4K211eEt6V2YxVmtmdGxKZ2JRWjFR?=
 =?utf-8?B?TXAySGdJbjV2Ung0bUVzcTdTS2tCbDc4eFcxV1loODhRNjJiNnZuV21WcG9L?=
 =?utf-8?B?MUh0SHU4SEI0TityRC84RGRhZGhCL0hrdHFtSENlbmlVcjAvTGovanhDODNl?=
 =?utf-8?B?OTVEYlJ1K0wzeDhCUlJKWWx1a3J1RFFSK2VMNkdXa1FqUzhlOThrWmtFTGNV?=
 =?utf-8?B?ZWhueFp4Q3ZFSjlpRGtrRDJaUTlrd3FXdUlqSlhYMisySkRJc0R3RTYwRkVv?=
 =?utf-8?B?MmpLTEx5eHN6QkphVndKVGwxaHdTZS9xMnNRWmxQRGRFRDdBakZ1MjQ1dm85?=
 =?utf-8?B?aTFsNzdXdm01cGQyU01YcTkrYm0zUTRoazdJVlJlLzE2S1RLZ3BQWTVyRndK?=
 =?utf-8?B?WFVScDFJUGl3dUV3QnloWm5BVXB4L2dDUVg3U1FOajV0UWVwR0Q5d1NkcGpS?=
 =?utf-8?B?R013U3VZOTFrSjhJRDd2dmJORmcrUTlmQ0J5QW5KZWlFTm9QRnFIYjZONXBZ?=
 =?utf-8?B?ZzFnYy9reGVLUi9ZWWt2NXdFOExKSHhhTW9JaHlyQzFIWUpOd05WZ0wxL0Zp?=
 =?utf-8?B?c0U2WFB5Zi8zUllPUG5pZUwrdEFsZ21FZ29NejIxS0hkVHYrSWVTVzllRS9s?=
 =?utf-8?B?V000U2ppUjVnSHVidXNVQ21oRWFQVEp5T2xpNTZmSnZlMlZleC85NitBNklJ?=
 =?utf-8?B?RURLMnhQNmpQVE9uR0NncStyZURybXNlS2psK25NcDExMWlaM3B6RGdRaWN2?=
 =?utf-8?B?YUxwZjNBbndHdXo1TTdjejBqdHlrSXovRGdVckkxMm0wMzJFLzNmU05BVGxW?=
 =?utf-8?B?NWJiZEJ1NEkzWlFNQ3lLc010dktFTUlSK0dndmk5ejFvbmJrRXNaR3JtQk4z?=
 =?utf-8?B?QUNwekxRRlREdEc3eXJTMEJIMUZKalptYkQ5MDk3ejJqaUdUZUd2RlozZTAr?=
 =?utf-8?B?WGFkTHpsVTVhODZtNTBwY2JpTmtOaVpHanJaUEUvQ04wUVJKcE93a280UWZE?=
 =?utf-8?B?VmtLRHZTZTYxR2h4QnFBVHNKVVBzdjhSb3NNbFY3b0xBOXlxem54WXJ3aEF6?=
 =?utf-8?B?UG1wM25pTTVHSDlFYkFKZ0Y4MkFibHlrbUhRcTI4OTVtTnBCdjRKbmxzeE5E?=
 =?utf-8?B?N1puMnNFVmRMMU5vazBxQUkvOGcrdlZRY2ZjU2w1NFp6TDBiRFplQ2V1b2Nr?=
 =?utf-8?B?TkpaOUdVQUVJV2dTWDZKd1pMZzN3UzhCaElBa0lyaVlKSVdnQWZuVGxPTDdV?=
 =?utf-8?B?NC84c0xYRHZxYW5MRUZLMnJzbStqSkxWMVBzc05nNVBncmJGVStUYUNhaExu?=
 =?utf-8?Q?g0TIHH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzdNTlcyOXJ0dHRUbmZaMGxhMlVzbStBcjVlc3YxZWEwL05kNG9CS0VLMXFI?=
 =?utf-8?B?eEVxMGo0ejNpSnJsS1JUZkVuWDduemtLSm11eXVJTU1iY3Y0ZTNhaTlSbUNE?=
 =?utf-8?B?c1RXVU5ZL3RJUndIZWQ5VHpTQzdSNG5MT3hVMm9McE5ZTFlUK2ZHcWFtZ1hB?=
 =?utf-8?B?bURBTVRXNjNyMy9mUVFRNHVPUnZKNGdjbEtUcklFVTJNWkxaeDVUcWR3SDZC?=
 =?utf-8?B?R3Fma3NvS2IwOWYzS0dUaHVjRXFGQVZMRUwrWURMN1UvVFUxR0FnaHczZ1F3?=
 =?utf-8?B?Rm8xQ3ZwdmE4dkk1M2FlczJLQ3JsN3FMMnRXamRtUXRkNUdLNGhTSGRranZr?=
 =?utf-8?B?NXd6VDVKcGpTTzVNNVhoRFBjcHNKeExyRk5lQ1o0WjJzZjQrRWdQSGM0K2w3?=
 =?utf-8?B?TEpnNXlkWCtVeDVpM2Q0a3lYajBiUlpOVDdwSjhuRnJRQWdOR1BxTEwwVVRM?=
 =?utf-8?B?NitPUnoyZW5KYXhXd0I1eG1qNHpLWHU0Q0RadFpWQUNyVE1UR244V01jQUpy?=
 =?utf-8?B?MDN3emZ5djEweHlYd3JIOUJ2QlVLdnhlUDIyVmJ5aVJCeUVIdXh2cnNTOWla?=
 =?utf-8?B?clpDb0FmdVNKQmF0ZFl5UXAyWURWSWFUTVdyN3hjUGU4MkNHZWNFME1yUGJr?=
 =?utf-8?B?RGw1TU5nN05VeHVHbHI1THZkNWJGckpyd3pDTGVJTlVXbXhUSWlzNHJQTHJM?=
 =?utf-8?B?RThJRDgwb3dqemxXcEFDcDhGdU1KTmwzeEFFa3VhZC9zQi9vQzdsbFpleGZU?=
 =?utf-8?B?a3c3b2VhenhjZ1NtNnZzSkZiMXhLR01zSDgrZm1ZNmU3WUorRmtLTlY1TEhl?=
 =?utf-8?B?b2J4TXo5ak5VNXA5Z1VpdjdqQ0gwd2FGbFZZMU9xZUFwZWo5Z0pxb3VJMjly?=
 =?utf-8?B?L3E5MjQ3NHJOREtibHVaUzVNMW53TmRvNzNPdDlQOWFqYnRXb2JJazkyekts?=
 =?utf-8?B?MHhLTDhhN2txMDlPaktMaVJ4NmlucVJSRFdlTTJOdTRTLzRFZzIrenVSZUV4?=
 =?utf-8?B?bithNmZZWTVtSW9FZ0pnT0NQOE1jMU16MzhSekttenFxZWIzRDhZR0hKVmZr?=
 =?utf-8?B?aW0wUUpLOWZYdUt1MmFqcG42Z1cyM3Y1TUZ5WjVLbE1HMm5oY2dlaE10cjZI?=
 =?utf-8?B?YXZiWGN0NGoyZlI0eEUxVmRTTGlFMGZ2NlA0OUo4WHNBcUJGN0NsbC83RVN4?=
 =?utf-8?B?TXFCWUxYQjNYUDNaRXQwSk9nNG9WcDFYYUdJOGFXRU1EN3B4MUczMFJwdWJj?=
 =?utf-8?B?STVvcTZib3lMV2czMTJXZzdrU0tZT1VSWDhMV1pzRWxjR3JtS2xWZXVRaTN6?=
 =?utf-8?B?dkVOOEc4VS9tZktpeUphbU1rM3lsQnhQV2E2TGlhWDMvNHZiUUo2czVFZHNo?=
 =?utf-8?B?NllmZEwxclNzV2Q4WGlDbEtTb1dPTGFRSkNsMUJSczN0RnNvbXpSaWIyTDFT?=
 =?utf-8?B?bU5LdEhDWTNadUdLMzRuTit2Q1A2U2t3bHhzVDNOZngrdnlueXluWk5LRkZa?=
 =?utf-8?B?SnR4c0d2OVIvZERBWnp4OVJha2NPODhCL0F5QTZ2VG5xL1dFc3NEeUNYbUt4?=
 =?utf-8?B?REZvSUdLa1Rac01ROUpOcVhQTmhPNGcyTmM5RmxiSzlBOVE4Rkd0USttei9K?=
 =?utf-8?B?UGFxanNKbng4MS9RS0YrblpzY1dEclhUZmY3d0I5VUMvbzJOdUprb011UGxE?=
 =?utf-8?B?SWtDcWJrUFRWTmdtaXF6L1pkc2tMWmNrb3pxZ0xsN3BhZmFRWUEzeitmYUs1?=
 =?utf-8?B?a1I2YnYrL0RqTnIxUDlWeGdwT2R2Wmo4WE1mQ3FLSVp2K2p2OVNkUmNQZEUz?=
 =?utf-8?B?bEVkbDBQTVlDWCs2SklyZ1JmcGR3Sjk1WFJ5UzRJeWp2UWQwbFZjSUhRK0RR?=
 =?utf-8?B?SjVZQXZXZXdIWWxORTJJeThSbFhNeHcySi9MZTFreCtFU3hlVTY2akMwUEdK?=
 =?utf-8?B?M0dzL0ZDcG4zZk92Tm1tYmJ6SkhMelhhLzhlRXRmRXlRYlpIUjVuajJjTnp6?=
 =?utf-8?B?bk9tTnJIRGNnZTd4SU9LUmx2bi8xN2JBMmpkaDB4dEV0YXZMRjVHaVpOWjFT?=
 =?utf-8?B?UWR2NHZYWGZCaUV3ZjBKenJYZGdVUEJ2V255R0VwS3NMWXh4NDgwVWlnNldw?=
 =?utf-8?Q?AUy0gX5H3Skbm+1Rfj2i2ZKxq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2bad989-b635-4d00-bc1e-08de1b89ca79
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 10:06:15.7052 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qf1epcnPHFY4DTsSN8QV52wlkGn7RnPqcjVw5mwz/t1+oVTwzincmgUARljcuMpKGgNiKO4OK5ZnyQiMdIvvFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9969
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

V4 patchset pass CI:
https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/28137

This patch series introduces remoteproc support for NXP i.MX8M and i.MX93
platforms. Most of the i.MX-specific logic is ported from the Linux kernel to
ensure compatibility and maintainability.

The existing bootaux command in U-Boot only supports loading raw binary images.
However, this approach fails when the remote processor firmware contains
sections that must be loaded into both TCM and DDR. To address this limitation,
need to use remoteproc framework ELF loader, enabling proper loading of
segmented firmware images.

Patch Summary:

Patches 1–2: Import memcpy_io and memset_io from the Linux kernel and enable
             them in the remoteproc subsystem.
Patches 3–11: Add platform-specific remoteproc support for i.MX8M and i.MX93.
Patch 6: Temporarily adds Cortex-M nodes to x-u-boot.dtsi since they are not
         yet available in the upstream Linux device tree. These nodes can be
	 removed once they are merged upstream.

NXP internal R-b tags are kept, because the patches are directly
cherry-picked from NXP LTS tree.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v4:
- Fix sandbox CI failure.
- Rebased to latest master to address conflict in documentation
- Link to v3: https://lore.kernel.org/u-boot/20251022-imx-rproc-v3-v3-0-92273a82c5da@nxp.com/

Changes in v3:
- Add doc for remoteproc
- Link to v2: https://lore.kernel.org/u-boot/20251015-imx-rproc-v2-0-26c6b3d16c35@nxp.com/

Changes in v2:
- Drop patch 1 import memcpy_fromio which is not redundant
- Link to v1: https://lore.kernel.org/r/20251013-imx-rproc-v1-0-fb43a3fafcd0@nxp.com

---
Peng Fan (12):
      remoteproc: Extend device_to_virt with a is_iomem parameter
      remoteproc: Add imx_rproc driver to support NXP i.MX8MP/N
      remoteproc: imx_rproc: Support i.MX8MQ/M
      remoteproc: imx_rproc: Add support for i.MX93 CM33
      arm: dts: imx8m: Add remoteproc node
      imx8mp: Enable remoteproc for i.MX8MP EVK
      imx8mm: Enable remoteproc for i.MX8MM EVK
      imx8mn: Enable remoteproc for i.MX8MN EVK
      imx8mq: Enable remoteproc for i.MX8MQ EVK
      imx93: Enable remoteproc for i.MX93-EVK/QSB/FRDM
      doc: board: nxp: Add remoteproc guide
      doc: cmd: Document remoteproc usage

 MAINTAINERS                           |   2 +
 arch/arm/dts/imx8mm-u-boot.dtsi       |   4 +
 arch/arm/dts/imx8mn-u-boot.dtsi       |   4 +
 arch/arm/dts/imx8mp-u-boot.dtsi       |   4 +
 arch/arm/dts/imx8mq-u-boot.dtsi       |   4 +
 arch/arm/mach-imx/imx8m/Kconfig       |  20 ++
 arch/arm/mach-imx/imx9/Kconfig        |  12 ++
 doc/board/nxp/index.rst               |   1 +
 doc/board/nxp/rproc.rst               |  69 +++++++
 doc/usage/cmd/rproc.rst               |  78 +++++++
 drivers/remoteproc/Kconfig            |   7 +
 drivers/remoteproc/Makefile           |   1 +
 drivers/remoteproc/imx_rproc.c        | 370 ++++++++++++++++++++++++++++++++++
 drivers/remoteproc/imx_rproc.h        |  56 +++++
 drivers/remoteproc/renesas_apmu.c     |   3 +-
 drivers/remoteproc/rproc-elf-loader.c |  95 ++++++---
 drivers/remoteproc/sandbox_testproc.c |   3 +-
 drivers/remoteproc/stm32_copro.c      |   3 +-
 drivers/remoteproc/ti_k3_dsp_rproc.c  |   2 +-
 drivers/remoteproc/ti_k3_m4_rproc.c   |   2 +-
 drivers/remoteproc/ti_k3_r5f_rproc.c  |   2 +-
 include/remoteproc.h                  |   3 +-
 22 files changed, 707 insertions(+), 38 deletions(-)
---
base-commit: c9fdb9ac4d5234953ffaaef0cfc9d4ccb03f0ce5
change-id: 20251103-imx-rproc-v4-34f85970587d

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

