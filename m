Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9EBCCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 04:41:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20C2683CB4;
	Fri,  7 Nov 2025 05:40:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZEvlhgVr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A24A283C4B; Fri,  7 Nov 2025 03:13:20 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7116483C40
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 03:13:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hiE3EQawmt8Dga25Jhsxb++4myGl5shDkRYC5wRIlg5ScECYhYC2b5uAH1Cqpz/1Hol3WFuVu1mWIkif/b2jgyHbCX8FkFWAedcm+Iv3xgHflAdMKU48ZyrNk5+YY4idgrvS/3Pgh1WECW94KV6Rpl/NYXy78KR9/B4+U9s3NlNgpaGQ2kydkcL+vmbRsYPGYjKirsurLsERmhwvWAN8FJi84D2/Ev6JwV4pEMl/2xOMV++wb4EMG/ScYypsdMO13bYAzCJNm78C1RxHxrRlFfazLNxPv8x4XrilgL0mJHFLV+bVHcFgkrYJ+mpHY+aca+WYQvOdzDwbwjOKGk0fHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/sLLu25Lir8WUGA26G4LSTZGIExFKcgzdd9iZg3LH7g=;
 b=QUJyHqhux22/kEHS7v2RpRmc9rvc31RyjJVGPZQCWLWHOekqdiJ4ncqO28sQ5VqK6hwvsdatorn2Si/ykTB+v/aShwapbByaqQV1BFfP3xsIsA4ICyGb0oT37X0YtmswwQo7ApTjKRLvf1bu8lc4trPtGrLFtpQzG33F42wCW8w0WIib/LpW5eyurZsKQpD25PrujEgskJIF4gBYAuR69vRIm+D/kilIlRs+oEtTM2dEYE1g/+2+4GlFjsSv6ks/Rd+oDi75xdfZz9hCHTdFeF3XP6n78yo9Y0SW86WoYsjz26AqHHxDwZEcAaEgUd5PgcueSy4rCz+4Z4k/jaCsXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sLLu25Lir8WUGA26G4LSTZGIExFKcgzdd9iZg3LH7g=;
 b=ZEvlhgVrfw1gIROHwNhdjSNfckM/gUJ8CS02PznXqqfTsXbSVU4K/lO1njno38C3qMDm8CeAIsgHX4KaiZ+mCGF5hd8jUIbu+kkElKx8KNK0sz2jj7DqWiOBpBNKzmSfv+v4o1Qu4EIYAD0HsEFv3SzFPuGip6f2AjatF0/4Juwtv/wtXWDqRbhiJdiWGn7EBZsbZAsqnOa2oq3WAS3mtfwrJyh0FTJYG3vNemuDPirJRdGUebA+uqxk3RFih/3RlRbBuuyzMlZj6/Ey9MBCSOlLx1k03z/kGTkLU0cWINS0h9cimst5hRMcsYcqQQRhFe7EVBZ64mjuZRRRHWTBYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB10484.eurprd04.prod.outlook.com (2603:10a6:10:564::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 02:13:16 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 02:13:16 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de,
	Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Peng Fan <peng.fan@nxp.com>, Vinh Nguyen <vinh.nguyen.xz@renesas.com>,
 Alice Guo <alice.guo@nxp.com>, Cristian Marussi <cristian.marussi@arm.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Valentin Caron <valentin.caron@foss.st.com>, Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH v4] firmware: scmi: Add clock v3.2 CONFIG_SET support
Date: Fri,  7 Nov 2025 11:25:31 +0800
Message-ID: <176248589258.804143.11914160299393845601.b4-ty@nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105034308.93340-1-marek.vasut+renesas@mailbox.org>
References: <20251105034308.93340-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU4PR04MB10484:EE_
X-MS-Office365-Filtering-Correlation-Id: eb7831b8-1ddc-4157-8299-08de1da335a0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MURqN2YxcnFnVmxWUnVBZDV0VFpJdEhGVUNjTzh0dzd4N1pXdTAxOWVFMVkx?=
 =?utf-8?B?N1JEMjdSWjVqa3k0aURFUVVZNEZabDUvQ3lKd2FYU25Lc3RkWXQ3R3ludUZI?=
 =?utf-8?B?YkZxOVg4ck5hZE5hQ0pURFhwMVA4Tm00ZUlwYjNCY0JvdForaktsMC9jQ0th?=
 =?utf-8?B?c0h4QzZyNEo2MWJrbGhJMSs2U0ltQTRGWEdrS2ozMFZTVjV3SzV2Y3o5SmlS?=
 =?utf-8?B?UjA2K1dkSEZjazZHdW5XdmlYUjZGVmwrcDF6cnJpWXVtbUpwcWRwUHhXRFNX?=
 =?utf-8?B?VVIyUTFXMkF3dEtoRTlxbG1PaitpNWhhMWdieVN1K04yQllJRjM3OXIzVG0r?=
 =?utf-8?B?RGV6NWNxWlBVU0JXYkNXL3VmajJ1ZVVCYWJ0Q0xhQ05JQkdTZ25pU2ZlQllq?=
 =?utf-8?B?eWNSVVd5RHdBTjFVQXdvcDhTNjhkYjNFLzFMaUs2NjdzZlh4NEJCTy9CS294?=
 =?utf-8?B?d0U4dmM2eDhBdFlveHJWK1pSMHRmZTEyYjUvWEpEbE5JbzY0eURFemw3Zmxz?=
 =?utf-8?B?V2hUbmxNL1BIUVpwdklzYTQ3UTYvU1RRNk5MN095V0VGazU1Z3RvYngxMWxG?=
 =?utf-8?B?WXZZTzJEZ3Rnb2VNUGM2Vk5JczlaeWRORit6Z3ltUDhUaHUxWktYZEEraDZV?=
 =?utf-8?B?WDlNNFVwN2lCaTlyc3FlNUVXSFdnZ2hZSEE0Z3YxYmwwM2NzLzFXb2RMc2ZS?=
 =?utf-8?B?UDRoOFpnRjBWVWsyb3ZuRlVMS2REc1ZyQTFCaHpEK2FIbXhpVG9FSFlvQ0l4?=
 =?utf-8?B?RjZmbW8zZm5pQSsyVy9mN2VzblA2MDMzNjhFRDluZHN3MkdLdzdaS2lxRU56?=
 =?utf-8?B?dkRzODV3TFV3K21ObzR2MXl5anVwaS90R0I4OE5TNkpXWkRvcjVUNXNxZy8v?=
 =?utf-8?B?b0MyWjlzTGxYR0V4bU1jSzB6aGdHWjJKelNSRWRaN1hQNmlqRFBRbUo4Y05o?=
 =?utf-8?B?K0w3dDhEdFFZTTEreFVVSmhNYWlRNXBxTExqNTVnWTl4VnJPSmhvSUVJZk5E?=
 =?utf-8?B?TGVzYjRxKzlYRUllcUIzYk5CRGphZ3IrQUxUSDV5TTFKbzV5WGFMUUswbVZK?=
 =?utf-8?B?a2ltQXBFTFhSa0FHMDcvTUE4Uml2OUprRllTaDBaUXVheHMwTEhsS3djaFEv?=
 =?utf-8?B?cHo0cTNaM0VrbC9CRXZSdXhkMFBRT0lycWxzNXJXRUdwUjF3S3V1QnNKY3dG?=
 =?utf-8?B?Yll3UlpjOVRXM2JLZDF2ZzFBVTFlRm5IdE0rcnU0OWY1VmpBd2hIbmVvU1d3?=
 =?utf-8?B?Q0Z6VGZuWmhSMFBRUWRLSFZmQjZ1UmtnaTJnKy9aaW1kU1MvUFNqT2doUCsv?=
 =?utf-8?B?bVpLdG9yZ3FNR25peS9sRUJxWHIxQjRaWjdxK2psTTFWSGFuSDVlK1hvR2hn?=
 =?utf-8?B?eGx5NVZiMUJkUnJHMzgzWHlFbnd0MWliK3MyRVNlUlM1YytVV3BPV3ZhckVR?=
 =?utf-8?B?QTg0aDhDdDJUc1gwQjJBV1JadFhIOTFFWSthMG10TkN4VWtmVEg3RWExTVV4?=
 =?utf-8?B?MUc4RmJUVlJSeTJoU2ZKOVpLblNiSDFTRy96SDJkU3RTL25RUlQ1NHF2ZTVU?=
 =?utf-8?B?NEovMkc4RTV2YUdwdVZvbjg5aDJ3S1RkdnRVTTA2SkQ3VkxyKzNHbCtNbjly?=
 =?utf-8?B?d0x4Szg1M29XSjljWkZ1ZXZWUlpBZEF0blFIc09UV1VYL0FDMkZWRm1OY1NF?=
 =?utf-8?B?K3c2ZUFHQWNIZTl3dnhCQjRmajNIcHE4dDd1OFY2RTNRTUsyRjAvUUhYNWZ0?=
 =?utf-8?B?NDFvZzY3RWR1ZlBQV094T1IzQmVQNjBOZVZKbkFLMVdYNmZwdlZKR3VoZStT?=
 =?utf-8?B?Q2hTVkUzdFREMEhxUW9qd2k3d3J2b3pNdHJxWWpJbU55OVNsZkVrWVNLSENo?=
 =?utf-8?B?SW16MEYwUEtMaDgwNlRaWTRBNGZ2ekVOazB0RUV3T0Q1Yk5oVUlWdktIc1VN?=
 =?utf-8?B?eWMzZGlSOWJkVHo4QmkrVlNjaDNHVWtocW9keTdLTytRUHZvQ0lEQjJYb3k5?=
 =?utf-8?B?OUp3TmhTeXpZZWZxOHl2SWh3WkxmUU5ZVm9XNUtTMG0wWm9FNEZGempRQ1o3?=
 =?utf-8?Q?E5sdNW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0NyT0lnM2VFME85dEljd3l2L0FiM2ErTlJKQTFFVTRVQkZmU3lkTlYwZHB0?=
 =?utf-8?B?QjdWczdTWktGazFoVVhQam9zNG04NTYrdTRxTHc0eThaUWpyc0tRaFhDaFVW?=
 =?utf-8?B?WFhMQXpkRjdqc1ZOblBmb1VVYnRBVUZQR3FoSXNKWUtLaERFcW1TVDVhbWdG?=
 =?utf-8?B?cXk2WUlaT1hjdjZQelBhNnhCWmVQUTVYRXBLOFB5WHo0THBzSS9JUVZ0VmlY?=
 =?utf-8?B?cStSTmlCYkJ2UGoyWEdGN3Jqb0ZwdTEyYkpId3VOWVExaW9XUDg2bm1ab0FS?=
 =?utf-8?B?OEVpaXdNY1BCUEJCTU4wSVVoOTJCekZIdUdtN29RWGc0M3ljVWZkYXU2RjV5?=
 =?utf-8?B?NE92VVB3elQ1cXRqTmwyemJIc0dlUnh3clNXc3BIVzdyeWlZRU1aVktReDNh?=
 =?utf-8?B?czdoRmZqVXp3d0ZmUUhUazNwbFNncXBibVhGYUlhQytSUGpKeVNTNHNWN2l0?=
 =?utf-8?B?MVFra1ZQenF3S3pSS1hmVHJBMnJZS3l1Y1ZDYkN2RFV1ZmZVcnNVc2diQ0dH?=
 =?utf-8?B?T0Y2RjhuU3EyWUdkcEJZNDhrdlR3RiszbW1helN1NnJjelFpNy8zc0orcnNy?=
 =?utf-8?B?c1gzbVJQaXM2aXQ5QWQvaC8vNGdHRTJ3d0tLN09PTnpwQWRUWkVBcFZpUkJT?=
 =?utf-8?B?dzBmR3MvOVd3ZjlJTGxSU2xuRVpTcStYbmIxRjFwb2VPeTFPZGh3SGtxeFpQ?=
 =?utf-8?B?d2FpM2pHZ0ZIYzl4Z3RRb1B3RlhLY3BmYnFKb1liN1RaZlEvL3lqWDFVOEV2?=
 =?utf-8?B?a0xVbHppTkI2Vm5jUk9WejN4Wjg1dTBPT2J1MU1xN2RLaXIvVHRtVVh3elJw?=
 =?utf-8?B?eVM5Z0lxRkFmNkFaYzFmV2k2M3NiM29rK20ybC9PV3JVQ0RTeDdSMDdEb3o4?=
 =?utf-8?B?eVFqVHptb3FnZkI0ZHRrK2ovNk9ROWJEQUtRQWlZSW1oQ3pDblpLVXA0ZFdH?=
 =?utf-8?B?ZXo3UW5lYWVuUER3akJ4VmVucFA2VXZCa2hoT3RqRnFDOFBaMmFoMWt1aHln?=
 =?utf-8?B?Y3QrdlpheEpNbnM5eG9MS1VZWkx4N0JxTXFWRWpYVUdTMFZEWDZSUVNxSHZS?=
 =?utf-8?B?eVNCWFNtNUhYaWltUklUbFVBMFo3RGROOVVMd1J1OVloZXVxcUVUS1ZlaU1v?=
 =?utf-8?B?WnhxV2VEWS85bEJ3Z1czeVl0eUhlSzcvYnl4YllMOVNoVjRaRmNjaHl1Zmxs?=
 =?utf-8?B?ekJoOVZ3a005U08wZGpDVVF6TmJwNDNYU1ZtdDhxUnVZL0pKVXNlOVVSblpl?=
 =?utf-8?B?eFFHM1dlcm4vR1Bic0JndnpnbW1UU1BCMUo0cTNSV1F4Vi80NnQ5dGU0WGV3?=
 =?utf-8?B?cDE5RFlMd0o2NnZoOXdsMG9QcHF0L2ZiOUxPT1hQOFlRWXZLRG5CbkorOHVV?=
 =?utf-8?B?Uml6VzYrYUFaZm5VZHJXQmpuUWNwYjhCZ1kyNlpVMjMrZGNYYlZSMkF5a1Y5?=
 =?utf-8?B?YlpKOE1ERHBWdEh6YnRlbG9Qb3hYQS9LYnZ0dU1mSy9NckFmZVMrY01yTDN1?=
 =?utf-8?B?ejhzV0dLdmxJbjRBK1hFZm8yR3Y2K0JvVy9YaWdxZlV5YmxYSDN5UGcrRVhp?=
 =?utf-8?B?c2JGdHFEM1BuZStaeW12a2lMMnBBTUs5ZDBRRjE2NnkrY0xISDdhc2pGckkx?=
 =?utf-8?B?RlpQT0s2NTRUTXo4dHNkRkhVRjluRGZrTVplOUR0OE01YmFCaU1ha3BEN0Iz?=
 =?utf-8?B?Q3lkL1p5N1ZnNlU5L0xGUzVQa2RONS9PZnpKcm5JZnVxaDViUCtOM0RyV2NE?=
 =?utf-8?B?bTN1dGJ6azFkWnNNdjFTaWo1VitUUURrSkwyM2pmZ1JTczFueGtHNDJhR0kz?=
 =?utf-8?B?dEErQm1XTndFYS9PL3dKMkhYak5Bb0VWWDQwTTNKbmZvVHVXQkpNOFVjWmo2?=
 =?utf-8?B?UXY1cUpNQndPUllSQUM5anlyN0JTUGpBL1RNSmp5L0VYMWhtTTNGMVlpeFFQ?=
 =?utf-8?B?RDJhSWZXRlBzQ0M1QUpEK2JaK1pHTVRtVTA2SS9iUWg3VnBxdndDcTEyRUc1?=
 =?utf-8?B?MWdkSGJ4SFlBcElROXI5WUdNdTRUcjFydW9OR3VzQlArU2ZmeU9nTk9ZOWs5?=
 =?utf-8?B?NndYYit6aTlSZlJVWS8yRzYvYy9EMUd3QmtiNDBXbXdEeTQva2Z3Z25tZWJZ?=
 =?utf-8?Q?iE1cHs39zXgqQ2c7pFVmB/Mps?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb7831b8-1ddc-4157-8299-08de1da335a0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 02:13:16.7131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kDUrkPFMud0XSmSBPgO/zjKZduq/YABRjMDt3e3E2lOPieqI7TEqF0YvqLHVdP88D5B5syLT8Uso170jH08KVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10484
X-Mailman-Approved-At: Fri, 07 Nov 2025 05:40:31 +0100
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


On Wed, 05 Nov 2025 04:42:26 +0100, Marek Vasut wrote:
> SCMI v3.2 introduces a new clock CONFIG_SET message format that can
> optionally carry also OEM specific configuration values beside the usual
> clock enable/disable requests. Add support to use such new format when
> talking to a v3.2 compliant SCMI platform.
> 
> Support existing enable/disable operations across different clock protocol
> versions: this patch still does not add protocol operations to support the
> new OEM specific optional configuration capabilities.
> 
> [...]

Applied to fsl-qoriq
ext, thanks!

[1/1] firmware: scmi: Add clock v3.2 CONFIG_SET support
      commit: a9295526a8ae7b2ed65b7dc91966295110ae5ca5

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
