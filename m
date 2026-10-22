Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B12606A329
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 17:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XXqKM9mp;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mFZu+dcD
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9058881182;
	Thu, 22 Oct 2026 17:57:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zX1hKa7pnBUo; Thu, 22 Oct 2026 17:57:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 97BDD8118D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792691842;
	b=AGAu+tkEQZClDIAW232eoxQBMDQSWbnuJiQzChP46mdsZqTzRrK2UdFjC8iG/G5715W2
	 Nt2Y5NtE+vWv9rfmvwawyVm1kPgnRmqwgtwMP0INPWIW44x/pyEBQpwTeN7gq0XdlOehj
	 I8AvNBdVkivwe/qoyG+0DXl+av4991zlgOkBZfiokDynsQpeQuasvmfcSQsIFolQ21pDe
	 WgvySXlsXuDXfXvjaEM5OwQDb7J2Hw+XIzCPki356KCQjEDV+a48UJRU3HcjMacLUerj+
	 Xo8iSpZZ63Qd47o8XCH7H25FLwUyaZgfWYjntjiYMS28ra7+VA28qqks1aG45jdY3oQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792691842;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=3tO1MXl0ydx+9qYqkoYWaJ/20HuD4MDupI4ozCIACIQ=;
	b=Ef8J3BJauQ1Gdeo58GmVhfU3gZ+JvPNA0W6v2+G5qNBVXCP0Gr2JBpRA/HXS8U38nUtY
	 ur8T0Bq5qy3i11iXMOAmo9FD9ciqatd7BPXofCPBCJ6WPRZZkkJm1nYfADkBU5d73fu/3
	 Hu28wZ7iJiDVlB3fEf3vDozI75dm9sN4Y1wgPP5E6hN1GKmotHsOKNa/HxeX+L1fDJEyB
	 hUvLvD1DwuXc1vowoDFyvHoOJkfJTWPcyWZIdsawVjrHCUMkFmn6HTcFUJKKV1oHivoU+
	 cEnSWwW0knY0XOIUce4CA4a5tse5IRiUWpbs1USiMnC6EWSouKsOCQTzYjiium9k91g==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792691842;
	bh=3tO1MXl0ydx+9qYqkoYWaJ/20HuD4MDupI4ozCIACIQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XXqKM9mpX9syB+vFTwoUE9f1ga5BnXpl9P5R6HbAW8uPNAi/8CJiqtWHTDEGr/XMe
	 EsdUgH4pFOyoEnP4JaN0CxcwnibKgwtrkJVAWiJRsjaza4EEGOEz9wCEIqz0Hgr3+3
	 GTD10Z/eNpq3XbZN9LAuvKLjreXQz+RZvhtQS6yD5ub3f88thwjCRB8MWE5gkA6pbM
	 G2WsDWOaiTaLNqFIDAyjArmJDhbFgdDgVUIAjMoxQwWTKDqUzgjy+hvTsuhnTt3jpm
	 FvHFzzVtNi9vuQHVu8AVf7ht5U4ADmo6LeU7Oz8hiVstwTiPDtI8PIz6Cbyi/56Uvv
	 UMA8SXIo9RQmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 97BDD8118D;
	Thu, 22 Oct 2026 17:57:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 31FC93A4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 17:57:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 239D740176
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 17:57:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xVMX-wFsWsDA for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 17:57:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D9CDB400B1
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::634"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792691840;
 b=gu8/brZ280brHFJhAPpIa9NjlCF8FsipU2FfQyOjIlOoZBli7KdO/CFsF4VEeCjcTXf7
 xVYLdDZLx9a/USYg8kc8XK7XMUqhHEcPHf3SUNbW7qLfl6i3f17sZFmuA3etm7iVQq2ez
 pXESId3ygucJE5cqe+yhbVyBpKffWm0MY2XLWzxV4G7nHx7KTzDLqcZTG1l68QBJpgYYU
 Ho/xtS5KgKPhis2Ntxng9Y0PwOg/2AvFyR+Gaq5yEsiZ0bWnC64c+8859A0iNtB8FUJYp
 vt8/h1YqPiKQ9rp1r5KX4cV9IYq6HssnREdnmMm2SMTJ8sd92rcvOeCCx0TUBE1pl6A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792691840;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=3tO1MXl0ydx+9qYqkoYWaJ/20HuD4MDupI4ozCIACIQ=;
 b=IrT7J2lPheMgfGCvKllFiWrl7W5RGht30VMPOtPt9MkvNq+R8HU3sfMdZzbbQ19hQTPz
 TS4haDVLs6/Do1SXLf7wCcQxGzdejCmOZdm8mYt+oRJ56dwsjHqpbYTFsf6kxrU1KBu11
 AaAGhO1/JlT/N/1vgdwXGJVCxT4MjsnOGvIU45ngk8Y8RdboCZbjaBxQWQTK68khEFQIL
 pqkX2E1zxnBn0YtTzF/IWsLSJe3RvbhSthCtpZh1rvP66N8VbsRGKnSsKM+e7DMS4uG4L
 /roO+9bjHYQJmJg73g8LZhjRXJAqrrp6XzPDbk5zrGKRinzUO0k0EV8O7OELj751/Kw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=mFZu+dcD; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::634"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com;
 envelope-from=massimo.pegorer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=mFZu+dcD
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D9CDB400B1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 17:57:19 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c413dea9ca6so11842766b.2
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 10:57:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792691837; cv=none;
 d=google.com; s=arc-20260327;
 b=RpepVTfAn+M17rpCYNT9djt7fYuRIlZshgJolRSX75U9dUQu6yOqWA4PcpVHu+AmEB
 cZtYQdy5zk6dAU0nDFmGUa5NHr/oQcULJehJtL1NmqcZg/yCuhxOg7dq7V9C9+I83CT3
 cKfWZNBmovWf83sGxyAhhij8X/vJUZN7Z3KOgSNdeRnnTBHViRMpdpkVfQVv3i6Rbrei
 kdlHOztET1A0FqByRttaBEU6wtu+FJWkt51+GzF+YjzOOxdsYQ2HLvFD3oRS4/XYGup0
 8xNK9InKfiqpzxac1NfgA4AjSdnIbnak0RWg8ejaM0J4dZMH0OGj4SkgA1vlk1mKGWXS
 1Mmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3tO1MXl0ydx+9qYqkoYWaJ/20HuD4MDupI4ozCIACIQ=;
 fh=br6zbsTm76X5RX8uBk1il/nHUjxRADK7WlLNrJbl1H0=;
 b=NIEAGMkkB+EqKdyQDge6sLxXZIw83d3uqcCsy/DB79TcA4Xb6/OUQxAWxxwIEnDmKP
 ic5qYu4OK1ErirWirEfTJqmX4BhyssJ7tcNz7OaDEnDZdrFF3Rmh8wLYVW2UBN42pcyJ
 b+yzZeMhBqtSvQK1rlmWo8YVBhTHL+JAbjgPyvqj18IuUI6Jn6Q1LueOh0esXQQmN03A
 I+TMNyxMH1aHVcXRpxQTRz0kgvoiITmIv/6jdJmja7J7YRS57Z3/ubauI4j7tOtmvhjt
 hQ5Uz1qrtFsW/+iQxE0pU5cVLKvzlntutzBBJni6ljQ1va3o39tt10cAQwubjtfyWmbX
 BoDg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792691837; x=1793296637;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3tO1MXl0ydx+9qYqkoYWaJ/20HuD4MDupI4ozCIACIQ=;
 b=mFZu+dcDIx6yU01aJBWn+QS+BZP7Y+U4gwAG7yEpByyiV7pvQHLNEi17y4AQFvy4iz
 rrAr+boZ3CEy1KFfFxbmlFY3um/S7i0722at7T3A8kURDPwpAkweXhLWfDUfh5kR42I/
 09mgmSaug4qvgNDf9YNJgH6FbltTxpL3YkzP359SCGBPpG+VcE4R3dmPln4pY216hNVG
 TLe8c8X9diY+my8WZR/LvDaVj1aU5S65LjydYt1/fO0gPFHEiIURkIaWAma2e2s33g1i
 EXr27vn/9ZF0zz33NTiztqqPQAj8EhnI/xoY7coiO4xbzFTlBUSqzeA49E/OFd/cQl3e
 s1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792691837; x=1793296637;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3tO1MXl0ydx+9qYqkoYWaJ/20HuD4MDupI4ozCIACIQ=;
 b=1uBGqE/EQsfyo009v5eHBCz/ldCJ+wknQzE0t+TMBtwcDc4QhD2ESvXYHsp3b7cb51
 WSz2zpE+hme2/YqjTGQAX+WNltSOy8x3B8/ciugWA9/A0SRY1WNAbIzZbTAHbvnrAMkD
 8exQCTnKh80moxGkYBWrg94lZiraKRDStsN6+fewM0kbBV0dQF/8UT0/eu+yvQSR0Fap
 2ouNxcDatYTW87WHTpwMNZypwz133tfPjCarGwqfSw0gbVKfBVfee9tuBcRDx9yBmLyx
 1epMOP2Z6P84890Wmc5V3hHipVm1FbXpSvBkqAxFuEKIvPWEpQ3Z7vH22y8SbVqL9qNz
 +Pyg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxmqR44XKqwHLQAbvQY9Lp/uwJGTHAPVUGUFD+ubHrXucjVzOqahYJZXwGpMbok9Dtnb7IRfkA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJNVDE9BygQm6azIicMslvMIR8CBQIcX9h7tvMhxWudiEcuk4gX
 xziJkbm4mYbXrn8b808Jbk2iyyhOVHLzqFI9CIm5iKOUk07OdVXFJBgAodJMiHv/5qaDki1nny6
 6SycMwKOQ9ec+t/lQscMjld7m+ieYJRc=
X-Gm-Gg: AYBFou3SIr/7UcSG/0fGR05/Z1IrQZiPaTEUocFZcgnVbktgnVzut4/B6QFoJmMH/wL
 0efPdV7T7LPrMo6JaLLw5ZSadSkLh0L6cmOuifPDycv/3w84Yb+4J8S+Kd8JLEWyVeytuMyi4Lw
 ZqDlbHJ5bPXQ+Q1e6ha0l9Bize7/UjuIkmxKfehQzn+VO/bykneL3o8YM+b75ufB5dthgD7sEFk
 DSTsnj92eL+is/Otlsx2oWRZM5gj7e/j57nOJz3VKXe4z6UnIvnoU6hDC5Ablz46zXWoGOaxg5f
 kTlXqL1R8ayg4nYN4AyfA6GBx2t0eLP9SbJ50hucDsPqlQHOlpAW4Ezxve5X55Ojytxm2bmy6Y5
 D3TkxSMrvCwuMpV5WdmOKyXz1VPdN+9+kRE3A6w==
X-Received: by 2002:a17:907:c011:b0:c41:b4e4:7958 with SMTP id
 a640c23a62f3a-c4678ff6fe8mr638657766b.0.1792691837349; Thu, 22 Oct 2026
 10:57:17 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260829-ddr-multi-v1-0-c0c7837aed20@gmail.com>
 <20260829-ddr-multi-v1-1-c0c7837aed20@gmail.com>
 <8a92f1ee-08c4-4f55-b0df-8098c4da7c1f@0leil.net>
In-Reply-To: <8a92f1ee-08c4-4f55-b0df-8098c4da7c1f@0leil.net>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Thu, 22 Oct 2026 19:57:05 +0200
X-Gm-Features: AclHuK91Gjs0hhdLesPKIdMHMqRbJG4Nsjt3ryGckFPyTugwP32YonQr_7C1TlM
Message-ID: <CAC928HZy+Gf+bTk3OHGD=zsUT0D_OzEU2MZ9_Tuf0VdBOnM6rQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ram: rockchip: improve ddr type configs selection
To: Quentin Schulz <u-boot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Quentin,

Il giorno gio 8 ott 2026 alle ore 22:49 Quentin Schulz ha scritto:
>
> Hi Massimo,
>
> Thanks for the patches. Note that the timing is interesting as we were
> considering having two variants of the same product, one with DDR3 and
> one with DDR4 and we don't want to have with deal with multiple binaries
> just for that.

Good to know!

>
> On 8/29/26 7:03 PM, Massimo Pegorer wrote:
> > Not all the DDR type config options named in the Kconfig are supported
> > by each one of the Rockchip SoCs. Moreover, the LPDDR4 option has a
> > different meaning in the context of the RK3399 SoC than in the RV1126
> > one. Improve clarity splitting config options, using SoC specific help
> > sections and adding depends on conditionals.
>
> Yeah, we shouldn't do that.
>
> >
> > Involved Rockchip SoCs are: RK3399, PX30, RV1126.
> >
> > Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> > ---
> >   drivers/ram/rockchip/Kconfig | 29 ++++++++++++++++++++++++++++-
> >   1 file changed, 28 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/ram/rockchip/Kconfig b/drivers/ram/rockchip/Kconfig
> > index d707d09c1c8..61a3193b3f5 100644
> > --- a/drivers/ram/rockchip/Kconfig
> > +++ b/drivers/ram/rockchip/Kconfig
> > @@ -26,26 +26,53 @@ config RAM_ROCKCHIP_DEBUG
> >
> >   config RAM_ROCKCHIP_DDR4
> >       bool "DDR4 support for Rockchip SoCs"
> > +     depends on ROCKCHIP_PX30 || ROCKCHIP_RV1126
>
> This kind of change is very welcome.
>
> >       help
> >         This enables DDR4 sdram support instead of the default DDR3 support
> >         on Rockchip SoCs.
> >
>
> We should get rid of the part that says "instead of the default DDR3
> support". We should have instead an option for DDR3 which is enabled by
> default and then we don't have to care about that part.

OK, I can add a new config option for DDR3. But in this case, we will also need
to check at build time that at least one config option has been selected.

>
> > +       Note that even if multiple DDR/LPDDR types are selected, support is
> > +       enabled only for the selected one that comes first in the following
> > +       list: LPDDR4, DDR4, LPDDR2, LPDDR3, DDR3.
>
> This one change though is less welcome. I don't want to have this in the
> Kconfig help text. I suspect nobody will maintain this in the long term.

I'm just describing the status quo. I agree there is a risk, but what do we
prefer? The risk that nobody will maintain this in the long term, or the
certainty the config options help is providing wrong information?

A trivial Kconfig choice would solve the issue, of course, but as I would like
to support multiple DDR configurations with the next patch, it is not the way.

>
> > +
> >   config RAM_ROCKCHIP_LPDDR2
> >       bool "LPDDR2 support for Rockchip SoCs"
> > +     depends on ROCKCHIP_PX30
> >       help
> >         This enables LPDDR2 sdram support instead of the default DDR3 support
> >         on Rockchip SoCs.
> >
> > +       Note that even if multiple DDR/LPDDR types are selected, support is
> > +       enabled only for the selected one that comes first in the following
> > +       list: LPDDR4, DDR4, LPDDR2, LPDDR3, DDR3.
> > +
> >   config RAM_ROCKCHIP_LPDDR3
> >       bool "LPDDR3 support for Rockchip SoCs"
> > +     depends on ROCKCHIP_PX30
> >       help
> >         This enables LPDDR3 sdram support instead of the default DDR3 support
> >         on Rockchip SoCs.
> >
> > +       Note that even if multiple DDR/LPDDR types are selected, support is
> > +       enabled only for the selected one that comes first in the following
> > +       list: LPDDR4, DDR4, LPDDR2, LPDDR3, DDR3.
> > +
> >   config RAM_ROCKCHIP_LPDDR4
> > +     depends on ROCKCHIP_RV1126
> >       bool "LPDDR4 support for Rockchip SoCs"
> >       help
> > -       This enables LPDDR4 sdram code support for the platforms based
> > +       This enables LPDDR4 sdram support instead of the default DDR3 support
> >         on Rockchip SoCs.
> >
> > +       Note that even if multiple DDR/LPDDR types are selected, support is
> > +       enabled only for the selected one that comes first in the following
> > +       list: LPDDR4, DDR4, LPDDR2, LPDDR3, DDR3.
> > +
> > +config RAM_ROCKCHIP_LPDDR4
> > +     bool "LPDDR4 support for Rockchip SoCs"
> > +     depends on ROCKCHIP_RK3399
> > +     help
> > +       This enables LPDDR4 sdram code support for the platforms based
> > +       on Rockchip RK3399 SoC.
> > +
>
> Please do not duplicate the same symbol twice just to change its helptext.

Ok, but please consider that RAM_ROCKCHIP_LPDDR4 has two different meanings,
one in the context of RK339 and another in the context of RV1126.

Within RV1126, it means including LPDDR4 support and not including neither the
support for DDR4 nor the one for DDR3 (RV1126 can support: LPDDR4, DDR4, DDR3).
This is like all other DDR config options that apply to PX30 and/or RV1126.

Within RK3399, it means including LPDDR4 support and... ...not clear to me
(indeed I left its help text unchanged): the RK3399 SDRAM driver seems able to
support multiple DDR types by default (which ones I do not know, DDR3 and LPDDR3
at least), and LPDDR4 support seems to have been added on top. I would say that
with this config option selected DDR types other than LPDDR4 will not work, but
I am not sure.

Therefore, would you prefer a single help text with two paragraphs, one
describing the RV1126 scenario and another for the RK3399 one? But for the
RK3399 default case, what config option should be used? The suggested new DDR3
one would not fit. For all these reasons, I would suggest having an RK3399
specific LPDDR4 config option, something like RAM_ROCKCHIP_LPDDR4_RK3399,
because it is a really different scenario.

>
> For drivers that support multiple DRAM types but not at the same time,
> the easiest answer would be to enforce that outside of Kconfig with
> something like:
>
> #if defined(CONFIG_RAM_ROCKCHIP_LPDDR4) +
> defined(CONFIG_RAM_ROCKCHIP_DDR4) + defined(CONFIG_RAM_ROCKCHIP_LPDDR2) > 1
> #error "This driver only supports one DRAM configuration at a time"
> #endif
>
> in the driver. I don't like it too much as this should really be in the
> Kconfig symbol but I couldn't think of a way to easily have only one
> symbol among a list to be allowed to be selected (that's typically a
> choice Kconfig) and also have the same symbols allowed to be selected as
> many as possible, depending on the SoC. I think it's a good compromise
> for now to fail the build by having this kind of check in the driver.

I agree with you, both on what you do not like and on what should really be,
too. I will follow the suggested approach in v2.

> However, this won't play nice with COMPILE_TEST so not sure if it's
> acceptable to Tom.

I know nothing about COMPILE_TEST, but I see xPL builds depends on
!COMPILE_TEST. And PX30 and RV1126 SDRAM support code is part of xPL,
therefore could not be a problem, maybe.

>
> Ideally, we should also figure out which DRAM type(s) are supported by
> DRAM drivers that do not make use of the Kconfig symbols. e.g. RK3066
> for example, and have them explicitly enabled in Kconfig for
> completeness. That isn't required for this series.

With which purpose? If there is nothing to select/deselect at configuration
level, I would avoid this. Instead, I would add the information in the
documentation.

Thanks. Regards,
Massimo

>
> Cheers,
> Quentin
