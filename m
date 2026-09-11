Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D01C88E4A
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 11:37:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B5DDC812B7;
	Fri, 11 Sep 2026 11:37:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OYvm3RpFTpV7; Fri, 11 Sep 2026 11:37:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EFB73810D6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789126654;
	b=I7325uEcvpyEDH41BtxGTX/F08X7QFQwBRwEvXko2HdHVacH5VfBVCfo6qnJZLTUThKR
	 QmmC379AYJQrPNJIqZH2iT641JYl3vQFKju570FA3+4hPmlKiBe5BJQXWrPZ59JwXdKqc
	 txRm3O3s8Q7xjtBaKGH5ARpW+P8xouKj1QAnLCVMdvm5BJXQUVpll1hfsh97GbuK8su/l
	 nMK43K3q4TqC2DygEvcsnngk/NJOQ7P/YfamK87h9nObvXU9NJov7/iJdPM47Q7MAFkZF
	 RWhFUuHOQco2wrDLsUfv5Ef0DDK5qVgXkm/sbCQUbS5e3h9tNWmo+2Y3hKGs3Gnk1Rg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789126654;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TrGx9Z5a4NsQb7TvsQnLGqzqr00ecqCFr3Almp9YHB8=;
	b=S0KwrXBDtppMUfnMQz01d/GbEENIpMkNaORDuulVBDvtms9qOmbrwH8QiNt828+aP3eg
	 s2XhhK8X45xBNFJoaFYxs0ex0LyUFgqSVcHuVUHKDHwy1qJYNZkUJW6SwxuP3VFqFN6LW
	 aCOHK5/kREMa+QRyvtYO9ulhLxQiKsPaEsiHMhGrniM4PTpa0t8tOJiSMDInRBC1fdVfz
	 IhHNbF07oxJ+dIvdwt+V78ECI+MUNNJq2U4VROulOOTjNaU+R8BUK1z/X7IT0eApbtUCj
	 FH/FQ0Vu4bXVayP3/SyUjFXZtQoIZUuYjCGkh3nNqZG0nHokmV/sDj5kmczgRL/phxA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789126654;
	bh=TrGx9Z5a4NsQb7TvsQnLGqzqr00ecqCFr3Almp9YHB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rk3ytrD0P2ZOeVEw8GUoYlPE2sQkL3B4QV9cg6UpkkH4S7YVMreN81j9fVRmVntlw
	 yLC2XdhC6LTdnU5a+j/6Cy14fx3BS4Jjpm8dSqznyw4hEb74LX0t4UL7XhSyKtuguC
	 ccAJK+E5Dou57f8b+QaAQ+0mGMP/CNtjERxckIgs2T48nRLibawHbS2rW8lUH3Ui+M
	 7yBSDmPmqLAehf4OGb5xyLneQMDiZgtwhjQaaRRAF8x5HMPghXof49jZ/BLJLVvW88
	 LNUNdqhxuvhe0heMpN5Z7kVPnshBmDMQxGiHKaotZrz24GqP+I+b6sm83gPbVxQfJb
	 jmFTk/6NxcOpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EFB73810D6;
	Fri, 11 Sep 2026 11:37:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 21E1829B
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 11:37:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0780E405E0
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 11:37:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8woYl0wsC2Wz for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 11:37:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org EAF75405CE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789126651;
 b=EQyAlcRNvmKi1FlKvd9Nvin6OtfseWwoG4jEijguOvbkmZDNu3H4lWKTjRL4wnljH0kW
 KIfY0awqsI0bc2FcTx7UzjEaWPOO/+L9pdyzCtUpk3FkwA4NbGPicKsi8ePySDvwdyXHl
 yX4HfWGlDt7wR9WCc1Y+hvu4e5RYyI5O3EgSA7XEBrrvHGqyzX8R8t7WHFTutpwBxvJ8J
 1YPXgDGSEDkR6cMzA/8FZQT+fHi3vhD7NUrII5mg3ts3jw9xqGBVx8tDa4lC5rAsRzSdA
 PxNteUYTSLYj8hOMIbzopoafDHTEZ1SBo0O5P5lH+NC/C6tdGdJBdTsvAvr6BYDP7SA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789126651;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=TrGx9Z5a4NsQb7TvsQnLGqzqr00ecqCFr3Almp9YHB8=;
 b=g++2V3GU+hc17ZdC0cGB324gHR9dsx7utUMl9mB7rShsE392EyWnS2vQtZIEEWCU63g6
 KggDx+sW9zL/9HOl3WxR4C2ebO5PgOhdupBKHEvoObmUQb0q1XZW7oVNIY1NFNzPD0GuP
 9Jx811DMjoFuVuqkCgs7pQgdPmPBfuXBgz8YXCHXcLl/xh4OR75B3LYeOa+hyp/MgC0Uy
 5fAY7IaTXmc6TP6YDiaQ8LZC3yP/2e7gWhqX9YLaP7ZsXOWoaaaSvUUezCaRusiSKpOEd
 fkHdenqrB6lxX3MnmWDz7cQVdpUso6OWfq1tNNhgaKgeKo8fn+jjJc2PHm6ImYHHwQg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=FsnTquEw; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=FsnTquEw
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EAF75405CE
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 11:37:28 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d37b6so4120145e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 04:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789126647; x=1789731447;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TrGx9Z5a4NsQb7TvsQnLGqzqr00ecqCFr3Almp9YHB8=;
 b=FsnTquEwJdHpkrIBEPiq7AlXAb1BxKuXaqwRnsymKLscZxsCMH5o8r+DrRpLj3Mj76
 a5RxuEEqM5FujZndDZv7ls09MV84dADq1f7bgKiNkl+gG62rtb0uZqGpYKPr/gAQltn1
 57T3O7LTLgVVYrGbhYXrjHEL4ftVh+ptWz76ccOjPDytTP7paFl0g8GeQiPbDTgCciF2
 B7P3xk7AhfZkdAvlnU9FAo9zdDtYYjT//6Bi/ZMZbByovxcWnPtxZwOUVq6IIrzuEBxE
 /YI1qYK3YqdL8f3WvgtENx8bDZudRsTXiIVmKSP1iCpDlsWuFI9OFdnkg7URo7jUn3vl
 zQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789126647; x=1789731447;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TrGx9Z5a4NsQb7TvsQnLGqzqr00ecqCFr3Almp9YHB8=;
 b=swDMwTnJ5/DJjpZriBe1dbTkWuyDfj5E738tId1ohFaJHW+e1xiTVczH51HhZxMh+O
 bC9CZ9nfpBlVXVwyp1Oo9PQdOeYG1Io8x2c6ox+aiTUalQqXfvr9xH/9LtbSca5Vn4WD
 47OyfAoHDpBzlNPMgCuG9FdvbjtFgDWgUZeXtH82+lywSXl5HL4WDYoht68qrwhucViR
 eLdCeux30Z6R3FT9TO8DXNP/6fGAsmV/OgHtuoQPzj3zkVv2fUZJ0YMpssyKVohUvdGY
 3FAMouJEVgrIvXMfRfgaFJC8ZwiTXgsWJWMYY5p27qIXQEkQNGw0lb6fYLcqoHEhEQXk
 gFfw==
X-Gm-Message-State: AFuF++mPg5h6IbBdu/Eo2bpKmqWlmAKSCbBIaSh/SQmJP1q+PrDGMpD2
 1RdcfyBX281w5X31Ece1Gqo/pk6EaGG2EkVvqnrE4hkWCUZxR7fo+MXFl2dntGYaDrA=
X-Gm-Gg: AYBFou0r/WWXuNJVvkgWrYFQKxczO3ToMT/GjLIZJZDHEbW+UdDs9UhVRtIImZpNRh6
 HozD32Cp9Zw5OvO+vSTo3StnPeuCjbGFvtWt3tosM32F7ix1/s7qWga49Or5H3pr4V20koC5yye
 xxPj1lzldqr1hYa9RYAPV7GBV3/X5BEhKE2nQ5H1b8taR6vzl+7S9BW8/LZEHIuaKx8Qic6K7YH
 C+iWnt2F/bgtpWNoYD9Lxab0Ai3O+VwQtBJ7KSisi820z+UDiqKjcZyrsccao3V6dCd5YEiSyhj
 Myv5zHNMaqouOqRGm/svgnH7QZpz31UnUs3InVhHtijh+6Pn1EajhTKLGowkuGqnLGAfily1bAZ
 x5tvYMzh4IZBnU0U/Yq3U7TSTx5NY/LbZuzSQDH3vHuzdbLXQgfwO0532jufSvV9YWjKImhzLWB
 dJOBMh6GHcCbLtsQgv2x4n7idzAtmOwptr0SsVCDrerxwSYokn4Lu3lo+ALvHbziKxUzbhNfnH2
 mFEuLnTgF9CPWOZB0SShxl04q+HEIGXFNfFqgFLYgm6laVZp3sw0vjy05D1iHphQEwVn/5hS4pO
 fy+K3UEMVfhdBdY=
X-Received: by 2002:a05:600c:470a:b0:49c:ee20:e787 with SMTP id
 5b1f17b1804b1-49e61878adamr74174825e9.1.1789126646760; 
 Fri, 11 Sep 2026 04:37:26 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-232-147-181.retail.telecomitalia.it. [95.232.147.181])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb34f353sm5065063f8f.26.2026.09.11.04.37.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 04:37:26 -0700 (PDT)
Date: Fri, 11 Sep 2026 13:37:24 +0200
From: Carlo Caione <ccaione@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Alexey Charkov <alchark@gmail.com>, 
 Johan Jonker <jbx6244@gmail.com>, Richard Genoud <richard.genoud@bootlin.com>, 
 =?utf-8?B?Sm/Do28=?= Marcos Costa <joaomarcos.costa@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 David Lechner <dlechner@baylibre.com>, Julien Stephan <jstephan@baylibre.com>
Subject: Re: [PATCH] spl: mmc: support board-selected raw partitions
Message-ID: <aqPnYlEWC1nDgwL4@macbook.homenet.telecomitalia.it>
References: <20260910-ccaione-upstream-part-dynamic-v1-1-381414ad9a34@baylibre.com>
 <20260910183728.GM1764417@bill-the-cat>
 <aqMXhBA7IX_Qz2RW@macbook.homenet.telecomitalia.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqMXhBA7IX_Qz2RW@macbook.homenet.telecomitalia.it>
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

On Thu, Sep 10, 2026 at 22:50:07 +0100, Carlo Caione wrote:
> On Thu, Sep 10, 2026 at 12:37:28 +0100, Tom Rini wrote:
> > On Thu, Sep 10, 2026 at 07:49:29AM +0200, Carlo Caione wrote:
> > 
> > > Boards may need to select the boot partition using on-device metadata,
> > > such as A/B slot state. The existing partition hook runs before MMC
> > > initialization, so it cannot read that metadata.
> > > 
> > > A separate dynamic-partition mode makes this policy explicit while
> > > preserving fixed-partition selection and explicit requests to load other
> > > firmware.
> 
> [...] 
> > This seems interesting. But, looking at the resulting code, it was
> > already a little bit of a mess for
> > CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION vs
> > CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE and it doesn't make
> > sense I assume to enable both at once, and now a 3rd option. So, can you
> > please think about if any of these would help?
> > - Turn the current two options in to a choice, then see about
> >   simplifying / clarifying the code. Then add your new option, and
> >   hopefully keep the newly gained clarity.
> > - Restructure things so that we can have a __weak function and override
> >   it already, as I imagine the metadata here will end up being fairly
> >   implementation-specific.
> > - Move up the mmc initialization to be earlier.
> 
> Agree. I have an half cooked version of a version that moves the mmc
> init at the beginning. I'll polish it up for V2.

I stand corrected: it turned out that moving up the mmc init opened
a pandora vase, so in V2 I'm pushing toward having a single __weak
function that simplify a bit the things.

Ciao,

--
Carlo Caione
