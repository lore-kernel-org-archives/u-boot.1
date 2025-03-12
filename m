Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF77C28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 19:43:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FA64807D7;
	Wed, 12 Mar 2025 20:43:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="STsIQ4Ba";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13AA781335; Wed, 12 Mar 2025 20:43:24 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3C8180756
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 20:43:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7c55500d08cso15300285a.0
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 12:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741808601; x=1742413401; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HvmUp7qDVgV5ZrLZu+k6wEQDKk15XTeehr2N2HaSJIw=;
 b=STsIQ4Baz2Du90OXPy4Ah9mlU4MTce7+iz5GaKBsc76U3KtpUNkMB/GfOXUWisk1eR
 i5qU9lb6d6DMe0hqMpAHFqKtXa1AiL8zBeHWzKOC+1xdF4pzTZmoVjDg2BO1Z8zbdIba
 JEp99SK1ZptnKKqhe8NbiAyP1jiEtQEj5hiYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741808601; x=1742413401;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HvmUp7qDVgV5ZrLZu+k6wEQDKk15XTeehr2N2HaSJIw=;
 b=qwPOCmN+EFuwAf8XPAYbkZbzff1mfUTejgcsCqXLtn7HxY5OacyUTEJT7a/5Ac94c4
 F3KYyu24VdBc0BFTNS2cHDQGAFv5nUZUyKOAeFZYtTRDp1+IQjNKXnRmSnuK8bCzpabA
 i87bgLunyfD8CZmpIqHKqiR4GM3wHASLXhWx2TSf1QjQr7kUDMRShgQbbuF94w23CTG5
 vb+qtw5I+QvLJJW3HthzXQJxahGhY/L8slnDyLHANc95KDhPKXc8oPf1OS10lO+KUE0e
 9PJNkBf0UkS+lqVCU5ftqHyDf9/mBFTtN9I+OBQ2l7uUGL8DGh66mgrs8FjT+CQN2YOU
 OGnQ==
X-Gm-Message-State: AOJu0Yw22Ze2Pr37uup7snjqu4FMLIAOxU7lIfdPDViNTbbbZ9WRvFCi
 pRo7LlSBCsMzaVz2CyH6lWqkF89MW2pnBiS8uak/f6PWj0mbe/v9SjpRd88P9yUJ3eKp+DoY6LR
 t
X-Gm-Gg: ASbGnctCcWQXi3Z8gYyj3k87rkAAC62k5HaLMihpd2bDCQB/5ii8jM0MO0AGkLEnlet
 SWjP/pySvOgZ1ms2inV+lj3nq/t6PFrOoEbcEKdmwn+ZNAHOh+k5y7o7LXwu47oQR4YcIZXvw9p
 IWb7gnMjQJ5aD0zKAYTpsAuqztXksXtb5Yl8o9+8zFC1SizyRpHC3p2oPUQ9FUM6Zfb10LVmQLQ
 XWO6o1cDQo4DtudqFTW9pGi9wXR4ZkLCpxEwECquyq8rokRNDLVLAB8W0cjdWdoZpxbRTCabCMy
 iDlXd5Na8eU10xYKM9ZwVccKC1PyyDmRpAXZQdr6UY3I
X-Google-Smtp-Source: AGHT+IHAAoIVwfK+ely+i4wjtJYydnYzxOH7s7Ktj8b6vcNezZOwO4p4FqomMX7zFqevPLNMXWZjaA==
X-Received: by 2002:a05:620a:1b81:b0:7c0:c3ea:6982 with SMTP id
 af79cd13be357-7c55e8705c7mr1218095285a.14.1741808600731; 
 Wed, 12 Mar 2025 12:43:20 -0700 (PDT)
Received: from [127.0.1.1] ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c5491fd795sm630841285a.110.2025.03.12.12.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 12:43:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250226135647.194842-1-patrick.rudolph@9elements.com>
References: <20250226135647.194842-1-patrick.rudolph@9elements.com>
Subject: Re: [PATCH 1/3] pci_auto: Downgrade prefetch if necessary
Message-Id: <174180859863.1757127.3053724405005308626.b4-ty@konsulko.com>
Date: Wed, 12 Mar 2025 13:43:18 -0600
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

On Wed, 26 Feb 2025 14:56:42 +0100, Patrick Rudolph wrote:

> Legacy PCI devices, like qemu's Bochs VGA device, are allowed to have
> prefetchable 32-bit BARs, while PCIe devices are not allowed to have
> 32-bit prefetchable BARs. Typically prefetchable BARs are 64-bit and
> typically the prefetch MMIO window is also 64-bit and placed above
> 4GiB, as it's the case on qemu sbsa-ref.
> 
> Currently the U-Boot code assumes that prefetchable BARs are
> 64-bit BARs and always tries to assign them into the prefetch
> MMIO window.
> 
> [...]

Applied to u-boot/next, thanks!

[1/3] pci_auto: Downgrade prefetch if necessary
      commit: 699baa63ddcabe141adf3305d61f7b2a0d2de5db
[2/3] emulation: qemu-sbsa: Select SYS_PCI_64BIT
      commit: 0dbb770981d6acff3cc4921454403998dd5d0c92
[3/3] emulation: qemu-sbsa: Enable PCI enumeration
      commit: 6b9f4d0f7f070845133bcddf5e5c2dfedf32170b
-- 
Tom


