Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE96C531DC
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 19:18:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 593D78843A;
	Fri, 23 Aug 2024 21:18:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a8x0fsoy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B65EE88B23; Fri, 23 Aug 2024 21:18:41 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1B348843A
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 21:18:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-533488ffaf7so3162865e87.0
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 12:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724440719; x=1725045519; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vkeIHwChdwE3kuZHQJCSDjiG+P+/sJLNji7c40nfdjA=;
 b=a8x0fsoy5RHAews0WHjvyf9OlCbw4bVSlPd8KeMAsVb9xDnwVki0VYh/7KQnYYodFh
 8xJPRjm8P3tsUo+VIbD8MyNxhjF6Zn8pwup4xlLbPcHiLOwF6ChW7318Lr70aTofsfaA
 qDY4CbJFeND0Ti8nClSmu53l5CgfzJcS58+bXlgtH5EISJmMb5TTUx9wC624qyyUC1Wk
 INcLTmqCtLWo92wHoClZO/qjEumBwbRIL5+kuNaxfueRqLb54Qbbmqid6SFwPkJxEx0t
 belNxT5Ib/zQQozuCTkoSNs4/N7Z2MVLP+0wTai0ugkUIVMGSl6UxeWt9y4ypLPDoAIL
 6VLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724440719; x=1725045519;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vkeIHwChdwE3kuZHQJCSDjiG+P+/sJLNji7c40nfdjA=;
 b=CIRjwhXFT8YGDf3njhfAhUCiX8uVwLtK74CBerv03QLQ1646vpToLi66OsudnWGvEM
 v3FBt2NyyuGKm1t6sHW8FFlWglrKVOP4cJdfdZS2f/2wcrAWU8q0KPEAxLchDD3/fGEn
 LEczU3fgPanaXt1Rh8JncLnkwQrPS3VP+0U4qU7ZFgCSPEv5bw3YAnKBkNNlarG0suY6
 bZ05PU3WCEa6ID5uHMp2K7l71sLea9VCOb3EMGXRlX/4Nia+t9g/7xXgfnUoaaCeLKc/
 7aYXpW2ldL+3+fzJyjBeSjOjuNgFaMBETpKrQ+6brnq8Or8wAlBQ3e+ac3aRaXIx3JKK
 I8Qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsvgsUk0dirlIlPIecxFjR9UvHaAU6SEfRVVYVPPSCi91SjlMc1mmxePWbnsKYcwf1i9P+PNQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yx4Ngd/9mWY7cHfVkXNKwPMla6VwfMI92RVNikc3tw0cZZ3xtI4
 YI713QqE7yzgFWkd3dq1JLes+oNITF/fd+24gVbJkKzK0fm7ex88KQxOrx6Jti2WAtJas15OH7H
 y9eV3Blfc0fcbRDpDYRtn0NdcMtGBUw==
X-Google-Smtp-Source: AGHT+IGDqXp6/m36xzqQ6XHBjPh50choq9b9APxNf6gg5hQCu5EIr+DsDuH+iqKy8ru56slxjlyFDDYP0C2xLhz+ejo=
X-Received: by 2002:a05:6512:234b:b0:533:482f:afbc with SMTP id
 2adb3069b0e04-53438783db8mr1976599e87.32.1724440718830; Fri, 23 Aug 2024
 12:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240820044802.12401-1-othacehe@gnu.org>
In-Reply-To: <20240820044802.12401-1-othacehe@gnu.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 23 Aug 2024 16:18:27 -0300
Message-ID: <CAOMZO5B_RgZbOqrb-yah0Ta+UPE3r=mYyemuN7Eq1LVKXTfknQ@mail.gmail.com>
Subject: Re: [PATCH v2] imx: ele_ahab: Add HUK derivation support
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>, 
 Sean Anderson <seanga2@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
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

On Tue, Aug 20, 2024 at 1:48=E2=80=AFAM Mathieu Othacehe <othacehe@gnu.org>=
 wrote:
>
> Add a new ahab_derive command that derives the hardware unique key (HUK)
> into a 16 or 32 bytes key and stores it at the given address.
>
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>

It fails to apply.

Please rebase against uboot/next and resubmit it.
