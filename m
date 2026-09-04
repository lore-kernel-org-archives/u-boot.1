Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74569C624DE
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 12:44:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1848440BB8;
	Fri,  4 Sep 2026 12:44:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5mZ4ZIsSwfxF; Fri,  4 Sep 2026 12:44:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 48E2340BA4
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788525864;
	b=lzFQkCs42+DmO9GdmW/HanAwRtDe+8M59299tjQyxV4/RaTuoJv7Yj7brMDnUagRjSuz
	 YpE6kDQa9o49uynpfSQC56xfh/t1gOY/59kcRgoYEVWk5JN4AYpn1yioD7KOC7UDvufcG
	 wZGDkXcGzAR70WSMDz6bOQAc6q1gur717GwubrhpEflr1JbFaiM9dvQ4JtlruWLE93X+O
	 seVDJrho06jvEH9y9dQtoBij+fjHZry7VHyjszycsRBOSzU2dC3gTdQVCPi1YRrmDaa8s
	 mfuc/nqx8xHBdMD0GZ29J3Z7Ar7lhNOFYGTl4buLhS0ZtAWjm6NvaggEDgzwcXnr02w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788525864;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0rEanwO5N6MM7UrpSCJzyqb/fSppyIjDd+6X4RBa4lM=;
	b=RRNGU3Ly9d63A8ovvEnml1qmwBt1MQypDuAKFk7BCC8tx5l4VocDQ86u/nCT6T4rMei/
	 OqXMTD7UvUdnYwbiNGko3HCo5NaiXtRybRmpIPYUc2DZuSHc5fpLuvEzE0vc4s4gCZrDD
	 9Op0+Wt8mM0XPa4g25B+FB+KkoaoQSj2c+OWb68FKUwf92heFPVGQ3YaNxzVj6be7eLgx
	 Osm5tRCYuhNskERkGtw5XNsag9ctGJiqoFuCUJhBFVfQE2ukMuoL7i7Mlv1ZvQHBkKiPO
	 hspacRf9jLPxsUuFKTQKeo69ji60aKa5gDxVk486VbIrhqJqUMVlzUc2P2IeyzZVUKA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788525864;
	bh=0rEanwO5N6MM7UrpSCJzyqb/fSppyIjDd+6X4RBa4lM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Yr1AXEtvFJKEKLaBSo3gMethZ5T4U0XQawVsrV+FL/AVpRourgPW4B5aMPkDLVjJs
	 3XsekPt/zqMsSqpuNCNvEc362QoLruFSBUCYt35kBz7PezD8WxXux9PvhYWB/uZTMY
	 nDptOVKjQg8vShLVNIEaRkY7Yl6AoiSVsT6RcXGbBfc74mNC4U4zGWLW9oozt/5EF5
	 sgH07XHDeULL+XNGD5JUivgx9TzgIJ7faq0wR6To7lZCgPUNJMboiMmc+qWuzW8ey3
	 SFvHt6BBZf3KXHNeu9Qh3T8vSYA8qdpaAL6tIXv0HYk2RTZd4H+fXjLqa5tilv0DAm
	 j02f75bWfxpIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 48E2340BA4;
	Fri,  4 Sep 2026 12:44:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2CCBAF14
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 12:44:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1E8D140441
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 12:44:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ouG4aOCpvl1X for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 12:44:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 4141240376
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788525862;
 b=exwi6VMhaq3epbr7CKDjg6aJsExCIP6zqM+7bR4J4TPm/LFQDzsA6UzPPoBlMDLfNU1c
 amZfe6ZQb4VuVJAin8G6zfIYAFGEQd2GcJDk0kL4KT8lceJMYPRx0yDOwqA9M18WMXMNO
 Fz60VShhPzD7fa83Y8daRCMCP+z0Wr+E++YH5NAnRsoKAx494JReiMt0duoraUwLEsL4F
 zE6VsGVGbbj9G/Np4GDJB+i0MyGteSwkqpUvGg+rQeYOdgDeZDezBh80h9Unia16TWQi8
 kpDU7t87i3/xP8pDMdE0cqvLCJ2o1ld7Zuk++lEdWw1NMM58dkwUN7ao6eC5bMvvT/g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788525862;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
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
 bh=0rEanwO5N6MM7UrpSCJzyqb/fSppyIjDd+6X4RBa4lM=;
 b=DZtAoAaaltC61sgJJuDq0hIGwY4+LjNFzYlizyF0xqcCeSCBzW5Ua8h9OJry5js22MEG
 2pe6HuWQBmiGxWGgNzBSJZxUsK6VczB57OaLz2JGl+lAv9141JKRiJuoBnAIelmm2iGip
 sPrTJp1gCUv/KeQWh6X0QpBSKrP4nNCAqjbrI701nWV3EqXBl3Rd1I3A9H/b0Pm7kcC57
 Ju7qAp7Tfiu1zYmjuLNQH6x4Oy0ESSJOeOevtBYJYBmAqBdxWpgmPW230mb0Aw5oZWZZp
 eNnSq1YbThVw+BAr1Dp5Gi3dlSgIn1UncRpSbkc2H3O6feie5Fkntr6QcS92M7AL0Gg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=atbbkrMV; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c107::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::3;
 helo=ph0pr06cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=atbbkrMV
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4141240376
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 12:44:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IK1wMVixAasnvz1GBPcs5U/LHK0Ns1GXsAxqBVH5kgcVD5yKudcSkNmjG9zDRZZhku1AvOr2DAtbMKSMBFuli+1LDQyIpbgODzLtO0EqOdGWc28sEKKOWN4LXzu1WsvrKdtA4Tcaa+GyVS8dxyihlIygWc4wCf9+pFYprz0czVnSovbbaqmPLQEC+zsvznaUMVl3ri+h/FKdVQLjizyGbmSdpxJxv9XL46vviaHnh4o8jMOZQ1U1PYEmCI2W3duwm7MNq50oaihc97tw0SCT63hlLfUTgoagKUy3UXPzx6zFYQxKBs/WOSmyi4Q239f6ImWQ/RBtHQOZlxNI7V//aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rEanwO5N6MM7UrpSCJzyqb/fSppyIjDd+6X4RBa4lM=;
 b=qrf0+q45yQvGQyBWil/NFzYLqQa3t7esiUSuoTMvGsoj5HgCq7AOL4nQmiejH4YxPqwm4jQYiB+a8ZDoBcvmuYg+D4ig9qQ4Vwd5XUtXCyjoDme+ZdySi13ZJH4LuwlB1K4ml43Bw/kG6okpwJorzOKm88MhPJNGV6NcKm7NxMlko3pQjoA0mwPsfgYGhRfqBhHwTrMn8lPAYR1jxueaR32tj2AMAhDmzhXgMzaOBlW1QKzjRob59WgKbBQMBcviTzTftRFQirLC/kfoPk2uEh2pVcfOJCcJu1UKTCLuUQeZ/m/80XWZSK9J28zL/Sk0R5CcZ2HbEl95hCiIiNejng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rEanwO5N6MM7UrpSCJzyqb/fSppyIjDd+6X4RBa4lM=;
 b=atbbkrMVFE5gs69ra2U6QoG3KbjI3PaHl6jZkONRxnseJ/mcPIhD8/GU7jLPCCABv6XGm1gErHeHS/JUnzjlCYNfpeTcJHCUJfHaDmbJprjEqlkgfpN4ckxTCT+e+68mlmu+5Cjr3g5Nlz3Nm+WkKxSTSYG13V6rra05cbmFYVA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CH3PR12MB8257.namprd12.prod.outlook.com (2603:10b6:610:121::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 12:43:59 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 12:43:57 +0000
Message-ID: <e3473f7c-a36a-4607-9945-22363959ca55@amd.com>
Date: Fri, 4 Sep 2026 14:43:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: xilinx_spi: fix premature transfer termination at
 low SCK
To: Suraj Kakade <suraj.hanumantkakade@amd.com>,
 u-boot@lists.u-boot-project.org
Cc: git@amd.com, padmarao.begari@amd.com, Tom Rini <trini@konsulko.com>,
 Jagan Teki <jagan@openedev.com>,
 Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>
References: <20260813120718.1707573-1-suraj.hanumantkakade@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260813120718.1707573-1-suraj.hanumantkakade@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0119.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::17) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CH3PR12MB8257:EE_
X-MS-Office365-Filtering-Correlation-Id: 401bc537-a2c6-4288-b372-08df0a822fbd
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: l5NKTjjTuLpUtpITg4cqWpiHZatWmN3x05V+o+3XgfafxqTpJvthoTfC6fxH+VPyXVKfbrwcJYOz3OjLh65QCj5hoWy54jAl8NpHSUvQq5XqnFjM7dYWYdNH2e91DIdXkvOuKJ+7Uo60WSG0WZfLtFCxnYHbBpL91ZLC8CwEATXUHRD/4BnVcGcpxY9aqetZYGxvjooUVfXuaa5a6vo0Py9m9pcS9L6KDIAHOT8F5QJXRzyI9Is5OZ4yy/6wFxNdcZoKBjTOgI0a/AWen2I174dz+KAvKl32spi+FNbAE4OjZ+YBK6SnwIELjObItKHiDhmUa36x+RFfnKU4blOrdqC/Ayadp1VdzDiSoHB1nsjkFe4RaXWC5vpEqdQ4Hwl73m0kIvyK94f5yCu7VPCkjWUpdIEe/5vuop091hMXusH3UFRoPpJa+MuVdGPRRnlDGtLivnCuUIgdHPdHUyM6zgUDNkuEnCfFZGYOJV27xq0COEbYDsthQRKrS0CuC6NfcbYk4nsiZNP0KO9Ilnq6lMwXTwGM7IlllSCvg45/BMODZDONis4FronBCEPbxCpVlEB+JaN+/XftnxpgKz/uOcF9eS0S7hVUOZ8fq3ooDjlOlrCT9bZb1RlTDwzqkcfFMgUxO5od+DT/UKNSdAXGuUB1fjhnfXxKSsUyceRl/mk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3JhNTFnbUpoVnAxYWVCZUZyNk9GN0xkV0FVQXF2ZlFZTWgyUlZGUDVoMkRI?=
 =?utf-8?B?WTQzcjdLQkxWMWlMMEtJUmE1YkxSeEs1UmhpNGRXWmhIVU5GelFjOEU0em9w?=
 =?utf-8?B?U1E4RnJ5VGpSVEN5OFhWeHJZcERGcWxiYU43em9uWW1admg2SjdNNmFhd0pY?=
 =?utf-8?B?UzF2SXNLei92cmxBK0pmR3ZBU2QrZjFhTjZIek5kam54K2pEUnRwcXd3eU95?=
 =?utf-8?B?SHc4NVJ4RzlyTUhNeG5iQWdiTjZNMmV4WE5GTWJYQzVyMjJBdGUzaytqN0lv?=
 =?utf-8?B?NDNpNm9EYklTWXQ3S0JNYUNYeDk5YUY2d0hNUjFSdEpiemZFREd6TEZqaklB?=
 =?utf-8?B?TU1Gd3VUTE5qV2Z4andwT2VCS1VCejFtWmlaM1l1UXJ0UkNwM2F6L1BGVUV3?=
 =?utf-8?B?Sk1IdHhLUTlyeWVTOERnM2t5bG4zdXFjRVNKdEpSc2VtQWJVaVYzTURONlhw?=
 =?utf-8?B?L05mblNieXF6M1BtTnFVeVplRDdaVU9LT1MxTUdTYWZjaFlPNllrZWtXcWpX?=
 =?utf-8?B?clhkTGZZUlczbGxSRlBOcHgvSzZ4YVdBSmpIRlNUTTlrRnpvOVJBczA1OVhT?=
 =?utf-8?B?M2t0OENtK3B2M2F3NjFKL29CVGo5WUJlTVdzU3I1c2xFaUhJQjI5NE9lSmwy?=
 =?utf-8?B?c1YrYXFjR01VWHFrTjY4RjY3bzlISDhCK05Gb2taUEIzN1YrUkE4K0hhVFdy?=
 =?utf-8?B?MlNiVTRBUE5yWk9HTFUvYk9LYkptUEtSTS9JZjkyRGwzaVhPSm05L25pNzNW?=
 =?utf-8?B?T2JCclRyTHhPOEdicVlZd2k5TnpmWTlwQWRRdGgyZlk5VmE0Rm83eVhvdHc0?=
 =?utf-8?B?NmhtYUFRcEtXV3ZVNURUYjAyenB0eFJRTkxRNDZMWndVSmdpMjJlYjNYdjYy?=
 =?utf-8?B?M1NXdUY5TWlFakQ4Q0R5V1BwalMxa1FobEFSSDhtTm81eVpHelFncGc0L2p4?=
 =?utf-8?B?TG8yY2VqVFdTMDNUTGE0ZC9uZWwzN2VIVTNodTVPNHE5Ylpmc2FsTS80eEVS?=
 =?utf-8?B?NkdVYVJ1U052b3JhZm56Ylo4Y3ZnaVo2SWNjaVNEMnZKdUEvUGExK0lXaVlK?=
 =?utf-8?B?STdhaERidG9MbkhJS2s1ZXN2c2I5TCtIWEhmZkdwMGJXN1hWSkF0dHViK0hN?=
 =?utf-8?B?UitLc3EyYVUzTW5Vd3FVOFJWMEN6aFk3dVpBSm1PZW9HRDBYYUF0eXEyN00z?=
 =?utf-8?B?ZVhoNW1aNlFmUDgzNVZ4VEJ6RDQxSlpxRndTVHQ5K3RnLytoS3I0NXBzcVRG?=
 =?utf-8?B?bmh3V1RtTWZaWWVteGFoZWlsSWtON3Q4K1dzQkZXazZibTlHUHYwc3ErMkhY?=
 =?utf-8?B?YXhsQ0RGeVhjYXRoWVNvSklqRmtlSVNaMncyd1BoL2R3aVAvcG1RTFhKVlJO?=
 =?utf-8?B?T3hIU2M3YmRFbnFsaXBzdkhTRDNFODJML0tNRERCOVhPRTJjODZnTWRpZjZr?=
 =?utf-8?B?b2tRNGViaFNlN0NKTHp5K3ZGdmM3U05IcCtxWWFBQjM2WG5vakhOQUNaVHBs?=
 =?utf-8?B?U3VCYWdlaFN1TVNtdnhPZGZhY0UvaS9STEQ4a3ZTYjJ2YUxjNTNBZk5BS1RH?=
 =?utf-8?B?ZVY0S0pxY0gyNzByRXBEWUNicUM2VWNHM29kS29hL0pJdjZsTXk4MkVDVHRX?=
 =?utf-8?B?ZUZ3K3RPOUduS1VaZ3hpUzdJM2gzd3E3ZGFoMzhRbnB4Sm5RNER2WkF5MHRy?=
 =?utf-8?B?RktFSzdadm1FdFpmeVJZU0hDRnFEWUM1MGZlNXE0U3NSV3NQUWxtRVFDVGRk?=
 =?utf-8?B?NWp1N2NGNFZ3Lzl3anJLUnlyd1NPT0hFbGl4RU1peXZTZnFWOWRVREVhU3pM?=
 =?utf-8?B?Q0huMDNrSGNRYjBUT1Byb1EvMzl4RUV6U25mUldYZDFHWXU4RnUxSnJ1VmVy?=
 =?utf-8?B?bElOaEtUazZtZzFRL0hPNEFWNyt1Q3EzWko5ajMwSzh2NExhUGJDd3Vkd2xD?=
 =?utf-8?B?ZVgyMmJrSUhkeUdTTzBxYmg1bUh2NGpmMHdYK2wrTDA4T3g5bUs3UjNKNGxu?=
 =?utf-8?B?aWJ4Ni9LTUJDR0QxN1gyQ0tHMGNlMFNid1MwOHB0U0FnMG82ZzZmcUJ0dlFL?=
 =?utf-8?B?VEQzcXJUVG05blhYOXRleERYMkJobEp6Um5XZXI2Uk5ZdktpY3RWSEFKOXR0?=
 =?utf-8?B?MjQ4bSsySk12UEk5d2lHeXlLbUx4SmU1Y3ZPOE1HNk5TSXBFZEV6TWwyRFc5?=
 =?utf-8?B?aUFwUDI3djEyVU9BNmlWVVg0LzUzZ2RtVmcvaEwzcWtXSE85dTJucHIxQ1hl?=
 =?utf-8?B?cDZoQVo0cSs3WVhVWUhxbnM5N1RyOWhXa2lRSXg2bXdwVGpUb1lyVTJSOUN4?=
 =?utf-8?B?NXVxTnM4TjliaUVoQURNNGJreU9pT3pHampnekJ5Ny9Md2xETDlNdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 401bc537-a2c6-4288-b372-08df0a822fbd
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 12:43:57.4601 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2/MGusynze4NrOq9AEJAT9ffc93iioCt9bgCnxf0p+tLmFRmQsmKtG9A8OGU0M6w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8257
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



On 8/13/26 14:06, Suraj Kakade wrote:
> start_transfer() asserts SPICR_MASTER_INHIBIT as soon as SPISR_TX_EMPTY
> is seen. SPISR_TX_EMPTY only indicates that the TX FIFO has drained;
> the final byte may still be in the shift pipeline and actively
> transmitting on the SPI bus. At low SCK frequencies the gap between
> FIFO-empty and the last bit finishing its shift-out becomes wide
> enough that MASTER_INHIBIT gets asserted before the transfer actually
> completes, truncating the last byte and leaving the clock generation
> logic in an error state.
> 
> Switch to polling IPISR_DTR_EMPTY instead, which is only set once the
> last byte has genuinely finished shifting out to the slave, and only
> assert MASTER_INHIBIT afterwards. Clear any stale DTR_EMPTY before
> starting a transfer and after detecting completion, since IPISR is
> toggle-on-write. This fix works correctly at both high and low SCK
> frequencies.
> 
> Fixes: 0c0de58f7b30 ("spi: xilinx_spi: Modify transfer logic xilinx_spi_xfer() function")
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>
> ---
>   drivers/spi/xilinx_spi.c | 21 ++++++++++++++++++++-
>   1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/xilinx_spi.c b/drivers/spi/xilinx_spi.c
> index b2af17ebae9..011bbc93076 100644
> --- a/drivers/spi/xilinx_spi.c
> +++ b/drivers/spi/xilinx_spi.c
> @@ -53,6 +53,8 @@
>   #define SPISR_RX_FULL		BIT(1)
>   #define SPISR_RX_EMPTY		BIT(0)
>   
> +#define IPISR_DTR_EMPTY		BIT(2)
> +
>   /* SPI Data Transmit Register (spidtr), [1] p12, [2] p12 */
>   #define SPIDTR_8BIT_MASK	GENMASK(7, 0)
>   #define SPIDTR_16BIT_MASK	GENMASK(15, 0)
> @@ -256,6 +258,13 @@ static int start_transfer(struct udevice *dev, const void *dout, void *din, u32
>   		reg = readl(&regs->spicr) | SPICR_MASTER_INHIBIT;
>   		writel(reg, &regs->spicr);
>   		count = xilinx_spi_fill_txfifo(bus, txp, txbytes);
> +		/*
> +		 * Clear any stale DTR_EMPTY before starting. IPISR is
> +		 * toggle-on-write, so only write (toggle) the bit when it is
> +		 * actually set, otherwise the write would spuriously set it.
> +		 */
> +		if (readl(&regs->ipisr) & IPISR_DTR_EMPTY)
> +			writel(IPISR_DTR_EMPTY, &regs->ipisr);
>   		/* Enable master transaction */
>   		reg = readl(&regs->spicr) & ~SPICR_MASTER_INHIBIT;
>   		writel(reg, &regs->spicr);
> @@ -263,12 +272,22 @@ static int start_transfer(struct udevice *dev, const void *dout, void *din, u32
>   		if (txp)
>   			txp += count;
>   
> -		ret = wait_for_bit_le32(&regs->spisr, SPISR_TX_EMPTY, true,
> +		/*
> +		 * Wait for the transfer to fully complete before inhibiting
> +		 * the master. The final byte may still be in the shift
> +		 * pipeline. Poll IPISR_DTR_EMPTY, which is set only once the
> +		 * last byte has been shifted out to the slave. Asserting
> +		 * MASTER_INHIBIT before this stops SCK and truncates the last
> +		 * byte, which is observable at low SCK frequencies.
> +		 */
> +		ret = wait_for_bit_le32(&regs->ipisr, IPISR_DTR_EMPTY, true,
>   					XILINX_SPISR_TIMEOUT, false);
>   		if (ret < 0) {
>   			printf("XILSPI error: Xfer timeout\n");
>   			return ret;
>   		}
> +		/* IPISR is toggle-on-write; write 1 to clear DTR_EMPTY */
> +		writel(IPISR_DTR_EMPTY, &regs->ipisr);
>   
>   		reg = readl(&regs->spicr) | SPICR_MASTER_INHIBIT;
>   		writel(reg, &regs->spicr);

Applied.
M
