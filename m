Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281EA606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 13:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WykDULtk;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=I2y8zA/z
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E3599811E3;
	Fri, 27 Nov 2026 13:17:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IgZo-y1wWOVo; Fri, 27 Nov 2026 13:17:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3C0F8811F7
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795785434;
	b=kBQ9LFgFBR5a6n0dKo59Wof/5wla6klmwjogOD+kQGUK77yA4DVxfJld7MvgQrzw6Fth
	 g+z/3Ak0g/NB2asOLPRsO/EfY7SQqeN+J3yaNlhc/uOA1ULIIT2PJYWCN2zgn5qcIvTRN
	 GNAiLndQF56NrcuMwXqfUZgmkNwgUbnk8qyCurWUvxL37r6PVU4h3KmwT88LddAletBKe
	 SmU0t0TLS6SqjnQJS7xl/en77fFDdZ3OupyekrgDbWidlTDniCGG1K1sZ8ZTm2hs+KrRp
	 y/pgTk7nJUnCS/W8Bg/GRXQWWfxaO/+WgVK1Rlg/jaQYx27GqDYZ3LpfvwLYPbmSycw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795785434;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Ynw1eF8aLe4AbDk+TJFQm/gkIzxXOpdVTQdVH/1zlJA=;
	b=CWBl81+doexMhXjdu+2Ze5nyNuG1LYn8jr5r5x832FYLSlegpVg0capXjmVM8/zdp2Re
	 rX86lJ6KB+l8uOsM1zQmm//JOq4k4wPAiSLj6kvKxxhjSAXqJudJDyEFu87AqQY9xHm/w
	 wbL5DCxhPmoxDP/FcPBsuoGGB1M7npEDyjtQeKvzFXkJQ3cmlQOSRCLfMadxF9UMfdsVi
	 JugOP0AoVPIPd6xOhKvEkQCDp0XVHEILCjWXQZmInMwwdZqeR7oVOj6MMUY7nvtGkAVlx
	 Hb9HRSM+f/wHBeWL9vG865C56R4Iz/s8j2CPpe475kXe5/wkCktN6SMr7FRxUj/UG7w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b="I2y8zA/z";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795785434;
	bh=Ynw1eF8aLe4AbDk+TJFQm/gkIzxXOpdVTQdVH/1zlJA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WykDULtkQCa9p+gUb1KqyqJ+2KibndIOI4SJVU8wiEorBX3J+AmJUffEPnaQBa+Pl
	 1IILAioZ9PMz2WcnJe/llWVps0E8prlBfv+eNaRMbRaV6GOPZhbpg16t2RiYv5jTZa
	 Py/n1fUD6HBk0yddJu53dUaB4mbwCDPbgBw0fL4KXvZzkc+ddtc8iYIRGWUUYICT5b
	 H8k83FOBhHBixmDLrg7NJIn0Jtvotu2NpFH1Pc+WUXAp1y5l+jv8f5aWayjkGYkYX3
	 Iz3wZcd868aDKjamLqzkKPdGoTBDsNrzvNqtAZLTjDJD/wNtn2bvLDF+AWRs9NikJI
	 O86Jb/aChW3Sg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C0F8811F7;
	Fri, 27 Nov 2026 13:17:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 18ABA2DF
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:17:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F2C308120D
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:17:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yoSIFHoEn59S for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 13:17:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 376F5811E3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=I2y8zA/z
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 376F5811E3
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ynw1eF8aLe4AbDk+TJFQm/gkIzxXOpdVTQdVH/1zlJA=;
 b=I2y8zA/z7aEYixl5dz8qqDUGCrLXSFdDsLju11C8skndCTp2HzC/Do757pDlZoRqojrVSGGG1VMB4GaqmqWphINDjpmVX7uJCc0IQDlqgLgLa4mzvejssVvjhZdMZLl0wghYXmrDHNZsXzQ0AoD11vXLZNViGvGpJ8MyJpUu9YAbePKntcoIBvUNtbMexp8NvoOyW4eJR+/XIKws2JErIlays1UQd7ZP+adbJrw1+SMka8YQ00JwLj0/izmBrSYW6Oj5HpjJ7MwwYAbUePgY0iaZSZ04PEjyUWW/3uB+JIKMTb+q/oRftrclAsBrLkdA/1LuMx4iuZa50WHw90pQoA==
Received: from AS4P189CA0031.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5dd::11)
 by DU0PR10MB7076.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:423::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.4; Fri, 27 Nov
 2026 13:17:06 +0000
Received: from AM2PEPF00070CF7.eurprd02.prod.outlook.com
 (2603:10a6:20b:5dd:cafe::af) by AS4P189CA0031.outlook.office365.com
 (2603:10a6:20b:5dd::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.9 via Frontend Transport; Fri, 27
 Nov 2026 13:17:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM2PEPF00070CF7.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 13:17:03 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 14:18:09 +0100
Received: from [10.252.12.59] (10.252.12.59) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 14:17:02 +0100
Message-ID: <3197827e-6f9b-49ff-9eb6-14c099ebb3f0@foss.st.com>
Date: Fri, 27 Nov 2026 14:17:01 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/35] video: stm32: ltdc: stop looking for the panel
 once found
To: Yannick FERTRE <yannick.fertre@foss.st.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>
CC: <michael@amarulasolutions.com>, <linux-amarula@amarulasolutions.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Raphael Gallais-Pou
 <raphael.gallais-pou@foss.st.com>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.denx.de>, <u-boot@lists.u-boot-project.org>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
 <20261107143241.2236511-24-dario.binacchi@amarulasolutions.com>
 <64337014-f5a4-4121-a992-132f1c99a8b5@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <64337014-f5a4-4121-a992-132f1c99a8b5@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF00070CF7:EE_|DU0PR10MB7076:EE_
X-MS-Office365-Filtering-Correlation-Id: 9780ba61-f421-4df2-6aff-08df4c88ba6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|10067099003|11063799006|4143699003|56012099006|261102123227099003|261009223027099003|261021121427099003|261026140227099003|261022105027099003|261028144727099003|18002099003|22082099003|261021135927099003;
X-Microsoft-Antispam-Message-Info: LyCsApYPNaZ5dKafy/cP9dd8RG5cavj8b0IbLjQrAk+z1x/a1OgZkpbhEGtSXVOwDeREYLEapsEgUVfLLUKJ9lQAMPAYXAFeY30s74HTGBDwLKWKAn7fmrRsKRtJ8BcPQz8xETyTUTWXoKxSD5RsHKul/nrHG8G1JJY/XYlUhmeV4COWrcP+KY68YXcT/4SDKhpfCCNf2o+PCIVTsDStlr2XJOAK+BBfanIAT9dR33Inbl2xWc3HRmPeNZeiOSQpc2UvvLBLk7ngNFvlHqpJkpVtPpA5uScOkjjABin4AtGM0uQerbD9QT9GwkGe5JF/3VTPqcJgC9ASzZABcZqw5s+cWltTKzUGD8dhoPjzzDLLQSX97GVPp1eJPOwMjkVCNc60TjMw9X603Lu5dbayozJjyQiZLSpdDSut5hGrktdypSSROckOBhGAfa2Sjpb1RtqYVYEGdxiMaepcM3UGuO+XDWf8uh9DkslTk+hdZSVu4UWJYs0Re8d4683Ebp+Ir5OytniTONEo+QfMbTKUHsIqmObvOUV3GSOVu95taAWz7bdgf5Y9XPPJL8yyrC2159N8lC9u+Kfm9P+Zdhpd0zI/7lB6IwNCNnsZGa8VokcGmXSqfPWBkOjR3YZeMzoOudt7VBi3i06XyazG/gF3keNzt05IxzJc4qI2UCgcGQFbiZG83HwHOAUWv6jjMbibEJDFaATi9uv6TOIiCwSntQ==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(10067099003)(11063799006)(4143699003)(56012099006)(261102123227099003)(261009223027099003)(261021121427099003)(261026140227099003)(261022105027099003)(261028144727099003)(18002099003)(22082099003)(261021135927099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0sxlD9XUWKWLq2hSz9x5080DbQUvKl2rSrp2KyW39pTI1O18Q/Q8AzwHmi+GedBbTjk4WN7mwKzWWLisTvWDq5oI4wePCkDYuSp8AWyR1VajwSB/Mkr6utpWVJRSk1tEOfb+3hEQ0gxG0k2XKeVp4cpESkIPiKp83WUKniVI8TEmuCxhhwh/EpcWJapnWTf29JKQN6qLVVs37bSsdyhFu9wmR8j00IW2YYoyJ/qOKYIb+rYZ5UXYuWwH96rs+yFze0XdOk0KrWqlxBYit11Xu4QSX/B+QW+dwKTgkw5Crxmv65XEJxNRuLt5opW9tIuSsdV5lfS8/PD/2YQIUSiI1rk/d1mhgFOGCkPawypsjoQpdd3Ub+5TL0Q+Zi/tjdSDVXjMPE9fVW//dSCgF++KHat7Oz7Jg5YqtGueSDnlTFj8GMKJQ1Lj7HCg5qyKnjbO
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 13:17:03.6084 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9780ba61-f421-4df2-6aff-08df4c88ba6e
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF00070CF7.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7076
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/27/26 11:30, Yannick FERTRE wrote:
> Hi Dario
> 
> thanks for the path.
> 
> Acked-by: Yannick Fertre <yannick.fertre@foss.st.com>
> Tested-by: Yannick Fertre <yannick.fertre@foss.st.com>
> 
> Best regards
> 
> n 11/7/26 15:32, Dario Binacchi wrote:
>> stm32_ltdc_get_panel() looks for the panel on each port of the bridge,
>> without stopping once found, so the panel is only found if its port is
>> the last one in the devicetree. This is not always the case, e.g. when
>> the ports are added by a DT overlay.
>>
>> Stop at the first port connected to a panel.
>>
>> Fixes: 35be94614733 ("video: stm32: ltdc: properly search the first available panel")
>> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>> ---
>>
>> Changes in v2:
>> - New patch
>>
>>   drivers/video/stm32/stm32_ltdc.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/video/stm32/stm32_ltdc.c b/drivers/video/stm32/stm32_ltdc.c
>> index 7bd6724bc2a7..da580a78a5db 100644
>> --- a/drivers/video/stm32/stm32_ltdc.c
>> +++ b/drivers/video/stm32/stm32_ltdc.c
>> @@ -571,6 +571,8 @@ static int stm32_ltdc_get_panel(struct udevice *dev, struct udevice **panel)
>>               continue;
>>             ret = stm32_ltdc_get_remote_device(dev, ep_node, UCLASS_PANEL, panel);
>> +        if (!ret && *panel)
>> +            break;
>>       }
>>         /* Sanity check, we can get out of the loop without having a clean ofnode */
Applied to u-boot-stm32/next

Thanks
Patrice
