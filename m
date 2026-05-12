Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6580ACD4F24
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 16:44:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA13D838BB;
	Tue, 12 May 2026 18:44:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j2VenFBh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EE9C83C51; Tue, 12 May 2026 18:44:28 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39BE8836AC
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 18:44:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ernestvanhoecke@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488d2079582so61000115e9.2
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 09:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778604264; x=1779209064; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=es2LrMGCJrPNtp2WurGRZmsEjGrsixp2fF0B+UT94eE=;
 b=j2VenFBhHmWX/K1nQF1qjGbpNs6Ndnyzy2Mf3JA9hdr8b6ezcrIQs7JC7Mdbmw3nvG
 4dsWMSTN6NTRWxzchNvYcC6e2wQaZt2F55DRvoop3e1e0M+c5HJFfafYg6ytn6jGpk9l
 wD1Bk4jjL3WjnXybaWbIYQGTZQc/q6d1njYaBubfkWqa/4mY+rbOFGRuJHhMJXsnJ5mW
 hJTCWpZ8pSIK3A6HPHDW0PQ7vHZ35J5Ya4QDDM/Njjb6fBmFMIi7xYMD8H8vTfq935df
 Rd4HMyOprLeUhHZbNj40Kc9pBM33TJGxB2D4B2DrFJz36ZAzfZ0TPEthhi/2vAunRjfZ
 T6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778604264; x=1779209064;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=es2LrMGCJrPNtp2WurGRZmsEjGrsixp2fF0B+UT94eE=;
 b=LRBtwHfiDENoHiczz7+wqlr/JDKMlvjmhCEEeA5OK1/Ese6lEVBLuoZYBnftcZlStB
 HzF49HxvSkaVoTtots2m6H7fIZvMBzcQPPHQUH2z7MLGtLypyIBuu8S0JdK4DnaGmr5b
 +zisjD7TSvhnR6tpgQlqhqNkBfCNgSubLpwP5i3rt3iJKiKzrKPYbByoc4QkUVL91F/w
 RFSwg54LJrO9OP69yIbXypb/AtYVgUW2AJSdQy+z7w9Jg3tc/O3YFBpckDhXccvN4ud+
 /o+RdVJR/S6IhQYVVUKQAkRKdNNzS5Gq1RtiWee/GtQZzRrv134rcdbJakE95HsWae3d
 dQcw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8HzWAHQTO7MBCS3xybrjGFcL2AlaXAammlsl0tUth+cxrivVvz8QYrajBdndn1YWfqrdkzljg=@lists.denx.de
X-Gm-Message-State: AOJu0Yz32SaFakzdyISkO0K7CNxNM0C8HB7tJwiu0vxEkQvB1Hwa9YZm
 rjku+SPj1PZCfBlC5tqx1TTo2Z/lA3PzRzJ2e0tsuUUEOOFPn3Y11Z+r
X-Gm-Gg: Acq92OGQrcAjTjlK/gi9vsc298Xdxh2bti2QlJFQwozSdi0O0oCAuC9yw3M+BK8iBTB
 R3zKBkheiI8jTJ3S+EV68Kb9PE7vfRUpwUiYMjr8aZmfH2D0Bl4pzEb7El+bCi0HMAhG61XzSab
 z92jKITIlxSFCF3nckKSOedN4sknF1DwW6v7eiCLUnTqgWUNV2ENGM8jpn8aEsgVdpJ7iHlp5Ns
 UdncfocxUPVJPr/AR4poxDzZvsdNFPfjb/3OAFb+Rf5wsWbX45NOoF2DG1mihNHTvAHVLqVVulX
 DYgeDb6Cye6Rq3XkvXX4sZnf2biApJ/i8hU1Ek45nkIuM5chJ0VrM63Y4yR8As0KhcWkIQhc738
 zTjdCBuy2sW1M783XyLeJxdTTyKmUBn/0h6SBmmCa019qb6XDDKzwJpZH3OmbHsWS5nSgllpLeK
 8y1ii8cqX0IleWeI61vJ0QmVcS8GjMZ1GX1uaUgVdGArVUF7ivhmmJbTxcA7Luj8YoobnNLgoHZ
 MYOPEoA4i1Qk2pTrXqOBxHZzNg=
X-Received: by 2002:a05:600c:3ba7:b0:48a:7772:c26b with SMTP id
 5b1f17b1804b1-48e51f40884mr513114445e9.26.1778604264348; 
 Tue, 12 May 2026 09:44:24 -0700 (PDT)
Received: from ernest.hoecke-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f3f5174sm33665205e9.5.2026.05.12.09.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 09:44:23 -0700 (PDT)
Date: Tue, 12 May 2026 18:44:22 +0200
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
To: Shiva Tripathi <s-tripathi1@ti.com>
Cc: trini@konsulko.com, vigneshr@ti.com, bb@ti.com, u-boot@lists.denx.de, 
 u-kumar1@ti.com, praneeth@ti.com, kamlesh@ti.com, vishalm@ti.com, 
 k-malarvizhi@ti.com, afd@ti.com, anshuld@ti.com
Subject: Re: [PATCH v2] arm: k3: Kconfig: Enable fTPM and RPMB support
Message-ID: <momeoh6chz4swvgj3oj36p57os2cejpbcx37qyc7f3pydvwdlt@gaucmqmtpjso>
References: <20260225112438.1035185-1-s-tripathi1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225112438.1035185-1-s-tripathi1@ti.com>
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

On Wed, Feb 25, 2026 at 04:54:38PM +0530, Shiva Tripathi wrote:
> Enable firmware TPM (fTPM) support via OP-TEE for K3 platforms with
> MMC hardware. This provides TPM 2.0 functionality through
> Microsoft's fTPM Trusted Application running in OP-TEE secure world,
> using eMMC RPMB as persistent storage.
> 
> fTPM support in U-Boot provides the foundation for measured boot
> and disk encryption use cases.
> 
> The ARM64 condition ensures these apply only to A53/A72 cores and the
> MMC condition ensures fTPM is enabled only on platforms with eMMC
> hardware support.
> 
> Signed-off-by: Shiva Tripathi <s-tripathi1@ti.com>
> ---
> Changes in v2:
> - Moved fTPM enablement from per-board defconfig files to common Kconfig
> - Added configs to ARCH_K3 (arch/arm/Kconfig) to enable for all K3 platforms
> - Added command configs to TI_COMMON_CMD_OPTIONS (board/ti/common/Kconfig)
> - Added MMC dependency to address concern about boards without eMMC hardware
> - Link to v1: https://lore.kernel.org/all/20260223091314.586968-1-s-tripathi1@ti.com/
> 
> ---
>  arch/arm/Kconfig        | 3 +++
>  board/ti/common/Kconfig | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 5508fce796a..eb83b5c35f1 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -834,6 +834,9 @@ config ARCH_K3
>  	imply DM_RNG if ARM64
>  	imply TEE if ARM64
>  	imply OPTEE if ARM64
> +	imply TPM if ARM64 && MMC
> +	imply TPM2_FTPM_TEE if ARM64 && MMC
> +	imply SUPPORT_EMMC_RPMB if ARM64 && MMC
>  
>  config ARCH_OMAP2PLUS
>  	bool "TI OMAP2+"
> diff --git a/board/ti/common/Kconfig b/board/ti/common/Kconfig
> index 409454813f3..149909093b3 100644
> --- a/board/ti/common/Kconfig
> +++ b/board/ti/common/Kconfig
> @@ -61,4 +61,6 @@ config TI_COMMON_CMD_OPTIONS
>  	imply CMD_SPL
>  	imply CMD_TIME
>  	imply CMD_USB if USB
> +	imply CMD_TPM if TPM
> +	imply CMD_OPTEE_RPMB if OPTEE && SUPPORT_EMMC_RPMB
>  
> -- 
> 2.34.1
> 

Hi Shiva,

Do these changes mean you expect any K3-based board to follow by
building OP-TEE with RPMB support (and in production provisioning an
authentication key on first boot) now?

I'm asking because we noticed errors in the below form appeared during
boot of our Verdin AM62P and Aquila AM69 now:
E/LD:  Status of TA bc50d971-d4c9-42c4-82cb-343fb7f37896
E/LD:   arch: aarch64
E/LD:  region  0: va 0x40005000 pa 0x9e900000 size 0x002000 flags rw-s (ldelf)
E/LD:  region  1: va 0x40007000 pa 0x9e902000 size 0x008000 flags r-xs (ldelf)
E/LD:  region  2: va 0x4000f000 pa 0x9e90a000 size 0x001000 flags rw-s (ldelf)
E/LD:  region  3: va 0x40010000 pa 0x9e90b000 size 0x004000 flags rw-s (ldelf)
E/LD:  region  4: va 0x40014000 pa 0x9e90f000 size 0x001000 flags r--s
E/LD:  region  5: va 0x40015000 pa 0x9e980000 size 0x011000 flags rw-s (stack)
E/LD:  region  6: va 0x4005a000 pa 0x9e910000 size 0x055000 flags r-xs [0]
E/LD:  region  7: va 0x400af000 pa 0x9e965000 size 0x01b000 flags rw-s [0]
E/LD:   [0] bc50d971-d4c9-42c4-82cb-343fb7f37896 @ 0x4005a000
E/LD:  Call stack:
E/LD:   0x4005b7b0
E/LD:   0x4008f220
E/LD:   0x40083298

Interestingly this did not appear on our Verdin AM62 SoM.

Of course, we can simply disable the fTPM until our support improves, or
ignore this error if it is harmless, but I wanted to ask about your
intentions before digging much deeper.

Thanks!

Kind regards,
Ernest

