Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882C0C5DF81
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 16:33:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 151EB408AC;
	Tue, 18 Aug 2026 16:33:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4QycODfJOoOl; Tue, 18 Aug 2026 16:33:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2FC29408AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787070790;
	bh=+PBWxZlj2rlGQmWAq6EZ36ewj0P/FlDZs4UjMzM7QSI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K2jl9uqVnOSVYqEOdFJqhXGbk1qziN9S6BDHpuuK+IfTwJvAKYw1tlaAUHdWYBb4H
	 QROu/bxfF1D8Q1RHO51ArG5zYs46s/M4ck83m/CC4bHIfEZaZNC1QscEufCVyfUM3Z
	 vefmH+gbtPohzy0F97xunBSAKEF8Zq4sEkjw9KtpHh2B7t23lv1L0a+gb3kEBms85Z
	 hcLlNS9Y0EPoTsl+os3WZkMXo03ZDUFfg9kwxEgkdrkjeyDG1LgiCi/mEyPzVTDKJS
	 3H6DtqKcyR4hbKPD4mRaRBsTXKeaCYO5QvqUa1cjAKCSTg7eiN4K9g7pu8FsBGFp5e
	 ZMpBIGtoIkbRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2FC29408AF;
	Tue, 18 Aug 2026 16:33:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 335CD194
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 16:33:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 18F6F8111E
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 16:33:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 48tl-bEpxU3U for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 16:33:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c110::3;
 helo=bn8pr05cu002.outbound.protection.outlook.com;
 envelope-from=tien.fong.chee@altera.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 047FE810D6
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 047FE810D6
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=JhcjL91s
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 047FE810D6
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 16:33:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RzUpr00EkJclFK5SlCOjIGLK0sn6hXJmx2QvPvb+cK25POof8f1e0ktEbPK1CcIDv8QSZh9icJbL6rHvf59j+m6mIXpSTfD8S67t6GA7jao+uKi9Y9KTRVN7IaqWRmAvrcSuj7Y6k9mm0y8Wn81HD9zJKJ4PAh19KiBJtj1v28bvzSj2PtQelnfmmGNyOcmFUGDRCbKiPJWupGRZgxAr5hONaOPt3ZDwd7vLRx6VRnJXaEEhpk8tMlfYmfQSarOk8aPEzIPGdYHA7Td9PPIOkBOUiAyGnrjM9E53NdkG7u4jOwqTqTPQPnvEcQaT2QwchSaZy4UVIp7MpofhnJUTSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+PBWxZlj2rlGQmWAq6EZ36ewj0P/FlDZs4UjMzM7QSI=;
 b=Z6cuNkaAzSgW7VMMIh5b/wcSlMBBh1zBg4m8MvO2Gl9HUUJLaOHbMNQtDbko7xrnH7KwXbdUrABWJXnkXWLfaBUZ5DIMkZsemFoS64sHvg0hPzLJlGWxpULlL12GtEhQ9RIWLG9PyJ6oO++m6Sb7YaYMCGHTRJIQy/gy2OZ0pDeN0R0Vgh87dqBaCpSSUzrMijpGsNImaru0QACCOjaxPiDxCwIA6DHTUKuupc1caE+8l3Wvodxmv8qzfRJ+VdBka8QzpdQ/DWI/YKof9IasiVErdj65RZNvdZ7xlYleNlhQsySDTws2cocohZWnjcFT7oqPFLYvKv7XMOk0Dxy+IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PBWxZlj2rlGQmWAq6EZ36ewj0P/FlDZs4UjMzM7QSI=;
 b=JhcjL91sMcZS/krlN7+5cslUNAdx1492xoUeBVxpqF1wOmMLkX9vHnPtw1NDWOQoo3uhjNhDCE6ZDgZW1mKikYWUheBbu2kxxVlR0H4ssO4rhPBEvns5FeDUOwHBojoyotu1NL6ckQR1vVChGA1BtSuBzmRKQI5GGAVGgqwB534yBeH8fbHN0qXz4n2U9GB/VqA9kK3mKnJ/xOVoUz/vAKPpY18smrzvbSNDT/uLsBZ3KXGJgySxabu0gVZcENNzTIf58o5o07ntcdKcgjVTQBbj6whPgbOuaIN6+zLxK8m7iXF3PU8PMwOiiSnPvS94ovsK/9ejiN1pmGLovwVhaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB8229.namprd03.prod.outlook.com (2603:10b6:806:465::17)
 by MW4PR03MB6667.namprd03.prod.outlook.com (2603:10b6:303:122::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 16:33:00 +0000
Received: from SA3PR03MB8229.namprd03.prod.outlook.com
 ([fe80::2802:a21d:f4ad:97]) by SA3PR03MB8229.namprd03.prod.outlook.com
 ([fe80::2802:a21d:f4ad:97%7]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 16:32:59 +0000
Message-ID: <b1ccb10b-2e65-425f-a029-b443eaf6767c@altera.com>
Date: Wed, 19 Aug 2026 00:32:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] SoCFPGA updates for next (2026-08-17)
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>, Brian Sune <briansune@gmail.com>,
 Tze Yee Ng <tzeyee.ng@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Boon Khai Ng <boon.khai.ng@altera.com>
References: <cfa5d305-908e-4ab5-8725-47f287fb5e54@altera.com>
 <20260817182735.GQ3297518@bill-the-cat>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260817182735.GQ3297518@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:196::19) To SA3PR03MB8229.namprd03.prod.outlook.com
 (2603:10b6:806:465::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB8229:EE_|MW4PR03MB6667:EE_
X-MS-Office365-Filtering-Correlation-Id: bfc7a4f2-b958-4b65-5219-08defd465dbf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|56012099006|10067099003|4143699003|11063799006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 2N7OT/2kQ4chmXDcRiBK5b9xZgxJE5OMshCgJf77FJYVT7L4JzH6htADngMDls01Z6wlF5RR4J4XY9pb7WKSLOh5DEiU9vGE2vCY+DvVWK9wQ1B2OIVb/I7fWnEJp31YBhG0Hdxww/0NIBXJKwx10CorAvpwyBNvWp+XdLnh98EgoYsjzxPMWE5rZf2lStEm9MesMqpErnj7/C5OT04CoAIlTvjFn8NU9ueglViqSpIuhON3onV7r+rv9Hv/V5N0aoQoZagqmbGoHcsqc/E8aEc54szKgMRMyWSv9ycMTM4nF5RXdKsAkIJZcsoEEPiDeJn340Dh5Odzt0Xxk60wSvTO13rmWxq7zXVdrASx9X/bWDFUrg5mJ+043wglbue3/Y30YOHPAc+l2J+QYaM9me5eXy7+2ShbtlSCLU54D6qn0a20LE7FuB25pAbhZN7NpP8JhPDSoHD9ncaLgQp283c2g0lMTSmejIySEmQhSMWD7f6opulRrt6BHSHVy9adYn9GZBugm+11KLubcEtaebpUVYnln9HzwdFSvr4JkH6/C7AtP+L+nUvDLlpA24OMTrr5OB5Bes4pO6CZTsjeDsnR/M0uBjhihiWn/WxLep8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB8229.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2JJTVFtQzJGMW42MlVGV0h5YjZwTzRUTlJ0R1Q0Slc5a1hMdStBSnMxbktr?=
 =?utf-8?B?eUMwbzZuOFZQejRQRTNwdGdzYjF0WGdPZ1Rib3VpRG81NlF6b2tOQWhQdXgx?=
 =?utf-8?B?YktLbUpnZS9jazg2SzNJUWhhN3QwNEtkZkwvTHNhZ2JYbGt4TjhCT1BDSGhz?=
 =?utf-8?B?WDNQZnJaaXNDaEUrQmNWWEVJanYrVDNKNFRvTjhFZmllVFVlQ2xlMThQWW9r?=
 =?utf-8?B?dVhqY01yUkZoS0JSdElwK2VwK0lETkttZ05pU0oxNGpBeHgwd2lYUXhJWVYx?=
 =?utf-8?B?c0VZcmc1UkorZStsNEZkUE5RSXJpTnlZdVdZT3RVUXp6ZFFoMTMrUHExTzFr?=
 =?utf-8?B?L1gvYmtydlM1THNSZzlxbnZsQzFyWUJjd2QyR2xWT3g0MUtqTGIrMENORFhN?=
 =?utf-8?B?Z0tGSjdRSDdLdm45WnhXNnZjNmp1L1Z4bXhDU0JpOXpSeVdzZUU1OHVQR1RK?=
 =?utf-8?B?S3RSaG5oSVFWaEdDR0EwTXYvK3NaQ0FBWE9ldnp0WWExZi9aN3hvM1hxY3hG?=
 =?utf-8?B?V3ZlbjlIWTljdVF1TTBYQkZVWndYZXlVQWtwWmJSWGhvOTBVQVpMT0Z5SGFU?=
 =?utf-8?B?ek9pK0hFSVdJNGxwZFVoQ2RhVmt2b2d2V2FSMXdtS3RIdjFlcThZVmJvbzN3?=
 =?utf-8?B?LzF3T2VGMnJhZDhwUW5GdFRJbTVTVFlUYzRkYkZ5YS9mWU5rc0tNUUt6OWYw?=
 =?utf-8?B?K09jU3hmZWJrTUF3L0R5UmpJUXdYMkRzVFQxWERxWGtwN2E3ek5qQkYvbHE4?=
 =?utf-8?B?RlBaRU92RnVXZ0JCTjBEZHpNa1hMTGxiSm0vR3A0SnJYbkRyQ2FrdFJ0Z0h3?=
 =?utf-8?B?bUNJelF5VXhEY2hVOUlyNkZsNEJiOHFqWEU5RFNqWVhyRWRHNitYelo5ZVlI?=
 =?utf-8?B?b1lvMjlLbmhHSDZOU1ozRENuM1NoZ1N6Sm1FbS9TMUsvdlplaFpOUVJuNWdZ?=
 =?utf-8?B?RFNMMEJ4UDNNUXNkM0VqcjhFdHNQc0x0d2dRb2VzVlpmS0YybTNDK1E2K2JF?=
 =?utf-8?B?a0NEQXl4WUJtM2lZV0dLelhrU2tsVk9HOHJuQk1kdFYwMUV1VmNremljc3F2?=
 =?utf-8?B?b2NxcUJSRkhUWlNhTnY0cEg0OWF0cWFDOHc0c2lVbU5lR1ArZlUreXE5YUhp?=
 =?utf-8?B?WXJxdUlGUGJsZ2V5Zk9UbjlRUDRiNm5UWTQ2S042UElqT1NCeE1UaGJNWVRT?=
 =?utf-8?B?WXhIRnJjT1lNV051VUNlRXJyS1Zxb29BK3dOb2w0RVNvdlhxYXVTeUJMYXNS?=
 =?utf-8?B?OEUrcDd6dUMzaG1sNVlGc2U2UkZYdU1kT0xpRmxjZm4yU2J6TE9XaHFiK1JJ?=
 =?utf-8?B?M0xIajN2ZkFuWFFCTENYNElEdWsxK1dtQWtlMk1HZE9KdlBoR0kvNERxWEti?=
 =?utf-8?B?Sk9hL1R2Q012WXY5KzNDenlvUTZEQXJCK3o4KzhNZzBieXgxeGJTSWFNVWRB?=
 =?utf-8?B?RHAxTFhQT1k5a0VNaUZYKzc3anhrZW5BQUFnK09NR3FONjhoUnBhRXRaUVlB?=
 =?utf-8?B?R2dFaTBOTVhReVBZL1BEZnc2NHNNODc0bElGS2c3RUhBVVZTSjkreDFLVklK?=
 =?utf-8?B?ZVVHRlYxZkZ2ZUdJU1hwSjZRZDU0NVZTd2lVajFXZVFPVU9HVG91MlFFRVc1?=
 =?utf-8?B?OWZYUUo3TjdIVlZsMVhnZ3Nad2UrcG9XR0RNWTBJeHJIMTlMNU80TlZOVzJh?=
 =?utf-8?B?aUJGNCtHejFOKzhldUZ1WnlBMU1SY3lkdzc1MUYrM1hNelVPS0prV2xidVhO?=
 =?utf-8?B?ZDVjbXdOcEl0ZEUxSjAxU2kvUjlXNGhxcmZWSk9rKzdXeWVWYnJqQXJrQ2dE?=
 =?utf-8?B?QW4vVXR0TlJPMkMrZUIydGh6d2I4K0tRdGtYU3RmQkVHaHhmQmRSaVdmWkR4?=
 =?utf-8?B?c2ZDVk9yY1RMUXJZc1kyN0RJWWtrK21kb2tIWldTRU1QUWF0d1pNM0F5bkw3?=
 =?utf-8?B?ZjB4Z08zcnloYVd1N0xCVmFZUS8xVEJpc2k1VzF0NTdpQ3NXTVpWMEZNQ0lZ?=
 =?utf-8?B?UlRreVg4eW9oWDdpVzhXbHZoWFlSTGt1NHJ6MFBOdlFPcnd1M3FJMEowSnhX?=
 =?utf-8?B?Vm81czhONndtUzB5b0p1NDg5TlN2d0xuMDBnTWg4aFlpejN5SnlmVTZJUHFr?=
 =?utf-8?B?Z1RSMTN6TWxJV1lvRDlOTlVVTzdKSjRuQUJaQWJBb3o0UkZESk9PalcyZWQw?=
 =?utf-8?B?QW5hVnBzTlc0aTQ4ZDJtNGtFNXMrWFdGa201YlJNOUJyU0ZvVU9uZHBxR1Np?=
 =?utf-8?B?SlVMR280enQrNUdXM3ZmRGd3WjdlbjllR3U3ZEFBRHhUVG9RdjBENHBVMWdt?=
 =?utf-8?B?KzBmNDNqMHpFdVFOZ1crYzg0ZkhySG5vMXlJQzFYMFFjQW1iQm4wUGpXS2Zv?=
 =?utf-8?Q?kf5nXbwb7U4QZf0U=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc7a4f2-b958-4b65-5219-08defd465dbf
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB8229.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 16:32:59.8126 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4XPauusV6GrnYdcwYOuuSf0QaQRexZ2Vu3IgVosVTtzL2ombJZwLA75wQ0LoKLiiI4JViWRzgrHavBvANqYH/mGbSRqHMiSv6tvGrnr30UM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6667
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

Hi Tom,

On 18/8/2026 2:27 am, Tom Rini wrote:
> On Mon, Aug 17, 2026 at 11:29:50AM +0800, Chee, Tien Fong wrote:
>> Hi Tom,
>>
>> Please pull the following SoCFPGA updates for next.
>>
>> The following changes since commit 527115ef6783cec49e5610c523c124b399011361:
>>
>>    pylibfdt: Replace removed SWIG Python 2 compatibility macros (2026-08-13
>> 10:12:41 -0600)
>>
>> are available in the Git repository at:
>>
>>    https://source.denx.de/u-boot/custodians/u-boot-socfpga.git
>> tags/u-boot-socfpga-next-20260817
> Can you please put this on git.u-boot-project.org? The denx gitlab is
> unresponsive at this point for me, thanks.


The same tag is now on git.u-boot-project.org:
https://git.u-boot-project.org/u-boot/custodians/u-boot-socfpga.git
   tags/u-boot-socfpga-next-20260817


Thanks,
Tien Fong

