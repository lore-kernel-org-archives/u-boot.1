Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E546BC54791
	for <u-boot@archiver.kernel.org>; Sun, 10 Mar 2024 19:18:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47FA687D2D;
	Sun, 10 Mar 2024 20:18:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GjtUeeNt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AF92879FC; Sun, 10 Mar 2024 20:18:54 +0100 (CET)
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com
 [IPv6:2607:f8b0:4864:20::936])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A259877AF
 for <u-boot@lists.denx.de>; Sun, 10 Mar 2024 20:18:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-7d5bfdd2366so1924860241.3
 for <u-boot@lists.denx.de>; Sun, 10 Mar 2024 12:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710098329; x=1710703129; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=otDUmL1IAXb65MtXKkXB14Mbpo1Tc0vkyXtPK1QW2aE=;
 b=GjtUeeNte5W+W3GZ8khsq21VCLIBXu3heKv8FVvbHae+21d3bqoPdHcmnJ1joNV8Rr
 gDGwccsftPl8bcxYqyfk1LPQ946QfbbWymMxxlXODCcsHBloyh9uHs9Uwg1ZAlw9R+fJ
 EIpLEa0g/HrVpRfIAt5dZbJCjy9hO3DRYEW++fRdvyUyvZ3xZBTSIepIYFPsVPOUOsPU
 oVudFQiiCkMNR/utqbpnldR+CTafbNOSRECl/O5OrtuESAnTELdg1Q+lnqVdG6ZZqFCX
 wdygTqDij6B63GcDrsmpaCa9UMOF8ayOAwiKu5S0LVbb5gutimpp3Zv8uOgoTHk41J0u
 TREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710098329; x=1710703129;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=otDUmL1IAXb65MtXKkXB14Mbpo1Tc0vkyXtPK1QW2aE=;
 b=OxFoeEtXknNSaXU9pkDCVn8eSh1Viwsm71wn3iWFGHM9b/RoXSNWYsXygWtIQIu3C8
 pYv7WGyVGZEyAodklnFwpeimJVZho6WZTFO2ep5oGANRsDaJ7dB4XLT+R+0t7u4wToRX
 7Q5+Wal968IlMK7VSkLgS5lZOggIb8zi43iwuX7CED952+Q+YGStjrvcdyZWSuGT9UpP
 eZJIZKAumM+BkMF9NHyv4m3As0tJZQ0Q5gLp89SxHPi7zBhIew8ZpikuAqkIJPCFvweD
 kFF7QJp08eyCdNU273qJZXfUbNTuYQZk1NWZJDo8ZUyiyvXKT/JhxEX9fCKOlbA1XIqe
 CDgA==
X-Gm-Message-State: AOJu0YwuKkU+Ja74hvViGHGY5XeZ7VjbEWFfaX+fZu//5XAJmdHC36c+
 uZh8H99SvVN5rUPHYzG0yKDzcauh4/NouJYXopxWd26qvxPcI/di3LrV+fhxnrDM1BYk3OoX7WL
 v9iovyrgHlO8xdULWnvNV9ZI4sGrfUogx
X-Google-Smtp-Source: AGHT+IGjpiRP+JCnSIiINaTZpcpHVpKGs6aprWpSyRQuZC6Y4ieXMMSTUXJBDp8JwKt5Uqz86LT9kvB01H1bNqBdJmc=
X-Received: by 2002:a05:6102:50aa:b0:473:3070:b6dc with SMTP id
 bl42-20020a05610250aa00b004733070b6dcmr1013372vsb.6.1710098329260; Sun, 10
 Mar 2024 12:18:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240303130122.29983-1-heinrich.schuchardt@canonical.com>
 <20240303130122.29983-3-heinrich.schuchardt@canonical.com>
 <CANV2PTNbhB1D32pK9nVKi0MNA=G-ooP=qcJBcsaEGMNzaxo97g@mail.gmail.com>
 <071b1819-ecfe-4ac3-8e86-e9f3dc920b3c@canonical.com>
In-Reply-To: <071b1819-ecfe-4ac3-8e86-e9f3dc920b3c@canonical.com>
From: E Shattow <lucent@gmail.com>
Date: Sun, 10 Mar 2024 12:18:37 -0700
Message-ID: <CANV2PTM=jhUMzUj=YzO-_tGETE0=74i4haJQy19-gm4VjvGqXA@mail.gmail.com>
Subject: Re: [RFC 2/5] riscv: set fdtfile on Milk-V Mars
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Fri, Mar 8, 2024 at 2:57=E2=80=AFPM Heinrich Schuchardt <
heinrich.schuchardt@canonical.com> wrote:
...

> > I do not like this practice of force setting fdtfile environment
> > variable. If I set fdtfile from u-boot prompt and saveenv, I expect tha=
t
> > my action as the user will persist over a reboot but instead it gets
> > ignored and overwritten by this strategy. Is this necessary to happen
> > before the boot scripts?
>
>
We could check if $fdtfile is already set before the update.
>
> This would require that the default environment does not include it. Cf.
>
> include/configs/starfive-visionfive2.h:51:
>         "fdtfile=3D" CONFIG_DEFAULT_FDT_FILE "\0" \
>
...

The default environment is expected to have a sensible default, and
implicitly is only used when there is a checksum error (so no existing
valid fdtfile environment variable). It is not nice to remove capability
from userspace i.e. Linux mtd interface access to update u-boot environment
variables; setting fdtfile as such has no effect as it will always be force
set by this routine. The workaround now is to set fdtfile from a boot.scr
but that adds a dependency to reside on storage (which is not always true
for all boot situations).

What of "fdtfile=3D${fdtfile_board}" for the default environment and this
routine instead updates $fdtfile_board (or similar) ? I'm not sure what to
suggest, or if this is a common practice for u-boot board support. Thanks -
E
