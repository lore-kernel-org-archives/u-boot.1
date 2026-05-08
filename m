Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB7CCD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 23:14:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89B6284DF7;
	Sat,  9 May 2026 01:14:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GXHmQhq2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26CC584C9E; Sat,  9 May 2026 01:14:44 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 580EE84CE3
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 01:14:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d1872504cbso2385707a34.0
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 16:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778282080; x=1778886880; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=isfKcrRrCvgm463VpVXN0EIpu4+5nNWwTtyiE3ALeVw=;
 b=GXHmQhq2GapD4mArdiTmXmztwxAleFgz9rCApaLHexpii7OI8PYJvCak0CliiYLbNe
 C4cU9Gh7BQbP9wpaoI7riuYxm8BZcTJoo/taIyLKcgD3zkdpTkPjpoYBLHWaG7YN3N4s
 dJ3KkvZT2O+YlOGX78F3ZHZeMxCI79f2VwfuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778282080; x=1778886880;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=isfKcrRrCvgm463VpVXN0EIpu4+5nNWwTtyiE3ALeVw=;
 b=cAOOTJFPbuY7G6esPGn2S6zAubmBVjmw6z8BbDsPteonrL8oJTtn/lO5QIbEic7BcI
 z9ABHkTOzjxWfj0Cg924LOnMv4Z7Kj++MdzLRpMH51JxUErta2rZEhI3SWFPxd5OyqvH
 1Gjs5f4vWmrBTQXXKd0Ck6+awAkk7MtargrdxuoMQjaT/xjwJAKhCaxm3gjYVnm+pE8x
 XU8xTZCga0JMOv5JfN3c8tBo9BDKuB2RQs8KwTs0ZyXQmqrqCv3EEoPrafcmL+cGOqF8
 9KWfCiKGVQey5Hb/3PLpVblc3yybLa8oxzmT90seDkuS1C/IWztdQwhoyKIkN/cmd92o
 SEvg==
X-Gm-Message-State: AOJu0YxddR+olberZz6XGjcCRyZdpuocbeIhR3B6UpsJ/XBHSRbZu/RU
 7dIjmltM6EC0fp3oUoD5wyY3XVDCwKeVizzGq9xVDGu4N4td9rz6ogEe9N1CrWV+R3o=
X-Gm-Gg: AeBDies9Y/vgq0bNqIz0PuFfhLb+CGUP/qotj4dN7znunyS/ak5RNK/h16W2heiR4P2
 dJBsCBHkYdsMRbXYyp+blJDnOSDz7r148HrKznSXHI3EG5c0ihAxdnx2ZiqGS9ErcJoNyIl3dZw
 iUHfbWrEMmccpZJFlQH8KBJcZS2jSQHEpY/MtKLwHplGP4GAC34y6flRaHqYcbaoY77RaqQudXX
 YSnFHnezP1M8sz7RVzxrCClOolUfGUW+BJ7FIoemdUaUoGqgvgGkgv9IqSsKCoE1Hty8bbmdy5q
 2c5JY/jGJ+5G7/a4Yc70ho9qK8bdDRhuX2f9Ap6Si70FjGfhhaFJpQJZgIcE4SO6cQQIKkMN585
 CEdISMzz1Pfte3Rm89/cqHtiQ1RKymbtk9IHIApwA1AlnWI3R0ma3PycgUBy9tWr0VYLZJc6+Bw
 O9jNvZtVOj3ORtcB837WDGFe7hJX1MCsLRcSCEgsGkYF+IHllJ/bbIB3Kf8vHqSqONkQ3LdDoCN
 iDXDjGT7o/BFWfDQOgcWyougCIBLk50qUjDG9mEPi5fsvKG1tnDnU8gfCip
X-Received: by 2002:a05:6830:4986:b0:7dc:ce29:32e2 with SMTP id
 46e09a7af769-7e1fcbf7780mr5443822a34.2.1778282080067; 
 Fri, 08 May 2026 16:14:40 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367be1168sm2005082a34.5.2026.05.08.16.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 16:14:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Raymond Mao <raymondmaoca@gmail.com>
Cc: Raymond Mao <raymond.mao@riscstar.com>, Simon Glass <sjg@chromium.org>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Michal Simek <michal.simek@amd.com>, Pranav Sanwal <pranav.sanwal@amd.com>, 
 Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260506145535.1679611-1-raymondmaoca@gmail.com>
References: <20260506145535.1679611-1-raymondmaoca@gmail.com>
Subject: Re: [PATCH v3] lib: fdtdec: validate bloblist FDT before consuming
 libfdt size
Message-Id: <177828207883.1997265.15777514578374067443.b4-ty@konsulko.com>
Date: Fri, 08 May 2026 17:14:38 -0600
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

On Wed, 06 May 2026 10:55:33 -0400, Raymond Mao wrote:

> Coverity Scan defects are observed in fdtdec_apply_bloblist_dtos(),
> since the live FDT taken from the bloblist is passed to libfdt helpers
> which consume header size/offset fields:
> - fdt_open_into()
> - fdt_pack()
> 
> Validate the bloblist FDT with fdt_check_full() before calling
> fdt_open_into() and again after applying overlays before calling
> fdt_pack(). This makes the libfdt consumers operate on a checked FDT
> blob while keeping the existing flow unchanged.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] lib: fdtdec: validate bloblist FDT before consuming libfdt size
      commit: 0a31d3128ee6928d7eac5b830ef79d0a27e3f0a7
-- 
Tom


