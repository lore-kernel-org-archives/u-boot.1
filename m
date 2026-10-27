Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA5C606A332
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 12:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DK32ng0Y;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NtJJ4U0K
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DCE81607A7;
	Tue, 27 Oct 2026 12:39:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N6VgEWMBEWPb; Tue, 27 Oct 2026 12:39:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 27639607BC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793104777;
	b=mcAabEd/D2Hm0EuVYGdHTIZ0lOc7I/yF0/DKEfMY6ojSXz8cQdFTDvFpxjAa3PcePK9R
	 1KVaZkTFpSQBSobLBCFzYz8RAUYCchw9J+wPlb1Ka3XC04GjbV8h8rce28Us5QN+TCmZj
	 VzhAonNqrkNlo+Ha8yQmrZqRGU6AprDpBSi9TIkM205U7UFo0fHGSxSs8UtKq/x4q5HlC
	 EgqNKVyoB+NdgP9cs40wmrKxkOYhb35DfRRsysiR1DmsbXnOjQ1RsEoJgiJ1mIP26gjtB
	 lcGuB4G8M9GGj50q0+t+Py9H23LrOf3idNUQ0lzX/UnF9DNHAgF/gZ2yOI8ZUKz9qPQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793104777;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=lU5ykpYWtAOqsDeeloZnZUNojIrXPwskNd/Kd2GwfB0=;
	b=ntZ03B+jOZV8wrqIuOnrCkTc1xOwuv360G7XnZFna5sqdHng9vt3g/tFBjIrNwp3yr0m
	 2OH7MQnMm5a306+3fe7kNGSCfexKk0WvL/onro1IZxj5jZ+551fIy3hFt4diDFFzTiv8j
	 9BojtaTj49X2pNZZy7P1lkZhEX/3kBI25xv/6BLPPBjog4tm+YA4qvpgVVHHYW4rzOja/
	 GQnli695ejM5CfFO/p8SJBIfbjIQKElWvPw+FkR+BHY/k1Ve8WcnGy3OdqeM6koJ72kr/
	 SQEla9eWXm9QO9NOHtz5RLdzWhGIt+EaeLDqKWQGqIrA4j1K61tgOEQvKe9OpNiQUIg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793104776;
	bh=lU5ykpYWtAOqsDeeloZnZUNojIrXPwskNd/Kd2GwfB0=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DK32ng0YqEkCOWdHqNONz9/W5cl4B3MNjbYETWWKw46NRTMRN5R3CY2xDaJtZj+Up
	 HHoJp0JmBXabTzh0Amk3DOs6kfN6wUgry1MAjkfHFthh5OKG8q5+Vok827z7cODy+O
	 fTIISUMnFf96ntkyhkWi62q0gQ5jstHnD9+Z4Ck7dUQLxLtJuaoyNMlQCf8xYjkckH
	 806KWv4Qu2wklFgm3nCwD/P4skP7gK0+3hlZx6vtCfbfc7vtABMpn8Q8LFeKL2W2a6
	 CJKEXD/+LvYKdWhd0yNkKzD2H2cX2q4h8UIgYGYaslrCd7un6+TweIGZtvUgHZYX8m
	 wrBn7UhqqYKqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27639607BC;
	Tue, 27 Oct 2026 12:39:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5BBBB279
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:39:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4D93480C0F
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:39:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iXvG0D7eOO_V for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 12:39:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 13E7380AE6
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793104768;
 b=SsjO/k9RGRClSA9XUy3mhTZ5uu20jOOLggpmVeX+Ew+hNF6oVXEFCA88isgQVchPY1Li
 8V6qqU0mPucb4D7Bd3xNdU9e4BktbRNjb5ClziD+CYy/vNnz0F8bkEeC8Pu1dE8EBg4eK
 pcEU/fsPe2ZagqtnK8IgdO1gRFx5zPU8uajlwe8vv5c9WlYFLueB7KlXJACnoWPdy7UT9
 1v/ZC9p9JTRH0vnuIYgc3TwE5D3q5a3vMGFPUEbwdO4fMRRuwDiDbF2TcWwWy+UDPsN9c
 ud0fUEzk395nIswbSXsqDYE+JC1Hmkf85F4NGYmeB4/70SlIh6yjRSe8pelyN7ihuCw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793104768;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=lU5ykpYWtAOqsDeeloZnZUNojIrXPwskNd/Kd2GwfB0=;
 b=ibjhg/4uxyExqjLDIvQs1aAPCwPVxXYmaaVQBpIk0O6oemHrQiTcD2fmRhLESxyHR3Rm
 PDZv/ADEvdH1QAgRZOnrGnS5uinCwgeKoIfgWyIGoe4FL3Ts3H6QOQXK5sDEWS2UoZlYp
 bX7XWN+PRRAQdjnvlj7f1N7fZkrtx538/jH1FxiKzDGN6oY1HDi6ijb32dqFjoS2sSdEx
 cb+GuXKZb2PC+gpEers2m+dgLKR1IFBhaysrhXTo0BruLW7gGaQ/f6vOIfjbWutcBkheT
 hlXD95EAQ73k2Z+Fyo129HMW+7nt6o3zLMV8OA83TiYuj/UaKYY2+VUxAFhe43BJ8jw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=NtJJ4U0K; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=NtJJ4U0K
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 13E7380AE6
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:39:27 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a20bdaf39cso42558245e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 05:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793104766; x=1793709566;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lU5ykpYWtAOqsDeeloZnZUNojIrXPwskNd/Kd2GwfB0=;
 b=NtJJ4U0K3du+cdP3BTLg9scK+wwEIjx8RJdpRLnvt7GwjLIUgFI5t6e78HFNsEAA9M
 KjwhRjd4vpQ3gfuAFmE60LnwXjqq6N/C0izA54r845jGiIo/Z/2HfNEZYY7Beq8+Ifac
 LDG+/eAvD0zYCJdfGvkCOqZu39j1yIudQytWAo+U8Uk7THSU4BE8HQN5wA290veS3e0w
 WDuuOX9yRJKA48fJK9+9UutVjR3EtwuC7vzH4JrqzYCRr8ZGvc6SZ+BMuGfSY3d/jDrG
 K4T66kVuPYOrJRxnw/qLNtKaAVhjqz0VOUEE1okgx7dc6jYwHKM/G2M2Lyp5GW5OJtqQ
 l7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793104766; x=1793709566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=lU5ykpYWtAOqsDeeloZnZUNojIrXPwskNd/Kd2GwfB0=;
 b=KKpkHidr6+tL1c184HXupfYUMgu7+haRZLidYiCzNfD9xD3SvXeQAUd9xFwvbU0GIe
 AAgU4gROOqgCbH4USAbFUwoBciZP1ZxFgczIZQHpKOCZhpsBoB1xMON2hqLpm0YIh1eJ
 LRys+0yRARvlLmySixdaz1lACmipzsNlZF1mtuJmkSU1HyNSXGJXKeOpkGNAedMtfO+B
 GrwnF3zBzQ9P9JmzmvZjjqrXKBMoMJc8lRe+xpZ+vcWKujVfKh6uxo0l3IiIwRfkOsJt
 6CEsdpIHCUuc/PRqyZbe2x/Ibn64lrojSsQUTRB++nuF4xEcdlUVzZi+FhfVssVIKTr0
 Yaxg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzbFgFIpvn5SnZmVZJu5aEzY26HIO4SeMQgwSl5vVHwqGrW9K5zM/2ESPeKPNoxJ4YGraA45Qo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI+jgspxfEyNrg/EEji+lblHv2ix5Tgh1CRdF3EYEcMuai6c4LP
 nKGKrXmO05XLjoSOg0+HFsbtZOPFeNbSEBqImhZMD5zokUTBNo2Tcr0F
X-Gm-Gg: AYBFou1xghPNgRSQVH6YJzTY+el8QAsMrMAUWdKd8eSIJ6zeJiYk2kqXKACZpHRxI5q
 t9GmjJifBa2Dw6nKyxMAlIApX7eVViZB7zLV3SFNN255rOp4r8Cu/hWS0gMRBsSkIBajzKRR787
 GM8ZNzz5VOMnRyu0YXPkl/2CYACLWecGx4zQT2x8yqOqx8L4N7M4DtHxj6eusp33XTXTFGb1D9F
 nlgH6O7cBefJeeXoUBW5rsTNFxEthOGdDwmGerndlKDfOBfERJLgZB1q5Oy640c0AYGtLf51g3X
 2X9kDaP4iq8KScZpkcrKf0oCRAyPnr90MPLaGdRxt5zdzXl3KHS9D/ltGNq5VgVAYsopZRVTpyb
 Q3KfczFL6vLD+s0oA+Tqxp9tIrxRWABLUJ+vzsOfLKqeOKBPqxd9bMgyiH0tnAbzy1QSODpWXE8
 DOkXH3ezr+LmpIp5u5HhcUASK8zLuzFaHdkjVD0PB5F0E9ZeqWW8yDEjUamzMP07JVCg8ynUosn
 Qx957zoBYdFEoD8NTNrrjb776cngF5KCL0lzxHSEJkZhMWudQW22gwnsvDlHbIB5cuIT5ZKrc7M
 CYu8dt1qlBV15rc4lnaFhTEzbvsnY8uyKstEnbH/C5pSCFK/ob1ewRjcBl5LpInxpGvrnyudCz0
 4lU+rwg==
X-Received: by 2002:a05:600c:4ece:b0:4a1:6c0c:ab93 with SMTP id
 5b1f17b1804b1-4a35acb5854mr173800255e9.28.1793104765504; 
 Tue, 27 Oct 2026 05:39:25 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd8c05sm29142078f8f.49.2026.10.27.05.39.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 05:39:25 -0700 (PDT)
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
Subject: [PATCH v11 6/8] doc: dtbinding: Update documentation for Generic
 Firmware loader
Date: Tue, 27 Oct 2026 13:39:01 +0100
Message-ID: <20261027123905.839-7-ansuelsmth@gmail.com>
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

Update documentation for Generic Firmware loader to YAML schema,
generalize it from FS specific and add new property and example
for FIP loader.

Also add details on the usage of 'phandlepart', 'mtdpart' and 'ubivol'
property.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 doc/device-tree-bindings/misc/fs_loader.txt  |  48 --------
 doc/device-tree-bindings/misc/fw_loader.yaml | 112 +++++++++++++++++++
 2 files changed, 112 insertions(+), 48 deletions(-)
 delete mode 100644 doc/device-tree-bindings/misc/fs_loader.txt
 create mode 100644 doc/device-tree-bindings/misc/fw_loader.yaml

diff --git a/doc/device-tree-bindings/misc/fs_loader.txt b/doc/device-tree-bindings/misc/fs_loader.txt
deleted file mode 100644
index 542be4b25a0a..000000000000
--- a/doc/device-tree-bindings/misc/fs_loader.txt
+++ /dev/null
@@ -1,48 +0,0 @@
-* File system firmware loader
-
-Required properties:
---------------------
-
-- compatible: should contain "u-boot,fs-loader"
-- phandlepart: which block storage device and partition the image loading from,
-	       this property is required for mmc, usb and sata. This is unsigned
-	       32-bit array. For example phandlepart=<&mmc_0 1>, meaning use
-	       that MMC0 node pointer, partition 1.
-- mdtpart: which partition of ubi the image loading from, this property is
-	   required for ubi and mounting.
-- ubivol: which volume of ubi the image loading from, this property is required
-	  for ubi and mounting.
-
-Example of storage device and partition search set for mmc, usb, sata and
-ubi in device tree source as shown in below:
-
-	Example of storage type and device partition search set for mmc, usb,
-	sata and ubi as shown in below:
-	Example for mmc:
-	fs_loader0: fs-loader@0 {
-		bootph-all;
-		compatible = "u-boot,fs-loader";
-		phandlepart = <&mmc_0 1>;
-	};
-
-	Example for usb:
-	fs_loader1: fs-loader@1 {
-		bootph-all;
-		compatible = "u-boot,fs-loader";
-		phandlepart = <&usb0 1>;
-	};
-
-	Example for sata:
-	fs_loader2: fs-loader@2 {
-		bootph-all;
-		compatible = "u-boot,fs-loader";
-		phandlepart = <&sata0 1>;
-	};
-
-	Example for ubi:
-	fs_loader3: fs-loader@3 {
-		bootph-all;
-		compatible = "u-boot,fs-loader";
-		mtdpart = "UBI",
-		ubivol = "ubi0";
-	};
diff --git a/doc/device-tree-bindings/misc/fw_loader.yaml b/doc/device-tree-bindings/misc/fw_loader.yaml
new file mode 100644
index 000000000000..9a767ff57469
--- /dev/null
+++ b/doc/device-tree-bindings/misc/fw_loader.yaml
@@ -0,0 +1,112 @@
+# SPDX-License-Identifier: GPL-2.0+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/fw_loader.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: U-Boot Generic Firmware Loader
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description: |
+  Generic firmware loader for loading images from block storage devices
+  (MMC, USB, SATA) and UBI storage.
+
+  The fs-loader loads firmware images, while the fip-loader locates a
+  Firmware Image Package (FIP), optionally at a specified byte offset
+  within the selected partition.
+
+properties:
+  compatible:
+    enum:
+      - u-boot,fs-loader
+      - u-boot,fip-loader
+
+  phandlepart:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      Specifies the block storage device and partition from which the
+      image is loaded. Required for MMC, USB, and SATA devices.
+
+      The first cell is a phandle to the storage device, and the second
+      cell is the partition number.
+
+  mtdpart:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: |
+      Specifies the MTD partition from which the image is loaded.
+      Required for UBI devices.
+
+  ubivol:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: |
+      Specifies the UBI volume from which the image is loaded.
+      Required when loading from a UBI device.
+
+  partoffset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Byte offset within the selected partition where the FIP header
+      is located.
+
+required:
+  - compatible
+
+oneOf:
+  - required:
+      - phandlepart
+
+    properties:
+      mtdpart: false
+      ubivol: false
+
+  - required:
+      - mtdpart
+      - ubivol
+
+    properties:
+      phandlepart: false
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          const: u-boot,fs-loader
+    then:
+      properties:
+        partoffset: false
+
+additionalProperties: false
+
+examples:
+  - |
+    fw_loader0: fs-loader@0 {
+        bootph-all;
+        compatible = "u-boot,fs-loader";
+        phandlepart = <&mmc_0 1>;
+    };
+
+  - |
+    fw_loader3: fs-loader@3 {
+        bootph-all;
+        compatible = "u-boot,fs-loader";
+        mtdpart = "UBI";
+        ubivol = "ubi0";
+    };
+
+  - |
+    fw_loader4: fip-loader@4 {
+        bootph-all;
+        compatible = "u-boot,fip-loader";
+        phandlepart = <&mmc0 0>;
+        partoffset = <0x100>;
+    };
+
+  - |
+    fw_loader5: fip-loader@5 {
+        bootph-all;
+        compatible = "u-boot,fip-loader";
+        mtdpart = "ubi";
+        ubivol = "bl31";
+    };
-- 
2.55.0

