Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE89606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 06:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XgIABiCl;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j30TNnSj
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E7B3180BD3;
	Tue, 27 Oct 2026 06:32:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qXNLgZT0cyHv; Tue, 27 Oct 2026 06:32:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B801F80BE2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793082760;
	b=a+jBAoncGx5AurCELyiZBGy5XVGCMALezGgGoDw5HK5ixrQ+q27ERZTicb5U30m5Hnrr
	 zIA3IEd1rUTCcKqF2UmAlixYhSAjGkMylUVlfQY2J4uFFWfDBqCd/IWH0uCDDf+hJ1aa7
	 UX+kD1bGcJ0Ays9+HRFD11ap8OjZk/6xYqW+Vz1EJvF/gv5n9/nkLJoSmZ19zjVHl7CxS
	 J6N8Zt7/Fgg+3654McwAY0Y/W8yIQsdx/u3EMVYm0rxJfU2nytxgNt8aUg+W294vWjhyk
	 4qLtA7afBzG5e+eQMbMnTPaC5ZW3THh4DttMUOyuWikYahqb3MmR8/83IdVKLxPhsGg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793082760;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=d9MixPv/GbxGvz2MmuqXXA7Vu9dtPqNuh79aS3w3UlQ=;
	b=rxZBrcR9cRVOOjFcCOlHaQ/xWJeKFdQzY3iZbV1XDIcnzj3pahY1lFfueBMzouIKrkmj
	 X8SpNkNC9iIU82qo1kJ52K8RfcoJs0FbFDOQZOXDff0HGLJN5VTAOVmYKUi1fck23Hmge
	 XQ++2hmat+XIbnmVOxm/c6+MvePv3NEUZ/gnpAcVNcBZEsdRakEWWMf1nza/nRnBuliOq
	 HODkhKSRx+LUPZgYEbN3eb1sVUEqEdvEHa6vDh5v2aZlyI3KXiDASgmP7ahKhsGiO1jtt
	 k1Er8Q9ti3G2nJmvBJnPJcUtdNENUfOmnREYPXNuIv6YJ0FsEUjs7cF4YtA2vglYdMQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793082760;
	bh=d9MixPv/GbxGvz2MmuqXXA7Vu9dtPqNuh79aS3w3UlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XgIABiCl3iNTauggr+5NTG/gedpaFq2yIwWW+6TyDWqBgbIcNtTcPb2jBKiZjuvQt
	 6BabbetqPsSGy2hXwtLO5jr+az/tf6ABw942bfIh6t+Q6ZEU/OW9yekhtruWSiTgSH
	 kvScmbKA4/5J/zkwj+urNQoRW65BEIJQ5pS8KSGy5o3HO1umvuWesLZfLm7RHCuYxQ
	 Ahw/rPIhA/wVAbEaBtphABQXGm5xYbyUhQjYU2n8rsL2ksPmbzxhHtBoQnhBLFTmKM
	 IdrNrQB+mowSP7OwImmbacuAddukxZpDaQgrXVi6gKS79W7n0Dsbi7UvpGweduBHr2
	 HrNB3n/AossxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B801F80BE2;
	Tue, 27 Oct 2026 06:32:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 19B55120
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 06:32:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0B9C240062
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 06:32:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7MXEfxwN7TA1 for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 06:32:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E0889400A8
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1032"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793082758;
 b=atfKrR2BsrRp6rWH6dAD4V5kQ1Ex/j0yQ4PJoQMCParBejDM8TcFnile2GsWG2v96qEb
 sNCNd4L8+wO/J/iYoGY26sRT7ch6KaAPQqSGFwn21mH6EeoXdkR57jd9naUUfplPu9YJ+
 Bly6txrWBf+d6Q0Zy9w/xBsqEw15tNyhLeOCWD1Uyexn7o4mDAgKQb3VYsWrA/GG6NhF5
 nGQch0yqA6XgJl5aHC3F85vWdr3wyx16aP5HidrjCPevqLPjoxdbbWjpTWN+bGBKG8qeu
 UFgLLcXGBDGTGnMlxmJ19gH5bocTIGx/l4S2901SYzotq3rcncb+tiJVxVteiFkInWg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793082758;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=d9MixPv/GbxGvz2MmuqXXA7Vu9dtPqNuh79aS3w3UlQ=;
 b=dy+ipfoz16nWp9EzuSoSiTh6e6yQFKxEuROnJ6AtThIRvAOcPT5D6uNLvOKoQ/4piB3I
 7L+mGUApmVI7wCXXwa1neznJwCqhbPmX48X4uovMTcJrR+aI+QzXM7KC8Jj8Zo5ypZJhV
 FRRlXzHfv77xNOsIN3aE3TF81gB9GtAtMEUMQ3sKkeSEeNVIVrIDqoHLK8tGbV1eGpnLv
 3ZmarE0FlqenpiWtS78LUvACXyKkmX3RZvDiNboF/5jC1/uh2Y4b2qUlpUKCw3aQ0F80d
 IypDne0pARgZ7WDrC7o/JAXUwqiozYD5nzQBtMImlCNVmMZ4v0eC+qN/QYUaXlz0zdg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=j30TNnSj; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1032"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=j30TNnSj
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E0889400A8
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 06:32:37 +0000 (UTC)
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3ac9f49b984so399775a91.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 23:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793082757; x=1793687557;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=d9MixPv/GbxGvz2MmuqXXA7Vu9dtPqNuh79aS3w3UlQ=;
 b=j30TNnSj/8lbhrQbgDNyImTEFdZMinbBNTB5caALhuHVxv8MieZEHMzp1/MA34GmNh
 ypcFoiREUfT2FnKpOlu+alrHij9/JspbBKt8Vqntly7LHgCLbNJT1hinuXQkXXnDcw4V
 51A20DV4BRaOZpfcYO0o+oALwazNqLzPSCPabGHtZ36LDUcl/T6EgAXonqzUQQjye48w
 /I0BOB4+Rh3hjM7ojb6G7Cb244XSgMqJMpJxneJPdxm25JmYaOHNUsNepehhPTBsK0RR
 v69LgWMe17ZJMPC4rXpNSdpH9HnwAZVQyj0WNrteMna8Q1zixA4d5EPdSbakwhVuEFsJ
 SlgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793082757; x=1793687557;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d9MixPv/GbxGvz2MmuqXXA7Vu9dtPqNuh79aS3w3UlQ=;
 b=a8/1GZf9+HaCR92Ki4I2YSJVBy8AS6mLs20jq8lVhESEqCnjW9EKN0YkIQTwjLukHU
 OWqlVixJOZyvbYVgGDVrU93iriuA4+7xdnbG0fnDvbLugN+wtPUf7wP/bZEI0+G5V5xj
 j7wEVDG0+ccRZyyCkhG0mpNZ9JXfGkSh+xxwTiSxp909XnPWrGvElO5au49VhhDXQqQN
 s2ig+Jp+nNnPu92hvMclp2U3luzWc4OQE3pVWWuiyGQbRylNd7dHP4llEP5i2X9+UIUQ
 J+pKDhFhHSiONGgnbWDtzpHSDHtLaVp9JqyExW4SJwG+BOfmGqGCpK/bKHPfb5DCFbgP
 8cKw==
X-Gm-Message-State: AFq9FYKNql3yXC+hCzRWrw2FFZc8jsglUjXhbntnwVbdeWA7hw6ijEI5
 XPkXirLFtwzicKwsVmJgOG2pPJblOiGrzJ5Agi+NVKtlyDdrKs6N1/GKAFZBsw==
X-Gm-Gg: AYBFou3svgbyjL55P5fRwx9QnKk1cIlGjosPjh1+El1bcWPzAMBu0KWpMqH7lsn04vn
 gyeRTbeEvk5biwRHWpWIVGg/0+pYZ840BDGAvYXL1/20F+IjKvk4NpOyqSDdepYONh8cQXJqSVY
 mnQyF1CUV25igMafp9QhOZzJk0ff69eiQS9t/vG8GUzTNzmTfUqGKjbZVcbZ+gXQ7bQf3Gedjr0
 yo8wx9c9tORtWPP5BPxfRSS6fa9hwouSvpFjHaPRFmUHjvEgJ+yafwB1q5tTH+VDYLtqkZ+4kfd
 PuwQD3lKbMItQp4kTjIO7J5m1hVWwghtGvpORmc13LM088SVTbLnE3P9v2G3H19o7nIGu/Egw+f
 jG6ahvtuKUd7o4XsJyE3lOO8ptKS8Xs84muvNe2+F1smXw5tB5KEh8/7orIjVeodeamIf3r154f
 s4McsSubgZ8zySjPxZoP8CeRr3wUg31v6qE0zMBn+m5pigFL7JYAW4FJGbsq/H20bZya24W3nHX
 Yo9MhOcnaVGi3j+HUJDScHbkDBAy7rOEumFQivX4eccFhlo0X5/dSCL/444FLKKB90Tg2bLfXFg
 zVByqKvp5qsZFI7Zt1etDoBov3HQwOziCSY=
X-Received: by 2002:a17:90b:4984:b0:3a8:c3b9:4b38 with SMTP id
 98e67ed59e1d1-3ae403dc500mr1165572a91.14.1793082756803; 
 Mon, 26 Oct 2026 23:32:36 -0700 (PDT)
Received: from google.com ([2a00:79e0:2039:4:1f3b:75d3:73bb:cec])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd8ccc666d1sm2194758a12.16.2026.10.26.23.32.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 23:32:36 -0700 (PDT)
Date: Tue, 27 Oct 2026 14:32:32 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: u-boot@lists.u-boot-project.org, bmeng.cn@gmail.com, trini@konsulko.com,
 sjg@chromium.org, xypron.glpk@gmx.de
Subject: Re: [PATCH v4 1/5] virtio: rtc: Add virtio RTC driver
Message-ID: <auBFgPWluma_Sjbq@google.com>
References: <20261021110706.2947351-1-alan.tseng.cs@gmail.com>
 <20261021110706.2947351-2-alan.tseng.cs@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021110706.2947351-2-alan.tseng.cs@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 07:07:02PM +0800, Hung-Chun Tseng wrote:
> QEMU provides a virtio RTC device (virtio-rtc-pci, virtio-rtc-device)
> since v11.1.0, but U-Boot has no driver for it.
> 
> The virtqueue must not be used before the virtio uclass sets DRIVER_OK,
> which happens after probe(), so the clock is looked up on the first read.
> 
> Like Linux, the driver prefers a VIRTIO_RTC_CLOCK_UTC_SMEARED clock, as
> it never steps on leap seconds. QEMU master reports such a clock since
> "virtio-rtc: Report smeared UTC clock type", but v11.1 reports
> VIRTIO_RTC_CLOCK_UTC, so the driver falls back to another UTC clock
> rather than leave U-Boot without an RTC there.
> 
> The set of clocks never changes, so if none of them is UTC, the driver
> remembers it and fails later reads at once.
> 
> Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Regards,
Kuan-Wei

> ---
> Changes in v4:
> - Cut the commit message down to why the driver works as it does
>   (Kuan-Wei)
> - Say that QEMU master now reports a smeared UTC clock and that the
>   fallback is for v11.1 (Kuan-Wei)
> - Drop the comment on giving up after a failed request, which is plain
>   error handling (Kuan-Wei)
> 
> Changes in v3:
> - Give up on a request after one second instead of polling forever
>   (Kuan-Wei)
> - Remember that no clock is UTC, so that later reads fail at once
>   (Simon)
> - Expand the VIRTIO_RTC help text (Simon)
> - Drop __packed from the message structs, which are naturally aligned
>   (Kuan-Wei)
> - Prefer a VIRTIO_RTC_CLOCK_UTC_SMEARED clock as Linux does, fall back
>   to the first other UTC clock, and explain why in the commit message
>   (Kuan-Wei)
> - Stop looking for a clock as soon as a request fails, as Linux does
>   (Kuan-Wei)
> - Mention in the commit message that sandbox tests follow (Simon)
> 
> Changes in v2:
> - Look for the UTC clock on the first virtio_rtc_get() instead of in
>   probe(), as the virtqueue must not be used before DRIVER_OK (Bin)
> 
>  drivers/virtio/Kconfig         |  11 ++
>  drivers/virtio/Makefile        |   1 +
>  drivers/virtio/virtio-uclass.c |   1 +
>  drivers/virtio/virtio_rtc.c    | 244 +++++++++++++++++++++++++++++++++
>  include/virtio.h               |   4 +-
>  5 files changed, 260 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/virtio/virtio_rtc.c
> 
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 55b444280..48ab669f3 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -84,4 +84,15 @@ config VIRTIO_9P
>  	help
>  	  This enables the 9P transport driver over virtio.
>  	  It can be used with QEMU based targets.
> +
> +config VIRTIO_RTC
> +	bool "virtio RTC driver"
> +	depends on DM_RTC
> +	depends on VIRTIO
> +	default y
> +	help
> +	  This enables the virtio RTC driver, which reads the UTC clock
> +	  exposed by a virtio RTC device. QEMU v11.1.0 or later provides
> +	  it as virtio-rtc-pci and virtio-rtc-device. The clocks are
> +	  read-only, so the time cannot be set.
>  endmenu
> diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
> index 6e7bcfc8e..ddb5ce4eb 100644
> --- a/drivers/virtio/Makefile
> +++ b/drivers/virtio/Makefile
> @@ -12,3 +12,4 @@ obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
>  obj-$(CONFIG_VIRTIO_BLK) += virtio_blk.o
>  obj-$(CONFIG_VIRTIO_RNG) += virtio_rng.o
>  obj-$(CONFIG_VIRTIO_9P) += virtio_9p.o
> +obj-$(CONFIG_VIRTIO_RTC) += virtio_rtc.o
> diff --git a/drivers/virtio/virtio-uclass.c b/drivers/virtio/virtio-uclass.c
> index c163b2fd7..c6cf55922 100644
> --- a/drivers/virtio/virtio-uclass.c
> +++ b/drivers/virtio/virtio-uclass.c
> @@ -31,6 +31,7 @@ static const char *const virtio_drv_name[VIRTIO_ID_MAX_NUM] = {
>  	[VIRTIO_ID_BLOCK]	= VIRTIO_BLK_DRV_NAME,
>  	[VIRTIO_ID_RNG]		= VIRTIO_RNG_DRV_NAME,
>  	[VIRTIO_ID_9P]		= VIRTIO_9P_DRV_NAME,
> +	[VIRTIO_ID_CLOCK]	= VIRTIO_RTC_DRV_NAME,
>  };
>  
>  int virtio_get_config(struct udevice *vdev, unsigned int offset,
> diff --git a/drivers/virtio/virtio_rtc.c b/drivers/virtio/virtio_rtc.c
> new file mode 100644
> index 000000000..f164c75e0
> --- /dev/null
> +++ b/drivers/virtio/virtio_rtc.c
> @@ -0,0 +1,244 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026, Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> + *
> + * Driver for the virtio RTC device (virtio device ID 17). The device
> + * exposes one or more read-only clocks through a request virtqueue; this
> + * driver reads a UTC clock, preferring one which smears leap seconds, and
> + * reports it through the RTC uclass.
> + */
> +
> +#include <div64.h>
> +#include <dm.h>
> +#include <log.h>
> +#include <rtc.h>
> +#include <time.h>
> +#include <virtio_types.h>
> +#include <virtio.h>
> +#include <virtio_ring.h>
> +#include <linux/types.h>
> +
> +#define VIRTIO_RTC_TIMEOUT_MS		1000
> +
> +#define VIRTIO_RTC_REQ_READ		0x0001
> +#define VIRTIO_RTC_REQ_CFG		0x1000
> +#define VIRTIO_RTC_REQ_CLOCK_CAP	0x1001
> +
> +#define VIRTIO_RTC_S_OK			0
> +
> +#define VIRTIO_RTC_CLOCK_UTC			0
> +#define VIRTIO_RTC_CLOCK_UTC_SMEARED		3
> +#define VIRTIO_RTC_CLOCK_UTC_MAYBE_SMEARED	4
> +
> +struct virtio_rtc_req_head {
> +	__le16 msg_type;
> +	u8 reserved[6];
> +};
> +
> +struct virtio_rtc_resp_head {
> +	u8 status;
> +	u8 reserved[7];
> +};
> +
> +/* Request for VIRTIO_RTC_REQ_READ and VIRTIO_RTC_REQ_CLOCK_CAP */
> +struct virtio_rtc_req_clock {
> +	struct virtio_rtc_req_head head;
> +	__le16 clock_id;
> +	u8 reserved[6];
> +};
> +
> +struct virtio_rtc_resp_read {
> +	struct virtio_rtc_resp_head head;
> +	__le64 clock_reading;
> +};
> +
> +struct virtio_rtc_resp_cfg {
> +	struct virtio_rtc_resp_head head;
> +	__le16 num_clocks;
> +	u8 reserved[6];
> +};
> +
> +struct virtio_rtc_resp_clock_cap {
> +	struct virtio_rtc_resp_head head;
> +	u8 type;
> +	u8 leap_second_smearing;
> +	u8 flags;
> +	u8 reserved[5];
> +};
> +
> +struct virtio_rtc_priv {
> +	struct virtqueue *vq;
> +	u16 clock_id;
> +	bool clock_found;
> +	bool no_utc_clock;
> +};
> +
> +static int virtio_rtc_xfer(struct udevice *dev, void *req, size_t req_len,
> +			   void *resp, size_t resp_len)
> +{
> +	struct virtio_rtc_priv *priv = dev_get_priv(dev);
> +	struct virtio_rtc_resp_head *head = resp;
> +	struct virtio_sg req_sg = { req, req_len };
> +	struct virtio_sg resp_sg = { resp, resp_len };
> +	struct virtio_sg *sgs[] = { &req_sg, &resp_sg };
> +	unsigned int len;
> +	ulong start;
> +	int ret;
> +
> +	ret = virtqueue_add(priv->vq, sgs, 1, 1);
> +	if (ret)
> +		return ret;
> +
> +	virtqueue_kick(priv->vq);
> +
> +	start = get_timer(0);
> +	while (!virtqueue_get_buf(priv->vq, &len)) {
> +		if (get_timer(start) > VIRTIO_RTC_TIMEOUT_MS)
> +			return -ETIMEDOUT;
> +	}
> +
> +	if (len < sizeof(*head) || head->status != VIRTIO_RTC_S_OK)
> +		return -EIO;
> +
> +	if (len < resp_len)
> +		return -EPROTO;
> +
> +	return 0;
> +}
> +
> +static bool virtio_rtc_is_utc(u8 type)
> +{
> +	return type == VIRTIO_RTC_CLOCK_UTC ||
> +	       type == VIRTIO_RTC_CLOCK_UTC_SMEARED ||
> +	       type == VIRTIO_RTC_CLOCK_UTC_MAYBE_SMEARED;
> +}
> +
> +static int virtio_rtc_find_utc_clock(struct udevice *dev)
> +{
> +	struct virtio_rtc_priv *priv = dev_get_priv(dev);
> +	struct virtio_rtc_req_head cfg_req = {
> +		.msg_type = cpu_to_le16(VIRTIO_RTC_REQ_CFG),
> +	};
> +	struct virtio_rtc_resp_cfg cfg = {};
> +	u16 num_clocks, id, utc_id = 0;
> +	bool utc_found = false;
> +	int ret;
> +
> +	ret = virtio_rtc_xfer(dev, &cfg_req, sizeof(cfg_req), &cfg, sizeof(cfg));
> +	if (ret)
> +		return ret;
> +
> +	num_clocks = le16_to_cpu(cfg.num_clocks);
> +	for (id = 0; id < num_clocks; id++) {
> +		struct virtio_rtc_req_clock req = {
> +			.head.msg_type = cpu_to_le16(VIRTIO_RTC_REQ_CLOCK_CAP),
> +			.clock_id = cpu_to_le16(id),
> +		};
> +		struct virtio_rtc_resp_clock_cap cap = {};
> +
> +		ret = virtio_rtc_xfer(dev, &req, sizeof(req), &cap, sizeof(cap));
> +		if (ret)
> +			return ret;
> +
> +		/*
> +		 * Like Linux, prefer a clock which smears leap seconds, but fall
> +		 * back to another UTC clock, which is all that QEMU v11.1 has.
> +		 */
> +		if (cap.type == VIRTIO_RTC_CLOCK_UTC_SMEARED) {
> +			utc_id = id;
> +			utc_found = true;
> +			break;
> +		}
> +
> +		if (!utc_found && virtio_rtc_is_utc(cap.type)) {
> +			utc_id = id;
> +			utc_found = true;
> +		}
> +	}
> +
> +	/* The set of clocks is fixed, so remember that none of them is UTC */
> +	if (!utc_found) {
> +		priv->no_utc_clock = true;
> +		return -ENODEV;
> +	}
> +
> +	priv->clock_id = utc_id;
> +	priv->clock_found = true;
> +
> +	return 0;
> +}
> +
> +static int virtio_rtc_get(struct udevice *dev, struct rtc_time *time)
> +{
> +	struct virtio_rtc_priv *priv = dev_get_priv(dev);
> +	struct virtio_rtc_req_clock req = {
> +		.head.msg_type = cpu_to_le16(VIRTIO_RTC_REQ_READ),
> +	};
> +	struct virtio_rtc_resp_read resp = {};
> +	u64 now;
> +	int ret;
> +
> +	/*
> +	 * The virtqueue must not be used before DRIVER_OK, which the virtio
> +	 * uclass sets only after probe(), so look for the clock on first use.
> +	 */
> +	if (priv->no_utc_clock)
> +		return -ENODEV;
> +
> +	if (!priv->clock_found) {
> +		ret = virtio_rtc_find_utc_clock(dev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	req.clock_id = cpu_to_le16(priv->clock_id);
> +
> +	ret = virtio_rtc_xfer(dev, &req, sizeof(req), &resp, sizeof(resp));
> +	if (ret)
> +		return ret;
> +
> +	now = le64_to_cpu(resp.clock_reading);
> +	do_div(now, 1000000000U);
> +	rtc_to_tm(now, time);
> +
> +	return 0;
> +}
> +
> +static int virtio_rtc_bind(struct udevice *dev)
> +{
> +	struct virtio_dev_priv *uc_priv = dev_get_uclass_priv(dev->parent);
> +
> +	/* The alarm feature is not supported */
> +	virtio_driver_features_init(uc_priv, NULL, 0, NULL, 0);
> +
> +	return 0;
> +}
> +
> +static int virtio_rtc_probe(struct udevice *dev)
> +{
> +	struct virtio_rtc_priv *priv = dev_get_priv(dev);
> +	int ret;
> +
> +	ret = virtio_find_vqs(dev, 1, &priv->vq);
> +	if (ret < 0) {
> +		debug("%s: virtio_find_vqs failed\n", __func__);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct rtc_ops virtio_rtc_ops = {
> +	.get	= virtio_rtc_get,
> +};
> +
> +U_BOOT_DRIVER(virtio_rtc) = {
> +	.name	= VIRTIO_RTC_DRV_NAME,
> +	.id	= UCLASS_RTC,
> +	.bind	= virtio_rtc_bind,
> +	.probe	= virtio_rtc_probe,
> +	.remove	= virtio_reset,
> +	.ops	= &virtio_rtc_ops,
> +	.priv_auto	= sizeof(struct virtio_rtc_priv),
> +	.flags	= DM_FLAG_ACTIVE_DMA,
> +};
> diff --git a/include/virtio.h b/include/virtio.h
> index b981eead5..95069a2de 100644
> --- a/include/virtio.h
> +++ b/include/virtio.h
> @@ -32,12 +32,14 @@
>  #define VIRTIO_ID_BLOCK		2 /* virtio block */
>  #define VIRTIO_ID_RNG		4 /* virtio rng */
>  #define VIRTIO_ID_9P		9 /* virtio 9p */
> -#define VIRTIO_ID_MAX_NUM	10
> +#define VIRTIO_ID_CLOCK		17 /* virtio clock/timer (rtc) */
> +#define VIRTIO_ID_MAX_NUM	18
>  
>  #define VIRTIO_NET_DRV_NAME	"virtio-net"
>  #define VIRTIO_BLK_DRV_NAME	"virtio-blk"
>  #define VIRTIO_RNG_DRV_NAME	"virtio-rng"
>  #define VIRTIO_9P_DRV_NAME	"virtio-9p"
> +#define VIRTIO_RTC_DRV_NAME	"virtio-rtc"
>  
>  /* Feature bits for virtio 9P */
>  #define VIRTIO_9P_MOUNT_TAG	0
> -- 
> 2.43.0
> 
