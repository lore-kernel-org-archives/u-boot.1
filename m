Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A48CCA463
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 04:36:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4FFFE81499;
	Sat, 17 Oct 2026 04:36:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3yVp1SxvA93m; Sat, 17 Oct 2026 04:36:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F3AA0814AB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792211808;
	b=MFvw28KeoWCmKdaSyLILqKcs4Am0hs2k8X+I2MF8IJMFOgu27h5i0ohkGcba2hb/W5Hs
	 RIWfSFTEE5fipHXCWY78zjX5oMvHInbc898+O9lfmWDFXYvFPC6qFaXzHfMt6640v8/Xd
	 VVhIYbF3vNvOtRvnjDew9gltpJD5iGf5H9n2qVA0tsel81ENnsArf+ZBU2izGOkCeEK9T
	 b3PJ8X+Uv3ZGscmUtdHcjDaqTv7+x9Ecg/6N+AM1vpQe3jI4A63SC2ji5bzSY3dTQ1VWp
	 LyBgahw6H1Z9Og4cruI+UBRtaUfUdOatJtP6umMKS7IQUXJSKQI9DDoVn1RaKC2vdEw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792211808;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8liULU8LF611aQGQ+QXwElJws6/A3JJPVTxYKNASDHM=;
	b=a75COUtBH5YAwoK88j9ENfQyOc0nwUn9u/CkwF7sZiiDBTp5mDQSF8fVayHk+YvlaEU9
	 +nyxiJmFy8btkKLLR2cl+1DWTBPCPX83SxLfNPC1ZcYYv61a73iXr4bF9VzqX7VgzmvVx
	 4jgY2MiTJ71lWypXCk2S7iaDcxZGkT7n/Af4pIw14eMi91UbnkM+V8jpmjqK/qmU95cRm
	 1mzl4SiekAx86lblg6XmpMjKZW4OzGrt3fn84dxZu5zQbUpk63nAMySv9wNXSL/cehG19
	 0P6V5mrko0hPZgpQNfBUtf1h1M8yfjIUJNJAtK/CbmMLQhhzTsL6FUyeZgjTbYr7FUg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792211808;
	bh=8liULU8LF611aQGQ+QXwElJws6/A3JJPVTxYKNASDHM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=njZCIMePTHs1bqopFtn1QOC4ajtUG04SyShWkqgZxIDfEuK8xtnAPwJbLToT3BquM
	 xRpSHoByDTYLH9UhA+sg7eeaeqVsKt5HPaYZkgaaCEwEtE1dx7nOxCXflymdB3BW/A
	 hjaqmm54KbJhls4H3AhtLx+dTAOytlQG5ZKP7XqLEKFoXoFHy9C0mmfQdTDy3+P5Cy
	 zBJIVfp+Pon4tDFXLQJNVmpfJt2PFOYXdnXb7h2XvxQhsxsh/dZZyIju9pta+xVuOz
	 YacUOgfxTPCS08chIqJquajLqFxBlpP62fjGMiVviIOHfJahOBcrGQYMARfIl2rF5H
	 etQqpUf0HIHQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F3AA0814AB;
	Sat, 17 Oct 2026 04:36:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DBF5179D
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:36:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C1DDB4081B
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:36:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FaryhdF8_Q_n for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 00:36:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C3F5E405E3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::36"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792197376;
 b=AzmwB4p1PkowUoStwmO62qBLWDxqwybBF++7b5jp1ouh3mnhrPq+A1m39yb/DIarar/d
 6ck63aF3T2K9a/NtInY+BZCjzYllZ8mw5aiIp95/b+gq/btEDcONjtu+UOyDcpmIW2RSb
 Ij1rq6ANUtN6Xg3dAgoiZqTegiMMTjCyb4THw5O4m54GQFwQf/UNwL/xVrZGcs0T2OC7i
 ERY3it9Lb3VuqL3l3ty9oTTbxXmr7asFMetVZhzKl6BNRIPUpvte5lPq4Mit8mOhyZcd3
 aTBucR6rPTWElIfypT7F2yVMPYljiS2VDL3paD4chKYkbHioA7uMmn8Mj0vAu6rvwYA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792197376;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=8liULU8LF611aQGQ+QXwElJws6/A3JJPVTxYKNASDHM=;
 b=m+g1yWsBcYI/A2yoQuZrjW6BcOZjyAGOInfd7CPEDfeWHgLZXCQvq7l4QZBcnTfkiyC9
 VN1ZENtlfbLsARgI17mJQ8KtHCHA6wvkpT4RC6Jye6JdsTlEgMsQKIyAD/T5ycmX6YRWA
 fKEpVX2vvuPy+1qo8PK9OekRNSMzD1L4tpdvpbsEVNL5r4wADvJ3ybf4A9I9YuwcTK0ah
 kKiHcYKOLx1i0MuTJWY42s1YsmN7eHAJErdeSjZmr3CB0z/dnKgfEiVKgaMjayovlAFGT
 iIKtFwCCSbTD6PAZqPYBsM71is/7wzBAiQUOq3q/X+0snu5lHMlwzB6RA5yObtBGM/w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=gefvVytz; 
 arc=none smtp.remote-ip="2001:4860:4864:20::36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::36; helo=mail-oa1-x36.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=gefvVytz
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C3F5E405E3
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:36:14 +0000 (UTC)
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-4a75171af39so168313fac.2
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 17:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792197374; x=1792802174;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8liULU8LF611aQGQ+QXwElJws6/A3JJPVTxYKNASDHM=;
 b=gefvVytz9GWMzpXGwbdnde6sK44qouh1FbuImwP0ghDqdoYN7B5umhumnO1dS2c0i6
 25OWWV2L1Hj8JKmb382XI+Bbwads6KZYBPRgnZPS9KP1uMDxxzTwO/LYS6vB7BJxlPIN
 ox0oiEiY2mEoGty+pUDti0PZ4GJ3iRvtQg1qcOIn7UXjntevs9rVoJUV/vVFK06+am7G
 2y7d5/VP8sV4olyxSiK/wW9Y2b3PYwmA2NFrVUVYmm9SGhUWEoFHNjH4hG6ilH7pFEpc
 RmBJ6QA6Prs4k31Dgjbpau582gIFsjObljEBX1AJAhfYkz2tFhES4oke3L24HNMrse36
 bfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792197374; x=1792802174;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8liULU8LF611aQGQ+QXwElJws6/A3JJPVTxYKNASDHM=;
 b=YIPzMc5pyMufE1FrHuuZlP38AAy4zmvCrzi0uS9QdyRb7ZMB+YPGHS6rB7rVNgfqp2
 EA8d9HNXHU8K4C+r1uShxV+znLlSih81NrQJYUnvizlIFUsiYqZ0q/yHBWIZdFn63Jf2
 lHsy9It7wWa05sYaRXXMLAYiCZK+7se1PvLv7WBlRoo5KhIpJude+R1hdc9JBLgDcny9
 gx9GM+vpzHi1fq6HGxgn/5qijE0XonZ6JTuQcS1tJMzDmEiU/b3l7IVFxaN6iP5KtwI/
 5SdB+rjq+0sgAR1sOjpfBmzrWgRzHp3g4GQVdoq2gAMZCIQD5KphxFxAXy+noW+F0m5j
 uC0A==
X-Forwarded-Encrypted: i=1;
 AKwUvBx/njFOCtQAz+Am7oIeM8IZrROjmDPypLKo5aIdnCBSEY/UjJRKSEZIW4blG6uyWR0WZRdcryY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK4N2IHlgpZI5MmuNpoUFU8xgguDzBTlTbgwXF4ZKJA4jsXHy7A
 Uu9bljnNppndi1eiZALqHihhQhb4uq0rr0NaQL7VGPRvjAjtzJoF+ckD
X-Gm-Gg: AYBFou0JlHbuLZC482R0cxSPZYs1DwA7vu8RUXcIuwhfgDD/KoP/n6TYab+zyMEBjGa
 C2g8T4KzyPDPBEdKuoyAFwIdP/j1MIRMKnBuwpqZIbA2Vg7eGMymhF65o1fnVPjndV2D4jojrPo
 oLX3FbmAQzpntBH0zcnQFOH/bUL0xmX4XmwX6w4NmwuAIuHWHpTVIC4gnkI4f1/ILt5alH08EfH
 kYNLUi4w6kLRAx4Tbem6kyvsom5E3wec3svI4m73bITywZUPhmew+nf6JrPw8OwFaKmYti9d0KS
 +IPaTASPFDV2RWUYK2/vnEVDg9JQGgJNFqeXw4X0frR13FU6Zkc314FwUo3tn7FKbGQTAmVTSKu
 K3M9vFHBeAY9pbAI2UC0ddUY7x+gEtFJun8et1s+akS4SqDmrxcrg8AVmAKCAebfzmTMvT9PDVJ
 1hQGAmzZyzylz29IE3FAe717MkCA4UGORvB3R69ZO4OglolH7DynOReumknFXy9a3MxrC4FkITB
 6LJiAnipJTk+F4Ol8UNKosgEho7XSx6rtYssV4u4JrymR8ulEmNPxDg+OAvCK2d6mSENoJfbKAK
 7Xdfj5lRMMFyeU5ZB+pp2mO/GLpWICfCwndu06XMcgjYyRA7/huxMAeRIXPPUZT5L7b8ZH0IwAB
 2E/uy+LfEfZZwIX9E2Rg/ig==
X-Received: by 2002:a05:6871:3688:b0:49c:8cd1:d293 with SMTP id
 586e51a60fabf-4a7575ad958mr1287184fac.1.1792197373656; 
 Fri, 16 Oct 2026 17:36:13 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a73b5b4291sm2745091fac.5.2026.10.16.17.36.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 17:36:13 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 16 Oct 2026 18:35:26 -0600
Subject: [PATCH v9 12/17] spl: fit: support encrypted payloads
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-submit-ce-series-v2-v9-12-c24e64daafe9@gmail.com>
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

Add SPL_FIT_CIPHER and decrypt FIT image data before post-processing,
decompression or moving it to the final load address.

SPL cannot always allocate a new output buffer while loading FIT images,
so use the caller-provided decrypt-to-buffer helper. External encrypted
images are read into scratch memory first, then decrypted in place before
the existing copy or decompression path consumes them. Embedded encrypted
images decrypt into the final load buffer, or into scratch memory when
decompression is still required.

Defer mapping the final destination until the board post-processing hook
has finalized the source and length. The direct embedded-decrypt path maps
early because the hardware needs its destination, but tracks and extends
that mapping if post-processing grows the payload. Map decompression output
for CONFIG_SYS_BOOTM_LEN rather than the compressed input length.

Use IMAGE_ENABLE_DECRYPT in the common FIT image-load path so FIT cipher
support is selected by phase. Keep that path disabled for host tools,
since the target-side decrypt helper depends on the U-Boot control FDT
and runtime crypto providers.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v8 -> v9:
  - Adapt encrypted FIT loading to the current SPL loader while retaining
    upstream external-data bounds and overflow checks

Changes v3 -> v4:
  - Map the final destination after board post-processing determines size
  - Size decompression mappings for the maximum output
  - Require SPL_OF_CONTROL and clarify the SPL_FIT_CIPHER help text

Changes v2 -> v3:
  - Use a shared helper for SPL decompression buffer decisions
    (suggested by Simon Glass)
  - Reject encrypted SPL FIT payloads when SPL_FIT_CIPHER is disabled
    (suggested by Simon Glass)
  - Flatten decrypt buffer selection  (suggested by Simon Glass)
  - Comment the no-copy path after direct decrypt
    (suggested by Simon Glass)

Changes v1 -> v2:
  - Drop redundant SPL_FIT select  (suggested by Simon Glass)
  - Explain the IMAGE_ENABLE_DECRYPT change  (suggested by Simon Glass)
  - Explain the host tools decrypt behavior  (suggested by Simon Glass)
  - Decrypt external encrypted payloads in place
    (suggested by Simon Glass)
  - Skip self-memmove after direct decrypt  (suggested by Simon Glass)
---
 boot/Kconfig         |  9 ++++++
 boot/image-fit.c     |  2 +-
 common/spl/spl_fit.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 90 insertions(+), 8 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 8fcdc36c931..9ad9b2f43ea 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -155,6 +155,15 @@ config FIT_CIPHER
 	  Enable the feature of data ciphering/unciphering in the tool mkimage
 	  and in the u-boot support of the FIT image.
 
+config SPL_FIT_CIPHER
+	bool "Enable decrypting data in SPL FIT images"
+	depends on SPL_LOAD_FIT
+	depends on SPL_DM_AES
+	depends on SPL_OF_CONTROL
+	help
+	  Enable decrypting FIT image data in SPL. This allows SPL to
+	  decrypt an encrypted U-Boot proper FIT image through an AES driver.
+
 config FIT_VERITY
 	bool "dm-verity boot parameter generation from FIT metadata"
 	depends on FIT && OF_LIBFDT
diff --git a/boot/image-fit.c b/boot/image-fit.c
index 6e89707788f..163daac0993 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2471,7 +2471,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	}
 
 	/* Decrypt data before uncompress/move */
-	if (IS_ENABLED(CONFIG_FIT_CIPHER) && IMAGE_ENABLE_DECRYPT) {
+	if (!tools_build() && IMAGE_ENABLE_DECRYPT) {
 		puts("   Decrypting Data ... ");
 		if (fit_image_uncipher(fit, noffset, images->verify,
 				       &buf, &size)) {
diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 64e5f95546f..955ce88dfd5 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -230,6 +230,34 @@ static void fit_fill_image_info(const void *fit, int node,
 		image_info->entry_point = FDT_ERROR;
 }
 
+static int spl_fit_image_decrypt(const void *fit, int node, int cipher_node,
+				 void **data, size_t *size, void *dst)
+{
+	size_t dst_size;
+	int ret;
+
+	puts("   Decrypting Data ... ");
+	ret = fit_image_decrypt_data_to(fit, node, cipher_node, *data, *size,
+					dst, &dst_size);
+	if (ret) {
+		puts("Error\n");
+		return ret;
+	}
+
+	*data = dst;
+	*size = dst_size;
+
+	puts("OK\n");
+
+	return 0;
+}
+
+static bool spl_image_needs_decomp(uint8_t image_comp)
+{
+	return (IS_ENABLED(CONFIG_SPL_GZIP) && image_comp == IH_COMP_GZIP) ||
+	       (IS_ENABLED(CONFIG_SPL_LZMA) && image_comp == IH_COMP_LZMA);
+}
+
 /**
  * load_simple_fit(): load the image described in a certain FIT node
  * @info:	points to information about the device to load data from
@@ -258,12 +286,16 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 	size_t length;
 	ulong size;
 	ulong load_addr;
-	void *load_ptr;
+	void *load_ptr = NULL;
+	size_t load_map_len = 0;
 	void *src;
 	uint8_t image_comp = -1, type = -1;
 	const void *data;
 	const void *fit = ctx->fit;
 	bool external_data = false;
+	bool encrypted;
+	bool needs_decomp = false;
+	int cipher_node = -ENOENT;
 	int ret;
 
 	log_debug("starting\n");
@@ -295,6 +327,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 	if (spl_decompression_enabled()) {
 		fit_image_get_comp(fit, node, &image_comp);
 		debug("%s ", genimg_get_comp_name(image_comp));
+		needs_decomp = spl_image_needs_decomp(image_comp);
 	}
 
 	if (fit_image_get_load(fit, node, &load_addr)) {
@@ -306,6 +339,14 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 		load_addr = image_info->load_addr;
 	}
 
+	cipher_node = fdt_subnode_offset(fit, node, FIT_CIPHER_NODENAME);
+	if (cipher_node >= 0 && !CONFIG_IS_ENABLED(FIT_CIPHER)) {
+		printf("Can't load %s: encrypted image without SPL_FIT_CIPHER\n",
+		       fit_get_name(fit, node, NULL));
+		return -ENOSYS;
+	}
+	encrypted = cipher_node >= 0;
+
 	if (!fit_image_get_data_position(fit, node, &offset)) {
 		external_data = true;
 	} else if (!fit_image_get_data_offset(fit, node, &offset)) {
@@ -364,11 +405,12 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 		}
 		read_offset = fit_offset + aligned_offset;
 
-		if (spl_decompression_enabled() &&
-		    (image_comp == IH_COMP_GZIP || image_comp == IH_COMP_LZMA))
-			src_ptr = map_sysmem(ALIGN(CONFIG_SYS_LOAD_ADDR, ARCH_DMA_MINALIGN), len);
+		if (needs_decomp || encrypted)
+			src_ptr = map_sysmem(ALIGN(CONFIG_SYS_LOAD_ADDR,
+						   ARCH_DMA_MINALIGN), len);
 		else
-			src_ptr = map_sysmem(ALIGN(load_addr, ARCH_DMA_MINALIGN), len);
+			src_ptr = map_sysmem(ALIGN(load_addr, ARCH_DMA_MINALIGN),
+					     len);
 		length = len;
 
 		/*
@@ -426,10 +468,40 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 		puts("OK\n");
 	}
 
+	if (encrypted) {
+		void *decrypt_ptr;
+
+		if (external_data) {
+			decrypt_ptr = src;
+		} else if (needs_decomp) {
+			decrypt_ptr = map_sysmem(ALIGN(CONFIG_SYS_LOAD_ADDR,
+						       ARCH_DMA_MINALIGN),
+						 length);
+		} else {
+			load_map_len = length;
+			load_ptr = map_sysmem(load_addr, load_map_len);
+			decrypt_ptr = load_ptr;
+		}
+
+		ret = spl_fit_image_decrypt(fit, node, cipher_node, &src, &length,
+					    decrypt_ptr);
+		if (ret)
+			return ret;
+	}
+
 	if (CONFIG_IS_ENABLED(FIT_IMAGE_POST_PROCESS))
 		board_fit_image_post_process(fit, node, &src, &length);
 
-	load_ptr = map_sysmem(load_addr, length);
+	size = needs_decomp ? CONFIG_SYS_BOOTM_LEN : length;
+	if (!load_ptr || size > load_map_len) {
+		void *old_load_ptr = load_ptr;
+
+		load_ptr = map_sysmem(load_addr, size);
+		load_map_len = size;
+		if (src == old_load_ptr)
+			src = load_ptr;
+	}
+
 	if (IS_ENABLED(CONFIG_SPL_GZIP) && image_comp == IH_COMP_GZIP) {
 		size = length;
 		if (gunzip(load_ptr, CONFIG_SYS_BOOTM_LEN, src, &size)) {
@@ -447,7 +519,8 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 			return -EIO;
 		}
 		length = loadEnd - CONFIG_SYS_LOAD_ADDR;
-	} else {
+	} else if (src != load_ptr) {
+		/* Direct decrypt of an embedded image can already be in place. */
 		memmove(load_ptr, src, length);
 	}
 

-- 
2.53.0

