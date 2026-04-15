Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B90F428C0
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 18:33:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8A29841B9;
	Wed, 15 Apr 2026 20:33:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="PC80duZT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DC018419C; Wed, 15 Apr 2026 20:33:07 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2BAE8407D
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 20:33:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso84656885e9.3
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 11:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1776277984; x=1776882784;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7DKsi4pzYyQDOTb8zo06i67V2qb9y1zARBTwXnfbWaQ=;
 b=PC80duZTZ8s5fQfkGgNJ/8RNXWOmVM3bPWVpGkwMaWWRYT/ITFuCPTS7o8HcY37z4s
 iEnt3ZOwR44OEQCJFN3OE66xfnONECvI/3pcIyufytyLgOlpljyyZCnkWR3TYU/S5+L9
 3EEroPHYTRW+29AsOumGvprLHJizqP95MGzRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776277984; x=1776882784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7DKsi4pzYyQDOTb8zo06i67V2qb9y1zARBTwXnfbWaQ=;
 b=s11sO+8BcF1I9635lbWPK1gpJwet++D96jO1HiPeWHOwnrQrdfIfB0W9nLYrATWSB5
 PKsdKXNAhz43nYrhHGjfJZsdIOCcuKruYwKlsJkDIy4KjNfSiV2wnoDKb2ZcuXf3noqT
 5F2vexPO6ascG1Hvx6b8zOeuqO2RTMTR7ZdnNBLcDZ44GuVg/fa/UccE8BQhtbpR+jwW
 GmfUzWC0UgSgtLVHYZ/RkrLwuy9+MqwPuudwQycsbC9ikmih7BHMQJmxXwbiSibnFC11
 4skeZ4M8KEqbhV6AEDrvs8tNxdQlUljFf+cGFb5Dnr9i4/7duQItwFewAqxJWzQ/EV1M
 S05g==
X-Gm-Message-State: AOJu0YxzV/QtZ6AOm5X+n/sukuZDns03JC78sclPYmw3hGv8t4x02+6A
 trCPzMtG/jbaStTd3FtWfwsEKzEqsEaj92k5gmBu28m2c3jBlKGDWukxlJVMMzPRUegQzBaOaJt
 enRXY
X-Gm-Gg: AeBDietiFzCQKQHQDmEpRNlne+mz6R/cVhjBsJ1P8yAfABl7w/YUmCgUHcmPncUV+DQ
 lAEKDRUZFKapqNspf+gVlkY81ZN3Y7GkXvhxENdkxU9DydpPs5REynZGMyQQIfQ9eKP/8/N8S/T
 UTW7Si5821nKOB21sfTFmCjniKN2cn+qC/O72jfwfqqhyNecotW5pydTXQ7Maw8opwp20Y1c4c2
 ctLeSYLMsyWDP/9VNpTkgsAPz+xkSQxyzOkXM2HFkkcWSor/W4+7EZzifXlL/p+HrcoZIYkSFOM
 7ujuNSVWeVTo+mMg5jz/UesvbNtf2dayiy3fr7n8WGeZzU501+8G6Rx2K572qFHixPvY4LUNiJH
 czDNqwuNPn/Gw8h1hdIGDr2iXu4M88DbuCMu9+JgopQJbnMKXM7ZRomdw6Wc4Dr1BhXukc6Z2+r
 Se9/Hl/Bq2f4AkKCgVV32RW7V6WnMfLl/VqT2sA6QIWR3yR4rUYzwieHnJS5j6vMNYhzlMIUSwi
 zCd5sjzzkGkcuygwFgKdY+qLGSPvg0EEYlrw7pXqNgnpgD0mttZX3PTAQ==
X-Received: by 2002:a05:600c:5298:b0:488:c014:34da with SMTP id
 5b1f17b1804b1-488d688687cmr325853095e9.26.1776277983903; 
 Wed, 15 Apr 2026 11:33:03 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com ([2.196.40.93])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f0e72980sm34953115e9.5.2026.04.15.11.33.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 11:33:02 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v3 1/7] lib: uuid: add partition type GUID for extended
 bootloader
Date: Wed, 15 Apr 2026 20:31:28 +0200
Message-ID: <20260415183250.3031030-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415183250.3031030-1-dario.binacchi@amarulasolutions.com>
References: <20260415183250.3031030-1-dario.binacchi@amarulasolutions.com>
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

