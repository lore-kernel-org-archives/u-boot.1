Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC21CD8C89
	for <u-boot@archiver.kernel.org>; Sun,  7 Jun 2026 19:34:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2CB1846D3;
	Sun,  7 Jun 2026 21:34:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T5F3n4Oo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAF8C84099; Sun,  7 Jun 2026 17:46:10 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C89C846A3
 for <u-boot@lists.denx.de>; Sun,  7 Jun 2026 17:46:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+raz.benyehuda.mobileye.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 168D240E58;
 Sun,  7 Jun 2026 15:46:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB117C2BCC7;
 Sun,  7 Jun 2026 15:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780847165;
 bh=S32Sbu1IkHpL8PnopdzXIACfseTAz+tV1tEaLC9bLn4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=T5F3n4Ooc+snXzWmwQ2BcQSaOHuZTWt8vU0bsFJTxfzNQO1bcjpaTOTkxkw33d1dM
 dJe8YXBn9EY713m05dM8je7ys7mb+HQX0xOSxKy0JEEdKb4GJGCjoqJIZAThOqSoUN
 2Z/Nkb/BIFYBA6w3ywubou3jh4GnzkvrclICAfa0uESHZca5w11D3FcrvKgH3v232z
 nPaCLi4H4Pzo4QTGq2cUyEWgJVVMqNLJinCLB1ACk/DdRdY0w3iygFP6OZjF+c0vnq
 s4FmbN50wYBMjJ2tFiAPgDpi/EZLOrO8NlU66IIQskMSr9Qu03AySB1Wvqh6LmLkuw
 VYgtadVVAFMGw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id DF231CD8C9A;
 Sun,  7 Jun 2026 15:46:04 +0000 (UTC)
From: Raz Ben Yehuda via B4 Relay
 <devnull+raz.benyehuda.mobileye.com@kernel.org>
Date: Sun, 07 Jun 2026 18:45:32 +0300
Subject: [PATCH v2 2/5] ufs: Add flags according
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260607-ufs_tool2-v2-2-f79ff26ab18c@mobileye.com>
References: <20260607-ufs_tool2-v2-0-f79ff26ab18c@mobileye.com>
In-Reply-To: <20260607-ufs_tool2-v2-0-f79ff26ab18c@mobileye.com>
To: u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Michal Simek <michal.simek@amd.com>, Julien Stephan <jstephan@baylibre.com>, 
 Udit Kumar <u-kumar1@ti.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Jared McArthur <j-mcarthur@ti.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Schocher <hs@nabladev.com>, Simon Glass <sjg@chromium.org>, 
 briansune <briansune@gmail.com>, Yao Zi <me@ziyao.cc>, 
 Peng Fan <peng.fan@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Raz Ben Yehuda <raz.benyehuda@mobileye.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=726;
 i=raz.benyehuda@mobileye.com; h=from:subject:message-id;
 bh=/w2PkHnQPmuBGriJVqFAGn8l0ypJLuh/dA3UCYxJEc8=;
 b=owEBbQKS/ZANAwAKAZ+a6ZSW6I45AcsmYgBqJZI5FkRjyCQ2OHShZtkAcrYn9HMfjQPb8fFHY
 BSPJHRCltOJAjMEAAEKAB0WIQSC7lz5E3UmOrJvRDqfmumUluiOOQUCaiWSOQAKCRCfmumUluiO
 OWXxEACnmnOR49tI4jIMPW2ChS/EbULRE5fafqLTfrqWdFyLts32A0NOydesVmSq17h4EW/pa75
 WxLS+AYHnQ9K+PpjOZ95trVGfs5sXSjn18FqNg4xuCxBLMw1qi2CguwAnAQsru+0jjuJ2u+fcRr
 F/Gp9LiPotn1EimGWDb+zLWpRUF7mT5Nw0/CJV3W67Tt48cs+B4YFVoBk6CfTFHRdfci7i1DKJ6
 L3ErsXgSH6WQ+QsbYdtJktalv9grXTAq4P8xQpJBAOIsSyiBnqgdUGh3lBFh040CcNHgCeR00KF
 2BkEGsNk4BuoRgyyBKYrBIezuI/V9toF7nDS5cn20Rzq875Q/eZ4Pgo/T1TRHU31JF1ZWqrGsdC
 uikNkFEA3VP4tHBDRltHboTievRNLhU2WePC/bPWGD48SR0gdtP6s4W81LVvloMfeYYYCetjB5s
 AV/tDZuHWLoXPQ28BNV5dQOSinjBYdql68VsQ8E0sQTkcl5kjrvTUSxR33DeYdecWmixYh54o3O
 hLHJQ04ZtYLRz4oPmy8hgiZsv7WtkA1BuvQvoThBzBhyDc6buhUnT74cNSXGQnCC3BR5wKsiowe
 Kks4eCToWJ1Gek9zl2ZqL03s7GvxzvIbpkTM7aGXinsHhonijrWCpu99vAsIiT+o4/hwhSW4Gs9
 lNAAn5qj07lF1RQ==
X-Developer-Key: i=raz.benyehuda@mobileye.com; a=openpgp;
 fpr=82EE5CF91375263AB26F443A9F9AE99496E88E39
X-Endpoint-Received: by B4 Relay for raz.benyehuda@mobileye.com/default
 with auth_id=808
X-Original-From: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
X-Mailman-Approved-At: Sun, 07 Jun 2026 21:34:17 +0200
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

Some flags are missing according to UFS 3.1

Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
---
 drivers/ufs/ufs.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index 213b489e5e4..75b7ff83155 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -218,6 +218,9 @@ enum flag_idn {
 	QUERY_FLAG_IDN_BUSY_RTC				= 0x09,
 	QUERY_FLAG_IDN_RESERVED3			= 0x0A,
 	QUERY_FLAG_IDN_PERMANENTLY_DISABLE_FW_UPDATE	= 0x0B,
+	QUERY_FLAG_IDN_F_WRITE_BOOSTER_EN               = 0x0E,
+	QUERY_FLAG_IDN_F_WB_BUF_FLUSH_EN                = 0x0F,
+	QUERY_FLAG_IDN_F_WB_BUF_FLUSH_HIBERN8           = 0x10
 };
 
 /* Attribute idn for Query requests */

-- 
2.43.0


