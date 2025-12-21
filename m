Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7840D68BD5
	for <u-boot@archiver.kernel.org>; Sun, 21 Dec 2025 07:53:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24A3E8391B;
	Sun, 21 Dec 2025 08:53:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="zeLJ2wHt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FC5883923; Sun, 21 Dec 2025 08:53:36 +0100 (CET)
Received: from mail.kernel-space.org (unknown
 [IPv6:2a03:4000:b:d08:14a9:1bff:fedc:75ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2348E83700
 for <u-boot@lists.denx.de>; Sun, 21 Dec 2025 08:53:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1766303613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+vovT7AXkw/YE3K7EHu44Az5nk1XbMWuFhEY2lJz9EE=;
 b=zeLJ2wHt7xiR6SSJSpnLSi7P6d1XowqlxYZhzC+YB5j4F1z2FocOkSQ81QGODBX3FaVD+v
 wY2rMkSIyT6px82OWOv1ygv5DGpovN4fCPR/Wwn5qROt9H6aOSC/rPPA9ooFfW4pz2ZP5e
 6Kxj94dltG1vX3P5Q3SpEOX9W3cot0E=
Received: from [IPV6:2a07:7e81:7daa:0:62cf:84ff:feee:627] (<unknown>
 [2a07:7e81:7daa:0:62cf:84ff:feee:627])
 by oreshnik (OpenSMTPD) with ESMTPSA id 8df99213
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Sun, 21 Dec 2025 07:53:33 +0000 (UTC)
Message-ID: <9adb99f5-0cc3-4ffb-b0c8-5948fa503319@kernel-space.org>
Date: Sun, 21 Dec 2025 08:54:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] doc/arch/m68k.rst: Update toolchain comment
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20240826164957.2789525-1-trini@konsulko.com>
 <20240826164957.2789525-2-trini@konsulko.com>
Content-Language: en-US, it
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <20240826164957.2789525-2-trini@konsulko.com>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Tom,

On 8/26/24 18:49, Tom Rini wrote:
> The old wiki page has not exited for quite some time, update to note
> what we build with in CI at least.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Angelo Dureghello <angelo@kernel-space.org>
> ---
>   doc/arch/m68k.rst | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/doc/arch/m68k.rst b/doc/arch/m68k.rst
> index 8474ece62c7a..de7eb3849551 100644
> --- a/doc/arch/m68k.rst
> +++ b/doc/arch/m68k.rst
> @@ -82,9 +82,9 @@ A bash script similar to the one below may be used:
>   Adopted toolchains
>   ------------------
>   
> -Please check:
> -https://www.denx.de/wiki/U-Boot/ColdFireNotes
> -
> +Currently the `kernel.org cross-development toolchains
> +<https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/>`_ are
> +used in the project CI builds.
>   

thanks,

Acked-by: Angelo Dureghello <angelo@kernel-space.org>

>   ColdFire specific configuration options/settings
>   ------------------------------------------------
