Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F17D3B9B8
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 16:19:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E33C9895F1;
	Tue, 26 Nov 2024 17:19:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PmBClg5z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7578D8972F; Tue, 26 Nov 2024 17:19:38 +0100 (CET)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA333895F1
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 17:19:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-724e6c53fe2so3772788b3a.3
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 08:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732637974; x=1733242774; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HJi+9pLQbsut/LsMgMwL8rmVH9SuXT2gVXmiyQqV6IA=;
 b=PmBClg5z+2Lm9TFU02zPi3w4d9PoBissTPPyuhpiSPoPQVq2rwwihC5Fc8mRokfcP8
 1R/R6vIQoFuJX5zaymGyED3WnSPPzs1IkKb9JOMBSC+ILCT9z5PXWCFXfy4hKuREfLyN
 hrl2/d0kqGGcmJsOnkHAZwYSL9d6IVTPiJPhRgTrBr3xBavGzMmZDi7IlF25MHNP6krq
 1CbSoRapXpMPh0Fl0mLiS0r42lXX/4fM3j8xsyi0RNsEXeEgyjmvJNt0MaznY8CPEdAl
 Sopu8VWZvl7dSdXko+G/RcU/xmEPZtQhmQFYLTdaWnUCsY2tDpkpXcci5tAmc/41YRV4
 P5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732637974; x=1733242774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HJi+9pLQbsut/LsMgMwL8rmVH9SuXT2gVXmiyQqV6IA=;
 b=Fgr/j+2jrrPkL93zBS9tZh6d4Eu1t2VdBpjBSwzR0lRo0Os98sJPE+q76fRr6HK0/Y
 dsquiiwBvNxF7kci4g4B8AeckH3OSmNWwYI5Hb2XXJeHBRa5KFPPgel5c2QMz5fmD89m
 LpFI5+a03D64IuCxEj4gMJeGairDRDWyez3nVti6OWU+zCQq6vhLJ1ToQeuZ2TXSLxDw
 CA+nep06TxJXNJBclAnxIwKf8Yl4L6g5AJfaij27ty7PXRfCzKA9glNPkjLPRfDQNoa/
 e52wyLolFKOOE0795rAXbBOVCwqKFPs0FkfY5RoKul6NkGV9BV1enEVBIhMfs3kf9i9I
 DNqg==
X-Gm-Message-State: AOJu0YyIT1og1YJ2StTWGhZHxbsd6MgVhNq7nq81FzmcEjajoLMF76O/
 1ryvFkrQFwXOufONg0S290dDlnyIajMBeMug8d8kCmBTf9CulfbaLUYr/3fd9Ew=
X-Gm-Gg: ASbGncvGtBP8qSCeuAo+rSapmKZA/9ZjLpIHlnYCnaI3d61n4k6jX7jkeiJ1Dt6ctNf
 gqVePw5RlfmsCTxLreFsWL4UP+HS1GHd6gYfBE/EkysSmx6RoJZsigVA7d3qpE9m3zslDVIU/Q/
 XgBA1wqN06LHoDUnD1Ue/cQyaAxDB/ghYaVxrtLzEGFlQKnbx3EDlymgTxVXQJslL2/gbNxgOm1
 akWFMYXMVug7Yljo0wFgzBpuig0pmlhTkQx+zXQ+dI=
X-Google-Smtp-Source: AGHT+IGzLiu1r12OMYSMBwVplWxS2Ac26IH1qmzCuuas9+Bpv9JbheUtdLNaazRh21n0H3mum2knzw==
X-Received: by 2002:a05:6a00:9297:b0:71e:7674:4cf6 with SMTP id
 d2e1a72fcca58-724df5d0b81mr23290545b3a.8.1732637974308; 
 Tue, 26 Nov 2024 08:19:34 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724ea6a23a4sm7863865b3a.60.2024.11.26.08.19.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 08:19:34 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de,
	joe.hershberger@ni.com,
	rfried.dev@gmail.com
Cc: jerome.forissier@linaro.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org, trini@konsulko.com, sjg@chromium.org,
 pbrobinson@gmail.com, yasuharu.shibata@gmail.com, marex@denx.de,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v2 2/2] net-lwip: zero terminate string with headers in
 wget_lwip_fill_info()
Date: Tue, 26 Nov 2024 13:19:21 -0300
Message-ID: <20241126161922.388901-2-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241126161922.388901-1-adrianox@gmail.com>
References: <20241126161922.388901-1-adrianox@gmail.com>
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

    This patch comes as a companion to the same patch but for the legacy
    net stack. Commit 1327c2a8d6 ("net/lwip: wget: integrate struct wget_info
    into wget code") introduced function wget_fill_info() which retrieves
    the headers from the HTTP server response. As we want to parse the
    string in later patches we need to ensure that it is NUL terminated.

    We must further check that wget_info->headers in not NULL.
    Otherwise a crash occurs.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---

Changes in v2:
- removed double check of wget_info->headers

 net/lwip/wget.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index 53c3b169e0..9f8664b722 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -36,8 +36,13 @@ struct wget_ctx {
 
 static void wget_lwip_fill_info(struct pbuf *hdr, u16_t hdr_len, u32_t hdr_cont_len)
 {
-	if (wget_info->headers && hdr_len < MAX_HTTP_HEADERS_SIZE)
-		pbuf_copy_partial(hdr, (void *)wget_info->headers, hdr_len, 0);
+	if (wget_info->headers) {
+		if (hdr_len < MAX_HTTP_HEADERS_SIZE)
+			pbuf_copy_partial(hdr, (void *)wget_info->headers, hdr_len, 0);
+		else
+			hdr_len = 0;
+		wget_info->headers[hdr_len] = 0;
+	}
 	wget_info->hdr_cont_len = (u32)hdr_cont_len;
 }
 
-- 
2.43.0

