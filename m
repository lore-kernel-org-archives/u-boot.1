Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99CC3E9A02C
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 16:01:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3CCC83AA9;
	Wed, 18 Feb 2026 17:01:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WGe+XEdR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0B9C83AC5; Wed, 18 Feb 2026 17:01:03 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7DAD83A47
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 17:01:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-45f09874c4cso2824517b6e.3
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 08:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771430459; x=1772035259; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mZBnburo9pBOUPQy4ai9+zvKl1T88ywky2xaigZdItQ=;
 b=WGe+XEdR1mQ6tsGD4KwDKcMHUbJBHcn8bu1LZrXAvnwN2agfADopumGyiY1jpuIv+L
 jnult6g1HMdbCcSixIIDLTBgDCIyXWKm4V6S3I7q225QeuLb+JNF5D59aKgwuKrLGP1P
 uXkyrvP11b6VJ6SDo79H++x/gldzsxN6y9gbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771430459; x=1772035259;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mZBnburo9pBOUPQy4ai9+zvKl1T88ywky2xaigZdItQ=;
 b=lmOQx2nu6lN6XHDMz9neL7D3XzEtyJjTCchhowgWh5AcVs8uddnBZJeBiPTqZDB4pK
 0Ne3MaVmKQkUH+a2zFrTHMzpNAODE+REYZslADwIlZ7EMhx9U90Jlp/YDG945tbPNddt
 VluDnogXsAspQk5Uqg4P+yhcToEoKa+QOTF5ZtXl+9NZw6/k+TDcKwj4O95i+02uiEcc
 6NxZKtdscxCJZ2n2qpyRywHxcsh6rt1nPD8mTyQm4rxPLnrfTwI4yuxPR6tdmXz6LE2+
 ZIEs4AHDpSWEbSporfMm8rYZVW6DPAByxZOutYBMG94lvt+hfRKqPI5pBImAY+1+BJCy
 Jy1A==
X-Gm-Message-State: AOJu0YypYS8fdsTcL45JerQ/oAlOpLp+Kr7Q+4EBR5SLht0IZWVaL/sp
 svRCqJYhcRGHClmhpYlTk2A+sU47xNGB2wqzDBeLDRVXGZlFa5q1lcKm0lbjkOng8Ok=
X-Gm-Gg: AZuq6aLyU+WTTauw+wKKubRxd/0rQRE2ZV96fR4q+CgOxzkFmSPEGzGBEEX/2cRovJa
 P15L4WlwuNMovCp0FfDU3Oap1hBATBRcg9f/gnKCNPZJFMTmJQZAJXGEuyQewjh35T++OiIuYtb
 9tfIJVCMhsbhsbw4othQjTV8bw3yX5HOBzJJF/gmx1NUBbEFN2QW6n4kKup+3v3ih89IzhmnlFY
 4DPJLeHiomHohUP3qSMhMwlbK8+nQ9+LwK6QLc+oggPUhjouCASEcLtW1uutjWB3CyJ7h/aRXtl
 VTD3p8lbKCqjl38D2eru328OjElG0B8vKMf0/DbVW/U/ISTmEzxFh/h/bHKlR8zBQz2NL783+A2
 UTMkImIGcyubcedW0hAFCz07zo3wqUE/fAW6HphDRJ1Eie7Y89vCaHvAWvSV2Tx6BBo+ngLxdSC
 v+9hqITrZIrlksinTaXT/21whpGbNCZ8utM2yGNkZvBXEM4eEpN9KhziboLMG24G3GfqGvGwAH6
 34wKd1hlbsdjvmIEPrjhbiRNzFiRarJWumolaojeFQY1Zzp3Q==
X-Received: by 2002:a05:6808:5294:b0:45e:8500:6fe1 with SMTP id
 5614622812f47-4639adb5e15mr10064563b6e.35.1771430459386; 
 Wed, 18 Feb 2026 08:00:59 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4636b064cd5sm15123611b6e.10.2026.02.18.08.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 08:00:58 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Raymond Mao <raymondmaoca@gmail.com>
Cc: Raymond Mao <raymond.mao@riscstar.com>, 
 Mark Kettenis <kettenis@openbsd.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Baocheng Su <baocheng.su@siemens.com>, Li Hua Qian <huaqian.li@siemens.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, 
 Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20260213225254.2544596-1-raymondmaoca@gmail.com>
References: <20260213225254.2544596-1-raymondmaoca@gmail.com>
Subject: Re: [PATCH v6 0/6] Implement all missing SMBIOS types required by
 distro tooling
Message-Id: <177143045815.3561457.4876010082218166241.b4-ty@konsulko.com>
Date: Wed, 18 Feb 2026 10:00:58 -0600
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

On Fri, 13 Feb 2026 17:52:45 -0500, Raymond Mao wrote:

> From: Raymond Mao <raymond.mao@riscstar.com>
> 
> This series finish the last missing puzzle of required SMBIOS types by:
> 1) Fixing duplicated handles when multiple instances exist in one type;
> 2) Implementing the rest of required types 9/16/17/19;
> 3) Adding version control when printing properties for all types.
> 
> [...]

Applied to u-boot/next, thanks!

[1/6] smbios: Fix duplicated smbios handles
      commit: 87f8a143da550a2de39dd5b30d3547bc8dfd7174
[2/6] smbios: add support for dynamic generation of Type 9 system slot tables
      commit: 83b28b55d74f884a30c47238dc8bdf9fbe6e495c
[3/6] smbios: add support for dynamic generation of Type 16 table
      commit: 374896158b435843d8ecf2c04c9985b0321295e0
[4/6] smbios: add support for dynamic generation of Type 17 table
      commit: 23674dee60240393dd17836c05df5b4f4aa01e5c
[5/6] smbios: add support for dynamic generation of Type 19 table
      commit: 41b7a09d24d878f748eba87ae85575043224148b
[6/6] smbios: print the properties only when they exist in a specified version of spec
      commit: 4c816ddbadb1bd8bfe09a457538d4f518151fd6d
-- 
Tom


