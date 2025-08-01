Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A3BEC87FCA
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 20:33:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F49383B07;
	Fri,  1 Aug 2025 22:33:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="r4IOeymu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D1DB839E8; Fri,  1 Aug 2025 22:33:12 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8118783A8E
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 22:33:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=984e=2O=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1754080385; bh=1QS420zk5dH6oCXaddbKTRqN2P16Eb/h7VV3H2G96PY=;
 b=r4IOeymuwVrWytlLdNRtsX21FP+Dmk6CIbtNt9mmW0sf1bjYCfL1aomf8Ul0TeBpNqCXVmbeb
 5Ng3SPrAm97oeQR/99fz9YQVLXpDsax9daxsTMT7Wi7ICKTF3njDiiGMM7erSL21pT87V6Dssvz
 t97xbvluwXrH20EKHUgJvzbmrWlZtWaVgHWyd0YQKuS6A2+Sad3KWWy80gsSIO9uyH/AJTxsK0V
 kIAm0Shqpz5Xrs4Ned/5ZSbrng1gpQupNjc9ddd7smTz+Pf7YN7U8T9iEh0tms7O7h+hZnN0aND
 wSBP6RZpKDFJ1KkrBKJSD0xaoPva4AG/rGAJcMQRQ7fQ==
X-Forward-Email-ID: 688d248003c11ad401760846
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 1/8] rng: rockchip_rng: Add compatible for RK3576
Date: Fri,  1 Aug 2025 20:32:37 +0000
Message-ID: <20250801203255.2590535-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250801203255.2590535-1-jonas@kwiboo.se>
References: <20250801203255.2590535-1-jonas@kwiboo.se>
MIME-Version: 1.0
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

The RK3576 SoC contains a RKRNG block that can be used to generate
random numbers using the rockchip_rng driver.

Add compatible for RK3576 to support random numbers:

  => rng list
  RNG #0 - rng@2a410000

  => rng
  00000000: 36 dd ab 98 ec fb fe d1 cf 36 b3 e1 9b 3d 00 90  6........6...=..
  00000010: f5 84 de 75 6b 27 48 9e 13 62 12 6c 50 ca 47 1a  ...uk'H..b.lP.G.
  00000020: b3 4d fc 43 c5 b5 2d be 07 27 03 26 bb 69 61 2a  .M.C..-..'.&.ia*
  00000030: 6f 70 01 83 4e ce 91 7a 5a 6c 7c 00 43 87 3e c5  op..N..zZl|.C.>.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v3: No change
v2: New patch
---
 drivers/rng/rockchip_rng.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/rng/rockchip_rng.c b/drivers/rng/rockchip_rng.c
index d854ea900442..8cf750e043cf 100644
--- a/drivers/rng/rockchip_rng.c
+++ b/drivers/rng/rockchip_rng.c
@@ -393,6 +393,10 @@ static const struct udevice_id rockchip_rng_match[] = {
 		.compatible = "rockchip,rk3588-rng",
 		.data = (ulong)&rk_trngv1_soc_data,
 	},
+	{
+		.compatible = "rockchip,rk3576-rng",
+		.data = (ulong)&rkrng_soc_data,
+	},
 	{
 		.compatible = "rockchip,rkrng",
 		.data = (ulong)&rkrng_soc_data,
-- 
2.50.1

