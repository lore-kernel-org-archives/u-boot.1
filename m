Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C13C5DF6A
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 17:59:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB3648132B;
	Thu, 13 Aug 2026 17:59:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 27XspHDmYscG; Thu, 13 Aug 2026 17:59:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1DE5E81313
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786643971;
	bh=JHTbGRcN0C3GMRAXU7Rfjyn8FbxUvMC/iKgSdb6E0N0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AFCOuUM+hNg+Ver7S8hc9hjb/gHLg82tEUD7NVn5bBbEhEh2drzfqkgo8vLNAZtpu
	 wgs3/nor7I0IZjgUEILQQvo3RbZGg7umY3te1DUth8tI5k7wGC0vYKnf0gbdeP7Cc9
	 QQ30aiNwP3iHkFXrEfAziYcJupL3VV8vMPA1NfKdfSiMp+eadqMq3wLGiZeDRjvyU9
	 +bwIlomOhSfJ6plcPYUZcF5rb5GL8JHvrnX//jyF5vFzHZJMKDCsiI3NVO2bvllZwg
	 OlSjhOspxK+bLg5ZZBdhzmR2zIrMzN6gRrirT4asDwna32SsJyhaWWVxYVKphkjfNz
	 fjTwzUeFSG02A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1DE5E81313;
	Thu, 13 Aug 2026 17:59:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 708D5259
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:28:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 62FB640418
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:28:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7KJZhLMfB8ew for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 16:28:39 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7790440158
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7790440158
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7790440158
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:28:39 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6a157f90752so3794800a12.3
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 09:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786638517; x=1787243317;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JHTbGRcN0C3GMRAXU7Rfjyn8FbxUvMC/iKgSdb6E0N0=;
 b=n598okyFmso3zp/z0EJH98dhc7LePrp6wyX4SMU+v+CY/GuqyTxXAA+7DJ2ACmh1K8
 L2hMNoiFh9bhESbK/LFaNKVoSwf+R5+8s9js9BG2HByWxGNAehisK04VVDqN6/Rmc2S7
 N4lpKQwU0/wOMYHlhOnIyRkx7kSbBf3/5hEck1i4/rw8N6SfZUYzhfBaZ33jO5YTrkVe
 Pyj3IT10cl5zJnwngO2fT2O0XSCe/K6tpXkd8ZY/On7WaF1ISymY4Y2B/3HM+m9o8kz9
 TQ3PPEJQigfJM/uuwHjQZMtj5aCzqLLexg+SLFyLPpRQlUFRVQFnks+HdseN1vg6s2IZ
 aFSQ==
X-Gm-Message-State: AOJu0Yy5zcnsGFmC+l4BNCVLmBR2+Z3cz84Hfe4nnSqrvaBVoPiUxliU
 UslOYK4SQi6TtXw+2bjKp7KBm5fCoxmUjfDGaT0jlfQX2SyvdDXteet0uFEOru/Z/xQ=
X-Gm-Gg: AR+sD13RYBC7MwS93Z+KimBhRIIcKUj0GT6+wmSH6dhMX8/g3SFTQm2hDpRV/S9rSAM
 +UC6xofNBwCEoaP0S0FtqzSPeMOWTrU3e13t1/eNvpOE3gz60YAwjHHkXnbwZLTeECyys8O6BaC
 xKJbsmOkIuFJP+k3bWN5JJf80h7mPH3JhrptWnls+heRHT/7wD3x41ysC2HmOz0JuyKMFf/suR9
 kClgH6cTWlGDV7Fj05OwocXrvfnZBuOyqC5j6WUSZ2UHkrkM85l5vVmmRKC82bzPrIUABMaosso
 kiYgmYF10ErETq8eSIjrO/UvJgHQ+QJpmzb6LjBoXzl3ILQHenFn/E7YU/QL1g7LyECXIkrTQ5/
 hhdYNx6RsLo5WRtfbsGZzE9hxvIK9d8tuJDlxTPJBZb14PhE2VN9lgc4HIY16zKk30D8tUo7Bk5
 sfQvw6qv+m02OAO4XFsiOXozpmlsd7nh4XTRqPLPykStILuT6WyoQ+UskgPcW18/exI/gVQgmjn
 zHE9F0VNtxchim7rlTmDAdUfAa7mltTZIkzZqOmRuGU/d5Gq0nCHWyU2g==
X-Received: by 2002:a05:6402:5293:b0:6a1:e8f4:8236 with SMTP id
 4fb4d7f45d1cf-6a38072df04mr3843579a12.21.1786638517389; 
 Thu, 13 Aug 2026 09:28:37 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f00b49b9d175e416b42.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:b49b:9d17:5e41:6b42])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a37f7f59afsm1139188a12.11.2026.08.13.09.28.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 09:28:36 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Date: Thu, 13 Aug 2026 18:28:17 +0200
Subject: [PATCH v2 1/3] net: lwip: wget: return ERR_ABRT after aborting the
 connection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-lwip-httpc-uaf-v2-1-1c3f0b3aa1eb@byteray.co.uk>
References: <20260813-lwip-httpc-uaf-v2-0-1c3f0b3aa1eb@byteray.co.uk>
In-Reply-To: <20260813-lwip-httpc-uaf-v2-0-1c3f0b3aa1eb@byteray.co.uk>
To: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, 
 Argus <argus@byteray.co.uk>, Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Thu, 13 Aug 2026 17:59:28 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1786638517; x=1787243317;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JHTbGRcN0C3GMRAXU7Rfjyn8FbxUvMC/iKgSdb6E0N0=;
 b=NlmexMvu0zJ40TwSLRB05NcEVLk4cJWsqdmpT8Xzq5thZn1Uoc9B9shr1UZiWZc8hU
 kZp8WCu3tnAfwNG1hPU1iGtLdQZ/qkavJYgqDvGnYRkr8hSQ2haVf5HHpH71OCtx+q07
 bhyLovwLywkv5eD5WwuERRHpXYrSVnHnS5xofMMJYv5LLSTFd8pZbq4X7/clNz83QOVB
 CBuZIBz28rgbT82EFMAXb5Gn7JBUIljxCEUJvlbi1muDe9DM67y+BJ9R7tc8dQBFwZkr
 BeEKoaCc/DgzKCmPor1dEjw96/UMSO4bKVUNeT2gxSCbU2szJv5tbaigbBSA56R8fDd4
 24SQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=NlmexMvu
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

