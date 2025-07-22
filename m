Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 538CEC83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 16:08:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A77F5833F6;
	Tue, 22 Jul 2025 18:08:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NYDoThTz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71BE9837E4; Tue, 22 Jul 2025 18:08:38 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01693833F6
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 18:08:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-615a4b50215so1988623eaf.1
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 09:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753200515; x=1753805315; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tlz5K0Mu+sswDM+OzCBygVLUwBm2SewSml7Mwezfi9w=;
 b=NYDoThTzHu+MjnzOKAzUiKIsLXGQQXyBwdQGnjBb4Uei+CsOzT5Pg19+T9uMfNwyi6
 URsy2xAxOFchS/PZTZCJDWpHRBt7dtp09lqPBK1c3Lh3mO8RELbhE5oavihKd/162zli
 2YMb3cv8tj90TD64td2tc8yb1Fz4YBOdJXWXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753200515; x=1753805315;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tlz5K0Mu+sswDM+OzCBygVLUwBm2SewSml7Mwezfi9w=;
 b=lq31M9tDDg7SR1ODUUFdj937IlPBG+hKTA0vT1XNXTD+pslUxJRlDrIGtt1q5KY42S
 gA+YYsu9Aen2jw+6RESg5lAdPbwYaNHqFS23YgV4xuEs9PYixNHQB+VXfB2Xj1YDiQrg
 QOyo+gcrp3HLYwT7yG2Uq5nyoePhVfRPbWkWXM/HfQ7Jbp442nTvRAXgUP1ujNjcaPg3
 0mKOdNLrnAXt6BRRudWBNzBk+l2ekfN2Pi4mS9gixD+u6yVI9EEGPnlMxAPawHbFvU0G
 UJ6H2vN5NKeYrkWRlULqehxSk2VlO8qPii0PIwHsXdkfBOpnDBvdwHr+O4h9Sb3FQet/
 e/Aw==
X-Gm-Message-State: AOJu0Yy3Dh6uhIm9UErXaI18QxvJhsuczd2hcwf+e8k8AqtdWjBlngIn
 TcpJshazNbzcq5bwXqTlMeGrbd5SvaL+yeD4BlFZR3FqA94Aq97HR1ib4YbksVA2qAfArRA5nvh
 IZqax
X-Gm-Gg: ASbGncvJJOUSrfoGsRWPB7UeS3OTpgPekbbMDE/kA4+8LTXE5lYCuSYmdzsbFYcMq+/
 lhFneBbhb+CNgGRhjX7KVKbFYcyGKgO3cokdClOarExsI3Y6RP+KLZXm4s/m3FRUNII8WpYoPvt
 +DgcMFs54/05NtPf2P83rldMASa0n38ClRMC8q2Y7/Q5xLSAPcsBckSseha2mMrkpB3jXL7wcm5
 IUEekIB5QYHAeB9oF09IXiR9BZxkHWxpG5MXovjcRdtgJ1ZOeQ2BRDcrQb/0zUJx32M7lG4MjiQ
 fn/ZuCJsmO+3vUMLpw4OmPnr7KX6cOlP9HsoKYg5QZMcrKRv7aYAM8s94fgtu9xMulCGH+TrBNR
 Ab/gUrcKHcGYxDCg5kV0WdAa7/MsCv4NRLZNZmZwjqyfqmeCpjiHAwg0=
X-Google-Smtp-Source: AGHT+IFlHLtPotqulAxBftJhOBHL6Ys6HMQ/Rcivo1Urd4+ok8sBE/xJHbyTfeCSlNZ+4Tq+E9kTjg==
X-Received: by 2002:a4a:e90d:0:b0:615:a91b:8e7b with SMTP id
 006d021491bc7-615a91b909bmr18170012eaf.4.1753200514145; 
 Tue, 22 Jul 2025 09:08:34 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-615bc84dcb9sm2120814eaf.0.2025.07.22.09.08.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 09:08:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Fiona Klute <fiona.klute@gmx.de>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <64e80782-bb7d-4b2b-ae42-82e7077ed4ca@gmx.de>
References: <64e80782-bb7d-4b2b-ae42-82e7077ed4ca@gmx.de>
Subject: Re: Pull request doc-202510-rc1
Message-Id: <175320051324.8418.12009076901172977.b4-ty@konsulko.com>
Date: Tue, 22 Jul 2025 10:08:33 -0600
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

On Sat, 19 Jul 2025 12:46:50 +0200, Heinrich Schuchardt wrote:

> The following changes since commit bd0ade7d090a334b3986936d63a34001d99722ad:
> 
>    kbuild: Don't mandate gcc as the host compiler (2025-07-18 12:22:24
> -0600)
> 
> are available in the Git repository at:
> 
>    https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/doc-202510-rc1
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


