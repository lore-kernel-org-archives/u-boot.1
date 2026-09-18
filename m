Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8081C982DC
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 12:36:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D9B0281296;
	Fri, 18 Sep 2026 12:36:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kxQAnC3DI6kM; Fri, 18 Sep 2026 12:36:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CB22D81292
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789735018;
	b=c6xrpnEGwQqk0nyUdEcb3O1sez/xTe8wUVTMLExxoNJUYi766bXAHjVGuvgOpHZVlSFs
	 NjQUdjQ73LZrDer529pJY4xadDbLavO3spMKeFLUVK+95JRFq+ZcwgzXWmOLKLC4zQlR5
	 VExtZnCk4t0x5/9smgW1Ggii9Nlcx/t5l5AR7NXXdkHPSw+oMH0KFm0zTLI/KuMTNyxVc
	 iMoeHM2Xg3NjdLughY2ZTzvOtG5FwaPtr//KfljHeiSv5sGuXi3BdbYXqmv52GPTVKrKP
	 r48a6d6UeKgZL1F1Pq71ep8c+cGMix4rgFDMY+AkCm7g3gGYh0bZx1oykAXrJpW8+2w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789735018;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=exPYLK0ZI/WcLu9DL4y5r05Z0RhX1kiPlYgHUdcLBVU=;
	b=DgJ4C4HViygv/JWuXhFFqMfztlyUkVAZZHtXMUZOWuDCjvE3CJ0ckSfTv4WJtSR5jnFs
	 cycNZ+Nuid8+CmWm1w3sc2QPlhcn4iDNYL6mje8/Qnrs4LtooWTwXYmU/20yUmgJgoQkT
	 hNIDUooddqFnNPaenFJLRsn8hzK0uyGw5g67JtWsP2d3SZDQWoto/BhLqy0Z3t6+JBcgq
	 Mt6kWpcx2OHjs8igpaxpmK72qBDkTcwHortmcvDpBfaN5wnWUiLNGiL3EHzxsNqMnzH7W
	 +uiVMtDYK8IA+YtxmT8zdxqcezSkPGleEiJtoHiCagzCn8AhR9s4P0NMciBBZQXT9DQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="H9y/BZeY";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789735017;
	bh=exPYLK0ZI/WcLu9DL4y5r05Z0RhX1kiPlYgHUdcLBVU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K0qjhTuLXRAVw3N5bRWg6QlbvSfXrflxU3jTjRs/cO3fdfUIgJuNeXL2L/FKQYRiq
	 jPUWn9LCRq0cQ7QALTdrWQza8gnpbWrTge4nVZbz+nooLznNcM2GzVFIQGo9zlGdIP
	 WpOEQBJNIFoXTJXex9ztqt2JE75sZ/xZi5C6TqqhUCJLCgFizP5eSXZh6yT4KnSHCs
	 JEF1iwHimsr4KHYBagnTPBIUhVWn8/KElRDLaXylJ6cdDabB8gu4byDAZIgvlIrwyz
	 67vUb4KHZ4FdYiK4h1+WJd6PDq0yla9PDyuUjliz4iyOiK5pFB223OrZwogx3CxbEu
	 U24/yiWwgNW9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CB22D81292;
	Fri, 18 Sep 2026 12:36:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B6C13279
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 12:36:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A892F81292
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 12:36:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f1LrISgX_Fv8 for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 12:36:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7602581291
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789735015;
 b=hiSH3fdcrV+2lalxklMDY7ulpK4AD5oZYfg/fIRixA9T68oJuxggZ5kKKS+bgCV4GF+F
 G6oiM8V3Bpjg2/A4het+RB7+FG7vzyzmeHyL6ygYsRegkD7nxDN+7d5jrF9m/SOXcASY/
 1F1g308BZnN0h5SaXfjog1t6KJKb6Dx9+OvY51NJsBksncOFI53kZDMhvTec8OvDKGhLZ
 fPJ/nwnYKMa4XaNUOZkH6By72NKSN1xnAb4ZZKONw34FoxdlTstv9aWPHkHDeSVE158Vw
 puHAFRiq52amZDjuR67IyWSlz7OyyyLiDX+qEFekzIwfqFKEzJcCFPZGZ+APFTAnrew==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789735015;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=exPYLK0ZI/WcLu9DL4y5r05Z0RhX1kiPlYgHUdcLBVU=;
 b=P2DirKRHc7TCqI2IINb/BazItiNrp9bl/aqbLvtjMbiwJsLMI+6TMsRB9mAY4cQq1nRF
 CZHvwmS50dvinRbmcpGKaMZdQE//2WIM7/XF2j3xkclYdMr0+BuO8EZx/SuPf63xscP90
 2b8xp3zvepazRJLa0rwISPx6TnLpclX81tBJL6QL6eg7WGyddf0CMuvsAyuipkP3+HYvQ
 nPtvHPKjoXkOoI4dzaRRGsRO8qUDYwsCsMG4FjUjDNds2YNWsA56cj4CypDa7sH7+FJ3h
 PdiiNEZYYNQkisOiKkT+KGyCoGphkTDiA2f41utStwaN0ZkEKJ5rAQl7fRUyLyxZOKg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b="H9y/BZeY"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::10; helo=mail-yx2-x10.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=H9y/BZeY
Received: from mail-yx2-x10.google.com (mail-yx2-x10.google.com
 [IPv6:2607:f8b0:4864:41::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7602581291
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 12:36:54 +0000 (UTC)
Received: by mail-yx2-x10.google.com with SMTP id
 956f58d0204a3-66e4ab222dfso657821d50.0
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 05:36:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789735014; cv=none;
 d=google.com; s=arc-20260327;
 b=osSpNN25N/A6DuaunZHsOWMU3C+eRfBkMAYh/815h8JDDf/Akilyk8jmbEUjBJeygm
 4xe2c51mMVjFFXBJ939A1Z6WngiJvT3Ruv9rVKKJYZp1rG5sdA+68DGZ8NkFTOCOaqf4
 bRPO+5q5BInh0SaiLMQjWTc5ekdcgPO0zvpXG4J2qQz0oMoQ+z2+1nUVZKJgP1Q0GBLn
 NTHXDQepAuvvyWoJ6GOZya/2Nr33ZSStUErnuiLOkxXxVPqo1MgKHFzK1APzqO/7VPle
 ehJ5mRINXsOLrSsip8omakyGCL88J/x+aAoFtOG0WPZn43/BDH/hI46RjDjXRSKBgKgt
 bTqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=exPYLK0ZI/WcLu9DL4y5r05Z0RhX1kiPlYgHUdcLBVU=;
 fh=emuA1F83Ks5EYF4hIBxaxs1GlPlePLJXnK0GnKIzCyg=;
 b=Qeit+CvcgJT7xUlYuBMaL6B+Y42mx/729L1vYXpkbqBZKhGZv6Dsw0Ni2mdbtgPiTP
 +vntvLa97Kyy2XLJZf4vbe6C5ZG9K3rmyXauWrIgHlU/4VrjsHiwLCEvfH4DDhvlNxef
 Q66RfOsJvIPl7FCFm5rY1tyUHfa72j0HNSn2eDnwEIT3LEeYCE0tO7GRWvfzbDw90Bn0
 NT9GHu8c2hcjOkxhAWOpvFgt+8CLOhVxTMvMCGNHmTKAmhB5+6ugoRKCAhlW67RpREq5
 a8mNbK0pBnP3VbZk08tBr9VDdaunEm+5FdI9G8bngFpUEQA4T8+lh6PvUIO46i1aMD/K
 nF/w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789735014; x=1790339814;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=exPYLK0ZI/WcLu9DL4y5r05Z0RhX1kiPlYgHUdcLBVU=;
 b=H9y/BZeYh1hOpJ3vwL5WCP4jvr06Ma61//rRvGnpOLXwkTxf0Uz43TZKwKEE0WrYkq
 4dd/kK/v9KdeHwjfljo7XeSFMD9HqiV4+0FZoCHObXeRltaNV97neg79ItB6yUF3LNcW
 EJ07YLMCofNiiDLTnxm4uc+vMoyDj8h6StOY+6KybWHgBni8r6U714rGtvbOwPX6Y1AN
 YK7c4/J9iPZ9GpbFZOfcOKUscznv4C1RAE/PhNVCTgYWtVmq0IEV8bfj+1eqS5WMngdH
 xf08k5S9N6ofm5bhdT7L7k5oxZLuFlWLlTy77KD4nOhPoXH6rV3HyJScIdvpAat65Hzd
 EKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789735014; x=1790339814;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=exPYLK0ZI/WcLu9DL4y5r05Z0RhX1kiPlYgHUdcLBVU=;
 b=cXJvxoTWrYXHJ/4cxM7h2m7XW6X+ZJh6i7qw82/v958GyKGWf1KVYYnbFp3Ev8zJLv
 /MV9aU/b1Hqz1TJVqjuFxYc+RZdf0j1pOfSfgvnbDQABPf2qUH40Tvl14maV97GUEZEz
 l04cOuYURg2ENmigf/WYSctsAKFa8Mbt6YSoJUO0YmXErMNx8aPsBQK8dy37u+weOstY
 SAjIkSUZGGUj7bmHsfj8z9uFct6n4P5X+wSuq3jwqLv41vrnbJe70LF0Nsj/i6MWc44o
 YFahOtyMkp3S5tAXEHmknPCBiQ0KdJhNPmxOOWAeMK77b+Mjwea2fViemyM8q71yZz1+
 pnbw==
X-Forwarded-Encrypted: i=1;
 AKwUvByVEdMSVne6wGL+SLvNLGkMwPuckKICHUp5O3ew4+exo2//w7ldqHUZZXyYHRNWwHOEPKDRuZI=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++l7hznK2XWz6R89Bny+dCiWM/VABqpuwyWgoy/rzqWRB85MfBQ5
 QV3zuQ1/m2zTJUkfpxNmk+hvq0Dw2TxXnoZd+SwAfuq67Xanq7avflwGeRuJGSa+nvFtUu380ka
 ht3hlJio3lEH3qyYAZAssfNPzTS+mKV14yt2h+gjy5A==
X-Gm-Gg: AYBFou0UHQwJv6W4XhAKmHkFd++mC9iFRZt7GUH/3oZkGpkxjT9zYv9l/nr8VotNRWy
 5GZ6o4HQtF75vr302ckSQ7szSiUOOknpkwr23jMmI9ZP/DoPCExWRSXn98OBxNG9KemUL30f89V
 nFE3pVK2X1fvNRFRnfMJTBg7EjYT5YfwcgAO2so81qYDdYbREp1R9rC7QqjXVqUjjcPlWQ6ISKX
 9apYLdwe8neAVlhbwSK0ayhpnpwVOKdHel3xRT342y4tN0v+E3vUZoVj7aVSGgpZ0/S1adVX96P
 Gg03NPIJDBPmMfcxTh/JUwIDKvwhYRDdj+R8zoSbBVXERKIexwRwlhtwFmMR0hUTWo4Vqbep6qR
 MMWb8YgUeWXyYhGu2eVKeEv+klj7u7iCD+SMcTNMqso3v3IWEZEkFqR+P3ztlQK7fuzcsPBj5Ea
 6odCsla6lHbjoEaG4fVkN9pPZlNYXT02Lxgd0+TJH91siK56dEAOwkBbVokb77fWNobIC7Hopnt
 45KjhX3FHv32ZkQeapwDHWBJG5p+2cJ+PLq6r4sOFZuxnXHR/7adOrL830CNG6WY0coPykDiEv3
 J+h8vZ4fzs0nUtvZTsBOfie8MwTv/hLMtiDEAu02jS7FRsNzyIqwdY6QFrayojb/pBgLHb+kk8K
 nWpBQi9I5RMcyovGLeai26llP/O7apVoaVy6RPxRSTAMKZF7EqKzR5YQ=
X-Received: by 2002:a05:690e:4195:b0:66c:486c:aa1b with SMTP id
 956f58d0204a3-6717fccffc9mr645651d50.38.1789735013788; Fri, 18 Sep 2026
 05:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1789023381.git.jan.kiszka@siemens.com>
 <1a6e9dffe86b43d3c62ba185859d30a376fb61cf.1789023381.git.jan.kiszka@siemens.com>
 <CAC_iWjJ7b=Dh+8k49Mq7W5=-b1dZV=L7Z_E6epeOCoej65unyA@mail.gmail.com>
 <5d4aff06-f1a6-4634-b7e3-4e054d5117d3@siemens.com>
 <CAC_iWjKnBrDYErLbDkQyv5tp545-_pfFJA6z1kmGcXvCPt3JBg@mail.gmail.com>
 <abb5973b-b417-4ab0-92e3-d3117ef68bf7@siemens.com>
 <CAC_iWjJaBtq5r=DJtdf_UWUxv0Hn6PrUFXi9xxDT86BdHibtFw@mail.gmail.com>
In-Reply-To: <CAC_iWjJaBtq5r=DJtdf_UWUxv0Hn6PrUFXi9xxDT86BdHibtFw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 18 Sep 2026 15:36:17 +0300
X-Gm-Features: AcwNN1UBzAGbrA7wzHSPcacGaKa0sAxdWsIYf1u4RP3j-HuIs5RYw2ModtCKIgA
Message-ID: <CAC_iWjJmRWZGO4zOOp=s2L91MLwJjMamHmP4jzXkVNOWNXyFRA@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] tee: optee: Add support for enumerating services
 that only need RPMB
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Jens Wiklander <jens.wiklander@oss.qualcomm.com>, 
 U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>, 
 Alexander Heinisch <alexander.heinisch@siemens.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
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

Hi Jan

The CI seems to complain again unfortunately.
https://git.u-boot-project.org/u-boot/custodians/u-boot-tpm/-/jobs/96289#L2649

I didnt check yet, but it seems like a missing header somewhere!

Cheers
/Ilias

On Fri, 18 Sept 2026 at 10:11, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Jan,
>
>
> On Thu, 17 Sept 2026 at 18:24, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >
> > On 17.09.26 16:57, Ilias Apalodimas wrote:
> > > On Thu, Sep 17, 2026, 15:04 Jan Kiszka <jan.kiszka@siemens.com> wrote:
> > >>
> > >> On 17.09.26 15:01, Ilias Apalodimas wrote:
> > >>> Hi Jan
> > >>>
> > >>> I pinged Jens for some help with the OP-TEE path.
> > >>>
> > >>> [...]
> > >>>
> > >>>> --- a/drivers/tee/optee/rpmb.c
> > >>>> +++ b/drivers/tee/optee/rpmb.c
> > >>>> @@ -191,3 +191,23 @@ void optee_suppl_rpmb_release(struct udevice *dev)
> > >>>>  {
> > >>>>         release_mmc(dev_get_priv(dev));
> > >>>>  }
> > >>>> +
> > >>>> +void optee_rpmb_available(void)
> > >>>> +{
> > >>>> +       struct udevice *dev;
> > >>>> +       struct uclass *uc;
> > >>>> +       u32 tee_sess;
> > >>>> +
> > >>>> +       uclass_id_foreach_dev(UCLASS_TEE, dev, uc) {
> > >>>> +               if (strcmp(dev->driver->name, "optee") != 0 ||
> > >>>> +                   !device_active(dev))
> > >>>> +                       continue;
> > >>>> +
> > >>>> +               if (optee_open_enum_session(dev, &tee_sess) != 0)
> > >>>> +                       continue;
> > >>>> +
> > >>>> +               optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES_RPMB);
> > >>>
> > >>> so both optee_probe() and this function will now call
> > >>> optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES_RPMB);.
> > >>> In OP-TEE that ends up holding a mutex in tee_rpmb_reinit(), but I
> > >>> don't know OP-TEE that well to figure out if this can deadlock.
> > >>>
> > >>
> > >> I was developing this under the assumption that probing and init paths
> > >> are single-threaded in U-Boot - aren't they?
> > >
> > >
> > > They are but iirc the responses from OP-TEE are RPC calls in the RPMB
> > > case, they aren't guaranteed to run to completion.
> > >
> >
> > Maybe it would help (at least me) if you can sketch a control flow you
> > are concerned about.
>
> I didn't have a specific sequence in mind. I just noticed the mutex
> locks in op-tee and was wondering if there's a chance we can re-enter
> on a different OP-TEE thread while holding the mutex. But I can't
> reprocude it locally with or without CONFIG_OPTEE_SERVICE_DISCOVERY
> (which changes how the device is bound).
>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> P.S: I'll fixup is IS_ENABLED() during merge
>
> Thanks!
> /Ilias
> >
> > Jan
> >
> > --
> > Siemens AG, Foundational Technologies
> > Linux Expert Center
