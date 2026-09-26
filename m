Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 338E3C98332
	for <u-boot@archiver.kernel.org>; Sat, 26 Sep 2026 12:30:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C5DA581183;
	Sat, 26 Sep 2026 12:30:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sy3vJJBxmFTL; Sat, 26 Sep 2026 12:30:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2F0FB81185
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790425854;
	b=TcPhspBYtwXxK0AMGF3AB+ip0ByJ8Bm1ICNt0/nudMOgbNl+PFcX2OwtUftvjUm/Wovu
	 Qt0wO2gCPXEKgpah33Dx67NuZ8A5bhqbH26wC8F9id3x5FGgqAeG0eaTDtQtqy1nTaBIX
	 eD+FFSrn9I3h1l8tTDLU/fC/h5uAGfoVtlUl6RqoaInDwPS9uImAEsnqXRF6oBk8NfCyS
	 aQ9LvB+5pri5+1NwXeu8eyfR8pjYulr89z+rHLBalWCXM+ctLylml4TeJyQBKGlIdAXXe
	 x/zjHEOeH0zDi03SUL9Bu7X+1IGxgvvlWavKsel1Fv9Yni65+m/iGvnC2gExaBK+kYA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790425854;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:References:Content-Language:From:In-Reply-To:Content-Type:
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
	bh=yplxlsQsnJqoXAgOsnp+aoEBk0DUoFgsLB4qrRbp4Mo=;
	b=MLcVBc0sLpoU+w2cGVBsJK+W7k5PKEAto1ZbSRK/ruftJ3TVrVdwpotUC6V1X7ul01+k
	 aITz2m53jr0vhrdLtDNHdFcalm+trtuRJrziOu/JxT29uzeC64mrTsSxmc0hDNdA95Fwb
	 mfBPnivWnS+g3kLIlJmdUhuvXJtFekhX8z/qSJTAumT1+0OtU21fXjF9Gx0B+sazM+bK/
	 D5qddDSsKUKmHIsaT4V9vnHrTqbIOvQmeMj1Go9Gdt/M0FxH9plm3m/yN/2gQtj9gvJL6
	 LtnEyARuUSNWvaIvKKZzJouWiJMcSa7M6d+ITjg9Oz0/bk0oKnTHwnum+mFDfySJvfw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790425854;
	bh=yplxlsQsnJqoXAgOsnp+aoEBk0DUoFgsLB4qrRbp4Mo=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dPy3g3Gdmaki7wrrL/hz+QzRrTT3Vj44zRNuY63YHxaSLW3hCjXBIYbchiO37trrr
	 nWBlTDuDb+I53hTzPC4LPO4ZL7JgND/yq9dvlFYXJHUmDXW26+8+jZOn4ihY2Vu8Tl
	 7RIwvKFSvDKKA0MAZWE6tjk5KO/F91dEsR4VM514N5R9RVE3DqbjDlMRbxGlTTlW7q
	 gm11HNTVGLOOPozJ5wxPtWdO1OBWK+3W15xVwpvDeStSMWBNbbQwqfqCxvVmkdkqTk
	 L6WIrhEwVrs8wS8VTzQReTySCfDlzhCX4IbI6zCUJQQJ2IwBojqPYMmk80rigbOKNj
	 N2Oe83WWlFSDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2F0FB81185;
	Sat, 26 Sep 2026 12:30:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7D836194
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 12:30:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 65F5140AAA
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 12:30:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aIWz-RMbooRW for <u-boot@lists.u-boot-project.org>;
 Sat, 26 Sep 2026 12:30:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8B10A40AA9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10c::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790425851;
 b=FWmbIa+yjsQMyYkpS3kqUsyADpLKYVjWRi+p+MzaPgtIxfFJacceTijN92RbFwF7VA2D
 U4eEvaxUDakCxHteIAQOjjWW/7fLEuLf9MnNDgw9yubBZgEUpr2ww3b6rlVlTWq9zb8J4
 zvEZPyBMe43vxEUXfYQ+KNk0qyQDNMRjHuhXzeF5WENOGXYmc8IYebke0yKqTtgXTryb5
 iaIzMlFVJD4zaLFBSfSjS3RCMEeDdlXZoQil+PWwh4XkNJZiZl0MWxdwk5/Vu2LlCKI4v
 dH45pqGyXhUEqEDxAo7rxo+aArg5PqKikYP1pPsnaJ8DKvwPiIL4aSYMK19myUVfIhA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790425851;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
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
 bh=yplxlsQsnJqoXAgOsnp+aoEBk0DUoFgsLB4qrRbp4Mo=;
 b=SXXaBAmhmpK/36pg0GrTPEMLnIBnsVIL8BR9Put6gJsYqR6NrMOZZ3Yuhb6xFbSg5BdX
 vh+G0v5iKPbrXFdvihFWrQM+5OJfa8V9QBvhO1UrLTkpYZ2aeKvK8jkEe+3sJXoZ3oFwe
 In2yASbVMT6K3UyTzi6Yr3UC6HW8vdFBh04L3P4FTEbNFje8tpagK1FDQv3gVyg2tc+bl
 B46W/558pW5DBWSBP732dcWA5q8/lHjVG1ISs3eyNs9fgUX5rM5HzKD9hcgG+n4GdSw5G
 o4SwnxSbRSaTQecnrFB7uqEb0LoRwiAw1lxZkgXb24/KBre2Pc4/WXupmWbO0LVlPdg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=altera.com; 
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=KSgqk8ZE; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c10c::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10c::1;
 helo=sa9pr02cu001.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=KSgqk8ZE
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8B10A40AA9
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 12:30:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LaTCssRdcJbdBzzCA2jePJFvX4Ow6cyind7ax2sgt0v7RV/jv7do6ip1YXJ607Z7je7f9yU1JPIXQbmSIQzW/w1ySw73P7iwIZtOt/dx/bo5Z2c9gGtNwV6aqC0TRaO0ZtvEB8oQz1/TgHutRpeJR0r8s2K08goFl6080qB0DoL/RGiHJh2lMUfqhR+qG8ziEL6lD9ixI02iXpfM47GnW8lhcWFdTw2eAvtRO10AEbVSWgMy9ahZ5lYdPef2hk2vGJF/iHqtrX2qGmCT8hubz6KjBrmCXRChEoGfu/7r2OQXOQYhOG5NGAZHuDkDhB0PK2qaqch+jSAXkq85Bg1HoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yplxlsQsnJqoXAgOsnp+aoEBk0DUoFgsLB4qrRbp4Mo=;
 b=QRMajS4cNZ1V6C536/NmnfCaIFntGsGzDfw1p5JWSXySEHlmFz/2kL+WgfArUQ7qSwiJtiq3vr9aTcqwURDS3q4+EE3RF1QiuDQsdAmeeh5vPuL7e9tbEUSblUR86QYl19yfSZrMRYXiYG3USUfcl/erc931eu13dC0z9fXxUdMopAFXywgMywCmL7IKg8LeMLsvaKk9VIG12I1QSJcFT5E6RFt1BDcdTIVmKCr1RtO106J1ySV0sr8b2BgivWZwt+aYxOi3oHlajnk6vowKnVi+309UJjGrMG2OEgoUrQbYdVkQcI+PuxUvIm4JdY2euI9FwsDSx6ZgJBdJxyPczg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yplxlsQsnJqoXAgOsnp+aoEBk0DUoFgsLB4qrRbp4Mo=;
 b=KSgqk8ZEEzD4DUc8miK14H7/QattNylNRCVujtRhQSx3txuy/HAkPNDDVPmimjxiOSaw+U7DnhJnhpAvg8kuk8L28DH8heqAXydbLhdg/IQ7Da29ALvjR2hAk06mq4NdUUfdoMvH+gwdv5dhTfUgyGh4tgx2irQeO90zaGzolqaxPdJ5OJfeWsx+a3dN3QnulBFl5GNlaY7Xo2R2KYZENDZHnIA+fQEBr0tTtU9okv1vhjjYTHFoaT/ONb9Ae1ph7KSfrWfzroq2AjR+R1h7QpALAX2DtD3dtH9FHveTRhkhiBvnrajK+7aEw9irMa76Bv2B5yfw/mSlhRzQT2dAKg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by EA3PR03MB510236.namprd03.prod.outlook.com (2603:10b6:303:2e7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Sat, 26 Sep
 2026 12:30:46 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0451.014; Sat, 26 Sep 2026
 12:30:45 +0000
Message-ID: <16f34ae4-7b4a-4843-8b02-1e54e816272f@altera.com>
Date: Sat, 26 Sep 2026 18:00:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: mmc: Print also eMMC health info if available
To: u-boot@lists.u-boot-project.org
References: <20260921075537.325240-1-kabel@kernel.org>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20260921075537.325240-1-kabel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0208.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b0::17) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|EA3PR03MB510236:EE_
X-MS-Office365-Filtering-Correlation-Id: 4efbbdfa-fdec-4bde-bf1e-08df1bc9fb1c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: Q5gnVTBzFTx6TYOnvaBTbhEdSs0lh7CLRZ/BGrB6tz8uTadrCRozH3pCqF3eTotaMnZVl6W2OFodBca7YEXt7z6asN8aW5ryqgD1q0oNEpB9NviTEl6nmZIy9kCE2Kdhba0TZJugdRPcX1UhPGHp1FH371PQ6CJq/hMrG3L+SEvX2Xjd4vnuSz0b82qahHAAjiEDY/WuoFyIqJnj27/UdsPAfP4Cds5ClbFSGJs/h8z0uXlayzr8R9U3aaqOBEba0PE8WjrSC9D2Ak5DaF1lHUPVzcT4HQl+i5EssYSk8XNvlwP5p2CiStPgmjQ6na5NFRo4HlmuOH5QNSLz8F2kenPxW+64kwAKW16ETf/TGBhAeFik04oAleQjsBJKlIs78GzSf6UtaMk6anThBLXt5s4WHN6RhNBIHahAGP3qGZ9Ym8hspBK9qcZP/RrjjiuT+2+pHWkRptPeLD8vMI65UPsUce0DaccQs6vyzH0FJiKwDqAEJb60GpROBKJykBVhsJJcUj7sy1iX06PwoQ6VrbK5wUwP3E8462oJ/PN3gqgcjtJW7va/egMoh7o2r94AS8YdBTR+HhWluuRu+XOpyLN/TVwyGyFCva0uApgOkiGi/FZjoZhIxOcYj5xvUbmlTuosx6UOTfJIhUC/kWvWuzOJWlgFhC1FFzH9IQxafZ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0VKZTlPalN2clBRcE80U0lRUThKeW14ZFZyZWRlL1RsSnd3Y1RlQTRjYVNx?=
 =?utf-8?B?cU5SSTB3QWZlZWNtK2JYY21TNjFZVDA0RlFYeGFyL29tWm5VVW1rZDNmVGJ5?=
 =?utf-8?B?M1NtSFdYSE5TSUhxdkhuVDhzQmE3aHpkS3Bwajhyd3JCdm8zcHY5bFFmdjQ1?=
 =?utf-8?B?UzVscFlyOTQ0YnBMWC84bDZ3SGlCbTZMTEMrRFc5YkcyczRmMFQ4b3VUYW0w?=
 =?utf-8?B?NjdGeitNQlYrUGdUYmJvaHVqSHpOYTF3RmU3UVFoNlB2TG1jY1JlYlpFTmox?=
 =?utf-8?B?R01iOTFTTTlLYUZiVGk5MjBpdVpsTzA2Qy9YcWltTm4wREZMUGdNQ2xKVGVU?=
 =?utf-8?B?M1djbDd2elF1MHgxNWVoMWFCSnpzMHFQaXgvMkc4WGlvSEQzLzdiNFh2QTFZ?=
 =?utf-8?B?U1dJaThIWDBmdlNtcUlkYkY3SW4wbWZBU0pJcW84c3phQmx6K3IzSENJWVJk?=
 =?utf-8?B?ck5IblZnOGJQWGMwSTNCVWMzS1lENUZmSnNiam5CTjQzMDlNTTFiZFpkRXlG?=
 =?utf-8?B?Tldta2xLdHprSDYvMEd0aExhRkRKZThMN2p4TVZGN3NBMll5M0V2MTVJS2gx?=
 =?utf-8?B?THlsMjZhcG1EK0RRcHdnaFVmTmdIS1Jpc1BydGZsdUVXMWttUjVmSm8wWXJI?=
 =?utf-8?B?dlJWcHVKTVNML3J3ZFBLRGZEWWZTdW1TQ0k1NXJWazk0dHZDanBJSTJRYStj?=
 =?utf-8?B?WHI5Vi9rRmxOSk5VZ0JEdDU0eFBFOC9SRldwdk92ejdhRlJlTGhDTUtQdkhz?=
 =?utf-8?B?a1k4d1g5dm9hU3AvUXJEbXlpeTA4VmRUa0F3V3lUeWtQdWxUUVNlN2I4TVFi?=
 =?utf-8?B?VUR1dERsaE0wbFAxYXAxakVLUzgxNUY0anZMbUZFYXUxWUFuMTNrZ3dPZEJ6?=
 =?utf-8?B?VzZndGVvMjVIMHIyN3gyc1VqZktGUnRVYjExNWpBRGZCWkZxODFza2U2Vkx5?=
 =?utf-8?B?QTVJeURtUXlKNGpmNFh3UUU1Q2lSNFJZclRVYzkreVU3L1QwREVYTm1UTzBQ?=
 =?utf-8?B?TGxYQlhET0hVVHJkY0tXWm9kbFpTdzFxcEJFTnBLUXhXb0lyWUw2RTdlTWNq?=
 =?utf-8?B?SE45VU9wUXBqZitXNkpOdUtYKytlL3lndkFwREM2ZGJkaysxcUZzcXBPZjRP?=
 =?utf-8?B?VkNZRlNYYVFjZnhWR2hZV09leDFQN0J6dHJaempNeEJNOW5XRSt0anhuR3Nv?=
 =?utf-8?B?blNqQmZmUmlURE80Z3NlQW9ZRU1TRkViYmo4Z202OU0zYXBJR1BKYTA5cTNQ?=
 =?utf-8?B?K2tCVlRLQXBWckZObHNEajgyWFhTSXZRL2FnUFN2d2dRRzJEblVnY1VhVnkz?=
 =?utf-8?B?S3p0ZmNuQUcrZnJPZnlwZU5HYVA2ZUI3VWVneVVqTVZqQWdMU3lJWFJaREts?=
 =?utf-8?B?WkN2VFVDenZLY2pKdStZeEpqNTNBQUlIUFVRR0tVclpjVGJLT1V6ZFd0dkx3?=
 =?utf-8?B?R1B5UjJFNkJSSmtRZVhRTk5JQUdva1hzdkphanJjaldYUk1KY3JLY2lOU1VG?=
 =?utf-8?B?dDlFcWJ0ODdHTWFmdXp6RUNwam5FcXRUTWk5ckZrRGI2TW9zZXRxQXhJNFZG?=
 =?utf-8?B?NCtyQ25Xa0RUSmxMSWRSazI5UzJhWG9nWEExTnZXT1pPYVQyU1NjV04xeGVt?=
 =?utf-8?B?eURSOEJrSHExaW5mRUxNUnlUU1ZybzZEa3hxMDBUK2ttUkYzWWFiRnYzREh3?=
 =?utf-8?B?MFVrVWU2NmdlajNoYmFEbm1DMjRUOFJuT1dqQWJEUkxWSmF3dElkbVNmYkR4?=
 =?utf-8?B?YUtjUHFpNTkzdW13b29NeWpLTmFwSFRranRWQlErSjJiMnNNTDJDMmJYTXQz?=
 =?utf-8?B?UW9INURhWnVFeUw1aU55S2hHRld5MkpHVHA0TU94ZWdWbXdJMllYZk9abXcv?=
 =?utf-8?B?UVdNM1ZvcXFEYXhoQS92bjkxWUk1TUgzUHNib2hRTVl2c0E0UXVLRDZLMjAx?=
 =?utf-8?B?V1VBSERocHhLZFVieXd1ZFNpcEw1V1FPQ0g5WjJLaWgzS0R2ZXlkbGxPRjYz?=
 =?utf-8?B?d1hDOXo1RENHcDRsSEg4emovTy9DUTNub253T3NjdlZ1cWk5dC9FaktTNWI1?=
 =?utf-8?B?U1dyRFA4KzR3Wkx5MS94VUc1a3gvZitkREw4eWlaYi96d2tYN2lmU2taQk0z?=
 =?utf-8?B?ZnhSdldOd0psOUVnTEJxN3dCdlNycU85bFRLZnJobE1kUTRlaEk1MWl1OUcy?=
 =?utf-8?B?RkttekNjb3pTL1poVm9lVGs5OFNXaVhkWE9yOHhhekJpV05ndTMyOGJaSEFw?=
 =?utf-8?B?bmZ1VDNscDJlSk9oM3JvSThjQWswZmVpRURUWmxGWW11MVlGTVk3WVMxWi9j?=
 =?utf-8?B?WVRaSVlSWk5YTVhkWDNiUnNSc3FmR1NLQ2lkcnQyd2tweE5YK1VxVlhJUWFl?=
 =?utf-8?Q?wkp/9LZHtXSJ40UA=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4efbbdfa-fdec-4bde-bf1e-08df1bc9fb1c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2026 12:30:45.8955 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zre1cLzA7Q45iq8BUyh+on+ztFzm1wHLuiHTZ3gqxOEScfZPV4lnBFtp3XCFjkoLWlvSzHxm+ICBH0DdgVj1gEQvVsrS6nb5aab9ozMnAco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA3PR03MB510236
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


On 21-09-2026 13:25, Marek Behún wrote:
> On eMMC 5.0+ print eMMC health info similar to `mmc health` from
> mmc-utils.
>
> Signed-off-by: Marek Behún <kabel@kernel.org>

Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

