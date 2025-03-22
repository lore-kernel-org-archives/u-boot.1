Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54892C36001
	for <u-boot@archiver.kernel.org>; Sat, 22 Mar 2025 02:50:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C3BF819B1;
	Sat, 22 Mar 2025 03:50:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742611802;
	bh=8L/1zoblPGyl/1hIFn0EBHS+Ry0pwMdeIhFncb9lnXQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lNZi1eERA+Zu3lY8zPgTcffq+TMZZ8sCv+qSsK/AU262zlaW68MmrCoWYhhKvQCeY
	 5qMyVICMw8E0O1RIq7bBxWJsjDaP1P6CTwzVIkxwtxgQNttlNrCeTXInY1UgNCfqFw
	 qiJLLHVw5dHZgp9h4eaYAGR7cDGlYUrQ3rmFOpMgcO3VBIM4JHOHs/jXg6RJbPVshk
	 4op39Fpi4yY/bPTPljO8JAD3HHHs7wUOcUQg7t7sM9kRjEAShv/ls7qwmjOtkwKSRB
	 oR1/jbwyyJ8tnxY+FkNol84HBaE0eu/EAvnKttfdYRs/wTf8FgCaJx1FP5YNjWjPAy
	 1rTSVDlwMsOBg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2525281219; Sat, 22 Mar 2025 03:50:00 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EB9181DCD
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 03:49:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Fql+eOvr"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0A5CC101E8F4D; Sat, 22 Mar 2025 03:49:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742611797; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=8L/1zoblPGyl/1hIFn0EBHS+Ry0pwMdeIhFncb9lnXQ=;
 b=Fql+eOvr2hfX40v3H35JjHLKEIkMP+8NhOq2cq8jsTnxVtQlnfPXNxEpWFBZgbHGOn5myw
 fWounXCrkClT7Fu2WXPNmDflXRDe+RHDMeBI5MR3/Mdhj640LQzQCPPM4wPCq39VDt3joJ
 RI8aQ2HTx97y2BGYUdj59K5yN4wmQOziLmVkYknRKV6ZG95sFut/4pzBuiWSKQOyRpxVT1
 0KnQdjdUSo0LT5ICsTxKoJQjxXmspy1rVdNtcMsqlQZDmlZ4lwNX/hciwEL1u1TO9i5mDP
 WKme4z/NJbkd9UnqFhRjea2advqiUiA2ynYnUU8mivO54R2uU+uGlgBoNeRXAg==
Message-ID: <450d1d58-d050-46a0-a94d-ca54b8fe453d@denx.de>
Date: Sat, 22 Mar 2025 02:57:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/19] clk: scmi: add the command CLOCK_PARENT_SET
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, =?UTF-8?Q?Lothar_Wa=C3=9Fmann?=
 <LW@KARO-electronics.de>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
References: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
 <20250321-imx95-v1-6-f2c8ba815f89@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250321-imx95-v1-6-f2c8ba815f89@oss.nxp.com>
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
> From: Peng Fan <peng.fan@nxp.com>
> 
> This patch adds the command CLOCK_PARENT_SET that can be used to set the
> parent of a clock. ARM SCMI Version 3.2 supports to change the parent of
> a clock device.

Reviewed-by: Marek Vasut <marex@denx.de>
