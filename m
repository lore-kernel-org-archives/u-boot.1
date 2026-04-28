Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B393FFF886D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 18:14:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7186846AE;
	Tue, 28 Apr 2026 20:14:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ER6DjZCE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E691E846AF; Tue, 28 Apr 2026 20:14:52 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69AE3846AD
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 20:14:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2C7A43F7D9
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 18:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1777400090;
 bh=4Lubqg1frltC9wcHVPNcHfE6IrBm+RcA5LF6N4hFuXo=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=ER6DjZCEOEEgDchGqbTCOQYU1BJnxJffWg9/Ti/JbMtQHsgVBgCCiyqdUoHF3SqDq
 eDOVV6Ntm9yMb0v6HOAxrdXdzYbCJYw+MeC1demey+qCdn/ghNjHiOMLy7NwPgNlY3
 71w87d5OnoUzeW+P1r0dpSZvJmHOHg2civp9qS7C70pjfIqgu5JxE0YZNO3GJ1g8wR
 HuHy0Oeu4Y6YYi+j9TNp60NFWn+hWgmOV+opvaySlaWxyl0wzEnM7yUZ+lD7N7yvem
 fH1KBBJ1DbFIALa/LnrC6aKAwQF+wE3teYjbYsQpBLOY4BLGYTg62Wm3dCmX8fopHm
 wa4Uttv+bFZFy2N/0EPTlDhiTdAEOoZKdhixe0f4ZGRot/wohILcef7PHGy45CVRRc
 W+twkGwAEXxnqvWzu+3Bbs3Y4xADa/xte+Li5bdIe09hvrnCwq7MLmNUtk01p1/OpQ
 DgBXCDNQ+pGYXM03BQZ/OvRTjhzSudzAl8JkAd32HQ6lGsH1jEWbpcuHn/wQ796Q4u
 81LLAXl9oMacvIK7xssSJWwJx3Scet4qsHTW3/DS6rZUX8QcmeJE1pgjO3pq7jYS3W
 sz2eD0KG4+zWD8h/qV6bHa5cnkZUQ5PmUN4JcAJ034T62ocAdDNCziaVhNa2oZx+6A
 TJNZl7hAQ63hA3xlekMWSpcs=
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48a548b585cso53855525e9.2
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 11:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777400090; x=1778004890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4Lubqg1frltC9wcHVPNcHfE6IrBm+RcA5LF6N4hFuXo=;
 b=AA+vfS/fEFP4SaVbkmshI3/orJ7vIMSDc4ioMzQdFID0+m2FTm1k6cIg+6Zq+xSi9r
 z/UHkZe0Qb/kXznlkkIK7kOh/73hr9GXn/087lf2VysVCAsDX8zUIlG6Xb39kKFIPYgc
 WNkedHkeh2tKcoMXuLyX/rK1OthheekxKNCkXZOkK+4FU5J/QL/KCYh9ANxnAYl1B/bc
 +dcJfapHRWYvmw0Bc8aj053EYMr+BvqLtNgczxITZ0gcU06IyQKjAUTftJXLdlxSsXJP
 CbRnWnXS8CJJhI/xhpABccV+x2IjZQ289bUwleSY3Rdk+Hv7lEeET7OHKnrC39NdgphZ
 4i/Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ97fI+YrrssBj5rF1DddH0VH2iwVrrjvPCu8A8IK5o5LbUO5na70t3S3wigO1IG5Sz+L8FvPyU=@lists.denx.de
X-Gm-Message-State: AOJu0Yzlqa8hYS56iWSsbOWVjPNjGGedBrvTePDe7qU4m0db+On6kr+1
 L5+vBy/xfQU1k+2fD4qpcQT1jADldJfieVk90yTL4us+l77e+nuwsO9Gu1quWgklhCioymAme/3
 90Pn152+cATWF/yPK1ywiWNgKv/D5sMYr0O8jaGX26gZyeOZz+3AXwsjE5XCRWie6dJ9onqI=
X-Gm-Gg: AeBDietd7zK8i/2dgJn9kJ/nv1/ydQ9BgmVsifZ9aIAXZ6j8Idv/26WBd1l2JPA68UC
 YNZLCeYKxEofcLov/xKLRM4fT585H3y2KtQAMh9uY5p27YAQGLWU50zTCxS8DXxyJoE2i81EmS2
 CHwU5Dx65tG4FNEFWIyK6NbQIOU7Kioq42AXUmC7IS7ZM7Mb6dJnsUOJx2dC4P6SJrvOTuzsK1V
 z0bS3nB2BbHe5t+k4nZigr9wXrP1ei9qVsYDATA3VoFghbJivBVRAEp/e1ILrqpZT26dcQhDRrj
 s4aUJ8iimZzcSSNC8k/u+Wb39+TiFL6heU5a8kcatpfcynNIYZf0I0MZR+iT0/iAhePNPbhBPaX
 A0B43crwkZ0hNiexYziGM1zUw9r5mHaDoFjJS8G6kfwX1kVPSAa8bTN0NSB9vEinasgSaL4aFdp
 iT6BKK0WMbDG9DOqOot2aKc6s10DedS+Po16pTddyLw8HkpqaDVYPGRzFmYFuP
X-Received: by 2002:a05:600c:820d:b0:488:ab26:8fe0 with SMTP id
 5b1f17b1804b1-48a7b534664mr12475005e9.15.1777400089647; 
 Tue, 28 Apr 2026 11:14:49 -0700 (PDT)
X-Received: by 2002:a05:600c:820d:b0:488:ab26:8fe0 with SMTP id
 5b1f17b1804b1-48a7b534664mr12474645e9.15.1777400089224; 
 Tue, 28 Apr 2026 11:14:49 -0700 (PDT)
Received: from workstation5 (ip-176-199-115-125.um44.pools.vodafone-ip.de.
 [176.199.115.125]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4463d02f35csm9551802f8f.11.2026.04.28.11.14.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 11:14:48 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Tim Harvey <tharvey@gateworks.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/3] net: lwip/wget: don't print content size twice
Date: Tue, 28 Apr 2026 20:14:33 +0200
Message-ID: <20260428181434.179888-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428181434.179888-1-heinrich.schuchardt@canonical.com>
References: <20260428181434.179888-1-heinrich.schuchardt@canonical.com>
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

If wget_info->silent is set, we should not print anything.

If wget_info->silent we print the received content size.
Printing the value of the Content-Length header is redundant

For chunked transfer no Content-Length header is sent.
The content length is returned as HTTPC_CONTENT_LEN_INVALID by the LwIP
library. In this case we were incorrectly printing '4 GiB'.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 net/lwip/wget.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index b6c25be6115..983abe2ccd3 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -243,8 +243,6 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
 		putc('#');
 		ctx->hash_count++;
 	}
-	puts("  ");
-	print_size(ctx->content_len, "");
 
 	elapsed = get_timer(ctx->start_time);
 	if (!elapsed)
-- 
2.53.0

