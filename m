Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF55CCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 09:32:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 71DE8606CF;
	Mon, 19 Oct 2026 09:32:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hi1CWYh3wFgQ; Mon, 19 Oct 2026 09:32:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B0050605F7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792402368;
	b=YX+u8Lur3LfuDhLY8MW055A0MplJrYYPerDQnHA3J2UXSSvaqzXXqVdYFG7HG269IbAu
	 KDXlaTtJqvr47kiReIV9yUYT8YunjVemDJ8DFqGsd8gaaKtbwSs4hKplMwQhsz+RrMO7o
	 R8oTEiWcAYUb8PwPaPROaoC0o/Y9FO9E3TarCqTRXgHUXGyA5DlF6XZicltsoF60QtjXu
	 fnCtCQGe6Qq+d1iCKSwdbmsSmq+KYSVc3wsGJH4x2fdEsEtdX/stA0loVhwpZnT3zKG8Y
	 hsKAsgtg3Sp31z1UVHIO6nni7Uv2q4wEckX3GLGy70sgzLlUiLr9oeG204dxfdhoO0w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792402368;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9edDvohtSzoEZwoGJ67ukIL2yPkyfOa5k3XDvSRkKJ4=;
	b=QROiMeFVPD4LcyYUZDjhzXomtqoNq2RZHwWA57toHk5RV5/x0+4u9U/Xyy2NhSO2z2eM
	 y2cB6q+dnDNctARQW4chZ/XpjkbWAEIvNOEvsjr/PHYVAH9I7luvbkn7ANY1BSo9HXPKm
	 Z7+ZUGVcEuMCHab58sCP4roIcnzcglgKk9BkVltsA3eCKhE4/cGMhyDXn1ldosLpT5AIB
	 HVCN5zYYGlpQi+k1XkTKc4q4lIgAlLSvrKzCC/GHb52njhgWjMe3MWiN/5KVHLyRLN/GT
	 dRktdKQii6cP+ZfLqes6LyUulGqtvxV/IF35GzbjpOHpstKdI6AAIwqBPOHAk2orHkg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792402368;
	bh=9edDvohtSzoEZwoGJ67ukIL2yPkyfOa5k3XDvSRkKJ4=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BrtSs/eVRL0vDVqClQvqM4a1vmKUoLVt1wfF783PBXXJszg+UBVEu3tdbQHe0aQgA
	 Eef0979q716Hqx2QewHqY7/Uw74t3/YRuiKva6Z9jl1v9ip8nLozNlMwQBC65b/C/I
	 BG3BaPW1dK2iypaY1ALloQzBLnj7I/uhVihoy5V+ys6uNsDs2SmwFGjhZbByfZ4rsW
	 t5j02sq8DVOg/sULs/T5xD4iubwVNgALWsBjNauxi/om6OaFp590zvCc5gy4s3HK+g
	 b5oCW/Ua2QBrwR5+1nSYKuKhxFirCywSbREt9vUsdBaas2iju+EhJEvmLP9/JuwkOO
	 HB5ogixA5B7NA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B0050605F7;
	Mon, 19 Oct 2026 09:32:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D4281E9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:32:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 031B94018B
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:32:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ArDVPz-c6Ncl for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 09:32:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 307D64008E
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::42e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792402367;
 b=qfSz0k69cvlRwIDZFvZlhWzQxH2eJ4tT4taJc9lQw/Q16Gzafe+IbTHIl6fB9DG87+8a
 KZi0dO84JN1cA3WIzjm3XvEXPnYFuCwJkEOovmecFTt102XMsllTVZkfRbErbVt0vDtTy
 lsAJYqnk1cmqye4oPLeET2al3JKKHgtf3E8oarC0I8AIizcPsJJxtDSUPWGrsfv2vVGsF
 oiiSaud11O4ySPlh3BadKSIs/uF9w2AbK7ol4kRvGBLfc3xpAJeDDUAKkepLQzvdooFoE
 q7v2grE7xWeVBYTBAumYqLbXOxTgQgh6FRjvQzOnpX6aF9QOVJMo2fQLtkU6my6FmJw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792402367;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=9edDvohtSzoEZwoGJ67ukIL2yPkyfOa5k3XDvSRkKJ4=;
 b=BRdmGdg8aAfJFEliDCuuFo7OHvpDdAEVkGLHn/pG50us+VQeHl3dJVllSjTTliQItlLG
 oJEvjYAm5zySQNV0El+KKLxUVZZ5ZfcZc4KRC9q0WYfLba5c3UKQw743dqaYxjYM9GzmK
 eQo9Vs2uc6eF18c5zyaozrHL8tIbA3XC2+ketle5/hlo+hZVVCFXc94RzZUe4l6cM2hH9
 9T5XLBzfEs24KdGqTA5SrdEJ0txahCJ1K4FviUXrRggKe9+44SOJg23P9PSHbbfTFkLEL
 wlFCfK7oDxF3hL53Iab/gvcNPwMfElPX5e7NuAYcyoO7YnusokTzTYzhX3Ln+1FuVow==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=OjduWg4y; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::42e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=OjduWg4y
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 307D64008E
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:32:46 +0000 (UTC)
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-89d6bd67045so732073b3a.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 02:32:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792402366; cv=none;
 d=google.com; s=arc-20260327;
 b=IUQy8k5ASAipNSqUYKyhuDP4B5CQ0Ife4uRhTNIwBg7+3+yqrZwyEImGZrB2YpZozE
 QwW97s1MOXqwzE0OSIYgBQ70r+oK5MMLCdSYwd58MsgTVtop97SjZoogiOKej/Lanpb4
 QpMQwTgIvJsqpFl5LIK8AvzeiMmns80hnuWnwXlkbeJxkxJRVhb8t09Iu5U6SygxXfdA
 wRE2fA5LbDJe++WG3+DSvd/y3FQBI4H2JyQPmd+FYOZur51SaUz5+TEpl9PxYndOEYpe
 l4sn/ooGcqLkv99tTHVUsalDrnMf2ORyxQm/RjXJeyk1q0Dx1b8vsWLbuyZj4glBBKl6
 ZjSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=9edDvohtSzoEZwoGJ67ukIL2yPkyfOa5k3XDvSRkKJ4=;
 fh=W9limZYOATxEysRzoYuLOospUaufMivdRUWM0xek0BM=;
 b=kRRcQpGYM+KN6/zrdVN2LJQwN2EpVfNGobp/ZJ8w3+dzfefPMJF0jNDYHgFf0DVFGt
 xKCpfNcYFMa2w8XkMkg4ZXEGQeLt+cpg5v0vCFNitobg8o9r9f25Z4aDPjV7LOcSeOCq
 tSv0y9y7ZZHTsYiaFowBeP2/oFqwh87Db01kdCxg53Jfc4b9RkkpG8rcDbChgYziJIBu
 /t0xpruMq6Nua6ilFG2Yw68JqeGJpZSWHU/hh4KsD2N88/z0PYdTX2L2GQz6EvpjxsQ1
 WTce8u3NXq4F8CTA8PR9CCVzvBTicbs1FbA1jYIzGsqkfYtg5Fi7BAKSJIKEIZgWsQAf
 DVlQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792402366; x=1793007166;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9edDvohtSzoEZwoGJ67ukIL2yPkyfOa5k3XDvSRkKJ4=;
 b=OjduWg4yj6B1/gCJDK67YBBuroPUVV8DZfS/g84yzoqmNb3cXRqVfg5QtiIMsQqhO5
 jGU96opl+DyQSy+NOqihEg/X3QHPDI1BVUSWFTV+MXBuE2qYgbI5diZSIFYRgq6W7l3A
 V7typRGB+cPNwQZ3/3PIzzZjL8fFKe4U2EcBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792402366; x=1793007166;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9edDvohtSzoEZwoGJ67ukIL2yPkyfOa5k3XDvSRkKJ4=;
 b=mQYfu0/ZtckoAyPgJilLNHTRe0YU10j+mhpoeq/2FDHcejYVQY7ehriUbGwp8bby6+
 IYsi6DWLq4d+YkY4nfDyfwYqaPpp21BPmTnLtLJaiq079IsJ9dQIl0p37elSkzU5Nj/3
 wUNh8HI3pa7QkafX4f2jV5nL0FMwdGMvhsmdwlJJKstCm2X1VDNS5L/Lbq/bWIO2+bAz
 4DhhrKgiiuhYsu8Up5QUl9mwaXUz2DzYylniGUdg79n0XhvksoJcgXXFB8oPeTkNcthR
 QY7kFhrfYfJQFr98AI/gZqoT70ebmS4SQL9/TKrCY5zs+xxS8HyPprbRBHlp/dvY8D3g
 Jzrw==
X-Gm-Message-State: AFq9FYL5VpWYujTaTtVv0NVKrizoq/h/ezTzNSLVH9YdWupY90qvmK7X
 WSlVMyQiFOhuLBv834xrjxu4R+8YmW3gpgcCNroC3SwSMEHyz3ff6/izpZTy4rB61vLLLg+Ikc/
 CGy2fHhHPKoltogbr0jnmt1YuPyjg322VISeGWu3x
X-Gm-Gg: AYBFou3BlDlmUe0zfrVJSr7sk1jksB8EYdGVNM69VmjkkN4l5gUO7rXT36XnaKMIeFd
 k7Vh2OMgOKnzcI1B1PJr9GdeNnHIxBhBqmDJl4BMNKRpEiZLCXvWL6rTbIcTd5FuP5mX5OCB/MF
 VRin+IZXOTFLyo5wkuZ7MF8UsFc9JemJ6Ao0Hld0SsCQc+xDmEiuEkEWfpJOrJ/OM3o3KwO3BDj
 Gad5Ko4vFAYDpptYVmCebe0XfaD3DhlLKM+ksA/Xs4oZcKGXYEQeRO25jpqNyahLRBonGEVB2Dm
 MPzK+3hIAWKvpOSGJa9XgJEyMbcNDfuIriuhfcIvGuZhEq7tqT1LTg==
X-Received: by 2002:a05:6a00:17a8:b0:8a0:44b3:1063 with SMTP id
 d2e1a72fcca58-8a04ba374c4mr3966836b3a.12.1792402365418; Mon, 19 Oct 2026
 02:32:45 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 11:32:41 +0200
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 17 Oct 2026 09:07:05 -0500
MIME-Version: 1.0
In-Reply-To: <20261017-b4-expo-colours-v1-10-479ac06e7642@protonmail.com>
References: <20261017-b4-expo-colours-v1-0-479ac06e7642@protonmail.com>
 <20261017-b4-expo-colours-v1-10-479ac06e7642@protonmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 11:32:41 +0200
X-Gm-Features: AclHuK_931KIaxa5QwPVtWFJ8wQvB8im-GaB49y5LdHffdGXELeZnrA6bykPRcM
Message-ID: <CAFLszTjxj1_=vj1QJuGt8RNvguqHkaNFVAUxRrrU96i_415bVw@mail.gmail.com>
Subject: Re: [PATCH 10/14] test: expo: Test a box with its own colour
To: petr.hodina@protonmail.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Alexander Martinz <amartinz@shiftphones.com>,
 =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Petr Pavlata <petr@acrux.cz>, David Heidelberg <david@ixit.cz>
Content-Type: text/plain; charset="UTF-8"
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

On 2026-10-17T09:10:23, Petr Hodina via B4 Relay
<devnull+petr.hodina.protonmail.com@kernel.org> wrote:
> test: expo: Test a box with its own colour
>
> Add expo_box_rgb() to check that scene_box_set_rgb() records the colour on
> a box.
>
> Returns -ENOENT for a non-box object or an unknown ID.
>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
>
> test/boot/expo.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
