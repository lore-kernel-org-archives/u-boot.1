Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD49C47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 16:10:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B458587B34;
	Wed, 17 Jan 2024 17:10:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="t/K3ntuu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 977E4879ED; Wed, 17 Jan 2024 17:10:25 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C49B87B34
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 17:10:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C3FE63F26F
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 16:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1705507822;
 bh=YAHUQv+TZByp3mrIZwnDG58yTufLmHMhRasnjcGmgp8=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=t/K3ntuuZbG7eOtc5fqlBpuW6pSzrOnRgRAxAHVK9V9Q69gafEtWS0y0Rkp2P0yVY
 kc7vh7WTKpY/0s8lFSC1BeCQapsORtx2LHm9EZxw6Dr8RlqJGrPbALqCCyR66IGPJB
 5lB+M4mN35mTpBDiGkbFBZjT+A8nCRJlE7QLM34/gu2CrMMpWAZbgWMdNQg/ukDGe2
 pFiVBYeJ5TAdXIPd5XmXAeM9sQKTlZc6kPZN1DEmccq5wtGUlTpCtCl5gq/wBtrFN7
 sEku4hMD4WY09g5C3gpmUQ8ngv4z6qvlOeTA6Gz7lmPeq40i95IA3vSrEg6dYT/rlj
 OX6lAvQ2HcdMQ==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40e47b2f6b8so74202115e9.2
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 08:10:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705507822; x=1706112622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YAHUQv+TZByp3mrIZwnDG58yTufLmHMhRasnjcGmgp8=;
 b=EF95n+8+DEtqdH2nI3OnuXSODFyXtEJ5atCIXYK3Y+AyQ4HQy2E4zk2k78Sgmji78o
 O6emXluc/hYCgYgPHGJt0f0bgcNHRcT0Jt8F6W4HvcWEgBp3Wb+UAEp0oejyk77Y4Qqi
 J/uD7IGQwP1qJsd2n3klCit10nQbqSgJsbkrVL1Pa5nmT6sMlfp4Ofa/iwnE2ubdSHXd
 aSHKpWNHeKh6xbXgyEsMPA/1x2lkIMxgFghMb7BatLV7oiEg8MX0r2tQzIgDPED9W0i6
 O9qK9jOKtCOn4Eq7V+HN8huDWg73w+QaPobManTd0cQkpQ5HLmX4GUJkaLS41o64d1x3
 hY7A==
X-Gm-Message-State: AOJu0Yz6isj7ZJ2PdMBNnccERrkuFs6azv86mVE+QTW6U4sG0fg3dyPr
 OcPtebePZIWEo0xJ4y7RTTuvakZ1UUQt4q3d/k7qbHh5zSshzVS8eNodM606FpfaudmgTQZ1nh4
 4JyLVjsuWAGG28V7OlKJSTuwWQYN1+8arYJJIKg==
X-Received: by 2002:a05:600c:3151:b0:40e:67a9:5d1d with SMTP id
 h17-20020a05600c315100b0040e67a95d1dmr4475463wmo.149.1705507822462; 
 Wed, 17 Jan 2024 08:10:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuUQFZCFczECx+YrkGzeG3cI8I5pZQMNAlHnIC/YvPiVhU/CUl2wBa/BieHqTBn/JW6vT5iw==
X-Received: by 2002:a05:600c:3151:b0:40e:67a9:5d1d with SMTP id
 h17-20020a05600c315100b0040e67a95d1dmr4475456wmo.149.1705507822110; 
 Wed, 17 Jan 2024 08:10:22 -0800 (PST)
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 az22-20020a05600c601600b0040e8d7ae469sm928541wmb.24.2024.01.17.08.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 08:10:21 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 0/4] cmd: provide command to display SMBIOS information
Date: Wed, 17 Jan 2024 17:10:14 +0100
Message-ID: <20240117161014.89092-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117153347.85074-1-heinrich.schuchardt@canonical.com>
References: <20240117153347.85074-1-heinrich.schuchardt@canonical.com>
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

U-Boot may supply an SMBIOS table or they may be copied from QEMU.

Provide a command to display the SMBIOS information.

Currently only type 1 and 2 are translated to human readable text.
Other types may be added later. Currently only a hexdump and the list of
strings is provided for these.

The following prerequisites had to be fixed:

* The definition of SMBIOS type 2 lacked a field.

v2:
	merged patch remove
	for generic boards we only can assume that a type 127 table exists
	my email address updated in all patches

Heinrich Schuchardt (4):
  smbios: type2: contained object handles
  cmd: provide command to display SMBIOS information
  doc: man-page for smbios command
  test: unit test for smbios command

 cmd/Kconfig                  |   7 ++
 cmd/Makefile                 |   1 +
 cmd/smbios.c                 | 191 +++++++++++++++++++++++++++++++++++
 doc/usage/cmd/smbios.rst     |  93 +++++++++++++++++
 doc/usage/index.rst          |   1 +
 include/smbios.h             |   1 +
 test/py/tests/test_smbios.py |  41 ++++++++
 7 files changed, 335 insertions(+)
 create mode 100644 cmd/smbios.c
 create mode 100644 doc/usage/cmd/smbios.rst
 create mode 100644 test/py/tests/test_smbios.py

-- 
2.43.0

