Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60DC3CCF2C4
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 04:37:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0BEF28156B;
	Sat, 17 Oct 2026 04:37:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QM2QNkvQ7loC; Sat, 17 Oct 2026 04:37:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3CB1181666
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792211817;
	b=OBgXopepymjSsVaZAp5kp7QtYXVk8ruCZPMLZGIJF4solN4HBQ/HMrR2w01HER6oscN6
	 HCJqeqwV4mZCqtvYMeGfp4Ea56zaRPaH9Vu9FrE/pIvNKBCQGa/JVP7hOvldZoEahEJj3
	 BJk7mCTR4ij2gmLacQNiKhjg4QHoAOyiUC94jYhtnef8NzaIklvs994vcVTaXDKsm/YjQ
	 rzKke9PPcK/SXautX+Rg5KH+oaWha8r3VFsTGqTQ5gNkBtdjX6rvDxQHlE9lBLYJFlIRy
	 EiCRySz7rseO0QrMiZ3oV1QgY5mHTAK6pZTfukyCIc+FIZ2bWELuyk/orxWox549iLA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792211817;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SQLPk7wbtQiTVfQ1EpUDdPY5NdUGLctlPvLUsSPnxBw=;
	b=eeuU7aeaxCojrXlyR69UJx85CNk6d0TZHYWSUQu1PjPFKyB9jDkD1I6m17EKuTnYm57M
	 8BI1t/s2ANyIAt8n2JQdh+TTBuX4QK2NxyimNtmGn5uv4MSwLby3HJ8jp0aYt1woClX3L
	 cIYrBU/3dZw9kaxW7GxCksgZx+dxDvs4YlIoJ13sF7fy6ypvMnV8UNr0XqmM+RSR5ka05
	 S0oTRkgAZFwe2dTmz1hbI5YHTZMSgDaie178N2G6ATVBm1f8xCoeCIexj0uPCqAZXosTk
	 BGKDgLUGjJUzUw2PWUFfPsfaTRwM1tpa/bSUbZl27DbdUDa0HNkSWWoJCBgenP/fDjg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792211817;
	bh=SQLPk7wbtQiTVfQ1EpUDdPY5NdUGLctlPvLUsSPnxBw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uvU7SGFI5yguPHU2f0OmzDRJFkSaSQGIR8PT8EcJGz4b+OuxJy+M1aElBac1qoQTZ
	 7Do2Hz+/kzJbdkgQjoEtF8bU/3A7oJ0Vrvo5basXKc27EZZ/pW3XCX5qmFV3aCbBXk
	 4N+CaX6ft7al+XYo9r2Clve3wzjsQJiskyVueaMLk8tcnWkxP9TYkOD5r+y+O6vwf2
	 tevQNhNj4D7/D8aiqmaRxM1scfUclJA28vqR77rWL3VfX67k4EYe4SkJSUCK+22b9Y
	 v/Xc/b1AA1E+48NgLx/xH/Vy1/Q8r92p+LyISSsafkcdTuZQG/F+Z8R7PyO3BH5JcK
	 zN3m9WU35HrUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3CB1181666;
	Sat, 17 Oct 2026 04:36:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 039297AD
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:36:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DDDA560AEC
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:36:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 16qdfkuOt2xd for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 00:36:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8649560A7E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::34"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792197393;
 b=D5UHyk8GJAmxHVpYURSL93fyPtc4X97y2udOZtBpwxBg+QvzNeh9O8Ijonf1Icr971ro
 9xuv3makGesvSoXKd1jPMENoQQaaemzr1gcTzrmaq68fzzZLCprsT54JvJF+UmzyXnBqX
 f6QZl5C5lfOnG+Z0vz7OUyZ67vcW99f0oXRKZ2iqz49P4GVjwYIX3+ELVBJ/xrugRpNu4
 VsZFaHZEZNlPuz6ai+aBTa6LCbWYTj2Sta1VC3ut+rYkRF0SSWhmLyBFhoHnxgxe1zN2k
 eNZhx5uMv/OOkizjJLVArqBesZVKvieBEfk1vtJVLSbN+gnjI2enbCzf3QRxTMB3NGA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792197393;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=SQLPk7wbtQiTVfQ1EpUDdPY5NdUGLctlPvLUsSPnxBw=;
 b=iYjiJ5tE0GxDE6F5/K3g00hQLFSaPDyQnjheye8Pet2aJO5hpJdsJWgiO2l+/j4lNt5W
 fG8jDUo8RIgvhqcNIsw086Rs5q3EtXtfOYy+pFdEqCRug54nDRVhaTyYCqU8J5D26fFdf
 vz1Vn9EYZxGDPu1OM4sqSwcu0yiODgDKRv7bnSPfTifWWeLdAwmgGDf5pMPk9CmYK1jQb
 E+lh7Eapb2/NoV/SK+76XNfvEfRTVqYOcm+7Y1WqRk4D4C9E8YkwU4dpELFFmGv91LNxU
 zUZjjLfruJlLqEKKdjOsGsSX53LebwGQDQe3ZTcTVz18tYvuad1HDiFFKTzOqBKQy6A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=HKekjlZd; 
 arc=none smtp.remote-ip="2001:4860:4864:20::34"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::34; helo=mail-oa1-x34.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=HKekjlZd
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8649560A7E
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:36:32 +0000 (UTC)
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-49429181ce9so297809fac.0
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 17:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792197391; x=1792802191;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SQLPk7wbtQiTVfQ1EpUDdPY5NdUGLctlPvLUsSPnxBw=;
 b=HKekjlZdRSu2Fy2bVqLASWjDHupjmT1hStR758pa3qIcb4zJ12vModzNHayeTj7C3J
 H0Cpnhs4MD09P4SLcWJ0VUImJQb+7u9+m12qzmFFhN2LwXXKG6fX+cqbOyi4o9yt2SCb
 A3CTnTfsR2wRXTmoOYgjEZyN/RMdh9DD6oJDAhdp81Q7dSXQBcDdpQgNisgoltZUflqy
 UkbeNd16r55FpKFqTiJaXPf56KhKout6qTxjAeCV9cfxcAlZEOzdKi5mfnicpP6gZhbT
 7QMQKjouluLdRiXEPppR3+KeH4WBZ4OUnGkLUl8o5D8hV0zjNm9PtbU7emOL+cml555A
 q1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792197391; x=1792802191;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SQLPk7wbtQiTVfQ1EpUDdPY5NdUGLctlPvLUsSPnxBw=;
 b=qxvTtvaU5wtCk+93qz+K3Hdcg/EKrs5EvaE1b3tOjuefP4y9NXC4+8kHNjYN6Ib2la
 tChr1SrjMw5QsIe3NcDt9nR8h2AFv7DBgqlp82Sa/5zyi4XkiQIdXRSrKYEQ6Aafbrod
 SzEnEdQQRUX2LJjrXkytU0fLoWTopSFoekZXNZ/pBlZd6P7rlXXCd5gyI4QDezd/LIEI
 slRRE5vQk5nDUvv4mgey7+qJy6FqE6Ej/pR87S0dvVnIFS16taSrS0qJFj0/0AQMWaG+
 QKVTLYc+429g8gBfUG7WOzdo/IhoVQ6sLe9155EO6t1ZPHsgCK2NT3FqTAiX4Fp/GiJD
 hgew==
X-Forwarded-Encrypted: i=1;
 AKwUvBwhjLjJIlxfSNdxFxTWbV8EtcxgRdSaSNS7eSUc8ygoQkkaowFhDxaShdv11FGBJrkbc5yrvDs=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK87fVjBcfswXOcMMuliFKOOl7SHyaq58eSkayb38w1lY+6X0Jv
 ARqj6Tn64gpNyLkFSOjcBHeMLdfC7uGIMLqpjpwjkJL/kOqEBkiDcKF7
X-Gm-Gg: AYBFou0QrFPX7jXW6v3cEvpyLu/S83YIprUbVmRgCrM5+b1gUyOlCYBDFCNvj5FYw2n
 6QZSSvh3HH6rL/QCTzEJdVl1tudBABAYyWTVeOLQp3MjKRz5An447WeUuPNbHL3uPJji5x1kITu
 lfsbpeVzkHLn3nsDlwgfhxU5/rHhQTqweFcE38i+CAOEzZbPXlPNDE/A/0bUBMFHBGqWY8H+z8Y
 mxmcdLFepXFY7caNTH0CN6aPQQNuI5uqJD3c1h6FM/SY00tZshN4ildUBz0zofCFLpe0+tR+Pqg
 +0iCO+w2oYsfldAmU0DwN45BJ5+DqZFSVefSaJ2wHEqlJxPz1+JwD+UW59rlfQGzrTF8QMN6Adc
 mLyvD/55mKEqMGXT0BiBDU0DUCfExua3FW/Jz7Q4ntfkVpxMv5XPRQYY28Yw1EjV5nRxMEFszCT
 0wgqiKyca3LmRGJ/Fj0gX7AZY0C645xmeqWW3NupNuxRtyKt9SBv60RnEJr+6PqUO7vesZoYj3e
 jN2qnrazARS9V9n3VMQiR13CjOPc3ZSXKZBVE+Bzk4iXE/RZho+MMO+/rKPwY7GaONjZMrstoly
 L/vBc2HPSvh3k/Sht+Hkz9WKfVcy2fQ9Kak19yFEsDWxqsXsbIyqZ16RgnKMtw4AgMYGl1Xc+fw
 yicH6GZ7ajptM9dWRCTGLYg==
X-Received: by 2002:a05:687c:22cb:20b0:4a7:4730:affa with SMTP id
 586e51a60fabf-4a7579279e2mr1039884fac.24.1792197391164; 
 Fri, 16 Oct 2026 17:36:31 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a73b5b4291sm2745091fac.5.2026.10.16.17.36.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 17:36:30 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 16 Oct 2026 18:35:31 -0600
Subject: [PATCH v9 17/17] crypto: allwinner: add sun8i-ce hash driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-submit-ce-series-v2-v9-17-c24e64daafe9@gmail.com>
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

The Allwinner sun8i Crypto Engine includes hardware hash methods. Add a
UCLASS_HASH child for the sun8i-ce parent so FIT hash verification can use
the accelerator from U-Boot proper and SPL.

Support MD5, SHA1, SHA256, SHA384 and SHA512 with both one-shot and
progressive operations. Progressive updates buffer partial blocks, submit
complete blocks, feed each intermediate state back through hash input-IV
mode and retain the total message length for final padding. Keep the full
64-byte SHA384 internal state while returning its 48-byte digest. This
allows discontiguous FIT configuration regions to be hashed without a
software fallback.

Build the final hash padding in the driver. Stream directly addressable
input through bounded 64 MiB zero-copy tasks and word-unaligned input
through a fixed 128 KiB repack buffer. Keep heap use independent of input
size while word-aligned cacheline offsets remain zero-copy. Retain the
fixed task, padding and result storage in each progressive context to avoid
repeated allocation across updates.

Map input, padding, optional state and a cacheline-rounded private output
through the parent DMA objects. Keep the descriptor output length limited
to the algorithm state, then submit hash work on the dedicated completion
channel through the shared task-session API. Keep one session across every
continuation chunk while retiring each task before releasing its mappings.
Release mappings in reverse preparation order after the session retires.

H6 and H616 use bit-sized hash task lengths, so keep each submitted chunk
within the 32-bit task descriptor field. Feed the watchdog from the shared
CE polling path while waiting for hardware completion.

In SPL, only advertise hash algorithms selected for that phase so
SRAM-constrained builds do not accept wider algorithms unless requested.

Progressive updates complete or abort their CE sessions before returning.
The abort operation can therefore release the idle context directly after
an update error.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v7 -> v8:
  - Add progressive context cleanup through the hash abort operation

Changes v6 -> v7:
  - Add progressive init, update and finish operations
  - Buffer partial blocks and reuse CE intermediate hash state across updates
  - Retain the full SHA384 internal state across progressive operations
  - Allocate fixed progressive job storage once per hash context

Changes v4 -> v5:
  - Use the parent's explicit close-on-error blocking helper to populate
    descriptor transport fields and abort failed chains before callers
    release their DMA mappings
  - Replace the algorithm switch and separate size lookups with one table
  - Derive bounded padding without adding near the input-size limit, and
    validate input ranges and descriptor-length arithmetic
  - Replace the payload-sized word-unaligned bounce with a fixed 128 KiB
    streaming repack while keeping word-aligned cacheline offsets zero-copy
  - Split large direct input into bounded 64 MiB tasks and use one
    continuation loop and one CE session for direct and repacked input
  - Carry intermediate state through hash input-IV mode
  - Use shared cacheline-safe DMA mappings and round private result storage
    to complete cachelines

Changes v3 -> v4:
  - Consolidate algorithm selection and invariant task sizing
  - Use the dedicated hash channel and shared task-session path
  - Return -EOPNOTSUPP for unavailable algorithms

Changes v1 -> v2:
  - Reject oversized bit-length hash tasks  (suggested by Simon Glass)
  - Feed the watchdog during CE polling  (suggested by Simon Glass)
  - Drop the post-operation schedule() call  (suggested by Simon Glass)
  - Bounce only word-unaligned input
---
 drivers/crypto/allwinner/sun8i-ce/Kconfig         |  26 ++
 drivers/crypto/allwinner/sun8i-ce/Makefile        |   1 +
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c |   6 +
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c | 494 ++++++++++++++++++++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h      |   5 +
 5 files changed, 532 insertions(+)

diff --git a/drivers/crypto/allwinner/sun8i-ce/Kconfig b/drivers/crypto/allwinner/sun8i-ce/Kconfig
index 01d58ac32fa..616f1a55c63 100644
--- a/drivers/crypto/allwinner/sun8i-ce/Kconfig
+++ b/drivers/crypto/allwinner/sun8i-ce/Kconfig
@@ -42,6 +42,32 @@ config SPL_SUNXI_CE_AES
 	  Engine found in Allwinner H6 and H616 compatible SoCs. This can be
 	  used to decrypt FIT images before loading U-Boot proper.
 
+config SUNXI_CE_HASH
+	bool "Allwinner sunxi CE hash"
+	depends on ARCH_SUNXI
+	depends on DM_HASH
+	depends on CLK && DM_RESET
+	select SUNXI_CE
+	help
+	  Select this option to enable hash calculation using the Crypto Engine
+	  found in Allwinner sunxi SoCs. The driver supports MD5, SHA1,
+	  SHA256, SHA384 and SHA512.
+
+config SPL_SUNXI_CE_HASH
+	bool "Allwinner sunxi CE hash in SPL"
+	depends on ARCH_SUNXI
+	depends on MACH_SUN50I_H6 || MACH_SUN50I_H616
+	depends on SPL_DM
+	depends on SPL_OF_CONTROL
+	select SPL_DM_HASH
+	select SPL_CRYPTO
+	select SPL_SUNXI_CE
+	help
+	  Select this option to enable hash calculation in SPL using the Crypto
+	  Engine found in Allwinner H6 and H616 compatible SoCs. FIT image
+	  hashes can then be calculated by the hardware accelerator before
+	  U-Boot proper is loaded.
+
 config SUNXI_CE_ECDSA
 	bool "Allwinner sunxi CE ECDSA verifier"
 	depends on ARCH_SUNXI
diff --git a/drivers/crypto/allwinner/sun8i-ce/Makefile b/drivers/crypto/allwinner/sun8i-ce/Makefile
index 753ea827a0d..5baf65e40ec 100644
--- a/drivers/crypto/allwinner/sun8i-ce/Makefile
+++ b/drivers/crypto/allwinner/sun8i-ce/Makefile
@@ -2,4 +2,5 @@
 
 obj-$(CONFIG_$(PHASE_)SUNXI_CE) += sun8i-ce-core.o
 obj-$(CONFIG_$(PHASE_)SUNXI_CE_AES) += sun8i-ce-aes.o
+obj-$(CONFIG_$(PHASE_)SUNXI_CE_HASH) += sun8i-ce-hash.o
 obj-$(CONFIG_$(PHASE_)SUNXI_CE_ECDSA) += sun8i-ce-ecdsa.o
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
index 0e5c6bf2c13..93f42c5d9b9 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
@@ -687,6 +687,12 @@ static int sunxi_ce_bind(struct udevice *dev)
 			return ret;
 	}
 
+	if (CONFIG_IS_ENABLED(SUNXI_CE_HASH)) {
+		ret = sunxi_ce_bind_child(dev, "sun8i-ce-hash");
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
new file mode 100644
index 00000000000..cc16237e76f
--- /dev/null
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c
@@ -0,0 +1,494 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 James Hilliard
+ */
+
+#define LOG_CATEGORY UCLASS_HASH
+
+#include <dm.h>
+#include <limits.h>
+#include <malloc.h>
+#include <memalign.h>
+#include <u-boot/hash.h>
+#include <u-boot/md5.h>
+#include <u-boot/sha1.h>
+#include <u-boot/sha256.h>
+#include <u-boot/sha512.h>
+#include <linux/kernel.h>
+#include "sun8i-ce.h"
+
+#define SUNXI_CE_HASH_MAX_BLOCK_SIZE	SHA512_BLOCK_SIZE
+#define SUNXI_CE_HASH_MAX_DIGEST_SIZE	SHA512_SUM_LEN
+#define SUNXI_CE_HASH_RESULT_SIZE	ALIGN(SUNXI_CE_HASH_MAX_DIGEST_SIZE, \
+					      ARCH_DMA_MINALIGN)
+#define SUNXI_CE_HASH_MAX_PAD_SIZE	(2 * SUNXI_CE_HASH_MAX_BLOCK_SIZE)
+#define SUNXI_CE_HASH_REPACK_SIZE	(128 * 1024)
+#define SUNXI_CE_HASH_DIRECT_SIZE	(64 * 1024 * 1024)
+#define SUNXI_CE_HASH_IV_INPUT		BIT(16)
+#define SUNXI_CE_HASH_BLOCK_SIZE		64
+
+static_assert(IS_ALIGNED(SUNXI_CE_HASH_REPACK_SIZE,
+			 SUNXI_CE_HASH_MAX_BLOCK_SIZE));
+static_assert(IS_ALIGNED(SUNXI_CE_HASH_DIRECT_SIZE,
+			 SUNXI_CE_HASH_MAX_BLOCK_SIZE));
+
+struct sunxi_hash_job {
+	struct sunxi_ce_task task __aligned(ARCH_DMA_MINALIGN);
+	u8 pad[SUNXI_CE_HASH_MAX_PAD_SIZE] __aligned(ARCH_DMA_MINALIGN);
+	u8 result[SUNXI_CE_HASH_RESULT_SIZE] __aligned(ARCH_DMA_MINALIGN);
+	u8 state[SUNXI_CE_HASH_MAX_DIGEST_SIZE] __aligned(ARCH_DMA_MINALIGN);
+};
+
+struct sunxi_hash_alg {
+	u8 method;
+	u8 block_size;
+	u8 digest_size;
+	u8 state_size;
+	bool little_endian_len;
+	bool available;
+};
+
+struct sunxi_hash_ctx {
+	struct udevice *dev;
+	const struct sunxi_hash_alg *alg;
+	u64 total_len;
+	u8 tail[SUNXI_CE_HASH_MAX_BLOCK_SIZE] __aligned(ARCH_DMA_MINALIGN);
+	u8 state[SUNXI_CE_HASH_MAX_DIGEST_SIZE] __aligned(ARCH_DMA_MINALIGN);
+	struct sunxi_hash_job job;
+	size_t tail_len;
+	bool state_valid;
+};
+
+static const struct sunxi_hash_alg sunxi_hash_algs[HASH_ALGO_NUM] = {
+	[HASH_ALGO_MD5] = {
+		.method = SUNXI_CE_METHOD_MD5,
+		.block_size = SUNXI_CE_HASH_BLOCK_SIZE,
+		.digest_size = MD5_SUM_LEN,
+		.state_size = MD5_SUM_LEN,
+		.little_endian_len = true,
+		.available = !IS_ENABLED(CONFIG_XPL_BUILD) ||
+			     CONFIG_IS_ENABLED(MD5),
+	},
+	[HASH_ALGO_SHA1] = {
+		.method = SUNXI_CE_METHOD_SHA1,
+		.block_size = SUNXI_CE_HASH_BLOCK_SIZE,
+		.digest_size = SHA1_SUM_LEN,
+		.state_size = SHA1_SUM_LEN,
+		.available = !IS_ENABLED(CONFIG_XPL_BUILD) ||
+			     CONFIG_IS_ENABLED(SHA1),
+	},
+	[HASH_ALGO_SHA256] = {
+		.method = SUNXI_CE_METHOD_SHA256,
+		.block_size = SUNXI_CE_HASH_BLOCK_SIZE,
+		.digest_size = SHA256_SUM_LEN,
+		.state_size = SHA256_SUM_LEN,
+		.available = !IS_ENABLED(CONFIG_XPL_BUILD) ||
+			     CONFIG_IS_ENABLED(SHA256),
+	},
+	[HASH_ALGO_SHA384] = {
+		.method = SUNXI_CE_METHOD_SHA384,
+		.block_size = SHA512_BLOCK_SIZE,
+		.digest_size = SHA384_SUM_LEN,
+		.state_size = SHA512_SUM_LEN,
+		.available = !IS_ENABLED(CONFIG_XPL_BUILD) ||
+			     CONFIG_IS_ENABLED(SHA384),
+	},
+	[HASH_ALGO_SHA512] = {
+		.method = SUNXI_CE_METHOD_SHA512,
+		.block_size = SHA512_BLOCK_SIZE,
+		.digest_size = SHA512_SUM_LEN,
+		.state_size = SHA512_SUM_LEN,
+		.available = !IS_ENABLED(CONFIG_XPL_BUILD) ||
+			     CONFIG_IS_ENABLED(SHA512),
+	},
+};
+
+static const struct sunxi_hash_alg *sunxi_hash_get_alg(enum HASH_ALGO algo)
+{
+	if ((u32)algo >= ARRAY_SIZE(sunxi_hash_algs) ||
+	    !sunxi_hash_algs[algo].available)
+		return NULL;
+
+	return &sunxi_hash_algs[algo];
+}
+
+static size_t sunxi_hash_pad(const struct sunxi_hash_alg *alg, u8 *pad,
+			     const u8 *tail, size_t tail_len, size_t len)
+{
+	size_t block_size = alg->block_size;
+	size_t rem = len % block_size;
+	size_t len_size = block_size == SHA512_BLOCK_SIZE ? 16 : 8;
+	size_t pad_len, len_off;
+	u64 bits;
+
+	pad_len = tail_len + (rem < block_size - len_size ?
+			       block_size - rem : 2 * block_size - rem);
+
+	memset(pad, 0, pad_len);
+	if (tail_len)
+		memcpy(pad, tail, tail_len);
+	pad[tail_len] = 0x80;
+
+	bits = (u64)len << 3;
+	len_off = pad_len - 8;
+	if (alg->little_endian_len) {
+		bits = cpu_to_le64(bits);
+		memcpy(pad + len_off, &bits, sizeof(bits));
+	} else {
+		bits = cpu_to_be64(bits);
+		memcpy(pad + len_off, &bits, sizeof(bits));
+	}
+
+	return pad_len;
+}
+
+static void sunxi_hash_fill_task(struct sunxi_ce_priv *ce,
+				 struct sunxi_hash_job *job,
+				 dma_addr_t iv,
+				 dma_addr_t src, size_t src_len,
+				 dma_addr_t pad, size_t pad_len,
+				 dma_addr_t result, size_t state_len)
+{
+	struct sunxi_ce_task *task = &job->task;
+	u32 total_len = src_len + pad_len;
+	u32 sg = 0;
+
+	memset(task, 0, sizeof(*task));
+
+	task->t_common_ctl = iv ? SUNXI_CE_HASH_IV_INPUT : 0;
+	if (iv)
+		task->t_iv = sunxi_ce_desc_dma_addr(ce, iv);
+	task->t_dlen = total_len * 8;
+
+	if (src_len) {
+		task->t_src[sg].addr = sunxi_ce_desc_dma_addr(ce, src);
+		task->t_src[sg].len = src_len / sizeof(u32);
+		sg++;
+	}
+	if (pad_len) {
+		task->t_src[sg].addr = sunxi_ce_desc_dma_addr(ce, pad);
+		task->t_src[sg].len = pad_len / sizeof(u32);
+	}
+
+	task->t_dst[0].addr = sunxi_ce_desc_dma_addr(ce, result);
+	task->t_dst[0].len = state_len / sizeof(u32);
+}
+
+static int sunxi_hash_run_chunk(struct sunxi_ce_priv *ce,
+				struct sunxi_ce_session *session,
+				struct sunxi_hash_job *job,
+				u32 method,
+				const void *src, size_t src_len, size_t pad_len,
+				const void *iv, size_t state_len)
+{
+	struct sunxi_ce_dma_buf result_dma = { };
+	struct sunxi_ce_dma_buf src_dma = { };
+	struct sunxi_ce_dma_buf pad_dma = { };
+	struct sunxi_ce_dma_buf iv_dma = { };
+	int ret;
+
+	if (!IS_ALIGNED(src_len, sizeof(u32)) ||
+	    !IS_ALIGNED(pad_len, sizeof(u32)) ||
+	    src_len > U32_MAX / 8 || pad_len > U32_MAX / 8 - src_len)
+		return -EINVAL;
+
+	ret = sunxi_ce_dma_map(ce, &src_dma, (void *)src, src_len,
+			       DMA_TO_DEVICE);
+	if (ret)
+		goto out_unmap;
+	ret = sunxi_ce_dma_map(ce, &pad_dma, job->pad, pad_len,
+			       DMA_TO_DEVICE);
+	if (ret)
+		goto out_unmap;
+	ret = sunxi_ce_dma_map(ce, &iv_dma, (void *)iv, iv ? state_len : 0,
+			       DMA_TO_DEVICE);
+	if (ret)
+		goto out_unmap;
+	ret = sunxi_ce_dma_map(ce, &result_dma, job->result,
+			       sizeof(job->result),
+			       DMA_FROM_DEVICE);
+	if (ret)
+		goto out_unmap;
+
+	sunxi_hash_fill_task(ce, job, iv_dma.dma, src_dma.dma,
+			     src_len, pad_dma.dma, pad_len, result_dma.dma,
+			     state_len);
+
+	ret = sunxi_ce_session_run_chain_or_close(session,
+						  SUNXI_CE_CHANNEL_HASH, method,
+						  &job->task, 1);
+
+out_unmap:
+	sunxi_ce_dma_unmap(&result_dma);
+	sunxi_ce_dma_unmap(&iv_dma);
+	sunxi_ce_dma_unmap(&pad_dma);
+	sunxi_ce_dma_unmap(&src_dma);
+
+	return ret;
+}
+
+static int sunxi_hash_run_stream(struct sunxi_ce_priv *ce,
+				 struct sunxi_hash_job *job,
+				 u32 method,
+				 const u8 *src, size_t src_len,
+				 size_t pad_len, size_t state_len,
+				 const void *initial_iv)
+{
+	struct sunxi_ce_session session;
+	const void *iv = initial_iv;
+	const void *chunk;
+	size_t chunk_size;
+	u8 *repack = NULL;
+	int ret;
+
+	if (src_len && !IS_ALIGNED((uintptr_t)src, sizeof(u32))) {
+		/* CE scatter-gather addresses require word-aligned chunks. */
+		chunk_size = SUNXI_CE_HASH_REPACK_SIZE;
+		repack = memalign(ARCH_DMA_MINALIGN, chunk_size);
+		if (!repack)
+			return -ENOMEM;
+	} else {
+		chunk_size = SUNXI_CE_HASH_DIRECT_SIZE;
+	}
+
+	ret = sunxi_ce_session_begin(ce,
+				     SUNXI_CE_CHAN_MASK(SUNXI_CE_CHANNEL_HASH),
+				     &session);
+	if (ret)
+		goto out;
+
+	while (src_len > chunk_size) {
+		chunk = src;
+		if (repack) {
+			memcpy(repack, src, chunk_size);
+			chunk = repack;
+		}
+		ret = sunxi_hash_run_chunk(ce, &session, job, method, chunk,
+					   chunk_size, 0, iv, state_len);
+		if (ret)
+			goto out_close;
+
+		memcpy(job->state, job->result, state_len);
+		iv = job->state;
+		src += chunk_size;
+		src_len -= chunk_size;
+	}
+
+	chunk = src;
+	if (repack) {
+		memcpy(repack, src, src_len);
+		chunk = repack;
+	}
+	ret = sunxi_hash_run_chunk(ce, &session, job, method, chunk, src_len,
+				   pad_len, iv, state_len);
+out_close:
+	ret = sunxi_ce_session_close(&session, ret);
+out:
+	free(repack);
+
+	return ret;
+}
+
+static int sunxi_hash_digest(struct udevice *dev, enum HASH_ALGO hash_algo,
+			     const void *ibuf, const uint32_t ilen, void *obuf)
+{
+	struct sunxi_ce_priv *ce = dev_get_priv(dev_get_parent(dev));
+	const struct sunxi_hash_alg *alg;
+	size_t src_len = ALIGN_DOWN(ilen, sizeof(u32));
+	size_t tail_len = ilen - src_len;
+	struct sunxi_hash_job *job;
+	const u8 *tail = ibuf;
+	size_t pad_len;
+	u8 digest_size, state_size;
+	u32 method;
+	int ret;
+
+	alg = sunxi_hash_get_alg(hash_algo);
+	if (!alg)
+		return -EOPNOTSUPP;
+	if ((!ibuf && ilen) || !obuf)
+		return -EINVAL;
+	if (ilen > UINTPTR_MAX - (uintptr_t)ibuf)
+		return -EOVERFLOW;
+	method = alg->method;
+	digest_size = alg->digest_size;
+	state_size = alg->state_size;
+
+	job = malloc_cache_aligned(sizeof(*job));
+	if (!job)
+		return -ENOMEM;
+
+	if (tail_len)
+		tail += src_len;
+
+	pad_len = sunxi_hash_pad(alg, job->pad, tail, tail_len, ilen);
+	ret = sunxi_hash_run_stream(ce, job, method, ibuf, src_len, pad_len,
+				    state_size, NULL);
+	if (ret)
+		goto out;
+
+	memcpy(obuf, job->result, digest_size);
+
+out:
+	free(job);
+
+	return ret;
+}
+
+static int sunxi_hash_process_blocks(struct sunxi_hash_ctx *ctx,
+				     const void *src, size_t len)
+{
+	struct sunxi_ce_priv *ce = dev_get_priv(dev_get_parent(ctx->dev));
+	struct sunxi_hash_job *job = &ctx->job;
+	int ret;
+
+	if (!len)
+		return 0;
+	if (!IS_ALIGNED(len, ctx->alg->block_size))
+		return -EINVAL;
+
+	ret = sunxi_hash_run_stream(ce, job, ctx->alg->method, src, len, 0,
+				    ctx->alg->state_size,
+				    ctx->state_valid ? ctx->state : NULL);
+	if (!ret) {
+		memcpy(ctx->state, job->result, ctx->alg->state_size);
+		ctx->state_valid = true;
+	}
+
+	return ret;
+}
+
+static int sunxi_hash_init(struct udevice *dev, enum HASH_ALGO algo,
+			   void **ctxp)
+{
+	const struct sunxi_hash_alg *alg;
+	struct sunxi_hash_ctx *ctx;
+
+	alg = sunxi_hash_get_alg(algo);
+	if (!alg)
+		return -EOPNOTSUPP;
+
+	ctx = memalign(ARCH_DMA_MINALIGN, sizeof(*ctx));
+	if (!ctx)
+		return -ENOMEM;
+
+	memset(ctx, 0, sizeof(*ctx));
+	ctx->dev = dev;
+	ctx->alg = alg;
+	*ctxp = ctx;
+
+	return 0;
+}
+
+static int sunxi_hash_update(struct udevice *dev, void *data,
+			     const void *ibuf, u32 ilen)
+{
+	struct sunxi_hash_ctx *ctx = data;
+	const u8 *src = ibuf;
+	size_t block_size = ctx->alg->block_size;
+	size_t process_len;
+	size_t fill;
+	u64 total_len;
+	int ret;
+
+	if ((!ibuf && ilen) || ctx->dev != dev)
+		return -EINVAL;
+	if (ctx->total_len > U64_MAX - ilen)
+		return -EOVERFLOW;
+	total_len = ctx->total_len + ilen;
+
+	if (ctx->tail_len) {
+		fill = block_size - ctx->tail_len;
+		if (ilen < fill) {
+			memcpy(ctx->tail + ctx->tail_len, src, ilen);
+			ctx->tail_len += ilen;
+			ctx->total_len = total_len;
+			return 0;
+		}
+
+		memcpy(ctx->tail + ctx->tail_len, src, fill);
+		ret = sunxi_hash_process_blocks(ctx, ctx->tail, block_size);
+		if (ret)
+			return ret;
+		ctx->tail_len = 0;
+		src += fill;
+		ilen -= fill;
+	}
+
+	process_len = ALIGN_DOWN(ilen, block_size);
+	if (process_len) {
+		ret = sunxi_hash_process_blocks(ctx, src, process_len);
+		if (ret)
+			return ret;
+		src += process_len;
+		ilen -= process_len;
+	}
+
+	if (ilen) {
+		memcpy(ctx->tail, src, ilen);
+		ctx->tail_len = ilen;
+	}
+	ctx->total_len = total_len;
+
+	return 0;
+}
+
+static int sunxi_hash_abort(struct udevice *dev, void *data)
+{
+	struct sunxi_hash_ctx *ctx = data;
+	int ret = ctx->dev == dev ? 0 : -EINVAL;
+
+	free(ctx);
+
+	return ret;
+}
+
+static int sunxi_hash_finish(struct udevice *dev, void *data, void *obuf)
+{
+	struct sunxi_hash_ctx *ctx = data;
+	struct sunxi_ce_priv *ce = dev_get_priv(dev_get_parent(dev));
+	struct sunxi_hash_job *job = &ctx->job;
+	size_t pad_len;
+	int ret;
+
+	if (!obuf || ctx->dev != dev) {
+		ret = -EINVAL;
+		goto out_free_ctx;
+	}
+
+	pad_len = sunxi_hash_pad(ctx->alg, job->pad, ctx->tail,
+				 ctx->tail_len, ctx->total_len);
+	ret = sunxi_hash_run_stream(ce, job, ctx->alg->method, NULL, 0,
+				    pad_len, ctx->alg->state_size,
+				    ctx->state_valid ? ctx->state : NULL);
+	if (!ret)
+		memcpy(obuf, job->result, ctx->alg->digest_size);
+
+out_free_ctx:
+	sunxi_hash_abort(dev, ctx);
+
+	return ret;
+}
+
+static int sunxi_hash_digest_wd(struct udevice *dev, enum HASH_ALGO algo,
+				const void *ibuf, const uint32_t ilen,
+				void *obuf, uint32_t chunk_sz)
+{
+	return sunxi_hash_digest(dev, algo, ibuf, ilen, obuf);
+}
+
+static const struct hash_ops sunxi_hash_ops = {
+	.hash_init = sunxi_hash_init,
+	.hash_update = sunxi_hash_update,
+	.hash_finish = sunxi_hash_finish,
+	.hash_abort = sunxi_hash_abort,
+	.hash_digest = sunxi_hash_digest,
+	.hash_digest_wd = sunxi_hash_digest_wd,
+};
+
+U_BOOT_DRIVER(sun8i_ce_hash) = {
+	.name = "sun8i-ce-hash",
+	.id = UCLASS_HASH,
+	.ops = &sunxi_hash_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
index d5b7edd357d..b7bb899c5f0 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
@@ -21,6 +21,11 @@
 #define SUNXI_CE_COMM_INT		BIT(31)
 #define SUNXI_CE_METHOD_AES		0
 #define SUNXI_CE_METHOD_RAES		0x30
+#define SUNXI_CE_METHOD_MD5		16
+#define SUNXI_CE_METHOD_SHA1		17
+#define SUNXI_CE_METHOD_SHA256		19
+#define SUNXI_CE_METHOD_SHA384		20
+#define SUNXI_CE_METHOD_SHA512		21
 #define SUNXI_CE_METHOD_ECC		33
 #define SUNXI_CE_ECC_OP_VERIFY		7
 #define SUNXI_CE_ECC_OP_SHIFT		16

-- 
2.53.0

