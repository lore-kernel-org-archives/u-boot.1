Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E06E7718F
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 21:59:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF6FA8039B;
	Fri,  3 Jan 2025 22:59:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="0nPrfOC1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6440B8039B; Fri,  3 Jan 2025 22:59:20 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65A2480295
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 22:59:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4402=T4=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1735941556;
 bh=RXY4Yg+Qe2W7aq785JNMAfQWygPoVSoEBRzGIQTm/90=;
 b=0nPrfOC1kZuW3Dn2BDi7cc0Mc/UGP0015Oizln6hBG0B6xDb0MXTRqDXQRQ5hnvfzvP1S2ljH
 xTWMfblZdpQ8zIck4tnCZpkF605wu45eObwrBsIS1Q+DVmJj87srkI+l3k6lxdsZkDEYnBTX7eI
 XEWlj4nzaR8IJ97YA2hlBctfkzUxzYCRHGR9xGkqzh07mCNcBDz29F7r4B2/iDVEUDWoUYwX4QX
 DUlSVW3rN/P8+9/+F50YI4B2I+q653EvTGdpWQoFzbvNsDeVNw7Rc9LWx9zy8akSJ7KorZ3ErPN
 9GmDunQ3t+YpHiyTbHP+qz7NWtSkJFyqeQWxSD+pHkTQ==
X-ForwardEmail-Version: 0.4.40
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Received: from bionic.. ([78.69.151.207]
 78-69-151-207-no600.tbcn.telia.com) by smtp.forwardemail.net (Forward
 Email) with ESMTPSA (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384); Fri,
 03 Jan 2025 21:59:06 +0000
From: Jonas Karlman <jonas@kwiboo.se>
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/2] tools: mkimage: Add Amlogic Boot Image type
Date: Fri,  3 Jan 2025 21:58:57 +0000
Message-ID: <20250103215904.2590769-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 67785dad053722097e3f0ff2
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

Add support for creating an Amlogic Boot Image that pass CHK in BL1 on
Amlogic AArch64 SoCs.

The first patch add the new amlimage type. The second patch add a eMMC
relocation workaround that can be used to generate a boot image that can
be booted from both eMMC and SD-card on GXBB.

The amlimage type and the eMMC relocation workaround is loosely based on
my prior work, aml_chksum, a small tool that can write boot image
headers with updated offsets and checksums, see [1].

This has been tested booting a very limited U-Boot SPL on boards with
e.g. S905, S922X, S905X3 and A311D SoCs.

[1] https://github.com/Kwiboo/u-boot/commit/6d0a17632922077a2e64b13ae1a6bdf0024b718f

Jonas Karlman (2):
  tools: mkimage: Add Amlogic Boot Image type
  tools: amlimage: Add support for GXBB eMMC header

 MAINTAINERS                    |   1 +
 boot/image.c                   |   1 +
 include/image.h                |   1 +
 tools/Makefile                 |   1 +
 tools/amlimage-gxbb-relocate.c |  79 +++++++++
 tools/amlimage.c               | 283 +++++++++++++++++++++++++++++++++
 6 files changed, 366 insertions(+)
 create mode 100644 tools/amlimage-gxbb-relocate.c
 create mode 100644 tools/amlimage.c

-- 
2.47.1

