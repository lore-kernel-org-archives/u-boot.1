Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA80C072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 20:43:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E7D887083;
	Sun, 19 Nov 2023 21:43:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="WFSSebV5";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="sGQ+iJtf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCFDC870EB; Sun, 19 Nov 2023 21:43:14 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86BE786940
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 21:43:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4SYMzF1MRzz9sdW;
 Sun, 19 Nov 2023 21:43:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1700426585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7XcxpA4LhpSjq18Q2JgTLrQHEQQq7xu4YG7xnk5UlM8=;
 b=WFSSebV5qMj+7hiJIRJ3UCTVIORnsNB849kDX8vRt+Rn7pA+yf8gP8qxoQslf6tg17RiV2
 bvnpacReV39ixjiUF88fAxRwlBlUP+db0zlTBjdz7TMDaP6+H9nCOtL1DusCWKjMBAhVIT
 FJn2HouY7+JpbbwLUd83rk5XnmAvbJJgNOH52e+/tBpSL2NvNOT7XZv1Iq7zUBOMl2Eqa2
 vNim8+UtTJmw3A3X8HJdkX0xmn9niAaW9IimOrl9b43Db1G3QgVwsa/pOrOSceTf/KxTCl
 9TrsrfrFH+oN63vGqnAG5BS6dN2orRtxiZjunzHeIbWA9HgHqxHUQ/GHCoiHLQ==
Message-ID: <5c3afcfe-40ed-420a-845c-046e36a167f5@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1700426583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7XcxpA4LhpSjq18Q2JgTLrQHEQQq7xu4YG7xnk5UlM8=;
 b=sGQ+iJtfwYcJ/WLhJ0dPT1aa5SgTVYgbhoiLMYZe5oNXnvNC3eU3L3P+Nx5pCT7/hgn9Gu
 pWi6Z5ih6ovSwUnc0sotCjCJgafFlT69FOzmxdMExd6qKTxGykgXlqVzIuLKBqfcNBtdD9
 Klq50vevuHiZnzoEso2WFHSt/aRDu92MBGDz0OGjbeU060IMm9RBkPSpnKkiuq1F/go/8b
 6mQRojJjjWSVcdmJI2HCCu4lkxjoLk0XRmGxOS6ia+gpZgrMoo3JAlpaXdeXuz21UenIBR
 G2lmtYzv8XkszK/3HFh/NnNtlQiTxrCEu++2Tan4q4LK5bTgr5jgEZZZqRz9Xw==
Date: Sun, 19 Nov 2023 21:43:00 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] scsi: set dma direction to NONE for TEST UNIT READY
Content-Language: en-US
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
 Simon Glass <sjg@chromium.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20231113055102.4041946-1-nikita.yoush@cogentembedded.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20231113055102.4041946-1-nikita.yoush@cogentembedded.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: tm3uf68s5esw3fczbtjuc74tjmu4trjq
X-MBO-RS-ID: 795241cce503400e16f
X-Rspamd-Queue-Id: 4SYMzF1MRzz9sdW
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

On 11/13/23 06:51, Nikita Yushchenko wrote:
> SCSI device scan code was executing TEST UNIT READY command without
> explicitly setting dma direction in struct scsi_cmd to NONE, so command
> was passed to driver with dma direction set to DMA_FROM_DEVICE,
> inherited from older usage.
> 
> With WDC SDINDDH6-64G ufs device, that caused TEST UNIT READY to
> return error.
> 
> Fix that, by explicitly setting dma direction to NONE for
> TEST UNIT READY, and restoring it back DMA_FROM_DEVICE for the
> following READ CAPACITY.
> 
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>

Reviewed-by: Marek Vasut <marex@denx.de>

Tom, would be likely good to pick into this release.
