Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA87E606A31C
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 12:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mYR7n/cb;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=frIVB9D1
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC1F68118E;
	Tue, 10 Nov 2026 12:24:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YtoaS4D9TGh7; Tue, 10 Nov 2026 12:24:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 84C328116F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794313451;
	b=KcEUx76+HqfoqSvHnEcU9/zs3LYHrBJ+MMxucl75VeCvRb+0rcO57XqBDlcBTWBwhCOS
	 uyBrB+OH+ir2nrfLrSxkdOprxWzBTkRtfkACaNmAJrq+N+UWwkcfL+hRwEarLoSZFFhzH
	 IbI+bFJ+x2dFrTM4N58t3+gpAhPegRzypRuQIwLu7s613jUxoXJlPBltIiVO1friFE6C1
	 xb/M8bXbcRdIhfhWc9DQ8sdw3R+0wNphwYYsM0AKtYOq7mkDbfGIbQm4SzOY2t1OqsFUZ
	 Jkpmf/lFwFDaSZ6EBP9BoBbqc3dW9/b6qre+e7fEwOpsWhvkg7QapZ63zjwpfRrpH7g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794313451;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=YNVGSgnni3ruWK90eZwmwBXRmtaMh0AYaeLIcPgKnGM=;
	b=YoYIcgn2nf82VlhlgFDGIsacDHln9zSSdg+ldV+5hj8mtSX1BamDJcoCJJv2YzzT0Zct
	 9xf5ZXMj7wlYZdopddVBUD/0lNdss0LqSPI7aPN275SlHfr1fasYXy+OhOfdpXOplJLTr
	 Rk+Rf9z6bI7dvAvIZPYmgfK/DNqV+NIE+vHoB1JMRtCevlC92oC/J1GfjXy1+7OEn3YTF
	 NtAsCTlEzhZL2UeDu8FWT9VEXdswzltmS8u9x+OceLxkPuykojSA6PCRV6Jw+RcpK8/BD
	 Paw4P8UrDdUJW8HHn5rWmMVRBsuUB0TMcdEIzfee7/+jqPWfyG48S7+nV9SzaFyHDDw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794313451;
	bh=YNVGSgnni3ruWK90eZwmwBXRmtaMh0AYaeLIcPgKnGM=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mYR7n/cbJ0go0nI+q6zwYiTThDzWL1ktTGRLTp6c3LuqAXjamzZRvYW9J1UYCQTW1
	 Kupqbd8ZtqOPwlzyetwmyksDboPLd2BBUS/oatyW6NN1unbFcvcIxD1bgqPO5XZ19J
	 LRl6tFPcXwoIzlKoz1D36PHeWQy06LBbiVal2IiwrJvG5/4cQj7kx+jdo6tMvrHhfM
	 au5PLcDQnGW4YbFyH9z6lN3PvF+FagzrcTdDkc7+q0BHJSsKfLS3NcXrG8GCHagsei
	 PB3LwZ/QI+m4FFWu02xnBNp4jRUhV/a0qW0wIaRawJIqkKsIkya3BgA2t8lduVOast
	 RapyWVvGAlbPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 84C328116F;
	Tue, 10 Nov 2026 12:24:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BE276388
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 12:24:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A399C40873
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 12:24:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dO_3R89i0tXP for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 12:24:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2A1E740859
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::5"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:31::5;
 helo=mail-wm2-x05.google.com; envelope-from=andrew.goodbody@linaro.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=frIVB9D1
Received: from mail-wm2-x05.google.com (mail-wm2-x05.google.com
 [IPv6:2a00:1450:4864:31::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2A1E740859
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 12:24:08 +0000 (UTC)
Received: by mail-wm2-x05.google.com with SMTP id
 5b1f17b1804b1-4b886ebe069so6301465e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 04:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794313447; x=1794918247;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YNVGSgnni3ruWK90eZwmwBXRmtaMh0AYaeLIcPgKnGM=;
 b=frIVB9D1o5KwfxjnNXSKwoGGXjhe69V+VuWkFR9+uGOVEdNSw3dPk+RyHmnChtgsOn
 JVAJZu/4GO6MJNKFefssRES0w+Tor/MaAeU9ekqnR5D/A4WuKmwcTpGi/kgBdcTEz+RI
 lqQEFrLQV2DqloLuS+SjVFZeMxecIaCwNqmP1+yvC2XKirjuWwP+5XFENyPXoc44+26r
 7EjY6t6l+SbG1YGHokSQr4C6SfrxIdqYnmiKmKmnPQxMDLIIt85t8S3+20u7hKWcXxIw
 z9QyIi6ST83V9OhlN9dwNrrwXguTKPgKnMevtMyUcZ7KxV58ID6ryuXt9ODvyaZhzawU
 806Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794313447; x=1794918247;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YNVGSgnni3ruWK90eZwmwBXRmtaMh0AYaeLIcPgKnGM=;
 b=r8jJCnd3x1vLh+g9rUaJoeH47v/UgyrlovnxILhxdyZBKYKsQ59/pnbYgE916kGnaM
 35oT4Ke+bYosxap49DbsDKajWVLH1mqAcwaadRWlJJkt4oy4DMSJgC+zYD1m9PFm59Uf
 JYaXrn5dHNgpzGEgpAwlPpEXcnxQ/ryfidqeN81BJ9jxiMzZeb06O/pe9Vno09MXDJ6L
 XGlruQ87l9j0Lt8N1/DD2D4FXuOecCR/CJQFH2+RsTBACs/vnkBbrAN72/LwPGT+dpk5
 Q22EyLmEA6iZCcV+PMLkBHwSpt6E2Z/EPR0ifTdKnXkaNTSQPqhK6IrEXxATa6fgr/8D
 YdHw==
X-Gm-Message-State: APuU4Z9d4uDfajxrjTbmZXATN3CvBYW79uY3930yfIGdM6q/11+0O+fj
 Gtv2zws4N5cZqtzAs6lHNNOWUhF/cTyCRCh8YYZyC8oo/eEoljQAINfiY7446CWteV4=
X-Gm-Gg: AYBFou2ZI08+GN7bKpfxdRi/itJRaRhhgU4Olj14J8Uvia37/+Cn+anecZ1AMKUAMKm
 GtTsvQCCmMPS/Dk49KE8pPLGva7AQ8tDm9hPw3u6xkyjUsJ7C5M72AWtbUHRmO+fVZplFPlrPiJ
 q3BuaPBwM8hpILI+kKTISfCrznxNbedTRa6bpyaFf9MWECfkOD7L4sL5XIxPlvu8/i80OeXz2gh
 U2y7FfYF6QHiPloPZwEVXF6fus1g6gJZepfojbER+YwzHgfftIYrdrUbHwW8iAnJjSxOIeP1/BU
 HVow7kiZahDpirxGfVgI07rtbgbNY2AY+iQy4cq5Q0BmCX6jjpNDtaGS1I5QIZRVj2hKJn+WqQd
 dPl86C34vLrCW52WoA1zGfQAywYTtHz7pFfWEh3dlC1NpLnbztFj/kLhXL90hMAngPVfdUUPO9C
 iekD059Vj3bo+lnXespVbh+tU/RydzUzihlxTTcK4CPtpxQX/6eK+rs5/QLlnGDWhQTliaUc/6H
 G2sMSDRr7Q+u6s36dEDw3mQ/hyjmndcvRtYOWuvYVhwahJL3UQ0HIa3B+8z9wx2gfL70KY9Pwqo
 a4aUnQ2X9QsvTFG2rS3a6BLIPINfLqTrNFeLvzNiBdnHZOxP
X-Received: by 2002:a05:600c:3e11:b0:4b3:9540:47a6 with SMTP id
 5b1f17b1804b1-4ba0234f7a2mr37747255e9.28.1794313446719; 
 Tue, 10 Nov 2026 04:24:06 -0800 (PST)
Received: from artemis3.elfringham ([2a0a:ef40:e16:1f01:e865:f651:6131:9a7d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fea9eesm99279315e9.11.2026.11.10.04.24.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 04:24:06 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH v2 00/12] Fix 'make check' errors
Date: Tue, 10 Nov 2026 12:23:57 +0000
Message-Id: <20261110-qcheck_fix-v2-0-1c76e0b68f29@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN0M82oC/02NQQ6CMBREr0L+2pq2ghVX3sMQU8ovfCVUWyQaw
 t1tYePyTWbezBDQEwY4ZzN4nCiQGyLIXQam00OLjJrIILk8Ci5L9jIdmsfN0odpWypseHMqixr
 i4OkxxqvsWm0c3vUdzZgMqdFRGJ3/rm+TSL1NHM3/4kkwzqywRa5MrtVBXHoatHd751uolmX5A
 fyKCwS3AAAA
X-Change-ID: 20261029-qcheck_fix-af97ed0d895b
To: u-boot@lists.u-boot-project.org, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Linus Walleij <linusw@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Anshul Dalal <anshuld@ti.com>, Alexey Charkov <alchark@flipper.net>, 
 Francesco Valla <francesco@valla.it>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Carlo Caione <ccaione@baylibre.com>, Yao Zi <me@ziyao.cc>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Various tests can be run using 'make check', 'make qcheck' and 'make
tcheck'. These have become broken and need fixing to be useful again.

Running 'make qcheck' fails on the binman test to check the version
numbers of the tools are found as expected. Update the code for the
tools that have been updated and no longer have their version numbers
found by the code.

There are also failures in buildman. First add code to understand 'gcc
-E' as an alternative to cpp. Second add the code to accept an empty
CROSS_COMPILE variable in the environment when testing that
CROSS_COMPILE is not set by the toolchain selection.

dtoc was not achieving 100% code coverage so add a new test to rectify
that.

Disable event_dump tests that are broken on newer versions of binutils.

Build mkeficapsule in the tree that is used for testing the tools.

'make tcheck' was not achieving 100% code coverage and needs to know the
location of the built tools to resolve.

'make check' tests of the file system had errors due to ext4 file
systems being created with an orphaned file but were marked clean.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Changes in v2:
- Added commit 7/12 to address intermittent failure for binman to get
  version string from lzma_alone.
- Added commit 8/12 to address a test failure due to the build tree not
  containing the built version of mkeficapsule and using the system
  version instead.
- Dropped a space from the beginning of a line in a new file in 5/12 to
  quiet checkpatch warning and remove most of the content as not needed
  for test as suggested by Simon Glass.
- Fix 'make tcheck' binman code coverage test by passing in location of
  tools built from this tree in 9/12.
- Fix typo in tools/Kconfig for TOOLS_MKEFICAPSULE config item in 10/12
- Cope with CPP="gcc -E" in buildman in 11/12
- Ensure fsck can be run and use it to force clean ext4 file systems on
  creation to remove orphaned file. 12/12
- Picked up some rb tags from Simon Glass
- Link to v1: https://patch.msgid.link/20261102-qcheck_fix-v1-0-f1f547c4a731@linaro.org

To: u-boot@lists.u-boot-project.org
To: Kory Maincent <kory.maincent@bootlin.com>
To: Linus Walleij <linusw@kernel.org>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Anshul Dalal <anshuld@ti.com>
Cc: Alexey Charkov <alchark@flipper.net>
Cc: Francesco Valla <francesco@valla.it>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Carlo Caione <ccaione@baylibre.com>
Cc: Yao Zi <me@ziyao.cc>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>

---
Andrew Goodbody (12):
      binman: btool: lz4: Update version regex
      binman: btool: lzma_alone: Update version function
      test: Do not set DTC environment variable
      buildman: Cope with empty CROSS_COMPILE in tests
      dtoc: test: Fix coverage by adding test
      test: Disable running event_dump test for make check
      binman: bintool: Do not add empty argument
      test: Build mkeficapsule in tree used by tests
      test: Pass location of built tools to binman code coverage test
      tools: Fix typo in name of command mkeficapsule
      buildman: Cope with CPP="gcc -E"
      test: Fix test_basic file system tests

 configs/sandbox_spl_defconfig                          |  8 ++++----
 test/py/tests/fs_helper.py                             |  4 ++++
 test/py/tests/test_fs/fstest_helpers.py                |  5 +++++
 test/run                                               |  8 ++++----
 tools/Kconfig                                          |  2 +-
 tools/binman/bintool.py                                |  5 ++++-
 tools/binman/btool/lz4.py                              |  2 +-
 tools/binman/btool/lzma_alone.py                       |  2 +-
 tools/buildman/boards.py                               |  3 +--
 tools/buildman/func_test.py                            |  5 +++--
 tools/buildman/test.py                                 |  4 ++--
 tools/dtoc/test/dtoc_test_include.dts                  | 13 +++++++++++++
 tools/dtoc/test/newinclude/dtoc_test_include_file.dtsi |  7 +++++++
 tools/dtoc/test_fdt.py                                 |  7 +++++++
 14 files changed, 57 insertions(+), 18 deletions(-)
---
base-commit: 709a97a05df66e394f40d249105d0baade46f107
change-id: 20261029-qcheck_fix-af97ed0d895b

Best regards,
--  
Andrew Goodbody <andrew.goodbody@linaro.org>

