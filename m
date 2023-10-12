Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E25BCDB474
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 20:58:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 087BC86E51;
	Thu, 12 Oct 2023 22:54:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nQz2wRJg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2313786D20; Thu, 12 Oct 2023 22:53:00 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45BBA86E4F
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 22:51:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-99bdeae1d0aso232588366b.1
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 13:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697143913; x=1697748713; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TO/zYGWM+LZApIzwrL0sYZ6uGjFjQhScsUi5aRRWw4k=;
 b=nQz2wRJgZM1CZqwGdwPMUAhTe9P+AH7FeVK3KZdtBWQfP8peCJ9atJEri3D2+Q+MWx
 9JfQKrMqgDp2r4xQ1E55rCUbtGcDObf4iEBOlEy4zIU2IQvm7TynqFkqdoT7JNhplWrY
 5EF0K7zsEyt3/t0KEiC+OVT/7GA66AYAek67LbJzK05hS+s6t5gE+WhtQSJlnqMIqTqn
 RMkXSJXCD1OrvVbJEdvuYNGnnttPM+PE2iXtkQk+1xaJYKRHCbExkIUPJ+1PVwSEtFxr
 lUkt0p1uluPM3h+wXT5Oxx5cntwv/UkVh2FIPSEtA1EQustpi0Ok0gGzuXxX5dpu5IBJ
 xVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697143913; x=1697748713;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TO/zYGWM+LZApIzwrL0sYZ6uGjFjQhScsUi5aRRWw4k=;
 b=eNURTZuD5fJa8BAeu1PDqeUUXROAGwFxKkonIV5DRfw3M/3OxoxHx9+Qxs37UfQg0Q
 9vs6otbSXh5lOGpCjW30oxLowW1S3LUl1gbJRj5ENc9Z3GdAMlu9h/grW+6Zy2I9pux6
 3EY1QTGzTOSSIy0annp+AnJAxs8Gl8RvihAIxCt+eFNNg9Mw35SQcV4mxH6wPAr7OAI/
 xArwDZDU6RZaj3UKtwxFliecpyI4s0fK6QtAhAPA2E6RlDdaUxLtoOl2HscntMMdgTon
 tdHdWxn3GJni1AYH2Ivp+xRjcXsVefWzX8spS/Qyt1wuGxXmWda4UOz5KkFMEocdtTHp
 iLpA==
X-Gm-Message-State: AOJu0Yy6l93WWOATpanTBC0JECJTQVMd1BD6JwHIDxHt8nevKGAcnsOo
 iURPQmgXmDDr1krGteg6g34=
X-Google-Smtp-Source: AGHT+IEzX6bmDy9qy3UvW7TPJV8QxcWdhVxOEObvi7ZQUbsI+TChLnWtNsh9TbsvM86g1ysLHPf6dA==
X-Received: by 2002:a17:906:13:b0:9ae:519f:8276 with SMTP id
 19-20020a170906001300b009ae519f8276mr21501771eja.73.1697143913207; 
 Thu, 12 Oct 2023 13:51:53 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id
 i3-20020a1709064ec300b00997d7aa59fasm11721493ejv.14.2023.10.12.13.51.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 13:51:52 -0700 (PDT)
Message-ID: <4050eaef-b4c7-3f18-6bd0-a89ac03ba4bb@gmail.com>
Date: Thu, 12 Oct 2023 22:51:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 4/7] rockchip: block: blk-uclass: disable bounce buffer
 support for rkmtd
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 u-boot@lists.denx.de
References: <9fffc997-fd13-eba2-3a73-a8e86816667c@gmail.com>
Content-Language: en-US
In-Reply-To: <9fffc997-fd13-eba2-3a73-a8e86816667c@gmail.com>
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

