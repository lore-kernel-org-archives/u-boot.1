Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D43ACA9EDE
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 14:01:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1BAC780DB9;
	Mon, 12 Oct 2026 14:01:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kLon-fVLhfXG; Mon, 12 Oct 2026 14:01:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 68BCE80DBB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813690;
	b=Y+2jqRXxAPXP/jxWowpj8J8TIqf8BIbf1culJJ7WDIfIX9yB9HddW2r+ZHKT+pUTqQxA
	 LL8v1saov5k3ROJE+GlaB1xUcZy24IYK71g8DIqtVIIJHg/B8qudcFzkjK7FVNERzbhsR
	 vkkKve/Grkv5TmgmgKsAIEgBi1EiK7cxw9MLzcfcWHpIc4p3o/UZppogC4KLYYR+Nzipa
	 LhYWoFsdohxEnCTr8g1bmDVZEFM9xO0YScc127X2jUaQwcBvT7oKq7yeK43AEa5d/tr9G
	 lwWzOfpGvN+dun7DqCBBFctAsfTOnEOKVYvhUeOIniSE+9f+kc2DH/cMM+zyn3hmt9g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791813690;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=tpfhScP6KRyDiOFsXGeU496N9s53GwsWPbixbH93AxM=;
	b=qJ79Y7oHQofM5sbWjq4NAOwU9wx7jf572x8J5tGfXWoTI10VUyKmWnUCTU8np8RegYMT
	 xlGjcA29EcmOJbFWpCOzjkAVh1dyrHXHq2DYJ8EnOjZv6SG491iRBZUO6Vo/DHqLBOelo
	 KHiWTa6BnlcwzEmWhz5NwFtUoNZMkbYqljgfSMljtftgdTy4P6DESlIOrff7ohjO8iPAY
	 VJXs4UaIbahh5Awgd6fCHlqx1VD835m/Wa5LSl7VrqGe2kvbR9LBrtUkYPmBFHOqhRhPC
	 vB0KzZiTwbrG4sfAjYq2wmduJPEqsn9meZX0hrQ3uOddoWSGxoeCJLypq2rRIaQee/Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791813690;
	bh=tpfhScP6KRyDiOFsXGeU496N9s53GwsWPbixbH93AxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JHaJ9OSJIE/4ibQiG3euVrQpyPGgKdYeiSbK0BoLsbPGBs4T/29d219UmO2jzr1nT
	 QHoHst9eGMIwq/YyrCY696GUFIhzMGDUPMZBhL4WrZ0U9EEUKlN7seu9id49si65Y2
	 iEKcxH55DFU4O/U6XxmrEX9wvqADdjMqjaE/uhz5dFKzLsJFE5M9vGHhspf4XLezt/
	 MqergIvN38twlMm2eft2lNULntayXtUZHaaPa30NaKUrKIkU0KmnwjHFqjRD+GG/5p
	 a6ZDdG+Kz4tItMjkqGjLc0uKyzmsXIEGLrTSVj3FKcE864lUC9sREPK6pqlrms0PXu
	 c1tT7bEh/U9Cw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 68BCE80DBB;
	Mon, 12 Oct 2026 14:01:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 165E5156
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0834C40627
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8WcRuboOGN60 for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 14:01:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3EE704062E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791813686;
 b=knAIL+kqAP6lbRcXBB40vOfmwTdEC+yoSn9CL4MpNQHU3riydxKlavJokg9ILl9+0UrE
 aF3/N8B8ATUV9RPS0tnYLf3YtNh8FAqf/dwDbWjaq5qtj9uwVSRZXXDBQyphfBjZsM14Q
 /Q8xnCfy8h61pYATB/oll2JGShGY0InAbpFZv1Fw3eVe+wdw/XnXsbUPjyKnHcgq3MZ4w
 JF1X1ueECORD/4PbpvIhlaZBix+Z3573F/huxIQQVG/VU6CzNkr8R5MjWub9BVcT7kjjk
 ba85CB3kLQ2lg/kk7emsFB6BiNlNzhytB3CNBt6qHE7ETO7CTaXRcm/OpObp3sotGGQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791813686;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=tpfhScP6KRyDiOFsXGeU496N9s53GwsWPbixbH93AxM=;
 b=EYJWZTi9R7ZQa7xp1ali0AXE0oxdgiOzi+OpuvZJlVgQSOC9ojvzBu7IC633H6xtaM9H
 3mTRkx0DjqQoJZVQOJmwS4Yshho36olvX6sGhN1UzOk6VZqst/uUv0OclFxBfktrI84kk
 lhUVsI9AZwTEY55n+DJlC8fVPYLjqw6WmW7PT8ly0COsPOncxLHDRJRvU9TOF5WPP7jhH
 IsN51xb78SUxuoJXnIqrbmDsr7HELhUbFyOJfLpWUGto4dP4vZ4HPhlBud41DSjaEu3NJ
 w0A1hq/L9eU6CVG60oP5OAprPkHg/bbf8ag8dtBBXCP0KJdeZtDHjwTyl1HM9Dh6bYg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=gl74HvX4; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=gl74HvX4
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3EE704062E
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:25 +0000 (UTC)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0DF1F3F223
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1791813684;
 bh=tpfhScP6KRyDiOFsXGeU496N9s53GwsWPbixbH93AxM=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=gl74HvX40DA+D+iYJWRx3eWK2eCSboMFV0IH/upKR2vArVVUBbchySjeIs6xZc3La
 Piy/pljxdiNd8rD1aBLjvhzFJBK/tXTBoAKMsf2pSX3We2VADA1YASGojt5NrUJHAU
 GvjfVns1if1L8gc6YkeNaZ+AQAUWNuDGhI/0fBDJKOyRYFhdKJ6bAoz6/KY8bASVbw
 uvikryT70P5Msezz4KmEZdSPxz75FAMMi21hJTBCiIpHvhTR6GpNj4sITz1WKh/CCw
 93Q9b0dDhoO3h5/exEw49C2w1pKoWDpQVwH0upvsgw8/r+q/1qzbVtARNJCMqkdD6p
 RyrG6zPH4CRRftWjBvrnUDqCnaMri4RZCM0/Sr4PEzStQY34TQKzmZIR9yF6iQ5YD/
 g14THU7jPhf2m/HlswfabaycJX68BduNkJICaG4I2osBHrxnpJkgBd4nlu1odbY/nJ
 quy3o5d28aE51vm5/4WJuug/SQONOz481VUAgCn+YDQtCP7k0PDV1gk+7hRUxfipFm
 oFn8RfuakoxGqsMDbFqTUTHqEB9Ws/5WMWbWR7vKwOZGWUffGkqM9DASoq5pkrY4oQ
 KJwVIoS3rx3gdKliVi6Wj46fmi2zvSfPBT7ERycZM8hyXNIs6X1oZrubsPAvNuMnz3
 0t3P9sqtokgypqoTjfhlzIFs=
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a170fa0879so14841635e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791813683; x=1792418483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tpfhScP6KRyDiOFsXGeU496N9s53GwsWPbixbH93AxM=;
 b=ViwsvyMVm3j2Eh72JbcXMMbh+JngfmpB99/Fq3xQgSMro7bngLOwpHo6P6Xk47PLcH
 H50xIMh1GWG5Ho/mIt6I9rPen1pT0+NKjvez408HlSDMUyj3qYVHgNGczLlJstSjnHLl
 ERBtDbnZ8JzYLDkygMG6SPiTJlNCaPflT1sddCWXVm4ravvg72ZiUsElHNWHwG+Dc6ny
 07jCawmIpq+rVoDPvBGhoQ5EZGemeoWRf3wPXHLqpYKPO9pR1J+Mwltm9nufO/AUdYcP
 2g+WcZOmJixBKaEVNt4HkULzjPoYFlRgwE+Sx1MgWItPoqjNVOBEn6SIg9n+sW3QOdTI
 GB5A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzmRkrSiz8bl3o7ooXJZqyBvX2mT1114fUvL1S+tZc6UEdJ77bUBoaNWMKKcDkYqg3dYqQjApI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJmSrLgs8g3uJy5wdgIEXyxT4bN/MNmqndopBNSphRVS30i/bQZ
 uxuRyYCUokhEHcdd/snKMaj+pvUSMkemQo9iHAjxvTiuBPU/zmSmnXlGR9nrKiISfSqLVPKI2F6
 8ZBUDyR7dfyNmRIO2V+TrXRvJHCy0J21D36vOd5C3/YJlY5iKEqvJ2vZWesG4lrTBx48X9rYnRc
 HnnNsXUXr+MQ==
X-Gm-Gg: AYBFou1wJG200jrCQX+GLxNOvMC14EbcGBAW+tL2r5WUfj6Ghoo7+IE3taPACKdkrSE
 F17ZKjqfzFlUqv3z5wQ3GnSkZ3vaWMCT/VPMgt0hlmmeCJqlzbKm1vkJKKJylavKJJMfwYmj23k
 2PQPjSZs2dqUJrnUcv7k7+/c6h3fmEQGMBPe3vGcmFHpaooUxO8Tl+jw2WHMxmjCY1yHMalwile
 +0KJ9FVofA4bOvlQVIkfn8t9OPac4RDy/p/QqZt5V2Pdte1JwTnYn1pIbdvf6eYb/zCVsfWTIZF
 7gBmO03Lzou2tm2Vn5dfXJVRzRC3A4y10eFtzERy6BSAdCZsWx3LLybxZ200BfNg6sRiv3g58ki
 X1oEdCxQP1Crn0c+gs+R2NqbghIwfCHAsGt3x2KEcFlWw3WV7UaahjsU=
X-Received: by 2002:a05:600c:8b6f:b0:4a0:25e9:bc47 with SMTP id
 5b1f17b1804b1-4a18e4ba6c2mr161382825e9.19.1791813683129; 
 Mon, 12 Oct 2026 07:01:23 -0700 (PDT)
X-Received: by 2002:a05:600c:8b6f:b0:4a0:25e9:bc47 with SMTP id
 5b1f17b1804b1-4a18e4ba6c2mr161381995e9.19.1791813682506; 
 Mon, 12 Oct 2026 07:01:22 -0700 (PDT)
Received: from workstation5 ([2a02:908:1242:30e0:468d:767c:32e6:22fa])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf15691sm284551015e9.6.2026.10.12.07.01.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 07:01:21 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Huang Jianan <jnhuang95@gmail.com>,
 Daniel Munic <v-dmunic@microsoft.com>, Tony Dinh <mibodhi@gmail.com>,
 Alexey Charkov <alchark@flipper.net>, Vincent Jardin <vjardin@free.fr>,
 joaomarcos.costa@bootlin.com, Aristo Chen <aristo.chen@canonical.com>,
 u-boot@lists.u-boot-project.org, linux-erofs@lists.ozlabs.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 7/9] test: fs: allow optional date field in ls output assertion
Date: Mon, 12 Oct 2026 16:00:46 +0200
Message-ID: <20261012140048.214059-8-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012140048.214059-1-heinrich.schuchardt@canonical.com>
References: <20261012140048.214059-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
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

fs_ls_generic() now prints a date between the file size and filename
when the filesystem sets FS_CAP_DATE (currently FAT and ext4).  The
two regex patterns in test_fs1 used ' *' (zero or more spaces) to
match whitespace between the size and filename; this no longer matches
when a date is present.

Change ' *' to ' .*' so the pattern matches both the old format
(size + spaces + name) and the new format (size + spaces + date + name).

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/py/tests/test_fs/test_basic.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/py/tests/test_fs/test_basic.py b/test/py/tests/test_fs/test_basic.py
index 88b163ce305..5f2af9e21d3 100644
--- a/test/py/tests/test_fs/test_basic.py
+++ b/test/py/tests/test_fs/test_basic.py
@@ -26,8 +26,8 @@ class TestFsBasic(object):
             output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 '%sls host 0:0' % fs_cmd_prefix])
-            assert(re.search('2621440000 *%s' % BIG_FILE, ''.join(output)))
-            assert(re.search('1048576 *%s' % SMALL_FILE, ''.join(output)))
+            assert(re.search('2621440000 .*%s' % BIG_FILE, ''.join(output)))
+            assert(re.search('1048576 .*%s' % SMALL_FILE, ''.join(output)))
 
         with ubman.log.section('Test Case 1b - ls (invalid dir)'):
             # In addition, test with a nonexistent directory to see if we crash.
-- 
2.55.0

