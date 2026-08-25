Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB6DC61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 18:11:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BACE760604;
	Tue, 25 Aug 2026 18:11:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id msWpZXkJ4QrT; Tue, 25 Aug 2026 18:11:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787681513;
	bh=dTjzCboJdfN/DtKVenuwRv/zyDgdrowyGoSuL2+3u0Q=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AFYgK6RGZhevQst7mz+ClbYq/SG7MAvAfjJnkDupxsEE6V/Pno6o/sQBaDSrUdCs1
	 xuBhm0tu2NHC69oGkCBIYKVDx7oKacOLLpyf9Hhg8i8HHb/DwJdbVrKFWvEyNS6+vf
	 j6fkz5nwuzXp0kGtgvJk5zZBD0fXJRcUYEKk1zCaCtsxbfWRFj3kCtiIhtEXlndLlC
	 l0Xj7F0nIkPJmphtu3HvCVblP90796qwogv9wIEJt1ux5MvADtDQpm0O86uMDE8QZW
	 I35BujQaO+lp21mi9kvokXZ4ZXgNnQtIQQEJsDCMsvfn0zBsDyvGosORVNnklmaZZo
	 ITqe+Lvp7ZxrQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EFE2D606E1;
	Tue, 25 Aug 2026 18:11:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BF3F4118
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 18:11:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B0EB6606E1
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 18:11:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YJQTHonst6bQ for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 18:11:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=r9KzSzFL
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 047E660604
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 18:11:48 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7e6b5737bb2so142268a34.1
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 11:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787681507; x=1788286307;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dTjzCboJdfN/DtKVenuwRv/zyDgdrowyGoSuL2+3u0Q=;
 b=r9KzSzFLT0D8OAydqPlKjH5S1BaawzIVZt3ilDniy8gKiPlzt3jwU9Sl4C808HOyuG
 B852Fs+LbFOJMFmR+p8NjPvK4+wiufvb80AFGLcZXz/bAObLxHt8bJArUjlVNnKe16n6
 O9ns8m2hYutJ0ahlClTC18UU5aZ0arEHHLLGVFIVXDEKjZimm6iJzPSmvDSjv52uoHKi
 Vqv1l9t8T3XsTtKp1J370KUVzcAktdyW7Q6Uz6/cJfOPfOGj56cL5zU+XVe1cFme6v+7
 6ecn7qVPrkULfa6+HOsJGuhpjFNEzSDPGw87D6ZiJbjuftVM58x+/EwZyTZDGV9d/5jG
 8shA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787681507; x=1788286307;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dTjzCboJdfN/DtKVenuwRv/zyDgdrowyGoSuL2+3u0Q=;
 b=tHKJR350Qznoyon+7c5lBPJ/S6SFPiGDl+qWRsn4VRltu3uE7WHiMKoIIa0l2L8PEv
 4RTCmYFsfCs4hlAMQIOfWMOMvQG0b4sOikhNt7YHOucg4HKU0CZ4ybjhhvGQswRUVHNT
 KIOxVjYrfzNpcUI2F5nMJ8uFl42bJ1m1dED5+Kg5HsRl4Iehxl6xnfQ4Fooe9sT1c4lE
 dyoSrT377Q4hd5xkKV8DT2afQrNo0GxZJdy2dV+BLnIfzcaUNMCg77iMoUV4G1bFChk5
 AVvHt25INiwpczhCTtGcu8LQeOu94ABDv01pHZcQhfeLaPuAXADE92Q4gVbSKkC9Is3G
 OBOA==
X-Gm-Message-State: AFuF++ngPnovz9SWMz/ImweYL9qEkVFFRB5AW13cicZ2zZ6esZFpnnIm
 6/01QuaxiFXO3em8kDoANai9tWBo4joRpwCW14rALhNIXqT0xr9gLJrjX2l+eiDz
X-Gm-Gg: AR+sD11h7n3vNpcVnIluplfusoxk7hxVjIxyqJ/6j0DTuGmkJPr0sWBdeFoHEzxS3tk
 5V2hudYdv2p0FVTek7T5o+xxrxHMW82FncjyTMr0SpdyUXE8HKoCKFTQO86oDwRoZp4kXMsH2uV
 h9o/6NdV7MiDq8B247sxL5BwB7F5vNEw8XR5h1383NkudlrgMIQCz2LvIZROqpVlzXUP25lyyIT
 9RML7oEbEWa4FIpyIGGGoNMG+O51Qc2bwGUI1epvw3tYPJcmO/XnsI/ELV/hZTUbdyLHJ6cn5nj
 CfVq9DLRghsyyeChQAgtL1lqM1s0Ehwz3n55rTOLSWkPQe7VPepClHeh3jB9wy1iHzfjedpLzQR
 Cof7UIKLNQxE3jr0iw1ju9dbPGLJf8yhLaf4j7KJjhbECnZOIdmbB6zBBF6sChOQ0m2yBHFBQgc
 Qk6uQ5XOTIlcEdr0JAvff0X46OznAKiuA/1B373fojuSCzNkCBix8iXqLDjK0AuooHqa47fDk4Y
 4GcLqNYjR2k6wjmT0Tiar6s8C0fm2QRmtEOiyACR8UxV2X/jEbnG+VMfqhwOXzNThlYsf98Lh8E
 +BJ2rjixUd4MbN9Bng/4W8vc0YkGC9PjPHvPD4Ji82DLs/x1krBYDUOBukWd/wNiQXXjyNUaYlo
 SkMpSdYxr8tqJUQ==
X-Received: by 2002:a05:6830:7316:b0:7e9:d3aa:e391 with SMTP id
 46e09a7af769-7f4c4c8368cmr654261a34.6.1787681507471; 
 Tue, 25 Aug 2026 11:11:47 -0700 (PDT)
Received: from [127.0.1.1] (71-218-10-81.hlrn.qwest.net. [71.218.10.81])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f4c426cb7csm216916a34.11.2026.08.25.11.11.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 11:11:47 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 25 Aug 2026 12:11:38 -0600
Subject: [PATCH] cmd: ethsw: support lwIP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-submit-lwip-ethsw-v1-v1-1-fbe6142e5d92@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMyw7CIBBFf6WZtRMpvlp/xbgAHGWMRcLQ1qTpv
 wu6PDf3nAWEEpPAuVkg0cTC71Cg3TTgvAkPQr4VBq30UXX6gDLagTO+Zo5I2cuMU4v21CutO72
 jfg9FjYnu/PllL9c/F+9JLtdWfVgjhDaZ4Hydxig5kRm2g+EA6/oFQ7W3n5gAAAA=
X-Change-ID: 20260825-submit-lwip-ethsw-v1-b79022823e94
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>
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

The ethsw command controls Ethernet switch drivers through the switch
API and does not use the network protocol stack. Its Kconfig entry is
inside the NET_LEGACY block, preventing the command from being enabled
with lwIP.

Move CMD_ETHSW outside the legacy-only block.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 cmd/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index ff90a87024c..2867e65f605 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2195,14 +2195,6 @@ config IPV6_ROUTER_DISCOVERY
 	  Will automatically perform router solicitation on first IPv6
 	  network operation
 
-config CMD_ETHSW
-	bool "ethsw"
-	help
-	  Allow control of L2 Ethernet switch commands. These are supported
-	  by the vsc9953 Ethernet driver at present. Sub-commands allow
-	  operations such as enabling / disabling a port and
-	  viewing/maintaining the filtering database (FDB)
-
 config CMD_WOL
 	bool "wol"
 	help
@@ -2223,6 +2215,14 @@ config CMD_DNS
 	help
 	  Lookup the IP of a hostname
 
+config CMD_ETHSW
+	bool "ethsw"
+	help
+	  Allow control of L2 Ethernet switch commands. These are supported
+	  by the vsc9953 Ethernet driver at present. Sub-commands allow
+	  operations such as enabling / disabling a port and
+	  viewing/maintaining the filtering database (FDB)
+
 config CMD_MII
 	bool "mii"
 	imply CMD_MDIO

---
base-commit: 964ad5b5c91b7be56e443e899d7f873e6aa8c9fc
change-id: 20260825-submit-lwip-ethsw-v1-b79022823e94

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

