Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C744DCC6B2A
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 04:36:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E78F814BA;
	Sat, 17 Oct 2026 04:36:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fZizi-LRLjRp; Sat, 17 Oct 2026 04:36:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D45738154B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792211802;
	b=V6WszSi4YSI19N7N6EGClRDHoggJPBNkQeINff219B2mr2pdp3Dd91YNPX+lViKwaj5l
	 w5T67hwCBQKXAofVn36OGoOzzZpJCEmiCg88mu3U98o5MeLnfu2q1hG9b+A3afQf2RX0f
	 ES0wJBrfuHAjdThag4I2WD/XBa5O15IHe1sFgwmIAtJgUeE+EsZZYl6v343pcJx7EhhT8
	 KE7U6N6dip80mfeB0G8JpILNSdns34ynDqvxlGsFjekixWgQYSx0fLpjvTF2YtAZm3CiZ
	 WM70I0EV6Hqs8P7iCFun4vaMl0FJ2IxUY6sOE+fkGTUcLNL5qSzUyNnEjUPt7WhvDKg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792211802;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UDlCQJmksE08IG1K2uinxdao8XBIuNPOYH+k4hED8rg=;
	b=nSTfFcw4wlKocRKah/dXkC3RtpvuY02NKO6LS0Y4aCGz3GmXHS6nwCkDNHyItd2nuQDE
	 Cj5o5XTCJ5Rjc9mb4pOZ0DbJnwJTbexzXo+OCywktg0AA+zmacNSo7NhCX8BFbnPJZ1Lw
	 8SfSn4J88ZMxHwGdnFv6SwAKHSo7y9v1AWVBGJmPYLKD3U3ZepQKzxbnendKTUaYEl6xv
	 OHVsj+JzVo/AYnTuCsqOjjTediRWkA2mrOjkPHT1PGPwxRFc7MmDkqUJNs6PCI/uST1Ru
	 XUf751YEG3zxZZ6aSuTWGChWGJZKXuiZoJZTQ7Tzccgn80+b+Ylu4djhjuMmpuLS2RQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792211802;
	bh=UDlCQJmksE08IG1K2uinxdao8XBIuNPOYH+k4hED8rg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aSjS9MpHqvRvpS8S9tkBErrOv29XVm8fJ3PGAdhnW6Y6/H/2APP4VXjSi48oU0Vbj
	 ORBtmXtieJC9QzOWU4CPhwHc64tegS/Jy3z9EEOoaoMU8lw50+UDlwysgAk/+JJmAI
	 eB0n1BA2DaE8z/Lu7pJIATE3keb4SmObe3Pvennc6IcaMrK5koAPNZbJaCJ3cUjgLa
	 6rTQyV3ZhfO/TE3nuufiOk7mBdl56Q9V0/vMpuYHrGqnItaagQRM8KZ5Emf2xDnqtb
	 zAcESOWZe8nmHUnLttbGeTa/e2CqsEv9jA+RNxAuJ2YBmc3DRZa/27yRLZ3jo6ihHO
	 DRzf2rg+4BJ+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D45738154B;
	Sat, 17 Oct 2026 04:36:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AF58C7AD
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:36:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 94FAA40AF1
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:36:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qkRJ2uR_mpB3 for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 00:36:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 766044081B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::232"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792197364;
 b=RnL0zeYTmlkZVqL3lITC5vys6TrpKAemWOnQlobW3s1AEiAHff/LXXGNOvFwdJsfCC02
 Udzv9j0vQq2FSea+QUMZPAmPGN9HrbhCaS81EqMzRvT1oYD05+95F4fuPEL+HsrzbUnD6
 T0MyMwdzNpx+fgnm8vs7My5z8q8yXMhpoLTE7QwM0AoyUS58pfzIuAJuoDpQfjBfnaHtd
 cKtbJKSkwU4T4PRB5ZKywuM3Mh2Gx1NiS0723pwozW07DlIzNjxc3K8cYSAN590Inu6FM
 vzRsWhAB/g50+pPXdICoPXg9D88hMu5q3ehZ6/knjF94moFHiRyJl3VvcB2dijx8TVQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792197364;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=UDlCQJmksE08IG1K2uinxdao8XBIuNPOYH+k4hED8rg=;
 b=njZwYtjwq2xM11NtSzKw1iEHNFT1wvd5BHVRLYXL8Yijwb9T+ZNAVhbiL7U/pzEtMgdi
 PePCW55Lx5VWtsMxUk4aTAZYjNgVUFu8ylFs/+xX2mkesxq3vz6KKv/3REQz67+sOephs
 AESRlRW5d8jBbrZcyMak2HfGBGHfgD/bne0Theji740b/tAktNbqVo2nMKNF6c5e13wxE
 KZunbSVCQWnaI1bj0m89rlYGAGC7EvzXJtay4Z2EbsBycr6fYxKfltePaoJjT+yzu4pTo
 b40dWvCY94KhmgLdS1ex/4rzpxsBjQ4M9rQJMOrbcHbbcmwHeLoZcyqwKLdAK7CiF3Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=rbv2hXrI; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::232"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::232; helo=mail-oi1-x232.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=rbv2hXrI
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 766044081B
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:36:03 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-4f488ba6e90so264172b6e.3
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 17:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792197362; x=1792802162;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UDlCQJmksE08IG1K2uinxdao8XBIuNPOYH+k4hED8rg=;
 b=rbv2hXrIgSsggDJ+u5WmQqUAfmE+C+KcuNTCt9NI/Uy7For16EyYDrejezPhGUIEYR
 2PNm3ECVWbbz/hfthUIP86RA2geRYt4AK183CdYxjKtb9WjRxpkN7PdnkaTZKBIAE4i9
 mzaQOKqWkZa4u9EQen/X528IQK85iwL2440SGnBwI+j6ll4XbZzpGCD0f0YHqhEeWzcS
 SDqi1DmY1kluMzeCgHg0/z/uVTt70YPAPCZb2bBUv+Fr4uP5gqHqey/+7ZxL9x/+dTtN
 3ypzhcvstE9Xh1HJesx5M8rzV4gsr0jGc/ia2PQMUas1tmIUUjTHV9Y9Oop/rRVCo32m
 IK2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792197362; x=1792802162;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UDlCQJmksE08IG1K2uinxdao8XBIuNPOYH+k4hED8rg=;
 b=gOrZw94C1BrqdAfUuyZa0BteEm1/buIMXrCs2Dhawogw22MotYPER0058kZk8/c8+Z
 GU1Gg6ho3bTSwjTETr4Tu2QNuHhhYfjPw+0g+F1qHR/vUK6mj2UqmcJjho9/SZdxPJoK
 FrdSI/276QR5atBhOK0nMi5vBwMz5zuJ6DHEx/vpRSoE0LfHhMxlrjpvaW2/ccjruwuD
 0uh6x200IYvLEXrP5imCHa6wwhikZXrvGDWWwTsdx5nucLXD7TubFRTyLSMjBLl/va8X
 Mm6CkJVmhobzNi5G12FJXNH7Tq1Q6mh/BqLZnGFAvLL0kGUYC2Rn79WqKrO/UQRLAwks
 yWwg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+/J1KxttRPd7lHAUzSq9cGAVGjs7TxC0celnFxFmJPznQPtonlUKWWXmMxKnqf+NDEWACmqY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLmvWfAaYxc64sAVzgyNHfo3wvZ5mNyZP5LcuYRlpz4Ae65MLEA
 H85mwufgBg0i3+gOyJZqmTsHSm3bhSD/wHSZ0kSKzHvWf5SAM+S6d7Rc
X-Gm-Gg: AYBFou3ptxzhKwJq9WMZWQS7eztSBgU0d5YtoNRIcqWyatU+wNGqITZKcjC0mU2oxDA
 js9ftoMpRzSNXV0pBTXV43rfycRBwu4fdRopq09gMV4Z9OrsrQ5hxqJEL1etkOwV9NTWQTlJ4hL
 VyhVLrQ5h6vPj4E/EcMPsiUbiGCeePxSOe5yiQ6wF+tnGuS8XUJ+SN5lp3r8+2LjS9uiqhA2IFY
 Y861CMNa86a4P5rInrDRccEE5ouVxtmYNPV4jXv8HK+NO+pCSJblZesnvIw9PaI0qU51i5h2aJu
 6Id7LM7oU8ZsFeA5I5fuF9IWqMbjuYnxu+yKfoyO7n0aFXeEiE1XfQUyDxuGdtq8YxW7QLVygSG
 zVTu0eqeIqfmIrUxsbQ2yklMmHoqg0fNfYRWiacDODhBDIedU5wcFS5SWhuG8Hg6QR6YQ2kWNV8
 Fmf5dpMtXS+f40uMkNEdAHyCTHgC21xClZcgSB53P2Qg4teGi8wjUvO/MMUta8ZEB4Js54uBwhh
 ust8R3HtmOmNtCZ8MYfy4g3Jtu2balauFE8OwLnyepGr0Zg8doHrINqigqNbGbraXE6RJPCJ6o7
 a77U9a/AXmkm+Gekfi8OBslQJB2gL95me6jySmyPkwQwFgBlU5A5ZVxvCpowToO2c1QT+Ko3Nkp
 lUcuYJspQeDZ/sCFwctqlyw==
X-Received: by 2002:a05:6808:3196:b0:53c:2775:1965 with SMTP id
 5614622812f47-53cd2099cccmr1173759b6e.59.1792197362070; 
 Fri, 16 Oct 2026 17:36:02 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a73b5b4291sm2745091fac.5.2026.10.16.17.35.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 17:36:01 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 16 Oct 2026 18:35:23 -0600
Subject: [PATCH v9 09/17] crypto: tegra: preserve AES key sizes and engine
 failures
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-submit-ce-series-v2-v9-9-c24e64daafe9@gmail.com>
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

The Tegra AES provider stores its selected key size in an eight-bit field,
although the interface and hardware register use a bit count. Selecting
AES-256 therefore programs a zero key length. Keep the full bit count and
initialize the default in the same units.

An idle-wait timeout currently logs an error but returns success unless a
hardware error bit is also set. Command submission ignores intermediate
wait failures, and the probe-time SBK test discards both selection and
engine errors. Callers can therefore continue programming the engine or
consume IRAM as a completed result after an unsuccessful operation.

Return -ETIMEDOUT for a busy engine and -EIO for hardware error status.
Preserve these failures through configuration, key loading and selection,
command submission and block processing. Stop before submitting another
command or copying an unfinished result. Wait for idle before writing the
SBK test input, and fail probe if that test cannot complete instead of
publishing an unusable provider.

Resource acquisition can also publish an unusable provider: a failed main
clock lookup returns the previous successful reset lookup's zero status.
VDE lookup failures are only logged, so hardware initialization can
dereference an error clock pointer or an uninitialized reset handle.
Return the actual lookup errors before initializing the engine. Select
the VDE dependency from the compatible: BSEV requires both VDE resources,
while BSEA has neither and must not try to acquire them.

Use an unsigned value for the counter-control mask so shifting it into the
upper register bits is defined.

Fixes: b01f0a7c1d9d ("crypto: tegra: Add Tegra AES engine driver")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v8 -> v9:
  - New patch, keeping the Tegra fixes ahead of software-key dispatch
  - Propagate clock/reset lookup failures and require VDE resources only
    for BSEV, leaving BSEA independent of VDE
---
 drivers/crypto/tegra/tegra_aes.c | 107 ++++++++++++++++++++++++++-------------
 1 file changed, 71 insertions(+), 36 deletions(-)

diff --git a/drivers/crypto/tegra/tegra_aes.c b/drivers/crypto/tegra/tegra_aes.c
index 55a4cec525b..716158510c6 100644
--- a/drivers/crypto/tegra/tegra_aes.c
+++ b/drivers/crypto/tegra/tegra_aes.c
@@ -64,7 +64,7 @@ static_assert(sizeof(void *) == sizeof(u32));
 #define TEGRA_AES_SECURE_KEY_INDEX_SHIFT	20
 #define TEGRA_AES_SECURE_KEY_INDEX_FIELD	(0x1f << TEGRA_AES_SECURE_KEY_INDEX_SHIFT)
 #define TEGRA_AES_SECURE_CTR_CNT_SHIFT		16
-#define TEGRA_AES_SECURE_CTR_CNT_FIELD		(0xffff << TEGRA_AES_SECURE_CTR_CNT_SHIFT)
+#define TEGRA_AES_SECURE_CTR_CNT_FIELD		(0xffffU << TEGRA_AES_SECURE_CTR_CNT_SHIFT)
 #define TEGRA_AES_BSE_MODE_FIELD		0x1f
 #define TEGRA_AES_BSE_LITTLE_ENDIAN_FIELD	BIT(10)
 #define TEGRA_AES_CMDQ_OPCODE_SHIFT		26
@@ -92,6 +92,8 @@ static_assert(sizeof(void *) == sizeof(u32));
 #define TEGRA_AES_MODE_UPDATE_IV		BIT(2)
 #define TEGRA_AES_MODE_HASH			BIT(3)
 
+#define TEGRA_AES_BSEV				BIT(0)
+
 struct tegra_aes_priv {
 	void *regs;
 	void *iram_addr;
@@ -102,7 +104,7 @@ struct tegra_aes_priv {
 	struct clk *clk;
 	struct clk *clk_parent;
 
-	u8 current_key_size;
+	u32 current_key_size;
 	bool sbk_available;
 };
 
@@ -137,13 +139,13 @@ static int tegra_aes_wait_for_idle_dma(struct tegra_aes_priv *priv, bool dma_wai
 	while (tegra_aes_is_busy(priv, dma_wait)) {
 		if (get_timer(start) > TEGRA_AES_BUSY_TIMEOUT_MS) {
 			log_err("%s: TIMEOUT!!!\n", __func__);
-			break;
+			return -ETIMEDOUT;
 		}
 		mdelay(5);
 	}
 
 	if (tegra_aes_check_error(priv))
-		return -1;
+		return -EIO;
 
 	return 0;
 }
@@ -156,9 +158,11 @@ static int tegra_aes_wait_for_idle(struct tegra_aes_priv *priv)
 static int tegra_aes_configure(struct tegra_aes_priv *priv)
 {
 	u32 value;
+	int ret;
 
-	if (tegra_aes_wait_for_idle(priv))
-		return -1;
+	ret = tegra_aes_wait_for_idle(priv);
+	if (ret)
+		return ret;
 
 	/* IRAM config */
 	writel(0, priv->regs + TEGRA_AES_IRAM_ACCESS_CFG);
@@ -191,8 +195,12 @@ static int tegra_aes_configure(struct tegra_aes_priv *priv)
 
 static int tegra_aes_select_key_slot(struct tegra_aes_priv *priv, u32 key_size, u8 slot)
 {
-	if (tegra_aes_wait_for_idle(priv))
-		return -1;
+	u32 value;
+	int ret;
+
+	ret = tegra_aes_wait_for_idle(priv);
+	if (ret)
+		return ret;
 
 	if (key_size < (AES128_KEY_LENGTH * 8) ||
 	    key_size > (TEGRA_AES_HW_MAX_KEY_LENGTH * 8))
@@ -201,7 +209,7 @@ static int tegra_aes_select_key_slot(struct tegra_aes_priv *priv, u32 key_size,
 	priv->current_key_size = key_size;
 
 	/* Select the key slot */
-	u32 value = readl(priv->regs + TEGRA_AES_SECURE_CONFIG);
+	value = readl(priv->regs + TEGRA_AES_SECURE_CONFIG);
 
 	value &= ~TEGRA_AES_SECURE_KEY_INDEX_FIELD;
 	value |= (slot << TEGRA_AES_SECURE_KEY_INDEX_SHIFT);
@@ -216,6 +224,7 @@ static int tegra_aes_call_engine(struct tegra_aes_priv *priv, u8 *src, u8 *dst,
 	u32 value;
 	const u32 ICMDQ_LENGTH = 4;
 	u32 cmdq[ICMDQ_LENGTH];
+	int ret;
 
 	log_debug("%s: 0x%p -> 0x%p blocks %d mode 0x%x\n", __func__,
 		  src, dst, nblocks, mode);
@@ -225,8 +234,9 @@ static int tegra_aes_call_engine(struct tegra_aes_priv *priv, u8 *src, u8 *dst,
 		return -1;
 	}
 
-	if (tegra_aes_configure(priv))
-		return -1;
+	ret = tegra_aes_configure(priv);
+	if (ret)
+		return ret;
 
 	/* Configure Secure Input */
 	value = 1 << TEGRA_AES_SECURE_INPUT_ALG_SEL_SHIFT |
@@ -265,12 +275,15 @@ static int tegra_aes_call_engine(struct tegra_aes_priv *priv, u8 *src, u8 *dst,
 	cmdq[3] = TEGRA_AES_CMD_DMACOMPLETE << TEGRA_AES_CMDQ_OPCODE_SHIFT;
 
 	for (int i = 0; i < ICMDQ_LENGTH; i++) {
-		tegra_aes_wait_for_idle_dma(priv, (ICMDQ_LENGTH - 1) == i);
+		ret = tegra_aes_wait_for_idle_dma(priv, (ICMDQ_LENGTH - 1) == i);
+		if (ret)
+			return ret;
 		writel(cmdq[i], priv->regs + TEGRA_AES_ICMDQUE_WR);
 	}
 
-	if (tegra_aes_wait_for_idle(priv))
-		return -1;
+	ret = tegra_aes_wait_for_idle(priv);
+	if (ret)
+		return ret;
 
 	/* Put the result from IRAM to destination if not hashing */
 	if (dst != priv->iram_addr && !(mode & TEGRA_AES_MODE_HASH))
@@ -283,6 +296,7 @@ static int tegra_aes_process_blocks(struct udevice *dev, u8 *iv, u8 *src,
 				    u8 *dst, u32 num_aes_blocks, u32 mode)
 {
 	struct tegra_aes_priv *priv = dev_get_priv(dev);
+	int ret;
 
 	log_debug("%s: 0x%p -> 0x%p blocks %d mode 0x%x\n",
 		  __func__, src, dst, num_aes_blocks, mode);
@@ -294,8 +308,10 @@ static int tegra_aes_process_blocks(struct udevice *dev, u8 *iv, u8 *src,
 
 	/* Load initial IV if CBC mode */
 	if (mode & TEGRA_AES_MODE_CBC) {
-		if (tegra_aes_call_engine(priv, iv, priv->iram_addr, 1, TEGRA_AES_MODE_CBC))
-			return -1;
+		ret = tegra_aes_call_engine(priv, iv, priv->iram_addr, 1,
+					    TEGRA_AES_MODE_CBC);
+		if (ret)
+			return ret;
 
 		/* Add update IV flag */
 		mode |= TEGRA_AES_MODE_UPDATE_IV;
@@ -305,8 +321,9 @@ static int tegra_aes_process_blocks(struct udevice *dev, u8 *iv, u8 *src,
 	while (num_aes_blocks > 0) {
 		u32 blocks = min(num_aes_blocks, (u32)TEGRA_AES_DMA_BUFFER_SIZE);
 
-		if (tegra_aes_call_engine(priv, src, dst, blocks, mode))
-			return -1;
+		ret = tegra_aes_call_engine(priv, src, dst, blocks, mode);
+		if (ret)
+			return ret;
 
 		num_aes_blocks -= blocks;
 		src += blocks * AES_BLOCK_LENGTH;
@@ -343,11 +360,13 @@ static int tegra_aes_ops_set_key_for_key_slot(struct udevice *dev, u32 key_size,
 	const u8 CMDQ_KEYTABLEID_SHIFT = 17;
 	const u8 CMDQ_TABLESEL_SHIFT = 24;
 	u32 value, addr;
+	int ret;
 
 	log_debug("%s: slot %d\n", __func__, slot);
 
-	if (tegra_aes_configure(priv))
-		return -1;
+	ret = tegra_aes_configure(priv);
+	if (ret)
+		return ret;
 
 	if (key_size < (AES128_KEY_LENGTH * 8) ||
 	    key_size > (TEGRA_AES_HW_MAX_KEY_LENGTH * 8))
@@ -400,7 +419,7 @@ static int tegra_aes_ops_aes_cbc_decrypt(struct udevice *dev, u8 *iv, u8 *src,
 					TEGRA_AES_MODE_CBC);
 }
 
-static void tegra_aes_test_loaded_sbk(struct udevice *dev)
+static int tegra_aes_test_loaded_sbk(struct udevice *dev)
 {
 	struct tegra_aes_priv *priv = dev_get_priv(dev);
 	enum fuse_operating_mode opmode = tegra_fuse_get_operation_mode();
@@ -408,15 +427,23 @@ static void tegra_aes_test_loaded_sbk(struct udevice *dev)
 		0x66, 0xe9, 0x4b, 0xd4, 0xef, 0x8a, 0x2c, 0x3b,
 		0x88, 0x4c, 0xfa, 0x59, 0xca, 0x34, 0x2b, 0x2e
 	};
+	int ret;
 
 	/* Encrypt a zero block, we use ECB so that we only care about SBK and not the IV */
+	ret = tegra_aes_select_key_slot(priv, 128, TEGRA_AES_SLOT_SBK);
+	if (ret)
+		return ret;
+
 	memset(priv->iram_addr, 0, AES_BLOCK_LENGTH);
-	tegra_aes_select_key_slot(priv, 128, TEGRA_AES_SLOT_SBK);
-	tegra_aes_call_engine(priv, priv->iram_addr, priv->iram_addr, 1, TEGRA_AES_MODE_ENCRYPT);
+	ret = tegra_aes_call_engine(priv, priv->iram_addr, priv->iram_addr, 1,
+				    TEGRA_AES_MODE_ENCRYPT);
+	if (ret)
+		return ret;
 
 	/* Evaluate the result of engine operation */
 	if (!memcmp(priv->iram_addr, AES_ZERO_BLOCK, AES_BLOCK_LENGTH)) {
 		log_err("%s: engine is not operational! (opmode 0x%x)\n", __func__, opmode);
+		return -EIO;
 	} else if (!memcmp(priv->iram_addr, ZERO_KEY_CIPHERTEXT, AES_BLOCK_LENGTH)) {
 		if (opmode == MODE_ODM_PRODUCTION_SECURE) {
 			log_warning("%s: SBK is zero or is cleared from engine! (opmode 0x%x)\n",
@@ -435,6 +462,8 @@ static void tegra_aes_test_loaded_sbk(struct udevice *dev)
 				    __func__, opmode);
 		}
 	}
+
+	return 0;
 }
 
 static int tegra_aes_hw_init(struct udevice *dev)
@@ -498,9 +527,7 @@ static int tegra_aes_hw_init(struct udevice *dev)
 
 	/* Check if SBK is loaded in SBK slot or was erased */
 	priv->sbk_available = false;
-	tegra_aes_test_loaded_sbk(dev);
-
-	return 0;
+	return tegra_aes_test_loaded_sbk(dev);
 }
 
 static int tegra_aes_probe(struct udevice *dev)
@@ -510,7 +537,7 @@ static int tegra_aes_probe(struct udevice *dev)
 	u32 value;
 	int ret;
 
-	priv->current_key_size = AES128_KEY_LENGTH;
+	priv->current_key_size = AES128_KEY_LENGTH * 8;
 
 	priv->regs = dev_read_addr_ptr(dev);
 	if (!priv->regs) {
@@ -547,18 +574,26 @@ static int tegra_aes_probe(struct udevice *dev)
 
 	priv->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(priv->clk)) {
+		ret = PTR_ERR(priv->clk);
 		log_err("%s: failed to get BSE clock: %d\n", __func__, ret);
 		return ret;
 	}
 
-	/* VDE clock and reset required by BSEV */
-	ret = reset_get_by_name(dev, "vde", &priv->reset_ctl_vde);
-	if (ret)
-		log_debug("%s: failed to get VDE reset: %d\n", __func__, ret);
+	/* Only BSEV requires the VDE clock and reset. */
+	if (dev_get_driver_data(dev) & TEGRA_AES_BSEV) {
+		ret = reset_get_by_name(dev, "vde", &priv->reset_ctl_vde);
+		if (ret) {
+			log_debug("%s: failed to get VDE reset: %d\n", __func__, ret);
+			return ret;
+		}
 
-	priv->clk_parent = devm_clk_get(dev, "vde");
-	if (IS_ERR(priv->clk_parent))
-		log_debug("%s: failed to get BSE clock: %d\n", __func__, ret);
+		priv->clk_parent = devm_clk_get(dev, "vde");
+		if (IS_ERR(priv->clk_parent)) {
+			ret = PTR_ERR(priv->clk_parent);
+			log_err("%s: failed to get VDE clock: %d\n", __func__, ret);
+			return ret;
+		}
+	}
 
 	return tegra_aes_hw_init(dev);
 }
@@ -575,9 +610,9 @@ static const struct aes_ops tegra_aes_ops = {
 
 static const struct udevice_id tegra_aes_ids[] = {
 	{ .compatible = "nvidia,tegra20-bsea" },
-	{ .compatible = "nvidia,tegra20-bsev" },
+	{ .compatible = "nvidia,tegra20-bsev", .data = TEGRA_AES_BSEV },
 	{ .compatible = "nvidia,tegra30-bsea" },
-	{ .compatible = "nvidia,tegra30-bsev" },
+	{ .compatible = "nvidia,tegra30-bsev", .data = TEGRA_AES_BSEV },
 	{ }
 };
 

-- 
2.53.0

