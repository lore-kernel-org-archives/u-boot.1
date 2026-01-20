Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABCACA5FB8
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 18:08:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 080D78313B;
	Tue, 20 Jan 2026 19:08:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iLd2/oZH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0492D8063E; Tue, 20 Jan 2026 19:08:20 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7FB98063E
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 19:08:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-45c7f3a9676so51746b6e.1
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 10:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768932492; x=1769537292; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kDL5nJzi3HGVxclP8U5jZpjTVvjMivdvfdq3vEqBopw=;
 b=iLd2/oZHY2X5TRV1Yec2oTiCnSXGc0/Dbl0a6Vl5zo+GG0Yc8UnTBIDBG+Y2upk/TX
 w0IJTBhaexSu9HAXE4h4RdxGyzoQHq1PtV2F7+bq2haSe17jl7Eg28v2SeborrfccFjc
 3h2oX3xrfiQFpX0mndpy81VmEUu/oixzziUhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768932492; x=1769537292;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kDL5nJzi3HGVxclP8U5jZpjTVvjMivdvfdq3vEqBopw=;
 b=HixeYZnNwO9auWWFSJTDQoyqc04KsuKYkUrnP4xSTmtG+dIfjSHAvHghbpn7K0pYtV
 fCFO6YjEhRUXr7K0JC94yHM9sEz3uCwMiDFoMnur5OvrcclpBry1u4zEwCn78IZiXf/q
 OI4IcPk8WYNY8t0HeqpUkrtLenDxo/rugkd9l7mvNn+fPdj0z4W2oucyABtKd8m/mpLk
 zMqvwUbTBfGsu/WAUkpgHDqzeN6tEsetsUsHLXc52mufcVufuu2W7SAYkJq8YR9tlnVr
 zYM30uqizNfSfpEQz2iR2EjvMsOxFbbVgrQiMOyjcJv37Vjd14S2U/pyqHMcqRFmgZN1
 c5dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXr4jzr+N9B07Bfh9m3z9RjAOsu22EpP8IZiJ5GetOwuIlav/QtU26T3Dl9Vn3p75o1s7dYiAk=@lists.denx.de
X-Gm-Message-State: AOJu0YxAUZNk7qXLC7GnIAMaNUJpzK7QcNc3mBWQ3v3MbUTJUq1YWjZa
 0Im58c/eFE8mbya/5schQzYI5wj1pjPiBrn1nVWWbnZ2Wf1+NqnnNtOuLJyQE9ZCr2Y=
X-Gm-Gg: AY/fxX4uvDDq9BT1piIt7cQVaUnbAJK3gPzn08Ug9mxrTnY8RiKCmZovhIEB86Pi6bA
 ORTYklq+WMk2M4UPQpQ7qJ5cFsZWyBUBR24kE5WU/0Dw0F0fIGJjL70tjji2tASFgNbtqGMN6vI
 ebE+1hX6wKNcvJrR5palbTkeaNQupeLmHbI/C0C+zLAuhF43yKHUj9QTUf4g8rJnSPcM15OOvZp
 4DYvrCMCUa76Mrg6OOtoFJvOETBc3C7BK3gfYS5/MsCQ8Wo4tLWiNZQG3DoSX4xPszoZR/mbc/Q
 y9xOf+NdcZfiI41ty4i+poD6JK9Ai5pusupzDGfGKjrklj1POsk2UjRLasXwMaIav2gHeG9xT0f
 XxUVn2dBXtLVW3HC9RVUrG9ZVAKuHF49GTwsj1TrTQRkOuPgBFpaVlEQpvZvn3r8ssAMzJl093V
 PGzRbHJORMuNqo8oqmMeaSUdmwo4zaARP59531nK1Lbe7mtM19OkxL2mFnZ8fUAVyzn+t9oxw1n
 1p2v8P9YlGlN/SNw4IJcvEe7p6lBvgVsd43i7hfFgy85RJK
X-Received: by 2002:a05:6808:1a0e:b0:45c:70f2:7287 with SMTP id
 5614622812f47-45c9c70c07amr6716043b6e.6.1768932492568; 
 Tue, 20 Jan 2026 10:08:12 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45c9defa8b3sm7364048b6e.7.2026.01.20.10.08.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 10:08:12 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Beleswar Padhi <b-padhi@ti.com>
Cc: ilias.apalodimas@linaro.org, malysagreg@gmail.com, 
 sughosh.ganu@linaro.org, philip.molloy@analog.com, 
 marek.vasut+renesas@mailbox.org, james.hilliard1@gmail.com, anshuld@ti.com, 
 afd@ti.com, nm@ti.com, vigneshr@ti.com, n-francis@ti.com, u-kumar1@ti.com, 
 u-boot@lists.denx.de
In-Reply-To: <20260112101102.1417970-1-b-padhi@ti.com>
References: <20260112101102.1417970-1-b-padhi@ti.com>
Subject: Re: (subset) [PATCH v2 0/2] Fix TI DTB alignment issues with
 recent libfdt update
Message-Id: <176893249134.434728.8367968681985080625.b4-ty@konsulko.com>
Date: Tue, 20 Jan 2026 12:08:11 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Mon, 12 Jan 2026 15:41:00 +0530, Beleswar Padhi wrote:

> Recent libfdt updates (commit 0535e46d55d7 "scripts/dtc: Update to
> upstream version v1.7.2-35-g52f07dcca47c") enforce strict 8-byte
> alignment for device tree blobs, as required by the device tree
> specification. This causes failures on platforms using
> CONFIG_SPL_MULTI_DTB_FIT, where DTBs were not properly aligned.
> 
> The alignment issue occurs at two levels:
> 
> [...]

Applied to u-boot/master, thanks!

[2/2] ARM: OMAP2+: Pad SPL binary to 8-byte alignment before DTB
      commit: 85f586035d75132b2b60d5e593e1c0049f5d126a
-- 
Tom


