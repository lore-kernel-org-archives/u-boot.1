Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E9ACCCA471
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 22:57:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84E12838EC;
	Sat,  4 Oct 2025 00:57:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UFDnHogo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 955618391B; Sat,  4 Oct 2025 00:57:25 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CABF4838E5
 for <u-boot@lists.denx.de>; Sat,  4 Oct 2025 00:57:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-91179e3fe34so138712239f.1
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 15:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759532241; x=1760137041; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=poInsBfrY7yZiw0KEUOzCIoRzMEwNf7UFRvt7fci38s=;
 b=UFDnHogoDME1KhxmWdALMQPOTJwRy678z3UQaRSmDq+V9tX+VUc1JxlNU/wOixk3II
 LBG7+bhiezCf9aS3MagsoOy1pGSZUonyn1kVKYxtRJJ6cHHVUEcAqxaVjJom/Bn6mB58
 HroDk2hYYWyuVKLsGk7U2/68XrDi/1AZH2+ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759532241; x=1760137041;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=poInsBfrY7yZiw0KEUOzCIoRzMEwNf7UFRvt7fci38s=;
 b=d077+Hz3RGaaXEXxGl22R8G4iijFOpWQ+wVPrtAihRI38ZlEUDcTM4Sm7qNg18iOAl
 De1cg4s4g1NOeOJHqhiYomgWB3XNet/mS3x9A1NwxcRSRfzjIEO7FWUI1PnEOqQ0Bg+G
 zWX2NH0CQejLZSH82R/XX+wL1PLoFTuKsX+Lixr8MAAp25uBfvhaIKIJrv+YkNNVdNS4
 +jm/mhqMMmV4GoNAUveIL25JsF101tE2lL30nZYT1174sYxO3n4M4VbWvi7Tk8dUdyCT
 U04JxsshQO4RLvpnv32SezhMORmuth2hfmtqJ8EqaalZo0W8YzpUe9FahReiOMIJy7Ib
 GObg==
X-Gm-Message-State: AOJu0YwOKtamPx4obSNR5D5BCqvieu8J0cXb/ARnOFU8tmSotnwPDwxr
 IA5it417klcjJNUxaKUZqtK3yPR0aIGS47maXU4LJ2Jk8ijQVFDxQHqgSNbym2Qu7fc=
X-Gm-Gg: ASbGnctvZHQbimLvW73MkrNXID/1KsGvSmoCfIWnxW9FjatjeFLBzdsXS1BA9wolTai
 /1FL9swml2EAJd3RtZPbg2/lak1ozo8EbzZ0XUeuUofHQ0ys44Mzr0IUmwSVnyhT7lbkkQFmm7Y
 t31R8fGflMRkKzA2/ysYviFo7cvZB7ir/9zqwI5G5zLaDasmdIunOxaGry4PrFN14rzWvsU4LBb
 BTZ8iEpeg8OEqib7AJL5h5FDiU9OYky0bqjhUIlA3zVxB2GaLiUtxH8u6fOcBf9LG56usZw5QAn
 YIdlLqCLYpQLz2nQmXtEnxbUpsxWBHn2B71Ndxvo8EgjsfxtekBpm6ZifFumWJCWaMzjV5tShuI
 O1nWS5Rhj41mZGU62zLLAEKI4lt7ZtMjDdSXL54dLomtiAZpqKStv6syYA+0OsG9QAPBqKOlxau
 priPaPnTIY
X-Google-Smtp-Source: AGHT+IHplAxGz2stzhus3RC+v0QBNvO/BTqz8rAPiuZIAkdaSCh0ueKU6ahp8LWOmz2OS3t3SeixZg==
X-Received: by 2002:a05:6602:27d2:b0:91b:605f:1f0f with SMTP id
 ca18e2360f4ac-93b968bed16mr678407239f.2.1759532241584; 
 Fri, 03 Oct 2025 15:57:21 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-93a7e3a3ae8sm231743639f.7.2025.10.03.15.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 15:57:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Raymond Mao <raymond.mao@linaro.org>
In-Reply-To: <20250922122948.56748-1-marek.vasut+renesas@mailbox.org>
References: <20250922122948.56748-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] linux/kernel.h: Update upper_NN_bits() and
 lower_NN_bits() macros
Message-Id: <175953224055.2203583.9485590148518336667.b4-ty@konsulko.com>
Date: Fri, 03 Oct 2025 16:57:20 -0600
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

On Mon, 22 Sep 2025 14:29:22 +0200, Marek Vasut wrote:

> Synchronize upper_NN_bits() and lower_NN_bits() macros with Linux 6.16.7
> commit 118d777c4cb4 ("wordpart.h: Add REPEAT_BYTE_U32()"). This fixes the
> lower_32_bits() macros and assures it works with 64bit systems correctly.
> This also adds 16bit variants of these macros, which will be used by the
> Airoha PHY driver.
> 
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] linux/kernel.h: Update upper_NN_bits() and lower_NN_bits() macros
      commit: 70ae44f3713427be5368d0829b97cafbd01ef1f5
-- 
Tom


