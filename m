Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B230606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 22:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kY0QqHpE;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=KsionRrB
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0373760BA2;
	Wed, 21 Oct 2026 22:15:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 61ZRoFtF_wla; Wed, 21 Oct 2026 22:15:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D73A9610C6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792620914;
	b=Wlm9DSQZTLdzY4I1W15KSEnrn1bZ5ZOfaVHbNr7A3vltHxUmuPOxiD8U708ly5Wt8h/8
	 iMTzi69TzE+zGde6XXi6onZ2PWHHUAvFayQh1Lnw3X9qS/yLTU2NKELcuwpaaYaUtF2QE
	 WxF6RLZG+V5bvSMjwSzzi62E3gJqn2hsxCqB6wMz0PnCed3PPfORm5U/E+pdHRSlYRBRO
	 mIfyrS2qN1nxBkiuzulqwwYqBktVgmc/QwVmoPWPYL2Xoo3ct/UT7kYqHblJ9sjV+TWu+
	 mQNPxyzps5497eHJQyU2gcezL19qSy7A4OuxaHMaOMJEedYy2b7UDwkhiMBxj5CIFsQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792620914;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nTbPRs6bKnYS2fnKLwzQgWz1G1gr0ODbY1hF1bl54us=;
	b=Crj/aNcMKvzQDQcN1NAWAzovgoexOUx2RRzb9kkXmxEdLHGCi6TGThcyAJlMGt+R95m2
	 2XGU3JsOGFQHZ5L9Zn+nBjzW/ARsxs2iFfIzqvHENSOZ5D7JoOv8B1zN8zc3RpIBu3Toa
	 lClnaHWvhgmemcx4VYei5J8152NIjCKgJoqaAaiN9JNknuhG/qCeS6TlB3Pg2Mio260BF
	 c/7MdrSfhtRYQnva8ME1aliocQ4AFlso5PgLMRos5p0vMW0PO3tnkRWKv+arT6xIb1Sl3
	 oCNwNQoHqPixYaFzUEN5NdZQMRWCHlsXiEz0YlbTqIL+eYaPDFeZK50lm5rwbiLCEEA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792620914;
	bh=nTbPRs6bKnYS2fnKLwzQgWz1G1gr0ODbY1hF1bl54us=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kY0QqHpEJfXiN79+RVtLagKxWVERJXF636Z/4ue5fXcue1wkaXYYtKzbtb88Z18lK
	 ueGDqS9h4eBLHM4vTSG6RIzKHr6Zl9PyKvedu9ZGnwlU4NjzXpmxeOpvIzF0eA7Mex
	 mRE6NH4l5Tq5sB3TYcpfd5VB8MQPgiJTa9dvuqy4XwiMobk+zDNYmaohcvK2YA132V
	 c2TN88dd6pAu1Rr6HN1YS7Cdg1NLIT2Lkvj2ONyh2EqG5S4XUx7IQwn/PWGZ29+wM+
	 RxRBM7aBE4JTw2ClsVNYCYHFv/dnQCY4hJ2BcA2rfHcZ5GLOuUUCW+friOS1zkEvPg
	 nPtSusr75dy5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D73A9610C6;
	Wed, 21 Oct 2026 22:15:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3153B95C
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 22:15:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2313740050
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 22:15:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YBTwuYQ0qOEo for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 22:15:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7EE2340042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::29"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792620906;
 b=FOu1u84xraz8uapjFQMdbuYqgHB2lYaB6UqracIB/rugxAVBWshR4ujCdhXQHxfWHbnD
 nATI1+zx0dWXkkXnEeLXBemofGlaQaKhHrV/nB+V+eIu1fFafUiAWrjJUU+zn/WYkAekO
 7VXEs8BPS5GYQ2IcXKrThuOHjBSm3+GeDpjDkU5or0YeO+4EZFeSCgAWPPHYysMqwu/0i
 n2pMNpSPPB5MXuo4Z5zUVDeOTEjjO0famWm+ChJpcbhz91NXMC18dC9sQXAf+ffoKkY4m
 QQGUsL5hoBbPM2YT7yyOEQ8UcVtP0PysIrny6EfcE7JGy/5p5em46AwWhIHF3NFEFMw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792620906;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=nTbPRs6bKnYS2fnKLwzQgWz1G1gr0ODbY1hF1bl54us=;
 b=h61zsBCBt6wcu+6fZxL1OqKkK+vQwPfZBCicLAU7yW2FATqKZxmvKCUpVNo6/4pkU0Zv
 v8e3f4GUUTGKC/BJbFe2/ZEsqiIKFe3WEudY5skjTpwOw5+2/gffy+Gp/TgMB8wsXddY2
 NTPVbvrYwY7GrsllZkjET2zQQI82wAN9p3riqqdXXVmn9Ex6wzw36GzJuYJOxtb+45+B2
 Vqy4zVAQdyqqya8Rs6IDkqTeR7CKhMMKTZ2fZamcPLm9BOQp2PPLyzniNqHpzuCkiwvi4
 JDVulm3s2GjpNwysndwgohAD5kH2wrz4kSvDJ4ji75NT3F+Ix3yVv3X+1QGBnATgEkQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=KsionRrB; 
 arc=none smtp.remote-ip="2001:4860:4864:20::29"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::29; helo=mail-oa1-x29.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=KsionRrB
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7EE2340042
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 22:15:06 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-4949f037131so654175fac.3
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 15:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792620905; x=1793225705;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nTbPRs6bKnYS2fnKLwzQgWz1G1gr0ODbY1hF1bl54us=;
 b=KsionRrB/fFe+rqSPXYXxC+tBBGx/xlVoSAje6jghrIXBb3lMCbg1NCW7C8yjmvZ3f
 TUGFtotyH6XZw/LNv+kV+IRxikq+yItVivdV+PgXXT6vPNaXMKcg7o9fwm3EvFq9G0Jv
 B4GhT7qxLELd4wpc0w4ODLyT1wXzy2JBN4YaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792620905; x=1793225705;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nTbPRs6bKnYS2fnKLwzQgWz1G1gr0ODbY1hF1bl54us=;
 b=SDAkBwYv+NIw3u1e8Vfd50WTw+f62c4LCziLhy1CGu8l6yul9baLMl3H9VHHIfAVjv
 MUi47ci+vw/AHYMQHFZvM3qXgmspkfJ5JDe+reXD+wiGUQQ5rnnbF4L5+aA15/RZ8CVv
 8IOMOLVh1bF3/TxMDK46InnQuRUtJ+x1vDReIQjLw97N9o54TAsZ9hnCwyw3k88HxvPc
 Q5vylZBGCpeUfA5JkTzVPjlSP++XugYcYlOs2AwpBckksZ/jrAiKt0jKIGTzpvG4fHO9
 8ZGuy8n997oJS8a0sdmEUaNEHi8hRzg9jWwNnM1rjSfw1rRoV+DfIhKoh08pMxCMteCl
 xa6A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwHMX7dE38otv++6e9U8VQFUhAGA3okxEKnvYU/k+F8KFIqrMgmM0UcTujhB7OLkIsws1niHm0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKUbR3vIi8vf95RPcniVcbss2671VZVL2oFgxNKdViILNQUSLcr
 hSKsvOZ8UZq0MKSckwmsVuSo2l5VI7USPfYHggzVISDd8Apt0k+rQ5H8Oc4Yy4Men8o=
X-Gm-Gg: AYBFou1jtVZGC69J7IIFoSxXqgN1dwa3mX55SQNdvcfWPK7v+dSZkk8d3kkkAmb5RxH
 VJFPMv5Ad2Qn6YR7tWvetqS1NMQxa19lgqtrPfM032iA1EX167aYjifkNmpqMZyKZ6GEt/ZhTwE
 W6Le6b7HEbSSn8jEEnsMx6Z8Npop4m7XYmse3Mto0N9XFn/M7V4rN/8hedebhggu5cUerQeDo2Z
 A2GS24IOY98LcrphZu4GvYhmlLY8EG5tDTtVhFNS4oi8UYVkuYkqXNiwJ2dBb8WGl1m0K4KtgyS
 uSq6Q3K2xvqn1ZuAaQMRV/y/qSIFAJyxvASbWKBllf9jPnrPkwqmxWX3j7lE/Q5aA0bBoev+d1m
 HmIe4SqaEpNepOmuBJ8la0UqfdrodMq2FhziNu9RQonXcKbaBiEs2a/Y+NVo85Nl99V40j8FvfU
 rWmhPNBYE6yKyJp/Q3Of8symfDp+L0ZvIKuL1jhmFEpkZH386XeCJwl4rR1flGNi/7fLlxiJdfa
 A9L5Qer0CHOBXfq9tqneccuWiT1X3KRigrlU23vtSQ7GvNMBWLotur5Z+kS7gnu+WB4rwL9HVxB
 UfJdvSE6rX5iwa6GsEkU+2SElCKwyOU6HRVPCyngHWVlkGSLyTAhF0dWFU7UiaLr2GRdHHx3Unn
 ksf1hDGVuDqUd0F4KI5k5
X-Received: by 2002:a05:6870:1436:b0:49e:691c:1bdb with SMTP id
 586e51a60fabf-4a7dc1d606bmr2475845fac.32.1792620905167; 
 Wed, 21 Oct 2026 15:15:05 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a7d5ebc240sm2956084fac.2.2026.10.21.15.15.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 15:15:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Aleksei Sviridkin <f@lex.la>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Tianling Shen <cnsztl@gmail.com>, u-boot@lists.u-boot-project.org
In-Reply-To: <20260822205540.1223-1-f@lex.la>
References: <20260822205540.1223-1-f@lex.la>
Subject: Re: [PATCH] mtd: spinand: fmsh: add support for FM25G01B and FM25G02B
Message-Id: <179262090385.3382776.16880046334774770865.b4-ty@konsulko.com>
Date: Wed, 21 Oct 2026 16:15:03 -0600
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

On Sat, 22 Aug 2026 23:55:40 +0300, Aleksei Sviridkin wrote:

> Add the FudanMicro FM25G01B (1Gbit) and FM25G02B (2Gbit) SPI-NAND
> parts. Both have 2048-byte pages with 128 bytes of spare area, 64
> pages per erase block, and on-die ECC with a strength of 8 bits per
> 528-byte step. Their ECC status field is 3 bits wide and reports each
> bitflip count from four to eight separately, so it needs a decoder of
> its own instead of the coarse ranges the other parts in this file use.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] mtd: spinand: fmsh: add support for FM25G01B and FM25G02B
      commit: 903c9578eeb36d72f087082da494c605ddaed3b2
-- 
Tom


