Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49AB5CD37B7
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 06:02:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD3A88467A;
	Mon, 11 May 2026 08:02:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="l/bcVng/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8000184671; Mon, 11 May 2026 08:02:31 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98D8284712
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 08:02:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2S7WmMtN/7LgBh6wPRqKHOIHYwr7LKbvxG7QMNIgDt9XXpW6qlrX1y5kFseRHEYeKaTH8/13vBMXKNMrsFzSaaPmtT5E5KsF9lx1GeYbRd65HKWRRGByywFWAkAE7RTWOPpJ9IJLFizRUHrcD1oZL7tmfpmJA1mht/d4gBo5VTMuBaUSbmkz4XNB0XFcDya7N9I18hTFoyxJ0eA6n0hYRGO/Anbc71Gl+dNDdifZMCbEUFpB9dgNyJVmsuLoGYBNTe4YjRshCOdKeKzAeAxaWezMLDUjgdyy19p1fswcRzNlSH9geQzYnbs7XmCMuqAx10HQVgVpobzaFdr7wcMhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Phagr5xYd4cAZ9zr/Ewi3adnc3Pm7U1f/jNyw1Gl/rI=;
 b=SOLM+ZiOd5bTMMEWKCEkg36bpVOs+AYlatspV4V+mYQfvOY1/51S2AF4Bm/VlCaEeDouNp+GC0axSlM3o0pfoj14+Cg5+oKc7+oKt+WSpmJTwopRGaes9y0T9b1GLK5omuNhp8mC34IqZRNDUU7e3JqD+DpiIgo5frYmCyv423DXoBUgPvP71XJ4I+Sxh0nSvD81zLW8gcfd2CzUH+hFBA3fo/HEvABWUU6tE1boI5uti8jtVbo7h3VdFNmZd4eJCE4WSFw7pfUxQhKfqc/4RkqylWx2Cs2WNK2P1WkMrMJialhhmv90H7gaHpDaTiUQcPXdd16flZz7XYGdl0XOuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=mailbox.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Phagr5xYd4cAZ9zr/Ewi3adnc3Pm7U1f/jNyw1Gl/rI=;
 b=l/bcVng/FsF1xtQ88C3eUT+RAZXFIl/4DUtsvdow3uqp03zRbs5+HSSobWsYn89HVkUsnluADZJBxpgBPWM620lLpj5SqySj4YH8I42sPnmUWXCUfbpajO0UudzkLOoL3fTaK/VHgTaIOsUzyLXp6a/+yx/+y4ixBt+lF1bYAF+3twOzOH5RwTHvEHdtyyWzDTi60m6K/bFuIpcvGQBhB8KBHYUEV2BTmvE6nBK9tr+53ahVtX1On8yp0YNkzC85lxOfjCt7XcXf4CtuVjzLYMoqRyDr+BCR5H/Nl7yNxyh1sbAM5j05nM2j8PfnpPZWiAEmEvVnKFXHt1aqmjjNpQ==
Received: from DUZPR01CA0002.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::8) by VE1PR10MB3758.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:162::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 06:02:27 +0000
Received: from DU2PEPF00028D10.eurprd03.prod.outlook.com
 (2603:10a6:10:3c3:cafe::59) by DUZPR01CA0002.outlook.office365.com
 (2603:10a6:10:3c3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 06:02:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU2PEPF00028D10.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.8 via Frontend Transport; Mon, 11 May 2026 06:02:26 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 11 May
 2026 08:05:51 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 11 May
 2026 08:02:25 +0200
Message-ID: <2812e292-f987-4503-a438-aef30fd3beb9@foss.st.com>
Date: Mon, 11 May 2026 08:02:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/14] reset: sti: Staticize and constify driver ops
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>
References: <20260509151308.23067-1-marek.vasut+renesas@mailbox.org>
 <20260509151308.23067-12-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20260509151308.23067-12-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D10:EE_|VE1PR10MB3758:EE_
X-MS-Office365-Filtering-Correlation-Id: 2362bd3e-8cc1-454e-fc4c-08deaf22e0d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6Rvgdy6xtrEBdubWF2g8ey2/jA4PsUgbm9FJCmEky8f6SWTEvSAVTikQPXrfd/Gph82DS9hLVNmxwbQJRiPZMWshauh8/QCblTYBPd4g5wTIXjpjyE42THe4QU3x2jetpGxfzuMo07bSMjg/D+MGlmk07Xmhasq/2jGAcvwmP9xjgsW+/Nqz5prloHsX70Qyp2PILwh8vqMzSy4XRib6SJ4si3OjWugByy7d8XDebRi1PjcRVAk89A8Tew7F2xgwwYg4JuFJLdPFTtocJ5ckaY5slMQi/QdkrnPZizDEKURnuWeU6UGpuamp6PEcraltIOP05qmVlEFOurTRHHa7OLcu3WcsVHXKK3jK6GDIfQ4I+Ey5yunyhGrVVOKocf3FajrQCT0RBiM0q2z188dZVv0dFjEs6hECglSJBlobGzfRHk0OnuZ391qdFlSyVh0RLeJS0Y75Cm5L3OG63uQ6J+UAxwj1QKWr9cb1uGEzoF/lmRiOJ2BN5jz5y72zQ/+B5UJy7tdlvBzTpm67YAnVakPDAh9dowDdqlQKQR6q47pYu1ffN+hdC8LBf0FcgtbcPVYdMdp2M6HOBzK54UmtCpNVjBnVmXM254zd4E6oBCFSMkcB9g4klNaIUWulfok3ZSceoLjE0944j6S6pRv3sTOQm4ROWO7WQT7ZvbyDgfViEpWujrCk7EcXK6gGbRtU+bsEdF/GEJQieuBN6C8ckTCSstRiPoYyISGg0QG0yqk=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 01xLiNDi+qftEk7GJIH+lqdqC58YfRLXVukQjjtk1oxt0dHGuhFnR7bgh09vxBu3o10ahQO+216arACbUeno2vMwhO1NpdFIS1k1bRBnlNjDljJEdBOQQdOHw97xdEvlrh+4Ydx8RDjRNLbKvWT8grWE0/gT05A6MWHBinMCodXOgi2qYcTut49Zu5M7L4uNXizF9c3ZB5GgSluvcS0xBLJ6IfT0t/JfLqqsjF7o3IsCTBbqXv1cvovKCoVKgcriltApbbS7uxuY6emzMz4PDTOIM42rHA9cl9RH1nMuwv0nc0JyObNaJsODSl+wZk8eD4qdEEl8BVMgQ0ilPZz9oh33ogXS72bpdOiE9g7j2ObEYJQ9kAdA45zP17Ckprgo+wCaiHvzkC/ScUsJgav4yTEbHs7VzH+exsL7rm5nz/T8JMYf7u4vOhZ3SH0PdLIr
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 06:02:26.8177 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2362bd3e-8cc1-454e-fc4c-08deaf22e0d9
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D10.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3758
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



On 5/9/26 17:12, Marek Vasut wrote:
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  drivers/reset/sti-reset.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/sti-reset.c b/drivers/reset/sti-reset.c
> index 412a0c5b452..37a37a72fd3 100644
> --- a/drivers/reset/sti-reset.c
> +++ b/drivers/reset/sti-reset.c
> @@ -290,7 +290,7 @@ static int sti_reset_deassert(struct reset_ctl *reset_ctl)
>  	return sti_reset_program_hw(reset_ctl, false);
>  }
>  
> -struct reset_ops sti_reset_ops = {
> +static const struct reset_ops sti_reset_ops = {
>  	.rst_assert = sti_reset_assert,
>  	.rst_deassert = sti_reset_deassert,
>  };

Hi Marek

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
