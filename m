Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24519CD6E6D
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 15:31:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74E2984908;
	Thu,  4 Jun 2026 17:31:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="xOV5A/zv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9721848DF; Thu,  4 Jun 2026 17:31:16 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3A06844CF
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 17:31:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-45ef1629ff4so679150f8f.0
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 08:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1780587074; x=1781191874; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9SVKWgPx4rw7OE6c1D9tE7CL1n/WhBLxdfBUx76JCQg=;
 b=xOV5A/zv2jert6SMmSVDUSp4vf8jP8vNnkAfCeI1UxekmJmdr6dVSHW2O+EdbfVcl6
 3h+zibNQDLLDxLYXxSTsYuRPbAs2TEufBmTgLHAcTOBET7Y2X1isQrAevbPBvtfGD319
 dsqQYAcJJUhj/vB5EpVcdVaZqiRMom1x8eaJYzWuXR2lkK9HHF8WBmgUtnXsTbYOUXHr
 rfOCddTGamh3Yr0lYUBUI7kLMtf7lMCbAxKRMg4Ao8BmgRHs56Eo74BTyvqigA7i6wq0
 PPhen22M1qCr+L82SiAQKyzkERfi+jlXGKtBPpOMWD2+tiORAMwL+e+OtNYbfAjB8Szn
 wD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780587074; x=1781191874;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9SVKWgPx4rw7OE6c1D9tE7CL1n/WhBLxdfBUx76JCQg=;
 b=iWK7y4R+tDRLU6b4x86kS1hCDGU7OYaNzYuRh6/rlPkI8gGJDRTbnIhAYFbWrq+qUP
 xuThhpqAzl6hovtzKbfVDTMKHWtfpERu6qP+dwzb9lkcLGuaVYczOhCrdyBocUvvUmDG
 Kp3+cT2acdVzOwpVeO8fy7mTAD15ctFhsa/soLTnVZsBju48pnXwP6dUOp3A5Zqs0d25
 mUtgTnTvlusRZc1QjRkq9QLXOeM1Thc4SdTRRya9bTv9YrkNkRIaJjTZ2lEgLeo4KwdM
 57GeRCn/Zjfguqh3CLy+ockYvOJKt96hmT38bqATEI+bIe2s+IyN9jXbU+w4BL7A9Sx2
 H1EQ==
X-Gm-Message-State: AOJu0YyGr8LpbIgOjkcVYCSp25U31XUPfoHqUYf+/NhxA1Tyr4l95vwK
 EDjQGg/4/Oi0/zLHjQx4uU+RtkMTHgNjs05kZBEWLimX5UYCGQwRwKzHl2GAfAte7gs=
X-Gm-Gg: Acq92OFz3QaObGk7ke19Hk+2YHvGasSKy5HEaVMVQ8qEKHwjObL7JjT33f1J5y7TVx1
 veAo5lT1/oVwLpiY525F5ykcCcS29XvrmNQJnzmdzCm1zKjmHtt6V8+EcfxdUMk26i3AxbeT3Zi
 lOhjCLFMwBEtGjmvEClvXSWhObEJWs425fkMYJiSkZ4vF0LSerdhRWDYRk4bGIf6t8n9GOOAd2p
 D4is479IecvCds/E2QoKxGg2SCc7X7Xx1hgzx+41SIyjyBJi1O5O15mCvKfshGLpqTDdejEAEwx
 C+EXH6Ejodjt/kCHd54gz7dpJKUPPo41IUF7zeShoL+vtU8tawygbJYntAgLq0wA0NhF0RhelcB
 /HVMHaCck026WRGYuydYNgu82lN2sCOQt3IXEC+ViSC6RvfYSe2wGAG/yFq2j8NxD05ggAhpbMw
 8X4mku4IXt2kr8G2rMowwCRFHHILmlximDGdb7owlwhdb+d8SeskY=
X-Received: by 2002:adf:f484:0:b0:460:efd:c682 with SMTP id
 ffacd0b85a97d-460218271b6mr11462776f8f.24.1780587074145; 
 Thu, 04 Jun 2026 08:31:14 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.92.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f351ac0sm28284932f8f.27.2026.06.04.08.31.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 08:31:13 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH 0/7] pxe_utils: small fixups, implement BLS type 1 boot on
 top of them
Date: Thu, 04 Jun 2026 19:31:05 +0400
Message-Id: <20260604-bls-v1-0-4ce6d1ee4711@flipper.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMwMT3aScYt2UJLNEY4MkS0PjxFQloMqCotS0zAqwKdGxEH5xaVJWanI
 JSKtSbS0AV9wrs2cAAAA=
X-Change-ID: 20260604-bls-db6a30b913ae
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Simon Glass <sjg@chromium.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Martin Schwan <m.schwan@phytec.de>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1813; i=alchark@flipper.net;
 h=from:subject:message-id; bh=OCwnK20O4DUPFHd5HxSInTzPZarUkB761vJqxYGnsRs=;
 b=kA0DAAoWsqLYjxBZ1KUByyZiAGohmj6gsNMHnfAvQgHBQZjHmm3bEgQs3To5NK10BBJ5WBZkc
 IiRBAAWCgA5FiEEnfakPZUyDpq6SEj1sqLYjxBZ1KUFAmohmj4bFIAAAAAABAAObWFudTIsMi41
 KzEuMTIsMywyAAoJELKi2I8QWdSlojcBAMFiC238BbFGK8cEzgMw0qpwDTZkP9uUiKwtgc9QEai
 EAP4kYFtSzjsHc6wOrONys7gAjidMxASNgBMDxKkz5//RBg==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

Add support for the Boot Loader Specification (BLS) type 1 boot entries,
as generated by default by systemd's kernel-install when loader=bls.

Given that the format of BLS entries is pretty much the same as PXElinux,
reuse the existing library for the parsing logic.

BLS type 2 entries are out of scope, as they are effectively just EFI
applications and should be booted as such.

This implementation is also only allowing a single top-sorting entry to
boot, as the standard boot infrastruture currently doesn't support
multiple entries per partition-bootmeth tuple. I have a proposed extension
to enable that and will post it separately as RFC - that enables the use
of `bootflow menu` to select the kernel to boot without jumping through
several menus with different behavior as is currently required with
extlinux.conf.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Alexey Charkov (7):
      pxe_utils: fix W=1 kernel-doc warnings
      pxe_utils: accept "options" as synonym for "append"
      pxe_utils: extract per-entry key parsing into parse_label_keys()
      pxe_utils: export per-entry label helpers
      pxe_utils: optionally ignore unknown keys in parse_label_keys()
      pxe_utils: accept "title" inside a label as a synonym for "menu label"
      boot: add a minimal bootmeth for the Boot Loader Specification

 boot/Kconfig        |  17 +++
 boot/Makefile       |   1 +
 boot/bootmeth_bls.c | 333 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 boot/pxe_utils.c    | 134 +++++++++++++--------
 include/pxe_utils.h |  62 ++++++++++
 5 files changed, 499 insertions(+), 48 deletions(-)
---
base-commit: 31af00bdc6a3ab5d4ada83e08407f2ce289f0ec6
change-id: 20260604-bls-db6a30b913ae

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

