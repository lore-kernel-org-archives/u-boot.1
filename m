Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D47C2CCF2D4
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 23:31:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4FA4A80F7A;
	Sun, 18 Oct 2026 23:31:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cxrmp1ueUjtM; Sun, 18 Oct 2026 23:31:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 35F9480F74
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792366262;
	b=CWTYaFo9R8AEO8x/lF1UVhNyn4skeiyA43ofWdxDDvgbjqlsRmvM2mZhTagCnjci1soV
	 czcmy6E13nndZc+/VWnfyGRIWajO4F2O5Dgkwa+zSFd0MYiFhwhp+d9nlj2CN5fwNbbRI
	 8SzHVt+9SVi6o575I0DpVpUcIbFuJIlqpI5Vy4R6IEM0mYkc1uwCJWUZZ2a6e6ohNx0eb
	 Tv2gEiDz+tNrJVZmByXTfeUIImFJWtMc4/Mb0y/EfyRVfjv361I9XNxMe6Qr2cjVMGShG
	 a2CTmGa5o8wp+HaO7ThA0tekRUawLv25hhPCTDejWN4vHgS4Ktxj1hDZF/Su7/G+UVg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792366262;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=z9muCDY9VU91Wj31YLBb2X2qLE8QVHFdVX8m2MwF8k8=;
	b=Gve+oG2EHzixkXF5pshZx2RArcBe78OGxv/o5wHLKKfEP54Z6nyi57dvCL4oUq9qHb4I
	 DXtz+655FhmPDPlWln2rmMw9LAvv9OqlznvxacwdnTcfM5TOJ4R7CPCQBz3JvwPlATXjF
	 I/ji/KNqUgmkmJWNboxNzJKoKF7XiuNo+duV2HJuaJvpac5eJ1Hu1dQLplzr9RGYEL2Ug
	 OSmswkzZL7QWaXPtgQP9OiHkgIzcOwd5eOr6HtgMVRugxOBLkhu/yCa+XKu8gj6CEspCP
	 0FpGFaPyz4rWXz8i0FKngJ0PEz1Rhwh2fjI26v/iusP7000wEXGz4Xcd9KVhzJKMh+g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792366262;
	bh=z9muCDY9VU91Wj31YLBb2X2qLE8QVHFdVX8m2MwF8k8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GCbssMhfXpl7qVLwq7qGS6hOsIKFbrQfEzfbRY1VIzoN9LR1zYMSlO3fy82WfgXcx
	 De4LmZMx2qhyOEksEQLWbd7i+0MKlhsDj6J7GkDM43M2SZJ5wuCwq0/EhwrDOIg5fn
	 PdyOSC+2SfdyZIpHuax4GIrgwech1bIG+ZxToK8GbzmvmSbXrURE1kdLyA4BbCGTPr
	 8jtQ6TCE/stYLWDxMmqKMFFddUHw9FyVimYVwfxX14diImFpO5Fna2b616dd7XSqN0
	 HfNtHcouT9OCRXhz7NC0YrDmOoTECXCtuRG9DrJtlLt+OGefjSzcwLX4T6FGHNQwQN
	 WlqAFEr5CwCIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 35F9480F74;
	Sun, 18 Oct 2026 23:31:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4176C2A8
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 23:31:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2782C60603
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 23:31:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qx8KQQlFWjp3 for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 23:30:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 92CBA606F4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792366259;
 b=ANMjz+2NCi21a8oyiCQ5gHIXkbM7cdmhYPumdgqxSjavI8G4kZgbQZcgtZMb6YJYZIdB
 onuxz6yzFssXaQGMbCEin6uV6fz1Hcs1KGacDi7VA3HZgLAq6nKPxjB2nBefBYkqI89m1
 RSAmMd5YlXgE4v8eveG6zjOBaosvOhOkWwkCnORSf0BIVUUdTywk4PKhEmDXM658yBDaX
 XqZ6OgYqK5GuM8Bbb9Pzcqc1dnJj9UQUmXJ37iOmsCO3Fh69DvR++jFAjLf/u4UvLW2xk
 X/LaTb1c6MZ7k3YY3XEjbHj7cO2+ETbW+H4nQvL6rdmdf3Mwg/OvVBEwIfI4hrKLbdg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792366259;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=z9muCDY9VU91Wj31YLBb2X2qLE8QVHFdVX8m2MwF8k8=;
 b=EQPGCr9Y9cqKZWfVCEKbuANqT3nSKq16b85GLQSBWK9HGqD3eSQs0v1cMIuYC9Im3/K8
 14rTISmae7xsdpke5fYOe8LzspNwAjNUho6uWaMX2izsF5z1ua4wsxeEj3uvZB9ePPcBe
 Soma2/WxNPtaBU0C27gaAVgFU3+XxbSzbeTepipjr/9KXz5vZQ8qcoxhiNoPvi02YYjok
 TtdGvEqhkD1jUFVLyi3BJNFBB2iDD5QXjF5jtnIDylkMoEr4Prtu4YLwmRNVowweR/rSb
 KY4AP5LFVFWORRDIvB725Hg9gjeBsJDNXQJqX3RsF8EsQ6ZRGaT4AkZLe6TZwDdEkdQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=kwIGhZ4m; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=kwIGhZ4m
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 92CBA606F4
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 23:30:59 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3ab98332238so1202298a91.3
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 16:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792366259; x=1792971059;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z9muCDY9VU91Wj31YLBb2X2qLE8QVHFdVX8m2MwF8k8=;
 b=kwIGhZ4mtkfG1LGF0ekaUswnzit4BNfmY7XMHmzEUUZWesci6FYLkpjzRD4QzHbeRa
 DMJtMQcyYvu2+8RFUg/kjSDYmO+lMS4RAwYxrZvpZ7dvHjCq6DgbrPL216TUGI5JZKfc
 kALnheStusBEJgA/i2UuVH2kYN2w76Cg9r5z5ixqxX7SwetYYEYuXcugdWqRUhoFa0YR
 ap94gEcP92O4huxuc23fohmRVfuubztlbWdTkL3jB+0/1kwZ5WnK+4XkMpYAWdyUmgJb
 UNT1Rm/qVE7ZRhSoZi6ROrOU9PziuieEwSxjLEs66V50kJFc6wgeHjR3l9kQDX1peMSy
 k77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792366259; x=1792971059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=z9muCDY9VU91Wj31YLBb2X2qLE8QVHFdVX8m2MwF8k8=;
 b=2RzTHQJzC3dyQyHY3TSwmfoPTt94j1fQpVwAcfundieOOIQWjSRayxXVbhHMk7buii
 6fPmfTS3L4Qb/p6APj0QsLNm7eVlQ2bgfCqSXnN4y2Ld0HlsTvWtVR+HzwSAVoCP2sop
 JsNstgS9Wx+CnWPAuG8uCAr0L1vmkbCUrkzXeUB9rESIp0Gmlv/ZLRZeWH4/L8Hp8XH7
 zmD3S3MSASvnp2hf2A4MccoMagMK42qYyoGMTVV7qk8nVpNsr056CXecbbk8IVgVvZDe
 /TXr5n/fbVUsYRT0rAWNITTUEFj6vGRFMmoHv3hNTUeXjTqryy3cVBPkQ88hNDGgovFR
 Lh9Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByTkx0gIwJWQ2xYBnsvr2h/zhvLiGlFQXRwQoK1srWGD72+/f29niuQO3z9A+HmWsOSKFyTje4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIDcgddfGgvTvDt69xYBf94vG0rxuR8cggGEdCvGMn2jb5lrbYG
 SSmtSmec8ARrrV0lXboMnOpf4Hsg3/CUQGbKngQKt9IM8/KyE4pOqp7a
X-Gm-Gg: AYBFou0EUZSeT7wKYUjq7fRKp3hDnAf0nZr2Ata+0TaoiT3gjrZZHDydVXiPcb65Dil
 /8iFCzFSscWMz7uaIj066btEQSm8J6MXWNcMfl2e9AmPNMHqtlgKV9ezQwkSEp5qsEOYsxtA4KI
 eF0qVWFBGHugc4s3rHQ3AgGMLYNJEgKF9oa0ydAxWKGqOmXzSpjb9GGeknKVBFD7gHDJZfNUWFD
 dUD+V1Wj0m0SvEPOG1DZitXtWwK2uz4XGe05b7lcBz3fms/zYUhdcdNXM8CBsJcmR+JXUfKma/9
 qCDefGRoXMA0z88HWeuv57/1FHaPUjCGHo3o43R0ePyNNsM3VRnFPtD4g4aFXzEG6UVOmMvcpLP
 3/NTTHt4UO9yN93Md97LxoCJw78HcIFDyplG/HJEfxplm9IeMs3b1Jb7RvUSJj/ACvDkxOeld6a
 UwBqXiZhbceOaTWryMjw4LeCQaNBkSVGKpJQeGZxf3s137auoCm/AW2NQyombi4V11vxE6tA8P0
 lRHSo+iXMPLyll964vypNhXY1uNbi4ssz7+p9ekFsBQ4MVtGFh01Y9j09BJZvj45R6oU8fqFdi4
 wGxcUJLVy8PP1zZEhVnFTqsuIkR5/gv0fqKY1wFMNeKvUbXCrahpvA==
X-Received: by 2002:a17:90b:5803:b0:3ab:9c73:12e with SMTP id
 98e67ed59e1d1-3acee29303bmr4849973a91.6.1792366258662; 
 Sun, 18 Oct 2026 16:30:58 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc48f4cadsm12941799a91.12.2026.10.18.16.30.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 16:30:57 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
Cc: Yixun Lan <dlan@kernel.org>, Dave Klotz <DaveWK225@protonmail.com>,
 Zixian Zeng <sycamoremoon376@gmail.com>,
 Eric Chung <eric.chung@riscstar.com>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.u-boot-project.org, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io,
 Anand Moon <linux.amoon@gmail.com>,
 Tanmay Kathpalia <tanmay.kathpalia@gmail.com>
Subject: Re: [PATCH v2 2/3] mmc: k1: let the SPL read SD cards more than one
 block at a time
Date: Mon, 19 Oct 2026 07:30:52 +0800
Message-ID: <20261018233052.1805865-1-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cc682162-56c4-4143-9fbf-a2d3b5dc25ae@altera.com>
References: <20261005T135733-0400.mmc-v2-0002.DaveWK225@protonmail.com>
 <20261014T154006-0400.uboot-k1-mmc-v2-handoff.DaveWK225@protonmail.com>
 <5cf65034-e7b9-4d0b-9a72-5d771e1d0e80@altera.com>
 <20261014213155-GKB65630@kernel.org>
 <cc682162-56c4-4143-9fbf-a2d3b5dc25ae@altera.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Tanmay,

Kathpalia, Tanmay wrote:
> Is the K1 SD host controller documentation publicly available online?

Yes, it is chapter 10.4 "SD/eMMC" of the K1 User Manual, in the
SpacemiT Keystone K1 Documentation:

  https://developer.spacemit.com/documentation

The Linux sdhci-of-k1 series pointed to the same chapter [1].

I have a Milk-V Jupiter and can test your next version on it.

[1] https://lists.infradead.org/pipermail/linux-riscv/2025-May/070005.html

Thanks,
Hung-Chun
