Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9853606A88A
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 07:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=D78R0XRf;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=pzn+CK4v
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C1D7608EB;
	Thu, 12 Nov 2026 07:07:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NbTSgXeg4Dwq; Thu, 12 Nov 2026 07:07:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 64F0F608D9
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794467266;
	b=IlDtSL7KDq4111aS41p8/0o1TR+TU9Vk5BN/Mb5qNUueZeEMUwIJwoh+YYZMfkSlSCO4
	 nLUFia6d+v5xtaqsISFgy7AvK5PvKcCVuOBdHIPbVb8NH5C6682eCnJsNEyHsdrd71Kiy
	 I71wU+ZuVJsSqi8pyxvMUYR6gf7ytbKe5zZ6XZNZjv4JLCKQesvrxfddEBUDEYxwcEJuo
	 0XYZAvw5HT1RoX/DI5axv7GI/F1Nd0+TVNuOUP9HBlapnmBSav+1wT/shgbU4ZIQv5457
	 zi1pKM1DT2FyRv7qZvg1lnPZ6DXXVtTzT7fzsfs0TUMPNqa39PVfJ4wHWsGUWrx2sKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794467266;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=R9zZeO/FDQO2gbWCm/b4981bsYJGvgw8mUE4Sjid808=;
	b=of/u5MLDiJoXStbz6a/JP4SHHmSZo96P6wpaFI1LjsLPc1o0cOfUfzl34AZ1rYxCEJZQ
	 NgFOF5mszy7FO5oI54/l4xnrHKbloAkpkhWmLVigEZE3BccQ4wtu8/o0+IWt+Rw4V2rNa
	 A6q2wpY7bom7zCmKIFuWZh0+hoOAN5YLu+t4vMqcX7Jc+pt7hFh8W3v1LO1OGXnrZsdn6
	 BvbjQpVM6y6DjYace90C+VKoOc9w00OftcA8UIwKxh3yaUz0R3ZFn0XgTPEnUmRxtO1v1
	 9daup//VD2092kxZ3pQPhRN0Uk1Nm8ETTFmvhVZWX2PBZ+fGo7GLSZ6alwfLAGBelYQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794467266;
	bh=R9zZeO/FDQO2gbWCm/b4981bsYJGvgw8mUE4Sjid808=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D78R0XRfAALcswil2uIXuzpM/4GXNr+YUfk2adJJrbMwJ+X1U/IKA0UBUvXCxOoxX
	 Qd1woZhrV1L0z6sFg6WM4v5am6IrJ8WX0z99J7+vj4JJW7qgPRzgYetWnKuqiCh8OD
	 +KKOSj7YHt61jvatKKvvi42F0UtbmT4i/a+z0cacvJ7OXWYJU+g0ILYdYIQ7yTIOGO
	 TgDvVhR8GExwXUH1usoXlM8kYYAqwXaG6SY3XyORZDD5kAfk8raaMdfrkzfvQzG9sl
	 RrFbkvGBmX7tnUOrmjv4tha+E1h5CqNaYIF6RX70aAbvhONx7fdJgIPB4Zrkg9Wdm1
	 sNs2sYekiDRZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 64F0F608D9;
	Thu, 12 Nov 2026 07:07:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D0E061399
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 07:07:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C220F813F4
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 07:07:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9knC6n6ixQPd for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 07:07:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D2A7E813D8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=pzn+CK4v
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D2A7E813D8
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 07:07:42 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so2356668f8f.1
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 23:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794467261; x=1795072061;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=R9zZeO/FDQO2gbWCm/b4981bsYJGvgw8mUE4Sjid808=;
 b=pzn+CK4vOgr05X8dqKilPPHqQ8OvYXjqpaKjrXMeSHZCwiONj2mIIAPBogcGe37sgY
 mm0pAfnhRQf7N6NOuyqLZwM+oCLkwV7lYowOdWUI1vLk3h3QMFUhDWnv99Z7+t34B7pq
 xNOtgp4AysPmoWJd6UXrkgi61HseSgsXW7wTThr6phWzkAbaZ6KO7oO6toF+kWe74pxL
 k6QZtt/R272IdatIzCqd3OFiYg5TYxKU28eeGUSNjUpgNlNkti3NnQUvfh0qZfouS6KE
 JZDz96GjB7ZA6OjKbD9RJsR7cM9h4vyrEPxKZWLz9kHkw04ztu+JjXEUYu+6KQyG+RIA
 /5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794467261; x=1795072061;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R9zZeO/FDQO2gbWCm/b4981bsYJGvgw8mUE4Sjid808=;
 b=UL6e8o3Gh2FqzGbUKGXJ2ptUeVVOAthm+D+Eyl/NTQ2TcIfVYVY13zHP7Vq2Ogkpaa
 kVyNLO0G6Piqgh2S9hAXucrIEKs3gP4B/DQMXS1FMOBlev8TOCpZdxRu6KxcayZfQoln
 TC0q0b+5RKwC9Rc2bzAeNPnpO938+KqIznzrh+DBerTfcTQHzJznqD+2deNsBPrwXIfW
 5A769Krn+ysORGvhGoQ7mAoDMGiPv6I5tXY7namRMP5odvGuukVCIlVYpfrp4qkxfAGl
 h1jz4l3FQOralMai0Ny1O4yzw71nt6gfOZ/WKtVbCzCIN+SRWBvP4Q6JS/63YOpa06Py
 QxsQ==
X-Gm-Message-State: APuU4Z9APuRBhosFd81acs/52PTG5Z78NTQxcH/xKMzPpDEY4SMjnHxV
 xtmBp+raquxjZ2iR2Mq7iZBELlqPBvZD5ol/qEHK8jaI5dfF9x40NUa96dmLhV+AnQQ=
X-Gm-Gg: AYBFou0Kj07DaLhHIQ3uBh1DXDIuwUoIwXAo58qHhOELKAhLQoATxvdHpJMhuL8iCYq
 yVxa/MnhjVcdw4L/LmeJIDqKygQn8LfRoUHsCvltST6LLZkeskarA8xP+Ka+4S04th93JKTH7Rp
 OgBsg8xXzzGg46EqnFa3irbWiTvHz7BzgkUjurni8t6YFVPrO6sS0GfYgJecvSp6KQhwnJWOpGB
 jOTd0YpSeQKBWLOIxc+LSpfh2l1cldgaE++4t8si3zabtXzDVU0orcMwqEWBaefTTWFX/+r+8D/
 YmIqAvY5GXTu+HGNlCVA+Z6FQs0TtoMSIuNEi7kD5iV9BI0QEi727u+MnUF2JLhuUcZbdGTf/8L
 n7BfWBjFSUYDa+2tg33ZsipBRuDvVFxSQeF68/EYjD57DXXe7Ca2A1NAJGeU4SroS+X1v9f578q
 hp+E6TlbI7rNHidSb5lFg03OqbwZtLRApcHUiZADhc+20gEE1CSttYIBZgdKbsUz0mHOJWchlRI
 Idy4H+kWgIhSC+w43CPzIl+iyBgSEBexYo4Abqvm+erO6swBywtTlATKdfsp1tptL4jAs2lA44g
 c/dY9vRqp4uocPOc9iWqr/uxSonkR4cNdogP7blEnwd7B9Zb0qKUoWQrZ70Lot/G6RwxeycVvhH
 1YPZ/bxMvnaXx
X-Received: by 2002:a05:600d:84ca:20b0:4ba:493b:3401 with SMTP id
 5b1f17b1804b1-4ba493b3412mr45594845e9.9.1794467260831; 
 Wed, 11 Nov 2026 23:07:40 -0800 (PST)
Received: from macbook (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e28c882sm49368475e9.6.2026.11.11.23.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 23:07:40 -0800 (PST)
Date: Thu, 12 Nov 2026 08:07:36 +0100
From: Carlo Caione <ccaione@baylibre.com>
To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jens Wiklander <jenswi@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Simon Glass <sjg@chromium.org>,
 Johan Jonker <jbx6244@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>, David Lechner <dlechner@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 2/7] ufs: rpmb: stop the model string at its NUL terminator
Message-ID: <avVk7_noolHp0olO@macbook>
References: <20261111-genio720-ufs-rpmb-minimal-v1-0-701a62dfa034@baylibre.com>
 <20261111-genio720-ufs-rpmb-minimal-v1-2-701a62dfa034@baylibre.com>
 <avVgZyWj1qwekTVJ@trex>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avVgZyWj1qwekTVJ@trex>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 07:44:55 +0100, Jorge Ramirez wrote:

Hi Jorge,

> > diff --git a/drivers/ufs/ufs-rpmb.c b/drivers/ufs/ufs-rpmb.c
> > index 508eb74d976..8b61760f071 100644
> > --- a/drivers/ufs/ufs-rpmb.c
> > +++ b/drivers/ufs/ufs-rpmb.c
> > @@ -270,6 +270,8 @@ static void ufs_rpmb_string_to_ascii(const u8 *raw, char *out, size_t outsz)
> >  	for (i = 0; i < nchars && n < (int)outsz - 1; i++) {
> >  		u16 c = get_unaligned_be16(raw + QUERY_DESC_HDR_SIZE + i * 2);
> >  
> > +		if (!c)
> > +			break;
> >  		out[n++] = (c >= 0x20 && c <= 0x7e) ? (char)c : ' ';
> >  	}
> >  	out[n] = '\0';
> 
> 
> have you tested this with Linux - RMPB access from u-boot and linux to confirm?
> AFAIR (plus the tests that I run) the code should match.

Yes, I did on a Genio 720 with a SK hynix HN8T05DJHVX105 UFS device.

The problem was that the device model descriptor contains two trailing
UTF-16 NULs. Linux's utf16s_to_utf8s() stops at the first NUL, while the
original U-Boot helper converts both to spaces:

  Original U-Boot: HN8T05DJHVX105<space><space>
  Linux/patched:  HN8T05DJHVX105

--
Carlo Caione
