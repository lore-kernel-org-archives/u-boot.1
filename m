Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697F9CA5FEC
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 20:08:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 13F1740AC6;
	Sat,  3 Oct 2026 20:08:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LcVOKc5HNzgC; Sat,  3 Oct 2026 20:08:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5C48F40EBE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791058098;
	b=W9Itm7xn1hNjim0xbh8yBh2hLMU44JMEnRxWoZ1KGIU+bCIHmIc16O1uqTzCPbaZWDQh
	 0OugwDihxIbmEYIofK8TgWo71dbL+xMQXFDdjr9ekIDBsWhuHR9+XMoUAaUSA57UMuP74
	 Bh7wjMCNfr7uXFVTQCK0svvykPNJjno9gboStyMktw7oPBnBGCQa7jdVZFJ1u8V/GNVqo
	 g9/j/og+y0+WnjpV29HV6Vr0HLaQ2QIUWtxh718kt58tEZ1PLczFOGyLzFg1JIM5rv+62
	 28u3T3XUdWiMecYg3W0GRuHDwwJkps0WZOO+256U/hzqYbxMcImZcszxJU+e80qnAgA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791058098;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=p9Lp+i4TTMjuQOuR1c6AiYrXgg60g+iH8r02mxRBhhc=;
	b=ObpQrd80A/MBK/p1/OfFVLyj41cfEZlF2R95iVB88GCkrcS0e2enl5DNNdFC7l8Y2MXE
	 5kGSvFB/Htac0W6QaA1QyH1FxzA9X1qLWB5Y3WzXVIFruXb+3dRVHCISQvUqj3NSmxsK0
	 dq20MBfDVGUf2zjJqGLAcseSieJ4gc76ExLka96zWP2npB14O8qJcJR3Kb8+p83IdTsJs
	 c8Swlut0Olvi6IBhpFMptF0qi4ookF54XpWVwT6eHLyA8N0StZndJbElYxk0ON8K0XquZ
	 9L5nJKfZjwdiX5N3laVgfLk9d0cBUCAn3cZh5n1oZoEnL1a/7G7KvIhkc3rX8gVA94Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791058098;
	bh=p9Lp+i4TTMjuQOuR1c6AiYrXgg60g+iH8r02mxRBhhc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JGik6DP4w67dP9F1pR5DYaf38RP4O/kX9rYsPNl6MNpWsM4kMEL1KG0xlGmmPmzlH
	 CkMYEVkwBpYzlIL0qlBMNlFElyiAKYgXUHSagbSG/+8XzG8GwUdLv39uhDcAnzK4Bq
	 xtV7j2SbrUuuBBzED0/KC1gYTd5M/lfPLO8b3WocIE+LpQJhe4z3WenuRwDMJKPBJH
	 oTPcTTNNvPVy/B3J3xvUlRsD+mvN6SXFyLJ/gQNc8tXdcp1mCTAM8ypoqYwYPTsAvl
	 uD86sSvQNVw+kch7IWq4tFrBa0KTwJT9Ufc6rNWpNwF0AOTdKdQhQSP8VhEzQ5DYw7
	 QLIoXMjNygphQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5C48F40EBE;
	Sat,  3 Oct 2026 20:08:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B2B17476
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 20:08:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9540A605F5
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 20:08:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xa35gCk2pQYl for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 20:08:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C5F4B60624
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::b12a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791058091;
 b=F2KRVl/pt+RePHOza2KXSCd5Lz7PgdcgxvuIe7Y1muubjNto5yGazGkFsRf3O4ox7e/4
 sXZ8mLxP0Np2QLNTzX0wrptb/xFJZ0l7N0b0nI2tupq5GEDBTK4KIPZyCQx7zF0MEhV4O
 uk3vU37R7Y1JncdTI0bQ6ayuDokWlgKwhHl2VZ6+mQ6+N082mKjJWOvUzoihSVG1IaChs
 bZytM1UwAMfBLZD2wenL0jWZvWlcdoHVIBjjmAZ9RQa4RCyEzuPRL8Ph39NOKILOPzE5k
 k/HJ+maq+KWBKqI06gMuveaejdQ5C9u/H35NbP6ZZttusOE50WNBrC+EvOkJZRBfzqw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791058091;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=p9Lp+i4TTMjuQOuR1c6AiYrXgg60g+iH8r02mxRBhhc=;
 b=e217DTrqOsSX7+Uemw/j8QMbjalp5b1WZEOCG/NhJm4BtgQMAncGntfJ5dI9vUFvZXW8
 AAUb7S2NEtzhrA3W86KfbmoWzZWAG0Yf2Gf3PRAOcagEojJt2Tl+zcWavp+u5xCeMKaK/
 Ig4+/3kBO11DYVo071weXr2bx2I81qE2WPNmLdkRpsYN2h+DyBk9CSd1ylejFb6deXi9+
 GREcWIsBEmESdOW/ObTnCiV6v/7oMRbGwTAWg8qq/19TDD1B8T6dI9cI9Tj5jL0Vx9VOa
 OcNgGV+0Pb7EYtrfTn07YgSmLXagOa/qT8R6bp3oKKBnOkwpgPcpbYG6zv4T3sJDT5g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.tenstorrent.com; 
 dkim=pass header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b="LGt3/mgr"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::b12a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12a; helo=mail-yx1-xb12a.google.com;
 envelope-from=asrinivasan@tenstorrent.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=LGt3/mgr
Received: from mail-yx1-xb12a.google.com (mail-yx1-xb12a.google.com
 [IPv6:2607:f8b0:4864:20::b12a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C5F4B60624
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 20:08:10 +0000 (UTC)
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-67489c8202cso510450d50.3
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 13:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1791058089; x=1791662889;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p9Lp+i4TTMjuQOuR1c6AiYrXgg60g+iH8r02mxRBhhc=;
 b=LGt3/mgrp2xsqQ0rbMlpSy4Q6rmHIq1qxQrkzCyhQnMD4cYmacBKvqAu9dDD0Saxk2
 b7xmi3h0SCDGzz5aQqk5eshAJ5Vd47YL81MKmpooaNfx98oq4DptVtKZFy7nEEWP/tQ4
 oveZX4RyiNbUG87xt897CEnzhmoWhYYxjgAt09UPPG4grA0BuCKpNg3Xqm/F890gNqhX
 iDno5BE5494l1RWo8TJ5pVi6dpw0zfBCW9J8FKbVd4tZlZXRe4QuDriqx/b5MOwPJyDx
 nAASOiI9Jpvkwb6bVyAYhlPjNXMF2onJbuvKRRAOOvVrWwKmUMeZmaB2l32KIkfxHRtd
 +BPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791058089; x=1791662889;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=p9Lp+i4TTMjuQOuR1c6AiYrXgg60g+iH8r02mxRBhhc=;
 b=nyGaaxifI2CGlGxDQU6NXkQx381k7ob2nAA2qStsIScWqZzKC9CQqJjFJrX3QZ4pPp
 br7qPBwsk+L1wg4XMQBNH7ujcj75Qaaqf6PaMFaLfL9VCjhMYZeVst5LatGMbE7Bf5rs
 KSr9+QztDZQlW/7nKimtNM8awLMAeZozHTxy4z0LECkl6mAC0E31eLSnfN1IpJsqLwEy
 hoSoGCAhdpMJENV+v5Rh40JuKkoADc0OTcdfIqmA5T9un3A63KXoQK2JJcS6dTwZGOWD
 DKZtBKI2kpN6knhLVAkC0TucomlGVs4bqypyravn19ut4DABlAlFUuDamj0Dq5gj71kq
 2HjQ==
X-Gm-Message-State: AFq9FYLNmO7KZII+eHNcpRKQszTqrsd+iZ+qkVUho7brSllzGDJgJBw8
 +/zq/816cL7yp3loSZYWMdqAm7QkhXkyIzycUSgR1NB69lMxUEy5ldsL2CDBf0g8xzko4gostkU
 P6FGejNo=
X-Gm-Gg: AYBFou0TYrIM44BgIrAH8bMmeD92S1UOUmVA7mt+6bGyWysYnNYu8CXIoKzRtr8eO9h
 hbSqiRhdm/kflsgEiW5ObMcV9NXM4RyGYotX6zGXP5TjpeyWQ/Nzp4nEZ6n0+FrfWD4jyCOYamB
 GH9kkv0LqQ+RNjePJWcBz0dNNkcui/gYKxIuiY3N1nRCb9g9gWEpshkh/OHvum8CUtegUVQcgYI
 SCbbfK6DC/rpp1mIxRdnjFM4Z93r0nROee+vXKpzrYz1qmyP63cSndui6KklttEguCQtO+99aLx
 Al3pIWoGSwSxc/lyY2KrviS7cTuC6rMgx74apiKZ4HmNRQWYcBtQsll8Gel2EYnbtL7FLPclztJ
 /fgoRKkP2U5zN3dcjVnmrDWUOe4zSFPM1GcL9mmEc72Ng0bfgwLZxf6KDu95srQpJSgUnsrQQrB
 A0lbGTpE5OS3hETcQxrzIs84zM7z6wDIzB5GDc+bSDOrkdTxPVN5UA3yZ97A0iRNH81+Wwv5EmK
 XP982XkcEGmMhAMozTlEcEKfHIJDUpydap+sgpk7xvE0In4fq62wEhAnzRrG0s+
X-Received: by 2002:a53:d04e:0:20b0:674:e07:5498 with SMTP id
 956f58d0204a3-677bd376597mr1031101d50.48.1791058089291; 
 Sat, 03 Oct 2026 13:08:09 -0700 (PDT)
Received: from [192.168.2.129] ([2600:1700:220:59e0:e2e9:9d9a:5aeb:a046])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-677c16c243esm986048d50.0.2026.10.03.13.08.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 13:08:08 -0700 (PDT)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Sat, 03 Oct 2026 15:07:57 -0500
Subject: [PATCH v2 3/5] bios_emulator: use driver-model functions for PCI
 config acceses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-aspeed_vbios_fixes-v2-3-f8e593f024ab@oss.tenstorrent.com>
References: <20261003-aspeed_vbios_fixes-v2-0-f8e593f024ab@oss.tenstorrent.com>
In-Reply-To: <20261003-aspeed_vbios_fixes-v2-0-f8e593f024ab@oss.tenstorrent.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1
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

To allow BIOSEMU to build without CONFIG_DM_PCI_COMPAT, update the
PCI config space read/write methods in BE_accessReg to use the
dm_pci_read_config8/16/32 and dm_pci_write_config8/16/32 methods.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
 drivers/bios_emulator/besys.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/bios_emulator/besys.c b/drivers/bios_emulator/besys.c
index 23392d3c86e..e02c9fc636c 100644
--- a/drivers/bios_emulator/besys.c
+++ b/drivers/bios_emulator/besys.c
@@ -435,27 +435,27 @@ static u32 BE_accessReg(int regOffset, u32 value, int func)
 	if ((function == _BE_env.vgaInfo.function) &&
 	    (device == _BE_env.vgaInfo.device) &&
 	    (bus == _BE_env.vgaInfo.bus)) {
-		pci_dev_t bdf = PCI_BDF(bus, device, function);
+		struct udevice *dev = _BE_env.vgaInfo.pcidev;
 		switch (func) {
 		case REG_READ_BYTE:
-			pci_read_config_byte(bdf, regOffset, &val8);
+			dm_pci_read_config8(dev, regOffset, &val8);
 			return val8;
 		case REG_READ_WORD:
-			pci_read_config_word(bdf, regOffset, &val16);
+			dm_pci_read_config16(dev, regOffset, &val16);
 			return val16;
 		case REG_READ_DWORD:
-			pci_read_config_dword(bdf, regOffset, &val32);
+			dm_pci_read_config32(dev, regOffset, &val32);
 			return val32;
 		case REG_WRITE_BYTE:
-			pci_write_config_byte(bdf, regOffset, value);
+			dm_pci_write_config8(dev, regOffset, value);
 
 			return 0;
 		case REG_WRITE_WORD:
-			pci_write_config_word(bdf, regOffset, value);
+			dm_pci_write_config16(dev, regOffset, value);
 
 			return 0;
 		case REG_WRITE_DWORD:
-			pci_write_config_dword(bdf, regOffset, value);
+			dm_pci_write_config32(dev, regOffset, value);
 
 			return 0;
 		}

-- 
2.43.0

