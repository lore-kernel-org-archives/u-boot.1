Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69861CD4F21
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 17:29:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4B4288B5D;
	Wed,  4 Sep 2024 19:29:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=public-files.de header.i=frank-w@public-files.de header.b="YTQyn/7o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0E3588B67; Wed,  4 Sep 2024 19:29:41 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0529889AA
 for <u-boot@lists.denx.de>; Wed,  4 Sep 2024 19:29:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=public-files.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank-w@public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
 s=s31663417; t=1725470974; x=1726075774; i=frank-w@public-files.de;
 bh=k0ge8jIkJLb/ILfXKin8TaifMk+oUL4oKZifCoQDG8U=;
 h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
 Content-Type:Date:In-Reply-To:References:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=YTQyn/7oltgl5WljT3wAA6dp/HoJnDx/vvO6VeqWnG+dOfS+Qpi6vqdh3t3n9xOk
 jL6nMRevqlJjDkeoCZucPLUq0Anb5PTMcr0Tx3TIwRkD8itmsrNoIqSwm1H/sFEiA
 7jyIDEwRvgll8SFD3nFsxK3DDweGDcQocOPhWSW0Qf5ddCJNDti2IF1y/vx+yljkH
 xLD9EOASG7COeaAJEBcWtujnMJAeyOQV7e1iXvci+aWEIz/ewo2Fikwm37xAThpye
 iWGbXxIt3NM+uAhNMjGcCyPDWpuHxz3J+Cabhya6bG00YfBc/Czjll72k+hytt9Sg
 ZygUdmtBbhLydwCmHQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [157.180.226.103] ([157.180.226.103]) by web-mail.gmx.net
 (3c-app-gmx-bs17.server.lan [172.19.170.69]) (via HTTP); Wed, 4 Sep 2024
 19:29:34 +0200
MIME-Version: 1.0
Message-ID: <trinity-13f6d284-1ea6-4a53-ad60-847791f0c127-1725470974423@3c-app-gmx-bs17>
From: Frank Wunderlich <frank-w@public-files.de>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Nishanth Menon <nm@ti.com>, U-Boot
 Mailing List <u-boot@lists.denx.de>
Subject: Aw: Re: OF_UPSTREAM vs. additional dtbs
Content-Type: text/plain; charset=UTF-8
Date: Wed, 4 Sep 2024 19:29:34 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <0ff5653f-60e2-49ee-b68b-d86801aa1d66@siemens.com>
References: <7765273f-7f36-41e4-a604-1901e4fbec62@siemens.com>
 <20240813125245.ezlu6me3ljwx6dkj@margarine>
 <89f8e976-e831-4035-8cd0-ab6284846d0a@siemens.com>
 <4ec5108f-b7a4-47db-baa4-edee532c58af@siemens.com>
 <CAFA6WYMQustcwo4Es7iJQj5Lva6UiYJ-j7WgSzMjOvEHemeDcQ@mail.gmail.com>
 <4576b818-9732-45ff-a4ab-b98fc0ecf4c9@siemens.com>
 <CAFA6WYNXgJkCX9-aoL5FGchAHGdV+ikTt4+pTJP-jZ_UJG8E6Q@mail.gmail.com>
 <87a9fe3e-5d9a-41e8-a8b2-4368cb727a65@siemens.com>
 <CAFA6WYMGyMAB=m-hkxs87PyHszcbQUk6+0_G0n+0-Yk8NeRXQQ@mail.gmail.com>
 <f61a8c74-9838-481e-aa1e-09fcc07f044e@siemens.com>
 <CAFA6WYNdS0jZ1iESfCErX92SOL2fJSRNNLZ1a_7jHoSfOUrdgw@mail.gmail.com>
 <0ff5653f-60e2-49ee-b68b-d86801aa1d66@siemens.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:O+xmE6SNOM9hmi7hpuW8AhmicTXoGjzCshxLo++wxwkiMxjqFKS+McxFM1kO15r7AS5Dh
 63SICz2T8ReG9vDeob4kugXzdBqoM2w0S0aofpXoxrez1wnmJu6KWKBFUFIuEdfavJ5S4SQKh5yG
 ChisI2Wq4+vV8SvUFas96wa4TO4oHxc+Rjg+QGMMgieHau/ET/4wCE2BpRAiY7vSrImCqN6jizJ5
 QtaEfr8wCnhYibA8CowgOx6CZb0dpdKwU4G16R2fJ36MyLeYXlj7sY6ABNjv+J8ZNN1PYYkiTTrY
 VA=
UI-OutboundReport: notjunk:1;M01:P0:4Sa1ewPNVOw=;2PJUoDqYUS6buJs5MQoVDckFWW2
 UC4dOak/Kh74Q8VLx2kIbdAzGv29pUDFIVXJJDWDpAJyG7BnG96IxBWXMsjt/MJecnYJ78XvP
 KmY83GtrLgWg6eHu7bz8L78tpYh+PCNqlzRfc8l7aATiNFDynKLASeDn996B3yrJxJ/RwmFRo
 7n25FDrkJr9sXx+r2iLNA2HnLz45xqeBSlV0d73Ct1o9sTT8FrHdw3lCjV7uMMBqI/leJLvzR
 fYmeVBcTKHm/iTbvGD+upD49eOj+NgVeJ08/O2pfF5VDuFsLieng5lUXruYYxijc/ltOyJw1n
 G0E5eW0oBdegJeAkcBc76ljlQMOKPTirv+04OegcHjKLNTLPlFnnhc2g86cdslFcHU1WfBKKs
 DQcb3IX4pEA+QD4y2aNJ8mLQzrVBLapmm3tW0/ocEQXHpjZuFhNYobu2eJKEm2PPfV9Vc/k7x
 Vcbt15DAtx9+7YISSs6KxtLuc9jBCCOx2kgBGyJLrxhpV+XhPNujzT3+RATVDpcYaqlC2Lxqp
 uFG5Bme7Wa5aN6H88KEwI9+JGKPCguNFI7tJ/VwZFEU/21fyWvIUhLarU2hdRr3qVbeYkiueG
 w6KrGpmggQBi6UJrYnPWry+WCG47Cm+fBuW2nrXaaAdNDp54yH8zWyjc4H2S7LTwc/3h6rIPA
 PVj9V34g1IEhkpIFaX6ZausovJjdSyzXY4vQPw1++w==
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



> Gesendet: Mittwoch, 04. September 2024 um 19:16 Uhr
> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
> OK, our overlay sources are on their way into mainline, will only take
> until 6.12-rc1 to get them here. To accelerate the preparation, I ported
> that change to a local branch - just to find out that OF_UPSTREAM has no
> clue about DT overlays so far. And it is not just that there are no
> build rules for them (that was quickly fixed). It's also that there is
> no way to trigger their build for your u-boot proper.
>
> Are there plans for addressing this? I'm inclined to revive my patch
> that allows to augment dtb-y from the board's config.mk. Better suggesti=
ons?

Hi

i hang also on this part, in my case i build the dtbos for the vendor and =
try to use fdtoverlay to merge base-dt with the defined overlays.

see commits till July 11th

https://github.com/frank-w/u-boot/commits/2024-07-bpi-ofupstream-all/

this fails because the target for fdtoverlays needs targets for the dtbos =
(have used the fdtoverlay target from linux)...
but i build then without dedicated target (while building the basedt).

maybe you can help solving the "small" problem in makefile.

regards Frank

> Jan

