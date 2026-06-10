Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B362CD98C5
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 12:24:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFDE78499C;
	Wed, 10 Jun 2026 14:21:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="CAnb4tkD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA2338489D; Wed, 10 Jun 2026 14:21:56 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A971984979
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 14:21:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gb4dr3wzQz9v0s;
 Wed, 10 Jun 2026 14:21:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781094112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ROaHQRMQoIMHrPhw/yloj0XzGNr+k2GTYM+T4LqrSzs=;
 b=CAnb4tkDFzSBsGQGJpngruu950iPP88jGkhmEPJ3rIn+gG+NYKL1xffRekAo3EZm2CcT1O
 UPjZqwISZrv5kTQOTC1AD/sZxSfSpSWselDhyJYZ74Iw31IlsIE+W8ZrUNkmMTanM9WA9h
 CKzHqetUNxkOfzAJAayr1EoYZnl3+2itsOwayjd8A4yAWrmAP7aU0hlj8WfVRDfm989VQ0
 pA7YH0EzLMP+0OSmWQbQPRpyVZ5s6x1BJ/eg89xB8OqjavefGUOoXdfcLTINHZqIFZweua
 nJIerdwoW7U/rIaCX1YtVbpQb6zo94byBG6gMVkR2xmxj3EF+qgP92YueremRA==
From: Stefan Roese <stefan.roese@mailbox.org>
To: peng.fan@nxp.com,
	trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] timer: orion: Use dev_remap_addr_index()
Date: Wed, 10 Jun 2026 14:21:32 +0200
Message-ID: <20260610122132.2674311-16-stefan.roese@mailbox.org>
In-Reply-To: <20260526075306.2801616-1-peng.fan@nxp.com>
References: <20260526075306.2801616-1-peng.fan@nxp.com>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 8r31i8iabeiehz3g38nctmc5pmibg7n7
X-MBO-RS-ID: 544ecd092c8f3fcb657
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

On 5/26/26 15:53, peng.fan@nxp.com wrote:

> From: Peng Fan <peng.fan@nxp.com>
>
> Use dev_remap_addr_index() which supports both live device tree and flat DT
> backends, avoiding direct dependency on devfdt_* helpers.
>
> No functional changes.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied to u-boot-marvell/next

Thanks,
Stefan
