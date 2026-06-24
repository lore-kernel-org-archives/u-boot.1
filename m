Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDED8CDB47C
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 00:01:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25E8B8460E;
	Thu, 25 Jun 2026 02:01:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="BNjuKSSn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FAE784704; Thu, 25 Jun 2026 02:01:21 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7133380287
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 02:01:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4glzVL38n1z9vC3;
 Thu, 25 Jun 2026 02:01:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782345674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9TJDkQecwL6IGep9iv3SsZzcF3nScidQOAbCVpn2tuY=;
 b=BNjuKSSn2rLHzNNhriwLoVgIUGKRVqsgZVz7YicIHiwceA30I6aizRptgqcgvUvtRNpNJ4
 bqkJpeY2RO+vjo3+j1AWVXuh9fyRikjQpNOswSL121KRZMQgOdAUcJ9Afo8xunphYIHMds
 nvAOnNxr5pNtctpnQUyrWl2nOqACTZqBNLA1DOeysqqMP8yDvTv/T8iVP8OdMYD5syc1ea
 FgdAJtCUY9jOR/i6V/JsKVOK/YY0ipgSQEV+2D2e+bONSBphcPoxDgkIu4Qhr5W5+3FyEX
 94J80D7sFddHv4kN8mFTXfy/sY6i7x4EcNTFPWfAvzd+TfVhK/oK4dbp2NHcTA==
Message-ID: <f9e7f058-9531-4dc3-8241-6415ec011bc7@mailbox.org>
Date: Wed, 24 Jun 2026 14:41:26 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3] drivers: usb: dwc3: sync code with Linux v6.16
To: Jens Wiklander <jens.wiklander@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Anshul Dalal <anshuld@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ion Agorria <ion@agorria.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Rasmus Villemoes
 <ravi@prevas.dk>, Ryder Lee <ryder.lee@mediatek.com>,
 Simon Glass <sjg@chromium.org>, Stephan Gerhold
 <stephan.gerhold@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Zixun LI <admin@hifiphile.com>,
 Jerome Forissier <jerome.forissier@arm.com>, Chintan Vankar
 <c-vankar@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>
References: <20260624123025.GA3245275@rayden>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260624123025.GA3245275@rayden>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: hpsyqyhuruii773ebmtn3sigpr8wxnqm
X-MBO-RS-ID: f5f88092860d24615ed
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

On 6/24/26 2:30 PM, Jens Wiklander wrote:

Hello Jens,

> This is a follow up on my last patchset [1]. I'm addressing feedback on
> the previous post. Since there's quite a few patches I've published a
> branch instead as requestsed. Last in this mail follows a summary of the
> branch (it looks like a pull request, but I'm only reusing a well-known
> format, it's not intended as a pull request at this stage).
> 
> The DWC3 USB driver was forked from the Linux kernel v3.19-rc1 eleven years
> ago by commit 85d5e7075f33 ("usb: dwc3: add dwc3 folder from linux kernel
> to u-boot"). Since then, not many kernel changes have been ported back into
> U-Boot.
> 
> This series synchronizes the DWC3 core with Linux v6.16. To provide
> a clear audit trail and maintain bisectability, I have structured the
> series as follows:
> 
> 1. Restore to Baseline: The first commit reverts U-Boot-specific changes
>     to drivers/usb/dwc3 to return the directory to a clean v3.19-rc1 state.
> 2. Milestone Imports: A sequence of 50+ commits follows, each performing
>     a "snapshot" import of the drivers/usb/dwc3 directory for every major
>     kernel version (v3.19 through v6.16).
> 3. U-Boot Adaptation: The final commits (based on Jerome's original work [2])
>     re-introduce the necessary glue code, XHCI/UDC updates, and build fixes
>     required for U-Boot integration.
> 
> Note that this is compile-tested only. The CI pipeline on source.denx.de
> was used as an OK/NOK indicator [3].
This is fine by me, but please do make sure the patches are posted to 
the ML.

Thanks
