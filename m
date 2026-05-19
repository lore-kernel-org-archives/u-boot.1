Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612A0CD4F57
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 11:56:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE5FB846CA;
	Tue, 19 May 2026 13:55:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=superkali.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=superkali.me header.i=@superkali.me header.b="PK6Ld4ff";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A22FD84659; Tue, 19 May 2026 13:55:53 +0200 (CEST)
Received: from fr5000-r.dnsiaas.com (fr5000-r.dnsiaas.com [92.42.104.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEB56843B6
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 13:55:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=superkali.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hello@superkali.me
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=superkali.me; s=default; h=Cc:To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2r/TEjBWjhZbLPScHQapNpitQg44VLj48gNqj5kYC80=; b=PK6Ld4ffWsjiBSZYRzh8/uRuch
 UbEPZWI03ZAtou7ZHjYsw9LmNjnvuxedPrwCDna/307rB+9FMqlTbxD0yUJOqxNfIAYKq5M1Ifd/s
 0sdSZ67LV6jsAUSQIi6EuG20u/FHVyzeQeLfyV9O0mM7FVcZgiQBRjJL2BCgR/CxaQgS3kq8n2TZd
 e4tNHadK4V2wdb4GfC0Fmah9kg1HjD755+FjCGJo0rCSTN7J7NIEIKejph/4AFIPlskCSgWFG7lCp
 2MmWQFH2xZXA70EfMelhV98oFi0GlzKogyw4K30P6nLi0e7oxKzvQ2PYIEQhcJwnw1mSFGwT+WeRX
 pseOkJiQ==;
Received: from [81.57.40.39] (port=48348 helo=vscode.iliadbox.lan)
 by fr5000-r.dnsiaas.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.2) (envelope-from <hello@superkali.me>)
 id 1wPJ39-0000000EKHd-2QQS; Tue, 19 May 2026 13:55:50 +0200
From: Daniele Briguglio <hello@superkali.me>
Subject: [PATCH v2 0/2] clk: add gated-fixed-clock driver for
 rk3588-rock-5-itx PCIe
Date: Tue, 19 May 2026 13:55:48 +0200
Message-Id: <20260519-rock-5-itx-pcie-refclk-dtsi-v2-0-738b67857cac@superkali.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMRPDGoC/yXMQQqDQAxA0atI1g04g9bSq5QuxiTW1KIyGUUQ7
 +60XT4+/B1MoorBvdghyqqm05jhLwVQH8aXoHI2+NJfy9rdME40YI2aNpxJBaN09BmQkym6JnD
 VesedY8iHOUfdfvfH829b2rdQ+i7hOE7d9xFzfwAAAA==
X-Change-ID: 20260518-rock-5-itx-pcie-refclk-dtsi-17ad4b21df1d
To: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Simon Glass <sjg@chromium.org>, 
 Peter Korsgaard <peter@korsgaard.com>, Heiko Stuebner <heiko@sntech.de>, 
 Daniele Briguglio <hello@superkali.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779191749; l=1819;
 i=hello@superkali.me; h=from:subject:message-id;
 bh=VbV6A7sa2Bn6XOmB+AML6L7hiK70MkmHXXAHDlP4Icw=;
 b=q7Hdz78ErpkJJKK2g5tEAVDB2PlVvrcZA5KdxHUiTypB4vS2pqJHMbvlJ+tuHWVgOm7R4cQrR
 96LsiQpjNLkBiLlsKFJ84ESuNZhBY7ka8wDnvyz2xox8+rg5kUCVBtm
X-Developer-Key: i=hello@superkali.me; a=ed25519;
 pk=5tynRWQdL93CDcapJ73FkcCRY2PeBOJOIAoIhRig53U=
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - fr5000-r.dnsiaas.com
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - superkali.me
X-Get-Message-Sender-Via: fr5000-r.dnsiaas.com: authenticated_id:
 hello@superkali.me
X-Authenticated-Sender: fr5000-r.dnsiaas.com: hello@superkali.me
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

v1 [1] was a board-local dtsi override that dropped the
gated-fixed-clock refclks from pcie3x4 and pcie3x2 on
rk3588-rock-5-itx.

Jonas pointed out that the u-boot dtsi is propagated to the OS via
EFI handoff, making the dtsi-override approach brittle.  This v2
adds a UCLASS_CLK driver for the "gated-fixed-clock" binding
instead.

Changes since v1:
  - drop the dtsi override
  - add a UCLASS_CLK driver for "gated-fixed-clock" (Jonas)
  - enable CONFIG_CLK_GATED_FIXED in the rock-5-itx defconfig

Testing:
  Validated end-to-end on a NanoPC T6 LTS via the synthetic-DT
  approach Jonas suggested: a fake "gated-fixed-clock" node with a
  fake "regulator-fixed" supply injected into the board's u-boot
  dtsi and wired as an additional "ref" clock of pcie3x4.  Probe
  and enable trigger when pcie_dw_rockchip runs clk_enable_bulk,
  and NVMe enumerates through the synthetic refclk path.

  I don't have free access to a rock-5-itx at the moment (the one I
  maintain serves a production mirror), so the v2 has been
  build-tested only on the real target.

[1] https://lore.kernel.org/u-boot/20260518-rock-5-itx-pcie-refclk-dtsi-v1-1-faf8626039fc@superkali.me/

Signed-off-by: Daniele Briguglio <hello@superkali.me>
---
Daniele Briguglio (2):
      clk: add gated-fixed-clock driver
      configs: rock-5-itx-rk3588: enable CLK_GATED_FIXED

 configs/rock-5-itx-rk3588_defconfig |  1 +
 drivers/clk/Kconfig                 |  9 ++++
 drivers/clk/Makefile                |  1 +
 drivers/clk/clk-gated-fixed.c       | 84 +++++++++++++++++++++++++++++++++++++
 4 files changed, 95 insertions(+)
---
base-commit: 38dbe637c9dfcadbd1bc201bfbb27f96b2ad525a
change-id: 20260518-rock-5-itx-pcie-refclk-dtsi-17ad4b21df1d

Best regards,
--  
Daniele Briguglio <hello@superkali.me>

