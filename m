Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63CCECF9C69
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 14:05:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31FD788B1C;
	Sat, 21 Sep 2024 16:05:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1726927522;
	bh=gLc6wAHrrB2oHrpGzYrSZhAgtKFmFg43fq+C6U9CyFI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n1ZuJITF0mnVd04dyB9PwSk8f7jLT2GZLWW4aV+B+Gc5JJ9U4CtRecdKOerZHLDsv
	 evtCEXdm4hkMcONrtWAZ3TPUeN5s5yEcIwEJIC7smGscTfX/osI7cfG9lzcqhDLdq6
	 ML24KgP70CQxGdDW47CQswJ4gMVv//53687BWHr55C8EYiI+jpBjTWxu7K73f+A0K8
	 RkD+4y8YCD+2y8BSdJzBYnzG5/Ioi5K4Ebwo/64cF1HddJ7jdlQWBnCWdgJ5Q2SZuq
	 9UWMaCLpLKhg1nCZEq2mMGTgtqPoyVACbYksedGZpJcshqniyds3OKa4573QH/1Awo
	 7Rw4ndNrGILZw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9BC4A88A9D;
 Sat, 21 Sep 2024 16:05:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1726927520;
 bh=gLc6wAHrrB2oHrpGzYrSZhAgtKFmFg43fq+C6U9CyFI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ZOd6lv2fuOkVPRjdwGbB2zjAgUaPTzKV1vzyDy8xC1SRrQtn9zwbzFuE7GepVqp33
 yY6quc4ubt1MV2Olyg2cTrdjbkNDNDyBq+rMrHC+Pk+nEh1+Z2hO9mtHZoutH8rKnm
 n2DycRTf7c1AIJFzWJgHtj3LVHjRTX0kM9oJYybmXVEw8DHRUzj01o0800BUNhw2mB
 Btctyaok+c0a6/BG3EBKeXIab/G5XCob+jXPP+7Vy0jLijtykETRCZB0eJv3Rb4k/n
 DTeE1z119ktE7cWMVrz42S6UOekaX1rcEfNoVq+H0Y4Xpnw6i3uurAlMCKTq8d8c8q
 K+4Ego4XMDi0g==
Message-ID: <9cc437c8-59dc-4e78-82d4-8ef479ca9ba1@denx.de>
Date: Sat, 21 Sep 2024 15:49:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/20] arm: socfpga: agilex5: Add low level
 initialization
To: tien.fong.chee@intel.com, u-boot@lists.denx.de
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Meng Tingting <tingting.meng@intel.com>,
 Yuslaimi Alif Zakuan <alif.zakuan.yuslaimi@intel.com>,
 Hea Kok Kiang <kok.kiang.hea@intel.com>
References: <20240920070242.20884-1-tien.fong.chee@intel.com>
 <20240920070242.20884-5-tien.fong.chee@intel.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240920070242.20884-5-tien.fong.chee@intel.com>
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

On 9/20/24 9:02 AM, tien.fong.chee@intel.com wrote:
> From: Tien Fong Chee <tien.fong.chee@intel.com>
> 
> Create new low level initialization for Agile5 due to the new ARM core
> composition and warm reset behavior.
> 
> Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
> ---
>   arch/arm/mach-socfpga/Makefile                |  1 +
>   .../include/mach/reset_manager_soc64.h        | 12 +++-
>   arch/arm/mach-socfpga/lowlevel_init_agilex5.S | 57 +++++++++++++++++++
>   3 files changed, 68 insertions(+), 2 deletions(-)
>   create mode 100644 arch/arm/mach-socfpga/lowlevel_init_agilex5.S
> 
> diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
> index 67c6a8dfec5..53c91d1d2a5 100644
> --- a/arch/arm/mach-socfpga/Makefile
> +++ b/arch/arm/mach-socfpga/Makefile
> @@ -58,6 +58,7 @@ endif
>   
>   ifdef CONFIG_TARGET_SOCFPGA_AGILEX5
>   obj-y	+= clock_manager_agilex5.o
> +obj-y	+= lowlevel_init_agilex5.o
>   obj-y	+= mailbox_s10.o
>   obj-y	+= misc_soc64.o
>   obj-y	+= mmu-arm64_s10.o
Can this be wired into existing early hook function, like s_init or so ?
