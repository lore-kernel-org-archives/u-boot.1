Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C552CC87FCA
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 17:18:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22F1A839D6;
	Fri, 25 Jul 2025 19:18:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="m+6lIQmb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FD51839E8; Fri, 25 Jul 2025 19:18:44 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC605839CF
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 19:18:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1753463913; x=1754068713; i=xypron.glpk@gmx.de;
 bh=/FV72h1vbEKzOwTH8A/j42f+9vkJqtf8K2A9lDBkkqk=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=m+6lIQmbH92e1JdNWeOPoCIruqEEZob3+vozbyQNO6dJA9cDzlv8FLnRcUk+5fXY
 ZcRZVENVYI0DwSyYk7WFSfIBN4rS+38TG4j1/CRonGsmB67MgQXyF5gqsClWrY7jK
 3KoSV6fL+F3PUJDyFHhmVtNBH43UJtuMZOla+hwzlntVoM5v1lCZroeT3e7BshPjh
 HwC0nQyvgi+hkS+Y7Wtf25tK0KQltme7cBTCSMH8DqUkh+d9a1wX3k3NG8lVSvJTC
 40TG7V+PWufYii5E0CMSemYerGrFSmR8vGjmW9xlZShq7XOAlErBKpKPQCQzdhjiS
 4RyQAuErs+cwHnJ63g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.110.103]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MF3DM-1uuh4C3ee0-00BPj7; Fri, 25
 Jul 2025 19:18:33 +0200
Date: Fri, 25 Jul 2025 19:18:30 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
CC: ilias.apalodimas@linaro.org, trini@konsulko.com, kettenis@openbsd.org,
 u-boot@lists.denx.de
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1=5D_efi=5Floader=3A_Remove_auth?=
 =?US-ASCII?Q?entication_header_in_efi_variable_data?=
User-Agent: Thunderbird for Android
In-Reply-To: <306cb986-34ed-4c17-94be-ded25800451f@oss.qualcomm.com>
References: <20250725123653.513252-1-aswin.murugan@oss.qualcomm.com>
 <d387c730-9d9d-49b6-9775-da5e69023a87@gmx.de>
 <306cb986-34ed-4c17-94be-ded25800451f@oss.qualcomm.com>
Message-ID: <9F595DB2-F612-40F2-966B-910E1BC41993@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E8OhBfppENGKo1Tq5+DxnTkx9sdu0oNS51vy0dO01uHIGSloZjA
 vsIiJZH9OCucWmev8BK/0BPfJjNbUM11Oq0/e1tPmc+2FVANWUCOxMdRLpDBS2Zp0SJ20EM
 gi1G06J/Ua+5RKMCG49ZCfaPsAwA36BPp+R7oBcs//LVaSc5v/qX7I8Cra0y2eJn4/skilt
 X+nL4cGZWVAI0KQH4cDCg==
UI-OutboundReport: notjunk:1;M01:P0:bGfu7ukRLjg=;nBCXQTd6dAaE/llAUskBWdUC9QO
 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
 SFx4ajxZ/+QmpK4KSb8ddo4=
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

Am 25=2E Juli 2025 19:11:57 MESZ schrieb Aswin Murugan <aswin=2Emurugan@oss=
=2Equalcomm=2Ecom>:
>
>On 7/25/2025 6:56 PM, Heinrich Schuchardt wrote:
>> On 25=2E07=2E25 14:36, Aswin Murugan wrote:
>>> efi_get_variable_mem() returned auth header along with ESL data for
>>> authenticated variables like PK, KEK, and DB=2E This caused issues in
>>> later stages where the auth header was misinterpreted as ESL data,
>>=20
>> Which later stages are you relating to?
>> In the current implementation of efi_signature_store()
>> https://source=2Edenx=2Ede/u-boot/u-boot/-/blob/master/lib/efi_loader/e=
fi_signature=2Ec#L809,
>> the db variable is retrieved using efi_get_var() and passed directly to
>> efi_build_signature_store()=2E However, for authenticated variables, th=
e data
>> returned by efi_get_var() includes the authentication header=2E
>> efi_build_signature_store() expects the data pointer to begin at the st=
art
>> of the EFI Signature List, not the authentication header=2E This mismat=
ch leads
>> to a parsing error, as the header is misinterpreted as part of the sign=
ature
>> list, resulting in an invalid signature list format=2E
>>=20
>> How can the error be reproduced?
>> Created the ubootefi=2Evar through tools/efivar=2Epy and enabled EFI_VA=
RIABLES_PRESEED for secure boot,
>> during image authentication, wrong siglist format error was observed=2E
>>=20
>>> leading to parsing failures, the efi_get_variable_mem() is expected
>>> to return esl data alone=2E
>>> Added a check to remove the auth header if the variable has the
>>> EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS attribute=2E Now,
>>> only the ESL data is returned from the function=2E
>>=20
>> Please, have a look at chapter 8=2E2=2E1 GetVariable in the UEFI spec=
=2E
>>=20
>> When the attribute EFI_VARIABLE_ENHANCED_AUTHENTICATED_ACCESS is set, t=
he Data buffer shall be interpreted as follows:
>> // NOTE: =E2=80=9C||=E2=80=9D indicates concatenation=2E
>> // Example: EFI_VARIABLE_AUTHENTICATION_3_TIMESTAMP_TYPE
>> EFI_VARIABLE_AUTHENTICATION_3 || EFI_TIME || EFI_VARIABLE_AUTHENTICATIO=
N_3_CERT_ID || Data
>> // Example: EFI_VARIABLE_AUTHENTICATION_3_NONCE_TYPE
>> EFI_VARIABLE_AUTHENTICATION_3 || EFI_VARIABLE_AUTHENTICATION_3_NONCE ||=
 EFI_VARIABLE_AUTHENTICATION_3_CERT_ID || Data
>>=20
> Isn't removing the authentication header violating the EFI specification=
?
> I belive that stripping the auth header during variable read might not v=
iolate the spec=2E

How could you return a different value from GetVariable() than required by=
 the spec and call it compliant?

Please, adjust the function consuming the value=2E

Best regards

Heinrich

>>=20
>> Is tests/test_efi_secboot/test_authvar=2Epy still passing with your pat=
ch?
>> Yes, it passed
>>>=20
>>> Signed-off-by: Aswin Murugan <aswin=2Emurugan@oss=2Equalcomm=2Ecom>
>>> ---
>>> =C2=A0 lib/efi_loader/efi_var_mem=2Ec | 42 +++++++++++++++++++++++++++=
++-------
>>> =C2=A0 1 file changed, 34 insertions(+), 8 deletions(-)
>>>=20
>>> diff --git a/lib/efi_loader/efi_var_mem=2Ec b/lib/efi_loader/efi_var_m=
em=2Ec
>>> index 31180df9e3a=2E=2Ef73daf8bdc9 100644
>>> --- a/lib/efi_loader/efi_var_mem=2Ec
>>> +++ b/lib/efi_loader/efi_var_mem=2Ec
>>> @@ -309,9 +309,12 @@ efi_get_variable_mem(const u16 *variable_name, co=
nst efi_guid_t *vendor,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 u32 *attributes, efi_uintn_t *data_size, void *data,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 u64 *timep, u32 mask)
>>> =C2=A0 {
>>> -=C2=A0=C2=A0=C2=A0 efi_uintn_t old_size;
>>> +=C2=A0=C2=A0=C2=A0 efi_uintn_t old_size, var_data_size, auth_size;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct efi_var_entry *var;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u16 *pdata;
>>> +=C2=A0=C2=A0=C2=A0 void *var_data;
>>> +=C2=A0=C2=A0=C2=A0 struct efi_time *timestamp;
>>> +=C2=A0=C2=A0=C2=A0 struct win_certificate_uefi_guid *cert;
>>=20
>> Please, move variable definitions to the innermost code block where the=
y are used=2E
>>=20
>> Best regards
>>=20
>> Heinrich
>>=20
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!variable_name || !vendor ||=
 !data_size)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return EFI_INVA=
LID_PARAMETER;
>>> @@ -335,19 +338,42 @@ efi_get_variable_mem(const u16 *variable_name, c=
onst efi_guid_t *vendor,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!u16_strcmp(variable_name, vtf))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return efi_var_=
collect_mem(data, data_size, EFI_VARIABLE_NON_VOLATILE);
>>> =C2=A0 +=C2=A0=C2=A0=C2=A0 for (pdata =3D var->name; *pdata; ++pdata)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;
>>> +=C2=A0=C2=A0=C2=A0 ++pdata;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 var_data =3D (void *)pdata;
>>> +=C2=A0=C2=A0=C2=A0 var_data_size =3D var->length;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* Handle EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WR=
ITE_ACCESS */
>>> +=C2=A0=C2=A0=C2=A0 if (var->attr & EFI_VARIABLE_TIME_BASED_AUTHENTICA=
TED_WRITE_ACCESS) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (var_data_size > sizeof=
(struct efi_time)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ti=
mestamp =3D (struct efi_time *)var_data;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ce=
rt =3D (struct win_certificate_uefi_guid *)(timestamp + 1);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 au=
th_size =3D sizeof(struct efi_time) + cert->hdr=2EdwLength;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (var_data_size > auth_size) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 var_data =3D (u8 *)var_data + auth_size;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 var_data_size -=3D auth_size;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS ty=
pe is old & not
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * expected for auth variables
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 else if (var->attr & EFI_VARIABLE_AUTHENTICATED_WR=
ITE_ACCESS)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return EFI_INVALID_PARAMET=
ER;
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 old_size =3D *data_size;
>>> -=C2=A0=C2=A0=C2=A0 *data_size =3D var->length;
>>> -=C2=A0=C2=A0=C2=A0 if (old_size < var->length)
>>> +=C2=A0=C2=A0=C2=A0 *data_size =3D var_data_size;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (old_size < var_data_size)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return EFI_BUFF=
ER_TOO_SMALL;
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!data)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return EFI_INVA=
LID_PARAMETER;
>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 for (pdata =3D var->name; *pdata; ++pdata)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;
>>> -=C2=A0=C2=A0=C2=A0 ++pdata;
>>> -
>>> -=C2=A0=C2=A0=C2=A0 efi_memcpy_runtime(data, pdata, var->length);
>>> +=C2=A0=C2=A0=C2=A0 efi_memcpy_runtime(data, var_data, var_data_size);
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return EFI_SUCCESS;
>>> =C2=A0 }
>>=20

