Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCB0606A32D
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 09:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=M18Jg3nZ;
	dkim=pass (2048-bit key, unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=CnW6756d
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 03E3C4070F;
	Tue, 27 Oct 2026 09:40:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3cECruh9CQV2; Tue, 27 Oct 2026 09:40:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 36160406CD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793094027;
	b=e8h70Gjv8xTPCZCuOkvz3ZrYn7QOMr9L8aRYLaobAoBDI/L2xs3w6XeKQ9L3H0Db5WHX
	 qQZu3CSROAzQit59ciUlM5ZOj0uF4HmHglklM/ejdCOYD9JUPAVKflq3buWFZ40frQKQr
	 FUMRaJ5wLYKIuitsvVl2wLX+RhdErIDiaWs+PvHGfN+xefqxGSF58Na5H2mqxYYs/f+hj
	 3b/TSmrY0zDX++9GLyQZ+d5VXdmH+Kx3E6n00lNFxNFBok5dBD08iMIdazOxwwcA2DxhN
	 NZAcxPIqJGEFgwXGESuuW3GGzl5vuYm1115uDPRxjq6HjrWT84W6dKqTXPw/yPIHuaw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793094027;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YUVabravkY2knyH9Qz1sPRKNSv+ZUIXuCig4bfdvW78=;
	b=UwzT2xSWditP01bgkWELlnW2Khz6/Bdb+OHIRejq5cFgvlvMLluzkDrDD0ai2Rb13WZ8
	 4xVXJ4R0kgFm41OVZyVdlwA/FvAWN1GshbqUx6KASuIC8Oxv/2/zjbFKc+f319Z1pasHC
	 TLG+/6ryRyn1KyOaaZBEjQv+EFtmdtOAdYxAbDbzSHEDqAj3iTuzdOEn5fIHXcLztfZ3n
	 dnOHBdzPT+dKsN7BhYYAzUFF7k9Hn4QzcS/Thpx1ojGC9pTQWly3ZufrgIriZGPwJSD7I
	 PKIQJyBpBN7uD6s72GjcCSbmzPQV4kzl49zROw6ehubVrHvLSF2MHdzB2BW+YRtKRlA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793094027;
	bh=YUVabravkY2knyH9Qz1sPRKNSv+ZUIXuCig4bfdvW78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M18Jg3nZlcKrwxA6f/5mLJ9sXbl/qz9LOdDW6tqpHVIsCSVXT2T+DLlxvAcqNbGz5
	 k4IhQGfVWp5B2T45Ql/lYEfxbu2mEQCS9jjN01t74Tbb4T/uA6eEOk6oFgTX0VQHXH
	 00OCutWICPPK1E2F2v9ZrTaa/qM7QxDO6C7s4km+W9UzXIfE/wpl/y07kOy+CjbM4D
	 H3nAI0VaC7JqJDP5n98uOo5CtrO+XZ28o8Uc12Dj9eyOT/6lQpxJjEcvQuTqLTGp4c
	 kVygTgJZ+LzDv2+j/oS3TXuqG3jzwp5sjcIwuaEZqIXBYHlY9Etwrqh3xtLKc3aqAn
	 mkZJfUdlIW4hA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 36160406CD;
	Tue, 27 Oct 2026 09:40:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F935380
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 09:40:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 73F1F80BFF
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 09:40:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r7gCMX1xBF00 for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 09:40:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 877D480BF4
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793094018;
 b=PJrzgwTJoYc+wn3uftXJJW6BSjBd5bOagV7ZNHok2Z6Lpn9/GOkd5CLKX3tX7ptkQE5b
 /j/ZjTDLVm6IwVBjyEk7MwUKinUFnZfncevS/ZVxcMrcX8twgww8FxQcksS2IFYNd5G3l
 LTj2h5+dBXlMYLrkw8qYqK49AKD8ptu0YrXvDzJOcREtdtXIcoCM1a7ZIhLYujYOGKM3U
 pxf+X/Q5+4uyBbTVt/doVFKOBbRlAOSqLLKXjAFtGjaAQdIgI589qHfVQ4ExiNKXxLRXw
 g9GiXzkfm55gzAOtMqwYoYMBuAg9SXwBiLL79zuWgdOekQIrhcnI9XDW1fMt5tdNcyw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793094018;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Virus-Scanned;
 bh=YUVabravkY2knyH9Qz1sPRKNSv+ZUIXuCig4bfdvW78=;
 b=ae9i2WH+VMvjA6aKIDPsgJuD+G86bQJGjqcBi6Z+AMzJOPFb1Zkpet+JRwVbehBuWknK
 xrsH0g2h8SsthflTgRdIA+qbHuNtk8TvYqHXwDiS6CPAr8ckQjnSVb2t8rI/0XOspRlYy
 CUAxKFp+SsIQwNQeWb01XedAXW+9NNZrmUC5ucWf8bUhgvLOZupXszzE3H4qIWSi3PztA
 Sg+KUcQfCRXquXUdJkfXKTTbECgz94QNJ3wgGDtQtGbGEtRRdXA50KIefUoOJ3jZcxSWA
 mjx176OYJVMGwvjOpcCtEwlOBqykIwSKRCF9jNXqyW1v+n3muAOwUBH/+t2qh2/iYdA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=ew.tq-group.com;
 dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=CnW6756d; 
 arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=CnW6756d
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 877D480BF4
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 09:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=YUVabravkY2knyH9Qz1sPRKNSv+ZUIXuCig4bfdvW78=; b=CnW6756dRm3XJysB5uBDmCcMyD
 L19pSqmoUp0VeeGu9R7mgGr01qHwF/Zqw4UUo8CuMVja3I+Ttdf29cJ8tsPUHvykErIuI0YowwUwd
 CtCS5c1NiLLuLRPxGfXJQrg9Psru/VKZ9V34jCoGCtOnkj+n2Pl9bM2wzsmeEVZrQNsUf9UgWXz1c
 fyq8BysQV9dgHhdTsKICrq6/2PNTphRFAn+TNNNxNH0P/wz+Nrn+6NC+1PiyFaynDd1n/pJ2tG/4l
 tIX8pfSrYLl8GBqlEo+PrveELtvOxlMoJ1yV/fjddA5zDmYC5iwNpL9gRdKm0XgMaGTbnt+I7HTeT
 4b009hHQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xLdfE-0007Us-1R; Tue, 27 Oct 2026 10:40:16 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xLdfE-00022y-1e; Tue, 27 Oct 2026 10:40:16 +0100
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH 05/16] power: domain: imx-gpcv2: do not unconditionally select
 CONFIG_CLK
Date: Tue, 27 Oct 2026 10:39:02 +0100
Message-ID: <3c045233162584ff5b16427c4aeff177816b7901.1793091394.git.nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793091394.git.nora.schiffer@ew.tq-group.com>
References: <cover.1793091394.git.nora.schiffer@ew.tq-group.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28166/Tue Oct 27 07:24:12 2026)
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

No clock is needed on the i.MX7D, and currently no clk-imx7d driver
exists, so CONFIG_CLK can't be enabled.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
---
 drivers/power/domain/Kconfig                  | 1 -
 drivers/power/domain/imx-gpcv2-power-domain.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
index 40cc30961c0..2915be0fc76 100644
--- a/drivers/power/domain/Kconfig
+++ b/drivers/power/domain/Kconfig
@@ -36,7 +36,6 @@ config BCM6328_POWER_DOMAIN
 config IMX_GPCV2_POWER_DOMAIN
 	bool "Enable i.MX8M power domain driver"
 	depends on POWER_DOMAIN && ARCH_IMX8M
-	select CLK
 	help
 	  Enable support for manipulating NXP i.MX8M on-SoC power domains.
 
diff --git a/drivers/power/domain/imx-gpcv2-power-domain.c b/drivers/power/domain/imx-gpcv2-power-domain.c
index 2fc5bf7613e..f61982df60f 100644
--- a/drivers/power/domain/imx-gpcv2-power-domain.c
+++ b/drivers/power/domain/imx-gpcv2-power-domain.c
@@ -517,7 +517,7 @@ static int imx_gpcv2_power_domain_probe(struct udevice *dev)
 
 	/* Grab optional power domain clock. */
 	ret = clk_get_bulk(dev, &pdata->clk);
-	if (ret && ret != -ENOENT) {
+	if (ret && ret != -ENOENT && ret != -ENOSYS) {
 		dev_err(dev, "Failed to get domain clock (%d)\n", ret);
 		return ret;
 	}
-- 
2.55.0

