Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8889CCA462
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 06:56:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A94B812DB;
	Fri, 16 Oct 2026 06:56:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TAgawjurW1J7; Fri, 16 Oct 2026 06:56:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C2670812D2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792133769;
	b=IZ/h6F/6lqn0FXl4NFGjVG6f7dfnn5Zp56J+uCkF3GIiDTPVX2QqJrdBFE1lngiT4FVk
	 C82hBAsOOUDLZunQcq8Ua7PqrgHp0U1Vcb1MB+GjB8YckdOHACzQqehos+6DEqBa4GjxV
	 oZxogGfNS47QvK2zxuOjtkyjbOxt6lkCHnK3eo9rK7BLX7AhED8wDZuhOSvmF3uhpOGCg
	 GVoWW7IYHtRFb5niYLNdDYY/ycOuTT53F5ktFy2x9F608LqT644epKSI6B2qi2lqHy1So
	 WzOtTBiApQWuhJgfyjUVVBCJR8KmRywHlFAWQ2kdI99OkVcX4RiRXsaSPt3blWrdMOA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792133769;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=rAXJKpjUyyoYeu8U5nPHjfQ/w96M4ZdW28hIu9m9odQ=;
	b=Q/wAk3BUyurgnmb91Iak1B68vnb3mAg4WoTj/B9FNluGXf/ArNT1fsteZOh019F6DQY8
	 vZ5jFbn/H18tCp2WIdq8uvGh2FsRVZmFhSCeKJ3hWv2qZm3vb9vk9wT7Mi+x1fk4p7VdZ
	 FtvWwEnlxkMJIkNOUV2CF8/oRR3jbZyvvO99hFSPvwp9Z6fBiACSyZPvxIkVPovyUFZJU
	 btGbDq9Q8F1CtDIq3Fl3pL82/LHud2x5T76gtO2fAg2PVhFO/juf0LSUwKkcCEkxon73i
	 4IfeS5IXQ7nT0gZFWznCIkMEUl8daUKEXz7cxHkPujFUpbad9vjQCKwmUie1TWS8Ldw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792133769;
	bh=rAXJKpjUyyoYeu8U5nPHjfQ/w96M4ZdW28hIu9m9odQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ti2htJQAVjbLxS72QGOQ6qLJ0ziVCoMKJtGj+3QNlMO9ySqtAae9K6EA8TDdVZMMx
	 OpqW/DjIidajap8YXRhNmC96P80Jax/SwyR0Bw/O+3uXPdbJvTBSDlDQG9IWUwrxjP
	 Ok2Iw+k2AYFevnuCoPzA4r3+7u9pT3KH2Arj9zupAIqQW0ElVu1xQqwhQjJJ4wBLEZ
	 5LTMtUp7NbLC+DWVxo5La3J50oWK9P4fKT8/g7P1XBoLKduHaLJ7bcIBeOTOGE12r2
	 oKd4dw8O0Ha7M+pXfxfDAYol1YChHrKVTtbzBLJ9kNqD7ly4AX/Ez9Vjz7pF9kQawb
	 et45GSBYs6sDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C2670812D2;
	Fri, 16 Oct 2026 06:56:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 945A5105
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:56:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8665C6087B
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:56:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ufss6qPbcobI for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 06:56:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E08B860AAC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792133767;
 b=d6S0vP7XHw+OGDU6NS1dx5BwkBnJ0C5iGhXiFzTUvR5ssYtKAnQ+TP+UzCLpSL2bkFYy
 OVCPT9N/ErZIy3zCnYPow/62Q41pZTz7Ifm1ak/90zhB14uXF4B9ctTHuFH3+64XaHGWZ
 MuRCOV/ICtio7dhIoPU/KsJi2189wYDpPWzAvSDpM4kHFY1IPt+0yEgxOnfebgiglxftY
 9YrlrjDzPVkZJMoIRpeGu0JkWd4E/rvV/gPzIPM1gaxKhqI1UNhYLcHLvI1m3aaqKRGgt
 mlaw7t6Fo/pn3lTTDTBHEJOVJ0+4kWAj5pFmeq+0LibcrBZbV44R6Al9PvqhlNbR2PQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792133767;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=rAXJKpjUyyoYeu8U5nPHjfQ/w96M4ZdW28hIu9m9odQ=;
 b=qg7/IjsGTXHKqKmZWbc1RyGxs1h7rFOAXO4NYBnHjWn4RwCzv0aprKRgX5VJLfEx3cfk
 PW6liCA28isHFr54jqcc3yQPSjniGP3jdrH5dU3haRXgVqEni0EcYW9gFJhkxLOjPfLWB
 8r3LUnqLa5dBuy/RSKpcJ2lqTKyPlnKXg1Kr/fmNUMxYcVdEAn430d6KQw5SNBkdo0t8z
 zG0TpdJc80QNMKgsX7EPguwu6Zy0IOZYSeGUbUsWYsPVCJ6eE5Gn1WmHOui66nGLdEDVr
 KyUv+h7h0faFd9S0SWu6zOaz06RpB++Xk3uNUtKDBkicQBIqgr5//XyRcQ4uHmzK1RA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=eJf7lzxF; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=eJf7lzxF
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E08B860AAC
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:56:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792133761; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dO7nbaq/ilg3i+KOGdr1RhTQhIIOvJudu2Kc4hzOkus4M8t20c/m9WkOcsBXIZzfWvbpJ2bv4F209kubcchOneKXW2FIsa8YzY3lvsvoZivpqxluu0i16aHwNCC4KabsLmZ5NlbyqVM9XrBHwffP7pOnGNxlYmZyB9MCbkln/s4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792133761;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=rAXJKpjUyyoYeu8U5nPHjfQ/w96M4ZdW28hIu9m9odQ=; 
 b=MfS+DcSUySONOaBqJykukAS34sNITdjqSQEiKpIGmsL1Dg/GRJ/WLvWctdq6bscLa37k9F5UX7x/aXgTbAfS277tlpua0LESwd/B6XzkznBrMU9FeiSO40QN7ZKm4Q/+UOTeDIPVz5OZWzbFxwHphTFEu6Jsu2QfHS70g3wNr6g=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792133761; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=rAXJKpjUyyoYeu8U5nPHjfQ/w96M4ZdW28hIu9m9odQ=;
 b=eJf7lzxFKKix0R3PK8mMC/SMw8m9cmHto/jklBOYmlCGJwmoDZwNteI+F7dC4lPm
 g/DnpbYxj9QakC8rYsB2hKPOb899dBPhItRQY3ZgBHTmvf77s1Bk89AQF4hk+uwtQ7F
 5SCvgdXR3D7fyuTBEva2DWy9buXpzMrSF5PIPg0o=
Received: by smtp.zohomail.com with SMTPS id 1792133758041761.2877937389583;
 Thu, 15 Oct 2026 23:55:58 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 05/20] image: Define IH_ARCH_LOONGARCH
Date: Fri, 16 Oct 2026 06:54:45 +0000
Message-ID: <20261016065500.137544-6-me@ziyao.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016065500.137544-1-me@ziyao.cc>
References: <20261016065500.137544-1-me@ziyao.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Allocate the next value to IH_ARCH_LOONGARCH.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

No functional changes since v1
---
 boot/image.c    | 1 +
 include/image.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/boot/image.c b/boot/image.c
index 185d52ba492f..fddbf01e04f2 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -86,6 +86,7 @@ static const table_entry_t uimage_arch[] = {
 	{	IH_ARCH_X86_64,		"x86_64",	"AMD x86_64",	},
 	{	IH_ARCH_XTENSA,		"xtensa",	"Xtensa",	},
 	{	IH_ARCH_RISCV,		"riscv",	"RISC-V",	},
+	{	IH_ARCH_LOONGARCH,	"loongarch",	"LoongArch",	},
 	{	-1,			"",		"",		},
 };
 
diff --git a/include/image.h b/include/image.h
index 09cae96b2a8d..01fbb421db2f 100644
--- a/include/image.h
+++ b/include/image.h
@@ -139,6 +139,7 @@ enum {
 	IH_ARCH_X86_64,			/* AMD x86_64, Intel and Via */
 	IH_ARCH_XTENSA,			/* Xtensa	*/
 	IH_ARCH_RISCV,			/* RISC-V */
+	IH_ARCH_LOONGARCH,		/* Loongson LoongArch */
 
 	IH_ARCH_COUNT,
 };
-- 
2.55.0

