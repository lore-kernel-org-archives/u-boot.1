Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE4BC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 17:43:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 836B6848DC;
	Thu,  2 Jul 2026 19:43:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="iErH81ym";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84B6484975; Thu,  2 Jul 2026 19:43:14 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40C0B83FEE
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 19:43:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BbxpdNu63xIpO3qa62Vgc5NNJRKRBtAXkDC6iEZTz6PI04Z1aVPwEOFIMKjL3OOFSgUOmmLChaFr8U3NjBIkL5IRUOPa+g8hBqS7EzH0ddxupbvu1NoIbBq4QSxcDybZTnup/6068L72AH4nNdRFtBoZRgF7SLWf74PlwOGokds5bBy/1RblVbc1ZN9G7A43ZnbnfC1sm5zgkJLjwVgaC2AXANkSpI9fC03ufVJ7fKQ1uclrIklT/cFtafrRuTQeWaS6n+3eT9iM+xEKKiOb4fV4eGMh5bRipxB2z4shJgFXchh2au53fwhmX/NcDPkaGaHtijpcczIHuOMxK4SzOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUzlLWeBaiqoce/k2hVnRftEDbxpEKRxKs0AGAlmQo4=;
 b=iv9Phduw5fgFBuzAJE3zV4MEJq7x5fVMTR3awjG0nrPv2ABhabZIKZ07cts0sc+hTq0Lr0egrIntKYjbMCYr5ZbKqNSbfpKu8wSQO6UymGSpRnmK5LqsvUN6N/T0rAaKKdYUoxdjy49bfofR8cO+z1eZ6DG+052Bjq/jS8Qc8xtJ+CmHCGx4iFFdRqYIEwHB16nlO9VNWrAbEGZPKEQ4s1eBKH7HwKHxSQSLmhOxl120zCxaNVjWDcfAXZyXcXYPBiSdSXRbKCRrybZxapPPxjxic2aeqhczyAyOE7jKeN6JC/SYiJRuWIf0RS2bHdeF7O6wbmSWX+jOD8efhFU62w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUzlLWeBaiqoce/k2hVnRftEDbxpEKRxKs0AGAlmQo4=;
 b=iErH81ymxLdMKiWX7ofwJuzOrmVpbKrHQIciqwc9khu3M6MQp1Md7W74pI8iPuDW0U5gyHx1n3+9P+8ERrb7fmVa+3Rg0oCUcbX1dA2nbddNLtlj0AoknTUFOds6QNwL1H0w970shI0Tby7dC9C1v2pxGPUUtWBjUMHJouOaGs8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by VI0PR04MB11573.eurprd04.prod.outlook.com (2603:10a6:800:2fe::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 17:43:08 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 17:43:08 +0000
Message-ID: <0a0af22c-ce8f-4c41-84bb-32d1b949c1f0@cherry.de>
Date: Thu, 2 Jul 2026 19:43:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] sysreset: Implement PSCI based reset to EDL mode
 for QCOM SoCs
To: Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 me@samcday.com, aswin.murugan@oss.qualcomm.com, u-boot-qcom@groups.io,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Cc: jerome@forissier.org, marek.vasut+renesas@mailbox.org,
 ilias.apalodimas@linaro.org, clamor95@gmail.com, michal.simek@amd.com,
 u-boot@lists.denx.de
References: <20260121063920.1500293-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260121063920.1500293-4-varadarajan.narayanan@oss.qualcomm.com>
 <667ec81b-da7f-4b10-b1ae-45e578cd9d54@cherry.de>
 <4fc15188-3de9-4345-85e9-d594efe9bdd5@cherry.de>
 <20260623165021.GJ382693@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260623165021.GJ382693@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA0P291CA0020.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::17) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|VI0PR04MB11573:EE_
X-MS-Office365-Filtering-Correlation-Id: 91b38646-10d0-4d0c-2767-08ded86160d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|7416014|376014|56012099006|4143699003|11063799006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: eNsqI8SOEyMBCMXqYIKbEgakotZyyLX4WlzNvb8gU2eTQyWhlZxpQpiLiPxMKxIY+3u3dt2cWjUWBtf9HMTWc0DYipVQSIJheXErjV6eSIzmT02DlY22QV8bOqzKJUCedUxbZ6ylGkt0vzDSYLh4jQ1Gdt9AuordT+oWBHR60QiYf6ZdLzHGDyl3x2gWNLbvPcsVz061UkgLmsopSuY4kb7qEArCf+htlD2UtuH2MzQjVHUasEJ5E7mUsFyLDDh0XrTzasvxOTxM+mowFFDiDcTCLr5djf6lIOVdHgZZ8gEwJtpZ+vbBEPdFs0P5BdRiAkbDTqA4tVoHTWWtgmKtbOyn3mL6WHHvRl5LjdWD0RViv0olKqOaD2ez9ilL8K0mwqWowqrSowBVFN4NugWlHuQLve20jwH2OjM8aeeLt+mijb77Ab1DSYzdivbCjNNhOmHrJ3n1Dk9rAEVkQdRXdNTWw2l5DfnS4iTf34J0G4Sxw5AXOLt3Czy1uWMVWZbNRqm2VH4er5l9Y+3kNsFLGTexJZuFGcGI//ZoZZYv+ZW2RqKhdiMydCXOfuOSQJ2mMZXn8039BJOkhtFfTVcn1DrIs7fqpONNQ4HF0vglEg2fm0lKhjCMrOV0Hd7EAEN31z22eSb2mYs2gxlDtdizS1APbV/7ZGn1N2KshSdJHBY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDg3c25ud3dlOUlJbWRDNld6NEdtTE1nK2ErSUZ3YjQ5eHMrNWRtRVl1SVdy?=
 =?utf-8?B?R1ZZelhNblpvMWhqT2FGWStJS1BhTDNza0x0TjQ4c3ZLZ2hDa2R5YmUyY2R2?=
 =?utf-8?B?bXh0bkw4RHBGMzNkSmdicHcvTkV0SlR0SEM1MnNuMS9UTmNJaG54bStWTFlX?=
 =?utf-8?B?elh6WkErTU5hUWlMV2VhQnpUeTNTa3V6SStPWjRsUGpFTWkwUmxNUTdBYWlI?=
 =?utf-8?B?blU4Ti9lc0t0V2dQKzNRN09DRWZoRGMxemJ1QVFaRkJONk1GcExIOU53Snpq?=
 =?utf-8?B?eVY0dEs0MGVIQ0R1aER2NHBOYUp2NVVmcXZVdmMxbkZIeU5GbzNab0dsTncv?=
 =?utf-8?B?ME0vVVFGNlpScnBQMmg3VkdEbHBmRVVSZ2xhZHRNSzVpZS9FVll3azVSRzBo?=
 =?utf-8?B?bXBBQkV3bDdlRGlMdE1sT1lJNUFubEdqbzVVWGlPbmJIZHZLTEhDb2dha3VY?=
 =?utf-8?B?ZjR4bjRucXBFOGhxTUtqYU42YTJQYjVSZjZkYXpBMkZUckpiWTBFSG9OS2tp?=
 =?utf-8?B?eUlqUm9HcEJ4TkU3TGRNMDArWVVDbCttQktDYWkwdkFsU1lCdUc3bGNkc3gy?=
 =?utf-8?B?V2lzRlA4V1lsS1RJMmVGYm5CaTAvUEpJQWUyWHdKNmx3MlFZNDdyV2hRRnJ1?=
 =?utf-8?B?RmwxYlcvcnErejNieE8zR3Ewd2QxL0hJRGtuWC9uTCs2bzgrNm1yMFJiYnlD?=
 =?utf-8?B?TUxlRUxyd2k4SGJyUXpxc3FkVmhudHF1SFZWN3BmTklHdEhIQ2lCRXRqWGdU?=
 =?utf-8?B?UEFQZzQ4TnpBcG95RlRseCsyMmsxMlBlTmRDQjQwanJSL2I5ZEZLOTdIQ2Nm?=
 =?utf-8?B?UG1sS0F1aTRqRlVsQ0Q1TjlkQWwrRU1LZEgyVDVnTVVIOGJaSTI3QTFkeFpz?=
 =?utf-8?B?dWF5M2p3RUtleUZpMTlEZmpNWHEzalhwL0dUR3g3RGFmUlJ0M05JNUREcUMw?=
 =?utf-8?B?MisyZTFadHNWRU1oeVBxVWZxVmtra0VRcHRQbS82TUtmQ3p3UkJEYVJnMHBq?=
 =?utf-8?B?cjNzNGQxNmZCS1lIckdRUnZhZndlTEw4NVFSb0gyYmI5dWFZUG5uUnBsYnpZ?=
 =?utf-8?B?Wko3UC9tejdzWTFNb3ZxOGpucGRqNHlCY1F2Y1p4THZrSG95dC92b1MyMDZ3?=
 =?utf-8?B?bE9tekZyMlJReFU0ZjI5aGg4K2JobDV1bUhUeTFMSWU2RjBnUnJGcUxXQjBm?=
 =?utf-8?B?cnlUaThKc1dXVFc0YnVpU0tVdExPWGRpaXcwZVBVUklmTStqYVgzSUVuYXUx?=
 =?utf-8?B?eExUSHplUWlUaXN2MFF3NjZ2QjlwWkhReHpueXo5UGlEZUNuWjBRT1hyM3lC?=
 =?utf-8?B?b1ZEQVZTcWw0RklSdGhxUzEvSFlpSnhYbUZyMGc0MUR0RElBemJoWHI4eTlp?=
 =?utf-8?B?RmNkMWkwelV1ejF1ampnaGxVVTZFSGFQUDJBZUcwdFVGbHlIdGhzUVE4Tjc5?=
 =?utf-8?B?N0xrYk1WTU5BSzd0RnVDZkM5YTBDZUdKcjM4Z0orMG9uSHFlU1ZQeEx3eXRa?=
 =?utf-8?B?UG5SRlVFajI5WnZFWiszNng2MitjMEVSeEh4aUFNNmZWOEVjSDhZeXh2TXZN?=
 =?utf-8?B?czBxa3Z4eExEeUR6c2lQOTd0bXUvUjkrSUx0YVpuaDdpOEFZMkFMekFLRzRU?=
 =?utf-8?B?WE56VklhWTljTHhMM28zM21FM3ZHRTRGNHg1OW43b1JWclJQb0I1aWhaLy82?=
 =?utf-8?B?T1h2RTRQcHQ3ZWtPeEVlbUVYSkFwY2hHMkpmbUEvWWpMOFcwaW5LSElwNHMz?=
 =?utf-8?B?NStnMGZkMUR4RVZob3B5c1VuUmRkQ3FOTktuby8raWVGVjlnekIrVFpQQjhn?=
 =?utf-8?B?cVptekdDQjBoOVd3ZjJXL2Zua2xPUDl4SU9rUm5haSttZG1IUGNyWjJDc0pW?=
 =?utf-8?B?OXhEUE1POThwOGREQlZrZFVoZTc0dTdyUTcwbWdFbHo5VllpcVpDMVBiRUs1?=
 =?utf-8?B?UW5QaVlxWVJOTjY3b2R3cVlSQ3RjcTBHWE9LUGYvWlZXTmFHby9PajJIKzZJ?=
 =?utf-8?B?RW54MDg1OHNLY1NvRk5hWWhVRUl3Zmg4ZDBBOEVGWldZdUJYeHlHcGxsT1Rn?=
 =?utf-8?B?WkRUSXV1cVBYdUQwMW1reVZBc3BSRlJRQnc1cFBJVVl0WFpjZ1JEamFrODc3?=
 =?utf-8?B?dlpiR2pReWREU1pjT3BGRGVmYXVQeUdvaVFUc3pIczhJN04wSHdrd3lKcWg3?=
 =?utf-8?B?L0NESmladHZYOTljNlRvZ014OVp4NTlzbWcyckdQL0tBOG81eno0S1FnVjVL?=
 =?utf-8?B?NDBFYVZjODFVNmVITlN0Tm50RmluWk5sUFJmYnQwTEE0M1JlRk5OM0I3cGlq?=
 =?utf-8?B?aWpaN24yUWdvR1ZTakZFQlJ5M0V4UHU3cU9vaE9aVk9pOFp4WURXQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b38646-10d0-4d0c-2767-08ded86160d6
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 17:43:08.3251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EH9iOeNJZxbgMo1HPVc7LTZqhCsNBwuUor+i6Cyf30atwFT284PZw3Da+TXTFXvlD8I58gc8vqF5/ix72tQh818hVnPdWggr6SVGEazJ7Rg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11573
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

On 6/23/26 6:50 PM, Tom Rini wrote:
> On Mon, Jun 08, 2026 at 04:53:23PM +0200, Quentin Schulz wrote:
>> Hi all,
>>
>> Gentle ping. It'd be nice if we can fix this new API before we have a
>> release made with it?
>>
>> On 5/26/26 3:32 PM, Quentin Schulz wrote:
>>> Hi Varadarajan, Casey,
>>>
>>> On 1/21/26 7:39 AM, Varadarajan Narayanan wrote:
>>>> Implement request_arg() sysreset_op for QCOM SoCs that use
>>>> PSCI to reset to EDL (Emergency Download) mode.
>>>>
>>>> Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
>>>> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>>> Signed-off-by: Varadarajan Narayanan
>>>> <varadarajan.narayanan@oss.qualcomm.com>
>>>> ---
>>>> v4: * Check if ARM_PSCI_1_1_FN64_SYSTEM_RESET2 is supported before
>>>>         issuing it
>>>>
>>>> v3: * Move argument handling to a separate function and pass the
>>>>         arguments to the actual handler to process
>>>>       * Drop Qcom specific SYSRESET_EDL from the common enum
>>>>
>>>> v2: * Update commit message
>>>>       * Elaborate Kconfig help text
>>>>       * Use '-edl' instead of 'edl' for consistency with other
>>>> arguments of reset
>>>>         command
>>>>       * Remove 'weak' for qcom_psci_sysreset_get_status() and make it
>>>> static
>>>>       * Mention 'SYSRESET_EDL' is Qcom specific in the enum's comments
>>>> ---
>>>>    drivers/firmware/psci.c               |  4 +++
>>>>    drivers/sysreset/Kconfig              |  6 ++++
>>>>    drivers/sysreset/Makefile             |  1 +
>>>>    drivers/sysreset/sysreset_qcom-psci.c | 45 +++++++++++++++++++++++++++
>>>>    4 files changed, 56 insertions(+)
>>>>    create mode 100644 drivers/sysreset/sysreset_qcom-psci.c
>>>>
>>>> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
>>>> index 2e3223e1c32..b6838a244d2 100644
>>>> --- a/drivers/firmware/psci.c
>>>> +++ b/drivers/firmware/psci.c
>>>> @@ -186,6 +186,10 @@ static int psci_bind(struct udevice *dev)
>>>>                         NULL);
>>>>            if (ret)
>>>>                pr_debug("PSCI System Reset was not bound.\n");
>>>> +        if (IS_ENABLED(CONFIG_SYSRESET_QCOM_PSCI) &&
>>>> +            device_bind_driver(dev, "qcom_psci-sysreset",
>>>> +                       "qcom_psci-sysreset", NULL))
>>>> +            pr_debug("QCOM PSCI System Reset was not bound.\n");
>>>>        }
>>>>        /* From PSCI v1.0 onward we can discover services through
>>>> ARM_SMCCC_FEATURE */
>>>> diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
>>>> index 6fb0ca81dc6..905ad2a7769 100644
>>>> --- a/drivers/sysreset/Kconfig
>>>> +++ b/drivers/sysreset/Kconfig
>>>> @@ -301,6 +301,12 @@ config SYSRESET_RAA215300
>>>>        help
>>>>          Add support for the system reboot via the Renesas RAA215300 PMIC.
>>>> +config SYSRESET_QCOM_PSCI
>>>> +    bool "Support reset to EDL for Qualcomm SoCs via PSCI"
>>>> +    help
>>>> +      Add support for the reset to EDL (Emergency Download) on Qualcomm
>>>> +      SoCs via PSCI.
>>>> +
>>>>    config SYSRESET_QCOM_PSHOLD
>>>>        bool "Support sysreset for Qualcomm SoCs via PSHOLD"
>>>>        help
>>>> diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
>>>> index f5c78b25896..8bb1eabd48e 100644
>>>> --- a/drivers/sysreset/Makefile
>>>> +++ b/drivers/sysreset/Makefile
>>>> @@ -30,5 +30,6 @@ obj-$(CONFIG_SYSRESET_RESETCTL) += sysreset_resetctl.o
>>>>    obj-$(CONFIG_$(PHASE_)SYSRESET_AT91) += sysreset_at91.o
>>>>    obj-$(CONFIG_$(PHASE_)SYSRESET_X86) += sysreset_x86.o
>>>>    obj-$(CONFIG_SYSRESET_RAA215300) += sysreset_raa215300.o
>>>> +obj-$(CONFIG_SYSRESET_QCOM_PSCI) += sysreset_qcom-psci.o
>>>>    obj-$(CONFIG_SYSRESET_QCOM_PSHOLD) += sysreset_qcom-pshold.o
>>>>    obj-$(CONFIG_TARGET_XTFPGA) += sysreset_xtfpga.o
>>>> diff --git a/drivers/sysreset/sysreset_qcom-psci.c
>>>> b/drivers/sysreset/ sysreset_qcom-psci.c
>>>> new file mode 100644
>>>> index 00000000000..3627bbf5c82
>>>> --- /dev/null
>>>> +++ b/drivers/sysreset/sysreset_qcom-psci.c
>>>> @@ -0,0 +1,45 @@
>>>> +// SPDX-License-Identifier: GPL-2.0+
>>>> +/*
>>>> + * Copyright (C) 2017 Masahiro Yamada <yamada.masahiro@socionext.com>
>>>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>>> + */
>>>> +
>>>> +#include <dm.h>
>>>> +#include <sysreset.h>
>>>> +#include <asm/system.h>
>>>> +#include <linux/errno.h>
>>>> +#include <linux/psci.h>
>>>> +#include <asm/psci.h>
>>>> +
>>>> +static int qcom_psci_sysreset_get_status(struct udevice *dev, char
>>>> *buf, int size)
>>>> +{
>>>> +    return -EOPNOTSUPP;
>>>> +}
>>>> +
>>>> +static int qcom_psci_sysreset_request_arg(struct udevice *dev, int argc,
>>>> +                      char * const argv[])
>>>> +{
>>>> +    if (!strncasecmp(argv[1], "-edl", 4)) {
>>>> +        /* Supported in qcs9100, qcs8300, sc7280, qcs615 */
>>>> +        if (psci_features(ARM_PSCI_1_1_FN64_SYSTEM_RESET2) ==
>>>> +                            ARM_PSCI_RET_SUCCESS) {
>>>> +            psci_system_reset2(0, 1);
>>>> +            return -EINPROGRESS;
>>>> +        }
>>>> +        printf("PSCI SYSTEM_RESET2 not supported\n");
>>>> +    }
>>>> +
>>>> +    return -EPROTONOSUPPORT;
>>>
>>> I think this is a logic bug.
>>>
>>> For reference, what calls this function:
>>>
>>>     int sysreset_walk_arg(int argc, char * const argv[])
>>>     {
>>>             struct udevice *dev;
>>>             int ret = -ENOSYS;
>>>
>>>             while (ret != -EINPROGRESS && ret != -EPROTONOSUPPORT) {
>>>                     for (uclass_first_device(UCLASS_SYSRESET, &dev);
>>>                          dev;
>>>                          uclass_next_device(&dev)) {
>>>                             ret = sysreset_request_arg(dev, argc, argv);
>>>                             if (ret == -EINPROGRESS || ret == -
>>> EPROTONOSUPPORT)
>>>                                     break;
>>>                     }
>>>             }
>>>
>>>             return ret;
>>>     }
>>>
>>> The issue is that the first sysreset device implementing the request_arg
>>> callback will consume the args and return EPROTONOSUPPORT which will
>>> stop the loop.
>>>
>>> Think about multiple sysreset devices, and let's say we have a new '-
>>> dummy' argument to the reset CLI command, then it'll depend on the
>>> registration order of the sysreset driver whether the dummy argument
>>> will be handled by the qcom driver which will return -
>>> EPROTONOSUPPORT since it isn't '-edl', or by the dummy sysreset driver.
>>>
>>> I think we should have a fourth possible return code which is "I don't
>>> know how to handle this argument", e.g. à-la IRQ_NONE in Linux kernel
>>> for interrupts that aren't for the device this IRQ handler was triggered
>>> for. Or maybe we should really be using -EPROTONOSUPPORT for that
>>> meaning and not exit the loop if that's the return code?
>>>
>>> Or maybe I misread or misunderstood the code?
> 
> Following up here.
> 

Do we end up reverting just before the release then?
