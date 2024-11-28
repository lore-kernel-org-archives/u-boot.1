Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9366AD6911A
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 15:47:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D22989D24;
	Thu, 28 Nov 2024 16:47:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DWl/li2v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2865F89CEB; Thu, 28 Nov 2024 16:47:45 +0100 (CET)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDB42893D7
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 16:47:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5f1e573f35bso384374eaf.2
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 07:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732808860; x=1733413660; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kz6xhLORRpoEGTXTCEJZyvTuSqlJHTLspNspRCoZ2no=;
 b=DWl/li2vE8MygpLTw03xXusN4bGW9GZB60wyklQnFv1dvfraAG4ii4QDUVHr1tBt7i
 k8fYXaCBU+wdXmGl/uml+uYHmr3J+wEgsY+Mz2ZTsny1teClrv67hvzv/0AmtF4o30qh
 fVGYhd6kXnoKfjerSsJrzxRNTN5PFMItoNkaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732808860; x=1733413660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kz6xhLORRpoEGTXTCEJZyvTuSqlJHTLspNspRCoZ2no=;
 b=sdntiHBUdVmiUsNg6JwBdJXPk94+wukol3+Glt7Os7CGLzvM2QtoJgPNR5c4Jg7+rB
 IviFg6j84HngRRuiAGedkbffQSq9tCzplMKcEaWk2euJOj506cBybRwg/+qdOMszSxWu
 zbDHVkeLLAhFPvRN8l7zzqQZfTYOb/EArBxXEYJnJouCoGRKARXnA1UYB6CJgnao1OHH
 m5CUMS9Us5nZD2n12wVh+xxblx+SfqqpuVaNi5T86/Y/aeNVNf877dpmzqQNXuMDnBEL
 aF7CL8z8h+eE6OrLp2hHOf5+Qr+dDN01bl2aawy+T59PSZbPMwlpziPlqxTet6nK2sk3
 1Y5g==
X-Gm-Message-State: AOJu0YwSDgpzw9EY8oEQMTgeLB0MQXSnBXfp8wdBEwOBSPGm9rFuNUqf
 2bviPjrD5pJhIDgX+z+7Hx3UJEs9aYWSXHrUsaT4I5NCxqO5EiVTrx8FgkVUPuNPvxLk35qWbV4
 =
X-Gm-Gg: ASbGncv+rdGJNNF2rVtRd+4WD8WPyjvLfIY2IgIoGiJRXpg3dbbWN0/8wxoRxQrfwGn
 awpi7S0G/zEewBS9h8GXmE73xWnD/AzfIBHPbtvf6LooB1gUwGtEJJlbaH7rXsmqPDvTwXjNxiI
 JW0wD2WMGWNHWD9sajUksoRfmqmECjQ/55Tz5DQ/NUN20FVojwyXEt6ijdM2Wv/OurGuil03afb
 E0WlMD0/jS8Mn71Lw/qUq/TDnW5ojshmDhZv9k8dBJ/Iw==
X-Google-Smtp-Source: AGHT+IHhaeT3cp0Db9KhJWFF6ZBSHenP8ZnfxlyKkxt2Jqu9M0f5WUWXV2Ez3EcSr2pS2mgm9fbWiQ==
X-Received: by 2002:a05:6808:1382:b0:3e6:2889:5fa7 with SMTP id
 5614622812f47-3ea6dd498b3mr7049373b6e.27.1732808860480; 
 Thu, 28 Nov 2024 07:47:40 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ea86347014sm305419b6e.47.2024.11.28.07.47.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 07:47:38 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v2 02/28] efi_loader: Fix typos in enum efi_allocate_type
Date: Thu, 28 Nov 2024 08:47:01 -0700
Message-Id: <20241128154727.771871-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128154727.771871-1-sjg@chromium.org>
References: <20241128154727.771871-1-sjg@chromium.org>
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

Fix 'indicatged' and 'adress' typos.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/efi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/efi.h b/include/efi.h
index 3fce281233c..95f8020049a 100644
--- a/include/efi.h
+++ b/include/efi.h
@@ -175,7 +175,7 @@ enum efi_allocate_type {
 	EFI_ALLOCATE_MAX_ADDRESS,
 	/**
 	 * @EFI_ALLOCATE_ADDRESS:
-	 * Allocate a memory block starting at the indicatged adress.
+	 * Allocate a memory block starting at the indicated address.
 	 */
 	EFI_ALLOCATE_ADDRESS,
 	/**
-- 
2.34.1

