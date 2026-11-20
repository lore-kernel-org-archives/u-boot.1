Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01991606A320
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 13:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Iheao82m;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YJIEk9g3
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2179B8167E;
	Fri, 20 Nov 2026 13:21:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3osoO6Q8qGy7; Fri, 20 Nov 2026 13:21:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5FADB816D4
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795180883;
	b=tIvO3jP+n0qpvm50moEGjWAwZ1kEebkjs5Ma/UVV7EzpMinSQU+wIb455XqWXCEgwKwl
	 GnpOFyek8Bw/zCq8KG6oh3HVt/WYc6kjFrjW8aCO+JUYhqpY8tdU21TVzMXvox/NM6pmx
	 Y2aA9BguAoYm1hwsW841jGMMALlJg/cs3uUvZhH6FSwLkflQzHNGhnaezX3Eh+tHx9lPK
	 Qi7WUfLxEShQXTTvVmbBdmti0VHSn0j3RdoBo39Ew51a28SiIWYX1jzZET9303P8Vckic
	 /s62I9fTxpxh40BFDt8QKeFXponVoDMzW+RT3czgrLsIGX4wKZNsCajGMOIkwPopxEw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795180883;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WxSp1RnHAbCsv/fc9ptSNnA8RTgknIUHNVBB4/Jvre8=;
	b=BvHdTo/F+Cnx7Fpa/XgcBwV0bQ97bw0tL8AQEPOxo8TU13zxAuCVQsmZ9tqkKydZMtBA
	 PzJUb9cYHnaQqXf3MBWzdgE9/Ku7oIbb6OQ470Egv0qWQNt6nDBDe7y6MVCRty/0R8Jbb
	 S5ARUM87cUsRrq1TVB1QiDv5JU56SzutSPLw3eNFOjQrXiQDRq13jXqzEdvbbsJFsQzSQ
	 1g+NlUr7ZYoi7nBgmiweBIX6ZZvpjefMErvMY138SdoRuCou/ma1rAnO16lnEsNrUjLYN
	 +Vj/7bcEoqOV8UAgFzMMhVOewZCLF+UNRbbIE4x7WoYhMIXi/9qwcWRxt91bwjZidgA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YJIEk9g3;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795180883;
	bh=WxSp1RnHAbCsv/fc9ptSNnA8RTgknIUHNVBB4/Jvre8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Iheao82mSla6JvGFDq986gPaA6z0/nZT4NcsE0s/eRR2Q0bqJObcXKB+xVj1FNisj
	 EVoEXYBmb9Y0aBPxpB+o2W48CTt2s/DLYyne1g8j0lY3y5bKc6Y2JwXeuaSMGPLIb8
	 9ZgNh6LwEUJrI+Erp3Lop4PcuDl0/Yjnw7uR23ecybzb2x1dE1N2xE/QSsAbHwhRPj
	 0p03Z9kAN8kTlFsaBqIDinxThIfzINESnp0YDMOsYQ7uNzPZsJKTYBghUOyC+UTXv9
	 4yB13IHtl1hEPKyHco9+/qmGExbHwHZNcNne4gQWBX9+6tw9Z/RfOUNvtDiZQo7e95
	 SM5pkWQjn3j8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5FADB816D4;
	Fri, 20 Nov 2026 13:21:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 95BEC260
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 06:37:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7C5B6815AB
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 06:37:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qi2YfSvEOOTZ for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 06:37:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E68E380F81
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com;
 envelope-from=sycamoremoon376@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=YJIEk9g3
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E68E380F81
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 06:37:31 +0000 (UTC)
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-cd6acc50b8dso302437a12.3
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 22:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795156651; x=1795761451;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WxSp1RnHAbCsv/fc9ptSNnA8RTgknIUHNVBB4/Jvre8=;
 b=YJIEk9g3PhsmxajXY5gbmRTs+okswNxAJwoRuqvJm6xNhYfek1C7JFj0D0DGG5UlAo
 BsfQElcjo8I5mWo0jr6+RhZ2HJlByMwZ8MkzrI1mVaiXzb7WFk3DOoPomQ8MbVApSvbw
 LV8OiVyDsKmQZ86Lon1865XqviWOnHtsLjICrkNItYxQOdq7ZDyMw+4bsYLyN/k0Q1sd
 1ILTz1DTKs2a3QlDQJQuvyCRygaZyGtn0E1QoVXM5jCI0KlSdMJabfiRX6qYSFYtMBHE
 Wd5NGndUmWEAKkOKGJDnMpxlyuwoODTj2MdBKax49pugDXRHyw1DP8lcpRrjX9fdbUlG
 H00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795156651; x=1795761451;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WxSp1RnHAbCsv/fc9ptSNnA8RTgknIUHNVBB4/Jvre8=;
 b=Go5BR97vZdXsOsFiDIXpr8ZysTCc7IxvW/Q2gd9zeY5FM0rkQEERJsRw7BDXiIqBek
 aP1Gk+RyiqDXH+WNa+SWtwaJbgpdcRWe0D9ohLx6Bi6NPGqhwbSj7NdkyLCPJaeeCUWV
 mVhZMEVcFTevzJEaZj9nccDmib7yFYJT3octRedee/7VzZWhm1yoIY/+4brU/R87FBN8
 44oVlk5gbDHW/BXR3AwkqFiAbmOSOyubO92zicvib/gA2Li7BQqopxOfrTvUYJY1FfM9
 S5vZRdlYa9M9pc2wb/ZIFZyhjYvpj+jC2Jo0wwqClCRFyNcocJmKDMD2TftGl/Du9PG0
 MLTg==
X-Gm-Message-State: APuU4Z+foNFAixPkLTw7aH7CCHXqdTvLly8EuvIxH1jSz9yY2DpWeiaP
 wOkG2+0jjthdPa3kpCp5f8M8Wji7tWBEMsxJ+rcxBlMZD/qH5v5VhWMlLVaMJEOPzX8=
X-Gm-Gg: AZFdTZcyK4MVV13wXPhTVUnwhpk2pqvlvSQP5l2Rb9/B3F8UYlmYVtVBL0HqS3G/Ffr
 kECHzOdXCS9CsRu67VWdoLOQ8RnsykDRh1VFfFM4IS1NJ+o70Ss2taioGV6MXU+eLTnC1+N7/7o
 j+G64BA0KVo6zQTWxR9bEsjCpQlL4F8Vh0BB51fUFclXMKaSI/ONqTqJ9eFs5u/zQKGXIGN3asU
 j0rp2jijslqhZWteqqzuFLrYE5YrsezpPkIGloh/EMusX3jZZOyr6E7Mb6ijogLOLJFTkABm5EI
 fPRXTb4m0dUqV7O5ETAMtvf9NP+2JBjh2o5uQqpuh3+RWW9ycwjKdVSJaNtgEBsv3kYwWcUbtMR
 ZK1bgyMyCL+1wtL8kDEiMmHLpzpBR6jHZSESKnWbVRlZm12dL8L7s9/C2NlyzI+4poac5Cpp/G9
 4YnuIE1fPtIH/WTHUQcvIZIM6gebIU5WBhEJ8aSwL7Q7AZIzDtKW9CLgjyvW8JNW3IUN/eN+JLl
 keBiqmW933MREbVG5gk15cpJU0HHKK7tlqDS8HJCtXKoveSCly2b9rXePgblbPyog2crMZ1/rto
 jomNsobKbE1U4fwSvKuGVT7Vy4bkOcZTsYEKpRd+COnL
X-Received: by 2002:a17:90b:2803:b0:3ac:ad90:7090 with SMTP id
 98e67ed59e1d1-3b41c9830c4mr1674461a91.67.1795156651242; 
 Thu, 19 Nov 2026 22:37:31 -0800 (PST)
Received: from morise.tail.syca.top ([20.89.104.82])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b41adcfe16sm2894325a91.17.2026.11.19.22.37.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 22:37:30 -0800 (PST)
From: Zixian Zeng <sycamoremoon376@gmail.com>
To: u-boot@lists.u-boot-project.org,
	u-boot-spacemit@groups.io
Cc: Zixian Zeng <sycamoremoon376@gmail.com>, Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Guodong Xu <guodong.xu@riscstar.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Julien Stephan <jstephan@baylibre.com>, Johan Jonker <jbx6244@gmail.com>,
 David Lechner <dlechner@baylibre.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Eric Chung <eric.chung@riscstar.com>, Yixun Lan <dlan@kernel.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Guodong Xu <guodong@riscstar.com>, E Shattow <e@freeshell.de>
Subject: [PATCH v3 2/2] configs: spacemit: k1: enable Ethernet support
Date: Fri, 20 Nov 2026 14:35:57 +0800
Message-ID: <20261120-b4-k1-emac-v3-2-120679f97b45@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261120-b4-k1-emac-v3-0-120679f97b45@gmail.com>
References: <20261120-b4-k1-emac-v3-0-120679f97b45@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795156534; l=982;
 i=sycamoremoon376@gmail.com; s=20260926; h=from:subject:message-id;
 bh=XXet3oY74JmM+MHkmnBAMc6n2XQq1ypQXjBtOCliD6I=;
 b=3tAG4zSODdyOSZ2FvCj0mOfnhsYVtHNBgEBL8qRodFVApfuBp/ze8i+vO3kfj1coyT2/wbNXA
 gLkhOZp8M9jB4+r/hc1gKqBBlX1/3IcJWBnwWBBle6OWPDjG9Fggv9S
X-Developer-Key: i=sycamoremoon376@gmail.com; a=ed25519;
 pk=xO+BwE3DuX3uCUVEo06fonjJtjMp0vUdCPuPP450qO4=
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Nov 2026 13:21:18 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable the K1 Ethernet MAC, Realtek PHY driver, and network commands.

Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
---
 configs/spacemit_k1_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index d9cb6c8cebc..ce0ec4e80f7 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -53,6 +53,7 @@ CONFIG_SPL_POWER=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x000a0000
 CONFIG_HUSH_PARSER=y
+CONFIG_ID_EEPROM=y
 CONFIG_CMD_TLV_EEPROM=y
 CONFIG_SPL_CMD_TLV_EEPROM=y
 CONFIG_CMD_MEMINFO=y
@@ -64,6 +65,12 @@ CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_EXT4=y
 CONFIG_CMD_FAT=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_PING=y
+CONFIG_SPACEMIT_K1_EMAC=y
+CONFIG_PHY_REALTEK=y
+CONFIG_PHY_GIGE=y
 CONFIG_EFI_PARTITION=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_OF_LIST="spacemit/k1-bananapi-f3 spacemit/k1-musepi-pro"

-- 
2.56.0

