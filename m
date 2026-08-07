Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB11EC5AC7C
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 08:15:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 173ED409DE;
	Fri,  7 Aug 2026 08:15:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ebei0FSgCEm4; Fri,  7 Aug 2026 08:15:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0A20C409C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786090554;
	bh=afxyQD7rczRdBxWv3X0TutGhDgElWk/OYNpj8+U3jAI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IiCvAXd420zmjFxlgtsX2YBrUa3NYy//IBenJKtB6gDrhcGW91CVO5uCx1XhbTQyc
	 H3OsDY7+Xat2Rl2LsCdfVuo+c6MZoC/053c4QcePHkd5j/P3Aqot8wVzLz6AJVJ2dq
	 z/zbMbfdlNsB3kZNCXtGHfNZOxb9xNwnD/xMw+Jax/hvWs3LThqKRUt3kZ2ba7zJD0
	 r/P7EQwoKai0ulkR4MuJv24FBw6jUZXdtPt/r/0786DsqLSxuCOMD4m9NxWC1U5jdW
	 KrVgnnnbbDrYMPBojCP/3JUeW1KwJDQGPhxCtBdypE2Z7fAIFtz90p66N4lqgJWaPB
	 gUdxDfFyn8rBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A20C409C9;
	Fri,  7 Aug 2026 08:15:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B349397
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 08:15:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E615F403C4
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 08:15:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id csWCNLgiSdUC for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 08:15:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 1BCBB40084
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1BCBB40084
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1BCBB40084
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 08:15:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oCSUkT/vTISSAnGKL8s0UhzSA/ZRnvQCVKSmH2JnyQOvE2SJgy1UDF14KgzfKpgs2I2wagCPP21sDTBGQ6Cv360FqosCEGzIysazaetLI5wyQ2cbybMoHo1qkwfE0NtC/VRoIf38eXiuWSqYcTkbRueE7JfoiM2RZx6o9Q99I/XKcHbtOwF0ujMTxAM7zepwZbP9ippMGUn3ck19jf4Tl4f6pBEfxzVBFGVNVLXRas+w0/YMutdiNCch3pSK/i386GUh96xn5wSR6w58HGmTC2DDIJOlIVTdvCMJoWQKUId5P11sJBIytNwmm4C5tnBFznmaT+7oImkFw49QMhYGbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afxyQD7rczRdBxWv3X0TutGhDgElWk/OYNpj8+U3jAI=;
 b=LrnKgxHE9heFtzoNgBG+X6hDPpYzgI7KDt/NeL+npYGi/BOGMP9+wdohQj62uOHdf/PVvhi1Sb/H/1Rm3R4nzhjH28Y+kMNmYH6BGzREjPs0FoINo2B6TdLuD4yqINKpFwXpgFEbn34nxFFWuFGxh9veVmgBeBhgrbokkFQdTtPCeYAcZHneSdnXkgfHNBZocOLKmqv8BPKr8X8PZe0eig339PnaX57RG/gUGaffMv4dB+Kj9kiBJzRyVlOdXqCCeYCFwmP+EiOE9vq6vgEEf9jnFF13yGJMl16+as+7eVWuneI1QGGw4yFTd4K8m/NlnXU9dJG21N7u+X4wcfRRPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by VE1PR04MB7229.eurprd04.prod.outlook.com (2603:10a6:800:1a3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Fri, 7 Aug
 2026 08:14:43 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0292.019; Fri, 7 Aug 2026
 08:14:43 +0000
Message-ID: <5af6d8cb-64cd-43be-ab99-3a8daaaf7ca7@cherry.de>
Date: Fri, 7 Aug 2026 10:14:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] include: linux: Import hw_bitfield.h from Linux
 v6.18
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
References: <20260803184314.2240153-1-jonas@kwiboo.se>
 <20260803184314.2240153-2-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260803184314.2240153-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0193.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::14) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|VE1PR04MB7229:EE_
X-MS-Office365-Filtering-Correlation-Id: a696052e-11d4-4b7f-ec90-08def45bef79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|10070799003|22082099003|18002099003|11063799006|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: NfUsxHmDViHlTVWVFTSQUwOZJVncces8+YjEDBvdPzDjxzy95DXP/Fq+F6bndeCzLeytK3wz3wH/ZbAU/aLrtE7ov1oOz8bTjXAVnvqTAdEMP0zTRPECbcCsfmJZhk+4AdBOHC01rfK0O8+PiJdWsIjG36ZXQds8zHmL3RjKCsVHp8qqDByu3UlXgH0MIXDkJOo+uFezSxv5ITFDcy0mKdWGW7JUnaLWMnbj/ea0WNDAeNShvdMjBrUlVAV1oCNii9a4Apfl9bwKsrKGJXKtip4slri/mHySY8Bh8iBVAiKWJ06B98gt7qoCDhyrRlN6Pv/3mjSuaTsjr8HBSUpq34/AlLmR1Hjvxxwn15r+GC+XacPio+ClbvCO/AUl8jzxS0EgWSmJx6AfBJsM3pJP51MjpwhOI/9CChSEXw+o5VTh3eijMvQ3JhXI6sIEkgS3VMV6zoZ3CkevpTt00VGPO23MLpvxSgYrgYE07751bfenEq1B0lXrKFzES6kMjcddtMIkeIVpdGhO7azdHFfNbh3CRWxhpIGWN7FgygxgFt24TqL4eA2j0qKcbS06VJ0sCr6VUQ9aaXX/pbOuv1ehvpwwlCe4H0EChrbfDyX2B/YmZen4wEagmPp770fMMVuwe1jpAvvysVzB3y3WKSsT3v8CLCQpHqMhpYY9Imfpn0I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10070799003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amtiMXpaQWFRQjVlcTZXaGw4Y3pMVlh0bWF3Z0xSc0s1VGkwdkhrNEp0K2Yz?=
 =?utf-8?B?WmkrQ3VBNThKK0E5ZzJOVjV3K2t2aCtHUER1NWs3bzR5NFFhblpwTTY5TlFL?=
 =?utf-8?B?Vm1RZ05EL3YvSzVGcHBRWTZyM0oramcwOWtuUEtrUmx6ekljSzhzbjZpeHNF?=
 =?utf-8?B?SDhlMmx2bW5ZYUl1c21DZkJnV0hrWUhMOHd3TVdINUJUWHYwZ0lQeCtiM2Vh?=
 =?utf-8?B?U0swTTNJN25rZWoxRjF6cFJOaUkwOTZTTUdCSkc4ajlNUUdqSTZJaThCYWwx?=
 =?utf-8?B?alBxcWxhdUlVeGFESEtoOG5pZnUzZi83Wm5yQitZL1hoaW5IbnpzcHpGRGZo?=
 =?utf-8?B?dUxlU1BENmxSbzVabCttOVZ6d0ZNc3FxeEcrMm1jSmZMN2ZiZElobm1PdS9l?=
 =?utf-8?B?dHdwNUcxQUo2b2VLS1BwY0tSN29MYjBueUdMdEl2eHBhZ2VmUSszU3NoREp5?=
 =?utf-8?B?TTdjak5JeTkyTnVNV0xFNDVsaHZNK0s1V3QzeHlpTWlQR1NtM0hSTUpnVjk1?=
 =?utf-8?B?Vjhzcm9FZXNmMHJSTXFMNTdyRXFmakswNDlMQ0JFY3Y0TjliQ0RERVdpaHk3?=
 =?utf-8?B?T2gxaUZES01ZRUprUUtpVHkvV1g4SlV3aE9OZFlOQmJoQnhoRjJxWm5tS2kx?=
 =?utf-8?B?RFVvVEluRW5ZZUIzaXRaa2VXdGFiclQyRWdRZXZiRHBBT1FjS2xqVTc5OXdI?=
 =?utf-8?B?c3VxR2cxQk1oTWhXNWU4aGJXb1JabEh1aUExdmVCdi9yRFBLZ1Zwam5tNUVW?=
 =?utf-8?B?cXhOZVpTNEFtMGZUVGxJdGZHWjJ1VXJydXVDdUlaMDVBQ0lyamJOUi82M1Jj?=
 =?utf-8?B?eVRTbldhcUVGWUlxQXZkQTlzV3RReDRhMGZReCtMTXFlTkc3V1oxUk1BNGR2?=
 =?utf-8?B?NlN0NWNrMFV2TUNsaFJlZ2FwMmcxSHVnc1d0MjBGR0ZxK2JJS2laVFE2ODZt?=
 =?utf-8?B?RDNoNUJLWFAvcjAyTmxmblphaXNPaENTdVI3SUhtK0FUbnFYeWF3Uiswa3NZ?=
 =?utf-8?B?VFRkUTdhNmdIYWVVbnFicUJQUk9oelJoaUowTkdnK2FCTForNEN3WkszMk1E?=
 =?utf-8?B?SDJWODl3VFU0ZnBFaFNSRTBMb1h4QlgwRXpMWkt2Nlh6d1QvdlJjR2dxL0c0?=
 =?utf-8?B?MGNhTzNTK3FIZG5OUVpDTXJ0TFp5TlJtQ2pEVEVWY2hCa3VCYzQ3NlhJdmVI?=
 =?utf-8?B?V1V5anA2UENlZVgvdU1FdjJUNUNuT0M2Vk9rZlVTRkRWOG9MR05TcVkvYTJ4?=
 =?utf-8?B?akdRZWFDK3ROOEVCU0FZdTFsK243TjF0VlZxVndURHJaWC9GYkFtd1Uxa0hk?=
 =?utf-8?B?M1JwMkJWZGRieWEvYnp5NnVLQkwxcEwxNDNjZFB4ZzNOVi9xZHpaTnhpVUxE?=
 =?utf-8?B?T0dDSFFhR1U3V0t2aWZjSTRjS3M5ZUVEZkhYcGJjUTBCVWowMmdmL3ZKUnZ1?=
 =?utf-8?B?Ymxqdk5IK1k1cU5xOHl0SzBjK3hibG1XNlExR3R1V3YzN3JwSjFRNm4yQkNQ?=
 =?utf-8?B?Z3JwcXJKWEZEdW5kY2V5QVpmMWxqNm1Da09KTTl5eE9FT1hFV2M2SnpjM0t0?=
 =?utf-8?B?T2tRVXlNUk5ReFBtdjlzaGkyMDVSTDYwc1B0c1dTZFhlMHpJMlRsUHpaYXJB?=
 =?utf-8?B?Wklvc0xUTVl4MWhwNVdwZVlNNWZzZUw3cVFaUTMvVWJ6Qk1UejBuUHdwTWRM?=
 =?utf-8?B?K3U4bHBQY3BQNTBXVzV4VlBXV01ITi9YdS9UUE5ISUdMUHBFZXpzZTJaTFZp?=
 =?utf-8?B?MzZ5NFZVY0w3RjBHZVlDNkNreGdOdWd2U08yblZWM3VBWjZ4aWU2YWNCVUc3?=
 =?utf-8?B?cGxVblNqUkZRNDhBRG53VVA2VGE1VGREVzhzSkRvVTgzcHVWcGVFZXhoZXly?=
 =?utf-8?B?ZXZrZEZ6dFFiSFhoT012V2pWVVR5dUdVVVE5dEZha0ZOay9WSmdhVzU2QkYy?=
 =?utf-8?B?NEpraWlHeHBwYmh1ZnNHdk85QnQwcWdhZGNpRk0wdmJZRDlabnliMEZUS2JC?=
 =?utf-8?B?c05ld2Nja2crNUhPVFFsb0lKeWFJakxxcUlOcXNaeU82cElKT00yQSsxclNn?=
 =?utf-8?B?KzBZL3h3eTdmVk9Oa1Z0L0VKQ3FJWW5SSC9DSDJtOXNUTFF1cTlNR0VKSHNT?=
 =?utf-8?B?TVd0Qm45a1dhNVRYNURIYVZ4NUQzYmM1REoybWxnS25rTDFQeU5VSjVVT1Uz?=
 =?utf-8?B?VXB5cDlkeDdsTjdZaUlVaDZxbjNtTmFsaGhCNkUwZWJoZHp2WVJTUWYvUTBr?=
 =?utf-8?B?a09odEdZNGtTRGNzVkNQUWpEeWdmWWpGN2pvN2RnRzZQT3dOVkZFZzUxYSt0?=
 =?utf-8?B?clIrL1hwdVJoOGpKMStWNlZsMnFiek5Wa2FBekZCNGNkRkNualhEUEtYaE8y?=
 =?utf-8?Q?mwlsrtTVtmwcSvpVyDL9s0MESStbeZ5Yh7rGbCEBvoGo8?=
X-MS-Exchange-AntiSpam-MessageData-1: ElovE86fOHVxPmqlnnbew+RFNoyCyuu1p9I=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a696052e-11d4-4b7f-ec90-08def45bef79
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 08:14:43.2141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wndDUMeDq+YgOPd07+DEI2JBtGZ2g0iQyGZ0gVT7+J6eevsGe+QTQiURbfp4Td57X+jsTrKZR+rB5H7xv9xl64w4+o2EUP5plh76OIvQuwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7229
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afxyQD7rczRdBxWv3X0TutGhDgElWk/OYNpj8+U3jAI=;
 b=NIitP2Lg66abqFMjE6qdXtsZrHkbl0aQWA6JMaupOUqB6bZBp3bRdIUfqoOcma7dTTnH5SHGB/OTVxMuIxbcDGeQVE5UbjDb7IKBRsSeETYpm2LEjPo2tr+CDqSy7HAU3ZbhMNBOHQ+riAiY97qYRfB+EjgvAo34URiQMpOU2y0=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=NIitP2Lg
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Jonas,

On 8/3/26 8:43 PM, Jonas Karlman wrote:
> Hardware of various vendors, but very notably Rockchip, often uses
> 32-bit registers where the upper 16-bit half of the register is a
> write-enable mask for the lower half.
> 
> Add hw_bitfield.h with two macros: FIELD_PREP_WM16, and
> FIELD_PREP_WM16_CONST. The latter is a version that can be used in
> initializers, like FIELD_PREP_CONST.
> 
> Import hw_bitfield.h from Linux commit 21368fcbb124 ("bitmap: introduce
> hardware-specific bitfield operations"), first introduced in v6.18-rc1.
> 
> This contains two changes compared to the Linux version:
> - include of linux/limit.h was dropped
> - use of const_true() in FIELD_PREP_WM16_CONST() was dropped
> 

Acked-by: Quentin Schulz <quentin.schulz@cherry.de>

The content in this patch is as described in the commit log.

I'm wondering whether we should try to get include/linux/limit.h (and 
include/vdso/limit.h) in. Also wondering if we could also get 
const_true() in somehow.

No changes made to this file in Linux kernel since v6.18-rc1, so could 
as well have said it's taken from 7.2-rc6 (which also means no missed 
fixes).

I'll wait on Tom's Reviewed-by before merging this though since it's not 
a straight import from the Linux kernel. I'm targeting the next branch 
for this.

Cheers,
Quentin
