Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC83C88E6F
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 20:25:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EC6C340336;
	Mon, 14 Sep 2026 20:25:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VrFfEctfq0M7; Mon, 14 Sep 2026 20:25:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 52A6C4033B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789417530;
	b=sMsofxLhNzKGqlaOyTcrvuaVzOTuI3/DsZqS80946wUWD0dww16K2/CTwxKqX9nfUrsq
	 hFb4/gqG/4163Ypp2tbIoGkr1NJfwJb5UlftZYV37VPis7V01G7II4KhkLWg3mqfMLdME
	 0fUNARzTR5Psrjp/za3eunVniWXZ90WlY7gVDMZpwY7mKGrlivM/YUlFCa2qs8tlpO7nK
	 FrDtWNPpht6Cc8QbreE9AMhVjlGEIXmXwvQNq6fmgIwhHvrn4fv4bDuetbblAfq2Nhpp+
	 cV1xiUwqdV7woq8CMzw9Lj2OHXmqyLDWruEPcnMLBYk9oV8TS5ecElx/0FfQv87xIVQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789417530;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=zaszLSZfk+8PVsK1xfPmtu6qQc2Y+aSUiqq8dZQRLWY=;
	b=hqtaLLOUFB0UhK13Ceuca9w3GnxL9lWdLOeifZkFVejBJ0jJQAwSbtyDOSTeUw1/vMZM
	 jLBR06r96iBrq1Wa8hftHmtiatO7fjZ7zoYCiEfDUbdS3i1WeYeVDGKG5SEL3QnMdr4+d
	 6V+qtHWYBxZdv9WZzhNl1enPes0DscLz5TOVC6gaGYtuVkgyNVCNJxZILITJDgDHMU5rK
	 LKwric5E8KJSUJYAF3f0G2DOAyYOw9umUnqkjIiEXYJtkz2YlTv8lpEsl3OBPEHjrrt28
	 oMKQN8c31WcWKRjwbcEhtud5yIyslFvvwFI4tPSyN7Q/BLZhY5knktdcb/1XyxNIWsQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KpuJFrO7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789417530;
	bh=zaszLSZfk+8PVsK1xfPmtu6qQc2Y+aSUiqq8dZQRLWY=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ECjfu2qYZygLYTStQBMBJ5ZeGp4FjbyWlccPd3bTGGs4/wAFNVvmpHPRGSuLs7nke
	 cAoR0JYXT6wFWujl5tGBHHIVX/KTpmC4LU30qqafbaNUFWgAgvsKII5DI1Z9CFiR6x
	 uKl2eZJWCYXpSr9uLNO548PAdqSsazEg6hLV6PQtpQRDnorEj+uPHD/Fo26ZX978cU
	 ghhImKLq/mgNTKebDnc0l2T90SKpRzBV7fRi1gxcoGnAs1sQ3mSTgDYVTKNQBJRVAp
	 0qNzytNmU8SdvQwNlcnkY8lrfB4qxmq3kqPqeNdVvluGWSPvjwmvjIYo7LWDNwE7Vd
	 wtjNxsxOhRtvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 52A6C4033B;
	Mon, 14 Sep 2026 20:25:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 39EFC224
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:25:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 379394033B
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:25:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pWgkcq7F3OuR for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 20:25:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8D41C40336
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:41::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789417528;
 b=ig7RAVxcTFkkaCMIItT7hVzs1F+ZOYUHnOAjap4zJGI4EYx9dSoRZwkS9pjjq5nJq9Lt
 8rgK5Lyn2Qxru/w7tiRuBGxxM9nMMx1rthJWyFC4BV7UlZkeZ1ORYnPSAo7fq1OpENn39
 hTqIrH7fPOBRVY/SkvpYcF07UcBN9uBtLd/JBgk6x5T+6A42CgcSmMU0B21OOr0aF1JFs
 7YODpshbz4ly+oq6DxDoAGgiPKQyWPGmMjEL1S8XJIdD0fH/5+OsXOH5df8of3TBVSApL
 /rCiFliZWuB6o6hrICuIuLvB7o4XJ7vaKdklCB6VsWi3zGJekDf9JrpSETThhhiWNJA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789417528;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=zaszLSZfk+8PVsK1xfPmtu6qQc2Y+aSUiqq8dZQRLWY=;
 b=RomvDVhXOjRygrcbL8bc1i1HMMg+OjmuLkFgkgbcUpDhgDH/7NiVrZOgya9NmPtOntbH
 NjgJU1n03KkmdSEZufGYbOEcjOfz7DTVk4iA+L5xnKI3c2q9hrqfaQNndfDTj1welecCp
 KROf6t9sivRJNYE2BexOZa3COVmr2WT8mIQz3mkum4OitGaPH5sPfK2FegHa419Fw6/KL
 bHoWIJ/M+XEZu3B09jEynwoPq7JvSMPoLBWFcq16QLw+YYstmKlJGrcudov/+JcxSTGxw
 +D3krM1YRntv9f7jdhL3nPzZaHiPiWN1ZogIoRI1NieOU60gqx5WEwbwJ8wceXCxKQg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=KpuJFrO7; 
 arc=none smtp.remote-ip="2607:f8b0:4864:41::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::11; helo=mail-yx2-x11.google.com;
 envelope-from=mibodhi@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=KpuJFrO7
Received: from mail-yx2-x11.google.com (mail-yx2-x11.google.com
 [IPv6:2607:f8b0:4864:41::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8D41C40336
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:25:28 +0000 (UTC)
Received: by mail-yx2-x11.google.com with SMTP id
 956f58d0204a3-671563fb8beso119106d50.3
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 13:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789417527; x=1790022327;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zaszLSZfk+8PVsK1xfPmtu6qQc2Y+aSUiqq8dZQRLWY=;
 b=KpuJFrO7VnjRYaEfjgjoJSKFx7D4gcqWXVaf1Rxwcw7vX+RVA9KUDPaEYH4t2uFNAI
 7k+d6uTd5GHtTtxYU7k7pvFQcjqn++N/FdxEutlVqjs9uC+KKDUCeo3cP3VLl3DS97+d
 1cGp1cD3JTlvMmX3nH8mphbZsQvSKFHLcvD/AeE7/FFT3wwa+ijllNW3GB3cKjBkyl5/
 SlmAmll3mgBBtOhfba+OTnw9FUqGRBxzzJtITeg/ExIyF3FUfhYuDT89eNfW3beVShX6
 poTm+nOx2wdRTzXaN5XYzM+7lPB9tSiWKkBijxaWI5Ta/dyp/kYtivOFPlZ2jmZ+kLT4
 0kHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789417527; x=1790022327;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zaszLSZfk+8PVsK1xfPmtu6qQc2Y+aSUiqq8dZQRLWY=;
 b=nYX9f2bCKC7Hqmxn3Az/wqaw2oa/v2NpIoqyE9TklUS7zxzWmnlLO6PKEcQq8IhC+u
 0SMB+bTbpvPStTqgE4hHyFQNTRvM2tglRd+uLrSkRtY+BsIy3xZ4JEPveZaBZGB5bNt3
 G0YgmaIJ6dQzOQK7ZxK1TuwYW7Js6o8yf0AmVVGYezS3XyWFQk53mkCaqoVkkoDFPqjm
 mrqWx9JqNdkeiHNf0ZnYe7wX/1hG4KGhJbGBR8cRaQG1fVvIGBtHPlPR39hUJ4uLa8/D
 ML+jKpWmX2/BRxHEwkeKU4MuGMTgxvVZzfOh8VfA6GEvnr08XWx8OOUJ5MRXLcK4ULcc
 yV6A==
X-Gm-Message-State: AFuF++keHtp81bMMOLA1XmmCWH0Mk7xKqEMiKEIHw3XhVIo1EG4uPnMa
 AD6/axjNRJskdtfqItOO0TKNXVbKs1QXTMS+xB0gzXQotrUu8yyiRAsGGo9U4w==
X-Gm-Gg: AYBFou3mT5iwJR5Q1z3CBq4Hhp4ZUW255sANRhxDAL9Nm0v1vZMnetRpNK7tOTe2PzQ
 Hzt9MdjUXQnPqlOE4/7gOKvaPbEs6aaFeGyVS9jTWgnyUpghtw+SbHzNbJCe5h+YxI/+gK0QdBW
 B1SQwDN83z6pyYDuRqlUGz+sSdX0yQVsHoPJCyYdT+dt7IYoGLa6x2JsRi/75CGJoAm1HBmvKED
 U45er6eVrPeRfB7qUonZl8WIL8LCHyG/Dwy5NT5ujVVNqCKOxY9oD9RU57cLno0y1b4GEQ7x9qC
 auEQ4+wbwEptyj9lZ2+j5T19ceGrkRaQIVK5pWScBv/W+dslmK+JNRTtnPKYCrlygd3F/nSUcaQ
 DyE6raUctGMvhVkxN1kbOW7OxnL+Z1QUnMpjXOzH++wdUVWHRmqinFhFceFZDgT+uxMm4OmbnAi
 gT1QPd65rY4FS9MAnbB/8Qj0EkkszRIJYi5LgcZh6G/digs0S5TKc3MOiq3QPfzLAIFQVhLC8yO
 REZRmhWZ/N8Zp32R9a2O8rQ4BszTLbhj1xGIm1BFi3RWXhscolpt6x9IBLAgw==
X-Received: by 2002:a05:690e:2406:b0:66f:c1be:84c7 with SMTP id
 956f58d0204a3-6714e1c5281mr959637d50.53.1789417522121; 
 Mon, 14 Sep 2026 13:25:22 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-88486c2d167sm40454717b3.18.2026.09.14.13.25.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 13:25:21 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
Date: Mon, 14 Sep 2026 13:24:54 -0700
Subject: [PATCH] arm: kirkwood: remove obsolete configs for Zyxel NSA325 board
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-nsa325_configs-v1-1-d4089f3f5bff@gmail.com>
X-B4-Tracking: v=1; b=H4sIABVYqGoC/yXMQQqDMBBA0auEWRuIY1PRq0gRjZN0XCSSaYsg3
 t20Xb7F/wcIZSaBXh2Q6cPCKRbUlQL3nGIgzUsxoMG76eqbjjI1aEeXoucg2lq/dIgNtRahRFs
 mz/tvODz+lve8knt9L3CeF8kosm9yAAAA
X-Change-ID: 20260914-nsa325_configs-55fd9223e752
To: u-boot@lists.u-boot-project.org
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Tony Dinh <mibodhi@gmail.com>
X-Mailer: b4 0.16.0
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

Zyxel NSA325 board has been updated to bootstd, remove obsolete configs.

---
Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---
 configs/nsa325_defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/configs/nsa325_defconfig b/configs/nsa325_defconfig
index b496fb2797e..47a5179e71b 100644
--- a/configs/nsa325_defconfig
+++ b/configs/nsa325_defconfig
@@ -19,8 +19,6 @@ CONFIG_IDENT_STRING="\nZyXEL NSA325 2-Bay Power Media Server"
 CONFIG_PCI=y
 CONFIG_LTO=y
 CONFIG_BOOTSTD_FULL=y
-CONFIG_BOOTSTD_BOOTCOMMAND=y
-CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTSTAGE=y
 CONFIG_SHOW_BOOT_PROGRESS=y
 CONFIG_BOOTDELAY=10

---
base-commit: a44f46af0aa17e48572e0d46c0d082886ee353c3
change-id: 20260914-nsa325_configs-55fd9223e752

Best regards,
--  
Tony Dinh <mibodhi@gmail.com>

