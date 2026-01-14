Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51749D29FE3
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 10:31:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3A96808AF;
	Wed, 14 Jan 2026 11:31:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="CdAV/yoN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8453A808AF; Wed, 14 Jan 2026 11:31:49 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F49E80C93
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 11:31:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=M.Schwan@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C1KuQgLiT1UFeBZK++oY+muP+ATEAe7f/GZqeTPSXXygwzsK1vlYvDeJ7wWynoAIOuEKxsOtieyL6C/8UNwlGDi8ms0kq3w3VWEK6OD8A5DtFAgo9iVaJEvpwDgXoF/jUaemxLhP6jye+L/k35tTdvTDfbuH6FSIBnA1EN47ESYloYC4blodY6RiY/ug1YRsV2XBUnhB0XMXStOSdSLrJFFq3BZepp63aXIIWlZ5vl6DACdz0iAIqwiP/d0tMmaVP98kHayS5gnrfFTWN3ApPQBrmtQJHMHjBwZpZr5B7p9izvHKA5pGIwab2x/Yd0qkzF0lr9bGnC7rcGtbzqFhTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UgFRnSqR+yi5hTrobQOp4NP7qdrwWfac006H6/wo3qo=;
 b=BhCHJT/g5JDeEd1RR5ljG61LkW5Wi2vpePdP+W2XVJdEHEZ37gdcEL9XSsCYBi4Ab2f8GPm6AaHFKGSsK7cbyqJK5LUpf6NzHzGdYrm0bNP5sgIZNKRdvntrJwTSxwL0WTyVr65SYxeNKGgaRlHhLaMhZWX/trrKY/igfyJ/qs/gBGgREmiQAxQUu0kC00QQRVqKic6fBTc00UwgwJvx/bE2uwztmaeZ5lh4isK5Gsd5oaesdnHAOynI0uHP9kR/w3LzqGS7a9zMRMtfqWcwQ0apaOzz55wnJJtz0OwoGYmPuDbVikqfDwbJyq88v7IWsO1YW7/TI4ozY75TriDnJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgFRnSqR+yi5hTrobQOp4NP7qdrwWfac006H6/wo3qo=;
 b=CdAV/yoNj56OiJJcBGiuIB3OvcBEZq9brBq1AUSczG+eCTrqoxhlfE7wk06edR22vsYGF0q+N1PKVBTuDcMarC6pjomyeG+bmLJpEEMeQrIMkJMi0Yfj9L2E6UojJ/dFLS4VAHT/oJVzyHJlyQCgyTCDPWTUkJOl3b28xxSlgo/3AxpV5dORM6sN7CIyOLTLRPRC8ARQmpFKFBoZxU7X/5gX0xItsgHvl/8IvH3erTY8L2fBQD7uBIMOXLs2eb6fi24Ihos1K3BjVSQlWWHSo21/p1kHacgZsbFOBIXUT8uvkhMO0o2WCFD/4TDzBq0qVs0EcGgj8nXkiezYNXeWJg==
Received: from VI2P195MB2489.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::12)
 by PA6P195MB3193.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:51d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 10:31:40 +0000
Received: from VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
 ([fe80::2031:4eaf:9669:3714]) by VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
 ([fe80::2031:4eaf:9669:3714%3]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 10:31:40 +0000
From: Martin Schwan <M.Schwan@phytec.de>
To: Francois Berder <fberder@outlook.fr>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] bootstd: rauc: Free memory during error handling
Thread-Topic: [PATCH] bootstd: rauc: Free memory during error handling
Thread-Index: AQHcfohvPN1jfAEN/066/ZU9BihTB7VRhN6A
Date: Wed, 14 Jan 2026 10:31:40 +0000
Message-ID: <1563c5d226cd0a455ec0cb005ad3f12fd5c22140.camel@phytec.de>
References: <BESP194MB28050FDFC3929BDBF71ED475DA86A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
In-Reply-To: <BESP194MB28050FDFC3929BDBF71ED475DA86A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2489:EE_|PA6P195MB3193:EE_
x-ms-office365-filtering-correlation-id: 42b987f4-e282-4a12-a02e-08de53581ac3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?ZzlOazJ2SFcxR3RPVHRxS0M4UmlqYjByMHlOR0IvOURNY0k2YklIWlk3eGQ0?=
 =?utf-8?B?dnJhMEVzWXhrR1FMbFoyTmVlcCtUSUZ3aUZRSldsZXNUN1dXdHAxVEJCVE9F?=
 =?utf-8?B?cVV6M2Rkb2pCTnd3VUswWG1NdkMvTGdVaEVZTEwyR1RzVUM2Ky9hSWIzYXBI?=
 =?utf-8?B?ZkV0TDkvOG9OWU5Ga3RDZ20xSjZBVXlKWVVwNWorK2VtVUFmaWZhak1wOFNk?=
 =?utf-8?B?U2dkTXFhazQ3di9kWW4xTnpJV25kR29HSUxFMW9vbFFZUEhBei9PeVBER1V2?=
 =?utf-8?B?d3VEejRJbWpKbHRXZDJLZ2FaV2Z2Q04vUENPU1NKZnRmdlh1MnJkQWM0b3RW?=
 =?utf-8?B?ZktzcXdQZy9GaXZLS3dOVGJTUENpdVFRZGorL3J4YTBuSG5YcVlaVFlwK0to?=
 =?utf-8?B?aDNMbnIrTHlJSE9OY00rdlNCUmc2ampzTndieXZGWXVXQlNjTmdOZ2I5UDAr?=
 =?utf-8?B?NG8wbHgyU1o1b1c2WUhTYnhWNzVud2hudmdkU0xtVEtYejFaNURJdTRPZ0dC?=
 =?utf-8?B?SXlidGVqc05HTWFjbHNYMFBVcFRjUEE0TVNuRzMvVzZRTXFSUUcyc2s3bUpn?=
 =?utf-8?B?SFQ4UmJNeDVBNkZ0WHJzSjNxMzdoMVNVeU1KcDNuTkgwQzV6WDRDQ0ZteGRy?=
 =?utf-8?B?Vy9tRFpOUmxMUHdCcEtPUWN5VHpCQ216MjdQY2c0ZklyVlJMaDZXak41QmVZ?=
 =?utf-8?B?YmxVM3lCVlV2RU5YeWFyNWozc2VmZUN1WlQrdkpKc2gva0hvM004RjlqSEo0?=
 =?utf-8?B?N2IzK1RJNWxLYld0YnFHemxsSS80OHB2R2ZSTFVuZFNpK3ZsM3R0OS83SXg3?=
 =?utf-8?B?M3FpWG9qVkE5UDlvOHh0T3N5NWx1N3JHK3VOZlRzU1VXTEc4NUlsTHhmQW1v?=
 =?utf-8?B?SDcwVW1CZCsxN2lOWGJJU3Z5cmNaYXMxUndjQTVtaTM2MVpsMFZoWUFpU0pi?=
 =?utf-8?B?cGZNSWlpVlorVTBvb0hITktlUEp6NTR1VGl6MHNCaDRhVXEvUUhuMVBhZEpV?=
 =?utf-8?B?UFJKejgrRm92dXY2UnBWRlBLSkNOcjVRVXltZ0JzekxyWm9MTUFUUWJEbU82?=
 =?utf-8?B?Y0Y1WmtSVUxCOHhMUGRON2Vkei9DOTJQQStYMzBqRTZZc3QwVXdwbE1jazhy?=
 =?utf-8?B?bmVkVzFOM3RBRVRZRm9pb0Y2RlgrcHlGTFNOOUlhbnUyQmxCTTZtaDZHQ2pT?=
 =?utf-8?B?QyszVUk0RHR5RDduaExTb3EydEVBK0tVVmF0Rzd4SnFkS1pKSFhpc21ib29V?=
 =?utf-8?B?cTFEU1oxYWNONDRyWWZabkFWZ1dVRWFDSXNVWUhDelJrcGZza1ZxNzBBMDZT?=
 =?utf-8?B?aktCS3VXNFZ5UzFJKzJLdGhST0NyaXBmRGFBZWQrZTlINlR3aGwraU9oUjYr?=
 =?utf-8?B?dE15SUpJTEQ0VURXUjhkd2FSSE1tWmJkTlNRLzJXU2FsM2JDZ0k4cDJpZGFj?=
 =?utf-8?B?bWo2bnNKWld5dkd0RmdTZWtBZHVoWVN2dGVWTlRZYlh6V1h4bGRDRzhqNlR2?=
 =?utf-8?B?M00vMTJKY2RMMVd1T2c3bzByZktySmY4ZHZxdTE1bFhNSlR3L0Q3VTk3MmFr?=
 =?utf-8?B?Z0VTN1p2OWozWmhaTEpkMU1sK2Z5MWVkS2taUzk1RTVZOVpCWWVkOVFpR2x0?=
 =?utf-8?B?QmRYbHBud3RwMGkwbEZURUQ0VmdhZkY5ZGpuajJqK3BYMzZOOFlUUkdBTXpr?=
 =?utf-8?B?d0VKR1JMR0tEb3BpaVdCYmFnOVMzSVJMWXhqeGorbnNOaU1XWlVqUVhMeG15?=
 =?utf-8?B?ZDJTY2RrOEZFWktvdDV2WHBZaDE3ZERaMDJxWWdhTGhGSWFWYTQ0RE96RmJ6?=
 =?utf-8?B?TlJHUnBJaXhJSkV3bStDU0YvVHJNbHgrWnY3YUk3VGdPdzRza1Qwa1VRZHI5?=
 =?utf-8?B?Z1FFYVlEaDFwakJJeGhWNHY3Y2UwdGJ3bXpJQXlFT3FzdlM0SjRrdGorSnpB?=
 =?utf-8?B?VFdGcHpWWWhEeWtRUlFEN0xuVVJ1b0p6Q0Q1SjdUMUp2a2F0SFZtNjJsVW52?=
 =?utf-8?B?NU9Femg0TzU5M28zSnNNOUNMeHA3VVNCbFVUaFo5UjVpRWp5WXduNmxpT0t6?=
 =?utf-8?B?ZlJqUUZ4V01CamRTTFNRd3V1WmVBLzYvNUlwMGxKSG9Nd1U0WjNCbjM4UGVx?=
 =?utf-8?B?YzhtWk5OR3hDRk5kTFk5M3N0NXZQWVh3dk5aZXFsTm9ycmYzRWpicTdaeGJq?=
 =?utf-8?Q?Eyt91V9/n6CsgBHez37w+I8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2489.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXVPTnlZMjdlSnBROEljNVZKTDhDUzk0TVBWYXJMV2tkZFVqeWwwdmU4b2Mr?=
 =?utf-8?B?V2hPaXFLR1NRblE5TXQ0MDE0KzFsTEhSSWFxbzJvK2F5UWsvYU1aUnV5dndh?=
 =?utf-8?B?VVFOdkVuKzJtVjEyU0hJdFZYTGt6Nk5kdndFeGZjbnBhSmgzc29KQXJDWDZ0?=
 =?utf-8?B?WndKQzQ4cDJIOHVOSHVxVTRnZEYyME1NZU4wMlVXM3JoZSs5QXplaW8xVml2?=
 =?utf-8?B?OHEyYkJWUXpRb3kyWW5NQlpJWG1XaVovRElBaXpmaXAza2I2SWhoclQwRnJv?=
 =?utf-8?B?N1g2cVRzSHVEL1VvSWsrYnRtNlV0N3V1elMzR005b2lCN1l3TEFQd1E3dnJK?=
 =?utf-8?B?R0NiclcvUVFrRUJWR0Y4OFRwcGZoZnJaNmkzcnVLNVRaYTR4TEJVMnVEZUxR?=
 =?utf-8?B?UkhjNHErQm5scXN0cndKT21oNDcwNEJFa2l6Y05UckxZbmVWNjJWZVljL1Yx?=
 =?utf-8?B?ejhzajFhdHRlYzVtaEsrelNNOFJtRjllWEZ0S05VWnVyZFdMZndrbDNuSFBL?=
 =?utf-8?B?a2NxSEN2QTlpcHpmbEVjZUx6RFFqcGRaemNyOWxZS2Jhbm5FWU9wRm51U3d6?=
 =?utf-8?B?WnpxcDZNUnJ6MjAxMG5kZGwxa3llTHBjRktaRS9FdFRQR2U3YXl3QklGclhk?=
 =?utf-8?B?U1ZHS3FqS0UzamQxWlJtM0RlQ2ZtYnJmejR5R004UnJUNEtBMWlvV01nelV0?=
 =?utf-8?B?YlcrTUtUaTBXSzZUV3cycGpBdk9BM1I2WlVBanMyNFZXUVVsMWlGMFFncG1O?=
 =?utf-8?B?ZjZGY1dqcE1SQWhOZUIzbDRzcXc1eWhQUCtWdHZZTkxnZ3BTbkpGNXAyaFU3?=
 =?utf-8?B?cUEvSkVMNThRR3RqNjM0OUswNEcweXdqZjAvZHlFWlFQakR5T3p4USsrdUxU?=
 =?utf-8?B?bnI5VlFaMzZWZGE1QVo0TU9HK3lsOHEyWEZaTmpwcmQ1QmFLWjVIRUp2aFI0?=
 =?utf-8?B?NEVXdjc4Uk1jcERMNWxMMGRyQ29oYk1MTWpEbjhzUkhJSUkrSGdBdTBzaHpK?=
 =?utf-8?B?TUNXSjVOQUtRVDlzQ1BVMEFkWHRjTEw1OFJhRzY3QXQyVzV4RHBjd3p4NmRs?=
 =?utf-8?B?MHFvN1ROZE9oRSt1ZGNoOVB5c2tSU3FTWkZ5cmx0bndiZjNqMmVnK1dJR0E2?=
 =?utf-8?B?S3hmMXZoWkJGU1pNWjM5NFoyWjJYV2hjTDBQZFM1NnlsTU1lTWZ0TGZ0RDBk?=
 =?utf-8?B?a0JQWEVzZlZVbzFieS9VSEF5clhsQXUyMEJhSU9jL2s0VTFMbWgvT1liT2Fm?=
 =?utf-8?B?USthUUIyb2wvUXF4L3dTQmE3MGZKU1hBaW5pQk1VSUF4NHVCQVNEdkVHNVFL?=
 =?utf-8?B?NEU1YXZ4V2xzU2poZnFlNTlyVmtKc1hYNWNLc0s2dFVMWlRsWUdQOTRmYVky?=
 =?utf-8?B?NjR2Y09vaXNxZWZjaGFNTjRDWHBUM2dVZTlaN2lCWUxyWGRyeHJKMGt3cnRM?=
 =?utf-8?B?WnF5YWVvNVErOVVpeG5kbFpVb2x0QVdKRVlpbkhVZWJ2T0JoRElWK3FDUXBs?=
 =?utf-8?B?VXMwSkVETEZiS2xNZ25KWkRwRGhGUjh0allsS3VGL1ZwWmxiWUcwWkVqTkt4?=
 =?utf-8?B?K3JoWUlBSTE5dlQzWWE0TjhDNHZxV05KdVhTNDgvOUhrV0piTklxa0FhTitz?=
 =?utf-8?B?dVV1TUM0MzVjVTdZSG0rVDNnUWNNREhYNkVmNGwyTEJ3SzdsQUNTMGV1NDcx?=
 =?utf-8?B?TGRNWE9zUXl1MjRLeGp0MjdSMU5PdG1hSzBBR2ZKaVJTQTJuVy9XMW1PNXVP?=
 =?utf-8?B?b3prNFlQczVIeWNYSzNiTzNiQXltNUNobWkwMFBYd2JzN1VzRmxISzJDVzB2?=
 =?utf-8?B?OUk5RGtZVWpOTEpHV3lub0JUYVNvTTlwa3B5Q0NMbmVVRGo4S1pMWVloS05I?=
 =?utf-8?B?VDlmVkM2ZG14VHl5RTNIdkRrK0doRkhxcVhHZUx5WVVQRWloTHVJL2VzWm5G?=
 =?utf-8?B?aVNLdFo0ekxmNzdUeWJvNlllM096eWZxc2hYQWZaSldpQWZxZmowQzhPSmhz?=
 =?utf-8?B?NXdIN1NkbXBkYnhPWFNVS0FRKzVicitBM1ljZCsvL3p1ZlBhTmhpQ21TZGR0?=
 =?utf-8?B?NE5tdVZDYmhwMlI5ZzJSWEw2aFZJdEdGUFB5VU82VXZGUDJDNnh2T00xb3pY?=
 =?utf-8?B?SWlhY2RTRE9EWnNVbnRWQlB1bHZZbVcyd1RpSWtJMFB3ZkVlL0VINlhydGJw?=
 =?utf-8?B?Q1hkd29DVEdCTFNIMnBNQzF6bVNEVnZ4blJZc3p3aDkzUjdOWXBmWmRmMlNk?=
 =?utf-8?B?R29seWxUcExBRnhOdEVtMERjTUZmVHIrdWV3WDJTWnBIbGxnSkdhdFp5akxl?=
 =?utf-8?Q?IZzgFQA7PiYs6FVxK+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB0AFC4573361547BF372014B38DE721@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b987f4-e282-4a12-a02e-08de53581ac3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2026 10:31:40.4199 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gR8QBud3kKfSJkBLMCx9t5Tzf7+Aq+3Cq2DbAOPVSm9JZSoNiMkNzswlkNKjwJXDAIUhHML9uq5+lRA5LkBMAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6P195MB3193
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

VGVzdGVkLWJ5OiBNYXJ0aW4gU2Nod2FuIDxtLnNjaHdhbkBwaHl0ZWMuZGU+CgpPbiBNb24sIDIw
MjYtMDEtMDUgYXQgMjE6MjYgKzAxMDAsIEZyYW5jb2lzIEJlcmRlciB3cm90ZToKPiBXaGlsZSBy
ZWFkaW5nIGJvb3RmbG93LCBtZW1vcnkgd2FzIG5vdCByZWxlYXNlZCBpZiBhbgo+IGVycm9yIG9j
Y3VycmVkLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEZyYW5jb2lzIEJlcmRlciA8ZmJlcmRlckBvdXRs
b29rLmZyPgo+IC0tLQo+IMKgYm9vdC9ib290bWV0aF9yYXVjLmMgfCA1MSArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0KPiAtLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDQw
IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9ib290L2Jv
b3RtZXRoX3JhdWMuYyBiL2Jvb3QvYm9vdG1ldGhfcmF1Yy5jCj4gaW5kZXggODMzNzE1ZTEzOTUu
LjQzMmQxNzBlMDA2IDEwMDY0NAo+IC0tLSBhL2Jvb3QvYm9vdG1ldGhfcmF1Yy5jCj4gKysrIGIv
Ym9vdC9ib290bWV0aF9yYXVjLmMKPiBAQCAtMTM5LDEyICsxMzksMTIgQEAgc3RhdGljIGludCBk
aXN0cm9fcmF1Y19zY2FuX3BhcnRzKHN0cnVjdAo+IGJvb3RmbG93ICpiZmxvdykKPiDCoAo+IMKg
c3RhdGljIGludCBkaXN0cm9fcmF1Y19yZWFkX2Jvb3RmbG93KHN0cnVjdCB1ZGV2aWNlICpkZXYs
IHN0cnVjdAo+IGJvb3RmbG93ICpiZmxvdykKPiDCoHsKPiAtCXN0cnVjdCBkaXN0cm9fcmF1Y19w
cml2ICpwcml2Owo+IC0JaW50IHJldDsKPiArCXN0cnVjdCBkaXN0cm9fcmF1Y19wcml2ICpwcml2
ID0gTlVMTDsKPiArCWludCByZXQgPSAwOwo+IMKgCWNoYXIgKnNsb3Q7Cj4gwqAJaW50IGk7Cj4g
LQljaGFyICpwYXJ0aXRpb25zOwo+IC0JY2hhciAqYm9vdF9vcmRlcjsKPiArCWNoYXIgKnBhcnRp
dGlvbnMgPSBOVUxMOwo+ICsJY2hhciAqYm9vdF9vcmRlciA9IE5VTEw7Cj4gwqAJY29uc3QgY2hh
ciAqZGVmYXVsdF9ib290X29yZGVyOwo+IMKgCWNvbnN0IGNoYXIgKipkZWZhdWx0X2Jvb3Rfb3Jk
ZXJfbGlzdDsKPiDCoAljaGFyICpib290X29yZGVyX2NvcHk7Cj4gQEAgLTE3NiwxMCArMTc2LDIy
IEBAIHN0YXRpYyBpbnQgZGlzdHJvX3JhdWNfcmVhZF9ib290ZmxvdyhzdHJ1Y3QKPiB1ZGV2aWNl
ICpkZXYsIHN0cnVjdCBib290ZmxvdyAqYmZsb3cKPiDCoAlpZiAoIXByaXYpCj4gwqAJCXJldHVy
biBsb2dfbXNnX3JldCgiYnVmIiwgLUVOT01FTSk7Cj4gwqAJcHJpdi0+c2xvdHMgPSBjYWxsb2Mo
MSwgc2l6ZW9mKHN0cnVjdCBkaXN0cm9fcmF1Y19zbG90KSk7Cj4gKwlpZiAoIXByaXYtPnNsb3Rz
KSB7Cj4gKwkJZnJlZShwcml2KTsKPiArCQlyZXR1cm4gbG9nX21zZ19yZXQoImJ1ZiIsIC1FTk9N
RU0pOwo+ICsJfQo+IMKgCj4gwqAJLyogQ29weSBkZWZhdWx0IGJvb3Rfb3JkZXIsIHNvIHdlIGNh
biBsZWF2ZSB0aGUgb3JpZ2luYWwKPiB1bm1vZGlmaWVkICovCj4gwqAJYm9vdF9vcmRlcl9jb3B5
ID0gc3RyZHVwKGRlZmF1bHRfYm9vdF9vcmRlcik7Cj4gKwlpZiAoIWJvb3Rfb3JkZXJfY29weSkg
ewo+ICsJCXJldCA9IGxvZ19tc2dfcmV0KCJidWYiLCAtRU5PTUVNKTsKPiArCQlnb3RvIHJhdWNf
cmVhZF9ib290Zmxvd19lcnI7Cj4gKwl9Cj4gwqAJcGFydGl0aW9ucyA9IHN0cmR1cChDT05GSUdf
Qk9PVE1FVEhfUkFVQ19QQVJUSVRJT05TKTsKPiArCWlmICghcGFydGl0aW9ucykgewo+ICsJCXJl
dCA9IGxvZ19tc2dfcmV0KCJidWYiLCAtRU5PTUVNKTsKPiArCQlnb3RvIHJhdWNfcmVhZF9ib290
Zmxvd19lcnI7Cj4gKwl9Cj4gwqAKPiDCoAlmb3IgKGkgPSAxOwo+IMKgCcKgwqDCoMKgIChwYXJ0
cyA9IHN0cnNlcCgmcGFydGl0aW9ucywgIiAiKSkgJiYKPiBAQCAtMTg5LDEzICsyMDEsMjYgQEAg
c3RhdGljIGludCBkaXN0cm9fcmF1Y19yZWFkX2Jvb3RmbG93KHN0cnVjdAo+IHVkZXZpY2UgKmRl
diwgc3RydWN0IGJvb3RmbG93ICpiZmxvdwo+IMKgCQlzdHJ1Y3QgZGlzdHJvX3JhdWNfc2xvdCAq
Km5ld19zbG90czsKPiDCoAo+IMKgCQlzID0gY2FsbG9jKDEsIHNpemVvZihzdHJ1Y3QgZGlzdHJv
X3JhdWNfc2xvdCkpOwo+ICsJCWlmICghcykgewo+ICsJCQlyZXQgPSBsb2dfbXNnX3JldCgiYnVm
IiwgLUVOT01FTSk7Cj4gKwkJCWdvdG8gcmF1Y19yZWFkX2Jvb3RmbG93X2VycjsKPiArCQl9Cj4g
wqAJCXMtPm5hbWUgPSBzdHJkdXAoc2xvdCk7Cj4gKwkJaWYgKCFzLT5uYW1lKSB7Cj4gKwkJCWZy
ZWUocyk7Cj4gKwkJCXJldCA9IGxvZ19tc2dfcmV0KCJidWYiLCAtRU5PTUVNKTsKPiArCQkJZ290
byByYXVjX3JlYWRfYm9vdGZsb3dfZXJyOwo+ICsJCX0KPiDCoAkJcy0+Ym9vdF9wYXJ0ID0gc2lt
cGxlX3N0cnRvdWwoc3Ryc2VwKCZwYXJ0cywgIiwiKSwKPiBOVUxMLCAxMCk7Cj4gwqAJCXMtPnJv
b3RfcGFydCA9IHNpbXBsZV9zdHJ0b3VsKHN0cnNlcCgmcGFydHMsICIsIiksCj4gTlVMTCwgMTAp
Owo+IMKgCQluZXdfc2xvdHMgPSByZWFsbG9jKHByaXYtPnNsb3RzLCAoaSArIDEpICoKPiDCoAkJ
CQnCoMKgwqAgc2l6ZW9mKHN0cnVjdAo+IGRpc3Ryb19yYXVjX3Nsb3QpKTsKPiAtCQlpZiAoIW5l
d19zbG90cykKPiAtCQkJcmV0dXJuIGxvZ19tc2dfcmV0KCJidWYiLCAtRU5PTUVNKTsKPiArCQlp
ZiAoIW5ld19zbG90cykgewo+ICsJCQlmcmVlKHMtPm5hbWUpOwo+ICsJCQlmcmVlKHMpOwo+ICsJ
CQlyZXQgPSBsb2dfbXNnX3JldCgiYnVmIiwgLUVOT01FTSk7Cj4gKwkJCWdvdG8gcmF1Y19yZWFk
X2Jvb3RmbG93X2VycjsKPiArCQl9Cj4gwqAJCXByaXYtPnNsb3RzID0gbmV3X3Nsb3RzOwo+IMKg
CQlwcml2LT5zbG90c1tpIC0gMV0gPSBzOwo+IMKgCQlwcml2LT5zbG90c1tpXSA9IE5VTEw7Cj4g
QEAgLTIwNCwxNSArMjI5LDE5IEBAIHN0YXRpYyBpbnQgZGlzdHJvX3JhdWNfcmVhZF9ib290Zmxv
dyhzdHJ1Y3QKPiB1ZGV2aWNlICpkZXYsIHN0cnVjdCBib290ZmxvdyAqYmZsb3cKPiDCoAliZmxv
dy0+Ym9vdG1ldGhfcHJpdiA9IHByaXY7Cj4gwqAKPiDCoAlyZXQgPSBkaXN0cm9fcmF1Y19zY2Fu
X3BhcnRzKGJmbG93KTsKPiAtCWlmIChyZXQgPCAwKSB7Cj4gLQkJZGlzdHJvX3JhdWNfcHJpdl9m
cmVlKHByaXYpOwo+IC0JCWZyZWUoYm9vdF9vcmRlcl9jb3B5KTsKPiAtCQlyZXR1cm4gcmV0Owo+
IC0JfQo+ICsJaWYgKHJldCA8IDApCj4gKwkJZ290byByYXVjX3JlYWRfYm9vdGZsb3dfZXJyOwo+
IMKgCj4gwqAJYmZsb3ctPnN0YXRlID0gQk9PVEZMT1dTVF9SRUFEWTsKPiDCoAo+IMKgCXJldHVy
biAwOwo+ICsKPiArcmF1Y19yZWFkX2Jvb3RmbG93X2VycjoKPiArCWRpc3Ryb19yYXVjX3ByaXZf
ZnJlZShwcml2KTsKPiArCWZyZWUoYm9vdF9vcmRlcl9jb3B5KTsKPiArCWZyZWUocGFydGl0aW9u
cyk7Cj4gKwo+ICsJcmV0dXJuIHJldDsKPiDCoH0KPiDCoAo+IMKgc3RhdGljIGludCBkaXN0cm9f
cmF1Y19yZWFkX2ZpbGUoc3RydWN0IHVkZXZpY2UgKmRldiwgc3RydWN0Cj4gYm9vdGZsb3cgKmJm
bG93LAo=
