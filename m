Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A3BC5DF71
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 07:19:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BA3C848A2;
	Tue,  2 Jun 2026 09:19:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q4ef2CCv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF24E84898; Tue,  2 Jun 2026 09:19:09 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6468F8489D
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 09:19:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C09A06001A;
 Tue,  2 Jun 2026 07:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B0ABC2BCF4;
 Tue,  2 Jun 2026 07:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780384742;
 bh=ValLLHQUolbywjwXxCVeZRZkOX3dMDHZoNxM3VKnmto=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=Q4ef2CCvhhWO0ICBUdoNnbDWEfQdu85p9OO/hz6LI2dZQfj1SDzsS1QjRJheQasIr
 wOAwzYsI0UiJIZ7Kh1VCPLbulLasaAFEZRh6nmpXGMA/+0bgbALDIgovEVG2uxeJ3L
 sHw28S/dLGYabaee59NedlG8CrOBsY1IRJvL+Cj8ojw/vMr/qx4SCVa4eFY5ACUeLD
 Ss8rlD3n1Geb/4QsYv+7wjXtaE4osiGOhwGNykbo6CcNU3IvcFhLvEfDvOQ6TDUnHc
 OKJy1WKyn+U/a2sdCMKU290IEl2fJbQ6uuv4nZ3mU91gc+bekiTRI0CXqiwsTGj4jw
 1DKg7c3qNguyQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 55167CD6E57;
 Tue,  2 Jun 2026 07:19:02 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Date: Tue, 02 Jun 2026 17:18:57 +1000
Subject: [PATCH v2 1/6] armv8: spin_table: Fix missing includes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-msm8916-smp-support-v2-1-792e53dac374@samcday.com>
References: <20260602-msm8916-smp-support-v2-0-792e53dac374@samcday.com>
In-Reply-To: <20260602-msm8916-smp-support-v2-0-792e53dac374@samcday.com>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Sumit Garg <sumit.garg@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Casey Connolly <casey.connolly@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>, 
 Peng Fan <peng.fan@nxp.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Michal Simek <michal.simek@amd.com>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Sam Day <me@samcday.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780384740; l=828;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=mQoSZDn/LSUJsIUtV/EsIb4Uz11YSinXSikaofNJ7ko=;
 b=SoME2+h/7g8MqnTGmxn2wXRP6eLyzvbBqaoUtsMlcf8mtwPX+wCZ0V4AIuB75Kw+TTMYhK/4n
 caLY0UlsLwpC0PPWWNZSfh3/2yZt2lkSCKKzm5kH78mGulMU92whqsZ
X-Developer-Key: i=me@samcday.com; a=ed25519;
 pk=bzyS0akxWMqr9+AXzgBRIp28KKpEOs+GjYMc2yf+aeU=
X-Endpoint-Received: by B4 Relay for me@samcday.com/20240502 with auth_id=595
X-Original-From: Sam Day <me@samcday.com>
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
Reply-To: me@samcday.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Sam Day <me@samcday.com>

Dropping the common.h header resulted in the spin table header missing
asm/types.h and the source unit missing the errno.h includes.

Fixes: 7410cde67de0 ("arm: Remove <common.h> and add needed includes")
Reviewed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Sam Day <me@samcday.com>
---
 arch/arm/include/asm/spin_table.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/spin_table.h b/arch/arm/include/asm/spin_table.h
index dec18c6e5c1..8fc61237e07 100644
--- a/arch/arm/include/asm/spin_table.h
+++ b/arch/arm/include/asm/spin_table.h
@@ -3,6 +3,8 @@
 #ifndef __ASM_SPIN_TABLE_H__
 #define __ASM_SPIN_TABLE_H__
 
+#include <asm/types.h>
+
 extern u64 spin_table_cpu_release_addr;
 extern char spin_table_reserve_begin;
 extern char spin_table_reserve_end;

-- 
2.54.0


