Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDEF5C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 14:19:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D63428803E;
	Fri, 12 Apr 2024 16:19:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p5Ai28EC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D645687DF1; Fri, 12 Apr 2024 16:19:11 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48A2A881A8
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 16:19:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-69b50b8239fso6751616d6.0
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 07:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712931548; x=1713536348; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ogw+BwBgcBgQMZvnXxSlvFwEjjACLRbvA1R+Mfbbxpg=;
 b=p5Ai28ECcfkfGngBCu3nctx5fPEGslr3gTKO+VPVSgUvZKuTsguPXbXuSk3bGGYSDX
 oVn70MYgQY2ZQuWH+KB9FAvJ6iJloqh79odvj5mZX9qNCxhfJGZr8vJJ5kusQc7IgYsX
 7EXJ13yOOidVS748mr1ESl9Xofbixgv6+fgvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712931548; x=1713536348;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ogw+BwBgcBgQMZvnXxSlvFwEjjACLRbvA1R+Mfbbxpg=;
 b=VwyTsG1BghD2+8d8xAlUFIBT0CUswpaM24JYouTunwtZn/tt4TZoaGwlNLnWtRMXYE
 mTcbE7WUvjIK4EyNCzcE/1XNldUg5AuvlGgemb23UNvf+wv8G5FIRbS9chgTpCxeQhio
 te7DvLheWSlu94OvQ/ALNDZQwCxt73q/4vDA8bheaVvlkeboAI+i/8aYgxCee3TCfV0y
 Aj3n8N6hHXUJJMlkxmRJVm294utFgeciI/z8uXuS2kcTUAdFSaoJkMGDq109mBTFkidM
 9PdgwsW6hWtgWFYdGcQZ+VvBcb8x5hWXzWVJV9IDnPMfydG2XOCok16wzTL+7yF+10TL
 kh/Q==
X-Gm-Message-State: AOJu0Yzdy1syI+MPTzsZxZgnsgrYu/CacOQjo+O3VeRp3e0GWJfiZ5Bf
 DYEnLu2uXidh4U5xlh4Lo7OH8ybtCioqiNYCNEZpbc/R9Jtqq9DfBfrXsCO5WDk=
X-Google-Smtp-Source: AGHT+IH1i+3T2TAT9acHuR+Wovi/XAdDxE1nJtJeFlzGcSKotVq7vKeiaO5PFP1q8AX+lf2lklhxzg==
X-Received: by 2002:a05:6214:138b:b0:69b:21b1:108a with SMTP id
 pp11-20020a056214138b00b0069b21b1108amr8690594qvb.12.1712931548156; 
 Fri, 12 Apr 2024 07:19:08 -0700 (PDT)
Received: from [127.0.1.1] ([2806:102e:18:245e:b648:93e1:5c61:68a3])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a0562140c2500b0069b5150712csm1759399qvd.56.2024.04.12.07.19.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 07:19:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Dhruva Gole <d-gole@ti.com>
Cc: Vibhore Vardhan <vibhore@ti.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, 
 Vishal Mahaveer <vishalm@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Sebin Francis <sebin.francis@ti.com>
In-Reply-To: <20240403120309.4026170-1-d-gole@ti.com>
References: <20240403120309.4026170-1-d-gole@ti.com>
Subject: Re: [PATCH 0/2] Add TIFS Stub support in AM62x
Message-Id: <171293154680.965666.2138460161843879169.b4-ty@konsulko.com>
Date: Fri, 12 Apr 2024 08:19:06 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Wed, 03 Apr 2024 17:33:08 +0530, Dhruva Gole wrote:

> Add support for signing, detection and loading of TIFSSTUB images for
> for HSSE, HSFS and GP AM62x devices.
> 
> Boot tested and Deepsleep entry exist tested with ti-linux:
> https://gist.github.com/DhruvaG2000/036010f6ae75aa6443fc77f61fd74893
> 
> Patches are based on top of tag: v2024.04
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


