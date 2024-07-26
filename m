Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6CAFC3DA63
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 08:10:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6165E884CA;
	Fri, 26 Jul 2024 10:10:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hPJNFT01";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29952884CC; Fri, 26 Jul 2024 10:10:28 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::600])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 664BB87CF8
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 10:10:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=seYVODv1c+e60914pQNBwISNGhVLZ9NmexUX28VOSDu9d0D5Y9GKAm5SysoHz3xKLYjNCrhTaEBJBI/aZjWnNzhaLmiRNfIxytVi30cdATz+BbP/gQhwXBxcmv4l5YhoJ7FS47FYEJ9Vsc4oCFla5KQnf62Su8mDotv/zfSi41L8uCr0m1x+F+Ue54eI59iV52ATttxVEB0PXY9Y+F4Q4O+EwmHuRIwnN45V6GypzvdryH25qV+oWzCrfJXKj04kDyEKr2NMssltIAbM5F2H+9WG/J1ye3pPMceqTqUt2407aQj9zm0HG7zqBDt7+khY8fLH7he5m7mDdDjF3sZQPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epx9qLPRn3LrrQqKy8YpaZKhMdSeZpgaD87XJzMmL2w=;
 b=Bie6nJODGG8wUPO5o2FAZ0QGWDqF0tSjiwp9NR5NOLxQR8ce5oEdBwsqotypyltYqXHiDMnrINrHX4ATl/ZRTL2kxwP3t86ec2+FiCRw7AtmRon3u7ZNY0C8H0y4lVTuAOgvh8lcfVy6bDXpnlfEpoBFQiw5eWb107JcjFac2WWHbA4VUGDsvZ4V2IUUe6GsiXGUshl/2tv2g0i5I7Rt7yCneG5ExD5JHK0yuajnVewGaC0t1hZ8oeYOsqchZBlGBycJ7y+/DHQvk5ZrpI3Bc688ewTAWNnH1JmPYDn3WU3qvQ+YvoLkMFR7IjJ5dlw8vQjdQ0HBKMs9+VsTpNFTeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epx9qLPRn3LrrQqKy8YpaZKhMdSeZpgaD87XJzMmL2w=;
 b=hPJNFT01NakGh4DfW59W48ZVRazybyDWpda7IxKwlnf0SrDACoA43l0kjjjfznxaRK16h1uBPV5KEyMwuXuHSEVQ+us9lw9evc7034lI82pRZWB4CNN2QFRsMWhzBTX6uoeE9R+5ItcxJNWcG8NDPoWSJZf2NztOUrLKPFA3J50=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS0PR12MB7680.namprd12.prod.outlook.com (2603:10b6:8:11c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Fri, 26 Jul
 2024 08:10:22 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 08:10:22 +0000
Message-ID: <53937771-00a9-435f-8daf-406f381d7a7e@amd.com>
Date: Fri, 26 Jul 2024 10:10:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: versal-net: Align node names with dt-schema
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Tom Rini <trini@konsulko.com>
References: <102d9499e9bab12f89dbf9ceaa49a11d685146b3.1721054306.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <102d9499e9bab12f89dbf9ceaa49a11d685146b3.1721054306.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P194CA0039.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::28) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS0PR12MB7680:EE_
X-MS-Office365-Filtering-Correlation-Id: 7de7a9e3-cb82-472c-6cd2-08dcad4a6599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ODA0c2NTbklWVDF2c2lzTHNUSytFalloM3pucnRmMmI5Tks1UWpyaEpQQVdy?=
 =?utf-8?B?ZUF5NXRYODdyaXRjWWdQbkxtTDFlWDhPR21GNmd4azhTaEVoMFFtYWVkWVNr?=
 =?utf-8?B?cEFGR3ZOd2d6ei9oT2FUOTdrQkpMdklCSlZsSllsOHZtZU1CamRKZXR1dlBr?=
 =?utf-8?B?RFlZTTh2ajZHMVk1ZnhnckExaXpKZkVaQk5LM3ZEcCtJMURaZ3ZCYUZ1OG9o?=
 =?utf-8?B?MG5HamkvUnNYc2xSU1B2Yy8xd2YvUEFmbHRBSFNVcmlCanZ5dVJVa0VwVzlh?=
 =?utf-8?B?aGE0dDhZN05sRGVsY2huVFI1ZHhSUTR0d3hEdmhmRWk0VnJ3eTE3ZzZodDVv?=
 =?utf-8?B?ZDdlcnZHeDc1bEwxK0xINmR0dWRFQmI3bW1BYnpHd0JRVWY1bXRWMGQrQU8z?=
 =?utf-8?B?eWJnVmFLZFIvVUV3aUhvdjhmVWd2eHJiY2psMmROR2dvemhqMEc1cDdGR2FU?=
 =?utf-8?B?T004ZmFqd2VZYkhSbW12TGhSc2pTL1A1VjVZbWlBTmN5YStqTzJncExtUTRv?=
 =?utf-8?B?RzEwbjNjWjFHU1dUcjFTRk42dlY3RzN4TDZ4dkZ0Kzk2cGpmcDYycGpsQ1Ez?=
 =?utf-8?B?ZTl2aCtEZ1R2cy96cEhiLy9TMVVYLy9tNkRDc0hyV2JwS2U2cGt4NDhFeThh?=
 =?utf-8?B?YWtqU1hZUkRjRmZpUmRTZ3BnR3FFQ0s2OEJLKzEwY0ptbDh3YnNWSTlJMnli?=
 =?utf-8?B?QWx0Mkdralc5YU1UV3JWd0RSNDllWmJVNTVHaHVjci9CWGpkZXVCSktNVnB6?=
 =?utf-8?B?VmU5OEdKcmtQVUVNUy8rVDlGa0IvZ0hhSUc4RGZVTEpwV0cxczNsMEc2d21G?=
 =?utf-8?B?QXpleG5sUGJUalFlSUNMNFRuSlVkdm9rV2ZhbVFyMVNBMXhPY29IMmJ2Qkhk?=
 =?utf-8?B?SzZIUDAvTDJKVU1hZ2RnK0dpSUdWUEJzSzJPUWlnL3hDQzFqMzM1UlUrVjJN?=
 =?utf-8?B?eFhKQnYxNnYvQ083R1JKZUZ2V3VacGJoNUpoWjNuV2ZaR2xFK2MvazRQdHV5?=
 =?utf-8?B?Y3FNamRkUUFndmdaMjlMLzNtSW9tWVdqRjVOekYwM01CRHNQbWRGS29TY01w?=
 =?utf-8?B?cW4yaWJXNkNTd0d4Z1hQMEI2QUs5ZFlpeHpjNlVPczZwTUFPK0YyVXh3L1VO?=
 =?utf-8?B?cE5PaDZKaXdLK0pCZzdhaVVmWktWZlVLZDhmcmhsRWZQdG5IOExWdUlWa2lV?=
 =?utf-8?B?Nlh5ekp6NlUya1hyYWthNWhNRndRRDNJMnRZeUowNDQzTzZTcGo3U1EwSGxC?=
 =?utf-8?B?bmkvNFdVa2FFcm9DelhCZzNWS1dIdGJJeG1wOHBsSTIwOFZJbEwvOUVuL0Fy?=
 =?utf-8?B?WEQ1UTVvZC8zR3M1SXpxdGU4d3N0czhaMjZwWGtSY1FweTNCa3lPeU9sSkJE?=
 =?utf-8?B?VS9Bb25pSFQyZUI5T2t5ZjNuc0h3MElhNmI5U2xMR2dNZE9MS1k3ZlBpbFRF?=
 =?utf-8?B?THlNQWR0cWswanA4VFZITUZ2SnArUWFtb2NqRTlmSS9rWVB4M2VpVmFiWndB?=
 =?utf-8?B?VkpTb2JmMEllWmxpZ3ZReUxmZ2V0cmNkY01Xb1I5QUpBZFBYcGlDM1RxSFFp?=
 =?utf-8?B?a0l0Zk10RXhoN1ZMRlJscTRLdEZvSkwzaTB6alBValhta3BLc0lnK2FVY3Rv?=
 =?utf-8?B?MjY5d0tnVmV0WCt5ZUQ0bUVEdEF2Ti9NZzVCODdHV2MrR3hUeCtsTndVV0VX?=
 =?utf-8?B?OFZCckc4Y0xPdHhEYVltQWdBZU9HYzZ5NWkxSjlBQjVUbmxIdEw2NldCRDBi?=
 =?utf-8?B?clFINFc2dnRaYWs3UWs4STljbUVTcmk0OElWL1FsTmdLMklHaUpEVzRmL0JH?=
 =?utf-8?B?WGFMaEFvd1FFTUFmTUN0QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1BYOG9hMkJtcXBGcHFpaWxvVDJFN2NlK1B2bmZRNkYrSEZYcmVRVzNGcFBU?=
 =?utf-8?B?Y2g5TFBaWE1ULzMrY0JsU3dzdTI4ZGdIb2RjdlZxRGpvYzJJMEZEVmh1OEp2?=
 =?utf-8?B?aDdhamRCdjBnb3pxM2R2VVh0KzQ1R3FXamhrSUk0d3NLWlFjc0sxUnVGWmVL?=
 =?utf-8?B?V2FQVy9NbmpIRzlVckZXUkgya09RQnhUdTJZNm83ekVFVXMvNmR3QmpNSTkr?=
 =?utf-8?B?TG4wYW5uV2FlempHeHU3azcxTE9NUVRlWldndEtGdWducnF6cGpyMFdxYk5H?=
 =?utf-8?B?cjFzdUQvOUFHRlc4cGFyT3VlQTJDTFlnQTN3Vjl1dmIvTUVhdEY2ZlVDV2gw?=
 =?utf-8?B?ekVTVkM3MDdWTjEwQUhGM0FCdGZIcFBqczN3ZzJ5Q0I4VDh5MnhWNE0rOUtP?=
 =?utf-8?B?MUJ1N2pqV0tUbmpmb3B4S21oQXRkZFZpdkZGcXpkVjlVK3FrYXpIcWJ0cXFn?=
 =?utf-8?B?a1AzR1RaZzMydEtYSHpaUm15MS9yZVNuTlJXZklwaldEMnBJckVlMVl1RzNL?=
 =?utf-8?B?bmd5L3Y3VVFHZ3pVbG1hNU1GSUNrOWtoYXpsQldUU25DT3dZMHorU2lvVVJQ?=
 =?utf-8?B?UDlDcEw4elN5eHZqYWZmM2FjbDEybUxTUUI0RHR0NEdBRFBhbU5TbW9DdGZM?=
 =?utf-8?B?d1BuQVdpQnJtdlZKZndDYVhRa0E1R05rbjBHL3FtL2tjSU9Tak9ZL2htRWo3?=
 =?utf-8?B?VDVaQ3dzOEhwcHRUTXRhcW5lQXdYOWViU2RseWlWYUwwU2V4ZE1vSlQ3dFlV?=
 =?utf-8?B?K1lZNHM2MWNyRDhVSmd5K3FJQVgyeXpUN1pyRTVSdkVxQzBuUW5GcUY5d2hW?=
 =?utf-8?B?S29SbzEyZUFXSzZ0N1BwVTlWV1k3a0grUHNhVWFrZnJjOGZ4bXZ6OGUwaGx2?=
 =?utf-8?B?TkloanhVbEcwWHFRcXJoTlkrY1VIQk9tNlBTbVYxcUNMcmdSbDVDZ1V6SnZR?=
 =?utf-8?B?dUJzM3hTWmxzMWtVOEg4Vk5GMlMrbUlIdXNVbEQvTjYyWFcwV09YWmxzN2R6?=
 =?utf-8?B?WHdwR1RBazJ0ODg0alJWV21RZVpOZFdJNnpEai9RQ3RPdmtOUXl4RXkxY2Ja?=
 =?utf-8?B?YnJreTVzWGRucmtqdnB2aDFKWXhNS3hiL3c3M1dRaEJzT08vUUU4Mm1GVGkv?=
 =?utf-8?B?aHNLdytCM01XRVpmeFBvMzlML0dWdlNIMTd0UnRMdHJMY2Vaa2N1NGx6QXRP?=
 =?utf-8?B?RTJaUlZpemkrRFZyZ3VlREdiOVdGMC9yQUkyVDZsOXA4TGJQSlhESTY3Z0lH?=
 =?utf-8?B?YVBTRHB4ZWVPamcxbGRsaVB5VjNaajFhOGpUNjVrRGVjV3RRV3I0WTZvRlVL?=
 =?utf-8?B?ZUhyMzIrSkVLWFV5N0Jkdm42cmJwei9aVTY0OFB3M1FYb0RFRmUwOXBIdHR4?=
 =?utf-8?B?TVg0eG5zV0xockk1cFdFT1VKazk4ZGpjNDBWOUtOVnpNaFZRM2RDc1RiUEZB?=
 =?utf-8?B?RjVvVUp3K05DS0wzREZpN1hYeUxHMjNJWmM3cTBSV3pTVEZjRlpSTjdDT2Yr?=
 =?utf-8?B?eVdLcTFYS0UxajBGVEF3TzFUeTE5SWpnNE1rb1htVmxGQ2FyazVheWZmZEw3?=
 =?utf-8?B?QnkrdWFLaTN3aU5vVnVHamRJaVloN2EvRFI2bk9iNmRVSG9ESEZrMS9hSVZq?=
 =?utf-8?B?dGpVekt4dzh0TkhNSElZNmFJc2NyWjZGQ2RUKzhrS3JvbWJvcWk4M0xUQWd4?=
 =?utf-8?B?RGFKcU9OVmQrUy9yUS9YbDl2WTlEWVN0dUh6d2hUQXF6Wmw0UFRxVDhzZi9B?=
 =?utf-8?B?UEJnaks1MHVtTHFXM056OVlZWjJNTWloa3dUVjJydEhZNllia0R5bkVoMTUv?=
 =?utf-8?B?YS9oY0JacnhPTEFOUmdJdW12Y2g1NlZXelhMeU9uTUlwT0hBR21JVmRRYU1G?=
 =?utf-8?B?bVZJbXcwamsxNnAyazFENWNjUmk0K3c4RUJ5MFo1UnhETUtkbXZtd3N0NDEw?=
 =?utf-8?B?YncrV0gxSUxHeEdjcEt2QWFCR1hONnQ0YXgySENIVzFLM2U1L29KUnhHSmRI?=
 =?utf-8?B?aFF4N0NGanNObmVlKy9YT0xuanZhV0ZBTE5uSGtoY1ZmWW5WOHRNZ0pOZmZX?=
 =?utf-8?B?dCtBZTdNcWhtRnVUQ0piMHFjUXcrcDNNY1NDR0pqZUdRNE4rM1N1NC9DaDBy?=
 =?utf-8?Q?a+8JCk8ounECuvaWaVk+hEJGz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de7a9e3-cb82-472c-6cd2-08dcad4a6599
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 08:10:22.5768 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQxaDeoSSKBB1WtFDqllfCqZ+0IobPdlzHWILAnI4YBqYSPIMPuvudymjSXyq79G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7680
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



On 7/15/24 16:38, Michal Simek wrote:
> dt-schema is forcing some rules for node names that's why align them with
> it. Labels are not changing that's why this change is not breaking any
> other board specific DTSes.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/versal-net-mini-emmc.dts  | 4 ++--
>   arch/arm/dts/versal-net-mini-ospi.dtsi | 2 +-
>   arch/arm/dts/versal-net-mini-qspi.dtsi | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/dts/versal-net-mini-emmc.dts b/arch/arm/dts/versal-net-mini-emmc.dts
> index 8a864ba3ed3f..e200fb694c6b 100644
> --- a/arch/arm/dts/versal-net-mini-emmc.dts
> +++ b/arch/arm/dts/versal-net-mini-emmc.dts
> @@ -42,14 +42,14 @@
>   		bootph-all;
>   	};
>   
> -	amba: amba {
> +	amba: axi {
>   		bootph-all;
>   		compatible = "simple-bus";
>   		#address-cells = <2>;
>   		#size-cells = <2>;
>   		ranges;
>   
> -		sdhci1: sdhci@f1050000 {
> +		sdhci1: mmc@f1050000 {
>   			compatible = "xlnx,versal-net-emmc";
>   			status = "okay";
>   			non-removable;
> diff --git a/arch/arm/dts/versal-net-mini-ospi.dtsi b/arch/arm/dts/versal-net-mini-ospi.dtsi
> index 5d188db62d92..d511b823754b 100644
> --- a/arch/arm/dts/versal-net-mini-ospi.dtsi
> +++ b/arch/arm/dts/versal-net-mini-ospi.dtsi
> @@ -42,7 +42,7 @@
>   		bootph-all;
>   	};
>   
> -	amba: amba {
> +	amba: axi {
>   		bootph-all;
>   		compatible = "simple-bus";
>   		#address-cells = <0x2>;
> diff --git a/arch/arm/dts/versal-net-mini-qspi.dtsi b/arch/arm/dts/versal-net-mini-qspi.dtsi
> index 097b58c633b8..e29a3f36d6e4 100644
> --- a/arch/arm/dts/versal-net-mini-qspi.dtsi
> +++ b/arch/arm/dts/versal-net-mini-qspi.dtsi
> @@ -42,7 +42,7 @@
>   		bootph-all;
>   	};
>   
> -	amba: amba {
> +	amba: axi {
>   		bootph-all;
>   		compatible = "simple-bus";
>   		#address-cells = <2>;

Applied.
M
