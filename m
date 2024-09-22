Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB297CF9C64
	for <u-boot@archiver.kernel.org>; Sun, 22 Sep 2024 20:15:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6B6288CBB;
	Sun, 22 Sep 2024 22:14:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jMOHuzUZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8195088BEF; Sun, 22 Sep 2024 21:21:18 +0200 (CEST)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6722B88C60
 for <u-boot@lists.denx.de>; Sun, 22 Sep 2024 21:21:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e1a7fa52bacso519900276.1
 for <u-boot@lists.denx.de>; Sun, 22 Sep 2024 12:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727032875; x=1727637675; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ijn0oEd1paqzb4bo8X1YUWGaUSXjoPpeZXqf7AtLP8Y=;
 b=jMOHuzUZs1LDpI1sFH1OEKiiS6kM5Z2Ovb9LgGBG2JcCPT+KVIgf4/U1eSuFzU2Eka
 3PcWvVn5PUe6T2Gxz2dJJxiIz0O7alZkWyPfr3OmDfFZ4N+dC43Z5irMvEoXsTeuFU+g
 WnlsPSNKTeOgqgZQZh8m/mFCPFVFH9itX2C56EQr0T/Xu5OYZpiVC2A3LGgaqKPY3dcG
 fPpdLcyconKE5eEkLdP9fQq393vz1q6bpD5gubku4xizw2IJ7F9Kry/eKemCkMPLaL6/
 NUIYMSekT9Ueq+NTMM2sKd/roirzDd/Fsceg7NGbxWCI28CxwA5H+Jr5VSuORWRPPG2h
 uRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727032875; x=1727637675;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ijn0oEd1paqzb4bo8X1YUWGaUSXjoPpeZXqf7AtLP8Y=;
 b=pYEaV4K6EssTU/xu1cUH7vdkoo+BuY+qR5VYQAEMWtLXrEAdfLA/+9rcZsK58VNQM9
 qzJWU1CGRlEikxApFaFIZFk9OAXZ6yUyQv2EV3D8MD1Nkl/Xr2lQlRqHBkhLaR57WCj7
 hTYlxBYctZg01ZzbJru/v91nSCkd4F1VhVKzKlbGteVoAFPLwx253hwWHn0HJLjcOaR9
 rY3r+p2xx/KJhE5K1eByBmYdkRlryYERw9CPVu9ElGrd/bJB5I7B4nOWUPtwyYk1+y87
 SE+9RYvcQy/r3vQmIaqH9XPiN1JByEIBh5dh2dqx0R3gASz8fo4kHEX+2LFxzj1RVGW1
 BEsw==
X-Gm-Message-State: AOJu0YxMDtE9i4YH8eZaOAP1oB+03BnTBFITh0hP7zNlIjiniYsJ1CC9
 RHTsd9fOVhbHdQwbeCvb/T4O1fmVg/nKEb4eHzRsJGzRczT7ztQ0UolyRyWsFYxAqCuyukNEe7X
 +o1x5OZ7tvmHMYVNiTehKKPYn6Fg=
X-Google-Smtp-Source: AGHT+IFvcRzLQNOAsFESLtr/dbqT8wm//MVLNxo+PQTTRLVRZbIxyJXG7p87PnvpHpA4beo1Ss92uPS1yffr95M4lQM=
X-Received: by 2002:a05:690c:dc1:b0:6d7:3c0d:3ad5 with SMTP id
 00721157ae682-6dfeec138ccmr35328737b3.2.1727032875073; Sun, 22 Sep 2024
 12:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240917062157.3181-1-l.rubusch@gmail.com>
 <87b42397-6eb5-42a4-81a1-5008142d293b@denx.de>
In-Reply-To: <87b42397-6eb5-42a4-81a1-5008142d293b@denx.de>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Sun, 22 Sep 2024 21:20:38 +0200
Message-ID: <CAFXKEHZ3i=Fk52s7xhSoP6xWyfwL0bs+waCy3bjgpducYJ-Pcw@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] add support for Enclustra Mercury AA1 SoMs
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, trini@konsulko.com, simon.k.r.goldschmidt@gmail.com, 
 tien.fong.chee@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 22 Sep 2024 22:14:37 +0200
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

On Sun, Sep 22, 2024 at 5:33=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 9/17/24 8:21 AM, Lothar Rubusch wrote:
> > Introduce the support for three variants of Enclustra's Intel Mercury A=
A1 (with
> > Intel Arria10) SoMs and additional configs. This is supposed to be the =
first
> > step to upstream several of Enclustras SoC FPGA Modules. There are stil=
l things
> > to be modified. So, this is supposed to start the discussion and also t=
o
> > clarify some of my open issues.
> >
> > On the DT approach: I can agree that in parallel I may go for upstreami=
ng
> > the kernel DT. There is a fundamental difference, still: In order to
> > represent the combination of module + baseboard + bootmode for the kern=
el
> > DT we have to use a mechanism like DTO. For u-boot this can be simpler.
> > Currently the few adjustments needed will be represented by the DT file=
s as
> > are. I propose to keep them, and in case remove them later, which I dou=
bt,
> > since the full DT for the kernel will cover more details. In case
> > refactoring is needed I can update the DT also in u-boot.
> I assume after the LPC discussion, there will be a V3 ?

Yes.

V3 affects mainly the DT question. As of the LPC discussions I had,
currently I'm about to rework the DT material. The material will need
to pass dtbs_check/dtschema. Functionality then needs to be verified
on my hardware zoo, and eventually I upstream it directly to the Linux
kernel ML. If successful, then, in u-boot I will build up on upstream
DTs as proposed here initially.

V2: Please, feel free to already review V2 patch set. As I assume
still some issues. Alternatively, we do this on the V3 patch set. No
stress! Every feedback here is highly appreciate!!

I pretend putting the involved u-boot people here in CC on the kernel
ML. Pls, let me know if I need to do the u-boot ML in CC as well.
