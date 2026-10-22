Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A767606A32F
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 19:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=1K+zOP65;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SbNfMKxi
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3310E60796;
	Thu, 22 Oct 2026 19:02:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hKbGCLv4Hihz; Thu, 22 Oct 2026 19:02:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8E6286080C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792695773;
	b=GcWxJv2pFTYmCZNb7kzix1UWf9tTxiF8XzYjZIL76RL2Qd9decJoqLjrr30bIcEpKTOG
	 QeUI4O+oR4iqc91N8QbFuhD+cf0+opI7SeyC3NGpSenZ0JN8ysmEDs4ijNYVbGSF1DAqV
	 ehgkvqLpwFlVkpdPOTuk4MRSIfVWY2DwVI9d9n7kodLbeH/4kuhCEF3JdDvpSSz0LfiTU
	 XAZJRlxr+mJqkVCk3ZWHug9SagN8xlQuhky17ReypOlRzr9FPagq0/ZIoJJ/pHpYlmMOk
	 h7jgJr2The16JtMh2AreKqI7pOpPfCYZ5i7QPGirqchUD4Tcu8d1s0axSRB5JjQNbDw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792695773;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=x2WQFQPEO1zdRrDGcQvVFN4QJ0ZHem+DfO90+CimfqE=;
	b=oBJc8+t54kpMvR4eo0wQlvnv/Ns5POfl4gtWasGdGHaWOxciL/Yqz/snipb7SaWazQh2
	 CUynFccwPtnAzXYzPWQU+E4wayN39gvArkpt5ewNDa8otcZQSk3f2nHt2kTvIyePWdTY7
	 aiWKBt2OwHzo6D9AEtxfxFfffL/Uqa8X8eU8cuFY4YTE+0FsCtW5cCokr2wOOLpNQ7WBY
	 BGKzc0PWuHa9IkFJpOqX9Rbhd/DO87McVQCYwExXmhEHrZXNqWUwJ6/0MjoRbQVBV1mHs
	 xqbHlWx4b0v/2dvxV8S4NdHDuJ39bJgleCs9eMFs/KD+IwJqnIe9K13y5kNtXGGz3DQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SbNfMKxi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792695773;
	bh=x2WQFQPEO1zdRrDGcQvVFN4QJ0ZHem+DfO90+CimfqE=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1K+zOP65CmCXya31PxZD8HCJrgDWAbvmW61NhLr6QOzKVguty/Bx7nMtBO5NxAUsj
	 re00od97GbQPs/QTc6EKU19cVXK+t4aof5EFZOT3StR9Es2QUhw+DTSjlA1aAu0x17
	 2mnQMQNyZSB2SzNye4biVSdxl04Efyhv5pZs3ubPlLDxK8nBTtQofBBttlupKgyqs1
	 37vr88Ad0ChKBZ2ukz+xufxb/FrMoWvH0ka5OSrOZl1/n+Iv91Pyf1gtohukT/90Kv
	 21uL8DtVb56hVQD63vEXD0Y5UX1y7zXAmmWacduQ3OFKTMAY1TiD645gRochRG91Ea
	 J1a+fFgbFE2Ig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8E6286080C;
	Thu, 22 Oct 2026 19:02:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6EE8D4BC
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6120860818
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hwzDctDCL3M8 for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 19:02:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6B104607E4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792695764;
 b=Wadz/alvrv+1l1aK/p98VfVbTiTe0qPpCm8vRS8ikuU8tKwlTACgQ3Lqn2kNlYLtnRB7
 fo8t41qN/btDm4w1ELis4Ncmzg+I4WHg8ulkEdAEmjf2xHEwtGGltut6tuZBZxErS2HY3
 l416YGPYRnJ6Bz+LaoAyUNo0c8R7cGDpXEtRGMTxOkz2RrPtamQRfPbdAePfIoLQn8JIK
 eJ+nJ5qLuZVaN+Yun73zD2ZQrD/6rqK2MQMAwA1sCv9OAShjEQX0yn8JJNW2+4x/iijW4
 hn87DjlkGw8+aWb6jL1kizh75DN/N467ukW6wBOzavlTF7iujaG8mSXNYig6WkETyEg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792695764;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=x2WQFQPEO1zdRrDGcQvVFN4QJ0ZHem+DfO90+CimfqE=;
 b=OzPxg6pML2bLhd4ZSrFjWiYcTlLB565usGOiO0Rsjk0dZEuBycK/KvPahG/m3vobrG/e
 +wMjDlfyeWevfMlWGTUQyXOH0mPPu0cvOUEuz2phY6RrEB5zcE4nGQ7IloQPjIBmzohn/
 fTcbItUDcG7TN1cxZ9/tKEip0BrSe34irh4fCEh3dkPwMYxArvhJT5qIAqoeKLMaLJ5lf
 COdLiz4ZrivO1WieJnvyQm9AdhMo0uQZ9Llv0JRos0UqJ7WyRBD8rwLdR9sanMVAwi51o
 3S+5H/U5OJxURRUuK4cAmtmb1LE721BrFVtWYdDCyhU71qqPZEuIO4CAkWHNnke/ylg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=SbNfMKxi; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=SbNfMKxi
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6B104607E4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:43 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48e011d370dso112891f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792695762; x=1793300562;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=x2WQFQPEO1zdRrDGcQvVFN4QJ0ZHem+DfO90+CimfqE=;
 b=SbNfMKxiQaT9fyY8FHgHYgWnheTBxzQnaP0NrffYhpbG89lc96fq4Dmc7V2gHogmOH
 bFMPNLyBsj1IGqu+FJBIaZIvBH6ChKea137xsYGQxt5s05NDzf3VdXeTZBW3hzVMffwj
 ULZX/Zl/3H8d2VZH+6Q5GUUSGtfe+7ws3UloADz1s4tTYn3HgmIgMlyI8kfm1AGf0ysm
 UO5qz62rF+5nOHVSD4KiCXIiqN/HewjEtFJitXL1Tzcq/wkf5xp7uvKVMubWksiCaF3F
 ToF7cWKGynTEBFa98JjyvnaaVyTEDIE9Ucqln2YLOyqD33cMbdiZkrMlX4+/CkAXVoLL
 yvjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792695762; x=1793300562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=x2WQFQPEO1zdRrDGcQvVFN4QJ0ZHem+DfO90+CimfqE=;
 b=hNgT19pY+W5Ql1QMTnLRgmT5ivpXUyoCma6ns+hux+crxqDO4gxM4i3tHiu3ekUnD0
 aKlAEk3Y/C6FjU7XrhHVSGtdNRx2B2yK2bGwtv6QXSLXMq6IhYTFCwIdqZeC4wqaw1uC
 fHleZfhdiIOsQgYTl/xbj5njACJGZcCJsDWiyq0YOiPjVl6hbcCprQW05TlxTGDcDUzn
 D/f6/wCrGFOg0qrFI84Ao8mA708wweWEddIGgTEKaU+/b6uV7c1CYTGJY4w/eQoJqbiz
 HPMrVBNGS6PPIPf3f6UkkSthA1LVCy5RW2mcL0N7yEuYftg/TLOe8/gG6/i3wVc79Oq8
 iCsw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxpZaUG9iUX+XO5Rm/5Sbx40Y6M0ZCsRcwM3eVyZ2WBKaer6H9La3hu7w2HHhe1E3sKqSjvhLE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ5AmWiGgNgSsVc/5GGt4Wtr0lCRmX/378jPbMZ6QeC6IccpzzQ
 gqP0Mtn5/xOGeiFEXQ2M46Gq0h3Q6uQDSQMav224jhW2Z4anWJVe5Tj7
X-Gm-Gg: AYBFou2xItuUeEC6VnJKyTTXF635698zb9eHRq66cC6l5H0AONLX82A5kOQyN1dRAgS
 L6hjTJh65TqJqPwv0kCsnl244MdrAJHBUC8DLXuzzYPtvpZ65fv/wkKusLEdagWrklGfiU/C0uM
 1wzzjnLLirvpUWvcCwvFHMFBYM6VaP+J+ybpF2giSx38XNP4iMGwBEMGqB78A1DVYm1IfiqTHbW
 YYbPB+DDpaC3J1P34KOf5TxTrzdG8xNQmhxziuqxU03M5D8oY3BP2SgE2y044xkjzaw4zdziu0O
 4Vw2Mv7kiJcqB9AWZtRMY6hbAoGtOBpmGfgXvtnYZyW3u+SMyf8zlA9a11Gj2HqlUmvBX/I/UIq
 TqmCm8w688LFIw0TjGvSmtuRru0/WUX1sJV6qB313phn7/x5aBzrwUZ2diFVWphC4aYbwaf0say
 gscZ0D3GLVcSSadG0uEhDRdTHaFnC7XBfcJYDMJ24Zmx+ntwGsgc2b4yssw0p+aigCSpPUjBI8i
 8eRx/03o+M0xTBeNWXWwnSWG06lASrvQxmRudLa+3I74m7w35ZGSFj6Fn5MeiYyWmHQxM8W+zZ6
 vRIvHmkYsjXe6wEsYyn5gTB+WU/GrD5a7fyw0YeHH+l4ici/3PcLJ0143O/NagvmFrLmGKZ+/Iz
 zU+Qyfw==
X-Received: by 2002:a05:6000:2997:20b0:48e:29bb:c513 with SMTP id
 ffacd0b85a97d-48e29bbc540mr7475948f8f.46.1792695761827; 
 Thu, 22 Oct 2026 12:02:41 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-48e37a0e841sm189495f8f.54.2026.10.22.12.02.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 12:02:41 -0700 (PDT)
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
Subject: [PATCH v3 09/16] ARM: dts: an7583: add MMC node
Date: Thu, 22 Oct 2026 21:01:51 +0200
Message-ID: <20261022190206.666950-10-ansuelsmth@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add MMC node for Airoha AN7583. These follow the same node of Airoha
AN7581.

Similar to Airoha AN7581, add the fixed regulator and fixed clock for
MMC.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/an7583.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/dts/an7583.dtsi b/arch/arm/dts/an7583.dtsi
index 629f0e64de6d..4f7b41665b1c 100644
--- a/arch/arm/dts/an7583.dtsi
+++ b/arch/arm/dts/an7583.dtsi
@@ -106,6 +106,21 @@
 			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
 	};
 
+	clk25m: oscillator {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+		clock-output-names = "clkxtal";
+	};
+
+	vmmc_3v3: regulator-vmmc-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vmmc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
@@ -262,6 +277,24 @@
 			};
 		};
 
+		mmc0: mmc@1fa0e000 {
+			compatible = "mediatek,mt7622-mmc";
+			reg = <0x0 0x1fa0e000 0x0 0x1000>,
+				<0x0 0x1fa0c000 0x0 0x60>;
+			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&scuclk EN7581_CLK_EMMC>, <&clk25m>;
+			clock-names = "source", "hclk";
+			bus-width = <4>;
+			max-frequency = <52000000>;
+			vmmc-supply = <&vmmc_3v3>;
+			disable-wp;
+			cap-mmc-highspeed;
+			non-removable;
+
+			assigned-clocks = <&scuclk EN7581_CLK_EMMC>;
+			assigned-clock-rates = <200000000>;
+		};
+
 		uart1: serial@1fbf0000 {
 			compatible = "ns16550";
 			reg = <0x0 0x1fbf0000 0x0 0x30>;
-- 
2.55.0

