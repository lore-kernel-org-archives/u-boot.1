Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D53CCD4F3C
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 06:52:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A83BF84150;
	Mon, 18 May 2026 08:52:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="UaULmac9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11F7084659; Mon, 18 May 2026 08:52:43 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EAD883EF9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 08:52:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1779087159; x=1779691959; i=xypron.glpk@gmx.de;
 bh=H0m0VpmnJvV38gietlK2LwjFJ3GKHspFMGo0TE2H6YQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=UaULmac9TcYXZnZsc3tUUaUqjXAavwm9dYisjSVRL+dsiZUjcplTr9YpTJX4l5Ct
 ruXdI8VL3EDKSRL+fRFrVWgm6+T3NdXdITyN/dP0jWRPrvSiyad9SdK/C2D9vNUa5
 4I+03496rfDT5NhmIkpZKrKjpds1utwbeGsI0LLsztfzYmT94q0QgoY6zY3gltXDS
 NY0Y4DdMLMFPfW/XGzp6Tl66vBVCflusr0LbgOs3dB/yCKSmj8CHpABxBY4tqHW2L
 8XUCyYk+o4Axz5tA6sx6dgXkMtjjYMRrpjNXynnxJIkjchlPfQZhU2/734hJy3P3r
 XvaoY9OgA6xFwLTH2Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MkHQh-1x4mA33VHd-00q8L4; Mon, 18
 May 2026 08:52:38 +0200
Message-ID: <3fd04756-f3a3-4d24-bb60-1d226f49057a@gmx.de>
Date: Mon, 18 May 2026 08:52:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tools: efivar: strip auth descriptor for authenticated
 variables
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: trini@konsulko.com, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20260514171649.3708107-1-aswin.murugan@oss.qualcomm.com>
 <CAC_iWj+bgFhPbxNH-BqU1fFD0j3wzBE_9FT_kfhZ-r48Ztb7pQ@mail.gmail.com>
 <da733868-79d2-4425-acd1-f1a9ce83feba@oss.qualcomm.com>
 <CAC_iWjJg=fGVUk2hVPH2=eo4JGYeRsOPhr0p94YxzmffKCMvRg@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAC_iWjJg=fGVUk2hVPH2=eo4JGYeRsOPhr0p94YxzmffKCMvRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RcoQi1AUIQMMnGt2o59y0G2RhHxt8rV8K4B3FPio4YhwMe39eoe
 PQB8xQpiKikFuRPu1zZaETuKpab4qaMTr2x3LKqx2dnanL0Ys8NMQwRH25aQl+8lievOynV
 9FUa0fE17JwiBrzvJrwHHyCT1pWUEftprdrURbJtXiYwRvUW5u9w1u2/09CNi8YzJKkbErs
 O/nLNw/toLgwhyvZoqtoA==
UI-OutboundReport: notjunk:1;M01:P0:PcnIK3pMVRE=;HPBhpmRDv4u8BFbX/3r1P6G8aQE
 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
 1Zcgyg7ARlpPYPEiSk9eR69wSM0=
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

On 5/15/26 15:31, Ilias Apalodimas wrote:
> On Fri, 15 May 2026 at 16:17, Aswin Murugan
> <aswin.murugan@oss.qualcomm.com> wrote:
>>
>> Hi Ilias,
>>
>> This change has been verified locally with our setups on qcs615 &
>> QCS9100 SOCs
>=20
> Alright, I'll have another look in case I missed something.
>=20
> Thanks
> /Ilias
>>
>> Regards,
>> Aswin
>>
>> On 5/15/2026 4:02 PM, Ilias Apalodimas wrote:
>>> Hi Ashwin,
>>>
>>> On Thu, 14 May 2026 at 20:17, Aswin Murugan
>>> <aswin.murugan@oss.qualcomm.com> wrote:
>>>> efivar.py currently stores authenticated variables including the
>>>> EFI_VARIABLE_AUTHENTICATION_2 descriptor (timestamp + WIN_CERTIFICATE=
)
>>>> along with the payload.
>>>>
>>>> When variables are set via U-Boot, SetVariable() validates and strips
>>>> this authentication descriptor before persisting the variable data,
>>>> resulting in only the payload being stored and returned by GetVariabl=
e().
>>>>
>>>> This mismatch causes efivar.py-generated stores to differ from U-Boot
>>>> runtime behavior and leads to incorrect GetVariable() results.
>>>>
>>>> Update efivar.py to strip the authentication descriptor and store onl=
y
>>>> the payload for authenticated variables, ensuring consistency with
>>>> U-Boot behavior and compliance with UEFI expectations.
>>> The approach is fine, but when I use the tool now to create signatures
>>> and enable secure boot I am getting
>>> =3D> bootefi bootmgr
>>> Getting signature database(db) failed"
>>>
>>> Have you tried a built that worked locally?
>>>
>>> Thanks
>>> /Ilias
>>>> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>>>> ---
>>>> Changes in v3:
>>>> - Previously stripped the authentication descriptor at GetVariable(),
>>>>     now moved to strip it in efivar.py during variable pre-seeding/se=
t.
>>>> Link to v2: https://lore.kernel.org/u-boot/20260512194205.1905069-1-a=
swin.murugan@oss.qualcomm.com/
>>>>
>>>> Changes in v2:
>>>> - Enhanced commit message with explicit UEFI spec reference
>>>> Link to v1: https://lore.kernel.org/u-boot/20250725123653.513252-1-as=
win.murugan@oss.qualcomm.com/
>>>> ---
>>>>    tools/efivar.py | 50 +++++++++++++++++++++++++++++++++++++++++++++=
+++-
>>>>    1 file changed, 49 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/efivar.py b/tools/efivar.py
>>>> index 67729fa8505..d248cd868ba 100755
>>>> --- a/tools/efivar.py
>>>> +++ b/tools/efivar.py
>>>> @@ -79,6 +79,50 @@ class EfiVariable:
>>>>    def calc_crc32(buf):
>>>>        return zlib.crc32(buf) & 0xffffffff
>>>>
>>>> +def strip_auth_descriptor(data, attrs):
>>>> +    """
>>>> +    Strip the EFI auth descriptor from authenticated variable data.
>>>> +
>>>> +    This is used during efivar.py-based pre-seeding of ubootefi.var =
to
>>>> +    match U-Boot SetVariable() behavior, where the authentication he=
ader
>>>> +    is consumed during validation and only the payload is stored.
>>>> +
>>>> +    For variables with EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_A=
CCESS:
>>>> +    - Input format: [EFI_VARIABLE_AUTHENTICATION_2 | payload]
>>>> +    - Stored format: [payload only]
>>>> +
>>>> +    Auth header size calculation (aligned with U-Boot efi_variable_a=
uthenticate()):
>>>> +        auth_size =3D sizeof(EFI_TIME) + WIN_CERTIFICATE.dwLength
>>>> +
>>>> +    Only the payload portion is retained after stripping the header.
>>>> +    """
>>>> +    if not (attrs & EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCE=
SS):
>>>> +        return data
>>>> +    if not data:
>>>> +        return data
>>>> +
>>>> +    efi =3D EfiStruct()
>>>> +    if len(data) < efi.var_time_size:
>>>> +        return data
>>>> +
>>>> +    offset =3D efi.var_time_size
>>>> +    if len(data) < offset + efi.var_win_cert_size:
>>>> +        return data
>>>> +
>>>> +    try:
>>>> +        cert_hdr =3D struct.unpack_from(efi.var_win_cert_fmt, data, =
offset)
>>>> +        dwLength =3D cert_hdr[0]
>>>> +    except struct.error:
>>>> +        return data
>>>> +
>>>> +    auth_size =3D efi.var_time_size + dwLength
>>>> +    if auth_size <=3D 0 or auth_size > len(data):
>>>> +        return data
>>>> +
>>>> +    if len(data) <=3D auth_size:
>>>> +        return b''
>>>> +    return data[auth_size:]
>>>> +
>>>>    class EfiVariableStore:
>>>>        def __init__(self, infile):
>>>>            self.infile =3D infile
>>>> @@ -172,8 +216,12 @@ class EfiVariableStore:
>>>>                    break
>>>>                offs =3D loffs
>>>>
>>>> +        if data and (attrs & EFI_VARIABLE_TIME_BASED_AUTHENTICATED_W=
RITE_ACCESS):
>>>> +            data =3D strip_auth_descriptor(data, attrs)
>>>> +            size =3D len(data) if data else 0
>>>> +
>>>>            tsec =3D int(time.time()) if attrs & EFI_VARIABLE_TIME_BAS=
ED_AUTHENTICATED_WRITE_ACCESS else 0
>>>> -        nd =3D name.encode('utf_16_le') + b"\x00\x00" + data
>>>> +        nd =3D name.encode('utf_16_le') + b"\x00\x00" + (data if dat=
a else b'')

The EFI specification for SetVariable() has:
"A variable must contain one or more bytes of Data."

We should throw an error if data is empty (possibly after stripping an=20
authentication header).

Best regards

Heinrich

>>>>            # U-Boot variable format requires the name + data blob to =
be 8-byte aligned
>>>>            pad =3D ((len(nd) + 7) & ~7) - len(nd)
>>>>            nd +=3D bytes([0] * pad)
>>>> --
>>>> 2.34.1
>>>>

