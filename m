Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF2BCD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 12:22:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3B4C848A1;
	Wed, 10 Jun 2026 14:21:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="P6jdmsY1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBEF884944; Wed, 10 Jun 2026 14:21:42 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7FE9848BA
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 14:21:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gb4dZ1FSqz9tQG;
 Wed, 10 Jun 2026 14:21:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781094098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ohwMPma/92EO+eeWH5EYvSj+r9muDIDJPepZNcHb1QE=;
 b=P6jdmsY1zWpq2qNVIxMi0ssjQqgj4mptQJBaG5rbrBzsrx6Fl2ZfhMPl2rhcmFBF+E7p/O
 TpLCDui//2S5sjHceOfDHZYhuHTT/g0x6U0czDo6egFnhfOnT6WB9AHRMciSh9FTQdV03/
 bPil0Wv934NhHC707PHQW41vFUcvjkqw5m+DQUwIlCv2/J2FwOyYrS1ssnbFOZVxADU5cT
 OPtGnHX8yKwQVMw32D59FSDkecOxsq4c6W8DBLjKTM6bFKdJkJKaMgJradtPi6pLUNf5Rh
 7lrdxVzASP1h0vi60s30MIfhn5ay+vbtJNkYPG5dBNK+Xtl94e3C2agY7INODg==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Chris Packham <judge.packham@gmail.com>,
	trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v3 2/3] arm: mvebu: db-xc3-24g4xg: Remove marvell,
 nand-keep-config
Date: Wed, 10 Jun 2026 14:21:20 +0200
Message-ID: <20260610122132.2674311-4-stefan.roese@mailbox.org>
In-Reply-To: <20251218225936.2016920-3-judge.packham@gmail.com>
References: <20251218225936.2016920-1-judge.packham@gmail.com>
 <20251218225936.2016920-3-judge.packham@gmail.com>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: snnhb8ktfrtk7w43mhkbeadj9u4cuqu6
X-MBO-RS-ID: 8bbabc364f179a2b0d6
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

> nand-keep-config is used to retain the NAND controller configuration
> from an earlier boot stage. In U-Boot's case there isn't an earlier boot
> stage so reconfiguring the NAND controller is required.
>
> Signed-off-by: Chris Packham <judge.packham@gmail.com>

Applied to u-boot-marvell/next

Thanks,
Stefan
