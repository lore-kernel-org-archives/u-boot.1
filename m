Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0787CC6B1F
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 09:20:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F01BD80D2B;
	Wed, 14 Oct 2026 09:20:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TLq800s2uivb; Wed, 14 Oct 2026 09:20:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DC0E680CC2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791969608;
	b=QVNZEikTQA87gABdT2mG/1+PNot6qDpCvxyoh5rTgz1xYx376hIYFwWr0KC+bvVcxcjy
	 SLKMMdYADUJ4f6F+KWdkQEpsCo2gCPFV/vDA7kh+qJlsvzGv7n0IH8r3ZOMl2fsqRh8mR
	 4NXOLZwPkEudYpa+Q+B1++H312BInhbNv9Vy/MJCcZM7dXlDC92ZfYLnKOVTlGBWzoAMT
	 GcWa9kVPFMeE2NyVrmOS8LrpHH2GV+KOgKswKtpslPtJf5MWZHaAPh6wMUVGH8nVp6DO2
	 V0FlQreXCvOrbD1ES2lezYuLGOQ7Vh4ja+GQiHpQdE6iiLBMOLvn7NvK2P7B5uwmnvw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791969608;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:X-Debian-User:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=s2m5WjIFcr/q5o/PbQroWqtttM+QyuZjHso4A77WorE=;
	b=DS3IT0y4wWNZfwRGoRHbuIiy77Z57wzrOSpAjIs2H0FPn8R6wO3Mu948aUSZYzHKgW9w
	 lKkNBQdF9l8gjljBPG/FWiPiiU1FB+9jBsHWSYO6QHSMNBpyHKSVxM9G6pL4OtzM8AAK8
	 FxLVCNwQpX0+ezsFywCSByCEQNbmn0U3MduRn2hEnXI6hkUfts6/+h+yjz2Y9/K1GPUPA
	 4UF4iI5sBnfNeuiVT6VRX/ecKORBvn/Qfi3Wra5yHzW6J+QIGPbpy9nt3Yt0ELBE3XKgS
	 cLdQbAh2Nym2hekMSs9MByQijRN2qu7X8m0t2akszzbeC7k0U4Ux1vSgPRhNnu3V2Cg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791969608;
	bh=s2m5WjIFcr/q5o/PbQroWqtttM+QyuZjHso4A77WorE=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Fo3hP4sMoT+wlxLIV3hHd72egOPsqIlj8vjBVQ7wT0UW351DHIM8MuKjm1GjKOHCX
	 blRmnke18jl52/B6P7/07nnAfTd0acv+84E46npYIZIlUNBtLtPK/wLGRS2SNTwJP6
	 h03HtpxTDPx3cEwSloK0tLwIoEWut67sXjBEQcPvnEmD3JltBiFUxmd/Q1lf0bTPJP
	 iclCgt6zmu/UyKSffMYpp+PSyoWRiGbgG7CVlFQ6gM9KHX2NaGaDDiQY/q3vZfTWUr
	 iNedj/wJ1GAIKtZ5gpllKpvxbr9tt7sL7x/NeVl+BxS+X5jGcwHggLmsoEL91aXywb
	 lNcNCfytUi4EA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC0E680CC2;
	Wed, 14 Oct 2026 09:20:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B23E235
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 07:46:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E5B9F400CB
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 07:46:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8iIoDPLp-pGJ for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 07:46:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E183340079
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:41b8:202:deb::311:108"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791964017;
 b=e37SOhAt67up36QL2KzfhR/FK//iwIZjjhTo0wHxrw7wAtpoKtJBWDkRLHvZQuj+GPmY
 p7Bvw0+15EI1qGWPpCEhE1EvvooIkg20TE60jbewf3tgjmB9lxdYNc1+iEnmxiSMvxyAu
 AhGqOjNYqefVBVvLB5GCAucAq9QWPTsTwVUjLXG+i2023sgvb1VR/973MsyAy4VPCubu3
 iypfMu81v3EGndK0XdFfn9meD10jXvgV1Dq7EKPhNWKqVm3O8MHoB1ng4rrU6G3X8ofeB
 nvT2Cx8U+dMb9cvOXA6il1DC54WYWOLwz2F/Q6y1A+kKolW8vljobHp5xstMkKXu/Cg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791964017;
 h=Received-SPF:Received:Received:Date:From:To:Cc:Subject:Message-ID:
 MIME-Version:Content-Type:Content-Disposition:X-Debian-User;
 bh=s2m5WjIFcr/q5o/PbQroWqtttM+QyuZjHso4A77WorE=;
 b=JVw11f8w6fHz9LZK94KdFviKmLtGfxDApF8tIvkM23If/DcPmGQBakfYmD3z0j22EUI1
 1xh4yuH3ZoaQuLEcv03+G1IwckC2RRul+z5qYUhICv3MaYDcOrCUzn+G/aWx3APz/8zFu
 ZbJZfYPHIp3pFynw1/3idDyMB2d/mdKMQivrfmOf+CaqtvM0nsCnJOW72cef1hSGgc+eM
 GRRs1e8aJND8hxnyZzClW7bQ053iqy7CbJUzD7vkv/zzmPQIIjJGh9ug0DBQX1IkCebzy
 r/9IjMcWrW0nNL7kRhpOON5A9566MXw9L+LUi2V/+9af+Wy2vLjKXYOxD6EBpFVylXg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=fatal.se;
 arc=none smtp.remote-ip="2001:41b8:202:deb::311:108"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:41b8:202:deb::311:108; helo=stravinsky.debian.org;
 envelope-from=andreas@fatal.se; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=fatal.se
Received: from stravinsky.debian.org (stravinsky.debian.org
 [IPv6:2001:41b8:202:deb::311:108])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E183340079
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 07:46:55 +0000 (UTC)
Received: from authenticated-user by stravinsky.debian.org with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.96) (envelope-from <andreas@fatal.se>) id 1xGthK-004Fko-1k;
 Wed, 14 Oct 2026 07:46:50 +0000
Received: from m1pro (194-218-217-50.customer.telia.com [194.218.217.50])
 by pi.fatal.se (Postfix) with ESMTPSA id 1E9E788;
 Wed, 14 Oct 2026 07:46:48 +0000 (UTC)
Date: Wed, 14 Oct 2026 09:46:44 +0200
From: Andreas Henriksson <andreas@fatal.se>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH] lmb: enable LMB_LIMIT_DMA_BELOW_RAM_TOP for ARCH_IMX8M
Message-ID: <6hnbarafo7qy56l23qwzcbzfm7v5liabgpnd6t5i5sbinmxqhs@6aggwhpwx5cy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Debian-User: ah
X-Mailman-Approved-At: Wed, 14 Oct 2026 09:20:05 +0000
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

On boards with >3GiB ram, we can end up with transfers above 4GiB
which is not allowed by SDHC driver.

fsl_esdhc_imx.c: esdhc_setup_dma():
	if (upper_32_bits(priv->dma_addr))
		printf("Cannot use 64 bit addresses with SDMA\n");

Tested on Toradex Verdin i.MX8M Plus SoM, where bootefi would not work
(with systemd-boot as efi application) and print the above message.

Signed-off-by: Andreas Henriksson <andreas@fatal.se>
---
 lib/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 021a82d4709..a5f2e3e1058 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1371,7 +1371,7 @@ config SPL_LMB_ARCH_MEM_MAP
 config LMB_LIMIT_DMA_BELOW_RAM_TOP
 	bool
 	depends on LMB
-	default y if ARCH_BCM283X || ARCH_MVEBU || ARCH_ROCKCHIP || STARFIVE_JH7110
+	default y if ARCH_BCM283X || ARCH_IMX8M || ARCH_MVEBU || ARCH_ROCKCHIP || STARFIVE_JH7110
 	help
 	  Some architectures can not DMA above ram_top boundary,
 	  which is after 4 GiB or 32-bit boundary too. Limit the
-- 
2.47.3

