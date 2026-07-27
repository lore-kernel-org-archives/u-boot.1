Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E17BC53209
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 17:14:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7933C80CA8;
	Mon, 27 Jul 2026 17:14:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4mLEmR8KACpa; Mon, 27 Jul 2026 17:14:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B149180CB8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785172469;
	bh=3r3oF5LIv7CQdk5qNSEVXQWZReO4+JJiNRYX7+MRYTc=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZCHeBdw2jNSPKfwnZBezpb58GCHrnCFqCXUqFfpI160q4tZF+9WrfjJM64BjEgBP3
	 dFBNAJRzsRauuvTWeqh5hIfRjH9G3cqdeDxzTZGMA7kMp8rbwf3g9bxkxWPbcxdg9D
	 sZ07DrRFkWcVFgVsviFDBjQTMPWtUwZCMyJM8obm8Q8SGW4SnI92tJp8Bs7itOBPB1
	 duR03KGpQ1XAl8ARfOQR3fWg1jkbxRPvGMsbpuJzUet3A6ldLiALMPEan3/ZeyML+G
	 O6j3chCg7ty4IArQFmH2YXHiso+Ya5lucAfi4+fMu6CHPyLWzlCoBjJTCBwsOD5F8o
	 aR+ubssc2/tAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B149180CB8;
	Mon, 27 Jul 2026 17:14:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id ED4CF39E
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 17:14:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D74E7606EF
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 17:14:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zRpltocObjiQ for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 17:14:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=igor.opaniuk@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D35CB606D3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D35CB606D3
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D35CB606D3
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 17:14:27 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4954dff6536so21767305e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 10:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785172466; x=1785777266;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3r3oF5LIv7CQdk5qNSEVXQWZReO4+JJiNRYX7+MRYTc=;
 b=YoG+uKfX3qkQtKO61CSZF+0cfXPetbAlh8PTDS5pGmyV4ZVmN50RUkEnZI/6mFF0LJ
 ypOE0GPQywwYkI+t4aFKFC6wUDECTpy0uaZmGLT6Dw4+OdDcm9RdnwB8UHJhRzjJlN0d
 RHIdxgkQClPwGDawzWAtarMyFWOzo8TKH8bE098+cItgkGznkcN/MqAwyIAHfjiLcw7k
 MQUidZ3ptYhjEXndwIcn+1YmBohPPgeoKTJqVL2tvem/6aok8kBJ10c6NB8BWXvFX+gM
 6ta+Rn9tCaG3qNDvI8x16G/oFPJhBC7Yj0zyJonI6lVB8tK6psYXNPeqPh2+6dTnVzaU
 5eoA==
X-Gm-Message-State: AOJu0YwwCeA4Oi1fAEUdnfgokki7cxgPS41eP7+HG5l7l29ximbs+0bu
 B2DxNuAq89IPymn/vMXuHRndt4ILDyxGyiivIVgtySGgWdYn67rBYyFb
X-Gm-Gg: AR+sD13BqtblqVaaoB/rS6UmiHCAKf5viMS3ledSGB5+u/p2DKPmcb3dB02AMCWKyoa
 6fwgQTqc1316FEdPgxTYPp4c4GtP2JPURV0YI+af8YpnQ/PhbjQyACjxa4ztvSEziPhGm75Y2cl
 Dl52gzex6WtYY9nR1TXGw/y4jWsU2037eZnnJdAVnBB1sZvi9XzRr+HdrlVsVG09O8oKY4JyzV1
 kBhX3ZrPy1icsJxp5tgbTS1HOKmKgrQhWv67vJbw8abbZsFjgZR8baablpTARwLbLhtZFgoKEES
 XTNr8kkEJY53eRIycKwjlivujtnH1uKENvZuHOow+bQsZtCDXq9noos4s55jcpHkgfnewGGdiIB
 g/k9TVh/aUs1qr5ZL5QILtA0v8kXDiFjkJqxd/jlUxBTtgss8qX7vHEqrtQqfT8iwnxJ3J0zcsW
 +7budUV1Koz+2TJBoUJKDcRAev5lybJ8PFRxGorByBdl3abchDm9L9/UqtN6kT3kPrPNAsAg==
X-Received: by 2002:a05:600c:6298:b0:493:ee2b:c876 with SMTP id
 5b1f17b1804b1-496b572e686mr121041735e9.35.1785172465553; 
 Mon, 27 Jul 2026 10:14:25 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a5a2sm55287391f8f.7.2026.07.27.10.14.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 10:14:25 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Subject: [PATCH 0/4] avb: make the AVB root key source pluggable
Date: Mon, 27 Jul 2026 19:14:12 +0200
Message-Id: <20260727-avb-root-key-pluggable-v1-0-7e27b2b92cc0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ6CMBBA4auQWTsJHQk1XoW46M9YRwklLRAJ4
 e5WWH6L9zbInIQz3KsNEi+SJQ4F6lKBe5khMIovBqqprTVpNIvFFOOEH15x7OcQjO0ZG0dOae+
 vpG5Q4jHxU77HuHuczrN9s5v+N9j3HyuDmqx6AAAA
X-Change-ID: 20260727-avb-root-key-pluggable-4c2c17dd3218
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Johan Jonker <jbx6244@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785172466; x=1785777266;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3r3oF5LIv7CQdk5qNSEVXQWZReO4+JJiNRYX7+MRYTc=;
 b=Inp4NJZRPr9YbTL6HnS757IEPH+hxeKMUHUf1A3+VM01ir4csbq6pAO2l26R+dPFb+
 teGhnpbXTcPuiHB/vvXb1aDUu3Qa72zkXUweK0JyTyczIaXlq7BLEmJo6fkJZUHPQvNk
 Y7zmhm2xLDTd/jIAiZM4k00HQrbm9wa4vNYsl+F8fNylISG/UhS0/6qdbcyE2tDmycqv
 +AYXZM1NhIamZhd1reoW+KhIqikap9a/U0Lz+ImxjZLrodpkg6ViVZDUpD45p6wL+7xr
 TU9zHSfApxBSaB779+4CBCKBMGuT+t2n90GlG8u7VZ9gGFIbPf4uX/iz+to1fEpAzJFL
 A9cQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Inp4NJZR
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

AVB's entire chain of trust reduces to a single public key, and today that
key is hard-coded in U-Boot as the AVB reference/test key -- whose private
half is publicly available. That is fine for development, but it means the
root of trust for a "locked" device is a key anyone can sign with, and there
is no way to point AVB at a real, per-device anchor.

This series makes the source of the trusted root key digest selectable via a
Kconfig choice (CONFIG_AVB_ROOT_KEY_*), while keeping the actual trust
decision -- hash the vbmeta key, compare against the trusted digest, fail
closed on any error -- in one place in validate_vbmeta_public_key():

  - BUILTIN (default): SHA-256 of the built-in avb_root_pub blob. Unchanged
    behaviour, still the dev/test key, so nothing changes for existing users.
  - TEE: read the digest from OP-TEE secure storage (the same RPMB-backed
    store that already holds the rollback indexes and lock state), via the
    existing AVB TA persistent-value interface. No TA change required.
  - BOARD: a __weak hook a SoC/board overrides to read the digest from
    wherever its hardware keeps it (e.g. a hash fused into OTP/eFuse or
    U-Boot proper dtb). The default fails closed, so a board that forgets
    to wire it up refuses verification rather than silently trusting a
    wrong key.

The last patch documents the choice and its security caveats in
doc/android/avb2.rst (built-in key is dev-only; a TEE-stored digest is only
an anchor if the TA refuses to overwrite it while unlocked; the board
provider fails closed).

Note this only concerns *where the root key comes from*; it does not by
itself make verification enforcing -- device lock state and rollback
protection are still only enforced when backed by OP-TEE.

Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---
Igor Opaniuk (4):
      avb: make the AVB root key source pluggable
      avb: add OP-TEE root key digest provider
      avb: add board-specific root key provider
      doc: android: document the AVB root key source

 common/Kconfig       | 50 ++++++++++++++++++++++++++++++++++++
 common/avb_verify.c  | 72 +++++++++++++++++++++++++++++++++++++++++++++++++---
 doc/android/avb2.rst | 37 +++++++++++++++++++++++++++
 include/avb_verify.h | 19 ++++++++++++++
 4 files changed, 175 insertions(+), 3 deletions(-)
---
base-commit: e6f091a208276db72596c8f7376648856a276d97
change-id: 20260727-avb-root-key-pluggable-4c2c17dd3218

Best regards,
--  
Igor Opaniuk <igor.opaniuk@gmail.com>

