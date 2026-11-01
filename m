Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14256606A325
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 21:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dD52i6SO;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pbrL/1KM
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E14EB405CC;
	Sun,  1 Nov 2026 21:06:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m-_Y2HY6CS2d; Sun,  1 Nov 2026 21:06:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 32199405DD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793567173;
	b=C49JGtJ1/LBrGBLdndgb4X9KTDqjPQVIUls7cS6OWLipleRJssu92Nkuh9agCqKL3VYm
	 q+QBkxo5MF5dGOTT1tTGHT6IbB/I3sYQTdvfbGV0zO1fw4yYQNdGUzPOw+SH3HnOM76Z0
	 td/2n6QCjyHlBEHWPiGij2N1vbH07JdpjQSUwGh56luq26NRzvYjz1iDicG1A1gPTw/yB
	 ZE9vFsGVsni2jrz/2weeFR3rI3O4mj05+fkdzoUBe1ZzDabUA0a9w3hBTJSISPKx3jhiJ
	 7oAL5d2g8FSi9jG6NLXxBNb/OCEv61cIkCA9hJb0ukXwDYcT39S+KEe4e1N/eoRl+eQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793567173;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WLV8I4X6BRhsBoikn4uDRgSP6hzU3RFcNKv8sRJIRes=;
	b=pBSSaZhUFuciJEZmpfsxnIZWGY0PJeDWCbhSXrrmNaR+TzGFbDll2ruyymR03+GscTBo
	 Hb3rUR8id3HOnl2wG+jFNmddJf/OAdMFCBjQlABM039POjz+mok65G2WtovewYMXKkZvG
	 rhWGiiTNqguOv5LHlab1i8TZZetC6RjgyaL1R0LN2AurJDRcEyBLmeks24f4G53LLynxg
	 8qkpetnxh+dCcZsNnO7SZZupIz2DQqDsOmD6Kd4Goh11tZkYWJ7gDzJw6xzDdqcJkJKlq
	 MXy5d6PwAFmdY/nYS9jnuXBzd6lfAqfQ5OVbRC9W+HWUrTexQ4voOSb5bJMw8eaaFrg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793567173;
	bh=WLV8I4X6BRhsBoikn4uDRgSP6hzU3RFcNKv8sRJIRes=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dD52i6SOgghxqcwoSUQ5UJI6V+ikV/WoYq4xT5xljPrxUdEtQwi3kr4Udu0JMubKJ
	 J1OU/Z3iaap3jyQcoGmuo6mp/sSx04XG9A16pLo5bHc40UGrJKFYEvQBpR7uFunyu8
	 yk/5kIBxh/vvKWjK8sAzzPaLrG+/iQUcP80uGRctChwDNl3od1pf2qOvThcDbqQzTS
	 iONUN0H1+xQr4Wbce370bbuT19jDBxm8k2RXzVIoV3C5R/XBRNeLuXcRknkul3gpEc
	 ovo1DZVxTaa+b4CuMxY5LJROBt71tI2SUAe4/SYGPbt75XTCD7iYlrb4X7/VYGOKnG
	 ZgRTLaMkyqvmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 32199405DD;
	Sun,  1 Nov 2026 21:06:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id F39EF4B7
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 18:55:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E57076060D
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 18:55:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id afgca0MaWSJm for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 18:55:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 42C6F60602
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793559304;
 b=LIKQxgVq9Pa6EtCmLZEtO3Ge4Eaka6lTlvz3hObLvIQ05lpzBqwDaRLOELnXunQk1NFC
 RX8jrhLVEdog1RTyrqO4vNwxwhFjDZ9blUGizSU2CQCanNMyiK7/texktKJwAV3OHaDbG
 wOTynxJaWZLg9cptXWNxbsGAGnB0IcqWj7jMD6WMj+0X1tMfGQGlwwyT2Jr9n53XpVbOc
 WdJx53Rf5k67I3POXx4cAecTFhc9NkyinQMCDW2jznwaYO4wKPnUlJmdfsR17LVr3D4mW
 2GK8GK1k0fl78jlwWmYYbfB8WoB7s+yMYHcp8QjebGHH7LA17XZRYH3V1RiOQwi9hWA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793559304;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=WLV8I4X6BRhsBoikn4uDRgSP6hzU3RFcNKv8sRJIRes=;
 b=PnUAmF6icuftN8JSALpmH0RUYz2LC9cRVVjKm3QAJRYvWZhD3GfvYKmpDMD6VFomhV8w
 4kdLfYF54GlCm0i+OTeIRHXRDcSNtcr3oyAqsmTQON5lReyQIGyMOpXpt+lgG+Zq2Rd5F
 +56Olz0qtZSxVmijye3DPut77ZUjvMGdsoMRGBrzkCHwLLSvvsA4cUH8j9e/4AGONZF3N
 Q62pm5ic5Z6w1HePByB1qPCC5jBmfeQYHuLvwXyKq3nlkTcgvEPMlk4VgHRpyZ4F+o62Z
 Q5Fen202iegkn1ydrKA+ZQPZmxP20xqA5NpgU/J7I3fepIZSOdb/+lulmonbrmaqbIw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b="pbrL/1KM"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com;
 envelope-from=asai.6265@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=pbrL/1KM
Received: from mail-dy1-x1331.google.com (mail-dy1-x1331.google.com
 [IPv6:2607:f8b0:4864:20::1331])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 42C6F60602
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 18:55:03 +0000 (UTC)
Received: by mail-dy1-x1331.google.com with SMTP id
 5a478bee46e88-369f3e9e431so1635623eec.1
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 10:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793559303; x=1794164103;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WLV8I4X6BRhsBoikn4uDRgSP6hzU3RFcNKv8sRJIRes=;
 b=pbrL/1KM26pBLGVsnQuk0MuB2aMkVjgsSBxDgAN0/AUjtNjEzl6yaq4pHcFZzcwFvU
 wmmzbVUgsZvttzSX2KQOUpi507k/JG7HXo7TkqXeG+LpKGfiWNNxd8FPD+PjRsmgVR40
 RVn9mBR2MCLjQAr54PZkTq7rV02MgVEqhqrugPpeU2d0/yGUPoO126HOrjwLsw4SprdA
 yMqEyU9EXvem8IIGkHUitSG3634FHSQxYaav5Dc6l0PDMzWvvgRH+F+hH7TOQYrXqVtF
 46Tmn7zqCTPWmYPwHHy8tYtKJC5qCMW0WqYpMwXOqYI5rZ8FMjkXab72mapedMNI5kj4
 jWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793559303; x=1794164103;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WLV8I4X6BRhsBoikn4uDRgSP6hzU3RFcNKv8sRJIRes=;
 b=rc5lKhge3ZONpF21nvyZlRyj2HoNd65F9AJVjh9fq87Y2hYGnV9C+OpSiRbD4xa2sg
 iSZHH9tUGSa0bm026+XGo3sREFxOOfzjXFXakZO96NpYJ0YjLelBDpmRDjoL05ca4Ggp
 Ta/dul4LD8P/ES3HSy8Dpwi1BktCRQsMA0Xa430vxVmv52+bFFMrqCHD6MHgTxAODoQr
 SfwJpk5hBRFZiKRH1g6xKJkyxMOUlrj9Q5NtrWXpaEU1H5khy2mIhNUhQSzzCTEW+cPQ
 W5jGn4MsAkq17YXZAHlHysd4Xty7xoXZAQCD3fKT/Zb1w+XncT0mjoeyj/trCklkNM+P
 0vvA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwyH9bYgNpx+Vqv84IxVBBJOU8bR3BDv2D1HQ7mAC2fnrgXSD4M0DCF87/p7u3TSOAteZ1GkSk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJYtR785nrtDZSHFDv+VmKqF/kQKaNT+dvQUqIJm0BUM9i+/97N
 BNrmhp4f7jkQaF/2mUX/zLc0LIns6cxW425gzYi5FsndmAYRN1lIG7Jd
X-Gm-Gg: AYBFou2Eohqzo92yDwRLHPteazgoTWExmffKNwP29kZUEAZa29wbmH5uUlUb3v3bt9M
 ceNq8+foDUFh0zflH7/gQYaaWGA4E7Zx1h2E3HThpmVJiFX13+lOMj/Qzte0wgx9tWuAcTfrFQp
 1nC5u/cUGuIcrCRlHfzgR/nQguNYLIDW8+xkLGWvSHqlEmYn5V2RouSuaAj43UWCAfl63K+jj5C
 xD7BVWkl4yvCSEYqo9MXsKaREVv8Vcx8ROlqVZMkHFmIdXrKVfAFEI+ufZsQv9IBE0F8L4uzDO5
 ypkR8mHscKqTRBrSSIX263ENh5AkTybuVRAyJ9b5vE++f1Ym1EU8z9cPw/MP881Qx6uu53c+Lrc
 oU8dWh4jRMa+nDv5OE0gAqVjOREAi1Hlal+RRhtm1+Sgb+idlPI9sHtblibTU9vaQrlElXXcTXz
 Jptekk88o2AN840PNaOR4ixGl+80ErEHk2sHk+ZwJOVI0c0Ci7cVBlxu+w4nYF3TSZXRtCZriTV
 R9mlTwD7vUAS1jQJjTg0DPaCG6p9vvwJokks/QC7zYA2vKXDaofQYujPhQ+Vg2VoXPt0tpKp/je
 aZFownWcmDfeEcKt8ncmWCIV5y9vWawYRuyp+feKI8GHpzqV9k7TDRRogotxHA==
X-Received: by 2002:a05:7301:fc03:b0:351:77a3:55f1 with SMTP id
 5a478bee46e88-36a3005344emr16370801eec.19.1793559302625; 
 Sun, 01 Nov 2026 10:55:02 -0800 (PST)
Received: from X870E-AORUS-MASTER.kkp-group.com
 ([2400:4053:d960:1a00:6c8d:b67c:1d31:546e])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42a6f7f9sm34800309eec.25.2026.11.01.10.55.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 10:55:02 -0800 (PST)
From: Shigeaki Asai <asai.6265@gmail.com>
To: Kever Yang <kever.yang@rock-chips.com>, Quentin Schulz <u-boot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Shigeaki Asai <y-asai.0816@docomonet.jp>
Subject: [RESEND PATCH 0/2] ram: rk3399: Fix LPDDR4 tRFCab for high-density
 devices
Date: Mon,  2 Nov 2026 03:54:39 +0900
Message-ID: <20261101185441.755448-1-asai.6265@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 01 Nov 2026 21:06:10 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Shigeaki Asai <y-asai.0816@docomonet.jp>

Resending, as the original posting was rejected by the mailing list
(the sender's mail server was blocked by Spamhaus). No changes.

Some ROCK 4C+ boards fail to boot with mainline U-Boot. TPL completes,
but SPL never starts:

  U-Boot TPL 2027.01-rc1-00126-g3401e006432a
  ...
  Channel 0: LPDDR4, 400MHz
  BW=32 Col=10 Bk=8 CS0 Row=16 CS=1 Die BW=16 Size=2048MB
  Channel 1: LPDDR4, 400MHz
  BW=32 Col=10 Bk=8 CS0 Row=16 CS=1 Die BW=16 Size=2048MB
  256B stride
  lpddr4_set_rate: change freq to 800MHz 1, 0
  Trying to boot from BOOTROM
  Returning to boot ROM...
  [SPL does not start]

The cause is tRFCab in rk3399-sdram-lpddr4-100.dtsi, which is 180ns.
JEDEC requires 280ns for 8Gb per channel devices, which this board
uses.

This dtsi is shared by other RK3399 boards. Boards that boot today may
still be out of spec: the ROCK 4SE boots with 180ns, but it reports
MR8=0x10 (8Gb per channel), so it also needs 280ns.

Patch 1 sets the default tRFCab to 380ns, which is valid for all
densities. This alone fixes the ROCK 4C+.
Patch 2 reads MR8 after DRAM init and selects the JEDEC value for the
density, so smaller devices do not pay for the longer tRFCab.

Tested on main (2027.01-rc1):
- ROCK 4C+ (MT53E512M32D2NP): fails without the series, boots with
  patch 1 alone and with both patches.
- ROCK 4SE (MT53E512M32D4NQ): boots with and without the series.

I could not test devices of 4Gb per channel or less, where patch 2
selects 180ns. Testing on such boards would be appreciated.

Shigeaki Asai (2):
  ram: rk3399: Use the maximum LPDDR4 tRFCab as the default
  ram: rk3399: Select LPDDR4 tRFCab from MR8 density

 arch/arm/dts/rk3399-sdram-lpddr4-100.dtsi | 20 +++----
 drivers/ram/rockchip/sdram_rk3399.c       | 64 +++++++++++++++++++++++
 2 files changed, 74 insertions(+), 10 deletions(-)

-- 
2.43.0

