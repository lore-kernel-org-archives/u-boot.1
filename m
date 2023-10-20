Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7040CDB474
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 10:48:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 174448745B;
	Fri, 20 Oct 2023 12:48:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697798897;
	bh=q0zIWbw1Njmrz4PE+/M40ibLRIUdlgbQ+JvEgama7cw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bl4pK0EkZKM1cDia0yVRbJfGfjRNVNi6KIOmn5+/HlWwZTJTk8eS284Yt4NBQgyOx
	 2+ELJ3P4UESrSLTEpi5dL2JdWRQikyvRjC5ixCHzwBoryq413MkNJyjwjmQ77+VQuT
	 o3t/XfQIZDRbVU8M/N1qefAlXSsiVb/f0kt2xWd9CK6Pl+Npx9txTx6B7cfwhep3Q3
	 EzNznktBfDTrbMh9hVwxRLSANoKycb+LIL8xtwtDDC8alDhrvoDlLrKvlLZCQRjyWK
	 8F/X9XUkRRlKCvTp5KTdOendtTbXkzuYQAxdYpuNwNQwK+E1FMQcjCXfirr++gSerE
	 X6zKp19Nzv3bA==
Received: from localhost (unknown [185.51.87.24])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pro@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 463A68745B;
 Fri, 20 Oct 2023 12:48:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697798896;
 bh=q0zIWbw1Njmrz4PE+/M40ibLRIUdlgbQ+JvEgama7cw=;
 h=From:To:Cc:Subject:Date:From;
 b=BO532+9mCZ/+mQzmbNcXa/0NSYrqV81f26WxFcRdnoL3zDTHg1f9FAlf8Wv7qXWyM
 FNNn4vrWEpdgB7cNPmIpXPQVAEjlwMRBiCnB4p9NaUH22xeXP1YtNv9Ii48FNTsEyT
 A4v/DwbVQpEjutwB2bzFsc51dyAuigSmQWDOr74KvKrzQxWeT9w5podxIAcGZ9x3yb
 Bznr/hzHm9Yi89HmqDn3VD3hjn5hvZEI0HgrW3JnaVSdX4PXPwm8VoGbMQbOaPzudv
 RgCLqiloadbswGDELtXPj2hKHV5wB4puYbNmSXCsJcnt80QOSlpsWo0MC7V4bJHBHb
 TywizOZOMvkDQ==
From: Philip Richard Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de
Cc: Philip Richard Oberfichtner <pro@denx.de>
Subject: [RFC] CTAGS prototypes
Date: Fri, 20 Oct 2023 12:46:07 +0200
Message-ID: <20231020104606.23305-2-pro@denx.de>
X-Mailer: git-send-email 2.42.0
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

Hi,

is there a specific reason why the ctags make target is compiled without
using '--kinds-c=+p'? Maybe it would make sense to (optionally) include
that in the Makefile?

I personally find it useful to jump to the header where a function is
declared to view the documentary comment. Or am I missing another option
to quickly get there?

Regards,
Philip

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-22  Fax: +49-8142-66989-80   Email: pro@denx.de
=====================================================================

---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index e0040a40d3..7f108330a5 100644
--- a/Makefile
+++ b/Makefile
@@ -2085,7 +2085,7 @@ FIND := find
 FINDFLAGS := -L
 
 tags ctags:
-		ctags -w -o ctags `$(FIND) $(FINDFLAGS) $(TAG_SUBDIRS) \
+		ctags -w -o ctags --kinds-c=+p `$(FIND) $(FINDFLAGS) $(TAG_SUBDIRS) \
 						-name '*.[chS]' -print`
 		ln -s ctags tags
 
-- 
2.42.0

