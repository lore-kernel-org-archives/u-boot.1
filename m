Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB1AC61CE8
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 22:16:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE45382CF5;
	Fri, 13 Jun 2025 00:15:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z3PdFQw1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68C0282CA8; Fri, 13 Jun 2025 00:15:32 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E77682C30
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 00:15:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7311a8bb581so1118657a34.0
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 15:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749766529; x=1750371329; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DIcKrQVKQUU8Eagy8Pzof/hbTN7tBHyyh+ChVkpZbiY=;
 b=Z3PdFQw1UTDcXQ4tYJBL1ESJ6JzKq6HwcyJYsc0+OO3qHX9//nu9prIY0dq7r5Gbjb
 rG4HrPpmKuD1Vaogq45N+vs9qmbzXw9utMa7vqQ2AQMpDKcPji/qK/KSgb37U2KKgHYR
 bDU3/4cjjdVcg570f/Sj4u8t1Z8Xt55dFDJco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749766529; x=1750371329;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DIcKrQVKQUU8Eagy8Pzof/hbTN7tBHyyh+ChVkpZbiY=;
 b=hSoosMV4tWxK7jHb6G9PxCXC1kXxZgOIVRSc/mPtRASexmvjSBHXeqBODausb1ALfS
 ina0lXupTBqnaxy8XPWFvuxzzfeEfB9vfx7i99igP5QuAXj5e4lZM+fw01tcAhM5r460
 O2cOZwA4em3vhtTE+VLW3gW+wd7fwGgPGdJofuoM9WfFlHlcwovRrgdyFK9Pj7NlNcKc
 i/D3/vBess3cviuyoGKOn30hBsD2eweDIsJ6tmzRtX5yPV2de2hvo/LXkUJ4l7kgo5X7
 F7fdV1zefrkJ+TjDD9VVb2WL0iNUvvRdJq/gXcaWE3Z6vK13zG2Voyc9bwvWTgvnSdY0
 q9ag==
X-Gm-Message-State: AOJu0YwINnNCeJ/9NOszHjSOPON1sAeIKNngkpzT9kxC8tdXurltHdID
 xs5sFm1JrQ2kjMHbXFqfH7pD5ZDOYS6hXqRFKTxdUxxort8+AoIgzFhxlkVNzSDNJtrCAYiMIjM
 L9K5yFS8=
X-Gm-Gg: ASbGncvenpPG56VmYODrOUEn3RRjJnjO/zx9lW0NkQhLK2UE0vIwiKyjbdlv3S3N2km
 cvJIe3I1gzkhq9uab6Wv+vIBnsR4qiGnp2TnAftOjUH0FfvCE+Lfs2BVjUrHdxD2aVO8VaZv09Q
 OHOvObboC+vUMhtJNqTrDncy7nMJEDyQfmA0A7evFTuLNXosZMBfafX3Cm1SRsWq4TM3Pc9QzUW
 UmrDuCfvFQrY7XqWQJroUVBlFYVmcJMv6MGni6naq0ddcDzNftNtHJx4tt0jWIxLRLpQf6iGrzh
 V+fWgkStIcpXqxTvQVZhqjsZIfzNOCEbKxMjr8CZq5lXZbHmlSkhiKo7z5xKTt25okITGJBBLQB
 +fCzeICz3jVcUJBgGRsyTuQ==
X-Google-Smtp-Source: AGHT+IH+PefNCU7lGUs4yqFQ9C8HWZZm0EiFWfNjvRm1DM8IyFpLhw5tKw3DahZLYlUzKkLdLTZIiA==
X-Received: by 2002:a05:6830:2802:b0:72b:aa94:6d26 with SMTP id
 46e09a7af769-73a27191b8emr347578a34.18.1749766528832; 
 Thu, 12 Jun 2025 15:15:28 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73a283e3198sm7145a34.10.2025.06.12.15.15.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 15:15:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Yao Zi <ziyao@disroot.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250602101515.37384-1-ziyao@disroot.org>
References: <20250602101515.37384-1-ziyao@disroot.org>
Subject: Re: [PATCH] ram: Move Kconfig options into their own menu entry
Message-Id: <174976652805.365589.8654384315024381296.b4-ty@konsulko.com>
Date: Thu, 12 Jun 2025 16:15:28 -0600
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

On Mon, 02 Jun 2025 10:15:15 +0000, Yao Zi wrote:

> RAM drivers using Device Model currently lack of their own Kconfig menu
> entry, which makes Kconfig put all options of the class in the top-level
> menu of device drivers. These options are also incorrectly grouped with
> pinctrl options in the generated .config, which is hard to read. Let's
> create a menu entry for these drivers.
> 
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] ram: Move Kconfig options into their own menu entry
      commit: 548d997229b7929bd7f0782415952d5a85eb7e64
-- 
Tom


