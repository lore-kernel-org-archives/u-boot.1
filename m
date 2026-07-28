Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502F7C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 06:56:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 198E660839;
	Tue, 28 Jul 2026 06:56:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HsCSDTLpUDtX; Tue, 28 Jul 2026 06:56:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3C46760828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785221818;
	bh=P2Ckvuu4uP7M103Mt5h8ecn/jiX9slzq2aK9qCsTOcI=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R9DVC6dUA7dScgIRyJkjwCTaW+imZWXsbjot5Aw7yaKbseKmjeqH/WwbsOUyhw1OP
	 MyFUOP2cp/S6p6kb/RlKDMZhoK/cj0X/gFsfx6Lkw02i7PcGgClM9s1wGJOQEYTDP7
	 ZRSWIgUDiYoW+B2wBoC1LH1wpfiNPmm2Dh4SKn/8YN5S7V9z4pzJ3XqR9ENXnJxLbz
	 c53kqpYjN5nbBiHEyTIz+/Wpnymju8GcdQOKUWhOr7F0tJFZwu2TegFv6ELpw2Y+IG
	 O1BNqAf94E2ipv74AYx+DCRq/sZ7Ch0qU/bfg9TxII8GD9lv3gpKhwdgO5OZELlIs2
	 H/2f5RkqW1gGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C46760828;
	Tue, 28 Jul 2026 06:56:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 86155357
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:56:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8420E81266
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:56:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NidMsb0KKP9p for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 06:56:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9F86681265
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9F86681265
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9F86681265
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:56:55 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-698ae9da373so631832a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 23:56:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785221813; x=1785826613;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P2Ckvuu4uP7M103Mt5h8ecn/jiX9slzq2aK9qCsTOcI=;
 b=cNwQ/eG65n2Oz38aeggYzApeNURm5UQmefW8nhdiL8ztXFUv1SXtyWfBvmo1fhATlH
 8MuAkO3JDyQDC0fkCkWFWTimQ8JW8mDL9T6GX5MKxtUNWRVb0a+piTMUmllIvP8m48BM
 cU6Kf6dzNKZe48o2E5xyYcjskyuAiT9UBaM4tMPu8sNbWUR+b6Y6RBoMBI9vAer0FNAU
 aZVMh9yWX8fwjL+CMn5O5Fm4G9SqkFGQHW63ZkTJKXg0r/d0UknUdngYpmHGUM0aHRBn
 kPQqSqCtrK3XZXPUhYqGmRu6fs7v7+LhrhQCMVgFHhzQn9gjUXdyBUsEZJ7uBvA1sitm
 XzOQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqvLkk78KCtNndCahYvqLA5cA2ql5lqa5g/4FnEVM9nn65BDObsgTi2ubIuT9365NfTrlnhy6Y=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyqevKPYe55gQzd4GnAqA8RXLRrNgmz2bv4UC5+d58qydiPSlVw
 NAA/rtJr45HeEx+ilnagt/7vuHHNp4ldpKpbRbESrnCvQh/ihFTb/EDE
X-Gm-Gg: AR+sD133fbVvyPxW50krh7vTRE9R8HwHOs9o83aRNQs+/TsqlQbjiL8JSESZqaE3DMj
 1e0JUfhsxoc02b1LZ4XSIIgI3CwFYS0r0v/yo1ru93JIeOXseeAkPQk53V6gT9mkkhfxzPU24EF
 WP/Xczgu6pgRz5TT2k2kneZg+8x4O/fJnW4ViQL6jsKRVxZKLKbQn+VES6Y27vk77h91YG5EFZG
 vGhj1Dg1GGhjGz3xKkB+5htfyIE5Z7TTuGFdq6u0/Yt9Xabyk/zf06ALfqiUM/Kh/tbngcP3jQ9
 DaJPfcRYoVXiGgIHiK8tvwova5O9v0BcIk4cfnPPZQHNRE9hVwvjBEnDwUN2YsIZRY/uapCSexY
 njmEiAOWH/8jvxarYGck4ujBTCjlMbAWAoIlEFp4sIj8PYA9e5uyjvlXCYHBDMplD8b42tdKvQk
 ubD2OFMiKdgDb1k0l6uDksI99pZOmElAiNVYngCf/L
X-Received: by 2002:a05:6402:5485:b0:69f:b7ec:9d98 with SMTP id
 4fb4d7f45d1cf-6a034aa6ebemr265136a12.7.1785221813351; 
 Mon, 27 Jul 2026 23:56:53 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a0341e3542sm358952a12.20.2026.07.27.23.56.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 23:56:52 -0700 (PDT)
Message-ID: <ca068b46-0a4f-4324-a6c0-ba56f76c6e23@gmail.com>
Date: Tue, 28 Jul 2026 08:56:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 10/11] rockchip: tools: add comment section to rkspi.c
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org
References: <734d54aa-6523-4c2b-ba3a-a51b063a340e@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <734d54aa-6523-4c2b-ba3a-a51b063a340e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785221813; x=1785826613;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=P2Ckvuu4uP7M103Mt5h8ecn/jiX9slzq2aK9qCsTOcI=;
 b=lg21Oldwcsy6X3nHVr0DBjNFqx3TZ64S4gXbDOaH/LPb3My6sMwDJ1ocyhDNkDsqaF
 DdGfNOjCafOSTLVWYYRKWy+eW1AIjRAeNpdT3MpP98cUujliYP8uIzlgqkwKnqp2N7U9
 03QHml6+wXjZweu4ODs5KmMhPM31wOnsa3G8Mq4ByDsrXEX3AViUrAMaL0rjGgE5B/yp
 MQMJdaP70eptd2envupgdl7xPB+lVt5rVJ9/NQZZWFH1B5m0EQWMqvl5vo9WviAchVDj
 Nm0cEugZy/h2ISmWD4TT5TTT3wAWOUODy/vM6h729FrkhSuI2tB2cUMuysOHa+aC/8JQ
 6Cog==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=lg21Oldw
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
Move the rkspi comment section to rkspi.c

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 tools/rkspi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/rkspi.c b/tools/rkspi.c
index f2530f7bde34..4f98a60a0692 100644
--- a/tools/rkspi.c
+++ b/tools/rkspi.c
@@ -3,7 +3,11 @@
  * (C) Copyright 2015 Google,  Inc
  * Written by Simon Glass <sjg@chromium.org>
  *
- * See README.rockchip for details of the rkspi format
+ * rkspi.c produces an image consisting of a header and u-boot-spl-dtb.bin.
+ * The resulting image is then spread out so that only the first 2KB of each 4KB
+ * sector is used. The header is the same as with rksd and the maximum size is
+ * also 32KB (before spreading). The image should be written to the start of
+ * SPI flash.
  */

 #include "imagetool.h"
--
2.39.5

