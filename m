Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C6DCA9EC5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 12:27:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6282660600;
	Mon, 12 Oct 2026 12:27:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4xaoMBQ1XJ0M; Mon, 12 Oct 2026 12:27:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A09756061F
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791808030;
	b=CVzvvJWCtOFf8hXP4uuRQGio6VIGeMCM6gVOEws1vc1KQHw32xuDRuIH9lK2Q9hbrHem
	 ZzOuuI4ZvopJAHTkSZlALcbcHTr9mc4ywsOGbX0dBgDxU7SyrUIHvW8ZYZEVmF0K7Y7Qu
	 xLvQC63c1WPWkuhaXknfuKxfnbcpEKage7h9CKKS+U+4XyAfD+2trtogriou5XmwnqUNx
	 ImQzypWS95jPZN/Q2iXuu97xx8CYc/zhCxlkgCR9ksoAGZsI33fGffm/QCG90pud/1eKX
	 ZlJ+tOFFNYU+hEJ2emt3ufpLfcBAmDMf2liTokaie7tO1cJJX5awh0F5ihe+valYVkQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791808030;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8DNuZXIwCkrldWHOurHbjB2vT4Bf1fkuoSuShFlLamA=;
	b=fSeqYC2uxUWN6uexXK2rj4lWOn3OZhTa7zEQqk5VEqrAoVlB5vnn87PS1EAl92VMK2XA
	 hrMvkc9+LB+vJXwA/4PL7rORSPVS11YOhV/3COCCJ/zlkeWUJafUmJoHzNSs1wkNi03Qx
	 zUDv9ltqjbGeYVWvgDPjq0s7KF0lCYs4D3pkp3qzjyAdk9QQH5gQ6rh932x4RKGZ61IHW
	 eg/VXjEV/mt/IPD4+YOz4Mn2sh8LC6Y7FyQfQ85JDJfBFU72D75zyKQLRFMcRwMLUCK9B
	 tl4f75vMXF1ozeOFXssEQHbwlWVCxseY8leKb91/V926ekTN6aK0bz8R5n6s8mxozvA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791808030;
	bh=8DNuZXIwCkrldWHOurHbjB2vT4Bf1fkuoSuShFlLamA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xdGVEIPV7kfb9XOxceJEiNLGyy/pcRZd++Gn55vH/Kcy2ZR1/fKrfTDKyKE/0Oe4i
	 b6w1Ra9KKru4MSTS/jMeMsmDlRPtKQc6XQpWsXHgDt5blsxwmDwWJMIM1J5t9kI9Jn
	 XG4X6xnxnl3Ibt89dzhvZ25uBfYg+UH3KEyCKS7koctL8Wd97EiCceE/ytDskvDoEU
	 HsAfSF+2IqytDXYf6sqzAXngmR5EQBgQtSNq6ZhJTsEukfLpL/wt/UqwnG0s9mtDL7
	 9N4dtHr0hFaZ+mlB+A9duSFpp17aBjycZbb9RQ4YAvwXi963wMSuKe4iHwVF+6WEJ/
	 iupIKAsMbVPEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A09756061F;
	Mon, 12 Oct 2026 12:27:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 130662E0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 12:27:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0477580D5B
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 12:27:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n7dQLCAZwkWo for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 12:27:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 56B0880D5E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791808028;
 b=HDOjPI9eRNlRWKVmy+WprBFSw41a0h+EAAPtYQF9uE7tlU64nakto2ZViGudBMIJfwT9
 EzrqLlBu+Jm6qBpTZyFzrPQFEPqJmyu+zzX6NXN0/eWLTZvlPBiyudgi7xeV+WxVvHC2E
 wmDhiQEmNutl5UU4hoX297lIjGYaaCR9rMylLHFDxml1Su5LANQCc80nW8qoPERnZqm7y
 ic5OBKjfDE0iotBaSfNSBcw99rne0ENymtJeVdkaoWn4fPrrAGT4UggwMx+EpyVv2kjTg
 6+fBQYUNKTpN4HS3nGPbb+44lIC1GP5+8IPV9Tq1joGvFmhdpD/gIclIWiSx4QQeDKw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791808028;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=8DNuZXIwCkrldWHOurHbjB2vT4Bf1fkuoSuShFlLamA=;
 b=BlVxf2UO21D9zMoXTcn/i+BRJD2EumZ9xSR14jNQo9BSg0EvddnLlKcn5lQmbQE9gDjf
 28Cr66qJlAuoaBqxYg6XukbGNejy6GYAtH7eJKZfAutHhqVJlR1DjKScSWAjxtbgcm+Wd
 RagZLgZb0DPZagy529KJlJ2IWTmC5Ohb9/qJNas9Lwv9aFOY2RN+xsX4H3ic1OVaUAPng
 9NakuhbAbNg9wo2O8EYfyWFogxkfY/oo0eeRVdGEdavwr5Wj8np2teGqB64a92bnjvl7/
 0YaT4E6ke264TjGCMCdphkoxAGYxa/+vR/tUey2GCard+jqlmO0oVZStxbVownRlMLg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=I8PpE2tw; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=ludwig.nussel@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=I8PpE2tw
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 56B0880D5E
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 12:27:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QhH8g9Cc5wgJy5ANiy31hZ4L2kif+/M21CCNAxgp+pdKQMbDpz7DJVdw41d0S7KsoaDymZkKNqKkyvfSfMtt8BDb0kUXq1x/2nd//LqkNQYp30xOBG3XNIVgTXYNqjwStagyzILMjU8ARUZm+SjQ07/miQt92hCZKftsVA8rPdwMOnn1YLcTfyjgPwR2TQVVaQhtri34XqO+4W0G5dlXLmVrVncPJ09GO91c2221Eu7+srt/esIHW2woBfEoys127NI+hJMXvvb30VkkAFH4dTONnyaDYZozafFPuKr8DSYrWiO+sj/SXbA2x3ZkqLZBdBOwYYzjaJsBVM/0cZ3UJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DNuZXIwCkrldWHOurHbjB2vT4Bf1fkuoSuShFlLamA=;
 b=VKhSzFba3mjvtguWBuxiDNFZa59+OHwQyRicp44H//AeDAoQFTPKAsLjit1Lgd78jZ/Tq2tOXgGWZZswhkar2szRs52bhpIFjNgk4mghc5Phsor2+wg+8iWfe6bl4+qPhMxQUdr/EQOeBSF6Nq2o7JxonnlFrPhLFxyKdKbYx8KB56Dh08JaO7rZ+bQ2eHImNpeeRyXxceWqF5zKDb3uE6zaWgusXCfDPQCG93SLrUVz56htNJbY6Xv9JZbWImVeOuGk5dVOUf4uBQ8i3ZAjVXHzqgIV0ge7wkf9B3luIpQP5ZSxGKO4bN8jnWPudpSfJ2chLdSgr7GVFBnLxnv+cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DNuZXIwCkrldWHOurHbjB2vT4Bf1fkuoSuShFlLamA=;
 b=I8PpE2twOuqzXT5rFE7RyAQgxZsHCeZbhjSUWVxn2g/rptszNCApSVTXiNxkynxCz4QCfMu+rDPUVb+uwhQgdI/FWzPfG6M0yKFetk5kJ9iDdLDonig4ssIfATlHy9vOe6CuONAr1XQpyY7igetvekTYD02zpDTsIgVKyJAoCxDuvwUkb+HJoX7BFiNlJnrteIVG7DbBLaDxCresC5UGzzpnKkZ+3Ysr1ks2ppu0u8z1GdCYt1BJGSYSu0crIDCWQtywMeFraD6hdAga9iWa21oH0Gx3eETUSq+3d0Go+BANpahNdV7cNp4B5mMkQ2K8aT5UEPUTV2hVJoQn5cC0Gg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2cc::12)
 by AS4PR10MB5245.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4b4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 12:27:00 +0000
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1]) by DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1%6]) with mapi id 15.21.0472.015; Mon, 12 Oct 2026
 12:26:57 +0000
Message-ID: <11fb0589-8ef2-4870-8490-077389ce9e53@siemens.com>
Date: Mon, 12 Oct 2026 14:26:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/7] Improve FIT signature handling
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, Alexey Charkov <alchark@flipper.net>,
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>, Johan Jonker
 <jbx6244@gmail.com>, Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Raymond Mao <raymondmaoca@gmail.com>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
References: <20260923114940.349985-1-ludwig.nussel@siemens.com>
 <CAFLszTiM+-BsYPjaw7aD7xfzU+3kK-BO9mkYKrtXpjPOv4SjcA@mail.gmail.com>
Content-Language: en-US
From: Ludwig Nussel <ludwig.nussel@siemens.com>
In-Reply-To: <CAFLszTiM+-BsYPjaw7aD7xfzU+3kK-BO9mkYKrtXpjPOv4SjcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0002.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::11) To DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2cc::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB5019:EE_|AS4PR10MB5245:EE_
X-MS-Office365-Filtering-Correlation-Id: 20e34d6b-1cde-489b-46bf-08df285c1bb7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|7416014|10067099003|11063799006|4143699003|22082099003|18002099003|55112099003|56012099006;
X-Microsoft-Antispam-Message-Info: 6KctfvY2XhBQDXMQrMUlXSu2JG+gSvS+fz+gBHbFJNkyRdv9F9X+UECBCuBstI2K9POx5vh4ug7KB8FPfTIiyNGXhJNrvKNLFb7pqPNPYfXUNJj6GXrDmENiG6nsVRzcQGL4FdXUU43QrtbHuvxS2gbeR2X+LzCCHkwaCeXM3rgLukoSPL6GN+06E1WZe6u2kx+q46jWf0w8tkC8yqzIRGm8BRm3azSPGNhLbNrQBLxid2Fp6gOnifCYVA67jJyd7MLDR7bUfoU4U6CgetA+Bp+K/3Ze4j4upp/nhXoZEOv0EDu4QX2WJ8mbEbm0dAcK/7wSCZl/M6mCNF+MfLNB4qSIyXsK6BE8zdlR+EzAnVgTaPMW25rJT2SPi/zbLzxnw2MYbjU03XYjykjPLM8wCYwaMECxyxVTxikHVrzdOS6sJ50ELOVha7K/b+aKHwpK9OEPWUcG2jiKe9gh5c0ioLzAMMycQmPrENmcQMmr5Upjie81j/BRLuOYwckQFbfGN8eyYZo0EKsgCpfJaziMvOlNGLe+qMqKfVATb8oT9ibbwkWDpQwnfFDYfyvRpEVhbH+kZiFfTdqJ7dW8ut50ZRo1w/lWvHZJc1vx4ydSbNo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(7416014)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003)(55112099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkIwR1ppS0FBRElHbGMzNzRnK1o3MkE4YXg3N2pTcDY0cVVoQ2N6cmJ1QjZC?=
 =?utf-8?B?Rm42SDJzMWdnZE1oT3hmdHJJbkh1SWp5d0FGRjhsd3R5V2l5YzAyTmlBVHlR?=
 =?utf-8?B?TkY0Z3E4bWxjQ0hRS1daemc4dE5qc1N3SkRMeHFzc2JwQnZDelZDSzQ0Y284?=
 =?utf-8?B?ZFVXRm15UDZsQ2YzMFhnYWRQTEVibXl3L2NuL1ZFd2Naek1vb1N0VU1nSWNI?=
 =?utf-8?B?OXFjM1BPWnZHQ0V1UFlrcmFrakFuakRKK3k1enV2SjJLY0RFMWFVdjNCakdm?=
 =?utf-8?B?YWJ1N1hvS2xaL3NwVDQwUU1Id0dncnFhN0l5aWZtQjBXWWNxSHZpSDVBN2hD?=
 =?utf-8?B?enFMT2VNZWcrNGwyY0hYS3RoWVZBOWx4V0ZZQ0xsWXBLU25wOFlsdWJyQnMx?=
 =?utf-8?B?VEh1SzdLbkxmc09FNkozMDJpeDJNTzFqdXg5ZW1SOGZmbm1VeUppbENsa0s3?=
 =?utf-8?B?eUo2dFBBWExGanV1b1V4NVJtSktNU3RBOWtNL2t4WHplKytpcElrcHg0U1lZ?=
 =?utf-8?B?T1NBYnA1eFVyaHV2OExOQ09lK3VpV3M5N3o5T1o1VHZxa3lLZnIwSk9obVND?=
 =?utf-8?B?S2IxOEhoM2lvclAzQ3FrTW5LSDFYbnZFamNuL0NOY2NuTlhQTlYyRkxielNa?=
 =?utf-8?B?NFJmQVpHUGJMUFhHSVdZelgvbnhDOVI4T1FLclc3b005aUlyUEF1d0I3UW5D?=
 =?utf-8?B?VVhhREtIQmZQV0tQN1Z6NjNwVHZiVEl1VE54UkhqK0FWSGhxU2RtRzNWS3RH?=
 =?utf-8?B?QU1MMC9rS1BDRjZsVEs2N1FhUDFERUdmZWorV09UTVR6QkF6MUs4R3dUbXp3?=
 =?utf-8?B?VnN2TCt4N3Z4b01MYVAwL1RTcHB2WHBGZzF0dEVhM3B6bW9tRnZhWXh0Y2RM?=
 =?utf-8?B?OUd3bWNqOEJZMjVUc1Y3aTBVSmY3OEduUEhwbkdLaUNlb3NyZVV6MkFQMTNW?=
 =?utf-8?B?R3QrSGY5ZERtYmMxVDZxOG5qUkdNZjlkelROR0RCRTE3WXZtaEhTbFZXRnB6?=
 =?utf-8?B?SVhBd3ZvTWN4WlBUYnJENm5jZTV2NjBLM2Y1T2lHZGxNZEVST0lOUW9nSnZN?=
 =?utf-8?B?Z3hreWlBeWpNTHJCUVl2M21MZ1RIelJZSkZ5c01VMHg2c2tGOWtyMnZESlZC?=
 =?utf-8?B?aUhhQXRUZ3o5dXh4VkhLSnRPMTFMK2RrREt5Y1ZOU3U5eW5SeXNkRk5OU2JB?=
 =?utf-8?B?WHMwc00yR1gyNUprOEdRa1hJNVZUWmtlYVdRQTZUbUxMZ011YXNFNGU0SGJt?=
 =?utf-8?B?Z0I0eG9STzY2b001SGVGaHVaWEIyaFo1N0Flbk5zYnU1K3NkUUE1bmd6WDZU?=
 =?utf-8?B?cFlLeXBXN2NqK0RTYWQ4bTIrcWV1RzNhc2xKYnFVRmVYY3hPMWI5ZHZUc3Rh?=
 =?utf-8?B?THorU3BiZENEQ3dvYzRBUHZ5YXVtcEVwZXVwT2h0ZGlqWXNzTVVPeGE1Vmxi?=
 =?utf-8?B?cVpCcldSL0V5VEJQL2N3aDJ6dTlydXB4bWduODU3VFY2aG9OdENTQ3dUbjdV?=
 =?utf-8?B?WG9ua2k1dlQrSHBFNjB1S0J2dVVjNGZ2Z1NwektJenNTZzdiZlJTS3RoWjFY?=
 =?utf-8?B?ekJPbkdseW5ualhPWlRlT1VQRmFQUzJPWURLVTV3VHpCSFpyRmtxdTQxMkFq?=
 =?utf-8?B?eDh0bzZhR0tpTFA5OC9HTExRUldSMmxQaEppL0JJcXcyTzl0MGc1TE55MTdv?=
 =?utf-8?B?UEV6bUpqeHB3cDFFZFprZkpXQ1h1alNuVmhyeTFIU3RzOFlqN2xDOFFrREJ3?=
 =?utf-8?B?NXd6ZnM2bFkyYjBjNHFRV1dXNGpBZk1CRkJBb01BK29OTTZkM0RHZlRwWjVP?=
 =?utf-8?B?dXZ2ejJuOGUxMC82NzBIQmRJeWl5bmNzWVZuWmNQZUJYMnlJamJ5d2FIQnVs?=
 =?utf-8?B?Tk5SY0hqaGkwOGVleVpxUS9hTG55WnZLYkZCTmo0NEhRUWtRSXFxMDFJdk85?=
 =?utf-8?B?RFdYWEM2aHByVFo0MGFpV1Y4OWFpQXk0aXhuNnpwQmxLa0tEakdON3g2TjNN?=
 =?utf-8?B?Y2R5N0VKVUlGdDF5SlgxQUlYdEpaLzRCdS9kbDNjLzRYTzIxV09WK1NaQUlq?=
 =?utf-8?B?bVY2MnB3MUpNRzVmZXEwd1BLaytGNW9UQ0Z2SnZOUmtGdzUrUm54VVRSV3ha?=
 =?utf-8?B?N3ZMVDZrR003ZEdPS1QyREduRzBHNGxaRm9nL1llQkhNc043NDBNZk1nRm0y?=
 =?utf-8?B?L3o5VExYbGRBSlJ0VDN4b1dabklVY01mTTlqa1ozZ1ZMRHlaM29zNC9IbTN3?=
 =?utf-8?B?WFBFQlUwMy9uRENZb3ZneThXWXhIUFpTZlNSTG9jTnRsRzRVWnRFK0l5WGFh?=
 =?utf-8?B?dDhOd29BVzE0MloyMi9wekZGRE5iQkZ5M2RuVGxkbmpibmdwRVpIT0tiVHNK?=
 =?utf-8?Q?pRewLxOkzRPC4TVU=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e34d6b-1cde-489b-46bf-08df285c1bb7
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 12:26:57.8184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+OVlC6cbpAd7mI7d3+TxUZpfRSOWaFt5tY/1E/Qgo//lANkPMHUYe6/zHxCmXkywzHFSUsnTV2/bvbG8u3j2tNMfpsx0vqwTTUOzjIySRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5245
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

On 10/9/26 09:23, Simon Glass wrote:
> On 2026-09-23T11:49:31, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
> 
>> - Note: commit 68e65953400 introduced forcing OF_OMIT_DTB which is
>>    incompatible with the intent of the qemu DT merging feature, ie merge
>>    built-in signature nodes into qemu's DT. To be sorted out at some
>>    point.
> 
> One thing I'd like to check before this series goes in.. with this
> series applied, qemu_arm64_defconfig still ends up with
> CONFIG_OF_OMIT_DTB=y, since ARCH_QEMU implies OF_HAS_PRIOR_STAGE and
> BINMAN is not enabled. OF_OMIT_DTB no longer has a prompt, so the 'is
> not set' line added to the defconfig in patch 1 has no effect and
> savedefconfig drops it. As a result qemu_arm64 never has a built-in
> DT, the merge code in patch 1 always takes the early exit, and the
> problem in the cover letter (QEMU not seeing the public keys) remains
> by default. The patch 1 commit message also says the defconfig change
> enables the feature, which is no longer true.
> 
> Please can you either fix the Kconfig (e.g. stop defaulting
> OF_OMIT_DTB to y for QEMU when FIT_SIGNATURE is enabled, or let
> ARCH_QEMU opt out some other way), or drop the defconfig change and
> say clearly that the merge only happens on builds that include a DT? A
> test for the merge itself would be good, perhaps as a follow-up, since
> none of the vboot tests run on QEMU. This may also be worth checking
> against the CI failure Tom reported.

When I developed the patch OF_OMIT_DTB was "default". 68e65953400 
changed it to "def_bool". Would something like this make sense as a fix?

--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -213,7 +213,8 @@ config OF_HAS_PRIOR_STAGE
           disabled in the board's defconfig file.

  config OF_OMIT_DTB
-       def_bool y if OF_HAS_PRIOR_STAGE && !BINMAN
+       def_bool y if OF_HAS_PRIOR_STAGE && !BINMAN && !ARCH_QEMU
+       def_bool n if ARCH_QEMU
         help
           As a special case, avoid writing a device tree file 
u-boot.dtb when
           building. Also don't include that file in u-boot.bin

cu
Ludwig

-- 
Ludwig Nussel
Siemens AG
www.siemens.com
