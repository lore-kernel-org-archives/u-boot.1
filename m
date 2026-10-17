Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C01CCF2C4
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 04:36:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3DCDB40A09;
	Sat, 17 Oct 2026 04:36:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oJHLKev7wQiK; Sat, 17 Oct 2026 04:36:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A57E0409E7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792211815;
	b=DJg1VCdcMC4xJL8/CLJv+vPIPkMrekNoSmH7ZhMn8gRUy5o4W8lv/pameRXRpXz+xO5z
	 wHszgbivWRF3QpXa+WpqfnsJ+a1hS5pDPi72973nkDJMBVh8EyfR/uaeYG59SA51vvozl
	 8VY3+iWjPA6yedX971o61vUZ3fkixl4SaMYW2q7dv8Yk9WoX/N8iu4vromQmCIOxeKDHd
	 hK041PzflqqujPVwTM3Di2V7DoJy9faQxgvF5fQbKSVaoFWFcBoLOxwI1jmOsZ3RfzFl3
	 pWB5/hwkMgLi54Zwm2t2r7VcZF3ehBd1scuxFRuendvph/MJd3TDH6r+EpWvMwEcu6Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792211815;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=iQZhLjqgx9lO1GLvPgL3IqO+zAlswTkZkPyQiVt8Xrk=;
	b=hYTxNSXdLXk2fa6rUjdBJ2hV/NyvN61+z/wZtZ4N28OqaT88WaSyeftG5VWAWxgUFBQ0
	 c+45kCWxEcSW54cVDDBGpC/nBZoKZevPsJ/yc9vuTh74qFb69mWh0+qjzztr7v/jykJzD
	 gL2Mcav6Yu+oer7yFB660DqirX7Llnh1hmqDwEToIVI2IpVPADPlvN+j9dqylrJafGGZ7
	 h7x3ICbNG04Hkb62zDkIrbe5mTeFGiQxt/mrFxZngrOKG25ExBeszLiSTeWunE05KUErb
	 ADtZ9ntaKcnQoSs93ojo0zTJb4Iy77Zxp2cXdOoFcKxG+RHVmTl6cS1gBsQbiCQm4iw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792211815;
	bh=iQZhLjqgx9lO1GLvPgL3IqO+zAlswTkZkPyQiVt8Xrk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jSDbiUpBok+PoSov9+LU5mKP/ebJxHk1Rc/EA0UVcYtT7246jPH0YWYicwUrGstEs
	 Vxk/YJpbS0EhXbCVbh7di/rXuDJ21N6DAPN/s4GeuoWxtq5h+rd0S06Yw0hMsFNUOL
	 08HIDvD8JUnm95itAyqB6bTzWwj96UVZa4OACdhSrjjN+MtF7X2NvAXUpYTgPyGPgF
	 KR2Ytbuo3xukVkajk0F9cHGcw/piAdY3zPFHUz4IWph57faZkHqVniugw57te82slV
	 dTVG4WGZ5lpV4cRwYjfC9pp2FGd/YwnC/mOi12ezqo0xU96Nh/jN98h6dl0h7tvRig
	 VCI0VSyQnMXiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A57E0409E7;
	Sat, 17 Oct 2026 04:36:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B6E8B362
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:36:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A8A3E8165E
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:36:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sC98XBGddJNZ for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 00:36:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 45E038156F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::29"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792197389;
 b=dljEr2ui2Dk4ZeAE4ReSy3jb48S9Rkc5bwAwRC0D3br0x3ZlaKDU5xHIxPaD2vl/1xHC
 /qFBkLm7FPCrzM4dgNnQVTf37W7yDONFEqXA6OHxZa4zktJLXB0f+ek1B0GNSfNFp1P5D
 IakzrgB7suT2DZn3y+ZSNymRmtG6i8oyKY2vHu1EXxgrM3fK3hPpwgkyXdzuqZlmm0Nae
 MYQIZX2stFQVMJqZuq7Ubibu0kvGFwFhH2Y3R1tObROZT0z/bYAVsn+JNLkPPfqD/ywua
 GA239MES4r2wJs5deuSico5s0BVX2AWev48bPnxS2Mfkj0cKZEexxBZrueqR+rss3UA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792197389;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=iQZhLjqgx9lO1GLvPgL3IqO+zAlswTkZkPyQiVt8Xrk=;
 b=ZvBCOFxGdbAshaOcsDPE0AzbfHbUHL55b6gk3hOY2TRA1HlxVQj3WNmymgBrUQ8vf9hQ
 /pXkU7IZUqLhvoPpXyJN/hVfU0tpBYBwjPkmmKtsKuD8ywgwE1/vLjO/3b2ncd3jGwCrJ
 YYdUe+vur1AnihDMRHaufiO700z6n8sqaogiKvGGEhO1feE5m5YcNhjL4UIc/IIW3YSTD
 TpS59HJ7DfVWK/QwvoANeub6/PS3xBuLwiM7WDkQkINcBXjwefY2d2udz3stWgCRKROBm
 vjG+hFJdOrAOuSZiS8DCHKAM/8g7W7oQsuPai26gS18Mwx2POu5/Pi8MOsT/hGNcbZQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=RedYW3S5; 
 arc=none smtp.remote-ip="2001:4860:4864:20::29"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::29; helo=mail-oa1-x29.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=RedYW3S5
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 45E038156F
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:36:28 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-4949f037131so299510fac.3
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 17:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792197388; x=1792802188;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iQZhLjqgx9lO1GLvPgL3IqO+zAlswTkZkPyQiVt8Xrk=;
 b=RedYW3S5LEj/3LLlTKybEmOJ01wlYEPyewx2asi+ugX7lCoDQKhppQM7jKQ1/0VC28
 XmkDodkCFmB04O3iDpwfIPORs4v4f7lWEalAU+BpKE+tnPl1QE35dNx0AnDkBrB3SO8l
 su5S0t1chzIzyZ1hmQSDXT7YZFo4qUUQstJrU3bCJnit6vh43BCuStitBjSw+wA+TJTf
 OEL5yQg/Mvrmp+0uHrkupt6hd3eCYMcBhhe/Y5tjdS0WFBFTLn3C17dqFXAz9/2umonn
 GAJ+jKb+XeJqhzeKBoiNZelTnP7uljyQ8FvR9B8w5fvZ/hj6iHTM/semZNU9dju9B3LV
 XFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792197388; x=1792802188;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iQZhLjqgx9lO1GLvPgL3IqO+zAlswTkZkPyQiVt8Xrk=;
 b=DGYc4AW8ChVVJu78BcmQhmfEH1r4KFG6zRL6mOxKoTOS4mD9vWcK3HeaSiJBAmh8Wu
 qTShP9pIEuUsWC9W/nlR+Vua2cLFLBwXT0n5w6WH+lSyETVtpJ9tWjQ89/LDaWSeDblE
 avbzV8Gucj6M02akiFltkbY9LDVEtM5/AFQB1fClQ1+N/L9G8rUbbIqk5PRVGwmVYdyc
 GjR8sanjIa+qyZ49KbsEOWoDRoMAXWGWVFEJ5rpHxt6NVYL765mMsf6ywekW91Wbxd0g
 PCySimN+dMjqCLxNkB4MnaEErjuvBsmVoiJ6U2kLYczWOy/ObtkEk4bOXAeSGllZyb8v
 jlsA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwUSWgayh5fgBNtxFZ4rd1FCIQ5tzSIXzWn0Il5a8PT5TmyMhDAjYWAXRuMXQyTCAeEMzdu6ds=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLk+v9/zujwj5ZNqVncCsOXJTwsxtlobeZKgHRwXyR0yMYWK6/w
 Q1FzVYYoT7QZYe915Na9sDdlls7Sd8PM+kAQUdE0VjjPTv2BwIZahK9U
X-Gm-Gg: AYBFou0Rc8NhkOwJhNOHAHLotDgMGhoXLJHnJ0+abhEOxQgQtMReFpRQjGgXAlkXhHd
 qpLuNtQ52/6nb8zMQhXYWngQReL+3/NrD3kB5uwVEVmk0xMRvY7L1z2dt4CoSSBioTryDYWrWJz
 PeH52HvSYmqOEvA23CYLJ+W/T1fwMP4bE0EPwP/cbcGpWedjTcJodCACXvogS/caTryW+I/uYRO
 157aiqBX0EIuH3RtgXChQkOdZK0hxaC2E6m+onULSIJPmXc7M9nET7FzNpxw8hNysSjk7Agqfsd
 aNTlCXLk4qKnAQuaxLJGvF8ZR723sxO5Sdr4cbtYDgJRi6MEi1WzOBaBXrpAHQ7Z2i6oRYOkgog
 RrzjZUkp0n1KAQwO+fawv4kJJQwDQNxl4yvO7CuGlqYFTecrnBLlo4FWoat8Qn+kO575bq26fKB
 mSFH8u3Prgbf8yUOM8Xr3Z2U98i4T2B77HFQEaidCi+2rDaxuN+tegjzlSBYHVoG+4WyOIWnfTG
 7pEpyPMovUcZOOxmDc/QmRjnAi28I9a3xIR2pvPN++ezgNNfWRmF+VHQ2yPhVfYEa4ccasRi/vq
 qJM+zdiTT0R8+i0NjkF8QyjecBSNuCsh6OSsKG217ZB8m9KcL6EBxZITDcOxT3x7xW8EtDDZ/Ne
 bdl4deSedPOUMpFtrESvdzA==
X-Received: by 2002:a05:6870:c0a:b0:498:f70a:b54e with SMTP id
 586e51a60fabf-4a757a44085mr1471912fac.43.1792197387727; 
 Fri, 16 Oct 2026 17:36:27 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a73b5b4291sm2745091fac.5.2026.10.16.17.36.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 17:36:27 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 16 Oct 2026 18:35:30 -0600
Subject: [PATCH v9 16/17] crypto: allwinner: add sun8i-ce ECDSA verifier
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-submit-ce-series-v2-v9-16-c24e64daafe9@gmail.com>
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

The H6 and H616 Crypto Engines include an ECC engine which can verify
ECDSA signatures. Add a UCLASS_ECDSA child for the sun8i-ce parent so FIT
signature verification can use the hardware block from U-Boot proper and
SPL.

The CE takes explicit curve parameters for each operation. Provide tables
for the curves accepted by U-Boot's FIT ECDSA parser: secp224r1,
prime256v1, secp384r1 and secp521r1. Derive each curve's a = p - 3
parameter from p instead of storing duplicate constants. Make each curve
independently selectable for U-Boot proper and SPL. SRAM-constrained
builds can keep only the curves they need. The task input layout follows
the ECC verify buffer order used by Allwinner's CE implementation.

The CE input buffer uses fixed-width curve fields. Reuse the parameter
packing logic for the message digest as well, so wider digests are
truncated to the leftmost curve-width bytes according to ECDSA rules.
Map the private input and result through the parent's cacheline-safe DMA
objects. Round result storage to complete cachelines while keeping the
descriptor output curve-sized. Submit ECC work on the dedicated asymmetric
completion channel. After retirement, unmap the result and input exactly
once before inspecting the result.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v4 -> v5:
  - Let parent submission populate the descriptor transport fields
  - Name fields in the fixed ECC input sequence and inline the trivial DM
    verifier wrapper
  - Reject missing key coordinates, digest or signature before curve lookup
  - Use shared cacheline-safe DMA mappings and round private result storage
    to complete cachelines
  - Unmap the result and input before inspecting the verification result

Changes v3 -> v4:
  - Enable CE ECDSA for both H6 and H616
  - Use the dedicated asymmetric channel and shared task-session path
  - Derive the NIST a = p - 3 parameter instead of storing duplicate arrays

Changes v1 -> v2:
  - Document the CE input-buffer layout  (suggested by Simon Glass)
  - Document ECC byte-sized task length  (suggested by Simon Glass)
  - Make CE ECDSA curves independently selectable
    (suggested by Simon Glass)
  - Use neutral wording in comments and commit log
---
 drivers/crypto/allwinner/sun8i-ce/Kconfig          |  94 +++++
 drivers/crypto/allwinner/sun8i-ce/Makefile         |   1 +
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c  |   6 +
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-ecdsa.c | 382 +++++++++++++++++++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h       |   3 +
 5 files changed, 486 insertions(+)

diff --git a/drivers/crypto/allwinner/sun8i-ce/Kconfig b/drivers/crypto/allwinner/sun8i-ce/Kconfig
index ee011cf8280..01d58ac32fa 100644
--- a/drivers/crypto/allwinner/sun8i-ce/Kconfig
+++ b/drivers/crypto/allwinner/sun8i-ce/Kconfig
@@ -41,3 +41,97 @@ config SPL_SUNXI_CE_AES
 	  Select this option to enable AES decryption in SPL using the Crypto
 	  Engine found in Allwinner H6 and H616 compatible SoCs. This can be
 	  used to decrypt FIT images before loading U-Boot proper.
+
+config SUNXI_CE_ECDSA
+	bool "Allwinner sunxi CE ECDSA verifier"
+	depends on ARCH_SUNXI
+	depends on ECDSA_VERIFY
+	depends on CLK && DM_RESET
+	select SUNXI_CE
+	help
+	  Select this option to enable ECDSA signature verification using
+	  the Crypto Engine found in Allwinner sunxi SoCs. FIT image
+	  signatures can then be checked by the hardware accelerator in
+	  U-Boot proper. Digests wider than the selected curve are
+	  truncated according to ECDSA rules.
+
+config SPL_SUNXI_CE_ECDSA
+	bool "Allwinner sunxi CE ECDSA verifier in SPL"
+	depends on ARCH_SUNXI
+	depends on MACH_SUN50I_H6 || MACH_SUN50I_H616
+	depends on SPL_DM
+	depends on SPL_OF_CONTROL
+	depends on SPL_ECDSA_VERIFY
+	select SPL_CRYPTO
+	select SPL_SUNXI_CE
+	help
+	  Select this option to enable ECDSA signature verification in SPL
+	  using the Crypto Engine found in Allwinner H6 and H616 compatible
+	  SoCs.
+	  This allows SPL FIT image signatures to be checked by the hardware
+	  accelerator before U-Boot proper is loaded. Digests wider than the
+	  selected curve are truncated according to ECDSA rules.
+
+if SUNXI_CE_ECDSA
+
+config SUNXI_CE_ECDSA_SECP224R1
+	bool "Support secp224r1"
+	default y
+	help
+	  Enable the secp224r1 curve parameters for the sunxi CE ECDSA
+	  verifier.
+
+config SUNXI_CE_ECDSA_PRIME256V1
+	bool "Support prime256v1"
+	default y
+	help
+	  Enable the prime256v1 curve parameters for the sunxi CE ECDSA
+	  verifier.
+
+config SUNXI_CE_ECDSA_SECP384R1
+	bool "Support secp384r1"
+	default y
+	help
+	  Enable the secp384r1 curve parameters for the sunxi CE ECDSA
+	  verifier.
+
+config SUNXI_CE_ECDSA_SECP521R1
+	bool "Support secp521r1"
+	default y
+	help
+	  Enable the secp521r1 curve parameters for the sunxi CE ECDSA
+	  verifier.
+
+endif
+
+if SPL_SUNXI_CE_ECDSA
+
+config SPL_SUNXI_CE_ECDSA_SECP224R1
+	bool "Support secp224r1 in SPL"
+	default y
+	help
+	  Enable the secp224r1 curve parameters for the sunxi CE ECDSA
+	  verifier in SPL.
+
+config SPL_SUNXI_CE_ECDSA_PRIME256V1
+	bool "Support prime256v1 in SPL"
+	default y
+	help
+	  Enable the prime256v1 curve parameters for the sunxi CE ECDSA
+	  verifier in SPL.
+
+config SPL_SUNXI_CE_ECDSA_SECP384R1
+	bool "Support secp384r1 in SPL"
+	default y
+	help
+	  Enable the secp384r1 curve parameters for the sunxi CE ECDSA
+	  verifier in SPL.
+
+config SPL_SUNXI_CE_ECDSA_SECP521R1
+	bool "Support secp521r1 in SPL"
+	default y
+	help
+	  Enable the secp521r1 curve parameters for the sunxi CE ECDSA
+	  verifier in SPL.
+
+endif
diff --git a/drivers/crypto/allwinner/sun8i-ce/Makefile b/drivers/crypto/allwinner/sun8i-ce/Makefile
index 2a8778065b1..753ea827a0d 100644
--- a/drivers/crypto/allwinner/sun8i-ce/Makefile
+++ b/drivers/crypto/allwinner/sun8i-ce/Makefile
@@ -2,3 +2,4 @@
 
 obj-$(CONFIG_$(PHASE_)SUNXI_CE) += sun8i-ce-core.o
 obj-$(CONFIG_$(PHASE_)SUNXI_CE_AES) += sun8i-ce-aes.o
+obj-$(CONFIG_$(PHASE_)SUNXI_CE_ECDSA) += sun8i-ce-ecdsa.o
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
index 6c4ccf4c61f..0e5c6bf2c13 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
@@ -681,6 +681,12 @@ static int sunxi_ce_bind(struct udevice *dev)
 			return ret;
 	}
 
+	if (CONFIG_IS_ENABLED(SUNXI_CE_ECDSA)) {
+		ret = sunxi_ce_bind_child(dev, "sun8i-ce-ecdsa");
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-ecdsa.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-ecdsa.c
new file mode 100644
index 00000000000..f9b36347e4f
--- /dev/null
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-ecdsa.c
@@ -0,0 +1,382 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 James Hilliard
+ */
+
+#include <crypto/ecdsa-uclass.h>
+#include <dm.h>
+#include <malloc.h>
+#include <memalign.h>
+#include <string.h>
+#include <linux/kernel.h>
+#include "sun8i-ce.h"
+
+enum sunxi_ecdsa_field {
+	SUNXI_ECDSA_FIELD_N,
+	SUNXI_ECDSA_FIELD_S,
+	SUNXI_ECDSA_FIELD_E,
+	SUNXI_ECDSA_FIELD_R,
+	SUNXI_ECDSA_FIELD_P,
+	SUNXI_ECDSA_FIELD_A,
+	SUNXI_ECDSA_FIELD_GX,
+	SUNXI_ECDSA_FIELD_GY,
+	SUNXI_ECDSA_FIELD_QX,
+	SUNXI_ECDSA_FIELD_QY,
+	SUNXI_ECDSA_FIELD_N2,
+	SUNXI_ECDSA_FIELD_R2,
+	SUNXI_ECDSA_FIELD_COUNT,
+};
+
+#define SUNXI_ECDSA_MAX_WORDS						\
+	(CONFIG_IS_ENABLED(SUNXI_CE_ECDSA_SECP521R1) ? 17 :		\
+	 CONFIG_IS_ENABLED(SUNXI_CE_ECDSA_SECP384R1) ? 12 :		\
+	 CONFIG_IS_ENABLED(SUNXI_CE_ECDSA_PRIME256V1) ? 8 :		\
+	 CONFIG_IS_ENABLED(SUNXI_CE_ECDSA_SECP224R1) ? 7 : 1)
+#define SUNXI_ECDSA_MAX_BYTES		(SUNXI_ECDSA_MAX_WORDS * sizeof(u32))
+#define SUNXI_ECDSA_MAX_SRC_BYTES	\
+	(SUNXI_ECDSA_FIELD_COUNT * SUNXI_ECDSA_MAX_BYTES)
+#define SUNXI_ECDSA_MAX_DST_BYTES	ALIGN(SUNXI_ECDSA_MAX_BYTES, \
+					      ARCH_DMA_MINALIGN)
+
+struct sunxi_ecdsa_job {
+	struct sunxi_ce_task task __aligned(ARCH_DMA_MINALIGN);
+	u8 src[SUNXI_ECDSA_MAX_SRC_BYTES] __aligned(ARCH_DMA_MINALIGN);
+	u8 dst[SUNXI_ECDSA_MAX_DST_BYTES] __aligned(ARCH_DMA_MINALIGN);
+};
+
+struct sunxi_ecdsa_curve {
+	/* p, Gx, Gy and n as consecutive big-endian curve-width values. */
+	const u8 *params;
+	u16 bits;
+	u8 bytes;
+	u8 words;
+};
+
+static const u8 ecdsa_p224_params[] = {
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x01,
+	/* Gx */
+	0xb7, 0x0e, 0x0c, 0xbd, 0x6b, 0xb4, 0xbf, 0x7f,
+	0x32, 0x13, 0x90, 0xb9, 0x4a, 0x03, 0xc1, 0xd3,
+	0x56, 0xc2, 0x11, 0x22, 0x34, 0x32, 0x80, 0xd6,
+	0x11, 0x5c, 0x1d, 0x21,
+	/* Gy */
+	0xbd, 0x37, 0x63, 0x88, 0xb5, 0xf7, 0x23, 0xfb,
+	0x4c, 0x22, 0xdf, 0xe6, 0xcd, 0x43, 0x75, 0xa0,
+	0x5a, 0x07, 0x47, 0x64, 0x44, 0xd5, 0x81, 0x99,
+	0x85, 0x00, 0x7e, 0x34,
+	/* n */
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x16, 0xa2,
+	0xe0, 0xb8, 0xf0, 0x3e, 0x13, 0xdd, 0x29, 0x45,
+	0x5c, 0x5c, 0x2a, 0x3d,
+};
+
+static const u8 ecdsa_p256_params[] = {
+	0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0x00, 0x01,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	/* Gx */
+	0x6b, 0x17, 0xd1, 0xf2, 0xe1, 0x2c, 0x42, 0x47,
+	0xf8, 0xbc, 0xe6, 0xe5, 0x63, 0xa4, 0x40, 0xf2,
+	0x77, 0x03, 0x7d, 0x81, 0x2d, 0xeb, 0x33, 0xa0,
+	0xf4, 0xa1, 0x39, 0x45, 0xd8, 0x98, 0xc2, 0x96,
+	/* Gy */
+	0x4f, 0xe3, 0x42, 0xe2, 0xfe, 0x1a, 0x7f, 0x9b,
+	0x8e, 0xe7, 0xeb, 0x4a, 0x7c, 0x0f, 0x9e, 0x16,
+	0x2b, 0xce, 0x33, 0x57, 0x6b, 0x31, 0x5e, 0xce,
+	0xcb, 0xb6, 0x40, 0x68, 0x37, 0xbf, 0x51, 0xf5,
+	/* n */
+	0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xbc, 0xe6, 0xfa, 0xad, 0xa7, 0x17, 0x9e, 0x84,
+	0xf3, 0xb9, 0xca, 0xc2, 0xfc, 0x63, 0x25, 0x51,
+};
+
+static const u8 ecdsa_p384_params[] = {
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xfe,
+	0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff,
+	/* Gx */
+	0xaa, 0x87, 0xca, 0x22, 0xbe, 0x8b, 0x05, 0x37,
+	0x8e, 0xb1, 0xc7, 0x1e, 0xf3, 0x20, 0xad, 0x74,
+	0x6e, 0x1d, 0x3b, 0x62, 0x8b, 0xa7, 0x9b, 0x98,
+	0x59, 0xf7, 0x41, 0xe0, 0x82, 0x54, 0x2a, 0x38,
+	0x55, 0x02, 0xf2, 0x5d, 0xbf, 0x55, 0x29, 0x6c,
+	0x3a, 0x54, 0x5e, 0x38, 0x72, 0x76, 0x0a, 0xb7,
+	/* Gy */
+	0x36, 0x17, 0xde, 0x4a, 0x96, 0x26, 0x2c, 0x6f,
+	0x5d, 0x9e, 0x98, 0xbf, 0x92, 0x92, 0xdc, 0x29,
+	0xf8, 0xf4, 0x1d, 0xbd, 0x28, 0x9a, 0x14, 0x7c,
+	0xe9, 0xda, 0x31, 0x13, 0xb5, 0xf0, 0xb8, 0xc0,
+	0x0a, 0x60, 0xb1, 0xce, 0x1d, 0x7e, 0x81, 0x9d,
+	0x7a, 0x43, 0x1d, 0x7c, 0x90, 0xea, 0x0e, 0x5f,
+	/* n */
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xc7, 0x63, 0x4d, 0x81, 0xf4, 0x37, 0x2d, 0xdf,
+	0x58, 0x1a, 0x0d, 0xb2, 0x48, 0xb0, 0xa7, 0x7a,
+	0xec, 0xec, 0x19, 0x6a, 0xcc, 0xc5, 0x29, 0x73,
+};
+
+static const u8 ecdsa_p521_params[] = {
+	0x01, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff,
+	/* Gx */
+	0x00, 0xc6, 0x85, 0x8e, 0x06, 0xb7, 0x04, 0x04,
+	0xe9, 0xcd, 0x9e, 0x3e, 0xcb, 0x66, 0x23, 0x95,
+	0xb4, 0x42, 0x9c, 0x64, 0x81, 0x39, 0x05, 0x3f,
+	0xb5, 0x21, 0xf8, 0x28, 0xaf, 0x60, 0x6b, 0x4d,
+	0x3d, 0xba, 0xa1, 0x4b, 0x5e, 0x77, 0xef, 0xe7,
+	0x59, 0x28, 0xfe, 0x1d, 0xc1, 0x27, 0xa2, 0xff,
+	0xa8, 0xde, 0x33, 0x48, 0xb3, 0xc1, 0x85, 0x6a,
+	0x42, 0x9b, 0xf9, 0x7e, 0x7e, 0x31, 0xc2, 0xe5,
+	0xbd, 0x66,
+	/* Gy */
+	0x01, 0x18, 0x39, 0x29, 0x6a, 0x78, 0x9a, 0x3b,
+	0xc0, 0x04, 0x5c, 0x8a, 0x5f, 0xb4, 0x2c, 0x7d,
+	0x1b, 0xd9, 0x98, 0xf5, 0x44, 0x49, 0x57, 0x9b,
+	0x44, 0x68, 0x17, 0xaf, 0xbd, 0x17, 0x27, 0x3e,
+	0x66, 0x2c, 0x97, 0xee, 0x72, 0x99, 0x5e, 0xf4,
+	0x26, 0x40, 0xc5, 0x50, 0xb9, 0x01, 0x3f, 0xad,
+	0x07, 0x61, 0x35, 0x3c, 0x70, 0x86, 0xa2, 0x72,
+	0xc2, 0x40, 0x88, 0xbe, 0x94, 0x76, 0x9f, 0xd1,
+	0x66, 0x50,
+	/* n */
+	0x01, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xfa, 0x51, 0x86, 0x87, 0x83, 0xbf, 0x2f,
+	0x96, 0x6b, 0x7f, 0xcc, 0x01, 0x48, 0xf7, 0x09,
+	0xa5, 0xd0, 0x3b, 0xb5, 0xc9, 0xb8, 0x89, 0x9c,
+	0x47, 0xae, 0xbb, 0x6f, 0xb7, 0x1e, 0x91, 0x38,
+	0x64, 0x09,
+};
+
+static const struct sunxi_ecdsa_curve sunxi_ecdsa_secp224r1 = {
+	.bits = 224,
+	.bytes = 28,
+	.words = 7,
+	.params = ecdsa_p224_params,
+};
+
+static const struct sunxi_ecdsa_curve sunxi_ecdsa_prime256v1 = {
+	.bits = 256,
+	.bytes = 32,
+	.words = 8,
+	.params = ecdsa_p256_params,
+};
+
+static const struct sunxi_ecdsa_curve sunxi_ecdsa_secp384r1 = {
+	.bits = 384,
+	.bytes = 48,
+	.words = 12,
+	.params = ecdsa_p384_params,
+};
+
+static const struct sunxi_ecdsa_curve sunxi_ecdsa_secp521r1 = {
+	.bits = 521,
+	.bytes = 66,
+	.words = 17,
+	.params = ecdsa_p521_params,
+};
+
+static const struct sunxi_ecdsa_curve *
+sunxi_ecdsa_find_curve(const struct ecdsa_public_key *pubkey)
+{
+	if (CONFIG_IS_ENABLED(SUNXI_CE_ECDSA_SECP224R1) &&
+	    !strcmp(pubkey->curve_name, "secp224r1"))
+		return &sunxi_ecdsa_secp224r1;
+	if (CONFIG_IS_ENABLED(SUNXI_CE_ECDSA_PRIME256V1) &&
+	    !strcmp(pubkey->curve_name, "prime256v1"))
+		return &sunxi_ecdsa_prime256v1;
+	if (CONFIG_IS_ENABLED(SUNXI_CE_ECDSA_SECP384R1) &&
+	    !strcmp(pubkey->curve_name, "secp384r1"))
+		return &sunxi_ecdsa_secp384r1;
+	if (CONFIG_IS_ENABLED(SUNXI_CE_ECDSA_SECP521R1) &&
+	    !strcmp(pubkey->curve_name, "secp521r1"))
+		return &sunxi_ecdsa_secp521r1;
+
+	return NULL;
+}
+
+static u8 *sunxi_ecdsa_copy_le_param(u8 *dst,
+				     const struct sunxi_ecdsa_curve *curve,
+				     const void *src, size_t len)
+{
+	const u8 *p = src;
+	size_t copy_len;
+	int i;
+
+	copy_len = min_t(size_t, len, curve->bytes);
+	for (i = 0; i < copy_len; i++)
+		dst[i] = p[copy_len - 1 - i];
+
+	return dst + curve->words * sizeof(u32);
+}
+
+static void sunxi_ecdsa_fill_src(struct sunxi_ecdsa_job *job,
+				 const struct sunxi_ecdsa_curve *curve,
+				 const struct ecdsa_public_key *pubkey,
+				 const void *hash, size_t hash_len,
+				 const void *signature)
+{
+	const u8 *r = signature;
+	const u8 *s = r + curve->bytes;
+	const u8 *p = curve->params;
+	const u8 *gx = p + curve->bytes;
+	const u8 *gy = gx + curve->bytes;
+	const u8 *n = gy + curve->bytes;
+	const void *params[SUNXI_ECDSA_FIELD_COUNT] = {
+		[SUNXI_ECDSA_FIELD_N] = n,
+		[SUNXI_ECDSA_FIELD_S] = s,
+		[SUNXI_ECDSA_FIELD_E] = hash,
+		[SUNXI_ECDSA_FIELD_R] = r,
+		[SUNXI_ECDSA_FIELD_P] = p,
+		[SUNXI_ECDSA_FIELD_A] = p,
+		[SUNXI_ECDSA_FIELD_GX] = gx,
+		[SUNXI_ECDSA_FIELD_GY] = gy,
+		[SUNXI_ECDSA_FIELD_QX] = pubkey->x,
+		[SUNXI_ECDSA_FIELD_QY] = pubkey->y,
+		[SUNXI_ECDSA_FIELD_N2] = n,
+		[SUNXI_ECDSA_FIELD_R2] = r,
+	};
+	u8 *dst = job->src;
+	u32 i;
+
+	/*
+	 * The CE manual specifies this fixed sequence of little-endian
+	 * curve-width fields for ECC signature verification:
+	 *
+	 *   n, s, e, r, p, a, Gx, Gy, Qx, Qy, n, r
+	 */
+	for (i = 0; i < ARRAY_SIZE(params); i++) {
+		u8 *field = dst;
+		size_t len = i == SUNXI_ECDSA_FIELD_E ? hash_len : curve->bytes;
+
+		dst = sunxi_ecdsa_copy_le_param(dst, curve, params[i], len);
+		if (i == SUNXI_ECDSA_FIELD_A) {
+			u32 borrow;
+
+			/* All supported NIST curves use a = p - 3. */
+			for (borrow = 3; borrow; field++) {
+				u8 val = *field;
+
+				*field = val - borrow;
+				borrow = val < borrow;
+			}
+		}
+	}
+}
+
+static void sunxi_ecdsa_fill_task(struct sunxi_ce_priv *priv,
+				  struct sunxi_ecdsa_job *job,
+				  const struct sunxi_ecdsa_curve *curve,
+				  dma_addr_t src, dma_addr_t dst)
+{
+	struct sunxi_ce_task *task = &job->task;
+	u32 bytes = curve->words * sizeof(u32);
+
+	task->t_asym_ctl = curve->words |
+			   (SUNXI_CE_ECC_OP_VERIFY << SUNXI_CE_ECC_OP_SHIFT);
+	/* The ECC engine uses a byte-sized task length. */
+	task->t_dlen = SUNXI_ECDSA_FIELD_COUNT * bytes;
+	task->t_src[0].addr = sunxi_ce_desc_dma_addr(priv, src);
+	task->t_src[0].len = task->t_dlen / sizeof(u32);
+	task->t_dst[0].addr = sunxi_ce_desc_dma_addr(priv, dst);
+	task->t_dst[0].len = curve->words;
+}
+
+static int sunxi_ecdsa_run(struct sunxi_ce_priv *priv,
+			   struct sunxi_ecdsa_job *job,
+			   const struct sunxi_ecdsa_curve *curve)
+{
+	size_t dst_len = curve->words * sizeof(u32);
+	size_t src_len = SUNXI_ECDSA_FIELD_COUNT * dst_len;
+	struct sunxi_ce_dma_buf src_dma = { };
+	struct sunxi_ce_dma_buf dst_dma = { };
+	u32 result;
+	int ret;
+
+	ret = sunxi_ce_dma_map(priv, &src_dma, job->src, src_len,
+			       DMA_TO_DEVICE);
+	if (ret)
+		goto out;
+	ret = sunxi_ce_dma_map(priv, &dst_dma, job->dst, sizeof(job->dst),
+			       DMA_FROM_DEVICE);
+	if (ret)
+		goto out;
+
+	sunxi_ecdsa_fill_task(priv, job, curve, src_dma.dma, dst_dma.dma);
+
+	ret = sunxi_ce_run_task(priv, SUNXI_CE_CHANNEL_ASYM,
+				SUNXI_CE_METHOD_ECC, &job->task);
+
+out:
+	sunxi_ce_dma_unmap(&dst_dma);
+	sunxi_ce_dma_unmap(&src_dma);
+	if (ret)
+		return ret;
+
+	result = *(u32 *)job->dst;
+
+	return result == 1 ? 0 : -EPERM;
+}
+
+static int sunxi_ecdsa_verify_dm(struct udevice *dev,
+				 const struct ecdsa_public_key *pubkey,
+				 const void *hash, size_t hash_len,
+				 const void *signature, size_t sig_len)
+{
+	struct sunxi_ce_priv *priv = dev_get_priv(dev_get_parent(dev));
+	const struct sunxi_ecdsa_curve *curve;
+	struct sunxi_ecdsa_job *job;
+	int ret;
+
+	if (!priv || !pubkey || !pubkey->curve_name || !pubkey->x ||
+	    !pubkey->y || !hash || !hash_len || !signature)
+		return -EINVAL;
+
+	curve = sunxi_ecdsa_find_curve(pubkey);
+	if (!curve || pubkey->size_bits != curve->bits ||
+	    sig_len != curve->bytes * 2)
+		return -EINVAL;
+
+	job = malloc_cache_aligned(sizeof(*job));
+	if (!job)
+		return -ENOMEM;
+
+	memset(job, 0, sizeof(*job));
+	sunxi_ecdsa_fill_src(job, curve, pubkey, hash, hash_len, signature);
+
+	ret = sunxi_ecdsa_run(priv, job, curve);
+	free(job);
+
+	return ret;
+}
+
+static const struct ecdsa_ops sunxi_ecdsa_ops = {
+	.verify = sunxi_ecdsa_verify_dm,
+};
+
+U_BOOT_DRIVER(sun8i_ce_ecdsa) = {
+	.name = "sun8i-ce-ecdsa",
+	.id = UCLASS_ECDSA,
+	.ops = &sunxi_ecdsa_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
index d0035af559a..d5b7edd357d 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
@@ -21,6 +21,9 @@
 #define SUNXI_CE_COMM_INT		BIT(31)
 #define SUNXI_CE_METHOD_AES		0
 #define SUNXI_CE_METHOD_RAES		0x30
+#define SUNXI_CE_METHOD_ECC		33
+#define SUNXI_CE_ECC_OP_VERIFY		7
+#define SUNXI_CE_ECC_OP_SHIFT		16
 #define SUNXI_CE_MAX_SG			8
 #define SUNXI_CE_MAX_CHANS		4
 #define SUNXI_CE_CHAN_ERR_MASK(x)	(0xffU << ((x) * 8))

-- 
2.53.0

