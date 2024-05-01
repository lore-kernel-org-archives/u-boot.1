Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09EE0C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 05:11:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B13488AEB;
	Wed,  1 May 2024 07:11:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714540281;
	bh=nrGYeMUUyC0MmgXty92fzEOrnrLNmyZ3h5lB+4rNVMw=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=UTFG7qL6aOk+0K2hsioQLtRH5PKfVQ+LF3hi8RJ9bOWvAvpRz4lDo+QT9bBvimj5r
	 UXFCck99+B5UjfLjeEMzSf6OsFFW+b5iS4/sl4VScHBQtmxQN9AkD6GnZ3Mtgd5e22
	 37UNljDtk8uwSd9XTI8HluJDcgkoPWS0gDhbJtMMONzX/RCSezWmExBrmZWKq03DvW
	 wFnW0EJz908aVW236fU39N7A6MlQsaCiPLWzKDn2zL24Klz42SBY/X2ehKtCLM858+
	 bYRMCUIx9puBGP/X/Q/Pp+Ucz9aIXBY21xobY0NRMZ7hbZu/R+nII6Ong60yXkHPng
	 HYfZfZINDlSEg==
Received: from [192.168.1.107] (89-186-112-218.pool.digikabel.hu
 [89.186.112.218])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4545F88AE8;
 Wed,  1 May 2024 07:11:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1714540280;
 bh=nrGYeMUUyC0MmgXty92fzEOrnrLNmyZ3h5lB+4rNVMw=;
 h=Date:Subject:To:References:Cc:Reply-To:From:In-Reply-To:From;
 b=O3foXamHvboPq1xJs4e3d500CIwwzOusVxuiylFzU1sq04n74QJTU8EM93msO8QuV
 8bNmIasVMOyYYd5FYvHgHc9bogwvOmF904YMX03eAiWIGixCQrI/5XcyqYulJE523B
 KAYGJRnq2U7ybZWvU5F4b3Vo+qO3kccpLcAwDa2avD0eQtMB1t3rK6Dw3sOdjptjAN
 iQ/MAocEJsYCi2sWa5ppYmGlY9WwIKSMXWbbtAJGZlvvS2naRKBgT7TZjEI1HiBZX5
 F73fG+aiNCzroY6GYum0wAG2rNy+Drc8CcSdFzl9rf6WvUxP/yohLN795KjyBXaXnq
 xwRMnC1GgBebw==
Message-ID: <92ca231a-101b-50a1-bd15-b6d7b41b3865@denx.de>
Date: Wed, 1 May 2024 07:11:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 121/149] board: socrates: Remove <common.h> and add needed
 includes
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
 <20240501024316.1767971-121-trini@konsulko.com>
Cc: u-boot@lists.denx.de
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240501024316.1767971-121-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Tom,

On 01.05.24 04:42, Tom Rini wrote:
> Remove <common.h> from this board vendor directory and when needed
> add missing include files directly.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Heiko Schocher <hs@denx.de>
> ---
>   board/socrates/ddr.c      | 1 -
>   board/socrates/law.c      | 2 +-
>   board/socrates/nand.c     | 2 +-
>   board/socrates/sdram.c    | 2 +-
>   board/socrates/socrates.c | 2 +-
>   board/socrates/tlb.c      | 3 ++-
>   6 files changed, 6 insertions(+), 6 deletions(-)

Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
