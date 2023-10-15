Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E49DDCDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 22:37:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D98FE85DE0;
	Mon, 16 Oct 2023 00:34:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ToYuL8Y0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A036F86B29; Mon, 16 Oct 2023 00:33:58 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E7C786BC8
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 00:33:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-51e28cac164so10353360a12.1
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 15:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697409196; x=1698013996; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jSXJr4a6TW/hEc6Cc8jFQ+Goa10EkzsZ9lSM1LqpRHg=;
 b=ToYuL8Y0QSrXUScWKH3fR0+Vgo96ifBzOezP2fz8RMhYrmYzW8vz54wa4ToSD3s0L8
 ThMOr0ZPlxy8p8yTu/eZksJceEtaYvEBVgygQI1PlixjTtrkLCLrV+i/E3uFRez22Adz
 Z/nM8EwjRDBFX3CvGAtw5zWXiU7cVSj274cb4udT0eyPAau2PoXO1MRcK28jErufM5sI
 IgCTVH6PFxiQmmvlULiEqh2RcA0Ir/0f9imUmTzleFtYZFG/W51zIsv9Y/R8pok9F/Yf
 sdazppYUu9DIuMK1UDsXep08dDy3LxHUyo6qgrj6qQ9Ct7HtAosJo3Bp0PjN7L8kQPzK
 zHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697409196; x=1698013996;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jSXJr4a6TW/hEc6Cc8jFQ+Goa10EkzsZ9lSM1LqpRHg=;
 b=nBUpSrM592Xi1L6769tfSUur6A56ztHNIdqIa8SBEYl8xIHyGQhPM6XqQEfne0sLE4
 GRLSOEHR2P5+rLi7n91KoRwnWfd/te6pwTpEGZdyjFbohV6k+jl1Mh4VBIPoldF9SOZn
 G+I8YO+qmexliLsNS0V1mn/vCYQkQBGXQpeo8tGHAeHtoSiFe/YlWbC1Ke5In+UJUrQr
 9TMnbRE6EpABSkFY6W6Y85ztcDS0KZwBOxgTJ/IaCpa0O3XTQU2TecUbjAzA49DRY/+1
 O5oeqKWK6FvFpvD8HkWde/ru74H8U723Hlhm9BkTokaAphLOTMxi0vpu3GenOZbzRAcd
 y7IA==
X-Gm-Message-State: AOJu0YyjZpQ6XCWBSt4jHG7SBwFhV6Ap2ZDvAL8ru2wNraJ+T6KnplIw
 D+9oAbd+R0WbK6t0f6WRHXo=
X-Google-Smtp-Source: AGHT+IFSeX9zk21GIvbxyufmXQM7dWLtKUEsdC0cN5r1iuEZoel+8eOz91I/ANp6U05pZG+/4u9TdA==
X-Received: by 2002:a17:907:84e:b0:9b2:b37d:17ff with SMTP id
 ww14-20020a170907084e00b009b2b37d17ffmr5103236ejb.19.1697409196545; 
 Sun, 15 Oct 2023 15:33:16 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id
 hg22-20020a1709072cd600b0099d9dee8108sm2909762ejc.149.2023.10.15.15.33.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 15:33:16 -0700 (PDT)
Message-ID: <fd206328-2ffa-c174-179c-85f6428e5d9f@gmail.com>
Date: Mon, 16 Oct 2023 00:33:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v4 4/8] rockchip: block: blk-uclass: disable bounce buffer
 support for rkmtd
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 u-boot@lists.denx.de
References: <8c0f5bb6-0110-b7b5-3c40-2d8d98a94dfa@gmail.com>
Content-Language: en-US
In-Reply-To: <8c0f5bb6-0110-b7b5-3c40-2d8d98a94dfa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Disable bounce buffer support for rkmtd.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---

Changed V3:
  New patch
---
 drivers/block/blk-uclass.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
index 30ad5bbb0024..ac1b43d757d8 100644
--- a/drivers/block/blk-uclass.c
+++ b/drivers/block/blk-uclass.c
@@ -415,7 +415,7 @@ struct blk_bounce_buffer {

 static int blk_buffer_aligned(struct bounce_buffer *state)
 {
-#if IS_ENABLED(CONFIG_BOUNCE_BUFFER)
+#if IS_ENABLED(CONFIG_BOUNCE_BUFFER) && !IS_ENABLED(CONFIG_RKMTD)
 	struct blk_bounce_buffer *bbstate =
 		container_of(state, struct blk_bounce_buffer, state);
 	struct udevice *dev = bbstate->dev;
@@ -441,7 +441,7 @@ long blk_read(struct udevice *dev, lbaint_t start, lbaint_t blkcnt, void *buf)
 			  start, blkcnt, desc->blksz, buf))
 		return blkcnt;

-	if (IS_ENABLED(CONFIG_BOUNCE_BUFFER)) {
+	if (IS_ENABLED(CONFIG_BOUNCE_BUFFER) && !IS_ENABLED(CONFIG_RKMTD)) {
 		struct blk_bounce_buffer bbstate = { .dev = dev };
 		int ret;

@@ -478,7 +478,7 @@ long blk_write(struct udevice *dev, lbaint_t start, lbaint_t blkcnt,

 	blkcache_invalidate(desc->uclass_id, desc->devnum);

-	if (IS_ENABLED(CONFIG_BOUNCE_BUFFER)) {
+	if (IS_ENABLED(CONFIG_BOUNCE_BUFFER) && !IS_ENABLED(CONFIG_RKMTD)) {
 		struct blk_bounce_buffer bbstate = { .dev = dev };
 		int ret;

--
2.39.2

