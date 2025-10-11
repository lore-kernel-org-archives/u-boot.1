Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72783CCD184
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 12:06:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9CDB83C16;
	Sat, 11 Oct 2025 14:06:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nW3iMIQj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BF3083BB5; Sat, 11 Oct 2025 14:06:40 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B68483B8A
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 14:06:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-639e1e8c8c8so5644610a12.1
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 05:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760184398; x=1760789198; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GFOTeLMMPPUqPpgc8O80JjaPkcCbs1X6asVv05MtC34=;
 b=nW3iMIQjnWOXg47PDYa7CrNcld9zd3XMc9OsUw4exzRMCQCb6uKyiVhfZtnaOsoK78
 JFVEWVWwq8x5EB61W9WpImco5kUYbmWi5Y+NFPS91WWE4vxzaL+rAsRm9H7RSFjCeBZU
 mMEAg4FYwrFuX+TIgIM+ETbL+qsqquy5HGe4ZPKLyfiokbqaqAlhSMhUfjrsxHGZdMIq
 VPqj9KFND8JGGXhjoYVNdEG81jXlt7A8tYRBT5n03VpyUvohzNv1NLqN/LpAIIJiedog
 8al92Y0cQvP/A6RrCQc+RyBDLLcH7IAFaUKPiqHp3xY70UuhSw+QmPl/9d5qSfaEEjCR
 lkpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760184398; x=1760789198;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GFOTeLMMPPUqPpgc8O80JjaPkcCbs1X6asVv05MtC34=;
 b=P80wWy4cmeHdNycazrOXWZ5jCU6lAhCuFysEt1h59Ax+G5Pzd8CU8qT6xT6iMofFwK
 L8KfZXYGSFDI0+KJpn0S9N9cYY5Y99aJAVHTGVvWTMPY3/QNn+h59j1w3dEjOaoS/rsh
 zvTwUhgM9KCqn1yWNqaarAFhtpCH3mnLf57kQvK9EksTzSDtJqknn4+CqJRguktlraK2
 LcoMP4ijSLrlOzM6kU/p7uROJDHhF276jcB8xcTLOmYmJzhAoneFZ/abl21T5Ii8f6UU
 1V8P+PQxurkmh4tP5lFfK+GiGisvKTcS8WldqsYcMM9o52qqhrCp0O68dKX7fts3wB0u
 BuJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfV/iA6mkYmVUA38YXlTvWYNJPny42GOxQA13fHosWrcKRt5PZ/VaeWdfv73KgLVO355LNwBE=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4cx2yJ4gxveULVEa7BtnkpzuY0u1CRQTocdjVQBN10YugVXI9
 TRizLdUXRHbmL4wntwPjLXV5HXdALZkvEPCCTIg5Ib4zrbkaZiesdULHyizm78sPgYGk8Fmn4xT
 70sXw8CucdO3fZEi5T/ZziEG96GNXFhs=
X-Gm-Gg: ASbGncsuhe+hrg18EUJZW+DmravQJJDr8gmGfKyLvBWk8zNZdvsoJqeALkowWwpZpf3
 Td9+i7iluUvVu9abo1Q5H3GlZqwkje9jdSWNIA/BMlOoo2PIDp9H5Ou/nFgAD9RbFkFAmFk3Qbz
 2lpni6ItR68+uqorLqzQtdvPgkM8/WAjx7sz1PbKlJ/KelITVcUxnMyv0HffHgGvhdfhqY08S6a
 X7m8DjHs5h0C8b8OGTyCq08lUeCmVctrIH+1l5HpQWnqBQ17jWrVbSlA3xQ9rZKTTpyqIxt2KXK
 fXSVU1A=
X-Google-Smtp-Source: AGHT+IFvPMvPNcEpfCojCHNVQ4utKH4tKz0zPtOaCLnYoM0nhkL+n5UYmI4eOepvx9GTeE+L0U6MekwX1zmyNOpAIAY=
X-Received: by 2002:a05:6402:3554:b0:639:fb11:9935 with SMTP id
 4fb4d7f45d1cf-639fb119b08mr8366965a12.4.1760184397603; Sat, 11 Oct 2025
 05:06:37 -0700 (PDT)
MIME-Version: 1.0
References: <20251010161442.410C4227AAE@verein.lst.de>
 <83d5b542-e648-4849-80c3-a3073242f72c@suse.com>
In-Reply-To: <83d5b542-e648-4849-80c3-a3073242f72c@suse.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sat, 11 Oct 2025 13:06:26 +0100
X-Gm-Features: AS18NWANpncGmC93kWc9OdCTXFr_-Ck2T2BK5GSbWQGEvdylYOtz5MllfjeVk4o
Message-ID: <CALeDE9O4i3asHZ2TKKJKbFae=8gkOAZFOs4sCFGFWhvtgRCv9A@mail.gmail.com>
Subject: Re: [PATCH 0/4] Improve RaspBerry Pi 5 support part1: Fixes
To: Matthias Brugger <mbrugger@suse.com>
Cc: Torsten Duwe <duwe@lst.de>, Simon Glass <sjg@chromium.org>, 
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
 Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 10 Oct 2025 at 22:36, Matthias Brugger <mbrugger@suse.com> wrote:
>
> Hi Torsten,
>
> On 10/10/2025 18:14, Torsten Duwe wrote:
> > Hi all,
> >
> > This series is basically a resend of Oleksii Moisieiev's from February[0].
> > I forward-ported the code where neccessary, rephrased some explanations,
> > retested and reshuffled the changes, grouping them into at least 3 parts:
> >
> >       1: Fixes
> >       2: PCIe support for the bcm2712
> >       3: RP1 chip and MACB ethernet support
> >
> > Haven't tried USB yet, but with the full series NVMe boot is working,
> > and I get a "file not found" from my DHCP/TFTP server.
> >
> > Let's start with the fixes, they should be undisputable. Credits go
> > to the epam guys for tracking these down. Patches should apply cleanly
> > on 2025.10 and on current master [ecdc3872a767].
> >
>
> Sounds good, but please use ./scripts/get_maintainer.pl to get all the emails
> you should send this series to.

Yes, for example you don't include me as one of the maintainers of the RPi :)
