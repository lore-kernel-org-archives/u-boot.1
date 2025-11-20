Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6290CF64AB
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 09:45:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55C3E840CB;
	Thu, 20 Nov 2025 10:45:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tgXzOWRJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1700C840CC; Thu, 20 Nov 2025 10:44:32 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DA8984057
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 10:44:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42bb288c17bso418331f8f.2
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 01:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763631869; x=1764236669; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gmqxkYLtbJA9FZ+8cdpn0mNkYBiBQ3JmV8KLmOvJN2I=;
 b=tgXzOWRJprAvMdc4U6F51g19IxUrCJyeojV+mo03T7TltNte1CW60uMPjUTk3FAPFp
 PMZ531jja9PnQiR/5uGomAmuJ3c14/r5INQMlm8w3/AesYJMTQC+Tp277a0EIZS/XY9h
 q6kHfGXIkdGC9777fm+P60XOMaUM7Tbij8GnEy7HCxqdchKhJIxRBDPwBLfV8FB7ZBNK
 upXBtCjAkGm6jaX+hcDUU2aNm+5YcwpT6bcZ61CxNKVkvsTPjrQqheV1Q2IzFW9jt4s4
 +GxzsVFDWvoBAVGZFUFudoN+RSQsRe7ziDDzGzqt7Z1dPhrvjztVRHO9oeNZaNixq/Ox
 ARwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763631869; x=1764236669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gmqxkYLtbJA9FZ+8cdpn0mNkYBiBQ3JmV8KLmOvJN2I=;
 b=tGndHB0QO/pcXTWuGZ0SzAptgVC6Q1NF/HfBd92hhgrMjzEaBt2YLJ5OUO/OmGuOWq
 MwSKqjl7W4baYQzEW+TaAiVRgXya+OXhDQ7lSKgUK923vgBX+kn8GXCy2th1N0KCIYpQ
 zOHXM1v0v8lt4YwvzgRGmBrgv3lHM7FeCaJS/c8szLLeGCS04ePszNhC8RGM7R9Jk4D1
 8b+W6QOXYJP9KYGaChvDcQqmr6HuX+uFH+o15QoSdWzTBH4y9n2y1RIl5SOTqVhk/+Jp
 81l7VgaiQn9yaOFUV6/mSovmg0p4tw9v7gz3SGklN8B7pLc7bAUHLYKK3qASJcYp1J2x
 EBSQ==
X-Gm-Message-State: AOJu0YzBNYxWnkGpxmnFgKFeA3NzlbdRws40y0HtEUr0hXwNWknkHZeg
 uV7IjImhUYo4sYVpzZ1PcSdspWIudM5oB9NkonakTKohCB4zsYnrnUdlR8CZGbO3moFS+5nY9G3
 c1Qim
X-Gm-Gg: ASbGnctY5n2K1CCUwXWMMr08yHMoCx691DV4q8O4X4k4lo+Quv/K8frq8AvP04rY1Qg
 8c58tDBkf1ggXUfyoN2Lt8FMwSrIYYhVFzrSHq0zsWxbvW09dk4voAE1qc/9CXvGx9p1Tc4jAe6
 9bBtNetWlPlfBycJkgM6pkpjT0Wi1Fh55cKk2uR7tgtlATU7O3b5y4B2Tp4EwsNxc/0UlpfqFzW
 ZeraaxU0C8KPq1jXrwCGEWaYuceqmtKkhwgVDDsneRM8tQSoPNQw58TXxDAO1UyVNzrM4CZ5XfU
 7uXH9UCc8wEETdvW602gQYcSZ1y2xZQDBLmbnWTlaND+VVzeJZIErjX+0TAp2bRGNUIDCX5RUB0
 g0EBYY/y2KV1V6gTMFBuDAmQeFFbGaHObaUzDbl5FUpFdQBlX1U2ABSZNMCxGYbwANhG4um9Ihs
 zwbbiNWLTxrW8YjAhL69K/GGN5mf+ur7KcDxOBM6KoyQ==
X-Google-Smtp-Source: AGHT+IHtX7/8VQIbabgao1+dW461Ct8AaBgLXUrKJnGDdskRE2AvFdeI3VsEBP+V/kCUWc0TcPp+Dw==
X-Received: by 2002:a05:6000:228a:b0:42b:3131:5433 with SMTP id
 ffacd0b85a97d-42cb9a2decbmr2069758f8f.26.1763631869310; 
 Thu, 20 Nov 2025 01:44:29 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fa3a6bsm4341813f8f.28.2025.11.20.01.44.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 01:44:28 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-qcom@groups.io, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Hrushikesh Salunke <h-salunke@ti.com>, Anurag Dutta <a-dutta@ti.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mario Six <mario.six@gdsys.cc>, Christian Marangi <ansuelsmth@gmail.com>,
 Heiko Schocher <hs@nabladev.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Peng Fan <peng.fan@nxp.com>,
 Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>,
 Alexander Graf <agraf@csgraf.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Greg Malysa <malysagreg@gmail.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>, Sam Day <me@samcday.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Marek Vasut <marex@denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Sajna <sajattack@postmarketos.org>
Subject: Re: [PATCH v5 0/7] Implement the Generic System Interconnect
 Subsystem for U-Boot
Date: Thu, 20 Nov 2025 10:44:26 +0100
Message-Id: <176363183225.2293399.15130710527365930765.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251120-topic-interconnect-next-v5-0-e8a82720da5d@linaro.org>
References: <20251120-topic-interconnect-next-v5-0-e8a82720da5d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Nov 2025 10:45:22 +0100
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


On Thu, 20 Nov 2025 09:12:51 +0100, Neil Armstrong wrote:
> Let's introduce the Generic System Interconnect subsystem based on
> the counterpart Linux framework which is used to vote for bandwidth
> across multiple SoC busses.
> 
> Documentation for the Linux Generic System Interconnect Subsystem can
> be found at [1].
> 
> [...]

Applied, thanks!

[1/7] Introduce the Generic System Interconnect Subsystem
      commit: 60a99d5ca374c83c0118f2634a7fcf4cc707b965
[2/7] interconnect: add DM test suite
      commit: 9ab7163710d390672a7325cd0980ce32e2a8191a
[3/7] MAINTAINERS: add myself as Maintainer of the Generic System Interconnect Subsystem
      commit: 3949b33049393c66140782adb2579c2fc09839bd
[4/7] interconnect: add support for the Qualcomm RPMh helpers
      commit: 591b9e14192f74a004e0be70c395c30f06810fca
[5/7] interconnect: add support for the SM8650 SoC
      commit: 8ec059c5ce7de20c22b8501bd4cbcb80f1dab781
[6/7] ufs: qcom: vote for interconnect bandwidth on probe
      commit: e1461a0f538152093c87b33022b629898294cff1
[7/7] qcom_defconfig: enable interconnect for SM8650
      commit: fb3db4aa8df2ae5093a5c1580b9cd5789c248de4

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
