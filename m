Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E5F41091926
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 21:30:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFD4183FC0;
	Thu, 19 Mar 2026 22:30:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="ZIzfDroT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EDB083FC5; Thu, 19 Mar 2026 22:30:33 +0100 (CET)
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com
 [91.218.175.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7462483F9B
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 22:30:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
Date: Thu, 19 Mar 2026 21:25:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1773955825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8gsU8+14tCdDaf1sLrt3CPQIm6pFdSHpcqyO8iv77JI=;
 b=ZIzfDroT7vwNskZzudrKJWgnD34kUGUDK44RZFkmSeVhVU5hPfjfF8tNBixOVcOgwMnzHU
 ogX1fGKuObRmZHjchIRGM50Tc9xfgGd0fI+T71QrbrWfJd3u6MzI0P5B34DmvEWi4aejLH
 DMk8hh3JOb+Jzs0IoCn9lYHq7ox//fOJPX6lQMuxOK9zjef00yCNz48M8nyBsQcNWCmiMP
 5yFN7ZynxzqK7sNDdclrqjizQWrBHrPwBonKYn7kzKeUkdjIENa6BKS/C5c9CBiRVMfgNc
 m0n1o1fv+nY4UyrUQ7gti7aDdo605jIi7ZjBtqV1W+9NbeLDh5mac2bgY+gCDg==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Ferass El Hafidi <funderscore@postmarketos.org>
To: u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Lukasz Majewski <lukma@denx.de>, Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Joel Stanley <joel@jms.id.au>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Paul Barker <paul@pbarker.dev>, Dai Okamura <okamura.dai@socionext.com>,
 linux@analog.com, uboot-snps-arc@synopsys.com, u-boot-amlogic@groups.io,
 uboot-stm32@st-md-mailman.stormreply.com, Sumit Garg <sumit.garg@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Stephen Boyd <swboyd@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Paul Sajna <sajattack@postmarketos.org>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH RFC 15/40] clk: restrict clk/imx to MACH_IMX
References: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
 <20260319-casey-ccf-upstream-v1-15-4df2ee2226da@linaro.org>
In-Reply-To: <20260319-casey-ccf-upstream-v1-15-4df2ee2226da@linaro.org>
Message-ID: <tc612f.1958x6s93grqj@postmarketos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
X-Migadu-Flow: FLOW_OUT
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

On Thu, 19 Mar 2026 20:56, "Casey Connolly via groups.io" <casey.connolly=linaro.org@groups.io> wrote:
>Only build IMX clocks when MACH_IMX is enabled, otherwise IMX clock
>drivers get compiled for all platforms with CLK_CCF enabled.
>
>Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>---
> drivers/clk/Makefile | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
>index 5f0c0d8a5c28..f96d57a3223a 100644
>--- a/drivers/clk/Makefile
>+++ b/drivers/clk/Makefile
>@@ -15,9 +15,9 @@ obj-$(CONFIG_$(PHASE_)CLK_STUB) += clk-stub.o
> 
> obj-y += adi/
> obj-y += airoha/
> obj-y += analogbits/
>-obj-y += imx/
>+obj-$(CONFIG_$(PHASE_)MACH_IMX) += imx/

I think this is not necessary. drivers/clk/imx/Makefile already requires
that imx config options be enabled for the driver to be compiled in.

Best regards,
Ferass

[PS: had to remove a few people from CC, because my email provider does
     not let me CC that many people, sorry!]

> obj-$(CONFIG_CLK_JH7110) += starfive/
> obj-y += tegra/
> obj-y += ti/
> obj-$(CONFIG_CLK_THEAD) += thead/
>
>-- 
>2.51.0
>
>
>
>-=-=-=-=-=-=-=-=-=-=-=-
>Groups.io Links: You receive all messages sent to this group.
>View/Reply Online (#2906): https://groups.io/g/u-boot-qcom/message/2906
>Mute This Topic: https://groups.io/mt/118408050/8399868
>Group Owner: u-boot-qcom+owner@groups.io
>Unsubscribe: https://groups.io/g/u-boot-qcom/leave/13198341/8399868/797498721/xyzzy [funderscore@postmarketos.org]
>-=-=-=-=-=-=-=-=-=-=-=-
>
>
