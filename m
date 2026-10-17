Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D369CCC6B2A
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 04:36:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 634C881694;
	Sat, 17 Oct 2026 04:36:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vBWAKr3UYoGl; Sat, 17 Oct 2026 04:36:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2F0088162E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792211805;
	b=T45a/fPUrfZ5gtfAyHT7EBZYpQlW8japrIE9Y0/0q1ogs7Qt3YJ/8ytOayAIlye1sJBR
	 9eGK/6klZkc7j5KWkialWbLjeLOiEYSNYG1PwjeJ4VacNVr6RVLjZMeaG66/DWEmhYn8z
	 uAiuvmhZstsdSU0eiMy3fx/n7zJ/Lf+RQD9Hy4Hvyi8YHlNIwf0ud2KmhBppQr+eih73P
	 947d9f72HVCr+qjV7QgolPAWHozaf7DcThdbeyiACHNhM/5kygCOhHwgUyJRobzyx9RfO
	 k06DRLyct3OkLK1oe1Hky+LXFLFE2wWlHswFv+XxHjKIrvPVcWMLjMp0w+/qd7qItJQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792211805;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/ZNnjT8CDiFiM9AkEnmkXovOVO5tW/rJTcCnoVvQQWo=;
	b=FgX8dcWatAyCGy9yVRBxxO6OC6isq4gtYXbAsFfKwfuQ9QgQN1YcyiXFQ4wr0mVwa8Nn
	 b+XS34Hr7aOxtB8pzL9alUHKMkhs6WDfc9+wfjtyr71BYsq5BR/0IEv0rrb7AhB1/Ep7O
	 hjxZQSQBgODV3ayamw6zU4K6aPon8N2ZJ4pkPqO2Y5uazq4XPdmtTSV0M8xgQj/b3lFfX
	 3DE9PEXYgi9Vf54bFkKnGhu6CbbUvOqxBb2Bb9mrX//6uqNgQ8aGHfRfLjBGNWyR3ZhJ9
	 O3FE//Psh8zloruP2ooXGuhKFJJTv4vrr84P0dxqKiKhvvQqjrLjSRjaxSxIVuKEfNQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792211805;
	bh=/ZNnjT8CDiFiM9AkEnmkXovOVO5tW/rJTcCnoVvQQWo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N8kIGAfwAIUTxS6v9JXCKnBneajoGESnCjJmri2MAqfi08U/JzyEO/4YoeXLjsOuj
	 WGzZ6u31JRMWZGRRjpkyzMoLNFtcMZnicbjRF2IXmELMHNd/JpsbKZpQWLzLhIwvbo
	 QYJkhzRjyuQWI4yE4CAvkFcEzmlN4eSV6OwByxiPvEES0qqn0RKsPruR57q7yxCOy6
	 htxAZR/++O5aqPmOhPUlkpK0Dc8UbgEaBzw6jvc4XPnAWqJXJA+q/bzaNlKZ1oGSHu
	 M+h9iGJLKtV3C0CZdWxWwjO1vEC8ppzhW4XU3lDkjcrfz4EUz4IdY8HqPJzlAJjwTy
	 jWQw7THJ0dP/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2F0088162E;
	Sat, 17 Oct 2026 04:36:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E877255
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:36:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6FFED4081B
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:36:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8MfCFaRJGAex for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 00:36:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C87C3405E3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792197374;
 b=BZ2JLT9LbvzcHl1L3JKPwSkxB54gUOeB3NVBoNtFXqBMwKVunFP3JwmaOOU+W8HQKBvl
 TfCcTyll1fwNi2kGyjSSuti/Zady9ZAjBq/PrjTdFruKRknl4TWawuwl2E4aCDk8u+vLj
 mM+5AnwZB+sK8+FU0VQuJcoUacl5x0V+rSQMiocu23QrM2+/Sr2k4I4cilj3jG/b45BHv
 BksnLTyT2ngL1ts0S/EU62HsUbm3CzB7HJiICAF8Ab/zl53zTr07GhNJaIQEc6jk3vyl6
 p40ysPXnOQwyzAhVCyLIk0t8r7vxdSDmhyKIEaNs1t5PrZj2P5O0NA3tBX6st9uh60Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792197374;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=/ZNnjT8CDiFiM9AkEnmkXovOVO5tW/rJTcCnoVvQQWo=;
 b=Q22fBQe4c2E9Ew8yqb/vk/JeR4AFgWQvj7HztXSXYZtojP7cRGW72xrleqDl+Q4bMFPM
 mz8YkXymlCymQSB6FMF9IVEvsWKXGvmbDXT8V5i4SbhM8QG1zPfF1cKavvfnpX0FbaTVO
 9iXUConqZnygQlFm9E669lu9zEOyscggQbFt/4TIm24BiLZQWtfNw9WU63hhw+oRfRY1f
 XMV0Uko/pqgy868vm+I7Hrx/cIbesOwAM3RewJ2J72j2Lq25xY3tMqheBZpyBgHXvyaDT
 1DT/I8PFohc/XZUtG+WJV84P/lKyvG4plIGgNQwQH3PS4K1R4oy8gI84Dthewz3qvYw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="A/194pxG"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2f; helo=mail-oo1-xc2f.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=A/194pxG
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C87C3405E3
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:36:10 +0000 (UTC)
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-6d00d120b28so384215eaf.1
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 17:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792197370; x=1792802170;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/ZNnjT8CDiFiM9AkEnmkXovOVO5tW/rJTcCnoVvQQWo=;
 b=A/194pxGTlJ4FLFVakeq75PS7/ti6VOzeblg+en/HYo2MTc/T7qPntw1oPo7mitg9U
 dHiTY84eaRT61KWWrcLsyJS192ToyqEVz5MzQZijDZ6U3BSErANwEo4DXcPqxFJqfsy4
 dtB2EwZzIDEdLoyHg3Pc7f7X4okj8/Ul0ZrCKcxNRMhNf7xlWMsZ3+5fgsQdrdeeAqna
 pzFjirK8ITTuDn6MULHeJOwHf/rnaZREDvtuBP2kTb637ORWiQrxv+W5P0gHyqqM25ly
 cIq8AQlilsdJqmp5zYO4JXQ3bWg5JbPj8MCRLU74nBXHuZno0xJA8PhrrYwvD33FiQv4
 5CVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792197370; x=1792802170;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/ZNnjT8CDiFiM9AkEnmkXovOVO5tW/rJTcCnoVvQQWo=;
 b=X2IM8lECVjM6CKAnQb5LPStg1cOPhPQo26dZB8Kd3O0lC4vg1hsJ9QzWUnAvkkHgu5
 BQ2AcwOsO0lEBDS0W1yNE8imRGatCdLdzcLa9j65no1q27Skhq+gjHPTUXZp+fRv9YIY
 VD1BOpA1egZhQOXS7RXUDEJd4PYG1Q3RR+8Exb2rry/thdel7QLuo40oXKaphdyQ+i5b
 zb/147yhO6cNt0Dv//ZDa1YvuQOkiar6jvRZZQMPnbiKp9UU/bu9yyvcCH3I1nBMFnAd
 5ahWhZFRmOFCLNIl2bHZOYfjnmeKjTchXjj9WekfcitZMgKBzNUDa9+pY6TBSrKYvFU0
 tOYw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz1dasvznx6Wd74Uh+4sN9MD+UUXtS/4NhYwmXxiGgD9N89E6VtB9ZNPBhuoAJMX/E0Urk5an8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLVagxhT+ZGd4NbOFrcTW0MO9tQQQCuRw7zir1DfjiNIG8dCfy1
 KTGo6GlIcDWpjw1Rk3q8yw4AjEWVinJBskQqHO5sqSLBImIN0mXs4Lep
X-Gm-Gg: AYBFou22azsomy1rLFNYTOA02L/4h9Fd8Jl4DrddFX2aloow5DIPdRb/VwBWqn8EGwo
 bDjPQWmPeQeWi9FdEfNK6l/GsZtsKDgOpmD/AXxRU/1/WoTZdK0pXbkVk84WUevLbL/j8y1toZt
 2KvTNuNJiUKyoRb6ccR4UaQWk/eROKNRQSCC4hKbsmK45/l19L1uzGwa5kG35Q8xcDwhzcb8YhF
 jKuDDojUqDt7S52eYM8xr1vTPey/MyTVGrgoRZYaAiNbR1zQPGJN78gzN6W9j/Gg/5KEjtx4/sx
 XsArT2cJdhIycvxI+831HEK3UojYm1LvG9nSs1IUUMzVYZfydzpfH8x+5RhHjU+Uh6LaKC7JT9R
 ZMIsdpn8Y6MaAWh/Vg4A+D0I9veiJwYkLwN/rsz7LYLgx8UlVHapCAoyBQ/+N2yWHmekh/vnVTQ
 3GakK8WtL/ioWkcWCqIpS7w1IN80IQdxSNMM5BQg36MQPZBaYUoG+QomRFuR2eOXymxssE5Q/i5
 km59mf+JPJWaxcVPF74b3z6nFfYsfZ33jZkDzNSNS5ykd1sf6DsUShsCiwaA0TEg2MAXh3fzvvK
 mEvSTOtSnWUajm5wVF9Htq5Ce5gGYzHRA2xlfBhbx23Unfe7c4iB482cpV6Gp6R6ddv0oIkwkV0
 EmNwYd8BrBIU2f9AXIxvpYA==
X-Received: by 2002:a05:6820:4b84:b0:703:3ff5:ddbf with SMTP id
 006d021491bc7-703528804fdmr883300eaf.1.1792197369507; 
 Fri, 16 Oct 2026 17:36:09 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a73b5b4291sm2745091fac.5.2026.10.16.17.36.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 17:36:08 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 16 Oct 2026 18:35:25 -0600
Subject: [PATCH v9 11/17] boot: image: add FIT decrypt-to-buffer helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-submit-ce-series-v2-v9-11-c24e64daafe9@gmail.com>
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

FIT cipher support currently allocates the output buffer inside the AES
helper. SPL often needs to decrypt directly into a caller-selected
buffer, for example a load buffer or a scratch buffer used before
decompression.

Add a decrypt_to callback to the FIT cipher algorithm and wire it up for
AES. The existing allocating decrypt path becomes a wrapper around the
new helper.

Validate the FIT cipher key length, IV length and unciphered-size
property while preparing decryption, and build lib/aes/ by phase when
FIT_CIPHER is enabled so the target-side decrypt helper is available to
SPL builds. Use the DM AES provider helper when enabled, retaining the
software implementation only when no provider supports the operation.

For U-Boot proper, use decrypt_to for in-place decryption when the FIT
payload is already in writable RAM and has a non-ignored payload hash.
The encrypted data is no longer needed after hash verification, and this
avoids a full-size allocation for encrypted payloads loaded into DRAM.

When normal image verification is disabled, verify the payload hash
before overwriting the ciphertext. A repeated load then fails the hash
check before AES sees the plaintext. Keep using the allocating path for
payloads with absent or entirely ignored hashes so their ciphertext
remains reusable, and leave signed FIT metadata unchanged.

On host builds, make both decrypt helpers return -ENOSYS instead of
reporting success without producing output.

Add sandbox coverage for out-of-place and in-place AES-256 decrypt and
malformed key, IV and size inputs. Exercise repeated FIT loads with
absent, ignored, enabled and mixed payload hashes.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v8 -> v9:
  - Preserve upstream FIT property-length validation and disabled-cipher
    declarations when rebasing
  - Leave the existing FIT property-check formatting unchanged
  - Share AES input validation between decrypt helpers and validate the
    allocating wrapper before allocating its output buffer
  - Require a non-ignored payload hash for in-place decryption and retain
    the allocating fallback when hashes are absent or all ignored
  - Cover repeated FIT loads with absent, ignored, enabled and mixed hashes,
    with normal image verification both enabled and disabled

Changes v5 -> v6:
  - Keep signed FIT metadata unchanged after in-place decryption
  - Require a payload hash for in-place decryption and verify it when
    normal verification is disabled, so repeated loads fail before AES
    processes plaintext  (suggested by Simon Glass)
  - Return -ENOSYS from the allocating host decrypt stub
    (suggested by Simon Glass)
  - Preserve the existing fit_image_decrypt_data() declaration wrapping

Changes v3 -> v4:
  - Validate cipher metadata before reading the key length
  - Preserve hard provider failures and fall back only when unsupported
  - Treat -EINVAL as a hard provider error
  - Fix disabled-feature declarations and use the public test prototype
  - Add in-place decrypt and malformed-input tests
  - Simplify the legacy allocating decrypt wrapper

Changes v2 -> v3:
  - Flip the image_aes_decrypt_to() host-tool guard
    (suggested by Simon Glass)
  - Let image_aes_decrypt_to() be the single length-validation path
    (suggested by Simon Glass)
  - Document that AES CBC decrypt providers must support in-place decrypt
    (suggested by Simon Glass)

Changes v1 -> v2:
  - Explain FIT cipher validation  (suggested by Simon Glass)
  - Explain phase-keyed lib/aes builds  (suggested by Simon Glass)
  - Return -ENOSYS without decrypt support  (suggested by Simon Glass)
  - Use decrypt_to for U-Boot proper in-place decrypt
---
 boot/image-cipher.c              |  47 +++++++++++++---
 boot/image-fit.c                 |  67 ++++++++++++++++++++--
 include/image.h                  |  39 +++++++++++++
 include/u-boot/aes.h             |  10 ++++
 lib/Makefile                     |   2 +-
 lib/aes/aes-decrypt.c            | 110 ++++++++++++++++++++++++++----------
 test/lib/Makefile                |   3 +
 test/lib/test_aes_decrypt.c      |  89 +++++++++++++++++++++++++++++
 test/py/tests/test_fit_cipher.py | 118 +++++++++++++++++++++++++++++++++++++++
 9 files changed, 440 insertions(+), 45 deletions(-)

diff --git a/boot/image-cipher.c b/boot/image-cipher.c
index 9d389f26cea..e7ef72987cc 100644
--- a/boot/image-cipher.c
+++ b/boot/image-cipher.c
@@ -25,6 +25,7 @@ struct cipher_algo cipher_algos[] = {
 #endif
 		.encrypt = image_aes_encrypt,
 		.decrypt = image_aes_decrypt,
+		.decrypt_to = image_aes_decrypt_to,
 		.add_cipher_data = image_aes_add_cipher_data
 	},
 	{
@@ -36,6 +37,7 @@ struct cipher_algo cipher_algos[] = {
 #endif
 		.encrypt = image_aes_encrypt,
 		.decrypt = image_aes_decrypt,
+		.decrypt_to = image_aes_decrypt_to,
 		.add_cipher_data = image_aes_add_cipher_data
 	},
 	{
@@ -47,6 +49,7 @@ struct cipher_algo cipher_algos[] = {
 #endif
 		.encrypt = image_aes_encrypt,
 		.decrypt = image_aes_decrypt,
+		.decrypt_to = image_aes_decrypt_to,
 		.add_cipher_data = image_aes_add_cipher_data
 	}
 };
@@ -70,6 +73,7 @@ static int fit_image_setup_decrypt(struct image_cipher_info *info,
 				   int cipher_noffset)
 {
 	const void *fdt = gd_fdt_blob();
+	int key_len, iv_len;
 	const char *node_name;
 	char node_path[128];
 	int noffset;
@@ -94,7 +98,7 @@ static int fit_image_setup_decrypt(struct image_cipher_info *info,
 		return -1;
 	}
 
-	info->iv = fdt_getprop(fit, cipher_noffset, "iv", NULL);
+	info->iv = fdt_getprop(fit, cipher_noffset, "iv", &iv_len);
 	info->ivname = fdt_getprop(fit, cipher_noffset, "iv-name-hint", NULL);
 
 	if (!info->iv && !info->ivname) {
@@ -115,7 +119,7 @@ static int fit_image_setup_decrypt(struct image_cipher_info *info,
 						 &info->size_unciphered);
 	if (ret) {
 		printf("Can't get size of unciphered data\n");
-		return -1;
+		return ret;
 	}
 
 	/*
@@ -136,20 +140,28 @@ static int fit_image_setup_decrypt(struct image_cipher_info *info,
 	}
 
 	/* read key */
-	info->key = fdt_getprop(fdt, noffset, "key", NULL);
+	info->key = fdt_getprop(fdt, noffset, "key", &key_len);
 	if (!info->key) {
 		printf("Can't get key in cipher node '%s'\n", node_path);
 		return -1;
 	}
+	if (key_len != info->cipher->key_len) {
+		printf("Bad key length in cipher node '%s'\n", node_path);
+		return -1;
+	}
 
 	/* read iv */
 	if (!info->iv) {
-		info->iv = fdt_getprop(fdt, noffset, "iv", NULL);
+		info->iv = fdt_getprop(fdt, noffset, "iv", &iv_len);
 		if (!info->iv) {
 			printf("Can't get IV in cipher node '%s'\n", node_path);
 			return -1;
 		}
 	}
+	if (iv_len != info->cipher->iv_len) {
+		printf("Bad IV length for cipher in image '%s'\n", node_name);
+		return -1;
+	}
 
 	return 0;
 }
@@ -165,11 +177,28 @@ int fit_image_decrypt_data(const void *fit,
 	ret = fit_image_setup_decrypt(&info, fit, image_noffset,
 				      cipher_noffset);
 	if (ret < 0)
-		goto out;
+		return ret;
+
+	return info.cipher->decrypt(&info, data_ciphered, size_ciphered,
+				    data_unciphered, size_unciphered);
+}
+
+int fit_image_decrypt_data_to(const void *fit,
+			      int image_noffset, int cipher_noffset,
+			      const void *data_ciphered, size_t size_ciphered,
+			      void *data_unciphered, size_t *size_unciphered)
+{
+	struct image_cipher_info info;
+	int ret;
+
+	ret = fit_image_setup_decrypt(&info, fit, image_noffset,
+				      cipher_noffset);
+	if (ret < 0)
+		return ret;
 
-	ret = info.cipher->decrypt(&info, data_ciphered, size_ciphered,
-				   data_unciphered, size_unciphered);
+	if (!info.cipher->decrypt_to)
+		return -ENOSYS;
 
- out:
-	return ret;
+	return info.cipher->decrypt_to(&info, data_ciphered, size_ciphered,
+				       data_unciphered, size_unciphered);
 }
diff --git a/boot/image-fit.c b/boot/image-fit.c
index 30da18f571f..6e89707788f 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -1029,7 +1029,7 @@ int fit_image_get_data_size(const void *fit, int noffset, u32 *data_size)
  *
  * @fit: pointer to the FIT image header
  * @noffset: component image node offset
- * @data_size: holds the data-size property
+ * @data_size: holds the data-size-unciphered property
  *
  * returns:
  *     0, on success
@@ -1042,7 +1042,7 @@ int fit_image_get_data_size_unciphered(const void *fit, int noffset,
 	const fdt32_t *val;
 	int len;
 
-	val = fdt_getprop(fit, noffset, "data-size-unciphered", &len);
+	val = fdt_getprop(fit, noffset, FIT_DATA_SIZE_UNCIPHERED_PROP, &len);
 	if (!val)
 		return -ENOENT;
 
@@ -1557,8 +1557,37 @@ int fit_all_image_verify(const void *fit)
 	return 1;
 }
 
+#ifndef USE_HOSTCC
+static bool fit_image_has_enabled_hash(const void *fit, int image_noffset)
+{
+	int noffset;
+
+	fdt_for_each_subnode(noffset, fit, image_noffset) {
+		const char *name = fit_get_name(fit, noffset, NULL);
+		int ignore;
+
+		if (strncmp(name, FIT_HASH_NODENAME, strlen(FIT_HASH_NODENAME)))
+			continue;
+
+		fit_image_hash_get_ignore(fit, noffset, &ignore);
+		if (!ignore)
+			return true;
+	}
+
+	return false;
+}
+
+static bool fit_range_in_writable_ram(const void *data, size_t size)
+{
+	ulong start = map_to_sysmem(data);
+
+	return start >= gd->ram_base && start <= gd->ram_top &&
+	       size <= gd->ram_top - start;
+}
+#endif
+
 static int fit_image_uncipher(const void *fit, int image_noffset,
-			      void **data, size_t *size)
+			      bool verified, void **data, size_t *size)
 {
 	int cipher_noffset, ret;
 	void *dst;
@@ -1569,15 +1598,40 @@ static int fit_image_uncipher(const void *fit, int image_noffset,
 	if (cipher_noffset < 0)
 		return 0;
 
+#ifndef USE_HOSTCC
+	if (!tools_build()) {
+		/*
+		 * Avoid a full-size allocation when the FIT payload is already
+		 * in writable DRAM. Require a non-ignored payload hash so a
+		 * repeated attempt detects the consumed ciphertext before
+		 * decrypting it again, even when verification is disabled.
+		 */
+		if (fit_range_in_writable_ram(*data, *size) &&
+		    fit_image_has_enabled_hash(fit, image_noffset)) {
+			if (!verified && !fit_image_verify(fit, image_noffset)) {
+				ret = -EACCES;
+				goto out;
+			}
+			ret = fit_image_decrypt_data_to(fit, image_noffset,
+							cipher_noffset,
+							*data, *size, *data,
+							&size_dst);
+			if (ret != -ENOSYS)
+				goto out;
+		}
+	}
+#endif
+
 	ret = fit_image_decrypt_data(fit, image_noffset, cipher_noffset,
 				     *data, *size, &dst, &size_dst);
 	if (ret)
 		goto out;
 
 	*data = dst;
-	*size = size_dst;
+out:
+	if (!ret)
+		*size = size_dst;
 
- out:
 	return ret;
 }
 
@@ -2419,7 +2473,8 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	/* Decrypt data before uncompress/move */
 	if (IS_ENABLED(CONFIG_FIT_CIPHER) && IMAGE_ENABLE_DECRYPT) {
 		puts("   Decrypting Data ... ");
-		if (fit_image_uncipher(fit, noffset, &buf, &size)) {
+		if (fit_image_uncipher(fit, noffset, images->verify,
+				       &buf, &size)) {
 			puts("Error\n");
 			return -EACCES;
 		}
diff --git a/include/image.h b/include/image.h
index 03e290ad42e..0d32d2847e8 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1185,6 +1185,7 @@ int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
 #define FIT_DATA_OFFSET_PROP	"data-offset"
 #define FIT_DATA_SIZE_PROP	"data-size"
 #define FIT_IMAGE_DATA_PROP	"image-data"
+#define FIT_DATA_SIZE_UNCIPHERED_PROP	"data-size-unciphered"
 #define FIT_TIMESTAMP_PROP	"timestamp"
 #define FIT_DESC_PROP		"description"
 #define FIT_ARCH_PROP		"arch"
@@ -1887,11 +1888,45 @@ int fit_image_check_sig(const void *fit, int noffset, const void *data,
 			size_t size, const void *key_blob, int required_keynode,
 			char **err_msgp);
 
+/**
+ * fit_image_decrypt_data() - Decrypt a FIT image payload
+ *
+ * @fit:		FIT image
+ * @image_noffset:	Offset of the image node to decrypt
+ * @cipher_noffset:	Offset of the cipher node for the image
+ * @data:		Encrypted image payload
+ * @size:		Size of encrypted image payload
+ * @data_unciphered:	Returns allocated decrypted payload
+ * @size_unciphered:	Returns size of decrypted payload
+ * Return: 0 on success, <0 on error
+ */
 int fit_image_decrypt_data(const void *fit,
 			   int image_noffset, int cipher_noffset,
 			   const void *data, size_t size,
 			   void **data_unciphered, size_t *size_unciphered);
 
+/**
+ * fit_image_decrypt_data_to() - Decrypt a FIT image payload to a buffer
+ *
+ * @fit:		FIT image
+ * @image_noffset:	Offset of the image node to decrypt
+ * @cipher_noffset:	Offset of the cipher node for the image
+ * @data:		Encrypted image payload
+ * @size:		Size of encrypted image payload
+ * @data_unciphered:	Destination buffer for decrypted payload. The caller
+ *			must provide at least @size bytes.
+ * @size_unciphered:	Returns size of decrypted payload
+ *
+ * If @data and @data_unciphered are the same buffer, successful decryption
+ * overwrites the encrypted payload.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int fit_image_decrypt_data_to(const void *fit,
+			      int image_noffset, int cipher_noffset,
+			      const void *data, size_t size,
+			      void *data_unciphered, size_t *size_unciphered);
+
 /**
  * fit_region_make_list() - Make a list of regions to hash
  *
@@ -2008,6 +2043,10 @@ struct cipher_algo {
 	int (*decrypt)(struct image_cipher_info *info,
 		       const void *cipher, size_t cipher_len,
 		       void **data, size_t *data_len);
+
+	int (*decrypt_to)(struct image_cipher_info *info,
+			  const void *cipher, size_t cipher_len,
+			  void *data, size_t *data_len);
 };
 
 int fit_image_cipher_get_algo(const void *fit, int noffset, char **algo);
diff --git a/include/u-boot/aes.h b/include/u-boot/aes.h
index d72322c1013..8fd43f02adc 100644
--- a/include/u-boot/aes.h
+++ b/include/u-boot/aes.h
@@ -35,6 +35,9 @@ static inline int image_aes_add_cipher_data(struct image_cipher_info *info,
 int image_aes_decrypt(struct image_cipher_info *info,
 		      const void *cipher, size_t cipher_len,
 		      void **data, size_t *size);
+int image_aes_decrypt_to(struct image_cipher_info *info,
+			 const void *cipher, size_t cipher_len,
+			 void *data, size_t *size);
 #else
 static inline int image_aes_decrypt(struct image_cipher_info *info,
 				    const void *cipher, size_t cipher_len,
@@ -42,6 +45,13 @@ static inline int image_aes_decrypt(struct image_cipher_info *info,
 {
 	return -ENXIO;
 }
+
+static inline int image_aes_decrypt_to(struct image_cipher_info *info,
+				       const void *cipher, size_t cipher_len,
+				       void *data, size_t *size)
+{
+	return -ENXIO;
+}
 #endif /* IMAGE_ENABLE_DECRYPT */
 
 #endif
diff --git a/lib/Makefile b/lib/Makefile
index f36a311f9e8..53bc5f2d911 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -18,7 +18,6 @@ obj-$(CONFIG_ARCH_AT91) += at91/
 obj-$(CONFIG_OPTEE_LIB) += optee/
 
 obj-$(CONFIG_AES) += aes.o
-obj-$(CONFIG_AES) += aes/
 obj-$(CONFIG_$(PHASE_)BINMAN_FDT) += binman.o
 
 obj-$(CONFIG_FW_LOADER) += fw_loader.o
@@ -89,6 +88,7 @@ obj-$(CONFIG_$(PHASE_)ASN1_DECODER_LEGACY) += asn1_decoder.o
 
 obj-$(CONFIG_$(PHASE_)ZLIB) += zlib/
 obj-$(CONFIG_$(PHASE_)ZSTD) += zstd/
+obj-$(CONFIG_$(PHASE_)FIT_CIPHER) += aes/
 obj-$(CONFIG_$(PHASE_)GZIP) += gunzip.o
 obj-$(CONFIG_$(PHASE_)LZO) += lzo/
 obj-$(CONFIG_$(PHASE_)LZMA) += lzma/
diff --git a/lib/aes/aes-decrypt.c b/lib/aes/aes-decrypt.c
index 5d616983082..3085e416955 100644
--- a/lib/aes/aes-decrypt.c
+++ b/lib/aes/aes-decrypt.c
@@ -4,56 +4,108 @@
  */
 
 #ifndef USE_HOSTCC
+#include <dm.h>
 #include <malloc.h>
 #endif
 #include <image.h>
 #include <uboot_aes.h>
 
-int image_aes_decrypt(struct image_cipher_info *info,
-		      const void *cipher, size_t cipher_len,
-		      void **data, size_t *size)
-{
 #ifndef USE_HOSTCC
-	unsigned char key_exp[AES256_EXPAND_KEY_LENGTH];
-	unsigned int aes_blocks, key_len = info->cipher->key_len;
-
-	/*
-	 * The ciphertext is a whole number of AES blocks by construction, and
-	 * the decryption below writes one full block at a time, so anything
-	 * else would overflow the output buffer.
-	 */
+static int image_aes_validate(struct image_cipher_info *info,
+			      const void *cipher, size_t cipher_len,
+			      void *data, size_t *size)
+{
+	if (!info || !info->cipher || !info->key || !info->iv || !cipher ||
+	    !data || !size)
+		return -EINVAL;
+	if (info->cipher->iv_len != AES_BLOCK_LENGTH ||
+	    (info->cipher->key_len != AES128_KEY_LENGTH &&
+	     info->cipher->key_len != AES192_KEY_LENGTH &&
+	     info->cipher->key_len != AES256_KEY_LENGTH))
+		return -EINVAL;
+	/* Decryption writes complete blocks, never beyond the ciphertext size. */
 	if (!cipher_len || cipher_len % AES_BLOCK_LENGTH) {
 		printf("Invalid ciphertext length\n");
 		return -EINVAL;
 	}
-
-	/*
-	 * Decryption produces exactly cipher_len bytes, so the unciphered
-	 * size the image claims cannot be larger than that.
-	 */
 	if (info->size_unciphered > cipher_len) {
 		printf("Invalid unciphered size\n");
 		return -EINVAL;
 	}
 
+	return 0;
+}
+#endif
+
+int image_aes_decrypt_to(struct image_cipher_info *info,
+			 const void *cipher, size_t cipher_len,
+			 void *data, size_t *size)
+{
+#ifdef USE_HOSTCC
+	return -ENOSYS;
+#else
+	unsigned int aes_blocks, key_len;
+	int ret;
+
+	ret = image_aes_validate(info, cipher, cipher_len, data, size);
+	if (ret)
+		return ret;
+	key_len = info->cipher->key_len;
+	aes_blocks = cipher_len / AES_BLOCK_LENGTH;
+
+	if (CONFIG_IS_ENABLED(DM_AES)) {
+		ret = dm_aes_cbc_decrypt_with_key(key_len * 8, (u8 *)info->key,
+						  (u8 *)info->iv, (u8 *)cipher,
+						  data, aes_blocks);
+		if (!ret) {
+			*size = info->size_unciphered;
+			return 0;
+		}
+		if (ret != -ENODEV && ret != -EOPNOTSUPP)
+			return ret;
+	}
+
+	if (!IS_ENABLED(CONFIG_XPL_BUILD)) {
+		unsigned char key_exp[AES256_EXPAND_KEY_LENGTH];
+
+		/* First we expand the key. */
+		aes_expand_key((u8 *)info->key, key_len, key_exp);
+
+		aes_cbc_decrypt_blocks(key_len, key_exp, (u8 *)info->iv,
+				       (u8 *)cipher, data, aes_blocks);
+		*size = info->size_unciphered;
+		return 0;
+	}
+
+	return -ENOSYS;
+#endif
+}
+
+int image_aes_decrypt(struct image_cipher_info *info,
+		      const void *cipher, size_t cipher_len,
+		      void **data, size_t *size)
+{
+#ifdef USE_HOSTCC
+	return -ENOSYS;
+#else
+	int ret;
+
+	ret = image_aes_validate(info, cipher, cipher_len, data, size);
+	if (ret)
+		return ret;
+
 	*data = malloc(cipher_len);
 	if (!*data) {
 		printf("Can't allocate memory to decrypt\n");
 		return -ENOMEM;
 	}
-	*size = info->size_unciphered;
-
-	memcpy(&key_exp[0], info->key, key_len);
-
-	/* First we expand the key. */
-	aes_expand_key((u8 *)info->key, key_len, key_exp);
 
-	/* Calculate the number of AES blocks to encrypt. */
-	aes_blocks = cipher_len / AES_BLOCK_LENGTH;
+	ret = image_aes_decrypt_to(info, cipher, cipher_len, *data, size);
+	if (ret) {
+		free(*data);
+		*data = NULL;
+	}
 
-	aes_cbc_decrypt_blocks(key_len, key_exp, (u8 *)info->iv,
-			       (u8 *)cipher, *data, aes_blocks);
+	return ret;
 #endif
-
-	return 0;
 }
diff --git a/test/lib/Makefile b/test/lib/Makefile
index 9fc4a1a9b5d..94cf42d724a 100644
--- a/test/lib/Makefile
+++ b/test/lib/Makefile
@@ -31,6 +31,9 @@ obj-$(CONFIG_ERRNO_STR) += test_errno_str.o
 obj-$(CONFIG_UT_LIB_ASN1) += asn1.o
 obj-$(CONFIG_UT_LIB_RSA) += rsa.o
 obj-$(CONFIG_AES) += test_aes.o
+ifeq ($(CONFIG_FIT_CIPHER)$(CONFIG_DM_AES),yy)
+obj-y += test_aes_decrypt.o
+endif
 obj-$(CONFIG_SHA256) += test_sha256_hmac.o
 obj-$(CONFIG_HKDF_MBEDTLS) += test_sha256_hkdf.o
 obj-$(CONFIG_GETOPT) += getopt.o
diff --git a/test/lib/test_aes_decrypt.c b/test/lib/test_aes_decrypt.c
new file mode 100644
index 00000000000..3b498e23e4b
--- /dev/null
+++ b/test/lib/test_aes_decrypt.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Tests for target-side FIT AES decryption
+ *
+ * Copyright (C) 2026 James Hilliard
+ */
+
+#include <image.h>
+#include <u-boot/aes.h>
+#include <uboot_aes.h>
+#include <test/lib.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+static int lib_test_image_aes_decrypt(struct unit_test_state *uts)
+{
+	u8 key[AES256_KEY_LENGTH] = { };
+	u8 key_exp[AES256_EXPAND_KEY_LENGTH];
+	u8 iv[AES_BLOCK_LENGTH] = { };
+	u8 plain[2 * AES_BLOCK_LENGTH];
+	u8 cipher[sizeof(plain)];
+	u8 output[sizeof(plain)];
+	struct cipher_algo algo = {
+		.name = "aes256",
+		.key_len = sizeof(key),
+		.iv_len = sizeof(iv),
+	};
+	struct image_cipher_info info = {
+		.cipher = &algo,
+		.key = key,
+		.iv = iv,
+		.size_unciphered = sizeof(plain),
+	};
+	size_t size;
+	int i, ret;
+
+	for (i = 0; i < sizeof(key); i++)
+		key[i] = i;
+	for (i = 0; i < sizeof(iv); i++)
+		iv[i] = 0x80 + i;
+	for (i = 0; i < sizeof(plain); i++)
+		plain[i] = 0x40 + i;
+
+	aes_expand_key(key, sizeof(key), key_exp);
+	aes_cbc_encrypt_blocks(sizeof(key), key_exp, iv, plain, cipher,
+			       ARRAY_SIZE(cipher) / AES_BLOCK_LENGTH);
+
+	size = 0;
+	ut_assertok(image_aes_decrypt_to(&info, cipher, sizeof(cipher), output,
+					 &size));
+	ut_asserteq(sizeof(plain), size);
+	ut_asserteq_mem(plain, output, sizeof(plain));
+
+	memcpy(output, cipher, sizeof(cipher));
+	size = 0;
+	ut_assertok(image_aes_decrypt_to(&info, output, sizeof(output), output,
+					 &size));
+	ut_asserteq(sizeof(plain), size);
+	ut_asserteq_mem(plain, output, sizeof(plain));
+
+	size = 0x55;
+	ret = image_aes_decrypt_to(&info, cipher, sizeof(cipher) - 1, output,
+				   &size);
+	ut_asserteq(-EINVAL, ret);
+	ut_asserteq(0x55, size);
+
+	info.size_unciphered = sizeof(cipher) + 1;
+	ret = image_aes_decrypt_to(&info, cipher, sizeof(cipher), output, &size);
+	ut_asserteq(-EINVAL, ret);
+	info.size_unciphered = sizeof(plain);
+
+	info.key = NULL;
+	ret = image_aes_decrypt_to(&info, cipher, sizeof(cipher), output, &size);
+	ut_asserteq(-EINVAL, ret);
+	info.key = key;
+	info.iv = NULL;
+	ret = image_aes_decrypt_to(&info, cipher, sizeof(cipher), output, &size);
+	ut_asserteq(-EINVAL, ret);
+	info.iv = iv;
+	info.cipher = NULL;
+	ret = image_aes_decrypt_to(&info, cipher, sizeof(cipher), output, &size);
+	ut_asserteq(-EINVAL, ret);
+	ret = image_aes_decrypt_to(NULL, cipher, sizeof(cipher), output, &size);
+	ut_asserteq(-EINVAL, ret);
+
+	return 0;
+}
+
+LIB_TEST(lib_test_image_aes_decrypt, 0);
diff --git a/test/py/tests/test_fit_cipher.py b/test/py/tests/test_fit_cipher.py
new file mode 100644
index 00000000000..4adb18988d8
--- /dev/null
+++ b/test/py/tests/test_fit_cipher.py
@@ -0,0 +1,118 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright 2026 James Hilliard
+
+"""Check encrypted FIT loading and retries with enabled or ignored hashes."""
+
+import hashlib
+from pathlib import Path
+import shutil
+
+import pytest
+
+import fit_util
+import utils
+
+
+# First two blocks of the public AES-256-CBC vector in NIST SP 800-38A.
+KEY = bytes.fromhex('603deb1015ca71be2b73aef0857d7781'
+                    '1f352c073b6108d72d9810a30914dff4')
+IV = bytes(range(16))
+PLAIN = bytes.fromhex('6bc1bee22e409f96e93d7e117393172a'
+                      'ae2d8a571e03ac9c9eb76fac45af8e51')
+CIPHER = bytes.fromhex('f58c4c04d6e5f1ba779eabfb5f7bfbd6'
+                       '9cfc4e967edb808d679f777bc6702c7d')
+
+FIT = '''/dts-v1/;
+/ {
+    description = "Encrypted FIT retry test";
+    #address-cells = <1>;
+    timestamp = <1>;
+    images {
+        kernel {
+            description = "AES-256-CBC test vector";
+            data = [%(cipher)s];
+            data-size-unciphered = <32>;
+            type = "kernel";
+            arch = "sandbox";
+            os = "linux";
+            compression = "none";
+            load = <0x4000000>;
+            entry = <0x4000000>;
+            cipher {
+                algo = "aes256";
+                key-name-hint = "retry";
+                iv = [%(iv)s];
+            };
+            %(hashes)s
+        };
+    };
+    configurations {
+        default = "conf";
+        conf {
+            kernel = "kernel";
+        };
+    };
+};
+'''
+
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('fit_cipher')
+@pytest.mark.buildconfigspec('cmd_bootm')
+@pytest.mark.buildconfigspec('cmd_fdt')
+@pytest.mark.requiredtool('dtc')
+@pytest.mark.requiredtool('fdtput')
+@pytest.mark.parametrize('hash_mode', ('absent', 'ignored', 'enabled', 'mixed'))
+@pytest.mark.parametrize('verify', ('yes', 'no'))
+def test_fit_cipher_retry(ubman, hash_mode, verify):
+    """Only a checked payload hash can guard destructive in-place decryption."""
+    checked = hash_mode in ('enabled', 'mixed')
+    hashes = ''
+    if hash_mode in ('ignored', 'mixed'):
+        hashes += 'hash-ignored { algo = "sha256"; uboot-ignore = <1>; };'
+    if checked:
+        digest = hashlib.sha256(CIPHER).digest().hex(' ')
+        hashes += f'hash-checked {{ algo = "sha256"; value = [{digest}]; }};'
+
+    name = f'fit-cipher-{hash_mode}-{verify}'
+    fit = fit_util.make_dtb(ubman, FIT % {
+        'cipher': CIPHER.hex(' '), 'iv': IV.hex(' '), 'hashes': hashes,
+    }, name)
+    dtb = fit_util.make_fname(ubman, f'{name}-control.dtb')
+    payload = fit_util.make_fname(ubman, f'{name}-payload.bin')
+    loaded = fit_util.make_fname(ubman, f'{name}-loaded.bin')
+    old_dtb = ubman.config.dtb
+    shutil.copyfile(old_dtb, dtb)
+    utils.run_and_log(ubman, ['fdtput', '-p', '-t', 'bx', dtb,
+                            '/cipher/key-aes256-retry', 'key',
+                            *KEY.hex(' ').split()])
+
+    try:
+        ubman.config.dtb = dtb
+        ubman.restart_uboot()
+        ubman.run_command(f'setenv verify {verify}')
+        ubman.run_command(f'host load hostfs - 1000000 {fit}')
+
+        for attempt in range(2):
+            output = ubman.run_command('bootm start 1000000')
+            if attempt and checked:
+                # A retry must reject the already consumed ciphertext.
+                assert 'Bad hash value' in output
+                assert 'Decrypting Data ... OK' not in output
+            else:
+                result = output.split('Decrypting Data ... ', 1)[1]
+                assert result.splitlines()[0].endswith('OK')
+                ubman.run_command('bootm loados')
+                ubman.run_command(f'host save hostfs - 4000000 {loaded} 20')
+                assert Path(loaded).read_bytes() == PLAIN
+
+            ubman.run_command_list([
+                'fdt addr 1000000',
+                'fdt get addr fit_cipher_data /images/kernel data',
+                f'host save hostfs - $fit_cipher_data {payload} 20',
+            ])
+            # Ignored/absent hashes must retain the allocating fallback.
+            assert Path(payload).read_bytes() == (PLAIN if checked else CIPHER)
+    finally:
+        ubman.config.dtb = old_dtb
+        ubman.restart_uboot()

-- 
2.53.0

