Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE34810F3DE9
	for <u-boot@archiver.kernel.org>; Sat, 28 Mar 2026 17:17:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68DDE83FA7;
	Sat, 28 Mar 2026 18:17:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jd8SJZFR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31C7C83CD3; Sat, 28 Mar 2026 18:17:05 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E707383DCB
 for <u-boot@lists.denx.de>; Sat, 28 Mar 2026 18:17:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48538c5956bso30828545e9.0
 for <u-boot@lists.denx.de>; Sat, 28 Mar 2026 10:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1774718222; x=1775323022;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Mh8S4bvLscy0w5DE+eviu1WjsIbvjgnteN21kYD3wY=;
 b=jd8SJZFRNwSGEDbpyQKHzOnkkfiMw6TMLZTYTGs9ub5Qv52sqZ/svqsGiDZWnGVPyB
 bxKbPebU+nY8AdmriWAgc9gvPH2UtbdOMmSh80t0pGEBLGdxzgrFRnDh9v4fSnfCwSxO
 sDar+jtLG+2jSDN3Fk6qzRMmYPBRiFqSM4jqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774718222; x=1775323022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3Mh8S4bvLscy0w5DE+eviu1WjsIbvjgnteN21kYD3wY=;
 b=sSLDuDACoAFLDid5Ee5hmMGil34hROiea+M6zxGYyKevIHIHblhLC7jxKqgUzqVNds
 w5tbOEQ4JirUuF8bz4L1hLIjigbr/4uym+c655unYXie0ikAdVLKjW9vKxEn0dkXSVH/
 sgYeaYR2cdzsOdu974GI0p4J+4LYIp/eMzRe+T9WIfIil4D6oGrV/QJ6saUx+vrtIwcc
 TWcUk89dAar1K6PaIgIDIQNig6ozSGhilDJXj8PpMpQh7Zkm6zq/uG1uioxvClATKsot
 oCLhB8MD7YLugc/sMkThSVmrMU2nmxPw3jFCgs/GmyywNxtiQcM2gVT/SUf28MkzRHGl
 DgDg==
X-Gm-Message-State: AOJu0YxRlzCGd4DUInAdeC1k1qEJHxbcZszjUyE+4VFUGdy2swb4HsTF
 ls5xjliH+zGO80AaDWKk51wgkvdyhde4/Tww1b/0klEdE04s2zJCmnk8vk5auyTvitCSOajkEhu
 RsNKz
X-Gm-Gg: ATEYQzxNKJH7xdcIFOazI2iWEGlqPXXkv7JBnwbW+hnpVKZTybatKttdrtXd8M2qYKX
 9AaY490E8SNQk9aYcgTqoTvHHij2WRyG/Jg7fZ0l6S22Y9UcTkkALN5ETCXXb9uL8ubNry7qvxI
 3e25rT6kLPk02lUuF1nJb1pGrpCycbkFuIYEzyHRMooY1GrQhWbFPgu+vr7T4oiB/GINZVs+XK9
 9afeZDRGY1Q3rMkwaEsE6Uqfu7x/ldIB0xNvAzLuV11fzrw0nuvqwZpciKNoZ3/+9327kvmvb8z
 xhpzPdnxeFO/uE4g8DHjbcVJx3ujX/Dpnod5KQR5LqW/NtX2b4ZBMfJB777JOLQ3A39xWthPjSN
 +IS2FiW65LzO59TBIA7IefrirrAq0rfELD+CyazDZoGpBOzz8bqLGtWinzqxFDxEioVJUsNSP6i
 H7AUzGq1zviV8RvrHHoVTq4Mvqsncx97p8pWMeMtgD050HByM64PU0KpKFK9Z75dnMEQjDDsW1P
 EknWhcvrZCzhUxVYR9PC7DD6CFeeDdvxiw+sjjzoUqPRIm1zXcZxpC3aGf1pc2fzp6tEqfVcaOm
 WuK8oKYRq9rWPQKBjEZLdBlBMqQc2RWLAwM=
X-Received: by 2002:a05:600c:c172:b0:486:f893:56c6 with SMTP id
 5b1f17b1804b1-48729109ac4mr90982165e9.10.1774718221665; 
 Sat, 28 Mar 2026 10:17:01 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-87-9-100-184.retail.telecomitalia.it. [87.9.100.184])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722c6b105sm332432465e9.1.2026.03.28.10.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Mar 2026 10:17:01 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/4] cmd: part: support lookup by UUID in 'part number'
Date: Sat, 28 Mar 2026 18:15:15 +0100
Message-ID: <20260328171624.2377527-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260328171624.2377527-1-dario.binacchi@amarulasolutions.com>
References: <20260328171624.2377527-1-dario.binacchi@amarulasolutions.com>
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

The 'part number' command currently allows looking up a partition
index only by its name.

Extend the command to support looking up the partition index via its
partition UUID. Unlike names, UUIDs guarantee unique partition
identification, avoiding ambiguity.

The logic is updated to check if the provided string is a valid UUID
before falling back to a name-based search.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 cmd/part.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/cmd/part.c b/cmd/part.c
index 975a0a08a99d..a3f3febb6977 100644
--- a/cmd/part.c
+++ b/cmd/part.c
@@ -139,6 +139,10 @@ static int do_part_info(int argc, char *const argv[], enum cmd_part_info param)
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
@@ -314,8 +318,8 @@ U_BOOT_CMD(
 	"    - set environment variable to the size of the partition (in blocks)\n"
 	"      part can be either partition number or partition name\n"
 	"part number <interface> <dev> <part> <varname>\n"
-	"    - set environment variable to the partition number using the partition name\n"
-	"      part must be specified as partition name\n"
+	"    - set environment variable to the partition number using the partition UUID or name\n"
+	"      part must be specified as partition UUID or name\n"
 	"part name <interface> <dev> <part> <varname>\n"
 	"    - set environment variable to the partition name using the partition number\n"
 	"      part must be specified as partition number\n"
-- 
2.43.0

