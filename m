Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52931C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 00:50:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A7C7871AD;
	Tue, 14 Nov 2023 01:49:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="eLSe3PW0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34EAF8717B; Tue, 14 Nov 2023 01:49:57 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DCC487061
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 01:49:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40836ea8cbaso37641295e9.0
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 16:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1699922985; x=1700527785;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qix27dDaF+Z6bv+sGnLHRPyck3e5KexcMccEjMKO2+c=;
 b=eLSe3PW0dpLnAjKsjSTQPPjxjhLBva5PSMdqr0Ur0naXWrRjb8770KwIjZphb+U+uT
 hUXz7OCD/278dV8KBQHnZ7xTgyCkNseHANRE6YjqNdmKSjT+PenfMIB81hR+z6cGnhxL
 azME2kwuQooEaDlY0nHtvcGEcMI8agVS4dJFyRQu956xE4iUp9k+6oyEjkrMBLH8MS3d
 l7LdSY76sZJKFUbYSUwJw2XEhMLe0bcVjlAtt22/ks30XeZ2Xf+yOWJM5p/3sQ0Q58W7
 4Z/JcFo4qKl7Vf56PS00TbHe/72bdhlItM2ZYaRn+kQd2ql8hf8tPe8izFGwaAbSOQUk
 nLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699922985; x=1700527785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qix27dDaF+Z6bv+sGnLHRPyck3e5KexcMccEjMKO2+c=;
 b=pUJVqqYup+ppl1koWonbTqzoVpy+RXYoEjsgRSVAP1Gv1eodBaVZtOZLzDL1uawW4V
 jPAb7O0mlPa/aLncdjrn+H9suXCeCtsvL+V7ilMHj/C7B64I1+tkGqS6FkrVzoQWq0uO
 jREX6NrJ0EIiUVDDSEaKRayuUbD3CN9EWP29zr4O+gUEZSgq0/49wbxMLgDKTSdOCCLB
 o776EE9TyiKnek0thpXAaA62dXcpl++pSL82gEjHVw9OK+FKaLfr9+MKcdJpa8sgJkbH
 po1FbiKQMfn5cBxCs+9J/FtLOL2DNAUbDFN7fhWdtEb3r9AzfbvosPkq+16jGESoA1+r
 gI1g==
X-Gm-Message-State: AOJu0YxfCrgvAsid85khOt9R7suzB3aRVAuhO+FXVl0hnW/AXe4AxVXF
 xYcd90QGEl31OtIlrvRpkszkKx7rTWPOucE4Vil5YyuJ
X-Google-Smtp-Source: AGHT+IFdcDkDgNLLrQWs4dqTIdLNof4vsRVWPn3V8+D28bLNo/ja4as+Jp1ODueWbneskxUMLGw1uQ==
X-Received: by 2002:a05:6000:1007:b0:32d:bef3:8b23 with SMTP id
 a7-20020a056000100700b0032dbef38b23mr4444905wrx.62.1699922985287; 
 Mon, 13 Nov 2023 16:49:45 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 p6-20020adfe606000000b0032d2f09d991sm6402675wrm.33.2023.11.13.16.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 16:49:45 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org,
	trini@konsulko.com,
	Shantur Rathore <i@shantur.com>
Subject: [PATCH v1 1/3] bootflow: bootmeth_efi: Set bootp_arch as hex
Date: Tue, 14 Nov 2023 00:48:24 +0000
Message-Id: <20231114004826.815833-2-i@shantur.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231114004826.815833-1-i@shantur.com>
References: <20231114004826.815833-1-i@shantur.com>
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

bootmeth_efi sets up bootp_arch which is read later in bootp.c
Currently bootp_arch is being set as integer string and being
read in bootp.c as hex, this sends incorrect arch value to dhcp server
which in return sends wrong file for network boot.

For ARM64 UEFI Arch value is 0xb (11), here we set environment as 11
and later is read as 0x11 and 17 is sent to dhcp server.

Setting it as hex string fixes the problem.

Signed-off-by: Shantur Rathore <i@shantur.com>
---
 boot/bootmeth_efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index ae936c8daa..ad3f4330da 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -338,7 +338,7 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
 	ret = env_set("bootp_vci", str);
 	if (ret)
 		return log_msg_ret("vcs", ret);
-	ret = env_set_ulong("bootp_arch", arch);
+	ret = env_set_hex("bootp_arch", arch);
 	if (ret)
 		return log_msg_ret("ars", ret);
 
-- 
2.40.1

