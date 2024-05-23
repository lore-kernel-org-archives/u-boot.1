Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA95BC25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 07:40:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DFA5881C3;
	Thu, 23 May 2024 09:40:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="I8RpJ3iB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D84A881C3; Thu, 23 May 2024 09:40:36 +0200 (CEST)
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com
 [IPv6:2607:f8b0:4864:20::92f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AB3D88263
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 09:40:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-8032187ea09so354933241.3
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 00:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716450033; x=1717054833; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iwZcsELBlCO5DXVXwAU+THj+aAobxissCS0tGjemweE=;
 b=I8RpJ3iBq+RLjaiOPvkc5iTkqPsJmM/mbc3oRDOVAX+O7Klxbrl4L4cJm9ZJvcVT9m
 3CiibauZBDltDN9JgaTpLCaep42V6VYdSARdpgaLhofeYubfeyVwMzYEA8yILjlhkCl9
 0U++quuifFLXDg5mkRfQ65KD0lgX+V8CJdNq+KexIEnZt7VmXtX8l7+dpjogSy77Vq7t
 sfAYoX5wTwnuLqJUexzCY4/uUogE5+R1Lx0SndpI3Uumh5zVdhH9o3HbgPHg3NzJsBYb
 cT0qPic7c3vbO9L2hd75IJma7YIumDljnK1a4xOdFSjkvqVlNKcxVLsnCJPVnhj+xrFL
 mtYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716450033; x=1717054833;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iwZcsELBlCO5DXVXwAU+THj+aAobxissCS0tGjemweE=;
 b=ChXY/l/5ZK9wgt/ijzrKJXFUdoJJ33Z/fwV33NFOyNhaeWvQr0Z8OV84vyTl50XZpb
 gEBlQoDZSQKAs2HyxiVuxK5SJP8zz4IxTA85a+qUaSSiuXglCa89lQl90txrUU1MkcWY
 7651BHvhN//pc1o+hXJ9naEyFaR5ISflrSdqT16REwAA51Tu6fwsaHDS3xdAiQJ2CKFu
 PolFljaQOJtlU68n4v7UYUfN7Eaex3lI135S6PnauANzzzWpPO+PY+HvUevhiqtiHPEA
 GkzGHUhdMyuL3UfJEXGPhLMBKvI7CBzclNXwEheOAPQ0wVZqUijHuxkvuqsyqnZw8bdJ
 5TnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsKSzH63SsghxodLnwNRwNF0xuW4/NbcBVtyIYIq3Qm1ZX2Ug6F+FjLZWIqoriYJ8zrR7yq8XbEWUwN+xypIHtbGurZQ==
X-Gm-Message-State: AOJu0Yx3tnGaKCo8r+mU1xe5Lkn3AuwSB5+iWv/NrAROBWDcfa8inImX
 Vz5ZcXpOSB+6XHK2bcrNxLf0M9pL+qbBr/WLSWeNXbyQ209Px1NHfvLbswD6Z7TtNMt8cIEiADj
 oO9JJfPo1idPeQnhbNeQrhWJqT5kmtZKmwM7mkA==
X-Google-Smtp-Source: AGHT+IEO9yaWQnHf3rTunB5FM73ogTDZONo5Vd2wGZNYLjIPUDo14HPNq1ex1pS3OYREwWRVJ1yS9++8Oo1270GjQhY=
X-Received: by 2002:a05:6102:370a:b0:485:eaef:a2b7 with SMTP id
 ada2fe7eead31-4890a002339mr4455075137.8.1716450032846; Thu, 23 May 2024
 00:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240522165801.1871915-1-liujianfeng1994@gmail.com>
 <7e603c4d-bf76-4b38-894c-30d2cf128217@cherry.de>
In-Reply-To: <7e603c4d-bf76-4b38-894c-30d2cf128217@cherry.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 23 May 2024 13:10:21 +0530
Message-ID: <CAFA6WYNZh4BH6y_h_BkkVgHi3rNvsWd++mC2BDwqOF-NB8eHtQ@mail.gmail.com>
Subject: Re: [PATCH v2] board: rockchip: add ArmSoM Sige7 Rk3588 board
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Jianfeng Liu <liujianfeng1994@gmail.com>, u-boot@lists.denx.de, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Christopher Obbard <chris.obbard@collabora.com>,
 Elon Zhang <zhangzj@rock-chips.com>, 
 Eugen Hristev <eugen.hristev@collabora.com>, Jagan Teki <jagan@edgeble.ai>, 
 John Clark <inindev@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Joshua Riek <jjriek@verizon.net>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Sam Edwards <cfsworks@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Tianling Shen <cnsztl@gmail.com>,
 Tom Rini <trini@konsulko.com>, Weizhao Ouyang <weizhao.ouyang@arm.com>
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

On Wed, 22 May 2024 at 23:33, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Jianfeng Liu,
>
> On 5/22/24 6:58 PM, Jianfeng Liu wrote:
> [...]
> > Note that these commits:
> > - e18e5e8188f2 (arm64: dts: rockchip: add USBDP phys on rk3588)
> > - 6fca4edb93d3 (arm64: dts: rockchip: Add rk3588 GPU node)
> > are not synced to u-boot, so I remove usb3 drd nodes and gpu from kernel
> > devicetree.
> [...]> diff --git
> a/dts/upstream/src/arm64/rockchip/rk3588-armsom-sige7.dts
> b/dts/upstream/src/arm64/rockchip/rk3588-armsom-sige7.dts
> > new file mode 100644
> > index 0000000000..c7b46536ec
> > --- /dev/null
> > +++ b/dts/upstream/src/arm64/rockchip/rk3588-armsom-sige7.dts
>
> Sorry, I failed to explain properly what was expected.
>
> dts/upstream should never be touched except with
> dts/update-dts-subtree.sh script.
>
> Sadly, your board is not supported in v6.9 yet, only in the upcoming
> v6.10 :/
>
> So we have two options, we keep the dts in arch/arm/dts/ like you used
> to do, until we merge v6.10 dts in U-Boot (probably for v2024.10?), or
> we cherry-pick the changes for your board with dts/update-dts-subtree.sh
> script, see the instructions in the docs Tom has started writing:
> https://lore.kernel.org/u-boot/20240517174930.1028063-2-trini@konsulko.com/.
> I would very much like to see someone starting to look into the second
> option :)
>
> However... it seems we'll likely need to also cherry-pick patches for
> the GPU (should probably be straightforward as nothing would be using
> the GPU anyway in U-Boot) and the USBDP PHY... but this one we would
> need to update all -u-boot.dtsi for rk3588(s) boards that have it
> already to make it use the new label/DT, make sure that the driver still
> works... etc. Maybe not a small feat, but someone will have to do it at
> some point anyway :)
>
> You'd be the first one to do this cherry-picking into dts/upstream, so
> it'd be really interesting to us if you could provide feedback on what
> is unclear/not working, etc... so we can update the documentation or fix
> tools if they were to be insufficient.

+1

Although it is very much similar to normal cherry-picking patches, the
dts/update-dts-subtree.sh script is just there to hide the git subtree
specific details.

-Sumit

>
> Looking forward to your next patch,
> Cheers,
> Quentin
