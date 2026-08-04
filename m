Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8D7C55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 13:06:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D447580C81;
	Tue,  4 Aug 2026 13:06:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GyK-ylEmGTYq; Tue,  4 Aug 2026 13:06:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 47B4880BB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785848770;
	bh=c744W4y+hcfLyvWhXGYNhIIK5gmkvX1L/wMrNvW2x5Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oM9Jh94Cdn6D4Sc6B3TRO5JstryG8owU0qUtq0ImZ9OjTUmKUud37HjLK8rAcY6dy
	 /XeImDQOznzzUD1HIV9BtkXgXIm0kDPybJU3SGaDfLq0gGlmyKvEGy/GjDxy9HcKwL
	 Zp95/nrHIj+pu9np1sCp92qQ4V522AUmA58q3gI8IhWTPvOmqvLu/kb+914JLgMSIg
	 TGod3rGdMEczH9Tu+cXtGi33zxJKueXnjbzUwZN9CbZG93f+ga/jg0lASR/XvnE8F/
	 ykq958+IVu581Hlto/SY/FTyl3Bjnv89Kk98YbRZ0icuX97LGzIMOU6ZXY9Xw4aRtI
	 2HVBfa7TJZD0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 47B4880BB5;
	Tue,  4 Aug 2026 13:06:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E504E350
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:06:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CB7C140189
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:06:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XQr69Im96fA1 for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 13:06:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3300E4053E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3300E4053E
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3300E4053E
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:06:08 +0000 (UTC)
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-ca957432c7fso3219301a12.1
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 06:06:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785848767; cv=none;
 d=google.com; s=arc-20260327;
 b=VPwU0J+Omh4jD+5ETgcs9ZENH9eQ+PAvR+CpDavN/6MZ69ugHCfAuTuDH1UBqVQDYg
 FpYgJneOLDhA3fynwkjHBRU79cBTyZbMoAHhOo3EBOdD425AoUr65drPzfg3UkFS2AQV
 /Bb7LzzRtZbn7LfJhLtPFV1Uo7WtUzoUPXABS9o1OMwvS+gaG+YnYAELSAw4rR9JRKkN
 nK+iUPOSWwfHmQQAr+1pv8M6RteGjMV3G9Y22jW1WKsf6I4SR5TZg1Yn0ADTuNkQzQVF
 b0kq/Mlgem9Z4sugtpleKdbAFAag3RWPp8/RSJNzKXl+6JjDhlZZhxz6gr+a7RDSgSoe
 o2Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=c744W4y+hcfLyvWhXGYNhIIK5gmkvX1L/wMrNvW2x5Y=;
 fh=Kycz0RmuF12z7/MfMEx/C/XJlPwcni/aTJr26m8kUJU=;
 b=Q43Njw7H2OBDTi2j06X2U1Y+hA1dZrPpQtkdecW4rzfYPM97URxolCI4jxBRQmWpa8
 a0dSQrXxwEuVfWT7BFK6EogGvnwNwnvyq9de+3OUoj9fX2Df3blRQ6W9/pUPhnAEymrx
 r3I6i7RFjMXtlOpOndjHDyQU5JsVfddVpsX1AHQSVo6k1SI+K/lXVtLRdiBj/RF4eBl/
 LxlZGM6YIBPT/PpkAEjLQ3DJLldKO2K11mwxA/0GGoaIaUepQePTfQcFV7QTvzo3DnRL
 fnriyGuCIxbcCk52y/xzCHAp2i/JatsCfTg+2ptrSXsy1lUhh22Cqd3pDjak+icosmM3
 cJ6Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785848767; x=1786453567;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=c744W4y+hcfLyvWhXGYNhIIK5gmkvX1L/wMrNvW2x5Y=;
 b=nCk1yS0Kk/8ljPMwSqLXUGYGWhOge4WUvYfczJCeRYSQfKy+H18udUhYAltaN2Fu89
 debhp6ZyIP9JWGCV5QiFcH9h1vAYXiyVhojKay7MxE8J4SDMZO6IFFN8ALKgO9Jb2zMX
 LECa10wGj906WYlwEdLZN1Ud5HgJkEMLLjnGtjvkjRYXWvdWcRWhXsaR9vkMgVEboJbd
 tZjOP63muNwT2oVO06eZHKYyMytx74iWQCVuWxTnKm4YKNahQgz0R2KWIIeutQKyZgvc
 PxeatS3D61mp3nhr+Wt84qj3IO+bcIfHaJeag558j0hTFAPs3vpmarzLO7Kz7oNjH2zZ
 JBmQ==
X-Gm-Message-State: AOJu0Yznsauo6YDrm+f07VzUYjvQr1bIRoa6cEUDu1qlaHYa+TAt55gZ
 DlMeeNr3yQPlpLBkfeCJ7okZ0jlbKu08+qDam70cBPrlPE9U4WxiIfhew2okS5Hadf87CCU9DgW
 FWwrJDHTULAqP2CJuC8z/RyxBDTevCDGjy8rtTl+u
X-Gm-Gg: AR+sD10nDcDF5nkOwjCuF8pizzO5yoewYMwTmiFRwG7y+cbXi0wDGjtAwgOH0CFULr0
 Boanv6FQQA/bLPqtRGUxXD9iPd5Abt9w3OlMjIhD7IaDPZcEGgd4YRpTKIL3Oc3STbJshGBUrOT
 WsmtMH4Tlkl9Ev592+4GQvNaTa93z5VQBN07BzoDQ2z5ZtA+Ongo95/wF0ITiGQYY8F4mxUpEsC
 0RO24GF7zKS3fiXrNW+pDhOG8Cq/kc/NtIB0G9hg3872875FgDGeXHHRn21ql9Yfv60ENs9sDBj
 ogmqIXlD9TcXAW0pv8b+edBs36TYx++ti3YPGwu9Z9S1
X-Received: by 2002:a05:6a20:6f02:b0:3b4:b216:2b26 with SMTP id
 adf61e73a8af0-3c92a4c975emr14565668637.5.1785848767304; Tue, 04 Aug 2026
 06:06:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
 <20260731-gpt-4k-v1-4-a3f1f16b53ae@flipper.net>
In-Reply-To: <20260731-gpt-4k-v1-4-a3f1f16b53ae@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Aug 2026 07:05:43 -0600
X-Gm-Features: AUfX_mzo83Xpky7mj46DK1BAKY1VN1S7k4cOp1UqMpPZQbYuk5OlVrf3OmJPStg
Message-ID: <CAFLszTji3OE8Vdepq8vyLnDWKaj5z6r7RQn_1=WK=P8xUB755g@mail.gmail.com>
Subject: Re: [PATCH 4/6] test: dm: part: Check the GPT layout for large sector
 sizes
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Tom Rini <trini@konsulko.com>, 
 Anton Burticica <mouse@ya.ru>, Javier Martinez Canillas <javierm@redhat.com>,
 Simon Glass <sjg@chromium.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Jacobe Zang <jacobe.zang@wesion.com>, Jagan Teki <jagan@edgeble.ai>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Suniel Mahesh <sunil@amarulasolutions.com>, Klaus Goger <klaus.goger@cherry.de>,
 Tim Lunn <tim@feathertop.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785848767; x=1786453567;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c744W4y+hcfLyvWhXGYNhIIK5gmkvX1L/wMrNvW2x5Y=;
 b=a2eFmUtro0xLFYAvAJdKJuJbucPu/BHIpfb0UNYFt0iQvuMSv+EAGqDV048uE/Isqt
 UHH1Gw5zR59QjGkaWtTnci6g5s/8YLmnqqsct+ZUeXa1AHDVOa1ZsLdsshj2ga1SVQmQ
 RnrqMZzJxe7GLmWBKploXZtlxGhpLalC15QpY=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=a2eFmUtr
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

On 2026-07-31T12:39:59, Alexey Charkov <alchark@flipper.net> wrote:
> test: dm: part: Check the GPT layout for large sector sizes
>
> Add a test that runs gpt_fill_header() and gpt_fill_pte() over a range of
> block sizes and checks that the partition entry array is sized and placed
> consistently, in particular that the backup array ends exactly where the
> backup GPT header begins.
>
> Neither function performs any block I/O, so the test builds a synthetic
> struct blk_desc rather than needing a block device with a configurable
> block size. The expected array size is taken from the GPT header fields
> rather than from GPT_ENTRY_NUMBERS, so the test still holds for builds
> with a non-default CONFIG_EFI_PARTITION_ENTRIES_NUMBERS, such as
> ARCH_SUNXI with 56 entries.
>
> Without the preceding fixes this fails on the first block size other than
> 512:
>
>   test/dm/part.c:313, dm_test_part_gpt_blksz():
>       entry_lba + pte_blks == first_lba: Expected 0x12 (18), got 0x22 (34)
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> test/dm/part.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 100 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
