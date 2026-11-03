Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A48606A329
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zww31kb5;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=NSZgrF6H
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7168340807;
	Tue,  3 Nov 2026 13:05:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aDQm1i8fae00; Tue,  3 Nov 2026 13:05:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B3E0440827
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793711138;
	b=Yr6+YNSDpr983D73r0phNS2qH2YaJ+wgEpNL+6QZ6tROv118xSrqzV2G9WoyEYPBK0Sk
	 K6OCqlCtNXqwiavPYDTPJyTn2NdUgxA7J1+IWW4oZnr05T6w0VoQNgL6EhBNtPvD+NlbD
	 7Mfs+MM5amI9UQSFoALgjfytabbvKDz67Zqckw+I/vWV2l1XWx5YncIaC1rqKa+Yia+4I
	 tB2qBeoGWnIdmsXAiMKdegfjn0tH71Sk4IRU9PnIIPIetuEal0FOdJiSlg3SPSK7/hYJK
	 ID/pBU92jQS5JIzO8gA84lciMWRRVi9vPuiVlb5VxUpQcUsfJp6W/eqXoJoeemav4GQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793711138;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=AzY+m1OR1shNFuN1A+a8OP6DInM3sWMD2Fyz1uIQs80=;
	b=doDAJQBVxC23FZ94b0UZfdHEsmV3By5chWFFjaKGXh7RcEgCrRAxyEC0hi9wvh/uOOcv
	 HfxzMQAINFmMlAU0A66N6mF9RigwM8P605KRisLvcyEtnp94H62SPdMD/N+yB1cfZnLXq
	 jBGd3X9zdcNhJPVdEqdGwQuMffFRew3G8twfbml1Kws/eFQAOUHcjOcPBLK8+swvu1kvD
	 R7NBN2p54eGXaUkSH88pTVcnbmMDcBdZD0E0qpU3gmRJU2LJ+aKLppP82dyjpqXeMPEUM
	 rZQk9aBMxSqL02JA2XEB6vmDs2DlnifUE/mbjbg3RG7K8n30gCNVezB3iujkeG4B4JA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793711138;
	bh=AzY+m1OR1shNFuN1A+a8OP6DInM3sWMD2Fyz1uIQs80=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zww31kb52rstmUVLVbb2Q/qn1hvtnekkKUvfk8ET6HCKyTX/nwgmzwWREidp/MWqm
	 aLW1yNVv1yZFiCswCkKJvqwbWZyNcdsLGCm40Z8tYtySYX3dln/jFsbzqV2H5M2wZR
	 q3fW1l/kfRo3vniJ/umOQ/WxFnvI6v5Inz/ZhDDHjKiJY46o5MHBoyVRjDivOFhOPV
	 ZG+NyqGlK5Mc1anH1wROs8iwHzfkUWmer3hQdcCwidx5J6FIAq+IWn2OYl/aZUQTz7
	 PimngUE/UO3BepCGIoj2rpTZyV8ypOWEPf0ATKl+a+HKJurcVkJ6p8ham8j6tux0oK
	 QC7teR2+2fm1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B3E0440827;
	Tue,  3 Nov 2026 13:05:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 45571D3A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:59:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 36CE04005E
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:59:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ERe21gpgu3fo for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 09:59:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5B9AC40080
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793699945;
 b=d8RoKs6c9W3PVH9hKaJtiz20vLr+BFO32IKRRNOI5O+vXcLQlXlno1PGbIEdfE2aYKrB
 H0YQa5ZwR4EAK68pCVntpChGRSNF9hNRmDmPWb3xt9QdcRFplZmrnBmsHZ66PDfJB1qUK
 7nPY4xwmg83E20ofSWkKH5x34VV8maXmKybkdyActTEMcXFjPoV0q8iH4y1rjmPmVaKXr
 Z5gsRqetqwsbhqwp99esBnqTptRHdtsAFa474r25NU3PlmFNLtRmueSDY809vv1MvMwRo
 dDam2M6GyeUF5nD9RE0K6FgcKXXMVRxYafGuCc+EVzqKWDCB7ezqTXVmuQUKTgHxHrA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793699945;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=AzY+m1OR1shNFuN1A+a8OP6DInM3sWMD2Fyz1uIQs80=;
 b=kRDF0fxS+TI0VH3eBFIuHZ/MTHyJIRBQsHjdj5Z0PJEWYA29AuOHrbKEa9tEP3jVHzRG
 tkkfAQ1LHX5otIdaj5DQwet2WLkbc7Ybis+M0XgXreDXL4C7COGiDdFq1/tcZLHBt8APE
 H7zZGJ2Aax+OryT8gvyXk8GJSDJVoS8mCL5Jew9FcC/xrG/kRx++gcXqc+FlLS7sGkab3
 /1b/SwJaVTpTHuVKzqIZfD2xi053PeNoHc0b5QOv/6N66pxrOSHqTDZ/hDvFi4HPLqs2i
 hi/79T/mg5tsUiWV+t6c+LIfa7T0blh77u2fAiciHgivEC6hPnfIO8Bk3qe0tYxtW6w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=NSZgrF6H; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=NSZgrF6H
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5B9AC40080
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:59:04 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a218c463d1so26482855e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 01:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793699943; x=1794304743;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AzY+m1OR1shNFuN1A+a8OP6DInM3sWMD2Fyz1uIQs80=;
 b=NSZgrF6HIUDowGJ5MInmE5k1+UQVbbQkUMCJY99iBUUyjaTbjmWBAEzVilCAYSVYSQ
 vQdlTuCOgDtX30S66LudIEdyYe7jT9vWSTE4WrSJBfIUu0SajAyI5p7Zp9Bafmz2aI4F
 OiFuVsofJhozdD0zZ69NofnEBeuZ8cnyc/36W4qphLdb6wvD6dnKiQjFg0WbvPiG4PKz
 2WNf+AjuyhmfN52y1m1aiQyUV0k1ut3He0g4NThfr8Cm5MRijJAafgpv3atBXTaUktE8
 D4A1dWmHCEzmqkhQEpv+pbvrp3G8NUWX8zGuhXznYUOG6eUIALCgX3M9hihWud+tvVKE
 mNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793699943; x=1794304743;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AzY+m1OR1shNFuN1A+a8OP6DInM3sWMD2Fyz1uIQs80=;
 b=thAOKCLBW9HCl863pxdRob7bjHOpNbhnRyICXhNdSa1FYT94FZP65R1d4qlANVcMN6
 AyJ0i+SkJVqRQPvz2J7CUZx05GT2KY17MbmcjSQC6DjMi3evJK/w0QXm1bXJGgqrCO5z
 0QlmOdo3FghEoxAaGUjeCdU0zxLj+XjHQJbdMBcIigH0wUYxI3a+kTBhaIUHAHeD51Fy
 Nc0Ce1YuN/ivsWlgcPi5PfHcsmgcrVeDDMOGaEaWgYsLqTM1KX52iJ90vMYsS305XGd+
 010OoKlXk92ihYlY5XwUFfVdsB/btKuhkroCjqYok8gyRfx07qaTvAZZX93wPImPEMYs
 9I5A==
X-Forwarded-Encrypted: i=1;
 AKwUvBybRBhQFg0PJUR0FipoMNi8ZJV1dO54hQhcILKMs91nPZ1Oi4b5hu12BhmX7FN/GrkgXxunTC4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8JS/ikABoqBxauIr3o9Cmrnv5W7pWwF9dcZx8q8lx4V+E2Md7g
 611AVoEXEje3usMxmHWGnUo7w9pFg/4/07Ch6E4IKFPFAYO67iilF9n1B8QKe3kfvbQ=
X-Gm-Gg: AYBFou2dn1mkJtAHb1r1UiO8wqVlvRRS6ey/fVBJytMgGnwcUl6zQXlxN4wvE8KJiiZ
 X6wzFwgzdOLiaZGA4KmJ5V3O8rXa2ROEQDt3BZ/BZ6KuULHNMjeAv3vN7nJxQV6oRkTq0O9ALS3
 EA18Y/36ZaOU8YgVZs/GAbDLsREmoIBamZznnpY8nCKYPVETH/j7YPRhYdz+wvKr/AsLlmBDq6W
 imXUw647xoM7SihadjF1vetiUw8YRdKA8hpWA1xE/v5veNLv2uQsiyfokq9WcUkzWXPDy7mSghO
 k6ZFG9pyMr6yzWcFxebjih4fXUzkKuz0sr0LJBXHOVu9c+wE4KWcRVB32loCmRxkYPejcWPZnDo
 /TrNILqpLCvf1G96Fa5MSsz4P42GmAhM6F19apfQlCLqhYMrMa3EpY2n0CN5auMUNUOYz5wL78Y
 Qp8CkJY+RG/yTFT93FghTZ9WfjybLEMABQw+ZSpFbfcdDL6YkRZ/DqtzUC1AQY2bEIuaGimo/iz
 KMCXQEDWDwh96chYBudFQhVAk8APoyxGwySM0e12NgIcWkk8WZunscR4YdvJrhzAj8QqEMaOEF9
 xRNA4VGK06GniW+Nd11wHdUr9zoWHW/fozqFjPBZMFtKDdc=
X-Received: by 2002:a05:600c:8b85:b0:4a1:cd83:b23e with SMTP id
 5b1f17b1804b1-4ac122897a8mr332685245e9.0.1793699942698; 
 Tue, 03 Nov 2026 01:59:02 -0800 (PST)
Received: from localhost ([2001:4090:a244:81d0:2c16:1c4d:8a04:e0bf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a555e59dsm50214735e9.0.2026.11.03.01.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 01:59:01 -0800 (PST)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Tue, 03 Nov 2026 10:56:08 +0100
Subject: [PATCH v10 22/24] arm: mach-k3: am62ax: Enable 32kHz LFOSC during
 LPM resume
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-22-0b24ff0a4d6e@baylibre.com>
References: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-0-0b24ff0a4d6e@baylibre.com>
In-Reply-To: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-0-0b24ff0a4d6e@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, 
 u-boot@lists.u-boot-project.org
Cc: Kevin Hilman <khilman@baylibre.com>, 
 Sebin Francis <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Moteen Shah <m-shah@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Nathan Morrisson <nmorrisson@phytec.com>, 
 Garrett Giordano <ggiordano@phytec.com>, Judith Mendez <jm@ti.com>, 
 Aparna Patra <a-patra@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
 Chintan Vankar <c-vankar@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Prasanth Babu Mantena <p-mantena@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, E Shattow <e@freeshell.de>, 
 Devarsh Thakkar <devarsht@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Julien Panis <jpanis@baylibre.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Stefano Radaelli <stefano.r@variscite.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Bin Liu <b-liu@ti.com>, u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1253; i=msp@baylibre.com;
 h=from:subject:message-id; bh=F3QaFqcNfsX3Iy5gk/RvGtAS8XDDHCMqzl/WcBpicpE=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqyXG4zeJqkwHPrqscfouvYGrtvra2TkAj/pap7cVety4
 uWy+Sfmd5SyMIhxMciKKbJ0Joam/ZffeSx50bLNMHNYmUCGMHBxCsBE3mQz/C+asm0b9/eeAI2L
 DyuDpu/wWM0XXdCof+3YxlV+rtF/pq1mZJhkqlHAryZ+UzHlx8xp9tKhYdNu8M1V+XMz/MOdLQ+
 qJ3EDAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Tue, 03 Nov 2026 13:04:38 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Akashdeep Kaur <a-kaur@ti.com>

Enable the 32kHz low-frequency oscillator (LFOSC) during IO+DDR
low power mode resume for AM62A SoC by calling enable_32k_lfosc()
in the LPM resume path.

The 32kHz clock is required by the RTC to maintain timekeeping and
generate wakeup events during deep sleep. This ensures the clock is
available early in the resume sequence for proper RTC operation.

The function is conditionally enabled via CONFIG_TI_K3_BOARD_LFOSC
for boards with external 32.768kHz crystal oscillators.

Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 arch/arm/mach-k3/am62ax/am62a7_init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
index ef96c35b553b..9a69831378f3 100644
--- a/arch/arm/mach-k3/am62ax/am62a7_init.c
+++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
@@ -242,6 +242,9 @@ void board_init_f(ulong dummy)
 	if (wkup_ctrl_is_lpm_exit()) {
 		u64 meta_data_addr;
 
+		if (IS_ENABLED(CONFIG_TI_K3_BOARD_LFOSC))
+			enable_32k_lfosc();
+
 		ret = wkup_r5f_am62_lpm_meta_data_addr(&meta_data_addr);
 		if (ret)
 			panic("Failed to get LPM meta data address %d\n", ret);

-- 
2.55.0

