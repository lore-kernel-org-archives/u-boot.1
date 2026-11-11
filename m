Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634C4606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 21:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kQVFWnQi;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Cuq7V8hs
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E1BB240D5E;
	Wed, 11 Nov 2026 21:26:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6y4hkGsD6-Yn; Wed, 11 Nov 2026 21:26:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2D47740D4F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794432375;
	b=EWYpnF95Im/5ZEblKIADzoM/nHOmhmkYUL9JNH5y+BXdFSMGAxYzIVr/iEccdydVoRMu
	 mxY1HNSmPeqOSQqYXqy0XDShtlLlnVsj1pdjtu4eacsF0loTezSdLaK/zywh99kupRmRL
	 ugy+4QQXc6WjJbAZCUwA0TkApws6ZL1TaD/GbI+mhJVyjQCUSX/3jW34PNhpcNcriUW8y
	 H0K1C5ZwVvAkyOfUgPKGLVBQpGFQygb22kRGwxUXS78J1TA0dT0kN7bj73N/4xyopAR+l
	 xtNk0240kc+2L3ehnd+9hoSPV/3RRR1uqo/wUWysRfGaUnQ8xsqTStRxIhBNhFfWdMQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794432375;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=K50Hh1hvYtC5ilbNm2Rg5vLepnd14XhKF6dnZEukOyw=;
	b=k779AhsQkMOFTsJktVyw9DgcolGLJ8FB+7OaGTcBIbdoZm7obNzdsgUWY+Ip4lMlQu09
	 39X1SqS+3mR9/o7dZfAHqBS8Il6VRIqgirgoJGW+n0lVNCbVsDgp5RMxi39zKMMWkeBA0
	 tSlzJZCQYgvz1ATI5Y+HRC2VBtDBLqITiyMwCL7HoagfOgDhdpGTlBNvUZxU/zDc6z11W
	 GHZ60FUKCYDE0b2heeY+uGzkdqoesto+31QUu4+Ed25sud0R1NrfaBHftAmpaPfBmgW7z
	 2M2gOKbRKlgo0rUDsIiNy8xIE9J+FUFAB9LBZtyXBVC9ia70Auur5sDt5sC4pkFQcoA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794432375;
	bh=K50Hh1hvYtC5ilbNm2Rg5vLepnd14XhKF6dnZEukOyw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kQVFWnQiurRJny5nPx7GDA21ZwKxyjLYvbNo762ABXDnK+WdIjzECZTIBrUoxJJ4E
	 zi1YuIY5UMeGa7/ziuYYfXQt9xOR+K3tq4sXntEJnSal4G+OkgpD2IuHxRkp4x1Cik
	 02Yg0UFnzW3doQAkWvt3jtLhT6DhUwyzv/FbgabPbLUrjpFyXQYCvSC3sHi3gCZItE
	 LMyp/GlOu672JR1moyJjbA4hSGapX+rMIb7AQYgL7l47kPoPlZ4LcIty+irtSJ2D4m
	 zNdcXyIfY6sIq8rKWL0tXciqHWGunCE/BOS2Eut73AxWou2siAsTNAkIuZkUkMLn7y
	 XaRNulrDEUD5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2D47740D4F;
	Wed, 11 Nov 2026 21:26:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E137CF22
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 21:26:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D391B400AF
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 21:26:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r0RxX8Cty0Mj for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 21:26:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 247564016D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=Cuq7V8hs
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 247564016D
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 21:26:09 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-82109f51565so1579520a34.2
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 13:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794432369; x=1795037169;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K50Hh1hvYtC5ilbNm2Rg5vLepnd14XhKF6dnZEukOyw=;
 b=Cuq7V8hsAeJJ9OotEN3cl5dbQ7SwQUEhmYR54xfBCHx++RC29TTIjj3A6KPifOxj9P
 Bropa3Zrr70egGlO1G2wnzlGwh0PzO8EwWLvNGr/H9Z/tkuzDbNwZyJM6FYop2NnEmP5
 esqa01xuyTK6yjU1U4wAvfY/ZBGaENRROXZ3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794432369; x=1795037169;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K50Hh1hvYtC5ilbNm2Rg5vLepnd14XhKF6dnZEukOyw=;
 b=EfxLvslu7t/BY1SmBeBieQrXoiBr37EU4VbdXGaR6i6uFRg20jcgHqXjtNHV8yIqns
 KGGPR1HD/iF+ZgtubyfOfM2ICEAgl8PPKV7yGxFTUirTozMLRJ3rW7EjADonkKWLUTff
 YN7IlBNxyDtKR4mSTqI+4aNkFA6wZVUVbnemI5Kjvdei25WQ9TMLdEaWJm/Ve9MKT7IK
 pqiZUEw1JHW7BkjOhcDcxr0kwqpMJ6FO6RVo21vkHVmvFE3rz95zkL+Z1KGdEkVARYCG
 /n2etENYLU7yIR8N0pdkN0LAb6hJ6NDbHYK4CVNFrggaMxe+47SngSpfZo3CYxhW1eq9
 KF3g==
X-Forwarded-Encrypted: i=1;
 AL+hErF+t0wKSGRGdM3SUo2z8Csblk5+2407LORNTjAtlvT99xvqZvU/oJViZfDxNJQju2x0tem6NK0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/lW2x2JHjK6HahLQKhJjKjGdoZfzEfoLXkaacWLu6bwhzqPVD5
 bat1YctoPIukN89Vjp9mZaRG0LMntklz62b7nn61BpgDzBrI5KMXnL9lsCiBBk1TeycPHvedFi3
 devjleciIGmeu
X-Gm-Gg: AYBFou2AV0MEETSkQ1dOkKViPIiYuD6G3O4M01ZqsrwurmiGsnXd1gBV9hZldjY6tRE
 pNMI4fBkWh3YJfLb3sp0lomIjHiXOhAe+0zEK6q3+Y/kwtC9m43CXnUrxXf17eq9AloPaA7qQ7M
 iDnLjpNzh2YSRYGdW46Ayn4A9Bs6sxEyaCkyDVUjIGThZh3LuV7GXwql63BdhFWOjsEZbPJAesj
 XqFwphwFzA0ug5WcuWEr1/Q0riEcmyhp2RdjXpjJfqz1wi0AOTCnWnjrD2w5j7jG9pSCJvflVO8
 0yuWxpJ61tx98NXemzXbaFOaG7PsBe72txVfsc6M2nfBChwzlA6PGJJFWMfo6gBZhQ/O/GPbls/
 Do3weoxezwnd88ipVmgSoC6EH4oyGQgtBqBTj6FgFd7RA9p6OthUDX3jzRsVenAiYStWyAxKvjk
 hO/j47xO82TKCq14ZJsYUMB0ORR5vJldK0NTNrG/SU3FjDy9bxUuhpOliIi5M3ASE6RECq41AqM
 rpwt+Cl/wAfk1X5m3/AjKrGIwth6EH9UJNAsgULhEYCLXaiPUxTLU8W8C2UA8kgsoBF9ST1cptk
 zEt6Sp/rGw76tX9U2UTF3+ozIoEj26/s2aASW0Nu699zvKD489i6Cg3a4SYV45kDou3GC/WEAGH
 +QmqVWdDg+G26a6uNRrG4K0GiHp2kx+QHTMuTmuQOLikxB+aHdP3hVR4LxhEJyjuZZWzAEDX7mH
 kNjGtEsa2QMglrIpG1x+ejATJAf1RE8Q==
X-Received: by 2002:a05:6830:4c05:b0:7fa:ab72:9e01 with SMTP id
 46e09a7af769-860f29bec58mr3545456a34.25.1794432368753; 
 Wed, 11 Nov 2026 13:26:08 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-860dcbbf1d6sm5205628a34.13.2026.11.11.13.26.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 13:26:08 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Joao Marcos Costa <joaomarcos.costa@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Oscar Deschamps <odeschamps.mail@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Allan ELKAIM <allan.elkaim@gmail.com>, u-boot@lists.u-boot-project.org
In-Reply-To: <20261028134427.405740-1-odeschamps.mail@gmail.com>
References: <20261028134427.405740-1-odeschamps.mail@gmail.com>
Subject: Re: [PATCH] fs/squashfs: fix NULL dereference on failed symlink
 resolution
Message-Id: <179443236796.664252.1618150597398787736.b4-ty@konsulko.com>
Date: Wed, 11 Nov 2026 15:26:07 -0600
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 28 Oct 2026 14:44:27 +0100, Oscar Deschamps wrote:

> sqfs_resolve_symlink() can return NULL, on its symlink_size overflow
> guard or on an allocation failure. sqfs_read_nest() and sqfs_size_nest()
> use the result without checking it, unlike sqfs_search_dir(), and the
> NULL reaches sqfs_split_path() which dereferences path[0]. A crafted or
> corrupted image can thus crash U-Boot (a NULL read) while reading or
> sizing a file through a symlink.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] fs/squashfs: fix NULL dereference on failed symlink resolution
      commit: 351e0e1e4c8dee49e24868a2e7bb624d5f8bf0fe
-- 
Tom


