Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B5BD0E6E5
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 13:44:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3659F8404D;
	Tue, 25 Nov 2025 14:44:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="MPzNhFIm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B23908404D; Tue, 25 Nov 2025 14:44:09 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4853283FA5
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 14:44:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dG3nb51DHz9sc4;
 Tue, 25 Nov 2025 14:44:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764078243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ovrdwpuon0WCChVmK1z0sonrJRFmp3mLWI1zSGLNtGA=;
 b=MPzNhFImDmFjV4QUglYIhpKs86WH3YvVp0eanTpxMb5YeTt1T0jITsUbo04zuEMzJeZ2eH
 mwNlkg2Sq+7plS3u3UFCqz4HubZanjGu8aNtB8lZH80cwfIHWQQNFz6iPuxb3MQKQmBpTP
 7osOy4pt8qyI46DcbwITW3CpicESjZCT9vPNh+/IP8OPoCfwWSB38VGSddPnWhcrEdME2w
 9OPhmtRMnRPN4J1zHRYc+/XczuZbw7w6UvMZ0vREdFwf+tM7f5GuiF5MaIq7zkXBsUyJmW
 djhyvaeg93t/o8+Mo1YXiab+J1Y7FkGHmJ3lTiy1RtQsqVQWiO8TUSVcVm92Kw==
Message-ID: <584e5eaf-6f43-4bf4-a4de-6891c2d7d1f7@mailbox.org>
Date: Tue, 25 Nov 2025 14:43:53 +0100
MIME-Version: 1.0
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
 <f94e70c5-e211-46ee-9e4e-9a8f44c82cc6@mailbox.org>
 <f5fa04f6-ddc2-415c-b887-adf3ba47a462@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <f5fa04f6-ddc2-415c-b887-adf3ba47a462@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 7356a560da085833632
X-MBO-RS-META: wo86rybc6a5b5ji5y7zuf8dfj6q9ct1n
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

On 11/25/25 10:41 AM, Jerome Forissier wrote:

Hello Jerome,

> linux (master)$ git log --oneline --no-merges v3.19-rc1..HEAD drivers/usb/dwc3 | wc -l
> 1347
> 
> That's a lot of commits. What exactly do we gain by doing this? Some
> of the commits are not applicable to u-boot or need adaptations
> (unsupported platforms, power management, debug/tracing, interrupts,
> and probably other things I don't remember).

History of changes and likely git bisect ability.

It would be at least good to know, which of the kernel patches are part 
of the U-Boot DWC3 stack and which are missing, otherwise we might be 
missing fixes that are in Linux, which worries me.

>> - Check what might be missing
> 
> Essentially, many of the u-boot commits in:
> 
> u-boot (master)$ git log --oneline --no-merges 85d5e7075f3..HEAD drivers/usb/dwc3 | wc -l
> 216
> 
> I compared the linux and u-boot commit log and only 13 of these 216
> commits have the exact same subject as a Linux commit after v3.19-rc1.
> So that's probably 13 cherry-picks and 203 commits that are more or
> less u-boot specific.

That means U-Boot dwc3 driver started diverging, but also picked random 
change from Linux here and there (see paragraph above).

> Also note that the DWC3 driver has dependencies on:
> 
> drivers/usb/host/xhci-ext-caps.h
> drivers/usb/gadget/epautoconf.c
> drivers/usb/gadget/udc/udc-core.c
> 
> ...which also need to be synced so that's a few more commits to
> cherry-pick actually.
> 
> All things being considered, I think it is better to minimize the
> number of commits. Sync with linux then fix. We can probably squash
> the first three commits in my series so that only one commit is broken
> build-wise. This way there is little impact on bisectability.
> 
> In any case we also need more testing on real boards.
I wonder if we could pick patches on top of the old U-Boot dwc3 import 
commit, if we could at least understand that the additions won't break 
existing DWC3 support. Because those picked patches could at least be 
understood, unlike a mega-commit.
