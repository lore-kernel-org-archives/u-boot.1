Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A63B606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 13:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KMGISclN;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=G1qrGwj4
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5498940699;
	Tue, 27 Oct 2026 13:07:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UGfK-KMOBqTb; Tue, 27 Oct 2026 13:07:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A70C040707
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793106468;
	b=P0bfphu+E34YN2JCvHJvHOf9Gc6+YxqnnU8xreIYni74/q1KZHYm2Kn6iAiffbLVR3e3
	 k7fHxVhxZhcx2QaCVsLueCyT9hhGetS1vCKuPQpWSobHOfxPhQKjVhW0JQ/ztCNzD3RAT
	 dBInFe/h708Jqm5daPSVQy7ys4zb+cSJVpGaHn6YkndMwRMAJW2HEDm/l78hr2zvKg8Gt
	 OHVJpSt4zMLVwt97kMHhc6x/Y4yUEasNaFeBhfos7zLxNcrLddyfdx47VoswaBqwlNOXo
	 LJ9UodhNIhY5TpXqzUQiT/sSr36uwhk/In2Qid6oS9fGv2M7sehVZGAr7h3jtNH7QMg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793106468;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cYcmBzmpDsekv2Qqj+HjgC1khWgRoKh46KPb5x76Ofg=;
	b=RVAS0S0XHtc95UVTPMfggx9QyMQKtNNFKFhHkjAkVNvuNTkwZG70cOdGdqgXpqvua6Oz
	 yPSbv4lFDoe4/PrDB46mFuxjWdGLJLgg+4V1bNyaVvJaQg9LF7W0R5ppXTRBj7h2976/a
	 weGHcs0ukQxKAtsqS1091oDTfVL41VKeGE5snE7tHpVlx6OHIm3xzVg6WmbW3I1bCWaAL
	 063OSU1kduH1JC/CMAVjaWatk+phcw6gUGVOQCwqQUjWj6fowEJOXWhW6yJ0Q7kZvl5XW
	 7G+X/VCpJSPVxism1lqOU8Z4zUvioJal1l09pFrCkc/nTTzLNimWbgDY9twMPdFAJrA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=G1qrGwj4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793106468;
	bh=cYcmBzmpDsekv2Qqj+HjgC1khWgRoKh46KPb5x76Ofg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KMGISclNTxbt0TqtVn9ScdHawyKYKN/jUbcoX4UwyWqWbSev2pWJI2oXHzC70eg42
	 l5rxDQA21YEpEPTlFbTVQ13hBNu6Pc8iOC914VSDSN9+h322x51BynmBqFgJtFCkf4
	 udrTHEbJUlu8yVmgw3gJC+lKjtPBE1FRGit4W2+WaI0AF2Kl9VqV1HFvSq7AeuZe+2
	 XcudfR98ujUwVh3eoq4UngCYdoy3IgNx4SB5VLCFZHMibK4lMcDVB/vNL5VfZskMtx
	 dzj4SrAjvsfFeYYp2c2bPj1cHntfdTwxUqeghesFrjGpDF+t6sjeKz99LHWoIwamzq
	 29FfGpKrprYpg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A70C040707;
	Tue, 27 Oct 2026 13:07:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DB3D4A32
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:33:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CC94F405F6
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:33:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y_b2GquIPyL4 for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 12:33:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BE72F405F3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::629"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793104438;
 b=Dpb87VuAFdiZFeq+ZOBz6+/LleJqnSC+GU1U2b89t/O73aypj9QuGp0P5/q+q9a2eaU3
 Sa2+peaQAoGqy4ReDyT+BJhhyUwRjUUeIvLbv3L9CBHwInb/qE9fiwuv4Xwz+4ToTvPzt
 ihLG1SQn6tWNbU3B7Qns6Hp+iOmreGgr2NjUZUVKTuQ30kqRaUTMVxZGnBWhqtggyfu97
 +vjLqxtK2HTqqHpkFoKfdJX4STpB32dVNuEvx45P/lAkztsF8i1s2YtvzfnDZjqSNYeYL
 xsT7fzLOGLDzc+2kJJs0IXrozy1kGTDRCx6Y0GL5YRZIz3VEdq74ebjjwLs67op7OCg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793104438;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=cYcmBzmpDsekv2Qqj+HjgC1khWgRoKh46KPb5x76Ofg=;
 b=HC8WQbEQZMTml8cxAtFp0cb72SQ/jbzUPDplfnVL1J1I2ofpYeACKtOdwv8B2SsoIzF3
 24qurp8819k5/mEZIDtbz1sBYrZarcmb6L7n/KuKDWsIMJXaNu76S18ZzHUjkSe7nPQFS
 t5GGkivWcsp1ZZlfAUw/f6cuAUGwLfZQa//2Yvgf875RTA5HQtOwSkPnXeNh8+A9ueCYf
 0N7DQZ/Qn/YzkWlmlZKhiAShTGVfNjLGl2jIK3ZkVJeRUHFB3NSuzpK54ChLrZ3jwhBcV
 N+Vjlp3qX8GamK8kqrhIYw6b6KlDAF5CID/W3auvDywbTPvv4EEUtjdlP3czWprLJ5A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=G1qrGwj4; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::629"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=G1qrGwj4
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BE72F405F3
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:33:56 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c40f5077425so41374566b.1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 05:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793104435; x=1793709235;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cYcmBzmpDsekv2Qqj+HjgC1khWgRoKh46KPb5x76Ofg=;
 b=G1qrGwj4gXUt1OutzRvtmK8bCwKza9aW7MUztg9cHWsFFF8IkK0pzf74DaYhK3nO1l
 wI21XfdJjqFuJklyEsRmBKa5XReXrIQzFvgkORVVq4t398rNORi/5nN+NAHMiw3M5uwQ
 i5ZyKEUfyoNEiEANjxmZrI+OS/PDpoE/EvcG2GP1VkX7iz6EqGs+BFiRVOOm1caeqdo/
 XZB9dLmntLitUuXwI6JyAmuoCazsVTkDTs3wukLwjtK4zlI1F+v/yY93Idri3FnH4hzB
 vZoJPs8VPdbAvyJYfO8Bm9G+9iZUBPIY6s8yc/epFks8NUU/r7U9CCEDjCRLSEZoaQYd
 LMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793104435; x=1793709235;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cYcmBzmpDsekv2Qqj+HjgC1khWgRoKh46KPb5x76Ofg=;
 b=rbfRxS1wDiAVHk5CteDk5eBHWvPUZFkgTWnwoPdYSClkHRHIBSGR+S/wfEQsr3T1Ai
 w0MgpZVZsR0a6PtEHFukA0+JxiuWWgVJc9+XwHy9PghIjMquj+dB2WLYLT1m2PfCGSu3
 Tb9sfqTkMTtB+j6BrnknRo7OIKYptkud7VgUOGV7nJ8aR5svjKtKQ9fFxy9pYBYerOQW
 FqFUh/xPPxllG9mr/hJ6a9s5cv2N/iRU5W6u+hBP6OMBEsDVzxIqc9An/yHAP9XUygYK
 1ahZSO+BPG857Y1ww+WCoR1D3906EBnSOXX6F1JgmJeVE+WvluEQH6JWo1IEYCX6A53U
 h81A==
X-Gm-Message-State: AFq9FYLP3MNzeuNlOthnlNjgUplMlmbUgKJM0Y8cb4kmmRnof92u6Pht
 BNRBsEJRQNd63bG2WDIjwcLVk87WMnEQC1GQ2HD4BXfPUeUDoYiu1JYtDE28x8D7UxQ=
X-Gm-Gg: AYBFou2xCxw8UCDPJn0l1rVj3yo23wXMoHmeqspT6OnxaDyqXfdwF0b37sSDSzw9sx6
 aQ+y9t1tBth44SCUJXqaM/XlbdHqCAAStJOICYdZxX23fWWWtTY3xoBZ27Alpgv4ctuaOeKaAC3
 APjAGGj7mD0kKCD8vzZN67kmQcCO7p+YJON2pIQvB1gNV4qdkZevT6iWGTp3PMjXxhPYbBeQ3PR
 M2LciVL7bM+EKoR3+54cO1UFDtitEiaZtWiaT7Q3AwCGkeqVhlbgkmRpSnEvo+1dG0SA93NMXXU
 EiS0dsTJGWkIlu4pDyudK+iP4yyHkEiXP7MS+qciCgPkxpsgW5GDmnI32R8crLLP5lMobWkmjHn
 hACOxvPNGgvBxsVLFfwapUf4aSbtHC9P0elH6i+ZzJZbz2msiykucUbz67djl/maxX/l8qkcjRC
 /7XTne0inPxh9hrl1517A8AwACvJI6THEdOk9X6nGBHzq+V/KVesSa2eTBYotU4dPedrhyEL9j+
 X7YZd9vYQKJSad2rZyc/kOZ/6UFH/TOZvPtoP6pm/i2TRAuH8k+SstA1s0DIZFK7bfUCIeO3y14
 9AI9vYTRWWO6a2XyQgKsMj0Saane0jaUhg==
X-Received: by 2002:a17:906:f04c:b0:c41:3963:6f1f with SMTP id
 a640c23a62f3a-c46bdc622cdmr1570882566b.4.1793104434591; 
 Tue, 27 Oct 2026 05:33:54 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd7984f5sm442298466b.77.2026.10.27.05.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 05:33:53 -0700 (PDT)
Date: Tue, 27 Oct 2026 13:33:51 +0100
From: Anders Roxell <anders.roxell@linaro.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com,
 ilias.apalodimas@linaro.org, michal.simek@amd.com, lukma@denx.de,
 alchark@flipper.net, jerome.forissier@arm.com,
 dlechner@baylibre.com, anshuld@ti.com, sjg@chromium.org,
 Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH v9 02/26] dm: add helpers needed by the resynced DWC3 code
Message-ID: <auCaL8srs_5XMClf@monster>
References: <20260916123826.517181-1-anders.roxell@linaro.org>
 <20260916123826.517181-3-anders.roxell@linaro.org>
 <f5a4104e-3b26-4003-bfe1-642db8af80d1@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f5a4104e-3b26-4003-bfe1-642db8af80d1@mailbox.org>
X-Mailman-Approved-At: Tue, 27 Oct 2026 13:07:47 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-17 13:36, Marek Vasut wrote:
> On 9/16/26 2:38 PM, Anders Roxell wrote:
> 
> [...]
> 
> > diff --git a/include/linux/compat.h b/include/linux/compat.h
> > index d4ba4d0088a0..16c02260c111 100644
> > --- a/include/linux/compat.h
> 
> [...]> +/* From include/linux/reset.h */
> > +
> > +struct reset_control;
> > +
> > +static inline int reset_control_assert(struct reset_control *rstc)
> > +{
> 
> Should this call reset_assert() ?
> 
> See e.g. this, which should also be updated:
> 
> drivers/phy/cadence/phy-cadence-sierra.c:#define reset_control_assert(rst)
> cdns_reset_assert(rst)
> drivers/phy/cadence/phy-cadence-sierra.c: reset_control_assert(sp->phy_rst);
> drivers/phy/cadence/phy-cadence-sierra.c: reset_control_assert(sp->phy_rst);
> drivers/phy/cadence/phy-cadence-sierra.c:
> reset_control_assert(phy->phy_rst);
> 
> > +	return 0;
> > +}
> > +
> > +static inline int reset_control_deassert(struct reset_control *rstc)
> > +{
> 
> Should this call reset_deassert() ?

Yes. In v10 both helpers are in include/reset.h and call reset_assert()
and reset_deassert(). NULL returns 0 like in Linux, and dwc3 needs that.

A new patch moves sierra and torrent to these helpers, with your
Suggested-by. Only build tested.

Cheers,
Anders
