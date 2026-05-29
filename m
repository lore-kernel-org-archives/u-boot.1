Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 972D3CD6E49
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 20:17:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2749B846FD;
	Fri, 29 May 2026 22:17:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="QxEQcplM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA3AA846A5; Fri, 29 May 2026 21:46:34 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB03A805D7
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 21:46:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rv@rasmusvillemoes.dk
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-68c1653ea0cso1482421a12.2
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 12:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; s=google; t=1780083992; x=1780688792; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gRcRacvET9u4v56wSl1NYOyNsq6dQo3uzXXZV8ypDBo=;
 b=QxEQcplMb4iA1eXLTf/cTI2VzCDjg7dqeXi3nAcqZgzvF79jqO+7K3QqjDT4tqhU/J
 7ZOZH2SEBzRKCSt2I7AZJbehMhyJK6JiDeWui4njzlzogm2TlH18gJ/r6oyHHHE2hpW1
 8GLMNi8pcZZYR/h4Ay2i1LJKzp52MxsbsTc6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780083992; x=1780688792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gRcRacvET9u4v56wSl1NYOyNsq6dQo3uzXXZV8ypDBo=;
 b=c7UzC4F3HiqjJ3uespS0MkUtMChe6s3Azu0bdNsb9XsJQ0pTZBeV1AExaSeUrL8+Fd
 ZNGrKU0Pj0jsLmNbuEaTsHaBctKDkn4/p5ksCPhatMLEzyRAvZ8h1CmS2flMjaVZ7HQI
 kzgibyp97sAFT3au4KKX39CeMBCoXvlmfvojyDo8gs8Kf8eP5mesQVHkFVlNg3ktHnn3
 5y02cC9aRmuSrXhrGgUT109UtVgH1B2PKX5liJw+ogoOBeVEuIWncpDoZa5vzJZvFZAR
 S2aYyK5TQa7QoHc1gz+BCRWwxOFzAT96P5xfeG/TBWDvQ1cTggDSBcZxwP708YS1va+N
 CeVg==
X-Gm-Message-State: AOJu0YzOfkKyB9U1OHkBzhhssboptFhxM5IfhIpb74fuUihvSoCy1sZp
 jtjJW72Uyzn8ZxbZxWmaJ69qRGl5V2wtAdA3DijugIOJLxRKHJfczn8yOV76ZQidmqt9b7527Hz
 RycPso38=
X-Gm-Gg: Acq92OFxfSDnWxzbcUx9SEZc4XkAprC53WCDvkK1xsfu/cv9aQKNLHBwCokzYJswYhn
 8kO4CXDrLPnjoB4dGG2zc1jU4xK+JjyWuhOVJReduX655ClsxjdHnWzlvQ0YhW9GCcHh0DFB7kp
 RsCTGdPNJkOpo4rEd9HD2ZMH4O62AHpWfEviRJD3HqHx51BjDd696KDhDwlVE2QE4OuwutS3gUt
 QlhOBvHPj8i1aeOUWWgInx0fcUfcVs2V+KvqUC79jKcjmFne0kTFJtparwJVw05h8Yy1pSOupXW
 opw6JghWOCpVD3Ad3LvixjCLCXgldj0aH9AOEqD42nHBw8ISbiNZRkCAZF3JMc9PcztS0PeEYrG
 8vyyCKKKtdAD066/s9bkcSk5oPbT9+7JJkBBe/1IaP1Vkz13M95SY6hXOlduQzp6J8sbCdtxZ4Z
 zOIzO0tazY90UZbYWaYX3iY+gRKOm53KkDZiO7PwRvotywWMqvROhqsf8aEx+nV2nv
X-Received: by 2002:a17:907:3c82:b0:bce:a1fc:6877 with SMTP id
 a640c23a62f3a-beab1b935bfmr56701966b.24.1780083991653; 
 Fri, 29 May 2026 12:46:31 -0700 (PDT)
Received: from localhost (77.33.185.121.dhcp.fibianet.dk. [77.33.185.121])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-be9d31dadb8sm95175066b.20.2026.05.29.12.46.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 12:46:30 -0700 (PDT)
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH v3 2/3] doc: develop: add section on embedding scripts inside
 control DTB
Date: Fri, 29 May 2026 21:46:20 +0200
Message-ID: <20260529194621.1470583-3-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529194621.1470583-1-rv@rasmusvillemoes.dk>
References: <20260529194621.1470583-1-rv@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 29 May 2026 22:17:03 +0200
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

Add a section that explains how one can embed scripts in the control
DTB and run them from the U-Boot shell, the advantages of doing that
compared to using a separately built FIT image, and the configuration
knob that must be turned on to allow this to work.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 doc/develop/devicetree/control.rst | 58 ++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
index 634114af59a..7d6117d5c4b 100644
--- a/doc/develop/devicetree/control.rst
+++ b/doc/develop/devicetree/control.rst
@@ -232,6 +232,64 @@ outside the U-Boot repository. You can use `DEVICE_TREE_INCLUDES` Kconfig
 option to specify a list of .dtsi files that will also be included when
 building .dtb files.
 
+Scripts embedded in control DTB
+-------------------------------
+
+The `DEVICE_TREE_INCLUDES` option can also be used to make the control
+DTB serve double duty as a FIT image. By including a `scripts.dtsi`
+file containing something like::
+
+  / {
+	images {
+		default = "boot";
+		boot {
+			description = "Bootscript";
+			data = /incbin/("boot.sh");
+			type = "script";
+			compression = "none";
+		};
+		factory-reset {
+			description = "Script for performing factory reset";
+			data = /incbin/("factory-reset.sh");
+			type = "script";
+			compression = "none";
+		};
+	};
+  };
+
+one can call those scripts using the `source` command in the U-Boot shell::
+
+  source ${fdtcontroladdr}:boot
+
+or just ``source ${fdtcontroladdr}`` for invoking the default.
+
+Since one does not need to separately build a "real" FIT image
+containing those scripts, this simplifies both the build process and
+the boot logic, as the latter does not need to first load the FIT
+image from storage.
+
+Another advantage is that when the bootloader and boot script must be
+updated together, it is easier to achieve a guaranteed atomic update
+when the boot script is embedded inside the U-Boot binary, instead of
+stored separately.
+
+For the above to work, one must enable the `CONTROL_DTB_AS_FIT` config
+option, which will (when the address passed to the `source` command is
+the address of U-Boot's control DTB) elide certain sanity checks that
+are normally done: With the above `.dtsi` snippet, the control DTB
+does not quite become a "real" FIT image - it lacks `timestamp` and
+`description` properties, but more importantly, FIT images cannot
+contain nodes with `@` in their names (unit addresses) anywhere, and
+the control DTB obviously does have such nodes.
+
+This is not a security problem, as the control DTB is necessarily
+trusted. In any secure boot setup where the bootloader is verified,
+that mechanism must also include verification of the control DTB. So
+in fact, since the scripts embedded this way are then also
+automatically verified, it simplifies implementation of secure
+boot. When using a separate FIT image, one must build it with
+appropriate signatures, just as when building a FIT image containing a
+kernel/dtb/initramfs.
 
 Devicetree bindings schema checks
 ---------------------------------
-- 
2.54.0

