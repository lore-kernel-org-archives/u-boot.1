Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD138C6FD1F
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 08:01:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45E5487F2E;
	Tue,  2 Apr 2024 10:00:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wdycT7SX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DBBC87E1C; Tue,  2 Apr 2024 10:00:55 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9461C87E52
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 10:00:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-34356f794a5so706549f8f.1
 for <u-boot@lists.denx.de>; Tue, 02 Apr 2024 01:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712044851; x=1712649651; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+J1pQDwP80T7/P0i+mw11V6a4QW6AL1/BPSC61RPB08=;
 b=wdycT7SXCtS9aVESD2JNoYSCPmrnItXafKKkIh7/Pm9DhhHZM1rV9GyoNl5TZjuaYN
 wm/xxMGp1ihEOOXp6KPS8mDfVIf95Wb8ev77Zc15U0vSyPKCvD5R6B5rYcldUQfTM346
 tMSB5l272SnJOFjNd6u6qX/HJ1py+5HwvWVdRWwWtBqD0bOIDlqTTg9tOOR4Ac1V3Dsx
 36p+1OGDJDjwEIodfoI877fONpBCvHsV8hd9LYtqQs5+ZplnrL3MOh88Z+kwj28tZ/XZ
 B67tANFIWRS+p2HRU+sr5KlRqdHl/38JLX88GgGs+ZKGJk2cRIjagcTRqkqaYVQviLTu
 Illw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712044851; x=1712649651;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+J1pQDwP80T7/P0i+mw11V6a4QW6AL1/BPSC61RPB08=;
 b=MDrRN+iuckHnaVlgKwlEp0yw+FAW5SSxGEHp2Uw6HLExuyNmVHVyTWkVLWTgefGosn
 k7MgSeqQfZ9XWOvUttY0ua2dQSUKAKJX0XbkBbFkC06Dg48fNuwHfeYO6kB2jTIlbFkQ
 Bbs+gwVFTf7Qpf/n8j+85hHumadpvf8W9u4MsMBKZQzAsrgQ1L+c6hqdbf2e16007QXI
 c8q+Lw4RuJMhPgAHaH/ptKLEwAP+jK9pCsout+sTCwTkoiEruZC/Zzj5YtoHln02eRRs
 maZuM+BcSGFhznmKvaYtUkabb+HL92HY/MFBJO3dP8+qfbltAmJsSlshANUwEFwN1bEo
 PQTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwqszQ0x8m4/x9xhAIk/wNtkrtTlOOG6bkJY4hfFK47YlWEUaZaehfH4UrwKw9SbQrf8AlvO0Ljwpwj8gtZ0z2QAJg6g==
X-Gm-Message-State: AOJu0YxtMG3EpSMgBoYGmWrGNPhobc67z48xTKr7OYLLtV66pEO58zGF
 NLWwkZxj7It7A1gn6QiYP2A84mlMuODxzh6TJZlR/vjMZN9tV5m0bFA5XxdrNKo=
X-Google-Smtp-Source: AGHT+IG7vKyNhloLBw0ExydQe713LjSDLa+ZkzUD1XiwegRrKjNT5QPVcypOjyLhx3HEdfo31yNhtg==
X-Received: by 2002:a05:6000:c8c:b0:341:865b:65c9 with SMTP id
 dp12-20020a0560000c8c00b00341865b65c9mr705706wrb.22.1712044850704; 
 Tue, 02 Apr 2024 01:00:50 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 dn13-20020a0560000c0d00b00341b7d5054bsm13539642wrb.72.2024.04.02.01.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 01:00:50 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Tom Rini <trini@konsulko.com>, Vyacheslav Bocharov <adeep@lexina.in>, 
 Christian Hewitt <christianshewitt@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Sumit Garg <sumit.garg@linaro.org>
In-Reply-To: <20240329-u-boot-of-upstream-v2-0-2512ad3eb63d@linaro.org>
References: <20240329-u-boot-of-upstream-v2-0-2512ad3eb63d@linaro.org>
Subject: Re: [PATCH v2 0/5] arm: meson: Switch to using upstream DT for
 GXL, GXM, AXG, G12A, G12B & SM1 SoCs
Message-Id: <171204485011.3673856.7933640729089233658.b4-ty@linaro.org>
Date: Tue, 02 Apr 2024 10:00:50 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Fri, 29 Mar 2024 18:51:47 +0100, Neil Armstrong wrote:
> Enable OF_UPSTREAM to use upstream DT and add amlogic/ prefix to the
> DEFAULT_DEVICE_TREE. And thereby directly build DTB from dts/upstream/src/
> including *-u-boot.dtsi files from arch/$(ARCH)/dts/ directory and
> drop redundant files from arch/arm/dts directory. Only *-u-boot.dtsi files
> kept in arch/arm/dts directory for these boards.
> 
> Keep A1 DTs locally since the architecture is still young.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/5] configs: meson64: remove amlogic prefix in fdtfile when CONFIG_OF_UPSTREAM is selected
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/a219eb8c314811b7cab06e6169ccf765da0b2d60
[2/5] dts: meson: Switch GXL, GXM & AXG to using upstream DT
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/227c586e80c77d8aaefe415c2abab11f58f41854
[3/5] dts: meson: Drop redundant GXL, GXM & AXG devicetree files
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/e747bfc48cc74fd944a1e2a603cf089ec58f20cf
[4/5] dts: meson-g12a: Switch to using upstream DT
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/01f661e46bf8a6837fa1801f09f1da79abda80bb
[5/5] dts: meson: Drop redundant G12A, G12B & SM1 devicetree files
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/7b098c305e51086db906a07c5bdc983c8e9ae3f6

-- 
Neil

