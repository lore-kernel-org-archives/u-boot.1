Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F07CA5FE2
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 05:12:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 262B680DC7;
	Mon,  5 Oct 2026 05:12:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ya9owMOxuVsk; Mon,  5 Oct 2026 05:12:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AFB6680D86
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791177176;
	b=YM8msxZ4xWHk1Ivob+jx0u9L11N28mfArJMnU0piFw7z2CBtsXN1DG5fFvGBTiAi2ywE
	 TD1est0TFOUIHLBpn0+uS7snsq7wlevE7b7cWsyjT3Lj1/jBdd+ugutDK8aUNDn3cY7RJ
	 WM/cBPRWATaUicLYFJvNrBGyoJNxiORMJ5HcrcJDAjXjobhAXeWiYi9wFc44VG8nRQqnk
	 eSpIrUoXRRTp7ASkmn3IJ9QRqSuW5ziyFsWYCIm9zEnIe+Mu/12x7fV7kcLlaS5eKV6XQ
	 yduM6kGlqUDeyyKS8lttDZsrpbttpwLjtywAJTCNQFBlysndsecOAGrIclwOSxbUlQQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791177176;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=wPtPK2a5WuTo3m4F24TjicBPD3suBQpLO+2VKfL+KoU=;
	b=FOCyi0FUm1yvR5vlT245fjhEtvrXzmY7QT+ORE1wb7RM0Bcvie7r3u0l48nF4kl7CiDt
	 vWNXwYZXd7D8WiYnwLsJBdTeespAMqJg6cRb01wDJE5fYhX5kzQCfbBe2ehADhA7wt+1n
	 3opp7M0Gmzl7pxQ8/nwGTBqfrkFx7j3pIvuM5JCT3dbXZURAK5HqTh17jYBJfgUy7gSR2
	 sSwnYvQvx5cz/YQFv5ctXLMg5sBqgBZEHh5vDg5LRpPG0MtsjU6+K+AYPZoC4uaGEz/R/
	 /Jz9wwqA7eWjjA5PzjpJKLJEPjNv4yF0/REL4lBJbGJ6gqu8L/JM/b/0QjJzPzmCAlw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791177175;
	bh=wPtPK2a5WuTo3m4F24TjicBPD3suBQpLO+2VKfL+KoU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Ep5wjcv51qRh21MRPbt/9xww3Pw5dUQTtMbFgsxoNEbxoCMtlJEyrJ5fb5oDlycXG
	 wpeb9ur77jd+6uIJosybb31HmJcP11qwoGcD4dOO/V00n1YxeHINvycNDy0nUSCMnM
	 ln3NHaxrctOmrSs5b9l/F7etxoaXRfbx6HAqBVJgDb2385vFJHBqLgZZFwhMNY2kOn
	 vHtycHyX/WlzY5dhaLicpPs6UqdakYWSkoE/aXMnZpbOxLq8QH3vMpFYK7bgUrV6Wf
	 Y8qthn4k1Bqn+eh23NQqSPqdo5WdncOZQLsLPQVaJ6TfdUVI/1PvoqHgiJDmdEWfL7
	 0rqyWC6GdIu7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AFB6680D86;
	Mon,  5 Oct 2026 05:12:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8E217323
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:23:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7EE0060705
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:23:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SBJzGAr77y4d for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 19:23:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A4674605CB
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791141784;
 b=ixbKNhNYQfYTuGFGOVVgWOFrENKo85/xr8JntQ1t7JDL3FZT4QB4DCvd13RTGA3bw+xA
 +/PHfPOmyd17hi8klWpj2LH9fXe2orriIt7IyGxwfkn9t1JHMRiVL7Npg3KPjCOALFHos
 uz5JmzXFigTqip/dom3V9emHgvF/xDxCdd8FMm0UvmEIyDrOmaQo63f9uPVmK/jdK2PH/
 S0djWaPNAZPMUKz5bF8kzTISJ7On6rXORGt9I6je7G6NakXzBUdaQOpbj2dG2rYWCgUhb
 IjeobrqTeXiFp5tQIVUR4dMeOiD4gZfaLAqd5kPn7EKorhIJfmNq/AWEWcPKDYpPTOw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791141784;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=wPtPK2a5WuTo3m4F24TjicBPD3suBQpLO+2VKfL+KoU=;
 b=NQ1wU4EEOLz6jOLlWFvvFty4WHfqlxG48f81j/OiZ1O92QUdB4gp3EyqtTOFsgtBbKLj
 MmQIoJUCjaVSQWnPBPispM8Wj+JVRFrQT8u4Vkd9t/rmIQdIDZjmsSCcRM1r4raa1xzZ5
 ICYU386qQRaSyTFUfLOkerTrwe3VQ6Tnv0AT339aRhztYUs3/s8c3IPoGwHxOqAKq3uAb
 vHDRerOR3OsdP1ctoussPFK1JIBiaZSjy0dYKvTylj1P9EqjkE4CWjwEKJPjn2uSoLO1Z
 NHRS1w2p1vbDvGPJPaggO3WvWqRTMZgH5OilKNUZrR868qegL5C4jHOqGuLllgTPy7A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=j0geeioS; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=j0geeioS
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A4674605CB
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:23:04 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5F9796021E;
 Sun,  4 Oct 2026 19:23:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C12DC4AF64;
 Sun,  4 Oct 2026 19:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791141782;
 bh=Ib1tkhZ9ekTW8pmIrYfLBqfAGauOMLKnRPvsJlvsv1I=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=j0geeioSfdLKeZzUfT0CQE0OhqSqzJqsKrPxYtUKsHXAB7QmXMNkwhc6fBYiqpaV2
 2UvGTHn9+5dbcLAKrnMI8M/Wkac2un0JAOhXA6b6QvsSKMFeKhFCm53+deCeOLhqlo
 bpYcf0UFg8kp4Klsh4wZr49VCA6ANimpSZjFGBxP9Xm+yopp5f0IHsfxjHvcDOrbJB
 ho7yFqA+ujV+A9zZj5Au0ZH5dfhHZIwQq7zf9HTB4d7uiRjyESfC7N68JSvMw/Z8Kf
 eomZ0H8fELCC4j7TcKbhU5BzRZA+kYynYKX/gwfdXupOmODhDAsIBCzhxMkt6qCg+b
 zfq4VwqAoE00g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id E8D7ACA5FF0;
 Sun,  4 Oct 2026 19:23:01 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sun, 04 Oct 2026 21:22:36 +0200
Subject: [PATCH u-boot 4/8] ufs: add CONFIG_UFS_RESTRICT_TX_LANES
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-b4-ufs-sony-v1-4-54e71c95ba62@protonmail.com>
References: <20261004-b4-ufs-sony-v1-0-54e71c95ba62@protonmail.com>
In-Reply-To: <20261004-b4-ufs-sony-v1-0-54e71c95ba62@protonmail.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 David Heidelberg <david@ixit.cz>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Jared McArthur <j-mcarthur@ti.com>, 
 Michal Simek <michal.simek@amd.com>, Udit Kumar <u-kumar1@ti.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Alexey Charkov <alchark@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Simon Glass <sjg@chromium.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marek.vasut@mailbox.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, Peng Fan <peng.fan@nxp.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, Janne Grunau <j@jannau.net>, 
 Julien Masson <jmasson@baylibre.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Markus Niebel <Markus.Niebel@ew.tq-group.com>, Petr Pavlata <petr@acrux.cz>, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791141780; l=2153;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=FTI5xYw1z/BewAVGIYfLfALDiWPTsnJhZaaKA4sllzY=;
 b=O/YEMpqMSysfNs3B88QX1ZmllpqFahoApTXj+hxJBbtBmAFH9OeaICcWC6NMbKRhCYaLTLO75
 N2hMWUUTuYxCo0xpxwJnxXwSVKP640NvHle0T6CZd5t4ymGU1nBNRX1
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Mon, 05 Oct 2026 05:12:03 +0000
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

Add CONFIG_UFS_RESTRICT_TX_LANES, to restrict the amount
PA_AVAILTXDATALANES = 1 at the start of ufshcd_link_startup().

Some platforms (notably the Sony Yoshino/Tama families on MSM8998 /
SDM845) have only a single reliably-usable UFS TX lane.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 drivers/ufs/Kconfig      | 14 ++++++++++++++
 drivers/ufs/ufs-uclass.c | 13 +++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index 49472933de3..266e7180152 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -8,6 +8,20 @@ config UFS
 	  This selects support for Universal Flash Subsystem (UFS).
 	  Say Y here if you want UFS Support.
 
+config UFS_RESTRICT_TX_LANES
+	bool "Restrict the number of UFS TX lanes to 1"
+	depends on UFS
+	default n
+	help
+	  Say Y here to restrict the number of UFS TX lanes to 1. This saves
+	  power at the cost of write performance.
+
+	  This is useful (and on some devices required) for platforms such as
+	  the Sony Yoshino/Tama families where only a single TX lane is
+	  reliably usable.
+
+	  If unsure, say N.
+
 config UFS_AMD_VERSAL2
 	bool "AMD Versal Gen 2 UFS controller platform driver"
 	depends on UFS && ZYNQMP_FIRMWARE
diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index fdf62a69c02..977ffebc21f 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -508,6 +508,19 @@ static int ufshcd_link_startup(struct ufs_hba *hba)
 	int ret;
 	int retries = DME_LINKSTARTUP_RETRIES;
 
+	if (IS_ENABLED(CONFIG_UFS_RESTRICT_TX_LANES)) {
+		/*
+		 * Restrict the number of available TX lanes to 1. This saves
+		 * power at the cost of write performance and is required on
+		 * some platforms (e.g. Sony Yoshino/Tama) where only a single
+		 * TX lane is reliably usable.
+		 */
+		ret = ufshcd_dme_set(hba, UIC_ARG_MIB(PA_AVAILTXDATALANES), 1);
+		if (ret)
+			dev_warn(hba->dev, "%s: failed to restrict TX lanes: %d\n",
+				 __func__, ret);
+	}
+
 	do {
 		ret = ufshcd_ops_link_startup_notify(hba, PRE_CHANGE);
 		if (ret)

-- 
2.55.0


