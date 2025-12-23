Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F0EE6F088
	for <u-boot@archiver.kernel.org>; Tue, 23 Dec 2025 12:20:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B0D183D1A;
	Tue, 23 Dec 2025 13:20:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="GracaUxH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5E4A83F4C; Tue, 23 Dec 2025 13:20:46 +0100 (CET)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDC8683CB9
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 13:20:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1vY1NV-0006hN-Ap; Tue, 23 Dec 2025 07:20:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
 From; bh=HZ4N02sLZUhWy4VhDRrKjBQfiW3sNkIXgZjfnc6nnH8=; b=GracaUxH+kNf2rWvbJg/
 aNo1TEwTcixpvh0z9Uncjj8AFEYteUhTNrSiTdnFvrd1nLiphPgsZk2er/rzJ4lChneqcTAZf+DKW
 V9k7VZ9tno0VJ1UkFjjxW/z451ikGy7dbb+19LNk/d6lfg9Om/JwaJMTSDmKH/wLDI9MwnSQUQuvA
 p1ZDTsqjpqzhHXmpW0pUj8C4q1DNKqzCiF0xg/jDhCaFRzN8PFXW0P0Tec3X0T1oE1hUHJ9rOd7Kb
 KY7gfOclW93K1Lzn26ayzhJPz1xa8hGKvc4Z2+zxaOJOPVHzwyz1BQBIyZB74HtWCkXYMhYgJ2HWy
 YfkZoH3N4uNC2w==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: u-boot@lists.denx.de
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,  Joe Hershberger
 <joe.hershberger@ni.com>,  Ramon Fried <rfried.dev@gmail.com>,  Jerome
 Forissier <jerome.forissier@linaro.org>,  Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] net: ravb: Configure CXR31 and CXR35 on rzg2l
In-Reply-To: <20251210141706.32760-1-othacehe@gnu.org>
References: <20251210141706.32760-1-othacehe@gnu.org>
Date: Tue, 23 Dec 2025 13:20:33 +0100
Message-ID: <875x9xfkz2.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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


Hello.

> As in Linux with d78c0ced60 ("net: ravb: Make write access to CXR35 first
> before accessing other EMAC register"), configure CXR31 and CXR35 correctly
> on rzg2. MII mode does not work correctly unless those registers are
> properly configured.

Friendly ping :) This patch fixes networking when using MII on RZG2L in
U-Boot.

Mathieu
