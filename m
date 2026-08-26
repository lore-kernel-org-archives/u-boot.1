Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B43BC61DC4
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 16:35:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D889A80AAB;
	Wed, 26 Aug 2026 16:35:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P9WMqRgkvuAh; Wed, 26 Aug 2026 16:35:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787762110;
	bh=EV1/Zq+xrw1G9SlaRud6zqkIm1KzWDQewvB08SU/Rz4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SdSQC9tuO6Lj8Lbvk9+FG6DoeoYcRRP/kb4HPBMdqpkhYmHKknMk7s83NpGRaGxbh
	 kl3UTPXIUWVkZt58xlaMUG1V9G2iF+H+xewwuaPQ4UvLEwB9VE5tdsaWJyySp+Fjlo
	 xtioumbkBtFs2nLtejLdqu8gWxnasQDf37kzNQr/YN2BFsHrX7ctpci1aTbc+MpoiF
	 +9ag1BppXQJ4USuQkyDyq6kHaYyS1niDy4RYSajoads+Jyh6fi3fEVSsWOWYaEL8oj
	 e4soZSK7r0HCDcf0A2hs100SYDWOBQEGjmR1SLqmF67ic/NanMQR7TuQt1g4fevAPV
	 RQo+vFACGPhQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC80A80AEA;
	Wed, 26 Aug 2026 16:35:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0A98C323
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:35:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 084FB6075D
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:35:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rViTgX2MBWEJ for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 16:35:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=zynInnK5
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B40236073D
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:35:05 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c15e2dab83eso180835366b.1
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 09:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787762104; x=1788366904;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EV1/Zq+xrw1G9SlaRud6zqkIm1KzWDQewvB08SU/Rz4=;
 b=zynInnK5WAhM2CdTeRyyA9uYB8PBXQdE5z8RQouEF5nTZglfQR69Xc2xNPalePH9vl
 YDZtjseZgRQOhUsW5ILGbCsw40ur0o6npEzg1ud6/u/vSNVA9sqFryVJCocS6sBX+m5m
 bgPLvdELb2RBca46oCdx8jYwWcMiDwBCAfV+RddtMRHpWjkqXHmkZKT4VnQAGLgPMMek
 074UMFT/UJl2T3A28xyjhX7H0PUS8eery//qwvBJNKXDxqdEu6W5ER42jQYr/hayGE+Y
 2kYyoOUdKSkLXwQGb2/UCrJ+zVHdmSq+IhTcxqr9JSTKxRSI8bw4ino9qJDL+7Qeyfwg
 ydhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762104; x=1788366904;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EV1/Zq+xrw1G9SlaRud6zqkIm1KzWDQewvB08SU/Rz4=;
 b=kz3ueQ/BOaORgELcTSPULQHoerVtWMEtBxg9EUlp8dyE4ZwR8eJZ6cFG8aJiWuWgWr
 NBHvRKef/4LlKrwnb/4fgpAVhmSgTot2Znqd/qTZNJ9Yz22XbnMbJr2u5SdkzlXzUnLj
 dGO9UPNX/99ySAPIBqrK7dBFoK+p3gKkTyQ/zTupUZxwbL7XoZGTYwqRf+RqOAcr3eWh
 RHZ+uAL//RTT48U8NR+srPnmqGDujQJ1/JswkhTDLAuvngGqayDhD3OR3mkw+bWBAM71
 +jRp4M/y2M8CPONqRVZJUtRgTUJXLSMSREd0wVN+vemWdiz6CElYfJNvFFNZ8JKl2UIe
 tK7A==
X-Gm-Message-State: AFuF++mfYhdAazNF/oisb5wcLxdIHZ2Xay/DAHl4OJsgf9dnwFKX7Gi+
 taHLnyDeClPSInBjLqF+Y4e2r3ImZj/y4lFRISytZu4OdDU9wF2Snwq6iS+Dzj3rM7I=
X-Gm-Gg: AR+sD12vmu1F8vqqUaPWjyAAEgn7WMe1KOuQJE/wvdPUEmNBNVXX63k0koY+gIGRASL
 nVsbG1diiDypWdGi8yJMvT9d01DSi+lyO0lVxzzFzJiwyPncvVCFAtd7CC8IQtBj5CEFI2YOWzT
 nUXEnfgSyx43Pa9RyK4BmqXLI+Rwr410PwYltON14XHy0xDA2o/QsBbLgXLkHBCbvzKuRjIdxnn
 eNa3jWGQqat3sGuiU0RGMDDGQNJ9JmJbuuikXw26mUrLajiOvejaeQc36of8E77x0Zt7yGaLTbO
 4zodVK1KxiF1ZtH/DcrZD2TLbrsld2OWAslTmxdgLoY2wrGcdRWqdOoahz/MyM2TsVh6a4UWHue
 DM8AnRy9e8QGZoWhWZHeRuSTnAHc1dPdC1lEWqqQTrR+YiyH5d02udyx6C/l9fRe8B8JRjMpues
 BPwofrg1J59SHcJrfJwzuXTKUabG3Jhh+7xhPydtTAcWKyPiNZOGnC68y3METCwl/tXGDRFgPFy
 kJA8SdKU33ARjiDBRi7vHeCgbI0/CnaqwHpuwK+Jg==
X-Received: by 2002:a17:907:80b:b0:c20:9447:bd6d with SMTP id
 a640c23a62f3a-c250c363b01mr1089203366b.11.1787762103538; 
 Wed, 26 Aug 2026 09:35:03 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-94.alshamil.net.ae.
 [86.98.192.94]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a704e55sm544907666b.21.2026.08.26.09.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:35:03 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 26 Aug 2026 20:34:05 +0400
Subject: [PATCH v2 13/13] doc: bootstd: describe the BLS bootmeth
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-bls-v2-13-17df3c9548ba@flipper.net>
References: <20260826-bls-v2-0-17df3c9548ba@flipper.net>
In-Reply-To: <20260826-bls-v2-0-17df3c9548ba@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Alexey Charkov <alchark@flipper.net>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>, 
 Johan Jonker <jbx6244@gmail.com>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>, Denis Mukhin <dmukhin@ford.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4566; i=alchark@flipper.net;
 h=from:subject:message-id; bh=H/qzI56AoaW6U0kXDS5vvQa8NG7RQ2ns618cLTvYhC8=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWT1i/ZlvVUL27pPe7IaN1/M6s9cn1en31i/6k7ss+ctO
 S6rHuw83zGRhUGMi8FSTJFl7rcltlON+Gbt8vD4CjOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GRrpGOsYMXBxCsBUbzrO8D/1XNYqU7lXS2Ytey9xYVLXm0qOvzdvbpb6Ye1q/yV93ek3jAzXTs5
 gcT5yW+O2th7ruTl96uwzzFa3PTn75V5NquF88Us8AA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

Every other bootmeth has a page under doc/develop/bootstd/; add one for
BLS and list it in the index and in the overview's table of drivers.

Besides what the bootmeth does, record the two things a reader is most
likely to trip over: how paths inside an entry are resolved when $BOOT is
a directory rather than a partition, and which parts of the spec's entry
ordering and boot counting are not implemented yet.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 doc/develop/bootstd/bls.rst      | 56 ++++++++++++++++++++++++++++++++++++++++
 doc/develop/bootstd/index.rst    |  1 +
 doc/develop/bootstd/overview.rst |  1 +
 3 files changed, 58 insertions(+)

diff --git a/doc/develop/bootstd/bls.rst b/doc/develop/bootstd/bls.rst
new file mode 100644
index 000000000000..52e691b70165
--- /dev/null
+++ b/doc/develop/bootstd/bls.rst
@@ -0,0 +1,56 @@
+.. SPDX-License-Identifier: GPL-2.0+:
+
+BLS Bootmeth
+============
+
+The `Boot Loader Specification
+<https://uapi-group.org/specifications/specs/boot_loader_specification>`_ (BLS)
+describes a drop-in directory of boot entries, so that a distribution can add
+and remove kernels without rewriting a central configuration file. Type #1
+entries are plain text files, one per bootable kernel; this bootmeth implements
+those. Type #2 entries are EFI binaries and are out of scope here, since the
+EFI bootmeth already covers them.
+
+Entries live in ``<prefix>loader/entries/*.conf``, where ``<prefix>`` comes from
+the bootstd list of prefixes (``{"/", "/boot/"}`` by default, settable with the
+`filename-prefixes` property on the bootstd device). systemd's
+``kernel-install`` writes them in this layout when ``loader=bls``.
+
+The format is close enough to `extlinux.conf` that U-Boot reuses the same
+parser. Two extra keywords are recognised for it: ``title`` (the human-readable
+entry name, equivalent to extlinux's ``menu label``) and ``options`` (the kernel
+command line, equivalent to ``append``). Some spec-envisaged keys such as
+``version``, ``machine-id``, ``sort-key`` and ``architecture`` are not yet
+implemented and are skipped.
+
+Paths inside an entry are used as written: the spec has them "always relative
+to the root directory of the partition they are referenced from", which is
+what the bootmeth sees whichever prefix the entry itself was found under.
+systemd's ``90-loaderentry.install`` agrees, since it strips the mount point
+from the entry directory and so keeps the ``/boot`` component when $BOOT is
+not a mount point of its own.
+
+Entry selection
+---------------
+
+Only the highest-sorting entry on a partition is returned, because the bootstd
+framework currently allows one bootflow per (bootmeth, partition) pair.
+
+Ordering is by filename alone, which suits the common case of distros encoding
+the kernel version into the filename. The spec envisages more than this, none
+of which is implemented yet:
+
+* entries should be ordered by ``sort-key`` first and ``version`` second,
+  falling back to the filename only when those tie;
+
+* an entry may carry a boot counter as a ``+TRIES_LEFT[-TRIES_DONE]`` suffix on
+  its filename, to be decremented on each attempt and skipped once it reaches
+  zero. For now that suffix is left intact in the entry name and otherwise
+  ignored.
+
+When the bootflow is booted, the bootmeth re-parses the entry it read during
+the scan and hands the resulting label to ``label_boot()``, the same code path
+extlinux uses.
+
+The compatible string "u-boot,bls" is used for the driver. It is present if
+``CONFIG_BOOTMETH_BLS`` is enabled.
diff --git a/doc/develop/bootstd/index.rst b/doc/develop/bootstd/index.rst
index ec74fc2fb9d7..9271b5eef14e 100644
--- a/doc/develop/bootstd/index.rst
+++ b/doc/develop/bootstd/index.rst
@@ -9,6 +9,7 @@ Standard Boot
    overview
    extlinux
    pxelinux
+   bls
    qfw
    android
    cros
diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
index ec9fafa0fa05..eb0f68d9bb87 100644
--- a/doc/develop/bootstd/overview.rst
+++ b/doc/develop/bootstd/overview.rst
@@ -445,6 +445,7 @@ Available bootmeth drivers
 Bootmeth drivers are provided for booting from various media:
 
    - :doc:`Android <android>` bootflow (boot image v4)
+   - :doc:`BLS <bls>`: Boot Loader Specification type #1 entries from a disk
    - :doc:`ChromiumOS <cros>` ChromiumOS boot from a disk
    - EFI boot using bootefi from disk
    - EFI boot using boot manager

-- 
2.54.0

