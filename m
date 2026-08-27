Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D83CC61DC4
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 19:54:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 535A340810;
	Thu, 27 Aug 2026 19:54:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8cIYNBkRNHCe; Thu, 27 Aug 2026 19:54:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787860466;
	bh=Yf07YdDNq+8TmNCOpbWpmIX8THcnlajRz1uFdvaVSS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n19ZPfdqzQ5Phaq5yi0tVmPX2ITPTjli+4NN79VumNvRvlAN0HEPZgXytZ0CK6E3n
	 hIAF7b3da4dzXcKLk4MImhzc2jbsr6gHGuvAoWy3oj+ar3Ve40+Zv8Eo76oPe42cyG
	 4mIIGolxDtEkzpCof69gf++oLo3XEbXAa5TEYNmrpvZBmI3296+CBx//EzsAdwjCfB
	 7ubyZB/j2tbbGFlcNkhHkbb/MB2ukDzUgzvcDI6sjSJb9hgZuwhXWzDO8Nhcd7W24T
	 8N3o4wQFc+eFvx/MMVJUJsm6Dwc0kdw0ST3eBWkYRif0kLIKj5vJANNUUALXCCTlgI
	 Y9jy6RhI4rzvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7DCF740811;
	Thu, 27 Aug 2026 19:54:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3948BCBC
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:54:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 36EEE80ED2
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:54:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mVuMKNqqMtUj for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 19:54:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.157.188.10;
 helo=smtp-bc0a.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=k6bq2Bd9
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch
 [45.157.188.10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6455B80EE2
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:54:09 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246c])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hWBzg4QgMzywL;
 Thu, 27 Aug 2026 21:54:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787860447;
 bh=Yf07YdDNq+8TmNCOpbWpmIX8THcnlajRz1uFdvaVSS8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=k6bq2Bd9b53xUjyGqhDe4eOtxujAJDHU9YonabIAdH0PyBz+JWBcKoXo/EN+qiH8W
 JCJqiCgYcsG1JC3r2G7SxKZYxIkhuefJambAjuCA8IwmYqJgsijj6dEPyIIjDds8iQ
 D1JpBadi0jD/sSYyn9BR53oXDmhmc5wO+vJJsE1B1H0JqNPkZLwRoX/CXutlrOsrKg
 Fdnk829ku4dXwniBYO7oBuAyc948aVnEutNYs3dQcyn/NEO3ZXlHEKSkFyw7c9N2Xx
 gUHIEdHDvMEjRTKOzmWlV4NAYRgPINSKu89kEZQBwUDKEm2C4nIUaxaxZHVdDcXfnA
 +/N2VoO4+jfXw==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hWBzc6D4ZzRNH; Thu, 27 Aug 2026 21:54:04 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
To: u-boot@lists.u-boot-project.org,
	u-boot-amlogic@groups.io
Cc: uboot-imx@nxp.com, trini@konsulko.com, sjg@chromium.org,
 neil.armstrong@linaro.org, marek.vasut+renesas@mailbox.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, adeep@lexina.in,
 sbabic@nabladev.com, festevam@gmail.com, smoch@web.de,
 alpernebiyasak@gmail.com, le.jin@siemens.com, jan.kiszka@siemens.com,
 iwamatsu@nigauri.org, pbrobinson@gmail.com, seanga2@gmail.com,
 bmeng.cn@gmail.com, lukma@denx.de, mkorpershoek@kernel.org,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH 39/45] doc: develop/bootstd: fix link to distro_boot
Date: Thu, 27 Aug 2026 21:53:07 +0200
Message-ID: <20260827195313.129994-18-foss+uboot@0leil.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
References: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Quentin Schulz <quentin.schulz@cherry.de>

We never had a file in boot/distro.c. The only time we had a
distro_boot() function was between v2022.07 when it was introduced and
v2023.07 (excluded) when it was renamed to extlinux_boot(). So let's
just point at the latest release that still had it.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/develop/bootstd/overview.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
index 106586f667bb..cf8ef419d4b2 100644
--- a/doc/develop/bootstd/overview.rst
+++ b/doc/develop/bootstd/overview.rst
@@ -883,6 +883,6 @@ Other ideas:
 
 .. _distro_bootcmd: https://github.com/u-boot/u-boot/blob/master/include/config_distro_bootcmd.h
 .. _BootLoaderSpec: https://uapi-group.org/specifications/specs/boot_loader_specification/
-.. _distro_boot: https://github.com/u-boot/u-boot/blob/master/boot/distro.c
+.. _distro_boot: https://github.com/u-boot/u-boot/blob/v2023.04/boot/bootmeth_distro.c
 .. _bootflow_h: https://github.com/u-boot/u-boot/blob/master/include/bootflow.h
 .. _migrate_patch: https://patchwork.ozlabs.org/project/uboot/patch/20230727215433.578830-2-sjg@chromium.org/
