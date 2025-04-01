Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11028C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 20:36:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B80481ECD;
	Tue,  1 Apr 2025 22:36:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="C/ppkBr6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE8AA81ECD; Tue,  1 Apr 2025 22:36:26 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9889181703
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 22:36:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2b2b6019a74so3067025fac.0
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 13:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743539783; x=1744144583; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aJ5DHN5x9HZzkx5AMfzzyt3PdQBdJR64nBWiP3f/nFk=;
 b=C/ppkBr6uaAyz8uD2dkcBNBb6JePzVgu3PKOkQgmhydPCFJ7AbwSARS4yA+sneCR37
 2VRTrMlWC8aYkBPsFWnZWiJTQ2SSRB04DLpidpL+Hwi2HW4cSsgg2hUYtRbIDf/lAzfD
 tmT0d2FARasGfvVa9zut+hBbJjajxP5W/PJ+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743539783; x=1744144583;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aJ5DHN5x9HZzkx5AMfzzyt3PdQBdJR64nBWiP3f/nFk=;
 b=ndlqptdmxGRzxpVECElbgtR/WYY+IOnHc2/b7sc4i9Nm5fKZsFpAtDvuQ/IoC3rOOv
 8/F24kNmMz7kE7s77ztVbM4MAis6esLTV74bbYtWmHKQFRG/yUORlfzNkHnyhrse6k2Q
 qzvmhSAJfPpOo5Q9vCM0fE2tTlIOXnkg/c31ayH6vk6q4KjI+QYrgiqOCjw0XaCblxBE
 qMdCF85nhZOh30bEhlhRv40YP3G4NVBH5J+bNTGge7snIyAAyLn3aro965W945RSjBb6
 xu8XNSV5GfdJlDKFQtzPzjgArjlqElojdiNVAeI/BqDpYiKOmKfu+iXKwvocX7UBlsyD
 GtCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVH44l5ojGzDGepQEcxglD6Jx3K9SUO9f24YbgX6Ud0fgD3ZcZu44EJoS4EDPG7IyEnlhyCivc=@lists.denx.de
X-Gm-Message-State: AOJu0YztE9UVDHSuO1c6EajCsEW8rfmcpui8eox0TMPNa4g3fi+DloTj
 ftjhEo0Xmza/h7w7LQzNueyxGrv8npMnyzpa5ktavSwv9iDlYFqRubf7ievX4JU=
X-Gm-Gg: ASbGncvayBCVSX1QElNzQzJJkP8efpgBKFFIqPczoDRZIqOqZqgvz1EqxrRtClJSdbe
 OJTNPs5uL1ZZ5vQsrcb4FESgUpZjOb/ffFOfd46YU+2OzdgKR37QzoVe56fsFqgvt8KNgj6xzqM
 QGAqqlTFUweb+a6wViCQcxsvaGfY82PMrQrWckxSWZ/6H+S4AJDQpTKdjt3GfJlMKNR9OLalWel
 Wuos4qlC5cuSU6LUu6elOLdeyFjoz9LWO4W4fRH1AiMcIv4VhxrpUkFIpd/igxmobWEH0TKg2ZJ
 c+fzeYnOf2eIx/xnf9Pvpy2ICkiptKRPSWGFuPfCAzl6vMIixgcHRU+MbRJT7lZvoK9fz19C9nD
 Sib7r
X-Google-Smtp-Source: AGHT+IGmj0alB/PjuvQP3vayZhAfTnRfBsvpN7WtnhrvC9ZeXOitDbb5N7lWB8/zttAaFOymCUEKUg==
X-Received: by 2002:a05:6871:3b26:b0:2cc:4613:76f0 with SMTP id
 586e51a60fabf-2cc46137cd2mr1185404fac.17.1743539783240; 
 Tue, 01 Apr 2025 13:36:23 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c58266eb4sm1956027a34.51.2025.04.01.13.36.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 13:36:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Stephen Boyd <sboyd@kernel.org>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20250314185941.27834-1-ansuelsmth@gmail.com>
References: <20250314185941.27834-1-ansuelsmth@gmail.com>
Subject: Re: [PATCH v2 0/6] airoha: Add initial support AN7581
Message-Id: <174353978195.1112159.319601148390455795.b4-ty@konsulko.com>
Date: Tue, 01 Apr 2025 14:36:21 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Fri, 14 Mar 2025 19:59:20 +0100, Christian Marangi wrote:

> This little series adds initial support for Airoha AN7581 SoC.
> 
> With the help of some backport patch, this use OF_UPSTREAM
> directly.
> 
> Posting this to have the targer and the very basic driver.
> 
> [...]

Applied to u-boot/next, thanks!

[1/6] airoha: Add initial support for Airoha AN7581 SoC
      commit: 793e327e2ca947a293c0eb5beb5eef27744385f0
[2/6] clk: airoha: Add support for Airoha AN7581 SoC clock
      commit: d0b81afb5ec9d2d8a3f11bfc827f2f24c32d47ec
[3/6] reset: airoha: Add driver for controlling reset line of AN7581
      commit: b02b8b767624a859a2776c11822119392702bbab
[4/6] arm64: dts: airoha: en7581: Add Clock Controller node
      commit: 83972387a52712acf98e4827c0d09b72ea970088
[5/6] dt-bindings: clock: drop NUM_CLOCKS define for EN7581
      commit: ea0d64adc67d270de27a092d7ff7bfce8780fefb
[6/6] dt-bindings: clock: add ID for eMMC for EN7581
      commit: e00a318d64724a8fa1ed1ad56cf54edc1c295f3d
-- 
Tom


