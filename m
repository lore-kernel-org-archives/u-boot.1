Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1400DC54798
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 16:57:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D61D8785A;
	Thu,  7 Mar 2024 17:57:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fes0Q5Al";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE94A87BA8; Thu,  7 Mar 2024 17:57:27 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 641B2876F3
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 17:57:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-299d76d3a26so30352a91.1
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 08:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709830643; x=1710435443; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yM8rmOxlJSTStsSve8nKbJfc1BXnfKnyFt/p3flTHHw=;
 b=Fes0Q5AlkuYDAMhznGqAw3qdkkl7Gt45eEgJtA8WQxyvue+P8ptoeqP8geY1piIlpk
 M4sHQhROZQJVcz8egDUT/bCh8oxUWhDXvHPAF9qwlYM4U3sIXFziOq+fO6hUc/VYtwm9
 +zdShRYMKyG8fN/nmj7pdVCYwglHnGH2HQh3nEP3lCf3XaKrieNymJQYYV2yJjF9ucLI
 3sH+CIdpNqeUmA0txPrfxV0o+ug+zE8sZfOQ36BXW02CTQcs75otcNtLwS92D7dzBAQu
 qC5fxMHlzkzczyDLbbHPOn8AUZvb4sACBBAPBf+snFbBfZjgiKLj/48nJybMoVEif43a
 fgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709830643; x=1710435443;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yM8rmOxlJSTStsSve8nKbJfc1BXnfKnyFt/p3flTHHw=;
 b=TrKXJYmWcdXCkjxhZkYUgVzpKkVpfIKNR9EF7c9NRYGaGqQppOnuiWdJ7zEkzDAM3i
 c/IFZhR7Jx8Q0pGkED+aNXi1R3t8RbZVZMo/UYrmLvltJnswdk/XpwbrM662tQXxiNlb
 ivUC0QXk5LIs4IMa2bZGBQOiuJRZiI69Hqm3WZnFyrKfyw6YpvxecpNVdFWozwuTBBBk
 YyfPhl9P/QU43Rn3mHjf8UgPGuSjuUw9uCGiXlm2Jng+JL/TtDQeJkyS5CsDr7OuFWMo
 Fkiiv+oZDZDHqRo1SLms+wPVAp+RLTjDcsymosZg0QTTeud3sYyInfs5oB+U3KyKPyj6
 vSdQ==
X-Gm-Message-State: AOJu0YwfV9aKPM5ztd3EJlbJsGMwQPY/89nxBWGfURdRMMMTXa9uqTnq
 9QP1hz5v1uX5iNqCyG2jnKexYKp3tbV6Lvz/0jc68mm4arMCdmRwWBsYrfU/XVGdpPFFks2suzJ
 kjULG6nltm7bGfuhCeT3+IcMVqqpmz7Uf98g=
X-Google-Smtp-Source: AGHT+IF5WC8FWIzw62xk2ezR2aprIDlokqeYIs3aTBpygV1AkqSvtk9Fqd2lDymiAN8w+1Czl4cxh1hpw6apc/WFEr8=
X-Received: by 2002:a17:90a:17a5:b0:29b:9a11:2a2 with SMTP id
 q34-20020a17090a17a500b0029b9a1102a2mr1422841pja.2.1709830643109; Thu, 07 Mar
 2024 08:57:23 -0800 (PST)
MIME-Version: 1.0
References: <BEZP281MB29655E047444C987850ED632AB202@BEZP281MB2965.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: <BEZP281MB29655E047444C987850ED632AB202@BEZP281MB2965.DEUP281.PROD.OUTLOOK.COM>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 7 Mar 2024 13:57:11 -0300
Message-ID: <CAOMZO5BhEmnVsmYdJgabZC1L6GrNc4WvMhRZNrFhemTvD3rpzQ@mail.gmail.com>
Subject: Re: U-boot fails for khadas-edge -v
To: Vivek Jaiswal <vjaiswal@cinemo.com>
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

Hi Vivek,

On Thu, Mar 7, 2024 at 11:56=E2=80=AFAM Vivek Jaiswal <vjaiswal@cinemo.com>=
 wrote:
>
> Hello U-boot Team,
> I am using the u-boot for Khadas Edge-v rk3399 rockchip:  https://github.=
com/khadas/u-boot/tree/khadas-edges-v2017.09-release-v1.0.0?tab=3Dreadme-ov=
-file
> And I am using configuration file : https://github.com/khadas/u-boot/blob=
/khadas-edges-v2017.09-release-v1.0.0/configs/rk3399_defconfig

That's an old out-of-tree repository, not supported by the U-Boot community=
.

Try khadas-edge-v-rk3399_defconfig which is supported in mainline U-Boot.
