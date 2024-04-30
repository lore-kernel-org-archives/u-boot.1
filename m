Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798C6C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 15:34:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 975F288A5C;
	Tue, 30 Apr 2024 17:33:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ynJDcal0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 833E2887BA; Tue, 30 Apr 2024 17:33:37 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B41A88A57
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 17:33:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8b89=ME=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1714491141; bh=dovZgUb/Y2g11/ZJZQ1gP6+K+k649psVY9KpzuuBfRc=;
 b=ynJDcal0Kv4uRVjXU80re8BAtujGjN3l6Zpx4n8VznJ8CuzD+bYzCAuHrNqEHQgm2iwCkaevT
 CeK3tWU6uAWIxADm7f4lA/f32dOL56QCa5ZLUKW94faF+wdRpBuqMFcZ59ah9xSYBbRpgzGZRva
 oiSh6By36ct3zEcuVKtPlEG4q+cMWs0dlHdPjgx3KNjHV51fsxJnP0gOC6OU37VFj4EyKRTBB25
 6BQNkV+WOyVhUNS9hDhn3vwZPU9iwk5zmkvtB/1DpusmULLZ1aG0i95nNWLAxiBStrsrHqZNUfZ
 LZSGfgDtc6RZSgTHgc2vhNQ4B8yQpFZBMYHstcGobKkg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, Klaus Goger
 <klaus.goger@theobroma-systems.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de, Jonas
 Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 15/18] rockchip: rk3399-puma: Move uart0 bootph to board
 u-boot.dtsi
Date: Tue, 30 Apr 2024 15:30:22 +0000
Message-ID: <20240430153053.308788-16-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240430153053.308788-1-jonas@kwiboo.se>
References: <20240430153053.308788-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 66310ef8d99e42224315b913
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

rk3399-puma is the only supported board that use uart0 for serial
console, other RK3399 boards typically use uart2 for serial console
and may use uart0 for bluetooth.

Move setting bootph prop to board u-boot.dtsi to only include the uart0
node in TPL/SPL control FDT for the rk3399-puma target.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: New patch split from "Fix loading FIT from SD-card" patch
---
 arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi | 4 ++++
 arch/arm/dts/rk3399-u-boot.dtsi             | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi b/arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi
index 2b3ea6da88db..390cf24152a6 100644
--- a/arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi
@@ -110,3 +110,7 @@
 &sdmmc_cmd {
 	bootph-all;
 };
+
+&uart0 {
+	bootph-all;
+};
diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boot.dtsi
index 496f25d9fbf6..9815dc53e8ed 100644
--- a/arch/arm/dts/rk3399-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-u-boot.dtsi
@@ -134,10 +134,6 @@
 	bootph-all;
 };
 
-&uart0 {
-	bootph-all;
-};
-
 &uart2 {
 	bootph-all;
 };
-- 
2.43.2

