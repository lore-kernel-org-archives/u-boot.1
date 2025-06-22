Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAB3C7115A
	for <u-boot@archiver.kernel.org>; Sun, 22 Jun 2025 20:52:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04D4382C4C;
	Sun, 22 Jun 2025 22:52:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RR8rjORi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 827B282CBC; Sun, 22 Jun 2025 22:52:34 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64FD68006D
 for <u-boot@lists.denx.de>; Sun, 22 Jun 2025 22:52:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2cc89c59cc0so2193843fac.0
 for <u-boot@lists.denx.de>; Sun, 22 Jun 2025 13:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750625551; x=1751230351; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LSBMQ+QjvrDOdx+X1S++VyJgzeF6GicU6F4bOsSwXGQ=;
 b=RR8rjORiAmCk9NT2P5yVuNVVpK1OFBbC+Vnbyxr1DBWCBRAE355FR0BSQHJ31CBHkH
 S2OsBF2sUd3mCDQR8ZifqTlnvqJbDg6zM8YkJonqA9iM+l9nTjT8Jv9VGtoTypMWDqNT
 /H+nsEBj70PXId0cv8AdWW1AXZRsaAVBTAP+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750625551; x=1751230351;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LSBMQ+QjvrDOdx+X1S++VyJgzeF6GicU6F4bOsSwXGQ=;
 b=pSLuw5TuICNS1hmI9o2xJ1Wlwn6A7nwwwIPmVMOin1E1OLHCgbDzyiinbDV/kCXoKH
 OkpLBywQvjO/5QkvZdM4jOujBW530id/spPFbEsAnFmXTTxjrYBCxV6t18VNqeG8HxOa
 1wtwIvC1/Et11GgOJPuXsTCU1t4reKuI0DzxZL9K3UEy1bg/ZkiPcdKzAjhwiYdJVenn
 IKDyJmIiamVeL0Lu6cNbekGy8cT3TX9k1JZ1C8PkwnO8utkXl2B4yUJ8D2Id9jzMEtVW
 vUpiNqI3MkJJK39YPN/M3mdeIFV+vq8Su7J/DD57JdL1h98IXOF+yxBPP+KMZrLOG1BG
 AEBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbFy1p2Y83khhgW+g5q3gKY1A+aatRQ8S+gxYq79XQ4Zf1DM4Wk0fPaFEpsySi693Xtlhpq4Q=@lists.denx.de
X-Gm-Message-State: AOJu0YwyRYREsk/SApQvlZ3aO7xGS4vjPxwv39A5Wn5TEDUqeTnK0Xvb
 XxqJXQ0ajeePA1VHEJgsrN4sJy0Ergqh8bpeXOjbdicvxW0gWVnsbH1H4GHwc583m2idfVXY4xY
 TcSp0vR4=
X-Gm-Gg: ASbGncvqK63jvbku3P5AcaST5RlzklddYWzDLBr5kP42uSKyolsQNeR/zi8lGEz2OtZ
 bIs5Pvb/0UF+0IDd8Y39hAjz+D6HR6yg0EtnJ1hE78oWDP/ZoPJGpydp3be+vWj706NHbn18S9T
 tN5+UfqprK1uhc7sGAvD47+IwDWyk3Rb6X0vMu0dIx+fwfzRmqWzW64RATjYxJoIZ093zOYkfbd
 R0QGo3o5XfpcjnOL6Tlgs7b+wxV4uggIBgC6OFUQiYegv/hfpTpmiGvp9Ua29sTofQulUhEA6Yj
 tX0arOwXBf19TNnxEAZ6XBFjVsHcf7lXPUm2M9aKeVu+ts/OLrKbH2ffln22HS/Y5PhmxePY6oY
 QHB6LvV1yHBdf6lo90IhLtDv74MgKHi51
X-Google-Smtp-Source: AGHT+IE79VhXZF29I2g59TpGeQEJHqRKmIlcpa8BjK7IwSXXxv5xWDFZkvFMe9ecAm/wu42ubkgt2w==
X-Received: by 2002:a05:6871:e2c8:b0:2ef:486f:7e27 with SMTP id
 586e51a60fabf-2ef48700c6amr4102482fac.10.1750625551046; 
 Sun, 22 Jun 2025 13:52:31 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ee665ad4a5sm1357117fac.18.2025.06.22.13.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Jun 2025 13:52:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Minkyu Kang <mk7.kang@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>
Cc: Minkyu Kang <promsoft@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
In-Reply-To: <20250620185010.11400-1-semen.protsenko@linaro.org>
References: <20250620185010.11400-1-semen.protsenko@linaro.org>
Subject: Re: [PATCH v2] board: samsung: e850-96: Load LDFW in board_late_init()
Message-Id: <175062554915.3894397.3339356566029231179.b4-ty@konsulko.com>
Date: Sun, 22 Jun 2025 14:52:29 -0600
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

On Fri, 20 Jun 2025 13:50:10 -0500, Sam Protsenko wrote:

> As stated in 5e847f7729b3 ("efi_loader: call efi_init_early() earlier"):
> 
>     efi_init_early() creates an event hook for block device probing.
>     It has to be called before any block device is probed.
> 
> Indeed, efi_bl_init() registers EVT_DM_POST_PROBE event, which calls
> efi_disk_probe() whenever any block device is probed. And to make that
> hook work, the initialization of all block devices was put after
> efi_init_early() in initcall_run_r():
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] board: samsung: e850-96: Load LDFW in board_late_init()
      commit: c08cecf2d7632d2c7be9a9d260f74bb585d7a3e3
-- 
Tom


