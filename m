Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4269606A31E
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 19:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hws3Yowq;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=lEyUbEr4
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 71A3640B81;
	Fri, 27 Nov 2026 19:16:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id peEXHyzG8UQD; Fri, 27 Nov 2026 19:16:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A414B40B4B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795806986;
	b=Y7OAlhMnhLYfwi36YTxr075tMCxL3vkOQAj7RYpX/34mrtx2hRRYKVu76M3nszgCUiHG
	 DAn9HFF4lyNV7ZjpFZHBosqSt1eRRS5mUg0GjFZdzwXzwsJ22H2x0aHRG2uv0hqkCL4IU
	 XU2mer8W+GIBOXw7VZrisb5N2cdliNCxnHcJ54B1QAyg1pqTrhHsoBkp0kyQUg1XUqu2m
	 RyLtDhD/iN+V/WYZ3g8s/blDIG71BLSqyDTbzLgwTnVTsofKf0vuF27JtoCijNbidTSXs
	 2FI/+qMgJoKrugn7kiK/tEvlXkCw2Tu7TN+ZtOt5QbvsyooBf7z17aSWgEnpNsP/qTQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795806986;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=G6jMEUI/1oCntzXVyZe5BVV0Z2aEw/QXFttQ6QyZt1E=;
	b=lFdrmE8kN+8L+J8bTYE6Gr1dGtfbnkuBcfe6mnbq82fSrbRLUvlLxlIW/oXgPLer2AgI
	 BeSuOd6AHsQ27Kyt1fPRo9qj25XtCHmxFdyxxY3kdGImW2LzhC9LFWwkscd/53GHDC8c9
	 Z4imWs6RJEbT03qkJtmIhRedXvE9DUB8KUgXHIOpMKB3+cK5gZcfP/ifXk5hzUUrCItRA
	 b4a1GArXQzY0aA6EnHNDICbahXTFl87J9C7jpPBzURqHRF4tktPUwu1zofEFUAJ/kEknL
	 vSq6OOqneluGQUFNsR3zW4dHW4wOvxhVE8YgimFCKw0zCCyHxJ+eq50vzSrfro13szA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795806986;
	bh=G6jMEUI/1oCntzXVyZe5BVV0Z2aEw/QXFttQ6QyZt1E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hws3Yowqtifr12+k+hdbVcYNu1NevrOf5Y6/oWzi+8ZzovO1TW+ZCdx2emwWuv6BY
	 ccjoV1EVLekQhCi5ekwZUhz0GBuDvUop3iGjL5CPMGBRLfz/qdPxd1Y5/YclSaLqK9
	 lN3+lgEsPNUPv7Op202YPczaSeviaEcYFATZ3u42RcB1QDrUv1RAYr2k0H1BzXEwew
	 viQLeo/Z1x5QEOyQt+Qf0yd2gbjjzyg/uqfl9+wCnhmT+VOtLORXvuh58TDengEUN1
	 GlfA88RqD6oLB9X5Oxir4x9jcI0uQX0k/apkuDQ+GduO/EaX+NOWhUro0uqZZKhZfu
	 K5bEHnBVNDR8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A414B40B4B;
	Fri, 27 Nov 2026 19:16:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 44F39373
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 19:16:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 36B5E60D64
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 19:16:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rFcAXyQlNlQZ for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 19:16:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8235D60AA5
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=lEyUbEr4
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8235D60AA5
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 19:16:23 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-86210f31496so4513373a34.2
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 11:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795806983; x=1796411783;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G6jMEUI/1oCntzXVyZe5BVV0Z2aEw/QXFttQ6QyZt1E=;
 b=lEyUbEr4+J7LWG3vB+dfcclEcyPUCmM4V7AerKxqKou5RLoIz5+6sV5YgPjarJVO5c
 rycx9QrxGlHkgSw7FEWmY8F41Fp9ugvALvMDVdznDKkCH/O41yBpHbonLwrOz7QgYKyX
 wyTTYNgtuWtUXLcEHP1O2cqHcWFMA836oG8Nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795806983; x=1796411783;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G6jMEUI/1oCntzXVyZe5BVV0Z2aEw/QXFttQ6QyZt1E=;
 b=05ny1GStyYMxULLF1DmM2BRjcv5AeaI2fBJjCfQQZuxXokTiDCqfp7eYWzCqZHOSaf
 mar764IkHIGxMJ3ELZjpFU3++TnRM6Xt3aEzF2Pz67JNJPyuvGc1/saMVSXsnlkfupSk
 CpXX1cf97Vu+pEKCHP49Nx+Hre/XUQ1CUDbAh0sC938cijsoQ8aK506GpTIl8dhkEBHv
 JVZwolVj5Nzs8EWUuZZ7YBcw7JYMqUlSpD5VEG4ObdpzdGpEHTwIX9ZvG/hXdZLkEb4+
 xIkSwC/HS26suL1cpzJRr0BO5oZe94FOJJwnMbf5MWljvGcKKsTl0ocKfYkSOmzyhWK+
 26nw==
X-Gm-Message-State: APuU4Z9LftLu3XsuR0LfBjoCWfVJLv3p+CKoROtTPWq9sp3uhEnhl0ra
 MM93Kv4d272BBjsKz1fYx3QMbMt4tNb9mKJmQXEvQU+rkJBSucsbJTWPV/2lzHOV8YY=
X-Gm-Gg: AZFdTZc5LwjpxfDiON3CIatXqncxrtTPgKVELpn20QXpZHdEKXxv8MhrBuOQ+byGfgn
 xZiw28fqUE+O5vh5ZHpKGMp3SmQOtMnVsMYycSAKumTKiLweJCoUMS8ATnbw2oLto7LA6HN5hZQ
 HD52FkFiMNcuBXss6h4dyWT1Vc9iXcLieBKkY/wqZat47ya9RMCgkmSBDcvNNeWrth1i2snZDzJ
 t28zPg5ZTzgQm3tcf4faNaPIH8Nac33D7SDVqic7booyuEVvJzdryXjrbufOeWG2JRSadFtH5QZ
 Xm1sD0sWqmMDlY92EIrDFo70jz/6R/LUuy/X5e+RLI8xr5h0ARY+XZgqLUIKuiOdSt9YXsffcY+
 2Bi+dQ0Z5UctO3PnmcuTuPMpUbn7bJ+xQkSdkjTBV+Vab6/o48Ba858iDj1Zng/knPIRJCKDQKK
 sViR7opCQmM3EbEV8M0q098UHe7BCcKE8XRkH6DIkAFsHRH1KsNdOzYJ1o3xiHpKA5D9T7LLjtU
 V/uo5gzYTtTxPQU8R2VC5i5cNuSpSH2YccohlI8h/TYLlP18trxgZ6JRJZ2E1IRBOoPz0l5bef2
 mXyLKTHWKBRNsRtm6uUV5cIfGHJt86sjpsu+jOxYnfdwoh9DDBasqhej/k+bTITTbT3TsyT+8Ge
 aWdRPvlNYIgbTKiD0I2L46jnj1CYilmxuzIbHjJt+7p4a68qA23gu1Kf1J3L5gzWKMbzesdDO05
 bOXwVhGScrGzSJ8XbxiTZ+f86bOOeBUH3TJYHWvX+yiexnkKWdTh8=
X-Received: by 2002:a05:6830:4c18:b0:81f:22fd:6ed5 with SMTP id
 46e09a7af769-863159b9da6mr29260401a34.21.1795806983066; 
 Fri, 27 Nov 2026 11:16:23 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-86385358ca2sm3258789a34.21.2026.11.27.11.16.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 11:16:22 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Ferass El Hafidi <funderscore@nura.eco>
Cc: Michal Simek <michal.simek@amd.com>, Marek Vasut <marex@nabladev.com>
In-Reply-To: <20261127-mailmap-funderscore-v1-1-d76766e2d31b@nura.eco>
References: <20261127-mailmap-funderscore-v1-1-d76766e2d31b@nura.eco>
Subject: Re: [PATCH] .mailmap: update my email address
Message-Id: <179580698228.3581729.13728560428651934407.b4-ty@konsulko.com>
Date: Fri, 27 Nov 2026 13:16:22 -0600
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 27 Nov 2026 15:33:42 +0000, Ferass El Hafidi wrote:

> My @postmarketos.org email address is now an alias to @nura.eco, and will
> be decomissioned in a year.
> 
> 

Applied to u-boot/main, thanks!

[1/1] .mailmap: update my email address
      commit: b857bb6ddb0d8b9862eeffece3260bb39a1ce710
-- 
Tom


