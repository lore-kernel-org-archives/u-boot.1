Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49DEC2BD09
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 18:08:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8C2888405;
	Wed,  3 Jul 2024 20:08:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kFnf6g16";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5E5B88405; Wed,  3 Jul 2024 20:08:02 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E29588881C
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 20:08:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2ee7a4f67aeso2248581fa.2
 for <u-boot@lists.denx.de>; Wed, 03 Jul 2024 11:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720030080; x=1720634880; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3NVMYvTx0VBTwla6dT3x00USIs19xc58hylPRzBHbWQ=;
 b=kFnf6g16U1Oh/lfiL9pROJQFq9zUGWLpLyHjLxxpdB1hwYMBl5XvvDe/J33MDzrqq3
 CacJhYmdFBDXG0XHcnXUjvllBajXWk1qWd86Dgq3C7wbMMw+acWpT96uQ0yeKYe50LmW
 0eCwznn9PG5x6aNoiPFxObjZt8wcQetlBjVMC/QqcjqabdHejjlM/yXdQSrzwZWZpi7K
 FWAEQGDijRG2MZjEfKgNrGaJx3AwYbKcig6zU1/NiEMKKlYvkfHEkMRpdxnMM898s6sz
 Q3w1yfweGc6iSoYAOBWvfsVq+ZC5+K5BH0RB4LN+BkQ0ereXsRFxUQ7S2DwlOyTZ5yTq
 5ufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720030080; x=1720634880;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3NVMYvTx0VBTwla6dT3x00USIs19xc58hylPRzBHbWQ=;
 b=lP3cuTYTZDgacCFFd2iprWdNywAKTVpm4t4UyJlZ5VdFKKUOIy7y2t2Ec7ErCEy4Wu
 SAaKr1suXWwhDCFxo9zTtEL3ejqnpNcvzdOhhIg3j89vAGd/V8JK/wrpaa4hki2n8O/h
 bqVZ+El+rdKYCrSdEJkAEu4WZv/nrsZuAHduF3edlpHf/OcVnFNfkJzogM7cWnMcgjvd
 Kee/6PFr8vrSf41fLluiG2bojFXULOgGKSOHzzGVdI/D0YNJNdM0WAntJySIC0Mfflwj
 ISJtBjn82/8KhDsAzXovYhWuXt8BNjhW35IuJwK4bhTbepaT1Z4LdMCxMEh5n/DquxTT
 Yafw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzCcNAj/stTAVGeFOga8TKR8EnFhTyz9GyIicELL0yvsJ3d//DM36wldsAcIxvgpbzggfMZet2ojOis2VUbVDMrrPb1Q==
X-Gm-Message-State: AOJu0YzdFXaE4ujRiaTLJhqRnOliZssdNKuYxEbvabfogDBtCJR4aw5B
 Kvrwv518+a0fJGqPoBx+1rruWMaUGge+8ZZblpd6uuZg7aqXwVpcKg4lhQvZ+PmA/L2k8vab8Eg
 QWp/7iVHJSfhuXgmn54/VEDWIVAahIuAT
X-Google-Smtp-Source: AGHT+IGaBoCtJcJUmuD/zR52z0jrpbad0uEY1bwZeJa03lJbvTau8dBzHoZ49bB1nt/eooHCegF8e0s02spof1SifWk=
X-Received: by 2002:a05:6512:e88:b0:52c:d5a5:bf7 with SMTP id
 2adb3069b0e04-52e8277120bmr8211847e87.4.1720030079695; Wed, 03 Jul 2024
 11:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240703175727.446205-1-festevam@gmail.com>
 <20240703180355.GB38804@bill-the-cat>
In-Reply-To: <20240703180355.GB38804@bill-the-cat>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 3 Jul 2024 15:07:47 -0300
Message-ID: <CAOMZO5Dej12iA7mX9MqMrrsj6oQ4SrNCAFN2vGuvOA_sq186aA@mail.gmail.com>
Subject: Re: [PATCH] msc_sm2s_imx8mp: Adjust the initrd_addr location
To: Tom Rini <trini@konsulko.com>
Cc: ian.ray@gehealthcare.com, sbabic@denx.de, u-boot@lists.denx.de, 
 Fabio Estevam <festevam@denx.de>
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

Hi Tom,

On Wed, Jul 3, 2024 at 3:03=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:

> Shouldn't fdt_addr_r change too? This is making me suspect the whole map
> is too small for safety, how much memory does the platform have at
> minimum?

It has 2GB of RAM.

Changing only initrd_addr and keeping fdt_addr_r unchanged allows a
successful initramfs boot.
