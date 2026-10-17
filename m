Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9441CCCA463
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 04:36:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 61C6C81493;
	Sat, 17 Oct 2026 04:36:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qOArU_2th4AR; Sat, 17 Oct 2026 04:36:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B70018148B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792211778;
	b=I3VIlrjKfOounr7ReehzMCsJ5Nn0iHlonBJDer6dLVdvhIenk7J3WBhOm4WO4YxpOUzs
	 kBnvlbX4/3xpBQYah9CDWkV0dvbmPAOvdsYxe/tRVoX+ts+a9gD1tVOfbtfTtT3XdAxI2
	 SKAoZZq8JwXnm+62QNyvq6QoGPG51ug7CUP5cWQX3TBsmG6Z8XQ7Q7DqEIiQHFlfplSpv
	 FmvDDbq2hdgcIaobJq3GCFZm3VZLKq8Bf+QdShtqE3yAYaThDs/0mMKKwy6vaiYZ1twvH
	 ZZ+pq3at6Xs9mfpNiHzJzMQMCTBN9sxF8SOtXMmDWxdIVHnccTr8SvyRD4+b2x9ex4A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792211778;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Jg7IslzZWetB0AnP9FRvawuKiTAEUtfgiX65rqMiEPY=;
	b=KQnYeQaEDJidZhl5Fzx45cJ4QzpVT0JqazCdFTHvHRX1qKEOMJgwS8qK17Ckvb6zEeaK
	 wL8vmCLvvyBykayOxhs1Yc5/HWa/ce+j8MEQ/1bMUK35BitpddLwgh29f2PKpc9yCR9+D
	 dImtneZ2WHFOjA2jfAHcW5Zqe2P0uxvYw2FLif6roNEnqKgATUfF6+jfd6HbV2sIW56Lw
	 JGOF+WWzdbeaIF1CWkK721ysgijL4ofXciDaseDaCzoF+nSLlRTqYYHyV8M5HEvouTn2+
	 Luf2Js40Vl3QJ5Qu1UNaBDvi2eezBWrHfELvJpyxcre/+L2gn9+D4/s4DSOT9i0eyFA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792211778;
	bh=Jg7IslzZWetB0AnP9FRvawuKiTAEUtfgiX65rqMiEPY=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KId4ly4IGSzejLjppbojFgRML0OAItLJoF7uUuPdR4Qns4hyu83hpqAz4FhRrwHmx
	 u283BOmd7fxQStxynYMr1iPDdzi5y0wdz6yOdnb6OCbx5FILYYpGmgUw+hRwXVf8oY
	 OagSri1y0eK3JktvzEHE9EXmwxyxixZaYiIGaXc5g0VSfb/Oo0a8mxnDH1MOujsE4N
	 KYErS8ZpPanc5YDv17zg8bk61oevgn2T/mxNvJS/9xtUWf8LCcyegb+VYP6fkbmQ+o
	 xxzMY60N7dVMEcCQU4TQTTo0tw79z5+GkAEI4KA2jvJjVNmKOOrUJ+5N7c4h742LQq
	 M677bLV2CbZfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B70018148B;
	Sat, 17 Oct 2026 04:36:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5EA2F362
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:35:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5065260AEC
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:35:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cktdxuzE_YiD for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 00:35:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B0C8660A7E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::30"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792197334;
 b=RulXUoO7eh3A6QAMRF+ptIWSqDRi2Rxd8ep6Ud6nIoODlvw0JzrRXzHQw6MU0oMPUpDj
 o7gGgt7uY2+9TYseloUN5cah/EJcFZS1/A4npgyhGPcBLfp7wLzZDxcDhmwyqdRJiLmQq
 b85v+nETNIrHSnoJMr0A2PIKqf6mv3xqhpeCAtAm1sSgurFt7d+vjQj3nGdXBF7EZwWHD
 8rEhXh0AEW/0tawPqxX7sJjUYVchTzOCqZ+N1fc8gYWMoQnQufA+bK3RAPmkaaP68+qkr
 ug2z3SXOEwGqAEbdwZdoc5GUJJhHpUIwn7/qRFlJ60Q+8HtYJ96YHoNWHPhQPPzv1UA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792197334;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=Jg7IslzZWetB0AnP9FRvawuKiTAEUtfgiX65rqMiEPY=;
 b=im4pKCrom00ROnDU+Ed/7zwwzeG2SJSy8QIug/jiPZGidtZBxKXq+wTyHIHU98tBnRAS
 IoF6aZZU65CNOEjqKiByNAmvge3vDL5qY3OYaEcy8m58ik4vfLLT+EIkkYS0qAbTZgqnL
 UDZbMsuR9H8t2Wfq5Kc80QUw4L/OrOUtGW4GfjEVE/J5nGcm2dOV1ielFYFbfwV1ymeJj
 qTdG5RDk34c8YyV1h/ZuQfOwBQ/seGXWQuLCzOJFDgACYsEy3UrJ3srxyfNBrOibeeO7o
 Dx+gHf9mThY5icRil/sOAzttljKpafBFrrQlhT8qR3rh2NbVdlzYxIVnv6D6FGs3XFA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="m/IK5OxZ"; 
 arc=none smtp.remote-ip="2001:4860:4864:20::30"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::30; helo=mail-oa1-x30.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=m/IK5OxZ
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B0C8660A7E
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:35:31 +0000 (UTC)
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-48e2d5a69c4so258077fac.3
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 17:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792197330; x=1792802130;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Jg7IslzZWetB0AnP9FRvawuKiTAEUtfgiX65rqMiEPY=;
 b=m/IK5OxZSHCDdrBq55Y/FMZu5bQS4cCMRlb1zXYW8RgwohoRbxZw64EXmmA3UfkC0W
 kUqXft3zqHyRlV9SBB4we5g4C1w1qMM+XNazXXF/8AsmUS9B7XCCtZeb+SoKlYDmH5YB
 6Ut8zuCTfhfH50C6jLXNcoS3IUnyElcW9pr+ue9sUkkOwvmm+3FekRjwGB4NpQ9TyWy5
 pyTmoqO9vLJqXwrKD+diGVhwbmhZC2/RjCwGHZ5kgk6a0PZRnWsNS9Di+EEKZyC02NUb
 kEasdRP+W7yoo4NHpBDgV71/wqSLQnXjxY2JX18U0y7uyi2/ZBrmpBm3r3UNIrw+L9DU
 T0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792197330; x=1792802130;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Jg7IslzZWetB0AnP9FRvawuKiTAEUtfgiX65rqMiEPY=;
 b=yh45HGYxnN2KY+azUgFPf7+8rIgq8NTd5VZH2N8TSXs+nrYG5iD+PdD0h2Uj7VCVb9
 b/FtjvvWq47w5S+zFjKhQvNACK5LI5pMoclNQKZgkHaGWA46FbHJ26UVT/fd5jI5grsj
 lFAimeQqhWMC830nxCGUWZfdjAVVpBv/HgbsQj1JcJ3limvrmZlnqGKQXhwoOM3zjKca
 yCsowynLmFxsey/RCvBtM7qEaKZ/gBgLU5a1ckDOtW+ij1ZmQk2h3XCmsJVGTZzm2Cpq
 T34L1vYDsoxPza744jJpVOA2376qX3yvWZjBWoX6R4ZiF1aFSQLeUu2XBs0wl+kqPAdV
 BvxA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxMs+wF/mxXRo60teNjMnX5Gc5/ozvvf04Ty4U2+4GH0b2PyLDip3zSUws+FwcovUMw0ZLPosQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLDMz76aH08KL2VJYdXLxnFHs2xv2uk0UqUWWz5KWk+5rrhcOAp
 +TzN7REhWzXJrqZCWpHLzkYIZNGdkIQ+yWY9+CDZ5vQwwqQPdRzVeO6n
X-Gm-Gg: AYBFou0Xh8B8w/xg0pRshEXfjs2FTf6l5ZWpg5DmMQddCOZjvxzZuaCIQDHJH+WlCqN
 1Jw/GEvA+Ahu+7ABANzlSAXyHTUSIqGvGFthjchuBpOcog4ifcR9X52kplODPNVfS+1eRyVR9yM
 9AZX5JxJQEyE+eOQkzzPk+FecLIWs90Mg37VToNXYfHkKCKpxB9uz37y5QulI7+dFkQqWxP9iUQ
 lu2X3yVjKy86VdoAhzIwytGUOkgi2u51DSXMYaXaNpC130MGOJ/xRrIEhGmPz39sqwytljNTuck
 jy5Hd+XQRJfVDrC2OglE29ItrJMatXAw9qxN/RXNw5O/paJ7HyrePh91yW+mBpfU7vLzGrprJlz
 e0rDbyJzAX5AwqgOtKTvE5kR0JgWy44j9UhdWrx9j3M9chtd3zbf8Kk8Vzo4MumxZ2jSGjco1t8
 PIq+ILgWrInpmJsWnr89GplbcFM1+Fclr4PJeUhTzwd5852u8sAbGEaIX8uvVUWU9G5JKwEgoCC
 xEfFYq4OokPdeRV2fjpDtBOB4lzu46L+1k41TEYrVgKj07ajWotLCr0iYGTRhKfx7AXiH3bPbQx
 NbMCug0Nb2Gsa9Rs9Ei/hrl1IED/8aKBtqgkiepZt611R5hoOPIlORH4P8767WcrePeH++IOC6m
 PCD5qWkZUZHs25I3wJOKQoA==
X-Received: by 2002:a05:6871:e0f5:b0:486:c1b6:643a with SMTP id
 586e51a60fabf-4a7579e45admr1307519fac.19.1792197330211; 
 Fri, 16 Oct 2026 17:35:30 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a73b5b4291sm2745091fac.5.2026.10.16.17.35.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 17:35:29 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v9 00/17] crypto: allwinner: enable sun8i-ce FIT crypto
Date: Fri, 16 Oct 2026 18:35:14 -0600
Message-Id: <20261016-submit-ce-series-v2-v9-0-c24e64daafe9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33SzU7DMAwA4FeZciYo/z878R6IQ5o4WxBdoe0q0
 NR3J2mRiEqHlIul+HPs+IYG6BMM6Hi4oR6mNKTukgP7cED+7C4nwCnkGDHCFNGE4eHatGnEHvC
 aiSeGhdO6oZp4ZTzKme89xPS5qM8va5zTXsGPhSo3zmkYu/5rKTuxcu//CvkQHGNwsoEgjYtPp
 9alt0fftahUmHht2H2DZ0MSqoMz3jbwxxCVQfm+IZZ3aAheE9kYtzVkbdx5h8wG94JGpYKQjG0
 NVRnM7BsqG4Z4GnM3MTq5NfSvYe71oss8LI8+GKFtDFvD1IbYN0yZB1hGmeDUWVEb8/r1PXxc8
 16NP/swz9+IYmAZdQIAAA==
X-Change-ID: 20260702-submit-ce-series-v2-4a77b170c68c
To: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 u-boot@lists.u-boot-project.org
Cc: Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Thierry Reding <treding@nvidia.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marek.vasut@mailbox.org>, Rasmus Villemoes <ravi@prevas.dk>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, Francois Berder <fberder@outlook.fr>, 
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Randolph Sapp <rs@ti.com>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Alexey Charkov <alchark@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Anshul Dalal <anshuld@ti.com>, Johan Jonker <jbx6244@gmail.com>, 
 Francesco Valla <francesco@valla.it>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michael Walle <mwalle@kernel.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 E Shattow <e@freeshell.de>, Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Stuebner <heiko@sntech.de>, Vincent Jardin <vjardin@free.fr>, 
 Raymond Mao <raymondmaoca@gmail.com>, Yao Zi <me@ziyao.cc>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Michael Srba <Michael.Srba@seznam.cz>, 
 Pranav Rajendran <pranavkasthuri@gmail.com>, 
 Carlo Caione <ccaione@baylibre.com>, Alexey Charkov <alchark@flipper.net>, 
 Lukasz Majewski <lukma@nabladev.com>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Sat, 17 Oct 2026 04:36:15 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

This series enables Allwinner Crypto Engine backed FIT decryption and FIT
signature/hash validation for secure-boot flows on H6/H616-class boards,
covering both SPL and U-Boot proper.

The purpose is to use CE-backed AES, hash and ECDSA operations on H6/H616
instead of relying only on software crypto paths. Word-aligned ECB and CBC
decryption requests of at least 256 KiB use both the AES and RAES engines
in SPL and U-Boot proper. The AES child uses the same fixed-memory
scheduler for one or two engines. Each engine has two bounded descriptor
banks, so software can refill a retired bank while its peer remains in
flight. One fixed transfer object owns all scheduler state, and the parent
polls and retires each completion snapshot as one operation.

On the H616 test board with the CE at 300 MHz, target-timed and fully
compared 64 MiB AES-256 decrypts reached 561.4 to 566.4 MiB/s for ECB
and CBC with aligned and word-offset buffers. SHA-256 over a 64 MiB
word-offset buffer reached 190.4 MiB/s. P-256 verification took 0.015 to
0.016 seconds.

At a high level this adds:

  - SPL driver-model crypto plumbing for AES and hash providers.
  - Driver-model provider selection for progressive hashing, so FIT
    configuration signatures can be hashed entirely by hardware in SPL.
  - RSA-local PKCS#1 v1.5 DigestInfo handling, keeping RSA metadata out of
    generic checksum descriptors and ECDSA-only SPL builds.
  - FIT decrypt-to-buffer support and SPL FIT cipher support, so SPL can
    decrypt an encrypted U-Boot proper FIT without allocating another full
    payload buffer.
  - A shared sun8i-ce parent driver with one exclusive task-session
    lifecycle, a cacheline-safe DMA mapping API, and one completion
    poll/retire path, plus AES, hash and ECDSA children for H6/H616.
  - Parallel AES/RAES processing for word-aligned ECB and CBC decryption
    requests of at least 256 KiB, using two fixed banks of ten task
    descriptors per engine and requesting completion only from each chain
    tail.
  - An H6/H616 ECDSA child for CE-backed FIT signature validation, plus
    common ECDSA curve-size handling and key-export cleanup for secp224r1,
    prime256v1, secp384r1 and secp521r1.
  - Driver-model AES and FIT hash-provider dispatch with software fallback
    for unsupported operations and hard-error propagation.

The AES child supports software-provided AES-128/192/256 keys in ECB and
CBC modes, including exact in-place operation. Word-aligned payload
middles use direct DMA regardless of cacheline alignment, while fixed
per-bank edge buffers isolate partial cachelines. Byte-unaligned payloads
use a fixed 64 KiB repack buffer. The hash child supports one-shot and
progressive CE MD5/SHA1/SHA256/SHA384/SHA512 operations. Progressive
contexts buffer partial blocks, retain the intermediate hardware state and
build final padding from the total message length. A fixed 128 KiB repack
buffer handles byte-unaligned input, and no allocation scales with payload
size. The ECDSA child exposes the H6/H616 CE ECC verifier through
UCLASS_ECDSA.

The previously separate "crypto: hash: use DM providers from hash command"
prerequisite is now present in U-Boot main.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v8 -> v9:
  - Rebase onto current U-Boot main
  - Preserve the upstream FIT property-length and external-data bounds
    checks in the decrypt-to-buffer and SPL loading paths
  - Validate allocating AES decrypt requests before allocating the output,
    sharing the validation with the caller-supplied-buffer API
  - Reconcile with upstream P-521 and software ECDSA support. Preserve the
    32-bit-cell-padded public-key encoding and both P-521 algorithm names
  - Extend the curve tests to check exported coordinates and verify FIT
    signatures using those keys
  - Drop the ECDSA documentation changes; the existing format
    description remains correct with the preserved encoding
  - Leave existing ECDSA diagnostics and surrounding FIT formatting unchanged
  - Skip HACE for progressive hashing until it has a DMA-safe abort;
    leave its existing one-shot path unchanged
  - Require a non-ignored FIT payload hash for in-place decryption so
    retries cannot decrypt previously consumed ciphertext
  - Unwind partially bound CE children and enable device removal in SPL
  - Add a separate Caliptra fix ahead of progressive hash-provider
    selection: preserve fragmented and empty input streams, finalize empty
    messages and reject data-length overflow
  - Add a separate Tegra fix for AES-256 key sizes, engine failures and
    clock/reset lookup errors before software-key FIT decryption; require
    VDE resources only for BSEV, not BSEA
  - Clarify probe-error handling and operation fallback in the AES and FIT
    hash provider-selection descriptions, including which hash probe
    errors still permit software fallback
  - Link to v8: https://patch.msgid.link/20260814-submit-ce-series-v2-v8-0-fe9212431a94@gmail.com

Changes v7 -> v8:
  - Add an explicit progressive-hash abort operation and release provider
    contexts after update errors  (suggested by Simon Glass)
  - Add the progressive provider-selection and error-cleanup test omitted
    from v7
  - Enable DM_HASH in sandbox so provider-selection and progressive cleanup
    coverage runs in normal sandbox CI
  - Link to v7: https://patch.msgid.link/20260813-submit-ce-series-v2-v7-0-593fcd8479fd@gmail.com

Changes v6 -> v7:
  - Rebase onto current U-Boot main, which includes the separately submitted
    hash-command driver-model provider selection prerequisite
  - Move PKCS#1 v1.5 DigestInfo prefixes into the RSA verifier so generic
    checksum descriptors and ECDSA-only SPL builds carry no RSA metadata
  - Add generic progressive driver-model hash provider selection for FIT
    configuration signatures and hardware-only SPL hashing
  - Add progressive MD5, SHA-1, SHA-256, SHA-384 and SHA-512 operations to
    the CE hash driver, including partial-block buffering and retained
    intermediate state
  - Fold the CE progressive implementation into the initial hash-driver
    patch
  - Validate a clean Buildroot build, targeted sandbox provider tests and
    encrypted, signed SPL and U-Boot proper FIT boot on H616 hardware
  - Link to v6: https://patch.msgid.link/20260728-submit-ce-series-v2-v6-0-80c1f7daffa5@gmail.com

Changes v5 -> v6:
  - Drop stale AES-128 wording and return -EINVAL when the
    software AES provider has no selected key
    (suggested by Simon Glass)
  - Leave signed FIT metadata unchanged and require/verify a payload hash
    before unverified in-place decryption, so repeated loads fail before
    AES processes plaintext  (suggested by Simon Glass)
  - Return -ENOSYS from the allocating host decrypt stub
    (suggested by Simon Glass)
  - Add Reviewed-by tags from Simon Glass for hash-provider
    selection, software AES dispatch, and CE ECDSA/hash support
  - Send hash-command DM provider selection as a standalone prerequisite
    (suggested by Tom Rini)
  - Drop unrelated hash_digest_wd() indentation changes from that
    prerequisite
    (suggested by Tom Rini)
  - Add Reviewed-by from Tom Rini to the SPL DM AES patch
  - Document that no in-tree configuration relies on the old SPL hash
    object key
    (suggested by Tom Rini)
  - Preserve the existing fit_image_decrypt_data() declaration wrapping
  - Link to v5: https://patch.msgid.link/20260719-submit-ce-series-v2-v5-0-3c41f66d4522@gmail.com

Changes v4 -> v5:
  - Rebase on U-Boot main
  - Replace independently claimed channel and engine sessions with one
    exclusive parent session that tracks per-channel in-flight state,
    deadlines, completion and abort cleanup
  - Add one cacheline-safe DMA mapping API for AES, hash and ECDSA, with
    descriptor-address validation and complete-cacheline output ownership
  - Replace the separate one-shot, bounce and dual-CBC AES paths with one
    fixed-memory one/two-lane scheduler using two ten-task banks per lane
  - Use AES and RAES in parallel for word-aligned ECB and CBC decryption
    requests of at least 256 KiB, with fair refill from a shared cursor
  - Direct-map word-aligned cacheline-offset AES buffers using private
    per-bank edge cachelines, and use a fixed 64 KiB repack only for
    byte-unaligned buffers
  - Replace the payload-sized word-unaligned hash bounce with one
    continuation stream using 64 MiB direct chunks or a fixed 128 KiB
    repack buffer
  - Use the normal DM clock and reset lifecycle in SPL and U-Boot proper,
    select the required SPL dependencies and retain the pre-RAM DT nodes
  - Harden ECDSA input validation and use a cacheline-rounded
    private result mapping
  - Validate secure boot, every AES key size, AES-256 alignment and overlap
    cases, bounded hash streaming and every supported ECDSA curve on H616
  - Link to v4: https://patch.msgid.link/20260713-submit-ce-series-v2-v4-0-ff7edc705b8a@gmail.com

Changes v3 -> v4:
  - Enable CE ECDSA in SPL and U-Boot proper on both H6 and H616.
  - Validate FIT cipher metadata before accessing key parameters.
  - Rebase on U-Boot master.
  - Try all registered AES and hash providers, preserving hard provider
    errors and using software fallback only when no provider supports the
    operation.
  - Treat -EINVAL as a hard provider error and reserve fallback for
    explicitly unsupported operations.
  - Require SPL_OF_CONTROL for SPL FIT decryption and fix disabled AES
    stubs.
  - Correct AES-192/256 handling in the software DM provider and add
    provider, decrypt-input and in-place-decrypt sandbox tests.
  - Map SPL FIT destinations after post-processing determines the final
    size and size decompression mappings for the maximum output.
  - Exercise all supported ECDSA curve sizes in the host FIT signing test.
  - Fold per-channel task sessions and engine ownership into the CE parent.
  - Trim redundant CE scheduler state and checks, and derive each NIST
    curve's a = p - 3 parameter instead of storing duplicate constants.
  - Run CBC decrypts of at least 256 KiB across AES and RAES in SPL and
    U-Boot proper with double-buffered ten-descriptor chains and tail-only
    completion.
  - Support exact in-place and aligned-offset dual-engine CBC decrypt.
  - Submit ECDSA and hash work on their dedicated completion channels.
  - Add target-timed 64 MiB AES-256-CBC and SHA-256 hardware results.
  - Link to v3: https://patch.msgid.link/20260709-submit-ce-series-v2-v3-0-5017da8c9bef@gmail.com

Changes v2 -> v3:
  - Rebase on U-Boot master.
  - Add review tags from Svyatoslav Ryhel and Simon Glass.
  - Simplify the AES decrypt helper guard and validation flow.
  - Document the AES provider in-place CBC decrypt contract.
  - Tighten SPL encrypted-FIT buffer handling and error reporting.
  - Clean up the SPL DM hash fallback and Kconfig help text.
  - Link to v2: https://patch.msgid.link/20260702-submit-ce-series-v2-v2-0-ffda5bed58af@gmail.com

To: Svyatoslav Ryhel <clamor95@gmail.com>
To: Ion Agorria <ion@agorria.com>
To: u-boot@lists.u-boot-project.org
To: Aspeed BMC SW team <BMC-SW@aspeedtech.com>
To: Joel Stanley <joel@jms.id.au>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: James Hilliard <james.hilliard1@gmail.com>
Cc: Daniel Golle <daniel@makrotopia.org>
Cc: Aristo Chen <aristo.chen@canonical.com>
Cc: Raymond Mao <raymondmaoca@gmail.com>
Cc: Anton Ivanov <anton@binarly.io>
Cc: Philippe Reynes <philippe.reynes@softathome.com>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Petr Hodina <petr.hodina@protonmail.com>
Cc: Michael Srba <Michael.Srba@seznam.cz>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Pranav Rajendran <pranavkasthuri@gmail.com>
Cc: Carlo Caione <ccaione@baylibre.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Alexey Charkov <alchark@flipper.net>
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Francesco Valla <francesco@valla.it>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Lukasz Majewski <lukma@nabladev.com>
Cc: Marek Vasut <marex@nabladev.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Casey Connolly <casey.connolly@linaro.org>

---
James Hilliard (17):
      cmd: aes: fix DM operation handling
      crypto: aes: allow DM AES in SPL
      crypto: hash: allow DM hash in SPL
      boot: image: try all DM hash providers
      lib: rsa: internalize PKCS#1 DigestInfo prefixes
      crypto: aspeed: preserve Caliptra hash update boundaries
      crypto: hash: support hardware-only progressive hashing
      crypto: aes: fix software key-size handling
      crypto: tegra: preserve AES key sizes and engine failures
      crypto: aes: add software-key provider dispatch
      boot: image: add FIT decrypt-to-buffer helper
      spl: fit: support encrypted payloads
      clk: sunxi: add H6/H616 CE gates and reset
      lib: ecdsa: support additional curve sizes
      crypto: allwinner: add sun8i-ce AES driver
      crypto: allwinner: add sun8i-ce ECDSA verifier
      crypto: allwinner: add sun8i-ce hash driver

 MAINTAINERS                                        |   1 +
 arch/arm/dts/sunxi-u-boot.dtsi                     |  15 +
 boot/Kconfig                                       |   9 +
 boot/image-cipher.c                                |  47 +-
 boot/image-fit.c                                   | 119 ++-
 boot/image-sig.c                                   |   8 -
 cmd/aes.c                                          |   8 +-
 common/hash.c                                      |  21 +-
 common/spl/spl_fit.c                               |  87 ++-
 configs/sandbox_defconfig                          |   1 +
 drivers/clk/sunxi/clk_h6.c                         |   5 +
 drivers/clk/sunxi/clk_h616.c                       |   5 +
 drivers/crypto/Kconfig                             |   2 +
 drivers/crypto/Makefile                            |   1 +
 drivers/crypto/aes/Kconfig                         |   8 +
 drivers/crypto/aes/aes-sw.c                        |  51 +-
 drivers/crypto/aes/aes-uclass.c                    |  73 ++
 drivers/crypto/allwinner/Kconfig                   |   3 +
 drivers/crypto/allwinner/Makefile                  |   3 +
 drivers/crypto/allwinner/sun8i-ce/Kconfig          | 163 +++++
 drivers/crypto/allwinner/sun8i-ce/Makefile         |   6 +
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-aes.c   | 809 +++++++++++++++++++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c  | 799 ++++++++++++++++++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-ecdsa.c | 382 ++++++++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c  | 494 +++++++++++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h       | 128 ++++
 drivers/crypto/aspeed/cptra_sha.c                  |  79 +-
 drivers/crypto/hash/Kconfig                        |  13 +
 drivers/crypto/hash/Makefile                       |   2 +-
 drivers/crypto/hash/hash-uclass.c                  |  44 +-
 drivers/crypto/hash/hash_sw.c                      |  20 +-
 drivers/crypto/tegra/tegra_aes.c                   | 114 ++-
 include/image.h                                    |  41 +-
 include/u-boot/aes.h                               |  10 +
 include/u-boot/ecdsa.h                             |  22 +
 include/u-boot/fdt-libcrypto.h                     |   4 +-
 include/u-boot/hash.h                              |  32 +
 include/u-boot/sha1.h                              |   3 -
 include/u-boot/sha256.h                            |   3 -
 include/u-boot/sha512.h                            |   6 -
 include/uboot_aes.h                                |  90 ++-
 lib/Makefile                                       |   6 +-
 lib/aes/aes-decrypt.c                              | 110 ++-
 lib/ecdsa/Kconfig                                  |   2 +-
 lib/ecdsa/ecdsa-libcrypto.c                        | 132 ++--
 lib/ecdsa/ecdsa-verify.c                           |  26 +-
 lib/fdt-libcrypto.c                                |  60 +-
 lib/hash-checksum.c                                |  30 +-
 lib/mbedtls/Kconfig                                |   2 +-
 lib/mbedtls/sha1.c                                 |   5 -
 lib/mbedtls/sha256.c                               |   6 -
 lib/mbedtls/sha512.c                               |  12 -
 lib/rsa/rsa-verify.c                               |  67 +-
 lib/sha1.c                                         |   5 -
 lib/sha256.c                                       |   6 -
 lib/sha512.c                                       |  12 -
 test/dm/aes.c                                      | 258 +++++++
 test/dm/hash.c                                     | 184 +++++
 test/lib/Makefile                                  |   3 +
 test/lib/test_aes_decrypt.c                        |  89 +++
 test/py/tests/test_fit_cipher.py                   | 118 +++
 test/py/tests/test_fit_ecdsa.py                    |  40 +-
 tools/image-sig-host.c                             |  15 +-
 63 files changed, 4523 insertions(+), 396 deletions(-)
---
base-commit: 65a7532545336e4b73e049a69436e255da7df961
change-id: 20260702-submit-ce-series-v2-4a77b170c68c

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

