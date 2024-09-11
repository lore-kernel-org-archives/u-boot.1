Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB1CEE4997
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 11:23:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 311A389258;
	Wed, 11 Sep 2024 13:23:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v7jqw6Tv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0073689279; Wed, 11 Sep 2024 13:23:55 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::60f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3421588CA8
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 13:23:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IZg4PZWdSTqP73h/Z7yX5Y4wKH64dcjrjvVhUe3RJuNucRRWbNSSwR2KM65VOBQcml3zl+iqoNzUZWPrIxD9y0A2CexeQfGZGiYl2/6MjEt5LlyRZK9pFXiaeFz0MltzmNjUbELwa80pbsH3S3aOFex1lH1Xqbznfr1WNrtFq8IJweh0fJdBI1HSfT+4IaX6SwFL3csDV09BBrn9wdEWP77WmYK8JHPeUrXryxjIX10Ter8hrW4pzxmb9iHuo6GPAaYEJsCVCO031JnX0XwzMsQPiH1/sipCQ6GFILvJKk42zO0q40pJmgSYW40W+ZCZO+FyW09EsAjItrgOgRsxdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsx7Z8vfB1CrabuKGQIDQGgfLbp2nF2qc2fTc3/YNoI=;
 b=wlGNCuHDpms4Dn0NEdRdA/YdBUq5Q1yPR4ipgb19TWLox8yAj00Be28X5UdHF5jeS1Frn5/wNLnT/DaGSSlA14yAJUAUJZYyppEC/lF1ynqXGrQh6qjJM9S0+ko10xeWpoZzqStlL64CQyWj0mBIxnwbCbgFwjRhuuletoInVeoZ/npzjI80igUyMgrSgaukjZO/RvHV0Dxljr/qds6b5EzHuCRv4qdKl6hQ1+CfXErw/griFRp+Tn7EOzMBC917uVYRcKNWrzxvuYaP6YHfV9rvTH4EfjpXG/WPNPfaTOWjmed7n9Ee2Y6KsjsAcA0qk7jkLQC8eomBKzjkqmRmeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsx7Z8vfB1CrabuKGQIDQGgfLbp2nF2qc2fTc3/YNoI=;
 b=v7jqw6Tvoo/GsAg2VHmn7/iSvikNWgSgO0SUpjvNa/1Ke/OfF/hIlzdmvONW0pq2Nlo9bZOwvwXjwMqEpcr11Y27Ds9sTL5zr4PKdJxvEumtpT5P0xcFdWIyQjJm72J7p/Q8wjSfnOR+CvE73Eeov1koNp5JgkhI/4dVDCjPfeU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SN7PR12MB6957.namprd12.prod.outlook.com (2603:10b6:806:263::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Wed, 11 Sep
 2024 11:23:48 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7962.016; Wed, 11 Sep 2024
 11:23:48 +0000
Message-ID: <3f149f20-7663-4e37-8a9c-52e4f87b62c8@amd.com>
Date: Wed, 11 Sep 2024 13:23:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cmd: sf: prevent overwriting the reserved memory
To: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Prasad Kummari <prasad.kummari@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, venkatesh.abbarapu@amd.com,
 padmarao.begari@amd.com, git@xilinx.com, jagan@amarulasolutions.com,
 n-francis@ti.com, d-gole@ti.com
References: <20240910154344.1837906-2-prasad.kummari@amd.com>
 <CADg8p94Fc55EYFVca8V5NPq6xWePgLhV93ebRfFEf-H_GoFgpA@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CADg8p94Fc55EYFVca8V5NPq6xWePgLhV93ebRfFEf-H_GoFgpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0037.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::12) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SN7PR12MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: c418baae-907f-475b-f915-08dcd25434cf
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFdMWkNXNlkzbGpGQnNTMTdoZ0VtN2ZtNnN1c0J5eS81UE9ONWFmRXlwSzQ0?=
 =?utf-8?B?cElJUXNwQisvV05ydzZUWUpONm1oVCtVSDU4Q3dSOFpzUDY1UTZ4L0FTVkIr?=
 =?utf-8?B?LzNBdmppZGJ3dittZ2xLYWc4T1pYaWIrSk9iL1l3eTJ3OGllZi81dHJTdjFw?=
 =?utf-8?B?akc4UmcrWFJvOHBPc1NFNEdvdTJPeEYyc08wNm5Pc0s1ckNoNUVFMFl5NXh4?=
 =?utf-8?B?QllqcHRYdnpSVy92U1hCM010WkpxaGQrWlN0dTNDcVhiMEs4WWZXMWxDUW9i?=
 =?utf-8?B?WFIxVE53SFZLa3kvQlVodEtuUlFhZmt5ckJ4UXFrUXFNN2F5Y2pFNzBsSHFt?=
 =?utf-8?B?SnJvNzkzS2tsZ0Rmbm0rMlBpZGpING1heittaE1SYjF3SWxGR0ZaOEo0WXFE?=
 =?utf-8?B?NjhQRlpRd2RNbExSUE9HdkttU21HTWEwcTB0M3VGTGdaZFl5aUhyQmNMRFZC?=
 =?utf-8?B?dUlBc2dlazJDaWRFQy9qTjBQWkFNS1I3M2FMMHRWK3JKRUhRNHh0dmhBbnhx?=
 =?utf-8?B?dUwzVnZ0ekpHRXRnVGtrQTIycUpsa25vRVRmN2crMExpSS9ya0VZMzNQdmlk?=
 =?utf-8?B?N0dxb1YrSVFQWWRPR3liTDBoQk5HR3NTYWI0K0hrVzdlaWdHMklCVVNSWmNu?=
 =?utf-8?B?bnhTTmFVKzYyYTVQNUtuSERwWms4RGN5Mmk4MlJzVEFvYkY5MmFsV1ZMRWpu?=
 =?utf-8?B?OERBSFcwS0NDNnJJbndQZDR6VldjdHYrMHJQRk5XZlB0bzBFSTYyUGE4SXQw?=
 =?utf-8?B?cTlCbTI1UWRmUEgySjh1WWhOWDcxTmlEQ1BNa1FMMU1pSGRKQnRNdlRTVFRs?=
 =?utf-8?B?cEZodGF1WktxRGxCWnlzdVFzUDRvYnpHR3ZBaEMrME5zc3Qwd1VIMVBkc3lv?=
 =?utf-8?B?OGFSc1VhN3RlODRqUnlJM2hPNnRIQXVJaWZFbXg4S01Ua3R3cWkzc2dCcGpW?=
 =?utf-8?B?L2pSNWxRdkZuTzYxejVnbmdmaWhEQkl1OVpvdTF3a0lpMHNmUExNTWIrY0Rm?=
 =?utf-8?B?QXU2bUpCQWNkN1ZOaVNGRzBkNjhaOG83ZjdkcXJVbG9KRFoxNWs0Uyt6aDdI?=
 =?utf-8?B?RVpRckx6NlBkSU5IZ0FaemhUWExXMHE5U3JwWWRqYVJHaVlEb2pIZHRQaUJa?=
 =?utf-8?B?TElzZzFLNk5ObHQxN2MzMkhRTU5QNm9ReFk4UUpTbjhYTGJNV3NndmRyTmc2?=
 =?utf-8?B?M2R5ZWM4dHFaNHhaandsSGtzT1IzTy9IUGlMOGk1RldCT2syWE1OSzQ1cFZW?=
 =?utf-8?B?OUwvZkVmcVZLWm42NVY3c2p5YmpvcXZiai9VSW5uY2MybUpFcFczeGFpVmhZ?=
 =?utf-8?B?NTdSSVUxMHFLMnRkeUlvb2xUdlNjd28yVUQ0dS9jYU5KVk9SR3RNdUs4TWJ2?=
 =?utf-8?B?NVNGQ3h2S2ovVDNOVE44dkpiNGc2UnFhSlp5S0RuWGl2WnJNbERxQ3FSRG83?=
 =?utf-8?B?Tkl1RThKZDZ5ZWNmN1Fpdy9rRDZtK2tScDFXUlhIQnB2MjdFaUVNdm8xeE9t?=
 =?utf-8?B?M3k1bjZ1UnNhS2ZnVllVRWdHcE9YTjBJbW5nQThiTFBISDFCZUZpTzM4eUdH?=
 =?utf-8?B?VFBMSHFUMkJzbVhNanZ2cG14YmdrajFvYUludmxkdVRiT05uT1U0ZHhPaE0y?=
 =?utf-8?B?c2xhY0VDNnYrTDZhNTV2RWtnTjB2OHJWeDZaSXRsMyt5LzloU05jeGU0UzRx?=
 =?utf-8?B?SE9iajZ3VzlEZDQ2NlVBeEZLWkpwQlpMQnRwYmppT1cyeVVKOEU0RWF3aGNv?=
 =?utf-8?B?eW5ZTmZvN0hDcngvRHJabHJMdUtpUzZWRHQ4UkRHTFh2aHB3VUphZHMvb01G?=
 =?utf-8?B?N0FUaU0zengvY2EzdWtQQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjdvcVVSUVo4bk9GYlJhcndCWmw4U2pZZU9zZmpHM3JwQlR6VUptSUhNQ0Z3?=
 =?utf-8?B?RDFuNExxNURjTGM1KzV0bzZNTFNyS1JPbDB1YlVVdDhiUy8rU1Qrb0l2Y201?=
 =?utf-8?B?YzBjS2hJaDh4N0c0czlaNHNtRXZaUU5vak5uQm84WExYUjI0d3I5cXBUVEc4?=
 =?utf-8?B?dWV6RWRSU05yZnFqLzhWU2kyd0UxQTNkKzVTcytOYTdLWUdpeW1jQVUya3Q4?=
 =?utf-8?B?ZWNRZ3JIYkF5YVY4RWt6QTRhdjY1UjRZLzQ3Yit1QVBJZExFeUpuR1g3Nmxs?=
 =?utf-8?B?RGltUnIrZVUva20xUmoveU1PZElDbXJmTWNDa0JlQ1ZzY2VSNW9aa1RxTmpM?=
 =?utf-8?B?SW0wTU1VUmhyNWZIS1dNSTh6bXhxc1NGYnFDSzRUQ0RrQ3YvZFhJY0pzRkVR?=
 =?utf-8?B?elZJVmlxZjlRR2ticy9LUEtid2hKaUJQak1aZE0rREVQU1FkdTVpRXpyYW1W?=
 =?utf-8?B?c1Y1TXFSMFdXN2Fxc1FuTG5ub0JXbEZ5MUZqdS84NHVWT2RXSVZKSDVEU1R5?=
 =?utf-8?B?NVNya3RWWDdzb3BXUDlPUTF1TU5oY1c2Yk1lZENjSURWbHBSdG5PYjZwWlhU?=
 =?utf-8?B?VlBHNFhrODRGRUJNQ3A5bE9vUEpaWkNsQWR6dmp5SjdzQWc1MFhOdExwS0tS?=
 =?utf-8?B?cGp2YlZTSDV1OVZmTEJCeVd6eEZPK1cxZDIrcTRYZS8xVWg0V2pXUjhJbmdt?=
 =?utf-8?B?SFRnc0FkVlhNM3JNNFIzSjFRTGtFRitISHQ5c3c0UWZoWVJ4MkVPbXVZblJS?=
 =?utf-8?B?enFONmJranpnSjY1dnNiTXhXcm9DYWQzUWZPbitRN1orMGZOa0c5MVkwQ0l3?=
 =?utf-8?B?LzJ4RjIxdVFJaWFUeTJRS043V0ljSlBXRU5XR1Q5bVY4Y25FUnd2Y2tyOFNa?=
 =?utf-8?B?YXlCSU1ZQUJDdlpCSHJGeGNhY3RvTm8zRUNxTXA2Q3JoSVBDeFVaUjZ5YnRX?=
 =?utf-8?B?MjNSZ0xtSmZZaS9hVUNvaERtdkRnRkozMzlqNmtsaiswRmNxMTJ1UEhEM2JW?=
 =?utf-8?B?UWdiVG4yckVJZHd5dEEzQ2FJLy9sVUd1RXJsdTlkRDFvNzhLWURLekFJRm1N?=
 =?utf-8?B?L1hFbXhQSEZzUEhpWkZraitWbVVIekNuYjZuMnZUbUFCSlRwU3g2OWUyUnFQ?=
 =?utf-8?B?amR2QUEyVlZVMW10VGFINXhXSzB1VjFRTUt6RmdiRHVBelBjb1NBdU1DdHl4?=
 =?utf-8?B?SitrakQ1alE3Y2lsU0hsWkNseURtY2dLd080YzZiVmpyS2YrNjVnT3dVdWFN?=
 =?utf-8?B?cGVReFlSTGRSN3ZpTlJvdGh5dGM5d3RjNWJjVVU4ZVQ3NWxXOTdobDBpREhz?=
 =?utf-8?B?S1gvZ2REOU5XZDhwU1ExSlBVaFY0dWF6MVB6cklXS05TQzQzdHMxSWRBVTFP?=
 =?utf-8?B?QStxMi9xa2ZyMWVUdXhXZko2ZzA5T2RRY09HaDJNdHlzekxYVlUrTkd1Vmky?=
 =?utf-8?B?NGE0NUhWWXU1WmxITDhibDJpV0NpZGlnYW4xVkVmNHIwYmVRMlhaSlhSU0ZP?=
 =?utf-8?B?Nm5UREJPa3VqcFZKcXFDd3Z5cHlDV2tjcFpVU0w5MWsvVkJpaWlkZE9rRzgw?=
 =?utf-8?B?c280cVg1NnJMemQ2Yjl3M2RhVXdnSHB1SjdPYURDOC9sMnVNVkVVSnp1UDgv?=
 =?utf-8?B?Q0JvQWVCanRMTU9CSkc3QmdqQUVMQlVGOW9ldzlJYjlrWnF5QlJpUFlJN0hD?=
 =?utf-8?B?L1RzdG9QM3Q1QXR0U3NSNFBnTVpYQ3k4TmY3WHdUWkRXVk4zUUdzeUdQcDVP?=
 =?utf-8?B?alBveHhUMGdJZ045MGg4R2htYUI1WjBnMko3SGJKaDVjODlJYTBhZ0phTjR4?=
 =?utf-8?B?UGpIRFByV0J1THl5cnJoQ1FmYzRTOGVvNllvbFFBcXBOeEFHSjFLZDROTGd1?=
 =?utf-8?B?UVJ4TGFaUGdiT1czc3RjdHYxN2hJWGpLT1BRWFIzdVBNaXZHU3F5QXdjZnhQ?=
 =?utf-8?B?M0haNXVHUXRmOXA3RnJoWHhnU2ZsOEFYMUxCWXpSeE52LzVxeG1CNHJtanVL?=
 =?utf-8?B?WDdYQ3R2L01FUWpRUXgwTU1rS21Hb0dGL1pHQWxMTm5ySmdmaXZ6d00zT0JV?=
 =?utf-8?B?VlpCRDAyNWpZbHhKaFJkT1gvdzFwa1NWdUJJU1BrNUdnYnJiQS9WZzlFR01R?=
 =?utf-8?Q?qIzfe4LXvGkFkIaRCfMnBhIhg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c418baae-907f-475b-f915-08dcd25434cf
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 11:23:48.7196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: siFCwSeAlALKkxxGh+pG8noYXmVxmJP+hq+IbPhUi/UyfphVj8iYgtuqHnJM/Y6x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6957
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



On 9/11/24 13:20, Sughosh Ganu wrote:
> On Tue, 10 Sept 2024 at 21:14, Prasad Kummari <prasad.kummari@amd.com> wrote:
>>
>> Added LMB API to prevent SF command from overwriting reserved
>> memory areas. The current SPI code does not use LMB APIs for
>> loading data into memory addresses. To resolve this, LMB APIs
>> were added to check the load address of an SF command and ensure it
>> does not overwrite reserved memory addresses. Similar checks are
>> used in TFTP, serial load, and boot code to prevent overwriting
>> reserved memory.
>>
>> Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
>> ---
>>
>> Changes in V3:
>> - Removed lmb_init_and_reserve() as part of latest LMB series.
>> - Error message moved to one place.
>> - lmb_alloc_addr() is not required because the given memory address is
>>    being checked to ensure it is free or not.
>>
>> Changes in V2:
>> - Rebased the code changes on top of the next branch.
>>
>> UT:
>> Tested on Versal NET board
>>
>> Versal NET> fdt print /reserved-memory
>> reserved-memory {
>>          ranges;
>>          #size-cells = <0x00000002>;
>>          #address-cells = <0x00000002>;
>>          tf-a {
>>                  reg = <0x00000000 0x70000000 0x00000000 0x00050000>;
>>                  no-map;
>>          };
>> };
>> Versal NET> sf read 0x70000000 0x0 0x40
>> device 0 offset 0x0, size 0x40
>> ERROR: trying to overwrite reserved memory...
>>
>> Versal NET> sf write 0x70000000 0x0 0x40
>> device 0 offset 0x0, size 0x40
>> ERROR: trying to overwrite reserved memory...
>>
>> relocaddr   = 0x000000007febc000
>>
>> Versal NET> sf read 0x000000007febc000 0x0 0x40
>> device 0 offset 0x0, size 0x40
>> ERROR: trying to overwrite reserved memory...
>>
>> Versal NET> sf write 0x000000007febc000 0x0 0x40
>> device 0 offset 0x0, size 0x40
>> ERROR: trying to overwrite reserved memory...
>>
>>   cmd/sf.c | 36 +++++++++++++++++++++++++++++++++++-
>>   1 file changed, 35 insertions(+), 1 deletion(-)
>>
>> diff --git a/cmd/sf.c b/cmd/sf.c
>> index f43a2e08b3..7bb8bcfce2 100644
>> --- a/cmd/sf.c
>> +++ b/cmd/sf.c
>> @@ -10,6 +10,7 @@
>>   #include <div64.h>
>>   #include <dm.h>
>>   #include <log.h>
>> +#include <lmb.h>
>>   #include <malloc.h>
>>   #include <mapmem.h>
>>   #include <spi.h>
>> @@ -272,6 +273,31 @@ static int spi_flash_update(struct spi_flash *flash, u32 offset,
>>          return 0;
>>   }
>>
>> +#ifdef CONFIG_LMB
>> +static int do_spi_read_lmb_check(ulong start_addr, loff_t len)
>> +{
>> +       phys_size_t max_size;
>> +       ulong end_addr;
>> +
>> +       lmb_dump_all();
>> +
>> +       max_size = lmb_get_free_size(start_addr);
>> +       if (!max_size) {
>> +               return CMD_RET_FAILURE;
>> +       }
>> +
>> +       end_addr = start_addr + max_size;
>> +       if (!end_addr)
>> +               end_addr = ULONG_MAX;
>> +
>> +       if ((start_addr + len) > end_addr) {
>> +               return CMD_RET_FAILURE;
>> +       }
> 
> This is one way to get the load address, yes. But please do note that
> with this method, if the region of memory has already been marked as
> reserved, the call to lmb_get_free_size() will fail, i.e. return a
> value of 0. Whereas if you call lmb_alloc_addr(), and if the memory
> region is marked reserved with the flags set to LMB_NONE, that call
> will not fail, as we can re-reserve memory marked as LMB_NONE. Hence a
> better approach would be to use the logic used in the fs module
> function that I had pointed to in my earlier email.
> 
> Also, like I mentioned earlier, it will be better to refactor the
> functionality, especially if the plan is to introduce this check for
> loading stuff through other interfaces like nand, mmc etc. You can add
> a function in the lmb.c like lmb_read_check() which does that.

Is this something what you are going to work on?

Thanks,
Michal

