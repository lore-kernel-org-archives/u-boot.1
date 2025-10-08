Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF59CCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 20:59:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49E41839B1;
	Wed,  8 Oct 2025 22:59:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QfBVjSla";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D72483ABF; Wed,  8 Oct 2025 22:59:44 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 129CA83930
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 22:59:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-646f75551e7so124753eaf.0
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 13:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759957181; x=1760561981; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lAp3ikEbnWlLzlcxlLYP2TkE3QakT7Vzf2Lt0f7E/3k=;
 b=QfBVjSlaKyYOw/1hh6y+TJ2MYdHB2JmWYNPAoAlkTFnY1LeYgK8ASClNWhCb1zinLp
 CYC/dNVaHjvl/1nKp4jKWGCXdlpBrjoRsx8Tf4AjN1E2iPO8Irsp9+wYTdLtbHNLARG3
 Jzoqred9vqSeMByKzfLp0FGKIauU8Zmd4lSSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759957181; x=1760561981;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lAp3ikEbnWlLzlcxlLYP2TkE3QakT7Vzf2Lt0f7E/3k=;
 b=IMFBEW8VcUqVZvog7G9tv1SE44JZD34crCPWHrezluS1X9+4Pa+1AlxFTIosZtNGLY
 kpZiy+PZHxSSxPO3dy9xH+Y2tlPQIPJGSS56qDbIwnqpCEr83mXZTdxZLuuS2eGUpRvH
 a9QVj+/zJQke1FQ6RhllCJvupziJkT0HlwuzCRW1oQ02LnwpfoTKmMuF1Ruv5qg6WLwn
 H7DZj2ZxNHXxGf9/q+EemVEeofmRefb3OIBnHa3UBPJHDYxyx3Jt7U7hqwuYAGCleFWH
 BibGjEqdJJGYPl31DO7eVLn3d2GwaSg4JgV/WMkHklJdQz5C7+SWt6Ff0kTP2vTWzsOv
 NMcg==
X-Gm-Message-State: AOJu0YyqCffs+Fz7VCnFzm4KbaKKnOBj1wuMj5Y6zQEHGJFuAjg4o0KG
 IgQIPKGbgGbZQ5tDmTwSuBQv+P50Sr2b9ux3jtpG5Ics7CUqvmpB55IHaA7MWXG9emdd65FlFZm
 Gkx2CG+E=
X-Gm-Gg: ASbGncuUdX8s6yiEDu3Xsr3Ohah9nAyxdXxJBIL7IvtwuiPxEFdYahbqUCLlsng25YL
 NGN7Y0r0Le0/b7F3TjwzFld2x4fysAUavyq4VUxzvDKrRCDrPCoXoc/d5DhdKP+z7+8KYg+A2vX
 lxyIK6OsIcXhae77Eftc/crSy+mehRUiDECB9L7qLragOdJD37QeV7TFelrUqAiqZ+Shg8RUd6d
 sIJpgjiBi8N8h6KdqbIr/QdS8oICbzU4Yne8ZGPuedHh9k9VAiYeZbWoEyrPCgcfZeyll81EtK5
 efEpJoqXPkkxUx28xXFo6bJ7KVfZef5CvGPwQpovI0m4UJiadVQPnbc6VKE5rWNoPtsAOKk5zJF
 kHfZ11GvZXnDPx5LiJ1A7eC1TDr7fKJdEf81hr44d0sa71iztv3HpZfEyylYNLYoqJJs2LrlOr7
 /zwaa49AJX
X-Google-Smtp-Source: AGHT+IEqBSfNtBkpOjJ3ZTu3hmCfOuOJxgwXI1maSQkl00k89sTkabKGlMF3+ERe9AOGxvsYCnVEfA==
X-Received: by 2002:a05:6808:2120:b0:43f:6d5a:9cfa with SMTP id
 5614622812f47-4417b3b4209mr2091955b6e.23.1759957180722; 
 Wed, 08 Oct 2025 13:59:40 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44189a67d27sm226052b6e.23.2025.10.08.13.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 13:59:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20251003-654-next-fix-v1-1-55d803b07d6e@ti.com>
References: <20251003-654-next-fix-v1-1-55d803b07d6e@ti.com>
Subject: Re: [PATCH -next] arm: dts: k3-am654: add vin-supply regulators
 for DDR
Message-Id: <175995717983.3059512.16794194470930278715.b4-ty@konsulko.com>
Date: Wed, 08 Oct 2025 14:59:39 -0600
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

On Fri, 03 Oct 2025 07:15:45 -0500, Bryan Brattlof wrote:

> As of f98d812e53534 ("power: regulator: Add vin-supply for GPIO and Fixed regulators")
> we must ensure the parent nodes of a regulator are present in DT if
> they are described in the vin-supply property
> 
> For the am65x reference board the DRAM chips are fed by the 3v3 rail
> which is fed by the main 12v rail. Add the bootph properties to these
> DT nodes to prevent them from being pruned during the SPL build so we
> can enable power to the DRAM chips
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] arm: dts: k3-am654: add vin-supply regulators for DDR
      commit: 8a9f2c19d44c8db105d0031efd9a2a43d7d1797f
-- 
Tom


