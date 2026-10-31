Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A38606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 14:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0WWMO/Zg;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=nrtIE2A3
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 61DFB40A82;
	Sat, 31 Oct 2026 14:02:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eJB-MwJrqfiX; Sat, 31 Oct 2026 14:02:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A4F0740A77
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793455335;
	b=Qj34lHUAgeXufpHvdUPOoeD2n/Psde9WU3sjPBwb7elRxaMf+1mvcX1KUojEKq3AuLTP
	 5nD8qqnqnFPV9xn0DBedP77AOFvGqp7fM+pWRtEJ/aDNGwSI8MFgwGStmjrxNwaK3BPGK
	 Xw6LRcNVwWV7ra8Td924BfpGfNf3DYWneSeXvOIJz5Q/Wf0tZ5lo7sZ1G1ZzGi9bWmORP
	 UepjE72QewMn+oR20qU1kBbRlKOlzgTjwYzBvZn2HQLMNmWkwh6JYnyPwp6k0YOVRYG7B
	 zY1d/1D4v5wboZq3YWOdUmVlEXG3w25y4XTqL6SHHmjqLCRB3eDciDNlZtgFj0WhQVQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793455335;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vidUCFnTMo5cuC1KZ34LbY5Vf/AUq5eTH7o+fzQ/84M=;
	b=dIxsasbvDO8fh9Salv56glk8G7a9AVQIxac1uG+yyoPsY6RsozScYKU9tHsKFWg8N3ZF
	 KAjewVM0sZH6UqtKRlsB2Fq5ex2fyW7Q/ndfLR/fAU/HOeTdODo4/3Ie2dkDVTYUYNEZr
	 zECkzsBFArF0OngV6EXFwNCpwyGfpb4hp4rmzjXWl2f3jafnhR2peAgeLEgnJA5UCCUaL
	 fwCc75vi3Pr7A44Ra7QaqF96KObDnjIiBYSpEQJZrjSehtMbOTtU/W3cP1J6jPsxSHYyg
	 2Pg7JXEv3SarlwZ4K9nHAAmEY8cWJoP3F04Ey/MiTNvLziZf3jSFmtyxRtt8Dk2eslg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793455335;
	bh=vidUCFnTMo5cuC1KZ34LbY5Vf/AUq5eTH7o+fzQ/84M=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0WWMO/ZgBMW7JNnErlyVYaObTjOsPwuKrL2H4rw3dSIwqsgc+GWd3pJAMYWl4PA8j
	 bEFG2j4ppW8jw4P2fsvCxY1wFSFK8PFAQh/9GSw1rhWaPMC6USjg1SUOeY1mvsdTJw
	 q0RmYm6sTYteJN1JmiH9ri2i3HiZcXRA1tLw4trH3RoiP7s7QqWqwB3YUH5x1zKden
	 ZFRoXmJPHovUNl+Pqo+zsUdE/WZ3Ik1mqRTA9iklvTdk+xSYPmSYeMcuhSq8HqlRGi
	 cvGqL3AcOxvqSGEn63U9/MyyWIk/1fZqiPteio+BTKJWo1MitHIduk0USkkVnstgIT
	 Z1nPB7904s3Hw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A4F0740A77;
	Sat, 31 Oct 2026 14:02:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 25475380
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:02:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 169716061B
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:02:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OVtHED-YtYmm for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 14:02:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1323D6060D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793455333;
 b=SZqFXkm0Z+UsZ3MMr7LL4WqJiAWOIImoX6x7jv0XVFio9KodDvBU5DWavSWHoymjSniB
 FPZYEqWosqWss9KA/mjZQq8jFHcPuKIvJMiVkjry7xZheYLJEiupEvgzeG0EOn6inwjGO
 AAzYf5+Uf8SAlwMjuLnIxHPPKn1VTr9O49Wm9FuygKNzEWsjQyo58vPPKR+CQM7plfRgZ
 rhCYFHo+ACu+RLL/Zn3UwFAYe4bvNH5IIqUPaYryeNyQ3Lerzz4q3uG7S3DRPIKZLVDkz
 mwykxP5ohQFCC6dW6Q46DvArhV8XuDt7MC0DTBTJ8vo/5TCa9YAfKMLq6CnaA73uB0w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793455333;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=vidUCFnTMo5cuC1KZ34LbY5Vf/AUq5eTH7o+fzQ/84M=;
 b=Qk5xaUnkBDy6lgwQjocpg806u+9dq4U+6IsEet4Hi/G7WBRf6lmdqyQApEkXJXkh0mVM
 74/E0TZNL+ugP7UayGERo8o4LIsNNBbTfXW3kqKbblS6sfk3RqVjW13794yTRjo4dkxHo
 AplbLTMMu1bOGS35mA0y6F/qvTRkE+2XLqwIzq/7qVGKe8p+KaPj2t0IqXTsv/ShoSITS
 nar878lsoLEEMJrSV/DSOykIbdJJpQ9x8e8/HU5esti5WlPYTw1lb05DO7SinMJS2xTlN
 f1yRXfDX59/x0cJLDJA1++EdUrTSjSN2HO/XzSW5NSEnkL6pr2GuL88wplMR3N1SVbw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=nrtIE2A3; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=nrtIE2A3
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1323D6060D
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:02:12 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6b1d8944cb0so2627880a12.3
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 07:02:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793455331; cv=none;
 d=google.com; s=arc-20260327;
 b=HashA7ZdyxKAsJXx9zmBCENSvA3gLMUnbahGd9+cjQRMEfzFJjZdX6ItAChPi3F789
 PWJNLsJ+KOStx0YHIFhvs1PTdyYezgohFbTgKWVM/i5nbRNcNqrrQspRqo9SUIodXCR2
 42pYr4vvp2GsmjWBzSeLQs9WPxpPr6xOQRAga7RHq08juIHmTLDq9siPsvOLp35ChIyq
 8+WwmsJa1YuS2gP24gROKKigImu25GtNxZ/lZk/0laTGKxhI34PxGtIkHw/8dkFSIm+V
 K4fIez+8HD/XmQE/2CslOupm/kDbUAxp7pppeINqJQJGs/mnbg/2GcqGxBiz5pHdT6bx
 s30g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=vidUCFnTMo5cuC1KZ34LbY5Vf/AUq5eTH7o+fzQ/84M=;
 fh=eqECjHGrLIVjHYjmY3TdJuiidPEn1dXJNV75/HrQKMs=;
 b=M6yjK9iT4d/sAxEgOIFpBWSCeKCxZwxjBsX/q6rGwuN4pS4Um5KCYIOkdUmNxNT82p
 xGqAk1hCAVjiJwGkudSI5dPKCUonmrpoD8g7Rf74CRX9+bk0EXDH3EB9AWpzmbOPm3pr
 7SOdMCIwMXrp7fRBsZyubgcPnJzTgoZE5+ToqkOr/7jpzp4OPSAuyXryITDXbmjQHFzl
 jfbb9QVORrqK0o8QJCcQFy9NTcz5Je2dZ3/TXgKMl1I7EweShJXNfLprV0FWXRvtQS62
 FoWQXQnOrFcg07968JbmsaMet5gSQ0eUMYk5/zuDATpzPXi1L7SfEHxYS3vozFIPo3HP
 yMPQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793455331; x=1794060131;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vidUCFnTMo5cuC1KZ34LbY5Vf/AUq5eTH7o+fzQ/84M=;
 b=nrtIE2A3Phc1CmwEh4htbUKSLN2tjaVJmjfKHDzwZjj7/gnUi4GIyZy7rcOd+7eB9e
 MLAoj0rEqKu6jmHVlBjEWk90q2dAfUAIj9Jgua1101R33A/t5yw9r08glWP4E8EeuiIw
 neISZaxTl+Ow5TzDOVBjWI+cNbcsnj2CEPav8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793455331; x=1794060131;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vidUCFnTMo5cuC1KZ34LbY5Vf/AUq5eTH7o+fzQ/84M=;
 b=wZXmUlOsyLzxKPpXSU0HKHy8g/1RyC6XQYw1bL1WcWEgMHWhspoR01LNCeK36OtU8s
 YqALdWr+OjJiEtuHz8pbTntZ1/NAf7SRlV5NzPMNNa1ftigsXQeshYZnZ1mhEOeGor6+
 kIzvsYbrbFPmbUTUyOC/3+Y6pqQJ6laosvjlF8xsH9tzjmg83AMFFK7LczK3EtUpfP5P
 ka0rw6faPyMTly8i77jy6yZqBm2RnjdVTj1RRxK2kn0pJkbxNEE0Eyroyq6cceLyihXu
 a7U8ojxXWr83nSSB/Yhs7OX54KWIxdHDOwQtoiB3tAPNC/yit5WTdcDjitb23LKZZj14
 SFZg==
X-Gm-Message-State: AFq9FYK6TpwoQ6P52ukS4wsV2NiPOw1IzJDcjQZnkSwUFkx/4gerR1P/
 2J+FzIkev3zBnyXURlf9EiPAZGHzAeQ2AESqMP19oxHe4QPREmsXORqooUNXp69FnGVqqAk8CCe
 3lyXYd7aMFDsHMWy6KT/PKIPXDgsCZELcdGcDIzlu
X-Gm-Gg: AYBFou1Av0l/g658RqOBaWnPU170gkFvd98vEQL8y2pgaWlvxO36vRl//U/17MSAmJZ
 fsBBxSxd2KP/23ljX86410ygOciNaJ027VyzxYFFdwYBzupJh3hkejDAc4IuX4nbNChddq1SAHo
 SOkghQ5rCBzGvU8Kv4/gNQE+8o/p4BjiGlAJ3O9ssEYzZPP9Cdunkt+Ud0YsJO+Y8nXWdth3w3P
 SfqTo7cXKzvOHVeKoNO1wMKHaFR5YYg8KOMCuALHYIHDMjxTbMXOzge0N3kYGQwhkxR4PuUhR3V
 xzrr7Prk2kwyTnuHobS+kEwBk8h+PEyQhscKopCVh+1y+XIKQ3+jMa+9USzo639qJslonbLfrN8
 HzllKSqMcqrwVeuP8q63VaZr3jB3kOrf9SsN0eaIgZQTkqB78ejmV4Y6jKPh0X3ta89u7dik=
X-Received: by 2002:a05:6402:156d:b0:6b2:3b5:d078 with SMTP id
 4fb4d7f45d1cf-6b4d543fe40mr2475565a12.30.1793455330622; Sat, 31 Oct 2026
 07:02:10 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 07:02:08 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 06:05:50 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261029173443.1495866-2-maxin.john@gmail.com>
References: <20261029173443.1495866-1-maxin.john@gmail.com>
 <20261029173443.1495866-2-maxin.john@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 07:02:08 -0700
X-Gm-Features: AclHuK-ZIf5g7EDwqBmj0sFQUjwi8iBO0NnX9itNU_QVuL9PVVEJzQmYsniM_4Q
Message-ID: <CAFLszTiQ9LgCmObGUUCTZHfA7zMXu7i0ZheM6TpTo1Du4nEjdg@mail.gmail.com>
Subject: Re: [PATCH 1/2] configs: sandbox: Enable binop command
To: maxin.john@gmail.com
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Mario Six <mario.six@gdsys.cc>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Daniel Golle <daniel@makrotopia.org>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-29T17:34:37+11:00, Maxin John <maxin.john@gmail.com> wrote:
> configs: sandbox: Enable binop command
>
> Turn on CMD_BINOP for sandbox and sandbox64 so the binop tests are
> built and run in CI on both 32-bit and 64-bit builds.
>
> Signed-off-by: Maxin B. John <maxin.john@gmail.com>
>
>  configs/sandbox64_defconfig | 1 +
>  configs/sandbox_defconfig   | 1 +
>  2 files changed, 2 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
