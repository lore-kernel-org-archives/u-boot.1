Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EEB4CA0EFF
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 16:11:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90C02831BB;
	Wed, 27 Aug 2025 18:11:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f1Cjc6W1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D33A831BE; Wed, 27 Aug 2025 18:11:52 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F14F831B4
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 18:11:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-74381ee9bc9so5310869a34.1
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 09:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756311109; x=1756915909; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NuYZQJ8HlIaO02cHW3wYavLkKODhQRahZRzxMLO2JGw=;
 b=f1Cjc6W1aK+zRf24K86/tivWWUpgOObvsCyPq3fJUHmKwzQXl2nxr1iWxyszvuvAZV
 YajQZ5jC3L+/rdTrnIG3QzQzNlVAJuwSWfIrBjT4KOF5u1Rv7M21rtzu9GOz9G0VnQQ6
 CqojCTt4gAxX1GwKJHzu909i0vTnhUqKFxlBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756311109; x=1756915909;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NuYZQJ8HlIaO02cHW3wYavLkKODhQRahZRzxMLO2JGw=;
 b=UQA3COGVWreDv9b4GayacIvMbCFTQOy7IFjC0OIcwbN7I96ZYktLWDVeFFxCknGln0
 L4hcACeNsZ+DggALsgnYoYcH2XHgI5CYyYmp0yKxpj+zOg/EadL4VYhyeZW1Z+82decp
 JLRHnHAXoB7B/JmEs/OuR+qDoZrzgWn8xhqxGx60TU8EO0k3jfGy+/MY9ZaGvLM5XtkE
 1PGsuliZmZuipz10AtjpEr/urf4tJHkc+KNBbiOTss77YKK3AS5kCAn6M3nSOxIvYp3J
 6hASYidPNNvDuIlXN2v21rsp1+nDDPQ6/MieozJ+nBa7S2fXaVxB05RSxOWIh87kp6bu
 p2lg==
X-Gm-Message-State: AOJu0Yw4qmV4U455Q7AkG8/ytYtekEBHkhzdGKnO8GwT9CC2dhmqAult
 SnuZbVEKbGRVYFXmtETD0lxExUZVhalgsgTfGrX0N79W/f0Xn8SYTaAE1xBTASeG+fllAvnucNd
 HAUzYYIk=
X-Gm-Gg: ASbGncs0Yw7N7Wt1g0Zwv6iWutLeHGCaP9fwIEBhpq6TS1pdFSOwzcpnDai6CTTUgYR
 ottzkPrcH5ER1TNZwyU2FNYk+efF0VgaQGKBsOfBJvlbhkhm4lRyZeXhw+1/PRAEKCuMZhxZaPS
 WUBN33ARa2sVHgtZvmqJn4ZQoPLR5ECITJ7EYXmXMUAc/GegAKMcjw9X9KeMHSNBWFDyCUaH9/0
 TiDA6n/UqYBn0TicgQcCOp8Kdusy9usCWfHL8yBptMdPUh+8RzWO68pu6VGgSW0jmMff98fosnA
 gUDWf/3MR19RQZIBMNoVZh5TZDTFZjiKgG6umNG1Son536LFyJmmY/tW5GjcS1VqxXPymtjKaii
 6V1K0EPljVwX9JiubcBL90sfmP4Ir8cwsr1uNX6sPsNDWAonFWdYFIxg=
X-Google-Smtp-Source: AGHT+IGwHR3rgUDyfG/KYHBhnlFkXUHkqooRKUEdC30KkbzAX6mCeqy26JUF3HVgR7biRz2V5/s8Qg==
X-Received: by 2002:a05:6830:7312:b0:73e:6317:5d52 with SMTP id
 46e09a7af769-7450090f95cmr11352295a34.3.1756311108708; 
 Wed, 27 Aug 2025 09:11:48 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7450e473c37sm3095612a34.28.2025.08.27.09.11.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 09:11:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250827093323.GB22823@nxa18884-linux.ap.freescale.net>
References: <20250827093323.GB22823@nxa18884-linux.ap.freescale.net>
Subject: Re: [GIT PULL] Please pull fsl-qoriq-next-2025-08-27 for next
Message-Id: <175631110755.657297.10331866582917895513.b4-ty@konsulko.com>
Date: Wed, 27 Aug 2025 10:11:47 -0600
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

On Wed, 27 Aug 2025 17:33:24 +0800, Peng Fan wrote:

> Please pull fsl-qoriq-next-2025-08-27 for next
> 
> -------------------------------------------------------------
> Various patches from Andrew to address issues found by Smatch
> Reinitialize job ring in crypto fsl rng
> Set scaler values for fsl dspi CS-SCK and SCK-CS
> -------------------------------------------------------------
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


