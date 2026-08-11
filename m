Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3756C5CFE7
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 22:50:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 74CCA80DEB;
	Tue, 11 Aug 2026 22:50:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7ZerwZbgxSqA; Tue, 11 Aug 2026 22:50:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CE58480BFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786488615;
	bh=fetNM0W3VK9fgieHXX2eoyk0rT/RWLIJw0D0/H1Jo68=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QR+fDSkGHiJCX+YQr+aGtzTneNycGTm+EvXzhBvQwXhvQ4LiRMoYKXiOFqra1tH00
	 6UDPgPrMJioqyrfcE3ImUbl3c6yWCM1eyyyIci7BjPCCoCKAbIkBhHqoScG5ruId36
	 38s4HqLUp42SOePwZBdVMS95WGCnZOM4vppEl2CTB/1v81nzDuxG31mDYZPTLktcXJ
	 VUitxbhz8+Hvarb5VNQlnGkCe4M6VVlKLNOweXzrS1Eg/XJ867I78DlON2nDWRdvBc
	 BvUXgUskJXkcAed4wAGUHcdoIFqBUguJP9YwxJFnbg8hP6M3CgN/N088zNF7godS9c
	 b5vuoVBKI5pXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CE58480BFA;
	Tue, 11 Aug 2026 22:50:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AA1CA2E0
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 22:50:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 97A0080BFA
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 22:50:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BmLqfqISsTho for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 22:50:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2c; helo=mail-oo1-xc2c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org CF7DA80B22
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CF7DA80B22
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CF7DA80B22
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 22:50:12 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6ae9b721927so267931eaf.0
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 15:50:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786488611; x=1787093411;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fetNM0W3VK9fgieHXX2eoyk0rT/RWLIJw0D0/H1Jo68=;
 b=Xv4JvvJx/61pCcVtKUCQmXX1zAIJ8L+A/iYffJDBGtrzdEUlKVJ7FooqlKWMd+0Svo
 l5g9Or1PGKNYRMsuy5bbe9vdn4LEcD39qAf8EJEMlIDAZdwhLHqPGqz9E2eKzl4+V9mZ
 2XPdfUtAxou8LWe4+pArpkOCd51yqhlfVe+u9pnEeXpCDE7zj4+9NqojfYSxTnGEN05a
 25v2RkuGTUCQe5yDm0zoGavfjibuEJkiW+Pcm8zVFJHE+cvh0iqwXY33uDyoHT6LPQmo
 xyhE7+wLgvLoGFIVxjBySoZnQ7Sncbg5rc7E2gkSze97nMzfpbOVeJ9IJsQvNft9IEBz
 wQuw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpZyguXnrxQzzXJBMm79yMFr8z6E2BxVVqTURkMlaieeZj2Ndl6YIkC/keiuOL8rSTlFthnoB8=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yweb3QtXarxkYwRuVj1zewyijFoT38UJDP5tLyXFvCcAZIoJ89S
 i92EzdnGou6jYfImFsjIkQ/uDIpd4vyEslyh0Nh2luEu/Kx6uGygKTzOSTd2k7ISTC0=
X-Gm-Gg: AR+sD10h0tHVT6JS0aMW4zQkfk+vHqakK9xKdLOrc/JWFw4FQ2No0zjdfuHeoNn3hk9
 zMqBbkL39ro+zXahOfZCjOcQShoOD/xLD1ICIOw/VeQ7m1m07oyFUP8xVEnaoewGQKh0fPIoHHs
 6/AGrnRHV2ppbzRhogC9/dSa5RPzdZ5h8Q+fDmcUcCj+5EgEJLF9KC73uU2DY4+h4p9CTskvIvH
 yv6c4OBJsk/4NiygHDr5LuUZpGeLIvYiz3hqq9KvynMdGeukYM+f7iwFz6DEfvVI2BKSDTjyTRk
 /Qqky5xxJgjfc8qd7pOLnuAgmFhfmUuUBkBeLDUgtR6bhl3mnM0OXJzxi+z6KjULybiP6V72xOf
 DIt4y6O5t+nq3Kvbl6ih4pPyBa/3ahRqftpqiPY3iFOKQ7nidyffFUVHA/2eOD/n9vHkYAXuxBN
 tg/Vpsq+bgQs9HnLA8pkdrnkMrxNJW7W8LoQ9RlwCFOx+k3ztNy/JcQgKY8iXqDFo0A2+NPi3Xe
 PizwhXf2qSjcB6qKCBJPs0XCT/GdfJghlDc4d9A3t1E6ZvcllY1mX+MU1PozvH6Te/hkJu9augf
 f1XI5Yj1OPKZMButWYQ=
X-Received: by 2002:a05:6820:150c:b0:6ac:9729:6710 with SMTP id
 006d021491bc7-6b0b282a624mr348548eaf.18.1786488611644; 
 Tue, 11 Aug 2026 15:50:11 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b0ad500d37sm972541eaf.7.2026.08.11.15.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 15:50:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@nxp.com>, u-boot@lists.u-boot-project.org, 
 Alexey Charkov <alchark@flipper.net>
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260730-math64-resync-v1-0-8792d9119d49@flipper.net>
References: <20260730-math64-resync-v1-0-8792d9119d49@flipper.net>
Subject: Re: [PATCH 0/5] lib: resync lib/div64.c and <linux/math64.h> with
 Linux v7.1
Message-Id: <178648861046.3127030.9238431055367519148.b4-ty@konsulko.com>
Date: Tue, 11 Aug 2026 16:50:10 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786488611; x=1787093411;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fetNM0W3VK9fgieHXX2eoyk0rT/RWLIJw0D0/H1Jo68=;
 b=JXr3/ID5t4aFe1pKbCkQwLsCzEK8oA1JXD1Zub5nc5wJan+iVJVv3kTWALp1+ZGDJZ
 4O9PY7WeF7pt4/KrDssg9f6VCuFq3evjiSIWSzPwyqbBIRgTqGQjQ99F4bn2T07beLMX
 12FOkeNHkk5RnnBoT0o/a5EuOTjGTCHWMCulQ=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=JXr3/ID5
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Thu, 30 Jul 2026 22:40:37 +0400, Alexey Charkov wrote:

> U-Boot's <linux/math64.h> was last really synced with Linux in 2017 by
> commit 0342e335ba88 ("lib: div64: sync with Linux"). Since then it has
> only been patched locally twice, and both times in ways that increased
> the divergence rather than tracking upstream.
> 
> The one that prompted this series is DIV64_U64_ROUND_UP(). Commit
> 3adc17f60bf8 ("lib: div64: Add support for round up of div64_u64") added
> it inside the #if BITS_PER_LONG == 64 branch, whereas upstream defines
> it unconditionally after that block, so any 32-bit user fails to build.
> 
> [...]

Applied to u-boot/next, thanks!

[1/5] lib: div64: fix off-by-one shift in div64_u64() and div64_u64_rem()
      commit: 8e82c0a75f5df98df1b23d0898c4d7008ab64621
[2/5] lib: div64: use abs64() for the 64-bit operands of div64_s64()
      commit: c81dbcc9cef01c31f7d6f3da07130cdf4f3ec63a
[3/5] lib: div64: inline __iter_div_u64_rem() into its only user
      commit: 6228dd6d791c0f9eab56060a1eb404d4d174b525
[4/5] lib: div64: sync with Linux v7.1
      commit: 378c10eab1a7224f00ee7d9b29748bb08c14d396
[5/5] lib: math64: sync <linux/math64.h> with Linux v7.1
      commit: b7fd64c36d4c98e5259a9970d3382cad2a715f74
-- 
Tom


