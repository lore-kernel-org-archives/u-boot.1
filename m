Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9AFC624D3
	for <u-boot@archiver.kernel.org>; Sat,  5 Sep 2026 13:02:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7C32C81166;
	Sat,  5 Sep 2026 13:02:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZhbAO22Ln_Fv; Sat,  5 Sep 2026 13:02:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AC4F2810D4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788613329;
	b=kPkSEldMvvHgi5Hf+bc7fnDTzYF9KKdyuienp1QYuqqHqVjB0m6SP73XzS/qCHy7ssek
	 MOYFHG3CQr8+nCabojb8Mi+yMbbU7g9nY1QqzUbFp+vA75ZdlhDazViveXb1cl0dUn5Zn
	 bFtN4RDQvRf4GiQo7SpbHyOQOV7AA7vEorJUmmTsiBzN5H7ipVUPyy8q4qbDm415REeKM
	 KtWDRi8U+REEKxuueLpo7y5coBgqYJLRFqFAsFDzDWv/ceFEb27dzj4ry/K/s41UV23Bk
	 KlT+ZrRd7iwOEx3+/MWy8a5VvCYiikxs7K9/hnrZ7cPnNWme9frDXnnP9N0gXH7jU6w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788613329;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FsZQQzM2UbIhyk5n00dV23EAI4LRBtTpTle09RWKnNU=;
	b=TmwAI7OHdUfMi83Z4e8k6+Hwe9s7MiQ4Vw05xEoEJvBcioeaqLGxN9f0D2G9mQVqngMv
	 abpEGCu35nqCFIyKMwA9MmsD3ZlryL8pJPxRGrnHx3ZKS932onqt+KTjfg6YwoeWbXT2E
	 b5sk8yqynnUc9OSOc8ysmyaOJyeBrDotgH2RFBUC2CMumgoFATZ3woo+pAKuBJ3PF7Z5X
	 mWGAw5ZE8ovjFfTlg/OXgyf2XcJRf/neZbgE9ibjN5+3olgveL5PkwAdgmmHIH3dYAAbI
	 h8vTzm93OJ9Np/hGU9sDIWntah1k2WiGZrUJeKC/YAlaSsRdRmTLtX9KQdB/vQWm6+g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788613329;
	bh=FsZQQzM2UbIhyk5n00dV23EAI4LRBtTpTle09RWKnNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sFooqVnu4WCMKHNpPWnnhKTY6a4eCdlPeX+FJL5WCpNVtXfLx2+19xjFBXtGcIitP
	 iiZJ2yIYuE4zBybJcWaYAnbrciuxxxGAmZVQg4RTMVmvJL18f02T6rmpekCb0AYWFP
	 GSzWfDVdUmibsbf7CTgCi6ZK/ulyySBy03BGyN1jbtxh/58r7qVs1BrixMMJaljGR7
	 Sq+4j8GuK2XmNTCY3k4iTXQgn+VXhjhfmKxAQmw7OjOIaM6wNhqNovXeqq2MGN3V+r
	 xfn+JhTXu7gVfK3RA8X8HXKQIeM+N7Uqt6+n5ZpkK0E4K8CSsOXySMgqOny3BqhPrB
	 xZlS89pXvO65A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC4F2810D4;
	Sat,  5 Sep 2026 13:02:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BF9602FC
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 10:24:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A5A8C40073
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 10:24:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3Asr7iq53fJT for <u-boot@lists.u-boot-project.org>;
 Sat,  5 Sep 2026 10:24:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org B28C340024
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788603897;
 b=MrIn4aTkSbx++PZ7Qvpk03sxjPvTh8HAsOwgCMumjXWaYWRceln3pzV6E9XW9cAju5z/
 jfB+rdNCXhRxn0oy9u7f+SwzcIUE9QJ48B5xjwvHLdYGaAw7gdAc7yORNf+qYnOm8aDqj
 tQwgsbpXuQ2ZEWay9yj4S/UI8TKcyhE4MG8/27N8ZfEkmaFvGHm0ulZnFIKWnRjb+nRYq
 K+RnhK11LQS59mY0ZXxahrmfcXUCJlWrzXgaAi2kTe/xtU2yPO1melLRP3gNJjKjtrC62
 5ABIFZEMXMqf8wh3JK1hdn1f0gdiznjCMfphRPmcYi2PrulVgOAo5mKMbSjpU23cNxw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788603897;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=FsZQQzM2UbIhyk5n00dV23EAI4LRBtTpTle09RWKnNU=;
 b=AqBZgMJ1WOoO1jfo6JO21GFHpQB0z4i68P58anRbfPfPnqu3m2YODj+ODHxdXGpUK7mM
 m4MwV9QBVguCl+ClLPVnr91WXe5urwMjgxkvMOQcdK/4icN8Fy6SLYmWvVy66Oq/nEG2x
 TX8IB5WxgH2nXgUcLY4QhqZcpBLhyp+axutJlfY7Vuv/japefzDVG6dvOWtqWarj1ooac
 y5kPZBft0Nt5nHFjME3gZ9AOp1YVix6jNtCm5aaObh6/cHa/xbT2PUEB3EQ3jGFwfGzov
 X3HNu2DEJM9CG46L/TRuD9sllrAwQZe81dHumN54mRzrSoMu+kWeLavcNg1wqGTZG0w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=IvEOQ5vT; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=joaofl@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=IvEOQ5vT
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B28C340024
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 10:24:56 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so21362445e9.1
 for <u-boot@lists.u-boot-project.org>; Sat, 05 Sep 2026 03:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788603894; x=1789208694;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FsZQQzM2UbIhyk5n00dV23EAI4LRBtTpTle09RWKnNU=;
 b=IvEOQ5vT80ME9M1Ssq70866Z1cwXHNO6vVWiN7ezVbIw0CiqPtFhlLI4UAlhr5nQh7
 AVhzv6TsmdzhzuE4m00cZhfZA6rFWBXmwL9lW6KdmQNo47/EEgidaplbbR7Vmo+38NKP
 m7KJvXpzDwNBCfjuRk1i5UBIlDHKdN1r6S60Kq184vC943UC/VkapypnkfokyIEliomJ
 ZBW4SSZJP9n+2RX1cLdU/elDY9YtbxB0r4zFpqEEkhzBIrWnwNhtyOVxzZz6B9GG+/kJ
 HQ+kyXpV2cNWHAN5hdiamCo0LR1y9wvHzALPRIGSxey1Q8WL1xWf5EHDZQcNKc73uGQs
 Gysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788603894; x=1789208694;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FsZQQzM2UbIhyk5n00dV23EAI4LRBtTpTle09RWKnNU=;
 b=TSYIrP2mRqkJjnOC12l1f0HCTmvVQ9BgM6MaX1gJNmm1N85ARgxeuCRa5ZUi+Aj5JR
 BRTQRa1sCJkNueSUohZaAN30LlqRC6QezCB0xg0d8SmVJXNrVz41vP8gyvvTYd5xKfyO
 BcxjTuv84LknRIfyn6i58cxl0mHE58P8NlbrwMXiz46pqWPrwvPP2i8O+F4Fw2Wi3QCx
 MbAkvv/8jB06byw4ijmpdhfzs2JicUcovFUUDmHf59zzeFyBZgVqpEPPdyUoXFBcqSvq
 0VN4Spkt/spj1Ge06P/bkNrVwIcMa3zHhhc/GagEwK5Byfcv/o92zX6Hoo9vAN7u84ta
 A7qA==
X-Gm-Message-State: AFuF++m13nmpOXlEuTnznQKeVGKFU4BefCzgJFAS2aEF6wHBpqxocGQi
 9QmMuFwKFaA1hK3n8PCEg9icu8yj5a86+WT3AfYUBrq0og9DEkGEMvFuLk3liA==
X-Gm-Gg: AYBFou3EX69d/wkN8Yxr+nEk1BWju4mMpS4FYsFuVoxuKucFfKh/XkZu07AJXFGAAzd
 UzNPObSL0P3hstquziadNEiBEDfIPeDXbTLTxzxtl9d/tGrUztVW/Gl/3Z9PRD6DWZz6NqqP2XJ
 aNVPMs45sTGaenuL9XQitjPl2qty45Dh6nXQyorN3BfzPeICyARC7RX95bgNeizOs/XoZG4LXKf
 Z2rqHd8hdfljs37kaqB9+wfi0F9peFsSNDpFZjTkChpIqbtCSg+QNWEaoaKL1U3BCsQ1IQxVR16
 BEJZzLQUHR0MNSsESwxFN8sjtZwPKnWGxvqBYs0b7E7ydhTjaiICIeFLP+mziItTN8vBYLrFATE
 P2tNtPtPgt9D2MCRL2c2VwfpXnp6RtP9Hf1EeregUL9irr7g38Z/CMLEg/QLNrNzbjvliuYvzQs
 EjIAakLGwgeOb2bggIMD5YfiBvPDtorKSv+vnCA4WuZzIYTVzAXre/XGJUjpW427rqdVQYIP7Wq
 RfHhdYzX09IXH4kYgSR3+AlNixOdVxK7uf7vDKVhgP7omuE+2ryWqUN6kxftSpnPZ8P5koRWBHh
 BofZxZk=
X-Received: by 2002:a05:600d:849b:20b0:499:900c:9c69 with SMTP id
 5b1f17b1804b1-49cf825d8c0mr89244195e9.9.1788603893976; 
 Sat, 05 Sep 2026 03:24:53 -0700 (PDT)
Received: from lap.lan (xcpe-178-82-236-193.dyn.res.sunrise.net.
 [178.82.236.193]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf772692dsm164424635e9.10.2026.09.05.03.24.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 03:24:53 -0700 (PDT)
From: =?UTF-8?q?Jo=C3=A3o=20Loureiro?= <joaofl@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Jo=C3=A3o=20Loureiro?= <joaofl@gmail.com>
Subject: [PATCH v5 1/3] test: dm: sf: Get the emulator attached to the flash
 slave
Date: Sat,  5 Sep 2026 12:24:29 +0200
Message-ID: <20260905102431.426747-2-joaofl@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260615175118.53720-1-joaofl@gmail.com>
References: <20260615175118.53720-1-joaofl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 05 Sep 2026 13:02:04 +0000
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

dm_test_spi_flash() picks up its SPI emulator with
uclass_first_device_err(UCLASS_SPI_EMUL), which assumes the sandbox SPI
flash emulator is the only device in that uclass. That holds today only
because the flash emulator is bound lazily, on the first transfer.

As soon as a second SPI emulator is described in the device tree it is
bound during the devicetree scan and so comes first in the uclass. The
test then hands a foreign device to sandbox_sf_set_block_protect(),
which casts its private data to struct sandbox_spi_flash and writes
past the end of it, corrupting the heap.

Ask for the emulator attached to this particular slave instead, which
is what the test means, and which stays correct however many SPI
emulators exist.

Signed-off-by: João Loureiro <joaofl@gmail.com>
---
 test/dm/sf.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/test/dm/sf.c b/test/dm/sf.c
index 3684d021709..0ec02ac694b 100644
--- a/test/dm/sf.c
+++ b/test/dm/sf.c
@@ -50,8 +50,13 @@ static int dm_test_spi_flash(struct unit_test_state *uts)
 	ut_assertok(spi_flash_read_dm(dev, 0, size, dst));
 	ut_asserteq_mem(src, dst, size);
 
-	/* Try the write-protect stuff */
-	ut_assertok(uclass_first_device_err(UCLASS_SPI_EMUL, &emul));
+	/*
+	 * Try the write-protect stuff. Ask for the emulator attached to this
+	 * particular slave rather than the first one in the uclass, since
+	 * other SPI emulators may be present.
+	 */
+	ut_assertok(sandbox_spi_get_emul(state_get_current(), dev->parent, dev,
+					 &emul));
 	ut_asserteq(0, spl_flash_get_sw_write_prot(dev));
 	sandbox_sf_set_block_protect(emul, 1);
 	ut_asserteq(1, spl_flash_get_sw_write_prot(dev));
-- 
2.55.0

