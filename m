Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CA0606A31D
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 16:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dTmeAYMV;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=lsSOSLcK
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 474D280AA1;
	Tue, 27 Oct 2026 16:27:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s3p_lSwV7AX6; Tue, 27 Oct 2026 16:27:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5BA2080BB7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793118439;
	b=VwwdN953qutqE7i4PLz2UIFMzG4QqxLxi/dtp0cVUA48E/nmgOngo/sXvRyZby0S42rB
	 1YrX8E5hAy6YLYo6JBCmk7xFMdaBGZeYCcRhhuqYI9VHEHq5rlHIjxCP9h838ZcnBiFtB
	 4iAI4wXMg4Ozm+h134UP3K0bZMX8VnCZeeN8J+0dhlhjTzlATDQ6bxRpwNW8CD+1H/vQw
	 erD15oTivs1CnqNWeq4+gcGyEwrV8YhtMVq1A6ZfDn2oQ8ORuYUAEF++IkM0x6hkq66FR
	 /baCJx57WZ2U4IAoJY/6oLd6suzDE/uQwGjfz0Vl9dwKXp1mR7w2NCAdJZQp+NqS0GQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793118439;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=wpW7OFLH6epn7gnl5jcCXzFPT2sxa2yPPWJIAHnEayM=;
	b=Uob7QPsmAdzvliOPH/t/vGF9gM2UvEW1kVude9PpiTmXtxyKuwn25hpKc7uh+xyy9G/4
	 KXXV3mIzyAd5Wa3BxzrcJ4Lp6hpdJ5H2FiIHzlT/YP5Rm7fhvYMBAkg+YNnFGOxapBOjL
	 EoL2xOJIHoguMw8PpDSAvnvFTYkj4S/xEKoIr0YFWZbQG45pamGOYQSQJFOF456rpoQAr
	 7TwQCisw8QnWCxRxz3zEY/uRZhnllSvJYZd0rbLtVfLruNH+fvHEfTOtPs1IF39C6Vxtx
	 gdXyPKTkVl0H834dPKu4IBUojnL/4FjgxgQZ/uIXkRzQB+PD2OFtfhoVRkMIMmTz42g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793118439;
	bh=wpW7OFLH6epn7gnl5jcCXzFPT2sxa2yPPWJIAHnEayM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dTmeAYMVi3uyehiboztIGFi7Zu/W7Zll/8ZB83UjCvDokh1Qyw6EStB4i3YUHOyFu
	 XJ1SqUM5SKMoIDf99u6WcqkG0LVBCiVy329g/Z1V++eARN6W8ruLYdXRytd/6Ucg1E
	 mhedMSdidhvp6FauEQiUyh3h7h0wFhfyBvpGehw82WYR4CdJ7Zy2bysevp1i45c/BZ
	 rSDgYyCHA07DPcj+tqQQn4S+HyPUu6g6lJFlaGfDOjeo7vKksTEb51f8Udy1OVER8x
	 mazkUbE1sZxovL7u6gy/vHkffzNVNzQZ6VjUpzZ+9UHd/1ge72hokmoitB8dlfzDOb
	 FAOMrABX5Oigw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5BA2080BB7;
	Tue, 27 Oct 2026 16:27:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3AE252F5
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 16:27:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2C69D40735
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 16:27:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 57fgIS4YQNZr for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 16:27:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 40A454061E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793118437;
 b=iJOOvDvvPLNJIY+yR+VcgUyl0JyzT+X+HfrLocnOE3Gm0TrbjT/XQbuuTgqyDiNpXrQp
 pnrAKtuGEFZJmg2MNtrCpWaagYvLGOmxx3NpmhKJKEKzOAI1JkP/TWXmlKuyKPfGqIOmd
 Jrr4Y2yWu+iUUkM23kRFfCoq2ziF6MgDK7FNgJkhsikua+OeEiPLC3JrqQc+jsR+tMOgc
 AfJIgxpHMNbEwJAuZWz2TKtnVCOxXpRmHpmHSKteRFfVUL3qBBXzX4E7xbnI5X5pwJVYs
 h10Wqt6fuMWjyyygVX/I/e8f/y/YsggdzD5rFZWy8X3WhGwnBMUS8Bf6VLMPGE2LUVg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793118437;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=wpW7OFLH6epn7gnl5jcCXzFPT2sxa2yPPWJIAHnEayM=;
 b=IpYoULO2hDH96TdcwzRscFQBo6t/BT2ThTLBVCP/ubU5+JMX+uFs7ZEbE1Af5aQoQvxu
 3x9ywKRxJgNf9HwBn10uXMik+RDC6UWKwzlXc3pfhJxPNChgYDtDqWqv+wu9Tx9IfNyDl
 /p75BbOCsLDGdGjgAjeMy7rvudIkYId/irHFo+Xwld55wECaReP1LhCmsLL1qxpeegNiZ
 eKjjiEoJI9CxPUt6doNgxjpFxrSo/cAQfATUDzYI+IJLIio/rBqLGqw63Gqb4BlaklY83
 9urEePgE1qRSgHU0x/14TPi6aM6FWATpfwJAZng6MTdEb1LHYQz7IQOgi5TCs70f1PA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=lsSOSLcK; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=lsSOSLcK
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 40A454061E
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 16:27:16 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-81b54d0cb17so31902a34.1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 09:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793118435; x=1793723235;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wpW7OFLH6epn7gnl5jcCXzFPT2sxa2yPPWJIAHnEayM=;
 b=lsSOSLcKEsyIJDG6ru4pyUyQx//8YML50ZbeOi7it2mCdBYqLIQrGuO9AI8vmi9WZz
 NbVPd+0a6gZNLLJ8H8v1dm0IJayOb3jGExMuRvZ3lI7HiolsibfIjGUsK19Yy+CB7H5m
 8CF61X/VsVcg6ltwNipGoZo2L/2U2Qu1rXSaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793118435; x=1793723235;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wpW7OFLH6epn7gnl5jcCXzFPT2sxa2yPPWJIAHnEayM=;
 b=lgOe2Dt92izKy1hueuVXhhFKbwLBBkH2OC9OpQyPijqg0WHC9HOXHTJqA185B/RzZI
 LiokJu//Kc45yEFu9tv+iGsMlX74//W2l46egf63RD2UYAKGX4c6URBtNZjspH8r6Z0G
 URXgDRmflwUmGAxQRsSChgKwOtIYyEhBpCCxQ4RY4lyCfFio6CDwhq3YGRC2Ks+Enw1z
 /npckmmxwomRu+bdlRc7922nRM1Yj3cdPXiLUcEJFOCebBnxbr2HklmOieqRCvBW+qej
 NkC7/EUCEfd+UDcH+Sj5eisPt8LDRF8cOhlibk7wEU3dyJTdpHLz3qQ8KRrWiQf8LbF4
 1/OA==
X-Gm-Message-State: AFq9FYLqeNoKtW4EIZyel1uU+XTfpXwZBpVDRUNQKbCtn9pFNXzhUCm8
 6ZqOBiy7QSdIMPZFkGfNJopZsXFaLpBItI8ANOPpuHYXQU1VAcc/en8+Mi/e8PmsDkw=
X-Gm-Gg: AYBFou11abbiVbNP3O5Bhytr6a0oQrjVkrnwVehHkAsHT7I0nIklOrXu/UY3LAEfqUR
 oiCp64ozZqX46C2szRXj3TnQyiJ68m8iNdBWTNXwbFBNuvpNf0JpuJStIBIpkCyOVt7vfEs0C6n
 GSgJ269L8FHfMTv8EK1yT/VT88C5Iqtt3BZx/ADegORZ/pl6AryVDMa0PWgT5JFyGBbX8wED/52
 7q7cYCrGnVbM7EEksgi/ilFkZ2ggHY/VHVTNLlrG3uUIJyEAhjjeJmj8BrQWLXrI4cacVpve6a1
 44mySXsxrHZpKHZCgsozGmglqFvdozCaWDWKLkEOZMJYKGY7pjksTHk9nbXWh8kVehTvVQ9li/a
 8NBrzPZie01auIV5qV73ASsymgrRduVT4AvPGz+LBE+U/Xm6j41qla4fkxqO6+Hvxa0aj7TNwR0
 CxeLBUvdeteOLbXUv2OujV+loiBEIzIue0Ww0z16szD8VsmQE+Qn/BTUPpqKhPynhrjtE8pZiiC
 tlpfzHAzpy1hSApL8Nka5NKbJRSQCSmqdVQfj1HumHdG9q92odRetabetPrtu/lDQQXTcfyttAN
 nIZj2sjjKzicLR4/1KOaSCkvKp9pI8xshzWy7Hf4eDGlP9o=
X-Received: by 2002:a05:6830:6810:b0:80c:d30f:97e with SMTP id
 46e09a7af769-850ff872d54mr8637982a34.31.1793118434918; 
 Tue, 27 Oct 2026 09:27:14 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-850fb0749cfsm12065363a34.9.2026.10.27.09.27.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 09:27:14 -0700 (PDT)
Date: Tue, 27 Oct 2026 10:27:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 0/9] rockchip: Remove unneeded syscon driver for RK35xx
Message-ID: <20261027162712.GD2177077@bill-the-cat>
References: <20260804105721.2402406-1-jonas@kwiboo.se>
 <CAFLszTjBiTtKmjgknvXGFBrphh6kpBzRg8iroWjFQ0EDvuXTyQ@mail.gmail.com>
 <c00fd65c-338a-428f-bf4e-eb28e463d914@kwiboo.se>
 <CAFLszTjKMRjF7hmEt6_bbnsRpi9Q=NHidRQC8zv4ToUEpqBarA@mail.gmail.com>
 <582f30f6-7d5f-4dd5-a8c6-60d027806786@0leil.net>
 <CAFLszTj=yHHYYojiX7TGAiFZun7qWsu7zO6awfLdWwYF8HkQmg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="chBFc1ebawKGxS+Q"
Content-Disposition: inline
In-Reply-To: <CAFLszTj=yHHYYojiX7TGAiFZun7qWsu7zO6awfLdWwYF8HkQmg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--chBFc1ebawKGxS+Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Big trim of the CC list]

On Tue, Oct 27, 2026 at 09:06:00AM +0000, Simon Glass wrote:
> Hi Quentin,
>=20
> On Thu, 8 Oct 2026 at 23:53, Quentin Schulz <u-boot@0leil.net> wrote:
> >
> > Hi Simon,
> >
> > On 8/7/26 9:46 PM, Simon Glass wrote:
> > > Hi Jonas,
> > >
> > > On Tue, 4 Aug 2026 at 13:57, Jonas Karlman <jonas@kwiboo.se> wrote:
> > >>
> > >> Hi Simon,
> > >>
> > >> On 8/4/2026 9:19 PM, Simon Glass wrote:
> > >>> Hi Jonas,
> > >>>
> > >>> On Tue, 4 Aug 2026 at 04:57, Jonas Karlman <jonas@kwiboo.se> wrote:
> > >>>>
> > >>>> This series takes the initial steps required to try and remove use=
 of
> > >>>> syscon_get_first_range() or syscon_get_regmap_by_driver_data() to =
get
> > >>>> GRF base addresses at runtime for the Rockchip platform.
> > >>>>
> > >>>> The GRF base addresses are fixed and known at compile time, yet dr=
ivers
> > >>>> keep trying to resolve them at runtime delaying some operations by
> > >>>> several ms.
> > >>>
> > >>> I suppose all addresses are known at compile-time, if you have a
> > >>> single device tree. I have always hoped that we might end up with a
> > >>> generic U-Boot for rockchip.
> > >>
> > >> I do not understand how removing these unneeded syscon drivers and
> > >> helpers would stop such goals or make that any harder. From my point=
 of
> > >> view, they are currently making such things harder and only adds ext=
ra
> > >> code, runtime and energy waste. E.g. around 227 ms was wasted resolv=
ing
> > >> fixed known base addresses for RK3399 last time I measured it, see [=
1].
> > >>
> > >> Most drivers or any SoC specific code is already identified using a
> > >> compatible that is SoC specific, i.e. the RAM or CLK drivers are mat=
ched
> > >> using a SoC specific compatible and seeing how all GRF variants are
> > >> unique there will always need to be SoC specific code to handle the =
GRFs
> > >> base address and reg offsets.
> > >>
> > >> And for drivers that are more dynamic in nature the DT typically hav=
e a
> > >> phandle to the GRF syscon node anyway, so getting it from the phandle
> > >> will be a better option and closer matches how Linux handles similar
> > >> references.
> > >>
> > >> The biggest current blocker for a more generic U-Boot proper on Rock=
chip
> > >> platform is rockchip_get_cru() and how it currently makes it impossi=
ble
> > >> to support multiple SoCs in one build due to how it is used in the
> > >> sysreset driver. Fortunately, I have a pending series that also clea=
ns
> > >> up the unneeded rockchip_get_cru/clk() related helpers.
> > >>
> > >>>
> > >>> I wonder if there is another way to do this, perhaps reading the
> > >>> address once and caching it?
> > >>
> > >> I really do not see the need for that; it would only make things more
> > >> complex than it really needs to be. We should use constants where
> > >> appropriate, e.g. soc specific drivers/code and use generic phandle
> > >> lookups elsewhere.
> > >>
> > >> At least that is my end goal with this and pending follow-up series.
> > >
> > > Long delay while I took some time to look at this area in detail.
> > >
> > > Pre-relocation is an area which I sort-of glossed over with the driver
> > > model implementation. There was talk about keeping the pre-relocation
> > > devices around rather than recreating them. We also looked at
> > > providing post-relocation devices access to the pre-relocation info.
> > > Over the years we have had discussions about having 'simple' versions
> > > of drivers (that don't go through driver model and perhaps don't use
> > > device tree) but no one has made the effort to implement this.
> > >
> > > Anyway, after a few days of hacking I've come up with some
> > > improvements to the existing code, at the cost of about 500 bytes of
> > > size increase. It works by using slightly better algorithms for four
> > > key functions - fdt_parent_offset(), __of_translate_address(),
> > > ofnode_pre_reloc() and lists_bind_fdt(). The result is saving on
> > > firefly-rk3399 of 230ms, about what you are getting. Note that I have
> > > made no attempt to enable the relevant options in TPL/SPL (it only
> > > saves another 13ms), so your work is mostly complimentary.
> > >
> > > The key difference is that this should help all boards, not just
> > > Rockchip, plus it still uses DT for everything. Tom doesn't want me to
> > > send patches at present but I did write up a post about it as a way of
> > > providing the comparison. [2]
> > >
> >
> > Please refrain from pointing contributors to patches that are
> > written/assisted by AI/LLMs as those aren't currently welcome in the
> > project.
>=20
> Do you have any update on the VBE series I sent? [3] It was written
> before the AI era. I believe it was originally sent 18 months ago. It
> is the final thing to get VBE running on a real board in mainline.

Your use of AI is not the reason your patches haven't been welcome.

--=20
Tom

--chBFc1ebawKGxS+Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauDQ4AAKCRAr4qD1Cr/k
CjHJAQCSUCn3JIV3Rck+WkuQRlN/Hw7sDRQqw5KUFXbAud/BWQD/WoKNK8xgtXE7
xLM5uzc4ORtGXinwuGYRwV0KwovENgs=
=HpnL
-----END PGP SIGNATURE-----

--chBFc1ebawKGxS+Q--
