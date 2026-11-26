Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682FD606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 14:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZCW9plS0;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=rn9GfWO1
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 37E1760AD0;
	Thu, 26 Nov 2026 14:44:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 08raWhZDB8lR; Thu, 26 Nov 2026 14:44:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5835E60A9A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795704261;
	b=qAjuMqKEnIL1ky4ROzUAawBUODSd5xfiE0We1+4PsxmLyo20kUo531vLHMY7VPaHfTEf
	 uYiEPqU8QCRsDbZR2mLibz7rTwqBfngSxDYWOO4+gRKS/1TrnVmnWt4Pe92yS9B0IYf2y
	 Zwmhe+HnerRaNTbBWF7n4241rijtK1KFy/07Oeot+vHnzx1Ii3o8BjeKjtgDm6NSsMa0p
	 YAi0pjLApQQdlbpYxIGLmcVwNfy347S0oav05t23uhMDat+tV/nMiMxMRbumHt66y76Sj
	 XtH12FujESRTVuVI9Bm1KsAkRGnshDJKKfSWmmTVrzNlUtvSzj+CEYN91rwWLVDPRMA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795704261;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=WT6FzQmCL8zE0sCWogRqChhT/2wquP1b+nWWzjyzV5Q=;
	b=V+lcvk8BJprvoUoUWDfsoY7NqR48yUziapnmAWTAIJ+SOQZkbz3NIcq6jnY4JC4XFBTn
	 3VOS3Qz67/KadO0eFKbxhzxX8bzQXGP5IWowCyAVq01Jt9DLvm7ECAEIsqBfSi27EMApJ
	 IXPcQc7JKRHhTRXrzos0DS3P2iVm2WKJm3u/uYWKIK6BXcOdtV+aDc3eBxt1GDt13jkcr
	 dDPHOm2OuRNkn3iqN8axud4lw4bqeaaiNZAtxalYoCGDTtUQeSlYQLz/sCxvw8IRv8G9a
	 L0PiUjU25/7KV2+K+zApP+7ykT8IEVV/gbywfkX2pSqftNdIL4C2wjRn8f0pM+IJrxw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795704261;
	bh=WT6FzQmCL8zE0sCWogRqChhT/2wquP1b+nWWzjyzV5Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZCW9plS0MuuUQ7UJb8Vd05lf0cQLxkk+Zp72JpdPcWVQQ7GLTzPzOP5FoqCZvi9mU
	 +fwO/51a4KlQeyHqz5qyqyWNOG3RKT+ru0izh95ZSm5YuruQWHMkgewkH6/y11sR2f
	 cbj5JVBNWCb5SkXqmuiaVPUMDy2MyUUEPC7cRtF0exbcviRnbyK9yukrSuKmF9lYwN
	 R4zc+e61ADE6jVqF6dGhnq4b69DjKqYjdncO5mqN/9/GlPA/clnJMNhpuFX62sMTq9
	 +nMf39yfjQ2IBM4D+FFOfqIhj4WVYIu4+3jUcjYaRcOvgJidcYdIypi4SmC/pZag2K
	 8jWoOtIYeGu+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5835E60A9A;
	Thu, 26 Nov 2026 14:44:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E4E18325
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:44:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D69EA81185
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:44:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h6iIK1DxJvaJ for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 14:44:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F02AB81184
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c36; helo=mail-oo1-xc36.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=rn9GfWO1
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F02AB81184
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:44:15 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-6b8e2d8df4fso4172663eaf.1
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795704254; x=1796309054;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WT6FzQmCL8zE0sCWogRqChhT/2wquP1b+nWWzjyzV5Q=;
 b=rn9GfWO1zrIZF6c7CUb8iCWrUeC4UMhbGGo0S1zZhOb7cj0dwVL/KOeMWbQZ0xmDpg
 vh8dgOpzu7TP1isg/FnVWFFrj/dxpyry8gO1htxsZxBWLlJR7mbjKMTr3QUN1hXzC2Ih
 DzAIiB3oSo0NULzt5vQUraSOU1ITP24CJr0sE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795704254; x=1796309054;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WT6FzQmCL8zE0sCWogRqChhT/2wquP1b+nWWzjyzV5Q=;
 b=T6fKu4kmd4kF4ME8rjO80p6D0UOrCSzKxDs2Rt+M8qNsspTN2u9/qnPsyK0xjEw6h0
 qAvFED99pOO0/FYlOE+4FK2ow2Oqtrj0zf97MLDDTCJS24deq67ao3OIsiO4h4kjZsVz
 P4F2U1+mmvxh63cCc8dkZZErcr9O2tPD2BqJYPrTtJBe9oVdFGrJSaNblqmZuVcpp6Mp
 PSDzRSvXonmVL/+Xsg+QJCsJpre+Gds62OCRN6KkVs5dokQBzsVInaAZ7VnLVxpZxfG7
 rSC9k8n7SMifX9MKrN+5rBYYHOryo/nvN4K6KYLZjKihKi+72kWZG8xdr4JiD/1Za0TV
 Ak8w==
X-Gm-Message-State: APuU4Z8GO72Oton2qmo7TSEG6d7OqPv1qJgGiI0WCcNrEhw4mUHvYiSq
 GhR5fFzqqcY47I/miF5aTBIvRgYHx0A7jJ44H5ccDbn/IfBv4NPILFi8aErUyjusxVQ=
X-Gm-Gg: AZFdTZfcEwpEw+LtfB/0pg9x9eh3qlIpSvM9X3q9IQxdgKBbNy0UxE53BMLR36QiR3T
 lwP5iICwBMbkH9VM1ETUg+KMwYumitQEE4GM0iatSCxQ+b3b7F/zLJgyuKe4URSwPEs3SOT7CnG
 /RNBKyhIHaqN+Cmazd3yMQSI8aKcCMop6bbn4y08fGh1PSi2L8ISa1jrsh2fq1FPIM+JEdzL1Xs
 wr+XpIHDqdrI1IvCvwHaJaSoJE2fjMrt0xK5bz1Xd0elwippQtr7UMoclcmK2GyOYlyKyGJCfNA
 heHIzCTIvhknMlG21Um606Go0CranyeDfOZUY+lWjtPF76AtXBZJ4AR/TmXQHOY1D399Y1tJU3t
 rdqGazV1LKKhD8ge0kp0vv85H6Daz5WDQTE4S1nEmEECzOo/vRhL8jN9YZ+Jpmz8lmWlEPGiAiE
 9c3X0q4fCEj1P3Yw/GZHTpFeEbJ0MXqsuviEkvXZiQ9NxPLpSf1RUB6sm6dnRYsvlvV9L4EjR2T
 RWOJTFXOwQvJUujqptrw0m2TeyrSaYUCmxFFEHgHGrc4NqvtAdeV5tBnnCLZm4zPPnl4z40oiNv
 Jor/ttKN26d2UzH9n0XrA+WdE7ChR4dv8i6Gz/X8AMrir87u9ubWVQ4eiOJVE71qzQrQFSVmeU8
 ls3Ivx55ANiNgIX0/wMNtFL77Yu3sK5HyPwfFUgi23BVK4OcX7+oDAIewJS3u0kuIChBQI6EFHL
 pqQh0DoFDof0qB1L6YTWf8Hq84aTeXiy4rEbY1Cy84f/k91tjj6ro=
X-Received: by 2002:a05:6820:83c5:10b0:6f8:2346:cd8e with SMTP id
 006d021491bc7-71b395b82d5mr12111105eaf.80.1795704254554; 
 Thu, 26 Nov 2026 06:44:14 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bc5ebdc0bbsm18198036fac.6.2026.11.26.06.44.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 06:44:14 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Marek Vasut <marex@nabladev.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, 
 Mehmet Fide <mehmet.fide@screeningeagle.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Stefan Eichenberger <stefan.eichenberger@toradex.com>, 
 Markus Niebel <Markus.Niebel@ew.tq-group.com>, 
 Sergio Prado <sergio.prado@e-labworks.com>, 
 Martin Schmiedel <Martin.Schmiedel@tq-group.com>, 
 Thorsten Schmelzer <t.schmelzer@phytec.de>, 
 Antoine Gouby <antoine.gouby@toradex.com>
In-Reply-To: <20261125205038.36398-1-festevam@gmail.com>
References: <20261125205038.36398-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-next-20261125
Message-Id: <179570425316.3223933.3262750469523139105.b4-ty@konsulko.com>
Date: Thu, 26 Nov 2026 08:44:13 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 25 Nov 2026 17:50:38 -0300, Fabio Estevam wrote:

> The following changes since commit a1ce46a6689641dd83d725edbfc3f5719abf3a94:
> 
>   Merge tag 'net-next-20261123' of https://git.u-boot-project.org/u-boot/custodians/u-boot-net into next (2026-11-24 10:45:40 -0600)
> 
> are available in the Git repository at:
> 
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-next-20261125
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


