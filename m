Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 711A2E77198
	for <u-boot@archiver.kernel.org>; Sun,  5 Jan 2025 22:12:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EE72805CB;
	Sun,  5 Jan 2025 23:12:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736115134;
	bh=1AX6sRNmjJ1vRSvu2W+LvtSzNLKIRVKRJevkPmAjhJs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bye6IYqW4i/Pkm6mj6P+PqxrEHmNBYx3IPXEmnnDHY6+BfaHikpaHZIjMryRH/O3S
	 YI7/RfhovgMc8Wt4mPoHYjyan1EQjxfKb4LyEyX4IDjt34B92USVrLDEHXCv2dyATU
	 1DSKOObp0YhJOacBg0xBkEg3YnkuwTjtgZWHuM7M/vmkdoiFRApNohPdOfY7cSkzkh
	 H3X5SJqV/BgTPdtdvjhR/meH3/7epVYn9x2crfLZl7fUKQADk+M71+ZYWZ960LxadP
	 hzN7QyFgJ68tHCDfLHyimHWltwt4EEDF17rFOPdKNUnqgC9njaV0ER5vhow74EOy71
	 MIJCDQzdbfWkA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 367B1805D6; Sun,  5 Jan 2025 23:12:13 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 929BF805EA
 for <u-boot@lists.denx.de>; Sun,  5 Jan 2025 23:12:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="G0QkqOaD"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3BF67101D74AA; Sun,  5 Jan 2025 23:12:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736115127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1AX6sRNmjJ1vRSvu2W+LvtSzNLKIRVKRJevkPmAjhJs=;
 b=G0QkqOaD7r6DxBJZRHIqQGKpwkBYijmw1iVqCsZm/4tZYxTdV8jb/25odftCGYGTvXimPY
 wrV9RqufajTKrc57TZnaQiFtresweiJpeGIHjPeEIwD7UEMZgXXZUtkHqHMaswXknUMR+w
 Blq3Pj9v+qjB9iSvCQsIWb9i+lTNxBZa7fF+VqBbjQRnK4LMEooOHxtC3W3QTEQTn+9vBx
 7tVn1u4g/6FAAJF+DXkeaceIRzZ/lNzHd134kNCvB9+4AeCdUuPBICAVQh6PIqPCNQ/ph8
 EcZGSPD87HErTDKd1mYIROob+9DTAG6bIel27uAOS9A/Ru5FJ6OfC+IyABea0Q==
Message-ID: <0898a19f-e6f1-4fa0-ae0b-6f696ffbc837@denx.de>
Date: Sun, 5 Jan 2025 22:07:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/17] clk: scmi: check the clock state/parent/rate
 control permissions
To: Alice Guo <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
 <20250103-imx95-v1-7-6744df5dc020@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250103-imx95-v1-7-6744df5dc020@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 1/3/25 7:45 AM, Alice Guo wrote:
> From: Ye Li <ye.li@nxp.com>
> 
> SCMI clock management protocol driver in Linux checks clock state,
> parent and rate control permissions. To be consistent with the kernel
> driver, add this check here.
> 
> When using common clock framework (CCF), use the clock signal ID to get
> the clock registered by clk_register() in scmi_clk_probe(), and then
> obatin the struct clk_scmi variable with container_of().
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
>   arch/sandbox/include/asm/scmi_test.h       |   2 +
>   drivers/clk/clk_scmi.c                     | 173 +++++++++++++++++++++++++++--
>   drivers/firmware/scmi/sandbox-scmi_agent.c |  56 +++++++++-
>   include/scmi_protocols.h                   |  26 ++++-
Please split common/imx/sandbox changes into separate patches .
