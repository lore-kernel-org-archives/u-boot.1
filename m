Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A402606A326
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 15:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GzyrNSy3;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WXu3HuIn
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A33C960889;
	Tue,  3 Nov 2026 15:49:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 85HNQQ4paSD3; Tue,  3 Nov 2026 15:49:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C241F6088B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793720959;
	b=W1JKOgmmyqj4vXPANbsKKVpFadZJ3FNGhxSeSlNUkv35J6LJlonG0d3qNqW/rYlLs0a5
	 UpwjRACWYA6l1tpf08Kn/nHLjW1FvwhzxBaqo1SYLcjDESoFtIV8bGjmMSdl9yiMK6lS3
	 A+Nv1FQnNTD9oaTkM5m5K/lr461eJtgKG31+nqnDQVyysXEft5vwr5JXqcxIF8Y31A6mN
	 a6qnK1cSGrCjyNxV+qf97Mh7N2N6CaqBq//R54KghS5MqSLMiUPqFih703lrnRfX4AtYe
	 B+n4c9k++LyOZG82YDRB44pM9i2vV9Hzh29waKgEaAvURN1bjSWlo5KA0T3M9K4VQKA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793720959;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lP+VUPz+8hR8QUAv+bqygs2Yf7CyO7VYUUv0XfwcLMY=;
	b=UZWjUNRKBjQDmE1+iFPDm5kschBFoUDcNRYVEQw/ObfdV++pPre02xLCTgrOkwQpoKTu
	 SXxF2Rmm1Q/RNUwVLrMaW4i8wt8kMMu0Kz+y8S9p9zhGjB6FYhhLsM+2ATteZcKuFzhSy
	 muiZNB5DQqQeZHVQArwI3CelPe21vBwsRTF1WSt2SBaWGjjwYkVn24N7q6giEZn4uIGaS
	 HVoOUG3n3+jlXPQQBBGvu6MmvxGX55ZWEFbQe3ERDEFUugPDn7erQohrRYHeRo2oz9V7F
	 4RJEoqjEXqL/IutQ9YSFYCG2Pm02REpHGDBUX1BLvmd5JfddrZSjjk+z13oURLo7KSQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793720959;
	bh=lP+VUPz+8hR8QUAv+bqygs2Yf7CyO7VYUUv0XfwcLMY=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GzyrNSy3OIy81FZCuiqDCilL0+yJF8DfujXDTaIveQcQpqR+4PqocKtFtghZX3hle
	 UE6zi1Osl1MdrRTr3rqQo4FyqkZIXwMUbWkHv4E06+svLsK5W79xHfYONR8eVpTefC
	 hJMs9Z1iWe1Qj0oRufbMaZwG66BSP7UXW1DV+01tYEBocPpOdD5CXKe4IfoEB8DF1N
	 HcP1Nbya0/v/2/itsEmb/ZeRLu7SiudZQrhUIO5r0hNA/+4YDg8FK15Sj27JRTJ/Gd
	 sdRrTKrwbM/rd5DHo8Dwl/SlttIkeUfsPSI9+VYSf3FZ+IxIoZ50/9zIQZnQO9Ja5I
	 8Y1BmE6uJpStA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C241F6088B;
	Tue,  3 Nov 2026 15:49:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D7D3235
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:49:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 73D0F40695
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:49:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rUIqhDS9c3PI for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 15:49:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8A19A406AE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::529"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793720953;
 b=EWBQynP6q5+GXe0v+RuUDM30v93W8VIyB49J3kODQ27JdO17xe91Fjo1R+VGQLmUxtaw
 l18M6PFKoA46RBmX+JT1MinEyYRYRWCGcKfQi3iPKeJWKnELPl9prA4M4p/1Q9jvE0s8/
 uN/RTEmZxPkPrGxl4dqGKDaN8XkTKH74YgjtQreKUbcPQAjCtR1KJlvfxxYQJTnas9Eoz
 pfYGDYzmZX6JK+EWlm0t9AkF72c3PFaUBVqefsUw/C/CahPD2j2f8KdoRYEmWam40YVIN
 7ulkEw3S/O1zTKv+Ua2lv8yWj3btg6xi49JkiARdw7iLvznMu1SkZsSeYdOFaPBn6Jw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793720953;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=lP+VUPz+8hR8QUAv+bqygs2Yf7CyO7VYUUv0XfwcLMY=;
 b=B5fD1A256+Bct7i8REN1heKANJN1t9ZozbCoiY1FT6tHuqecNwU8fRGPZqhCD0r+byiI
 eFR1AnB1v7jvsNvrsD8oNi5kSdmrxZrtT/s12qOm7UIcQj8E+4HILN01BpGBq7W3De587
 /8Puk3k2nPjAOoGcvh90nqUX9Z2MfdYJv5ifWrttxB0vCgTd41KzsxG/RaB0BanpvugGT
 64+YeN2IQA+CHdJWld41/1041RGeOrFiiQZbG0cuUsFdmIGytup3XUx+sJNXEuBCfmE4Z
 j56h4jgYCxXOPfALvALRcbv2cTAw2SCYBPE4tuPgLTwl+dlvYGqOVQyb9DYZYp4hGDg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=WXu3HuIn; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=WXu3HuIn
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8A19A406AE
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:49:13 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6b1b13e09ffso5920178a12.3
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 07:49:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793720951; cv=none;
 d=google.com; s=arc-20260327;
 b=ptfD4REK3inrTPlRj7+hEvVaQ9Y57SJslVkwVoj5/qKfruLdQZeoNBC4HXY1NejeWs
 if1bIIWd6o1HDZXsZXgBzmvFyduIv90fT5C3hTQQIpAfPys68iI2ujVKeZNLznJRgVIb
 CVZPWzO784LSxEWWgTvrNckWSiKuTLac8Co/5YoIhrG36px4wZaQbZZAutckJPbnM1KB
 Jfe+L9Z4ZeGfvywg8L1sm1ozZf8UG7UCoFrXmJcPy+u7SR+Kr6RVTg9UOxyPApKoq0Hj
 /Gt3gt4fQE06S8veKQkFviwlAX4T1Vx05VZbC4sUjcK8zPdEztMT3Y03I1wiFLUURz8X
 XdPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=lP+VUPz+8hR8QUAv+bqygs2Yf7CyO7VYUUv0XfwcLMY=;
 fh=vAmY7hRBdMrkxhak4XNxRo2S+aXYqAOi9P6V2g3HEEg=;
 b=jzNV/6NDd0fWO/cMfhtYdaEa0AXKHyMg+aCMNTy3KeH+Jfj0/v6KjkL3UZi9/t9zlc
 KY2h7vSnBY0de2yNXHeF0KvH1PPwIJV2BcoeOAOnR94NQobGvLIKHKoWOWwuHfN3PYqo
 2P7hgN2Dbw3p9xDY9Jn05hU7hIy1TXQvE99gyPIikHslb23T2ObWLVKWAbGkpg8DmGgK
 kN2YeSU7hD/DTAiQZWcH+3mgcSEFmWJDH9VYLdxEhoSnEsmUGearxdG9SAfg57sVJk8U
 llDCYSFrFYEJ5aWKANoxMxAyR69KlQ656A8ffCViNVmePfBHTZCwovl9K5R2dOzH8dQM
 zwaw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793720951; x=1794325751;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lP+VUPz+8hR8QUAv+bqygs2Yf7CyO7VYUUv0XfwcLMY=;
 b=WXu3HuInHmrlKeb9+snNGFURV0/qYtXndmcd6uRZA8QetgA9zgwZkjpuh3FYouq2hg
 kNstu/XnBJUIZL7ZrgyJrfv4D6kY+wRzikaeDCuVkndcTVna0JBUh6Yrb3TWvNB4z63k
 DuElePTLoa9ouN55fVpxiyJVwK8WYIxKW+bVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793720951; x=1794325751;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lP+VUPz+8hR8QUAv+bqygs2Yf7CyO7VYUUv0XfwcLMY=;
 b=pfUfhpMbnXfPG+bGVw24DraSYV57r3XrTM/psp0jCkOON6boxX/vjatmt15i3fRMCR
 Rx9RXDt418YuTjOISI/62c74PTiqFV/kErzfBxaC1IojD4wjdQYa6GdTepsRShVbj8w7
 BBlPeoo3b35EftjN+vzzPvBG6C4XeQV6SzTM5Ul8k/NdEhkQzW2KYX1dMkoAzVb8LOKP
 n80vtJwFOPHwFB3i9GHzmdf/RLhlYgmdh/6hxjbAwHzTznmHaVB30Ji04b0Q8s4CHn3o
 SjYujYfimLHmf3BQXqU0x1YXjBN1QkJxkIewDBmgHKG2gyrMec2quVNjI8ivaSBeZaRw
 7Dgg==
X-Gm-Message-State: APuU4Z/d+1UoLnbvZ5gr7ubpBQT1JXqqaN1myJsYZ0OKhSgLOnr7OCvo
 Hj8DNoQoc+Vy5RIxofjoNFv5NsnSKPwnfE1xGaLAkjJ8AnRgSW0SNmOXnJyaqeyKkzELWDeiFR7
 ufJcyDc/Npl+xo3U8vYQZp1BFai3aO6XVuFIm9uQM
X-Gm-Gg: AYBFou0Y2RQYkdIS7hH1rlNcqPC2nrUkqW2JWoTw7npSukUJcIsTTFVCoXmPXZqlVJL
 s6pxxNuxQ5NFBGq30+L2+ipx404vRut4GetcBWoh/x+rsT+UiEdGJvupXJV+vF/2ECmOMKhR3tj
 6jcnYOG/WWIQ4DS9dce62xzOIeN/qvirPVoZSAUce6cne+BV0EJY07iY+O23GaIcd/UyPTLdv1Y
 1/ib1XN1rwL0+wOZ8ImdIaRghBkgDpJHmBwmnZKTVY/BzIATmQvmVkPX2Oi4gq6n+NRhgWKZ4FD
 FkQCB5DsxUx+zcnI59s+8cEm9uFniPIunTdKn1LH9U4o/BCv1flzGvbZvV2eATQnUm8clkpisZV
 A8oR0QspuWW3NlsmcSnFODAbu7J/E+Vv/NXKcMoITkspxpCg87SWwORceqhTqZgfkAgxq5aAmfD
 urzFVHlJKH6rGuYhxA
X-Received: by 2002:a05:6402:a512:20b0:6ac:b0fb:57b5 with SMTP id
 4fb4d7f45d1cf-6b4d4c74d91mr6631546a12.26.1793720951195; Tue, 03 Nov 2026
 07:49:11 -0800 (PST)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Nov 2026 09:49:08 -0600
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Nov 2026 08:38:01 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261103-riscv-full-fit-support-v3-4-e1dcdc9638e5@maquefel.me>
References: <20261103-riscv-full-fit-support-v3-0-e1dcdc9638e5@maquefel.me>
 <20261103-riscv-full-fit-support-v3-4-e1dcdc9638e5@maquefel.me>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Nov 2026 09:49:08 -0600
X-Gm-Features: AclHuK_hZ6CmhGmHYZHibpIhbpO1GDSgC4qEr1sAztXowtTVLeXYHKBsVCHfHdo
Message-ID: <CAFLszTgUQE7gDhZgOUFTgW2xXLN8FDA=OjVrFq96Rx3B4_UZEg@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] test: spl: Zero spl_image_info
To: nikita.shubin@maquefel.me
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>
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
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-03T09:53:01+11:00, Nikita Shubin <nikita.shubin@maquefel.me> wrote:
> test: spl: Zero spl_image_info
>
> The next patch makes spl_load_fit_image() check spl_image->fdt_addr and
> write the loadables into that FDT. With an uninitialised spl_image_info
> on the stack this could end up writing to a random address.
>
> Use memset() to make sure spl_image_info is initialised before passing
> it, as board_init_r() does.
>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
>
>  test/image/spl_load_os.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
