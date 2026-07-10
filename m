Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B782BC44506
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 13:18:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BBE784ADF;
	Fri, 10 Jul 2026 15:17:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="m8VqosuK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C969F84A63; Fri, 10 Jul 2026 15:17:41 +0200 (CEST)
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch
 [IPv6:2001:1600:19:8e30::bc09])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6685F84AC2
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 15:17:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gxXSM0rsjzgdt;
 Fri, 10 Jul 2026 15:17:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1783689458;
 bh=bCJkCcFbMTzgjr2jIEp3PX7RNLSsKjpcCLwBeZQfTjo=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=m8VqosuKQok/gcc2okMcf0RtSmiNlfj7554+f5W22hpetX6OZHcbsUAUI9sY1/wU5
 RWWOPArtbYoHu1hLihCipLjUBDBALJduIBjw/4DwR3M5YJLeQAD7rkuGcBfXY2eF/B
 qNLL/oYgh+En/CVwXro5ztz0QR4dfv7OfbazDCjGqZQS25iqaoe4IntS5nYZc+knSz
 HKwDA3zLKbjzrTdDyKTIih/cx3jYOBDEwP8cgQbT5p6clhuq5q1SmAdjMXHlwOW+hc
 l2NFEVFP85BF8xUirWd5OsYfJ4gfYoF5MFRswzUcndRrWtpSnRp9zBOVuvV495SEEd
 0xaLeFTIDA9hw==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4gxXSL2HNfzdTP; Fri, 10 Jul 2026 15:17:38 +0200 (CEST)
From: Quentin Schulz <u-boot@0leil.net>
To: Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Klaus Goger <klaus.goger@cherry.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Jakob Unterwurzacher <jakobunt@gmail.com>
Cc: u-boot@lists.denx.de, 
 Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
In-Reply-To: <20260625-pub-jaguar-puma-ringneck-tiger-v2025-07_nvme-v2-1-c57bf1020d63@cherry.de>
References: <20260625-pub-jaguar-puma-ringneck-tiger-v2025-07_nvme-v2-1-c57bf1020d63@cherry.de>
Subject: Re: [PATCH v2] board: rockchip: set M.2 NVMe PERSTN low in
 spl_board_init on Jaguar
Message-Id: <178368945826.879692.10317495343740498090.b4-ty@b4>
Date: Fri, 10 Jul 2026 15:17:38 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Infomaniak-Routing: alpha
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

On Thu, 25 Jun 2026 13:55:15 +0200, Jakob Unterwurzacher wrote:
> As it is, an NVMe's built-in PERSTN pull-up fights against the
> SoC's built-in pull-down which results in an undefined logic state
> on the Samsung SSD 980 and likely others.
> 
> Fix that by forcing PERSTN low as early as possible, which is SPL.
> 
> Both Linux and U-Boot (via "pci enum") set the pin high later
> as needed and the NVMe is detected fine.
> 
> [...]

Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip (u-boot-rockchip-2026.10), thanks!

[1/1] board: rockchip: set M.2 NVMe PERSTN low in spl_board_init on Jaguar
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/6037673a10f1ec24cd8e9fe03785d1e7e19e6854

Best regards,
-- 
Quentin Schulz <u-boot@0leil.net>

