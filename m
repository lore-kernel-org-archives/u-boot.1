Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A6DDC5478C
	for <u-boot@archiver.kernel.org>; Sat,  2 Mar 2024 14:51:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92F5B87D80;
	Sat,  2 Mar 2024 15:51:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="BUtotu9v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 348CF87E45; Sat,  2 Mar 2024 15:51:17 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0823387D37
 for <u-boot@lists.denx.de>; Sat,  2 Mar 2024 15:51:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chris.obbard@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1709391074;
 bh=8Zr+9ae3J2CzZ1iDSojAOosd6UwhB1Ns4MhvbicsH88=;
 h=From:To:Cc:Subject:Date:From;
 b=BUtotu9vWxmUKZMFpvJLFos4tb9N5Da1mp15L4vgrLOgwKQWhEEmeBco6m+c5SaIk
 v/VJdMrTF1a+dyLQw/fuWxOf8Q7HSBQsgJXvjW5n3k6auA0NlVoXJkwHSbeVsp5x5J
 z0w3gGcDlUGI2cCGV5Te7iq+r7um2wxNP1DHqW/g73tV/h92jK9s0mPmVAwhuoFSaf
 QNAHyXjZuguCQGTNYYfRmXu/eGII/hJBEgDjat2qgilUbzdGs9MuUUIhFIiz4cnoHu
 /Mj6jghd2eZfB1ygyxtil8lnm6LXPrdg0LrTYvYE8knf40bdIzzhmQRun9MhhaAXnM
 Xnx373VNWA/Rw==
Received: from obbardc-t14.home (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: obbardc)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id EDFAE3780016;
 Sat,  2 Mar 2024 14:51:13 +0000 (UTC)
From: Christopher Obbard <chris.obbard@collabora.com>
To: u-boot@lists.denx.de
Cc: kernel@collabora.com, Christopher Obbard <chris.obbard@collabora.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 0/2] Trivial fixes for Rockchip's SPL boot order
Date: Sat,  2 Mar 2024 14:50:55 +0000
Message-ID: <20240302145107.168080-1-chris.obbard@collabora.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

This series contains some trivial fixes.

The first patch fixes a spelling mistake in a comment.

The second patch adds the full devicetree node path (rather than just the
ID) in the debug message when a boot device can't be found.

This series may be found at [0].

[0]: https://gitlab.collabora.com/obbardc/u-boot/-/tree/wip/obbardc/rockchip-spl-boot-order-fixes-v1


Christopher Obbard (2):
  rockchip: spl-boot-order: Fix spelling succes→success
  rockchip: spl-boot-order: Improve debugging message when device isn't
    found

 arch/arm/mach-rockchip/spl-boot-order.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.43.0

