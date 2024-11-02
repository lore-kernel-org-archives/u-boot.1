Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC1BE677F5
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 10:12:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84D1788C10;
	Sat,  2 Nov 2024 11:12:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="o2yi2NTb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7678988F6B; Sat,  2 Nov 2024 11:12:37 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7A908862E
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 11:12:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 51CD7408DA; 
 Sat,  2 Nov 2024 10:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730542121;
 bh=cKJ6+3//cYj2Xjq27VOmruKO7rfTkkZF8/1Lp/7FqiQ=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=o2yi2NTbrkDFXeGiM5SiIzp/Kbxxfr0eKqPvpEBk1vk+YwL8ixmyRQeoFAMjdSVFP
 HUFvAjNtJeIqxwpf2t/9kwPoHbEZE4OIFT7yypEcDsvmvZ78xEBe6/UB/81m2bYf2A
 tEoilcOdm1+19ptIvi+7ngjLyn49DmdOVXj7qAnL3mtuuGzU0HK4KCt7HRMtE2Cd5u
 aK1YLBxVWaY4SsgdbpJI90C7vE03RJCj6f5SPMWCZUJb4ZxkiDkZekddu2s/qsFI1i
 +k/7jgXgKJMWqDb8/9Rq4ZT6t66KwhzFYeoQ9z5qFd5NYkvggRsUuiB6w20HMuLOCe
 W1C++3xo3eO/Q==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/2] cmd: hash: correct parameter count check
Date: Sat,  2 Nov 2024 11:08:34 +0100
Message-ID: <20241102100836.103005-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

Since commit 348ea878508d ("cmd: hash: fix param count check") the hash
command cannot be used without the optional variable name parameter if
CONFIG_HASH_VERIFY=y. 'hash sha1 $loadaddr $filesize' returns
CMD_RET_USAGE.

The minimum number of arguments is four no matter if verification is
enabled or not.

Fix the parameter check.

Provide a unit test.

Heinrich Schuchardt (2):
  cmd: hash: correct parameter count check
  test: unit test for hash command

 cmd/hash.c        |   2 +-
 test/cmd/Makefile |   1 +
 test/cmd/hash.c   | 101 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 103 insertions(+), 1 deletion(-)
 create mode 100644 test/cmd/hash.c

-- 
2.45.2

