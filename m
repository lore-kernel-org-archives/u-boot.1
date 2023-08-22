Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46596EE49AE
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 17:39:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 313D8847D3;
	Tue, 22 Aug 2023 19:39:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=oracle.com header.i=@oracle.com header.b="Aqyi3E4G";
	dkim=pass (1024-bit key; unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vu1z8FQf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F381886422; Tue, 22 Aug 2023 19:39:47 +0200 (CEST)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B27D8846C0
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 19:39:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=filip.zaludek@oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37MFngxc009370; Tue, 22 Aug 2023 17:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : from : to : references : cc : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Wua24CVP2aAOedUnLvIhFzLX/W6YimTCVEB2w8/RA/U=;
 b=Aqyi3E4G/9k0lFxoroonAUaJ/YqWGHIz+vr5NIUE4iaTazmW1JXDmxKkRa47XdGt/oi8
 o+jPCaLcbdT82+ISx9iHtsXht5gF7x0CveTR0CEJSBFKm0prFrv4HPslk2DBQTB+w+y5
 OqSxWL2W8zwEGY7eOBbPVjZEgWgTjiVhSWzlKKFeJy5ugUgR9dk9mVPN7Rs66w2kf/tR
 kGwaHfikWUfW8ovcq5CAFpTlXnUrWZIHM/534uAZF73hawDEA0aukq5cpsG8sKG4vS0e
 byQbqC7cJv7yp1H5Zu0/8BYBXZqWdV5gJcrPCAOZqxwgBtsqdxDsjHsH76bjWn1O1MYa 7A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjmh3e091-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Aug 2023 17:39:42 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 37MGN9Ks020180; Tue, 22 Aug 2023 17:39:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3sjm65802f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Aug 2023 17:39:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDVXXODmPARYaOAuOTw4ELHBJJUTYGP5XF1F5X8ghW3kCWQE3uu0rQgwGymEHGq9XlsMz5pvAlPZ77zeSiCdJHRM7cMSlKhH2KcvT3v94tYMito2LNMgocLetHSUEzddHnZPqOOKWPiFkpJZDJBQVN6YZEbwM8tSPHupBNHFw4UYtTJCP5miIEpL7SHVxZEZa0gS0GsJHAFpjZij3rQGBYf9ed7YxRB7Rmf9X3Rbh+OrWYkABbAWDvec4zQf178qGurvhk4fbsSPMfv6LOMHiaOYlat9AoTJlRhbyQXohqB8wUzYnmvBF27BzSZLzi30P/xFPzE55RXwuTE0C3AK6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wua24CVP2aAOedUnLvIhFzLX/W6YimTCVEB2w8/RA/U=;
 b=D8PFlHkcQASHQxsKi1zgEVCDMSt2wIy/nZh44PUpVZp3oUeQZkpE2sNCtoXdf1dHje6FGnXQmS/Sk+2YQvKSodK+iiAgPuyKOLw1KA27MWd++EWfnoSblj2eCLNf0Hd2hWftqxFkGdkxS80o7O7aUbXdTblkFeEtrtIxBH1fXIPFgem02BL6a7kdSwru4bDSGwQsWLE5huS25EeZqv27iT5IMYXTFySZSYh1R3yEBJrdPoxTkeXf80s5q50FpYXyvBGto7XcTOb0iquLIqTYW8U9sr7ptzdRw+E6ZPfIsNt7F5Fohp3WaLnpg+7r3yeeV5LAqUhPNvX5QeOLTiWkIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wua24CVP2aAOedUnLvIhFzLX/W6YimTCVEB2w8/RA/U=;
 b=vu1z8FQfowxnsM0uRqOniSofdE/UD4xruBm5dkzvRATTvlhF6NyJ9j6DUyJ//t8ezqN660tzqGvabFKxeLXYdOSUU+mklyt7hw1GhZDrdhD8TqSQStnOtAhYYQGlhcL9OIpgWnBWcGnX4tdzVQKoZmInmTDlIJq9aZTU2hKXkwo=
Received: from PH8PR10MB6501.namprd10.prod.outlook.com (2603:10b6:510:22b::18)
 by CO1PR10MB4594.namprd10.prod.outlook.com (2603:10b6:303:9a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 17:39:39 +0000
Received: from PH8PR10MB6501.namprd10.prod.outlook.com
 ([fe80::2d67:b065:cd73:7122]) by PH8PR10MB6501.namprd10.prod.outlook.com
 ([fe80::2d67:b065:cd73:7122%6]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 17:39:39 +0000
Message-ID: <172d59f1-5195-ce6a-c59f-1ae95aa08d8a@oracle.com>
Date: Tue, 22 Aug 2023 19:39:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: RPi Zero 2 W usb keyboard support?
Content-Language: en-US
From: =?UTF-8?Q?Filip_=c5=bdaludek?= <filip.zaludek@oracle.com>
To: Peter Robinson <pbrobinson@gmail.com>
References: <f79d2161-eb57-f6a1-256b-f814598a0dd3@oracle.com>
 <7faf3aa3-ca1e-8768-f470-427fd9183e3f@oracle.com>
 <CALeDE9NQ8zZGOevwzxeCct+2NSvCD_U+qp1WWspVK+zO7wPOCw@mail.gmail.com>
 <7e2cbb5e-6626-bb51-6aef-a96fbb381470@oracle.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <7e2cbb5e-6626-bb51-6aef-a96fbb381470@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0181.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::18) To PH8PR10MB6501.namprd10.prod.outlook.com
 (2603:10b6:510:22b::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6501:EE_|CO1PR10MB4594:EE_
X-MS-Office365-Filtering-Correlation-Id: 490bc9cf-38ff-4446-c58b-08dba336c292
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wn8rOYnOrFv4pB7FFd3hnOyGV5avwYVBa090eQzsmz89Y8MB/uWEye+8bpzOn0t5DoEVkREC0Z7lFpX6rc9wWcoxDTkru378ciNC+1po9uRn3uOprKpjb2bIJL/xMCUsyA0fVEkWe0F20D/xbQ99nQdIk+PZYK6NKSIIz7ksV3IZzOijmPBOjqBRPS5/VU421vl+uoH3GDe8XxBI26KJDyU41awbG5gviDYAFyFYWcdbsYUU4++wZAeoGha9ZF94Zk2aP6fE+DuSkmB67oyXXimURiX+sTnreHXR9RCuutXDCvdtteI1Pdb/XKs02EwcmU4vC61YqIGqp1cLjy7U0unz2eJUTh71MqgWsJARB4KnER6rvfb8ERzbla8htUNKyf60KbQ2IbiNKHmmir4q68LJzGdNzNqyZBlrbwsIyq1+dVDSImABxrntRS8tkZL8wINxfmMN2R6/BFm4lgVakRJ4VPQMldOjwn1JGexAEisOyCBQw6bsvEPzCfre8Lk/MC9/nOkM7h+sFQTW2jOsCFdYoHjweZd4yHpHx1ecSEBe1sFtX4RkaZiPJCMFl4SoNwref4eQCjCW75B+okTvUh+JFJEvQYOlEZYleGxRzG8QUGKGTLSBg0EUcSUzwCQhXhjIPJiTHWXvcI5XH0G6zA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR10MB6501.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199024)(186009)(1800799009)(2906002)(38100700002)(6506007)(53546011)(6486002)(83380400001)(5660300002)(31696002)(31686004)(86362001)(8676002)(2616005)(8936002)(4326008)(966005)(316002)(66946007)(6512007)(6916009)(66556008)(66476007)(478600001)(6666004)(36756003)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlFYVWNzTStOUE9wU2ZsLzQxMXZvdHYrVVFYanp3dEhacWJncWdLbDZGb3RV?=
 =?utf-8?B?VTBoajlkNE54cEhGK1VaUWFnM3lDVUVpTGw2OEFNUXdHMGxxYmtXdlFNTFlJ?=
 =?utf-8?B?S1VsbjlUM3NvWTFJSHBGWjBNK1djb0ZkS2tyYWpPQ2dhbzZ2Z2VGMEJKN24y?=
 =?utf-8?B?N0U1Z2w1VS95SmhEV3R1Z0tWbjY4L3k2NlRVeFZjTkd6M2hPQ1FzZHg1WmNy?=
 =?utf-8?B?LzJaaTIrdG00dTc3ZTBSK3N6Z2ZLU2xsZzY0WlRvT3NzL2hYa3JCM0hmeWJJ?=
 =?utf-8?B?Vk1WbklJUWdEWE1rY014aGRrZjlQQjZZWnVvQ05zZlE1eWxGVnRJakVacTY4?=
 =?utf-8?B?SmF1MDcrU0tpRUsxYWpQWlRSUXBzS2lsTUNsVUo3V2YvV2o5MERSOFZvN0l4?=
 =?utf-8?B?V1pXV0tkTUdzSEJLVVRDNG1QS1BJSFZzc3FPeG5jeVdEcWYyeGFTMVVQaGpq?=
 =?utf-8?B?WHBJdy9rRW9jMTBwRDJUeTFobkNtMkR1My9mcVUxYjU5NjQ4TTd1WTkwdVhR?=
 =?utf-8?B?SWlaSE5rb2RRcW5qck1UV0Q4ellaQ2VHR3JkTXBvUVNLL2dkSHVpZHRtbHFJ?=
 =?utf-8?B?Tzg5QmJ6a0hPeUpwTE1UV2tFTmJySVlYcUZsdjVRUTJVRUd2SFUvTXdGVjdx?=
 =?utf-8?B?Q09kL0RsV0tJUGN3Mko1YW55djhEMjhFR0NhTmVKZkRNZUtGY0xWMko4UWl3?=
 =?utf-8?B?Rzd0R2NmZXdXSjhRbHZ6VVlvTFdaaGVpZlBhNnVZWkorRE9MOXIvcU9zMVB6?=
 =?utf-8?B?RENKb3BuMVVTTStUSlRVYzlCZ2Q1T2dFRjlNYktvRktWS1Q5MWFVSkl6ZU0z?=
 =?utf-8?B?L0trRzRoOXdqbzJJMDB3dGZzSHRNczBBdFJyaEJGZjAzMVF5Ti9rMWpaalBT?=
 =?utf-8?B?dUxLc29hMEZhQjBSNFlzcTBNZ2c3K0hSSEtKVkdaYXVsMUExRkxzcStVang2?=
 =?utf-8?B?cmtKbzkvbkhvTmJiT3RyVFE0WXdxeWtVeFlwNmJSZWlNeHJVYk9ocGtydHhm?=
 =?utf-8?B?WDA1b0hLcTdlbndhRWU1dDQ5OVF6TFJGQkVVcW44UXB6RlRJQitBcEVrYXRX?=
 =?utf-8?B?SWIzZzl0dFJBTmszY3FrU2c0VVJQZ0pqbkx6NnRJVS9MMVdsTUpqdUNEYVBQ?=
 =?utf-8?B?WGY1VlQ1MDZibEtLMDFEaTJCQW5TQzBwdHBmOUd6V25qeW5hSWNCQmp5emt4?=
 =?utf-8?B?MGxHV3J5Rk9qM2xiZHNycE5xMk1XU3lQOUVOYUFmeE82UCtTZ3praTlOYUZB?=
 =?utf-8?B?R0prbkVYZkxsUzVTYk8zcXZrR0d3OXJDalFMSS9hWHlyMXlwTVdNZmpWbmRa?=
 =?utf-8?B?c3ZpeWVSQUsvN01ROHBhTi9OSktBVDZMQUVydUhxZzlYQW5KZnJZUWJqTTJn?=
 =?utf-8?B?LzVidG4rU1A3MWtrREhqZWtJMllwaWtxc1hYTzRNUWh6dkM1T09SQVU5a05i?=
 =?utf-8?B?VXQyeGhHWHZKM2JXdjVoRlBteVBRZVNTZjJTMEsxbjJ1eE51aE1Ud1hBNjhi?=
 =?utf-8?B?S1YxK254QmJuNGo2djU4djZzREJBUisyeXlMbjFyaGhkTFVWZ3JIWmNKMGNK?=
 =?utf-8?B?OEpTRXYxVkpQTWtJYlNzZ0NJamQ1Sms2SFNteFFnUU9EU1lpR2VhZDV6alpJ?=
 =?utf-8?B?WkNWZXpURk1JYTNvTyt5M1MxTkxRSysvTlZhSkJBbkNoWXhFZG51cTJNUkR5?=
 =?utf-8?B?bUZlVWRsTWFzTUd2WSsrTFZ1MGNWUThlbFlodksvblR2VU9GbldFMnFHOEV3?=
 =?utf-8?B?ZS82NjNTdWsxRExDa09TVEdsem5aaTEwOWIwVzJvVThpMU8xVStZQWwydkRG?=
 =?utf-8?B?d0UrVEloUE16VDFxWVRheEpZVVYrazJ6M2pxMGtRcjRsZjgrOTAwSHRwT2hl?=
 =?utf-8?B?QTVUT2FMVHdIY0NmU1JCalhFdnIydjkwaFVoYlBRSm9wRFR0bU80dUFqRHJV?=
 =?utf-8?B?SjFvRTkzK0JZbGczWTArRWtqL05JakZEWFRsUXRzQnBVaStoRzUxVVkwa1RT?=
 =?utf-8?B?cFVqNktFSCtvNWN4MUROTnJaU1lKeW51djVWTFI0a2NYblBpTTlMNWtFcmVR?=
 =?utf-8?B?azdwcVNBNUtneHZMcmNHekNBRWU4am9uVUlMTkF1TlZ4eDR2ZzBJQkJqVmhE?=
 =?utf-8?B?b3BFSGZSOHVNTERmWTFibVVzb0tWV3NkSFBYeXpsaGZST1pqQXZUQkxhWlEr?=
 =?utf-8?Q?0Nl420U1E85TnBzdpqNdBLE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ovFUrZ9ied09JNHlFg07P4KtpL/iiAygDuycAI0lgjS9dJytEaaQ4ul4C/L8MKJcAN6Bo7NqNZ/Q5e1jrGLGvSIQ2vEYLj0O6NPjnoZHJ6qhDkAScm+Zi3elyJDFkjz0pEHGRja3LWH4Bx/sFFm2kck873lYetoA7kJ9GD4787dW3ghqsEPsNsdI2jZxWPo7wjXvO/JcNswSxKTexnTNrDBN+SHn0AuffhIH/YpEUECQnTxVUKzSNiRB/HHioBPuR2sSTmA1nm1XK1xWVO92s2vvLaUe8XXfipHTflQ1Xcjt2fs3oJLizWGKOkYU38/uERpBUYOSFN/arM0EYnKazI3JG/MYc6nauQwsfhztpkIoBNTmMw5r3gGW/RmFso0FuR3NJalfeeVcDAkomgFnxfby++fafAsEVR5rmChu4mpyx/6fbIPjcWTfVzpbItNRkYz3vyaaCDtMPNT1+DLYHyD3UQlUVan5cOpCVyZu1MmdrIARMogBQSWGC71FdqJLeEAR+JIip4ICIfu0phtueof9nsdhMVntJzRfQmzY5bmUgN9WIGV3DGT3rcJUPllXJ4UZNbEeDtqNvMEh4Lhx0ogIZF8rxIeBowa/Y+Vinc6p4wNJPqUsu5KZxJv01Q2IbhH4k4zbwWBiVGpiv6TfurShRP+IDnetOanFIdK3M1eAzJZcaetO0C5MN+mfFbAj/QkXePoH2AmYTnr0nziPrY3bPHkawoUGZZUfdzafEop5jwaLJR4XwKOnCzAbCnJQA3fxY0LQKwk2Wbu4g4p0GHN7jLj9NTpclB4KeNNh260=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 490bc9cf-38ff-4446-c58b-08dba336c292
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6501.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 17:39:39.4049 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GPrnX1XeiMirGK3WhwOHiluDikLf93dvI4g/vJ5YOAvFFy8/wp4RFTErwCmhHPj9mdyv0jsaj0xoJLOrD2JZmf8LdmxhjzgoJ3fyRF5E+Gk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4594
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_15,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 mlxlogscore=977 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308220140
X-Proofpoint-ORIG-GUID: QE4dHNAXVytfZRZsBqYfteO0ikzSimFB
X-Proofpoint-GUID: QE4dHNAXVytfZRZsBqYfteO0ikzSimFB
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



> Hi Peter,
> 
> On 8/22/23 13:00, Peter Robinson wrote:
>> Hi,
>>
>>>> Hi,
>>>>     is supposed usb keyboard to work in u-boot 2023.04 on RPi Zero 2 W?
>>>> Configured as rpi_arm64_defconfig, no usb devices found but subsequent
>>>> kernel works as expected.
>>>>
>>>>
>>>> [pi02]
>>>> kernel=u-boot.bin
>>>> otg_mode=0
>>>> dtoverlay=dwc2,dr_mode=host
>>>>
>>>>
>>>
>>>
>>> Hello,
>>>    I see, increasing usb_pgood_delay makes the trick.
>>
>> I wonder if it's device specific, my Logitech wireless keyboard is
>> detected with the defaults:
>>
>> U-Boot>
>> USB device tree:
>>    1  Hub (480 Mb/s, 0mA)
>>    |   U-Boot Root Hub
>>    |
>>    +-2  Human Interface (12 Mb/s, 98mA)
>>         Logitech USB Receiver
> 
> 
> 
> Yes, seems to be device specific, it is also sensitive to OTG adaptor used..
> 
> 
> Notes: (no usb_pgood_delay adjustments)
> Linux 5.15.0:
> * all the adaptors vs keyboards works
> U-boot 2023.04: (+works, -does not)
> * k1_a1- k1_a2+                        // workaround usb_pgood_delay=1000
> * k2_a1- k2_a2-                        // 'usb tree' detected but does not work
> * k3_a1+ k3_a2+
> 
> 
> Keyboards:
> k1/
> Bus 001 Device 003: ID 17ef:6099 Lenovo Lenovo Traditional USB Keyboard,                bcdUSB 1.10, bcdDevice 1.10, 
> bcdHID 1.10
> k2/
> Bus 001 Device 002: ID 03f0:0024 HP, Inc KU-0316 Keyboard,                              bcdUSB 2.00, bcdDevice 1.30, 
> bcdHID 1.11
> k3/
> Bus 001 Device 002: ID 04f2:0116 Chicony Electronics Co., Ltd KU-2971/KU-0325 Keyboard, bcdUSB 1.10, bcdDevice 3.00, 
> bcdHID 1.10
> 
> 
> OTG Adaptors:
> a1/
> The PiHut, USB to microUSB OTG Shim
> https://urldefense.com/v3/__https://rpishop.cz/datove-redukce/4365-prevodnik-usb-na-microusb-otg-shim.html__;!!ACWV5N9M2RV99hQ!JIFzwzVvSSXpR2n_vV5USgKPkbrvI1VtCWDO4eKbLaT4RVHAtvawPy76faXmhOJ33tUlx9_TtwkHgiewJKqAUapuqEk$ a2/
> USB 2.0 Hi-Speed 0,2m OTG adaptér
> https://urldefense.com/v3/__https://rpishop.cz/datove-redukce/580-usb-20-hi-speed-02m-otg-adapter.html__;!!ACWV5N9M2RV99hQ!JIFzwzVvSSXpR2n_vV5USgKPkbrvI1VtCWDO4eKbLaT4RVHAtvawPy76faXmhOJ33tUlx9_TtwkHgiewJKqAYbCSmmM$
> 


Sorry, I get lost with so many devices. To conclude my experiments..
All the permutations works in Linux 5.15.0, testing is OTG adapter agnostic.
USB 2.0 keyboard does not work.
Some of USB 1.1 keyboards work out of the box, some with usb_pgood_delay=1000 workaround.


Filip

