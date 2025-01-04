Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15899E77188
	for <u-boot@archiver.kernel.org>; Sat,  4 Jan 2025 01:11:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13B5B80295;
	Sat,  4 Jan 2025 02:11:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="LzsyKw2u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCE13802EF; Sat,  4 Jan 2025 02:11:17 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D2AC801F5
 for <u-boot@lists.denx.de>; Sat,  4 Jan 2025 02:11:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1735953075; x=1736557875; i=xypron.glpk@gmx.de;
 bh=Z7HHUevRLyXMXntAJbl/0MyZmyxmgAB/RdC1t4XGWpk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=LzsyKw2uJuV4zl7bEaTfnxnLwtzo1DMuzB5HZoxzQl55UiFOUq9dO8m109KZg94v
 aJBwTXdF26Ey1dEHrTnc3LJYQS9glbbQQ0fwvAK0d1wVANUFBz7mahH+1rw/PSDcP
 ZXyd0c5kkbzgxxoVNGLCUvfZdDNc+Wtnl860cRNlC8fivzoZ6En0dHcTUTzgxvjCr
 OBaG2SuW+t1RR+IVhIV/sf0mrspaU5qvfRTB8ePzeAZX0gbOb10rnHlnlMliKHG7X
 Wjf5pPwR5DPwM9Mti+IFRb0+4EdOn5r4FFyEg911c0MUR8ugpYp38K/EIlbwewIC5
 clJ2lJoIIaBELMloPw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.109.94]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MuDbx-1tkaCd3nsD-00rV9q; Sat, 04
 Jan 2025 02:11:15 +0100
Message-ID: <aa40e092-8ae4-4b26-8924-4edf2de5fe48@gmx.de>
Date: Sat, 4 Jan 2025 02:11:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] config: efi-x86_payload: Enable DEBUG_UART
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
References: <20241128114737.1.I9eac706713ffc05dccc51ad3d60833a179c9e83d@changeid>
 <20241128114737.2.I03b59e1d26d2a79a666adc8ef313077da8dce145@changeid>
 <c31b3d7a-c840-4b3d-a6fe-90f9a576ffb4@gmx.de>
Content-Language: en-US
In-Reply-To: <c31b3d7a-c840-4b3d-a6fe-90f9a576ffb4@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1ZyoHrUSt+Lg2pJ/HMHMmZEtOrSJBkDD7y21TgyjJzLQHPuJ31W
 OUmOlaFWSYqPOCelCE/NiU/EtgVGttomXjWYu+xGThjPLIWXrLnVxuaz/zFxAd5dlkhZtxR
 3S4da+XLW4JmjRMMZf6ImMKuyPB/TVIADLGxGQR81Z9krSwfhs7uXhUvJVPdNhORqdY5Upq
 1g+j388G0A7qj9NT5tWeA==
UI-OutboundReport: notjunk:1;M01:P0:3JIVOuyiLdo=;wCQVZ84+9kURtIEx5I7legVskgS
 e5z6GlFuKmMWhPbj/EQNZ1fC2KJXWwjeXo04dtDhqZ4RXKCj4IwznN1xkwSvNVW0n57Lk6smd
 r7Oup2ItWQXNfbNQe0hpTruqdRuKBms3P2fZlwVrGUgxw+BPpveaJUbtVcL4VrNueAJ1qR2Sc
 YaCPluKxoAI2POe9YtwSvdU1uSl3dCEzbKpvEJ9PCrG1DpHVn+4IU1Btu44BqCKVZFqhNnMni
 YxvblJ73RTtOKTjmVJH6Fj5ZvGur0LqBiMq9Q3CZen0wcmDgSdEw5QsayPTzsltSfJsPvxhTF
 Qalw/JxD8qgBdxLDShEZKFaOhCjtaJ1fdxpkLdOKheqCwion9a9k9wg34DDixxaRSXqOFciZi
 qBR85TwfBtkc0zrMcwgizhzoSjXeslVF8H4k0PwpT3Tyz0pkZdZxKgYMkVByRmbQJw0jh0ccR
 CvSxErCVX6c/rHH4MRkFqiMKnpjnbbTUIcuNy3SpxNOn3oHBHNRz3Z7pBxrSaaArKJCsh49gK
 UxxmuopTMveJn62F6INFENVgvJynoJSBKaDlUkzmmyWauXstzUEjfX0OIrVz3QvtMAmSlEGEh
 dNg24swX4jk9zNcOE64Cq7w7jZa1YqR4vUhQ+DIvXg0gVqQAUx/2b+HGZ1btlTLfvcWTmlzn2
 3LU6fPn4R1YDsYybcFP6vh9vKhlYecXzl9yNGNqCeTYMLR/9yrqHTlvEAnma8mJkabg0In2N4
 O0QgwYSf7UTiZdFXFOvc8VDmZr1vHeKx/hAaA+ZJbb6sWa+4V2FRayvqN7pyTudKbUlqIuUQS
 Pn/60YbfgGk8vB/6RhLiLX3zkdcLlhMicOlIywrJwBR58CLlexLSIdx+SnQyeh7SEDTQUD0s9
 rk2+Yi4cBJvbc+BDVPaeTroNj4RdOreLj4KSDN0tuS94dLFqTGPuwxeXjVa2+wThE1VfzsgUe
 lAuNOvqk9blK7uhGDEmiKFpZcKmlaplzffQvOa1kZX0T/GxLB+aeeqmPUEM0DesbSHxjqag8N
 Pg6d40MJuz5LOUFdX9CCxaARAZ5+8vMPpbNq1FwAWz5a9dFa6NLeFx4nGo192KKYaI270ADNM
 T1FzE74MU8bNBLpkR2u0pT8N3YI7SZ
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

On 1/3/25 17:16, Heinrich Schuchardt wrote:
> On 28.11.24 04:47, Kever Yang wrote:
>> The efi_stub is useing DEBUG_UART interface by default, Enable it.
>
> As Simon already wrote in a code comment the implementation of the EFI
> stub is broken as it is not hardware agnostic.
>
> In the EFI stub we should never directly access hardware. Please, use
> SimpleTextOutputProtocol.OutputString() for printing.
>
>>
>> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
>> ---
>>
>> =C2=A0 configs/efi-x86_payload32_defconfig | 1 +
>> =C2=A0 configs/efi-x86_payload64_defconfig | 1 +
>> =C2=A0 2 files changed, 2 insertions(+)
>>
>> diff --git a/configs/efi-x86_payload32_defconfig b/configs/efi-
>> x86_payload32_defconfig
>> index 071ddb8e36d..f0b9acc358d 100644
>> --- a/configs/efi-x86_payload32_defconfig
>> +++ b/configs/efi-x86_payload32_defconfig
>> @@ -5,6 +5,7 @@ CONFIG_DEFAULT_DEVICE_TREE=3D"efi-x86_payload"
>> =C2=A0 CONFIG_PRE_CON_BUF_ADDR=3D0x100000
>> =C2=A0 CONFIG_VENDOR_EFI=3Dy
>> =C2=A0 CONFIG_TARGET_EFI_PAYLOAD=3Dy
>> +CONFIG_DEBUG_UART=3Dy
>
> On x86 this uses the NS16550 UART driver. This is fine as long as we
> don't use the debug UART in the EFI stub. But correcting this is for a
> separate patch.
>
> Having a debug UART available after the EFI stub makes sense.
>
> I will update the commit message when merging.
>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>
>> =C2=A0 CONFIG_EFI=3Dy
>> =C2=A0 CONFIG_EFI_STUB=3Dy
>> =C2=A0 CONFIG_FIT=3Dy
>> diff --git a/configs/efi-x86_payload64_defconfig b/configs/efi-
>> x86_payload64_defconfig
>> index 71612d7fb19..b02a861e59c 100644
>> --- a/configs/efi-x86_payload64_defconfig
>> +++ b/configs/efi-x86_payload64_defconfig
>> @@ -5,6 +5,7 @@ CONFIG_DEFAULT_DEVICE_TREE=3D"efi-x86_payload"
>> =C2=A0 CONFIG_PRE_CON_BUF_ADDR=3D0x100000
>> =C2=A0 CONFIG_VENDOR_EFI=3Dy
>> =C2=A0 CONFIG_TARGET_EFI_PAYLOAD=3Dy
>> +CONFIG_DEBUG_UART=3Dy

Building fails without a value DEBUG_UART_BASE.

Looking at function putc() in lib/efi/efi_stub.c I guess this should be
DEBUG_UART_BASE=3D0x3f8.

Best regards

Heinrich

>> =C2=A0 CONFIG_EFI=3Dy
>> =C2=A0 CONFIG_EFI_STUB=3Dy
>> =C2=A0 CONFIG_EFI_STUB_64BIT=3Dy
>

