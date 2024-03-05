Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8821BC54798
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 13:03:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD5DF88050;
	Tue,  5 Mar 2024 14:03:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IpM2ibtB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2DC388044; Tue,  5 Mar 2024 13:51:45 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA3518803A
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 13:51:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33d90dfe73cso3006983f8f.0
 for <u-boot@lists.denx.de>; Tue, 05 Mar 2024 04:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709643101; x=1710247901; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x91VJBZqjXRLt3HCTujHvFpj+vG9EQ3dOOSIkLwi6Rw=;
 b=IpM2ibtB0Yo9xgn31H1RMjA4h5MZPpkEW7pXl3bvqkz1ACDTsPDyBJrIEO8SSBmn3s
 l2D5Ty1Xmp/JLXLxJXEW9PdiW11Evbk54ULq9L2QYdACgmkecl05aCLc0i2IeR8xnRDV
 hUttReHEBGZOIL192bgbtew/jqT38bz5tlRjCsFK69iRKgc0GDQuczxXc8ADpLAqoOCN
 Pyj+Txu35rYK9Vd7doXU6K++Eusi8Rw0LeBgRu2IZC59XdEDwMlQ0aSkP1fKqyTuT0PR
 KP9SMcSzXXStD88WGhgnVEQ3hgxYqrcEywFVyDR7NIOc5AofSQRtDZ2zDg+SHjnAKRDT
 aiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709643101; x=1710247901;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x91VJBZqjXRLt3HCTujHvFpj+vG9EQ3dOOSIkLwi6Rw=;
 b=OK3FBt3QHBTq8H817dQWesNCWJSCC1xArkNfev402dEhhBerxyIfqr2IMDeulJk72e
 nVXNoNQKGk/mCufRwnyq/J7i5tlX1DIf+oqYP1XBSYNC/CH0VK+FDMNbiu+vhvPUEyZI
 RWUWbkqPyn5SKlTDDlZM9sj9RasLGyy/nFcIBBjDgjx9T0AnPyS3fY+Peb4O4LK4V9xg
 qYiLDvsUkDQz2OAh9EVDBZM5xcZX3Q+z8kQQs6IB5OuCpz6kjHNiZ0z20LWqxL8R3wPn
 RljxG6bYGij9+65C2Zx/U/C89rml7BEawzLBVODnT5wJdeWtdvbFRe/MmuTwaKfTWeW9
 qhsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYhRDEnJ1e/Ph51UEYzDm72iE1jf4qQqzWPJQVjVuVSW33izVk3YB6MZO1XcllQMLo8FZW2dRoKeMOBfYCyM/BbFs6Xg==
X-Gm-Message-State: AOJu0Ywv5MYPKdultk6RrPXqj8yFhQRiREQxG1YM6708+GNsKn24HQjV
 DUcinXWhcLD+JVQUwyPR7Bt1XVy+ys0vlodiKNPPmAePKlyYr0cUcnm8k8UDrIw=
X-Google-Smtp-Source: AGHT+IHnT6DPSQterrn8gdAzpmDRRKm3ffEfvNCc0pY3+OmjAlf4/PwRTEQcSOEXen96G54bD8IYvA==
X-Received: by 2002:a05:6000:22e:b0:33d:8ebf:4f6 with SMTP id
 l14-20020a056000022e00b0033d8ebf04f6mr1957148wrz.20.1709643101208; 
 Tue, 05 Mar 2024 04:51:41 -0800 (PST)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 ck4-20020a5d5e84000000b0033e2b9f647asm9147469wrb.31.2024.03.05.04.51.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 04:51:40 -0800 (PST)
Message-ID: <3e17d3e4-e2e1-45ff-9d62-44bf5a8991df@linaro.org>
Date: Tue, 5 Mar 2024 12:51:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 26/26] dts: support building all dtb files for a
 specific vendor
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Sam Protsenko
 <semen.protsenko@linaro.org>, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Chunfeng Yun
 <chunfeng.yun@mediatek.com>, Eugen Hristev <eugen.hristev@collabora.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Dai Okamura <okamura.dai@socionext.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, uboot-stm32@st-md-mailman.stormreply.com,
 uboot-snps-arc@synopsys.com
References: <20240304-b4-upstream-dt-headers-v1-0-b7ff41925f92@linaro.org>
 <20240304-b4-upstream-dt-headers-v1-26-b7ff41925f92@linaro.org>
 <CAFA6WYM6sTEdw+VphKidUqjQW61eW8ZVq+oO35CJVM=5wPoniA@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFA6WYM6sTEdw+VphKidUqjQW61eW8ZVq+oO35CJVM=5wPoniA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 05 Mar 2024 14:03:39 +0100
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



On 05/03/2024 12:35, Sumit Garg wrote:
> Hi Caleb,
> 
> On Mon, 4 Mar 2024 at 22:22, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> This adjusts OF_UPSTREAM to behave more like the kernel by allowing for
>> all the devicetree files for a given vendor to be compiled. This is
>> useful for Qualcomm in particular as most boards are supported by a
>> single U-Boot build just provided with a different DT.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>  dts/Kconfig          | 24 ++++++++++++++++++++++++
>>  scripts/Makefile.dts | 17 ++++++++++++++++-
>>  2 files changed, 40 insertions(+), 1 deletion(-)
>>
>> diff --git a/dts/Kconfig b/dts/Kconfig
>> index b9b6367154ef..67d9dc489856 100644
>> --- a/dts/Kconfig
>> +++ b/dts/Kconfig
>> @@ -100,8 +100,32 @@ config OF_UPSTREAM
>>           However, newer boards whose devicetree source files haven't landed in
>>           the dts/upstream subtree, they can override this option to have the
>>           DT build from existing U-Boot tree location instead.
>>
>> +config OF_UPSTREAM_BUILD_VENDOR
>> +       bool "Build all devicetree files for a particular vendor"
>> +       depends on OF_UPSTREAM
>> +       help
>> +         Enable building all devicetree files for a particular vendor. This
> 
> Do we really want to build all the DTBs even if many of those aren't
> supported by U-Boot at all? I would have rather added Makefile targets
> for boards which really supports a single defconfig eg.
> qcom_defconfig.

Yes, for the 4 Qualcomm SoCs currently supported there are 51 dts
targets that ought to be able to run U-Boot to some extent

$ ls -l dts/upstream/src/arm6/qcom/{msm8916,sdm845,msm8996,qcs404}*.dts\
	| wc -l
51

What do you mean by a "makefile target"? Like copying
arch/arm64/boot/dts/qcom/Makefile from Linux? I guess my concern here
would be keeping it in sync, and introducing additional busywork when
porting.

We do have a lot of Qualcomm DTS files, it takes maybe 10 seconds to
compile them all on my machine, but that's only once. With incremental
builds this becomes largely irrelevant.
> 
> -Sumit
> 
>> +         is useful for generic U-Boot configurations where many boards can
>> +         be supported with a single binary.
>> +
>> +         This is only available for platforms using upstream devicetree.
>> +
>> +config OF_UPSTREAM_VENDOR
>> +       string "Vendor to build all upstream devicetree files for"
>> +       depends on OF_UPSTREAM_BUILD_VENDOR
>> +       default "qcom" if ARCH_SNAPDRAGON
>> +       default "rockchip" if ARCH_ROCKCHIP
>> +       default "amlogic" if ARCH_MESON
>> +       default "allwinner" if ARCH_SUNXI
>> +       default "mediatek" if ARCH_MEDIATEK
>> +       default "marvell" if ARCH_MVEBU
>> +       default "xilinx" if ARCH_VERSAL || ARCH_ZYNQ
>> +       default "nvidia" if ARCH_TEGRA
>> +       help
>> +         Select the vendor to build all devicetree files for.
>> +
>>  choice
>>         prompt "Provider of DTB for DT control"
>>         depends on OF_CONTROL
>>
>> diff --git a/scripts/Makefile.dts b/scripts/Makefile.dts
>> index 5e2429c6170c..8005527f3df7 100644
>> --- a/scripts/Makefile.dts
>> +++ b/scripts/Makefile.dts
>> @@ -1,3 +1,18 @@
>>  # SPDX-License-Identifier: GPL-2.0+
>>
>> -dtb-y += $(patsubst %,%.dtb,$(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE) $(CONFIG_OF_LIST) $(CONFIG_SPL_OF_LIST)))
>> +dtb-y += $(patsubst %,%.dtb,\
>> +       $(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE) $(CONFIG_OF_LIST) $(CONFIG_SPL_OF_LIST)))
>> +
>> +ifeq ($(CONFIG_OF_UPSTREAM_BUILD_VENDOR),y)
>> +ifeq ($(CONFIG_ARM64),y)
>> +dt_dir := $(srctree)/dts/upstream/src/arm64
>> +else
>> +dt_dir := $(srctree)/dts/upstream/src/$(ARCH)
>> +endif
>> +
>> +dtb-vendor_dts := $(patsubst %.dts,%.dtb, \
>> +       $(wildcard $(dt_dir)/$(subst ",,$(CONFIG_OF_UPSTREAM_VENDOR))/*.dts))
>> +
>> +dtb-y += $(subst $(dt_dir)/,,$(dtb-vendor_dts))
>> +
>> +endif
>>
>> --
>> 2.44.0
>>

-- 
// Caleb (they/them)
