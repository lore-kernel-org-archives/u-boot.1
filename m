Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B7EC44532
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 00:52:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 482CC409E8;
	Thu, 23 Jul 2026 00:52:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pDG4rn1vkna6; Thu, 23 Jul 2026 00:52:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8A55540A91
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784767957;
	bh=2Jv5E1xnnC4GZIEE6j8nSzIXoWwS7uAZpkQ1EORuXi4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Yi3a1+fZRv/lcvF1GXNaUQ/7vehDjegh3qm2jncg478KcXmA9hqzVXI3z8NUYQ+X/
	 tNvzl8AN+dFUuofcS84vvQQIar097YNqO9i8GPxHR+JD6PVpQR3url6Eii+VROWZy4
	 CLr3OBgPaPIivBOCs/7l7NvsQ08zKs083LDDNeg7OGWYsVzuNOSJ60rNr5jMHJ4+Ln
	 mIIM7jMNv20OSau3cIKHeIMYi9hjzyLhCcN2X7uXoDz5TeZyJSERt1Z6i+La9UrPZY
	 SMtkYU7UCOT/Aept1Eeeo9U60ghsS0potteDNv2ZCh2FeiaF36lCvqlb8T1fcOLItW
	 Z2RG7ap9rpDzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8A55540A91;
	Thu, 23 Jul 2026 00:52:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 441032E5
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 16:22:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 275C580F33
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 16:22:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AZx67ZzB3LEJ for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 16:22:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=fugininsane@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3FD7F80F1D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3FD7F80F1D
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3FD7F80F1D
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 16:22:05 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4954aff6088so37202395e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 09:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784737324; x=1785342124;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2Jv5E1xnnC4GZIEE6j8nSzIXoWwS7uAZpkQ1EORuXi4=;
 b=KehSGQvbN8c40mIPYQWXPBCnpt5g8ymWjbXCm1pp5W5nOk4USuD+olpOfvAKwhtu2B
 g5TKMmPYmRh6nb5Mp+UQYmU41iTFY6/KDCESyhPeSdheraWEx+mPk2LSZvUrl6KHQLFg
 GbDwjGTFXtaYAob1SzjrGv721UMEu/cJUamBsx34z0foyuTWVFYfnBDMoTMZX7RASKVI
 dtc3FVsoVq8+nX6Ys0TEkpU4i8N+qdC/OUmknVCP7Wk+fMWR9pcIZ2aSnwJpcLHxVs/Y
 PU1SPUWJqdqUjAfALGSWzTxu6fcepbXhkRzfj3x7APz7bPMQQKSrZT7Y7wbbL1YMBX+n
 ifAw==
X-Gm-Message-State: AOJu0YwKKRY2RWLwG8WXJ7YQvQsQZ9YwnkHKr2pWijg2TB0NguYX8Lpc
 uEG56csN5Z3zapv7+/HFCjPxQ0PwkhOBnqW20yEm6q0ZpSvE4gScg/IngydPn2q5VRFfuA==
X-Gm-Gg: AR+sD12JByrz4Ng96KnOi+CfITPG/wZU+NSjos0fc6Qnetdpri94IIMwmW8zpZAtTaS
 oT9Ym/4X13B/1XFjMpKk/2S7CObfhDf9WNL4y6KDRqCUKpWYrCgllCZXQrDX0o4P4dzQvje7ZfR
 ejMZDIPWr0CDIKoFf9k2q73Chfi7szMPIRvnqhFsaJZL1o61p+abyw/XIbPdIse9zy95xbHz/e3
 9OuWxmTw9qGskldJ/RPRmlcZHtr2i5m2er9389K4dMm789pulpHIrLfwhSc86nkxmWvsxwh5ult
 4YQWCLUf2bowMRRRp8/qEvcgDiQIH66RAcP6yneo+OXVBtU2ZPbvXsv3B8kMbGq1NgruUNaFqxC
 5fRYjkG6JBIpRnNzOyVApGTA6hZQ0xLU4KQKjabt1lcS9wqQvLw751tvpOa0cWdNATtFFjAfNR8
 U4JNbyKVu8ULk/Kgt13TFBTdLF
X-Received: by 2002:a05:600c:1550:b0:495:6e68:5df2 with SMTP id
 5b1f17b1804b1-4956e685e95mr26838875e9.12.1784737323686; 
 Wed, 22 Jul 2026 09:22:03 -0700 (PDT)
Received: from coolemuke.fritz.box ([2a00:6020:b320:1a00:c256:1463:a40b:d8c6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a509901sm144942985e9.8.2026.07.22.09.22.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 09:22:03 -0700 (PDT)
From: "=?UTF-8?q?S=C3=B6ren=20Hantel?=" <fugininsane@gmail.com>
X-Google-Original-From: =?UTF-8?q?S=C3=B6ren=20Hantel?=
 <fugininsane@googlemail.com>
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?S=C3=B6ren=20Hantel?= <fugininsane@googlemail.com>,
 Claude Fable 5 <noreply@anthropic.com>
Subject: [PATCH] mmc: sunxi: Fix mod clock register offset for the A80
Date: Wed, 22 Jul 2026 18:21:26 +0200
Message-ID: <20260722162126.2790195-1-fugininsane@googlemail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 23 Jul 2026 00:52:16 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784737324; x=1785342124;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2Jv5E1xnnC4GZIEE6j8nSzIXoWwS7uAZpkQ1EORuXi4=;
 b=fPsf7ZaHCNU3cDYiVMSJdQCpW9Nd4GFSddd+cD3Iu3KaBFMyxjpxgMhRMmp3ajQXDV
 lj583VjI78Hfu3KINxcI7yOhUj+5EF7MxlhQHHjyKqhVrowW/nVaqqA2wWnB1PWk+zKw
 uhCCNPDy/+K4p+68CRsQcdhryxc/QcUkUJYybF9Vfg7m8vDJlbzVLvOoDzF7D7pTu7kR
 0bxNvo/HEtA7nHpw5AvRDXm24n/W+QupRBRZwBkt/G/5F0OcXZXAGWRdQW+nn6Aj3rfL
 5Vl/t5TOgHSOBXdMWjRtEa9j9c3e1g9xebIXyJCYrutUS35A/pi3PC8EYqU5ilLhNclI
 cH4Q==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=fPsf7ZaH
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

get_mclk_offset() checks CONFIG_MACH_SUN9I_A80, but no such Kconfig
symbol exists - the A80 is covered by CONFIG_MACH_SUN9I. The check
therefore always fails and the function falls through to the default
offset 0x88, which lies in a reserved region of the A80 CCU. All mod
clock writes from U-Boot proper end up there and are silently lost,
so the SD/MMC controllers keep running at whatever clock the
SPL/BROM left behind.

For the eMMC on SDC2 that means card identification runs at the
~48 MHz the SPL used for loading U-Boot instead of 400 kHz: short
responses still limp along, but long (R2) responses are received as
all-ones, CMD2/ALL_SEND_CID fails and mmc_init() returns -110. This
went unnoticed for years because the SPL uses the legacy code path
with a hardcoded mclk address, so booting *from* eMMC still worked -
only U-Boot proper could never access the eMMC on sun9i.

Use the correct Kconfig symbol so the mod clock writes reach the SDC
clock registers at CCU offset 0x410.

Tested on a Cubietech Cubieboard4: eMMC identification now succeeds
and distro boot from the eMMC works.

Fixes: 0237b3047e25 ("mmc: sunxi: Refactor mod clock register offset")
Co-authored-by: Claude Fable 5 <noreply@anthropic.com>
Signed-off-by: Sören Hantel <fugininsane@googlemail.com>
---
 drivers/mmc/sunxi_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/sunxi_mmc.c b/drivers/mmc/sunxi_mmc.c
index e28c81af..623393fc 100644
--- a/drivers/mmc/sunxi_mmc.c
+++ b/drivers/mmc/sunxi_mmc.c
@@ -663,7 +663,7 @@ static const struct dm_mmc_ops sunxi_mmc_ops = {
 
 static unsigned get_mclk_offset(void)
 {
-	if (IS_ENABLED(CONFIG_MACH_SUN9I_A80))
+	if (IS_ENABLED(CONFIG_MACH_SUN9I))
 		return 0x410;
 
 	if (IS_ENABLED(CONFIG_SUN50I_GEN_H6) || IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2))
-- 
2.43.0

