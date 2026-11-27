Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE842606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 18:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XQn1Y1sE;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RJg//0Ax
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E53E940D1D;
	Fri, 27 Nov 2026 18:29:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BDxhHLNkPIVZ; Fri, 27 Nov 2026 18:29:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 79CA940A5D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795804162;
	b=BcEVn1cQ64SswLjM+nIAfPwU+QkrjHL911+Ep9Q22f7bquU4lmXGYnexB4qBVdkMJUuH
	 lYgolnK92ctFDS1/xgFCk5SimqIyQRnOoEHlQT1FF5ObNt5/3wiQuYibdceKmz4p6QGIf
	 8GZlkV1SbqCIlbz8tY8Xq25G1SQxKYsdkQbpMwmH+DNsCKw7K6WrC2pC9gZg0iLWT5BFp
	 RU9hcYnqFC9lqVMPCQZkgvXTQUBc9UAIAt2wICazfni209SScjplS5engvqUFR2QXjcyr
	 IDsY9GwqDSuXcorr39PO4f3RTvYWZNb9UhuWHS2S4EH2DfhXraO/CVLqxaAu34sOXJw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795804162;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=D1nXvwNshFEdqaLqKekXuNQ7YlnFQscgXycUEu00lS4=;
	b=U7MmD6Rma9h/5B63ZPELblyEWbPuCGqQ1gi40baEHw+4B5GRmrFRFs9T81IjsHvKeH+2
	 ybWw7+k+PEuWtCsJs9mr+lK67dkAfaliDSKbquPYhMCTmXqP48f5VHkNlN7XoNfa88f6j
	 X0aIgWf7hipHopke0FqtgkS16kZi3pS86sjsTU775DYA/CV2O0UC8/zgppB8R0J4Jr9bL
	 nlQzHb7HBQRz5bO3F7ZrmcjQkyA6an9vvRkRX8KxWK5/RMdNi3fHW327vpx6zGaw1xyXU
	 eC6LglPMi3geOXRMFzeTTsiUGdfVkkd9yVSZY5sxV2vCoMjJeBCS4r4OFpZ8rM8DsGA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795804161;
	bh=D1nXvwNshFEdqaLqKekXuNQ7YlnFQscgXycUEu00lS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XQn1Y1sEp9NxSTKI68ynX0iMKrbxXH0FmcSkhTHkU/5aznx8GNZiU6VyZhLQZZEL+
	 9PsZEoDxmZY2HYYx19goShVk92SRKtulvCdiQdj3b2HTw8NMGz4f+tmEnXEZjO8X6D
	 5/wlQrv27gz2EEOpJVy8A/XdY/qWzXUp5DVio7ngn76/Ox9iuiIlzYPXxl8hTQUIRT
	 f9gxDwNlx9QNy4VZbgubpvL69yhpzMWF3k/t6PuvkiqKE5pZ+biPsEKkNDi86B5Bfo
	 qqlu7B6aVOvBxWNYD5LplAy3jrDiPNID1SaqkVEbyhKfe5UWN46i/rKAiS4BvFBa89
	 RNKjQpXFHXsZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 79CA940A5D;
	Fri, 27 Nov 2026 18:29:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9A5812BD
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:29:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8069760A63
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:29:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1G0ny5sLDajz for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 18:29:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 994CB608CD
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=RJg//0Ax
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 994CB608CD
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:29:13 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-492fcbfaa88so5729080f8f.3
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795804151; x=1796408951;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D1nXvwNshFEdqaLqKekXuNQ7YlnFQscgXycUEu00lS4=;
 b=RJg//0AxyrrFWDLL3KGGyd3LnJtPHUYWw8Nd820O26Zq87qUZwD58XJVHLujSbzOO2
 7EToTHtnRrUz5RLkQHGuKdzBH9t2oxf6PrHBpqz7p3qtoGyJwwkHjsT7taQFvr/13Qab
 3W9W+SAiea8gi/S+9STeiAbM1FoU9oRdiX3SUDjfnSRxNYOMpHotuymictKBq/u6/Y7a
 z3VMO3PPODFHJ1aGC5ZSEGZsGGYxzrx8qypumr2T0wUn9LQzA5xvqR3mkkGP31QcXcp/
 KJfjW4gtDnkRGbbY12T5xAql3nSlc/njTpLnC3dHSNHJWbeUxhX8tJ+LiP4p6si78qeH
 afug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795804151; x=1796408951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=D1nXvwNshFEdqaLqKekXuNQ7YlnFQscgXycUEu00lS4=;
 b=f4XMf86Iv/fAFiYCVE78y/hrUqM+mHBY9wZjGtYyJsOVO+QSBXCRJmT5Jhsvm4NTen
 otTDDJz/Bgrfc8bkd1VKQWTB47kDOA8FAIhkgsMzOCK1KkHWIsU1473yPMTAxuP2Vg7q
 odVFkaBoDeSmys94xIF+nNuGM3HoTCWxe5oVkDm+O5veueQ+jCn0/bt7lFw7zq8b9UCW
 WRjBxGDmaqOJWGinXNmSKluANinEZYq3O9CMEnm6nYGy51cwB4SGzsVGRHazGGzQgVdK
 G0bkkFRp1u6ZuWEee+8YanKAUv6Y5FYkDZKizxSjrkr9i2aPVuvpgocUEJRLaEQ0X5FH
 1n6Q==
X-Forwarded-Encrypted: i=1;
 AL+hErHFXgUffs8a3xLTfuM7IRM1Y+AxhmymfFgmFD8yfpIx3ltsrxUsxFmmfDzQL/FK0ABYbSHXDYQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/ArlMDnmYZiRp2phTdsg8IyN0n5pLygBfais7wBnfHVBhwGFXp
 PX4UROUuJiGhOTBpzOZjFIuPoGQ15VBUHrxgSNLz/Lx/T7toa2qZar1r
X-Gm-Gg: AZFdTZfKiqDCZ+qAMGnXvELOHXFnkz6X6ifLcJTRQwi/hElCord1S64uhBZpCpWwBsQ
 jpeDog5pfd4WhLefo1r+LZQMbMdLE/ccfQHVEIjsB5CP3eUdE0sBAdDZgBAogOi7Z3nsnVElSwK
 7i2eoZ9EcnPOqYTmZrEoQpfF0X8bazxmMD9iL1xFu3SX6Od7SS4Blz5dGd5s4Pg5aVAsX2lPxeP
 1KRgR2IUQuDWetaLH6k39JnCJt27oOVZNet+eAC2XOAjfTmR8Kzyxnf6lHUTfYCKohfl7gKwq80
 0Y2FUVTef0NQTIcjFjblMx6A3P8VOw2BVuF6XvvAOKaYFrfZDffkTtQPzVPpQ8hFUtOiDmV0REJ
 LYp+R35c7WgkHALQrkG0YyVjMgCOKi3xHmRToA8UOKsyUls6k05r5a6SuBWfKh3MRqFkLHABXNn
 R6SyXG79UKbuYv9cShlpSv2CYXVDImwvaOFhFqtcl1VOV7/218Ren31+207TW+usgpZ3/wpVx7A
 3xwU7LFYsaPL4nIernF21WzgkpoiowhnzKxi1xXrfWbdsMgu4qf+enBPhlT5jefCYfccuUKmIGs
 aZLsZs3hHnaiy8OdL94szP5+wFNysaoUfQOdEpWsP83KIxXl27IXuN6+
X-Received: by 2002:a05:6000:2903:b0:4b7:70aa:4553 with SMTP id
 ffacd0b85a97d-4b770aa4574mr26561689f8f.38.1795804151347; 
 Fri, 27 Nov 2026 10:29:11 -0800 (PST)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d1bsm50584856f8f.8.2026.11.27.10.29.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 10:29:10 -0800 (PST)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Fabio Estevam <festevam@gmail.com>
Cc: Lukasz Majewski <lukma@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, mehmet.fide@screeningeagle.com
Subject: [PATCH 4/8] colibri_vf: use the VF610 clock driver
Date: Fri, 27 Nov 2026 19:29:01 +0100
Message-ID: <20261127182905.2836449-5-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261127182905.2836449-1-mehmet.fide@gmail.com>
References: <20261127182905.2836449-1-mehmet.fide@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

Enable the VF610 clock driver, and make the clock controller available
before relocation, where the console already asks it for the rate of
its clock. The clock tree needs more of the early malloc area than the
8 KB it had.

The device tree assigns the NAND controller 50 MHz, the rate of the
VF61. Drop that in the U-Boot overrides, so that the board code keeps
setting the rate for the module it finds. The other assigned clocks of
the device tree now take effect as they do in Linux, which moves the
timestamp clock of the FEC from the external ENET clock to the 50 MHz
one.

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
 arch/arm/dts/vf610-colibri-eval-v3-u-boot.dtsi | 13 +++++++++++++
 configs/colibri_vf_defconfig                   |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/dts/vf610-colibri-eval-v3-u-boot.dtsi b/arch/arm/dts/vf610-colibri-eval-v3-u-boot.dtsi
index a4dabc69428..4413ca6b06f 100644
--- a/arch/arm/dts/vf610-colibri-eval-v3-u-boot.dtsi
+++ b/arch/arm/dts/vf610-colibri-eval-v3-u-boot.dtsi
@@ -19,10 +19,23 @@
 	bootph-all;
 };
 
+&clks {
+	bootph-all;
+};
+
 &dcu0 {
 	bootph-all;
 };
 
+/*
+ * The same device tree runs the VF50 and the VF61, whose NAND controllers
+ * take different clock rates; the board code sets the one of the module.
+ */
+&nfc {
+	/delete-property/ assigned-clocks;
+	/delete-property/ assigned-clock-rates;
+};
+
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ddr>;
diff --git a/configs/colibri_vf_defconfig b/configs/colibri_vf_defconfig
index fcff654e4e1..0a3977673be 100644
--- a/configs/colibri_vf_defconfig
+++ b/configs/colibri_vf_defconfig
@@ -4,6 +4,7 @@ CONFIG_SYS_THUMB_BUILD=y
 CONFIG_ARCH_VF610=y
 CONFIG_TEXT_BASE=0x87800000
 CONFIG_SYS_MALLOC_LEN=0x0220000
+CONFIG_SYS_MALLOC_F_LEN=0x10000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0x180000
@@ -69,6 +70,7 @@ CONFIG_NETMASK="255.255.255.0"
 CONFIG_USE_SERVERIP=y
 CONFIG_SERVERIP="192.168.10.1"
 CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_CLK_VF610=y
 CONFIG_DFU_NAND=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x100000
 CONFIG_VYBRID_GPIO=y
-- 
2.56.0

