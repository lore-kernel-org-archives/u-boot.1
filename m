Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FCE606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 17:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oz1EyyCr;
	dkim=pass (2048-bit key, unprotected) header.d=e-labworks-com.20260707.gappssmtp.com header.i=@e-labworks-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=kXkI09f+
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CE0FF81299;
	Wed, 18 Nov 2026 17:40:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7JdP-xGdAyNz; Wed, 18 Nov 2026 17:40:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 283028126B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795023619;
	b=dKWGXYaM4KkoQz7k6n0aQVLbit3u0UZupJA4/rXKez+/TOH97+Kae2qTogEQHrR0LwTJ
	 2U20XHjoGWGkwqIAxKj7XsbN57dmShY2d4yF/mcWty93gbPszKAVeKIrWv9zBxPdyTAJh
	 KdwNgiZZHfKoGI2k0hfA+/NyTOAU7QSNUSYjvM3wKIx6Zd0UsrZ3vNCzfcKK3ZrDxghBU
	 kxNjLHgvEiipdIBzep30f3c1qpuKiOrSPPT1ZXKeE1dWzotUMoUlGzcLDf2ACibLaBxK7
	 NYlS55Vo2llzVu4cCc0cjI3NLVFpd0/st34DJ/+xwU6Qu88Aok0xnSNOAIBm8fl1MCA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795023619;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WhuhGZLiy2V9qj9RNdHav73ILY4qT7HgJcUSXDRr2xY=;
	b=iPN/XhBm7s/yhf02HXrSP1OMFqic8DSVKf9Kv+0CoIEMFAGIaURKEbILlOBLuGM8qriL
	 lwN2/flDR0pGrIoUZ/06nP2VvwYO84FK11pf8tBZAPF8Zifo8zzC99HCosAcYyirEaa7P
	 PmRjxxlgQ/e8o1KY4Mq5Vcu8A44apWqAZgDPN08DoFSI5hRa1Fr8lu65nDy2aB1dyFwH2
	 apzxY5KYJzkyhN6aqNhZV5tX6X5nVpxxDqQNVu9DMXF3ZHh3Vw9sqLsYlSMgSKEtKXz1C
	 C/FDIbCiZ6Bjf4S6PFcEj9E09vqk+BGBd3mGl1luK3ihiWpO6OQ4cpsNZW7Hke5D3UA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795023619;
	bh=WhuhGZLiy2V9qj9RNdHav73ILY4qT7HgJcUSXDRr2xY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oz1EyyCro9oL0dV5OlqV04cAwGjw9D3r6H8VUsfOTYHepcp7lU/InPRRG4XirwKwV
	 Y21T8OSiRZKANwx8RfULGcui7U/C19WeYY+R/R1q7Udekqy2XYylrURchAS403uHV5
	 e4LvUPgkeG7KWOz8lnSrfGjRtoCMfbI2MEzjbDQJGaivXBwfmTKxJEOEgQq1Ncw+oA
	 ImhHvA7gZDM/jMEAf6A6wkyx8EIp+hJMyKhPMa6aiexqnp230rn8gtMKLPWs1BlNaV
	 TLFtxXQNL3Hv41p1hw3CV230zB1SW0H6LSxwr+8PUIJgPjJaFDKgoHOaLobPz7ZV9R
	 fbFcPxfUjeJLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 283028126B;
	Wed, 18 Nov 2026 17:40:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1508BA0E
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 17:40:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0692240807
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 17:40:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZhcU1Nuk8oQC for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 17:40:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 102D94078E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::132f"
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::132f; helo=mail-dy1-x132f.google.com;
 envelope-from=sergio.prado@e-labworks.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=fail (p=none dis=none)
 header.from=e-labworks.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=e-labworks-com.20260707.gappssmtp.com
 header.i=@e-labworks-com.20260707.gappssmtp.com header.a=rsa-sha256
 header.s=20260707 header.b=kXkI09f+
Received: from mail-dy1-x132f.google.com (mail-dy1-x132f.google.com
 [IPv6:2607:f8b0:4864:20::132f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 102D94078E
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 17:40:16 +0000 (UTC)
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-3282db206d3so3460915eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 09:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=e-labworks-com.20260707.gappssmtp.com; s=20260707; t=1795023616; x=1795628416;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WhuhGZLiy2V9qj9RNdHav73ILY4qT7HgJcUSXDRr2xY=;
 b=kXkI09f+l5dr1mF8K+WXF60yC0TObXQbDgUifQcvsf/Z9CakLIblqsoZfQ3mhc8CzO
 6067xD3BTfCDKIk2gNYMsxvxyHYYgoMtBY0uYKxA2gqlV9Lo0Kq3V/ourYBF3b8nwX4f
 UIJsI6HpnBTXbu68WgmTI62mKBezvl/LtbsgFyZO1BlZRNgsVt1AEbsT+cLbg4d3UKwN
 0K1okzUwREWdq0WI78VImYuUqPumVZkS7gqKi6ii6apdxD3S461MyH0kfD2qcaVDgOeD
 NQNg4P1MAfRY8XiIjNgGCNjISOzD42yavnT52qkoTSzgdu9JybGOKCT4Vnmmqgk1fHQO
 7AWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795023616; x=1795628416;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WhuhGZLiy2V9qj9RNdHav73ILY4qT7HgJcUSXDRr2xY=;
 b=WMPF0ozlKXQMkGpHnl+pnbG2rGpojs2LrWmztp98TJzoiiB6/lgUbv8MTl2yS1Pkn/
 HVKewYOAWHzZKCGc0qplQJnveWEEENnjUZcKnz4/P8lsU8Psc6F8HwhkNJvwbxeZ7KGI
 O5W1PX4EIb9S1AxA6rZhI5U92v3YZBwIH+ft0mkOPSlGGYtRITAMCqIFC3kZ6bNkEPGl
 rA1gYpXcPhZK5AZ/zsglwcbqz/Q2ebblJjyVR4ZVXXp0p166N0wm6sGPQfY3sAV4YgFL
 za0jvZFJA1cH/4W1oUyEoGrjnPrHm2ZrTdg6Pq9vRSGGWxuFYlH0lWYUdJtXOqsOdcxp
 hZgw==
X-Gm-Message-State: APuU4Z+fhqGVdduUHgIgxdZ0wnEu2LkhbPxvDjYBADY8QmaQOs3YS7MV
 KTKYBAC2y1cvj+W3ebpb44IuY2C1gTg66bMwRqiD8Atmlu3NLA0mrPQV1PwgBJcTOW3SLVNkl8P
 kwWalHOVroPVmLSd7dOB9qjVT/jtJlhLqvzv3DS28/w==
X-Gm-Gg: AZFdTZdhfXSkdObo9sVUmOIxr/B+9MlKTAoItCCC0Bqevw0t96FWFXtsOaGRSebKM6Q
 FgyzJ+FyF8+hb3E47kZRWtXAF8qnHYUhjxyLNglPX95/sM8R30xwtpweQe/T5XfH1+Oqje6Lfok
 z3xAG8Q4jvVAhZOpRLv+xS9UEtLjWDSvLc5oiDO6g3kNZJhu8eBwpGTI2k6UooXytz18XOyDDPO
 Yl6A5Wkaa4EdiVTIIdLx8IXnsr7J3n/drHks2TUyO1d/iMbtZ2u28sbbAN7Nh4BPiFqwWwoijYC
 0jeJlRoIwEkofxBWkGGf4IdpyEPvSv/LUKdloaTuwukZHplB+s554XBOCO1ot/0WLUDodyMV/Ga
 GR43lf5vvz6ENQ/iZlqzzetgV8RtHNKsF6zkB4k4JC9+wBzK5K8vHr0tuWxkgSBQghns4Jw==
X-Received: by 2002:a05:693c:8646:10b0:381:f33d:edab with SMTP id
 5a478bee46e88-3827f5ad43amr3411796eec.9.1795023615479; Wed, 18 Nov 2026
 09:40:15 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261117101519.3952636-1-sergio.prado@e-labworks.com>
 <avw6QW3OO4Lw0631@francesco-nb>
In-Reply-To: <avw6QW3OO4Lw0631@francesco-nb>
From: Sergio Prado <sergio.prado@e-labworks.com>
Date: Wed, 18 Nov 2026 14:39:59 -0300
X-Gm-Features: Aa3M54pEB6OLi7r11k7kuVYgorldOf_utyAVq9Zo22kKyA_m_P6fibArrJhK79g
Message-ID: <CANu7NGuOMwMd6W5y_b1=Z=1o9Y9GnegUdQOZiKEWpdewWd5qvg@mail.gmail.com>
Subject: Re: [PATCH] board: toradex: verdin-imx8mm: adjust U-Boot proper
 offset for eMMC fastboot
To: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: u-boot@lists.u-boot-project.org, festevam@gmail.com, sbabic@nabladev.com, 
 uboot-imx@nxp.com, trini@konsulko.com, marex@nabladev.com, 
 o.mandel@menlosystems.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Francesco,

Thanks for reviewing.

Em ter., 17 de nov. de 2026 =C3=A0s 08:28, Francesco Dolcini
<francesco.dolcini@toradex.com> escreveu:
> > +     if (!IS_SD(mmc) && (readl(OCOTP_BASE_ADDR + 0x470) & 0x80)) {
> > +             switch (EXT_CSD_EXTRACT_BOOT_PART(mmc->part_config)) {
> > +             case EMMC_BOOT_PART_BOOT1:
> > +             case EMMC_BOOT_PART_BOOT2:
> > +                     raw_sect -=3D 32 * 2;
> > +                     break;
> > +             }
> > +     }
>
> Why do we need the runtime check on the fuses? verdin imx8mm can boot
> only from eMMC and with fastboot enabled, so this runtime check is
> redundant, everything is known at build-time.

Indeed, the runtime check is not needed. And since the offset is fixed on
the Verdin iMX8MM, setting CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR to
0x2c0, as you suggested, is simpler. I am sending v2.

Regards,

Sergio Prado
