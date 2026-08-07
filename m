Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6712C2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 19:45:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B8B0C81203;
	Fri,  7 Aug 2026 19:45:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xjrD-eFW4xVA; Fri,  7 Aug 2026 19:45:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2C054811EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786131901;
	bh=bo9PzB8Z+lqZAT97ZtdcwMY7g78nEc6CL3ro7yqCuG0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TVlioHZCcFUUGXa++hf1yQcF70XKPj4V74nfNqa/ptyL9jGyaMGG7rPUILWLUgk9v
	 PYGv7kyWqIxOFuTho760r+pGp7HgXknpgapprzbT7YpURUpxtsv80nwyM0NsQklH4F
	 EWLgmKer5gHOPn1NsfiJ5Wduggi7bPFssNroVy+dnwaChRaDV/IioCaOpE2MUYWhgV
	 7JjnWWkq7v5bq3QtbJLT9ySPW4g4U8gg9p/p/PISJ1KvdgC3fVeXETm0z7mHXfZgqr
	 97x6oDAkLgUqhC95k8RhFscqirgAaPLBvtZiUbZIE/kzuZJlR5imQjD6i69BRpRZVI
	 DruJE7AC5J3wg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C054811EF;
	Fri,  7 Aug 2026 19:45:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A32ED392
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 19:44:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8BE1940933
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 19:44:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l5uHUJCtxZtC for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 19:44:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8794240738
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8794240738
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8794240738
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 19:44:58 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6a144c8eea2so5463493a12.0
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 12:44:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786131896; cv=none;
 d=google.com; s=arc-20260327;
 b=H4NS7gDbpemMKXN/SSVEJNX+cI28jSU3PG9mJjqCaSu7MuaULIyPWQbnSUjOiPbfg0
 cjWx8l6/6nFM+8OGWbwIqisOflKFUgHu3dyCtCM52DgUBsmh0yDQpPMKFho145+ynRjw
 DjMbjpTGQrY5VEUYiidYEtHORQ6kcL2mXJKHE927w/Gi0JI1Rogs7nnAYxbTYjz1YX8n
 FbFCnyvKY7rPo/SDYoNcE92g2CrVIcKuP1rFQki9ZJkx09YQUdII6iHtDJgYPpLoZKLG
 /r9m8aYnxrNZ7ZxM0jywBnOabyvkW+LwJ9jaoEf92cfymNU5PqMpVWTVHVptuFCPf8+p
 KYNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bo9PzB8Z+lqZAT97ZtdcwMY7g78nEc6CL3ro7yqCuG0=;
 fh=kEYfZBBSRt45rdAyEExcuq1763Pb6qQ6ayanXNU4av4=;
 b=f43M7QQietzicjy+o6l0QWAJlU6A9GrufJWpDwXU0y1ZRH4ptwSV7IPxKuSUblgur5
 iGtEE5YbbpVGkMHntsBXJz3DwNRRiCaJL7mFDorDYErHqDslMxG2kLc+GT6RI0NoL6tp
 XAfx8lA1/NZUYGpRrz0naBYElqL3S/1KQOHg+YqlLIGtTmr6saeXu2mdEBH/Fpl2xygi
 xZMIzas3aMeFKHgZcL3HfJvLv8DAPCSh+0shxZ4BIanJcfM7ezs91bNem/mnNpsAHRJ8
 lowsRTDSYlATROwnkDtYfko/WIYpFl8k4PegfTYbXCoptRmlAIGwuPG6AJuhAmjzFl5G
 s9fQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786131896; x=1786736696;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bo9PzB8Z+lqZAT97ZtdcwMY7g78nEc6CL3ro7yqCuG0=;
 b=KMExk3C+Gubg39qxGLFgMk2G9VdnmfPePWgbDXmtfE/rv200qLZRq+xi613E0YPowq
 Ox+2rbbLsgVns4/sbHfWjWcDu1wmiJVnTCvJxqwN2LhtB5ClZuyKtxVAn9MkhVaH9+XV
 /mTDLmn3CLa+S7IY7nGzD1awTRIXUF7X2kP/XXCjE8fsZFBA7VQPrUFEXlSGLM8CGTI0
 iSz+6QUiE0W4pTeZbdDf0gXbC0rSze39o3quRrYtjVF0iv7b6DWUXuBIKOLpCKjISpDE
 0zZwH3TwIIz7/xkyl1f2lH6DQs/0Ba3QIK1IfSoiCpsVKzKDHqf88f5dvm9hKkxNLLxE
 Urqg==
X-Gm-Message-State: AOJu0YzOOwcMSD+MF6pcklbvOh31KfoufXKCt86IEVnLEOTVf5s49M+/
 FPm4I8iMnkTYMXojouW3QGJbGE6Nf0V7uE3ojfS5FaBzz01EUl1uavhLubxqIWKYZoOzWbxuGv5
 j9xjKrToAr0jQefpjVKX4G5N0Xle5djSL+TdEceeicPNEhj2ET+EgKg==
X-Gm-Gg: AR+sD10Rq7h/v5WaXOQiiINqneSP+q0xqDcaMnhfRd1Se7oElhh1iyhHY2u8HUs7cuu
 dzihZahIb2etS2bBoJ/b2e50JlBbcXy6mO0eLVSrUdF//lesJjASMDANYFfYH2jcdptLvQLW2wE
 FnxrWnw0PKWUGJ2ckq1OKLfM9nWANKqGaTnWjH7H/yIHakJBVYfmyqvJPeKbb7T2Pdi2dA4ObQd
 Z4cO59iStEEzHblNyXavuuXvKhLdlK2TJfrsLbbKUMNS04ppnGS7rBP43jaW6WeZxSexHmhOFlQ
 EIvhoq3cDgfgYs5oM3i3dEXJnvVFcDD6z0zNi510wRA=
X-Received: by 2002:a05:6402:2383:b0:698:428e:9177 with SMTP id
 4fb4d7f45d1cf-6a1f246146fmr1256442a12.11.1786131896319; Fri, 07 Aug 2026
 12:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260806-improve-logging-on-missing-uclass-v1-0-d477f0054f48@baylibre.com>
 <20260806-improve-logging-on-missing-uclass-v1-1-d477f0054f48@baylibre.com>
 <CAFLszTiW7wZf_TUf-1hjkMGLaEd8GJ1QjUSe4dQugW2aDdOY4Q@mail.gmail.com>
 <CAEHHSvYfBunWje_rJJJkft2guJDod1kFtpsgjuxazQCXcABaag@mail.gmail.com>
In-Reply-To: <CAEHHSvYfBunWje_rJJJkft2guJDod1kFtpsgjuxazQCXcABaag@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 7 Aug 2026 13:44:43 -0600
X-Gm-Features: AUfX_mwgPNa1_I2lAFG_VVvsPHbkJFZkJE4O5mDKDTEWkYAhdpplUKVRosaVZ6A
Message-ID: <CAFLszTin8Hx3SMiXJF4Ug7vynUSG_WArqmZA+Hvjh2h1cvq7ww@mail.gmail.com>
Subject: Re: [PATCH 1/2] dm: improve logging for missing uclass
To: Julien Stephan <jstephan@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, dlechner@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786131896; x=1786736696;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bo9PzB8Z+lqZAT97ZtdcwMY7g78nEc6CL3ro7yqCuG0=;
 b=Asc7BaCfYPGng/a0cz+VOmYWGNS/cr/3R0Y7B3Figyavjjmr5llVkCk7atrwezVUrY
 8Ipn0hpumdExWkaCW+LrHnbqpMS2HpTtkgLnCsUSRPSf/xSVgjRFBXwP/5dqK6MxfaeP
 78f7oxNVyp13g3iabXgoa0adZJYmqlsZV4664=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Asc7BaCf
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

Hi Julien,

On Fri, 7 Aug 2026 at 09:33, Julien Stephan <jstephan@baylibre.com> wrote:
>
> Le jeu. 6 ao=C3=BBt 2026 =C3=A0 19:01, Simon Glass <sjg@chromium.org> a =
=C3=A9crit :
> >
> > Hi Julien,
> >
> > On 2026-08-06T13:05:19, Julien Stephan <jstephan@baylibre.com> wrote:
> > > dm: improve logging for missing uclass
> > >
> > > When a uclass definition is missing for an enabled driver, the board
> > > cannot boot, and without any extra debug option enabled the following
> > > error is displayed:
> > >
> > >   initcall_run_r(): initcall initr_dm() failed ### ERROR ### Please
> > >   RESET the board ###
> > >
> > > There is a debug message using dm_warn(), which is not displayed by
> > > default.  Since this is a fatal error preventing the board from booti=
ng,
> > > the log level should be at least ERROR.
> > >
> > > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > >
> > > drivers/core/uclass.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > > diff --git a/drivers/core/uclass.c b/drivers/core/uclass.c
> > > @@ -60,8 +60,9 @@ static int uclass_add(enum uclass_id id, struct ucl=
ass **ucp)
> > >       *ucp =3D NULL;
> > >       uc_drv =3D lists_uclass_lookup(id);
> > >       if (!uc_drv) {
> > > -             dm_warn("Cannot find uclass for id %d: please add the U=
CLASS_DRIVER() declaration for this UCLASS_... id\n",
> > > -                     id);
> > > +             log(LOGC_DM, LOGL_ERR,
> > > +                 "Cannot find uclass for id %d: please add the UCLAS=
S_DRIVER() declaration for this UCLASS_... id\n",
> > > +                 id);
> >
> > This file sets LOG_CATEGORY to LOGC_DM at the top, so log_err() would
> > be cleaner:
> >
> >     log_err("Cannot find uclass for id %d: please add the
> > UCLASS_DRIVER() declaration for this UCLASS_... id\n",
> >             id);
> >
> > The idea with this was that by returning -EPFNOSUPPORT (unused
> > elsewhere in U-Boot (he says...)) it would indicate this problem,
> > without bloating the code with a large message. This code is used in
> > SPL where code size is at a premium. I don't see the error number
> > though, which I added here:
> >
> > 13123276806 initcall: Adjust the failure message and return value
> >
> > Hmm yes it was dropped in the initcall move back to the header file.
> >
> > We already have DM_WARN to help people with debugging, so perhaps
> > instead we should just enable that by default in U-Boot proper?
> >
>
> Hi Simon,
>
> I didn't think about the impact on SPL. I understand your point, but I
> do feel a fatal error deserves a proper message.
>
> So what about reducing this long message to something shorter, using
> log_err() as you suggested:
>
> log_err("uclass %d: no UCLASS_DRIVER()\n", id);
>
> That keeps a readable, greppable hint while cutting most of the SPL
> size overhead.
>
> I didn't audit all the dm_warn() callers, but enabling DM_WARN by
> default feels overkill. I suspect several of them are
> genuinely non-fatal warnings.
>
> Otherwise, we could just drop this patch, since patch 2 now prints the
> -EPFNOSUPPORT value on failure.
>
> What do you think?

I tend to agree that a message would be better. But any SPL growth is
painful...perhaps we could have a Kconfig to control just this case
(default y in TPL/SPL/Proper) so people can turn it off for
production?

Regards,
SImon
