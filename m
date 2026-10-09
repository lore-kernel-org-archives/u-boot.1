Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA05DCA601E
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 12:19:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7EDD281149;
	Fri,  9 Oct 2026 12:19:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MMXtt7RB0a-5; Fri,  9 Oct 2026 12:19:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ABC1F81107
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791548348;
	b=BWzBOZoDyWlHyYfNMY8CGa1vUGqlv6y9wI/2NZKEHxJ000uvc8ZqtxoXTOjVy/dI0SXr
	 iil9aKuZ8QhkhJoEcLcoQfp5la0UqBQrHau100kJvTu6+T9JKZfaRfgtnX/OYJArcAy37
	 cWT0TCEc6EHjr44mP6RnXDUY1ScwlcebmNCO9VEaDYbVLb+OEJ3L4jGBNfKVr+goRWneN
	 NRsdqTgNj5EPHLF5wLzADEGVyFCZPxyTNWiV24mFMus9ZGXOrcf4HAV27vf5VDL7Qy9aN
	 UCrRT66Vr+h7ckbEVfyfUlQUaOlVazrmuQHi0S8B3zze8dXhyQ8NdHFwRGOpTb6sDgg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791548348;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QFYcn5Mb+biGafW7p6PJfZu+QtuYcSuW5c+lmdo+mo8=;
	b=G6dbaxkABS07gK6LPJiy9Drloo7qlFVTo3+JkCLEtt/fFCGhSQWu99pwXURF21AVM2Ob
	 xHgBuZ8AyuHd6mBvPPWjmn+20Bxs4mXCLf1lFDhQNFuAhk5Bby3OvQZolZC5mLMzBuEE0
	 kQyeslnSVOIEYdPve8nWQrEMh92niQTG/YKo/PsbSVQulij0hFt1JD/93lX3e6DsSPQEv
	 h0SRWbN/rALdEO5jqZC0z7jpQYiRkh8i++1wwOwLPW0G1kCLZO5Xu2OMgbRWgKGGtAA85
	 bott0usNkoTaAPCzIoC7QugvwwOuh4GRhIl/nWo3LedZfmo7dT9q9nYAS9XqZvGER3Q==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kGtRX5he;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791548348;
	bh=QFYcn5Mb+biGafW7p6PJfZu+QtuYcSuW5c+lmdo+mo8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sTN9YqTpeg79Zx3s3weeQDsBLTSUTKT/kk0R2RVm1g2M2cVPAGz99sBqVL/5Le66s
	 dTq/JIkkqTUDeQ5HFZjBN3MFzVSNrAimxkpFnZXZLhMzUGfu52Ti4OrV7L93lpzWcn
	 aMX/OUJ8zCO8scxClPRT6IOflHdoP2FTq5iXynd3lbMScYYz+tv7tQoOulcSWJvles
	 MWwHTpUjwSXEa/6mGeWrtQA27FT9F1CpTI4AbB2+lvIS/KI9+sYF1jUHJcvBFqbOfm
	 iZW/jqJcoz/KnlgjkrNWEQy9UTIPFlGU0F/37YM96bH0VDhcRmVrf16k3VmOpFw5+5
	 DIgkUO5Sr745A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ABC1F81107;
	Fri,  9 Oct 2026 12:19:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A480A1DE
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 12:19:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8AA9381287
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 12:19:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L96NMNi3FjTJ for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 12:19:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 64EB881107
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1134"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791548346;
 b=Yg8QB5qZ8Ct7kjxoIecsHLL0sJ5pCqQICl8RCd6NqBVnAv4uPkMa9msMFWF1Ez6V63GA
 wPmJtn3pYDIBdtmR9patee7414rCd+JEHGDFkcs8HN1y95FdBimdSK8qkiW3dGHgumg5x
 ZOjh36QjPieXsFugHL24S4iLK6B9BuJuGvzmE6l1iTwtU3JiNGgox9S+Yo7q9OobDGx7C
 Vh68yCqVAtIGQsuxIY3gfV15vrjP6LLeAAFMfXfvsmH8lvtyX6luQGvcgfsgw5yg+ETyt
 DJhqegv3UQaROFh0tCH+PzLxbhF+jtpe9K5dAEQJCrdgbUzovJtQXoDkIKWEyI5cLsQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791548346;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=QFYcn5Mb+biGafW7p6PJfZu+QtuYcSuW5c+lmdo+mo8=;
 b=A4YfSQTlWfBlST81zILTJIGCnHReCmAEAXSfWxAOA6R6gM0wzM6iI5BZMxHkvlp7baiN
 2TcUq/CNNbuTDmZRThW8pG2OiKbDwpOWJrIl60xOqGefFDJFTiwEyuiTt1AaFyBqWNSar
 JTu8FduZTiJTPvYrF7ETV1Tkechrl1f1iVTYfX75Be7Z+SKytGEqNkr/7yzuZefI521ma
 TyXUh6ua3jnw8/XuaEU6wfEugVabb0GM5oZjGQ4n/OIj09ou46sd7xTGzuTzlkmwQ30B1
 6dEVvfPoWLiiYfNgIt6E0mydEkPi80ZnkQstHsPO7eW3ZNGaV5xxyB5D0OGGSVcBtwA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=kGtRX5he; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1134"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1134; helo=mail-yw1-x1134.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=kGtRX5he
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 64EB881107
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 12:19:04 +0000 (UTC)
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-8aca54b75d4so12811927b3.0
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 05:19:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791548344; cv=none;
 d=google.com; s=arc-20260327;
 b=o/H1kzh0GQ3Cw/JBBmkt9Wcq8IUdL/hUhUVqiHtRDdaM5c2ndd10YlXi2anbDucubm
 kn2RYmPxKoPEEiQjrBivsPjEmPipAV26eyrC0q+d1yMfgId5Vg5WaYbHycxRCWPLBn/9
 ULpES8LIQPjjg2M00o1IKBAbcQTjpnD6z/vGA49mF0REsoeqL4EDdy6KzWPAnauQPoAq
 9WQID2LIY4S9xqtfZ7GJmwvjuGWBD0SiZDbbMHTyScL/bE/3rpKFW/7VBpC8LLMdNmMe
 dvFufuRubfgJrKEeoAVzIkpRWTPOu61AxJGbWdebKoKgM6HLYuaX8jDCaKC/0OP4OF86
 JUcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QFYcn5Mb+biGafW7p6PJfZu+QtuYcSuW5c+lmdo+mo8=;
 fh=POLhRcnKGOpdukJDOzd7uUI7C32yo7oDIG0MQQyFg7Q=;
 b=exocRJVoW/eF75reCn8EZ+FbCzH/hEsUtpG4IMjNWrR3yG0L4aP2TVW/dheADjPhxT
 XBxZeamHdEMhEq/Mkn2Duueclnuc3qvGffvY7mva+czRFo39AzvPCWLTnbNN06JsN+KA
 jiZv6MCB8COYhKMMNutUNpRTuSkGbYsE7nHDnLIt29p4KQGC3arXu2OxYOgTR+jol4JA
 4JiHTFDpa8CvcmTzRUerQ67tmHrHrM4ZZ3z3fcZPvrCbDFFjXU9F/JWY0pkTzioeU4FZ
 BNc4xBkjvJhtnUnzVBL9oA53WkHS7gD1On2JveY2LF4VB+LQICXpZxoG+Jp0CTtK62kf
 YaRQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791548344; x=1792153144;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QFYcn5Mb+biGafW7p6PJfZu+QtuYcSuW5c+lmdo+mo8=;
 b=kGtRX5heGbeKiFmsvemCeJA8BiMmDT3OQ7GqtJtRk14V6msW+evQ6MTaOEZoRVdVwj
 OFHCoA20SpMZelOVf2mUZifHzNRhkedNkIPzS4phjB/s35+So9R5FWjrIM8jWTAzC0zi
 oY3RwRm9Gm/69772hYdMOG8Hkfjgzjr+o7aUxNGpROPIIN2NWKonXs7hYIQ/HjRjHMBg
 ZHed6XpqFyejeyNmcy4Vu0t57CBc6ULG5GIAKhEBuO1fOFnHg0qdGcSzSTDnJRTTeFc5
 CmZG4j9NrOq1NciES+TDk7XKczXMfhAwLRW6OyXDVynZjBkABsmyzXIar/Yokf2v1fiZ
 RfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791548344; x=1792153144;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QFYcn5Mb+biGafW7p6PJfZu+QtuYcSuW5c+lmdo+mo8=;
 b=dFL1DctiEqq+Prcz93X9Qz/PI25PWWPw3SqQ3iFlt1EC1KJygKddBmSVi8+d2Va8wD
 zrcgplPVP7OawittRllyNMg3TmIfTYCDYlEqIDHyzrsYLq/BR7GmVQpm/99bPfLW+v2s
 UcZ486xP+u06ttcLmYu5RJ7QpjTHsVrPtsz6lKLIo4jFuG6qpTADAMkDJkjyAE4aWtbN
 F1Lc7nhTbZqOYN98mhKs3invTk1IaaGf+eC0pJdFeGGV8OHZqEucHxWf+Zo77Kr59Tnn
 wmO7GUA9leOiv8k/GBtKM+3cNrj3UiZmZEXNiwHClM8Sam1UvMOPmMfB3zOjIVDU9JCW
 Syjw==
X-Gm-Message-State: AFq9FYIUZX1TdZ5O+z7wQS43OcKF23MirESNKbAeKqWCIqYq8PzoDQnx
 FW/QZB/AJY202JQX56WVeAYg4yR4MjyBofdZFkM7Nc/VInYveU9V4l77CmhsQN53kMX0DrX/09g
 UFdt8qpdoohaJPBriCo9wIvUC6Uhp505VzN6VsTQp0w==
X-Gm-Gg: AYBFou0b+pHyj0rsJcciYCHkYFFlqUTH0H1uhVA8nU6zHsySNfCUMqT6mQnZPLn9ciC
 n/Yw7pJ3O6Qk8q2whxh/0IwuxSE9GfWZu7RkVQ0KXw57138st8c/4wyIy+eV3Ju4GLDP9oT+Uo4
 vvQpGFAvWJauR3UZtbCmIb4lrpFVsM3Jz7Jy+H0Zia3W8SbYRGhtAiZIs3g26+3x0dMdTbDrmqX
 XHljUv1/NLEZdL1BUDa3ooBEGRYsNu9qLr9nTxmUrv+xaoHj7xNF+sAWoxkJGSL9cBHzbCCOQEQ
 kbLhOvbpUkocZAelnBdoBmL53Tlt90HcDtS04zUPWmTKEtv8YazDCbfhwxJfbU11alhqL3KwLFE
 iDndr0EUZzUL2KRc+5XwTQmaAWydoWneiE/7/TSzHLFtT+GsVHiLClxH+8ZkaBZr+kzTue+OW25
 +ZeuJJ78MDGCVnat7i/KxngBRNhz6Ox4qvryWK2nM6opkXE0P8c031fLjj8kumGHITGex5Oumhl
 KiiCQ08M/Tl91PDb5v7oeQBJrriC1IQnGNVOFOvkvK6+obxvDwlYhS0f38dBUfqn/EXoKJswFMN
 x+uROahIVbEhIMv/9XAVNBBu1FL4cI/hzSy8oTcjAd2BkIDIucrVOy5vuf5+9SoWPDiniLofheC
 E9Jjou8wUZUfP4NaM3iJPcFhga4hNnykBUjs4hGT+L3oo6eJo7GhYAkjTEQCv0AuDyw==
X-Received: by 2002:a05:690c:e209:10b0:8a4:e89e:5185 with SMTP id
 00721157ae682-8b07d3c429fmr4736277b3.9.1791548343617; Fri, 09 Oct 2026
 05:19:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAC928HYhgVNM9BwpJJ821PWpZuR2gCKZisuQK4exKSCG42AO3g@mail.gmail.com>
In-Reply-To: <CAC928HYhgVNM9BwpJJ821PWpZuR2gCKZisuQK4exKSCG42AO3g@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 9 Oct 2026 15:18:27 +0300
X-Gm-Features: AclHuK_9tg4rEsRZMOgGxMXxB3IrN9WAAsezQv6BEtjlxRWbnFLsrBGGEB73A2M
Message-ID: <CAC_iWjLbGY1PBjJVcHAc4dsG+pb9EvVS5y1TXShHBvwVw3OzLQ@mail.gmail.com>
Subject: Re: [RFC] XPL linker scripts and related Kconfig options questions
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <u-boot@0leil.net>,
 Jonas Karlman <jonas@kwiboo.se>
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

Hi Massimo,

Apologies for the late reply.

As Tom suggested, I've cleaned up the non-spl linker scripts to an
extent. Cleaning up the SPL ones is indeed welcome.  Unfortunately, I
haven't been involved with SPL much and I haven't been involved with
TPL at all.

On Wed, 30 Sept 2026 at 20:46, Massimo Pegorer
<massimo.pegorer+oss@gmail.com> wrote:
>
> Hi,
>
> I'm going to send a patch to fix arch/arm/cpu/armv8/u-boot-spl.lds linker
> script, making it honor the TPL_SEPARATE_BSS value and not the SPL_SEPARATE_BSS
> one within TPL builds (quite trivial). In the meanwhile, I would like feedback
> on some doubts I have, starting with the comment that stated to use "#ifdef
> [CONFIG_SPL_SEPARATE_BSS] to avoid using CONFIG_SPL_BSS_START_ADDR which is
> not valid in this case" in commit:
>
> a3403e6fbf8 ("armv8: Support not having separate BSS")
>
> First of all, I've noticed that there are several linker scripts using
> SPL_BSS_START_ADDR without any guard. Second, the Kconfig guard for
> SPL_BSS_START_ADDR is SPL_HAS_BSS_LINKER_SECTION.

I think you are right about the symbol dependency here.

>
> Therefore, wouldn't it make sense to have the Kconfig default value for
> SPL_LDSCRIPT pointing to these linker scripts if and only if
> SPL_HAS_BSS_LINKER_SECTION is selected?
>
> Moreover, I would expect all architectures relying on these default linker
> scripts to have at least 'imply' SPL_HAS_BSS_LINKER_SECTION under their own
> 'config' ARCH_XXX section. But I found it just for ARCH_SNAPDRAGON.
>
> ARCH_ROCKCHIP has a second 'config' statement for SPL_HAS_BSS_LINKER_SECTION
> and for SPL_BSS_START_ADDR too, the latter losing its dependency from the first:
> unselecting SPL_HAS_BSS_LINKER_SECTION does not make SPL_BSS_START_ADDR
> undefined anymore, which does not sound very good.
>
> Another point is related to the relationship between SPL_HAS_BSS_LINKER_SECTION
> and SPL_SEPARATE_BSS: looking at armv8/u-boot-spl.lds SPL_SEPARATE_BSS makes
> sense to be defined if and only if SPL_BSS_START_ADDR exists and therefore
> SPL_HAS_BSS_LINKER_SECTION is defined. Is this always true? If it is true,
> shouldn't we have a 'depends on' SPL_HAS_BSS_LINKER_SECTION under 'config'
> SPL_SEPARATE_BSS?
>
> Third: TPL_SEPARATE_BSS exists but TPL_HAS_BSS_LINKER_SECTION TPL_BSS_START_ADDR
> etc. do not, even if armv8/u-boot-spl.lds is the default value for TPL_LDSCRIPT,
> therefore it would be used to build TPL too. Do these TPL config options need to
> be created (maybe with defaults equal to SPL ones), or are there no real use
> cases where SPL and TPL need different values? In the latter case, I would
> prefer to rename these 'common' SPL_XXX config options as XPL_XXX to underline
> that they are common to all XPL builds and not SPL specific only. My cases are
> without TPL_SEPARATE_BSS, thus I do not care.
>
> I would also rename all linker scripts not used solely for SPL as u-boot-xpl.lds
> instead of u-boot-spl.lds, as before, for the same reason.
>
> For SPL_BSS_MAX_SIZE/SPL_BSS_LIMIT the situation is similar to that one of
> SPL_BSS_START_ADDR/SPL_HAS_BSS_LINKER_SECTION described.
>
> We maybe can drop IMAGE_TEXT_BASE and IMAGE_MAX_SIZE definitions appended to
> LDPPFLAGS in scripts/Makefile.xpl and use CONFIG_VAL(TEXT_BASE) and
> CONFIG_VAL(MAX_SIZE) in the linker scripts.
>

I can't combine all of the above points into a single change. Mind
sending an RFC so we can discuss it?

Thanks
/Ilias
> Thanks for your support.
> Regards,
> Massimo
