Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED38C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 19:55:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D56E488604;
	Fri, 21 Jun 2024 21:52:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OLxlOPTL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6811D8859F; Fri, 21 Jun 2024 21:52:28 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45C10885BC
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 21:52:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7ebc67365e3so90051439f.1
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 12:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718999545; x=1719604345; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VImn7eC6Dpo9NE6YIGiHh04gfKjTg4SkC4HhpgpbdXc=;
 b=OLxlOPTLTgx4qCO4HihaHYmAY35xc55PF1jKDEOxsD8jmGs4GyD0h/Y5B6Uddo67kK
 E5bNk5ljKdvq4KSp7ruYc9FkN2JibnRuluIi+ycGK0qvjYwxC868BJ8+A81TEpvJWGxu
 6bl1CYioydPMbO8VJA3PnjPQlvnlHr1rpdwgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718999545; x=1719604345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VImn7eC6Dpo9NE6YIGiHh04gfKjTg4SkC4HhpgpbdXc=;
 b=qf8I2McdJFMwtTeSUwkl6ENhcWL6hT9dn2WZB1iwNoq4xon0E2ngDevvl6ptBsMF/0
 DTpYaLmbdaakrawjIlt/EjVkVE5B7yyk37iTWulfor2ZYr7TwwGCO4Twr5/+czJf/199
 S68byEbDHvYOcpKYhdPG3x57A+RZQGz3i8+8rRliJMAWRnnnz4U7bGKNS6ToEd7F1YgD
 EceaasMSA+7h/I7jFcMfYm8Hnl9DeVG/wYlqlx1D08zj6NcHmnU5VOGSpe5GuDLnljhE
 ayOloSrsBGx1768GSPemDqvC1oPBkk87cYmsTULip/AMBQnTmaN9lmuGc3EqP+VpDeQz
 Eouw==
X-Gm-Message-State: AOJu0YxoST2XrrNW01cilvu6k43cca96wqy6D7x7h5bJ0+x8DhC2AQcn
 Lcz1niPz2zetgdLJAeZuEkKtsaSobYQErLFDf/hdSvs2p/Hon+hqJzMIkVCR2VWonH2TbFMLPI5
 eJw==
X-Google-Smtp-Source: AGHT+IF8rxxLjtIgL+ENWXDQ5Dek0atzIfMvIHb4ZshcruBIYZbbHvUENc5acmc8cLiyandKz++47w==
X-Received: by 2002:a05:6602:2dd4:b0:7eb:6b58:440e with SMTP id
 ca18e2360f4ac-7f13ee94480mr1107166539f.18.1718999545016; 
 Fri, 21 Jun 2024 12:52:25 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203deb7sm48801139f.47.2024.06.21.12.52.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 12:52:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 19/43] test: Allow signaling that U-Boot is ready
Date: Fri, 21 Jun 2024 13:51:40 -0600
Message-Id: <20240621195204.2675252-20-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621195204.2675252-1-sjg@chromium.org>
References: <20240621195204.2675252-1-sjg@chromium.org>
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

When Labgrid is used, it can get U-Boot ready for running tests. It
prints a message when it has done so.

Add logic to detect this message and accept it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/u_boot_console_base.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base.py
index 3e01be11029..e230caf37e1 100644
--- a/test/py/u_boot_console_base.py
+++ b/test/py/u_boot_console_base.py
@@ -22,6 +22,7 @@ pattern_stop_autoboot_prompt = re.compile('Hit any key to stop autoboot: ')
 pattern_unknown_command = re.compile('Unknown command \'.*\' - try \'help\'')
 pattern_error_notification = re.compile('## Error: ')
 pattern_error_please_reset = re.compile('### ERROR ### Please RESET the board ###')
+pattern_ready_prompt = re.compile('U-Boot is ready')
 
 PAT_ID = 0
 PAT_RE = 1
@@ -170,15 +171,15 @@ class ConsoleBase(object):
                                     self.bad_pattern_ids[m - 1])
             self.u_boot_version_string = self.p.after
             while True:
-                m = self.p.expect([self.prompt_compiled,
+                m = self.p.expect([self.prompt_compiled, pattern_ready_prompt,
                     pattern_stop_autoboot_prompt] + self.bad_patterns)
-                if m == 0:
+                if m == 0 or m == 1:
                     break
-                if m == 1:
+                if m == 2:
                     self.p.send(' ')
                     continue
                 raise Exception('Bad pattern found on console: ' +
-                                self.bad_pattern_ids[m - 2])
+                                self.bad_pattern_ids[m - 3])
 
         except Exception as ex:
             self.log.error(str(ex))
-- 
2.34.1

