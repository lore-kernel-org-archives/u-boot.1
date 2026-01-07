Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B7CD0D171
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 20:28:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B3FB840B0;
	Wed,  7 Jan 2026 21:28:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Xjlz27M2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B983483A26; Wed,  7 Jan 2026 21:28:21 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FBAF83A2D
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 21:28:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+david.ixit.cz@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id BB380600AA;
 Wed,  7 Jan 2026 20:28:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6BBC1C4CEF1;
 Wed,  7 Jan 2026 20:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767817697;
 bh=3SzK7zFNN2411j+CdvliX/rSTfJSXnP/60IXCawXpqg=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=Xjlz27M2sNwrqqHbXu9UA88HjuuUQSGCOOu9xgi9x6/nyU92AT9goSU9SqG8/30sz
 vlXciONEg0wEsieA4Sxv6XrvNi/pms0dAu32iUTeQyzq7ahW8RdguEzCZq/yn4T/43
 Bklwz0KM3GESSZxeMg5OkSSADTuVmokD9AXmYB5r97QLp/GrJxrxDY5EaHp/DOCwaO
 wX97eJjaF7o+wMncyJHvaXj7xL44btVTKuM1AtCCrCHklwu3PhHh2NCv63JEHpH3hr
 U/iX2Zjvv6Joj2WeAkXCR5ZguyCkaByNsy8MlTJlqGBrp7oWzsHZwsu9RBmhlZDq1G
 sX+P7WsVca7SQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 63DCFD0D172;
 Wed,  7 Jan 2026 20:28:17 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Subject: [PATCH v3 0/2] Introduce Pixel config fragment for chainloading u-boot
Date: Wed, 07 Jan 2026 21:28:14 +0100
Message-Id: <20260107-pixel-config-v3-0-02a25e3fdcfa@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN7BXmkC/12MQQ6CMBBFr2K6tmRmoAKuvIdxAWWASQyQljQo4
 e62bkxcvv/z3q48O2GvrqddOQ7iZZ4i5OeTsmMzDayli6wI6AIIpV5k46e289TLoIsWTMXWFoy
 tisriuI9/yt0fkUfx6+xe33rAtKaQgZJqhLw2kCGaAgrQpLsmSHeTTdbMvlWyA/2MCggAc1Nnh
 ERR1vhvHMfxARwKWCXPAAAA
X-Change-ID: 20260107-pixel-config-4b058ecc4e1b
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Petr Vorel <petr.vorel@gmail.com>
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, Simon Glass <sjg@chromium.org>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Matthew Croughan <matt@croughan.sh>, phone-devel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1527; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=3SzK7zFNN2411j+CdvliX/rSTfJSXnP/60IXCawXpqg=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBpXsHgu96s46mCrxnpGsffw4TgllkxFfuWTq5+3
 iwbEQc5CqCJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaV7B4AAKCRBgAj/E00kg
 cpSqEADSu2qQuMc1MVOasA0CHhgfMV/kLoPVKLLZilp35ax//QRKLWCxPW+IgvXKfaKIsttQcMw
 o2OV+MFld7FZqyFgH91vpxnCCDqYqyAfGaHTbiSh3OYiczaZgvzaL12ltRYmjoozBiRrqVYbJOV
 EDE8XzbMWPRGy24rt+dGROHQj1eO3iBkx+ZLmd5fxgvA1pfIhvvZlTcJzxa//mgGyBBIhBLDY8r
 Anwv8mxcM+3v18lCPrcIUhK7haLVQhrc+LPim9Nqxg6/9rgqCYfeU/pvxoV508v1BnOhlNmnPxb
 +CQvSq2k28AWQTNGwo6jichmbID8WRQUlPabluUoGW5FRWokx89BdJixzyjjrmFWb2WdDbG6WpC
 M9qqdpEvqSlO7vjxKDF2bSoVMwlpecdkAzgfWdO/uBOh4b94zPApi5s3QJnw5OjKDxJYosWobHw
 vukify/BZa/llOL2Ew4mE/xOzqKonWVcxFqORjGOS5iHp7/UhlKCud0uFpVFEskjeWP3u+sq9hI
 kP3FhqcxkGwz3mFQ18/EutW+8N6URCKbfRcSohj4KX7TlT1cJq9+cIftAKaGUu2uiQ/DsccWPme
 oTWcqogBMNU6nQFQFGIy18KXaDGv1wmvdfnq9QFtCj7bP54q1dErhcG8M5kxznm61SPiCZ+UDJO
 /Cp4Hp3s/1f9UpQ==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
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
Reply-To: david@ixit.cz
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Snapdragon Google Pixel bootloaders require the TEXT_OFFSET to be
exactly 0x80000. Without this, U-Boot or kernels will fail to load.

This patchset documents Pixel 3 and Pixel 3 XL and adds the necessary
config fragment along with usage instructions.

It has been tested on Pixel 3, 3 XL (by me), and Pixel 5 (by Petr Vorel).

The corresponding DTS files (sdm845-google-blueline and crosshatch) have
already been merged into the Linux -next, so mainline U-Boot will receive
these devices support soon.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
Changes in v3:
- Renamed google-pixel3.config to google-pixel.config as it's not
  limited to Pixel 3 / 3 XL, but also 5 and possibly others.
- Reworked the documentation. (Casey)
- Reworded commit message. (Casey)
- Link to v2: https://lore.kernel.org/u-boot/20250802001359.2122103-1-david@ixit.cz/

Changes in v2:
- Added documentation of Pixel 3 / 3 XL into doc/board/qualcomm. (Casey)
- Link to v1: https://lore.kernel.org/u-boot/20250729103950.1154040-2-david@ixit.cz/

---
David Heidelberg (2):
      doc: board: qualcomm: document Pixel 3 / 3 XL support
      configs: Add google-pixel fragment config for Pixel 3, 3 XL, 5

 board/qualcomm/google-pixel.config |  5 +++++
 doc/board/qualcomm/board.rst       | 20 ++++++++++++++++++++
 2 files changed, 25 insertions(+)
---
base-commit: 53c0d5b387956bb4070a943b61991898373a20e2
change-id: 20260107-pixel-config-4b058ecc4e1b

Best regards,
-- 
David Heidelberg <david@ixit.cz>


