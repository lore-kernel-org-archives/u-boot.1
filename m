Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6554FEE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 15:53:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A5E686482;
	Tue, 22 Aug 2023 17:53:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=oracle.com header.i=@oracle.com header.b="u+XQgJCu";
	dkim=pass (1024-bit key; unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Zsia4C3i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DC228647D; Tue, 22 Aug 2023 17:53:21 +0200 (CEST)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2460186420
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 17:53:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=filip.zaludek@oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37MFnhRs008959; Tue, 22 Aug 2023 15:53:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Cb3uf+EHJKvNeC/admqP9yVrKUvHDE+16JF9laiJc1c=;
 b=u+XQgJCuYsWhHQhk2sd0HDzD2OyPjbxsTbj2DFKPFqCg5dnqgpm11hQHaeqUo31YVTwJ
 GFZ0rsWlgwjkd0g21cbkCTNVyJX3byZY9dSDzMh52pMA2DzHZrw3dM3utbxNF9cEzY/O
 QNxovn4/pfT7itKgmkxt+BW3s1UT+5vUrMTr9sPd8jJWWLBAQYaTCkbMcO3Qrs8qro91
 GXQm6qy1+6NoTofFjJGXpBpWCkHhRfFNX393zUCrZCYLN8n5sa1sjo7nqYcG47BgWlt2
 mEbFisK54VeXI416PRE3pDO1jy33wvPt87KIYMLhEBzxD2XGwUO5T9kZxDZgTL+73kjV Aw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjnscdreq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Aug 2023 15:53:15 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 37MF1pMQ020196; Tue, 22 Aug 2023 15:53:15 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3sjm653hjt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Aug 2023 15:53:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGRQ8AKblMNHUXimSXn79mSD1B5eHM1qZNwLduxvLC5uWo+O8n9bpULr4jvj5V9vsnfYSCbabN1s4Hh60jz8AXMofghNdmnMWnVlaVWu0GGmn2Irk2DqGwmJkmqxNmZ0PhOxPNQ+67KeqDTr54OKzHE61z+BO+GTnq5JSjasQnZAN859RzMp6ZGr70r3v0Usbk9tmEr2L2jR7D8xdpfzXBVEFAaBO9mQ2Oq+I20vQF5kLUOYUu3nl1iB1R6f1WfjS0lCwizOyc+mLTMOv+I0cMbkrOG3nPFsqe3s6jQM3ng/xsjVnwQ0bxC0Z/H4MJT2agN+cFqLs2ZJjg+DjaGUVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cb3uf+EHJKvNeC/admqP9yVrKUvHDE+16JF9laiJc1c=;
 b=dQ9IEiKHJFe8MMgN0Bh6tX0XfJgB+dlZnZQ/Jc1mB+/lU/gErGI5af7YTo1xpMLhj6CUW2ysYTstoNoyi/8aAHoVoTivG7ca0KQNZvoSmvSUIXneaNdgFRbJjo0qmZES0uFUBgRSktjgewR1PF7wYpBX8Nmeu9ThWxB/1nJ//yn8C4PBu8mW6NkVMEEyUs+LhApL1EafDKvz0DUjzfa7bZEmiWbHv0VktO1kjNCR7Of2ppgVDeYPomVP+zeM/gRpwO96HNrJh87S4zbH1GydEMYItXGjcOi2zSfh0Q1+pT8f3oOEPw5wqYHpgX80vdU1lokIUJYvET7WYpd7hsCeRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cb3uf+EHJKvNeC/admqP9yVrKUvHDE+16JF9laiJc1c=;
 b=Zsia4C3iC8YuKqVL1SmQARiQbIepLASr4fGM/PHYqv+f5hWsV5lC/eBftgBo2DHnnsxzK+2PL485Wov1k4EzsELB9KiVV2cDGKSg+8s7M7AGRJmwTOoEsTkr1D+IEetU+aJ3NvhnmmYrPamBOumJonaeXQb+4F3w7ciGnHKVoMI=
Received: from PH8PR10MB6501.namprd10.prod.outlook.com (2603:10b6:510:22b::18)
 by CH3PR10MB7836.namprd10.prod.outlook.com (2603:10b6:610:1b1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 15:52:47 +0000
Received: from PH8PR10MB6501.namprd10.prod.outlook.com
 ([fe80::2d67:b065:cd73:7122]) by PH8PR10MB6501.namprd10.prod.outlook.com
 ([fe80::2d67:b065:cd73:7122%6]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 15:52:47 +0000
Message-ID: <7e2cbb5e-6626-bb51-6aef-a96fbb381470@oracle.com>
Date: Tue, 22 Aug 2023 17:52:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: RPi Zero 2 W usb keyboard support?
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
References: <f79d2161-eb57-f6a1-256b-f814598a0dd3@oracle.com>
 <7faf3aa3-ca1e-8768-f470-427fd9183e3f@oracle.com>
 <CALeDE9NQ8zZGOevwzxeCct+2NSvCD_U+qp1WWspVK+zO7wPOCw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Filip_=c5=bdaludek?= <filip.zaludek@oracle.com>
In-Reply-To: <CALeDE9NQ8zZGOevwzxeCct+2NSvCD_U+qp1WWspVK+zO7wPOCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0669.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::19) To PH8PR10MB6501.namprd10.prod.outlook.com
 (2603:10b6:510:22b::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6501:EE_|CH3PR10MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: 740cea98-c62f-447a-5344-08dba327d50c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 78YPcU75sxcyVQ3NN2pQXA2wsuTe8Qx4YRyyL0Pj6Fc2zypsGo93eH76lGIYiSJ4vhv2lXhs6OQoFt8kw29+pY6UAi0L9lpjGgubayoFDEYAEZXSI0+Ii7Em9L5xCakmyZJL7Or0nWnb9yPQ+xREr8kLuCGsGNJc9ZaUEsgQS8QAPZuysr3uz3/h7I7AxLBNva/jtNfG2Uuk5GWHr/BvLNufX0UwFJJBh1beSVaTgkAeIB8orH6vKkJINdNAZ4aVhTOTspWl/C2QJyAJcXM31CakmknZ46OfsM8/45hIJCpfzXyAmwdjK8fV0NebdaUvoJsJfM9bXn9zaLf8R8iuSlXZeuMGLZhYP7S1mIgXA7ty0E0FtMMRN3Lr2j20JBYFV9Oa4G+r0wgjQA0x3FjdkstjrsiXgcvcxBdPNHvcEDRBzcHEddHEcWAWRf+rGkbdomiOv936KmnAcbrbgU2KrZJN9JmxMV70Fd+F/5xkAxcdJNmgel1c5tm42/yfLnInzA+Q6csDytUSaLIzHYMvTcROm9Kq6JykrcdvpnFwMW/h0a0B4/GSPvvSSTl4W+tiIAV1ZbHUwHDxyIrb+rm/uQqOIHCqN8fYqNUuXOXPopsrWjAapjUgdI1Cw50SVX0m3FnJr+hvTIqabl1qqPuuGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR10MB6501.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(39860400002)(376002)(346002)(366004)(1800799009)(186009)(451199024)(6916009)(66476007)(66556008)(6512007)(316002)(66946007)(966005)(8676002)(8936002)(2616005)(4326008)(36756003)(41300700001)(478600001)(6666004)(38100700002)(6486002)(53546011)(6506007)(83380400001)(2906002)(31686004)(31696002)(86362001)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3l2ZHJCR2l4cWwxWDBXeUVSQkJsOFdaTVc3YkI5bEVlbWNTWDhRTFZRVEhB?=
 =?utf-8?B?VzZwU1ByeHZYK09OSWFlNWdUc3lxWVk5cFhRUmxyOUdIRzk1VVNOb2YwR3hC?=
 =?utf-8?B?UTVGV3pqK0JOUHRtQTVJTUREM3FsdXpCbVhIQk9DYThVM3o1aFZrQTlISUVi?=
 =?utf-8?B?bmwzWERPelBGWFBMQk9QMWhmZ0FmNUdDM0J6bVVEeXM5UFAyUnB2QUFTcS9M?=
 =?utf-8?B?MEQzTXpmcXRzdDl1OW41SGFhYXFyMXlyQ01KZnlnL2tnZGlXZlNLMXgwdE5Z?=
 =?utf-8?B?RGtuZng5d0ZPejhBZlNzc0N0a3RtakVPZ3F3UW5JV01DL2owTkNhNUxEeFhw?=
 =?utf-8?B?TEFQR1p0bWR6TEswUktuNU1DVll5cG9NMFR2d25RTzFIRWJ1QzdhZDN4L2Np?=
 =?utf-8?B?RitHZ3E5QzVOelViblBlTDlnRE5EVEsvMXJHNGl5eVdtSFlQSmlwUlVKaDd1?=
 =?utf-8?B?Wm9pVE9zcHpNeTJRNFBvNUlUNzV1WTBRdll1M0pKaExDSGZmcS9oZFJ1UzFw?=
 =?utf-8?B?RGdnRzMyWjV2dUhpK3U4NUp2YXh1VGZJcURZdHcwZElESWs5aDZwTmY4NE9I?=
 =?utf-8?B?V0s1VmpMdEZWS2tiQkxNRWlmSXhiTi96K2t1RFpOWStSYjZJWVlEd01pV1d0?=
 =?utf-8?B?eWV5WnpCcG1wUnJTdEcyb3NWaFNNNVc1WUVzUVFNSXpCOUVhSHk4SHRkVWxn?=
 =?utf-8?B?d25XM3h3azF5N3FsWXhVdnc5by8xSkdtbGVoNEZzbzRCWCtKeUhYeHlBUGd0?=
 =?utf-8?B?YmtEODM2VCtOT3J3MDJvQTFFd1NLYXlySXNLNnBjL2RHTWZ5Ym96WktUdis2?=
 =?utf-8?B?SXhSMVYrQ0M4aWVTcSt5UFdOU0hsOHNsSnlxV0xrQmdLWjk2VVJRQ1BQQi9X?=
 =?utf-8?B?MzA1MmR4VnNJZW5mNGZlVWhyV1VQb2Fqd0N2SjgwMXpIa3dndEgyUlc2b2s4?=
 =?utf-8?B?NE1IN1B6VkJIaUJkVUY5L241MHZEUENhTkJ3U25SdnZNM2FQRFF5NmxsYlAy?=
 =?utf-8?B?dzd1STdBWGdUR0d5Z1p6RE9sTnppT1JmYmdTN3MvZForSEw0emtMRFN0QkRw?=
 =?utf-8?B?cDFRYlpBaVVicFFEbFFSaTdPWG5mWlNReUtIRG9UcHpwZGp4VDh2TU41eHFs?=
 =?utf-8?B?ckFjUTE3VnBSNjBlbFQ2Zi9iTXgrQ3ZkMmIxazR6Zmc0dUZndXQ3NnBPcU9O?=
 =?utf-8?B?WGhNMXBPSDlWUjVsaVF5WlRQNklmUnNvdkNTQXVQaGJWZmlwQ254OEozVjFV?=
 =?utf-8?B?TXg2L3k2bHNCQWZjUDhDMWdWSW1tbDRaTXVWenlEamp5OEszb0RMVUlRL2RP?=
 =?utf-8?B?MWpXeVNHQ0grN1VUVFVoQVU1b21wNG1SR20zUEFoanFLOSthT2VkQ3lUMkxZ?=
 =?utf-8?B?d0hxclM3b2tDWjZZT29QVDQ2a3lGQ1hUSUNINFduSUJ6ZWpoMXhTTld0ZVlQ?=
 =?utf-8?B?V1VsUk9mVzU0L1RveDRaRGN6SmRLZENrQUhrWVV5eURmN2lWNk5yYlhOQUND?=
 =?utf-8?B?ZEJiTVk4MDhEV2hSSTZPVW83dlZab3pBdWo2c0c3Q2VFYldXSjBIVnBvSDMv?=
 =?utf-8?B?dVoxTnFlZnlBMzhQd1ZZcEFiVGNXcDlTZ3p2T1B3R3JKeHRrMWpDOVpxVnV0?=
 =?utf-8?B?ZlBGL2pOdFFOUVMwdmFyY0ZvcnVnSUFmb0x2MjFtVHpDY2l4VTZuQmNRTThN?=
 =?utf-8?B?M1RtczZuZW0xYU5uTG9MZWplYTd1QVZmQ1pEemljRHNYNlZBc2drMTdUNU15?=
 =?utf-8?B?R0FDWGtKcWtkcXRiWTcralZJMnNCSWtacUpaWWhGOXBHdmw3K3BubmNRblB2?=
 =?utf-8?B?U1NPVHBucHFwTjJ5RFpYdWFvTmZxbGNuUlVSWVBVOUpWN1AzZUczNS9sdmc2?=
 =?utf-8?B?cXRqeE92bnVYY0NjVjFMYmpLYXo2QWpycmNsUzJSWnJXM29BUFFMcDJlSU4w?=
 =?utf-8?B?eVVGTy82aSt2NzJWcFhaRHBuaU5ycGhWbi9OQ1ZqZ2ZvMTdVLzd5RGFuMjRL?=
 =?utf-8?B?NjBUS3ZPalBJTEZCMjhQYk92RVd2ODVXMjluMFZLM0xNS3M3ZTN0cjQ3dXdZ?=
 =?utf-8?B?aDh2MVBmL21STHg0NzZibEcyRHlTbFlHSlFOVnRSQVZ5U21nNG5VTEhYL0Jv?=
 =?utf-8?B?cmFVUUVrR0NjRG5qdWdkN05RbHpOdUYvb1ZFcmJ6ZVpDczJnM1hCTHROL2R0?=
 =?utf-8?Q?vs+zByRM+4GJQnPbxaqIABs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JdBGXIXyrFdwa+elqBHMsCNiFR02RMH8TzCxAp8I4fIzEBkLZvj4AUuZigNfNwRWl8iBU8BqpfVTBiOE4KvcSDPvG8gFpdOD0wLk2/dOdZOWYckyzIHQTMl4AZQH4/JIuiJkCHz2M5LOpcL6upDsijxyZsi6yUjZ6Bgy9FQ5obXcMxv0YrG6KiRY5KfLN1sGen2y/AWdO8FSpLLGC7gWGo9WeR5lrLIOkTPwzgDKp+DVIJOMVKD+P9r/lPHy7lmntzCDcB5fJfNJBd0mEBdBeTeAn9oPA8R8IJDKPRHTZaiX/zJMTFRQFiOEOVLtWQzHIV79CTL9EHwdgcuslazOHhutmba7Yv2JZOTVthdql7LlwdVxQihjrYx1nC3kp1g27Y1J+u2juewYqulsyXviS3yUyS3vRJUoZdc3DgaQuzF6yf/lfZpyes5092JNWJO8Du04pub6ppAN9tArzZ4Md8XvrTT02Vh5ci7RQhJztS3fxo3lvJ1Uw1A7OmU/BDf1Ix55vuUcKny5pVn2g4k0e3lD611y0BJ407hCXbjDGyHpZJSfnJuermY2sjWIyyb0U+Hx9spleyWO2nUBSZEjJRJWYN46dyB8CcJruIs7j3b0mpAKcT7OxQJ4AjIAU61IFu9r1Rp0BnAb2jfz8tL1c4K6JKAYkHM75O9SO4xNXmuQe/dQyWVG92XkN8q3ZePhaxfv14GxEcqms+/yNSj4IKi5SzuZ1qZO0+s6KjPfId088yqZ749iVyEFF9Cxt3V95RkG12/IsSQDQJ9eAQhI7+k2cDfNFe5nJHBd5MjsBvI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 740cea98-c62f-447a-5344-08dba327d50c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6501.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 15:52:47.7958 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ksivIuzcDA1ZNi+hUs9X/UCms6P86Rn8Mwj9BqRWDHGSKwzysQHWf95KVC+0/vZ4t6ffNqcKEnxKgGtKzGg6R9t9lLvProGIJTnz93UWWUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7836
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_13,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 mlxlogscore=802 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308220123
X-Proofpoint-GUID: 9lwRGyq6m8Wf-VS68NnFAz0umZjpC0ux
X-Proofpoint-ORIG-GUID: 9lwRGyq6m8Wf-VS68NnFAz0umZjpC0ux
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


Hi Peter,

On 8/22/23 13:00, Peter Robinson wrote:
> Hi,
> 
>>> Hi,
>>>     is supposed usb keyboard to work in u-boot 2023.04 on RPi Zero 2 W?
>>> Configured as rpi_arm64_defconfig, no usb devices found but subsequent
>>> kernel works as expected.
>>>
>>>
>>> [pi02]
>>> kernel=u-boot.bin
>>> otg_mode=0
>>> dtoverlay=dwc2,dr_mode=host
>>>
>>>
>>
>>
>> Hello,
>>    I see, increasing usb_pgood_delay makes the trick.
> 
> I wonder if it's device specific, my Logitech wireless keyboard is
> detected with the defaults:
> 
> U-Boot>
> USB device tree:
>    1  Hub (480 Mb/s, 0mA)
>    |   U-Boot Root Hub
>    |
>    +-2  Human Interface (12 Mb/s, 98mA)
>         Logitech USB Receiver



Yes, seems to be device specific, it is also sensitive to OTG adaptor used..


Notes: (no usb_pgood_delay adjustments)
Linux 5.15.0:
* all the adaptors vs keyboards works
U-boot 2023.04: (+works, -does not)
* k1_a1- k1_a2+                        // workaround usb_pgood_delay=1000
* k2_a1- k2_a2-                        // 'usb tree' detected but does not work
* k3_a1+ k3_a2+


Keyboards:
k1/
Bus 001 Device 003: ID 17ef:6099 Lenovo Lenovo Traditional USB Keyboard,                bcdUSB 1.10, bcdDevice 1.10, 
bcdHID 1.10
k2/
Bus 001 Device 002: ID 03f0:0024 HP, Inc KU-0316 Keyboard,                              bcdUSB 2.00, bcdDevice 1.30, 
bcdHID 1.11
k3/
Bus 001 Device 002: ID 04f2:0116 Chicony Electronics Co., Ltd KU-2971/KU-0325 Keyboard, bcdUSB 1.10, bcdDevice 3.00, 
bcdHID 1.10


OTG Adaptors:
a1/
The PiHut, USB to microUSB OTG Shim
https://rpishop.cz/datove-redukce/4365-prevodnik-usb-na-microusb-otg-shim.html
a2/
USB 2.0 Hi-Speed 0,2m OTG adaptér
https://rpishop.cz/datove-redukce/580-usb-20-hi-speed-02m-otg-adapter.html


