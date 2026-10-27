Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD9A606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 04:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AhdpiEU/;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jzHtSqvh
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3BDA56065A;
	Tue, 27 Oct 2026 04:37:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NELyrcSVas34; Tue, 27 Oct 2026 04:37:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0F80B60603
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793075854;
	b=PDghMq0XJcmcAACvAPg+gwW7oWsndvE36TEDn3TtajxMa74gwExM4p+WCi+D4X4f6rye
	 ePVbVS+olAMRskiRiVxTMr6bbkNxuDhHVCb1kfCCZXdeTVUY3pTDEv6/l50cj2zB/Er2i
	 z0dLiUxfcILwZjet11h6iYFYtzmRHkazjckoFOri4nxQTT1CF11noMCa3bNJ+D9lCQc67
	 jz9Q7pOn4RpZFyXjIm417qC5j1LNXnxpiAr4zumkGcjrRB0WevqSvt8DMoeEm6JTk71sz
	 ssdxU3xoH4HBmg4KKga2ctJxXzMpsIcfM0uugMLdLtGnfjScu8hvowjauynw4/jGETQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793075854;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ix6oepBdSOnDlTmqvq5nLffYb6atfx/6y7RgSV87AWo=;
	b=YMYlXF/ZAHSssxcFPOcn0Oahp13e45AzFn2mNb8tvcmM011yX8ynygB2y7Mc+0sb09NM
	 NinJMU5ArvYfBJhScC562CcBuUB/RxXqZkLN8EOyI3jnIKBNiYV6DBOK/mbgzLXQLit1b
	 flTT91/m8ULu4bEvpnzHYlVCJdt5XXd4LMcyqaP4wYlWXSVto/p3S0bD+a6EF75a6zYaB
	 V5MreU/V3wxfNmpH2R+TNljEjYAzmOXGl0PCfxIj0kjq435sbcQudqdNUu9z2hwqSl0mk
	 DTI01IiU0K/2f7ebVCl+bE7vJaVCtFyJyJMJw33T5ESVLCRhG+q0du0XmeOyaWvMUJA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jzHtSqvh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793075854;
	bh=ix6oepBdSOnDlTmqvq5nLffYb6atfx/6y7RgSV87AWo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AhdpiEU/sNt/ntI5sfrMMuBSsHTvjG+ogXppD4J8OPtAC28TWUV4QvR5RjGnY1dyx
	 Zh1axD1e7rKiqDC6M2EH1AhtA5e5UClqJK52q36dCNqBO8gcuVXx8PNk2A+tbL+Oba
	 J86Z628SOg2nSlyJx+I/voDhlazCL5RuZLh3vogUcKVvV3hYgoSbGZzh6IrXYlh/fh
	 3RTEREPgIG99V4CklPLT+VKSNCqElrNSnnAm3qxYQhraK9lTb9nGxIve4coZEyQgwW
	 L+c9gD9azwMQs+WvQmHPdUjYZNG/J3aqNJaV8BsStRgqwM2d0Lv/6k5axzXd523Or1
	 kYMk6igEXScsA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0F80B60603;
	Tue, 27 Oct 2026 04:37:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4019F120
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 03:06:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 26638605EF
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 03:06:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8KQYkIdIxHPm for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 03:06:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0A21A605EA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::836"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793070408;
 b=aPrJQgf0m8V4lgnha557yksz8nou8R8O35t4BuHHpQTblqzVqyJ8phD1+B2djNEKbA7D
 WV12UfOrXEk3HxmXKvg1wkwRkpE0LXNhgzjMUKtsVASjTiFC0mpMDmCnYX4QlJi2128jM
 V49vlpk/KvbUePD2L03/ArXnYAlGvVL6JjCTuiCDl7TQTcWQysARBNJg4g+2jL1/8j94I
 vy3Wc802/XQfeAezizH6p8iebNwhvMFXPYJmfdEgwUDxLPclg5soHZ8F2GCH4D3L/4qrw
 6/fIlmEWwdqb+nfrbexIdw9efMxCGvHms4aNKEVr6yoWisNb0UvX1AfyCYBt5NRfRqQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793070408;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=ix6oepBdSOnDlTmqvq5nLffYb6atfx/6y7RgSV87AWo=;
 b=fF50jD7w6ueDPLUHy5VGEKKnjummsLvkoXybkyb+ktNi11yksroAKDrcBlgGpFW7vlhy
 ajdEyur9DfpUYiv6rHK4Bz18krpiTSoW12VGs5OKBYgiFpFtuBRWb4LM4OzCOU+UFCuDT
 u5PfigtLfSQWzqYVeDn69zkHQaI2RNs/H/JzmHlCsOE1VBtZTlCuwf9GcC7USaf6WxoDz
 YHrvGmMSwq5mqpGp0IIp3YjEhQcbHLMtPHQiJLsv1HOhEa6EZ1cJ94QmpGPEJvn7k/IiU
 WW8+lcwc2Vhucb+3t2Nf7orJjPsIwsmaq1OuTuz0i9j7AAI0hHuIpvK1Dv1mAaVFaZw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jzHtSqvh; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::836"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::836; helo=mail-qt1-x836.google.com;
 envelope-from=terryzhou05@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jzHtSqvh
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0A21A605EA
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 03:06:47 +0000 (UTC)
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-5361e313e63so35351361cf.3
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 20:06:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793070406; cv=none;
 d=google.com; s=arc-20260327;
 b=kUypua87LJ6aj57Te3FbG6t4IRXvV2TBR+b0VAeFHxPp9pPywBP9dxwZiOQeI+Hu1y
 DEEaWQSPOxmdA4AeflAFziBiDVqjyQoLXGyGnyVPNaXGLxASHfnjLd4LrTFJqtO0nWmB
 ItlPilYgJXH4+3xiOSSXD7BP7KRSuqapcZugmU38EILeWxYWco/c+g83x9QuuS3m5p2j
 TBZU1QJtsh6xzP4eXgu5Xa5EIWGkGbh5nl6kiZFzpxay0R6vSh9c44kVeY3mrA6D+/MZ
 EVu3qMfLnWooJdaQjR0pzJ0mtBKc2k+nZXNEL/vbosDVLmDnZ/PtOosxgqjoMhL9tE0E
 7k5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ix6oepBdSOnDlTmqvq5nLffYb6atfx/6y7RgSV87AWo=;
 fh=nOTuJrYEKMwu0YQqcaYcu2VeTxn+oBYYYXmrSbSfILQ=;
 b=DSCqcbdNUFaD+nl3i9V9n18aTmaac3x2bYot7aaQClGerV5UCyFzeEbuVYSH6rgz6R
 JZ8WnYx8gD0+WDErCc/C0Wy3A8EMalx/KWeUIhsimjDsA03GG4vQN+O0iX+4WDOrxWQJ
 ST1bZHg9+YrpdXr7IktMMrS3C3SOeQzxrFcDlteVOetmrHlpM5gS/Sr5oTYzRbdeeJj3
 ojvNdioe1ouRoYeDYwl+i05MV2hdOJSVkYIVM7OwH7Vm6nOdzWRGwT3FtJjilhjn75hD
 3wDxMxebbdCDZQQzbv8Qn6zHxo0QBnjxC51oF4AnU39qi9rHCl+wk7kTMv9hnrObR68c
 GD/w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793070406; x=1793675206;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ix6oepBdSOnDlTmqvq5nLffYb6atfx/6y7RgSV87AWo=;
 b=jzHtSqvhXn/gV393F2K+akqIsB61IFtL1Cyv2L3VxwtCotV9ynT5VbAC5r1qnKLwqH
 P9p3+aD6VXCx9Mc5Fpn2FOjltAQHnW6TV3RIFLZgmvjFkMP3BxRfOI2uwlWL4NdaDnNg
 3oW+0vNQczUbCj/mqmYksFJr5rhARo1N+dHRXq2v329WPbIW9hcQaOPRIm6fnzc9aSTP
 FI1HxW965kbjH9E/9QDO1+xZrLsjzg8m3HE51AWsCOsQG8jUGbLI5HpZpv9+gYmc/ToP
 DwWwAz0bTDoOkabVHrS0DRBrZ+GGoZB0JxQ77pvKNAIlWUgijtGhuz3tYNUIoJ+557VZ
 92Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793070406; x=1793675206;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ix6oepBdSOnDlTmqvq5nLffYb6atfx/6y7RgSV87AWo=;
 b=g8IfJNgV/RoP0G5g4nIymxv73RMa02m5ibWjiBsYbw1t0C5jRcaf4Kn2VQUqusMfjh
 eSb2P0ymZgkx9ldG1IgvL2BL1fAokaTyH/iebeSCQrIDTBVky7/WEWE7a6CMpckd8e3j
 BK/I4IPRwMfNKhNump0lwYoO8pAGAAfJdlxOqjpyCw1zMFIqBeaEqOpFfIrnGoOi9vLf
 pIBpss4+bYdTuIDHY3qjcDx8kWNMPgAVTZngwVzMcqPkQPx6YpoeQDPW4U75u/sgRG4S
 eVEV5iyyr9Put9EZkljE/ZF9xRgWSUri4qegxuLw8HqVtd1nHDHfl3qeVWB/TNC+lNix
 OZNA==
X-Gm-Message-State: AFq9FYIt5/aXvjGkFMSn36J+GQ/VehVQC0IVUtl3UYMRhSqbmS38l8hC
 K59z583XyM2hfmF5X1NPVOztAs+vpGSsk3eKG+YTscc/BaipriuME2ZChWMks1vRXIeh7z+k/3d
 ZXObdz21JiFhHdd7ZYZFELi1teWPcnZg=
X-Gm-Gg: AYBFou0Oep+2tgNkPMAcs/klm532gIW3f5wPJUOGuPE3y+79udViRQppmY2lz8y+bt7
 3nmhZa5QmihefxkwtCrIMsa2SxDwyUsWyqZrR7uxkOQ3VY9S1p8QeGpBpQLT6D6/cikMP4rV7pX
 yRptIj0gf9CogNJwDxIQFn9EUocuN4qLn6N6H1mQH/NtBZCUqY+c9o5WJYWrCNqTPgmT/6q5Z2b
 W1VkXF1fHegqZrNX6cpxEZ0Dgbdb7WeVNuWGSo8YV39ozTxB2Pp2JvLy3Pspybf5MIbjnF0hpP5
 ummQZJ4igx6AvZIzfK8uRmatkUitWyAK3N9UwYKeMqbve7/9TpPkcRoEf2/KFAwjSqkVTFLQNRI
 +rHV7lbcLAAMzg06nqdewhvKfr2FZoy8sCXaR
X-Received: by 2002:a05:622a:5cc:b0:536:2816:dff6 with SMTP id
 d75a77b69052e-5383b5d6447mr131889331cf.60.1793070406425; Mon, 26 Oct 2026
 20:06:46 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAMPWMbrVO9-ZVYQu6Y0GSA37OXzTrg+nyZObyxQJKtJvBErmQw@mail.gmail.com>
 <20261026142950.GB624796@bill-the-cat>
In-Reply-To: <20261026142950.GB624796@bill-the-cat>
From: terry zhou <terryzhou05@gmail.com>
Date: Tue, 27 Oct 2026 11:06:35 +0800
X-Gm-Features: AclHuK9J41ohFEVpk5e8ULEcUiPmx8HZx_PFVP673_sPGFRn4OsvtRJqcTg3QII
Message-ID: <CAMPWMbp4EBpAz0bfAVeRcMqBxJW8VMvchbP-qOzufws2hn-P5A@mail.gmail.com>
Subject: Re: [PATCH] net: preserve the driver error in eth_init()
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, jerome.forissier@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 27 Oct 2026 04:37:32 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom=EF=BC=9A

Yes, I checked that the base commit includes ff448fa9a1b8.
I re-tested its change with and without my fix using downstream
SDK U-Boot on VS640 and SL2610, rather than running the exact mainline
base on hardware since these boards are not supported in mainline yet,

We are now adding SL2610 into U-Boot, below is the first patch from
Richard GENOUD <richard.genoud@bootlin.com>.
But only few interfaces are ready in it:
https://lore.kernel.org/all/afb22430-4cb1-42e8-9b22-5fc57eaf7625@bootlin.co=
m/

ff448fa9a1b8 sets eth_errno when device_active() is false. In the
failures I reproduced, however, the device is active and the driver's
start() callback fails. eth_start_udev() returns that error without
updating eth_errno, which remains zero.

With ff448fa9a1b8 alone, the diagnostics showed:
  VS640:  start_ret=3D-5,   eth_errno=3D0, active=3D1
  SL2610: start_ret=3D-110, eth_errno=3D0, active=3D1

In both cases, eth_init() overwrote the error with zero, and DHCP
continued with 17 BOOTP attempts before timing out. With my patch
added, DHCP failed at initialization without entering the BOOTP retry
loop.

Thanks,
Terry


On Mon, Oct 26, 2026 at 10:29=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Mon, Oct 26, 2026 at 10:11:37AM +0100, Terry Zhou (Synaptics) wrote:
>
> > eth_init() overwrites the error from eth_start_udev() with eth_errno,
> > which may still be zero after a successful device probe. This can
> > report success even when no Ethernet device could be started, causing
> > DHCP to enter the BOOTP retry loop instead of failing immediately.
> >
> > Preserve the return value from eth_start_udev() so that callers can
> > detect the initialization failure.
> >
> > Signed-off-by: Terry Zhou (Synaptics) <terryzhou05@gmail.com>
> > ---
> > Validated using downstream SDK U-Boot on Synaptics VS640 and SL2610
> > Without the fix, driver startup errors are followed by BOOTP retries.
> > With the fix, DHCP fails without entering the BOOTP retry loop.
> > DHCP succeeds with the cable connected.
> >
> >  net/eth-uclass.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/net/eth-uclass.c b/net/eth-uclass.c
> > index 07ec59b97f0..18efbfeda71 100644
> > --- a/net/eth-uclass.c
> > +++ b/net/eth-uclass.c
> > @@ -349,9 +349,7 @@ int eth_init(void)
> >                       debug("Trying %s\n", current->name);
> >
> >                       ret =3D eth_start_udev(current);
> > -                     if (ret < 0)
> > -                             ret =3D eth_errno;
> > -                     else
> > +                     if (!ret)
> >                               break;
> >
> >                       debug("FAIL\n");
> >
> > base-commit: 8649a54d301a4d0ac526324c7a7ad2574939ff27
>
> Did you re-validate this on your base-commit? The base-commit is after
> ff448fa9a1b8 ("u-boot: fix error check in eth init") which I believe
> evolved from a patch that looked like the above at first. Thanks.
>
> --
> Tom
