Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C074C87FCA
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 20:33:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4916483B47;
	Fri,  1 Aug 2025 22:33:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="raAdU7lK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 361C583B0D; Fri,  1 Aug 2025 22:33:56 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CF6783B34
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 22:33:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=984e=2O=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1754080427; bh=L6z/9CeLZEIPTvKiyFYrRQltY0Gxu/SYV/pBYS2tWeQ=;
 b=raAdU7lKAW0LEvHycdoj9wSsqak/cH8g+JVXAXcc08a/fwhcUVFtNzD/yGBugY6CqDI6+Piyk
 DHjryJZpLG6wph8e0Uw5SzmtEh27FXAXN3C0D6JpvP5Yz0lAKIkerSPCSsdxBVHW73Re9vPoDOm
 hPgP+y9yRz1rCJkQFDltU+IFdZAVPO6byBQ+cw3LMH1d/hjF/9LsRb3HGRvsItKSxJ78BG+sa+o
 MEFDd/h5oi6z2+VbBu7HP993QLlOSV8+6QossSWTl2dyzYla45Zyiq0lyqS13pOibNTyrdTSl0M
 e4fvPqKrZXsT+t3Q5o+8rmDT9yPszCLOrkvY1xr21PkA==
X-Forward-Email-ID: 688d248d03c11ad401760903
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 5/8] arm: dts: rockchip: Include OTP in U-Boot pre-reloc
 phase for RK3576
Date: Fri,  1 Aug 2025 20:32:41 +0000
Message-ID: <20250801203255.2590535-6-jonas@kwiboo.se>
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

Update rk3576-u-boot.dtsi to include OTP in U-Boot pre-reloc phase for
checkboard() to be able to read information about the running SoC model
and variant from OTP and print it during boot:

  U-Boot 2025.04 (Apr 22 2025 - 20:43:17 +0000)

  Model: Generic RK3576
  SoC:   RK3576
  DRAM:  8 GiB

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v3: No change
---
 arch/arm/dts/rk3576-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/rk3576-u-boot.dtsi b/arch/arm/dts/rk3576-u-boot.dtsi
index be99a48a630f..fb5a107f47d9 100644
--- a/arch/arm/dts/rk3576-u-boot.dtsi
+++ b/arch/arm/dts/rk3576-u-boot.dtsi
@@ -49,6 +49,10 @@
 	bootph-all;
 };
 
+&otp {
+	bootph-some-ram;
+};
+
 &pcfg_pull_none {
 	bootph-all;
 };
-- 
2.50.1

