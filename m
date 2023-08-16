Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FB5C001B0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 01:50:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1961867C7;
	Wed, 16 Aug 2023 03:50:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sy2MJZh/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6D0E8697B; Wed, 16 Aug 2023 03:50:22 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BA2D8671F
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 03:50:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-589addee1c1so54451017b3.3
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 18:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692150618; x=1692755418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ipvDKatEdY3ZQeQbzTNq6KdNaS/bzrHNytiaMi6oNI=;
 b=sy2MJZh/eopTRD6uQY91ZGvo9oysTX2Je7TvFyCXnNS019pWk70W/x6guwJVl/Q60C
 8BhdukAaMbXoPwKevzOCTlc0QIGxvx8GbnwDrch5npRKv9BCRXhEJIzlrEovVy+2CECi
 s+YwZPRKvbyZJAR5ieFlHG3paJNXE1PoS/QP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692150618; x=1692755418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0ipvDKatEdY3ZQeQbzTNq6KdNaS/bzrHNytiaMi6oNI=;
 b=BICGr65EEs227C0p1qfRgiqS+m+SHyWDqYdFD/QFaZ2BussBV0o9y6cOzk/uOErkQe
 PP6Zfg6xKodGzmoBrjDjATTeV/3HdtDQfOWVJgcJPDHI+RARMi6xllgUtMG1/koOixZg
 D2yAohne56mgbU2styPm92GG+QNQyyu4kGOfzqa/xOJU19DnvMUoUVsxx687lshV32sD
 sdsl5hv5Vki2OOhSZLZ0GpsLX8s+DpgRqqt+I8pOFqgX+EzScOvAc1glo016+x7ZnWft
 HzDmV/F7nKZHawm7GIIRFfXnPV7YtOUvF4sKYqPnrtWcR959iUSmVodRcrklUWklX0ED
 EjtQ==
X-Gm-Message-State: AOJu0YzuzAD+Pdo2PPJ8Zq4lbGz/zIAnYWwQPXUKVM2q/br3c3B28H6W
 RO8zgtK0IpUZ5ZFKaXtMXCueoSGb+KgsN7FYQNHK7w==
X-Google-Smtp-Source: AGHT+IFgFDQyeOzZhKe5l2883x2KWoTZsmP7VE/qgMErtr9d4T16eYubVmMbQ6FEdi/hXWO27I+Thg==
X-Received: by 2002:a0d:e897:0:b0:589:f444:a72b with SMTP id
 r145-20020a0de897000000b00589f444a72bmr310480ywe.51.1692150618595; 
 Tue, 15 Aug 2023 18:50:18 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-83d6-b858-ec94-88d9.res6.spectrum.com.
 [2603:6081:7b00:6400:83d6:b858:ec94:88d9])
 by smtp.gmail.com with ESMTPSA id
 i191-20020a8191c8000000b00573898fb12bsm3757789ywg.82.2023.08.15.18.50.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 18:50:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com,
 sjg@chromium.org, Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: s-anna@ti.com,
	srk@ti.com
Subject: Re: [PATCH v2 0/6] Add SGMII support for MAIN CPSW on TI's J7200 SoC
Date: Tue, 15 Aug 2023 21:50:16 -0400
Message-Id: <169215059838.1521843.8014730893106555260.b4-ty@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230802081729.2056561-1-s-vadapalli@ti.com>
References: <20230802081729.2056561-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Wed, 02 Aug 2023 13:47:23 +0530, Siddharth Vadapalli wrote:

> This series adds support for SGMII mode to the CPSW driver to enable the
> functionality on TI's J7200 SoC.
> 
> Supporting SGMII mode also requires changes to the WIZ driver which acts
> as a wrapper for the SerDes used by the CPSW MAC to transmit data to the
> Ethernet PHY daughtercard mounted on the I2C GPIO Expander 2 connector on
> the J7200 EVM.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom

