Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F2E3CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 13:41:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F3F8280DB5;
	Mon, 28 Sep 2026 13:41:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oGdzQlSNrQYH; Mon, 28 Sep 2026 13:41:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C111580981
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790602908;
	b=GBdaGfW7+fOcLDmMizCZBcYdgiS4DXhXwyiRNonFwY3qi1Wc5JuKZeO6ym81nFoX50kw
	 hNQAdGE0zqkscW+QqYDpyxEaFelc0C9oM/uAERo8stV2WEoGT1JKsHOf29sVHWO2wvJ7r
	 /obqNQRZgTDBjerTSZFhTD7Q0vr0m+JHtSh24x4HbryhMU/20bGnZwFp4tzjUQHK2ENTn
	 /gJP404NGsGDNo76pmsnwCOQUdzJyhwwJFk/94Uc6JR2KOQhsJ14jfB0CF+lfb1bLhRcE
	 nQmPAJ+V7+CGjpqrtaVbIK3NHYEj44RB2vIw0azoPwoKkOTpvegtGSC0LFyhXqXTzVw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790602908;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=FI6blqF7BBoJG4zcjp3RDnIKhkgLtY+n034tdklxIn0=;
	b=ixPFhw/SWRjGQe2vY88P+3HdS9GZMFMYWRG0oIxY+1q+SFw8iNSYdrSbRdQ/4E1mMmrp
	 pbtw2nAYlMk7gLJ+G00dYEca/lkz6ernXCmxSk9zI70Z24oGu94hvlZuBZTm9XqWgb8Qn
	 xz/W3+x2OvUXV07RmMSMEArQtXwbwoTOEaUqdz09JDEb8IcOJqcTrmiuIeUHi9D6+1gh3
	 blY6AdRnwhmQo0660e1YS1xZZDPzbTTpK3Yh7wf1k416NrLxYU8CyuLRGMVrpXH5YMxO4
	 zJEeaYA2UGJaZ9L3zFcJSwTba6MN+m1lWQGDywgadcC1UxTbHCOohnjLv/rxTwKk7PQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790602908;
	bh=FI6blqF7BBoJG4zcjp3RDnIKhkgLtY+n034tdklxIn0=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=RXVCkIaLeCOtIQBmjUEV0xugPNQt+DMaLxgHFqhP3t8l7wDdgJ/h3S3sZEWtCaCJr
	 pjAlC3nFMpEiAmGXcCvfP/XknQ83UQwzkVgdiyAYkXRSrTYmBBOsext+2XNGT6p5+n
	 d6S6PCqD9B7mDccJn7rxGCSdL+yhBiN5qVavW2wicGQPCTxu6g/Iwa27H6yYnlD4nV
	 yB72Y5poBfB3jjpCut4J8DDlkFRY4R15NjpTNo1Q/noi25WpTjZyvgNbSu8r4USmbJ
	 Etls7OsdAH40xnilTUjm8SuK78NdveNfANR8dKmT8uYWJXZHG3ZeUbQWgtV6rK8dGO
	 kB0OS7c+kSsNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C111580981;
	Mon, 28 Sep 2026 13:41:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2FC853D8
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 07:39:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EC187400E0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 07:39:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z36qtczIAMfI for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 07:39:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org D0641400AF
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790581143;
 b=BhL4HMb3u9rgfaffA47V+uC7AwZvuplT0zj41xdEj2+h/ImQ/cXOEYBHArqUJn8plJbN
 1nFP8LvcYL6fbhCW3yFQbtEg/E28ev+CbK5E//ofaw3bq7nkWHeQy9F9RYVfk7k4nMk2q
 4g+zlQiOZRk3seXAb9HDTZRCho5ilafeW01YUuGfJCDJgI9zkBsTiErswSXqvbyDGYKDm
 5M0dyCgXyP9aeI8veOQUhNi6CD4RWS/Hw5hXKKt6DsN9efAqj1rGWjN+Vd1brjpppxdqq
 S4B1ZOjQxlneEPmYQ/Eq+CoZLhbygkTi/+mGzCq2CKLOpSJTLeCsS8tOJtcUqxafQIg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790581143;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Subject:
 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To;
 bh=FI6blqF7BBoJG4zcjp3RDnIKhkgLtY+n034tdklxIn0=;
 b=UNTPZVhDiC/pVGapFcyuUKSjUFAB+AgHqW671dOknDGmg2iyW+zG8F3DMSSmMi0wGaw8
 u30Z4Rzixia7BcywqWeu9vnTS/x94V9V3CFiNl9J6dZs5GhODliU4ZCe0ma3kR6ITQqbR
 Nsvh6tmovx8U3S7mElN00jH+j8IHt0cIiqVoI+hroFUIpg2ydVc3qQuVEr8PwZ4WQrl7f
 JTImK4bsrWPsN9iuklXJiYGj/ZOyvcM+u+2YuTn0DEaab2ZJ6gpbwDFmSJhYukJ6/hC6c
 KQ6s+eMp9hfWooGpkIZIxVT4+PrvN/QdDB+vEFQr5EN3iLsF/717MYMflHXg4Xvo9nQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=U60If5k3; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+dinesh.v.adlinktech.com@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=U60If5k3
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D0641400AF
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 07:39:02 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id DAAD9601F7;
 Mon, 28 Sep 2026 07:39:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F338C2BCC7;
 Mon, 28 Sep 2026 07:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1790581140;
 bh=zL1J8Gvo7KX/aNNnFW41u/vTMLuwQP0C9AtPnuvE9R0=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=U60If5k3+yzPgEvln1ClYh68yO4bQh0oY6jzMtcgjrranVTietfRbzKYKcAt9XE+R
 L1oJRdtFZglrV8Q3KToYuPFvTRJFQjjUxtfQKFn0KrvwpBqEJefWtVsdOYE5y9x5IJ
 Ue5+RNDEfxkiBy24BzmMGHQalCW/bstNh03NgGVB9OkXe1tTaABBJne26Z5hIV+hCL
 kA8h3CKCICImslrtVrDeSwe6hbwnlLFjL5Rtj0BD0XpXFKel3zFg5NMEkEUWudw5nf
 FUiUtLaZsSxHV65/Hvxlc4P1nn0TAouTHWqIoDL6zWPMcTTQZTSHUNN0lWzdtggaNV
 NuoQFKeNTQgpw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 7E300CA5FA1;
 Mon, 28 Sep 2026 07:39:00 +0000 (UTC)
From: Dinesh kumar v via B4 Relay <devnull+dinesh.v.adlinktech.com@kernel.org>
Subject: [PATCH 0/4] Add ADLINK LEC-iMX95 board support
Date: Mon, 28 Sep 2026 13:08:56 +0530
Message-Id: <20260928-lec-imx95-v1-v1-0-9e0c9b94ccbe@adlinktech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJAZumoC/x2MQQqAIBAAvyJ7bkGFLPtKdAjbaqEsFEQQ/550G
 ZjDTIFIgSnCJAoEShz58U1UJ8Cdqz8IeWsOWmojrR7xIod8Z9tjUkh6MKbBSuOgJW+gnfO/m5d
 aPwL/BxleAAAA
X-Change-ID: 20260928-lec-imx95-v1-e2766e27906c
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Alice Guo <alice.guo@nxp.com>, Primoz Fiser <primoz.fiser@norik.com>, 
 Johan Jonker <jbx6244@gmail.com>, Simona Toaca <simona.toaca@nxp.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Dinesh kumar v <dinesh.v@adlinktech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790581138; l=2135;
 i=dinesh.v@adlinktech.com; s=20260928; h=from:subject:message-id;
 bh=zL1J8Gvo7KX/aNNnFW41u/vTMLuwQP0C9AtPnuvE9R0=;
 b=l1U9FVvhr/rJRkehtdvlEN2+Jmb4DC0zf64d/3U1grx7juh/Z+NmLH3V10Je71ZDGQj3F3M2P
 xJQk3OxKuWyCm5rkXsfcrUFQieolxmxB3e63tvNfs5tOea0hjXMRAqW
X-Developer-Key: i=dinesh.v@adlinktech.com; a=ed25519;
 pk=2+xm2aDQjQT68aPFzfLMgdZrQGpCMUU3Qp1CwWoRlus=
X-Endpoint-Received: by B4 Relay for dinesh.v@adlinktech.com/20260928 with
 auth_id=1074
X-Original-From: Dinesh kumar v <dinesh.v@adlinktech.com>
X-Mailman-Approved-At: Mon, 28 Sep 2026 13:41:44 +0000
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
Reply-To: dinesh.v@adlinktech.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

This series adds U-Boot support for the ADLINK LEC-iMX95
SMARC module based on the NXP i.MX95 processor.

The series includes:
- ADLINK LEC-iMX95 board support
- LEC-iMX95 device tree and U-Boot-specific device-tree support
- LEC-iMX95 defconfig
- Board build and boot documentation

The board support includes SPL initialization, board-specific DDR
size detection, MMC environment handling and the required i.MX95
boot image packaging support.

Validation performed:
- make O=build-lec-imx95 lec-imx95_defconfig
- make O=build-lec-imx95 -j$(nproc)
- successful SPL and U-Boot build
- successful LEC-iMX95 DTB compilation
- successful Binman generation of flash.bin
- successful targeted dt-validate of lec-imx95.dtb
- git diff --check
- checkpatch.pl (0 errors; advisory warnings reviewed)

Signed-off-by: Dinesh kumar v <dinesh.v@adlinktech.com>
---
Dinesh kumar v (4):
      arm: imx9: Add ADLINK LEC-iMX95 board support
      arm: dts: imx95: Add ADLINK LEC-iMX95 device tree
      configs: Add ADLINK LEC-iMX95 defconfig
      doc: board: Add ADLINK LEC-iMX95 documentation

 arch/arm/dts/lec-imx95-u-boot.dtsi   |  73 +++++
 arch/arm/dts/lec-imx95.dts           | 216 +++++++++++++++
 arch/arm/dts/lec-imx95.dtsi          | 524 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/imx9/Kconfig       |  10 +-
 board/adlink/common/Makefile         |  26 ++
 board/adlink/common/mmc.c            |  49 ++++
 board/adlink/lec_imx95/Kconfig       |  20 ++
 board/adlink/lec_imx95/MAINTAINERS   |   7 +
 board/adlink/lec_imx95/Makefile      |  11 +
 board/adlink/lec_imx95/lec_imx95.c   |  96 +++++++
 board/adlink/lec_imx95/lec_imx95.env |  75 +++++
 board/adlink/lec_imx95/spl.c         |  79 ++++++
 configs/lec-imx95_defconfig          | 153 ++++++++++
 doc/board/adlink/lec-imx95.rst       | 183 ++++++++++++
 include/configs/lec_imx95.h          |  27 ++
 15 files changed, 1548 insertions(+), 1 deletion(-)
---
base-commit: 2b8902913c19eb581fb0d567201c09b8fa46ac74
change-id: 20260928-lec-imx95-v1-e2766e27906c

Best regards,
-- 
Dinesh kumar v <dinesh.v@adlinktech.com>


