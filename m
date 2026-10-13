Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2658CC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 07:43:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D48E660765;
	Tue, 13 Oct 2026 07:43:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id byBeoRzOUSUE; Tue, 13 Oct 2026 07:43:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org ADAC960729
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791877420;
	b=rJ0rmYlDa5yJYV+CbIf//1LWIcA6Tg3vgtcWrSNQGRPnJSw09ZKUiG1ltHEPKJH2Gj/g
	 +ebLHeT09kSQ/z9A5m1U7taNTNhKUopFdI6RN3CiDAaA6Cv0PFxBx/yEHiC1ml/I9WaUI
	 luHg0IXJTDaUR7uh4aZ3v/B3Y3u/1/EDqk8u+8Ghj8ovqpgg+KTZ+j1/ytrTOrYTDN/bc
	 mBch2PMQuZMCk5qYjg+s54hDAwpN3gqGUecEKs4u2KZmPKq62JlRZxaSNCRteWrfTMmfu
	 XnzWbo8OZocrnPlenDzV0m2J4EskHsIY1yWJX/WgJUp5EFId4fnKKRB3GYoNMuRvfsQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791877420;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=x1FbnFIvpVO0vF+Uw16DuO299gEqJWsoN5SpU9KN/BQ=;
	b=ZnqGCVMAdkvr81ZQsbJo9I74VZ5iLHWHQCk6UDlCpbPXjdF95cMZEFosNu/8s37DWzZA
	 iviHhUhky6MiinaxCJ8yU+Ezb9fOtIDzejY93ob7D9E6Ly5MZ7j5SN5qnshQrD71GzjSY
	 0ng0SUQwk04JBNilIa3rbnrc5I+F4zP19QmJagXWjhpJrrNheFNrKHgZyokC9zFxIlw2J
	 rC1uD3L/k8ukfM6kRQwtbspkaJmiXcgjvCwpTSlHxFuvX4ljJA9m9JzVggAKImnVkuEo3
	 U1lOgsSCdxpuSVkBgKVyA927BWWc/cG1sl8Tx8CqEO6ucetsJfLtgH1FaGLRhVuHOjA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oLNlFwqP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791877420;
	bh=x1FbnFIvpVO0vF+Uw16DuO299gEqJWsoN5SpU9KN/BQ=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=TathdfqzOSLUsx19o5LFEplmKq18hE8IeVeSVckiJ2qGTiNYjZx/WhSiCKazhy+r/
	 c5m1r1pMT4Wdg02bV+RmWnFN+iBAne6y89HMjMDonGH4KTem9+dijE51dTl7txbEEK
	 DBuuOgFZZIKR1FsB4BPLEpziQvY2xx8YaRkDzyXFuIqA3aFVor5a9aW8MdoZwM1vkz
	 DOK1qxbH1D2RWq/RaCA3aC42tC6bBrKupAz617PMq+oboxcKloqC57ntLJxKojFQmn
	 EyPyXGBuQ7A5sfuenVVAM6ItgvZ9gQewseP3g4EtDn1jl/5m6PNgBO7ZDoRj7i2bDE
	 xBpV2UtJhYY4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id ADAC960729;
	Tue, 13 Oct 2026 07:43:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 563F7129B
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 07:43:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3733660751
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 07:43:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A7ugsrznsdqU for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 07:43:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6DBBE606E1
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791877408;
 b=BL2wbYJZmdFlYQFd65inzGDVem+BYcq/YJ5wWAUwfYbQV9pqFHLq2AVO15l0GeiXet5T
 kzlBYf471evbBoOVFz8k3BpekxC91hPUHmvhoJh8n7Hg+nwBcEZe6vzWvzC1b9HvAXjeQ
 JphLL7UyPvsM/Sxd1+zdO1NyXRqai43Drpp0ORtDASlx5TCFWcrFmF/zByqRqIWDsBsZf
 +3d8kmNCaE6UTFrqNYYe/pHaSly/pUFkuqelVXEFDbQqwDl5XHPC0UVa4rVCYjbBx5og+
 LhoqxT/FVWnm/iQLS651iMLg6ITOMxNmxTMLKwGDicxLzA207pGAf8BeaDZs0tsvVrw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791877408;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=x1FbnFIvpVO0vF+Uw16DuO299gEqJWsoN5SpU9KN/BQ=;
 b=T3xVCUXMqOv9sQETYbxQ2dsiHp2DwAFSXRScsrE+6QIxD3Z9zijHTyTuFS/QV22Td6Cq
 lJqf/tfYMokTohVaUFnJ9w0YzOEgnOchH45dgvSCYaJ1C/OJwkmLfVkKRJkNPvCMA3oXi
 VKTsleSg5g8aguy9kEBRl8e+hCCgGCE3S03GRkh+zKDHd+v0S7fp8ns4TzgYfFHC4RuEF
 vHaboBq5+XASRYT9aMmjJEMV7aM+bjWHvX/RYrU+0IobzKgHddlmO37h8EX7UypzftkUw
 F1Eip0O5DSJMxcRymSIxlyy2SlOZKlKGbocdQc01RyD5ukdFFFkLODBftWc90k7a05A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=oLNlFwqP; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=oLNlFwqP
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6DBBE606E1
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 07:43:27 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49ff680331aso21160755e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 00:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791877406; x=1792482206;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=x1FbnFIvpVO0vF+Uw16DuO299gEqJWsoN5SpU9KN/BQ=;
 b=oLNlFwqPBhdxs0H5YgtW7nT1bTuzSxKH9aCEn8fGU56okK9h/IoMWcAeOCeJpVE4RD
 uD8OSbzFx0UB0u5XYJIhkUKKTiNPaZk2KIGRknk5LXIlOSpV2gy0lzOkzsxcdPzq1zSn
 Ssr87uJoUcHy2Wc19yIpiI1aUh+lDHX+we3itP5c6QxQ8ILEk9IMmCpaD5rQ8Wubq/11
 5+XefBRm2YFyt/jkkXyhw8fnl/yGULrD+ko1AWvQWggiRjutwpdaCNCGXpUflz8hYehr
 43G4BzMDa2RW8CECaDIsoHXJEV5HpCDxvCyDfZ57l7sXOs0h0GfmXPIUooraZ4+g0CYY
 MdYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791877406; x=1792482206;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x1FbnFIvpVO0vF+Uw16DuO299gEqJWsoN5SpU9KN/BQ=;
 b=BsRd3sVrn2rgtqPCfGAMJiRJENp7YxnTCvld6RoJsIP/o8Z8qJDpFH/1XLh7baGvQM
 gkKnLfXQPMOE1VXlByZW1UCUbIabW45CWzM2rLIFNbK4eNmZZemyVvSr4/3xvQnmkNLp
 x17heeNQ5w6zjRioob5Ddg1fV9kFkpvN+uxXLzmMUgYgI9dsBwq1tnL0p0L9uX+n9KCW
 Uj9HYSV3BMB4RABlo33A6hbNUBmc6Bh9lPOqbeDE7F6I6LlQoCXhUBeEgJTRAB015Cu+
 XMFUIXULQZdCfbM48bubAW9ii2a5z2f0dBwxg5/u5A2/fKMgxErIlUn5hCSZubgzYfAj
 9Vvw==
X-Gm-Message-State: AFq9FYJV9YOEbunXEPqpyHDN93ky0wl1MR8lPGTRpNkV/oroi6USgRgl
 jVwCOZfjguB9mtK7vDwViutT/PJZRT6RKvF8IlBh8gzE55PCIfkeVzzx1d56mkTG
X-Gm-Gg: AYBFou1PrRDM3Mu6BDggdH5ryhjaoUKHq89VAPaEEK6nrsf2xPhrv7fYm8fc9Ss0AHP
 mhrW+pHKa5w7APXx3AuK0p4F5F8iSV5p3sciEbrUFL/93hYEuNWdwpPYg/PlDjdVjsEkWJXcXV+
 Po4iXP6kGStKfdOroEZnTjZAmeRbMfuPc6ROb7YBnNvylT/58kzTPvFInZLGTVZhLlnYT36QRHN
 UE+eZOAxBy0bDebAfk6K08sk0Fd7TqXmYVqs3aNiv26xnO8yNcxLthUBWEitPewqulzdTAFkvDC
 blFab7WoMZXqARs7Pw9w99uc/9Iigo45mbae30MoCcXzz8VnWX6vdGqtMcg3J3ES3pscg7ualjk
 sHRdnZIRUQAARQdoDWmRJYJFs4zY3XySsxByNUqzRocA4VQSrvmKFu9yHXvIV8m7B+BFUheZH92
 Kt4KW9ev8cKotiEyBgHfrFT13VPfto1X9zHCTyHiqt8t7fVt+cgqQVyTlv6PfPhcvQv/7QcRAxS
 w6M6kvM3yIMghlWWfHoLarvcdun3dZhyUQjjZ8ugQXW0L7FnIC6KCKHSUH+la2ECVJGv66zWzd7
 ljJHpEdYxpy+n1Wylqfd7HuGeDjp1bHBq3R4a1jjJ85BpOlg/KYx297a9dq3F796zSNnwTy7teZ
 8rrNddwZu2tHbt+Y7mxz1/NxrILRoLSEt47yfTQrT
X-Received: by 2002:a05:600c:c16f:b0:49f:cbf1:e765 with SMTP id
 5b1f17b1804b1-4a18e3ef314mr212446995e9.0.1791877405576; 
 Tue, 13 Oct 2026 00:43:25 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a00-1028-c000-0ddf-303e-2074-f3ca-cf21.ipv6.o2.cz.
 [2a00:1028:c000:ddf:303e:2074:f3ca:cf21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a19f249692sm274369605e9.3.2026.10.13.00.43.24
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Oct 2026 00:43:25 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Subject: [PATCH 0/2] arm: Make the LTO conditions in arch/arm/config.mk take
 effect
Date: Tue, 13 Oct 2026 09:43:20 +0200
Message-ID: <cover.1791877299.git.pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

As requested in the review of the mpc85xx LTO series [1], this sets
LTO_ENABLE before the top Makefile reads arch/arm/config.mk, so that
U-Boot proper of the ARM LTO boards is no longer built with
-ffunction-sections -fdata-sections.

The first patch keeps --gc-sections, which the same change would
otherwise drop for LTO with the private libgcc, making most of these
images larger.

[1] https://lore.kernel.org/u-boot/20261012190720.GF3722450@bill-the-cat/

Josef Schlehofer (2):
  arm: Keep --gc-sections with LTO
  Makefile: Set LTO_ENABLE before including config.mk

 Makefile           | 14 +++++++-------
 arch/arm/config.mk |  2 --
 2 files changed, 7 insertions(+), 9 deletions(-)


base-commit: 5e3b01c8466dbe45cd6a06299f8f4c7e8c1c2363
-- 
2.54.0 (Apple Git-157)

