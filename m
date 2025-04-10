Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB5BC3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 09:54:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C39083B72;
	Thu, 10 Apr 2025 11:54:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lCkILM2m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 119E383B81; Thu, 10 Apr 2025 11:54:45 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD01383B71
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 11:54:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39c13fa05ebso317062f8f.0
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 02:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744278882; x=1744883682; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9jKU6azxgPq4wGc8QJJwmANVEEDE3a++ejvoJ5DAIjE=;
 b=lCkILM2mrNVFK1QIv+WojN2x2m8twAQ/l1+ev8fxB9vHzdisA5v5qMkXs9do7bMVd8
 j1RnS+weWn3QdJfLGFxYZiPU//A7vKkS+YVzEwwbrHY/FB+csJTDR/qgQ+d/BYwBPTrr
 is7/rlZvWpfs2uF9LKU1OtwIvCkuWBwzk6Z5c5marjEz9TYlpTXqwuXXXsbnL4X5EgAO
 uJzyLrNhv54hZJD+7BNF4hH5HDwoVwXM4xr8M+lAsKioy3cuaNN/tML7zLcn8KyGWN2u
 MtqGHmKCvlbw3v+XajwIrqCpAlu4PQfyJh7lGY4DmjneRFBKNkV/3ZoH1dU05wlybGW4
 EMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744278882; x=1744883682;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9jKU6azxgPq4wGc8QJJwmANVEEDE3a++ejvoJ5DAIjE=;
 b=SBl8iyr1ZM0UzhFkq0p6Ix45EY5jo3v4ms1nU6rI1AO4UQ/tUFhr+dYUJgizunUK3C
 JdzQFWDwQSHPyehTLbGxyN5wqIya1TjNv5u8A0OTtJCcJ8BmoHhAtc0qXE/T7S7U3llo
 gJDcOrJ+oSMU3THdvvT8zT/1syBhex5NtlB583sjCDH8PtPUx2/lmN0A2+2/tMXjbk/n
 qnKDEbUQIe5HT0Aq/iMwhVqdxRn+Fp+c9lG5+lGVrscj95JQfDysCz8GoPozZoFCpP0H
 PXQFqRxNAesMR1x+PougQ12UmbtfVNTH21GU18P2wY+slf7B+QHmqKKkC+GNzpQ0ha9B
 pDrg==
X-Gm-Message-State: AOJu0Yz0PTqBWW3ZWL0Ynyvh9yKr600TN9iy+hhQ75zLTj35oG9U3Uy5
 0uYRG9XlVVYj+C1F8wH00OGY7UMtWzukOa3aBYZ7t0Q1iGH48vmQtsw/lPYNZMM=
X-Gm-Gg: ASbGncvdWityFaFQ3JgmzRRDKkm5Ov06gn+ik3L287KVX+VypD00CEE00wVyytpjsQy
 FfwDaDcLb7L3+VXZSeY2RZ4xIRIZF5uu9CIzfJPQick1CybGP/76r10lmR9FaEtYf41/eitVAOt
 YssY+hu3buVylZqsNJfYpUKAQVRD/QgBtv3KeeGrr9s00Rt+i0froK/AV2FgGfNsL7sls2z0ZJq
 RYt4T060eR+Cmo+AlQHwxfUihj0Wivy3yzV7z8PdU0qmohpSQsRBB2z1ua3wSgbZhxdwKfdAx3/
 aeb5vYN4+LM9bwpD51omr3YJHqHXhZG2xWSZKURKAOAatWLnxYNDl5NrqbT4KwXoGVz4Wy+0SvH
 5NwA6ow==
X-Google-Smtp-Source: AGHT+IFHgF4Y4FbOPf4ZART2fZLhvZzfIwPTH6zgzBE6drs5UGE7I9pVETVuH0MSB9Urrr8eDoVdgQ==
X-Received: by 2002:a05:6000:40d9:b0:39c:e0e:b27a with SMTP id
 ffacd0b85a97d-39d8f46db29mr1824964f8f.23.1744278882032; 
 Thu, 10 Apr 2025 02:54:42 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863B08.versanet.de. [94.134.59.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f235a5e9dsm46931315e9.36.2025.04.10.02.54.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 02:54:41 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
In-Reply-To: <20250409-livetree-fixup-v1-0-76dfea80b07f@linaro.org>
References: <20250409-livetree-fixup-v1-0-76dfea80b07f@linaro.org>
Subject: Re: [PATCH 0/6] Qualcomm: cleanup OF_LIVE fixup and fix RB1/2
Message-Id: <174427888064.2136308.7249049876232428758.b4-ty@linaro.org>
Date: Thu, 10 Apr 2025 11:54:40 +0200
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


On Wed, 09 Apr 2025 19:17:23 +0200, Caleb Connolly wrote:
> Introduce a new event to signal that the live tree has been built,
> allowing boards to perform fixups on the tree before devices are bound.
> Crucially this allows for devices to be enabled or disabled, but also
> allows for properties that are parsed during the bind stage to be
> modified (such as dr_mode for dwc3).
> 
> With this in place, mach-snapdragon is switched over to use the event
> and some hacky U-Boot specific DT overrides (which had to be undone
> prior to booting an image) are removed in favour of fixing up the
> livetree (which is not passed on to further boot stages).
> 
> [...]

Applied, thanks!

[1/6] event: signal when livetree has been built
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/1c057be814e1
[2/6] mach-snapdragon: use EVT_OF_LIVE_INIT to apply DT fixups
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/f27e9c349b03
[3/6] mach-snapdragon: of_fixup: skip disabled USB nodes
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/6d81cb1c01bc
[4/6] clk/qcom: qcm2290: show clock name in set_rate()
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/bd7b4fa55310
[5/6] mach-snapdragon: of_fixup: set dr_mode for RB1/2 boards
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/dfb173f8080b
[6/6] pinctrl: qcom: qcm2290: fix off by 1 in pin_count
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/9511f4381bdf

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

