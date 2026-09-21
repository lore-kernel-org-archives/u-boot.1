Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0902C982FA
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 22:51:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 302D860714;
	Mon, 21 Sep 2026 22:51:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id keJmxOwbLAba; Mon, 21 Sep 2026 22:51:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4B86E6068B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790031109;
	b=n109Lzfw5AlXBV4ZsMdAsnqvN7xLWbDyuveIZue7o6TtKYi5Vx5aR6OQgU6oFjwGRaDP
	 uagUoFtgCom2e6X9433ftejvaYikP7yJpstq2i48tkK37Ao1pUhOfh6pGA1pa3jbOJmW8
	 p9kCfp9vG0ZxCWWZUR38ApAL3n2zdgz+SOSSGuRJ1K5arnqFl5V8jV938blnxIVTcDEvO
	 VzCo9rmm69rxk1EweDdi3i2vZJFdEdZE7u/TTFYW9L+wUryOcQkhe9fx+g5hmCOhD9aAU
	 e4OYu87g+ngEuvJdggKGj6pJAsxdVCFSPeDmlmqbqHEpAunzu7xA1CNkFS7YRYs29EQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790031109;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=eGIMBlu+Nj7+5AdtbA+o57WNU0UutNxy5SUOUMc5Hks=;
	b=fhpMz4s81l4CD2XDu1YwiAEMUCDlikxGAUJOUs1V9teZY/1w3ZDJhdvbLAvlI0h1U1aq
	 rvVkXmxnVB0YJOQTQkY54cHSV7IQF9JIm14NNX9gGrcrfS4L7B8bHu7gU0XvpsuT2xyyi
	 nm3IMSi+PmITKOd4Wk7i/izN1wbE4fSTpY7IzXmH+0T4UdLUJeUch6C1Qo/wArIS+1MuW
	 g0/89uxuMLDcZvEALam11fJAuKhl6wEGlt4JxYwxHfnRPi59Ir4u/+rQJtfbQQNah650L
	 b/3arBWzCgq9ZQKjUKtzgpB7FpeTsPH7xiZfWdkmOiMkvVzNW60iPXlToo8vQSF+hxA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790031109;
	bh=eGIMBlu+Nj7+5AdtbA+o57WNU0UutNxy5SUOUMc5Hks=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Eazkzxuj9Mjh2gqEo7McPlrbOTon+zwkbcDUdf1mV+4BMJN45kmWv9yzpKtVBhNXx
	 eUzQSSMQmJ4RNL20uxyV7nHGuFW7ljqTjtDZed4/990OlIOP8/wjPIak/hXOHkdugy
	 HoZ5hNG8zgOcxTPYardP5b6FMWxzwRp8R+IKfAJExxq3aWHedOpdIY1+h7eBM7Tcd1
	 qH8uYO+o/b5UuVJfgIEX4Dlyy+tazuMhQyxvzzuG5JJ9LKE3NyNJBtriovsinsr06L
	 3UKuuNk1ecYyHtM1CAB7VA/JL7LVBApq3IF2BX7n76hdPGmuuR59OgA19bx1KvFe66
	 uuoX+uny9ZF1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B86E6068B;
	Mon, 21 Sep 2026 22:51:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 48D1D380
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 22:51:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 46A30401F0
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 22:51:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F2vNhjaCDfiI for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 22:51:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 65BDB40112
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790031105;
 b=aO1apJdx+oU6rKJUyRfKDNqTn43ZpfHk+araDzU4V9BLBxozcKkI5zQCxZFJampKeiYe
 94GjotjCSNnAz+rFHgNEipscImI91Qt/bvsv/bXfW9GK1347pHcKvyHdVGY5bOEUOBL9N
 r5Lx/HdYN+30utSxJnDkIw6nMp/tCh2xC6LCjYasH7/FjPFaGFV+cCPT1DpQMlHzQ4HQ+
 1mvUQk6MY7bESNCFIDIBMgacUXNgZLUTdoDxX2fPeaf+B1SY7iAiL2GHPZm0Hq7h3Btok
 83nlvPcx0dP84s8TjnIdyQLpBPduzwj7WcjLZFXn+Yj3IGCO2j7KYmk//XKaIU5n4FQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790031105;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=eGIMBlu+Nj7+5AdtbA+o57WNU0UutNxy5SUOUMc5Hks=;
 b=B8D2AY8XLjxg+jer0NTGB6OR0OqyfwC2CUtIkLZ9Iqa58uk36+lBfWYpXWT3o3Vcg9KH
 2qQ0IEK9++M5WKwx4xZxVHQtW3S2YJewZEDFI1T7XhTIsXGghRIETPwkNKq3xWyk39su0
 HpjmzFDv7F87nNOl8H8cSjZkXHKskro3uZmoVpxkQvDxOocpkNmNMRhoCAFSsuL6s96t2
 dyQTrqwMSTdvrQ8cJGrO9Lz7PIdheao0K1WDMTwr5ojDtCDKwgeNcHHqBbKMgTdqJ5Dkp
 vZIWSxKtm1fEFs91+mljnukOFy5ruyWXDKehJEKzp9b+G7zBxFVd9XpDLKH7O78iKVw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=oyGIkw4U; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:30::10; helo=mail-oa2-x10.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=oyGIkw4U
Received: from mail-oa2-x10.google.com (mail-oa2-x10.google.com
 [IPv6:2607:f8b0:4864:30::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 65BDB40112
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 22:51:45 +0000 (UTC)
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-482620dc91bso2542625fac.2
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 15:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790031104; x=1790635904;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eGIMBlu+Nj7+5AdtbA+o57WNU0UutNxy5SUOUMc5Hks=;
 b=oyGIkw4UspCxBTiMs5kwZYZkOHBlU+5ZFOGzkxV1gsD1u9M3/EGCB8lyECZnLAo2D5
 wIpNdffJv5IjcpZVj9BhYH7U4baj1HFkIlvomANBP5bR6mWslT1RIXh8qbHbE1KLEK0i
 hjuxUcEFzEsRReKG9nKWIrrreTv2kjMTRZ9xOT+cWNYeUN01XNgGN0r6x1QWR2C3yV7f
 XuyuFQtPKJ4pam3AHdrq7yrUeJPtFbRIo7naueporgzYc8gyGizdDzi+GkbQFkbqOhIv
 gdZN8REXd1b8/VCHtFL7GpRB2TYrBLIo5kjxsET+jYyWJuT/ZgwjXtZySCuRz60nybN3
 mktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790031104; x=1790635904;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eGIMBlu+Nj7+5AdtbA+o57WNU0UutNxy5SUOUMc5Hks=;
 b=LM43vA677mjCSbK6I1RoP96oV+c9ZhPICz/0O78u6mCSeZa2zQCmesTtn+K0kCthxm
 soiJcbYEWrkQzqzjFXQleTY89YBvIDC0Z3Pkn3BZ1iMI/tX9vW3istS8rikSKsxn81Mj
 eKyxIMuRWAkzdKK3b0qcRIK2IUZ+KpV6+C5r/Mr3/se2QzR2LdY4YyngimDQbZwcVUV3
 CIO3+epWtTVibkEbwVfpR5looUppf782bbZYhSpCRAvZm8iK40BiUzBCy+fGOt5uL5e0
 Jd5yODvQj3WyoVMjYcXxh3f951afE49Fybb1UcF/A89Li64uDaPFz0AWv/MzktmNcOIx
 Nv3A==
X-Forwarded-Encrypted: i=1;
 AKwUvBz6jANrK7dtP2xs4mo/T/5agA9DaU6poInICL2VNFmahZY64CEuJwlB70jX8fjSYxx3Qoc3G48=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nmZpNX4Ntb23w1KqGh8qkkfKlQmgAVHy6T8Tq/thsUsqYBBq97
 JwAIMEGmqfJDJPCb+0NyEaF1N/1Ip/dinBoe9YEHiT4rSjUB0y5J8TIf4xKXaubyclo=
X-Gm-Gg: AYBFou1G1dUKgfJpfREKlheB6TXCzT9Ln7qNoyOcnLc+tKK20bMIKOIuHTkWHFYeBQo
 KJ+Gadb++2ogF1q7szlo7fIafZeIm2LlXbo+y6OS8eydyLspD5Ixgun8ZsqAm0j1ju+t0LSVzNL
 MvXv6RD4IPoX1BvLZL7tNAM4QNhSucfiI0vSx9LTw7AKYD8tLRowu3giEAsyDp5nTWqzuqJtKYH
 fz5A1s0ZVDPOpZOi24e48UCMIKI08/paCLIgR4cPfs49+J4EL0UFdUyJxUZnnXfg3X/CXF/AyQU
 K1ZF+cvsadwfI0D3I8CW+6ZWR5Kkw+mzoRgRgCIyZD5K7B5pC1J+9QF17ofZAKaCfWMeDJxq/PI
 uSuVuCQwQ7oc/4/VO+eU5YVUJwxw4W/LHZqqgaGpP8hzcsbDGh2eXR2HwYl3JwCsMxeeHj2QcK4
 QpuUN9rrtcZscMzfOERmxIv6rR9mqzeeHWpAQ5xgwwgumkpsu6DQMUeQ1ePjZwBFLityytrFymP
 rw=
X-Received: by 2002:a05:6820:16a8:b0:6c9:80d8:a1f6 with SMTP id
 006d021491bc7-6ca9cb53ddcmr11557641eaf.51.1790031104268; 
 Mon, 21 Sep 2026 15:51:44 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:bbcf:6512:c1f9:5b9e])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-48f71e90570sm481468fac.4.2026.09.21.15.51.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 15:51:42 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 21 Sep 2026 17:51:04 -0500
Subject: [PATCH 2/2] power: domain: mt8189: model the SRAM handling of two
 domains
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-mtk-power-domain-sram-iso-v1-2-52e9b365d2d1@baylibre.com>
References: <20260921-mtk-power-domain-sram-iso-v1-0-52e9b365d2d1@baylibre.com>
In-Reply-To: <20260921-mtk-power-domain-sram-iso-v1-0-52e9b365d2d1@baylibre.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: David Lechner <dlechner@baylibre.com>, u-boot@lists.u-boot-project.org
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3041; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=fzQ0pPR83Il0toqKxlgA2ut7WkIZ8XR4js08lY/DEcI=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqsbTybvnYg9lPPa4ua1cXoXSILN4Tqv7eCCWGw
 Y9lU0K6ZiuJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCarG08hYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Ah/sH/1bwxOS7YcslU8zTafV+h29YDwUKh6mPn7JcHzm
 s5ln0FgM1O/u0OMZEPbZPl2gYdG/9t273/iWL/VPdQ1J+kT3wU//1dbAHU96emHZQtMLlcrJS2l
 ueAnh8/7xablyPd0se3zV+wY3PbF0prJH0TG/jWzb3hqSWHexhzpoNRlN2AjL8m/PZa014M/Qc+
 +P7SLKw1+N5QTOBNjkLXcKPpBt9boriIV5ItJQBsCGW0DWTiTngEOl+y5EOwZ+bsuYW4/1ZBifp
 a6lcObXSw4VDlFKuARiZV7bPZ2i2OzRxU8XqgCNYjSSCQ2F/Ykli63L+3/ISCfzMqL/Q8GDX+V7
 Wokw=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

The ADSP_TOP_DORMANT and EDP_TX_DORMANT domains both need SRAM isolation
and have an inverted SRAM power-down bit, which the core driver can now
describe. Set the caps on both so they can actually be powered up, and
drop the part of the comment that said this was not modelled.

Until now both domains carried the plain power-down values, which would
have powered their SRAM down rather than up and left the isolation
asserted. Nothing in the device tree referenced either domain, so that was
never reached.

Linux marks ADSP_TOP_DORMANT with MTK_SCPD_ACTIVE_WAKEUP and
MTK_SCPD_KEEP_DEFAULT_OFF as well. Leave both out, since U-Boot has no
runtime power management and does not power domains on at probe.

EDP_TX_DORMANT has no SRAM power-down ack bits, so state that explicitly
rather than leaving the field implicitly zero, matching Linux. This leaves
nothing to wait for, as both branches of the acknowledgment poll are
satisfied by the first read.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/power/domain/mt8189-power-domain.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/power/domain/mt8189-power-domain.c b/drivers/power/domain/mt8189-power-domain.c
index 503919b7045..6ad2dd4874d 100644
--- a/drivers/power/domain/mt8189-power-domain.c
+++ b/drivers/power/domain/mt8189-power-domain.c
@@ -71,12 +71,11 @@
 #define MT8189_PROT_EN_PERISYS_STA_0_SSUSB	BIT(7)
 
 /*
- * Three things the Linux driver does for these domains are not modelled
- * here, because this driver only ever powers up the domains that the U-Boot
- * device tree references: the EMICFG GALS sleep protection step that MFG1
- * needs, the domain supply regulator that MFG0 and MFG1 need
- * (MTK_SCPD_DOMAIN_SUPPLY in Linux), and the SRAM isolation with an inverted
- * SRAM power-down bit that ADSP_TOP_DORMANT and EDP_TX_DORMANT need.
+ * Two things the Linux driver does for these domains are not modelled here,
+ * because this driver only ever powers up the domains that the U-Boot device
+ * tree references: the EMICFG GALS sleep protection step that MFG1 needs, and
+ * the domain supply regulator that MFG0 and MFG1 need (MTK_SCPD_DOMAIN_SUPPLY
+ * in Linux).
  */
 
 static const struct mtk_scp_domain_data mt8189_scp_domain[] = {
@@ -125,6 +124,7 @@ static const struct mtk_scp_domain_data mt8189_scp_domain[] = {
 		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = BIT(9),
 		.sram_pdn_ack_bits = BIT(13),
+		.caps = MTK_SCPD_SRAM_ISO | MTK_SCPD_SRAM_PDN_INVERTED,
 	},
 	[MT8189_POWER_DOMAIN_ADSP_INFRA] = {
 		.sta_mask = BIT(8),
@@ -384,6 +384,8 @@ static const struct mtk_scp_domain_data mt8189_scp_domain[] = {
 		.pwr_sta_offs = MT8189_SPM_PWR_STATUS_MSB,
 		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_MSB_2ND,
 		.sram_pdn_bits = BIT(9),
+		.sram_pdn_ack_bits = 0,
+		.caps = MTK_SCPD_SRAM_ISO | MTK_SCPD_SRAM_PDN_INVERTED,
 	},
 	[MT8189_POWER_DOMAIN_PCIE] = {
 		.sta_mask = BIT(13),

-- 
2.43.0

