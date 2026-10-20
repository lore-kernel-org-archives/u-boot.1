Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C3760A2603
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 16:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=btr3tlAN;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=gqhO0VC4
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4402F81110;
	Tue, 20 Oct 2026 16:57:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yZ-flu7NCsQ4; Tue, 20 Oct 2026 16:57:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 896EF81105
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792515462;
	b=TgK7I5pfXyF/FqSt+qbtaiJ3NoZFArExbK8L5XzsQcf63yFkvNQmJrChkkphZ0PlWHW0
	 9iF50yt7L5jgbWoruUzJSNR2dk9WSm8fNPVJNY9+3ut2tpUK4gRuR/FNbnMkuMYdF1zYy
	 Y16xEZMiTdUwp/numVvX2WiCs82XEJ9kZQMeDjbY1VOLcU8FpYDERsUIvah7RE2+syGnz
	 5SX2GD7XAJK4QWHFR6qwnOKUW5gLJOYBXDrp4u9LP+eOffT4KR5+P2l1jpM6TGCWPuNK9
	 3o/pjL3XC0UdeS8owzS84W6+KlttasauOT1pT6eVPMU39m1L9ZYjtHL0liEl0LyYQ0Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792515462;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=RhUc3UD8DIneWl642VABYU0jl1zUvboeezOUj3Isiwg=;
	b=kQhUx9RO7glscQ0aRiiRmTrIhOsU3Azdg7hFrruWHlfgd93+N0xnRive3yLSBV4woVTL
	 pJv+IyD118A7AbksEVSMFC7z5YWaxohL5/5uezrUuWI+a/FSqXuTzaDm7vAXtzW/HVG9X
	 RozXQeHAaiuVdde3THv0ZOx9O6+x41WJqznDhZ4IgbVutaz9cSVUk6tq7raudCHs11RR4
	 GJbteBilUOK0vyXw4fkMuycvUMHNEyX5/ufpH07J074F0axGTV8RmwwBLr/5ISM8wQeA/
	 YNoXlVEqGLv/AlXAgVzvMrenJIEOVT6nt7sr7nMS4GGGfjAVdIvlKt5HJbq8KVCkp1g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=gqhO0VC4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792515462;
	bh=RhUc3UD8DIneWl642VABYU0jl1zUvboeezOUj3Isiwg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=btr3tlAN3LDQwOVlAWMRzypZhEHv7ydLVhKWsyTWZMaxkfXylHVwhKDwSyRNeiexU
	 ggOySVILpAa4waK7WEYN/RzvLgu7lZHm90/zOXgj8DT7qa3zVW3oSb0u2v2htd0Fz2
	 VLgESTvGOq3qv4LZY+ZA6x3b567MryvjrAVkdur8+r4RB3ewBJQfAVPqzI5slqoxkC
	 dBtoQuEBXwjbmqmHHaP1TL2izJXIZ5dcp0ZPisu0lTDdDnm+BUoweFrK5S6D7xRqsz
	 GVXwkZbJkCtbdKJkAo58U5WJe1pEOmH3e0FIteqZ8JHbE5+bO84wtsoPbNL5eEDq4e
	 KZZ2eovYzu2aQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 896EF81105;
	Tue, 20 Oct 2026 16:57:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 219671AB
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:57:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1315D81105
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:57:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LOjMZpssQuMu for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 16:57:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 551F981101
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792515459;
 b=WMMOWscW6diz2CApqau+2XzzLGT8XWvnI4gVL34lKTaqEYwjAttRtDYts/DMB5yXO3PW
 faLe74BPRFzAHOtVCyIaDiJl6EfYi+0GI0KFG/cfZMQfnrRuABzdAhuLFwscicXFBF/3F
 0W6dv4oNAnthE3P91/oiaCZCzUUQpXbxPm21PBgA4WN/W4DzW29VxsePM008FlQie+e4E
 TyDk33fAMxAZQft8NbFroIryV7ZgP04f5cQAfHP92tt6ZaXF/AuGHwi3zMYNwkC5SlTjw
 x/+wmyKT4ZqmeyBJ7xMS8fsNCGnd1V+MxcOxLVm8Ex4ec1SRrxLRNdfh2cpqrQ9UKTg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792515459;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=RhUc3UD8DIneWl642VABYU0jl1zUvboeezOUj3Isiwg=;
 b=HC0SB33Sk21ssPGCPFx1oaA4N/GA46Hu1OzsTdMbIuRiIwrNdF3Qw4mti9FoKQ894fD1
 J4WajDTbg5xl4+nyck6szqEOZM1xJl+I4D4K8gGidgpYZCVWQWzt8UauBiGUaLeLyOw8z
 u6iG6ig+TJJjwfVGc0An1+xxEBc1UD5h4qv29yQw1jLg4By+5CoTKIC/agBnU8MsIHzEE
 yB+JWr74Rw93iBAo3aizo2YkPEwvgpbhWUBKqtJAmA9h2/GGlZuze83o7ztcxB/Er4uBJ
 2tJsiBDgxOJDdMXMcaaF+87I32weq0fH2B5kLtD1Qg9S5IOTRXQTBDWaG9xut0YrsWQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=gqhO0VC4; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::332; helo=mail-ot1-x332.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=gqhO0VC4
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 551F981101
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:57:38 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7fccba9c675so1300893a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792515458; x=1793120258;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RhUc3UD8DIneWl642VABYU0jl1zUvboeezOUj3Isiwg=;
 b=gqhO0VC4A6GlNe5XTnAhFo0nlou/z7zJKhsbztR+VDu2pEInCx0Fj86D9iXfTVH4s6
 OhQaQkTZXKlC5/t/AYi/5/8Az6H/D9szNVYotWff/wZUDm09+VBpJDXDj9k6Y8zeg/+Q
 OYUjLo9wtWTCYlwJuFoJxQvU1u6qR6L1wJVw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792515458; x=1793120258;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RhUc3UD8DIneWl642VABYU0jl1zUvboeezOUj3Isiwg=;
 b=FE/Weiap3XquDMj38FgispxywekpV7cVVGioKmk+/hXJDybE0VMQNSE0Bb5SEM7M1l
 uhugHckpBCmTQ6rbBeAm2vgwqJKJHo9wEc9EEeDKMJ8fXybfgQQwCEhknU6QLlHnEEGu
 /RWJPFau3SNgkhRKEaba+AYmelMhL6gBCW/Etc/nhgYmiDYzntFtBVU54bmzQSH/o/Sx
 sjnN+KCS6PrYz/oPUlaL2kBilyu9xPBwM+4PbQ3GPaN59GGPLpy66OfDslZzF2EiOOEX
 TggWiE8rio1ijK058DVvh1rSPjcYt4YvEad+RgPDp7/chPC+gxWVf+j+ecvDUxXGAbX1
 riEA==
X-Gm-Message-State: AFq9FYJiG15wkm2ItZZUcapyoD2mqgjTjTonTWnad4mY8J42kHvWdfic
 m9xY5bSGN1mCARxgPHk/xN4e9hQnaSZWURd4O9YB9vdqw168kO31hF2SoaXDD/WJvbk2i5++nKQ
 49LonjmSaw26H
X-Gm-Gg: AYBFou2dXWSPnhW1wSlNE9Xksdw/FFIuXipWhfpw0bPnKnxtE9+WlODxz0Cbci6lX0j
 pskaHe9VgncvG5Ob/GUk7phW1PiF60d7ws9h30iN3ojKPDMfCeHYCNsFT38PwwoKGv+8+KSIjCk
 gLAJcXueNQtvl4P42v6cub3rtiCdn+SaEQo4JFVsNi0vugAAIDz+196uKGkNheKvqfgUta/50CC
 UC3v3t2SEvAil7GmzM7M2D/VB39FiKc6J//Qt5D1o3RaMx/DzwF6BUrmyR/V6HD3243fvJZi/ro
 CRyjKxfd4G8q4KNHxe9wtis5VvmzjyBG5pUxGLHRt8b8V0GIH8axf0LEUJKWB2+CAnE35ElhqHq
 NWkvG4KexVHH/ksWoGWMqzErFi3hzDLuFgWJpKzDEIf1YStoS0qxGPL29StpqGIpC0ID36LEIhM
 4HAUfYE9MFZvJ6NR9/XGPA8S6bpxFrlu7/atkh/RrQySzBH4XjG/Ey26/MDHyDBxQcG/oKyMUX2
 JrUU6Uith6vXUnm0jr4Kog/FtcFT92zk54lPkaw2FT4GU4AZMDkT1eqCtyYO3JyPAqayM1ZBc6V
 vzEvNFZYBHqsJ2p7ls2DCiyutEZK
X-Received: by 2002:a05:6808:1512:b0:4fb:b543:dc3c with SMTP id
 5614622812f47-54d847c4aafmr1850078b6e.5.1792515457865; 
 Tue, 20 Oct 2026 09:57:37 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-5388c16d862sm9993760b6e.9.2026.10.20.09.57.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 09:57:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, khaliforce <kforce@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>
In-Reply-To: <179128521949.5.18128894373298117517.uboot-uart@gmail.com>
References: <179128521949.5.18128894373298117517.uboot-uart@gmail.com>
Subject: Re: [PATCH] serial: ns16550: make probe clock enabling optional
Message-Id: <179251545698.1085247.15435811751434109923.b4-ty@konsulko.com>
Date: Tue, 20 Oct 2026 10:57:36 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 06 Oct 2026 20:14:01 +0900, khaliforce wrote:

> Some platforms need the UART clock gates enabled before NS16550
> register access. This is required by the downstream Allwinner D1
> port used on the MangoPi MQ Pro.
> 
> Add CONFIG_NS16550_CLK_ENABLE to enable the UART clocks during
> probe when explicitly selected by a platform. The option defaults
> to disabled, preserving the existing behavior on other platforms.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] serial: ns16550: make probe clock enabling optional
      commit: 70f51e1e2ea5a744e44f76b9a73741aef87edf82
-- 
Tom


