Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 057A0FF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 17:20:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7349784105;
	Sat, 25 Apr 2026 19:20:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eDsPdchb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C9B884439; Sat, 25 Apr 2026 19:20:09 +0200 (CEST)
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com
 [IPv6:2607:f8b0:4864:20::e2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A5A684413
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:20:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-6058ac0ebceso5400629137.2
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 10:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777137603; x=1777742403; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PfOkzMgo8ZtmalkJPwB+2xjQOfW4CSgy5qrGX1o4c/k=;
 b=eDsPdchbOoKHs+IWkcA78FXv9QtWtZ3+y/11icKhUi3gIfkqnqwO6MxDuXVKs7HLK8
 c5NoH5KWY0TCN0M0FtSoEIxdL1xHpTzxbTqTxNGHx0RoieXooVF0fwMSXnjuixatxjL+
 IPQF+vADCNk2DxO2Edt05fi7QAyt4PTbfOk/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777137603; x=1777742403;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PfOkzMgo8ZtmalkJPwB+2xjQOfW4CSgy5qrGX1o4c/k=;
 b=C7PeoW0SHtR3E3cfs/ZO7R1bJMph95yu/wHVcORk3pQW1BfsZsntqwQu6lKtnDPMIM
 gWJs4yBNSDqJB4RMCfUDXVFhjBJb+4KxgC9Fa9zsoOVhTbSm23JgSLr9ncnFCfbY8lGQ
 ECeJL8Wuz0iChNftTttdU6AvE4VH796lh5/wI1GfG8qw5VJuwjfsyavP9f5hfZcMaRmu
 eqcGDZ9c+X+lN4e23L1pjr1hQ9EcZFk1lfW5WxLGscX8OCBCIfpUZkgk1DwNc9n9cbNP
 Hq+d3HqctFEihuzVJ7pfoSwrRilHQdD3NPzx2PkO66MAHDtlVlTvdHtkfWIdq5y/C/OO
 pmgw==
X-Gm-Message-State: AOJu0YxJpcwqRDiLpUu1DjJZFIioAm7so1+aNnzSKi3eTcL9+L2242KH
 m2ULi2H9fW8dnsBULb44tGhNHNKgfR7coAGtnXhmsIUqgiHW0iovsUVLWgowGoNAgkaicx+yKxr
 C+j2PKVIvUw==
X-Gm-Gg: AeBDievDQlN/rZCdEx8OtIL7/e2E9hGsJfQ1VGHCCbyBJgTlXrXWkQG/2hI4tvPWBXm
 0IT9FEu9+AVElVef18u+PhQo6w31jcD01ix9aPp6cAkiF9RikqIDek0vW7nqD0WHurAs70heUXT
 wJp5lRxDLTqJCzS1S6RgbUAZZhg17fZrnFLE6tsm0HDBmMSGSbpp1z6XEiDeW0Y5haf37AWzonj
 Hgc0W+W/oJxsX+3/mkVM1q4wWavU6wx1kcNlkT+nUSL4/uE7KzlcA3cyRZtH0HMN2JDQkIWsPJ/
 OWffVxUmipfKWRufdN6cc7xRIGsn/tQK9Esnw8z0Jlm6PXwcyhxn2KYNwDscN7HRG/5WR3VoO6Y
 W19MBCJAptEFTkB/9fHvQE3YqYl0dS0JYxgcro2hGYPiviZsgbGLWZFSIBhVP0wCOT1pCj1otnZ
 B/+ei9/X+8xKKQ2jWsM8Yv29XDT++6HEjZubs3fRQNMj6Wfjlv6X1+imUNW6Gaj2cFPUYqrk64Q
 0PqCVN5cpRcjNjreJaha6aeUqF/rUT1PklSvm02WHUWfr/4C734G7Hzjlzg
X-Received: by 2002:a05:6808:221c:b0:45c:9384:3626 with SMTP id
 5614622812f47-4799cb465aemr17882609b6e.47.1777056648046; 
 Fri, 24 Apr 2026 11:50:48 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc975034e7sm19832464a34.6.2026.04.24.11.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 11:50:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
In-Reply-To: <a37aad0d-34a0-48a5-8f9b-8553f11b1f16@monstr.eu>
References: <a37aad0d-34a0-48a5-8f9b-8553f11b1f16@monstr.eu>
Subject: Re: [GIT PULL] AMD/Xilinx changes for 2026-07-rc1 v3
Message-Id: <177705664683.2527258.7342013976597541170.b4-ty@konsulko.com>
Date: Fri, 24 Apr 2026 12:50:46 -0600
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

On Thu, 23 Apr 2026 15:20:49 +0200, Michal Simek wrote:

> please pull these patches to your tree. The biggest part is new pcie driver for
> Versal Gen 2 SOC. Others are small fixes and adjustments.
> 
> Thanks,
> Michal
> 
> The following changes since commit e973fa5115e40f93bb1425db5b1cc1f3d9b8047d:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


