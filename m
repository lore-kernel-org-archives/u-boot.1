Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412AC606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 19:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nEPDbqyJ;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X8yLbgnq
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2077F8138E;
	Thu, 22 Oct 2026 19:03:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bHNO6CWmgxU3; Thu, 22 Oct 2026 19:03:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A7A0E811EF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792695781;
	b=pHLwyUIsgXM4/s+aTK/S1/GWD7HGatEu0wTK9yJtwDMs0yfXUZxUClK9HAVOCjIydyLe
	 VuUFPmE/Vbw6NEDWwctDVOMLrEG/rFyhCukmuesUHcSj/D6H/N1BDEYvG/jFgHpeTVkZR
	 Hfl6pbK0hwOcXEXo/exy+LHVIR74sNOBqsDBdOiblSsnggPZT41sZtpxgvjA3q7eEju18
	 /dYUKTPgaKY4WmOeLlMCLhwWM3zjws5XJztzyaYTGNPGuFDauqgxqGcptlqaGG0T80v5X
	 SyqWczrx6xpiBkB/HgUA+1tH65UjeVezTCbjj23w/dJdkfTI7a1TYv1Z082848k/KwA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792695781;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=yp7K+iu9VxI/KvmHKcs1Y20FjlZNOcVD1DPAlrqKtg4=;
	b=KeZOVsOqvYMGfH9oNmbruhvPG7HIqD2zgwZzwO8KJFy1511aOXERlU9qycMJWc2weubq
	 4STU7Lf5uZdhim09+tppzRrc2nmlnZAO7+VPLHQi5WgY/Hktd9Bgdy1sIGjV1wMJaXmon
	 M8POlGSPVe2g/J95Rvdm4KPXUKRweaFBY9Z6kkKqX0B44Blcbwo+7uspDn6K5UDq+/YDd
	 IXonx1dTC2VPUqI7T/jOhug/sh9hbkjcETG2rKT8O/PQtlyptaMgovmHF5ilLDQncFCAv
	 I4GzHojYqBCljtd1Hdd/+JI1YEv9VsU1ZXSvcnzWML9nq3wv0BU2/3Zy/yQqJOar+Ow==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792695781;
	bh=yp7K+iu9VxI/KvmHKcs1Y20FjlZNOcVD1DPAlrqKtg4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nEPDbqyJ+wpQvpnIfip98G3RW6yCyA2qCmwNY5WdUtqjT3cirRjzXvn1vrSD9nYlW
	 okK5E6D3ubusIyGoEuhTGauiw59CXFFcVOdeiVqblNGl3UFgJxm7GzKyVQt40TDdhc
	 rct54Z5J35ffxjYGP+dl9Zod6JyJmc+MXKK4DZ7mBaEXVSwnxNwngvV75SAiKhU0aS
	 pEIYmIyK/PziPg5lkT5BeOzOEjDVNuzKkyn7qbvDlmo0QCWP9aTWUOTtYUR05yDo1J
	 HIDSWaORk1eXCW13FTp+ecf5d2EAmu+xx4fjBi2W6Hoyh32x3pr7n0PHZhBWbBefJG
	 zAqYELG4NMmVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A7A0E811EF;
	Thu, 22 Oct 2026 19:03:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0AFFC3A7
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E4E8A4099B
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id URnieshAUFGc for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 19:02:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EE0764099A
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792695771;
 b=Vo/5cpcIY7dvhNZCh8s00/92Pw/G2KOi3LUbC11MkJCYtAl++zJ8F1PQu2PRlPgGbIo6
 cA2oxp2b6Tt+FeAwfkfz3FMsiKY/CoktQ/5vx4UJk5/5QO5ZmL//3NPj5zVo3vRNiVUhC
 gkflMWj6Iqi6LxL/FeRXHfp9jfUA2QivivFEUrSN6sR0BTKkoQpohL8HIHAqDrY6UGEid
 UdI/eXzVBTVVufoi/lwBoC5yV7Qjs6T9j2lQ7mK8Ybg3up+SIAA39sVhzlmXKlFjo1Tgu
 kHzN3f9RUv6pjq3Yzl4Z7+Y5xoCa62l4/prXe+ilEJGl7TmP5WUPKFZzxxDEMootVaQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792695771;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=yp7K+iu9VxI/KvmHKcs1Y20FjlZNOcVD1DPAlrqKtg4=;
 b=r9NCMtv7tV8QW973sRlU7YKcxPM/Fn9VfmvCG2IMCmL/BdedEG9VNKMY7Yi4L/fFTc7y
 wILPAATUu6wNEzFWFCbNg4Fx3GpG6WQ36yWb46opiJrqmbkPEAJb1RnnobZwjyN6cd14E
 QajZVP8LSeH7UVGYtYY+ii9bEICNteOXnG7oYww8q2r2YtnQONvrHsJUtwj8BDB8a9LPw
 00lflkxOYq6INTDjJl2G5q+sr5jVBLChbqn0RAEcfG6JonpXpHX1HHo/MebzGsGNvh+QB
 /QMGuqcrQvzDs/mf7OGzVXmqKxA8UdvFe67anBwoblTCpUzr6IBJqoAX5GZxliCpg2Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=X8yLbgnq; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=X8yLbgnq
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EE0764099A
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:50 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so99189f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792695768; x=1793300568;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yp7K+iu9VxI/KvmHKcs1Y20FjlZNOcVD1DPAlrqKtg4=;
 b=X8yLbgnqptxULI9lyLjvnomCryTAsCd5HZJBASRvlnjzvu6ykAGEPhHodYnw7R9Gfm
 oV5GpDJlsoIJ2vrz0pp3LCHpmMyOCiuVSI045Mv5LbJR6Wu/JjBFlFZ/I8ANnSapUo9G
 jghZufi/rvaPgg8Z22wvritwbriDp6EMi3mFcB9NRCy5mWM/fsBQwmfHUJB7L2SZRTmQ
 8TMferF7Da84NxYEO1sA+jGGDktzRlv7+o+4yhAX9y72uDmLxkLediu0s67dp3Xv1rLU
 eiWDZ2jNJy/gOf+TAi0nz/CcAimTrqvhobZ6M6IkNIyVKHqJeug6UUhGPb86X8IZhmZl
 DrwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792695768; x=1793300568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=yp7K+iu9VxI/KvmHKcs1Y20FjlZNOcVD1DPAlrqKtg4=;
 b=bQWY1Q9x5fUDb7NDTmcVK0HDHEKazGNNTbmzkIU1XZin2IFn80JnAQhID5GbZKjfgB
 ON/4L2KVxwxX/0DzGhUuSLy13xsQ8BIHCcOyXSXetyDiNXp87N40K7c60clQpO1a6q5l
 fAI83QZehqClf0DU4XnQoWu0Z7Ycdfa8ZgJsyEeZZbN+AgnuDSev32cIJ01fG75oyZQA
 nNa9c7PigeS7XK13e3WSCDmxQYjW6tEL6N8rITeVMlALa3vzEvJ6sij6UZja4lj8kH3M
 dT+3mo31OmxI/T4zvEzz52pT2oBYsWvjXOxd888/ZkiAbfNHgrKzJT2GjcXEj/1f04EM
 TohQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByQdBdWoCLpUGhwVj8mbFwHpwmuGAbMk3CtsMfoXVA+6tSGyVTYZ1e+HZBRTsn+SSJlNB7MTXQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ4UpcKYKrA4M1ojvLEUFCNj51GSfv+Q+qN7JUzRQ+ic7mcYEWW
 rdBb9W/t2JAqWwK+cVRwP+nuEKGZ0CDmOTOrs60vUGHLW4wKs4FulgV7
X-Gm-Gg: AYBFou0EodHweYnAaiTW44+n2UYV+8o/MGiJc6ZuKXVpj/z4x5i558a2bjMu0Z67NWl
 N7sJkYjf0Z5BYNC7gRKPZAI9IBFP3oZYimzqTSO6q0FMZ0LPHQ7aUvX6CelR31izYtE5oUDN4/a
 Mies2r8lOYWkm69oTBxuVLYYB0avUl7GmiydzlrSv6vOzufJeOyGGClAz7rdafD3pfnY1esq6cj
 CdEYvrtWI+S3fU2CPg1ols/6EPIeUtdu8ctK/Adz3Kx3IpiwNeFPJV3MVQJYle1XyGe99R9qGgF
 x9rXlbFv+UA8Z0uyjiOKMf9gTuFCRrBn+87CHMbdbBg8UG2+DiNe4y/w5sVZANhfQ1XB2tlohb5
 2lF7ABcRhLYAo6bBoCWsEL08i7PyO+i8KS0LKlt0Al7XpExmI7m8wdaXRRn2bL3kHFpGL0oNje+
 CxJaWEqyAEzIr+KPb3NJMVSTqVqSak0AjsSsQlLr18LSHNwwg3F8nEyRtOrlyCISmdS7IEp1kzY
 0IKyVHAR5XW8n3JfcQYB1fLYcd+eLHqwavIHsYCWtuEoa9cMfNvMwR027s7cdRHVgl+1HamM3fh
 +9HnVrPCGw4aD226vcIadbsRXS/xM4YlKZNwkAPSypZHfODD1MAcmXH3yryn
X-Received: by 2002:a05:6000:615:b0:48e:20ed:27f9 with SMTP id
 ffacd0b85a97d-48e263a7542mr13587012f8f.0.1792695768359; 
 Thu, 22 Oct 2026 12:02:48 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-48e37a0e841sm189495f8f.54.2026.10.22.12.02.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 12:02:47 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>,
 Zhengping Zhang <zhengping.zhang@airoha.com>,
 David Lechner <dlechner@baylibre.com>, Wayen Yan <win847@gmail.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v3 13/16] ARM: dts: an7583: add PCS nodes
Date: Thu, 22 Oct 2026 21:01:55 +0200
Message-ID: <20261022190206.666950-14-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022190206.666950-1-ansuelsmth@gmail.com>
References: <20261022190206.666950-1-ansuelsmth@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add PCS node for Airoha AN7583 SoC to enable support for Serdes Ethernet
and PON port.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/an7583-evb.dts | 18 +++++++++
 arch/arm/dts/an7583.dtsi    | 75 +++++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/arch/arm/dts/an7583-evb.dts b/arch/arm/dts/an7583-evb.dts
index d02cd194e8a3..714c90eadfee 100644
--- a/arch/arm/dts/an7583-evb.dts
+++ b/arch/arm/dts/an7583-evb.dts
@@ -65,3 +65,21 @@
 &snfi {
 	status = "okay";
 };
+
+&gdm1 {
+	status = "okay";
+};
+
+&gdm2 {
+	status = "okay";
+
+	managed = "in-band-status";
+	phy-mode = "usxgmii";
+};
+
+&gdm3 {
+	status = "okay";
+
+	managed = "in-band-status";
+	phy-mode = "2500base-x";
+};
diff --git a/arch/arm/dts/an7583.dtsi b/arch/arm/dts/an7583.dtsi
index f0ba3da21c07..47d356d43895 100644
--- a/arch/arm/dts/an7583.dtsi
+++ b/arch/arm/dts/an7583.dtsi
@@ -146,6 +146,49 @@
 			reg = <0x0 0x1fa20000 0x0 0x388>;
 		};
 
+		pon_pcs: pcs@1fa08000 {
+			compatible = "airoha,an7583-pcs-pon";
+			reg = <0x0 0x1fa08000 0x0 0x1000>,
+			      <0x0 0x1fa80000 0x0 0x60>,
+			      <0x0 0x1fa80a00 0x0 0x164>,
+			      <0x0 0x1fa84000 0x0 0x450>,
+			      <0x0 0x1fa85900 0x0 0x338>,
+			      <0x0 0x1fa86000 0x0 0x300>,
+			      <0x0 0x1fa8f000 0x0 0x1000>,
+			      <0x0 0x1fa8e000 0x0 0x1000>;
+			reg-names = "xfi_mac", "hsgmii_an", "hsgmii_pcs",
+				    "multi_sgmii", "usxgmii",
+				    "hsgmii_rate_adp", "xfi_ana", "xfi_pma";
+
+			resets = <&scuclk AN7583_XPON_MAC_RST>,
+				 <&scuclk AN7583_XPON_PHY_RST>,
+				 <&scuclk AN7583_XPON_XFI_RST>;
+			reset-names = "mac", "phy", "xfi";
+
+			airoha,scu = <&scuclk>;
+		};
+
+		eth_pcs: pcs@1fa09000 {
+			compatible = "airoha,an7583-pcs-eth";
+			reg = <0x0 0x1fa09000 0x0 0x1000>,
+			      <0x0 0x1fa70000 0x0 0x60>,
+			      <0x0 0x1fa70a00 0x0 0x164>,
+			      <0x0 0x1fa74000 0x0 0x450>,
+			      <0x0 0x1fa75900 0x0 0x338>,
+			      <0x0 0x1fa76000 0x0 0x300>,
+			      <0x0 0x1fa7f000 0x0 0x1000>,
+			      <0x0 0x1fa7e000 0x0 0x1000>;
+			reg-names = "xfi_mac", "hsgmii_an", "hsgmii_pcs",
+				    "multi_sgmii", "usxgmii",
+				    "hsgmii_rate_adp", "xfi_ana", "xfi_pma";
+
+			resets = <&scuclk AN7583_XSI_MAC_RST>,
+				 <&scuclk AN7583_XSI_PHY_RST>;
+			reset-names = "mac", "phy";
+
+			airoha,scu = <&scuclk>;
+		};
+
 		eth: ethernet@1fb50000 {
 			compatible = "airoha,an7583-eth";
 			reg = <0 0x1fb50000 0 0x2600>,
@@ -162,6 +205,38 @@
 			reset-names = "fe", "pdma", "qdma",
 				      "hsi0-mac", "hsi1-mac",
 				      "xfp-mac";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			gdm1: ethernet@1 {
+				compatible = "airoha,eth-mac";
+				reg = <1>;
+				phy-mode = "internal";
+				status = "disabled";
+
+				fixed-link {
+					speed = <10000>;
+					full-duplex;
+					pause;
+				};
+			};
+
+			gdm2: ethernet@2 {
+				compatible = "airoha,eth-mac";
+				reg = <2>;
+				pcs = <&pon_pcs>;
+
+				status = "disabled";
+			};
+
+			gdm3: ethernet@3 {
+				compatible = "airoha,eth-mac";
+				reg = <3>;
+				pcs = <&eth_pcs>;
+
+				status = "disabled";
+			};
 		};
 
 		switch: switch@1fb58000 {
-- 
2.55.0

