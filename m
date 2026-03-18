Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9C510775E4
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 17:05:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12CE583A41;
	Wed, 18 Mar 2026 18:05:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KcGCb8BM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7830383D71; Wed, 18 Mar 2026 18:05:25 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8956F839DF
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 18:05:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7d4c383f2fcso58852a34.0
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 10:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773853520; x=1774458320; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nt7K2nQV/WUmSyhy61xiOviDgyYxppIJ8t7DWaOhzKE=;
 b=KcGCb8BMy3ANQ32KFPRM3sgL1wbYvET5SHeuNd1M3TdCNfIKHv7jJAbuvu/6XlFxxQ
 GJdmFzlLcJzLGG/zL0N+r/JIJxhxJoyuA7M3q4NQ+FPhfyBsFD4QeZPxVCV7XH9iHRGh
 uauX405fkxx8FT/Af9a9F/hOmZlVz24fhvTiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773853520; x=1774458320;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nt7K2nQV/WUmSyhy61xiOviDgyYxppIJ8t7DWaOhzKE=;
 b=ZF3leL2rPcQlX9gg4H23mnoXUsDWBHtq2PVFti6V8eh/c1397fEd5HmfVGST9cUNL0
 jd4tlPsicto5bfM2zvnJtdOSRt5C3I4lCEJz5N2NY6e8xAKZSYC/0zDLNcSnS9R1mTqi
 PG821gJythYcbQE0TGoUbBSjTvxTz18Myfr1wG7Vmp6nBib6d5srAJpdk2/g5eOQXUo9
 39uYr/hDD5kABDdoZmFlHwVj2Bg38lAFtZRPN3kNuboKOnKBXNoumwzCMR5uA7hgujC0
 2g7QmR0T3tcKi/vlWw3ZjDC3/tgOE1dqfkl9bza/CwLF5RDLz/7NIpxvtJobtSxGpAaQ
 WUiQ==
X-Gm-Message-State: AOJu0Yz+DzQCTYoAY0Zhu6u05E0EKHJQIuA3ywD3FAtSCiG/daeDsS6J
 YAYJzrWQWUuszz6GCHzY4NAREfYvelTrIlj7YbXcwiBdP78h8aBvkViTpcqnxCN0rExUXOZpiQv
 Snu71UYw=
X-Gm-Gg: ATEYQzwz25NWLjAc2TMpNz51hwPcDhn/iUT6ijI1siPnUT1Nmah7wR2sEUO90oEzhIZ
 fqHmS52NRgWnB1narpMY8gYWManP4X+UVfkXQFpzPBhQHKKhdYpyQH6Ni2+BZJRYVc7YHE9elmx
 ctOThGaEA4tIADQKP4+NTBa8pykSndr1DLY4cl5bEgp0uei0YJhkquLj4MAwtZsTYf0Hm0GuwoQ
 MnqFjU6dSTWxBBsIV/AaFq/mvGZGRQsrWX5ygMddyf82T9N5KsCDlwq4cvzzFdAiAqaK/ulct1n
 7mG1/Vtk2wCuKdphHHQsQKHmhMdl4jNkoGuMx+XvINOf6d76NYRzuDU7peXmvdlVAuG0K7/ANbA
 OhIUZZ1O/LeQRvgyAjf4Eeab9EMl/mgLEUxHmhXeJlgjvQklNoA8J1RyjPKXiNpbArIjKbclKrT
 RBKHTDC5WxdOt4ARn3WgKhDQDTIyBr7I+uIKlOx7LuEugdFVe/GqIG8ZrfPMsn6gnxy73A6uNey
 AdACyLcr5jQDXtCFwA6z22n9jKIP7rSRwbSX74PBKO0+mQ=
X-Received: by 2002:a05:6830:82ac:b0:7d7:c7b1:1b61 with SMTP id
 46e09a7af769-7d7ca759561mr2830773a34.24.1773853520135; 
 Wed, 18 Mar 2026 10:05:20 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7c9985c1dsm2611442a34.11.2026.03.18.10.05.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 10:05:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Leo Yu-Chi Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com, hal.feng@starfivetech.com, 
 e@freeshell.de, jamie.gibbons@microchip.com
In-Reply-To: <20260317060146.3983817-1-ycliang@andestech.com>
References: <20260317060146.3983817-1-ycliang@andestech.com>
Subject: Re: [GIT PULL] u-boot-riscv/next
Message-Id: <177385351919.1201153.15952263606256841859.b4-ty@konsulko.com>
Date: Wed, 18 Mar 2026 11:05:19 -0600
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

On Tue, 17 Mar 2026 14:01:46 +0800, Leo Yu-Chi Liang wrote:

> The following changes since commit 841856ed9675b26ec517fdd00b5cc0aef8db508e:
> 
>   Merge patch series "Add PCIe Boot support for TI J784S4 SoC" (2026-03-16 08:24:18 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git next
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


