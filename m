Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1C8606A88C
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 17:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=E5k/bqti;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vIBezQrT
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F10CD60D67;
	Fri, 13 Nov 2026 17:32:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PVnWo_L_k6iB; Fri, 13 Nov 2026 17:32:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 45E0260A4F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794591121;
	b=nCeFXM+ED3lG5Oxh+80/Dk+soUD++LF4DWXe30NuUYMNtBxirCepB56cf8oM0TyVdPVh
	 vqqRr65q0Wr+yOEKZkA6MD8EZXLwfLzeNOhLD9cV8pXfJdjEwtIau1eVIdEWXrxJvZm8a
	 0WH1j+HKU2yWBAscJN+jnsFPJAKmzvKT5MgxfCHgEFvCYbnHLSMHrXEcB5dlqb0qTBkAk
	 eskKqDOw+GOetJhdr5UPlGvTCGJp16iHTguEoV/jSJ9FBoI4dRQhtM2jHAopdKu26oaVi
	 CAi30RWAawiP5BmC7FkG+T1/ajes6gQE0WWWUGagvPF807kjMRUNV2P18DeM76wLNqA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794591121;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eqp6LqtQvmdmmYJPKm7qitG8p0X2zKKR3qhyNGQs0EQ=;
	b=WjZvXpo4WL4N/IiSuqv/iqxF8mgUywASt9emS/S08G2sej5kr/oNlxlvL2XVuEM4X3BW
	 j0VadZYPJZ3iKHg6FqcMTmffK1U/4WQHztMTrNJPQ25F2um8cfSViekEm3JdOs6QblcHD
	 ia6ppR/+XjqJ6BMh17Qe+ZQjLz//hL5lZZbWiMkdcmksesnNNHRRiOv3asbyyV5jy+vxo
	 5hWg9qGr5ICZSRQ2HqPAnLHJTdHBftiqKLHmk42YaYIgR7lRyMB+i12fWYWYgLz+2wL25
	 tIJMuZw8fn7xSa5fOwO5E87xu/Y3n5ngFKdoLAoSv07I6fgLMOT2yPpZ9t5IxdKDQ0Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794591121;
	bh=eqp6LqtQvmdmmYJPKm7qitG8p0X2zKKR3qhyNGQs0EQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E5k/bqtitnGxETpKPsNYnGwgTu18U1g6E8+/dUV+mN3IZRxh2wWRD51yvVDgwBAxv
	 h3kFkAr4tsbhC91KI6aorRtl1M4mw35hYYJpvpClLlWQWaqA/DrNnldwccZ6+F+5Lk
	 4up4aBoTJ76/Kd9LA44ovXSTf+jgX96us9e1DmmsaO3I7rQXtJv6w/0Jt76KgZTbmN
	 yqM3WtowM6Ry6Z2v+wVH0MybjpvTrzF/Guprf1xmbYWOGAuz6QB7LCkZC9p3bOdglY
	 H3/GiV5Kx8ENBPCTMdGv0ByDklRwQeiyP2SA9nwI1rAtpoKy8SXmLUFa+4osThAYMI
	 UyDRlUYdnfuxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 45E0260A4F;
	Fri, 13 Nov 2026 17:32:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 036301A6
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:31:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DDF90815D6
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:31:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0wLfdN-n0YdB for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 17:31:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E1F1781360
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=vIBezQrT
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E1F1781360
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:31:54 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-4918c2d727fso621162f8f.3
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 09:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794591112; x=1795195912;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eqp6LqtQvmdmmYJPKm7qitG8p0X2zKKR3qhyNGQs0EQ=;
 b=vIBezQrTQqWaUsXFdV+pfhncmLRx8wPmt4cJnw4ax8AoEZMcxrdRx45r/GAyrJQQ5A
 0C0+CIJI4im9wiP4GBe1hjyj5SdPntEGzEgFCgBMF1nVdgxql57tXo0zRhfHBMV07gDT
 tNJqJbUq7Q4i1Br5klPllOsDjOIUJJEVWk76XLoLAWafO+mWGAZpHvw4VazRIeDkIfYA
 9ApquHhaWQGrr4AP1u1KLTOt834bHS/3xPaZx8hscSH1bi8yeOY9PgNG6M869ZBoTaxn
 61S5AqcDhvs+ACTrh5rElNblx1fxhX55RHPZ7LyoixDmtBgHuB/lRx9Ius5G1TnG7iZe
 n5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794591112; x=1795195912;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eqp6LqtQvmdmmYJPKm7qitG8p0X2zKKR3qhyNGQs0EQ=;
 b=zo37jlGtr7+WftJkJVw7MKj3ClJ2nyPAfq3ZzHzKhmTPUx4AER0DHSTZhlxnajg0Cj
 lwPHlvTYojtrqyJ4mw7ibOB5UgtH3AEEnRv1+Z/ohDKJ/idlew7Us+NseQ+SP0F9qyNL
 BPYhh1LSBIO+LQekc5VFRNae1MzPw62REZ0wYkD1Nku8C8LnFMlhkbA7qsGBXZNpjo/x
 XS+hhDT3i2WKzuqB4XLCYrTA5KrDToJnag2UjsWcF5SWnQNbSXkkSRqiK6eBCzYn8Btv
 yB3+Pxa3fFwRIySzhEzfgJDg34R0BApfOxlUKjGSF3Ax37KUmxGbALJm0fUdXBzmblsx
 FnZw==
X-Forwarded-Encrypted: i=1;
 AL+hErFcxVQiNBLRDwd3RziJMWVaM+TnbFlLkW4JxsCnBN5s09M2arjPPabg5CvYnZ9fdyej55dfnsQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z++y0wnkQHjgZwyYkotQXtP3rg1ZQ00CcRdrjYVU0+4dfoOanN1
 poKFPcUVH5Qw6lyse4I0cAoz9K0E0WOr4wDnweBIQk3vnq8vQ+jtHWCl
X-Gm-Gg: AYBFou24/MZd97nwNqKlN+HVCxx5qycn2nnqZHOGp0ORCMnzTmXhvZqmH7f8WI54O/N
 Vv9IFbFrHApkhmabZb+pxjfJPQ9OSTnB4Q1HNpStB/Ib4WGwHFxzGXm5v0YjgsQgQ9Prpl5VDjN
 ROcAJAGKkmcOnNdEbB4gb2LIUpQvSaHgi94ZHZ1mdKb8g0VU1gzwjANMs6jdXt6+AtAy4jemtZY
 ei2oBMbzfWv1tegp6MJ0pA8GvgCuA30uXkI9eOmVRNZSVUn9iESq4oc6a0qVPDhnr2eZbmAsBNp
 RRHkqOiPU1lVVfdZx7uqCO/rJ+npVacVgpPHAH3m3vjTxfbApuQ+IecjWDa0d2dZBK76s4njV8L
 DaioCkvj4gYYa4G8uU3LdHqmPM1l7aTRy2tWQDbywcmJq95Gsw7QA4iirp3vSSuyh1y/Uthnhfk
 CRadhYQKaMr6sW10S+Y5ublUftAH1kUhQAMEkmXFcVaHjkf7VvINYlribIXkBfktyWKUYZbkjNt
 IQOsWRGneqnZ4l+2R7botLhVGl6HBocSQNi3+R1SGnmhyOIU7xLiZAVO+R8ziwTuWI+seQlc5VV
 isRbGjBLtvwkuRRPUekKONRJAfJD8D+EzfmTK6pZ
X-Received: by 2002:a05:6000:240b:b0:490:39ba:4359 with SMTP id
 ffacd0b85a97d-49c714a2db3mr7202511f8f.23.1794591112390; 
 Fri, 13 Nov 2026 09:31:52 -0800 (PST)
Received: from [127.0.1.1] ([151.51.254.138]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c81a63b1csm5587810f8f.4.2026.11.13.09.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 09:31:52 -0800 (PST)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Fri, 13 Nov 2026 18:31:42 +0100
Subject: [PATCH 3/3] Kconfig: Drop HAS_LDR configuration option
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-ldr2-v1-3-dd7dbf436494@gmail.com>
References: <20261113-ldr2-v1-0-dd7dbf436494@gmail.com>
In-Reply-To: <20261113-ldr2-v1-0-dd7dbf436494@gmail.com>
To: Ian Roberts <ian.roberts@timesys.com>, 
 Greg Malysa <malysagreg@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This prompt-less option is never used at all.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 Kconfig | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Kconfig b/Kconfig
index 6381c523a93..93b84a31b0d 100644
--- a/Kconfig
+++ b/Kconfig
@@ -788,12 +788,6 @@ config SYS_CLK_FREQ
 	  A static value for the CPU frequency.  Note that if not required
 	  for a given SoC, this can be left at 0.
 
-config HAS_LDR
-	bool
-	help
-	  Enables building .ldr targets for U-Boot and SPL. This does not
-	  automatically build any additional targets with make or buildman.
-
 config LDR_CPU
 	string "CPU name to be passed to LDR utility"
 	depends on ARCH_SC5XX

-- 
2.34.1

