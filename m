Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBC5CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 19:24:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31B408443A;
	Fri, 10 Oct 2025 21:23:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q8UxVpK8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E845F84047; Fri, 10 Oct 2025 21:23:29 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E08458432E
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 21:23:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-3627a1979a0so1668476fac.1
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 12:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760124206; x=1760729006; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FzmKreXHHRP2+pD3dEsiraCbggozt92S5TzWnPGg/+I=;
 b=q8UxVpK8DJzDrIak3LVNe7VrNb0kPw0uxEqJq5SpO3hB4DzfAPfydzyqLoCDwfHqln
 nda8nJEcflUtzupyFq0/CgV032qzhJqC+FYoMhytRhwYS/B4xZPLNqWXH9NK2MNrFXeR
 IpZlRBcFnt5w/TRfupBrezDb8ilEQxyNCwCBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760124206; x=1760729006;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FzmKreXHHRP2+pD3dEsiraCbggozt92S5TzWnPGg/+I=;
 b=AqKrmEDtKfczllx6eU868W4UhkHfQzan7B/MLUMgHkKamlywWFsMUxMz3bt+03kJ6a
 Ywaatf2mRAFNDMPVozKYJ76TnTuvdJpvca9I2ED/HWvJJclh1/dPKWC08o7xSqX4saY3
 J8cn/YFUwZdUKB2bhZuSpkrrmteHPBIU474FRrFNwt/Hj57Pn3l7xrsFhQE606Vg3pru
 sztVlZ/P6uRLirVPzJUIvnlUeXwZuM4p9vu/4i0bJ4apH+yZjS/otsqB/2NQWXHy+7m4
 5Oe/Uquwr8YdXdUEC6m9Ncw54Tcl7ClEeR8dnILHzIV3tgpcaZ6EmE9hxrHFJbq92Vhc
 g2NA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZ3ISoOvZJBJlaA0cDQsBYTLmEYhjirCu9Dz33HXe+l4EEvcNh3fLMOxKSJRxNqZx5gY89GsI=@lists.denx.de
X-Gm-Message-State: AOJu0YwST6eHmrxFUYqXNZHFi+CR6LIuCr21pdQ5grT4a99kBg7GK4ob
 hYMqCCHeXrZOJM5M/BB6rUBIS1if6otvMZ5t8YiALJUpocp3Vd6mP98BBASRXhCSqgc=
X-Gm-Gg: ASbGncvaF5jlEMa+ILtA+oZT6Of2CFcfV2Mqm8eT8cVYbk3FCmJZJOWgz5N46h8CPr3
 ltXXzoGhLeTja5/LO5BwZtaahjjvZCAiKBOZ/G4cuXapxXJDN4Rytx/2D+qgxYcRL2b1ZPATlqT
 aLSBmqaIPRwoK60S+znwZbikcOEfKlfSHDqp9yWqttkNeXLjW3jn2buskuCr1dTmW3YeiKRpAst
 UAY7t+OrK39jYKamEkV0iEPhO23kndSlkHtufTBTDc5tZy9PB8G16Bn+MSM9Q4ALTEUhmIACfhh
 HI6vWsusiieIdFU73Sj/O0J786y7v8UWGVaFNN76m+L5vDfFDdnsFsqm+RE/eG3Ycv6aL5gtjUR
 LTK9KUE4L5cbDrKrhI3+OMAzjwOTikL6AA8l8IJGL0rzFDMCGSW2D4zPegfvJdhoHNmXIUqf6hy
 VaCfU=
X-Google-Smtp-Source: AGHT+IEKtgn4IpI3r73x3fpTLtdiTP0hxJm19Dm8ekb6x0ZlDNBXU3dk51atHxpz6lARjYS7qclUAQ==
X-Received: by 2002:a05:6870:888d:b0:33c:25d:17e7 with SMTP id
 586e51a60fabf-3c0fa068db4mr5488362fac.48.1760124206518; 
 Fri, 10 Oct 2025 12:23:26 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8c8f581ecsm1155832fac.25.2025.10.10.12.23.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 12:23:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Fabio Estevam <festevam@gmail.com>, 
 Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de
In-Reply-To: <20251001132111.1490516-1-ghidoliemanuele@gmail.com>
References: <20251001132111.1490516-1-ghidoliemanuele@gmail.com>
Subject: Re: [PATCH v1 0/4] configs: toradex: enable USB Gadget OS Descriptors
Message-Id: <176012420572.1180358.7401989723523689449.b4-ty@konsulko.com>
Date: Fri, 10 Oct 2025 13:23:25 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Wed, 01 Oct 2025 15:21:03 +0200, Emanuele Ghidoli wrote:

> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> USB OS Descriptors are used to install and configure the device without
> requiring any user interaction on OS which support them (e.g. Windows).
> Enable them in order to improve the user experience when fastboot is used.
> 
> Emanuele Ghidoli (4):
>   configs: apalis-imx6: enable USB Gadget OS Descriptors for fastboot
>   configs: colibri-*: enable USB Gadget OS Descriptors for fastboot
>   configs: verdin-imx8m[mp]: enable USB Gadget OS Descriptors for
>     fastboot
>   configs: toradex-smarc-imx8mp: enable USB Gadget OS Descriptors for
>     fastboot
> 
> [...]

Applied to u-boot/master, thanks!

[1/4] configs: apalis-imx6: enable USB Gadget OS Descriptors for fastboot
      commit: d748154ff17d8b9e09b4e3df194c5bae49ea454d
[2/4] configs: colibri-*: enable USB Gadget OS Descriptors for fastboot
      commit: 4580222b87b474fa2aaed52f1644aed090bfcf20
[3/4] configs: verdin-imx8m[mp]: enable USB Gadget OS Descriptors for fastboot
      commit: 86901e07492989ed680b7219986b5cc2f7a36bdc
[4/4] configs: toradex-smarc-imx8mp: enable USB Gadget OS Descriptors for fastboot
      commit: 6052e225fa04d5a8262e251430acc5e28c1a7e6b
-- 
Tom


