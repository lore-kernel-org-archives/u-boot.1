Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280EACD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 06:42:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C14B846CA;
	Mon, 11 May 2026 08:42:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="MCtcS0oJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6455846CB; Mon, 11 May 2026 08:42:54 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 705F2846B0
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 08:42:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5Q73fsqfA8Kors6hr0hYysPlN3cRcIYro86DD9Evxm1mzDuQAUmwDsk9KkpD2RS8BF6pN8QSrpGVpkjpn8OaIEfC1KPf/+JGh3SgcpDG/tLUwqR5Dl/Yaa0qCJ51QkUcCdeNzr67pQ5f7eNBp9YfZ7Wqxh0neHympsH9na/rwg6WojOJbYZoYVHvqHZWgOZdcLYA73ZqXUBr2fYIDxBEL6xUwunKlTe0vKd0kddyEtBtu/7bK3LtqAinxdzQwnNBwwXHjyozdmKRDiMLVPm90GQVR3FJbCgxqrMHGORjdp+DY6V6uRLMmb/ernAerJD6Cf4VKrHEZTpr0l3blahnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8MgsZfMqaNBVuBwuacZ186/OetJkSkYFTRF4lgph9YA=;
 b=qVE2V8N/gKBCRGOVx82XpJQ2zKgqPbVUySsL4+sqlj1WQ9E2coGcwuFkKYrDdlR9ylYhvGnlt6HrZIKwLpyNF525IJrrJrUcQP08Zpa5LiWpnyxbeTxGSg8dpY0vn8A4a82u4aTED+BUUWrmoS9pnVvjxZqf6fEdSpK6xW2/0wRu7jUoxo1m3XXHaWG4u69Z+k8tSq7r4zfrBEf7MQTi7J+zg8ypgKFrK7ldPN4Dew5ljoSkONsJnt2oAQ2Q8OpSmPIYlVDAGXq4SYb0xA38be1Y21cuiYxGnyzVVtQqNHzeDmxklMZ5oT32xhR3ztL+n5p9W3nDvNZ3iRcn6l0pvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=mailbox.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MgsZfMqaNBVuBwuacZ186/OetJkSkYFTRF4lgph9YA=;
 b=MCtcS0oJWollYC4m2W+jZhfefIpthuis4Faa1Hd9QJU0NaZsWIk4Ng2RoezNLm/R8qXaMU2X2WN2ciHHJJEU8uABS6Pj1KqFuR/dHd6JSqyupp17YUwCMfik5qHHllJSaAbS+JPJPIaEPu1ceWcDsr56pyeurao6wrPA+S6SgABR5Glurdp5anmBFKnUTxVKORFOgR+YEZ0UVuiaLfQbHb0F2Ue8RPljF/c3cp8cYsmsvnejciv/KfKw4Y1YzSXUqOXL4BMbxpbBafRMbw5Aw/i66qzq/UYgNHsyv6yMHy7atXCg00fR+OjYZe8dSd5yQH1KtkOZHjxGJB62z7xTjA==
Received: from CWLP123CA0117.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:5f::33)
 by AM0PR10MB3348.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:18a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 06:42:48 +0000
Received: from AMS1EPF00000090.eurprd05.prod.outlook.com
 (2603:10a6:401:5f:cafe::84) by CWLP123CA0117.outlook.office365.com
 (2603:10a6:401:5f::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 06:42:48 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF00000090.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 06:42:47 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 11 May
 2026 08:46:13 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 11 May
 2026 08:42:47 +0200
Message-ID: <fc9c4c3a-cc8f-4f68-ae32-f867cc5b3a99@foss.st.com>
Date: Mon, 11 May 2026 08:42:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] mailbox: stm32-ipcc: Staticize and constify driver ops
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Tom Rini
 <trini@konsulko.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20260507220651.209168-1-marek.vasut+renesas@mailbox.org>
 <20260507220651.209168-6-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20260507220651.209168-6-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000090:EE_|AM0PR10MB3348:EE_
X-MS-Office365-Filtering-Correlation-Id: e1833256-d69d-4a12-014e-08deaf2883ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: IcK5hlXNG/q3AuouxBkf6/yflWSBg59XbgZuLWqU2VhyMDQUta3JLv73+BKfz6YeiXgGLZ8t+M3vr9hqqZ7ff2yAbSgTr2VivixRB+zD02E91j0c59fE3KXZlw//xeqBTf9aZ0tTmDR3OBfBw8IAQcFYDyD5yjfQDfOf1EXtoc4Czx+7IfT6M2b4HXBPQ+42YqBo7nSRAdJY424d8ZFQvIaNBcMQfSBBirLTlmeSiNq/axPzeUh5v/+atcT8pymYwDoT0i3LP+IsqyzLSGyLwx1eYZwEB+vNAnyWz1aBAlqpRohYAQ+E0Dgs8Q8KVDhhjeeizaDlC/pD/Jw2gn75GhITN+PD2rmD5rJUrKZEWqrqldqyOITC892nR7Av/MsEQ9gUOO7iHy5k27cDholqz5RTL5UxnJktqjTTJNBxSs89k6Abz3+FcgRDQ3Fd4z+SmNiQEYRf6WXYy3coXv9+2BnC/xQYbY1RzfxByqOYF5Npx51LZ8iITJOQ9ForINCvHA1mtUYsNSLYtIWWrXeikqpOu0qX2cYkri7gqzJ0C18U7l0peL8R4KhL/i2BAZmaSQd55VmDivPp6jQYUP5MEPZ1SWHRC3nhRHuJpHffvd1Ek6/yMA+vmLJTsA7bENI5amePDbUiWKEkaI+uNMXSGSmOLR3xK37mg1wFqQLrnTpUfOsKlPve6JQcttOhUbTATaD918NTOK3ES6AaYkBADkM4vXHnvWQGKsJN5cHkN5o=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ir0IupVxx6OwJYmqD0YXN2IY8w3nwSsj0w+/y+GoDV95abBZGtNuTFo8i+xUgqH9Mci3EHU07L1uEglU3K000009stlHy/Z9nreiG02Nhcno2vBCIoK97rVureXNS7NjJQz9mFrtgDtD3zHH7kxa1DtHNKMsGIwBN6TPuJe0osFj+8137Nt1TD/DskTvhQACmoTQz/DD11IRCAyXPCEUACZS4OttRp+3yUAsvUipKHprPE1golw2557VWZEV78BQLoVyoHmQ4cZToTNIbZuOULWBm6UvaDa4DN/ERi+Sx7SkYi9qk9N2Ir5ez5kEET/hKBEnxGTF/3GUePY+Knqc0S2HqdEGA99Js0ve5uX+QuCmAVj41kEV9y55plI3hTf4SIqks+fQ5Bjfni+jp3brczMYuUuEkFa7SIVEGmOtx+nzZeKJRfU0mpkpcCp1vgTa
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 06:42:47.9367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1833256-d69d-4a12-014e-08deaf2883ef
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000090.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3348
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



On 5/8/26 00:06, Marek Vasut wrote:
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
>  drivers/mailbox/stm32-ipcc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mailbox/stm32-ipcc.c b/drivers/mailbox/stm32-ipcc.c
> index dda108735fc..49f7795b3cd 100644
> --- a/drivers/mailbox/stm32-ipcc.c
> +++ b/drivers/mailbox/stm32-ipcc.c
> @@ -147,7 +147,7 @@ static const struct udevice_id stm32_ipcc_ids[] = {
>  	{ }
>  };
>  
> -struct mbox_ops stm32_ipcc_mbox_ops = {
> +static const struct mbox_ops stm32_ipcc_mbox_ops = {
>  	.request = stm32_ipcc_request,
>  	.rfree = stm32_ipcc_free,
>  	.send = stm32_ipcc_send,

Hi Marek

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
