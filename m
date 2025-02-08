Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34DFC02198
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 12:00:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2290807D9;
	Sat,  8 Feb 2025 13:00:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="ofOhwNI6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8713A80805; Sat,  8 Feb 2025 13:00:00 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20722.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::722])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47D7D80756
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 12:59:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josua@solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ggkq+9vyUjdE2rX5VbTrDlT7lauKWDQATl4wjEHM/kGZHUj1aT8UwkrU7pG2IUYWSGnH+wYCdhMK3D5jlXRZ90Qq28CKhVfqcv4QBp2DgVGWv8ZO6S285kSWgby0r4vVM0T6wuQukW5j74wJxPMDd2NHxGBpb5afNrngOojkW0rjoiWvQBpacJ+a9ElLF7ORJlHweeKQHxdOGaobjTf0tJuSH/vZAOoGYX4uf4s5Zn7GBA2d97jr81aMH7+FCgzBEgupobj15Qhtq2fL6ZRRhJj28T4SBHeBzGwKc/4DEBu68N2DQ5f4TWoa0pK9u85mzp/FjDake0nKxcAxxTWk3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GnywAphIOjkSCtIPpbP5XsIE7B4kehVMMe5cJUOC6c=;
 b=x4ipKRtSLPrmcPC6SuHwjNLZzFPnwdh30skTCfyhpcZZfwikFFYHmp/FBqjnk5011x/UAXh8WlS9Zhilnx3CqcqO1B/z66yk5fqQF2kBJSRZHQgkilWpPG1I+nULKQhy9Fx9vQHxV6H+yWHz1rzIcog4RuznLFn7JnbuMQBvm6bc75nmUJPcsZMcrtj9wWw6+ct2JMh+Ys7YdKZ1wy4KH7Mic8TfuGTR3Qi82oxq71S5lbQp79jL6jDgInHvJVDnExvXJcGRKHoX5BhIV1GlzHvn3KnnqVC2UU4qRvBB/d54c0MDvUaqQLlf9ZKqN7w7eNTYcnEnjzQfrrGNzhqxXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GnywAphIOjkSCtIPpbP5XsIE7B4kehVMMe5cJUOC6c=;
 b=ofOhwNI6vz0Vyp4mrAJqYD+iKcsqTmsKY66zHmycxaLmwDBtUhaNPNhN3M8mNvqWF44Eiqcp8zZ9NMRlDa8P3pqPfodwImxYMAe5+atRV2yUpf6RG+Np4f35x+kdfe/4sFPc7dQz4vkdNykgPJKLoGHOPNZsYLmtCmVbYew88Ps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AS1PR04MB9239.eurprd04.prod.outlook.com (2603:10a6:20b:4c5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Sat, 8 Feb
 2025 11:59:56 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%6]) with mapi id 15.20.8422.012; Sat, 8 Feb 2025
 11:59:56 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sat, 08 Feb 2025 12:59:54 +0100
Subject: [PATCH] configs: clearfog,helios4: disable sdhci sdma
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250208-a388-kerneladdr-v1-1-1ed91f642c2d@solid-run.com>
X-B4-Tracking: v=1; b=H4sIADlHp2cC/x3MQQqAIBBA0avErBNsTJKuEi0spxoKixEikO6et
 HyL/zMkEqYEfZVB6ObEZyxo6grmzceVFIdiQI1Wo+6UN86pnSTS4UMQhaY1bppMi42FUl1CCz/
 /cRjf9wPo8W1nYQAAAA==
X-Change-ID: 20250207-a388-kerneladdr-23438bb34215
To: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>, 
 Dennis Gilmore <dgilmore@redhat.com>
Cc: u-boot@lists.denx.de, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: FR0P281CA0196.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::18) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|AS1PR04MB9239:EE_
X-MS-Office365-Filtering-Correlation-Id: c1614e3c-f780-4149-2b8d-08dd48381aa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QU5mbU5vSWFqUEJuVm1xK294bzRqNlFveEZTR01IU1VRZmVTb1hJWDZhLzAw?=
 =?utf-8?B?OXgrQTg4WkdkSjZac2pzMEw4NklOS3o4K0E5T1FRSnp2YkZ6eHlZRjlQRmxz?=
 =?utf-8?B?MXh2KzhycENLNWd4UE0yd0lUbEliK1Q1bnlIWFhTSktWZFFGKzRFb0FJZkND?=
 =?utf-8?B?NWxHQjZRT0xVUHBRUjZ3eXZBVWZWa0ZSRStSRlllbFJiMi9pQmJycnNsQWdx?=
 =?utf-8?B?Tm9rcDNaekVJUDBKdDlwYmd6azNXTmppZ0p4Z29ac1NEd2VYalM4SnFrVmlP?=
 =?utf-8?B?dloyS0srbWdyWllXKzhJd2d0TGk2ZUdteEw1dEd3L0dKaWkvdFhycjdpbnJD?=
 =?utf-8?B?c2tyejc0VUw0NlVEQS9LNWZVSUFabHh0REd3MnlDbjJlYVNlWm16ckFNVmU2?=
 =?utf-8?B?Zi9KbnRuSnFIS01kNDZmUXV1QkFjWXE2emZrOWVXTDZIVmVvMmRPY3FpRUJw?=
 =?utf-8?B?MDhOdjB1Q0QxOVRqQXpoVW5MeDhEYXl0Z2VYUGRybnpXY01BQUlzL1VpYitE?=
 =?utf-8?B?eFI0TmdUblAwTnV3eXc0OWU2eEN6M1VBbUdFUmwxUUsyakpNQnozRmdHb2dF?=
 =?utf-8?B?S1ZydFdDaERYRHk1RW5hUnpvd0xHcXZKV0dqZlpNYUs4dzE0bWk2allBOTQ0?=
 =?utf-8?B?eWVXSUZnVW1CNlA0OVozenFTOU1GZHpORTdPbjFZQUFaSnpwVFZzeUJvTDVB?=
 =?utf-8?B?ekgxRStxUVF5UlIxYkFmQzlaVEM3clIwSGl5OXdXbXgzQk9UUDJXQ1Vad0tM?=
 =?utf-8?B?MkI0T2U3RlIxZllSWis4NEVubFRrVzNnaFN6TEF3MmhzY25vYVptRWs1RWtU?=
 =?utf-8?B?bmVuc2ppemk0MktyUURVZTRZdG1NQVRaaENHS0w4Mi9iMCtuaUR6WXRFK21Z?=
 =?utf-8?B?eEVmaFZFMXpmMkgxbFhHNG9mckRGMXgvSmx5ay91VkxsdUlPUndWeC9ET2FG?=
 =?utf-8?B?REMxQzNLWFFnTWpFUjBCK216MEpyNWhlZkNPNGdudEQxNFZmaTc0QUxnS0tN?=
 =?utf-8?B?c1JybFRpTDZ3eHBJcVNNN2pGenVKd0VZWlNucHl4NW1TdlNGT0FDZ3VzZTU1?=
 =?utf-8?B?MHZzQ0k4RzJEcnpuanNiSHVXeHJpMEg1bHkxRVJUZCtCQUhtcGFPb2xuZDN2?=
 =?utf-8?B?VWliNC9SbnAwWHF6MTZkbFp0R09jZm9EMlpFRWlzeW5qTVZDaGl3MmhPWlhO?=
 =?utf-8?B?WkFPT1V2TWR1T01kcElOS2xrRDloc01wcmVXYm9JdkI2RzNHcXhHcVBSUitP?=
 =?utf-8?B?NDJWK0Y4NUtzRWxPRjNybmdCekE5SVd4dXBYNnpJakZueTRkK1BnNTdRb29O?=
 =?utf-8?B?NzZaTllGUXl6clZWZmRsK2VhcnpWVzUrWkMvN052VTc3VFhnM0h1OW1PUER0?=
 =?utf-8?B?TWlwRERaOEp1QlVoUjFSTlN5alB1SU5CSUt6c05tTXdvVHh6VVZheDNBa0I2?=
 =?utf-8?B?WGxOUjZXbHNMYm53eVkxTk9NM0twdldaV09WSkROU0ZKWjVKTWpGUGYrMUNK?=
 =?utf-8?B?RDArY2tEcEVZQzRvSC9XVFc2N3lJT0NqeXROVDZnVWpKYWQveGdaRDk0Sm1O?=
 =?utf-8?B?QjJGRklaTDAyQURtSCtJbjg5Y2tlVno5aHpWbTRLREtLMDhXRWNaTEhFeWc4?=
 =?utf-8?B?b0o5TWQvNW1DTklRRGUvenR2ZE9vYUdRZGJzQVdGdnFwVDJRRXJXUFEreEJS?=
 =?utf-8?B?SklYVGJvdEQ1dDJuSTZDYzZpc3Q3cUFrcHNxcHFEOU9McTNaSFBmTVFTd3lj?=
 =?utf-8?B?endPSVQ1WHRNSGxrWVQ2S0FQMnExbzZKWlQ2bnZnNHhiZ0UwSS9NUHo3anZz?=
 =?utf-8?B?alF4T2FLdDFUWStvbnZxZ3BZRzdudFBXck5aQ0YvSDlNNTlXUlRFYnlRYTFt?=
 =?utf-8?B?MFUwcmZsaTRrZU42K0FWcXNXd2R0cjd6TkwxZGVXbGovejR6OURKa0dmdHpK?=
 =?utf-8?Q?qAhZw0WrveLGfHA8iNNgkYCGTfR7Btxt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB7586.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnpiZ1ozVFA2SXNST3BBaUliVytaRmtQOTZLaExTeGVwQ3NLc29KVGxOZUJa?=
 =?utf-8?B?TVcvNHhhY1BaN0J2dm1nandzbmYvUXp6VTFWWXM1N2FFREZHOUNLWFBWU3VS?=
 =?utf-8?B?TExHWldsVUJobGNZRER0Y2xiVU5pUDdiY01leGUrR1R0L0trcVlFajdlRXFh?=
 =?utf-8?B?ODZxUHJsKy9uQWg2MHVBb1B5RklSSFlnS2ZIQVZRVUJ0c2hpZWx5eGJtRWlV?=
 =?utf-8?B?SUZiK1JuREMvanhvVVQ0RkVkeXZDVmphd2VWNU56M0c5amE2ZHlsbVhmblFR?=
 =?utf-8?B?R0w4ZnA1U3plTHY1REt6ejRCMEhwNmF4RDljd2xqd3hqa29HcFlubElYMkdT?=
 =?utf-8?B?UDZCUVpJK3ZoVWQwU2NnZVRoaDNabzFGYllMWnRNTG1xM24zK2c2M24yVXVs?=
 =?utf-8?B?SDM3OGlXV3laNllKZjdYa0o4clpUejM5UDVkRkNSRmNVb0hPcktZUHI4UjRI?=
 =?utf-8?B?YVZ4c0t3M01ESFR4MmlXZDJTdVFaNHZNbVR5Tlk0Wjh3Zm8xVWdBNWFteU54?=
 =?utf-8?B?Z3lZSHU1dzBPVU4xUDlyVmxBejdDbU4wakt3S2dWT1Zsb0g1T3lQandPemsy?=
 =?utf-8?B?bFpoelVVa3NWem1UZnBqdUlVNzVWcEdzTGhKekRmelN1R1FLUUNTZDU4NmpX?=
 =?utf-8?B?UVQ0dXFmZTVnSnUzRjJyS1JBOUVrUDlCaHhiV2FYTVUxc20xRnhTdy9saC9l?=
 =?utf-8?B?NFNHa3czc2QzdWxyMFliY3BLUXhaM1dqRExRbzlFd1Y3WkVWOEE3V1U1Vlo2?=
 =?utf-8?B?a04vYUkvY1NsQzgveDhOQnhOVXVsV0hqWkZzUzdNT2tCYmlBVFp6Ui9MYm9i?=
 =?utf-8?B?U2dZVkRzeXVXY0VZc1ozTnVZYlowSk0wNXh2Sk1aOW0zTXhLQ2FwREtFRGZ6?=
 =?utf-8?B?N3ZBaFpoaG1RK2lEQXcwMGxJQ1pzeXJucG5Qc3VxZC8zMlQvcHZyUUpzL2Rl?=
 =?utf-8?B?R0xPMjhYM2ZTRUdjMEtnMERsTnNxRnkwV0c3Tm9ob3k2czVlejhWOEpVMGUr?=
 =?utf-8?B?dElnTFlPNTV0aUZrbWJraHNDQ2pjWnh6QldLQ1ppa1V4K0RJUEp0RjhiMjAv?=
 =?utf-8?B?MDBzaTM1L0ZhbTZPVVBoZDNyek9FSU1VYnVJVnRnbFJpRDVUNm56QStOS2ZQ?=
 =?utf-8?B?MFFxYXIrRXQ3bmNwa3d0amdQdXJzSnFWTEZyREM2N0VQcmhTNVJOYTg0QzBS?=
 =?utf-8?B?Y2Qvems2a1RzNVZpWUw1bTJhaFNwNndtd0s4R2krTmxPMGtVRUV0aEtXRzZZ?=
 =?utf-8?B?SDZOeFIwM3BnS04xSzcvYkVBQ3VRNmRyZm05dTAzY2dldFgrQi9UeXVjeFNt?=
 =?utf-8?B?YnoxZk5hZS9YYVladGdyaFdFU3dlMXV6bFprTU1aT2JwMWh1bXk3ZXdidWN5?=
 =?utf-8?B?WlREeDhvU3hlV1lSWlVmdE41ZWJtUUxrZFRUdUgyMitMdWV5TG94bjQwYUN5?=
 =?utf-8?B?OWxjL3RtRUpiZ3RheVVxNERUYTJvVG1BeTBlbHBlaVJGa0YyYjNIRDVxRzVs?=
 =?utf-8?B?VGpRUHk3M3RqRENGYW94a1Y0UnFiKy81RTNyVG5yRklDV1JRcHl1cmxrV0NY?=
 =?utf-8?B?QWlrVmtITFVTMEdsT0xEZkRDczBIaUhtZXUxYndjNjgyN2MyNmZxVTZXVWxE?=
 =?utf-8?B?UjNpVFlld3JEbGg5dGhMRy9JRjU0cmp2U01SSE95U0NtYzNmMjcra3ZoWTZ4?=
 =?utf-8?B?bUdPczVBTkZlc2RUUHNYbjBOalZIZWFEUDhHZXVlRjhmcDJnOU9VUGc2VTl5?=
 =?utf-8?B?SHE5a0hySUE4Z3FGSnVNV2gvTTdNYXIydHQvbFZaUkhCZlhJaUFqaW40UUF5?=
 =?utf-8?B?OTc1RG8xcU5QaEtrZHN2YkpLRVpYUHVvbFBVMkZ6QTl3N3hQditKQnl4TmZP?=
 =?utf-8?B?QS9UK1FjMk9XUnZLVHBFUlg4Ym1KWUtOaWVvOXhEU3I1dFhhODRMSlpMN0Vt?=
 =?utf-8?B?YW5zM2R1VVNVRHQ1Sm1ZZHZUaHI1UlNvNVRTQy9sNnB1cXRQUloyaUp2MUJD?=
 =?utf-8?B?TUZQL2szdHZRMWZraElvREM2UlN1VlFSYTFZYTFxZ3FjSk5nc21ydE9XSzR1?=
 =?utf-8?B?cFF5VmNaMm1ydTN4QXVITGtCOUI0S3NuSHE3eVRraXI3Z2hMWDRxTnF3UStj?=
 =?utf-8?Q?xdy+xuZc5NW511GW13rm6GSSZ?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1614e3c-f780-4149-2b8d-08dd48381aa5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2025 11:59:56.0658 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: meYPKBnID9c3XpWyHVEVMuzg1FnSgIOl6sPz4Dtx6BNxkc3yPts6kO4yCtxpW1s5EuZtmX/wh6X/L0o5orgs/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9239
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

Testing has shown that loading large initramfs causes data corruption
where the kernel image had been loaded to.
Debian 12 installation using a 17M initramfs boots fine, but the final
system with an initramfs of 27M obscurely fails to boot with bootz
reporting "Bad magic!".
Inspecting kernel_addr_r after this failed boot attempt does show
garbage in place of the expected zimage header.

The problem seems to occur on armada 388 only when sdhci sdma is enabled
in defconfig. Other armada boards such as turris omnia did not enable
the option.

Remove sdhci sdma from defconfig for now as a workaround.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 configs/clearfog_defconfig     | 1 -
 configs/clearfog_spi_defconfig | 1 -
 configs/helios4_defconfig      | 1 -
 3 files changed, 3 deletions(-)

diff --git a/configs/clearfog_defconfig b/configs/clearfog_defconfig
index 6f6597c5331f4aadf827b40a8f2864722585fda9..a139d7cb463167f59931fd4a151a309c29ba3a44 100644
--- a/configs/clearfog_defconfig
+++ b/configs/clearfog_defconfig
@@ -60,7 +60,6 @@ CONFIG_SYS_I2C_MVTWSI=y
 CONFIG_I2C_EEPROM=y
 CONFIG_SPL_I2C_EEPROM=y
 CONFIG_MMC_SDHCI=y
-CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_MV=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
diff --git a/configs/clearfog_spi_defconfig b/configs/clearfog_spi_defconfig
index d3de1657c09ac8afb7655094d88b649f711e36b7..85be40db48536ca153d0dae8eda69532745b5526 100644
--- a/configs/clearfog_spi_defconfig
+++ b/configs/clearfog_spi_defconfig
@@ -61,7 +61,6 @@ CONFIG_I2C_EEPROM=y
 CONFIG_SPL_I2C_EEPROM=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_SDHCI=y
-CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_MV=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
diff --git a/configs/helios4_defconfig b/configs/helios4_defconfig
index 2778cb7dc8680191155582da14a21b6a521fdef1..baf7c9396362fd9f6a8e527e27e8ad75a1fe643e 100644
--- a/configs/helios4_defconfig
+++ b/configs/helios4_defconfig
@@ -60,7 +60,6 @@ CONFIG_SYS_I2C_MVTWSI=y
 CONFIG_I2C_EEPROM=y
 CONFIG_SPL_I2C_EEPROM=y
 CONFIG_MMC_SDHCI=y
-CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_MV=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y

---
base-commit: ac3dcb0c2710c4917d93d6d2eb34dbfb00516bc2
change-id: 20250207-a388-kerneladdr-23438bb34215

Best regards,
-- 
Josua Mayer <josua@solid-run.com>

