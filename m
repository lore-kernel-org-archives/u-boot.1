Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1561C36005
	for <u-boot@archiver.kernel.org>; Sat, 22 Mar 2025 02:51:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80E4C81219;
	Sat, 22 Mar 2025 03:50:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742611816;
	bh=KjtzITaJ7rLivSrlVmWnvAOUTCCVqG1i6chFBLmO3ak=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KHGszmepOPLfNasxCoCrJZlctFMU4oRDSEqwQ4UUhVXK4Es9S1JvFXWgETBwgjCKU
	 hjd4usL4V9pTiMuD59s/fQlZG2MKqd10ibHkxt6nlzzFJrjNZDeQ4uPw0ogGRRPdi3
	 HSLcwlM0hPRFG6krl0QULbw2FDaBkTRhAEg45DRt1u3kSGjd6FQtDBfG0KlRRT6Ya/
	 QwCpm7IALYwhfasy07MFNiwZw0/9e0EnbaqTAZwPHvIMHx0Y4DmT/alC5cpafkUMFA
	 E5xZaWwjTJrYc3oHpgIPywuiJNaA/bJ63PMuWpL7BrmcDVuR1Xfc6wehRFV82T3t5/
	 es7OMwBIPQEOw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83DDA81E51; Sat, 22 Mar 2025 03:50:12 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57A9C81D3B
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 03:50:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Oq5DQOSr"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5603A101E8F54; Sat, 22 Mar 2025 03:50:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742611808; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=KjtzITaJ7rLivSrlVmWnvAOUTCCVqG1i6chFBLmO3ak=;
 b=Oq5DQOSrDhrCr+lPr0T/4d5ZkOZ4RroQdgrZqYgJoafAk2X1+F81ge410yA1vSNQfimOHM
 HgdjDfSROMtKWFR74khtU2DSgKzh3B8R3aRPaGozOUXS/unFmMO7efMHM344+jXlCQZ0HI
 T1wOb7cMngpzumPQIKc+SFH1Gi9dRCEs+m6v0vaafO2hMszBQ2vwft64FX5Z3YuY8MNryg
 JUsa7Kx7JoegXJtLYLI6y0imM4pRlVayOXXDXbPy9EdMxjMhIuP2pxKI3d4aBPzB1EV/Ws
 Luv+0IhdtZZT7Ky+uKDdyGw22zYps3MMmIz81K26N+/huOUIyHcqGou1pUq7Kw==
Message-ID: <865fb821-9e59-4bad-8b95-cfe3c5bf35d3@denx.de>
Date: Sat, 22 Mar 2025 03:20:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/19] imx: add i.MX95 support
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, =?UTF-8?Q?Lothar_Wa=C3=9Fmann?=
 <LW@KARO-electronics.de>
Cc: u-boot@lists.denx.de, Viorel Suman <viorel.suman@nxp.com>,
 Ye Li <ye.li@nxp.com>, Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Frank Li <Frank.Li@nxp.com>,
 Ji Luo <ji.luo@nxp.com>, Jindong Yue <jindong.yue@nxp.com>
References: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
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

On 3/21/25 8:15 AM, Alice Guo (OSS) wrote:
> Changes for v7:
>   - separate i.MX Messaging Unit driver patch from this patch set
>   - add U_BOOT_SCMI_PROTO_DRIVER() to avoid putting i.MX related code in scmi_agent-uclass.c.
>   - update drivers/clk/clk_scmi.c according to comment
>   - dynamically allocate the size of struct scmi_base_discover_list_protocols_out
> 
> Changes for v8:
>   - add a comma to enum scmi_clock_message_id
>   - use readl_poll_timeout instead of while to avoid to silent hang in
>     disable_wdog()
>   - use the format "%pM" to print a MAC address
>   - use "%u" to match the data type u32
>   - add a comma enum imx8image_cmd, enum imx8image_core_type and so on
>   - add a line at end of container.cfg, imximage.cfg and imx95_19x19_evk.env
>   - update arch/arm/mach-imx/imx9/scmi/soc.c
I added a couple of comments , I'm sorry this took so long.

I think the SCMI part is starting to be pretty good.

It might make sense to split off the SCMI parts and get that in first, 
this way:

Separate patch:
[PATCH v8 01/19] firmware: scmi: smt: Interrupt communication enable

Separate patch:
[PATCH v8 09/19] scmi_protocols: update struct 
scmi_base_discover_list_protocols_out

Separate patchset:
[PATCH v8 03/19] firmware: scmi_agent: add SCMI pin control protocol support
...
[PATCH v8 08/19] sandbox: add SCMI clock control permissions to sandbox

And then the rest as a follow up series.

This will allow you to reduce the size of the series and get the pieces 
which are good in quickly, without having to resend them repeatedly as a 
part of larger series. (and yes, it also makes reviewing easier)
