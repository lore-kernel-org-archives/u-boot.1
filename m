Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02A1C5B572
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 07:47:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0037380F3A;
	Fri, 14 Aug 2026 07:47:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1YdYknfwLzIj; Fri, 14 Aug 2026 07:47:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0659C80F28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786693665;
	bh=nRdIphAUoSTqnx4c3bTEa2F87rYyPvfszfRqh4xlwKs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DEmx9nbYJvecMb+s2+Kz5GPvyN+Q7sNrLxuq8ELoI9V1e20o5cdRAI626zyfW+8Kp
	 eO/YSbHZNwQ4AbtegxEaiDLdm37+JRjSrli8/TLM8s5dcEDYdzET+kWInrvfv1srtA
	 JukrDBYIm/VwQmfbKs4AusQ8AApMWom3lYv7zBcuH+42LLrpcHsqk2ZJWJw4JXjmcS
	 3eK6OIES66hw76mERl9B2fhqYqkK8YWyVwCbKmUmB20odghaqFuGgA+1zPymH7wmQg
	 JXvvbSThHTMAFqe8oV3aEefQ+BbjLM5Oj3cDyvgkWGq6HksfRBO3JLFRAwnotN0DCR
	 IMAKkYNGqlIyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0659C80F28;
	Fri, 14 Aug 2026 07:47:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BD979282
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 07:47:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A70DE408D7
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 07:47:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yeYH-DNKKEf2 for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 07:47:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=7d93=gh=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8B83F408D0
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8B83F408D0
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=JbR1NGB+
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8B83F408D0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 07:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1786693658;
 bh=nRdIphAUoSTqnx4c3bTEa2F87rYyPvfszfRqh4xlwKs=;
 b=JbR1NGB+kECqh0SBOIh0aXGTMxxDKPyHqpvrVSMkum1w++i19nZaNQ/HObNfkHeE5HH7xZ8aj
 pKZjaNhi1lTabHow8r0PoiHAc4rcdPFHPeuX3UxsVDf4YSxuux8qWDkm6Q/rdTMWvdDu18YRZzh
 j+AOk1JqSveTfoYdKD/s+B6nu+1n6N8Fe++UlIzkjjHhx4AhyqkqywclD5nQj2Vg3Ydub+Tv45a
 sr4K+kCzYDSrjrqSlB95i/HF/thheiX0NEsYtGkdmh1Lun80A7+oE7kjyk7ozUNI75bNDnFyDKd
 vAFX/Ku6rjrwp5PPWjsJgkmhXLplL3+36g9JFKCdv1YQ==
X-Forward-Email-ID: 6a7ec81729c185ac040ada77
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.13.16
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <1e47521b-c3f2-4c62-86eb-51866b911968@kwiboo.se>
Date: Fri, 14 Aug 2026 09:47:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/6] rockchip: doc: add back to ROM section
To: Johan Jonker <jbx6244@gmail.com>, u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <53b3903e-9413-4c96-ab45-4c34a2a6dca9@gmail.com>
 <becb8615-aa14-4dfa-b6eb-958abc535902@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <becb8615-aa14-4dfa-b6eb-958abc535902@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Johan,

On 8/13/2026 10:59 PM, Johan Jonker wrote:
> Add a back to ROM section to rockchip.rst
> Correct Kconfig text.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  arch/arm/mach-rockchip/Kconfig  | 16 ++++++++--------
>  doc/board/rockchip/rockchip.rst |  7 +++++++
>  2 files changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 1a2e7847c9e7..cb5983623bdc 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -600,26 +600,26 @@ config ROCKCHIP_USB_UART
>  	  SoCs will enable this routing as a debug measure.
>  
>  config SPL_ROCKCHIP_BACK_TO_BROM
> -	bool "SPL returns to bootrom"
> +	bool "SPL returns to boot ROM"
>  	default y if ROCKCHIP_RK3036
>  	select ROCKCHIP_BROM_HELPER
>  	select SPL_BOOTROM_SUPPORT
>  	depends on SPL
>  	help
> -	  Rockchip SoCs have ability to load SPL & U-Boot binary. If enabled,
> -	  SPL will return to the boot rom, which will then load the U-Boot
> -	  binary to keep going on.
> +	  Some Rockchip SoCs have the ability to load a second loader binary
> +	  after the SPL phase. If enabled, SPL will return to the boot ROM,
> +	  which will then load and execute the U-Boot binary.

What RK SoC does not support Back to BootROM mode?

To my knowledge most, if not all, RK targets use this mode during boot.
E.g. this is used on all rk32xx and newer SoCs. And for older SoCs that
may not have this built into BootROM they miniloader provide similar
function on legacy RK SoCs.

If you feel this text need to change, please be accurate and mention
what legacy SoC do not support returning to BootROM (or miniloader) to
load next image, as most (or all) of them do.

>  
>  config TPL_ROCKCHIP_BACK_TO_BROM
> -	bool "TPL returns to bootrom"
> +	bool "TPL returns to boot ROM"
>  	default y
>  	select ROCKCHIP_BROM_HELPER if !ROCKCHIP_RK3066
>  	select TPL_BOOTROM_SUPPORT
>  	depends on TPL
>  	help
> -	  Rockchip SoCs have ability to load SPL & U-Boot binary. If enabled,
> -	  SPL will return to the boot rom, which will then load the U-Boot
> -	  binary to keep going on.
> +	  Some Rockchip SoCs have the ability to load a second loader binary
> +	  after the TPL phase. If enabled, TPL will return to the boot ROM,
> +	  which will then load and execute a SPL binary.
>  
>  config ROCKCHIP_COMMON_BOARD
>  	bool "Rockchip common board file"
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index 5e16e860bfd5..7f6570f95cf4 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -218,6 +218,13 @@ For SoCs whose TF-A code is not available as open source, use BL31 binary provid
>  
>          git clone --depth 1 https://github.com/rockchip-linux/rkbin
>  
> +Back to ROM

Should be "Back to BootROM".

Side note, please name it BootROM or bootrom or BROM for short, not
"boot ROM". Similar for "maskrom", it should be maskrom mode, not
"mask ROM".

A small glossary:
BootROM: code/software part of the SoC, first code that runs when SoC is
         powered up
BROM: short form of BootROM
maskrom mode: the mode that BootROM will fallback into if no other boot
              option is found, listens for 471/472 usb ctrl commands
maskrom: short form of "maskrom mode" 
loader mode: a possible second stage after "maskrom mode" after a loader
             blob has been loaded, listens for rockusb usb commands
rockusb: rockchip usb protocol used in "loader mode"

Regrads,
Jonas

> +^^^^^^^^^^^
> +
> +Some Rockchip SoCs have the ability to load a second loader binary.
> +If enabled, the TPL/SPL code will return to the boot ROM, which will then
> +load and execute a SPL or U-Boot binary.
> +
>  TPL
>  ^^^
>  

