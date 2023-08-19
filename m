Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94EB0EE499F
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 00:23:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 666D2869B7;
	Sat, 19 Aug 2023 02:23:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="HiTQApn5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13EEF869C8; Sat, 19 Aug 2023 02:23:10 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A0B4868D5
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 02:23:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RSKFz4yntz9smV;
 Sat, 19 Aug 2023 02:23:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692404583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b74hEbaIXhOQylXrcnE/QcW5EeeO5+xDDPkFiOsu3ho=;
 b=HiTQApn5J9y2pSpZ3FY8n7yauHDEdQ5Q78A+fhi9lACRqJF5y/Xcms//ld/EOFDdtgny8i
 QgIOg/0ntHN0V94kckp/GEBobe0OgzX3pA95S3a5bUyn/YArphO0HeNxwOjDTkrVsvzBwU
 vYhNP3IZsW87pyQparl/79fgenJrafNPEme5ZhljS7BT6Wda2xAI1zdxCxyX28iS7h4uf6
 ectLZPC81uomHt1JWC9aCdgM202UidsjbWu2VLyedtYDCrDyIM6AWHqSBDLSX+9WaIPx6b
 pSmUoazTFzf5gih9NcHR1MC2UfiKuX+a8XvektH8C2X9CY2KSWsdug+M5n2bSw==
Message-ID: <7c03ac40-44af-0da9-d968-7d00f7ae96e3@mailbox.org>
Date: Sat, 19 Aug 2023 02:23:02 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] drivers/mtd/nvmxip: Rework the read accessor to
 support 32bit systems
Content-Language: en-US
To: u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Simon Glass <sjg@chromium.org>
References: <20230813214659.441964-1-marek.vasut+renesas@mailbox.org>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20230813214659.441964-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 3jg5bmd8gb8upy686gtu3bfgpbfbk9bt
X-MBO-RS-ID: 12f7f7589809b3e39f8
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

On 8/13/23 23:46, Marek Vasut wrote:
> Get rid of nvmxip_mmio_rawread() and just implement the readl()/readq()
> reader loop within nvmxip_blk_read(). Cast the destination buffer as
> needed and increment the read by either 4 or 8 bytes depending on if
> this is systemd with 32bit or 64bit physical address.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> Cc: Simon Glass <sjg@chromium.org>

Sandbox CI test fails with this series:

https://source.denx.de/u-boot/custodians/u-boot-sh/-/pipelines/17427

https://u-boot.source-pages.denx.de/-/custodians/u-boot-sh/-/jobs/679256/artifacts/test-log.html

