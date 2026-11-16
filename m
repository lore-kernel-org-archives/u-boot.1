Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A89C606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 14:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oisMxvie;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Ks9ncwHQ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3880D80D7B;
	Mon, 16 Nov 2026 14:54:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YZeDzuykHFpD; Mon, 16 Nov 2026 14:54:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7032B80D83
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794840892;
	b=fM8g9wbyId3oNlbypFIiRtsAV8HtTJLTsPsCpzoum4dVcm66K+vg7DtIVuXc3y2E8Gge
	 2zJA86QvpLWeDIaAo4Ia426elg1lLlMPW86TjkyjE6Mg913ikFWWDzS+oVhzxlMiQAvbu
	 7tHGgWpf2Xp8AyThRhedl9BTNkug4ThZsPaYBOCHr95fQNTrXS+rS7Jrnl9zAknaMLrtX
	 XI0TEEovkCaEe8KLwZDPQCY8wDOhyiCDaXeVrJ4Tjbxr/I10ZQ0ffZAby6sm5xmNxnfeL
	 B7a6sB3yPlzIHV72dkMSRup3r56F6Nin+uEMKUdM3zjKh4RCygPl2r53n9fUsQIadig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794840892;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=4N+MjYtT/X1OPQsuTZJ2700MTsEGY+XAXRAqOMRhkZY=;
	b=aGCpjRWrzKYwDzkMRjazUdl4ryqXvxqbdNvRwkKSjBKOUbATrpVPIicCgRyzmKH7uZiL
	 GWuCH+5WjgVvtuebjbHMYUQpJMG31K1nhBp5D2bToJDqylAhtvMSyLwS6HB92pSIFj16U
	 mJfhkDuy4i0tJmj3rUrApcmVl73dRUdL44Bxroy3+0ZAPSO8mc+4VpX0oB4ZSe25Hty56
	 odNUjOfNNDXQ8iXEXNeV8apaYKmqe3ARixmeXd184HYeBHzfNRmvSqer+dERZLdfUvVU2
	 6EeBPz72mbuMADOIjMqqEMV8rowys/0A0vJ+6DHOGsK4mr99g38CDwasO01GmTXMb5A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794840892;
	bh=4N+MjYtT/X1OPQsuTZJ2700MTsEGY+XAXRAqOMRhkZY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oisMxvie4RHAOB55BYAS3LtqDJqwMfF84nVeP2WHIZBFcLT/ND1kOSTqx5H9DNbmE
	 GtzwEdATrKWTXbL6x7zUwBBOYnrtQxiEswj3dUoxfWyVFUEKtzdsklkJfa0F/l5sTd
	 /SWdsVCh0v7L3uHghieZD2n3dvzM6wI2OmWCWNpo0GUvxxm1ze2moNpBqVkIBxR5Oa
	 Xl3SWz2Xhlrw3CaHzrFuuWdN6GELNsRyS014fkeqgCkOpjWsRvhbAOO+02ngHDeL/S
	 ZYNm65ky6ZBhfEbviqwgjmoLMPbRijFmwFpg+A4zF5gGJ3fDsKtuNE0Ls22wtuYAT6
	 yQSvUw32CdiHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7032B80D83;
	Mon, 16 Nov 2026 14:54:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2812B4DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:54:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0B16540722
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:54:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yqMhQmt_n4oh for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 14:54:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5180140733
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2f; helo=mail-oo1-xc2f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Ks9ncwHQ
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5180140733
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:54:50 +0000 (UTC)
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-71ad1db7e31so1045356eaf.1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 06:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794840889; x=1795445689;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4N+MjYtT/X1OPQsuTZJ2700MTsEGY+XAXRAqOMRhkZY=;
 b=Ks9ncwHQkiO4XaiNuSZ54wKhMuJ7UX5OCoaOUmyxTzYynN+MU2Fw4yGovMEGNbCZlg
 L8ddPRccTLUUEtT84AsNgRr46ff1bCrLZoU0XHgcOn5YDii5j5pj8BajIzr3XGMkXXxY
 bfS2d5tgNU6lGf5Iyao5LI3XVvEMUNaxt3XBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794840889; x=1795445689;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4N+MjYtT/X1OPQsuTZJ2700MTsEGY+XAXRAqOMRhkZY=;
 b=kGD794R4fnj/8wqsDji9XqzIQwQEICjr9JKKIxQxNu17rRiEhQuUmaG2X0fIybbm9c
 7Oz5Xb6VL02/DC5I9GKsFgOgQn8SlZepjTmNSbQTWtj59YRUNOSJG0B+Xw/lNiFg28nP
 0LsnLVJnblbUXqCCtRqpdpftdmn4vRC/dBPwP2m7liSydhpcCBNGztZ+jVbBM7SdzFEq
 LibE4YTQcoSd6HNu75WDO4bTwj9XN62oL+JtpGh3e5am37/FzcziKfRfXPG432T3w1Gp
 V2yVj9bBVRsAjtQ4nOTO0wWkeRaJHrAzDjEbWjSKmCFpv+IbIZ1egIzddXGyEN07CRfO
 WuEQ==
X-Gm-Message-State: APuU4Z/akXsEC7omZs33BKSOCUCXU8p2k2QHOpsFbhm3qsKbBeBLqwri
 llHyGekkvkaHLS+/raEE9pZ0fqFVXxgGyIzVuhj4i95qN1GaAbRF3XdowNOpgYhUFyKwjDdILJd
 Q3t8abCCCDA==
X-Gm-Gg: AYBFou2hbrrx1PPedF+4z6nILFoZJkRxW+HVPVJqj8zraONDUY57J/B9qodkPOOdyKw
 8lPlLPc/dn7FustxxdmmjRPw0m87Ae/+/0541m4cta1WcDjhRvbVf9H1oBlRwH31L3W6pdRQkYS
 UzSnmXUJThNMHHWAdVZT0lSs2lBE+z3cfdLhD2CluNTUPhbjdStn58x1mwgar7DzAqZxRf9Vv5M
 loHeR4NpLhUDS35eXFpoiUQ3HKP/Jl/CMwfserFRIEGGZLvGMQhB6iTR/tj5rEN/1qfV0GHFneI
 PcdOgYxeFGt8x0GcK97YZc7NFr0NryATvXWPOiSygDU2nmB6ph3qjLhDXhwlSgt5GjYvipEicUJ
 gsJ0OdUlE2p+ziePnLrOvWl4La3EDLfl3qaXCUVd/pJWU+qT3EkpV1L5ZBdN7TQkYOfA4NSLFBf
 GyrcDCk5hbjk91R3QRLDPVzR2tQ9ToQ9ov9kIoBZZ/5lYl3Msqypp6FctfVF7I/TCen0+BiJwZ5
 0f7yGd3SvSkTjInye1K4/epf9Nu6pZ7Dvw05TdLcqIeG8XG4YXBIl6cYdaWPEyvlxwPw2PhfboO
 0Euf36ydO/wMQ7HPWcRZI71toY+dpSs2pxOrVFUT1ko18Gjiwka8p1bDkNWuOtkBvwppgE7kC3E
 mmRPH2tPUZgiogPq2ydAbCnI3ItRpdzOuKftYHCUVkxGD+WezLmYkwwvjtConFEMVa9Ap5v41wy
 cFEkRkidJiXcvSVlg/e1UGPuEph38c6g==
X-Received: by 2002:a05:6820:1343:b0:71a:e696:71ba with SMTP id
 006d021491bc7-71ae69675c8mr2803930eaf.19.1794840889033; 
 Mon, 16 Nov 2026 06:54:49 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71ae6868fc2sm4482988eaf.2.2026.11.16.06.54.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 06:54:48 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Anshul Dalal <anshuld@ti.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Sam Day <me@samcday.com>
In-Reply-To: <20261028121313.814-1-pepe.schlehofer@gmail.com>
References: <20261028121313.814-1-pepe.schlehofer@gmail.com>
Subject: Re: [PATCH v2 0/5] arm: Make the LTO conditions in
 arch/arm/config.mk take effect
Message-Id: <179484088721.2109674.1641747976070215997.b4-ty@konsulko.com>
Date: Mon, 16 Nov 2026 08:54:47 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 28 Oct 2026 13:13:08 +0100, Josef Schlehofer wrote:

> As requested in the mpc85xx LTO review [1], this sets LTO_ENABLE before
> arch/arm/config.mk is read, so that 32-bit ARM LTO builds of U-Boot
> proper leave out -ffunction-sections -fdata-sections.
> 
> v1 broke the K3 R5 link [2]. Patch 1 fixes the dangling reference in
> arch/arm/lib/cache-cp15.c that the missing -ffunction-sections exposed.
> Patch 2 keeps both flags on ARM64, where U-Boot proper would otherwise
> grow on 104 of 105 boards, by up to 30240 bytes on i.MX8M. Patch 3 keeps
> them with SKIP_RELOCATE_CODE, whose data relocation does not expect
> section anchors. Patch 4 keeps --gc-sections, without which 32-bit
> U-Boot proper would be 2080 to 10832 bytes larger.
> 
> [...]

Applied to u-boot/next, thanks!

[1/5] arm: cache-cp15: Do not reference the MMU helper without an MMU
      commit: da83c61a114901d2b64935d3e05323b2cf271637
[2/5] arm: Keep -ffunction-sections -fdata-sections with LTO on ARM64
      commit: 7a3fc96a8ba005b52381dada33c8d40ed0edbe5e
[3/5] arm: Keep the section flags with LTO and SKIP_RELOCATE_CODE
      commit: f0a83474bb63c5394922e46d1e245193e47dbd5a
[4/5] arm: Keep --gc-sections with LTO
      commit: 2aa7d3d7b5aa3afa74e66c01cc7c76f538729c84
[5/5] Makefile: Set LTO_ENABLE before including config.mk
      commit: 5f3bcac3f7f94e447191bd3945b9a7ea964d336a
-- 
Tom


