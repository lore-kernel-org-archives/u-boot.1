Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E144BC55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 13:37:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 56CEA40680;
	Mon,  3 Aug 2026 13:37:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zcXGFIn1PLcB; Mon,  3 Aug 2026 13:37:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8C8494066D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785764233;
	bh=ks+M3htbZz6DpR6RrqgbcAoEd6QHoEn5GI9lsql0dXw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wXp1l3p6l4xQZY4ExkNMqm5D21/74pGhy+ts3nyMuAOc47Jg9bZvtIafoYUqVnY2y
	 YvgoiXWZuQc+ZVEsDpVH8Fxmcw/6pvurBVLJUFHGQwdcxEJPfSUZrcAyC5g9nvYAd8
	 sCR3lDKgt06Lt6JpPIO5n7mTfgbwpIN+z8KKLomMUDw2kB6MNGuPfIVFIqPkQUhlL7
	 K0lW3gDW9M+8o5L/ddiq8JW0wdsSy3kJMNUd0y8mzgky3YDaJrIVdZiqaS80S1i1GV
	 yDIiwZs25/7ReRZV67ggBvlFWPvahxY/chbzXdPEhf/TbHFVjezVT+r73wh7zk/cY6
	 zQvZRq+3gWrwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8C8494066D;
	Mon,  3 Aug 2026 13:37:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 70C44218
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 13:37:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 65A354066D
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 13:37:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id toPO7MffdLsX for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 13:37:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12c; helo=mail-yx1-xb12c.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7D16040637
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7D16040637
Received: from mail-yx1-xb12c.google.com (mail-yx1-xb12c.google.com
 [IPv6:2607:f8b0:4864:20::b12c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7D16040637
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 13:37:11 +0000 (UTC)
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-664e3ed58bcso5916568d50.1
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 06:37:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785764230; cv=none;
 d=google.com; s=arc-20260327;
 b=CFCI3J4gMO2FSLH6t+ZqjS7P5HPAuTJzvrPzowQTE/coUKTkqDJkbN4VKnDGuZayfr
 eArcKQ1aTx31QUh3HU0ZVXWWIZR/gmwD2ZslfHK3YY437+0dCZ9VDUXnrbHRIZ4Np0Fs
 4LooMdabsZZSQTJ9KqFCQQ5Ro9JK1o9rVB4Iq/V0htCvCj2nwBNXXfhQ9yYr/cWb6GKm
 cORrlAZ30cmSncQBwZLrxuh5bVgzgXWiXyzqqLkEEQCWbT7s5Jc6Ny9OpB4zMxedIBjI
 90HiJn0Scbvy8OufISFbLSnWOohdlbS0QXBzv1O5nS7EQm/fZVWlkKmGUL4M/Z33owPm
 pp7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ks+M3htbZz6DpR6RrqgbcAoEd6QHoEn5GI9lsql0dXw=;
 fh=RumdPtPhditwHcT1mHPmbBt4XmKWLO4lCG+zkYKBWig=;
 b=DIxKHsWFW5nuKNOKREmU9uKQeByoJ/eEZ0ICFw2KHiDzWlS5jcnn8RspQ9m/86nHx7
 cWnUh95XpEhhe5i2sGSJzmw4YcU/sDWv5NDgdIlaSiXuLeW0At5sU9xK4xlAHKND/Gmu
 Y6+HTUuDgQoefsfz3WAjel7y/rn3Ho7LQl96sSuykACOpRsA5NCyvzMapCB7pPYLdOzY
 HTpt5aQIYCL24EzWvMJ4BwMT+7jUe4I1I2W7js8lRKby7hXCImaLJttAcHlQe/GdpwW9
 csZz0fl8szUwXKfYbGuX5dA1xXvk8Uki2RadkWjsHrrjbLt8CwQj0BtmJy3vFcKEArak
 emHg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785764230; x=1786369030;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ks+M3htbZz6DpR6RrqgbcAoEd6QHoEn5GI9lsql0dXw=;
 b=Rva/80MM96muZDfcEn8c7oS4Suv1GQ3wPslGq1dKeZ5jaaeLrzfPvL6O2SnS8QQXzp
 bfOlu4rpUspoFaJmGsz2Asay3YWLhuTv2lApDygTQqcYT6RtOEPB9QE+K8lCZWiDrGkS
 zLGOUoosK6g/daJQeb+5LcSYNJT2/3I1p5P1gEU6QDyLpT0e+42cFZtjmQ+tzRs4DvAM
 PMyL1mdaORkPwfgwyBSXeY1dVNuH+Ngsj+Heq+wWGG3vgx5uhndo257p+nwwf8hydy6P
 pdTeIOqk+NUz71cSZxwjukl4KsooKrdrH8unqWu+V2OOYG+XfGbpOTIFivjMUKyjbocG
 N/WQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrxKeazHtahyLv4jN/g8pcoASklSzZVjTjZtTapKncv9lmxvTF56eKzB4IRp4hlQA6R+nwwKr4=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyY0lipH0+6ehSdXVtSc/Sf04sUzlf3qDjzEuITBiXAODeM6wdq
 OZKJVcV/iVFYTuRVAK9QnJKVYQLyB8ay7bpkr7DCyNlDPa2zp3dpeAOMNQI1JrkBoSwiTXXKG22
 03mHm7vYhY1UZWjKHq+GTSWfQ1fsRF59AddyuY8mPdA==
X-Gm-Gg: AR+sD10hdfUzbvcSrjcC7NuVOtjpD3S02Y2WtGwG4UYcaPnYYp3Yf9/xqWcrvfXY69k
 nZWugqELsJ5rVMYW74lQP2S926boLmhTxo9lmIiuH9MZV9CBrSvu3hFOo/B+RcsAhYKn9CCy835
 JnafQFC2cVpJassgNA9BJc4ltdJhziE2FyZWcAlYFFsMRVzYfh3h9H72eyx9Z+e9gXHIAhC39kA
 V0omDHn3ox+I7jICQMTnjZfZDLo3UMngRaTRlXYaB7EzPoiUQco66aUrCQj54IWShuQiTWAYqhu
 S6Uw0I0A6xeOguuIlDlWMUwg8LR4Eg1aDQazXL6gYvbq7kBo7CVrcVa4qZW7z6vpY4ITavoyVX/
 uxXDMhmFzLV/53plNDOykIJoEIks4cWZkKXu5ACEjhOSYWiF4mo2I/DjO7QQCMA0JcgnUW7szf3
 rb99Ep/XovDX5bp2Pt9xzV2D7UHC7LCu4wEqH4VVuQojNZKuHK0Bknui7F6O9UZibN3ld0zFlBJ
 +Yq33ylZeWrKNvQO18SfSgW7cZTeq13x7IQo2la9fZcTP+F35+nKAFbBx+PVnRK4pVF+ySUx6KC
 mjWeHt6PInnVTMTEvQLD9BzTf30E2YMuTjf6LbTuuK9fsl1isiesagfsq+BvpnasLN0V6IyfOjl
 ErEiipuMmvCfJkmxiVFokqOMWViSFkS8xMRq/hXD+k0o=
X-Received: by 2002:a05:690e:1287:b0:668:43ec:3f73 with SMTP id
 956f58d0204a3-66945c49286mr13157720d50.15.1785764229951; Mon, 03 Aug 2026
 06:37:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
 <20260731-gpt-4k-v1-2-a3f1f16b53ae@flipper.net>
 <CAC_iWjJniUgONw47_WXAZZRsvrT_y6SJTyMLMOa+Hn9zy5BeFw@mail.gmail.com>
 <CALeDE9MOOjXRf4MAt=N-BmDdEQ522nQabEB7uoAcmf6t9fADQw@mail.gmail.com>
 <CAC_iWj+SD6axn-auG+rsE=c=0aaLDHaVv7jmS+1t4T_Y4BZ5zw@mail.gmail.com>
 <CAKTNdwHiNVy5rEYi9erzJ2E5EskZ8PsbCfvhxG-Y9c93j1hdSw@mail.gmail.com>
In-Reply-To: <CAKTNdwHiNVy5rEYi9erzJ2E5EskZ8PsbCfvhxG-Y9c93j1hdSw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 3 Aug 2026 16:36:33 +0300
X-Gm-Features: AUfX_mz5pQAvrUwJSgck_z6cRtJJDBZaZkcCNHhYgVcj2SxJ-xPh4TKONbGODCM
Message-ID: <CAC_iWj+SbvzKB2ogB0AtGRzmG26HNZAMU0dQ0LVVLpuJhkLTaw@mail.gmail.com>
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
 d=linaro.org; s=google; t=1785764230; x=1786369030;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ks+M3htbZz6DpR6RrqgbcAoEd6QHoEn5GI9lsql0dXw=;
 b=M3CWlsvUsk/9E/fon6e9+B0eP4xHwxst1v+5v2FLygBuVpZ5Stbw+ccTYkzvBSSA/L
 TgvENpQJ4X7vlJ9Rtdefm7/NpWZy+5b1AFgRjr5vUl08WHedBqgqmizVLWNV5gupc2yc
 ORN4hjIxPRFvIASCWFixRrZl266g4JWPl6zboIigpBgLy26BA26u8kD9Fa5wG/jDrkPP
 t5qhir1+wFIIwd1GiKID7nq9M/K3qoa2CgY72o4g54QaNWOwBy3/OTlVSCxWk/B2COZt
 p2xPQn0IIe9DQMv13TpNdGNANx8eMQL3zfjnDLeXSeVV3Jxk3HWW1jEwGUs50g6Go5FO
 Bc5A==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=M3CWlsvU
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

On Mon, 3 Aug 2026 at 16:29, Alexey Charkov <alchark@flipper.net> wrote:
>
> On Mon, Aug 3, 2026 at 5:07=E2=80=AFPM Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Mon, 3 Aug 2026 at 15:33, Peter Robinson <pbrobinson@gmail.com> wrot=
e:
> > >
> > > On Mon, 3 Aug 2026 at 13:20, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > On Fri, 31 Jul 2026 at 15:40, Alexey Charkov <alchark@flipper.net> =
wrote:
> > > > >
> > > > > Several GPT header fields are read without converting from
> > > > > little-endian, which is wrong on big-endian hosts.
> > > >
> > > > Probably because we got no BE architecture running EFI.
> > >
> > > Isn't the EFI spec explicitly LE?
> >
> > Ah yes, I forgot that part.
> > Alexey, you can drop that patch in v2
>
> Does that mean no BE system can ever have a GUID partition table on
> any disks relevant to U-Boot, including removable storage?
> It doesn't
> have to boot via EFI to benefit from GPT-formatted storage, does it?
>

It doesn't but that's the EFI part of U-Boot we are changing here.
Cheers
/Ilias
> Best regards,
> Alexey
