Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0535C44507
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 20:48:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D32C884BE3;
	Mon, 13 Jul 2026 22:48:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="C9k8oVf2";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fD9I2iq/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69F9184C13; Mon, 13 Jul 2026 22:48:33 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAF3C84B93
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 22:48:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66DJ7Lhb2978531;
 Mon, 13 Jul 2026 15:48:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=wNI7T9+GhLvxuyRegknbq10RzKvCD1eA89qF7OLr/
 9Y=; b=C9k8oVf2vZyzZKm1IcjNy4jxaWqQLu2VifVwtFKYpGZSpKBBUke/ykENZ
 i8mqR3sFtqlhfjITaPo/rzZSMyBfjLnrRWPa7IOzvDtNoI0HiTll5NL1VhwsAD6J
 QO95Sam1S7o3wtl9RDNDvT5i4SOn72cwWA5RtB+HAHRxiXXKECRrMGL4FCG23B5W
 DzoZvgnawuC59RkYjiNFe1LStdW8PkiHV3zoKo8+/SrOEMrbaqww/hF7fxJGKMoz
 ViHDEuLVZeilpZi5wyJd5/dpxcnGWof7pMX1AUHZ4Q+cYQ1JNUvlOuaF+FFv2Uy+
 P/Ildr19Y9oP4dHEgV2r1d/el/CFg==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012002.outbound.protection.outlook.com
 [40.93.195.2])
 by m0384305.ppops.net (PPS) with ESMTPS id 4fcxx6kgeq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 13 Jul 2026 15:48:21 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JywKYdSu1r/8uYnig5xuDiGGkn7JfoEbOFAHmKX75EpPn4KGQSRQiIFWG3J6264pWFk8w8gn7kwST9kKDP1OiUfWWr/YlOAfRSU/w9jIR6/eMILAGzoN9Izsw/d6XDpAEYtNeq4CHWM2aTXPT4kzB25zin+6OUcCjNiwMvVLYFKFZZgAhVDTwxjH470rbZrYBjKISV8AUOFyE1Xs1e98aICqhgqzxaJ/k1bljxNL521j3N/dBWcwxraKkMJABdY3hct+tu/9mJxzc3AzFPUM5Nodpq6IIqJIyYqwgoG0Li+KBmqIccuHc3WWpKTFP06HPar/JnsnNJySaCPoXoEylQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNI7T9+GhLvxuyRegknbq10RzKvCD1eA89qF7OLr/9Y=;
 b=mV6T6VlUxQ04FcRtt8NKsK3uE9Hzmi8Zbt7HxbkrGeF9GzSWOSu77BTupwddimhHwaZB4V7ByNFk2AksxSI9jsyQjMhORWlaicMhU5LFSSM6v3dEGdphaD76hFoQygL+MJsedf5vCzdtuX6L956aYEVMpLlEC4AKbavncX3KfJFPAMxEJlzRoR5fAeQYU03nRyVq2PVbLM7lcV2F22rWx9CE9bALu3Pyox6RSriKdpxDUXg08WQwjWtluRpQaPdapSfSINjeNEtRoFoGWt1sJjQ0ZDfGfwgJ+221mGhpwKErl5QQ5DTtGrVJFyaKjsINrT/VsdBIZyLWoojuZ6TgOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNI7T9+GhLvxuyRegknbq10RzKvCD1eA89qF7OLr/9Y=;
 b=fD9I2iq/WM2dP7qzeBhmD1miR9okcCuil5bXT6tByGrhwoIMeAUK6SkR9e5loD0euA3QWV+sWtczephO0eMHQqGCP+zv5Z4fS/eHDYPZKeL4QhSAiwZ76G/eSfTjb5nNcp9OSMfVOhI4N9oisObCxyt0M3n+lALVA+Br/kW3ofo=
Received: from MW4PR03CA0347.namprd03.prod.outlook.com (2603:10b6:303:dc::22)
 by SA6PR10MB8086.namprd10.prod.outlook.com (2603:10b6:806:446::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 20:48:15 +0000
Received: from MWH0EPF000C6184.namprd02.prod.outlook.com
 (2603:10b6:303:dc:cafe::1b) by MW4PR03CA0347.outlook.office365.com
 (2603:10b6:303:dc::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 20:48:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MWH0EPF000C6184.mail.protection.outlook.com (10.167.249.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 20:48:15 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 13 Jul
 2026 15:48:11 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 13 Jul
 2026 15:48:11 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 13 Jul 2026 15:48:11 -0500
Received: from [10.249.33.93] ([10.249.33.93])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66DKmBGN3065718;
 Mon, 13 Jul 2026 15:48:11 -0500
Message-ID: <18e4cac3-2cbe-457b-a7b7-9c84f9103804@ti.com>
Date: Mon, 13 Jul 2026 15:48:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpio: pca953x: Add GPIO settle delay
To: Francesco Dolcini <francesco@dolcini.it>
CC: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, "Francois
 Berder" <fberder@outlook.fr>, <u-boot@lists.denx.de>
References: <20260710230409.147210-1-jm@ti.com>
 <20260713070752.GC13102@francesco-nb>
Content-Language: en-US
From: "Mendez, Judith" <jm@ti.com>
In-Reply-To: <20260713070752.GC13102@francesco-nb>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6184:EE_|SA6PR10MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: b9ae9145-4d2d-4a1d-b83a-08dee1200fae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|32650700020|36860700016|23010399003|1800799024|376014|5023799004|56012099006|4143699003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: IO93+08a8bLZTGUj7Ti7tkHBcU8NS2SBrGEOSVr91NtlMVoa2YFs9P2ZoZ5roP8aIeoTRA6WWh3L52hiG2OcGBSwC/a7bMSIAm0XDmdKVdsQLJ9dMF14DtEHXnPkSpZ+cybikOTFDsgr+PXsE1wt2Ea5H2R0UDTet2ec0Tv2AVxJZyXzBI0vgfirobGgTvuBXn9iZuH2/rdkr+aOWbLadQkZrPXB784XY1mzvkgTwXXbiuNCViahX0DtpWw/QY/khynWXVE2xwQotKMoqSsfrj69Y0GZLW87ULUyWhuKt7XADUoi5DgO/CTrBRU081sBvTSWc1x50i7TmZ3LgYVhwEN/+0IMjqODw5NbmUUZaFxyuJU2XLEkI+Dz73/kF3JSfnO5hyBr/LBbuWfZDf/tiF1ywMg0DdWanZI1MmHfXXJHEwI1Z/tRrYBHrS6C2ULR+zpoBQIiXx5ZVxfFsPHivfX7gaSTaHodMiRRNhBsLvwyk9N1qsfZVDxvHxNr3cVp+lkaGyOR+qVLfTjVHQhX317rRUKbiNRX1OHZ1VuUTUNzzoXTvU53l6ZGmwFJquijArug+QugWDFGDlM6bSLU01hW85enzhyoe2088rKkXNKeaKZ7R/cfx2R6mzyqB/CXTUSJP/615WtQyPFgtwTdVOdgZq53zuuQsrNpL43LS2OINzx1ZD5C5EUth4UVMdTnsDRAupFRc/4nVWs+VSuvvw==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(32650700020)(36860700016)(23010399003)(1800799024)(376014)(5023799004)(56012099006)(4143699003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fmWWRT0L3hBTeFswosBm//GzKqK77CzHQZW7A3lgtvZcdCtK0tybAWTC+s5ezFQ5VrEaALFrpgKo16I3e4E1FQeg7MsLkpy2N+rQ4chZUGH5atrG7ZMa04lJeQ6LxxOzUes/owirBbTQiFT4rIGgeiYUMjZfRiHk/U1HjrNlXiEuU8Cf5jUQnXwTV9Hw0xDm5Ir4fRTjj+jenW4/1ug6wU+oEIJLtF5HmrZj6yp4RMD8EiwD+XbA+ks6kyKtOwKBwW2A3Qn3mWWbP4rgJn2TkMPVVafFftXcqRlVVVvbBMyVNOUK68z33MQutS384d6b11g5+TAyi8A2uEzZuguymZ3W3uMR5IXYf3yGSxSGWvTiYKqFmE6QWoNrpEcVZ0tMqgXOjLqXmZY8ZuLlyhUYmNYUF1wrMOKJLAEsv1p4IYO85niiEyMM1o25lJu2rjgE
X-Exchange-RoutingPolicyChecked: EKeTR6FLrbBT+kqgX7tBo89zL3GxCwZpKo6cYO15jXSFLxOWyHEPS/tPH/fAT3X0yCQduyWKIrXK6JJxsZpK1JAoN9sJooRFmwbODJSYcD7uHAp01ls8t/DYbFvLXU9YP+Qmfwny0TfTyAM8m0CzTVsJJSbe3L/UO2AzqjYsDVLVsAwyxUckojea1Iy6AGGQcx9To09DUepmDkxLw+ncOn0de9KSjD7ck1ZgrBgFN0m+xMygjTF0rrPUer5oXQQ3MB12/aMcQP/3q3hGVIerHouXsCvPz3Zar0HHpQ6yQyZbTmYGiFyg1kAxLAaW7t38Ti70Ol9eA8L9YvV9q8kRcg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 20:48:15.0208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ae9145-4d2d-4a1d-b83a-08dee1200fae
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6184.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8086
X-Proofpoint-ORIG-GUID: 8kcNHJbB-SjtlZxdS-HHJAGffN3U6oGh
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIxNSBTYWx0ZWRfX6fs7wD5T3LCk
 mTeUlLgFuB9vAzbfdbjQimLNjSNUGZp6iSevgqx4IJF9avZRtKgB9s4GQ0O8AFUXZ7eFkiPWIOA
 KsTioKhz6ERl8Q08UTAQxyTdScFhWGQ=
X-Proofpoint-GUID: 8kcNHJbB-SjtlZxdS-HHJAGffN3U6oGh
X-Authority-Analysis: v=2.4 cv=S7npBosP c=1 sm=1 tr=0 ts=6a554f15 cx=c_pps
 a=LBR8CsJoUNkXwF8+XrmcNA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8
 a=ZZiYAlpUqm_Rytx-CAYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIxNSBTYWx0ZWRfX7/fbn+IU+mIK
 6gd2WfnQLG4QrGV1t5IptGQhyPdpmrHxROwK9apr3KNwJxfXz6MS/X2/lkpPlYawe0wAsR6QWdE
 7HhTg2G1RFfLQSRPg21sTcdRiBzovYchH4CfWrP3mAo0KJJR44LfN6NDSA2+lL0czhOWUtq3ToI
 58j8Z36hgq/Sckf5YiBUhJUaDjdFjFszvz0JyVvik+SqPOgrdm24HktNh/7bxLT+ZM13bC2mpfu
 sJs6+zRk068XFpZ6ubde3fbJa8MflmGkS+x9sdpQSsg8zvaCspX4+u7Z/sfA32ICiMB6mQIsKcb
 QHlIe+Jd3P01SgQmKPcu2vF/S16Tryyb9Wtw7eT2fT6gNutxg9SbRY8kRjCT+FKLV4Y9KlluBpZ
 JW1Fr2E1EusFF/7MyUJ4/0QzauO+njdxNRUvVL+UTmezF1W3IyD4j+dXmStCcAXXlU9UodxKjco
 6QGxQpj0Sz5PNXW2q1g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130215
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

Hi Francesco,

On 7/13/2026 2:07 AM, Francesco Dolcini wrote:
> Hello Judith,
> 
> On Fri, Jul 10, 2026 at 06:04:09PM -0500, Judith Mendez wrote:
>> Some board designs have slow RC circuits on GPIO outputs controlled by
>> PCA953X I2C expanders. On some board designs, pin voltage transitions
>> can take significant time after I2C write command completes.
>>
>> Add an optional "gpio-settle-delay-ms" device tree property for the
>> pca953x driver to add a delay after I2C write if specified, allowing to
>> compensate for slow RC circuits.
>>
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>>   drivers/gpio/pca953x_gpio.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/gpio/pca953x_gpio.c b/drivers/gpio/pca953x_gpio.c
>> index 965a5fcf30b..54b957069c9 100644
>> --- a/drivers/gpio/pca953x_gpio.c
>> +++ b/drivers/gpio/pca953x_gpio.c
>> @@ -333,6 +339,8 @@ static int pca953x_probe(struct udevice *dev)
>>   
>>   	info->bank_count = DIV_ROUND_UP(info->gpio_count, BANK_SZ);
>>   
>> +	info->settle_delay_ms = dev_read_u32_default(dev, "gpio-settle-delay-ms", 0);
> 
> Is this property supported also in Linux and defined in the Linux
> binding? I do not think we should have U-Boot specific DT properties.
yea you are right. I guess we can use gpio-delay instead.

~ Judith
