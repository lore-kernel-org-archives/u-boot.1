Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DE5CA9EBD
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 20:13:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 71C6B40642;
	Sun, 11 Oct 2026 20:13:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dNJLtNl7z80u; Sun, 11 Oct 2026 20:12:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 583C740629
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791749579;
	b=NuGDdAjWrgQulDatMFRefEmv/7m+jSTXOgWV7Z+X+lB1yu9EZdEqOOgOw4SK1i+UqgwG
	 7AjtbOf2RHBZaQDs2b9eelFs1n9vqdXhwuPoBbcP4q2C9oqN5uUBimxw9E+VCKELS1+4c
	 aC3insfoV4vca+gbJgjmBJgWw5jU7Jy4X/jVoVVO7Gu2zeMwzK7VEDb11IzXeOnNlX4nP
	 k6SLIL3RBuUZp/Vb3j/mCCXWpRG2OVKczLAzPXT4XHcl0hO3l1s3uvz2ZtfYvXes7KSTT
	 tED1iqXK/EDx0cyJpAyB9I+37/zIcIXbQP78hyTJ1mFMoa5BR6+wsy8ElZ3v36X3u2w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791749579;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=+4R02DwTD4OIbk7l3zR98/5aoXAv4L5HegKyc6cgtjk=;
	b=XGagy7LqDvwqQTJ9H4FrQh0TmqPoGuFgBmz1Z18j1k4A5NkZzrSLtOdxTh+DSGxhv+U0
	 TukwyA4pl6ET0+U3LYQfos8vBdJXhCa7daLhyqwv1gfQSBfGmHZ6Ojq3CE4RMH0RCA0AX
	 9Pd43Pgsjlh8BDMwFMSqj5/USyOtyyfdEqnqAMoj4nMtBzRv2/XgXphFiO5eRIc56g37a
	 Rrsg/OhobOQjJ9p+t8H4mWqiJJ0QRW3/OYkuXcLQ4HxIvg75gynzpi0qCWgcrxjCWpk6u
	 Cgw4wEckIhCcB63cVpxDGGk14kOEZL4LP8VzcksvwnOx9ibPSVlw8xyqfsVOl+NLYGw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791749579;
	bh=+4R02DwTD4OIbk7l3zR98/5aoXAv4L5HegKyc6cgtjk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=MTQyf+InP9Hmfirnm5zoS2Q9z6S5my/1Nbi/rrWxQQu/Txohrm7j12ap0uJLgp8+p
	 37jVGn0lTNifnf4vjJs5dvQMxSFZ1xtuHtzhMOAQiqHmYThf/TC1gFWyUVMbZNEvn2
	 +BqT3eb0g3LpPALFbHi9yYeVqR5nQ5z67mIw+UrTU3iFCEKOfnpMq7QrvwUCNya9rx
	 TDttxqf9qzDbWz1SkiNgVx4mS07+NjRJIF5sln2pCx70OPCxM3Mw0qYW3pWVrXh8Eg
	 k5kyKzanOhZNpug6ncpXYsZMfELxJ+PDbcdW/PKWlXGGOzNToKHb499pKAwHi3oEUg
	 6vw0hF+BUsjfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 583C740629;
	Sun, 11 Oct 2026 20:12:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 04D5A1A6
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 19:35:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EACFF6061E
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 19:35:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K8doAM-348b1 for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 19:35:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 02BE26060E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791747351;
 b=nyDniJaMtERQErbRKYm/Wpr3kAGvknI8S9NQXUQ89CZwybO9hSRUSBnXM00QURd5MNyx
 5rmxtjrvbu5YZ/zVRnYFslEUoUs7x/9nst9YPbs/iClEHAXnPAgesxS1tm2Roi1cq6Usq
 iYQOeSvT1ZoM+UErBv6VG/yJBF/+d3Pk8Zz+p0/UWUK+usydK8glMRIcKPiP3mbuCg7oI
 ODnNnyel0NWuCx9IBNaCIxrxJ73iAEm1fJnGEKdv9Db+fvViAVRglGMsCIN4NRhus5fQH
 QoOWB0y8D37qmyJuSi8wkDHlQ+4O1OzSnRh6zG96v5SIN40q3q4CBEDu8GeimNTu2UA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791747351;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=+4R02DwTD4OIbk7l3zR98/5aoXAv4L5HegKyc6cgtjk=;
 b=aOG8A8Qu+X1OtjdtAw25i73WYW8k2qJ0yM9fmdc1FnQUbPMGCf8UlkMmFNJXA8+E1Va+
 zI6diopCn62O/1K6mHq6v0PtBwS2FpuGQPXbpPQ/pTls810O9cS0ufv52dtS+zZ0dA9Xk
 Jv94mHlwfXznW51C38P2liH3223i+B5nkVgFaXzOSpgKvBMqzeoKM1CUvHkOkJPUH+1a+
 iclY2CpH2r+8llPJiJgovOqgb0P1N1B6uh3b0tX6nzzQwPmbekalvkpQL5BuyFxpm4qlD
 o97pkALHe+7G0vF0kRw9LQjnCCU2iY+/jRA1LhUy2OopvzuH9zDnM41V1xzKyvIRYhw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=EPgBsSey; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=EPgBsSey
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 02BE26060E
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 19:35:50 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8BC9C43CDB;
 Sun, 11 Oct 2026 19:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B988C2BCFD;
 Sun, 11 Oct 2026 19:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791747349;
 bh=aOiy0egEV8GM0r5a0GZnv0xGUAfMtzWVmxF8Mm5m2PA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=EPgBsSeygsLgmDWwRuwc6w/jJQ3qEiHzJCWEKB21L3Wd54AlNGznOu7VTZzKqLiIO
 2qUDEnkjeq9/7ADwGP2JJLVyf7dRwANsdbMa5GZDQh9gMsMmtPJ5R7XaBtQtk7MHIM
 /cfy+HJTGIthCOkrODIVFPwig7cjau8KQaS6EiuwmTUv69oYr8qHcBw6HSVlHNwVKj
 aDLei4FPPaveru4cJmVuvTQuR0Mb+7UrfKkqEtjjKzfUWsay5S3OmxIa99SbRTKqxK
 rFGQCH0I39l/OinAYFIvtAUr5s3gk0/oYKamopCvQ43BaPNPinoghLKrHClm1Fg4zV
 0ojq8EMIV1MIQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 58266CA9ED3;
 Sun, 11 Oct 2026 19:35:49 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sun, 11 Oct 2026 21:35:46 +0200
Subject: [PATCH v2 4/9] video: rockchip: dw_mipi_dsi: account for burst
 mode in the lane rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-b4-pinephone-pro-defconfig-v2-4-6b7be35fbee7@protonmail.com>
References: <20261011-b4-pinephone-pro-defconfig-v2-0-6b7be35fbee7@protonmail.com>
In-Reply-To: <20261011-b4-pinephone-pro-defconfig-v2-0-6b7be35fbee7@protonmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Peter Robinson <pbrobinson@gmail.com>, David Heidelberg <david@ixit.cz>, 
 Ondrej Jirman <megi@xff.cz>, Tom Rini <trini@konsulko.com>, 
 Petr Hodina <petr.hodina@protonmail.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791747347; l=2791;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=55ZJhhJdUuVFaftrDXmUm8u9CiuNcYH0bDSCxuumNx8=;
 b=0OEV/xHVr5A/TtG9XRI6wYEpVUrYfKusps1+DLSSDndhGSv5nLufx7uT16voEDwL2JC0S2rm+
 m/zzvjUE/gSD38n6kVbM26o21Xso7jYB73xTXowf6E0AaqI7LnncRjb
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sun, 11 Oct 2026 20:12:50 +0000
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
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Petr Hodina <petr.hodina@protonmail.com>

Derive the lane rate from the pixel clock, bpp and lane count.
Add the 20% burst margin when the panel uses burst mode and fail with
-EINVAL instead of carrying on when the rate exceeds what the D-PHY
supports. Pass the computed rate to the external D-PHY helper
instead of a pixel clock based approximation.

Unlike the mainline Linux driver, which adds a flat 25% margin, this
only adds the margin that burst mode needs.

Based on megi's 0711c54e94c ("video: dw-mipi-dsi: Sync-up with
Linux driver"), https://codeberg.org/megi/u-boot

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 drivers/video/rockchip/dw_mipi_dsi_rockchip.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/video/rockchip/dw_mipi_dsi_rockchip.c b/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
index fa512173510..c47992dfb13 100644
--- a/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
+++ b/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
@@ -526,8 +526,6 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, struct display_timing *timings,
 	struct udevice *dev = device->dev;
 	struct dw_rockchip_dsi_priv *dsi = dev_get_priv(dev);
 	int bpp;
-	unsigned long mpclk, tmp;
-	unsigned int target_mbps = 1000;
 	unsigned int max_mbps = dppa_map[ARRAY_SIZE(dppa_map) - 1].max_mbps;
 	unsigned long best_freq = 0;
 	unsigned long fvco_min, fvco_max, fin, fout;
@@ -544,30 +542,28 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, struct display_timing *timings,
 		return bpp;
 	}
 
-	mpclk = DIV_ROUND_UP(timings->pixelclock.typ, 1000);
-	if (mpclk) {
-		/* take 1 / 0.8, since mbps must big than bandwidth of RGB */
-		tmp = (mpclk * (bpp / lanes) * 10 / 8) / 1000;
-		if (tmp < max_mbps)
-			target_mbps = tmp;
-		else
-			dev_err(dsi->dsi_host,
-				"DPHY clock frequency is out of range\n");
+	fout = timings->pixelclock.typ / MSEC_PER_SEC * bpp / lanes;
+	if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
+		fout = fout * 12 / 10;
+	fout *= MSEC_PER_SEC;
+
+	if (fout > max_mbps * USEC_PER_SEC) {
+		dev_err(dsi->dsi_host, "DPHY clock frequency is out of range\n");
+		return -EINVAL;
 	}
 
 	/* for external phy only the mipi_dphy_config is necessary */
 	if (generic_phy_valid(&dsi->phy)) {
-		phy_mipi_dphy_get_default_config(timings->pixelclock.typ  * 10 / 8,
+		phy_mipi_dphy_get_default_config(fout / bpp * lanes,
 						 bpp, lanes,
 						 &dsi->phy_opts);
-		dsi->lane_mbps = target_mbps;
+		dsi->lane_mbps = DIV_ROUND_UP(fout, USEC_PER_SEC);
 		*lane_mbps = dsi->lane_mbps;
 
 		return 0;
 	}
 
 	fin = clk_get_rate(dsi->ref);
-	fout = target_mbps * USEC_PER_SEC;
 
 	/* constraint: 5Mhz <= Fref / N <= 40MHz */
 	min_prediv = DIV_ROUND_UP(fin, 40 * USEC_PER_SEC);

-- 
2.55.0


