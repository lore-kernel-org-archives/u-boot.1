Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6385D606A322
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 07:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=W9Kaevfy;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=FnTqTcCz
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3A6D660869;
	Tue, 20 Oct 2026 07:56:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7f17lbfRJnfv; Tue, 20 Oct 2026 07:56:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8559160841
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792482996;
	b=Wnz5DDc8VZLyeM95018Uvo1WMsORUz3gG9IOZE8bWadZjFr8Ovt+1XY0CA5jWdf5ttf1
	 tmfuQswk7XWsktrltUmQn0qlFAts68WuPBMensu0afyZAA0VlPc+WoGhY1/S7FIYVFIh6
	 gr/xlalJDl9S+ru8mqJOx76tbV4f4nbxrkygao5zGBfZ/W4nyomlYCytT0xYwuY5aig8v
	 jgv8o0KgO1DJnbJtBZfcGh4bO5vXto3pIbMnxKpKk6atJBPLca2lZVB7I8W6E+Oo5Pxte
	 RH59vsl12UzKvNjCCU0Mp/4wdzv1EXzhXWPehYxNspPPgNZ0pGmgc7E3QWrgrBGUNCQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792482996;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=XB+QQ1jjFZIW0+d8mCzejjGm8tDh2ZMvPo9Gxcdnz9Y=;
	b=e3H/34tmskwcelVpIZv/z8iUCq7LEfzMCvjE8cREqGgow1nNO+CP49xFsxFsk7dAfSQG
	 6CbBD/oGq6fpzsVEALGPx+i3MHOmonelmCrp4kJng/9cf5qODKkyVOMI/C+qcBE/86thh
	 RqSthho4+qY8wgrYpHxvajkKJJeW/lQGs7RUWnFM/7bfm52zp5L4RhackGaBO/yJj9eqD
	 7V5wYUJPwbJcC7cZ4hhL36QqovgJrZwkjPg7ayLguLuiz07rIv2TV5hyE/AI5MW0csI5B
	 2TcNKn8EZL/HR+RM4v2Kd5j8liV7Sxs7bjJmCOfT/l6cnhhwx3xc+qyOedjMpxrgQJQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792482996;
	bh=XB+QQ1jjFZIW0+d8mCzejjGm8tDh2ZMvPo9Gxcdnz9Y=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W9KaevfyGe+6HesQkhOyhdGmGkN8YHZINC5sbN8OnT3R7uQ+IgZTu+1iQlhoJSrnF
	 2CrdLkurMIiVJ32929VTg10RfIKBBr28dPOMDKArBtpdXdr6lc/+ZcLBXtY0gcSr/Z
	 yhNmYwfXQHKwzO4K22ak583G3q+Y4slXKsIyt5Gab/8FMOrwegub9+5uUdQm2f1gpk
	 XpCClkLq3RC7YA3Y7ZWeFZI+Kh+MGageb1AoN5wbAcAdPTmv8xL1mB0Pu9Qj6JkN5Q
	 7QDP5pnQ45GqbLyZnNcj2PDwj/PlUQUJjNf00OjRouRGk8BHxuFkESx5ljEEzCmQWF
	 1a+msn8b91vtg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8559160841;
	Tue, 20 Oct 2026 07:56:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E5FCF3A8
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:56:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C5C2581010
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:56:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 457eD5Wz4xzi for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 07:56:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2AA3B80FE8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::534"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792482994;
 b=dF5yrWP9fdmm/fD1yBa6gJfxO+IrH4pqwA79ff0qccrLERfTG6YbDlefUVJyEQGt0ugS
 1lLs1jf5+7vsfDczT4kkstKTUiS1cFkXmC8mSloSytBiCzYa4R4IGA7FHzIGfUaBPaLxT
 ZEkoNZm2PbKnp6k1fmJOX3aCWZ6jghnI9tK4MxUEKoaVweRO/V8pVVpl0JPIysywTnlmc
 8bJKJbfD8Ed7+6bm0tv7pIwLNFCdGteM4g0Wk/B+l1MLfeAeSP69hv8D8zhsGASi+HTMt
 rTGNa9gD84ImVz+Cgspna9goMH+xrMgRSYffaA9EZQKvv1GRqlZpcqXmDEIWIYyxkqA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792482994;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=XB+QQ1jjFZIW0+d8mCzejjGm8tDh2ZMvPo9Gxcdnz9Y=;
 b=VzpvCQAe2fwVUVRCjkP6WBauCTYpQWcBmK6QIDMv5SLG6ab0YTqeAfCUR8xyOzDav1M4
 TaXSe1V1rXieQHWu2azw+CKSBhLvtamva4BQD2AKSaIkq+vEiQ9kUG1BRQ8TwS9fHMvYB
 MFkodYh71jvd9ZzbiQgnTRkWUea+MMXjf0Rtvc6HRcnctE9abw7b/uHpNgzZjnLBBqTh+
 TEMakxHHYTf3fDifbXpip1e5CL+lLkQyWReFIGPZxchXFaCf/gJy7w97/5n6zi4HdWzpJ
 lKFM2a+4EgMzMChRZUijyTzZeTSHlaAWmnWBQXh6fToJcwbju/nJgZfGko2qV0UDHXQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=FnTqTcCz; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::534"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=FnTqTcCz
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2AA3B80FE8
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:56:33 +0000 (UTC)
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-cc4aa0246b7so1045636a12.3
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 00:56:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792482993; cv=none;
 d=google.com; s=arc-20260327;
 b=Idmv1dYdPkTZomQyWCFFBlLYXiWk1//fKisTQ2AqngCXmtrnuXdn29hpun9sPng7Cm
 uojtYnvV1ii9kWcI0U2uO4lXCySUq1QRc8Dn9oCCRxi4IZgqpV9hk7QaoAZQswOu4eM/
 wBdCcLkn1BdBFwF7ZHEt99QjMYfrGDBFKSP9Pw03vdjPQZtNOoMadZhvchETnesQykM+
 EgWtMHWcl1dVyS0wYATHWyW90PuyvSpmPA5h/fQASEI80bNOEL1HBDtCtxKAsHiCD2Av
 WwjTTKnupCpcZfosSfpgeW5kvDlCqbwnetGr1a+uhVJBOAJ8CI+8xlMvbX8T8rfPzqF3
 CcVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=XB+QQ1jjFZIW0+d8mCzejjGm8tDh2ZMvPo9Gxcdnz9Y=;
 fh=YZUMPEuVAxv+jZuXsS1UlsnLGnmLxFMs7mTn76W2P2c=;
 b=oNRFJkiyjxC5OMAnwGxeK+tdOa7Xb1ddZeldVir1c9Slw6htd83xZuaG6NkOZQ2yQG
 CKYCMvbe4A7mftOZVQXFzaDjUFpmdU1XrUH3keuIMpjbZhMplBBza7Je3rkuOV6F2XYR
 0wgo0bCyN6R3pjvVOQCGGIazg6et8U7T4qRWTNszl3Tec7xxRRF+Go09nwUUIa/dTcp7
 pnn6XzhfG+I7+/wcodO+bIQPtePshyv58HppB31WdMzpXbLVNrx/hZR6rZFeZKgTShCe
 azkm6oQIa1DXHDcN3Do/pgd7aNv4lcmt2EToGnn85+Y5RG2otTx/u/+SWxMGAHgP0nnd
 0p2Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792482993; x=1793087793;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XB+QQ1jjFZIW0+d8mCzejjGm8tDh2ZMvPo9Gxcdnz9Y=;
 b=FnTqTcCzKwJb6ElJcpvji7fiCKQsCGyqo8dT0/2a8/l91iCnGEYGdISM+AgtoMosDJ
 uYVopO875ZBVkOyJ9akfDTGh3jCurBF0BGez9LTNr6JrteDdpitWHOhADaUcCnVv5J92
 KndfBlMxG/2CM4ohMsZVQ1i0xPsZsm7eVX7qY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792482993; x=1793087793;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XB+QQ1jjFZIW0+d8mCzejjGm8tDh2ZMvPo9Gxcdnz9Y=;
 b=XF5jORuseM5BFxguYAOm8D8Fzxr4HiEi8CGOdviujOQ/8ELE0XoNMO/sdKjHCfWe3U
 Mwy9VkVi5jjvc9/AWW/NSDVXa/03kliVWNL+0+44dmbphi0av01R6O/VGrKfZ2cSkzw+
 PVM7BWHAJvA9m5rwZ/895iWfug5Kqde1X7YyTFFg5k2Ds62zQVwAUkrEg9/GrJpuNfJv
 cI8szhYSpso5xkIRH/P9MHZm08QLKH72lfuV9ouHph+qov18bMRCcqagnE2PzDEQRHvm
 m+Gq9I9OLWuflBySowE7oCWBM67Ld8PuLkOh04GZYgkMgu/wOaOOngNYPHR3ES2c+MUH
 MJlA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw6jbOpX34uQcSsdvz7PSnrNx9grtJ7n+urG2REND+VjKUJ5Og3/VPe78RryqJq+ZObksgMrZs=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJUpzz/rmqmuILLgAZnIGOZ8vkw1yPhdSo0uVk1eKrF+aLGzS46
 i6/QwEhoYzhzciXBkQmVScM3TN9z665iNXtE876BI7rflWe4NVnT2tW7mb7HHyJUnBXOeosiWf/
 VO+J7IBAmS78bRmFKDRQl6PhDVHAklOon33esJ3mA
X-Gm-Gg: AYBFou0ghv3/1ootTFDWqaSGo2207FEPIy7ld+YT5jjTDxc82zekUSoo9ozE4kMLmwZ
 599x9FYK0vZ2s0Dwg/BIz01kK8D8ulxfQ4TJI1C4geO8QKtqnvkz9TSBYv2wUIW0K/Oy27kxGOv
 vE/n7EwFg9oaqQdoFyu7UrZh/BH8r85hQIYjfxoc+aiyFOwDGngOgzRna7BWGCOE+tSr+ekkBRw
 Xk7sl5/mE5gS4DyeA8KT9BCv8P2ioVrnCe+e8VvnCCznxOD4oX7mYMkSaK6bdPBCsr721BJnolm
 CIhVYDQxGWq6tV3a1TEY89AZGDWFpsVtbSOBlNyJfhuTmC7jsHJc12VOMtvFHMkTIhWxLw8IK8R
 eZqi9n6ZCfOUbJofUrwmk2Z4RdnBvfECq/N4=
X-Received: by 2002:a17:90b:280e:b0:3ab:be66:ddbf with SMTP id
 98e67ed59e1d1-3acef58d853mr7928290a91.54.1792482993064; Tue, 20 Oct 2026
 00:56:33 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 00:56:29 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 10:31:57 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a31012076023af2162824f03a53820d947cc715d.1791966831.git.daniel@makrotopia.org>
References: <cover.1791966831.git.daniel@makrotopia.org>
 <a31012076023af2162824f03a53820d947cc715d.1791966831.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 20 Oct 2026 00:56:29 -0700
X-Gm-Features: AclHuK_3uM_SopMDP2asVE43B9EKf6XiNxf_JEgMABSFCWs6o0ocPiARRu5Jrec
Message-ID: <CAFLszTiKJpc2VQydyd4tDeY4EnYnqjDhg3Draf5bgD+nbD4nbg@mail.gmail.com>
Subject: Re: [PATCH 06/11] doc: develop: sort the imagemap index entry
To: daniel@makrotopia.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Vincent Jardin <vjardin@free.fr>, 
 Anton Ivanov <anton@binarly.io>, Randolph Sapp <rs@ti.com>,
 Anders Roxell <anders.roxell@linaro.org>, 
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
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

On 2026-10-14T08:38:38, Daniel Golle <daniel@makrotopia.org> wrote:
> doc: develop: sort the imagemap index entry
>
> The imagemap entry sits between bloblist and bootstd/index, where the
> surrounding list is alphabetical.
>
> Move it after global_data.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
>  doc/develop/index.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
