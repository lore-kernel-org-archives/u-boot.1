Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1689BC88E53
	for <u-boot@archiver.kernel.org>; Sat, 12 Sep 2026 14:41:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED3E780E71;
	Sat, 12 Sep 2026 14:41:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g06TYjT_bCXv; Sat, 12 Sep 2026 14:41:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3A81D80E6E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789224115;
	b=ZjduZUuJ33Ah90AysNm71ZwM0bf9jMkzLHdbu15Pxvwky5VMWufF8iZu5821W8bYGzVd
	 PPrsi+gKrjPUf13SCPR1yzAZL/glxEzqDCYq/zwfmBInprrKbPbDlvgRA23d5h1RFj1ba
	 HPtgDB2i1pbF6DOfvhB4WgHNqwaNtjmg2JGX1ZJlIynmiAZMs3HaZdZf3I+Me2itpQN3a
	 N7aEcKsFh8mPGuAYLWCNl6s9r3+7lbIqnNI0IvWNN7LhPkARi9U/f5KbpsGv7PynVTrIT
	 zZdf/u6jbupdP7qt/tOg++isr1J2PKABZsrPepS5wbPxwgNyigTFc01QF3nP1Nis44g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789224115;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=3JcKTCGuFB/9R1ZPKUI+NuQilnYARJgOTqEPDVfMN50=;
	b=XOt5pePp6rPk0BWYMvjDJDoiguqS3KXT95sQRwAxW5kAX+CyTehDKNVHvU4Khz+Iz+e1
	 9/c5J+gLaJ6zlvVSlpGoyUkB3tSqf9jU45rRJeGjWixzAG8dBYVOt0DUDzBy0SijPaJA5
	 4mEIjBc63fICIWEAF9TlMELvAH/zlt2P9Zone/QHl2HCdIJU37UkfXPC+XF7W8LB89rh3
	 U+JFDWfesZTcHjVIgS/jRIU9GR4vy0iDoLpP9I66DF/+o92QWkN58mpOk0XmT3ZftOcdR
	 5TDDb/QuSzArvtDQUoKAFi4S6+gZXi58jZ1e62TJT22c3A65HJyF3v0rXWTk7OZ09Ng==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=nwVxjWRN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789224115;
	bh=3JcKTCGuFB/9R1ZPKUI+NuQilnYARJgOTqEPDVfMN50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X1PDzAJ1Vlmw1OolDof1P7Ozy5AU32quVuObgELvMlMd2rc/XIcPWjPTz8PG6zJbY
	 aYk4vcf02mHRJK4A8/ORkJx6+eWwm+wpywR58tCJ06MrMP1abcEnloR/ceoJDxhQz0
	 jK6okjcGSbwLfuwOe9sMqtMo4bwModwqDCgDOs7iGHLSBahP8+OnMalq3dedmnOuUT
	 dnaegxOMXPNVyL+ouD6S2wx8D7Fk8le78SSM7szR6vTuzSnRAjtdtGmZ/rubXTy8rN
	 0QIt75odJ/OU3tmhDfLqKyH6ow0BUt2qbEUmdm2Ju9CgUkNMZtt8H6OsuG6TeaHoyL
	 LFaVOu6HQuzWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A81D80E6E;
	Sat, 12 Sep 2026 14:41:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 05499EB
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 14:41:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EA92680E6E
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 14:41:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hOyE6XiN66DD for <u-boot@lists.u-boot-project.org>;
 Sat, 12 Sep 2026 14:41:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 346A680DE1
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789224113;
 b=MDdgtYdzw5YO1XvJ1idx89ip1is7p6NiiQZpAX4jsPKhjOkYbxBd6I9RKATEX8zpxX5S
 uJYjo5QmODQvzze6GnChFtWuHLfKKTprN0nYetFTfXe7mqgRjzEQp6d4Y4rgNU9vQKljZ
 ZupH3h8LcbjPptjRXaUzoHHzNk20afGqUAizecdtOu+p69EEsvGDgSE1bsKfegUDBS4Wr
 CHYOmob1N0kkMYKo3SMoGNlpDZ3FbpBwUAN1HeqmJ0/Xx34+uRjrcChAIlVkOTYElM7Vq
 4f31lq1qpKlHf456b0TwSMEfQKhH1mZPwMtcm6ETxXEGPLx9G/pzJUNkWbT/MoXZetQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789224113;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=3JcKTCGuFB/9R1ZPKUI+NuQilnYARJgOTqEPDVfMN50=;
 b=SETsJDBBmJVcDXF1EP5zLCH8Wudz5XbbaDDSS8fdCdtAMmEBM079SuIq53nh8mN24Jrl
 pn0ylw6ba81+OOrtQttStCa5D1sL3HSVkBfCAgLfOeIFuPzlhMnnezyI4Gy4osdWz12HD
 cn7Zdh2ouicedqZmNrGfRRvNu0bN1JbyKZgP4SVrDekEGJoymGgNZtW7XqsaqFBs5VuHl
 oqMXCxU6ZkcpHCZMJwTLVG19HnITFXUmcOY0zCTQK7++XVFm14qLkMSHFlnLGFXcwgk8Y
 Qurb6Sd/7fGafeun3W+/d0TKRjnz9ZhM7hyPTKc84k8hvWnxyw0E/AXezoSJ5tMyDNg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=nwVxjWRN; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::11; helo=mail-oi2-x11.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=nwVxjWRN
Received: from mail-oi2-x11.google.com (mail-oi2-x11.google.com
 [IPv6:2607:f8b0:4864:32::11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 346A680DE1
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 14:41:52 +0000 (UTC)
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4c54eed93e4so79625b6e.3
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 07:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789224111; x=1789828911;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3JcKTCGuFB/9R1ZPKUI+NuQilnYARJgOTqEPDVfMN50=;
 b=nwVxjWRNl3F/xl4D32AWPS5y4NcZl3LpkF8Atvi0m/QZbIZbxQO27fyTh8h4vztu1o
 IhcrEr779uPAVe0hiGV6oLRmkvb0V92XdYPLsAqEGUfzhuFy4ojaUjzMlvrv4prc9jgG
 0i+RBU7M2i+4ndftKxOcU2xQ+y3Zsa8wsk/4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789224111; x=1789828911;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3JcKTCGuFB/9R1ZPKUI+NuQilnYARJgOTqEPDVfMN50=;
 b=XAoWodiezh7KaUPvFg6bJ2ki6+HXe454FRg8LoygSH8UMHA760chqgj5WaK9wvaAQI
 GgnG+c7mM/ZowoxfylZr8xyyMxXQ3w062dtm6MLCOAq0layfK8Wyqg7XpfpSHIdSfNpp
 okGI9nCKMUfC624hoMF8+vZyr56DEinUt/dipk6G6k0A+tlm2lRuWd0pa32KDjNh7dsG
 005BPvmDlz6PTfNgYdqeRXtntl0jF5CipTsCKyZgzLqFsk7HuDJ2UNQDye15mFT68vjF
 of0XoGaESe0FWIIJHGzGZ5cb328POLMeoK2DoGF0BUOejnSnaRkdRZLFW7zy38Zg4yaG
 3Y6Q==
X-Gm-Message-State: AFuF++nwfdvF2Jo3KvN9qom/dFKNHchPqeYhgJhw1aAkKNEBKfo1g/+X
 xygJ2dvkkg9Th0l4QZTLWwA5anmibxEP5R1Q5++Ky9TiCkrV4RMKBbXOingCWm5Iv4o=
X-Gm-Gg: AYBFou26/D6zlm+/G5CJrr/AAq/ElpVoGA4eMiTLYZUIWyp902IKC5kH7rMA827X/Tu
 O1FZwanTnj2zqC+C/xxxRpw0gAz2mt3QaFYXO2nKCi3Y7whTQ/AuJHGl02NIpBKwwVLF0FOB/Qm
 /sSKLXTauyzKJzsZ71LzOUFj3osDj30MZfsqRfwhHC/cv0YX9yiU2WgeXoG96TleA97zB+lB39Z
 6wgKMCGFCWuGy2QqaNly4Ry7G0ar7FwDjt7fk+PCUXFId/RtryBzkxflPAwP08DhlrrMRdhKbBv
 08qfpqklRQ7OJuq0RmadQE0HZuxplAJZYg9sxLfZUGMBRfMJo6kOsQ4IYFe+LuvtAJPpuGDhg0p
 iodnggPeZeTnAC8VFIetJ/Q0E9wu2fBwG09TGF4b67NdLWgrN5VYndBwP7fjvIAAxkgha2Mq9ZN
 s4f+2McdJGsWwLZa/5dGzIHTduyKlbnwx19PfxHu1UjzBDt4NfNJTckQOlx4ZDu93DUxpvEAWbe
 4Pqr0QJd2CnNwzfQD4k+Qw7MpUZDf6/J5PtEKwKHrFq45iZcGszRfsNM3lNLtrkZEjeTtHjDtUh
 zJExj+DPqkKfj9UNkqiI
X-Received: by 2002:a05:6808:4f27:b0:4b9:a88b:888e with SMTP id
 5614622812f47-4c4aa5f002emr2460944b6e.36.1789224111533; 
 Sat, 12 Sep 2026 07:41:51 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4c330da5ad4sm5343352b6e.3.2026.09.12.07.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 07:41:50 -0700 (PDT)
Date: Sat, 12 Sep 2026 08:41:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Carlo Caione <ccaione@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Alexey Charkov <alchark@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 =?iso-8859-1?Q?Jo=E3o?= Marcos Costa <joaomarcos.costa@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 David Lechner <dlechner@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2 2/2] spl: mmc: support dynamic selection in raw
 partition mode
Message-ID: <20260912144147.GW1764417@bill-the-cat>
References: <20260911-ccaione-upstream-part-dynamic-v2-0-295fefc9a3c4@baylibre.com>
 <20260911-ccaione-upstream-part-dynamic-v2-2-295fefc9a3c4@baylibre.com>
 <20260911174122.GS1764417@bill-the-cat> <aqUtjQx0haoqjaNq@macbook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="svL/ZYUFtGF2kTek"
Content-Disposition: inline
In-Reply-To: <aqUtjQx0haoqjaNq@macbook>
X-Clacks-Overhead: GNU Terry Pratchett
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


--svL/ZYUFtGF2kTek
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 12:51:42PM +0200, Carlo Caione wrote:
> On Fri, Sep 11, 2026 at 11:41:22 +0100, Tom Rini wrote:
> > On Fri, Sep 11, 2026 at 02:05:59PM +0200, Carlo Caione wrote:
>=20
> [...]=20
> > This is better than v1. Did you look in to my suggestion about turning
> > this in to a choice between hard-coded number, hard-coded type and this
> > new dynamic option? I do wonder if that would let us get rid of a lot of
> > the if/else nesting we have in these functions. Thanks!
>=20
> I'll try but I do not promise anything :) The problem is that it is VERY
> easy to break things when touching this code and relatek Kconfigs so I'm
> basically tiptoeing around it for now, but let me try.

It is tricky, thanks for trying.

--=20
Tom

--svL/ZYUFtGF2kTek
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaqVkpwAKCRAr4qD1Cr/k
CvQ4AP0Z5ntbo6Dcgf4P564JS+xGu98Zjtd6AmDfKPPFKR6GYQEAuhUloQNyzbXX
zzH3dwVKu1msxewKNtuBsizkq3Foswg=
=dwmD
-----END PGP SIGNATURE-----

--svL/ZYUFtGF2kTek--
