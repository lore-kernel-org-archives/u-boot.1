Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F28E4E77170
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 18:06:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87C20894F9;
	Thu,  5 Dec 2024 19:06:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ln7PqMoB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B78EF89506; Thu,  5 Dec 2024 19:06:39 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9474B891B1
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 19:06:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1733421991; x=1734026791; i=xypron.glpk@gmx.de;
 bh=GyyhQJ3H11CULzdh7V/SW3k0ipAQUsX7uTk+IgeScdc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ln7PqMoBhHqbhamEh7R9hcyXVmA5KQkhZw+iMlvClAnloRfExcXSbr4D5pP/r7LS
 iuSZ1jddipDPMOZ21gml+69/anKYq8QrbdIdHfLJn6j43U424LQdDsEo9kO66sM8o
 gA2wdvFpmv+IJiKEtMT9pMId160RAITLQOrMTsjJTgmA4VkZDV1UzsWBw22JQT+Bi
 7CwVHhyATsmyVg/UGK/3SqfTCSSahX5uYXyyj96fw6RWNceZakRTmQ5UouqDy16ZK
 ENkCgsF3aJr9g1eMk9Oh9ABHp7sZ/6iT92KIgL3mTyZx7hNOvBvRLxU+G+U8fYnMG
 Wyu/4/LErQS6VPod4Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ml6qC-1u4Nh51GpQ-00kcuk; Thu, 05
 Dec 2024 19:06:31 +0100
Message-ID: <a6650f01-b3c5-4a16-863f-33e441ef6e44@gmx.de>
Date: Thu, 5 Dec 2024 19:06:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/14] efi_loader: net: set EFI bootdevice device path
 to HTTP when loaded from wget
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
 Tom Rini <trini@konsulko.com>
References: <20241204030530.2099776-1-adrianox@gmail.com>
 <20241204030530.2099776-8-adrianox@gmail.com>
 <20241205013018.GA1377816@bill-the-cat>
 <38d341ba-7690-496e-bace-60604219f174@gmx.de>
 <20241205151924.GL2457179@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241205151924.GL2457179@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nY8o7ZFATariaDiqnyf13omkQ2B+ocRkCriTj5LGwlkBHCNPR4A
 tB6xvGW3PvwgrHq0zri+ua9MDt5qpbR+Xid2Ry4KqRfqWqU45/AXcw0XuTUlySNW15d/1Jg
 QSu5uuRpznxvUPEo+Yuw8y2JnHEX5erWqDIi0EHGgWBiQL8rBo/Ozwf87HuinqxLb9pIyjk
 RO6ja/590fEbqjL5mQ6JQ==
UI-OutboundReport: notjunk:1;M01:P0:YcD00wyTlVk=;EvUu+77/PTn7nC79q4K1dV0c0GZ
 j7zf+pgSLEzl0foZ0XUOcC9WhVlXOIkls6waf+t0kj8jzhAfNC//x7kPpnKbC1mpZgp5iSoAz
 Qag8F/PVZEb61jneEVaD3hhkrW7wyetmd/kPdZ1q8b4rA9qrurAlMjpjmSxQOpYepfZbMIatZ
 +rFmLQz1wJRTRnroHbytrelbsPhMkPwVL/9WAYAouGeLljfC1P9w1C+DEUTT4o1/wtwPcxZlu
 ny2mVTfkZbLudB6Iox0/4Craa771l47KKsVjE+uHtkyRIa6HG1SF+tEZozhe5dFUOluXdyaFa
 zrU5eGz4AvWK6+Blkp+FcWbefDhbZuBW475N7Ca2LCxxe+vzJRnsF4kglu0HVuFdE/5bhMo98
 VWyKsJzuviq7wwqB5ZkM6w+e0EdjhInES2trgJhugGXeIyj4pFnegwWtmftI4cUQJDHvO/I/D
 IClLD9duuAItAo0E0mSZx0rWhrmRujv1KHdEF/5axTlTvyhZm+PtcjWnGSwD63pxRu/IQ82i6
 hfZoT4JPF7zMimp02kPhNGk2IhSWoOdoAv2NvYbshBkZ9WZBItvE9BYv1akeFCYETJ2RHJ/7u
 vTNXQ7q9UDY8MkwCgJxnyMydzsWwvTtfzqRba7EmP9jY8/bJ8qnT19GFTy1B/tKRCEb/JoNnn
 aUFRV2Vb6JlYooYqvUyOlVShUoV4Bvyt9x37wSWIg3w/lvCjLUDpXOu1o38fhpktS+1JkPs3m
 PKtO7l6AhENFJ11Qzum2VaiG4sBK5gTJIj3+ahH7b06Jlv1m11swLa95Rx/KIa5szMXKKE8lX
 al5bifWKhCAZsepiK4MOo0ADDBsSxcJG/jpTudCF/uKwulZDjpx/sG8Xi2IpX0c0U8wgQvMm8
 v4QETqjfSfbUtUlAbWWe4V4nfG4QxKRUd0gBdITgHLQPGM4xyjVtjRbx+wXBguBlUvaRbdkyp
 CWgfFKz2naLrpOCgZkUhCXcJ0JMOZ4rCuo87Xh33xczEwKRdPsOersebuQp7mgcOEBfh6azjd
 tJykzB2pvS+m8WkRK5Vm6yFqln2R3fs0P4WGPQecJ2/90b88GjiipQrz1txvvUo8GzDsNSte1
 5FjIkmor5cO/Wc8vT+XxSeuVoOF06b
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

On 05.12.24 16:19, Tom Rini wrote:
> On Thu, Dec 05, 2024 at 10:00:11AM +0100, Heinrich Schuchardt wrote:
>> On 05.12.24 02:30, Tom Rini wrote:
>>> On Wed, Dec 04, 2024 at 12:05:23AM -0300, Adriano Cordova wrote:
>>>
>>>> Set the device path of the efi boot device to an HTTP device path
>>>> (as formed by efi_dp_from_http) when the next boot stage is loaded
>>>> using wget (i.e., when wget is used with wget_info.set_bootdev=3D1).
>>>>
>>>> When loaded from HTTP, the device path should account for it so that
>>>> the next boot stage is aware (e.g. grub only loads its http stack if
>>>> it itself was loaded from http, and it checks this from its device pa=
th).
>>>>
>>>> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
>>>> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>>>
>>> I know this is applied now, but after re-checking some things in one o=
f
>>> my labs, this breaks test_efi_helloworld_builtin on rpi_3 at least (an=
d
>>> possibly others). There is no output from "bootefi hello".
>>>
>>
>> Hello Tom,
>>
>> None of the Raspberry Pi 3 related defconfigs enables bootefi hello:
>>
>> rpi_3_32b_defconfig # CONFIG_CMD_BOOTEFI_HELLO is not set
>> rpi_3_defconfig # CONFIG_CMD_BOOTEFI_HELLO is not set
>> rpi_3_b_plus_defconfig # CONFIG_CMD_BOOTEFI_HELLO is not set
>> rpi_arm64_defconfig # CONFIG_CMD_BOOTEFI_HELLO is not set
>>
>> Which configuration have you been testing?
>>
>> Please, supply the .config and the related test log.
>>
>> I just tested pinea64-lts_defconfig with CONFIG_CMD_BOOTEFI_HELLO=3Dy a=
nd get
>>
>> =3D> bootefi hello
>> Card did not respond to voltage select! : -110
>> Booting /MemoryMapped(0x0,0xbdfbe9b0,0xbdfc1b60)
>> Hello, world!
>> Running on UEFI 2.10
>> Firmware vendor: Das U-Boot
>> Firmware revision: 20250100
>> Have device tree
>> Load options: <none>
>> File path: <none>
>> Boot device: /MemoryMapped(0x0,0xbdfbe9b0,0xbdfc1b60)
>>
>> So there seems to be no generic problem.
>
> For testing as much as possible, I do enable a number of additional
> options (as well as building them with clang). In this case, please try
> also enabling CONFIG_CMD_WGET. I've narrowed my config changes down to
> adding both CONFIG_CMD_BOOTEFI_HELLO=3Dy and CONFIG_CMD_WGET=3Dy to
> rpi_3_defconfig which results in:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D test session starts =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> platform linux -- Python 3.11.2, pytest-6.2.5, py-1.11.0, pluggy-0.13.0
> rootdir: /home/trini/u-boot/u-boot/test/py, configfile: pytest.ini
> plugins: forked-1.6.0, xdist-2.5.0
> collected 478 items / 424 deselected / 54 selected
>
> test/py/tests/test_efi_fit.py s                                         =
 [  1%]
> test/py/tests/test_efi_loader.py .....F
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D FAILURES =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> _________________________ test_efi_helloworld_builtin __________________=
________
> test/py/tests/test_efi_loader.py:208: in test_efi_helloworld_builtin
>      assert expected_text in output
> E   AssertionError: assert 'Hello, world' in ''
> ----------------------------- Captured stdout call ---------------------=
--------
> U-Boot> bootefi hello
> U-Boot>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D short test summary info =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> SKIPPED [1] test/py/conftest.py:620: .config feature "fit" not enabled
> FAILED test/py/tests/test_efi_loader.py::test_efi_helloworld_builtin - A=
ssert...
> !!!!!!!!!!!!!!!!!!!!!!!!!! stopping after 1 failures !!!!!!!!!!!!!!!!!!!=
!!!!!!!!
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 1 failed, 5 passed, 1 skipped, 424 des=
elected in 27.01s =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>

Hello Adriano,

The following command sequence reproduces the problem on my Raspberry Pi 3=
:

U-Boot> setenv autoload no
U-Boot> dhcp
lan78xx_eth Waiting for PHY auto negotiation to complete...... done
BOOTP broadcast 1
DHCP client bound to address 192.168.1.83 (109 ms)
U-Boot> setenv autoload yes
U-Boot> tftpboot 192.168.1.2:/arm64/helloworld.efi
lan78xx_eth Waiting for PHY auto negotiation to complete...... done
Using lan78xx_eth device
TFTP from server 192.168.1.2; our IP address is 192.168.103.83
Filename '/arm64/helloworld.efi'.
Load address: 0x1000000
Loading: ##################################################  4.4 KiB
          198.2 KiB/s
done
Bytes transferred =3D 4480 (1180 hex)
U-Boot> bootefi $loadaddr
Card did not respond to voltage select! : -110
Booting /\arm64\helloworld.efi
Hello, world!
Running on UEFI 2.:
Have device tree
Load options: <none>
U-Boot> wget 192.168.1.2:/hweb/arm64/helloworld.efi
lan78xx_eth Waiting for PHY auto negotiation to complete...... done
HTTP/1.1 200 OK
Packets received 7, Transfer Successful
Bytes transferred =3D 4480 (1180 hex)
U-Boot> bootefi $loadaddr
Booting /\hweb\arm64\helloworld.efi
Hello, world!
Running on UEFI 2.:
Have device tree
Load options: <none>
U-Boot> bootefi hello
U-Boot>

I was not able to reproduce the problem with only TFTP or only wget.

qemu_arm64_defconfig shows the same issue.

efi_install_multiple_protocol_interfaces() called in efi_run_image()
returns EFI_ALREADY_STARTED.

With a debug message enabled we get this output:

Path /MemoryMapped(0x0,0x7f762d10,0x7f765ec0) already installed

We have to these things to check:

* Why do we miss to uninstall the memory device-path when executing
'bootefi $loadaddr'?
* Why do we generate a memory device-path for either TFTP or wget?

Best regards

Heinrich
