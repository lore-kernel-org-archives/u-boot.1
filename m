Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4017C5DF71
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 03:52:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C602A84898;
	Tue,  2 Jun 2026 05:52:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="E/K4X4+1";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Q5zitg3Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FCB58489D; Tue,  2 Jun 2026 05:52:32 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7FA68488F
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 05:52:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gTxjm3M8sz9tp1;
 Tue,  2 Jun 2026 05:52:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780372348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dfz7YN1hUBNecWgr/C8K7s+mH6iVf4i+0MAcZaDAk/U=;
 b=E/K4X4+1EO20pJfe9UPTiL8Kd1Yj3ZtigQy4udOFcd7paiCN/K0HisGPjoo3yNRdSTTLFM
 XQK2i9/lqs9zjFXQK3y0CIMIQHSZnUEFdR9kK4/gIzqeqMDdU5JwX1MMapG/Lkt6NrUKu4
 PLv05O/v4uuZw3ouk1ij7fCKXAiN37NEijAeN5j0WjLlK1e9aUj8Q/xRXGke7vLhZausBl
 tkj6FEhA24zTp8rsuQ3f2LLOPm/RY1WCRIySOq6YKB2lOnRosy/pmhZLQZtAM0Rbn31ptk
 Ob+wngjlu4iofVgFrHmewltJoSeo01lZhlUaDjY/kML8B0abBC1JnmpkrxbGZg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=Q5zitg3Y;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <1c30e380-26dd-4613-bb9d-6dd4f2f615ea@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780372346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dfz7YN1hUBNecWgr/C8K7s+mH6iVf4i+0MAcZaDAk/U=;
 b=Q5zitg3YHeP5jFzzZu1ZD43agojCD0tEafyl0hK12wO9boph+6BQzZRhl6CvKUlLQ87gVs
 0zetKkDgWgqkHlojvp032iGKuAJKPBFSC85LW3JlnHV+msy77QA80G1yCQt2U9fInVAu30
 rQsrB9ovCcFyyiR/tME8VeB+bzodwQNOjjGGjTWclWqTxFwa04DfJ8ajcI394YLkoVZwJ2
 h+VgXloHLKl/BhYHdDUqIclMAzVfmID0SnBG240rykN3R1zIcln28UJQ+8Y4oBbjdj+0iJ
 CrCXSz8EtpwkbXhr5MCYfrk3YYAtATKkDlmhN6ji8ESxGmJV0V+VZMce1C1+zg==
Date: Mon, 1 Jun 2026 16:52:17 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] arm: mvebu: usb: enable Armada 375 in XHCI driver
To: Tony Dinh <mibodhi@gmail.com>, Stefan Roese <stefan.roese@mailbox.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260531204723.5422-1-mibodhi@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260531204723.5422-1-mibodhi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 5n6mdh6re58t58i34c4ktkizzsb1bsao
X-MBO-RS-ID: 535d056d631d8022c99
X-Rspamd-Queue-Id: 4gTxjm3M8sz9tp1
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

On 5/31/26 10:46 PM, Tony Dinh wrote:
> Add armada-375-xhci to the compatible list in XHCI MVEBU driver.
> Tested with WD MyCloud Gen2 NAS.
> 
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> ---
> 
> Changes in v2:
> Correct the typo in string "marvell,armada-375-xhci"
One more nitpick, the subject prefix is "usb: xhci-mvebu: ..."
