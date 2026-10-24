Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B82E606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 06:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OPgQ5UKX;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Au0M/uGh
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 252796069D;
	Sat, 24 Oct 2026 06:22:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WeWfAwjIiRtH; Sat, 24 Oct 2026 06:22:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 68504608FE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792822978;
	b=hxlqNZd7beRtMY7Qjl2s0JODuvPjSall+xRwgr6WtINggQaX82veJFCEq9hjrYo4u9gY
	 D/IsKwnxfo5tfbijWu0rrVc1bnVgUNcTmBz+i4/X5dl2agLTVXQg3xPcaP1cUHvt+xRUW
	 PUapvKpbwtPL/IvccKbq5ajgKWcenVNReythv/iK1AHHpC33QzpdMvLdfKKcpf0IByg+S
	 A5WMUdDcZBfQPo07U3YeECoybWAd8Jx8LmN2o3KNBpk34L4XGv77jwpEOM3Iac4iAjuuQ
	 40uAhDEFi9bDGlHgiSIFi86SG5Y1FvHCwHu9yrlegMHUhBY0OKT2nXMDwugDuzaLN6w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792822978;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FyuaYBmleO2W5VShFa2ImcAsSQCKG30TG3fl2ntvS6s=;
	b=jEOaCjALgjETFI/slseAno4tSXBnb7u02WEaAOT6w/rUv1NRi9pyh2cVOur214GbWDx4
	 d83q/nexBprAAiVDxXIMVPXo8JV75EK7UwMDWDi3SC0JiH7Iio5W2ZqfBbpH0fbHxVV6R
	 Ea6NgnPkdDs58tQZ3aI9W//pFpGgAbrugNjdwFuTdnS7WrkzHHBVS479ln0b+QgeWztSV
	 gsntAqFiY+ZMM++EbIC2cP76yhF8CZnzbZPHjNQZ18IhsR/u9tBgSAbK0zCsa4RkvKOsE
	 eVPlntXDPDh6QBFSvPhsdelmdPsuw7eqqsI4AzCF85eq1m1g0JBkJPXSlFSjIHwQVTA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="Au0M/uGh";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792822978;
	bh=FyuaYBmleO2W5VShFa2ImcAsSQCKG30TG3fl2ntvS6s=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OPgQ5UKXbZg2s8u3zXpbTD7U46IDaf7x+1+vSoXXvzKXuPOoqNW0fivnPwE/pM9cs
	 5+59Oi3Dlwsmgp7Ph7xug3w4ljkkahJs3aMX714OjvzphvOs3fTjsfjeRhA2RzlD++
	 n7dCQ5bxErLU0t2g7gWjHq8zrSFVkSfuAuQ1E5bhFYbsJSSPbkQEZ3KFVXz7ZW3R28
	 yW5/denkTuK2+ZvlBpIdThsnTuDJIcRg9Af5IihAH6XrQGBLzQ5Bl26sxrI4xX55PZ
	 Z3ju3NpQzuqhPaxLh/4Fwg5d797YL3/rmAYvR2rwCBqD6nDjo4PdewPQNa6khBZGu5
	 T7uJOWDYXYFlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 68504608FE;
	Sat, 24 Oct 2026 06:22:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B3FE4D1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:22:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0E99A60A41
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:22:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ajK6F6AfiyfB for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 06:22:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 387A76069D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::633"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792822976;
 b=q3N7b3SVZAMxDDXI9SlUKJ1nnCZc45rqogbMFVElcwciwXzrXM/pe4AN5XCmm8hiDY8u
 i3AYxfCy+qsWAV072GR3PtflFm/rHPhgdc3CJR6ZMSm1QNv8rPZiQdAkc+nUinVbAYmLM
 BJ3At7jNxlVAi6Ts7oo7Vkkl/GFhCZU/hAbRGivV9SUdj6dom4kuE2rXc+6b4qu1+4PxB
 7nMzCnkJxj2ATaP+kYHC0oTf136y0T8/deQ0jR1GzUPQy0Ox3CXoZsj/MMv9hsH02HFVf
 fZJbQ8cZw0hUGmmmMRxhGGuIHFaNgJ5DiCYBVT9fmUYYDFl4p9ymIz0nIcthQvddPwQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792822976;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=FyuaYBmleO2W5VShFa2ImcAsSQCKG30TG3fl2ntvS6s=;
 b=W3VKcMxzoBHFy4WCryKPeVIB6PxFjmPjyUn0mj+nZqW3+5Jol1js98ILeiU9/nYcn0U/
 V75DRJa2itinu2I4CLNBsEOxxWRgdFsgYlYcbTbzf9yjf1xZ+ckRqsX8JevMEguVD+iJz
 TDUeG3gjXoqRDfQMXi4deD8y5TO/kPIs+k7v0tzriXcHz+UIJYYoVf73SMwXyPvemDDXd
 rTJWNbyEzHCsr2QEnCjJQ1vGQYlOndyz3jr5l8w+PEgrWKfwWdxt7RVPEB35r3fLwkR30
 s9Ge9pqP2W9MwtnwmHW9K178XQr85+/jphutx4Rke/frLFXAY6r5kQCMH6ueNhA4esg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="Au0M/uGh"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::633"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=Au0M/uGh
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 387A76069D
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:22:55 +0000 (UTC)
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2e9cf928dc9so12262495ad.0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 23:22:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792822975; cv=none;
 d=google.com; s=arc-20260327;
 b=Tm0Q5QS2K/3thRV3xEwHnbb5+ag0Pqc6DjB29WbfpjXJV95TLx1Pi7T6qKfzw5dxXx
 wK5R1n4ORsx13X/TP/I+vfV8dI5eLBgdWp7ANDYy7kXAjWJvLg9tZaULQ7BEgz2AjeSX
 eaNPf5VKwmzufFNvhn4+aMmw6dYEZru4vYLooYDPtQxRcOlX7GoUc7yF/aEM6f9DR+Xj
 Xj86Ek01HwkDdlZD0l4OKDdAi6RPIV0w0iimuSkw1S85k5eToZsjO05QWULRUuEb0b0U
 3i2JQipSWP5QTtygBsD0Rf3fdtioQsCRplR7nmfvRTExNLyucE+P0FXfgqwww6q4qCvO
 eEJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=FyuaYBmleO2W5VShFa2ImcAsSQCKG30TG3fl2ntvS6s=;
 fh=4elKA/8R8nsp2QSEXfJoIvGF0mo+aUc0n1hMY1echd4=;
 b=nEXj8taVcijkpHEe4a5WlbGGu5KitJToY/XfbweDdScGrYiOdR9IhzGngum7BvKK9e
 X85jTU7SJcgtn/7+rpQEnN6mC9gApbg13waaittupZN7EAE2NPtMI1RW+R4RxbVErqf+
 2k2MhBiE+cDfVhO2fgLxuBMRJrgyh2fI85ijnhiYS339fkolB5Drl02489NMsjouS0M9
 HqRQa1Vle3ZxwwPyc8M3z6QvvUPYcbus7ruPrdpi+UU/I8KtwISLAumb8hJrfgTt0oT7
 NNoPhbKwrTP1U6pI1mysWqHJirhT/zFJw7sqj8FZbgJdrUeIi4H2LvJFjdi3M/glL8Ha
 042g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792822975; x=1793427775;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FyuaYBmleO2W5VShFa2ImcAsSQCKG30TG3fl2ntvS6s=;
 b=Au0M/uGhqN4fR9zNejNBdiX5dwJxy1re6pZM1h2jcUBlcBWdGPvsVr2rHekFHC9F9E
 bJT64mhQQIlPRMG5uBlNm7x8op77pTQXieKHi6VSaQYXbeirmenavQ3zxNWSNATWT1A1
 sd+ufylgxkzXijN4dB5mIrdxayAquASFEicd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792822975; x=1793427775;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FyuaYBmleO2W5VShFa2ImcAsSQCKG30TG3fl2ntvS6s=;
 b=Nz13NdIzEi0cjmBYQh41Wm4+/S9Mj5Su0NyZOCXFQbQrEh9ZH/jzydDcq9602TdAHR
 TEK0ZmAKRohy8QQdOQcfeRPC48kcZmMdU2MRZEqXzKF+2lCEWWynVPS6U26AsQBhoYg0
 q+aO3JrWUPIFtAxYUf5SJMqkRCz8l/Oc76BKzP0ZILnU1Db9ICWROZKHxs43zBmz4S+D
 dUtsBb+sN5u2fNklGh6XnaGivYHApJFmgns1GUPQGm0HcfjGm8vRLcLBkOLs6mYLuKgU
 vw7lXSWOUZQQPRlN/sPF6ZHWKPliyJt6fQ+YIup58is8mM381cvhjnk8h5vISJQfE45L
 +i4w==
X-Gm-Message-State: AFq9FYI6efRwt3r9Awx8xrFAFe0TRffB/r8CHyP4AaqYIroM/MVYUclC
 6Unj6uXI1IN+W+waDPoHmecqapwiTk8CkzvUHChv6ch5Tt30WjYlP4KvXKcS/Z3sJY5OQke9Ow3
 6qM+OscW3t78R0fH5jjbNVUKHES/jwV8mpXvbFDRU
X-Gm-Gg: AYBFou2gfVJGbinus+rInA6mlGTnF3KrQMK9rL9M6MD35TpfRrrXbacXOT1G/oEZlpS
 wFSInIW7iaH50F1CEumsr6Vf82f+xiQ7EpdD69w/s4NRjvtKYafoXYG0ufEluRLS0DbH6hB57iA
 xWbWfcls7XYCofoHh1I6CQO4HgdqaBdKzDVRXNXuoDcdTUcFECc2ezRBoBBXQvParox0uku+R3C
 yebw0jDkY3baR/514zsM92/mD3oF1+GYxmrTGRxLS2DLSkFQAW2TMLZTEYH/x+EzN2USMEgTEN7
 vngheomWu40waS4QlkLX9DmwcDG+E3O6oR+Tg3p33JrF+5JOej0F2COT5bqqwPDFGHWy9Qlm22j
 9b1zrAS+GsnoSJI5LRI8+MF7Q7ymBVMTsRss=
X-Received: by 2002:a17:90b:2b8f:b0:3a2:bb9f:f87d with SMTP id
 98e67ed59e1d1-3adeb5a57afmr814264a91.21.1792822975266; Fri, 23 Oct 2026
 23:22:55 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 23:22:48 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 11:48:52 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261021102626.264091-3-ayoub.zaki@embetrix.com>
References: <20261021102626.264091-1-ayoub.zaki@embetrix.com>
 <20261021102626.264091-3-ayoub.zaki@embetrix.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Oct 2026 23:22:48 -0700
X-Gm-Features: AclHuK_HwrB0iZGwdNH-PxBN-mn9UWU3pgTqimR4QECACMn2uVXIcGkXVbUU1z4
Message-ID: <CAFLszTh8nDGwT8XYUFGU0xcUsXcVxjyKstXMx9h=Ca4heGR5cA@mail.gmail.com>
Subject: Re: [PATCH 2/5] lib: ecdsa: Remove outdated key lookup comments
To: ayoub.zaki@embetrix.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Marek Vasut <marek.vasut@mailbox.org>, 
 E Shattow <e@freeshell.de>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-21T10:26:22, Ayoub Zaki <ayoub.zaki@embetrix.com> wrote:
> lib: ecdsa: Remove outdated key lookup comments
>
> The signer already uses key-name-hint to find keys in the key directory.
> Remove comments that describe the old lookup behavior.
>
> Signed-off-by: Ayoub Zaki <ayoub.zaki@embetrix.com>
>
>  lib/ecdsa/ecdsa-libcrypto.c | 6 ------
>  1 file changed, 6 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
