Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D18E7E0CD
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 17:13:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 708FE83CEE;
	Mon,  9 Feb 2026 18:12:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="K6Ey/Zjq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B35CA8341A; Mon,  9 Feb 2026 17:40:30 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 493788388D
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 17:40:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7d19bfe1190so3708367a34.1
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 08:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770655227; x=1771260027;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mp5KpfrX+kS1TIGkovL0IMsd6JsOMKuYlIg57sBSu4c=;
 b=K6Ey/Zjqsw3RuKMV2ujmw+pmTXMmzqBjojffgmw4BAMdR9SEhPMMvrAJvkNwz+qnF3
 gMOfmdbjostv+HcpXiuehJHMsE7cLom8Azvn2MpLARa8diLCE7m+kVaD+UP5XviVWvo1
 hbuhC8v6d4kCITt9sTvl1jfrRk5OKm4xFCWVEFVEmlX3Jk1I8dzPMhGOVFwkQEQ4fE/O
 MmfcUAlxnlCQTmOGjFsB8xyqfU7QIewxWoE3/57dPeu9FF1X6WRJn6R8asv037nsnlad
 ot1Tl4UGYbaORPgprToOhF15KKggHCX/au7/9lQ0P85n65KAHAXcEFvb65JcY0Yb2Jfc
 s2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770655227; x=1771260027;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mp5KpfrX+kS1TIGkovL0IMsd6JsOMKuYlIg57sBSu4c=;
 b=P5nNf1TXbiR6Ibk/v7tVQyCSCswgDUIh2choh/iNRa1XY7/2o0zqJKxt0iszkJbYqg
 7f35K3E4uES3ugz7+ivL8P2nd1WcqomHXlkcook63xGGN1fVLDKQGohounVZMdJ1uGdn
 gTOl2SsyRf/I4drVx+a7idFQ3Wm6mVoqrF8T1AAMMZvVzbuKDbE2ahGVnJgPTGYnRjnI
 E6kyWve098G09HOhOLq6k46pOg2Rgfn2nMo6JQXp4N+b5EeRHInwharXt8AyWBowfhgT
 SrLWBekxwIs9ngBTSgCqOvkWoyBA199lefgzoBn3qkZB1k0G581BG935PK+musm7JbYU
 /blA==
X-Forwarded-Encrypted: i=1;
 AJvYcCURFfbbNj5YLVjkAM19am36yHnL0b9iAIJ4q8LEw2dCn6gC6yr1NxcMdy3OVB41d0+hDixtfXo=@lists.denx.de
X-Gm-Message-State: AOJu0YwgS/ItwwQssyDL1iA80tKp3ROG/mzLOne6D5Q6fd4QSV7PpHCC
 Hksb8kxWwFru6BvLGWDC1SPh0UdGLj/7PxHdaKhIRS7hip5I7NrQOBdMrpPi8nhgByU=
X-Gm-Gg: AZuq6aI2AX3XNZFxN31lmvk9R2nZMh9MNSCfjd/XJ8TaX8ppeKMM+WUQsIdnAWhC03v
 WBeLAoBqGJ6hw6WJNditVbRxWcnucm5uPN5Pnuim6i6byNXHgzI2hoPlvY29O7oLTouwLk7PzhO
 iH8vTBcxjqSGUCNuQc4BZj0q4982Oxs/HYqNUmiHUcu7RtrDyzDf8fxqy8zj3HoN24DsXf+zr9T
 wWunhBtuSEphDaUSBFq6jVk41U+iN5HI0Un1hg8ZK5/MUPMKLJlccoHtg9dR9Def5Qe+BN64a11
 d+PJ/CtLeZUzjXUZf+nYV350ZjAyA4gWnazSW8FXF0fP1WLAvgfLkPw0XTUGenbwo3TtSz7dx94
 mDtgurS8kb1QZrwxMg9KH0ijJk4ghb5yQFDaRhj+YhdLAllf+USAGuttNZB0i7Jad5WhxcyzyZM
 LO3K8NmRBSulkwxkk=
X-Received: by 2002:a05:6830:6996:b0:7c7:62d0:b462 with SMTP id
 46e09a7af769-7d4643d7229mr7483896a34.6.1770655227067; 
 Mon, 09 Feb 2026 08:40:27 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:cee0:eb0c:b683:ad1d])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d464785d7esm7731139a34.15.2026.02.09.08.40.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 08:40:26 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 09 Feb 2026 10:39:30 -0600
Subject: [PATCH v2 5/7] board/mediatek: move EVK MAINTAINERS to common file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-mtk-mach-clean-up-duplicates-v2-5-e3b22282c74d@baylibre.com>
References: <20260209-mtk-mach-clean-up-duplicates-v2-0-e3b22282c74d@baylibre.com>
In-Reply-To: <20260209-mtk-mach-clean-up-duplicates-v2-0-e3b22282c74d@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1411; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=LASzHMMl8LX4HdA0+U4o4IikT/6VqfY1S1/60Vpe2ek=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpig3j7ZcHN+VBLF70ddxUEkyurM1X7h9D75Ht4
 Xb3GY43tQyJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaYoN4xYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AyrwH/jHD6oCNXy5k5ZvVlXdEx4RVJBQmsRB5LK8A2LQ
 uUhFBP9mzWmShsWSbnvPnNaEVIbULBM5P/O32dPnruHolF38C3YPnXxDb3eyco+Iuy9QE89HsHO
 jb2I0W7/KAyLHjdku8FC53GsF8l48lIeJ1sMSa5aRq/DgvX54lx5JVNMIm2bL/tBVF/Xv8/PgoK
 Stk5Fuqr36TUa6IxWI8RgYVWXtaWyZ7LixXsjF4DX8SGF1cHL8ohSIoigYNKNrBL9PP0Hg0dVbf
 h5K/VywtJIYa2T8gvp1wJrrHyPK4DPqbPz/qJpcuegqWljmf8KZLQfcEXDNkFGJL6/ITO/VtbG8
 P7BY=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Mon, 09 Feb 2026 18:12:16 +0100
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Move the mt8365_evk and mt8390_evk MAINTAINERS files to a common
MAINTAINERS file. We will be deleting the board-specific directories
soon but we need to keep the MAINTAINERS for the defconfig entries.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
v2 changes: new patch in v2
---
 board/mediatek/{mt8390_evk => }/MAINTAINERS | 6 ++++++
 board/mediatek/mt8365_evk/MAINTAINERS       | 5 -----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/board/mediatek/mt8390_evk/MAINTAINERS b/board/mediatek/MAINTAINERS
similarity index 56%
rename from board/mediatek/mt8390_evk/MAINTAINERS
rename to board/mediatek/MAINTAINERS
index d46b8b2e156..3345c87d30b 100644
--- a/board/mediatek/mt8390_evk/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -1,3 +1,9 @@
+MT8365 EVK
+M:	Julien Masson <jmasson@baylibre.com>
+S:	Maintained
+F:	board/mediatek/mt8365_evk/
+F:	configs/mt8365_evk_defconfig
+
 MT8390 EVK
 M:	Julien Masson <jmasson@baylibre.com>
 M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
diff --git a/board/mediatek/mt8365_evk/MAINTAINERS b/board/mediatek/mt8365_evk/MAINTAINERS
deleted file mode 100644
index e0d65efe812..00000000000
--- a/board/mediatek/mt8365_evk/MAINTAINERS
+++ /dev/null
@@ -1,5 +0,0 @@
-MT8365 EVK
-M:	Julien Masson <jmasson@baylibre.com>
-S:	Maintained
-F:	board/mediatek/mt8365_evk/
-F:	configs/mt8365_evk_defconfig

-- 
2.43.0

