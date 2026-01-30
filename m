Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3654CE6BF2F
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 18:04:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F79084523;
	Fri, 30 Jan 2026 19:04:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="eBlN4c3R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8156084529; Fri, 30 Jan 2026 19:04:31 +0100 (CET)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB223844AE
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 19:04:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1769796259; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=CEecBycALdPddDlsK80B+4NMLh/m/XaEGgOxxXzONRLIm0/LHFs3xneSpycLusG54PlaQ1fqoT+R4oTRL/lZnSdXQXPKtAXyFrMWuT6NcI9kKIpuf9F2xyAd+eCuPvI7B6y/0h03V+w6L2VjNPIxvarowuV1Pbp/mxOSJFR0O/s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1769796259;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=q12utGGuBY0gHg1X4T/TlDzlJADjObeB4ojuQWKwoMQ=; 
 b=EjpCHKV9+ORdQctu7p9UkZyV0+4OCQuDeZBHomoau1RiLrv8WqNwsQ8c/yA89ncfyDlR5z+H4iK70FBJ3DjRAYyMb9r4eHDGAk2PE4JjFspuy5PHPwc+7DqNlYejJBkipslVxqGleUU2fzbdZENIRAZ1e07+D+8jygzIf3QMXEc=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769796258; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=q12utGGuBY0gHg1X4T/TlDzlJADjObeB4ojuQWKwoMQ=;
 b=eBlN4c3ROk6VpA5nB/jCeeXfeqM1ksJcapg/pH6V2oEh4jpvSLk4bwnnU0OXZAsy
 oUdWbKgWBIxFARf5Ir1dXGpigtqyCcRwC+D8S8AULfyL6kiW7AC+s/6AUGiJ9OG5aBO
 kGA8rzw08xSojUkYnAOF4tcumSB/CVYyYf9KrVsY=
Received: by mx.zohomail.com with SMTPS id 1769796256595243.60357325799168;
 Fri, 30 Jan 2026 10:04:16 -0800 (PST)
From: Yao Zi <me@ziyao.cc>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH 0/3] Code improvements and argument checks for mmc dev
 subcommand
Date: Fri, 30 Jan 2026 18:03:50 +0000
Message-ID: <20260130180353.42205-1-me@ziyao.cc>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
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

This series reduces code duplication by utilizing fallthrough, then adds
extra checks for arguments of mmc dev to ensure they're valid numbers,
preventing unexpected behavior.

The last patch replaces an integer literal returned in do_mmc_dev() by
its corresponding symbolic constant, CMD_RET_FAILURE to improve
readability, no function change is involved.

Yao Zi (3):
  cmd: mmc: Simplify dev subcommand handling
  cmd: mmc: Check whether arguments are valid numbers in dev subcommand
  cmd: mmc: Return symbolic value when part switching fails in mmc dev

 cmd/mmc.c | 55 ++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 23 deletions(-)

-- 
2.52.0

