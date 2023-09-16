Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC48C2BA12
	for <u-boot@archiver.kernel.org>; Sat, 16 Sep 2023 22:19:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1363847C3;
	Sun, 17 Sep 2023 00:19:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.b="bZBoha2R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8800084B20; Sun, 17 Sep 2023 00:19:10 +0200 (CEST)
Received: from s.wfbtzhsw.outbound-mail.sendgrid.net
 (s.wfbtzhsw.outbound-mail.sendgrid.net [159.183.224.105])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D13F2803AB
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 00:19:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounces+31435339-7456-u-boot=lists.denx.de@em2124.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=mime-version:subject:references:from:in-reply-to:to:cc:content-type:
 content-transfer-encoding:cc:content-type:from:subject:to;
 s=s1; bh=cIrrZDg4rqNcviIiD9bRRFNvckwDNeug0Uj37Y/Vmqk=;
 b=bZBoha2RHmR5FkLSdzIlmy0LttLqedJ9PDqE+AdJ7pmdddLX0SXxwROOFpWZynqB2AhK
 iKq/MkxtnfM3znLRWK3ekJEH8aO7jgcn4BOiFH7h0+s4YWgjAOn/52woizXhNsdqflCDl9
 fgsZ2GoJCJxiHTRfOcvBKplE8uTPegxKEU2Kb8rd2T0t7mYdCwGTysnh3kUZdFb+ZjiRPm
 HftHTEwwU3h/lJBKdpaXByBiO4L4EnQ0BeendiQBCSTFYkKYtDON3rSC1NMRayEkmOvVFO
 Ebv0LfAnWZS7P0OgK/97lfyGoreUvMq1AE1IXVWycfA88ZKvzRXqcoNMtlVA+3rQ==
Received: by filterdrecv-d7bbbc8bf-wstxc with SMTP id
 filterdrecv-d7bbbc8bf-wstxc-1-650629DA-8
 2023-09-16 22:19:06.463543446 +0000 UTC m=+117891.179427251
Received: from [192.168.1.50] (unknown) by geopod-ismtpd-0 (SG) with ESMTP
 id vlAe9v3rQcisWjYIyPb2Ug Sat, 16 Sep 2023 22:19:06.093 +0000 (UTC)
Message-ID: <7e069c36-fe99-3701-9572-1363b694645b@kwiboo.se>
Date: Sat, 16 Sep 2023 22:19:06 +0000 (UTC)
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/2] riscv: dts: starfive: generate
 u-boot-spl.bin.normal.out
References: <20230906120008.86717-1-heinrich.schuchardt@canonical.com>
 <20230906120008.86717-3-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20230906120008.86717-3-heinrich.schuchardt@canonical.com>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h0WiOFdPFIzFBqTMG?=
 =?us-ascii?Q?TyOH=2FOuEjzMa2qHRUY0LAdTT+6SY=2FQ5n0K0oI+4?=
 =?us-ascii?Q?0txDRhsOVzehbkNXJDHazwsZxr6tqyqUgpOXOuy?=
 =?us-ascii?Q?EWG+=2FKYmLomGDmGbKJ6z1NZqgW0BuTeLmQh01NE?=
 =?us-ascii?Q?iueW8250xCvgG7i3dKcJp9x5uSKdQhSeRpYlgF?=
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Rick Chen
 <rick@andestech.com>, Leo <ycliang@andestech.com>, Yanhong Wang
 <yanhong.wang@starfivetech.com>
Cc: Simon Glass <sjg@chromium.org>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Chanho Park <chanho61.park@samsung.com>, u-boot@lists.denx.de
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Type: text/plain; charset=us-ascii
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

On 2023-09-06 14:00, Heinrich Schuchardt wrote:
> The StarFive VisionFive 2 board cannot load spl/u-boot-spl.bin but needs a
> prefixed header. We have referring to a vendor tool (spl_tool) for this
> task. 'mkimage -T sfspl' can generate the prefixed file.
> 
> Use binman to invoke mkimage for the generation of file
> spl/u-boot-spl.bin.normal.out.
> 
> Update the documentation.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Tested-by: Chanho Park <chanho61.park@samsung.com>
> ---
> v2:
> 	Fix a typo in a comment in tools/sfspl.c
> 	Add Tested-by credit
> ---
>  .../dts/jh7110-starfive-visionfive-2-u-boot.dtsi   | 10 ++++++++++
>  doc/board/starfive/visionfive2.rst                 | 14 ++------------
>  2 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
> index 13f69da31e..defe2b605f 100644
> --- a/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
> +++ b/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
> @@ -103,4 +103,14 @@
>  			};
>  		};
>  	};
> +	u-boot-spl {
> +		filename = "spl/u-boot-spl.bin.normal.out";
> +
> +		mkimage {
> +			args = "-T sfspl";
> +			blob {
> +				filename = "spl/u-boot-spl.bin";
> +			};
> +		};
> +	};

This should probably be:

mkimage {
	filename = "spl/u-boot-spl.bin.normal.out";
	args = "-T sfspl";

	u-boot-spl {
	};
};

Regards,
Jonas

>  };
> diff --git a/doc/board/starfive/visionfive2.rst b/doc/board/starfive/visionfive2.rst
> index 941899a0a4..f5575ab68b 100644
> --- a/doc/board/starfive/visionfive2.rst
> +++ b/doc/board/starfive/visionfive2.rst
> @@ -65,18 +65,8 @@ Now build the U-Boot SPL and U-Boot proper
>  	make starfive_visionfive2_defconfig
>  	make OPENSBI=$(opensbi_dir)/opensbi/build/platform/generic/firmware/fw_dynamic.bin
>  
> -This will generate spl/u-boot-spl.bin and FIT image (u-boot.itb)
> -
> -u-boot-spl.bin cannot be used directly on StarFive VisionFive2,we need
> -to convert the u-boot-spl.bin to u-boot-spl.bin.normal.out with
> -the below command:
> -
> -	./spl_tool -c -f $(Uboot_PATH)/spl/u-boot-spl.bin
> -
> -More detailed description of spl_tool,please refer spl_tool documenation.
> -(Note: spl_tool git repo is at https://github.com/starfive-tech/Tools/tree/master/spl_tool)
> -
> -This will generate u-boot-spl.bin.normal.out file.
> +This will generate the U-Boot SPL image (spl/u-boot-spl.bin.normal.out) as well
> +as the FIT image (u-boot.itb) with OpenSBI and U-Boot.
>  
>  Flashing
>  ~~~~~~~~

