Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C396BF5543A
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 02:12:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FE9683E61;
	Wed, 25 Feb 2026 03:12:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IleWri+f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB76D83E62; Wed, 25 Feb 2026 03:12:05 +0100 (CET)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 093B283D8A
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 03:12:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-38706b10b3bso61800291fa.1
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 18:12:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771985522; cv=none;
 d=google.com; s=arc-20240605;
 b=IIg1Ab0tj/UiCkOZKDDvfd4bKDbhFJQIGG6GgiZ5cScjJNQpkHnTh3lHgLz/uOL/vT
 a/jS4NIHmYBdesQlVH/CULkthno/ZZeRxyovV/RVJWxnUz8HTcaoHy/EfLgE8FK8nuRc
 6ZltvDKxA0jtR4J7DBJQ2clGbL4yXuvrDcVZeHR0EDMPv1lWBBmF0VLvEqPD1dCMqRdL
 EXdKvwJXYfKWjFQ8GHeSZed/kRM12X70PIxNChDSsddfQ6/1UVeWbHaEMdzk7k2W78wX
 WtSVPxTbXsZgVthR5LT4U5nat0oKu5wkXVAVqvGXQnjduXeXw31fQ68nW1j6PDkv3U99
 hywA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=o0CnUAgHSJUUad7/B1faEWh50lbFGnZZLZqR2hEYmBk=;
 fh=AuDiTlI0tnweyyQBHRSvAo6ZtNIXxucrGMG0qe7ym8o=;
 b=XTld5zkmrrqf/k/d/fTHqxsJ79c+kGd4Hc5zqxx1o9tJizICIT9nJa+iLcqWjwyK9t
 BsTEXcThqDlaLVNi2XWzwENusXk+7LC1NGbL81zOhjT/BEfuxmQPIVQ3GIp88mCgmSOv
 s40ocWRTeXxcGZ7P7i+k/WOr2CpV3YcYVhsmF7cG4cEBBrSAQK4ghINUQjU6bx7R7OmS
 u/kipDi6w5HzWaRAK36j/cJL6PhwvRRgHBoGFdv/YXpY2ZH6eQRXo37Kwh7W0vjYDeQa
 l0+HoaAORRWt4nlTk/qtiSQ4zqxJL8tcnH9d9nHoSax4eYX6T/XmF8iwr0m4G4szviED
 3keA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771985522; x=1772590322; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o0CnUAgHSJUUad7/B1faEWh50lbFGnZZLZqR2hEYmBk=;
 b=IleWri+fBTKWX6r/AXKzx8j66eJDNEenoRoe0cZaVN3M0VDg7r+qFoKSgJqywBSq/u
 c4q/RAh72QdNwXv9jgGhePcxjj0e8hio92DXOX1olGLc3XZwT4aEMcqXCZwj4/dmgVb2
 QTXlJy/tYhuJ/thswOJMef+u674DFzv0Hn7twgJjNs7gZE7OgQHIKzBM2Yni3WEdTviN
 EHEmXY+Ko4D+JNN+UYYN8gwH97iSa0GuJHlAT8t12bw1xNg7jkMB4sDKZ5TKESipn8Lu
 enoPizgZrqbfK8R5e4cdFREtIZUluL7qcbP9mmz4uuMZdWBV+9hp2QaYHu9yfJYbA+4S
 5j9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771985522; x=1772590322;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o0CnUAgHSJUUad7/B1faEWh50lbFGnZZLZqR2hEYmBk=;
 b=kZvkFBB0N0yCTowdV2Ljwn+ReZYe77TQPTTV6VQy+769SYZRJOmvcvGom0PRytPbsM
 5t+osEuZ7wmnYKwkxaz1/+xa+zxHFFb/ofqltQuDQs1kx+AvFtUosaXag663s87vooUZ
 fZjU8TOr2iBw29ezZaZ4tk2rnWWXwjmIMesgqTdUKLS3JS0m7DYGurkXFKpECZe8CLan
 mDUeV/jDAeE3d5/nNbx6slFUKFhlBm7NkfLhc+d3fuGG/aOXoG10en13uSwimgm2c5qI
 1g1+qN8HE1MX5u08fK7N0CbB+jj+95e3wxFODbwTWRzVAgTAwGnL2trBqBjz0I3s33U+
 dJpQ==
X-Gm-Message-State: AOJu0YxHcOAO8ZWXnxQaY14N4rKgZDz9Xps5mULe0VIvB3zYWmcpv4tz
 eaUC+aBsuWqYqxUbhKSubK1U7ISqX/ggfn+3MRxudTxSxHPcV6sZk/m9e0mRs7KRy07lKvL0IKt
 flNoAQtpf0YdtXkV2emC+qrCJkw84y8A=
X-Gm-Gg: ATEYQzziPPonuacGRxLSqYLvAIUpN7vdbANLg5tczJurbRni6Q2fCprxlxUH+iJ1Liq
 f80DNmy/4+nWph7ZCfMcsp4yfaoakjFxjPrmUWk5UYWk4+L6PcopE9pP8fMcE8+hvlZS1tEBn7q
 D3jWytPPWbYrAM1AdUWz8GIz0ctZJasy5apYsoO6kuIdPggzV0JhcgfFwpjhqxs/s8f0ZL4C17k
 WS0Qwx0w6kh9/ERLRHq/Zh/21ATe4hGDu6HRGgOuB/++5YoMz4da1dheoRxkVKXUJenhVgKVST3
 jJGZlVpmvcS74DUX8HoLRpRJuIg=
X-Received: by 2002:a2e:bc87:0:b0:389:ddc6:a4fe with SMTP id
 38308e7fff4ca-389e2d2591cmr2467241fa.24.1771985521982; Tue, 24 Feb 2026
 18:12:01 -0800 (PST)
MIME-Version: 1.0
References: <20260223-phy-usb-exynos7870-v2-0-5e91a25ef42d@disroot.org>
In-Reply-To: <20260223-phy-usb-exynos7870-v2-0-5e91a25ef42d@disroot.org>
From: Minkyu Kang <promsoft@gmail.com>
Date: Wed, 25 Feb 2026 11:11:45 +0900
X-Gm-Features: AaiRm51j6H-T1QT2TsOyEq4LkXu2CikWaYC-l3_nv3fajhYC6vguL2OCdRhHi1o
Message-ID: <CALrBrZ3q6qJdyNO1GKDSgF3tXndcAdSRhNsQ0Nv=eREEZN8okw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Support for Samsung Exynos 7870 USB PHY device in
 driver
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi,


2026=EB=85=84 2=EC=9B=94 24=EC=9D=BC (=ED=99=94) 02:45, Kaustabh Chakrabort=
y <kauschluss@disroot.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> This patch series aims to add support for the USB PHY in Exynos 7870
> devices. This can be accomodated in the existing driver, the patches
> implements the ability of multiple devices to be driven by the same
> driver.
>
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
> Changes in v2:
> - NONE (collected reviews from Mattijs, +cc Marek)
> - Link to v1:
> https://lore.kernel.org/r/20251017-phy-usb-exynos7870-v1-0-5885b00f0c87@d=
isroot.org
>
> ---
> Kaustabh Chakraborty (2):
>       phy: samsung: add enum for variants based on SoCs
>       phy: samsung: add support for exynos7870 USB PHY
>
>  drivers/phy/phy-exynos-usbdrd.c | 271
> ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 261 insertions(+), 10 deletions(-)
> ---
> base-commit: 5e7624979083e2bc163e18165452d8ead462b58c
> change-id: 20251014-phy-usb-exynos7870-c2f2ac44fd65
>
> Best regards,
> --
> Kaustabh Chakraborty <kauschluss@disroot.org>
>

applied to u-boot-samsung.

Thanks,
Minkyu Kang.
