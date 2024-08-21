Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E57C52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 16:24:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5908088E88;
	Wed, 21 Aug 2024 18:20:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d/ZGw+Le";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 802AC88E7E; Wed, 21 Aug 2024 18:20:05 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91AD188E51
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 18:20:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-70943713472so3216270a34.2
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 09:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724257200; x=1724862000; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+XuniX7CvS5lAXdr7cIqEyl1WfOfadrMlaBVJ+KGEh4=;
 b=d/ZGw+Leb5gLDMk9xu0VN9pJdpCVe4wGLG3ZCu9m/9Pc4PEyaz9IlJ6ax1tbICCrXp
 33vKADjrL40Ytpiv0mayEBtcwofERzd0wowU6zCUAJoSGWiQCzWV2bweylnzHJDLgli4
 Pzy/tkLzkXqdCKE2hTkgJIUD287e/tnJ7CMmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724257200; x=1724862000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+XuniX7CvS5lAXdr7cIqEyl1WfOfadrMlaBVJ+KGEh4=;
 b=gKh2YonrjfA5mM5EvC7hRDYfIqIYEGlTgEuFrAWnuzzK5xsGdzyETkrpZWcLatH0Wg
 20PQBO4Va7g3GYpsapY1bwRs2yVN89WnDN/WF3Zl/hRidWL20KqasQfWpRV3k3gw0ZL3
 eR2qCaqgc61cx2iTjBhDS6rBK/rftdMMoqz5TOKKjK1rExRAbfq8RRCNkio3EIVdc9SL
 yZtko7ZTH/8TXvk/nWZdPkXIYbF5/JMLD3zJfjMigu8qH+oEADzjXR+fW0EBxNNHYT7y
 +UEDImQnk5ZejeCMpSfNPE7dw7iSiQIhUgF+C43wEH61yLvyM/DWikezXuoXe5mAZ2bC
 KsUA==
X-Gm-Message-State: AOJu0YxZToH3/Rb04jCFLO5DhoQBxlHFEGibZlQARGdUrYmkDJW4cT3v
 qpLsfSQoS7O+BALOB/U5ztV65p8XBc8cNViBvkagtgk1U4UGmrIpEq2t55vvJWPMLTN247cHKlY
 =
X-Google-Smtp-Source: AGHT+IEOoDEfUg1pZDdgV9dcCE4Yt4tKD2xgY1UtMUFLtoViLwW1QK+m0War/NiWoGxR/Nc1Eu9cuw==
X-Received: by 2002:a05:6830:908:b0:703:fdda:c1c7 with SMTP id
 46e09a7af769-70df85d5261mr3761808a34.7.1724257200300; 
 Wed, 21 Aug 2024 09:20:00 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca6629792sm3222376a34.72.2024.08.21.09.19.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 09:20:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 27/35] global_data: Move baud_rate field lower
Date: Wed, 21 Aug 2024 10:19:19 -0600
Message-Id: <20240821161927.695717-28-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821161927.695717-1-sjg@chromium.org>
References: <20240821161927.695717-1-sjg@chromium.org>
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

Move this field to be with others of the same alignment.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/asm-generic/global_data.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index c5f07709118..3588e1eee5b 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -55,10 +55,6 @@ struct global_data {
 	 * See &enum gd_flags
 	 */
 	unsigned long flags;
-	/**
-	 * @baudrate: baud rate of the serial interface
-	 */
-	unsigned int baudrate;
 	/**
 	 * @cpu_clk: CPU clock rate in Hz
 	 */
@@ -75,6 +71,10 @@ struct global_data {
 	 * @mon_len: monitor length in bytes
 	 */
 	unsigned int mon_len;
+	/**
+	 * @baudrate: baud rate of the serial interface
+	 */
+	unsigned int baudrate;
 	/**
 	 * @env_addr: address of environment structure
 	 *
-- 
2.34.1

