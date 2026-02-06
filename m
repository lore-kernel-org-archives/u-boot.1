Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51175EE209E
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 12:54:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA57B836D3;
	Fri,  6 Feb 2026 13:54:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="m7digAHB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E36483B85; Fri,  6 Feb 2026 13:54:25 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD0F18352B
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 13:54:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b8870ac4c4eso103602666b.2
 for <u-boot@lists.denx.de>; Fri, 06 Feb 2026 04:54:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770382462; cv=none;
 d=google.com; s=arc-20240605;
 b=VSiPW/cnNqa2Zfjw7M6+57sPv+uqHVxNYJhVVR2gxOQc863k/8VcJ7wva3RXeHYQ0a
 pV5S9FVXyMNui94fTvlV00gE5SPKA68cxXU+vxJAtY8EPoSH/2I2gNn9A2SSz5p/HBjm
 h7iRXyI1DNUbZFDGUNKKWl0vdWzP3aCFOLo7KpkmT1rFQAiGz2geWQVjU0DKx05PGCdv
 D238qnvd0WHAeAVDNm5EEzoq5iJq6F8Ip7lRKEFNJyAvLEWxyGda3U/FFtRuc3jKqtrU
 MoeO9gv6XbNleDSlUNzpw/ewrtCfsi7pJe7BUQit26XoF0B3zCE+9iyPbtZrzOwp0ZcL
 0b6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ar67RZKcV+pfVTe7N70rE5ie+8/eFp60YehT2AeuVKc=;
 fh=ZKYkIgFDz6IaiVS0gxcw1ioVGtK+60r21PjB4mLXaPo=;
 b=DstStBIj4NK76DhKpvPwIb6+HVbZqvvIrt25UfbfN7fS/urzbS52rEWd8ZGUo4Ek0W
 sOrMjDEBrjuC+22VNMmvjF7Ia9Y6eKsuflUjXsgiz+i8tsJ1JpSsRDnbNyBJ5QqeZU9j
 wxNp45RIZ4AtrkWobdSS42Juvu4jMdBL5s80GlTCD+ZfDC+lyH6uGZiarEY3TjBLbnbK
 gMbliVNKQzJPGXufdL5Dt8GRFAU0NurAdg73awKdl2/Zm/14cH15uWgkyULgMXeecxy/
 ZrRoma3GRZ4q7NRZz4JO3ZSjW1BLUx0tfW9SgQkTb03Fge08ljs+7k95ZXJIQSmF7kCQ
 tW1A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770382462; x=1770987262;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ar67RZKcV+pfVTe7N70rE5ie+8/eFp60YehT2AeuVKc=;
 b=m7digAHBEEey6FEsAoiPiPhvZYPd09LcTgdquEtf/espdAsojJQTdxyTLNX3ugk/I3
 MJb7f6FVrXhnYalhvpXH0ODdGuxYeN9iEeUoTVa9MekWREAIv4nU9kn7hZibhpyDXO/k
 v1atjUPMT099K7HtqYKcOaNkW+qanl+tViq879rOIr9fhJuFifjhPaiuZEkc3khTGt9R
 2hBBa1ys9k6GsahUO1rnaO06vPIp8ZC1hbtUSUPFmXUSIyasloFLxTe5oyNlB+tug/4z
 6vVIALUZCilVbW/Z7xzMIzYXrRUxjuSNaW14OfVvBy7YhpRuhHVRSdTsHS/okux5JDzK
 2Saw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770382462; x=1770987262;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ar67RZKcV+pfVTe7N70rE5ie+8/eFp60YehT2AeuVKc=;
 b=C5Ex+tT1laDI2WyHPqWLaSSiyUJOMLA3BPVedqf0bZYbDLCRY2I1MFDAbUhN8sAtEk
 2KX141EYYXw+e+XDBJajvOst/KG73SP6aFEDiKD24YCbTu5ALLM/JRBKqVOXTIfnrGdD
 tEn2GYsIC4qXrRdWvmuxVpyAbk4FaMAO6i/BCyzyyq9GlVi3FNoCWWIOC/tbqw6gYC7c
 Nv7UADdZ82eQzOK/+H3bpjK6nVv7ZUoUxl/TG0xc1FVw3cjAI2JEe9qF7OTWghGlSC/k
 CrCi1k8G/Ce2Phx+quKIcNWt+npc9BrGn4uajNg2b27RlNE6JlTooSUTDSI7ZHzLXgDL
 jApQ==
X-Gm-Message-State: AOJu0YyDAYr+7rTjUXuJ9XFq9jk8jrkQc7MV68Czxn6zrV5OjvYALYq8
 rINuhzEpkabxP5rig+Q2jW57Up+8UYYnNzDnfO2zu3Y8PaK6dSAEEUGCdaqYCYAt9lHCWjFK2FM
 Qdj15S3K3Vec3ULCpfhoaax0AtecMED1YvFpfyDeaTA==
X-Gm-Gg: AZuq6aKEhoZNhNoILR9REF6/9nPhEHzhB987kFLHs3dp1soupTMfP9xFRoWue5EY3KE
 Uk1GIBxJE0Vndls4aWWwgXsikE0amq3ma7Oem3Q/MStceX02OSMz69Hdk1Cjnp2rhevn1zr8ADw
 i9XSOK+qyRHYHhbeGae9Q8CcZDS0Q4xIP7O5WHZfyDNCr2uWRfBdV3skYX4J+nJaE+a8wFvk48+
 iJj+q/ioUaYK/L/ay0Xr4Wi+Y20mBE2Ig5wvl3G0TLus6GRrJ7FDUW4D6eqQKXQI2YlWO/2fqa6
 Zsj+dRTHkvkmilOrnrNdU+gtKCEaBmpvAr+6EMI=
X-Received: by 2002:a17:907:2d8d:b0:b8e:2a8a:431a with SMTP id
 a640c23a62f3a-b8edf350596mr147591066b.34.1770382462191; Fri, 06 Feb 2026
 04:54:22 -0800 (PST)
MIME-Version: 1.0
References: <20260204-add-mt8370-evk-board-v1-1-3132f953d845@baylibre.com>
 <20260204202915.GB2603314@bill-the-cat>
In-Reply-To: <20260204202915.GB2603314@bill-the-cat>
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 6 Feb 2026 13:54:08 +0100
X-Gm-Features: AZwV_Qi_EYzONFc69hJ3Iv2A4SBCaOGPm9iN2ZxS832HESyTy1B-dJ3ctRtqqgk
Message-ID: <CAEHHSvbdPi3uk1-B0f4SpTzZO_4bdDD7=p7f_LHDzFO4VSf7_g@mail.gmail.com>
Subject: Re: [PATCH] board: mediatek: add MT8370 EVK board support
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Julien Masson <jmasson@baylibre.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>
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

Le mer. 4 f=C3=A9vr. 2026 =C3=A0 21:29, Tom Rini <trini@konsulko.com> a =C3=
=A9crit :
>
> On Wed, Feb 04, 2026 at 09:24:30PM +0100, Julien Stephan wrote:
>
> > This adds support for the MT8370 EVK board with the following
> > features enabled/tested: Boot, UART, Watchdog and MMC.
> >
> > MT8370 is based on MT8188.
> >
> > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > ---
> >  board/mediatek/mt8370_evk/MAINTAINERS  |  6 ++++++
> >  board/mediatek/mt8370_evk/Makefile     |  3 +++
> >  board/mediatek/mt8370_evk/mt8370_evk.c | 34 ++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 43 insertions(+)
>
> I'm wondering now, can we reduce things to be more generic? I'm assuming
> the memory map is not the same but this is basically the tiny bit of
> code for mt8390_evk or mt8365_evk (which doesn't have an empty
> board_init, is there a CONFIG option to disable in 8370 and 8390?).
>

Hi Tom,

We discussed this internally with David. He was already working on a
cleanup series, and as part of that work he addressed your comment by
adding additional memory map cleanups.

I=E2=80=99ve now sent a v2 of this series, rebased on top of David=E2=80=99=
s cleanup series.


Cheers
Julien
> --
> Tom
