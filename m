Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1ADCD13CF
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 17:46:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D834C88C67;
	Mon,  2 Sep 2024 19:46:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ASLzflj6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A01FB88C67; Mon,  2 Sep 2024 19:45:59 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAAC3882EF
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 19:45:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2f3fea6a0a9so39806811fa.0
 for <u-boot@lists.denx.de>; Mon, 02 Sep 2024 10:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725299157; x=1725903957; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/jJ9uUkp5b1M3io+C7T7FG0OfyXtcFTEjdFzGkPRvhI=;
 b=ASLzflj6bI//gCAXTNJBvRdOwGkN2apJRBSpM1EAoFLIYcBJRNdQCIytXl8IyiMacS
 FsHYLbbUL+aD8d0GI+y2VErLHI7LNKSAy7z1+hILoTTQTAU+PvXwzmuKD5rBSFwS8rTl
 OV8qBNdNZTAtOdikPlcl1PqWw9z6G4HoySxi7SWTw6Z6qhJCq1BQriIqoWcA2BO5cDZu
 MBB9ARMhcgyBMjswySr0JugVfimv+HwOQ0kr+CbYNOdLSareGcTqfdFcze8lU0FDEFtP
 cB/aQfhJZq17q8NVGe0kVwYecH4aXLldgMcmj4pqBWNqcFgk/QhGxXYDf2k9HOt8anSQ
 hx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725299157; x=1725903957;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/jJ9uUkp5b1M3io+C7T7FG0OfyXtcFTEjdFzGkPRvhI=;
 b=W5EN/POJ96SVAIWQ13X0Hys+/EkmLiR+sUA+M+cu615uf4C0KwAsoMQlg7AaJ9doGk
 /xNdgfH9lQh+z0g0nqAw7CMtmbhFTqmjMcU8frulFwhe8ZNxv7ZGeKBYgjPhepnE5sTa
 c1PkD41jPtkHLllf6cMDjqlbEOx1JuXfpfyfyPqrlSzjkxHNi4UBuoPNa8a3ASQbE4Zq
 S9z986J9NAkTX8OedbOXXN1uzHZGj5AXWXeCfsLahsL5VYIgXI8TKZRlIsLT32AYi4Dl
 qW6XUEhBqHPdt150shoFAResaX42g/IMVF1psKb5yEzAjbxwgTVVUbGe9uBRhm/wM2VI
 vj3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUV+3S24UgFxVJ3wX3W2wESGeZaxtGrLai68uxPxVLIaEWASROdD337MNJtc+Dgju+uGLGpl1A=@lists.denx.de
X-Gm-Message-State: AOJu0Yy8n4sri7PV8HC04Wou07Qhgk9GKnCkAmnFo7MxgKERdrSGLa38
 OwiTVOZOdh0SVdfxX8/35S3bNEYsxhk8appIP9D7U0kGYSzSkvWNDYJ5EwERLnYUae3+Pk8OSnd
 g82AZtg+8dJ8rWt6pa+PHA5DQjbY=
X-Google-Smtp-Source: AGHT+IESssam8ReLDrJeJs9CoGdktDTb+pL4LwQdRyvKXy9j3YwOLB2+DIWUzK6/BHzL+LlP/SYkYsq3g1QByy5/af4=
X-Received: by 2002:a2e:b88a:0:b0:2f5:cd0:9e0c with SMTP id
 38308e7fff4ca-2f612b1cadfmr43140501fa.21.1725299156645; Mon, 02 Sep 2024
 10:45:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240829112357.22292-1-hiagofranco@gmail.com>
In-Reply-To: <20240829112357.22292-1-hiagofranco@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 2 Sep 2024 14:45:45 -0300
Message-ID: <CAOMZO5Bfc0OvjycBjBeHqVX6kLLz0Pr_=Evzsxr9+qBDAfUj2A@mail.gmail.com>
Subject: Re: [PATCH] configs: verdin-imx8m[mp]: set CONFIG_SPL_LOAD_FIT_ADDRESS
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de, Rogerio Guerra Borin <rogerio.borin@toradex.com>, 
 Hiago De Franco <hiago.franco@toradex.com>
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

On Thu, Aug 29, 2024 at 8:24=E2=80=AFAM Hiago De Franco <hiagofranco@gmail.=
com> wrote:
>
> From: Rogerio Guerra Borin <rogerio.borin@toradex.com>
>
> Set the CONFIG_SPL_LOAD_FIT_ADDRESS for both verdin-imx8mm and
> verdin-imx8mp configurations to specify the load address for FIT images
> loaded by the SPL.
>
> As per lastest instructions from NXP, the generation of a HABv4 CSF
> (Command Sequence File) requires the U-Boot FIT image (u-boot.itb) load
> address to be set to a fixed value when binman is used. The address is
> defined by CONFIG_SPL_LOAD_FIT_ADDRESS.
>
> Here we set CONFIG_SPL_LOAD_FIT_ADDRESS to an address 64MB past the
> start of the DDR memory leaving plenty of room for the various DDR-
> residing artifacts to be moved to their usual load addresses which are
> close to the start of the DDR.
>
> Signed-off-by: Rogerio Guerra Borin <rogerio.borin@toradex.com>
> Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>

Applied, thanks.
