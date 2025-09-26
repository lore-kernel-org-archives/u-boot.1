Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D8DCAC5B8
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 16:06:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8228838F0;
	Fri, 26 Sep 2025 18:06:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xqJBe3+n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEAD383677; Fri, 26 Sep 2025 16:54:35 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFC09835B9
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 16:54:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b9iYQQtVDKPYNqO5j/+LKZZSDrcL+vgO3BmySG4cPhY5HIbo1CtA66jyH5swRUXLnGMKIRMhwXdvw+iifqjhRAjW2IZcRoqaJ4atY1+xr+4AgbG3u8/l6lLq8hdM55y2El07rrYysXsDDedB0OXMF49oJvIELzWUVj1qHThA7aBv1R9A0Oe0T2Kby1ZeEPxdSk/+G6yUJSjEDrYjn8MgZ2ksW05BhDm9i3obeR3A23ytJAXsBt8ZToW0xOkxn5Vmz+XF40809whnxDUn7dW8wEBUILI5hmsuJhmDXGzdAcHApIezKfsiQezoENA3z6Rh5KImMiZU7iq9myFZsF0/6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aF2Ui9EmKMOLfaYjotwi24zp4kjVZW/06hLbVt7KX+8=;
 b=a4VPtrBY7nzcP2Q6GScWg2jipT2zDiy/7xTiLVUMAVEx0rSCN8HfgBV/JjHLM2flm51HDdwNBNARlgPu9LCZ/CKrM8fjhlpt/uhhSAVNx7eHFZxZyknB8kzF7Ac0nwHwqxJ9d5mMm8I4rOYVuc9rJEJtRX3vujcmC4LupM8hIXC0UWNOvQLNskP0rJAikVppt17Vw/MuWAtQZsr2mA+dgcNyzKgHfBqVn9clHZW4qVZ+6Ws75QOiyHORZkef25TM4GtyhRDr8l0Mgjyx9RK7hS0TyqpOKkaUf6798IHfWvzPTWkbYTkJSmSUt7ZbW/GIOVOT5YGbVLZ7CtRMJzT4pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aF2Ui9EmKMOLfaYjotwi24zp4kjVZW/06hLbVt7KX+8=;
 b=xqJBe3+nmGqvq2rVKLJzOduBBjv38QoVVKZ1SPYf7RsUCJ4aH4Km56syThdUjako0FYeDp4fcipquZpslyuLXSj6XeFX+r1mkYbW/gvH/Aqyq06Iu1RlH6xCEPnMrQfb7QUrLiQTvGs8R9x1wzX4Sy1236k7vsVLL5ilaG3C0tEXo6NkWoirgGL0BF/VNPDruSkIQNfo7tDwAIl/vNxZFk/ceT4EV3ITieK9XJgypihH4H/2VD482TKOs4JlYHbXx+OTjb98d9POKpXJpeM4jD5nPUxaggrqar53wZySYnXnFgSa+GbBxpv90aAvNV83mWqGg4P1MS6vKAIBiepuiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV2PR04MB11141.eurprd04.prod.outlook.com (2603:10a6:150:27c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 14:54:31 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 14:54:31 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 27 Sep 2025 00:06:16 +0800
Subject: [PATCH 03/10] firmware: scmi: smt: Dump more info
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250927-scmi-v1-3-5e9354fb3bff@nxp.com>
References: <20250927-scmi-v1-0-5e9354fb3bff@nxp.com>
In-Reply-To: <20250927-scmi-v1-0-5e9354fb3bff@nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:196::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV2PR04MB11141:EE_
X-MS-Office365-Filtering-Correlation-Id: 56ff7e61-85c3-4149-03d0-08ddfd0c99a2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|19092799006|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnVKb0VweVIxdGxOdE04Q2s4QlhrckN4NUhNK1FUNEpEL1JramlqT00xZUNG?=
 =?utf-8?B?aTJ4STRMeVUxQkV6SW9JOHlyMDR5Z1p6MDdHUFNoNjgyekdJOHR0akdJeXVT?=
 =?utf-8?B?cGdFQ3ljZG1oT0xlTEMzeC9XM3FQMnFGS01VM3ZtblI5U0lkUGg3SUZjRWM0?=
 =?utf-8?B?S24vUHRXd1V5ZEhkQWlRak9TTFJ3K25IZVU0aklaWFBXKzhHc3hpTVVLdFh4?=
 =?utf-8?B?c2Q3NHh1dE43dEhpZ1M3SE0rNjlNRWt5RzB0Q1JmR1VXeWpEWmZvNlBDMTRN?=
 =?utf-8?B?QzQyOWMwdkE0TlpiTWlBQzZId2NOdkRsV1llUkFxOVlsMGxRd0NKUXVndjdr?=
 =?utf-8?B?Wnh3YWlXQnpPSHBGK2hPQUNMQmRvWXJ5enlIcGRiMHphVThMS212UXE2c0tw?=
 =?utf-8?B?QkY3TmRacUMxMG9ob1Y5WkdNYVRkUjRWVUZIdlE0NFhJdVlNT2FISkJTYStw?=
 =?utf-8?B?b3c2YmdHYXdrTm1idTFVbjk0T1YyT2VaZ09JZG40aVpLS2VLeHVNSGMyWDU3?=
 =?utf-8?B?T2h1ckwrRzJNdmUvMDJFcXo1L3dnZHBjb2xaYzlmWGtkQmRUQ2c3clhWclUx?=
 =?utf-8?B?WERTRU5IYzFyVGJUWVVoNWJjMllzS3lVcUl5VjU1OW9rWW8rN3A4WFlOUWU4?=
 =?utf-8?B?YWhvdklWbDREK1RLMjdQbjV4eExsS1BSd0htVmlkcU02UW5IRWMveHNKQmJU?=
 =?utf-8?B?M01NVlBzY3RXaTVjNFFXeVBDQStMT3gzcHZuRkk2V3VrVm9rYk1vKzV5L1Rz?=
 =?utf-8?B?dUxIdzJpUG5JaWtXT21HalRoR1FIcG8vR2FmVTZxRkpTbk1jQkIxUi95YjNs?=
 =?utf-8?B?SHhOaDBaZHVKWTZJMEMxZ3BKWGZ6ZFdaOEhNU2p5L1M4WHpickpQRFY2b0dX?=
 =?utf-8?B?d0Eyazd0bC9waENjZWVXbTFoaUJEMjc2MHZmOG1yaDRiUFVIdlYrUnZyN1BO?=
 =?utf-8?B?TGViY1J5d2ZBN3BEallFSG5VRmQyK0d5ZTdjdEtlaUVJZjlJSlB6MjFTR3kw?=
 =?utf-8?B?bndiS0trWXFROWQxQkpxRXVDdDBQS1NjQWNQeEIvanZqNm5udDM5MTRHa01M?=
 =?utf-8?B?Vlprb3d1YVdtbUtEU0dTajFxaENOcW8zZEVUZEJ3Um5Dc2NXQW5NZnQvRTZ0?=
 =?utf-8?B?QzVqeXc1c21mKytRMUsxbXdTYUxZQ2d6NG14ekNtTW9Oa1NOODdTbUFVTUgv?=
 =?utf-8?B?SmZsUzhaTXBEc3AzOGtSb1ZFcmdzRGU4ODdicktXaXEzK0JwdkxvS1NLVUY4?=
 =?utf-8?B?QWRkaGxaZTZrZ2lrWngrMEZIeldBZlZ4RzNHdGNsdWFJZEtLa1pwaXRLVlBW?=
 =?utf-8?B?RXlvR012c25yNTNTVUhhVStZcHhOTTNncjZhY1l5UzhUamF4UFFKd0N0N0hH?=
 =?utf-8?B?VTFhV3JqNlgwZlNsVlFsWVlGUnNWSWdobEdFWDgrSTV4Q2s0WkFyMzN0MWJV?=
 =?utf-8?B?WDU1cTYwcStmZUxIUlJLMjZOSUJZR0k2Umh4a1U1TWxHWFRyR1g4TUFwRTdB?=
 =?utf-8?B?OFBHdDBiamxYMFRkRlpxaWpqNCtXVG1UdDYzWW9SQ0tWT255K3d5cEExR291?=
 =?utf-8?B?WXRacXRseWVYUFB1MWo0WFhQdG9jTXZMMDZhZU1IY3FicWNmRytTSVo0THdU?=
 =?utf-8?B?R2xIUStnZ0txMWwzUDhFSStFREgxc2J6cHE1ZFJlTjRKSkFHRTE3cmphcGx3?=
 =?utf-8?B?VjdHOFNrMVh2OEFJcmVjTWk5VlNLdUNkcTVBQzRuOFBCb0VyYXJBRmdKSFkw?=
 =?utf-8?B?ZzRRTFdsWk95WlcxVG9rbk92eFA3Q1ZCK3lFYnBrVkxWZk5nMDlCekNhclIv?=
 =?utf-8?B?WHZRbzZwWlg1SUtyUjFwWCtCaHJaaTlXeG1CdWpiOFlQQkRkOHVlMFBFU2JJ?=
 =?utf-8?B?ZGlCWHBlWFZpRnIwbE9ROHVEMnlLZ0gwM3FwbmNUTS9Na2ZpVFlDcVI3M1ps?=
 =?utf-8?B?Z3Fxa2R2NjVsUWUwYm41bnpKcjNYZ2p4NmhYVGsreExYVzhyZGRmNTQ2NWIz?=
 =?utf-8?B?NnZ3RFExVWJRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(19092799006)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVhYcjBDK1I3RFFaNXNMR051bWJ2WmdhWFZ2Z2x6ZUdXUnc2b0NKVmhLZ3RD?=
 =?utf-8?B?Q0Fqcmc3bk1QeVhRNmxhMWNTTE9HVUhWdVhaZ203WSs0Z0s0ZzY4RXpuend5?=
 =?utf-8?B?akpYTEpFM3FvU05rbmY4WkYrOU91TGNHYzNlWWV5STJEUG1mUldoYlZBNm53?=
 =?utf-8?B?TFltTkgwUGtGREVJYkJkdkFnaExTTlNYUDRqclVzT3Vod0NPbjhaVHdia1cx?=
 =?utf-8?B?ZlpQQVN6eUk3RXdwWnpEVjJjOWdCUE5SN1lBMENUR2NOS0tVeFM1dkRzQ3Fv?=
 =?utf-8?B?eC9STXpsL3FFZTZKT1QveUcxek5OekFmMVRGUXJ3WWpnL1Z4WXNlK3M5Y2pS?=
 =?utf-8?B?UDRJTUhwbHJSS2xia2RyeVo3QWt3MHJPcDFDYUtTWjhGR2RLNjRUSUNpOTB0?=
 =?utf-8?B?RnFjenNCd0NvbzZZdTFtYURRc1dOUmwxRktoaCtPZFdZY3NUd1RJR2lNZlND?=
 =?utf-8?B?cVNWWkV6d2VmYTUybXhHVzBzNGJXQlVWQUtQT1lEOWphWmJwL1VzLzFQZUJK?=
 =?utf-8?B?b242S0ZPSmtjazlVNHpiOGFVYVo3QWpKWkdmUjBweHZPOGczUEJxWUZMVURW?=
 =?utf-8?B?UGNKYkh2VW12NEIvVlJsUnpVZWJLb3lwSWFxS2lSRUYwRGJLcDBxOHh3ODJS?=
 =?utf-8?B?NXVKamhURHgvSnZaYzYyYmpxSFVKS0YyMTFnOVBwNXRWcmE2UGZzcUo4cXpQ?=
 =?utf-8?B?UEYwbDAwQkZObHp6Q0xEMFBJV242RVVkTDNlenF1ZFl1dkFDajZNZEZVbmRS?=
 =?utf-8?B?ZjJBY2tmTHVYVVRFT0tqTXFrTm56Qm1lNHdYNHpvQlZ3Y001Q3ErSnBnVklH?=
 =?utf-8?B?VStlMlFvZlA5TTBIODRJc2E3Wm9MRUVLbXJBVkVnSGZ0YkkrWVN5dEM0TTJR?=
 =?utf-8?B?bEYwQTd4K0pOaC8wZHdPWTRRczhIYzN3cjYvNEZTemZIRVFLMEVOOEE2aE5t?=
 =?utf-8?B?YTN4eVBrSGFwdHVxbEdwQ0NucGlFS0pYN3ZKRTZmeWR0a2hwK2p0RjcxZ0hT?=
 =?utf-8?B?bWk1QzZJeGFxTno2TGlEN3VyU0YrL0VzR2ZMWENNMENVOTM5MzR4RXZNMUJR?=
 =?utf-8?B?MHd1KzhHRjVQTUJzT0ZEcnJZRGFXRjcyWWZOUGpxMVA5d1hUUW9aZXV0Y1Br?=
 =?utf-8?B?SXRrZ3JaZUIxMkc0K2FKUlJyeHovTXpCaFNsSVhTSG1ZcUdIVzZMZXN6VDEr?=
 =?utf-8?B?ZU5YSHI0dm9iYXdXZUc3V2s3UU1BRVBPa04vSFdXM0FISkpHUUo0bTcwNU5F?=
 =?utf-8?B?cnJaMEs0cnNYZlBBYlgvcERCNDJIZkdpYU1HaS9ocngvSTZXZ09YRXByMzVQ?=
 =?utf-8?B?RGZTWm5FK2g3d01CMnk0cFpTSklrODFOcUZMSFI1SUcwdVVYalVxY1V6OFBs?=
 =?utf-8?B?WSsrZEJNQmRGNWpwYTBnTnlBNWs3SVRtZ2xXeEt3TnNrcE1LcDlaRE1xM2xI?=
 =?utf-8?B?T0hmQ0tRcXNsSndVRUpXSFdYY0VyT3E3dkprcUxQNzNZR0FhejVFUWtzMUx3?=
 =?utf-8?B?VldBTHZHZmYzYllRNVhkSWhsc0UzU1JnZVdVTjl4YUhoMkFyWWk4WHB0UStH?=
 =?utf-8?B?Yjl3NEoxNDZBOVVGZ29tNUo4a0dGVG1ZZm9iMUZGckJYMmNOc29DaU02UVdp?=
 =?utf-8?B?QlcyZXZRK3JXZlY0TGlWOE51Y3BPY0gvVzZKUVc3U01sVnRaN0NWN1c4UGJG?=
 =?utf-8?B?dmJpeVVqUXZNTDVSTjB5eDA0SGxDSmFHWGEvZlFDUkdDZWhCVU9laUgyazVa?=
 =?utf-8?B?WnlhbURxSVJaRThKdFJCNno3bUZWNTI5M1I5ckN1elpnNXVwT0FiVTJaSXYw?=
 =?utf-8?B?RmIybjlMVTczM2htVEFsamM1Tk5YWmNOczBCbzZpeVBUM2hOQnlBWnY1dWMv?=
 =?utf-8?B?ZnpOSHBaN2JKd3JML1FOQVlhZGtDTzhOQzlRRGxYNXpucmFDS3JyWW9sZkx3?=
 =?utf-8?B?MGRJWWJhK2dKNGxLeFZ6dUVEMzZpRUE5aGhZMVZCL3gwc1VzQ1VhMXBjckpa?=
 =?utf-8?B?dVhSS0cxNS9HR3pRNGlWK1I3TUN3b3JhK3l3WDhaejZNVGttWUI4b3lNVlFY?=
 =?utf-8?B?NndZd1hTdURyWDQ2ejJITXZjQVdMTGRjZkgxclk3bjQxTlh5bWRhL0JkM3dE?=
 =?utf-8?Q?usijiDLQEwiHIQQYmA9oS8zXe?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ff7e61-85c3-4149-03d0-08ddfd0c99a2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 14:54:31.7679 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iSoUnKE8/lmvBalQy/10/nBPTdCM85S2FzaG0q2/dGt665jAZKxf5gxb9nJ+JLebetjh9orQAbMkh7bucEzG2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11141
X-Mailman-Approved-At: Fri, 26 Sep 2025 18:06:25 +0200
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

From: Peng Fan <peng.fan@nxp.com>

"Buffer too small" is too vague, dump more info to make it easier to
debug issues.
Change dev_dbg to dev_err when buffer is too small.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/scmi/smt.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/scmi/smt.c b/drivers/firmware/scmi/smt.c
index 8bc721c664794e6629c50939707a756786353f9b..5eb78387344dd874fe3cc3fea38a0586ae149ef4 100644
--- a/drivers/firmware/scmi/smt.c
+++ b/drivers/firmware/scmi/smt.c
@@ -92,7 +92,9 @@ int scmi_write_msg_to_smt(struct udevice *dev, struct scmi_smt *smt,
 
 	if (smt->size < (sizeof(*hdr) + msg->in_msg_sz) ||
 	    smt->size < (sizeof(*hdr) + msg->out_msg_sz)) {
-		dev_dbg(dev, "Buffer too small\n");
+		dev_err(dev,
+			"Buffer write too small: mst->size:%zu, in_msg_sz:%zu, out_msg_sz:%zu\n",
+			smt->size, msg->in_msg_sz, msg->out_msg_sz);
 		return -ETOOSMALL;
 	}
 
@@ -130,7 +132,8 @@ int scmi_read_resp_from_smt(struct udevice *dev, struct scmi_smt *smt,
 	}
 
 	if (ioread32(&hdr->length) > msg->out_msg_sz + sizeof(hdr->msg_header)) {
-		dev_err(dev, "Buffer too small\n");
+		dev_err(dev, "Buffer too small: hdr->length:%u, out_msg_sz:%zu\n",
+			ioread32(&hdr->length), msg->out_msg_sz);
 		return -ETOOSMALL;
 	}
 
@@ -167,7 +170,8 @@ int scmi_msg_to_smt_msg(struct udevice *dev, struct scmi_smt *smt,
 
 	if (smt->size < (sizeof(*hdr) + msg->in_msg_sz) ||
 	    smt->size < (sizeof(*hdr) + msg->out_msg_sz)) {
-		dev_dbg(dev, "Buffer too small\n");
+		dev_err(dev, "Buffer too small: mst->size:%zu, in_msg_sz:%zu, out_msg_sz:%zu\n",
+			smt->size, msg->in_msg_sz, msg->out_msg_sz);
 		return -ETOOSMALL;
 	}
 
@@ -193,7 +197,8 @@ int scmi_msg_from_smt_msg(struct udevice *dev, struct scmi_smt *smt,
 	struct scmi_smt_msg_header *hdr = (void *)smt->buf;
 
 	if (buf_size > msg->out_msg_sz + sizeof(hdr->msg_header)) {
-		dev_err(dev, "Buffer too small\n");
+		dev_err(dev, "Buffer too small: buf_size:%zu, out_msg_sz:%zu\n",
+			buf_size, msg->out_msg_sz);
 		return -ETOOSMALL;
 	}
 

-- 
2.35.3

