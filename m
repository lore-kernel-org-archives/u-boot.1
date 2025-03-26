Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42BFC36008
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 10:10:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 476D3808B6;
	Wed, 26 Mar 2025 11:10:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="jMO14Jbs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 961D5808B6; Wed, 26 Mar 2025 11:10:39 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CCF4806FC
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 11:10:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E81FD3F54D
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 10:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1742983836;
 bh=DJo/INbnk86FQuDZ6qawYgh3Jvneo0PJUd2oqHVaC3I=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=jMO14Jbs5BRcrcmt2Tq51foyCXaLf1dySxWMbm4Cx5JZKpo07H/sOasq8ypNroda+
 Dpv0pgG/JXROP637DPWTcLEb3mxwd/D0Dgnl+RiroCvkQn8njRm0qRwQ3JO0gEwlC8
 n4Z++63JMy88HoVHyPvY7tvPvjwAAp0SNUqm4LHB7sEt1QUVwyHszNkyVJTlF7vyFF
 n2aZFwxWCMmggr43C+PrTPai1OZCmKnG4aG4AkaUqi0/KchlWHSW1S7Q1sJ9N70fHP
 BO/MokXSDWgUFkNB90JApi95tROPzPlyWeE8mhnq6H7RNYNl/9PmW1BmZi42ksoVOn
 H6cW43Q5B6pKA==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43cec217977so2862925e9.0
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 03:10:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742983836; x=1743588636;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DJo/INbnk86FQuDZ6qawYgh3Jvneo0PJUd2oqHVaC3I=;
 b=TuXbyrwEKxej8SWU1NMNTmwGndTwB2Qep3XdGRRMSAhBaJ9gFOFO/Cw/htV+DBehHv
 567h1OHQ+8rIv2P139dX1veKoyUTNzGRK+7CgSYIZSXc+o9n4dNStGmM7ZTXZ165WEju
 eVgWfmmlifYCZ+Hb/oA/FSCjZYo7VWh++MgDw0RCsjq3qiASujH6K1Cn6N0vRzBu0Wxt
 CarxL+RaEmNN9GOrjrflp3fti+0ofvIuWzehOIhgKYlnp/etEL85D0Iv4JoEiccTOWwG
 +z1fIoCXr+TCO89+/9+oQbjQBaC1XZkUseh+F6IkvWDpE2kqfuVSKiUR/aWlGlgkshnM
 LEDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjm0RfUfPKHB8mJUeJFwWNbT2AAXSedZrKjjmK5T7dHrJCSKBFhtqf6/1Yc9sbnxSKtqRq06E=@lists.denx.de
X-Gm-Message-State: AOJu0Yz/1nIcmZFPMbY1GfQVugSflcObq94EvhjYPQaTGqLOcqYZUVIb
 /FLqAtNBs+x1nuZjlw44JLtZTI/+ww24S8xgjvTxDVk1anuxki5RZzK0sPCc8z3UuxOKjOcas8V
 W/9H2JDwSt2BcIzqoZB4e9Z4uQLaGvtMFf2Rmd449oOeXegkqlEy/Z5SkSFFWWZ00GzM=
X-Gm-Gg: ASbGncuKh6+qyQpIV5fcBWWwraHxNVyJXirTDD71QLgoam7TxP6uZB3lXgCPNkDbVvy
 CK9G26C/dAaSM7zDaY0brZHOdeuyWyWIiEoPJhMii0l2ZFfDePGUC2MmsBhU+OFXg5qR6BEsJRx
 K6AgPlqi/KyZjV1v7FO5Wk7nLyarJwFvMQYKjKe554rVNwzzLC0KPWO3rXlXTtXdZdvN7gIw5XH
 odYFenadW3TYGHGK7p/7R8F4R6aCgIYeOZfbBRlsV+DydgybTudTfN8A/2UxxaW9Z8mv/vSjUUq
 kwxlVVu7R8B7VmUDk3teOo/GpEEtY2ux9SmrtzPjw9evk6a2Rw==
X-Received: by 2002:a5d:64c8:0:b0:390:d6ab:6c49 with SMTP id
 ffacd0b85a97d-3997f94d923mr19667907f8f.35.1742983836328; 
 Wed, 26 Mar 2025 03:10:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtyI6D+ZV72bGhuYiIxXJtJnWPQv9FLObCdfKSOgtlcspA8ZA5Wh+P7sVkMLsXefoe2TRpzQ==
X-Received: by 2002:a5d:64c8:0:b0:390:d6ab:6c49 with SMTP id
 ffacd0b85a97d-3997f94d923mr19667870f8f.35.1742983835917; 
 Wed, 26 Mar 2025 03:10:35 -0700 (PDT)
Received: from localhost.localdomain ([2a02:3035:6e0:68e3:f378:8949:ac0d:6931])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fcea6ecsm178910665e9.5.2025.03.26.03.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 03:10:35 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Martyn Welch <martyn.welch@collabora.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: correct references to overlay-fdt-boot.txt
Date: Wed, 26 Mar 2025 11:10:24 +0100
Message-ID: <20250326101024.60764-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

doc/uImage.FIT/overlay-fdt-boot.txt does not exist anymore.
Reference the correct section of doc/usage/fit/overlay-fdt-boot.rst.

Fixes: 6f6e8bb695a7 ("doc: Bring in the FIT overlay information")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/README.pxe                     | 2 +-
 doc/usage/fdt_overlays.rst         | 4 ++--
 doc/usage/fit/overlay-fdt-boot.rst | 2 ++
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/doc/README.pxe b/doc/README.pxe
index af2e64a5776..9fff2cd5ae9 100644
--- a/doc/README.pxe
+++ b/doc/README.pxe
@@ -160,7 +160,7 @@ kernel <path>	    - if this label is chosen, use tftp to retrieve the kernel
 		      It will passed to bootm with that address.
 		      (see: doc/uImage.FIT/command_syntax_extensions.txt)
 		      It useful for overlay selection in pxe file
-		      (see: doc/uImage.FIT/overlay-fdt-boot.txt)
+		      (see: doc/usage/fit/overlay-fdt-boot.rst).
 
 fdtoverlays <path> [...] - if this label is chosen, use tftp to retrieve the DT
                       overlay(s) at <path>. it will be temporarily stored at the
diff --git a/doc/usage/fdt_overlays.rst b/doc/usage/fdt_overlays.rst
index 81d0d37f3f1..15ebd17ccb1 100644
--- a/doc/usage/fdt_overlays.rst
+++ b/doc/usage/fdt_overlays.rst
@@ -76,8 +76,8 @@ There are two ways to apply overlays in U-Boot.
 * Manually load and apply overlays
 
 The remainder of this document will discuss using overlays via the manual
-approach. For information on using overlays as part of a FIT image please see:
-doc/uImage.FIT/overlay-fdt-boot.txt
+approach. For information on using overlays as part of a FIT image please see
+:ref:`fit_configuration_using_overlays`.
 
 Manually Loading and Applying Overlays
 --------------------------------------
diff --git a/doc/usage/fit/overlay-fdt-boot.rst b/doc/usage/fit/overlay-fdt-boot.rst
index a7db1a37f7a..3d7296ad913 100644
--- a/doc/usage/fit/overlay-fdt-boot.rst
+++ b/doc/usage/fit/overlay-fdt-boot.rst
@@ -111,6 +111,8 @@ Where config is one of::
 
 This selects the DTB to use when booting.
 
+.. _fit_configuration_using_overlays:
+
 Configuration using overlays
 ----------------------------
 
-- 
2.48.1

