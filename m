Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E0BAC55165
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 12:15:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 055BA608A0;
	Thu, 30 Jul 2026 12:15:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ACJ2xwnwJrd0; Thu, 30 Jul 2026 12:15:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2AE2160884
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785413743;
	bh=DcoIf5J7xImlwhi5VoYOAwH0vCu7EeNnatwuDz3PntU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZgLgQQRShKuKKfuhPBv0QJi8ZiYNLdyKLDxXGLJsjsBMePg5kUmdc/xvkqRaxr5bU
	 L299w4+fPCCB9Qvkqmnmf1VJ3tFAygIc1yXrHlnqF6gnMLXM6tGG8zKx+kmvIMWduc
	 Jp8BFc2YG5V62wL2uYThYW7SNmGOhOCKQI9WtuzeP2bXdOc2vhA1mIe17Ms+D9yB6+
	 toBt+z6SPIMGRE8FGQ2Za5nNcIyx0vol3+h88Yf655lTNZ7AOAFkAH/vHGnaoo+w3W
	 nI/k36kn/j10UTotIOqR8aeJeGo7s/EeNL9mhBd1J27EYtxSjvZUWCY2DDqgvmxWo/
	 XvLjcm0CmS8pA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2AE2160884;
	Thu, 30 Jul 2026 12:15:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EDE5526C
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 12:15:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D356780F7A
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 12:15:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HVwnmGPKKsNg for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 12:15:39 +0000 (UTC)
X-Greylist: delayed 380 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 30 Jul 2026 12:15:38 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org CFBBF80F70
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CFBBF80F70
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=f707=fz=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CFBBF80F70
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 12:15:38 +0000 (UTC)
X-Forward-Email-ID: 6a6b3ee946a9e64104fd70b7
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.12.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Cc: Jonas Karlman <jonas@kwiboo.se>,
	u-boot@lists.u-boot-project.org
Subject: [PATCH] arm: dts: rockchip: Drop OTP nodes from u-boot.dtsi on
 RK3528/RK356x
Date: Thu, 30 Jul 2026 12:09:07 +0000
Message-ID: <20260730120907.1209949-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1785413738;
 bh=DcoIf5J7xImlwhi5VoYOAwH0vCu7EeNnatwuDz3PntU=;
 b=0GHONkINsHhc12k+djhjxb6BAh15zaN6kftGRHH/sH6+rVIt8eZkVuSj4rG3+tl0zPjjiI/hK
 fgapMm0UJ6U2HO3C9q9EAZXP8BWSyZhCUeGVDg4F/wzHsXj/7xDEP99rV1bjVPMV9FS4FyUPHHj
 aawSiMajbRY+ZP4FpwY41gKCfeeFkJODYViDbHSOq1NnhLVBZ+RSWGe7LDdXByOJ7do/5L6gzz3
 K6Nrz62HCiaNlkT9/jvdrrjTUiCf+NGWfaaIi4bf1BsPafTyJfvRalr/8Z083RKqW1FMKrGJpUu
 CmepKWmbq58FxAkYr/tqjvZLnKUmDin595by8TrZc3Nw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=0GHONkIN
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The OTP nodes for RK3528/RK356x was merged in Linux v7.1. Remove the
obsolete OTP nodes from <soc>-u-boot.dtsi now that dts/upstream have
been updated in commit d0a838bdc629 ("Subtree merge tag 'v7.1-dts' of
dts repo [1] into dts/upstream").

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3528-u-boot.dtsi | 5 -----
 arch/arm/dts/rk356x-u-boot.dtsi | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/arch/arm/dts/rk3528-u-boot.dtsi b/arch/arm/dts/rk3528-u-boot.dtsi
index 31345df62959..3126fb4cc8fd 100644
--- a/arch/arm/dts/rk3528-u-boot.dtsi
+++ b/arch/arm/dts/rk3528-u-boot.dtsi
@@ -22,11 +22,6 @@
 			compatible = "rockchip,rkrng";
 			reg = <0x0 0xffc50000 0x0 0x200>;
 		};
-
-		otp: efuse@ffce0000 {
-			compatible = "rockchip,rk3528-otp";
-			reg = <0x0 0xffce0000 0x0 0x4000>;
-		};
 	};
 };
 
diff --git a/arch/arm/dts/rk356x-u-boot.dtsi b/arch/arm/dts/rk356x-u-boot.dtsi
index d09dab35b31a..4fd297cc02d0 100644
--- a/arch/arm/dts/rk356x-u-boot.dtsi
+++ b/arch/arm/dts/rk356x-u-boot.dtsi
@@ -20,11 +20,6 @@
 		compatible = "rockchip,rk3568-dmc";
 		bootph-all;
 	};
-
-	otp: efuse@fe38c000 {
-		compatible = "rockchip,rk3568-otp";
-		reg = <0x0 0xfe38c000 0x0 0x4000>;
-	};
 };
 
 #ifdef CONFIG_ROCKCHIP_SPI_IMAGE
-- 
2.54.0

