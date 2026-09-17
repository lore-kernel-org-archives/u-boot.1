Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A052C982D0
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 19:52:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC2F760B2C;
	Thu, 17 Sep 2026 19:52:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0zfNzUPhxOWe; Thu, 17 Sep 2026 19:52:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2CCD760859
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789674760;
	b=UxwjH9uLb/ItlFO9CR0/4p83LoWB3F0Od7+kZsJt6flImM6PBQjbLtyVnIUI36X1+4UH
	 xPdkE9206RMW5Krq75iidfVgs5RvvPnXwq1nvJEaZaR/IbLWeV+P90B0AF27VwaFUUfRG
	 /jRf9alhWdmZ7nwN48OX/9R6FktjxzPLR/RxVyiY+qRNlnAhyRrw1vgCx04jUmYY5TCaw
	 77TQqFYBSqxpnSMGcZ/i7DP/j0eI+9hqgrXbRZiYoV2hDx51w/2D2Xk1Z7ifULdD5N4Ln
	 q7YRQHO+mGMETn8HEXmD1/clWBrW89VR3z1+3DnkpPkef/2k2j+m2ECGhXEc28fdWKQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789674760;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=/YXbxztHpzwiDObw5rFociPByp8fqGJQX+HlEr7NyDI=;
	b=f/vVzgboq0GuU5IfRNiy2AFTa9XIXl0Z4h9iIFpWQMa9GKpLFX5sbjixO8iluXke0n14
	 A91M5rm7VZFkVbD7ZOx4rPnrxDuFhKWw8dUGC1JIIVXDaIUD/oQD2qPbakrTj/WeaN4ed
	 vR+vGRdFV3smxt+pYiR1cHu5ZCMKrdE8ZVHybuv/Tn7UnTXueQqYSVCBcMbkwey+rEPM7
	 K1nbCMLzUDtdZmzl6Fz5Hi1HIF+ouIHLd6Rt93ALVcvTFLh8ioXK/qscHC17aJC1M9nnR
	 YLL2BZv+xhX/bPL45iICwAyp2KdRTYEBWhRkvnHd6J9Rznjg8mwe3ThBln+y1iJWR5Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789674760;
	bh=/YXbxztHpzwiDObw5rFociPByp8fqGJQX+HlEr7NyDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Lwh7qLV4mNCjBnsyQ624UkYOICFv2aB3frjbyTS/F6VXje2SXz8Q3REO1coIJ4fOc
	 ZNVJThWzg5JMTk9auWQ6EVTquz1tprYWy58/ILBGAWH3ER4LFfSwK9bfwn268boSq8
	 j1sIGoy37+4/lod+lgaKZAdtfRzGys3+K+hWtkXqAN4bBodzpfpxNVvpwqOEPh/XVb
	 7SnMlgfOA8v6ZN0PdlbXKjOx+sCGiskJrOE9OfvKvyJ5g1vHhdU2hk9/jE7UCX2s/y
	 JYDg3CkOO8UvfP2xZelRjFTHsnQCvnvDY2CPCluP3U8mT+W6E2yJt0AHL2Hgj1CfqD
	 RCaUKRxkzXJtA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2CCD760859;
	Thu, 17 Sep 2026 19:52:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 71E2C362
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 19:52:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 096BD80D7F
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 19:52:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cJUv796o86l6 for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 19:52:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5449C80D8A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789674758;
 b=K11ZWKl9udvIrJcCD7JLHvYd3vO1D/bfbMPUVaUlqidVgpJJY0BfH+LnsuLK74Lf8Yck
 9u+AQP3Zp0E0a90ZCWAPb7AeG6AO9/TYtfk+IRoGiDZq/L/5fx1ttKPFGfp5KhWkyYwML
 icG1EsZ5Q+pVPQfTfTMopakWmiIpxDobxrCYjOtHfzZiginse8GSltwD67QigWoQ2Ay43
 VYevgNgIvA7TZXlOc+NcrfLkaLg3gqwp5qbV92c7d/Mz9TNt/XjEfs7pvLIeIvl1VZgOv
 5JvDxapeaDRmu58qIUfGf+zG9i0buwPggYSIcfbcae90qlvvjIi49hi6Jdd2iMD54lw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789674758;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=/YXbxztHpzwiDObw5rFociPByp8fqGJQX+HlEr7NyDI=;
 b=XozP1tQwhny0YG3nyc3QLae1g1JktVnGqgmtU6JU3+vfgAnYU9GFFxtdiCBuqGb4i9ld
 54Po70vvqkKnIUMj3q9EIi0bRfNl3sg/qigdx9wheQXK+qmLMY7RuRf3///UnN/6UKRP4
 oJhKRq+EhAvhWcn3XfNfGD01GYM+3tLPDYeD4G5GC0Jf2dMubHWxj1srs5MLsj5PczkHO
 SLHwSihFR0SsuHiT4JjS9QXBFvV9zzU7hSCzkyja+Z0OC1wv2Al06tBie4JJ8/VbOw9W0
 ilMqI1/LNaeckO044C8k1FItTyxecZJeBJzJM9JzBX+zEY1DthZZZLJwT++XvBmb/pw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=oLk0ZJD7; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::d;
 helo=mail-oo2-x0d.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=oLk0ZJD7
Received: from mail-oo2-x0d.google.com (mail-oo2-x0d.google.com
 [IPv6:2607:f8b0:4864:31::d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5449C80D8A
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 19:52:37 +0000 (UTC)
Received: by mail-oo2-x0d.google.com with SMTP id
 006d021491bc7-6bd42f1c01cso826554eaf.2
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789674757; x=1790279557;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/YXbxztHpzwiDObw5rFociPByp8fqGJQX+HlEr7NyDI=;
 b=oLk0ZJD77UyHfMZDPtw0viOB4Fj9o+wXzyBfoj1ZGjz1aYbW47e/q+qAUD+x5zkETH
 dwJrzlNQfGhzQKdrNqd827ySRE1rQxiV12/TTyP5OiHwFNl9u/K+tCWXP9IfdLrYBYn4
 JW1xIm+Zq9Snxgd1A77KejKOuL5h2qQ5UCTLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789674757; x=1790279557;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/YXbxztHpzwiDObw5rFociPByp8fqGJQX+HlEr7NyDI=;
 b=nelygpdv5a3BsMwMKSCLfACoda+0zpUNZnUH66ayWofO26NauotVkoL6jO6gC2LvAC
 HpsSMzyAaAsC5uCvCBShJ3lyRPbhGBWM9NIijAXuMIQ1hiD3ec0U/szsH0Qb/s3KIOND
 Ut88lnPd6k4TLI+gES9QO6Bh2Veg2e6fGxdV7AjEyivKpKEMhGJfb9E6P+k3XvMN5C4/
 OP9EaClUNs0cu05V2uNaOS+UG1nakZMIjz6EHLSCkyppyE/e6Z/tcbmfafY5QrhC8jN1
 6deW5ZM11VBTElbENH5mzH9rZl7JQss7DQfDicSTnRSQdVbmbluXyO/b8p55E5PjiYsm
 ba9A==
X-Gm-Message-State: AFuF++n1olMT+xjR9W22SHY575qA7ok6uES1Epzo2BrKXnKcPUZRh5yB
 BkfxKOl4mCzPtAV/xt/b0N/RvE50oKrLAtC4Q7OpfuvAL+79lT6/nCrUM/QxofikYuEBNHTiPhK
 8Mta2WPBPvZiR
X-Gm-Gg: AYBFou2HFN9CjDPkofBqstzRBxrxGrUAZ4IrZneQBhkF6tf3LDRxKd/iD1ib5cmMT8h
 n6tLQyWTinTkNryH7pzfl4BtLTpJd28I8wJcukDq5B5X1ZV8QiOsmR+ltPyjDH7Z6jy4CjGvgcw
 koDyKUEQNSMKXifOEr4LU8XW+yrU8Pt4hd6Wuor47RDwU1nT8ew4eU2lz2MCmmYnX/es24IIvM/
 NYPJ9ltMFvvOkKAUCrVa7xe+FecLDS8fG1fOldcnbFvYWRLW0kwnZjqImPgwcTzy9P/U0tOX84F
 DUDeaQWOoAXgjLyfeSz/c4LgJj50mTcRYr96QImGPO2RacXrbfl34XKYCSL3FH9l8QVzLQM3+S4
 UpWu/Dzobk5FxtfdKyilk9T+FpeIOxmiI5Fi2f51CDnRMtwod/oBYiIAJYMlTkbg0ejDjUKWzHE
 Wp6ojBTwE7p9eZGEfQ16bplmYDI+CgsclxxWLQhoFtuhgNj5XmzFGhLXT5YyR7HbZTZ0MpSgyIl
 ruXv2npQdlcmbzB2DTBmlAy8PLyGmKxNNbEWUEGXXvIdKeh2VmTUigp3um/vyppD3XFJVfAANtK
 WRXCNudBbrfOfgtC8L7B
X-Received: by 2002:a05:6820:290d:b0:6b7:83c5:fdf2 with SMTP id
 006d021491bc7-6ca9c65b94cmr57675eaf.51.1789674756857; 
 Thu, 17 Sep 2026 12:52:36 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-486ab47440fsm1129916fac.7.2026.09.17.12.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 12:52:36 -0700 (PDT)
Date: Thu, 17 Sep 2026 13:52:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>,
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 03/11] lib: Let SPL minify zstd on its own
Message-ID: <20260917195233.GL858934@bill-the-cat>
References: <20260917-spl-fit-compression-v1-0-7985ac56ee9e@flipper.net>
 <20260917-spl-fit-compression-v1-3-7985ac56ee9e@flipper.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+Dgz93lEDzbAOAr0"
Content-Disposition: inline
In-Reply-To: <20260917-spl-fit-compression-v1-3-7985ac56ee9e@flipper.net>
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


--+Dgz93lEDzbAOAr0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 06:02:24PM +0400, Alexey Charkov wrote:

> ZSTD_LIB_MINIFY is offered only inside "if ZSTD", so a board which
> enables zstd for SPL alone gets the full-size library in the phase which
> can least afford it.
>=20
> Add an SPL-scoped variant of this option and key the build flags off that.
>=20
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--+Dgz93lEDzbAOAr0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaqxFAQAKCRAr4qD1Cr/k
Cm2/AP0YZKDzwVwInEFrTqlWpA+cdba/xeILovOAm0IfCF09pQEAtUHUrkVRJkk+
YBP4t5rCMqOB9VDeMiNxpcdYjlzgeQY=
=sUXJ
-----END PGP SIGNATURE-----

--+Dgz93lEDzbAOAr0--
