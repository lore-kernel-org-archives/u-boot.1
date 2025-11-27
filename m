Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FD9D111A8
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 17:18:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBE7C8445D;
	Thu, 27 Nov 2025 18:18:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="PyDb3/32";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5273842A7; Thu, 27 Nov 2025 18:18:15 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D29C83B4A
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 18:18:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dHNRl0sfLz9sn6;
 Thu, 27 Nov 2025 18:18:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764263891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ip6O2YAZzS3j57Cdf1RQneylBISvLGqCsSkISJCwiAQ=;
 b=PyDb3/326DGHJH/u1wDaWiojc6UPs70oVdvfrkMHAFpZ1FX2MZmybpdemDmamPJXCZuOw3
 ycG7bWZpGcX+WCiw4IBgcEanEWOagwG0v7lacUVC1Ptr4CdSpyB8l1IAdDN3aBpFF6v2Mb
 4Di7wxny5GNNG0vo9ZU9Me6UrMW6uXwxQXjvlVZWBByCyl9xG5mvycQ2RGCyfoRv+OjQb4
 um1yPT2UTNSbAsNvEL9KwjKaVjaL2pKvxs8hQ0LhjC272GOxUE3MIllr88pi3SqKHm86x5
 Lrg23in1tiRkiQOO4kNfrLLE3Hh9qsJs9GRjqPKRL74JJ+Adn4L/72s3ui21WQ==
Message-ID: <3b219e15-5513-4474-aae9-9d9a8abeb61e@mailbox.org>
Date: Thu, 27 Nov 2025 16:09:07 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v1 2/8] arm: Fix "file truncated" linker errors from empty
 built-in.a in SPL/TPL/VPL builds
To: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Brian Sune <briansune@gmail.com>, Tien Fong Chee <tien.fong.chee@intel.com>
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
 <20251125081316.17329-3-alif.zakuan.yuslaimi@altera.com>
 <3e4de604-292d-4232-893d-db43e29b469c@mailbox.org>
 <19c33d9d-4cab-4add-9dff-f3b9e051f146@altera.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <19c33d9d-4cab-4add-9dff-f3b9e051f146@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 4168986b4d73b0978a9
X-MBO-RS-META: tfs8ubbmsb4shmsd77ibngywt4pftaos
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

On 11/27/25 3:12 AM, Yuslaimi, Alif Zakuan wrote:

Hello everyone,

> I already have the referenced commit in my test branch, and I can 
> confirm that the same compilation error still appears on CycloneV when 
> certain directories produce no SPL objects.
> 
> The existing fix ensures that built-in.o is always present, but it does 
> not prevent ar from generating empty built-in.a archives, which older 
> ARM 32-bit linkers (such as CycloneV toolchains) reject as “file 
> truncated”.

Which toolchain is this ?

> This patch complements the earlier fix by ensuring that each SPL 
> directory contributes at least one real object, so the resulting built- 
> in.a archives are non-empty and accepted by all toolchains. It does not 
> change runtime behavior—only ensures the archives remain valid.
> 
> Thanks,
> Alif
> 


-- 
Best regards,
Marek Vasut
