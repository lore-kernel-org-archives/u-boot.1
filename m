Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF1FEF36E6
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 06:48:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9307A839D5;
	Mon,  9 Mar 2026 07:48:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="KYrGPbmj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84008839DF; Mon,  9 Mar 2026 07:48:11 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B32383952
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 07:48:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wAokBGc7Ny1NDhWDm/E3+af6EINmDqoVdybjQraqzXqXdvVW6ZZPpaT4/AMxVep1/zhBT7SkYfeRelNHjtYUSlV6Ff7URcVEUrVphAjfSn01gMIPTnXzP6a3h9tDLTsA47reFdLvDJBO4Qtuu5kpbr4qcpIBC53HjLRd6pO59Uk70CCy41lgTj1bf9F4JdqXaGkx7x5yr0vaqGy5v/RWEE2i8FkvUsOrekEEH43Qb8bKntPWatYimmNORVcVpZ/bcmCqeM3gpIDCO2QKTK+tZOZ1UXzF/hXtoaMs+OH/ocUh4G27kS/9bcRydTfIZePdpafqahJzjfCqI7l2CFl8WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rg5eJpnyOeZZVbNnIb2F07KZhI8KuHxTtiKSCiVZ4ik=;
 b=H+Z/3hsWUXhS3xlgJcjVAb83dAZO0JCEp/yfcoR6En/baqeV8bTFOCtfm3krSkqqXMkeLC8S/UXYAY6otAGTukQRuLiIyBsZecLBJhcb/2hmk0NJoLATQKK9wZShr3YpAOt63d91dGwMX9yWQkY8cMtZkgIQ8uMdN7SspPrCMHLbt9hp0Kcy4zBDRL1AKCJcZBphIVC8RNtBYTw01cBqqPSQU/OLaRqYicjMthtwC/K55FWEDom9qmgqhnla6c4eVyEJDENVfzTNpPOjUhJtTTKXwODeaiaN0tNKG2dRRyp7VyWBpyoVAC2xr6j/VhgI+7xZe5dZo6uPKNNhihVEDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=konsulko.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rg5eJpnyOeZZVbNnIb2F07KZhI8KuHxTtiKSCiVZ4ik=;
 b=KYrGPbmjh9HP9RyQ8bak1SFJM++VFU3CLykHRArEdRFWVg5CDec293WrJcwQw46Yn+F3j8zlFfgqfPecY5xhZpO0+grPwnPfdl6sYM7sxXPW4eNWs0I2oDsJy4ruxcmfhSjZmvRN7GLIpvh8xFBuvKYfvcTsUCJzRlQ9v8j6uUW/q1kypFyby5/YwPNiZIl8nNiOelx+q4XXJCFL112lp/VAtouB6kfXpLx0l6sDPxXaVBFAJfKDhAkJYh/QgEVhRGjlTM/lk09NjZsv33aBvxbGrS7X+AsePfPyoPcfbYNNigHD05PdZQ4PgVYOhjCbnwi5BJ3clQG8mmQMM97a9w==
Received: from AS9P250CA0017.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:532::16)
 by GVXPR10MB8988.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1de::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.24; Mon, 9 Mar
 2026 06:48:04 +0000
Received: from AM2PEPF0001C716.eurprd05.prod.outlook.com
 (2603:10a6:20b:532:cafe::4b) by AS9P250CA0017.outlook.office365.com
 (2603:10a6:20b:532::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Mon,
 9 Mar 2026 06:48:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM2PEPF0001C716.mail.protection.outlook.com (10.167.16.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 06:48:04 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 9 Mar
 2026 07:50:17 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 9 Mar
 2026 07:48:03 +0100
Message-ID: <c81042f6-4a32-437c-96df-74d5c8c73622@foss.st.com>
Date: Mon, 9 Mar 2026 07:48:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video: stm32: dsi: add .of_to_plat callback
To: Tom Rini <trini@konsulko.com>, =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?=
 <rgallaispou@gmail.com>, Patrick DELAUNAY <patrick.delaunay@foss.st.com>
CC: <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>
References: <20260205-dsi-v1-1-eb5805068e97@gmail.com>
 <50a9f6c3-4284-460c-a429-49b4a53c836e@foss.st.com>
 <beec85d9-a580-4ae3-854d-3c957b888eb2@gmail.com>
 <20260306223317.GW1388590@bill-the-cat>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20260306223317.GW1388590@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C716:EE_|GVXPR10MB8988:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cc73dd1-e10f-410f-c6fd-08de7da7d077
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: sv8s71qWZt/aZ82+MTigxOQ42IOzjSJKyQdllX5Q+RgL08g52e4jc0PzRPB4K2b1vS8a2WJ377JruGtn9WpM//QP8jZviK7sNv79gWcMXM+GwK4nEWcGJO59Dpjt0jz/zF+VBR/cjqmiWAE8IZpsR5+wXJpAjhm/Fm/XEPa/hS4yBYaTjXdOJNHk3by6PTiKUfpvwp3AEo0oP6b3CBqPxtWB/NPlHH+aW82/6dfBwSd1YrdXM6BYlqTVwLK9ynWlOORSry33yWR2obhnEB2Fbe5UoVy0PdiTDFp+K9e0QhbUJ/HnlL+d1Rt1BCNCotJe/oO/2HIzjsUZJTriK2cMU1vOPJTFIjSKE2RNyuI39/pzXS/89urwGh7fkOYpkEYpQTFNUvTyqyWKprXoqF5OmwR3Fsb+h4yGPqpeU3+XWBt01CYRi6xvPGNulUvXyIjtpRxtMa/385PKORZkDhzUc7yg3M191v1324B6kstKGNSp57UWu9/FnNNi4e1AVbhCZ0KGLyfv/fPlWWtyNlfNVbsNevSremOgYoj/S6Rk+opkFH+uA4bZCrPqfPXuMQojLrLuiNO6ULKGC5kqt3U8pK6yQLMEO5so37b036eI+YWg8XxUGyLYMSYzvIcM44LijcYvZgB1JDEAMMiY/s8H0pR5KUfTwMfJXVgLLTgukiV0uFPo1T5KlVkSmxkVd1lEhLv2QeVO8c/GcoPMAJnlUe2BvB+HURH6GN4xvZt21WvzsDRyDyVUrkiX1Xxk1aOa5muJPY6m7UTqJMQOWq+FjQ==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PvGb/5yX+YBIMIGqcjKiYLql5ND6s9/CS2Lv+M+xXV/XhLhvT6xRb0q/SdYpHWePi8Nu1hGzeHM82M+vegj54rup3ly2GR8QocWpDvL6woUlVBNWxY9LEgttMg8VdC+vu53bBbzevO6huYJrPzg2jB9ZM5c4EEyMXyt6s5t9cezIN2l+/8y5RwOf4dNKk85sy54pTrNg7jkHUybQyP/hiBEJ32ptwRWfR7iiICiB/OOlUFw7RQB9QhZ6Jt9Vcr1Yu60YfcorOsnDdFwDj7YXQiFCc3FVeowA4eGgJhOpSe/YfjFhZLn/XB7V9Fz7l0gUlKMQVksHEJ6PeDzWv+K4AAJ8+IKizl0QgcfXmOZNUh7jR2iw0sYbC8gNscawt8q82z0mPNnYqDVns+N/mGFYmXDEEAkHTHxSz9tVGR9HQ/jxcWnNDjxNZJqeyYLH81JD
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 06:48:04.2863 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc73dd1-e10f-410f-c6fd-08de7da7d077
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C716.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8988
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



On 3/6/26 23:33, Tom Rini wrote:
> On Mon, Mar 02, 2026 at 05:23:23PM +0100, Raphaël Gallais-Pou wrote:
>> Hi,
>>
>> Can this one be picked up for v2026.04 or is there something I should do ?
> 
> Patrick, Patrice, should I take this directly or is there some
> objection? Thanks!

Hi Tom

You can take it directly, 

Thanks
Patrice

> 
>>
>> Best regards,
>> Raphaël
>>
>> On 2/24/26 11:01, Patrick DELAUNAY wrote:
>>> Hi,
>>>
>>> On 2/5/26 00:35, Raphael Gallais-Pou wrote:
>>>> Drivers should extract device-tree data before probing via the
>>>> .of_to_plat hook.
>>>>
>>>> Implement it for stm32_dsi driver.  By doing so, it also solve a
>>>> variable shadowing in stm32_dsi_probe() where &clk was used as
>>>> peripheral clock and ref clock.
>>>>
>>>> For readability some struct have been renamed such as:
>>>>
>>>>    * struct stm32_dsi_priv *dsi -> struct stm32_dsi_priv *priv
>>>>    * struct clk clk -> struct clk pclk
>>>>
>>>> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
>>>> ---
>>>> This patch has been tested on stm32mp157c-dk2 board.
>>>> ---
>>>>   drivers/video/stm32/stm32_dsi.c | 168 +++++++++++++++++++++
>>>> +------------------
>>>>   1 file changed, 91 insertions(+), 77 deletions(-)
>>>>
>>>
>>>
>>> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>>>
>>> Thanks
>>> Patrick
>>>
>>
> 

