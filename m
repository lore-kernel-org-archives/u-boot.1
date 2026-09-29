Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A32D7CA5FA7
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 20:32:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 69A4B810E4;
	Tue, 29 Sep 2026 20:32:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d0XuTgl3iTdO; Tue, 29 Sep 2026 20:32:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A87B8810D0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790713978;
	b=BebUzg2bbx1mCzK9gwUhQXEdJ6A6DbPBPnxRB5gbkE1Op1lVMvSnx33qGgcZYlXSYef0
	 pP9nvj4PtZmtKqX+miwlWbaZLLjOXg5P7/lZbmLiIhNUqPOIJj2GVQVrjzZdXF4kyArl4
	 7jK4/TK/aG02Qt/bcmBNx0KXax6WQ/dSgFbK82IPyzKN6PywIBKdSbahJ+J3Hu+hdaVGm
	 1R3qjd3e1CYUdbyIlXIsfp9KHF/molCzVs2Wq2tktYpr6pRJVvrYmYF1qhFV/Uc0O+Em3
	 Bg2iMt2gewI8txqKHsV1BUKc2tO7XL3SRTT0b0UQgoK0YA0mgVwtJ1q54Np4sJhN7nw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790713978;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wI2OIsbWdYV6bPFWheByAHe7H6csNjBynmwDlgJdNFk=;
	b=m02ACd0+ffvkzTGkGE4UidA0lmZiC9NI2AFUJtNyhSvCqu4SDjyZelMVLZIpWeRtylId
	 fStcyX5CxWS85Q99/k7aa7oZi1TrKInU8TIRI60kC6mih92mRjpZBAVwzy7tmBl3XRe2w
	 spI7VTbB1VzGMimu/Bxdnk/F+OxlEEDI430f/Lpad/chvFU+qmYzIDDRZLuaMqxr5gKMi
	 dc3+6DSEnVLBoZWh0DzcdG+jMAZKFvs1eVUzBjf1DSWH1rdvaD1EKgwu0j9MatzxHdsrF
	 UMO7pZVMd0EQ833N4xMOcb2G976QD3d/0G/LR58yXsVCnCvvK1fJlPx7x152AbviY5w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790713978;
	bh=wI2OIsbWdYV6bPFWheByAHe7H6csNjBynmwDlgJdNFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FyNq1EBz+p493kOIO9zfAqQwlf7kLdmN3v7Nq7G7x9O4JCrAN/WZ/5yxgBU8K/0lJ
	 3/W60DzJzm3yNry1W4N26z8OeUuI0AaXopiIM250E1qO7jfEAyHGtEsjSnGUDeetls
	 0un+cRVe4ZiB+mvfN2Bdee4Ic/bQRTq2ntM5nGCTv3IplIZEOcZ+HtpfqpZqWlLZeJ
	 MaFqCwhuDW/ZyVrydl0hgas9LS49mRQsN6HBn0Sea2j3mIJUjvJeJB2FF9mi3AW7sB
	 GHme97poSpbf7clo2bK+9Qh8x50SpEm8KTVFp08aHiE19UfhniBLZyo76/ovz1Rwc8
	 KOBIXaowYBbWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A87B8810D0;
	Tue, 29 Sep 2026 20:32:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 195F73D8
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 18:07:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0B2FA400D5
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 18:07:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VKD3W8DSpnPL for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 18:07:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 04CD3400CC
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:34::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790705251;
 b=P8wMCjZQ8EnNe7RSgWmzWT3LirmMCTLSa3SRyVijlN+MRdtSKiMqSTwHq8c+Y/u683Gz
 VcMGDkybP/zZDIK/58jcy9zqEiqRseFHuaQ+ElwS3zcXkPAnIqfMjBSCf41L3iNf6tWMf
 lxOUVpkSPDg5JWoWgiy0K83c0YyZ01W0G00lGUyr/hLeQf4DlpcQJqLgIhtrLvPyyMA7/
 qLX6UV4D8MTvUDCX1uwpRdku7vZEO1IJLA4ocBeyzzT0qfdob5eFSEhWPzO/r1cEIVdQ1
 iwgO6Bg5TIxvQPcEClbKq1efyiavDZwoWA2IIzCyLrTiy3bLv+kU+kminhh3S4IpItA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790705251;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=wI2OIsbWdYV6bPFWheByAHe7H6csNjBynmwDlgJdNFk=;
 b=kkOUEW/KTkH6xzNbQOixnIs1eHwUVAK+9ICfaCTLjCaRc++v260VJGiqS38VkKKX5FD0
 jGFkQXSbvA0EX59phk/7Q5XBQ6Gh/rU9zd28VqYzg2N48wifVS1v+k1lIIlZXrW5uichy
 MGAz881fSjmzETQcSGhIUywqQLekeSnmLwIU2iJbhwm45wmnslAqH0mFhObMKnLXm2afa
 u4jCshVFYWt8V5Aih3SZvpSdMy/ppwR+4Vi3rxpfM9cYsXSAw70/QvUki1lFpxCOBfW28
 98XYxRyrdrAwzPKuCBzrc+BPckFys3gaMFfdmgSeIV6XSp6XlVuYZ3bhFXktGLOrjWw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=brivo.com; 
 dkim=pass header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b=Ss1Fi5tc; 
 arc=none smtp.remote-ip="2607:f8b0:4864:34::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:34::f;
 helo=mail-qk2-x0f.google.com; envelope-from=sanderson@brivo.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=brivo.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=brivo.com header.i=@brivo.com
 header.a=rsa-sha256 header.s=google header.b=Ss1Fi5tc
Received: from mail-qk2-x0f.google.com (mail-qk2-x0f.google.com
 [IPv6:2607:f8b0:4864:34::f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 04CD3400CC
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 18:07:30 +0000 (UTC)
Received: by mail-qk2-x0f.google.com with SMTP id
 af79cd13be357-93910c9ff1fso459933585a.2
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 11:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brivo.com; s=google; t=1790705249; x=1791310049;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wI2OIsbWdYV6bPFWheByAHe7H6csNjBynmwDlgJdNFk=;
 b=Ss1Fi5tcmum0JQFmAQ9QH5fMb3WC5ZTgjULTQ+Ql9YZW5wECg9iuQSYDGJsHAxgkXc
 HMxwqDqUNi7VcZBXGpQOH/Hw+QSXmZACi+mYtSHUdKZFf8tZCrghMHT+lFqFuPwZFhar
 dlvVrREdpUu9WzyZoaXW4FsmfUgrn9FPGbdT5D4BaEXyEI0sBGgmEI4B9Q+q99pdXQvS
 5o5smEYPCxZ38kX0vtWPUksvcffxhfh0OCgHmzK1ppnPVZn943Fp3mLH3pOJGVUGlkKr
 01z9f8nngisQ/ZYSjiBUbBAoC6tMu4sxPGpkgCPO44ACUODvdxjf5LTqjoFSLZh3UNxB
 eKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790705249; x=1791310049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wI2OIsbWdYV6bPFWheByAHe7H6csNjBynmwDlgJdNFk=;
 b=zqbsxgwMn+Ixc3F8ytE9h1w3aON8zrHUsWuhda8HqaTYiY+Q0fklbSf11XH1C2CnkB
 ST+Yzm7Kkejv4BuYw24Q8QrESI0ng+8B4fU+LqFhXJ+Z/O2BCYTxVqm784J3LYViEkb9
 PjIrb0yiSFy4JXmDDtSpUaT2s94nT/Q0ulHMlQIV1uqrVGYgJSzzSWIBXhyrhRkHGX7T
 Mpkmv575ZrauvVAcPuaF8F85XDiCFtGPo5GHeke+q7XRRT6I5ju8Bla7W259V77+xtwS
 6fg+Elf2DDptjswtj4y3Ch+rsdIBCJAssc0VolX6H5awiL31H8ltTrqm/j5bRcSQXvEX
 zObw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxF9dXk5n/vHVhEJVlNScFueAkfRzWqorwNS3QKq9SRT426c59gV2UAUhHik93lSSbB0uGze0I=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mWkDvwuJQFPzY4HplLjDL3BGJ+3HtKQNjZS4wMUG4LuSfOqFrm
 m7waIa/Y94eg0B6rm2OOtEwnxBWZMT2vA3k/zbeKz+zJfl+r7hlLhXYJKVHiO9sqgyhcqFEjP2p
 dDoyob35i1ePyaonRIKGNZH0BiaeuQQjVbubOEMpgWUkyr+S3ea3sf7z8xYApl0Y=
X-Gm-Gg: AYBFou18mgLphQ5Cryh0xLOI7hJHWlccCKaQoY/0tFOGoN7npKtrFMv/FRd/SXxfPm/
 w/QGehzFnAXh0/mBKkFFKXKITKv+3xBKyrwBfq5NbO7uSjDpMNQj/PNnd1MT9Ypk7driPzLLyQw
 1KCg5IPJQPIQQJ7WdB38LLKe+DlpjJoVAbHMZAmGZxe5g37eTQgI7eKlHEq9IC5AbwiS8pazBBB
 Z2wsU+o0oFv8DloDsxVDurZrb2WfpuW0oXe7C6qJ18cqjn713Zs30kikUJeuQ3VZ64x2+y5axku
 J5LDOo10syCqA/L4AqwuU//2+CDV2gtmlKxy0Igrnl2D2GZYTpgo8AYo31PdkvYExaphdpjPNj9
 kW/qM1Bz8iagqeqCYw7yvzH6F8ZDheU8pg9OJNYC16aELz8PR4Bo7CF61uWzvJqBsqLsZ2SfQUi
 Y8L4eWWBYEp7FsXquQSxIAKKPn9rPFkFI6ukO1fKg9Xw0Zd/d7B3HyiZ9onJOpZLBp
X-Received: by 2002:a05:620a:1728:b0:93c:65f2:7d63 with SMTP id
 af79cd13be357-93c9fa23772mr66834885a.31.1790705249285; 
 Tue, 29 Sep 2026 11:07:29 -0700 (PDT)
Received: from strozzi ([71.163.254.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c9f462b0esm28802785a.9.2026.09.29.11.07.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 11:07:29 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>,
 Sean Anderson <sanderson@brivo.com>, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v2 6/9] clk: meson: Support fractional fixed-factor clocks
Date: Tue, 29 Sep 2026 14:06:28 -0400
Message-ID: <20260929180721.3440839-7-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929180721.3440839-1-sanderson@brivo.com>
References: <20260929180721.3440839-1-sanderson@brivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 29 Sep 2026 20:32:39 +0000
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

One of the s4 clocks has a non-integer divisor (2.5). Add support for
this.

Signed-off-by: Sean Anderson <sanderson@brivo.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---

(no changes since v1)

 drivers/clk/meson/clk_meson.c |  3 ++-
 drivers/clk/meson/clk_meson.h | 12 +++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/meson/clk_meson.c b/drivers/clk/meson/clk_meson.c
index de5aa5ae3c9..29615fdae77 100644
--- a/drivers/clk/meson/clk_meson.c
+++ b/drivers/clk/meson/clk_meson.c
@@ -153,7 +153,8 @@ ulong meson_clk_get_rate(struct clk *clk)
 	case MESON_CLK_FIXED_DIV:
 		parent.dev = clk->dev;
 		parent.id = meson_clk_get_parent(clk);
-		return meson_clk_get_rate(&parent) / info->div;
+		return mult_frac(meson_clk_get_rate(&parent), info->mult,
+				 info->div);
 	case MESON_CLK_EXTERNAL: {
 		int ret;
 		struct clk external_clk;
diff --git a/drivers/clk/meson/clk_meson.h b/drivers/clk/meson/clk_meson.h
index 990e9434126..86b272985ab 100644
--- a/drivers/clk/meson/clk_meson.h
+++ b/drivers/clk/meson/clk_meson.h
@@ -61,7 +61,7 @@ struct meson_clk {
  * @MESON_CLK_GATE: This clock is a gate
  * @MESON_CLK_MUX: This clock is a multiplexer
  * @MESON_CLK_DIV: This clock is a configurable divider
- * @MESON_CLK_FIXED_DIV: This clock is a configurable divider
+ * @MESON_CLK_FIXED_DIV: This clock is a (fractional) fixed-factor clock
  * @MESON_CLK_EXTERNAL: This is an external clock from different clock provider
  * @MESON_CLK_PLL: This is a PLL
  */
@@ -87,7 +87,10 @@ struct meson_clk_info {
 	const char *name;
 	union {
 		const struct parm *parm;
-		u8 div;
+		struct {
+			u8 mult;
+			u8 div;
+		};
 	};
 	const unsigned int *parents;
 	const enum meson_clk_type type;
@@ -133,13 +136,16 @@ struct meson_clk_data {
 	})
 
 /* A fixed divider */
-#define CLK_DIV_FIXED(_name, _div, _parent)				\
+#define CLK_DIV_FIXED_FULL(_name, _mult, _div, _parent)			\
 	(&(struct meson_clk_info){					\
 		.parents = (const unsigned int[]) { (_parent) },	\
+		.mult = (_mult),					\
 		.div = (_div),						\
 		.name = (_name),					\
 		.type = MESON_CLK_FIXED_DIV,				\
 	})
+#define CLK_DIV_FIXED(name, div, parent)				\
+	CLK_DIV_FIXED_FULL(name, 1, div, parent)
 
 /* An external clock */
 #define CLK_EXTERNAL(_name)						\
-- 
2.53.0

