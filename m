Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C304EC4707B
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 07:43:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAEAC87738;
	Thu, 11 Jan 2024 08:43:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OvcZWII3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A9E187720; Thu, 11 Jan 2024 08:43:04 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94CB587738
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 08:43:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzZftbBnJTf/xpBMBgzy5hUuTISRnOG9z5bgN954n/WYNGEo9RqbJq0N5jnmk7rUH0xslX50FS+IMxdUh5hc5krOK6zGH+riY+cx6GPU2GgbyN1WZ09sT7bCE5FNeKanpOpBeMyeiE5PVmUisxf5Mb8+L6o+gB+DWTuJKxU34MncLtsbLgI4lmpCv8+K2ZUiN9yWWCVPdDHnXOq/d5cReTYVYa3qXSy2/RP9MZCRyNM95L1QEOKtQ6q64XEmwB9m5a1grkW7bpvAo8to/zGoZ0au7FgDzktGIJI4Gd0zxa/h4tI9TcYEQNc7B4QuCiLYLZfUM5TlJ04IgtKXOLfzzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqGXlPWtmdUBe8TCiLIUzrYThKz3zw18GlBeLF64XoU=;
 b=Ek1J6LrYDs+GRdZnm3naRAFgIoAiy8/2EDxlRp//i3taAraUGFynGg5peOcOJwId47YAn+ALYPwfG5xsPxj3tRzsZc9pQ/az6P4hsVMN+b6N1t31c5WiS3XRPrE9bUQeM6a8t9ZtSJlPlkSrso+LlW7On6EVC28Ajo0UyfIM6qINGfcwHslHXyFiqM4lm1JLBI5mDKRZv0YEmUZ0vKGC1hwXaaasIv1gTWohJV/rbwEixZnXhDY0aR4KHuuS1jnMiYC4myutMvU8SZ0rvpD4wHMc6NY+55O2q7Lke3TxV84AA7+hpqIYxN6Z0MuwIjCsydFuiFKg6RXmLrgR3vRZag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqGXlPWtmdUBe8TCiLIUzrYThKz3zw18GlBeLF64XoU=;
 b=OvcZWII3U9ITo4HqGKLq5UC4eNeiWofeCRvKlINafc0VuSwGmuSANdU0S81VcJYcOJC4yaoOA3ISdoRWTGOH7Af7XSPJID1Uz0Gmt5dGlDsWR1o1GtXDhNpuyWZwtVoc90a44EtbqNxlf4hNuIe7FdUDhQSgS4UGftI+YFG7GbE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by MN0PR12MB5858.namprd12.prod.outlook.com (2603:10b6:208:379::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.24; Thu, 11 Jan
 2024 07:42:58 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7181.018; Thu, 11 Jan 2024
 07:42:58 +0000
Message-ID: <555b6601-a091-4c66-8008-59a29ce7b38f@amd.com>
Date: Thu, 11 Jan 2024 08:42:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: Integrate usb5744 & usb2244 driver support
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: marex@denx.de, git@xilinx.com, T Karthik Reddy <t.karthik.reddy@xilinx.com>
References: <20240111071057.2771902-1-venkatesh.abbarapu@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240111071057.2771902-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0084.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::25) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|MN0PR12MB5858:EE_
X-MS-Office365-Filtering-Correlation-Id: d09bef7b-61ba-4b9a-79de-08dc1278ee01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +VWN6ahYZc4YCav9Ff0kvLlWj38ZAWofkH7ylYTIVfLEybH0n6TcY7q44jHHnC+iL1snftOCJLXmNBLF2BpU09TsBvRNrs6Q786kxEWHw+2PymPtWWp9a1r8tX86bmsSmVk0AA778VO382eejmjQbMxGb85DPoDLF2B4p+luUKP3IT9kE1/WVAieb7dhC52Xz8Ot2ZUoqzf90W7hXE2KAzh1j9KKA7HLiHK/qd64mrQOUaMGAA4JCFO7UoOV01//X/mgV/RqbJcbLB4xNOBQZbakSx/yz8wq0klCRVitlNUujWad2bBjUhFdpp8Ys3RCJwy0SCtIezO/+nWV+bWA81S3vOrHoPjtuRp8T1hL6BWyFpHY9hTvQ1IEHRxzc8bwQZtjJ0JS+ZdGPw06Lagtg/eh5tb1EMltXqQiZ+3O+IVTiyNB2x+3U2c3oLN1NhZhL+k+F0eBubPY8qFrtCftWZxWtOeJTEv5rC0U9KubTPMCiQKtSPwIUU4/9+d5iBF9EUnXg/hglHbnBv/71wrRcPaVIN4pWdx0a99seuu3ueQwUpIftpH4fZcNpkqegrJdCCZfGvwBB9iOqcbKQyrtNjKEhN1BuIDfnRbJTnxoK9ByK8Q4dKKOJfEZy27Jf1UPwSi3h96ALgsPjD4Qt9obTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(31686004)(36756003)(6486002)(6506007)(53546011)(66556008)(6512007)(66946007)(31696002)(86362001)(478600001)(66476007)(38100700002)(5660300002)(316002)(8936002)(83380400001)(2616005)(26005)(2906002)(4326008)(44832011)(6666004)(41300700001)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUh3Z2I4OThFNmEycVlwVEdlR3grK296RFBlaG5TYyt2cjI5UkdQQWxRRktk?=
 =?utf-8?B?NTBmK2lUUXFSUkVPRTJwc0NTNTJ0WXd3OWg0WHJ5SGZmbDFIeDhHdHBqbm9P?=
 =?utf-8?B?aWtOQ29GQUJOTWk3NDZOUHZ1MjBnaVVrMzVJNHRUb3NFYWRPbm4yRUh2SmxT?=
 =?utf-8?B?QWR2WkcwUVlNQnJOS205TWpCQThTSzY2SFNDODdwSGZMYkFtZ2ROUksvMzU2?=
 =?utf-8?B?T2JPY08yVUw4RjRZYnV3RnU2L2Y4WGRHbmZVb2V0WnhJYnFlS09VaEpnS1BN?=
 =?utf-8?B?Qm9DZFI4V0FXMkt3VDhGQS9CZW9TUXFwWFpEVThnbjk2VXlJVGJvR05rZ3Q0?=
 =?utf-8?B?QWhQRmdHVEZyMkVUNk1NblFyZ2xmQWpIUGF6UDlZYjBKdHk5Y1ZHMkNGVHg2?=
 =?utf-8?B?TlA1UGZ3K2pNeEVWdU9sV1FvcmkrUnRFNGpML053aXZyNTUwM1poTnJHcmxi?=
 =?utf-8?B?akl3bExtVlFldWw2WU4rME5XSmFaOTZ5Qk9MdnZPWWxYMkUrVEU5Y0RHQ3pS?=
 =?utf-8?B?UlZqeFJwd3dpQUsveDFYSHhUbko0R3RMSldpR3lhN0lieFp5d3M4ejE2L1NZ?=
 =?utf-8?B?UGlVU25NMUtUT0FFU1UxZDRGM1c2YWpLU3pYUWJYQngyVGhpRWhyRUNhR3ho?=
 =?utf-8?B?ZlRzeTFiT0ZMVFZBUzFWVXJFVmQvNE9IZzRJbWM2RTBmTXZReUlPREhSQlRZ?=
 =?utf-8?B?Y2ZYVnVsQ2F6NGdiR0Y2WEdjcWJ2Nk9zODM2UGN6aDE2aERyMFJsaVlhT2ps?=
 =?utf-8?B?c0VSbG9xWC9WNWhRMm9VU2dSM3NtQVRFZ0tRdzg0Z2dHY2dlR2JrTWg3R09h?=
 =?utf-8?B?aVdNK21tS0g5UnhSL1o0Wk5BMjhBV2xOR2cxTy9ITTBXNDlEZlhaSnRwYzAw?=
 =?utf-8?B?SlUzbHlNMDJnQmd5ZlZ0a2VTZENTQW5HVk1pd2JWOXJnTlN2UFNYMGl0T1hT?=
 =?utf-8?B?WWlEekMzWVVpZUFLeDNXWkVONFYzNVplSWF5enp5ajhwRVVVT1hJOVBSd2Fw?=
 =?utf-8?B?dytJUnVoNjZXaFR4WTBIMHVNQjZ0QTg0NG0rMkF6TEE0bG5PcGlTT1N4Uzht?=
 =?utf-8?B?eU4vak5UMlhla0d6ZVF1Y2orSUd1a1J4dGU2UnhiVk14R2dQakRBMnQ2N05S?=
 =?utf-8?B?T0hidVVzQ0kxMmdxTzdoSUtva09lcVhIMGhwSlNMbkMzcm5ZbjdVRFN5aHdw?=
 =?utf-8?B?S0ZUZHM2VWdUeVZvaGZqNS9nazNrWUpCcEhseVU1WjVNcUFmN04xNk1TQ1d2?=
 =?utf-8?B?SXBGMmQ3NWtPSG55aTZUbWJmTGdKemdKM3JkandySCtoUkFDR3JST1lxWDZC?=
 =?utf-8?B?anZqOEx5KzJRTVM0R0tQeHJ6T3pOQm9sbjllYjhCSndxRXRRT0JldXQvcndx?=
 =?utf-8?B?aENZL05tWkdQdWNQQ0xmalpHV0dxZ3E2aG0vbEk3cWZ1dzArZ1hTYUZ2dWdy?=
 =?utf-8?B?dmIxSllVQzlSQWRTTUNLTHdZYitzUUZIZ05OdHk0MzVmbVAxLzgxT1dCMlBw?=
 =?utf-8?B?Q1BEWDRXTzU3T2ZHaDhCQlNHSlVTeUVOZ044MXhDYUVsMXd1bFI2Snp5aUxG?=
 =?utf-8?B?WG1LNUNGV21kVG45MUZTNnJxdy9xaEtDY1lwVHZZWjhuVEUrTEJCcXIya29t?=
 =?utf-8?B?ekR5bExhb3hrT3dUUWVrbDRYWVZBNDFuQXJMNzE1MGZ0K2lPRExOazI0VmdE?=
 =?utf-8?B?VWNCckZmU0o0eXk2WmtNZ1lkbVVDTUlxdFhQVndmMEpxaU83bUpTN0RnWm9h?=
 =?utf-8?B?ZmtzRHJXaUc1MFpRMjJXZFVZbkVNSGt3YTRXY3k0SkdCZEo3VmE4TFVkYWlN?=
 =?utf-8?B?SEZZU0VFVTdlYjc4SStIZXNnQVB6Mms0eEVxdjB0K1IzL0JoZG9DNWJ4S3RJ?=
 =?utf-8?B?N1pnZk5adVRzUUcvc1IrOXJGNkNkV2NWeVgxR21WZEdYNHZJam5ZQTVzK2Ns?=
 =?utf-8?B?dy9SNkVZcTRDeFFSeW9zcUFqcVBYeDBvMmp6YWNKZUZleG1KeHpmRVgyeENt?=
 =?utf-8?B?RmlaVVpoVUhtcHlGZm43ei9hd1dZaE1zWDVHVkZzZmJMdisxRy9mdjFYK3hn?=
 =?utf-8?B?Q0padkJlZW9LVlJ2VXBlM2h3VkJsMHpxUjNmUG9ObnZ6TXVhU2J6c0hROWVa?=
 =?utf-8?Q?u9e9AuQGDUYCIpDa3JmIyp1jE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d09bef7b-61ba-4b9a-79de-08dc1278ee01
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 07:42:58.1130 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: whPYpqIlFteS8eWvIUDHdqo4H4ehZSJFXUz/Qxj02tc9yuguo0qdN9bTYgPFfyFV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5858
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

First of all I think this should be more RFC.

On 1/11/24 08:10, Venkatesh Yadav Abbarapu wrote:
> Usb5744 & usb2244 are Microchip based usbhub and usb-2.0 based SD
> controller devices. Integrate these devices into dwc3 driver to bind and
> probe the respective drivers to get detected by usb controller.
> 
> Signed-off-by: T Karthik Reddy <t.karthik.reddy@xilinx.com>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   drivers/usb/dwc3/dwc3-generic.c | 67 ++++++++++++++++++++++++---------
>   1 file changed, 49 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
> index 6fb2de8a5a..a2eb2c8e24 100644
> --- a/drivers/usb/dwc3/dwc3-generic.c
> +++ b/drivers/usb/dwc3/dwc3-generic.c
> @@ -430,29 +430,49 @@ static int dwc3_glue_bind_common(struct udevice *parent, ofnode node)
>   
>   	debug("%s: subnode name: %s\n", __func__, name);
>   
> +	if (!ofnode_device_is_compatible(node, "snps,dwc3")) {
> +		if (ofnode_device_is_compatible(node,
> +						"microchip,usb5744"))
> +				driver = "usb5744";
> +		else if (ofnode_device_is_compatible
> +			(node, "microchip,usb2244"))
> +				driver = "usb2244";
> +
> +			ret = device_bind_driver_to_node(parent, driver, name,
> +							 node, &dev);
> +			if (ret) {
> +				printf("Failed to bind: %s, err: %d\n",
> +				       driver, ret);
> +				return ret;
> +			}
> +	}

I don't think this is going to be accepted by Marek to have device specific code 
in generic code.
I did some grepping and I see that there is new CONFIG_USB_ONBOARD_HUB entry.
Don't understand why it is in common folder if this is pretty much device 
specific. But there is a new UCLASS_USB_HUB class.

Venkatesh: it should be investigated more how it works.

Marek: IIRC you mentioned any support for companion/peer hubs.
How do you think it should be integrated to u-boot?

Thanks,
Michal
