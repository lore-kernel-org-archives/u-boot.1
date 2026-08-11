Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88EA7C5AC67
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 23:05:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E3370608E2;
	Tue, 11 Aug 2026 23:05:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3gXBgK8AGkpO; Tue, 11 Aug 2026 23:05:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8480E608C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786489503;
	bh=JHTbGRcN0C3GMRAXU7Rfjyn8FbxUvMC/iKgSdb6E0N0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=obENZiY1PuFF7hRvkxqX50Ta2/T1vUfo3J1Pmi1fIdEixdjpOs/OBCH0gAqEkjMTs
	 N3p05+Cj/y75FT0PhsQI4xNgrWoaraDJPt4NhhYysDTVGNFtlqBWFqV8/Nq5fS8XYO
	 +hBFtJN8lDcCPysFlxYiin/k1n+Q1yMuSKiF0TTDYURSYqU587X1POz4FjmikbZK+l
	 J3JTs85o4pOvDEDtdfBLT1K/H1QwMlROjfjj2FvA4rjh867c4eYR6QLgXnRRlHi62T
	 e04ux8Jn4BA/t/qCFUNL0/Adpd8fwv0mx55MWyzrpMjIIrIywGxQ/M4DT7Rr91te0B
	 0XUH7bAlqsWEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8480E608C4;
	Tue, 11 Aug 2026 23:05:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id F24531F43
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 19:04:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C490D8110D
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 18:55:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6Yy1lHOpTThQ for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 18:55:58 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C11458110A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C11458110A
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C11458110A
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 18:55:57 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6a1b51723a9so297942a12.1
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 11:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786474555; x=1787079355;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JHTbGRcN0C3GMRAXU7Rfjyn8FbxUvMC/iKgSdb6E0N0=;
 b=jjT3kXw5KA9ArqoT1kSyKrhT3jTpnO/nEFpB73uq/fl5N8BaSOzSSIuMku2e7L5zof
 AdkzJE1ineMt8scsSJIrL3WOCxCNjEsxrDk6mgDTxlnBfcY0z31kJ7XkuWOc/VRjZRWC
 x/Dh8EKTPDenXaFMCvevdfaP6QKnz6yiyXrxMIlSBNYzlYHJ8LlAqN0xxIXfOb1xwoJ4
 I+K1qPhY8OurmfjJ6IT8nDvPQQIX6HjmLrvB+mHdXUYl2wltzXiPbdhHhk55XQHSQEHp
 5/US31Q8HBLBTf4Em4PnD7TXe5BtYX5Mh63vPPZbPATM6muiX7tHdQD66QivqzvZR3lN
 3vzw==
X-Gm-Message-State: AOJu0Yzdt1Y47zJBBoCgJ+tbOaaZIC3fL/CIkpo6cifXzWg6GjiifiNx
 ZKMsTnwdfLOJcBHmEO5cHpQbgCEVzsdehzXg09/MKBrwsu/GL5kXWA5t4ptjykNT8Cqh6Ka4ykM
 vQFQgMUE=
X-Gm-Gg: AR+sD11sDM3NlX8hFA2se7h42ZfdMr1Eu1BfZTt0xq7VHwix0hwNZ6oU28G9imHGMwt
 3uHx3SuT48GMr/lEhmzPqUxojlO8aBzL+OAw8orgEQrn59FBgM2a49em3mOby7Sn5nc3wku3O6F
 gnAINGLDj0cWRyo57fzTUBAw8oStO6gBuWaeTiimR3q7u4psizegFauTd+Z6euRZBp9fBLyN0ZA
 eKU8zEGjqLTZ7zfPYOIB3T+5pVdra+mu7GaSBEiRFOD8sK6o2XtSZ2Z1sgiTe4QwCnJHm5FE8qE
 LEE56yP4gfJzl+HIPKTMpA90SPl3KdNQv2DFK7QgsPtbBdYKVhwCfucqKxYAbO2DoKLbiNFLwvo
 feYEH9wTu2r50rUQ1wpp3FeRhY4V2R/1wH9xFx+HLmws5lm7Q3UQTIE1dov6j693s9rQAwMay+F
 pFzNrkYqPArCi9XGnVN3dk/sNQYN87mBNxbPDP0KRdsckoU6/Ft+hJFi/dxTOdFrcHZ53JaCl/k
 0bYmrwZw6maqCpEUliqD4x3axrJ1MufXLlvIkQuJTn/T7jrfb6gCmhAu3Q=
X-Received: by 2002:a05:6402:541a:b0:6a1:284f:7891 with SMTP id
 4fb4d7f45d1cf-6a3644a3c3emr3141426a12.7.1786474112253; 
 Tue, 11 Aug 2026 11:48:32 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f001cf8ed71865ce089.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:1cf8:ed71:865c:e089])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a362ec88f5sm950529a12.19.2026.08.11.11.48.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 11:48:31 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Date: Tue, 11 Aug 2026 20:48:12 +0200
Subject: [PATCH 1/3] net: lwip: wget: return ERR_ABRT after aborting the
 connection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-lwip-httpc-uaf-v1-1-9f0ba7331dea@byteray.co.uk>
References: <20260811-lwip-httpc-uaf-v1-0-9f0ba7331dea@byteray.co.uk>
In-Reply-To: <20260811-lwip-httpc-uaf-v1-0-9f0ba7331dea@byteray.co.uk>
To: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, 
 Argus <argus@byteray.co.uk>, Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Tue, 11 Aug 2026 23:05:00 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1786474555; x=1787079355;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JHTbGRcN0C3GMRAXU7Rfjyn8FbxUvMC/iKgSdb6E0N0=;
 b=qG27+OeEiQ+qUHOjkFes6eQyzQCYTps4yJEpv557CZxt7o81x9SZnAB7wAi58C853s
 xjVZzt2BKMPsslODt1pyMLFQStl43c4BiRv2UHTDmd8vFwiY8jFvzuDFWXFBeE1jP1EE
 fsRFAsD6nWYPAkWQMu7yjhnhbixj9gOd2GK1e5J//hKcsiuUdZKWDYGQ7VkACF8uwyCK
 T6NNcm/7nONNcT/t/jS3wRE8e+PxX0vJd6+yPDq9qRrokLfTI+s3yW4VhvP+Oa0I5R3M
 jWGb3HUN+xxWHqXBnzc745/gFAMgjm9YaICbYDj0u7x7tNtnNCsrlZdBGn+z8qEsfa6k
 2h3w==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=qG27+OeE
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On a store_block() failure httpc_recv_cb() calls altcp_abort(), which
frees the pcb, and then returns ERR_BUF. lwIP's receive-callback contract
requires ERR_ABRT once tcp_abort() has been called. On any other return
value tcp_input() keeps using the freed pcb (for example it stores the
segment in pcb->refused_data), a use-after-free.

Return ERR_ABRT so tcp_input() stops touching the pcb.

Fixes: 3c656c928bd7 ("net: lwip: add wget command")
Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
---
 net/lwip/wget.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index 247ece18e2b..9e93765926d 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -205,8 +205,12 @@ static err_t httpc_recv_cb(void *arg, struct altcp_pcb *pcb, struct pbuf *pbuf,
 
 	for (buf = pbuf; buf; buf = buf->next) {
 		if (store_block(ctx, buf->payload, buf->len) < 0) {
+			/*
+			 * altcp_abort() freed the pcb; the recv callback must
+			 * return ERR_ABRT so tcp_input() stops using it.
+			 */
 			altcp_abort(pcb);
-			ret = ERR_BUF;
+			ret = ERR_ABRT;
 			goto out;
 		}
 	}

-- 
2.43.0

