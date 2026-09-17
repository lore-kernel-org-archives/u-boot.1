Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757D7C982D6
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 14:02:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 26FCF404F4;
	Thu, 17 Sep 2026 14:02:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1XVnvpk-en5n; Thu, 17 Sep 2026 14:02:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 70E9A4051F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789653771;
	b=FmB9l48V660HduQFXTAiIsKrc7yt+MDbJS29Sl2GtLHl4fZYu5gG2BqkhhgtNKM4xb3W
	 /F67bV4o+IzEHRmNtc3Rc9Zf3xnJ0Pb9s9Q9XoC7DQQG1iD2oQO1F+MWEqkmP0M0EWmyS
	 YgEbwzS70l7XWgE5SmbGMfRM5p9yhQAqyRJ8Ksn+dS5x5HRq2YFYwEX9U76tTVLBf5QFg
	 JX+VYwwo9XhfJj3v4sw/eT+CicJ7zFl4QEMR4C/z/0yEZLZ1fFb7T9zliLqsB+W3pmyFl
	 EIUH7P5UBPgGPmQBKwoPndW3wScK4xADK56yT502yivnTTN3O7R0vbY7Jvoy+d6m5gw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789653771;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sp4wjSJhaqaRySeRGTzifeBaqvYDsOHA+eEsA6vplNk=;
	b=rg1rlUwLvUe+Bdwxuv+nEJhEO9xk8bwpB9yojlztUrGhtFyy9FrQZFcN9JUeRdcDwtXq
	 ZCW5MWZJUhKDFSthrdG9KZJwEuiZIov52O7mX/3dcEGne/5hcdGXpF6SpV4w7Os6gi/Iy
	 PBPnVbSoCAVu3Ij+1Y1/HWKpng3tDCnIkaXKNnrVsvEZw16wIMEyU/5wkQLySOdwWf1tS
	 +Gi4X07gOz2lmMBiE9dywRMfP812LdSJ/r3f0vAVAqd3ffSTT723BW+zOaRXIkyHIf9tf
	 055YMLShJ4bMAe96yOFzaFd3RxxgE1JP1vuUIL6uCftsScKI485VfWso3fgxynGPjdQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789653771;
	bh=sp4wjSJhaqaRySeRGTzifeBaqvYDsOHA+eEsA6vplNk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g+JU2PeM1Fy2gdCU/X+FSuLrDJLUmdTD6JEzPP3Gw2JAjAj8fpsbXqMqugRqkQgYl
	 hbyuICnbXf3wfxL3cu4qmcWGGsTgY22kMzN6dz3m7C1rKvXwXOhulKN1VReLKyHABS
	 1jAdKXCpzXB5zngep5INqo77c4s1RXf5+iPmPtfclDeiXYaGmL9Yu4hAWr7FNY+Y5h
	 H0KpJYDjDQlI6/XKmkQfQfGN8Ax0wytFFH8Q3G7d6mTkEHnCnmgC8Ps7W7DNbUPchT
	 guWRb5m8JfUac6mNN9txbJzA70ePjCnfaTFB86HYKWaOY6/Ke2Fd81I96V9bgwN+ht
	 EzY4VgOdsrK8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 70E9A4051F;
	Thu, 17 Sep 2026 14:02:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7F8F7465
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:02:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6256A608AD
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:02:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r8TrURsT0BsH for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 14:02:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E791460889
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789653768;
 b=GZMQG/e2rhJ937MdicoNKxe6WcbK7JzKkCfPMmG5gKWLHL+VLazowXk96ghV6eEPVjmp
 V7s97XsdKo15s4U9o+/AuXsHAFQftB+NoscnuyuXT1DmPmUlkhgQyLXvxIPPZxi1uAa8n
 CL8k90A973sUXAnZ04d1yKVqZPhma6pQs/Eq7a1BTKqO6ll/XZp44o1C+zBWX+K/0Z3lo
 wIDTL5iUM2QmPPRrDziKmvV/AGRw17/kBGdNriy0VRyRwiGHh5I/6uE7/5cndFWDdx/bi
 2axTpgSAyWbPzIS7itIEf/DBmKeXpJ3vl7u1bN+22d0IKYN6HjkMXKCPEG5zjbQpePg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789653768;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=sp4wjSJhaqaRySeRGTzifeBaqvYDsOHA+eEsA6vplNk=;
 b=gZrKQ0IGK7Uzb2qF/RXhJuVbwggjmpt6duFxptza8+MhSzNgb2/HIyQccZ397L5lxDIt
 a2FPh7r7YeiewLphQYKh1+BO0T17HP2I4LVgTLs8pYUpYVgr7cDHAWHzZ7yB1LKQFxfVp
 9OvrIaeSgZFbavxQ09Q017ywhP0F6PhkeB7T9WXl435dTYTDqpxe24Nx1NuH+K2/jW/nZ
 VevQNsWj2jZPYOd8zLnzSgabuMSB2gk4nPpUfvPVSOrBScWDgbCvvTxx2cvJlfTG0klWG
 JO9vJ4rgwB/WzFK0eQWpyWT6iK785TWNBhKWRkxVh5DN+ecAd8zp0mJik4aCjwiMm6A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=PGWXaoMW; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=PGWXaoMW
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E791460889
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:02:46 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-4843f22dc83so689791f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789653765; x=1790258565;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sp4wjSJhaqaRySeRGTzifeBaqvYDsOHA+eEsA6vplNk=;
 b=PGWXaoMWY7pSJHQqsNXx+cmpLPEgbeu6qgbhkw5vv+yF/sPTNTIiL3wL3jCkq/82ny
 87LO6tOijgqxbPVN4GpPvkpQ0KmsPIbTcfGM6pvGLZ6ZRer8NqETJyKv6neg1fOKFJDS
 zAxqEiDyg8OZaVTk6X92C4JmHM4jkHBgPLDNxeN1jKpNm11KQCDMdQVRHaDinL6jJLmU
 Kxv+JVPet5T+Qc61/A2sxNaxKufW6N+3WUNTZ8b7cv3XEepqAj/elmTQf3Xh+/1vooc8
 H5hgkj+3IOvjvtHU9iCqNiBnyc7ye1z7uKVPuWI38czGgyFDTUA0gXrZvygGzPtXdYZP
 3Tjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789653765; x=1790258565;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sp4wjSJhaqaRySeRGTzifeBaqvYDsOHA+eEsA6vplNk=;
 b=Gbd9KyKGjIzjWqakES/c5OcqpIFsNjpETKAu+qcGRRFfkutGGEXakhOfjx2H4GGNvc
 dXo6xhpeXuTHEPoI3D6QeDXcaaT7STdgcuS3qh4if1Hm8eyC0F+Pv/MaNVKqncB/x7m4
 tWyEuRNh+E4ieMuaENj47cGnhccPreCerVl7ttepWUsAqlPGHfUGPPQCuylDVzL8+/wA
 xsAVvmF0uFe4cGEF7bERDopqMUI3NSZxHaWZHIP+i2l/6vTN+fFSLTGe8jKAmYp02R+U
 4TZ2YHRl1r6OSuCCIZwNKOp051BysQroQ+4o0zUNtDiLezqglqDb8ZUY5jMRreFzerkb
 93Ag==
X-Gm-Message-State: AFuF++lZAKc7v0hsQ6HHTHDZ5UdClJR0KH1px35NCUw0GQuVa5yFcxDE
 m1T9BHAVJFVUMwboxlV5L94zjPMhPTAz13l+mm37YzDXE9tjQ9JwWJCfUj68pZLbSWM=
X-Gm-Gg: AYBFou2fmJhjdBh0y9sRYT2i8SGIvLAFlGDdBxZPQaV2M00d0k/8GKjxqOxE6H8iR7t
 GbwMQ+pVR0swMOY5Jp0pKX8MUME9H/qUSzH4RFPEMiDrO22HnJlRMi+L+MooutWoXqwjdo8+GAL
 MBAFZwDG0H60xKm/agwaT4myB2UDS6ZF0LIf3lXzPZwkALae1CMzeBOmuMk7qJ63+CSndS2WB8t
 tFUdnYHjknE5yLpryU/qOBhvvpjl1CbYdgXMJgSh52ZLmwCB1a//RpU+sp/sFf6n4jhZqcoo7zc
 c/SOWmnBMGoNDBkt8fwlwZA919qNECUawsd4y1fRtK8PKY1LglBzsnMjxS3S/WyCEdrl/By1zXk
 qTRzXsJsNfk3ztCMcRQn2GDqq1tcAyUN3XvNuIKyRhulJQITBVya4cs0hOiqYH6anMHXtW/28WH
 tC+5iFB5whfEDWX4s5I5oXoIxbig9mWVcTgD603BI9GSI5UoLThwt1o/6iM5mlusL0/h3NrnDu1
 ZfRBOdAl4S1irlmZ3J1bxiMToLxCt7v3ilQlhCgnMgCa6sEt8h4
X-Received: by 2002:a05:6000:2387:b0:487:a93:7506 with SMTP id
 ffacd0b85a97d-4870d05ac74mr9335141f8f.48.1789653764010; 
 Thu, 17 Sep 2026 07:02:44 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf344fcsm16893905f8f.26.2026.09.17.07.02.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 07:02:43 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 17 Sep 2026 18:02:22 +0400
Subject: [PATCH 01/11] boot: image: Keep the image-type table out of xPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-spl-fit-compression-v1-1-7985ac56ee9e@flipper.net>
References: <20260917-spl-fit-compression-v1-0-7985ac56ee9e@flipper.net>
In-Reply-To: <20260917-spl-fit-compression-v1-0-7985ac56ee9e@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1153; i=alchark@flipper.net;
 h=from:subject:message-id; bh=crFBkqfjXF/I0APenGdTOB8Lcn2kATBkzy1U7o/PhQo=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSt/vSLbf6dNmWTjemKtY8T2ONW7D7LYaKTy6Ow8n6ur
 ZXzSaPLHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOsY4RAxenAEz14UxGhjtsOzlZBKzskqyi0krNtxtflvl0y1j6pmd5jaRXwdGNgQz/9Hlzlrf
 ufsU74Z3jo2vVFzwrBBic9t93dWnbEz2t6sJEPgA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

print_decomp_msg() names the image it is about to unpack, which drags
uimage_type[] and its strings into any phase that links image_decomp().
That is about 2.5KB, measured on a Rockchip RK3576 SPL, spent on one line
of progress output in a phase built for size.

Name it "image" there instead. U-Boot proper is unchanged.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 boot/image.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/boot/image.c b/boot/image.c
index 185d52ba492f..a7dc69e858ad 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -416,7 +416,12 @@ void image_print_contents(const void *ptr)
 static void print_decomp_msg(int comp_type, int type, bool is_xip,
 			     ulong load)
 {
-	const char *name = genimg_get_type_name(type);
+	/*
+	 * The image-type table and its strings cost about 2.5KB, which is a
+	 * lot to spend on a progress message in a phase built for size.
+	 */
+	const char *name = IS_ENABLED(CONFIG_XPL_BUILD) ? "image" :
+			   genimg_get_type_name(type);
 
 	/* Shows "Loading Kernel Image" for example */
 	if (comp_type == IH_COMP_NONE)

-- 
2.55.0

