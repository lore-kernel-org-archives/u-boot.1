Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C8EFC624DE
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 08:08:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D62640B67;
	Fri,  4 Sep 2026 08:08:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TxXyDhsphjI0; Fri,  4 Sep 2026 08:08:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C9EE940A8E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788509308;
	b=mIao5UC1JD4SIUa8iKZfDCIXlqlBDAomdVQaP0LHShYDBztsvyEOil7F4Pp+gsCKNn/p
	 UQI3fIBb2DNrkuoq1Xo2TXl+0pQSrDm6tdeR06CKMubs7n8tCTF81UrPGSq/gfkdz1ypx
	 y/MvWlLyrqAFoO8cqMg+D8PS/Q7/BUrlSsgBERqDXCyYf2eMJyoandRuJTJv+OYgSAL/t
	 RFB/KVqRU9PyO8yBB0VuxoFq/0/NQREUJONNfhu/1aTJbHywSoPnCJLhB0r3cceEBS8Oq
	 bm+Uggp7lfC4A1A2PbEs673og9VaPfAcc0qFHjZPKqCtxh+63AREzch6CTXpSbdDXLQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788509308;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=P1y+sOuxFL7Zmqfkg/Uecj9/8aEk+iJIR5RQyWzckes=;
	b=WXCTYypMt5y75eORfzYR39LYXfHUDByAsaEkSDMuggLWFA7kzlJ3wm9J9EFjYPg8i1jt
	 dsH0lzIuduaGITz7ZNd6/3Uni2faDDvIcx1HshSQaPeHXuR6mevgos2fSg1yiQIljElj0
	 dOb4yoYJB8pRWyw+u7AlZN+m133dDJi96rOtvt7b3AifLeYrXrsamljbD2FqPpoZ0xq8L
	 MwcvQMW8UX9iqHyZcbSCCs3oZnWjqMYAoExox9UD7eHlmpTwcdMj/knDli1EFp1z0psCn
	 3qxOWMt/c9umu6uVqWu355HCow0NGR3jkpzDR/f6g9PHeJxBtLgORfExu5cc3X3Owhw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788509307;
	bh=P1y+sOuxFL7Zmqfkg/Uecj9/8aEk+iJIR5RQyWzckes=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mwtbwqBLI8VFbB36UnPLZOc25lAXv5DB6WUiOYG2DERa46Q6NDGhOP3eMbczIe5Y8
	 3mMKBYUAeeNRUVbFqjaSKZRRKsJn7NDqjcKhRboiFS/GSteoLCstcKnakxjpEyveko
	 YpZMjbi5uG/SZLaprgJGEGOH5eZgHvm7RaEax6NICMpaAHzyCZXO1/dTS5Xsg+12NN
	 fgw9kTvVCuKjZDEHKx3uUpvZp0p0eE6BudXr0Sz8SlRX84S/6KlELOEZajyuBO+BHe
	 1e/71+inHhOwPCuV26KUH4ijO7iG9X6s6h0Wme/sdaX3Ih1sbFr16kxrxdUXY18ZLX
	 i/h0CBR91R3tA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C9EE940A8E;
	Fri,  4 Sep 2026 08:08:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E5863AF
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:08:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 344434013E
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:08:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S0ITpjTMa1Ti for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 08:08:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 417D640080
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::636"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788509303;
 b=mgbsylEbar8IbXSCoBBnuSN7AMSIlbrxVI00jsK4jMs8cGVOyJU0pQePVvFA0UDcrraF
 9nR4cOPN+6WnGjdMw3dGVhpmzY/6cgNa30uhpBbQyZl1dLVdSHqXsrud3Gpaoi+7W2B1p
 u1nmf/tGKB93S7MHjXRCV8WrhR0aNTrgjYplxU+3z547RBRB/KZvydhgLk0/huii2qoVA
 vEZW7p8+tIFKsNHPCgvHGNOkRX+K8nZmOsaMDgK2I7/3vkMJN+NgGXxsnQX3xkpBf2a2r
 jJRpq7htAO351h1dWmXU+tsxtQTc//fCV0m1Ppl7CwvubopqOPQ32bqXuIyRtGWOLzA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788509303;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=P1y+sOuxFL7Zmqfkg/Uecj9/8aEk+iJIR5RQyWzckes=;
 b=dLoMc2M+nFvQcGHOr3nL5TWWArgtsP6UL58SVRcfPwVh4GsydPGPcrw5u7Yvr6Euiydv
 ee5DSS5iOsWL/S4fIbucVMPwO62JHOLXqsO6m7AYT/vwJVjaZ8cUeLJ39FVP/H0Hl4IGo
 qv07a4K83sn9xwHIxkj9Xw+MPWDT8RtYrUgCYdZPrlIs409s0uytr38XpVAIzsx6dGfvW
 9wASHd1eUc275xd5evN9gx9ntdVDGpj572bPZgzfhqTCRTVsiiPM/IRQFhfVVV5yDMscZ
 nRzHYbaD6U5huPA4SJlvtOoMUZ111G2KMa3+t17fxVO2Ct+APOVneIcx4cyt1+M3D9A==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=y5rFdUVy; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::636"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=y5rFdUVy
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 417D640080
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:08:22 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c25420fe973so109371766b.0
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 01:08:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788509300; cv=none;
 d=google.com; s=arc-20260327;
 b=aqIWkNuhDR5ciIxgG0RS0j15EXCItlKwRfgM3Hj+0GVSLhqfzmxqS/KjlpWT4LgnPW
 5xrNoGdpaKjcto8jNNQvLLL8O5Om1Emcuov0DDhUHDYYjGSznjAIJXs8Br6LS+a3r4gU
 oU5C7ikLLYLgoSAaiM5wLv7BrlW46xhENyB4A/EXeSDJ0yRJe+Lq5r74mP6/EiYNJmbk
 mkpi8vGVoeoWzlC+hDT3WEhWboPEaRScmIusD/U+mTOVj63jzV1ZpGiLPf99tHDszRA6
 3gH4B9awZRjGEoHIRG95gxJY/MTIAx3xlYMES9SY8+bhlshKylrN13mqC/Yqxuah9zK7
 4PBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=P1y+sOuxFL7Zmqfkg/Uecj9/8aEk+iJIR5RQyWzckes=;
 fh=/ExAnPSEoQTNVbqLVU5b3GFMyi6P/1TqXnkyEQN9YgU=;
 b=Qnh5SR8+hXvjeWvQYzNCKil8lZUdgGzKZS5y8oMpd/pHZDlzMr4yKOLCCyrqx06yDY
 JB+gU+RsZISWp8Ki7jffKwR3JfRSHdLnPzPgp3jNuRFjGERTPIjAFUAtPHetmhRPuZdx
 qNAhLGwwi0tCjjy6GrWEJuF5rERcCNprL2JP6d1G8pTuu6Xrs85a4IlgdcS5TnpvX75q
 zGO1KCyzjYsgQetaT9e4RCoErOO/2/EfQ3f+dcWo5oHuILN5tbrnwdRJaA2wtgJj6cQh
 LtyRRyTm6dJbTLGsNg3azFiH8kmIYbA4d2zla4ELjw1oUwrEO/8hz/9Fxi9G0VXXPBgn
 K3ng==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1788509300; x=1789114100;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=P1y+sOuxFL7Zmqfkg/Uecj9/8aEk+iJIR5RQyWzckes=;
 b=y5rFdUVyYS2bRZXyt7vqvPeP8rcI/JkGDjXo+uyAR2WS44BcI0wi7sIrf9OR7hgkYg
 s5mzpomHyrANVcSAFld5olNCW+wXyWDHM5SfEUd+sRPF3gnPImb1LDN4fhVgBVVv0hs4
 XOv38ShFy7d66Zdh4uQCETT3iBKd5Ew8IBAePYgCTwENhE87r/2hwR90ZBbyFJT4wV4m
 WflzaiIN3yn9x4ZgmlB2n3+xAVxcD038TmsxF60+3T/chmX12SiZidnq20iF2PbBVW1I
 t8jSA4wck0GxAFzZdPbZucazVBnwjF2pTOieFImnNM//3OUxlbAj8t7atO9u6v/b9OYp
 ETHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788509300; x=1789114100;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P1y+sOuxFL7Zmqfkg/Uecj9/8aEk+iJIR5RQyWzckes=;
 b=RlhwG9lLf+/4GXaaLVyCHrQwlfoPghzXwVsC5LUI2xNezxKpQlIIETkV9aD02R2Jjj
 Dzt8zNSW5/gsS2ZvUb7pMQ19pzhXAmFgc6XkPsLX6YQo60j2OOFd5BOFnn6uFEaVE4Ol
 e+jf7npEnjQt0tEAf7ib5QWUOju6BkiRg4Qza7k1LRCBcYpOApn5UZ+ToHgWV0EGlxC/
 c4B+K/IPGcBtwJDr9GrM/gf2nnd8h8nhefTZrCPV/pRJrOeFY6krOKBNKSntoObN/LCY
 pvNYdxp8H4Nwamyook0cCB32tVzVPRWUn+MVVL5kB5eZZvI9G0/UVCAfkqa6lgsn6HcK
 w/Yg==
X-Gm-Message-State: AFuF++kKn+gM4N7L5JBdLwGZoq8SNcd2DRpkmA5qO0T9DM4/rUHQv1cw
 /RsHpOu2jjggImaNgkh9dsbXv3z8295Wj+RevlFUL7T+iySDzeEapWkNECLl9Z4a6bDczsbAv0L
 4oGQKFqgVUPBb3oJ39+P49TpSkT3DOVp9J+yi3xYYyw==
X-Gm-Gg: AYBFou0eYX37MTuw3BrIj5GPfrV4tQJaOAoh76TAXIMH2rj9Iod7xeqxxku5Wch3hMi
 aNE+Nuu6B6b0bRIIGAQGLmZFJ3mOpllW78R6H+Gt8BKYY7SpjsIysFslc3AOuaqjP8qFs39VJID
 s0CN/XPYr+zHyhavgCCdDVXHePcRs8HjmwGMSkkvCIY3BPygCX9K7BuZWa6axOkoJeOSa2kKZ0P
 f+FSsxnxPzCXKZP2+Gvh7kxQUd8lyiaqeh7Fziq3iH9qDEMGPvgzt/PYaxzatEwYp8cfLmmnHFP
 pnAthR4ha5kRgs4BxZEsYo+EUintowAbq7YyJ6QPx71XshKVwgn8iGH/IKtfVYsaGndJx3Iq49U
 KZrKlVi1rt5F9IQ==
X-Received: by 2002:a17:907:c78f:b0:c26:19de:9129 with SMTP id
 a640c23a62f3a-c2619de9fa2mr52271566b.28.1788509300573; Fri, 04 Sep 2026
 01:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260904-ufs-spl-boot-wlu-v1-0-59aeea16c4de@flipper.net>
 <20260904-ufs-spl-boot-wlu-v1-4-59aeea16c4de@flipper.net>
 <bc3a2bb1-00f4-4c49-a85b-b38132b502b9@linaro.org>
In-Reply-To: <bc3a2bb1-00f4-4c49-a85b-b38132b502b9@linaro.org>
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 4 Sep 2026 12:08:09 +0400
X-Gm-Features: AcwNN1X9lnWPUTqC8Fmch_nscbJU-OldmxrOj6KtfyKRtlBX0dBA5XkD800bfIA
Message-ID: <CAKTNdwFuV=2X86oEzkapTAX5ueAhP4qVAiifbRJTpMC1UAuHPA@mail.gmail.com>
Subject: Re: [PATCH 04/10] scsi: allow a controller to declare well known
 logical units
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Julien Stephan <jstephan@baylibre.com>, Simon Glass <sjg@chromium.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Johan Jonker <jbx6244@gmail.com>
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

On Fri, Sep 4, 2026 at 11:57=E2=80=AFAM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> On 9/4/26 09:12, Alexey Charkov wrote:
> > The scan walks a contiguous LUN range, so units that a bus places outsi=
de
> > it stay unreachable. UFS puts its well known units at 0x80 and above, f=
ar
> > past the ordinary maximum of 0x7f.
> >
> > Let a controller list such units separately and probe them once the
> > ordinary range is done, so that block devices already created keep the
> > device numbers they had.
> >
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > ---
> >   drivers/scsi/scsi.c | 13 ++++++++++++-
> >   include/scsi.h      |  4 ++++
> >   2 files changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
> > index a60843e505ea..55915a021864 100644
> > --- a/drivers/scsi/scsi.c
> > +++ b/drivers/scsi/scsi.c
> > @@ -685,6 +685,7 @@ int scsi_scan_dev(struct udevice *dev, bool verbose=
)
> >       int ret;
> >       int i;
> >       int lun;
> > +     int j;
> >
> >       /* probe SCSI controller driver */
> >       ret =3D device_probe(dev);
> > @@ -694,10 +695,20 @@ int scsi_scan_dev(struct udevice *dev, bool verbo=
se)
> >       /* Get controller plat */
> >       uc_plat =3D dev_get_uclass_plat(dev);
> >
> > -     for (i =3D 0; i < uc_plat->max_id; i++)
> > +     for (i =3D 0; i < uc_plat->max_id; i++) {
> >               for (lun =3D 0; lun < uc_plat->max_lun; lun++)
> >                       do_scsi_scan_one(dev, i, lun, false, verbose);
> >
> > +             /*
> > +              * Well known units live outside the ordinary LUN range, =
and
> > +              * are scanned last so that they do not shift the device
> > +              * numbers of the units before them.
> > +              */
> > +             for (j =3D 0; j < uc_plat->wlun_count; j++)
> > +                     do_scsi_scan_one(dev, i, uc_plat->wluns[j], true,
> > +                                      verbose);
>
> Perhaps check uc_plat->wluns is not NULL ?
>
> It's not a serious issue since only UFS will declare it, and it will be v=
alid.

The struct holding it is zero-initialized, so wlun_count will be 0
when the field is not set and the loop won't run. I can add the check
if you prefer, but as you say there isn't (yet?) a code path which
would reach here with a null pointer, given that only UFS sets these.

Best regards,
Alexey
