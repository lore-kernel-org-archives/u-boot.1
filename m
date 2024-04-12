Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10ECC4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 02:13:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2AB28822D;
	Fri, 12 Apr 2024 04:12:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JfcNXlZ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FD2788241; Fri, 12 Apr 2024 04:12:49 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C0C18821B
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 04:12:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-78d61a716ddso26964585a.3
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 19:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712887965; x=1713492765; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j1TdnfSuIPbYbraVKCV/gG3CtxZDZjiXI2wlPqA6jrs=;
 b=JfcNXlZ4q3CT1af3TXOSTy+esSMPjEYNRvHze7iphGMYYtw4rCZ56XMWp2NpUpqLSy
 KKKPe64ehBWHnN5iFF7AxifKsuhJWu+7ib5We2LfcMTnmXb1Dss7RdZbTIbe4/v8rLf4
 EjCOoDz1rFi9QGrK07JAYSrGpc0bfvpyvMt/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712887965; x=1713492765;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j1TdnfSuIPbYbraVKCV/gG3CtxZDZjiXI2wlPqA6jrs=;
 b=Z5O/1bLySzDvBL3SsZe7gBbt8NcRXOyS2JFipGQy8OD1ArbyOjyyKYKVHWWL62opxe
 gFZYHlgZbvCHpE+CWAyvC88SJwM1p3sVRw/XZ4P3eD/u1LNNNVC6p+qvRa46SNmD3rJI
 qpa3+OOHSveFZrnPfruYlKk/SyxzvkQFOKL12769i47qWNUl0AWBH+p/MSXK9hcv8myX
 2r49wlrysG1ye42rFugKXTQPy7vblROx/MfGAXmQYF7cjQ8wITrF1CVKGOM508o215DY
 bxa1CzKhHFagTQwaQwTV9PS8DGoh/p8lXotWDO+4pe8LY9P6fegCuebP2dXeLbPxMYBD
 8IXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7F4da5R8hsAZ2lnS9+B7t8emXK08ORCcX8FkmbjVXXUpMILPyUryOqMUNYvyst3zpoDFafXEGSmADSA//W1sJFiKu0w==
X-Gm-Message-State: AOJu0YxeEYS78ScWKvSrmlfPJncWpd8GbGm4LFomYSSy6vEhPD98F0AS
 Mfy8pBhA3aV8iQTRF6aowihNWLBvON2za4k7UGcx8qn1i+qwd0/MVjiBvan9NAE=
X-Google-Smtp-Source: AGHT+IGxe52RPgTbwxEOEjAIMsQZCzqmph19Hau2BF5X/dEEufqBa+3Xi8Ic2qFOJY5l7UmxonM9pg==
X-Received: by 2002:a05:620a:450c:b0:78d:50b7:d683 with SMTP id
 t12-20020a05620a450c00b0078d50b7d683mr1738187qkp.11.1712887965399; 
 Thu, 11 Apr 2024 19:12:45 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 g13-20020a05620a108d00b0078ec439a9a7sm1348922qkk.62.2024.04.11.19.12.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 19:12:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Vitor Soares <ivitro@gmail.com>
Cc: Vitor Soares <vitor.soares@toradex.com>, u-boot@lists.denx.de, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Alexander Graf <agraf@csgraf.de>
In-Reply-To: <20240328100548.321634-1-ivitro@gmail.com>
References: <20240328100548.321634-1-ivitro@gmail.com>
Subject: Re: [PATCH v1] arm: mach-k3: common: EFI loader map memory below
 ram top
Message-Id: <171288796435.897536.7500560881700628569.b4-ty@konsulko.com>
Date: Thu, 11 Apr 2024 20:12:44 -0600
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

On Thu, 28 Mar 2024 10:05:48 +0000, Vitor Soares wrote:

> During the boot, the EFI loader maps the memory from ram_top to ram_end
> as EFI_BOOT_SERVICES_DATA. When LMB does boot_fdt_add_mem_rsv_regions()
> to OPTEE, TFA, R5, and M4F DMA/memory "no-map" for the kernel it produces
> the following error message:
> 
> ERROR: reserving fdt memory region failed (addr=9cb00000 size=100000 flags=4)
> ERROR: reserving fdt memory region failed (addr=9cc00000 size=e00000 flags=4)
> ERROR: reserving fdt memory region failed (addr=9da00000 size=100000 flags=4)
> ERROR: reserving fdt memory region failed (addr=9db00000 size=c00000 flags=4)
> ERROR: reserving fdt memory region failed (addr=9e780000 size=80000 flags=4)
> ERROR: reserving fdt memory region failed (addr=9e800000 size=1800000 flags=4)
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


