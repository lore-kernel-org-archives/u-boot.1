Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA96FC61DB9
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 14:59:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0E14140781;
	Thu, 27 Aug 2026 14:59:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X47gEJCzresT; Thu, 27 Aug 2026 14:59:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787842776;
	bh=clUrSHlwWj57uyxPatd+CN9U6gdE4iA7YDJ4NBJHN0w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GlbgEhl+gh0ljHVmKis8l1u38wm15ygLi5RRDYy7nqYbW4iq8kJNMzrdYhStnA6fe
	 cOFfaiDyjGOUyxlVeYLvNynvdriBrt1xIDY+87TLdKA74PLGOhWUg33TCRT3WbVwVP
	 pokvWsNg1RPKIqz8Nq8oHswrLMP/mCcVPvMlfIi0x2Tb3CRWeUZhean1A3Dq87Y6oB
	 1bVdOTiwiZ8Eo66DE4UCmdApO17SZ7mLny+gex4EKGXWJru4jwTULCvf/CVsoUx+U7
	 5WU9lFJXRCw/0DYhcbZe6utLLCjX/qjVT8wbxRRX1ipeAs1QrUVXI0uRZstH9WdI3I
	 OS5DaN801WdWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7584740764;
	Thu, 27 Aug 2026 14:59:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 75396355
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 14:59:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5B1CC6079B
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 14:59:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8uvbaMXq9jrY for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 14:59:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::1;
 helo=mrzp264cu002.outbound.protection.outlook.com;
 envelope-from=philippe.reynes@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=s3pQeGMq
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6C13B60792
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 14:59:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JD9Yl3mf3XSiEXmGJy9Ei1pmP/BnEl05RPnH06f0ctQ5XkCL7S/9pHCBvD7/4x6dTV0kbmnLVq12t5t6JydytEIZ1f3PuENQV5pvAu6pUdYEBNmzyd+sI9+EE2oPHw4QtU4A0sIo9yeAVWs1ihXbfEmtIagzxReniMUy7J+WGKVqqhrDr+qze/WXSV4r/dyjesAl/eYD/lOFyEybyFIsCwroJPA0a3NAE+inQ3fVD694cNaw414ZM0VRCUge65YchbT+jhu9biGxinChrFRhLJihAQB3k3NZGCyelyBSKw3Y3PFLU/pnwzQqHT18fNDb/pkvrALgqVWPLoQQACIJVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clUrSHlwWj57uyxPatd+CN9U6gdE4iA7YDJ4NBJHN0w=;
 b=vFfPi1vkY0QB1vd9gR0xNfOUSGW9uFZ5YEt7sSuGug2Frpr5+VvC6swec72NiVpPJsl8I66Nq4utglDAwlpflQXVb6KRH8txop2I7deOUfCdvCAhNxSP7L+aFKqKI4O4y8zjjJm7GW8wy6AD16OJU9kxbItJkWooH+zUtAlt36HfL6C2v8RtnwMqCFMI7RHNYkhxezZ5VbdgIyQAxanwhaBweS19DzmO0mIMQNvmn0NMtREefh44/JEDMAawGqnMfOw2ZBKroCHX6ufYNpxYhvGKtCDQx436JN4I+4j8V6z8WV1+mL4AKqnUN8KPEaW52L2xi+4GICHJ4m+ILhXexA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softathome.com; dmarc=pass action=none
 header.from=softathome.com; dkim=pass header.d=softathome.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clUrSHlwWj57uyxPatd+CN9U6gdE4iA7YDJ4NBJHN0w=;
 b=s3pQeGMqQA4/IO91qyuxYVQ3nI2XW5Z/vYKk4u79L2CCGoDwxoWGiqtrwszEW906PSclBe82gYRRGEOC1Pv96N6ujzSiq8ElLjHSs5d9pX9J+hSTLlkCfoZHpm+qa5mgKbiUEQgKk6z5ahRGIMNJBKIVfKEeWc19NXl3QBvSiggooejAAk2tGNTjRxXx5SZigh6EiYc+CJSWAsrXAUWZgpOopmg6lj7RDLb4yV7QIeoSVcHEfLbZLSdmiqWqB8yHKqt9TskiCAmQs6VWt7aGUrnv/62P2h0MgGApurrxtc4XVms73ureiVgAh8MG09xEFrbZW7wTqo+tv0rYTG9lcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softathome.com;
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d0::9)
 by MR1P264MB3505.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:23::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 14:59:26 +0000
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6e14:438b:5c18:8557]) by PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6e14:438b:5c18:8557%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 14:59:26 +0000
Message-ID: <7655d8b5-af60-4ef5-9ef5-18419e12d3b6@softathome.com>
Date: Thu, 27 Aug 2026 16:59:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: merge software ecdsa support
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Raymond Mao <raymondmaoca@gmail.com>,
 u-boot@lists.u-boot-project.org
References: <02ea1132-9adb-4f07-b14f-9648a61a8021@softathome.com>
 <20260806200154.GA165443@bill-the-cat>
Content-Language: en-US
From: Philippe Reynes <philippe.reynes@softathome.com>
In-Reply-To: <20260806200154.GA165443@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0105.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cf::18) To PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1d0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB2741:EE_|MR1P264MB3505:EE_
X-MS-Office365-Filtering-Correlation-Id: 394a4ce6-0153-43b3-b041-08df044bc9e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|376014|23010399003|366016|10067099003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: KF6PjTmQL2UKbUqYy0e3pvpdQibGCBZ93wYqb5g2nfKvsawadyvbMWCqJ5UpqF1dfme2Thv3gc3SAI3wV8uqt+MvsfFVHpAeHvfFyrQrutDtemJ6l4nCeLcslijH+ReVf/+3mvh3XTlOkjL4hP2PBlMind7IfeW4Z1xvJSx1sr4n0KVoEcaeNsjIicA9IAWTByM8NmOWtRahC8hBwpKPxvQCYPx8Kho5CK3R2VBDvmyWvt+cnWfQjDiTrl3EpTzwKaiOd9Axo1kO0gUHQkDxRIgzlUOuvg/ecrQkJ2Qcqev9Mo1ZteC/Ud/ilE1UYbUBVu/iCyGS6aQrzHy05WrwOKDQVBUBuRsDBgtJ01DstYtRGMqMcMPkiZe0RhWCRiwXzNPtxpbgefUCTseqe5eUeTXE4s/oSRTFzsFppEFd1nv+d8Y4LZ4ap0drExPYUSA15kxPwXtwSDDZ+gwPzzqFkNik/uKlCpYsExQGwaY1UrozwRDMiuYILpNYCeaTQ9ENBajHtwKDDquAix54htUuqo1AL4fbCaJCpBqqRj8ztaqj9U4amd9RgRGwkNkeE8ZwGpWAKKITXLPJN3aCwR2S4MCdXACEPEMX7ax+AArVvkFtVbEM/V3TLRVRT4PLdYGO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(23010399003)(366016)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDFncldVTFhTMUkveWFlc0tmeHZQUlVTbUREWmhTUUx4U25KYkhRd0tHY0VH?=
 =?utf-8?B?ZjhhOUE4clEyd21LWG9Xclh0YXZaTUhvdFcyVlFGcDFHdmVHZmJEUFNmeUNX?=
 =?utf-8?B?MlhUcUxLRHZ0WjlldjBQbWNnM2FNZThFWjBjVTk2SnR0TnM5VEVvaWxSUnFs?=
 =?utf-8?B?eDdEUmlZM3VyQXlFTTJDZnZ4QWZYSWw0MGFYeDVjNUJOZkdYRXoxWDgwVUV4?=
 =?utf-8?B?RVVxRkRsNWZBQlZndmF2bWZPYUNaUGJSd002ZkxPb1N2UU81SUxnYXI4aHdz?=
 =?utf-8?B?VHdGUGdwbE90RjBYb2c0NmY3S3Y2NllWcWNjSlNXc1d2eWQrU0o4eGlaSlBV?=
 =?utf-8?B?OTdmQThMNmpQNy83L1Q0bitVTHQwNG9VUjRVVERvWXpjbWt6aDh1OXM0VW84?=
 =?utf-8?B?YjdSTDVYdXdwMGp5WkR1T3BUL2FDOHlLTHZWMUNaODNsYlhPOXZLOWE1L2V6?=
 =?utf-8?B?Tm9PMlMrTWhPTG9lSVhHRkVuMlU2SlRsV1VxS0g3Y2JLNU5ISmFZL29nZ25T?=
 =?utf-8?B?NE5MMUphNnoycFRWU3hFckd2U3RONThLcDRtYXNZWDAvem1YbGlLRG0ycUpv?=
 =?utf-8?B?RGkzRVlQbFJWM1l5SWNuWXl0Q0VmR3hPSkpTQWFiUGRWQytXV3FSR25jUlJl?=
 =?utf-8?B?MU9MK21LMzg5emJFZldLd3hyTmRUV2lQMlFUbm1IckFZNlZHdjJQWExVSUlU?=
 =?utf-8?B?RGU3M1R4T1B5SnRiSEJhWFZHVkErQ0pnaGhaQ1hDbW9Eenp3MDJIUERVUzFK?=
 =?utf-8?B?NGNyN1hnYzZocWhNTlN5T1BJNUZseGczVzRjZnVDQSt4UExuZEpVRk5xbWow?=
 =?utf-8?B?cFpXQ3RERUl4NTZPV0dFbkIyVGdXK0FwZVhxOWJtQmt2RXdnak8vUzhTWFBS?=
 =?utf-8?B?TFAwY0ZKRWRyVnVJelQvY3hFYi84MlRPbmV1YUEyZVRTZUUycERQWGZvcnpP?=
 =?utf-8?B?QUhZQkFnSTRUdkdHbGY4L1h5MDYwd0hOeUd1eTQ3V3BQWjhkRE9SN2dvT2k3?=
 =?utf-8?B?RkdrbWc0R2M5bU9kN0Zjc0NvVUJaYWVSK2toYTRQTHl6QUkzU2JIak50NkRq?=
 =?utf-8?B?dFFZRkhBNER5ajJaUHErcUpKbml0L1lhTDhzdTdoTXlQUHh0L05IM0xGbHlS?=
 =?utf-8?B?VWRMbkZQR2liMm1zY0hwNkZBa05GUTZETXN3eGJYeHM2RlBDUWdCd0d3TE5G?=
 =?utf-8?B?Sk1zM1REb29BQUdxSTM5bVRhR3NyMXRrQXBxbEd2K3NFSmRYNlVqTzh1SDhX?=
 =?utf-8?B?SDR2WnVvSVhUeHErYnVMYUIzKzlXckVkcXZvaVFwOTdKT0FNRUtsN0tFcTMv?=
 =?utf-8?B?Q0RIRFdTWEhPeWhTbWNYYytGR1J0OW5IK29BUVQrY1VCSzF6WkRTa0g0TS9u?=
 =?utf-8?B?cFNZMXNURHpPb3Fmc0M2ZkpQNlVxYWJNUXBpSm5FSjJrN2pINThDdFlYZU0w?=
 =?utf-8?B?U1VzZEFYV25wQ0VHVmgxb0J5RTA0bWM0SGc0MFFkV09nZTluYmg5aEtqNGpt?=
 =?utf-8?B?VXBMTFBlNEFOWEx5VnVCazVGRG1GZkFyVUY0SG0rek41UUQxZXkvYXgwLzRq?=
 =?utf-8?B?ZExWUlBUeVFkL2dmRDJyT0FSR3lRaGVBR0xDVmtUTEVVeXZNbzhJWXJJaE9L?=
 =?utf-8?B?bDVpU1Y2Z2FlRitiM1ZVbEpncUFpTng0Tnhxc3orakdCM3Vyd3pjRFJaZUcv?=
 =?utf-8?B?OVdtclBZc0FjY2pIYUEyUGN2WHZibEx1SlBkUTBIZitGbHRuSVBvYmxUVko0?=
 =?utf-8?B?Z2xQQ2ZFaDE2SzFCcnRtanE2czZFRHZGWmg0N0pBcms4cjAxK05PaVIwbmU3?=
 =?utf-8?B?L3BVT3R2RkNBQnNJN1FJZytydFV1akUyUDBDS2hNeStmMjJMZ1JsR1hzbjlv?=
 =?utf-8?B?a01GL0JrRHdtRnhXbTl3RU5uWkZVQXh4OHEyVjNuMmxmKy94aWh5V2ZJZFlE?=
 =?utf-8?B?SXlDTzVBbzNsMkpiMEF6YzJTYU1zalJlOGxUaWVjTWIxd0M0eDllWlNVUXJz?=
 =?utf-8?B?b2NGOCtOZUJtYkhWMlJJT05lZVpKVnBRZlNyQ3VGTEwyQktXV1B5Y3BBZHBN?=
 =?utf-8?B?OFNBWStXamVQeHU0eEN2blV2dEo2UlZ3ZG1QLzlyMFM0VlRzZHl2TjdzRURM?=
 =?utf-8?B?TndFM1ZweVZrQUlZMjl3d1FrQnRpTGpER29pQzRPOHZtWjNRRWFlTDNzQmRG?=
 =?utf-8?B?cTBHNS9DRTdNbm4yMDhMZkp1aTI5cWNMZUNjakorNFBjREpEaW8xTTcyMjBP?=
 =?utf-8?B?ZjM2N2o5VGEzc2NmbjMxalVUVWpSNXp0dVd0OW82YzFqbHNTakxXa25RLytY?=
 =?utf-8?B?SGdrRWNvT0ViUWdiOXd5cC9sUnZXY3BjKzd6SFVVMmt1NWlLNjI1ZEwreEZi?=
 =?utf-8?Q?s71uSB72+HkEC73l17r5YoG3UgnlpC+/S33Wcze+YUzCw?=
X-MS-Exchange-AntiSpam-MessageData-1: B/jAQMCzrfb0wqWnTmB2v6y2NirTUYxJFzE=
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 394a4ce6-0153-43b3-b041-08df044bc9e0
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 14:59:26.7246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJrjqxUWRJOgh3OvKQxL7oPeYevrLUD8xrbOAecwqS60z9WyJo1l+Lg79Fen6tzdWPUPc32S/2DW0sg99dVezNqtN/W7+Uh75sMML3AFBIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3505
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

Sorry for this late answer, I was off.

Le 06/08/2026 à 22:01, Tom Rini a écrit :
> On Tue, Aug 04, 2026 at 04:29:47PM +0200, Philippe Reynes wrote:
>
>> Hi Tom, Simon and Raymond,
>>
>> Do you think the support of software ecdsa may be integrated in the next
>> release 2026.10 please ?
>> https://patchwork.ozlabs.org/project/uboot/cover/20260601134310.2452454-1-philippe.reynes@softathome.com/
> At a glance, it looks like the feedback I gave a while ago about having
> it be enabled by default in some config (likely sandbox) so that it's
> actively tested and compiled hasn't been addressed yet?
The options ECDSA_MBEDTLS and ECDSA_VERIFY_MBEDTLS are enable by default 
on sandbox.
Do you want that I enable those options on other configs too ?

Best regards,
Philippe

