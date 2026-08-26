Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 531EAC5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 13:01:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D04BF80BB8;
	Wed, 26 Aug 2026 13:01:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k2gnonS6mRDs; Wed, 26 Aug 2026 13:01:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787749318;
	bh=6BRUHqF0JO5iXnrW+t1DUqTC9LTMA6iuUvzVPTiLEd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oKCCZ3yUdGHE2l2RZIvRCf1KdyEyvj3okiI3z+C40mXtRkwOsqQO80SuDvzfLZyp1
	 pqHQKxfBapuPGOpt9pbziSyur3DTJztCasd+P3TyXX5tu4b/xccfHFyklpf6sOhcbz
	 Q7XDg//HeZ59cWtMfRKKiitF0kpGTRvfBOaTtCkERVOIseUzeZFxAJuCNM17kdJcg3
	 x4ipwwUaHGhE7uQQejH0Xzvv2iSfSSCnIN+uVRKfF9DfFNGD9u81KLTZhvj6vupOV7
	 WQvrqkfBrm/zfv8XxMTNRCHM2LIcM+ks4LT/Qc6TJMdq5DOPE4k7kRjB7Hp4SDPPJI
	 c7atmvOnnYLxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 499E0809B3;
	Wed, 26 Aug 2026 13:01:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 93E5D23E
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 07:16:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 79EFD80B1C
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 07:16:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pKd6oaliOG_O for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 07:16:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=cam8JAs3
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9268180B20
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 07:16:21 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c250a2bc3b3so71386366b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 00:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787728580; x=1788333380;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6BRUHqF0JO5iXnrW+t1DUqTC9LTMA6iuUvzVPTiLEd0=;
 b=cam8JAs3launu4GEnvjQ/Y7sULKetBsm33njbvMPupmY71vS03pMaIcPKXS5CNWlZr
 Dtc2FcT6qiGWvDK1iYplxzzdPsdeDP2VWFP5P/U4mIhZMFx6nx45oMM/ycqhCmCvyBVA
 C5fj8LmdXKmlP71MMZkn7HbgcncUgNWuddGHauuSG17Z12t4rhFOfl0G8Z4XHHoBL3TE
 NV9FBSJ4iqReuonqcMumbSDuw3cXUbbKzwI3OV8CwOXsDAGNx2SW8Ej4rGqAeA4gWRaS
 AePLm5k462dzto4ogJj9bTgtETOsyA3ldOchkgbulSt3n0fUu8UcVayEGYoQFd/LFH20
 /YWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787728580; x=1788333380;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6BRUHqF0JO5iXnrW+t1DUqTC9LTMA6iuUvzVPTiLEd0=;
 b=VrtGwU6XtTm4dePMDpsW8gWE2fSsohGiHsyatCDLuO0FJDCtVHsjxJn3M3rKDdikj/
 bpGVt2qMYcCDLoDQuDqtkc/c5poVvyNxRkIAZGaZQX1RgOjtjmD8KtLqtNnyWgUrbDn/
 sNVm9u4/vY9CqmBUfZRWjSakm6NZVPLHRVsMUN8JYVNx+H+NlYe7UHKlEAK6JklyvWt+
 ZAWKCS+SRnRlbETCp1cT+UeZ7ChZ2CvaC6s1+vbvDtlDxAnzwhiEfWIjY99LKB71pi3d
 yHzdIgoTDbyTpRPdBrD1vIBD5AgKBzKHYRF21YyLmt7NY6jQWWYBTQew0CiS/V9N7A3C
 yulw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpaxMq0lwQnxiR+lVtj+oupZDRhqHPKl+IEJcr2+FTx3xOlwXFz7OX9EHxkhA0GOdUq/vstP/k=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kfbkgaD7wkB/q/ZuNS7p9LIiE9Lkj/D9SerCBS5yZ/Q2Ptqy4E
 uLgWqA1ckTOglHy2qQGvujI0tFNGKVxL0ER70qLzUVsFeP6yhGoOhuvX
X-Gm-Gg: AR+sD10r6Q4QUmaw0rD2D6affXnEQl/AoLAgUz475eED8PZ95dxTH6Z1WL5ZjmSgkOF
 EAdW0RhR6El+iWxk7cQvdBhQcwXmRAWZHT1keJVFe0zbvN/4SlR/kWXyqveO1hSLZjy6gYtc+X/
 JaxIZKNDOy1gbTHS9JschvGAiuY8d6DIPWEuihGWnMGDBIXNKmGou6NRnIKlHHS0A2KvLrxjkF9
 f3912K6s6GNy5e6GrOrX5uf1rE/ShkEmAFvHU05PgSRuL3WhboIRbjGiyZYDo4ajRLx2Pg2DYO4
 5FqSOzTfCOBcPbCsDAx4B1+rN8UhWc4g6oqOm1dvthlMdeTLqXz+tfc8+jF6tzes8w/S4gMqrl1
 hOM2JyIaQGKGWgCNBJPZPZuzz3Q3i6AMT67SXD+kbkTZ/dtvG4eWGG0z3cHHyEP8etG4ThJaKlX
 9gSPMPZAmIN0O17M9AWSiHTAcMBZTpfyrSjkISAA==
X-Received: by 2002:a17:906:4fc6:b0:c21:9870:c4f7 with SMTP id
 a640c23a62f3a-c250c32b599mr572772066b.20.1787728579650; 
 Wed, 26 Aug 2026 00:16:19 -0700 (PDT)
Received: from eichest-laptop ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a88ad70sm369629266b.38.2026.08.26.00.16.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 00:16:19 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:16:17 +0200
From: Stefan Eichenberger <eichest@gmail.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: francesco.dolcini@toradex.com, trini@konsulko.com,
 ilias.apalodimas@linaro.org, sbabic@nabladev.com,
 festevam@gmail.com, uboot-imx@nxp.com, marek.vasut+usb@mailbox.org,
 alice.guo@nxp.com, antoine.gouby@toradex.com,
 stefan.eichenberger@toradex.com, emanuele.ghidoli@toradex.com,
 franz.schnyder@toradex.com, balaji.selvanathan@oss.qualcomm.com,
 gurumoorthy.santhakumar@oss.qualcomm.com, mkorpershoek@kernel.org,
 xypron.glpk@gmx.de, casey.connolly@linaro.org,
 hayashi.kunihiko@socionext.com, sean.anderson@linux.dev,
 sjg@chromium.org, ernest.vanhoecke@toradex.com,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v1 3/6] usb: skip host-only devices when picking the ehci
 gadget controller
Message-ID: <ao6SwTIr876ifB8l@eichest-laptop>
References: <20260824183048.419198-1-eichest@gmail.com>
 <20260824183048.419198-4-eichest@gmail.com>
 <36d72877-ab8c-4338-b34a-dc85c82c039f@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36d72877-ab8c-4338-b34a-dc85c82c039f@mailbox.org>
X-Mailman-Approved-At: Wed, 26 Aug 2026 13:01:55 +0000
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

On Tue, Aug 25, 2026 at 01:45:08AM +0200, Marek Vasut wrote:
> On 8/24/26 8:29 PM, Stefan Eichenberger wrote:
> > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > 
> > The i.MX95 SoC has two USB controllers, a DWC3 host-only controller and
> > a ChipIdea OTG controller. The latter is the one that can be used for
> > USB gadget functionality.
> 
> Both DWC3 and CI HDRC controllers are dual-role on MX95, are they not ?

That's correct we only use the DWC3 controller in host mode. I will
update the commit message in the next version to make that clear.

Regards,
Stefan
