Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0476C61DD3
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 03:01:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19EBF40854;
	Sat, 29 Aug 2026 03:01:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AnF7H7D_loHW; Sat, 29 Aug 2026 03:01:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787972515;
	bh=rTIJBiTlNpG7xwzSg5Lw1j8Kcbx1WbPovWL/krSO2OY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cWqkU0KA12CAIW+EQKe+Xqakf8DSGI9QpepS7XwgU5FBp6IEhltJ6XshC/n+RnTZo
	 ojOktTfQqoMP7Whi00rw1sJHu+kVPno+iMR1WP+8oVhKcQbJkclBo8ydIeFOIH3JLB
	 5olPJCqaOTgpTmHPzqBNbjfuWCS3T8BSSiGdNjOd21tLs/5PtiX4I5jM+cG7hJfe7U
	 O+FTG4gEue7641w9l+0JQ1AtAb/55hhicBNJKvHDe4CSGiX19YCIU/LYfIyqAybgJe
	 ME8sz4pgFYbsJABtdyWWwTlirepWYMzrT2op4zsvkTVGl9RdnjD07ElmaK7HgQAkrx
	 ba2izejHnZTdA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AB6F740812;
	Sat, 29 Aug 2026 03:01:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4129B23E
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 03:01:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 32B5B40812
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 03:01:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AkMq_SS_AeVN for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 03:01:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=nfESf7BE
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6F014407F6
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 03:01:53 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hX0Qh5Np1zMlFW;
 Sat, 29 Aug 2026 05:01:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787972508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rTIJBiTlNpG7xwzSg5Lw1j8Kcbx1WbPovWL/krSO2OY=;
 b=nfESf7BEA12kU53tto3engKQGIbhapx5ot2tWSlKN2YVdm3T4TKnXXGHxKyF6c9Jakp3II
 M9Ctiulg94SjcUMiC2LAkh0nIGbFFiECToWezlwfzQYlrA6zbu3UPQ3MEq5hpp5vDArK0l
 wi7CXbJi5dIUp9sfqz3MiGiWCdTxWA00d1Xp9RMnYFgzMY9MpElXzAexINsfm8gefM9tGT
 roS2FVDKnseNX6AT85yr2s7DiLUt9Yure5RjD/O/7zQArA9v3gB0UOVHLyM9d1F5n5C/66
 jjmdtoZd3Gfm6dRJdd0G83VoP5oHBxx6z8kSVM00/mZkLYKp0xFUw99dRVKY1A==
Message-ID: <d1468bd5-f56c-47e7-9da1-06d23d8f0339@mailbox.org>
Date: Fri, 28 Aug 2026 23:15:13 +0200
MIME-Version: 1.0
Subject: Re: [QUESTION] Architecture and roadmap for Synopsys XPCS driver with
 APB3 indirect access
To: Akash Nair <akashn@marvell.com>, u-boot@lists.u-boot-project.org,
 boon.khai.ng@altera.com, jerome.forissier@arm.com, trini@konsulko.com,
 clamor95@gmail.com, maxime.chevallier@bootlin.com,
 Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Simon Glass <sjg@chromium.org>
Cc: rkannoth@marvell.com
References: <5skppezbdkanp336d4nr2jv7yp24kngxs2wcewll6mrxgwdtug@mygftq2jjbjo>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <5skppezbdkanp336d4nr2jv7yp24kngxs2wcewll6mrxgwdtug@mygftq2jjbjo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: kmzq43f8qkfpxekqqfqt3fknk948duz5
X-MBO-RS-ID: cfb673117d136c37817
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 8/4/26 7:41 AM, Akash Nair wrote:

Hi,

sorry for the late reply, I am buried in emails.

+CC Alice, Peng, Simon, since they might have something to say here.

> I am currently working on Ethernet driver integration for Synopsys IP in U-Boot, specifically focusing on the Synopsys XPCS (Physical Coding Sublayer) block.
> 
> After reviewing the current codebase, I noticed that while Linux has a dedicated XPCS subsystem driver (drivers/net/pcs/pcs-xpcs.c), U-Boot does not currently have a standalone equivalent.
> 
> Before starting development on a standalone driver, I would appreciate your guidance on a few architectural questions:
> 
> 1. Existing References:
>     Is there any existing/in-flight work or reference implementation in U-Boot or vendor trees for Synopsys XPCS handling?
> 
> 2. APB3 Indirect Access vs. Clause 45 MDIO:
>     Most typical implementations access the XPCS registers over MDIO Clause 45. In our hardware architecture, the XPCS is accessed via an indirect access mechanism using an APB3 management interface instead of MDIO. Are there any existing driver patterns or abstractions in U-Boot handling XPCS/PCS over non-MDIO register buses?
> 
> 3. Design Context:
>     Is the lack of a dedicated XPCS driver in U-Boot primarily due to design preference (e.g., relying on TF-A/BootROM pre-configuration, or embedding initialization into SoC glue code), or simply that a generic driver model port has not yet been submitted?

The later, nobody implemented the XPCS yet.

> 4. Upstream Integration & Guidelines:
>     Is there interest in upstreaming a standalone Synopsys XPCS driver? If we implement this driver under U-Boot's Driver Model (DM), what key requirements or design points should we keep in mind to ensure it aligns with current networking uclass standards?
> 
> Any insights, historical context, or recommendations on how best to approach this within U-Boot would be greatly appreciated.

-- 
Best regards,
Marek Vasut
