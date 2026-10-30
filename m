Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C71606A31C
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 11:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=a3bmbQ3o;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0KqsBGUW
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F2D26079F;
	Fri, 30 Oct 2026 11:08:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1kHCalt8xOo1; Fri, 30 Oct 2026 11:08:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BB2B560690
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793358519;
	b=mLduXhtu7IFoj5rw0GuO8k9JkRupvOTZZnlcL/qgnPKK9DxHaU1YUaxzE8sdqGVntYyz
	 ZJl74XxMG2cCEu66L/ivjADkYpRXuFRp05ybsOGUfV41yL3gE0RE/ab2wcp+b3I8ZATas
	 0GXIgw6raakA6PbLsnKo1Tu3PkHd2o9hINzwf6YeOeXDTkdB+/YbSN/Y+ob67d0WWLDX8
	 YtevBkEmNGs+PK0ESZh/v0SQ9Nh8eIsNJ5VWjB/zV1sQ+OX31NR73F+Y9rcXAYOROjFRj
	 mK/UNj5KtmLfTtGeN3P/46cgeS3z8qnlkDN8o8vK8WlBCnMfATIStC8OUJR4t7+IABQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793358519;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=m10ekB6GdPma/xpptnNVjw+Re8uDpbIaw0XRpfCKgrQ=;
	b=W8L9ikqG09rGLruF/PY0hdsZ98dWld6kUFDOp6zi1N9dQPvLSo1cs8orvGeqF3aqtbIF
	 d4tryBuct9xBbNtfaTXZXLEXgIXHCrAh0P4Hgnh6IrUvk8ga/Y7sHssptcOlt9f80zk8A
	 OzWdEoRb0unhLqVF3Hdiy2mQzeaPHTM+hc//6Uve5JvOe9xh0M/bmAjWkq9aded8dX/ry
	 6ynq9R76wbU11tjYq3kfevagLqUtTpLFNjRsdOpn42rvRcSRFt45TjzfVF6mtucEdojDG
	 EnvBR+sm9Q1b3rwKRsJWNNDOO70eN711KOzBozeAD2u7vXD7XRh5+XIPIwJvFojO3kw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793358519;
	bh=m10ekB6GdPma/xpptnNVjw+Re8uDpbIaw0XRpfCKgrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a3bmbQ3oClz3ASvx4/hVoS7vQe1z4HBNepcpi/2kfphTc60v/nAQSCkiSZ0027m42
	 wqw4FJcjp012OlCIx+X37Z63bgMnV6g74cbZdlV7o/NQfmRESiwxE/3Imfyus+YRep
	 lXFeAtlaRKm/CyJplh0Y8M5ggLq4g2vVw5qrr4U/mX5TT7snCMA3rdgIHt0mGVgz9w
	 NB9YlWzNQbbVpbwlQvOBrpjAFvWhbXqjhDB2t6HKszqQEQ0W0xQ/TNVACWG6aXNOA5
	 Q//o8z5iOYGWd34a2vyKeMogLIhjpM2YU2agQg0QAhscWCHm8XdsNJabkZN4UUmh05
	 H2mgnNJevyXCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB2B560690;
	Fri, 30 Oct 2026 11:08:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1600E235
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 11:08:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F05874053A
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 11:08:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qMBnvxHIXBnv for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 11:08:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 49864404F4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a2a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793358517;
 b=o9AwnKokCWZLX+49VCC7AkZoGy+hyLcxS2dzhqFxZxLHADnGSOpf+OjGZs2SkuILVZqb
 1XLsa6bHPS7gQdUsIOO6ddEkwcT3DD4r1dATZ1Eh5zdSaTKzQ/qy+ReKGgh/TZ2z80Lsd
 4pb9oX+hrZpaBUp6G6awQGwCTfd4vj1ZC/NxAcGW2K0MjMG9BLU62Kld2PheaL1odlSXL
 2v2df7+SE6n2dFHdgHgISX4IlU4nPTffDPoRn1v/xOdGJr0nPsS65Ag9NH8sggK0auyQq
 BwwprauDDm+CiYJuhapWXD0D9zV3cmH+sqK2PKy5/9H2syaVop24cq3hV0p9Vr8EQwQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793358517;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=m10ekB6GdPma/xpptnNVjw+Re8uDpbIaw0XRpfCKgrQ=;
 b=sJWxuEw9IrMMYKe8H7+xpBHhc9M0jk37h+DhTvUqSnKCvVQcq+ghlwTQy87DqLSxJ6UY
 2aO4htHjNNfhk58cHpCRoK0NJzvNCoj0G91sn3v52Rb98NJBwpE1rgPL6jbnnxMKt8LJY
 tbxb3FZVKqZAUqh2ljhD84pDPD3j6DDzDfBMhZ9mMaGNzk+wzv2B0w4uGYfheuNR/314G
 YNdPAoJjt/6IpkIOrrk7nBK5Zn16cgUk4U/UKUET5CntPjPAqSilr2x4jVzwwzAv6tAeQ
 rAZrGAmu+KiDIrkqu3YEZr8aLzSzDp8PYWoaEDCRn7l0ypNfUBqc9VY84rX+uUI4ILg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=0KqsBGUW; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a2a; helo=mail-vk1-xa2a.google.com;
 envelope-from=vinicius.eduardo.pedrosa@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=0KqsBGUW
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com
 [IPv6:2607:f8b0:4864:20::a2a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 49864404F4
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 11:08:36 +0000 (UTC)
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-5ec3561ad43so391740e0c.0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 04:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793358515; x=1793963315;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=m10ekB6GdPma/xpptnNVjw+Re8uDpbIaw0XRpfCKgrQ=;
 b=0KqsBGUWQYp+K1Nwa0wf0nCFDBL+8dANcgj6rKzRX0PzoZjWIk2OFAaxtNXYBWl7pK
 RatZLB4WOKoNvQ72JfoQtIoL/nXHjGspDDX41xKbYsSJdYUNDqh9FyHOl5dIUmUyJxlH
 2vJSFdC5d37QZQXdh4hMO/PvKzjhPMpkrstiriAbPB+3iV4ZIG2AGJLSUt/kvME661GY
 VyMfVW61TH9qPR00ru9ni1qkVQL3ZsecLYZAq3Yvt3E0X0DbAU6Xc9yvRqUEAuGOQ4O3
 guiJDG4u4u1T0G1VO1K6bJvEDO3B2ScTfrksgNPlVuQsx3agpiEsgJyMRR0ufGi91qbw
 Q5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793358515; x=1793963315;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m10ekB6GdPma/xpptnNVjw+Re8uDpbIaw0XRpfCKgrQ=;
 b=Ig6kHnCLPRJoTi1g35T2Bty0UHewQ97judAPPyXXbYKaJzFOSXp4ObxzF78FOTxX+X
 ZZCqDaCowgULi3trEPrH2wvmbAScPQ2fWm/ZOyJlKvsYue1h1WY6m4nraoWR0JovOWcp
 +zfzmPjAMXLS78FC5Ypcg5TN1vUUXZeAbCza+75eH77yUbgydjPINRUn4aaaTnffLd2N
 AXCYJe8+2nWijfQBKghI1GJ8TK2+bmHqEA6KukljR/K8LfH8NR8+X3vu49YOYabFz3Xg
 Q18OlO/rhqt3RbyF8HDi1AAIwXFtw5gzSIdhe7J/ZhEjAiGD344hxS5IBArPAknWu6lT
 mUOQ==
X-Gm-Message-State: AFq9FYILTRgetm62bVUV/BumicL3KA8gEp9kzPIRQ9KMKFy9P21tNReb
 5C5RWdiEi4b2/rDFfgYzPPMejFA2TIDVEUvLav6gqyFZftJri1zwzJFC
X-Gm-Gg: AYBFou0n2H/mh8qLTCASkqukaoEYLdSG5D4BWcoPman20af2Ki+lccTl5wT7mW5Fsxk
 PmUmjDKm6Csa9aG/Tpq0FGKOr1TvZ1wDeeOPN/UJw3yUkpHwd5fwvACIF0Z16AwYgD0NsMFG7r1
 DwtKI+yxsIWOYBEvsYvlcV1bIrEe62INMg6Y4V8973V/1RdtYOlRby2OT2ui6CZbExsR4Ql1Fa1
 jum9e4/jT78TFHr08VYu//NW4FyjuZJt8L/0Dcl0S9KCx7PYYEYhOYIYZ/LRNJfaFWHgO07aSwy
 xHcUedxSgBb1e/ojVGfPg36dnw3EZ2eFioZbjaJFG5ucTUnDwa+uzSMp1sCKFFym1ntmlQgzBLn
 pofsHnW52Uyu+kgUunwhbvSGz7b2QPTlHM2fuBIpoftFrx7lNJCzpzNJy4s9D4A7naNSwydGGZc
 wV6bWm76R0EEaRmaTTM0Ex/DOFdMRSwDKF/YKjTlz+hvKTDtxk29Ks/3hqqS3mPJSYNLJI8OO79
 xf30vyVmtusxyGLw4d5xuoN4tdxlukiio9seKeG7vZv9WL6ZNUS48XN2Jm/7d/224Fuq7iGTD1/
 AWrZfO/IIHFNQ2zuORgMbsQq4MmsOdIAAFlznbAKL8440S4FpDOPLjaPY/SaF/Gx7mfeiR8onbX
 a71LQaPwli+ceYvMatt4J/uiTjvUmrgEd+tBN
X-Received: by 2002:a05:6122:4d87:b0:5e9:176f:a548 with SMTP id
 71dfb90a1353d-5ec68297713mr977570e0c.0.1793358515513; 
 Fri, 30 Oct 2026 04:08:35 -0700 (PDT)
Received: from MaquinaLab.. ([179.179.238.247])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5ec69bba011sm2020349e0c.5.2026.10.30.04.08.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 04:08:34 -0700 (PDT)
From: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
To: =?UTF-8?q?S=C3=B6ren=20Hantel?= <fugininsane@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.u-boot-project.org, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 =?UTF-8?q?S=C3=B6ren=20Hantel?= <fugininsane@googlemail.com>
Subject: Re: [PATCH] sunxi: Fix misspelled NCAT2 config guard in gpio_init
Date: Fri, 30 Oct 2026 08:08:17 -0300
Message-ID: <20261030110817.74836-1-vinicius.eduardo.pedrosa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723105705.3338923-1-fugininsane@googlemail.com>
References: <20260723105705.3338923-1-fugininsane@googlemail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Sören, Andre,

The Kconfig spelling fix looks correct, but I think enabling that path
in gpio_init() needs another look. I ran into this while looking at the
A733, which also selects NCAT2.

The code copies PIO+0x348 to PIO+0x340, using the H6 power-mode offsets.
That matches the R528/T113 layout, but on the A523 family the power-mode
registers are at 0x388/0x380 instead. So the fix would make the SPL
write a different register at 0x340 on boards that are already supported
upstream.

I built U-Boot next (ed869863) with and without the patch for avaota-a1,
radxa-cubie-a5e and mangopi_mq_r. The copy isn't in any of the SPLs
before the patch and is in all three after it.

I haven't tested this on A523 hardware, so I can't report a boot
failure. But the register layout suggests the copy should be limited to
SoCs where those offsets are valid, rather than enabled for all NCAT2.

Thanks,
Vinicius
