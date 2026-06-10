Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE602CD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 12:22:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4BCA8495C;
	Wed, 10 Jun 2026 14:21:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="PfXQgCfI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5C7284963; Wed, 10 Jun 2026 14:21:46 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6397A84910
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 14:21:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gb4db5WtTz9sx3;
 Wed, 10 Jun 2026 14:21:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781094099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9RmWdF/zhlD/+JtrJ+4csD7AfmNhaVNXaG54C3od7kc=;
 b=PfXQgCfIDRgWRF94bxlbjLmNb5sNx/aROhyMZM5Bj8cncsxZeSjVuPE0+aT0Zb8fg5QHJd
 V6tLdkaDL0mbRZPzfXSOHGtzizu1r7WRCkcTdMFlfhPeTHVv7U4A27pnr43FMiiCC2GqTr
 tLkmjoU2yA5FVgqsOoRCrFMC9jhOANazA9pgqhtQVnn8KHXMZ/DZzfRdSw0L+iQX7s8UKa
 2Z+Pnh3kWq/3kDccGDGED7dYk1ynsf6ajlXezOnrwW1K42asPg71bQQ0k+rNO+XOD0j5O9
 SxYmFYr6Jrcb9AEvvhacixlQYEAWgHJ+D2yqFI0fKBTHRPyYyCAEZ4wmD1ngow==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Phil Sutter <phil@nwl.cc>,
	Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/2] board: Synology: legacy.c: Include asm/io.h
Date: Wed, 10 Jun 2026 14:21:22 +0200
Message-ID: <20260610122132.2674311-6-stefan.roese@mailbox.org>
In-Reply-To: <20260212223110.20267-2-phil@nwl.cc>
References: <20260212223110.20267-1-phil@nwl.cc>
 <20260212223110.20267-2-phil@nwl.cc>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: cf0d5ef973c0cb1f739
X-MBO-RS-META: 3qfcshnhrwkronnijs4937ctdcqmfu1c
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

> Some boards building this source define CFG_SYS_TCLK as a term involving
> readl() which is undefined otherwise.
>
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Applied to u-boot-marvell/next

Thanks,
Stefan
