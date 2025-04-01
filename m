Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18749C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 20:36:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87D3381F59;
	Tue,  1 Apr 2025 22:36:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DIOKVi43";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6BA681F54; Tue,  1 Apr 2025 22:36:27 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77194817C4
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 22:36:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-72bbead793dso4402756a34.1
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 13:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743539784; x=1744144584; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PUSPhqF4Gw4GwvKvjJjLhkjd7R1eLKPhyxHaD7ETqlM=;
 b=DIOKVi43WF/hkqQm7C6u/1If+ltNt5BivxcZCY6N1vG7xRKvNMSEoDyla2Eat2YIQR
 KnOghvcZlIWZlYtI/OsSme8YG7j2Y5obb8QYKgEIx5TbJNZ8OvQdAewJanQz3cyueLol
 9zFuIFciVKj13rvmWQvf7favOxl8i+np8Fric=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743539784; x=1744144584;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PUSPhqF4Gw4GwvKvjJjLhkjd7R1eLKPhyxHaD7ETqlM=;
 b=s6yqyzMmhOdBhV7ik1KTLl2fqxJCt1wC7b2RM5bu4JBpkOgFY61ZvzW2+V3UTL3KB3
 IAuDZiwfcOw/mODCGvcr8Jogk38rlGr+JXGtuLaZRLaDT6zxsR4LYIHvHgijcQQw9liM
 BkWId9KCBV0w39pbNJZ4/gjlpLSqmW0hlOHGUwa/NQtOARHVornPN2TVzuXnSF2yJZZH
 lp1kVb76kTSAoOlYuBxB4eTVpU1k1lwK1yQ0MY9+blPbe2atjW2BZTzBLBp6RaqNHPDE
 0MD7PtZX2Xc0z2gDl19HJe31S+g+Q8u9Q0rWQcDUf2skP1n5/9l4vC1fLv2z2oUfCCrr
 g5PQ==
X-Gm-Message-State: AOJu0YwFzLYAzHVfI+fP2a+xu2QbSnnN5aBSb7lMYGnNROagOlMQwU/y
 selcXhrFdRCsP3a+H4m8ctNrb4jcoHz3VBxiuW1smkWvzrAaiEF+oEzkY6Gq678=
X-Gm-Gg: ASbGncu6/zsr39VcvVGmUuH8OFwgbaWeDkZKJ94sp0WjqOmzwK/3vCl206mTpV7VKEp
 Nxxz8q2ebe570TiDG2XTFcltWGMflbPeIszOYxvn50Os1GPZiGPaiwkrtWCN7XxmUJ8jPSO788i
 6iPpmfrbCkIaL4PGOfmX0FhBQNWs04zrSqyWGYGINXRsQIIA9WJl9EBw6aEW8/89P/PcwwmKD1L
 W4y9gwMgsMV35pPShseb6alGlMt+nefxFY891V6Zb7JRAASd3Zn8uTUAhp+gUznbD36O9FsTw3o
 GqHnIuqtPjGytPlidNX1Z1Tw+uCAA7lerdx7w6pjt9URVKrzI65ymXwkr9V99VzE5jr1/HUPT/8
 rgVLF
X-Google-Smtp-Source: AGHT+IEgPX1MwOVZumh0ValWi734ugv0aaCnO+/81MmqsmXV7UVo/TuISzkNTpLaWMTA8Wv/Rl7Bog==
X-Received: by 2002:a05:6830:4123:b0:72b:aa94:6d26 with SMTP id
 46e09a7af769-72c6382cd82mr10111530a34.18.1743539784092; 
 Tue, 01 Apr 2025 13:36:24 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c58266eb4sm1956027a34.51.2025.04.01.13.36.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 13:36:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250315012849.399336-1-trini@konsulko.com>
References: <20250315012849.399336-1-trini@konsulko.com>
Subject: Re: [PATCH] Kconfig: Do not "select OF_SEPARATE"
Message-Id: <174353978335.1112159.18252005850406737124.b4-ty@konsulko.com>
Date: Tue, 01 Apr 2025 14:36:23 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Fri, 14 Mar 2025 19:28:49 -0600, Tom Rini wrote:

> As the code is today, we get a warning about "select" statements on
> "choice" options not doing anything. In the case of OF_SEPARATE this is
> the default so we do not need to do anything here normally to enforce
> this.
> 
> 

Applied to u-boot/next, thanks!

[1/1] Kconfig: Do not "select OF_SEPARATE"
      commit: da20dfb2e901d499fe18c6302987432604e6f999
-- 
Tom


