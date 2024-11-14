Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8560D6A224
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 18:15:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FA2189655;
	Thu, 14 Nov 2024 19:14:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Sr3wVACW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 972E58909B; Thu, 14 Nov 2024 19:14:03 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6F6A88D90
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 19:14:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5cf7b79c6a6so1181849a12.0
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 10:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731608041; x=1732212841; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9QOoPMKm5tPGd2OXyDL6MmbLlhxbnZZA6OBkaTOBciA=;
 b=Sr3wVACWlMny+M5doEG3k0dO4mS/nouyPxvau/3NGd5HUhV0eE3i8rn1j/Y8WmICgr
 qe2a7+TL1FuH000ZVdGF0c519PceBB9Vw40+jhrIjmxpqtF7T0xRq86PFusuwMkMMFTg
 GxKOBQl4mNKnyuozg+KTLIi5AH63GyOtP+19awU/c8Eu43YNEWA+rrpxuLJ2IBRhFF7K
 nMB8gE1mJl25gcw2eBm/z1Rib6SSiNtLOaqvTKJ4OEEP8RWHj11yNtAy1Ehfml1LLasW
 cOCIt5vgRDs21JbQUlreKbxFgZBTkwutlwSFCqL/6lJYED5zCJadEOhJCVqNjawlzFtf
 VUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731608041; x=1732212841;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9QOoPMKm5tPGd2OXyDL6MmbLlhxbnZZA6OBkaTOBciA=;
 b=RTAiljrnmy+lSxvGoMGJRaa4pnJq07WGcc+3s4OVf4c5aU1kNkgdCF0YFrnZBcRhKn
 Kim8s7axjKin3VO6dOUFgQ78bjTDXMgrNV1GzHLEbTSBf6ArnvyrN3qOwCstUE6mp0da
 ph6k7PT2V426FZlWaZQ4uh8vuZc439aSZJlIPT7X9ab7Hywbp9sO0JZt8tUUOMt4Nxf9
 wUOSCUg3dkEQmfz+VuW78Sgr2YCvq0Vi3dp+ugRTwcAjaBV4zMtweKbo5wMMsp95Gnfz
 bafHHhmTexg4/ud7L3H4U0vBQ0J1QK4tise3XpfYF+GxVFUAVETHsz/pvcG/aDjkefPY
 KUSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFV437+RSnAUmIDWOQYbKLeyctFR6KI3buR7AqDoSppkvXiaxPGgLSU7Cyq9oA6uJPf0uK2ho=@lists.denx.de
X-Gm-Message-State: AOJu0YyeRwqx9MBUPiTSfsXnqEAZcxc69b07gG6ZFY9H5ekEvbPgh+Kk
 VpyfLiogS34U01L07tcy45jEaPzyEx6wFjTg+K5CcR4jU33BseCd8RNUgTRxfSY=
X-Google-Smtp-Source: AGHT+IHnh+XdumRe5S3NfP4Ib+e+s1xHhpVAb0Lh9QYvNPB8HyeBmSZG283lb8X2MCJUguiNQvLmQw==
X-Received: by 2002:a05:6402:184c:b0:5cf:7aad:c63f with SMTP id
 4fb4d7f45d1cf-5cf8de47acdmr38744a12.7.1731608041092; 
 Thu, 14 Nov 2024 10:14:01 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cf79c0ad25sm785479a12.61.2024.11.14.10.13.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 10:14:00 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20241113050931.1853447-1-caleb.connolly@linaro.org>
References: <20241113050931.1853447-1-caleb.connolly@linaro.org>
Subject: Re: [PATCH] iommu: qcom-smmu: handle running in el2
Message-Id: <173160803867.3344980.1098162648628990970.b4-ty@linaro.org>
Date: Thu, 14 Nov 2024 19:13:58 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev
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


On Wed, 13 Nov 2024 06:09:24 +0100, Caleb Connolly wrote:
> We only need to configure the SMMU when running in EL1. In EL2 the
> hypervisor isn't running so peripherals can just do DMA as they wish.
> 
> 

Applied, thanks!

[1/1] iommu: qcom-smmu: handle running in el2
      commit: f243551178ddfe30d217d88b2e683cbed49307fc

Best regards,
-- 
// Caleb (they/them)


