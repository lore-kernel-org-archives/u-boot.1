Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB8DCCF9F8
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 07:44:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD3FF83914;
	Thu, 30 Oct 2025 08:44:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="V8wQIzSr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B14B83946; Thu, 30 Oct 2025 08:44:31 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61504838E7
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 08:44:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=33980d621d=yannick.fertre@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59U7VawG1099199; Thu, 30 Oct 2025 08:44:21 +0100
Received: from pa4pr04cu001.outbound.protection.outlook.com
 (mail-francecentralazon11013009.outbound.protection.outlook.com
 [40.107.162.9])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4a3mwa310m-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 30 Oct 2025 08:44:21 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUopODYoth8ohEoSgbkYcmxCGhKOnPMYB+GSgjZabMAzxh/n/4CM1m4Je9p1YqdWpOIljSmJa8ELy1Kzh70NUp6Ysiwg5uj8+a7nfZNFLVdoHZYtsAznj4pBRjHnrHLt7aQkl7QfXkR5IhI+KK13UnvzRayUHV2YD2e7NFMAkus3R9hvQ4y+ax6n/LTmHSXCperM5YLVXhYjZkPAgfgonmUJhZAApiSPF+jUxnNSAccXstW7W7uARbFp0yIcFSwrOE37Ydy7iLouxFS96iDKaHbxVF1NrnHUd0rFZKy7oNOW423uHsSBdIxIZlBV3vDzRTPDPE2mVJurJolI8ZRszQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Z33fBKYUkatRJQsN4mKhuAi670uWDi4nLG8O2wM8oo=;
 b=w0/S10o74bKSHbHCvj0s3Ur8cOJFCXrdLUhkMYSt8jT0vnYiB01RzUbNZ7sg7lDb6odWbrRGeBk5esJuHIWQpcgh7gRQNxSIP4WAV4kXTzG7RbBaBS2Z8EAHEIBY3bl9REOtLftM50TXYzhZ3LSz0ofcCvCkOZvfdLejvh0jsvLsD3NC3lmEAqzbHo7q3n++Rpi3A901eM5CgscjlNYbZBMXy7HmMpPLhNm+AqTmpstaiXNGQW5v6USlJQghgNOwgEfzLu/7ebtQYwG1PFO1Qe+/KLsi/kh73p+9Lh1V4PbXzMMeYOiEYVnGiTdzvOhLyS2TlMmCcwAzGAQSmRC4jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.44) smtp.rcpttodomain=konsulko.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Z33fBKYUkatRJQsN4mKhuAi670uWDi4nLG8O2wM8oo=;
 b=V8wQIzSrAij/xwZqsVQ6sTT9ZaGT+L2WAvX5N3JfEYLA5gWndoytieAW7tDuEqzk6spZ1oinn7gkrdENeb4zxuykWpIi0h1abRflDcYHr4WOcFtHUFrOGA29XMj51OKtRxnHODucui0tRG80J+r4Heac9qHv07HmOXWYfbc8eEkmv15XkQDag45fp3Gcc3P16ir2ZQbW6M/kIYVb8H+dkk5yJOdxcnsDAJd9vD+H7G7vDDmN8XRkKkrA/cPsMxR49rPqsLkuVqUN51GRDzCZCGSVb0bv0/I/jsePkqdMcyEcY3fpaM7T6Xsv0s0buwqWsLFowdmFalWSxaIbgMa0pw==
Received: from DU2PR04CA0066.eurprd04.prod.outlook.com (2603:10a6:10:232::11)
 by AM7PR10MB3720.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:13e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Thu, 30 Oct
 2025 07:44:18 +0000
Received: from DU6PEPF0000B61D.eurprd02.prod.outlook.com
 (2603:10a6:10:232:cafe::9) by DU2PR04CA0066.outlook.office365.com
 (2603:10a6:10:232::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Thu,
 30 Oct 2025 07:44:16 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.44)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.44 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.44; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.44) by
 DU6PEPF0000B61D.mail.protection.outlook.com (10.167.8.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 07:44:17 +0000
Received: from SHFDAG1NODE3.st.com (10.75.129.71) by smtpO365.st.com
 (10.250.44.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 30 Oct
 2025 08:36:49 +0100
Received: from [10.252.23.232] (10.252.23.232) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 30 Oct
 2025 08:44:14 +0100
Message-ID: <92fe2431-deae-4d78-947d-dbc0fbf58aeb@foss.st.com>
Date: Thu, 30 Oct 2025 08:44:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] configs: stm32mp25: enable LVDS display support
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, Tom Rini
 <trini@konsulko.com>, Kamil Lulko <kamil.lulko@gmail.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Dillon Min <dillon.minfei@gmail.com>,
 "Patrick Delaunay" <patrick.delaunay@foss.st.com>, Anatolij Gustschin
 <ag.dev.uboot@gmail.com>, Simon Glass <sjg@chromium.org>, Sumit Garg
 <sumit.garg@kernel.org>, Philippe Cornu <philippe.cornu@foss.st.com>
CC: <u-boot@lists.denx.de>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250904-master-v3-0-b42847884974@foss.st.com>
 <20250904-master-v3-7-b42847884974@foss.st.com>
Content-Language: en-US
From: Yannick FERTRE <yannick.fertre@foss.st.com>
In-Reply-To: <20250904-master-v3-7-b42847884974@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.23.232]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61D:EE_|AM7PR10MB3720:EE_
X-MS-Office365-Filtering-Correlation-Id: 58fd8ec8-0a06-42a9-5720-08de1788219b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXkrdEVla1k4Ykp0dW5lMDYzbm5kUFQzUnVRUGVPLzNJVmlDOVpncDliTWVM?=
 =?utf-8?B?QzE5MTlhcCtPQllGZXZibDdxZFg1VG1vWnpSblpmMXFTRTJRZlBtdnAxbDM3?=
 =?utf-8?B?a2dHNWs1TXZmQzF3UVBEQnpnSmUvd3hRT3YxQ0txOTVzZmFodmdUblpTQTBi?=
 =?utf-8?B?alp0YXpLclpIZDdwSXBoQ0VDemhSWkhxaExvREp1ZU9pTUhoTFZBMHpLVmpp?=
 =?utf-8?B?bWVjVGRiSFJGY1ZTL0RyVG9MUUxMMTJxQXJvcy9Qb2htRmZlZ3lxVThJNmhv?=
 =?utf-8?B?d1B6djdnVmpTSzlLTGlIbzFmWDF2T29MRHhqZVhGUU9TSjBpeTl5MU90UW81?=
 =?utf-8?B?ZExEYlBmQjd2Uzcyb09jSldTMy82UmxHSXpmNTJkcWtDYmhIR2JGbXd3UzJo?=
 =?utf-8?B?dTZrNVhrbHkxczI5a2RJS3lUbVdBbDlydEt2eFpoS1hBeFFoRmVnMkVzN2tD?=
 =?utf-8?B?TnJCSzUvQ09pUklnMFVEWDZsNnl3UDdTMk9HbGtlTHpsYWFCa3BmQk5WMWpT?=
 =?utf-8?B?STNKUTZqQ1QwYXhjbGE3WEtvQTRXakFBUE54MDFGY1VMblhWVitsUS9qRlVU?=
 =?utf-8?B?cU05eVNFZStQRDVXR3FON2VwMklVWlhLNUdWT0JYTUxHNDZ2TUk3djZ6VHBU?=
 =?utf-8?B?d0N5aklvcWZ5SXJsTmZrK0NlOEM5Vzg1NTVLQUpabExDUS9RZ0R1WkVFK1Ey?=
 =?utf-8?B?UVNLSktPVmkxUEtuVHFUSzM4WWp6aCswekIvdUUycmo4VUk3dVlKVndoSXFN?=
 =?utf-8?B?TUtlU3p2aURTWCtjNXgxaExnNjNDYS8zRGxiQWx6bmE2dGVrMGFRTjc2bndp?=
 =?utf-8?B?a0hmZjJCZ2hydVBxMlhQZXpIek5lT3JlWXJ6TFI2Z3Z3cmhVQTFQWFJ4Y1lR?=
 =?utf-8?B?Q3owYk1VUHd4cGlTcUlZUHVGQzhkZU1lOE9QMjN6UUZTQTQ5ZGhvdmRxMEhj?=
 =?utf-8?B?SUY3TXR3cnozbWNsNXRuUkFFeUNXaURPVThWRHFDM0NkelA4bnl4NmlBbkh2?=
 =?utf-8?B?Yy84aU4ySEhyY24xbEJiOElyaWVtczBOTVhFZDZzNWNCUGpVZ0lBQkZnd2lF?=
 =?utf-8?B?dVQrejUyUUxRb1A1Nml1ZDk5ZWtwTzBwTHRYRzV3dmYxT3JabUhVaUJKYXZN?=
 =?utf-8?B?S0I5cmlPMk4yS2hjTDRQN2tuTEhYM3VhNUErNFBReFBkQXVBc3lFa2h5TG5V?=
 =?utf-8?B?bG1Kakw0bHk2QXRodURjQkdBT3g3Tjc4aWJjNGZJbi9WRGFISTVsd3NLTjdZ?=
 =?utf-8?B?WWVmcjQ4ZXBzK2ZxSWdjWkZVRzVPbk01UnJUbEU0OHFTemJSN1dVNmxvajJH?=
 =?utf-8?B?YWIwKzZ5aGxacTNORlRWK3NDeC9ITVQ3WlQybzNjNVZtbTRoYjJoQ2dSbmpy?=
 =?utf-8?B?MnVCT29pcUl4Y3pIaTR3cmkyT1VhL0Z6V3d5VzdCOUtzZEJ1OGdmeUNzWW9U?=
 =?utf-8?B?V1IrZi9MQ1hwUnBlbFBJa2VtZkp4ODN2YitYRndHdHBuUzNmU2RtQ2RVVld5?=
 =?utf-8?B?YWIyS0xwM3NRbmV1Q0xDOVR3SkwyNzZ6UFpwTmZrYUtPUnN0Q3ZVZm9tcUll?=
 =?utf-8?B?cGhlK2phTXJ5dDBkbmFYWGczZzhzNXA0cWU3MEtYYmdpTDQ5UU1EVE9QTy9D?=
 =?utf-8?B?SCtKaTFFZWZaam9CQnNLbWxWemlKa1pGbnJwbUN0clBESEpvTnJjdjNxaFgw?=
 =?utf-8?B?WXhhcGxvem1yRjRuS2NzWC9VcHppQ3Z4aE43Z25jRStvSWNwWStiQk9Qaklw?=
 =?utf-8?B?UUpSaEkycldTd25xdzRqQTJnbS9aSXRYZkI3aFBiUnZSVExkUEpndU1HVCth?=
 =?utf-8?B?TFRBcmFTcUc4N056Y29LaEs3U0tGOVhsSzk0QzlsbjZ0dS9UbGJjejZtZytQ?=
 =?utf-8?B?b0c3TlFJZGR4QkhSR3NhTklNYjcrNE93TFZ0TkRkeEVITzQxUVdEWG4vR2sv?=
 =?utf-8?B?d29kSkEvMzlva1Y4Z3VXUDVMNWVKL3pNNnk5eDVvcUJrMG9QbzhuWWk5L2hD?=
 =?utf-8?B?VzJFNTBsUUt5aDJ3RGlMT2lya3FUVGVIWEJlY2huK0hmYzhPWVgxdEF3UFdR?=
 =?utf-8?B?VVpWRkR2dW9UaUswa0dzN1d1bER6VFNhNlVqM2pXMHFXL0NiT1FscTFndXh3?=
 =?utf-8?Q?lE33gfITYzfwY6VR7dxQVo0Nf?=
X-Forefront-Antispam-Report: CIP:164.130.1.44; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(921020); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 07:44:17.8984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58fd8ec8-0a06-42a9-5720-08de1788219b
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.44];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3720
X-Proofpoint-ORIG-GUID: lww9yhoUR5Jmi15PnTrmZ2E8L6IdDbQi
X-Proofpoint-GUID: lww9yhoUR5Jmi15PnTrmZ2E8L6IdDbQi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA2MSBTYWx0ZWRfX8jKVTkcM6shX
 yPTUr0mcfNMh4szYZjDbErjuxqgj9Zf5+L630fkEoCO0PGBL5T2vmMHF0mAxdLm22zXZlc8rXQR
 Cke8s7LpwkjgSGjmRmVlZ8SF3tG4fLriU0xFMjYj/msrEDGE4NXqlwRthFAjbfH5474cKVud9AI
 BGlAxtzKGzD/5bV3MD+xRX91IeQoNC5cwl1ekCd2wEBiKSNw/whfik6sKnZ+qSLtpbp1p+4fJvW
 CCzgowE6owzH0C1vrFVlgNRAH1TAYoq+zmEMWZBTl0X9uIkCjMFKbt1OpNHH3NuEQ+/vPROjTpP
 L5ymj8+Q7GFLAC3VzPkmfRenhiFpNfFJEsAkPnPhWOK8HadiYW/kmw40+W4J8YGqRXYPMh8Lm/Q
 heGZdv1434t7Pd7haetgLa3H2j9A7g==
X-Authority-Analysis: v=2.4 cv=DP2CIiNb c=1 sm=1 tr=0 ts=69031755 cx=c_pps
 a=LGnPzPuKiaZPXrRM6phl+Q==:117 a=Tm9wYGWyy1fMlzdxM1lUeQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=ttam_Flv6DUA:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=mEGgFpeMVL09x6plPeYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300061
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

Hi Raphael,

Thanks for the patch.

Acked-by: Yannick Fertre<yannick.fertre@foss.st.com>

Le 04/09/2025 à 14:53, Raphael Gallais-Pou a écrit :
> Compile VIDEO_STM32 and VIDEO_STM32_LVDS by default.
>
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Reviewed-by: Yannick Fertre <yannick.fertre@foss.st.com>
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---
>   configs/stm32mp25_defconfig | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/configs/stm32mp25_defconfig b/configs/stm32mp25_defconfig
> index 2b02cd86d6134497151e398eb54230f08d4e6272..e84df4a2a8f52890376f7689b01d3dcab5079ed9 100644
> --- a/configs/stm32mp25_defconfig
> +++ b/configs/stm32mp25_defconfig
> @@ -78,6 +78,9 @@ CONFIG_SERIAL_RX_BUFFER=y
>   CONFIG_SPI=y
>   CONFIG_DM_SPI=y
>   # CONFIG_OPTEE_TA_AVB is not set
> +CONFIG_VIDEO=y
> +CONFIG_VIDEO_STM32=y
> +CONFIG_VIDEO_STM32_LVDS=y
>   CONFIG_WDT=y
>   CONFIG_WDT_STM32MP=y
>   CONFIG_WDT_ARM_SMC=y
>
