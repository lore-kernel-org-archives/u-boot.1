Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3122C5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 08:51:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9996D60767;
	Mon, 24 Aug 2026 08:51:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IRdMcaKYc_qI; Mon, 24 Aug 2026 08:51:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787561515;
	bh=l8Cf7boF9I+7AftYkc6cyZTM23fUc9s52WqogIxSTGI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=taa6Adt3q9yEN93COtYv5Eky4Xg/AeFOKRDIXJNS+WV4yVAexXkdLWGMVYXEQncRo
	 JTfW2M+M5E11giY5MxvQEwuKNoJzRdiEepmS5BmYWxz5lRn4KjxLqsUj6TtRMLHbgC
	 eoe+G+6eT7umjWKL84d9Zqy9vMBpyej1cnjY66AbeXrXJDICtmR+xDhQFfklwjYW18
	 4ys0x01tbThq8o9Ym8PjVaINP4Zwzh9ZQEclGN76ufVjA996bFJJrRhMDvhufwYeps
	 hh9oT+zleVJdDnYHVoMKTWj6Rfe2Eu2FLv75w62DGGpuZ/wtQDmRNQaaCaiQg6E+YG
	 eyI0hpvBw5hMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 617CA6063A;
	Mon, 24 Aug 2026 08:51:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F204336
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:51:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 35E12400AE
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:51:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1tfO5K_8pfjr for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 08:51:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=A42d/LK1
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6A86D4005C
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:51:53 +0000 (UTC)
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2cf6d65d8a7so39216015ad.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 01:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787561512; x=1788166312;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l8Cf7boF9I+7AftYkc6cyZTM23fUc9s52WqogIxSTGI=;
 b=A42d/LK1HIXay0OILIDtAM/ytPJN1E9noBa3puDWryk10pVFA1cDd1yNxyFC7jjPvn
 j451zIbvm4ocdwhiIYH6UGeswTL4b4SPJf6BHNj1ZSB55LqbUJMldExLDgRVt8Gj0sU7
 OzaDG5ECjEr6KEPqQkl24A3klhEGwTWH6PG6th9yMPdG0qsgi6oSBBiRBDVzsgeiMxEu
 krvh4kcYYy3hm2OaFBX6I8XPRUcIbZecDIYxtw1l1HvPlUeG9EXtsqkjbMMrZdrPj4xs
 bCZ9pBTQqJzxYhgyJDFW/kaPs0EGhAUAFg1MTeWpx9KomeyiWxFVczaiNduDgBpeujVt
 eRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787561512; x=1788166312;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l8Cf7boF9I+7AftYkc6cyZTM23fUc9s52WqogIxSTGI=;
 b=kj77YdiuluwJoKhz8Py/I4XpO+pQa9bjZDq9M2/EntRXCeOjVvHkGXxCcP5o8rcm/1
 WhwAosqvltt3eVYbBuvOsxJUHOBGk9hWOqa4YlF4fU5DtqhTa85WEsV7Oz/7fS/PHW+k
 OjCH3puPZ4Y3MpQmviNyVOqNo8mjLinSndNEcQXvUlzYeZBz27Rw9/PQSXONKRpLiFZ9
 bhrO867IwgpxzVNO8kM+h6X74KDjhYWXshdmb0QR45puX5Hd27XpLa1jSuh5dFVAZ+M3
 be1YdmN2BmA2q8eG6+XQsgMlIP+YetsldRlFcNk6ajvZDbvlTTKYX9n39ObnbXJfxaIo
 OYMw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrfIpTcd8U1i3rTveyhUkEhVBhPqfdRfn2JjwSb46ii43NqO38LL+8sks5YgTRwxPz3NszZFaI=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++njgmpFsD7Jdnk0Ug3BjargpQbiTdt/6bJ4183N4Cl99GJFCI/v
 LjjkLw3ljOQztn68FzNiLaaNQJVp3UM0m0cYJ4z1q9qInbJ9lRSrM4y/Zc46J/rIpgc=
X-Gm-Gg: AR+sD138A/m+KT1Ff3pw62/eYM1Mg/UP7sM2E4l9vrJrxRSDaT2GfiLJuxozsYrsg1I
 RUXN/Fsa11clTFBO/mAGyIq9yFaLlABj9FRyme7CbcTZptp92QNpt20hW1qfW0KU4TcFwAqmQRl
 IDTlpsOsXWlWGqBD7HyMccNmz/bas9PJct8K3aRN9cL01K1halnn3uUvnj/Tb1gVFqos/vVImwZ
 iHjC6o4q5MqQQO20gXMkLcAp8beTwlky4enGev+G1YVC743f/gBIdKkrqLEtc7Z2Vag54J01xcB
 63zNoxgQMGcZPYrS7AqDWR0W+aQPtvuVmcY+NDvH+FeyXVp7nGYmtbOKicvqe9LqX69tOgCrJIe
 nM4Ax8k0DrC1Uy/BsCXtdWl6kBcGmkxR+BqH1fPgsh7r8ErAco6kw/YGaxsLP8lM0cX12Lnl0sz
 1dDtANQgurIBQAKa+ZVUXsCyTsUwahgCLfAW1MiabXYSWUQN2IxHv3DQNbrDR4zRLBD54QdKeCo
 YOA16pwsh2qOzHVJrjvWFmNq2K6a8sGXtFlHlurZpLRwkA3eWXlykRHrFKs28mmMlrL5UmCMym1
 5DW2JuLTwSBVs/an0zBAMlyYKQ==
X-Received: by 2002:a17:903:2285:b0:2d3:14c6:2372 with SMTP id
 d9443c01a7336-2d64adea480mr419869215ad.1.1787561512462; 
 Mon, 24 Aug 2026 01:51:52 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f91d37d9sm26085522eec.14.2026.08.24.01.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 01:51:51 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 24 Aug 2026 16:50:45 +0800
Subject: [PATCH v10 10/17] riscv: dts: spacemit: k1-musepi-pro: enable PCIe
 ports
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-m4-v10-10-5e0adcb1edb9@riscstar.com>
References: <20260824-m4-v10-0-5e0adcb1edb9@riscstar.com>
In-Reply-To: <20260824-m4-v10-0-5e0adcb1edb9@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>, 
 Wei Fu <wefu@redhat.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Yixun Lan <dlan@kernel.org>, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Alex Elder <elder@riscstar.com>, Andre Heider <a.heider@gmail.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>, 
 Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
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

From: Andre Heider <a.heider@gmail.com>

Enable the two PCIe controllers along with their associated PHYs. They
are routed to the M.2 M-key connector and to the PCIe slot.

Signed-off-by: Andre Heider <a.heider@gmail.com>
Link: https://patch.msgid.link/20260513071958.29574-6-a.heider@gmail.com
Signed-off-by: Yixun Lan <dlan@kernel.org>

[ upstream commit: d9ab0a855ba13f1db3ae16539348714c74010a22 ]

(cherry picked from commit b526ec8833b7e7a646cdb7ebc7b8f0af14dd154d)
---
 dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts | 38 +++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts b/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
index b284bf416880..898b537ba0bc 100644
--- a/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
+++ b/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
@@ -36,6 +36,14 @@
 		};
 	};
 
+	reg_pcie_vcc_3v3: regulator-pcie-vcc3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "PCIE_VCC3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
 	reg_vcc_4v: regulator-vcc-4v {
 		compatible = "regulator-fixed";
 		regulator-name = "VCC4V0";
@@ -272,6 +280,36 @@
 	};
 };
 
+&pcie1_phy {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie1_3_cfg>;
+	status = "okay";
+};
+
+&pcie1_port {
+	phys = <&pcie1_phy>;
+	vpcie3v3-supply = <&reg_pcie_vcc_3v3>;
+};
+
+&pcie1 {
+	status = "okay";
+};
+
+&pcie2_phy {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie2_4_cfg>;
+	status = "okay";
+};
+
+&pcie2_port {
+	phys = <&pcie2_phy>;
+	vpcie3v3-supply = <&reg_pcie_vcc_3v3>;
+};
+
+&pcie2 {
+	status = "okay";
+};
+
 &qspi {
 	pinctrl-names = "default";
 	pinctrl-0 = <&qspi_cfg>;

-- 
2.51.0

