Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32000CA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 09:35:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB8364061B;
	Mon, 12 Oct 2026 09:35:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Faevf2EdxaiT; Mon, 12 Oct 2026 09:35:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 187564060A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791797703;
	b=jBdBXrCoA1cYkWyTqFyHybr2RRMjv1YS8qiS97wxCgC27y2abFNR+CDNNPsGj2eYAndH
	 uGMocgf01IX8k9fOtWsdADZz+BH/LUIwKe+R3WBLuPiI392ezq8IvxoKW7LNh9wUBjdG3
	 k/fFiUvEMKBkkCbsVjHMKrp6o9PNZeQuEdenmd9zxnKOPIO6KERfE89Q8BkUULfY9hfr8
	 TGozmZ8LgJyco0rrCltK75ZoemJ15rWJv3It8BrQ9jcb2aHUU0oqbvcG6QCJ6ld6Fs7+j
	 djm47zmmSQKGyZ/f6uLEXrn63Mf4R/xwxtlYkEXX0LppxTezwuYjuGUZe4U6TsCLGTQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791797703;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=CBduEd+dwnX7/VCREZkyfoS33GsDnZn1WdClBfbemCs=;
	b=O0v4Qirkw1WHk8JQTCVf1QpXbPE4uyQtve3ktIuZHqKKrfNyadc36RA2NFtgsFc5OtHt
	 NG3QAf6drVxqKPiJhPbw+XTTgwgPTjvRaFPba3aw6EME43Mq0L5dRwonVlOtw+4WLenKK
	 MCB6VS7XB1CqdxYcarZljHg9FXh6pinwoaT9Gtsd2YBn9BrXcjahmWf2QU/HnKBmlNFb0
	 Un3tM01/TrHexTiJ9NuOQMxQLeh0rC7RdjwKSgnYAMl65xa4nhBfDP3K/usU6KlyhiehE
	 E2/rooDte63G5ok4plfGHEdOpRYlquFcUFMSoRYAuw2tucd8XjHv2IHf0A0rv7iqutw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791797703;
	bh=CBduEd+dwnX7/VCREZkyfoS33GsDnZn1WdClBfbemCs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=ZO4rE/Wvr5gGJHnLP08645XSPS/sO5TRNUeSAjtk/Z/eIaD4zK5O1i6Xed1f+1tqT
	 uyA+B9+5+TOpq5lXqbJ7s3tmehOhIeNpduV6tzLb5WjqRvOPbKAITZDvZxpE8dXcCH
	 q7UmtHhloS9WeFNhIj9PSj+vi5ISM5+7lM4Nwz1USBKF2DmeEx7MfDW5M4gdKK1vfo
	 Npa8Sai5Aak/iuMmI7YFKRtXx2Ie889dUXLP2bhmJa9zLFvfvMblSpyB5pwPq6a480
	 3Dk0bLXmtQEZ0w15LS9x1PWZYdCCkcAq+Kbq0g5oxyp79TpXNcYYFs/85yek4Xvzq0
	 ftz7s5gfZcOLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 187564060A;
	Mon, 12 Oct 2026 09:35:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 677212E0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 06:55:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4D55D80C74
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 06:55:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z14nFP3cEWco for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 06:55:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7717580C72
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791788147;
 b=kGqzWN0RnLMi28xfo4DLHHBMKErfOSFip5ocdf3QzQJEFZNvsfvJzH5gXmnvI2/0aV1K
 Atpap21SixnLcd8KdkyXJ6J1ofHJzp8eZvH1yuIz7iA1tiOt9qbr9cOmUrs8Agfp90+jX
 LLiHGxA5Zggohay/Py06w31jq2/p+Jc3DZCDgJKmxWr5IYAX1kzHFRoM0K3dVY9FKKYtA
 UD/pJD1RWvlDcGIKlPJQXA8S+bsi2hUCUnIKjPaz7ZLvwGvlYb3eskt4OFx5VXq2ZpnJV
 F5SXIiJmDDoRwVxeEVU4NGE50lFK4cYwBRGL27ziENpFBFYxorC625hXYBMITBcI5BA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791788147;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=CBduEd+dwnX7/VCREZkyfoS33GsDnZn1WdClBfbemCs=;
 b=sQ0r2wI1y+osrlwI5hXMk/t+aCgQkVBG1Rv/M3exRvBykwPSTFdNrcMaV1jTgOls8BCG
 DA69A48G6ew5iwOAcnS3naSM5NeGoclLAmP9Mxb7j+dvkcvC6w65wqAwRym/p15Mt4jTo
 lrZmoYAxKeY0H0UIHxZtv4GiPf/17bZtUs4pDJIOOdOXWP4HkrjhYA0CHMsWWiVe60LYC
 965KJe6PdvnfFEOnuoekCn/tA/OnMz5VCek+IP2r2CN4QmqESRcN53n695qg6hvM+Cg6W
 VyoDqIZgVM2bQfxKWEuWFCqukqTR77KRchyzCRt24wSGCV5DODIk+ixt2JG3sy/cYzQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=dAvqzHas; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+hystericaldragons.proton.me@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=dAvqzHas
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7717580C72
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 06:55:47 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id DE64E60AA1;
 Mon, 12 Oct 2026 06:55:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93D8CC2BCFA;
 Mon, 12 Oct 2026 06:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791788144;
 bh=r5kZWMxPwBXGiHhqmPEMflSK9IDirel6UlqoE3wAHm8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=dAvqzHasFHQ10u8Ki9SieBXVbL1adJbK3qm/ImLWj6wpzO4l5n3q3CBRZ7hlfF4tI
 9fNeRrSp1WjQB2RLhAOSoGr2m05ar9povzzu1sYaNACJkrQ2TEnFndOdSaW9rW4LkV
 lDKWcIdgBlRL6xV2RaRKiEVIDuOFMNOSckJO0wy5fvEvjLx+Ti98sHGmUAYRyeeEhr
 nMAgjYMgu0SkDDjwFiRUapwXDF/91y2tiqNqPtYrCF7dHW9U2vI5bnF3Og2CigcjX4
 fw8R1usz3XXl7Xv1PMF0WhSIEVH5VBMNl/2OcX2XbT4g3nhvBb+N3k7tUV6i87e9cH
 Er1kvwtGikv3A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 73F70CA9ED5;
 Mon, 12 Oct 2026 06:55:44 +0000 (UTC)
From: =?utf-8?q?=E5=AE=89=E5=AE=B9_via_B4_Relay?=
 <devnull+HystericalDragons.proton.me@kernel.org>
Date: Mon, 12 Oct 2026 14:55:42 +0800
Subject: [PATCH 1/2] rockchip: rk3528: Split out common NanoPi u-boot.dtsi
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261012-nanopi-r28s-v1-1-042d62597829@proton.me>
References: <20261012-nanopi-r28s-v1-0-042d62597829@proton.me>
In-Reply-To: <20261012-nanopi-r28s-v1-0-042d62597829@proton.me>
To: u-boot@lists.u-boot-project.org
Cc: Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <u-boot@0leil.net>, Jonas Karlman <jonas@kwiboo.se>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?=E5=AE=89=E5=AE=B9?= <HystericalDragons@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2152;
 i=HystericalDragons@proton.me; h=from:subject:message-id;
 bh=OPgz28j3KtTUGlUgWj5O/HjkThPqN+JWbYP1nYWKvr4=;
 b=owGbwMvMwCUmepz3XUtTHjvjabUkhqwzLflCEwNWf+c5uP+M8uyEP5HG00JZduo93ju5KZ+1M
 Hrymx88HaUsDGJcDLJiiiyym6ojhVZFzyxikToOM4eVCWQIAxenAExERprhD0ffVrdr5ptPz18R
 pRjB/o2l59fWHavyzC/517OdXXG2XJORodllp8fzSbYhcSv+FRfvLq7fGq68Krw1+qntz4sMZ+T
 1GQE=
X-Developer-Key: i=HystericalDragons@proton.me; a=openpgp;
 fpr=1DB27B5912AA5B9972041AC715C70DEE84826E07
X-Endpoint-Received: by B4 Relay for HystericalDragons@proton.me/default
 with auth_id=1004
X-Original-From: =?utf-8?q?=E5=AE=89=E5=AE=B9?= <HystericalDragons@proton.me>
X-Mailman-Approved-At: Mon, 12 Oct 2026 09:34:57 +0000
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
Reply-To: HystericalDragons@proton.me
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: 安容 <HystericalDragons@proton.me>

The Linux devicetree of the NanoPi Zero2 has been split into a common
rk3528-nanopi.dtsi, which the NanoPi R28S builds on. Both boards use
the same PWM regulators for vdd_arm and vdd_logic.

Move the U-Boot specific parts of the NanoPi Zero2 into a common
rk3528-nanopi-u-boot.dtsi in the same way, so that the NanoPi R28S can
include it instead of duplicating it. No functional change.

Signed-off-by: 安容 <HystericalDragons@proton.me>
---
 arch/arm/dts/rk3528-nanopi-u-boot.dtsi       | 11 +++++++++++
 arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi | 10 +---------
 arch/arm/mach-rockchip/rk3528/MAINTAINERS    |  1 +
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/arm/dts/rk3528-nanopi-u-boot.dtsi b/arch/arm/dts/rk3528-nanopi-u-boot.dtsi
new file mode 100644
index 00000000000..3e2fbd81da1
--- /dev/null
+++ b/arch/arm/dts/rk3528-nanopi-u-boot.dtsi
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3528-u-boot.dtsi"
+
+&vdd_arm {
+	regulator-init-microvolt = <953000>;
+};
+
+&vdd_logic {
+	regulator-init-microvolt = <900000>;
+};
diff --git a/arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi b/arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi
index 3e2fbd81da1..151f1872fed 100644
--- a/arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi
+++ b/arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi
@@ -1,11 +1,3 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 
-#include "rk3528-u-boot.dtsi"
-
-&vdd_arm {
-	regulator-init-microvolt = <953000>;
-};
-
-&vdd_logic {
-	regulator-init-microvolt = <900000>;
-};
+#include "rk3528-nanopi-u-boot.dtsi"
diff --git a/arch/arm/mach-rockchip/rk3528/MAINTAINERS b/arch/arm/mach-rockchip/rk3528/MAINTAINERS
index 95543b40dd3..d1810fb0528 100644
--- a/arch/arm/mach-rockchip/rk3528/MAINTAINERS
+++ b/arch/arm/mach-rockchip/rk3528/MAINTAINERS
@@ -13,6 +13,7 @@ F:	configs/hinlink-h28k-rk3528_defconfig
 NANOPI-ZERO2-RK3528
 M:	Jonas Karlman <jonas@kwiboo.se>
 S:	Maintained
+F:	arch/arm/dts/rk3528-nanopi-u-boot.dtsi
 F:	arch/arm/dts/rk3528-nanopi-zero2*
 F:	configs/nanopi-zero2-rk3528_defconfig
 

-- 
2.56.0


