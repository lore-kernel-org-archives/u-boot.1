Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A41FC3DA63
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 21:16:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E1448865D;
	Tue, 23 Jul 2024 23:16:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mail.de header.i=@mail.de header.b="Y6UFuKvo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CE458811C; Tue, 23 Jul 2024 23:16:11 +0200 (CEST)
Received: from shout01.mail.de (shout01.mail.de [IPv6:2001:868:100:600::216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1D8E87903
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 23:16:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=seb-dev@mail.de
Received: from postfix03.mail.de (postfix03.bt.mail.de [10.0.121.127])
 by shout01.mail.de (Postfix) with ESMTP id 089E5240B60;
 Tue, 23 Jul 2024 23:16:07 +0200 (CEST)
Received: from smtp01.mail.de (smtp01.bt.mail.de [10.0.121.211])
 by postfix03.mail.de (Postfix) with ESMTP id DD1F6801A9;
 Tue, 23 Jul 2024 23:16:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
 s=mailde202009; t=1721769366;
 bh=u1fxtWGVCtmUqVydcfDcuOOIDXd/KgCmIFK8x8vZPnc=;
 h=From:To:Cc:Subject:Date:Message-ID:From:To:CC:Subject:Reply-To;
 b=Y6UFuKvol+jvxnvHHIpD8enLztZzEpf1p9TiuF16b1ONs382Ksa/nrv1fxVxWNJTR
 C4MPH2ayVmjIn6XJd5bBL8dSfcP27l1e5zmpSX4n4XlHTdcx3YpYkL+mDvLm5mIAjs
 /cWG1SNIXecWBx+THNt0pfFF8guihGE/OBR56+vFOkEC2bNvzz0NqEmMwtOnslT4d8
 ALdBIaJda7FHZocna+u1SQULxEh1mBWwDUnutzIfGQgusjgP2AvtRAaZTXzTWZjN/4
 q0avN87NpDOpPBpUVLb40vogqMhG6UUAerSBz0zM30GwlXa1Kd8Wj0yOAsuCTgxLBr
 811GsVVKAxKLg==
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp01.mail.de (Postfix) with ESMTPSA id AA4E32417EC;
 Tue, 23 Jul 2024 23:16:04 +0200 (CEST)
From: Sebastian Kropatsch <seb-dev@mail.de>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 0/1] phy: rockchip: snps-pcie3: Fix bifurcation and spelling
Date: Tue, 23 Jul 2024 23:13:13 +0200
Message-ID: <cover.1721768589.git.seb-dev@mail.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for
 further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for
 further information)
X-purgate: clean
X-purgate-size: 1010
X-purgate-ID: 154282::1721769366-CADB0670-696E83C9/0/0
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

This is only patch 2/5 from the previous v2 patch series since the other
patches are already merged.
The title has been kept the same as v2 for patch management purposes.

Cheers,
Sebastian
---

Changes v2 -> v3:

 - Select only patch 2/5
 - Call 'dev_read_addr(udev)' only once by using 'addr' in 'priv->mmio ='
 - Remove debugging printf statements
 - Collect "Reviewed-by: Kever Yang" tag
 - Link to v2: https://lore.kernel.org/u-boot/cover.1721161722.git.seb-dev@mail.de/T/

Changes v1 -> v2:

 - Add new patch "phy: rockchip: naneng-combphy: Introduce PHY-IDs to fix RK3588 muxing"
 - Collect "Reviewed-by: Kever Yang" tags for all previous patches
 - Link to v1: https://lore.kernel.org/u-boot/cover.1720988760.git.seb-dev@mail.de/T/

---
Sebastian Kropatsch (1):
  phy: rockchip: naneng-combphy: Introduce PHY-IDs to fix RK3588 muxing

 .../rockchip/phy-rockchip-naneng-combphy.c    | 46 +++++++++++++++++--
 1 file changed, 43 insertions(+), 3 deletions(-)

-- 
2.43.0

