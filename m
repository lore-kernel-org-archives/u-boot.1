Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F84C001E0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 14:33:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21EB6878ED;
	Mon, 23 Oct 2023 16:33:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tom-fitzhenry.me.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tom-fitzhenry.me.uk header.i=@tom-fitzhenry.me.uk header.b="MpkpcXcz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CD99878EE; Mon, 23 Oct 2023 16:33:52 +0200 (CEST)
Received: from mx2.mythic-beasts.com (mx2.mythic-beasts.com
 [IPv6:2a00:1098:0:82:1000:0:2:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 331D8878DC
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 16:33:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=tom-fitzhenry.me.uk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tom@tom-fitzhenry.me.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=tom-fitzhenry.me.uk; s=mythic-beasts-k1; h=Date:Subject:To:From;
 bh=v+REk8yow4Fe1sx+3WYQ60nOK+FMOB01RQCt3fhiQwE=; b=MpkpcXczWdTHSdo7fqPl6pX9x+
 2YsrjrUHvuH8JDv8g9FCikcbLEwfYTw+bZorerhslubpqdtsdWS8jVI8JiR6x8/OkcA47QvjkLiZZ
 xbCL35nnb+HYLKoBLu7csSwfuiHnRvz3QLqn5tfUusMMaWwwujKezQtx6wRPoZfa7ZGN3x2AQbb4a
 AJi/2O0Z83s7QajjbdRmSaHeX6RKXDRY4C20mwwQtt7XgQY87beVPP6v7P3i1hqQ5tXHU8Abv7Cu5
 E5sPBfrZghu4XbSHKMQKx53dHl13vht1AVjbIhKCgxmKCRvx7ZYOOMSDUPJ+RSO3VgUqQVyseivb/
 1AYC12eQ==;
Received: by mailhub-hex-d.mythic-beasts.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <tom@tom-fitzhenry.me.uk>)
 id 1quvzz-00E7Re-PO; Mon, 23 Oct 2023 15:33:44 +0100
References: <20231017155943.127659-1-tom@tom-fitzhenry.me.uk>
 <20231017155943.127659-3-tom@tom-fitzhenry.me.uk>
 <7eb8ef51-903d-4143-bd14-74745a276d9b@rock-chips.com>
User-agent: mu4e 1.10.7; emacs 29.1
From: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Eugen Hristev
 <eugen.hristev@collabora.com>, Jonas Karlman <jonas@kwiboo.se>, Ondrej
 Jirman <megi@xff.cz>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/2] board: rockchip: add Pine64 QuartzPro64 RK3588
 board
Date: Tue, 24 Oct 2023 01:31:31 +1100
In-reply-to: <7eb8ef51-903d-4143-bd14-74745a276d9b@rock-chips.com>
Message-ID: <871qdl76j0.fsf@tom-fitzhenry.me.uk>
MIME-Version: 1.0
Content-Type: text/plain
X-BlackCat-Spam-Score: 0
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


Kever Yang <kever.yang@rock-chips.com> writes:

> On 2023/10/17 23:59, Tom Fitzhenry wrote:
>> This patch depends on "rockchip: rk3588: Sync device tree from linux
>> maintainer tree"[0], since the QuartzPro64 upstream DT depends on upstream
>> dtsi changes.
>
> This patch has been update to V2, and your patch are not able to apply
> any more.
>
> Please help to rebase it.

Thank you for your review.

I have sent a v3 patch[0] which is rebased on top of master
( 9a3a58396b78b1f9d0c14580dc03f81d29207dd2 ) and Jonas's v2 patch.

0. https://lore.kernel.org/all/20231023142246.26830-1-tom@tom-fitzhenry.me.uk/
1. https://lore.kernel.org/all/20231017170216.1627789-2-jonas@kwiboo.se/
