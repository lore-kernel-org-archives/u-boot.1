Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0FC7C55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 13:39:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 141B64068D;
	Mon,  3 Aug 2026 13:39:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6NZXXACLcwOS; Mon,  3 Aug 2026 13:39:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5C3574066D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785764345;
	bh=pQ0G2ql8QwpqC64Q+ZoGpDBJzWzN1Y0/EKYVV1KuxvI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T7NB+YvQP9YZrsCcYmYAZdoRLIHywiMikib/Ffbktcz2zdpnY+2f+bcP/RUO7IspF
	 SpOaRDNYNyOGRURAcUQKZhPxO2Wf+MHsKomdSDbI7OXDfgLofmxHrsWO/S0tW0sWY+
	 zwI6P25CbRkuQr3j5zFqda/ohCVkLobmVjErindBPtz0SIj9L2qXLTcbtYAuw4kK7o
	 +y+v8WvsaWIbqL+MwFxG5OSKN+f7ZPnWefLz1OSDuVIl9aZ4Hj68AjU6dN+wEEasQZ
	 QoIyUuXTlaXDFIx6mV1xzy228neoI12mBuJTN+JZZiBtR+Q1/ICFCYIr3y9WwTsg/k
	 UJ8YQimGadp1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5C3574066D;
	Mon,  3 Aug 2026 13:39:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7DDC32CE
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 13:39:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6FB18400A0
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 13:39:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wcj5cDFXy6Mr for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 13:39:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b132; helo=mail-yx1-xb132.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 98BEE40042
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 98BEE40042
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com
 [IPv6:2607:f8b0:4864:20::b132])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 98BEE40042
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 13:39:02 +0000 (UTC)
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-6689402c7bfso3881086d50.1
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 06:39:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785764341; cv=none;
 d=google.com; s=arc-20260327;
 b=WJjFrJzzX1zbYg3GmkM6rcKfJnVMSZBuysX2dAaNJMwBx0OHAWj8//Awpsot6YUqSL
 yqwQ8xIPFvT2ZoQEmD7vo2dibzffu9WfoPzG/AkwKheDhvYANiTYIhfqpmsOXyXPtm0Z
 bdjQQQB6OZTokTmLkPbIbEKjC05OFLSUr5N0RfSaBal9lPT4xYWDfZcOCRAaueXtxhuK
 5gOJU34z5ydFTbKToBvatR6k9mWvwbr9dpDxHJzWjnUmEqRkzVYBKi9TEJcnyi+ecu1u
 dBvcTZMAnQIEJtqgobEYKOijRLssKiTkVxL4Gy8qjrAFDa5uyOYspcohbZkmL61hfEGa
 j8gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pQ0G2ql8QwpqC64Q+ZoGpDBJzWzN1Y0/EKYVV1KuxvI=;
 fh=z/GpSBAuYrNUKCeD58i5ugrmO+EsKVMxSA1M9j3oto0=;
 b=bQ9O2qjKrdihU/Rye6H0KLJ9lYrnVfpamG1qLeHRykpykA4eleaUD3BMGWxJ5u6FI/
 jKpdF6XO9yIrwOSLb1Ft0XWRc0ZPKLIiFnxzn4kU1DCokKAA9jRF6el8o1W/tKO3+vU6
 1rqzXD+DGUexy8ysoNKoiJXjJvJwpSQj3L/+RLeo7ZeccH4us/ejhgOMmFVn090ibgNl
 MsplfXMMd5fu4pWv/PJgEGdfoySJablwxcHbrEfW4YInGrVuOwzoz21PHd0G0irb7WWB
 +du4M1EItuQ7aFGU1uRatuMY5mVYKuLxskfmIlbm7UVr9fMYnC2XdNbZVQmQEwkWB9W8
 U/tA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785764341; x=1786369141;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pQ0G2ql8QwpqC64Q+ZoGpDBJzWzN1Y0/EKYVV1KuxvI=;
 b=RLA1vTZdQXWFzbk4dzlbxldZhpNeQ+jJ6SqJKW7zH3NwU6HF1K6dLSUbNhvbXqTMBK
 joS8QfeJ7b//eD2SzwUlWWLan3940ptcdyu0AUso+BLGTY8ZNsQMZh+rcm1LUnr7fPpP
 biEeyDg9NWJepB5zU7p+Zv1CP/emO86uYRbGvEkUBvq4JzJYElAtgu4OTH0q4vq23lKw
 RK05jTu79/ogSS6g7HW2lqnwZF2Z6jzNIfa6idfFg4Q+TM0lBKVoXs7sM674DksJXRIN
 xmSG1Y3dKJbGq9Yfi8pSO1R4KceYXst2VnJTDi0FXI/OxsUGq1idFTNeK/NWZL9vdGqJ
 pMlA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp5DMNahEV/9rdgPDCZH+FCFiVHjP569xr8PNqcI1CGM9oLO6m47pjP1fvAb1sDGcW3gHNUjik=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwK0Y7TAHGb1xvs1sRJvO78ISJdx8rt/SIG0xFmB1Oh5R4Q513f
 KlqYxBlNvYThY35KDbFYgx2te1slGu9L/dCd55wWJMwuVXXdlkln7oSTKtXXZ1MLIwZIDS/Rcp4
 QacC6v24plYPeKGBaCwtu9DFfrI4roaKFhIhyaK7Y5Q==
X-Gm-Gg: AR+sD11IXDtl0bs90tJ41A9sLcPMJpFbau0jyozLVqi8AcIMb97rwZux9k0b1QW8rEp
 iU6Rfkmz4iW3st8ioj+mBTTKe+1VRIFqLnzGFK62Nu1jDEK2f6J5qCJIFokYM+WPSJbEAguCd8q
 KffeqI3dZrA4kPzvMEnqui9E7FzgiSty31Mrx0I/7ZD+iDhaCVTmvzi//GLtsxMNfUMbxsFkOvz
 Y6Fsq2BuPXWyjfxkenGwEwxLAMupJ7u9t2kKGYKxy/YGh4nsvftSnpWnEE2TBic+QhfKPDx6w0m
 w5Cq/t1d/TKsonvv+CbdPwzPXUyVqcWEiNpfC8k2mZDRL9oBnR38/6uGqlLCpw7rjC726QEIeD+
 LY9zbno3s55et8k8XUkco88YBz/Wv5aKfBvYh1nj8lv+UzXKpalxyMsFONqZ5tE4GeS8dWU0P3j
 3sJbiFJp/sncvOt7lWv8M5lsmKf0XB3lpIRfLfVgFBW5Pm2cF5QzFvbmzwAUsPoQ/0YLnNwXYVT
 57cbKdH5cn6mEfq4KEIGEJt1pQga9jj96Km4O0QaBK7NCOzo+lKApd6T6DiLjBvzyFRo1vS1VhC
 73VbTMKZohVLJ2r3FNoK5wl79idr7ZJYFY/EWw6fnO2SuGPFcJSib9XJeqi3t2uGX+KiL/MAgG/
 3CdEtAR8KEhwGwmC8TFCUed3rJw9JxNZmdD1BBDaI5tA=
X-Received: by 2002:a05:690c:2606:b0:7dc:7764:3e83 with SMTP id
 00721157ae682-81fd4b3c270mr129070907b3.17.1785764340947; Mon, 03 Aug 2026
 06:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
 <20260731-gpt-4k-v1-2-a3f1f16b53ae@flipper.net>
 <CAC_iWjJniUgONw47_WXAZZRsvrT_y6SJTyMLMOa+Hn9zy5BeFw@mail.gmail.com>
 <CALeDE9MOOjXRf4MAt=N-BmDdEQ522nQabEB7uoAcmf6t9fADQw@mail.gmail.com>
 <CAC_iWj+SD6axn-auG+rsE=c=0aaLDHaVv7jmS+1t4T_Y4BZ5zw@mail.gmail.com>
 <CAKTNdwHiNVy5rEYi9erzJ2E5EskZ8PsbCfvhxG-Y9c93j1hdSw@mail.gmail.com>
 <CAC_iWj+SbvzKB2ogB0AtGRzmG26HNZAMU0dQ0LVVLpuJhkLTaw@mail.gmail.com>
In-Reply-To: <CAC_iWj+SbvzKB2ogB0AtGRzmG26HNZAMU0dQ0LVVLpuJhkLTaw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 3 Aug 2026 16:38:24 +0300
X-Gm-Features: AUfX_myeADBA9vSuv6fPStL2Jw5vMZU-UElmY5WpVRFobSieeZ5T771ARGQjty4
Message-ID: <CAC_iWjJvdsuh+bn+2QVVhnAgPEGg+4d5YbeybMDqA490G-b=fg@mail.gmail.com>
Subject: Re: [PATCH 2/6] disk: part_efi: Add missing endianness conversions
To: Alexey Charkov <alchark@flipper.net>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.u-boot-project.org, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Tom Rini <trini@konsulko.com>, 
 Anton Burticica <mouse@ya.ru>, Javier Martinez Canillas <javierm@redhat.com>,
 Simon Glass <sjg@chromium.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Jacobe Zang <jacobe.zang@wesion.com>, 
 Jagan Teki <jagan@edgeble.ai>, Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Jonas Karlman <jonas@kwiboo.se>, Suniel Mahesh <sunil@amarulasolutions.com>, 
 Klaus Goger <klaus.goger@cherry.de>, Tim Lunn <tim@feathertop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785764341; x=1786369141;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pQ0G2ql8QwpqC64Q+ZoGpDBJzWzN1Y0/EKYVV1KuxvI=;
 b=bmnDqVPPQ08je19y9LzfaOlKumIzh5W1h5pCIOgogpudfSENm9iU/CuNc4+iEYtEBS
 r/17fXwuU9z/mIy4SUedX+UfMGOClPlZRoAGgSKEiWJvxWJvDO0DWEPiWiUqbrlW0Sdh
 M/ZX648FfD05+gY5HGWe9PKCF3bQtQcWt8IT8D/aXd6uiniN+F/2MysDHfZkOPm6GHnq
 K6wHNUIKsDikA4u3yGWcZvsUSu65ZjjlBo+av/zKB/put4/jYktbKh37q61jlVleo3HK
 qjx+LWaMnd91Mi3lHl1zjOJhvTCA3BHIR+WRUiF7xWCiKsMZ2ekS80rDqQUo9+pAPk/X
 NEVQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=bmnDqVPP
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hrmm,

On Mon, 3 Aug 2026 at 16:36, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Mon, 3 Aug 2026 at 16:29, Alexey Charkov <alchark@flipper.net> wrote:
> >
> > On Mon, Aug 3, 2026 at 5:07=E2=80=AFPM Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > On Mon, 3 Aug 2026 at 15:33, Peter Robinson <pbrobinson@gmail.com> wr=
ote:
> > > >
> > > > On Mon, 3 Aug 2026 at 13:20, Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > > On Fri, 31 Jul 2026 at 15:40, Alexey Charkov <alchark@flipper.net=
> wrote:
> > > > > >
> > > > > > Several GPT header fields are read without converting from
> > > > > > little-endian, which is wrong on big-endian hosts.
> > > > >
> > > > > Probably because we got no BE architecture running EFI.
> > > >
> > > > Isn't the EFI spec explicitly LE?
> > >
> > > Ah yes, I forgot that part.
> > > Alexey, you can drop that patch in v2
> >
> > Does that mean no BE system can ever have a GUID partition table on
> > any disks relevant to U-Boot, including removable storage?
> > It doesn't
> > have to boot via EFI to benefit from GPT-formatted storage, does it?
> >
>
> It doesn't but that's the EFI part of U-Boot we are changing here.

Ok I was too fast on replying. You can keep this patch. It's not for
the EFI loader.

Thanks
/Ilias
> Cheers
> /Ilias
> > Best regards,
> > Alexey
