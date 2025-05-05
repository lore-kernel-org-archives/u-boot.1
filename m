Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B3EC3ABB0
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 15:44:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DFC382757;
	Mon,  5 May 2025 17:44:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H652PYfY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F77982724; Mon,  5 May 2025 17:44:09 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B8EA829CD
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 17:44:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5f62d3ed994so2982537a12.2
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 08:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746459845; x=1747064645; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UHpK9B8mz+ROvvWVKXDc/nDPuXFGVMMBHp9tPwjhxAY=;
 b=H652PYfYaqZO+3sYyUEdrepofda2+jBa4VLFyYfQo2oyTudGJ8PBtYJrJWQ7BKbdL7
 M9zblXGNM1K1+buMTEFx2C7NLUS2tJxgot1K8MwVBef9QU00ILXmAm/i1qHiCcvJAoFJ
 KfygVoLz947LbVXT7snc8zDEavzu33jugumn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746459845; x=1747064645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UHpK9B8mz+ROvvWVKXDc/nDPuXFGVMMBHp9tPwjhxAY=;
 b=Gp0W3wOHGYTZjmq5AF7P3/l/S36ADyrXkcUsTr2P0/G0wPc8OGMPzqR39WTbXOORj8
 iWn4P6i9maPUzPV5NqMjS46Wma4Wo/P4AuQhsGxc8kXrShKGt7AUzhthO9qivIgzUv6L
 WYTbdOcEz5wL464/kmeThcttruUC6A6bKYCOjvnkjm9S6bntOiRirX2/rV1tOLQ2oHyA
 uL/ORCqVlAYI6EfzWGOWeo+RRpzeTOnjE38pNHJUPHZg71nFeS3zHpbDH4dwGoDCfEZp
 GgoNIzYX5Xnh6e+JEMKtQUSeKOHaZKjbjlc8+HK5oz2nhNY9HDr+OVeCwSJoZbtLpldm
 r1Sw==
X-Gm-Message-State: AOJu0YxyFCxvq1gVcLv0BAQJmX0oK026MidoTi6NBVCyks09BNn0WbQr
 HZ7cmHcpyTQa6wb0juSIbyKpsT2XWvaDzSftst+HYy2sz9CG81FV9eDdKl5/MySpY4qSowRQRfg
 /gPMeXg8=
X-Gm-Gg: ASbGncvaeJcl+Xe6wxibr8tWlxJ07ZfFPt4xKbD0M6Q0jK08+qUPsJNPkdT9miP+U0V
 mZ35qna21/g/cdS/CYEE92IGV6T4mNNaRUJ9+6LvtZGWl8XL67OeYvf6lxf5EvsF7cKz7mrfmWr
 zBpyUUg0UtymeqSaZBsOwzS4qbX2BsP3c2FsGbJ9g8ccsgUHzHeG0k26sGrw8hCczcvjmCkJJ22
 Csm3Nm+wYYI7WJi0dzYHl5oGua+qRnAO1Db23fAVmWwIeMTFuhqhgtSZhEqew/pKLrAMGG1rBDM
 AmQzhEq0BXpBT4em4rMi3VuniD0KK1EMMMFt7Y8J2ZoktMs=
X-Google-Smtp-Source: AGHT+IEnIeUNamvpg78ML72+FDOZeI9i199UhS0D/cYOwbfRNFlL2wd2HYEvjY3o+fWc786SximVVw==
X-Received: by 2002:a05:6402:34ca:b0:5f8:d50f:1783 with SMTP id
 4fb4d7f45d1cf-5faa7f4d909mr8484076a12.10.1746459844885; 
 Mon, 05 May 2025 08:44:04 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa778188acsm5561762a12.35.2025.05.05.08.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 08:44:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/19] expo: Arrange cedit after setting dimensions
Date: Mon,  5 May 2025 17:42:47 +0200
Message-ID: <20250505154308.2911248-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505154308.2911248-1-sjg@chromium.org>
References: <20250505154308.2911248-1-sjg@chromium.org>
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

Switch the order of these two calls since dims for each object should be
figured out before moving to arranging things.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/cedit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/boot/cedit.c b/boot/cedit.c
index b7c2d37e3a2..c560be4d9c4 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -140,11 +140,10 @@ int cedit_prepare(struct expo *exp, struct udevice *vid_dev,
 	scn = expo_lookup_scene_id(exp, scene_id);
 	scene_highlight_first(scn);
 
-	cedit_arange(exp, vid_priv, scene_id);
-
 	ret = expo_calc_dims(exp);
 	if (ret)
 		return log_msg_ret("dim", ret);
+	cedit_arange(exp, vid_priv, scene_id);
 
 	*scnp = scn;
 
-- 
2.43.0

