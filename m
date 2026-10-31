Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DAD606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 08:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=chhNHOV5;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=TyTNZSa3
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 176C960A88;
	Sat, 31 Oct 2026 08:44:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IoNN1ZieiHYN; Sat, 31 Oct 2026 08:44:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 43982607A0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793436256;
	b=asM0iovcx6geYSN0vKgT9skHsygUTEuTCmoGYy8knlUb22NEGtQM6C3yn5hMj/1pnMop
	 74c8rhX4Z/wdjA/QRNkhDkk1rG6P7rx4H/O7uCTtqGUzfvNtjyDIStcKtC84Siddrqv0F
	 4v6kQlBIpQH5v3M1ePoOKyIXCFEHBC+SKZM7wRA7xESb80CuU47XFhZOeghk2PiIzwrdb
	 +yl8hqXYRASmwvfv7bQgHf4MBWRnMSoy7r2n1g++SM5ui3cxxRNik1d/U6oO1LN7LiNfV
	 NfQOuy1p4YbjjQQDx/QPef3VtE/fML/vcuEBYaPH6lx0FP+YqoYtUufD9mo+4LSP5bg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793436256;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3VjdvpKXYT0HYmFDq5+c0ZMSfSI1tB9huB3LXkP8ncM=;
	b=l6+QXTAWilnKohBzFUpleV0hN+I+xamVy5kCcCEtJ0N5tEi1/D2cW7xF8O3IDJBSiuD8
	 cETephhNlPo1+CkHsvbPINUil4DKb4ySW6xZl9rI36FTrTodMKmIoPEUcM/290dP5E1HZ
	 EE+jtxhf2FVUsAOHfuN59DO5z4CRo1hIF7kfcEChSlRZybvO9jjiCixnQNl8OE7P8EOga
	 kOl0X27txx4biklRnxHRFsYuwfgcHZxW4tkNRKHBEXKGM64PUKEH2WTrAPG0oTwn5LiP0
	 Z8lAx9UpO3wyqLRCZsg2MISmIurZmj8d4O/7n+fb+9uuSQ33tjyGwNiGGYfIAPac3ZA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=TyTNZSa3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793436256;
	bh=3VjdvpKXYT0HYmFDq5+c0ZMSfSI1tB9huB3LXkP8ncM=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=chhNHOV5rD20r8YEz2YciedsoazHxWUCY6jquvJcIZQJ8LvJbo8vJkVMVou5HoVC/
	 sb6k6uu2Nd4KSac9GSKdq65jDQxSiPrW+pfBNs4C5nKBWS1mcKBoheLidx8l+VJ6Lx
	 OJ3otcoaXKnVLnaVhmuufuSNpKhVhwuosZ5SuHKObxJy30CCxyR96+oz0Ni7Dql5hP
	 FRNYbVPIt2ndabUq9fdoPX8HA8AFqVH7NCHWlNT8XP6Xg9G4faQnxIiKqrHoZaAmqf
	 58e5Xqv/TY4BzQkTlgCfY7q5hDCjGwvvS6tg5K3X1KIRMD2Z/MbPYU45BXeZoCQ9l8
	 R315/S/6TdXBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 43982607A0;
	Sat, 31 Oct 2026 08:44:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 39AE5156
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:44:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2AB2B607A0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:44:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OjDWHnRuTxfu for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 08:44:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6D083606A9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::529"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793436254;
 b=LVhVubdXs556i3T46f2/el/xgD7sM+rLRcClvUDFMLnKAhHNLS2Y8qGXdt9rDTY0rz5a
 GZAKEnsP+USKvfwCP2DN8hzW6NzNJLsWvjTlLbyhw++JTg0jIVfLkdbInplZelbikMYdq
 jHNFhcuoN2lJm8V7/l2lXFvHvAa/5/y5uv/CVWCbn/xHtKvl4hdVaA1TuEkrtBblriW6o
 k4P1KwMwTGkAXHVxLSNFdpEkzSQmqxPtiGSAvS99/AC4dF1/LJNriIWUhwjKHOHJp3BX4
 Yo2Xr9rIg6H/qkXnGEnE2/oKq4EBUeaM5l2Si/TI9Dvwb9exKTkrVNPhQaspGJ+dsqg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793436254;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=3VjdvpKXYT0HYmFDq5+c0ZMSfSI1tB9huB3LXkP8ncM=;
 b=gqmTRqTeVJ8D3gK/SUEikJ6TWr640Ct/vozfeHEfGGqS02qctLwaZyqcxjm3QVHmoM1b
 FZ1pWf5bM0yyBGFArJdn/+HlDVVwpGVwLF73ui8PXFjO+/qV4gDNOjdmoKRTGznFjOlTg
 wT5l10OXzRG6KbHaZblUMGPLHJNaZbq7aMppeQ2WyePBsoVPvBCu5dooIXtV8tiuIeKcL
 cEAf0REP4w4hFnQiZQCALLqnng+Mhxf+HdULMRwnqQKOLazLtLY2hsmz0G05Q89eze1gX
 DWXfqEeBKSY9GNOdzvZnJjZLs8L43PAoNnqEDEOJ7ygwwH/nyCWg080TrPnN0X3W7Lg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=TyTNZSa3; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=TyTNZSa3
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6D083606A9
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:44:13 +0000 (UTC)
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-cd6a7e1f4e4so664854a12.2
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 01:44:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793436253; cv=none;
 d=google.com; s=arc-20260327;
 b=TzaCYtKdJN1uR08mr1oTgIoWFlbvhBD8iI2bsyN/Bu6LnRhj0XtkeFSW+xK+gpzkFa
 y4jrtKN06uXT7ino1CSi6yNPJtWKk5Igfa/B/exkiGRWEHnufkxCy9IxZwMv01RZv+OT
 JOlmZW5UhCJpSBirTSuo+iuBQqXW00HhlJjmtwA6EbmR9XOEP4AIjl0xD4nMCSJYSIIK
 LmtZq1fImY4SAyJC1K/8pkQdR1DVn1JZQiT6EriOxXEbUzbZW2a8QFISJlwV+mwlrAHk
 Lp58Vrttn+xyYJUqPGInpG1XKo1Beb+WFC8hSn6WPcA7x+Lkg+mLhrvI9vSuJ6jLhR7O
 +kLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :references:in-reply-to:mime-version:dkim-signature;
 bh=3VjdvpKXYT0HYmFDq5+c0ZMSfSI1tB9huB3LXkP8ncM=;
 fh=Mwrf0/HGETW3h38uuwq4SJVuWmSwqGAPYSM3459DeFk=;
 b=KZVl1SdLlxZoBdsDXzK2rDWdVfIWi6WBxJF3IkFpmfIRn4AB8YidxvoZMOIdXtfNPO
 nQ4G2QEKcIqCC3j7316fjiKm3DR8jhBZSUI25G9i76+cGETQWrJ43YwhJKOMFIItR3c8
 ogN6tZDD/moua4D/P/ZMCwiZbQe2LAwK5zvWTcWq5Mt/uMfDJmUxq+hjoj9ZK1V6C1sQ
 gVr6wHO3W/ox2BSODvatANyjlK3F3PAHC3RpLtj3DLsqYOBu1y5jtb3JHzbA0q7UX6b9
 jxd/cDXtp1e0UPCCu6OzV8NLE4PhVSQhintIl1ZSuesXM3nGY0SbxKDDSr4xoZ3OR/2o
 fmWw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793436253; x=1794041053;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:references:in-reply-to:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3VjdvpKXYT0HYmFDq5+c0ZMSfSI1tB9huB3LXkP8ncM=;
 b=TyTNZSa30P/ez4pg4b0DUfud/5biHw8sbyHRwulH9MBjbTpyu4mqG97kwRB9u7p768
 xgkuO6ruSly/I9AiJGVrzLsYaJ6oHrudbgqJqye9v1ZUxzUd6/znidjtm0EUtnndKP9Z
 Cnf2ynDM/6KWPDZaXvtVoLh0poMSvUWihB8+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793436253; x=1794041053;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:references:in-reply-to:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3VjdvpKXYT0HYmFDq5+c0ZMSfSI1tB9huB3LXkP8ncM=;
 b=TPNVqie3/O/+SAZFoyFujnotXDWFdcYEIi0/HsQ7Fh8S+ZTaXtrt8ggqQUryhOwc58
 iQUcpS25ekjz/xo7g1hkFNJJGuydblI3148xOlWG2VBrIiMtv3OOyFansjPXnA9pHDSJ
 w+HkWHRgPJfsg3fpt1+PsdP8on6rB8FNFNFUUhvTHkikmCESRCYyLTht+erRiuRd6Xv+
 RHEwt8OKpcOJzIZcewOq089g0oAdwQdkJMkRk/If2wM9qj+2/9U0+RYI5Cr+B4JQtNyq
 wPc+hYR2Z7Z3XQXALQwy+ZsL5SpSZd4T2rsdiJ7leTe2aM2FSwY3YbyHiOGsTuwg4pOv
 yajA==
X-Forwarded-Encrypted: i=1;
 AKwUvByZHaUeBaWNADVMOsGv6+mIf7BlPm4JrWqwoYA9hUD4ypIBbUh7JOUvPbbE5QRyqZ3iA9t3/YE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLkbzrRCTExbFs7ba+1vp1/I8XoQi7HdKFQyYe/gHsnscHA6phl
 fnnUGQV29QnB1o85QyzZ/7B3O1J9U9Wit2jypPSUGjOR3HbVrQunkrx2u/Otld6EAvEhJcpYRzh
 ibxcz5+T8GHJdxCEXxL4O4P4MHPX2PNw4jqkMczpz
X-Gm-Gg: AYBFou3ya0fbyAvPtTwg+6hrYytEEicWMVCqyRNGYY4LUo/n08Yt5V8z5aLymYHEv5A
 tjppEV+5Kscb3iUCpybfe8kFx8KTwoJRQtoImaEhwlQZ2/uuqsvD+If/qHJXDwhbnMYDvS+0y6b
 0p5VUorJWkT5zkkLc6TT/ownF3uNG7nd4061kZsF4qvX7QfQbige8uT+ehfFOYjHOEciTJC/+l4
 Le1kB/qaM741P2yQcIJhdAHG6Ez52g79Eu4hrg9hAr3ALOYriF2YD+mSlez+E/4xJEEw1NJuOni
 X9XmFBdlyEDT3NxJejZ4zrJlQc/E9V+oSmRXryeJPDTTRdZ3t7rKzF90D9vHzOCynCtC7CMK5Qt
 pybTwNPJAmyVs6ACQBrRVcatOpocwsAtdpSGyDTJYBbcHciX3YHgNsA+7kEmgI/hWB4VU2ic=
X-Received: by 2002:a17:90b:4b12:b0:3a8:5fd6:cb6 with SMTP id
 98e67ed59e1d1-3ae89173bedmr3820499a91.0.1793436253021; Sat, 31 Oct 2026
 01:44:13 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:44:08 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:39:32 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261029-imx93-secureboot-v6-3-27b9c987e25f@bootlin.com>
References: <20261029-imx93-secureboot-v6-0-27b9c987e25f@bootlin.com>
 <20261029-imx93-secureboot-v6-3-27b9c987e25f@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 01:44:08 -0700
X-Gm-Features: AclHuK-sfkI_Pn4mNVTqVJDVRrmY2OePOZ0UhSfG6Akfjk6EK859YTHheZRkKx8
Message-ID: <CAFLszTj+txLBm0EqEb5-F7y2HN2Tv6b6U8pJVUvKN3YZm7d28g@mail.gmail.com>
Subject: Re: [PATCH v6 3/9] binman: add nxp_imx93cst etype for i.MX93
 flash.bin signing
To: jeremie.dautheribes@bootlin.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.u-boot-project.org,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Marek Vasut <marex@nabladev.com>, Denis Mukhin <dmukhin@ford.com>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?UTF-8?Q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>, 
 Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Simona Toaca <simona.toaca@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Christophe Guerreiro <christophe.guerreiro@non.se.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 Lei Xu <lei.xu@nxp.com>, 
 Joseph Guo <qijian.guo@nxp.com>, Vincent Jardin <vjardin@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-29T17:35:23+11:00, J=C3=A9r=C3=A9mie Dautheribes (Schneider Elec=
tric)
<jeremie.dautheribes@bootlin.com> wrote:
> binman: add nxp_imx93cst etype for i.MX93 flash.bin signing
>
> Add a binman etype which allows signing the SPL and U-Boot proper
> sections of the i.MX93 flash.bin using CST and AHAB. The implementation
> reuses the shared functionality from the nxp_imxcst base etype.
>
> Signed-off-by: J=C3=A9r=C3=A9mie Dautheribes (Schneider Electric) <jeremi=
e.dautheribes@bootlin.com>
>
>  .gitignore                         |   2 +
>  tools/binman/etype/nxp_imx93cst.py | 111 +++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 113 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
