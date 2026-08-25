Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48647C61DBC
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 16:50:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2428E405FB;
	Tue, 25 Aug 2026 16:50:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NE5749EtAMo5; Tue, 25 Aug 2026 16:50:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787676619;
	bh=GIp2wkfRKJvsBwL06X1B/nIdjPM/nwrv6V4YMRtv4NU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j9vSizJAq+rv718JDnYMu/EfXybNNa9os7zVYCYsJIwnPi0Y3QPDeVXukY2IrHH42
	 COVJbmwnXo5oPcWxiDO8MNlhNU+JYAKUMZw2/KvCPvnGEDszDy8lIDNPrG5nasXaLL
	 dT/2t6X5bSIFw7K1lAHmem9PpzqBCxWHbP31YFnq9q7lpXNk1o+UMRFaoWiEaEmQZt
	 un5mAjaufuGH4N+U5ww7XSN+jzZKeHs1BLvzRAMV/fyOR4W+O/T3wl9oqgIIEoCgRZ
	 leSevKLQOIxwKJ7vtrEpX9rjpBdSDnd7uCJ2mAmUik0gX/ykM/9ZitFkDxzwOS1Abu
	 /do6Ct2TtqyDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C21B3405CF;
	Tue, 25 Aug 2026 16:50:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C90FD39E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 16:50:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AFB8040169
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 16:50:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hmL7TJhsnXEw for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 16:50:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:fff0::8faf; helo=smtp-8faf.mail.infomaniak.ch;
 envelope-from=foss+uboot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=CVfud6d0
Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch
 [IPv6:2001:1600:19:fff0::8faf])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 138F24004E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 16:50:15 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hTv0P05Vlzk2j;
 Tue, 25 Aug 2026 18:50:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787676612;
 bh=GIp2wkfRKJvsBwL06X1B/nIdjPM/nwrv6V4YMRtv4NU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=CVfud6d0MZkUYUKoxjobbrBXfQk1NNs8eY7MhaKq/BCCdfGDUuKfhyx+i+qs5obeX
 fjWpr6K5uab1c8G+yxBbC7assMVKnbLdMrVi68TGaCz8eHDb7jy3d6TdaT2nGf5HyQ
 3MAkNhr8JOKZZaG6u/aliRHg1J2bs8OtR8cJS/JyIBLlxFbAocquMA6ibYikh0ridF
 bxGYMPA1dVg8xJWHuYsy5nnrFCt003cVPfBHYl5HKh/xdFDlA0o4DXqYm6d14y9SUa
 ECxl2G5s0kOLx2QAYEvUExRiWkADTea/9lIP4A1t87GlOoqQqiKrqet4rIIG5nuHFD
 hQOpnzpnkBH3g==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hTv0M3ZQ5zXQH; Tue, 25 Aug 2026 18:50:11 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 25 Aug 2026 18:49:42 +0200
Subject: [PATCH next 05/45] doc: arch/x86: update link to DediProg SO8 Testclip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-linkcheck-v1-5-ee7573fe3a4a@cherry.de>
References: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
In-Reply-To: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
To: u-boot@lists.u-boot-project.org, u-boot-amlogic@groups.io, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Viacheslav Bocharov <adeep@lexina.in>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Soeren Moch <smoch@web.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Le Jin <le.jin@siemens.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Sean Anderson <seanga2@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.17-dev
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

The current link is returning 404. I'm assuming this link here is the
proper product page based on the slug in the URL.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/arch/x86/x86.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/arch/x86/x86.rst b/doc/arch/x86/x86.rst
index 7abf819e36f4..09d180087fb8 100644
--- a/doc/arch/x86/x86.rst
+++ b/doc/arch/x86/x86.rst
@@ -192,7 +192,7 @@ On Minnowboard Max the following command line can be used::
    sudo em100 -s -p LOW -d u-boot.rom -c W25Q64DW -r
 
 A suitable clip for connecting over the SPI flash chip is here:
-http://www.dediprog.com/pd/programmer-accessories/EM-TC-8.
+https://www.dediprog.com/product/EM-TC-8.
 
 This allows you to override the SPI flash contents for development purposes.
 Typically you can write to the em100 in around 1200ms, considerably faster

-- 
2.55.0

