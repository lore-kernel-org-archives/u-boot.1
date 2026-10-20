Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317B1606A31D
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 17:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ff9Nr5jl;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=bDPsiHFl
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 09BCA40976;
	Tue, 20 Oct 2026 17:26:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J5aFu5NQgfgp; Tue, 20 Oct 2026 17:26:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1B5FA40918
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792517196;
	b=J2loI16uq/JpeIpgGN4TGnn63QU7htcDwYd7vbAlKSiwvAz+L+wChI8bvHkW41ZVh5ce
	 alytfRwhzNjaTX8oqnblbffqInrHe5BAblBJggvGMkcE3x+Jk+8KTHYdqdeYAjQ7EbVuj
	 Wg42XRjmfEwf1rsLuPzQw2BEGuZz5hNYNCmQB/NRucAf0mfHHNkT6eIwUMLJ2bhFr6lxy
	 cIInSd2XlLE3EO0xV65QtdkA5Jgv7Ca+sLJH8VRFxiSAyyVq0xwp7bYyRRvNhypHYTPK+
	 D1zBUHSHYoFWCxRiPyACamLZGHtW/p0g0UjrKs5uaRFUr5CJ8AZnULHdx4nB/GdzpFg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792517196;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=c2NotH6uCpHDBP7Ge5Oqt0z4P8f8xo+K902eYTSmULk=;
	b=lqkXTkS6zX4xx32Rl9VEi3WbxM6aFq16FatJLzT2iXl8lmlORTPhB/hLAXN/ThCAg9CF
	 tKY0Zqn9/12dkDbfND27b5FRaUTMNfKLXA1ym0oujrHILpeYpZdsGF4+DhaCpeAISu9dS
	 Ik2UZGXlRAnHGW4NxHUfFg/XP6cyivbu+0YQQp2ApudnZzBn8dvhvB/sIjx5TAVL0SvVY
	 BtyZlue4gh1x81CiMeFqRnIWNi+EkOxkdh7kHubLIa/SL7spF/3bD2VjZEnknFQPHQrf9
	 sl95Idy0Oe56647rtO4Cn7T2UzHSWp7HNK6hbjDy2zxH03ssmQJofiTQDndL3BmPojg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792517196;
	bh=c2NotH6uCpHDBP7Ge5Oqt0z4P8f8xo+K902eYTSmULk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ff9Nr5jlTMBtJHaWqQQpm6IBdcD50cTxqzpC7Fuj/fY/u/DZYqkduyh6FpRRcugUY
	 T2BfpTvRGA3k0bxUXPriTs0tc/PUPaSNVZW67+vUsv3g5wtx2G54KcCH8HWDtv9kP9
	 0Pc5mqUJitqGqByoT0HbzlnrjhzpUsc1t7tSrlA6eAQatYIFa6li97kR2KH1XCoSY9
	 vqAPPab1sgoTxk5ZxhKf5rUDBErO5+D590UUYIp9WKDvtJTfqZCbNUTrMfB7bU0ySs
	 vJDAYC5Cs2WtJNIQDnVesUVmkID30OyqWZgzcRb0QoASxRzdZA93HiolofRY63Gng2
	 Imb1LlAshdLOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1B5FA40918;
	Tue, 20 Oct 2026 17:26:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 35DC8930
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:43:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 33517400CD
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:43:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iLu6zgf-prFO for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 16:43:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2004A40060
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792514607;
 b=oD6GkeGzn4KFIw1U7eCVFkGyX3J8mQzIcP/hfKRf8hdKa/XFzquU5MK9HtAWBGFL1GAT
 9sz/ljTdCAjWrX0d+7cUG+Sa/xqIyJZlp2dGsEOwSigHbwqTkkdVzAlOztVNHxDDgs2pA
 206KYsYQJttv+odwD/Uml/9TyhuxJ64+osoOKfJsO0gn/sVmNmpQprkUvUbIvFh0mL6Bw
 XNIeBq467mkl6BARPQzkD2ePTsEd/L47Y9CKew/mQmW2dQJAUXwZhuXMtq/UQI9EsVDC5
 /XBbu3pnqdFO1QEO9P6eyCILN0V5wKCXRAmISH3+qjAetHDj3EQURJdygWooVC3AerQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792514607;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=c2NotH6uCpHDBP7Ge5Oqt0z4P8f8xo+K902eYTSmULk=;
 b=JVis3sQDxaOL80BSczcAwbatz4l2QydRTy/xZO3C4lENgpHQTB8uUkmMr3v4sJpuuNKh
 Y91x7kHtKkXcA4mSXZMK4VUqRlW67KJqzD2XrAat1jOu6ha8hutClnLvgjgncXu2Ye1zD
 Vlh82cUBa8hFXhMFfnMmu8pcsNgKh+JL+r8Qb1kovE8mdNucdTceQP8nTcfcn1EjxOcGh
 IwQHazQBtZToJ3UOoVl9AOOyXQfQ4My45t5CNq6riY/22PzjvZnCKBPkDc95o14hF0tPC
 a9HhJMgwCB+P5nCCu/WLwmGKrEWG7GPD8cMOrXcBod8aYkThpPyATzRTmyEx9b3u9FA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=bDPsiHFl; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=bDPsiHFl
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2004A40060
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:43:25 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a1df146015so21279955e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1792514603; x=1793119403;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c2NotH6uCpHDBP7Ge5Oqt0z4P8f8xo+K902eYTSmULk=;
 b=bDPsiHFlAG5ctSCOQKZUlgzdOlWbnuvmIM/m/YQO/LJh9lL2vcEzJe6ta+lzXaH7oG
 bBgvXosHevuReGHrBESgOGWa8VOVRZNDZgi484dRJJQF0CPMVPbAU1h62j24lefXuQI7
 DdWT1ch47GCZkqleeC0Ygy1BKpM694flWm36H+X4j9YJwPCbiH2Vndt2jHGrEupWhHJp
 l8OTx3JvtOCbknUY/FrB3nq4HKnnz0UTXe5mA8WygJ3vg+xsVsXKHu2me6/MzfQh6ShN
 cxXbgvrhJjMJ4AhtAyBvfJFN4D4AsB3z9tsWMMXQbb284LB+tc7O7p+m1VVTuZ+aNdur
 EaRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792514603; x=1793119403;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c2NotH6uCpHDBP7Ge5Oqt0z4P8f8xo+K902eYTSmULk=;
 b=H2bXNMb9oDfREo9TOSv224UCrTEhhZZd81f6TBKWsRKmlJ7O7wnfmd93wM2EU9fKGP
 d/g9tJNjwXtZ3flkerGOsiN+LRRojF8QuJLvrewbdFTlpk+TII1fLxLkB62Mf+8ATFbl
 NeotaNuspwOzi8Qv2ZCOf4JQVcKi0N1BsKYfuZ7VwR1eFt7j/9N2c/Tnx/3szsqOF2+j
 XTaJ+OzxMmZCObVDiSOPB+IcyKvsOQCFYfG4hNrUQENU1Aj7xM5ov5+dOvQd3DfxdeCI
 dimIBVB1OYQfN1qUAJk2i0uUMj7F0KbZ6oJ4fA/6FalLJP6aqLTgJTAiTJBOu/fuqLpR
 0hKw==
X-Gm-Message-State: AFq9FYKFaN2WkImK4GaI8zRzOYj/+d4D7KBUH967UG4oFdohALKClimy
 owtYjYS05bYXOVPGq/rIvNmKZV4oEX6IoS6W5lsOOlQ95uTmbz7ieWdFUnmCrFDYp58=
X-Gm-Gg: AYBFou34Vcy3GqLpvb3JsuoQtciIFCKflZE9FrtWxAf05ETnv2aoX71LVPe2lleKf3W
 6N03nwaK9DrpoW7Uep1z5/R/or7n38aedyHDqA8zvRznm6ZXI0Xs4ByE+wmGM7e+Kq1+rk8/hiz
 GA4uMammmHmoTWHy1NFphK5u5tgGBcZS6PV65CdG1gGDHpXVrmCeXZ7u1sYvmYr0dmPwE0da8lA
 nRuXwlPiW+aVj/CPI1zDq5JAhtcy25lmtFUTSU2i+KGAIu3oUHIUVRp0FaRpm7tsPmx2u9f+kOA
 jwFsI7YkEGczMfO9sOe/NL3YQ5gba9FFXNOTufuVt+UyN87Aoc0TPIOy138izdPP9ZlHXFY0QN8
 eLOlHu6oQ+35a4r3YHhu3D4gxlsnkSIMn2y9It1cQdXS5oEaKjYRyV733w0uO2vAOUDMeaoe+mE
 lQuH88K4ZXBzxdvkMxxIL+pTk3D5vLAqloFLkrN8KhiTLZ+B3LN81Ymm7H3mESKHHaezoJTfPT9
 2t+xgYmxibML+BvhD1SoNWUyARnFFYKJdUZzr7/KTmZemJaSa2scw==
X-Received: by 2002:a05:600c:548c:b0:49f:dc71:e609 with SMTP id
 5b1f17b1804b1-4a1d7610f2dmr251229035e9.20.1792514603145; 
 Tue, 20 Oct 2026 09:43:23 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae.
 [86.98.194.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fc10de99sm643315e9.1.2026.10.20.09.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 09:43:22 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 20 Oct 2026 20:41:07 +0400
Subject: [PATCH v3 20/23] boot: fit: Allow choosing how SPL's FIT payload
 is compressed
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-spl-fit-compression-v3-20-6647aa23ade5@flipper.net>
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
In-Reply-To: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
To: u-boot@lists.u-boot-project.org, Sean Anderson <seanga2@gmail.com>
Cc: Alexey Charkov <alchark@flipper.net>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>, 
 Simon Glass <sjg@chromium.org>, Francesco Valla <francesco@valla.it>, 
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>, Max Merchel <max.merchel@ew.tq-group.com>, 
 u-boot@ew.tq-group.com, Petr Hodina <petr.hodina@protonmail.com>, 
 Bruno Banelli <bbanelli@gmail.com>, Carlo Caione <ccaione@baylibre.com>, 
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marex@nabladev.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Mehmet Fide <mehmet.fide@screeningeagle.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5505; i=alchark@flipper.net;
 h=from:subject:message-id; bh=wjhDcmpawvTZcgZQGJvLeX/g4qAruDhoxQBbCf7+oR8=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRdn7la9rdp59cd8+fk/d3s79pxYb/q0RP8b2o3qpwJb
 Xw3LVA+r2MiC4MYF4OlmCLL3G9LbKca8c3a5eHxFWYOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MzTSMdYxYuDiFICp7t/HyLC6r2ueqOL1y7VTkj7uy5V93VP2STfi1muehQt68l/mCGcxMhyzuCr
 y/al9lEjqm+ivPJMC9wZrPrFaJJ0xXfvWRss9JxkA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Tue, 20 Oct 2026 17:26:00 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Platforms which build the FIT that SPL loads have no say in how the
U-Boot proper payload inside it is compressed. The ones that compress at
all infer the algorithm from whichever SPL decompressor happens to be
enabled, so turning one on for an unrelated reason silently changes the
image, and asking for a particular algorithm is impossible.

Add a generic choice for it, covering every algorithm SPL can unpack,
where each option enables the decompressor that provides it, alongside a
companion compression level.

Gate it on HAVE_SPL_FIT_COMPRESSION so it is only offered where it does
something: a platform selects that once its image generation honours the
resulting string. Until then the choice stays hidden and the string reads
"none", so an image description may reference it unconditionally.

Offer the level only for algorithms whose tools take one, so that a new
algorithm has to opt in. Let 0 stand for passing none, which leaves a
tool's own level 0 (gzip's 'store') out of reach, as binman rejects it
anyway.

Leave sizing the SPL heap for zstd to the platform: it may come from
SPL_SYS_MALLOC_F_LEN, SPL_SYS_MALLOC_SIZE or a board-specific region, so
there is no single symbol to check it against.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 boot/Kconfig | 97 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/boot/Kconfig b/boot/Kconfig
index 8fcdc36c9318..cdad11918ff4 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -66,6 +66,15 @@ config BUTTON_CMD
 	    "button_cmd_0_name=vol_down"
 	    "button_cmd_0=fastboot usb 0"
 
+config HAVE_SPL_FIT_COMPRESSION
+	bool
+	help
+	  Selected by platforms which build the FIT containing the U-Boot
+	  proper by applying compression specified in SPL_FIT_UBOOT_COMP and
+	  SPL_FIT_UBOOT_COMP_LEVEL. This in turn shows the selection for those
+	  options in Kconfig, so that the user can configure any supported
+	  compression without the platform itself duplicating the boilerplate.
+
 menuconfig FIT
 	bool "Flattened Image Tree (FIT)"
 	select HASH
@@ -347,6 +356,94 @@ config SPL_FIT_IMAGE_POST_PROCESS
 	  injected into the FIT creation (i.e. the blobs would have been pre-
 	  processed before being added to the FIT image).
 
+choice
+	prompt "Compression for U-Boot proper in the FIT that SPL loads"
+	depends on SPL_FIT && HAVE_SPL_FIT_COMPRESSION
+	default SPL_FIT_UBOOT_COMP_NONE
+	help
+	  Pick how U-Boot proper is compressed in the FIT which SPL loads it
+	  from. SPL unpacks it on the way to its load address, so the image
+	  gets smaller and the boot gains a decompression step.
+
+	  Compress it where the storage it sits in is tight. Whether it also
+	  saves time depends on how fast that storage reads against how fast
+	  the SoC unpacks, so measure both on the board at hand rather than
+	  assuming either way.
+
+config SPL_FIT_UBOOT_COMP_NONE
+	bool "none"
+	help
+	  Store U-Boot proper in the FIT as it is. SPL copies it into place
+	  instead of unpacking it, and building the image needs no host
+	  compression tool.
+
+config SPL_FIT_UBOOT_COMP_GZIP
+	bool "gzip"
+	select SPL_GZIP
+	help
+	  Compress U-Boot proper in the FIT with gzip, using the host 'gzip'
+	  binary. A middling ratio, quick to unpack, and its decompressor
+	  needs less of the SPL heap than zstd does.
+
+config SPL_FIT_UBOOT_COMP_LZMA
+	bool "lzma"
+	select SPL_LZMA
+	help
+	  Compress U-Boot proper in the FIT with LZMA, using the host
+	  'lzma_alone' binary. The best ratio on offer, and by far the
+	  slowest to unpack.
+
+config SPL_FIT_UBOOT_COMP_LZO
+	bool "lzo"
+	select SPL_LZO
+	help
+	  Compress U-Boot proper in the FIT with LZO, using the host 'lzop'
+	  binary. A poor ratio in exchange for fast decompression.
+
+config SPL_FIT_UBOOT_COMP_LZ4
+	bool "lz4"
+	select SPL_LZ4
+	help
+	  Compress U-Boot proper in the FIT with LZ4, using the host 'lz4'
+	  binary. The fastest to unpack and the worst ratio, so it suits a
+	  fast boot medium.
+
+config SPL_FIT_UBOOT_COMP_ZSTD
+	bool "zstd"
+	select SPL_ZSTD
+	help
+	  Compress U-Boot proper in the FIT with Zstandard, using the host
+	  'zstd' binary. Close to the LZMA ratio for a fraction of the time,
+	  but its decompressor needs a workspace from the SPL heap, which has
+	  to be large enough to hold it - see SPL_ZSTD.
+
+endchoice
+
+config SPL_FIT_UBOOT_COMP
+	string
+	default "gzip" if SPL_FIT_UBOOT_COMP_GZIP
+	default "lzma" if SPL_FIT_UBOOT_COMP_LZMA
+	default "lzo" if SPL_FIT_UBOOT_COMP_LZO
+	default "lz4" if SPL_FIT_UBOOT_COMP_LZ4
+	default "zstd" if SPL_FIT_UBOOT_COMP_ZSTD
+	default "none"
+
+config SPL_FIT_UBOOT_COMP_LEVEL
+	int "Compression level for U-Boot proper"
+	depends on SPL_FIT_UBOOT_COMP_GZIP || SPL_FIT_UBOOT_COMP_LZO || \
+		   SPL_FIT_UBOOT_COMP_LZ4 || SPL_FIT_UBOOT_COMP_ZSTD
+	range 0 9 if SPL_FIT_UBOOT_COMP_GZIP || SPL_FIT_UBOOT_COMP_LZO
+	range 0 12 if SPL_FIT_UBOOT_COMP_LZ4
+	range 0 19 if SPL_FIT_UBOOT_COMP_ZSTD
+	default 0
+	help
+	  How hard to compress U-Boot proper, numbered the way the chosen
+	  algorithm's own tool numbers it, from 1 up.
+
+	  0 is not a level but asks for none to be given, leaving it to
+	  binman: that is the tool's own default, except for lz4, for which
+	  binman passes level 5.
+
 config TPL_FIT
 	bool "Support Flattened Image Tree within TPL"
 	depends on TPL

-- 
2.55.0

