Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9775EA813F
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 16:05:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFFF083CB5;
	Tue, 10 Feb 2026 17:05:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bqFSEvBE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84FB683CBD; Tue, 10 Feb 2026 17:05:12 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C75883B03
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 17:05:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-385c6c727fcso46516651fa.3
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 08:05:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770739509; cv=none;
 d=google.com; s=arc-20240605;
 b=KEXkLuef8TTd/As9zYsL4T/JzhST4GUcFW0uzKDBtFOs+NBMLRw+hruxPDPjZsuPiV
 rvRvIrzlWlo8lEO+6XiMwS2xmKRBImqV2hAo6bUSVZSMau0KwLZtF6Dg3e7EfOPeEftv
 FdWVFJfslDquMPcPooATeuyCLTueNTLsD53Nd+9xn5rftVtsDPZcmoxveMj/BMVkABUk
 9ZMoKdo9jtpRpiCICM28qVW4r+ycPJj905Jz4dYw7m9pURuzw9qaSt877g1dkKaEsgQ7
 1P6VumQiFrX8lUGUMl1MIlPUUklmUN8Uypk8lyIbeqqD0q765lhozOOCjsoOuzGztVRS
 ZIMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=t2kWyBRnvROUUX3prmp+yzbQsOAEi4kWN8GuobC7vRs=;
 fh=nE9eekRp8ySHaPxDnRnDpltNUhJDlsc9BYrsyJx/vD0=;
 b=jzUbaTrYmcuJN/wMSYQgkf18iulCGfhxjeWlvCQsVLXFfKXymtZFfR1NCrHj+YuEYS
 kATwUUZw0fFJ9GO0QxTZAKjxMOMe29nbj+aOKNvI0PZiq79KbL2jLshaIBx6wt6l7VYe
 6pBUt1fXzdJsjXPd3rbxMfw8a9Ge/gQMs0Nf5uvV+1fd2LGwKs7xa9///y67yldF/H21
 MHItredBBbR5HCV2KEDgIuTKEvKME+Cf4Fvf1YkbZAaRlJy5/4euyxBiplA1v/NRqMI9
 9mnkuXgr+4uuWujTSmluM/zHb4vMcOt6k6/WOfBLgH86cOWOw4BIJXTL7MEOGIKbkYL2
 g9MQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770739509; x=1771344309; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t2kWyBRnvROUUX3prmp+yzbQsOAEi4kWN8GuobC7vRs=;
 b=bqFSEvBEVatk5+kaxV38C2mBLanrgY3Gx2HLrlhF7S3oZj+HwD6ojq9TmOn9IWlzqI
 n58QcoWvDjnR09eXpy+1JOAAbSkvvF0XLT8Nmvqx4GZwgARG91ywNxQoPWimELpaoa7C
 swkCnQt7xifqjCuGYY5kN6F0KP2xfMWbpaueVB4tNV7GEHK8BX78mBpOuTne4qi/I9zl
 x/4BbFPdHfdWJqeCB6qhWBM0mZXKNXrl0WDCvV5b0JBaHiC9AyR5Rsoh3C9kpHJHGEDj
 yWf3GI2Rz/KUwm4EgQZxYooASaTl4IG5BzpQGlOy1Brh7r0Nk3I3SoEWp1Kf2nq9daL1
 B6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770739509; x=1771344309;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t2kWyBRnvROUUX3prmp+yzbQsOAEi4kWN8GuobC7vRs=;
 b=QhMfe7dTBHbvXhetzAUVKx6Z7rR5WKjGFpPdpLdD1Abk+cbTW7hG2PAlpjjQ/TDi9+
 wuvSc4PMPStAfIOu0LwBVFdVwAjh+8O1hBC/AJvyPxGwIbSX7dLxRa6Hid6VwjNy16s6
 trzWj/lqq1+gYRRp7ODJRUp4XVfwWVZbxUG06nY/YQZymbwU+mzmAtxjkUHZtkOvP6fq
 z2AxNx++2CpsuCGVg8MFEfUXXMcG5UjWfgLpWnIg038wTwwk6qRnb7ro7MGkUO9uxCux
 NJ6KfZSqzf62AZBG2dGpHZRdjFqdsnm0RDik4wzHc0CXLe9ju58RJwH86EP5xf1vSV2D
 e1bQ==
X-Gm-Message-State: AOJu0YwdED2o6PibHwT+1QjodYA24MNTLz4yJLwr0JkpRpGfP2Q3YvYv
 NRxi4gAQ7BGOXURjSfpfH325w017GBJaEwYaxx5HeAD09SLehq5sAcPnhM3Mq/tU+OS42jW/4Xv
 yniVb3twqLUkobrdpy20xS4mHXd/4DWo=
X-Gm-Gg: AZuq6aKkr3U0xZCxAHckaTviiyue/FAYwxU8NpktJG14RpeP3pttVCyCjqdtdeXkmj5
 wHmKdI3Dk/M1DMrECh9lEvnKaaOrmsOuZgfA8jVZwgdkNJnjTKjSIJFQD8UUjpepnKzsQD3lH2z
 4iin9cAuCIpL0z/tfSrBHEHVgJzfjC8Rx3jpnmT6ONWUeH+SkAFPdt72XtucjVA9un8dNEXODph
 I8LFFaEt9QeIavwdMvPob2/R1YZ+INVw/waZ96WZ/gH1ksCpmJa3Anj/280lIR0IQ7+qkVHQRBt
 T2jNd4bMUnC33Ylq4JQ8+h1JtgcS+cxN7WuXb9o=
X-Received: by 2002:a2e:be8e:0:b0:386:91a1:f206 with SMTP id
 38308e7fff4ca-386eedf08c8mr8787201fa.5.1770739509124; Tue, 10 Feb 2026
 08:05:09 -0800 (PST)
MIME-Version: 1.0
References: <20260210090029.728636-1-brian.ruley@gehealthcare.com>
 <20260210090029.728636-3-brian.ruley@gehealthcare.com>
 <CAOMZO5BF-jfjunxhW2_9ZF+r-c1GE2UvEBqeg9ruKutAW3H4ig@mail.gmail.com>
 <aYtUi1WdLPLEnv2X@zoo11.em.health.ge.com>
In-Reply-To: <aYtUi1WdLPLEnv2X@zoo11.em.health.ge.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 10 Feb 2026 13:04:57 -0300
X-Gm-Features: AZwV_QglUqoGvQ0fbK09TIvm9kcD0rbtUS9iknfzDcZ0Pek5tzo57IZTOtsm00w
Message-ID: <CAOMZO5Dq5fOFUYHxyW2SrmsZ4QTmkwAJrswEqBMwqfVMDQZe6g@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] clk: imx6q: apply clang-format
To: Brian Ruley <brian.ruley@gehealthcare.com>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>, 
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>,
 Mark Jonas <mark.jonas@de.bosch.com>, 
 Peng Fan <peng.fan@nxp.com>, Ricardo Simoes <ricardo.simoes@pt.bosch.com>
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

On Tue, Feb 10, 2026 at 12:55=E2=80=AFPM Brian Ruley
<brian.ruley@gehealthcare.com> wrote:

> I'm simply following U-Boot coding style:
> https://docs.u-boot.org/en/stable/develop/codingstyle.html
>
> Checkpatch has already complained a bunch whenever I touched this
> particular code base, so I applied clang-format (since the project
> has it) before making my changes to suppress some of the warnings.
>
> If you feel like there's no visual improvement, I can of course remove
> the patch, but I feel it odd to have a coding style in the docs if it's
> completely optional.

Please explain in the commit log that you're fixing checkpatch/clang warnin=
gs.

Simply stating "Conform with U-boot guidelines" is too vague.

Thanks
