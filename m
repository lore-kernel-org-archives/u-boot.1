Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD7BC5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 18:17:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 32296407FB;
	Mon, 17 Aug 2026 18:17:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T7iRB-KVs6bU; Mon, 17 Aug 2026 18:17:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 40B4B40802
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786990636;
	bh=DMx7UcHNlKCrrxUEffrlLmu1qz/kyVUQ2IVxdpkiJFk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QuOvSDcl9BtKwLAuKr9EI6G8q6H+tgKC+34wgkLnlhhvreAm3itg08xrvKPTxY6Gl
	 Aag3YxCIf7daUrMxnBnnaXCOCyWdeDu1SVL0tIqWo1VphWNGl8TVUtXt38IbWzm8DH
	 /MxVWmRON//vUtyEUuyDBHpczi4kM2MpjwATUcmeXIcJJL+cwkwh0V6euBqO2GUItQ
	 LoAAsbPfS1hc0yvH0yL/p0iw+wC3nwTbxuVl8gUJfh5VnxbBg6VSNdkgB1DkfZdcCW
	 1xtbTfLeOpUIUlt7mAzNyJ5aY+TEJCvgUeNGXTgM3PZtv3NK9yWvfN3UNVA6CxM40B
	 oSor+OLDxLU/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 40B4B40802;
	Mon, 17 Aug 2026 18:17:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id AFD8423F
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 14:33:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 95D67401C7
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 14:33:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n-vPgOg9W359 for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 14:33:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::5;
 helo=cy7pr03cu001.outbound.protection.outlook.com;
 envelope-from=nathanw@msu.edu; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A7007400FF
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pa.msu.edu
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A7007400FF
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=pa.msu.edu header.i=@pa.msu.edu header.a=rsa-sha256
 header.s=selector1 header.b=eWo9JNAX
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A7007400FF
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 14:32:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FBKXrf7EPBmJYiM3MVtYeuLRGvuWRcYe+4bW0oxSVGrbVEDdMf9e3fG5no9/xkDX76U79nvewpKfPTQivw/qKI1F09lqu2ZeLrcFWJVbUo6suZFpvQF9c693Vg4BK8V8noHDF72/rpbaD7qxdBgUdJu21Nb/vN2wIsmnNEYyd+Ja3jINCGmrinUm5U/nheV7/dvOC8MdTmj6IGHvgfpUMciWs5rgWl9Qf6bnFh+JlSXk7+Y1IU1vt32LrZJng+sIXtPhIpBVIDpsE1hnN0asL2Z0w7VAsyyrcI5apFZjsuI0aaRLy2o47Fu2yRuqiKrG7OHVXcaRq6VsECavdkaGLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMx7UcHNlKCrrxUEffrlLmu1qz/kyVUQ2IVxdpkiJFk=;
 b=Gq7Y+3PtJgoT4po9rPZ96wzSkctcf1E4UX3bghRJppnegk0OyKt6iDHxflrh1uBJjSNjnTHHh8ED1/Gf3PZSZNYyqdaEMTYSFFKBpLXoJdvXateIqtdtZiVZiUywkNvKCubFTDK1VTI+f7r2DpI5G4Z5M2n86BGKM3qysctiEm/v3/FXyZO/ldt0lr8y0jbCd0owZsAtvLZDVrUFr/aaMg1d25ui4Irc17tz9+coigZrSnbMgDslNEeUNJOTS854IqZ4WlG3eBIXGRnNpOl2WRwsWFjIUSU1maSgl/DOmYF2F1NQ0Oq00hcAzqAFi4OsBva5y+7H+erjqQIfgVEKoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=msu.edu; dmarc=pass action=none header.from=pa.msu.edu;
 dkim=pass header.d=pa.msu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pa.msu.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMx7UcHNlKCrrxUEffrlLmu1qz/kyVUQ2IVxdpkiJFk=;
 b=eWo9JNAXWwumA1KWMmecrZs5BDTTuDjDiuO70IhqjztKW5v3pY4IwUjegKb/p7uoZfKYCPGOL9rNPhP5FWWk8Y+gY/KgLF01wtY/SX0RFZIMy5Oqo3ueae1ZREp/4YHFPyJjt2si63J6clhQTprAVjrB3QhDzITzLrY9hvkyHZ2prJ07WXWr4/jKCC3+iGF0ikqOs1q40aIeA+CqB0jz0B8sgp7+6wBHmJedCt7cYbStsH57BJosl37zK+qLmmjSHYSqCyS8cvhdb6r0Hd8zOK8M3Dbk/WUNLR/nK7R8C0nDxqLHP4qNZUEdqQyD+gX8pqJDI2kCl/nhSUGVGLZ6Kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pa.msu.edu;
Received: from DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12)
 by PH7PR12MB9253.namprd12.prod.outlook.com (2603:10b6:510:30d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 14:32:52 +0000
Received: from DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5]) by DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5%6]) with mapi id 15.21.0315.012; Mon, 17 Aug 2026
 14:32:50 +0000
Message-ID: <1f83d1e5-bced-4fe2-8afd-1ad5e215ad1b@pa.msu.edu>
Date: Mon, 17 Aug 2026 10:32:49 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: mpfs: Read and store FPGA design information on
 MPFS hardware.
To: Tim Ouyang <tim609@andestech.com>
Cc: u-boot@lists.u-boot-project.org, conor.dooley@microchip.com,
 jamie.gibbons@microchip.com
References: <20260724173547.77823-1-nwhitehorn@pa.msu.edu>
 <2ityfs2bulvplo6klwvv3jqb7iybjt7225xj7nmmbp7tofsv3m@jsbyw2shn2ss>
Content-Language: en-US
From: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
Autocrypt: addr=nwhitehorn@pa.msu.edu; keydata=
 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
In-Reply-To: <2ityfs2bulvplo6klwvv3jqb7iybjt7225xj7nmmbp7tofsv3m@jsbyw2shn2ss>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR10CA0004.namprd10.prod.outlook.com
 (2603:10b6:610:4c::14) To DM6PR12MB4337.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4337:EE_|PH7PR12MB9253:EE_
X-MS-Office365-Filtering-Correlation-Id: f50d0525-5252-44e3-f9fd-08defc6c6a50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|786006|23010399003|376014|1800799024|10070799003|366016|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: uzbP9wKljPrtCJRoyMUP+SZ+KWmXuTRZPEFDour1jx616p71DS/ULMYytp8Gp5rwM29E5v7x5t5l57GDQKwiEQxy6sfMtkLmVJtu4nnBl9mhoslZjv73f5521YAum3//Odyd5tE0LkLeJc4Gdes0W1j2EFldfRlzh+Aov+p6bKSz4dpjooBljKaP7/0K9Wy/oXGwTi45XRApGObGespZva2MZEDGGnscG0Nw9VWBnUgQQWyXqQpWQsRIa2eU1ZtvvepXN88527kv5BZ/UlkEm56qxzMT1lZy9wXWgfYXfACzSp1pKdI9F/MQrQ6GURt5q+M8PUqBM1KLSLhxgOg1CrSjK70c8r/6MP6JwJNquarfmu0wro6zk0fGeiCTARSFRYje2SShE7K1Vsguh0rz30xIDM3OjMeK0SE3FLaxgP7HgryZYh5/0IMySotzOZcbT6vowl+KU7g00tkvusPTtzvjZ9pJ2dCZT1gmxsHnFs4wTDksZNz8Qp6DlVWAm2FPjqmzM2piAtgvIqSSewoaTJ+EosYdZ5xByLmHrykI1H8BgLifskoeKyWtZSSTnNfU8NzN3Onq+13qINOQmBg07uv/XjpjX5E2grSuPw+Ox4/7A/k0VqavCfsHvR5felMKWXo2TwnlqTPhC9I2BrIB0pCFN53PLuh13Xyh/qR3DNc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(786006)(23010399003)(376014)(1800799024)(10070799003)(366016)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1p1Q3RhNjlQcjBya1dTWVpiL1FmdkFqYWNmQnJMdDZkR0xseGx3cUJmbTZE?=
 =?utf-8?B?Smd6Zi9TL0RmcVp4Mm0wL3d2eFNTZ2FnNGcyTm5FTllVa29sS1dvSzJDWkFE?=
 =?utf-8?B?b2YvWlZaTjJ3bVFTS21TNWI5SUszb1JsRllvbzdOZFJtb2Q3NEJ6QUpjMWVR?=
 =?utf-8?B?dmhBVm1KTVZFamhiWkRjbEhkK2ZmanJTcTFWNk9Gdkx4bkRMYW95ZHVFcDJQ?=
 =?utf-8?B?TkFVbTUrRllnNEJLOWRacFEycUs1QzZYTU1rTk01WUF6ZEI0OFBXOGhzNm13?=
 =?utf-8?B?elN5S2t3cGd6V3krZmtwbzNhaGVKT054TzlCU1NQbENhS0FXdy93bkFTVHBC?=
 =?utf-8?B?MlhibGZsLzBHMFplQkpOSjVhRmJaR0ozRnZ4akQvS2ZlOFJBWkNURENrMWVG?=
 =?utf-8?B?TWtLRXRiOU5ONzlWUm5GSWt2YmVVbC9uMzcxeU9IL0dEZkNBcnFlVzFZNjFE?=
 =?utf-8?B?L3RsVUJ4RmJ4eUx4aEg1aFNaMHQvaHQ0OHEzT0c4TUJFV2I0aVpRSlNhc24z?=
 =?utf-8?B?YWVOeUtKanIxWllDZnMrUEQxYjhWN3BFS0RMQ3JOVU1oc2ZMcUcwbGxwcUtk?=
 =?utf-8?B?ZXh0VzQ3NWpHMkVCcGxBZ3BHY2puOXZvS2h0U3ZTSE5WekE1UU9pTFR1anp6?=
 =?utf-8?B?TlR3cU94ajZIZHBQcWl4Z1M1WUtZOFVqeDFDamlyVytHNEhXcTJIdG5GTUQ1?=
 =?utf-8?B?VGkySEdETVpJTlpRQUFueGFjVTZ6N0lzd3B2VjZEdmpIQ2RPaTJjRXUvT2xr?=
 =?utf-8?B?VCsrYi9CRFdzQmxib2p5WUsvSTFJQjhoOVNyUFFhWFhUeXFqVFBCNjdobnhP?=
 =?utf-8?B?QUNDeGZ0VENXOU5XMUhUaW9NUnp3Z2pvWWtpVHcxamJ5ZXVMWFZ1Zjdsdnln?=
 =?utf-8?B?akZzbzFRRkhEQjdiMElLMW03WDVWUmQ1clM2SEFsYUpEY2xOM1J6dHRpaEp0?=
 =?utf-8?B?Z3VRa3RXWUtBbzlYdFh3bGdUbU9Ld3RJeDJDUHd3dHlsTys2MnhjMHh4S3RO?=
 =?utf-8?B?Q1JRR1RBOTlDSXlraXRGaStFUjcwSEo2dnRYcG03S01vSFMyWUgwMk9CamVP?=
 =?utf-8?B?bEFnMk1mZCsxUGtMVW1jMTJUM3IxcjQvcURiVEpieFZNcFhhN1pFZ1ZsRnVU?=
 =?utf-8?B?bXNDSTU1RVVwcHBBTGswb0lybmxkWUZ1WW8vdGVORU1zd1gyOVZDcjhmNWdI?=
 =?utf-8?B?YkRvUEdxNXRNRVQ3aTJPRzdaM0RmWWh3cVBqUmZwOUZBaWRMQU9mYW90bnV6?=
 =?utf-8?B?bk00U3NVV0lMOEFDSDlyWCtMREdvV0JOaW8zR0drL2NiOHhYeDJHZno1d2tV?=
 =?utf-8?B?UzJ4aVFicEZQb0lJRkExSWxiKzBNQnNsek5TanFFSTdLZG5yd3B0Vlh0M2lw?=
 =?utf-8?B?OWZUM3NtNmVoTlRlYTdJYVA2S0tHSXE0Mzg5YVFXejhpUnlkTzdsbDRxV1pV?=
 =?utf-8?B?eGdsOTBaKzl2ZjZkZDNVZ0IvczJRaDNSY3MycUQ5NFBVTWltQ3dvd0oyMlpX?=
 =?utf-8?B?cmtZSVFXUDQ1SHVrUXk1bm5NYjVibyt6bHpFTngwaGgxZFV1QWlYcUxKUEZa?=
 =?utf-8?B?d0J6WWtlMENoYUZ2d2JOT0dQYm9XNnBRdStwb0ZEQ2p4VDBQRjVyZDA2VWlJ?=
 =?utf-8?B?NkZVSXVCbnBlTGhjb0NUWjk4NC8wdFR5ZE11RjBxUEdkWmVlQ0RtUk5aRlBO?=
 =?utf-8?B?dUsxWmJ6SjEvbW1mcUtpNzcwVFJyYlFZOUtpeDRtdzVNYTFIREpNcmVXQ0Iw?=
 =?utf-8?B?dTdoK2dyc0I5bTVpQTRJWW4xdGkzckhiUnd3cnc2N3ZUdUEwRm9SWkdCcGxC?=
 =?utf-8?B?M0E5dy94ODFaR0xQbUVuN0JEU1hMcWExTHFsa2lNUy9WLzI4YWZnUEFZRjJx?=
 =?utf-8?B?RFQ1U0RBV3daNmoveml1UGQyK1Z0aU0reUNBZEpVQmoxVzRhMXhFbHJiMWFm?=
 =?utf-8?B?TjRaNXh2eE5aUExJc1BqcDdhOTYvK2VMTjNvZm5qTlJWU3VrYVZ3WlovZG14?=
 =?utf-8?B?cXpjcFI2T2lHbGJTVXVxNnNPd0F5eTJMeSt5RFhSNVk5RWQrZ1d2OHdua2NE?=
 =?utf-8?B?U25zS2YvNXhuVVpSNDZ3aWxaTmZkMnJRaHNHNis1NUJ4ZWQ0cS9XSDBMdnYw?=
 =?utf-8?B?V0NVZVN4dnRSdk52eGgwQ21maFQ0MGZYa1F2MVZxT1lpaG9ORG9KdVpJWjB3?=
 =?utf-8?B?Tm90SUhzRjE5TXVlMFFHR3BPOS8rTHkzSHpjWXpTNXRvTzExVFkwOWl5aFBs?=
 =?utf-8?B?aW5GcTZDenZvbGpGNnV5UlA2Qm5ST3RUZEFWOFhQNmNRQkR4TVhsUlFFNlE4?=
 =?utf-8?B?TXIrdmVjclcydVJQRGZrbjU2c2x4T25xa2RGZGpwWWhjT3lNMzZJSkRzMWlI?=
 =?utf-8?Q?x7FR8r2/Blzjc4rDsh3BFoRpTu4wrAeJgDCX2?=
X-OriginatorOrg: pa.msu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: f50d0525-5252-44e3-f9fd-08defc6c6a50
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 14:32:50.6981 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22177130-642f-41d9-9211-74237ad5687d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZplXyzJVQt3RzlqQfaHjidLmQddCaMWYgdH/+rFFb0wJY7tXyPm4QHHpu1jA2RWw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9253
X-Mailman-Approved-At: Mon, 17 Aug 2026 18:17:15 +0000
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



On 8/16/26 06:25, Tim Ouyang wrote:
> On Fri, Jul 24, 2026 at 01:33:50PM -0400, Nathan Whitehorn wrote:
>> +	designid[32] = 0;
>> +	for (idx = 0; idx < 16; idx++)
>> +		sprintf(&serialstring[2*idx], "%02x", device_serial_number[idx]);
> The variable serialstring may not be properly null‑terminated.
>
>> +		if (env_get("pf_design_ver") != NULL)
>> +			fdt_setprop(blob, node, "fpga-design-version", env_get("pf_design_ver"), strlen(env_get("pf_design_id")) + 1);
> I think it should be strlen(env_get("pf_design_ver")) here.
> Please ensure any long lines are wrapped properly also.

Thank you for the review and for spotting those frankly embarassing 
bugs. I will send a v2 shortly, including the style changes.

One question I wanted to ask before sending v2: I somewhat arbitrarily 
named the created environment variables "pf_*" for "Polarfire_". Would 
you prefer they be "mpfs_*" instead?

Thanks,
Nathan

> --
> Best regards,
> Tim Ouyang

-- 
Nathan Whitehorn (he/him)
Associate Professor
Department of Physics and Astronomy
Michigan State University
Biomedical and Physical Sciences 3225
East Lansing, MI 48824
(517) 884-5563


