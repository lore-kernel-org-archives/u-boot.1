Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5045FF885D
	for <u-boot@archiver.kernel.org>; Sun, 26 Apr 2026 15:41:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 556DA842F2;
	Sun, 26 Apr 2026 17:41:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="FFiuYZXC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACC8684307; Sun, 26 Apr 2026 17:41:07 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6DA880087
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 17:41:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488ad135063so85817675e9.0
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 08:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1777218065; x=1777822865;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xRUth/tej3+7h0oPp5SVnZPyDPN+il6XelJ/U9ZGoW4=;
 b=FFiuYZXCX5LgSLYzLbZNHsCaU3pSaQTZOCXpDX979CHoI9NVRcnqee3OfUzYAu6eQ0
 5MjHq74nP395dBBn1/8Aew3rj1kyHhVIEbvOMJF6a+yFUBOO+jFbvuGF3+ZyHLVefpTu
 Qekgjb+X/QtjWiTTsIkaYYwK3iMIpxKmcrFBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777218065; x=1777822865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xRUth/tej3+7h0oPp5SVnZPyDPN+il6XelJ/U9ZGoW4=;
 b=ZEX6k41zUMj4S6GDoPgHTRCMf42foZdjwcqwRfNG8NxlC7wyFeNHb0LIL2eF9Mq5NP
 2lBntRz0bYz1Mllg5tfN8PQ3HKH7EtkoPW0oO4CocNDJY+Rn6dIdHjA3HrKezHdxmVkA
 L5vS7rxuZnioZo2v4TZ1S12uy2Xdg1IGdfR/vxw2Ood26U/oGMwPkvBdxmdjvCRlZZtg
 IvlP8zc9ICd5bunsBtR8IaHCyIUNHmkKY4LgVGueMfcwOxiX25dxs8Fmxse9ptSsOCH0
 gl3FgOxWM9tIGdrW3IKCNeVAX6+d5pFhKCpKTFWp257ZcCnPJvHA2dyjF9RkYvAKP1vp
 A37Q==
X-Gm-Message-State: AOJu0YxO9DJwLLwQhbQgAW5fqF+ablYt6XG0K2t23Zlbl19ifemZtEeB
 Nu35EnRILA7l8TszcRyS38yRz84oNxVcjRL74ElR7uoWoHJgw6RJCBVScdbDjYjfIUP2x/bQll+
 Q5/N/
X-Gm-Gg: AeBDievZ786Yhd2TKlNxsZRM8QJm13CMV1lZdSvGUwFSSkx8F+yw1twv2ABio/PCApt
 x85bHxluNNms13aLbcfvy5vGxmTa9IQqxST1trdZUR9ZXFlorAfM4XRi9mbJf+20Xt5Oykz5TyW
 fxoO/FD5XG4U9GGnVDZ8tAAVVllvhoMQsktuIyi6lRbcfe+9VebQ4P9Qe7a3JvyAmxrlxCvLeLP
 6Jwk+El1hHYQnNb5LlqDtGODvkbvlSrQPmHoVaDK6DkmqRJXKFm1mH4mIfifUs4yvYHKm3QZQFf
 JYnI7NdysJDjbYIPtJzqK7dhSEmnPSjoTmMWXjGA+92DYkr7HtO9OAFSlTub9fbH5I6DNUf/ozN
 U3kWo9zbBlhGOdfPDjqd2EGGGH4xHVroowAPLK1sA6U8VNp3fmxlIQRiS5PfEdcgFKlSRDf/yej
 WZSXWxMYXX06Ci4mZvziJJoK7Ttt4fqq9Y789E1nEykOZbSscMXLkqpkkz5ahsGESglE1FXcS05
 QO/ox1rYB5q0cnyCk8YN1B2fEJOm5kym73tUV3Jhgi5tH3Nrt+KpzMJEGHNKXyR+7+Ek5dDZbFO
 CNPq62H6UWEshcHV5+WNMPAwEuObmw==
X-Received: by 2002:a05:600c:45d3:b0:48a:5821:5ffc with SMTP id
 5b1f17b1804b1-48a58216a4bmr327190065e9.2.1777218064846; 
 Sun, 26 Apr 2026 08:41:04 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com
 (host-82-56-22-134.retail.telecomitalia.it. [82.56.22.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891bb3d121sm802593765e9.14.2026.04.26.08.41.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 08:41:04 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, John Toomey <john.toomey@amd.com>,
 Jonathan GUILLOT <jonathan@joggee.fr>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 4/8] cmd: part: support lookup by UUID
Date: Sun, 26 Apr 2026 17:40:36 +0200
Message-ID: <20260426154054.2040932-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426154054.2040932-1-dario.binacchi@amarulasolutions.com>
References: <20260426154054.2040932-1-dario.binacchi@amarulasolutions.com>
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

The 'part' command currently allows looking up a partition only by its
number or name.

Extend the 'number', 'start', and 'size' subcommands to support looking
up the partition via its UUID. Unlike names, UUIDs guarantee unique
partition identification, avoiding ambiguity.

The logic is updated to check if the provided string is a valid UUID
before falling back to a name-based search. The help strings for these
subcommands are updated accordingly.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Simon Glass <sjg@chromium.org>

---

(no changes since v5)

Changes in v5:
- Update doc/usage/cmd/part.rst to reflect the changes related to the
  part command.

Changes in v3:
- Add Reviewed-by tag of Simon Glass

Changes in v2:
- Update commit message.
- Update help for 'part start', 'part size' to mention UUID.

 cmd/part.c             | 12 ++++++++----
 doc/usage/cmd/part.rst |  6 +++---
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/cmd/part.c b/cmd/part.c
index 5e520d707f39..3191d5861fdb 100644
--- a/cmd/part.c
+++ b/cmd/part.c
@@ -144,6 +144,10 @@ static int do_part_info(int argc, char *const argv[], enum cmd_part_info param)
 		err = part_get_info(desc, part, &info);
 		if (err)
 			return 1;
+	} else if (uuid_str_valid(argv[2])) {
+		part = part_get_info_by_uuid(desc, argv[2], &info);
+		if (part < 0)
+			return 1;
 	} else {
 		part = part_get_info_by_name(desc, argv[2], &info);
 		if (part < 0)
@@ -517,13 +521,13 @@ U_BOOT_CMD(
 	"      flags can be -bootable (list only bootable partitions)\n"
 	"part start <interface> <dev> <part> <varname>\n"
 	"    - set environment variable to the start of the partition (in blocks)\n"
-	"      part can be either partition number or partition name\n"
+	"      part can be either partition number, UUID or name\n"
 	"part size <interface> <dev> <part> <varname>\n"
 	"    - set environment variable to the size of the partition (in blocks)\n"
-	"      part can be either partition number or partition name\n"
+	"      part can be either partition number, UUID or name\n"
 	"part number <interface> <dev> <part> <varname>\n"
-	"    - set environment variable to the partition number using the partition name\n"
-	"      part must be specified as partition name\n"
+	"    - set environment variable to the partition number using the partition UUID or name\n"
+	"      part must be specified as partition UUID or name\n"
 	"part name <interface> <dev> <part> <varname>\n"
 	"    - set environment variable to the partition name using the partition number\n"
 	"      part must be specified as partition number\n"
diff --git a/doc/usage/cmd/part.rst b/doc/usage/cmd/part.rst
index b91f6541f7f8..a0e7be08a9ab 100644
--- a/doc/usage/cmd/part.rst
+++ b/doc/usage/cmd/part.rst
@@ -52,7 +52,7 @@ The 'part list' command prints or sets an environment variable to the list of pa
         an optional environment variable to store the list of partitions value into.
 
 The 'part start' command sets an environment variable to the start of the partition (in blocks),
-part can be either partition number or partition name.
+part can be either partition number, partition UUID or partition name.
 
     interface
         interface for accessing the block device (mmc, sata, scsi, usb, ....)
@@ -64,7 +64,7 @@ part can be either partition number or partition name.
         a variable to store the current start of the partition value into.
 
 The 'part size' command sets an environment variable to the size of the partition (in blocks),
-part can be either partition number or partition name.
+part can be either partition number, partition UUID or partition name.
 
     interface
         interface for accessing the block device (mmc, sata, scsi, usb, ....)
@@ -76,7 +76,7 @@ part can be either partition number or partition name.
         a variable to store the current size of the partition value into.
 
 The 'part number' command sets an environment variable to the partition number using the partition name,
-part must be specified as partition name.
+part must be specified as partition UUID or partition name.
 
     interface
         interface for accessing the block device (mmc, sata, scsi, usb, ....)
-- 
2.43.0

