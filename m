Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 152FECA5FEC
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 13:41:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B99C6414C8;
	Sat,  3 Oct 2026 13:41:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F7QUoozQgsHZ; Sat,  3 Oct 2026 13:41:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B028D414BB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791034908;
	b=PtyREBaQQn/v7gTH8jWlMRC9VpgK3l2DzHnuy/cJHlzDOB47O4lAlK+mUkzLYZalS8h5
	 PET4ypSFwe/iQPlMVdY79hbfROBVXSHCaykix5Ln1Qum3oHBMPpbvh3e/9MECaylqZIAW
	 0GIOeRoPjutyLnV/cJfBohARpWgvrsQRFV6yAZT+xaDc9Rp+1bS/O/vE5W/kUr79i03l0
	 14K5LJ1C+zCIwD9UWCCvwfoWK9Hbb35ovSAV+nfrGif2SbIG6NHgXeOBfRAnOt++zzBbW
	 56ucB/GzedmcAxvtgiHIp4YJEkgoV80RmqFfGuw3YSy91u0M1ri+JF9UGCijEHWqRbg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791034908;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=N5XOTZ/dCsCgsrcMOgf6UVNGHb9MqHtSRtGsig4O3Z4=;
	b=gk3fnJn6meysXwIOGDrcZfLhsHCAtBKZnxsTM5xw3BLmDyCAv3qhNXCFq0zzx7GjaWin
	 XpdIGbHxmworPdyWjTPaBF8JsuxjHLbWFcizZldv+ls7E8KPfby5Qr1CnMvKnWObAYe2s
	 /Hig4SuFXfaqw0loxBp3bHmDhWez0rXXTxqIizA+iwRpxHxuLD+ru7hq0qnGi617rfc+D
	 TF9PcKODs9Ei73kKSp6S9qMt18HulIYkbVumuDiYMAKPPEVoYenJAypwJLCgUM6gt/T78
	 l90Y1wHCye6HFyRQy1haOfJ9EcLWAnKXV0yeOVoXI+1QFsZQvQUnac6QHlyskDeyrlg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791034908;
	bh=N5XOTZ/dCsCgsrcMOgf6UVNGHb9MqHtSRtGsig4O3Z4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IlBI9NkpxNzjfINY57BJ1Pe4YN6K6G3FhhOy48+iPSc3hA7If1XiYG4/X0gWwhV3q
	 iaKN1d5kP663mJZefDSNq/Sw4sHtpfh/BvejAr0Odam0LIyc5H4AXmxQ6q/NWecJEB
	 sQS5Dt/Kd6/U+p/yQk2hfs82fhYS44CrBMK0VBLAl54ZEPrTW7JMzyDlo6EBjF30H0
	 jYrCHkGfjV2FfwFuQaFJDLlGnQIdb+o2Fkfbaci4eZo3v3tXFWNxKRJtdWYHh4IwYt
	 WRExHu/tvyS1QCgjqqPDYC1eqTvwmL+gV6SW0aPF/5sLSnlhiyt11QE7hdgTh3CySC
	 m4crfBa3nfLoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B028D414BB;
	Sat,  3 Oct 2026 13:41:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2C11132F
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:41:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1E16A40063
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:41:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CgKGXJqIr1_d for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 13:41:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E167540024
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:34::c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791034906;
 b=bxc34yugfmpcJez6EPF8/VfAv2HZHqp5nzzC4O7WATfIyhqk/JtVhfDfDUcQKb0JjppA
 i5to6p8U0Yl0b5+yD6JjMzwJwXZ3DiKViUxXFpnwOT1Cov/bnDsWbIY+JHIbHWDFaVOJ+
 04Eg2cUaOVtru9KRkVSr03AMAfTYXrYGRHXOybvJgoiXI5L3ziLWGmd7t3qlgGHW/+PYg
 6vBTSFrTIA/T6AhFhvsjFQGtotO+kczlBdtBB1a8rnrwN2WpUEZREcMk1AZ64Uvo5Yj2Y
 gsq10+W3ykkucZt34l5XW7UTLgjoGij542XoLT304J5X/afdsKaD0eI9/1qTEn4aF0g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791034906;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=N5XOTZ/dCsCgsrcMOgf6UVNGHb9MqHtSRtGsig4O3Z4=;
 b=YcgyrO3ENslqW5lGiFOr2sAQKCbtgnFONCNqLSuVUqft/L/3JgobHTE9h0ht4yyd0vUU
 ozxg5N2n6d5AGaDDwhEPi3vbUzdau3EEBUtEWNlZ/lAjIKjnNhKWELstIFsVkMN1gWxhf
 HxuncaicTvqrVPKRxhlgO2BGSQnEQYNrgWvZxq/l2crfDhgQp1pj+qnswsjBFBDuzTvV8
 H0zgXJicfOQpe35rxExZdvpmQhb+TdxBh91W7YElMxiKKxtBPUDHJajY1qSYiG5bp92bT
 /TXr/fD+htAZ4LXENfeCYSVGCLt30FBCreNda1gThiuCDXMtJHRaBSvHHh/KyWdKqcw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ADU01+4E; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:34::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:34::c;
 helo=mail-ej2-x0c.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ADU01+4E
Received: from mail-ej2-x0c.google.com (mail-ej2-x0c.google.com
 [IPv6:2a00:1450:4864:34::c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E167540024
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:41:45 +0000 (UTC)
Received: by mail-ej2-x0c.google.com with SMTP id
 a640c23a62f3a-c2e01f5c0aeso86453466b.1
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 06:41:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791034903; cv=none;
 d=google.com; s=arc-20260327;
 b=keg9mXZSqjKk69lNSVKlbYotbv3uQqwhGi8OiUWp26wEue6jO91kYHomoyXqqopcy4
 mVkBjVyD0Un1Mpg9ZPyiJkavIG5x15POvR9lUe3Q7BNAM9V/gWfXq0G6QC4P8PMaCEXE
 mBDli0RST/f9qmHmF/LIzcHNsjYzoPVbEIbpayhp+K7ZGxKikVBzQnmP07Kjk0SDjyI7
 jMslHKZ9k/Zi47n+Cwrsb+QPn6AIeKEDCPmaQW5I+/BHAsIlfk29g2HPmW2k5GgvFPd7
 ILaQQV8K1hLweaX3x+v9x8pmArMw8eaZkTuDDWc7NfFVYNQv/YBw7H1JWhnfmD/2m7kl
 SC9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=N5XOTZ/dCsCgsrcMOgf6UVNGHb9MqHtSRtGsig4O3Z4=;
 fh=DRMAGgHoPax3R1r6Pn28XA3dtWVqztZPwpEzfTF4Rao=;
 b=ZiL/PJMyox3XhkP4Z7yT8rbrgJwN1isEWudyIlouDv2/008DpZN0o+TO1joQUTag7i
 0kZAl8UJx3VCJC/2CrmEz7gjzsXXJ4Sqn3EJ0iUI6pBmKoh9nsjk2i21aBZ+oN70Kuib
 LDYWn4OR/H2QRPSeplqYTjaPUXZzY81+pe1Y2R0f0Hg7x8OzKwNA6MFtVNBPJBzJVNTi
 O5qBKM8yJsXVZpkQhkdyVZAZQJ8a1CKjbfapCASRCqnoBYQsHVAI51cV4EP4SB4PSCdV
 57PMflCAS+4h8iZis1lqjVGE9RuTVWAYwB65+vRMgPJQJaoLcgvMsD/QOdtzzlA9Y7qO
 8KIA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791034903; x=1791639703;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=N5XOTZ/dCsCgsrcMOgf6UVNGHb9MqHtSRtGsig4O3Z4=;
 b=ADU01+4EPnwOweC3PSSn7mEWOvMTaYog9ExLt0UI50fZWs2GsGXelFK8BNY5CseZdF
 yxqQKWoxS3nN9q8e2H1jUjHFSR3ckjP1fFhzkQD6T39N9ek2qno8ogayvu3VFWMW03LP
 qBw38Vi6mCXYHU1+Y2h0P6thb1lWHS7S57Z0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791034903; x=1791639703;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=N5XOTZ/dCsCgsrcMOgf6UVNGHb9MqHtSRtGsig4O3Z4=;
 b=RX+mNdchRf6bepHC746b9l04mPmqHuEajeLIvARgRF8sqMDPFmU0M8lzg2FLoIO2Ar
 b9akq5TCQsvedRuHy89jNhMbhdjZoQbDaoAO6fuyZwNdC6chdBoPUYCwUG4V9nHVte+d
 OYV61F1YdS9GtuWG6QQIlqTzzsrJRdTsHdccMy31yhYa+rIbibOYrdaL927UTBr72K15
 ATlRC9F6dT5vHFfd088uI79iYmnffdCNRtyzyMY/CEG728ETvZY+67Ht9KqgV0cd5iXe
 hYiTBsxaOtc9jo7z5o+fsjyLy2a+ldX7SiwHZtY1whVXo5cmQJp32D+4kQqiz1WntEwO
 +PJw==
X-Gm-Message-State: AFuF++m/dGu6xWTwA7ygXv2Q3HZijgOmTbAAbrlQImTw/HqSv8YuIyVk
 d1f+UgQOvKYeybSkTljKcMgxG3VfQJ9IMMWR60HTDQ+Gr+zBhiBHc5rrrNCbaWY/w4ZjQZZK6XF
 1mPYKpEzPp5F/O7+hf0xhl7ilIppcVty0fPxCs+GXg2m5fpZFUsMGgG4H
X-Gm-Gg: AYBFou3jYXvbBwWB2zGvbg3nd/URSVa2ZVF2Q/HpVGabCmb6m5sXii4o4PPSpZQL8oH
 zwQ4l6LcL1XImnoeh9rpNBLUN3zYUCsvQ+RwpJXD0jXpWvdnkTO9Y99uKPZ3O6+4U4ZS66ePJxm
 0caREVOij+v/EcfqumeIbU/6UHqSP/zbRJHYmyx5QvndpvZuGTz4/KWM8ELhqoHi2v/yjXn0W98
 PcXeJYQAvXuJxvziMyxJaWAPaupM3igxVq60AoobmMjlwTm69QYtx5aOn2FXk1BeZiv470aGGYN
 O/mQrL8M6u7BHRiwIq+7FxJmvgIy6w/vqN7GYPhBg33cB4mtJMjqDA0=
X-Received: by 2002:a17:907:9490:b0:c2a:fd19:8fa5 with SMTP id
 a640c23a62f3a-c2e4af31dd2mr476312366b.34.1791034903415; Sat, 03 Oct 2026
 06:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
 <20260918-spl-fit-compression-v2-10-28e946f57357@flipper.net>
In-Reply-To: <20260918-spl-fit-compression-v2-10-28e946f57357@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 Oct 2026 14:41:19 +0100
X-Gm-Features: AclHuK8IXf5oOt_Tptwn-S9F9M3msHyBgD82e18XzAk1UZas293KpWXqNL_xTtg
Message-ID: <CAFLszTjzjsft0Y-Utn+zkBwmWTUwBMrYvdqz6xf-=EtfDkJx1g@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] binman: Allow choosing the compression level
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
> binman: Allow choosing the compression level
>
> Every compression algorithm binman drives has a level, and the best one
> to use depends on what the image is for: a payload sent over USB wants
> the smallest it can get, one read from fast storage would rather not
> wait for it. Today only the tool's own default is reachable.
>
> Add a 'compress-level' property, passed through as -<level>, which is how
> all compressors want it except lzma: the LZMA SDK tool has no such option,
> and is controlled by the -lc/-lp/-pb values binman already passes.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> tools/binman/binman.rst                            | 21 +++++++++++++
>  tools/binman/bintool.py                            | 10 +++++--
>  tools/binman/btool/lz4.py                          |  6 ++--
>  tools/binman/btool/lzma_alone.py                   |  6 +++-
>  tools/binman/entry.py                              |  6 +++-
>  tools/binman/ftest.py                              | 34 ++++++++++++++++++++++
>  tools/binman/test/entry/compress_level.dts         | 12 ++++++++
>  tools/binman/test/entry/compress_level_gzip.dts    | 12 ++++++++
>  tools/binman/test/entry/compress_level_lzma.dts    | 12 ++++++++
>  .../test/entry/compress_level_no_compress.dts      | 11 +++++++
>  10 files changed, 124 insertions(+), 6 deletions(-)

> diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
> @@ -711,6 +711,11 @@ compress:
> +compress-level:
> +    Sets how hard the compression algorithm should try, as the level number
> +    the tool itself uses. Requires 'compress'. See the entry documentation
> +    for details.

The entry documentation is generated from the docstring in
etype/blob.py and that still only lists 'filename' and 'compress'.
Please can you add 'compress-level' there too?

> diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
> @@ -1182,6 +1187,22 @@ The entry will then contain the compressed data, using the 'lz4' compression
> +The number is the tool's own level, so its meaning and range follow that tool:
> +1 to 9 for gzip, bzip2, lzop and xz, 1 to 12 for lz4, 1 to 19 for zstd. Asking
> +for more than an algorithm offers usually gets a warning and its maximum
> +instead. Leaving the property out uses the tool's default, which is what binman
> +has always done. It cannot be used with 'lzma', whose LZMA SDK tool has no such
> +option.

Not quite. I tried this and only zstd warns and clamps. lz4 clamps
silently. gzip, bzip2, xz and lzop read -12 as -1 followed by -2, so
you silently get level 2, i.e. asking for more gives you much less.
See below for a suggestion.

Also, with lz4 binman passes -5, which is not the tool's default (that is -1).

> diff --git a/tools/binman/bintool.py b/tools/binman/bintool.py
> @@ -570,7 +573,10 @@ class BintoolPacker(Bintool):
> +            args = self.compress_args[:]
> +            if level is not None:
> +                args.append(f'-{level}')
> +            args += ['--stdout', tmp.name]

Given the above, I don't think binman can pass the number through
unchecked. A typo in the level, or changing 'compress' from zstd to
gzip while leaving the level at 19, produces a valid image that is
larger than the default, with nothing to say why.

How about having each compression bintool declare the range it
supports (e.g. a max_level passed to the BintoolPacker constructor,
with None meaning that levels are not supported), then have Entry
check the value against it and call self.Raise() if it is out of
range? What do you think?

> diff --git a/tools/binman/btool/lz4.py b/tools/binman/btool/lz4.py
> @@ -90,7 +92,7 @@ class Bintoollz4(bintool.Bintool):
> -            args = ['--no-frame-crc', '-B4', '-5', '-c', tmp.name]
> +            args = ['--no-frame-crc', '-B4', f'-{level or 5}', '-c', tmp.name]

This treats a level of 0 as 'not set', whereas BintoolPacker checks
for None and passes -0 to the tool. gzip, bzip2 and lzop reject that
as an invalid option, while xz and zstd accept it. Please can you make
these consistent? Rejecting 0 in the range check would be fine, I
think.

> diff --git a/tools/binman/btool/lzma_alone.py b/tools/binman/btool/lzma_alone.py
> @@ -55,15 +55,19 @@ class Bintoollzma_alone(bintool.Bintool):
> +        if level is not None:
> +            raise ValueError("lzma_alone does not support 'compress-level'")

This error does not include the node path, so with several compressed
entries it is hard to tell which one is wrong. It also only fires if
the tool is present, since otherwise CompressData() records a missing
bintool and never gets here.

If the range lives in the bintool as suggested above, Entry can check
this with self.Raise() (e.g. in AddBintools() where comp_bintool is
set up), in the same way as the 'requires compress' check, and this
special case goes away.

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> @@ -2168,6 +2168,40 @@ class TestFunctional(unittest.TestCase):
> +    def testCompressLevel(self):
> +        """Test that a compression level reaches the tool and round-trips"""
> +        self._CheckLz4()
> +        data = self._DoReadFile('entry/compress_level.dts', use_real_dtb=True)
> +        self.assertEqual(COMPRESS_DATA, self._decompress(data))
> +
> +        entry = control.images['image'].GetEntries()['blob']
> +        self.assertEqual(12, entry.compress_level)

This checks that the property is parsed and that the data round-trips,
but not that the level reaches the tool. The test would still pass if
compress() dropped the level, and the same applies to
testCompressLevelPacker().

Please can you check the arguments, e.g. by using
unittest.mock.patch.object() on bintool.Bintool.run_cmd as the cst
test does, recording the args and then calling the original?

Since you are adding range checks, you may need a test for an
out-of-range level too.

Regards,
Simon
