Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5034BD68BF6
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 09:58:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACDD983C54;
	Thu, 18 Dec 2025 10:58:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="ePCG6f5h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2E9A83D07; Thu, 18 Dec 2025 10:58:54 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CFD383BA1
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 10:58:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d8k3TeW5nCeLcpIbjViD3igqs/xBDifb7GDubZpPV2BxwNVbEBlFnZ6AOIWbaoDhd6dFKJXpI7ngzCziE7RjPHMqYLtd21QUALIV6xqcw7Krm0oPDZ+MvspAJ/35PeOW8AhO7coD88JR5nRUuzdMD80xZvwkuFjwKqTys7mHSxmFyfAu6JM/dF5pSjiGqMZSGuqhWeaBp585bEmG9y2SztRjL6bBHYDiEISpoXQGJD9BIymoD8x+sGp2kFD8Y6tyXBpQEbjGINeqGFqcuBWrSo/87Wdct2VSCbTb4fGVO8onVDCDjccMME1qOwgM3QmJo2gbfkI43DsD0nivxuUaKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3s+F8q7MZB+4v/gFTg0Q5HwAd63jGPvmHFU5wieJqh4=;
 b=dabBEcw4v/sNBxurMz6hH+mrznHI3QPT8kcKwpuhMYEmdLokf0+jAX+SNxgnvAEtqUkvhNLNHBhqs1baPU75enVevHpT3XN4s8C1fGeryXmz/ZvvqA+1wuI5H42+LiUp51zJ5vMcO5nU9VEmWVpF5imLVGqzspZ34EdoPd2Kg5jFXjdopCwhWsevOXWRDxLXQusLLoE55YqsblqFhLtwTECCTsIoxRcAcRpEm1TRBNnjvGfvV2J1L45hyB4ChiE/aL/4UhWFW8kZbWAJve1WlBFtu+vwcH6oSOnLDrhp0b1XXm/+29AHBv9vKZLfTBIE/wD59NKbnjP+/g07b4Ftyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=mailbox.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3s+F8q7MZB+4v/gFTg0Q5HwAd63jGPvmHFU5wieJqh4=;
 b=ePCG6f5h8Fa/5hC6tyzt0Z0DtyJZrYQvt/vTATL07oHhfwtMY/lk/GWY4vuzyclB1vXJtWmNvRLg+S09O8KmN3UudZ+k6NhgAFvvFOQUbH7bg9kJ2+4UxNi8z2bScI4/T2xY+s49YwVLpN5amukrfmAqAQa3PpbkNSxLRVEvVHP+sBjbrLDtRwfO2zz1v3aO6BR2YayKERVrq7omJRlcgBFt7RXyO0pUCISo4mSy72byUmtwKVfmt16UQ3SA0OvDMPkHTGE9YfXhl/KA4YRuXewLyybB9qtQM7zLclhTBq1fYFycrdpQ9cmtLCecIuDqFOzVH3RDYoYPBKQmVIU9XA==
Received: from AM0PR10CA0005.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::15)
 by VI1PR10MB3280.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:133::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 09:58:49 +0000
Received: from AM2PEPF0001C715.eurprd05.prod.outlook.com
 (2603:10a6:208:17c:cafe::e2) by AM0PR10CA0005.outlook.office365.com
 (2603:10a6:208:17c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Thu,
 18 Dec 2025 09:58:47 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM2PEPF0001C715.mail.protection.outlook.com (10.167.16.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Thu, 18 Dec 2025 09:58:47 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Dec
 2025 10:59:32 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Dec
 2025 10:58:46 +0100
Message-ID: <4255b341-2a03-4ca3-bc33-45075d0fb80c@foss.st.com>
Date: Thu, 18 Dec 2025 10:58:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] clk: scmi: Fix priv initialization in
 scmi_clk_gate()
To: Marek Vasut <marek.vasut@mailbox.org>, Vinh Nguyen
 <vinh.nguyen.xz@renesas.com>, <u-boot@lists.denx.de>
CC: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, "Peng
 Fan" <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Alice Guo <alice.guo@nxp.com>, "Patrick
 Delaunay" <patrick.delaunay@foss.st.com>, Valentin Caron
 <valentin.caron@foss.st.com>, Kamlesh Gurudasani <kamlesh@ti.com>
References: <20251218-sqqs-v4-0-ff95bf2062ab@foss.st.com>
 <20251218-sqqs-v4-2-ff95bf2062ab@foss.st.com>
 <93f17cf0-542c-4c0c-a97f-40dd328afd5d@mailbox.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <93f17cf0-542c-4c0c-a97f-40dd328afd5d@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C715:EE_|VI1PR10MB3280:EE_
X-MS-Office365-Filtering-Correlation-Id: 17b6f950-63d2-4302-8c51-08de3e1c09ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|7416014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VDNTQ1hxTW92TFVtZWxVVDM0akh1ZlNBKzRxVkZFdmEzUkhlOEpWREVFRXFH?=
 =?utf-8?B?Y2ZlSVNkTFRaNmY4WStUY0FyRkcvS0FsU1p3dEVhZUZCRHJpRVlXWmd1ZXpY?=
 =?utf-8?B?b05ON0RFQU5IU2NNWklFWGpWeXNQTmduOWx2b2gwYndjYzJEdU5KWTZ2YWdz?=
 =?utf-8?B?NVdUbk5JRkpocFZDd0YrYjhxMCs3c1VaVGYrRFgxaXQxSHhRV01SeDBuSVhL?=
 =?utf-8?B?OW5JKzdmVlE4MHZxSTFodmE0U0tTK2dwdGR6eGExdnI1eGdzMGo0NVJXc1Mx?=
 =?utf-8?B?azU1bnBENW45UUZ2TmhweE1ncFhiZlFQV1J5UGlMNk5ONFFzZUhCR21BMWNE?=
 =?utf-8?B?YTUvUVhGSVErbXM5a2JNQ1pLaW1vZGlUdHRLc0FDMU9HZ2NtUW9IS2ltRkZu?=
 =?utf-8?B?VU54SkRLaTVDeTlzbENGYzI0eTI1M2tBWXZKR2JwVk1tTnpMd29kK2w2c0RP?=
 =?utf-8?B?d213NndML0hYUDdwKzBsVnBSU3IwYkxyM1YwRzZ0K2p2QXR0bkgyRUJTWUtN?=
 =?utf-8?B?ckFWWUl2M1VpYS9lMVpZcllVVEpYNzZWelVYYTdLL1JXOERZOU9JWkgxTUZ6?=
 =?utf-8?B?bkE3WHE2Mno3L0UwSzVLeVVRWVoySVNMVW9HajlXdG50ZFJCb3ZvUXNaeFpP?=
 =?utf-8?B?SDd3Y2haYjFJeFBuVFBRaTNnV2E1TWZlOEp5RXltVHQ1V1FPajdhN3hlWU1W?=
 =?utf-8?B?cHZHMy80cXZZWEIzYThibVZZcDNOV0FXeHlLNDZZS01SNE5NeElOUXdKZWRz?=
 =?utf-8?B?YmZxY0JZOFZkbGtaRURqai9NUjl5cy9MS1k3ekE0SE1RenBiaEY1SFFjOUUv?=
 =?utf-8?B?aEZRanQraUFVWklmY1RCNGZwTlNKdmlzTC82R0JybG1URVlMYlhHYWNNUkdE?=
 =?utf-8?B?SmJZYnE0SDZUMll5MGNHdkg0RFFoTE5ZbmV4MzdOVlJlcjZMVWFkUHVZNWI5?=
 =?utf-8?B?OHBDVFlHbWdhZ3UvMUlTbHRXaEhNTEpSUFU0R3RjSzNXTVhDTnVvTDFQVER4?=
 =?utf-8?B?MjMxY3lzVStoVVZ6ejliZVpZQkVmMVoxRnRGbks1QmNqUlMzZk9UcTk5dFUx?=
 =?utf-8?B?anZOR0FLUmRRUDhneldJbEhabUpBcUJKVHd4UHFiZ0hrU1IxbVlyR0dWdzY5?=
 =?utf-8?B?RlhoOG1KK1VGUkV1bExjL1JKdlBONnlJZDJDTGRMa0Yyem5OSWUrTDRiR0R3?=
 =?utf-8?B?THN6NDRFTUx6MjlJcHB0WDNoZnNyQm0wRXh4Mmx3WGJvUUFvaDNveW1FZmhD?=
 =?utf-8?B?c0dTWHMrZm1lNmlSQTlUUW5Jc3ZDVE9mcnBPMXkvekJ4ck5rbDJJZ0lzcHFM?=
 =?utf-8?B?aFVtdVdHRnFoN1FncEdOUE1EUlk0eU0zNVRBdnpLaWJsQm8yT0NNV0tJK3Ro?=
 =?utf-8?B?K3p5T0xONE8wcE1ZNFlOdlNsNjdGaytjOEJGWE1lbm9kQzZVMEpFVG9ZNy9l?=
 =?utf-8?B?Y2EwcVordi9MVFY4bEVlYU1TZmRzMzhWQU5RQUtDTGpRdU51bEtYdU9FRXJj?=
 =?utf-8?B?RzlBc2R0YmVaTmF2ZXBCRmdiWXhzZVdIUjEwc21ZU2ZBRzhVZWNMclZlUzd4?=
 =?utf-8?B?L0d1Uy9EdnZJWTA4a0txYnBQUkQ1aEJsakhCbGpleHFLTmI4aEZXazRmN1dm?=
 =?utf-8?B?djNrOWU2ZXlNd0VjaUlkQXJSZ3RuUWtLOGhCUmg1SlJkazNnUEVmcWJMNmFh?=
 =?utf-8?B?OXpDVEtlSTBEQklQZXFSU0VvTDhsMVVIS09wd3IwWDh5cjFNUloxNElZUTRa?=
 =?utf-8?B?V1BWZG5TN3RZeXBCSmgvbU9ySmNrc1VGTnNOTlFkcWZyaXRJK1cyZVM2OXhZ?=
 =?utf-8?B?NXhBUFk2TkJxNzhUMTlxSXhCRlpQQTR1UytCZWYwOGZKU1BtazJkd05XVmpK?=
 =?utf-8?B?Um1hWW5ZeUc0MHE0Ui84OFgzQkRPbWVobTY1VjlvYWhiTWhpLy9CbFNzVDgy?=
 =?utf-8?B?dXVqWnorNDVMSFduZ0NZdVBzZXQ5aHhNeWlwK0gvOXU2OTVKRHZ5YWlwWU45?=
 =?utf-8?B?WXpyUUpXQ3FJY1pnQVdNdm9FZ1psTWVxdEY4SDJjN3lHNXhQZnJndHpRREJM?=
 =?utf-8?B?anBNbDVtZEpObmk4cGlFRTUydVdCVlhzVTByQ1d6M1QwY1VXa3ZtWm1PQ0pL?=
 =?utf-8?Q?3Das=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OlTXS09t+ZfqhXZFBBQfsiMceIbECHGIFYM/ZHm78Wl8nknl+EsTZM9BXj7xYyA+4un+dE0E7mexWz6IgIhn+SgNGZ63FPBTSnRbBLyeluRqaISeGnr9jfkO9kZy/iVxV/XQQ617tmoBqMX5kTgo+NKv6B72tELNRLvCP1hVFCVi8zOJdqwE1qrDNv0PWj1CsgT3sQnV+Yau/KD+aE1wOKY/64hFUpEw7Xq2z5DDpZRI1116NYDzCbc+V1JtkAxF81ZL3IW+XlHXw1tGyK1m863Iq7N0IxdPg8MQ1I9eNGXMrDyEqb9TXUAG+WHmBkUCMOVTllPoDNbJH1drvyWZ3fVUMZHHfdXEAnve8ffPu0SCTJcRdipsr1gOx+rhHNR1MTtTNByAfJiJFAUc3j0DI9DEUzzye2A1etNy66rePxXLHXqBSatYjD+L6cvZVbqY24I9tdg7AGqS3qPyZgm9qrDlSjQdqClnTfS53q/RXU6jAP70HiOm59x7F2zc8v7XZ71R4/HsOY+d75BoNodCA5D/xDnDwzW/ym6cSd2aoz0tBolLQiSEL6jL82gzdBOvsrJXk210GbCxVN+OZIReAl70gmy8aiyyzRVa3VGjPrubP/UU1qG8Zt9P30VM8S5TC1oSfCCSBdylcoN2ET6AAIT6pXIkAnpQJAJH4NW69FgMMdpYX9ANp4t3AZ7ym9KArIgxcOolmzmgSzIbBZYbWw==
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 09:58:47.5554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b6f950-63d2-4302-8c51-08de3e1c09ba
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C715.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3280
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



On 12/18/25 10:13, Marek Vasut wrote:
> On 12/18/25 9:26 AM, Patrice Chotard wrote:
>> In scmi_clk_probe(), in case of CLK_CCF is not enabled, parent private
>> data is not set, so in scmi_clk_gate(), an uninitialized priv struct is
>> retrieved.
>>
>> SCMI request is performed either using scmi_clk_state_in_v1 or
>> scmi_clk_state_in_v2 struct depending of the unpredictable value of
>> priv->version which leads to error during SCMI clock enable.
>>
>> Issue detected on STM32MP157C-DK2 board using the SCMI device tree
>> stm32mp157c-dk2-scmi.dts.
>>
>> Fixes: 0619cb32030b ("firmware: scmi: Add clock v3.2 CONFIG_SET support")
>>
>> Reviewed-by: Peng Fan <peng.fan@nxp.com>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>> Cc: Alice Guo <alice.guo@nxp.com>
>> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: Peng Fan <peng.fan@nxp.com>
>> Cc: Sean Anderson <seanga2@gmail.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: Valentin Caron <valentin.caron@foss.st.com>
>> Cc: Vinh Nguyen <vinh.nguyen.xz@renesas.com>
>> Cc: u-boot@lists.denx.de
>> ---
>>   drivers/clk/clk_scmi.c | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
>> index f6132178205..a4fc4f8da89 100644
>> --- a/drivers/clk/clk_scmi.c
>> +++ b/drivers/clk/clk_scmi.c
>> @@ -137,7 +137,7 @@ static int scmi_clk_get_attribute(struct udevice *dev, int clkid, char *name,
>>     static int scmi_clk_gate(struct clk *clk, int enable)
>>   {
>> -    struct scmi_clock_priv *priv = dev_get_parent_priv(clk->dev);
>> +    struct scmi_clock_priv *priv;
>>       struct scmi_clk_state_in_v1 in_v1 = {
>>           .clock_id = clk_get_id(clk),
>>           .attributes = enable,
>> @@ -156,6 +156,16 @@ static int scmi_clk_gate(struct clk *clk, int enable)
>>                            in_v2, out);
>>       int ret;
>>   +    /*
>> +     * In scmi_clk_probe(), in case of CLK_CCF is set, SCMI clock
>> +     * version is set in dev's parent priv struct. Otherwise
>> +     * SCMI clock version is set in dev priv struct.
>> +     */
>> +    if (CONFIG_IS_ENABLED(CLK_CCF))
>> +        priv = dev_get_parent_priv(clk->dev);
>> +    else
>> +        priv = dev_get_priv(clk->dev);
> On your hardware, do you have CCF enabled or not ?

On stm32mp15, CCF is not set.

> 
> What does this print output if added here ?
> 
> printf("clk->dev->name=%s clk->dev->parent->name=%s\n", clk->dev->name, clk->dev->parent->name);
> 
> I think it should be something like this:
> 
> clk->dev->name=scmi-325 clk->dev->parent->name=protocol@14

I got 

clk->dev->name=protocol@14 clk->dev->parent->name=scmi


