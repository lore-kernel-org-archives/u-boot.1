Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD9C9C87FDA
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 05:04:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AB328357D;
	Mon, 11 Aug 2025 07:02:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jK/Y+e7F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83EBC832BC; Mon, 11 Aug 2025 01:38:33 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61C9483278
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 01:38:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-459ddf8acf1so31735155e9.0
 for <u-boot@lists.denx.de>; Sun, 10 Aug 2025 16:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754869110; x=1755473910; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DLMkP2hJrvpOxpcLWSTgcSabNNYoiOprc8VcTCKW0MI=;
 b=jK/Y+e7FaAkJji718FBDzAwmZHqaLPLrMYdCiU7876DG20XIWH+pmntjXUvKikKrC2
 KzRtSCWC4P9yjjWzQRyyfOZWgXuHlNvfuusPnOgF/fWGfEvoV29gkRwcPs1447Vv1qCD
 JzXLpyES0AQGyLRnbd7OhgZhA7tpr7Q6nAN+1NKEATYKqBoqqy0k3GirKzp3+v5DKGeG
 Q2y4G0wgyHT8iHTO1DHB5ggnxpDjyb+H/CXYqiyxtiVGs2FLrtmJwEJHJq9pCT8HgFEP
 5/NQDbTQMSKsvMr+hs5NB/9nV8lQe6ftAtqyvWRFjYJOmjv8eILujJiD5Dsq5f7AGpNJ
 9iqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754869110; x=1755473910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DLMkP2hJrvpOxpcLWSTgcSabNNYoiOprc8VcTCKW0MI=;
 b=CSqf90BeigvfREMkcSmotqKBYHVoUXmp2T88IlF6WxkFjNOVWnpmBBnmsASefqneP7
 NlMc76+tnsVmVDhWBrdGzZymkAOC6LTZGSPOdKyItN3MJwgI1000Ol40Ogu512OuRxLu
 d+oLDV4K80+zBSpuC3ButzCREwxI9cpMKEFHkZY7H8s4ioyJbyCcl98bKw5oRTKC6PZd
 CAeZSKQOCIzNtU3K0X7KiPEHgSKXVYfRXMV1zXbSaYzWL9qVS6fPPrYfx8l8fiJL1pbh
 jNdgCOF9LszZT8OGuoXU98nz+58uQKUeAMewmOAlvuR62SE9KO7mKv7/ODEoN4vAjLxF
 3jXg==
X-Gm-Message-State: AOJu0YzpqSr2JDFOkxPVWbiZIYUHFU/Y7egjFsjbswz4o5lBouF2GX8B
 YuSrKGzadHCJ+AGj/4KvnOn9x1xfXG8JpAmk5Qds7jitEVTOL35Ouaat2Eve7A==
X-Gm-Gg: ASbGncsE27V9CSUVK91WL3YM22nqqRl3SMyUCpjOXhxZPA+4di9YHjszw8y+81TnY+O
 OqVaPuASngjmjzRZIGbOxukzqrAQ/0rX71W4odPb+VJni3AU+iNtrwPwKgOmf9ZKBtALP7D/Ihz
 JvD2Z0hXfFrJloweIg0PDeLi4zU2XyTXLK6PYYoWej9eqcHL+Hqcs1M/1Cfkdg2hW+RHTG/0Cih
 Mg6SOw00egpleG3GIu1jQcXt3NopqJ9JRge1RT0ASW9NgVZS+z+31/PCyXDzM/j9thVSoiZk28k
 37N0hAHVZj/DDbFp4Ppp2tWdD+/9ELBij4944WBrxz5tON6ZHgmRMJeAAA1X01NBE8pSPDLIBzt
 Abo8VhUtPEtnbfua9IJ1actQuAz0TVw==
X-Google-Smtp-Source: AGHT+IFOqlSfy+wDT+Y+FYGojwiXTZO4nVZ8BrPwza7cJTQ8q51V3bW7IZE8Vgm+BwcBQAAqL4IN4g==
X-Received: by 2002:a05:6000:2304:b0:3b7:8b64:3107 with SMTP id
 ffacd0b85a97d-3b900b50c9emr8333664f8f.26.1754869110546; 
 Sun, 10 Aug 2025 16:38:30 -0700 (PDT)
Received: from N580G.. ([2001:8a0:c46c:a000:d911:da6:779c:bd3b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e585586esm242339815e9.13.2025.08.10.16.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Aug 2025 16:38:30 -0700 (PDT)
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
To: u-boot@lists.denx.de
Cc: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Subject: [PATCH 08/10] doc: Fix typo in doc/build/gen_compile_commands.rst
Date: Mon, 11 Aug 2025 00:37:39 +0100
Message-ID: <20250810233742.51902-9-adrianocarvalho.pt@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250810233742.51902-1-adrianocarvalho.pt@gmail.com>
References: <20250810233742.51902-1-adrianocarvalho.pt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 11 Aug 2025 07:02:48 +0200
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

Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
---
 doc/build/gen_compile_commands.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/build/gen_compile_commands.rst b/doc/build/gen_compile_commands.rst
index d503764f9e3..5eb9e4ccb0a 100644
--- a/doc/build/gen_compile_commands.rst
+++ b/doc/build/gen_compile_commands.rst
@@ -39,7 +39,7 @@ course) to have an up-to-date database.
 
 The database will be in the root of the repository. No further modifications are
 needed for it to be usable by the LSP, unless you set a name for the database
-other than it's default one (compile_commands.json).
+other than the default one (compile_commands.json).
 
 Compatible IDEs
 ---------------
-- 
2.48.1

