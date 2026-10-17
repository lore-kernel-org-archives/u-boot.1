Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C833CCF2C4
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 04:36:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D0915409E9;
	Sat, 17 Oct 2026 04:36:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qhwd1lYD_u9E; Sat, 17 Oct 2026 04:36:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 42CC5409ED
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792211797;
	b=d/xwv8kY5ZT2u0cSCOF3ku7khl3dKsS8SyrvKleZO7yH2A2xXKCmQ46D+3vMv33s18qp
	 7xtnZssVmBnUcoMbvIHtTdAKEr7qNSofa5tEExklqoY+SXvKvdtC1SLk2wDASW63JNczt
	 j4XI/hadMiEVDQOSyVDgzffI70w3gJjZhjMWwX6S1Z0SaSdXCzBDr7D6MPeQBBIfdpkbI
	 V2zcPKRuDpClQaUtD4R1zUAlW3DlQ3nwIldNeRPGSBKFpIveSRJFzlzL1crpy5emKri/A
	 mBNIEcxv3nLxk7TeH23LhZMbn455RK8Ff8ksO/LGIk/E+sn9tHSbSBBexm3QQHATo/g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792211797;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1xoNO+T8N0aFOCi5xygH+NT1Rr4UGGgjfNYdwmRqSYM=;
	b=EpD8U/5sKZ6Zu46c6W4naLBZ0pvOHZfTiB7FUru4SqTwpba53swjm4ZdZ0lDNSEe3hou
	 EtjrcYooYmP04cuf/ZYW8ORQkzv9JFl/yLZ5r0Zqn3vS97VAfG4N0o61DgIpP+HmJxdhE
	 b8Augokrx/R9lN7xKysD8LeLXJ336+PQ3pK0qCHwE6yRy71t8W3WqqpUDCBHBqFDl7Xzc
	 4p+29k/jObxUxZLNYdFKjXsa6L3xzDUYW1htX0Q36m5qCaqNo2WWisssRhslRmaD/b6q+
	 5Y0VJaIzpyxLapi5zi0fOM4hYtwnzgmI/rAFvsFgFiIfEHw0WTVZb3+MLArJsyLSX8A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792211797;
	bh=1xoNO+T8N0aFOCi5xygH+NT1Rr4UGGgjfNYdwmRqSYM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pINYLQSIb10O4/3ziCTdVBXRcp+C5wSPZ6Jl5LDv4itVn4SQ1TG3n1blJ0MJnipUB
	 uHo/NfzbWsd25Yy+BFsKUFS0gTfVX7vj9u+Hr6ml7hGapbXeZktvlAGMVpEpxKS9pu
	 U9PPWpG/Ci7UEBatGM6ujizX0dnMzsl2aLSbIXMjZbCIULDGyu+KINZsbNgxHNW8Kp
	 A+2umyUeGPo55AKz+TYe5PizekEvmNd0+E/ZcF4P0ACKMFoGYVO6do/XQSNrQcUUnL
	 4c9YW5sz9kzHcbtVplaqbiZPy70aDmU2QwHaWlwYnjf6mb63nWfO4dPWTLrBNMAeJf
	 a0HKeMg7Lht7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42CC5409ED;
	Sat, 17 Oct 2026 04:36:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C20B4362
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:35:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B29068165E
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:35:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KBppg5etnDJv for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 00:35:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3F2318156F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::35"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792197356;
 b=ROjRdiJsH97J0LY4sIHOT0yKGhPloyZEdyQKEebuCbLBG6aS0IILd3B9ob9Ytr0whj7w
 mqsaT+Y8OKtiK+CaeYDe6JETsvyP4Bym0cGJBVyl4gUMS/4mMydJ7DM8wvn8i68mC8afK
 KCQjpK/HLQQQqsuwgvHnGlwFX/tb2NQRRndHnbD9WWDBF9ogGCDKoSxRjMlkTIe2z7fx4
 1lAIoN5edlILPnn4FQQj+amufFDjcMAHr7eN9YvphVhQAblt3NaeL1/URcX05fX5nTFkV
 KCCwlKPdf9T+w4SU7VMly2xpE7WGHcReog4eqPD4iw0xA5F4MVhkQkN55wer/LwBmvQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792197356;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=1xoNO+T8N0aFOCi5xygH+NT1Rr4UGGgjfNYdwmRqSYM=;
 b=HHSWRrkMTFkImfKr9luEWSO3eZmLod2gn9m4B/6W0vmbCz5H0HvF5yoEU0q3FZl559Zd
 szicD26yHItA1FW0zXXQr6plLwHToOaBj1qrcszOsuxC3A7RtennNt+G3L1ZTLObo8+kJ
 TN1zO5A6DsZAXQCTzjYStTaFa5AKkfWNGy+pX/XZ+3FoYRMHS+WJecVgzMFolX8TKnwze
 fB/dEqoqWUflrgcw+YvTghrbiG1YgMaD6BBc8FwvVzhVvv9xr2ClwwADGGFVLat8HYfw5
 mXaazRPImA+lFociUoZ+LjmG5AOh2M1QdvrM4//Oovo00+btxHsUML4S4hoHs+h04jA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=icuAqXBa; 
 arc=none smtp.remote-ip="2001:4860:4864:20::35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::35; helo=mail-oa1-x35.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=icuAqXBa
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3F2318156F
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:35:55 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-49429181ce9so297580fac.0
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 17:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792197354; x=1792802154;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1xoNO+T8N0aFOCi5xygH+NT1Rr4UGGgjfNYdwmRqSYM=;
 b=icuAqXBar+kotOk2PAZZ69H6IISBrC+EBR16xHDAiTqdQcqcHVsNpCGeIkqOs6pwRm
 w01cILaP6MBwZelsXL09bd+LCdYdoB3U+qo3C/bZ0L2nX1TsfBJBcmAryaPDgKsC2D06
 t5B2o/csQ9Jf6EaRRJkdvYHgxvHN02ALmUiWrvFyUZemWSzrYI+/DxuGdiQLAZvkh+F9
 s7h3sNU9XnTKq/hvnWmOPuvQtYoIOQYjoPPqsg9g63vg38pIVPilme01D1G5sgjsFxxW
 MU2i8hu2t0h0DwZ+xAWbSRwN0KriphabDSIFaPADK2NdCPS56Jvqjqs1g5xaWgvqipG9
 z63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792197354; x=1792802154;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1xoNO+T8N0aFOCi5xygH+NT1Rr4UGGgjfNYdwmRqSYM=;
 b=tYhkXWlDkGoDlsUoMoFAkHq3zC7B7Cq2+hqrk59+lCqYjUSTcpPaLdAFO4UJER0Q8V
 Ipfz1O3krYNLe64zTM4xefOY8+fZ3r4oVuTPLIYTLX4vSGoVL0CRrKVQnygxrG5Wi6aV
 CrfozsHfZV1U1Bn4AUHobTEhV7ACHttvuvJqQDPTftNIABYAUa43RPoB7wIKNaz5Q6us
 pifYYm4nzA2kJZIdmvIw0658hCMCyO8UUTTo4cSh8htrNew6m1vvYwjkJ8HU4xGRdh44
 /cR1S5G4OEMLQj38reekMeHAWD6PMMDdMXlMRLYVvYNWgY5O13KDfDj6n8cTxung+cy2
 RNRg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwfG+wG8wuuTI70UudG6BLchkMi5V2eB/jXy/6jqgE0pTwQDW1z3B9hv1MqoVVyxdbDyCrwoIc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIT28FDOBN77SkWnGFeVsF60cUhvj3+uOR8XI+2Z1RHDd5kwxYB
 PFTmzAzur6MKUu4mdAFFFNwyniBu3OaU0KQlLnRkMbRjqgQAXVuyNLDH
X-Gm-Gg: AYBFou1B+Ux99GRja2Tjymr6v9qOLxbjN9Ya8WHeVzAL74oIEdn8Jau0fjlRffe0udk
 6dx0FFx/2whouY8j6rtHXeNTt4EQuKkXxoBL4b0+0YBT0eA8AePDLO9TlNzA7Kcel9JGe/hR6ZK
 /d5Lr2EnqjzaZk54IfV0hkn+VAfgaNoTkoPMhdE7H/XilQ+ZFMXvhSwMDjO/dKUE/FP+Po9aguU
 9Gy4NMREfjHLoWvrvQMTZdrCrrs0iUW5WNc+DgLqZTzrln5utDNO6xvGw77A/ZBoe9Vmr8HfU6t
 qAs7gt4MEkv2CFyFBbar5raQDIFli+o4CJ+vopIpR2GmnFzOaOcarbA8oZZcOzGV3lcwk7zL8Ol
 cMks7VYuBJx+I3OmgKbdh3Qgyu/rRnnoD1KhGYRZMaff1rfLOhk9+fCPgP1rL88y1yUbhDuT2PX
 uyv3jVKg1KQe59mZ69QUz+uKZxt17LpSi8cp6gGpWA9hZ2NJ22MqpqpqJHnb7xU/t73d6yXLeEB
 4ieVr5+ePoD6Tx+rIbov0xvjXTYHuDLNhrFjGuuC5lpw8qd2lFgAkcsp24aKh4u9lxX8ma3GKYy
 vaQ/7at7ZZHIIXR1NsedafV3ixCgBFbNycrsAGPyz7vGj49zPM+m017kQXJGs3aTFQcaSa9qFJ3
 j5ZELERd0LZuF4ZGve24/zg==
X-Received: by 2002:a05:6870:638e:b0:494:b4f2:3d8e with SMTP id
 586e51a60fabf-4a75796af7cmr1524338fac.27.1792197354389; 
 Fri, 16 Oct 2026 17:35:54 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a73b5b4291sm2745091fac.5.2026.10.16.17.35.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 17:35:53 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 16 Oct 2026 18:35:21 -0600
Subject: [PATCH v9 07/17] crypto: hash: support hardware-only progressive
 hashing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-submit-ce-series-v2-v9-7-c24e64daafe9@gmail.com>
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

FIT configuration signatures hash multiple discontiguous regions through
the legacy progressive hash interface. This still requires a software
implementation even when image hashes use a driver-model hardware
provider.

Add provider selection for progressive driver-model hashing and use it
from hash_calculate(). Allow SPL_SHA256_LEGACY to be disabled explicitly,
link the SHA-256 software support only for a selected software backend,
and make legacy fallback paths reject an algorithm whose software
callbacks are absent.

Require the complete init, update, finish and abort lifecycle for
progressive provider selection. Add an abort operation to the software
provider and register Caliptra's existing cleanup helper with the new
interface. Use these operations to release a context after an update
failure. Finish and abort must stop hardware access before returning.

Keep HACE on its existing one-shot path: it cannot currently guarantee
stopped DMA after a timeout, so freeing its context is not a safe abort.
Providers without abort support are skipped before initialization,
leaving the legacy progressive fallback available.

Enable DM_HASH in the sandbox configuration so these driver-model
paths are built and exercised by the standard sandbox tests. Extend
the hash provider-selection test to cover progressive initialization
and error cleanup.

This permits SPL to retain SHA-256 FIT support while relying exclusively
on a hardware hash provider.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v8 -> v9:
  - Leave HACE on its existing one-shot path until it can guarantee a
    DMA-safe abort, rather than freeing a potentially active context
  - Make the hardware ownership requirement explicit and cover skipping a
    provider without abort support while retaining its one-shot operations
  - Move Caliptra's streaming-input and cleanup fixes to a preparatory
    patch; retain its abort callback registration with the new hash API

Changes v7 -> v8:
  - Add an explicit abort operation and release provider contexts after
    update failures  (suggested by Simon Glass)
  - Add the progressive provider-selection and error-cleanup test omitted
    from v7
  - Enable DM_HASH in sandbox so the hash provider tests are built and run
    by normal sandbox CI

Changes v6 -> v7:
  - New patch
---
 boot/image-fit.c                  |   2 +-
 common/hash.c                     |  21 ++++-
 configs/sandbox_defconfig         |   1 +
 drivers/crypto/aspeed/cptra_sha.c |   1 +
 drivers/crypto/hash/hash-uclass.c |  44 ++++++++-
 drivers/crypto/hash/hash_sw.c     |  20 +++--
 include/u-boot/hash.h             |  32 +++++++
 lib/Makefile                      |   4 +-
 lib/hash-checksum.c               |  30 ++++++-
 lib/mbedtls/Kconfig               |   2 +-
 test/dm/hash.c                    | 184 ++++++++++++++++++++++++++++++++++++++
 11 files changed, 328 insertions(+), 13 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index dacd8a61f31..30da18f571f 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -1349,7 +1349,7 @@ int calculate_hash(const void *data, int data_len, const char *name,
 #endif
 
 	ret = hash_lookup_algo(name, &algo);
-	if (ret < 0) {
+	if (ret < 0 || !algo->hash_func_ws) {
 		debug("Unsupported hash algorithm\n");
 		return -1;
 	}
diff --git a/common/hash.c b/common/hash.c
index 5cbb4926c1d..8bbf9aa4825 100644
--- a/common/hash.c
+++ b/common/hash.c
@@ -38,6 +38,14 @@
 #include <u-boot/md5.h>
 #include <u-boot/sm3.h>
 
+#ifdef USE_HOSTCC
+#define SHA256_SOFTWARE_ENABLED 1
+#else
+#define SHA256_SOFTWARE_ENABLED \
+	(CONFIG_IS_ENABLED(SHA256_LEGACY) || \
+	 CONFIG_IS_ENABLED(SHA256_MBEDTLS))
+#endif
+
 static int __maybe_unused hash_init_sha1(struct hash_algo *algo, void **ctxp)
 {
 	sha1_context *ctx = malloc(sizeof(sha1_context));
@@ -65,6 +73,7 @@ static int __maybe_unused hash_finish_sha1(struct hash_algo *algo, void *ctx,
 	return 0;
 }
 
+#if SHA256_SOFTWARE_ENABLED
 static int __maybe_unused hash_init_sha256(struct hash_algo *algo, void **ctxp)
 {
 	sha256_context *ctx = malloc(sizeof(sha256_context));
@@ -91,6 +100,7 @@ static int __maybe_unused hash_finish_sha256(struct hash_algo *algo, void *ctx,
 	free(ctx);
 	return 0;
 }
+#endif
 
 static int __maybe_unused hash_init_sha384(struct hash_algo *algo, void **ctxp)
 {
@@ -273,14 +283,14 @@ static struct hash_algo hash_algo[] = {
 		.chunk_size	= CHUNKSZ_SHA256,
 #if CONFIG_IS_ENABLED(SHA_HW_ACCEL)
 		.hash_func_ws	= hw_sha256,
-#else
+#elif SHA256_SOFTWARE_ENABLED
 		.hash_func_ws	= sha256_csum_wd,
 #endif
 #if CONFIG_IS_ENABLED(SHA_PROG_HW_ACCEL)
 		.hash_init	= hw_sha_init,
 		.hash_update	= hw_sha_update,
 		.hash_finish	= hw_sha_finish,
-#else
+#elif SHA256_SOFTWARE_ENABLED
 		.hash_init	= hash_init_sha256,
 		.hash_update	= hash_update_sha256,
 		.hash_finish	= hash_finish_sha256,
@@ -634,6 +644,13 @@ int hash_command(const char *algo_name, int flags, struct cmd_tbl *cmdtp,
 					goto done;
 			}
 		}
+		if (!algo->hash_func_ws) {
+			printf("Hash algorithm '%s' has no available provider\n",
+			       algo_name);
+			unmap_sysmem(buf);
+			free(output);
+			return CMD_RET_FAILURE;
+		}
 		algo->hash_func_ws(buf, len, output, algo->chunk_size);
 done:
 		unmap_sysmem(buf);
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 424df09646a..98c45f70be4 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -201,6 +201,7 @@ CONFIG_CLK_K210_SET_RATE=y
 CONFIG_SANDBOX_CLK_CCF=y
 CONFIG_CLK_SCMI=y
 CONFIG_CPU=y
+CONFIG_DM_HASH=y
 CONFIG_DM_AES=y
 CONFIG_AES_SOFTWARE=y
 CONFIG_DM_DEMO=y
diff --git a/drivers/crypto/aspeed/cptra_sha.c b/drivers/crypto/aspeed/cptra_sha.c
index 62d6955493f..644fd8b2c9f 100644
--- a/drivers/crypto/aspeed/cptra_sha.c
+++ b/drivers/crypto/aspeed/cptra_sha.c
@@ -261,6 +261,7 @@ static const struct hash_ops cptra_sha_ops = {
 	.hash_init = cptra_sha_init,
 	.hash_update = cptra_sha_update,
 	.hash_finish = cptra_sha_finish,
+	.hash_abort = cptra_sha_abort,
 	.hash_digest_wd = cptra_sha_digest_wd,
 	.hash_digest = cptra_sha_digest,
 };
diff --git a/drivers/crypto/hash/hash-uclass.c b/drivers/crypto/hash/hash-uclass.c
index ffca19af2de..0340eecf3f6 100644
--- a/drivers/crypto/hash/hash-uclass.c
+++ b/drivers/crypto/hash/hash-uclass.c
@@ -119,11 +119,43 @@ int hash_digest_wd_lookup(enum HASH_ALGO algo, const void *ibuf,
 	return found ? -EOPNOTSUPP : -ENODEV;
 }
 
+int hash_init_lookup(enum HASH_ALGO algo, struct udevice **devp, void **ctxp)
+{
+	struct udevice *dev;
+	int first_probe_err = 0;
+	bool found = false;
+	int ret;
+
+	for (ret = uclass_first_device_check(UCLASS_HASH, &dev); dev;
+	     ret = uclass_next_device_check(&dev)) {
+		found = true;
+		if (ret) {
+			if (!first_probe_err)
+				first_probe_err = ret;
+			continue;
+		}
+
+		ret = hash_init(dev, algo, ctxp);
+		if (!ret) {
+			*devp = dev;
+			return 0;
+		}
+		if (!hash_op_unsupported(ret))
+			return ret;
+	}
+
+	if (first_probe_err)
+		return first_probe_err;
+
+	return found ? -EOPNOTSUPP : -ENODEV;
+}
+
 int hash_init(struct udevice *dev, enum HASH_ALGO algo, void **ctxp)
 {
 	struct hash_ops *ops = (struct hash_ops *)device_get_ops(dev);
 
-	if (!ops->hash_init)
+	if (!ops->hash_init || !ops->hash_update || !ops->hash_finish ||
+	    !ops->hash_abort)
 		return -ENOSYS;
 
 	return ops->hash_init(dev, algo, ctxp);
@@ -149,6 +181,16 @@ int hash_finish(struct udevice *dev, void *ctx, void *obuf)
 	return ops->hash_finish(dev, ctx, obuf);
 }
 
+int hash_abort(struct udevice *dev, void *ctx)
+{
+	struct hash_ops *ops = (struct hash_ops *)device_get_ops(dev);
+
+	if (!ops->hash_abort)
+		return -ENOSYS;
+
+	return ops->hash_abort(dev, ctx);
+}
+
 UCLASS_DRIVER(hash) = {
 	.id	= UCLASS_HASH,
 	.name	= "hash",
diff --git a/drivers/crypto/hash/hash_sw.c b/drivers/crypto/hash/hash_sw.c
index 4590e225481..63a775d904f 100644
--- a/drivers/crypto/hash/hash_sw.c
+++ b/drivers/crypto/hash/hash_sw.c
@@ -218,6 +218,13 @@ static int sw_hash_update(struct udevice *dev, void *ctx, const void *ibuf, uint
 	return 0;
 }
 
+static int sw_hash_abort(struct udevice *dev, void *ctx)
+{
+	free(ctx);
+
+	return 0;
+}
+
 static int sw_hash_finish(struct udevice *dev, void *ctx, void *obuf)
 {
 	struct sw_hash_ctx *hash_ctx = ctx;
@@ -225,9 +232,7 @@ static int sw_hash_finish(struct udevice *dev, void *ctx, void *obuf)
 
 	hash_impl->finish(hash_ctx->algo_ctx, obuf);
 
-	free(ctx);
-
-	return 0;
+	return sw_hash_abort(dev, ctx);
 }
 
 static int sw_hash_digest_wd(struct udevice *dev, enum HASH_ALGO algo,
@@ -253,16 +258,20 @@ static int sw_hash_digest_wd(struct udevice *dev, enum HASH_ALGO algo,
 				chunk = chunk_sz;
 
 			rc = sw_hash_update(dev, ctx, cur, chunk);
-			if (rc)
+			if (rc) {
+				sw_hash_abort(dev, ctx);
 				return rc;
+			}
 
 			cur += chunk;
 			schedule();
 		}
 	} else {
 		rc = sw_hash_update(dev, ctx, ibuf, ilen);
-		if (rc)
+		if (rc) {
+			sw_hash_abort(dev, ctx);
 			return rc;
+		}
 	}
 
 	rc = sw_hash_finish(dev, ctx, obuf);
@@ -284,6 +293,7 @@ static const struct hash_ops hash_ops_sw = {
 	.hash_init = sw_hash_init,
 	.hash_update = sw_hash_update,
 	.hash_finish = sw_hash_finish,
+	.hash_abort = sw_hash_abort,
 	.hash_digest_wd = sw_hash_digest_wd,
 	.hash_digest = sw_hash_digest,
 };
diff --git a/include/u-boot/hash.h b/include/u-boot/hash.h
index 7dba66047f5..456a73b6c4e 100644
--- a/include/u-boot/hash.h
+++ b/include/u-boot/hash.h
@@ -51,10 +51,41 @@ int hash_digest_wd(struct udevice *dev, enum HASH_ALGO algo,
  */
 int hash_digest_wd_lookup(enum HASH_ALGO algo, const void *ibuf,
 			  const u32 ilen, void *obuf, u32 chunk_sz);
+/**
+ * hash_init_lookup() - Start hashing with the first supporting provider
+ *
+ * Probe each hash device in order and initialize the first one which supports
+ * @algo. The selected device is returned for the matching update and finish
+ * operations.
+ *
+ * @algo: Hash algorithm
+ * @devp: Returns the selected hash device
+ * @ctxp: Returns the provider's progressive-hash context
+ * Return: 0 on success, -ENODEV if there are no providers, -EOPNOTSUPP if no
+ * provider supports @algo, or another negative error from a provider
+ */
+int hash_init_lookup(enum HASH_ALGO algo, struct udevice **devp, void **ctxp);
+
+/*
+ * A successful hash_init() returns a context which must be consumed by
+ * exactly one hash_finish() or hash_abort() call. Both operations release all
+ * provider resources, including when they return an error. Before returning,
+ * they must ensure that hardware can no longer access the context or buffers.
+ * Providers without a safe abort operation are skipped by hash_init_lookup().
+ */
 int hash_init(struct udevice *dev, enum HASH_ALGO algo, void **ctxp);
 int hash_update(struct udevice *dev, void *ctx, const void *ibuf, const uint32_t ilen);
 int hash_finish(struct udevice *dev, void *ctx, void *obuf);
 
+/**
+ * hash_abort() - Discard a progressive hash operation
+ *
+ * @dev: Hash device selected by hash_init() or hash_init_lookup()
+ * @ctx: Progressive-hash context to release
+ * Return: 0 on success, or a negative provider error
+ */
+int hash_abort(struct udevice *dev, void *ctx);
+
 /*
  * struct hash_ops - Driver model for Hash operations
  *
@@ -66,6 +97,7 @@ struct hash_ops {
 	int (*hash_init)(struct udevice *dev, enum HASH_ALGO algo, void **ctxp);
 	int (*hash_update)(struct udevice *dev, void *ctx, const void *ibuf, const uint32_t ilen);
 	int (*hash_finish)(struct udevice *dev, void *ctx, void *obuf);
+	int (*hash_abort)(struct udevice *dev, void *ctx);
 
 	/* all-in-one operation */
 	int (*hash_digest)(struct udevice *dev, enum HASH_ALGO algo,
diff --git a/lib/Makefile b/lib/Makefile
index 30092dd4a04..f36a311f9e8 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -79,8 +79,8 @@ obj-$(CONFIG_BLAKE2) += blake2/blake2b.o
 
 obj-$(CONFIG_$(PHASE_)MD5_LEGACY) += md5.o
 obj-$(CONFIG_$(PHASE_)SHA1_LEGACY) += sha1.o
-obj-$(CONFIG_$(PHASE_)SHA256) += sha256_common.o
-obj-$(CONFIG_$(PHASE_)SHA256_LEGACY) += sha256.o
+obj-$(CONFIG_$(PHASE_)SHA256_LEGACY) += sha256_common.o sha256.o
+obj-$(CONFIG_$(PHASE_)SHA256_MBEDTLS) += sha256_common.o
 obj-$(CONFIG_$(PHASE_)SHA512_LEGACY) += sha512.o
 obj-$(CONFIG_$(PHASE_)SM3) += sm3.o
 
diff --git a/lib/hash-checksum.c b/lib/hash-checksum.c
index 1970a741294..e3e7f6adb7f 100644
--- a/lib/hash-checksum.c
+++ b/lib/hash-checksum.c
@@ -4,11 +4,13 @@
  */
 
 #ifndef USE_HOSTCC
+#include <dm.h>
 #include <fdtdec.h>
 #include <asm/byteorder.h>
 #include <linux/errno.h>
 #include <asm/unaligned.h>
 #include <hash.h>
+#include <u-boot/hash.h>
 #else
 #include "fdt_host.h"
 #endif
@@ -20,13 +22,39 @@ int hash_calculate(const char *name,
 		    int region_count, uint8_t *checksum)
 {
 	struct hash_algo *algo;
-	int ret = 0;
+	int ret;
 	void *ctx;
 	int i;
 
 	if (region_count < 1)
 		return -EINVAL;
 
+#ifndef USE_HOSTCC
+	if (CONFIG_IS_ENABLED(DM_HASH)) {
+		enum HASH_ALGO hash_algo = hash_algo_lookup_by_name(name);
+		struct udevice *dev;
+
+		if (hash_algo != HASH_ALGO_INVALID)
+			ret = hash_init_lookup(hash_algo, &dev, &ctx);
+		else
+			ret = -EOPNOTSUPP;
+		if (!ret) {
+			for (i = 0; i < region_count; i++) {
+				ret = hash_update(dev, ctx, region[i].data,
+						  region[i].size);
+				if (ret) {
+					hash_abort(dev, ctx);
+					return ret;
+				}
+			}
+
+			return hash_finish(dev, ctx, checksum);
+		}
+		if (ret != -ENODEV && ret != -EOPNOTSUPP)
+			return ret;
+	}
+#endif
+
 	ret = hash_progressive_lookup_algo(name, &algo);
 	if (ret)
 		return ret;
diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
index 66bc16db451..7ea0800554a 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -359,7 +359,7 @@ config SPL_LEGACY_HASHING
 	bool "Use U-Boot legacy hashing libraries (SPL)"
 	select SPL_MD5_LEGACY if SPL_MD5
 	select SPL_SHA1_LEGACY if SPL_SHA1
-	select SPL_SHA256_LEGACY if SPL_SHA256
+	imply SPL_SHA256_LEGACY if SPL_SHA256
 	select SPL_SHA512_LEGACY if SPL_SHA512
 	select SPL_SHA384_LEGACY if SPL_SHA384
 	help
diff --git a/test/dm/hash.c b/test/dm/hash.c
index 6adf916dc77..19a01f5374c 100644
--- a/test/dm/hash.c
+++ b/test/dm/hash.c
@@ -10,13 +10,83 @@
 #include <dm/root.h>
 #include <dm/test.h>
 #include <dm/uclass-internal.h>
+#include <image.h>
 #include <u-boot/hash.h>
+#include <u-boot/hash-checksum.h>
 #include <test/test.h>
 #include <test/ut.h>
 
 static int unsupported_calls;
 static int success_calls;
 static int hard_error_calls;
+static int unsupported_init_calls;
+static int success_init_calls;
+static int hard_error_init_calls;
+static int update_error_calls;
+static int finish_calls;
+static int abort_calls;
+
+static int hash_test_unsupported_init(struct udevice *dev,
+				      enum HASH_ALGO algo, void **ctxp)
+{
+	unsupported_init_calls++;
+
+	return -EOPNOTSUPP;
+}
+
+static int hash_test_success_init(struct udevice *dev, enum HASH_ALGO algo,
+				  void **ctxp)
+{
+	success_init_calls++;
+	*ctxp = dev;
+
+	return 0;
+}
+
+static int hash_test_hard_error_init(struct udevice *dev,
+				     enum HASH_ALGO algo, void **ctxp)
+{
+	hard_error_init_calls++;
+
+	return -EINVAL;
+}
+
+static int hash_test_update_error_init(struct udevice *dev,
+				       enum HASH_ALGO algo, void **ctxp)
+{
+	*ctxp = dev;
+
+	return 0;
+}
+
+static int hash_test_progressive_update(struct udevice *dev, void *ctx,
+					const void *ibuf, u32 ilen)
+{
+	return 0;
+}
+
+static int hash_test_update_error(struct udevice *dev, void *ctx,
+				  const void *ibuf, u32 ilen)
+{
+	update_error_calls++;
+
+	return -EIO;
+}
+
+static int hash_test_progressive_finish(struct udevice *dev, void *ctx,
+					void *obuf)
+{
+	finish_calls++;
+
+	return 0;
+}
+
+static int hash_test_progressive_abort(struct udevice *dev, void *ctx)
+{
+	abort_calls++;
+
+	return 0;
+}
 
 static int hash_test_unsupported(struct udevice *dev, enum HASH_ALGO algo,
 				 const void *ibuf, const uint32_t ilen,
@@ -53,17 +123,43 @@ static int hash_test_hard_error(struct udevice *dev, enum HASH_ALGO algo,
 }
 
 static const struct hash_ops hash_test_unsupported_ops = {
+	.hash_init = hash_test_unsupported_init,
+	.hash_update = hash_test_progressive_update,
+	.hash_finish = hash_test_progressive_finish,
+	.hash_abort = hash_test_progressive_abort,
 	.hash_digest_wd = hash_test_unsupported,
 };
 
 static const struct hash_ops hash_test_success_ops = {
+	.hash_init = hash_test_success_init,
+	.hash_update = hash_test_progressive_update,
+	.hash_finish = hash_test_progressive_finish,
+	.hash_abort = hash_test_progressive_abort,
 	.hash_digest_wd = hash_test_success,
 };
 
 static const struct hash_ops hash_test_hard_error_ops = {
+	.hash_init = hash_test_hard_error_init,
+	.hash_update = hash_test_progressive_update,
+	.hash_finish = hash_test_progressive_finish,
+	.hash_abort = hash_test_progressive_abort,
 	.hash_digest_wd = hash_test_hard_error,
 };
 
+static const struct hash_ops hash_test_update_error_ops = {
+	.hash_init = hash_test_update_error_init,
+	.hash_update = hash_test_update_error,
+	.hash_finish = hash_test_progressive_finish,
+	.hash_abort = hash_test_progressive_abort,
+};
+
+static const struct hash_ops hash_test_no_abort_ops = {
+	.hash_init = hash_test_success_init,
+	.hash_update = hash_test_progressive_update,
+	.hash_finish = hash_test_progressive_finish,
+	.hash_digest_wd = hash_test_success,
+};
+
 U_BOOT_DRIVER(hash_test_unsupported_drv) = {
 	.name = "hash_test_unsupported",
 	.id = UCLASS_HASH,
@@ -82,6 +178,18 @@ U_BOOT_DRIVER(hash_test_hard_error_drv) = {
 	.ops = &hash_test_hard_error_ops,
 };
 
+U_BOOT_DRIVER(hash_test_update_error_drv) = {
+	.name = "hash_test_update_error",
+	.id = UCLASS_HASH,
+	.ops = &hash_test_update_error_ops,
+};
+
+U_BOOT_DRIVER(hash_test_no_abort_drv) = {
+	.name = "hash_test_no_abort",
+	.id = UCLASS_HASH,
+	.ops = &hash_test_no_abort_ops,
+};
+
 static int hash_test_unbind_all(void)
 {
 	struct udevice *dev;
@@ -111,7 +219,13 @@ static int hash_test_bind(const struct driver *drv, const char *name)
 
 static int dm_test_hash_provider_selection(struct unit_test_state *uts)
 {
+	const struct image_region region = {
+		.data = "test",
+		.size = 4,
+	};
+	struct udevice *dev;
 	u8 digest[32];
+	void *ctx;
 	int ret;
 
 	ut_assertok(hash_test_unbind_all());
@@ -138,6 +252,18 @@ static int dm_test_hash_provider_selection(struct unit_test_state *uts)
 	for (int i = 0; i < sizeof(digest); i++)
 		ut_asserteq(0, digest[i]);
 
+	unsupported_init_calls = 0;
+	success_init_calls = 0;
+	ret = hash_init_lookup(HASH_ALGO_SHA256, &dev, &ctx);
+	ut_assertok(ret);
+	ut_asserteq(1, unsupported_init_calls);
+	ut_asserteq(1, success_init_calls);
+	ut_asserteq_str("hash-success", dev->name);
+	ut_asserteq_ptr(dev, ctx);
+	abort_calls = 0;
+	ut_assertok(hash_abort(dev, ctx));
+	ut_asserteq(1, abort_calls);
+
 	ut_assertok(hash_test_unbind_all());
 	ut_assertok(hash_test_bind(DM_DRIVER_GET(hash_test_hard_error_drv),
 				   "hash-hard-error"));
@@ -151,7 +277,65 @@ static int dm_test_hash_provider_selection(struct unit_test_state *uts)
 	ut_asserteq(1, hard_error_calls);
 	ut_asserteq(0, success_calls);
 
+	hard_error_init_calls = 0;
+	success_init_calls = 0;
+	ret = hash_init_lookup(HASH_ALGO_SHA256, &dev, &ctx);
+	ut_asserteq(-EINVAL, ret);
+	ut_asserteq(1, hard_error_init_calls);
+	ut_asserteq(0, success_init_calls);
+
+	ut_assertok(hash_test_unbind_all());
+	ut_assertok(hash_test_bind(DM_DRIVER_GET(hash_test_update_error_drv),
+				   "hash-update-error"));
+	update_error_calls = 0;
+	finish_calls = 0;
+	abort_calls = 0;
+	ret = hash_calculate("sha256", &region, 1, digest);
+	ut_asserteq(-EIO, ret);
+	ut_asserteq(1, update_error_calls);
+	ut_asserteq(0, finish_calls);
+	ut_asserteq(1, abort_calls);
+
 	return 0;
 }
 
 DM_TEST(dm_test_hash_provider_selection, UTF_SCAN_FDT);
+
+/* A provider needs safe abort support only for progressive operations. */
+static int dm_test_hash_no_abort(struct unit_test_state *uts)
+{
+	struct udevice *dev;
+	u8 digest[32];
+	void *ctx = NULL;
+
+	ut_assertok(hash_test_unbind_all());
+	ut_assertok(hash_test_bind(DM_DRIVER_GET(hash_test_no_abort_drv),
+				   "hash-no-abort"));
+
+	success_init_calls = 0;
+	ut_asserteq(-EOPNOTSUPP,
+		    hash_init_lookup(HASH_ALGO_SHA256, &dev, &ctx));
+	ut_asserteq(0, success_init_calls);
+	ut_assertnull(ctx);
+
+	success_calls = 0;
+	ut_assertok(hash_digest_wd_lookup(HASH_ALGO_SHA256, "test", 4,
+					  digest, 4));
+	ut_asserteq(1, success_calls);
+	for (int i = 0; i < sizeof(digest); i++)
+		ut_asserteq(0x5a, digest[i]);
+
+	ut_assertok(hash_test_bind(DM_DRIVER_GET(hash_test_success_drv),
+				   "hash-success"));
+	ut_assertok(hash_init_lookup(HASH_ALGO_SHA256, &dev, &ctx));
+	ut_asserteq(1, success_init_calls);
+	ut_asserteq_str("hash-success", dev->name);
+	ut_asserteq_ptr(dev, ctx);
+	abort_calls = 0;
+	ut_assertok(hash_abort(dev, ctx));
+	ut_asserteq(1, abort_calls);
+
+	return 0;
+}
+
+DM_TEST(dm_test_hash_no_abort, UTF_SCAN_FDT);

-- 
2.53.0

