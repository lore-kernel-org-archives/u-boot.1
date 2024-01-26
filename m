Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82F6C47DDF
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 12:58:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CC1587C3E;
	Fri, 26 Jan 2024 13:58:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="R0vxGC5U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DC7287C3E; Fri, 26 Jan 2024 13:58:42 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4658987808
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 13:58:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1706273919; x=1706878719; i=xypron.glpk@gmx.de;
 bh=PNsoL/6puPYd2B8NamnwhcJ+gcYGlokyUbX7Blxt50o=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=R0vxGC5Ua3ZtIPgDKrhahLHAv3dOo+XleZAqLOv2x4NgCEP/M75bjnYKIUrLucQs
 DfC8uYcIYCnTaiMZ5DSViBi+7sJtTMoFeaJBAWRHGQS4ab5an/CCnW8XXqkrhbNFS
 aJK2ZPXG/Mr8+5EpJhhRtrD32EHDBFvzSVArfEdTMk/KLNeilCWx1mIe/Fux9tGHD
 mr0+MAfzeiWTcOj8/HYLwOCMBqs8pCTJahOd2TP3idrWkYK1IHll95MA/d6JL2HSl
 lCwwNVOp2O+A/TUXo2Kl0gyubYSOnt31stGMlDPPQuklI/9r1ssAftVYc9pW1C/Y7
 8QafQi75oyeZvXqL3Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEFzr-1rLL221Kab-00AGju; Fri, 26
 Jan 2024 13:58:39 +0100
Message-ID: <f5dc6d03-985f-4ab3-a6fb-eaa87593d630@gmx.de>
Date: Fri, 26 Jan 2024 13:58:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: check efi_get_variable_int return value
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20240122072617.1104227-1-masahisa.kojima@linaro.org>
 <5da90978-3d5d-4458-b2c9-476a7e390406@gmx.de>
 <CADQ0-X8mRuLnG132hhNr4tZF+9neb=8wjrjBXbJ_bx8LfdhL2w@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CADQ0-X8mRuLnG132hhNr4tZF+9neb=8wjrjBXbJ_bx8LfdhL2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HVBa6YTkcF08XgBrh5JdDQ2DSQBl0korzyoYhhkZA658bgtLvtA
 Zztseqasokero1+7Yh5QtLgNhJSc+tsFtmeVJv21cJCXMEOSgGrQndgnfkhepL69Ykqb6MK
 tMzSGiTBsj3bLPt/TsP3N7OXjI6r299xpIvkrcphtuX0DsFKCEzOcNpXpNQE4TPUwXZn+1W
 GYGOJ/o1EMlG4APyPAXsQ==
UI-OutboundReport: notjunk:1;M01:P0:uBIHnSClJow=;XqoKS6JnacRGrdAjlUzV3joOe3+
 HK76pyPtUW9v/2pWtIjCQb3WvGT8bQTl7DU1ZrC2my1cHk/tEI/3hp4HnxKUjRBnzAylvMgP5
 QsFKz+HlMctTuwLP73kX3FMNMjh3JsJuZb2XVaa49LGFGgGTX2BleSs/n1Z9k+1kw0KI6HgUV
 Xj2B2/aWUwVWyeYYR0XVPxgZNwbxA7AW81aJ7lSQhsETSFurqY6bJOrFN5dQ1bWLSnbvN2/45
 Uw2r7nNjdb1LMXRhymwjcf45rj7K+EOlQWssYJf9/FXcIWzkxWgQ69Rv3QAsw8YShJgDORv/6
 nk9r7yQhBkFGGR6YhT7802j2CEpOUP0P7J6QR229ktFR7BVv4KFQQc7LgmQjYO/fnEg9ocqe9
 shYadQC3s3bjpEsPKflRnEEHDtguDH+4sCG7aWCpJd276r/uhAz+Bu6LUQomLVsuw3gbLZ9BR
 ztjDSopszfjK+J/Yo536GRzKSjmPjBhdI4YdffEjxsAzBYUkm6zic6qyfiIpaCq20ehUitgwT
 /rFUYwJDlcwMlpLnmwwZzhYziuSnUZ4Kwyt+Gq7x72NFZgwQxBxc5/4oXbjk204amkiF0bfJm
 T8dYxyogRdrciXClJ2USqa9KgnNKmyLLw/Mc6oiTRBIIxWh+VFQperIJY1jqq39IG1fibF6Ha
 8pS3LAXvp9PHoGSQVa7079nejIJdFSu4CyTzSOxilcRuWX+7/8J5Ow1ev6YNrrHCHJETV9QMN
 64RzzJK7UQ1IvADKmexK+5MrQ/NbD4pmRfSTPdLURDR0pY6YYENOVWXbTeQm5oMWpC3lUFZ9E
 SOOsF3C8xC6/DU5dERQ6NvQIITjBH0eFM6TvkuNH1/GSfBn1i1yWLGuxdalYs+ALJ2dxSypHd
 zy8WfhnsD/OM7AWHed+Qaf+1MQoYFgrWjW4ECFKuJ5H6uk+Ex2ozCas6Mm9o3maQBBUIbp2rc
 7lWXvgM7NOAL5B9ApMTZ/KhcZX4=
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

On 26.01.24 12:36, Masahisa Kojima wrote:
> Hi Heinrich,
>
> On Fri, 26 Jan 2024 at 16:20, Heinrich Schuchardt <xypron.glpk@gmx.de> w=
rote:
>>
>> On 1/22/24 08:26, Masahisa Kojima wrote:
>>> efi_get_variable_int() may fail, the buffer should be
>>> cleared before using it.
>>>
>>> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
>>> Addresses-Coverity-ID: 478333 ("Error handling issues")
>>> ---
>>>    lib/efi_loader/efi_firmware.c | 8 ++++----
>>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmwa=
re.c
>>> index 9fd13297a6..fb83fa8113 100644
>>> --- a/lib/efi_loader/efi_firmware.c
>>> +++ b/lib/efi_loader/efi_firmware.c
>>> @@ -407,11 +407,11 @@ efi_status_t efi_firmware_set_fmp_state_var(stru=
ct fmp_state *state, u8 image_in
>>>        /*
>>>         * GetVariable may fail, EFI_NOT_FOUND is returned if FmpState
>>>         * variable has not been set yet.
>>> -      * Ignore the error here since the correct FmpState variable
>>> -      * is set later.
>>>         */
>>> -     efi_get_variable_int(varname, image_type_id, NULL, &size, var_st=
ate,
>>> -                          NULL);
>>> +     ret =3D efi_get_variable_int(varname, image_type_id, NULL, &size=
,
>>> +                                var_state, NULL);
>>> +     if (ret !=3D EFI_SUCCESS)
>>> +             memset(var_state, 0, num_banks * sizeof(*var_state));
>>
>> Hello Masahisa,
>>
>> We allocate var_state with calloc(). So it is cleared before we call
>> GetVariable(). Do we have an implementation of GetVariable() that would
>> fill it with data before returning an error code?
>
> No, current GetVariable() implementations do not fill the buffer
> when GetVariable() returns an error.
> This is why my original implementation does not clear the buffer in
> case of error.
>
> Anyway, I agree with your previous comment.
> I think it is better to clear the buffer in case of error for safety,
> because UEFI spec does not say GetVariable() will not fill the
> buffer in case of error.

In this case I guess malloc() is good enough. No need to use calloc().

Best regards

Heinrich

>
> Thanks,
> Masahisa Kojima
>
>
>>
>> Best regards
>>
>> Heinrich
>>
>>>
>>>        /*
>>>         * Only the fw_version is set here.
>>

