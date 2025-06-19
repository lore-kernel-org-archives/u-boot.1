Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F8A1C7115B
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 07:51:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DBCB82CBB;
	Thu, 19 Jun 2025 09:51:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=zoho.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=zoho.com header.i=alex3kov@zoho.com header.b="cfJl5RMH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60E1782CCE; Thu, 19 Jun 2025 09:28:07 +0200 (CEST)
Received: from sender4-pp-o92.zoho.com (sender4-pp-o92.zoho.com
 [136.143.188.92])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CDD582B18
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 09:28:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=zoho.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alex3kov@zoho.com
ARC-Seal: i=1; a=rsa-sha256; t=1750318081; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=FYgVG4tAPozVonoYp1Wws9fXVSc0Q2aYiWbKYM3hh4F3ZQgzeOeUtq0j59jrY0N8OxUAbWgxFCbLaLjdgftKeMZc0/9b9EFb6rJIPzTTWp3slvZoRtsXVWjdrPqHTUuNWHgdUgGJCFFkSBfFrqQoSw/RKCIfrqBiVuc4nfoYjTg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1750318081;
 h=Content-Type:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=Pp3N0+tJhR7oE2AY7hOl0Qfs5CjemCGmBJdoPEv8PPo=; 
 b=bhWVwheBSxu015NW5XAopKLf9tukjH6MwDv2P2M2dtkzq538JaONNcNEMak424mSET8iYNTLFUd680YZjFVsHFJ26V6AJvJ1g7GGznuVkIf8LTCsCgo4cWwDd0l8rjyFAj/ulQ6exn5g0/4m04YQW0lLhG1vKljTLmYhaM9lY28=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=zoho.com;
 spf=pass  smtp.mailfrom=alex3kov@zoho.com;
 dmarc=pass header.from=<alex3kov@zoho.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750318081; 
 s=zm2022; d=zoho.com; i=alex3kov@zoho.com;
 h=Date:Date:From:From:To:To:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Feedback-ID:Message-Id:Reply-To:Cc;
 bh=Pp3N0+tJhR7oE2AY7hOl0Qfs5CjemCGmBJdoPEv8PPo=;
 b=cfJl5RMHHSD2nVOFNtTRWoN4tmYhXcd9yNSx+Gf9fZBtQEMJv1vQ5SQhWl+sN70i
 0mALPU8UX4mVdIFouMwOm6uWePPvrcBSw9CQKoK9637G9yl3SCkd5XpQLOLI0RUtVeh
 hST6eRff5VomY56boS8w9MaTa+erH5d1YvRqASTM=
Received: by mx.zohomail.com with SMTPS id 1750318075460354.44580158455904;
 Thu, 19 Jun 2025 00:27:55 -0700 (PDT)
Date: Thu, 19 Jun 2025 10:27:47 +0300
From: Aleksei <alex3kov@zoho.com>
To: u-boot@lists.denx.de
Subject: Re: Build fail on rockpro64-rk3399_defconfig + SATA_MV=y
Message-ID: <f6vr7xc7v4ajxjlwtynrugtdrppv3h2jgbaj4gsixxacoqnxz2@hvko5bjrm7ui>
References: <tc42tqvd3kqqbfqkau5niycwkhi5ddaqponrasaitk3tkusops@yevset7ocspg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <tc42tqvd3kqqbfqkau5niycwkhi5ddaqponrasaitk3tkusops@yevset7ocspg>
Feedback-ID: rr0801122873e84037f4f4fb89938d504400008baa71d1ef1214b68eb8d354a5f284c454127343baa1a133fa25:zu08011225bbb388485513ea1f411218ba0000d425b3ae16a6c1c6ae085e279ea75353615899354afb3a:rf0801122c6c6af37dc06b98a911eab8ff0000cdd839120890b32a838d1a42b443b85f451b192137cd3c6a5f033b320dfb:ZohoMail
X-ZohoMailClient: External
X-Mailman-Approved-At: Thu, 19 Jun 2025 09:51:38 +0200
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

On 2025-06-18, Aleksei wrote:
>Hello,
>Building v2025.07-rc4 or git (17012e3068d):
>
>make mrproper && make rockpro64-rk3399_defconfig
>make menuconfig
># enable SATA_MV=y in menu
>make -j $(nproc) BL31=/tmp/bl31.elf
>
>drivers/ata/sata_mv.c:55:10: fatal error: asm/arch/soc.h: No such file or directory
>   55 | #include <asm/arch/soc.h>
>      |          ^~~~~~~~~~~~~~~~
>compilation terminated.

Disregard this please, I misunderstood the meaning of SATA_MV.
