Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF671CFD316
	for <u-boot@archiver.kernel.org>; Sun, 23 Nov 2025 21:34:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D58E783B85;
	Sun, 23 Nov 2025 22:34:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ERgY+1cq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5210583B91; Sun, 23 Nov 2025 22:34:36 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97D4183A79
 for <u-boot@lists.denx.de>; Sun, 23 Nov 2025 22:34:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dF2KM1Yqlz9sVN;
 Sun, 23 Nov 2025 22:34:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763933671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CVQy1fdfYacQb7wu5iewOANdn6hZwCsaYQm7T10dszs=;
 b=ERgY+1cq8rwuVg2lsYjkHE1YMbp9NZn5XN11FoCA5l0un4lNpNLsNFvoJC/SZzhx7MKQ5t
 H5O5zxgi6K6Yh4TC4I6h1OVlwQsTHoSSZiaRMkB45q8yB8l1laokXuGqhmh4fNmkFSD05o
 IKSPN8CaAVjaflD7WVGpyPCkBZwkNTvbDmymUQ+KW+xeyIlJvuw/wgU8oSgmZeoxnN1pwR
 yYJxYhg6k671vcoAu3VwLRXxCV5HJdQeyUugBPfNbH7wCGWDl0y1nf+BidQI95uz3PcviK
 +dqFSPDk61hE6Cac9MWwTEkXsMo/HxAeIevxU2gpEV/odPhi3jygvZN/C04uEQ==
Message-ID: <f94e70c5-e211-46ee-9e4e-9a8f44c82cc6@mailbox.org>
Date: Sun, 23 Nov 2025 21:39:51 +0100
MIME-Version: 1.0
From: Marek Vasut <marek.vasut@mailbox.org>
Subject: Re: [RFC PATCH 0/5] drivers: usb: dwc3: sync code with Linux v6.16-rc1
To: Jerome Forissier <jerome.forissier@linaro.org>,
 U-Boot mailing list <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Anshul Dalal <anshuld@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ion Agorria <ion@agorria.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Rasmus Villemoes
 <ravi@prevas.dk>, Ryder Lee <ryder.lee@mediatek.com>,
 Simon Glass <sjg@chromium.org>, Stephan Gerhold
 <stephan.gerhold@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Zixun LI <admin@hifiphile.com>
References: <20251121153812.2076440-1-jerome.forissier@linaro.org>
Content-Language: en-US
In-Reply-To: <20251121153812.2076440-1-jerome.forissier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: e40e672ee6e1919bdc9
X-MBO-RS-META: yf7hy1h6akwbggg6uspemq1s7exd4muz
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

On 11/21/25 4:37 PM, Jerome Forissier wrote:
> The DWC3 USB driver was forked from the Linux kernel v3.19-rc1 eleven
> years ago by commit 85d5e7075f33 ("usb: dwc3: add dwc3 folder from linux
> kernel to u-boot"). Since then, not many kernel changes have been ported
> back into to U-Boot. This series is an attempt at synchronizing the code
> with a somewhat current kernel (namely, v6.16.rc7 which was the latest
> released when this effort was started).
> 
> - The first three commits ("usb: dwc3: re-import from kernel v6.16-rc7",
>    "usb: host: re-import xhci-ext-caps.h from kernel", usb: gadget:
>    re-import epautoconf.c from kernel v6.16-rc7" and "usb: udc: re-import
>    udc-core.c from kernel v6.16-rc7") replace files with their counterpart
>    from the kernel, unmodified.
> - The last commit ("usb: fix build after resync of DWC3 with kernel
>    v6.16-rc7") makes the necessary changes to adapt to U-Boot and fix the
>    build.
> 
> Note that this is mostly compile-tested only. The CI pipeline on
> source.denx.de was used as a OK/NOK indicator [0]. Only one config was
> actually tested on real hardware: xilinx_zynqmp_kria_defconfig. With the
> help of a custom build script [1] and with an additional patch [2], I
> could boot the Kria KV260 board and make it detect a USB SSD plugged into
> one of its USB 3.0 ports. It certainly doesn't mean all platforms using
> the DWC3 driver are still OK, but at least there is some hope. If this
> breaks your platform I'd like to know, and if you can send a fix it's
> even better.
> 
> I realize this is a big change and I did it this way essentially to get
> going and be able to post this RFC. But I am not saying this is the way
> the re-sync has to be done. Feedback is welcome.

Thank you for doing this.

Do you plan to sync this further to 6.18 ?

I will also ask the usual question -- would it be possible to 
cherry-pick this from old Linux until current state commit-by-commit ?

I can imagine the process would be:
- Identify which Linux kernel commit was used as a starting point for 
the U-Boot DWC3 driver
- Undo all changes from the U-Boot DWC3 driver applied since
- Cherry-pick new Linux kernel patches
- Check what might be missing
