Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF71C4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 07:13:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F45387A4E;
	Fri, 15 Dec 2023 08:13:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="BjqbK9IU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E83F487A4B; Fri, 15 Dec 2023 08:13:56 +0100 (CET)
Received: from mail-m17214.xmail.ntesmail.com (mail-m17214.xmail.ntesmail.com
 [45.195.17.214])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86C9187ABC
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 08:13:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=BjqbK9IUB6PQM5oYbbIP/MBbgb74OoOOftVj1d8fIG6/2mv/MmWdtk7wE7jfD0O8F8pbOVcpIZ51UK7u0LWlSgGgrtB7bOzrwRBcJ2r3XYsyFZY7F+Z+im883aVcHT5TocHMibRcgfphVI8onSJscF67YDXYwJksZKQQvzqe4x4=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=fGCZXGVSQoh76nf2JIo1gu35cFnTGgnh2YI92PtRwho=;
 h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 83AB5400497;
 Fri, 15 Dec 2023 15:13:38 +0800 (CST)
Message-ID: <f04a716f-1383-493c-87b5-e39edacee857@rock-chips.com>
Date: Fri, 15 Dec 2023 15:13:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/17] video: dw_hdmi: Support Vendor PHY
Content-Language: en-US
To: Jagan Teki <jagan@amarulasolutions.com>, Heiko Stuebner
 <heiko@sntech.de>, Anatolij Gustschin <agust@denx.de>
Cc: u-boot@lists.denx.de, Da Xue <da.xue@libretech.co>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, Simon Glass <sjg@chromium.org>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 =?UTF-8?B?6Jab5bCP5piO?= <xxm@rock-chips.com>, =?UTF-8?B?5pON55Ge5p2w?=
 <algea.cao@rock-chips.com>, =?UTF-8?B?6Zer5a2d5Yab?=
 <andy.yan@rock-chips.com>
References: <20231211085939.5478-1-jagan@amarulasolutions.com>
 <CAMty3ZBNC7Fpi-S4uOwfJ3ULWQ27PiVAKTqbnQKB3nB5vXHrhg@mail.gmail.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <CAMty3ZBNC7Fpi-S4uOwfJ3ULWQ27PiVAKTqbnQKB3nB5vXHrhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDGBofVh0fQkhMHk5KTk5ITFUTARMWGhIXJBQOD1
 lXWRgSC1lBWUpLSFVJQlVKT0lVTUxZV1kWGg8SFR0UWUFZT0tIVUpNT0lOSVVKS0tVSkJZBg++
X-HM-Tid: 0a8c6c52de3c2eb3kusn83ab5400497
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NBQ6Mhw6ITw0DTdLViMpDgE5
 L08aFA1VSlVKTEtJTUlPT0lLS0NJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQU5ISE03Bg++
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

Hi Jagan,

On 2023/12/15 14:36, Jagan Teki wrote:
> Hi Heiko/Kerver/Anatoloj,
>
> On Mon, Dec 11, 2023 at 2:30 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>> Unlike RK3399, Sunxi/Meson DW HDMI the new Rockchip SoC Rk3328 would
>> support external vendor PHY with DW HDMI chip.
>>
>> Support this vendor PHY by adding new platform PHY ops via DW HDMI
>> driver and call the respective generic phy from platform driver code.
>>
>> This series tested in RK3328 with 1080p (1920x1080) resolution.
>>
>> Patch 0001/0005: Support Vendor PHY
>> Patch 0006/0008: VOP extension for win, dsp offsets
>> Patch 0009/0010: RK3328 VOP, HDMI clocks
>> Patch 0011:      Rockchip Inno HDMI PHY
>> Patch 0012:      RK3328 HDMI driver
>> Patch 0013:      RK3328 VOP driver
>> Patch 0014/0017: Enable HDMI Out for RK3328
>>
>> Importent:
>> One pontential issues is that Linux HDMI out on RK3328 has effected by
>> this patchset as I wouldn't find any relation or clue.
>>
>> [    0.752016] Loading compiled-in X.509 certificates
>> [    0.787796] inno_hdmi_phy_rk3328_clk_recalc_rate: parent 24000000
>> [    0.788391] inno-hdmi-phy ff430000.phy: inno_hdmi_phy_rk3328_clk_recalc_rate rate 148500000 vco 148500000
>> [    0.798353] rockchip-drm display-subsystem: bound ff370000.vop (ops vop_component_ops)
>> [    0.799403] dwhdmi-rockchip ff3c0000.hdmi: supply avdd-0v9 not found, using dummy regulator
>> [    0.800288] rk_iommu ff373f00.iommu: Enable stall request timed out, status: 0x00004b
>> [    0.801131] dwhdmi-rockchip ff3c0000.hdmi: supply avdd-1v8 not found, using dummy regulator
>> [    0.802056] rk_iommu ff373f00.iommu: Disable paging request timed out, status: 0x00004b
>> [    0.803233] dwhdmi-rockchip ff3c0000.hdmi: Detected HDMI TX controller v2.11a with HDCP (inno_dw_hdmi_phy2)
>> [    0.805355] dwhdmi-rockchip ff3c0000.hdmi: registered DesignWare HDMI I2C bus driver
>> [    0.808769] rockchip-drm display-subsystem: bound ff3c0000.hdmi (ops dw_hdmi_rockchip_ops)
>> [    0.810869] [drm] Initialized rockchip 1.0.0 20140818 for display-subsystem on minor 0
>>
>> The only way I can use Linux HDMI by disabling IOMMU or support
>> disable-iommu link for RK3328 via DT [1].
>>
>> [1] https://www.spinics.net/lists/devicetree/msg605124.html
> Is anyone aware of this issue? I did post the patches for Linux IOMMU
> but seems not a proper solution. Any suggestions?

I'm not expert in HDMI/VOP, so I can't provide a suitable solution in 
the kernel,

but here is the reason why we need patch to workaround the issue in the 
kernel:

- The VOP driver working in U-Boot is non-IOMMU mode, and the VOP access 
DDR by physical address;

- The VOP driver working in kernel with IOMMU enabled(by default), the 
VOP access DDR with virtual address(by IOMMU);

- The VOP is keep working in kernel before kernel VOP driver is enabled, 
and the IOMMU driver will be enabled by

    the Linux PM framework, since the IOMMU is not correctly configured 
at this point, the VOP will access unknown

     space(the original physical address in U-Boot) convert by IOMMU;

So we need to disable the IOMMU temporary in kernel startup before VOP 
driver is enabled.


Thanks,

- Kever

>
> Thanks,
> Jagan.
