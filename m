Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E930C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 12:39:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE9F783414;
	Tue,  7 Nov 2023 13:39:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zdHMmELv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EACA58711B; Tue,  7 Nov 2023 13:39:36 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1842D86828
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 13:39:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6bCXtpvDMN4WuzCrwIyj09eMgOKEOU+xVNa/AnMpM4zAwvDHW4L4/8QxTOwwXnrUQXKtSHVZL6w510AfbOQdf0us0RQgQla4cUV/yQm5WU4qmh4uKkla5YDNthKR/2JRUT+S8gACVzHnckzp7InD3/Sz/a/uEIgfWGC5Bj0MQ7FmKXzMtJdE66obRiaYthCD02HP/4z/PoBL/m8LMcJpd3l5EiVU4gSfWjVb6c7TM6x74QVuEuQG4p/3nSXyo4VaVtl38HVMDZ4mdQdjjATFgnntVKZDhWdeb5RusOTaq1AlslELBJkVdEVArEbhDBbD1nLopqOZmX+CxKVTprL0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLP7fV/2vUgx5R03T7IUEz7szqNqN7/tvELogRIpLHk=;
 b=gAIpjyZ6mrqJYhMQM18ouExz2xPZPNgLVtoyaYbLZk66sgOzG8g/gBQuaKTcBL22x31jtyHhEiDxmYIaqDEwalET7Z//koh6PpW+hFkQhnXH2utfkSVl8E/ZuhrlsTXwJ1VVWF/nUGD6tXK2mJxYgeCqrcmU7rYpj7XRKjngXuRs7nD93nPcFmPFwOToEcx8VDKgdkoNMYbrnKxzYSe/2vSoVuIiR2N9aFVoTW8vaNy0VAkE8He0cj3nnljgx1KSxdUq+xdPca50Tg1B5SmZoc4Rz1CUdniddj5ivZd+uhoxnGbanX9y/t+lkhqu7wIMfjsMTLDPuGtX2AiHvI+R2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLP7fV/2vUgx5R03T7IUEz7szqNqN7/tvELogRIpLHk=;
 b=zdHMmELvAMEGLsnYKeqyN4PCF+xY+L4JFQMnfX+PB5I5KjB3umWyiah4zmZb1kyba9NpirUrjjIWc/cGcQMVN07qL+N4YDviY+jNdW+/szz/mi1UQtIotQeCpPS0IJwTTE2OUWqACtrWLDRMEiOtYCiq3/kER03bnnL93INhvus=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by LV3PR12MB9093.namprd12.prod.outlook.com (2603:10b6:408:19d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 12:39:29 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::1d07:c316:b830:70c9]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::1d07:c316:b830:70c9%4]) with mapi id 15.20.6954.027; Tue, 7 Nov 2023
 12:39:29 +0000
Message-ID: <45a8b60e-26df-4b94-94f5-f1652be57561@amd.com>
Date: Tue, 7 Nov 2023 13:39:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Add description for nvmem efuse layout
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Piyush Mehta <piyush.mehta@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Robert Hancock <robert.hancock@calian.com>, Simon Glass <sjg@chromium.org>,
 Tanmay Shah <tanmay.shah@amd.com>
References: <af81299cafc2bd13ed30dcd69bdf6efb5fbb7f68.1698840373.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <af81299cafc2bd13ed30dcd69bdf6efb5fbb7f68.1698840373.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0095.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::36) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|LV3PR12MB9093:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c071a18-7e39-414f-0d6c-08dbdf8e95cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aWX3R6U+5h5iAmh2oYhCa9rIWkIiIjfyObI6tId7zca5R9qKGQ/0Ug5MV5+FzT/R09175EQf6qxIx09DwHX5N0uWY+uu3LW9WpWWuo7GpdJs47xQK7uWlwRS6sxtf72QxNicrPx3pWonZPIXfum/J9MjK9EUhEcs+8SbNrjZOKQiJFkpzGCx8RdSk0yfTXFHz4Pldlb/9L53R644Lqa+ZtovYJ1EXU2roTWxNg68mRSc1RrAmwHRIe70ueePZYoxxDrFqgxzQsuQtyRdpHo5VcwiOenHLlUCwsXpPhyHAjmzHD8P5oB+nriiroFplGi3dsFvjbp8/UaeFpBZmQ/3vYELRmGS63Ykb/uS/qpiEV5sRdEBGBjwc+UbBP+RI+UdHOqduO11q1Tyw7vmdRJ4OQivplwYN69tWUVfY/yjmxdZ0YnjgrdwVWmwChhvASj4dcmhKzxWqFtjUUJ5bKO23JAn/53bdBvGHJ4OP3st8smfPLvU7TY18sEYfC4qsjlhF8HklU7aF13KmjLZISA7kJ+hciFrfSRLaX6viZE/2yZ2fl3+IcfyXcd0eRcq0FjGCMp38UVwpU6KTnI978S/VU1dvtLDmv5jvb+n+bUyGtIxp7gJSe240gVNmhQLmBtc7Vh2h8KgzuhHCdfPSjZXMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(396003)(366004)(346002)(136003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(83380400001)(316002)(38100700002)(478600001)(6666004)(53546011)(6506007)(966005)(6486002)(26005)(66476007)(54906003)(66556008)(6512007)(66946007)(5660300002)(2616005)(2906002)(36756003)(31696002)(8676002)(4326008)(86362001)(8936002)(41300700001)(44832011)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1pvT0x4V2d4S2YzdVdkNmMrWGtyY3diMTlaQnVBRjNQQUMzMkZnUHdSMmY0?=
 =?utf-8?B?WkRHK0dUa0pDUnFwOG1qVEpGaTdGOTV5TmN6VXFFdFJXMGpxSGtMUHRHdCtO?=
 =?utf-8?B?MTRoZjBGT3pRaDdvMzNSN3NIejBUOVlsQnlNaXpQTDl4ZC9OV3JvbjFoUzRI?=
 =?utf-8?B?Qkk4Z0FvUjFJVVNzcFdKZGNyWGRibXhlaGh1Sitscm9nbkRGUkQvZXZXUnBh?=
 =?utf-8?B?NXdFUExpRnNodXNrOGExT3NEK2FKZFkyMTVmczdZclE1ci9pZVNHZWpENlN3?=
 =?utf-8?B?ZTlMRTFjZVZwNWVUTWZSMG01aUlJSWRLS2JYV0c3dm5Sa3ZCZ1dEUUtEYnFa?=
 =?utf-8?B?UFBJdVI5Mnd3bXU3R2xQM3hrM3pXQnNuWGZ0cXlWdUVUTThrMlhVeFNiVnJk?=
 =?utf-8?B?K1IrSHZ0RGM5SlhVMEtMMG01ZUZvYzJEL2VNWFFtNTBDU2dSdGJmSVM0L2k0?=
 =?utf-8?B?T1ZkSGU3cVZhN05CK3ZITXhCSVN1aWxCVk8xdFlzZ1VKZ1VHSDlTQkk3SWZx?=
 =?utf-8?B?K3ZUNyt6aU1JWEswd21zWnBOZEJ5bk94cDJqZkFmNXQ0bXJ2SkxFZy94cnUr?=
 =?utf-8?B?eGhYZjE0REFmeG5EMk0rTjM5SmZ0RGlKb1NydEdGWjFIdXNpeWdjRkRvaS9E?=
 =?utf-8?B?bUpxbTFjS2Yzc3JLOHFoUnZTaDcwYzdXZ1l4SjY2elVLeFVUZGUxSmpDemFW?=
 =?utf-8?B?RjNMc0lydVNweGI0bFNjK3U5cnV5Uit5YUZCOUZqZHVzcEFsbGM3NDgrUGRQ?=
 =?utf-8?B?bWJvZ3hDWVRiNzluT054NythY09EMTI2QUZCalp4dkU1RElGdjZsYWh6djI3?=
 =?utf-8?B?TERDS2xOWjBra2xNNk1YSUo5c1VMMnBPYmQrNHBWSENvUGxKNXF3UFBFdFp1?=
 =?utf-8?B?aG1oaFNTMlFzaFRlMi83STAzRVVxSmZzRTUwM0xGYWpyY1c0a0ttdzlYQzAw?=
 =?utf-8?B?ZXIranlNcUFZejZOVVdCVjVEY3VnME1yVGc0eTh5VTdrdFRrSDcySEJoNUNa?=
 =?utf-8?B?Ym9qQlZSQ2tzQzZ2NXZKTzFJejRSMTI5M3ZxRjVJaWpDQ0VyZS9yNW5JRVpG?=
 =?utf-8?B?OHVyT1NPeXMyajRERkdhSzlQU3Z2TjA4QTcwQ28xMmhKOEhFWTNzbHFBY1Fs?=
 =?utf-8?B?R1RQbVp4TElYWE5XMWMySHMrKzVUTkpXVUhaN2dqdlE5SmRPZEwwL2ZHNXdx?=
 =?utf-8?B?amNlWTlvbGdPN01wZ2dZa3NNSmg3MjM0SENCUjNTMkxCVmJiTlQxUjlxSkQ0?=
 =?utf-8?B?T0hWUkg1Wk1IU3BrWFR5S04veVdmR2E2ZWk1U3JFd1B6K0VkakhTdUtzazBX?=
 =?utf-8?B?VUpDTTc0cHFUeGJoZW5lN0ZXeitwMHRXWUtCN0szbnAxb0E1bFlHaFY0M3dp?=
 =?utf-8?B?QXRXSnh5UGh3dDd1TDhwWnhQa3FNcUdFRzBsMzF3cHVMNFhTYTBKVFQrNWdL?=
 =?utf-8?B?aUlibTZqdmUzbEdZUEp3MHBJK09Xb0FwT1gxb0RiWGVWcmhuUE82ZlYvby9x?=
 =?utf-8?B?eXhQNTBFOXBGTFRMK0dieFA3a2RMN3Q5a1MzMjQ3MFg2UGRpd2hSUnhibGVj?=
 =?utf-8?B?UU9iVHN3cDgvb3Q0OU9aWUgyVmtsL1ZoZUNweVVlb3dwUU5WdjY5dmh6YnZS?=
 =?utf-8?B?RHhkRGxrVW5RV3RLVytqcTVaVy9YSG9zdnUwQzk2NkhCZU1nL0tKS3djOHVK?=
 =?utf-8?B?cW9lOUZtaERURmFMVkQ0Wmh3UnkyTlMwckpDd09wdnZodmdVVEJVL3JoNUh5?=
 =?utf-8?B?QlRIanR1OWRYTC92M2VWUU5oczhNT2VJWWljWm55dS9JaHRGZzJyclZjVWFj?=
 =?utf-8?B?RUZLVHF2VDRkMWkyN0ltMlp1cWNxNm5iWE5SUjh2UDJtSnNUbVA5dTZ5c1Jp?=
 =?utf-8?B?Q3dXTmx2RHFNSmdqQ0FXeDRGNXlzWE8wTHdVSHFEMmNxYWJvWjVCZUs4L2gr?=
 =?utf-8?B?c2FLWnArL2lIRjVVeVI1T1R2d1lYMGNaV3VRL1YxSGFQeUtpdklVQnRYT0hi?=
 =?utf-8?B?L1hqbTIwZUxocGpmNVhsSWE4ZUI2bk81RGlHWWthLzhZdFlDSFJ4OGRQOTBL?=
 =?utf-8?B?U3htWk5YbVZZa0c2YkNuelowdWNqLzAyOFYrai9yaVViNWJ1LzJpVHVWeHU3?=
 =?utf-8?Q?+498hezgjOcq0ZZK37ZAiRINe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c071a18-7e39-414f-0d6c-08dbdf8e95cf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 12:39:29.7422 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UqzQ60FzX17gnpUaawQ3MdeAczpTskZn6eJ8/lYXtE42dVqfjbywv3ZCH4x5O9Jv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9093
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



On 11/1/23 13:06, Michal Simek wrote:
> Based on discussion with DT folks at link below there is not going to be
> any name restrictions for child names. That's why add description for
> current nvmem layout.
> 
> Link: https://lore.kernel.org/lkml/20231013101450.573-3-praveen.teja.kundanala@amd.com/
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp.dtsi | 49 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 49 insertions(+)
> 
> diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
> index 2253e773d386..735543513f02 100644
> --- a/arch/arm/dts/zynqmp.dtsi
> +++ b/arch/arm/dts/zynqmp.dtsi
> @@ -214,6 +214,55 @@
>   				soc_revision: soc-revision@0 {
>   					reg = <0x0 0x4>;
>   				};
> +				/* efuse access */
> +				efuse_dna: efuse-dna@c {
> +					reg = <0xc 0xc>;
> +				};
> +				efuse_usr0: efuse-usr0@20 {
> +					reg = <0x20 0x4>;
> +				};
> +				efuse_usr1: efuse-usr1@24 {
> +					reg = <0x24 0x4>;
> +				};
> +				efuse_usr2: efuse-usr2@28 {
> +					reg = <0x28 0x4>;
> +				};
> +				efuse_usr3: efuse-usr3@2c {
> +					reg = <0x2c 0x4>;
> +				};
> +				efuse_usr4: efuse-usr4@30 {
> +					reg = <0x30 0x4>;
> +				};
> +				efuse_usr5: efuse-usr5@34 {
> +					reg = <0x34 0x4>;
> +				};
> +				efuse_usr6: efuse-usr6@38 {
> +					reg = <0x38 0x4>;
> +				};
> +				efuse_usr7: efuse-usr7@3c {
> +					reg = <0x3c 0x4>;
> +				};
> +				efuse_miscusr: efuse-miscusr@40 {
> +					reg = <0x40 0x4>;
> +				};
> +				efuse_chash: efuse-chash@50 {
> +					reg = <0x50 0x4>;
> +				};
> +				efuse_pufmisc: efuse-pufmisc@54 {
> +					reg = <0x54 0x4>;
> +				};
> +				efuse_sec: efuse-sec@58 {
> +					reg = <0x58 0x4>;
> +				};
> +				efuse_spkid: efuse-spkid@5c {
> +					reg = <0x5c 0x4>;
> +				};
> +				efuse_ppk0hash: efuse-ppk0hash@a0 {
> +					reg = <0xa0 0x30>;
> +				};
> +				efuse_ppk1hash: efuse-ppk1hash@d0 {
> +					reg = <0xd0 0x30>;
> +				};
>   			};
>   
>   			zynqmp_pcap: pcap {

Applied.
M
