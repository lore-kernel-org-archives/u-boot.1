Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C34DD13572
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 18:38:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AC7088278;
	Sun, 27 Oct 2024 19:38:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="j+mDf7lh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C75FD889DA; Sun, 27 Oct 2024 19:38:12 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::617])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 661CD88278
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 19:38:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ECccVOt9TvH+wYj6UkUMVif2XDx7vVsBqtZH1I8jSn1w+ZOkS7tPI26dxHRzfs/i2Dh2OXjOjeFVwAMVrSIU3nd3yumndlOiL+vbSHoz3CAoD0xAZ/xEKDcwauP84PbOPb74bSAX1LJUQnvC/Hf8ZPTURD8i3WokXXHEW7jVUaZDT+23IxELlK47yChNKziuadX8IkOVgx+1XvVoN2SAG5A9cFfBlWtnqQTma02YPDV5TFkjqOABzuIZskE6ebhbEQmmiKAvfy/gB46fequ8OotER2t2wkjjoXjuMkE2N5koIgOMgvCZgYq0SX1zAIATDba7U0q2CNRnOthT1Fuy6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kODxi0Hbpjrz+ADeulQXJXgRo9601x7n8sKuxIUX4R0=;
 b=vdkZPQTBbY8tUeyJx/nEwkL3UYUDiPV3scnHo8P+XW17kwfX/bog3/JH2SR7GUw7+RLoUcXi1jd6Rnce/zREqfvrt3aaz25l0k/0WThFcszd1CyrtGgS+J5edpUvr/g1D+V+4+njJFaRVcYbHBfUVE/RL89BMQNTpfz7XnrnXa+PQrbQmn3UaZppMtoSe693wgeCV3aF5PbmS1sgYLvfJrsASa5/ivGqfcbsmPSb1IdbySW9REf/cP0imWlqQ4aARKvMEM0380kNrin+fJ4UkaolucY7UOUe/8rZXxtJ9pyW59/4zvG1JcEmsCddmpca5Fqi7ybHRVNZB1+3R0IKsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kODxi0Hbpjrz+ADeulQXJXgRo9601x7n8sKuxIUX4R0=;
 b=j+mDf7lhBzu3+GF4mckZkmTpVoUTjqY1yBfyDmjv24IMCy0RFIm8PLttrMDgIDwaq8J1dazQP1x0OguPSWoLwHtSS9qMX4xiizxVaLZtIT+4mjE0BnosYCnrhXBV90Y0leDeWEnPq/U2/rV9DqxJ8gyHfZmQ4JaevNC+g8Errlg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by PAXPR10MB7632.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:28c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Sun, 27 Oct
 2024 18:38:01 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%5]) with mapi id 15.20.8114.007; Sun, 27 Oct 2024
 18:38:00 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de,  Heiko Schocher <hs@denx.de>,  Fabio Estevam
 <festevam@denx.de>,  Tom Rini <trini@konsulko.com>,  Peng Fan
 <peng.fan@nxp.com>
Subject: Re: [PATCH] imx: hab: fix size of IVT+CSF blob tacked on to u-boot.itb
In-Reply-To: <e2d45889-33b1-438e-8872-f03a4c050c18@denx.de> (Marek Vasut's
 message of "Fri, 25 Oct 2024 17:09:15 +0200")
References: <20241024122735.893319-1-ravi@prevas.dk>
 <3fa7049d-4657-4cae-9ccf-fac1c62ce529@denx.de>
 <87o738psig.fsf@prevas.dk>
 <e2d45889-33b1-438e-8872-f03a4c050c18@denx.de>
Date: Sun, 27 Oct 2024 19:38:04 +0100
Message-ID: <874j4xl7cj.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0113.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::19) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|PAXPR10MB7632:EE_
X-MS-Office365-Filtering-Correlation-Id: 7097e075-6932-41d6-1d2f-08dcf6b67c13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|1800799024|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vhBkNBfFgBJvgZWJ5/jvMbWTekIOoIHGUWzt4FcKCAEEyZXpC0GODOFtbEoH?=
 =?us-ascii?Q?X33h5BuBOevhJq9rabn9UVNtxtlsOUJl03MVWRPW8YcokXs44NEWJfYWLps0?=
 =?us-ascii?Q?vb0t8QPlMWv9Ly7c2od/nSVbnVwD6KQtLHAV1o+ntBGt+Hf8bgcoxNamx9ft?=
 =?us-ascii?Q?/mABfNuZWyembE8+y7xPWjbzY7paIbdLAnjxqdoTdIbBYcRtlZoFOakm0l5E?=
 =?us-ascii?Q?8nqZhv60d/RE79zLPL7u17CBmsTU6oQmROllpLyLyO2GLYsREmqw7aJJ0ZNz?=
 =?us-ascii?Q?c08gDMa6yhPRpu+rCTEUwYuUEf+vvBGSxKHyxLW/JhBpsudpypAoSEz5aM+S?=
 =?us-ascii?Q?9+IGcDW5PYg9a/veuctwuOii87sXXA8wKMNvx/B6TJGp/36yOfxs8RsJgGsV?=
 =?us-ascii?Q?o308Vnnif0Kj0Ue7fCwxlGU0W4PWV0Y0hGBVMK5B1sy0PCm4CCwBS8INfqhb?=
 =?us-ascii?Q?0H+xoEghrsojS4UIQmauuCZiV0qQUHF+oAN5EvHLy0lMsStTbWpfHz0SoCr1?=
 =?us-ascii?Q?6l7P+SpaAftd5isoDK3GcNEQWOZR6DXwswtRNCy1nJ+jX9Z0RkZdqUoMlOEU?=
 =?us-ascii?Q?tT2LmBl7q4FNQ1KHVwxUoPHmgyWmXI2/wJRr5qsVK/SzBicEcwUBrSZ7bOjT?=
 =?us-ascii?Q?T8dPDGUHpVpDn0hw2hYYXZwugWhYhJ8Gk39477fVJAIIHck1Jvp7UKYkLww1?=
 =?us-ascii?Q?Yo9pFwpIc1PKenu2ymqVjK3MQt6lmyFrxyQ9ZiLCv6myziwnCU8IeIN4ocff?=
 =?us-ascii?Q?hrXA+Bn/8K7a5EBUNhKG46TWo38/7RB+bfyjVMEjawQbdcIfGSMvOkLxqP0E?=
 =?us-ascii?Q?H0Z7Su5Orc1a0mEiup3a/aTRYu0Z3Q2rA5xC24WcoFI25HaFKJAifg8rqQCx?=
 =?us-ascii?Q?Am9qIUocTTpnZTqEzpyU/AJe0Kb5Gwu0iHmotIlkfUmOk3BBMO5iELnGksl9?=
 =?us-ascii?Q?JBJTETsOeSWH5BwvSxaXiIQ4pLuf/wGdAT7RAZ01pVr0vwQOUnlnEApgOSAI?=
 =?us-ascii?Q?36kBWw66yaVg4TV48AwNP7wkIdi+Jp7rU4p5EaT9x8LqdiFh9trIdHbN9JtI?=
 =?us-ascii?Q?kOO8naQbxMuG5tmGExHLl92i6E1AQc/j3xGPXkjN40aOISbs/tLt4zI0hXgW?=
 =?us-ascii?Q?81GtURwYfQnU9jGH0my4igA4rO1av0Fm0R2Z2qse+cG9jLLr2C3Wh93Jc+jD?=
 =?us-ascii?Q?e2EuCz1odXnfG1ZgewXGqEVKdvn8NVuaMjTj7GX+HRhf8BmmZuOdOoVYspYC?=
 =?us-ascii?Q?pZB09MAdqNdB5Sm/yd8I2eHxTi2uo2eWHbfvZ2JRR416g+RTgi2feDBMg8Ok?=
 =?us-ascii?Q?tcfK6QlwDrYBq43Zxsemrqxf+D5+9n6N/kV1+/Nvg2dVvUETVPUAw7n/7qd0?=
 =?us-ascii?Q?hZ2d9hs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zWLPGimERomPr560epLLz6ylYVGK3ruxo2eVfd4ucXmPUTcmTd6QgyJJQwrh?=
 =?us-ascii?Q?p2KmChS7s9BAzoyXefNZK0cJ2WxVMUeerIdU86YgkcdiJ8Z3fuyl/6VxOlBx?=
 =?us-ascii?Q?73of5dOGKG1S8/4nxHc8b6I2IbBxak75Zua8ycs3bP1xsv4MVh7/Ud04q0Zw?=
 =?us-ascii?Q?2OrdkoITJqdWoZi17HnOjpIiVooPLYXLA2iwwmRM3Ch9KG+/NPkVI451+QVu?=
 =?us-ascii?Q?iogj29mzflIm7OFrp0TzWmj4HA+Nal0pNCkYdn6xWSdXajVtdeGJ68wMBFbU?=
 =?us-ascii?Q?4nlCwvRbHkGTlhWLqraHr4swQH4tY+rvKPWfQcNNS7w/IFsXg57GLiVOW+j/?=
 =?us-ascii?Q?2kXViVaBO25GjD8TBz5atosBp/+86ksaTYW9Gsm+Co1auV95GhHpqxaMxbKg?=
 =?us-ascii?Q?WqVo8D4QP2u+HUeKWdqn4vld9D9lAf+fNXyadoG3gOTHO9n8GY6RGJUTjju2?=
 =?us-ascii?Q?NbMgXLnYuemqZJieISzViGDoPGZxrcgboVqiBmMrTR2u8HqiLE+2UDvGkMIq?=
 =?us-ascii?Q?ARBxYq/uZk96TL0aoQqQRajOwwN82GGRjooPEFUs7v9ir3HJgBmenThlPCfE?=
 =?us-ascii?Q?klX32cIOo74is7pJJXydiZXbWKRUwFhJXAahwep+xqbR9eayQ/GuLeDWMbxH?=
 =?us-ascii?Q?WCk6kbxQymgtl7A9o5UnrRDcbvcn4p8OkBHDcQ/YOdwez7VkodtutkKFCRrN?=
 =?us-ascii?Q?2/2mP/X07gNJfWPriP4Ne1Rydh3XT3ILnMqlwztLACyiAqp7uqNNg5uDMwmq?=
 =?us-ascii?Q?sR3hUzB6BGTxP8yKb2QT4ps9q5gHsXwzzEFBcWJgV+rrWJEm24OxqG32Eo2Q?=
 =?us-ascii?Q?FaDD0nnBFMvgTEMgmflah7vNUyffQWXMFrlnnBKdDgBm/Nmd4MsvPwYr2nGw?=
 =?us-ascii?Q?M9w5/wkPCnfce+nXBUl30wHk32FjWsbicgQdB81NdzcxzWoDskO3+LmaEI0n?=
 =?us-ascii?Q?4w5s9P58SowwBuWaLc1OSk7Rewqj+q+e+8yoALsYUi7hAvA58Fh6rfZh/cvZ?=
 =?us-ascii?Q?ug7d50IQqq9b/xssHqybdhTZbau/BrTbXRS8sW45FoCqn5LINJ8NBt4fOzo1?=
 =?us-ascii?Q?W1agNj0D9GgDjYfuTYP/PLzLEPD3uDKG+qZiJOONwCUBgehZvnY05qVxWd72?=
 =?us-ascii?Q?yqXqhccPtNfklJ7Rj22Y3934Q+YEONJo7dYdCW2kSawvOieX35icskz0/lfm?=
 =?us-ascii?Q?RCs8zXC2ov6Cucs4D4lAu7tM4cJVxo+z2TbFo6jswHTWGED2po5gmw0rASbf?=
 =?us-ascii?Q?JFvz2uPpFaT4kR6NoNMiUrRQ4m7LkGSPa4PMRMztUAqrLQSbPoWslCLaWOnZ?=
 =?us-ascii?Q?ZWfgDMakrNMMgwdyz4e4CnFWXKK4QjHrfKSalz45b31HtMet56zNs3fyZymN?=
 =?us-ascii?Q?E3ughdmU5z47iViS8KfyKQNjIzOsaaFc0FDsJQM8CTpfWrOCZRwOkV84MZIj?=
 =?us-ascii?Q?x3DJJ+uE0+FYccr8fiN+fN+GmFjZI6WiPar9gi/zODcZUkhfW68Wg90e1iW7?=
 =?us-ascii?Q?9+M+r1Nj+/Uh1BwYDE3q3TaR3xoBvcXlKmNF1xjOCfe2kOt/ghV/Qje5A58K?=
 =?us-ascii?Q?IIy0UHurlKuDRsZmfwIzcMumjfo0R0+vncLzTKmwmHlPLCN+HeiqUCe47gTi?=
 =?us-ascii?Q?eg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 7097e075-6932-41d6-1d2f-08dcf6b67c13
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2024 18:38:00.7260 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g0AfqTj27fSlSwAubsMYrnA38M3tO+zxOjNEnnUllu6VOgpNNY7XFmOlAm2TZ36XcMmHlQ0bpv2IerbUJBoAxcizuiUFz+VxKcsW1fVSnBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB7632
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

On Fri, Oct 25 2024, Marek Vasut <marex@denx.de> wrote:

> On 10/25/24 9:10 AM, Rasmus Villemoes wrote:
>> On Thu, Oct 24 2024, Marek Vasut <marex@denx.de> wrote:
>> 
>>> On 10/24/24 2:27 PM, Rasmus Villemoes wrote:
>>>> Loading flash.bin using uuu fails when flash.bin does not have the
>>>> right size.
>>>> When flash.bin is loaded from some storage medium (sd card/emmc),
>>>> SPL
>>>> just loads some random garbage bytes from beyond what has been
>>>> populated when flash.bin was written, but when loaded via uuu, SPL
>>>> hangs waiting for the host to send the expected number of bytes. Which
>>>> is (size of FIT image aligned to 0x1000)+CONFIG_CSF_SIZE. The
>>>> alignment to 0x1000 is already done and is necessary in all cases
>>>> because that's the exact expected location of the 32 byte IVT
>>>> header. But the IVT+CSF blob tacked onto the end must be a total of
>>>> CONFIG_CSF_SIZE.
>>>> This is exactly the same fix as 89f19f45d650, except that this time
>>>> around I don't know how to cleanly get CONFIG_CSF_SIZE.
>>>> Fixes: bc6beae7c55f (binman: Add nxp_imx8mcst etype for i.MX8M
>>>> flash.bin signing)
>>>> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>>>> ---
>>>> Heiko, can you check if this works for you?
>>>> And if somebody wants to pick this up and knows how to get at
>>>> CONFIG_
>>>> values, feel free to fix up and take authorship. But perhaps it's not
>>>> really configurable at all; imx8mimage.c has the value 0x2000
>>>> hard-coded, so I don't think anything good could ever come from
>>>> modifying CONFIG_CSF_SIZE. If so, the right fix is probably just to
>>>> make that knob non-settable.
>>>>    tools/binman/etype/nxp_imx8mcst.py | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>> diff --git a/tools/binman/etype/nxp_imx8mcst.py
>>>> b/tools/binman/etype/nxp_imx8mcst.py
>>>> index 8221517b0c4..9a1974cc522 100644
>>>> --- a/tools/binman/etype/nxp_imx8mcst.py
>>>> +++ b/tools/binman/etype/nxp_imx8mcst.py
>>>> @@ -137,6 +137,8 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
>>>>            args = ['-i', cfg_fname, '-o', output_fname]
>>>>            if self.cst.run_cmd(*args) is not None:
>>>>                outdata = tools.read_file(output_fname)
>>>> +            # fixme: 0x2000 should be CONFIG_CSF_SIZE
>>>> +            outdata += tools.get_bytes(0, 0x2000 - 0x20 - len(outdata))
>>>>                return data + outdata
>>>>            else:
>>>>                # Bintool is missing; just use the input data as the output
>>>
>>> I have to admit, I never really figured out this binman stuff, but
>>> shouldn't the fix be also in tools/binman/etype/nxp_imx8mimage.py ?
>> No, why? That logic is all about generating the imx-specific header
>> in
>> front of SPL.bin, there's no CSF being generated.
>
> This patch is modifying tools/binman/etype/nxp_imx8mcst.py which is
> the Code-Signing-Tool binman etype, the thing used for generating
> SIGNED images during HAB use.
>
> Shouldn't this patch modify tools/binman/etype/nxp_imx8mimage.py which
> is the etype used when generating flash.bin itself ?

No, because this is not about flash.bin per se, but about the (u-boot
FIT+IVT+CSF) blob that forms part of flash.bin, in the IMX_HAB case.

> My understanding was that the problem Heiko reported was alignment of
> flash.bin , independently of it being signed or not ?

Read the thread again. Heiko's problem was very much related to IMX_HAB
being enabled. I've already explained what the problem actually is
and why this fixes it. Not only once, but as I said, this is equivalent
to a fix I sent for the shell script implementation, so to answer a
question you asked elsewhere: Yes, this is missing in the binman
implementation.

Extending the size of flash.bin in the !IMX_HAB case will have the
opposite problem (as will adding the wrong amount of padding bytes in
the IMX_HAB case), namely that the board will boot, but uuu on the host
will "hang" waiting for the target to consume the remaining bytes.

Rasmus
