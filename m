Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48AF3C61DBE
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 16:55:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0862B40640;
	Tue, 25 Aug 2026 16:55:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rBA8VsVwMPhQ; Tue, 25 Aug 2026 16:55:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787676941;
	bh=SA1yi+xrrFqYaC4ydbnH6AspjY5WcDY0lsDbFKfq5eY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UB1TTMLGaeAlX5APhtdnWNigN7VJI09zezb4HANhQKamTF5ddA5UI3Z/VsnJH21at
	 81umk/rWhIUNC5/lJAhTrTMDUasQ6WWcxW4+617m+NXLd6yx56qS3655y6sr4j4blM
	 SkkfBiB/BgCwEK9kDdjCCkKfayVVNCDYHk2wl1yqLmrzxWmueYcEN+531XYBT9FWuD
	 YLP6zXlYPtFKXJwzuCtXXJaA7la2CLVFqaChqtAggtEUVhdz3W3keR7NVQxHyWXnJt
	 DoqqkoEyj0ac7OFuXzBcC9PE8gb8UHXn0wQp4JzLLvLwmELGqiTG81G27B8TuhLr9F
	 eGCZTxE6LmqSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F23AC405E6;
	Tue, 25 Aug 2026 16:55:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 59A9E396
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 16:55:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 40A674004E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 16:55:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QX9qjUdWHnPn for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 16:55:37 +0000 (UTC)
X-Greylist: delayed 329 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 25 Aug 2026 16:55:37 UTC
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=mV/HzLVs
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=83.166.143.172;
 helo=smtp-8fac.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch
 [83.166.143.172])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0655340169
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 16:55:36 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hTv0S6QxXzj3k;
 Tue, 25 Aug 2026 18:50:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787676616;
 bh=SA1yi+xrrFqYaC4ydbnH6AspjY5WcDY0lsDbFKfq5eY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=mV/HzLVsgJgUGxAW3pUg/HPZ1sEnRwLO9vnfPymNxBTFOh2/HLi+vGLY0U3womlLf
 cEXxt99vloYYJbStpnOMqsoObx4AZWcB1XxkIiMxUeiWfDWEmQM3Z/w1V03Nt8UM4z
 VO+0nhbUSLCHSGUu817Uxcs+ejgZBIp5jfhMrKLKaP1kfSN5aeAhHHjaeUWCGcVywf
 4qwxE/SFpGBsTJyF1VvpU3l/oouydmVJEhx6FYKVrYBZi/eSIEGn08KeQ6xuC6fsdX
 x1gwyLcfWx6kywQVhYWAnv1KrYCdNy4UgEm/YsQbkMdKvX5PQeVPt1KtZr35DspYEq
 XNpyq2f1CM56w==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hTv0R2GXwzXx9; Tue, 25 Aug 2026 18:50:15 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 25 Aug 2026 18:49:45 +0200
Subject: [PATCH next 08/45] doc: arch/x86: update link to SeaBIOS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-linkcheck-v1-8-ee7573fe3a4a@cherry.de>
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

http://www.seabios.org/SeaBIOS returns 404, so let's simply return the
landing page of the documentation instead: https://www.seabios.org/.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/arch/x86/x86.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/arch/x86/x86.rst b/doc/arch/x86/x86.rst
index e7bd9205caa9..13d2b2ea9af3 100644
--- a/doc/arch/x86/x86.rst
+++ b/doc/arch/x86/x86.rst
@@ -485,5 +485,5 @@ TODO List
 .. _microcode: http://en.wikipedia.org/wiki/Microcode
 .. _SFI: https://en.wikipedia.org/wiki/Simple_Firmware_Interface
 .. _MP: https://en.wikipedia.org/wiki/MultiProcessor_Specification
-.. _SeaBIOS: http://www.seabios.org/SeaBIOS
+.. _SeaBIOS: https://www.seabios.org/
 .. _ACPI: http://www.acpi.info

-- 
2.55.0

