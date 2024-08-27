Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A93ECC5472C
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 08:21:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE3D188915;
	Tue, 27 Aug 2024 10:21:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="qLT9bOO0";
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="HWjnjsST";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61BDD88981; Tue, 27 Aug 2024 10:21:26 +0200 (CEST)
Received: from mail.kernel-space.org (mail.kernel-space.org [195.201.34.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26C46884DB
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 10:21:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
Received: from kernel-space.org (localhost [127.0.0.1])
 by kernel-space.org (OpenSMTPD) with ESMTP id 5faccadf;
 Tue, 27 Aug 2024 08:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=s1; bh=0q
 64QSUH+jLPf6efTJtlZ8+e4Wo=; b=qLT9bOO0conZsiSS6pGEyWsOvA/8wzbMQd
 EgnZSFZikTArcDVPrZuEro03CG6jHoGqAXYWM/peK98enH+RZQl1PX44UPhzPEN5
 Jc9RLY9jk4GfCnFSWVG24PFbut1FiU/blI3vAIqNjKiDwiHuWZD/5HP9mzmNgT2v
 zPqTb1GUg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:references:from
 :in-reply-to:content-type:content-transfer-encoding; q=dns; s=s1; b=
 B4wfeUfNWE/OEEd3KJJWd14G+bClQTOEob4r1yhs5PA5vwAubseGDWEIK5ha7EEe
 bgYhJ9cwLhEigD7T2KUTx5Qj2oiXyIAmQYbqVxMIyZRxgvSEf3X3LafBoG/SJtwt
 35ztdC2ZzzwqnHPzXZeUx1OEK1UtDEjuoz+hsdEWv8Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1724746620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mwk8YjGKLuPrgDM568ehPaIozchiy4uwBO6Fe3t62uc=;
 b=HWjnjsSTFq/4QiKpf9bp+qf5DSUljuKO/N/UrgcfElvfTeo4yAJt5pih/WeGIbaeJZx4H2
 jKPrJstHItOlhCgYKdPMmZixiVXOW3Btr/yIFUC8nG06dpadimeGO+kOqDWFfx5cTw/E9t
 Q3+26w7Zi2IxFFIYsvK8qolkJuxQSvg=
Received: from [192.168.0.2] (host-95-233-232-76.retail.telecomitalia.it
 [95.233.232.76])
 by kernel-space.org (OpenSMTPD) with ESMTPSA id 7acb3419
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Tue, 27 Aug 2024 08:17:00 +0000 (UTC)
Message-ID: <7a749cfc-35be-4a09-a933-6422913b5395@kernel-space.org>
Date: Tue, 27 Aug 2024 10:20:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] doc/arch/m68k.rst: Update toolchain comment
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20240826164957.2789525-1-trini@konsulko.com>
 <20240826164957.2789525-2-trini@konsulko.com>
Content-Language: en-US
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

Thanks Tom. Will check this later.


angelo

On 26/08/24 6:49 PM, Tom Rini wrote:
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
>   ColdFire specific configuration options/settings
>   ------------------------------------------------
