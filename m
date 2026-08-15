Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F02C5CFC1
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 18:45:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5E8B14088A;
	Sat, 15 Aug 2026 18:45:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9Lro8v1O-Vsy; Sat, 15 Aug 2026 18:45:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9C23C40843
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786819533;
	bh=00f/K4ESGuBGHvBD8JXyGwlrK/QiVH+FgMqbXxmD3Co=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XJ/eWWvg4jgpqJduqKCi3vkpKTxtKOCDOr/yAhR9eRxsuUelIDzGIvXRaTb5Yz97e
	 rKZGdmm3CrMoKyG3pGTBgpLAhWLOr3kUtFnuFA4tArRLiuDZ8DO8BMNWtOIJs7jRIx
	 EhidGN8EImvCXXwuM38mi1WWDRB1FfpGquWilsBKP2CQzPrDsDtGAb9VJxGqIeXVQp
	 Wm89QFVSR1xakKfSxnXNt5okdQdlo2MdbuFsZKOOwtxKY/kC8PUEv/OvH0zbBN7YpA
	 yVa8CLc+gxTOMkr59PGz+ifqLdmB/1odYIHJ/d5VZRqfOQeV6bvJDcmtdetdichzsq
	 8r4Khn+tYuDvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C23C40843;
	Sat, 15 Aug 2026 18:45:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E3573336
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 18:45:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E104040843
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 18:45:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cHC9VhrabtLA for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 18:45:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org EFCFD40841
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EFCFD40841
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=mEE9QsK2
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EFCFD40841
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 18:45:31 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6a17211b9ecso4381393a12.2
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 11:45:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786819530; cv=none;
 d=google.com; s=arc-20260327;
 b=Pc3pc84Kuyewbbjb2wu+9xDXf6Q5JUPytuREAj7no/OVkn3vrmL2c1Hiu+AeBkWq8h
 j3ctCvP1By4oa43LW0pIQZPARbpVVQXDUhSyt3ax2O2mYb1Jd8p65T/67mscXSmqeXyr
 2D80ZNPFwceHxaiHgKJCszi8cc2A+1N6oncO7XN3t8dlzAyEjgZEIiUGnDcb8Xwz2qP4
 7UCy3v5EakgPjAjKO4qEksdK2LMnw8aheZthM2yg4Z9qEkaz41ddlRZdhSEfAZL1FEwy
 u69zlL+EZjRrXocerAS7907jeWQN08tG71dBYGuWWKNHsan2YvHdpX9B+kxnIgpTwgLU
 aAqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=00f/K4ESGuBGHvBD8JXyGwlrK/QiVH+FgMqbXxmD3Co=;
 fh=cUYNs/76oAu8JC8Dnt20Op7FjAkbyXpOSgmkHUekRa4=;
 b=DU+Te+/Ou2SDaHPJzVau9PFSmphRS/B//gLd3MlNNwxxN9dtK+RaGWdcpRnVrD+PwU
 YmMndzMeVP+b6b7fWOlDwP/P6flnR5yIkWDozDO/tm45kgNWSdalUJM6uOEosTnW+tWJ
 TDFGgRCKHEc+eB89UIimE1QBv16droKwsZ4kVCZUEaMelQwlNpyWtXZMpp9vtDD/Dqon
 /1wWI7Gk93ejsp1dvOyx7y+ipqt3cNbxvZBdWPnMY7zUYqdrHEicJWvzB0axR8I4Tdkw
 4ZaOPaFGy2r5mGNN7idLhxf3SkfysP9m/ET1Ma9dyRCoyTb9yDFNNXrWl/iuehBGSTcr
 iHFg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786819530; x=1787424330;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=00f/K4ESGuBGHvBD8JXyGwlrK/QiVH+FgMqbXxmD3Co=;
 b=mEE9QsK2Asz9mdXATOgTNzu8zBbIkjq/g/b/ZDN58gUzC38IHIwzGJzGZWnIhJLhzf
 KlQPuqTCBnbzjtIQvjSPDzw1MUTK5NjObvgwpTLBFOf7ShKYBiIAAl1fnrqWAy+tWaRD
 gmof5qPdnGSq3z0//p34Bp7TcksC3NdOnjPj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786819530; x=1787424330;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=00f/K4ESGuBGHvBD8JXyGwlrK/QiVH+FgMqbXxmD3Co=;
 b=C5RAWLLhnATVlukMRespDJFhYNMZfvVngORkKi2SSo5rB++NarSFdZTYWIGB1ea0vX
 w9vryqMHf0SUpdltJcWJnQmF2VyjSkBa3F/LRPQup+IDAlgBaGS76uxpTiLb47ewPSZy
 8zNxpZUJ57pHSzInZm9np8NelGTlD7S3sTc93vU5QNdXwX8Fs0dm9FzS3EkIcqHlL7/N
 ceANyY460f+9BwfWZaxd0v+vTOD7Jti3yVOG1i3AkT7YrflR7EX5K3alrAbKIMUNiBvH
 L85otCXivnCSFfrq+RK1TXaS7JexdBH5+8hlezBIQuaMUV+ceGnw0hWkl4ZKkQGFm1s1
 QubQ==
X-Gm-Message-State: AOJu0Yyh5hKGTLj5UWZhZV2TTJkEwekHn9bRuHp+XlGYLqnKkSfZzWll
 tk6gkPlGCPagyx1PHqPflcKeV+wyzGcw3jRhll6YII8pQb0+MrLCe5I+Vnk2Y9IEfSwYjR5ukSh
 Na7ZFehXh/UKAo6r+VrXl2pn0k5ZAK5RWQNCpcHOg
X-Gm-Gg: AR+sD10M83AwbQdgLMWnFByvH9KPuvUAxYPQa4q1Pj1DwuhSlKI/seyEUo78lZjSxMZ
 rq9WEpBJiS25+Fx8T+HkifG8kse3GkFBqS2KsaLUn6DqAuP2QkPd03fOpujBzF/1UjqmYTLqQyJ
 usDxIhpRzLiGnIrefgab8Tw4vumK21eWIqDkkMop1RHLXXYCl3eurmBlecZHlEjf+GJy9yN4mIT
 +fS2sUqOSOF+M5ND2l/vEPwhJzUu+/oEk/kMqGnXEsQXdBkDfqtwqzjuzay+4Ymyv0AGYKG0Lpv
 0Gu93nFxfA38Q+gOK5TDKlxm5OrQxOfxKVm6ndbg3uH/LdYAjuoZ8Q==
X-Received: by 2002:a05:6402:5cf:b0:6a3:8652:a373 with SMTP id
 4fb4d7f45d1cf-6a38a8bbf12mr6570858a12.3.1786819530025; Sat, 15 Aug 2026
 11:45:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260728-ccaione-upstream-ebbr-v2-0-4efb529140d6@baylibre.com>
In-Reply-To: <20260728-ccaione-upstream-ebbr-v2-0-4efb529140d6@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 15 Aug 2026 12:45:18 -0600
X-Gm-Features: AcwNN1Uqu-VHDCqHPSG-xb8fSxHnAWclQAAChC3cI5JX6OnjWeM3OO8zeSrrHxY
Message-ID: <CAFLszTgX08U3GpcvwkvzBinY7X21EC_P2nEZPx3ikVH=vBt_yA@mail.gmail.com>
Subject: Re: [v2,0/5] firmware-owned devicetree for EBBR / SystemReady IR
To: ccaione@baylibre.com
Cc: u-boot@lists.u-boot-project.org
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Carlo,

On 2026-07-28T13:20:42, Carlo Caione <ccaione@baylibre.com> wrote:

> Patch 1 makes an FDT passed to efi_bootmgr_run() outrank a Boot#### FDT,
> as an independent behaviour fix. Patch 2 adds the loader, binding,
> documentation and shared EFI staging policy. Patches 3 and 4 integrate
> the EFI bootmeth and boot manager. Patch 5 adds sandbox coverage.
[..]

> - 'fw_fdt_part' can pin an A/B partition and 'fw_fdt_config' can select
>   an explicit configuration.

Just to check - is exposing these as environment variables really the
right long-term interface? U-Boot has been moving configuration into
the control devicetree, and both of these look like properties that
would sit naturally on the u-boot,firmware-fdt-block node, with the
env var overriding for A/B slot selection only. What do you think?

Regards,
Simon
