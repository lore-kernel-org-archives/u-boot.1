Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87212C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 20:53:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 075C4801CF;
	Mon, 20 Jan 2025 21:53:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fAoq6ToP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13F958032B; Mon, 20 Jan 2025 21:53:08 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAAD0800C2
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 21:53:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7b6f8524f23so613304685a.2
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 12:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737406385; x=1738011185; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r+dHjZ7qFLNxzb3YI2zp7O+WlQGT8pOSs0Q2Ni5XC6w=;
 b=fAoq6ToPt9Ji6PiLC+aTAHTjXnGdk4Ahk6fy15YxmuxF0nVuJY4DoU68DxODDql5+c
 mEUWNvpZDcXvmBVHJyscvBxK57dp4m/Mf+t05LMimiLxhB7qzKjGgzRWzqGLW2kPrp49
 FiTwLoxm80F/fyipAurkSLY01wejvPOZAVxZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737406385; x=1738011185;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r+dHjZ7qFLNxzb3YI2zp7O+WlQGT8pOSs0Q2Ni5XC6w=;
 b=SvVRQIhc8Rb0bOP1vOZDIHP95Lcm+hZbF5Yi7wBhtTAl9qyXbnN9sgYPeDZmTY6y58
 PDVQv1GX/o6BPX9xMT1Glb3NLmVNvIfL1ifFTRKQZ1cztWijqSE8E0OozWRQqvwdWE7z
 nJOMk18bYVe+GaGJVFRm+xtlCua9k0U3wL6W23DYZh47jeZJ4djLsFwNTt6IqJfjYIY7
 NOcaq8nFTgPuuQYaEKUQy6jWPk9DTdBz6qSBZIZB7NfgEmL+7SEjQEh0zvfeAQudbDuO
 PkeWECRyr0cIrp3+PUsDCuo1runHPZX/76kBNtm9nvAwyn/cRzuRgYi8sRyyiYeoW33E
 04eg==
X-Gm-Message-State: AOJu0YwjKwEuvdCGGQ52WvMC2FqcKB7+j7sB1rkazeJp2Qr4QZmWv7ii
 MlFxZfUj5x6tj+NXe+ZfCCuQxuiwO4NZMiquGGYyTH4xGtimXZVXVDGMC1BMwDAdiX+pefOMGWM
 f
X-Gm-Gg: ASbGncuQEPlykuvY+K+UcSDszEGfSmYx1g7cs83gQ9uIUbdX9iv9RFbcK+Jqmsy+7su
 MnZY1IutlbJKxBeGRaEmF36DHdMvJq6svbxnt8dIdtJ8ghqfjfMDmAfKBiwknVvJ/raJEy0MQ4i
 uoT55buIsqYj+qCfuaDCDI7CcpuX0LFKlEVVnMYh2KhahhvyJWO0ZpzGuqEtROLgq9LtTzb+Ebn
 7djZgUyXxqVO+kE0Q7lO94Prpc29d726Mqzze+qJP8uBDekRQKqJGou9Mi2gkTa1Q==
X-Google-Smtp-Source: AGHT+IG0ARE0n+flwF+MIK+ctiZ0qfPZ5xORhipTeYeqFfgIVtjFoqXswCgMAmhcidFqbm7YjDPOKg==
X-Received: by 2002:a05:620a:2698:b0:7b6:6e7c:8efd with SMTP id
 af79cd13be357-7be632575femr2476897685a.58.1737406384855; 
 Mon, 20 Jan 2025 12:53:04 -0800 (PST)
Received: from [127.0.1.1] ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be6148054fsm483851185a.45.2025.01.20.12.53.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 12:53:03 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250120134421.3380217-1-festevam@gmail.com>
References: <20250120134421.3380217-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20250120
Message-Id: <173740638327.2858479.2237112182447872513.b4-ty@konsulko.com>
Date: Mon, 20 Jan 2025 14:53:03 -0600
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

On Mon, 20 Jan 2025 10:44:21 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/master, thanks.
> 
> The following changes since commit 639cd409987acf173eaffebe7876968b42fd7c32:
> 
>   Merge patch series "add the support of sha256_hmac and sha256_hkdf" (2025-01-18 17:13:01 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


