Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B6EFC71159
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 22:09:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFE868006D;
	Tue, 17 Jun 2025 00:09:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Y76ZQhS1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D07682C4C; Tue, 17 Jun 2025 00:09:41 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 926F78006D
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 00:09:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-105-042.46.114.pool.telefonica.de
 [46.114.105.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id BCF2E3F23C; 
 Mon, 16 Jun 2025 22:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1750111777;
 bh=yB56pFHF1oKgTR+p+HHvCcU0A47z2j/8Vw+BRCFmAeo=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Y76ZQhS15azndDVl8zHyvIEv3aucQ+K/eK9YWUtInY3xXOOKIipRabeJMnlJLi0eL
 A4uNdF380/nJZ/Ur7gJlmYBtXxV2bAfAPG5ORDj22DyNHm5Uu0wdgBnXnKsZiavmrf
 Hf7izlQR4vEF1yTJa8Dew5RiuwRy5VZ/yosUKVfA+utm2VcKCsdgcuek5WEY6psLhq
 jh3fLo0Josx5q95CecfYp5O8K5L16gE5fjhinb3RDm8tzj0D/gHVI2QEHJ15FSa+Zi
 8vw7fNj9/g8ElSiv2xVBzv1LnMaCvdHF8SX9vXz847pIT/3sgbNiuxNm3NlQjuu6j6
 u5ax1tYp6GXPw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Javier Martinez Canillas <javierm@redhat.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/2] sandbox: enable CONFIG_CMD_BOOTEFI_SELFTEST by default
Date: Tue, 17 Jun 2025 00:09:15 +0200
Message-ID: <20250616220917.34189-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

The sandbox is used for a lot of generic development, we should run the
UEFI tests there, too.

The TPM emulation on the sandbox is incomplete. Disable the TCG test on
sandbox.

Heinrich Schuchardt (2):
  test: disable TCG test on sandbox
  sandbox: enable CONFIG_CMD_BOOTEFI_SELFTEST by default

 arch/Kconfig                       | 1 +
 test/py/tests/test_efi_selftest.py | 1 +
 2 files changed, 2 insertions(+)

-- 
2.48.1

