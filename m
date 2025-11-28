Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC85FD116E2
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 14:38:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43ACC84598;
	Fri, 28 Nov 2025 15:38:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qh7OJddH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E9C3845A1; Fri, 28 Nov 2025 15:38:33 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C02484564
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 15:38:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b7355f6ef12so390361166b.3
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 06:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764340711; x=1764945511; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4r14P1EuxMbAWo2k0wtjGFSh5hl7klHb0iulPdPCxAs=;
 b=Qh7OJddHuNo8HWKSjUC3zaEESsY6Ial8saCfuEM7XODpAlKbNWB/i1H+w5BwegUx/7
 kAFmM1GVb6wK110JtamzJy/1ZilvO9utJdfBIJ+J7QjA/O0JCYQEAIlM1z9pbEUYMn6Q
 poJekl9zUheiIukITSmS31JEQ/QA7bXehgI8vVpKd9RbC1is9iMK5aMuto3d9BBXuyCr
 7ngsviQ6WmQKw3iyYeyHEFGLXt4z28K+ZtbRvyx5eVZ44QZ5QCfUg2rS1hsr4uyHC98K
 797nShXMvjXH15FkDSkKbT47V1IQ3cPH/JC+r3624x9zBX2/g+pXAODKvp77/0SigX9O
 1G5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764340711; x=1764945511;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4r14P1EuxMbAWo2k0wtjGFSh5hl7klHb0iulPdPCxAs=;
 b=PbVkSSaSy/aPLCqFFlbpvuPzaWwzyPuHLoXf4ZecKwtMDdFzcNeuwbRBZJ1SaqKmJ5
 II+zzaq/FjscMtpxukHs2joSeHSawWmbRQm1T1jh9UPd4K1rCudgtnJQbOjLuzYlyoej
 sTAIzYwlZ115XJIqy+D+cm2RmunjE2bFMbokq9unDu/p6qJuiHThJBU9faZso8RaYZdG
 Wwy/8L3FYKFrbFMX9Dr7tVV3+w+0KF99/g5M1G18S1bajzs/HvYuSCv8NeLBmyx9NQRZ
 WBqydMKXGWaNtj0vu6bgbXWfJ77Jb6fiMrdAvLPE85UWsPxy9RPhIMtNiRxG/MUrSm9s
 JSDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXb0PuFPB55d+B4GTBBWDhgbulUmzHIKU/Nek0Bky3IizuLsWe2c1u32YLsCJlVxluTwb9/Gs=@lists.denx.de
X-Gm-Message-State: AOJu0YzxhofYfqVuAnhQDJbotLuBjxJCtWH13RVdwZ4A0osQXelCslD+
 2U+TRNMQqPB/8PaSLFP/ykSpuTFLoR2IGsFH7vAUQ3qEGrOriTgo6PZBM7+xXx3XmkS0LlqzwRh
 EKLGmCmhgQBNR+DJaUaz+D+VlqqO/OEM=
X-Gm-Gg: ASbGncvmMTrXntZ/LKyxaRBLayhbEVZaHR5/00gu+x/jl8WMDPteYgrhyD2Lx3hGFiV
 4iqEVUtDZH0GxkGxeGiG3iAfEifakLMeZHrgMtQ+Bwdg6FDT+jGrRgDHmeqcQw1DThQvqQQw5Kp
 bd/u/p69v4UwERoXL0V4hYbby5jjWIcJglZT9oiTVkCcqavNJgYbLXFLYT2CXiBgeaXCPO7jWk9
 Q5kN//D9fGDRFL8ZEUK7z//HhqVaOg96UHWG43E5tPbQzc+7QW72rbp+O1H+FGRgc8G2adkgTKz
 8VOvFccB68265XbfyO7skrg/D7vjoQvQLRa9K56DQaW/X9LZEDv84D+cNzRG7NdF1C/QWb+VsJv
 CSljDAxiuBO9Mp8dfdcs7pbZeNyCkueqkHdc7o7FWWfDXGLU02wc1t1eyZfcG0os2
X-Google-Smtp-Source: AGHT+IFZrBIVocjbsMrzbT3b4z9l9xAd4E4T9z6Onb0yoSdXtgmTt5PxCgUGu4HnzZ4eKQKGgFcTdiL3v0ArMPWBLdQ=
X-Received: by 2002:a17:907:3da8:b0:b6d:50f7:a805 with SMTP id
 a640c23a62f3a-b76719d0791mr3269366066b.59.1764340710464; Fri, 28 Nov 2025
 06:38:30 -0800 (PST)
MIME-Version: 1.0
References: <20251105163553.15F2A227AAC@verein.lst.de>
In-Reply-To: <20251105163553.15F2A227AAC@verein.lst.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 28 Nov 2025 14:38:19 +0000
X-Gm-Features: AWmQ_bmfuSBCP6msolSv_T990DUHWg2SoSSV6dz0WHUnVkSaNkis1N5UDrpERtk
Message-ID: <CALeDE9Pwp9j4Nh-YS-ncx+HfXz4oVfabkd6-eDgQwS6JOO4ZxA@mail.gmail.com>
Subject: Re: [RESEND PATCH 0/4] Improve RaspBerry Pi 5 support part1: Fixes
To: Torsten Duwe <duwe@lst.de>
Cc: Matthias Brugger <mbrugger@suse.com>, Simon Glass <sjg@chromium.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Heiko Stuebner <heiko@sntech.de>, 
 Huan Zhou <me@per1cycle.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?UTF-8?B?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Joseph Chen <chenjh@rock-chips.com>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
 Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
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

Hi Torsten,

> here is the requested resend of the first mini-series with the fixes,
> now hopefully with all interested people involved. I regenerated it
> using get_maintainer.pl on part1 and part2, for the heads-up.
> I also added Oleksii's refreshed review tag.
>
> Part2 takes actually longer to rework than expected; documentation on the
> PCIe bridges is not so opulent, mildly speaking.
>
> This set should apply cleanly on 2025.10 and on master [1c250e444ad].

So generally these all need more work.

To begin with the commit messages in general, as well as the proper
sign offs and attributions, are a mess and definitely need a cleanup.

The set of 4 patches as a whole don't actually fix anything because
for example, there's PCIe fixes in there, but given there hasn't been
work done to add support for the PCIe IP that's in the bcm2712 SoC if
they do fix something to make that work without the enablement patches
they're basically a no-op. Also it seems you have an issue with your
mail service because I never got [1] your mail about not applying
something.

What I would like to see, which I believe I asked for when the
original series was sent, it is broken down into a few series:
1) Fixes for existing support without feature enablement
2) A PCIe enablement series, this would include, if necessary, and
PCIe fixes like from this series, enable NVME etc
3) A patch series for the RP1 chip, the support here is now upstream
so we know what this looks like, this would include any fixes for say
macb so it can work, any config updates to enabled ethernet/USB etc.

If you've got any clarifications feel free to either post here or
happy to have a chat separately via IRC/matrix/VC etc.

Cheers,
Peter

[1] https://lore.kernel.org/u-boot/20251119174740.00be0a78@rocky.lan/
