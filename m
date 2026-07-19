Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B614C44512
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 22:02:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C38FA84AA5;
	Mon, 20 Jul 2026 00:02:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="UJrBT6/7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B789184AB3; Mon, 20 Jul 2026 00:02:32 +0200 (CEST)
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch
 [109.224.244.16])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89F9784A9E
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 00:02:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anoduck@protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1784498548; x=1784757748;
 bh=WU+j4M/Nityt5ICYowOUiAB0HycFEDRR5LF3HlATclU=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=UJrBT6/7vviTcNbAejU7CsPQZ83rGPmUSsVkgkFrK0r/xVVTEkwFK5oZDS1SgwlBP
 8Ftvpx+qKsnYlUT8H2anqDttyn436XFhIvk6dQX+EZe95NKBYsu4wBUrSBw3isfKHY
 IHqMA2pY9rrW1S2re2H0xnNLc7DOpr2Q4rMvChwR+r/FsK17CXXH+y/dVntpd8bH2K
 ZXC1uXcZWszFSlYqauBZJvNaZrmQTPtByI1sMl48qruND6x19IDBY36+QRgoGxaoGz
 qYUICi0lqivM0ek8rK7SJA9ZWBNxLGhoAm1kTl9VETD71jYY1LDHiaQ8Ha0JWJcZZY
 bJb1+iWtBl7tQ==
Date: Sun, 19 Jul 2026 22:02:16 +0000
To: u-boot@lists.denx.de
From: anoduck <anoduck@protonmail.com>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>,
 Minda Chen <minda.chen@starfivetech.com>, Hal Feng <hal.feng@starfivetech.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 anoduck <anoduck@protonmail.com>, The Anoduck <anoduck@protonmail.co>
Subject: [PATCH RFC PineTab-V DTS File v2 0/2] Pine64 Pinetab-V Device Tree
 Support
Message-ID: <20260719-develop-v2-0-91fdc4cd60a2@protonmail.com>
Feedback-ID: 3493375:user:proton
X-Pm-Message-ID: 304415598e47859ac40fdcc727b4dce79e1fb6f6
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Provide support for the Pine64 Pinetab-V Risc-V 64bit Tablet

Signed-off-by: anoduck <anoduck@protonmail.com>
---
Changes in v2:
    - Device Tree split into two separate files per request.
    -- File 1: Previous Community Additions
    -- File 2: Addition of support for sd card and EMMC
    - Location corrected to `arch/riscv/dta`.
    - Link to v1: https://lore.kernel.org/r/20260718-develop-v1-1-d4b5c0675=
f87@protonmail.com

---
anoduck (2):
      RFC: Pine64 Pinetab-V dts Device Tree File
      RFC: Pine64 Pinetab-V Device Tree File

 arch/riscv/dts/jh7110-pine64-pinetabv-u-boot.dtsi  | 1756 ++++++++++++++++=
++++
 .../riscv/dts}/jh7110-pine64-pinetabv.dts          |    7 +-
 .../jh7110-starfive-visionfive-2-pinetab-v.dts     |   12 -
 3 files changed, 1760 insertions(+), 15 deletions(-)
---
base-commit: a83903122b85e34cf3ef1050bdfaa7b258f17b74
change-id: 20260718-develop-1e9fbc9b4fe0

Best regards,
--=20
anoduck <anoduck@protonmail.com>


