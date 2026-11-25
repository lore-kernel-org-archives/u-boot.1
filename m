Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AC6606A323
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 12:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EJMAeKfL;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YMY1GQ+5
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 519E56088F;
	Wed, 25 Nov 2026 12:20:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SBmwZVMFM8hM; Wed, 25 Nov 2026 12:20:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9611B607D2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795609252;
	b=IGBX710w7W+YULec0q2Vi0ubUxL2t6cgJ33svWGPnsCEFn2jhFFxKMOy494ez/nZkUQ+
	 1jEkHmvT6BoGyVWHMqbtr8GRZ1/OlQgQcKSo7OeqYA41y1hmqpksqxrjNdr8+Ebaf0eqN
	 1a8kjCFDPCc/1us5ITQKjp6PmzSogMDTYCmwMUncDw+Avn9wlS5MQQm/ypRzNP0uCOnOd
	 MvEeRC+n1pLQFgxmQNIACKSeB58jXs1gpIQt5ksyeMvEHdWaRgbG24Lv/UtppX7IEH3/j
	 AM2qlwduJfEmIYjbfjHRD8G8+xfUmbvQKRJ7XMaCeMlxhKi7ms9iOw3emsreMB892Ng==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795609252;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=3ua2x7OyOUevvccG4TIT+p2TWCD9JgZT4ZOFju4uS6c=;
	b=H9MwpnZ8Gp+YAN31S3m+hAJzjHLp4Ss37oqtXVMzpeTNWltD7N8j/kL9yzwdniRtFKkq
	 N+RT2OqPWS8CYRZI/g4ZCR+SVs9wEcCscjKn1EXjVkZNfoMLHbRFlQjtKGhY5Sf9uxSjo
	 m9lTzyR9t8MCZqxwf9LORz3iklQ4VUIVa87tdGiSyQnETyFsw/s1LCdhAyax8Qh75hl+p
	 BIZaFggqQelziCe7i3xTUVbriF5dph64fqCj1svoWfsRN9HxjG9MjgwzrGxQYeQRTLjF1
	 P0WnHNRCOnI8ivWchiO+i8q6m3yRL9jHdhb8Mpy2nuh37OB5SK75J9ywgsjPgJ8QRNg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795609252;
	bh=3ua2x7OyOUevvccG4TIT+p2TWCD9JgZT4ZOFju4uS6c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EJMAeKfLuUtJTPz3FYequA57izARO25I3D/SpHb9MxP+ZH6sAZIG6tilTsxENfm9W
	 nNj1D3REROO+ZDl2Eg/BHQRvbfXbk6Nr1gQi6mamowD4UPKu39xAoCAOKMjkN92Gef
	 AXjvB9Iy4kq8RJ6W1np8hsOQ4RTZm0xZNZZibzooPkjOFv7UyiaTMwCWEEdfz0yasp
	 n/FMz8df+iC8cEIpdTr4BV9FlhyW0khG9cDIlDt2l7+jQ3XH82R6v2/BcdNXmq+eeC
	 tNgkfx/smMiIt7F1ThcTibm4c28ZNC3fyWkJIcuFm59GjchinyniMM2/hWCMqRNABD
	 pqL7Mx+xjjKhg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9611B607D2;
	Wed, 25 Nov 2026 12:20:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1A35E22B
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 12:20:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0ADC780E3A
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 12:20:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dn1q10J85zmP for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 12:20:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 483F380CB0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e2e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e2e; helo=mail-vs1-xe2e.google.com;
 envelope-from=jpaulo.silvagoncalves@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=YMY1GQ+5
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com
 [IPv6:2607:f8b0:4864:20::e2e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 483F380CB0
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 12:20:49 +0000 (UTC)
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-7d2dc1ac787so1813977137.2
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 04:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795609249; x=1796214049;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3ua2x7OyOUevvccG4TIT+p2TWCD9JgZT4ZOFju4uS6c=;
 b=YMY1GQ+5OZVoFrPLwLOyyylTZI9cmCxUhuzPG2ZkX3nXb9ULRpnvvy4xAJvC5OK++4
 bL/4UskvGeCAsv0zeXD52g74zr7rOylwX6a+0Gndoa1nd3L7SxRvyDtaVshudXd5esqK
 qX2eiRJBGDBihAeGB4GS834sPSPOGEljasABt0peVdpn0j/kZrfbwXENkCPXvY7seHZ/
 mXlObYvaJNYcc/l85sEnTCHXoNqusZf8pJY8kmZgXFCPjpUq76XrxNjHnJd8JA1NOP+B
 oJ1UorXceeYV1F64lguyQhud4XEndh4nqh2DrsjBTZ4/eGqC1lkKbrLySm9PFUqMBdea
 Sbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795609249; x=1796214049;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3ua2x7OyOUevvccG4TIT+p2TWCD9JgZT4ZOFju4uS6c=;
 b=p+z5vAZfRtSTS+pPT1UoTSeUCmAOxp70WK2iho0ljIRUONzZjBxMQiydXN2AeuTebp
 w/h9Gj9uHi90jy2l3w8sDNv6qcF8BFQGIsCktKvz/185r7zakNbJFTYaV3NPR6Ibylzy
 VfgJebqTN/HYWId1OB8xXMAHyfjjTMbcJv5mR0aJYAZ7SAH3eDFQ/G4Yfuo1hOjk8VXq
 GDFuuD9KdszYW77QRGGjictmC7qvpVvq0LY8c8+YRWaCUNUx8VNhSV9VdwgMeJsahkkP
 2ZaZr4WtkVSeTo4sy2mnsTsE2YbSnn8UgzBYqXOwdSbbX1GnuKX2bnPDnwEhwsuSPmrm
 /THw==
X-Gm-Message-State: APuU4Z8Jn/paRf4OU0/WjOdyEyfEKNII5sSVbLkP1ryHdqHdyLFt8EaQ
 TFJ3w0J//jH4hcFYvlXwbUpsYghZYw65bW543JLlY3mpDQST57kPUvAl
X-Gm-Gg: AZFdTZce6VlvETFQPU5gGlqiHlcsVY4d0lgNKMRxUBP1B8kKwKUpL5fmVz4I952C4fb
 cEilK4wgOiWVnXOkkxqLCMM6NcujSpmOVObopTAXSacpyNwhGWHGDglpmehnvUkVXg1GRCXLU9L
 j5R9ic0f/wAz79Ulo6+OkYsoNHepjfs0MctTwYS/BbnuXpTEvt3JH21uIXREUojgxuEMwwuUD8C
 Tu7HrHIMyHdlGQXnNdW/OsPlf0f0Qb7g/Ln97W/jZBOooo0id/UUIn01Gjxp0EVYN27hm9sU0ZZ
 6D1auXs43ewdduYZ/H3DTwqJq8P8mSCVITBqqbM2cNovZHFkkABkvoPeLaNduqIUIMGuSbi4CnH
 nzNOvoe/owzEVss1VfZ1nj15Jmude4NPj+JrCgQI7EQ8LJBJtomvTLTrTmWfbOgd0lvSRZwxh7h
 FmjY1kea4VD2uCzE277weepQX1nnLs04poFwBeRW2vh2+Mj889adNEiFx0vkvD6JX4l5dcOlNR1
 VAVMTfbvFChQJYiJrnXzinn5htTi7WbNwMNiNpd+wfiWT8TGIWVrVDYn9MRgxM5i6ie7cKpYSIe
 B/xoXCDucTk8w3nLbCvQKXls6KJU+YCsK7JwUuZbEfmUNw==
X-Received: by 2002:a05:6102:a54:b0:7cc:2daa:90ee with SMTP id
 ada2fe7eead31-7d7393dd1b6mr8960640137.15.1795609248647; 
 Wed, 25 Nov 2026 04:20:48 -0800 (PST)
Received: from [127.0.1.1] ([2804:14c:490:135b:b225:aaff:fe93:9186])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-99e6dec7cb5sm18636534241.2.2026.11.25.04.20.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 04:20:48 -0800 (PST)
From: =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>
Date: Wed, 25 Nov 2026 09:20:28 -0300
Subject: [PATCH v3 1/3] clk: sophgo: cv1800b: Add SG2000 compatible string
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261125-upstream-v1-milk-duo-s-v3-1-9ed94b63cbbe@gmail.com>
References: <20261125-upstream-v1-milk-duo-s-v3-0-9ed94b63cbbe@gmail.com>
In-Reply-To: <20261125-upstream-v1-milk-duo-s-v3-0-9ed94b63cbbe@gmail.com>
To: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Gui-Dong Han <hanguidong02@gmail.com>, Joshua Milas <josh.milas@gmail.com>, 
 Chen Wang <chen.wang@linux.dev>, Inochi Amaoto <inochiama@gmail.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Peng Fan <peng.fan@nxp.com>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Michal Simek <michal.simek@amd.com>, 
 Yixun Lan <dlan@kernel.org>, Andrei Lalaev <andrey.lalaev@gmail.com>, 
 E Shattow <e@freeshell.de>, Zhuxu Ran <zhuxu_ran@zohomail.com>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The upstream SG2000 devicetree (sg2000.dtsi) uses "sophgo,sg2000-clk" as
the clock controller compatible string. The clocks needed by U-Boot are
the same as on the CV1800, so the existing driver can be reused.

Add "sophgo,sg2000-clk" to the driver match table.

Signed-off-by: João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>
---
 drivers/clk/sophgo/clk-cv1800b.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/sophgo/clk-cv1800b.c b/drivers/clk/sophgo/clk-cv1800b.c
index 2270a076ce2d..da0ac9ce7fef 100644
--- a/drivers/clk/sophgo/clk-cv1800b.c
+++ b/drivers/clk/sophgo/clk-cv1800b.c
@@ -744,6 +744,7 @@ const struct clk_ops cv1800b_clk_ops = {
 
 static const struct udevice_id cv1800b_clk_of_match[] = {
 	{ .compatible = "sophgo,cv1800b-clk" },
+	{ .compatible = "sophgo,sg2000-clk" },
 	{ .compatible = "sophgo,sg2002-clk" },
 	{ },
 };

-- 
2.53.0

