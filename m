Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 169A8C54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 22:26:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77EE48334D;
	Sat, 24 May 2025 00:26:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tSD38eP9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D473783409; Sat, 24 May 2025 00:26:18 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF7558334D
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 00:26:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-4033c89f2aaso281406b6e.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748039175; x=1748643975; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S9/xHLB6GcgU2XMtM+0Rf4isePGmg26FU6Wc9OUQfpQ=;
 b=tSD38eP9rM1aaGTwZoaGhJEkYVIP2N7umqgrVWthtL2i69RqtY7zfjEgHYJWGkxQlV
 maq9LhM55uq0RZc9f7nEWtvLjSA89wyb64hWSzJ0Nxdl/7NSJV8I9Mnl6rmB2Bk4TxXd
 yfVag+HSVDw1pDLNiec8+6U9xS3ifV8wAbto4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748039175; x=1748643975;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S9/xHLB6GcgU2XMtM+0Rf4isePGmg26FU6Wc9OUQfpQ=;
 b=V0aBJODS7SNfeA+s3xIekELM4PYztXQPrduJMVHygkiD6fTKDoQZCwoU+kgFSA1bMB
 5dPSKQ6JtVHEBeCos9x711FO/iu9Tog/KVDw88SE0gSANJ57xdkhXRCMbIlriP4hoGhE
 0c0a5Fdayl4i8TjC3PyEuiRQzcIggHymmu/J+EkxCF/EaTV2b5tY5DC1VfgmRjwsj++C
 ryvwJ9CLOqASl5xeTVxJX1QDGWsaFA09msEf65jmvbOXDOjNBSYSX/Rx76efl3AU+LLG
 goZ6wnd8rr2FNKZttV5/2PGfqemYAF+JvezGB3o6pLizTbb1uuTtE2D4zdbqs5MwsiiQ
 hYfw==
X-Gm-Message-State: AOJu0Yz0QFnNStalnsIz9ko1dAJ3+gLxrYlpdvO4FK7CexsmkxAAfuvv
 yxiP7AATU2U7OxdZ5FoHXST55t7jEd39ZqEZNDDYxwMwEPRTYYzYZwcArj7IAZiz6pY=
X-Gm-Gg: ASbGnctU7QMYxMfwmrh/JrttNK+cDzYGvlfjxrG7Qc+0D+h1nrvH+IizNxy/6mikXGl
 xHOjpYhS3+LhDwsGP25i0GPKikbs3Spn8tIgZt+z//+t8e5cbuklxAGBQE4ta6vVNUTiyKbehcQ
 TkocrcMhxcD7Tj4wudoWQjvGf+Nj4C2l3oTJHxnGWU3w55NRcQTtg4fjpDiUD8jMmYmyKAN5gas
 zjxvslnNxb6IMyAAqaWojzlQX4cQnPbh/9TpgrcQ3htMgWJ+0+TTCwvl77PdCYLOzqI45A1fMCn
 S+mnR8x60X8OIxR71q22c4ymBBWffM8YBXPXKlCC9AFpWi9pYR88Zozs9qfNaQQjdsXJGPbw7kr
 bX3CEBW3wLY4=
X-Google-Smtp-Source: AGHT+IEmvkmxnW3kM8AgCfZ7tiPtmyXps9oByZKfQYElO9KQrhXNfodaGw0mUHdN9xsOmCbf454kEw==
X-Received: by 2002:a05:6808:3318:b0:403:5277:9424 with SMTP id
 5614622812f47-406468601a3mr493518b6e.32.1748039175563; 
 Fri, 23 May 2025 15:26:15 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4064522312bsm194029b6e.34.2025.05.23.15.26.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 May 2025 15:26:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 Nishanth Menon <nm@ti.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Suman Anna <s-anna@ti.com>, Keerthy <j-keerthy@ti.com>
In-Reply-To: <20240513062643.3589070-1-alexander.sverdlin@siemens.com>
References: <20240513062643.3589070-1-alexander.sverdlin@siemens.com>
Subject: Re: [PATCH] net: tftp: don't call stop callback from UDP handler
Message-Id: <174803917373.2369538.6508553373646553791.b4-ty@konsulko.com>
Date: Fri, 23 May 2025 16:26:13 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Mon, 13 May 2024 08:26:35 +0200, A. Sverdlin wrote:

> Contrary to doc/develop/driver-model/ethernet.rst contract, eth_ops
> .free_pkt can be called after .stop, there are several error paths in TFTP,
> for instance:
> 
> eth_halt() <= tftp_handler() <= net_process_received_packet() <= eth_rx()
> ...
> am65_cpsw_free_pkt() <= eth_rx()
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] net: tftp: don't call stop callback from UDP handler
      commit: 44340456475da953a30c5cc4fbe8a9bc013c8c0f
-- 
Tom


