Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E73EDCD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 13:09:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E9F18813F;
	Tue,  2 Apr 2024 15:09:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZIO7+HwZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 310C088165; Tue,  2 Apr 2024 15:09:12 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20731.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::731])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48B6F88137
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 15:09:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KVk3GrDKeLAGCeODocLvnsP7H92pJpmP+GaZH1dEiB2c5kG8mT+UWZqvaeR7PEWtbXI6g49Go+amIkumIbOz2g2OgNE5Z7je60ci3k/34kHdKb6bwc7ZuDhqlwTRTEF9NqZMibIJEuptx2ALp7CD8ytp/zTIVEhqkUxT9NnpOn7AeH/bgCkqltXoVegRqNhvK5vhODBcfHrksIIxZYeEt/NzNlpaQSO1pMjB38lJghMZ5tPxQMjbpqKk9DNm15nkrGaTX1slYF69hjskpY+MS6Lo4ZfA4/bszmStd7wsTU4znpFgsnhexuPF7fi90HX71DUbQfI5bGZR8Zc3Gy0Ykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Ged0fxYH2+sw55nU1Pz8V0DBnfYBjRX+ddSpn3JAeA=;
 b=e80ZGiFonjwRCHWzBv6tl3pc0AEWYeByvGTnwtveqWXixnNQfxqxO21th7UrlP0DYn129d2M1edZgGurN71KNCZy2L5VkcyKDHJ+9Zwf5B+aOAs0gPsxD9aPYkKWr2vehlO5Bha14/VJjJTJxIuGE02xUC9xfH1PfH3hKXwkeKix9SsVvZFVQdiE97Cu7rFaJh7NeomZLp8gUBLeicGYWUKAEBbfyWNsroQB/Sh3lAqdQV+4t1KhX5Pdj4RcdryOM1mx82Qysg8OALnpbsxU07JzflcJM6cCxW5UMhUg35+e+dETtznaPdbnb0VIFf/MpyiYII6W5j1A9eXfRORl9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Ged0fxYH2+sw55nU1Pz8V0DBnfYBjRX+ddSpn3JAeA=;
 b=ZIO7+HwZJf1ofJPdhsuuLmQ59mJfU/Qnpkhm3ZwY6JCbtnf8ehyw7lFyITm5WeyVJ46+Vd5FBHGt1+GWJma9EhDVncOq4+FLASGnpqRJCo2lQ2ygWB87xsTpwcEbWLY4s8LWuVD7Cn4Ig/SVZODz5IzxGmUkGjJnR+E/BYGflU0=
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MN6PR12MB8544.namprd12.prod.outlook.com (2603:10b6:208:47f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:09:05 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 13:09:05 +0000
Message-ID: <9be85361-948c-4acc-82f6-ee0e57481fc6@amd.com>
Date: Tue, 2 Apr 2024 15:08:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: zynqmp: make hw-ecc as the default ecc mode
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com
References: <20240325095013.29497-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240325095013.29497-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0013.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::25) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MN6PR12MB8544:EE_
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x+66ZA51nGdWwt/8es/QJ8CV5c5wPVRKtxLt+CtSoHRgkYrmJgOoUugeIT/u7IP1z4ShzIgUACRLei3fNUKD3Y4puDLbR4iqXSjeghC9k9ZN2O6k81l3DYR9QkwyPW+jQD68yc3i99pcDbCXHX8HP0/0Uloe/+OIiuvqMCPlDm7XMo8Ha/T8PzF7Z8Cob3PkPY+O0+SIAcT+4usJVxcKMR5ZrEGpV678IEykYiJ7yQfQprUdgnDZwBAZfEDcgvDJMKKLjQqpiWgbepZ2AgUT5PL/zXfa7RaZ0tLqWKAo08GotGEqvn2JHlcUyAdhZlFGDNJYZPtnk8jKFaW8S5j7So6sJ0c7ypH68rU81t8MlxBvYgQtQZAjvR5SXZ4ok3rb2wieSxGMpVvQAAplGV5zQMThz9/ejlK6fnl6YBPtQ/Ynr7JQKs4uXQx/f9OTgnO5+bl+bsZzjDQCcClmg086eUTi3XMLXWDf86pzkYXlszbFlbDP7WeRTDvzYzCPk+WPEBfSHXSYdwTY0BAzmIOngKA224PW4C49/fP7OUG4T6D5E3By8h6ecqppJOQxG1XshJCcOKMWn7KkXuh73J1qrjDaXPY2xps6nNH7LD8Ad/vJdzWgoAkpbMU67rn/t5OZ2sKxXHo5uduwybI6zB5mhxU7IQu8oFTQfeSmYPLAPK8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXVzUFBpeG5YUVEveXovYUV6V2lPOXhTem1yanRLZ2l3dzJnem8yYUZiaGtp?=
 =?utf-8?B?RFlDaExCTVFWRTRhUXpuQkFTeHd2em5Kd1BuMlVxTUtXL1ZZV1ppRWNpL0k2?=
 =?utf-8?B?a3dVMEdEekpSbXhEazNnaGMybVRTcGRiYkNUSm1BeWZOTUZrQXpIeTNQUTd2?=
 =?utf-8?B?UFRYV1FDWE1NbDZia2JaMk1aMHIwYjF4UVRJa2JzcFhEWkNiWTFWMFM1YmVx?=
 =?utf-8?B?VUJHV2s2NVplbTVEYmI1a3BoYW5uYlQzQjNsYktWTC9hUk9hYjc3MkdjY0lG?=
 =?utf-8?B?ZldjdzlhMVRpSTd6QmowcVR4dGJEWHZKeFdEdzNHWGswZXQwaFRnOW9ORERJ?=
 =?utf-8?B?d21qZ0JXSG42V1hRdkxUUHY2aDJIMUMxTDE0NEsyaTFEeWNyZWNIdlluS0k4?=
 =?utf-8?B?cHROOGdTb0FtNE9UdFBDY3l5OWZHcFg0SC80eGxGOU9TVmlIN2FOVk5YMS9r?=
 =?utf-8?B?NE5CbWYrUFhxK2lweXhwNXh6NGxqYmp4UFdQdE9XQmg2MkNsOFplcG1TOHRP?=
 =?utf-8?B?WXVXUXl1ZVh1YjFkNHhnNXNJNnF2aDllaEhWd0FyeHczbHgwclFldEVIdXpL?=
 =?utf-8?B?U2tBYmU5SU03U2p0bk9GdGF4Rm5uc3QxNnpGeG5ibzJQd1BkSHJ1N3QyT1dJ?=
 =?utf-8?B?QnVzNnJRcm9yUHFBNTJwL2h6cHFkcTRINnZEd0FhamliTExlUERITzFKalVP?=
 =?utf-8?B?UFJKaXpSNnQ5VEgxc1p6WHFLU0JJVElVd0h1TlQ0b0tkN0F4bWg1ZnVzdWtU?=
 =?utf-8?B?UEZGZnZuMDBWWGtmcTZPcHdZMjRZSDhuQXQ5dXJHcWh3UCtFb0N5aUV3SVpm?=
 =?utf-8?B?UHVHNTNqVE00K2E1cnVuemd6QVArdmRERDFwY3ErelRKaEFJOHVvYmFpVXZX?=
 =?utf-8?B?V0tHQjVNNUFxOVJFOHhlTFJRS3hrZ1g3c1lobnh6dlpTcDZZdmN6a0ZyeFJx?=
 =?utf-8?B?S21JV291R0trSHpxVVVrT1VFMS8yZm94dy93ZytCd21TWkhPRGliNTR5MFhk?=
 =?utf-8?B?OFdKTkdIUEpKQUhlYTdmYitBZm9uR21CYmFFTFkrYjYxSERGMDlsaktGdmRH?=
 =?utf-8?B?cmhGV0hsQWEzKzlqV3pIRVZxaTVDOWNya0FTYzZmSmViSHFWVVltUUxiQXE1?=
 =?utf-8?B?NXFSMHprVVlJeEhEK0VYSlJQV1NHbDg3bHV2NG5FMXp3eTB0WktrZWhNcjg0?=
 =?utf-8?B?YnZlWSt2YVNvNE9xVVBuallQaitlSVZOS2txZThQRFAzNVpjdnZJcFJMSlFG?=
 =?utf-8?B?RXhuNVg1YWJSOHBlWndnRUZ6d005eU9WNjIwclhaSnlENktLbEJwL0dGbE1J?=
 =?utf-8?B?ODFUSVV4eWZ4ZWpGbElYSThDWm05M2FBUWNsSnZHc0x5ZENrQ2EyZ0ptKzZ0?=
 =?utf-8?B?RVowb2t6K2lmb1kraU11N2RtTGtkbUhKMGR5QzJIaW5GQ3pmSDVxZE40aFBn?=
 =?utf-8?B?SmcxM3Z0MDljOE5raFZlYWxuMnJucVd4SG10RmpUU1BPQ01kTjVjem5yMW5T?=
 =?utf-8?B?Z0h4Z04wbWtuUFdXcU9nS2pzUUx0eXJWc2JtL1Jmbi94ZXRWNXVLcVhyTWcr?=
 =?utf-8?B?Q0o1d3h6K29zcDZ6SjNKZE1UOWVHYlpaOWFETG9lVko3SVhqdmpOdzdBUmRZ?=
 =?utf-8?B?QWRsYTEwL2NlS2REMERmRTlPTEJFVnNsTTdjOE5TcWg2MWRpR0V0QTBZL1U4?=
 =?utf-8?B?Q0didFlYT3lSVUVDVW1IT2NBRzZrUGZReGxPQ0hkNEk0K005T3ZJcElYU21G?=
 =?utf-8?B?bGUwRmhhN0NzOGkvMHRHZmJjeFF4a2FDMGhnM2VUcGlBQmpMYktZTWRTUFRG?=
 =?utf-8?B?NEJNN3NxVEszWS9kLytYZ2E5eloyNGxZdFk4YkcwWXBuemVDTitqZHhhK2Fy?=
 =?utf-8?B?Ry9ZWE9BNkhxRGszVlhzUTAyM0JFMnZqQ3laSWFsOHZRLzJlR1VFdVZ5SG82?=
 =?utf-8?B?Rys5aEM4U1ZKVitXT1lXTXlkczBtd2tvSGR5MnRtMGVPRWNERllFaDF1azRR?=
 =?utf-8?B?T0NGQ3hxQ3dtYll6aWtGODhLN0tTeXZmK3NsZURRVTV6aGNvMU5xWEE5TDdI?=
 =?utf-8?B?eUZDUHQwYkE0dEFBa2t4TGRRN0Jkd3RxVHpZdmtoTkUwK01xcEJWNm9IME1l?=
 =?utf-8?Q?UKQItC7t8n22rQ36oLvXTlyIe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a92d543c-b0e3-4618-155b-08dc531612ea
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:09:05.4118 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 91ajyyHRks7UA/BBMGpehe2hQE5ADMC7zU3OXXzkIdRCj658celMm2IAZgBKB18w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8544
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



On 3/25/24 10:50, Venkatesh Yadav Abbarapu wrote:
> Except for Linux no other component (i.e., u-boot, fsbl
> or BootRom) of the software stack supports software ecc
> engine. So, make hw-ecc as the default ecc mode.
> Update the same for mini u-boot nand configuration as well.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   arch/arm/dts/zynqmp-mini-nand.dts        | 6 ++++++
>   arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts | 6 ++----
>   2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/dts/zynqmp-mini-nand.dts b/arch/arm/dts/zynqmp-mini-nand.dts
> index e0517cf460..5889d436ed 100644
> --- a/arch/arm/dts/zynqmp-mini-nand.dts
> +++ b/arch/arm/dts/zynqmp-mini-nand.dts
> @@ -50,6 +50,12 @@
>   			#size-cells = <1>;
>   			arasan,has-mdma;
>   			num-cs = <2>;
> +			nand@0 {
> +				reg = <0>;
> +				#address-cells = <2>;
> +				#size-cells = <1>;
> +				nand-ecc-mode = "hw";
> +			};
>   		};
>   	};
>   };
> diff --git a/arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts b/arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts
> index b97f7ee8d4..48ab619472 100644
> --- a/arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts
> +++ b/arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts
> @@ -136,8 +136,7 @@
>   		reg = <0x0>;
>   		#address-cells = <0x2>;
>   		#size-cells = <0x1>;
> -		nand-ecc-mode = "soft";
> -		nand-ecc-algo = "bch";
> +		nand-ecc-mode = "hw";
>   		nand-rb = <0>;
>   		label = "main-storage-0";
>   		nand-ecc-step-size = <1024>;
> @@ -173,8 +172,7 @@
>   		reg = <0x1>;
>   		#address-cells = <0x2>;
>   		#size-cells = <0x1>;
> -		nand-ecc-mode = "soft";
> -		nand-ecc-algo = "bch";
> +		nand-ecc-mode = "hw";
>   		nand-rb = <0>;
>   		label = "main-storage-1";
>   		nand-ecc-step-size = <1024>;

Applied.
M
