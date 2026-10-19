Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE87ECCF2DA
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 09:23:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2247760740;
	Mon, 19 Oct 2026 09:23:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6sAA5426a2Pf; Mon, 19 Oct 2026 09:23:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4FB0B605F1
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792401826;
	b=FDEP/VGbfO9IDK7HQG7TrYG0AvcPDR4y4nxqTTnkIHQUogOG7ni4GOyKawupj2KL8UWm
	 +skzAoLbdcJQP/9TvgtpvrPPquuSk3BKbPNL74nTLA8NjnKEO5TtPuIeCFTkpwqQLLevq
	 6PiHzXTj1QLbGY1YweB1oaKd0MLj3EQTWUOfelOE8zsZ2pma/yGpHeGpksbn0Bv9aPO+M
	 QdRA73LOO8muRux/z5Wyk2V219NP3FM+jPiWqBtymvb6rTRjY8IC9aMG0wL9tYR76G/dU
	 AjZNP2clXq1cBWQXTW115o0P+4N5c9+D7c+Xk4JlkU7t2csrgKg4JHp/icPBRmnH9kA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792401826;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vRDZBa2Lc7/0xfWe3k2ZRt2xpdQMpYflsXvZFB5honk=;
	b=m239j4o1hS7XJXZJJC87hqwLoSqCR9nOHb8MaWKdTfFxmy9hzwrGXS2S0s6bsCJ9+8eO
	 b5meP1SYo+jsLNXxU7H1co/pIcGMkY/X9XhOWs+LyAuRo0BIKzlWz7QjVfuyqWTCP9fG9
	 dRA8vlvpYxWh5OEmKlTm7IWmmjmqwdR+nd/Of8T54hWY5WeMmokkMsqUmNAK5IPnw1wMx
	 GnBeP6sV122beaV3Jw+P3C2QIt5TgWq/7xKEKWbeVhVwNt16iLHdOkO2oqR1qPQxbAZxs
	 yGpeMUAH8t9W6agiqtSTJ9YMUjml0O+3VqOeBqLhmH5XRme13cBfUwo5FeM89osQJMA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792401826;
	bh=vRDZBa2Lc7/0xfWe3k2ZRt2xpdQMpYflsXvZFB5honk=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j+pw8vys1wNPl5RXzxLxUgrX9a4TpwC23wFvY1qsiB8bc8mxKBLqiySiGKaIl/EAx
	 txQvUJWHpf7R9oSEKusLAG2Cw9OFhNDPeZUJ1eRUtpWj+IqoIL26js8e4+AHz0spp7
	 GUCC9ml0XTlIcLzN8MIlYqy6+sw8KSXP99XjCV31uL8s8/ji7T9Bkdl4cDTJY+NzS/
	 ePsN4Ix48JeNo0uPxc7SVngUTrCpSEKwaO//AeVd12L4xkwRiwWcm2wBIpUG/dBG4N
	 pRl578xvGtBVfRb+P/8EQOwzuwZs+mzlYaJfal+DWL6zFMOOj/u8e9LZYpjjqnHgFf
	 ml1UjB9j+J68g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4FB0B605F1;
	Mon, 19 Oct 2026 09:23:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 82D051E9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:23:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 70FAD405AE
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:23:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F4xOG-GVvVCd for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 09:23:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 608EE4046D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::534"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792401823;
 b=bU/ZXuIg5kUQFKhmXpSFy/ZPnc4vNUOZaLVNICQXH5ckYCBmAIFxAmemWJ4jvcYPbTNE
 83CO9ci4OGLuWVHcayacxQnlIrvNGijkMETZyZDx4WlqSTIYX256HwhTbl82m9Vr+fUx8
 F3x6IbgWiV5drIkopJIPdFbefHFatYV37ycl5dyf2OtLZFYlLwd6uIN150C8GrgYXje5h
 hABTO8ZKyI1pkwK7JV+j4y4toKm3EbwqqdFlgDciBS2/raK6Km1r5Z6g0w5aHOP2LHOOv
 L11fJg8Ku7aeqGkuRKA9hfZc2uIiezJSrnxb7g6u65khGr98GeRoJvKt2w4yAPuanVQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792401823;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type:Content-Transfer-Encoding;
 bh=vRDZBa2Lc7/0xfWe3k2ZRt2xpdQMpYflsXvZFB5honk=;
 b=NvkEAHndYcNmJiQjgYOVMPI4uyRCVquIyRVxBPVSykQdm57QH2BEg7GdjA8I/yqfMggS
 AoWDRZ94nkzG4K8McqHbng9Jqy1HBp8OekkD0Hrn0UzFbYSQ/D7/rj6KvzoFtHrRfhWOn
 CgFTLhwH26YIdhldSEgXQzpEIBZqyAAjqxIaN6DlEo8ysjfhLbRY9edNI0y+6Xp92YyCS
 GvWYLCPTYg9UHKauCC7j9FRk3n/jz7hZX+dEjZALGOH5UP1hWjTjxj4WO+u7ccVX3Ln4E
 hvfvRu/ExBfVqaBSshsXAUwFBDh1zIuO7YPdax7Ul4OX41++zmxVAI8aWDByL9gKUJA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Sdws8PN6; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::534"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=Sdws8PN6
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 608EE4046D
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:23:40 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6b167ffd132so3183276a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 02:23:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792401819; cv=none;
 d=google.com; s=arc-20260327;
 b=jK4SM5bLp1dwPtz5R4KSbor8w5idJVzht9WDJwdWy2Gq6Azq0frVcxnb3U0n9z7qAx
 fv5cdQNdmvNe0/Fm/MDuL+yle1e6aLQSYoVlzxIcPHFH2Tm3eYE8IfAkanoR9FTneHCn
 a8nTW2zJOrcjpgnQB1/kMG7NpGLqVC4I9KThRdGB/AdZnV76FUXOYflXzNlEZ+8/du3I
 DJPYyw+pSOeoX1UMlZJCy9JlptZg9un/A3Iis8xsLnTsVZL/TXcYvM/fD20wnLjdKa5Z
 jiHunl+BrVFSRkf2Nhu5jlwu8Ihw8QBb3aD6g8uQdwlp09B67CSaeyi3pg83aI1nkAPx
 LUog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :references:in-reply-to:mime-version:dkim-signature;
 bh=vRDZBa2Lc7/0xfWe3k2ZRt2xpdQMpYflsXvZFB5honk=;
 fh=kcTwKzLIqR/+Se2R+6jxC+vUBOe/RTTnwqJw2bt0OAk=;
 b=TxoCMYDSdxTbdWsAVCqte1nVZ4bQUGopR0LLZiRRH4JvquZ2XatjSc9FRgA22sti8E
 XpgsqMfGQu2g5pxtKYu/AWIKzLml7zLUqQi9ElkatSAZvm0oIzFluH48AFViQ3P7OkWg
 C5Rnsp3+6NUZUUbGCV2a3tWaivolpN5Mp3dJxD6sR5Y1LKmLV8eJUQC/0K4H+k/Ow2L2
 QRCOEnyGHjEwt0V+tQtJJam5rBYx8JsctIro1cGiuRvfVdh+3sx/NUIIDc0squ7w7v7a
 rem7n/UG2FpmCoXUtFLCEZiBbogDIjU3d/YF5Y97j8EyvoUJYqft322Xwi3J2yiAlKKS
 I+1w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792401819; x=1793006619;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:references:in-reply-to:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vRDZBa2Lc7/0xfWe3k2ZRt2xpdQMpYflsXvZFB5honk=;
 b=Sdws8PN6+fJGcD94DPn/uhIO33uqKfr/yBvBILLABPtrMmwepOgPm5qMf6DaDxz3D9
 6dHWfoZNA3u8QNEauO39vZ45unX5gJs12PGOd414hqF5B7rdUxp8Kq0tnyYxBanuwG1M
 YFb20LXc4Q6HRBlZoitJ7UdwvRvo/XkLYB2Rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792401819; x=1793006619;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:references:in-reply-to:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vRDZBa2Lc7/0xfWe3k2ZRt2xpdQMpYflsXvZFB5honk=;
 b=Pkd1eLESNMmGF0+yBa8Ri+qzcW9SFwOA4CG5wzif+MZtM+ej/kH7Mt5eir2LtreFYf
 GZVQlEvk1Cg5pcREEbgJCMkaXGPX5gq7B0cCnoT1uA8fTcv2y0lnnQ9nC+UrzmFLiN04
 hyAki5p0m9/DBGW+Y2G6MSytk3EXf4GUDvtxukKbwrNxQZM89jA4A2UUNomj3jSHRUnm
 ETdxfMifsqQDFLJ9pdAskbehSp4pCXi8nfrYj7bQYcLh+yBWDNdZgVwNLai622/3PB7F
 jM+tLwFTkXQ64/ChnN+ZS+skRwSsWIetSbkzeHYzzNqqTgSZ/NCcaD8/xvxFO0Lq0Ky3
 7IuQ==
X-Gm-Message-State: AFq9FYKjKUKydJTuLXrpQVLELtBS69cyVicfBuY0u3XvJRwu72GZSjgW
 Y3cYFWSA1qdtNPmsjIOLezt3iSiV6BwmKqtVaB8/H7L+g4BEivdIKuN5cpDZzjpAgYP5tLvmav9
 891C9uURIX8ubI03KTuqg3XfjWhBzq9TQ8cEbrd6B
X-Gm-Gg: AYBFou2B5z3Jrqq/+pxMX313YLqjbt3VoHp7JGu/emuD08J4Qtzm7mkkL29ph+42Owh
 q71MFJoFFrPyhJ2WdVeaIqENx+nVora3Mpcrp38pXL67ftUOl5yP5pU8LUmWu0huILrXwnQbSWN
 5jOLXFXLuX6NNrViDYdho7r48/xbkzVPR+ZGtBZ79c7OPHi1h9po7O335/RNSRTs0sn9uXMqxJQ
 Fi4tNYREC2FJWHjg7WqJRaW/CYRkedKuTKNn43hZ4sOU7kEWZaPLAd1ktQ6/wCLDqqjDwakkSNx
 4Q/fQ2earc047xbVAvrNjIPw0e5XYq3FuoZ3khEKxDVjJUPAvWQn9w==
X-Received: by 2002:a05:6402:27d3:b0:6aa:ff76:3076 with SMTP id
 4fb4d7f45d1cf-6b3a8191bddmr4428988a12.32.1792401818940; Mon, 19 Oct 2026
 02:23:38 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 09:23:37 +0000
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 17 Oct 2026 06:36:29 -0700
MIME-Version: 1.0
In-Reply-To: <20261017-b4-binman-fit-fdt-compression-v2-2-d7e290847543@protonmail.com>
References: <20261017-b4-binman-fit-fdt-compression-v2-0-d7e290847543@protonmail.com>
 <20261017-b4-binman-fit-fdt-compression-v2-2-d7e290847543@protonmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 09:23:37 +0000
X-Gm-Features: AclHuK_OXSE4zZhMwMZPZ-KA9sft41ZusYkbnglewDQO_3T-yshk69G9fQ5F4QY
Message-ID: <CAFLszTgu24i6C4J2tabaeAmNnYWfw8Y0Cr=xVuuNmcS+2uG6gw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] binman: fit: Add fit,
 compress for generated fdt images
To: petr.hodina@protonmail.com
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Petr Pavlata <petr@acrux.cz>,
 David Heidelberg <david@ixit.cz>, Alexey Charkov <alchark@flipper.net>,
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

On 2026-10-17T07:38:59, Petr Hodina via B4 Relay
<devnull+petr.hodina.protonmail.com@kernel.org> wrote:
> binman: fit: Add fit,compress for generated fdt images
>
> The 'compression' property of a FIT image is only metadata.
>
> Add a 'fit,compress' property for generator nodes. It names the
> algorithm so binman compresses each .dtb with it and writes
> the algorithm to 'compression' in the generated node.
>
> Any algorithm known to Entry.AddBintools() is accepted.
>
> Register the needed bintools in Entry_fit.AddBintools() and
> report a missing one in the usual way instead of failing.

The code does not match this. _compress_fdt() raises ValueError when
the tool is missing, and testFitFdtCompressMissing asserts that
behaviour even with allow_missing=3DTrue. The usual pattern in binman
(see Entry.CompressData() and the mkimage path above in this same
file) is to call record_missing_bintool() and emit placeholder data so
the build completes and the user gets a single consolidated
missing-tools report. Please either make _compress_fdt() follow that
pattern, or reword the commit message to say that a missing compressor
is a hard error.

>
> Document the property.
>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
>
> tools/binman/etype/fit.py | 67 ++++++++++++++++++++++++++++++++++++++++++=
+++++
>  1 file changed, 67 insertions(+)

> diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
> @@ -274,6 +274,29 @@ class Entry_fit(Entry_section):
> +    Any algorithm supported by binman can be used (see the 'compress' pr=
operty
> +    of entries) except "xz" which FIT does not define or "none".

The "or 'none'" tail reads as if 'none' were also excluded, which it
isn't =E2=80=94 it's the default. Please reword, e.g. "any algorithm suppor=
ted
by binman (see the 'compress' property of entries) except 'xz', which
FIT does not define".

> diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
> @@ -1148,10 +1197,28 @@ class Entry_fit(Entry_section):
>      def AddBintools(self, btools):
> +        # Add the tool for each algorithm requested by a generator node
>          super().AddBintools(btools)
>          self.mkimage =3D self.AddBintool(btools, 'mkimage')
>          self.fdtgrep =3D self.AddBintool(btools, 'fdtgrep')

The comment belongs on the fdt_comp_bintools block below, not up here
=E2=80=94 as it stands it reads as if it applies to mkimage/fdtgrep.

> diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
> @@ -1148,10 +1197,28 @@ class Entry_fit(Entry_section):
> +        self.fdt_comp_bintools =3D {}
> +        def _add_comp_bintools(node):
> +            for prop in node.props.values():
> +                if prop.name =3D=3D 'fit,compress' and prop.value !=3D '=
none':
> +                    if prop.value =3D=3D 'xz':
> +                        self._raise_subnode(
> +                            node, "fit,compress 'xz' is not a FIT compre=
ssion")
> +                    try:
> +                        name =3D self.get_comp_bintool_name(prop.value)
> +                    except ValueError as exc:
> +                        self._raise_subnode(node, str(exc))
> +                    self.fdt_comp_bintools[prop.value] =3D self.AddBinto=
ol(
> +                        btools, name)
> +            for subnode in node.subnodes:
> +                _add_comp_bintools(subnode)
> +        _add_comp_bintools(self._node)

Just to check =E2=80=94 this walks every subnode and acts on any
'fit,compress' prop, including on a plain (non-generator) image node,
which the _build_input() path never honours. Worth restricting to
generator nodes (name starting with '@') so the two sides stay in
sync? Otherwise someone will set fit,compress on an ordinary image and
silently get no compression.

Regards,
Simon
