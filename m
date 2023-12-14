Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE37C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 16:30:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 992E687AB8;
	Thu, 14 Dec 2023 17:30:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lpjD4jzf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C97187505; Thu, 14 Dec 2023 17:30:35 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A45487AB8
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 17:30:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d346f4a043so6677845ad.0
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 08:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702571430; x=1703176230; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SKSJerhkI73GmSHBDqkmYukOM9ANMsgC4FYe5PNMRpM=;
 b=lpjD4jzfTIOGi3C21VLKJbzazBEFAfc5Qi6tER/mf+LoEy9JOi3t8mPHF46i/l0wAJ
 7pqnUHbd113yJs1gDeE3P9U3lPzgaH0ZbMDN10tjNmA99dBzweehAGPLRrjrPEpe0vh8
 OAt6mIVN+2kxT3kMATyvY5/feEBqokb8zGMqb2gDYzom55eZ57JA11TH3/JymDG1IH8O
 NxZohXOPwWVyxbSMrDlaZZ2PKxZE836Ag/2L9pU44tMGn+tsycwHnhoAmYZmUW3j+Dnk
 NUGbrblAvrJwLUPJIViymnkf1QV86RbPwN1drwFtFzLs444iSXCtugRhTgeiQotlvYr8
 5wCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702571430; x=1703176230;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SKSJerhkI73GmSHBDqkmYukOM9ANMsgC4FYe5PNMRpM=;
 b=wPYJKTCfccFGZaOmsfg+DTs5u+8crslLjzAF3N0Im72j5DCiIHmzAY4mRAUqVr+2Da
 fFTfOSRtY9seKApoW9FtE1Uza7PlktJTYP7olHdbUpF2l6ZJTriEBvAngYvPO1ZHPcBw
 8Q+05ydis9bakx8tGNgH+/L7vgXoyRbEjFj0/uwvLgwwfK4slgFjWHWMcMin+7OoSW3T
 IPRDyKJbiWZKZ6r4BE6zAdH2D9yHbZzzzAoLz+J12iW3HZ7CrZYaIHr2Q/2+yUQLJRzJ
 cgDrj2qgLay/TEXqQJSt05avBxk9FWxJd5rOV68NUUpbfKRnf+TGGA3klBHJNfNFW9e6
 9A+A==
X-Gm-Message-State: AOJu0YxiupNwE4Qj2uNi4FeiyTU32TQ/IxIdEw3LHZ23spmFgHGvT8A9
 r19wsEkfCSEXmpHYbIV3iV8+Bqr1afMR7jnqDN8=
X-Google-Smtp-Source: AGHT+IHMYoW+45XpR1oMWxIneMs+R7R1oKw33DhySabi/0Tg2FB3o44fUc/IUypHQrVw3QMR7X0A56nlyqtOmehWgYc=
X-Received: by 2002:a05:6a21:a5aa:b0:18f:d3d3:846 with SMTP id
 gd42-20020a056a21a5aa00b0018fd3d30846mr23906073pzc.1.1702571430222; Thu, 14
 Dec 2023 08:30:30 -0800 (PST)
MIME-Version: 1.0
References: <20231214162543.1200276-1-tharvey@gateworks.com>
 <20231214162543.1200276-2-tharvey@gateworks.com>
In-Reply-To: <20231214162543.1200276-2-tharvey@gateworks.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 14 Dec 2023 13:30:18 -0300
Message-ID: <CAOMZO5DuRnmNpT-GZxkjL4UmwNW-NyQWf+VNy4Q+N1=aitUptA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: imx8mm-venice: prepare for dek blob
 encapsulation
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
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

Hi Tim,

On Thu, Dec 14, 2023 at 1:25=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> Prepare for DEK blob encapsulation support through "dek_blob" command.
> On ARMv8, u-boot runs in non-secure, thus cannot encapsulate a DEK blob
> for encrypted boot.
>
> The DEK blob is encapsulated by OP-TEE through a trusted application
> call. U-boot sends and receives the DEK and the DEK blob binaries
> through OP-TEE dynamic shared memory.
>
> To enable the DEK blob encapsulation, add to the defconfig:
> CONFIG_SECURE_BOOT=3Dy

This option does not exist.

Do you mean CONFIG_IMX_HAB=3Dy?
