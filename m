Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FEF6C77B7F
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 23:50:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3342082E08;
	Tue, 24 Jun 2025 01:49:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hw5T3GNj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD21482E08; Tue, 24 Jun 2025 01:49:32 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1852382E26
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 01:49:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a57c8e247cso3804737f8f.1
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 16:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750722569; x=1751327369; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iyVu0TpQy4yJhjnrB34n/ZyGBoQdOsNKiF2MRduIzI8=;
 b=hw5T3GNjycXfzFcAyEfgID/gViRjln8dJK2UGe3yyoRnPR/4MhsblptjUFDXIBVIU1
 5N8Q42DoNUHEseOwzb4Cw65rv21zTDsZgJc8UQ+Mh5RtDKqWfAv9LgNSXwWb+L5y10hZ
 HAo7ZK8OgUBI2jrbL20WyWLCweGYjfPha90wA+W4NCRko0j5KuB1j11GUwdSBn3FDLS2
 wWPwtNGFSthXR0eXCbA6p1U2HVNYjn52G7POoZtZz0mHyzGyPpnRXhFAeaMV12Y7Eimc
 /88+pYn+nPmWEl+pAUv5JDzCaZi8fbz3IF8a06FVn64VRLP3D7urUQdeRiCNmMJpydx9
 YldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750722569; x=1751327369;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iyVu0TpQy4yJhjnrB34n/ZyGBoQdOsNKiF2MRduIzI8=;
 b=fTujZPFULQ+VvyQXmD83RnH17fGYIlBcGLEsjfUKNRbyAmYwpQ8mCLsuQH4i/GMak/
 V5jHmWM5so7u0N91/9BFh8EY5TP4gQNnMwhcRk5YdaguIROtu0GhzeeG/TuC26/80Z2H
 xdE+29veM6mOGcSbR6q8OOLlHs+2P0EP9k7i4wCJGHC1VD8bX2WAZeHoM+lqMr5j9fgJ
 Crn5pEug1iTJvp/k+Pl8GaN9HPFOLdUnATfJM93b/S8yd/7YhGnKm5wFUrPXOwe+0WOX
 AoiFCVC7hlZZNGzSmvuAXJqiJQz+1EqTyVMh9sLsPujXIEzLm9CRAJU2jp4U3XnUHzI3
 JqJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYWEYx/u9NgnCZQYMyBukUNt+o2/MKipJSHq7FHzgGYm02d5SkTQqkstyxAhbG/ot95d1JJzQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzxEEHOywAp0Pix50gfK9CWucfWYgJyErRHhg4Hd+/udVPWVe0s
 6tSOoTztM86tApNBexyRNdYu+1RE0F8KDYJcrIuTAoCXpmOQNTjGQ7BVizBXPSWN0Pg=
X-Gm-Gg: ASbGnctX8wk2u54kd10Qskjh7EkJ/lAfctuKVOal4o94znG6IUSkJj5M2la85E+FUAV
 gh67BMssBk5k6WBqCVoPJCp0lspz3zAr3XlcDj+KJPz45UlRQbR2vrUz+WIoJpsV3z9wycLZqEV
 4q3RCCK/tUIE/gzIOnPyYhNNNz8ySD/88GNicqlASPcb8GxDGaOVHamVDAi41GBA6Wd3bH561fd
 YB0U2zvFatdJOfxgVkjkJXWYCGEXn5FxZV59t6MB75yyTYWAygP4txqnAl6xEQ7dru+QEmT8xIt
 aYVj7hmkZn3m3U7PHSj7/SDQIq5Z9b7IzjW6Tkn/CZYiQPzGcPjgaQdVt7LL/KSeQa7T/+6l7TJ
 lkiWNf5RTeBeYAa+rpxIfFA==
X-Google-Smtp-Source: AGHT+IFz14MyeRAUcOwQzBo6EGWa9ULUXDJyxogvq/uxz+H8q5RIx/vfqgZzn+zCC83ZpKyF27cO9w==
X-Received: by 2002:a05:6000:4917:b0:3a4:fa09:d13b with SMTP id
 ffacd0b85a97d-3a6d1333f71mr13395389f8f.59.1750722569419; 
 Mon, 23 Jun 2025 16:49:29 -0700 (PDT)
Received: from toyger.tail248178.ts.net ([213.240.182.16])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e7fb5716sm432284f8f.0.2025.06.23.16.49.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 16:49:27 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: trini@konsulko.com, neil.armstrong@linaro.org, lukma@denx.de, 
 seanga2@gmail.com, Volodymyr_Babchuk@epam.com, lehmanju@devpi.de, 
 sjg@chromium.org, robert.marko@sartura.hr, dmitry.baryshkov@linaro.org, 
 andersson@kernel.org, u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>
In-Reply-To: <20250304110105.2762124-7-quic_varada@quicinc.com>
References: <20250304110105.2762124-1-quic_varada@quicinc.com>
 <20250304110105.2762124-7-quic_varada@quicinc.com>
Subject: Re: [PATCH v1 6/6] configs: add qcom_ipq5424_mmc_defconfig
Message-Id: <175072256676.128390.16011362577610151001.b4-ty@linaro.org>
Date: Tue, 24 Jun 2025 01:49:26 +0200
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


On Tue, 04 Mar 2025 16:31:05 +0530, Varadarajan Narayanan wrote:
> Introduce a defconfig for the Qualcomm IPQ5424 SoC based RDPs.
> Presently supports eMMC.
> 
> Per the flash memory layout, U-Boot size cannot exceed 756KB. With this
> defconfig, u-boot.mbn size is ~480KB.
> 
> 
> [...]

Applied, thanks!

[6/6] configs: add qcom_ipq5424_mmc_defconfig
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/cb99e1257bab

Best regards,
-- 
Casey Connolly <casey.connolly@linaro.org>

