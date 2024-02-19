Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B16BC48BC3
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 13:15:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0BF587F5A;
	Mon, 19 Feb 2024 14:15:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UAlKH/jw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FB1487F5B; Mon, 19 Feb 2024 14:15:26 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8E9F87F57
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 14:15:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1dbd81000b6so5792635ad.0
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 05:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708348515; x=1708953315; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RmM6/QMOQ7fy0igYv0TIB7JjXkEkpGnAFVBjhpl/OAg=;
 b=UAlKH/jw6zP+ih4IIIY5YRMcaKcN01//lvZeGujxV5RxQBSzimc+46v9i6L/nwOsA3
 by/Kzct0nOTmpAVtjerhhqi5stAIFnaWqUYk8QuKuihCLNqMLbroOFHDKlvBx0ZoWeqf
 IAX0atpxSdyfmCDU+r+pcPN35G4PTmp8C8LYBbeSHu/8EH+d1KLl8ww0FQv0yGs+cKd7
 iNuvhzIHiP+tjE1P2wqKM25oN7uI9770UvjyL3LVTIr8ywqWttw7qdkwh855M9j3xydA
 OwXdN02zxQ2plORyO03NyZ/pfLqBgqdUqlX1Hx88paYQNI1BqoYKp0W2jgzFgnMWpVRv
 1kOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708348515; x=1708953315;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RmM6/QMOQ7fy0igYv0TIB7JjXkEkpGnAFVBjhpl/OAg=;
 b=ToQD5cnQPWj8KDn4SjP8dP9+L/1tHIWzPqyPfxKmrkwp8XGV5xlx6c9r+15mQLoWiW
 JUbKPZYrsTxooaZezE70fsX1VxM2Cb9EXaIaD6P735y4AaNCNG9XtxB7IfrrbX20VzEz
 0VDCYXO5jEefW74Rtk3ixgfneJ02fXAVRFUhUlrWr3AGB9i2p2VvAq9DdePp77bC4w2Y
 7Rr6enJJcUCcOJsmwsdTApTexpFlKWqLMRXEw9guaknNjY/vIyX9lbw8+iyAPbDhW5Y4
 1f7BtJCqR7i8OjUSUvfTZLkvdG3lbJidgbljMFgataIapZu884ttDyBu6gjjkaS9vlV8
 PZiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYS5yKJpbmmC18znlWsjAvy0c97SaCCEpWSQSWMuldzNo2TwFwyKdTRjfmVkgqBtRu4V4/oKvQK5AHkvz1r79LeYhXVg==
X-Gm-Message-State: AOJu0YzWfUYgv8gO/GPHGyf8SJ55oQzbOVtJofo7qq6i9xIdMzeGRr1B
 qVrUETpOKQSKj7wcl2nxSbOHN8uSyRtcq0H8RTWW68T160pN/ye/9+PVVAmNXuAk6Tk37ohNDdn
 UH/Tfj5FhKWOITeEws30mCMWl0H8=
X-Google-Smtp-Source: AGHT+IHXmhD5e7WEQ+bU7ZNM8i5pQucOvFoWeUseo4DzSjq2tcydN/Nv5vRFjGAfEEyKAB40WvZf0bXPJBJWmLJ+rs8=
X-Received: by 2002:a17:902:c14b:b0:1db:92e1:2e55 with SMTP id
 11-20020a170902c14b00b001db92e12e55mr10344216plj.2.1708348515129; Mon, 19 Feb
 2024 05:15:15 -0800 (PST)
MIME-Version: 1.0
References: <20240213114342.2728075-1-festevam@gmail.com>
 <Zc39_kXIbw0LsCvd@de2cfed78370>
In-Reply-To: <Zc39_kXIbw0LsCvd@de2cfed78370>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 19 Feb 2024 10:15:05 -0300
Message-ID: <CAOMZO5Aw6H4aPsBPChKDSN0mcnkaxoWPC_6xysGa9dN_Vn1o2g@mail.gmail.com>
Subject: Re: EXT: [PATCH 1/5] msc_sm2s_imx8mp: Convert to DM_SERIAL
To: Ian Ray <ian.ray@gehealthcare.com>
Cc: sbabic@denx.de, ian.ray@ge.com, martyn.welch@collabora.com, 
 u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
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

On Thu, Feb 15, 2024 at 9:05=E2=80=AFAM Ian Ray <ian.ray@gehealthcare.com> =
wrote:
>
> On Tue, Feb 13, 2024 at 08:43:38AM -0300, Fabio Estevam wrote:
> >
> > From: Fabio Estevam <festevam@denx.de>
> >
> > The conversion to DM_SERIAL is mandatory, so do the conversion.
> >
> > Signed-off-by: Fabio Estevam <festevam@denx.de>
>
> Reviewed-by: Ian Ray <ian.ray@gehealthcare.com>

Applied all, thanks.
