Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D0DCD6E6B
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 12:33:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D995D849BD;
	Thu,  4 Jun 2026 14:30:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="U5BI2xMo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BC4984913; Thu,  4 Jun 2026 13:26:01 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 484FA84874
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 13:25:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+raz.benyehuda.mobileye.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9C5034197C;
 Thu,  4 Jun 2026 11:25:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7AA60C2BCC9;
 Thu,  4 Jun 2026 11:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780572355;
 bh=1IswX9DhHbm/YQI6cCWBPDfjt8XTx01Oph43H3OrqbE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=U5BI2xMohNJilZeyOGMCkg9T7rr+KQv0FHdkbBLQFE3r1R6PDw1joJZaxZOQS2d8J
 SkjCEDkbKoNdxQJZ+bByyC/0bOhKnnIPkF2qi1x5+VjwGhXjgwtvfHzPTWi08cz3dV
 3YPixJpLcBPKGlbrGKWa77ocYn42sMTwgbgoTtdWNv+W6vqTfd6MoJxDBKUGwp0a6k
 L/JvCtTM1WfDHBP85pR53b25/Eb/8RFPgPisCcTbOevJ3NtFZSRlf7nHyvNdrqxyHC
 dNVnRbT0FcX4iwJOH4rtR8F7Iz3mQG5VaZlX2u4f6hkG+/9oUAhx2CYa/HDOtzqvmN
 HTnQE4KLKP8VA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBEACD6E6B;
 Thu,  4 Jun 2026 11:25:55 +0000 (UTC)
From: Raz Ben Yehuda via B4 Relay
 <devnull+raz.benyehuda.mobileye.com@kernel.org>
Date: Thu, 04 Jun 2026 14:25:49 +0300
Subject: [PATCH PATCHSET 1/6] MAINTAINERS: Add myself to the list of UFS
 maintainers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-ufs_tool-v1-1-741ed00232c0@mobileye.com>
References: <20260604-ufs_tool-v1-0-741ed00232c0@mobileye.com>
In-Reply-To: <20260604-ufs_tool-v1-0-741ed00232c0@mobileye.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Peng Fan <peng.fan@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>, 
 Yao Zi <me@ziyao.cc>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Michal Simek <michal.simek@amd.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Jared McArthur <j-mcarthur@ti.com>, Shawn Lin <shawn.lin@rock-chips.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Alexey Charkov <alchark@gmail.com>, 
 Raz Ben Yehuda <raz.benyehuda@mobileye.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=668;
 i=raz.benyehuda@mobileye.com; h=from:subject:message-id;
 bh=Ocf5B/AMvqRO/bsWWzBAN9GEVg25q68LSul7v418mCs=;
 b=owEBbQKS/ZANAwAKAZ+a6ZSW6I45AcsmYgBqIWC+AyXrL+ZyJ8ag+7GnEq4cGzbkiN+715ojC
 +jb5YBkg8+JAjMEAAEKAB0WIQSC7lz5E3UmOrJvRDqfmumUluiOOQUCaiFgvgAKCRCfmumUluiO
 OWiWD/4gii+hV7dDiuKRz7ez3tUfMBfFMBrxJ3LxX7Uo7OXU4mv1vPYrDCVWUlXi/JFD/4cSTZv
 JPb/P7vW+t4lDlDohTZf5TQjXTGjulJZ1OHZhCl8DBLOJWyOn2qcqOE+JTZ/xOmeIlgOHrSAqsg
 Mhz6JtVKM5otfja7PrBma9tguhPtFwmDI1+NrA3lI5flixCJE/VSkcvJrB5yLlknrDfu/NviKLF
 OZGynGUelNtZ4F2VsNBO4BuLPib8CLygvL8DG+SFmV8is6totjxOwQuPbN/g/R2LNQuPk8mGIhK
 78qCRG+TG0lK3TqouhpRPCBw5qlRuaZqDpR8c081pBbR/yqQdL2kPMLo2xkQuAAdPsbteqfaOqK
 nBdRyODMrglnMA+5SFzPxYETWbYdZ+cDGoP3R/uTirVfS0GAkmocADjCe+Az1MchA4pAdMiDfpx
 pvkIs7csalaL82CIoXmZ27Bd7qcoPosTOBglAKKfZWAqa7xeXjqU22ZCyD9Yf63rcUxWrWJ6w9r
 zHEh+ZLDgEucyD89jmP05uzZe0c3BT0G7JQ+XZ8SZynTM65F0HbQWS1ikGwKPD2F0xGvlfi52qO
 YTiDO9R5PFEkWK/l9ScocIq5pxR/cY3TucXcOCCzAY519Lbfg0021kb3psfef98Gk3bYOqi+QVD
 LD1ZCCuVJ6bz5jQ==
X-Developer-Key: i=raz.benyehuda@mobileye.com; a=openpgp;
 fpr=82EE5CF91375263AB26F443A9F9AE99496E88E39
X-Endpoint-Received: by B4 Relay for raz.benyehuda@mobileye.com/default
 with auth_id=808
X-Original-From: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
X-Mailman-Approved-At: Thu, 04 Jun 2026 14:30:17 +0200
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
Reply-To: raz.benyehuda@mobileye.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Raz Ben Yehuda <raz.benyehuda@mobileye.com>

    Adding myself to ufs.

Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 571af196465..0cb8c3e144b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1920,8 +1920,13 @@ UFS
 M:	Neil Armstrong <neil.armstrong@linaro.org>
 M:	Bhupesh Sharma <bhupesh.linux@gmail.com>
 M:	Neha Malcom Francis <n-francis@ti.com>
+M:	Raz Ben Yehuda <raz.benyehuda@mobileye.com>
 S:	Maintained
+F:	cmd/ufs.c
 F:	common/spl/spl_ufs.c
+F:	doc/usage/cmd/ufs.rst
+F:	drivers/ufs/ufs_tool.c
+F:	drivers/ufs/ufs_tool.h
 F:	drivers/ufs/
 
 UPL

-- 
2.43.0


