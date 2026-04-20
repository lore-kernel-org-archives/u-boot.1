Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA03F5A8B6
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 19:32:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65EDC84374;
	Mon, 20 Apr 2026 21:32:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jm5fp4O3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A40184347; Mon, 20 Apr 2026 21:32:35 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E34284347
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 21:32:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ba36357195bso395483666b.0
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 12:32:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776713553; cv=none;
 d=google.com; s=arc-20240605;
 b=PJtJvSBxmUe/B9Axig+DwM4wSlDjeZXNkPKBAhJcAVTRkrvDCUs90vMiX3We0Dv3v9
 CE4EIvq7Do5IXfaKkPGPL48iZGRwLda15bCLpYqSqz8PMAJ0nYACO9BpxFdD0Srb5Uqp
 1UVWlhoa1+y0cWA+DLeiwunBlb55zqT7La7H5qvgdNCLJ0jZ972NO4ef7u0kCTpiXD5h
 +OVBu9Wp350xNRMiIXol3bisaFbszBPlu0zGNLsUuJHj0SjEugx14ci8hxy6CdOSQ+E0
 IJZ61f5guzvKhTOeYaqzT4BHSJEPUIs4THrh57KPVCLLewfZI/AlqLqq2k9rM7WPEpUK
 /RDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nlDIVAiw/n1Q0/t0IVX+Wa+MF6T4VeU6akn34nNkNwU=;
 fh=QQJE3IaAeunPHumA5bQT00HUdZQapHaeCUQ1zQOCaEg=;
 b=Oas8ftjGXGk1wk0fJCLLTyMS8OUo8UMjRXX734GZJCmRta+NF7dif8kfz+RS8kB09W
 yUlJ7vxzaeHHuXCcla4V26SCoIar1nYQoWoOciNxgQU+AxVJ4sMu5nMdiSJuqUZAD7mK
 Mxohr9sjYexNYJXu+pqMWjMafLdp0kVvxtIvG+WgBCfO2b4dJaZ+6vSyqqSAba6l3DeQ
 9tPzgd5ydNDwxVrUt+N4ggAjnV3G79wX85Z4lgvoYyppTILeDfvQiQaqfpcxwKC4SZqK
 vLtfwjmIn771fPrYFJBxL4WjgllgYor4LgVIN22iXy2GPmb8hlCFkigFRaiSFI7VnE1h
 lX8g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776713553; x=1777318353; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nlDIVAiw/n1Q0/t0IVX+Wa+MF6T4VeU6akn34nNkNwU=;
 b=jm5fp4O33zWt0nnxR6QmmneyjbgzJ4jTuGI3b9Qky2/Wr7PGED/V3D9BOAomOZ9IQL
 PTnHLRIEd0q7aiRWkasTxBXmo5prSx02oBbjBEFU+X+eJQFd48DbH8c3aID7Jw8YRVQM
 PDzSxRlhuQG7idbFSxUui4vk1kHScNBL22iVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776713553; x=1777318353;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nlDIVAiw/n1Q0/t0IVX+Wa+MF6T4VeU6akn34nNkNwU=;
 b=OMm9BO8qnUWyAfGBuizypRiQSC1PRYGwAGHYgix02FeQvNIz0WQMZbifOLiYdBXRNR
 2ZQ52HTYktzC5vjcPhkaGiJKHdmBns2z0+uluKxSUa5rjBpHRnv9TjpmHgnqA0GdRElS
 Jo54FeTra7zepxKzzJ1FPP8fQTgxNx+NkKr5xKwvyrw2i5YrBXyt4Mu/aWDMihJYELJj
 Raot2HCEDzWZt9BgVsZr17m61Rm0hLcVDYDZmBLTFYHshvwEmeos5kBKEpbNzdnhwAl5
 KDKrI+Eb84XPOmvLx2Ioj8HWX09+jkFoiUnEXUKGr6A7RvdRIPEm7jyfP/nDeZeK5biS
 LlrQ==
X-Gm-Message-State: AOJu0YwymhlCkze0Ujrz9/Wd+EEFQbWnUNuAsa+RRNUJYEj5oI2dHf7+
 MgA+//16cnfiCVzeMI/Fsbeg+JFQy7pus5wQogjBUX47qKA+p8i3Fi3KBznCVoG6GibvbEgftN8
 DpJd4w7PfpDJTMaLDgPaU9gYJAiFEcMt5AxD98Xptqm30uK58MGk6UA==
X-Gm-Gg: AeBDieu5O7K1qEaspnKTf7uYvZcc3s0YEJQpeby8TxGBaJ/bdXLtdJo2ruecZ5q1TFf
 1A7cFaVZ4r8qRM2njqJqmMfsFhGryg+8E3D7KOlSHIrKVb7fYcU1MpYSiLlRMmIs8QNzDjoqX1Q
 +toeK88Scu3vSynbhkSrsDBzOzgU6zCrpO2if6SqxXnyYfS+tplF2d7FaUFcD+l0kBXGEG+8lpj
 9GWL/ljloNfQb42QJRJBoDx3AuQIf3cJ5cL8c9ANS3Gzp/H55JQQEr4J7h5EtQx6CWmIsU76B4r
 ztanMG5VnlgPkNFkA8sJ
X-Received: by 2002:a17:907:a604:b0:b96:eee1:bb66 with SMTP id
 a640c23a62f3a-ba41829279amr652324466b.10.1776713552565; Mon, 20 Apr 2026
 12:32:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776392312.git.weijie.gao@mediatek.com>
 <17d1fc9a1ecdd0a5d54907b8816ef62793387a42.1776392312.git.weijie.gao@mediatek.com>
 <CAFLszThHeX97x6Ebc_7TZiRs3ez2MC05Kf0ir+yo9=09NHThHg@mail.gmail.com>
 <1219110f4621405d5312a7376d35d1bc6638618f.camel@mediatek.com>
In-Reply-To: <1219110f4621405d5312a7376d35d1bc6638618f.camel@mediatek.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 21 Apr 2026 07:32:18 +1200
X-Gm-Features: AQROBzBxIs7dU5ceP1sMkd4xVgljQfTFBKMnpP5mf5zljcV0nrNHp6pb9GfCZiM
Message-ID: <CAFLszTgWtDYuuscRheT0T8w5bUcbSrRU=7UBWgnGmZxCczp6ow@mail.gmail.com>
Subject: Re: [PATCH 2/3] cmd: ubi: allow creating volume with all free spaces
 in ubi_create_vol
To: Weijie Gao <weijie.gao@mediatek.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Weijie,

On Mon, 20 Apr 2026 at 19:25, Weijie Gao <weijie.gao@mediatek.com> wrote:
>
> On Sat, 2026-04-18 at 12:47 +1200, Simon Glass wrote:
> > Hi Weijie,
> >
> > On 2026-04-17T02:35:14, Weijie Gao <weijie.gao@mediatek.com> wrote:
> > > cmd: ubi: allow creating volume with all free spaces in
> > > ubi_create_vol
> > >
> > > Although the ubi command itself supports creating volume with all
> > > free spaces, the api ubi_create_vol() does not.
> > >
> > > Since negative size in invalid, this patch replaces negative size
> >
> > is invalid
> >
> > > with all free space size in ubi_create_vol().
> > >
> > > Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> > >
> > > cmd/ubi.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > diff --git a/cmd/ubi.c b/cmd/ubi.c
> > > @@ -226,7 +226,11 @@ int ubi_create_vol(char *volume, int64_t size,
> > > int dynamic, int vol_id,
> > > +     if (size < 0)
> > > +             req.bytes = ubi->avail_pebs * ubi->leb_size;
> > > +     else
> > > +             req.bytes = size;
> >
> > When size is negative, the printf() below still prints the original
> > negative size rather than the computed req.bytes
>
> OK. As you mentioned in patch 3/3, I think maybe we can move these
> printf logs to the command's main function to avoid logs being printed
> every time these API functions are called.

Yes, good idea.

Regards,
Simon
