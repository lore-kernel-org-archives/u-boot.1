Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06786C47077
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 18:44:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C6FC8796E;
	Tue, 16 Jan 2024 19:44:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="B9RcTXO7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E17B08751B; Tue, 16 Jan 2024 19:44:29 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65DF087978
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 19:44:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1705430665; x=1706035465; i=xypron.glpk@gmx.de;
 bh=a/3oms70OL7kv0UHS3FEzepfVf7CwfwfIb3BxGDA9vk=;
 h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:
 In-Reply-To;
 b=B9RcTXO7pSCE7Cija1tePfG+vNKsag3qSAmNoLIUTeOr6udGfyz05DWRG3jhFzmO
 Lugq4QIY/kFlxAoUmBsGh4OocGGDeKZ3GX0t3GMJXG3wyhbsBKgo6R9QPKcnfA1GZ
 Rjew3fyoO8v7lChL5FWRDaJkhsVotOXuuw+XIbFdgsfSooiPecOIOTnq7Io7op/1D
 j+ibmfxEkVPcdQ+S+vai+9Pg875HGnVloWZM+DrC60RM6EshUmmcwUiafVm44X+JA
 zs/3mW4oDBF9ogfnUSgKeIQuclY5cy0KGakOtqEbjDIQgKuvhFW8UPJbwkFbGY5qN
 toIjNeEQoTy4ipFY9A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mq2nK-1qlZnf3Itm-00n5g5; Tue, 16
 Jan 2024 19:44:25 +0100
Message-ID: <ddc1e7d2-c70d-4a7d-884a-6a18db3ea1c5@gmx.de>
Date: Tue, 16 Jan 2024 19:44:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] efi_loader: rename BOOTEFI_BOOTMGR to EFI_BOOTMGR
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
References: <20240110011637.174710-1-takahiro.akashi@linaro.org>
 <20240110011637.174710-3-takahiro.akashi@linaro.org>
 <1c42a17d-1043-4449-93c2-9020c1ded71d@gmx.de> <ZaSDUrTQ2Z5N+gil@octopus>
 <d70d5134-1cc9-4d56-9aa3-499ed992584c@gmx.de> <ZaUFH3r9MdW+tHTv@octopus>
 <379beb70-c147-470d-ac45-ecc8c93a5f52@gmx.de> <ZaXfNy2V8y0N1o08@octopus>
Content-Language: en-US, de-DE
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org,
 ilias.apalodimas@linaro.org
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <ZaXfNy2V8y0N1o08@octopus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t1LHKdLddLyvaiFpTsJ0yS8JRL3/9beh1EIWagx4UkQz+aMY4KD
 s5PadJJYjlzVAtTq+Z+yiVg9M2kSUf+xSVExDUyorK0GGhSd0gVAjIIqsp6YYvI4Hx0Ew+S
 eQiU7AdnT4W7GKz9nbShm/NKDVBnTUMuNhLq9y9p1RlN8VhtTCAlMXixtlwM0svpcc45S3e
 VmHBYCWreOXrmsYkdzDvQ==
UI-OutboundReport: notjunk:1;M01:P0:AjQpCMhUxXE=;9cK1RcLDEYyrdM6w81m9dYIZL/Y
 QrtuGBBFRRc9514PnZD3GDF8NpKa0wdASfbYMAZ+CiYrOjm0X4yI4YDCDUeveG1loKZNLVbXv
 3jSfJ6XZNODrq5BiL1rrjDjo8qcbwfKWu4OLyh8GI0tAAZxKGEGt2aWXRU64HSpNyjU584RsI
 zyszerzRbPtAg+FqRt+usj5pQO6QydJlPOogPsmy16qoPprzcFcrcc3v2sDNbkC7s/z/Kd/sF
 FA7XnIkbTLoYgU9hMX90dtuXajRZd1Cj6EuZXmDaWBC460RounKk8AfByIPXdzpqhLM3aorhX
 teQ5XvauBQpjk6tDZxoecCQqwK/0M6th5FS2b/AdsU6yxTio8FLCHs+TQ3x8F9LxFPxCwQ2t5
 t/GANySfKBoKsaNUIhh+eypnEQ51PpDRoi7vrXlmvNgnWOtwep2HP9YTmowGvKyRXi9loGiM9
 ZQO0IQvbGsvrnDp/IDb5+wLvmPGc1sqDhOwaM0V/sNONrZz94WRA8E7aXYIjemAwxjCsc/idE
 bToD+02m2+T7ZAnO/vbkhRzzfFj3T5JUl78qMeU/44arxqFEe68y1P3HoTAlRJY2BQxTKo9kQ
 6jbEo9+mfkJ2qT+0ShmW9wLtZOY5Cqniu8AxT8BRD71xkHEKLZ52SMV+WlAU7yLOd698gN6vS
 Vu3/pqiVyv4gkSCK1FgazKDIGvQwvYmxrtU9ikMijfGSJFMur2oRxBeRhIFURLptynV37aWgS
 kHMVrlX5GbLUrlv2r14W2VEfNoxpKyUm8bY9W0sqxG8dVRFZ6mYZ5ZzsxCXoATlI3nTrJQWda
 PsEQ2EwHxaS/8GcQUfUaRIbkXgGerSqhIYqalJRsRZmQZj1HJAoZSwFOO2/swEQlME/rvlxnn
 cQ71sRQXkh8qO83GlKcKLBlo1EPsyJNLzU0BBkI+PGNQo80nT1S1cJ4FSlNoExCBeo1cnJsx7
 4nMTTpf/RzlYcsIgrhtq9CHSsxo=
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

On 1/16/24 02:43, AKASHI Takahiro wrote:
> On Mon, Jan 15, 2024 at 03:16:22PM +0100, Heinrich Schuchardt wrote:
>> On 15.01.24 11:12, AKASHI Takahiro wrote:
>>> On Mon, Jan 15, 2024 at 09:34:51AM +0100, Heinrich Schuchardt wrote:
>>>> On 1/15/24 01:58, AKASHI Takahiro wrote:
>>>>> On Sun, Jan 14, 2024 at 01:46:45PM +0100, Heinrich Schuchardt wrote:
>>>>>> On 1/10/24 02:16, AKASHI Takahiro wrote:
>>>>>>> At this point, EFI boot manager interfaces is fully independent fr=
om
>>>>>>> bootefi command. So just rename the configuration parameter.
>>>>>>>
>>>>>>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>>>>>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>>>>>
>>>>>> This patch breaks the 'bootefi hello' command in
>>>>>> qemu-riscv64_smode_defconfig and other QEMU defconfigs.
>>>>>
>>>>> What happened? Please elaborate details so that I can trace your iss=
ue.
>>>>>
>>>>> On my side, I didn't see any problem with "bootefi hello" on qemu-ar=
m64
>>>>> and moreover CI check (github pull request) didn't complain anything=
.
>>>>
>>>> The failures are logged in
>>>> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/19302
>>>
>>> In the logs for qemu-arm64, qemu-risc64 and maybe others as well,
>>> I see the same error:
>>> --- ---
>>> ______________________________ test_efi_grub_net _____________________=
__________
>>> test/py/tests/test_efi_loader.py:188: in test_efi_grub_net
>>>       addr =3D fetch_tftp_file(u_boot_console, 'env__efi_loader_grub_f=
ile')
>>> test/py/tests/test_efi_loader.py:136: in fetch_tftp_file
>>>       assert expected_text in output
>>> E   assert 'Bytes transferred =3D 520192' in "*** ERROR: `serverip' no=
t set"
>>> --- ---
>>>
>>> This seems to be the root cause and my commit will have nothing to do
>>> with the problem.
>>> Please check the test environment.
>>
>> You are looking at test_efi_grub_net. I referred to 'bootefi hello',
>> i.e. test_efi_helloworld_builtin:
>>
>>
>> ----------------------------- Captured stdout call
>> -----------------------------
>> =3D> bootefi hello
>>
>> =3D>
>>
>>
>> The command does not provide any output.
>
> Ah, yeah, but
>
>>>
>>> -Takahiro Akashi
>>>
>>>> I have pushed the tag failed_20240114 to
>>>> https://source.denx.de/u-boot/custodians/u-boot-efi.git for analysis.
>
> While I compiled this code and tried to run "bootefi hello",
> I could not reproduce this issue, always seeing the right output
> either on qemu-arm64 or sandbox64.
> (I also invoked test_efi_loader/efi_helloworld_builtin locally,
> but the test passed.)
> So no clue.

Please, rebase your patch set upon origin/master and retry the tests.

Best regards

Heinrich

