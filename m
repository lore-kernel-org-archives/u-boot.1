Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0348DFF885E
	for <u-boot@archiver.kernel.org>; Sun, 26 Apr 2026 15:47:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34FFA841D7;
	Sun, 26 Apr 2026 17:47:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Gl7f756j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C6408412A; Sun, 26 Apr 2026 17:47:33 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2613083FF5
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 17:47:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so117367405e9.2
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 08:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1777218450; x=1777823250;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7DKsi4pzYyQDOTb8zo06i67V2qb9y1zARBTwXnfbWaQ=;
 b=Gl7f756jtU15ody1bJbVaso61GD//6sK8v9zHP/7h5T7ovwJkVoq3wjECXFhpZxWgT
 ncmyFN+Cn9zToWZibXOiNtSv6fPTXkqn0rCjdQvCM076fLkPJQMmHmPO3KgpskHnvoYq
 1ju2hj3g3EUl2EkVHecsN3zw7xJDsP3s+KCck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777218450; x=1777823250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7DKsi4pzYyQDOTb8zo06i67V2qb9y1zARBTwXnfbWaQ=;
 b=j8hPdh/BYxsKrfDfA+P3xhVS3bHJPpospXjDSffCvIHE8VbyvAF1YNgVsDSWgUV/BJ
 uGWVhAkpu0phTGk+T6JbXruuC40es9795Nsd9n1cn2uJXzep9R8Xo2WllGTAHR02ti5p
 naVNK4VUD5afEvuhQbr4zmPQy5c8TwNemKTTjHxXefQE70rj2YvWAaWSplkIOhp09n5C
 YGxJlDsV7h7hhoi0/dyB36Lt1E38KT9cHKzg2pFHTbMU4v03mLcLz34Wg5HvU8l4XQeD
 XMgi0weG/0tszfouZjrG5PGBbfykO52W+UlRtqkC4jozlnXfCJTyV4LDN8MY4TJ1YtV4
 ObeQ==
X-Gm-Message-State: AOJu0YxZ0RcJTRQgX3d8sw7PFP6+QqxzQGFQ2+t5Zu3/f701PJWJK0hZ
 nMXPcDrpYcWL4uRObInI8F5asRBq+27wG3bkgegOaLilZCGYfUpQNlKFS7n4bBBg62njHcb41Zm
 1ozlL
X-Gm-Gg: AeBDieulBxK/IHk9ogt1lWHDULLW5amgU72DjCO0E8pSCeW9G4NILbKfEq9TQbvw5YW
 o1qJnE5pbAt9FCqLv1ydaFZ2htWrs8jF3d3mJ2e68pQiQlM1d/f180qazfPLHgndk2Sd2FXGD23
 KsWfphnxWKNusHObK97SQ7m+/CXvtvVAEf7NpG/EtnOOng96dDEqafOKBMfiWTL2A3faQrWm5Wg
 TDA+BsU1+/fzctASysuG8FIZzVbLeKDewp76Dm9U3y1I9snHVBix53qtfYMpxyp3FaSnRiHfX1U
 pA90V6xWuJ8zALdoEGwhpqqzKOut+ArM3TjLHbFDw4g2C2r22CxwLeicIG6jPU5GIRLFjnhB3xb
 tYjZDrokX1mhwnDSn4ZWd2vOwhf6ScypUUWHJ5fpD/PO8jwXXu8tbj9c0BmFSWJtJG+a4ribj5T
 W5LaWlh2KOZGYrovFKpPCbAhE/ZTKtq+Bg76FoOYGBaIatbL+veRKev/zO+0bpJeUth6K+3MeC6
 fxjTF5D9OlXmQpahjUzu6+mr2z0BBED5BA8gDyPC8HcYrB/Pq1iJK7Mx3dHNxSDd+NXJDm/9Rob
 IRUNUXM3eQONz3p28XZxRkAKIzsOBg==
X-Received: by 2002:a05:600c:6297:b0:486:d76c:fa57 with SMTP id
 5b1f17b1804b1-488fb77155dmr526199295e9.17.1777218450344; 
 Sun, 26 Apr 2026 08:47:30 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com
 (host-82-56-22-134.retail.telecomitalia.it. [82.56.22.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44123d23e0bsm34489985f8f.15.2026.04.26.08.47.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 08:47:29 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v7 1/8] lib: uuid: add partition type GUID for extended
 bootloader
Date: Sun, 26 Apr 2026 17:46:54 +0200
Message-ID: <20260426154724.2042569-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426154724.2042569-1-dario.binacchi@amarulasolutions.com>
References: <20260426154724.2042569-1-dario.binacchi@amarulasolutions.com>
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

The Extended Boot Loader Partition (XBOOTLDR) is a standard defined by
the Discoverable Partitions Specification (DPS) to host boot loader
resources outside of the EFI System Partition ([1], [2]).

Defining this GUID (bc13c2ff-59e6-4262-a352-b275fd6f7172) allows U-Boot
to correctly identify and label these partitions using the "xbootldr"
shorthand.

[1] https://uapi-group.org/specifications/specs/discoverable_partitions_specification/#extended-boot-loader-partition:~:text=UEFI%20Specification.-,Extended%20Boot%20Loader%20Partition,-bc13c2ff%2D59e6%2D4262
[2] https://uapi-group.org/specifications/specs/boot_loader_specification/
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Simon Glass <sjg@chromium.org>

---

(no changes since v2)

Changes in v2:
- Add links to the XBOOTLDR specification in the commit message
- Add Reviewed-by tag of Simon Glass

 doc/README.gpt     | 2 ++
 include/part_efi.h | 3 +++
 lib/uuid.c         | 1 +
 3 files changed, 6 insertions(+)

diff --git a/doc/README.gpt b/doc/README.gpt
index 386ac2e0fc8f..a6e1fd7ce8d4 100644
--- a/doc/README.gpt
+++ b/doc/README.gpt
@@ -286,6 +286,8 @@ Some strings can be also used at the place of known GUID :
 	                    (E6D6D379-F507-44C2-A23C-238F2A3DF928)
 	"u-boot-env"      = PARTITION_U_BOOT_ENVIRONMENT
 	                    (3DE21764-95BD-54BD-A5C3-4ABE786F38A8)
+	"xbootldr"        = PARTITION_XBOOTLDR
+	                    (BC13C2FF-59E6-4262-A352-B275FD6F7172)
 
     "uuid_disk=...;name=u-boot,size=60MiB,uuid=...;
 	name=kernel,size=60MiB,uuid=...,type=linux;"
diff --git a/include/part_efi.h b/include/part_efi.h
index 2cea50880465..5713b3018f42 100644
--- a/include/part_efi.h
+++ b/include/part_efi.h
@@ -60,6 +60,9 @@
 #define PARTITION_U_BOOT_ENVIRONMENT \
 	EFI_GUID( 0x3de21764, 0x95bd, 0x54bd, \
 		0xa5, 0xc3, 0x4a, 0xbe, 0x78, 0x6f, 0x38, 0xa8)
+#define PARTITION_XBOOTLDR \
+	EFI_GUID( 0xbc13c2ff, 0x59e6, 0x4262, \
+		0xa3, 0x52, 0xb2, 0x75, 0xfd, 0x6f, 0x71, 0x72)
 
 /* Special ChromiumOS things */
 #define PARTITION_CROS_KERNEL \
diff --git a/lib/uuid.c b/lib/uuid.c
index 3a666d0430db..d7c164ea06bf 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -86,6 +86,7 @@ static const struct {
 	{"swap",	NULL,	PARTITION_LINUX_SWAP_GUID},
 	{"lvm",		NULL,	PARTITION_LINUX_LVM_GUID},
 	{"u-boot-env",	NULL,	PARTITION_U_BOOT_ENVIRONMENT},
+	{"xbootldr",	NULL,	PARTITION_XBOOTLDR},
 	{"cros-kern",	NULL,	PARTITION_CROS_KERNEL},
 	{"cros-root",	NULL,	PARTITION_CROS_ROOT},
 	{"cros-fw",	NULL,	PARTITION_CROS_FIRMWARE},
-- 
2.43.0

