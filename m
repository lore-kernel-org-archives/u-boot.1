Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548E7C0218D
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 22:50:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CDAE80F98;
	Sun, 26 Jan 2025 23:50:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="mymje9o8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF20580F98; Sun, 26 Jan 2025 23:50:01 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B2D480F10
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 23:49:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ca7d=UT=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1737931797;
 bh=h1Cth1cPoUfUykUCuosRuN2noPH0ChkCdUP68IERh+s=;
 b=mymje9o8+P3gBrJv14dHSHjWGeiaDmRV5XJHp94c4vpONknDX6laFkc1/TmRfhjUKOfwQwvdv
 HEl3DE8JrbPNCWjS5isk30c9o8Vjqah016WNwvrRWjYyyImlsULWccz2jmlNj31oHG4NVCvifWz
 MDhQ4IGnt5qph+Vzk0+soeYNU9PxSP2AOptMwsbarH8Cos/5Dpy2aGtjFzis2Ehjvf7uZ846YdL
 /DTzMTosdTuPouG/aoOqDf+dW1bRJvccdP8BuETI5jV292UTjFt4aylEtkVRGWzj9Hb91ms54uY
 6g0wrcrACZ+BQmoO3fNSH0SkHGtXNnLE2oTHJyAtqf6w==
X-Forward-Email-ID: 6796bc114079df9fc6c0d002
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
Cc: Heiko Stuebner <heiko@sntech.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 0/3] rockchip: sdram: Fix issues observed on RK3576
Date: Sun, 26 Jan 2025 22:49:39 +0000
Message-ID: <20250126224948.544633-1-jonas@kwiboo.se>
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

Most Rockchip AArch64 SoCs have start of DRAM at 0x0. However, the
RK3576 instead has start of DRAM at 0x40000000 and can extend continuous
beyond the 4 GiB mark.

This series fixes issues observed on a Rockchip RK3576 board testing
Heiko's RK3576 series [1].

Changes in v2:
- Drop duplicate patch
- Add patch to limit gd->ram_top to max 4G
- Add patch to assign gd->ram_base in SPL
- Collect r-b tag

[1] https://patchwork.ozlabs.org/cover/2013854/

Jonas Karlman (3):
  rockchip: sdram: Allow the first bank to extend beyond 4 GiB
  rockchip: sdram: Limit usable ram_top to max 4G
  rockchip: sdram: Ensure ram_base is correct in SPL

 arch/arm/mach-rockchip/sdram.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
2.48.1

