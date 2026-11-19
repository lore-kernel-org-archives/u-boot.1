Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A9A606A324
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 18:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=auxsbkIQ;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=ca53yBS5
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D01AF60D53;
	Thu, 19 Nov 2026 18:11:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tN7UjVSCpvF8; Thu, 19 Nov 2026 18:11:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1EA4B60D5C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795111860;
	b=Xo+GP42NnRA1rccjTilHuu2hF3NzzokkjpypzvjYAuq7TFYg4zCL2ZGf5q4nrJIPyPP2
	 XQQBoogiwvd5sjX9++j0wzT1iLv/aQGXhHGbt7p4+xo/Nu0trXbvFvjfMa3wZ+a5Hwzkg
	 SYTHE+sisRUeWjwznBFFLnB/vNYl/vlBaVBsdOqEPMEGVj5GYwqtbwlMAHAQF03a2gSRe
	 E6GRzNDAYHnXc7v2ANURULs7BYcaDVnVutZXw9Fq77dvWYwekpNtB5XhdfZWVQdW3X0sG
	 gFaloCpMV4Gnz3Vtc9yd9sDwU03hX6dxJ51dIujZSNplJoCYmGM6I9EAf6gAIkgowSQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795111860;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=WDf6AWFKO2MD62Lv/xUgV79nlDXOUucm3wgepSdJt9s=;
	b=AnhwqaFt+PtLva3uccSXm3s0oP6D61zX1aff3DeR9IPvJSVCGKOl/HpWU5hjLR+Qg8CF
	 M+bc9NKaMnB5RHdyKvdvOfRjkWXN1T/01Yj21Nvg1RiE6GekqA1gBt9cfTnFsoe15rYgE
	 CtmSi1MPQAw1TxptqcumedQOu0j3t2Zi2ySD1Y31DjOH8lqFgyepPsoZokm4n+tDf7CKW
	 1abHTUno4uFk1JYhK9tdBfg70qArJf4jAMoV6jNvLhVcAnOpWOQ9zbBjd4IMomhXb+DLJ
	 1t5w0S/PKuK+Hr5P2T7z/uzmzrqouUhHwLA6GL/YrdkbVK/a4rg5twqhHAig7iqILxg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795111860;
	bh=WDf6AWFKO2MD62Lv/xUgV79nlDXOUucm3wgepSdJt9s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=auxsbkIQVVdr3uyfTSvjCrVIZJGchTXtxPYzy/K1Q5HNJIbAbONmH3DN3eYitCDMj
	 E8EDNmIyc7YKAG3IHZSFBIXi9A/dJEyZLB05w29OnGtjkY3DV42evYxmg340oAb07W
	 hkFeuYa6NB7VZh3OP620sheuf5D57jN9PRbys6XpDq9LLTtFSZPy2TXYU5sgHFsQzX
	 NC16IlKw/3jl7a+/rBavO3jefCa7eHvAw07IbPLvdgU2Lb8cNddhfPYT56VvEfN1be
	 HpPaYEW4AAgMcYEL45e1ImHFBekXdjlzVkpqYoQS6xd5aWTPfAZEvtPrUKnVJOcTan
	 YpahrouJ8fcoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1EA4B60D5C;
	Thu, 19 Nov 2026 18:11:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 412B32FB
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 18:10:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 323958148D
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 18:10:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tWEHyH5firnN for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 18:10:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7158D8149C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c31"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c31; helo=mail-oo1-xc31.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ca53yBS5
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7158D8149C
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 18:10:58 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-6df7f544919so11914eaf.1
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 10:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795111857; x=1795716657;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WDf6AWFKO2MD62Lv/xUgV79nlDXOUucm3wgepSdJt9s=;
 b=ca53yBS5zz5zjk15QQPv8S9BY3s4b+K62sUoXSbr4/cBZ9y5BNd7fEZfP8vPw1gW1u
 7fBLPQdJ3e9XfDebWoP6jZfIKeLgV+Iy663a88IhKaOJez7mrC5q6TP93VI5kqY7XA7f
 YqBCR3tPjb1wpdSlr3L3chWVPmnvJyQJY8Nj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795111857; x=1795716657;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WDf6AWFKO2MD62Lv/xUgV79nlDXOUucm3wgepSdJt9s=;
 b=nmHuvd/dp70CnN64amPBMVSU/1kYoTccGHER0djrlY9oioJidF8kZCUnQdB8tQxnbW
 SeEaq86ophh/UOBvJBnvHkSZogb9LLlMqSADGlzNUoe+/C+hg6fhDFjYk/8qV6HXs03C
 a6Ok/sPsVrJz193z/5BpshJsHiFC+DICc5MRKw0GQ0WBse1VYpmHnew3xBLVW8Oq+ghY
 ie7klXJbKSGLGhupVov3xF8VzjdGmy5CBFfBELfj4UJ/WZULt6yXCP0XbStHxYeSYfTb
 ZQpxsyCfLCOP+JJmeL/bSKj/yGo7fVpog6pcGI/cGPoKtJHnINjphf3l4yNz2e+rps0T
 YQrA==
X-Gm-Message-State: APuU4Z8+aARNCt+g9Tpc/4PRkaHEU8EVBmIMfEDCg988tlqaHw6ntNAo
 sp/2NmZEzs8VSwkQPNcyyOGMf7o4IjgL9Kevab9iwrDkK2VqGG6Bn59s4xVgQUTHqCTxrkWuaOt
 xeDMieS8wfA==
X-Gm-Gg: AYBFou38eqQPf8vE8fErnkeHfMtV83KesudsEuwHK82L5j59/iHRI91laTEhLJsdgPZ
 fn7om82DJqFvSCM0db3T8txeO0YEJbF9J38+cFEGc6854fTuTzLVtwx0QibaRDOWKgLU4ndDfG/
 4jKLhoa2YPNkhulSjapAegqCr8q/PABZTQP0e2bAAQR0JpC1UPMEG+TXUmBd6lnYoVxpEqTynYn
 gQ73nF506DJj546Zyx16UmYPqZEBekd5yBePiozFQLYUcEff8ckRujaFNCmj64CsZvkUkh6aO/c
 edar9Qs7/vvTocMKAId0cw1O05LP5vjT+YqZo1cbDGoOTkQpm/FRm2MFE9XoUcRauo5YkMtWKJ5
 cvhfLnXI1ZzxDdQs2MSOdOq4XnNVQOQYjc7cKke6N3oc99nz383QxETutbsVEmC5uhXxE7vnUQj
 l3RPrnwHg/lazlY05BApcmUSovexyWe3bmSxlkpS3/8A5ZufscrzcqNRbOnQS7uBOcANUI2tCw+
 LfVOQLy8EVjgyO+5PepkiBNviOEH/D1n57o7lCJmikQL8iypVKWL69cNi5EMAWtENmvwV3uRmsR
 KORGzh/JcQNhZSbyuu/39I+GLdHPIA93tni+zFscMO3MntwtXZ6awYybcPSKUC2kfiK1vo6q2fa
 jzst/1jhLw+WyT+6N6F2QWJcC6h49/3aLv2/JiLlwaTgD7AiJN12wYxIfQBpPZBPAA78DlOdcIY
 fAjxn2KFnxvBxB9NK6Lu1exMT166+lHQ==
X-Received: by 2002:a05:6820:7092:10b0:716:bb4f:9d1c with SMTP id
 006d021491bc7-71b39559ce8mr283851eaf.70.1795111857262; 
 Thu, 19 Nov 2026 10:10:57 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-863168bdba0sm213594a34.7.2026.11.19.10.10.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 10:10:56 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Daniel Schultz <d.schultz@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, Anshul Dalal <anshuld@ti.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Simon Glass <sjg@chromium.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Julien Panis <jpanis@baylibre.com>, 
 Jacob Parker <jparker@basepowercompany.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20261104-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v4-0-e211cba9f3ea@baylibre.com>
References: <20261104-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v4-0-e211cba9f3ea@baylibre.com>
Subject: Re: [PATCH v4 0/7] K3: wait for TIFS init before CTRL_MMR unlock
Message-Id: <179511185598.565509.6978933201884902436.b4-ty@b4>
Date: Thu, 19 Nov 2026 12:10:55 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 04 Nov 2026 11:58:18 +0100, Markus Schneider-Pargmann wrote:

> this series uses a TIFS barrier before doing the ctrl_mmr_unlock(). This
> specific implementation works for the platforms where TIFS is already
> running at this point. Note that other K3 platforms may have the same
> problem, but for these this implementation is not straight forward.
> 
> This series is only tested on am625 HS-SE. I don't have any other HS-SE
> boards.
> 
> [...]

Applied to u-boot/main, thanks!

[1/7] event: Split EVENT and SPL_EVENT sections
      commit: b184d943ff87e51db08c953ae2cc9e74067300da
[2/7] arm: mach-k3: common: add helper to wait for TIFS initialization
      commit: c862b8d175c0c65b722b12f4a9fae5074dc78f2f
[3/7] dm: core: Add SPL_DM_EVENT
      commit: f4a141de0ece6bb4d029b7c1354720de0fcd34c0
[4/7] arm: mach-k3: am625: Wait for TIFS initialization
      commit: 5478c0e03eb6f22b1a5a9830c63cde6b3c2aacdf
[5/7] arm: mach-k3: am62a7: Wait for TIFS initialization
      commit: 433c46331b89c91cbb9edbc144009afdc77adaa7
[6/7] arm: mach-k3: am62p5: Wait for TIFS initialization
      commit: a308df61da5d2b08bab780773039aa62e247632a
[7/7] arm: mach-k3: j722s: Wait for TIFS initialization
      commit: 0aba4757e04bb103db677a881214bfb5bfe5e7cc
-- 
Tom


