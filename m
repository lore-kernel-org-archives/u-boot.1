Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E23CFCDB46B
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 03:10:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A156849D1;
	Tue, 23 Jun 2026 05:10:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="GG9R7zSa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A6D1849D2; Tue, 23 Jun 2026 05:10:20 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D64E3849CE
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 05:10:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gkqnM2SVnz9tyg;
 Tue, 23 Jun 2026 05:10:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782184215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/NeLrJ+jcRWJUimXOi3sOk3VAZriQ8GDyIUDqI10/vA=;
 b=GG9R7zSaVE/AeGUF3ifZ90/E46RoyrUIf4esEsSD90R136UwO43F/vxoAROlfjkClV57vc
 lGfjGnBJtD5+dF0zIj7o3wX+bCQ2mSOrGaWUx8FfshV5eYLNhFpczA2lpKPlzVrzifNZUK
 /uPQgNl7/aFAeNryi5lAYOl4Sd8fVfNYwcKC8n9OyrBrLPujqwLiugei2BewmTI0I4N+Iu
 NI9CxHhXD/7hEcxHDHCVCRGvFwMgRpVqT2Xwi1/vBpcDDadeB7v9GR4S2bgsXMgtKXLGpX
 lWny0Uxpo6MXRViaWjvKnJnb2LLCVbodDREkjMdwHLtyWU4YLreFvzzm8XgJ0A==
Message-ID: <56316a7d-d30a-48c4-ba07-f0fcd9b5adff@mailbox.org>
Date: Mon, 22 Jun 2026 20:22:34 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] usb: gadget: f_mass_storage: Move schedule() in
 sleep_thread()
To: Patrice Chotard <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Tom Rini <trini@konsulko.com>
References: <20260622-move_schedule-v1-1-4b5dac252b70@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260622-move_schedule-v1-1-4b5dac252b70@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 0f7a434a78a2cadba9b
X-MBO-RS-META: djperm31jqcwyeaifx5aux697zd3aoko
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

On 6/22/26 7:18 PM, Patrice Chotard wrote:
> Move schedule() in order to call it only every 10 loop iteration
> to avoid useless overhead.
This really needs more info here. What problem are you solving ? What 
overhead do you observe ? Why is that a problem ?
