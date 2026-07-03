Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE70C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 10:37:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CEF484832;
	Fri,  3 Jul 2026 12:37:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="HCFJBieV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24432848BF; Fri,  3 Jul 2026 12:37:14 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C27168469D
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 12:37:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EwBL2wC08SWn9NDnkISah8EJw+VdvVgde7Qi3rKaCIBkKWGzt5G4goqE7P1zy57ZVnnsGtKWeMlNrYr4E5LbN0V6D177IXaPqunLQ4pludWOCV6Qu2O/wfQUj1j6tC7YGZGqo0+oCSWuKrVjssDQrQ/jaoNDc7Wn1SYyR31CEQXVng2cNJcBzdCjvzQVSv0AD/mRoKl/csPGCEkY997TKFb01KJuM76c1Ku0eI2iX1Ptdax6/EDZ09EPm6TN/LdHLvgMx4NIidaqGsUVsnty4Qk8lnriQ3VUJX2a5JW3OjzrP88DpTyagfVXjwHPcWIjql07kOMS/h0CncjqC5iH2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/f8HkVr9025YhSxl9a8u2FhvD38I+M+fLTmkwNTgK5Q=;
 b=iFyNTLMoRE/iMb6zrcw5hack1REGBvwgCnpIcqAumUgP03/0MCJQ8iGchK2Gn6ky6XyDrJunHKpND74UzWlu9E/Sckh4CjrwfExKRyA+IPseZfR7UVjgbirkNCQ8PSRavxi1VCZ6uNwpFxr2s2dys0dL00ZRCWZpSxE4/Ft9Qws5w839UKhhCt1UYyzBD2hjRR57S0EqqVFLLRcitN5fhUnGXWAsT+v9KnQ3dg/MWyMAILku9RuuaUo1RN0nxlQYmvcsyuArj3Sg9YmPsBn2ZSpLVJIxlvhBnU/F/yb1T4ExLfkIe5Y/FqqAwUAZtfft2WvWfKZzF04XW6yOgvlfdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/f8HkVr9025YhSxl9a8u2FhvD38I+M+fLTmkwNTgK5Q=;
 b=HCFJBieVAhT2kKXycNEM/0O2S2lXnVR2KZoMkc6wxKq4egeTakOBBLduM7x98f8E944C3ZGM3JyhgdG5jqp9GcCIZPd3blf5GN5E7JMlXQmWPaP4YEp7MaVqaeGGasANc/SUf2wXu3ytBQN0vfKV+KpqIwteS0c9TicU+Tzmfxw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by VI2PR04MB11220.eurprd04.prod.outlook.com (2603:10a6:800:29a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 10:37:06 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 10:37:06 +0000
Message-ID: <d7e003b3-e693-4579-8e3a-b09ce9f78d10@cherry.de>
Date: Fri, 3 Jul 2026 12:37:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: sysreset: Do not end sysreset_walk_arg on
 -EPROTONOSUPPORT
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260703-walk-arg-fix-v1-1-64beca00d7e2@oss.qualcomm.com>
 <af5d617d-4963-44cb-81b2-c0b0b0dc4c6f@cherry.de>
 <akeOqlGa/bRWA3B7@hu-varada-blr.qualcomm.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <akeOqlGa/bRWA3B7@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA3PEPF00000523.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::66d) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|VI2PR04MB11220:EE_
X-MS-Office365-Filtering-Correlation-Id: ada7b3bb-8a11-44a4-ee2c-08ded8ef073d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: ZuyFOmx3esUecBkmyU6KmC5VZW/zrGzBGlsIo3WQkg9r2jRoVwOMt1O+Tb4W0P5lr4ZoVxyNiJR4O7oGKJjji9+KTtaWHIvr03H6YkPKn2ypL+sHXcCBGr+k33FolyJ1Vt3kthHtvLD3LC8GvN/kWtFi4XhK4bv4lTno4ZOjEkg1/6Q5/KU3F9S3MvlHTWrnPn/rQTDEtKK+RZvFaniko6mQj3qZDaiMYh1qorw9b75gJ8DFTI7hVeiae7UBcjdXVLrEE2tAnCu5vH20IfTra7rpYn2z3hX8a7wLsSbwflSuz2jf+jeKMOs7ZVpcKlrUrohKaUhA6XKTCJcW1yo4+GflRjmApPM++P1eeB5/+cMT12P/byp+T/O6tNH7FFetCWzhTQnQeJFi82QFveai+6Y30bED2WgSbpZ20Rc6b7LkGLH6DXejDQbWhG8XAin8YG27TsReqIJE2Wsg2gV/3ETKirk41J4qDAjJ82nD+mky6OApx9CGC96MPAxfowfT2EHUKYbC721kkicbZ/4l1kKdlI/5y2l6QNKJeSnk3UjRRjgLtuhgLqfG7eWNFo9Qomguf7v3UcYvIfHM91fle1gn3Y38FsMsbjpeY9KwoF4luo4OnMVjM0nc5n5ooptevFTENsE2CMdBSGfN+FJXZ8T+DOE+bD6HC5fEEV9IQJg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUc4R01KUnltRXh2VXFvZndOVldRM0NDTUtBS1dscWxFSGxXSitoRDB1QmYw?=
 =?utf-8?B?T3FGbTIrS1ZKenUyVWJjdUtVSHFEQTJTQ1ZpTEthbUJ6cVpxUGVicGVraExs?=
 =?utf-8?B?Zmc0YnM3bGVra3N1SFZQdjhDdFg4N0QweGJVcDJxOExrUkVRK2liQnQyZkhv?=
 =?utf-8?B?eEJSM3J0WW9xemtKLzZMYWY5OG9xWUFTRXdBdTdLNml6WlBLSkRpNGlBcXNm?=
 =?utf-8?B?WTg4TlVoamg1RUt0Vi9uSEN5bnExYnZCYkMyTllCaTNLcXp5dm43SWFKeG9B?=
 =?utf-8?B?aDJybGU4RzRmcGpFaTVrR3ZzUjFMbUVteno2VEFqdWp3aEVIelFVd1c5S0Nk?=
 =?utf-8?B?cW1pNW15WHpFSVJiTkQ1U0p4cGZ2WkQ1dEFoL1g1OFllb3EzazM5TkF3eFVR?=
 =?utf-8?B?VEZmamJ2dElkMjdrbUdNbW1lZ1JKbXJJeXhlMTB1bkd4cGg5V0N6MEZ1bUZO?=
 =?utf-8?B?VkJKWEtaWHlMeHM3RTBETCtzSWpuNS9aWnIvM1hzbmg5RWVybDRuRHBSQXN6?=
 =?utf-8?B?UC8rNENQUU4rRmJHWmhocUlhMXd4N1NacXh1VTBjRURkY25tWHgrWVYvSUdW?=
 =?utf-8?B?amdsNXBJUkMzNGNSUEFaeG5TK2dvSlE1RVZhSW92L2JpYnA3d0FKeDhvMWlv?=
 =?utf-8?B?OEMzdmhGcWN0NmNZbCtCTnI5RDRqOU1ZNW1lWStGTDR3eStDOXR5K2tUT0RL?=
 =?utf-8?B?enMzYjlZSkUzWEh0VGRQdUZzSUpzL1gwZ0dXRzB2R2pTcHllQ2NQTHhrMEVL?=
 =?utf-8?B?TjY4bjJIN0t3dEIwdUs1a0JLdVZObHNrTDNHRVEwS3diK1R6anhTUTFwVlBm?=
 =?utf-8?B?d3lrU0tpN2FUcU0rU0JhajUxZFdoZkNDRGEyQk0valRjL2dRZFpWVVZTWEZ0?=
 =?utf-8?B?VDI4bDJybS9QRHEzWkVsdWUyNlVMWVBNcTJ0SFNzeENmb21BNWVpd1d4Ni9L?=
 =?utf-8?B?RUY5cldXdVF5WXRReWptTkNTYVZ6ZC9lZDd0Y2tlRGtZVWM2MDFCdlYvRnVp?=
 =?utf-8?B?VGR5TUI3V3pDKys0QS8wUmxTTzlnVWtLVE91anI5ZVRxeGlKZFJiWlB0dTBx?=
 =?utf-8?B?dEVIdlR1Y2JiZW5aVk1VWDZxQ0NRa3o0eDNWME1TUEpzc3YyRTIreHdjYkpu?=
 =?utf-8?B?Yzl2UmYvRzlxSnBRaVhYM3dVVHdxeWQrZ0h2NFk0OUpzek54QTMxRkJMbVo5?=
 =?utf-8?B?bTZSSkVCb3NXcVRqbDE0aFQ1anZqRTltL3dLalhmRFlVZDIyRVZ6KzVBZG5T?=
 =?utf-8?B?MFh4SlRlN3BJb3NLUmphTHVya0c2WVVrU0psZmpLbUxPeEluK1EvY2xuY1dB?=
 =?utf-8?B?S2pnQ25lRDVpektRejVlYS9sZWFydi8vYWdwSnNMbHY2dHBJay9VQmJLcXZE?=
 =?utf-8?B?RmJlMkh3blM3WU1RSUlhK0k1Y0lEVENhc1pyNVdXZzRIOFJOSmlSNFZibjF2?=
 =?utf-8?B?TUJtUzR6bUhGd1V2VzF1UFA4bzd0WHFvNlIxOTI0RmR6bVBvRzJHbm1NdC92?=
 =?utf-8?B?Ni9hSnh6bHdJWjBXaFMrRjhDMkNiNXJzend2R3hNNFk1VnhYVUVKbCtJUFo0?=
 =?utf-8?B?NW1WOEdraDYycjcyMXBieC9BeGZhUlhqM1NWOWZncW5XV3FQeGgvcGorNko5?=
 =?utf-8?B?Vm5uTjJjWDNHYStEWmZKRVE3U0V3ZUJyaXJ1R3M0bjQ2dUtCaXpYQzRxSWtC?=
 =?utf-8?B?Yys5ck9wZmxuYjVxM0tVVFVzWjhUd0tRMDE5NjZWSXF3Vk1jcFBTd1loczli?=
 =?utf-8?B?RzRkYWphb3NTUWVUdWtsYlNEY2VkT2ZxemhoYTJpT0VVNnZ5QkVrbWJ3K0tp?=
 =?utf-8?B?a2Rna3pxaEthWENWbzdkVldkNlR6djY4Y1kvemg4K1FVcjN6SlVFbFg5aWFJ?=
 =?utf-8?B?dVlOUWlrZExqV0E3QWI1OEVSU04ySUE2WGJWU2FXc3huUmNObnB4VVQ2MDJD?=
 =?utf-8?B?TTJzZE9CdmJzNGRGNnRvTWJyVU1OUU9PSzB5T3M4VThUa2dXTTVQWWw3eEM4?=
 =?utf-8?B?Si9BN3ZvZTgyalRtMDk4Rnl0RG53ZE9JdHc5SlpZN3RIWmZsREFVZkE1aStx?=
 =?utf-8?B?ait5WjZkOTRheng4dEVPRGZHUHJDZmhDVzM0b0g3QXIrOTBhNk0vQVdlbVUx?=
 =?utf-8?B?WlNwSm1pV1dYK3Z2R1FaNm5Rd3ZUSVZncmIwb3dtMnZEd1FrcHEyTWJRcktt?=
 =?utf-8?B?Z0gvRHp0V210Yjcva21BcEpMbGcreXBENHBocGxVU2ZOZnFrbm9CTnBGY2Jn?=
 =?utf-8?B?YkJUai9YSHMxVFdzWTQzdWxmbHkzYU9Vd2QrRkNJUFZaLzdHY1NtUEVZWDV2?=
 =?utf-8?B?U05XUEcvcEkwaGVnZDNBaElibzgwZDlYQVFncW9qSnJER3Nsd2JRdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ada7b3bb-8a11-44a4-ee2c-08ded8ef073d
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:37:06.4724 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HXCEj6/+m1YDKjJ0xLx6cEjrSdaBqk02MBRHYk81OW6NEH9RF+BNAHTAhA8/3jqhaH5MbOQ+Ls8n6Unx8z0BwCwOxbUmVU3/TW4K6JjTox8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11220
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

Hi Varada,

On 7/3/26 12:27 PM, Varadarajan Narayanan wrote:
> On Fri, Jul 03, 2026 at 12:11:30PM +0200, Quentin Schulz wrote:
>> Hi Varada,
>>
>> Thanks for the patch!
>>
>> On 7/3/26 9:24 AM, Varadarajan Narayanan wrote:
>>> If there are multiple sysreset devices implementing request_arg callback,
>>> the first sysreset device will consume the args and may return
>>> EPROTONOSUPPORT if it doesn't implement the given argument. This will stop
>>> the loop.
>>>
>>> Since -EPROTONOSUPPORT is used to indicate absence of support for that
>>> argument, subsequent drivers should be given a chance to see if they handle
>>> it. Hence do not terminate the loop on -EPROTONOSUPPORT return code.
>>>
>>> Fixes: fcb48b89813b ("drivers: sysreset: Add sysreset op that can take arguments")
>>>
>>> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
>>> ---
>>>    drivers/sysreset/sysreset-uclass.c | 23 +++++++++++++----------
>>>    1 file changed, 13 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
>>> index f25e09e9cd0..0fc096e7f0f 100644
>>> --- a/drivers/sysreset/sysreset-uclass.c
>>> +++ b/drivers/sysreset/sysreset-uclass.c
>>> @@ -89,14 +89,12 @@ int sysreset_walk_arg(int argc, char * const argv[])
>>>    	struct udevice *dev;
>>>    	int ret = -ENOSYS;
>>> -	while (ret != -EINPROGRESS && ret != -EPROTONOSUPPORT) {
>>> -		for (uclass_first_device(UCLASS_SYSRESET, &dev);
>>> -		     dev;
>>> -		     uclass_next_device(&dev)) {
>>> -			ret = sysreset_request_arg(dev, argc, argv);
>>> -			if (ret == -EINPROGRESS || ret == -EPROTONOSUPPORT)
>>> -				break;
>>> -		}
>>> +	for (uclass_first_device(UCLASS_SYSRESET, &dev);
>>> +	     dev;
>>> +	     uclass_next_device(&dev)) {
>>> +		ret = sysreset_request_arg(dev, argc, argv);
>>> +		if (ret == -EINPROGRESS)
>>> +			break;
>>>    	}
>>>    	return ret;
>>> @@ -153,6 +151,7 @@ void reset_cpu(void)
>>>    int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>>>    {
>>>    	enum sysreset_t reset_type = SYSRESET_COLD;
>>> +	int ret;
>>>    	if (argc > 2)
>>>    		return CMD_RET_USAGE;
>>> @@ -165,8 +164,12 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>>>    	mdelay(100);
>>>    #if IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_ARGS)
>>> -	if (argc > 1 && sysreset_walk_arg(argc, argv) == -EINPROGRESS)
>>> -		return 0;
>>> +	if (argc > 1) {
>>> +		ret = sysreset_walk_arg(argc, argv);
>>> +		if (ret == -EINPROGRESS)
>>> +			return 0;
>>> +		log_err("No handler for reset command arguments (%d)\n", ret);
>>
>> Just use printf to be consistent with the rest of the function.
>>
>> But here's possibly another logic bug I think. If we pass -w to reset, this
>> will try all available sysreset devices if any can handle the -w argument
>> and then print that there's no handler for the reset command argument, which
>> is to be expected.
>>
>> So I'm wondering if we shouldn't bypass sysreset_walk_arg() entirely when -w
>> is given as argument to the reset command.
>>
>> Also, *any* argument starting with -w should do the warm reset, e.g. reset
>> -warm should do it too as that's the current logic we have (we only check
>> the first two characters of the argument).
> 
> Would this be ok?
> 
> int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> {
> 	enum sysreset_t reset_type = SYSRESET_COLD;
> 	int ret;
> 
> 	if (argc > 2)
> 		return CMD_RET_USAGE;
> 
> 	if (argc == 2 && argv[1][0] == '-' && argv[1][1] == 'w') {
> 		reset_type = SYSRESET_WARM;
> 	}
> #if IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_ARGS)
> 	else if (argc > 1) {
> 		ret = sysreset_walk_arg(argc, argv);
> 		if (ret == -EINPROGRESS)
> 			return 0;
> 		printf("No handler for reset command arguments (%d)\n", ret);

I don't think printing ret is interesting here as it'll be the return 
code of the last attempted sysreset device (so either ENOSYS if there is 
no sysreset device at all, or if the last one doesn't support 
request_arg callback, or -EPROTONOSUPPORT if it supports args but not 
the arg we pass it).

We should also tell the user what we're doing in this case: a cold reset.

> 	}
> #endif
> 	printf("resetting ...\n");
> 	mdelay(100);
> 
> 	sysreset_walk_halt(reset_type);
> 
> 	return 0;
> }
> 
> If this seems ok, will post v2 with this change.
> 

No, because it'll do the reset before printing it's doing a reset (and 
will also not do the delay).

But if you move the whole if block after the mdelay() then I think it's 
fine.

Cheers,
Quentin
