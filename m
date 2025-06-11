Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5C4C677C4
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 06:35:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF5D982B20;
	Wed, 11 Jun 2025 08:35:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7619082B63; Wed, 11 Jun 2025 08:35:02 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 742A282A4B
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 08:35:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [143.105.117.26])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 78417B4C47D8
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 08:34:59 +0200 (CEST)
Message-ID: <1f35b183-1082-47f8-a955-d7cc33e4715a@freeshell.de>
Date: Tue, 10 Jun 2025 23:34:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Set fdtfile variable from DT
To: u-boot@lists.denx.de
References: <20250610-b4-fdtfile-from-dt-v1-0-aec4df0fa53e@linaro.org>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250610-b4-fdtfile-from-dt-v1-0-aec4df0fa53e@linaro.org>
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

Hi Casey,

On 6/10/25 09:23, Casey Connolly wrote:
> This series introduces a new devicetree property in /chosen named
> "fdtfile". This string array contains the upstream relative path to the
> devicetree (e.g. "qcom/qcs4690-rb3gen2.dtb") and may in the future also
> list the overlays in use. It is set at build time for OF_UPSTREAM builds
> where we know the correct path.
> 
> Then we read out this property at runtime and set the fdtfile variable
> in U-Boots environment.
> 
> This provides a fully consistent way to set fdtfile so that U-Boot or
> another OS Loader could find the correct devicetree file associated with
> the kernel version being run, since it isn't always preferable to pass
> to the devicetree from U-Boot.
> 
> Currently, U-Boot searches some subdirectories in the ESP for the
> fdtfile when booting with EFI, and uses it when booting with extlinux.
> However today with EFI booting it is impossible to find the DTB when
> there are multiple kernel versions available, for this we need to
> integrate with the OS loader.
> 
> In the future, the fdtfile variable should be exported as an EFI
> variable which can be appended to a devicetree-directory property in the
> OS loader configuration to find the correct devicetree for the kernel
> version being booted.
> 
> This will allow users to safely roll back their kernel and devicetree
> together if there is a bug in a new kernel release.
> 
> Ideally devicetree would be stable for all platforms and none of this
> would be necessary, but this is unfortunately not yet the case. This
> series attempts to make the best of this bad situation by providing the
> safest possible user experience.
> 
> Feedback is welcome on how to implement the EFI variable part of this,
> as I'm not sure where it belongs. I didn't want to hold the rest of the
> series back since I'm sure it will be useful elsewhere.
> 
> ---
> Casey Connolly (3):
>       dts/upstream: write fdtfile path to /chosen/fdtfile
>       env: set fdtfile environment variable from /chosen/fdtfile
>       mach-snapdragon: skip setting fdtfile if already set
> 
>  arch/arm/mach-snapdragon/board.c |  5 +++++
>  common/board_r.c                 | 35 +++++++++++++++++++++++++++++++++++
>  scripts/Makefile.lib             | 15 +++++++++++++++
>  3 files changed, 55 insertions(+)
> ---
> base-commit: 87e02cbb78a2897d43db0f732e926b73d9c0823e
> change-id: 20250610-b4-fdtfile-from-dt-0bd7930ad62c
> 
> Casey Connolly <casey.connolly@linaro.org>
> 

Please also adapt for this series the starfive_visionfive2 board target
(board/starfive/visionfive2/spl.c:board_fit_config_name) which I think
may help you further develop this idea, and I am more familiar with to
test and comment about.

I.E. there is a section of logic in
board/starfive/visionfive2/starfive_visionfive2.c that I consider
redundant and troublesome for setting fdtfile env variable. Later in
main U-Boot or the eventual OS there is no fact of what the dtb search
path was (one of the CONFIG_OF_LIST items) as when it was determined
during SPL phase what board model variant is detected. I strongly
dislike that we even make it a possibility to overwrite this information
at runtime as-is today. Commands and workflows requiring the dtb search
path string should drop the use of fdtfile U-Boot env variable and
instead reference some API call directly and relieve us from the need to
mess with fdtfile env variable at all.

As for whether there can be some user script to load a dtb, I think we
are all reaching for a command to load devicetree and that already
exists in U-Boot so what are we even doing? It is impossible to access
filesystem in some circumstance and this approach of passing a dtb as
filesystem search path string is chasing a problem we have invented.
Perhaps it should be as an alternate memory address or as the concept of
"overlay without inheriting any parent".

Thanks for taking on the effort to make an improvement, anyway if the
effect of this series is better or worse or about the same I'm not so
sure either way because of the wider dislike I mention for what we're
already doing. I would like to see this approach applied to the many
JH7110 CPU boards ('starfive_visionfive2' board target) which has (I
think) the right amount of complexity.

-E
