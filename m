Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15DCDCC6B2A
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 04:36:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC5E78150D;
	Sat, 17 Oct 2026 04:36:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vhCPLP818zb4; Sat, 17 Oct 2026 04:36:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A2CAF8153D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792211795;
	b=lKkgWOlUy5voVuLEQlYCshZIvMUcpGzEk5glnsvUaXdh7jn9ZA4ABTYQOdPs7wXwj0UC
	 Ke0QS9QRfVT3+5ufJhrHyWyLz5FOft+eDbH/3AKIWIOGyOugudC2B4kWPkdRV11+RNMBC
	 tvq1dhYpnPaoiCH6vlIiJ/wxKICtJ8vTnGpr4hZWrL0ETDUmSRFikYWksFYjz32DI6zIA
	 abRYXc6ULCMOd24TdSKzvv7ZEg0OSwXoqP/rXn5warvjErrcH23HrXIIaFN///2ILP6t3
	 JImvS4zCeVbfyr8RP5l0D/wvx/wvOMwasiVCmskyA89tQiHGTcwEz+qDdM/sKCODIjA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792211795;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wTxgZFck3fqYOD51izeq1z3wEPtoXFPdInTR6K7LiDo=;
	b=dWzs9PfhVuhd1HL8N3VY2KgcAdjjk7HBmb9LZjv9WUznLIFu5RyiUD7RYrNYexX0k4AC
	 Zqte+iE7o7j1Qfca87KuYMeR0sg0PnnyM0+tOXqsTpqzeNvLbExyvBMYNY7vmbbEGsRU7
	 Gi33XCxZEvCcBeBXfgS46ZkdNcCULu0ANimwwXLxV4dXUKhGwYdcMBgaNJ2MjmfPEnopO
	 y+K2MRNTCZjklpHXxupoH8YmTwYpNaz3yQrLiRPLT9G//9Uo2PnOcW7O1bVv9HAej+Ir1
	 06hAYh0cFnUNDd7VkUjq4fkARzbGZ/Nq8+eTocBNlk/gTpuy9GtJ6k0UGieCEhiUIfg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792211795;
	bh=wTxgZFck3fqYOD51izeq1z3wEPtoXFPdInTR6K7LiDo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YcsjhhrD3A97wApIoqR86vrozz5IEVvnEsn1G0VqTsmGj2ZXFNtXeXsQQZMqchTxx
	 SxtueefjsP6y34jqzzAeGBN/wvWt9t0xoE7+muZOvMwCZElFeeOp0/JpJpkAijJ+V0
	 7ifp7EOG5Afmbp+oCncBdHe5r9VSa/kTyZ7razkyFvoKmHYIOc0zNoclxPJYjT9Cx3
	 Z4i9bl6k5zBrsuOCaR8nCru0KFKB6gKNmSvv3raGmhsRhP1ZXFiXKZSmwFU2IGVneh
	 h2gKq9LarktmHgta4hHnKxO+cnwM9WvywkYgR8l8moP4jz0g7PNp+mhuxCgBwOqkff
	 hDf8/A9F52PYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A2CAF8153D;
	Sat, 17 Oct 2026 04:36:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B176C105
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:35:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A366C405E3
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:35:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7yX8cSORuyii for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 00:35:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B8E794081B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792197353;
 b=UVzIQk1hy10fC9LDYleWErqkUdO7UEpk8D+DpFvXY+tVvDv9S28S14SOyXZR72wES/Uv
 k6HLBX6VlpOYDP/fA7LhpAf73ED48GWj/MQEGRcfSwC+sIbq5b3M/pDya6BgstYj0XAch
 wvt7A5LC4l9PdMeN5mbpOZK+kfCoZwzQMNIOPpy6RERglhjBVad1CNnp70Xsdvi0K3VR0
 Pco/yN486eJcHE6t25T9Z3/+4Gan3GIVNYrsJpsRZzfu/stEXVBcT7ND4+Q2C5I7WEJjO
 S7DmS8HsVlTi8QO/z3eaRqMndLTZUcHML77ojuoV1+voRdVpQYDYmkMTPkrFtTxOmQg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792197353;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=wTxgZFck3fqYOD51izeq1z3wEPtoXFPdInTR6K7LiDo=;
 b=LTWFUB3iIMGglzheCd2jsIe/56VsJeTpiDQP1j3Q1cO+8anq0anxPuY4b88EJqosfeRO
 RdmviCOvwMONBkra5GrOWvv96ySqyv7Kbpkzg51DvLJ5K/o3nsjffx/q3Mzg1KCtj7tY3
 COy9WIDqb03Y1GyFeIqOgUeAB0nDYDXyqFhZz82JbH1DyGwPzzyfff77gYfrLycGyqaRb
 LENMQkSluxmDCi75i9q+Hn9TS0lA0235H90KSnXVVN+9DrZ2tBDsQeWUmHSpMlPtgwuYr
 Zl362YDy7PUsS2BX8MRryzgBh6O5XDOvOJGxYOktCpAZZIvEPG89uc4nUDOhMR5l4Tw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=XyDemwpw; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2c; helo=mail-oo1-xc2c.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=XyDemwpw
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B8E794081B
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:35:52 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6f8a519e215so485107eaf.1
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 17:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792197351; x=1792802151;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wTxgZFck3fqYOD51izeq1z3wEPtoXFPdInTR6K7LiDo=;
 b=XyDemwpwvy3oqCBMWZzBTO/OD9RBHItRJiuFmPmEoCGX8MIgzLTPEwx5qM8dbLRD6R
 yLZac1TqgggbIOMYqL6GqtTYjo/qj8RUcXhobgNskGKXcSxOVcsNunsE5tLcZ0REveDA
 SMVfV2IJY6UyJDaz3Q1Oa6gQ7W8GIYiaGxyE8EpRzVi2IH7EUEI0jr9ljRJItu0nfOhC
 VCHUdJYmJ1v/99cjKJvYJLvKX+SO+LjAmYtBKR1oLpXUndrnaeH9Rd/KSYNgWEP5lA4G
 wkqn9E8/2MkphvGRCdCSZsHhmkyti+sMVoHgF44FsZ4mp7CCjN20QgxXCwKVdNNoQLq2
 PpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792197351; x=1792802151;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wTxgZFck3fqYOD51izeq1z3wEPtoXFPdInTR6K7LiDo=;
 b=uDDxPLgDvLxAH5Jk71BN5cCo2dW3RKgQ8N8AOW5XJVGuDC75BorMfprc8kXWG2Fb93
 +DOjF5TudHdZng/6TnXcONLNaDqRQPbZXDgIJaOWzi3NyRjpfmE93LyCddF3npahtTJX
 9ZiHQiWuEzilIlHNMIrLddLxuvN8LCN1wFZYny9Tx0kC02U81h1CjI94CKI2H3bvQNQs
 1vhv6VoSFsi10E9IQuqg8qK/69hseqaP6NJY2xYCrboCuxEeh7Ui+Wd4+OzAo3Wf7SuS
 NR/xHLmArjybLsUW8/lnGgLXgaehhnfNbFtjXIaPID8gssPlqhKRola2hvEwevA8HWJr
 f3+w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwkYerdjPiyFsAJZM8ntXq3LwaA4tSURhLJavTWGI5YJSS691rmw5/oOa1INQu3m7lBJvfc3h4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJBw2Y6VbXHR5DM96vRMKSvca8GJjxDZfCHsHEaIuMM7krqok5v
 v+j05fbh8pqRH35Z8tHa1j+bdkAbUr6PluYVNT1Gl8QzUbvYjtqyP74f
X-Gm-Gg: AYBFou28rI4Ye88+iCNsOhrKW3h6+o3Hdkld6ZIueB+kxmfvI3eSbbFWGr2rS2eYhOO
 UiI3ldYjTZAe1cN/XMcZBZKoZpEOHJ2UXEeynSZCLoUlIqOI4BfYWW5v7ftj3si8AjyRPdQEtgi
 IjHAgJGnBU/9HVVpFHJXSzTl06OjdiMvVSb/cDs72Cp+TKOD/se87SYEO4gZ8qbJg6IgfRE9Ma8
 44YKV2CyWg5ilPlY81FHpSNA13oFg3HOb+lbsm10ojEo6yZB5ZKW9H8No/cpUYisDACqUWgcAKz
 Mf/uJIZ2gkOiHzDRUOmQvd6gqWAxpjoXUJS3x8Yezlv9aoq9jJhMiG0wgDUBzMxABDPcOcGXgSq
 yyhOZx/4QzR9vzoAHrvTBg41JRGDfyiYGcyHwcUgEpyaYrzyRZd48QovK4O3tUuLWI9NiEWRdzs
 Oa+n5gk9LMG3As2e4Cfu16yJr75Frpm21qb1R+y9OzljI06cKLEOaXrnMNIX8fc5y73b6xgHxlP
 1SReGQ9KVU4NnGDrk6X+xopr0A4WzYdJJeNjekZYwcgTuAg7IdIpnCzwO0ZYn1Ebhu5IlJmlHqN
 IFsZE81BWWF7c0M+w3Nd88gZwP50lwp2rjUQeTEIWNeWMwGmBVK/xRgh9cMAJiqPAZLpnkKg6vo
 Zv/Gqm003fev5R8Zioxt/MQ==
X-Received: by 2002:a05:6820:190b:b0:6c7:8dab:ca1a with SMTP id
 006d021491bc7-701124b0100mr3384155eaf.17.1792197350878; 
 Fri, 16 Oct 2026 17:35:50 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a73b5b4291sm2745091fac.5.2026.10.16.17.35.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 17:35:50 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 16 Oct 2026 18:35:20 -0600
Subject: [PATCH v9 06/17] crypto: aspeed: preserve Caliptra hash update
 boundaries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-submit-ce-series-v2-v9-6-c24e64daafe9@gmail.com>
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

The Caliptra SHA accelerator consumes a stream of 32-bit DATAIN words.
cptra_sha_update() pads every update to a word, so splitting an input at
a non-word-aligned boundary inserts bytes into that stream. For example,
one byte followed by three bytes does not hash the same data as a single
four-byte update. This also affects one-shot hashing when watchdog chunks
are not word-aligned.

Keep a partial word in the context across updates and write it, padded,
only at finish. Empty updates must not write DATAIN, since that would
insert a word into an existing stream. An entirely empty message still
needs one DATAIN write at finish to start the streaming state machine,
with DLEN left at zero.

Reject cumulative lengths which overflow the 32-bit DLEN register before
changing the context or hardware. Share driver-local cleanup between
finish and the one-shot update-error paths, zeroizing the engine and
releasing its lock and context. Also free the allocated context when
initial hardware-lock acquisition fails.

Fixes: fca70d61817b ("drivers/crypto: aspeed: Add Caliptra SHA ACC support")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v8 -> v9:
  - New patch, separating Caliptra streaming-input and cleanup fixes from
    the generic progressive hash-provider changes
---
 drivers/crypto/aspeed/cptra_sha.c | 78 +++++++++++++++++++++++++--------------
 1 file changed, 51 insertions(+), 27 deletions(-)

diff --git a/drivers/crypto/aspeed/cptra_sha.c b/drivers/crypto/aspeed/cptra_sha.c
index 0dc00f306f1..62d6955493f 100644
--- a/drivers/crypto/aspeed/cptra_sha.c
+++ b/drivers/crypto/aspeed/cptra_sha.c
@@ -5,6 +5,7 @@
 #include <asm/io.h>
 #include <config.h>
 #include <dm.h>
+#include <limits.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/iopoll.h>
@@ -36,6 +37,8 @@ enum cptra_sha_modes {
 struct cptra_sha_ctx {
 	enum HASH_ALGO algo;
 	uint32_t dgst_len;
+	u32 pending;
+	u32 pending_len;
 };
 
 struct cptra_sha {
@@ -75,8 +78,11 @@ static int cptra_sha_init(struct udevice *dev, enum HASH_ALGO algo, void **ctxp)
 	cs = dev_get_priv(dev);
 
 	/* get CPTRA SHA lock */
-	if (readl_poll_timeout(cs->regs + CPTRA_SHA_LOCK, reg, reg == 0, 1000000))
-		return -EBUSY;
+	if (readl_poll_timeout(cs->regs + CPTRA_SHA_LOCK, reg, reg == 0,
+			       1000000)) {
+		rc = -EBUSY;
+		goto free_n_out;
+	}
 
 	/* zero clear SHA */
 	writel(CPTRA_SHA_CTRL_ZEROIZE, cs->regs + CPTRA_SHA_CTRL);
@@ -102,33 +108,42 @@ free_n_out:
 
 static int cptra_sha_update(struct udevice *dev, void *ctx, const void *ibuf, uint32_t ilen)
 {
+	struct cptra_sha_ctx *cs_ctx = ctx;
 	struct cptra_sha *cs;
-	uint32_t din_be;
 	uint32_t dlen_sum;
-	uint8_t *p8;
-	uint32_t i;
+	const u8 *p8 = ibuf;
+
+	if (!ilen)
+		return 0;
 
 	cs = dev_get_priv(dev);
 
 	/* update length */
-	dlen_sum = readl(cs->regs + CPTRA_SHA_DLEN) + ilen;
-	writel(dlen_sum, cs->regs + CPTRA_SHA_DLEN);
-
-	din_be = 0;
-	for (i = 0, p8 = (uint8_t *)ibuf; i < ilen; ++i) {
-		if (i && (i % sizeof(din_be) == 0)) {
-			writel(din_be, cs->regs + CPTRA_SHA_DATAIN);
-			din_be = 0;
+	dlen_sum = readl(cs->regs + CPTRA_SHA_DLEN);
+	if (ilen > U32_MAX - dlen_sum)
+		return -EOVERFLOW;
+	writel(dlen_sum + ilen, cs->regs + CPTRA_SHA_DLEN);
+
+	/* Preserve incomplete words across update boundaries. */
+	while (ilen--) {
+		cs_ctx->pending = (cs_ctx->pending << 8) | *p8++;
+		if (++cs_ctx->pending_len == sizeof(cs_ctx->pending)) {
+			writel(cs_ctx->pending, cs->regs + CPTRA_SHA_DATAIN);
+			cs_ctx->pending = 0;
+			cs_ctx->pending_len = 0;
 		}
-
-		din_be <<= 8;
-		din_be |= p8[i];
 	}
 
-	if (i % sizeof(din_be))
-		din_be <<= (8 * (sizeof(din_be) - (i % sizeof(din_be))));
+	return 0;
+}
 
-	writel(din_be, cs->regs + CPTRA_SHA_DATAIN);
+static int cptra_sha_abort(struct udevice *dev, void *ctx)
+{
+	struct cptra_sha *cs = dev_get_priv(dev);
+
+	writel(CPTRA_SHA_CTRL_ZEROIZE, cs->regs + CPTRA_SHA_CTRL);
+	writel(0x1, cs->regs + CPTRA_SHA_LOCK);
+	free(ctx);
 
 	return 0;
 }
@@ -143,6 +158,16 @@ static int cptra_sha_finish(struct udevice *dev, void *ctx, void *obuf)
 	cs = dev_get_priv(dev);
 	cs_ctx = (struct cptra_sha_ctx *)ctx;
 
+	if (cs_ctx->pending_len) {
+		/* Only the final word may contain bytes beyond DLEN. */
+		writel(cs_ctx->pending << (8 * (sizeof(cs_ctx->pending) -
+					       cs_ctx->pending_len)),
+		       cs->regs + CPTRA_SHA_DATAIN);
+	} else if (!readl(cs->regs + CPTRA_SHA_DLEN)) {
+		/* An empty stream still needs a DATAIN write to leave idle. */
+		writel(0, cs->regs + CPTRA_SHA_DATAIN);
+	}
+
 	/* trigger SHA calculation */
 	writel(0x1, cs->regs + CPTRA_SHA_EXEC);
 
@@ -158,12 +183,7 @@ static int cptra_sha_finish(struct udevice *dev, void *ctx, void *obuf)
 	for (i = 0; i < (cs_ctx->dgst_len / sizeof(*p32)); ++i, p32++)
 		*p32 = be32_to_cpu(readl(cs->regs + CPTRA_SHA_DIGEST(i)));
 
-	/* release CPTRA SHA lock */
-	writel(0x1, cs->regs + CPTRA_SHA_LOCK);
-
-	free(cs_ctx);
-
-	return 0;
+	return cptra_sha_abort(dev, ctx);
 }
 
 static int cptra_sha_digest_wd(struct udevice *dev, enum HASH_ALGO algo,
@@ -189,16 +209,20 @@ static int cptra_sha_digest_wd(struct udevice *dev, enum HASH_ALGO algo,
 				chunk = chunk_sz;
 
 			rc = cptra_sha_update(dev, ctx, cur, chunk);
-			if (rc)
+			if (rc) {
+				cptra_sha_abort(dev, ctx);
 				return rc;
+			}
 
 			cur += chunk;
 			schedule();
 		}
 	} else {
 		rc = cptra_sha_update(dev, ctx, ibuf, ilen);
-		if (rc)
+		if (rc) {
+			cptra_sha_abort(dev, ctx);
 			return rc;
+		}
 	}
 
 	rc = cptra_sha_finish(dev, ctx, obuf);

-- 
2.53.0

