Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D759AC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 22:51:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA89440561;
	Mon, 27 Jul 2026 22:51:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5mQ8JXwu1a01; Mon, 27 Jul 2026 22:51:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E3C2340563
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785192666;
	bh=8x1DgypBuY0YPLbZiAr6RWEjKFGv+xt31+qV/LCUtHQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ra2zty2hMk+HydfOBzLwHFSmcxfQ5+DIk3KC8x3bXhfM6PeziI57fhcXVLxsV8OpQ
	 IHEbloCcWExepnJi5IWXMCzhe2IlCcNfs1QUwKP79Zn7nan7ebzNITiEalz/JvMEFy
	 MExYTfxa/kM2HPW54+XGQBeMgoRvSdUSB5Md+60Naq2M70uAot1/y/6wIJw+xTESZZ
	 Ca3M8+ddhfCFoI7hSNhzrkLk5UeFxFl50Z/Cxa4p+03xQWgTUennvenWhFHddNYIq4
	 Iw6Hl1D3fvlz5uQaykIisdJmNurMY/1osqFt8cASku56KZpProwTc/V9e6gqsmTO8w
	 AoBuRYz3Kct/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E3C2340563;
	Mon, 27 Jul 2026 22:51:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 18A88350
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 22:51:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0A69440557
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 22:51:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aq4gPs5kEJCw for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 22:51:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::334; helo=mail-ot1-x334.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 11B3A40295
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 11B3A40295
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 11B3A40295
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 22:51:02 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7ebd88be784so2415716a34.2
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785192662; x=1785797462;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8x1DgypBuY0YPLbZiAr6RWEjKFGv+xt31+qV/LCUtHQ=;
 b=cPFqHvtFIsAEyrdMuece4yfx+V2xtASh+tB3SH53wozj1Y8VIqsX2HDlUB/lrKUIVc
 v2dAJ7vb8odRykaa3Qh8RIml0RD+gTcNWYgbpbXuPI90hBM3pZzwdEjiY8fJm6S1wEoF
 vAFlzwe+3vF8lG20VEyNYCcerDxYQbNcySFBTZzyRxWtEv9povlqOjlyNpk6iDXU5CrR
 v0XC3xhKFGOflMXX4uAzHLyGG/40uM2WS9h0oo5uB5p1nPeYBNyt/dSM/mUn7tYsvhXn
 +T3xUBXgDOIqCbdkS8TWdrQ3Ld3PRD8fkg/37nJIp87VZ9BGG+DwEPapXic0jH5RRJqP
 yWlw==
X-Gm-Message-State: AOJu0YxmLfCE4+3HiVVT3ZsLbJkusEIsDcRrgcnz9x2XXL+NaGE4CuQF
 kuVmh0hJnYXgEHQD9iFYNRqWEWxal9ntFGsjbamJC5PmlUQTC2IUrtZwgv+098Lc7xU=
X-Gm-Gg: AR+sD11W7MxzF7jFeMAumFggWSVvjtF9y2NN3ChzF65POUTo5q+X+s7BKa7EXqyy6Mv
 7/h+f+BRHzVmt7JpZCrpKkAKzK6YC51opASz+SKnRGZTGg0eL16mmnbpXuXEjXKBpfNlVnx6sjK
 T7diOtramYkvwjLV6FAkcnZvw5QpgZb1Ezng+xtdl3r2ZtqDOlhrQYfiUGCFIfKgOjul52sj+uU
 MKA1zAzn1jDx5HNla6O4lMVeJCTtoRw1r3MppgtiK2UZU7CTkRE/sXOdXmh7XXZ29FKQiqof+Df
 nzyzcd7RhUAqMDUEV1t/avB1wVnFk2lWgroTLdD7ISE+sV6xIbOWkPSC+TW6/d5/BjnmhXMZwEL
 v/g7qPAUGZ15W/AO4YIt7p1dBB8v9KPMDoHhRe8yIM8339f03sUuULZcwwvpmclC32fhTv6ukm/
 cmPoMTthX0/jHzJ7IzFzCfa6XuLCI7fCCyQVW5Xo89vW9NRwhXX2I5rXIZZh9j3H2sM36kVnrTA
 0DrBSAdzngDmE4u/YuOSYOTLw==
X-Received: by 2002:a05:6830:2906:b0:7dc:e37b:b5d3 with SMTP id
 46e09a7af769-7ee78a6b8d6mr9349623a34.7.1785192661851; 
 Mon, 27 Jul 2026 15:51:01 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ee29e2643fsm13154190a34.9.2026.07.27.15.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 15:51:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.u-boot-project.org, 
 Omar Ivan Fardjoume <ivan.fardjoume@gmail.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, linux-sunxi@lists.linux.dev
In-Reply-To: <20260727174414.22152-1-andre.przywara@arm.com>
References: <20260727174414.22152-1-andre.przywara@arm.com>
Subject: Re: Pull request: u-boot-sunxi/main for 2026.10
Message-Id: <178519266094.74116.10650678499402530532.b4-ty@konsulko.com>
Date: Mon, 27 Jul 2026 16:51:00 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785192662; x=1785797462;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8x1DgypBuY0YPLbZiAr6RWEjKFGv+xt31+qV/LCUtHQ=;
 b=cOi65YTg1HcgqPxnU0LkGygMsZdfPJzX2gO6Fm/QVZT9t0iPZKgCbK8UcNscXvT2kJ
 IkSidhIE7rSCi5Ww6biiwk3FySBiE5xHntV8/iTWGvbdAMM7/O1vO+AzyeLrnEZKjnxH
 gCb428w25wWzHkuIWMmTTnxnII+puQRMCiR5Q=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=cOi65YTg
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Mon, 27 Jul 2026 19:44:14 +0200, Andre Przywara wrote:

> please pull these sunxi changes into main:
> 
> Beside a fix for a long standing bug in the A80 eMMC code, this adds
> SPI booting support for the Allwinner A523/A527/T527 class of boards.
> The second major feature is support for the secondary Ethernet controller
> on that same SoC. This might not be as important as for the kernel (I
> doubt that U-Boot acts as a router), but for once some boards only connect
> the secondary EMAC, and on others people might have the boot server only
> reachable via this port.
> There are some smaller fixes and improvements still queued up, but they
> need some more testing and are minor, so can land a bit later.
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


