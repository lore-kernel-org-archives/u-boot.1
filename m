Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96A1C98304
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 01:09:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6010A606A2;
	Wed, 23 Sep 2026 01:09:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jGwicKN9-KGD; Wed, 23 Sep 2026 01:09:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A13286064E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790125763;
	b=JeyH7haNAZ5GMmRH6XVYw5T4Z6+bYIUboLmrpBZ9qoLQKspes/2XHq0Xd4/sOrGXN6OT
	 c0OzhTwNOvtO4ER13MiIQvSaQRaWt4vZKoK41tEcm18f9SUSrvdBIMNe6jytLLpCJbKmg
	 y1p4bCLatuWd06CB/QXVkKqe9B2mnccCbI/wdgM072iO0FJF2Li3OhYF2D6lcEEAgwtVL
	 QRJdQc8lziXrbImoGerqMDiCurK0YWARRvgdm8b6dm+LATmqZHLKEuTtgLszSRvBKyVMp
	 1/GzY3pOCjY4mFg0YsTgT9GFAoqmUq+n7AO/9fd7AkKaL3U4bdwUic5gO17q6Nu24wQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790125763;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=nGQcqC1+MeT1TdjpQVl/Sg4JBLvtg7V6O5Y19wSbARQ=;
	b=DhkRhHkcppvZ+wWTX34GX8vtY7JLumkl/iNSRNpvmlW12kjO0MXGbYJDHX1qpOUif9Pf
	 8sYb7R6tzDpVEDaEQaxJbbDRQu5GktTRG9kBaCJy34czaFTz6ceMP3AT9SHEP0uL6euHj
	 vHmfOz4wk0Jn13G74dprHOYYPLOUSNprrN8yoEKHr0LqSxivvsfVc63YeuNmb5NpHp7WM
	 tOxsQC+mcoB81s9tHM4L3/+4EP1p4u2pf+2OELAF2oVEvhA4Kze8i0xitBDbZSdSP+z5s
	 PnnmqxCUp9X1qr+fednr+W7CLYMOBMdrlgF7Sz58LSUsNpuiI/EsjU1WQS9rTzJ41yQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790125763;
	bh=nGQcqC1+MeT1TdjpQVl/Sg4JBLvtg7V6O5Y19wSbARQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QfKlNRrWOrf49r8AEraPfLb2bhCKZc6gPocfSvOfQNZHU1fwz9GbaW/p5cAvX2JBK
	 y/gI72Dy99oj2kvW5MNkdAhQ7lvaJ5RBmdEzl+2Q/7lajaWqg7rUnDtMcEJEIcchAy
	 YNXYN+jhCqgH/knbeGSmaArS8IoRNOYd4P/Ar/aTevv9rZn75EXzdF3J7rzidCnwRO
	 Jrtf3RFEVYUAjvth9GeBIODdnVyrraZXFE+ZJbDqjPzYDgbxzXwdm7Rqm72KyWjRrw
	 9YZ8pXaIHjsb0s+6ZwVTetJV3Tm6rW/eHTAQqNcNkEioKOqD8nwHZ0Fz77IsQpsChg
	 wPUAJ0iySMeyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A13286064E;
	Wed, 23 Sep 2026 01:09:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 415ED12C
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 20:12:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3329A401D0
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 20:12:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sl5A2MQjjX0S for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 20:12:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 4442D40116
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790107921;
 b=WJz2/2LV0yV5dvXgVRcDqnxjaE671Roc1xfXMPzcWH8m7z2skB7/3Bv2WiuLG1wSBzK2
 ZVMQClVUPWk6UW1o4JQQ4b5Rd6sp9P88QJ2uM3qPErJ6e4Px4ZJc47dlcmYJpK4OwmYwn
 1Mnj3x7erfML1cgE8VV09jMXkfrskbh87UmrlQN8KVRSXVfkv4Hq9Bvdd9PPeOL3qPb3W
 H+QXylHEaaq4wpe6Fz4TaRJobYbPRxpT6x4uskV2uFVW84iu4c6wfX/I06Ut8ZTY+xR6z
 UIgt4AoGiL8sk0f53AwZIgwyz0ZLcFpFy7R90sKUyk/sp48Pq9tRECjtltngJBeY23Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790107921;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=nGQcqC1+MeT1TdjpQVl/Sg4JBLvtg7V6O5Y19wSbARQ=;
 b=AfWyt7YqGf/xbgkKOE1gvIwgbKaHZSCHVm+RlPo8AYOr7C+T2/Fwspf6PVijXuPogrrc
 4c8dcxshuXv0MW8G9rQKrJ1izDJjCxJbPyxNkGKt6J5tfYNt3YYBxFIdEZNZZz023w9n6
 0cA2RylS8JiL+k8CbPPAoMYxEzygm7Q9y4ITJ31tp1Q56T2RMN5st9MH/8uGWSdIe56D1
 0MsHj3L+5pxSmANuqeX6atkrW9mFDBSm54INEFFpQMtDmOCrGXqo3gp2lnBx5Jn4wAcUI
 LGnqQkO6y6DBfYQZ8KGUV94R+uXSYIMq0G+qObY+MqT+d1QumdpEWeaztAZW5mW/n8A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="Ty72f8/S"; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Ty72f8/S
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4442D40116
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 20:12:00 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f633ece3so247074f8f.3
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 13:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790107919; x=1790712719;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nGQcqC1+MeT1TdjpQVl/Sg4JBLvtg7V6O5Y19wSbARQ=;
 b=Ty72f8/SysIoNxqt3q1Uj29SHL+7TBvHtGL9Ku83cP5H9y47ENqLue+bsjiec1GR/e
 Cg1np2a97RDE0zKs+5foCTXY1w9UU87TkY47dLpFMEtKuNkQLA/4ILRDK5lOY7bGrFiY
 dZbcEjBeYGnpf0UWJOxYI9NU7UORSVPYpThnGA9WW+GOnZmzMLdTPPN6kCi9pw6Rh76L
 tAwsZ6iVueLee+r4OV64gx6EsFa9mXIekzhEp9KDnG9w+OR7A7qoC/LCJGHhCtUMUGO4
 eqg7gWMUxPhtJplRfDZcH2u/VNoBI7QrG1ZCUYxkVGz6DpOywrDarBzaMQw3FU211sjH
 Ajlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790107919; x=1790712719;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nGQcqC1+MeT1TdjpQVl/Sg4JBLvtg7V6O5Y19wSbARQ=;
 b=y+2luFbWC0iwAmOIGL/J9TJToO5IOR+bbZ1NrZI7gEVqOM4yPzWyf0G4A5ebySfDz3
 SKC9GV+w6W8oqKoWjewJKY8TPChKvKvolSxFaLz1RM4mHrCsoBm/TWiqbmww9HPDWXoa
 rYWjhEXabW2czGz1q+Hyqxztqm6QPqIXI24pj7t6Hj/t7yusykBnVsj5TcFJxn6ejFSD
 50CGk2Vsc0AMbDgCam6nUtO2SR8ea+CtBn/XaGfWJftDbMrQ6v8oZfFlftqIIMg77va6
 oaBq/8yxYR3XC/yG+NChPeGrVrURf9KSL0zzUI8pul5ETUWHB+9bri9hQ7smazFElqXa
 xOsA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwcq9umdfO/LR0h1c67eVRuXLZT0uF7v5LO8Fz+mGUa/52co5FAi8POnW2iCJCO8igW3V192Dk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mscMXFEF4DgehDEKGL37tbkD+Y9017BkDmgIzubxmqvHLi1aTZ
 kKcDotjP6LR6okWEXorxGHqiHpp35OOZP7qC3wSQvSmITWNBqewR89FH
X-Gm-Gg: AYBFou2Xl4V/YiXRD1YVosOtXxYNd3LamvKPEfONt0+fmaweSBg/6wX/X0g8zqCextB
 DMLBJwbYqV5b5hTpPqm8bjgHBcdLVCLReji4pMMDVwLImOJO/9iu1Hf61ycz3mI73X1ZS2bZUZv
 nvMZaFlYqC2zoVDLQB2Q1OW2SejcIXfZPUdgStT+ZSLjKrFhYgG3yjqEkeeuhf0gevqAgwJG2CJ
 pbTgy+sEWdEETryTlFEjW87ScgT/dR+ySxO06wsE3LUBR+yf9/xl8SMBTE1S6W6VgRm6YwPGEXG
 7pJKu7srdj5h6ONf0ccHTH4w4Sc1d4TFLhpFc24rMBAVg+84g1J5lOda4gA2IXBpYdvfD4//RUD
 O1/2acXS8u3llj4Cbi2NO2WOSpCgEUqrW5Q5kDTMaofByELTAQ5faEKS2uEslJ8da3+hFYxhhmc
 rEj8eazmqTHdUsoeExxkZn8lkZ7BGJzn0g9aWEJA5PSeT5fry8IGr3DJlhFkeQ8NlYE0mKkA==
X-Received: by 2002:a05:6000:4a1b:b0:485:c240:20f7 with SMTP id
 ffacd0b85a97d-488670a0f1bmr940015f8f.53.1790107918414; 
 Tue, 22 Sep 2026 13:11:58 -0700 (PDT)
Received: from eichest-laptop ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886848636asm815743f8f.6.2026.09.22.13.11.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 13:11:57 -0700 (PDT)
Date: Tue, 22 Sep 2026 22:11:56 +0200
From: Stefan Eichenberger <eichest@gmail.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Tom Hsieh <hungen3108@gmail.com>, marek.vasut+usb@mailbox.org,
 stefan.eichenberger@toradex.com, trini@konsulko.com,
 hayashi.kunihiko@socionext.com, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v1] usb: dwc3-generic: fix ref clock lookup indexing
 wrong clk_bulk array
Message-ID: <arLhDEJhOWuXJmJT@eichest-laptop>
References: <eab9d4af-6f01-4963-8fea-49a53abea2e9@mailbox.org>
 <20260921054432.2978558-1-hungen3108@gmail.com>
 <arD0gD8AMpO_B6kT@eichest-laptop>
 <898ceb98-5e56-40be-a916-77a4133d838d@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <898ceb98-5e56-40be-a916-77a4133d838d@mailbox.org>
X-Mailman-Approved-At: Wed, 23 Sep 2026 01:09:19 +0000
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

Hi Marek and Tom,

Thanks a lot for the feedback and explanations.

On Mon, Sep 21, 2026 at 11:40:15AM +0200, Marek Vasut wrote:
> On 9/21/26 11:10 AM, Stefan Eichenberger wrote:
> 
> Hello everyone,
> 
> > However, if we have to handle this corner case, wouldn't it be better
> > that probe fails entirely when dwc3_generic_probe is not called by a
> > dwc3 wrapper driver? Or asking differently, is it supposed to work that
> > the "snps,dwc3" node can be used without a wrapper driver?
> 
> arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
> 
> 792                 usb3: usb@3100000 {
> 793                         compatible = "snps,dwc3";
> 
> It seems snps,dwc3 can be used without a wrapper ?
> 
> > If that's not supposed to work, I would propose something like this at
> > the top of dwc3_generic_probe:
> > if (!strstr(dev->parent->driver->name, "dwc3"))
> > 	return -EINVAL;
> 
> The parent driver name check sounds good !

Perfect, then I will add this check to v2.

Regards,
Stefan
