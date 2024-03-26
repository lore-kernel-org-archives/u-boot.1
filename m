Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB1FCD11DF
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 09:40:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DAF287F64;
	Tue, 26 Mar 2024 10:40:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kz4kQJHm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1A7D8801D; Tue, 26 Mar 2024 10:40:27 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0D97874AC
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 10:40:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id B0106CE1C97;
 Tue, 26 Mar 2024 09:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BCBC433C7;
 Tue, 26 Mar 2024 09:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711446023;
 bh=p5JMmDgrmDpN7TtZIky3Gw60g9N8a+hyRHYxLFcMH68=;
 h=From:To:Cc:Subject:Date:From;
 b=kz4kQJHmIv9vNztriIUTzOuwRh/SnkZGEQxuGNMuVIqsdAndXA5/SC5cy5Ff4djhA
 ef6ZDBdPbxyOesasBYxBiC6zxjygu0FmcRtZOp/fSKxmlutzoRRG9jAxp4gURHoRpa
 lQ0DOb95RvADEovqXST0CxRydrNdOVG/4jnkd0RC5tCKkiJM2eUPqtpOx6zbW2yXbW
 /zmjmGm2rO+9rz0LyFioPEATjpRxpozvx6/PG3zudhI4ujkViqOgoeSkASa3IbwE0f
 /sFjMmRgm6pFLLzKHNUOHidQrYsNGNTwpn/kE0Z1c1huyjHUvNkayfkrqB6su8v9IN
 lX9pOiAnxCanQ==
From: Michael Walle <mwalle@kernel.org>
To: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: Neha Malcom Francis <n-francis@ti.com>, Michael Walle <mwalle@kernel.org>,
 u-boot@lists.denx.de
Subject: [PATCH] tools: binman: ti_board_cfg:  improve error message
Date: Tue, 26 Mar 2024 10:39:34 +0100
Message-Id: <20240326093934.2167180-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
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

When there is a lint error the user gets the following cryptic message:

  binman: Node '/path/to/some/node': Yamllint error: 18: comments

This isn't very helpful. Improve the message to tell the user that the
number is actually a line number and also tell the user in which file
they have to look.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 tools/binman/etype/ti_board_config.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/binman/etype/ti_board_config.py b/tools/binman/etype/ti_board_config.py
index 2c3bb8f7b56..c10d66edcb1 100644
--- a/tools/binman/etype/ti_board_config.py
+++ b/tools/binman/etype/ti_board_config.py
@@ -248,7 +248,7 @@ class Entry_ti_board_config(Entry_section):
 
             yaml_config = config.YamlLintConfig("extends: default")
             for p in yamllint.linter.run(open(self._config_file, "r"), yaml_config):
-                self.Raise(f"Yamllint error: {p.line}: {p.rule}")
+                self.Raise(f"Yamllint error: Line {p.line} in {self._config_file}: {p.rule}")
             try:
                 validate(self.file_yaml, self.schema_yaml)
             except Exception as e:
-- 
2.39.2

