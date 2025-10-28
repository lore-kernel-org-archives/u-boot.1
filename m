Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3322CCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 17:59:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6CB783942;
	Tue, 28 Oct 2025 18:59:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dk1KiTxV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7AEE8391C; Tue, 28 Oct 2025 18:59:13 +0100 (CET)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD149838CE
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 18:59:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-650317ae979so1864668eaf.2
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 10:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761674350; x=1762279150; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WnHUWiUZaPNrmzwUVBJ2R1SXfaV8UTfE8iqLoH34tTs=;
 b=dk1KiTxVaiOm22WqoDvALB8dfFqDWQb3iLbfcCvIAHIaJPXrrucSPOIvFLIKsqwU9G
 yjViknj0ZyHrxpUHu5B9W8zuqn2MWmqGJgAR894bS6UQ+VIqwmPBPWBw1xIsp3r8TiWM
 8hWozXhtmOqWrz6iBMY5mayYPQqKapOJqXkj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761674350; x=1762279150;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WnHUWiUZaPNrmzwUVBJ2R1SXfaV8UTfE8iqLoH34tTs=;
 b=SVoBbJ6XFt21nD5hxLPJT3uJfl30ZxsY0WiZwwIebHQawbDAMoMm9NCNHq/XyBfuEm
 xcgo4CRFfS19zO3pRlufm46J3t+rT66AMqlTuwK/ILBiUW/Q/aDHcKwXYkDT0Zk1NX28
 IpVUWa56dM+Qo8u9DUnw7MkCmpAKFCoAgNE6tPAFHMyVaI6NJtYaL3FCoLPYtrCPZv2w
 qsZTIZJLdG+DU8D/md/Pc9hjzNZfmVdT4o+6AQ82vliJedk10p7YDRKpBhfi7JHWk7vB
 Wa9i86IbnDtDsJrNK3bqeQv0D48gzU7kIqWwHKdyauP2PdmO0zCD3Q4sxeSL8bKOMx9h
 ywsA==
X-Gm-Message-State: AOJu0Yyy0KhEIY64v3FP9BTUHxqvxcPjRZtM+5a0BRLNtPgdioesw9kd
 VdKsFTV/fdLiBXOmNCrzmLYQzNTngg6dPNdHR8YuoF+HyxAu10GgfFOdB8t/tmi5a2U=
X-Gm-Gg: ASbGncvvm1+og+fUKWHCZIITq7/cXSxy6VdQA31V4sbZcpQYdFZjgN/OBv6bb3xXilG
 nRK0biCZNGfvG0z2vB9dI5zvdZN+had6eabFJcIDImRBa9C4GlP7UK6ZxeuzOA0kRPEnXBfNu4t
 uTz4Z4M+EnqtAXZSBLsMv9E/1NQQkl7PP1mdi4DQ+j4fRHFBJBReLterTcnZyBAtnSW94Woplrs
 iqbb5wx5LPNzdlXtvEGV3hMhc7N9M28i9SWwr0U4eiIOI5HWqBGL9dmX8cPcjalt66qvYuRvCSB
 BI2C/j4q9vVD0CeVvLRkBmK/0xDTmNkvLQsyoNz5yZRS+VrL5KIOrt7PTpbYN8Kr0NtovvaW477
 ppP4B4OhaWOoI0hNtT90EfJOFt367NhsGvDOjGoeoavg+Q2RHuP0NfScQi+jQOwABV3Z0qB1ph0
 qnm5HpTxu5ezqPYFnOaOb9jVmJJvQxGCnIjeGpQQ==
X-Google-Smtp-Source: AGHT+IGMtQKuXFFB5u0FfAJe8EZMQi1ixM1ik/FX4AcIeUerKh6zT1IvEOKcS3vtUfb68VWVUU3iow==
X-Received: by 2002:a05:6808:4fd1:b0:441:8f74:f32 with SMTP id
 5614622812f47-44f7a5339b9mr162235b6e.60.1761674350564; 
 Tue, 28 Oct 2025 10:59:10 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-654ef2e0d33sm2843926eaf.16.2025.10.28.10.59.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 10:59:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250731-owl_mmc-v1-1-8493be6755e6@linaro.org>
References: <20250731-owl_mmc-v1-1-8493be6755e6@linaro.org>
Subject: Re: [PATCH] mmc: owl_mmc: Do not dereference data before NULL
 check
Message-Id: <176167434937.2025892.1792835140026903420.b4-ty@konsulko.com>
Date: Tue, 28 Oct 2025 11:59:09 -0600
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

On Thu, 31 Jul 2025 12:11:47 +0100, Andrew Goodbody wrote:

> In owl_mmc_prepare_data there is a NULL check for the pointer data but
> it happens after data has already been dereferenced. Refactor the code
> so that the NULL check happens before any code dereferences data.
> 
> This issue was found by Smatch.
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] mmc: owl_mmc: Do not dereference data before NULL check
      commit: 6e382d8fc5ee6876ade500222cb0ade9cdc597ed
-- 
Tom


