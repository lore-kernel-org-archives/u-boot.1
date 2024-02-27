Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0ABBC5478C
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 08:23:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 094A687F2D;
	Tue, 27 Feb 2024 09:23:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uVMmvFYf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44B2787F48; Tue, 27 Feb 2024 09:23:24 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2924587F21
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 09:23:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41R8NDTE120496;
 Tue, 27 Feb 2024 02:23:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709022193;
 bh=9xvaduUH4RyxIPc9PewaI6VfCMHnp47fnvlitVpofzU=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=uVMmvFYfJpJNl5wUAEScNkGjj+Z25c/EkYj93isDLjNMbrqvPsHto1TQHd8oFuKlh
 T0+9X8XGa3cQjxpa/BU8ntyW6XmzjBQ2fzgZWrt9SwBHbygi/xe1OxOE/TYNaH+FTQ
 qmjDvqc7iQ4RHI9XXIbGqiMm/ayd8p0wmdSsRqgs=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41R8NDix009982
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 27 Feb 2024 02:23:13 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 27
 Feb 2024 02:23:13 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 27 Feb 2024 02:23:13 -0600
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41R8N8oW015235;
 Tue, 27 Feb 2024 02:23:09 -0600
Message-ID: <f0a0f05e-054e-4a19-ae0a-cd9bc442238b@ti.com>
Date: Tue, 27 Feb 2024 13:53:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/13] Makefile: remove hardcoded device tree source
 directory
Content-Language: en-US
To: Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Lukasz Majewski <lukma@denx.de>, Sean Anderson
 <seanga2@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass
 <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>, Nishanth Menon
 <nm@ti.com>, Andrew Davis <afd@ti.com>, Igor Opaniuk
 <igor.opaniuk@foundries.io>, Hari Nagalla <hnagalla@ti.com>,
 Ravi Gunasekaran <r-gunasekaran@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>
References: <20240205-am62px-wip-rebasing-v3-0-04cbb42eaa6f@ti.com>
 <20240205-am62px-wip-rebasing-v3-11-04cbb42eaa6f@ti.com>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240205-am62px-wip-rebasing-v3-11-04cbb42eaa6f@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hi Bryan

On 27/02/24 02:49, Bryan Brattlof wrote:
> Some boards that choose to utilize the OF_UPSTREAM directory for their
> device tree files will need to specify that directory instead of the
> traditional arch/$(ARCH)/dts/* path.
> 
> Include the correct path to the board's dtbs depending on if OF_UPSTREAM
> is selected or not.
> 
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>   Makefile             | 18 ++++++++++++++----
>   scripts/Makefile.spl | 17 +++++++++++++----
>   2 files changed, 27 insertions(+), 8 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 0f0c7f30d2717..51b57d26857f1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1184,6 +1184,16 @@ dt_binding_check: scripts_dtc
>   quiet_cmd_copy = COPY    $@
>         cmd_copy = cp $< $@
>   
> +ifeq ($(CONFIG_OF_UPSTREAM),y)
> +ifeq ($(CONFIG_ARM64),y)

This would fail in case of R5 builds, is there any reason why you choose not to 
use OF_UPSTREAM for R5 builds?

I understand that R5 builds will require U-Boot DTS (from U-Boot code base) that 
(ideally) should inherit the kernel core DTS (from upstream), is this support 
not there at present? Let me know if I understand incorrectly.

> +dt_dir := dts/upstream/src/arm64
> +else
> +dt_dir := dts/upstream/src/$(ARCH)
> +endif
> +else
> +dt_dir := arch/$(ARCH)/dts
> +endif
> +
>   ifeq ($(CONFIG_MULTI_DTB_FIT),y)
>   
>   ifeq ($(CONFIG_MULTI_DTB_FIT_LZO),y)
> @@ -1209,7 +1219,7 @@ endif
>   
>   MKIMAGEFLAGS_fit-dtb.blob = -f auto -A $(ARCH) -T firmware -C none -O u-boot \
>   	-a 0 -e 0 -E \
> -	$(patsubst %,-b arch/$(ARCH)/dts/%.dtb,$(subst ",,$(CONFIG_OF_LIST))) -d /dev/null
> +	$(patsubst %,-b $(dt_dir)/%.dtb,$(subst ",,$(CONFIG_OF_LIST))) -d /dev/null
>   
>   MKIMAGEFLAGS_fit-dtb.blob += -B 0x8
>   
> @@ -1407,9 +1417,9 @@ MKIMAGEFLAGS_u-boot.img = -f auto -A $(ARCH) -T firmware -C none -O u-boot \
>   	-a $(CONFIG_TEXT_BASE) -e $(CONFIG_SYS_UBOOT_START) \
>   	-p $(CONFIG_FIT_EXTERNAL_OFFSET) \
>   	-n "U-Boot $(UBOOTRELEASE) for $(BOARD) board" -E \
> -	$(patsubst %,-b arch/$(ARCH)/dts/%.dtb,$(subst ",,$(DEVICE_TREE))) \
> -	$(patsubst %,-b arch/$(ARCH)/dts/%.dtb,$(subst ",,$(CONFIG_OF_LIST))) \
> -	$(patsubst %,-b arch/$(ARCH)/dts/%.dtbo,$(subst ",,$(CONFIG_OF_OVERLAY_LIST)))
> +	$(patsubst %,-b $(dt_dir)/%.dtb,$(subst ",,$(DEVICE_TREE))) \
> +	$(patsubst %,-b $(dt_dir)/%.dtb,$(subst ",,$(CONFIG_OF_LIST))) \
> +	$(patsubst %,-b $(dt_dir)/%.dtbo,$(subst ",,$(CONFIG_OF_OVERLAY_LIST)))
>   else
>   MKIMAGEFLAGS_u-boot.img = -A $(ARCH) -T firmware -C none -O u-boot \
>   	-a $(CONFIG_TEXT_BASE) -e $(CONFIG_SYS_UBOOT_START) \
> diff --git a/scripts/Makefile.spl b/scripts/Makefile.spl
> index 407fc52376a50..d074ba2350065 100644
> --- a/scripts/Makefile.spl
> +++ b/scripts/Makefile.spl
> @@ -559,9 +559,15 @@ FORCE:
>   $(obj)/dts/dt-$(SPL_NAME).dtb: dts/dt.dtb
>   	$(Q)$(MAKE) $(build)=$(obj)/dts spl_dtbs
>   
> -PHONY += dts_dir
> -dts_dir:
> -	$(shell [ -d $(obj)/dts ] || mkdir -p $(obj)/dts)
> +ifeq ($(CONFIG_OF_UPSTREAM),y)
> +ifeq ($(CONFIG_ARM64),y)
> +dt_dir := dts/upstream/src/arm64
> +else
> +dt_dir := dts/upstream/src/$(ARCH)
> +endif
> +else
> +dt_dir := arch/$(ARCH)/dts
> +endif
>   
>   # Declare the contents of the .PHONY variable as phony.  We keep that
>   # information in a variable so we can use it in if_changed and friends.
> @@ -569,8 +575,11 @@ dts_dir:
>   
>   SPL_OF_LIST_TARGETS = $(patsubst %,dts/%.dtb,$(subst ",,$(CONFIG_SPL_OF_LIST)))
>   SHRUNK_ARCH_DTB = $(addprefix $(obj)/,$(SPL_OF_LIST_TARGETS))
> +$(dir $(SHRUNK_ARCH_DTB)):
> +	$(shell [ -d $@ ] || mkdir -p $@)
> +
>   .SECONDEXPANSION:
> -$(SHRUNK_ARCH_DTB): $$(patsubst $(obj)/dts/%, arch/$(ARCH)/dts/%, $$@) dts_dir
> +$(SHRUNK_ARCH_DTB): $$(patsubst $(obj)/dts/%, $(dt_dir)/%, $$@) $(dir $(SHRUNK_ARCH_DTB))
>   	$(call if_changed,fdtgrep)
>   
>   targets += $(SPL_OF_LIST_TARGETS)
> 

-- 
Thanking You
Neha Malcom Francis
