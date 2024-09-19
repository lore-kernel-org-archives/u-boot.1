Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5BACE8D78
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 12:01:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A13289151;
	Thu, 19 Sep 2024 14:01:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PVMyXrOc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DAEE89154; Thu, 19 Sep 2024 14:01:34 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 741648914A
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 14:01:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2f77fe7ccc4so8077371fa.2
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 05:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726747292; x=1727352092; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D622eEAE72OxJ4FmYjcD5EIOaX5uwdFL2YIaI34EwU8=;
 b=PVMyXrOcKo3EjmKpaIE3yNIZiRc+QY+tb3w0cU7AK1NcIQC8Xfm1wjOT5Gq4wxmpbE
 aHXgtuT5GcY0XHQsLecEwgRdzbF/rDGeylEciK7JzX8DMvydZr4vyr933NaJS7A+91j1
 5G0ruxg3YWliquj/OvtyMiU5/9dEic0oSZTjkqqLUhz7GYE7q2jGAp9q57UAClDwA62j
 4tzY0qFhhh979HbuEABWuJD/ZMgB4pMYbZQ5NTr1PgdVW9Gen7OQcW09xOZz5B9ttRA5
 EnsllOw/aUyG+fKfsGwo4UnZjFA4jmcFp+5JT0XQT+HD9qso5s8EnENCSt8tjZtWSRbY
 n/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726747292; x=1727352092;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D622eEAE72OxJ4FmYjcD5EIOaX5uwdFL2YIaI34EwU8=;
 b=Kc10Ko65qJ+UYjEA4oBI4/E39jr7hyq+mtgYMgWlszY4cMq5FxsETeIg0sUx7NPXX4
 BxTG8/C+xIT8iVqBtIzUCO0TdaGc9wA5bZ4RjYi9rYrcxtPjT8rUER1axMJhSfnnKk5E
 I3rWQlX5Xr212kAhhDf8tAVra+7c6Ooqi42JeBBijB7HjHFjQd9sGD3pfg9T/xUHZmkV
 Peid+CJeUqR8+mTRwqpGgWSUHoNl4lg+1l76kLjxLyyPOmCBaz94RsYck2Yksu2EABJr
 xWpw6bbbQif4ZZgVbOAjHgtNbVNJ1YEjF3xeBHSE/lCp9Av23VFLW6TBbG/xnPSv+YXX
 EA/g==
X-Gm-Message-State: AOJu0YzEGzFBKonl1O3J6b/WmG29NbQlLfZfJMv5B+EXOtzZsTl6+BHH
 edI735JmDkmxeOjinA2/CY22/Dju+2HNdShj0utVpLI3Cxad3tOvt60vud1vU97ESWBFGH9RXUG
 J2fUb3kNJ22w8kFFwwKK/Tb1hltEi6A==
X-Google-Smtp-Source: AGHT+IGZiN3EZ4h8GZBie2WgfOLgfEoLbbs5t2vDRsmzZbZcu8RLD/3Eltiedkl+KaeqWVP3f4r1N2gbWcc2DSbaHoE=
X-Received: by 2002:a05:651c:b22:b0:2ef:2f9e:dd1b with SMTP id
 38308e7fff4ca-2f7919079afmr118153491fa.14.1726747291416; Thu, 19 Sep 2024
 05:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240914005605.1827759-1-festevam@gmail.com>
In-Reply-To: <20240914005605.1827759-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 19 Sep 2024 09:01:18 -0300
Message-ID: <CAOMZO5B4ey5-UjsnRZ5EM929FyYXyc-E4jR4s9DVfZBW9ZGDYA@mail.gmail.com>
Subject: Re: [PATCH] imx6q-lxr: Add board support
To: sbabic@denx.de
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
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

On Fri, Sep 13, 2024 at 9:56=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> Add support for the Comvetia i.MX6Q LXR2 board, which is
> uses the Phytec PFLA02 SoM.

Applied to u-boot-imx/next, thanks.
