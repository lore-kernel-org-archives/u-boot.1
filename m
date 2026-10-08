Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78112CA600B
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 08:37:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 552E8811E0;
	Thu,  8 Oct 2026 08:37:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sRqlTNq5ZPf9; Thu,  8 Oct 2026 08:37:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E8180811F4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791448669;
	b=YQStex2krNgLA2BHoMTccJlDdMkI9wEXgncFNV8E7EQhCNUuuoWGrxzHnX5MAE743yQF
	 KD3R6ps7WNLEOWQ++a4Z8bdLgMQTJcykGBVQJMC7Lk6ksa+zK++0BOTBY1cOzwfqRE17J
	 mJ3j7GXVvWu1l/11hPGViO9d9Gu7ppM3krSlaU6+i8pGX0DDYd+NurUg1qegMcJR9S2n6
	 PRK7pvLviE8fSV+0tkoCZk5BKcomj7C60YNrOhuXqi7plfSS7ayTVEnrECEgYeImBCzcQ
	 Iyro93OJBryM7qNAU71eTV0B4qd3w0eSx7Q3MMbXEEROVieXFpsSaCGT466VDOEZ6Rg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791448669;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vM1h42SaGwkmh/55o5juAZVJAzGKXuJoIEhK4UxkA84=;
	b=Ptxia92kQrVo0bi5WSEBvJaPKmhDOZ0n2+T8C51zqGMZiysOfaTV+CiG5SdJrjyiYTEk
	 JE3awBnMmuFVzAVz4nhaM+wtmKlAopaflrlXt4kbWwHPpPO79OeH3YJJV1IbxOraZu6oD
	 ya+2EgWcOktIn+UmUL6L8+IWzuVNan9osmqFEcTmaNUAK+XvWe5HxR2WWzQ528J9asZPF
	 idycQrU98oHW6kRujGGj7IQIUEGsoTjcNZ4jzF8da211pThsqvdtbNmggMuetBya1SWb1
	 +7RsnrDEk5HdsapOV2a4/3Bb5xwpku38UXfYD6+bHLZKdh5qx9+H6xdzyKUDYUfUtGQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791448669;
	bh=vM1h42SaGwkmh/55o5juAZVJAzGKXuJoIEhK4UxkA84=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=0uHB/90iHZXYrpJrnj1kDpC5P91hBL303uWOu/GgHH36qOMgmq7RAAVJWGChHboS8
	 Sju+jgiCSuiDNiZ4nqngSKWMcuSZrh4EU+skey4MCz2761+RphDpVew9d7FHg6PyAH
	 MD+oh4gWZvRa1Al5OtbflP/JCXv7kjakf+WTabQxu9uyjm6PzWhw1w2W6laRUJLpGn
	 vLAZ/TH37Tbgks6h7L1hwzCLUJwAlLyUP7YbVoioeuWVpv+gBrBMrZZXnGTDKjamtk
	 tXj6kHuJ8CGQttJkcOFEYSr+y3OHB/+p6PLu56HB6oQqBdJBYQEm9pdVRGXnmYQIH/
	 3cKcQOUJojIdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E8180811F4;
	Thu,  8 Oct 2026 08:37:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 19EA622B
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 07:01:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0B7014082D
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 07:01:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GQMO3l0WY_Zo for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 07:01:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3CA3140827
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791442904;
 b=j43SW0nVMLD18cBE4j2r+pnEESCqeHW1vw2NwBcrtE7xvA6oAQJhoZaipYJnUn+rz3hQ
 PjXTX4+NGv8okcfT0s39lvMpou9Gf2N7NyldkPzSSsgQEypO5OpFwcvLGQfZU0LJilrvd
 D/4BkXdhXtss+Zk3Bhjb+aKYC88kWo0sjTgzemrYCAUSySo1b+W3vq8KBbCzc25wgmYd1
 LNdNMxBNTbTwOxEHcGtwzKA8wClaPwtb+EsGmA7tWnZdUvMSO0MsMRs5E95Y5KEFJfbd3
 OkNUiX1wOzrFSfb7Cxsr+Bj3d+z1XusVE3AwUu71GvSUFKbe4n9uH5tSJEPBt1lN+QQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791442904;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:Content-Transfer-Encoding;
 bh=vM1h42SaGwkmh/55o5juAZVJAzGKXuJoIEhK4UxkA84=;
 b=NIHFNMhQezPKx1WYWTAud2P0ChM9QO9o8WcB7YQ0Z02ZYNI9BgWnAZbjdiP3hvWlZ5l1
 s+pb9UnQ3cH0iY6P6IVzC3HWXV+FSDOrpEHn/5G0S7tNoRY7QiuAH6UTla6SCRRR9S0R2
 fFDlF6AK+WeLkC15ia7MBJZKCLmSTHSLQ3gJiNgkAt5J1OmeudlnA1sX09qvCS5VO0Xe9
 drnwt+Se9C94zZD/w7Orj4R1KsOX4DdJG6+gv06fvPH/J0C8wmHvmqJizGUUn0fCPVzAC
 /3BdTV8av2xkpkD2PUqjXnEgGy9RkYMblZVNVQB59ZL8iXgPHFKtxs1zqsGY4FuXAyw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=DRXbkzXl; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=DRXbkzXl
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3CA3140827
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 07:01:42 +0000 (UTC)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3A9593F604
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 07:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1791442899;
 bh=vM1h42SaGwkmh/55o5juAZVJAzGKXuJoIEhK4UxkA84=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=DRXbkzXlbR8PnEmQDYf3RUXpeRWFS/a3zGh705ZeDjacoytmkBW3CK4UxfJzV5YDP
 meAOwo3JkyQQhtfixRkykWZ6Vyb1Rc9SFsHGsUzDpzCaRTzbW4zeQXUs5OQhoWUNSz
 fdNppZRn+O7sI3bFCWyxGbJSV0kDCMKpszdYBJVJQyT6El8LRk0OZwo1ZhPvPs8+yo
 ZYiXrxXHNsq/Og3WUdkVhu0mR9g80n6t9V1KhmlvPOwDBPe3ZTaK7AYQZ6d6Zz8BQH
 W/TKKgjhcd80AQUuQAK+/ilTSFEardyIlGSN2mnrjzgoYUM9ZF9d0icK4AcIPXmgFD
 eNsJE8ecCFfP108gBm5zp20HnnAHQI1HgeQ8Qlerd1ivP7YCiQRPagnEib4ckt5ydc
 xXXvPenfbROQ0814hXyMgb+8IE+YXu1f1eS/1om6KreTLdcejotQJ9L5ksYEJuDcZ7
 87hLqixMRYrumIFcW0C1aMEijbxfbh5Ur51IwheGHDU6mmNskWTloqwWH8jDaBJOKB
 TfG9PeQT1JAZQ825+0jt91gR9FDMeNW6TrXxjX200oANKz0iAJVyNvDJlflJPSsmmi
 5jAgt2JYcfUKgRbWJeFUjXEMGJtw6EzqkHvGQ52y0TEFgMrviWotAaWCGpcft5Q33m
 NzMgML4cIwBfx2inVXw+X664=
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cfa4e4684bso81638835ad.2
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 00:01:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791442898; x=1792047698;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vM1h42SaGwkmh/55o5juAZVJAzGKXuJoIEhK4UxkA84=;
 b=KjrrIFx2Voh42NXc6y6t/7qrV1yhwdVLnZ7BIAAbHVcQ92m7lY1juyuxUBi5r8g204
 VUk3PRvBFVsle7uuL2Cuonm//LMSqRHctJHDr1SfnWKHSgBMurlScIwGYb/1UM8Ok4YS
 dKCidDvmdA2ZmRriS4hjLB2s1M2yJ0ACBd4AUJthKwQfbnoQhS7Va2H2v+xb1v/SDxLp
 KXVHklnJWiNM5JQXxyJQo5A/I79aXW0572BPd09a4YbV+5SrVXB8ONEJ/4afyHkqKHI6
 UkUqeW6fPaMT93NMwcVaFeDQGcZHEYZLdAz2Y5EF/0VK8f6ajZEnMwR6ZAVbW/837Itw
 P93w==
X-Gm-Message-State: AFq9FYIcY1WGyJZvgr3O2JzMlP/jDDu/At6WNOUV1aOwjY8CY9wfBYbN
 VesfhnxrRb0u7Ksq3C2MjmluXcbzxmkbj6tkJMHDpUOBiL2mP6LLzhiMF5haY5djMjL/MiZKWgp
 o4iZDtXs8jlKXwq++SAJNp9z4+xGNhP6L2rf7F1ygo24hiA9qyyk9PD67SjQEYo5/iL1gsh+L7d
 2toSjlMBTx0cSbNpq0XQ==
X-Gm-Gg: AYBFou1aDCAIUxcBvbqiivG33w2Wro4ksEWvTxQY+BPGx+lduBeA+tB3o46iZS2DHIl
 B8r47LExA+5DZP+LBpYW7rX2jnM+6RoOJ4R5qvMw/tebrqihfeybV212dc8djc6ctxRByKLxfcK
 kEGbY+nmBSw8Szu0wulrvEh4E0SeFXdEDYb4z6ktwrL6IHlhRuHMMzPD8DkEpeBaDwDTktwdB0E
 +lTzma5seV96RZrxR73FXYW+6C5r8+ufsGBHH//0tG6nH/Jr1r3nlcD3TbzNst0DVUCZMOtke78
 CRipXeF37wHAWXmQoJ/Tz+HX9pldvqwfRKE9p4COOM8uy3WFC6gGZ4r2Oj2M76r7D4VyM7p4b21
 BfriXSGitWUO0olHt5WlZ4GSua9QfvliDDZEPXEmJ9923UYTsE7z6oyThlEIX6STFoQ==
X-Received: by 2002:a17:902:ccd0:b0:2e5:d33a:88ef with SMTP id
 d9443c01a7336-2e5ffc33d12mr41573045ad.12.1791442897586; 
 Thu, 08 Oct 2026 00:01:37 -0700 (PDT)
X-Received: by 2002:a17:902:ccd0:b0:2e5:d33a:88ef with SMTP id
 d9443c01a7336-2e5ffc33d12mr41572775ad.12.1791442897121; 
 Thu, 08 Oct 2026 00:01:37 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e6046fe0c1sm20245455ad.21.2026.10.08.00.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 00:01:36 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, quentin.schulz@cherry.de,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 0/2] fit: use constants for the cipher property names
Date: Thu,  8 Oct 2026 06:59:47 +0000
Message-ID: <20261008070116.328864-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 08 Oct 2026 08:37:42 +0000
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

The image-data series [1] added FIT_IV_HINT, FIT_IV_PROP and
FIT_DATA_SIZE_UNCIPHERED_PROP to include/image.h. It was on the list at
the same time as the series that converted the remaining FIT property
literals in mkimage, boot and SPL [2], which was written before these
constants existed, so the cipher code still spells the three names out.
This series converts them: patch 1 the iv-name-hint and iv properties,
patch 2 data-size-unciphered. The two patches touch different files and
do not depend on each other.

Patch 1 also uses FIT_IV_PROP for the iv property of the key node that
mkimage adds to the U-Boot device tree. That node is not part of the
FIT, but lib/rsa/rsa-sign.c already uses the FIT_* constants for the
properties of the key node it writes.

No functional change is intended. Built for sandbox and sandbox_spl
(U-Boot proper, SPL and host tools), the objects of all touched files
are identical before and after the series once debug info is stripped
and the embedded version string is held fixed. Each patch builds for
both boards, and the sandbox FIT, vboot, mkimage and dm-verity pytests,
the fit_cipher unit tests and the binman encrypted-FIT tests pass.

[1] https://lore.kernel.org/r/20260922123630.608961-1-aristo.chen@canonical.com
[2] https://lore.kernel.org/r/20260924055459.125648-1-aristo.chen@canonical.com

Aristo Chen (2):
  fit: use FIT_IV_PROP and FIT_IV_HINT for the iv properties
  fit: use FIT_DATA_SIZE_UNCIPHERED_PROP for data-size-unciphered

 boot/image-cipher.c   | 6 +++---
 boot/image-fit.c      | 2 +-
 lib/aes/aes-encrypt.c | 6 +++---
 tools/image-host.c    | 6 ++++--
 4 files changed, 11 insertions(+), 9 deletions(-)

-- 
2.43.0

