Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B43C54749
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 01:54:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B46D88875;
	Wed, 28 Aug 2024 03:54:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YdF0FrA7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5095C88AD7; Wed, 28 Aug 2024 03:54:49 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BAF688800
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 03:54:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2f3fea6a0a9so1181381fa.0
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 18:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724810086; x=1725414886; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2nMBslhjtHzbxwaNrIuUzlyTPFXwOHCsDBZ2n7Krp6A=;
 b=YdF0FrA7l74bi8l15vbZzRbq0GX7k2OYGpLyZL//ZmVVyrQfOpDbbs+WcpkH1Ll0M8
 u7P7iQAjGojd1nDknBTXzaqLnI/tQc07BZKgri9/iLYjUAwQP+leeZSFB8IzyzPCqEsn
 +FKoFyaPdGdRSVGXtvWAGs1zlancwpVejn5Ebo8UIBKrwpxgFMFvqGPVehC/yV+BGaJZ
 fPsiQyz0H5CWBoOY7CjwCZrvZiT9kXEE7rmbW8c8fLjtmSZerA3ytpBDby505pf4oNlK
 E9zBmit+hzwTzshGYX+7NGQV8SqVXZCE2ipkvyqUhZ97K7GnHtQ6p8RdBvJMwiEdGVth
 Ghvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724810086; x=1725414886;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2nMBslhjtHzbxwaNrIuUzlyTPFXwOHCsDBZ2n7Krp6A=;
 b=TT0LFH7eUsydse3YPcsxKZUpSEueXqJVnnsinbYSFf5awWpo3cJsmbAEwHtEITXZyD
 fa+S47/mmw+ZdYqnXH/svokQWjEg/PaGBJM4Dtt3EBeJti74Dl/uvbYMX9thDmkKxXbr
 pGxTFJl9yKCRf1IoAzFGvxCy8Efi80GFh6NhHt2UWXb9l+Lb8AcFIj2rGS91m1Btv8dT
 jxtbdiHv/yFJI1SVMnBe2pWUPTkAxsCmH+LrfmqIycjenDwXKNAVnwXIDVFm39oansR/
 SKSNxqRjeYRmEa6WTbzoq0AZ55mIF5082wUarR1BDLYPCflzdxWWGDMz+vUUmy9MmCRD
 Vk1Q==
X-Gm-Message-State: AOJu0Yztv/pxwzDSC4Pk/E9O6+gk5xu65oaVCfDoXRK2HkFScO6IrkeM
 tx/9LedzrpQL62shq0Ukcqa/JDL0kFGM/OFx+EwcGwq6Q50oZcvtIt7p8JtCLhraNcP9kX+RzPH
 yesvz4ogiOsZLWDPkGaYzyCTrxBY=
X-Google-Smtp-Source: AGHT+IFyCiKgkBN8vdTWRppvESQ9cOZCxF5WGS+CFz/3Pr+DvMuStF0AuXjZJQYMfYOsPP30QvrlelQgdw2wax964MI=
X-Received: by 2002:a2e:9a12:0:b0:2ef:2843:4135 with SMTP id
 38308e7fff4ca-2f523375fd7mr1622521fa.22.1724810085748; Tue, 27 Aug 2024
 18:54:45 -0700 (PDT)
MIME-Version: 1.0
References: <GI.Za6b.48b6UC5Rsur.1cpWwh@seznam.cz>
 <CAOMZO5Aj9zSEWF9Gm5-tF9hTaczf6FXv0zo_z+Jws+BGPYPwrg@mail.gmail.com>
 <K9.Za7d.77W3I8GjZaJ.1cpYlf@seznam.cz>
 <CAOMZO5BshEknpJEeEiqip3e_YkN21kAKtKva0ik=8SKGJxmngw@mail.gmail.com>
 <CAOMZO5A1r4F403efkpAPbv9zJD7bjv=aHB8SgOK3pPXtVvzE2g@mail.gmail.com>
 <Mh.Zbul.1u3}4uost4Y.1cpdu8@seznam.cz>
In-Reply-To: <Mh.Zbul.1u3}4uost4Y.1cpdu8@seznam.cz>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 27 Aug 2024 22:54:34 -0300
Message-ID: <CAOMZO5AG_e-TCToM_+VJXJnBWJ81eT64MWRfnM6BnsehMLTBZw@mail.gmail.com>
Subject: Re: [PATCH] gpio: mxc_gpio: fix reading state of GPIO pins in output
 mode
To: Tomas Paukrt <tomaspaukrt@email.cz>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
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

Hi Tomas,

On Tue, Aug 27, 2024 at 10:31=E2=80=AFPM Tomas Paukrt <tomaspaukrt@email.cz=
> wrote:

> I checked the current Linux driver and it uses the DR register for all ou=
tputs.
> This change was implemented about a year later after the mentioned discus=
sion:
>
> https://lore.kernel.org/all/1430321701-13758-5-git-send-email-vladimir_za=
polskiy@mentor.com/
>
> So both the Linux kernel and the NXP U-Boot work as expected, but the mai=
nline U-Boot does not.

Good point. I missed that.

Could you please send a v2 pointing to this commit in the Linux gpio-mxc dr=
iver?
