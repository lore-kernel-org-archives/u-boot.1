Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90455C61DBE
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 12:42:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 28E38606D3;
	Tue, 25 Aug 2026 12:42:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f7ehsKVjmXbb; Tue, 25 Aug 2026 12:42:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787661773;
	bh=BeGz/uR1YFDuJ8ayXHD4UF+doA3tZRqp0tfLMqpAzJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wMB6zDiCgHbxTWBTvy0yvT6AxQEf7wtQ4u7i63H5EOlmF+b2M/FP6asXSKkntS+Nq
	 9xrUiCW8ek0RQDnEi/96YTPXOl3nwt1Cy1va/azju2A2SgOTP9gUqTjeon50R0e8Gm
	 izO4U+tgUR6GhGyM3ef2P8JuN3wLDkee3EYjS31Ib9Y8bToIPFeiiVY8hJdiUZBpPU
	 fth/Et1LhWkLsyP//cK9anTR20T5IdUDp+q116OiPWAFprQM8zdcu6N2Zjba2srXg/
	 +FILa4ehsR9rOI8+EbnfIhFC+Lj30aB1QudEEpw+j8gS14VXICy6pUPTZ3JtyPfFHl
	 2hRe56+H3Fj+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4BF34606B4;
	Tue, 25 Aug 2026 12:42:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id F28A1396
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 07:45:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D927F400E3
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 07:45:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XKRiOmyXXpUC for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 07:45:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=E3eJ6PsJ
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F098C40068
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 07:45:29 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c15cb6f5c12so784518766b.0
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 00:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787643927; x=1788248727;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BeGz/uR1YFDuJ8ayXHD4UF+doA3tZRqp0tfLMqpAzJU=;
 b=E3eJ6PsJwGfMLGEVT9Z/2XimhK3i1xo/7l40peZxuUJyZbb4h3HT00Fo6AHsZbUuEz
 jctMrMhLAJfTwZCWdm+rCJm7TU2rSzIASlHATfNq0D7a0cIA2BtTQv0fz7XKt0TcOQpb
 TGQdnNRoTiZ45p1+IIsPtAL6fP0LN6oTqvv7DvzXeta4Pcov1xPs2lPFGCfzoQFe3Pc4
 hF2qBMoGM+olMKyZXVHSFEwMn2OO2E5yTJTUOlcbkHCFAxXFWQHUsY5ngSCC0sxtDI3f
 +KSNyjaQ/ItKd6wSQlqu1zxt8RihH7mQkCLRijCwtzGXbZYuSTBS6bjHNLFe2OMWLrMi
 0cog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787643927; x=1788248727;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BeGz/uR1YFDuJ8ayXHD4UF+doA3tZRqp0tfLMqpAzJU=;
 b=lZB16T9ZhjKLhmHL652HoWIfXrEdNfF68xeIPuNNmqSgKTYteSIyc3NLr2J/srWa3S
 DY56RGgoYOk+VGgG9k67GaptX+17gdU3ibyyz/bqbUbGTLplDta6AsY+evcWHCHOJMhG
 1RCNQw4QNQfStouj0d45b8y8CB1hM2SQtyhYHFzPf91EC3p7z1IGx1Z9uiYm17VPQ2bn
 O+oigcJVW8q94J4SP4sxQzeKXGVueGMx3079dEjo7LX3LGXv1GQY62/YNEr2474baQ+q
 QuwFwfmojZql89XMEkt/SoA6/LWzl6zc9jekuR6jIaMMJVwNIAKh4kr9RButeF17o9/3
 6d/A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrf+vFcYqzvcDgFQXa+XbYnty3m+dBfUguB0ul/JigaNmbbWIGmt8zfeFsPru12mB9QCTysV7I=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++l1Hfh/oVJeJQmQwmy/4GVEYhB1r6NCUJ5zMVlv2AYJvEUFouqU
 HpBGaM8yqoe7AZvIBbY2ecYPE/uLLl22NnktV6tla/0iaEaYbZOK9Rf1
X-Gm-Gg: AR+sD13zfS9D51KLzqHOOyljPtQmDOSU+B+NSBTs9NK57PIrGzlPrgLEwihH2ryW6Pn
 kdXljRLvPF4r8bI/E3bbio3dPvLiUAnCLow+h3VKNEYmYWevgZKKx8N2QdHnALYBJlfC2r5SE1m
 +T/WWDnSFuc5AVU18SZecVmyQD5DiK/f7XoU9TGk2BkUlVjQdpvZKiBVaunbRionDHrnhD9HxgK
 y/yzL+/p2WPrXGg+biySSez09+Gv5k3c4EOXnGE1iskA5JDvVzTH0fqOaLz5SVimP509TBFCZAf
 +AWa6s7TnR47fB7Me4hNIfe49BtCV97qcompKtSZZBO8+mSAmUUujtoVv/NO7mRAWP4qneQfHnV
 xlBb/rSSd4+pAg20x/JMJUXk7B6+/9y/th/JWSX7xWiIxLxHPum65fGWvwPuW3SHwsKtf9NwoJI
 dtcoAk0riA1GBCYaHProwBxIF4cl/Pm6CztbslictBD5F9aKzxBPnKwbJG5kZm
X-Received: by 2002:a17:906:6a10:b0:c16:2dc0:e1ef with SMTP id
 a640c23a62f3a-c24925e38femr2371605266b.14.1787643926985; 
 Tue, 25 Aug 2026 00:45:26 -0700 (PDT)
Received: from eichest-laptop ([77.109.188.37])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2496738e7esm1822078066b.46.2026.08.25.00.45.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 00:45:26 -0700 (PDT)
Date: Tue, 25 Aug 2026 09:45:24 +0200
From: Stefan Eichenberger <eichest@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: francesco.dolcini@toradex.com, sbabic@nabladev.com, uboot-imx@nxp.com,
 trini@konsulko.com, franz.schnyder@toradex.com,
 stefan.eichenberger@toradex.com, emanuele.ghidoli@toradex.com,
 sjg@chromium.org, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v1] toradex: {aquila, smarc, verdin}-imx95: add
 board_fix_fdt
Message-ID: <ao1IFKQq7Lni4Kx4@eichest-laptop>
References: <20260821070958.6997-1-eichest@gmail.com>
 <CAOMZO5AY7nkpdyBckixiBTRLK6f1YTL=H14cLnoMLc+Qh5=MvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5AY7nkpdyBckixiBTRLK6f1YTL=H14cLnoMLc+Qh5=MvA@mail.gmail.com>
X-Mailman-Approved-At: Tue, 25 Aug 2026 12:42:50 +0000
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

Hi Fabio,

On Mon, Aug 24, 2026 at 10:24:41PM -0300, Fabio Estevam wrote:
> Hi Stefan,
> 
> On Fri, Aug 21, 2026 at 4:10 AM Stefan Eichenberger <eichest@gmail.com> wrote:
> 
> > +#if IS_ENABLED(CONFIG_OF_BOARD_FIXUP)
> > +int board_fix_fdt(void *fdt)
> > +{
> > +       /* Remove nodes based on fuses. */
> > +       return imx9_uboot_fixup_by_fuse(fdt);
> 
> Shouldn't this be added to the common i.MX95 SoC file instead of
> adding it per board?

We discussed this internally and decided to implement it in the same way
as NXP does in board/nxp/imx95_frdm/imx95_frdm.c, but I'm not sure why
it was necessary to put it in the board file. Perhaps because it can
only be done in board_fix_fdt, which might be overwritten in the board
file anyway? If we were to do this for the entire architecture, we would
need to define a weak board_fix_fdt, which could be overwritten, if I
understand correctly.

Regards,
Stefan
