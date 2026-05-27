Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BFC4CD4F54
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 16:13:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DB45848D1;
	Wed, 27 May 2026 18:11:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PDBfjcgZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D98B6848D2; Wed, 27 May 2026 18:11:33 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAD3E848A2
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 18:11:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7e5fd39cf11so4868642a34.0
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 09:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779898290; x=1780503090; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rLJXpZVPbCkVvudpXiCoi5NIFaXDM026UFl+w7NHhuA=;
 b=PDBfjcgZTOiJXiNXa12FhPKlX5sFZcaeFAkh3rFolC5EgtcJBP8YaUeqOHvxsGpAYQ
 GbGNL/kLDHiocF3q6EtLwqqGPvYqz9dYhWUgnKqCEofN2X5NGMkY/tVO4K7GVrgKGZoV
 rSETVFsJy7XaN/BV/u0GedKdIu/p3nmyhWCSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779898290; x=1780503090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rLJXpZVPbCkVvudpXiCoi5NIFaXDM026UFl+w7NHhuA=;
 b=WFjOK4vqyPQMlamFGDMYEEFLUr1XBMQyXJhhSzLuDhZFxkBZoU2C0yF90e7Svd2nUd
 +8ceJJGVN7MEJ6OO1zTvv741gcqgyo0OSrSX9Fn9yzySxGUxiP8FJJM5Sj2xDcAmN6yR
 DeyJK5Eaq1d/MS/S1NztDfQ4efZnX/r9uOMriQi9GkEp8M42irlbq2vGUabqoWx9ro6o
 5KXgEgXt/sigm8PqUDBnOq+3GQsO4eyTyMlZBjh+mcSa92gFkENi486vWknmhBPYy/f9
 DdW+rbiyLUsvQglCz5QtRC0BdXfKLHeY00AaCkb8PO6MMfAW9U7NH8SPNmW2Hj93AW2R
 5+Mg==
X-Gm-Message-State: AOJu0Yz9JQOyYf+tU6JZE3OklG8Y0Ay3lQC1wrsWcVqz19AionbEyVlU
 lIyQCiECkWMwkz84g3GOcLi+EVt7vKzoys+dYsuA2QIveF397llDQ+JZeOjOPAGbBcpDgSmdwIL
 auQ/PBLCsxtjFXA==
X-Gm-Gg: Acq92OEMwJv857TKUjB/cMGMakd6nmk7/t18mfapkzfwrF0FwcAPwMg4UbxQjOFJfbl
 3KAaAcw9MvlhMB1lLe5XS+M7X3x85Na4YFKM0drbZn3Jt02YYOa8s1sLVztupaQqYFZ4pYGkpnJ
 xsIqT251v/8VGkLq+7VnH2MMOLzYb+t+FWV6LxVd1PmMQZU6rqv65SwjGg6Fhry05DLu+seV4ke
 ygCozSC4BHUEZKOtMp0QfP9c+WrDoXHp/W6WhfT1VjHgJgqwGV2bJKYmTE3QMTLFuXmkJDCW2JS
 Iojp1sKwpNTki3/3b4HuurzuRvIdVNia5Wu5cggpr/r4+fXFFJoLTkppHYbbjyuYNyurnJj+bC0
 AwFxUbVD4YG8Fgjxcfopn2QGJuHF6aw82EW3nE9ttVtP3x4v8Zkfn264f8RlKD75wD0mojTqAC6
 D1qTwLGtLVavLA58xo+w==
X-Received: by 2002:a05:6830:67d7:b0:7dc:d7e8:cb30 with SMTP id
 46e09a7af769-7e5feeaffb8mr14345428a34.26.1779898290599; 
 Wed, 27 May 2026 09:11:30 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6065e7cb6sm12102085a34.16.2026.05.27.09.11.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 09:11:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 13/13] virtio: Free mmio base when removing sandbox virtio emul
Date: Wed, 27 May 2026 10:10:23 -0600
Message-ID: <20260527161033.3273795-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527161033.3273795-1-sjg@chromium.org>
References: <20260527161033.3273795-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

sandbox_emul_of_to_plat() uses memalign() for its emulated MMIO region,
but sandbox_emul_remove() only unregisters the MMIO callback; the buffer
itself (several KB per device) is not freed.

Free it on removal.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/virtio/sandbox_emul.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/virtio/sandbox_emul.c b/drivers/virtio/sandbox_emul.c
index 673575806ac..ea7e72b4dc6 100644
--- a/drivers/virtio/sandbox_emul.c
+++ b/drivers/virtio/sandbox_emul.c
@@ -295,7 +295,10 @@ static int sandbox_emul_of_to_plat(struct udevice *dev)
 
 static int sandbox_emul_remove(struct udevice *dev)
 {
+	struct sandbox_emul_priv *priv = dev_get_priv(dev);
+
 	sandbox_mmio_remove(dev);
+	free(priv->mmio.base);
 
 	return 0;
 }
-- 
2.43.0

