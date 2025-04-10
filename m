Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B82CC369A2
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 01:46:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9777883980;
	Thu, 10 Apr 2025 03:46:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N57rnzQv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB6CD8395B; Thu, 10 Apr 2025 03:46:23 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E1B783965
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 03:46:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2c2c754af3cso125033fac.3
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 18:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744249580; x=1744854380; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jlSCGMB5Vhq7807nHPshrbqsmKvtGQJgHwE/R+QMe+I=;
 b=N57rnzQvvtSu2gBqR4ty+dOmbk+j63fmx3kWiC3t2STiOb2OZL7/1Kk4jMwotSIDfO
 ABgMUMNEXcsjOaO823DYINm1tOlwliOURvgdZDj6aMzdORyIuqFcQqMUU1QrH0VEAzpV
 3yGrLmjjLo46iHdIz2WGU6V1adDGOBo+P6JXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744249580; x=1744854380;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jlSCGMB5Vhq7807nHPshrbqsmKvtGQJgHwE/R+QMe+I=;
 b=aUZqEuz8xcYuzee028Sd3mkagoNMjGGaC0lxKs1H7Wx4LpNCObNDZxy13cPjo0deor
 yYaeA7qEuPN9mUeD/84mNpyHswXE0qSClGdVpemy5rM4femw3NprjnFLevC31GEsc5Kw
 UGQj8IdM06hqSKYoknv3fAjGCvx4Trn+mOZ9p/WAmqc0Y8c+DJtKWhPiHNaRdacY3rvq
 vBDsv/W8IOEmG4oscCYQp3ztWNWc/UrA2SDgWEz+H4fnPubMCQXOdcjX4VjNt3Yxgegu
 O0wCmI+vynXQq83pFKYhriA4bQsnM/MJSGOxPbg1rq05rT/lyPVed2MM1Z3R25Ojhhys
 wi6w==
X-Gm-Message-State: AOJu0YyBnTABNcmEWZLrI6+K+1B/SO3YXxyv7kD8fyxUNXZA0r5NlDvr
 ADIp1vdtiAkOJGDZLebtFkDAl72Ojuqss6fksoYJUTXwclV9jZyEy+Reak3rj5vs4Fo5KLpOk98
 7
X-Gm-Gg: ASbGncvkrr8dM/pNCa7F25h0PLP55S9W4W4Bbrvajt/uJepy1AngrkiJe+bdLLFpvLE
 CyUqcG5IoccaM+TASyuySuqx7Dg540XGVDrndrebvFd6TmORH78r92F018m42PTXyktDTGEfUGG
 sPWFIl0+UZHXTUF+WKWMm4+uX+Dqzm77mMOJ5/HggCkZBnfiVmAaSImFppkhd5/AoLCnW+NoAN/
 ey0qB0ms5ylv3imXopuQGTUF42LliW4Ix3pluO9dQiy1eBvUVhRP8XyzNw7ar7iox7s4Ty6GBLk
 gppNV84IMgWVy0iiFkHmCkwLilM4a+x8KwBmgCc5+lBgk35IauB7MBPP2rAfGSK99TsTOJ+fkqm
 ReuD4FHXdtHg=
X-Google-Smtp-Source: AGHT+IG/Yl4rOc2HgFuq6awDHBCH3uF83Wyd6zwVQJdFvKPjbjCNLKQc9e/s3X9mJwUeRq/1XPt3OQ==
X-Received: by 2002:a05:6870:830f:b0:2c2:3fad:760f with SMTP id
 586e51a60fabf-2d0b5e29913mr335177fac.37.1744249579995; 
 Wed, 09 Apr 2025 18:46:19 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d096cd3764sm474569fac.31.2025.04.09.18.46.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 18:46:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250320125201.27459-1-patrick.rudolph@9elements.com>
References: <20250320125201.27459-1-patrick.rudolph@9elements.com>
Subject: Re: [PATCH 1/3] arm: gic-v3: Scan for subnodes
Message-Id: <174424957920.1824423.2917825370323365545.b4-ty@konsulko.com>
Date: Wed, 09 Apr 2025 19:46:19 -0600
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

On Thu, 20 Mar 2025 13:51:56 +0100, Patrick Rudolph wrote:

> According to the binding [1] the ITS node should be a subnode of the
> GICv3 node. Since the ITS node has it's own driver, manually probe for
> possible subnodes after binding since dm_scan_fdt() is not recursive.
> 
> 1: https://www.kernel.org/doc/Documentation/devicetree/bindings/interrupt-controller/arm%2Cgic-v3.txt
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/3] arm: gic-v3: Scan for subnodes
      commit: 6554cb460bfc0d1a21406da49bf44f029b5aa185
[2/3] emulation: qemu-sbsa: Move ITS node into GICv3 node
      commit: d5a060b01b322231725dfc38090d8dc5e080cd33
[3/3] emulation: qemu-sbsa: Fill in correct ITS ID
      commit: 65504478fe44f6dd8b61907efa4eaeba5b79cbf5
-- 
Tom


