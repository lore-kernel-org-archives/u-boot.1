Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB72FCD8CB2
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 12:22:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CC20848D1;
	Wed, 10 Jun 2026 14:21:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="rmzPJ12n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28BE684948; Wed, 10 Jun 2026 14:21:44 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25A658489F
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 14:21:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gb4dZ6f9rz9v4l;
 Wed, 10 Jun 2026 14:21:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781094099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gJep4JnTn8kAYkzf1hTIvmbuaZ4gaSddIYvqBPIpetw=;
 b=rmzPJ12nRjPK3oaFhldzrC11aNsAxYpOFLTrephoHLsR8YuFOfBzSrodv5JxQYkSMRCUt+
 pcotPYQzl7VBL5/ugRD70EmHMIyRHu9uq/5ZLHY7BQPmZawAgBBlhbncRTtWCwCgHCt90u
 e30h1jeAARL1uAhhV8KkHJKsaBS0V2CixJlIzCgxogf2z8lSHvMLX2vcZVm7Z5aaXNnU6E
 +CSrvw5/1+HiDjB5ccxQwhOLA5lKOxDI+50vV10B/DPC69MnInS6re87Fgd527bOYGW1nC
 iCxEJV8SuIbt3hBIJo2En35M0X+HCqUHbwc6GF/QqCeyZ9bXYXl7y1WkljgjTA==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Chris Packham <judge.packham@gmail.com>,
	trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v3 3/3] arm: mvebu: Add Allied Telesis x220
Date: Wed, 10 Jun 2026 14:21:21 +0200
Message-ID: <20260610122132.2674311-5-stefan.roese@mailbox.org>
In-Reply-To: <20251218225936.2016920-4-judge.packham@gmail.com>
References: <20251218225936.2016920-1-judge.packham@gmail.com>
 <20251218225936.2016920-4-judge.packham@gmail.com>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: tc4pjsbdjg1o8nm6aamu31rxfw91o9up
X-MBO-RS-ID: 96453de5af4f5f7e3b3
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

On 12/19/25 11:59, Chris Packham wrote:

> Add the Allied Telesis x220 board. There are a number of other variants
> with the same CPU block that are sold under some different brand names
> but the x220 was first.
>
> The x220 uses the AlleyCat3 switch chip with integrated ARMv7 CPU.
> Because of this it is reliant on a binary blob for the DDR training. In
> upstream u-boot this is replaced by an empty file.
>
> Signed-off-by: Chris Packham <judge.packham@gmail.com>

Applied to u-boot-marvell/next

Thanks,
Stefan
