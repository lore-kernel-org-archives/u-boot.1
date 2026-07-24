Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E4AC531F9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 18:04:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 586A040B97;
	Fri, 24 Jul 2026 18:04:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dDEgu_OGXykN; Fri, 24 Jul 2026 18:04:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7506940B6E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784916288;
	bh=OQWOln7d/nEbkFZhy8CcRxIsuctWvEjnB7bz8fhxsYw=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=b+37AIk/vBoneLj7rS4Slk7SPYCJGGwW1eO1ir6E28kBdK1mJZwEjpteBkNJFXVfw
	 nzp3da+dkFdrI2n6wMOPuxq7JGlTTWms939psSNJNCl+fAZd0jpLrmgcYVCy7LcMeO
	 Gk4gp63bjJAc4igmhdWBkLHsnNFm7roQgNZVuZsVJ09BTLD5dZKq9fwm8/gr/duc8z
	 Qy3Fe5ONeK+YDWXpsYjH4RohMIdrINmsYlAep0jniQIZ0XO6K0OWChEeRcpgmA0XeN
	 pQqirRMJr49GMuenmY63PrqXKEm/5KChxqKjTl6P+2sub1ubNJJ+sECoLM4pVFDdif
	 Bc7NSfaK/k98g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7506940B6E;
	Fri, 24 Jul 2026 18:04:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id ACD2EEB
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 17:09:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9E153400BD
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 17:09:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FxFOtMha86f2 for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 17:09:37 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=me@et1.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9FF2B40083
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9FF2B40083
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9FF2B40083
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 17:09:37 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id A41F6846A4; Fri, 24 Jul 2026 19:09:35 +0200 (CEST)
Received: from mx.et1.uk (mx.et1.uk [116.203.106.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AE3B800AE
 for <u-boot@lists.denx.de>; Fri, 24 Jul 2026 19:09:33 +0200 (CEST)
Message-ID: <9f135129-b2e2-4030-8a72-8c5facf71f27@et1.uk>
Date: Fri, 24 Jul 2026 18:09:31 +0100
MIME-Version: 1.0
Content-Language: en-GB
To: u-boot@lists.denx.de, Tianling Shen <cnsztl@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>
From: Peter Taylor <me@et1.uk>
Subject: [PATCH] arm: rockchuip: rk3568: remove HS400 from device tree
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 24 Jul 2026 18:04:47 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=et1.uk; s=mail; t=1784912972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OQWOln7d/nEbkFZhy8CcRxIsuctWvEjnB7bz8fhxsYw=;
 b=FgiqZCyorrKg7Mhj8pq1MAd9GrQ/4oN9zMY8tWV3Y9JKtgjMDJeOVgSeWP+FYIRbdAHe0W
 BEP/kLDOZYy6no6nNTdDo76lZt1xhFn1889o3J2r1jJdOiKFsRlDQwTihQhrrbiH5u60Jq
 7HauVB7J6KRDxXmCMpWe9YOKWYYqIxQXfEjwIaufF1EV4he2/Fd21VD3PkS0ofUHviKjWL
 GYrLLBOebMA8KjtXDmgyZMqwkgj+xd/SiP5CLbQxwRBjkEm9IGfBwcnIGrsVnzfDXi3+9S
 Nb419VHOGKcwCLYzn/hjt6NzbhexSyT51vt0hKGLBA/ES83GrVftW5/cvpKGBQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=et1.uk
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=et1.uk header.i=@et1.uk header.a=rsa-sha256
 header.s=mail header.b=FgiqZCyo
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=et1.uk
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=me@et1.uk
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=et1.uk header.i=@et1.uk header.b="FgiqZCyo"; 
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Fixes bug when trying to change MMC partition table on linux.

 From the linux-mmc mailing list [1]:

On 22/07/2026 03:54, Shawn Lin wrote:
> The RK3566/RK3568 SoCs only claim to support HS200.

Removing the unsupported HS400 lines from the dts fixes the
issue inside linux.

[1]: 
https://lore.kernel.org/linux-mmc/b01a6658-e575-42e6-9520-e8bb55d0329e@rock-chips.com/

Signed-off-by: Peter Taylor <me@et1.uk>
Cc: Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Kever Yang <kever.yang@rock-chips.com>
---
arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi | 2 --
1 file changed, 2 deletions(-)

diff --git a/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi 
b/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
index 64c43374c04..7e0b2ba02e4 100644
--- a/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
+++ b/arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
@@ -15,8 +15,6 @@
&sdhci {
cap-mmc-highspeed;
mmc-hs200-1_8v;
- mmc-hs400-1_8v;
- mmc-hs400-enhanced-strobe;
pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
};
-- 
2.55.0



