Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D7E606A323
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 08:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=weS5cuo2;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lAZiou/3
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 336A660690;
	Fri, 30 Oct 2026 08:24:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tVjTe8nRvblo; Fri, 30 Oct 2026 08:24:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3C0D6605F3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793348653;
	b=T/C+zCflIfanhnYMOUjAVgQK0zr3GLXDuqKnp+x5rBmTpycisZPbF46rtTMrfU5om/8p
	 yqNYCBL7E6+SzNJgQfmIrK6mezbb8hZ/rz1r9hvveFKO1Zsp1IDEtGRb8Wz/qkWxelvOM
	 IzUlgWwi7VDcmLbx6nbnppCbo3JbOuq2rgLqbWCGdM2P5iRkr8gRSwnNRweqovLakZDxa
	 p8xoWyx+l71cqQhF6Mko/ld27oCUs3VzVkn+rm1Jlb9k33TwGV+Xt8y8Vk5+1XYIdm47r
	 Rk3BhAb6iVf2PrYtsuzLyPpZWh4AY5oMKGQWO4pc9F3u/xpYXJ0MSo7YqqCc6vi1snQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793348653;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=M5iCJ7wQi39z38pgSlvJxiv5/f/NeI0RjM9b25srCqI=;
	b=WZuGvLcvZbEqx7xOFP3q44P63IUME6XKjw8cDzNDELVE7vAIYfghasAaSmUt6xGJ+aTc
	 JDAtrkptN8XRTzEPE68viKEcwvaSOiUXishu8V4lN3wNGzWFrL0H6oGuh3WxOQ56Dpvhk
	 6co8TbbGPypqDyOEWjV1W/75ho0YT9h6P5JYAHrXKSm22BU4iSlA970EnlQ5HThKLjjg/
	 WesPladjelJF5VF1FVoVvAUyTFEQ7totE5aPZFvov7WJ4gC4thgshBk3TgwoqzwSE+5Jj
	 SBOMrwtjJrXnPilSKsmt6avSjPqrlGfWcAVRToGpXYvbh6jFM9KvG+66KMULZeWSlaQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793348653;
	bh=M5iCJ7wQi39z38pgSlvJxiv5/f/NeI0RjM9b25srCqI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=weS5cuo2ATzr39WSN3bnrBqS8xPHHZ4Ej7ktehFZNz3J4bjFtOXTO3Yym1Bsw57XP
	 oJ/q8SMRHdg1gQj026d6yQThk6gkGK1MYxwfzsM6qJdx0TuU1VIr78+IEC7JVy9cAh
	 dVht1FkdScpyayRpZ6+/tdNQpqqat4VcKHKW7NA+lwMoElbqWvE+eEQPNYeqvznwfk
	 EQFOctt39SLhPfKogrO0u/72awx/kNqo2GtXKUNkB2ZJ93ClQ2HeoeeQ6H4R0F0nnt
	 I1QLQm5aoy/uPnKOoYmltPsMvDe8roRb+fuc0+84DLMBNzypcRfyngNtodWIAwEjhg
	 ZPP8N4pbwpSrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C0D6605F3;
	Fri, 30 Oct 2026 08:24:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A5C26D43
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 08:24:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 979E940A9C
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 08:24:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mc-oDK-1Hevb for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 08:24:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9667740A93
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b130"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793348648;
 b=ZcCAvJuJ4EmpywBB84g5+UASIlzNti2Ul4xsCCypBOITOO50QRcg2dLo2FLoYSCYTI40
 bzb9CAWKFQzT9XTpUX6lfxtFFXMGH+EjvjSDFyT/u0oxEybsGbAl1TESz15dldA9EIrw9
 aqn96qMy6XMfWRa0g6FprlM3vVYP0WG86A3pjjzZNlWBu7xqb9r4ggyYIv0zhI6zgNdKG
 WHTiXgkWDrRnpJ4xNWepG9SpbCwpIHaTHJc+WQacnZLRrUp5dR02LSzgt6CwQIRwyqAmD
 NohCPN6Ie8SQ4hRJ2wJenaOYk6snkg1dXR2IF59jFduaz1h1yZxZNPWVNpdx24QTH3A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793348648;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=M5iCJ7wQi39z38pgSlvJxiv5/f/NeI0RjM9b25srCqI=;
 b=k1u8GP53G4F96tXwA0nnra7I3FKou/JMir8KePCQyvMBtYhUusi3l8G6dorp0p6NJ0xo
 FpCyxMgZPNAFQjPFpP/cenoxZcpkp0IbowjQLP2yEYlEc03/kjmZL0hnv7M7WgS/bl6NB
 kMij4dDvVyj2aMGkgc8Ry1phC1kJexe/KDLBsEjWbpvTNyBsX430rK9GOLLrq2tFj2YGj
 mCDvtFzMxvNXRo4IJl6Y4ve9VSRrUrSMQ2RaUvYv5mKxgu5wOD53G+ht7DfvImRG7BZB7
 PIqRaL/AS8bXjn3rSPZIS4b13YDezptpmaMOHr7OdjlZ6rf8Nv5lQpDzugvFk27FW8w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b="lAZiou/3"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::b130"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b130; helo=mail-yx1-xb130.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=lAZiou/3
Received: from mail-yx1-xb130.google.com (mail-yx1-xb130.google.com
 [IPv6:2607:f8b0:4864:20::b130])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9667740A93
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 08:24:08 +0000 (UTC)
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-6798d4ab549so368021d50.0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 01:24:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793348647; cv=none;
 d=google.com; s=arc-20260327;
 b=a57rB0z+d5oSJk+aGHsmPLFMQV4j7ew2BpblH3cDN0W/YsrKXHAO9WDdPIftNnXbPe
 f1YLDj/ZCrEt+0XJi96DKBjaY1wRwraRK3Bnrvj2/BnQ9FJr0EPQeE2GyUizI1J+g8MV
 ZZq9IdtNySiv1HLXrmydEMPozrHw7z8avL90ziROaXAdhrIRVs9MZt+PD90smMWzQqTY
 /gZJA0BXZcbCIpvla8/g01TI6mOSVAJBVuSAEAKwxuWGIx33P4nReGeq13I4uMLOWmZF
 6BpM91KdHRMq+GKnZ2aDz9oqxLuWicl3r+MkSwNSTxJVbfO9L+yjdEbyUv+zT4JaV9JW
 m0Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=M5iCJ7wQi39z38pgSlvJxiv5/f/NeI0RjM9b25srCqI=;
 fh=wUTxbXCZe6fGB4KbRPZJfz4dHrMi6cdcH7MsBfEGPcY=;
 b=mFzFTRcEkQH6Oy7XTdvw/G/u4xuttvTsSurI1/cwIp47xQv0m/dFVRdkxGx9YTsemC
 ELz9Y9wimW5niQIVv69PzotiCAGDKyP6SmtyVeVmajYA1r2k6nk1W8xzKI6dPfG+DRFj
 JhM5n5N9jTqUdSqAbOEYhP8DLzyPG8d+mIFPG9xUlAxm29J0SNwJZEqYtBCXyMMdjadZ
 qc25A1314W0lnq4QMRdaRpUGeMpc+tsdlX1FVtiFZ7R23GxyjBDG2WmBexbf5BjN3gMz
 epImslMV6vaRYYZWDyZWfMHGbTpgj7pQnLGlyZ/ZhoAXfbHmQRqddHnqX3tDXdDkzt9J
 hifg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793348647; x=1793953447;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=M5iCJ7wQi39z38pgSlvJxiv5/f/NeI0RjM9b25srCqI=;
 b=lAZiou/3cYgOi/L57jcxYFcDMwL/4l0P2d+ZvX5a3UCzYNWg9kDCp7Ouupkd4x2Wwz
 DBHB5VOcCZYvNvxOlK2P26MmCKEmPbC8n5tjXlAw5ckZYe18CTjclss0CjVhYRzuiGCl
 FOIfcgJbsDvUCsnd4h/dwZnDcGLQ4v9aRJ1noHSCPw3G9YjpOP3i3wxLjxt8sdQp8slk
 kW1Hsxj8ple8EsCZp7M9fFubFV+TRfz+4++OziA6fnSvAdKf890LdB4gKnOXhgKeASDs
 jJs2Ythsm2xEs6Lwqu6/EVSIUU6782hLj7v/OEyey4LjGox1Jl7hoMqiMVnQtctEDlj4
 Q2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793348647; x=1793953447;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=M5iCJ7wQi39z38pgSlvJxiv5/f/NeI0RjM9b25srCqI=;
 b=VGGWwd3Q3+eVCeNLz65roIrBvY4ex7LLwdzlWX8fgptytDRoAdax6NqzYl+Wznyg9p
 4h0MmLyjlQTSEzv/1zW43eYm/3Wq5dIMGptGaImp276znywxEZBb5f08emyhH0efLWj5
 p5MD8qwE+bqUd6exsBx8FOV4lElRyK68uWHxP77+DMweDZVLd5HXdmsIFi2so4aJObZU
 dPc5u5SazHzIyl+lMvA3SsYPyBVRqhnNv3etlyekYOqGt/KhxwVG8SlUrU2pZm/HyOil
 vkBoO7mjOQIiQynCSXHevAXB97MIx5dU1HFXYgx7rcOTPYF3z73jR9QNQ1zR7RW8WM88
 YliQ==
X-Gm-Message-State: AFq9FYIWhGnwUo5XbtRo257IQLzEx5VLaxy4YUDNrht4473VyNCpPg+A
 Is+7kSYICF2axhhPezY/PnL4XXxYpeCAJLlR3RZp6/uerWxciLNiE6F8PyLhrka5HB5QffvOZfx
 qrgxp1MPH9nDrIYSzGvsHpDoAh9LVxyeoIqKGMFE=
X-Gm-Gg: AYBFou20cf90dmOnf6m+hCaklBJnitXMvIdN7eHxE3tC8UzHlOK6/xTMlFc8SuLrDeI
 YameGXOJIcsxrq95MCtGyFHbBSqT3k9pDNL3I1k8HzNqkKpWyWKSABWWmQCdloKJPYfufWiivHx
 amJ3IC/MCn5FMfPC3DlBPtBA/Z6K/BGnQFwH884a+e+2sAE/VqG4iEGurQhGHCiP9R9emai0B5Q
 fNPn7fadigdMaW8dC4J0fQCu3a+TM/cdWTeXJi8hO8IRtdmyQMsbu2dV3eD7zscakmKs2fSvpMI
 dfghC1t3H4NfgkWWMqnU0AHuUhhu6fr0qT2l2K633EF8x1rRUlSvHNr6SHVSve6A6vq2+ENCEKQ
 gMY3try2l5x2vyznm/oEjWre2JOqZtyb5qQRf4hXuPO4GMy69ZTiAAFXVsB/lZ+taYY9zpaMIKa
 OaQFQ1JsLHkrLLyCkiklQtik15lS1g/2vJhboDeqxNQMiZTTufArMYVCe4
X-Received: by 2002:a53:c08f:0:b0:679:b98d:9b65 with SMTP id
 956f58d0204a3-67ba4ff16damr931496d50.35.1793348647040; Fri, 30 Oct 2026
 01:24:07 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261028121258.572-1-pepe.schlehofer@gmail.com>
 <20261028181244.GD2677024@bill-the-cat>
 <CABPHAJweoMq-H+yQV_vzhbEx1=RXcYxxqz=_qoHPqKtV3ncWQg@mail.gmail.com>
 <20261029173022.GC3011578@bill-the-cat>
In-Reply-To: <20261029173022.GC3011578@bill-the-cat>
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
Date: Fri, 30 Oct 2026 09:23:56 +0100
X-Gm-Features: AclHuK-IqT23Dx93ZqJQTUjgp6yKL8umCc-1FPqimOA1vaIY2QpZ13xKX8EuwAQ
Message-ID: <CABPHAJw9n-0bw+sO2-47UoU5HRaOZ_NBei4yqQGYM1FiBsy+dQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] macOS improvements
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Stefan Roese <stefan.roese@mailbox.org>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Simon Glass <sjg@chromium.org>
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
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I got to it sooner than I expected. I tested your patch with my series
on GitHub Actions, on the same macOS 26 image as your Azure run. And
yes, I could reproduce it there: with HOST_TOOLS_ALL=3Dy it fails at
crc8.o and the kwboot link without my series, and passes with it.

So I've sent a patch that adds HOST_TOOLS_ALL=3Dy to the macOS job, so
that it catches more:
https://lore.kernel.org/u-boot/20261030081436.86780-1-pepe.schlehofer@gmail=
.com/

~ Josef

=C4=8Dt 29. 10. 2026 v 18:30 odes=C3=ADlatel Tom Rini <trini@konsulko.com> =
napsal:
>
> On Wed, Oct 28, 2026 at 07:36:22PM +0100, Josef Schlehofer wrote:
>
> > No, the issue should be there with macos-14 too. You just don't hit it
> > because tools-only_defconfig doesn't build the two things that break:
> >
> > a) kwboot is only built with CONFIG_ARCH_MVEBU or CONFIG_ARCH_KIRKWOOD,
> >    and tools-only_defconfig has neither.
> >
> > b) The same goes for crc8.c. It's only used by gen_ethaddr_crc, which
> >    needs CONFIG_CMD_NET, and that's not enabled in tools-only_defconfig
> >    either.
> >
> > I hit both with HOST_TOOLS_ALL=3Dy, which turns these on.
> >
> > To be honest, I haven't tried macos-14.
>
> Ah, OK. Would you mind testing your series on top of
> https://patchwork.ozlabs.org/project/uboot/patch/20261028222745.2775066-1=
-trini@konsulko.com/
> And then a follow-up to your current series to make that test we have
> build more, so we would have caught this? Thanks!
>
> --
> Tom
