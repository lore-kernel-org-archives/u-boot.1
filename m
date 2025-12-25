Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1698E7AD4B
	for <u-boot@archiver.kernel.org>; Thu, 25 Dec 2025 19:48:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE4DA84222;
	Thu, 25 Dec 2025 20:48:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Aifg+4NI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4667C84214; Thu, 25 Dec 2025 20:48:14 +0100 (CET)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA501841DD
 for <u-boot@lists.denx.de>; Thu, 25 Dec 2025 20:48:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-65745a436f7so3914304eaf.3
 for <u-boot@lists.denx.de>; Thu, 25 Dec 2025 11:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766692090; x=1767296890; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=54OuynPvSHCFVmTU9hmIYsYrWPfDLtpxHsLyFWx4VuY=;
 b=Aifg+4NIziE9Z3SToLJ9YuRNmUBeOONlndhT4r9xOnWDLeoX86Nhpc/S5M7Jd8n2d0
 4eIU3RLjXT7UoqfPyq7MfAU3NId2SwgJegZp86+bJZDnbk9ZuvsMkNj6FA23/AB74NXV
 6noNIQJn2GhiDpekD78WQdXTbsAXsQmQUaHYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766692090; x=1767296890;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=54OuynPvSHCFVmTU9hmIYsYrWPfDLtpxHsLyFWx4VuY=;
 b=wUZPHpb5KdBJBiHCR9N1niOBCJGwHhyb7WKY6CkznJ8pdxgyKqv7yVmVjr5qxWgsxk
 lod3cS0E0pJMp7CuckgsI3DWGdAsMqmAOGayip0rQDxBxc/ONmwunSwNrMtoBcC0xwIH
 0+mr+GoKRxj17D6cIwOJrxOoOcK6ZQVbxAQl8lHs/Le6e7uHH23PzzlQvIL8LXPXJgGg
 ZFfhXeNbYilr2MaupLxhpOChPyZJuM+qZ2CUDET8QVbnhmjZ/l0dzX1KWYXN1L9SAgf9
 7PDPrvNUeVuZWlwALs/qgl2zEaIyUpdl/7h8oi0eV5a+kD0JRnVHdbUN/l+Hze4MGH9+
 tUCw==
X-Gm-Message-State: AOJu0Yz39zxJUoSOyCXMreWRGzb4Ic1adpsXf2QoIgumeG3voXspem6h
 XJAqcuPo2SJ5VfrzoCdLA6r8+viLPetwnbz0nB/8IVtsMCx5vS536J9fe6Av4bzMhmg=
X-Gm-Gg: AY/fxX7Vv7AW2Z7HMLWSNGpTqIG1VhLlYX469oyqTuT8iUeej3B9zYeCzjiT8Vuix4b
 MI9lZsD92m5cG9XxBP6SJch+rMqAJKq40g9/nqgJL+y44O8AadlATxHGxXrepe5N8nYpLdXDAN5
 oAFkQ7MuSYvtEIPH+OFQppWeq34c+yMohVTVoq6BiP9hRTUKL4QYLVgbpDx0JWhCqieNPKzZ4hf
 U6Qn3mVIX7VaS7T2/bopm/ZA58SE0wUHQj3p1EQ7JOFsbxqMCee89qGnamHYVyBMFiT+VmZFjbW
 /0+vVeG4pwwGTZo7DYgcRd0YwqdTyk0YSc46Dx4j2tW/5QoSrLIQ/YdeL9xKLUjM5HMtC/6PJgT
 Nxz1JqayUO1NDgIcVHLDqOM+L+JEr40yiuALJl8FNQkoWG8cG8ENjnE6c81e36d26NW/VvvnfyK
 iIP8V8vc1ne6+13CRBoOpl7CXAUPKOJ4pznfR1LNuzsMSmccbE
X-Google-Smtp-Source: AGHT+IF2YHylj3cf4NS3RA1QV5gUAccKpDCwvWWfCeRFhxPpuOy4LcDI04lSw7cNS1xlorU6KsGR6g==
X-Received: by 2002:a05:6820:f00c:b0:65d:be3:3110 with SMTP id
 006d021491bc7-65d0e99d928mr10482987eaf.23.1766692090547; 
 Thu, 25 Dec 2025 11:48:10 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65d0f515721sm12794412eaf.8.2025.12.25.11.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Dec 2025 11:48:09 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, E Shattow <e@freeshell.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <1faefbf2-e8b0-4c94-85f5-025355915e0d@gmx.de>
References: <1faefbf2-e8b0-4c94-85f5-025355915e0d@gmx.de>
Subject: Re: Pull request efi-next-20251225 (for next branch)
Message-Id: <176669208910.1263958.8972451881709434686.b4-ty@konsulko.com>
Date: Thu, 25 Dec 2025 13:48:09 -0600
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

On Thu, 25 Dec 2025 11:13:02 +0100, Heinrich Schuchardt wrote:

> The following changes since commit baf076aeb32dcdd2b022405088c3288ffc160fcf:
> 
>    Merge branch 'staging' of
> https://source.denx.de/u-boot/custodians/u-boot-tegra into next
> (2025-12-23 08:11:36 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


