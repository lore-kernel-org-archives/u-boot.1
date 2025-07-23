Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B5E4C83F17
	for <u-boot@archiver.kernel.org>; Wed, 23 Jul 2025 13:29:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0616834A3;
	Wed, 23 Jul 2025 15:29:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QZB8AKQc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6E6E834E1; Wed, 23 Jul 2025 15:29:40 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B70C183440
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 15:29:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-32b3b250621so60758891fa.2
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 06:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753277378; x=1753882178; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CvzJGV7UtigvEFdF35FbqBdERkeXjUeXnLqfzUUegpE=;
 b=QZB8AKQcLcnakCa+MyfXT5hSy6F+q6p/j7sroqN53Ytcx0ps8WlGLTh3og5XQMdY8U
 6ywtCCyNxeYKWWr4XssAz6z+g5GutGGRncEeHKhFVkh65kt6Oht5rvFqtPf+hgtU7HDn
 zW2QJEIQ3Whf07/WdmVpk19/s6EI2/Sa50ikP4+vE/Dzl1X5/AbQUiG2ZutqjBEEK4Bk
 JGfmlWkZW7F5FXCSqI1hqdDyZfayWnwzP0o1JAEiB3243aw96BXcDbI4+T8Dn9i2RkXR
 e30rgvgfzesjOI1WCnaI9t7Mu+sG1XNKh00jRfouv7rK+qZp3ZnCx0zOUgyNp0mT/VvP
 ZdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753277378; x=1753882178;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CvzJGV7UtigvEFdF35FbqBdERkeXjUeXnLqfzUUegpE=;
 b=pOqIG2HcYn6H+Tfy70c/qqF83R8BEjbzR/K0de1nF2rW1L/XQ3j2DvwYyugy6ASSjD
 /nS3uYQPUlySh5Q9vhBHYNAzIx8l5RNu1olhzJMttKeVghEkUMypOyxXiH7tFXLi/Act
 4tsFXDXpcDXgUGUBmgYUM4KrmP6004Si2PuoCW4MEfLrVpuCqOUay32QAOiUq/CrKoBH
 iHrMO+BELNpzPegYmyG4aNcd9zftNPnoFP/ZANze8+OKhH4vfUTXV5F7oiKKiTgsB0/y
 GZ0LwAvCCIfr12cSxVctyZq4yPGezLBdQS/EBDTOR8qbLDWRNtyTAeGnNLI7zqICMs8a
 1RBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpIf7kdnbjsI+j976PoZppgQLb84Em/nuN8UiYx8VUiaJp+DdfEnDUX1fq3fsGEJyPZ6/K7is=@lists.denx.de
X-Gm-Message-State: AOJu0YyHZ0GFIb33Gkeri6PVL1k2tRYX7hOBKjIpNC4qBpHdX/WAdyss
 iZFbnn2TEuYDIpyXmO76OVzqjuSBbOLSN29ImMNh4ZcCyh2qPOQN9FfujMNjV3MK2vvCy2SPg7N
 iMEAZyjkMEQHt0DWwN0ghyys3pJ5pNXs=
X-Gm-Gg: ASbGncuLhbkTnLLLmFPS0mezjWjjLzan+IJ/RnRHrMXThtdqNuDbOnoZAJORkbLh4Wf
 4sos+yrBC5PJxVbOIPVwegz1pD+UNM6MLKNxHr/OHAHakHte6U9Wm8nRkaqGfutc8Rhl5F+ehQM
 PWgMawuc+yWraW3Befp4PFI66vEEDWuFJKusCTPiQ9Qz4LzxVw6uitoSZMvKB6kVotzcDDJBxqU
 Y05pNiW/iuhSGOrKk+arcrhxkUuk1NJ4uUyJh+rcidGA1bbVA==
X-Google-Smtp-Source: AGHT+IFn7JIrxkhNMN3N+kPhIcT3uIhemLht1Zj3F6whLSU5XJkza3Kga0YVCbAl5vBv4UrZNx+3w3YhJhDPzjMIDuE=
X-Received: by 2002:a2e:930b:0:b0:32b:8e4a:5717 with SMTP id
 38308e7fff4ca-330dfd1f979mr8429141fa.25.1753277377565; Wed, 23 Jul 2025
 06:29:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250722203736.1792103-1-festevam@gmail.com>
 <20250722214025.GJ2847763@bill-the-cat>
In-Reply-To: <20250722214025.GJ2847763@bill-the-cat>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 23 Jul 2025 10:29:26 -0300
X-Gm-Features: Ac12FXzDzPhP-2gAlF1b-OdXp-DCgwfPtgu8mE03B5BuDxEB3JSFOLh66cZhziA
Message-ID: <CAOMZO5AFnmfwDG0Rj=msa9BJfScNRcQq=OCW1trsm09St3edog@mail.gmail.com>
Subject: Re: [PATCH] imx93_frdm: Add initial board support
To: Tom Rini <trini@konsulko.com>
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de
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

On Tue, Jul 22, 2025 at 6:40=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:

> The bootph stuff can be upstreamed.

I agree - the upstream i.MX devicetrees in general can be improved in
this aspect.

> > +#include <linux/sizes.h>
> > +#include <linux/stringify.h>

Fixed in v2. Thanks
