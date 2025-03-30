Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062A8C28B20
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 02:27:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7722480584;
	Mon, 31 Mar 2025 04:27:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="aTOgL3xy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D9EE8144A; Sun, 30 Mar 2025 21:37:13 +0200 (CEST)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.111.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27EE18129B
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 21:37:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerio.borin@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1743363430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RChKk63pkh1af0KWsUXfEQ9rc9cLrc6ooKDjt+4BOlw=;
 b=aTOgL3xyOSQgyhRh4o7RbKZS+vixZ6vnIiNfcXkECOUS0usCpwTXUESpLVikwfwF6SiUjP
 O/a/C2E/LGno0LPshQqKKXFfc5KEgmuqtVvA5xai8rXVHuQwmj67lrVw37maF83CnT0OmD
 bCgtZbsDgE7pkXbrlMMIcU/5aG0ajnA=
Received: from ZRAP278CU002.outbound.protection.outlook.com
 (mail-switzerlandnorthazlp17010005.outbound.protection.outlook.com
 [40.93.85.5]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 de-mta-58-V2YGG4miPnKTM30hJIFWHg-1; Sun, 30 Mar 2025 21:37:09 +0200
X-MC-Unique: V2YGG4miPnKTM30hJIFWHg-1
X-Mimecast-MFC-AGG-ID: V2YGG4miPnKTM30hJIFWHg_1743363429
Received: from GV0P278MB0321.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:30::13)
 by ZR3P278MB1711.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:90::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.54; Sun, 30 Mar
 2025 19:37:07 +0000
Received: from GV0P278MB0321.CHEP278.PROD.OUTLOOK.COM
 ([fe80::797c:7290:661d:7a99]) by GV0P278MB0321.CHEP278.PROD.OUTLOOK.COM
 ([fe80::797c:7290:661d:7a99%6]) with mapi id 15.20.8534.045; Sun, 30 Mar 2025
 19:37:06 +0000
Message-ID: <6570a5ff-ad3d-4371-99db-ae665af4ee16@toradex.com>
Date: Sun, 30 Mar 2025 16:37:00 -0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: fuse: add switch for quiet operation
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Rogerio Guerra Borin <rogerio.borin@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250317225336.2891974-1-rogerio.borin@toradex.com>
 <c45358f6-e84f-4fc6-b5ae-44a3ff5985f1@cherry.de>
From: Rogerio Guerra Borin <rogerio.borin@toradex.com>
In-Reply-To: <c45358f6-e84f-4fc6-b5ae-44a3ff5985f1@cherry.de>
X-ClientProxiedBy: CP6P284CA0067.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:103:1ad::6) To GV0P278MB0321.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:30::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV0P278MB0321:EE_|ZR3P278MB1711:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c2ec021-97d1-486f-0d4f-08dd6fc24142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eldMdGpXbmFMTmdvZzc0SEQwNHZGeXdmT3JHU0NWRjgweUhIeC9kUlowNWJI?=
 =?utf-8?B?NVU3OGxYalYyOTZOcmlFVmYwV1BtMFlVYmNLRWpPenoyVjVCNHBwYkRSY2VV?=
 =?utf-8?B?UXVRZ29SZU9LeGNJNlFxczJQVlg4MjVLTjErQlJwQnpCOEY5ZlJzbm1LeG1U?=
 =?utf-8?B?ME1yd2JKYWM4VVF4UCtJc0JxbWZORUtsQ0hhQnhWWTVEUlhmMzRGK3ZaRm0z?=
 =?utf-8?B?N3diMHFsVUNJc2xuSW1lejZZSUIvbllhMC9EenpnYUhEMERsQjRRZHRtcFUv?=
 =?utf-8?B?UzU3ZW9rc1BOb3JEbEdMcGVpMXZWd3plS3hERnNuS0p2d3E1YVJNYkErZk96?=
 =?utf-8?B?NGdnZ0VuVWZNaWwzYUVkeVhraDlXOGQzZU1uVkI4RWtZSE00WUlFaTQ3bEtV?=
 =?utf-8?B?YU1rRnlZeG5lV3BEakxlbVFKTExWZHJ3TWdJdlIwdWNhcVBPWVROSVp0TXBo?=
 =?utf-8?B?djNZbDNMd2FWM0I1eVhmRk1UQzQ2QWxkc09HQituendObEhodFJqVVkrdFVt?=
 =?utf-8?B?YTVhWnNPWnoySm5sb2lpNTdROHdrU1ROaEFrQmFUUHJuS1NyTUZVRUtDVHgx?=
 =?utf-8?B?Y2MrbGpOb3RXSjZmR24zY3VlRmFkc2Z6M0p3Z28zajV2QUQvd0EzbzB0eDFR?=
 =?utf-8?B?QStmYWdaU28xWWtrQU5oTlFKVGdPcmZHS3VvQnpUbjdYSTZzYml5ZmJNUUZX?=
 =?utf-8?B?azRSUmpGcGZhMUpqL0RFRHlJdFg5TElxeDRGdTRvcWFNV09qOG9RajBVUllH?=
 =?utf-8?B?RHF2cHc3SHFEQTNWMUZsYjRvaU5qMHozVkd0WU81YTlQMUU4OU9qdlNJMkRu?=
 =?utf-8?B?UWpmR0tKclg5ODlsZGFiK09WM3JxNFlOY0NmZXNxWHY1ZzZTU1RXL0lKQkth?=
 =?utf-8?B?dkV6d3E5bENMU0pkNk5OOW1lcDRqcEtjclY2cXFzcnoyU0RHNDlQN1BrYUtL?=
 =?utf-8?B?UTZjNU5yQXZmZUxUZHl4RkhkTTYreVIyTDFadldnQ3JwVXRDVFRVVDdjWkhL?=
 =?utf-8?B?bG9ZdVRqYUp4QXlwOWRlL21na0ZHVXlNcXdKRkc0VzJQWHRuM3hxMHhoVmxj?=
 =?utf-8?B?MWUzdnZ0czlma1JhL01Xa1l6eEF3WEM3ZDdKS2wrQzFpZlhsZjV5dWJUTFlW?=
 =?utf-8?B?M0F4SllHQ25lZi9rcGl0TThJWGZUSkZlNE9OSXl2c3ovdlhGcFV2UEcyZlpH?=
 =?utf-8?B?c1gzYlZYQkdQbkc5amZINmlycCtWdi9kcnJaU2xqdi9QTURCMkw2blNENnpn?=
 =?utf-8?B?UnBzVmp3RXo2TXdjekxjOFM3ZXdDWVVvQTBaWXF4UmJJNHhKUVBaYkdXYWxF?=
 =?utf-8?B?RjRENlpLY1lhR2RqR05sUnlLT2RmNG53Z2FTOHdoZ2NmWC8xMzdmZlpqN2dQ?=
 =?utf-8?B?Yk9oQVJ2R1J6bW80a3BVbUlqaUs1TzRpOXlDWmhodVkxekNwWkdhejNleCtm?=
 =?utf-8?B?dFFjc1BSQ3ZzL3RyZTZFVVg4Q2NZVitWWExlU2E3Rld3ZThYUWNZT0s5Yk5G?=
 =?utf-8?B?RGI5VnFiTkNCbHljWUFRMzBHV2VPaHJQaGFSQWtFenQ3Wnk5bUVhcXZBQ0NE?=
 =?utf-8?B?L0FmQXpWVE51ZFFOeEVCYnhTZVVjK3U2dFBWNjhJQkF6d1k3RllBSXhiSW1v?=
 =?utf-8?B?RGVGM1NkRkhNOUdRNW00aVFlMDBiOWNsM3liTm4zcFdwVU1LelNCV0o1T3Ba?=
 =?utf-8?B?S3lrNFlVNTBtZjNad1l0ekgya1h4THc5Y3NGOFBGb3R5ektiREd0Mm9UTlhy?=
 =?utf-8?B?NUVCTFY4b2Y3SzlJRkdmWkVVT29iQlhKY3JuZGZlamw5L1pZSys0dEVBeWVk?=
 =?utf-8?B?dlIzRld6UDRGMlZjZm5ZMWFtWE41ZXV5SEQ5UU1wT1NmQzhPbzEzV3NEU1pO?=
 =?utf-8?B?d2NSN2tjVjI1THJ3ZWpBTWJpQmhoeFVUVStEbHdEQWFnT3hjeENEQmkxZWlM?=
 =?utf-8?Q?MgA/WipXhaI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV0P278MB0321.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0o0VVVMRHdpajRBZDBLSm9IVHJMK2lOSm5qQWwvVW5nMnREcnNnTlVVUmUw?=
 =?utf-8?B?YnJnTjBERmdrUmdiWkNON3lNUW0zYXZVc0grMS9MNjgzd1pCbnc1OTgxSmtj?=
 =?utf-8?B?NlQvLzEwS1pYWTUrcmU2WFpvSU0rcE9jdEpUZThTS3Ivam9VczBWV0FCUHN4?=
 =?utf-8?B?VlEzRGhtVHowTW5KdERRUzFwdUUxZHJ4TkRTam1oRFVIcEZhdCtkR0RScVd4?=
 =?utf-8?B?Ym4xOSswV3krMFhzRVdKOW5TSHhmckhDQVQwQ0kzUk8wejVMbXZaZk5jT1ND?=
 =?utf-8?B?MG05blF5MHo3dS83U1QxY1BWeTFaY1U2eXkrU3RsMUIzb0FwZnZZZW1uaWpR?=
 =?utf-8?B?RjZQekVvL2s5Q3poaWVUQ3d2TWx4MGthOGRaMU1pTUlaVnhtNG9HMVJST0lv?=
 =?utf-8?B?QURPejMyeU16MEZyZHo1WlJzTFZuZzBXb3lCVXc1QTdlZHAySnN3NmFXRWlL?=
 =?utf-8?B?K2ZHOTM2TUNmeEpvd3gyWmZTc2Q4SnVFWUhNM2thaURmODhzOEtYellyaCt4?=
 =?utf-8?B?Z1BzaEVEamEzc01ZUlZtc3dsTXlNOWFBd3gvZVVLVXdvL05WQXNGUm8zZnVE?=
 =?utf-8?B?anZ1ZDJNc1lwSEtvWkY1YkVWcEpieEVLb0FyZTgrb1FBRTJlaG9DQWVqc2VH?=
 =?utf-8?B?MHQxWHRHYkt3a0Y4MS9qUEV5OFg2dk0yZ2JsVXN6bEVRTk9hOGJ4MjFQaXZ3?=
 =?utf-8?B?RWpnV0Nhb2FDdFQ3Q0ZMOVZXRVdLU2diSUZKekhwcVVadER6Y20xY21mQ0ND?=
 =?utf-8?B?eUk4SXBFQ2swWjhjS3BaNkxqUEd1dWcwZU9QVjNIcW1iTU1pNkpYT1c4YmRR?=
 =?utf-8?B?aFgxRENsL2N6OHByNTlzNmFMd0pHRkJTUWwybE9PSHNFaTVNL3Q2MDlHRllO?=
 =?utf-8?B?ajdhdmZINUd1YXVmUnFLMmlnVVRXTXIrVmwwd2JwcnNSaU5jNUE4MXltQW5M?=
 =?utf-8?B?TFp5UzdpbUt0dWVLYXVwVzBwU0dFbDdWRDZhMUR6MWwzR0o0U1V3YjdwRnhk?=
 =?utf-8?B?akxmRjNBSkdzYWxBbGFtaUZVWUFneEgxOWtyTGNTMWp3L3VCZHYxZVNYbGpz?=
 =?utf-8?B?T20rL3NCZWdBdGhGWTN2QndBU2JIR2trbHQ0OEF0OUpuNFAyTzMvZlp6TWg0?=
 =?utf-8?B?Y0VnSlhFQytZN1ZiRU42d2hDOVBmSzNDeU5NcGc4WHNkUE9IR0xaVTZzNGRL?=
 =?utf-8?B?cElBeTNocFlvKzF1bmhmalRVRG16STl5eTRzY093NkViN3M3ZWFmU2drYk83?=
 =?utf-8?B?TWpSVkQ1OVJuR0NLWXp3V3JwMTNuZXl3NnZTYmVtQ2t1VXZoTmpOSEI0RTlB?=
 =?utf-8?B?c00rVjBOK3p6QXJ3K05xcUhhV3JYSHJaa2pyV1RHWU9yeEhFV1pZVHFCZ3ky?=
 =?utf-8?B?M3prRHJocFJPL1NUZjVPRzJoQkFBUmVkTklPeVpleTFwcjY0Nkx3NmhSYldS?=
 =?utf-8?B?cjBCY3VFN3NiRDArSnFGcS9DZGtraXRrNmtrb3IxNzVvcGp1dTFkWXBmYlpU?=
 =?utf-8?B?eUFRQkREZndvTUVRMmpvY1ZLc20yODdYMXZPU2p0QWpVRHdKN3dBc3d2K3Fj?=
 =?utf-8?B?M2hwaHNGTjdKL1VVUE5hVzF0OUlieThiUzVNbVVqMjI2NXdJamxQVDNxWU5r?=
 =?utf-8?B?Vkd4UHVtRWI2Z2hEUllHSkZ1Z3pPaktPM0xaWDJmZVBMVGhTWWd6TGx2aU1z?=
 =?utf-8?B?N3FaSXVzbzFua1d0TXNkSU9PU1EvSGNvVy9tZUtzU2RyZ1lzTUU0M1B1R0h5?=
 =?utf-8?B?WXc0b3VKZElFS3Z1TTJWL0xNTTBydEkwdTFmYTNnRlZiazdZR3RkSnJGMlNr?=
 =?utf-8?B?U25abGdoYURXcWNoc0tXZ05VeTU1WVp2TUpaUzNrMjZsbEZuN21pRmxBeTJv?=
 =?utf-8?B?Y3pMckRLMDY2UEpDUk1kQmNVb1M5TWxac3pXeGRvdURKYSt1ZnFrQ2hmWTZa?=
 =?utf-8?B?dElGeVpjb3hsbm0yYVowQWNUaTUzVmhPek5wdGxoZWFINitYZG1TeHBtWGFw?=
 =?utf-8?B?Z0FFa0x5VEFUV0FzVnRZMUovZEc1ZkFYTkRFYzhHQzV6WG9kY2JmTUN4ckxP?=
 =?utf-8?B?bXhaSk1jSVoveEJYTlNPY2xHaE53VTF5RDlqai9RVTBhVGswc2JGVUVod2w0?=
 =?utf-8?B?MDEwenB0aFBYbTlwVXJSN3ZncjlNM3Z3Rmx2WVRqNHp6Z1VWQkNxWGdJY3VR?=
 =?utf-8?B?MUE9PQ==?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c2ec021-97d1-486f-0d4f-08dd6fc24142
X-MS-Exchange-CrossTenant-AuthSource: GV0P278MB0321.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2025 19:37:06.8779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jiHkclE7J2I/tpFj03Q1t/BRhsPscyMHCFyA27sHVV3nFQIeQzYSIjP7jJgCuvqsuk4nSTNRmZLykoWmzDjwUHq0Rx4SFydy7aZeJ/X5J1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR3P278MB1711
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Cp4GXrGOoIlqu7-JI5gAgCJGYVMgboAGq3YObe4y0fs_1743363429
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 31 Mar 2025 04:27:45 +0200
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

Hello Quentin,

Thanks for you feedback.

On 3/24/25 06:55, Quentin Schulz wrote:
> I think this is a reasonable expectation. I'm wondering if we shouldn't=
=20
> think about using the log architecture we have to have a generic=20
> solution rather than expecting each command driver to handle (possibly=20
> in their own way) a quiet flag.
>=20
> https://docs.u-boot.org/en/latest/develop/logging.html
>=20
> The idea I have in mind is that we could dynamically set the loglevel=20
> for a specific command driver (or at least for the command subsystem (by=
=20
> e.g. defining an LOG_CATEGORY LOGC_CMD) and use log_* functions in the=20
> command driver rather than IF_NOT_QUIET() below. This would also allow=20
> different log levels to be used. Maybe there's something to be done with=
=20
> filters, or something new needs to be added to set the log level for a=20
> category maybe? I don't know, not too verse in our log system.
>=20
> Another option to have a generic logic would be to depend on an=20
> environment variable instead of needing to expand each command driver's=
=20
> logic.

That's a great idea. I'll look into it and get back when I have something.

Regards,
Rogerio

