Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ECBCCA5FF5
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 05:13:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 54D6A80E27;
	Mon,  5 Oct 2026 05:13:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YSQvt4UOgpDY; Mon,  5 Oct 2026 05:13:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 55B2180E0D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791177184;
	b=IHlTh59n2IecNjd1mXczBVsgAnsdzRg4CvjvBI7UvYCeosGs6ySFYK/XjvOiawvf3cpN
	 /0pvoorYSy9+KPbxZk/ZomMGR/ZwglynaFkWNEz5PUYKec5I1DcKCPDz2l0ByE2MOmW96
	 ZhAdhCblc9kU67AdFG414r8MUiW7TW8MAiZoBqKf6Uf2mISWkETwREj4bLPkx3i2QTAOW
	 Zv5JhQea0VOQzMMnY7exi+KIT4piF1XvaIkJh8PCk45OV1pQAS0XEcwF8CqHCheYzKCQH
	 I+iisMvW/KfdrMKQuiTl7YxupcCnS6Ynn+pBGMVEgImaIROd/po68+IHUqccHljYDWw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791177184;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=1OOdgIu1mr4kxv0BksD2xwyCIZYMEGRytuwX1aQFoSE=;
	b=Cu27oqg/Y0cVxwaBFFxmqDzUN4G3wlWaXxx5kHDpIrcAnqX/9yiiyD1+t11E2Te600r2
	 VkQxjU6lW98p6Vyasy24FiLH/rUz7mFAwJDjhywUXBV4ZSNj3/R5O8XD9RTXUjRwo/ak+
	 YRLfNt+OiUM+4qY3099eWaUIhaTY2e04A7JaCYM5/7vdwKjZW/Bj2+8K28nlMjx44GtnH
	 8QcyjZutY7Hye/HK4kgMVANYrHBlbL64vx17bN/Gd6m2XxQnWMdCSMx8lL6xbZFjtdh9S
	 OI9bn93Izef9PwnZV4z0QJU6sDj/UGfgJAZTUGmdCSS7rB+4FZ7C7lHt7KKCd0NA9gQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791177184;
	bh=1OOdgIu1mr4kxv0BksD2xwyCIZYMEGRytuwX1aQFoSE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=G+QmwgKaJlFoqGgTlwz06EN8m40JuTzIT/tCgXvE6/sA2Jf32KEm69i3LLvpAr28C
	 y//R8IV8ETg1k+t0aFELESs/1D0Wh0oNfY4F5txkWgGzYEc+/5Cu0eIF4+jqRRRLr3
	 Ng24mA0q00aO8dzDckrFVbdUi7PC1wBeVNMS9xayBYGN0SLwLnCMlpJ0NxWQ/wGMS1
	 1y+9L1xbuzJcwpQP4CjtnROeB4e+r9WGWcWRi5GjQrbbqNNu7cNpCfMeJl9ofeT8Zl
	 /rq+lSAYuO97fTKxZWWlzISXNN0SR1sX2g0LO5xf/Sktqx0Esfq9SZ2/416H0SxOOG
	 Sr+3+16+oX8VQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 55B2180E0D;
	Mon,  5 Oct 2026 05:13:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 50B521A6
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:23:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 36F144040C
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:23:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d2wIZMqpqc3i for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 19:23:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5730E40401
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791141786;
 b=RkVY+b5RyNIrYkTmIvtPTOHC7pzWPKr7r+C0Zay6HK7UZ5iSKh6F7oAYkYSAEtPhJBQV
 DwczLN2TWQc70HDS+tbC0K4xecX8hN9GHkX1A2ghdVy9GGwHO1GwYLzGYjNNT5LMM7iRG
 8BtCWicKXWm40JLksVHFItM//LO5PQ8VsHXvhrw3Ayz2HtoYqL4ltBtt6mHECliWpwjnA
 tYsevCAgp9O0YAHeEvFGoBHsEtUz06wfjTnYRRD4yejTQUaCZaIn8CwOrLsuueXoaK0gY
 kiDmCMHJpRU/qCFod8rrf9oZ3Ayi490M+V2gcB059wIlxmCzRsgLUrj3h1+f7uCqalg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791141786;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=1OOdgIu1mr4kxv0BksD2xwyCIZYMEGRytuwX1aQFoSE=;
 b=Wjd6r3h2rfjUc0ITuWc4oTqpDFVu3bgCTNJre4shkDMyWKOzJ+yq4OcoajAPdy3eNFEo
 hN++ZxERnRPn8Xwlk0qsOkKDQTfhSlw1EAGcXFV3y61MrgX2Gng06S19kCGeFszwhWkDq
 +TamSFTwDUj0tEeE/zc0KzsDA/5Vj4c4kepZ7gu0SopVuQi+G6UOjn7OjDevmCimX92zB
 Qj+BsU1D5+MYNyldRCWHzZjJcovffZh9Esw0SXwvQx7UlhRPDmN+/7iCA5XWqeN7H5XXc
 jXqTtLuj48/zS4+Zv8DyoIvxHL0wfCWNL8fk4Qw8efHe25oW8CFCYLcZ2ZujkwhVZCg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=U0av8zuG; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=U0av8zuG
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5730E40401
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:23:05 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A7A9C60515;
 Sun,  4 Oct 2026 19:23:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 76CF8C2BCB9;
 Sun,  4 Oct 2026 19:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791141782;
 bh=9y7hc/0YTSwT2jIpqNQBvJy9E5f58W6dMX3/Nl6ynr4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=U0av8zuG4ehZQVvJamh/UhgJ+jiiBN0K1L886d4+zO38J803rF43fyJrsVE7plws0
 GhFjPbHN1aSDAPrFOF4HjnK9pgUUQdBbAYHhhiSdSV/nX1lgRlCDSW2HDN6ncsaPD+
 gVjUaUtUT0WEZmRZXeWwuyBPriMNl9oNP1fE1Vyy2x+UONTYUA0OGPHJ9F4utjD/Xx
 qzwuHkGwkQNeb5rBGA5MlB7jsFHs4eL/xMiDbhhzL8YRHV9MuIfbuvITScZZwk/fmW
 KHpHKa+xizILJJW95ntV/frbJIb0rb26AfmfAOyQhrAo+9u3mauObUEtYK3RRBBHU4
 Wahf47QtPcrtQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 61294CA5FF0;
 Sun,  4 Oct 2026 19:23:02 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sun, 04 Oct 2026 21:22:40 +0200
Subject: [PATCH u-boot 8/8] arm: dts: qcom: akatsuki: re-enable the UFS
 controller node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-b4-ufs-sony-v1-8-54e71c95ba62@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791141780; l=1485;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=QVlhZ7MAT+TeLV7gQeOnoExu28XTr702eo6kVaytxCs=;
 b=0cJS2YcECbh/9q131AEAOs2knpLx8EUVSKgQqR0xf+H0QMBcRigu8G/+Xl1FWPZyWk930YUQG
 3YXk8/2TUEjCT1dTbR+G8OPHhxyxEUO9Ava/S3BGll/M3EYgB2eoej9
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

Upstream Linux explicitly disables ufs_mem_hc/ufs_mem_phy for all Tama
devices (sdm845-sony-xperia-tama.dtsi):

    /* BIG WARNING! DO NOT TOUCH UFS, YOUR DEVICE WILL DIE! */
    &ufs_mem_hc { status = "disabled"; };
    &ufs_mem_phy { status = "disabled"; };

PURGE/UNMAP command issued to these devices' UFS erases the bootloader
and permanently bricks the device.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 MAINTAINERS                                               | 1 +
 arch/arm/dts/sdm845-sony-xperia-tama-akatsuki-u-boot.dtsi | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 45e9076de67..9d6aa8126b7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -687,6 +687,7 @@ R:	Sumit Garg <sumit.garg@kernel.org>
 L:	u-boot-qcom@groups.io
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git
+F:	arch/arm/dts/sdm845-sony-xperia-tama-akatsuki-u-boot.dtsi
 F:	configs/qcm6490_defconfig
 F:	configs/qcs9100_defconfig
 F:	drivers/*/*/pm8???-*
diff --git a/arch/arm/dts/sdm845-sony-xperia-tama-akatsuki-u-boot.dtsi b/arch/arm/dts/sdm845-sony-xperia-tama-akatsuki-u-boot.dtsi
new file mode 100644
index 00000000000..a6e7ba45e92
--- /dev/null
+++ b/arch/arm/dts/sdm845-sony-xperia-tama-akatsuki-u-boot.dtsi
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+
+&ufs_mem_hc {
+	status = "okay";
+};
+
+&ufs_mem_phy {
+	status = "okay";
+};

-- 
2.55.0


