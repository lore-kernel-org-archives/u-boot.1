Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83292C55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 19:13:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B1566070B;
	Mon,  3 Aug 2026 19:13:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qQYNZDG4lvLS; Mon,  3 Aug 2026 19:13:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0AEBA606AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785784418;
	bh=RlfZihXi3bZZtzLeX2cxXZIr/9FWAj4CkJSQkCbbqGo=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=txUzxmEnal7rl0U4UPa9Rg/t9j8G0t+wqlr9sNgbTH2wdFFhtLjAsDliaOEKSR2wY
	 AKcbIrn+g9iVKNrX70Qkjd8IFaLj/bAORy9ePfTKtCdY12koIfJOEoM+pu3DqDk6AE
	 +wQkHT0VHiL53zMAepQM8Xg5unPfvL60u+frqVz3tmPuwYitqWuTIjDHdSwcO3Tc8w
	 /Yl/pYEawnmlUb2bLIVbUMVhyhR3utl/HlzgndXfK8E1Y2q3ZWNPw0PH8seGD7TiIz
	 fZ56uPGoTA0/twfSaGzc+xEODfm3mFcrt1kZK6vfFSA9kcyYxhZJKcOyluToB88M5T
	 Mf5BTOPE2qNgg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0AEBA606AE;
	Mon,  3 Aug 2026 19:13:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 66EF72CE
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:13:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4CE8080C0D
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:13:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lk3JRwyKSs10 for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 19:13:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1DCF180BF1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1DCF180BF1
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1DCF180BF1
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:13:35 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-69a33fb0031so697844a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 12:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785784413; x=1786389213;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RlfZihXi3bZZtzLeX2cxXZIr/9FWAj4CkJSQkCbbqGo=;
 b=GC5MfEWsNTnlLlbPSIb5b/L2vDrHz0XvppLA4lyIfI2PMDHGbBn4Y+79XXWgQwi8yy
 WqKx1B6S+CbcRK3YJsoclK1Ex5wS+tXlWpxZSKx63DKPVZUUsAnrjNE3xMSzISdnKKMP
 ri34VpL+kJc/ShSGvJfWwZvNv7CQw7Aa79PbbsIcrNPZ3zfkAZThJ1j0wVycw0w6SNzd
 11eLMaVJH+s+N4D1IxPbAZ9dIjCGzQNJu5qfOYPrDU09CmWRpkZKKfWIEijeGo3D6mQf
 sLoKz1JleUARCcfgDhVBKmJaV92xGAuhwWI8KbjtxqF93PiZIqjFeAXr3tY4At6KFhr7
 cisw==
X-Forwarded-Encrypted: i=1;
 AHgh+RonSMmK38vQG6aRcGwWLbvxXkrSfAMoX6P+k5aNIghkkcmT0y7GAYlaEbe+HzRVnE8lPuwV1wo=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzsqiQa5u3HAFRye9VXkeJBZ8F3/fkv8v2dcc+txeE5Hlc26bKR
 KUzlJMtDPDTA13VlhuNfH1dfm6V3N12umCAzfrweFMKpcShaVi7Ed0Ao
X-Gm-Gg: AR+sD12YaeRa1QUNxZ8HVjUtgpgOkZozB2K6U9zYIeCvqlALS6fxFcvkeTtNoqaYRP2
 /rRTgCRNufMgJpS2pvwpSAKJ0h6gIH44sTd0g4aKzGn4qT+KOd3JQIkUrwR7+DqRZ4nZzCYQTtY
 xsFuNA0TW2pNoun8DfECMjrr+lEOFir8Zl7g0SY/4dldxi/yYKyOV3xrjKaspkzFAUujr8RlH4m
 0jxjHFyBWhetEv8up8F+TiXDCpjoWAGJmxqAnkOS1xpWXAOHtBR44ZF8bwXTEsWC7Wns79D/GvH
 ZZg+xAcDGRgjdD0b6wUR0q2ajWEEA/voQth3w63feGzzqVUsY87rCRqO3St7EsLwx9ZcmK0sCY0
 atFvwqSxAJC7R0+IXvMiHmYX0438DSsVTofJGIUJ6cXc25O/DHW7qyY3q2f4ZSu1Z2pBUxMKbw1
 8jM5tz1ZZzBvDjkJpsT3XaQ8F3awLk+Xv/35p6g9hScvQmpsuGgNgrrK+hYAq3zNYvWqIOEcytv
 EJJmRb74RXgzKxal2/HzRvPhNbs
X-Received: by 2002:a17:907:9616:b0:c12:732a:fe52 with SMTP id
 a640c23a62f3a-c1fe80cb168mr579238166b.4.1785784413007; 
 Mon, 03 Aug 2026 12:13:33 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1ffbbbe009sm257500166b.10.2026.08.03.12.13.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 12:13:32 -0700 (PDT)
Message-ID: <7b2fc523-7721-446f-8f98-80dc61145fd7@gmail.com>
Date: Mon, 3 Aug 2026 21:13:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v4 8/9] rockchip: doc: rockusb: remove reference to
 README.rockchip
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <d15555b5-e57b-4567-ab70-56d48fd4b878@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <d15555b5-e57b-4567-ab70-56d48fd4b878@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785784413; x=1786389213;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RlfZihXi3bZZtzLeX2cxXZIr/9FWAj4CkJSQkCbbqGo=;
 b=lh8XmxEmacycyispimNw3emLTwHZTBIYD/v+9zWsw2WDUbsPip0tffTUvFe6byesZj
 FLDEDyQa7nk0RG3to4ZrqJ3SgDzUdS3zQsCQ3Nbj3PgvGXcBcn6i2jwY6qflpaHjNOun
 JsTQll/xj5FQVzRQ9iKmu6i1Byho7i55k+rg0Y/oJ1AYWnvEBDDlMwUCtmZ7yLa7GpqP
 wpzyaaqDvcrvJ55/gPB3MMQ2lMmAB8mmbvJavo7VyktdKcCA7XrRd3tBG980dV0iaBaU
 2jJRC//VLEgD7ZnCIp9lmNUH0yTjn6FgmSExYDM5X5tA9Hc8SsiJxb7cQJkIxKDnXTX5
 lWHw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=lh8XmxEm
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

README.rockchip must be removed.
Remove the reference to README.rockchip in README.rockusb

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 doc/README.rockusb | 1 -
 1 file changed, 1 deletion(-)

diff --git a/doc/README.rockusb b/doc/README.rockusb
index 66437e17e46b..5b96467689b7 100644
--- a/doc/README.rockusb
+++ b/doc/README.rockusb
@@ -38,7 +38,6 @@ you want to write.
 sudo rkdeveloptool wl  <BeginSec> <File>
 
 to flash U-Boot image use below command. U-Boot binary is made by mkimage.
-see doc/README.rockchip for more detail about how to get U-Boot binary.
 
 sudo rkdeveloptool wl  64 <U-Boot binary>
 
-- 
2.39.5

