Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A165CCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 09:31:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CBB9D606CF;
	Mon, 19 Oct 2026 09:31:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7OInEAqueuPm; Mon, 19 Oct 2026 09:31:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 13D87605F7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792402299;
	b=gICxh7AbJgoGLcYDJyYlBpzqxH4jQOJa0kF6dR5QSo9JLfwl3e47bIJ0HzdRlOcBVFwU
	 DorMw/cRLnTBL/Z09LRBpTRznBjTKFtraNQWlhw8o2BNo4Pu/qXrcnTEJbOmUJ4E4R8/a
	 JtaSiix0xXwRv8yhrUZuaBzaMzAaN8InL0UeJhqj5JE6ZsD98GoVhFAXJAW/DYiyLiPUw
	 dFry5OruH3BOUPe03r564GlnsKMvb4x8axb1hIoDoeS2d3IVsPEy4DN6RlhqJAhzu2O6U
	 2K8OM+WOWL0qtBkhhqN/cK0B2S8HDneQasGQ8pDKuKTvPLkCj61kaPFcHs0HRTK5zDw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792402299;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VreyUwhvCdQXb8sg4j8XaPJ1a8s59/jJrVpHw7PQvpk=;
	b=NtH92nc2LYroSb/OngwdzZnKmKCj5wW8hFUamv4HE3zw4KEMEKx7pzQNh/cqdiSw6MNf
	 RxjF9jFV+SNKM7f4IZ/9cMcTZND7/DtpMgN0LD/nso09vIABwLu6e9nR2Fl4aH1LSmgYO
	 rtXfrJACrAYsh7tGY6B0vyXLKeCzdmpl6QmUcd69mu0a8XBDmPTZT0gqLjdNp23Sp68xI
	 YdqrjVrw+AJE5yblLpH7AU2Y0VHlfnLXeOQv0u32IZ8cbFiwYlME43/+wT+kkE+aGeXZO
	 zI6oK9hrMoy+xZBuQmV0fpjIsKC3WR9AbMbOte5Z4X4haFcwOViUsOkIaJY0lzC6GKg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792402299;
	bh=VreyUwhvCdQXb8sg4j8XaPJ1a8s59/jJrVpHw7PQvpk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zAxT8/b5/qW0NmW0cjx6GYzi3RHo6ZjzPKJo8WyLeMF+390LWY7uBdXiMVFZohtjJ
	 PO51xAHpRV6ynbcELLHaBrYrRqJ5F5obr74POFrAJbpzWlE/ZnlY5WvlFIEy0ZLOb2
	 ttl3cXmf9v0PptaulxP02J74CWPjrYk/Ll3oqOmLou3VjJ3tUYH6zlooxS//YMEUvR
	 b5RUcocGqYgfLFg6OFyiFP6YaGdWKPECeZ2Fm3O8NWLHsFWeIaH0mAHtAmhWSVHFgX
	 z+iptX6oSqxCTEMMgSzJDNjg+nzKrR1tObmE/ybuJS+/7sb/9xp4QZI69gRAoLNco5
	 W1suCJImv97QA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 13D87605F7;
	Mon, 19 Oct 2026 09:31:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 283FC2A8
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:31:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2550E80F51
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:31:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id csH-DRr4vdQ9 for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 09:31:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1A0FF80A9F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::634"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792402296;
 b=pSp0vOHiMC3lxDVUunmTuAIWwEB47RqduEOJIEdei7NeDvZmW12Dop6bMRrZUeREbAfA
 DWnWciULYZs0Z06vl2p0Ywx5MJfaYr11TZA6KRocFk+dgB1S/IxUoMY8rKECURJm4rotr
 4TzK3U4hTeFdVEk2s1pv3AMl0XL5T28ofef6vLtoGTIPioWVaA3mTKLq8wctwSFDrL067
 WKOdgxgnQsQAzDBMmTHiXmfnYhVNqCJdIdLegS/zwwAvCktxb3TWPnRcDxgmiFbspTQ+d
 3SCj38EvgbTisHwrMzEs842iyroWLVPQCgxp/yMTJWbYwtM0YxIR2dx7UBoqy+a9YBg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792402296;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=VreyUwhvCdQXb8sg4j8XaPJ1a8s59/jJrVpHw7PQvpk=;
 b=sQtlFcmJXjU2TwIeeIk9Un1hKICqx2WHI8Jn9w1HmwLHOX8UoPheJC3gKZxAsiWsjUv8
 Q89pm8P4q2upsOneoIA6AjsQplpwaTa+ZRMj2zh0L8tJ1NjDC1N8s+7z1PgsFcHtrsI0T
 Z2Vw4Lw4+P5OEClAOj58WSN3JZMXqp6uviNyWQy4OwPS1ZRTDXa9E3Z57AsLzZZV3eBHc
 FYwglKTYdXbJV2z/0QYiqaQPCuKye1dggrl2GJkyiSvv1e2gbTQS0IQ8V/OagvCRo9X0p
 iB4gVQXOeZn01mJxJ2HficSDL5nph7+hXAqPATx3OEgcIIT0fOnVxlsrVe6JfZPK7Fg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=QLcs1vDw; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::634"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=QLcs1vDw
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1A0FF80A9F
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:31:35 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c418e215671so221634466b.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 02:31:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792402293; cv=none;
 d=google.com; s=arc-20260327;
 b=UFZpwrDslaIiS3/OOKwqaMsrdnBNGMSqTZK+dUjMHSPHDJaX8GfijRySa8hT10C9H4
 9FZAu9NzNlQ3ppszHpuFj3EBqb+QrZKX6G+UB974Ez4mN3RHweMiH9oI4Z/TVsFCS395
 Y3U7t5DS16FTta9GAvb0wCzWng9ONzMwFxebh+eaSTvnzR5L1p+tzK14ms5AMKczojBn
 8JSa/HtSmif7NHIvVrdG8CDot0/9H29dU0XEJMatOvKl8fKcp1weolclxqpt462gEldG
 G7JKHa6ZqReGHIjgWyAIgmHyK7J6L9fhOql25GOBN4+iezPvL4WQdzTWynd/+1CxpdSg
 jpTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VreyUwhvCdQXb8sg4j8XaPJ1a8s59/jJrVpHw7PQvpk=;
 fh=GgR9PUmESCWkTiIqjSrp7dGvnIMHsQBMuWFa6/yhFvI=;
 b=mNMq6lysIAYlU9Kzu4eB6Zm5yT0I5S2qI1OSKH3LTDjrF8noM1BvqCipajjyRu+x6v
 3MBtk9lbDkipQdidqywV5+vdPTivrzE1vlokc7N8KfODoQHq2OFX4SceCO52B8oqwfhX
 DrQQsVs4zdguWBL6E3/WZB4s3T3iWsBPORGJ/Dta7D8CFeheb0UfF8tbO0uEaPGdDgZn
 q1fMl7Efo2BMcXetwdztTjqdj2gMOEgP6x6pNYXASENre42LVLC9m5bi4G0jY7doO1mT
 NDDb49SXToyLEFcNXvwVebA/5hRt2H565t/BWnHp/SV+En4ar2Y/9xO5hbjDBVYp9Wum
 2gtg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1792402293; x=1793007093;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VreyUwhvCdQXb8sg4j8XaPJ1a8s59/jJrVpHw7PQvpk=;
 b=QLcs1vDwYmuuQrTGUBWo0aSX/B5yFpZv1Mgpk2J0XfM/ESmFnzCQ6an9mOndjuXhkg
 n89EUkVS/r/i8I93mw93snMBpT6t/76Q17+/ZDUZzyuuXXJ9PJrZZplwm5lSLcRRaNcQ
 tPbfZhsVgc+E/gpjhF/hLS+0I2cmmg+yUiDE/+pmpC1NcjCyY5zhVZQcTcspOq9HY5jI
 Bxp6AYnkUz/42ouOUoksPWNKWRD6J7o9Duz9K7TwCBkOzB2XgyE/c1uyFaU6kALK+GE3
 fNqoTxKDvipKs8kpoN1avdGoIhUHsuzewa3HMG1svBOXf24u89y9pjkO35UnmBTyz7Ky
 D8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792402293; x=1793007093;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VreyUwhvCdQXb8sg4j8XaPJ1a8s59/jJrVpHw7PQvpk=;
 b=V7fHc4E0sLt+BlOxB9vx+toHbtTAEmAja3eBQJm33EUlz2bdmruwRgtCZ4daAge0yU
 MiR5Y5YknK+SeeuzdSWKySQQqO0HCVhSeuMzYyYwHe2ePQwWTsMe3qYxpw45fTJUlYK2
 4r2nxjNFQcRRcHK8htv1XJ+vlFHOtpesHm22//cAmGdvQsl83sFz9a+oHZWoLfzcSU73
 UHrU8S8ZySPWkAiTGbwUyVu0EfPAz7/1N3tZgS1Mvdsq6mON20TpvSVi45kLyPW5NK4a
 hGHiZ5XDmtAZ++UUNtrp0hhYVAdIopDWQ2c+gSSQp4H7QX9id4Wm9gCvpLU1lRlQGEBM
 h0dw==
X-Gm-Message-State: AFq9FYIu+NgwI32NAG5rT18q2ABc1hW3v/fnHYiULZa3B7Vr5XXtVrYv
 qjA312T7M21He4GHRgFXl6Be81dmlucXaqX/5fY809XVh8gNI3GPEz+9gFbZH1IN5ce5wuxbpjg
 PoHHJgxJllxCQ5Ix8hXzyZrOKA1Wgwfoz0gU15e1uQg==
X-Gm-Gg: AYBFou3+tG6DyfnNAi9WiLBCMk9pTmQdQM6gCQZG3dpPE2jNeTR6IOpNIQ1vy1e37hp
 4Als0P//sGPCJ1aGxP0dUNC9D7LwuKy/0QC1+DPvuycoc3+R+2Ubl2nZMOaiDztGuNcu/kpju34
 eVL5+3Q4V5drQ557wbrwIok86SYDI2r/w0zOE62uo9ivdWPDB/D4dgmnhp243kz1aPT/iTgJ1p8
 hRGJ0ZUw1EXn+jFPtUHv6qXqvuuHK5ghpYnAw5/fIf7H90PgIKwRt35yQWYtwBID5oXYQ7b0Yba
 d4tHkIoABwiGB7YPCD0pyhZfD2wiezktM5WXRfviCIQO3jw2V6GXu9MMvB2tfRMAgs5J6ZehIq0
 XOm3MdEeIDYQP
X-Received: by 2002:a17:907:9494:b0:c35:d50a:1352 with SMTP id
 a640c23a62f3a-c419d34f678mr477233766b.11.1792402293340; Mon, 19 Oct 2026
 02:31:33 -0700 (PDT)
MIME-Version: 1.0
References: <20261017-b4-binman-fit-fdt-compression-v2-0-d7e290847543@protonmail.com>
In-Reply-To: <20261017-b4-binman-fit-fdt-compression-v2-0-d7e290847543@protonmail.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 19 Oct 2026 13:31:24 +0400
X-Gm-Features: AclHuK_SMaZUtlCZjqNn_tETy2d4jn2NuhQVuPfIKUIXuoLWF3Txi3G1-iXUzGw
Message-ID: <CAKTNdwF9+bGYArwyFUfP52DjaZRQJJFEbrinXasLjNFNMkjNyA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] binman: fit: Compress generated fdt images and use
 it on Rockchip
To: petr.hodina@protonmail.com
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Petr Pavlata <petr@acrux.cz>,
 David Heidelberg <david@ixit.cz>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>,
 Daniel Golle <daniel@makrotopia.org>, 
 Johan Jonker <jbx6244@gmail.com>, Quentin Schulz <u-boot@0leil.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Petr,

On Sat, Oct 17, 2026 at 11:39=E2=80=AFAM Petr Hodina via B4 Relay
<devnull+petr.hodina.protonmail.com@kernel.org> wrote:
>
> Entry_fit's @fdt-SEQ generator always embeds the raw .dtb. Add a
> 'fit,compress' property so binman can compress it with any algorithm FIT
> defines (xz is rejected) and set 'compression' to match.

We currently use 'compress' (without the "fit," prefix) for the U-Boot
binary. Having multiple spellings for a semantically similar property
sounds confusing.

> Add a generic SPL_FIT_FDT_COMP choice (none, LZMA, gzip: what the SPL FIT
> loader can currently decompress) and use it on Rockchip.

Do you happen to have any numbers regarding the size savings and the
real-world cost in loading time? DTBs are not that large, so I'm
wondering if it's really worth the added complexity.

Best regards,
Alexey
