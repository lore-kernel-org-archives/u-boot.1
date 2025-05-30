Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E91C54FB3
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 00:38:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C43B82E76;
	Fri, 30 May 2025 02:38:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AjZqkRbh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DADC8301F; Fri, 30 May 2025 02:38:15 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D553882E26
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 02:38:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-735a6faec9eso934279a34.3
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 17:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748565491; x=1749170291; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VP5GG6RHsS+gzDsaxOch+ZYXcnqe9vpvQLTe0ZVnb0A=;
 b=AjZqkRbhSVhTWcEyg1O1NJ6m0ilD2pXWcLhX6ZlJm9qjKsOT2H3PsDwqZhzTE3VKha
 cveC3eWVAx/LN/dOPX4EfOvwJADZocFSAvd5BmGQBvjAeZwuhKQ26tcR+3B7wJlZPFJ+
 FbO3GroFrn635i6F4nFwBFF1qBs/oayPUTwhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748565491; x=1749170291;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VP5GG6RHsS+gzDsaxOch+ZYXcnqe9vpvQLTe0ZVnb0A=;
 b=uiesyPOrpz/mENI+uLEQK+wAuYJpzmOS4RsJvuXwWdWfCW0hm/pxQXktqdC+2+DHYh
 6fttRsHp390gldFqWgDpG16AUYfcRaIKBKOBm6YVSfYL4bybFB6J7LiklcolNnA3bg4J
 mctZRZUa+dl2fDS55AM2cSOxmcD8kpp/vUSXKpHNWA0wo7/Zg5B0Oqjx39VH1AFVF2ze
 j0N2PGgKbG0PsxwBwcfo0fr27GMZmv4iQ7uPDz1FBImqngPdNC/4nxAMWASoF3YD5Y9j
 rhFX3BbCVEfwAPxiLc6OlUwcWir7g2nRmP2K+8K6lIJFZnOupDCXo+p+MTPZ7vF4o2og
 8OuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLKlvKEhGCBwU9IVD+r0Br+/riWaMMAMSXuhEewQ8DOF4DcC6xMcr/+rDSl+4j/SOrT163Jec=@lists.denx.de
X-Gm-Message-State: AOJu0YyoaVxh9TZaPs0+LbeiOgu1JYxtQ34sSTmk1CESdFFWZMwO42zy
 m8Cee5u+P8UqztlkVoRhXnA9T6nmPYQZqwHdMyAfPCZrlSVrLpQ2U3XuXfbJeiYq8xc=
X-Gm-Gg: ASbGncv2nJjsO5gKzMaV8n3aYmKtJ/Ia0PupvEGs5jMs7QtfAQlCGz1pIlrotVW5ouG
 Xlx7qOmd3nxO0zz7O+hFvdlr/YMyqQ5XQHLx7P6BHOZ6fcxdqBgKvHVWWTlrGfa9tJIAblqbAe1
 SuVkjMOjpM96XbQWsvZHZ5iJ2uIRWsqzdT6KBTpXIOKIaavQ659e6UAxl2QeABXNRbKE2K+m7KL
 udUlMSEyO8akfsxmv6dnfrPvegIFuhsl7dINIXl6F0fLgb7uQbdiRv4on/VVwGT8g9xEQ6u+8K0
 VAUkomVHtrbxjbX7pgO3GCttU40sx37aokuPs6OvvGPzMsvWCxvW6gaRU/aVFldpc3ksouTID86
 z74IxzfKoSHImSc6d5H0Pdg==
X-Google-Smtp-Source: AGHT+IH2r7sFYoRnuEY0u9hy+SplAWIbnjP92yYrUHH6SHcbcVKW4ns+xrOPq4NiG6d/fsWxtHO44Q==
X-Received: by 2002:a05:6808:3383:b0:3fe:bc96:b82d with SMTP id
 5614622812f47-4067e6e50c8mr88707b6e.36.1748565491369; 
 Thu, 29 May 2025 17:38:11 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40678aeeb4csm210321b6e.0.2025.05.29.17.38.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 May 2025 17:38:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, joe.hershberger@ni.com, avromanov@salutedevices.com, 
 michael@amarulasolutions.com, sjg@chromium.org, hs@denx.de, 
 michal.simek@amd.com, marek.vasut+renesas@mailbox.org, 
 venkatesh.abbarapu@amd.com, ansuelsmth@gmail.com, 
 cniedermaier@dh-electronics.com, xypron.glpk@gmx.de, 
 ilias.apalodimas@linaro.org, u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Varadarajan Narayanan <quic_varada@quicinc.com>
In-Reply-To: <20250513091710.3719292-1-quic_varada@quicinc.com>
References: <20250513091710.3719292-1-quic_varada@quicinc.com>
Subject: Re: (subset) [PATCH v4 0/5] Enable env in SCSI
Message-Id: <174856548924.3951697.822012021632141206.b4-ty@konsulko.com>
Date: Thu, 29 May 2025 18:38:09 -0600
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

On Tue, 13 May 2025 14:47:05 +0530, Varadarajan Narayanan wrote:

> The qcs9100 based Ride platforms have UFS as their primary storage.
> Hence add support to U-Boot env framework to be able to save and
> retrieve the environment from UFS. The environment will be
> saved/retrieved from the partition specified in the config option
> CONFIG_SCSI_ENV_PART.
> 
> Also add an API to convert partition UUID string to block device
> descriptor for UFS. This API will be used to get the block device
> descriptor for the partition specified in CONFIG_SCSI_ENV_PART.
> 
> [...]

Applied to u-boot/next, thanks!

[1/5] disk: part: implement generic function part_get_info_by_uuid()
      commit: 43fd4bcefd4ea5e586e201a0908018d1e8395c82
[2/5] scsi: Implement get_blk() function
      commit: 9a2010941f56929cb28432cc3f4b37a944f55b8e
[3/5] env: Add support for storing env variables in SCSI devices
      commit: 8bf3e967f6a999faa4782cf4a81f6aa82d31ead8
[5/5] configs: qcs9100: Enable env in SCSI
      commit: 142aab7f3e036a0cfb6efe864ddf3fe85174af44
-- 
Tom


