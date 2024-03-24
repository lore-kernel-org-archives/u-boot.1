Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18431C6FD1F
	for <u-boot@archiver.kernel.org>; Sun, 24 Mar 2024 17:54:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 563C087527;
	Sun, 24 Mar 2024 18:54:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b4P6woQ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20A3687519; Sun, 24 Mar 2024 18:54:22 +0100 (CET)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D308187527
 for <u-boot@lists.denx.de>; Sun, 24 Mar 2024 18:54:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6ea7b38f773so280569b3a.0
 for <u-boot@lists.denx.de>; Sun, 24 Mar 2024 10:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711302857; x=1711907657; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7zu1LHGswR4FJ49JO8vEGF5f++K0HXmt/XOCKZ8cRFI=;
 b=b4P6woQ0ZUIkmsriq6XBeZl+blSs/59ughntJ81XIqzDF5kE9ikJTSmwVt7KFSKAZQ
 yLel6fSOhlSVBeDJwrr98UFq0IxQ2VrI2FeMCBqEoewQnRH18Q2CVRuGPn/L9TgpL9sE
 rcnzjNpESnPjbnRjXFixUDaHY6C7rlaKlaeHYR5cnI9NPGe7NnOeIH0VYQlubmIHWZ99
 Jh1amm7fO4gV21HhECj2Xzyh3zhmOazoiqTNRbBbBHk+X+SSS/fRzUFbn0LQzzx97PYy
 V8QY+znnrfluK05aKyHJyby/xY7lD/4xZHmGaqT+8QsWaybY+dPqXwLSZ/sYVnBSlJBo
 4B8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711302857; x=1711907657;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7zu1LHGswR4FJ49JO8vEGF5f++K0HXmt/XOCKZ8cRFI=;
 b=f53jfET0mq6ztI1ErRkVV9R7p0HGuhYYO7Pw3nmgIBih9akGQAvurngfc3AkqcIPnN
 ml4RGzLEdgZQmthqSKABv8/aFDFu3WpBlyBLLEY5izhnN9ptbPrH06DZCSMl3jPehyzS
 Sph+4hRtC5deEeE0nuRytB/IkNzjmgVS3Q1nvgKZ5Ot9abE4msVpE5PFCyxXrXkuMWIz
 4oE5kMg6q6eEfPVH0SV4G1/iK2uArPeca2DgQ3PFzoer0+kgRDP6uFSlJqcYWvz4Jz0t
 pyP/Ij5wsOY85/5pMG/McVsdPX5hlFom06sb5IUS2iv9CC175RyQoBie2ns2qv3hbRM1
 Jd3w==
X-Gm-Message-State: AOJu0Yx4cbd9mKCxIM+gTYKsIsbCde5mVNA6ole8tqISJtcPoEhpqk8e
 5sAwY1p4FyGNbJzv9F0Us6NxCEewgujVgatBfhO26TgigHUSzQ6WHELuX80Vo3JfgXzgo3CU5Qy
 VXAteMgdf+EaQ2swnh+w8HLwjELE=
X-Google-Smtp-Source: AGHT+IEprW8I+2Q4ms+fmctbaLuNz5FTU9Bz1Z5M7UjxJWcw+In/xn5zb8mHVEDecfUVlsJPBxdgyM8nKSZ1ix7JZUM=
X-Received: by 2002:a05:6a21:a598:b0:1a3:a936:eb07 with SMTP id
 gd24-20020a056a21a59800b001a3a936eb07mr7385484pzc.2.1711302857377; Sun, 24
 Mar 2024 10:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240321145507.619448-1-sumit.garg@linaro.org>
 <CAOMZO5DjJRRRi8ujbMu0ypCwXWbymt_RTtdviUhNAcknQN3-Vw@mail.gmail.com>
In-Reply-To: <CAOMZO5DjJRRRi8ujbMu0ypCwXWbymt_RTtdviUhNAcknQN3-Vw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 24 Mar 2024 14:54:05 -0300
Message-ID: <CAOMZO5BnuH21=H+dkKeDOkYkq+y3v1jEFMMH1AN5X+jetVzh9g@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] imx8mp: Enable PCIe/NVMe support
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com, tharvey@gateworks.com, 
 marcel.ziswiler@toradex.com, francesco@dolcini.it, lukma@denx.de, 
 seanga2@gmail.com, jh80.chung@samsung.com, sjg@chromium.org, festevam@denx.de, 
 andrejs.cainikovs@toradex.com, peng.fan@nxp.com, aford173@gmail.com, 
 marex@denx.de, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org, 
 fathi.boudra@linaro.org, remi.duraffort@linaro.org, 
 daniel.thompson@linaro.org, pbrobinson@gmail.com
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

On Fri, Mar 22, 2024 at 10:51=E2=80=AFAM Fabio Estevam <festevam@gmail.com>=
 wrote:
>
> Hi Sumit,
>
> On Thu, Mar 21, 2024 at 11:55=E2=80=AFAM Sumit Garg <sumit.garg@linaro.or=
g> wrote:
>
> > Changes in v4:
> > - Incorporated misc comments from Marek and added his review tag.
> > - Dropped patch #4 (imx8mp: power-domain: Don't power off pd_bus)
> >   since power domain off path is never excercised for DT based devices.
> > - Added patch#8 as suggested by Peter to describe older pcie_imx.c
> >   driver as legacy one.
>
> v4 looks good, thanks.
>
> I'll wait a few days and will queue it to next.

Applied to u-boot-imx/next, thanks.
