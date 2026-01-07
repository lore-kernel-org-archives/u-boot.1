Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C80CFD642
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 14:35:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4335983A26;
	Wed,  7 Jan 2026 15:35:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="r2xpckkK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE61083A57; Wed,  7 Jan 2026 15:35:46 +0100 (CET)
Received: from mail.kernel-space.org (unknown
 [IPv6:2a03:4000:b:d08:14a9:1bff:fedc:75ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9021B839F1
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 15:35:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1767796543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M7b3ZqZvdG4jJDnHjcjTCB3Mm53vc3qNa2yzx1IEmaY=;
 b=r2xpckkKo5e7Wt0uH2hyN7619hxhP3TubJfvmhubBfN/9NwWH5DGGf0Xc+Eyw0jtd4CiX6
 MYh/nm1FMhw9q2fSdOz2xaSu5lJzv6Ntdfl+xsqh+m1NKFixu7l+hCXJXOeRZItEjdSHvN
 N3DEbhNTZbqrZAzSBsBTbT8IYtZnwpU=
Received: from [IPV6:2a07:7e81:7daa:0:62cf:84ff:feee:627] (<unknown>
 [2a07:7e81:7daa:0:62cf:84ff:feee:627])
 by oreshnik (OpenSMTPD) with ESMTPSA id ef331104
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Wed, 7 Jan 2026 14:35:43 +0000 (UTC)
Message-ID: <8b208910-1324-49e1-befb-c7c138d5eb61@kernel-space.org>
Date: Wed, 7 Jan 2026 15:37:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] MAINTAINERS: Update m68k entry
To: Kuan-Wei Chiu <visitorckw@gmail.com>, alison.wang@nxp.com,
 trini@konsulko.com
Cc: me@ziyao.cc, daniel@0x0f.com, heinrich.schuchardt@canonical.com,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, u-boot@lists.denx.de
References: <20260105165221.1816070-1-visitorckw@gmail.com>
 <20260105165221.1816070-8-visitorckw@gmail.com>
Content-Language: en-US, it
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <20260105165221.1816070-8-visitorckw@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

It's ok for me, not owning any m68k hw here.
Also, from my understanding, Alison Wang is out of the games now,
can probably be removed.

Acked-by: Angelo Dureghello <angelo@kernel-space.org>

On 1/5/26 17:52, Kuan-Wei Chiu wrote:
> Rename the "COLDFIRE" entry to "M68K" to reflect that the architecture
> support now encompasses traditional m680x0 CPUs (e.g., M68040) in
> addition to ColdFire platforms.
> 
> Add myself as a co-maintainer to assist with reviewing and testing
> m68k-related patches.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
> Changes in v5:
> - New patch.
> 
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bf85f642a8d..57e8fd5bd8f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1045,9 +1045,10 @@ T:	git https://source.denx.de/u-boot/custodians/u-boot-clk.git
>  F:	drivers/clk/
>  F:	drivers/clk/imx/
>  
> -COLDFIRE
> +M68K
>  M:	Huan Wang <alison.wang@nxp.com>
>  M:	Angelo Dureghello <angelo@kernel-space.org>
> +M:	Kuan-Wei Chiu <visitorckw@gmail.com>
>  S:	Maintained
>  T:	git https://source.denx.de/u-boot/custodians/u-boot-coldfire.git
>  F:	arch/m68k/

-- Angelo

