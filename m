Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88043606A31E
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 10:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jnfT2joH;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=VuKuJRUs
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F10D60A57;
	Thu, 26 Nov 2026 10:47:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6-JBPRinHGRB; Thu, 26 Nov 2026 10:47:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C2CBD608F5
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795690022;
	b=XVlMG7FAD4PIaHkFZXp7brWnLsvSf5EHPQB9Es2/3muo8HVIooevNvzNgLyUorPD7+N9
	 wL8IuuviVIoBIFlTyd39sgm+/KpgC9KrkIksS4xMEksC78BTDJRzL5ShmJhfzKFTNMK5V
	 MOO0gBm75EiaM+t0dMUzwEnqrhHoWeUe3ww/BNAe/SZRwtrKD6uygi9SNgqlb60E6lC2p
	 0OpPAVsk9xybbkqUQdbi9NAqihzrRn7sM/h89c2mWF89t85ev0erioF18/9oQTfbraUdc
	 Tka6arGfyHZbh5QB+i/wl6QVZxTUOFpKhfW//yaHRNBr2Niaj+r8tWdPHM4FbvCZdTg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795690022;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Qh0DuNscY94bL0iV5byRMUs8sKW73MsjVKugNdL6Z/E=;
	b=jCQIYsf1wA+Lmzxaq5k6Y2nZZfgFAcb+09PF3pCI8H49sphezcYjpwL36i02R2D5m3lH
	 vPhpr+YrVEIsj88TiVB7I2aAiIzlgHA/PTfd2YCvfUrJNN+0ZQWEw9TWZjrp7CK9683zD
	 rOBNbakXOHuwxXWk2MDVjFdBJd3+8/I3AzV/vyBEdYcgnRsSm/zAlhoDtG7eXNGBFiEF1
	 gvMhdjwSsGASNIZEK0dPLdDvH688YhSsmEiLDZLpcun4w1QxxpdYn2V7E532fqToDff4J
	 LIP6tyg5F+t7U5xHPDbq7308NeTK0jfPZNbx6cpQyiM3kIoZVgSdTjNePzptW2d/nmw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795690021;
	bh=Qh0DuNscY94bL0iV5byRMUs8sKW73MsjVKugNdL6Z/E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jnfT2joHXeXpwcXXN4dFuCeaL5YzbZ9zf4/borv74bnrNN8sU4UE8YYc4MHilEAw9
	 BCGmR5MgT/Tm8Re5Fp4BkAQyk60DVBDoPc0Whza4+eAScMSyO7KAQJ/aaj0HwgWnVi
	 JwhBJwrlYjxqz0+lWJeeSb0grXrEwfFU5ZFQkHQQlqEPhjR5r2JIB7flB2SnvXOxbl
	 Jf0o6OtjljUDh7CWIZHD49qK1vuk2CISoxTyg0Wp8lxUgO27IaLYTagZlOkukoLRgj
	 lddqiFsrCf9XeRdjoKyD1iMf2Z6Ocyz78bn+THpHB5uBwl7H6Ut7BaD0ppTy1/oZgc
	 K/0uPPxBy/euA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2CBD608F5;
	Thu, 26 Nov 2026 10:47:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4529910B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:46:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3710181116
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:46:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z3dB44w2MEO2 for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 10:46:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 48074810D2
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=max.merchel@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=VuKuJRUs
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 48074810D2
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=Qh0DuNscY94bL0iV5byRMUs8sKW73MsjVKugNdL6Z/E=; b=VuKuJRUsEYEIFowLpPfbRmocXe
 xP5q4Gw3MDc0Wgb0PMKnfhyVPRVjr6xUakIeyEGdGAm3oiR20XzTZQJnHp7d97irDkCDR/semFIux
 H7OFHyEB5e5hAG1hihFBVjXHYMviPjcRteXq7mQms+gy8T0vNw2rk7smU9YCoT2kG5t/RjmApU7QV
 rCn8KeFYxUy+PBWUXJuLR5Z640xERLPXJDGAHgQCAdg3DzjsvcMOF1xi9vHhbBzby5r/LNLzPIWTK
 THLqWZP2b/04knL4P+FMK5FbtBeo0m6+T11gRsyuElycH9x1MtUF/Y9xquwrttMyXZ44QjEbFd3fd
 cFwe8kIw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1xWX06-000Nty-0k; Thu, 26 Nov 2026 11:46:50 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy06.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1xWX05-0002PX-0T; Thu, 26 Nov 2026 11:46:49 +0100
From: Max Merchel <Max.Merchel@ew.tq-group.com>
Date: Thu, 26 Nov 2026 11:46:47 +0100
Subject: [PATCH 2/6] configs: tqma6: add memtest
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-update-tqma6-v1-2-a105aba78868@ew.tq-group.com>
References: <20261126-update-tqma6-v1-0-a105aba78868@ew.tq-group.com>
In-Reply-To: <20261126-update-tqma6-v1-0-a105aba78868@ew.tq-group.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, u-boot@ew.tq-group.com, 
 u-boot@lists.u-boot-project.org, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Max Merchel <max.merchel@ew.tq-group.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Paul Gerber <Paul.Gerber@tq-group.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, Adam Ford <aford173@gmail.com>, 
 Nora Schiffer <nora.schiffer@ew.tq-group.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Markus Niebel <Markus.Niebel@ew.tq-group.com>, 
 Paul Gerber <Paul.Gerber@ew.tq-group.com>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>
X-Mailer: b4 0.14.3
X-Virus-Scanned: Clear (ClamAV 1.4.6/28194/Wed Nov 25 07:26:59 2026)
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add meminfo and memtest with default start and end for
512 MiB RAM.

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 configs/tqma6_mba6_common.config | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configs/tqma6_mba6_common.config b/configs/tqma6_mba6_common.config
index 415589db03e..78786c53f29 100644
--- a/configs/tqma6_mba6_common.config
+++ b/configs/tqma6_mba6_common.config
@@ -5,6 +5,8 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_SF_DEFAULT_SPEED=50000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_TARGET_TQMA6=y
+CONFIG_SYS_MEMTEST_START=0x28000000
+CONFIG_SYS_MEMTEST_END=0x2a000000
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_SUPPORT_RAW_INITRD=y
@@ -22,6 +24,9 @@ CONFIG_CMD_EEPROM=y
 CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
 CONFIG_CMD_MD5SUM=y
 CONFIG_MD5SUM_VERIFY=y
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_SYS_ALT_MEMTEST=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y

-- 
2.53.0

