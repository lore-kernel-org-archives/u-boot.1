Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C56EA3C59
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 11:39:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ED2B83DC9;
	Thu,  9 Apr 2026 13:39:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jKc9YRCo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71EA683CF5; Thu,  9 Apr 2026 13:39:49 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83CBF83693
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 13:39:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SDuW6Ubn0CoHEuTXsRJwMOyw7fSoI7ilj1EEtB/oIpTXZjPLEktDdzlzksyzqcPVsIUnmDjEUi17ql2h6VTzR6K9Tw+QROy0fGrrgoqxZpwliXKcPEHgGsd2qmtMsUq9wcpi5DzWf9SL+7jjgP43o5kOBT4kRxMheDeVuuC3YrPlUMRWSQXIX+R6J68Uwe0tjpQbBrMKnVI6rioexzUzk5Q2Ag9g57vE7bMZC86sAaOrEXWLv2VUCPQ+pgSahSYPI29EMSPN2oL9gWQ4eO0/nauMg5bIHY9008k1wmZ0QTw8RVqvlWmr0WsmEuTCY0EY9eILgiI9frc0n9DgXeaxkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/1Om9MTxNhjMmD4vyv6Kt+ocMDWwIST5HHS9XlBjJI=;
 b=cZmvh5DNTOeKDT/AHhzP3KqBteTQV1NT4XRrvgtTCAhPkcZZwMrWT3uKT1iYewY2jAngc41R5cFIHNVAxXDSKMwiKSA1EO6y6Mvg1MTeYeQ9OBtwnjB9yh28jncRUMggIyzRgNF2y0Z5f0KcoDIiyzGW1WY1Se/wmFLmyv8mKJXH1y3J8dk1FNcpJvqFb1Fl1+RTR5VIGyyMP5BKFojGbO/+JyUd1b86G+ruepn1sBuoZgOeyLsPan3ih/ZKcOwm4ag03iCP4SimmRETv6ni7g++H1j2vlNJs2R4PtSIhbpUg6STaTLbS+r55jdR5osicZagy5qxe3WZo4Y1Xcw45g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/1Om9MTxNhjMmD4vyv6Kt+ocMDWwIST5HHS9XlBjJI=;
 b=jKc9YRCo+2TOK9bVYt9JphmoVOWEQzyY9/INLfUccZUVI/wpPpIyu+dtYN1WkGviJoC5feUq1vbfFiFQZvHrEYPJUnXwC43iBVOAKEUSh49lRGGks35xy6Qb2Y5GXSnI3eivxKDXD4GK+/ru6wDImXgfaFKEQ/hp98NaYQR+TdBQf30v7WZ0YacnpcgUpZDULl+uc08RisQGafbtImisglELOkcAaTy0izSG8xmak928ibiklgZBMm7h4rd1NWyXbuOi/sBJyKBwPxb6gFo9c6u9iDvC2dwUevWO/QnYv0WNgyQtM+E01ejuyh9Q+IqyP1ghPZcNigZAXNhzIhtxkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 11:39:45 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Thu, 9 Apr 2026
 11:39:45 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de, trini@konsulko.com, meenakshi.aggarwal@nxp.com,
 andy.tang@nxp.com, chunguang.li_2@nxp.com
Cc: Peng Fan <peng.fan@nxp.com>, ioana.ciornei@nxp.com,
 florinlaurentiu.chiculita@nxp.com, mingkai.hu@nxp.com,
 Zhiqiang.Hou@nxp.com, pramod.kumar_1@nxp.com, camelia.groza@nxp.com,
 priyanka.jain@nxp.com, wasim.khan@nxp.com
Subject: Re: (subset) [PATCH v2 1/4] ls1028ardb: add env variables to assist
 boot
Date: Thu,  9 Apr 2026 20:55:43 +0800
Message-ID: <177573926840.4193161.15530355356520156129.b4-ty@nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260402035132.1706521-1-chunguang.li_2@nxp.com>
References: <20260402035132.1706521-1-chunguang.li_2@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0156.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::26) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBBPR04MB7979:EE_
X-MS-Office365-Filtering-Correlation-Id: c63d4874-8cd2-49dd-4148-08de962cb1e3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|19092799006|1800799024|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: TXcyFZb9uxsmfSuSg5CBD6Ez15ZlvyYLCTvkaMbfdk1VTYiFfkzF1uDLSWjqMCbrCcKVaYPZs3YYuiAtJcqSHZpT2zMCpZzMYXn3+WhlNjN1DTUV5gDshkQfuUbdTSPbNvQ6dEscduXG2/wjOmw+gsC2POkhn50lUFJOOozr9XUwLvTJCUSoeDqf4BYaYCE6WATORy0CdkRkBqfKbg4q4r4HPWbirUR+nzrZZPnavbmFnLKfe3XmivNTvvhlRMwBRZOQ8ZIS29Vw0cE/2OyNmn3snMiFXuGCKxWXOhUMum9l5bCFUwtDFCBm2U035aacvyJQ6XdsfV4yt80+5+GEkkyeTNeyStM56y1PPOOyAmzinC2xxpAtauCcqowk4zfuSif3DPaBnpPYkBC99WiaaZyokxdI1cxwkZGcDIxTWHP6lGF2KRbLZUIYY7hL71lh4Bhu04tWDeG+Rjior6HMSPHRDfR2ZhubsVt99vT2kfU5irtymGDcSlmHOiC9+f2nz7CYHTxDUqj6TUsVOSv64EUiUU/OTbyuv4P/ytqF4F4kqh8Tx01kSCcgrKB3Pme20XigC+CiTANmcMgwBHJfUGxSaOY1ayxfYLykImbgSeBgrHthqJeLkeZE83bAcZoacRMYX2aQgrdjrBAyN19QXGjTnfYFsrsFrKA17RUEUMJg+vE5zNcwdf8XZNPkrmpXym+A7pySYST79yIuGkvv6Xktd5LnGXFHbDb9MeHmkCehISQorqGf2EkO87xVyhFt0LJq7JsMK992wM7kPOT0EvyQ88rLpc5E5W2whWO8m54=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(19092799006)(1800799024)(38350700014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TktrNzdpUUpBS2tQODZWSjNmN3k3c2Vwb0pTVjdESjBQajRTZ1FWS25lS0Ri?=
 =?utf-8?B?enNPYkxsWXg5Tm5YSEd6Q0ZBS2FNdXJicE9DdkU2dGtLUjFFTjIyUjU0aHp2?=
 =?utf-8?B?SXNNNXp4Mm1UQnJJK29hMUFWSlQxd3dNU0lTK2tmK3pWaHVFaXZEdkxmWVVH?=
 =?utf-8?B?R05JZ3dGdjk2YzMwL3Nmc3hnL0F4bGs2VmFiQjc1WjMwNHViMkUwVjhZSzNw?=
 =?utf-8?B?WkRucHdsQTZSdnh2Z0pXK3dLUUhwQlhpVm5NWC9mZ1ZERytDSUJtL2hYT250?=
 =?utf-8?B?ajQraHhTUFVYUjBZOVlybGNiOUlzYzYrTDB3QkhzZ3l4RUNEa0VuQ3hFa1Jy?=
 =?utf-8?B?NjRrU1hqTDY0dzNNcFc1OUlJVXlSRFREcjZkbXZpSWh3cXNsWnFpSUNDTDRH?=
 =?utf-8?B?UnJnWHl0QjBDcUd6c3JVZ2MrdXB0SngvM1U0RnpuZHUxRk0yaDB1M3pvQThL?=
 =?utf-8?B?TS9McURRSDI4OGZnc1B3SmkzYS9uMG40OFl6dWdqVVpicmVTcnRDZzJydlpj?=
 =?utf-8?B?anUwbmFGYmVPZkg5SkRib1JSa0Y5c053M2hQVXFuUWhQYXlGaGo5UTc5aVpD?=
 =?utf-8?B?aWFrd0UyVWJITjNwYU1IQVRaMXRyWHNrUWhaQ1c5MXI2UXBTOCtweWFZdkVC?=
 =?utf-8?B?SWxmdldTSVV2OW9rcWJ6azBkUUhpVkhHWS9jYzU1Q05XQkdMUzBweUlGR2Js?=
 =?utf-8?B?TjhLbTN4bGFJaHRNSDFZcldva1Z3Nk1aelR3NmdzbEM1a2NDbFp4UXNHWFFU?=
 =?utf-8?B?OXJwZG9RSnhnTjhQd0dyZUVlN3ZkWW9mWVYrQUZOT08vR3N0aUxydGVZZTZx?=
 =?utf-8?B?cVhQOWVNUnA4RFpKN0JxUEVTbEFQa1E1Q2JjV2ZybFdIeXkzTWpjMXdlN0xL?=
 =?utf-8?B?clcweVEzYXFURzU5Qk9GODdJeEFJZ0c2WGtrZHhKRlkwODZjRll2ZFR0ODdk?=
 =?utf-8?B?Tk4rRFFSSCtjeG42ZmYyc0ppNW02Z1V4cjk0dHo1amM4ektuU1Qxd09CaFFG?=
 =?utf-8?B?ekZ2bGVDaENaV09URU5KaGQvNkdyS3FYalVDeDBJTG8rMHpnb1dyOE4yTm15?=
 =?utf-8?B?UDN3bUUxTGFJR0hGL1lEQkk5OWJrYm9ldW5MYWZzeVY0a1VKSGxzTnNRQkZq?=
 =?utf-8?B?ek9vbXp3R0dodnpOdHdoakoycDBKSFF0bXhDNVEySHJ3c1N1ZVEwQzd3a1VQ?=
 =?utf-8?B?a0JmblpBVGxWRjdrOExFSC93MTlHRFpBVFp2MmIwS3VjSTlyZ0ExM1VCNkF4?=
 =?utf-8?B?TGdheVQ0YjB5d1RVeDBZVUtBcXJzbGJJNDRFQ2liVHR0aXRQNEx5R1RBc3Ry?=
 =?utf-8?B?L0dFTmFUa09nSXNmZ0tnVVdTQndJTmI0eVJXL0N0aDlYanJtVTVyYVcwbHZS?=
 =?utf-8?B?c2llWlZoM2JnVEF6TUp0bG83MjRyNzJxdk1rNCtmUEdFSmFiU3FlT1JuUzBk?=
 =?utf-8?B?SzloRjNGanlWZ25YRW1kc3haSngrY2xFYUhicmdKTEVncFZyRlRHYU1PN3pa?=
 =?utf-8?B?ekgyUzFLS3AvUkFIK2NNWFdFUFE4azdRRkUyS2J6eHlReVZ1dmNuY3RjWGRx?=
 =?utf-8?B?V3B6Uy82N1Y1ZkNpRDZYZW8wNlNuZU0ydW55bTFKcEw1dDNaWVpQUHR4NFhF?=
 =?utf-8?B?M0s3UFRrd3VkZ21lMDM5THZQd21ReHEzY0lyRW9qby9vaWh3MGtmSmlpV0lF?=
 =?utf-8?B?b2V2VERENUxVOFhudnFQcTUwM1daV0hBUWFIZVJXQjVKODVzdnRzd0g5UlRQ?=
 =?utf-8?B?dm9SSUM3dW1oTk5oR1BISlVwR3dOQzFRNXV3bnBoaXg5MUlYZGNWb1pWR0pF?=
 =?utf-8?B?SjFzdzg4eSsvVXpQWDVMaEV6RkVBL1l6RThIcThKcThrR3kzR1MxS1dHWmxo?=
 =?utf-8?B?bFFOZjBvci9Hc3BkcWxQVXY4amlVQUM4TFh1K09UckwxNktIR3dRWkNhTS80?=
 =?utf-8?B?QVN0YXB5NVJ1UWNCQXJiU1ovNUZjY2dnODhneFp6TVVMM09VSzZMNVUzQmUx?=
 =?utf-8?B?Z1A5WGUzUm5pN2NnQ1IwbFlWdkhOeUVmR3U5Z292YXNKNGlLQllMaGg2Q0pr?=
 =?utf-8?B?RUMwVU1UNVlGQ2VxSUNyRGI1N2J0MWtTYTRIcWUwQVdtOUVvV0FaZXgyZnd5?=
 =?utf-8?B?M0duOVQ4czEzeS8rMktQOVJvWklMLzlRdHN0eFVFQkxwOEtSWXliQ3JsNFNU?=
 =?utf-8?B?aU5DRnBZRENiY3A4bytUNmk5a081S1hjTEp1RWJFeDd2ZXhxclYrUE5ET3Fh?=
 =?utf-8?B?emtWWDRGcnIyRklZcWZMNjgyaVVkT2NiZHV1RGNoZnBwVjRHaHQ0Q1RleHFK?=
 =?utf-8?B?dzhiN1IxMEEvMVhJU1pXZXNQeUN6MFFnNjhRNDI3S09oL1FzTTZ2dz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c63d4874-8cd2-49dd-4148-08de962cb1e3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 11:39:44.9917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IrT5Ytp7wf9+J2/P2ZdNN9kLsbnKpsR4237G60ZS1Us+P7bkk5vdVPEkHXin+zDajo1KO8tMK2Y2CX2qKb5pGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7979
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


On Thu, 02 Apr 2026 11:51:29 +0800, chunguang.li_2@nxp.com wrote:
> From: Chunguang Li <chunguang.li_2@nxp.com>
> 
> 

Applied to fsl-qoriq-for-2026.07-rc1, thanks!

[4/4] lx2160ardb: add env variables to assist boot
      commit: 7cd6c9df4ce1d4d6afab05e351cbd8567c8a13df

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
