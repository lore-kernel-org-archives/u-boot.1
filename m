Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 794D1C531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 17:14:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1681260730;
	Mon, 27 Jul 2026 17:14:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VxAmI2fI5qBc; Mon, 27 Jul 2026 17:14:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3356F606EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785172474;
	bh=FAHw822Kt6/NW0lVXibTqgZ2CD1rXhCRCG+CN55yQFo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jGAE7SrSp9lf4wC82HBgJ7SMCNnQyAvu8RVlzZ9oCQAXNS8Y9kdUKaM0pYk/qt6hu
	 FSWVjT6yceMWuHplYD4fXqdRUmpJGsOyRqzU5wTtNUYOdVyDqFnUt30xoUMQNdWU03
	 1VUxml2QZ6johF0j1OML5jKRhNI2PneemIyhP20mBr4VnS1P70/z9tj4Cf1pIlqySY
	 03hf+kv+Zlciya4r5RMotxEY0xRTWc5JS6Ru7vJGtcdn8FN0hLpI2JvpaftZu7OGVB
	 pFxC40OZScAGVLpTy+SfuVSlxcclFlVTrJwuDj+Dim06WwrS0tZQ2RKlNPtLii7bQ3
	 e8TdWrzj4lErg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3356F606EF;
	Mon, 27 Jul 2026 17:14:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 72C94350
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 17:14:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6377E80CA8
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 17:14:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IWavXnUZ261L for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 17:14:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com;
 envelope-from=igor.opaniuk@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 75A5E80C46
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 75A5E80C46
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 75A5E80C46
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 17:14:29 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-4799b3f7c83so2072687f8f.2
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 10:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785172467; x=1785777267;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FAHw822Kt6/NW0lVXibTqgZ2CD1rXhCRCG+CN55yQFo=;
 b=JzU0IrFR3X8smBFQZjSUxzsItIEHaS1Gb6H2XdPEYpaQ2julcilBoe0XEgEzBySdJH
 0tGZyf3BpSUag8WSWDPnvf7QPINz1rI2RUeCJrc+0WvySChQVpZhkt+SIBx2oEPFbIl/
 XY787xtR5hLTGOCOyOhEABBj/hWU9eYNFJm6dzRxRJAi4cv7G5OxJQE+T2h0zMOJVZvM
 7LPdBSXt86TE9i0I0n7ZtqciUhpFGx1RwHH7I/SYNBKap2na+PgwgY5lNCKKuK71rY75
 VTScs4Cq82dldkx4jNapQ8Bh2qR6spyKflXM+K7weu6b/7bt6FASzkGLygVyDzOiAdNe
 B9NA==
X-Gm-Message-State: AOJu0YwP5bHTZVRJZxdNcQIVaaH69IisgijBmnybilYGRdb9VQRz5cRh
 K5EgoxS9VM60aLDHCuKSUXcDB8NnpL6K6xSHAYbJR5BnuVYFqmDizmr37H2vlV4n
X-Gm-Gg: AR+sD11rrS3fGXSWwhHm3lBSj4wYsvaf8nqpjHFrQYBDGqa4NFEASJiXiF5abJHOSIN
 D5q4ZvuFhfFxDV6XKAX5Z7V03QVibWjvNq6S8SvyKtJVHZhrNNZLGRYNp9jqihPv+oBJII1ZPGg
 EwqTSHplfJMokB5mvcBBvL70hoA6sTdLRNdoZN2S8I55PF+amIWx1fQzWvGpac+jNZMfhX6Nx0Q
 qde0AkB4A/9KNoDFnx5DG+O8fy9vhXHs+14w0KEiXkY+DZdiN8glTuo5vjV4r2JSAEZpeksalyV
 AaAcFOWgmbS5GwBGdWlIK3vy6UH/fIq8bBgkh5ZT2dilbaXRJH+7Ei6dMqKZ1wgI03p0S0BZF/H
 8UAEtBZvu2Y+ZKpIK1x9vbsuPhm4w4x4l/7vwH71ZSz6o0R9ltPtkKd402FPPF+EhkH3Sv2EeCJ
 9mQT863eXnn9Lnx7s1HX1sKMs08oFiXC1tYjOngAyer8THwh4PbmxeQ4S945rxRRRXX1O3QA==
X-Received: by 2002:a05:6000:430d:b0:474:cd60:1154 with SMTP id
 ffacd0b85a97d-47f9fea193emr12058637f8f.41.1785172467349; 
 Mon, 27 Jul 2026 10:14:27 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a5a2sm55287391f8f.7.2026.07.27.10.14.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 10:14:27 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Mon, 27 Jul 2026 19:14:14 +0200
Subject: [PATCH 2/4] avb: add OP-TEE root key digest provider
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-avb-root-key-pluggable-v1-2-7e27b2b92cc0@gmail.com>
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
 d=gmail.com; s=20251104; t=1785172467; x=1785777267;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FAHw822Kt6/NW0lVXibTqgZ2CD1rXhCRCG+CN55yQFo=;
 b=gBxBbfYzE6I5FmqOYpraJHxxUj2kf2FEjmlr8Nwf4Rb2Lguq0ojZ0MkNZ7jaGJoda9
 q3US9e/9HcHP5VA8Cc/JhwMeJGJz7Ui/b2ywc+Zr1y5waBNpejs3Are0STSRApNy8vzP
 +TlKgqYH8QpoVzqUqhuL+yLOkxUo0JCsV+60jknEmu+IW807/ylLrmuMBencGG5pdEid
 B8GjdEjLfvytQUY8rpGbYUSdvztxIrjEkdyvnyw+pQm1pHQaFh9nEHOzcqRU00jx0df6
 4pwjh27JxowFj/j0sPjtGWpX67tgVQMcedyO6VnFqcgROtTFADkTVsghJpdwZTiVuSk6
 +aqA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=gBxBbfYz
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

When a device already runs OP-TEE, its root-of-trust key should live in the
same secure, RPMB-backed storage that already holds the AVB rollback
indexes and lock state, so it is provisioned per device and protected by
the secure world -- not shipped inside the bootloader image.

Let AVB fetch the trusted digest from the OP-TEE AVB TA. It reuses the
existing persistent-value interface, so no change to the TA is required,
and a missing value fails closed.

Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---
 common/Kconfig      | 23 +++++++++++++++++++++++
 common/avb_verify.c | 23 +++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/common/Kconfig b/common/Kconfig
index 654e78b7b7a..094635bfe57 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -920,8 +920,31 @@ config AVB_ROOT_KEY_BUILTIN
 	  the AVB reference/test key and is intended for development only;
 	  replace the blob for production use.
 
+config AVB_ROOT_KEY_TEE
+	bool "Read root key digest from OP-TEE"
+	depends on OPTEE_TA_AVB
+	help
+	  Obtain the SHA-256 digest of the trusted root key from OP-TEE secure
+	  storage, read as a named persistent value ("avb.root_pub_digest").
+	  The digest must be provisioned into the TEE beforehand. Integrity is
+	  provided by the TEE's (RPMB-backed) storage.
+
 endchoice
 
+config AVB_ROOT_KEY_TEE_NAME
+	string "TEE persistent-value name holding the root key digest"
+	depends on AVB_ROOT_KEY_TEE
+	default "avb.root_pub_digest"
+	help
+	  Named persistent value read from the OP-TEE AVB TA (via
+	  TA_AVB_CMD_READ_PERSIST_VALUE) that stores the 32-byte SHA-256 digest
+	  of the trusted root key. It must match the name used to provision the
+	  digest into the TEE. The TA prefixes stored names with "named_value_"
+	  internally, so this string is opaque to the TA; the "avb." prefix only
+	  follows libavb's named-persistent-value convention and does not collide
+	  with libavb's own reserved names (avb.persistent_digest.*,
+	  avb.managed_verity_mode).
+
 endif # AVB_VERIFY
 
 config SCP03
diff --git a/common/avb_verify.c b/common/avb_verify.c
index 7c6baa33ed8..b8b99628180 100644
--- a/common/avb_verify.c
+++ b/common/avb_verify.c
@@ -1068,6 +1068,29 @@ AvbIOResult avb_read_root_key_digest(AvbOps *ops, uint8_t *digest)
 
 	return AVB_IO_RESULT_OK;
 }
+#elif CONFIG_IS_ENABLED(AVB_ROOT_KEY_TEE)
+/*
+ * Read the trusted root key digest from OP-TEE secure storage as a named
+ * persistent value, using the existing TA_AVB_CMD_READ_PERSIST_VALUE command
+ * (see OP-TEE ta/avb/entry.c). The digest must be provisioned into the TEE
+ * beforehand under CONFIG_AVB_ROOT_KEY_TEE_NAME; a missing value returns
+ * AVB_IO_RESULT_ERROR_NO_SUCH_VALUE and verification fails closed.
+ */
+AvbIOResult avb_read_root_key_digest(AvbOps *ops, uint8_t *digest)
+{
+	size_t num_read = 0;
+	AvbIOResult rc;
+
+	rc = read_persistent_value(ops, CONFIG_AVB_ROOT_KEY_TEE_NAME,
+				   SHA256_SUM_LEN, digest, &num_read);
+	if (rc != AVB_IO_RESULT_OK)
+		return rc;
+
+	if (num_read != SHA256_SUM_LEN)
+		return AVB_IO_RESULT_ERROR_INVALID_VALUE_SIZE;
+
+	return AVB_IO_RESULT_OK;
+}
 #endif
 
 /**

-- 
2.53.0

