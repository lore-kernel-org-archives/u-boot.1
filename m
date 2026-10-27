Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE7D60A2631
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 12:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LjK5NcdI;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E6HidF5l
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A84D060779;
	Tue, 27 Oct 2026 12:39:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nwAt3hUY8YzG; Tue, 27 Oct 2026 12:39:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 96C0F607CB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793104782;
	b=RYkoqs+DWiMr+wOktAg0e75mxZtu26BQPCZM7jgjU+I/QYCFG58FXafJYg71DlB+qcN8
	 p36nkOF6I/GAi/zS3ZA/Z+InDkl5jS13HcnRld2WX8CKY0kxgQ01Rg+7hYJyZQXLbJxi1
	 0fXB9uHrUZSzearWX85YKyu5NKEnZqiPoPyGk4RIXggzmKgN5rkakG77rH0ivCmXhwwda
	 8tXjfnMMYSPi4W/ql8xLiyYXSEuG9+CF1ElGtFShPMvJd0M5W8CrWQILIVYmUZkA6F0gP
	 qfPYx57iXAiJHs7/7pv00xrSgHpmKOfFmNfYLso384EKvuoCYawXJb4qK9SOuIFVXtg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793104782;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=T1zKCRUEXGgB1KkF5P44jEh8cPdmi7dRfZfij241SVs=;
	b=GyaYe9Jf+BNRhCVszQg4seE6na65Pqaatp+vxo8bNGioew+09uqJ+effabaoqrx10+oX
	 XAD79dwjb2tHX8vAs9WY7t2L8BH1XhQhjifFQ3p520RDhTcNtR5ShURpNDi8bfU7P5zsR
	 BMDHtZ+AdAhCnXkrlm8U2KtkP8yQ5cA6NqSmsAkrsoHcJOXqwsD+R63vMLdxZU576HlOd
	 8FDJqSdOxX6jay5G2KrpXX1GqqTxH6kWIouLp0uw8IoJAY0wbQfGJoPDo5wVsPFAEaVBV
	 RH8pOPZZ1BP8TJ3Je5hkNncYk7Gx7aRgNh98884WC3UZv1rXJX8B2fPmhKo1YZ2dJ2w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793104782;
	bh=T1zKCRUEXGgB1KkF5P44jEh8cPdmi7dRfZfij241SVs=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LjK5NcdIlRaVoyQqdb28rGdkPmVoPvPLFUXKIj+Od5bukKQ/+vk2TUCO5HuI3QHqy
	 yNQQ0NgykY9W0+x5oVQagY3wxvxvKTzIv01YH8d6ciDV0eOYBMvJ0tGTcwDgO0Y3Zv
	 Vn37I7dSpt0yLNhuPIE3iNUnukIgobqUfrUE5Soe09KkzZppqVAsVGaBQoP1u3S4d/
	 xrFyPnvv/ywbMoFQ2EK7nxJi7ZYoHP1RaZQ9RV5rYhYtZd1yTU32xNb/UHQZnNCRUE
	 AzsXbSlMOo+F1aDn51py4nuotpmBEFDm/gtC4VlxBTCzee5b4JZnWqNaaOES3Eo3pc
	 ydwr89k4bYKAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 96C0F607CB;
	Tue, 27 Oct 2026 12:39:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 56D444BC
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:39:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 47F7C4007E
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:39:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DkzeO16WLvBb for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 12:39:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B5F3F4005F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::532"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793104773;
 b=LD92iHZUHNc1ofljnZcwSZb9dpaqsYLNiFqszCXBu/CN3gEicwTuAiT2TfzyQ9JYKwS7
 o3tRuwrXpJmATBVARFDDctJFnlrOpJByy2ZpKS+KJYU2X/iT0B9iTWYmhNPEJdzXGJozn
 Gv8H/0XKTwdJH8ED/Qge9wfzDOzHfqeKMh31i1aH3V655ALuMd0F/S4otgPZz4HPkwybB
 60CaQ3ePdeijEk5enfpaA+oC+B/376vlaElggWXdYDl1Ur6io7JhmyqeSJBNHVN0g/enF
 cnnNQWZ1QXQNknWcg3y4pVQQAHYOYwIZJ1xEOQegAIxHWcJ3JkzOCQ+7KtHlER+uDuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793104773;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=T1zKCRUEXGgB1KkF5P44jEh8cPdmi7dRfZfij241SVs=;
 b=FsrssipQW9ACSImMlu39wKvo0xc5FM5O6yqs2fMEjOTPvakejIEyzgobESRE3m1jyyji
 hjpCSsHH7MXlO64Zmkvte/zoVMPEkBnXsMtOETJPkzL7XBsLSgwzoVo8cD7Bq2gEev8Gx
 3ZBvnL9jxUskdyga+23L9N8drt+ZRsRVwodA688jdHZV+Qf6wONW+c1EeqT0WHLR1GhZR
 S2dQ1cUGSJMB+kTwjiWKUKwWUTS6sxpPXjN8/6TDWpTVuuy2QRbOWzjrj6BPiBWsCGLFz
 aq7N9TGlQ97e3bvlwUVS829SjHCxYYPqx3Va/MWeOYkBgWCwxKjNXdsjAgCXdBJT6BA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=E6HidF5l; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::532"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=E6HidF5l
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B5F3F4005F
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:39:31 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa4d71e7so4469301a12.0
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 05:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793104769; x=1793709569;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=T1zKCRUEXGgB1KkF5P44jEh8cPdmi7dRfZfij241SVs=;
 b=E6HidF5lQiIznAv1dEedvYgcdJGsfO8Z2XY+69dI4aUeFJrBYyLfnDR9IKlWlOTvru
 OcvFEY/OGKiVKBy+A5IaWOWXCH/V41yPDfrelc3WfhLCqpLoHTdmjKm2Ta+Wx7GznNnd
 JG/1S6Vet9VzZt3xvsiSpaIGfHIWj9ZUTFAvCeLtm0uOrQjaWMIWM4FrsJX6QzM9/nld
 eqXXgUoHenfgXCkMNvN729ZQVNgz9hic6UL0HFwBzQHuYka2MXSFM8Cte0mBErHPUbOt
 /bAjR5HRtOvv5kKtaWObFght03HewXpskKyNO5KjJCY5UBdZgjg3zxdWxIih1xwF5MGK
 +i/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793104769; x=1793709569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=T1zKCRUEXGgB1KkF5P44jEh8cPdmi7dRfZfij241SVs=;
 b=q4bSOtFyKfMxZ3zucfQvvAgwzS/9K5tIyjuB3mZtY4L8oWsgHwlveBFgcKgfaX5ekV
 4cnqovoGrkImDHKiJGPIuviQJmD76/XRkaToG0rT72aUeQ4y5DFZzAYZzwhDnob499Tf
 Extys0AAanLrNcvAaEW4GoMb1OE9unCTcD2jSBeRSwo/heXrLCSM2eePV8lgd7ddiHFE
 9ROcpOMM0aatQOmy3G3q/B/aaZqUs6SHiJFYkvdAr6r2+rcv05/xGuPQMzA2skdUHmj7
 /sOo2ASwxHXvaqUkBuMsLtcxsWINeM+SnDjoKoKbzv80RWAI+RuxLWrbfWQLxhtvVMAS
 lz1w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwlg9cWZqXIKHAtOiqGg2OhmQeEEgKFDLIT8s9k451duKIFWbe6zK2JCnhRonFnvrSN5ozoCzA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKzCXnOQWU+z3/wQ/5MuG8Mh+HzX3WvyhSIlEbQSevMJsNImtc2
 g5ITXWasGoZn89/ufq7A8gqGEQ+60A4KtrtKHQ8icvy3rP+zEL1WwM1q
X-Gm-Gg: AYBFou06vrciFWKHzy5bxseWVI6Za6GlWKnJhw7TaoSvCnQd0g6ikkPBng2opNjpqiO
 teUlqk0bhS5hFn1pu8P4PiJNd+R1RUmvGCX2/fXBtAWlbccpF7UkgOLDd4hCgXUW4ujqI7TPVM/
 yx7zl62hrIrAZwa+DC/fE2mQziLHaR2fH+M7c4SubRWiwKDlC2Df7f0YLUts7noovPBd0veDB4P
 Sepdp0lvEmOMG5158IdBGWQhzfoDu2/KIHiHXgnsuUPJuEWn6pN/oXCNdb6hZGSjz1pQzSP2tlh
 nEY2gJAOZTezMB86W9hTP9WOvQ7y8sUQiFOXgD7KGA1kpIPDzqmBol/Fg6nG18zULpBk7E4gI4W
 UL8rlIsIGO5uT4yUOkx21irWjlaIK3Wd8KxoGg6CkzB70oz1L9wGPlgrz4IK4t0ylSifm1YviJF
 ZyRoXFph8rrJhljG9xS7tIOxjE/uDjOFrVaEMrlmXuO48re8UQ/jAUU0zjwO/39DbuXAXwLzinZ
 laCEdbnoHDp12E+4TiR3wyiPfda7UqpDHR0ieu6VWiO9HUhWyZyfPI4xlC/I+YrA3hE5cQ+N3tW
 Aka+zMRzgz/1PygA7J0yM67HT9YCQ5O7Q52+XzwcoadWrBob1jGiafirAHP4
X-Received: by 2002:a17:907:6d18:b0:c2e:4f16:fbf with SMTP id
 a640c23a62f3a-c46bde74274mr1127560166b.31.1793104769193; 
 Tue, 27 Oct 2026 05:39:29 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd8c05sm29142078f8f.49.2026.10.27.05.39.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 05:39:28 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>, Alexey Charkov <alchark@flipper.net>,
 Rasmus Villemoes <ravi@prevas.dk>, "Lucien.Jheng" <lucienzx159@gmail.com>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Neha Malcom Francis <n-francis@ti.com>, Yao Zi <me@ziyao.cc>,
 Peng Fan <peng.fan@nxp.com>, Martin Schwan <m.schwan@phytec.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org
Subject: [PATCH v11 8/8] test: dm: Add test for FW Loader feature
Date: Tue, 27 Oct 2026 13:39:03 +0100
Message-ID: <20261027123905.839-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027123905.839-1-ansuelsmth@gmail.com>
References: <20261027123905.839-1-ansuelsmth@gmail.com>
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
 configs/sandbox_noinst_defconfig   |   2 +
 configs/sandbox_spl_defconfig      |   4 +
 configs/sandbox_vpl_defconfig      |   4 +
 test/dm/Makefile                   |   1 +
 test/dm/fw_loader.c                | 254 +++++++++++++++++++++++++++++
 test/py/tests/test_ut.py           |  58 +++++++
 10 files changed, 367 insertions(+)
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
index 59e08d03f776..51f8adf36e5b 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -175,6 +175,8 @@ CONFIG_CROS_EC_SPI=y
 CONFIG_P2SB=y
 CONFIG_PWRSEQ=y
 CONFIG_I2C_EEPROM=y
+CONFIG_FIP_LOADER=y
+CONFIG_FS_LOADER=y
 CONFIG_MMC_SANDBOX=y
 CONFIG_DM_MTD=y
 CONFIG_MTD_RAW_NAND=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index f307972a762d..4683f11300b9 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -259,6 +259,8 @@ CONFIG_CROS_EC_SPI=y
 CONFIG_P2SB=y
 CONFIG_PWRSEQ=y
 CONFIG_I2C_EEPROM=y
+CONFIG_FIP_LOADER=y
+CONFIG_FS_LOADER=y
 CONFIG_MMC_PCI=y
 CONFIG_MMC_SANDBOX=y
 CONFIG_MMC_SDHCI=y
diff --git a/configs/sandbox_flattree_defconfig b/configs/sandbox_flattree_defconfig
index 57f915d4ba9a..61fa3b8f7036 100644
--- a/configs/sandbox_flattree_defconfig
+++ b/configs/sandbox_flattree_defconfig
@@ -139,6 +139,8 @@ CONFIG_CROS_EC_SPI=y
 CONFIG_P2SB=y
 CONFIG_PWRSEQ=y
 CONFIG_I2C_EEPROM=y
+CONFIG_FIP_LOADER=y
+CONFIG_FS_LOADER=y
 CONFIG_MMC_SANDBOX=y
 CONFIG_SPI_FLASH_SANDBOX=y
 CONFIG_BOOTDEV_SPI_FLASH=y
diff --git a/configs/sandbox_noinst_defconfig b/configs/sandbox_noinst_defconfig
index 7a7550127956..326541413ae5 100644
--- a/configs/sandbox_noinst_defconfig
+++ b/configs/sandbox_noinst_defconfig
@@ -174,7 +174,9 @@ CONFIG_CROS_EC_SPI=y
 CONFIG_P2SB=y
 CONFIG_PWRSEQ=y
 CONFIG_SPL_PWRSEQ=y
+CONFIG_FIP_LOADER=y
 CONFIG_FS_LOADER=y
+CONFIG_SPL_FIP_LOADER=y
 CONFIG_SPL_FS_LOADER=y
 CONFIG_MMC_SANDBOX=y
 CONFIG_DM_MTD=y
diff --git a/configs/sandbox_spl_defconfig b/configs/sandbox_spl_defconfig
index 60b497f48886..32ed5150093d 100644
--- a/configs/sandbox_spl_defconfig
+++ b/configs/sandbox_spl_defconfig
@@ -154,6 +154,10 @@ CONFIG_P2SB=y
 CONFIG_PWRSEQ=y
 CONFIG_SPL_PWRSEQ=y
 CONFIG_I2C_EEPROM=y
+CONFIG_FIP_LOADER=y
+CONFIG_FS_LOADER=y
+CONFIG_SPL_FIP_LOADER=y
+CONFIG_SPL_FS_LOADER=y
 CONFIG_MMC_SANDBOX=y
 CONFIG_SPI_FLASH_SANDBOX=y
 CONFIG_SPI_FLASH_ATMEL=y
diff --git a/configs/sandbox_vpl_defconfig b/configs/sandbox_vpl_defconfig
index c85bfbfb3b15..b1f2a084ce0f 100644
--- a/configs/sandbox_vpl_defconfig
+++ b/configs/sandbox_vpl_defconfig
@@ -161,6 +161,10 @@ CONFIG_CROS_EC_SPI=y
 CONFIG_P2SB=y
 CONFIG_PWRSEQ=y
 CONFIG_SPL_PWRSEQ=y
+CONFIG_FIP_LOADER=y
+CONFIG_FS_LOADER=y
+CONFIG_SPL_FIP_LOADER=y
+CONFIG_SPL_FS_LOADER=y
 CONFIG_MMC_SANDBOX=y
 CONFIG_SPI_FLASH_SANDBOX=y
 CONFIG_SPI_FLASH_ATMEL=y
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
index 000000000000..aeddd4b652b0
--- /dev/null
+++ b/test/dm/fw_loader.c
@@ -0,0 +1,254 @@
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
+/* uuidgen -n @dns --md5 --name test = 45a113ac-c7f2-30b0-90a5-a399ab912716*/
+#define TEST_UUID	"45a113ac-c7f2-30b0-90a5-a399ab912716"
+#define TEST_INVAL_UUID	"300b74d6-cc34-4e68-ba5d-733157f633f7"
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
+static int fw_loader_get_dev(struct unit_test_state *uts,
+			     const char *name, struct udevice **devp)
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
+	return get_fw_loader_from_node(phy_node, devp);
+}
+
+static int dm_test_fs_loader_get(struct unit_test_state *uts)
+{
+	struct udevice *fw_loader_dev = NULL;
+	int ret;
+
+	ut_assertok(bind_mmc(uts, "mmc12"));
+
+	ret = fw_loader_get_dev(uts, "ethernet-phy@1", &fw_loader_dev);
+	ut_asserteq(-ENODEV, ret);
+	ut_assertnull(fw_loader_dev);
+
+	fw_loader_dev = NULL;
+	ret = fw_loader_get_dev(uts, "ethernet-phy@2", &fw_loader_dev);
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
+	ret = fw_loader_get_dev(uts, "ethernet-phy@3", &fw_loader_dev);
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
+	ret = fw_loader_get_dev(uts, "ethernet-phy@2", &fw_loader_dev);
+	ut_assertok(ret);
+	ut_assertnonnull(fw_loader_dev);
+
+	ret = request_firmware_size(fw_loader_dev, "firmware.bin");
+	ut_asserteq(15, ret);
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
+	ret = fw_loader_get_dev(uts, "ethernet-phy@3", &fw_loader_dev);
+	ut_assertok(ret);
+	ut_assertnonnull(fw_loader_dev);
+
+	ret = request_firmware_size(fw_loader_dev, TEST_UUID);
+	ut_asserteq(5, ret);
+
+	return 0;
+}
+DM_TEST(dm_test_fip_loader_get_fw_size, UTF_SCAN_FDT);
+
+static int dm_test_fs_loader_get_fw_in_buf(struct unit_test_state *uts)
+{
+	struct udevice *fw_loader_dev = NULL;
+	int firmware_size = 15;
+	char *buf;
+	int ret;
+
+	ut_assertok(bind_mmc(uts, "mmc12"));
+
+	ret = fw_loader_get_dev(uts, "ethernet-phy@2", &fw_loader_dev);
+	ut_assertok(ret);
+	ut_assertnonnull(fw_loader_dev);
+
+	ret = request_firmware_size(fw_loader_dev, "firmware.bin");
+	ut_asserteq(firmware_size, ret);
+
+	ret = request_firmware_size(fw_loader_dev, "firmware2.bin");
+	ut_asserteq(-ENOENT, ret);
+
+	buf = calloc(firmware_size, sizeof(*buf));
+	ut_assertnonnull(buf);
+
+	/* Normal read */
+	ret = request_firmware_into_buf(fw_loader_dev, "firmware.bin",
+					buf, firmware_size, 0);
+	ut_asserteq(firmware_size, ret);
+	ut_asserteq_mem("This is a test\n", buf, firmware_size);
+
+	/* Read up to size */
+	memset(buf, 0, firmware_size);
+	ret = request_firmware_into_buf(fw_loader_dev, "firmware.bin",
+					buf, firmware_size - 5, 0);
+	ut_asserteq(firmware_size - 5, ret);
+	ut_asserteq_mem("This is a \0\0\0\0\0", buf, firmware_size);
+
+	/* Read at offset */
+	memset(buf, 0, firmware_size);
+	ret = request_firmware_into_buf(fw_loader_dev, "firmware.bin",
+					buf, firmware_size - 10, 10);
+	ut_asserteq(firmware_size - 10, ret);
+	ut_asserteq_mem("test\n\0\0\0\0\0\0\0\0\0\0", buf, firmware_size);
+
+	/* Read at offset with bigger buffer but firmware ends */
+	memset(buf, 0, firmware_size);
+	ret = request_firmware_into_buf(fw_loader_dev, "firmware.bin",
+					buf, firmware_size, 10);
+	ut_asserteq(firmware_size - 10, ret);
+	ut_asserteq_mem("test\n\0\0\0\0\0\0\0\0\0\0", buf, firmware_size);
+
+	/* Read at offset equal to firmware size */
+	ret = request_firmware_into_buf(fw_loader_dev, "firmware.bin",
+					buf, firmware_size, firmware_size);
+	ut_asserteq(0, ret);
+
+	/* Read at offset beyond firmware size */
+	ret = request_firmware_into_buf(fw_loader_dev, "firmware.bin",
+					buf, firmware_size, firmware_size + 1);
+	ut_asserteq(-EINVAL, ret);
+
+	/* Non existent file */
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
+	ret = fw_loader_get_dev(uts, "ethernet-phy@3", &fw_loader_dev);
+	ut_assertok(ret);
+	ut_assertnonnull(fw_loader_dev);
+
+	ret = request_firmware_size(fw_loader_dev, TEST_UUID);
+	ut_asserteq(firmware_size, ret);
+
+	ret = request_firmware_size(fw_loader_dev, TEST_INVAL_UUID);
+	ut_asserteq(-ENOENT, ret);
+
+	buf = calloc(firmware_size, sizeof(*buf));
+	ut_assertnonnull(buf);
+
+	/* Normal read */
+	ret = request_firmware_into_buf(fw_loader_dev, TEST_UUID,
+					buf, firmware_size, 0);
+	ut_asserteq(firmware_size, ret);
+	ut_asserteq_mem("test\n", buf, firmware_size);
+
+	/* Read up to size */
+	memset(buf, 0, firmware_size);
+	ret = request_firmware_into_buf(fw_loader_dev, TEST_UUID,
+					buf, firmware_size - 1, 0);
+	ut_asserteq(firmware_size - 1, ret);
+	ut_asserteq_mem("test\0", buf, firmware_size);
+
+	/* Read at offset */
+	memset(buf, 0, firmware_size);
+	ret = request_firmware_into_buf(fw_loader_dev, TEST_UUID,
+					buf, firmware_size - 2, 2);
+	ut_asserteq(firmware_size - 2, ret);
+	ut_asserteq_mem("st\n\0\0", buf, firmware_size);
+
+	/* Read at offset with bigger buffer but firmware ends */
+	memset(buf, 0, firmware_size);
+	ret = request_firmware_into_buf(fw_loader_dev, TEST_UUID,
+					buf, firmware_size, 2);
+	ut_asserteq(firmware_size - 2, ret);
+	ut_asserteq_mem("st\n\0\0", buf, firmware_size);
+
+	/* Read at offset equal to firmware size */
+	ret = request_firmware_into_buf(fw_loader_dev, TEST_UUID,
+					buf, firmware_size, firmware_size);
+	ut_asserteq(0, ret);
+
+	/* Read at offset beyond firmware size */
+	ret = request_firmware_into_buf(fw_loader_dev, TEST_UUID,
+					buf, firmware_size, firmware_size + 1);
+	ut_asserteq(-EINVAL, ret);
+
+	/* Non existent file */
+	ret = request_firmware_into_buf(fw_loader_dev, TEST_INVAL_UUID,
+					buf, firmware_size, 0);
+	ut_asserteq(-ENOENT, ret);
+
+	free(buf);
+	return 0;
+}
+DM_TEST(dm_test_fip_loader_get_fw_in_buf, UTF_SCAN_FDT);
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 2a5acc18c612..004419615376 100644
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
+    data = b'This is a test\n'
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
+        # TOC Entry End Marker: Zero UUID + offset set to size of entire FIP
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

