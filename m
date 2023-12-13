Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2603CC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 19:51:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 091C8877B0;
	Wed, 13 Dec 2023 20:51:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M2PVFjVr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2752874CC; Wed, 13 Dec 2023 20:51:03 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48E5D87579
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 20:51:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-dbc666461daso4594756276.0
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 11:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702497060; x=1703101860; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UvFnjdfBNgT+0GSt2FUbGRzZQlgRcGURIgBr4RDM1h8=;
 b=M2PVFjVrcPwTvqEuVKZ0qLbuhB0OoSvrFxqoBXyJQ3RF9/7DDQiW8rq2V27vwNjTMH
 LkAKqc7K6qPm9/O8egUZTv3yO4TS+hf32gY3mYzWx4JpmCmF6+8gQRy2gcw24WUEHfZO
 TfacHBjI9cQAe0xEZxFf3wp66MqQ+OQlTzF0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702497060; x=1703101860;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UvFnjdfBNgT+0GSt2FUbGRzZQlgRcGURIgBr4RDM1h8=;
 b=U/Ykge2SKRluPUUUqhvjgZaOohQuHtjwH3crVBdAPqUjVGbSlQze7We8BvxjzeMIRb
 s2ch6bTMouu5vMI2ByYP6Rvsk37RHFGXOr1hAnLuIbFqBIYGWIe/WLuWgiy68FVel0qt
 jWR1OyQMa9XVhNZmqPKQSnv0L1tMvc0cwS5dmplkuTw++2tLHuUwJiYagXLAPoaSpFUQ
 tu2Mr6xVjl8prwZzvw9Oiu5NgCK9Jniz4si5haiZ4nOsdf/DZkBDdbHOJjH+KYPDU6aa
 0Bwi7Pqc0O6/P1N5vcIuJHWpG60n8DVCkSSk96q6ev+5H+DU0kpbujED7HCG5x92Krbx
 4sSQ==
X-Gm-Message-State: AOJu0Yx3RKUhcXsIjGeTb6PhLmsR+GG1TgP4gXaXxfe8//H4kjkn++0p
 v36FcxaGsjal3oQG+5MD93zZKYZ8ma02ZeNYE8gijQ==
X-Google-Smtp-Source: AGHT+IHpsVQVcg3Cvjy406xsm6Di/1/Qp3IaiT6Hsr7kC3xVlztLhBBtoaweaJtlXsKT3XUODV80WoLy773B13s2osA=
X-Received: by 2002:a5b:58e:0:b0:db7:dacf:6fde with SMTP id
 l14-20020a5b058e000000b00db7dacf6fdemr5814855ybp.102.1702497059654; Wed, 13
 Dec 2023 11:50:59 -0800 (PST)
MIME-Version: 1.0
References: <LO2P265MB2605C61E483A315CC62D1DCFDB8DA@LO2P265MB2605.GBRP265.PROD.OUTLOOK.COM>
In-Reply-To: <LO2P265MB2605C61E483A315CC62D1DCFDB8DA@LO2P265MB2605.GBRP265.PROD.OUTLOOK.COM>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Dec 2023 12:49:56 -0700
Message-ID: <CAPnjgZ37QpGjJHevWDF_N=eNUKNL5TguewG-y7JMNuDkss2o2g@mail.gmail.com>
Subject: Re: whitelist commands
To: Thomas McCann <Tmccann@drumgrange.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

Hi Thomas,

On Wed, 13 Dec 2023 at 07:29, Thomas McCann <Tmccann@drumgrange.com> wrote:
>
> How do I add commands to the whitelist.

Which whitelist are you referring to? I am not aware of one for commands.

Regards,
Simon


>
>
> Yours sincerely,
>
> [cid:image001.png@01DA2DCD.383194D0]<http://www.drumgrange.com/>
>
> Thomas McCann
> Software Engineer
> =F0=9F=93=A7 Tmccann@drumgrange.com
>
> [cid:image002.png@01DA2DCD.383194D0]<https://linkedin.com/company/drumgra=
nge-ltd>[cid:image003.png@01DA2DCD.383194D0]<https://www.adsgroup.org.uk/ab=
out/>. [cid:image004.png@01DA2DCD.383194D0] <https://hellios.com/joscar/> .=
 [cid:image005.png@01DA2DCD.383194D0] <https://www.cyberaware.gov.uk/cybere=
ssentials/> ..[cid:image006.jpg@01DA2DCD.383194D0]<https://www.drumgrange.c=
om/about-us/armed-forces-corporate-covenant/>
>
> .
> Drumgrange is recruiting! For more information, click here.<https://www.d=
rumgrange.com/careers/>
> .
>
> =F0=9F=8C=B2  Please consider the environment before printing this e-mail
> This communication may contain information which is subject to UK Export =
Control Law, commercial-in-confidence and/or legally privileged and is inte=
nded only for the addressee named above. If you are not the named addressee=
, the communication has been sent to you in error. Any copying, distributio=
n or other use of the information is strictly prohibited. Please note we do=
 not accept liability for any viruses which may be transmitted in or with t=
his message.
>
> Drumgrange Ltd. is a company registered in England and Wales with company=
 registration number 1460044 Registered office address. Drumgrange Ltd. Uni=
t A, The Forum, Hanworth Lane, Chertsey, Surrey, KT16 9JX.
>
