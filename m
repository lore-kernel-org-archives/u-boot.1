Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE83DC0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 22:36:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E281880BB0;
	Wed, 29 Jan 2025 23:36:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="GsoHDq2F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F06680B9B; Wed, 29 Jan 2025 23:36:54 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA2E6809D2
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 23:36:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e4db=UW=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1738190210;
 bh=dP/+GhZl04Rj7A7YxPgb27pLc+epDdTwwnueuCzOhI4=;
 b=GsoHDq2F7zpz7x8GA03zp9wUslHO+hUZhitFhRJ8v3SKO7u8rOJTMb1LuO+OCo5zB2y9jkrc3
 Ggo1PjEYecX6FHdGZEjDLZ2FcQ7VO9L8bfyEbz+3pBJy7wfsTwnaEugel7LlDXCXCnGrOh1hwuI
 WBDpNgd/dCJsixzAUvPwH4dNEVnJ+tCehfCaXfvEjij5UeQOwoSOPWu03uF4S2lnei28pspFjoQ
 lIjRne1aM5bP+ZIgXGJPT5kTT0VIdCRQw4zFdGXyhMwMJHZNAwADyD+D0KK/ZTqSM2Tr+taJ65h
 Fp0CtY15yVnadJfjQTu12GLmsIptzPRmDydvynjatF3Q==
X-Forward-Email-ID: 679aad7e3590a80aa97f8de2
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/6] rockchip: mkimage: Improve support for v2 image format
Date: Wed, 29 Jan 2025 22:36:26 +0000
Message-ID: <20250129223641.1888833-1-jonas@kwiboo.se>
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

The Rockchip idblock v2 image format header embeds much more information
than the older format. E.g. it can embed up to 4 images that the BootROM
can load, image load address, flag, checksum and more.

This series improves mkimage with support for some of these features of
the v2 image format. Features that are likely to be needed to have
working SD-card boot on RK3576.

Jonas Karlman (6):
  rockchip: mkimage: Split size_and_off and size_and_nimage
  rockchip: mkimage: Print image information for all embedded images
  rockchip: mkimage: Print boot0 and boot1 parameters
  rockchip: mkimage: Add option to change image offset alignment
  rockchip: mkimage: Add support for up to 4 input files
  rockchip: mkimage: Add option for image load address and flag

 tools/rkcommon.c | 268 +++++++++++++++++++++++++++++------------------
 tools/rkcommon.h |   2 -
 2 files changed, 166 insertions(+), 104 deletions(-)

-- 
2.48.1

