Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB46CCA100F
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 14:54:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DFA682CF4;
	Mon, 22 Sep 2025 16:54:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="lTklU+91";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 845A2833ED; Mon, 22 Sep 2025 16:54:40 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 113D182998
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 16:54:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=13602f48ad=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MEWf0Q027200;
 Mon, 22 Sep 2025 16:54:37 +0200
Received: from osppr02cu001.outbound.protection.outlook.com
 (mail-norwayeastazon11013064.outbound.protection.outlook.com [40.107.159.64])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 49a77kx5sy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Sep 2025 16:54:36 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBhpid3kFogxW7k8+T66HfthBY7EoCtJqar7ODWa6qEwTeoABTnX8yoFe33acYKWkU93FjMqpXb22AdLVfmUjPY/lwKOUV0+YhmWKRgvCUYZqFg75Cl98SCxWrukYuYMvG5KHdVoYx+mkhpjb+OrIvCHCwBn1KEqHDB+I9cECSGfYSoG/m6Przmh3ct95w0AXFAZCIsEjm/p0LT4P/t2gMcCt5NcS6RUtvxqXT8HcCLEWEn+AyrK3Unp5qFLCf7a25dUbBlouIpEfOARnY8SKQXtB9/9i66RXXl41IFj5Iv9zr9UuZuCLaGtMRNNvGS6kbTCqiFYvMGdQ9sV4HMkNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83AMO4cmqFXzgDn1yXgxpdMzOifvYku8UdaMTx1g55o=;
 b=orEiXt3sK45YxDT4qKTs1pKFQmKdcx4m+Wf6UXjqBTFjoTWKi2BfDUZntGgCmeP01x7d9yPzDFLS63cit6f0e0Wgcy31dZV9VYZqjp4uurJLEUJvPWmjcWE2ZykewGZMPeeREDSSGm+AoRhy1cEuSI7Aks07tDskx6d2BXA/E1wEn0rgFqe/684UVmwX8zGaF6zWLFHVRgDGVTIp8KFFC3HiAkLx8vSrG4p38kA6nWq9Rk2LgyJELwrU39V+uXQ9+9pp44i25Gi9h7s1KO6mvZjAZXZ3T0m8Ifm4I0cfk+Jd+u7UVVTT3jOdN8Bq/0/aXPOXBGRkr5X2kpOA8VN4Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.44) smtp.rcpttodomain=konsulko.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83AMO4cmqFXzgDn1yXgxpdMzOifvYku8UdaMTx1g55o=;
 b=lTklU+91YKfN5PruFyUgV+gIENpIcuy5P/deWmOmT0izYW0Vujw0+7w7Johb0NvUFWSJrR0eyq2CF+fx0VoWASC7DVaChNHXeg7KUdsYzMQpWgUon/W+pvsGmI76UaDF+z7mLwJSM5yMF+l4s/U4WETPM4hjokA+ngA2UsNsJWKd4GWKVkFILI56Y56KL0H/Q8NUvkTpNZonkAIXnOpeJE1ItR3ZhG1xWUp78fMIW4dQHpI12siDcGNqwwgVhiZ0szoozYbqEN8LQztNVqLsYZZQXpgI+mLgPtCXU2tZl6dn7NqrzGzSt5zxGQaTJVALYUQ4xPlh8qs3Po/eFLp0eA==
Received: from PR0P264CA0157.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1b::25)
 by PA1PR10MB9121.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:451::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Mon, 22 Sep
 2025 14:54:30 +0000
Received: from AMS0EPF000001A2.eurprd05.prod.outlook.com
 (2603:10a6:100:1b:cafe::c9) by PR0P264CA0157.outlook.office365.com
 (2603:10a6:100:1b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Mon,
 22 Sep 2025 14:54:30 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.44)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.44 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.44; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.44) by
 AMS0EPF000001A2.mail.protection.outlook.com (10.167.16.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 22 Sep 2025 14:54:29 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Mon, 22 Sep
 2025 16:47:09 +0200
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Mon, 22 Sep
 2025 16:54:29 +0200
Message-ID: <4facaa5a-c7b0-48ea-8863-0324ae1bc780@foss.st.com>
Date: Mon, 22 Sep 2025 16:54:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL] Pull request for u-boot next / v2026.01 =
 u-boot-stm32-20250919
To: Tom Rini <trini@konsulko.com>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, Gatien CHEVALLIER
 <gatien.chevallier@foss.st.com>
References: <e7ce25bf-c64c-47bf-be8a-158756058ead@foss.st.com>
 <20250919141110.GU124814@bill-the-cat>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250919141110.GU124814@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A2:EE_|PA1PR10MB9121:EE_
X-MS-Office365-Filtering-Correlation-Id: 872b5991-d436-4cd3-c88a-08ddf9e7ef11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGc1UUdmOEk2RU91S1Y1SDBqZHZBWTB4Mk81V3NhLzF5QmxUM2p2SmhTKzFZ?=
 =?utf-8?B?aCtPWmxhSFcxdzdQTmpQTWloMHZVYlNLZWtRNUdtdTNGZE16NDFBNDZLVVZM?=
 =?utf-8?B?allpNnd2OERxTUJUQ2tGcTErVk0zc0U4cFNTc3ZtYkdvTkJTUS90ZnJCZDVa?=
 =?utf-8?B?bmZBY3EreUNmV0RGckNtVWs1MHVUWklNTmczM2M3NUN3TTZXeUJYY0hNNlFz?=
 =?utf-8?B?ZW9ia0wrdEZJWCtockRuY0ttRFRpdGZmdmdkcDVlNzltVU15aTVNaHM0STNk?=
 =?utf-8?B?V3J2WjhwL2RXdHlNamdmM25SKy9sVzI1d0pWR1Jxb25sUnJmTmdKOTJEa3R3?=
 =?utf-8?B?UTE2ZG81bGZhdjNRMWZtSWZEM0h3UXpmalM2SHFvby9ZcVI4SVMzTFdHRjJi?=
 =?utf-8?B?Y1ptaFBTYzRYM0hNblBxU2lhVDZSMDMzYmFVT3QvTjBMaGNKQXV0ekRLSmho?=
 =?utf-8?B?N1NMWkQwT01TZVNkWXl5ZmpLNU95d3JwV3NsalVoVTMxVWs4L1F6Y3FqU3d6?=
 =?utf-8?B?QzY5TksrYUVhNTdhVzZLamhma0R4S3VPb01hdG5rMlF6Z2QxcGdxQ0l1cWpq?=
 =?utf-8?B?dmpDeDhqZUg2eFBNTThBVld2b0RjT2Q0SGJxaXpub2MrK25YbjVRcUZYZDRS?=
 =?utf-8?B?T1BuMWQ0WW5YOXhTZFh5elo4T0M5Tk1mMlVSdmFyb1AweWN5R3ozUkZuM0Qx?=
 =?utf-8?B?ZG1sbTM0Z3loVmgwVGxrS1dvRGhNWG5aTGdHU3F3NVRBK1pYemYzUDhtTTFa?=
 =?utf-8?B?Yk5PMVVUOU1LUHZLMkx1OTc5V04yQTJpc3F4R2lLSlR2WDdhV2d3bmtOczdZ?=
 =?utf-8?B?bzkvSUJnT1E3ZitCRDZEMXlMWVA3czFVd29CSzEwcWgzZGNrbXI4Rm1pVkp2?=
 =?utf-8?B?NTQ0RnhnSXRYNzdKTFU0K3RkUVY5MDU5OTlSUmkvWjlYSU1WMndXc2UvbVlQ?=
 =?utf-8?B?M0tZQXVCOHZ4WStsU1k1Vm9xcWJPYWdZcHZxeDM0N3pyL21qUWhGN3ZEcmJM?=
 =?utf-8?B?SExnSDRZUnZmZzJHNkZnTVFPblA3NkdUM0hNRHlPZjRFaCtVRFVhLzNseURY?=
 =?utf-8?B?OU56dkVZNUVWZnA1RlB1UGU5YXFWY0NPbWkrbFJka1c5TWI5V1dKRXJ5eDhT?=
 =?utf-8?B?elVTVmZMY3NJRDVtR0JwL1I5RG1EM1VvSzVSaVVrd3JZcmp2Ulc3SjlkZjBt?=
 =?utf-8?B?K2MzbHJDMTQwVnNtbFNMZTNEOEtyalRIWjk4M2VacjErSjk0ZnVySWJUMlNC?=
 =?utf-8?B?WnVBamNUQjVpQTZtUzFLU2ppcE5iU3N2RE5xYndtNWdXU21lNFlOUkFybFJJ?=
 =?utf-8?B?Ni91MjAxVXA4d0tlWCtHakJIRm9kZTM3VWNjQ1JVaXpKVzcrbXpIRGk5WnFO?=
 =?utf-8?B?TnJ6OXo3eUUzWGVqTjZuS3lackp3bFFQTDNjZDVrMUx0MFVKbElBOFB6Mllz?=
 =?utf-8?B?MUgyL0p2NTRmdmhoVkpLOEtacDNxVVN6N0psNzRxOWM5bzNPenRGd3lGK0lB?=
 =?utf-8?B?ODBOQit2YWdtLyt0WWVoSmZCbjI5ZHh0MXgvZXM4QlRQUER5WmI4SGR2MVRr?=
 =?utf-8?B?eXIxdFViNnVoTEFLL3IwMGRHMmRBa2NDc3Z5bDhnR2ZWYXFBN3QzOHRnZEhz?=
 =?utf-8?B?bnpYdXZBVVFHazFEZWVjRll5TEhBbDRWRHVWdk9WaDRnbkhnRytWbVpFMXhm?=
 =?utf-8?B?cmd1dlBZZHJ3ZFowUlZkWFJNb3A2VTRPaEc0TW50QjJQSTVkbFMvK1Z4d0NG?=
 =?utf-8?B?SStSUXlsWFlBYXY2YkF1Zmh2R3Izcm9aZ0R2V3JzeHd2VU9BT0RwWEFPMVVj?=
 =?utf-8?B?bUMvSTBZZ1MvUDROVWV2UjlQd3BVRFVDdU9td1JqSEcraFN2RFNEVEFuSldU?=
 =?utf-8?B?OUNvbzUvb2g3QjBXQ0dSSDloaXk4KzUvRnlhcHJZcUtxNUZNL2phRDJLM3du?=
 =?utf-8?B?Z3RYM3ZxS3NnSW44bGMxckozL1VSQWV2QjYxc25Nc3FJc2xoZkxaKzFCazd4?=
 =?utf-8?B?UkhSMXEybFcvU0s5Q0tUZUdjV25FMDg2enIvWmJMckpvVVAzUmhyc2t4STl5?=
 =?utf-8?Q?U/5VNm?=
X-Forefront-Antispam-Report: CIP:164.130.1.44; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 14:54:29.8982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 872b5991-d436-4cd3-c88a-08ddf9e7ef11
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.44];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A2.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9121
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIxMDAwNSBTYWx0ZWRfX70n1fvVc6nna
 CmUP8+3PR1K1gu47bx0R77Mm3STktXBTBLaWzpboOvaFoxRPdGnR+kAV/1MBmV+Md4ZVIa7yzzH
 Bc+3eUCQyVTbvMfzllqo9Wnl9/9dyIPGEK/1acIcLrjRxdXQo1H5oNXKpGT4EA13s4k27aZhqxf
 Nl9jZWlqLTqBS58Fmf52iuI+HRLaC5Hz9/s3uYPuHxVjY4YJh+H99PkCvdUcA8HSTqE/lPq1qJp
 EBGTO2zkapjLKmKxaUawHI7w7iJG/Csz71SlocyZ3EK+HYbDKcIetH4Pb8Td9zeSKThdIEZqa5R
 irchjjd3bAbLGMEoJh2bz6r7waL8TXpSYu3uhIg07vJZOhy43COstPAjAg1TGp+VaYt7cZ+GQdx
 C6NXkaxj
X-Authority-Analysis: v=2.4 cv=H6Tbw/Yi c=1 sm=1 tr=0 ts=68d1632c cx=c_pps
 a=JRzJ8T7PdTfL/uBtHARA3w==:117 a=Tm9wYGWyy1fMlzdxM1lUeQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=SAHXIHsbQyQA:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10 a=YfCOm-DyAAAA:8
 a=SSninbzh35AtQip9lr4A:9 a=QEXdDO2ut3YA:10 a=zQLMK8awuJ6_Hvp-_9Ux:22
X-Proofpoint-ORIG-GUID: C00oMHyBaFgdqFIpOlrezDg9NE3tLkhE
X-Proofpoint-GUID: C00oMHyBaFgdqFIpOlrezDg9NE3tLkhE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 bulkscore=0
 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2509210005
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



On 9/19/25 16:11, Tom Rini wrote:
> On Fri, Sep 19, 2025 at 08:36:18AM +0200, Patrice CHOTARD wrote:
> 
>> Hi Tom, 
>>
>> Please pull the STM32 related patches for u-boot/next, v2026.01 = u-boot-stm32-20250919
>>
>> CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/27668
> 
> I just noticed to start looking at this yesterday. The 'tristate'
> keyword is meaningless in U-Boot, we only use bool. I've fixed this up
> in the merge commit.

OK thanks for taking care of this point ;-)

Patrice

> 
