Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED14606A31C
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DYIfvjrI;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kvJ0pv2M
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F0F98129A;
	Sat, 28 Nov 2026 13:16:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RB-uo83O6rg5; Sat, 28 Nov 2026 13:16:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 05DCB812DF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795871788;
	b=YazAdwSnvHGtMHIFkZ6GzZG4Gkg97AgSVb4ll/0EL+JYbgmu62RbKY3RlH4+UZXC2yLo
	 4NsAbUl6LAt58WWxkGqM2Uu///tRP0I7z4RtjHLn6ls4OSlFAVQOhuGsfJnMxAJVI9ddT
	 7LtRMN+RI913VNSo6h/XR9mMCCA0I8/NQd+N2Fo+Y/mDi008Bj4WBzFgKGSQfof6tQTyz
	 dw9AerOFPa4YddPDB73vBb45cQpalaAu0QQaHy43eFWnzV3tjyl4+5jVGBbDQIfVPEVkD
	 dmXfUdPOmObPJDZIVdXr0qsqw6EHxgWfC9lk0aXTQGDe/5ixonBurWcn+p4WUJOdaiQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795871788;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=sZxkJB6kpSWzbKQIIWI5OwvakLPewwnsYo60P0Fwnjk=;
	b=gw9vOS42O3+bXcFxiKzYjoSQH0Ol/Xx7z2DV8NllVdoEFXLwpvlEcsYlyZEjPpy3SD0q
	 1CB0/ws+fblsHb5DU6rB+GxVZwJ0sJacDXdq6pqE733C0Q2hI0jatjNJ41Yv/OAQyhbJd
	 kcB6QB5ZeJovGunJYPqoo3hxDpcFl6IfHke3DSUTL0EmwUZEV7Gkmfd/A8WM12masMrQT
	 WctjR9JAr4xQESKfzc0uoXWgdtPZcdw+QfR2lqGlv1BhqPs48KZxSh3BIbPFzKVlxvKXm
	 cCbDdYcRlG89e4jIEP8bUqaBWc63qVo5Nr2Qp0odaTQ6qKeRuR2lApno3ckD+Y2MQeA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795871788;
	bh=sZxkJB6kpSWzbKQIIWI5OwvakLPewwnsYo60P0Fwnjk=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DYIfvjrIlglrddx/QxME7frytXNrCnU4qHLFp8IvEdonrNeLmG0s7h1DU5dUokc+y
	 66IBoWjhfvaJa/3TwP6lbWiMe2cHa1LQoN7ECGT8bQXYqE0EfW9c8YjONPOKyAw+tj
	 gGFZ1TjP6dXBGoM2NYk68LcqjAq1OZQQgylvGAm/s4RnoDtT9bilLQjMmjYxUvNyiu
	 I8+gktUn/Xvb6O7uatipcqgPcTaSdvluqrH0OwxxG1WxbZ9nX7dOIhZmlv4T908RxI
	 ER70So/N7A1/zg0MquaXPwIDFJOV5OQ1ox0N4Wjn/7Q1hLEx2EXBhivDxZY3Uj5qpd
	 3PEceYldLpE9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 05DCB812DF;
	Sat, 28 Nov 2026 13:16:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D561E2BD
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 08:09:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C7CB36062B
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 08:09:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EOwLsjJEPKUA for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 08:09:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A5FBB60617
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::22e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22e; helo=mail-oi1-x22e.google.com;
 envelope-from=dmitrii.vaniushin@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=kvJ0pv2M
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A5FBB60617
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 08:09:14 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4d7034a99a9so5384310b6e.3
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 00:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795853353; x=1796458153;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sZxkJB6kpSWzbKQIIWI5OwvakLPewwnsYo60P0Fwnjk=;
 b=kvJ0pv2M3o9R7jDUMnlyma14ynizLAK4n4L5hQZdEVFf9a1gQdjMVDZgO93AfeBtpQ
 7TVW7UbEJkJxuyt1shZipdDf6oItedM4Fe8Cfppvcetj3wjj4ETfKZUOtFw1tjlHxhwG
 SjlQxCls4dE1J9IQxlPqk965bbu0eURHxUQ42RF+pQ86KLeyYlGQUuCeggeIoyumUmSU
 PqbPf5N0jHSM4o1wZHxOaZHBMhRf1g+VmSZ1Awi2lqileOCZk24sPyNylKmm/7cBSx8S
 QYjRHQpzJKWji3OJvqFkpTxKZYn5EpX06kgumZMjq5mAHpHzZ3iQSP2IvAf5N86Ahc6c
 kHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795853353; x=1796458153;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sZxkJB6kpSWzbKQIIWI5OwvakLPewwnsYo60P0Fwnjk=;
 b=v+h15juDJxPSf1Zr0yNf4ejJvcwHtP4q0bFMbp2B81jTUJKr+4JnXjgLQ4jo4lDDFG
 NKdKpOtvvqE0m8OqVmu8TKOiOUlnPSDPJGaspsZalRm8JCb+j98Uzd7YHDaF2PKELTE+
 g9Ck0NBbsSIvCi8Pi6KdfK99r2NY0lsTYRBcU0QTnuXKPCtyyCu9sXaBUOhVovIJpviC
 vaK6UcWeeA+EMeT3aIJ/ml1I/IMEe2KNK+r0XG1SL9CXILI1gJcwjCYv0w1W28QP4pf1
 903tWH7mImKbDw30qIUWMGqzy0pMUWJnYD9QEU7bmk1lYSlVfXVkXxCxeC9UCPB1rDNn
 HPsg==
X-Gm-Message-State: APuU4Z+LID2NqYMv9ZE53h7ffHX6ihoQtJ9mtsXa6Or53vr+I6Jep18Y
 V02lYZLoEtKu3uYPi0VoNa3+/vxMMLIDrvhKAxQ0z8R5884fQW79lsXR2RLcMqlNNYE0hdB/DaK
 AMWx6up/3K3XQj3uyGzSkZ20sKlD3/WECqoQCG0Rhu/Yy
X-Gm-Gg: AZFdTZcWYeZxKvHlFw/rAqaXYFdFdUyRwYM0aHPIluD7OXE1g4teEt7QbZPY01OlVZ6
 yIOYda+xyg0yb39DXLjEWl+jZTK7Ro4R8WL2IO4DDX06XlJA3+nYJshyqWX61R6+j2LZY3Qt6L/
 KCK+yzocKh8c3KaAfrE/VQatx0zqyQTpi6cQAuS3PB9faJSVPNL9HyIkFr3e+tFDBgCpZu7kh+V
 ZMQ9Yao9G8x4nxAL9WaMxtOH9/REfTfT+r8uqe7MwWjgYFSEyx79c0CTqP8i8Dt3Q3prK+pHTNn
 izFJBT7rvez31rhH4QgsRClWOOd2R0WIoTXYWpm9M1Q7CEUHY3YzOMJxftqPEVQItCVK98d91cz
 u7K3pJgRALZOaf9+xdg0kD4CZqr/r2e4SEg==
X-Received: by 2002:a05:6808:13d3:b0:4af:5d69:1cb4 with SMTP id
 5614622812f47-57a09c0fbf4mr29668507b6e.15.1795853353219; Sat, 28 Nov 2026
 00:09:13 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Dmitrii Vaniushin <dmitrii.vaniushin@gmail.com>
Date: Sat, 28 Nov 2026 11:09:02 +0300
X-Gm-Features: Aa3M54oc05b8Urxg7T4CVT84nRpLDU3PRpXOHtwIiLsgVrG-M6Gzdmurh74LZkg
Message-ID: <CAHyrWCPZoVKBKJHR4uHkbGzo9f02UADdbXACemFGroSeZRxBZQ@mail.gmail.com>
Subject: SpacemiT K1 SoC watchdog support
To: u-boot@lists.u-boot-project.org
Cc: u-boot-spacemit@groups.io, eric.chung@riscstar.com, 
 alan.tseng.cs@gmail.com, dlan@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 28 Nov 2026 13:16:13 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello!

I would like to contribute to u-boot. As I have a Banana Pi BPI-F3
available, I was thinking about adding support for the SpacemiT K1 SoC
watchdog to mainline U-Boot, using the existing vendor implementation
as a reference.
https://github.com/spacemit-com/uboot-2022.10/blob/k1-bl-v2.2.y/drivers/watchdog/spacemit_wdt.c

Is anyone already working on upstream watchdog support for the K1 or
K3? Would such a contribution be welcome?

Would appreciate any feedback!

Thanks,
Dmitrii
