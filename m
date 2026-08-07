Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C4ABC2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 15:12:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 14A8181335;
	Fri,  7 Aug 2026 15:12:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KMEL8WCPD0Bc; Fri,  7 Aug 2026 15:12:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 23BF78134C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786115568;
	bh=VIiaVQvINDJKTkofP+rRxBpjA0ihdHiJBUqALmqFlSw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tEKkjjWFiE7Ph/i9CAtDYCjj+xglW1MuGFdmo8x06fIF8NglHvt0+opui+TgYf2XS
	 I9g6DEsxV0FZeM/+5BqCK3CvjZIbuZIiyS0bu2VhgTJxjJvv5fJmAB7URvVN7KcQU8
	 bL2JUsQ1fUnNGn5tBZlKm15GlfOKbqKbnBj0LN3vZJgdDq2y2PkzHRZ9GT9lBaUNzB
	 L7j/6jLoGuKKViY+ieik5F/coc6rC/19x3lmMnkhI1m9OUVMy5LAZAVc5tqvpMSFOm
	 u/zcKY1/CgKt9Uhy5fQNN11hPhOF0GlmfMQLUMGWwPimlC1GPiA5Z2EyCMgQHQxlsn
	 t5lY6mLsM4YBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 23BF78134C;
	Fri,  7 Aug 2026 15:12:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E6788282
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 15:12:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CCAC240A6E
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 15:12:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hiMjg3O97Imu for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 15:12:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A804040A6C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A804040A6C
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A804040A6C
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 15:12:44 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6a173ad7cf4so4496085a12.3
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 08:12:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786115562; cv=none;
 d=google.com; s=arc-20260327;
 b=QAVNuk8y/SLpRDZFYgK+kNmGwbpN89RGBCTleW8U8bLSCduGm9bUyIM5l1VltP9MsN
 dgnZprpVEHYJf0Ojgnkuuk/Ez0fiNh+1lSxtuSfEgQ6PzdHlpy87sAbohdWTgl7KW31A
 mCL84NGxYGa9PcxIjVnBGkcDdRlqKucK2XirSFLvZ3KPm/nBgWkm4J643UmVZjuTj0r5
 hWXMO6z49LxNwIkvEAhTCitHumuwcLltpDjXEnObX3LYShemphXTylVuriLv4nancq3O
 hTKJofvNuYHfKCmPMk/7AJsW1tATu9I32xBWlvtE5/jz07pK/Cjt9z/G5tQALkEK+GMn
 JXPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VIiaVQvINDJKTkofP+rRxBpjA0ihdHiJBUqALmqFlSw=;
 fh=Ve5Rf33lTpAQZl0FmIOUMp9/uPnwy1xsgvzmn825Zcc=;
 b=MEM74zNFCFMaf0dqsVW4L98fNFdvglNO5yAbtaiShR1L2A4PGW4OovXkarpGJ3yQIE
 Pk6t8k8qzCUxkzmeTAAhU6THVEGgM81dDrPMYj/wp0uH0MnJu6hToKODvBhx+5PvASp3
 jiUjUHVYHYPWHJmMrjShEvyExEoymFNTFCKWsNY61vaVNs4SUXrQ5B938aiPIpoclbav
 xeh6z4EBocHLfGEFevAZfwRC+uEs86rbLHxT9lKukOP3fWHR/AOXNnAL9Vr6yVvYvkhZ
 rFwMIzVHXmWIpk3M0/uQpWm/EEofD3l5dYifTfZZ3Do05IUSXMBmze2OPMyDGuqVTe/k
 mI9g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786115562; x=1786720362;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VIiaVQvINDJKTkofP+rRxBpjA0ihdHiJBUqALmqFlSw=;
 b=JyOjf0q86KHvbsY391iOfQEFqkylsjoFlxPKswmMS8fGe5wRi9rfhodBgWkvRRB23m
 5SbP78Uu7ZJOHZPOcXFdYqyJTPBMy0EcRJ2Ftb+Nnto5Ei3GINpSZWTsrrEFVaFTw1nb
 zgIlDkWEveDKBJeJcsaSkiVtoBdXjK4mZUBwVWuheYep5qFFi8XB8UZf5aw6+KaZh0FZ
 WjQe96RXCkKOtiFxuFmrxy3ACgQ9j9cVhrNNbBp+ZdoHHOZQhgvirXcTfwanTAfaIEju
 JWg9DFO/HlTkW+Agd51Bxh0JzRk5uL6s6RDjEl56mugJGI1OZmpGTkrKcJrPyj+douvt
 7DTQ==
X-Gm-Message-State: AOJu0Ywpn6v8JuXpArSCjM4bJyeD0Ix6ZN5nMt0TPzo7NaCjriiDSRZ8
 SMa+WFklQdDm/XsMVCwlfwllmSFuE2EYM8axvdzQWeQGwlwTR+GxuVeINrumOfyxjOr43q5cmTW
 8HRhKmCn55UDUHGHL8sFt3vc56xJ3GZZUGEoF7e7qeZegTWShHxQ=
X-Gm-Gg: AR+sD10ol5+PugEXOS3DR9G00Sk1PPxR1bak+Wlp4Li7V9zDjOM3tWw3WkEGcgQhA1H
 QGwClbVlzk/94Ie2jeWIpXnWIuNhGnLK86Ta5zmf+rRWt8LBB+BdIW0lTthynV0X/orwcQN5E6c
 BX8hMooffd7PE4nAFAViic769OVL9FAwZEPQYLWYeRUHph61Ap3y44XnTd+f8w2cwOEvWmqVOkG
 SrzbwhhnShULLgxM6iWqHVGTciumSh08jfBrndVJbEtV/QAxHCWlZ2EuUVpbNj75lulwUl5OA3F
 tddMfdkZEIfzQhZKksWm7/oxTtgDpFM0NWOLTLXfClk=
X-Received: by 2002:a05:6402:2353:b0:6a0:fa22:c1b1 with SMTP id
 4fb4d7f45d1cf-6a14f14def6mr12445299a12.19.1786115562542; Fri, 07 Aug 2026
 08:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260804-am62lx-v4-0-01746157643d@ti.com>
 <20260804-am62lx-v4-8-01746157643d@ti.com>
 <CAFLszTj2jqcQG9P4nWWiXjJ-7cHko8WghVqCbBb-FExnH+gUFw@mail.gmail.com>
 <20260807134512.ri7cmbidhvjcytej@bryanbrattlof.com>
In-Reply-To: <20260807134512.ri7cmbidhvjcytej@bryanbrattlof.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 7 Aug 2026 09:12:21 -0600
X-Gm-Features: AUfX_my7EgMFPR9DPJ8TKyeZqZwplfPGewXGdZIrTeZbwJF1PHx7yIHCRC6JWMY
Message-ID: <CAFLszThaqsGCD_scGi7L=0FOAL=hPnA6QQ_SDXSm5R-rBh1cew@mail.gmail.com>
Subject: Re: [PATCH v4 08/11] configs: am62lx_evm: add initial defconfig
To: Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786115562; x=1786720362;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VIiaVQvINDJKTkofP+rRxBpjA0ihdHiJBUqALmqFlSw=;
 b=KhB7iBqFC3Ld3Lxfm79rRPl+ii1XASzWPbDoEzYByUfUTfbjeswTYh0HW+lZLYryeE
 UYmlWo1JJJcon5u2Bxj+PrMlGR0MWx7pm0T7hVLuV8sdn3ccwGDtmIcq+4xcBT7rB2Dd
 R+FoSXH3GWOUm5P2YYkvoqWJXz9YpFEZv5iYg=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=KhB7iBqF
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

Hi Bryan,

On Fri, 7 Aug 2026 at 07:45, Bryan Brattlof <bb@ti.com> wrote:
>
> On August  6, 2026 thus sayeth Simon Glass:
> > Hi Bryan,
> >
> > On 2026-08-04T21:55:02, Bryan Brattlof <bb@ti.com> wrote:
> > > configs: am62lx_evm: add initial defconfig
> > >
> > > Add the initial minimum configuration needed to boot the AM62L3-SK
> > > reference boards.
> >
> > The commit message refers to AM62L3-SK but the defconfig is named
> > am62lx_evm_defconfig and selects CONFIG_TARGET_AM62L3_EVM. Please make
> > the naming consistent - either the board is an SK or an EVM, not both.
>
> I'll fix the commit message.
>
> >
> > >
> > > Tested-by: Anshul Dalal <anshuld@ti.com>
> > > Signed-off-by: Bryan Brattlof <bb@ti.com>
> > >
> > > configs/am62lx_evm_defconfig | 138 +++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 138 insertions(+)
> >
> > > diff --git a/configs/am62lx_evm_defconfig b/configs/am62lx_evm_defconfig
> > > @@ -0,0 +1,138 @@
> > > +CONFIG_SPL_LOAD_FIT_ADDRESS=0x83000000
> > > +CONFIG_BOOTSTD_FULL=y
> > > +# CONFIG_BOARD_INIT is not set
> >
> > Unlike the other AM62x A53 defconfigs there is no CONFIG_BOOTCOMMAND
> > and no CONFIG_BOARD_LATE_INIT here, and the .env file added in patch 6
> > also has no bootcmd. Just to check - is this intentional (relying
> > entirely on the default bootstd behaviour), or an omission?
>
> The downstream teams modify this for their needs[0]. The goal here is to
> support as many boot methods as possible and let meta-ti do whatever
> they want for the downstream fork.
>
> [0] https://git.ti.com/cgit/ti-u-boot/ti-u-boot/commit/?h=ti-u-boot-2026.01&id=c754b0419ef89c20e0ffb5e1beb82b4606953b13
>

OK sounds good.

Regards,
SImon

> ~Bryan
