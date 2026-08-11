Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1CE0C5CFC1
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 10:35:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 29141607CD;
	Tue, 11 Aug 2026 10:35:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hevalqHzyul3; Tue, 11 Aug 2026 10:35:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0C562607C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786444541;
	bh=TxSY9Z69LNkFM0n4zu4Ksqn7SPJE3ag18Ybs36AG7Hk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FNVgBkdHb5r/JHmFLCgjRFHqsSz6oFyElOjlqT4lCwA9pHL+p2vKr8w+qRFG3Xcpd
	 XCOmAY5VDHOfH2LtdCYwqLsbL/nPEUQSB60uobJxX79gzBn+AYvb91yw1fTZuDiqR9
	 pcaIm3h3waEN8M1IptU8ZLIlEztHA45pYW5YNq295nUZHlIA1SWfpl3eylZSxy0brS
	 /Z3ZZSkBMCL7PoAeB3+3pZotBcTeAx2hGjopwCXnVstXscPpl3MqMZe0ZnaQ11xL+Z
	 aBpAQzZBfrk/0q/GLr9RVTL8Pc0O5lxDIq4P8Ft9PS26vD+SlAFMdfDs9jr5zIOuub
	 33qV3iCKdieNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C562607C7;
	Tue, 11 Aug 2026 10:35:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 73898722
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 10:35:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 658A580DA9
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 10:35:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SAOtnFOre2TY for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 10:35:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::7;
 helo=ch4pr04cu002.outbound.protection.outlook.com;
 envelope-from=pranav.sanwal@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2887580DA2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2887580DA2
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2887580DA2
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 10:35:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wuxz80B+FVk3OHpnXKrTqzsfTB5SBUfc5azJ668/lJ1zfCKqxC4x2Av95W8kYHjCrciydFqrIRbREvfDn3ObjcdurQ5OKko3lfJkjdPqDwLxG/mBxOJzW6nZqGgmrizU+WhUyPswUXTkCqIjlutpX/N5rhHLt3iKvB2EVLeHXYtdnch5P2gAzKOZEeg9sa/PlTX0IIJfHKQG5PbsIvcPiT8YfEpxIAcquh5j1fLbFudcadOKkGOjlsTCk6fi7g2kprkyfUkJfUc0okuB4KrcldaTDXa5lu5UK9DvVckd2kK7rCi9p4IDhJC6irUph6Dj0YUANsKW7ZbmnqXM8CSl8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TxSY9Z69LNkFM0n4zu4Ksqn7SPJE3ag18Ybs36AG7Hk=;
 b=S1z/d1qQdDqUEt/wl/aQKfJMjtSFV5FriM0dK1Bpi1SCzhJeBpYPObDDgsjB0USckmwim+ibpicIH1hM4MWsGo7ixhgAjyg8wM4yiO1G9V/P6co2k20k8s8xV7gatkLvId2B0+0d1NNzCBfH2xw/g2wXnsxAVB3RBf37Sr6WKrFoIcI1cVf5YG+TUMb6Q2FgGFNGDb3BnXfsRKEHa37rWWVSP1FnWcPiA+HeW5huHVJNz6wV9mO1Z0DoTmO4DdRu3QLDVZba12bwT1eGJB8t5McdEVbI9VDFXUgLJjs4p6oNd3fQ3lGkO4f/W/rB/4NYV4nB2jmPx5kspfIQTa/8xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MW6PR12MB8758.namprd12.prod.outlook.com (2603:10b6:303:23d::18)
 by SJ1PR12MB6169.namprd12.prod.outlook.com (2603:10b6:a03:45c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 10:35:34 +0000
Received: from MW6PR12MB8758.namprd12.prod.outlook.com
 ([fe80::c0e9:462d:f3ab:6c77]) by MW6PR12MB8758.namprd12.prod.outlook.com
 ([fe80::c0e9:462d:f3ab:6c77%4]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 10:35:34 +0000
From: "Sanwal, Pranav" <Pranav.sanwal@amd.com>
To: Simon Glass <sjg@chromium.org>
CC: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Subject: RE: [v2,0/5] gpio: improve claim diagnostics and fix gpio-delay
 offset handling
Thread-Topic: [v2,0/5] gpio: improve claim diagnostics and fix gpio-delay
 offset handling
Thread-Index: AQHdJ1+Q3DfnRWTNx0KV5vGdrkJxOraYiwqQ
Date: Tue, 11 Aug 2026 10:35:34 +0000
Message-ID: <MW6PR12MB87589E71B8B7B2EDCC7E4014EFDD2@MW6PR12MB8758.namprd12.prod.outlook.com>
References: <20260729081218.550465-1-pranav.sanwal@amd.com>
 <CAFLszTgSKL4SRDOpej4-rd2CPtNuLVbA=L9yfCLhy9_g5E9ihg@mail.gmail.com>
In-Reply-To: <CAFLszTgSKL4SRDOpej4-rd2CPtNuLVbA=L9yfCLhy9_g5E9ihg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-11T08:39:16.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB8758:EE_|SJ1PR12MB6169:EE_
x-ms-office365-filtering-correlation-id: e3202e24-0a78-4f76-2507-08def794468a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|38070700021|18002099003|22082099003|56012099006|10067099003|11063799006|4143699003;
x-microsoft-antispam-message-info: G/Z0yAMRxszRPbe1PWZlwA8SEBpr5ynDqnJrC4ZPgrDWxRs8rhaSY3somZbekAuc6MvS7PEwCY4lzGt5vZyggwlZVhqmx077L7oMKxoIADwa7OMArdVDj9Fz/65K93YtCMV0WfskU0Lrig9DQzDBuCBlqz2sxqhbYCEm1s0LVl/sWB+RJVQn+ZbDtXzD6ju8ehw2h3Vo9ZJsnNbwtJRh4eGstfkOKjhOOLcFVsJGTMaC87Dzer8XafWXXBdT8no9SoSEFq8idL6zcDjhzbBg9bP9FffgJiurcUMAZBKM7OHBDBtrkH/bZqlO+dZ8ORa3F6ogfdh67XXP3DkhMRYInzK+x7OmuyVjZobZGo1aUQO4ehGZL5xyiSH8y0rxeCYMY7qUmrPuQSpbGxhWBJFlk6HW4gE0RR5mAiZT/pcItcVWlGvKqCIUAKnrBZeHv1AZoXmo79bq0UaXPl3uCLoh8cjhaI4O+clS7R176or8+VwmA8pA15TXirRhrs3imaZn9BOhbqMSG0kioND3p8rxGT/GAr2V8Cj6rrj8PwVG6aGuMhACP1VVUTzwFrd+TDZQsR4nwMZchLUaSavPh3EZ5+JP9bUswvG1+G7vDH5f0jAeaxFoXxVEmIE4sInx+z1BwvomfjzTQsibj+UOD7ON2biWtQLiyfcd7gB5OJnXvO2l+++rsZHA4qksOr0EoQGKt1EAyxdJpYZuElLSLM7dZcXLq5d7upIw40MlOYH1V7M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LVkCtwMd51Q0mtT2wgMOdtePfeaDgClFLpCeHCb934y5IcpENilbhy5uQIRT?=
 =?us-ascii?Q?qb4atgscVXG4HOPkcCXSfo0ie2mod7iu55UA9I9kyh4OEiSyTb31CeXLV92K?=
 =?us-ascii?Q?9BGYZFKzAaJGRu1EnqOJ6TztYkW2d5YnZ/SWZJVbzhmA712A5yNdsB4WTsjn?=
 =?us-ascii?Q?HS7DHBBqpdZEK+Et6i16G8IbWCxq7ICucfqN1ZFO+i+0LXIBL35N04TDdfdn?=
 =?us-ascii?Q?NOLO4MQZNsULl1qkJJei34Kll62kg6UdHA6cPmBW3YHAmmEtZESd7fWWZNQF?=
 =?us-ascii?Q?Wl70EEatLEXhGhvhh6Lw0r2Ebz1Z4dGdUUfYqIMZYjwQc474D3YbnzDaIY8y?=
 =?us-ascii?Q?EOZMVDhAfDqQY4PYubktwcwmGy7EOVHn/A84RfBqpukXrCshv1va1pRdTPNM?=
 =?us-ascii?Q?bt+Q4bBO6XugQ4Ut3rTjxwhF1DKCGD7kjqqqf50xgv19wLFXIvG5GSlXnzFD?=
 =?us-ascii?Q?DbnpaXkYDWCa+yXXSnHCfFsadoat0Q3t5Ux3+y+TCx/ZnJEFJMORaCs6FOTy?=
 =?us-ascii?Q?02Eu+GCVDddqjHkoLg/ISe+Z994tPytBIDOljSMHTcicMTQztFnnf0KF4WFm?=
 =?us-ascii?Q?zBjKzLwNrVrEeyL8rVhpjUQ4stbK0RuKgOl5HisZkebJpQY0Q64kWz/8sUjO?=
 =?us-ascii?Q?sclpLNWFzM+24VLxknAFWeK7+3Fhn7HBtcuxZv3mRVLzRh0g5KUqbYGMhh4y?=
 =?us-ascii?Q?mOE2Azlex6q/SM+orFb4aExcu7hVNehTqrT1TLuO4Q4MmL/UEv2urBcaYglQ?=
 =?us-ascii?Q?wK/MB+jLnl0ibqYR9g1VVMNiZUp5D/lyJazVvXcbQe5crlpHRLmrFkkqR7yy?=
 =?us-ascii?Q?Y64buIO6CBsYRUU6Gx82SsRpYlHSknqWt42YvFDi9rh26nHV3cmT5RSDeCHp?=
 =?us-ascii?Q?RJ9wyiHVGLjWeUPLUCWt1zR2UonUpUdi0YiVuG9QGCD0wc0tOlS1z1DA1DbL?=
 =?us-ascii?Q?FjNqZK+pWubQZql65kc6M3IHVs5iMIaZs8m7djq14A6oxARcUvGSh0DPnZv1?=
 =?us-ascii?Q?PheeWv05EMaeZZIjhKl7MYAvBuRfxaKRJQgTQ1t3n7p0iCsFaGaTsqfg3xQO?=
 =?us-ascii?Q?24r7VxTcjhoDlMcdxFrsodP3rVDvM1S9g3JdGWQn6F2bpxbOyXGMAg0AO6/M?=
 =?us-ascii?Q?fzfRxv0fiIIJQI4XJyiwxQFSvgEVrk036NwVEeDMPGPxZVC4ihObLHCHZI7E?=
 =?us-ascii?Q?vBbuPwetV+ksjx5AX9MTmjwow8iDInqM+6ZBDStPbvtbU/byujVtPSxhPoUE?=
 =?us-ascii?Q?U/k8FnodxB1RwcxQ+GYtkSyj5PbtbLZCgSbRAnEmF81R6MZWezvbLjru/lJr?=
 =?us-ascii?Q?ZvDR1L4vCSHzo/Hfmsod3fSz3dPRLFwS4l3pgTNUMkhSPKjYP7ZXlxv0HtVt?=
 =?us-ascii?Q?wi9vf+/24L/6GGzjFfBgswwn6Q1ts79La9CsuZMLg8GNNdWx9IMuRFDu07NM?=
 =?us-ascii?Q?9v52zatwToyYgVeK/Rk4RmrzZXqtAZ3iYdbRRfizA2eEm6V52l2IKC4aAIcK?=
 =?us-ascii?Q?cbY4DMapmr7J2oUOZvUpkRerjItMaLE4AjuQvvR8gbJSRjVlQqgcMv7kamfb?=
 =?us-ascii?Q?BzrapDDupx96yHteEc9/L5bpE7g8g5AnRso3uzUKsbSMDwIQZDOEmBpGmCkS?=
 =?us-ascii?Q?F+4qr9xrc9YHSvYxj7V+m5ooaaNyaprJRS+y8eci0W3cQiE1asrDu70wMASR?=
 =?us-ascii?Q?8DZcquAC4As0pZTztnw/yZ+HyH1rpuUUCzRMcCOwe6NINXoQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3202e24-0a78-4f76-2507-08def794468a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 10:35:34.3284 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vHRfjmAnt/zwmuKMJFjBnNVnt+O4AOmW16cSsQupYCd2TrRl7GPtgaVtzYBBAMHW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6169
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxSY9Z69LNkFM0n4zu4Ksqn7SPJE3ag18Ybs36AG7Hk=;
 b=RoNTE042Omp2vFXjoqfOcoWTNZ1RnzMP18W3aJXJdf2JkL9ikP8M4eiFMeYGaB/ce6dNkeb4N6ZLz6mK18/LUkA6AYvBfNmgQSZUa1C81xFtacl32TQoDRfONEAm4iYUQnLlkjBhipabLRjf53Wmvhe6CpxBeyjJKoDAgi/sQSw=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=RoNTE042
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
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

AMD General

Hi Simon,

Yes, this is covered by a follow-up series I've already posted:

test: dm: add sandbox coverage for gpio-delay
https://patchwork.ozlabs.org/project/uboot/list/?series=3D516335

It depends on patches 3 and 4 of this series (the test fails outright witho=
ut them), so I sent it separately rather than folding it into v2.

Thanks,
Pranav Sanwal

> -----Original Message-----
> From: Simon Glass <sjg@chromium.org>
> Sent: Saturday, August 8, 2026 11:29 PM
> To: Sanwal, Pranav <Pranav.sanwal@amd.com>
> Cc: u-boot@lists.u-boot-project.org
> Subject: Re: [v2,0/5] gpio: improve claim diagnostics and fix gpio-delay =
offset
> handling
>
> Hi Pranav,
>
> On 2026-07-29T08:12:14, Pranav Sanwal <pranav.sanwal@amd.com> wrote:
>
> > Changes in v2:
>
> Could you also add sandbox coverage for gpio-delay ? You shoud add a gpio=
-
> delay node to the sandbox test devicetree wrapping at least two real line=
s, plus
> a test in test/dm/gpio.c that requests both consumers and toggles them? T=
hat
> would cover the offset-propagation fix in patch 4, the gpio_count/bounds =
fix
> in patch 3, and - via dm_leak_check - the remove-path fix in patch 5, all=
 of
> which are otherwise not covered by tests and might break at any time.
>
> Regards,
> Simon
