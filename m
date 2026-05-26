Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EAF5CD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 13:11:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFA84848BC;
	Tue, 26 May 2026 15:10:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bP3eGJmu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1450A848BD; Tue, 26 May 2026 15:10:24 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F383484879
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 15:10:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7e61d8d9a21so1468676a34.0
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 06:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779801021; x=1780405821; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SCum16EqKanPVMvqkbxPNSyKeLH/oSWR80GZqSE9W4Q=;
 b=bP3eGJmurkJoiFsd0MUbTgsOY+TDIQwoOlyNkF5KPL9EyFmeSgUKWf6rOsY6G048uu
 3S0m4vaGKQ/YuoqXq33oJKd5yntWRcr+BJTQ9m0f1ygahovfjAyk4Mxorba09aVLZswM
 snKmY/XhhTlwMEVAlcxQL/D/V0eH2IaJyZI1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779801021; x=1780405821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SCum16EqKanPVMvqkbxPNSyKeLH/oSWR80GZqSE9W4Q=;
 b=a23pnyAbGQSZdsAnsRIGqOCSbiSecIXde9ntMh7vV4LEs5LNhaBpOKsHveB5GsLJUk
 NNl4REyXGXfGcQreH/t+ZBRvn3SYdxnP0CBjUXtblTxZj1MevZStBSO9C+qqJ/LkZ1It
 8GgNuuRheE8ZKXwcCQEl+toasClHITdRI52ivk2e3d6zjlqjrx+gWJBAxD+4yAk7pf78
 tKEyOxtghIEQG3gwfyr+qaezM1AEO+J0o9VRzRMh4Vcpf19zHn9pNuH6VisqWs9yX+5Q
 7HCe6ZZJ+oIrX1YTy6tayWFagwFR36spODTA15vGEUaDC0qdh9Q3CVQv13by30H8hQWp
 dEXA==
X-Gm-Message-State: AOJu0YwrOkPk/UiDeHDUaUaC9j7F0e6FIE3/zdn9VN4MJgRuRTiibzMr
 pP1tDaEUUEFqNtUKa48KheVUjIumnywNCNWSgfYTfECfcsbfRwAEGmyzs3N0cvlIE6ajxfJmnKE
 Ztt1h7Mr5DCY=
X-Gm-Gg: Acq92OFBDmitqRl/lmUxoRydDZZ/b7YApw8Jyw1myehw/t5GEMIMXBPVvOd5SBkH5Py
 ZDE/cZZ6VNEGxWMRx54ce+Qx5Z4orBPAh+dWZyqt/xXFjTbxu5EEwnisHsTcKTVshU8k6Gz1y4h
 t2K91Q7WuhcR3ZYYqX7IajjbSA/hFw8NuincKGpwA2QzzS5qGlfU8TG6hN0jQkXPvMtiCEN411t
 ITBvU7rprVtIIZqoWUz2jXBtvbVYwhSWFNZ0otl3nHNcwBHFghbMTUNNj9E+/sSdI1+qQIancPg
 jb6k2zPmcfDWgK7DXWGbZXl8b+6g2ONTc+Lt7jomlY7c3JIld+uHG27Z/dfPHZGWHoAt9oXRswR
 GMKuq29ng6XreblGoiIplvLww9bm6snSObR8hgUX2CDc0Zj2uqGnaViNOpSDc+eqt5+qU3/m4al
 fH+aqDfqSrTQWjZqhYl7SsfbUyp9EeA1EmsLh8Oh8=
X-Received: by 2002:a05:6820:f004:b0:69d:9823:c9e0 with SMTP id
 006d021491bc7-69d9823d40emr6260153eaf.2.1779801020760; 
 Tue, 26 May 2026 06:10:20 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d83aafca2sm6974601eaf.15.2026.05.26.06.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 06:10:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 9/9] boot: Use strlcpy() in label_boot()
Date: Tue, 26 May 2026 07:09:15 -0600
Message-ID: <20260526130931.2103552-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526130931.2103552-1-sjg@chromium.org>
References: <20260526130931.2103552-1-sjg@chromium.org>
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

This function is recommended instead of strncpy() since it always
terminates the string.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/pxe_utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 419ab1f1b0e..e97faeec0bb 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -646,7 +646,7 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 		}
 
 		if (label->append)
-			strncpy(bootargs, label->append, sizeof(bootargs));
+			strlcpy(bootargs, label->append, sizeof(bootargs));
 
 		strcat(bootargs, ip_str);
 		strcat(bootargs, mac_str);
-- 
2.43.0

