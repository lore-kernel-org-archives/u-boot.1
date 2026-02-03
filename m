Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E63E8783D
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 15:11:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF8C184563;
	Tue,  3 Feb 2026 16:11:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d0jQYTuw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14C4984548; Tue,  3 Feb 2026 16:11:10 +0100 (CET)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2857B84548
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 16:11:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-385bc6910eeso39733291fa.2
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 07:11:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770131467; cv=none;
 d=google.com; s=arc-20240605;
 b=TEkuUJAZ35wp8cz20uH9KDmUXEqGXErRoOMzh8Ccu03jnnygGkzo2ISwsWNg8CPCxW
 a7mHjzeRzweyCL4vjDJU0mRznTmXG60M5edalpRfbozzGxKvE+aNRiF/MPeAyVNRViP8
 G3adCodxgPfW+x0Ylcd11MP33k2bHYMMGR7F3U34EGRrrdPbNJ01fjqyLwh7qbVU+n1H
 ldtjIkkLZ9ZGY3FFq7FSLjz1DAVn4dIER6+zGKnI6NMKe3SpB8MFfyZANHxTRSetgJsy
 AD7bwij0SyAWMf/MarxXgNCvAUnoaOId21omHWg1LWLwzNUCSF1DdxJj7xakuFh3FrSv
 lYKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=z86O4+oMFfmy2pheyLw9ac4gHe7Ix2trLdMNWVrPnsk=;
 fh=BDeYLgfEmINH6mROAjcYEyFfgHkyLtBCZd5Z80tejIE=;
 b=J5ctWB1xCW4cBs13P2MpLQzh7nA7fJhy0yzgefL9u8smdtKV+tJYZNZ4jG52XL0vqF
 xoSp6pJxcVQ6nxrza+TXs/BBzT/TI1ioLYOxTssP8qfYRbMZNARX2Pdcp8OLTxWtgjYN
 J43EQ2QPFzzVeH6OXZ4d8tMl15GPtNYqObwcRH61KGBbpfFMx2CLxlZzbSPTh96BTCTW
 LMCOSRm91YIq7PI4DUW0/zLJipU5bNli+X1LLMVN926wh9rw6XWd+1JyxNpAcET6Veux
 1RFHssooTb8YWNFm7ysrjYIKEGUBsKdgi9WnHeGrCapJLoyL0zPnwxy3707kUN5V5iDC
 eB/g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770131467; x=1770736267; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z86O4+oMFfmy2pheyLw9ac4gHe7Ix2trLdMNWVrPnsk=;
 b=d0jQYTuwJw3nmkKZcPhWRunJqGd7joJ7Cjk5fcxWlObxaZBUwwlhXCLwD5bdroqzPp
 WuOWktJw2BtqLTtcCo07S65jETSjdEY5MFBAdhOLz36039/hUWDEcr0bcXkhXhtVgTDH
 zjvxmuMUJWASV488lpay0fA671QVh8j70Fs198KQLltZEzo0iYwa5aASC4NuZHUzLyTp
 SPeQxUohxaXVif8saETryHKWxVOO67OcGBF9uZfss49H61Y6/BQkj2HODs1x7VLZ6Gqv
 4vKsZossiLo1RXNr8D8PYLypWa/bHUT8mK4UVSin9aLWqYJmwnrVn7nh+5HKy2PJdi3U
 5+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770131467; x=1770736267;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z86O4+oMFfmy2pheyLw9ac4gHe7Ix2trLdMNWVrPnsk=;
 b=Is1SvEs7pT33oNnLTcAnIIQmd8q+Vflpq3/3/AcpkR4hnI5v+07L0jfsz64Zwu9Wuq
 G+M9sfnyUxeZnLPKlFDPFR2N+HE6RULDElz9MMvF/8IkwuqheVTZR52+g8KomT/OoiSX
 4skk3ugxaWply6fibWP+zZT/fjrlfZN4mOsDKwwFzz+D6yZW+qHtcCN7D4e/wykICLt9
 izGg0J/7tpQfCv+HKMvIPNbGqb/AV6mYfwvZuxvli+CRsLofYjpbQupneQwnodPt1fhB
 R+nSStGAXt4cd6RC08dz4WCwN2BmQfmrhhRyTcEqRXjwNuPDEnGg5Kl9//UOo65dFwfD
 a3HQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDPFs18fhKB7yLJR49/7JTmQE8hRC1dOiSVnkxdPtwzZI3F7Z7VlOOm0FwYsrWUuj+7/Ty234=@lists.denx.de
X-Gm-Message-State: AOJu0YzxOTyANL6BNN/KwGPgNv5ARol1vCVGelHnF3qKpb+k/NhWGa+9
 l7OPLdnH7mF6HNjn4/PLKtP9R5YAmmKPfucueh39ZGByg/TmbEmlPq6MB4fIto1iopKAZAMNwg3
 M/uRESec4+v+dP98wOsUi3D89fB6P4Cc24RXC
X-Gm-Gg: AZuq6aKazB2b3jkHjuS+gQLvwoe67YFrl7lKVf4CV8aTZrjVAzcCvThpnVlz8/Yi9SA
 XKSZbG22aUTWqkYuLLJHSaoeeijcEag2vWdxu1O8CfiE29Yz+UmYNaAg5I+tQzwK6Hui0w8Yx3A
 ie1JmXZvPUtFrfi9sDCzR422pKDZ+1hznuMXmOqNrYlkV9Kxw4BZQCTbGl7oeG9kQ81ydBt3Sll
 DLe0j/mif8fq+JGCiZUUCCs2HGdV1AOLr9DWB0r5B2fnI5jI41aT6CPJbOBUFSKXIBRm2M3SqUL
 HzgfVvx4nc0UaJgCfi9nGvNWgBA=
X-Received: by 2002:a05:651c:f09:b0:385:f454:68d1 with SMTP id
 38308e7fff4ca-386466f6b28mr50982351fa.43.1770131467083; Tue, 03 Feb 2026
 07:11:07 -0800 (PST)
MIME-Version: 1.0
References: <20260201004456.763107-1-festevam@gmail.com>
 <9ddc1e46-6573-4952-8abf-b84617964d38@kwiboo.se>
In-Reply-To: <9ddc1e46-6573-4952-8abf-b84617964d38@kwiboo.se>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 3 Feb 2026 12:10:55 -0300
X-Gm-Features: AZwV_QjUM-ehVIbM1FBYTepL6NcKZD_MXB7NaoE7e58TuZ1w9LCu9FaBYDOHIFg
Message-ID: <CAOMZO5CBi4rJ3tscXiij2Z6YS-K+MXUg1WdQ68Vqr0sh7dcT3A@mail.gmail.com>
Subject: Re: [PATCH 0/7] ARM: Add RV1103 Omega4 board support
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Fabio Estevam <festevam@nabladev.com>, kever.yang@rock-chips.com,
 trini@konsulko.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Jonas,

On Sat, Jan 31, 2026 at 10:12=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se> wr=
ote:

> This series seem to handle the RV1103B variant and not the RV1106/RV1103
> variant, please name parts as rv1103b to match vendor U-Boot or is the
> rv1106/rv1103 and rv1103b fully compatible?

Thanks for your review.  I appreciate it.

Initially, I was unaware of the differences between the RV1106/RV1103
and RV1103B.

After reading your message, I investigated Rockchip's SDK and
confirmed that RV1106/RV1103 are compatible, but RV1103B has a
completely different memory map.

For v2, I'll change the references to RV1103B accordingly.

> For the Rockchip platform we typically expect e.g. dt-bindings headers
> for core parts to be upstreamed to Linux and picked from dts/upstream
> for new SoC support.

> Please at least send out clk and pinctrl dt-bindings and drivers for
> Linux before a v2 of this series :-)

I'll work on upstreaming support for the RV1103B in Linux. I was able
to get some early kernel messages via earlycon, but the clock driver
is still not functional at the moment.

Thanks,

Fabio Estevam
