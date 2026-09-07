Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA69C79FA1
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 16:20:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 44DEA40595;
	Mon,  7 Sep 2026 16:20:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7LfcTe3WXYuk; Mon,  7 Sep 2026 16:20:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6F88840566
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788798035;
	b=MnhGivrTpIWzUsTGSgRD/8izoP18QqilFwR0RO1gYPCoqbGNUQZMZQTJ24T7H9rC1USa
	 y2pk3LzIneW6guPBkWE9JHHJ7A5RZ3NV0Mp75pWpOB2gSN/SZ4T9ewVkwDtqTu0WMQhRZ
	 POR2T9M/58f8gwonkYSfjoKJcBHw+SJLjmj7NdLdvP7vvI1c2KSmw40kFVM6zaiFtb3d2
	 kxvx2dp2HY0kV3E7Avu91BNpboISOvsAWzEqrehwweD4kb5/PHVwkOI09jqys+Tb2bmM0
	 68Ou4CL41ANOOLB2jPw+2HhUqQ5ZNk1OlBUmOr0lC3RuxRe8xzRWyZBL3EqAiw2fTyw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788798035;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:In-Reply-To:
	 Organization:References:Date:Message-ID:User-Agent:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=i8TR1GlfAb3bjF2mXca+DJwQaWqiypfBD+vsSeoGzfg=;
	b=MI6HQVpVxZWhFoOKgMxFg07cxq9SL3WNVfzlTzkSMcWKIOhvsUOgPdNmKctVUU6x2yUl
	 SjAmjUt4atUtCGebLOqfjrPJBYPg7/5rt7QFLY3SGA60NutL5gya/cn2Ce+yFg/+a3Lzc
	 EmWsGA4JJpP2EdgpjgsUsXAaP0fWjEZQo1fZgg08SH70FBKUTyMz3Jf13nrXqL+diWYxE
	 fXKVu35CCGzf1zqRuWEamyZuMahacsEalujP/fJnF2V5liUK92bd+7KtQQbexy5M0uV89
	 CKVnkSnABGUsGmPqRqOKLlpm5II8zBRtyZNhV5rh/pNKuol5USQiux8q0UTjMouTQOA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=prevas.dk;
	dkim=pass header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256 header.s=selector1 header.b=eN+CIGlu;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788798035;
	bh=i8TR1GlfAb3bjF2mXca+DJwQaWqiypfBD+vsSeoGzfg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hOxlvI3CCTGwgs+iIkGyhtporMwHcDdpcS7sTUUHDCfG6fnN63n4r1u8WwBXNdcoD
	 QRac7YFk/WOfvZUm6a9XDtPSS13wIaljv4efqJ5i7UOg9vOH6HXRi7divgA13BfqxR
	 dbjw/4ldZAM5d48MiMe4rJ19ixZr24VE6rHcZwYosWhuR5iCzAzI6LhPrSrPgbOWA2
	 kdNDuO5BW2DwJCAbh5D4wGaYX6VrcSBxY2PmCoKkTVQ0Bmnl9fYI6yMEJAaOQC4tCi
	 vCxS003TQ7Zr0T/CYXRAqo8z8t7Lq2dtqUMrzz5HIl1N0Md0b6P9n2E77BzCz0yI45
	 cKorO1bmvX7eg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F88840566;
	Mon,  7 Sep 2026 16:20:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E49B34E
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 13:20:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 33D9540547
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 13:20:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oznaYkZBzBDi for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 13:20:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7D58140450
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788787246;
 b=H0E3T0cjTw7IH1NrP57DAcMG6TKrxfyWSUjq2GPmA2XanhSolBoVZEwNaeeeAHotVju1
 826TG62JvkD6vNVC5JJxhTwS/Pcx+Q90W+3p2u+N69LjvFh76PZZM4kGaBiTO9sF2EG3K
 OJNSw99lLbL4EA4VLGuWlkETzhTZlqwM50fSVjCw1hDZBZDopyTnsIwvUNJ6h/Y59Vmy9
 VfKHwJgY2d7zURQAkNB2zlhrveLT9Mf30bQ+fmdIIq3Rr3wJoWFoJfPU54glnILUni+R4
 OaEXLh2tmClTpwgiiQrhH0DkheKbhRutdFEoY7z0G3ZAV8gIWsXuKqZVX4PK/mIwupA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788787246;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 In-Reply-To:Organization:References:Date:Message-ID:User-Agent:
 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=i8TR1GlfAb3bjF2mXca+DJwQaWqiypfBD+vsSeoGzfg=;
 b=MhMXTevDc3LoQOAxt1RgiF3Hfq/nRtXxSOwRGI49JVNjTT7yEMbVIEju9v/yr3oVH41T
 fqEtLfSsTNDAUGgH8sQdcISolvdoaMcTkBneFiWmqJDxJP5WZsenzAxlnmXfafefanwPD
 GNWixqsdAAZHSuoSSjnxYAnoobPIMOJQy53paR3nlrITvMszFrv/g5twP2NysTkJDWegW
 5FAc+4MgdC4puDrdMhIIqmUDiTVwBYMLp3EEKUt9skNUVUhEw+Tum5IsnJZ1hR3VRlvxV
 QzIfmD9LqpttrQbDVa1vhE8BVB5FxgUXdZcguWo/JG07a3/nZA0F0zjsWTm91VwPG6g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=prevas.dk; 
 dkim=pass header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=eN+CIGlu; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=rasmus.villemoes@prevas.dk; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=eN+CIGlu
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7D58140450
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 13:20:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aR1sVHxMf7/mNTtwOWo74j6w/zC0RqJSwB/kuDvpwIEh+ImHO4ezaK7avd+WpgFXkkQ6/CoKZxgduokdID79l74G7Y/OkGfPX6AxouUoNoKj0tJTfwbgGhz52VvgzztbTtkgoWSA0vNIBq9f/xXle+jOwQ1ZU80yyu6O8947avQDov2lj7hy3DMIpW9c4vb68bU6eq3jssrXU/YSTMu9ie/jGW/VJSgpC/Eo5GpekZnCXnUSa6AoxHa30xVrXU4a1NcDTYWZzCXU4kUIWI7hq+Etq92DA/O2RE9pE9j9w8Z9CR1ufU0Ycd4uLVbvNa2p0Y/7XUCo6jX9megigYn5Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8TR1GlfAb3bjF2mXca+DJwQaWqiypfBD+vsSeoGzfg=;
 b=oGAXY8IPKCdAJnFBu5D21qLPsOxV3ySV5ZytlrnnC3ODRkrywLDpsy/pUam4r3idNFyO59wVRhsJwj7LAGSeM0z56w//csHejjA1GA8OaCcnh/+Zf3CbDf6BBnD+lW4ZSi6nDInN9Tz0J8oUP+QesWAV3UO+aYrzmlXL60mQ7MR830I8fCMb6zBnt0jdz/2MNVrYkTtObnm7KsNK0tPScDtjxfQcrgwM0+RVBIn1RLQKrfV9YqOWZh5l2BJBqkKl7OiNN4U0oTLFcXJSEVPetgRl5XfPgvMZvXuTcDcxX0cKxVul1R63BUltWvO+sX6qLK8LPjCNGNE73S3TxidG4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8TR1GlfAb3bjF2mXca+DJwQaWqiypfBD+vsSeoGzfg=;
 b=eN+CIGlu4y0cMgUXOz9i8cdNzKWNgqOefIxTT3rmU0VVEYbvnc3OHUj0nuZguWsIPYyATKVuqRQHNlwt0jcDhKK8V6BMkQBtF+0oXP9YhJMyoJGkhshXZJnJeDi//+BA08lO/4Fu6fe/XtTI6Z4MOslWOShjjPZpD2fcMP6m2r0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by GV1PR10MB8808.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 13:20:33 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%3]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 13:20:33 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.u-boot-project.org,  Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,  Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH v2 2/4] optee_ta_avb.h: add
 TA_AVB_CMD_READ_PERSIST_VALUE2 define
In-Reply-To: <87a4pttgch.fsf@kernel.org>
Organization: Prevas
References: <20260903212215.2331118-1-ravi@prevas.dk>
 <20260903212215.2331118-3-ravi@prevas.dk> <87a4pttgch.fsf@kernel.org>
Date: Mon, 07 Sep 2026 15:20:32 +0200
Message-ID: <87cxup9p0f.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: OS6P279CA0052.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:31::6) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|GV1PR10MB8808:EE_
X-MS-Office365-Filtering-Correlation-Id: 29d93483-e076-4f67-8cba-08df0ce2cbfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: pa9UO5D1MuEebdhNsDOe6eSX/Qq0gQUPpzUM8h3JSHjQVrVQJ77xKKycYyEBdFr/IJODa8iSckcYyY4BTPaSgiIM0EWz6DJVmeCEk3JMdbGxNfpbaQkHOw+xrlycjddBXpn24cPwbgT1wcVlbPupjttymGoRg9uaKbR11Sx5vB8wAFKQZ+IzxNPnsSJQJ/YrdRIHRgBCaolwb9k+HDQQ/O7lZQ4v03coalTwHse9AniEu6UewxxRSLTtrshWNWlUSA/H3GiuKdffobqhEs9ZGzeCvaFHUaO7IeR6WxiNo6ZbcRF8GHiAvLlB/U4oYFMHez8C8ClBbEYxEEK0Lq31rmsHHCvK/u9xtwQ75My9N4z/KKBhDCzvr+RAFK7HUqY9t32uT2S2sIhoXgtwhfQYnRl9K11NIDFOkf8vUC9Nk26IIRxwqI9TS+tKSRRwMYYd9QbnG43PNlRpB/VMacJGElqHquNkg2dx3e32hC/3tAIzrQXgj7miG9T980ZQKnqvRXIkl8GJC1XGXhlNsJJuv2NSrDfF/aRe8AvLoEfSQY0JEAbC023mwVKsLPrEHdEwnsDrq3Ihe3zHnUaVjaUTzbpXPNS9GjTEN6p+TMcrtlI9YW13EIQkGWHNlWkD1jch+t5nbTeWbdE+1CFoipXIN6nZCa/W5WAhRDNjTge/SpY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?338M659V/FSlE+ZpMugsmJansQHiJVlUq4Omuc0XFuirWm1gWfMb7HYXGC9X?=
 =?us-ascii?Q?IeOqQw6AxdrFYcOcG1whApllwpQAhFuvj4S8vJq9fdyoXqDd8rKBf7d1rxFY?=
 =?us-ascii?Q?vGAR8BPhATmkkjLH8lmlfqTP/1U5zraaq2rHEQjk07ilZOcmh3aEwawKlpAh?=
 =?us-ascii?Q?/0W4jfOrM0BcUmGdeJb4lhTMlA4KwRvHzEP00AUG2ZtxjD6pRv+F5V0Wuv3V?=
 =?us-ascii?Q?08NbFAY5/5WN7zjHV9MacS5mlUBC+mpjwdJVa2zGIIW7/1npQ+Y4KDqd6JL1?=
 =?us-ascii?Q?m9tFque36fr8EGtn60YZvBf4nU00iCITNCOSTl6OsUOVOh7/cIRh5lu+z1SB?=
 =?us-ascii?Q?fSf1txLw0TmRcBFZghM1mpbwYc8aJv1rLBBK90Pli/47U5zPMTmNg0QrkB/B?=
 =?us-ascii?Q?YQV2RcXKk0NfhRSYG8/pgcuHilqQsGDmridCgby7GQYHwBzlqvf53fYyvTpO?=
 =?us-ascii?Q?ep2if3FFwY8BhRIrnrSv7HEtHBdBM0rdj+6qGa+SunK1LP2j9ahxMQE8NAeF?=
 =?us-ascii?Q?Gvbd7+HX5o9KQt/sAzoRbMjQHw54DxkqEITPGU0Fytx17ADSttfvNsFWB01d?=
 =?us-ascii?Q?iax/u72qlcIVHz8/XyMWl4W1BBEjO2xsk3E+MvF3EKZeTdi9yy+yDQIsFAhH?=
 =?us-ascii?Q?5N6e02wyManODGXe7y1XuPBaqd9dLXnA1x7fqH6PHU68Mw4Vl4XSbR+cVL7G?=
 =?us-ascii?Q?qlWkYGH7kjBkSqU8SFsyVWw2/6ivxTVxiqBGAE5iAGB3c/Jg0cnFFpxDEpfR?=
 =?us-ascii?Q?1w1xIXuXWPkbUz0Ocw5vjAVHdlD6OhBFFRu9T3i1xpUT6jF5eBVadryiisQ7?=
 =?us-ascii?Q?cKj2Cwz3SG4l57XHBDJKYugXSzBAteR5Cu/iEuLgAAWgnYh59kn/4PIejsDg?=
 =?us-ascii?Q?0BfH1kPXyq6Y4qHjUMgHJXlPATG8QZg+hgd8t/aaJuj5MvbMju/xCZ6SKbhU?=
 =?us-ascii?Q?0sO8MyB68qzubL32sLm1j6XL9arsQ7BVYuRjuuqEhNsvP/tN+96BeAqfE8NN?=
 =?us-ascii?Q?C//x/M+IjC+FMW4thikhTUyJuRmuiCF4K+kE0k2BT3b7+C87pZdOEaQiI79W?=
 =?us-ascii?Q?dg51tz5WHlYt0ogkg6vdJJYMBaV/ywIMMQevyymd6DHoJuuDHIT0/XhCZ1Nf?=
 =?us-ascii?Q?x42bq+ULso/M607D/wDM4nRAScNxTZ3H2SRA05PBaWxeHv+ZRcfDK2s3VDgG?=
 =?us-ascii?Q?SrtRIZUbGYtRBKIA3K2OX9qhoie8/LX1SAshYq5y8rxXDejWGuzzXeYhfAEF?=
 =?us-ascii?Q?UHW4DhlUv9zEwY8rY6y4wH558o4DF0YeYYAlB1xaYgwCMYgA9lxacJXbmzVx?=
 =?us-ascii?Q?djt92D6vni2yurE96F39cri/PPvbwtASBoH9YUBQqOlAiXO7fNsGGMxbl6qY?=
 =?us-ascii?Q?7P6swfovaHtXMWiVIUgVRzsqy02wPgAW8Bpkh3Q+j9pVynzGGAG9roTATpkj?=
 =?us-ascii?Q?Ddw08bWgtShkrUbinRnLj2SsmKAhH/XD29TfKiUIph7hvoDLsnAnA+nVUM5Y?=
 =?us-ascii?Q?btDYAsTN6mAHF5zzCotxO7JpZcvPl0Mf09o8tDVOG8LI/sMC/VW4khLYsHMl?=
 =?us-ascii?Q?yLyKpdhZDzKUooovkgUpPF/lgYFjmvyAWMIwAvoJAHAWzCm99x8tTBZRdAx5?=
 =?us-ascii?Q?fO5vptozxraM64iENyXjMdK+kxs4dFagnKntocAiS4O0ty6nlFFm9iQHEdJc?=
 =?us-ascii?Q?vlSreNo39QuILbiwsUQmtqoeAZLHamrzJy1gerZ3d0dLtkilRI2l1MHXMgl2?=
 =?us-ascii?Q?Tqw+087FTv30MmDlx9Jwdh7xmlowv4M=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 29d93483-e076-4f67-8cba-08df0ce2cbfe
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 13:20:33.5679 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5JqKVHim2ZITQqMuO4wjImxhjYPTr4hHyG92QlruWaDnXOWqBNnigTGJbG8f+llRaI74lQ4yNvffLswOELZSN/RcJaO76WFjXEeeSCGn4HI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8808
X-Mailman-Approved-At: Mon, 07 Sep 2026 16:20:33 +0000
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

On Mon, Sep 07 2026, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:

> Hi Rasmus,
>
> Thank you for the patch.
>
> On Thu, Sep 03, 2026 at 23:22, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
>> Add the new TA_AVB_CMD_READ_PERSIST_VALUE2 definition, and synchronize
>> the comment for the existing TA_AVB_CMD_READ_PERSIST_VALUE with
>> optee-os' ta/avb/include/ta_avb.h.
>>
>> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>
> I see that this is not yet merged here:
> https://github.com/OP-TEE/optee_os/pull/7959
>
> I hope there won't be any other changes in optee_os, otherwise we will
> have to re-update here again.

Indeed. I had hoped/assumed that since Jens gave his Reviewed-by it
would be merged soonish. I'll give it a few more days, then ping to see
if there's more I need to do.

> In any case, looks good:
>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

Thanks,
Rasmus
