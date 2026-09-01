Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 856A1C624CF
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 09:13:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4CA1140742;
	Tue,  1 Sep 2026 09:13:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4XgQaLB9O1QK; Tue,  1 Sep 2026 09:13:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788254012;
	bh=TvnGg7gsgPnITGdtBLf0BbyzY0jZSgItCyL5e+bZk8c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wp4IK9T3MopNYmVwYG6FosxZU9ojrGlV3HkTngDFcZCVX1GGmFKZHtkFS8AGQKvgh
	 yjWmu8VG4UltbmG+rLzf6CxLtj+PVWocDhllD8rg7aH8c53xrGG3Td9ErEfQau9OwY
	 pQwoiNWgJB2ZuAPM3JxKYmpXc5USFtoUSraULCIq8QNVirzN7NaaSNQe3Fb/Mfoaof
	 qSWDnzGHL7AHtgciRoggr0fUpqc33ufP8T4wBvTvnquhUuVAtg388kR+GuISH80U6i
	 zjpsB6nW9L1klEuZ1aCyqyMBmlGr2vAPAbfhiMmXJjx1/SFIJWb8MTs13Zbvckp8Me
	 z6RRg5vsl/56Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 781CA40706;
	Tue,  1 Sep 2026 09:13:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BF351363
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:13:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A1A3D6074A
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:13:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AuJoiCcTuPcX for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 09:13:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=F7saLwJh
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A52B760743
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:13:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9749860204;
 Tue,  1 Sep 2026 09:13:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C6E1F00A3E;
 Tue,  1 Sep 2026 09:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788254008;
 bh=TvnGg7gsgPnITGdtBLf0BbyzY0jZSgItCyL5e+bZk8c=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=F7saLwJhqwHQnYl9Mcp3aJqbAULpvADDpYI5Lyun+prG7nUICizdsyl3IFjTGM0v4
 woTF0PF/8TXX52Ad8Mmh1xWOlOdTSveN7YzK4oNN/aLinQjEom9aydU06C9Z/kJl3W
 8sGE194CshzcRlO6iyu+P9HNTSsEZWmRu04p4yZf6qTCbEQUwQlks58q8RzqYvCPNy
 MVWunpix8uPA23wyaJl1KZVU60OUeQG9PK8HTdmnzwUaH8migk5+3FTYaNqTSlZD8z
 fP4ITODxCSd7nwG3jLmoT6R/nAZFnqpVjhKcUFArN9RYWp4BGRIt1CXqLt1QXb4ro9
 UgHk4W2mXdY5Q==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 01 Sep 2026 11:13:09 +0200
Subject: [PATCH v7 11/13] ARM: dts: ux500: Make panel regulators have
 unique names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-ux500-external-sdcard-v7-11-427923e9934b@kernel.org>
References: <20260901-ux500-external-sdcard-v7-0-427923e9934b@kernel.org>
In-Reply-To: <20260901-ux500-external-sdcard-v7-0-427923e9934b@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
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

U-Boot is not happy about regulators with the same name though
Linux can deal with it. Make the names unique, it's more elegant.

Link: https://lore.kernel.org/u-boot/20260817-ux500-external-sdcard-v2-8-ca9a110bd9c6@kernel.org/
Signed-off-by: Linus Walleij <linusw@kernel.org>

[ upstream commit: a2dd0d9654e9e68b901fe63fe60cab8f4b4aa039 ]

(cherry picked from ux500-dts-for-soc)
---
 dts/upstream/src/arm/st/ste-ux500-samsung-golden.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/dts/upstream/src/arm/st/ste-ux500-samsung-golden.dts b/dts/upstream/src/arm/st/ste-ux500-samsung-golden.dts
index f736888474e7..d4f364ec8685 100644
--- a/dts/upstream/src/arm/st/ste-ux500-samsung-golden.dts
+++ b/dts/upstream/src/arm/st/ste-ux500-samsung-golden.dts
@@ -510,7 +510,7 @@
 	panel_reg_1v8: regulator-panel-1v8 {
 		compatible = "regulator-fixed";
 
-		regulator-name = "panel-fixed-supply";
+		regulator-name = "panel-fixed-supply-1v8";
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
 		/* GPIO219 */
@@ -527,7 +527,7 @@
 	panel_reg_3v0: regulator-panel-3v0 {
 		compatible = "regulator-fixed";
 
-		regulator-name = "panel-fixed-supply";
+		regulator-name = "panel-fixed-supply-3v0";
 		regulator-min-microvolt = <3000000>;
 		regulator-max-microvolt = <3000000>;
 		/* GPIO219 */

-- 
2.55.0

