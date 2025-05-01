Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3864C369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 14:23:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B78E809D4;
	Thu,  1 May 2025 16:23:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rizX1t44";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4B4980F03; Thu,  1 May 2025 16:23:21 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 206D9809A5
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 16:23:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-72c1425fbfcso704870a34.3
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 07:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746109397; x=1746714197; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kO8icpJ6GuI9UA36xs6DtEsAQy3SaeEv+feuDopJaZQ=;
 b=rizX1t446xBa+C6/Bg4nTWDK0auh0fx8z5bqmBXeraRK0c8zQYk26J++9cz4WFEW+r
 gwGh4MH2EEz+os9TA1Cm+wwAlhegAY2I7wZXtk+K5wsDXQAOxr/dnswaqHENbtk2XMly
 LfQrm6xrnAIfrxQ9hkDXGxqzZIR7ckAzA7YZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746109397; x=1746714197;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kO8icpJ6GuI9UA36xs6DtEsAQy3SaeEv+feuDopJaZQ=;
 b=obwnLxytRlimbXV+leZfsOnMiqNTzr8G9CcHx97JSKj24TtgQXsLly/doUNM/Dftcj
 fnvf2IMowluNzramHqolSADCUgpoRhcznqGsdRcjtP1aI17azst8dHAyJwhzs+iLcJxK
 99IF5Whd4bXnSmRWkKDFBXnSoJ1FAac2RIylB50Ez7bSaj8JImSnjDxRBTFYJPPGUzzi
 ZMjxfrR33RafB2C+K5dlngmIkdKoLtvP+PbCE992zPBDE83sn73Y0gZfPP/CVS1+u925
 u1hdXHWUh05/+HWhBDcsuYYo2BNr2ixxsDKLtCwwIMXKL6Lslq1+Vh/Uw2zvRkgkBtu8
 XCRQ==
X-Gm-Message-State: AOJu0YxSiKDj/m7O/j9Rm5zl4Fnr7TQa0y5f2+RQUpiSTZW65aSHknAV
 u2VffBMTEcxnr7t6dwXJe2X60yDqZjytHmKkZofujuYlJwsb5TkciSEXJL1zXPI=
X-Gm-Gg: ASbGncs8S7CwK2k09Upms6bMT8mXBV50UDltd7ez9zpXdLANyAGySUokzKzPcdnGM8M
 BD5213nXRcz/2cQXnRQOyp7vvWszrQPG0MBQilUQ81YADs4IRXd42eIuYHmZ7RiMluY4q0QWA0D
 GX2lWU/zCe0bQuQNfA+KHUzy9j59+LBkOYSWS7csOMD9MDGe8lW5gbed2gGGQTHxrKKc1PnLWun
 amzRZrUJxZpMxk5P55iiPBQKnKvCw2un7Gg9e9R5KCkV6xl3tQZN1ZN8gwgD9lSxtBVJ0cVP9ya
 +Av4LNI5NsyYWD9XV57hc5efgaow1QXv/J44x3C6nHScBPD/SyqJa3PJAsk1UbhiD799sso/3XH
 K
X-Google-Smtp-Source: AGHT+IFBLRt6YKRP1f6cVjFrhX3WaYNL0IcEgFPuyMW8sD0J/kAfGJ72r+iNq+jeHsXVEtIDCCZ4oA==
X-Received: by 2002:a05:6830:641b:b0:72a:18a6:d431 with SMTP id
 46e09a7af769-731ce36b51dmr1895540a34.14.1746109397698; 
 Thu, 01 May 2025 07:23:17 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-731d350a04csm115251a34.68.2025.05.01.07.23.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 07:23:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Mike Looijmans <mike.looijmans@topic.nl>
Cc: Alexey Romanov <avromanov@salutedevices.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 William Zhang <william.zhang@broadcom.com>
In-Reply-To: <20250408054642.6843-1-mike.looijmans@topic.nl>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.bc83124b-b53b-4cfa-9911-d8ca2185a06f@emailsignatures365.codetwo.com>
 <20250408054642.6843-1-mike.looijmans@topic.nl>
Subject: Re: [PATCH v2] mtd: mtdpart: Support MTDPART_SIZ_FULL in
 fixed-partitions
Message-Id: <174610939695.2332917.12074241187689468342.b4-ty@konsulko.com>
Date: Thu, 01 May 2025 08:23:16 -0600
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

On Tue, 08 Apr 2025 07:46:38 +0200, Mike Looijmans wrote:

> Flash partitions may specify MTDPART_SIZ_FULL (=0) as the size of the
> partition to indicate "the remainder of the flash". Make this work with
> device-tree "fixed-partitions" as well.
> 
> This makes MTD partitioning compatible with the Linux kernel, see:
>   https://github.com/torvalds/linux/blob/master/include/linux/mtd/partitions.h#L29
>   https://github.com/torvalds/linux/blob/master/drivers/mtd/mtdpart.c#L123
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] mtd: mtdpart: Support MTDPART_SIZ_FULL in fixed-partitions
      commit: 98a898e58499c78245e4fe36ee404b1b1208e32b
-- 
Tom


