Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52391CCA470
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 10:54:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B33A883045;
	Tue, 30 Sep 2025 12:54:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="VC0ZX6tD";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VC0ZX6tD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8509583071; Tue, 30 Sep 2025 12:54:12 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 579F1828A2
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 12:54:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Harrison.Mutai@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=N7xn6aNErDAT+JRV5RfEHy5euVDB9A4tQnO5i2jgNESgF8UNwpgeMUYEcQe8mw8rnE0cHXqMKNbiDxmXXdQHVSy3AX8tHxrEUwIIRzSA/8eqfR2LIETqRAtpENHlvNKZ94e549RSvFBn4wxRq77qhOZl0oNQYQZljk1tgDSmoplQ25HqBGlB1U1QhAGL/zlgUjCnj92vAp9bChBId89wyczNC+3fLOEVvZtwVpE1jDakg7ycnXdDl44nXSjdQfe5T1NzIfLXRONGDpcPH+D7A36TxyNwUF2yUHtxgPMPGduLvY8fChwSjtU0hF5lweksuoEJs2daoKj/mGBdtXP3Sg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLcgTLU7CtSJnGwnv5X8bK4dRlp8t/QHSSfN1NHOSnc=;
 b=rM+bHlUMjcurV135ygtDXrkg5lIoArZoy2NfpFJiVSdDpEjKFvoR0/DAhDG3KLNCvqolUrww3voGc5O+l7QGhAUF2+XwtwWooPy84kTYWT7z/yqfjeIYEEMbqZbL0JGgq2Snp6X9MdjFRX3kkPvlz4y8YzJpZIvyStfyJndnxHCC0zhqApF9tzVhLQaYVQH6Zkq31Bft7w+K9Od1ftV5LuDV4kFcruUfYEIjSoSyTkO/OI5+b5UFaS1feT1g1BlH5gxvXisDNI1gUeYx8N4dX+8gfWFQLWhpZwg4sNTGq9TEC/LD1385JLfgEWYzykng+KP9NTuIoyKivO5JgJZTFw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=konsulko.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLcgTLU7CtSJnGwnv5X8bK4dRlp8t/QHSSfN1NHOSnc=;
 b=VC0ZX6tDHGc7jv4NvnC+Mg2O/YGt9tu4wCT6vYaBpaF/klPIODeTb6DLA/MABEwI4NPicbYk1lEgijmXQM6cXogpK3V3em0NHW0Mk1g7ijPAdP2vJ1NIjAC82qT/FIjIf+UKSzpqdETmyJBzILSAHJ904rTdnMXZGb791bedgqw=
Received: from AM7PR02CA0018.eurprd02.prod.outlook.com (2603:10a6:20b:100::28)
 by GV1PR08MB10730.eurprd08.prod.outlook.com (2603:10a6:150:162::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.14; Tue, 30 Sep
 2025 10:54:01 +0000
Received: from AMS0EPF000001AE.eurprd05.prod.outlook.com
 (2603:10a6:20b:100:cafe::9f) by AM7PR02CA0018.outlook.office365.com
 (2603:10a6:20b:100::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Tue,
 30 Sep 2025 10:53:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001AE.mail.protection.outlook.com (10.167.16.154) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.9
 via Frontend Transport; Tue, 30 Sep 2025 10:53:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LYNhSZt7cPaIIwPfc2NfXvnmSNepaORyYmcnlHbDtwrOUfjAIomZfHVmmeZmJybLY0qjYeVzl9ryy2mb1ns75iZ24GSEGExoVXdguhdUoDGyTepVPVnpQKj1vlcey7mUOYscb350EED5v4c0ISWsPJ6/1nDZe0D8SvK/WselQ+sqqikEjGQdnsH+lF38RwLkMDGRaDLtTMUaAMAKlvIuGXOMTK65bqbj+l7kZ5wn2rZan+SeO7V273y5KxcL5xm+OhmIxFnkLOoIFfYv0dC0CtAPEa9AEqIjNFeIlADeNI7IMtmRiJKL7uxMiMS/PlK2M6RGwh+X1y6BWtM3up4KdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLcgTLU7CtSJnGwnv5X8bK4dRlp8t/QHSSfN1NHOSnc=;
 b=lvqNOkkUQ6jdCW/bGyb3uDJWOBAu7IMNiQ1lGjX9DQL5edWomQG8EP6y8xseFeJBha0RT2hnZ372E9OIQcHekzKN3WBQ8vKKsFlUmivY0oI9GajSxE59kvPLjCh0GzPf3Seje/NZJ2lBK+epgkPuAXceGEHTiv3vFCChhj+YvWWOfYOAYqKgdUelGUBvDj+dgOARVkJDqoCxrYC/Y4QDb0aSY2K9WWk0pfDgLqHoyc7PaawVAXxTj/apG+26rs1/AcM21W5vQFJTkce2R9rBfA3xiR6HPhje2o3VN0W51QRHqKYG/hhN6rvmIFG60Vs+FpQMUjSENLC5qlqwqtiHjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLcgTLU7CtSJnGwnv5X8bK4dRlp8t/QHSSfN1NHOSnc=;
 b=VC0ZX6tDHGc7jv4NvnC+Mg2O/YGt9tu4wCT6vYaBpaF/klPIODeTb6DLA/MABEwI4NPicbYk1lEgijmXQM6cXogpK3V3em0NHW0Mk1g7ijPAdP2vJ1NIjAC82qT/FIjIf+UKSzpqdETmyJBzILSAHJ904rTdnMXZGb791bedgqw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DU4PR08MB11188.eurprd08.prod.outlook.com (2603:10a6:10:571::11)
 by GVXPR08MB11183.eurprd08.prod.outlook.com (2603:10a6:150:1fc::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 10:53:23 +0000
Received: from DU4PR08MB11188.eurprd08.prod.outlook.com
 ([fe80::5926:9f0b:ea5d:24df]) by DU4PR08MB11188.eurprd08.prod.outlook.com
 ([fe80::5926:9f0b:ea5d:24df%5]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 10:53:23 +0000
Message-ID: <cbedfd39-85c7-415c-a401-91795408ebc8@arm.com>
Date: Tue, 30 Sep 2025 11:53:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Transfer List Checksum Correction and Impact on Bloblist
Content-Language: en-GB
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Simon Glass <sjg@chromium.org>, nd <nd@arm.com>
References: <b7c008b2-0a1f-4971-af4e-428faf818d4e@arm.com>
 <ada31617-374d-4f87-97eb-c91da2c4e9b5@arm.com>
 <20250929181133.GM6093@bill-the-cat>
From: Harrison Mutai <harrison.mutai@arm.com>
In-Reply-To: <20250929181133.GM6093@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P123CA0018.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::11) To DU4PR08MB11188.eurprd08.prod.outlook.com
 (2603:10a6:10:571::11)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DU4PR08MB11188:EE_|GVXPR08MB11183:EE_|AMS0EPF000001AE:EE_|GV1PR08MB10730:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d8d25d1-5739-4e9d-dda5-08de000fa969
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?dFVHNTlmcjEvTGZySDNZeG1GazRGTCtrWnFmY293MkFtdFRCc3ZUeGpUUFZw?=
 =?utf-8?B?WHVYeUdHY002WE1reEdCV0cvYmtseWZNbjJaQkt6U1plaXltWC9VbmplcW1B?=
 =?utf-8?B?K3BDbmx1OWtZUkhNaXB5a0xiVDIxRzBxRjdmVjNRU2xmSU9RSVM1VW5LRU9C?=
 =?utf-8?B?TzF6WWxENll4UXJma1dhWVE3QjVHM05neGg1OXQxWnZVSHZNc1RXalNDRU5N?=
 =?utf-8?B?MWFBVG1iNGNqSkJndjlmQWc0TVREcmFjOFhaYk5wOTZVdFNQWFFBRDZvSWZO?=
 =?utf-8?B?SXRCWXpDUHhzOEt3ZDNrbjZES1NjZ05hZFVJaVFiaWpUVGJmbU5ycnVOVDRt?=
 =?utf-8?B?RXFZVXNDVGVPWXBENm9VaDkrVS9RL2VLNW9mRXNkRlYrbFJlY2Y3Y3BVaHQr?=
 =?utf-8?B?eVoxMmc1dWtxYmg1dWU2bkc2Qzd0Q3FWZjVja21wclp4eCtEM0c5UjFVOSt0?=
 =?utf-8?B?UDdpUVVIaTQvK3QxY2xMZHFzQmdGZjY2N05adkJodVY0dkJWQ1l3b3pxSThx?=
 =?utf-8?B?eVQ1Z0hkT1M2bHJYMG9wMEdUQ21zNlAwOFU2SDNUaDFaSDBkZFFUTjRsZG9i?=
 =?utf-8?B?SjY2UUdCSGxLbW1JV1lOOHNIUDhOU3F0R3BEbVFBKzBUN3lvYTRxVG9zS1oy?=
 =?utf-8?B?cmtWT084ejB5THh5Y29VWVU0NmZBQ0hsamQwc1VXSFg3b0UwbGtCRzFXeFNP?=
 =?utf-8?B?K2l0U1Y1K3hvOTRRV1NkZ0NKZHh1T0ZvdU5MS3ROZzNDbEpJUStuRkNpN1RC?=
 =?utf-8?B?QWZGTjVRQi9pV09QTzJURjk5Nzc0TFh5c1FhcitPeDJHYXhmU3FOUWtrL21Q?=
 =?utf-8?B?ekpXL0dnMS96TVo5Qkh4UXlxcDdXM24xOWd6VmlONXgwejFiRzJSM3ZGWGpF?=
 =?utf-8?B?Z1luVmxUaXFiaC95Mmg0VG9UM0U2dkRIcnVqWkYyT09QTG05Y0ZOMTAyNVd4?=
 =?utf-8?B?MXJJYTdlSWFzeGQwYXo5QVpxT1FST0daVEIxQ0ZKYWZTdGhBL2puZmJQSThs?=
 =?utf-8?B?OVRtVCtZN0N6RUoyWlh2QXU3QnNweTB3Y2U5NzhpdTlsbEpoc1JwNStGQVh4?=
 =?utf-8?B?cGxjSXpsdUw2enlJdVFPMEtBeTlTclBXbGpGV1lZOVJVSzVtYlRpemtXMU9w?=
 =?utf-8?B?a3FBYWg3UHBQMi9YdkN3K2VrVjJKMzcyVHZBbnJodTVkd1hFR3ZvU2I2OWRx?=
 =?utf-8?B?UTMrSk03dlN6Qkh6czRtR2JOZFBTSmsxbUpEckZUK1BKcWRjQzVrSmhhSFln?=
 =?utf-8?B?MDRhZW53a0poUnZkZFgxZXdNbldIYWlVTmZCRmIwUUowbmlRUUdtTE9iUGJi?=
 =?utf-8?B?bW5LcUpOVGl0aFpmQ2YyR1ZFblVjSiswKy93cEZ6TElEOEI2Z25JbUtUUHBY?=
 =?utf-8?B?UmdseHdnTWM2aGFtV0pYY1dNN0ZrQmxscHd1aFQ1cWtYZTVJdUliRk5rdWRJ?=
 =?utf-8?B?Um80Zy9YQUhzRmhoRk9ZWURKN3lqNTZoYWh5cFVkS2Q1UTZscDQ0ZEtFMHV3?=
 =?utf-8?B?VkY2Z2hIVm53VEpCeHpWUW5tUFpQN2ozOFBzcm5FTHBsNDZIUVV6MGFXK2Rk?=
 =?utf-8?B?MWE4clJQTkdKNVhVeXRPTGprUWIwYlBNTCtQYkhxeGkyV1VtdGhWcU0xU1RF?=
 =?utf-8?B?Y3E2dVI3U2RRL1JtVUkreUVyWnhUMHNkMHV6bFRRRGJROFJ6OTRzZk1iTjVu?=
 =?utf-8?B?aE5EZk0wMmhIbWl3VWtYbjJWNDZxSldRZ092bUZmWCt4VWpzdlQ1WCtWeUtS?=
 =?utf-8?B?L1lTT1ZiT3lzQjgwQzd1MVgveENWQ2JaMVErTnBVNnlOQXFqT0MvMEZwRURv?=
 =?utf-8?B?NW5GRDIzSHJhSDlsWmJGQisvSTdsZ0h4c1ZlSWNvUyszUHJFWlM0MVBzU3lL?=
 =?utf-8?B?VVR2Z2tCUVRQNXdOVHFMeVoydytnNWVzME1HQmxnNGl2cy9yMG1ObDBUaTBF?=
 =?utf-8?Q?YYhlquDqsgw=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DU4PR08MB11188.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11183
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF000001AE.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: cc8aaae9-4219-4d6f-d63b-08de000f9345
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|1800799024|82310400026|35042699022|36860700013|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFRMTlJieDA0bURDWnd1aUlqSzdtaElMY0N2MUMrRDhtRkhNMzZXNjUzeS9L?=
 =?utf-8?B?dlRBYVY1MGFQOUdjTm15VVdkM1dLaWE3WFdzMk0zWFZvYjVsMjdKc1pmRVNK?=
 =?utf-8?B?UVB0M1ZBeW5yNW9GTm52MTFzUkl5RThhRnVTcUFKSE9EUmx3cThEM0IwNHcr?=
 =?utf-8?B?RGw2b1E0OFh6bUduYitZQnBVazRkSlJSSVlaZG9qQi9iemVtOTRwektORFlw?=
 =?utf-8?B?cnJuTS9QNU5ERllrcDRsUWZpYldxamM0Zmx6N2pEcTExRllpNTNoWmNrR1l0?=
 =?utf-8?B?c2R3OFdOdUgya0xzYWJtbWJIYzRWdDB6QmcxcjNYVmkyaGtWbUJEekptRW8z?=
 =?utf-8?B?VGFTL0l1a0pGZm9jdDVvQmxxZVVGMzlJdDVWeEFTczBxakRIVk5vVUN1eW93?=
 =?utf-8?B?ZUUvdVE4MWl6RzkvSzFudHhuYmFyYmRPcXZXRHozUmkrUjV0TUR4Vld2M25y?=
 =?utf-8?B?eFlIZWVuLy8vYUNZOU9IOWNLV25jaVoreGFvaFk5eG9uRHlLZHdETXd3TGxG?=
 =?utf-8?B?QitaRE51eHYxQXJ6elJDbEhQVld3b3RlWm96c2tsTFR5b1p6cmdOVlNKemho?=
 =?utf-8?B?YVRFWVJOUDJGQ2FOdWNmSjE1Z2EwSGg3Y29rNy9IRmVDd3I3M2tQV0VpcW9u?=
 =?utf-8?B?UGt5M205SmRKa3VmWWNvTjErdXFPY3JpV3p3ZXRoTElVUXE3ZlNQeDNuSG1J?=
 =?utf-8?B?eG9YK1VKbEdUSzdEcElrZytxeDlEbmptUlpIWGhPZytITUdDWUJKbC8vSFRT?=
 =?utf-8?B?NlJLbGQ2MDZLZCtwU1VjdVFzUzNJQWhXMktaSTlxME5iQVFtMEhOdlJycHZN?=
 =?utf-8?B?M1BaellTdkV4OWVIZ2FEVytzS2Q2eU9ZRkNYMGpsWDhrMk96YWpvOFVGbE4x?=
 =?utf-8?B?S01KT2hsQkhBUnpicG1Odkd6SSt2bWp4VmY2clZ1WEZQblFwbDdJTU9KODcr?=
 =?utf-8?B?b1NZbUt6N2IyNXkwbjdvcmFKOWt3NGR6dTgyK2tyWEI0ME4wVEdyL25FTXVM?=
 =?utf-8?B?ejIzK1VnRDFXRkZ1WW51WXg5cVZ5TS92bnlHcEdhWU9LbVQ0MlZXSFl1Zk1G?=
 =?utf-8?B?N1IwRXFaZzBUQk82SHdRZ1NDM2dmSmZCNWt5b1IwUXdLUVREdGtlem5FZUxM?=
 =?utf-8?B?UjY4Q0lVWStlbkJOMWwzMW9Sb2lpdXRNQ1Q0NGViUlVNY3lEY2ExSnVndzVE?=
 =?utf-8?B?QURlTGg4U2ZuSXh4NmIwL052QTVqQ0Zuay96QXhJQUFaNkJQeEVCYitwUjdJ?=
 =?utf-8?B?VUtjenJXSXB4NDlZUVYrT2hySlpXSGdOZ0U4Y1RQMGc4SGJYdXdDSjVueTV3?=
 =?utf-8?B?VzBPb0k1WFFEUS9mTlNibGpoSjc0N1czZTBGaVNaUEMxQmNXN3Y3akxIcEg3?=
 =?utf-8?B?VEdRSjRnb215Njl0NXBVSFBIaFUrbkpGUHJFMzRmT1hJVW1MQjEvUWU4cGhy?=
 =?utf-8?B?YlIxc0thd3I3TUVyYU1pcjFwaTY5UFYvMnQ1b2RHYy9WenZVMHhxSjNKU1ZS?=
 =?utf-8?B?ZUZFYjgyLytqU2xrMVgyWXBLTVVTUjRJVXMycmMzcG5xQW5hYUJyelpIa3gx?=
 =?utf-8?B?Y09ISHdveGZVMnNRTTFEdmc4cko4YVZwbFZ3N1VsQUNidm1PK3FMQ0ExR1BO?=
 =?utf-8?B?SjZKWTNPRldxT3JEcjc0OWFsMzJXOUNkT3VpS3h3NFF4WW1NOS85RjFENjhP?=
 =?utf-8?B?cTlxSzdDMzRpTHRzYVhHeHJ2TDczbm1RdjlrM3puWGpQTWNNWVRpS3dydnB5?=
 =?utf-8?B?RkplY09TcURoTlJON3NjaWoyU00rMi9HWmlwWS9xYVNxM2dmODBqc3l4dk0w?=
 =?utf-8?B?RXJUZStQaGtVM2k1WGpLY1JTTkVaVlV6VXNtbDNpbGs4NUlwZ2QxODdySGts?=
 =?utf-8?B?TC9VajZTSFUxOXFjS09HN0dlVXkzQ0ZpNkRzU0Q4YkZMTVFhVlhtSms1V1dU?=
 =?utf-8?B?Z3U4K0xldTE2SXdQcExsZGpQbHRhNytpNUVoRWdzY0w1NExpb1NWOGlselBT?=
 =?utf-8?B?Z3ZoaXlpWCtJRTltYjFRVzJlUGw1bmJsYm1GWXMyODA4TlpWeFpzV2pWU29v?=
 =?utf-8?Q?49IKMc?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(1800799024)(82310400026)(35042699022)(36860700013)(376014);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 10:53:59.8967 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8d25d1-5739-4e9d-dda5-08de000fa969
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001AE.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10730
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

On 29/09/2025 19:11, Tom Rini wrote:
> On Fri, Sep 26, 2025 at 05:09:53PM +0100, Harrison Mutai wrote:
>> Hi all,
>>
>> We recently applied changes to the transfer list library [1] to correct the
>> checksum calculation. Previously, we used a simple byte-sum approach.
>> However, we later realized this contradicts the Firmware Handoff
>> specification, which states:
>>
>>> The checksum is set to a value such that the XOR over every byte in the
>>> {tl_base_pa, …, tl_base_pa + used_size - 1} address range is equal to 0.
>>
>> This discrepancy creates problems when interoperating with Bloblist.
>> Should Bloblist’s checksum calculation be updated to follow the same
>> XOR-based method?
>>
>> [1]
>> https://review.trustedfirmware.org/c/shared/transfer-list-library/+/42548
> 
> Erm, since this has been out in the wild so to speak, we can't just
> change the algorithm without bumping some cardinal. Or are there yet
> other implementations that were doing what the spec said?
> 

Raymond; Thanks for setting up the handoff tests. The next release for 
TF-A is planned for mid-November [1].

We’ve run into an issue where TF-A requires specific tags from the 
transfer list library, but we can’t consume them due to the recent 
checksum changes.

Tom; As it stands, ours is the only implementation currently using the 
updated checksum algorithm. There are two other consumers - OP-TEE and 
EDK2. OP-TEE already has a patch in upstream review to move to the new 
algorithm [2].

I’ve also reached out to the author of the EDK2 implementation to make 
them aware of the change.

[1] 
https://trustedfirmware-a.readthedocs.io/en/latest/about/release-information.html
[2] https://github.com/OP-TEE/optee_os/pull/7531

