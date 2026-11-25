Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2023606A332
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 18:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xYOcrYRy;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mqt+b86l
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1FB924065B;
	Wed, 25 Nov 2026 18:13:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 434jezNEqMme; Wed, 25 Nov 2026 18:13:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 646BA40648
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795630418;
	b=mh5gPSAfg/ikfH/H6EPmGq0NqhVVYLcdxPT/csi2De+u0VR5+ty0qC/77ZivfFdoZ3yU
	 6jMk0xqPgNNjrRIfYpXLpfyhjZiQ4VEZDhMddh64O7AGSXyM9ZGYjemGzeqncRa14ZbVT
	 +xmd0asn/sRgyXEcVLdVl90UNMK+sgEuF7BIFjUKzC5DPGNpAPagjnBxJXNi3YcLrcWlj
	 5KQ4w8yWK28VuCTv5qLVP2skxm1oiUVfiWigqFCqO+32daHcA3OryJr2IBrvQHbNl4x8C
	 O7YrhwMaJl3DzVhAYcSWFw4BEPwtmlHFvFYY7M65Tzz6WmO59WpZup9H7oDM2X+9kUQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795630418;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wUAzRNwrdGn1GCQ4g8AY3oDvjRP/h67LoF8QqZeBTig=;
	b=FfV2+PJSrTVlAGkiYa0N9yyAb+bQ+tPQA7m5e48SnjPZFWmnyt9aCNpXJPnN3Vs1R811
	 eo+H6XOgMTlnOSSxWjyH1N5epZ6enZlGmewdxc8+W0w0DnXDu5BtvJSvR6YVtfLJGugVu
	 kbmTDvYJp3wwQ/GFsxoC41eJ2T8FDAvZQS/l7o/KClcodxYcvqfmp8RLB73lX2ZJlUne1
	 i8RU3sE01khDZY8vXCGZcw8v2JYScMq1cI7iRn1iEZHDN04NseGaBSvh4mqzJYWOoXl0g
	 0ws+wgkcU9LOBRSqnhjNa33l3cOytYs+7A6wnqCcG/KEjQXoovrg2ICjPLH4mSP60kQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mqt+b86l;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795630418;
	bh=wUAzRNwrdGn1GCQ4g8AY3oDvjRP/h67LoF8QqZeBTig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xYOcrYRyebH0bdZNEEXuq51QxhXwT6TDeWHpiWBfnzwrU0UJvvRtSy3HaP3IhO4KO
	 NbDc5wOdQBH8+GIPcIVJkONRS76u3l6ZBnHV9s/oavjoMBP+51JsTgUC3rtOli0C5B
	 CWAWd1Anp/p64BCqWFM8+NSE8lD6wE0P7xzn9dof3MBoqlMpfeijn/0VEvSFZxak8N
	 vn+qUrwkICVUbSXRin0p4bqFXhOGH/rKksGb/sJx/XXrNJyhwXohMctE7LIk6y6qkx
	 GoUQjlyFjwoXResMKj+vgVjqfk5N1/SVBk5cdwYiS4x3neW7ODJekrU2wZxSgg/A1L
	 +cPtIMfJ/OGJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 646BA40648;
	Wed, 25 Nov 2026 18:13:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3C5D7371
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 17:34:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2DF004054A
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 17:34:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EO4Wg8PqJXfT for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 17:34:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3B8A54053C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::532"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=Mqt+b86l
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3B8A54053C
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 17:34:32 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6ba380cd8dbso8240968a12.3
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 09:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795628071; x=1796232871;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wUAzRNwrdGn1GCQ4g8AY3oDvjRP/h67LoF8QqZeBTig=;
 b=Mqt+b86lwFjpYZ8Ss6XEwROc/7sNZkD6XJMqjJIfHyuHmM9NE5o7zTqRQ3L71zEQPL
 +KdRTyu1VbGOLnhXGJ8xRBYElsNcvBNEOUb3ZUF601TWK4EFMsr/4ZBIlN3Tlq9R8z2d
 kXzZjOHqKiIfSow7kPrI+76jWhnMr+mPxk01QxHcJiY+Fr4Kvu5hVdNZBcIuBfoMI0gh
 Om7K04jf2DgM2U5ZUlV78MXnV4ITC8H0AgM2xRmkTQGt+DG4dS3bNqbcrN+6vVtDClHI
 LcaZkLA2dweu5yzK35W3HG+Rbm8ZIAiqoFtWLuj1hXfRiNKrnbImUwq0c1tMVe7Y6MKQ
 gI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795628071; x=1796232871;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wUAzRNwrdGn1GCQ4g8AY3oDvjRP/h67LoF8QqZeBTig=;
 b=P2UFuuorWlYeH5+NH09bznOiFhwvIMUx9q8tqS85CKLxgopWNTtNAzLrnD9vHfsfCb
 /CfqoJbYsWQOgScPA5PQRmtB05M4h4djRJQupZL0b8R38pbLiWur3ucDr2p0I5iZ3QFQ
 Fd2aD17dMmvZfrxF/pU4nG5fZv/XCKzUOnciyAbvriolCNzzmXAYIF9EsvUa+qz1IVEX
 joIeeA8QwqaOHqHPNv30DiOTyTfRW2nI36EOMyhUJQZvPAodmZxWIP23l5R/9d4G9e+p
 G9XwIY9uyYlcF/5bJwFEgDzX3Dy+vHJmqk5ZSs94KDxhemJoHzI4kuDn+Py2yPj5dUn1
 7aIw==
X-Forwarded-Encrypted: i=1;
 AL+hErHn5A9jqNcUtYKwnY54BcxvitoB3dMtv6g4fX2DGXg063aTqIJk+i968gpsr0NBUpy78VmDuyg=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9kVGGzc+KHy2iFx2zwkCCpXCdnYLCuhaIPbHhKpl3eGUjvdXKC
 oqwAt8hlTrCPCqri+YDOggfZyzfbjVPA1RXpj+w8SiapH2ASWc0OI/oP
X-Gm-Gg: AZFdTZd6Pk7605zIEG8P8+9rIN4w5XgRSo+CzGzmTe1oJozKv/RhG97cGbOtmYeqVUv
 yuE7fo1N9Ravi2s3swM9017MhkPXBgRhXECar3v0FwUEG9znhRUYuXXxui6//JW9k97l8be3gqH
 MqXhuxCICSur/7AhdtUeRXS0tOIL32NLCMqKFrf5SmQXEzl43+o0ewxt4iMV6leDmrXmr+EszaJ
 9SLuEsTR4YFyHGNV5pusk+OXWS/HYUADIwwM890qkFxjVoT9kVEvopvu+NvdDO/BYsKq0A3DF8w
 scGPJQ+JKfDJnIzFnzXmCPgs3vku8fnuCA/hcbW98X0dFLS0YCJUrk4SN4duOKfhvlUW0TBdT1l
 pTujsj8TuDifoZH0ZHGpO79lhSMNJicOm6JAf9SZrwbDhyoECccTTkn8m9Kg1OeqQyxU6rvNLVS
 u7ufzqvXGleO+1igvGCIyIWyxB76yKA9QSiB4FoOHj7McqOSfK/RR/E06LBGz6X0Uj59Ocs5nNy
 2uUt3z1UmIJjTosdkuPejydmV11H9zIpr06IBvoNBBC4MJcqQ2Lrpa2PLtXHlMr1U+ECyE6jQwJ
 hiqdUzI=
X-Received: by 2002:aa7:d0d0:0:b0:6ba:56e9:2980 with SMTP id
 4fb4d7f45d1cf-6ba56e92a4amr8582069a12.23.1795628070574; 
 Wed, 25 Nov 2026 09:34:30 -0800 (PST)
Received: from eichest-laptop ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba37109c58sm8425332a12.33.2026.11.25.09.34.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 09:34:30 -0800 (PST)
Date: Wed, 25 Nov 2026 18:34:28 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 sbabic@nabladev.com, festevam@gmail.com, uboot-imx@nxp.com,
 francesco.dolcini@toradex.com, lukma@nabladev.com,
 dlechner@baylibre.com, msp@baylibre.com,
 stefan.eichenberger@toradex.com, Max.Merchel@ew.tq-group.com,
 nora.schiffer@ew.tq-group.com, primoz.fiser@norik.com,
 jbx6244@gmail.com, aford173@gmail.com,
 cniedermaier@dh-electronics.com, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v1 4/7] clk: imx: imx6ul: add the enet clock tree
Message-ID: <awccJPMFok5udt7D@eichest-laptop>
References: <20261120111037.110741-5-eichest@gmail.com>
 <20261125095652.28340-1-peng.fan@oss.nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125095652.28340-1-peng.fan@oss.nxp.com>
X-Mailman-Approved-At: Wed, 25 Nov 2026 18:13:36 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Peng,

On Wed, Nov 25, 2026 at 05:56:51PM +0800, Peng Fan (OSS) wrote:
> >  
> > @@ -276,6 +331,17 @@ static int imx6ul_clk_probe(struct udevice *dev)
> >  
> >  	clk_set_parent(clk, clk1);
> >  
> > +	/* Take PLL6 out of bypass, the ENET reference clocks need 500 MHz */
> > +	clk_get_by_id(IMX6UL_PLL6_BYPASS, &clk);
> > +	clk_get_by_id(IMX6UL_CLK_PLL6, &clk1);
> > +
> > +	clk_set_parent(clk, clk1);
> > +
> > +	clk_get_by_id(IMX6UL_CLK_ENET_REF, &clk);
> > +	clk_set_rate(clk, 50000000);
> > +	clk_get_by_id(IMX6UL_CLK_ENET2_REF, &clk);
> > +	clk_set_rate(clk, 50000000);
> 
> Could we use assigned-clock-rates/parents for these?

Yes it would be possible to use assigned-clock-rates/parents, but I
think it is better to set the ENET reference clocks to 50 MHz in the
driver.

The Linux driver is also setting the parents and the rate in the driver,
that's why it is missing in the imx6ul.dtsi file. That would mean we
have to add a -u-boot.dtsi for every board where we want to have the
ENET reference clocks set to 50 MHz which is probably the case for all
boards.

We already set the parent for PLL_PFD2 in the same way, so it's at least
not completely inconsistent.

For me not having to add a -u-boot.dtsi for every board is be a big
advantage over using assigned-clock-rates/parents. Let me know if you
think otherwise.

Regards,
Stefan
