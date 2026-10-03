Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066C1CA5FEC
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 13:40:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 59934813FF;
	Sat,  3 Oct 2026 13:40:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hedc8nsvgimi; Sat,  3 Oct 2026 13:40:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9BEFE813F5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791034844;
	b=nVqTh8CIyomM3/6QpVSQxEQUJQQzU179Cqm9KiWtM7jWUq2vEfkSlfkY56IDiX0WKxC3
	 nCu7HSb4oK1FVG48k9Ekue1tvnSCG8/JaAjkYxEbVm3ZZN+NalbZOuDC0coReD3tlb/U4
	 mzUE/cHVkoJUAsB2SCqWj0dAj/T+nkfw82h8lej06i+j/j0vG3IZUk/K6aGqRJmt7x3QB
	 ZZyM8LflB6dZYlqJ49gatyDlz4XwZtVhNYm/Qbali/EA+3+0CcoPww/0OTWYhwVIDHi/o
	 yXTmfBdVTWCvnvdzZk9tIOzLgV6KX7xXxYCaS3e7+yq5YtALlkjBTnoOA9pfOU7bZfw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791034844;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DsG/uF6WQTk94kvngBj3z1Ssqcd5aAEXQelWQDRaJVc=;
	b=LEQ4NLZkFY5UlC1I9ClwtD4GlxK6gUqC3+anF6+66axiPrwaUo3qEiueD5rgVVzdCYto
	 4QZH6mtD6bdmK5YB6T4KQjmNL69OzCSVYtwuwATUBlDSF7fnE6SojkLVkp3jlsjDSXPZC
	 pPXYjWYnow5hf30uU6wapoKRXErMfQMLZH1sePwEpJtskU3nGBSp9s1mZrc4J2Pd+k9s6
	 /NQazs4z5Nq4UZjyN3hz04LV4PFDo5qZxcrsmdWaSz9J3BLb6mgDIwKfSRCUFz7ij3i8/
	 y5idnV3BSOFhrcDRGZEI4S3U3wA/5B0ehuSeuNIxa0i/Yh9jwcIHF27oKjFN9cgo2bQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791034844;
	bh=DsG/uF6WQTk94kvngBj3z1Ssqcd5aAEXQelWQDRaJVc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OhkiTjZpyeEZ3BDTv5mAex6D/sbzrP/PeT+6SqvYOqjsT/whIP9M4RPIpKvXHQ12f
	 /vu6vCFO8Lt6ZHAk8AyiEbuGF4SkEfWGRoga06gpYILF5Eum0U2hZI43GI4lrOI9eu
	 UDfA8QGADaXAYo6Uzr9t2XBcjOI6K2bxQ4Hb+wa2AoStNXRIxU77BMG95xExVNeZ5x
	 UOgqBCO9DBixKAWsIrvvDT7woxCsi0hxFmP5434pGPT+1KapA0Hrtszalm9LUbudXy
	 tUKLlIc6SXyBswk0vBIU1zfUU4OTiB6A1bR21uJuvEvqhAda/bgFhdmBNBzaOkve5N
	 QnDCy6Q31g3zg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9BEFE813F5;
	Sat,  3 Oct 2026 13:40:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B01F3179
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:40:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A1ECD414B6
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:40:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fGynSVNhsTtn for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 13:40:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B7E15414B2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791034843;
 b=SE+A/vyOgNBUHz5UWXDaDT0wbK53ggwVDqCKJVt+BwbV759JQ7KyNyAHJa+PjV/MZwPU
 d3ZhDdq9ccmzt3l4JR/XhMA9VRu1eeoSKdVp6i6pDbY4xkUCnpWoH1zzLNpkkn+5SXDMV
 Y6ZEaICzQf9R5ax5E5vk5tLKKHJsPgkpFaNhynP2uzJ19YBmH322Ph9/4TSZoXmU4dkWt
 3i7hN2B8t7MLmx1q1YbQcKdnSNog2NFl4zT7RZPByT7qh9Wq1cF49BpZinmG9qAkAgqu/
 tgzIhfguGdq5dLz5/BfiIkgCXeFrlu+yfCv8+4VHvQWD7uWNJ0Z7SQ//lQrrek2MhVw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791034843;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=DsG/uF6WQTk94kvngBj3z1Ssqcd5aAEXQelWQDRaJVc=;
 b=T4KBqj0a4siGp/KO0ITRFplpXgUdjzGF4zbE83Fn2scSapgjfkGY/4baxSYRygwkS9mT
 qae7ubi8GmG69M4vh1EV1lM4MxsJooaAyEi7043nXM4KozTgfU4mxrjlYq4+/jkXLLdSZ
 PZJXu/RjE5S4p6i9dPw/xf+lciUTfWAjekqZBX2o4qcgEVkWrYZD4pqUgIM2kjaqX42Ub
 vqhMI29wBV8nF6jnXiDCMdGW6EQW8DJVkfuaRW9z5O6gZCTr9TYnISuZkfuX7G7PzVD2v
 ed3meQleaf8sg1yyRDgG3pTPLlrBO2aD7kFLCEt3Ny8nFqOI5SM7MYWS6LIj1PuMwQw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=jGcmsKuf; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::c;
 helo=mail-ed2-x0c.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=jGcmsKuf
Received: from mail-ed2-x0c.google.com (mail-ed2-x0c.google.com
 [IPv6:2a00:1450:4864:33::c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B7E15414B2
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:40:42 +0000 (UTC)
Received: by mail-ed2-x0c.google.com with SMTP id
 4fb4d7f45d1cf-6acb6b726b5so589867a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 06:40:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791034840; cv=none;
 d=google.com; s=arc-20260327;
 b=Njs3b2MEuZ5+pbbqRshUX3JWyyA4HF3S7NsO1UboLBIEWPZWiUGis8Lj8r3tR6tyCx
 MrNCeTcacAKzHoZ60crNjewXkHGbS0NL7b74w80bwC158SKV92Qh7XZyDFV0qlVCnQxc
 KXWbHPsl4zssMA250Gckvc6hXvjeADBbkprYXvdB5fc4gF8g2rfettwENfTFJOgfzwTL
 Qw2Uyw1JCfSAMfGf839g3WtKLx3VVL8I6hFB8Ryaq5LjM1G8lvhFZMEE/7g8agq3a4zq
 7w/o022b/LEn3sgWiVQKgM3jN76bPRWb4fczpMAlfxp/HKR3By26YsHaJ8Z3xuj2zTB5
 v6uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DsG/uF6WQTk94kvngBj3z1Ssqcd5aAEXQelWQDRaJVc=;
 fh=DRMAGgHoPax3R1r6Pn28XA3dtWVqztZPwpEzfTF4Rao=;
 b=da5FUEsA0DEwwI5JE1is4Fxe0KDs6lRQ4OzQnh68A8Enq/qWS0aoB8saaOGIzchUHY
 Ul2IM78tMnoJkxqsz+etN/8Bl8s4iBA9ktk3afb9ggFc52/8IFYm5U+RZNPUjcIfE5JR
 LXzUEEmnGQQbJogKkwismjQ5m7nUubd8PGaV07vDliIKnCYQ2aHC6kTUWE4+dAV67oLV
 USTapvmJ0wZivzeEKNIeVKQr9uSZfnUAikkylrXBkQJJHefVxNgZI5l2TPcFK+tBwyXy
 cxdk9VEHfAJo0xIRvXhM/C7QKIKt7pnFglqHW1YR6vY/cETVL4e4upBnC1eZCxHFXv4Q
 V2BQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791034840; x=1791639640;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DsG/uF6WQTk94kvngBj3z1Ssqcd5aAEXQelWQDRaJVc=;
 b=jGcmsKufSBhOuVzwMpDaqFGGGwsUFGmOxaoqNi5kko6OXX0Q18rklVIew0e6Ba7831
 rOn6I1+zLiC030BpXOc95yJlkotxG6ow6wc8uhAXnw3aDWvGq/S0EkH27jabKzDffdR3
 rTOwKUCHSGcZVS+7+YbfiuX+mQSw52+T/OLmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791034840; x=1791639640;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DsG/uF6WQTk94kvngBj3z1Ssqcd5aAEXQelWQDRaJVc=;
 b=p3If12HMRb0SvKW3caoy2dotIjwq+LWWpOkznjWK3MPA5dagF+kYZAMCE9AhxyoJ7P
 Ab++27Cz89lgU/R8fFkUWEigvqjrKl5IG9tU4uWOa0IinwwTiJleXQoopzzfmTWjLZ3O
 8WDxQSBNXauSuDcMrw+/PSDyh1ynhwOrB7bZ5Sallc16ClcdwmU+CXOKnO6kQi+GdBp0
 e9t3UqlvPN/mk+bo0Dwl1npgFseoNqNIaz9km+gvNXSiKKgXgbnwJWXL612rkcBsM1x+
 4KK4mgBFz+AUADEth4fwINCaecUB0Zt+V0OP0WNxABVvYC/OFEDjGrSFOvKfrDXgbuCS
 9GQA==
X-Gm-Message-State: AFq9FYKPSKJ81GlHXMPKTYaghMlmujFKXSzk5qdWjpyGiaACrGyj7n69
 wnuIO1i05KvVY0K9X64Uf0pSpXZ0nkjANBrN/P0wd1odnGe4m7vBVOkdOiEnuTdzUMpC9PHndhm
 t7apfN2dFvv9vilHKYJxYmMFoA2gr68aR2Eia+JNe
X-Gm-Gg: AYBFou2I+1QEJIqNf1/wOUU9xLS2b/OAXwG1NztLp1gCbyAxbTN4aAuC6iuvVe3Onnq
 dOnI/0PpnsNZDv25wc54C3MMerrusUFiMvnuTVja5hUjGwmJ6G/kiifBtNvDkWCQuoSyHhT9LKI
 J7nut0Ihg7VqK619idJ2+s6E5bGrtKiKzlXomx7lCsmT1Y2sveQSw1+eUfERjG4s9uAYHuaBRfc
 jV48vrMwU0C8l4MABzkG7wSvLT4jzmjcLf2hCE0RP4gg06c4mFGgpPMCIjAjboic9cf90KxpGWv
 VcxKHAq0SepGlIOcNDOAmH41xKpRMMRsCT3XobOvMKE/++6i5ZWCEc8=
X-Received: by 2002:a05:6402:a25b:10b0:6af:9f9e:c1bf with SMTP id
 4fb4d7f45d1cf-6af9f9ec31amr3254994a12.21.1791034840448; Sat, 03 Oct 2026
 06:40:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
 <20260918-spl-fit-compression-v2-3-28e946f57357@flipper.net>
In-Reply-To: <20260918-spl-fit-compression-v2-3-28e946f57357@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 Oct 2026 14:40:26 +0100
X-Gm-Features: AclHuK-jyy5ANqnn2XsFaXvbPnENkLmFBrhaEIU46IJgm1iC3Yb6hNe_OURZI2g
Message-ID: <CAFLszTgXsSaCOEsDuULahHCK-5Oq0kyvDnRiPOWmpe8hKpF1KA@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] lib: Let SPL minify zstd on its own
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, 
 Cole Munz <Munzzyy1@proton.me>, Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
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

On 2026-09-18T10:52:27, Alexey Charkov <alchark@flipper.net> wrote:
> lib: Let SPL minify zstd on its own
>
> ZSTD_LIB_MINIFY is offered only inside "if ZSTD", so a board which
> enables zstd for SPL alone gets the full-size library in the phase which
> can least afford it.
>
> Add an SPL-scoped variant of this option and key the build flags off that.
>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> lib/Kconfig       | 12 ++++++++++++
>  lib/zstd/Makefile |  2 +-
>  2 files changed, 13 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
