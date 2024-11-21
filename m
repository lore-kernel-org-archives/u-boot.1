Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E254ED6ED21
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 12:48:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 371B689735;
	Thu, 21 Nov 2024 13:48:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cbTa1SMX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 831A389733; Thu, 21 Nov 2024 13:48:08 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EEA189733
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 13:48:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=al.kochet@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-53d9ff92ee9so858628e87.1
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 04:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732193285; x=1732798085; darn=lists.denx.de;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=zmFR/dqeljPpOzu9osVcjbrOUOIeYanWpMjjgkolKzc=;
 b=cbTa1SMX+RXxzvh9HRcbRG8FJn1esKCE9hV9O11DZZ22j+t5pR2mpdoFXZpkYqaa2H
 I/1RT8G/+lqLX1nMA1lUAgqvfZPSy1UNm4M1+NWU7wGz4Cdar1YfbaeXhL2RAlYi7AlA
 W6Nk3faoMZ8o245sH6TbWRlwIr690Phqi7hqVKNypO4YVRN6YcHFFGeFSk6rU6IxsNJl
 BgYvDv24n8ZuvvhGSx5GNj5cHCVC88p765MJCOt+dVTq6XtWw1Fn84Q9GdFuCbit1y4T
 oxo1sIcXwP3pIdKCU8JD/Z+FY3pbegiOKWWms1vgGtEl5pQ51kOaHZ7qyF5zBkfS0jma
 vSlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732193285; x=1732798085;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zmFR/dqeljPpOzu9osVcjbrOUOIeYanWpMjjgkolKzc=;
 b=nvF81joa73BXGLvHs3gIfsCi5B1VtyoErBPXPFKWSBUl0pTfMchj/72Z0+eKrrrza5
 R7KUq1iVxZXeTGbnY3zN/8DPYma82AXdwGjPvv+rAvs7SQRyChFJLTSkRdHCfGIPIv5Q
 4dXWfjiTz+KRdRCkZb7UFlw5URmjzJI6eDmYah5IJXximQ7Dojq28DRvrH/qOEoYC4dE
 zWQvT6vK8B3rWJ/HPb+wMAz4nPVqxaw5TKtxpoSnAdK2eBlsEAyBZDmt0p4cT1tldrzy
 5H8uOP9Ye8JoHmOeBS5bDqYHl4xMw6D0aZjeQF1znbkghdHDTtQ6rJupMKm40vFJCpuP
 aN4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhjTnwA00kmhqY8gmRxePHV33lVik2tC439WALHbThKu5UlXk/+qAIiugWcKxE7QUrkfqMoyc=@lists.denx.de
X-Gm-Message-State: AOJu0Yx7yCQD9LxOHeWW1HPtMFLDjaLQgTtXuO2k1huzDGHymPXCoqRR
 SBUii6E5//ciA3SFQRyA4hX4o/URF3NpgXzascDL19xq36kxRG31dm36kQ==
X-Gm-Gg: ASbGnct2M8VSJj4eDicLNzWaxcHiHqUuqAmSJP7XI14UYlsNzh/gz+fdeDPs85V9a8b
 ASj4p4Xy1ZAANIaSJ17G3CD4vP+x7L2amQbcNbFNg0BFeRGpZi2clf1TxOH8M7/h7ok+BL/9S83
 lCZPgrMTGWjBbc54RXeF/U8WaEB7DsZ+ZMvO6K1MnnsAjd+/ntlJmix74U0T9U1xjay/Sal8bkL
 YikY1uD541/NN+O8zLyUmsPCVF6g/7GicuuGjrDnsPllFgfEasGG7XB77mBFQERHzQY5uI=
X-Google-Smtp-Source: AGHT+IG8ut9V8FJvNGmB1ipXWx+gAtUl+7LII17c7whpJm64+Z5f/j9+cpMHS984q0+8quTVLGZ4PQ==
X-Received: by 2002:a05:6512:3b97:b0:52c:dc97:45d1 with SMTP id
 2adb3069b0e04-53dc1328833mr3042637e87.10.1732193284255; 
 Thu, 21 Nov 2024 04:48:04 -0800 (PST)
Received: from smtpclient.apple ([80.87.144.137])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53dbd47bba6sm968058e87.269.2024.11.21.04.48.02
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 Nov 2024 04:48:03 -0800 (PST)
From: Alexander Kochetkov <al.kochet@gmail.com>
Message-Id: <9A86BA01-8A62-4985-A706-A8E37487A40F@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH v3 2/3] tools: binman: Replace 'fit,sign' by
 'fit,keys-directory'
Date: Thu, 21 Nov 2024 15:47:52 +0300
In-Reply-To: <d067cee3-88af-4a6d-bef3-726540cb4afa@softathome.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 paul.henrysd+nodisclaimer@gmail.com
To: Paul HENRYS <paul.henrys_ext@softathome.com>
References: <20241120100911.885418-1-paul.henrys_ext@softathome.com>
 <20241120100911.885418-2-paul.henrys_ext@softathome.com>
 <CAFLszThV+sQ6Hj5TW=8JyLz-Ta_GTJhkXxfNHY-caeN0dpaZtg@mail.gmail.com>
 <d067cee3-88af-4a6d-bef3-726540cb4afa@softathome.com>
X-Mailer: Apple Mail (2.3826.200.121)
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Here how I understand Simon=E2=80=99s answer.
He suggested to introduce new property like =E2=80=98fit,encrypt=E2=80=99.=
 And if you see that property, then you enable keys detection (and so =
you enable encryption).

Regarding you current (v3) implementation. I would call the new property =
as =E2=80=98fit,detect-keys-directory=E2=80=99 as it makes more clear =
that binman have to do during
fit processing.

For me, then I see  =E2=80=98fit,keys-directory=E2=80=99 I expect, that =
directory path must be provided with the property. You did that in v2.
But Simon told, that its better to implement that behavior using entyarg =
(https://lists.denx.de/pipermail/u-boot/2024-August/561346.html).
I have no idea how to do that. May be any usage example could clarify.

Regarding implementation of signing in the binman. First, I thought to =
implement singing in the binman. There are another entryargs that =
implements
signing e.g. preload_enty.py. I could extract signing code into separate =
file and implement signing in the fit entry arg: I see fit,sign, I see =
fit entries
related to the signature (key-name-hint, algo=E2=80=A6) and do signing. =
Later I found that mkimage get called during FIT creation and decided =
not
to duplicate functionality.

Alexander.


> 21 =D0=BD=D0=BE=D1=8F=D0=B1. 2024=E2=80=AF=D0=B3., =D0=B2 13:17, Paul =
HENRYS <paul.henrys_ext@softathome.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=
=D0=BB(=D0=B0):
>=20
> Hi Simon,
>=20
> On 20/11/2024 14:35, Simon Glass wrote:
>> This Mail comes from Outside of SoftAtHome: Do not answer, click =
links or open attachments unless you recognize the sender and know the =
content is safe.
>>=20
>> Hi Paul,
>>=20
>> On Wed, 20 Nov 2024 at 03:09, Paul HENRYS
>> <paul.henrys_ext@softathome.com> wrote:
>>> mkimage can be used for both signing the FIT or encrypt its content =
and the
>>> option '-k' can be used to pass a directory where both signing and =
encryption
>>> keys can be retrieved.
>>> _get_priv_keys_dir() is also renamed as _get_keys_dir() and adapted =
to support
>>> both signing and encryption nodes in the FIT.
>>>=20
>>> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
>>> ---
>>> Changes for v3:
>>>  - Adapt the code after changes made in commit 133c000ca334
>>>  - Rename property 'fit,sign' as 'fit,keys-directory' since this is =
not only
>>>    about signing but passing a key directory to mkimage for both =
signing and
>>>    encrypting
>>>  - Update the tests and documentation accordingly
>>>=20
>>> My initial changes proposed in v1 and v2 has been outdated by the =
changes
>>> proposed in commit 133c000ca334.
>>>=20
>>>  tools/binman/btool/mkimage.py           |  8 +++----
>>>  tools/binman/entries.rst                | 13 ++++++-----
>>>  tools/binman/etype/fit.py               | 31 =
++++++++++++++-----------
>>>  tools/binman/ftest.py                   |  2 +-
>>>  tools/binman/test/340_fit_signature.dts |  2 +-
>>>  tools/binman/test/341_fit_signature.dts |  2 +-
>>>  tools/binman/test/342_fit_signature.dts |  2 +-
>>>  7 files changed, 32 insertions(+), 28 deletions(-)
>> I think it is good to be able to specify the keys directory and not
>> just rely on Binman's input path. But do we need to remove the
>> fit,sign property? It is the signal that signing should be done.,
>> although I understand that there is a key directory too.
>>=20
>> If we need to remove it, please do that in a separate patch.
>>=20
>> Perhaps we also need a signal that encryption should be done?
> Based on my understanding, we don't enable the signing by adding =
'fit,sign' property but by having a signature node in the DTS passed to =
binman and thus also in the ITS passed to mkimage by binman (at least =
with the current implementation). In the current implementation, adding =
'fit,sign property' in the DTS passed to binman only leads to add the =
argument '-k' with a directory where the private keys are stored and =
nothing more. The '-k' argument of mkimage is used to specify the keys =
directory for both signing and ciphering FIT data. That is why I thought =
the property could be shared for providing the keys directory for both =
signing and ciphering when generating the FIT.
> Then maybe your idea would be to use such a property, i.e. 'fit,sign' =
property, to be able to add more options related to the signature =
(key-name-hint, algo...) instead of having those information in the ITS =
in a signature node. In this case, I guess it would indeed make sense to =
have separate properties that could both set the '-k' argument passed to =
mkimage.
> The current signal for the encryption is to have a 'cipher' node in =
the ITS provided to mkimage.
>>=20
>>> diff --git a/tools/binman/btool/mkimage.py =
b/tools/binman/btool/mkimage.py
>>> index 78d3301bc1..3f84220fb1 100644
>>> --- a/tools/binman/btool/mkimage.py
>>> +++ b/tools/binman/btool/mkimage.py
>>> @@ -22,7 +22,7 @@ class Bintoolmkimage(bintool.Bintool):
>>>=20
>>>      # pylint: disable=3DR0913
>>>      def run(self, reset_timestamp=3DFalse, output_fname=3DNone, =
external=3DFalse,
>>> -            pad=3DNone, align=3DNone, priv_keys_dir=3DNone):
>>> +            pad=3DNone, align=3DNone, keys_dir=3DNone):
>>>          """Run mkimage
>>>=20
>>>          Args:
>>> @@ -34,7 +34,7 @@ class Bintoolmkimage(bintool.Bintool):
>>>                  other things to be easily added later, if required, =
such as
>>>                  signatures
>>>              align: Bytes to use for alignment of the FIT and its =
external data
>>> -            priv_keys_dir: Path to directory containing private =
keys
>>> +            keys_dir: Path to directory containing private and =
encryption keys
>>>              version: True to get the mkimage version
>>>          """
>>>          args =3D []
>>> @@ -46,8 +46,8 @@ class Bintoolmkimage(bintool.Bintool):
>>>              args +=3D ['-B', f'{align:x}']
>>>          if reset_timestamp:
>>>              args.append('-t')
>>> -        if priv_keys_dir:
>>> -            args +=3D ['-k', f'{priv_keys_dir}']
>>> +        if keys_dir:
>>> +            args +=3D ['-k', f'{keys_dir}']
>>>          if output_fname:
>>>              args +=3D ['-F', output_fname]
>>>          return self.run_cmd(*args)
>>> diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
>>> index e918162fb4..1b1d73ef17 100644
>>> --- a/tools/binman/entries.rst
>>> +++ b/tools/binman/entries.rst
>>> @@ -864,12 +864,13 @@ The top-level 'fit' node supports the =
following special properties:
>>>=20
>>>              fit,fdt-list-dir =3D "arch/arm/dts
>>>=20
>>> -    fit,sign
>>> -        Enable signing FIT images via mkimage as described in
>>> -        verified-boot.rst. If the property is found, the private =
keys path is
>>> -        detected among binman include directories and passed to =
mkimage via
>>> -        -k flag. All the keys required for signing FIT must be =
available at
>>> -        time of signing and must be located in single include =
directory.
>>> +    fit,keys-directory
>>> +        Look for a directory where signing and encryption keys are =
stored.
>>> +        If the property is found, the keys path is detected among =
binman
>>> +        include directories and passed to mkimage via  -k flag. All =
the keys
>>> +        required for signing and encrypting the FIT must be =
available at the
>>> +        time of signing and encrypting and must be located in a =
single
>>> +        include directory.
>>>=20
>>>  Substitutions
>>>  ~~~~~~~~~~~~~
>>> diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
>>> index b5afbda41b..e0c1ac08d8 100644
>>> --- a/tools/binman/etype/fit.py
>>> +++ b/tools/binman/etype/fit.py
>>> @@ -102,13 +102,13 @@ class Entry_fit(Entry_section):
>>>              In this case the input directories are ignored and all =
devicetree
>>>              files must be in that directory.
>>>=20
>>> -        fit,sign
>>> -            Enable signing FIT images via mkimage as described in
>>> -            verified-boot.rst. If the property is found, the =
private keys path
>>> -            is detected among binman include directories and passed =
to mkimage
>>> -            via  -k flag. All the keys required for signing FIT =
must be
>>> -            available at time of signing and must be located in =
single include
>>> -            directory.
>>> +        fit,keys-directory
>>> +            Look for a directory where signing and encryption keys =
are stored.
>>> +            If the property is found, the keys path is detected =
among binman
>>> +            include directories and passed to mkimage via  -k flag. =
All the keys
>>> +            required for signing and encrypting the FIT must be =
available at the
>>> +            time of signing and encrypting and must be located in a =
single
>>> +            include directory.
>>>=20
>>>      Substitutions
>>>      ~~~~~~~~~~~~~
>>> @@ -518,14 +518,14 @@ class Entry_fit(Entry_section):
>>>          # are removed from self._entries later.
>>>          self._priv_entries =3D dict(self._entries)
>>>=20
>>> -    def _get_priv_keys_dir(self, data):
>>> -        """Detect private keys path among binman include =
directories
>>> +    def _get_keys_dir(self, data):
>>> +        """Detect private and encryption keys path among binman =
include directories
>>>=20
>>>          Args:
>>>              data: FIT image in binary format
>>>=20
>>>          Returns:
>>> -            str: Single path containing all private keys found or =
None
>>> +            str: Single path containing all keys found or None
>>>=20
>>>          Raises:
>>>              ValueError: Filename 'rsa2048.key' not found in input =
path
>>> @@ -533,11 +533,14 @@ class Entry_fit(Entry_section):
>>>          """
>>>          def _find_keys_dir(node):
>>>              for subnode in node.subnodes:
>>> -                if subnode.name.startswith('signature'):
>>> +                if (subnode.name.startswith('signature') or
>>> +                    subnode.name.startswith('cipher')):
>>>                      if subnode.props.get('key-name-hint') is None:
>>>                          continue
>>>                      hint =3D subnode.props['key-name-hint'].value
>>> -                    name =3D =
tools.get_input_filename(f"{hint}.key")
>>> +                    name =3D tools.get_input_filename(
>>> +                        f"{hint}.key" if =
subnode.name.startswith('signature')
>>> +                        else f"{hint}.bin")
>>>                      path =3D os.path.dirname(name)
>>>                      if path not in paths:
>>>                          paths.append(path)
>>> @@ -587,8 +590,8 @@ class Entry_fit(Entry_section):
>>>          align =3D self._fit_props.get('fit,align')
>>>          if align is not None:
>>>              args.update({'align': =
fdt_util.fdt32_to_cpu(align.value)})
>>> -        if self._fit_props.get('fit,sign') is not None:
>>> -            args.update({'priv_keys_dir': =
self._get_priv_keys_dir(data)})
>>> +        if self._fit_props.get('fit,keys-directory') is not None:
>>> +            args.update({'keys_dir': self._get_keys_dir(data)})
>>>          if self.mkimage.run(reset_timestamp=3DTrue, =
output_fname=3Doutput_fname,
>>>                              **args) is None:
>>>              if not self.GetAllowMissing():
>>> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
>>> index 156567ace7..adab65e579 100644
>>> --- a/tools/binman/ftest.py
>>> +++ b/tools/binman/ftest.py
>>> @@ -7885,7 +7885,7 @@ fdt         fdtmap                Extract the =
devicetree blob from the fdtmap
>>>              str(e.exception))
>>>=20
>>>      def testFitSignNoSingatureNodes(self):
>>> -        """Test that fit,sign doens't raise error if no signature =
nodes found"""
>>> +        """Test that fit,keys-directory doesn't raise error if no =
signature nodes found"""
>>>          if not elf.ELF_TOOLS:
>>>              self.skipTest('Python elftools not available')
>>>          entry_args =3D {
>>> diff --git a/tools/binman/test/340_fit_signature.dts =
b/tools/binman/test/340_fit_signature.dts
>>> index 9dce62e52d..97c0cbd05e 100644
>>> --- a/tools/binman/test/340_fit_signature.dts
>>> +++ b/tools/binman/test/340_fit_signature.dts
>>> @@ -11,7 +11,7 @@
>>>                         description =3D "test desc";
>>>                         #address-cells =3D <1>;
>>>                         fit,fdt-list =3D "of-list";
>>> -                       fit,sign;
>>> +                       fit,keys-directory;
>>>=20
>>>                         images {
>>>                                 u-boot {
>>> diff --git a/tools/binman/test/341_fit_signature.dts =
b/tools/binman/test/341_fit_signature.dts
>>> index 77bec8df1e..4a4da7e589 100644
>>> --- a/tools/binman/test/341_fit_signature.dts
>>> +++ b/tools/binman/test/341_fit_signature.dts
>>> @@ -11,7 +11,7 @@
>>>                         description =3D "test desc";
>>>                         #address-cells =3D <1>;
>>>                         fit,fdt-list =3D "of-list";
>>> -                       fit,sign;
>>> +                       fit,keys-directory;
>>>=20
>>>                         images {
>>>                                 u-boot {
>>> diff --git a/tools/binman/test/342_fit_signature.dts =
b/tools/binman/test/342_fit_signature.dts
>>> index 267105d0f6..9c61aea044 100644
>>> --- a/tools/binman/test/342_fit_signature.dts
>>> +++ b/tools/binman/test/342_fit_signature.dts
>>> @@ -11,7 +11,7 @@
>>>                         description =3D "test desc";
>>>                         #address-cells =3D <1>;
>>>                         fit,fdt-list =3D "of-list";
>>> -                       fit,sign;
>>> +                       fit,keys-directory;
>>>=20
>>>                         images {
>>>                                 u-boot {
>>> --
>>> 2.43.0
>> [..]
>>=20
>> Regards,
>> Simon

