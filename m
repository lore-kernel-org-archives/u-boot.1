Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF10BCCF9EB
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 16:34:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71C3283849;
	Mon, 27 Oct 2025 17:34:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="A6dvAMZS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55A7D83849; Mon, 27 Oct 2025 17:34:09 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9F0B8384E
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 17:34:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=23951467bf=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59RG1Nm12188848; Mon, 27 Oct 2025 17:34:00 +0100
Received: from pa4pr04cu001.outbound.protection.outlook.com
 (mail-francecentralazon11013027.outbound.protection.outlook.com
 [40.107.162.27])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4a22awaswp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 27 Oct 2025 17:34:00 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLeiEelmybOpZ5i/QRVweMXP2e3MID4o7BUSxTA+fy0fBIAq9iolbgKyh9cGcMZpHV5mNaDLSCZs6fCJyX8vOd5cqGl1SDkI4l/0Lh1Q7iPDxjCXUqyRJMCfEx8P0BkX3J0ioC5idgvgHK6oAFTZ4kRV6yaFivFznFaIV+hkUE6S8+lU3CuwggeGL1jSBL6OywGP7PJSAQ7FZW8tz12qAC87j7mwlEV6O+s/HFn+IjN7jjCo+mGGaNrUmvG8+i0p/AL+t8Fk+XttgNlQU6d5RCYnLy02J+tYwKXdOE5qboD/nLR9DDETLRotRnbcBrFyqD7cRng5OxQUZmS2xCyjZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHTX+GGZMXU9JGJsJtE0K1fwN1M+fhr6tMi37EcNuUA=;
 b=u+YM0te2G+gYLlXyXMWAEv61kRPA5xYz2v7TQ//ml5aHeNWlemmWG5g+6Y8q31203GmtzFTbZhf5fzwQzGHJyJxLw+8chIuI0rhYuJ7kGxhbyd6juiIS+TVRN3M3Gu7tgQh5Wtl0fhVx/AP/lQg7hejpwXzlOFJLG3d8OoqAWa3sfXOGGTVteUoKJWJ+kZm58lLEmGlaP+x1ThSgXNfQOM/YYgYffpeLAqwuTvm8RMkd5qoc6XaBkXkojHCKD2Q2oboe92t2HtJXymYyxa7c9T4aJ1NJeC1w1gCt6HPEIr+Q24OUU9cgvtSuzuHZ0SsfyAYGQJzEpY8C4hFFMZlHSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.44) smtp.rcpttodomain=eds-india.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHTX+GGZMXU9JGJsJtE0K1fwN1M+fhr6tMi37EcNuUA=;
 b=A6dvAMZS4ixx7yDqiBJVgZss5IrrSj+eUCoIgmPMCCB793kowLJw9XnscJ0x1Sy9Fo1wY2c/BXZN0h/44S05XIaqhx+E6BDjswdKvZu62daAetpUNrpmmNNIVgaXIy/bxS+OCGZQf/jTqEgEkEW7qjo5t+T8CqoIDuGhxMhTjMP/8fr1USP+JypuO883KUVkMgKT99h5JoUH2LLoW7OsL5aJC/2Qx6ZgM4pE+uOsTd+IrFsVrPUgfzaroxJlHduyRrfRKKkb6l0QlxXTfGI3x/0cNu+VeLbLqCNc9zLpHq4yQebK8YsCUSzSeUE1baCkPAbaf732CSnM6O6obSWZ9Q==
Received: from AS4P190CA0004.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5de::10)
 by PAXPR10MB5436.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:275::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 16:33:55 +0000
Received: from AMS0EPF000001A1.eurprd05.prod.outlook.com
 (2603:10a6:20b:5de:cafe::98) by AS4P190CA0004.outlook.office365.com
 (2603:10a6:20b:5de::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Mon,
 27 Oct 2025 16:33:58 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.44)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.44 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.44; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.44) by
 AMS0EPF000001A1.mail.protection.outlook.com (10.167.16.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 16:33:55 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Mon, 27 Oct
 2025 17:26:27 +0100
Received: from [10.48.87.93] (10.48.87.93) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Mon, 27 Oct
 2025 17:33:54 +0100
Message-ID: <6cd2b44b-d758-4eed-b8de-2fc30f6c3c95@foss.st.com>
Date: Mon, 27 Oct 2025 17:33:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: stm32mp25: add ethernet support for stm32mp255 series
To: Asadeds <md.asadullah@eds-india.com>, <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <linux-stm32@st-md-mailman.stormreply.com>
References: <20251008063623.1233604-1-md.asadullah@eds-india.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20251008063623.1233604-1-md.asadullah@eds-india.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A1:EE_|PAXPR10MB5436:EE_
X-MS-Office365-Filtering-Correlation-Id: 069be8cc-d586-4c26-1a6b-08de15769f35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VHNiZkZMOVFZZ0hSVFZWbTJhSDF4ZFhwWTdyV09XSi9aaExQYkNlTVppMEF4?=
 =?utf-8?B?VVRhcHJXa2x5T3kvcXZaeTBuZW9HT0ZtUDdjV0VRdGNxSzlyVko4Wnc1UStw?=
 =?utf-8?B?ZG5iaUVndzRTN3VPcFJsUWlyQko4NElHQ1VMbHpKME4yNEMvNGJYNVByMFFF?=
 =?utf-8?B?K0x1MVZ1SmUybzkzKzF2S1dYYlQrVnJDVzV5b2pZUHFzWTdjZnA2c0VteTNt?=
 =?utf-8?B?OHBYdjVwVy84L3JwYkg3eWFxMThvZUNtSm81REtFOERJU3lNdFNmeGRWYlh2?=
 =?utf-8?B?QytnYS9ROEozWFA3T1QvaTd0aXh0NGtYWlRyaDUya01kSjJPSFhpMWphNVUy?=
 =?utf-8?B?d1dseGNiSU05VFk0aERzWGJWVEVXd0xYdGpvTXdwaVUxeWdPY0VWSE4yMDQr?=
 =?utf-8?B?TGxHUk54REJFd1VLT3dlK2lMSFhUckg4WlRuMTNqNEc1N3Z4eldyZjBsOEY0?=
 =?utf-8?B?b1lna3hydnZIVjVDc2lzQ0o2ekZxMXQzUm84VmkxZVVRVkZvOHYxYXVMSTkr?=
 =?utf-8?B?b21SUmRXZ1NIU1Z3Szdqa2xUSllaOTlFY3U1R2tUdTU0TlphVnoreWdSUVQr?=
 =?utf-8?B?RkJYeGJuaU14OG1BRDRiUWNPcFl1SWFGWGkvZThXbFNyV2dYM1BvRTBPUXRT?=
 =?utf-8?B?NFBNZGgwdjI3TVorSHEwM1ZGcVl0MDRDY2dNejVFQzBQMitNRElTSDRmVTI4?=
 =?utf-8?B?UlRCTGlod2pyeHE4UTAwakRIVURVempWbEZ0NWw4akxhZk01b0szbnRDT2Fw?=
 =?utf-8?B?Q2ZzSFA0dnZ2REcwcmk3VUxpMTRLbVRxbkJOVHV4VGZUS1dFV3F1Yk5yazIy?=
 =?utf-8?B?aVJqNHpQbklyK0Z0UjJ4Z085Tlp6czlpTXdQMEtUUGplL2VmMlNiSGdNN2Vt?=
 =?utf-8?B?NEtvbDFzNG1kTE1TcCtaMkV3ZmtROVU2RE1pclUyNzE0a0NrRnpnc3BzUHRX?=
 =?utf-8?B?RzhoRzhqSzRhTk1QdjJ2UVZHcEdMaSthUzlMSmEvaWZKSnFqSGpWM3p4Rldx?=
 =?utf-8?B?bGxHSUp0R0pqZjNYeVBoUzA0UE96b0xRQUIwRFJ4NU9KTFUxbVdYdHRUbTNG?=
 =?utf-8?B?WGttdXdlRXBTcHp2S2R1c0xoZlBHT0owdFQvS1BGRDRKd042SlBxc24vL3pQ?=
 =?utf-8?B?Nm5FdXltVFBDNmdrZ1B0aWlMMU94Tm50cThoU1FvVzMzM1pRQ3NSM2FxeFE3?=
 =?utf-8?B?NzM0d3d5Y1BUT3FYY3ZVb1kxOWNsaVJnZ0VGeHcvR3M3dkxxYklpLytJVktj?=
 =?utf-8?B?SXZTcHZMS3RwTm42NDZOYWNzSFFncllzUTN1TmVLK1R3RWlCeEVJTTNmZkFn?=
 =?utf-8?B?aFZoUGw3ME9xRDI4dXVucTFYUWJGZnhvVVMyWWEwQmxoeHJrVi9va1VIaEhs?=
 =?utf-8?B?ZW9BVUh1RS9vdTNJbE1SRlYrMXEvODEyQmdnaHlWYkpsNG5EV2FNakNSUHVF?=
 =?utf-8?B?N25jQ081dXg2cU1veXgwZHRUbDhjQUNzYVZZNEZ6ZzNRbzgzNTlvSTlINmlS?=
 =?utf-8?B?bXNUYVJOUERsSmp1d0x3NERNOGpPR0RXbkMyZjV5d2trZlluYXA1OVFiUkMv?=
 =?utf-8?B?eWp2UjhxVWJtRDFFSTd3M25FRmFsV2tvUDduZy81LzgyNCtualpXd0tvL3VQ?=
 =?utf-8?B?WkF0TEM0NXh1WEx1aGRVa3U5NlJZbHhtZUt3YlF1UzZnaStaeStXQ2NsQUFL?=
 =?utf-8?B?bklvMmpQYlJiM2RPb3RjK252dGRmWlNzQVhOYTgvY3pndm52alFEQktmbjRj?=
 =?utf-8?B?dnpFb3lqWFpXOHE0aXFXeXZmSjNXdzVCZSthK08yWERnamN3V28zaU5HNkw3?=
 =?utf-8?B?YXFCdGdKOFRFSUdSaVovZmR6QitubXZFcDJSRnBUWEZSWGxwRkFJWFdsSGQ0?=
 =?utf-8?B?bUJMRFgrcjB2Z1ltcURiZHVQcFRJWmZmeGdvL09tRDVWTjh3MmkwbUhWMWM3?=
 =?utf-8?B?UkRZN1UvK1JnZnU0aHlhSmNNaGhsUy9ZR1RqamZvNkwvV0s4NXNqb2ZaMlB1?=
 =?utf-8?B?ZzFqcExpeTc4SGIvei9BYngrS1ZXNElPZFYzN1hyMkVoeUhaZ0huZzlDREpz?=
 =?utf-8?B?eURUcm11d1hDMGNmaUR3MTVNejRVTFJHZEZFNHRIcmFVUDQvaGN0NzRBMkJw?=
 =?utf-8?Q?ltv4=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.44; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 16:33:55.3402 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 069be8cc-d586-4c26-1a6b-08de15769f35
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.44];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A1.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5436
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDE1MyBTYWx0ZWRfXz7CQrWopKeVY
 RTLcxzfKBXCqRWmYoOz12dnGNjGrre7GkaVc3dxUEmU228EjaDprPjda3P6+jnYTI8sU69w/oBk
 jYBu00bXNncmOjcQNvhArc4CFYIqPzzGyOl+PUh8/KwKHlNBILpu//du3mq+gR70kxrrEn58uBZ
 G3IT/CTMHW4wngyiC0VgmmnMKLUxkstMrtDXZyYeERKCTB6iDVJ+FgVi1djuGstxYJ5GfmMD2LZ
 Ua1eYOf69o5ekFhtmR45soub1k13h/MAG3tkrnxvCs6bJTxDQLHaBZdBEuYkrZEdrWwTScBWxNW
 SPXDdrST0OndVBksSlY5XovMTp4bCOGGC/9Oyo108jqTO5sGPTqRXUrOACUnsH5SS4eBmyB1Mim
 d0TZfsrfXf3R2Pto35eI3H31IuiqHw==
X-Authority-Analysis: v=2.4 cv=T/KBjvKQ c=1 sm=1 tr=0 ts=68ff9ef8 cx=c_pps
 a=cnuazBrkUzhFqb89caq3hQ==:117 a=Tm9wYGWyy1fMlzdxM1lUeQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=2w8NBIiDAAAA:8 a=xOfxabL-oR3heyWxoh4A:9
 a=QEXdDO2ut3YA:10 a=FR9XvEe225z0xfbndyrf:22 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-ORIG-GUID: R0L-Q1vjP2gGDMrS6TPBAenayX6fmA9Y
X-Proofpoint-GUID: R0L-Q1vjP2gGDMrS6TPBAenayX6fmA9Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 impostorscore=0 clxscore=1011 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270153
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

On 10/8/25 08:36, Asadeds wrote:
> Add missing CPU_STM32MP255* cases in get_eth_nb() so that U-Boot
> correctly reports 2 Ethernet interfaces on stm32mp255 devices.
> This fixes the "ethernet not found" error during boot.
> 
> Signed-off-by: Md Asadullah <md.asadullah@eds-india.com>
> ---
>  arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c b/arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c
> index 0d199f6f903..48b452f01b1 100644
> --- a/arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c
> +++ b/arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c
> @@ -78,6 +78,16 @@ int get_eth_nb(void)
>  	case CPU_STM32MP257Axx:
>  		nb_eth = 5; /* dual ETH with TSN support */
>  		break;
> +	case CPU_STM32MP255Dxx:
> +		fallthrough;
> +	case CPU_STM32MP255Axx:
> +		fallthrough;
> +	case CPU_STM32MP255Cxx:
> +		fallthrough;
> +	case CPU_STM32MP255Fxx:

Hi 

Can you sort above cases by alphabetical order ?

> +		fallthrough;
> +		nb_eth = 2;
> +		break;

As STM32MP253 and STM32MP255 has same number of ethernet, remove the 2 above lines.

>  	case CPU_STM32MP253Fxx:
>  		fallthrough;
>  	case CPU_STM32MP253Dxx:

Thanks
Patrice

