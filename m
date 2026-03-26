Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29E0106F30F
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 09:30:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34D9183EAC;
	Thu, 26 Mar 2026 10:30:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DyWorR5h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E04A83F86; Thu, 26 Mar 2026 10:30:20 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBDCB838BB
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 10:30:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4852e9ca034so7266005e9.2
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 02:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774517417; x=1775122217; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=u/1E3XJVA4/n+ORYtOSJ9uubj2svA1SkWoojEpFcseQ=;
 b=DyWorR5hmmWGHyM2NrBX+rm82j1wqe0kehjyCiLX7itOxUkaeuYY6d1UcYxhExC68e
 eJh3qLrrBtBV4+d0tb3D/b/IDCTtEl8BnykPV5SNRff83Hz0Y4lA0x6n/len1jaMUcoa
 uAdw/ARh/G/oP85hZ2G4jvP114AD9jAN8v5dQCE2pMnQ7svVClUmIBS+RMIEZInlIyQm
 CeE9EINNuH1Qq4/9OxlYy8L76XKOK0ddZNYQQXhR2hwJW0eyUMg5DdmXS2JgXzMfxMyq
 lfdVGzxUhWeM/uk4kHP/Wca5TiibVy4/dZ8ooXdKMBdSyYT3OKEdSoh7dorRzGzWApTS
 S6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774517417; x=1775122217;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u/1E3XJVA4/n+ORYtOSJ9uubj2svA1SkWoojEpFcseQ=;
 b=UDLlp247ormVw/dRX52kTKwxgYTxlH1a7sfQcWQkP1H5VaKU4pk8trude23UQzBrYW
 iMpkCH+57tWKX2ZIGLw24qxXaQLs/96GCQsNoXVP42Ep3FVocnmFDQoXPeaWhgei8JsU
 OCrZjn3MFX7bsxASxEvM3U/pDxjusR8pEzlEgSAXwFwfWizfm/2sC0z9WiEVAyKrFb/2
 Q59qTMYPHID8hPLHvRHZur17YGO46ehUtZvZQeFdQmY/N6os52Piz0Fib+UwvVE6QYpF
 vfDsaTFIKVgojq2aLBzX72lwbcB222rvNfp/eyVn6Z3VOo+z4teu8gEJEZDUXY/m2Cxg
 PknA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+LudS34OW6lRPvbAFQhWKRdGl/euIxGcl9tPLHW5FZokxlPXDFVc714W3LyOFNwAw4UlM0bE=@lists.denx.de
X-Gm-Message-State: AOJu0Ywye9b8riaZv3b8ljX4FIz/hknxKzeVVJXyXa7x3/GfQVGYoKrZ
 e4pqM5jHsIOfrC7ZpTqy76VOfibl/bZJoC+leWpKa539gM8OGcAGVwMUqf075j8p6JI=
X-Gm-Gg: ATEYQzwEEu9MbkSNSvR2ZXx8sskRsZd3uMlaLJBTW6xxKSaeb28reEhCU5y7qstXvTA
 Im5c2aCIXaliZO+G1RvXcFlkcOSZHk9ZekNgMUV2roUKYUh7fvtWiDZwC+Zvq9i6NP+0qHRxrCZ
 oyrDVew/LslhwNJCW015fisauwdi2eBuidr8DQBYJKeTgDBJ4ZacuN/gCVUPqUPwAkEGo5isLL/
 b52aI6PxctrO+9e7bZWsaJ37ppiYcsLf3yEja0NHzUVsLbJKmKUKQBqa+VVDfK9wBpbVLyMymSS
 uhTcydMNQP9fsFLH2bVF75X9qjllkMiKmEcHWZUyq6mAgG8ue2DtTwhj37/BUN9XRZ6LMlMLlhA
 hEFSSPwAncVr/pd/AWIukq0KUQMHDUAtllY4S63w8MmhWLhldJPmmoep7MZTI7vXr1DdnAdl3BB
 z6vOH74c/yt5aa98A1nVoXDbkcj4Rt
X-Received: by 2002:a05:600c:3490:b0:486:f8e9:add5 with SMTP id
 5b1f17b1804b1-48716042c08mr101023585e9.19.1774517416931; 
 Thu, 26 Mar 2026 02:30:16 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722c957b9sm35804605e9.8.2026.03.26.02.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 02:30:16 -0700 (PDT)
Date: Thu, 26 Mar 2026 12:30:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Marek Vasut <marex@denx.de>, Greg Malysa <malysagreg@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Yao Zi <me@ziyao.cc>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Anis Chali <chalianis1@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>, Ye Li <ye.li@nxp.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, u-boot@lists.denx.de,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 arm-scmi@vger.kernel.org, linux-gpio@vger.kernel.org,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Khaled Ali Ahmed <Khaled.AliAhmed@arm.com>,
 Michal Simek <michal.simek@amd.com>,
 Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH v2 3/4] scmi: pinctrl: add pinctrl driver for SCMI
Message-ID: <acT8pMQkFd2NKMTf@stanley.mountain>
References: <cover.1773256350.git.dan.carpenter@linaro.org>
 <1048331f5d3c8e0cdbe1542bcb65bbf942a4275b.1773256350.git.dan.carpenter@linaro.org>
 <CAD++jLmfRVGGHH1EqMAeSVHVCr1-s2JPyuY_w=2h35_mKUXj2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD++jLmfRVGGHH1EqMAeSVHVCr1-s2JPyuY_w=2h35_mKUXj2Q@mail.gmail.com>
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

On Tue, Mar 24, 2026 at 02:19:34PM +0100, Linus Walleij wrote:
> I really can't endorse it though: with deviant device trees and
> information stored in paralllel in two places we create a
> maintenance hurdle.

Yeah.  Looking at this more carefully, you're right.  Let me do
this in the right way.

regards,
dan carpenter

