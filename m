Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE50CD37B5
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 06:52:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 581FA847EF;
	Mon, 11 May 2026 08:52:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=online.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFF3684815; Mon, 11 May 2026 08:51:58 +0200 (CEST)
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [IPv6:2a01:e0c:1:1599::14])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF8F4846CA
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 08:51:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=online.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=legoll@online.fr
Received: from [10.0.0.2] (unknown [82.65.243.93])
 (Authenticated sender: legoll@free.fr)
 by smtp5-g21.free.fr (Postfix) with ESMTPSA id E73EA5FFA3;
 Mon, 11 May 2026 08:51:33 +0200 (CEST)
Message-ID: <23405282-9112-487b-a6ab-3219b2803db9@online.fr>
Date: Mon, 11 May 2026 08:51:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] riscv: spacemit: k1: add clock reset drivers, switch
 to upstream DT
To: Yao Zi <me@ziyao.cc>, Guodong Xu <guodong@riscstar.com>,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Junhui Liu <junhui.liu@pigmoral.tech>, Peter Korsgaard
 <peter@korsgaard.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Finley Xiao <finley.xiao@rock-chips.com>, Rick Chen <rick@andestech.com>,
 Conor Dooley <conor.dooley@microchip.com>, u-boot-spacemit@groups.io,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20260510-b4-k1-clk-reset-upstream-dts-v1-0-db0b0503ee44@riscstar.com>
 <3fe472bc-b9aa-49f6-ab75-a45547815c28@online.fr> <agFgoT-HbPfzgVWT@pie>
Content-Language: en-US
From: Vincent Legoll <legoll@online.fr>
In-Reply-To: <agFgoT-HbPfzgVWT@pie>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hello,

I was sure it was something silly...


On 5/11/26 06:52, Yao Zi wrote:
> b4 shazam20260510-b4-k1-clk-reset-upstream-dts-v1-0-db0b0503ee44@riscstar.com


That's my first use of b4 tool, so not really up to speed with it, 
thanks for the right incantation, this works.

I'll report my testing, this evening (CET).

