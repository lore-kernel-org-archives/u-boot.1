Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F1F3C52D6F
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 04:31:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CF9D884C3;
	Tue, 27 Aug 2024 06:30:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724733059;
	bh=lNGQ2gX7uZiza7x6BEHWdgPidkbVnS1CXomd/hVTuUs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dFoUvW/KT71WpvPxxkawCsSBt1t0rQ6pydSrymuRsTw6bOMCHKcGMo2IkwkIZtM6x
	 xM2DsKFwSkSAc4EtYeDdfsjDwxTFmTxiDDMiKY+2GP9MG3CA1aR2UK3xx9ab/x7BVs
	 C1isq5cKwijOCQHRazzbgQvWK/oWsF1BX0yMeeTOhY0RtRwpyvn9VBxjDpuZ/FY9OP
	 dMJMa1GRhIhYALFwHMRqu3xrmGBoMqRVpH0nXo2eGbEooEZOAdNL2Im+TZGALtDj+U
	 kYyoCFJT1qAGQZKEL+f3rwOGui9Flw7BQGmhOU9Yl2Bqz0DqdEX1nyuLh9Wrh2WAkf
	 jfGAh+BUbZsmw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id BA40288363;
 Tue, 27 Aug 2024 06:30:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1724733059;
 bh=lNGQ2gX7uZiza7x6BEHWdgPidkbVnS1CXomd/hVTuUs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=bq+boYcF+1dyRD7KyN9eA4mIHBa11jWMYvfL1IdUy7m+GWbsi5kuAtG0xZX0fGzVS
 g58kOjM/G5FGuwOBjxDosV8Mps57ux1OTL0L8Z0hEBISYfrhgkvYY4CnCfzI7cL2s5
 UOw2FkcmN11LlPZqMC1tjjNHYE1Vh0SUB3/ys907aVoMegxqvuO9ul4ilkLlscA9YX
 nviF5ngn7O6n8oOVoFzZb0t7d2QDwBkq9P1ZOvpqep5EwqPA09IMpBcyJsTyNz+bvI
 rWg7dXNFf0sQC3wmBhzw5rqsJUmoy4x4UdTck6w8S9H4Wk5us1bF1Jtnvqkasep+Z0
 D1A54KWSW4w6w==
Message-ID: <bd308c00-4bfd-4ace-a499-46ea41271228@denx.de>
Date: Tue, 27 Aug 2024 06:28:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] imx: Remove CFG_MXC_USB_FLAGS
To: Fabio Estevam <festevam@gmail.com>, peng.fan@nxp.com
Cc: u-boot@lists.denx.de, tharvey@gateworks.com,
 Fabio Estevam <festevam@denx.de>
References: <20240827005826.2831478-1-festevam@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240827005826.2831478-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 8/27/24 2:58 AM, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> CFG_MXC_USB_FLAGS is only used for drivers/usb/host/ehci-mx5.c, so it
> can be removed from all the imx6/imx7/imx8m board config files.
> 
> mx51evk.h is the only place CFG_MXC_USB_FLAGS is not set to 0.
> 
> Suggested-by: Tim Harvey <tharvey@gateworks.com>
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Reviewed-by: Marek Vasut <marex@denx.de>
