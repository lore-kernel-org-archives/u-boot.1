Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE1E3CC6B2E
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 19:06:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8598C6089D;
	Wed, 14 Oct 2026 19:06:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sbezRtJ9NHln; Wed, 14 Oct 2026 19:06:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D06C360849
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792004805;
	b=Sg1mFQQs4kQC+x9jHhKKMHipy22O/WPk1qx2qM7oZLAUbKbFusaaTKLto9YFX4TuqopG
	 cNEmDJJJIJwv0JWLRprhUdC36gDBaYPvzRm6+31SIb7sh1h+w/9gkfftVkeFD6BqCYaYL
	 NR0T+oIdCsEjfFilFsrllliTP7EoVvqnqtj+IiegwO0LPkdyXZuCPkriCopl4WvqyeeBr
	 xoOaNBo8ZqRVPTUJsd9NUqDcTziYXqiXx0cg/mZM63mNZcPjxZL7zgWsigQWeNne5+Qw6
	 LartIM9VPy2O8E14HD8ZMQeQPNcWs42WNxmnfLrtS7YtBvGHfvkG3ntwG5BMxRioyDw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792004805;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=aSajIKs4hnV8Xegtaoq+MaPoCDQWbIO+6dE6S7FOt7E=;
	b=M2i1pWmXdp8yV8nehi6JthUgc5u6jYtHuCyNe29SqPxyILgOJKyCaofiGgPuzLsRlJHt
	 c1adiw4a1gSUKBXu34UGFFnFhMvx7nOryspfvpQtawWYaa0cYkXhLLoVnxgQGa0q5FHnO
	 PCdWWioY5eJorcNywpA5OMV+76sRDdGJy3vXBdGV0TVzq/WKub8yjCis2mN9CMbJrjkdp
	 bzNTqpl/pEflOMllX+jL7YeNnqvivGw/gy2k7TE6xws/aS12t19DTkmduRYM9uVYAGUb6
	 62wrUcuKtlBEmJfydbS2DGljrrncqY/aXkMXqRLdRbkWv+LdEJUCX5mso5bMzDToZdA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792004804;
	bh=aSajIKs4hnV8Xegtaoq+MaPoCDQWbIO+6dE6S7FOt7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jPGERnreqdmxhrkwjbPKqX7sbr0NVomHIF7PbkMh5MM5FYFkHC+N+xpalEmVFmfHI
	 AdpgbDfR0NyCOtU8+pmLiecaMuErOAujNtespIfAm7EVqKfdOeotxeSg0yOnweuBaP
	 NpjimMf6jGoWEUx9iX8/2U7Gnd+ZZQIh6v7nOBBivAy5iXPAzWgjjFUxGI/vbVcpqg
	 S/Wg+4x09vyavBbCcZ6603fUCgZOpo7vbaRTFNV3tT7ZGzm4aqF9AyStAE6tKSPSX/
	 SLpP1M1CMHpBmFpp3z9oXYfAdWqsSk+r/H2yTz4Y4p68wkH6Uf0YZYqPry9BHHOk9N
	 QRuZMt+pJ9kQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D06C360849;
	Wed, 14 Oct 2026 19:06:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 68D1CA58
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 19:06:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 44F6580F42
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 19:06:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TBZGrEPgOHp2 for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 19:06:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AE32B80F23
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792004802;
 b=e59w/z40K7TiGSh3KGKB2g4pM3VqS3G2pZAbL8TNYCpRe0jJbmnAOgKypUVIXIJbixzv
 dLIquq6vfN5jnwWV9a7wfjdzXhfXrXAIpOi5Fy4DMZOPLa9i8nAYvYzcNfsdHyFxsbZWJ
 uPtFBgezCuaJ3qrft9OGEwoDAJAdZmRopfhcVg8Xt8v2Ow7fG6uAGKf684O56tng2NpyJ
 tGTY7fIZNH4Q7eVdStMIRDL5jJ815tnLtyqKu8aUZ0TP3XDir3i6bl9tgYantl3gXWOUY
 grJf3EZbXE6a4Xm/EK1M5g7P8Mccs/4K7w9maAs388ts/tlyEGPFs3f05UVpqk2Q5Cw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792004802;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=aSajIKs4hnV8Xegtaoq+MaPoCDQWbIO+6dE6S7FOt7E=;
 b=O/vQLOHahtSj06xdTtZcGWq5kRYyib5Z9bNkAraX2yGDZ99QkN/yURIcghBjKsRSLWAk
 m0fhmfttOGBEPJoKvBM3866w/U9HwmvX4G4ahwFF92+ZvaN6uuiKECtSHw/GnhdiWs7sR
 BQXgx7hrn6IKIUgfDI6W7stKyhTafHkJIfdWvJlbakvST2CVRAZLu3jQ9uU5SEZhcE3n1
 VQmmy8Kde9eJJSZ97rxx+yggQoUD/Ai3QGj2Eom4l4M6ZciYqIR8FJs8rzJAVvC7GURAr
 LWJ4akLuGwXqbvRzev/b17FyEq1VyT387JArq+1mpUKMswF0l5NSlEuZd53qncccJ0A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=psJnlsQO; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=psJnlsQO
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AE32B80F23
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 19:06:42 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-38759bcd877so2829975a91.2
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792004802; x=1792609602;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aSajIKs4hnV8Xegtaoq+MaPoCDQWbIO+6dE6S7FOt7E=;
 b=psJnlsQO/k78g5RqYZJEyAvCJjWJqqXAGa+JGI+w21ZEgJzPwBgAWYp20iZagqVP5M
 WHRPf9gGCn2csEVvKob8N0J5HccLAZnSSb8w2X4j3nj1hS6qgEVdFBJrIs20bA0cQR4i
 D9Cv0pFeIaoO/Jo+7wud3b/gy+EktF2sDcPYC6iuMWWTi1X0OTU1sximbqfw721U9rIt
 BqGJgt/M0UL9QTIFZI4HxxRPlaGCEvfl2CQ4XhfzPqNcmY9He2OSa1CCld2VMlV/mdtp
 Ou+N1+AS0J8JcEORq8PY/+BKIIVoye0nUQhHKmfXGTDj8EAZru0Hs7rzEAghv54jrC7e
 3ZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792004802; x=1792609602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aSajIKs4hnV8Xegtaoq+MaPoCDQWbIO+6dE6S7FOt7E=;
 b=zn2stSrrYqXycFEGxJGDP+EJad0U+/1vwnLzNAKQWy8XmAKJyMr1fUZrsXG0SFG0yN
 mzys2JOPsP1nuzKKWp6NkroC7JtKLh/FGk9/7+GceYei9CYm/Bjy0msHPXws5MDy2Oxo
 kwsPFPo6jB5k4V/edB2zfGY23XZdaORxY5naCF/LqRuJsVm/i/hEz2QckkqpwoGvg7JU
 QcGMlreDk9W0liMLTUkful4cnjfjs/o60tZGCyp6xhRahOp7khDqOVjhOJYeuehLu84y
 PHGzASrU1TRyjNb1pNI3La9NDPNzDiR5gVK8NX0c6ut3FbkkEu/Z/2so/yJtfKx0MWKE
 jnBQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByy8QAONx2rKjmRFOI2M4HLzjObKKXpVTcJ+/lDXVAxvOUroC06RmnX8W3918AXZfp30vqiXOk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLWVkAnKzjzrKHXcFiutACBN3ts7GHf4nw/ykIVho5ky/aLcQJf
 SEPEk4unINX87uibgHQU033e05VvEy/Ho+GTmoKDgSMqwXZXWCfYkbQJ
X-Gm-Gg: AYBFou0B4YnHg71SHZUmOrxecqutIuwa9DdX05qDHCWjKgKk1BNLneu0w0BYEnKMS3O
 yJvs7I6JKY7Zc8aW2zajrUMWncEBtNH+kG5+4D5rV4Ub8H8M7C8g3yAvTEiuLFU5SKBRPeTIhuv
 rX8vIPuyBc/IGvFDF2kIkAeBluGS0oxPoe/cv0YLK95vgjcEX8AJ0QHmq06xAxmTvAl3f0KxoJO
 CMyk9Kh2qsSsyPamEocG0Cv4517shCqmOtDIYrKuSs523xcufbvrOOSpe80S+d6OzEhVIOCqGKE
 Imf2uUzgVd4LvwMWZLiAWo2QL4M5QGy15QxS9QAXfvWFGou6vdgQLPyKuZoU56lHHDVi5dDqKeX
 b9GOxTCBodT9ag8PWp1E0pIMXXSq7sxwBWzyg4VsdtJXLnNZFZ5LNOu3BG8Ck3f1laDI3Ja9+tG
 BPc9GNBYUjioVeev2i2FYlXKVzn8bZQDWmXJ8rQPweQPkSjQhy5VjDHaRFyyHSLlIg9kowkJHtW
 OX+2YTTgTI6GzqJSdBnKvOUYQtrcmfKUHnSaGIZX2oxtL/QoYmW55cwxGjNj93UUCG3mt5jwl4j
 xPYUOvqhkrWUYd055p7SsZKX/z7I+rQiRDonKc50jJSiiqKxw78QbQ==
X-Received: by 2002:a17:90a:d44b:b0:3aa:fdad:7d6c with SMTP id
 98e67ed59e1d1-3ab3afe1d32mr13493824a91.58.1792004801730; 
 Wed, 14 Oct 2026 12:06:41 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac92a1f906sm624938a91.0.2026.10.14.12.06.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 12:06:41 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>,
	Tom Rini <trini@konsulko.com>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org
Subject: [PATCH v2 3/3] MAINTAINERS: Add entry for virtio RTC
Date: Thu, 15 Oct 2026 03:06:31 +0800
Message-ID: <20261014190631.2232208-4-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014190631.2232208-1-alan.tseng.cs@gmail.com>
References: <20261014190631.2232208-1-alan.tseng.cs@gmail.com>
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

Add myself as the maintainer of the virtio RTC driver.

Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 28d090d3c..2ce94d7f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1872,6 +1872,11 @@ F:	include/virtio*.h
 F:	test/dm/virtio.c
 F:	doc/develop/driver-model/virtio.rst
 
+VIRTIO RTC
+M:	Hung-Chun Tseng <alan.tseng.cs@gmail.com>
+S:	Maintained
+F:	drivers/virtio/virtio_rtc.c
+
 WATCHDOG
 M:	Stefan Roese <stefan.roese@mailbox.org>
 S:	Maintained
-- 
2.43.0

