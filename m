Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 718B5C83F09
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 08:03:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E4E483390;
	Wed,  9 Jul 2025 10:03:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KDow6Hl2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16ECD83394; Wed,  9 Jul 2025 10:03:27 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1C7883371
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 10:03:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E9AB2466B9;
 Wed,  9 Jul 2025 08:03:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD08C4CEEF;
 Wed,  9 Jul 2025 08:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1752048202;
 bh=n4ZPTTYm/SC3XbsEQNikaY01GEWIzUtyDoLRiPCr5e8=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=KDow6Hl2MSdtD/M9ZULeKdmtPWwojvTBKmbxBHu9yOY3XslooAcLQmuhfIJ3c216Q
 ZjMSlqzl62hunqMHaHqERNJyJendKtHOa9bvlk7Dd3CMAagv/CYqjXq/rjYYAHIY9T
 EX5UXM6xXX7S6z7AnHbnWkG0y/ZlNb2/5zoypdXDDpyHhtNIQgLALreqOCOM4e8zK7
 B3jw0Prlu2b1K3wrIaG93kDqK9VK3IF/+ugZIC8vIGTBdKkrz3hEkhsQWzhHTpkbzr
 zw1fzC0I1Jw7ni/1IQzUW/vKhdJwRvFafhBkJ7bWAsh4QeipO4uwsNB1G3Khg2qwy1
 yQhErkygZhPIw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>
In-Reply-To: <20250702010603.19354-1-trini@konsulko.com>
References: <20250702010603.19354-1-trini@konsulko.com>
Subject: Re: [PATCH 1/2] boot/android_ab.c: Make use of LBAF for printing
 lbaint_t
Message-Id: <175204819997.8343.16701344965238632653.b4-ty@kernel.org>
Date: Wed, 09 Jul 2025 10:03:19 +0200
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

Hi,

On Tue, 01 Jul 2025 19:06:02 -0600, Tom Rini wrote:
> When printing the contents of an lbaint_t variable we need to use LBAF
> to print it in order to get the correct format type depending on 32 or
> 64bit-ness. Furthermore, printed message should not be split as that
> makes finding them harder, so bring this back to a single line.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/2] boot/android_ab.c: Make use of LBAF for printing lbaint_t
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/ab0d5fe4cba420467689be9cbf4ddccabc54cfa8
[2/2] common/avb_verify.c: Make use of LBAF for printing lbaint_t
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/34272133d9e5a46fde6c7f87e452e4b5e51c2999

--
Mattijs
