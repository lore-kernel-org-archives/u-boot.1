Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B45E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 12:30:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60C688021A;
	Fri, 20 Dec 2024 13:30:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zmnc3D6N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A8E480243; Fri, 20 Dec 2024 13:30:06 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::61b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E82F780087
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 13:30:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nijKxL945fz+l5pED53lKPO8eF8oMtok0AheaFMfSRYthPI3U6BBfUnMf9ugtP1V/rr+ltMX0+XryyjcplVi2zYiOQruKio47OHuQy5VMzODk4xMXN3y2XCBUEyJHbFUyYJlFzPfH/VAxlEBSJJd+WCSNggGzBhJgpxsJYwrLHL2go8XOejP4eZgEIRrp1gsm/15Rig7+i6pyLE8p/2cW2LZB7rc3eDlwXymkniPrfJURuTQAOUX5WUX6wjNAubhR1BEkQQbia2eU2zEOVpqaVDeUF136Zd+b9waQieWgLeLRXfe5SfxOysGXHNOqrE4UKYEi69hAtknrw7yEBOV8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEmrO6F4YEhWmRV0jy9TIgOwgBUewiRDarKMKvbyX0k=;
 b=SidJbhORvei7uVnaSZxjl7ihw9ATUlIp9XuR8OnJwbRhe4kwXs+psZWtLzi7Px91lqhHhpyKa2omLSGk5ZM7bo6XYhEQ0gtEBe3eORoNFFa2ZEDNiHVn0YT1aM5poG/iD5ilWU4VECKqfzOObXeQTFp6YswzhVW70tb2HPj2RQNFYQXBjpZFNC5wGUZAFNLQEl0/AKd4A0kIXhzDVFABHqzgLB4Vwfz9MND8XEf+LF6hBguV8otrSSCvfImtHK/XDFMeP98fK/ApeTAIO4X3ct/Sll8OU/DW8TWrHnWwkVwjvSDXaJGqpsRRn+yKx8BvenPK36JzJkDe7kThLbcaqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEmrO6F4YEhWmRV0jy9TIgOwgBUewiRDarKMKvbyX0k=;
 b=Zmnc3D6NaVV8dQXzYksR4xu0PTVoQrO2si/twecoCjo5ghjFauxDh7UcsCHNfRAXJhAn47X022vXABuv/P92bhOC3dm31+MzQ8WLbqnV/UrP6kOogfTtGod8jORe4q3hCs/VXCGUrcUXRmlZNlvMPewCLrGnYGqEZu9V9R6f/Ps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by LV8PR12MB9083.namprd12.prod.outlook.com (2603:10b6:408:18c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.17; Fri, 20 Dec
 2024 12:29:54 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 12:29:54 +0000
Message-ID: <3b7ac676-09ab-461f-8cbf-c3d78171934a@amd.com>
Date: Fri, 20 Dec 2024 13:29:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] common: memtop: Fix the return type for find_ram_top
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: sughosh.ganu@linaro.org, git@amd.com
References: <20241220030742.1745984-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20241220030742.1745984-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0502CA0033.eurprd05.prod.outlook.com
 (2603:10a6:803:1::46) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|LV8PR12MB9083:EE_
X-MS-Office365-Filtering-Correlation-Id: 62e5f24d-376b-4284-210e-08dd20f201f7
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M2VkcjVzYkVBUWRVUEJXL3NjWkRSb3BIK0VJRmpPNVNYakJCcFBlM0FtVTQ2?=
 =?utf-8?B?d2FCOTdNZ2JEQ3hxVFFsalZFc1B3RTVvdVkweTVzdlpnL0lpSWF4RDMrdHhR?=
 =?utf-8?B?L0hsTzlhWGNId0gxRzZRMncvT2Vad1J6RkVQOG9YNlplSUFKY2MzK0pQY2wz?=
 =?utf-8?B?dTNTdk5yWTc5Qzl6bjF6ajl5NlFISTBuaW9GUkxtSVVjWUdFZVNYbUtnRDVB?=
 =?utf-8?B?cit1aHRQa1FCSXZBTE50MGM1VmJqQml1Yi9tdDNVWkpEcFFDZUZrVXVOb0tp?=
 =?utf-8?B?MXRSWGlMT3dDaGgyV3FnbktTelBmNU5jRExZR1VPbUFob0lIQVpwWlpteDJm?=
 =?utf-8?B?aHE4Ni9RVlBkR3oxUFZ3aVd6ak5Mb2xhOVFyNEJqVjF4VVFrSzZ4L3BkeW54?=
 =?utf-8?B?cmZka1k5QzlMSkRFVkJpb3hnQ2d3RDhrbHd0LzJSVk9jNTZONVpHeWZLdzFF?=
 =?utf-8?B?OTRrdDdRNHVFcEdqdFM2L2dGTW1QN2RMNUxvZktkQXVaenNSaVdXRkI5eUxT?=
 =?utf-8?B?eWJRNFRpZ2JmcXY5SVZpVWMrQUx2eThjUHQ1Q1ZsZ25VOGE0c2xTaDAvTVI4?=
 =?utf-8?B?bHFNMTdScXNOYnE5RVMvQU1qZCt5Q0lFcFFOL08rMVByeHRCTXNFWnJjNGJ0?=
 =?utf-8?B?eFpMNW8yM2dya3V2ZzlvU3RFN011bXlTNEFjL295UzlHMjhESG55d3cyRzBT?=
 =?utf-8?B?U3JwcFIrRXdFYjdxc2NIWnNldUdDekNjUGRueGI0VTdjdXZlcnliak1VaDBC?=
 =?utf-8?B?cmhqY2hLVWJ2bjhFN3g5cmpFVnh1cUJmaE93clBGZkZOZHkwcVlEcHU1QnVn?=
 =?utf-8?B?VlhtVjExV1lseGxrdmRyWFJoNFpzYlFOaVlkV2FhOFFueDJqSU45TGdYelkz?=
 =?utf-8?B?a09GV3BUaW5qdWsyQ3Z0ZHBLTi9mQWQrZU8wZFpaQ0R1WlpKUkFqeDZOSERJ?=
 =?utf-8?B?blNBRGZVYitSMlpKakU3empyR3VrL0RFUXZkK1VnbjhFd0VoV0w2dUdZSnhV?=
 =?utf-8?B?OTRib2x4SlpnVEFObkxXSE9VQVVZVGtsRHRQdFRMU0xWUUVOWk4vcDN2cFJy?=
 =?utf-8?B?WTA1VzB3ZHlhMWd0THVXbElKRk5vWDUvdWovclZFdGdNWVBXei93WTZiUTFS?=
 =?utf-8?B?bFVNbW9DUXBneVMxVnVjMU9TcE1nY1VrZ3NrSlVybzNCUElXbFpaSTV6blIy?=
 =?utf-8?B?QldvMnVNU25yU2RUNHRiOUdna3hwYTFIRi9ZR1hPQnRDc01rT1ZxZzd4U2RP?=
 =?utf-8?B?UmlYTHU2ZmFGczRUdXg4dG9XeSs5TklkdE5sVEYwVGhpTGhBWkE3dUFWVUxt?=
 =?utf-8?B?YjUwUDlrNE5SODgvcXE2UEZKQzQ0SEUwV2tNUjJJV1lLa1JTSWREMlhlWjk1?=
 =?utf-8?B?ZSs1eVNiZWx0YjUyM3ZnbnZua3BnUnNUUUFzTHFhTlVSL0ZZaEhLZVJNNzJB?=
 =?utf-8?B?RmZsV3BXcHhaMnczQkRYLys2NHdBbGo2M0x5c2wyRjk5YVc4WG1LYTZKYTYv?=
 =?utf-8?B?SUx2MmE2ektFQVplaUZjMXVnSFpqM1VWOEJaRHQ2SFExVzBxbng4emRkRE5n?=
 =?utf-8?B?Tm1pMnlNZ0tlU0tobUtqS3M0RUhUS2J4NTg2RUxTTFIxZ0d2eFVOQ3Ava1FR?=
 =?utf-8?B?eXJvYnV5NzFNT3ZvWVJ6ekZNSW9hclcrVVVTUHBnK0NWYXpkVCs5VGxHWjhs?=
 =?utf-8?B?dWcwenh0Nlc0Tmh2dCtWbm1DM2ZoTERpc2FtU3RQYitJa2VCVE05bWEwbzFs?=
 =?utf-8?B?YzNROXFZaEU2ZXVlZnhCVG1XM0NlWWJCM3E4Z1RtTDMzYkdvalNIeHltMU1D?=
 =?utf-8?B?MjNkcXZ2bmhxNG1Sb0dBbG1LZXNLWCtJZnpBVFRLNWVUSzJJSzhkZjEwdHJX?=
 =?utf-8?Q?h/xHVKvX1vAsi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dThaWjNiU29NN1FEQTdDY2l4dFFLUERZMmpndFUxckVERFVKQ1Vqem5SSWRO?=
 =?utf-8?B?dHVUcmNyREdLOHhqUlZkdnhGa3BvUHZsVGlFYzdjQ0JWNG41T3U0L0NuRjVs?=
 =?utf-8?B?YXFoTk5NbjhIcDQ0SXlNZnU3Yko1WmlDNVArSEw3RmNlelp2SG1RdU00aEVz?=
 =?utf-8?B?amc3L3ZUVW9JT0czRzNyMjJqOHhFSmtTYzlNcHVScVY0bXJJdWVMZ3BkYzYy?=
 =?utf-8?B?bHNld3hNcS9NcmNtZ3NUSzZZb0pLQzlOMlI4Y2Y4VUlia2tWZmoveERrL0pH?=
 =?utf-8?B?dmlxZ1JsNVFxS0RnT1B0SGR6NnQzcG1SMVltVlNEV203aVg2UnlzSkFJMld0?=
 =?utf-8?B?SHExQjllUUJGSzlPeHp3QmZDbnNSMmZxb2QyMEtEeVhuellrbkdiZzlaRXdN?=
 =?utf-8?B?Z2x2eEJmZmV0cnBMOXNVUHgzMVJHb1ZHS2dQaXlVWDJkUm9vMnNmL3VkNG9p?=
 =?utf-8?B?UDNnNGJUNVFXY0hkNzZkZEJscXdVd25SVzJKbEQxSldJSXVMZzd0NjlUWDJw?=
 =?utf-8?B?bWp3Y0FEbmplY0l4UC95MXhBQWh1VngvSkN6ZWdaWkFtUnE1V3dnaXkrZWxJ?=
 =?utf-8?B?OCtRcUZmczV2ZWZNZGlwMk1iU3lLc3pyd2JFQUJ5M0FaRmhmL3JJNW1RRGU3?=
 =?utf-8?B?NkNOd2IrZ0luV1BFcWMvbHJLMXd5WUVFNkpsRDRiMnlKVlBmeSt5VzVQU1lX?=
 =?utf-8?B?a3VsWnFUeVZGWkYwWmxEendzTFBTQ2g5bHkxbGd1Q1NXV1hmbHZIdmthbmRo?=
 =?utf-8?B?K0ZIWFh0UWhNQUh5d21EaS80OGhGVHc3b2hPa3BCUDlJK2FoNmJhMHJSbmFi?=
 =?utf-8?B?aXh6QWNXVWRsZmUzaHgvREZjd2pPcnlxWE1JOGJkWmNkNnF4WkVMUlJ3VzZF?=
 =?utf-8?B?WExyWGdMQ3g5dU50bW1DS2NOTHcxc3VseENaa0l4YVNFTmxrMjZhbDcxV1Rw?=
 =?utf-8?B?SzhXUEZiYnowNWo4SHYrd2p2aGFWTHhVTEY1eE1URWlRMk8rWTFGTEdNYXk2?=
 =?utf-8?B?QU9zb1MrdW5KUmNpZWZuNFMvY0lNQ0g5U0ZEWWVhK1Yvb2ZLOU9Hc3NxS3Jw?=
 =?utf-8?B?KzR5ZTBpZHNWMjlkSUluUzVaZUpEaUpWRTN6a1haRCt5cFh5V1lsVEl6QnJS?=
 =?utf-8?B?RThuYWcxRnFHSWtvaTgwZ3pBbWE4WlZka1BVay93ZXZnbkZVNjRBOXBRaTlV?=
 =?utf-8?B?RmNVOVZDQ1l6K3Q1N2RLb0crOXUxWURWQ212SXpoakxvQUV5OHpMMWc3eW5r?=
 =?utf-8?B?TkQ0QVFDM3VIOTArNkE1clJSeHNVQnUrdlAxdmtudnR6dWJjVVZMeHliS09P?=
 =?utf-8?B?WlNwQ3FQOUdWS01rWnlYeXU3Yy9BclR2ZEd6NHRuTjJyM2hMeGxkTXdJdXdD?=
 =?utf-8?B?Umh4dFE3SnVabERoZURaVitjWEREUXNON2lvRExRZ3A5Tk5VSi95YVdYUTUy?=
 =?utf-8?B?SFovYlVhWjc5bVZpc1p2SlZFbzFBT0N0QllHR3V5TlhrcXhIR1k4Ti93TGtW?=
 =?utf-8?B?dk81Yi9WbWVaR1J5T2VUdHJhcWFSS1JKSDY3c3pVWGdOaG83NzJ0b2dtVnIv?=
 =?utf-8?B?WjJITnZjRmhPV2hxTjJlNFlhRGw3Um5HL2RCZ3l2dGVlQm9IcWtjWklncGx5?=
 =?utf-8?B?eXF2M29sNnFPTjQvZTNGWk80WEdna2NFUTZBUFJvOG02MlB3blRFT3locito?=
 =?utf-8?B?VWgyZ0pvQmhFZWtwQjJodG9ZYWxzMzZ5NVcwUm83T084RDJyb0NGMENxQXE3?=
 =?utf-8?B?UnRuMDVLMnY3WFBEU0Jwc1N3OFVCWS90dyt2bnFtTzJwU05VMkNzdk9UbXhZ?=
 =?utf-8?B?ZkJ4TkRhR0MxeXZLVlR4R05uMHBrYUhYZHdPRVJWYndRR1RGc3d4aEhPN1U5?=
 =?utf-8?B?MGpoODlHeTFkb29rN3EveUs5cmo1VS9aZkR6RXl4VmRqdlpWSHN0bXFnQnVV?=
 =?utf-8?B?YU9iaGdGT044QVR5cHMvMHltbTQ3aks1c1A0YUVCd2NMdXVpUnZKUTdxNG5T?=
 =?utf-8?B?eXIrdTdKbW9xUjRvM2V6cGNVMnp4SlJPdUVpbm0vTmZ5TmNoeXNKVU9pNWhs?=
 =?utf-8?B?dGpkdGJJbEF1b0VMekRYUnlXenk0MHBBeWh5NGppaVFlUUt6Zks2RTNCYjRN?=
 =?utf-8?Q?rpkVpqm/nElpwLzYAwE5SSYxQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e5f24d-376b-4284-210e-08dd20f201f7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 12:29:54.5976 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FdzeQeTIPUMvveBZpbCzkwZ1ppdwxp5govxbwMuImOjRFgl8ff15XWwj5An+UXxE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9083
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



On 12/20/24 04:07, Venkatesh Yadav Abbarapu wrote:
> As the return type is "int" for find_ram_top() function and
> returning the "base" which is of phys_addr_t is breaking when the
> "base" address is 64-bit. So fix this by updating the return type as
> phys_addr_t.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Reviewed-by: Michal Simek <michal.simek@amd.com>
> ---
> Changes in v2:
> - Fixed the check patch warning.
> ---
>   common/memtop.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/common/memtop.c b/common/memtop.c
> index 841d89e0799..bff27d8211e 100644
> --- a/common/memtop.c
> +++ b/common/memtop.c
> @@ -121,8 +121,8 @@ static long region_overlap_check(struct mem_region *mem_rgn, phys_addr_t base,
>   	return (i < mem_rgn->count) ? i : -1;
>   }
>   
> -static int find_ram_top(struct mem_region *free_mem,
> -			struct mem_region *reserved_mem, phys_size_t size)
> +static phys_addr_t find_ram_top(struct mem_region *free_mem,
> +				struct mem_region *reserved_mem, phys_size_t size)
>   {
>   	long i, rgn;
>   	phys_addr_t base = 0;

Applied.
M
