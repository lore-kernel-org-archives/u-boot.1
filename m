Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBE6C54EFC
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 17:14:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 172DD80EA7;
	Mon, 27 Jul 2026 17:14:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xilktvv1Cza1; Mon, 27 Jul 2026 17:14:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 568D080E9F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785172475;
	bh=l4inVWIdSg7Knph/btrdzlhjQ+WBjKain0JoHDoX6k4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vsia4rraLpNh1WaUZXEuTwbe29HG/vVxgnDXOK/p4M507mowBk9g0bcAzKllXPBle
	 //nVAMK8q3DJYNFkG7iuAY3cG2H0lk4SZt+9sC7T/swzhJuWwRdD3zY8nlbPRZo8b+
	 Hu/JLxb8AVmPc/mZTz7gYuMmzYZ+iHGVyj3srDNzzxw2txT+vXopcWkY7e2pj0rJtQ
	 URg6fIADOnKail2j215+1EUM7mfyGWPpvERrZ06Ey1m62PTY+VatPNW7QRoGQHSojD
	 7ZyaJIeHfN2DmkQ3gqIAx48wAC09+HzZxjwAfbPdP+1SVuj0TSAepLqZTMqdyL3NQI
	 4v5bE64VXsa/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 568D080E9F;
	Mon, 27 Jul 2026 17:14:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 908162E5
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 17:14:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 76C5A606EF
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 17:14:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XaZIZoyePOXh for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 17:14:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=igor.opaniuk@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7A416606D3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7A416606D3
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7A416606D3
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 17:14:30 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-47f904e80eeso2407099f8f.1
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 10:14:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785172468; x=1785777268;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l4inVWIdSg7Knph/btrdzlhjQ+WBjKain0JoHDoX6k4=;
 b=H8Em140qkAW+DTw2UPqAA9LIstSgj2CydzFSMKd2uizAfVXGFSSLzIZ8iwM7T9SK9/
 7kajfLTYnPM1MdVoe2cUgmnQhTbxWO07i9xHWKnZs5tkiZiODzUy7fn/4kjjfzfn8q5N
 yf/GVodlWZPhKXPD6/8Hg/EgMCmVcjBc/FHXOmFxl3X59l8DixUYBqW3Z4/AzMLmxLeg
 U+Hs8XklmSdr9Qrad8Zi3YDaRM+O8pkTA+XAk3XnygYldp77TyTmOzMXtIOjBwn/nMld
 ft2U563moiDidx26vJW/dhQrWWjjT+kdpjCq824J75zatwCVmkwFaib2JtEIhVFPK2bd
 vwNA==
X-Gm-Message-State: AOJu0YwXbF75LhxlwPY8MDTC5l1uhI9HxhAKXinUvd7G/u8NVaICSr24
 sTq0F5x6BULqE2sWmPKtBIKRd+RVio8KW8OjmGm+TCdm0F+PtxHp4KXF
X-Gm-Gg: AR+sD10Wnv5wIejEkpnRUQs5Jx7h6z8nfWo208SvHtX6f4xDd/oEFmsQB3SAWqPIM0d
 p81oPDrezfX4lChU/zxCQcbECz1hD1qyihIXVciwzLMdypKbeFlpa0oPpNUk7OxEikAso+XpXWI
 Q/qwdhcehrF23LdYW3rcjskz5OF887TXbFmXoQP6iLJNN2OjGpyBPyW2vDDsshgUNWicVbe7P4J
 kP2m7Ctivd5M7mzLm7r3UBoVvtYq5RTAdI+Qn/gqnHy4kyCozckylnatv0ag8BSp5LUa/b7ZILv
 ImBKUuZlv09iJrCSGuRyV2rCtxCyqfT9yiWKgdVXHJB0LekJh8EKdWJIfQcRbqS9amCWx5wGaxN
 2qQBUGaVLWubhyzm96PnrvWw+n2G/aSCn23YtE9Qo+PFISAPZcolvOsw0qAhKELzfc3LoNmFwDb
 h1+fWvK7P8ac4+CeJFru83tV4nu5//y3NWd27DOlmgC1hxNDdv1CCW6FBXCuEh+jTYf0mC9mtyv
 c5P+jQi
X-Received: by 2002:a05:6000:2011:b0:47f:8e50:9412 with SMTP id
 ffacd0b85a97d-47fafa71bcemr5094f8f.39.1785172468264; 
 Mon, 27 Jul 2026 10:14:28 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a5a2sm55287391f8f.7.2026.07.27.10.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 10:14:27 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Mon, 27 Jul 2026 19:14:15 +0200
Subject: [PATCH 3/4] avb: add board-specific root key provider
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-avb-root-key-pluggable-v1-3-7e27b2b92cc0@gmail.com>
References: <20260727-avb-root-key-pluggable-v1-0-7e27b2b92cc0@gmail.com>
In-Reply-To: <20260727-avb-root-key-pluggable-v1-0-7e27b2b92cc0@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Johan Jonker <jbx6244@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785172468; x=1785777268;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l4inVWIdSg7Knph/btrdzlhjQ+WBjKain0JoHDoX6k4=;
 b=EwmkfvK9b9gjiLcjJ2gCCJ2P+aAqxyafPkqni6S33V+ZZCdT+voy7ODJjlu9r6p0/l
 Rupuo90WBELk+CK3PjkDFlTMtBm/oYruN3uq4k9rh3c1EMJKLZo+e2arEdhoqaUIu5xb
 Ut7mXxVMCrghZPsNrcCPAAcqNpias0jdwjpuKPxCZAFcCtkjg2F8XNze3G7VUQP5w2+8
 C1k8Pe3WGcuLmYiTF69OMAzLHWom/26bE6PwJSf7oIAjIxI2mu6rMmniGGIaClUbr/QQ
 +Jiy2kuvPfb2/ZRtzk2FXE16y+QlcFYjwNafxZNih20RArgITdXNTejy0rTAlD8sY1nH
 H7aA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=EwmkfvK9
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

The strongest anchor for the root of trust is a key hash burned into
hardware (OTP/eFuse), which is inherently SoC-specific and cannot live in
common code. Give boards a hook to supply it from wherever their hardware
keeps it.

The default is deliberately fail-closed: a board that has not wired up a
provider refuses verification rather than silently trusting whatever key it
is handed. A misconfiguration should stop the boot, not quietly weaken it.

Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---
 common/Kconfig      |  9 +++++++++
 common/avb_verify.c | 13 +++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/common/Kconfig b/common/Kconfig
index 094635bfe57..110eaa0d004 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -929,6 +929,15 @@ config AVB_ROOT_KEY_TEE
 	  The digest must be provisioned into the TEE beforehand. Integrity is
 	  provided by the TEE's (RPMB-backed) storage.
 
+config AVB_ROOT_KEY_BOARD
+	bool "SoC/board specific provider (weak function)"
+	help
+	  Obtain the trusted root key digest from a board/SoC specific strong
+	  definition of avb_read_root_key_digest() (for example reading a hash
+	  fused into OTP/eFuse). The default weak implementation fails closed,
+	  so a board that forgets to override it will refuse verification
+	  rather than silently trust a wrong key.
+
 endchoice
 
 config AVB_ROOT_KEY_TEE_NAME
diff --git a/common/avb_verify.c b/common/avb_verify.c
index b8b99628180..b96cd1ebd7b 100644
--- a/common/avb_verify.c
+++ b/common/avb_verify.c
@@ -1091,6 +1091,19 @@ AvbIOResult avb_read_root_key_digest(AvbOps *ops, uint8_t *digest)
 
 	return AVB_IO_RESULT_OK;
 }
+#else /* CONFIG_AVB_ROOT_KEY_BOARD */
+/*
+ * Weak, fail-closed default. A board/SoC selecting CONFIG_AVB_ROOT_KEY_BOARD
+ * must provide a strong avb_read_root_key_digest() (e.g. reading a hash fused
+ * into OTP/eFuse). If it does not, verification fails rather than silently
+ * trusting a wrong key.
+ */
+__weak AvbIOResult avb_read_root_key_digest(AvbOps *ops, uint8_t *digest)
+{
+	printf("%s: board root key provider not implemented\n", __func__);
+
+	return AVB_IO_RESULT_ERROR_NO_SUCH_VALUE;
+}
 #endif
 
 /**

-- 
2.53.0

