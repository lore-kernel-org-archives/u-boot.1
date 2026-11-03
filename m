Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402FF606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 06:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hkj3CRv4;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d581hzc4
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CAE1080DC1;
	Tue,  3 Nov 2026 06:06:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BqK8Xv4zOWj6; Tue,  3 Nov 2026 06:06:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CB08380D9F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793685966;
	b=IK8n9xy5vBGjQ9dQIFf+o9eyWtfjM4zADzQFhgladPoP4xOjK4JsWOQRNcBi04uDXz8R
	 +nqpu4gChBg0hy9+QCyaEZZlrcFV0Lb2v+6M7+UwgRMEX9dSeIaLeQdxtPHbY5Uwx3ITz
	 kjy0yIk7oWihCK7NOocD50wo74KVegi28D+j86nI/bmP/7P/QUbrOgY6B76YzwT+nUbjq
	 VjKB7qfKrGcTKH2TAmWNT/zzHFl2yBW/bpC3MWcKYmCKDbVv1JBd6+xLEF1qlUQq90lYS
	 qyXWrLdA51O6gtRzZOpcYBjx9b+3KoinwU0vek4y/MoUPEZOZ4bPkG8MM30vJN7Q92w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793685966;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=9eOXoZSvuTBaSJt8+O+RWJ0HUq6TASkcBU02rnG+do8=;
	b=WBzaPORfx93yRz2JKX5PoJSDRPBNRJ0j1x/pgUvr6ySaIFUkxHx35emijGZxF54eYcy1
	 v5IbB9lvVY+2mMdgBgUFV0SOrw+5202GkBfqzRBM0584ok9BZWHVNN7U5Hc7basYtPNY5
	 3VveeCleVwVrqtgCTq6//v8eVsX3BezF8+CI9a/jqWjcbjUeO+xtvoclJxkCCVwEy7TcW
	 UDRF9SLbIez/7nVs/KB+reuyAFkuUdVLGt2otQt7RvWiXw5+Jx6zz+SZYJmb1RlyqYv9o
	 z+8X6LSwF5ti+PHvm8Vl0rPw9uzSGU0zunLDCa1qZ3wnuWbw79vqyAjpPuuVH9jd95w==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793685965;
	bh=9eOXoZSvuTBaSJt8+O+RWJ0HUq6TASkcBU02rnG+do8=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=hkj3CRv4s5UqNQEx/EKV54yCzfhqtzxuFfyZ8u9oe23uADhOYzzhAgAWIaORkB6J2
	 euCM4IjMxZdOMNw4lhWeYTnVT+xKvKVybvQA7hRrnqCZBA+mUgenbbq9FlIcWNmCgN
	 9qheIUmfPHmIvUKr2JtAd3OtTowTayYaViFHdRzQQHNv5d06VS5EF5slfRiDaPUyzw
	 eLjM3upC6OZYyann77FazXkbPk29NeMCjqoklJclAKOQ5NBQANSi+DJ3mvT7HM1/8B
	 r//xYtZtfwzGHDHLP5STVtzqEpct416KKGvM42UHLDoHb5Zp9k6fLYP4Jjs8ai5SeP
	 Mca+6c3o3viiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CB08380D9F;
	Tue,  3 Nov 2026 06:06:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0FA58235
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 06:06:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F1ECD40589
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 06:06:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1BuDT6s9TzAe for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 06:06:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0C2CB4056C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793685963;
 b=U+UIYGY8J5jIRBMi/QjodhCJe0BNIGqk+yfYNMJQj1JoT6nH5wq4mg7dwkVH2vChUfI6
 5YJcV53Wqqssxu/smcZ9WzmnPFoK9MvCChn+s+DKe4tvtPv8qPeokGvbHGb3B2Tdv71lU
 GjCZ8sV2jVYsiccNdOXIRhnHakPk3tUr/8nkMwlAs0a3fDwxQr2o4Msa1Y6xCxt5BhRVh
 DmzQ0bRP1+jBCtvQCn7n4Y2PMTPpT4tcVLy4L1mSsxm7J3ASD5eJtXHrnp3yEP77GK2kX
 6pFYtH0eVu6eWBnYYBAk7Vr6gR0P5Y+FNr8UWQvocC3sHKfTmMKvTespng76z5NxGoQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793685963;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Message-Id:X-B4-Tracking:To:Cc:
 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=9eOXoZSvuTBaSJt8+O+RWJ0HUq6TASkcBU02rnG+do8=;
 b=D+FSjOWkbNzAqjRZErAti5NGdQR17avllQbXms2yv/9xHzmYQDtBOzQSi7KAEmXyiVgO
 YPpeipzrZxjDXEAy23ZXcALRkePXvE3jWHqc40+lwmDwMX0Bvcrt0qSbR5FKxAwr2GG6f
 cWjfOl19r1xXVhcQsnYCe7pHq7iwdDd9wFKREMT7wm1M5w2uLSdNRTemuDpkfwm5AsTu5
 Vp8iMHzyaxqkPhTIFIFfuCyrvZ3qqBfdrtPd5OGZIHAdpOkBFPI28IMACmoUt4Ngu9HVJ
 6GoUqGj9urX74jgQv6BLkgiMW9n0j4gkb+GtiP1UnXKojB20IDH+dMWap9n+Gaf9Hsw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=d581hzc4; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+iav.iav.lv@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=d581hzc4
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0C2CB4056C
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 06:06:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CCE3B42486;
 Tue,  3 Nov 2026 06:06:01 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793685961;
 b=g3vjLGS5TqaCCS4FzMqZguFH7hoBnYDdgIpmyDJ7ypOf2P++3dsXu44qfMkUTMiMAMoF
 tenWce7dS6jLnQRa2XCqY5TkYUFLr1Ti/rp8s97TV9DoUcLUMHHJQgkrxDn+c4JqYuwRy
 DxOpeYMXMoTS0PO+jWyh7TRiSHiZnBsCp2ycHeAJismtCGd0N0NFo0HN/mBLBqFIh2EOH
 yjh9fHfau0PydurtUEn2CmTTWg8dYT5vfmDD+UadsK6ldyPFCSbtxJHlPPKaxIpNUX80N
 Ozn2TvQha+m9CcaDSPUSqU7DtvSZGt4pJucnlV/NgokJOE0+Dg6vbZJX3lm80ThfQgA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793685961;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
 Content-Transfer-Encoding;
 bh=9eOXoZSvuTBaSJt8+O+RWJ0HUq6TASkcBU02rnG+do8=;
 b=xV7EitE2Km14y5tSNc8BLQeCM4DdEj5DNy3cbDd3Aec03fq9GFueuM2Vk4tVCOHVuak2
 wRwFocPu/bA1PhZ1qZkkFh+5NdZuEutrBqj3B+B8Me6JIqOBmBAOnfhsKpkcSVvxQURNz
 SGW/oA30EKCMO++jYbeQ8cUmGGjncwmTHOHeH0u+h6JNjsoE78W3qA3w1iWUDHOT8iUz2
 8luziIzwnumcwhDHYIvyqkVBdyztlS4FS6QXfNo2HixKDvjvILn0E1P590OLQ95uy92R8
 iG0UOicOMeZEq0u79IHWvDj9ag4Mswsi6Sci93J0QqOf5FKRf6aDfs1k3txY0Ze9pZg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 293D81F000C1;
 Tue,  3 Nov 2026 06:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793685961;
 bh=9eOXoZSvuTBaSJt8+O+RWJ0HUq6TASkcBU02rnG+do8=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=d581hzc4BEl7y24hIgQMkGoSZXR2n1MI3T8ff7aWVBAtKxS35mif6WXf7grpbBB7f
 z7AHGeKol2JJGdkQM/j+r4eUFbV35AGPYQv/ml6KQdZXsP6bfKUaKTeaXP58k6KB4w
 ZpwsU3B9FLzkBBvgEwSWWVWNP/QviXNyyQOzgMqBQN5N69byGN7whnW7YnRoSt0Fau
 wTujPrq4mV5YB1S59++eVcCKPvrh7dtyECtfH4oNLqN42bob5OLOShU90LCYZ4tTtB
 DTUU4KmjnhNqbv9RJIF7PWlCnCoUAr1F74DLMWQ9YVkBjyz6p9PyP/ltufE2Hv2pVc
 ud6o8yC5N+PWA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 99A46467C5;
 Tue,  3 Nov 2026 06:06:00 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Tue, 03 Nov 2026 06:05:59 +0000
Subject: [PATCH] rockchip: rk3399-rock-pi-4: Enable IO-domain driver in SPL
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261103-b4-rock-pi-4-spl-iodomain-v1-1-8dfc34a5e2e2@iav.lv>
X-B4-Tracking: v=1; b=H4sIAMZ56WoC/x3MQQqAIBBA0avErBtQsxZdJVqYjjVUKgoRRHdPW
 r7F/w8UykwFxuaBTBcXjqFCtg3YzYSVkF01KKEGKUWHi8Yc7Y6JUWNJB3J08TQc0A+qE167noy
 F2qdMnu//Pc3v+wF17EVMawAAAA==
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Quentin Schulz <u-boot@0leil.net>, 
 Christopher Obbard <chris.obbard@oss.qualcomm.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.u-boot-project.org, Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6346; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=NUk8Wk4P7MMJBvKKkJJQbczvVwvQytZgIODuS5gkBrA=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFkvK49/fvV3BnOmRmXq86OF83UsnjDlt9Tp/VF2zFeqY
 tPoSVrWUcrCIMbFICumyDLhkMatjCVX//p7mD+AmcPKBDKEgYtTACZSVM3IcDk49cDGwDr1sw/D
 bDat38icNjmuV6bp8YbC3y2uW3pmsjMy3PlXMf+JzzfOGw36SULcDHXXuMVbUre+6faNvPhwo4M
 ZHwA=
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

With the SD card in a UHS-I mode, vcc_sdio (RK808 LDO4) stays at 1.8 V
across a warm reset such as a watchdog reset or a panic: the PMIC is
not reset, and the card supply on ROCK Pi 4 is not switchable. The SD
I/O domain resets to 3.3 V, and SPL fails to load U-Boot from the card:

  mmc_load_image_raw_sector: mmc block read error

Enable the RK8XX regulator and Rockchip IO-domain drivers in SPL, and
drop regulator-always-on and regulator-boot-on from vcc_sdio, as these
commits do for the NanoPi 4 boards:

  commit 2abd7fff9ebf ("rockchip: rk3399-nanopi-4: Allow MMC driver to control SD regulators")
  commit 210ab4f60df8 ("rockchip: rk3399-nanopi-4: Enable IO-domain driver in SPL")

Without the boot-on flag U-Boot leaves vcc_sdio at its current voltage,
and the I/O-domain driver sets the I/O domain to match it.

Signed-off-by: Igor Velkov <iav@iav.lv>
---
Tested on ROCK Pi 4A booting U-Boot from SD, with Linux running the
card in SDR104: sysrq-b 4/4, panic 2/2 and watchdog reset 2/2 boot,
where SPL without this change stops at "mmc block read error". With
the card left at 3.0 V (non-UHS DT) cold boot, reboot, sysrq-b and
watchdog reset still boot in high-speed mode. Not tested on ROCK Pi 4C
and ROCK 4SE, whose defconfigs and dtsi are changed the same way.
---
 arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi | 14 ++++++++++++++
 configs/rock-4se-rk3399_defconfig         |  7 +++++++
 configs/rock-pi-4-rk3399_defconfig        |  7 +++++++
 configs/rock-pi-4c-rk3399_defconfig       |  7 +++++++
 4 files changed, 35 insertions(+)

diff --git a/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi b/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
index 4861574636e..7a15f613c99 100644
--- a/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
@@ -14,12 +14,26 @@
 	};
 };
 
+&i2c0_xfer {
+	bootph-pre-ram;
+};
+
+&io_domains {
+	bootph-pre-ram;
+};
+
 &sdhci {
 	cap-mmc-highspeed;
 	mmc-ddr-1_8v;
 	mmc-hs200-1_8v;
 };
 
+&vcc_sdio {
+	bootph-pre-ram;
+	/delete-property/ regulator-always-on;
+	/delete-property/ regulator-boot-on;
+};
+
 &vdd_log {
 	regulator-init-microvolt = <950000>;
 };
diff --git a/configs/rock-4se-rk3399_defconfig b/configs/rock-4se-rk3399_defconfig
index 7f22aede912..dfec68ac4c0 100644
--- a/configs/rock-4se-rk3399_defconfig
+++ b/configs/rock-4se-rk3399_defconfig
@@ -9,6 +9,7 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-rock-4se"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
+CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_TARGET_ROCKPI4_RK3399=y
 CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_SF_DEFAULT_BUS=1
@@ -25,6 +26,8 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rock-4se.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_I2C=y
+CONFIG_SPL_POWER=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
 CONFIG_TPL=y
@@ -52,6 +55,7 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
+CONFIG_SPL_ROCKCHIP_IODOMAIN=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
@@ -70,8 +74,11 @@ CONFIG_NVME_PCI=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_PHY_ROCKCHIP_TYPEC=y
 CONFIG_PMIC_RK8XX=y
+CONFIG_SPL_PMIC_RK8XX=y
+CONFIG_SPL_DM_REGULATOR=y
 CONFIG_REGULATOR_PWM=y
 CONFIG_REGULATOR_RK8XX=y
+CONFIG_SPL_REGULATOR_RK8XX=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_RAM_ROCKCHIP_LPDDR4=y
 CONFIG_SCSI=y
diff --git a/configs/rock-pi-4-rk3399_defconfig b/configs/rock-pi-4-rk3399_defconfig
index e5c9072c27f..fe120db9b8c 100644
--- a/configs/rock-pi-4-rk3399_defconfig
+++ b/configs/rock-pi-4-rk3399_defconfig
@@ -9,6 +9,7 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-rock-pi-4a"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
+CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_TARGET_ROCKPI4_RK3399=y
 CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_SF_DEFAULT_BUS=1
@@ -25,6 +26,8 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rock-pi-4a.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_I2C=y
+CONFIG_SPL_POWER=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
@@ -53,6 +56,7 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
+CONFIG_SPL_ROCKCHIP_IODOMAIN=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
@@ -71,8 +75,11 @@ CONFIG_NVME_PCI=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_PHY_ROCKCHIP_TYPEC=y
 CONFIG_PMIC_RK8XX=y
+CONFIG_SPL_PMIC_RK8XX=y
+CONFIG_SPL_DM_REGULATOR=y
 CONFIG_REGULATOR_PWM=y
 CONFIG_REGULATOR_RK8XX=y
+CONFIG_SPL_REGULATOR_RK8XX=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_RAM_ROCKCHIP_LPDDR4=y
 CONFIG_SCSI=y
diff --git a/configs/rock-pi-4c-rk3399_defconfig b/configs/rock-pi-4c-rk3399_defconfig
index 4be7b0f8130..1a37190d077 100644
--- a/configs/rock-pi-4c-rk3399_defconfig
+++ b/configs/rock-pi-4c-rk3399_defconfig
@@ -9,6 +9,7 @@ CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-rock-pi-4c"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_ROCKCHIP_SPI_IMAGE=y
+CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_TARGET_ROCKPI4_RK3399=y
 CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_SF_DEFAULT_BUS=1
@@ -25,6 +26,8 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rock-pi-4c.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_I2C=y
+CONFIG_SPL_POWER=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
@@ -53,6 +56,7 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
+CONFIG_SPL_ROCKCHIP_IODOMAIN=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
@@ -71,8 +75,11 @@ CONFIG_NVME_PCI=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_PHY_ROCKCHIP_TYPEC=y
 CONFIG_PMIC_RK8XX=y
+CONFIG_SPL_PMIC_RK8XX=y
+CONFIG_SPL_DM_REGULATOR=y
 CONFIG_REGULATOR_PWM=y
 CONFIG_REGULATOR_RK8XX=y
+CONFIG_SPL_REGULATOR_RK8XX=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_RAM_ROCKCHIP_LPDDR4=y
 CONFIG_SCSI=y

---
base-commit: ab4dc5aacf957835c295b59ef2dd28281839cb20
change-id: 20261103-b4-rock-pi-4-spl-iodomain-f6230f4d5eac

Best regards,
-- 
Igor Velkov <iav@iav.lv>


