Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E50AC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 17:46:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31FA3879FF;
	Thu, 28 Dec 2023 18:46:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Opzqk0+V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A68EF87AB9; Thu, 28 Dec 2023 18:46:41 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83885879FF
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 18:46:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d437a2a4c7so8784225ad.0
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 09:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703785598; x=1704390398; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pn0myI5QTsQ2iuph9Fj3iAyTJ2XZcLPMMUZvXzwedlM=;
 b=Opzqk0+VVBrA7/j76ES+Yj8D6S601tEnBY7usho2Mzt2eVlLhGhmtw5zSkYSvBHX1y
 OWeXCTxCI2wZ7LVy/bQzA4QSX9RqywlTM3Nk3i1upwV4wX8UwpFCNtE5MIXc3lOoSZu5
 j+m+QBWeAyt69rPMbn2DBWqC+Xtu7BVkXLxtOls84rEkU2hBlbVeRA+ndu1su28xjTm/
 7UHZr2nto52Fz+NLwbMdMbezB1vTgxFdtlAPu4Ipu2dOWJcjuz0DtgjlBo8VUBX1DHmM
 uCkSviDMTOyJZu/o2j/N1Ui7oJ/XPyzSlrfaLAkiTY/4z4g1YDcOH7YRF0wt8RjGblT3
 3K+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703785598; x=1704390398;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pn0myI5QTsQ2iuph9Fj3iAyTJ2XZcLPMMUZvXzwedlM=;
 b=mWPBJQaf8vlddf/aCRSUBPo62Iio4OrnSVY83Hpf0Ok7uFeY8NbTxO5oYgF+LezLYK
 b4Adn+uDtBZwlFcw1jSu5RyuQTAUWdNY1uy1DvjFd32J1YWq6wswGsflwNo1w7geOJMP
 6rfLe/57TNdxdUzXGrH6E49J7pvMxlpvXOyIppR4IiXADSDN/V6a/q4OSq2ZJjrJNzmP
 sy1ptVxOvgUSFSH2ZVFKe994WHrSAJhQnaNDZmxGRpNCsflozYeKBkHe4G9WH1llRMxt
 /iQTjuoSb1IBMRXTLAFgYnZayCZDRqObTnSOry67EnDYfgB3AUWUN6NMgGdphKIZOinb
 rQGA==
X-Gm-Message-State: AOJu0YyDYzlXSmarfov6MVXNb243sVW23GOFwBevuNFNf8xlJ6XPzATe
 3fY0n7TadtNFUIqRbDc0O1piFFWG3SeaE56aAtk=
X-Google-Smtp-Source: AGHT+IHXiU0k/I9Y2EYvGfneNy5OJvq44tjg9teOkja1ck5VrMQt1dDejJHY+MKQT+MehQakcG1wXYbi3esox20wwnA=
X-Received: by 2002:a17:903:18b:b0:1d3:9a7d:a39b with SMTP id
 z11-20020a170903018b00b001d39a7da39bmr2264747plg.5.1703785597677; Thu, 28 Dec
 2023 09:46:37 -0800 (PST)
MIME-Version: 1.0
References: <ZY2ZDWAQuTlRjV9H@francesco-nb>
 <CAOMZO5BSt4rbdSDNrcchg89qYJ6kK2nkHLFqfjdu21H_joU-jg@mail.gmail.com>
 <ZY2mVMg0532pbuFh@francesco-nb>
 <CAOMZO5AeEWRbpYsNDhno3gEo-0ab01Kd62v8inDt6V40BLqp5A@mail.gmail.com>
 <ZY2vJYySJ5CL1PQG@francesco-nb>
In-Reply-To: <ZY2vJYySJ5CL1PQG@francesco-nb>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 28 Dec 2023 14:46:26 -0300
Message-ID: <CAOMZO5Ajj1oqq8KEAQvXwPpRV-1eVD8PZG6U+stVDsrXtevpSw@mail.gmail.com>
Subject: Re: Regression: i.MX6ULL reset not working
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Stefano Babic <sbabic@denx.de>
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

On Thu, Dec 28, 2023 at 2:23=E2=80=AFPM Francesco Dolcini <francesco@dolcin=
i.it> wrote:

> Are you sure? After the related kconfig changes you'll have CONFIG_WDT
> enabled, and with that the watchdog is started and you need to
> periodically refresh it. At the moment the watchdog is not enabled at
> boot and it is used only for the reset.

Ok, I understand now what you mean.

> While the change might be fine, my concern is that this might affect some=
 use
> cases. Debugging? Kernel not having the watchdog driver enabled? Any
> other fancy use-case?

I am not aware of issues in this area.

imx8m boards handle the watchdog via CONFIG_WDT and I haven't seen
problems with that.
