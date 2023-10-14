Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747A7CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:14:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0CED86F56;
	Sun, 15 Oct 2023 08:39:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KHLtZ1F9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C35586EA8; Sun, 15 Oct 2023 08:37:50 +0200 (CEST)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2117986E22
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:36:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-41954a3e282so20896891cf.2
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 23:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697351812; x=1697956612; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8MJ8I816eGLNe5RbeVnfFu5DVrL8DFgV03WxjpfObU0=;
 b=KHLtZ1F9xK84aqsSNV94jEAtzNwakVRkRRuFUegrJtYJOr8WdTsTvU4LctV9Zsii9Y
 kD55CqnwGOV1O+PrZpGpzVb1lRPYZwId71lyN4vi4oepSKhZBwhHOILX8FfByqSAqC6w
 zCQKuKJGCMDx+ZsTJ6xCDZxUL/8T2aZDOOtJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697351812; x=1697956612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8MJ8I816eGLNe5RbeVnfFu5DVrL8DFgV03WxjpfObU0=;
 b=esJqM0REuiLXuWZJw2iELvp4v4DzaAFedvwYBq61iDGySQWolhiUr/oZ+yaJrWE9iv
 Nmkc4vFqu4Ae7J+6+c6s7/sPypg8ibb3AAv4SxVHpA+RRozyCPWRgEUKvvusJaJmzb+Y
 pahxoox4sk49EsfW2IStkRA1le9epE8krglb1jApYpi6Yyatt5JmHC7xCu+QlG3zZP4O
 iGbsKahoOLy0dBVccxB8y2Op35OWccgPj4xBiFdUCtMSTg5a43tgMHnaoNck6v9LgHxv
 kukISFqNpZVqZfH9Tl8wLzTqn+qMbCC0+6uRxQTsXkumfPZEC5Yy16Lj+EauW+RW6+IU
 sVNA==
X-Gm-Message-State: AOJu0YxawawLJVY3/J2Qw0/CGeOdOcQBE7MeC9ut8bnW4cauy+5AvwzG
 P3Quwvg+Iaejfq8d8dBQFseBbEhEWw7ZWnfbwUC2dA==
X-Google-Smtp-Source: AGHT+IEhnHn1IsKAFlVonpPlN0Q0CmWaTwPE9WvHh1oVQgxTyqvlgPB/6Mfa3gxy6IFx32WXoxsjmg==
X-Received: by 2002:a5e:8811:0:b0:792:4cfc:178f with SMTP id
 l17-20020a5e8811000000b007924cfc178fmr32595132ioj.16.1697316038964; 
 Sat, 14 Oct 2023 13:40:38 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 j27-20020a02cb1b000000b0042b14d9be7bsm5424649jap.22.2023.10.14.13.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Oct 2023 13:40:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 1/6] binman: Reset missing bintools after testing
Date: Sat, 14 Oct 2023 14:40:25 -0600
Message-ID: <20231014204033.3077052-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231014204033.3077052-1-sjg@chromium.org>
References: <20231014204033.3077052-1-sjg@chromium.org>
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

For tests which fake bintools being missing, we need to reset the list
afterwards, to ensure that future tests do not also see the bintools as
missing.

Reset the list when processing is complete.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/control.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/binman/control.py b/tools/binman/control.py
index c6d3205b8c25..2f00279232b8 100644
--- a/tools/binman/control.py
+++ b/tools/binman/control.py
@@ -858,6 +858,8 @@ def Binman(args):
                 data = state.GetFdtForEtype('u-boot-dtb').GetContents()
                 elf.UpdateFile(*elf_params, data)
 
+            bintool.Bintool.set_missing_list(None)
+
             # This can only be True if -M is provided, since otherwise binman
             # would have raised an error already
             if invalid:
-- 
2.42.0.655.g421f12c284-goog

