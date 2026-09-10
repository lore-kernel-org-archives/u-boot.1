Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 649A3C79FBB
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 22:08:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CA16B40B57;
	Thu, 10 Sep 2026 22:08:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PZQmBBxVxX-L; Thu, 10 Sep 2026 22:08:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1350C40B79
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789078105;
	b=L4IovJgrxW6m29glSpJFri6crrshvrotzs0wDd7g+GZL7ZU39FYYxEr+93ehaWcHjZup
	 uYgWvDXArf5sw9cm2/6IgM9HXbpDkC2qf1rUG3er2kINoMrZF8UaQ/4pNSCSBq8A06tjc
	 VShMFm5MIHQuBwF2lg959LNNAECi9C6mw6FqEtAqS+53/6sUhyHpaSWMUVgnxdM2SeUfN
	 rwsF9b5g35IJTRP4bqcttqwrU040uvlNnkTevqdnu3RYtSG1r8I2Wfxkbinnn+Ha95Z7i
	 KUDIDrwtYoTSe3G0/UmCu/ErvJnJUUtECcbTnR3BV7MatjvW8dYvR0ARMbhbzq4T5GQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789078105;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=k2ozo6Qok3YJTHDeLsuxAaVtUB0ELMpwcx6ksXnIMkU=;
	b=HTcKCAsl3xMSdQhkW/TBle9+MWjaAOskJcxK9kQfF58B1dExo4ns3MIDuBSv/K9Ua7Dt
	 4r9hFTQrJe4zyy33FT31dynXF81MOl+pRXm/0JKp9lQ6PB2B74F9QhCX9Us8kOpRc3U0V
	 dRva976USVyGIW+YgfuiIwMelpYulJPvhUj2158d7+k8Yfw7Q82MI6uckNPdI/DbaO9Cz
	 VECuprBKNCNp37aTlBctiuCD7GGeMRT6YvfMKiLLX4J3pzEYmKdRUA+YA6bAPOpSXRokg
	 O1DLwKgXUhbiSHwV8S21LAwlTLqAynEPCPTVdwuFFTxsxFhPNLodp5YL0MxL8ecmr9w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789078105;
	bh=k2ozo6Qok3YJTHDeLsuxAaVtUB0ELMpwcx6ksXnIMkU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=q96mzGDX3BLycxMd49jBOuscJsE+B6ZLWo7I3Z6t/zUtJJfPQJe9dmIYgjwgxWCfm
	 +qJQ2iw9u2v64Pc900r3lY5Rx4N1bSU8pCmVNt50MLXWRIAJ7HOYtXUbjBlcnN6PNk
	 QlRNnsxSAchikxfs+QstE3sQdsBx0S7OX4LMvPCTVC4ypcmwcuYKB2ty3IsF2IefLo
	 tmdTWx/4xFxj2h09ctG/nIzVjZexpFIAoiPpePxTMgBUMIBAu0QRHxdfK3mKdX6MX3
	 cMw9CgzaSVC3BRyayBaSzmvdHN/lloSh6puQ851bECpsnyThcrD5CiIWnQAx5JH/+/
	 NDi1YqpXdBQiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1350C40B79;
	Thu, 10 Sep 2026 22:08:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F8F749D
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 22:08:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4CBD960B83
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 22:08:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fa9BecOKy6iN for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 22:08:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3EEA160807
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789078102;
 b=Gj1+BeG1YGIBdPRWk+cCzO9hscFDN2uNRoUpjkHvNMaR9zDJj/ZD3dihqllk/AWvDbD4
 HIlu9tnSF6DSpqf+zYMQrEcmn0yVDyfpaCkMLK0v2mQU5SKo7QzCdThOFyP2Ak2XdckM7
 Ej/DQ6FFTGkvkGiK0mGwF/jtx5fjvxwZpYuGFplF0QFZvcHtHgvUEBW9wWD6MQqOzU7tA
 9XauRBAKUS/iPe1NjdTq22oMwoj7rgjN6nK+368OVzcKPFCjYSCgE59dFzk+qij18F0bY
 eZQx99JUOTjqM7O5TkP+XN9QLU/pqd9P/XEOZ3PKn1neNSHzbMfRbi8pLKbApayvyUg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789078102;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=k2ozo6Qok3YJTHDeLsuxAaVtUB0ELMpwcx6ksXnIMkU=;
 b=HfMl1SXxcNKMoiNNnpw4BtApoB+a4tZvNEqP8+UKe45KK0TlK3Z1qJOJs9O1zDULrz1Q
 5+ACp1Y2XMZw6BCTCSKtkyA0YQITqIowAyGiCq8dcY6kwudcGwbhURu6ZRVKUMgtUCzhD
 p/KH5xE+ixeyALmD6EtU4X58WCKOF2auZlkw3OeaAHVYGHwn7RaqZ7ONABYdrSBTT4L76
 zXogVMADlWHu95s8PRy0idNlVj3WxSzvHePU9VHQyB1K6uXfRoaAeopsH0V+rINhFabBY
 +Dvb93C9lLHAhHf7oxxuxceqNcc00xjhyFObYhrqVi0YVGF3YaHmuWjMtxZHjUBY3QQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="BI79Sph/"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=BI79Sph/
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3EEA160807
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 22:08:21 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-49ccfae359fso2415125e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 15:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789078100; x=1789682900;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=k2ozo6Qok3YJTHDeLsuxAaVtUB0ELMpwcx6ksXnIMkU=;
 b=BI79Sph/toze/C4VUZ6jld64KP35wTzGYPQMyTpQJatsTD2EyQ6kMufXYnCg5/UKgB
 eyMZp9+d6Z19JcR9hoNjlWlMk42hRxIvmlovldrOR7nQz8WDk0aeGjbN4cZUCWGrOHgo
 6BrmT7Bo2RFpfhumd4Br4bZBOR+hLCswgdzOfJTedB1buo7HEzNfEkxpLABTGH6wjIV/
 /Kw+S+5+0O446EJYshCOxfd2RUSlvEIwufjjuHrE3UepChXanOxlHZrzRBVPdDIJf5ha
 ZsOPrTzRbyXytCfGo6GKo99HV59S4Du2qeDkqOpXuUjq/oK2/I7mOCXKlsaguUK0oULU
 yqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789078100; x=1789682900;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k2ozo6Qok3YJTHDeLsuxAaVtUB0ELMpwcx6ksXnIMkU=;
 b=QIayGN8Y9Z5fTk73X63EuIT14iFGIYqEOGjH7IP1eJuF4SH/6tLd5F6tlYAFxEkLZm
 6wSPHcPxZ3gafTuoH9D+1BAbio2FhtdjeD2H2dfVrzmE5sfGiAa4slGpmnlxMXGN+s46
 kSJcU7Ck/Gx/Q/peoXuAxTBhErknjPsqQhUJNTdbbc8Ka+FWk37Sj1rt8FTf+RplSRJf
 7e7O20ki6UTpP+vDC4MKliesISG4qmiMRIkVtvyX4eqCuQONuLnvmUSXWHQOpFJOE1Lz
 Hxq8u8yabpm7kUS+R9ejXG7UIr47KajVNEjATrUA+BQRW9dapXaHazOoCx0RvxGy2TKy
 /Nmg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwRLYD5x+TyNlPH9QakHVeBUp2JhIyqdoRGO9VhIvDTZz6jltdT4yLCzg5sCp3AqG69jAw3Hb8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nfwg1pmYEor0UtqpJtapZuwiXi2A2fCZVOJ+edKzA61OEFIY1L
 ASgu4wmcRyP65l+CRFn4QHjRsGJpA6rXMUVyHREa1zu7QxXCTQbn3Uxq
X-Gm-Gg: AYBFou2B/Tj67psp84mKhKweyeHsjnZId55eSaEVqgvUR/J0NJBDDdYPsD6/ZAI241e
 CYDxCutIPtazS74sLS+rETRDl0Y3E+ijqWP4LTHPJH2W3Gr7ggkmcxSlOlo7qtEym0c8ZnjI41E
 7FsroDJVzZ3K+NXrRB6B6bi/So0NVYqeFnlP41z0/eLZYMlV6XJQnV4VKJCNCnd2O7Ylz+RHyz7
 tjTgxitU7cViXM2y7Ktw/T6U4lBNIKF6UOXabUfiSDdHHlhAPSKp96fX8LorF6wS2aehAbRSBVD
 upTIllqSqAlF4PTGl2TZ0bnFd3YrOflU9Ekn7AUL3eKLwCf4lL0zfmyPgcFg1JakwBXs6ZlAy1E
 dxlVEX+lrPj33pvEtUoyGm3kHHtIrMgc6aaEI8VKzLTSHrAQyzhzru57rOYrk9n0jsfIIBeuY4v
 ukIugJtCtDOtVPr3AQi9MIRveZOWANgWFQjk50KnXQ6WTOy7RqSilPp+I2BG3l2kyYSaONqNh3I
 Nr8
X-Received: by 2002:a05:600c:4fc8:b0:49c:cedc:3c36 with SMTP id
 5b1f17b1804b1-49e619bd0femr12025075e9.16.1789078099723; 
 Thu, 10 Sep 2026 15:08:19 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62231360sm4795595e9.4.2026.09.10.15.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 15:08:19 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>,
 Ye Li <ye.li@nxp.com>, Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH v2 0/4] dm: gpio: read GPIOs in of_to_plat(),
 request them in probe()
Date: Fri, 11 Sep 2026 00:08:14 +0200
Message-ID: <20260910220818.3093364-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

A driver's of_to_plat() method must only read the devicetree, but the
only way to pick a GPIO out of it, gpio_request_by_name(), also probes
the controller and claims the pin. Several drivers therefore claim
GPIOs while their platform data is being read, before their own pinctrl
state is applied. On SoCs where the direction lives in the pad register
the pinctrl then undoes the direction the early claim set; on Vybrid
this leaves a fixed regulator configured as always-on powering nothing,
which is where this started (the ehci-vf VBUS supply).

Patch 1 splits gpio_request_by_name() in two: gpio_parse_by_name()
reads the phandle into a struct gpio_dt_spec that can live in the
platform data, gpio_request_parsed() claims it later from probe().
Patch 2 converts the fixed and gpio regulators, the two drivers that
share regulator_common, patch 3 writes the rule into the driver model
design document, and patch 4 checks the two phases in sandbox for both
regulators.

The remaining drivers that claim GPIOs from of_to_plat() (about fifty,
mostly panels and backlights) are left for their owners once the shape
is settled; I will convert fec_mxc and fsl_esdhc_imx, which I can test
on a Colibri VF50, in a follow-up.

Tested with 'ut dm' on sandbox against the same tree without the series
(the three new tests pass, the pre-existing failures are unchanged),
built for colibri_vf, evb-rk3399 and the sandbox variants, and booted
on a Colibri VF61 from NAND. There the VBUS regulator's pad register
(0x4004814c) reads 0x60 until the regulator probes and 0x22ef after,
the pin shows up as 'regulator-usbh-vbus.gpio' in 'gpio status', and
Linux boots from the same U-Boot.

Changes in v2:
- keep the list index in the spec so the request label matches
  gpio_request_by_name(); rename gpio_dt_desc to gpio_dt_spec; document
  the list_name lifetime and the -ENOENT contract, and use it instead of
  present-flag guards in the regulators (Simon Glass)
- drop the GPIO request from the fixed-clock regulator (Simon Glass)
- doc: reword the helper sentence and remove the paragraph that allowed
  probing providers from of_to_plat() (Simon Glass)
- test: move to the pinmux-gpios bank (a10 is a hog pin), name the node
  fixed-gpio-reg, add a gpio regulator test, check the simulated pad
  direction as well as the name table (Simon Glass)


Mehmet Fide (4):
  gpio: add a way to parse a GPIO now and request it later
  regulator: claim the enable GPIO at probe time, not in of_to_plat()
  doc: driver-model: state that of_to_plat() must not probe or claim
  test: dm: check the regulators claim their GPIOs at probe time

 arch/sandbox/dts/test.dts                  | 18 +++++++
 configs/sandbox64_defconfig                |  1 +
 configs/sandbox_defconfig                  |  1 +
 configs/sandbox_flattree_defconfig         |  1 +
 configs/sandbox_noinst_defconfig           |  1 +
 configs/sandbox_spl_defconfig              |  1 +
 configs/sandbox_vpl_defconfig              |  1 +
 doc/develop/driver-model/design.rst        | 16 ++++--
 drivers/gpio/gpio-uclass.c                 | 34 ++++++++++++
 drivers/power/regulator/fixed.c            |  6 +++
 drivers/power/regulator/gpio-regulator.c   | 21 ++++++--
 drivers/power/regulator/regulator_common.c | 26 ++++++++--
 drivers/power/regulator/regulator_common.h |  3 ++
 include/asm-generic/gpio.h                 | 60 ++++++++++++++++++++++
 test/dm/gpio.c                             | 39 ++++++++++++++
 test/dm/regulator.c                        | 58 +++++++++++++++++++++
 16 files changed, 274 insertions(+), 13 deletions(-)


base-commit: d4152edb50356338af994d1c0483f65b717b4c15
-- 
2.55.0

