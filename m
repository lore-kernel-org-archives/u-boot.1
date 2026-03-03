Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA42EC1433
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 11:49:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2C7A838BB;
	Tue,  3 Mar 2026 12:49:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="Dol5DrbE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B447083F4C; Tue,  3 Mar 2026 12:49:40 +0100 (CET)
Received: from mail.kernel-space.org (unknown
 [IPv6:2a03:4000:b:d08:14a9:1bff:fedc:75ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97A958063E
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 12:49:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1772538577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v9CLiZaaVKT4mnnTj2XZZuXB/RS8uL98DpP8KQ/SJK4=;
 b=Dol5DrbEPQxSEIOr30s5yTW42GUI0X+p9EE5ph04WmAMRhlDVY0fZhedcgHmWAKFNRY/tZ
 UhAFsUHYLGV04IW16WpDJJmGHd+k+PLyHggnNiWk/s1BxlbureHlAzUDQV+GkekJ+Z/N8K
 c11ONViBylujuRZ4G6ohzyvuu3Md9tQ=
Received: from [IPV6:2a07:7e81:7daa:0:62cf:84ff:feee:627] (<unknown>
 [2a07:7e81:7daa:0:62cf:84ff:feee:627])
 by oreshnik (OpenSMTPD) with ESMTPSA id 93b7b5c8
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Tue, 3 Mar 2026 11:49:37 +0000 (UTC)
Message-ID: <3474cea2-eb92-40ed-8f01-6b36f5c7b472@kernel-space.org>
Date: Tue, 3 Mar 2026 12:53:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/17] m68k: Call bootm_final()
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Alison Wang <alison.wang@nxp.com>, Angelo Dureghello <angelo@sysam.it>,
 Kuan-Wei Chiu <visitorckw@gmail.com>
References: <20260228202011.1834493-1-sjg@chromium.org>
 <20260228202011.1834493-14-sjg@chromium.org>
Content-Language: en-US, it
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <20260228202011.1834493-14-sjg@chromium.org>
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

Hi Simon,

after rebasing to master, applying this i get:

+arch/m68k/lib/bootm.c:68:9: error: implicit declaration of function 'bootm_final'; did you mean 'bootm_init'? [-Werror=implicit-function-declaration

Am i missing something ?

Thanks
angelo

On 2/28/26 21:20, Simon Glass wrote:
> From: Simon Glass <simon.glass@canonical.com>
> 
> Add a call to bootm_final() before jumping to the kernel. This adds
> the "Starting kernel" message, bootstage tracking,
> board_quiesce_devices() and dm_remove_devices_active() which were not
> previously called on m68k.
> 
> Signed-off-by: Simon Glass <simon.glass@canonical.com>
> 
> ---
> 
> Changes in v3:
> - Add new patch for m68k conversion
> 
>  arch/m68k/lib/bootm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/m68k/lib/bootm.c b/arch/m68k/lib/bootm.c
> index 3dcff8076e3..7e36ac73169 100644
> --- a/arch/m68k/lib/bootm.c
> +++ b/arch/m68k/lib/bootm.c
> @@ -65,6 +65,8 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
>  
>  	bootstage_mark(BOOTSTAGE_ID_RUN_OS);
>  
> +	bootm_final(0);
> +
>  	/*
>  	 * Linux Kernel Parameters (passing board info data):
>  	 *   sp+00: Ignore, side effect of using jsr to jump to kernel

-- Angelo

