Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92281CA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 12:26:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5A62040E04;
	Fri,  2 Oct 2026 12:26:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sp3NkfnVgssa; Fri,  2 Oct 2026 12:26:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 76DF040E23
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790944009;
	b=AiU8d6n+UDS5fKlRV+2JJ4lTAmQbEZSeofkQVLj9RwsFK7uFb/TzcmKdzFu5eK2IgL6D
	 YUpyT+4FiIne5dFNOwIzv+crQO+hfdPOd+km728yVhO8iDjdf13fYSiQf7MU5tMg8k7gl
	 +0fttyEodJ2fQs1I/BSVxQ3xT0SxMmcZAG7F4vAyN9qUmzdLzVTT9xVyby36B5nj7kIS/
	 RyropPV+9nOEPwr5kj1lF8NVTWTfoexgT49Del3EB3VEd6dSx/yEw63fpfzQRzR/CaowU
	 72EaopFa3WhHw+DriccJbGrSb8E8YGwudKS9NOYC35HIml9HKgbRtnwvXL09XkC9a2A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790944009;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TXGwmt6Iaqw+OlRXKUBQwDhyX+0shPt0wkkmsZTjElU=;
	b=LnVHB22Yo7xpK4MHiJKTRbQKGEMwmRH9N1dxwgJ4VhyKfppSXx8rUSSh5hbj4mCCvIX9
	 ZsiXiEWRbWQBMWmYchv6w6i09rgv3GSAToGVcUcktJPW7XpX5YoS8+CaMsPHRGYKfrC6i
	 O+tK3w5ksufu53ttfi+uVU0EmfTp8cnSqhU9NOros0DF5dQ/BEr1T3sgrfxFb0VVTDyf3
	 bZ/v9arW3++Djxz53nrKttQDSJ9CIsvlIz72jH2Gl7i8p2fZOGOfhyxi/RyV/Rz7iDww0
	 40csi/OfAh3tkREl0XRKHEPPLrpBPJ+sHKdM+PdZG9Dxi2/Ts22+ZCXWcfo7qMXAtSg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790944009;
	bh=TXGwmt6Iaqw+OlRXKUBQwDhyX+0shPt0wkkmsZTjElU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CxytQlChMfbYkLUhojPCgq9kS4mwcuDoASrBeG/se2N2aU4BAmof07SaMol67exB4
	 dA/GhSLmH1HjpXYSb7IC4xiUPIMu/X+N+xIfQNww8pMgJymfSEkfIU/+TEXEFY8PGs
	 10x3ku+C6TVhpvpbnww/mTjfBKlMEcHDYgFh6yUzZ+RvpYAU1pyDOPTLJjvtMzu6kc
	 1V06nii1IQeG9gsiPwcCS8+aaPcWT+dVGYocdq54Vw4Frqk3b6Az8cilYxPJPtD0rH
	 04B6YQvrEK7tu1Neu8heDqr9yvuzSie9mTy7+AMvCWsnz9QIZU4gE/N/eeuD0x4gSE
	 LCexhz2kq9V/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 76DF040E23;
	Fri,  2 Oct 2026 12:26:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D19A32A
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 07:34:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1AD0A6080A
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 07:34:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 66Nafk0ij23A for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 07:34:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 635E8607FF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790926484;
 b=goMyMR/WLWOQzdMnxcZnCVofWKr+/pQzA0FuR6OFZjH0xQc8OeEE1BuE4DlrvPg64or0
 YUUx0aG4xf8kBZjzFbOg7p7Mf4/CAm7V4a7in+7/OM2Xsv9nHoJlJEOeZgFbNRn8zKPIR
 wxeoZyVzPSuIFAx2VVbQ/ea5JBuOw+AV2pwCgl4av3pgVT/kojbjwX5ze1ugaxZrPsDT4
 9RRjHzMD2tDxpCjy45QLduW15tb3E+0NtBS/1GEL7jJGfZ6bNciNJmWmj5e0ZZ/5TRmkZ
 6qtA1jZMFPKL1TzIon+zOTaA1xYrM6z/oF7Q+1s+QDNN8r3uE2m4JTPPr8oJ6zvxqOg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790926484;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=TXGwmt6Iaqw+OlRXKUBQwDhyX+0shPt0wkkmsZTjElU=;
 b=Q9uTeXlJBes57tPduOJjzMK7s6iKxnMIDFqtsOdeG7Uc1LPb7URQIuvyAtU7OzbltP6f
 bgPef/AKkUh4Ct82OGeAqqUA8NIRZoHyDu7PIKonKc8pR+lpU19UWh2lt8m0ly+5smAJu
 2nYmViHrbJO+wJMiX7VKA8MAGn7Fg4h0R0ZvjqlxiLevDQGulSQCMmp1ErSq91GmnP27F
 VnKRy5ppc2Rjh02aMkJBfojTzL1YbeG+fpj415XZqDVWH8rqYiYfVeNsN+TR7oR+qWaXc
 LWRxDhFL6Iwum6I4FXucwjxeZE24tG6yQhDrhed6lQtz6UXjr5ubRBirxFUOqeByJbg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=izjGy9If; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=izjGy9If
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 635E8607FF
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 07:34:44 +0000 (UTC)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CCBFD44DF4
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 07:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1790926482;
 bh=TXGwmt6Iaqw+OlRXKUBQwDhyX+0shPt0wkkmsZTjElU=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=izjGy9IfYGqsZ6VexPc7gv2DrzifBtlCU00Ogso2ko6AHHWLOeHLi/u4xo9APZ+Jg
 5aW2A0e7twV9x0zLwE0H1C0pZ3G6vrHzMvF156nBeLwk262mXLL12xl4toBhROlqdb
 hvq8HvGSlPwAG4x+wjnRJhXPj4wUPqkpVqegjpSin8D4MhO0FbuwPsZ5I7A8Z0puzl
 plko5n2+Og5Vy75IItbem0xAFQb9YhqZJhaas+dWDgxxMeRsXFVwlLiyJWGtr1OKOH
 Rpd/l2B5KAnfW+AWwK7UFjNPqZm//2uCekNHUYNQPxcdM1vRrLJkav5IlKXX9r7YiC
 ovna0RO5Dq155Uk6fXd0BtStn+wHP2AUCAnY4Bj1jp+88SHA3+LVe53iv9FqX9cMlB
 yfp14vCT8muI4t+afVEf04szVfUxyYj7SRNnQBQIgfDJ19ZdOV+ERqBaUGXAdaxVzg
 3FNTdFbmfuAx3EdjoS5d7mlG0OLCfUV+xdOQmU1gt7NjrYyYzTPTadQZa9a5F92QIf
 lwNrZJnvFgfTOT21UtVlFqW6OEp5Rw2RzG4jOCRyLqQDxggW9cEXPuVHG41cbzXbdM
 6+00CaZGWDplvBur2Nvv61TpQLm5TU4HLl6hKJuTWOjmpvxJWbAqE9GTb/g6EeDWi5
 oO/mydI3DLK2tAlx93bdM9f0=
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3a4a053dcadso3971440a91.0
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 00:34:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790926481; x=1791531281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TXGwmt6Iaqw+OlRXKUBQwDhyX+0shPt0wkkmsZTjElU=;
 b=iOF9ES6TIbPxq+xqMrmEDwC1Gpwas8yxQKoF2HiE4+WaaLJTECf4WOKjR8npjnpTS4
 V1R/lrKvXPtqOt9QUDFA+oxHO9nR4K5vfCY5v53L9tSPIx4oowr6TZx/XpK4cli4Lh2S
 sqXy1SElEUaWx8/yCUc4EknxtYibfIvMQ1Haq9nCkKD4ITLFhbqLPUnhfuojrpjTwaFa
 cKUWNZnW5a1zUxApNInJ7ePUJ1duRVu7ATdJtmXnWugLyk5yvS5RwEBGcBp8WO5SsPi1
 Vu6aBec6CR9nuxCjSkguUzsVPS9oBpuWuyAeoMmJFC6kAU34L3fCi7FiX0+QcKNuW0KS
 QkAQ==
X-Gm-Message-State: AFq9FYJb0+90z5gnrGfufALzSoj2iBco/byqkd8psM0jXVsHd6+iJ//g
 YP19WKHmAoWXvvyW1Kb0ZLN9KkKM/WeOJMxbPX5UyCFpr8edXronPqiyCf1YQ/gY6VOSghVNi+B
 rZZW3+bffXuAjsBXs4NjFcNgijknTiTxxEQovmvpWIKYCx7oolKijOJaDfsWAQv3DRondd0h/k0
 PtFDTJfZF9bnVfGgKkOQ==
X-Gm-Gg: AYBFou0uv2WG3BOLydcHjnlBNyERstPOWbgyca7nVnhBhi0Sl5uuklPOhrcXTkYBUmv
 k6M4KsWx3/xcxWyVhKz9HExqzfGZ1gbB4bsdBFkpIqgWIYJ5QxdYeDhPCu4/Zp0XeWHVdG+2Dla
 rKHVhncRxEteHjQxaH9YMMCrH/pJPQSzV10PcNBvEnl3XfNtm76Rg5dx3Zn89K8IIwy0rYfF/T8
 djXGuDDt2iARo8R8jSQMAgncEXJlAji/AJxEH+MxI7pQSjo0DcAXCjHEqfpdYA0EHdcwrg2J3Cl
 rxXKbf6SIz7usAvs5XxAmZ6HN4UZduqtXVOw8CHzTWjncl8v/ixuAM1KP0Id7wTsllKUl5ynS7L
 7WxRz1CaUHuK0JJP6avZg8/EjxBaPzRubZdY5bYDK58lYQm5+H3o=
X-Received: by 2002:a17:90b:528d:b0:3a5:364:dfd with SMTP id
 98e67ed59e1d1-3a6cec5f39amr1789709a91.31.1790926481249; 
 Fri, 02 Oct 2026 00:34:41 -0700 (PDT)
X-Received: by 2002:a17:90b:528d:b0:3a5:364:dfd with SMTP id
 98e67ed59e1d1-3a6cec5f39amr1789702a91.31.1790926480845; 
 Fri, 02 Oct 2026 00:34:40 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a6cd44c2c9sm3172004a91.6.2026.10.02.00.34.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 00:34:40 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, Aristo Chen <aristo.chen@canonical.com>,
 Simon Glass <sjg@chromium.org>,
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Subject: [PATCH v1 6/6] test: video: define WHITE and SCROLL_LINES once at
 file scope
Date: Fri,  2 Oct 2026 07:31:56 +0000
Message-ID: <20261002073357.382228-7-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002073357.382228-1-aristo.chen@canonical.com>
References: <20261002073357.382228-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 02 Oct 2026 12:26:15 +0000
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

dm_test_video_text() and dm_test_video_text_12x22() each define WHITE
and SCROLL_LINES inside the function body. Macros are not scoped to a
function, so the second pair only redefines the first, and
check_vidconsole_output() further down uses the SCROLL_LINES defined
inside dm_test_video_text().

Define both once at file scope, before their first user, and drop the
two in-function pairs. No functional change.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 test/dm/video.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/test/dm/video.c b/test/dm/video.c
index 48ec60c4140..cc854d0e042 100644
--- a/test/dm/video.c
+++ b/test/dm/video.c
@@ -135,15 +135,15 @@ static int video_get_nologo(struct unit_test_state *uts, struct udevice **devp)
 	return 0;
 }
 
+#define WHITE		0xffff
+#define SCROLL_LINES	100
+
 /* Test text output works on the video console */
 static int dm_test_video_text(struct unit_test_state *uts)
 {
 	struct udevice *dev, *con;
 	int i;
 
-#define WHITE		0xffff
-#define SCROLL_LINES	100
-
 	ut_assertok(select_vidconsole(uts, "vidconsole0"));
 	ut_assertok(video_get_nologo(uts, &dev));
 	ut_assertok(uclass_get_device(UCLASS_VIDEO_CONSOLE, 0, &con));
@@ -183,9 +183,6 @@ static int dm_test_video_text_12x22(struct unit_test_state *uts)
 	struct udevice *dev, *con;
 	int i;
 
-#define WHITE		0xffff
-#define SCROLL_LINES	100
-
 	ut_assertok(select_vidconsole(uts, "vidconsole0"));
 	ut_assertok(video_get_nologo(uts, &dev));
 	ut_assertok(uclass_get_device(UCLASS_VIDEO_CONSOLE, 0, &con));
-- 
2.43.0

