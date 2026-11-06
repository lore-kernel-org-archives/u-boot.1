Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6580B606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 22:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rSX1WVxR;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=A1n6QtvN
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 38FD0608F7;
	Fri,  6 Nov 2026 22:11:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eDihiwR10B-z; Fri,  6 Nov 2026 22:11:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8ADFD608FD
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794003078;
	b=fjjeu15fJJNBAMfz4GRmv7IbEBgJTP8Na3MjPyYaYa39ABv845R8nwmTHvRREdbbqJlQ
	 SFsG+gyCdhwPlnwfXC2gfnTW0o6IMi5uQLEOD4QQh8imEsyJppSWHFak3caI5k7NZyjNG
	 5dXgTNQqnww/1z4xbxhW3cuyNc9sPV+erWHFxi+JEmdO2HYkJSzHmOSdIU4Te6TeeJJff
	 QnfgV/2B3HR79gMQHZ6QYLg7kLglv9W2Rxcs3riECs4tVYFeyKSzhTjLcGlLJRXWCxfvG
	 3pOSOHjlxpmUryM0T3OgtW3GYje8XndLF72wXub2krsswUsdoIisGAqS2nZZ+fxCN7g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794003078;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9FyX3jLSSPd70djXzmoj9pv/78YEGLp3r4rxeu3c7Do=;
	b=pqELnnvGQTcFYf0S8A68PxAw7y1x2+e6Ul5PEJyAD4KpPP2/YPpHGRVVm06M3zV98heI
	 ZT/xGn7Jq8nT5jKMPJjRV5uu4pfDzUp/7Jkm4fT9HmOk4FdjyX6ZqcRq7+0zPlKnAVJ/Q
	 yxfZcQBhr69QgxNKeIMqXhyUBZHPfRLdSsHpXP2J8ZnY1FZ5GK0qo6V/F/LB4OY/Fou8e
	 Ll/5OsnnjmjqjU1egyikgLxmumvRk69ZFv8U3U8XRPpd44HLFc/bQk+DPlDnTlnZf5Wn/
	 66Rzz8NlGZ6LzGiyX9e/dDxx44YtLni5AAKahreXGIbJKjU9dhunpvRX2oCI/MkCg4g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794003078;
	bh=9FyX3jLSSPd70djXzmoj9pv/78YEGLp3r4rxeu3c7Do=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rSX1WVxR+UEE/CBu2sQWfRDv+pBkzhuQm7wLJm3dtWHwf1pxCNA4yQTC7cBz4SBim
	 I84Q0u7om7yI5ga/89u8tX6WWHNeAFVvnv6o1FHN7GhU6zF/iGIp80MrrVSpDHgo6P
	 sDDoZjv3gliDJ26A+wLSPNfvBFXvWhnMj1R/HLzkbieEjD/slFIMeYwEggu3qxOrLj
	 HQKeAGRV6CgCK4ZifYrS9clw4O9tyKUTNbJL5AQ49rNCxIQ59KvRJaZ0nPmm61JyCx
	 qjl0DuCH0Q1a3pjyfGTguWIQpOdWSeXvCDdzz78KFQLrAYpsQV5wcRzsk0f4pR9Hvm
	 hNazLwUsXoPtQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8ADFD608FD;
	Fri,  6 Nov 2026 22:11:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id ED60D32A
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 22:11:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DECA4407A4
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 22:11:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W2esWHFqF8OO for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 22:11:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D92B140737
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::336; helo=mail-ot1-x336.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=A1n6QtvN
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D92B140737
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 22:11:13 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-8256106635eso517028a34.0
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 14:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794003073; x=1794607873;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9FyX3jLSSPd70djXzmoj9pv/78YEGLp3r4rxeu3c7Do=;
 b=A1n6QtvNTye8Q9OVFbmiilI0nyf5SKMuPW55Dk3uW4RAn6rIbQNzlLqmlXcViQHY7s
 f1O9YgffhpbP9iNeCXUtcsKAfZMgHUqol9KKkLwDkyENj5f2fk9WoRkk0QJd15FYHDxQ
 l0wN6lAK8oC+qAdKZLGywwgnEFm9212xyPqiU5kGqELKGkHQ3RE/sYw7SwNRONGa0+Uu
 jjc5EF17ruBYCcV4M3oEvmORc972KC5MdCjSifk1i9iouXVT5Ok9c1DD1uIWOR4WyJTI
 2NA5fjR7HgP8zs9Yh3WPCTPKE4or5+psTU7d7g0X9xnKPFATVPAU2Gc5BI3BzQPYATem
 tvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794003073; x=1794607873;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9FyX3jLSSPd70djXzmoj9pv/78YEGLp3r4rxeu3c7Do=;
 b=WKqLbjFPuhjSXYPm1rgVE0ImbZNs9/1Pk/N3ToxZDyvNhhvhCLgHDatxN+VAP1JmTR
 dYkpsSE7liIWfMGD7iFFCKOdNJa2i7wZBP5ov4z3PLygmr8JolXXqkxMOvvIfOvn+ovD
 409xomDDYc7s/szSX+NY0EmU/Q4Xra8M3S9kSqo7mPzLFaWRDlkvOmxUZRk10qa1FpVk
 fRFwrw+1LSu8UZInptH/0E4RWMecaTzjT5P93WPYEEovc/BXocXS/oTUQ21QuwDkgcrk
 1aFYrtlI/q21m2p+8SJQeURK1kNw3t53CE8L+c11o9lGtc6HcGnLmzaT/7oy2nspehcP
 TMbg==
X-Gm-Message-State: APuU4Z/0Sy305usaonp+noMg+sE2mUNcS87ex5kHQgxzFogxOr/qHrZW
 s9ouNG/rx8QatINDKzbeXUQKgvTihV6ON7PDbrSkguzr3/MlowNj/V95Es+zIK7dVEE=
X-Gm-Gg: AYBFou0lhT0n1VJMPX5MpGfUSUBy+h8962QhjGb9meV+MpP/YtRn1R3gig0MSAGYWIg
 jXr3CcvwC1foRC85SrsYEFsKBuZhyGpZK3312J509Ny6TPU5StLFwMswPjbNZXvoxZlyKFGe2ER
 /uGGCbUGISLKCTQXyRisjKybcSplXF4gQFWfDi9YcgNkwtQsZwhpjiIQDBgiktEcnvPypEQjs+h
 mPotDHqyI8fD56vEoB9XI610yMEV6rfFe6nFRkMwAmy+KWtJg+ftAonUFAIwL5rpOzA4pk8W6bQ
 +g0GINgInOYWaZvuAkkrG4SVCqxuRzQ7hLfMr1nZL8GPg5cIeqwiD63MQmIHCZn5psDYGMyVEFM
 o3D5YrYpBHXR/cdCD1fr6+Fy15y6Rrq+IMKnHiyobTtLFFjBmIE4T3jdXzAd42JQYsrLmfEjfBC
 BbsRD9thURTAyB4y2zNcKA0frvY7aSFSW4n4D0TuyZGFb0/3n3dG7hCG0e1MXPkwxg8UU9nX/Wm
 qgf+g3rqduc/Ky+dlBvrbzD1biWrQUR3ysR1xrk/4PYon0GitaAEJTi760810ppnTEuxJ7/9r+L
 I4vU6FO9m6SYA1MvqmNje8SYmzIWq80eDn1J8MoxdPbzVqtgj8hnfi0=
X-Received: by 2002:a05:6830:44ab:b0:83c:2a05:c65d with SMTP id
 46e09a7af769-85f1cf8ac52mr3751883a34.18.1794003072985; 
 Fri, 06 Nov 2026 14:11:12 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:ce15:58eb:7458:e922])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85f1dd1a172sm2999299a34.15.2026.11.06.14.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 14:11:12 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 1/9] spl: ufs: rename SPL_UFS_SUPPORT config to SPL_UFS
From: David Lechner <dlechner@baylibre.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Johan Jonker <jbx6244@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, Anshul Dalal <anshuld@ti.com>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Michael Srba <Michael.Srba@seznam.cz>, Jonas Karlman <jonas@kwiboo.se>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alexey Charkov <alchark@flipper.net>, Peng Fan <peng.fan@nxp.com>, 
 Daniel Golle <daniel@makrotopia.org>
In-Reply-To: <20261019-spl_ufs-v4-1-61432d0b258c@oss.qualcomm.com>
References: <20261019-spl_ufs-v4-0-61432d0b258c@oss.qualcomm.com>
 <20261019-spl_ufs-v4-1-61432d0b258c@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 16:10:55 -0600
Message-Id: <179400305526.3924283.2925980655316496453.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=508; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=n8kHOGHhQJ76Ne49b9s91Hh6/RnSJuwaXky3FG0OKSw=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq7lB2xdRbdD/dtFsL02h8MtBdsmlfmpNLltDwN
 Ii4tx6urA6JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCau5QdhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AzJ4IAIpR4lfBKI5YC8ks0VbvpUBdPhqopf4hJO6rA4h
 HVeSEkaj6gKqDh3S0OptKuH91F9ttqFOFF9SRPt6WpLeqRdU6+0AvDOVA913h4YdUU7W7glSFJr
 MZbe2AKdFsYrTxEQ6Cy/3hSIQYCX1u1a23dzzI6iyV/InduIK6orTvU/DvwGFNhgGykqrwG8qGk
 r6h66CBzGYr2ZB3t7a/MwT1ptWogG7HgxBKcuz2xIEfXalK/E+eBz1DbGwDyxeigvW1zEmLSAsd
 HJXKiJc1TO4giUqxxp4B5TrgcZI8akTeKIbi6z0aVxjNurIKPEDKRQsnLS65CSAW/x+kEqbPdds
 6LD0=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

> Rename the Kconfig symbol SPL_UFS_SUPPORT to SPL_UFS to align with
> the naming convention used by other SPL storage drivers (e.g.,
> SPL_SATA, SPL_MMC). This shorter name also works cleanly with the
> $(PHASE_) prefix macro in Makefiles, allowing uniform use of
> CONFIG_$(PHASE_)UFS across SPL and TPL build rules.
> 

While trying this patch, I noticed that there is this symbol in
arch/arm/dts/rk3576-u-boot.dtsi that needs to be renamed as well.

-- 
David Lechner <dlechner@baylibre.com>
