Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4675FCD6E55
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 15:58:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6B7A84898;
	Wed,  3 Jun 2026 17:57:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="awYMo1iy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88FA78005D; Wed,  3 Jun 2026 17:57:48 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74F8A8005D
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 17:57:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7e6b571750bso3042388a34.1
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 08:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780502265; x=1781107065; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kUPFjsCNqJMrNRcD4DA2pbqukKDs2KhCpDL7Ec9H/Ms=;
 b=awYMo1iy+Z8/SdwmjF0SLS9sK3BcPmGQU9wKhvgit4StWRQM6oNKrHpBu3V540IH6v
 sWfq/3++yem1rcpkrW9zcTXXW2Bvu42uySI6k7DeB0N25HSK4rcz0c+K2hdY0RnCt87o
 +tmRMKl4ijPA6WZYk0A+dG5n0eYF2vrLme/ME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780502265; x=1781107065;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kUPFjsCNqJMrNRcD4DA2pbqukKDs2KhCpDL7Ec9H/Ms=;
 b=BY825TLl50Q3Al06oDqSqOATIiWwlZjzjCw6cOZjrrG/Y3xLtQFRZQw1AzgRWv4HRD
 mV9/g1+cP8ldQmd6B71ns/es7O1t4lObFto9VBWiHw0bZDz0vpf2KHkG0D+wIOb2pJA5
 MNFL1jm47pVQoz8um171POuDjCErogGX5tL7dLzFvyl2Fw1r4k5vKDkAxIpshgxJVhfr
 oYpYuUJPohpN88j83tT0P++WzGpJFlhsNeo8CRyu5OYy8GUPHZ8MarqQcHlR8ZMwqSnC
 pdZDy92aHCHL2Sb1doSycn7+rLMSczYXjk9wYuobP05OY9Ee6nQeeDjDpMhDWdb6PXCq
 8HlQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Iq6jXIzGeJWrhReUWgW7K9m/Pby9+7XDSap5IRRTpzRZ5KV1y0Q1HfFFY4tKDBI8eJ+BRNW4=@lists.denx.de
X-Gm-Message-State: AOJu0Yxqp3Wcwswvc4FQCra+wf/UhyF412uvl7KVO1/gd/2OIfC49IFD
 2Are9EYWs07Wuv+6/JXGvQVfBrVss7JAC52BqYtFF2zFL+MovT9XozLGBONpIRAxYAN+9rVSm+N
 El6ipPj4=
X-Gm-Gg: Acq92OGFc3/dAYZ6GJYWVzef4S9Lq92ZzZhyJ87BZBfMzpp94dTH6kcsXrjnpbyxOiE
 jduiF9lmOcrF3Ck347t/q4M6cI/IACYa1dIEnhcYu9UaoNRKp2psMexVeIbHedJjM1Kv+m9G9qN
 K49w8/rXdi+wXoPVlj/IjeGArbNmD75NmYmJQ8nTdSFScY3emtK4AnvfJ4LZo1sA8EFo6Nq830E
 VyotlSgo1LuPHFy4Arch2TdmrUi/SOR+J5CKk4nC4IT6aNqLo1e1UDw+f4vHoG7Dh4Q99U/Zl9S
 kr1swU//kayLh4I8v/So4LSzs4B0ZK1Ye4jrB2GH6bF1BEj87tDzJjLVTIfmnffudaXRLtihX+r
 Zr4AiN+PU+E15RnXCDG9x+CCo9oo40NgudG6HJvG1zPFGoZZYEPU16L9Su4Uuopzkq5Q77aHQ5F
 EYdxh7qwJK2tZS77DBPFkwFyAXrJA8bwhNd2/HCrNHYXiNZipwSLIVgQIUTqtPglIj5cxT0F6BF
 xwU9yreFZdaoynQ+G86LwBFYnfjAjD4XD7UN6J6A3QccMGINAqjqc0Vfehw
X-Received: by 2002:a05:6830:917:b0:7e6:e114:899f with SMTP id
 46e09a7af769-7e6e9e1177cmr2043835a34.25.1780502265191; 
 Wed, 03 Jun 2026 08:57:45 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e78e7f9csm1970441a34.17.2026.06.03.08.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 08:57:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 Francesco Valla <francesco@valla.it>
Cc: Christian Taedcke <christian.taedcke@weidmueller.com>
In-Reply-To: <20260531-test_fs_helper_fix-v1-1-f32da24de827@valla.it>
References: <20260531-test_fs_helper_fix-v1-1-f32da24de827@valla.it>
Subject: Re: [PATCH] tests: fs_helper: check path validity during cleanup
Message-Id: <178050226431.2193579.9885595860228220473.b4-ty@konsulko.com>
Date: Wed, 03 Jun 2026 09:57:44 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Sun, 31 May 2026 23:15:09 +0200, Francesco Valla wrote:

> If the filesystem creation attempted by the FsHelper class fails, the
> invocation of the cleanup function will cause a TypeError exception,
> because the path of the filesystem itself, fed to os.remove(), will be
> None. This will lead to a test failure even in case a skip is instead
> wanted.
> 
> Such an exception will lead to a backtrace like this:
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] tests: fs_helper: check path validity during cleanup
      commit: b353d523a86775663ca2eebcd4741f3f3a9b1fe4
-- 
Tom


