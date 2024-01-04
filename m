Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13699C47074
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 14:29:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4628787952;
	Thu,  4 Jan 2024 15:29:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q5HuubgU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B538487947; Thu,  4 Jan 2024 15:29:24 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BE6E87952
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 15:29:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d4c91a9adcso573735ad.1
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 06:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704378558; x=1704983358; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BJ2Y3KSjPqx8aIoJyViJb0yYY3b/YBhcSFDuB+Gd6IE=;
 b=Q5HuubgU+Q4Nfa24daGLzin56AZ7+C1Xzg0a2auL+lGqqF82Mi++7UQscQw8IVzAx9
 XT8Ef9gcuypFkGMnvDOjvLbKjGTHMF4SBzTD0HoBWti2mIIDLxweBCbxSBy62btiKp9l
 tYHyYmPsGIMeh7FuFdy9cJcM0BqGA7SoFHtLu1pdsJAr72HvY4ECKFZ917SwiOoePnCs
 vf/511VfQS2TLtJXv7mNA2zUUBjYFbc8H93pWNRhGpyTv7RSkaboPvr7V+kP5kkXNsYu
 iEA0UcWo7IsjBsdMGyRL9D6GREsyifgZ9rNifRtVUcjRFenxlVLq6EUALU+5cqUV7BgF
 LLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704378558; x=1704983358;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BJ2Y3KSjPqx8aIoJyViJb0yYY3b/YBhcSFDuB+Gd6IE=;
 b=o0+xmQwNIk+ZJRped7Hin7Qbpl6CE2tbArgyj43PjBsPrRN3LIoyYCFZzQjEIkkC6n
 DwLIz2Nq34lXIyzfCPvXtl20Pr0dUBmFn4swqC5z2aNc9V0BzARGgGh3T1XNUUmPynE7
 /Frt+XRVywfQkpn/uVEbDBvHJC9huGLWHK33ZQYk+waIY1JI+TqPSq+cghSsjhggc9lV
 1IAUU5mKpdrPjY+xqEcUaw2m+fMhNvitTTQILGoDQTnMC5mwWeQBgG6LY4t9AYWuwAhb
 Djbcc1tbV5Zm07MPgThf+RPpMNzz/wUPa3QK/AretL/ZsTat0ghVMgHfPgtgHTbpU1CT
 5bYA==
X-Gm-Message-State: AOJu0YzR1FIqDM38o9l1z/9EDbY5PWTfwSzzGTlGFY0ioHF1oJPSAkK5
 PtY+M0yi+nY1qTTDnOcXGp9z84aQYYcweywVjkE=
X-Google-Smtp-Source: AGHT+IH+nObQYqQHnsrAD9D6W3s/Tw1ovhDPjt/VZNA7ooP/Ap2xkWlfwWyTVshpLT25rD+jMo7/EDstr2doSnAy3hc=
X-Received: by 2002:a17:90a:154c:b0:28b:9a2d:c1c5 with SMTP id
 y12-20020a17090a154c00b0028b9a2dc1c5mr1160249pja.2.1704378558483; Thu, 04 Jan
 2024 06:29:18 -0800 (PST)
MIME-Version: 1.0
References: <20240104091350.18252-1-othacehe@gnu.org>
In-Reply-To: <20240104091350.18252-1-othacehe@gnu.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 4 Jan 2024 11:29:06 -0300
Message-ID: <CAOMZO5DPuTmvM9_tFDytC4xVENZH_z6Rin5eJ_tHu6Uer2HaAg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Add imx93-var-som support
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>, u-boot@lists.denx.de
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

Hi Mathieu,

On Thu, Jan 4, 2024 at 6:14=E2=80=AFAM Mathieu Othacehe <othacehe@gnu.org> =
wrote:
>
> From: Mathieu Othacehe <m.othacehe@gmail.com>
>
> Hello,
>
> This v4 rebases the series on top of the next branch and fixes Fabio's
> remarks.

I ran your v4 series through CI, but it failed:

https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/764727

Take a look at the xilinx_zynqmp_virt and imx8mm-cl-iot-gate errors,
for example.

Thanks
