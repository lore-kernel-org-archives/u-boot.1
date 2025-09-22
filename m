Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA6FCAC5A8
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 14:40:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E939B83510;
	Mon, 22 Sep 2025 16:40:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sttls.nl header.i=@sttls.nl header.b="FCw0AG4J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7589783335; Mon, 22 Sep 2025 11:23:05 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABB9E83211
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 11:23:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Maarten.Brock@sttls.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kcuCAIHMlZwTsi+lY3D+ysSDtMGrU4Vq+yp545XQNHnNHBJ+opIn1anY3P4Saa/x2TIbi4a1vQIy7JJJ6S97c8xLFv7gCH4dln8IT27qGtLEjf3HYfnBbqxjcaXh6aK9D8NYmE41ZxpwffO7I1AwaKgp+0WWXhU284pryGSif59V/+VAwJtZ3+daSz7867ziHNAqrw6xizSvYdwuNI6aMSTtkQL7rjUbg0UPkllpZxYpBDycRBq6X0BXr4mFnQFlXrPmjhfNp5C4MkjX/850FN2syV+3V/RBmQOWUfahuGgrkVlUpFzxmooilJc6ESekW+qutki0BTQ1c14qAGyfPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jsEtFQPzZFw9rSHe3GqtkXKhlZbSyqaNue36uQa1JbE=;
 b=ddfVsb+2LnnS00zAD21u+XOio/Z0bIbjtFlZa8iVUrrMIYTSqN88EkTQqwykpdTTOpB+fDoN+Q/NWl7RorOdhCyhxpMn8xnJembuXrPWc5bji3n1UJ9pMDgwfeVdkvhccca721qAvEWBZGvmgk4FMfPr8N1mNav4bI73BV9e0JN7VYAxfogNf7J3thHsD5FORUHDclq+gzjwtgJ8RjQOs0rTJp+o+3xZ3oMn3eROABhCdqHC26Tk8lgWyYIBJCsMpfrSfolRI6hV+PXK2hr4YMnd6xz173dTln8xkIQc1lgmA7X7JkGasgCvEviwRqrZRzqVRehJE+7mQPn/51qqhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=sttls.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sttls.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsEtFQPzZFw9rSHe3GqtkXKhlZbSyqaNue36uQa1JbE=;
 b=FCw0AG4JwKApzRBX6JLQRa9ZnPxDtPt5lL3/fsv4iRZWjBeg967Dvjdm1UxvnGL6pErUbtscCnVg7Apy4+H8f3lcLBefW7UvZwh/m6Xw2hNzuM0aelseniCSNd7QWhIl9Bqdort0Yr58aM1O0/o8YYTsI/XAjKbzLvK7besSfl9Nkw1KPNV2im3Xge0e/cDovxXy9nCDI0KG+DheHpdwTFgD1DXKCP0jT81ddnZIiMeSgdvQebwFoVfsXeNqosrF/+mVmEz98RiYgwH/3ZZO7cttMM8K/MbwpjX8XerqDwCSXbqpB9cq5jZcFNUpoE9txJa05FlezLFPr8zNzavh8Q==
Received: from AM0PR02CA0185.eurprd02.prod.outlook.com (2603:10a6:20b:28e::22)
 by VI0PR05MB11136.eurprd05.prod.outlook.com (2603:10a6:800:20a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 09:22:56 +0000
Received: from AM1PEPF000252DE.eurprd07.prod.outlook.com
 (2603:10a6:20b:28e:cafe::8) by AM0PR02CA0185.outlook.office365.com
 (2603:10a6:20b:28e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Mon,
 22 Sep 2025 09:22:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 AM1PEPF000252DE.mail.protection.outlook.com (10.167.16.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 22 Sep 2025 09:22:56 +0000
Received: from AS8PR07CU003.outbound.protection.outlook.com (40.93.65.55) by
 westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Mon, 22 Sep 2025 09:22:55 +0000
Received: from DB6PR05MB4551.eurprd05.prod.outlook.com (2603:10a6:6:4a::24) by
 DU0PR05MB10058.eurprd05.prod.outlook.com (2603:10a6:10:467::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 09:22:48 +0000
Received: from DB6PR05MB4551.eurprd05.prod.outlook.com
 ([fe80::f854:dcd:a8dc:bc53]) by DB6PR05MB4551.eurprd05.prod.outlook.com
 ([fe80::f854:dcd:a8dc:bc53%5]) with mapi id 15.20.9137.012; Mon, 22 Sep 2025
 09:22:48 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "jerome.forissier@linaro.org" <jerome.forissier@linaro.org>, Kory Maincent
 <kory.maincent@bootlin.com>, "sjg@chromium.org" <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH v2] board: ti: am335x: Do not call disabled PMIC functions
Thread-Topic: [PATCH v2] board: ti: am335x: Do not call disabled PMIC functions
Thread-Index: AQHcK6J2k0ARc/vCB0CQFuDa/taEmw==
Date: Mon, 22 Sep 2025 09:22:48 +0000
Message-ID: <DB6PR05MB45511C9367B93E1E788A543F8312A@DB6PR05MB4551.eurprd05.prod.outlook.com>
References: <DB6PR05MB4551D31271569EC04E8EC60F830CA@DB6PR05MB4551.eurprd05.prod.outlook.com>
 <20250919001117.GA974973@bill-the-cat>
 <DB6PR05MB455171F726E8D6E540141BAE8311A@DB6PR05MB4551.eurprd05.prod.outlook.com>
 <20250919141058.GT124814@bill-the-cat>
 <DB6PR05MB4551C51511978A6DF29228188311A@DB6PR05MB4551.eurprd05.prod.outlook.com>
In-Reply-To: <DB6PR05MB4551C51511978A6DF29228188311A@DB6PR05MB4551.eurprd05.prod.outlook.com>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic: DB6PR05MB4551:EE_|DU0PR05MB10058:EE_|AM1PEPF000252DE:EE_|VI0PR05MB11136:EE_
X-MS-Office365-Filtering-Correlation-Id: 30258a57-d1ef-4178-f7a2-08ddf9b99da6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?WU9IRW5OWnVWM0h6QXJtcjdxZlVQQ2o2LzBDR1NwVnA2enZWZFNXeVlXMXRw?=
 =?utf-8?B?M1g1WkR4WFZQYVV6UUU5WkVON2lZZTJzdmZXSmJNaTNseTl2clVmd1JzZXFn?=
 =?utf-8?B?Y0tUTkk0V3ZObWdUa0pLUmEwbGlNQ28zcHE4NFBycXhVMzR0TDZYUHdFTExi?=
 =?utf-8?B?MEFqRFQza1RCSTRvQ003aExDSitvNFZCemJaN254a3FKeS9BMmRGeVh5REhm?=
 =?utf-8?B?SkZPOVJYQXZmK1BZNXhMR3Y3QkJVTzdIcHhoU0FCT0ZodEVsUWFweGZNKzVv?=
 =?utf-8?B?WFZHZ0RBSXZlaWc5eWl0K21sQlN4S2V5Rkt4eDVaSGZHSWpWWlRRVjFOREJp?=
 =?utf-8?B?OWZuTUpaSzQrTFF6RTNPOHZVR0pxUks0Qy9USEhXYXRONzQ3VjM2ay94dWZi?=
 =?utf-8?B?ZTlKc3NGOVNqVGk1TlBrUWpFU0ZOdjRUSEl4UFM0VlYwU1BtSCtYOVl4RXEz?=
 =?utf-8?B?K1F1aVNSbGlvR0ZBQ0prd1VJQXRaQmNQOXJ1K2VWOXBvYVJBMFlVQlVRMXlK?=
 =?utf-8?B?VE0zY00ybTNKWWxqSTF4OHpVcS9RU3YrWGhabUx2d2ZMWHR1UVJqaTRSakR0?=
 =?utf-8?B?WVFKYzhoTjlPWlNtUmNaZWR5VHBEZjdwU2dSdUFNaXBVaEtSNW9aaEhveHlr?=
 =?utf-8?B?SkhoVWEwSDhpUXdhaFA1MDhVdmlTRzE0bElxcGkrMnFDN1YyREhYZjNyNklO?=
 =?utf-8?B?M1UzODVVSDBMRDhSOTdQTlN0ZDFCa00yUjExV2FFSUNBTHZKbWFncnJYNlRl?=
 =?utf-8?B?UnB1USs2cVpVN285Qm9Sb29IczBPcVNiV3ZoVk5OTkM2dUdZREdBR1ZGNHFi?=
 =?utf-8?B?YlgwNzN4WUxWTXAzZjA4aWNwamFYaytKQndVT2I5WkxqQ3V2TkMzLzNoSkJi?=
 =?utf-8?B?SENuYTFnV1lvWWNYQXlWU1NFbDZuL2F4V09hTzh4VTZWRzIwaWFNc255NUlL?=
 =?utf-8?B?U2EvUlYzeS9YcjZOTWFGUkEyRm53WXh6eWkrdE44MUhINzk0Z0lLMDRKUzRa?=
 =?utf-8?B?Z2UrZFYydThFSkNodnVxNVRyZU5BNERjREh4T0c2UGs2bUEvWjNvbjk1aTJq?=
 =?utf-8?B?a25wMDd4aU5yd1cyRFc5SnBNTE9TaTlRdmM4OWtiNXBIeUhQM3lxVi92M1dz?=
 =?utf-8?B?a2E0cFlINVJYSE9FS0xoNG5ldE9GQ0xodklWdmRsYit0L3RiWUxKbmZRUHVh?=
 =?utf-8?B?U1Z3QStYKy9tc285Vk5obksrdktHaHFCQ2h5TXVhUXE3enorMXJIb1lrZzlX?=
 =?utf-8?B?b1JoWlBoMk91MmlFdFVBUHdyWENMYXkyOURzdXpjSFA3c3VrSGw5OU95cndo?=
 =?utf-8?B?MWZMM0cwRUt1RzBVNzRnYU0vQTlSRWMvSDJibGI3UjBqRmJmZGYveXQ3Y21J?=
 =?utf-8?B?SndGb093a0tqcW50eXNJWVd0ZkRiYnRXNmN1N2taR05WOE42S0s3MmR5bVpU?=
 =?utf-8?B?TWdwTzNxS0MyZEtzYStCb0xxRFFsYkw1R3RaR0pnS0lEb1EyRjhBdWFJWm5H?=
 =?utf-8?B?S1o3Z0VrRHNKWVFFYWkxek9lcGxqamQ1elB4ZjF3VHJLRGRKNmp2dDYwc28y?=
 =?utf-8?B?UCtnK2U0dkkzcDJaenl4NXFxR0k4ZndRTENjaERsbjJ1c2p6T2dpeFFrWGE2?=
 =?utf-8?B?SjBMWUNMbmxrRmlvS2NUYnhIUW9uZkVhVGh2bElNTk9oRTVGeHpJNDdiampw?=
 =?utf-8?B?SHIwZGVic2w1aCtwTVRuMXBqTzZ3S1VBek16SlRjaHF3bWZqOFFmdzJIeXRu?=
 =?utf-8?B?bW1Ray9HTTk0YmIvaWlydm9pcjJOU1Q3cG1ubVpGdGwrZzV6OUVoWCtYbWFC?=
 =?utf-8?B?czlwOUdsQ2Nwb0crWjVoSkg5Z3V6YzRZcTF2YXp5enBKR0xoMHpWYStCY1Nv?=
 =?utf-8?B?UXRtRWY5V0ZpT1J0NENtVEs0eTBqTnNDUitEa3VjbDFsb1kva2JTVEhJaFpT?=
 =?utf-8?B?N1lEaXBpclB1N2RtYnB1blJGWjBuS3R1OXp4UWpTeG1JSjZqSkI5V2pQWlV2?=
 =?utf-8?B?K3B6SkIzZzFBPT0=?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB6PR05MB4551.eurprd05.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700021);
 DIR:OUT; SFP:1102; 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR05MB10058
X-CodeTwo-MessageID: d9589d33-47b1-421d-a160-8271f7a23b83.20250922092255@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM1PEPF000252DE.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 75be9035-d555-498a-e2ca-08ddf9b99907
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|14060799003|35042699022|82310400026;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y3ViSUFzem5maUlwRDhCa251aXlwWWVuS3ltTmJXd01FYVFaZWhmakxtSG0r?=
 =?utf-8?B?MklGVnVyOEdremJXZzBFdjFlQXk1MEpYTkt0NkR6eW1RVEpXYUZFbGE4RVpS?=
 =?utf-8?B?Vm5WbVRLVStVN0NYdGpPdXRENHBsK1k1d0QxYjZrZ0hHUm1IRmthRzFtUjVZ?=
 =?utf-8?B?TkQvUXJNK3NPNVRDU1ozczNFWWdrUmVyYk5velJLM0dkRlpWVCs3N1lLVHBF?=
 =?utf-8?B?aExJSzc3bDFNZGhLSVovZE00VjlPbXI3bU5mdzE0a0doc2hRUGdXbU1ldWxX?=
 =?utf-8?B?TUZjMk13eWJEaUF2NklUS09XV1dhSkUvT3FRdTloT3psUXdhcmxWbXpoL2d3?=
 =?utf-8?B?ekdGSHllZEJ0cFVwcWQrWUhWbGRHd1BadWc5MDJNcG01ZjVKMlQyQ3NYWmNv?=
 =?utf-8?B?aVVTMmYzR1hSOXNqSHlWUUViQm1sRy80SGMxVkNUcFd4MmIyUWlvS00zK09V?=
 =?utf-8?B?OS9NOFFlQW5aYVEyVnhWRW5hUTRPNGl6ZWxtT2d0aExzN2NZQVR2Y2UzcE1s?=
 =?utf-8?B?NnNQSFpZS0pvaVZoV3lpSTN0ZlBkTkxuQ2traHlUcEkrMTgxdE9YMlZtSnlQ?=
 =?utf-8?B?bmlmWTlwdktKUkh2SUJiSkY0SVFxZkRjZ05WVHZtVWdoTVQ0UXh6d1pQaUY1?=
 =?utf-8?B?dTVBZ1FvMGliS3doRTY4UjBjcE42eHFCT2xaMUdDZDAvQjgwNE9tOG1yVWsx?=
 =?utf-8?B?dUpmTXJaUzhkM0JjSXhhOVJlbEs1MzYvTndMV0UyZytpUU42WlpMVDZKQkg3?=
 =?utf-8?B?R05WZm5HWkpnY0doZ0tqcmIwaUswYUYrUUlVRUxtT2VaekxXbXhWTFZxd0tp?=
 =?utf-8?B?aDUwQUYrQzduaXJqanR6dGVkL1lNTUVFUlZvbk1jZmFtR2thRTh6N2RTMlJH?=
 =?utf-8?B?TTZPZU0zSjgzb1VMOElTU2Z0bE5VZWdEWjFMU0I2dHBnUDJvOVd5dkt3UTJn?=
 =?utf-8?B?aUxvWXk5SStYYVdmaUl1R1pwVXFWQjR5UnFUVW5UM2NXMElVVFRIbW8rTWZT?=
 =?utf-8?B?d0xKcHRmVEdibjFTQXZwTnMxOENlVy9SVmRyTDZhSW9HWlBFSDJGWGdYR0s4?=
 =?utf-8?B?bnpKNllreUpCTEx6Rm13dS92TjlGRkhjMDZZRm9BV2lscmpKQmhaUDVtbmZO?=
 =?utf-8?B?V3d6Q1hOaVZzTDFhd01nRGUzRWVIK011bTl5c1JSMTRIdFNwUlhPd295NW9U?=
 =?utf-8?B?eEhVcUMzam0yS2gwQjdxVlVIQm1kVVBPWFVhM1ZWTy9qcVVWNzlibENWZjNh?=
 =?utf-8?B?a1R3b1JtaHVLWStneGxPUkVyaUd1RVM4V1FoZzBCUHcvMEFkTUhFVHllOC9y?=
 =?utf-8?B?N0ZGT242QkJ1YmNEOXE4dHRmdE9ZVlVIeExoMFhwMUljU096RnU0TWQrWkI5?=
 =?utf-8?B?QU5lUmJZWGUwWURRQlZNQnE4eS91b2dDWXlMa3dMNDkxdUhMZ2IvTEpxeStz?=
 =?utf-8?B?alNMM053NTR4S1JLRE9STWdsMlFzN1NEYjVoUlQyTW1wY3hLYkxwelh6VFVJ?=
 =?utf-8?B?aWovazNKV0NwTVV2Q0I5UGZDWmI4a0J2b3dYMkthb3BkaUgrSXd6WUEyTUJv?=
 =?utf-8?B?NmYzeWNjSmVoZ0NrSmNpc2QvMVlBdjREcUo0Mm00TG9iQ0ZyaTJWUnVqdE5Q?=
 =?utf-8?B?VmxSTU1BNFd6Uld6d3ZBbWo5TnpCYlRQWmVsSU9nUjEzaHBYaWk1MGg2TUpV?=
 =?utf-8?B?YlFFNlVKdG1ZbDZiRWJJZTZia3ZSNnMyWVFWcU82dTlKOGdYVVEyby9DL0V2?=
 =?utf-8?B?YnpGcWJMbFhkempsU3V4Ui9SN0pVcVpCYjlLajJ1NlhrTlJHRkJodmtRTVRQ?=
 =?utf-8?B?UnRIdVNWTUVOQjhycHE1bFN0K0ladGpUR0YzRDZJaGEvNkZyZTJYSTU3dXdM?=
 =?utf-8?B?a3Yrb1RaeTJOZ0luaFp4Q0dIQm9LRFhXV2tYOEV5YzdTZXh0elZvUUxNdE4x?=
 =?utf-8?B?QnVzbFd3SDUyS3lEUXY3K3pUZUk4engyNEljUlVXdmpFMURUZ2FoSVRhM0sr?=
 =?utf-8?B?eFFFNjFTSWRYUEFQdFlXZVo1c3lZYnV3SlFsZlM2b0FlZUNBUFBDMU5lMkdK?=
 =?utf-8?Q?6iRSxV?=
X-Forefront-Antispam-Report: CIP:13.93.42.39; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu12-emailsignatures-cloud.codetwo.com;
 PTR:westeu12-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(14060799003)(35042699022)(82310400026);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 09:22:56.5351 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30258a57-d1ef-4178-f7a2-08ddf9b99da6
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a; Ip=[13.93.42.39];
 Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000252DE.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR05MB11136
X-Mailman-Approved-At: Mon, 22 Sep 2025 16:40:04 +0200
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

V2hlbiBQTUlDIGRyaXZlcnMgYXJlIGRpc2FibGVkIHRoZWlyIHVuZGVmaW5lZCBmdW5jdGlvbnMg
Y2Fubm90IGJlIGNhbGxlZC4NCg0KU2lnbmVkLW9mZi1ieTogTWFhcnRlbiBCcm9jayA8bWFhcnRl
bi5icm9ja0BzdHRscy5ubD4NCi0tLQ0KQ2hhbmdlcyBpbiB2MjoNCi0gdXNlIElTX0VOQUJMRUQg
aW5zdGVhZCBvZiBDT05GSUdfSVNfRU5BQkxFRA0KLS0tDQogYm9hcmQvdGkvYW0zMzV4L2JvYXJk
LmMgfCA4ICsrKysrKystDQogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvYm9hcmQvdGkvYW0zMzV4L2JvYXJkLmMgYi9ib2FyZC90
aS9hbTMzNXgvYm9hcmQuYw0KaW5kZXggNGFkYThiNTM0YzEuLjcxMjgxOGVjMjM1IDEwMDY0NA0K
LS0tIGEvYm9hcmQvdGkvYW0zMzV4L2JvYXJkLmMNCisrKyBiL2JvYXJkL3RpL2FtMzM1eC9ib2Fy
ZC5jDQpAQCAtMjgzLDcgKzI4Myw3IEBAIGNvbnN0IHN0cnVjdCBkcGxsX3BhcmFtcyAqZ2V0X2Rw
bGxfZGRyX3BhcmFtcyh2b2lkKQ0KIA0KIHN0YXRpYyB1OCBib25lX25vdF9jb25uZWN0ZWRfdG9f
YWNfcG93ZXIodm9pZCkNCiB7DQotCWlmIChib2FyZF9pc19ib25lKCkpIHsNCisJaWYgKElTX0VO
QUJMRUQoQ09ORklHX1BNSUNfVFBTNjUyMTcpICYmIGJvYXJkX2lzX2JvbmUoKSkgew0KIAkJdWNo
YXIgcG1pY19zdGF0dXNfcmVnOw0KIAkJaWYgKHRwczY1MjE3X3JlZ19yZWFkKFRQUzY1MjE3X1NU
QVRVUywNCiAJCQkJICAgICAgJnBtaWNfc3RhdHVzX3JlZykpDQpAQCAtMzMyLDYgKzMzMiw5IEBA
IHN0YXRpYyB2b2lkIHNjYWxlX3Zjb3Jlc19ib25lKGludCBmcmVxKQ0KIHsNCiAJaW50IHVzYl9j
dXJfbGltLCBtcHVfdmRkOw0KIA0KKwlpZiAoIUlTX0VOQUJMRUQoQ09ORklHX1BNSUNfVFBTNjUy
MTcpKQ0KKwkJcmV0dXJuOw0KKw0KIAkvKg0KIAkgKiBPbmx5IHBlcmZvcm0gUE1JQyBjb25maWd1
cmF0aW9ucyBpZiBib2FyZCByZXYgPiBBMQ0KIAkgKiBvbiBCZWFnbGVib25lIFdoaXRlDQpAQCAt
NDI2LDYgKzQyOSw5IEBAIHZvaWQgc2NhbGVfdmNvcmVzX2dlbmVyaWMoaW50IGZyZXEpDQogew0K
IAlpbnQgc2lsX3JldiwgbXB1X3ZkZDsNCiANCisJaWYgKCFJU19FTkFCTEVEKENPTkZJR19ETV9Q
TUlDX1RQUzY1OTEwKSkNCisJCXJldHVybjsNCisNCiAJLyoNCiAJICogVGhlIEdQIEVWTSwgSURL
IGFuZCBFVk0gU0sgdXNlIGEgVFBTNjU5MTAgUE1JQy4gIEZvciBhbGwNCiAJICogTVBVIGZyZXF1
ZW5jaWVzIHdlIHN1cHBvcnQgd2UgdXNlIGEgQ09SRSB2b2x0YWdlIG9mDQotLS0gDQoyLjM0LjEN
Cg0KYmFzZS1jb21taXQ6IGU0YzhiMzJkMDNkN2VjZmZkNTg2YjdkMzMzMzY2MDNhZDYzOWQ3YzAN
CmJyYW5jaDogYW0zMzV4LXBtaWMNCg0K
