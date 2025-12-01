Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB34D116F3
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 16:04:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB19483C0C;
	Mon,  1 Dec 2025 17:03:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="O1ngWO8+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA24383B91; Mon,  1 Dec 2025 17:03:39 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6D2783B63
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 17:03:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7c6cc366884so1049150a34.1
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 08:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764605016; x=1765209816; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cw/UqlCrUazTRKXeod1KOuFH2GloofG3paW/R7bPo+8=;
 b=O1ngWO8+D8Fwt8HSCLnUBa0H/tVJL+lC9Yo9ERE7E2tQMKZlKT417yI9Y7RUkyD2eg
 lYp7USDJZ5CIDRMk7vCXAeqvTEkNuhuIK4TgEAgkhzpm25YcW14ksM8LCBUrx1kJ7EZH
 IKO0e54d70xywB+6qmYwPX3/FFzdkivL4z0hM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764605016; x=1765209816;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cw/UqlCrUazTRKXeod1KOuFH2GloofG3paW/R7bPo+8=;
 b=qF2V5MEVZGeiG8ABFHEQlslYneZFNU7urrY2j8ZFr0T7Dzsscfi3RuH1jjyutAWg06
 oaYCQdyFVmycmCmjrC92PtFhPKBghCCfxVOUEj79q2dD0q0joUaSzmHUGlD+RGhOUelS
 N6Xo/LJoMYQZ3dwjTfQouC/Em21sInPP1RVCni5fbzv6Vb2x16KQ289ID3eobuEEgGem
 Cf6cyk9T2IQ3MWuHsfP89S1xf1VZIU4Rs5gKjOc4XWhnIAxCRLmx1IGfY9iuRMHSyEJe
 y1Q1BsMjmVkRJeWcRvqLzronxbI3aER+3yQp7DjTlbAsP4XJsuAVWa6mCVSPdiDKylbh
 nf4Q==
X-Gm-Message-State: AOJu0Yzn//Liwp5h9RzRnY+fTKbxaaed7ztCWb6mgnR4/2vSZTPj7Yzr
 YGJSCdrrJAT3WO3Z0m9NLj0WT9jx2yWFRwqdghJenNWqLyEuDOiMDAGGjA4GYkegGiw=
X-Gm-Gg: ASbGncuVxpc2dFh1gusWFU/d0zYIp2S/roFKhSjk23boHW2QCE76qSkiUuHYhQ2Yfyv
 YaAZ3Z8vlcEWD7c4FanjnhpzwWKSOdx31CF+IQmyqH0NQCJ/UHngDZz9aXR8rkJLTBZ/4QC0G69
 S3HqdFEmrCCF+9RQKnM+tydVKiu6+lww0h9d+7NKq1O1emty0OlNNH4HVLRBbF8AITRuGfW+XWX
 dMUYZwn6jn+hdPiC8tnA7aWjb2JwDPX0yHS7yhB1cBq34ura/E0TQMBrKxi1c6zy+eOz/ldkkIj
 +D8puuG6cccfCOIdtfGRDUds1mFnYfs4lPe/oF3B2tm4GPdxuM6JRMT5GXBXcmAupKsz4wXpx+Z
 mO+gAYZ43SCUJuQBoTrRFbn0V3AAE/KmVVzu6yXQT9PNdNeVY7UuaYXur+BIUp/IE6NaogRJxDI
 MkJUCSrndO8bPcQZBEZIZ9XSZwBSi/Q9fqxB2JZB7tOrTpfDHG
X-Google-Smtp-Source: AGHT+IFdPJbOvsctbMHR9DJ0A0pNEI8ngxk3mR3ES2lH27Vu0ViKPYrQVbZKxHSsHN9BUMyDTUSj/w==
X-Received: by 2002:a05:6830:81e8:b0:7c7:3b3:fdbc with SMTP id
 46e09a7af769-7c798f9f9c6mr20580164a34.14.1764605016204; 
 Mon, 01 Dec 2025 08:03:36 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c90f5d811asm4708061a34.1.2025.12.01.08.03.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 08:03:35 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Quentin Schulz <foss+uboot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Raymond Mao <raymondmaoca@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Raymond Mao <raymondmaoca@gmail.com>
In-Reply-To: <20251127-gnu-mirror-v2-0-c86fa2e8d464@cherry.de>
References: <20251127-gnu-mirror-v2-0-c86fa2e8d464@cherry.de>
Subject: Re: [PATCH next v2 0/3] CI: use mirrors for GNU tools
Message-Id: <176460501535.1117748.7857258369470219152.b4-ty@konsulko.com>
Date: Mon, 01 Dec 2025 10:03:35 -0600
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

On Thu, 27 Nov 2025 14:29:25 +0100, Quentin Schulz wrote:

> I have to add one (1) package to the Dockerfile as a new dependency and
> wanted to build the image to verify it works. I wasn't able to because
> GNU servers are just not reliable at all.
> 
> The git server URL we're using doesn't seem to be a mirrored one, and
> switching to mirror URLs seem to make fetching possible again.
> 
> [...]

Applied to u-boot/next, thanks!

[1/3] CI: use GNU mirror for grub (and switch to HTTPS)
      commit: e0c72161710e3df45ed41302643b20952528eb4d
[2/3] CI: use mirror for gnulib dependency of grub
      commit: 93316f15339d6b696f58a0ef99b057bd45b76c2b
[3/3] CI: use coreboot mirror for GNU dependencies of coreboot
      commit: 6e39395a1869d9fb850e5bf5e9ba2da4663ac873
-- 
Tom


