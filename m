Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E25CD8CAA
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 10:52:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C06384869;
	Tue,  9 Jun 2026 12:52:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="RfkFo9Wj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C8808466E; Tue,  9 Jun 2026 12:52:28 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51104846A7
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 12:52:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gZQj44b17z9v02;
 Tue,  9 Jun 2026 12:52:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781002344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RhmKRy5M7HRatT3TXyN9INsIvym9q2a4H2sDVjV4uMs=;
 b=RfkFo9WjB7OuqkO2fFw4kCHQtmjaCDEBt8UlbSJ6FoNozoRgHdFJMM8fu5bYm96vQHgRg1
 qhdcxAGIhGnZyEuHlgEhSutYRvUc8lKCqCsqmftPgjPX0mY9rldM9fp/bxkAP+Tb92pqh8
 ipHFpXlgcuN+fo01jmTB6xZ70YsSrmzODl8KKCXRBc/8zxrVjvIZ7GjG2yq8ExVzPlxzIG
 0TkfGdC+sj7AIU9uQsg0rY3kGb3KekcepNhonVZR82jOqSfxgT1yOkKIBHmdUHoe9oQPW5
 6dZd8RsCyKrVr8bodYtb3vlubAc5ROkl0IVW6SwvutrrM/ImZjZC7Xnu3ooB/w==
From: Stefan Roese <stefan.roese@mailbox.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	u-boot@lists.denx.de
Subject: Re: [PATCH 1/3] watchdog: orion_wdt: use dev_read_addr_size_index()
Date: Tue,  9 Jun 2026 12:52:16 +0200
Message-ID: <20260609105219.1172564-7-stefan.roese@mailbox.org>
In-Reply-To: <20260525-devfdt-wdog-v1-1-d8142b674ba0@nxp.com>
References: <20260525-devfdt-wdog-v1-0-d8142b674ba0@nxp.com>
 <20260525-devfdt-wdog-v1-1-d8142b674ba0@nxp.com>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 58dcad98bff9ef11df9
X-MBO-RS-META: bm67eouusp1fncfumbyi4zxzbczzkj7q
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

On 5/25/26 11:51, Peng Fan (OSS) wrote:

> From: Peng Fan <peng.fan@nxp.com>
>
> Replace devfdt_read_addr_size_index() with dev_read_addr_size_index() when
> retrieving the register base address.
>
> dev_read_addr_size_index() supports both live device tree and flat DT
> backends, avoiding direct dependency on devfdt_* helpers.
>
> No functional changes.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied to u-boot-watchdog/next

Thanks,
Stefan
