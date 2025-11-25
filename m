Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866B2D0E6D8
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 13:03:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 727CE8405B;
	Tue, 25 Nov 2025 14:02:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="pqsx8Znb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9809584064; Tue, 25 Nov 2025 14:02:40 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B693C84057
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 14:02:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dG2sg6h1nz9tj7;
 Tue, 25 Nov 2025 14:02:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764075752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nO+zFv93JBjRLpETGpukrOEqTQi137kzT6Jv4SuWtRY=;
 b=pqsx8Znbcw2gP22H3HVHOLRyu13/sAxrsc42SfscwYfG1irlj+vOyyzSQtuozY8AUxJvBc
 TTiqhvvAXsaBzff3ZolXBnK6nIzOG7LAmxVS/ROC//ZzkYBJaU7ZYPLguIH7nz9AT+X2Ra
 erk8U6LJZ2je/g+yXpRY7zCauUTG6uvIyUZlBYRfpw+uUXUNMJ+Ri2gcXare0WzDLFl8sQ
 uadh5JJfhu7rR59ESJweqKIA94Qgwl+mNLfW/HVxZCM/fXTTUMvscmNsiRZ5Q7jmwgo3Zq
 LCbnK1u4BLn8TFMy4CdW0l7BecUgdtnUmqDZWkl+Z+wZHE40dyVuZBKAtJUQkA==
Message-ID: <3e4de604-292d-4232-893d-db43e29b469c@mailbox.org>
Date: Tue, 25 Nov 2025 13:23:04 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v1 2/8] arm: Fix "file truncated" linker errors from empty
 built-in.a in SPL/TPL/VPL builds
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Brian Sune <briansune@gmail.com>, Tien Fong Chee <tien.fong.chee@intel.com>
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
 <20251125081316.17329-3-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251125081316.17329-3-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: rc8o9iht6ubcirw6cgpgm9f6ccs7mee7
X-MBO-RS-ID: 49a6646b57b7116577f
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

On 11/25/25 9:13 AM, alif.zakuan.yuslaimi@altera.com wrote:
> From: Tien Fong Chee <tien.fong.chee@intel.com>
> 
> When building 32-bit ARM SPL (e.g. Arria 10), linking may fail with:
> 
>      arch/arm/cpu/built-in.a: file not recognized: File truncated
>      cmd/built-in.a: file not recognized: File truncated
>      dts/built-in.a: file not recognized: File truncated
> 
> This happens when a directory (such as arch/arm/cpu/, cmd/, or dts/)
> produces no object files under SPL. GNU `ar` still creates a zero-length
> archive, which older ARM 32-bit linkers (arm-linux-gnueabihf-ld) treat as
> invalid. The final link step then aborts with the "file truncated" error.
> 
> By contrast, 64-bit SoCFPGA (Agilex 5) builds use aarch64 linkers that
> tolerate empty thin archives, so the same condition does not cause an
> error.
> 
> To make XPL (SPL/TPL/VPL) builds consistent across architectures, this
> patch ensures each affected directory always contributes at least one valid
> object:
> 
>    * `arch/arm/cpu/Makefile` — add a persistent `dummy.o`
>    * `cmd/Makefile` — add `dummy.o` only when CONFIG_XPL_BUILD=y
>    * `dts/Makefile` — add `dummy.o` only when CONFIG_XPL_BUILD=y
> 
> These dummy objects define no functional code and do not affect runtime
> behavior. They only guarantee a valid archive for the linker, preventing
> false "file truncated" errors on strict toolchains.
> 
> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Such generic fixes should not be buried in SoC specific series.

+CC Tom

Maybe you need a fix similar to

37a777e1286e ("Makefile: Make sure all linker input objects exist")

?
