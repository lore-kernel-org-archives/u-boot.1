Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8697FC79FB6
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 14:35:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A70680DC3;
	Wed,  9 Sep 2026 14:35:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oE9HQTFX85CB; Wed,  9 Sep 2026 14:35:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CD6B880DAF
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788964539;
	b=dxc6JEzdAIfsWyguQQCh8xn6geC8jVyUmQqFfHdb9ghH/tUN+o/vmfTt/9ryjb0XBAWF
	 Spr3jBivnEyNWbV2lZox5L/T2NBwbuMMcjD8zhTx7+TW2LiosQ/ls/YmjyPdLx6LNXb+W
	 VIYlncQiJVl3M264Mi+drnB44Uaq/pi3jU7TI7/FSVAwnPkS0sjxmHXgrRJPu4bOF8k6I
	 x355IsJ0N1HAIjxga9fDvhXVPuurXtDpjOYdBiP9lrbVXsURpOt9OuxojJf2EYrztKVgS
	 gqSHokFHFlIKoDOVYP5e/D9VOYEepB7i+4eREY0jBEfZ2W0jvwVda/BPBNrWhC4THvA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788964539;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 From:To:Cc:References:Content-Language:Autocrypt:In-Reply-To:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Z8FFgg3J85z+zmK440a3sO9wW3mQLzf2e1Bu/i0KMms=;
	b=d4Yei5EROEwtAZ04qOnYftbMYmYYT6m6SheMIBDbJPy0fiRXx1WD4aqkjjdU8xiUTpto
	 0MeoLLngvwNf6ExHRJRZYKw+qbr4zG3E1iMJW/56+OWJ7MmpARaxJwaGxv544aJa4DAVv
	 nXzVkhcadiEUkTcHJIdHy7eIEggrKUKhsFJ2kApKd8ZfHJX1VzeZ7gEdDfx53+IjDHtRb
	 m/v2mwy8WyKiuOABGwhuW+jaT3ZczH8dD2OpZToVnfJeQgfTbn9AQ58FvpbZ3hMG76di0
	 tHM0r2GGUltCxtTuwSfYB36qLVKdJNPx8b0UQH4GVHRj3OTynbWxN00zk++uLJ2XydA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=r4+SgTIS;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788964538;
	bh=Z8FFgg3J85z+zmK440a3sO9wW3mQLzf2e1Bu/i0KMms=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vU5tKpP7EWptv7ptoAn0hf2+bvdAlxbKmpIB3y9hoeDUE6DtFQRyUtLA023UabfDv
	 1vnJH4NTfMbUdOciTOcUDHjb3u2a9tdSNIotAQoXaIFOdOQd9MCdGwJTkmeddmcPJO
	 shqVOQKrB+la9t5+5WzRY471/WIqS1VPFMXHqbDMM8Q6P+FO5dr8Vw6FK/iwd32Gs1
	 Iz9+NJ8mZdr4QGyQSsTGyUSvSREJOdglbKY5vvR/mPcJoIUgatkworPtHZGvtPFouM
	 iMb+x+KYoxzmQjswyHjWLwt5whQ116/hgo4cnKAQYF5fdxkcsfchEH2HRg/5Dh7NQc
	 mN7pYGwL06oWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD6B880DAF;
	Wed,  9 Sep 2026 14:35:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C233A2E3
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 14:35:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A796680DAF
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 14:35:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AbUCG5yCGRCN for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 14:35:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8B0E180DA8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788964535;
 b=nQTAbihW04alvR478yH2M5zudYS0wKxTRZpcZw/utaSRDcy8d9QRuf6saCAgZpiJ4b6r
 MxTTR1CqG8XDB3jBcL2tBVfDnFtaLNirCoG6ByneJ3o9/7uEu7WXjxH8n1gf37T7og5G8
 r6b5mKGXN6kTAeek2Jo2ytGHpCCU815TD7jcoc5iViSLOixJJVdzl1qik1ZjTUUt1IeZD
 hvmXhUy/a10ZFimHVpaHYW5Rq5Zi3zPelR45YfEfP4u8zd0fPzV/4jfP6PYCR3LCZzzNy
 naIjnlYsBEQXAhAxr2UpkU7rUEYycDmJ+jEIW26HSN6QpPcUBq49BAePlAC5WNWzdkg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788964535;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:From:To:Cc:References:Content-Language:Autocrypt:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
 bh=Z8FFgg3J85z+zmK440a3sO9wW3mQLzf2e1Bu/i0KMms=;
 b=gifJYzy/7yxgKL2NES0MhddTgTxfsRTCvpUKEg+EE/BOmx2wG53PzhwSoy0bCWdPyFhO
 2t2MrtcNFBFRJ+5ZsplZwB89xqn9GiGj6qM7iojsDq0hwdZTiv8YZ2l7WUANCVVRxIMmk
 pDtcUp8HjdQ9E1HHnUCgRRbg50xuC3bEqC1VtMbtlllffa5mPLmVjOfoNWBWI9mzuF2sw
 X0JGmSAoiZrLuMLiPHO42P17JYVpxzMnSphSLERtH/ZAwiILSWHHGEzXOnRtpMHOMLLX6
 W9xpjjztCYYTYcfMTk3FYPbHiawi25jTsbmjM7E2maVFC36g5ST/47dJnOy3F9ZcObQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=r4+SgTIS; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=jan.kiszka@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=r4+SgTIS
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8B0E180DA8
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 14:35:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ns4jPrO3R2vYnW84WyX0ugZRrArEQ27EUAQVY7pJbA7UDblUJRxR6hKIzbe2vaifY4hn1k3I+JrHvk2ZRhnh6gxNwnvgxl0jqwosi3lrg4/H7quVnO1QwNiV4V7v+mRh1lUR2F2dDN7D+PWGQDb3EcneDTRJ8tiUf7lkdxG3QrdLoMrZQjLXYNO9AcW4uKKGyY4osLsD/H6ToAg2mJPq11R8+RE5UP6mq5O3LfugZt7PWCnLBSTS8rFBcdyEHW7zNZ8+XJFdFXfTBMPZA0WcpjwXMqdYJjd+vaIAIs4547lRpnyfwU49leFKsb4L6fECmWh/9S25HtSrLydpe960aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8FFgg3J85z+zmK440a3sO9wW3mQLzf2e1Bu/i0KMms=;
 b=IyUeD+5LgHsgAv++GCFsre5BpLZLwliFKW6r/ppyrJGrLZM4UdhmzueE7wIJku9DOwHBQH5v9DhnqoNEaAaJg4ZTqdNrXibxdZWQM7aL39DQfJulQreliLdS1FjTUnFbUPejTSV65UEriMDnlypiBWz7aZN8aIiWr73kXGIAfAXQ+ubM9h09JaCqjk5FXyB/Zpd0dujt+v9mDJWDeDiQQUX17zHpFuhrq46P7KUyoK5JUmzd91yoeyEYYm9gNyyl4Pi41nDJ9My223TFF/5PW7JOIg85hsurzwJWjVqiNnMkeWG7FJB1/KAP4zp4p1WNzMM8klDe/+6CxQhceAz/iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8FFgg3J85z+zmK440a3sO9wW3mQLzf2e1Bu/i0KMms=;
 b=r4+SgTIS9eHUPtKB5HnkLRU29gOHeh7c7GXZVZ4xncKLh0NAvW+Y8/rHg32OSFxJHB8knYgQAD+oEjV8ucEnHIY4ElCqhgv7bZEzIuNfHuusgztBxuZsfumTuxaiHAkPRL50utWyJnpwy35Ht0IxsXl1FxjJ7ZjzALnqCniJWKmcFKppuJwNHl/VqjtlyIntRY4aZPJ/oCN3faS9Qn5e2HR+Baf2dq8GnsFkXfew6z0yW8eLuOhZWxn0drAONR9h4CvnLpCtXDE4FQNVRzfvfP4sYIi2NKeEYg9TAHcPTjdxVykENjI8EW0M0g0foLlBppyfPVrTZU/DbErib8+4WA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6127.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:548::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 14:35:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0406.007; Wed, 9 Sep 2026
 14:35:27 +0000
Message-ID: <b8a8ee0b-17e0-4353-a3c0-3baab12e95af@siemens.com>
Date: Wed, 9 Sep 2026 16:35:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] mmc: Call back to optee after a successful mmc_init
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
References: <cover.1788879818.git.jan.kiszka@siemens.com>
 <598cd2523e3b2a8b7a613468747fe740b1f35fbd.1788879818.git.jan.kiszka@siemens.com>
 <CAC_iWjL9fOYDdyfHRh+LHAeAh_AjNA6tajAFsjb59V6PccLwPg@mail.gmail.com>
 <f78cecea-5651-44b8-a817-18c084001354@siemens.com>
 <CAC_iWjKsyfFQA+ASq4WQvQf1t2uKqsa0CTCdLvXP7MuuRuTYrw@mail.gmail.com>
 <7eacb72e-e147-4ca6-a704-25a7753f02fa@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <7eacb72e-e147-4ca6-a704-25a7753f02fa@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0245.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6127:EE_
X-MS-Office365-Filtering-Correlation-Id: bd8e701e-773c-4ab0-bd37-08df0e7f9788
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|6133799003|55112099003|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: EUwosXOOiMoCmWqSEFDEb6cyBwlXejmjdhfle9Kuu88pCoUxPoJT3PLkPP62ZuvLSg4gHDbQ6YMqhSPK3Cj9wGIfIN6nbQhjlaauYMVOSmTyETxkLNt4+MXM7gDDZMY3qpOe/0iFjtmeD0FzfoWZ3y873OTDTxb3y/8tORnh5cIgH9jRXzC03ucBsXdR5yLpSeCd1A2TSnsDv35xbS0dFqg9lU7ePdv9SG6OIlvGLKzOE9W/bKZlPfXy4Esguc9xIafWtsSt3WdxgnxrdlyPjcKbLaW57AsFG3JWpzZL4W0Xi+gk42J6byUaHaKWV2Q9rFvOgpSbD+u+grY2Px/tcHg/EDAP6TpVVj7v+bc8D2fqQvmtToubp/yLu6PyMBrykyuCacXlIWbXM2NvaX5EBfY/9fri2UbdPNpXRZAmV20eGTrUwNbU+E7qdHdWSyz/UC0S+F6+ed3lajxqk+oPougLUKfQpJBMQvsC4H1QZh1ZCAwd65y2UZWFuoLiDmXIriKiYruYZQPMa20JKZwg5UrE/+wSV5Pr4lTrjIHy+iXIoPAnsXf7dovwJn2fFgY4xwpxhhhct4XrSYhU7B5bXfTPoeUZHDz48GZy+0U92/H5789KITf/6gkLsNAADiROdaU5G4FvbJnwEyzz4jsUjjTX6thuv1myauObqj9D0f4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(6133799003)(55112099003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UE1iYUFzZzdJd2hOcmUyN1VmQ3hrQXhQa3FOQjhNVEVhY0RPOEgvajFjazRr?=
 =?utf-8?B?cHlpUUhQT0VEVENiMmpza1hUNHQ1eDFkMGJZWC92SlFQYmtuWHFqU0dVMkdL?=
 =?utf-8?B?ejdJcXdoRW82MmZBdEg2MnRjY0N5Y2hwb0ttQjlubTNqRk5CQUFYMjRpRlln?=
 =?utf-8?B?TmpaTnRERElzU3c0SUkzR3o4cEhaa3NBSEphckM1S0tHZ3QyUHBNRmxqZ1Bo?=
 =?utf-8?B?Ykc4Y1d1YW4xcU5PRExzaXZ1K3hNYTFYUlljcHNwSDBHYXhMUDI0MTNjYzRa?=
 =?utf-8?B?MTRDQjY5WTgrYmE5VnpnaXlDQllDWDNNcW1UbWI5bFFjMTdZQ0JtaEhseWdn?=
 =?utf-8?B?eWg1NzhsbnFCalV5T0dXbjMwcklsMXN0bUlMNG1RVXN1QXZhRkluMXpTcGVU?=
 =?utf-8?B?R25xYSs1aEl2VWc5cUwrYlFxdmNHbUIwMmFxUHd2c2VZZWRHeDd0RE5NUVdr?=
 =?utf-8?B?bzQvK1A4ZDdrREtSdWtlZ05MWHRibEFVVHhXd0JyeVAvZVN2YWllcDZmbHNB?=
 =?utf-8?B?a0FlQjE1Y244SUFwb2Q0M3RBTFQ2RmxtSGNIQ1dxR0dVZG5XTFM5M0h3M2tr?=
 =?utf-8?B?U05RRENkbHFnclIzOFlkaG53VWd4ako4eXBwajFzTFFhaDhPd1hUaVRQT2sv?=
 =?utf-8?B?Smw3bWthVTdCTkxId21ybWU4OU55VGRmOFFGWW9QbW9EUDhJSVNkak45bjNz?=
 =?utf-8?B?eXFVYzJ6VXh3eGZHdzFBTi9sczZBSWNLMUMzTFRmdjFrMG42WXVqUVA2NGt6?=
 =?utf-8?B?M2FDNkNIcnp3aG00YzcxMUhuZi8ycDRtdnVXaVM2Wkxmd0ZXQm8xa0dHWnZ0?=
 =?utf-8?B?Y1NaNGNRTGxrRzJzVWxrOHZMMWZuUHBBc1VLV0VZdzFJcEIzUjdtT284WlJw?=
 =?utf-8?B?cDBiSVI2bFg0UXRXNmhyakR6TnBqdThJU3dvaVV4OFFRaDBCeTBZaVhvcGRL?=
 =?utf-8?B?VVh2SGVZZHFtenVTQVdmZFM0a1cvRXlOejJGaWFlZHNuUWt3TWFhRk5SVW00?=
 =?utf-8?B?RHM2TkYxWHRpd3MyVlFRc2lHRjZUZUdKZU9xRlVOd1JIMFJiSFFXOTNNVlhK?=
 =?utf-8?B?Rjd3eG1jUStTYXBGM1dmS3J6c2ZObEpES3d6cWQ5K1lBbXBmM3U0YlBZNlVu?=
 =?utf-8?B?c0NlckgrTHJaZnJtdGVtaUVVd0h1NEN1ZWRoUEpvVHBzYU82SnZ2QjBmNmRP?=
 =?utf-8?B?czE4MVNBVlNadFZTRmVQeHhwbmZzRnNHSUlJaSszM1lqeWQ0Wm5XNUNiL0Y4?=
 =?utf-8?B?ZDJ2YkN2cTBnSHBlU3E0aFk1N0tqeUo2QVVCaXZtbWp0dW1JYjB2cllYK2t1?=
 =?utf-8?B?Si9IY2VVNkdXNUcvVC9qS0cyMjZ3N083ZmZhY2xKRmpzMEJjeGdEd2NhNUha?=
 =?utf-8?B?T1REWU1lWDE2cEFKUmg4WndZSzJ3ZHJ5N2gwMjA3MHhjZitsYW1ldjZUTWlj?=
 =?utf-8?B?L2Y0NWZTbWdESDdROFVzOWZZZEZlQ2cxcDNueExpVkw3ZWI5cHRqdGhKTjJa?=
 =?utf-8?B?VHRrVHhSbjhSbEV4KzdPVWdsc3Y2VWRINFFkbVVyRDlNSWxTL3E5VHJSUFFa?=
 =?utf-8?B?QjArM2FncCszdTZUTExRbWVxNEJ4RUQ2MXJBWUwzb2dxRytBMU5KYjNzd2dL?=
 =?utf-8?B?bExyN3JqK2xJdkxMY3Z6WGZVQk0xUUc4cFg5aTI4WmVvaERwR0pqNDdtR3Nm?=
 =?utf-8?B?a1UzOHU0UTZPYlpxWFJSUzY1R2UvSElaRVcrOTNtUFZlY0pPMXZKNTh1RWRQ?=
 =?utf-8?B?bTJOSk0zbFlJVjRKNHNzRGJ2MHRwbDFZTW43UkxQM0EwQjBvU25BWGF4Z0RD?=
 =?utf-8?B?YlNEdzF5akJRdkJYZlY1U2FSeWNJOVYvZW9IdXhVM09uUW1aVGR0WHpOTS9F?=
 =?utf-8?B?NUswdVVPbkpEK3VCb1A5cU1kcnkvTmxRa1FjR3JrYzd6eGNBODlFMGpTOW1t?=
 =?utf-8?B?NFAzSTd4UGd1bXhyTjZnNlZuaDJVSXFFakpYTENvZ2RjOWtYVmRrQXNlNzNO?=
 =?utf-8?B?dkwzZkRsOXVidlpYRzZVWExEM3V3a2JyY09jamJoOEdIRjdHczJhK0NSZzc0?=
 =?utf-8?B?Z1lXTlhRSUZpek8vZ3VrT2lIcEVjYWZXQTBhWXBob295eHpndUI2c1dLMnpo?=
 =?utf-8?B?R1l2dC8yN3ZBUUFZYXRmWEFOcXJoMUk1ZWN2b3NJc2VIbGRiZ1gyWE9GcEUx?=
 =?utf-8?B?R3NWMlRVZW5YQ0xtSDFrZUxvckEwa1FxYU41RUlaYlFTVHlYS1pXVDhnS1Y3?=
 =?utf-8?B?cHlSdlQ0T2VJazYwN0hUQVVBRjFKSXM3cGFONDZxNTJzbklmd1ZZcm5Ea1dR?=
 =?utf-8?B?R2Nzc1d3VGVGcmpOU25uWkhONVdnUlpiTGc3ajJ6Y21oeGUvbVlZZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8e701e-773c-4ab0-bd37-08df0e7f9788
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 14:35:27.7469 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +McNZ2+QP3O2evBW52DGi49kMv4FBb6fDWQ4LGu+IiPdTVRJ/DLARG50mWpfMaQrVvcjv9S7QlTQjOZ2ljTxNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6127
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

On 09.09.26 13:46, Jan Kiszka wrote:
> On 09.09.26 12:04, Ilias Apalodimas wrote:
>> On Wed, 9 Sept 2026 at 12:12, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>
>>> On 09.09.26 09:50, Ilias Apalodimas wrote:
>>>> Hi Jan
>>>>
>>>> [...]
>>>>
>>>>> --- a/drivers/mmc/mmc.c
>>>>> +++ b/drivers/mmc/mmc.c
>>>>> @@ -27,6 +27,7 @@
>>>>>  #include <linux/list.h>
>>>>>  #include <linux/printk.h>
>>>>>  #include <div64.h>
>>>>> +#include <tee/optee.h>
>>>>>  #include "mmc_private.h"
>>>>>
>>>>>  #define DEFAULT_CMD6_TIMEOUT_MS  500
>>>>> @@ -3168,6 +3169,9 @@ int mmc_init(struct mmc *mmc)
>>>>>                                 mmc->cfg->name);
>>>>>         }
>>>>>
>>>>> +       if (CONFIG_IS_ENABLED(OPTEE) && mmc->capacity_rpmb > 0)
>>>>> +               optee_rpmb_available();
>>>>
>>>> With this we'll end up calling the optee bind methods again for
>>>> discovered devices calling bind_service_list(). I haven't tested this
>>>> locally yet, but is there any chance this ends up binding the devices
>>>> that depend on an RPMB twice?
>>>
>>> I don't think we will have an issue here: Either OP-TEE isn't ready yet,
>>> or RPMB wasn't yet when we called it first. So I do not see yet who
>>> actual successful listing could be done twice.
>>
>> The question is what happens if OP-TEE & the RPMB is ready and you
>> issue an mmc rescan. That will force optee_rpmb_available() to re-run
>> and rediscover all the devices no?
> 
> Hmm, let me check...
> 

It's a problem. Is there a helper/service to check the binding state, or
should we track that via a static flag in optee_rpmb_available?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
