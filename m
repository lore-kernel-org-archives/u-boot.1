Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD6DE67488
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 22:10:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88A9688E41;
	Thu, 31 Oct 2024 23:10:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="GycbEMFe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92E3388E75; Thu, 31 Oct 2024 23:10:16 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE78088B9F
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 23:10:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8fe9=R4=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: References: Cc:
 To: From: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1730412609;
 bh=zl6WK6xITxtDhai0W6+MK8eqVT7Ocmjtu0zfIepRkE4=;
 b=GycbEMFeVR25MBXlt6t/0y7TthZt1J5HCGu72L0Is5y1OmSuI7O+6OpeHk06jMipivgWEu+7X
 sylNHsW9XLLglPw6AM/C9tKSusBhKBScrLM1zNzVsQV/q7v6mZ6CCmykRIlg/LrwhE1IQzfMQh8
 vggWm861KXCamM5V4I24Ln2J9+OcBkITs8pORdouPsRwGhXQdi5otgPsATrWl2Ijk/kQWGndjMj
 4mSsikqeDmNrpf6yU+iL1UZ74j6Faw6AWBZpMOgG2XSmY1PRLulr5TRZmq8FNOYwUJsSnDHQaDi
 FizjS55drTvEM7ZBsZDaxrAph9RHlrlOiKn0Sh+m59Yw==
Message-ID: <2420f2aa-6608-4fa3-8fcc-0e7151858b8c@kwiboo.se>
Date: Thu, 31 Oct 2024 23:10:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] rockchip: rock5b-rk3588: Enable automatic PCI
 enumeration
From: Jonas Karlman <jonas@kwiboo.se>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Eugen Hristev <eugen.hristev@linaro.org>, u-boot@lists.denx.de,
 Kever Yang <kever.yang@rock-chips.com>, FUKAUMI Naoki <naoki@radxa.com>
References: <20241031180212.116330-1-sebastian.reichel@collabora.com>
 <e457b630-bd7d-4f7d-bd4e-20f0e3fbc9a2@linaro.org>
 <1d28e59e-9e92-4570-960c-ed642731a226@kwiboo.se>
 <d2ri4jalkbd2vxpubsbypv35wjpfj4dc25bicxkju45r4awap3@iyzh45ejli2f>
 <b0a713b4-8839-42b5-9a18-2fe79f3256e0@kwiboo.se>
Content-Language: en-US
In-Reply-To: <b0a713b4-8839-42b5-9a18-2fe79f3256e0@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 672400404382f7c758edc6d7
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

On 2024-10-31 22:52, Jonas Karlman wrote:
> Hi Sebastian,
> 
> On 2024-10-31 22:16, Sebastian Reichel wrote:
>> Hi,
>>
>> On Thu, Oct 31, 2024 at 08:17:32PM +0100, Jonas Karlman wrote:
>>> On 2024-10-31 19:15, Eugen Hristev wrote:
>>>> On 10/31/24 20:01, Sebastian Reichel wrote:
>>>>> PCI enumeration is required to detect the onboard Ethernet device.
>>>>>
>>>>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>>>>> ---
>>>>>   configs/rock5b-rk3588_defconfig | 1 +
>>>>>   1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
>>>>> index c54e13e8732c..e5b9f7d326b4 100644
>>>>> --- a/configs/rock5b-rk3588_defconfig
>>>>> +++ b/configs/rock5b-rk3588_defconfig
>>>>> @@ -17,6 +17,7 @@ CONFIG_DEBUG_UART_CLOCK=24000000
>>>>>   CONFIG_SPL_SPI_FLASH_SUPPORT=y
>>>>>   CONFIG_SPL_SPI=y
>>>>>   CONFIG_PCI=y
>>>>> +CONFIG_PCI_INIT_R=y
>>>>>   CONFIG_DEBUG_UART=y
>>>>>   CONFIG_AHCI=y
>>>>>   CONFIG_FIT=y
>>>>
>>>> This has been added and removed before, please see
>>>>
>>>> https://lore.kernel.org/all/20231104130451.111020-1-martin.roukala@mupuf.org/T/
>>>>
>>>> this commit adds it
>>>> 5b269ed404dc ("configs: rockchip: rock5b-rk3588: Enable CONFIG_PCI_INIT_R")
>>>>
>>>> this commit removes it again
>>>> 191ece249a96 ("rockchip: rk3588-rock-5b: Enable support for PCIe SATA 
>>>> cards")
>>
>> Ah, I should have checked the history. Sorry.
>>
>>> What use-case are you trying to solve with a forced pci enumeration?
>>>
>>> With standard boot Ethernet should be enabled when it is needed.
>>>
>>> However for EFI boot Ethernet maybe is not detected? Please see [1] for
>>> a possible alternative patch that I created when someone reported an
>>> issue with iPXE boot some time ago.
>>>
>>> I did not get confirmation it fully solved the issue, from what I could
>>> test it should help get Ethernet detected during EFI boot on a ROCK 5B.
>>>
>>> [1] https://github.com/Kwiboo/u-boot-rockchip/commit/90b6d787de0b3e6ed863440be576b01d83ba5789
>>
>> LAVA by default has a U-Boot script doing the following (IIUIC across all
>> boards), which fails with the current setup:
> 
> If you run a boot script you can easily add 'pci enum' before 'dhcp' and
> Ethernet will work for you LAVA script.

Look like something like following in device-types/rk3588-rock-5b.jinja2
could work for LAVA:

{% set uboot_ipaddr_cmd = 'pci enum; dhcp' %}

Regards,
Jonas

> 
>>
>> setenv autoload no
>> setenv initrd_high 0xffffffff
>> setenv fdt_high 0xffffffff
>> dhcp
>> setenv serverip 192.168.201.1
>> tftp 0x0400000 16212093/tftp-deploy-or30pzbe/kernel/vmlinuz
>> tftp 0xa200000 16212093/tftp-deploy-or30pzbe/ramdisk/ramdisk.cpio.gz.uboot
>> setenv initrd_size ${filesize}
>> tftp 0xa100000 16212093/tftp-deploy-or30pzbe/dtb/rk3588-rock-5b.dtb
>> setenv bootargs 'console=ttyS2,1500000n8 root=/dev/nfs rw nfsroot=192.168.201.1:/var/lib/lava/dispatcher/tmp/16212093/extract-nfsrootfs-e0aw1qlf,tcp,hard,v3 rootwait ip=dhcp'
>> booti 0x0400000 0xa200000 0xa100000
>>
>> Basically it comes down to missing network support when breaking
>> into the U-Boot shell. Also while it is obvious one needs to
>> enumerate the PCI bus for U-Boot developers with knowledge about
>> the Rock 5B, it's unexpected for people with less knowledge. So I
>> think it's sensible to have a default configuration supporting
>> network in the U-Boot shell without extra steps.
> 
> Unfortunately forcing a pci enumeration slow down booting from faster
> boot media, adding at least one second pci timeout delay and an error
> being logged for each unoccupied M.2 slot.
> 
> For normal use, standard boot automatically enumerate pci and Ethernet
> once needed, if that is not working then that is an issue to be solved.
> 
> PCI_INIT_R was rejected earlier because it forces unnecessary slower
> boot times on any user not booting from Ethernet.
> 
> With use of a boot script, the script should be capable/responsible to
> load any resources that is needed for its custom boot flow.
> 
> Regards,
> Jonas
> 
>>
>> -- Sebastian
> 

