Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A4AC55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 19:13:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 255C360714;
	Mon,  3 Aug 2026 19:13:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZX6E0aEhw3A6; Mon,  3 Aug 2026 19:13:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E9B55605D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785784405;
	bh=9artrsmgWtIMnKJpg9n6C1X7vOMINTo0CazPm2oQ1Y8=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w4ZVRYcjaxrIjH8vhBBdwdiQtuCxSvzPtQybdh9o6sNzfixwjJv3sPtszH8NkYJOu
	 a6q7PdR1WcUv/RD8pgSCdeFyIG00DSHDsRH+2Rnv6scTd6Sy7z5LwgRQ+n1g8RgVGC
	 jN4OpY/Ok+FNX/QJ+7x8pR7JP43l9jKhv8XCI51t/aDRYpCKE/iSFUoLiOdq+Bn+q9
	 RB2JCxEPNSILNW2P978Ah+ptjkrPKz8YhFrXyFg5jbUNz+jbMFL+9xm46fquxlXe9p
	 8/gPKN8MkycPeoYIpi512P1N/X2TUnc4vOWvDYU8OTFaqntENPr98dTpiXLcan7UAF
	 mMzvAXfCBedEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E9B55605D9;
	Mon,  3 Aug 2026 19:13:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 229002AA
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:13:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 14ADD605D9
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:13:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pD9TCofIpiI7 for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 19:13:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 34DF5605AF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 34DF5605AF
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 34DF5605AF
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 19:13:22 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6a10d6f455dso98195a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 12:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785784400; x=1786389200;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9artrsmgWtIMnKJpg9n6C1X7vOMINTo0CazPm2oQ1Y8=;
 b=EnEuGzWVwEZXBzTq58j61/rZVINlVaYJ70QGIwJ/SRB+MSu02+ghUhruX8yELYsVI4
 r+oqIurSo78BuzuZgfzvC7OjB0qNTFeymOMoVAx49AFh8TKtVjLT7+fzN2j7lG9iKP0r
 M3BT/BmoDNUVjPR/+NGO8f2foK2HRnLDMQeKJYKRY0KV71Rl7bpShBFBARnGiD4a4+DO
 cg7rpo/ApNjm2tqrpzrNWNP+CLcnTTUWXd9Ffa2zNOJqsRRi7WnGnC6gHUqAbB09miB9
 0N9RnwvPAHxhV0+tYVRUNA+uo5u1vfzEmDhHDRVXzJw3AuBVvUgO/LOltn8bDD9CL0Px
 e86g==
X-Forwarded-Encrypted: i=1;
 AHgh+RocfobGJaF1fLfCBoybAqgqk3/Kgfn/wttkJRRtLKCG6QrGADx1usV3348ZZaKyf6uT61jp67U=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxPkyLD5laH+tV5Ok6IgtB3pWKqwrgPYwZg/Td7tsiKBQ7ygjwE
 bYNF/fWQi+EHzy3SrgPDif2hG6REzkh1OEg7zppG80OymMd7dV1qOJ3A
X-Gm-Gg: AR+sD11dj1f3sdDFeNuUB81PoNAIahaP6zuQ+1lgFRNhEk13LrhCG3UsJ9LKgT7vH0F
 mdN4lT4QipTgftMkYKSsO/j+DAKBucvGJxhfAbbDnTFlO54vGy/FCdgQ0ulWOvQSJQ4CGyd04Rs
 MuB6THuJL54x2r8Eg4RDG+nTXEpxX4YqtpndC8VS2juArhAZKVuTKoyr/j4ss16R4CPffBXBsqR
 g10ZnJKGkDLopI5lwlFsfQjM2UeELPpUyj3v4gsIApMNPmHgxc1quILk+D7YMDVXgjSdwauKDOh
 xsVVy1oOJI0wiqGrUiPWGchXwWmTWtpsbZRv6aoKNi6yrQu5ItCy8O2LbLXlcVcMSgiowAWQm9a
 SawHhZqp9xCbpgsr19StSZzKUhTiYMTh54RqHbDdPa1JIKHysGercpjYqk0RreMoTq/ELeE1UhH
 wFY8gpkXTnjJR2maEGo7qI5YsHcATVyq8zKujVqcHvbLdM2O/Limqe62vb7dlWSIXo53W/5xSoA
 bpYUeN0s4APAOhOjB6FBJyZimAJM09bIS2mgg==
X-Received: by 2002:a05:6402:350a:b0:6a0:d532:7157 with SMTP id
 4fb4d7f45d1cf-6a0d53272f4mr3374705a12.1.1785784400052; 
 Mon, 03 Aug 2026 12:13:20 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a09c660f6fsm5866544a12.25.2026.08.03.12.13.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 12:13:18 -0700 (PDT)
Message-ID: <b5753fa3-d1a3-4411-9f1d-319915541676@gmail.com>
Date: Mon, 3 Aug 2026 21:13:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v4 7/9] rockchip: tools: add comment section to rkimage.c
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <d15555b5-e57b-4567-ab70-56d48fd4b878@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <d15555b5-e57b-4567-ab70-56d48fd4b878@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785784400; x=1786389200;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9artrsmgWtIMnKJpg9n6C1X7vOMINTo0CazPm2oQ1Y8=;
 b=Lk3XrS9xlbK2JsFKb4wLlplli6GiZteO5SV0SmKmqbo/NDFNrFNrKay28aDvKX6juA
 mKb+Ra7URgrYjY3BxtAbKvN+7xO3g+7Fy5iJsoqho6R8JSCnEuB1ffaBGZz5ueW/kz2w
 W44sIra01Z8lgAvvareEHeYmxqLivWJ6UP6l8J9cUdq3VX+KSNPaAQSMgDUB+p4xGiDN
 LiBJX0iI7KHx0Zcvlw+Gx95/x/y3y+aSqUb2B6WfxD7StfCYlZgkgb4C4ZMhNq97+ndC
 sZLYXbnIZl7WVFQA7jrKXmGhNkx2YVg7OeVsg0UXg5iWD25ssrAmjqpGFWpldP201JQm
 G6oQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Lk3XrS9x
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
Move the rkimage comment section to rkimage.c

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 tools/rkimage.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/rkimage.c b/tools/rkimage.c
index 1c5540b1c3d1..0cabdf2f6723 100644
--- a/tools/rkimage.c
+++ b/tools/rkimage.c
@@ -3,7 +3,9 @@
  * (C) Copyright 2015 Google, Inc
  * Written by Simon Glass <sjg@chromium.org>
  *
- * See README.rockchip for details of the rkimage format
+ * rkimage.c produces a SPL image suitable for sending directly to the boot ROM
+ * over USB OTG. This is a very simple format - just the string RK32 (as 4 bytes)
+ * followed by u-boot-spl-dtb.bin.
  */
 
 #include "imagetool.h"
-- 
2.39.5

