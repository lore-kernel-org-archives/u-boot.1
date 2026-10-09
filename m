Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD08ACA5FED
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 07:27:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6FF8580F17;
	Fri,  9 Oct 2026 07:27:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xOQB9mffk7qp; Fri,  9 Oct 2026 07:27:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 894DC80970
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791530845;
	b=Th53mcaw9HD+nV5bSEYoz35LjY0KTFZCFq6QRyfGuDJpt4mNTqEc8kOOUZSfGZqrsZIL
	 SKBJMhbiOR+s7/Ct3egULI4AW7+a0rR829qWYKmq/KCKmuk0wW2ksmfgb0OwTurEGy4q4
	 U2PL19Lql//qduYh/23L0NMG4LIH2CX6AkUZ4Tl2CAlZqeJtWek0R45ZqBd396L/RN1yr
	 cwVQj4BEGwzfpRpbwMtCHcnuF7FvX+rh6s4obH8LTFXTFGBw8lKkZAMuCijaPttzx5bxT
	 z9woDVi3zWd7e5W5girsZun+F+h10g5rb2akZYDDBYbrZnH8hq0Kkmtih6pdVLN78tw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791530845;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Kix3p8+de2u7v90IDCckDM1hAZlbR5CaP9ndzDCk5oI=;
	b=rqv1IEI4Evle2zrzFNCcaF7x4d+MFeMFj+rxb3Xk1CNyiZpWdKEJVkx3zjclYwkq7yYu
	 SLkxyU9bASfC1bUz2eICrRxkyhbk60dOfPibdkQJlqwwjP5y7PczAqQTE85/BQmklkfAP
	 hsPd/iW6i8ZHUEKyVSH6vjpFEhH5vlwk1fnBQnshXso9HFv0vP0rw4iOYBcB4GaPdjkFt
	 wgVatRrUMA7HtDN6rNVHU1Vp3eoT+B62UJ6um/9rqB0q+7J/GhEOsiIL9NnD7v7tXNLic
	 UZ9MJ0CegP9pij9j1k5BTUNPuAf4Cz+KmXTaOZ5Pwnz48wQATMCBWYrmcICDZyvxtCw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791530845;
	bh=Kix3p8+de2u7v90IDCckDM1hAZlbR5CaP9ndzDCk5oI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N5DiWUJ6JMcAll6MBGnRdP4qUbRRZjIAod5w3ww8dESjrD9Y9mFgrpvTjOT2UubTc
	 rQEDAgqWPTOpivIAan/ffRNqr9zPF89mnJBUKPngWYCmYppKKhhqbeNceYCO0wx540
	 QZTk4iMcDuJFb7FnEtCjaxIiTFUUl9iGrQl3I1jB3htcqSN08N9ao1j3RNOp5PKgB0
	 s2KLusbdMlvyI1+79Z2qJWRWZS0yYGwhqgoNCjDLuEUsV53QaaabmRYD1F7QI+1Xar
	 VURKvNq/gOegCzJ0ok44FxIACWm+hQ6WFmL10oINU0V2vLupoBdzvK7+Au0R3Dm+0n
	 5J44LA7InVg7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 894DC80970;
	Fri,  9 Oct 2026 07:27:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 65B3F2E0
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:27:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 57C0A402BB
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:27:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dO-s6HA98ZR4 for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 07:27:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9B0BE402BC
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791530843;
 b=lxkc/TDEBLyKkyBWyoLgc+JeAzeeIJ0slKR4lY7FBNiy4+ckh2OTEzenYHyN54RGgBiG
 uaXr118BeRo7s/tTGgBCHAmAC3xJyG/8V+/Rn0Z5+mH2ul1R9jghAGbAWTfu7U73p4pT6
 Hds7/sQ7wc2aCbg4LtgUrx+YPI5nyAlbWTwXpfcPGFopQdEKhdtJWm1MtsA6blVxoPJs+
 J/vNNGDI4MRCXt207asJs/z/QSszUrGDxUdysOibVO1OJqNeuVrWvFYtRNML6G7VQxgHc
 KJBb5M1YEs4RZyHyzlcEczgoGNgqtl1+gqbe6W3MEBdsMN5tKoBlHFYDMWoN4WSRccw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791530843;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=Kix3p8+de2u7v90IDCckDM1hAZlbR5CaP9ndzDCk5oI=;
 b=cTXf+N1anJ3E+36BtaqsSV3Z/gNJWU/vv82IixsYB3qYwf2IJm61laQPJciTIvMPxVFR
 mdxp8mMkcymOa/SyKCFZY1BLqHm8oEQFnETmaEjaKTiDp95nOoxfRhwBceO5M1JhSNEjn
 Z5q/HHLvwUiau8psa/xon/TY++iUUPhjxmPyvzzn0akiRqgV5QjxhvkTx1XXxD+BBgLDz
 tOHZtppyB0FwW0NwjWDb3sOHhk3ZcIfMejiNRJWTqN5lMx6GDGH2xE36/xukRCHpbvB3r
 Zn4mHO33NWa2nMNy51PwUoFScWFdlYN3V+lGmKTnDGPU6tfgHZZBHR04+hIJ+xh7XbA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="BmxSZss/"; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=BmxSZss/
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9B0BE402BC
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:27:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 70D31411C2;
 Fri,  9 Oct 2026 07:27:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248331F000FF;
 Fri,  9 Oct 2026 07:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791530840;
 bh=Kix3p8+de2u7v90IDCckDM1hAZlbR5CaP9ndzDCk5oI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BmxSZss/FVmyDClV/QrpQ3US/iy+TvZN6zji9r7Lf0YsfXQGmUBVfAIBc8t27sJwt
 lKyjYfS81cz3Tiq1gtOmg6wYOt1sUrQ19VnkNK6QADJqkUo51m6ZtnD32hlS/67JdK
 x37EwGeeNrzf2dxU9w2HXMAgXYcBlYBqgjX1QcMzTphAdkcP19Oi/VWDLyKPtA2evh
 KRO7DSiqN/CvoU+ld6qItsssTF8qoGmAJGeCDS3T/bFvhvVJ2bEu/ZOkW8P+zTyKuf
 GWc8Hlx8BPE3d1+ic1VYii9VgQdAOxSSFD6YAufb/7+Qimh0oB+Ny1PZbXUJACADsc
 0yzUnjUrOyWTw==
From: Yixun Lan <dlan@kernel.org>
To: u-boot@lists.u-boot-project.org,
	Yixun Lan <dlan@kernel.org>
Cc: Yao Zi <me@ziyao.cc>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Hiago De Franco <hfranco@baylibre.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>, E Shattow <e@freeshell.de>
Subject: Re: [PATCH v4 0/4] riscv: spacemit: Add support for K3 Pico-ITX board
Date: Fri,  9 Oct 2026 07:27:15 +0000
Message-ID: <179153080875.120012.17314893286028029569.b4-ty@b4>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261007-00-basic-spacemit-k3-v4-0-c44d09937088@kernel.org>
References: <20261007-00-basic-spacemit-k3-v4-0-c44d09937088@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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


On Wed, 07 Oct 2026 05:11:30 +0000, Yixun Lan wrote:
> Add initial support for SpacemiT K3 Pico-ITX board, the config file
> will enable all basic components which make it able to run into U-Boot
> serial console.
> 
> The series actually depend on previous sent patches, I'm not adding
> dependency to this series, but list it here for reference.
> 
> [...]

Applied, thanks!

[1/4] board: spacemit: add SpacemiT K3 Pico-ITX
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/31d3bdb0e37d568e951f6b861999c8e9e7132b40
[2/4] riscv: dts: spacemit: k3: add binman node
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/262a0267b6635eab951c0070229976ba75aedf2d
[3/4] configs: spacemit: Add K3 default configuration
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/d56972c3f331de89e19a4c6d21ea2a53416f84db
[4/4] doc: spacemit: k3: Add Pico-ITX board
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/ee7bd2529853076ca717a5cf61ec232992fdfa58

Best regards,
-- 
Yixun Lan <dlan@kernel.org>
