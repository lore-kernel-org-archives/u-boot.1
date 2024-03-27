Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F536CD11DD
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 01:04:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AFE887F78;
	Wed, 27 Mar 2024 02:04:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fgo0Ydaf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4251487E47; Wed, 27 Mar 2024 02:04:12 +0100 (CET)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B13E987E47
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 02:04:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6ea895eaaadso1070656b3a.1
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 18:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711501445; x=1712106245; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q1vP1VLeEZQR7Aw/Xx376kC7KlUHvWn5Aj8D2ktfEt4=;
 b=Fgo0YdafCZjo3TzS8oplxRKZF3HnZZSvrDDcL9L0KWBjEuVzrIQm5CBr1ieG+iYDuS
 H4JQ+V4LzOo9stw6egGBA4ljTJxS1OvZZHnDg2ubRGGX9xYwKJPQbpw/1H9f0P5Ts6c5
 YuUJ6SsyNPq4fqIAHJLv7FdzqHpkFhkpf/4MoWrXj/Ffh0cC9clmAnAdBsdoafZzEOoJ
 19yxTz0keja4mhEyKu4ynZRvcW68k0L/fzuGH9bkYQGSq2dGYsX5GSbJMGUZJlUSUSgL
 9no1kReZJAK8K8OsCsyaDvZyXx/v/UNTXTzUeV/bc4X3JSISoZuojt+RWPWCSBeZjPIr
 3Atg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711501445; x=1712106245;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q1vP1VLeEZQR7Aw/Xx376kC7KlUHvWn5Aj8D2ktfEt4=;
 b=N+hW7XRjAQqVxus8QzQCs8GQ3PjkZnlswjndK1qQ2lkukBdML+SaEDRyLY5BtEMv/+
 DQJzeo0MJqaqQqiAwtQLC8qUZWWIIooUS+xBY7vsjql3VKi67S2XtHACR9We0L4zdnC+
 nnbM6zsNxj9DOzJ+1hi6XIZFzY8V4iPHDhhVQj9zaWPoxrB7XKSce7trJhVRrP8VpO12
 rgE8O85dfUqKzOIP2oKB+Wu4YKIXNXoQOgC7pmSR18wxRKekmBdADj5N0oJEElrkaWNr
 H4XflQYVh6Muj0uDw2AQLpytaQnRZcsRmhNdXoIUUUnxrXyvlxDmCJIIQmE9Fo2Nyqqo
 U4Jw==
X-Gm-Message-State: AOJu0YwEtuBNTYDqCk40fA+hznHHE0wmcwGUSV0drFQ6BsVTKXxwwdg9
 2hDDK2+oebLUFVPjnlsHEGT4qe+D9RWROAo3Vwb91IvCiLALcLtKlfj/Qvfd0n1kKeMg6GGgP9V
 FUkvjg55WF3NPdex/YuPndeItvlM=
X-Google-Smtp-Source: AGHT+IGekDIBC2RJfzzB909ym8wtQ4JraE2/OcTp1X/ez7twp/g9NhV6viIAcUL8kyYOMCd2/wDZzrAm6OuLiyPJL6Y=
X-Received: by 2002:a05:6a20:daa9:b0:1a3:c61f:c2d5 with SMTP id
 iy41-20020a056a20daa900b001a3c61fc2d5mr9463094pzb.6.1711501445117; Tue, 26
 Mar 2024 18:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240326202439.46707-1-aford173@gmail.com>
 <20240326202439.46707-5-aford173@gmail.com>
In-Reply-To: <20240326202439.46707-5-aford173@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 26 Mar 2024 22:03:53 -0300
Message-ID: <CAOMZO5CGm_OXe-oxK2qhWnnfzy=Bz57oV57XEo7-6KV5jpXSPg@mail.gmail.com>
Subject: Re: [PATCH 5/7] arm64: imx: imx8mm-beacon: Migrate to OF_UPSTREAM
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, 
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marex@denx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tim Harvey <tharvey@gateworks.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Hai Pham <hai.pham.ud@renesas.com>, 
 Andrew Davis <afd@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Gilles Talis <gilles.talis@gmail.com>, 
 Patrick Wildt <patrick@blueri.se>, Simon Glass <sjg@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Martyn Welch <martyn.welch@collabora.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>
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

Hi Adam,

On Tue, Mar 26, 2024 at 5:25=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:
>
> The imx8mm-beacon boards can migrate to OF_UPSTREAM which also
> allows for the removal the device tree files.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Please split the series by SoC family, thanks.
