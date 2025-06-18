Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02063C71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 09:59:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3695282CD5;
	Wed, 18 Jun 2025 11:59:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="T5aHGEJx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0E0482D17; Wed, 18 Jun 2025 11:59:25 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB4A382CC9
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 11:59:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikko.rapeli@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-553d52cb80dso301200e87.1
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 02:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750240763; x=1750845563; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TpuAQMjur9JYh90sYK2QCxLvg1bKVesXPgE7FXt9NXc=;
 b=T5aHGEJxhmf270NmXcpjZNtYxQgLbibq/26pwazjrOmDVKKYHkvmuO9BzCfLlYBJrp
 sbIVwz8vabtYVhrM+AO6/g7wP5ggnA91NKGf5i9tm9d4cBLEH6JB1hjkScsjcOa4PLFe
 JuukJ3X0BPy00f/zySw9u7W40Irtkk5IfXzSejRhiMoeRVp6ewG31+K36WrTSMuzWsOd
 iRlKI8Ym5J28IEvzg2l3VGXXXZi1/MDNRbJzV6W0Alw1SzfQ07lfZYHk7RZ5MNmX+j0O
 Eo720Sym/Z6OKiaR30IsTupy8fAO6gN3GVSKeSSK2Q+5rhm4v/P8Y4ZpiKuA/VKZSCbZ
 +x1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750240763; x=1750845563;
 h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TpuAQMjur9JYh90sYK2QCxLvg1bKVesXPgE7FXt9NXc=;
 b=bi/qMmO5zTo2FyVVdUPyLmb+qSqSJNweF7I7dOUqpQbYkPt/Iu9zAdg9vdbUrjUa8W
 tBspCTbG/MCA6dGZcu87uxpg5QtdBkId1/6ewvvDap2abTEJxpvg7w75Z+7Lv8q4D0Cr
 gVDb86rmNtwctZjGvhgdKIEhiJ0jlbZOd8IH2N+UaxrqU+bKYqMKDZ4+hVRRRJsnvRMK
 XVHFbwLRsnYt8NwsVr+1C6+9oi1S/BgJyE3bl4bOnzmwVY/TOU9T0ATY4X0EXw8+pBmN
 KkILUpTFUNkVO/WHKKM9HryE9bzCfl1mn8kymWgZKisMe/f0BT+YArbOjr1mdRFCKXoB
 rq8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnTh2AocwY1eMw/saEsLV5SnqtgC+pXW9uJCPMua+ZzQ4e/061ITj5HkVtXf1YNyoSDwclHnQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwuO/QXj/Pnt6LXnkUdEXurIzf16QKckq7fH5eNY33DRac5tnmA
 WlpDQAtRUABpg7Pro8ip0Pihy6xGXC4cJriL4clPWY45VIy5u015Xk+pYKhWsswKbBk=
X-Gm-Gg: ASbGncvP0OeMzAqghinJiLrF88CkO3uOUA+gl1GvpsZx/puJaoc3drq46Z2BlC7z52W
 W7Gv20M048CgahA+bATsjxLqBSP70dte9eGfgo2t/eQVyTCcBKdtlU7NZuVxTEx/00SUxHFKl0t
 gAVYjRowOoWdQbxz1vsT1hXpNF+NZxVTIaR89XcyGkbI8Mn8ZFBFBVaIXKOaZGWWWD7N3B4kNBP
 Rc3Q1qm6Kf8udEXNi5QwMrDUW2t4cpOtzMHjICbdLZrzsn2Bqr9iiWUg+rw/rEpK978+7GfOzog
 0MGzAiAmVibzmc2XCuHytWaMFvMZO4jMWr+qv3OHXTMTwxDk+wXzU8uyGnSOu4m1xUPfPV4ir1d
 7oYLbR5YLHCHPOyMtwWQ=
X-Google-Smtp-Source: AGHT+IE5t+LXdp3I/Q/v2WG/M8B5d4CuTzgVK2i8vVhBaFVWX3Gv4XT++3yg+0n4NnELNzEBT/mV6w==
X-Received: by 2002:a05:6512:2215:b0:553:2438:8d16 with SMTP id
 2adb3069b0e04-553d393f333mr564097e87.20.1750240762959; 
 Wed, 18 Jun 2025 02:59:22 -0700 (PDT)
Received: from nuoska (87-100-218-141.bb.dnainternet.fi. [87.100.218.141])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-553ac135c7csm2216134e87.64.2025.06.18.02.59.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 02:59:22 -0700 (PDT)
Date: Wed, 18 Jun 2025 12:59:20 +0300
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: trini@konsulko.com, jerome.forissier@linaro.org,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Liya Huang <1425075683@qq.com>, Boyan Karatotev <boyan.karatotev@arm.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Raymond Mao <raymond.mao@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH v2 0/3] Fix io accessors for KVM
Message-ID: <aFKN-N8RhWsBOhWp@nuoska>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618065828.1312146-4-ilias.apalodimas@linaro.org>
 <20250618065828.1312146-3-ilias.apalodimas@linaro.org>
 <20250618065828.1312146-2-ilias.apalodimas@linaro.org>
 <20250618065828.1312146-1-ilias.apalodimas@linaro.org>
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

Hi,

Tested on yocto poky master branch using u-boot master branch
commit 17012e3068d047ad71460f039eeb0c3be63f82a0 and these
patches. qemu KVM boot on aarch64 works again with USB devices
enabled in qemu system.

Tested-by: Mikko Rapeli <mikko.rapeli@linaro.org>

Cheers,

-Mikko
