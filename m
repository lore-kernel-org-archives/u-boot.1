Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9B6C83F2D
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 14:58:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24CF388C35;
	Thu, 29 Aug 2024 16:58:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GZa43/vN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A311A88C0B; Thu, 29 Aug 2024 16:58:20 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB77688C44
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:58:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-39d2044b522so2698645ab.0
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724943496; x=1725548296; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WsX9jb99takRUHMQMWW+Mt2APc0hODiE34uAeBg6oSg=;
 b=GZa43/vN4Jfn1ZznN7Ebu/3V+NdPkBvnSsR+GURNfv3mn6UmPCYx+FPAIMRJuoOgH+
 umvIg7RQ+Coydk1I7zQdViIa9ZijJi3DjVfX5fTI7wOjTEwYC6hcV473NbypZS89Rm++
 KKUJr/WXHyEGQfToskMjuOenyIX3pPGcdk5bg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724943496; x=1725548296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WsX9jb99takRUHMQMWW+Mt2APc0hODiE34uAeBg6oSg=;
 b=l0xU2/41cMZTAMZ43yzt1O2h3ZakkgwpdRg8G6SiYyqPTTHw8KqI5K3qHgjXWmlXxS
 F9Q8G+kHpkdNrrs2BFwu745Zh3b+HxxMBlDxM/i47gESO1hMCyZ3T/PmLmrtN/ZYlR6X
 gT1cuzbtWHSTm5uzJc5Wz1G3rTej/PMeEF0zPPJHQNH0D1xet2cjheGxOQ37yM39D3h7
 jKo/+wiLyQ3Z5Q3DollUo2E7GiWHZc4R7o2Jfkk/OTWBb6FoUCivvpblZXS4BLOZHdTY
 TFvvhs/GT7RxLG/uthIp9U9qWKTW92K/0vxfB16UOVM2YOacSrMISirhYEP63M1zEoO9
 43vA==
X-Gm-Message-State: AOJu0Yxg/buXmQY/Ek02I0Yudaxx/l/oTlx+UMjWQHj3mJuUGSx8isPv
 WRTaAjypijXCWizCkQcdo54wzGz/sb80zfzPTRaUEuWRvgBnkT7GgauzmOUTvtImvPeojUEjxD8
 =
X-Google-Smtp-Source: AGHT+IHFMn5vSFuwxife2vZieBwo69Fy+BYiz/vP+L35Q/+M7Nx+bGUX6chCBVQv7y5GWqsciI4p0Q==
X-Received: by 2002:a05:6e02:b27:b0:39f:36f3:1957 with SMTP id
 e9e14a558f8ab-39f377ce412mr38220065ab.3.1724943496462; 
 Thu, 29 Aug 2024 07:58:16 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ced2dcdd2bsm284900173.21.2024.08.29.07.58.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 07:58:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/19] image: Add a prototype for fit_image_get_phase()
Date: Thu, 29 Aug 2024 08:57:44 -0600
Message-Id: <20240829145802.1827952-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829145802.1827952-1-sjg@chromium.org>
References: <20240829145802.1827952-1-sjg@chromium.org>
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

This function exists but is not exported. Add a prototype so it can be
used elsewhere.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/image.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/image.h b/include/image.h
index dd4042d1bd9..dbf8d0e7ba9 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1183,6 +1183,18 @@ int fit_image_get_data_size_unciphered(const void *fit, int noffset,
 int fit_image_get_data_and_size(const void *fit, int noffset,
 				const void **data, size_t *size);
 
+/**
+ * fit_image_get_phase() - Get the phase from a FIT image
+ *
+ * @fit: FIT to read from
+ * @offset: offset node to read
+ * @phasep: Returns phase, if any
+ * Return: 0 if read OK and *phasep is value, -ENOENT if there was no phase
+ * property in the node, other -ve value on other error
+ */
+int fit_image_get_phase(const void *fit, int offset,
+			enum image_phase_t *phasep);
+
 /**
  * fit_get_data_node() - Get verified image data for an image
  * @fit: Pointer to the FIT format image header
-- 
2.34.1

