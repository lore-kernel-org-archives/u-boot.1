Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA9BCCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 08:15:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 32D2560612;
	Mon, 19 Oct 2026 08:15:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kGorXMgSWMMN; Mon, 19 Oct 2026 08:15:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 69F8460606
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792397712;
	b=GN+g7UKBxnt4zO/MSO9w8w33NJZ+We0lx425YEZ/5GUOnS8w1HuYNsZq6Z3nfyjK4Ukq
	 XKIxnLnB4ZcYEBJ2aWNYHBd/YhVhKu6ikT7aE9jBewil982cAXcBXttL6ANDoLWDPPIFz
	 x5b5dp5+eFhbY8VsKhqEJW4CpajeED77acpTN9iOSSmVhaTPVhIJmbDR6mHtNTDt51oAY
	 +8CLqaNJlR8sgOyNe4F2hQctZIqrDuZO6KEj8gJOuWi8krq0kNPcWMxr6965rQFBXfSUX
	 b3OJFuRzchYZFayuAEZ4lsimakTVMoBXBQEXovOk9du2KNUh2q3dF1iZCT5Y9dR/K7g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792397712;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/aTC6Chy4DbadkhRfFd9vxCLkJHWKmhJ0j/Y4pHvzXw=;
	b=MU3A0l1Lc0Rf+ASB6ZWpo5xwO3P0i9SA5G9rJv+69+y7qmy7qwnFPN4Sc4CbDCU0XUG2
	 PI9kas9alpBjV/sJ3oixV6KyhHMVWe2MmQLAVKPM9p0D6JG/bF3K+rSLPPksVq9aeKEsk
	 5SkyFlvvF3O9hJX54XTcgH0/jgVX++Mm2SS0TsBS44q/xpq9WeHInDpl0WoXPzFCxbU2X
	 ZBV6wypG5WQp8j7XD0z5HGiKhGldak2h/F/HZAYnFSAL7Nu/StYaquD4cTgX8LskTuHH2
	 ICwsgtZDPYO/HKBfwCWo7yKGcu64aIlM2XFZPBD8F0OMIb+w+9CyPvBZFaf/sqnHRSw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792397712;
	bh=/aTC6Chy4DbadkhRfFd9vxCLkJHWKmhJ0j/Y4pHvzXw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dSmJGiF82Nc37i+8nySZxq8WqG6W24J2UM6CDFtVhFYst9T5xggGmxffWNnzJLj5V
	 /ilwnKUxthBKKm1DdkI/bzlThItziWCt/kSsRQB6L/bsp51TzFnQGvxhug0JF5wsyA
	 N3Op62cjv6XfQ/06JbgGN67naT0xYVUqetnLNK0esmaNWoegNJrsPOxN05QJ07Vhsu
	 krqYmwugVljY9QcIDF5KJf6pCoyH6ggi0cvgDPbOgTOAu7khocI0Kz+Gpp9QNwtfjE
	 YU+eeW4a8SVxWDyDOLzUZNPvkzzalKTlya2EetLqIDNo+KSyRg8IvTRtlCrD5BhQAv
	 SJfQ6IbMzAW5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 69F8460606;
	Mon, 19 Oct 2026 08:15:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id F2407263
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:15:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E3F8B4018B
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:15:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZsqJ8A9aI-SC for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 08:15:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 53D6440062
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::234"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792397710;
 b=YMIMHUT+NvraGoXR4w7rxMcK9gcCLb9lXQTKdkcCHt0JkK35vu9iQbpuORloP9k0PnYN
 KnqsljRtzkFuA2kQpJoIEG0wnSigvx7b04r9TOZ9F6YtWjWg83TUlL5lavuoBP/BeI215
 6BK+GH9BLeTYk+C9hRZmysLw9uslse9Dv4Ul+ztyRZRj7zr/CUWZFYCqlAIm3xBfdoaKE
 9H6TwDOKyGFu336brN2IFMbEmNQ7YmQ1SOlOg/to1cRXf1yvqo1hvo743C9TYMBL6gyPx
 F05rMIx+IZ6NMTZyYRQ+nN600PtosgcLX+K7re4t/QocPZ7aAtHjJ88sXILZkj6WsFA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792397710;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=/aTC6Chy4DbadkhRfFd9vxCLkJHWKmhJ0j/Y4pHvzXw=;
 b=axiF93Cx7O7giGdB+UJrtojvMxBmwdvEIieGZYtkIcoV7qQTQJTNEvPKHfiR7UewBY6I
 sXxrXgBbxZU4CUji1azMzWbNGSywy2qc7zT67gcqeppfJbKr8EdPTeAlCZTTs4o9QqppM
 mkLenYEofbvY4tvz9Ufyhi1Gwn1ZEEvC3isV15/89pc4Nzao6f34FjfO3PkBDlABNIEJ6
 yAkOs5ReLv5n5EzABNAk50SQdBOZOJUrk3LKKq9qD+SDHGQs6zRoA7BKq+wsC6M54Nq8b
 H/1tgTd1tHpr2kWewMn89I+UV8ivKNvTxo1Tam0lkyj5FVBVAS1yiE8fgXr2OCNs7mA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=riscstar.com;
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=w4LepZVY; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::234"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::234; helo=mail-lj1-x234.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=w4LepZVY
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 53D6440062
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:15:07 +0000 (UTC)
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-3a9787a156eso12893311fa.3
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 01:15:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792397705; cv=none;
 d=google.com; s=arc-20260327;
 b=aoSoj1lP1bBUVHt7ss81EOW+Zoo1O8fANxEMc/ALDR/lCDMJNfnBo72kXNpUTl6xAB
 LMIVdtUHiMMM23VZJPv0GXt7PYfGN55TSRROdaJwgO0j0g1FSafKOmIx2w15yvu8HQUk
 y1OremfOCReK/9YWCOy9lyjDPtoFRkqaal1bFP4PB786Claxha7wzbW0QUTay/I2n3sF
 VHJKXNJHceiNbNLItJ0JQWGV8SKCrKHcaiudMxliaLP8xJpm23cpcaXm7y5HVrRpBLRE
 3LzhmYMkOwwltFzB2+xrZnPl/5axao1tpbHyTk0Zv2i46dLPKVLjgm83sIbgVRiLKzeC
 LGdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/aTC6Chy4DbadkhRfFd9vxCLkJHWKmhJ0j/Y4pHvzXw=;
 fh=4E0ChzIQASbtp/3i1h7XJw8RtL93veoqv11e8FvGqBo=;
 b=XxYZR8FJ+lF1uHAtjQQNDYe8CYLNxBE9mBCu61Uqg6QC5StBRZadg5+9+bgv+8C3aw
 ippdO5pbSdcAGQw8Gh8j7r3s0M34CQKQCCvAvKdNPvdsI/zt23j65Uqh3NTaQ4dVAzzM
 LR2mK8QSSzloRF9vvbcJrxJQevBof+xH08keekL+Pf9OehXMI0zp5Nryfx4cbTamJzEh
 VDmv1orWyeDaDypnb1rI86GJDt9KiGEg/87Krnvfva52XMxuE8EO/xuzFfBkkf62Ic5o
 TP1vluHBC8LVUW1CSlvpQK80Gp8fCUdDCjYZv1DxycNXB6yMc63OYZCo7X5lXCDlW0RZ
 n7Yg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1792397705; x=1793002505;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/aTC6Chy4DbadkhRfFd9vxCLkJHWKmhJ0j/Y4pHvzXw=;
 b=w4LepZVYNY48i/HXL4WxJQfSZDx5Sr5Q5k4Vzvj6sx2OLa70c24WIrqnLF/GUr0DHt
 wR2cYXlP3pRK8kV5FBw7UiKd/5E5s70fJ09yDRppafzVyIE1BYwoVeClEtTQziSwVeyQ
 jGdjors/WaNJonTa2NE7k/CNG2zpgF1LYpxPwSiiPw6HG8G4Lgw3IAWn53kLSDK9wulA
 7hhCPEAmoXKGK2yuzzA2edN1LQX+O8AFpFSfPw8moHK5XEdMMJorom7n0FKbieMal4Yx
 5Xmo+NSrWqbw2BuIQJGUy7NkH7CQGF3HKH/EbiFKzZ77oM7H/tnW0zSy20I/c0mvGc/P
 nCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792397705; x=1793002505;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/aTC6Chy4DbadkhRfFd9vxCLkJHWKmhJ0j/Y4pHvzXw=;
 b=f4yto1GT9mHeQWZu+si4M1DavpOHfZLYZk1yTKkISV4lUg9ZlWK3mYxGnD1b3cwc6k
 ZsPizWE+HjV+TkZKQryUKTHmpgbFjYPWCXc6Rz/3FlC5BQktAV4BvEwiVhflBqhNwlKE
 MYOUJmo/THPc3MFo8ICfcknetDtgQvp282QS1aupH9CBOBBpFO7H8eB5kAAEmmowB6QB
 G48cHV9jJC30LUkUo27NLWvaiBUBnVf/k+Xlt/cgXSpuvPS5NSLdHGrL0Sc6EugKLY0k
 k9iY9MAF6DAi8ciD1XC3sGDeIzLrh/rqXSTP0ZVC/C+l7OWeQJVzyfajTMmgXb4WCYhq
 PFsA==
X-Gm-Message-State: AFq9FYK2MtKpvJJI0OUWr+/rNX0x4nLSf3qeNwpxmdSamxhc+OV5+vQf
 E8TPsbfo5ZUoCtecbvlMDnZgUmUjuI1AUeNKRR9Ls7wCSt3PKAecIeF8mUs2WdiodcOH5ul5R/7
 Le0Kyc3CQh9bEZ4yRZ0z3WDml25BjeN6xc65hEwMuQw==
X-Gm-Gg: AYBFou05/s51FAHFNBttJ1q46t+2lVSECRtTnPESb7N+1dbOYDhHaRzx0UArQM4ozQD
 gL/75XTQnYj9/dzNUIpmHTRN7Ni3Yuy6IuShscjWVEz0pj7tguw8N91YNQn3x1/DBxfplumzwPx
 RccKNZ5i0BC7rPYyRRnpAc9C7ZOT4ZeXNSpjDCwIkAsYHe/DYwWYaExPFPRrDFEkLDi3LJQr+1/
 C3GO3E48zS0xi0OQGga1j2jxaykkJis4P2RUib/U9jv6C7fDxLqTQr1mfmmZmEjkwsP4qDVgrDp
 JJVn7vyXVvetlSbp8XjhN9gwzJW6r4GOmcL6Zn3hp0bFQxOLmCNGjOJ/xSQE+vg0XMabE8OIrY4
 KVssMPLXVCghg7nbiRXZe8g99EVKkmzxVORW7SfIZFa8XnZtEba3GvSHMOuMxbt2rShQP+glnA9
 dn2lfkhuZyWW9Uog==
X-Received: by 2002:a05:651c:1994:b0:3ab:46fe:156e with SMTP id
 38308e7fff4ca-3ab46fe1e54mr1863391fa.26.1792397705522; Mon, 19 Oct 2026
 01:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1790975598.git.DaveWK225@protonmail.com>
 <ca6d36aa511c453032d723005dc427f4d6889216.1790975598.git.DaveWK225@protonmail.com>
In-Reply-To: <ca6d36aa511c453032d723005dc427f4d6889216.1790975598.git.DaveWK225@protonmail.com>
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 19 Oct 2026 16:14:53 +0800
X-Gm-Features: AclHuK_yHqSGYn-YBWO8YM7nftyaA4XSQnMUGAkDhRlT9VUsgCxaqNZxhQY64sk
Message-ID: <CAH22mJxiqYLHtEF3M96aYdXsxaRu+spQ-xNmRey9oKMMv5Tp9A@mail.gmail.com>
Subject: Re: [PATCH 1/2] spacemit: k1: do not require a PMIC or an SPI
 controller in SPL
To: Dave Klotz <DaveWK225@protonmail.com>
Cc: u-boot@lists.u-boot-project.org, Huan Zhou <pericycle.cc@gmail.com>, 
 Yixun Lan <dlan@kernel.org>, Tom Rini <trini@konsulko.com>,
 Guodong Xu <guodong@riscstar.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, u-boot-spacemit@groups.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sat, Oct 3, 2026 at 5:31=E2=80=AFAM Dave Klotz <DaveWK225@protonmail.com=
> wrote:
>
> pmic_init() and nor_early_init() panic when the board device tree
> describes no PMIC or no SPI controller to the SPL. The OrangePi R2S
> boots from eMMC with its rails already up, and boards that boot from
> eMMC or microSD need no SPI NOR, so the SPL stops before it can load
> U-Boot.
>
> Log the missing device and carry on instead. If the SPL then has to
> boot from SPI without a controller, spl_spi_load_image() reports it.
>
> Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
> ---
>  board/spacemit/k1/spl.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
> index ef23db62d6..96ee4449c4 100644
> --- a/board/spacemit/k1/spl.c
> +++ b/board/spacemit/k1/spl.c
> @@ -301,8 +301,16 @@ void pmic_init(void)
>         int ret;
>
>         ret =3D uclass_get_device(UCLASS_PMIC, 0, &pmic_dev);
> -       if (ret)
> -               panic("Fail to detect PMIC (%d)\n", ret);
> +       if (ret) {
> +               /*
> +                * Not every K1 board describes its PMIC to the SPL, and =
on some
> +                * the rails are already up when the SPL runs. Only board=
s whose
> +                * DDR bring-up depends on programming the bucks need one=
, so a
> +                * missing PMIC is not fatal here.
> +                */
> +               log_info("No PMIC (%d), leaving rails as found\n", ret);
> +               return;
> +       }
>         set_vdd_core();
>         set_vdd_1v8();
>         set_vdd_mmc();
> @@ -412,9 +420,15 @@ void nor_early_init(void)
>         struct udevice *dev;
>         int ret;
>
> +       /*
> +        * A board that boots from eMMC or microSD may describe no SPI
> +        * controller at all; that is not fatal unless the SPL boots from=
 SPI.
> +        */
>         ret =3D uclass_get_device(UCLASS_SPI, 0, &dev);
> -       if (ret)
> -               panic("Fail to detect spi controller.\n");
> +       if (ret) {
> +               log_info("No SPI controller (%d)\n", ret);
> +               return;
> +       }
>         udelay(10);
>         ret =3D uclass_get_device(UCLASS_SPI_FLASH, 0, &dev);
>         if (ret)
> --
> 2.55.0
>
>

Reviewed-by: Eric Chung <eric.chung@riscstar.com>
