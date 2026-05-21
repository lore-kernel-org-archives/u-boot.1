Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41AC4CD5BAC
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 18:50:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 949B984825;
	Thu, 21 May 2026 20:50:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="rw0AOR3v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D54CE84867; Thu, 21 May 2026 20:50:32 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D30E584713
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 20:50:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-046-114-111-011.46.114.pool.telefonica.de
 [46.114.111.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id BA32C3F69C; 
 Thu, 21 May 2026 18:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779389430;
 bh=YjAwFo95ZgSs45OtA05H4GuQvi4pY2Vzul8GWmd7sts=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=rw0AOR3vvOxOPF5TZXZSHS+m8TJy56f16Sdn2TK3qmCKNhmxmVpV7H2hs82Zdg/2Y
 +FkQ/K8Ryepzu1f+thggGVW8J/LusOyjRKZJ6F4grCqxwwpf4j5LtoaEggmve2T1LL
 d7y8ZrwVvta2JnFEe7M14g6j/Jz34uXwCtec1/HKRWdfT7MMUNO+8KaBphWnVCRlk4
 e/+Et4UDgjsPGWTaZlQcnPY75hpowursv5os68OJ1W4Kcw49scwSyvSl5MdnTy+Ym0
 eDIdmM3XguRLHmHBXUYGQhhJHG1vzrLQ2kND48onoOrbtuc5QUbRa2R7jjrpO1Skf9
 xYl3SkzGj/Qd3df7iLstsXJV817G5tw/+xzBFneaqwvn+YBOKiSYiJJVJSdezUVXm1
 j28T60iv4QZRsIfYv9iMn7jMBnrkTTV7w4650lvHo+O0PTkNb0yUBfmwFb21pRF3Qj
 VRcjE5nzGCJEQLs8n3LgmDB16T0yGPPqEwWfY2CPgPtSb8aPFKEAyM/Fbv3Q67kqfN
 cnimctTG6xf6TAxi7sFFu6Sy6zmC5TmuiC7MPo5kO6Wz2BeBZGFKt+waka3B3aYbVY
 916CM6pexQLLnJwIyGm5fGBUzwyzaBADrGl1DJkziDg5p2BuDf9Uxn7L1UOKOlcXEo
 eujh3oCIt1QwtYDKVaPYPmxo=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/3] efi_loader: fix ACPI table installation
Date: Thu, 21 May 2026 20:50:22 +0200
Message-ID: <20260521185025.30857-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
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

On the sandbox efi_acpi_register() used sandbox virtual addressed instead
of pointers required by the invoked API function. This lead to EFI
applications crashing when trying to access the tables.

The first patch corrects the API invocation.

The second patch provides a unit test to ensure we don't do this wrong
again.

The third patch provides an EFI app that we can use to download all
ACPI tables to the EFI system partition for further analysis.

Heinrich Schuchardt (3):
  efi_loader: use pointers in efi_acpi_register()
  efi_selftest: add ACPI configuration table test
  efi_loader: add ACPI table dump EFI app

 lib/efi_loader/Makefile              |   1 +
 lib/efi_loader/acpidump.c            | 999 +++++++++++++++++++++++++++
 lib/efi_loader/efi_acpi.c            |  42 +-
 lib/efi_selftest/Makefile            |   1 +
 lib/efi_selftest/efi_selftest_acpi.c |  75 ++
 5 files changed, 1102 insertions(+), 16 deletions(-)
 create mode 100644 lib/efi_loader/acpidump.c
 create mode 100644 lib/efi_selftest/efi_selftest_acpi.c

-- 
2.53.0

