Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D500FF8855
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 14:14:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D45858495A;
	Tue,  5 May 2026 16:14:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="snx31Kb+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C4C8848B7; Tue,  5 May 2026 16:14:30 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F06084948
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 16:14:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so51442255e9.0
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 07:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777990467; x=1778595267; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ma6CEzXB7VSxgRovy+esLYtQP3ipkMzznyzUpvH1PP8=;
 b=snx31Kb+eA6eA/lQoiA4M5CLK/OV9HHdZHAhz+gFSwAfd2BDcAcA0AnnUruvN6X1mA
 oaapKv129fIJBdnY4i3agN11rHACucY3qZlQhYPBGW26bFpZz46sLE8TRjYjwOJSbvzW
 h7WwJXcXoW5lKYmQs+XHty3eMy3up430mvyO6cr1gyFVfk81shwzhh+Oe1qlrdG9041c
 ui6JvR6RZrk1hAxvS2d+JvQBykBjhlAzBnOp92we1C528NdQN5Hk/vGupTmXcaIXkT2/
 M/gYvfii+4r83oezZjIStayvuYEU81cJgV5c6NvYNuDkaJ1LodYTCTfCOGVZpNlYJox5
 i58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777990467; x=1778595267;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ma6CEzXB7VSxgRovy+esLYtQP3ipkMzznyzUpvH1PP8=;
 b=mSjxK6r5orzSzXdiNTvIIxOKSqByoicEZrEvWpDcA9wCgBl8D/4rPiLea4Cir30XCC
 tMoGD6O9pBBq8V6JSzOpL3dbIpAXAwnMcmRQLG7a8ZriUZK/HCEct+ewmZQH4FRlhhBL
 BjuO7s1vFklPL8DXZCfVGGdnCAODQco4yZwdeaeaBR+Eg1wJbMl9q8Fc8SjE6KocJVgD
 vvIwPiH5U6nbCTq10y0whaC8C3vfiK+yCnhxVUBj9GrFyaXK66ws6fjdFsrVR4LVAJjK
 KpGh8p+iUOdqri+rv7AJ0ObcNn6RmB4zZSi7FsbWRYZLlHzjDch7rGz6uxrfr3kEJZwA
 3EYQ==
X-Gm-Message-State: AOJu0Yw55CFIzkQ1OCgreVIeFqPtQg9SbPLEJogqpZdEFXGeevS2vFj+
 vVMEk5glCnk9Og4c4c68RJA+ZlNspZV6dpneOqFzs78O7dSCDPENyTElh824bXGqbsY=
X-Gm-Gg: AeBDieusiNqE53K2CrwJ0xe6SIYE4mFt+l30v5GHBSSjpvbSQZqQA5avy8YNhupi4eT
 9MItlbdHEoX2nZjfa8l2hFmHfbm7va9RZkGC8KFJnVZ9vPYAo3EbDRsvSj3sKIj7ypJ+m8zRoZ6
 dD49RnnBS7k+Hfr5G43Bwlttfi+W7h0N2YVKLEnLbCo7tYrjqkucpLGw6Fx0xJQEiqmInLgE1ul
 lm26c96f6j7R9Ox/kI041Pdf08NiBMxrkXMiCQ/Bed9Luxp6B9rU3zTpZMmuEnJb/Bfv14vBkDs
 lK/eqyoq9qogAT4fUh1onpzCWD0qJrwpiWtm0KM7VFCeMKKXsvpneUU5z1oq1wyYYI/1/YLaLtG
 icyeoqxXN58vX+qJQpQDSvXKHG2jREE2wZh/bUmPur8rs8hMduO6WczmHBebgozrUwIvrIcCIG4
 rw3KkOiN87MXXE+TcKy9R9gQ6VYbmONUTy9DJ4aJNYwwyNgNsFska7SbGk8FKgqnqouWv47HN/b
 KGc/Uw=
X-Received: by 2002:a05:600c:a11:b0:487:12c:e7e1 with SMTP id
 5b1f17b1804b1-48d187d95d2mr58241335e9.11.1777990466929; 
 Tue, 05 May 2026 07:14:26 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8eb3427fsm581408135e9.0.2026.05.05.07.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 07:14:26 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 David Wronek <david.wronek@mainlining.org>, 
 Jens Reidel <adrian@mainlining.org>, Luca Weiss <luca.weiss@fairphone.com>, 
 Swathi Tamilselvan <swathi.tamilselvan@oss.qualcomm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>
In-Reply-To: <20260427-ufs_clk-v2-0-36e10a7c0ef6@oss.qualcomm.com>
References: <20260427-ufs_clk-v2-0-36e10a7c0ef6@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/7] Add UFS clock support for Qualcomm SoCs
Message-Id: <177799046572.839461.17483687199897503044.b4-ty@b4>
Date: Tue, 05 May 2026 16:14:25 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
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


On Mon, 27 Apr 2026 14:56:04 +0530, Balaji Selvanathan wrote:
> This series adds UFS clock support for QCS615, SA8775P SoCs and
> enables U-Boot to initialize UFS clocks independently.
> 
> Previously, U-Boot depended on earlier bootloader stages to
> initialize UFS clocks. When these bootloaders failed to do so,
> UFS registers became inaccessible, preventing UFS initialization.
> This series removes that dependency by adding clock infrastructure
> and enabling U-Boot to configure UFS clocks directly.
> 
> [...]

Applied, thanks!

[1/7] clk: stub: Sort compatible strings alphabetically
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/fdc6db475148
[2/7] clk: qcom: clk-stub: Add compatibles for QCS615/SA8775P
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/aa5d2d38194f
[3/7] clk: qcom: sa8775p: Add UFS clock support
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/aef9cdcda59d
[4/7] clk: qcom: qcs615: Add UFS clock support
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/f94e4cfee4aa
[5/7] clk: qcom: sc7280: Add UFS clock support
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/79bc2718d137
[6/7] drivers: ufs: qcom: Initialize and enable clocks before hardware access
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/0f9d0c9620ee
[7/7] ufs: qcom: Remove redundant POST_CHANGE clock setup call
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/c026f721d27f

Best regards,
-- 
// Casey (she/they)


