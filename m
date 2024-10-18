Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9AED3DEA6
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 18:33:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8235488BEF;
	Fri, 18 Oct 2024 20:32:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NI/+nFn1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F7B688B23; Fri, 18 Oct 2024 20:32:57 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F39D88A0A
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 20:32:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6cbe90c7c95so17478386d6.1
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 11:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729276374; x=1729881174; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=L3K8dZVLJ8ubP7awNdrmT7TdUd1AwuvHqjB9nzSPVRM=;
 b=NI/+nFn1XKLZwCgJ3yL/zvEjjA/sFBSkfuhs6OrlENeete1VHJjnV3lFknEGldZgJY
 YTESwnP/gSWsBMVzmdTdFYSn5QBKtAi7NequUssLWUczKGGG1aOdQsNFFSksVvvQ9LZi
 jh81uJFl44n19WGIe9CuxJvPrweV+lnfp9Cs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729276374; x=1729881174;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L3K8dZVLJ8ubP7awNdrmT7TdUd1AwuvHqjB9nzSPVRM=;
 b=kxs/ihyqhigJdLGwApLGWYvkH5WHWJX825jJCrgMsPmNnn11eoftJTLnXEZ1iIeP7X
 okd55lpb+Hz/zQ2WW5YRS7V/AnmQzl3u6QEpaVLggEgOUT+CRSnXjvc43Z/VYcPM6lxB
 iJpUHA4vm403eNL/3JKshZkTkdMulwNr5AfkLt8WDfinRRaSzDpqOa4YsP3rAXn61Hl4
 Fb9qYnCTeQFQ1aI5fYS4FuZU/ClpKLARQSw3b4wjlOcNZTSVc4lMkn1jsQlgaXY2fsco
 ABjKpx4UCMAvl9IVCzIU69kyC1xNncXiVhJh7wzlKgTvnawXVll//5amtF9DBCgtH3J9
 vsJg==
X-Gm-Message-State: AOJu0YxeysmyUcgVVBgk8eH6iI003amdYYzQCsP7MWkWGhh2gJQdNuo6
 zIenWgXICw3qsLnyeiEcQj+2hjOxle8eONbtcAbn4daVmwCVJYtZkG1WNFU+ERKTR4VmCd66y6O
 JUwA=
X-Google-Smtp-Source: AGHT+IH4/JLsRzzX2Eu+rFXyLq7X4wPRjpjRWbe7v/PTDZ84LMNRn2YBb1HCjDVMa/jNlu1d/SJpfA==
X-Received: by 2002:a05:6214:540e:b0:6cb:399d:6ec3 with SMTP id
 6a1803df08f44-6cde14bdaa8mr39257276d6.9.1729276374390; 
 Fri, 18 Oct 2024 11:32:54 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cde111b366sm9365866d6.5.2024.10.18.11.32.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 11:32:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20241015013310.289277-1-trini@konsulko.com>
References: <20241015013310.289277-1-trini@konsulko.com>
Subject: Re: [PATCH] Azure: Update to latest containers
Message-Id: <172927637347.2470674.1966894899390419445.b4-ty@konsulko.com>
Date: Fri, 18 Oct 2024 12:32:53 -0600
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

On Mon, 14 Oct 2024 19:33:10 -0600, Tom Rini wrote:

> Soon Azure will be removing the macOS-12 container in following their
> normal support schedule. Move us to macOS-14 so we won't have problems
> there for a while. At the same time, our Windows container is the oldest
> supported, so move to the newer option. Finally, Ubuntu 22.04 is the
> middle option currently, but 24.04 should be fine.
> 
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


