Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E00C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 17:08:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85E6F87AE5;
	Thu, 28 Dec 2023 18:08:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jeVSV/GN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29D3E87B23; Thu, 28 Dec 2023 18:08:49 +0100 (CET)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A41987AE5
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 18:08:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6d9b760610bso274757b3a.1
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 09:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703783325; x=1704388125; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ocb2IWF5d48cE5OhidN5ru16R7JCdUcbx7w/AEnzf0o=;
 b=jeVSV/GNq4LpgsYHRFw0/hYVEskZChN6XsX5i/uOqCpsAsC+vHWSe4jbP/sXCq/kxv
 b7KldoypzNWJsrwG0w/RGT3NSuvMi+TLRHjIALSyEBEPZTv+KHXTcL0NeUjn/emdnxgJ
 29Iz1xq2ZBPonh32kPiL9QKe3hTQCmIxPu8ulhiOyOcfuA4jMVcCiUXmf1L3Po6N/8ON
 RV9FoNIiIW/IRJJJBtX5fMRcHg879hc0ATVpufa6EGkaywqZsZJW0pk7+zL+avH3+y33
 NFP3qTMZFrioWYhp3znru2mvSNW8y7X0s6l7xH/gGo+wzVe1p7hqxR0nDc85V5TUVIMx
 HgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703783325; x=1704388125;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ocb2IWF5d48cE5OhidN5ru16R7JCdUcbx7w/AEnzf0o=;
 b=cQZiDoDsrQw5DJKT5684+fIs8UWU0/qYqKsVsGhK5h460FBJnIWI+TZObxtmz2uhfl
 srho4qwRsJihKjgCAKtVCfDNr4bNACAdUawLI0PWF7uFE/AbsAFnwlmFUQqVUXnuxR/T
 9NvX2lZGHYSMMUzHuKKYspghVbCqopXN0MKTeaZ+TbhkEDdu8pPj5L67CmjgZtI9JQCc
 RmFyPvXKS00jy9RnHQK/PgspddQfwUcr0SjQWu9qLKLUEJApTZSeqI/upBxFXNnUWg0d
 h8N+TdKY9Vi2pJsb4V1SDODECinzsD7dv9Z0PsF5Oq76g9wS4oOjFcFVgRi4y9vLlOnp
 PoDA==
X-Gm-Message-State: AOJu0Yz8Ix5WWVluq+iM/i5Kt98T5E7cQZkmxP6EVrS95OLoAOoJatAx
 iUZNPrDmZdas+bApHCEritYRc6X7l9A4EcZnyyU=
X-Google-Smtp-Source: AGHT+IFlIz56NAIaBOKTcBjOEB1N2h2I29LH+c8CsQ1XFhXDDUvkk1tgufrLYNkNBuaYZ1V+0YRhKEKPPE+gvOudf+U=
X-Received: by 2002:a17:90b:1195:b0:28b:ecbb:29da with SMTP id
 gk21-20020a17090b119500b0028becbb29damr15725487pjb.3.1703783325245; Thu, 28
 Dec 2023 09:08:45 -0800 (PST)
MIME-Version: 1.0
References: <ZY2ZDWAQuTlRjV9H@francesco-nb>
 <CAOMZO5BSt4rbdSDNrcchg89qYJ6kK2nkHLFqfjdu21H_joU-jg@mail.gmail.com>
 <ZY2mVMg0532pbuFh@francesco-nb>
In-Reply-To: <ZY2mVMg0532pbuFh@francesco-nb>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 28 Dec 2023 14:08:33 -0300
Message-ID: <CAOMZO5AeEWRbpYsNDhno3gEo-0ab01Kd62v8inDt6V40BLqp5A@mail.gmail.com>
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

On Thu, Dec 28, 2023 at 1:46=E2=80=AFPM Francesco Dolcini <francesco@dolcin=
i.it> wrote:

> With that we would have to enable the watchdog, something that is not
> done today. Any potential downside on doing it?

I don't see any.

The watchdog was being used originally too, but not via DM.
