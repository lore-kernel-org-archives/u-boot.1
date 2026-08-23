Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B24C5DF8C
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 19:09:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2FEC56061B;
	Sun, 23 Aug 2026 19:09:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wuFYbtEIP0H3; Sun, 23 Aug 2026 19:09:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787512171;
	bh=lqdqHqMk2sxe+kXmA3F+5EELDNlXeGOL0iyC9WE+RY4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w5gCj7yYfObiCvlj7TKOtlaVoR812wpMIPMcKKp/RRRrEXXVjmAKmgPyZ6vNsdVM+
	 anTAwWj5E7YEuJj0SRezOfVBmmqlIDN4uNR79eQh8ZmwE1CCbIRid5qrxEhwl7YplO
	 7vOfFdwpzk71OjYWiofchXQmK87S3zE60Nq8X/uKuPrKR1HQVr4eJv5pmVSjB2rlyj
	 Bee/0GBQ6dLa5CH/WZjEElyTnRrhXujNpkBzkMG1PebEkkA4ju9f437gpQKSko+cU7
	 TM+ErztZMp8K1g+vzhHhW4M/99xxdZzX/sgstUzHLLU/Ybt32XeHRufmwuxTUn6fRs
	 R2Ha29iwA/pGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5D0DE6061D;
	Sun, 23 Aug 2026 19:09:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B80DE42B
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:09:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9D9C96061D
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:09:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BSg1Fzts0KQt for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 19:09:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::1;
 helo=sn4pr2101cu001.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=uyGpVzZ7
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 995E46061B
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:09:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6WRi/X0x8YeJjd3XDbJMZBWFxwrmTXQMN50rpLf4+gLQbfYvmOgtVoevZYz54Grm/zEHyqGTHcpAkUVOY19WdH5lWPgYSog63LcARLHrH07LDzy/YjwgV5NcOpdVHkDo1SIuZWqfViZFCkYUC706SuNtshfJYhF/lnIdLyrSsxlW8i8c4YkrjZVcIfXQccXOzfavStPvPo9PD6FKvmnJBbX+TuZYzvL78T1CrpGR28LZIAHs91btfagoj3cXj+QIdhXYy6oyNUjTJKz/0G/8pbeYfWZyGPWcX5uPqfNuMMXsq4OoN3oAl2zZIucfpZeqTM+UZ6yQL3MIUiLJM/Ypg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lqdqHqMk2sxe+kXmA3F+5EELDNlXeGOL0iyC9WE+RY4=;
 b=FfteWkwIHb/DjY4CrU76VTgs8bnNa2Yxjg2oZtlziW5qJrO+3VFRzBpbGpAdglmZt0ANfHIonn4qzMg/pDaaoHbGE46Aibfd4ZTWWQqnd76RF3A9d2o8brkXzZ+tT6DW8xsbjZUwoVTP43H8vSXzV5nmXuAR4ncRXXhBO9UT2MKBf35A1vu9WKYBbF2/GRfujBspPlUPGSRRdBj2a18cUIb/usDBp7YC96nM+atDaVRzjZ2fCPltIv6w4NgEqO++SSAXBBcVObCgONUZ7p0g2oHokCto7UBFdGnZicUWvsi5YBQEYUPU7hfXoxB95MnZZcbyo36swlwG+9zC+LqCIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqdqHqMk2sxe+kXmA3F+5EELDNlXeGOL0iyC9WE+RY4=;
 b=uyGpVzZ7bewLXB9UgIjpcVbOqNiKEwvqs/eudmjb2zlXl+ihgtrAejJ2Gh7QHZW/AUS1cuZYpbtk+oWNn47CPCkIeJvXSBYJ5CRp6clYmmT8imU07Xo2n1F4RDuJSyk0FliUe6xMiTpGu8VvqUcpgvXV9R4UzAeWF7IllatCN4abmffktBknc9zzZBc4eVHtQNxeYe19aMOX/tsJ9wsmKN4FM1hP3HgTQ5msPP4P6SeZA1XoT6FcCC2HZbW/0mZMI4jJ+ybodpXNnMI3yYoTSkJd4rKbA81WQ7JniXxbfyip4dOPBwyAl+K696PfEz5eIYxWMub0KrzcuSC5S+X3xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by PH0PR03MB6940.namprd03.prod.outlook.com (2603:10b6:510:16e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Sun, 23 Aug
 2026 19:09:23 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0339.012; Sun, 23 Aug 2026
 19:09:22 +0000
Message-ID: <d0dcfd69-669d-4041-857b-b98fcecf559a@altera.com>
Date: Mon, 24 Aug 2026 00:39:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] tee: optee: Add support for enumerating services that
 only need RPMB
To: Jan Kiszka <jan.kiszka@siemens.com>,
 U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>
References: <cover.1787304541.git.jan.kiszka@siemens.com>
 <bfd9927ca141783a9f73f82a10eca75699222e1d.1787304541.git.jan.kiszka@siemens.com>
 <495e9da4-cbcd-40ad-87aa-b8a156dc9022@altera.com>
 <75fed8fd-cd21-49f0-b539-14389aaed66e@siemens.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <75fed8fd-cd21-49f0-b539-14389aaed66e@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0146.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::6) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|PH0PR03MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: f51d2d69-b275-4e25-bea2-08df014a0a88
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|4143699003|56012099006|5023799004|11063799006|3023799007|10067099003|6133799003|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info: liE44MXok/K+52wFuDYMWcwABmzbi0BZoQiydMi5WtrHzmUz6r/AmOnFZNHRBVRKzpSILTRci9NcqrVjjOpEQwnoFgHmiRFmluSE2gFPqW4+4G/+4sSpXKI/Sou5Se7FH5MSdltWiycXeTq4/88+DDygW9ld5CEOoZcaKz0ksIQkiK3C8beg8SwBeRIojjIoZjoD5W24TucGUZSe84HeKMyG34/Xyd/xaGNi9zPvkRIlWuZFqqbELkznRLfN5HFdSjjpF2I1qMKvafOUOqFvOvxWaT8f3ho7uDv6F+0IGMpF0/D2g4L/gQEEqZD0aXnQEKdodOy+JSXiLUgVPIROIp6ASwK40LCT8NG5J66TNa4xixhiyYtCNkBHeX5Yt30IUKBRRZi8sRJzmNdxN9tmMYMWFfOHL99CNyJLRnhq1YTQUqHjDBdBaNbZGp/DvcJMSLI3bCK92sKODxrA+wUsXROzbGhAGda8FbLHWPjR7JnmUDYLwy+/Pcx59jGQPXZrJwpHInVeHcuujtFozbt9SE+jjyJ4bv3Lyum6j4WKG+OTkO0b15hh0oIGK5yHPQffemQlMXc3Sw0qhGKS+hVjQfPRG9tOfCLGjcs29+i2l8YFBIEL1Ci/qav4ovG+eym+w8FvPs02wvp7KMPrYE0jTuupPZiNR29m6D0zdg9EVII=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(4143699003)(56012099006)(5023799004)(11063799006)(3023799007)(10067099003)(6133799003)(18002099003)(55112099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0hoLzF3OGZlSnh1RGdmYXdjQmg5Rmo0REhKbU1ub2RrbzVwcGNoNFFhUnZr?=
 =?utf-8?B?L2E3aW4zYXJDWTdmdCtwVzlMTFBwOWZZS3Jsb2ozUGZyc2luYTFJNlU1dVB3?=
 =?utf-8?B?UDk1Z2NlamV5YnJjclRJcE9NRUYwWGNLSld1UzdVdGFjaE0vdDNOeGh5aDM5?=
 =?utf-8?B?bTFSb1hNVitlZW9kblNMRVc1YWNvck1ybS9JYXBHMFVDUElxL2VZem9jenh3?=
 =?utf-8?B?TXZPbW4relRuTzJwaDlpN3RsNlBaaVB4WWkvckpmWmlSeVIwRDR3YlRsSE1D?=
 =?utf-8?B?RS9vdnQ5MFI4ZHdPQ1RwSW9VVEFScHV6aVJ4T2FzUjh5WDBxUjF0OGJ2TURh?=
 =?utf-8?B?SjFhTFFQR2ptc0hMeGtSOGVrTUVaeEczeXdBVnJDWXlqdXQrakxFOU00QmRS?=
 =?utf-8?B?S09VS0gwVE41eDZNNUxTSVl4V1QrM1VIMmtCZEcydWJSWGUwQ1pvZUUvV25G?=
 =?utf-8?B?ZC93aXpJYU4zNFlLT2pkQmZOYmVwVjJMdmkrVURFcGNUTDFmcXlTU1FMVHBo?=
 =?utf-8?B?NkkvdDV1ZHNYSnZvT25neEZGN3VSZkt5Z1Z0OUpVQWlaenV5cmt2S2ZXLy9H?=
 =?utf-8?B?TlpNdDFqZlFuSEpwNzV2ZWZNZ3NQcUVtN3haaGZadjIxWkdxb2Y1QWxOd0ZU?=
 =?utf-8?B?cEJxSDdibzZpcnVQcXBpMHBHSld0QlVib0duRURXWVQrQmNRYzRpRnNCTGpQ?=
 =?utf-8?B?eno3Y2FLM3RGcnhpb1gyYis1eld2U0hrRlV6WUZmZEFBMXZDSWQ3ZEUzN0xO?=
 =?utf-8?B?ZzlNbUVTUUhtU01KeUZzdi9ZRHhucTBsRVJrSEcvdURDeG5yeFRJcVNhREs5?=
 =?utf-8?B?ZEpXNUY2SGl4NElTOXEwQ3BzdTRZUERheDJoU0Fmb0piSFdneklUM2NNczIx?=
 =?utf-8?B?QWR6TzVzTEIvUDdkbVN6NmI0aElvd1hVWG9rMGttV1lYV2I0ZmVXQUtBZjJ0?=
 =?utf-8?B?d3N4TnI0dklHVmtlaENYSDA0TXdCUlc5L01nV1VDL2tibUxSNGtPa01aUWFW?=
 =?utf-8?B?a3d1OEkyN2IzOE5naU0xMjFoTVdtMDZRNjQrODF3cGtIcndmRWJlT2xwZVFO?=
 =?utf-8?B?cVdEaVQxZ2hkN2Fjc1p5cVdXTHR2N0w0Y0VGbEd0N3dsTGpadldCblZOVFNk?=
 =?utf-8?B?TmdLN3hnTCtwYlJlejdpdDFaUE5lTlB3QlZXWnZjUVgrcUJiOW54NFZBMXcw?=
 =?utf-8?B?b3JXK2hvTHU1ellhRTNiNEc3aVpjTFFOMGloL2wrSTkvRmFaeFoxeEsxRVh3?=
 =?utf-8?B?eXAzTFg4Z09YZFNTcWhBTjRkcjFxejhOVTlhOFFqVDBTeStLZ3RhYXpoRFNI?=
 =?utf-8?B?ZmpheHlPMnE0aGNPTzVaQkgzTTdMSUkyS3hJdkRHTThxdDFyc3o1MmhJcUdN?=
 =?utf-8?B?TUVySm5LYVIwRHQyQ0NsbzhWS3A1YkhFcFhnbGdmYi9OSzB2YytCcHgzeFJR?=
 =?utf-8?B?SEs2UHkxQUlxZWVwRXZsaERGdUJDdlpzZytJSGdRN2NESDdvd2RiQVRSV04r?=
 =?utf-8?B?SG5LMU9xNEZTRTl1UStaTzF0ZmM2Yi9KbFpDNU5STkZ5a2czQTRTeEJxQTRF?=
 =?utf-8?B?Q1BDZjNJVWlNaCswVWl6THEwOUpxbHJQMW40WXRrNUFMTHd1cHRTaGlHalM3?=
 =?utf-8?B?MlJUT21uYnVWK09CbU55MG5iS2pTWXU1YlgyWTB5NlZWNmJrSnVXczZ5N0xh?=
 =?utf-8?B?NG9OdEYwWlZYS1RJbG9sWlEyTDRpSkdUbE90NGhQYnZzcjM4ZVdHdkFzdjA0?=
 =?utf-8?B?bi9wR2lhczVJQVdpR0Zob0xDa0s0UG5jU2NZVXNNZ29OTVhQODhqT29rYmZo?=
 =?utf-8?B?aW00aXFUeWw4V05nSlhzMVhKQU9yZTJqbllHNktzV3RVU1dSNXM5QmhaVDZY?=
 =?utf-8?B?elFKMUZMNldpa2xrYUdDR053bmEzRzhURC96Rm1LTU55MncvTjhNWCtLTFZY?=
 =?utf-8?B?Znp1bDlTdERLbCtRRHRIcWYxdHJROW0vZUhreStxK2FzWFFpTHpVUFhIcmxK?=
 =?utf-8?B?SGIxS09xVE5iSHNNem1aNkJLTFQrQytMdUdjNTBpdEJnbjBxMHpmSTM3bDJz?=
 =?utf-8?B?blQ1TlkzcGdRejJwS3dLSTRmQ1luRVpmdWoxM0JQWHVMYldERFRNODJ2ckJu?=
 =?utf-8?B?emNwQ3g4eTJpTnJTRzl0bytqVWgzdzdJazZzVHh2bU9venhTM093ZnBlM3pD?=
 =?utf-8?B?QVExNnFtbUI3RXN4bUQ2ZmQzYmJldDdydmVXRG5FM1JTN08rc3ZwNXQzRXVJ?=
 =?utf-8?B?VDNUSTlPUXFvdkxLVW0yd0hkbld3UlRuN1BtYndRWVorNkp4ZzNkRDVYS0dm?=
 =?utf-8?B?blJRVnY3S1M5NFdTNGRCVVRGQ01sWE9BSm1Fa2lnanBnMkxranZpOTUrcS9q?=
 =?utf-8?Q?pf98HKOyL0SOffAc=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f51d2d69-b275-4e25-bea2-08df014a0a88
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2026 19:09:22.7582 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vw89wWgRCEf2nqjv8f2IMQ62CMi+sXGrD0CbdSXmyFPo0i5yJ3w3yrzlA2CzxI1wUng5kuG1VlidIX4FLESVJpwTiJ3G/oEqheiRBG6Ym/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6940
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


On 8/24/2026 12:02 AM, Jan Kiszka wrote:
> On 23.08.26 16:31, Kathpalia, Tanmay wrote:
>> Hi Jan,
>>
>> I am not an expert in TEE, but I went through this patch while reviewing
>> the MMC side of the series and found a few issues.
>>
>> On 21-08-2026 14:58, Jan Kiszka wrote:
>>> From: Jan Kiszka<jan.kiszka@siemens.com>
>>>
>>> Up to OP-TEE 4.4.0, all services that needed a supplicant where returned
>>> by PTA_CMD_GET_DEVICES_SUPP. Since then, services that only need a
>>> supplicant for the purpose of accessing the RPMB are only enumerated by
>>> the new, separate PTA_CMD_GET_DEVICES_RPMB. U-Boot so far lacks support
>>> for that, thus no longer finds such services, e.g. fTPM.
>>>
>>> Perform the separate enumeration during probe but, as that may fail if
>>> the MMC is not probed yet, also provide a callback to trigger a retry
>>> when another MMC device becomes available.
>>>
>>> Signed-off-by: Jan Kiszka<jan.kiszka@siemens.com>
>>> ---
>>>    drivers/tee/optee/core.c          | 32 +++++++++++++++++++++++++++++++
>>>    drivers/tee/optee/optee_private.h |  2 ++
>>>    drivers/tee/optee/rpmb.c          | 11 +++++++++++
>>>    include/tee/optee.h               |  2 ++
>>>    4 files changed, 47 insertions(+)
>>>
>>> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
>>> index 4d67c948ec1..5600d5a4c7d 100644
>>> --- a/drivers/tee/optee/core.c
>>> +++ b/drivers/tee/optee/core.c
>>> @@ -41,6 +41,13 @@
>>>     */
>>>    #define PTA_CMD_GET_DEVICES_SUPP    0x1
>>>    +/*
>>> + * PTA_CMD_GET_DEVICES_RPMB - List services only depending on RPMB
>>> support
>>> + *
>>> + * [out]    memref[0]: List of the UUIDs of service enumerated by OP-TEE
>>> + */
>>> +#define PTA_CMD_GET_DEVICES_RPMB    0x2
>>> +
>>>    typedef void (optee_invoke_fn)(unsigned long, unsigned long,
>>> unsigned long,
>>>                       unsigned long, unsigned long, unsigned long,
>>>                       unsigned long, unsigned long,
>>> @@ -210,6 +217,29 @@ static int bind_service_drivers(struct udevice *dev)
>>>        return ret2;
>>>    }
>>>    +#ifdef CONFIG_SUPPORT_EMMC_RPMB
>>> +void optee_bind_service_drivers_rpmb(struct udevice *dev)
>> This function is only compiled when SUPPORT_EMMC_RPMB is set, but
>> optee_probe() calls it unconditionally after a successful
>> bind_service_drivers(). optee_private.h stubs other functions for the
>> !RPMB case, this new prototype has no such stub, so for
>> SUPPORT_EMMC_RPMB=n should fail to link.
>>
> Yeah, thanks for reminding - I forgot again that the linker won't
> resolve that. Will also refactor this to move the rpmb part into the
> rpmb module.
>
>>> +{
>>> +    struct tee_shm *service_list = NULL;
>>> +    size_t service_count;
>>> +    u32 tee_sess;
>>> +    int ret;
>>> +
>>> +    ret = open_enum_session(dev, &tee_sess);
>>> +    if (ret)
>>> +        return;
>>> +
>>> +    ret = enum_services(dev, &service_list, &service_count, tee_sess,
>>> +                PTA_CMD_GET_DEVICES_RPMB);
>>> +    if (!ret && service_count)
>>> +        ret = bind_service_list(dev, service_list, service_count);
>> A dev_dbg print would help here.
>>
> Of what exactly?
>

Sorry, that was unclear. I meant the early returns, not the successful
bind.
open_enum_session() and enum_services() can fail and the function
just returns. Patch 3 will retry this from mmc_init(), so a dev_dbg()
on those failures would make that retry easier to follow.

Thanks,
Tanmay

