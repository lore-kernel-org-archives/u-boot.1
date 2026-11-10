Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB5260A380C
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 04:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JRmZWnxm;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JUB0OGr2
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0EEB98101F;
	Tue, 10 Nov 2026 04:30:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QOLvLylm1Jqs; Tue, 10 Nov 2026 04:30:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 44AA58100F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794285030;
	b=rvmJ3chHLQshlmDAcFQunwVlX5T2NZ0y8KwioAI/LbmIkXbPdtILV3d/CMRTs5cGkGjd
	 dpaXfOmuyDsiWFS9OhC3dD13Bm+8NSC1xFr93gDeNqNxwpPPoolpxUeusAFVdyUzzOvHx
	 OBqXxpbl4geb0C8IcK6vH/4/riC8/gqDjhIS23X13lgNN0eUHARwh9r2R7muk8WCE9/cs
	 Hscg+68DY2QY3BPLnHGwAdDpU6m//XnT1HP7hmfg6pyyZkfZPcs1BxjFAK2HrUipDrsb4
	 mz8R4OkVjuWUdAfseq4y8rppzAzJ3npe4ymFviShmG6oQ6fMrgtnNBbwu0Nw1kUmScA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794285030;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=nIYITo4F7M8tSiG6N5zsjnN4pWN3v8PKwZNx6uBLeQs=;
	b=V83823LbPP9n71oVT3KdWPamhA3EXONZ8BsaqJoQSYxxuJ/i9rFbR/d3yKfoAmyY3jat
	 2APBlfTrS86ngmhvduahMYcGi8dCNGZq5sjRzimE2d48zdb0/LdA609/u/8S9FYmFKcle
	 r9lxlpMR3T48djLQDpyz0cFOse5lASOpHIUzi5VmKQTR/4NN+Fui2o4ypHthlkXtjXjeC
	 IMXkWXlVkSil+6dNK6lFWJCHjIYrZRkc2wf6P9Y3cKhmxdw7Dr/vhi4FL9+jomWa3V74H
	 v1ckNrbvCBpVmIJwaqdvjAOE+ytUcVTVNbj4Zf0Zf0xndNKYIcyjN5SbY0dcTD5tSAA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794285030;
	bh=nIYITo4F7M8tSiG6N5zsjnN4pWN3v8PKwZNx6uBLeQs=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=JRmZWnxm0RFW3y0xDjlgEU7cS/6chi/FqAer8Mu5jxv9/IjSKa7ZH89MDOcWPRDIY
	 NZojJ5oujRBHGazrCkBVGvCip/BCBHgpzxSaDvpopEl0cAyoCOsGUdU76bzIY5gmkN
	 52xOtIFHHbNCzYibYACEHMsru1eoxy3SxhpOFOQ8Fs92AolxEPNxNE6bTVJE9+LWAq
	 AEYzL/fNiKY6MtAfGx3b5DwqHuaR0h2ObkedVeWpNMs9MZsuOCYVgLCoro8zGJSgpc
	 rg99kBsbr96BjQ1BMvcYdjZAVqdERayOukrI93Hcxi+yJVHw8dZfz2oJ1H7TESYGC3
	 daacJ73cLuhIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 44AA58100F;
	Tue, 10 Nov 2026 04:30:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E99D231F
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 04:30:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DE799607FC
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 04:30:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8yPMDwieNwpg for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 04:30:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2D5CD607C2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+iav.iav.lv@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=JUB0OGr2
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2D5CD607C2
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 04:30:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 00C624691B;
 Tue, 10 Nov 2026 04:30:27 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 45BD91F008BD;
 Tue, 10 Nov 2026 04:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794285026;
 bh=nIYITo4F7M8tSiG6N5zsjnN4pWN3v8PKwZNx6uBLeQs=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=JUB0OGr2/WqY3JiZm/ivkYE3oPYUjdWSzUVFSjRDkxqK43U1S/EU8v+k8f3/zDXKB
 7scP9SItS3NXw/oDoaEBoNrmmaOK1cq13M8kujIEUaQpn+6n0qTqkqfUFYDvln0Xln
 TdQvMlZRy+CW4u/yj9YyXp8o4VKovVVCtFjfBAnMB2KBlg/ys8pbx1EehqQhehnXKv
 F9R79A2KJbrv2kXeD1idaZmSXBmHQdUoEo1AxvH0UlnXY6yBvllB8HIvftf/3Il3Op
 c0KcDGu7kz2k0/sXlu7qsYjsUZscCsYeWkmSMzLfDdTBYU2ZvGYl0DH74uE7qX/89t
 0343fnKIP93Qg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id C7B39487E1;
 Tue, 10 Nov 2026 04:30:25 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Tue, 10 Nov 2026 04:30:24 +0000
Subject: [PATCH] clk: rockchip: rk356x: Set twice the SD/SDIO card clock
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261110-rk3568-sdmmc-clk-v1-1-482eeb42f571@iav.lv>
X-B4-Tracking: v=1; b=H4sIAN+d8moC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0MD3aJsY1MzC93ilNzcZN3knGxdS9Ok5OTEVHMjI3NzJaC2gqLUtMw
 KsJHRsbW1ANN1e+hiAAAA
To: Kever Yang <kever.yang@rock-chips.com>, Quentin Schulz <u-boot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@nabladev.com>, 
 Tom Rini <trini@konsulko.com>, Elaine Zhang <zhangqing@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.u-boot-project.org, 
 Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3285; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=R2OKm69sEn6Alznt2gmTcH5ZSpX61IlnRP6pIL+WazA=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFmf5j5I7Vh+ziZF11Lp3h6ZSPlkUT2l5QuUjn2q5Vj8Y
 gc/p/rijlIWBjEuBlkxRZYJhzRuZSy5+tffw/wBzBxWJpAhDFycAjCRNe4M//PiT7768bac/ezU
 M+vnM/zebL9GNml1xP81eS6Nma3TvJQY/lklpr0M07OXqRJQCj7kduD2uceXbul1rO3iuiFafaX
 jISsA
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: iav@iav.lv
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Igor Velkov <iav@iav.lv>

The dw_mmc controllers divide their input clock by 2, but
rk3568_sdmmc_set_clk() selects a parent equal to the requested card
clock, so the card runs at half of it: 25 MHz instead of 50 MHz in high
speed mode. The RK3399 and RK3328 clock drivers already set twice the
rate for their dw_mmc controllers.

Select the fastest parent that does not exceed twice the requested
rate, or the slowest one, and report half of the parent rate.

On ODROID-M1 with a SanDisk 128 GB card in high speed mode, reading
512 MiB with mmc read takes 22 s instead of 44 s.

Fixes: 4a262feba3a5 ("rockchip: rk3568: add clock driver")
Signed-off-by: Igor Velkov <iav@iav.lv>
---
Tested on ODROID-M1 with this change on v2026.07: CLKSEL_CON(30) selects
the 100 MHz parent for a 50 MHz card clock. The CRC32 of a 512 MiB block
read with mmc read is the same at 25 and 50 MHz, and the CRC32 of another
block is the same as computed in Linux. With the SPL erased from SPI, SPL
and U-Boot load from the SD card, also after two resets with sysrq-b.
---
 drivers/clk/rockchip/clk_rk3568.c | 43 +++++++++++++++------------------------
 1 file changed, 16 insertions(+), 27 deletions(-)

diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
index 181917cf92a..06d7d4741c6 100644
--- a/drivers/clk/rockchip/clk_rk3568.c
+++ b/drivers/clk/rockchip/clk_rk3568.c
@@ -1426,19 +1426,20 @@ static ulong rk3568_sdmmc_get_clk(struct rk3568_clk_priv *priv, ulong clk_id)
 		return -ENOENT;
 	}
 
+	/* The card clock is half of the parent: dw_mmc divides it by 2 */
 	switch (sel) {
 	case CLK_SDMMC_SEL_24M:
-		return OSC_HZ;
+		return OSC_HZ / 2;
 	case CLK_SDMMC_SEL_400M:
-		return 400 * MHz;
+		return 400 * MHz / 2;
 	case CLK_SDMMC_SEL_300M:
-		return 300 * MHz;
+		return 300 * MHz / 2;
 	case CLK_SDMMC_SEL_100M:
-		return 100 * MHz;
+		return 100 * MHz / 2;
 	case CLK_SDMMC_SEL_50M:
-		return 50 * MHz;
+		return 50 * MHz / 2;
 	case CLK_SDMMC_SEL_750K:
-		return 750 * KHz;
+		return 750 * KHz / 2;
 	default:
 		return -ENOENT;
 	}
@@ -1448,34 +1449,22 @@ static ulong rk3568_sdmmc_set_clk(struct rk3568_clk_priv *priv,
 				  ulong clk_id, ulong rate)
 {
 	struct rk3568_cru *cru = priv->cru;
+	ulong parent = rate * 2;
 	int src_clk;
 
-	switch (rate) {
-	case OSC_HZ:
-	case 26 * MHz:
-	case 25 * MHz:
-		src_clk = CLK_SDMMC_SEL_24M;
-		break;
-	case 400 * MHz:
+	/* Fastest parent not above twice the card clock, or the slowest one */
+	if (parent >= 400 * MHz)
 		src_clk = CLK_SDMMC_SEL_400M;
-		break;
-	case 300 * MHz:
+	else if (parent >= 300 * MHz)
 		src_clk = CLK_SDMMC_SEL_300M;
-		break;
-	case 100 * MHz:
+	else if (parent >= 100 * MHz)
 		src_clk = CLK_SDMMC_SEL_100M;
-		break;
-	case 52 * MHz:
-	case 50 * MHz:
+	else if (parent >= 50 * MHz)
 		src_clk = CLK_SDMMC_SEL_50M;
-		break;
-	case 750 * KHz:
-	case 400 * KHz:
+	else if (parent >= OSC_HZ)
+		src_clk = CLK_SDMMC_SEL_24M;
+	else
 		src_clk = CLK_SDMMC_SEL_750K;
-		break;
-	default:
-		return -ENOENT;
-	}
 
 	switch (clk_id) {
 	case HCLK_SDMMC0:

---
base-commit: ecdcf9e365df6249a57cd8cc946e7026804ff4ae
change-id: 20261110-rk3568-sdmmc-clk-95bccae72277

Best regards,
-- 
Igor Velkov <iav@iav.lv>


