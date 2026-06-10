Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55ED1CD8CB2
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 12:22:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8984D8490B;
	Wed, 10 Jun 2026 14:21:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="yelqZQTj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3A2D8495B; Wed, 10 Jun 2026 14:21:46 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2942E84928
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 14:21:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gb4dc3mL5z9vLY;
 Wed, 10 Jun 2026 14:21:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781094100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7sz3zWZm23dnvtTxOuA1C1PQb38YYOCExnkps/U2h/M=;
 b=yelqZQTj9efbSaCZzSfsuFLQOjK3WRmLkGOw47OyDlbymBL0bsA8d3xlfK4cgzVepJwqkQ
 xOa/HR2WJ+4T2rnSr+ImYgxKfKNIeXPK1i71MSl9Xnp3qZ9spUPtpS0IfMJGB+9tIQrc+M
 VDQCii/qG8yJUbxmT0rIXvkzZoIjLZ+3h+Qy8Q/+7NQ7lyAyLRLfJMeklznmBlpPKZbjXF
 5+fFdtmzs6QxTYPJ8SmSSXHS9XEP06kOOrXd/BvHE9o3rl6dtf3EIiMO/D5fubmlVaqtuf
 69/3VjVKa6vsmDdVzk091XtwY26/NkS004A6c68qlKcs5T3f84kOEfVoPnumDQ==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Phil Sutter <phil@nwl.cc>,
	Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/2] board: Synology: common: Fix typo in Makefile
Date: Wed, 10 Jun 2026 14:21:23 +0200
Message-ID: <20260610122132.2674311-7-stefan.roese@mailbox.org>
In-Reply-To: <20260212223110.20267-3-phil@nwl.cc>
References: <20260212223110.20267-1-phil@nwl.cc>
 <20260212223110.20267-3-phil@nwl.cc>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 8urb8caij8c6fbq97ei57x1mhn9uxfuf
X-MBO-RS-ID: 9d292a05be36ad5241e
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

On 2/12/26 23:31, Phil Sutter wrote:

> Due to this, legacy.c was neither compiled nor linked into the binary
> and thus booting legacy DS414 firmware failed. Missing atag setup led to
> no console output (and probably stalled boot) after:
>
> | Uncompressing Linux... done, booting the kernel.
>
> Fixes: 9774462e34faa ("arm: Disable ATAGs support")
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Applied to u-boot-marvell/next

Thanks,
Stefan
