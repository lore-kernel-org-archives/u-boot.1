Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EAD606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kiR2A/d+;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=dqIBECi9
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 216A360852;
	Wed, 21 Oct 2026 16:05:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h5cvi8N3BcQp; Wed, 21 Oct 2026 16:05:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6026260896
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792598724;
	b=ZpZmMZjn7RjYf5Ku3oqLs0TdIrj4hC9yvdLO/CyNe/BwolT1cOr0lV1n3+r7L8wv5Y3W
	 c4jO7UJDM/voUL6PWGaUiwYUgRef4KouUk0vwDnMsHJkh+oqwsE7n+jofVaLE0gP2S4sN
	 6niNcF+6TjtjY6Q4/3jeZKC0JYHH8WKsBtKYz17fywvuWm4cwCjk5eL0DncVvx59Q7Mec
	 PhG0BAL1T/g13bimGuQbTgGZ0uHGzgo2ionn99yp5/5AKauooxvfqI2GUII3oGnAklZoR
	 IhTDeAf6+sbYEJdEFgcl+NOvwQQqTP1Uldt8BgCmTsCLuf/Ow2/wkAKMJ4oatJLvxBw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792598724;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JA1UdTEk6/zCrVoeW0V5BinIIfMptVTl063ciPGXTyA=;
	b=NFB3jLpgEJB3pruReV0ihbm1ggeGbm2oTjVfDFbkvW+TB9Yr3/4sEVD4z9xrfwWcn/jw
	 /l1/LqLsiB6NzQDT23If2xnrmr15t+hmL0obYPyR3klJ9p/x+AiksJB8OeWr4U88yEDVY
	 onlgkr2QTncIqCM7B/mbDlorsUjYfSi424+ggvW+SnB8ORwuSsWV1eajrEuhQT3NsDWV3
	 Y4CgAny8LXCoP2nBoD1uauh6SowGS2UK+Mdl4YBhPQ45C+n4+hyoi380PnaFNaV6W50K0
	 mA3lZAe2VqrO5gA8o5NIO723/r6EDOo8DCNnHFRb7iKaMpO7gcR7uWrsAMrdYOrU9tw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792598724;
	bh=JA1UdTEk6/zCrVoeW0V5BinIIfMptVTl063ciPGXTyA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kiR2A/d+A7zukBrwv6JR3ZslWmFfWlQiwCwlQxtCoNWWh+G/fIwP2FHf8FitsqH5y
	 +LkMZdHKqKTeqlbCBOMJdEOeJLgR0qkfU8JlgzKHnriT9J/OQkA0aMb+Zn1wStbLWB
	 5cIN72fnxe0V3rWzxnH17uqbfCxS03lBbiecew+sxfmo03AuW7TKeJaAh6PQR12UCW
	 TBu9fqz6U7EdiPMtM2WqTuRRL4d4vEw6zHPO9h4dpfdNZUzB2pRpaEtRXThytwIJCS
	 kiECSipXxNXmOkhHbUGd3+vFCMAv4i9XkialeazE6Hvnv/Ktb8qLMhyla88CJAb+Fx
	 yFQcgExo6q/Bw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6026260896;
	Wed, 21 Oct 2026 16:05:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 49AA7356
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:05:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2FC5F4039F
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:05:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WR7j3q_SNnt1 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:05:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1628D4016B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792598722;
 b=S8cBwDePN70jJtqxGSt4Qo1iim9dW82ZH3qu4bPKc/AaypuHY7vARFv+mba/XGBE9oE/
 DgE+PklCNaixI9lahG8v2q3CtCJYlbrRe+MoDd2EvWbi1KOGBmmM1rVjeKH9rmChjzcIz
 otS143/mQ25IXmh6qZ0vRF8wq0d8W3vvaSrFfE+cYq+RKizrt7ttyE2Bkh06OjZjikUJh
 InOyF0xhvHl6EQrisnfI9TAbPI6zhcC5y+hVLMOBRl87DpcS9MbQeeXl4EYw3YhM2gJDu
 8VPN/EaEpE+gcGYORx9B+/bgyreZpEYmR3Yc2mcRE8d0mRJfdC+huaaQmoAUVXI1Y9w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792598722;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=JA1UdTEk6/zCrVoeW0V5BinIIfMptVTl063ciPGXTyA=;
 b=cK2PKnZQ36iU7tYSLVOrW9li8jx9RzTOq0ZTWLOj59LsegcYfIsHmuiB8MGVWJvx0JTI
 HQqUT3Is1jxgBXuG+Mtja59Eqig1rUOiFE004Dyvil2ZYIKC2K24SA82nhejevmW/YWqd
 SK5hbLtdWvLWVvbUYxnnswUfntwryJGNBLMzKOeib0BPJzz3cawSDrBokS3FQ5LrwTyal
 yY/SuPLgsCIHNT2NcTanz0g2LZnCsead6Kd4qaOW4MUg1W1AWG9oA9j9vS9XY5ukg9hWO
 +O9AyF9+tGrPGoiLkSbv5Z6yvpdGZyhptaw1ZTh3qkda9kQZPRWG73IrsBf+hr80ggw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=dqIBECi9; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=dqIBECi9
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1628D4016B
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:05:20 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a018dc1f98so7746695e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1792598718; x=1793203518;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JA1UdTEk6/zCrVoeW0V5BinIIfMptVTl063ciPGXTyA=;
 b=dqIBECi9GcFmI6Ag1ddPZnTiKXhX5bu/tUC6K+aCPAmp2aDejIKXRjOaop3IMZi5JY
 oDBD7fIlJg9G/x34iq179/bT4H7HqwO/miuxkt0WW4B/i/Rw3bSQmQWbEQxhmNdeRQ+l
 UCib8Qx/yrx/IGT0B/EISpSBftoIOe9iqe5w3TV5EYdht5Aa+GF/UqeIw9Vih6hoKs7T
 ik8ECv5vCfE+VQOnZvoMaBZ0em9p4jPX6QkcPDsa1BJy/5fJPQXxDBZeqvXEDYtqFd0g
 2CkqHsyMPd0n8/ynf6Ab8cIoBYkUlzz8nIKeKkFg88oUk1Bs0VJtEm20YsL1J/4nVMeQ
 L35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792598718; x=1793203518;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JA1UdTEk6/zCrVoeW0V5BinIIfMptVTl063ciPGXTyA=;
 b=zXjcjt95+GtSEh1YBhBNuSfH6LqLp8rb5cfUnlKKkNarh95W0WIzuQvm9w5g2IQQeJ
 7H6086+nt0yor5L5nmbaBYBkH5yQIyhXoQvbq6QnTGDrzTvETqxLpB1K0Fy5DP1nUCSr
 uA8rpil5jOTtiBb8kI3nBmdI3iLtBPx3i0WrtOT/j3LxxQ0+jC94VYf8Kte8Dtg1VPhv
 TEu+RxbMiq1aLutRtIYi7Raqkb29V6XGK3aa5E03+xBQV14jh3/dke2ntgZxvFr3w+ZZ
 nvgpyXVi04J6bj7B0ygaxaENPaSZESKWZ4fHBZbYGATzxlDOS1KyST1MT5G1HzI/A63b
 US7w==
X-Gm-Message-State: AFq9FYIsZt9b7KOu/U79/2IJQD+25HbHhHhbrsym/B9cGHp3f0O5Pgnu
 E+/ozVwFioMzi1ca5VKtB0/xMUWfSjNUkhvuYvscdaS5GU74QBPEaborrfYkvxnlptw=
X-Gm-Gg: AYBFou3d4r/Tz1QmQoMwBpBo/+O7d61hLgb7E0TBnxLYdKbAZmjbCCcv8NmKVveQ+xR
 jFlwta5jhEWffgx9yuWkqeq+SyUrKwNWS60B9qG/FShGyJaVQP9SvGum9F7dRgaALpAHuEAm5hO
 yjRjpRO6FvXGoQmMXxRdd8uWdZ66elE6dCOtkwMful+1A8twdXMz/srBiuSrkVT9PBddSJEvcKM
 BJTrBhrw1MNjN+FP5CEz+TFRkAVDYqFXxIh+mMH/vZa7H616+3CjYa6RFLcrdLRmmLNl6Zq/hzM
 WeNVwsupyHSDcuqITI/xInaoELW7gXcTPOvSP9Vb5nsLsAheJouc7fscInrgR7P35M0DrQco23F
 AWxiWdAhhYuQpOzEgD9zDVO5WqPLAME9SoTkdYBcHLvzdVgPrgBSPvt1kQ3rnxY0ewgWJAAVDmq
 CTX+LX1pjZaddGINCeIIxv5koN9wSPKFMeX/3FCMAz4Pobbt9FJU8CNHgS5h4ieP0Y8Y06gaMSh
 jXIgnhuSbLP18CKrulKTse+6jPuD+ADykc6ujqFj1RRDWsvvwSu1r77CbRIrBwkEPZRyyvLqfDz
 QHhrT6C2r1awpMzGHdy9jG6hpThJZbwY1rIR
X-Received: by 2002:a05:600c:46c3:b0:4a1:fc98:1cb1 with SMTP id
 5b1f17b1804b1-4a1fd8cd9f5mr53925625e9.2.1792598718158; 
 Wed, 21 Oct 2026 09:05:18 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae.
 [86.98.194.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fcd629bbsm54075975e9.5.2026.10.21.09.05.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 09:05:17 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 21 Oct 2026 20:04:49 +0400
Subject: [PATCH v3 4/4] doc: spl: describe loading U-Boot from UFS
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-ufs-spl-boot-wlu-v3-4-064e73cd2209@flipper.net>
References: <20261021-ufs-spl-boot-wlu-v3-0-064e73cd2209@flipper.net>
In-Reply-To: <20261021-ufs-spl-boot-wlu-v3-0-064e73cd2209@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 Alexey Charkov <alchark@flipper.net>, Simon Glass <sjg@chromium.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Denis Mukhin <dmukhin@ford.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Carlo Caione <ccaione@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2801; i=alchark@flipper.net;
 h=from:subject:message-id; bh=g+Okjt3m34NXO4NlcGNPep3vtUseGUvTbzlFCsOl8dg=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTdeLSybVFk43V1rRSv9Ki4ghs5n2XuSv/7LnOhRVs0w
 r11U2BPx0QWBjEuBksxRZa535bYTjXim7XLw+MrzBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 aKRjrGPEwMUpAFOteJaR4cX/SWt3aLb8MPq4/qeUdUHcse8v7qb+WM3XYmGl9Dl6xn1GhpZ/F6u
 PF0RZLJZmOVgttUDY7++2XbF6wlM3V6tI7ew+ywQA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Loading U-Boot from the active boot LU only works on a device whose boot
LUs have been provisioned for it, and the Kconfig help is a poor place
to explain how. Document the UFS load method, including the A/B boot
attributes it relies on.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 doc/usage/spl_boot.rst | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/doc/usage/spl_boot.rst b/doc/usage/spl_boot.rst
index 64b8083e0073..d5d9eeac203f 100644
--- a/doc/usage/spl_boot.rst
+++ b/doc/usage/spl_boot.rst
@@ -145,6 +145,48 @@ SATA
 
     * CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="<filepath>"
 
+UFS
+    This method reads a raw image from a logical unit (LU) of a UFS device.
+    Required configuration settings include:
+
+    * CONFIG_SPL_UFS_SUPPORT=y
+
+    * CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR (where U-Boot starts on the LU, in
+      logical blocks of the LU, usually 4096 bytes each)
+
+    The LU is chosen in one of two ways:
+
+    * CONFIG_SPL_UFS_RAW_U_BOOT_USE_DEVNUM=y with
+      CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM (SCSI device number of the LU, in the
+      order the SPL scans them)
+
+    * CONFIG_SPL_UFS_RAW_U_BOOT_USE_BOOT_LUN=y to follow the boot LU that the
+      device is set to boot from
+
+    UFS has built-in A/B boot support: up to two LUs can be designated as boot
+    LU A and boot LU B by setting bBootLunID to 1 or 2 in their unit
+    configuration descriptors, and the device attribute bBootLunEn selects
+    which of them is active (0 disables booting). With
+    CONFIG_SPL_UFS_RAW_U_BOOT_USE_BOOT_LUN=y the SPL reads bBootLunEn on the
+    first UFS controller and loads U-Boot from the enabled LU carrying the
+    matching bBootLunID, so switching bBootLunEn, e.g. from Linux with
+    ufs-utils, moves U-Boot along with it.
+
+    For this to work, provision both boot LUs with U-Boot at the same
+    CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR, and make them large enough to hold it
+    there along with anything placed before it, such as an SPL that the Boot
+    ROM loads from the same LU. Note that the configuration descriptors can be
+    locked permanently through bConfigDescrLock, so plan the LU layout before
+    writing them.
+
+    .. note::
+
+       On Rockchip SoCs the default provisioning that the maskrom loader
+       writes makes both boot LUs 4 MiB large. That fits the SPL, but not
+       U-Boot at the default CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR of 0x800
+       (8 MiB), so reprovision the device with larger boot LUs, e.g. 16 MiB
+       each, before enabling CONFIG_SPL_UFS_RAW_U_BOOT_USE_BOOT_LUN.
+
 USB
     The USB method loads an image from a USB block device.
     Required configuration settings include:

-- 
2.55.0

