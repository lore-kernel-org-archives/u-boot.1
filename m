Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D91EC36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 06:42:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDB598290A;
	Wed,  9 Apr 2025 08:42:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HMagOVcj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F8308290A; Wed,  9 Apr 2025 08:42:20 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0FD8820FE
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 08:42:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cYhLjchK7+QqAOJsxjnoHuqq+ypMOzf0Chs56t9biE51QNnRmmootMmg23JneigYYidc/em12H64S4V5VF3L114NNU33JhOh4yIPYuyp0IemY/2J9TUhRk57IPMNkJU/fmZFcXiibUpZqHlbTFXCnMyCR2JygKIFIn9Ot9lOOxvPy9asWUwXjaB/3cDFifHz3HpiS92oo2WGNJBO+jTo5famSd9WrR8h2pMSFjYJv8jq7TfjBMd5PoQ+8rtkqC4KG1HmsTo/d+EMfJUXGi59bJx+kDDttVJp6iIn29sWc/qqoY1vjJAQ1e26vhdGo6S32Flo5n1wreECAGQ6VzvA5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=By4XXKEN/vd0mxqokxNpXg2/F1SlTfh57a/RS4tNS6o=;
 b=IaOWhDu41TTrbuw9FGNuynD4NiwQdH6swkBfGYqVt2qk3vXIVfUjzsKHVXvYVZsUMKGOFAJY18UOurhiTecwwgOnRzLGnj3qyqK12xG0kFzh0yjQZ8UVjRCveKe18zjlkhcNn00wVwSe2WWsyEZbm+5yCn1UrozNyvVHOo0JccjZga5BAkn52bkWmNX3tbUW3unZ2c+AvY4Zby/9pOL/hK17D9zx+6VN0kpAwcVwzkeJKebklrOK10bRzNAn4iuvUawzJC2p6d6mi3zAq9r606xweRUUZcjA4kIEAsN3msdCPnz5GisBlnBgs3Dw9crpGFOYA9SzEt6oWIxNa7N4mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=By4XXKEN/vd0mxqokxNpXg2/F1SlTfh57a/RS4tNS6o=;
 b=HMagOVcjB9vzobpy/VKQVMD9dSfFnEDy5LWa3CCsFOc/NEJtosi8SUsbbAuAgTQR3j3GDRA+6jY/f0AyFoTODCkX7msVQA86wisFJMzqbla1k5JYf15I+6vwQXZ7sjRKM6gi+UBx9yO0y/gojW0dJP5IzsM335Zmm5fCVjq0CGbn7HOkCWOb+iNgGe0vwoDlnwSlhYlaWDypfvjH6nrSSV3pdmarR0/+SQQbigMXBHwy/6h+FnpbHlCUl/IcNO2qJlvmz2LO2sdOf9MBGsPFLAP9grUvFsTOj6FYzbta0HnNQHhJN56ZYiGqVmaAU2Gge6MV08WeQ1yuUivBcNDYlA==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA3PR04MB11154.eurprd04.prod.outlook.com (2603:10a6:102:4b2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Wed, 9 Apr
 2025 06:42:15 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8606.029; Wed, 9 Apr 2025
 06:42:15 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marex@denx.de>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Alice Guo <alice.guo@nxp.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Tom
 Rini <trini@konsulko.com>
Subject: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtFWFRdIFtQQVRDSF0gcG93ZXI6IHJlZ3VsYXRv?=
 =?utf-8?B?cjogc2NtaTogTW92ZSByZWd1bGF0b3Igc3Vibm9kZSBoYWNrIHRvIHNjbWlf?=
 =?utf-8?Q?regulator?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbRVhUXSBbUEFUQ0hdIHBvd2VyOiByZWd1bGF0b3I6IHNjbWk6?=
 =?utf-8?B?IE1vdmUgcmVndWxhdG9yIHN1Ym5vZGUgaGFjayB0byBzY21pX3JlZ3VsYXRv?=
 =?utf-8?Q?r?=
Thread-Index: AQHbmswHRR63eDdDBEe47H96cEgkmbOR2HgAgAhalgCAAMoxAA==
Date: Wed, 9 Apr 2025 06:42:14 +0000
Message-ID: <PAXPR04MB96443BD51F4B7CE32A39ED54E2B42@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250322014444.174796-1-marex@denx.de>
 <PAXPR04MB96441F643A1FCC464C25CDA2E2AE2@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <4db49cb4-bb80-4aa8-958b-a5b14f0d22d4@denx.de>
In-Reply-To: <4db49cb4-bb80-4aa8-958b-a5b14f0d22d4@denx.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|PA3PR04MB11154:EE_
x-ms-office365-filtering-correlation-id: c5509b8b-587d-450e-c796-08dd7731aa45
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Mkx0TkhvMnFIS2xYU0xwcmRESi9uMUsrbitwZjdKcHZObkNLTWU5cGFNWDM3?=
 =?utf-8?B?RXpLalpSZDdTMzlxY3lCOHZlODA0OFRWaE5wTmVkWTllZ1V4Q0JmcVpYWlJQ?=
 =?utf-8?B?TTc5S2NjK01Yby9RNkhLN2o2Z2k2cjVRWC8vb1VRTWRwTmRXOEZzbk9wV2Rq?=
 =?utf-8?B?dGY4dGxjdXN6Mmg0d3I2cjdwbVNlb2Q5eEZNSzJhaEpBUHhKZjhNbWdzejd5?=
 =?utf-8?B?dVdCSjRVMWJKY2JXMThvdFlHWlNjSjNRdkJINVhPUWFtMmJtMWxBNXBVVWNm?=
 =?utf-8?B?R0xuMnYxMUJ2UTFrTElwbVFXWjc1M09zcWdkcXB6QWMvNkVmclIzVmNleitP?=
 =?utf-8?B?VnhuZFZCMzFxNWxFa1dVcXFlYmwyWEtzL3Zzb1J4U0lFR0hKNWVUNGNXNnR5?=
 =?utf-8?B?NS8zM3p2S1QwQWFaRG1meWdDQWUyUFdyVmVJMVlDMUpZKy80R0xlQlpSOWU1?=
 =?utf-8?B?NUFTa3JRM3Qzb2Q3OElGbHN3dWZPdmR4SzgwUkdOYkladVhFSjZXY1hVUzZo?=
 =?utf-8?B?RVVjZ0Z4SHYxNmtLS1l3dFZFZ0REb0l2aFNYTHlXbEp2eXk4aEJZNUxobVVn?=
 =?utf-8?B?Q21LQnByNmFJQ21YSDE4RUFPL09IQnNpc2xvT0hlZEhkTHA1ZlJJQ0xBaW1Y?=
 =?utf-8?B?ZmdFa05PWnU3Y0VpV1R6bVhZcWF1VnhDK3NhZmJwb0h3Wmh4NXdxR2ZHcVJE?=
 =?utf-8?B?U2VYWlBzVFRkVTUrL25YL0tTQS95L2RGelBSTkVPdlNGU201b0tpOEg0UHox?=
 =?utf-8?B?M0UvaDYzdlI4a1d3VW5sL2R0cE91ZHF3NzUyL2hvNy9VVW84ZjlEWTlFMUJ6?=
 =?utf-8?B?Vk5lYk1JRWFpeTZUL2JMc1dqSUUyamVQczlTTENmREppRUNNNkdNaC96MDlJ?=
 =?utf-8?B?V3lIcFJRT21pN0dBSzdQYWlrWHNtN3lma0lES2pzb1QzMytTRnU3b0dqMllV?=
 =?utf-8?B?UjVoS1Y1eGRKMHVSTnRWRUhVV1BtejUyY21xWjdrNlM5NHV6YjlDbGZSVHh4?=
 =?utf-8?B?L05tcHZENWJhMVhlZ1RxenF5SHEvckRrZGxuSjZJeHVJdGliTlZ0K1lPdXJa?=
 =?utf-8?B?Qm4vQzRpS3ZIYTdIbUdQRUhncldrM0NTaGdMQ3hvczhxOVFzQUx3QzJWMEk3?=
 =?utf-8?B?VzNia3p2SUl2TWtkTG5nOEt2b3Q0ZTNEQWdmZmdRb2tjWnNsSVdsZ3hKaldJ?=
 =?utf-8?B?VGFsdHZsQXZhZEhOWkQxUFJvbkVxcEhFcTBZYkkvZ1AxQ0lpMUNFMFZPUVh6?=
 =?utf-8?B?QWtFRWxyZUl3c2hrVlgwV1dWd2t4SEx0SHdzOWQ0WlJ0NW5KZnBYcEt5aDIy?=
 =?utf-8?B?QmVSbWlJTU1GaTl3dHJabDFORExVM0VhYUc1TmtrQmViTWVCRS82UFl0SU9y?=
 =?utf-8?B?eTdJMXpwL3JuVGJreFArdVBZWlEyYUEwUk1vT0ZyNFc3TlEzM1RKSWlBdkcx?=
 =?utf-8?B?MHhVWGhTT2RFMnlHUDJlckVTMnh6bE1kNFhzZFNtQTVUS0RjakZtMVFQMzY2?=
 =?utf-8?B?bVIyL2dkRUF4NnZQSVJNdGhzSUpCTlo3U3VIc2c5bzcxZUFVZWFoQm9jNXhp?=
 =?utf-8?B?aVBEVjdkejAvL25YM0MrMG5icm1nMDRhcFo2U0VGV09jL1JldlNmZHh4aGxI?=
 =?utf-8?B?NUlyNzJrdWhXbC8rcjFtVkhtcndYZzc5c3IzUGo0cVFacERwYjczV3dLb0RR?=
 =?utf-8?B?b21KZ3M0OGhjclFmVEpITm1LMWJpUCtNbnNaSTR4bUVSVS96NDZwb0FhRU5L?=
 =?utf-8?B?VkNGdHVrWGJCZS9BUGpuUnFmeU5vMXlLVVZWMTViUmFrTzJzMG5NMFowWFc4?=
 =?utf-8?B?VXJUTmMzN3FUUXNhd0kxcStDL014S0pHRzhpR2pHcTBPdVFnZW05aVRNa1JO?=
 =?utf-8?B?YXpZTmtzMEFPRnR0Vzd2eXQzL1h5UXZqTHBwVllBcDgzRnE2bmJDWHduUUJ4?=
 =?utf-8?B?Z0t6ZTVxNXBhWGhYTXREbHB4ckNHZDdNRVo2VXRReCtuNE1qT1IyNkRkYUIv?=
 =?utf-8?Q?MWlCEqe+R7+KXsP+ZO4tzkz3zS3oJ4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aW1mY29hQVpXUnpoWlNVR2pkWjF5bWg3T0lHcDBReUwvc0oxZElyUVdHQzcw?=
 =?utf-8?B?Q2l3Y3lpbTJ1Yk9rVXMrWFZSNDhLMlFSQVhVa2V6TUE3MDJNNFV5bm1VM0cy?=
 =?utf-8?B?dk9vUHhpdXgrSU1ZOU9ZczM5UkRqMkpCK2dQL2pnbmlKenF2Q3hpb09BclZu?=
 =?utf-8?B?bUxyZmhzZnUzSncvaU9MZDJSa2Z4OWY1QWd6YWVYRHBvc001b2JlM0t5ZmdX?=
 =?utf-8?B?SW50UjVHWWRHZHV2L2I0VmJFVGNsNG81c2w0VU51aXdtSklhcU9BUjdjeWdh?=
 =?utf-8?B?WWs1TFE3Sm5Vb0VhN3ZpMkJ3T0RYbGJPOUJGb1VrazRjckRuS3FPNW1iaHhp?=
 =?utf-8?B?ZHNhWmQvQTFEUy9YS3h4VlBSb25OYzlBQ3haSGhBYXFxS3N3NUVGL3RWd0hU?=
 =?utf-8?B?ZUdQdk42STdkR08wMGIrL1Z6OE9MZUFKdFlKNWVlNGQrbmpYaCtQMWk1Q1FD?=
 =?utf-8?B?cDl3MmhvZ25JUnBhNFVjMWJEdW11K1VtWnI2VW5UaGxjbEcvS01nQ1JjVkhR?=
 =?utf-8?B?OVZHVXpZRG9YMGxyVDZDUk1CSUN4YkRudkdZUmt6NU5zdFVQSk51WmFBNSsr?=
 =?utf-8?B?YWJUYlRFSUVQUk9YemU2WDl6bkhZNTJmUjcwWTcrL2VrQTNNU3IvQzZjQ296?=
 =?utf-8?B?alZ1YlVVMVlTMEFVMkx3L3V5eU9CdmI0STBKdmNVY3FMZzVNQU9ud3VBUmhn?=
 =?utf-8?B?Zm1hSDRWbzhDaU5PQjdxdHY0YWRVdjNFK1VEMDhDVHdGeG03bkIyR0NtT09M?=
 =?utf-8?B?V3p5Z2FBNFI3ZW9VaytJN0VHdnV3Z1JrUTZBLzV1MGRPQ0w1Wjk3SHlpa2hZ?=
 =?utf-8?B?ODdHaHdFMlpFOGhVQUVNVXRTMWQ0VVFCUFRDL1BFVkh4UWJuTU4vYXpZbkw5?=
 =?utf-8?B?MWk2QW1ZUXFBVFNCT1lIVHhYbE1yZVN0YjdOL3YvRnJ1TkZOVlkvOWwwcU5q?=
 =?utf-8?B?YXp0aER3YVJzbzkvaFQ3NnRuVnI2bjJXTzZWa0pPWk9PWUtTNmVIMVkrdUFw?=
 =?utf-8?B?OGpwN0Noa2FSS2JSNXFKSW14cWhiSmxDOURyN3FaMFJOSmQ0WkhsbzZQem1u?=
 =?utf-8?B?b0JMWWlqVHNNVnVkT0daQ0c5aXBFZ3J6L0JEQStuV25zSExQNFVIUDBuSEJj?=
 =?utf-8?B?Y2ZCd2FDTGhiY3owYTZwQ2lmNEdLZVRPdDlQN2Y4MkJQaXhtZVRFbmw1RlFm?=
 =?utf-8?B?WTVNVlplNUc4Zy9uWUNQbEhmK0QzVHEwVE5jRkhEMmRIUitCKzZEb1FTRnJo?=
 =?utf-8?B?TGEzaldGalplTFNKTDFERHZteWd5ZVVMdDJaeTF0SEw4Q3BiKzdZeFFaSUpV?=
 =?utf-8?B?Sk56SDdEc0ZoZnZKL294SmM1eVp6QUpLdWRTSW05NldNWE1sTFc4TUhVeEN4?=
 =?utf-8?B?c0lyZnUyMWFKZ09EV1ZJZzRVMkt2d0RQU04rT3NDTEJkSDNkdGFaQ0RyamZK?=
 =?utf-8?B?TEhSTGtZYzV4U2lVcDVvbXh1NTVvWkcyczhnY0NRYWU2eTI5Vklqc2ZKcFZO?=
 =?utf-8?B?WDlvQmNlZndtaUZjcnlTeC84S0UzL2QzK0pXZ0tuSENNdzh4ZWxMbXNNUFoy?=
 =?utf-8?B?cWs4WGo5RWp5aWVEdkc5VXcvbU9ScWV1K3diTWF2ME1mNG9rSFBUN1djc0lW?=
 =?utf-8?B?V3Y5Z1dIdkFNbWdkVmZuUXlGTHNoSDhtckxCeVArQ0QyMEJOWFc4WVR5NUtB?=
 =?utf-8?B?WFRpa2dLRXZBRkluOEFQY1RVa2xqZTFadlR5MnlLM2Iyc3h6V0dHaS9wU3My?=
 =?utf-8?B?RGlSWG56ckZOclNoVUJHUG5uR2p1ZUV3dzlqTVZUUyt4MUdUZng5RnlnS1ZR?=
 =?utf-8?B?ak1Fd2pFOHBGdDNPbGl5bG44dzAyODk1aGVNSTVWcDZqOHRHZW1hNXYyRlU5?=
 =?utf-8?B?Wk5xRW5wcTI0enU3d0VzdjNmZG5Bb3ZMb3J6c1h1UU1UVEpCR3k2cnJSalFB?=
 =?utf-8?B?b2k4RGRiREpQdjFmb1hROUxwbnIzSVZYS09HbGkrMzIrZkNVN3RuR0hQQ0dU?=
 =?utf-8?B?TVhTVlZnNWdzQndPOUMrSW8wTy9Ca01Ib3IxMU9yQXRuL0FCZEM0dENJOWJr?=
 =?utf-8?B?YTBYMG5vTGE0M3pIQUlidnRNd2tpZ3FuTi8yK2tBUDlDZ2JweDZlZVhCSzZ6?=
 =?utf-8?Q?2M5s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5509b8b-587d-450e-c796-08dd7731aa45
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2025 06:42:14.9803 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HeaEvjL35jbs+GQZDZergOmpHbkKSdlfy9vYh1sl1x/mvFZpGJgaI39960CooS2B/P6org6LwTYrlnO2m+MVJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11154
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogTWFyZWsgVmFzdXQgPG1hcmV4
QGRlbnguZGU+DQo+IOWPkemAgeaXtumXtDogMjAyNeW5tDTmnIg55pelIDI6MzENCj4g5pS25Lu2
5Lq6OiBBbGljZSBHdW8gKE9TUykgPGFsaWNlLmd1b0Bvc3MubnhwLmNvbT47IHUtYm9vdEBsaXN0
cy5kZW54LmRlDQo+IOaKhOmAgTogQWxpY2UgR3VvIDxhbGljZS5ndW9AbnhwLmNvbT47IElsaWFz
IEFwYWxvZGltYXMNCj4gPGlsaWFzLmFwYWxvZGltYXNAbGluYXJvLm9yZz47IEphZWhvb24gQ2h1
bmcgPGpoODAuY2h1bmdAc2Ftc3VuZy5jb20+Ow0KPiBUb20gUmluaSA8dHJpbmlAa29uc3Vsa28u
Y29tPg0KPiDkuLvpopg6IFJlOiDlm57lpI06IFtFWFRdIFtQQVRDSF0gcG93ZXI6IHJlZ3VsYXRv
cjogc2NtaTogTW92ZSByZWd1bGF0b3INCj4gc3Vibm9kZSBoYWNrIHRvIHNjbWlfcmVndWxhdG9y
DQo+IA0KPiBPbiA0LzMvMjUgMTI6NTYgUE0sIEFsaWNlIEd1byAoT1NTKSB3cm90ZToNCj4gPj4g
LS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiA+PiDlj5Hku7bkuro6IE1hcmVrIFZhc3V0IDxtYXJl
eEBkZW54LmRlPg0KPiA+PiDlj5HpgIHml7bpl7Q6IDIwMjXlubQz5pyIMjLml6UgOTo0NQ0KPiA+
PiDmlLbku7bkuro6IHUtYm9vdEBsaXN0cy5kZW54LmRlDQo+ID4+IOaKhOmAgTogTWFyZWsgVmFz
dXQgPG1hcmV4QGRlbnguZGU+OyBBbGljZSBHdW8gPGFsaWNlLmd1b0BueHAuY29tPjsNCj4gSWxp
YXMNCj4gPj4gQXBhbG9kaW1hcyA8aWxpYXMuYXBhbG9kaW1hc0BsaW5hcm8ub3JnPjsgSmFlaG9v
biBDaHVuZw0KPiA+PiA8amg4MC5jaHVuZ0BzYW1zdW5nLmNvbT47IFRvbSBSaW5pIDx0cmluaUBr
b25zdWxrby5jb20+DQo+ID4+IOS4u+mimDogW0VYVF0gW1BBVENIXSBwb3dlcjogcmVndWxhdG9y
OiBzY21pOiBNb3ZlIHJlZ3VsYXRvciBzdWJub2RlIGhhY2sNCj4gPj4gdG8gc2NtaV9yZWd1bGF0
b3INCj4gPj4NCj4gPj4gQ2F1dGlvbjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNl
IHRha2UgY2FyZSB3aGVuIGNsaWNraW5nDQo+ID4+IGxpbmtzIG9yIG9wZW5pbmcgYXR0YWNobWVu
dHMuIFdoZW4gaW4gZG91YnQsIHJlcG9ydCB0aGUgbWVzc2FnZSB1c2luZw0KPiA+PiB0aGUgJ1Jl
cG9ydCB0aGlzIGVtYWlsJyBidXR0b24NCj4gPj4NCj4gPj4NCj4gPj4gVGhlIGN1cnJlbnQgY29k
ZSBhdHRlbXB0cyB0byBiaW5kIHNjbWlfdm9sdGFnZV9kb21haW4gdG8gcmVndWxhdG9yDQo+ID4+
IHN1Ym5vZGUgb2YgdGhlIFNDTUkgcHJvdG9jb2wgbm9kZSwgc28gc2NtaV92b2x0YWdlX2RvbWFp
biBjYW4gdGhlbg0KPiA+PiBiaW5kIHJlZ3VsYXRvcnMgZGlyZWN0bHkgdG8gc3Vibm9kZXMgb2Yg
aXRzIG5vZGUuIFRoaXMga2luZCBvZg0KPiA+PiBiZWhhdmlvciBzaG91bGQgbm90IGJlIGluIGNv
cmUgY29kZSwgbW92ZSBpdCBpbnRvIHNjbWlfdm9sdGFnZV9kb21haW4NCj4gPj4gZHJpdmVyIGNv
ZGUuIExldCB0aGUgZHJpdmVyIGRlc2NlbmQgaW50byByZWd1bGF0b3Igbm9kZSBhbmQgYmluZCBy
ZWd1bGF0b3JzIHRvDQo+IGl0cyBzdWJub2Rlcy4NCj4gPj4NCj4gPj4gRml4ZXM6IDFmMjEzZWU0
ZGJmMiAoImZpcm13YXJlOiBzY21pOiB2b2x0YWdlIHJlZ3VsYXRvciIpDQo+ID4+IFNpZ25lZC1v
ZmYtYnk6IE1hcmVrIFZhc3V0IDxtYXJleEBkZW54LmRlPg0KPiA+PiAtLS0NCj4gPj4gQ2M6IEFs
aWNlIEd1byA8YWxpY2UuZ3VvQG54cC5jb20+DQo+ID4+IENjOiBJbGlhcyBBcGFsb2RpbWFzIDxp
bGlhcy5hcGFsb2RpbWFzQGxpbmFyby5vcmc+DQo+ID4+IENjOiBKYWVob29uIENodW5nIDxqaDgw
LmNodW5nQHNhbXN1bmcuY29tPg0KPiA+PiBDYzogVG9tIFJpbmkgPHRyaW5pQGtvbnN1bGtvLmNv
bT4NCj4gPj4gQ2M6IHUtYm9vdEBsaXN0cy5kZW54LmRlDQo+ID4+IC0tLQ0KPiA+PiAgIGRyaXZl
cnMvZmlybXdhcmUvc2NtaS9zY21pX2FnZW50LXVjbGFzcy5jIHwgOCArLS0tLS0tLQ0KPiA+PiBk
cml2ZXJzL3Bvd2VyL3JlZ3VsYXRvci9zY21pX3JlZ3VsYXRvci5jICB8IDYgKysrKysrDQo+ID4+
ICAgMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+ID4+
DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Zpcm13YXJlL3NjbWkvc2NtaV9hZ2VudC11Y2xh
c3MuYw0KPiA+PiBiL2RyaXZlcnMvZmlybXdhcmUvc2NtaS9zY21pX2FnZW50LXVjbGFzcy5jDQo+
ID4+IGluZGV4IDhjOTA3YzNiMDMyLi5lNmU0M2FlOTM2YSAxMDA2NDQNCj4gPj4gLS0tIGEvZHJp
dmVycy9maXJtd2FyZS9zY21pL3NjbWlfYWdlbnQtdWNsYXNzLmMNCj4gPj4gKysrIGIvZHJpdmVy
cy9maXJtd2FyZS9zY21pL3NjbWlfYWdlbnQtdWNsYXNzLmMNCj4gPj4gQEAgLTQyNywxNCArNDI3
LDggQEAgc3RhdGljIGludCBzY21pX2JpbmRfcHJvdG9jb2xzKHN0cnVjdCB1ZGV2aWNlICpkZXYp
DQo+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gPj4gICAgICAgICAgICAg
ICAgICBjYXNlIFNDTUlfUFJPVE9DT0xfSURfVk9MVEFHRV9ET01BSU46DQo+ID4+ICAgICAgICAg
ICAgICAgICAgICAgICAgICBpZg0KPiAoSVNfRU5BQkxFRChDT05GSUdfRE1fUkVHVUxBVE9SX1ND
TUkpDQo+ID4+ICYmDQo+ID4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICBzY21pX3Byb3Rv
Y29sX2lzX3N1cHBvcnRlZChkZXYsDQo+IHByb3RvY29sX2lkKSkNCj4gPj4gew0KPiA+PiAtICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIG5vZGUgPSBvZm5vZGVfZmluZF9zdWJub2RlKG5v
ZGUsDQo+ID4+ICJyZWd1bGF0b3JzIik7DQo+ID4+IC0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgaWYgKCFvZm5vZGVfdmFsaWQobm9kZSkpIHsNCj4gPj4gLSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAibm8NCj4gcmVndWxhdG9ycw0KPiA+
PiBub2RlXG4iKTsNCj4gPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHJldHVybiAtRU5YSU87DQo+ID4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfQ0K
PiA+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgc2NtaV9wcm90b2NvbF9pc19zdXBwb3J0
ZWQoZGV2LA0KPiA+PiArIHByb3RvY29sX2lkKSkNCj4gPj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgZHJ2ID0NCj4gPj4gRE1fRFJJVkVSX0dFVChzY21pX3ZvbHRhZ2VfZG9tYWlu
KTsNCj4gPj4gLSAgICAgICAgICAgICAgICAgICAgICAgfQ0KPiA+PiAgICAgICAgICAgICAgICAg
ICAgICAgICAgYnJlYWs7DQo+ID4+ICAgICAgICAgICAgICAgICAgZGVmYXVsdDoNCj4gPj4gICAg
ICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9w
b3dlci9yZWd1bGF0b3Ivc2NtaV9yZWd1bGF0b3IuYw0KPiA+PiBiL2RyaXZlcnMvcG93ZXIvcmVn
dWxhdG9yL3NjbWlfcmVndWxhdG9yLmMNCj4gPj4gaW5kZXggOTlmNjUwNmYxNjIuLjI1NTBiMjcy
NDZmIDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL3Bvd2VyL3JlZ3VsYXRvci9zY21pX3JlZ3Vs
YXRvci5jDQo+ID4+ICsrKyBiL2RyaXZlcnMvcG93ZXIvcmVndWxhdG9yL3NjbWlfcmVndWxhdG9y
LmMNCj4gPj4gQEAgLTE3OCw2ICsxNzgsMTIgQEAgc3RhdGljIGludCBzY21pX3JlZ3VsYXRvcl9i
aW5kKHN0cnVjdCB1ZGV2aWNlICpkZXYpDQo+ID4+ICAgICAgICAgIG9mbm9kZSBub2RlOw0KPiA+
PiAgICAgICAgICBpbnQgcmV0Ow0KPiA+Pg0KPiA+PiArICAgICAgIG5vZGUgPSBvZm5vZGVfZmlu
ZF9zdWJub2RlKG5vZGUsICJyZWd1bGF0b3JzIik7DQo+ID4+ICsgICAgICAgaWYgKCFvZm5vZGVf
dmFsaWQobm9kZSkpIHsNCj4gPj4gKyAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAibm8gcmVn
dWxhdG9ycyBub2RlXG4iKTsNCj4gPj4gKyAgICAgICAgICAgICAgIHJldHVybiAtRU5YSU87DQo+
ID4+ICsgICAgICAgfQ0KPiA+PiArDQo+ID4+ICAgICAgICAgIGRydiA9IERNX0RSSVZFUl9HRVQo
c2NtaV9yZWd1bGF0b3IpOw0KPiA+Pg0KPiA+PiAgICAgICAgICBvZm5vZGVfZm9yX2VhY2hfc3Vi
bm9kZShub2RlLCBkZXZfb2Zub2RlKGRldikpIHsNCj4gPj4gLS0NCj4gPj4gMi40Ny4yDQo+ID4N
Cj4gPiBIaSBNYXJlaywNCj4gPg0KPiA+IElzIHRoZXJlIGEgcHJvYmxlbSBpbiB5b3VyIHBhdGNo
PyBTaG91bGQgaXQgYmUgY2hhbmdlZCBsaWtlIHRoaXM6DQo+IFdoYXQga2luZCBvZiBwcm9ibGVt
ID8gQ2FuIHlvdSBwbGVhc2UgZWxhYm9yYXRlID8NCg0KSSB0aGluayB0aGF0IGluIHRoZSBzY21p
X3JlZ3VsYXRvcl9iaW5kKCkgZnVuY3Rpb24sIHRoZSBzZWNvbmQgcGFyYW1ldGVyIHBhc3NlZCBp
bnRvIG9mbm9kZV9mb3JfZWFjaF9zdWJub2RlKCkgc2hvdWxkIGJlIHRoZSBub2RlIG5hbWVkICJy
ZWd1bGF0b3JzIi4NCg0Kc3RhdGljIGludCBzY21pX3JlZ3VsYXRvcl9iaW5kKHN0cnVjdCB1ZGV2
aWNlICpkZXYpDQp7DQoJc3RydWN0IGRyaXZlciAqZHJ2Ow0KCW9mbm9kZSByZWd1bF9ub2RlOw0K
CW9mbm9kZSBub2RlOw0KCWludCByZXQ7DQoNCglyZWd1bF9ub2RlID0gb2Zub2RlX2ZpbmRfc3Vi
bm9kZShkZXZfb2Zub2RlKGRldiksICJyZWd1bGF0b3JzIik7DQoJaWYgKCFvZm5vZGVfdmFsaWQo
cmVndWxfbm9kZSkpIHsNCgkJZGV2X2VycihkZXYsICJubyByZWd1bGF0b3JzIG5vZGVcbiIpOw0K
CQlyZXR1cm4gLUVOWElPOw0KCX0NCg0KCWRydiA9IERNX0RSSVZFUl9HRVQoc2NtaV9yZWd1bGF0
b3IpOw0KDQoJb2Zub2RlX2Zvcl9lYWNoX3N1Ym5vZGUobm9kZSwgcmVndWxfbm9kZSkgew0KCQly
ZXQgPSBkZXZpY2VfYmluZChkZXYsIGRydiwgb2Zub2RlX2dldF9uYW1lKG5vZGUpLA0KCQkJCSAg
TlVMTCwgbm9kZSwgTlVMTCk7DQoJCWlmIChyZXQpDQoJCQlyZXR1cm4gcmV0Ow0KCX0NCg0KCXJl
dHVybiAwOw0KfQ0KDQpCZXN0IFJlZ2FyZHMsDQpBbGljZSBHdW8NCg0K
