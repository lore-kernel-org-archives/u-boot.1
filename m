Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF359C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 13:49:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6463A8197F;
	Mon, 17 Mar 2025 14:48:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vS6JA0z+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDB63800C2; Mon, 17 Mar 2025 14:48:28 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F1CB800C2
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 14:48:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4394a823036so20385515e9.0
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 06:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742219306; x=1742824106; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KGa6KR81QHBijn3uFrVDLc5ddRiuLW6FesRh737Nl98=;
 b=vS6JA0z+bESnMWFYie5XW4iZeH1dSs/mDgkY4JS8VsDSz2lO/nOLARAlzd7jy/mk9t
 gRIQYGCp4XXKJfs8JB5S1SXjTUaX1rRaZKa0acVmYN291pN4ATFAUpOGyaMCh/+LEAxw
 CdC5TGdyYcuC5LwpKMbVPzJkvkEXFbW+9ylVCZffAsfw0RpoKrsvG71D2Nlw8TWr4YIo
 ghQ4TMlC41YZX21XPZxyPU2f2aUCNs8yIJKATEcZKyQFlHyqePMWwkv8t548zguNSfnO
 4S+LrbErBxMKNBPUI1/zkOj5NwEqVrACtFKeHbhHuXhYpHO9HA/t5GpHNHHni83Gkwt+
 GTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742219306; x=1742824106;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KGa6KR81QHBijn3uFrVDLc5ddRiuLW6FesRh737Nl98=;
 b=blIUuPBcP7Wpjc3Pts4PBiGwLFM0PLZLgOwBTGmhKepsnI8K6wDnSBeAV64ARY39cN
 3fX31NIWS7pvQ7/nW+G2V2cBo0njP/PuFCGYjHiR7MILFzSWS27foWdfADwcFebVbKaC
 7MMHroWt5ZCAJnRG0ADH2iiFw60lLlzzHrVEMVbg4gCFBWMPt6KgjfIPKHpmFrEtXW0R
 0gm3tfTaWPqppqVjllySrf2SYtKrkFmSfWaLj7f63GYE02IwsDpTqzt7+M04T2L4xjYJ
 A8zddA9F7anLasyi0s18ie1Z9jvmxXIdCDx4H7bZKvUcniWTZO5w4Kh5fMwUxWsGTxl1
 AQ5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXC5VLyugiKJ9rkkt5jwvsIuhJP/hIAwoza8IUSyHvLFF3Suh4nd3PAIllt4H7seUdsQlRtAo8=@lists.denx.de
X-Gm-Message-State: AOJu0YwklhHwRsuSEvCa9IMvXZkfM1246opEtdtSjM7ktRiIJFL/7Mcb
 FztHrGI/NcJhhAn3etOJGIe4r2zW+kNk131MhlQeaA39qyRI8e5AVyCz+RRp7ZM=
X-Gm-Gg: ASbGnctmxeyKjNfBo3EhemQ+h3gza5byalnsvR1TlcAFhQh1ct4ptJbUOsspeQB21HJ
 yvEEFU57oyOXgXl9ES0Hdmp9LZMoYBZDWNzlaijKDF0oJ2w7a6TckrQ5Tc+yRm53M1pP+PqrXNX
 bvA5TEWNtScyzwJd4KSDvVPXdvYJGy8gG3aXsa4ciNIcmpgS9KlnhQ0Ytos3FQedD9iRNfn8Mxh
 /4s16oDWqsm7Niw/dN/23sq4uMA6ojLK+s+OLihtToiV5lTJhiipXTm68F2DHa5Q1b8vpYhcORI
 3cpU00ZzWwa3Z8ZJm+PU8EWnq53IIrsImDGVxssDCY/bgCCzRobzB25lfh3r2fDsD1IfS+k=
X-Google-Smtp-Source: AGHT+IFLznCi+trDAwwS5q/iwWHXAgs9TXIfPUw4Nu293l3Ep4Rb3g4y/OWckcTG5zzabeyE+Of/HQ==
X-Received: by 2002:adf:c08b:0:b0:391:39bd:a381 with SMTP id
 ffacd0b85a97d-3971dbe0c60mr7909890f8f.30.1742219305998; 
 Mon, 17 Mar 2025 06:48:25 -0700 (PDT)
Received: from [192.168.1.116] ([2a0a:ef40:1d11:ab01:670b:cd84:4753:5ae9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d200fae4asm105655945e9.27.2025.03.17.06.48.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 06:48:25 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Matthias Brugger <mbrugger@suse.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Sam Day <me@samcday.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20250123-qcom-parse-memory-updates-v3-1-c5332b81ea9f@samcday.com>
References: <20250123-qcom-parse-memory-updates-v3-1-c5332b81ea9f@samcday.com>
Subject: Re: [PATCH v3] mach-snapdragon: support parsing memory info from
 external FDT
Message-Id: <174221930476.73541.17341209911906609382.b4-ty@linaro.org>
Date: Mon, 17 Mar 2025 13:48:24 +0000
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


On Thu, 23 Jan 2025 12:12:14 +0000, Sam Day wrote:
> qcom_parse_memory is updated to return a -ENODATA error if the passed
> FDT does not contain a /memory node, or that node is incomplete (size=0)
> 
> board_fdt_blob_setup first tries to call qcom_parse_memory with the
> internal FDT (if present+valid). If that fails, it tries again with the
> external FDT (again, if present+valid).
> 
> [...]

Applied, thanks!

[1/1] mach-snapdragon: support parsing memory info from external FDT
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/11ff5a57e2fb

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

