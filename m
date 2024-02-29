Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97FB4C54E41
	for <u-boot@archiver.kernel.org>; Thu, 29 Feb 2024 14:22:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 308A6880D8;
	Thu, 29 Feb 2024 15:22:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="npdrt5MU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B909880D7; Thu, 29 Feb 2024 14:49:30 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22B4C8808C
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 14:49:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=barnas@google.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-29acdf99d5aso431386a91.2
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 05:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1709214566; x=1709819366; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jlSf7HMVMk2VDbUyY8UJVYdQg9ollf6xGjp9wzUWPHI=;
 b=npdrt5MUQQ+3u3hltWdmHctSxn1RuI1uZ6nxcorouicbw1GFM6rv3zu/Ci84IdKvLB
 Wi+IEPuiBeLRCtPH28gGc2zoGFr+WGebc+BlJUppTuR0FMGo1g2yYq5wBwHi3XW8Uyvf
 zoLGbitqGRitxf1L9etAYkyGBzUpWmSHGYEWzMgzLJz/pHbkUaXDAGQ5Cr51chcgsrY7
 ricXTSJV85kgKg5K2JXjeR4IIoZF8GQaaSC1t8GY3El+gSd9l/knNVYs1qV0QC8fAv3p
 OBi76GmqvXU+lWtrzafAzb4FbTJlc6jQum47I5gcUxL55VPGMt6Z+WWF0kpQMLAQPefq
 vQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709214566; x=1709819366;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jlSf7HMVMk2VDbUyY8UJVYdQg9ollf6xGjp9wzUWPHI=;
 b=NwW/8dWX4PMfTp1RtiVtoRaGQA8zkTMN32LOruohx62VYIT53UV66WzGwIXWYgzaBv
 4mt98S6/zTGT/7kumne/VCJIu5Ivv8R2JwVxWsYE4p6WRZHD8imQrBEvcvwk56p09Pqv
 +E1HT+dM2XiA9VKfwCuXeJUmzRX11dOqT1ZCGzvm7M39OUu/hm5a+I+GMpmBCh/aKIaw
 w4cpzanH27e7kkO9h/BriXxZl0m44/m3Fj6RWaiErDPIvu1wy+pI0K35NTH4cWm103Zz
 fC4qaU807w+4hkEjrbpNHityPF6VKz9ZKg6iKAqE2Zjq4Zy9Oq72yHhwvxhwwfIIfLAn
 XbtQ==
X-Gm-Message-State: AOJu0YwiIouNbTLwtyTcPDd+EkJXlyRYhoW44eBuFEhQeAif4j4PlMB4
 v5iYFIxRxPM1koIUCZMJQa5bOkk2mDDXEoIrCaonQEDzTfdOtvctQdtnhSCYrQZh4g7lhPo94k6
 y07fA0Ku9ckNAd+qxzHg3GdCnAq9lKzFjGjgW
X-Google-Smtp-Source: AGHT+IFhkyPNKNra5iIGxAhmitPBO+h5Wk0bwzUmhbR3C6t4PGV+otlzbLSMQMhpXIOPS4t/02b9FCRPsOMc3rLhIyk=
X-Received: by 2002:a17:90a:3d4c:b0:29a:ea0c:71c6 with SMTP id
 o12-20020a17090a3d4c00b0029aea0c71c6mr2051554pjf.47.1709214566284; Thu, 29
 Feb 2024 05:49:26 -0800 (PST)
MIME-Version: 1.0
References: <20240222152102.1677445-1-barnas@google.com>
 <a83ca999-aa53-4d81-a570-677ba644b0fe@kernel.org>
In-Reply-To: <a83ca999-aa53-4d81-a570-677ba644b0fe@kernel.org>
From: =?UTF-8?B?TWljaGHFgiBCYXJuYcWb?= <barnas@google.com>
Date: Thu, 29 Feb 2024 14:49:15 +0100
Message-ID: <CAO4U=yuHDFpAZ4tk2e_o=T2Wj5b1U5+i=htDqv30VPaug1_YmQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] arm: socfpga: arria10: allow to reprogram FPGA with
 warm reboot
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: u-boot@lists.denx.de, Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Marek Vasut <marex@denx.de>, Martyn Welch <martyn.welch@collabora.com>, 
 =?UTF-8?Q?Pawe=C5=82_Anikiel?= <pan@semihalf.com>, 
 Simon Glass <sjg@chromium.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 29 Feb 2024 15:22:15 +0100
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

On Thu, Feb 29, 2024 at 2:03=E2=80=AFPM Dinh Nguyen <dinguyen@kernel.org> w=
rote:
>
>
>
> On 2/22/24 09:20, Micha=C5=82 Barna=C5=9B wrote:
> >
> > By default, the board requires power cycle (cold boot) to program the
> > FPGA with bitstream. This change adds Kconfig that allows to enable
> > reprogramming the FPGA with every boot. This makes the update process
> > of the bitstream on the filesystem to be applied with simple system
> > reboot.
> >
> >
>
> If we want to enable the reprogramming on every boot, would it make
> sense to just do it and not even bother with the Kconfig option?
>
> Dinh

The FPGA programming part takes quite a long time, so it increases the
reboot time significantly.
I don't think that everyone needs the reprogramming to happen every
time. We need that
because our boards are closed in the lab and the power is not easily
accessible, so in case of
update to the bitstream, we should be able to remotely update it with
a pure warm reboot.
So I thought that this should be set by Kconfig to not bother other users w=
ith
longer reboot times.

Micha=C5=82
