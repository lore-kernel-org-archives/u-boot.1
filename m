Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284A4C282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 20:29:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FB4280FF7;
	Thu, 13 Mar 2025 21:29:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="R4j8HpBR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47C7281870; Thu, 13 Mar 2025 19:43:47 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49ED2817EC
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 19:43:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6e86b92d3b0so11803246d6.2
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 11:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741891421; x=1742496221; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KEzR60LL17+rtu6LFVU6IWox6ciPWSFDOYWoTzXP4m0=;
 b=R4j8HpBR8fp55hJxS+muNIOL+OULC7638YIf03xVR7u6XNrcU2oKtTyKo+PhUT95eU
 eoQ+GbyxJVpTZYbvP9JZMaw36B9hHo0kcOSb8cVtVa69nF2m6Qen3g8rRErwmEWsAJPm
 7DT2hFRmOCjfP+Z0OwjnscEtzLfzIE0FU/S08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741891421; x=1742496221;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KEzR60LL17+rtu6LFVU6IWox6ciPWSFDOYWoTzXP4m0=;
 b=pg+4UdzcRcAJ0+u6+NfhApYfsqFmddGBRAD3NhVwV5PC0d0lkLumRyMlXBwXl6bTw+
 aWtMtnIu+hLQnmi77R57UfO2tePMkWD5keDIXsT0RFeSbUNm64fylwBawlESfq3i1aQO
 n+RUKRm9bKScu24aNMUY76fMiMXdg+NB+B0uOCVugSDnG/uOtWA8lvtY2pWF+rAGYkQY
 0Rc+0tNSd+lELrJ+flEm/q6HtOzptVrQcA7rjscMOg8WHNQrqL8xbXJliS/lrnp3t8Vc
 RH3wPswYIMvVdgs1sbNaa+WBPMgq5TaRnpaq8a+OGHgklbhXqdvYnkWfsGk26ceWP1jc
 McwA==
X-Gm-Message-State: AOJu0YyqJKV/jqeaaAEq2Bb2hzGO2LRJ+NdzbTGfiCUuFLOVwrtNCP0u
 uR0bukQH53/9D43ex5zN3Ov4JYWpvEJS54dj3LSWMICZp9izl50EZQudVZ4P+QE=
X-Gm-Gg: ASbGncuvja1sx9shnQfmAklWt4AThIytzFvanwJOLajN5XNYoagHqGw5Owvw+7FQxjy
 JXJt00yEScrFrYCYVjM8RWUK347sLQy+JwnssltuLbiTCVVJ1uclrP/VXi8r8KOqFQko9wTLpfl
 lxxHlPjQVnYxKmUWa+3z9CyPr3UpYjhS870JYjpG3kwXL9GxmkN46YCeG4mcY2wUSdZmAW0Dl2M
 vLoLcmH0vmgCSjDob7mFFnjdfSj5iXxdPDEJEU/MuJFXCQpD9lps34GwYSh0OkScYCLpY3tAQYU
 xulel/DzvCVschGvGE8EOzvDYKb9xuQBY3/AhcbK9peL
X-Google-Smtp-Source: AGHT+IGWvSOMQzc6Qn48AVPyQEF9lpMK2HQ+gDGqmRPyI9Z5j+hrfvhPdv4H7OWhWuMPlVLwNcvexQ==
X-Received: by 2002:a05:6214:e48:b0:6e8:f1c4:f9e8 with SMTP id
 6a1803df08f44-6eae79a34ebmr12371726d6.3.1741891421169; 
 Thu, 13 Mar 2025 11:43:41 -0700 (PDT)
Received: from [127.0.1.1] ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eade231261sm12640476d6.30.2025.03.13.11.43.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 11:43:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Albert Aribaud <albert.u.boot@aribaud.net>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>, 
 Alison Wang <alison.wang@nxp.com>, Anatolij Gustschin <agust@denx.de>, 
 Chee Hong Ang <chee.hong.ang@intel.com>, Chen-Yu Tsai <wens@csie.org>, 
 Dinh Nguyen <dinguyen@kernel.org>, Dragan Simic <dsimic@manjaro.org>, 
 Gary Bisson <bisson.gary@gmail.com>, 
 Holger Brunck <holger.brunck@hitachienergy.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Leo <ycliang@andestech.com>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Matteo Lisi <matteo.lisi@engicam.com>, 
 Mike Looijmans <mike.looijmans@topic.nl>, 
 Olaf Mandel <o.mandel@menlosystems.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Raymond Mao <raymond.mao@linaro.org>, Rick Chen <rick@andestech.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Sean Anderson <seanga2@gmail.com>, 
 Stefan Roese <sr@denx.de>, Tony Dinh <mibodhi@gmail.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Wasim Khan <wasim.khan@nxp.com>, Yannic Moog <y.moog@phytec.de>, 
 Ye Li <ye.li@nxp.com>, u-boot@dh-electronics.com, 
 Sumit Garg <sumit.garg@kernel.org>
In-Reply-To: <20250228122042.1277079-1-sjg@chromium.org>
References: <20250228122042.1277079-1-sjg@chromium.org>
Subject: Re: [PATCH v4 0/4] xPL-stack cleanup
Message-Id: <174189141658.2132480.3168802510111332482.b4-ty@konsulko.com>
Date: Thu, 13 Mar 2025 12:43:36 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Thu, 13 Mar 2025 21:29:53 +0100
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

On Fri, 28 Feb 2025 05:20:22 -0700, Simon Glass wrote:

> This series was split from the VBE part H series. It adjusts the logic
> for selecting the top of the stack so that it is more consistent across
> xPL phases.
> 
> Changes in v4:
> - Rebase to -next
> 
> [...]

Applied to u-boot/next, thanks!

[1/4] tpl: Rename TPL_NEEDS_SEPARATE_STACK to TPL_HAVE_INIT_STACK
      commit: e7741f11246102a9bf5e3b5585bb5688afe588b7
[2/4] spl: Add an SPL_HAVE_INIT_STACK option
      commit: d6a53f523afea94fb20fe4f9babcd880833372f1
[3/4] spl: Use CONFIG_VAL() to obtain the SPL stack
      commit: ffa98c08e8597ecb3668025ae881630f5664684e
[4/4] arm: Support a separate stack for VPL
      commit: f09d5b28ff60808e81f7c7bb97855e2db8da9bd9
-- 
Tom


