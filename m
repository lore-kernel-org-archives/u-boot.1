Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C33C531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 09:09:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2D767406EC;
	Mon, 27 Jul 2026 09:09:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r4gSSeytaxER; Mon, 27 Jul 2026 09:09:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7EC7B406E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785143384;
	bh=RkWOLIdO/tI3fAHj5KqjWhhNYuAmp2jlpaCnr8AsRRM=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=CSDHm5KS4100ZiF1Z6H8c8gSGWvuJaMER5QnDSP+kMoDUIOBNcTx0j6ISw9AV7GLW
	 t/XzOQnJMbQGk0ngjOY35Zxs9KXqK6zYAO6M/fgrc16Bn0BDOJDmKswpJFyUma9u/j
	 nGpZ4dMUl64bvh45y0tR+ynRRdWPb0678IVaok3Dr1bvf8iBPSoWRa5125lW1cBdbJ
	 iwqCnkrRBxHBHT0Tskb45wjhMV6BmWotCL2RPDGU8kPDmthvBX+dgBJio4Pg82Zan9
	 oS0+hHYxEBbXmkfMX4RAsTJJhnxo5QjRgALU+TwfaeISq9B5BqkgSfXgZ1BHjWTDUL
	 ThbHFuJHdLT9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7EC7B406E5;
	Mon, 27 Jul 2026 09:09:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D9EA9490
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:11:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CBE92605F5
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:11:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 286mKuxKxlOU for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 07:11:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.94;
 helo=sender4-pp-o94.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org CD342605ED
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CD342605ED
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com
 [136.143.188.94])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CD342605ED
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:11:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785135207; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ceSm6sTLZpf42EwmzSdcWpWPAwOHJMJFwZVYkUdmUktonvi+mxUcKHXgWkOF+MGeorjx/AfPxdBSERvoSUTkVsRNsvSvdsoS4muBI85bBaRKlIGHChB1WmTww4EYnGk5NXPuu4h/2BRkGE5yyRBCClQpxLzE3VBbZ0PPu4pf8GQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785135207;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=RkWOLIdO/tI3fAHj5KqjWhhNYuAmp2jlpaCnr8AsRRM=; 
 b=h1M6NxJ9t4uGtV/FkWkINu5+9/SmosR0iNuu/FyrBYtTIL9L/LdMpceYsuQt4AnXCJmBcm7APkqUPkTZP7b4An/UchqlucFtiqZXTBrgJmia2LUFVe3m5xcMvthaXZQxescSlgGTVpJ9e3jP5jLEHUWiiN2QUF9uVUCT9KFXZBU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
Received: by mx.zohomail.com with SMTPS id 1785135205117513.2329921913612;
 Sun, 26 Jul 2026 23:53:25 -0700 (PDT)
Date: Mon, 27 Jul 2026 14:50:14 +0800
Subject: [PATCH RESEND v2 5/7] riscv: licheerv_nano: Use upstream
 devicetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-milkv-duo-upstream-dts-v2-5-51486b4549c7@zohomail.com>
References: <20260727-milkv-duo-upstream-dts-v2-0-51486b4549c7@zohomail.com>
In-Reply-To: <20260727-milkv-duo-upstream-dts-v2-0-51486b4549c7@zohomail.com>
To: u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Zhuxu Ran <zhuxu_ran@zohomail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Kongyang Liu <seashell11234455@gmail.com>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Guodong Xu <guodong@riscstar.com>, Andreas Schwab <schwab@suse.de>, 
 Junhui Liu <junhui.liu@pigmoral.tech>
X-Mailer: b4 0.15.2
Feedback-ID: zu08011227ff65b92d345cc1f488ddd844000006be861c6eecdc8eaef5d85e9fa36db3d1f952f8f9e234dd8c:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Mon, 27 Jul 2026 09:09:33 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1785135207; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=RkWOLIdO/tI3fAHj5KqjWhhNYuAmp2jlpaCnr8AsRRM=;
 b=RO/Q11L1BBPssshMVEXpZ5gmHTa8wqQxjpKhQ5K4oS2l9w/nonIpWRDqTcRnb9rQ
 vA4xZJq5GRX1vS5YXzypW92NkjPRQ9zVHGcSwK6FwWYJ2h+JK/YS/Hzet30+eaw7RVq
 hMxmbeECX6j6nz3/vpskHFM+AlC/O/K9y5rXaoZE=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=RO/Q11L1
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
From: Zhuxu Ran via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Zhuxu Ran <zhuxu_ran@zohomail.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Switch LicheeRV Nano to the upstream SG2002 devicetree by enabling
CONFIG_OF_UPSTREAM and selecting sophgo/sg2002-licheerv-nano-b.

The SG2002 clock and MMC compatibles used by the upstream devicetree
are now supported by the existing U-Boot drivers.

Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
---
 configs/sipeed_licheerv_nano_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/sipeed_licheerv_nano_defconfig b/configs/sipeed_licheerv_nano_defconfig
index ab29f327d7a..6754f3c0f7c 100644
--- a/configs/sipeed_licheerv_nano_defconfig
+++ b/configs/sipeed_licheerv_nano_defconfig
@@ -4,7 +4,8 @@ CONFIG_SYS_MALLOC_F_LEN=0x8000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x82300000
-CONFIG_DEFAULT_DEVICE_TREE="sg2002-licheerv-nano-b"
+CONFIG_DEFAULT_DEVICE_TREE="sophgo/sg2002-licheerv-nano-b"
+CONFIG_OF_UPSTREAM=y
 CONFIG_SYS_LOAD_ADDR=0x80080000
 CONFIG_IDENT_STRING="licheerv_nano"
 CONFIG_TARGET_LICHEERV_NANO=y

-- 
2.55.0

