Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D766AC83F1B
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 14:06:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47A4F82FAB;
	Mon, 14 Jul 2025 16:06:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DkaqGbF7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24CF883043; Mon, 14 Jul 2025 16:06:04 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 312EB82F49
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 16:06:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-558fa0b2cc8so3411267e87.1
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 07:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752501961; x=1753106761; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZeVU3qp0my9Ba0iJ89nEBZmL2j3ZoL7vYX/sIN2Qo44=;
 b=DkaqGbF7t7dCS9QB3olrXJwMi5q6b5juEpB3CtYyANR4JzS4Ki3++YlAOctjMLEjQW
 0uSpdqjRVYgwL/byf4x2Eda6IITfT3MZwc1gCb3c0gNz6CdcMn3SeI5D3RCUa1YXOGeV
 z8XfsVatTMQPlEnxjPthEqIvnljr7WYyp8hSEujMXChmUEt0P+dOOzndAPaFZbP1ApGN
 wsu+hu/UTMfXkGgXrjqy5tKLQhjN1dMtlVFD+1d1ELY2xjUcIkf2wdT4GraB1k0MOpK6
 X3TEUx8j/sRPbUz4+Y/Y1Tjp95CsFMM/7qJt4IP3uc4SbaiUId2+HE+O9DDJPQofU58n
 zamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752501961; x=1753106761;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZeVU3qp0my9Ba0iJ89nEBZmL2j3ZoL7vYX/sIN2Qo44=;
 b=VgBJgTbE2gGHbKa3/T4eRypZy4oX23nfpNsSdpFaLJOk0OY3+bgsKm6dGQpTYTD35f
 zG80uoSV0fb+0OjC7S7TuooisWrsZi0KSHwpMwBbvdjTBx8pg8n+ZoDRlt9EzLqgWYHW
 lTsX3HgZLrru/fVA2Mdjdzwt5PJRHkTB3RlllwbEy1HxKpdMh9qRvINvRgskVZIMeQD6
 EGT21Ef1kCREai7trrx5+MMFhbkVZNAuyikfFXAorR1i95avztDycI0fmwWdAcz3GT/H
 2USFr6CcIxGA169H5vs4ZAt2MLG83CbpsyH0quq8wVVEV4aoE6YpQPsmV7G8+p2WWGDQ
 Qq3A==
X-Gm-Message-State: AOJu0YxtG+WUvalzinSlAe4GR+qJs7ZJESkokbe+2WCSPZCpzOMKKrL3
 eIY10uFNMP5Bd6oExtNctg8DvFuwIhPEn2i5rl/wU6/OGkjEZbkYBlqaZ8nvdDanFBiSVU0dJb4
 eW6gppzzsEgKOH7aLR9vZvq9adQBgwWU=
X-Gm-Gg: ASbGncs5XEwmIR4a6BkqNQQKGmQbMtxX+P7WJucM5UQKkTFbRsWfki+5tZFAGYfycJj
 OUkDlrI9bfU7VA59gqCYMk/9DwxXUdFGyUtwm5etGFar9v3esRKSXpw0oY1CFNqSR2WPvouaFPw
 vXsh9P0TGxUuvyyhncfzM+w5M96RNfAzVeLfxnfckD5GwzDRlZnuascYvVBWbF5cX88yoMyZDKH
 jgFsR4eFYQeW0OU6k0mCPirFF5IYwpxaw0bsZI=
X-Google-Smtp-Source: AGHT+IF41PzZ4J3g9JJY9MIaLNT2pJeLGKw62L/Elqjbk7W98INqhitzvIHlixzTv/OwJcEssso1cZHPWp1blXpNxi0=
X-Received: by 2002:a05:6512:b8a:b0:553:5d00:be84 with SMTP id
 2adb3069b0e04-55a045f06c8mr3652795e87.34.1752501960365; Mon, 14 Jul 2025
 07:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <BN0PR08MB6951B4921AD52EDFA06E885D8349A@BN0PR08MB6951.namprd08.prod.outlook.com>
 <BN0PR08MB69511CACF429DE68924BCB348354A@BN0PR08MB6951.namprd08.prod.outlook.com>
In-Reply-To: <BN0PR08MB69511CACF429DE68924BCB348354A@BN0PR08MB6951.namprd08.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 14 Jul 2025 11:05:47 -0300
X-Gm-Features: Ac12FXwnoh9cji3gf-El-8Rh3NCfPwytY3udeg80Cqb87IYaD6pPuc-oLS5kJBM
Message-ID: <CAOMZO5BXVuLnCUF1CCLMm93pcqESv_+fps-8GFXPZvhcNGbugw@mail.gmail.com>
Subject: Re: u-boot corruption from EFI CAAM RNG request
To: "Anthony Pighin (Nokia)" <anthony.pighin@nokia.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "gaurav.jain@nxp.com" <gaurav.jain@nxp.com>
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

Hi Anthony,

On Mon, Jul 14, 2025 at 10:04=E2=80=AFAM Anthony Pighin (Nokia)
<anthony.pighin@nokia.com> wrote:
>
> > u-boot is being corrupted following a Linux EFI callback to get_rng(). =
One of
> > the many footprints is a corruption of the EFI protocols linked list.

Which SoC do you use?

> Here is a proposed fix. The caam_rng_probe() init might not even be neede=
d, but I left it there just in case.

Please send a formal patch.
