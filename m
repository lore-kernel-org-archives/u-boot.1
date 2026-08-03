Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96120C55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 19:12:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5701E6070B;
	Mon,  3 Aug 2026 19:12:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2jDgcAB0VyBC; Mon,  3 Aug 2026 19:12:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BC627606B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785784372;
	bh=fpUuzyD3X9gHd1cBuYdLZjvVE11Bv3sLvZOigRQ4yJo=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fxwG/sfxBqYulj9bgA28T2IVdVkyos91t/O2LSiCIRLvDQvzCIeA5nEdqmaGVY0zm
	 U9KkRgivrbdpi9KD1jJJ7oljWRtc1MEKsGU6ZbEo8XZgnXdf5yULYOfubiZHHPb7Aw
	 xu45FXOzH4kGdI2jqVnreOckRggcNK0qgtwDZPINh/d+TnhUQzflDPVgvPKxHo0weG
	 /MhtqvHyQYwtmQqsSsbljaHzuPLadOoVbEupqioLsX7BRhwRuiz6EZETy1eSwm4Dmv
	 ZQCZmEa2ayYQEWY+6T8CON2K4JPI+QfhsI4h2VUqhOLrwSdDZkONL8jtOIYf1wXIlK
	 dc4/zhrgL1x2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BC627606B4;
	Mon,  3 Aug 2026 19:12:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2F00B296
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:12:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 210D1405C4
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:12:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TvLGGu86Q2Lj for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 19:12:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 51E3B405BF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 51E3B405BF
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 51E3B405BF
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:12:50 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-69fe1df830fso542477a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 12:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785784368; x=1786389168;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fpUuzyD3X9gHd1cBuYdLZjvVE11Bv3sLvZOigRQ4yJo=;
 b=M30idsKz6Mfu4/e9IFbIGXFdoYRCNG1G5cJSDWXgHZxd6LRZtknKkQPBEx5AVKdC2b
 I6xfcIrfq42hVdPSjDRrTqqW4TrfDGmLWx8ud3f27Ut913vk/j81x/T6lGqWEokeQFcE
 H8tFhE2PO8CyLwZpmVVxBClV4LlP++FGB+Czn1r9/qvf0kRto/K8PhxnoCxEUuqw4k6E
 jNatFP6eODhs/EaNM5heE3egUQyJh1F6RyL3NEQT7sU+HRAgqowl28fJZcR8qvMPoSHT
 e1U3erTHfd8vKcKQDFAkHqK/UxyK2Cx6Tl++PoQYUUWWT7aXeOK734HkInRX3VaOCvlk
 3eRA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro5AbkW9OSoLPhVVI0WEH0eJfAlTCCA5Ed733zi1BG6/Yky33Epw9gll6X8dR81+CVjVObVBFg=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzzBWblg67Y5hSUKbtERfF5et4NoxOIfaecKha8e8mT652CTiU3
 z7LXtnX8IhNoTcvW+6rTByYoe+2Wpu600b5duJPx9U/nfqBRPlu7qHwy
X-Gm-Gg: AR+sD12j5aj5KzZ/kzloxL3UujGCZtYkdaMHUHNBOKxphc/YbYGVo7mKqXety5mjfMJ
 DTVWaRir93V3hOfo4sjLHOihxepjKCyg9g4RlCzfCZ7rlSAB6UnNidg9AvTYnvgMGFE1M3bZQnM
 6wzl7EruE7DKtMyOyMtNvFwVHw7QS+AXuuAWBkg+W043bg1iX7kTblOWfdT7NqhxJEcx3gf7+s8
 IHVju7rkgPl6W+dTSsg5bWPragyoAdsG4IpbuE8mNdHjk4gQmvbnAV7Kx7mfLpIhYWk9xHSGwTb
 Jv3UHrQilqGzfjS1/T5YdaAtVSCRzXCtlcRBYGAtqUQjpFx8Mo8Noj9f/C8yaWLPZKJg90dl3bt
 nOmaQx8wOkkXq0/wOvWURcP/PW3VnOdKjSDtkKQPoslYpJuUvGF+1LQh/qe+ps4I08GAoRSYGT8
 VIIBxvsgbUWr1n8c5QikPftCcrrgOSLH9QqWZtFEVL5y+9yzMaaVzFgTjlorNfBg01vi39AkOaI
 ADHiGryc+Y2lNk3E592HTXxgMk=
X-Received: by 2002:a05:6402:501f:b0:6a0:19c8:f9c0 with SMTP id
 4fb4d7f45d1cf-6a0a7d017camr4955873a12.4.1785784367911; 
 Mon, 03 Aug 2026 12:12:47 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a09c63daf7sm5759886a12.18.2026.08.03.12.12.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 12:12:47 -0700 (PDT)
Message-ID: <4cd5a494-93b1-4cfa-90d4-7965be37ecc9@gmail.com>
Date: Mon, 3 Aug 2026 21:12:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v4 5/9] rockchip: tools: rksd: remove reference to
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
 d=gmail.com; s=20251104; t=1785784368; x=1786389168;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fpUuzyD3X9gHd1cBuYdLZjvVE11Bv3sLvZOigRQ4yJo=;
 b=RtQNgQNN2LIWW9d0F/kcqOz1XbzjvJ9Vahvx5WBkfImezdByeIUiMgUJ9WUadzCpJV
 Du1fNmRp2XlAI6Z3g66u5kCvan27U5LqOZ8QmNf1q0VcK88JDl1au647hGV87OjQsrsx
 U2/bOo+7V2/46e40e2FJFMPDz1cJGP23vEKoinDC4RyyIeRqn9IJBy5bbk07LcFgwVCq
 Jskh7+P9VaD3HuwBod76l3n5BuIHl23mrBbMw0ehSpKifL3rDVsvUE6bX9ZfMzYId66u
 o9OiSqeREWAs8j5jV+NG/+0RFAG9vN7IEaSMK71DgQUlwd02a9TO+Aw07VsiVhqWexhn
 NX/Q==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=RtQNgQNN
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
Remove the reference to README.rockchip in rksd.c

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 tools/rksd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/rksd.c b/tools/rksd.c
index 7d46a1b07b3a..bf1b3737b72a 100644
--- a/tools/rksd.c
+++ b/tools/rksd.c
@@ -2,8 +2,6 @@
 /*
  * (C) Copyright 2015 Google,  Inc
  * Written by Simon Glass <sjg@chromium.org>
- *
- * See README.rockchip for details of the rksd format
  */
 
 #include "imagetool.h"
-- 
2.39.5

