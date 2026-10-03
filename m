Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F52CA5FEC
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 13:41:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E3D71414C3;
	Sat,  3 Oct 2026 13:41:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pH-SuQp0CeY4; Sat,  3 Oct 2026 13:41:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8EEBC414BE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791034873;
	b=P83w2HBPDqGv9OdW5OdxlsiyTcgH1dySqEWvpcpsiwyFMtnkbZyUwud1yY4iJP2qV5OD
	 6ziDra4rlcDBWM12gBu74daLaMCwJpFar9NdayzB5GHjdomFPFZpt1qopx8LW2bDCiuhz
	 koIYR7u2huKr6IGjlI8063WE6dbOq4DeZriwz86lrvGIxzegNvnlbS3jOpa5OBM//MLXN
	 d/683kxuZTJHPim2kC0cgW/dUcf1OVYq0v68W4cRxNG9CSYaNf15wd0MEh+QEEZpUcyzk
	 R0KIP2i5wK0Cxj2fZDxQ/eFE5l4MP2AzW1LCAhb7OWFeXMmcNkBXW1X3/mexb5J8h0w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791034873;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zwDlnTlPAlSxvUno3jtg2kePRZjWAR7qdNTjzimoaHI=;
	b=BxWOOzc6M+Fv6WHrJA4QgfVDq3e8J3Gl90h/psCqwyyDSyQ/UB8SJ1i1+QlLqby1oUmn
	 BKLqWER0ens4bMKKPPYLdWsqbL2pdqnPMidN3HlEROccI6hsD0clEFTbDjlgj9Bb3Wvo9
	 JcNxi8y+YZMW9JQ+Qj0Kl47d5d/pu/BhGsufJP/17zZpw6YoOFymI2oFq29yJSJVZFmoI
	 2b0IolC90l/M86b6jaVoFfhLLPmAgBb2bUswQCoKL7YB+sKag7dTJszWwJ4jkCs3L8k5F
	 pVRqeP35GOfyoTmktVOVW+l1gXf2mq8nMgM8uAXni+RpMLtcNca0HtFOdAZveTGWE1w==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=kDQS47du;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791034873;
	bh=zwDlnTlPAlSxvUno3jtg2kePRZjWAR7qdNTjzimoaHI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n7fwRrdCQDVGc/BEInEDSj0vFdrnwVe7wRnFG/VtSnFmQADgn2Ndrc0qzpM4Ys6BB
	 s94rXagMq2Q3A7TOzOfvYMmRAs8OdnL4ga2i5jNH92V1ii9AI8cQBBg59XM4gKHPZN
	 zUI9rzdgTmgErxq7ECs0eqgqLkx9FUbvqPm3YQQLXvvBr8jjJcqPTSq6uZzrSjDVEh
	 +u7G7b5Oz49vUfEiCtHgG/pRVNq+qXXJqzjOHRXlFGFaqnldnjOqNRqBJHM8wgD6XX
	 BQf+AY3cjuYaEs64shDmbWW4x5intbBBLPYiQwD7H2YE5Qv4M0I+Pbxa91hkSmr2S2
	 oLoXltxf//KUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8EEBC414BE;
	Sat,  3 Oct 2026 13:41:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 24F3632F
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:41:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 16CFA414BB
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:41:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9Ql-9LxEzZB1 for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 13:41:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org F322C414BF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791034871;
 b=s8CeJtdvGM0e+9WPf75Rfg9tLlH18GIgGbq6rVwd+4qgd/jWJMpJMdk1/4etZSnxO5go
 IPMHKHxAQ+BNoSy3DfMmR2rsey73XaGm4k1X2oLXMyF2uzGuFiCM3jMmQW0+CZxzE/QHt
 px+XrbiqWNjZ9qBs+iUNEU1xJuh/QRzARo2UQRng1HIJDGHc7oNBS53P6XD/0my70bCl0
 Q1Bymi5RaSksfqJsQeAH5alSrA0/O1b9yGYj5IzkuyuwF9h9bS8lF88+fMJTv1LLERsBw
 6LHFIKTKm4u+8vbwRy8lPvyucgjTOWNGBiAVAx+b1gVc+rP85jJmxE6zkilgH/E1jHw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791034871;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=zwDlnTlPAlSxvUno3jtg2kePRZjWAR7qdNTjzimoaHI=;
 b=Ye0JnWqhpwV5Jd728kR9tRrqWBitmK9CpJppoUfm0zmHnaXJQ3hfaSMpSZ8Q13fwfV4n
 udaMi/FEE4roQIfNUUnRqA+pJEeXPhc76pOxOLtnMB0+GQluaKDc/l+iKktKwBzZSHPdz
 /i2dNqlgUrwqqhHrqW/A4cqH+FF9Tw/9wOHjAG2xsZ94+5mzMGk6JYJLPHWHU7KEQorMU
 EfGFK153iB6g2+415mVNrYn4k2sb7AG6HYVbMVo49eR9CDr23KAkEgo7ICO3tOCg//Hkp
 Fp3jzoKocghUfvqkj7h9YEhjFSnFONejyeItQp35E+yv/hEPdBI8qLIO+hvwnipYCCg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=kDQS47du; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=kDQS47du
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com
 [IPv6:2a00:1450:4864:33::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F322C414BF
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:41:10 +0000 (UTC)
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a60591ae54so515041a12.3
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 06:41:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791034869; cv=none;
 d=google.com; s=arc-20260327;
 b=cljgEIh172p0idmpPJm7941QaNdTU0W9LtBfWUsNWc357YLz85DVjP2ORhgSbr6uNF
 EjTd/Kp3vK8gXCZHHDVBgghzWLXEeH0Fq+HnYLJB56XBAJrVDntJO2l5cyTe56gCeo94
 Fq2wbsdHsb5U1rubcN9HzdlRsHabg3zTqpMzz54pL4MlF/di5x3cyOIfB9JR5IotcxYg
 qTahx9nDDfd6iSAnsVJ24RA5KeN/RcztFJU5W2Ze+tHX8969FRWGpfbbnQxAh2ms6x4E
 9/ZcNYQdQPgBQGaRnwsHJkQMPjKhz+FO/HgWoi0MZ6Cz+f7Uz7H19w0Dza5xzTCe6CAB
 b1Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zwDlnTlPAlSxvUno3jtg2kePRZjWAR7qdNTjzimoaHI=;
 fh=DRMAGgHoPax3R1r6Pn28XA3dtWVqztZPwpEzfTF4Rao=;
 b=ecr6cqBrbTLyoxA2dHLlFcc4oFoFofP9F6PF3Z/zWoRUKnFF/usMR+za/nXlR0pU9/
 nBiLUwiR95tb+0yBeh2IwMstHvFWomNIu6x50kqxYkV2bZGwnO/EhHq0IlLRO1SHRuxe
 pNY7NdQI19iu41TW18DU5h6NQ5/ioaEwG61Ait+9M3dCld6zEtfm1QsVaHlyaA8A8Cui
 MOyoxtfzILBZQmKOm+yCpcl8tEqvDmrbRfOOdblhl8EQgErkDhfySiDSKsRy8l9JH3QO
 GiW/SiGr4izyme7jx40QcZAED5Wz6HIU8Q/6DCQJ8212qMLvYuoVz+U7QU4oy52VIqGD
 NCWw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791034869; x=1791639669;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zwDlnTlPAlSxvUno3jtg2kePRZjWAR7qdNTjzimoaHI=;
 b=kDQS47duVxQWWAJll9HhiciyvF2Iu2hJt7FNLnwE40D4bKPtgr3kQXok+mZMZbtnj7
 5EG3nHxQToM9pyjoqzaZXK+I+TeZFeuLzw/5afIoANGjLtg/mBlW1xjka5wgNMIofMM7
 7IVCHxqDT1u6EaGs/JHyFJ4A7WR44Ev00BiG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791034869; x=1791639669;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zwDlnTlPAlSxvUno3jtg2kePRZjWAR7qdNTjzimoaHI=;
 b=iToffphITMJtWjJfyLBjnbXRttmPkZHeUdPSdeVDhLAHZqopYHSpRSZtn7evf36YSa
 vTnccUtUM8kmTUa/n0ECAMbSjpWvs0YK0Bsijn83rSlgyIlGuBv0vNVbhX73tbO3Hedk
 jB4nCk5YtK6GhGLGAZEl1fKsTfjovjf/lgYnVn0ne6S0YhKsLv00Ap2PLP+WJseiphmT
 dcV6CclhPr4eA+WDwhkqESJ7GMvJUYgcbUXwNa7vbR4m0vIhjxAfDNSgbmxx8r4lgL56
 6CHaTJZJ8vcefEw9uw/lgO86H5WOIQ0NdwxgTRPw3Ay7906zwsf8yCCkI7kYqUalTTPE
 dzyw==
X-Gm-Message-State: AFq9FYIEm7/+uKzUKm/v2QtrIafjkSO/YwpJ1YbqfPA5Q3jUcGqCGV++
 iKRMe6ACO1JQQVIrl6Z30xECRaS1AaU6B8Jjc5qvh7bkOyNVC795eMa2PUHJs/RfZDDnlt/7WY2
 oNm1XhSP2LpoQIFjbyErgpRrMnLGQudRGULl3i+Hg
X-Gm-Gg: AYBFou1a2++MUM83fic5IN+kOULFitO5HTkUTTU/xFinT0aRrv1eoiV29MeQ6uDQRgS
 u8G0xD8oD8fjKJZE/EnnBLpFjp92bAUGzzcRmRq3NHVr0b7Br24AdeUMuZUAlFplpNCGOyEWvxD
 JVC4Iscq21T+lR0culo8J8S7x1pF8QdRvXyZn/GJ8F1okTqU7AN6keEHqWsAsUvTytdG3rga28I
 ky2Pckg2G2pfPZS7oBOT/TxAq1Cuulmvz07UZ45/LZzE1aKbm5+7kk4uZI5ghuMMsXC6Ga2n6Nt
 TXBHV7QioX7Rg448w2ppk/pNqUbsT+DwUx463NqG6e4YdKZb1QobGfQYqHJ6aqs41w==
X-Received: by 2002:a05:6402:350c:b0:6aa:734a:a093 with SMTP id
 4fb4d7f45d1cf-6af9e36fdefmr4547826a12.42.1791034868965; Sat, 03 Oct 2026
 06:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
 <20260918-spl-fit-compression-v2-6-28e946f57357@flipper.net>
In-Reply-To: <20260918-spl-fit-compression-v2-6-28e946f57357@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 Oct 2026 14:40:52 +0100
X-Gm-Features: AclHuK_hFOJfTBlPqbQWolvgZxCBs6qAhRSp_4RBHU6YhXpkLsdL6TkCjBSQtlI
Message-ID: <CAFLszTiHqnGH5R_PhwJ=B2Nr-r2FDtdChUAecnxDH+iEJYVFJw@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] test: spl: Keep the payload create_fit() is
 handed
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

Hi Alexey,

On 2026-09-18T10:52:27, Alexey Charkov <alchark@flipper.net> wrote:
> test: spl: Keep the payload create_fit() is handed
>
> fdt_create() clears the whole buffer it is given, and for a FIT with
> internal data that buffer covers the payload the caller has already
> written at the offset create_image() told it to use. So every
> FIT_INTERNAL test has been loading zeros and comparing them against the
> same zeroed memory, and would pass whatever the loader did with them.

Nice catch!

Since this fixes a bug in the test, please can you add a tag:

    Fixes: b93cc1e73e1 ("test: spl: Add functions to create images")

>
> Keep a copy of the payload across the call.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> test/image/spl_load.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)

> diff --git a/test/image/spl_load.c b/test/image/spl_load.c
> @@ -184,8 +185,28 @@ static size_t create_fit(void *dst, struct spl_image_info *spl_image,
> +     if (payload) {
> +             memcpy(dst + off, payload, spl_image->size);
> +             free(payload);
> +     }

This fixes the problem, but nothing stops it coming back, since the
callers compare the loaded data against the same buffer which
create_fit() can clobber. It went unnoticed because both sides of
ut_asserteq_mem() ended up as zeroes.

I suspect it is worth adding a check in the callers, e.g. in
spl_test_image() and do_spl_test_load(), that the payload in the image
is still what generate_data() produces after create_image() returns.
Even just regenerating the data into a separate buffer and comparing
against that would do. What do you think?

Regards,
Simon
