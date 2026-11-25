Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFB3606A31E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 10:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qj4gGYQr;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=WmY8lrrW
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC38C6070F;
	Wed, 25 Nov 2026 10:58:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aL3vna26IJ29; Wed, 25 Nov 2026 10:58:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D0F99606BD
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795604318;
	b=nzyl+R8xw77o6RmJq5fnM2ttpSzwSdOD25+bYXc3obEPgKSL19Guo1flv4PPucDKQvUo
	 LGianqU5ku4Y75feJ3CW2bGwF6YLxUZbkdC8rtrRrRQHfXKevVfqWNtjkDdIRbVjLVRyq
	 1UaMlGsn+UyZ0qYFQzsM0wJiYOd5nDGKRxmLKTF0HT9yfZPQCHxGNLgplAxfPGIO8zrsJ
	 TojY/xeNGLfHfQKHxIZz0yyGx/WpIf221q6v0AJkLwPT9ucjYzh/k4JlJXX2Jzimm0uYD
	 bhh4qnlTqSj2qUKY/Rjsu1DA4o3HvdtMxLeqjJ+F29nW6JG6vvekVzLJEM+iKeSC+wg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795604318;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=LmJpf/AWZWiD1nLk+IkN9i4jA7I5ObPDGpVFqxTy3xA=;
	b=RrMm01v2d9Qb5/fNXmLoZrsjTZ8mEfJVrc0VZCG/vwkdl3WzQLKgEUp5fzzonyKlbZoz
	 kz4ZncIsEyVYTZ614+LtqxWzK62VkaiP+vla8kqE37LQoF6IlDOqt6tCRzOH0iFXDLSFJ
	 tjTDAwMdPvBZxx0nmPBmxFiS5Iy1JC1EyDEtws0pCKOQkP8k9JRJb8/6SJJFuFUbyR9B1
	 t7sfLPuYGnmEZZZZVOtOvbDBkgqGu0Tc+oEAVjFpkd614AcJd5s7g5oQwH64kZ12qQPlf
	 FiIcBF/T7SYZkHwwlkyFTACX2pkoVIcyy66axcN55dQPxN25+NO8kbT9UnPrOQStIiQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795604318;
	bh=LmJpf/AWZWiD1nLk+IkN9i4jA7I5ObPDGpVFqxTy3xA=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qj4gGYQrPCpY0RYpp7ONVTmVnFUdNVnoVubQppHu1T5+WshhMMMsDoejr//x6mjNX
	 mPoZ5WxZecnA2JjnhqIdjmu0IRdZg5sOuL1uC8j/Oh5kK1O1+4HWbdR0ELBAC8zP9V
	 b+L3NBxYLumtuTCET7YrulAn5yHYo1KoyQAgL8ZL4VfNIQCUAojiQJu2C+20jwBulQ
	 9VnE/oUZUsqh4N/xAmUSFKLN7pXL/rWVLuaRCmU0XgLfEHQ8bupvwFuu877cLybFj5
	 99Crnw7r6uqkSf85sQQopfEi80w2zz04Z3Pc6AWjB58/k7QznWP59iPa4BGogocB1y
	 yA+M/Tn/WJOEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D0F99606BD;
	Wed, 25 Nov 2026 10:58:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 64CF62DF
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 10:58:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 55B5C80847
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 10:58:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vNzxskcsOlY6 for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 10:58:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5DF40807F5
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=clegoffic@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=WmY8lrrW
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5DF40807F5
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 10:58:33 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so51369855e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 02:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795604312; x=1796209112;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LmJpf/AWZWiD1nLk+IkN9i4jA7I5ObPDGpVFqxTy3xA=;
 b=WmY8lrrWNxFjIcd8EqiIpVJn2ytcAF8uxG/X3SLMuJVAl2gXtLiBk1QjqQbUQtk2oI
 CdP60HNRP7gobi5mrfoMgTZnlTbmjJBD87lCVfXbikh3Gr38IyIi3qGX9geM7v48B7Gn
 ZueCIYnVWSSeyGox3uK7pIuf1KMpimTx2NqE4yEpHWPvLVuqRyie1GXvAOkvC9cQ8nXZ
 JxF3VB+lrWpNB0KT5tsYBDpJZmktKhtiJETH5CYu1DsqHDxXHKgZGQhAdk+afLsAxglO
 JapUpewWUYqJ3mkXrHzcLPabKN2ZFu6kcd6LHdEppY/PMM7pBEpNOP5GWjbK3htKC3jw
 k/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795604312; x=1796209112;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LmJpf/AWZWiD1nLk+IkN9i4jA7I5ObPDGpVFqxTy3xA=;
 b=aSEXpkUh7JwVTr0a+tEX7MKVXa8P4VU3vxomLFfbJ5o+01nyZzxMourm+WtQRC8fVv
 GlxB1V4uFa9sRTIPH9SkOrm14mOa18rQkjC/R00y7AZBWISNk5UEZb3TQS54I9ZizbBg
 pmRomgJpCGi+fU3l00ck+7iXMDT8llZo9xdVIac38oEmBCy1IOWAHfCMN/jW9U9Pbg2M
 wnnEeT/aX+eqKeLmyq2pfv4C+lJNng9rya8kvoG2v9Ox+2t00yh9WH7uWcMS3a2EJqWr
 4x6XfFwCMpqMOpzOlvfuZWN9au/JTeRpnmdTg9hYolg8Gfoq21zlUgliT90I24FqdLnP
 Nl2Q==
X-Gm-Message-State: APuU4Z+V521d0aSgjSCi9Or873lM4jMdmkuiQSjzx+kNHUU1SpcHBOJu
 T68fNVQ/Q3T0S4ZSLFNuYwZN/+kZTht4gQ9sVwFkRtYhNylQkR8AnzFcOxkBsQJPoTaSkL03ET3
 HK0X771Ir4Q==
X-Gm-Gg: AZFdTZcAepIchqschXMADhyD+oq1eYGxATWPjIcGI/xpA7p29MA3M33q2jL9D3/+CDs
 5klAovXeSqyIughzS0SNAOXm1SQg0MmU6XMXppC5KJkCMi0b5ATWhAUsPsStGJFGmMjTJn/5ksp
 MQIhRU6lMipnmkB6XCwA0cfe652T5ZHXahPsiufW4I0JL3D36cvo6+qX6ZIfbsgQWnBH/cSb5kE
 nNCqD9cAWGMLOoNLRJAeNiOBr2zkPvjpYoBd7xQmTKxjjz59JsR6bAZ//6eByQMQyX2zZf3xktk
 7aOj4DZgkvT2s2dXHy7tm6Cr+4hlFtIQWZ/UGONQ7sXPX3xEYvThoTRBKl5qgYv75tWInoYMeY0
 P975jq2DNjhN7VeRjUMfvOMDaUGlK5KCPg2xkAui/w3Pg7BZoIygdOpSvW3Vwb7JU0W2sFVgeAT
 clMlFz6htcn4sOBjyDaiI3JDMeTr4060DYr+GMbekqNEEL/kIPXEzlIjNPHG6xeTXB4BlrZIsO7
 y0GHC9nYxmHW/B1tyqKhf1Qu7CJr5ozkK+Rt+bHy7cKvafautVxwoBib1LK1Ujke1595vzMw+Z6
 3tAaq68FbvYae2jRQdfFsPYD3SoGzKvzHSd1VoSi4N4yvJjQ1mQQsM2A/pUjDXrRsBWHG0/9
X-Received: by 2002:a05:600c:4f10:b0:4bb:60bd:5398 with SMTP id
 5b1f17b1804b1-4bb88804d35mr393257015e9.10.1795604312181; 
 Wed, 25 Nov 2026 02:58:32 -0800 (PST)
Received: from localhost (140.30.66.37.rev.sfr.net. [37.66.30.140])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884a15absm458762905e9.9.2026.11.25.02.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 02:58:31 -0800 (PST)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>
Subject: [PATCH v2 00/11] env: flash: Add env erase and enable it on R-Car
Date: Wed, 25 Nov 2026 11:58:09 +0100
Message-Id: <20261125-clegoffic-env-flash-erase-v2-0-8d31a33a54d2@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEK/BmsC/42NTQ6CMBCFr2K6dgytphBX3sOw6M8UxiA1HWwkh
 Ltb8AIu3uJL3nvfIhgTIYvrYREJMzHFsYA6HoTrzdghkC8sVKW0LAE3YBdDIAc4ZgiD4R4wGUa
 4aN+clTaonRZl/0oY6LN/39sf89s+0E3b4dboiaeY5l2e5db7x5MlVCCbuq6N9dJ6vFkzD2QTn
 lx8inZd1y9/AQRe1wAAAA==
X-Change-ID: 20261026-clegoffic-env-flash-erase-46d8326ae6c6
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Johan Jonker <jbx6244@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, Fiona Klute <fiona.klute@gmx.de>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
X-Mailer: b4 0.17-dev
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the missing erase operation to the flash environment driver and
enable env erase on all R-Car boards.
Also fix an RPC setup that made the R-Car X5H Cortex-M33 port hang with
some saved environments.

CMD_ERASEENV comes only with an environment driver that can erase.
The flash driver shares the sector erase and write with save and erase.
env_flash_load() no longer marks an erased copy active (it was before).

Patches 2 and 3 let the shared code test pointers instead of adding

  WARNING: Use 'if (IS_ENABLED(CONFIG...))' instead of '#if or #ifdef' where possible

While testing, the X5H Cortex-M33 port hung at "Flash:" once two environments
were saved.
The board code sets the PHYCNT HS bit, which is meant for DMA.
With HS set, some CPU reads of the HyperFlash never complete.
It was the reads that miss the RPC read cache at an address not aligned to 256
bytes.
The hang depends on where the variables fall in the saved environment.
Patches 10 and 11 clear HS and fix this issue.

Tested on the Ironhide board.
Patch 10 is only build-tested on the R-Car Gen3 boards that also use the
RPC HyperFlash driver. I don't have one to test.
An LLM was used to review the patches, set up the tests and chase the
RPC issue.

checkpatch.pl warns about long lines in patch 8/11, a boot log kept as
U-Boot prints it
It also warns about an unknown commit id in patch 10/11, a Linux commit

---
Changes in v2:
- New patch: only offer CMD_ERASEENV with an env driver that can erase
- New patch: define env_ptr in every build
- New patch: define the redundant copy pointer in every build
- New patch: factor out the flash sector erase and write
- New patch: factor out the flag update of env_flash_load()
- New patch: drop end_addr and end_addr_new
- New patch: only mark a valid copy active in env_flash_load()
- New patch: clear the PHYCNT HS bit in the RPC HyperFlash driver
- New patch: do not set the PHYCNT HS bit in the R-Car X5H Cortex-M33
  board code
- Rework the flash erase operation on top of env_flash_rewrite_sect()
  and select ENV_SUPPORTS_ERASE with CMD_FLASH
- Drop the redundant copy and partial sector details from the erase
  commit message
- Enable CMD_ERASEENV once for all R-Car boards in renesas_rcar.config
  instead of in each Ironhide defconfig
- Drop the Assisted-by trailers
- Rebase on v2027.01-rc3
- Link to v1: https://patch.msgid.link/20261026-clegoffic-env-flash-erase-v1-0-18777abd1bde@baylibre.com

---
Clément Le Goffic (11):
      env: Kconfig: Only offer CMD_ERASEENV with an env driver that can erase
      env: flash: Define env_ptr in every build
      env: flash: Define the redundant copy pointer in every build
      env: flash: Factor out the sector erase and write
      env: flash: Add an erase operation
      env: flash: Factor out the flag update of env_flash_load()
      env: flash: Drop end_addr and end_addr_new
      env: flash: Only mark a valid copy active in env_flash_load()
      arm: renesas: Enable env erase command on all R-Car systems
      mtd: rpc: renesas: Clear the PHYCNT HS bit
      board: renesas: gen5-cm33: Do not set the PHYCNT HS bit

 board/renesas/common/gen5-cm33.c |   4 +-
 cmd/Kconfig                      |   1 +
 configs/renesas_rcar.config      |   1 +
 drivers/mtd/renesas_rpc_hf.c     |   3 +-
 env/Kconfig                      |  13 ++
 env/flash.c                      | 319 ++++++++++++++++++---------------------
 6 files changed, 170 insertions(+), 171 deletions(-)
---
base-commit: 9d67454e920b3908529c9fc642a8c911db040896
change-id: 20261026-clegoffic-env-flash-erase-46d8326ae6c6

Best regards,
--  
Clément Le Goffic <clegoffic@baylibre.com>

