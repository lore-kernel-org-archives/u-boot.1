Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97794CD8CA8
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 10:54:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DB7184954;
	Tue,  9 Jun 2026 12:53:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="tA9N7yIq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8A3C84878; Tue,  9 Jun 2026 12:53:23 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24FF7848D8
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 12:53:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gZQk860VRz9v3m;
 Tue,  9 Jun 2026 12:53:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781002400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y86hhhXyfFjKnjdHVM+cYZcVQ+e3b+nwvFR3j7LUzZI=;
 b=tA9N7yIqUa20xW2+HQmzgiUssMsYNWhaZJe8qJkq0YtCHxfwK0qAD26UG7P6muLPZ10eGr
 lo+N3jJtcP0HXDtqM6cWAQEhlrOxc1OEyK6fqRXGJn99Rlp/ffQGFWd3RXzOLtUXkb8+M4
 m3POoicapebV15Gl3/noZDAt1yu35TMm+hU2wgiyqkdD8qRRRm8Bqth5nrNqJ6gHoBGKjJ
 njEq7cBBwr93oxdXY1FiO+kqfJ7yw92nmZOiWLGnhZjmjmNcsW5oicwXbmgvShCa7FE50s
 Z3vw1lLmtIyxLJhDpljyVMZIXexEDDOJ8DodGTOpbL28LkKHC38yGqGZubSyOA==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Jonathan GUILLOT <jonathan@joggee.fr>,
	u-boot@lists.denx.de
Subject: Re: [PATCH] doc: wdt: fix typo for expire
Date: Tue,  9 Jun 2026 12:53:12 +0200
Message-ID: <20260609105316.1172918-6-stefan.roese@mailbox.org>
In-Reply-To: <20260521190011.32751-1-jonathan@joggee.fr>
References: <20260521190011.32751-1-jonathan@joggee.fr>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 541crtrxgqzpfs6pkja89odr6kh163np
X-MBO-RS-ID: e1380e01acafe065062
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

Applied to u-boot-watchdog/next

Thanks,
Stefan
