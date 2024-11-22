Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38BE5E65D34
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 08:25:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EAAE897AD;
	Fri, 22 Nov 2024 09:25:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gwFTSrlm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D3AC897AF; Fri, 22 Nov 2024 09:25:15 +0100 (CET)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56C5D89288
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 09:25:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2ffa678ddd2so4996691fa.3
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 00:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732263912; x=1732868712; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gXXu1OcJWhyYkqCFeAE+4rra7B7kMS7le+nDzNxtSlU=;
 b=gwFTSrlmfVF8zVEXhGYDGe9NQVJ9bKNJV+VXb73xS/pYo4gqAjQJTDbYDxKOq6kmxc
 Jp5MfqfIeV3TMvkZaK1AfgbMd9Xh6EuBltSa2yHzyNldwUyrs1CyKOwlZ/YpvqEJyWrD
 Zqhdx6aGrHDF2Y6q32YJoXIoX3gQamV1IWbVxlrRqsHhXRL4d0hS4Fj+YBUIvzrSoaCd
 9d/smXumK+ihc5ADjbWwm05oPwSSCQO1G2yYTAYFc7jak2UXeHjhlI4oWnHJXv41fxkR
 QrQg/mPitRhcvC1hjncqgakOgMi+9aofxbqx1sd9CfvTt6rnHDSDF0HJCQ3GsSo/greZ
 p/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732263912; x=1732868712;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gXXu1OcJWhyYkqCFeAE+4rra7B7kMS7le+nDzNxtSlU=;
 b=mpqQwNFqRCRrQUl4JDeImvwoex0NKixvX09bSeEqMV7Qg2br8e3XHXuwAs+QCVK4Mt
 qAVQ6qYx2bcz/3l2R00X+aocGFh+IX6PkiUs6jJSyeval8V0UllOC0WQRE/KF7PZG+7D
 Fodxa4Hp5Xf9gOvqBguXA/rawEBoEKnRS1ACir8nJognZ1sbz+HTdPeg0WQ8Fcg37NDS
 M+brDAyUp2DWEeT1aWmTlM49zPCTCAbX3rr/CpiNMlGvrlPlj65qFMcEHVsi/aYq+uEU
 ejdT8YXDwBzM6Y0iUlh7sGkUpes3pdF+1GGOt8lomEJNwjAdkPD+5KLZroQgWrtHdTUL
 Vc0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaLyL44YQzzn8t3Hm6muhHtWNzqxJctC6AqB6A8GtT8+fDkQ26uy4lbFGPA3ntWVFzix/OPy0=@lists.denx.de
X-Gm-Message-State: AOJu0Yw1vrrpZbFJzeFC2dfeo6GA+Qj8XWQAqbKDJlHYpPrqa7iSTFcs
 /PDvjvx/wiFiCnWxKmAFbxY+MXOZyIlzz9XcdPrUjB7XmGNxIZ4xY+qzMT8291rnEIlmCp+JLO3
 J86VPu/8dNTPrRUUd9+81tQDEUvicCVZx
X-Gm-Gg: ASbGncvUtvVXtRdi4zRs6DX8LBNFrrkLzHfuqFPWyOXC0kCY9z/7Bqc0cD6P+MTR/k+
 je9HhPF1B0oFTzjwvDnfrqTJINVGgaphtM1b615N90QDwfBPy6N5TLa5XNtGYcIjvEQ==
X-Google-Smtp-Source: AGHT+IF/nNYHv41TEZU1ydvxt+T3flIX19QNuDxruewK6gzFfVYk5yYJ4DBdNCmWqPo/dz3NlMVPvDSqwhvwvEemYYg=
X-Received: by 2002:a05:651c:2208:b0:2ff:59dd:925a with SMTP id
 38308e7fff4ca-2ffa71a7aa1mr8680251fa.29.1732263912194; Fri, 22 Nov 2024
 00:25:12 -0800 (PST)
MIME-Version: 1.0
References: <20241121142522.59059-1-heinrich.schuchardt@canonical.com>
 <mvmjzcwobi0.fsf@suse.de> <a6a1d0cb-c363-47bf-aa91-b3c2ad2fd5b9@canonical.com>
 <CANV2PTNnOC43iYnyoczWev+2vAjKR+BEU5o1rEyZqr4uPVaJ8Q@mail.gmail.com>
 <CADg8p97T1L-JwPRAu7Wq4Uz-yEBuvNucJcNULcCTi2o+zFTRiQ@mail.gmail.com>
In-Reply-To: <CADg8p97T1L-JwPRAu7Wq4Uz-yEBuvNucJcNULcCTi2o+zFTRiQ@mail.gmail.com>
From: E Shattow <lucent@gmail.com>
Date: Fri, 22 Nov 2024 00:25:01 -0800
Message-ID: <CANV2PTMT5S9+JpQ75kaaMKLu1Np=yYUrMr_5HW-L=QaA9RKuTQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] configs: JH7110: enable EFI_LOADER_BOUNCE_BUFFER
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Andreas Schwab <schwab@suse.de>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Rick Chen <rick@andestech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Hal Feng <hal.feng@starfivetech.com>,
 Tom Rini <trini@konsulko.com>, Chanho Park <chanho61.park@samsung.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Nam Cao <namcao@linutronix.de>, 
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
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

On Thu, Nov 21, 2024 at 10:32=E2=80=AFPM Sughosh Ganu <sughosh.ganu@linaro.=
org> wrote:
...
> > Hi,
> >
> > Test failed for both boards here with origin/master then applying this
> > series, then starfive_visionfive2_defconfig target and set
> > CONFIG_BOOTSTD=3Dn following with oldconfig target.
>
> I think you need to apply another patch [1].
>
> -sughosh
>
> [1] - https://patchwork.ozlabs.org/project/uboot/patch/20241121142522.590=
59-2-heinrich.schuchardt@canonical.com/
>

I did apply the whole series, patches 1 and 2 inclusive. Is there a
canary (printf? i.e.) I can add to know if this survives to the
compiled output and does what you think it should do?

-E
