Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3806CA5FC1
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 04:47:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2F60940D94;
	Sat,  3 Oct 2026 04:47:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PApkTVTlOksU; Sat,  3 Oct 2026 04:47:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6947240D8D
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791002832;
	b=sxH8+agMuB0TV4QhDmW+CXKkFZF+T8ej+iGEc5/HXmhpp6jdfcOVy7HcImd866479y+7
	 SYx73/29vkxVHQ2spIOFatAbNZ0by4l3FLsa5OuBvKlpTQrrnuCEE2wlXNbXprFzYHr5a
	 kbf6LcImmwaIc7B9d0TyqWm8LzAGTyarL0OpUUMlYAwuiHz6J9stUzepnoycxGv5KSorl
	 iTXDdy8ZXtbhMQTqgs138BnOCKZtf/W7k4z34/c+rdFPrU1jJ2vfoS7ih4EjCEYngV3lG
	 8rrtdwg3iW+C+bpGvrCdUUMYxosAW5ZTMdt6q2w18kGDbBvZlT7vzSEMfGN8DO9q9eQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791002832;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HZKSGN3L6TX9qCErqkifMlufQk7E34Pj3jazMA+2DGI=;
	b=C4OlbKdIMMgNli6FlRCsqZgp4a4txhxsTwD8R/h6ngT0xOrrZ46Cw0tzJJONVIhZHOE0
	 0XVXpp2BPuLow+0qiVylq+5XuUrQVx3cwR4oufklEi9AOGEWQlMFrqsDoQWKWr15SL1vK
	 V5ICs5tWr/vhe4Kz6Ep8LBVhvd/tgEjpOusa9hArm0UiOX7pxYpA9mKfo7CmcRoyHUfNb
	 jR55VZvt5FEyNYHGYAiUaakBGBmv1iO6ByxaJTiyDxjtry8wOMSly9JoOPWObXoLxzzq6
	 aVk077sbfZddTdtFiqg+DvJoUntNP63EEOzFAiyap1A3X00+CUvXDLbsHUwvitboW4w==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791002832;
	bh=HZKSGN3L6TX9qCErqkifMlufQk7E34Pj3jazMA+2DGI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H+SF9sSOuleHfmSZWonK9deQy2lQjZdxMEvDY0UV8INihkoZwrJ3rnkvZ6Noq9q14
	 yyJAi8eczBgo5tu5YmiQji//w8BZU+CLsRqxqTedHpiX7mDAxN6BfEm1uERnYqhWuX
	 Ku2hKDYrhlAQ3yJgGOSsNGdd55nP70/SEYAC2fyinZolY9nBKczywAClChp8jouMcT
	 eQklzX0s1ubJscO9VI9Vp23fZjVUJaUQaVrxP4RObQ+pJKqGC6QZAMhYHxqeDFCh9p
	 yYidhKQH/j4SznufJv/TA+BK7FHFWH7YquYY8HNGtdA0hMUM1G856uTBPI25JHAtvx
	 Ca7BGjtkQ4ItA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6947240D8D;
	Sat,  3 Oct 2026 04:47:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B378B2E0
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 04:47:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A5634400F1
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 04:47:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4Qbn5yUX-S_k for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 04:47:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org ABD51400E6
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791002830;
 b=ALIN5JvW3yQ1tr5qgUY3OMBCDNsGIkTKo9244FQeXdhsz+fMZD6qyn5otwUBluPQR7oy
 txMO825HsiQK6RnoFU3JiXNO6frl4RjHZFhIDFFq3mYGYfhlKUKAe+cruCJmbOtZ35VMS
 puusK84pZDQ7j9R9MD5zxts3bumHGR5r9QE/lC6eoFlTfTFeFKp6dGjS6qzxmczMPcVvB
 8Z9IPEZeIqY+X5GLlnKeN2nw9WwkczhprHhl0XKJVPoDfk0zrMnUt5N+CFJbtq5czAeFO
 l/LBZZ9SO/5C7olPPWtZSizPV6KOlGepqFappfdnC929qydr0iQe9xGZheISbNeAJbw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791002830;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=HZKSGN3L6TX9qCErqkifMlufQk7E34Pj3jazMA+2DGI=;
 b=sKd7xJvVOfjAYxkxf9KLE9o1kioqdlEFpSt0DYQYckX2YfBZrSOuNU+Hcsf6Ox/AKugs
 BblMGG7FHU2a9pCAHtzCkPnmubMu0kzhvNxvxqfcC4KcqvJs1Nbrdj9n0lmwhMLy/DchG
 pHL/AQHssLaWUQ0XcT7a4hrrzwuge2znWFHpnHg73/UydwDRDmFxHi4skw5ZVyGCmC2y1
 M646oTLsyF6Jq7PxufazgKSjNkWVMQZ3rbmf3c1wdxgF5U4bkIyfyholILPLgrAh9ff0D
 RT0owLaF8EubIGGxgGsv0rC0o1jn8UvCueq2+BPoi+JmILXpaKKSZa81BGl7TosY7/A==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=oWel0iDZ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=oWel0iDZ
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ABD51400E6
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 04:47:09 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6acb0fb5945so215802a12.3
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 21:47:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791002827; cv=none;
 d=google.com; s=arc-20260327;
 b=kWZH/OBtDJ/WKK/6+Alg6fcNXcQbgSjTWH5+wAZ9lVCDNjYfB0KctyBbJVyNviljP5
 05rCjwTxJvhSsi5jeIwAxFu+pGiN5zRg5zt2/kyrbd0jiWWT6NDxQd+kRo1Cq0lCK1sT
 r48FE7qPZa2z4zfJYDccXvGE064QBVVVEGhd4dN+T7pTOS6JArHfVevWE6LRRNWMzWFK
 ovlq3L4kE6Dk/UHDDVzDSPyRYMwNFWYATukjSoLSotAwNaVuUcnXWRYry3QANlx4wBOT
 j25pSmUWxS3/pkDJ4Le0ZB+IrwzpzllU3GNsmk1crBN+t3wwyviSWYVUof6r9YNMEPnX
 rm9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HZKSGN3L6TX9qCErqkifMlufQk7E34Pj3jazMA+2DGI=;
 fh=6vrxFiHTpMVqMrB7zhgLECcF+aCWJa85hfZ0R47mqGo=;
 b=sTH+hNfrfoT0iYIJyCZH7YUxRe081nAZd/9DqNlSqtCwj219cY3/RvGuSxTcya/PeV
 +s9T2sA1eLX6l5M4L8n4AENfTAOzxAbrU6bXNe4Vr4jVdRVAWr98kMjifoDT1XNC/4Ry
 pACjuftyJzkF1r8uTYxymSTBeuLAquiWL7KAs2JBdwNOAruKGAT6tJM3Da3QXNlDN37c
 WjfPi7vFXV8lKwjoiJCxX+RKM8J8o8PlAd9H9IGX7/ujP214oeevLC7NBfWKIINS2+o9
 mdBnpQltD2ogWFHLNaEejHFcXGFBaReM/PSAbLKWp+ByX6ULOHK3PovD1wLA7PzoTyC6
 2dcA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791002827; x=1791607627;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HZKSGN3L6TX9qCErqkifMlufQk7E34Pj3jazMA+2DGI=;
 b=oWel0iDZl/egjsG3NkfbKyeBX5AgEkNbavlArTSUoAfOBhXqqXpo507E/rxM6VQN+O
 x6YQy5h5DaYE3HRpuGFhOP+I4T3367HHmMiN2UTSwIZZ6yPCUUCfWdTRuf3HV7GSvH5I
 Nd2Cd4pHb/DjeTFZB7uM4TxQ7y099BjQr8u08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791002827; x=1791607627;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HZKSGN3L6TX9qCErqkifMlufQk7E34Pj3jazMA+2DGI=;
 b=qAIyP1qfzMXYTtKEQDzGwGoQUABzzdzAWN07UE6jzI3bggevEGNyaRjk7fQ0R1l6V8
 RGFUoDcix1eny0OiTcnPxs/6KXPEl2JDA5XI6DeGANE57FQLWYWHQVhRelFJRyFtBkOt
 LPAzZgbyMEdv7sGvIKSTnfJLlK5UuahAqJaK7quF/C19WWvFP9JLXyJ4ljOIJ5hV+8mx
 V3u5s6pST0ZVbxYFXI6G5AarB6cjTp5/OpdHzyyJTLCjMA1/9xM9GZ2JUVzpcA/3ZJUL
 dnYzklSaCK0QF0/dqykiPl9VIIs9FZpfucCF54+Io5XfNxwyU9fwMuQoal593SnBkxCq
 6Hew==
X-Gm-Message-State: AFq9FYIAREKGGdD6ckXgnIp4R236UH7NMmd5wWv2lJypMAN1AHUGuSaN
 vfxz47+lsKPwV5aPOvlEoMBsGECmtnY0OLFE6r1eXFp5fo6poCFe49YLcWswci18wmw6yFzXqNt
 m0zeJ2oqgwBpKA8fPXMqwdYsQsxlwWAEH1RdEBKgOv/xLGSIysRCWng==
X-Gm-Gg: AYBFou2b+SLfFEIh4LmCDxxbqI5Wi955QJpVEDR1qf41rD3r0yD9jkQ/WW9r8u415e1
 kvTi+c3NQ0UkNnw629k109BFdWRIH7y340QMo5LvYMjcy24Othgh9nqrrgyCMG5KctmQ9QzBIWw
 GTC6IdRsqagSb4UBSw553ExqQP3DPSbGwomXlW48ccoa2OzbWcX3HNq++H0a679z/lTDPZfvlvN
 tPi+roCem+k92AcWmdLjJYvWCEk9a6twsqmyVN1uNr8UXXFI+LX4f+AW2/pfVjNN/tA9vlrtrgR
 rBSaISiqrmfjpsmXR+c69GY6eiQyjYhb7U2eET9R8DUBFLXrmSYrRqtU
X-Received: by 2002:a05:6402:849:b0:6ae:19c2:bae3 with SMTP id
 4fb4d7f45d1cf-6afad8fce26mr1153569a12.20.1791002827381; Fri, 02 Oct 2026
 21:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260918-gpt-4k-v2-0-daefa4792e9f@flipper.net>
In-Reply-To: <20260918-gpt-4k-v2-0-daefa4792e9f@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 Oct 2026 05:46:55 +0100
X-Gm-Features: AclHuK8B9BqSvGPyaGyJCc2qJlILA50Uys6nrGHon52vzHmtmp8OXc4B3MsmoAs
Message-ID: <CAFLszTjpAyratAmqYepsBDd4Y6trt3DkGJb9ZK-tBViom6JjXA@mail.gmail.com>
Subject: Re: [v2,
 0/7] disk: Fix the GPT layout on media with large logical blocks
To: alchark@flipper.net
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

Hi Alexey,

On 2026-09-18T12:13:49, Alexey Charkov <alchark@flipper.net> wrote:

> Patches 3 and 4 add the C tests, which are complementary rather than
> alternatives. Patch 3 drives gpt_fill_header()/gpt_fill_pte() with a
> synthetic descriptor, which is the only practical way to sweep block
> sizes from 512 to 32768, but it can never reach anything that touches the
> medium. Patch 5 backs a blkmap device with plain memory and does a full
> write/verify/parse round trip

The blkmap round trip is patch 4; patch 5 is the malta64 defconfig
change. In the change log, the 'unbind the 4096-byte device' item is
listed under patch 6 but is in patch 7, and there are two 'Patch 3'
entries, so it is hard to tell which numbering (v1 or v2) each line
uses. Please can you fix the numbering if there is a v3?

> Partitions given without an explicit start= will be placed
> lower, though, and on sunxi first_usable_lba lands exactly on the 8 KiB
> SPL offset, so sunxi and Rockchip folks may want to look at patch 1
> specifically (none of the devices I have override the default).

It would be worth copying those maintainers.

Just to check, has this been tried on a sunxi or Rockchip board where
the first partition has no explicit start= ? If that case can
overwrite the SPL, I wonder whether the series should deal with it,
e.g. by having those boards set CONFIG_EFI_PARTITION_ENTRIES_OFF, or
at least mention the change in the documentation, rather than leaving
it as a note in the commit message. What do you think?

> Patch 5 enables EFI_PARTITION and BLKMAP on malta64 so both tests are
> actually built and run on a big-endian target.

The blkmap can only be created with 512-byte blocks, so the round-trip
test in patch 4 has a single case and the 4096-byte write/read path is
only covered on sandbox, by the python test in patch 7. So the full
write/verify/parse path at that block size has no big-endian coverage.
That is fine for this series, but please can you list it in the 'Still
not covered' section?

BTW the discussion with Heinrich on patch 2 about converting names
with the charset functions is still open. If the outcome is to leave
the lossy conversion as is due to SPL size (I tend to agree), please
can you mention that in the cover letter as a known limitation?

Regards,
Simon
