Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14DEBC3DA79
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 14:16:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BCF687061;
	Mon, 15 Jan 2024 15:16:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Ov+JnxaJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 510C2876E7; Mon, 15 Jan 2024 15:16:32 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20BC786EF1
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 15:16:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1705328188; x=1705932988; i=xypron.glpk@gmx.de;
 bh=qQl0KOcL1MPLAeq3PsLeSMcPfHzHJNOebUkA+/YygvY=;
 h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:
 In-Reply-To;
 b=Ov+JnxaJ8/1ihBUzi6ytemi+ysDELEeIBfwvsbys/5MqUgy84BAjfl/yTeup0fby
 mnydEomM2mqQlSew+rN3e5GsJPfBqIB67hbGIpcEZDNt7Yjpe8rTknPMM9xisvGDv
 2dl9gk7PapHbAr/xmC4CSN6zmNamXunBUWlP43/h+yxluAdqoOpgRgmPeoo0hbcnt
 zxRE7CwR6tW6sJGvu541PFzLozT1+zRGCqNrpupoO9UyUw5ebOF1/tDS/6rSwZWrx
 xqAHpNnpyId7VgRAtI9FGIgTBPXuFX7gPC5f7sfa7IC9Bs/45lR9fFsRwlxcVigwH
 WC/JXt9Fc7M88g9yTQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxDou-1rEZ2S0m8e-00xeQe; Mon, 15
 Jan 2024 15:16:28 +0100
Message-ID: <379beb70-c147-470d-ac45-ecc8c93a5f52@gmx.de>
Date: Mon, 15 Jan 2024 15:16:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] efi_loader: rename BOOTEFI_BOOTMGR to EFI_BOOTMGR
Content-Language: en-US
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
References: <20240110011637.174710-1-takahiro.akashi@linaro.org>
 <20240110011637.174710-3-takahiro.akashi@linaro.org>
 <1c42a17d-1043-4449-93c2-9020c1ded71d@gmx.de> <ZaSDUrTQ2Z5N+gil@octopus>
 <d70d5134-1cc9-4d56-9aa3-499ed992584c@gmx.de> <ZaUFH3r9MdW+tHTv@octopus>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org,
 ilias.apalodimas@linaro.org
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <ZaUFH3r9MdW+tHTv@octopus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ko9cnWtNnL4/RTNdP99motg8jrqiBHboxQnYwIUZEfHS8tNJrOJ
 HdAKB5J5udH4W4HDzH5J4S3Q5eVCI6ciG+AQdE+1uRZBTNOd67gDbrE+mWaznq8G6pIwhLz
 63hVF06HeH/sLmGymAAAhxPTv0suMocNDn4h5nhG1469mp3UdKb3CYNej/RMAq9l8yo5hWs
 A4XzlxFRx7L3B3GN4jm9g==
UI-OutboundReport: notjunk:1;M01:P0:PohsQAbewbM=;CDoH8YZavZItNG8vlE4vgvkHQ+I
 txX2OZfMgaY9hGqSDw9aJViPYsL9YnmTPJJCtybuTT/1gUvFBHkjA+GnFA2XYoq2epFOcZqBO
 PHPDrB5w3NgfE8EWDGwYbUOSrhWECzrDdB7V5SocMbE4ySPniuo/MIoh2WrM3/6UKyA9zbaLI
 5i70NyoKXBIIp9nVKBlCcioZwyx5490jzIT9JDSKJ+5JT+IVz7A3wHBLAdsWft0FG8kmQU0NC
 PhdlU/EuztzMR9sHNKV0kWaHq83rg3wErFMm3mr1C6Kizoi0qunacVbVPCCivEQr7WbwAn4KQ
 DIF+EkSQjuCax8Q0RlAKkPKbI/G9NYU883uF5/az1aEhr1ifwt5Poyxdezf9cyv+dlNurlGiD
 8k7OEtuKadU7HVMOWScWzGIv5qspVM06xduhUdWfKDCwjmAxhYNuAtXj6YtQV4SRUy+8TM1Tq
 ASaoPgootzVyvguw65F8GKmgCeoiPYFVOSXS8cIz9JEVxa8Ixwvgs5rGfnOklgwSuMxgiMYsZ
 U6FkcN2ajDxP0MFgp/FHpeUTwnnCB2LyzIU6PrQbGVfG+7QvDelzaxn3EpcBzexhdJBq6Idhb
 4201JLEgxmTuQ/cOgRkwrM1ubKpM/BbJD8PCcBykFZd/Gq/smiRCFJU75FWakyNz8TXnQuPqB
 ej1rQWH7iS7jj6CiQBYmcSqnE2LsCPFJIRb54bE3iZYIlqYRPEE/0xM8wWidWwAyY3Tf7JgJK
 8S7sYG0Ng5obQ81UB1XwKmoa4NxSdG6SfDA6K/S8Uo334EMhBpS5j9s2SMSrs7iV0BMWO2nJi
 0iNSTj7oemV9xNXO2enMqaLjiVHmXtg1bGw7JVvBPAytoBw+0K3oGe7woOxZp3su33i4Wz5K+
 3F7P/o7ilKRI/X0pg21CHKP1HSEacVyeVMqVEr6wAXhbnA5Pd3BbHLvp+rDNToiW511Ekec9M
 UPeoVQDxvku9dTHio9jJrkMwZwk=
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

On 15.01.24 11:12, AKASHI Takahiro wrote:
> On Mon, Jan 15, 2024 at 09:34:51AM +0100, Heinrich Schuchardt wrote:
>> On 1/15/24 01:58, AKASHI Takahiro wrote:
>>> On Sun, Jan 14, 2024 at 01:46:45PM +0100, Heinrich Schuchardt wrote:
>>>> On 1/10/24 02:16, AKASHI Takahiro wrote:
>>>>> At this point, EFI boot manager interfaces is fully independent from
>>>>> bootefi command. So just rename the configuration parameter.
>>>>>
>>>>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>>>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>>>
>>>> This patch breaks the 'bootefi hello' command in
>>>> qemu-riscv64_smode_defconfig and other QEMU defconfigs.
>>>
>>> What happened? Please elaborate details so that I can trace your issue=
.
>>>
>>> On my side, I didn't see any problem with "bootefi hello" on qemu-arm6=
4
>>> and moreover CI check (github pull request) didn't complain anything.
>>
>> The failures are logged in
>> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/19302
>
> In the logs for qemu-arm64, qemu-risc64 and maybe others as well,
> I see the same error:
> --- ---
> ______________________________ test_efi_grub_net _______________________=
________
> test/py/tests/test_efi_loader.py:188: in test_efi_grub_net
>      addr =3D fetch_tftp_file(u_boot_console, 'env__efi_loader_grub_file=
')
> test/py/tests/test_efi_loader.py:136: in fetch_tftp_file
>      assert expected_text in output
> E   assert 'Bytes transferred =3D 520192' in "*** ERROR: `serverip' not =
set"
> --- ---
>
> This seems to be the root cause and my commit will have nothing to do
> with the problem.
> Please check the test environment.

You are looking at test_efi_grub_net. I referred to 'bootefi hello',
i.e. test_efi_helloworld_builtin:


=2D---------------------------- Captured stdout call
=2D----------------------------
=3D> bootefi hello

=3D>


The command does not provide any output.

Best regards

Heinrich


>
> -Takahiro Akashi
>
>> I have pushed the tag failed_20240114 to
>> https://source.denx.de/u-boot/custodians/u-boot-efi.git for analysis.
>>
>> Best regards
>>
>> Heinrich

