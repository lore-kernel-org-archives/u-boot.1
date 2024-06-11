Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F41C27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 21:04:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC32688755;
	Tue, 11 Jun 2024 23:04:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="g0YRgeyy";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="fdHvWSqC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6156E88714; Tue, 11 Jun 2024 23:04:18 +0200 (CEST)
Received: from wfhigh4-smtp.messagingengine.com
 (wfhigh4-smtp.messagingengine.com [64.147.123.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E530C8839F
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 23:04:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfhigh.west.internal (Postfix) with ESMTP id E16951800146;
 Tue, 11 Jun 2024 17:04:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Tue, 11 Jun 2024 17:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm2; t=1718139853; x=1718226253; bh=Ij
 Vi7E3MQU2knldMvNctk5o6SPH8mbesc/DouuhnzCA=; b=g0YRgeyyH0x1LpqBg/
 3Of0uTEc+6jg/Fh+tkGcBffIW9ssnDUyl2nhrASrwNlU7UwhqphvaMoktW5RooTu
 AMAeOM+HNQJvaDWPeXr2qUGFRO9mWSTl+mnBQGdFaPuUHzM6/gRUlIc6OT3NtXIR
 ZL1e9lb4H4zJiNjv2rzmbdb9QzgQsSWDIofMx9sYluRIkUBht4XAsnL6sWK/oEix
 tByxGeDmQMNq1UGIShdMK/JTzCi89kxSVvoC68HhC0DUmmt2PCwfDqX5OJr7eqK2
 gFspE9uoA00Vd+KJhP1HRo79omp3HFoUykD43FkcTrQfVFXHvN0a8FiFRwH3Q5Xh
 uHfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1718139853; x=1718226253; bh=IjVi7E3MQU2kn
 ldMvNctk5o6SPH8mbesc/DouuhnzCA=; b=fdHvWSqCnrZFinGbgQH9zsvt2rda5
 lBVOWYCxG3eHGMXWAW5K+aekHo97QlM8BZjWsyBplYTkoqM/DzOc96K86PXXB7uv
 /9fBkasalYaIV57cEoB6lzZsbuDaZI8m+mtupa+Mj+X0Y0q18nCwtLr6v42AVlPC
 bwlRhRLMm72I+6dkGgwZTi/8Frv+4+OMFiiddyf4uCa7uk1VWd3AeboAl7AjlbO7
 qpaGiAT25FS6PmdsxEGqrgC9tCAjiFSD+iWLlM81tqfBeH+h1N5i00x3BkNCg9Nr
 2IqepusKadg2oSfffev+5IS3CADobXhFxxajyB9WFirgWtbp9fjl9Psxw==
X-ME-Sender: <xms:zbtoZk39sKiiLtGF9GNOniv0YQc0TVh90CZSm0uQzT-JfgttSdTCfg>
 <xme:zbtoZvEj4Wc4frORqNx1V92FKIBgubvrxDG2bF54ChNg2_vHnJXUIFGLLfNixVXS2
 sRD6wvLB8wX1BL40c4>
X-ME-Received: <xmr:zbtoZs4rs5gP0DqbGJzLXl88R5bghYsnUzPKFlNib8jAd1dPa7IHupI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudehgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheplfhirgig
 uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
 ggtffrrghtthgvrhhnpeejveduudffueevffdtgfetheeugfeggeevheffleekiefhgeev
 geefieelieelheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhtlhgrsgdrtg
 homhdpvhhishhurghlshhtuhguihhordgtohhmnecuvehluhhsthgvrhfuihiivgeptden
 ucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrth
 drtghomh
X-ME-Proxy: <xmx:zbtoZt0mcEgRrKgsTr959EloClu8t5ry8olwGTpS-8q-CfrDSCfnCA>
 <xmx:zbtoZnHeqlAhyesDPqNdX3TaBH9cILh2fvSjjYrd5OAzZX1BQSjNyw>
 <xmx:zbtoZm_YrGusQOggJBvPRvRD7P7r20CyaZq3cykuXDnXbtMtb56hEQ>
 <xmx:zbtoZsly_V1UOypvLVG4kt9LQd3qErLvMpBmDNfSnbxq9XTku7AWdg>
 <xmx:zbtoZtaj3HytSyxQOGKgCyBWNG3X2Q0Tgro8PtlA2P3MWeT3wpnN9-_L>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 17:04:12 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 00/20] New CI image and fixes
Date: Tue, 11 Jun 2024 22:03:59 +0100
Message-Id: <20240611-docker-image-v1-0-51472eb70357@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL+7aGYC/x2MQQqAIBAAvyJ7TtAlRPtKdBDdaok0FCKQ/p50H
 IaZBpUKU4VJNCh0c+WcOuhBQNh92khy7AyocFRGKxlzOKhIPn131liNxmvv0EFPrkIrP/9uXt7
 3AzeIzmVeAAAA
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Aaron Williams <awilliams@marvell.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4306;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=DnVkBuKzNj5mqIV1iMHZUgmTyIQasyJi7BaEq4445i0=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSM3WetvyeGbZS4YJW1X7F7isXdIwtjr23uzDjhbr3s7
 j2HWdkBHaUsDGJcDLJiiiwhAkp9GxovLrj+IOsPzBxWJpAhDFycAjCRvHuMDJ9eMJ8weTs/1NR8
 goqDYELrX8+5O3s6Vhw+m2rfxux14RcjQ69N/xWt799fZ5emdz8za9M707d4kbD+oZs3NOtWZ0b
 94gIA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

Hi all,

This series build a new CI image based on Ubuntu focal with LoongArch64
support, fixed various python scripts for python 3.12, fixed various
problems popped up when testing againt latest software.

This change must be combined with test hook changes at [1].

Last two commits are for demonstration purpose and not for commit
into repo.

CI runs passed at azure [2] and public gitlab.com runner [3].

Thanks

[1]: https://lore.kernel.org/u-boot/20240611210025.798978-1-jiaxun.yang@flygoat.com/
[2]: https://gitlab.com/FlyGoat/u-boot/-/pipelines/1327832544
[3]: https://flygoat.visualstudio.com/u-boot/_build/results?buildId=63&view=results

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Jiaxun Yang (20):
      py: Replace deprecated unittest APIs
      binman: Replace pkg_resources with importlib.resources
      py: Replace distutils.core with setuptools
      py: Replace usage of configparser.read_fp
      doc/sphinx: Remove usage of six
      py: Remove unused entries in requirements.txt
      py: Bump requirements versions
      py: Bump pylint version and clear warnings
      binman: Workaround lz4 cli padding in test cases
      tests/test_event_dump: Relax match rule for output
      lib/charset & efi: Fix possible unaligned accesses
      cyclic: Rise default CYCLIC_MAX_CPU_TIME_US to 5000
      CI: Ensure pip install is always performed in venv
      CI: GitLab: Split build_world tasks
      CI: Dockerfile: Set global git name & email config
      CI: Dockerfile: Bump various software version
      CI: Dockerfile: Add LoongArch64 support
      doc: ci: Document how to run pipeline on gitlab.com
      [NFC] Use Jiaxun's CI Image
      [NFC] CI: Dockerfile: Replace some URL with mirror sites

 .azure-pipelines.yml                            |  22 +++--
 .gitlab-ci.yml                                  | 122 ++++++++++++++----------
 common/Kconfig                                  |   2 +-
 configs/octeon_nic23_defconfig                  |   1 -
 doc/develop/ci_testing.rst                      |  12 ++-
 doc/develop/python_cq.rst                       |   4 +-
 doc/sphinx/kfigure.py                           |   3 +-
 doc/sphinx/requirements.txt                     |   1 -
 lib/charset.c                                   |  21 ++--
 lib/efi_loader/efi_device_path.c                |  11 +--
 test/py/requirements.txt                        |  24 +----
 test/py/tests/test_event_dump.py                |  10 +-
 test/py/tests/test_ums.py                       |   1 +
 test/py/tests/test_usb.py                       |   1 +
 tools/binman/control.py                         |  18 ++--
 tools/binman/entry_test.py                      |   6 +-
 tools/binman/etype/fdtmap.py                    |   1 +
 tools/binman/etype/fit.py                       |   1 +
 tools/binman/etype/image_header.py              |   1 +
 tools/binman/etype/pre_load.py                  |   2 +
 tools/binman/etype/ti_board_config.py           |   1 +
 tools/binman/etype/x509_cert.py                 |   1 +
 tools/binman/fdt_test.py                        |  48 +++++-----
 tools/binman/ftest.py                           |  50 +++++-----
 tools/binman/setup.py                           |   2 +-
 tools/binman/state.py                           |   1 +
 tools/binman/test/184_compress_section_size.dts |   1 +
 tools/buildman/bsettings.py                     |   2 +-
 tools/buildman/builder.py                       |   2 +
 tools/buildman/func_test.py                     |  74 +++++++-------
 tools/buildman/requirements.txt                 |   7 +-
 tools/buildman/test.py                          |   2 +-
 tools/docker/Dockerfile                         |  75 +++++++++------
 tools/dtoc/setup.py                             |   2 +-
 tools/microcode-tool.py                         |   1 +
 tools/patman/settings.py                        |   9 +-
 tools/patman/test_checkpatch.py                 |   2 +
 tools/qconfig.py                                |   1 +
 38 files changed, 293 insertions(+), 252 deletions(-)
---
base-commit: 1ebd659cf020843fd8e8ef90d85a66941cbab6ec
change-id: 20240610-docker-image-868126a1a929

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>

