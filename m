Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE06FA3728
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 16:07:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0704383A91;
	Fri,  2 Jan 2026 17:07:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f4WeTsRH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8355083AB7; Fri,  2 Jan 2026 17:07:55 +0100 (CET)
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com
 [IPv6:2607:f8b0:4864:20::c43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59C93839A8
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 17:07:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc43.google.com with SMTP id
 006d021491bc7-657523b5db0so2606210eaf.2
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 08:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767370072; x=1767974872; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zmu0/992VBqV/Hra9HUdXNplZnHsHX1mfxceFwgFpeY=;
 b=f4WeTsRH43QZ/8ReQzaSF3+RnLHG5+ok8kLBuqYPOvlQVhWkVr4uM22CGOEfzSdHVK
 suS4mRTinbF5GUrb30Xat+FnzBjWoUWLtJbr/aNTKMTlNhx70u2CN6e4kyAssh+hUwH4
 jRTBjTDG9kbpUgMyZ7DNQ5mzz9YdxQtDuQ3aU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767370072; x=1767974872;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Zmu0/992VBqV/Hra9HUdXNplZnHsHX1mfxceFwgFpeY=;
 b=uDXXte+tLe8J7x+KSvWMGYujKnRBe9zOiKIkoc3vJcQyLeIuB3Luh3rKJq21kC3B4x
 pUKR+MvZnEo2J9JRAKS/2hNNvcMu/ZiwAunw0FUlw9b/UjuBBocS/Em2uBvpslKz94YJ
 UV/vIv7ZuSE1MQDDDtQ6Txj+wGmYH7BpipORk01PEn9GYc1onz64V1N5Bo8tNtbytRUS
 VZNPpwTRxZOeELX3Ma7qRYURSqSMHZzrG3I9qDYso3i2aFxwKF8GBpA9ZyS86coV78oP
 6HSnBr1tHvOaUx7sriYxWvMHxpn9zDV/Q+LVX1c8ULdpCxK3ikSBHE4kcbEmLx5hsKh0
 t/EQ==
X-Gm-Message-State: AOJu0Yyaw08slp1/0NhfdKXvFflv74/OW72HbtYaCn+6enVVwcFCSrMI
 NSL/hAu1ZOXnIRLVQhkWMgDbuFthGuddYT8XgxLX6rwSNd10YHzRpEKkeX+/dHk/4fA=
X-Gm-Gg: AY/fxX62zbvqJb1biNkIAfotU8PuX0iayFd/zoa8AQXT3K3ZiR4noRZ+eQgMYTpMKn6
 +toO4AwZWvjQcMaoewWM3YSzxYeiMrShkTlSUUt7CLwJILm5BtDMCnyWGRh7x41cG6KM/CDbW+W
 fhyBT+ZnJIZQgufwL2Yz3L7zdb8asnVpDloVb2h45GZKz3YrAZvwhNt278LLMC0jD7V3Si/7dMs
 XaUy2v4mB93T9UYqHl0t1//0c7AsNqueeY2aJXZeN7ofz3sDz0vOFTXzwDhEdt3P1jnJhZlD0dF
 TPRaxcYgJggD1E/Vvo6aM42Rv+2pqpCAlFWWBhYiajBuncsmZfhFhc64n2lXi75Lw5Q0QttPP9d
 9a3bBmidlbbXONbU9kzEvjrwE32NgqMlSfYOsnzFB0w1isp45iMCIh8vjKRF59u5M4Tg/zsLnRJ
 5Q9dCcF70JeglnMyCeL5wtRbW7J19nfmLAK8+w8BVpyONF1/zqVB887m+z5vkPVEgIfTYY/hP0/
 Rqe0oz8REmzuTpyj91vjJSa6eUA/G8J0jyJdQ==
X-Google-Smtp-Source: AGHT+IGl+t7XQPt8RkQaeldC/ARIZkEadTIZteOYJAbgrfKTtMRCjxHech4vhhQCNsas+rIB4zG+GQ==
X-Received: by 2002:a05:6820:4704:b0:65d:1ca:6253 with SMTP id
 006d021491bc7-65d0e9e87camr12866761eaf.2.1767370072091; 
 Fri, 02 Jan 2026 08:07:52 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65d0f4b7c42sm23821068eaf.6.2026.01.02.08.07.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 08:07:51 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot mailing list <u-boot@lists.denx.de>, 
 Jerome Forissier <jerome@forissier.org>
Cc: Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Christopher Obbard <christopher.obbard@linaro.org>, 
 Greg Malysa <malysagreg@gmail.com>, Heiko Schocher <hs@nabladev.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 No generic patch CC mail please <noreply@example.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Stefano Babic <sbabic@nabladev.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Yao Zi <me@ziyao.cc>
In-Reply-To: <20260102145504.3222666-1-jerome@forissier.org>
References: <20260102145504.3222666-1-jerome@forissier.org>
Subject: Re: [PATCH] MAINTAINERS: update my email address
Message-Id: <176737007005.111457.10767336868475804668.b4-ty@konsulko.com>
Date: Fri, 02 Jan 2026 10:07:50 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 02 Jan 2026 15:55:00 +0100, Jerome Forissier wrote:

> My linaro.org email isn't valid anymore. Use my personal email instead.
> 
> 

Applied to u-boot/master, thanks!

[1/1] MAINTAINERS: update my email address
      commit: eb18217b63b79dfcec704d420fcc61e77397c88f
-- 
Tom


