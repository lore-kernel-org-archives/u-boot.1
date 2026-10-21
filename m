Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4304606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 09:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wsYDe6jI;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DVwfkntb
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9243B80F75;
	Wed, 21 Oct 2026 09:15:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sYs5gL-g7oa5; Wed, 21 Oct 2026 09:15:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BD3A480F92
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792574140;
	b=smnxjt1893P/Stz18dfWrVNdFuCsnfyirMuZDSxkU7dtJNE7q071TjwLQxJCBDB+sjM+
	 5pK5drbUuaQXwjwulGBDfovCcOQNmggdatrTAOakjOuaA+Gept7Oz+h9R15spmTgre5SN
	 2FifSn99cYXDcVmXWeNgTpLl6kYNMhxvUpkZyKR+5Dy4zYrCzebM3XGK0BdkFgfYCl8p5
	 z4E++MtTi42DTkI/BhLkpOKMSybSMLUDZTRcg//RxWrXELRIhTW3IzEPE9f+IGCyUTGK4
	 e6e/if9EmsawDs4nbbLg4GyXnexeWwW5ExTmSIqM0nFnolhLf3/I8n+9af8BME8eIag==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792574140;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xNQFMtPm8lt9wB0FM6aBekaZRv0oSTZ/LZlQ0r/FTK0=;
	b=RTA/CXq7GbopAtUHYqi/E90R6lz2wBItDPnPSWZ9q2NbUmH7a43TMJ4v5sjG4iy3PJY2
	 2uGjtL+lB1t2ef3UFVW4qlTSEXLJEBmcKrFU3AolI3gcxc+Za7ZhJZEC4NIB25xQcYppp
	 AOToaR9xZ9FGRQVDJm9d2NVvTvEuEjzzwCY7Pw5LaKVhok9GZnTU8wTbKTSMdajfxCSAP
	 D5uPKGWKvFWh1ewPWGCb2504pKfbxOvZBhuCRh9YEIQQvOdaH2BMFY0zdYCsg2knoQErO
	 9lE7rhXvfJdqa67anL+7EEuUiSx0iJi7pWgJKyvGEjGVBir/3E8gU1CBRKWQuIBH7fQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792574140;
	bh=xNQFMtPm8lt9wB0FM6aBekaZRv0oSTZ/LZlQ0r/FTK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wsYDe6jIatgjxMCfORwHkCdAUghWi4EEaehO5X2CN2LOVV2ZuOK7yoBVF4RZnLBhG
	 knjgHt7AuJyL30zus3L5hyj7SUVxNtAswQb5mQT19U5aER/JyNw5GHM/Y+6XpWfhXb
	 IU6YXyFV+ga9kyhxfzRg7evKvswNUOTjb752q2JquNBc5lcAJVmeRXeVBHwwbCzI19
	 2eT41XxDSNpaaJSXMyrRBRHZtjgjHEvXYVcjjzKnRXPjNTOfMrut5petpSYjcd3L/I
	 16nIuSguSCjHovvzBKws60fi3vhdwS290YqAWcQLT7dHPYERGvJjwpf5xfWC7MQQTe
	 DWGe1RPzO9r0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD3A480F92;
	Wed, 21 Oct 2026 09:15:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8DD333AF
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:15:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 802FB40060
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:15:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j7io3_RVUgm4 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 09:15:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D4C6E40050
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::529"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792574138;
 b=lODtDRl+U7fNCSb1R4NWoKTwDmE7R72LVEWESImbsCQP5uZqG9f2O5Pl+eeiIy8cIoJx
 WoV7muTRuaDVlokzaDRU+F5W0RtlqOxXRV/iTR5XQKkiPjYXpbR4GkH2P5kf8QNxVLg2D
 Hd3y3JK+tEANwkqxXqErzP0Q98nudvACLP47iSzOMT96T51KRU8MvZcKqcvmlmKGIevHr
 Uj9csoy5byvN+KNl9o66Y2cIzGP90g3euMaLdeDXtfKxicEXatmVk0T+dXrSHBDbcHqd5
 g+AX+nUw9Vib7Q8wReJy1Wfp1b9k9pqLjigPBkYlqq2QY6cSebtROGZzv7l/rNny6kg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792574138;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=xNQFMtPm8lt9wB0FM6aBekaZRv0oSTZ/LZlQ0r/FTK0=;
 b=tfGBoMKX7gHCsWwvLNT9nht6RiU97i68s6QH5XVyoNlEXh03fzIKBuejEjN9kq0jbzm7
 ap4F4f8LFO0DpqWjGuuEZSXV5joEO14Ad+I1suwOs+ORGh8mjF4lwx1F9T7A9C84xe6s4
 AqOCPTh49pzkNuIKuewxJiMpMFGvgUuGNvrb2WYtwSN+FNWpVui3bOOmAD+YYM0QxT7oo
 s+TjaOS1LvKrRRo741ZJtmXfYgZTX69YzxAnCT2qc51NAA5wYsJ4MYT6BzPMk9evDU8N6
 teUA3Rv0UlztkHfjoBhjJHAjpqbkOSPjYcuEB+IeChkXakRb8sJAowgGoKEU+KUlFNg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=DVwfkntb; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=DVwfkntb
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D4C6E40050
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:15:38 +0000 (UTC)
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-cd6acc50b8dso140373a12.3
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792574137; x=1793178937;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xNQFMtPm8lt9wB0FM6aBekaZRv0oSTZ/LZlQ0r/FTK0=;
 b=DVwfkntbTs09eoVtguRvL0Q37MLQcBmZQhHDoBIcedGybG0F8IF8a0nCfoKrqoqS5A
 i2GfIbC8q4HYIOpiLU1UFbelQIsYYcjagZIF2zFI2YwPrcvViUmR5W4hmZl639rRI8CV
 5tqLOMbCXkmd3jPjeKA8NchOx/MDwBRlxY1oVqWTVEndWeI347/HIAULbDWtyPL+DDS2
 ymue3S9wE3MGXO3xV62AaUmqBXg/7gxdsNxFl91ff4tWk91hyON74NMROi3npF17dUXd
 e0bvlQItOmmWYSl5o2qNKmZuAM3HLQk6vitMLrptWJD45l3J1guAdZo8JrfY8p3gnmYF
 LDgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792574137; x=1793178937;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xNQFMtPm8lt9wB0FM6aBekaZRv0oSTZ/LZlQ0r/FTK0=;
 b=ulz61Fjuh5O1CCfQCfyN4BpbyKj8RX+HGDtWEfl460nZlIpGTwB7cCeKiLYWHvpsk7
 5jc5urRHgZ9IfSeVZF5xTvjsbsmkEGaiZoaEGVSgYQxOHpIMUtO3hhLG0ZQC1bJ6paAs
 IAWc9fY0KA18b3784D3quYXJHv9Nkb9ou2OZQfeBVupKQv3/mi4UHNVRBetwEOheDZQz
 yPqQu7bwRE0UUU2T4NDtQ+23xGzWK3Y/ZKTJKvW02fIESVSbMfArPuh+VVCGVzvisHxE
 4KeBqP0m1SWj+Ajr6XtrlMuMo9I5wqcXBQypi+URQzWIKlAmmQksCsf7khId/6b647Hq
 db4A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxsItoYS9Rann8IDiIHgleMDOxnea+1zH1WMvCowIc8rbm5yocjao+VValGSGUTw5uy6rUucf0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIn1ASLG9uZ1zDSGd6d/uDxl5K1kgNqIAV5vJy6XwNEfuqnBiWF
 oks9y3UufcOvq7b4bHYSetPh7FkNMwfmRxpe5nA1H1EMT0yeVc+xegEv
X-Gm-Gg: AYBFou0irKIFF7H6wFCkE8al85H0suXaX8t6OHvC0+Z5qZg1DiO8l8vrKnKJabzfsZv
 2b3kMDUbGL/AULmbgW+7yUJBDc9etHxyiMNWlCmm/Ratqre1oZr+H5VC9/q/tedpl8wggGPEUwv
 HhmpQr73STrbeuYkLiGB0q4kAn2tS0m9t6mwzs1aOlP0y8to89TxOuAymuckPFER15jYU52dqwz
 up4pefA8Jua0IDev6FtM0qEUnj5BvpRJXaY+gSgMQtzC3SKOzAWitL6+AdxuPWrhBTIUYAvRLKM
 l5nfOAjMUoLY2Ups0HxRQ9Zd8fM74SVRkkJQnpiZQ6w5UjhBf00DyrJvKPqBlo7CGMpC2moXrLx
 9hBxDSP2rZMOsXQrzXdNiJmRrpf3PqrA36g/961+nv2aB06jXeJHXYsTjQqiiqI856vjanbArvZ
 3TtLzfK6KzVnfPLqrHYpV0N8dtqfcs6+iq46uXG5G+qDBkyLD6ZUG7NJU9KbM/AALJd9uTD9Bdk
 gHx/zOebUIxEV8Y9eFGQ6WocJshLPOuPeDN2ZOa0Nug0ivuPLS2XruSrL6VYOwVcXpstGudQBb7
 iTs8Uz8NbYHsdRY=
X-Received: by 2002:a17:90b:4d02:b0:3a5:133:ca5f with SMTP id
 98e67ed59e1d1-3ad86d27ae5mr1275456a91.46.1792574137500; 
 Wed, 21 Oct 2026 02:15:37 -0700 (PDT)
Received: from google.com ([2a00:79e0:2039:4:4ebd:3f41:2c23:6d5a])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad8030226csm3606524a91.12.2026.10.21.02.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 02:15:36 -0700 (PDT)
Date: Wed, 21 Oct 2026 17:15:32 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, marscheng@google.com,
 eleanor15x@gmail.com, jserv@ccns.ncku.edu.tw,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 1/4] arm: Add Google Tensor SoC architecture support
Message-ID: <atiCtIU2JWtiQcwU@google.com>
References: <20261016040216.3636305-1-visitorckw@gmail.com>
 <20261016040216.3636305-2-visitorckw@gmail.com>
 <CAFLszTgxQdAq5Q0cFM4yHLt_mFnMWaUWrUgaWOv+cYTjzZUXUg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTgxQdAq5Q0cFM4yHLt_mFnMWaUWrUgaWOv+cYTjzZUXUg@mail.gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Simon,

On Mon, Oct 19, 2026 at 06:27:33AM -0700, Simon Glass wrote:
> Hi Kuan-Wei,
> 
> On 2026-10-16T04:02:12, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> > arm: Add Google Tensor SoC architecture support
> >
> > The first four Google Tensor SoCs were offshoots of Samsung Exynos
> > SoCs. Starting with the Google Tensor G5 SoC in Pixel 10 phones,
> > Google Tensor SoCs are of Google's own design. Add ARCH_GOOGLE and
> > the mach-google directory to support this SoC family.
> >
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> >
> >  MAINTAINERS                  |  6 ++++++
> >  arch/arm/Kconfig             | 21 +++++++++++++++++++++
> >  arch/arm/mach-google/Kconfig |  7 +++++++
> >  3 files changed, 34 insertions(+)
> 
> > diff --git a/arch/arm/mach-google/Kconfig b/arch/arm/mach-google/Kconfig
> > new file mode 100644
> > index 00000000000..a9e605ebb82
> > --- /dev/null
> > +++ b/arch/arm/mach-google/Kconfig
> > @@ -0,0 +1,7 @@
> > +
> > +if ARCH_GOOGLE
> 
> The SPDX header is missing, and patch 2/4 adds it to a file this patch
> created. Please can you add '# SPDX-License-Identifier:
> GPL-2.0-or-later' as the first line here, and drop the leading blank
> line, so the file is correct from the start.

Ack. Will add.

> 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > @@ -2252,6 +2252,25 @@ config ARCH_GXP
> > +config ARCH_GOOGLE
> > +	bool "Google-Designed SoC family"
> 
> "Google-designed SoC family" would be more usual. It is also worth
> considering "Google Tensor SoC family" since that is the name used
> everywhere else in the series and in the help text.

This prompt and the help text below were taken from the Kconfig in the
upstream Linux kernel to keep them consistent. It uses Google-designed
rather than Google Tensor because Tensor G1 to G4 are also branded as
Google Tensor SoCs, but they are supported under ARCH_EXYNOS.

> 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > @@ -2252,6 +2252,25 @@ config ARCH_GXP
> > +	select OF_UPSTREAM
> > +	select POSITION_INDEPENDENT
> 
> Just to check, is POSITION_INDEPENDENT actually required, or just a
> convenience given the BL33 load address ? Forcing it on means
> downstream boards cannot opt out. If it is only needed for the current
> defconfig, 'imply' would be a better fit than 'select'.
> 
I'll change it to imply in v2.

Regards,
Kuan-Wei
