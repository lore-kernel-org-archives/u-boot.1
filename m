Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D134EDEBEF
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 20:30:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BC2B83F75;
	Tue,  3 Mar 2026 21:30:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="xkokcQak";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08F4983F7D; Tue,  3 Mar 2026 21:30:48 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35364839DF
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 21:30:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fQS9c3y7Cz9t1y;
 Tue,  3 Mar 2026 21:30:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1772569844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4K2wSKplRWOpcB+T2FG+rvw8hspWLrLNNPF1yHSNUuo=;
 b=xkokcQaktgn4e4UmR3Nw6t2aOrsoN54J25lR12gAhAoSjoD5UVNQl/+TDrk9JwwDNvDiqz
 yVzNc4objIdxOAejbTopyW6SsYqTyIH7Zpl0XK/j/ViXvnFsdMtwM8aS49gMcbkWaMLkH4
 bYCdkyjpCBE3AI/x4vxAmFSdjzeLEOJRoB9MpGJPQCNhvNWZrdhpzaviKKurkyAyxxhw2M
 5GJPNEmIbxJxPfkV4N67HI82OyZlYL1H0NFWuEYCmjB1cMlUwioDHh7l+m4/nopiyxNnG6
 roaP5FxTZRFk6ZJAf10YHlKg8MmbeHYouF9bGVyi0rbGWqZzgGr2nzJaLCyXYA==
Message-ID: <aca1d0f5-e053-4a7a-99b0-488581076210@mailbox.org>
Date: Tue, 3 Mar 2026 21:30:42 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v4 2/4] iopoll: Improve handling of timeout_us param in
 read_poll_timeout macro
To: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>, u-boot@lists.denx.de
Cc: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
References: <20260303062503.3392544-2-ronan.dalton@alliedtelesis.co.nz>
 <20260303062503.3392544-4-ronan.dalton@alliedtelesis.co.nz>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260303062503.3392544-4-ronan.dalton@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 50fb315139d62c07133
X-MBO-RS-META: ntis5fxgseqndrzpfyfzeyeka146y5my
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

On 3/3/26 7:25 AM, Ronan Dalton wrote:
> The read_poll_timeout macro definition is missing parenthesis around the
> usages of timeout_us. Also, the local timeout variable should be named
> __timeout to distinguish it from any variable named timeout in the
> surrounding scope.
> 
> Wrap the timeout_us parameter in brackets and rename timeout to
> __timeout to follow macro definition best-practices.
> 
> This change brings the macro definition more in line with what Linux
> does.
> 
> Signed-off-by: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>
Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
