Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50FE9C43458
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 15:51:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF2D684704;
	Fri, 26 Jun 2026 17:51:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="oKhY70WO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D73384894; Fri, 26 Jun 2026 17:51:45 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB87B8404D
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 17:51:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bkQ6PTvhw+DlmeGkgxTotqPT+fKcUn4gsE92kSkZTFfKiwjGpcsu+pr66o/mX0nV61uV5YQLg/iJ46IZ8tVxgq0iKsve1s3/E4tvVyOqPutmaeOpHSwh5r4abqj3/BkNpB5Xw+CdW4f4thVHCsyOVLqyDXisDDjBP4alkb6n7DOqaMm6dGP090XpvrxoZC114mkzKTmgoHhLKw/5vsN/NKeBXr4CFY27c0FdHdnPczzzNZMcPLMkKQvSscmk4EB/2v/QPZKCGgkRYuf6GJ/50F1rAYJIL30QizM26kiJ4w5qNy5fS6oCVwCxdszphFMkEmeTbLt7jLwQHERrO0DUfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmBLGT9l/2ljK0Q+GYbTPpl0MQ7HURjUP/RqbaKFzk0=;
 b=omXo4FtnW4UAD71dfzMnwNvP+6i9EMtt/WDnG/NHnIkXAkBLnAITrVMlHgGfspFnJvJwAHeeBiqx4hfKsc1joBcGa5D8gPiM2edBj1T8SaTH0AfLVbmH/h29FLhDIhiKCyjPpcJ1WAhZ0otr9tFGZtCIaFx0c3cPi9uH0kTMvRoYQmB040W+ibF7zyUAv3EiL88tIFrUSC91nlCuNvq2fVEvMlWUxP0X8NR6r9RswHwTCcmwWlQQgVTXcJveDtK8y/sAqU01CAmuolAppk5F4lDlijfciH9JHMbZTC7wY+dsjQR5lBhGh47azAfwJ7owHec43Lw2paLnXVt1Mo3UBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmBLGT9l/2ljK0Q+GYbTPpl0MQ7HURjUP/RqbaKFzk0=;
 b=oKhY70WOjuqsX7Nr4deo2FLyZ9bWie8B/TQvtL5csG3kllNxZSh372YK8hkJoxJ+9ewUfsdPeCVolKaHL8hA371tJNmSYfTADMtIi0WzBAVqROr845Ny7lKg9g/k+dWJg5HcgNWeMwdyAjTYq1pgGT7/DD2HHbHRBkBGtkK9RJc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AS8PR04MB9127.eurprd04.prod.outlook.com (2603:10a6:20b:44a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 15:51:34 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 15:51:34 +0000
Message-ID: <e4f79621-6c6a-4e06-9d35-c673636fd788@cherry.de>
Date: Fri, 26 Jun 2026 17:51:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] ufs: document the UFS command
From: Quentin Schulz <quentin.schulz@cherry.de>
To: raz.benyehuda@mobileye.com, u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Michal Simek <michal.simek@amd.com>, Julien Stephan <jstephan@baylibre.com>,
 Udit Kumar <u-kumar1@ti.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Shawn Lin <shawn.lin@rock-chips.com>, Jared McArthur <j-mcarthur@ti.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>, Heiko Schocher
 <hs@nabladev.com>, Simon Glass <sjg@chromium.org>,
 briansune <briansune@gmail.com>, Yao Zi <me@ziyao.cc>,
 Peng Fan <peng.fan@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>
References: <20260607-ufs_tool2-v2-0-f79ff26ab18c@mobileye.com>
 <20260607-ufs_tool2-v2-4-f79ff26ab18c@mobileye.com>
 <100d2db4-d05d-4b1c-9576-d83d5c225e38@cherry.de>
Content-Language: en-US
In-Reply-To: <100d2db4-d05d-4b1c-9576-d83d5c225e38@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2PEPF000008A7.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::64c) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AS8PR04MB9127:EE_
X-MS-Office365-Filtering-Correlation-Id: e3111dc2-94eb-4524-cdf4-08ded39accbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|22082099003|18002099003|56012099006|3023799007|11063799006|4133799003|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: FeBWVQArLTpK2aU4Fto+K8wXXO+yvMVGOMV+bx0+q3LDot+M53ATVXK36suTwCp2rmKxx1MK7sPMQl/KIYN6qMt6QFff3Ks198ykCSaN0fdc1BR7TS6r1SM2698mnyLQC6fosW8yckWzpHI9uatphGeY9s7IAPke6VNbCkUIL7vhd9s6EspPRCe8bvKv4y8e0teyP+dcNJRnA0IHimuLGV7bNjXsdHl0qMXWNnjCsafxWZvsYArxnKlS5WiaGT9guigqKT2glYkeQEm7z0oKSpgCf83Bs6ytp47VlTNX/1qoUh1TslQKSMg6tk8n1iDm8fyXS16hjCXvaQ60mxh9XwNkUGRdas+zkCqgNwkz0+qyTckgtnlDsulkTtH5gVin56c5IIC0S6ZGXUnkkue9kKBcagLctyW05WVoO+QfSmmrm5k7/DAVDfEgCV3516AJkkdwG6u/7j/e7C9TKi0qJ6iKd1HfioHdwpSlWbg2tH8hrq7bNGRVwvh4BOsLRzf7ovMMqGZIBR4I8Yt/YCPcx3SLWJEuwC973ej0al4as9bpse3Q/VtDwMQQYLSFS5FsEtyQUICJC+Rm1S+mIsTXcrmoavdPYhY8PGhHLpJnNnm5MYaC1QrmNck/GaBSODX0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(3023799007)(11063799006)(4133799003)(4143699003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkkvRWtJeWFweEN5TDA5R05td0V0VWduYWRBejBxK2hBNUlkK2o5azJlSUpj?=
 =?utf-8?B?Tkw2d08rcjRTZHFxRngzYnJOVzdLQWl2UWh6L0xERmFYc0o1UEhYclI4eEMr?=
 =?utf-8?B?M1hSY2tOREF2VkVSWGRZNVhSdTJYeFlDN2pIT3dnTmtCT016M3RCYkJETDZ3?=
 =?utf-8?B?OHp5NjRZdjVleXg1WWVYRlRsVksyRDZ1Y3pVejJycmpmalZaTVoyNnJVR1Nx?=
 =?utf-8?B?dFhjOUhINDJsbXNvVEF6SWQvUHYrVXhXY3RLbFMrSFBBcWJkaEVUNnY1MWtn?=
 =?utf-8?B?SmtVUCtWTlFjRkpIQ0JoVTRwaVNKVHZHRkpzc1FUMGx4bTFscytrN29ITHdp?=
 =?utf-8?B?Qmthb0QzYXZmdTlMYjVaQkF2dUc1bnVSV05OdTUvbUh1eHJja1Z2SGFtR3RU?=
 =?utf-8?B?dlFZUnJRNmxkVFRnY0tZU0xJa3pzYUdzN2VuTlhuWHpweTBnTXMvN3FlNWFK?=
 =?utf-8?B?NjhqZFh5MjlHL2JtR0NENEFCcFpvMGpQOXBTZnE4VEV1UDQ5aSt3eHFuN2pS?=
 =?utf-8?B?MWNTaERZSXFReC9wbDJ0Y3FqYlI4Mko3Qkgzakx0NXliMlRhem9hQS9tVTk5?=
 =?utf-8?B?VElsU1B4bWdaTDYzODczb1l0b1dPSFptYjV1MXdPaTZhSW1NZmhoL3FsclFO?=
 =?utf-8?B?Zk4xeHJudkdTVWo2bi91WFZtNjN5NzJsRnk1emx4RzArUzdTZmRXbDBTZXEy?=
 =?utf-8?B?aFJqb243R3lKSStWbjJRaDY5OTBadTIzUnFHZjRKSlFETUtIT3h4VjNNckwv?=
 =?utf-8?B?MGRBcWtabi83NVA0YVZIL0NRRzdSQTl2N09Vc0xybkMwbVUyNHZCOHdPbnR1?=
 =?utf-8?B?eGJqQUI4WDFKVU81bUdFam5lVHdDbmt6emdqcERRWDNKN2tPaFN2RnVnZU83?=
 =?utf-8?B?N1ZNSG5pdkJmWEk0c0tUaUN0eE9SQXlYdHpocTdTRWRWMk5rRGpTQit5ZTMr?=
 =?utf-8?B?Z2E3V1pheXVtK0llVU11RDd0NEJmYitxY3pDM3pSSEVJZWRIWFJhY25oNDlz?=
 =?utf-8?B?V0JKVVphcHU2NG5zUmRsWGRuTHVzQlRxek8zdlYxZHVjK2lYRHdQWHVjZ2FU?=
 =?utf-8?B?ekJSQjdwU2s3c2hnaHJnUXhhY056dkx3MVJBN3RJTnJUd1I4MmhqQksyZWdj?=
 =?utf-8?B?UmkrMVZRQXNuM2ZWRlFqUDVqNElNVU4zdUVyYUtOTnlXbmNLZEJCYWJjM0dP?=
 =?utf-8?B?OEozeENkZk1aazMrVnpabVlrYXY5ZWkwQTFIRjRWYVY2R2NYQTliU3czd2Qx?=
 =?utf-8?B?VGFyaFpOYkwydFZBK0tyMkEvRlNlV1BveCtlWHVBMldacllUd0RnTzVMcmlC?=
 =?utf-8?B?V2l2L2REREZzUjVmdi9qcGFkVURybW9hNENiWU9YTUxsTDdBekpRQkhVRHU0?=
 =?utf-8?B?b0dmTzJyTWE5YzBINmp0NUd1V05BcFdMa0xRWmZ2N2t4UzFwcE12M01WcWlW?=
 =?utf-8?B?WHY3YlBIcTJBRXFtbHhNSUZvd0VIR1BSNXZsbTJxQkFpTkh0R0kreWhVRG5P?=
 =?utf-8?B?czZtUUdsbFA3R0NpM05SdFllQkFHeDBFU3RKTU5JbEhESnRrVjdmdlJPK20z?=
 =?utf-8?B?dE5YU3pLK2ZneDBwVGdnd0FuZjA0VFNWWFkyQjY5Q093aDhiYnFFOFJ3SndH?=
 =?utf-8?B?eGZiTmxaNzNCcnpSMmZFa0dIMHVzMmJqREI1aXpjdTBBSk0xUnJFUXRuRWZp?=
 =?utf-8?B?cnZNNXJGczRTa2MvVndIampZUVR3cFpJRGpoa05KRHBpOS9VZ2ZHbkpocE5z?=
 =?utf-8?B?ZGNLaHdZT2xPUTZ4M0NrY003QnV5VzZXam9vQVZKL0VHNGhnZ1lhVjFHeHJs?=
 =?utf-8?B?OExZUllweWZRQ25XRFJnbllDcHdwR2Q5ZWVDanU4Q2NXNmFZVElFSTRFaEpW?=
 =?utf-8?B?cWd1Q1NvajRrNmFyNmcwYVBVTlRXVFZUdE9PUUNmQWpsd2NzS1dQQU9ZVUVG?=
 =?utf-8?B?NVEzVnk1YWJ3RnQya2hmYnlmd2lhMGh5NHFtRit6WDhRWUo0U1VPeUtJaHZN?=
 =?utf-8?B?d2tkbjZVTzdIKzJRMU45cy83YzhwcFREYTRpamJld1Q4ek5VamhmbzViRitp?=
 =?utf-8?B?bGRBSzBEYnBLcXlsWXpwWGVnYWRyeHdYNUxJaHp4S2hub0JYa29ZOVArWml3?=
 =?utf-8?B?bGxXK1dlYzVtYndtSVN1Y0ZmTWZENTNyNDdGWC8velIzWldWK3NMN0lmcWNZ?=
 =?utf-8?B?eHpkMUhuVitHdEVSQ1FvTDBQWVk4L0FxWDZnRVZaSDBndm52YXZGdm51akVy?=
 =?utf-8?B?bzdVbWFUN2hQSW54cHBJamw2cHJVSzhWWE9LWUNCcjB1NFNicFcvektnL3RL?=
 =?utf-8?B?bXQrcHQvaGxzaUE3cjQ2OFMzbnFwTG8zeG9aU2xXcGJKY2JEMTlLdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e3111dc2-94eb-4524-cdf4-08ded39accbe
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 15:51:34.7935 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PNR4Quh+OeThLQhl7Z8FmgZ3He6In1qC4+AYaytYb6H3VO39eXx3CurJvOP1vVKiS54w+V+Mm+YT77F4xBmsDIY4tV+XoFrjhikRB2xcGSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9127
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

Please ignore this mail, I see there is a v5 of this series (without a 
cover-letter, hence why I missed it when looking for new versions) and 
at cursory glance at least a few if not all of the comments have been 
tackled already.

Sorry for the noise

On 6/26/26 11:37 AM, Quentin Schulz wrote:
> Hi Raz Ben Yehuda,
> 
> On 6/7/26 5:45 PM, Raz Ben Yehuda via B4 Relay wrote:
>> From: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
>>
>> Add documentation for the UFS command-line interface.
>>
>> The document describes the available UFS subcommands and their usage,
>> and provides a complete command-line reference for configuring and
>> managing UFS devices.
>>
>> Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
>> ---
>>   doc/usage/cmd/ufs.rst | 226 ++++++++++++++++++++++++++++++++++++++++ 
>> ++++++++++
>>   1 file changed, 226 insertions(+)
>>
>> diff --git a/doc/usage/cmd/ufs.rst b/doc/usage/cmd/ufs.rst
>> new file mode 100644
>> index 00000000000..1553bc28935
>> --- /dev/null
>> +++ b/doc/usage/cmd/ufs.rst
>> @@ -0,0 +1,226 @@
>> +.. SPDX-License-Identifier: GPL-2.0+
>> +
>> +ufs Tool
>> +========
>> +
>> +The ``ufs`` tool provides utilities for querying, displaying, and 
>> modifying
>> +UFS device configuration and descriptor information.
>> +
> 
> It's not a tool, it's a command.
> 
> Please follow the same template as other command documentation.
> 
> For example, doc/usage/cmd/sm3sum.rst was recently added.
> 
> So:
> 
> .. index::
>     single: ufs (command)
> 
> ufs command
> ===========
> 
> Synopsis
> --------
> 
> ::
> 
> <output of `help ufs` from U-Boot and/or all supported ufs commands, 
> similarly to SYNOPSIS section in manpage>
> 
> Description
> -----------
> 
> <description of each command and their options, see the mmc.rst example 
> for something that is likely closer to the ufs command>
> <you *must* specify if parameters, functions, features, etc... are only 
> available if a specific Kconfig symbol is enabled>
> 
> Examples
> --------
> 
> <typical example usage of the ufs tool with the console output kept>
> 
> Configuration
> -------------
> 
> <specify which Kconfig symbol is necessary to be able to use the ufs 
> command at all>
> <specify which Kconfig symbols are necessary for subcommands or features>
> 
> If the ufs command doesn't follow the general rules applicable to 
> commands (see https://eur02.safelinks.protection.outlook.com/? 
> url=https%3A%2F%2Fdocs.u-boot- 
> project.org%2Fen%2Flatest%2Fusage%2Fcmdline.html%23general- 
> rules&data=05%7C02%7Cquentin.schulz%40cherry.de%7C3871837b97374bfac7e808ded36694bb%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C639180634709249262%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=oqfGHsgWJ8kuajTSmBcstmmRyGVu7b29n%2Bd9zWKOiFg%3D&reserved=0) then you must make this clear as well. Specifically, are numbers parsed as hex values by default or not. Does it return something else than 0 on success?
> 
> This document is also missing
> 
> ufs init
> ufs luns
> ufs clearall
> 
> It documents `ufs sethba` which isn't implemented (at least not provided 
> in the help text of the command).
> 
>> +Features
>> +--------
>> +
>> +* Query and display Device, Geometry, Unit, Configuration, and Power
>> +  Descriptors.
>> +* Display LUN configuration and calculated capacities.
>> +* Modify LUN, Configuration, and Device Descriptor fields.
>> +* Configure WriteBooster-related parameters.
>> +* Query common UFS runtime flags.
>> +* Commit configuration changes or clear all LUN configurations.
>> +* Decode and format descriptor contents for easier debugging.
>> +* Provision UFS devices using exported Configuration Descriptors.
>> +
>> +The UFS tool header definitions are based on the JEDEC JESD220E
>> +*Universal Flash Storage (UFS) Version 3.1* specification.
>> +
>> +Usage
>> +-----
>> +
>> +Query descriptors::
>> +
>> +    ufs query [lun] [idn]
>> +
> 
> This is wrong, lun and idn aren't optional.
> 
>> +Descriptor IDs
>> +~~~~~~~~~~~~~~
>> +
>> +::
>> +
>> +    0x00  Device Descriptor
>> +    0x01  Configuration Descriptor
>> +    0x02  Unit Descriptor
>> +    0x07  Geometry Descriptor
>> +    0x08  Power Descriptor
>> +
> 
> What do they do.
> 
>> +Configure a Logical Unit (LUN)
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +::
>> +
>> +    ufs set_lun <lun> <parameter> <value>
>> +
>> +Supported parameters::
>> +
>> +    lu_enable
>> +    boot_lun_id
>> +    lu_write_protect
>> +    memory_type
>> +    data_reliability
>> +    num_allocunits
>> +    logical_block_size
>> +    provisioning_type
>> +    context_capabilities
>> +    lu_num_write_booster_buffer_allocunits
>> +
> 
> What do they do, what are the allowed values.
> 
>> +Modify Device Descriptor fields
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +::
>> +
>> +    ufs set_dev_desc <parameter> <value>
>> +
>> +Supported parameters::
>> +
>> +    descriptor_idn
>> +    device
>> +    device_class
>> +    device_sub_class
>> +    number_lu
>> +    boot_enable
>> +    descr_access_en
>> +    init_power_mode
>> +    high_priority_lun
>> +    secure_removal_type
>> +    initactive_icc_level
>> +    queue_depth
>> +    write_booster_buffer_preserve_user_space_en
>> +    write_booster_buffer_type
>> +    spec_version
>> +    manufacturer_id
>> +    periodic_rtc_update
>> +    device_version
>> +    psa_max_data_size
>> +    extended_ufs_features_support
>> +    num_shared_write_booster_buffer_allocunits
>> +
> 
> What do they do, what are the allowed values.
> 
>> +Modify Configuration Descriptor fields
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +::
>> +
>> +    ufs set_cfg_desc <parameter> <value>
>> +
>> +Supported parameters::
>> +
>> +    length
>> +    descriptor_idn
>> +    conf_desc_continue
>> +    boot_enable
>> +    descr_access_en
>> +    initpower_mode
>> +    high_priority_lun
>> +    secure_removal_type
>> +    init_active_icc_level
>> +    periodic_rtc_update
>> +    reserved_HPB
>> +    rpmb_region_enable
>> +    rpmb_region1_size
>> +    rpmb_region2_size
>> +    rpmb_region3_size
>> +    write_booster_buffer_preserve_user_space_en
>> +    write_booster_buffer_type
>> +    num_shared_write_booster_buffer_allocunits
>> +
> 
> What do they do, what are the allowed values.
> 
>> +Query UFS flags
>> +~~~~~~~~~~~~~~~
>> +
>> +::
>> +
>> +    ufs getflag <flag_name>
>> +
>> +Supported flags::
>> +
>> +    deviceinit
>> +    permanent_wpe
>> +    pwr_on_wpe
>> +    bkops_en
>> +    life_span_mode
>> +    purge_enable
>> +    fphy_resource_removal
>> +    busy_rtc
>> +    permanently_disable_fw_update
>> +    write_booster_en
>> +    wb_buf_flush_en
>> +    wb_buf_flush_h8
>> +
> 
> What do they do, what are the allowed values.
> 
> Cheers,
> Quentin

