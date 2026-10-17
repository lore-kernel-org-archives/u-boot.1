Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451E7CCF2C4
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 04:36:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E45B3409E6;
	Sat, 17 Oct 2026 04:36:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7A7emsBVZ4xm; Sat, 17 Oct 2026 04:36:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 31240409E9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792211792;
	b=JSzgt0NbIuMsBGsi31PxkD/eWKj8sJjzr5bbYQzCyjjYqYcaZPI5ENLGXxiQRLXtFALP
	 2dwPTQqHQ3qGMw3RIOIS7jpp0b9EMGVtmunsaYWYqi3ywEx6h0ktSBaOdk6hsf8LsnXNm
	 sUcB9eKJxGcOBXlrMHb/qeiJlG67mR/Vk2V4EIVi0iPdSyo3Dq7ggzvnkQrIOXw3yOtCx
	 lkvVjB14UGHcHdLYe7oVx2YM/3JoJ7045vL84z0MGurPN/bhAQvnjAWKQcth8mnCAyGb/
	 LK7XcLE6JMRBDrTMnU5j+j6itJDJR6kwBZkf70q3FNmCmCHKnTe6rnlcsJkGUBpVNvw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792211792;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9ibA6Ff8qHV/EFWc65mA69Z5Q8FnHmycKINMaVBinz8=;
	b=rFv6jjsVetR27RUfAQ2vT6cC/2ylwhjAdOi0zaumlIRfhjtZBr3HOSwr7FcN5oaASwr2
	 L0LWFITHki8FXWTGtv9iu2L3+rHsVh3lbbrXSdogDVxp5ed9R5u30Y6+ufJCAkIZQQfRa
	 FRZbS3bsf5yZipvh4L/HReCFgQZcL/PnjawXJlnYeIxPy4BNNbtYo4rQQb+45BmLcjzpT
	 VBNFopS3/JFjxQk60P4tR6pP+j9i2LApDMgwjNBcIffMh0z5v7keiWArrrzDNomzigG9k
	 ctHFcEdUsmxJK8ar27oaABU8Bfuyp24tjjfo27+FPMLKvk6ebc1JZ/menM1+yhHy1Bg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792211792;
	bh=9ibA6Ff8qHV/EFWc65mA69Z5Q8FnHmycKINMaVBinz8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oo6P503m3HhgXA33hcu6OANNEmj6p7BVVlhgwwVjSBPMjFE1D1XLqQddEjISdyFy/
	 iN4ZqD08j4Ale5Xlw9wkIhuWF0hUj08wkdP44cD59sMDIMqT/Hk0Xc+JaC8qKjo3SI
	 LvLRI4MYVnmFbJT0jxyfsp5bnMKEvteM6OHrPh3CS8F+kmYnfiE/b7KQ5RGmsI5l3+
	 zeaXncEqAn4S/QFGd2nyePQA86PexgqDRhGbu4QoNpPRyLaDLHmViHOTm3yqjiFF0b
	 9AiLrrLleQSPFmY3fAXCXRPwC7nqn+c8cGV8RTcoT0v01miD4TDoDnsISTn5NoL5k1
	 FV7AxaeHDb/Xg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 31240409E9;
	Sat, 17 Oct 2026 04:36:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5B69E79D
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:35:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4182A60AEC
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:35:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K6H6SXX7V_6e for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 00:35:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7BBFA60A7E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792197345;
 b=LTHfyWKxGWVsOGzgTHRVbOm/k/shaHx2W7pcCxuk69uBUonMhE++SlWptax91ujKgI9t
 Z1fcj6HaXAcS6r04EKfUlnUWq6aIHtXFXFDXh/pVJv3w/hYGhs7PV2v09bRsud+s22/s5
 14DNY8YRd1u410pzmEcRH7NgZprk2WZMELYLqVjm9mf36tFZ6WhvtJtlO3ZnTjBGlnPg9
 b4LpHxjE3TeW1jV1A5ng2O0BNKfwQf1vmpk4jN5Y55r/C60YlB1tPk5yLJkug3uylhYjf
 sgchowDY5sbASVtOtypOXhMPYoyMopganUjhmf0Giezwf790bzSgm7w/2Zf5Q48xenw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792197345;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=9ibA6Ff8qHV/EFWc65mA69Z5Q8FnHmycKINMaVBinz8=;
 b=bXyEjqd+V9Xn2yrjSoXh/kmx3LHGBerq/ydv7RP2oCfi3A0kv1us73ql3PpOyuGR6AiX
 PkeDutDG0saSydVEn+J2W9UjNgCbi4LGbtmQMspanTF+5gZEnaWhjZCmojcsx9dGiqRtY
 pFiZunl5iIbGW8TsGa8B//fZW3tbidLiUzJ8kdVK8aMFZ/HKTJLO55xGnMyQHS0ALZm7X
 5w7v3lPYWovhKAsokSpBxQEmOjUfXcLjAYnKgHByHEE9cpD8IeFiJg7uWaf70HboZ2vxw
 hllWiMwXdxPLQyPIZdxzkGoofhHDq0kUmvf8KnPJUFF/m3U5e6TqbywWpylrYyHniGA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=D8H6bdvj; 
 arc=none smtp.remote-ip="2001:4860:4864:20::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2a; helo=mail-oa1-x2a.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=D8H6bdvj
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7BBFA60A7E
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:35:45 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-486f013db83so202253fac.0
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 17:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792197344; x=1792802144;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9ibA6Ff8qHV/EFWc65mA69Z5Q8FnHmycKINMaVBinz8=;
 b=D8H6bdvj9aJHe0ETKH/f+yJbbl+CMvS9nCYdhQmDr26USPuurSkBS6CWpdRHJ0vgAl
 4kppN/zd9qWCBEo+QY9+pHsSADh/qkaQzrg59XRlR+k/+SLOrPwzqycE21Wc8W6vIvqx
 JlnPiHwyVGjudvi0m5eoz0DlfMXd7O1vtiEAC/NTZoMmKvdSNrBCcKQVC5uUhn44Rwzn
 NCi4WO81yHbMKrBKdPvbt7SBOTqOYRjR07gruQFxpTkY13/vNdqct7DJItNwSpi0ANIs
 YgQNYFN0orhNwQlc8PWdrlmxffrQeBDNbMWk9m76zlLe/+toQTCzSmO6zTrc3hf49Edk
 2BsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792197344; x=1792802144;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9ibA6Ff8qHV/EFWc65mA69Z5Q8FnHmycKINMaVBinz8=;
 b=vdMdEoTg+Iy9SFfCNtFuttE9/asCi+ykMK95owkgvL+irciWnsHdYk7cAyFO6avU+k
 6vYQTcIrMJe73lo7YejNgSbtO9vnKyDO1VgEtA3vZorvctneKdUr3xyXmpfyzATKhE0o
 CIwmabqAAlDgmASSbTb/5yPdxWDy275Dp0IJaZ9rdnXiN8XuoL03C/XYFtTAzRZlVjiN
 Q6AQs53dSMyqQKeI1J0zUFsXKKubZJu3nuHsTvN7CaggOzv3x7//aWptAW65y8Db4MLJ
 iuyqzpvQDUgLnfBRMmhJXBqCddw/cT20sGsTZcnZ4p4s+kqa36tyR9Yw+6IwKtmS+8VI
 7vrQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxRTscvG84fXCyspp9E4TfEmA1hZA2x9l1IQy9aGCRfS3NuzaUaMGiBsX02maPe5YJkneZtEZ4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIySeIJs2/7dKRBvmab+H+hm+OQYhV7jnSE97yw9zD8wmUrFLNM
 w0uFqPd4fAR6KeSM7YqwsYi8AR24hoZ1NVzppo2SPcUDzbtjQKbXvXSu
X-Gm-Gg: AYBFou11CrOD0bXfyUzhJuDRAvqh9P/Y8R2i1ROw9y4hGpWV0Jp32fp/GgKQ5sqL3tj
 HGD+WpOIfti4jMuTy93X4TxxAbb+GU/Esl3EUeLZ4vHE8+BubaEnKs/5mPXTpex0eGwXmn3O0P4
 Ay2/ubg5ag9h+8nvoIKb5iyUaaPeb3gczjHUgqFJHBMnLxcNJxGFIAmjBz+tMSXoduYSlniYXDT
 2mCoZajQMTlpq9ne2zudLAvLOKiwSAf/xFgoQWoqy317EGnzRaRB4Y5257rI2e3qyS4Oiqr0RSq
 jEGz4iQnFLQM0YW9eNBJoKG983EB3g0WbuwkMLj3zf5gMw9cHAq6F/DTQKtlaTr6rdr+sUFo5MD
 uiuB+P0pfjjvwVxkz8ff++AR0oxDD1xsEd8S+4JYPlF3m1FxGYZACS3ctnydGU+sh/mRLDPke1+
 CcOfc6t73lRqDCS0Fn8YlEK9oNrWzprER1XAJhQrWZaI2WDoSRNUeri4YDMG/quTYMF9maJd2Qo
 iyyzPy8m4QvAYkvNWN8HxXyXfYWImSlQ0r8j3uhhBOaOMxW9U6aJNfO5ZZIYytdwZSOy6F18H9x
 GXqw3RfgeDjKKJDHWxfciUKdDoB9SNWaRi02xq7DfkNUV5GD18+qcak2Y6WLwg/ebsGDX9wd3HZ
 XKmjlz46H3UKrzvjRCuDaHY0=
X-Received: by 2002:a05:6870:d621:b0:49e:6fbc:cd5b with SMTP id
 586e51a60fabf-4a757b7db46mr1436603fac.55.1792197343927; 
 Fri, 16 Oct 2026 17:35:43 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a73b5b4291sm2745091fac.5.2026.10.16.17.35.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 17:35:43 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 16 Oct 2026 18:35:18 -0600
Subject: [PATCH v9 04/17] boot: image: try all DM hash providers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-submit-ce-series-v2-v9-4-c24e64daafe9@gmail.com>
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

FIT hash calculation currently selects UCLASS_HASH device zero directly,
so a provider which does not implement the requested algorithm prevents a
later capable provider from being used.

Use the common hash provider-selection helper. Retain software fallback
when the helper returns -ENODEV or -EOPNOTSUPP, including when either error
comes from probing a provider. Other errors fail the FIT hash check rather
than retrying the calculation in software. The FIT helper retains its
existing generic failure return value.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v8 -> v9:
  - Clarify which provider errors permit software fallback, including
    probe errors, without changing the FIT helper's generic failure return

Changes v3 -> v4:
  - New patch
---
 boot/image-fit.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 0ed809aa1f6..dacd8a61f31 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -1329,30 +1329,22 @@ int calculate_hash(const void *data, int data_len, const char *name,
 #ifndef USE_HOSTCC
 	int rc;
 	enum HASH_ALGO hash_algo;
-	struct udevice *dev;
 
 	if (CONFIG_IS_ENABLED(DM_HASH)) {
-		rc = uclass_get_device(UCLASS_HASH, 0, &dev);
-		if (rc) {
-			debug("failed to get hash device, rc=%d\n", rc);
-			return -1;
-		}
-
 		hash_algo = hash_algo_lookup_by_name(name);
-		if (hash_algo == HASH_ALGO_INVALID) {
-			debug("Unsupported hash algorithm\n");
-			return -1;
+		if (hash_algo != HASH_ALGO_INVALID)
+			rc = hash_digest_wd_lookup(hash_algo, data, data_len,
+						   value, CHUNKSZ);
+		else
+			rc = -EOPNOTSUPP;
+		if (!rc) {
+			*value_len = hash_algo_digest_size(hash_algo);
+			return 0;
 		}
-
-		rc = hash_digest_wd(dev, hash_algo, data, data_len, value,
-				    CHUNKSZ);
-		if (rc) {
+		if (rc != -ENODEV && rc != -EOPNOTSUPP) {
 			debug("failed to get hash value, rc=%d\n", rc);
 			return -1;
 		}
-
-		*value_len = hash_algo_digest_size(hash_algo);
-		return 0;
 	}
 #endif
 

-- 
2.53.0

