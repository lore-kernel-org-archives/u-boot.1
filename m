Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2EE3C2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 15:33:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 86A9940A73;
	Fri,  7 Aug 2026 15:33:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dGSNvxQPqVht; Fri,  7 Aug 2026 15:33:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 61A7840A69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786116805;
	bh=xTNWHQUtFZ63wFKuoaKUXK429ySs15AcoSe4B7mBFsk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xZ0HE2F6sLLDfrwejgp0a79vP0EDdCR985fVmMUWC9Rnpl5CDso9AYlozfuopC/6v
	 YeEfzgPYerJgHPSE4DXW/CRbFWqIcTlXIaCHQHBYQfD9TTzWRaVVM0YA2oLNxWOQZB
	 UjbmmiH/HI0dCRhhNJWPdtsvzuNaxP+iNZERjXP6VOGNVJjMYiAiXvQ9fbzmgS7UqD
	 g+J62GPjBDx0mYQpi3pbE7kkhbnzY9/KRqsArBTLG6b4zw2YaRPziCK4UzbyeqxomW
	 PFYvzCQxQLVhQpgbact0T+yHYi+eqWEEpfKz823/aYQvcVkv60hRZs0Hbh7badqOWz
	 aIqTbnhygzAYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 61A7840A69;
	Fri,  7 Aug 2026 15:33:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 478E0D3
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 15:33:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3977A60A7B
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 15:33:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9i-lDoUeQI5N for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 15:33:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org AAF9060643
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AAF9060643
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AAF9060643
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 15:33:21 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c15c42a45adso326789266b.0
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 08:33:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786116800; cv=none;
 d=google.com; s=arc-20260327;
 b=gNOZ59U6BuWL8ki/w3/WWHgo9xa3CqOdT/CB0mTPW+7VCG6T0jtdXaI/mn9NSR7cHu
 jsIfPpX0gt4uowj6rSTqyzr+k8Z4YGAXSYHeip87bLO5PPuCGLtMrB0ebciILjIAphAE
 zJGeoJf9kNtN0E1z+DLQxl3quFNPIYnVZKRh1nevzJIJ6Q6zzHusIMOSZqC7uyeCCyRS
 80kVJNfE1jM11K9imIA71UXLvc/mlYz1IuRbdGsdDdTjgCz6ZoXkrp7FwH7yB3q99xW7
 ujfTwpUcroQNUdjEg76/RSkbpYmRckAi2cyUuNWESndISkH675TK4MQJLa9S+hJ+PQAC
 sk0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xTNWHQUtFZ63wFKuoaKUXK429ySs15AcoSe4B7mBFsk=;
 fh=oftjkY5JAYKhw7RO8IazdpUQKAzt2rIu2vc1nebJ/7U=;
 b=HxgCcTAEzQr9rVxGRQrireBFgMQbeDCw50OQP6XQp3qU7qzKXo8W+8/7hc1mI3n/pI
 RyhFwxEGqI613FzwkqZZ1bYe694Nn5WqeZydvdm9p90zyL5To437HWNybNgZl3vsgalV
 pwoCMESnz7He9kzbQ9B8Msu92wRxZrva7wvk6XqUSf95Tkm3lQACgQh6iTSq6easTXCa
 YqwE37PKm+Vi0uleKt1AKG7xPU0taNtgCi+ZsxYPgLo0ipJ9ry+XfCcQKsNPl5XjvaxW
 DDUdenCO5dHG7HZhSItDxmkNYIdWW+JJPLgi7ZRsHES52a5UxEpNhtVSjCJXyDgLP19O
 xYNQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786116800; x=1786721600;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xTNWHQUtFZ63wFKuoaKUXK429ySs15AcoSe4B7mBFsk=;
 b=VqWSZp2RMF7WPgrYUmlSpAmLkux5GqZ/eTnxRXdRDHrVDXQ9yQp8dz6EAZGa9AEJQY
 OF7cGMIrq+1u8iD1TPHOMzVqiGY9Dr7IEPxQ8GupU0TgH5SPlvOqtHBw9ee20mHAfd5R
 L3J3eHU0gVEtq/FsfEFSds/0tBZpq6a9cd7vqfexzIGVgo1eTM5TLW4rNcqrw7UkFrp4
 wZfMEgF+OIG5B+77G6WTpfFoQEtVGo2//WM7QJxVsryrlXBwgYgW+ZPQjRlkhhcNg6sN
 kYjPetvcWw1Yxd24HNKlvs1Cj2zm3Fn194yPIZ06cSRIU4xVzGx/vmG2laKvt5X7iIUi
 bylA==
X-Gm-Message-State: AOJu0Yx++BejbJcserpF9wsd2Ch7nF9xguXKqWjAlPmYDRZ5sZDRrMYF
 Bc1PT4uxDfRuMhVCfwefEnK2ETsJ9hLOtJAA4D/oegb27zv7Zndc9f0sQ4C/zwSKzAVtUygJ7QB
 8d7o3FaJetFUOEhDjE/EJHSP2IONg7q1Rz0gfucZNb4dHys8GHm4yFc135g==
X-Gm-Gg: AR+sD13Q0Ik15Xpd4A5GuZQPKlCT6Ml7RWJVIVPQUkTJYZGdjlNb5jEPIWAoBrMq7Xj
 3Xo7QoyhxZUpA6DH2UNbg9HnWM09l8pNrPsNgAZA+Upywg0V8gAKj/fU0PSZSWuRKBhuw64AXNB
 eW7SF80/7MMtdVhMinBDiABhc/Y5N9OU6OpDNyN7yvfwFmm8wvZhTFmHFMDt/UEV6sdRaZduycp
 FSXeLkt0Bl4k1i9oXou5eb7YS+LLK3otzK1pKgORSgvZfNcbtM2dlr/0ofcFPzWAI19q9K7RQxp
 8I3q3xPVeUd7Fmsy3xCtKYySKsLourbQ5vSFp8ZPoqJ4eU/PEwK62za2zqVWZAVW2UbitRwFHOb
 7RpBkMDeRfFH/Ledyz2cwhe+hIdxnBZCqoaji05+s/1d4uR2+F0M6LpoG8WK+N+fZrSjeON6dVQ
 ==
X-Received: by 2002:a17:907:e84a:b0:c16:aee0:5422 with SMTP id
 a640c23a62f3a-c2057f8a4a3mr717646066b.6.1786116799662; Fri, 07 Aug 2026
 08:33:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260806-improve-logging-on-missing-uclass-v1-0-d477f0054f48@baylibre.com>
 <20260806-improve-logging-on-missing-uclass-v1-1-d477f0054f48@baylibre.com>
 <CAFLszTiW7wZf_TUf-1hjkMGLaEd8GJ1QjUSe4dQugW2aDdOY4Q@mail.gmail.com>
In-Reply-To: <CAFLszTiW7wZf_TUf-1hjkMGLaEd8GJ1QjUSe4dQugW2aDdOY4Q@mail.gmail.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 7 Aug 2026 17:33:08 +0200
X-Gm-Features: AUfX_myTPdfYr-PUghKXRW2L6zOwn1dOCkoWxI2jBr-eHjYcl5bCxdn1ZZYVo9Y
Message-ID: <CAEHHSvYfBunWje_rJJJkft2guJDod1kFtpsgjuxazQCXcABaag@mail.gmail.com>
Subject: Re: [PATCH 1/2] dm: improve logging for missing uclass
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, dlechner@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786116800; x=1786721600;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xTNWHQUtFZ63wFKuoaKUXK429ySs15AcoSe4B7mBFsk=;
 b=epDxqcC8EFB6bnxvPJS6K855ksNIFrwofBD3/eqvsIjHJW+wRrUF0BHspir5P+mAnT
 jjM1FA+ZmyPS0KkXqzgjXwXBjyQwHk7iBGzo2bT5nkRTgX88ZdblsbayYDHYCmUc0tr1
 M3NmKYG6BZs1WS0VF3wTNM3pX4mOhv7nEYny9MWtUnEulkM3wF6Joqwa2sRy1WKPwnK8
 +WPoOwmjpwxfUuBD10x3SSWVYEj0l0LZeUrs/EV2jjTkiQ1+CCAXnb6+mC33HFzsO31m
 VJZFjcTDMFs2BYksDAEc14zQd0eK47KxpwXgevGLOgjBOwILq7c/jdZVpDXRVrhQNau1
 w92A==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=epDxqcC8
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

Le jeu. 6 ao=C3=BBt 2026 =C3=A0 19:01, Simon Glass <sjg@chromium.org> a =C3=
=A9crit :
>
> Hi Julien,
>
> On 2026-08-06T13:05:19, Julien Stephan <jstephan@baylibre.com> wrote:
> > dm: improve logging for missing uclass
> >
> > When a uclass definition is missing for an enabled driver, the board
> > cannot boot, and without any extra debug option enabled the following
> > error is displayed:
> >
> >   initcall_run_r(): initcall initr_dm() failed ### ERROR ### Please
> >   RESET the board ###
> >
> > There is a debug message using dm_warn(), which is not displayed by
> > default.  Since this is a fatal error preventing the board from booting=
,
> > the log level should be at least ERROR.
> >
> > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> >
> > drivers/core/uclass.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
>
> > diff --git a/drivers/core/uclass.c b/drivers/core/uclass.c
> > @@ -60,8 +60,9 @@ static int uclass_add(enum uclass_id id, struct uclas=
s **ucp)
> >       *ucp =3D NULL;
> >       uc_drv =3D lists_uclass_lookup(id);
> >       if (!uc_drv) {
> > -             dm_warn("Cannot find uclass for id %d: please add the UCL=
ASS_DRIVER() declaration for this UCLASS_... id\n",
> > -                     id);
> > +             log(LOGC_DM, LOGL_ERR,
> > +                 "Cannot find uclass for id %d: please add the UCLASS_=
DRIVER() declaration for this UCLASS_... id\n",
> > +                 id);
>
> This file sets LOG_CATEGORY to LOGC_DM at the top, so log_err() would
> be cleaner:
>
>     log_err("Cannot find uclass for id %d: please add the
> UCLASS_DRIVER() declaration for this UCLASS_... id\n",
>             id);
>
> The idea with this was that by returning -EPFNOSUPPORT (unused
> elsewhere in U-Boot (he says...)) it would indicate this problem,
> without bloating the code with a large message. This code is used in
> SPL where code size is at a premium. I don't see the error number
> though, which I added here:
>
> 13123276806 initcall: Adjust the failure message and return value
>
> Hmm yes it was dropped in the initcall move back to the header file.
>
> We already have DM_WARN to help people with debugging, so perhaps
> instead we should just enable that by default in U-Boot proper?
>

Hi Simon,

I didn't think about the impact on SPL. I understand your point, but I
do feel a fatal error deserves a proper message.

So what about reducing this long message to something shorter, using
log_err() as you suggested:

log_err("uclass %d: no UCLASS_DRIVER()\n", id);

That keeps a readable, greppable hint while cutting most of the SPL
size overhead.

I didn't audit all the dm_warn() callers, but enabling DM_WARN by
default feels overkill. I suspect several of them are
genuinely non-fatal warnings.

Otherwise, we could just drop this patch, since patch 2 now prints the
-EPFNOSUPPORT value on failure.

What do you think?

Cheers,
Julien

> Regards,
> Simon
