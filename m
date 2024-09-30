Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C323CE8347
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 14:27:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A49188E1A;
	Mon, 30 Sep 2024 16:27:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="c0fHPPjk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E6C6881C1; Mon, 30 Sep 2024 16:27:21 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48E0F88915
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 16:27:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-37ccdc0d7f6so2283506f8f.0
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 07:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727706439; x=1728311239; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jvw5KqLxLj1F5gegJYYVjZJm0uru/pqT1hBAosgRBe0=;
 b=c0fHPPjkHd9eJBbfG/rcsEg/ASBsDjrqvB8JTlFJzm1TTkTV99JxltptCIPlUVij5t
 OExnJqpwGDutDOyhuKp5b6Ns2cHwjf88q0mrOWylDL46olLsSp6iziziuikxd7ZbEetO
 Ee+1YLa4J3xTdxQynMLMk/Bwhx6kwPDpNdABrAI0BC87DlxIxGD792u9QcPN8sSJa6Se
 v/n4zx+zo9pnZL7FKs0SMNkCiCDQ2j4JLvQrbW/dsVOROCGGkZvc5xmrJ5IbhirrUQ5U
 JWdY6qNHoTS+KFzh/+WBlfZp+BpMVTf2jTGhSqTQtDLHtB1MCHqARhityjxs8Y8K/Rnp
 jEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727706439; x=1728311239;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jvw5KqLxLj1F5gegJYYVjZJm0uru/pqT1hBAosgRBe0=;
 b=fY9DWJsyPX7Vr+TQlen6TgDVLN8grSHa8OsWwkeCujUR6l3ERS8CSqnHVeTI8D7gGV
 JfXzoQ4d+NQnUObbEN6+4QgKPKenuxd/oxbq8amU1e5CttIA7kaF31rzFTp+I1yiieP+
 iuEMRUBD4UUUdTgk6HGYv3/RVXSS7oD8wI3QXVwgzFM0o8Xnnxw/7JLPhcxkXImUFVrd
 JeJ1GDnYUgclqdMGYmJwNxAq4WjIbIxzXPRBY2QnXuVMhnHnn/W8HOETyf1Iy4Cxg3ew
 lC5BCZ2hdT+RKSSgPIf6719MffRhlDrZBilz1Je29fexvHWUluqsos2s6/tbHoOAERh+
 W2sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUU2qBpInJUN6EjMACDuIulcdsXZQtuX/nDD87MMRv3qc2KALP1EX3h6+Gngjh5tN0Coq/3SlU=@lists.denx.de
X-Gm-Message-State: AOJu0YwYF/uhWXt1d/fEAmQcxAQ6dD10zP4TQ0vF5BCAIJWpOEdQlJey
 UezRDuiwHUwkD47HrUpnTCAxSQtc8Gydl5yEN8l+TEYBEiJbbLLKgmp2hp2x0Oo=
X-Google-Smtp-Source: AGHT+IHhiYsNkXlX5g4IUoMh0HORNQHbGXHCfjgU5EU1KIVllNY9lq9Dv9QYHatl7s+K306KvyOjJQ==
X-Received: by 2002:a5d:410a:0:b0:37c:cfeb:e612 with SMTP id
 ffacd0b85a97d-37cd5a6923bmr8365122f8f.1.1727706438717; 
 Mon, 30 Sep 2024 07:27:18 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd564d2e8sm9303200f8f.18.2024.09.30.07.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 07:27:18 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, da@libre.computer, 
 ilias.apalodimas@linaro.org
In-Reply-To: <20240920-u-boot-topic-libre-computer-solitude-alta-v1-0-8915b108840b@linaro.org>
References: <20240920-u-boot-topic-libre-computer-solitude-alta-v1-0-8915b108840b@linaro.org>
Subject: Re: [PATCH 0/2] board: libre-computer: Add support for Libre
 Computer aml-a311d-cc & aml-s905d3-cc boards
Message-Id: <172770643803.753773.10093460884732350284.b4-ty@linaro.org>
Date: Mon, 30 Sep 2024 16:27:18 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1
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

On Fri, 20 Sep 2024 15:33:32 +0200, Neil Armstrong wrote:
> Add support for the Libre Computer aml-a311d-cc "Alta" & aml-s905d3-cc
> "Solitude" boards:
> https://libre.computer/products/aml-a311d-cc/
> https://libre.computer/products/aml-s905d3-cc/
> 
> The Alta & Solitude boards have a Credit Card form factor, similar to the
> the previous "Le Potato" card, but with the Amlogic A311D or S903D3 SoCS,
> MIPI DSI and CSI connectors. PoE header and a single USB2 Type-C
> connector replacing the microUSB one for power and USB 2.0.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/2] ARM: meson: add support for Libre Computer aml-a311d-cc
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/0ace48fc0990381450a4dfc75275eeade202a8ed
[2/2] ARM: meson: add support for Libre Computer aml-s905d3-cc
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/aae228b1a590e840ae15f84c97b5b66da7cd4a2d

-- 
Neil

