Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA95ACCA463
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 04:36:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 65F3081496;
	Sat, 17 Oct 2026 04:36:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v295U9adjfyw; Sat, 17 Oct 2026 04:36:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 33FFE81514
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792211811;
	b=SVXJLHoC/F8apQGtxb+6k8WufMQtedrbV/39+jBI5PHP3c1W7kgSXcens8QCBTdKuXYK
	 c2TjVZzHijXq+7lQB6qurRivJu48SaLEhFVt5GqQXxeVUMvrdiQXjLwQ+rs4RKXQBluV3
	 qpCBkT6xqfUvIMYQqiDVrtuf4S8Zm7VXwpgFf5kbCV9gBs+HQB1xWNSt0yhjLK8Jo05eJ
	 2FR6sYTCu3FGd5qyK1/3d/QmPgwjz4qVZb+OY8WuwdFFMJTscy5MuVX+dH3bP1UNMvneq
	 K9aY+jY27hACk8koSlydmDyW3kSo5sLEXxmsmduwhqx/AX0IXBfNdrst7g9NwzQ2QnA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792211811;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=e2yXDw3Si8AlPZO422Z6UIaQ/P8DGHTmdCnwfqKa/oE=;
	b=pu52rYeWFYUjX5glMtO85oZysUIQ8QCaS1KkAJ53pNatXzbAngoKFQCSM12mbjKQuoRu
	 fBUSZSDi5yJACikcSUsO1G4HHBgfmlk6ix6rGHdJSAWAHo20fguH/yZbleHX73H2bqokL
	 DHdruwuiN7UFY7emzVgVvaMv+JXyK+ZV+qPJaGpnrjx7OMwDm/gUq3IJnghPa9SOIeE96
	 0RGDQcZNi3uTaZXWrcosaMKeURvx8dGFG3ycuCvmd/M6pJJEnGvPlSlTiL3IZ1LCYMJ4/
	 5yzLMOevNQWR8ohpLfC27aFeqe6/lYI7rdnN+YRtQcqLLN5tKz4dJb2PH1J+yoCAVNw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792211811;
	bh=e2yXDw3Si8AlPZO422Z6UIaQ/P8DGHTmdCnwfqKa/oE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EtWUw0fpATGPmoFtDjGTJMBXuZ6crOA/da1E4irnMqm3Z/vX3sEWgMmFojU067hVb
	 hMQA4z4J1iPfkYEzUjranoPk5r/gnhK3dMTBbE3NI9EKTlGfLNk9p2GHqytHGYGTyJ
	 0O7jGQck9ozQU5gJk4+EzeKouGpuiYoBY7N4UIpe/ecJpNF3uNkVRu8QTLrS1Y/Z65
	 21oSzqJgccAn7qd6KNM2rIPJ+7rHlCY0Hxmnf+AQvAp2mHUq0gdtXxKJrSIxGLOou0
	 2woeu7NTgyeQzjeZRKStzJBhDozkz9coAF7L7OoJJF9h8VQPbVvreNotAl3bwkZWLO
	 aqPYxP3LP/dbw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 33FFE81514;
	Sat, 17 Oct 2026 04:36:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 734F5362
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:36:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6220460A7E
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:36:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EbC6HU-Dj3OK for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 00:36:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D867E60AEC
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792197384;
 b=NrlrpEbqih3Y0Xx1BjroPla7zVlBN79z0+xvmUjjbtDEACq8by+cfnGA6kajbttqBB7r
 UaSoc0LDSGwF/SNfptnYJOcPgZ20DsvcIone3zk3p6f3I2cdwA5SIkvU0dluOhpv3Iyi9
 hnw+b0WZVv5Bd16fr1XYlkDv0RJFrDXNBirtTgEq6la7g4PtMeGci5dHGYUdlA1MCvePN
 BqruyGT+rffHxJJmUIdeG/4uDMVR0PMD3gD8LUGZpP43bAh2JsIhXp/ue0qoA+Ii1Z0R6
 3W7sTRr3LwpAaqzdLIYNgLvg9pqotJuisDSlB5kiX97lw4HwYT5fSUYaPUbfFTkAhvw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792197384;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=e2yXDw3Si8AlPZO422Z6UIaQ/P8DGHTmdCnwfqKa/oE=;
 b=TVkdhsNJv67sUwojte5jUPILH/XMbVNs8ce/vN2li5cesa7V5ybVtbIFXsZQXnjyDHFj
 f0Xj0z+vMCkt1LJ3drqSPwLtqd6Q7GrMsLcczlRnpzH2EEIRPLxE/GYdZRyQR02bugUNZ
 Bz3a3oorcSDF4ovjc/AYSlPTLD4TBBPIEib40QR1C7WFSatH9IpXV9zPILinEKPBR2S9U
 FKOGpIa/KcjZlp7v2bz9RlIoBKQ1UOzSZ29RP+gOCD9656/MnJHW8MygnSBWPYnsCZv2W
 lRAHlG6VYMjcsn0qZ3UBNAm36RIrTVR5huocdiGcofItEepaE58jQY8q3gbBjmdSPTQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="Cg/zExlU"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Cg/zExlU
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D867E60AEC
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:36:21 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-81ba09a5d23so257369a34.3
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 17:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792197381; x=1792802181;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e2yXDw3Si8AlPZO422Z6UIaQ/P8DGHTmdCnwfqKa/oE=;
 b=Cg/zExlUn3keku+LBPxn+V9SHl7GugVWPqyGs951F9GfboBq7tI6zKQTpHUj2kGKWu
 LFUWkkWv5KzhJg+MMFNcuAbM0ZOMEvNoTBeXrP7IcksdF0wbnyqEHNEy3KGiJgBCu8Pf
 qENKvAM4dGN7aLZQ1jf3lfRzVVuyrkRkjM2ObcoThiVxW1GwM8WuZZpRbDKDVNALoVXN
 5UeYhSZ8IWGbZLt3EwtcJE6j/ULsc71H8aU36a/TELEVJXfaUd1uG/OkMmT6VT/Nvl41
 eRN20yKneqC9Uu+LqWlaXIswDGXgxYKJVGmYcay2C9jIpahaVoUtI1FUebogSiJGzuPS
 FzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792197381; x=1792802181;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e2yXDw3Si8AlPZO422Z6UIaQ/P8DGHTmdCnwfqKa/oE=;
 b=LDftzmApcSaUKklIZOAMI69MPb+1ozzilNPp3XzqD1IfwrdH689JvPNhBPmTEE65g5
 2IOfMUM1CpgZeUko7f/oTnH0g0aRkRbKP9q7S4xoe5zWEw4IktdSVdxRtfgrqrZ0D6+4
 cFAAkKYFqUruIBO5Hd02Z3jc77UQndp9ZcRHE7gHeeruFFk7tmtqJVFovUU3psHn+79R
 7bZl7dfhSrVpyuzczDUtfPQzah05oFMvbU+JgVcjb/1rPun3xGiItAuQmLiRSzI/M7vX
 QXQ2IzpTFW9C08tkxS9MgxS5cYX5/a2ksNXacad1WLNKeU1bR5Avv7aGUGA1p22lB1dj
 QsQQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxEwHMLz/rgu2tsTiTmDhyxYdXBivLPNFOPnnCNkPlI/6ettMY1+v56pytE0N0O7r+AKIvRSU8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLpSHeqdsLw9PDNHpMzlWSoB09V5tqXq3uey/VA4JJc85c6QmPG
 JDRO2OToaNWBireCzCSrktEXTT4hyx8F2Z1xWuswjC1+OoTtJ5AGJF95
X-Gm-Gg: AYBFou1bmJK7M3C1g4VDEEhDjyA/qSFuheEdM+7zjIZ8Vw+/0Ih0zCbPABjQbcuKoT+
 HjwyJajtXsUNTspY8G7B9ke2JkvQSBm+SoUADIsiEYobMgyAt6lry9y2tOV4Opvbdtg7P/0jE09
 ctrFbtXlLxhtCZNGPEyvCour5JdZY6Xejij8iCTGjzfixPnJblQwIXUQV605vPW4XdVwiV+OG19
 vHsWh78vU+VZIN2PgVsMxybml02rwualofsvBT6s3x1MNxFifH87wIYQ27V3Xa9V0O3GJQtfvWa
 4Fn7v97bLNi0ofIivvmgkrcTPLKEyyaxWhRoL+Y1bAh68HoQQINP8QSIkHcFJuro8RjXNMgIJ9F
 AbVv45vZYd6KqFolqqQpWKl7SXmIfhKsHjiJcHUM0ReeS095swMjYYPnaBGGzf5F/ohiskQUKUZ
 4mRYa7D8YrlU8E3esczzrQ58f1Jnp0Gvd1HVPxw/LbG6pBh6jMXKsXa3YjbLxrtHQNwYBsFjmYz
 XFCMM0fvYGjpJa90Yst4P179jvMsZdJIJ1BuaUifqYOcj/joH8KyhiyPnqlcFexylIiLQn6B6ys
 sZJJ65BPS6jQjAc2XZPw21Frsh7zeRbqN6KvBh1IiUeNlXVElFBcgExSq9XEZ/k7F9FTp9h4S5Q
 Pqp/Kc59d46D1lzJ1NulYaQ==
X-Received: by 2002:a05:6870:a0af:b0:494:a6ba:53de with SMTP id
 586e51a60fabf-4a757bc7c11mr1422281fac.60.1792197380581; 
 Fri, 16 Oct 2026 17:36:20 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a73b5b4291sm2745091fac.5.2026.10.16.17.36.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 17:36:19 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 16 Oct 2026 18:35:28 -0600
Subject: [PATCH v9 14/17] lib: ecdsa: support additional curve sizes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-submit-ce-series-v2-v9-14-c24e64daafe9@gmail.com>
References: <20261016-submit-ce-series-v2-v9-0-c24e64daafe9@gmail.com>
In-Reply-To: <20261016-submit-ce-series-v2-v9-0-c24e64daafe9@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 u-boot@lists.u-boot-project.org
Cc: Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Thierry Reding <treding@nvidia.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marek.vasut@mailbox.org>, Rasmus Villemoes <ravi@prevas.dk>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, Francois Berder <fberder@outlook.fr>, 
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Randolph Sapp <rs@ti.com>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Alexey Charkov <alchark@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Anshul Dalal <anshuld@ti.com>, Johan Jonker <jbx6244@gmail.com>, 
 Francesco Valla <francesco@valla.it>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michael Walle <mwalle@kernel.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 E Shattow <e@freeshell.de>, Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Stuebner <heiko@sntech.de>, Vincent Jardin <vjardin@free.fr>, 
 Raymond Mao <raymondmaoca@gmail.com>, Yao Zi <me@ziyao.cc>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Michael Srba <Michael.Srba@seznam.cz>, 
 Pranav Rajendran <pranavkasthuri@gmail.com>, 
 Carlo Caione <ccaione@baylibre.com>, Alexey Charkov <alchark@flipper.net>, 
 Lukasz Majewski <lukma@nabladev.com>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Sat, 17 Oct 2026 04:36:15 +0000
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

Hardware verifiers can support secp224r1 in addition to the curves already
handled by the FIT code. Share the curve-size lookup between the host and
target paths, add the ecdsa224 algorithm, and retain both upstream names
for P-521: ecdsa521 and secp521r1.

Use BN_bn2binpad() to export public-key values without modifying the
BIGNUM or allocating temporary arithmetic objects. Preserve the existing
big-endian, 32-bit-cell-padded FDT encoding, including the 68-byte P-521
coordinates. RSA key properties retain their existing encoding too.
Keep fdt_add_bignum() errors in the libfdt namespace so callers can retry
when the destination FDT needs to grow.

Clean up the libcrypto signing context so raw signatures are owned and
freed consistently on error paths. Exercise all four curves and both
P-521 names in the host FIT signing test, check the exported coordinate
widths and values, and verify the signatures using the exported keys.

SPL ECDSA verification uses UCLASS_ECDSA, so make SPL_ECDSA_VERIFY
depend on SPL_DM.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v8 -> v9:
  - Reconcile with upstream P-521 and software ECDSA support, preserving
    the 32-bit-cell-padded key encoding and both P-521 algorithm names
  - Check exported public-key coordinates and verify FIT signatures using
    those keys in the host curve tests
  - Drop documentation changes; the existing format description remains
    correct with the preserved encoding
  - Leave existing key-loading and verification diagnostics unchanged

Changes v3 -> v4:
  - Exercise secp224r1, prime256v1, secp384r1 and secp521r1 signing

Changes v1 -> v2:
  - Explain the RSA impact of fdt_add_bignum()  (suggested by Simon Glass)
  - Document ECDSA public key byte-array widths  (suggested by Simon Glass)
  - Document ecdsa_curve_size()  (suggested by Simon Glass)
  - Keep fdt_add_bignum() errors in libfdt space
    (suggested by Simon Glass)
  - Explain the SPL_DM dependency  (suggested by Simon Glass)
---
 include/u-boot/ecdsa.h          |  22 +++++++
 include/u-boot/fdt-libcrypto.h  |   4 +-
 lib/ecdsa/Kconfig               |   2 +-
 lib/ecdsa/ecdsa-libcrypto.c     | 132 +++++++++++++++++++++++++---------------
 lib/ecdsa/ecdsa-verify.c        |  26 +++-----
 lib/fdt-libcrypto.c             |  60 ++++--------------
 test/py/tests/test_fit_ecdsa.py |  40 +++++++++---
 tools/image-sig-host.c          |   7 +++
 8 files changed, 167 insertions(+), 126 deletions(-)

diff --git a/include/u-boot/ecdsa.h b/include/u-boot/ecdsa.h
index f0ac0f327e9..3d70b138026 100644
--- a/include/u-boot/ecdsa.h
+++ b/include/u-boot/ecdsa.h
@@ -8,6 +8,7 @@
 
 #include <errno.h>
 #include <image.h>
+#include <string.h>
 
 /**
  * crypto_algo API impementation for ECDSA;
@@ -64,8 +65,29 @@ int ecdsa_verify(struct image_sign_info *info,
 		 uint8_t *sig, uint sig_len);
 /** @} */
 
+#define ECDSA224_BYTES	(224 / 8)
 #define ECDSA256_BYTES	(256 / 8)
 #define ECDSA384_BYTES	(384 / 8)
 #define ECDSA521_BYTES	((521 + 7) / 8)
 
+/**
+ * ecdsa_curve_size() - Get the size in bits for a named ECDSA curve
+ *
+ * @curve_name: OpenSSL short name for the curve
+ * Return: curve size in bits, or 0 if @curve_name is not supported
+ */
+static inline unsigned int ecdsa_curve_size(const char *curve_name)
+{
+	if (!strcmp(curve_name, "secp224r1"))
+		return 224;
+	else if (!strcmp(curve_name, "prime256v1"))
+		return 256;
+	else if (!strcmp(curve_name, "secp384r1"))
+		return 384;
+	else if (!strcmp(curve_name, "secp521r1"))
+		return 521;
+
+	return 0;
+}
+
 #endif
diff --git a/include/u-boot/fdt-libcrypto.h b/include/u-boot/fdt-libcrypto.h
index b15d8a1eaf4..aa15561e225 100644
--- a/include/u-boot/fdt-libcrypto.h
+++ b/include/u-boot/fdt-libcrypto.h
@@ -19,9 +19,9 @@
  * @prop_name:	What to call the property in the FDT
  * @num:	pointer to a libcrypto big number
  * @num_bits:	How big is 'num' in bits?
- * Return: 0 if all good all working, -ve on horror
+ * Return: 0 on success, negative libfdt error on failure
  */
 int fdt_add_bignum(void *blob, int noffset, const char *prop_name,
-		   BIGNUM *num, int num_bits);
+		   const BIGNUM *num, int num_bits);
 
 #endif /* _FDT_LIBCRYPTO_H */
diff --git a/lib/ecdsa/Kconfig b/lib/ecdsa/Kconfig
index dac8bcf23dd..5be8f9eeac4 100644
--- a/lib/ecdsa/Kconfig
+++ b/lib/ecdsa/Kconfig
@@ -18,7 +18,7 @@ config ECDSA_VERIFY
 
 config SPL_ECDSA_VERIFY
 	bool "Enable ECDSA verification support in SPL"
-	depends on SPL
+	depends on SPL && SPL_DM
 	help
 	  Allow ECDSA signatures to be recognized and verified in SPL.
 
diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
index 5e69782424c..bb4cc89a5a5 100644
--- a/lib/ecdsa/ecdsa-libcrypto.c
+++ b/lib/ecdsa/ecdsa-libcrypto.c
@@ -33,7 +33,7 @@ struct signer {
 	EVP_PKEY *evp_key;	/* Pointer to EVP_PKEY object */
 	EC_KEY *ecdsa_key;	/* Pointer to EC_KEY object */
 	void *hash;		/* Pointer to hash used for verification */
-	void *signature;	/* Pointer to output signature. Do not free()!*/
+	void *signature;	/* Pointer to raw signature buffer */
 };
 
 struct ecdsa_public_key {
@@ -78,13 +78,8 @@ static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
 	if (!key->curve_name)
 		return -ENOMSG;
 
-	if (!strcmp(key->curve_name, "prime256v1"))
-		key->size_bits = 256;
-	else if (!strcmp(key->curve_name, "secp384r1"))
-		key->size_bits = 384;
-	else if (!strcmp(key->curve_name, "secp521r1"))
-		key->size_bits = 521;
-	else
+	key->size_bits = ecdsa_curve_size(key->curve_name);
+	if (!key->size_bits)
 		return -EINVAL;
 
 	key->x = fdt_getprop(fdt, node, "ecdsa,x-point", &x_len);
@@ -148,13 +143,8 @@ static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
 		return ret;
 	}
 
-	if (!strcmp(pubkey.curve_name, "prime256v1")) {
-		nid = NID_X9_62_prime256v1;
-	} else if (!strcmp(pubkey.curve_name, "secp384r1")) {
-		nid = NID_secp384r1;
-	} else if (!strcmp(pubkey.curve_name, "secp521r1")) {
-		nid = NID_secp521r1;
-	} else {
+	nid = OBJ_sn2nid(pubkey.curve_name);
+	if (nid == NID_undef) {
 		fprintf(stderr, "Unsupported curve name: '%s'\n", pubkey.curve_name);
 		fdt_free_key(&pubkey);
 		return -EINVAL;
@@ -211,7 +201,7 @@ static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
 	return 0;
 }
 
-static int alloc_ctx(struct signer *ctx, const struct image_sign_info *info)
+static int init_ctx(struct signer *ctx)
 {
 	memset(ctx, 0, sizeof(*ctx));
 
@@ -220,11 +210,21 @@ static int alloc_ctx(struct signer *ctx, const struct image_sign_info *info)
 		return -1;
 	}
 
+	return 0;
+}
+
+static int alloc_sig_ctx(struct signer *ctx, const struct image_sign_info *info)
+{
 	ctx->hash = malloc(info->checksum->checksum_len);
 	ctx->signature = malloc(info->crypto->key_len * 2);
 
-	if (!ctx->hash || !ctx->signature)
+	if (!ctx->hash || !ctx->signature) {
+		free(ctx->hash);
+		free(ctx->signature);
+		ctx->hash = NULL;
+		ctx->signature = NULL;
 		return -ENOMEM;
+	}
 
 	return 0;
 }
@@ -237,8 +237,8 @@ static void free_ctx(struct signer *ctx)
 	if (ctx->evp_key)
 		EVP_PKEY_free(ctx->evp_key);
 
-	if (ctx->hash)
-		free(ctx->hash);
+	free(ctx->hash);
+	free(ctx->signature);
 }
 
 /*
@@ -274,7 +274,12 @@ static ECDSA_SIG *ecdsa_sig_from_raw(void *buf, size_t order)
 	s_buf = (uintptr_t)buf + point_bytes;
 	r = BN_bin2bn(buf, point_bytes, NULL);
 	s = BN_bin2bn((void *)s_buf, point_bytes, NULL);
-	ECDSA_SIG_set0(sig, r, s);
+	if (!r || !s || !ECDSA_SIG_set0(sig, r, s)) {
+		BN_free(r);
+		BN_free(s);
+		ECDSA_SIG_free(sig);
+		return NULL;
+	}
 
 	return sig;
 }
@@ -342,10 +347,6 @@ static int load_key_from_fdt(struct signer *ctx, const struct image_sign_info *i
 	if (!fdt)
 		return -EINVAL;
 
-	ret = alloc_ctx(ctx, info);
-	if (ret)
-		return ret;
-
 	sig_node = fdt_subnode_offset(fdt, 0, FIT_SIG_NODENAME);
 	if (sig_node < 0) {
 		fprintf(stderr, "No /signature node found\n");
@@ -402,7 +403,9 @@ static int prepare_ctx(struct signer *ctx, const struct image_sign_info *info)
 	int key_len_bytes, ret;
 	char kname[1024];
 
-	memset(ctx, 0, sizeof(*ctx));
+	ret = init_ctx(ctx);
+	if (ret)
+		return ret;
 
 	if (info->fdt_blob) {
 		return load_key_from_fdt(ctx, info);
@@ -416,10 +419,6 @@ static int prepare_ctx(struct signer *ctx, const struct image_sign_info *info)
 		return -EINVAL;
 	}
 
-	ret = alloc_ctx(ctx, info);
-	if (ret)
-		return ret;
-
 	ret = read_key(ctx, kname);
 	if (ret)
 		return ret;
@@ -439,11 +438,18 @@ static int do_sign(struct signer *ctx, struct image_sign_info *info,
 {
 	const struct checksum_algo *algo = info->checksum;
 	ECDSA_SIG *sig;
+	int ret;
+
+	ret = algo->calculate(algo->name, region, region_count, ctx->hash);
+	if (ret)
+		return ret;
 
-	algo->calculate(algo->name, region, region_count, ctx->hash);
 	sig = ECDSA_do_sign(ctx->hash, algo->checksum_len, ctx->ecdsa_key);
+	if (!sig)
+		return -EIO;
 
 	ecdsa_sig_encode_raw(ctx->signature, sig, info->crypto->key_len);
+	ECDSA_SIG_free(sig);
 
 	return 0;
 }
@@ -461,9 +467,15 @@ static int ecdsa_check_signature(struct signer *ctx, struct image_sign_info *inf
 			       sig, ctx->ecdsa_key);
 	if (!okay)
 		fprintf(stderr, "WARNING: Signature is fake news!\n");
+	else if (okay < 0)
+		fprintf(stderr, "ERROR: ECDSA signature verification failed\n");
 
 	ECDSA_SIG_free(sig);
-	return !okay;
+
+	if (okay == 1)
+		return 0;
+
+	return okay < 0 ? -EIO : -EPERM;
 }
 
 static int do_verify(struct signer *ctx, struct image_sign_info *info,
@@ -471,6 +483,7 @@ static int do_verify(struct signer *ctx, struct image_sign_info *info,
 		     uint8_t *raw_sig, uint sig_len)
 {
 	const struct checksum_algo *algo = info->checksum;
+	int ret;
 
 	if (sig_len != info->crypto->key_len * 2) {
 		fprintf(stderr, "Signature has wrong length\n");
@@ -478,7 +491,9 @@ static int do_verify(struct signer *ctx, struct image_sign_info *info,
 	}
 
 	memcpy(ctx->signature, raw_sig, sig_len);
-	algo->calculate(algo->name, region, region_count, ctx->hash);
+	ret = algo->calculate(algo->name, region, region_count, ctx->hash);
+	if (ret)
+		return ret;
 
 	return ecdsa_check_signature(ctx, info);
 }
@@ -491,11 +506,16 @@ int ecdsa_sign(struct image_sign_info *info, const struct image_region region[],
 
 	ret = prepare_ctx(&ctx, info);
 	if (ret >= 0) {
-		do_sign(&ctx, info, region, region_count);
-		*sigp = ctx.signature;
-		*sig_len = info->crypto->key_len * 2;
-
-		ret = ecdsa_check_signature(&ctx, info);
+		ret = alloc_sig_ctx(&ctx, info);
+		if (!ret)
+			ret = do_sign(&ctx, info, region, region_count);
+		if (!ret)
+			ret = ecdsa_check_signature(&ctx, info);
+		if (!ret) {
+			*sigp = ctx.signature;
+			*sig_len = info->crypto->key_len * 2;
+			ctx.signature = NULL;
+		}
 	}
 
 	free_ctx(&ctx);
@@ -510,8 +530,12 @@ int ecdsa_verify(struct image_sign_info *info,
 	int ret;
 
 	ret = prepare_ctx(&ctx, info);
-	if (ret >= 0)
-		ret = do_verify(&ctx, info, region, region_count, sig, sig_len);
+	if (ret >= 0) {
+		ret = alloc_sig_ctx(&ctx, info);
+		if (!ret)
+			ret = do_verify(&ctx, info, region, region_count,
+					sig, sig_len);
+	}
 
 	free_ctx(&ctx);
 	return ret;
@@ -577,42 +601,54 @@ static int do_add(struct signer *ctx, void *fdt, const char *key_node_name,
 	group = EC_KEY_get0_group(ctx->ecdsa_key);
 	key_bits = EC_GROUP_order_bits(group);
 	curve_name = OBJ_nid2sn(EC_GROUP_get_curve_name(group));
-	/* Let 'x' and 'y' memory leak by not BN_free()'ing them. */
 	x = BN_new();
 	y = BN_new();
+	if (!x || !y) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
 	point = EC_KEY_get0_public_key(ctx->ecdsa_key);
-	EC_POINT_get_affine_coordinates(group, point, x, y, NULL);
+	if (!EC_POINT_get_affine_coordinates(group, point, x, y, NULL)) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	ret = fdt_setprop_string(fdt, key_node, FIT_KEY_HINT,
 				 info->keyname);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	ret = fdt_setprop_string(fdt, key_node, "ecdsa,curve", curve_name);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	ret = fdt_add_bignum(fdt, key_node, "ecdsa,x-point", x, key_bits);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	ret = fdt_add_bignum(fdt, key_node, "ecdsa,y-point", y, key_bits);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	ret = fdt_setprop_string(fdt, key_node, FIT_ALGO_PROP,
 				 info->name);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	if (info->require_keys) {
 		ret = fdt_setprop_string(fdt, key_node, FIT_KEY_REQUIRED,
 					 info->require_keys);
 		if (ret < 0)
-			return ret;
+			goto out;
 	}
 
-	return key_node;
+	ret = key_node;
+
+out:
+	BN_free(x);
+	BN_free(y);
+	return ret;
 }
 
 int ecdsa_add_verify_data(struct image_sign_info *info, void *fdt)
diff --git a/lib/ecdsa/ecdsa-verify.c b/lib/ecdsa/ecdsa-verify.c
index 341486de2d3..26e8590cd4a 100644
--- a/lib/ecdsa/ecdsa-verify.c
+++ b/lib/ecdsa/ecdsa-verify.c
@@ -13,24 +13,6 @@
 #include <malloc.h>
 #include <u-boot/ecdsa.h>
 
-/*
- * Derive size of an ECDSA key from the curve name
- *
- * While it's possible to extract the key size by using string manipulation,
- * use a list of known curves for the time being.
- */
-static int ecdsa_key_size(const char *curve_name)
-{
-	if (!strcmp(curve_name, "prime256v1"))
-		return 256;
-	else if (!strcmp(curve_name, "secp384r1"))
-		return 384;
-	else if (!strcmp(curve_name, "secp521r1"))
-		return 521;
-
-	return 0;
-}
-
 /*
  * This function fills keys with valid pointers (x and y) so
  * the caller must then free those pointers with fdt_free_key().
@@ -49,7 +31,7 @@ static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
 		return -ENOMSG;
 	}
 
-	key->size_bits = ecdsa_key_size(key->curve_name);
+	key->size_bits = ecdsa_curve_size(key->curve_name);
 	if (key->size_bits == 0) {
 		debug("Unknown ECDSA curve '%s'", key->curve_name);
 		return -EINVAL;
@@ -174,6 +156,12 @@ int ecdsa_verify(struct image_sign_info *info,
 	return ecdsa_verify_hash(dev, info, hash, sig, sig_len);
 }
 
+U_BOOT_CRYPTO_ALGO(ecdsa224) = {
+	.name = "ecdsa224",
+	.key_len = ECDSA224_BYTES,
+	.verify = ecdsa_verify,
+};
+
 U_BOOT_CRYPTO_ALGO(ecdsa256) = {
 	.name = "ecdsa256",
 	.key_len = ECDSA256_BYTES,
diff --git a/lib/fdt-libcrypto.c b/lib/fdt-libcrypto.c
index 090246b44e9..bd9d0907a0e 100644
--- a/lib/fdt-libcrypto.c
+++ b/lib/fdt-libcrypto.c
@@ -5,68 +5,34 @@
  */
 
 #include <libfdt.h>
+#include <stdio.h>
+#include <stdlib.h>
 #include <u-boot/fdt-libcrypto.h>
 
 int fdt_add_bignum(void *blob, int noffset, const char *prop_name,
-		   BIGNUM *num, int num_bits)
+		   const BIGNUM *num, int num_bits)
 {
-	int nwords = (num_bits + 31) / 32;
-	int size;
-	uint32_t *buf, *ptr;
-	BIGNUM *tmp, *big2, *big32, *big2_32;
-	BN_CTX *ctx;
+	int size = ((num_bits + 31) / 32) * sizeof(uint32_t);
+	unsigned char *buf;
 	int ret;
 
-	tmp = BN_new();
-	big2 = BN_new();
-	big32 = BN_new();
-	big2_32 = BN_new();
+	if (size <= 0)
+		return -FDT_ERR_BADVALUE;
 
-	/*
-	 * Note: This code assumes that all of the above succeed, or all fail.
-	 * In practice memory allocations generally do not fail (unless the
-	 * process is killed), so it does not seem worth handling each of these
-	 * as a separate case. Technicaly this could leak memory on failure,
-	 * but a) it won't happen in practice, and b) it doesn't matter as we
-	 * will immediately exit with a failure code.
-	 */
-	if (!tmp || !big2 || !big32 || !big2_32) {
-		fprintf(stderr, "Out of memory (bignum)\n");
-		return -ENOMEM;
-	}
-	ctx = BN_CTX_new();
-	if (!ctx) {
-		fprintf(stderr, "Out of memory (bignum context)\n");
-		return -ENOMEM;
-	}
-	BN_set_word(big2, 2L);
-	BN_set_word(big32, 32L);
-	BN_exp(big2_32, big2, big32, ctx); /* B = 2^32 */
-
-	size = nwords * sizeof(uint32_t);
 	buf = malloc(size);
 	if (!buf) {
 		fprintf(stderr, "Out of memory (%d bytes)\n", size);
-		return -ENOMEM;
+		return -FDT_ERR_NOSPACE;
 	}
 
-	/* Write out modulus as big endian array of integers */
-	for (ptr = buf + nwords - 1; ptr >= buf; ptr--) {
-		BN_mod(tmp, num, big2_32, ctx); /* n = N mod B */
-		*ptr = cpu_to_fdt32(BN_get_word(tmp));
-		BN_rshift(num, num, 32); /*  N = N/B */
+	if (BN_bn2binpad(num, buf, size) != size) {
+		free(buf);
+		return -FDT_ERR_BADVALUE;
 	}
 
-	/*
-	 * We try signing with successively increasing size values, so this
-	 * might fail several times
-	 */
+	/* Callers may retry with a larger FDT if the property does not fit. */
 	ret = fdt_setprop(blob, noffset, prop_name, buf, size);
 	free(buf);
-	BN_free(tmp);
-	BN_free(big2);
-	BN_free(big32);
-	BN_free(big2_32);
 
-	return ret ? -FDT_ERR_NOSPACE : 0;
+	return ret;
 }
diff --git a/test/py/tests/test_fit_ecdsa.py b/test/py/tests/test_fit_ecdsa.py
index e59390374af..d1180d5ecfd 100644
--- a/test/py/tests/test_fit_ecdsa.py
+++ b/test/py/tests/test_fit_ecdsa.py
@@ -11,6 +11,7 @@ This test doesn't run the sandbox. It only checks the host tool 'mkimage'
 """
 
 import os
+import shutil
 import pytest
 import utils
 from Cryptodome.Hash import SHA256
@@ -50,12 +51,13 @@ class SignableFitImage(object):
 
         return self.signable_nodes
 
-    def change_signature_algo_to_ecdsa(self):
+    def change_signature_algo_to_ecdsa(self, algo):
         for image in self.signable_nodes:
-            self.__fdt_set(f'{image}/signature', algo='sha256,ecdsa256')
+            self.__fdt_set(f'{image}/signature', algo=f'sha256,{algo}')
 
-    def sign(self, mkimage, key_file):
-        utils.run_and_log(self.ubman, [mkimage, '-F', self.fit, f'-G{key_file}'])
+    def sign(self, mkimage, key_file, key_dest):
+        utils.run_and_log(self.ubman, [mkimage, '-F', self.fit, f'-G{key_file}',
+                                      '-K', key_dest, '-r'])
 
     def check_signatures(self, key):
         for image in self.signable_nodes:
@@ -71,10 +73,17 @@ class SignableFitImage(object):
 @pytest.mark.requiredtool('dtc')
 @pytest.mark.requiredtool('fdtget')
 @pytest.mark.requiredtool('fdtput')
-def test_fit_ecdsa(ubman):
+@pytest.mark.parametrize('curve, algo', (
+    ('secp224r1', 'ecdsa224'),
+    ('prime256v1', 'ecdsa256'),
+    ('secp384r1', 'ecdsa384'),
+    ('secp521r1', 'ecdsa521'),
+    ('secp521r1', 'secp521r1'),
+))
+def test_fit_ecdsa(ubman, curve, algo):
     """ Test that signatures generated by mkimage are legible. """
     def generate_ecdsa_key():
-        return ECC.generate(curve='prime256v1')
+        return ECC.generate(curve=curve)
 
     def assemble_fit_image(dest_fit, its, destdir):
         dtc_args = f'-I dts -O dtb -i {destdir}'
@@ -86,11 +95,13 @@ def test_fit_ecdsa(ubman):
 
     mkimage = ubman.config.build_dir + '/tools/mkimage'
     datadir = ubman.config.source_dir + '/test/py/tests/vboot/'
-    tempdir = os.path.join(ubman.config.result_dir, 'ecdsa')
+    tempdir = os.path.join(ubman.config.result_dir, f'ecdsa-{algo}')
     os.makedirs(tempdir, exist_ok=True)
     key_file = f'{tempdir}/ecdsa-test-key.pem'
     fit_file = f'{tempdir}/test.fit'
     dtc('sandbox-kernel.dts')
+    key_dest = f'{tempdir}/key.dtb'
+    shutil.copyfile(f'{tempdir}/sandbox-kernel.dtb', key_dest)
 
     key = generate_ecdsa_key()
 
@@ -109,6 +120,17 @@ def test_fit_ecdsa(ubman):
     if len(nodes) == 0:
         raise ValueError('FIT image has no "/image" nodes with "signature"')
 
-    fit.change_signature_algo_to_ecdsa()
-    fit.sign(mkimage, key_file)
+    fit.change_signature_algo_to_ecdsa(algo)
+    fit.sign(mkimage, key_file, key_dest)
     fit.check_signatures(key)
+
+    # FDT coordinates retain the u32-padded encoding, including for P-521.
+    for name, value in (('x', key.pointQ.x), ('y', key.pointQ.y)):
+        output = utils.run_and_log(ubman, ['fdtget', '-tbi', key_dest,
+                                          '/signature/dev', f'ecdsa,{name}-point'])
+        coordinate = bytes(int(byte) for byte in output.split())
+        assert len(coordinate) == ((key.pointQ.size_in_bits() + 31) // 32) * 4
+        assert int.from_bytes(coordinate, 'big') == int(value)
+
+    fit_check_sign = ubman.config.build_dir + '/tools/fit_check_sign'
+    utils.run_and_log(ubman, [fit_check_sign, '-f', fit_file, '-k', key_dest])
diff --git a/tools/image-sig-host.c b/tools/image-sig-host.c
index 7145637a8b8..f6797147342 100644
--- a/tools/image-sig-host.c
+++ b/tools/image-sig-host.c
@@ -61,6 +61,13 @@ struct crypto_algo crypto_algos[] = {
 		.add_verify_data = rsa_add_verify_data,
 		.verify = rsa_verify,
 	},
+	{
+		.name = "ecdsa224",
+		.key_len = ECDSA224_BYTES,
+		.sign = ecdsa_sign,
+		.add_verify_data = ecdsa_add_verify_data,
+		.verify = ecdsa_verify,
+	},
 	{
 		.name = "ecdsa256",
 		.key_len = ECDSA256_BYTES,

-- 
2.53.0

