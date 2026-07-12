Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DF6C43458
	for <u-boot@archiver.kernel.org>; Sun, 12 Jul 2026 12:44:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACAE0849A9;
	Sun, 12 Jul 2026 14:44:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lc/pHW5a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91F1B848A1; Sun, 12 Jul 2026 10:50:50 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9B1E844F6
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 10:50:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-69c5f6f7a40so1855369a12.0
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 01:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783846248; x=1784451048; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PPAdTqwVDXfzfTrQ7af6ei4e09oXkWxDXviP43iUbn0=;
 b=Lc/pHW5ajX7KROzMXpGXdZ7ObPRw+sex0od1tPi08+VAxlHHgOBY4biBDlcF9iVaUU
 iq5xHGYTiw/5nmKXtIQXraYsDfgbSoqmkRZ5zvPtVUCkC30zIYOy+2OcpdxE73YBJ3pY
 BYNMg0t2SbL/8Ebc3LIl6nOXjw1nfdtLGkP+NpR7HSKgV9XOCEvuxOg+sY1acfRwhrtR
 mssxf5jqMkoOXYVptzMQrpHVRDUseuT6tNrQy9uWENN6kjaKZVAhOMERCJi42Q+kOuhr
 HibKZ896gCFy837BGu4PAO+jqXebjG5LfASnXrqZ3GxuhWiNFKFBCDf/FDSgp634uLGN
 hrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783846248; x=1784451048;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PPAdTqwVDXfzfTrQ7af6ei4e09oXkWxDXviP43iUbn0=;
 b=i9T6HJaCvzmH1vY3+YpNYPPLjy+qH9GMwuNNlr0GYnF/dEcOIOutzOeu4EQdOeXpLl
 U31pfXfuCg0UcFL047Ng8jzmA7K2THJGfeqXXOuRKgOX0Qr88OBKX9KIAZ6SUj2oHoWO
 GIQEXai1nxIn+a7wu3FnArD+Wqs+5Evd7E3v9B+zZNtmrmBBSZDHUb2slAy4cqMk+JVL
 WqhYR1SMndKH7lO4buPhMhhr4cOCS39H12vsd8hui0D7XElHFF9PJ9m2vCcycbyybAuW
 3qLSn7ScSENoQP7ivYEIkeQDNoNImDZLUlb0crjxdJCdSBSAOSjkCY9f4G3gPC/g0xVp
 WzMA==
X-Gm-Message-State: AOJu0Yy0k2K1Qgg34rSp4vakZmKIIIIWZZytdfkVjUglVHGms0kA6UBY
 N237YkIisryzrFT4v7Zcv3sYXidB488mZHWZVXKGPGXQyA6IlfrMg3qi
X-Gm-Gg: AfdE7cmfpLu9z4uz+RCty36q+hooBXcEvvVYUpySdWph3qb6gGJ4pvUqg5iw3Gsp1rM
 8akLjiVrSgTrEQAgnsNLCIGHbClEbg3BTk2Q83qrjaW+1NpzBBOCqr6+Q/RJGe6Rq1fUP4NtDzj
 9edccKGQPuzVnjYbYuP9+5AEDkkNVg0Xb1aTIry7Jw5Az1pA/2hHAXteA1sjIEyjUzEarrriQSa
 jUIrv4EzP1Ws9AJCDZejzDoG/WPP2j67eKC2jid8VkWwlr2QqZz3DxdvSDmO5vX9k6P89kKWo5j
 kY8+MAfaK+87azHrzuIQnVndyLbjs224LAs8H8uYFTTX6Y/0vYxmdZUzosSaEU84LTKW+IXRXP2
 V8H1JWIGqfCxVRrVQ14uB2JCTpqOMAT7R98HVl3EsCE0vmEzktlsuvqW7szw4GNwRofCpSqWRlW
 SL/0E+t8LMkvvsBRkiNseOCLUfGd8bfkd4CJ+xhc0oJzMqZPmFwkiXe2R+WP/mBvt914EcyWXOk
 2A0sfFJ
X-Received: by 2002:a17:907:1ca0:b0:c12:80a6:2df9 with SMTP id
 a640c23a62f3a-c161e9400admr219684066b.8.1783846247898; 
 Sun, 12 Jul 2026 01:50:47 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15de6c565fsm525483966b.2.2026.07.12.01.50.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 01:50:47 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Subject: [PATCH 0/2] avb: fix memory leaks in AVB 2.0 verification path
Date: Sun, 12 Jul 2026 10:50:19 +0200
Message-Id: <20260712-avb-fix-memory-leaks-v1-0-51d6d5a42631@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MSQqAMAwAvyI5GzAVF/yKeKg1alBbaaEo4t8tH
 gdm5oHAXjhAlz3gOUoQZxNQnoFZtV0YZUoMqlB10ZBCHUec5cKDD+dv3FlvAduSzDw1rIgqSOn
 pOTn/th/e9wPtGLXHZgAAAA==
X-Change-ID: 20260712-avb-fix-memory-leaks-831cfd7e2115
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>, 
 "Nicolas Belin (TI.com)" <nbelin@baylibre.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Sun, 12 Jul 2026 14:44:41 +0200
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

While reviewing the AVB 2.0 integration I noticed several memory leaks in
the verification path that accumulate on every boot.

In the Android bootmethod, run_avb_verification() allocates an AvbOps via
avb_ops_alloc() and receives an AvbSlotVerifyData from avb_slot_verify(),
but frees neither on the successful return paths. Every boot therefore
leaks the AvbOpsData structure, and with CONFIG_OPTEE_TA_AVB the leaked
AvbOps also leaves the OP-TEE session open (it is only closed inside
avb_ops_free()). The AvbSlotVerifyData - holding the kernel cmdline and
loaded-partition metadata - is leaked on both the locked GREEN/OK and the
unlocked ORANGE/ERROR_VERIFICATION success paths.

Independently, the AvbOps I/O helpers leak a struct mmc_part on every
partition access: get_partition() returns a malloc()'d descriptor that
only its internal error path frees, while none of its three callers
(mmc_byte_io(), get_unique_guid_for_partition(), get_size_of_partition())
release it. A single "avb verify" performs many such accesses (footer,
vbmeta and the hashed image chunks), so this leak grows quickly.

No functional change intended: the GREEN/ORANGE boot-state handling and
the locked/unlocked acceptance logic are preserved.

Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---
Igor Opaniuk (2):
      boot: android: fix AvbOps and verify-data leaks in AVB path
      avb: free mmc_part allocated by get_partition()

 boot/bootmeth_android.c | 37 +++++++++++++++++++++----------------
 common/avb_verify.c     | 29 +++++++++++++++++++++--------
 2 files changed, 42 insertions(+), 24 deletions(-)
---
base-commit: 6741b0dfb41dc82a284ab1cff4c58af6ef2f3f9c
change-id: 20260712-avb-fix-memory-leaks-831cfd7e2115

Best regards,
-- 
Igor Opaniuk <igor.opaniuk@gmail.com>

