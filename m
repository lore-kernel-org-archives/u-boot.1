Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07BF606A33E
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=h333Vpxz;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=LPxVcfVU
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 772EC60A81;
	Thu, 26 Nov 2026 14:22:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id By8RxeI8vZqf; Thu, 26 Nov 2026 14:22:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A48B660A67
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795702920;
	b=SgOUgeh3SogbrxnwuUVLaaez40lwVW7UKv61KXTee/o255BmFu+MYCErFeMIjsn5qPoc
	 R2G12j9zK7G5AtKB9AzWIramiTwykRey2yAYPyGf/JnRMqGDEtwDb9UXI8XMtEFJsXgBk
	 pHoLZ8Prwf+ODB13SGRjxLhHIdOBM6jwLGLR1ELVqV/tD9rmE1/Ob6hGwh7/mM6ndaSpg
	 urjQ4yFOOwTDEeXZh1g/nH1z8ykxWETpbS/HnV48QbSJvHWoNOXsbXEkIW3MYYe25pEi5
	 ibFzQn1ZgOTc31eikJChuczl/t2cb7VcDSW2KIZvgMfZQ4PKxSL1TV5YI+dm0hiD9Kg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795702920;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CRj1O6I8E5L6YPHMXcYUqcQ+Vd5k7MCSydRzi+6Fm6I=;
	b=bvhG19nMQ98OFtVLgizWnh37z5RXhMYDvV05OI0vdQwBvloBGFRk2e5drqAcQGzBeagW
	 hE8l/ss1xWP9wDNZiyORHDOoP9x918v5btlYkRopXQHrhdGTSRopI2Ye6cqnpJErjRah8
	 qvQ3AZ9IvF9NZyWoVAVArXyZw92M+ws8bC8yPqLou4k5owKKMC5/e3PVRybyoema9SFW1
	 h/GH3X2yl6lMaE7TcA/YoQ9mbE42/3+bwyuw3NxjuNlg8mMSHWWMlqmhl9yTg/2OK1eZl
	 YbYCUrd0W4skNPQFgpMlGNkehi+4ssgF+VYmZe3K11nMNfZLL5zCvooERrLdYkCVIMQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795702920;
	bh=CRj1O6I8E5L6YPHMXcYUqcQ+Vd5k7MCSydRzi+6Fm6I=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h333VpxzYQQ88rKSoYTvwjd9SSnRVLLrEOiw00mpZxEEvctfQiUYNBj1Yd7c/SkBT
	 Bwr5SO4q5mLlzckhU/H0QWtiRgiWUYfW4GLUkSiAXxxMf12GZ005FF2BnkMzFNQcZe
	 skAyijYuIi5HNV9c58xx3+MUhTVQ68vEcVre2qlWz4WAfPJ7Xka0KtfMnv/wXBmVu5
	 hlhP2FNWtm/jiRmyXakyyAjx9o/7tI3hwFBshRwAVlpFv6H2Br7KL66C3nw71Qd5kX
	 jM0hTlK7zf6x5D1YmSP0hBylT7fUgoolxuknUF/8Ic22N1/x1b5mz26KcH3clAIopm
	 eFmPELzUha+8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A48B660A67;
	Thu, 26 Nov 2026 14:22:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C15B3371
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:21:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B3A444099E
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:21:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IUd0AIvmBkwH for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 14:21:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E1A2F4099C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=LPxVcfVU
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E1A2F4099C
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:21:56 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso50580525e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795702915; x=1796307715;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CRj1O6I8E5L6YPHMXcYUqcQ+Vd5k7MCSydRzi+6Fm6I=;
 b=LPxVcfVUQ17GNKZZ6tNyjlKnUgId2ob1hLKKQ7xaNN9XHyuDDYvm73CCVxoIbaYaQ9
 r9j0LkFOHpq8DnhMh51Q0anQwlZHo+okpPPSNzp5bTYLOlnW74tfiaNSXlogn9pEhOe2
 TZQa+FoNuX0OIiYjlc8FnAXrQ0aZJP8eKh/NZNzEbIW/JAAw1q0Wv6XojCza7RY0MiiO
 wMSATx/7qq9pL6xISBK8C7kk6CKMvxfOq8xCV1Yn34YnH4j7BeeedYCNx5QuzWAwQybB
 8Wx5fUN+WLC83XEYQGkm+cipFixYtKugwrRRfF5OMbQEqRHhXUOu0DU2Fh7QjCcqQYWR
 Fg8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795702915; x=1796307715;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CRj1O6I8E5L6YPHMXcYUqcQ+Vd5k7MCSydRzi+6Fm6I=;
 b=NW8T6qsRPCTjLhskb5glZVfBlqmcYZXzY+HhSMSeTP4A+SAlwypMQ3gFjK3nWdp9pp
 GwFKMlUUwzFOVNpZ8mBObgtpk8JI0s1LP9DBFrFB2Ki797XNOXgp0NJS6NJ11Xwq10y8
 IAL2HHEuCF/X0sQdcK6/pIBgYZmUH51fL961eLj2mNgEvViPMu7GM1/E7mu2D5Q+wrbR
 DTLCS3gom2rT8ukKwJ85X69KWvtqxS5AXcZVijQI8kCnWKOg/2rvzU2+ZqnbFOWsSfp9
 o1Xs/vQW1XNlPZqa9J2j65SHcgxxsre9R0s127dbHhzGSE9vbpHlJ8NfPXyH4AuRVZXC
 uvCg==
X-Gm-Message-State: APuU4Z80ZwRL9LyQVItHuqUmQ8e0fSlKG/T/oRzWD/c64QRaTpbY4yag
 u0nZhvvIeiZHEPWNCeOoqN1GmirDgxRGQnjRKIxk5dxftkqHFjeBbdNY6XUTV/WIonQ=
X-Gm-Gg: AZFdTZf2qZvLm3zPQg1Sf8KHIDQCL0P4YgcEIQsC19zzxsAl0tgR8B4scFZAO+dAUG0
 iwGmu1ntmpchPQzZU0/a4JG9aasBSL7PJnLTVWoykU3KVSM1IHCZXCLhS4libZjT/fCpgDtoO1n
 xMcSRD+PaycUSJhB/ZZMYStC4WsgAIKa7lXWMGydMlBiVGCxUPz90XKP/3zQLdboLZabMzjO2+D
 pz1YF3UzIiggWUZxvBweJ47ncXg+Yg3g6XTYUqgaeoYpMznwtdrK4saFJ+9wxvAUc1aTchFgZNX
 zW1FEE96k1hICWyB0iXSKe3X2aAIHgyhB/8nZCk4ui8TCJpstwChR2QdK6OM5UH1ExUdpGeTn4U
 vrNUzGtdtHZ5wbH6ErwDMxR5mO7+jzJd3KHqqHchjMfErpApac3xVQiLPX9ELqeNJgikqYHPOYP
 5dyfVz4yga95EIfSDAh5EEWiqUkTb9zjaa0QC0BouNDhN4AxIe/KaIqLIyVACqO1J27ZNAD8jkA
 jV3+jb0n8fJDweXQX8MJ2+e3irpfQv8CVj9JurwxkDKGwQFStktwSmrTCtbg3eqXm0E4gE8TDQv
 EPX0K50FTPOnSyGK0H5YkBCj2/U0xSbu4WJFVUEYT3R896IDcK8zTzx8/LERasaaQ9vR7tVd
X-Received: by 2002:a05:600c:4f84:b0:4bb:5f3b:25a9 with SMTP id
 5b1f17b1804b1-4bb88820f39mr403806675e9.30.1795702914683; 
 Thu, 26 Nov 2026 06:21:54 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb90655f5asm387647325e9.1.2026.11.26.06.21.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 06:21:54 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/5] riscv: spacemit: k3: Allocate SPL FIT load buffer
From: Guillaume La Roque <glaroque@baylibre.com>
To: Yixun Lan <dlan@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Yao Zi <me@ziyao.cc>, Junhui Liu <junhui.liu@pigmoral.tech>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 E Shattow <e@freeshell.de>, Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <20261122-06-spacemit-k3-spl-nor-v1-1-33beb921011d@kernel.org>
References: <20261122-06-spacemit-k3-spl-nor-v1-0-33beb921011d@kernel.org>
 <20261122-06-spacemit-k3-spl-nor-v1-1-33beb921011d@kernel.org>
Date: Thu, 26 Nov 2026 15:21:50 +0100
Message-Id: <179570291085.2502540.13570623023208505283.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795702912; l=368;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=QaOeKaWgH7zQLBnG1WGQf6HNgj1rqaYmB+JkSgpC5kY=;
 b=bA+9LpCN2QaaJ+cjtSX5cPiAaTKl3a44mFu1CS4uKVK0oHaOjaIW7ZDJDepHIw7oNO/l98ZPM
 D7KD0SlBVpvD31O9i8u+kfhw1TXxbXq7mmzZX2mU4xvx4q96bua9ta/
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 22 Nov 2026 02:34:09 +0000, Yixun Lan <dlan@kernel.org> wrote:
> The memory required for SPL FIT load staging buffer is quite large,
> which close to 1070 KB, allocate a dedicated address for it, so it
> won't consume memory space from SPL heap.

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
