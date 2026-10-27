Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DCC606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oAaXaStn;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jjuqTQVz
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 95F1180C0C;
	Tue, 27 Oct 2026 15:44:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3vpE7u9hG5id; Tue, 27 Oct 2026 15:44:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E05A380B12
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793115840;
	b=gv03vPqND7X5iy4G8yiV131V0nDQ9Kg8HeeegIZP1UVPIQsycjWWP6Pjf3A/jEX8to8q
	 1wQBgJIiFkjVvkFVYDKqJxToFF1pGcIfgSAv57DdLnmacDxwFCszno1fMtubTeK4DampT
	 XwQsMHue4hzqQ7kuayFKSBrNa7973hnR12EQmmXyNLp8ZzUcH6o09xiOLM2xhtOWJURy9
	 SErDO1SjeG35v2i99OdYWFoWiiLweGYrHsoQVCdYDjdde882bMVKfw1l2THUzhei/UiNi
	 RmgwDIC81vkG1BEE3ytyltTVqPYZxkbyFbUvwZl6AZ1tl/oQzoxaHhShCoxI7Fit0Og==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793115840;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=B570QiyTQ8Y/dB44dZ58ydjc+XsFWM2ySJuEHZ4s8J0=;
	b=iwyptKk2HklIGJyZVDsPQZ6xn2JtCcbByIKSoLEVupDfkBbrOURxPAKRb+BYM6Dq2Kwl
	 uQPE5gu7LOVHeJco5H8vTFCsq2WxMPo8hxlBw6k47RCgD5OR+BKTLUCJThxU96FJ2P3Gm
	 204ZtOl0UVMOD0KFwPaWzXtNQcYU5SUKwlMqlAptzjrTHAIzYZSID3GJY7Zp9JTNxalTH
	 K88KOGDslkuix8yiNVc4EqJvGBf9fjGQ2KhWT0lId+Rj5x465AbXrsiPIWSCyhlMFPgzI
	 FHwnoqQ4bqboPQHJElxZiNtQ9mpb8XwUuhh+IbBCympeMOunQ9/X7SxG7dlhhAtHtmg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793115840;
	bh=B570QiyTQ8Y/dB44dZ58ydjc+XsFWM2ySJuEHZ4s8J0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oAaXaStnzgPXvI5cKW6dT2m1WJeZ4vcSYTABMk6sZB0ikjfVExceSsVlv/7ClwCss
	 lBHXfweA8LaOJiHI3jciBt50fDlb+JL9rH8PEqle1bztCLvSHBN5ZgKwL+fN7k9A2P
	 Z4opl2XjZamlMTGhUdAVoyFhdM/ZIDM5Xuhl0DSLKuYFE3wyGWSp+pzapWcPvStQSO
	 KHyFoysUQ9IsFz9GGLV3f7o/stTR7KHCHWDubwE9EIPWXqE/pPOUEbItrhBkaOgFIn
	 cCskKc/c4l60UOMh2nXVCE8oZL0495NRIhc+VYverzdfrJvjhtsw2DjvQDkGrZAO7q
	 a5JIAqhHLFv9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E05A380B12;
	Tue, 27 Oct 2026 15:43:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CA3EC4BC
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 15:43:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BC447402BD
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 15:43:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wuyn1Uhoow_y for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 15:43:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2A28D40184
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::431"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793115836;
 b=GkBPvHNDcdaRrBPALgbRAyNsNxJb2mvREm4gp4CNdegX9ij4uf0FnSYEawZC0/8+ew6S
 rVhMeLR1o+xbLsSTVLGJzSf9/0C3mVAAi1yGMhZAh5C63zd5HCoyWTT+iv+gik+qrnUN1
 HvxQzrW/9n6OvhHCPOQVi2MD14SFpwz1HFpOJahbzMozT5T3yLG+feRZkVBYBl1KXhc1i
 O/e/oqqfmNlZMehVYZXBtwE9bWn4NXj7lp2lp+QREkpsgAsUO07qvcrEo3JMJFbHu1wp0
 vfVtoorC8VMjrK+hvskLIv75eYMTw9BSM7PbdolFsFEydqeQI35pZECGwNZHA2Z6VBA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793115836;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=B570QiyTQ8Y/dB44dZ58ydjc+XsFWM2ySJuEHZ4s8J0=;
 b=DfQOxB64z3S5m4llwpsoHgUQ111hSetEU+tDqKVH4rUI/0saVye5fhCmG7phmK8wVQeQ
 PrapBT6BZBtMxRE5etx2i9JBw5Co/0zejMRepC2zvFys2Buo8EPpHTQ+CMCAnWWRBgYJs
 CkSt9X90NXipLywkMozs6M0MGa0qWC3AapOsKqqhB73FvLjwAB/urMH1spGl3K1/r/7JW
 sSps/wiJlcM7iUpjkhZWZUTocMm9hzbs3y3oG13b1d2eXBzSpX1pDIwOndtI9eq01UVlQ
 kFWiIp69N5w19XN110yeVDp3axpDEAJMMz5KS7vaAwR0TDh3em+pmBuwAqJHUuF/ZyA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=jjuqTQVz; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::431"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=jjuqTQVz
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2A28D40184
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 15:43:55 +0000 (UTC)
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-89f85edd210so19289b3a.2
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 08:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793115835; x=1793720635;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B570QiyTQ8Y/dB44dZ58ydjc+XsFWM2ySJuEHZ4s8J0=;
 b=jjuqTQVzx48cYpScQZfhF0uOtbausUTaEvMMD71DuA22ZtpFOML5Lj8umQPBhCrVGa
 hQcFWeW5+EMKr/laxC+GZ+GDgkFzBHpCTZNrZHV+b9e4DxXhvfIUAv1DcK+gMavTcIXT
 ALC7xxzUYfTUQjRye5+3UG7iskT8pxWR6uU+f0rYxsjChAL3TDmo02tYTy38qwwhCc/8
 cRt2ftNagj6ralwTix4foidllj/5M4yUK3erNPNEY5ACsC6RLf1FELgVeJMZtOBwdXDv
 HvEFIzV+g7uPuRofn5gm4NAMO5b3BO0u3jN+P++FoEHURBqgtyYZZiZXi8i62WfVv1GG
 Zl6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793115835; x=1793720635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=B570QiyTQ8Y/dB44dZ58ydjc+XsFWM2ySJuEHZ4s8J0=;
 b=ctjgtyC6J0HFDPeLg+68Avk+gTrhXCyekY/ylOjlOZ7ar4Pk6b4rcb/JuVkadOODs5
 yJROioGSqHl8m5PdfK33iien6IWgUGqmIjBJ/PB6GYkB4nShG/+xASiTzcxYR0wjRiBu
 Mh1rVZ+V0/VXej3dSlyIGOknapU5KSblYq6Q4qumZvNwX8HOi2Fcsd5+wshaspQ7R5eQ
 4aOkQaKa9U/3XjqnAtJuYTxcHZ6SoTnaqRsHMEFu0s3eCBpO5zOE1gQWLnOJltKiReRx
 mn5Dxe3p4Lj3iRDsvOgTzc6E8oZT4KeE50OFQJl6HOgPZRDaBOA9ApOhCsaH1f/l646C
 0hBQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxU+UATne2GxTQwdU8gEjd2QpO8Lz+svOcnsEgM9f2bUgDWGQ1In7soMEifX7EA4ZvyfOEi++E=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLYwqaUBBhtSxGI1LmWm1DB5qfh6ztXVt4/jRP6O7dbkIUwEp8P
 WTrCQZz+2qgro9XxwQK6SEK/L62cDPWF3vtivNQPDp8LJonRDgL8pN/t
X-Gm-Gg: AYBFou0VkQmIRYjzFyHIwyryhcPr1WRZriHxDVhmES7UuhoFf65Ypi0nus1WKbUNihB
 VEGD+Kec02tCE90exbMo/cWxTv54rLNFqTZLaJR8pqi9MVtNiZLP8LWQrUDoHKjbrbOyF8ui4GA
 AELGLzSMmFXcc7RF2ujc6arXNBFX5grdW07lwmqs+EYNj55PAJEvV8LSsxT1vfXN77JoPf5WIM0
 moebaaSLO2/6VxTGoaJS1rnXeGayKGtoHD0kMq9Z4MXTjl5gvqoFhVhgnYpxaqiJ8ccT9ayk4qj
 vh7lVzISLyBO38PGeXjjG90ubeAJAJVNcjTzoMgrOPnAD1WkGTgLWyU+x+jDj6BgDy65UwLCYT6
 7y5RtlgKD9mFYTAuwtn2StVX9shi2zkpjPsw/uGx9hy/dGpHTRfeUGWgt94xjuUr3kARQXTIm/f
 T5ZlCoVGEdk/ffDU75A+A8pV/kKbIp5IQjeqp9G4QAq3At54TiUklk2kPfF1hC2NE1WlGmu7Xph
 NqBuCThKYAh8rrxsuzTSc+mPEHuXgmol8Z1Fbmi+9xDIsA6dJzOTFxt8QDU5jmI09/PAoSLNMUt
 4CnfzfFurd//fJWpSZ71xMHBN0QCcsHKZBgkZ4ZPfW3bvgnEJiAfnXM1dpvyZOM2wGRl2KBp4Q7
 xZ27HEBHEIolEA67mPssvyyqnH/N37RZpDFI=
X-Received: by 2002:a05:6a00:23cc:b0:8a0:1a6b:59fa with SMTP id
 d2e1a72fcca58-8a366d77c9dmr7850006b3a.37.1793115835255; 
 Tue, 27 Oct 2026 08:43:55 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8a6a6cf7f6esm211685b3a.33.2026.10.27.08.43.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 08:43:55 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Yixun Lan <dlan@kernel.org>, Huan Zhou <pericycle.cc@gmail.com>,
 Eric Chung <eric.chung@riscstar.com>
Cc: Tom Rini <trini@konsulko.com>, Guodong Xu <docular.xu@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH 2/2] spacemit: k1: initialise the EEPROM index in
 read_ddr_info()
Date: Tue, 27 Oct 2026 23:43:47 +0800
Message-ID: <20261027154347.1392094-3-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027154347.1392094-1-alan.tseng.cs@gmail.com>
References: <20261027154347.1392094-1-alan.tseng.cs@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

read_ddr_info() passes i to read_tlvinfo_tlv_eeprom() as the EEPROM
device index before giving it a value, so which device is read depends
on whatever is on the stack. read_product_name() does the same call
with i set to 0.

Initialise i to 0 in read_ddr_info() as well.

Fixes: 83026cf8f90b ("spacemit: k1: Add DDR firmware support to SPL")
Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
---
 board/spacemit/k1/spl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index cc0e26bb0..60f5d8c56 100644
--- a/board/spacemit/k1/spl.c
+++ b/board/spacemit/k1/spl.c
@@ -332,7 +332,7 @@ int read_ddr_info(struct ddr_cfg *cfg)
 	struct tlvinfo_header *tlv_hdr;
 	struct tlvinfo_tlv *tlv_entry;
 	u32 size, entry_size;
-	int ret, i;
+	int ret, i = 0;
 	bool found = false;
 
 	if (!cfg)
-- 
2.43.0

