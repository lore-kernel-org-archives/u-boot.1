Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ECF606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 20:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=juKN4o6N;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=fM79zm+F
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3410A605D7;
	Wed, 18 Nov 2026 20:30:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZD--CqcDsK-a; Wed, 18 Nov 2026 20:30:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7F5E06063A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795033810;
	b=TbOdPrComY5sHlMBMhWNeLnwa/3x0dGHTg2oJJtsQXJYcp1O+dO6jsh6kPpgwgAdchBM
	 c2JJG67tK4Z/cHtrPMT58gyZ/1GK1iXj178JtFUjHBwy2UD9BaoDGn1RNtACAwX+U88Fy
	 Rj6jh95Capg4Kkuo152lwatw20tmjxN384K3F7/Fcr5C/8KU0RyJtg4XZQrtPTOZiPuyL
	 OosNmYM0k7RxJ7LlJv7wWvy13+UqnynWxCPU4qTJSK1I+DifwztIsGSO5gBcALJ+31MNo
	 24RFBPLwZ6fDtP/g7xmW5LNbfHMYq3G7iJ8MCwmJRseTKCUzhbKMlsp3/4xhgYHnk5Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795033810;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XeJIH15EKH3sg7GL3hmyd3wrLEeiKwGtqSlpaau7A1c=;
	b=IOOVbwVmsd+MMaw4hJswfadSNZWTsbUwLpY9oZg/HBHZq8e+p9QC1L0RtwY570gmiizo
	 lGnsnb64lj5vQb2lB1edM6nkiEZeDga3lUQS3EGjhGO3KXi4cj9vbOQ7GPjuABvYV8Spl
	 rM34hHO0aZ2mWh3VFe1RR6pirPFdMPtc3KelpUkoaT+xF6s5ZGJsxZEJP6QSTIJrqv9v+
	 ZRo/UCHJ7EItqhDHjVeP77ZJ2xZaWDRXGxaWI2KiVoe0I70GEdeCouvZY02vtW+KSHmW6
	 vKrj58mJXNIRE4cxPytabvQ/WKB7ZAzR5KSgIqIu4yhcLWgQAMh9fkZImInswOsKNrw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795033810;
	bh=XeJIH15EKH3sg7GL3hmyd3wrLEeiKwGtqSlpaau7A1c=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=juKN4o6NIz9qwBAtOIP36EmihWzXmv4NzZzJo8OMy4XaejP+ZA8nCfOFnx6ztqSNy
	 Ds4OCfLB4jwqsdhQIgE02eKls/nqfq9yc+1SvzmPuSHCj3I7S7/Z43yDCa++ILweRq
	 f5xNXMhrIo9iWAK4Qwg9BrsXSyPIm6hA0wIpKwzCoWFQ2iQIl5CQH2oJa/Ez0Q7LVD
	 Wvk6t++E+3SUd4zoLaDRfgU2IQ32fjaHzeQqe8+uU7dTZKdp1SqUHWycXj+WEr4CF+
	 Gslx/q1P0cl4SVGI7USFHmpwbSFDzFX/BLoAUt7fbi6mL8xsLpQxYTDgGuFNgVG3Mj
	 kH6NtjifliR7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F5E06063A;
	Wed, 18 Nov 2026 20:30:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 73E6F798
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 20:30:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 65AB88111E
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 20:30:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nu3hZJvbHeNF for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 20:30:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7917D80E66
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=fM79zm+F
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7917D80E66
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 20:30:06 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4bb64ef5a14so15345265e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 12:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795033805; x=1795638605;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XeJIH15EKH3sg7GL3hmyd3wrLEeiKwGtqSlpaau7A1c=;
 b=fM79zm+Fw3vTT5Uyz9db56QKYijvfWvdebPGBIyDRQLBukvrDGRTS6I85gp4YRXHot
 7VMdhPzHMt0WidZBy7KwRoXN87mvJWgpuoSefBKSbGCj/BJuYhVadE32YRNekaKT5cLd
 4IHSfmi7CQCqhgFghWGwEfqPZ+d0pVjBWtGkqLN0iR+lo/HZIlYHhFmeBjYRZKoaGEn5
 3FFeFCIlOpiThXM4QHq6Ldy6l2UPvIkGg+5oqdULqNfGZBlNKJj4M+gO8ZOCF4Tok5fe
 kWVRQfmhYy+LM2MYFNCLk8nYAs2riBeiXqXJgfHWfVTW0H1S9/EPHCQ7i4/WlmZckma6
 4VEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795033805; x=1795638605;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XeJIH15EKH3sg7GL3hmyd3wrLEeiKwGtqSlpaau7A1c=;
 b=LByj4qn7uFFLbp0vvuPv0wnQCQuAvM2PsQvuLNT2XW6m83azFXEF4nVNCn8lS3nur3
 8h6qkrRavTQBOPAJNAFUQWnGvJGzXMxLLRo68tZ3d4iMNrSTqew8UzX687TN/BbAXjpm
 afIUq7V0lPAMfyOB55iSsRRHKdSqK7EmiFqLTD/WEpqNeAnhcQ5Q3rPBOObca/V46ze2
 qqmMYArFSleFiWiXyM0h08G4pK+RODBTo62y5vaJmVy1HI9Zcgpc/yWb7BEKXJZLmVRS
 OUzqrVBeFRxDW0IQjucr0LdypbvDToiq+MwPCRiRxyEco+XYVFdWVT3IT7Eob3ZveCd9
 S8vw==
X-Forwarded-Encrypted: i=1;
 AL+hErEpYU55opgqeI3+6aQyiR0M/7HbCmnaX2FxdVQlh5b2PRYPdvgr0oOw9T6EGjhGSi7GEJ/xVxg=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9pDDDxmiS7saqI6AjvwdaglGr8olBXqaZhqZcUiYZKRdCsaPiQ
 bNCaBsf5zDMZsZ64d/d+vKtW30V4sx1+vQuMSrexRW/OmewIWdPJfz19BSr4WMPt+pM=
X-Gm-Gg: AYBFou0nFSR+sziFF1NZyexvfM82YpYxiAD6SBl3RENVwIp/OHJ7vZ1n0HvQTZPL4Vz
 kCjClUSkIVdQP91ScRgFgxwDMquJPJwoTPp3m2jU2n30Z/JelSkZvso2VLW/L0zqaAu8LQGD8D9
 zQGrbpQzhbT5h1xaRp9XOBBz/Rnz6LZOUHobsbIj5y/1+le8mYOWZ2cfAcQr3fDc3OW++VM2w/M
 JIYqXHTdkMg9mxROdHl+ev390BSe/NvRkfF0NteXJnzUqelhSuRrlLXOkj69DayFGWm/VPEf7ZJ
 huQUwUgYQxdpCUoAWTrxvykXIU/4kKSlkuclC0D6uP8ROFX3J4uNsG2CXELuIZwlg7l5EFjSIRY
 keR2S+GLqMlQ8EUCAWfPvl5Duu6fuPfltwEvTeKCVBBpVAuCC/XMevbof/EEcnvLA2RCPCP1ZWz
 ltbdVd3AL/6gebA3v8JqkIMZT5LfAUU9A9y7dW72j6omdFDOkHcgHxQ/02MQeODYgCsukIT/lRj
 m6CmcNsxkyGnE8OGlwl2DI3mv40rQ95if0K1YbzWmCsaIytlLl9JCIMO3CbKGETzlwp5s5spW22
 kK5a0TmEoa9f783kZ0DAtA5DsH8QztZA4F1H/45XBpKgctcxlliWPW2P9F9+AH3gSaUB7vLNSkx
 1c3wJIMTvcdd0paYMSg==
X-Received: by 2002:a05:600c:1c11:b0:49c:d019:70c5 with SMTP id
 5b1f17b1804b1-4bb7d57acccmr85071385e9.0.1795033804552; 
 Wed, 18 Nov 2026 12:30:04 -0800 (PST)
Received: from [127.0.0.1] (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8326c332sm13066705e9.15.2026.11.18.12.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 12:30:03 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH 0/7] Enable I2C on the MediaTek Genio 520 and 720 EVKs
Date: Wed, 18 Nov 2026 21:29:46 +0100
Message-Id: <20261118-ccaione-upstream-mtk-g720-i2c-v1-0-916dd6cc8d1a@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMQQrCQAxA0auUrA00WUyrVxEXMzGtUVrLZCpC6
 d0ddfng8zdwzaYOp2aDrC9ze84VdGhAbnEeFe1aDdxyIKIeRWJNFNfFS9Y44VQeOHbcorEg8bE
 PMXRp0AT1sWQd7P37ny9/+5ruKuU7hX3/ALkzAmiBAAAA
X-Change-ID: 20261118-ccaione-upstream-mtk-g720-i2c-12986a67bfeb
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, Chris Chen <chris-qj.chen@mediatek.com>, 
 Simon Glass <sjg@chromium.org>
Cc: Heiko Schocher <hs@nabladev.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.16.0
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Genio 520 and 720 EVKs share the same I2C wiring: an MT6375 on
I2C4 and an RT1715 on I2C5. Add support for the MT8188 I2C controller
and enable both buses. The series also fixes clock gating, pin pull-ups
and DMA handling needed for reliable transfers.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
Carlo Caione (7):
      i2c: mediatek: align DMA buffers and handle 36-bit addresses
      i2c: mediatek: support the MT8188 controller
      i2c: mediatek: skip DMA for address-only probes
      clk: mediatek: mt8189: index I2C gates by wrapper-local ID
      pinctrl: mediatek: mt8189: fix the I2C3-6 pull resistor offset
      arm: dts: mt8189: describe the I2C controllers and wrapper clocks
      arm: mediatek: enable I2C4 and I2C5 on the Genio 520 and 720 EVKs

 arch/arm/dts/mt8189.dtsi                  | 141 +++++++++++++
 arch/arm/dts/mt8371-genio-common.dtsi     |  32 +++
 configs/mt8189.config                     |   3 +
 drivers/clk/mediatek/clk-mt8189.c         |  20 +-
 drivers/i2c/mtk_i2c.c                     | 331 ++++++++++++++++++++++++++++--
 drivers/pinctrl/mediatek/pinctrl-mt8189.c |  16 +-
 6 files changed, 506 insertions(+), 37 deletions(-)
---
base-commit: fdc9a05c74e01db407e538ebf7024eb9e332e0b8
change-id: 20261118-ccaione-upstream-mtk-g720-i2c-12986a67bfeb

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

