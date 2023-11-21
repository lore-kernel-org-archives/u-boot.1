Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6954DC61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 14:29:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D65CC875B8;
	Tue, 21 Nov 2023 15:29:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kjTfP0m+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE76787616; Tue, 21 Nov 2023 15:29:21 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::602])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1E2887572
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 15:29:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUKSMe2VszK7zzUr3YfQykYv0DB8GCvDszO5siuanG58dLI2DFVhyBlMtypbIsq34B3fAFhMOApdGgu0dO57e7oBBQFNTDAjOAmdb+sJ3GeZsBdUBmMeinOOAvV/stkBY7bnJ1LwjeAGvLCkaTc3Xkh+YQzQRubf2LLWKTVxkOW1bQTirLX7t/3nieyjurUZtVXGwrJOEzLhbHFy78XWsww/wn/zqLOtvjH2EZ1xvBojoYTgIg4+BT+zK8Y49wSS1Ht+QXlMdYpmFC35UuRkYIokqVvmbLK/HfqAhIwsz8b2nn+ZWagwAu8M9iz/hPkoNFTWRAhYAm4TcE1ScQeiCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3Jv24DFItcxbNswh9U+xjxWs0Hz/N8NDdwn3rrd4DE=;
 b=gOqfu7u3pNb3ZN7jlfrlfhRiuOaa3U4PLmYHmkoMJ08LTa6EqB587WINtA8fPr2Wolf5WC8aXhdNOmie58+s6qZI0UY3ojal671+aQ4fYE4lolLnUC1y0iXIcx+XlbB+tNX4peGgS2jGjkzzREcCLKAdhyMVgO3LB51kkwbzo3RTvPOtWYZShYQzHjsYrV3ff6oFGVl1jUUYkLIzu6NpzNwvANd9JABiWKlQ1Wzu+dBa5y/NMr8jDNuNa8LR34fHBnOa2SNTefm+PaL1nI3hJFMgi4zouURazoPeFDklHFpWBlJ6UG4uH3FGCh2ypce9Wz6WelKLEBwzj0deWCbodw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3Jv24DFItcxbNswh9U+xjxWs0Hz/N8NDdwn3rrd4DE=;
 b=kjTfP0m+N7570V17E6Dhd0fmcGlvv1jbag7ij5ybsoiBVnOnzVEMZop/av2ou71WR+zVIVIPgOb50HRiqWHkahktQ6tz1q0FUuCPQk7EXaZzAUknZdlnQsqYxWuLG1q43b+7zWn7QJ++HN6jbYZSFzY+/ldzcLNgP/11TQF8b88=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 14:29:15 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 14:29:15 +0000
Message-ID: <626d4f5c-6070-4bf8-8f44-9f137815c148@amd.com>
Date: Tue, 21 Nov 2023 15:29:08 +0100
User-Agent: Mozilla Thunderbird
From: Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v3 0/2] Xilinx PCI driver fixes
To: Mayuresh Chitale <mchitale@ventanamicro.com>, Bo Gan
 <ganboing@gmail.com>, Puhan Zhou <puh4n.zhou@gmail.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Shengyu Qu <wiagn233@outlook.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20231116165103.140968-1-mchitale@ventanamicro.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231116165103.140968-1-mchitale@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0217.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::38) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|IA1PR12MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: d400c25d-1d04-4906-1935-08dbea9e3d20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wfsk1In9KxLudZruj/JBJh7ZL3pBOCDzWzErHX9Ph1+XW4/8J56mkGYU68fgxvF27tYH/CZ/6JIAptrj6nOEiXcJmoF44zaLbh/2XiUnJgPyY6ckTvGO/nuX5LYKAy2Y0O+LYejVV/i69tgkEOgdcDI1XYivY0jQPCuf5w8WYixNbIFxd8TPdpGKnZMzjg7ud6X8YveN4wbcxtdrCW43nTi5bdMaeZqjLU7oKsmgs6KZqjIcZyKgXXlulcjROqyo0dnoYtznxza1ZfBnuSH1XyBB5haE+3siG1rz2nth84cooM+mBlt7ZI2z6SpNMP1EAa6LRDLGU96v10B/gb1G1lh9EirsOTb6/ULkisW9PPn2N8r2GL9pKDrPv5yywG0AO7Yv6QHQWU0kcnNijHmcG05qJsNfItbe/ZMZLrhDdGmkH7qd9s/Ua4UypxGAM3UqlQFx9gJ/5qEA0cinVQSbQ9sErjRbvF02/Cibivyg9vg7j3nZjGf46u3SInEHBFmTU6LtD6Y3uYNP5B4uMy//d0tPuJVm6kxSHzfqIsiIZ5DK1bT+E5IHpW1tuEEuf7luXRO+xVAUtwZDmGp2Zm6SJ1D+hXvju5lh4ZqP0W8HNvPo/RzMADGMBjHWq3P0X7FPSHbotSln7OongA9QA1+JOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(396003)(346002)(376002)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(2616005)(86362001)(31696002)(31686004)(110136005)(6666004)(6486002)(6506007)(66476007)(66556008)(66946007)(316002)(54906003)(36756003)(6512007)(53546011)(26005)(83380400001)(7416002)(4744005)(2906002)(44832011)(478600001)(41300700001)(5660300002)(8936002)(38100700002)(8676002)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDl3VCtnY2pUZHVTZjhsbGlQd01TV1lPMFNpYTRmdGtzODN5bXovMW5mRWJo?=
 =?utf-8?B?QlZBaWw5L1Bnc2dTOU53QUIzWDFLcy9vbmVHTkx0OFp3TEVLekhnMFUvT1lF?=
 =?utf-8?B?WWJkRkNrdyswSEJVY2lKZ1JiY0JTc1dqWldMYXIxUHBrUm9NbW1oTXdFa09O?=
 =?utf-8?B?M2pxVzdhaTA4Y1h4SlFMeHdHRWFoVlFETHBiTFBWNFZiaFFmYjJBSDM3Vm5s?=
 =?utf-8?B?SVJjRUtYNmYxK3U2NnBlTVU0T1NyKzF0M2l4c2lHOVhTM3ppd1h6bHRHVGY5?=
 =?utf-8?B?bllKUUZIVjRBcnhWMEN5SWtCN1pxWFRRUC9uaTZ1L3lmU0lBbGNGR0ZGSldD?=
 =?utf-8?B?djBWbUYzM2ZVQVk0Q0JzNmdaUkQ0QmJBdXFtYk5qbk5LbytOWkduYkpjSmhV?=
 =?utf-8?B?OWRHZXkvODU4VHR4b0syT0huL0N4eUxZYXQzRnRVcys1Y3VjajRtdHRCWFFC?=
 =?utf-8?B?d2hqSFc5S2lFWWIwbFppTkRXQTBrRUZwcE1TTUtJTHVVV2ZyUTFPOXE0T1JW?=
 =?utf-8?B?ZUltZ3FCQVNvbTNPUU1RdXczNmxhV1dTSHNxbllLaENTcHR5dmdlZUxUVldG?=
 =?utf-8?B?Nmxtb2dUdGNxZUZjQ0dDUlg3OWQ2UmVTV0hWbit0R2hJYnpZVmRrVmVZdFl0?=
 =?utf-8?B?a1BXcG1ramZKVzRlaXZqbTZDcUJUd2N3cWhTQkh5TFoxZkI3N0lqWlhyWUR0?=
 =?utf-8?B?bTh4RmZ6eVBLZlp1bnpJTTJ0SVFvWHR0bUpYOVJQa05lQngzUThZdFNsa0c1?=
 =?utf-8?B?V2NlSitDUmkvT2Y0bk9nSXg2bE5LcVROMGtNTjB0UGhWNU84QmlIUkM2ZnVw?=
 =?utf-8?B?S0g5WmRYVWhrRFUwVkwyb2J3bUgwblJoeUFJRGlTZitadW5rdmM3dmdGVzhX?=
 =?utf-8?B?WXpIdDc2cS9ueE80Q2o4TkkrOEs1TnUwZUFOV1gxRE1yZnNZT0RHK1h5UGI3?=
 =?utf-8?B?VG1MZW9wVlN3akdjYjU1NjltVit4S1FPQWtPM3A0aTVOUGFKV2RRbTM0dkxD?=
 =?utf-8?B?ckVqaisvTEprRkY2NjhaOWJwMllNOXd6SzVockdRZmt2VGdnc2pEQ0diMWZG?=
 =?utf-8?B?UEt5UDlidTJpYm9tTVAwUnp6SzJwUHdJU1JoNGFXNVk1ZDZDbVU3Sk9wRjVS?=
 =?utf-8?B?ajBjSFlyb2tEdUNHY2RTVTJMSDRPZ0plb2thNDhFdDZCMnAzRXJmYTdQVXFY?=
 =?utf-8?B?OEM0bmdXUFhnaGFMa29iK3l5Q2s0YXl2V3NaTTVHSC9OQ1MxS0MxNDhBUFV5?=
 =?utf-8?B?TXJDZE9BSE9sSWJlVUp4MDAxQXVNY3lEM1U1aTZWUnFIa1pDQVRjSmYvRDBh?=
 =?utf-8?B?MU5jWi9LLzBFYldNc3lwWVRlTEtFWlJkWm56dXN1RUFlMk4yZlgvWlp1N1pC?=
 =?utf-8?B?SHV2RnI3cFdudGdqdDlnWURHaTk3YW9mSVB6akNuYmZkTzdPdUVKb09OWUdU?=
 =?utf-8?B?bEM3UVFEbmlHUXo4WUhOczhDc3VLZTZlTXNldDR3NE8xSzhqd2FYSGxtc09G?=
 =?utf-8?B?ZXVZQnBQVFErSHBrVjd5ZGswb0h0TjBHc3FIWkpYb1dyUGFaZXNYcm9xTVdG?=
 =?utf-8?B?MEtYQnNxYzJSRTl5dkJjd3FuMUdKZFlkMjRod0pVL25BaDZkR3Z3bTRFNUwy?=
 =?utf-8?B?c1Y2d1NkUXMyRDVRNXBkOThVQzBvSHIxR1N2c3U3UjdUMUR3WWZHNVA1NG84?=
 =?utf-8?B?d3lhdy9SRHY3WGJhSXZ6RWtHRTZYY2sxNXo3WCt5R2h2WHBxbFFuMis5Rmdj?=
 =?utf-8?B?YXV2M1NyU0JrVmM1b1I3Mms1NFA5VmNBTVA0VENJYU1maUhjZFdRQjVLTWtF?=
 =?utf-8?B?ZUZEc2Q0TDdNMktMYVBZOE5qSzVIWG5tVzBSV2lVTytXT1ZYN3cyUjYxN2Yv?=
 =?utf-8?B?SE5pYnNpYmRJWUhMMkV2YVdWSkhVQ0ZqemxXekdSNUF0SFhaWkVJWHdLSFNq?=
 =?utf-8?B?czk4VFdrVzRHS0V1L1VHYTByTWE1K25TVUlwT0JidG00K3V4UmgybmJya1U4?=
 =?utf-8?B?U0NKNk00eUs2R3lheGREM040ejJHUkY1d2dLWmlobzRsT05MUmxRUVI1a3NU?=
 =?utf-8?B?b2FBampJa0h0YjIrNmVGZ1hzdmxHNitEeStQMThWcmY5MkVBM21CTDdNWTFh?=
 =?utf-8?Q?x/3anVLEMGhhnXvjbq/9V/psn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d400c25d-1d04-4906-1935-08dbea9e3d20
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 14:29:15.6799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gjFnOl+fVLXijzFlX1XLrrIVhIG7VE6/laoX+Wk+5v6egBMF6UVDMD4sem+frv+v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7736
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



On 11/16/23 17:51, Mayuresh Chitale wrote:
> This series fixes couple issues with the Xilinx PCIe host controller
> driver.
> 
> Changes in v3:
> - Add error checking and improve commit title of patch 1
> - Rebase patch 2 on modified patch 1
> 
> Mayuresh Chitale (2):
>    pci: xilinx: Fix "reg" not found error
>    pci: xilinx: Enable MMIO region
> 
>   drivers/pci/pcie_xilinx.c | 37 ++++++++++++++++++++-----------------
>   1 file changed, 20 insertions(+), 17 deletions(-)
> 

Applied.
M

