Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9928CCE8D6B
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 17:43:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D791E83BE1;
	Mon, 17 Nov 2025 18:43:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="ajpXwQoH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2054983BEB; Mon, 17 Nov 2025 18:43:07 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2CF383B9D
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 18:43:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=3416482c8e=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AHHQKGx1798059; Mon, 17 Nov 2025 18:43:00 +0100
Received: from duzpr83cu001.outbound.protection.outlook.com
 (mail-northeuropeazon11012044.outbound.protection.outlook.com [52.101.66.44])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4ag6nw8bwx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 17 Nov 2025 18:43:00 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MP0QVTuKwUBt/p6z9wbNkoh7ruePf7bCvHFS2REVXAebU0Og+V19EfY3uw+iYMQgqEU8hT5HKYxQegCOoxWim2pUqZ/wAzkgDWIUOAcawqPXQ6AgSXJ44aWx4Ke2+ifAcUuFCATfemm8jlvqoxvt1DPKQcxlnfIGO0dJmQwPnRiy+F5aUMM2fcwjyQZe8y/yQqzwlOyko+UdLTK1yTOEQ7Wz/qmd7WkJl3x4RP3pOPFlQtFItn0Ixn3bitjj7AYdJymg+UNkZYj2sWY6Wl2sooIPeZlet0v4igvVSej5Fia5+I9v9n47Euz51kLFWHL15dxEEP4yNbzplCa0NeI7LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQ1UDBCvA/G/yhSSrn57lrmvB9S2uatQbiSTSwfvwag=;
 b=S10pQi+D4S448t/fjCGFh82iGyEHKwMH95506XC3HTS81P7duvJLd8XNTCejYL7fhTjpYD3CGBngg8EDo/lo1sQi4zjD9INz6JJJwHgto0rQRjJmsb8aMvoE6PQ6ROuigpfSlET10vAIC+Efml0u3dPVUUvjQq2oQsQpbS6lzWg/bEQW9Z53L6HYIDcaBGkLMeCSJr1EC9326V7OI+WSdKz/2pp+3sSi+b0beOVLVVtGuny0h00ziynbM+w3opqlG2a2+NVz7fG+Cd1tV2dZyiPje80MbU1wiLnVSH8PUa7KJ8Sn/aiTvbNpVzJ55qwMcprd2doeubnVItgki+fmuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=konsulko.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQ1UDBCvA/G/yhSSrn57lrmvB9S2uatQbiSTSwfvwag=;
 b=ajpXwQoH/VgdOOtUm1bPK4YNNI8aPv5WePmRCplZDRXDAXnG3fCPOMTeepu7B39D86Or/pwOZ/Dy5pir9yG5BzjrYdc57aNbhYI6sZMgEgguJPB8pEqDV4kelWpwCNTAqXnZrjCNASrhLMQTdeVd2g2a08d9u4b6t9bdneQL6bsYTnFFTDWkmrOge71bDYVus6nkcrQ47cCzGxreNh01nntaIfo6FVuAuHF/C3E/o1SsUk2kIH7BWkYOZ3rMeizkyXWLDzjDbp2ul5KXVdve3EBSuacRNSxXeuZ4VW/ndNkL+T14mSH0q4H4zqkE0oXUJZfc+i7kaVQzwk/r3BzZxw==
Received: from AS9PR01CA0005.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:540::15) by VI0PR10MB8881.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:23a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 17 Nov
 2025 17:42:53 +0000
Received: from AMS0EPF000001A3.eurprd05.prod.outlook.com
 (2603:10a6:20b:540:cafe::4) by AS9PR01CA0005.outlook.office365.com
 (2603:10a6:20b:540::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.22 via Frontend Transport; Mon,
 17 Nov 2025 17:42:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS0EPF000001A3.mail.protection.outlook.com (10.167.16.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 17:42:53 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 17 Nov
 2025 18:43:06 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 17 Nov
 2025 18:42:52 +0100
Message-ID: <96c2d56c-1079-4aa9-8c89-d6aadb8785c3@foss.st.com>
Date: Mon, 17 Nov 2025 18:42:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL] Pull request for u-boot master / v2026.01 =
 u-boot-stm32-20251117
To: Tom Rini <trini@konsulko.com>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Asadeds <md.asadullah@eds-india.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <raphael.gallais-pou@foss.st.com>
References: <dfa99b38-b75c-42da-b631-a158699b3f0b@foss.st.com>
 <20251117164654.GK2125796@bill-the-cat>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20251117164654.GK2125796@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A3:EE_|VI0PR10MB8881:EE_
X-MS-Office365-Filtering-Correlation-Id: fac34776-5530-48b1-4ca8-08de2600bc7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHVLVktWT3JuSDdYVTdoMHVzL2hnREw1dWVvVVF5K1U2RXNueFhnUnhFcmh0?=
 =?utf-8?B?cCtib0wyMVdNNUpILzkwS3BUak05c05PRGFZSENVSVQ1cUhOc05wQnQ4NXdP?=
 =?utf-8?B?Vkh4eXNhckFoZ051TkMxTUV3T2ZBR2R4ejYwR0tMcjViQi93ZFlTdTU4MFJ6?=
 =?utf-8?B?SmN2dnpCa000djFGaS9VOWxIYkZncTI5NnVpcm1BN2liZTQ4TllDZFhxRHJs?=
 =?utf-8?B?RzBPZTY0di9BQWtWOGwxdDJJbS9ZOXRwZFB3YUx2VTZIaXNoRlFqODQ4bk92?=
 =?utf-8?B?Y2MzQ3dqaUg5RzljR0QrWk9pTEZoSEhBb3BoMisyUG5VdmI2NHBqOHNVd3Ax?=
 =?utf-8?B?cGE4M1RKbEhYQVpDMkhIZGpMYnpwNmR4UGhVcXZQdTdFTnA1T2M4RWFEOTNz?=
 =?utf-8?B?TXBpQkFYWUM4aFpsMklWRjN0ZXdpZEtSQkxsOTB4MmZqWUZYSkNpMUZmTlN1?=
 =?utf-8?B?UzEwNitMSnlRdzdsQjFjN2FKb3VTU0d2U0o1MENBaUlES3ArWE56NEVPV2dq?=
 =?utf-8?B?RHc5cEpsRHJvcVl3SUQ4Tk80WWZVdndUbnZrVXMyWmtTcEROSm5yaHJHdzF0?=
 =?utf-8?B?OFZhLzdHSDQvSDhVaUhvcVhQME1LV1NtVUhKYWZOclVzRFBRaVVTR3VGQldv?=
 =?utf-8?B?QUhYak9jNTRoNG1tTHBqQW9Pcm5uaHovamlNaHRHSFp5WE1XaWN2VzN3ZUk2?=
 =?utf-8?B?VGMwcGRCYjJaVUI0NU56WTVyTHhwOFpZOGI0WmJvUFo2ZGpBaGp6SDlLRXVw?=
 =?utf-8?B?aHlqajUrMVRyMEVnSS84OEhTem9pYmVoRHpsOEJEUkZKaTIxdVA0elRYeDJs?=
 =?utf-8?B?M3RkSUV0eExDdmJTaFV6K2FGSisvYkd6SFZINlJMSzg5ZnhkTVFDSDRmV0o4?=
 =?utf-8?B?Z3NKNXQ3SzV6L1pvLzIrMHJHSmZIUzh1bCtGUGIxdjNFd0E3MjZma3Q0R04r?=
 =?utf-8?B?ZHZKM1RwNUxWQkdYSUpqbmhvMlAxQk9OWENvMy9qUWpxQnVPb21CbC9rUWJm?=
 =?utf-8?B?OHZSSndRYjBNYVRFbXE3dk50aDZpL0JYemFGWHdpbFh2c1JtVGluKzhlOUJ6?=
 =?utf-8?B?ZmRBSGQ1MXR6L0NZYm02OXJiZXpyN1NSN2k0R0tIR1loRFVSdWU5UkZlREVo?=
 =?utf-8?B?VEozNEVtby9CMVNoMUVyL0ltTVlhbTJWL2d0Nk5VTktIekFDZWJ0c0NpcG5Z?=
 =?utf-8?B?cEsxaERJQ0E3UkZ3azh0dkh3RUZvODhxSGcwSkx1TUljTjZ5L3dBUlF4WkdK?=
 =?utf-8?B?WU9yU1dnV3oxdXVILy9ERHdES0EzV2Q5VERLNXg5SHpMY1lHMXBLbW9DZnNq?=
 =?utf-8?B?L1cwc1JRSS9mOHJLdkRvKzFNMlVtYkVJdGxnYjBHQi9oSis0WFgwY3lnMTBy?=
 =?utf-8?B?VXJtRHF0SE1nUlQvcC9SSWx6ZFdGb2VHSUREOXZkQzhLOUVDNGZCYVN1L0k3?=
 =?utf-8?B?ZFhxVEtoMFU3eDlkWFB2QXhreHo1akt0dkJLL1k4R1RWS2dDM0pxaUZDc1BC?=
 =?utf-8?B?ZHcrQmYyRDNLeFJybmZUTi9sVGZUYi9lTFgvU3dINlB4VWJzOUpNcGc4UWIx?=
 =?utf-8?B?QXh3ZUFhWkJWSUJWcHFBdXdqa2VQYjdNNHdVQ0k2aVhIc2U3TGxVY1o3RTQ4?=
 =?utf-8?B?WEk5bEtsOW00N0hLVXl2MlFFR2NhSGduN0FzOG1TYVpGYWw3RVd3UUNGYVJ2?=
 =?utf-8?B?bEFLaVBsYUNHR2hHRTQwSytYcTJQQXpkekVIaW43NWRMUG1vY0phbEdmNXBi?=
 =?utf-8?B?dDlnOEx1ZTFmeWdVU2JUVnhzbzlVMnpKTUhCbGxKbTNWM1NQT1NqeGxwYjdx?=
 =?utf-8?B?dmcyRkFzcXdXL2x1Mjh4SWJaN2wva29QV2JWVUQwakNpSjg2eHVIRUtUMWlR?=
 =?utf-8?B?QmZOdlBUSXhyRnJreXR3ZjlZemUraVdDSzJNbFBGMlF1c21aSFlMck5SWHNp?=
 =?utf-8?B?a3NtM3N3djhsek1zZTZ4WnlkTlVtOW8yU3RZU0ZPY083MzNtRklvQXlEYk83?=
 =?utf-8?B?OXRUbDM1RXNsYURQMWRVMFAxVjVkVDJZYTRPdHJxeStUdWhDcUxOM2FiRGVx?=
 =?utf-8?B?MHBKT0J6WGtNcFBCU3JqQWxBTFhPVnpDWlRQbXo2c3VrZFBTb255anpnVjhB?=
 =?utf-8?Q?+UVU=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 17:42:53.6676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fac34776-5530-48b1-4ca8-08de2600bc7e
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A3.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8881
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE3MDE1MCBTYWx0ZWRfX9Db2QvT/CGkx
 yFXsN/I/jocmQrArBzSV6MPm7bk8lzU4th3xgFqpszwrIsw4SbyIKzk0YHLA+x3/w6RuL/yYaI1
 tKZzuVqE3/d+W+nJ6PrvvdAK9ZGCYXNTuDFsEvYB5o3qpRFYunvF7/Ym9/8Jmi8Qu/WnR0EwLJR
 ZqGHNgbQVpfA7ecfwdrG54ttBlWgVo+9nIr8VxfJinI40UAY6FQx44Nit2lVS8TU9Smsx3ES3RF
 Iwv4KvEbZh/z9wj6IWo6BCJgJoW8kVISG883T6cFNdaZ66TJQcTZD6/4BR3i+TFBOw9ZkraKGbo
 FDhOC3hWGKoF2aQ9ExwJxaQwWy9yXx7ez/MJwNegiE6NEku4VVpIMjG52zlpvxPhLcox8/+dCjo
 YEFl0r5HYu8WnGuA5Nu5de6noW8W+w==
X-Authority-Analysis: v=2.4 cv=WPVyn3sR c=1 sm=1 tr=0 ts=691b5ea4 cx=c_pps
 a=cJFLXlvTZex2m2t0Pupgcg==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=YfCOm-DyAAAA:8 a=dytLNw_WKNaHN_-QKaIA:9
 a=QEXdDO2ut3YA:10 a=zQLMK8awuJ6_Hvp-_9Ux:22
X-Proofpoint-GUID: shpg-IQds8-r9JkUmXfv7wPUDHIZSXbE
X-Proofpoint-ORIG-GUID: shpg-IQds8-r9JkUmXfv7wPUDHIZSXbE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511170150
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



On 11/17/25 17:46, Tom Rini wrote:
> On Mon, Nov 17, 2025 at 09:33:03AM +0100, Patrice CHOTARD wrote:
> 
>> Hi Tom
>>
>> Please pull the STM32 related patches for u-boot/master, v2026.01 = u-boot-stm32-20251117
>>
>> CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/28392
>>
>> Thanks
>> Patrice
>>
>> The following changes since commit 365a7079fb918643da0f0709660a7d8ea76dd6f3:
>>
>>   Prepare v2026.01-rc2 (2025-11-10 11:30:56 -0600)
>>
>> are available in the Git repository at:
>>
>>   https://source.denx.de/u-boot/custodians/u-boot-stm.git tags/u-boot-stm32-20251117
>>
>> for you to fetch changes up to 66e2e941cd44db9c642b64618bd16ef132fca83e:
>>
>>   ARM: stm32: Add MAC address readout from fuses on DH STM32MP1 DHSOM (2025-11-17 08:09:23 +0100)
>>
>> ----------------------------------------------------------------
>> dhelectronics:
>>   - Move dh_add_item_number_and_serial_to_env() to common code
>>   - Read values from M24256 write-lockable page on STM32MP13xx DHCOR
>>   - Add MAC address readout from fuses on DH STM32MP1 DHSOM
>>   - Keep the reg11 and reg18 regulators always enabled on STM32MP13xx DHCOR.
>>   - Fix boot for stm32mp15xx-dhsom.
>>   - Fix build of ST DFU virt code on DH STM32MP1 DHSOM
>>   - Introduce DH STM32MP13x target.
>>
>> STM32MP2:
>>   - Add support for stm32mp257-dk board.
>>   - Fix arm, smc-id value for stm32mp23/25.
>>   - Fix stm32mp235f-dk boot (add syscon compatible, add txbyteclk).
>>   - Add display support:
>>     - Introduce LVDS driver.
>>     - Add LTDC support.
>>   -  Add Ethernet support for stm32mp255.
>>
>> STM32MP13:
>>   - Add ADC support.
>>   - Add power check for stm32mp135f-dk board.
>>
>> ----------------------------------------------------------------
>> Asadeds (1):
>>       arm: stm32mp25: add ethernet support for stm32mp255 series
>>
>> Marek Vasut (7):
>>       ARM: dts: stm32: Fix STM32MP15xx DHSOM boot breakage due to ETZPC
>>       ARM: dts: stm32: Keep the reg11 and reg18 regulators always enabled on STM32MP13xx DHCOR
>>       ARM: dts: stm32: Introduce DH STM32MP13x target
>>       ARM: stm32: Add missing build of ST DFU virt code on DH STM32MP1 DHSOM
>>       board: dhelectronics: Move dh_add_item_number_and_serial_to_env() to common code
>>       ARM: stm32: Read values from M24256 write-lockable page on STM32MP13xx DHCOR
>>       ARM: stm32: Add MAC address readout from fuses on DH STM32MP1 DHSOM
>>
>> Olivier Moysan (1):
>>       adc: stm32mp13: add support of adc to stm32mp13
>>
>> Patrice Chotard (7):
>>       ARM: dts: Add stm32mp257f-dk-u-boot.dtsi
>>       ARM: dts: Fix "arm, smc-id" value for stm32mp23-u-boot.dtsi
>>       ARM: dts: Fix "arm, smc-id" value for stm32mp25-u-boot.dtsi
>>       ARM: dts: Add txbyteclk clock in stm32mp235f-dk-u-boot.dtsi
>>       stm32mp: Add stm32mp23 support for syscon driver
>>       configs: stm32: Enable ADC support for stm32mp13_defconfig
>>       ARM: dts: Add st, adc_usb_pd property for stm32mp135-dk-u-boot
>>
>> Raphael Gallais-Pou (6):
>>       ofnode: support panel-timings in ofnode_decode_display_timing
>>       video: simple_panel: add support for "panel-lvds" display
>>       video: stm32: STM32 driver support for LVDS
>>       video: stm32: ltdc: support new hardware version for STM32MP25 SoC
>>       video: stm32: ltdc: properly search the first available panel
>>       configs: stm32mp25: enable LVDS display support
> 
> I'm fixing this up while merging but in the future it can be helpful to
> run scripts/checkpatch.pl --git on a PR as I see a number of duplicate
> signature warnings (which I fixed), and one spelling problem which I
> also fixed.
> 

Hi Tom

Sorry for that, i will take care of that next time.

Patrice
