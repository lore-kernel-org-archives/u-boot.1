Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45729606A320
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 13:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=z5obeW8B;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XttI5uh/
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DA89640722;
	Mon, 26 Oct 2026 13:40:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S4H4BLzJXc3c; Mon, 26 Oct 2026 13:40:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C4A8B40718
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793022040;
	b=O+QKk3Gsu6iee7q8L5+FFzVahPHwWngDmjEI4LleTFoycVBJ02woNifAno3GvJwgFP3b
	 8vPLJdKfg2Cb7OR4NKyc7ZLmqrWKYUniwM3r91fccxdTK8vAL3ynwN/f+6ZFsDFX6d4tc
	 rmfUWN57L9U+LifFTbeytM7F+sJr+ZS0TEgjxlA1PJjLMZPnbURIY2nrIVRJgCLs0SmOa
	 tp3KzDBs3KIzzrIynCb9yNL0jZ6mqsvREj7fFi9wkcfMLhDze4ZbWAZ8jlWpvjfrb5Kh8
	 cptzv8Nrd3zzb0fnnRjsU59VtHmK9FxUSe9NZWK/BRleXSmOaFY9aWn0BBZ1UH358Qg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793022040;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=aujnJZuw0iDHoFCJmfWf4ouH5b6E9bLA2aCQEkZaecw=;
	b=mzeolXOWkzNfRLMl2Owsl9fG2rjrtTcushCkhlwxSm9zIE+sxnjR8iRRXoLEItXwPJFL
	 t9bmIQbkhzx02/h9yQKtLQor7MTDlpoPWOpiOqLT52VpXKyUFL1I6s2ZS/XjmELDYceHg
	 7KYer86/jWhWAfcza8y9gX/Wh7c3k8vHa4UKdC8cMQodCIsAKaPrCGUeY/2p1dyY5aj55
	 w/vtpoanprHbtj94xgmjrTAag61Hj6F8X/rz5C7K+Ycz5PCnexkv6Ao1gUhChzWSgwTpC
	 rMHj/IadNsdKFgv4pd4l7Tt3Jv3eUcLQVTIHN1rapq6KlHjuH+yUPLMW6Q33CUrxXeg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793022040;
	bh=aujnJZuw0iDHoFCJmfWf4ouH5b6E9bLA2aCQEkZaecw=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z5obeW8B5nKSEttoXmT+Nt+DrpdoqVeaVKj9cL/bkxxff4bNT62qqG9/EOFBjYi8C
	 mBW12M888CoHmWr98tL4vEX6mFPhzjVUdZKkS/e/wqEi4KaJ6X9v6xWlShrktcPiTB
	 7AexFRcNs1p6l2VU+TI1UUB7oPz4+27Y7WfnT0pzXyg++S7EMGj4bQILcPOkcOnp1J
	 QPFuNXxUCmSCBFn8LH/0B1UzNHxtrBL4EjZ0JF7hbWkhIOMuOpoVOgkMmyG/uCYaU0
	 ix9tCAT3T359KAs455Hyj3JcdNmvA0zfMHKkuTUVLsP8blESqtYELOT9jpOsSF1vcI
	 S7a/qSPgHd0AA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C4A8B40718;
	Mon, 26 Oct 2026 13:40:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 99506D33
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:40:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7F55560626
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:40:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KOhxnTZe8Q6x for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 13:40:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2AF13605ED
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793022032;
 b=p9Xw3xZLRLfBWMVsL1xDhUHYGEruA4FtyRBh7WqLfparq8lWzj+Q6sGzJ0CEhX8RQyWM
 iBKwrphLJsFd2HqFNTtiIGn8sAtkirm8WPq8YQUVe0ld5cP/zwS/zzfWWVztXmKK+nxTW
 9cUX8UZl9U+0Gx0K07u+1JOXFCHKFIF0ZsFif7UBWRkNqPnXiwb9WkfMOqPdl8h7Dv6gL
 gnhNz6/opGS/rxqkd50gQ4EEw/AKIDCrE08ap7zyHBlHP9eZzrTIAh9IHjEK31RovJog6
 Q99wvAAV6O7VbL9EzZ104QpJgTeyMhmgSn9qYja8tqX3GiKx7PPTXg0q1IZLfxEmJQA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793022032;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=aujnJZuw0iDHoFCJmfWf4ouH5b6E9bLA2aCQEkZaecw=;
 b=FgvOJCiQjis0kp1NFbjtpFfy8CAD9APERuq5zrPyH+UoTL+Dsn4nZ23qA2ge8MAr62LW
 IEz3ss1o+IiDhZkpzyRD8188Ck+ImPc62aNWh99ohwmJZqel9UsTQd/WCQnX/vQVZPEgt
 bJjRPdFpiXHfGGZh7Zr1DisaTFhFuMHWBuzfrbTxNCfAdLwP6Bn7KpVmxK+Do+jcalFWx
 uNAH8rmF3WxPCz3AyY88WvorqZi480YJ0tQj7ZSkHimHpbb3lSnNrkvu7R+obKPKIBWWw
 lF88zoo68Q40xRT5YZanX8bf/GKCW35moDHXx+Oh0wDp/Pq8UAlR+M8TSiq+7x0MocA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="XttI5uh/"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=XttI5uh/
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2AF13605ED
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:40:31 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a5036bbac7so9032345e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 06:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793022030; x=1793626830;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aujnJZuw0iDHoFCJmfWf4ouH5b6E9bLA2aCQEkZaecw=;
 b=XttI5uh/vYJB4ZHWTTbymlo7yI6vB4SxfkFgSkFp5evq+asf1HiuDyS6XjVewwrXBK
 BNw7wmEhAHuOsI06rrmgYQVyG3jFkQArlyoKcFo4UAyj5bi56ThsqhMcgedPVsUm0vk7
 m380U/mwuseQORsdX7+YJwNCBVodghUAO5wo7aiZeMar5F54dfOGkwsobgNL8TW4FlPt
 pkt6SwvvNkgsqn0qOUbHP11FWK4g4aXZxJgg6ChyT/u9YFFed/jRaFNYGbzKa0iPn6Yj
 mQxNsXfVwpDTmIradckFPiV2KhC1AyjF6XwENGJRAJwWiVArUUnMWKs/LO/EiDHPIqpt
 vSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793022030; x=1793626830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=aujnJZuw0iDHoFCJmfWf4ouH5b6E9bLA2aCQEkZaecw=;
 b=nAM21i2vQjXLJOeXCiE1VZEQmB5psCfd00cIdZIg+Y+bhy8R7XWkm270AFQcyjlGXa
 H4K8BUbtP4d023XoTK0NwnlZNw0c8Syk2kFgqvkyYa+TAC65KsFXeAzEL89LXhDc5Ca7
 wa086W/bMm9ByEVwv9OA0dyCdq+h1+dSOSwbfc3JBtH++ENdiUNPRJ1mbCdo8s/PzwZP
 a9TD+h7tP4P1Xh8JmEqtGMjdfI32Fvbu4CusKv66p/ZeRhjvMk65wuECWzn0siKkFwhf
 hF5VgLWOqYB6Q+ZqMsweg4Bk9yQ95VMbPwBAedu3LnNn4L+9T0fWPhkSbeDqmcR1C4bK
 ZNdw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxQqo35TWkELKKkpOrjXVzMX3VhvDJO/zyCLu+ZTvG81D2eG5a8ke6YMyiHoeM2a2bA7xSe+0w=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJKjQCet5nfMXcjXPgpMjoSf8NHKrAWgOMkiuRufpuupt6ztkIe
 4vuh/HcG60m+9Nkz2DxqKjCaOmRNkMlaX0nQ1PO93nvnMnlJvtwbWCps
X-Gm-Gg: AYBFou3n9bN5ezwPsnDWGrJkFq3/8TbFVmhJITmQ2A2EgVVZuYCRg3CEPKggNNHt3ee
 44tPh7yfO5HW0ZZSGEgVmjRUGM7j15MAmoyn6lHA57w5wxwFDQ3O4dtv/JZGfrn1+j6oAyAdTyW
 RRYCoLEfVlo9OqKJ4F7k3N4MGjSlISflhMhp7a1b9fTdx4IWSWRqsLNWr+UL4+AyTCztwg6Vyy0
 d2OCcyVhjU/G8UeMowrEjLjyyXGM1x6+2pjnvJwJuWSfIWUCsR8UTbRw3f4yQajHiE/85aOYJBH
 7dnbnKUAZgVeGRP2rdOGfGENJcTJOf/vuwJ90yLIF0ykjNgVQFw6uViB1DHOde+5Z0V0ncr2AwJ
 h+HU+PQAryxldWLVLugMIBP1bitDNUKRlsRa94qMnVAUcRWYCB/tn/HYXPK8faA/GXo2uDb7ck3
 SeafVi3PFM8rODYSmCPsnikLQqEwFR0LPcULlrEH4XDvRVJim6Jbm8xa3ZE1KXvPwP8xU196PZT
 D9wixnMY4O8n1tmoFVgb/AjqUIGvOncVAcdbn/7MST22PLo1949x0es2d38xQfo9RD50clLdv3T
 KRbBGCGHeDnMbp8HxB16PKwMS485/iQ7nY/Luc1pqncff2ZY12gxQrjcJHjD4KHQSW3kt/d9yGc
 OpElWJA==
X-Received: by 2002:a05:600c:c171:b0:4a2:191f:7cb8 with SMTP id
 5b1f17b1804b1-4a35ac94717mr117615165e9.17.1793022029788; 
 Mon, 26 Oct 2026 06:40:29 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4a35a2c0458sm194344375e9.11.2026.10.26.06.40.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 06:40:29 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>, Alexey Charkov <alchark@flipper.net>,
 Daniel Golle <daniel@makrotopia.org>,
 Pranav Sanwal <pranav.sanwal@amd.com>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Tan Siewert <tan.siewert@9elements.com>, Yao Zi <me@ziyao.cc>,
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Randolph Sapp <rs@ti.com>, Martin Schwan <m.schwan@phytec.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org
Subject: [PATCH v10 8/8] test: dm: Add test for FW Loader feature
Date: Mon, 26 Oct 2026 14:40:01 +0100
Message-ID: <20261026134002.109025-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026134002.109025-1-ansuelsmth@gmail.com>
References: <20261026134002.109025-1-ansuelsmth@gmail.com>
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

Add basic test for FW Loader feature for the Filesystem way and FIP.

Additional MMC testing image are added that loads a dummy firmware.bin in
a fat partition or a simple FIP blob.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/sandbox/dts/test.dts          |  38 +++++
 configs/sandbox64_defconfig        |   2 +
 configs/sandbox_defconfig          |   2 +
 configs/sandbox_flattree_defconfig |   2 +
 configs/sandbox_noinst_defconfig   |   1 +
 configs/sandbox_spl_defconfig      |   2 +
 configs/sandbox_vpl_defconfig      |   2 +
 test/dm/Makefile                   |   1 +
 test/dm/fw_loader.c                | 218 +++++++++++++++++++++++++++++
 test/py/tests/test_ut.py           |  58 ++++++++
 10 files changed, 326 insertions(+)
 create mode 100644 test/dm/fw_loader.c

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 25c99ef81472..772d8dd548bc 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -189,6 +189,18 @@
 		};
 	};
 
+	fs_loader: fs-loader {
+		bootph-all;
+		compatible = "u-boot,fs-loader";
+		phandlepart = <&mmc12 1>;
+	};
+
+	fip_loader: fip-loader {
+		bootph-all;
+		compatible = "u-boot,fip-loader";
+		phandlepart = <&mmc13 1>;
+	};
+
 	cedit: cedit {
 	};
 
@@ -1398,6 +1410,20 @@
 		filename = "mmc11.img";
 	};
 
+	/* This is used for FS Loader tests */
+	mmc12: mmc12 {
+		status = "disabled";
+		compatible = "sandbox,mmc";
+		filename = "mmc12.img";
+	};
+
+	/* This is used for FIP Loader tests */
+	mmc13: mmc13 {
+		status = "disabled";
+		compatible = "sandbox,mmc";
+		filename = "mmc13.img";
+	};
+
 	pch {
 		compatible = "sandbox,pch";
 	};
@@ -2143,6 +2169,18 @@
 		ethphy1: ethernet-phy@1 {
 			reg = <1>;
 		};
+
+		ethernet-phy@2 {
+			reg = <2>;
+
+			firmware-loader = <&fs_loader>;
+		};
+
+		ethernet-phy@3 {
+			reg = <3>;
+
+			firmware-loader = <&fip_loader>;
+		};
 	};
 
 	pm-bus-test {
diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index 59e08d03f776..7d56ab984c1d 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -266,9 +266,11 @@ CONFIG_WDT=y
 CONFIG_WDT_GPIO=y
 CONFIG_WDT_SANDBOX=y
 CONFIG_WDT_ALARM_SANDBOX=y
+CONFIG_FIP_LOADER=y
 CONFIG_FS_CBFS=y
 CONFIG_FS_EXFAT=y
 CONFIG_FS_CRAMFS=y
+CONFIG_FS_LOADER=y
 CONFIG_CMD_DHRYSTONE=y
 CONFIG_TPM=y
 CONFIG_ERRNO_STR=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index f307972a762d..cf3c858b4b72 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -383,9 +383,11 @@ CONFIG_WDT_GPIO=y
 CONFIG_WDT_SANDBOX=y
 CONFIG_WDT_ALARM_SANDBOX=y
 CONFIG_WDT_FTWDT010=y
+CONFIG_FIP_LOADER=y
 CONFIG_FS_CBFS=y
 CONFIG_FS_EXFAT=y
 CONFIG_FS_CRAMFS=y
+CONFIG_FS_LOADER=y
 CONFIG_ADDR_MAP=y
 CONFIG_PANIC_HANG=y
 CONFIG_PMBUS=y
diff --git a/configs/sandbox_flattree_defconfig b/configs/sandbox_flattree_defconfig
index 57f915d4ba9a..3488036ddf8f 100644
--- a/configs/sandbox_flattree_defconfig
+++ b/configs/sandbox_flattree_defconfig
@@ -12,10 +12,12 @@ CONFIG_EFI_CAPSULE_FIRMWARE_FIT=y
 CONFIG_EFI_CAPSULE_AUTHENTICATE=y
 CONFIG_EFI_CAPSULE_CRT_FILE="board/sandbox/capsule_pub_key_good.crt"
 CONFIG_BUTTON_CMD=y
+CONFIG_FIP_LOADER=y
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_FIT_VERITY=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_FS_LOADER=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_BOOTSTAGE=y
 CONFIG_BOOTSTAGE_REPORT=y
diff --git a/configs/sandbox_noinst_defconfig b/configs/sandbox_noinst_defconfig
index 7a7550127956..941bf2d69431 100644
--- a/configs/sandbox_noinst_defconfig
+++ b/configs/sandbox_noinst_defconfig
@@ -21,6 +21,7 @@ CONFIG_SYS_MEMTEST_END=0x00101000
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_FS_LOADER=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_HAS_LOAD_FIT_ADDRESS=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x0
diff --git a/configs/sandbox_spl_defconfig b/configs/sandbox_spl_defconfig
index 60b497f48886..183611632ef8 100644
--- a/configs/sandbox_spl_defconfig
+++ b/configs/sandbox_spl_defconfig
@@ -223,8 +223,10 @@ CONFIG_I2C_EDID=y
 CONFIG_VIDEO_SANDBOX_SDL=y
 CONFIG_OSD=y
 CONFIG_SANDBOX_OSD=y
+CONFIG_FIP_LOADER=y
 CONFIG_FS_CBFS=y
 CONFIG_FS_CRAMFS=y
+CONFIG_FS_LOADER=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
 CONFIG_CMD_DHRYSTONE=y
 CONFIG_RSA_VERIFY_WITH_PKEY=y
diff --git a/configs/sandbox_vpl_defconfig b/configs/sandbox_vpl_defconfig
index c85bfbfb3b15..445e979915e8 100644
--- a/configs/sandbox_vpl_defconfig
+++ b/configs/sandbox_vpl_defconfig
@@ -231,8 +231,10 @@ CONFIG_CONSOLE_TRUETYPE_CANTORAONE=y
 CONFIG_VIDEO_SANDBOX_SDL=y
 CONFIG_OSD=y
 CONFIG_SANDBOX_OSD=y
+CONFIG_FIP_LOADER=y
 CONFIG_FS_CBFS=y
 CONFIG_FS_CRAMFS=y
+CONFIG_FS_LOADER=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
 CONFIG_CMD_DHRYSTONE=y
 CONFIG_RSA_VERIFY_WITH_PKEY=y
diff --git a/test/dm/Makefile b/test/dm/Makefile
index 5dd6b57bbe84..2f095ceedd8c 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_EXTCON) += extcon.o
 ifneq ($(CONFIG_EFI_PARTITION),)
 obj-$(CONFIG_FASTBOOT_FLASH_MMC) += fastboot.o
 endif
+obj-$(CONFIG_FW_LOADER_UCLASS) += fw_loader.o
 obj-$(CONFIG_FIRMWARE) += firmware.o
 obj-$(CONFIG_DM_FPGA) += fpga.o
 obj-$(CONFIG_FWU_MDATA_GPT_BLK) += fwu_mdata.o
diff --git a/test/dm/fw_loader.c b/test/dm/fw_loader.c
new file mode 100644
index 000000000000..751792e818e1
--- /dev/null
+++ b/test/dm/fw_loader.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <dm.h>
+#include <dm/device.h>
+#include <dm/lists.h>
+#include <dm/test.h>
+#include <fw_loader.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+static int bind_mmc(struct unit_test_state *uts, const char *mmc)
+{
+	struct udevice *dev;
+	ofnode root, node;
+
+	/* Enable the mmc node for this test */
+	root = oftree_root(oftree_default());
+	node = ofnode_find_subnode(root, mmc);
+	ut_assert(ofnode_valid(node));
+	ut_assertok(lists_bind_fdt(gd->dm_root, node, &dev, NULL, false));
+
+	return 0;
+}
+
+static int dm_test_fw_loader_get_dev(struct unit_test_state *uts,
+				     const char *name, struct udevice **dev)
+{
+	struct udevice *mdio_dev;
+	ofnode mdio_node, phy_node;
+
+	ut_assertok(uclass_get_device_by_name(UCLASS_MDIO, "mdio-test",
+					      &mdio_dev));
+
+	mdio_node = dev_ofnode(mdio_dev);
+	ut_assert(ofnode_valid(mdio_node));
+
+	phy_node = ofnode_find_subnode(mdio_node, name);
+	ut_assert(ofnode_valid(phy_node));
+
+	return get_fw_loader_from_node(phy_node, dev);
+}
+
+static int dm_test_fs_loader_get(struct unit_test_state *uts)
+{
+	struct udevice *fw_loader_dev = NULL;
+	int ret;
+
+	ut_assertok(bind_mmc(uts, "mmc12"));
+
+	ret = dm_test_fw_loader_get_dev(uts, "ethernet-phy@1", &fw_loader_dev);
+	ut_asserteq(-ENODEV, ret);
+	ut_assertnull(fw_loader_dev);
+
+	fw_loader_dev = NULL;
+	ret = dm_test_fw_loader_get_dev(uts, "ethernet-phy@2", &fw_loader_dev);
+	ut_assertok(ret);
+	ut_assertnonnull(fw_loader_dev);
+
+	return 0;
+}
+DM_TEST(dm_test_fs_loader_get, UTF_SCAN_FDT);
+
+static int dm_test_fip_loader_get(struct unit_test_state *uts)
+{
+	struct udevice *fw_loader_dev = NULL;
+	int ret;
+
+	ut_assertok(bind_mmc(uts, "mmc13"));
+
+	ret = dm_test_fw_loader_get_dev(uts, "ethernet-phy@3", &fw_loader_dev);
+	ut_assertok(ret);
+	ut_assertnonnull(fw_loader_dev);
+
+	return 0;
+}
+DM_TEST(dm_test_fip_loader_get, UTF_SCAN_FDT);
+
+static int dm_test_fs_loader_get_fw_size(struct unit_test_state *uts)
+{
+	struct udevice *fw_loader_dev = NULL;
+	int ret;
+
+	ut_assertok(bind_mmc(uts, "mmc12"));
+
+	ret = dm_test_fw_loader_get_dev(uts, "ethernet-phy@2", &fw_loader_dev);
+	ut_assertok(ret);
+	ut_assertnonnull(fw_loader_dev);
+
+	ret = request_firmware_size(fw_loader_dev, "firmware.bin");
+	ut_asserteq(256, ret);
+
+	return 0;
+}
+DM_TEST(dm_test_fs_loader_get_fw_size, UTF_SCAN_FDT);
+
+static int dm_test_fip_loader_get_fw_size(struct unit_test_state *uts)
+{
+	struct udevice *fw_loader_dev = NULL;
+	int ret;
+
+	ut_assertok(bind_mmc(uts, "mmc13"));
+
+	ret = dm_test_fw_loader_get_dev(uts, "ethernet-phy@3", &fw_loader_dev);
+	ut_assertok(ret);
+	ut_assertnonnull(fw_loader_dev);
+
+	ret = request_firmware_size(fw_loader_dev,
+				    "45a113ac-c7f2-30b0-90a5-a399ab912716");
+	ut_asserteq(5, ret);
+
+	return 0;
+}
+DM_TEST(dm_test_fip_loader_get_fw_size, UTF_SCAN_FDT);
+
+static int dm_test_fs_loader_get_fw_in_buf(struct unit_test_state *uts)
+{
+	struct udevice *fw_loader_dev = NULL;
+	int firmware_size = 256;
+	char *buf;
+	int ret;
+
+	ut_assertok(bind_mmc(uts, "mmc12"));
+
+	ret = dm_test_fw_loader_get_dev(uts, "ethernet-phy@2", &fw_loader_dev);
+	ut_assertok(ret);
+	ut_assertnonnull(fw_loader_dev);
+
+	ret = request_firmware_size(fw_loader_dev, "firmware.bin");
+	ut_asserteq(firmware_size, ret);
+
+	buf = calloc(firmware_size, sizeof(*buf));
+	ut_assertnonnull(buf);
+
+	ret = request_firmware_into_buf(fw_loader_dev, "firmware.bin",
+					buf, firmware_size, 0);
+	ut_asserteq(firmware_size, ret);
+
+	ret = request_firmware_into_buf(fw_loader_dev, "firmware.bin",
+					buf, firmware_size - 10, 10);
+	ut_asserteq(firmware_size - 10, ret);
+
+	ret = request_firmware_into_buf(fw_loader_dev, "firmware.bin",
+					buf, firmware_size, firmware_size);
+	ut_asserteq(0, ret);
+
+	ret = request_firmware_into_buf(fw_loader_dev, "firmware.bin",
+					buf, firmware_size, firmware_size + 1);
+	ut_asserteq(-EINVAL, ret);
+
+	ret = request_firmware_into_buf(fw_loader_dev, "firmware2.bin",
+					buf, firmware_size, 0);
+	ut_asserteq(-ENOENT, ret);
+
+	free(buf);
+	return 0;
+}
+DM_TEST(dm_test_fs_loader_get_fw_in_buf, UTF_SCAN_FDT);
+
+static int dm_test_fip_loader_get_fw_in_buf(struct unit_test_state *uts)
+{
+	struct udevice *fw_loader_dev = NULL;
+	int firmware_size = 5;
+	char *buf;
+	int ret;
+
+	ut_assertok(bind_mmc(uts, "mmc13"));
+
+	ret = dm_test_fw_loader_get_dev(uts, "ethernet-phy@3", &fw_loader_dev);
+	ut_assertok(ret);
+	ut_assertnonnull(fw_loader_dev);
+
+	/* uuidgen -n @dns --md5 --name test = 45a113ac-c7f2-30b0-90a5-a399ab912716*/
+	ret = request_firmware_size(fw_loader_dev,
+				    "45a113ac-c7f2-30b0-90a5-a399ab912716");
+	ut_asserteq(firmware_size, ret);
+
+	buf = calloc(firmware_size, sizeof(*buf));
+	ut_assertnonnull(buf);
+
+	ret = request_firmware_into_buf(fw_loader_dev,
+					"45a113ac-c7f2-30b0-90a5-a399ab912716",
+					buf, firmware_size, 0);
+	ut_asserteq(firmware_size, ret);
+	ut_asserteq_mem("test\n", buf, firmware_size);
+
+	memset(buf, 0, firmware_size);
+	ret = request_firmware_into_buf(fw_loader_dev,
+					"45a113ac-c7f2-30b0-90a5-a399ab912716",
+					buf, firmware_size - 1, 0);
+	ut_asserteq(firmware_size - 1, ret);
+	ut_asserteq_mem("test", buf, firmware_size - 1);
+
+	memset(buf, 0, firmware_size);
+	ret = request_firmware_into_buf(fw_loader_dev,
+					"45a113ac-c7f2-30b0-90a5-a399ab912716",
+					buf, firmware_size - 2, 2);
+	ut_asserteq(firmware_size - 2, ret);
+	ut_asserteq_mem("st\n", buf, firmware_size - 2);
+
+	ret = request_firmware_into_buf(fw_loader_dev,
+					"45a113ac-c7f2-30b0-90a5-a399ab912716",
+					buf, firmware_size, firmware_size);
+	ut_asserteq(0, ret);
+
+	ret = request_firmware_into_buf(fw_loader_dev,
+					"45a113ac-c7f2-30b0-90a5-a399ab912716",
+					buf, firmware_size, firmware_size + 1);
+	ut_asserteq(-EINVAL, ret);
+
+	ret = request_firmware_into_buf(fw_loader_dev,
+					"300b74d6-cc34-4e68-ba5d-733157f633f7",
+					buf, firmware_size, 0);
+	ut_asserteq(-ENOENT, ret);
+
+	free(buf);
+	return 0;
+}
+DM_TEST(dm_test_fip_loader_get_fw_in_buf, UTF_SCAN_FDT);
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 2a5acc18c612..eee5be621f37 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -14,6 +14,7 @@ import struct
 import os.path
 import re
 import pytest
+import uuid
 
 import utils
 # pylint: disable=E0611
@@ -685,6 +686,61 @@ def test_ut_dm_init(ubman):
     with open(fn, 'wb') as fh:
         fh.write(data)
 
+def setup_fw_loader_fs_image(ubman):
+    """Create a 2MB disk image with a dummy firmware on it"""
+    mmc_dev = 12
+    fname, mnt = fs_helper.setup_image(ubman, mmc_dev, 0xc, img_size=2)
+
+    fw = os.path.join(mnt, 'firmware.bin')
+    data = b'\xaa' * 256
+    with open(fw, 'wb') as fh:
+        fh.write(data)
+
+    fsfile = 'vfat1M.img'
+    utils.run_and_log(ubman, f'fallocate -l 1M {fsfile}')
+    utils.run_and_log(ubman, f'mkfs.vfat {fsfile}')
+    utils.run_and_log(ubman, ['sh', '-c', f'mcopy -i {fsfile} {mnt}/* ::/'])
+    copy_partition(ubman, fsfile, fname)
+    utils.run_and_log(ubman, f'rm -rf {mnt}')
+    utils.run_and_log(ubman, f'rm -f {fsfile}')
+
+
+def setup_fw_loader_fip_image(ubman):
+    """Create a 2MB disk image with a FIP blob on it"""
+    mmc_dev = 13
+    fname, mnt = fs_helper.setup_image(ubman, mmc_dev, 0x83, img_size=2)
+
+    fw_name = 'test'
+    data = b'test\n'
+
+    fip_toc_header_size = struct.calcsize('<IIQ')
+    fip_toc_entry_uuid = uuid.uuid3(uuid.NAMESPACE_DNS, fw_name)
+    fip_toc_entry_size = len(fip_toc_entry_uuid.bytes) + struct.calcsize('<QQQ')
+
+    fipfile = 'test.fip'
+    with open(fipfile, 'wb') as fh:
+        # TOC Header: name, serial, flags
+        fh.write(struct.pack('<IIQ', 0xaa640001, 0x12345678, 0))
+
+        # TOC Entry: UUID, offset, size, flags
+        fh.write(fip_toc_entry_uuid.bytes +
+            struct.pack('<QQQ',
+                fip_toc_header_size + 2 * fip_toc_entry_size,
+                len(data), 0))
+
+        # TOC Entry End Marker: Zero UUID + size set to size of entire FIP
+        # Assume alignment as 1
+        fh.write(uuid.UUID(int=0).bytes +
+            struct.pack('<QQQ',
+                fip_toc_header_size + 2 * fip_toc_entry_size + len(data),
+                0, 0))
+
+        # Append data
+        fh.write(data)
+
+    copy_partition(ubman, fipfile, fname)
+    utils.run_and_log(ubman, f'rm -rf {mnt}')
+    utils.run_and_log(ubman, f'rm -f {fipfile}')
 
 def setup_efi_image(ubman):
     """Create a 20MB disk image with an EFI app on it"""
@@ -752,6 +808,8 @@ def test_ut_dm_init_bootstd(ubman):
     setup_cedit_file(ubman)
     setup_cros_image(ubman)
     setup_android_image(ubman)
+    setup_fw_loader_fs_image(ubman)
+    setup_fw_loader_fip_image(ubman)
     setup_efi_image(ubman)
     setup_rauc_image(ubman)
     setup_bls_prefix_image(ubman)
-- 
2.55.0

