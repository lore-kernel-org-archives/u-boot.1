Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E77BC52D6F
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 21:54:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4F3888CDC;
	Tue,  6 Aug 2024 23:52:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Zw2T/pOM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0606988CFE; Tue,  6 Aug 2024 23:52:00 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A875188BCF
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 23:51:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7afd1aeac83so242748a12.0
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 14:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722981116; x=1723585916; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pv6EdGeHMy99xSbzxgOmrgfyOALjqj5riCK1FgzGX4c=;
 b=Zw2T/pOMCOMqistRiMnE5rth6kXGIYC5tymDWPCDA2GhSVseK7f7wo3XQX/PPJVGd6
 OEsr9aCd6o9C1GcKkWeR8XD7/ifAWr1jFo7BS8W5s7sN7B9YKe+FYCeZn0Gtx0iVrufW
 jrDNQS/5cZDLBTmnDbAMIHjHTZxkoPNtoxpDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722981116; x=1723585916;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pv6EdGeHMy99xSbzxgOmrgfyOALjqj5riCK1FgzGX4c=;
 b=V8/54zZBu11nHiMzTlC7UTlLOiHFk7SdTBBXTHmI7pHpMKewpgL8oWjpcjNryqL8qa
 bT+p8bSFOwF3OnknaJN9bn/f80hkmKXm4EmDUOPRAlrIKL7eSU3QpAOwtB+1xdZCKIzG
 sIPY8pFFIdk4Yq1GtNHRS4DKQeAfj5qTIKim79m/E5oenhNVzltXYyigPmyfTYrq1gdC
 S2+/D6/LHnn5KldTLkIilSrnqvsHoE7i21aN7EQq5ULGCY4ychyYfbYNsAOVLFDZ+pQe
 cvYJIvNb2iEE7wqK0mesEYkiq9LWoSQxEqFtFWRQQWImzYfRE4cecSaoCmCsRvhM89tO
 ktzw==
X-Gm-Message-State: AOJu0Yy1VgUlu6aLgpo2pZJsq+ZHaezRFspWBZ9hHVs4wKgcTrDtoDss
 Z1cJfvMIeYWoJdIVP3S0P4J+g0+3I3j4NORMrYbnzdPr1TeUbxaN/qc+XT61MAD3L0x2mbnZNhd
 E2hqgmAiUkxsLn+nXVSXyg6Al2zf9ZxRHkKo/rbMaM0Jm/vQ=
X-Google-Smtp-Source: AGHT+IHGeqTSr7vyG0c936aws3I0XTZo8bsI4KzYiSqvh+EW15pMqus8QT/16OptjM/M3VkrD2ys59EavB57PSJqvEk=
X-Received: by 2002:a17:90a:e2d6:b0:2cb:58e1:abc8 with SMTP id
 98e67ed59e1d1-2d1b2dc628bmr249470a91.21.1722981116092; Tue, 06 Aug 2024
 14:51:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240805133520.1745316-1-paul.henrys_ext@softathome.com>
 <20240805133520.1745316-3-paul.henrys_ext@softathome.com>
In-Reply-To: <20240805133520.1745316-3-paul.henrys_ext@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 6 Aug 2024 15:51:42 -0600
Message-ID: <CAFLszTimv+99guHRofkMH62HjT5-ofA1VmWTZVHM3LaZyNO_qg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] tools: binman: Add tests for FIT with data
 encrypted by mkimage
To: Paul HENRYS <paul.henrys_ext@softathome.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Paul,

On Mon, 5 Aug 2024 at 07:35, Paul HENRYS <paul.henrys_ext@softathome.com> w=
rote:
>
> Test the property 'fit,keys-directory' which, when a cipher node is
> present, encrypts the data stored in the FIT.
>
> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
> ---
>  tools/binman/ftest.py                         |  39 +++++++++++++
>  tools/binman/test/326_fit_encrypt_data.dts    |  53 ++++++++++++++++++
>  .../test/327_fit_encrypt_data_no_key.dts      |  53 ++++++++++++++++++
>  tools/binman/test/aes256.bin                  | Bin 0 -> 32 bytes
>  4 files changed, 145 insertions(+)
>  create mode 100644 tools/binman/test/326_fit_encrypt_data.dts
>  create mode 100644 tools/binman/test/327_fit_encrypt_data_no_key.dts
>  create mode 100644 tools/binman/test/aes256.bin

Looks OK but for nits

>
> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> index 93f3d22cf57..64b7d0231de 100644
> --- a/tools/binman/ftest.py
> +++ b/tools/binman/ftest.py
> @@ -7691,5 +7691,44 @@ fdt         fdtmap                Extract the devi=
cetree blob from the fdtmap
>              self.assertIsNone(dtb.GetNode('/node/other-node'))
>
>
> +    def testSimpleFitEncryptedData(self):
> +        """Test an image with a FIT containing data to be encrypted"""
> +        data =3D self._DoReadFile('326_fit_encrypt_data.dts')
> +
> +        fit =3D fdt.Fdt.FromData(data)
> +        fit.Scan()
> +
> +        # Extract the encrypted data and the IV from the FIT

Please write out IV in full for clarity.

> +        node =3D fit.GetNode('/images/u-boot')
> +        subnode =3D fit.GetNode('/images/u-boot/cipher')
> +        data_size_unciphered =3D int.from_bytes(fit.GetProps(node)['data=
-size-unciphered'].bytes,
> +                                              byteorder=3D'big')
> +        self.assertEqual(data_size_unciphered, len(U_BOOT_NODTB_DATA))
> +
> +        # Retrieve the key name from the FIT removing any null byte
> +        key_name =3D fit.GetProps(subnode)['key-name-hint'].bytes.replac=
e(b'\x00', b'')

Why do you need to replace the nul byte? Could you use this?

fdt_util.GetString(subnode, 'key-name-hint')

> +        with open(self.TestFile(key_name.decode('ascii') + '.bin'), 'rb'=
) as file:
> +            key =3D file.read()

tools.read_file(filename)

below also

> +        iv =3D fit.GetProps(subnode)['iv'].bytes.hex()
> +        enc_data =3D fit.GetProps(node)['data'].bytes
> +        outdir =3D tools.get_output_dir()
> +        enc_data_file =3D os.path.join(outdir, 'encrypted_data.bin')
> +        tools.write_file(enc_data_file, enc_data)
> +        data_file =3D os.path.join(outdir, 'data.bin')
> +
> +        # Decrypt the encrypted data from the FIT and compare the data
> +        tools.run('openssl', 'enc', '-aes-256-cbc', '-nosalt', '-d', '-i=
n',
> +                  enc_data_file, '-out', data_file, '-K', key.hex(), '-i=
v', iv)
> +        with open(data_file, 'r') as file:
> +            dec_data =3D file.read()
> +        self.assertEqual(U_BOOT_NODTB_DATA, dec_data.encode('ascii'))
> +
> +    def testSimpleFitEncryptedDataMissingKey(self):
> +        """Test an image with a FIT containing data to be encrypted but =
with a missing key"""
> +        with self.assertRaises(ValueError) as e:
> +            self._DoReadFile('327_fit_encrypt_data_no_key.dts')
> +
> +        self.assertIn("Can't open file ./aes256.bin (err=3D2 =3D> No suc=
h file or directory)", str(e.exception))
> +
>  if __name__ =3D=3D "__main__":
>      unittest.main()
> diff --git a/tools/binman/test/326_fit_encrypt_data.dts b/tools/binman/te=
st/326_fit_encrypt_data.dts
> new file mode 100644
> index 00000000000..3cd890063cd
> --- /dev/null
> +++ b/tools/binman/test/326_fit_encrypt_data.dts
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/dts-v1/;
> +
> +/ {
> +       #address-cells =3D <1>;
> +       #size-cells =3D <1>;
> +
> +       binman {
> +               fit {
> +                       fit,keys-directory =3D "tools/binman/test";
> +                       description =3D "Test a FIT with encrypted data";
> +                       #address-cells =3D <1>;
> +
> +                       images {
> +                               u-boot {
> +                                       description =3D "U-Boot";
> +                                       type =3D "firmware";
> +                                       arch =3D "arm64";
> +                                       os =3D "U-Boot";
> +                                       compression =3D "none";
> +                                       load =3D <00000000>;
> +                                       entry =3D <00000000>;
> +                                       cipher {
> +                                               algo =3D "aes256";
> +                                               key-name-hint =3D "aes256=
";
> +                                       };
> +                                       u-boot-nodtb {
> +                                       };
> +                               };
> +                               fdt-1 {
> +                                       description =3D "Flattened Device=
 Tree blob";
> +                                       type =3D "flat_dt";
> +                                       arch =3D "arm64";
> +                                       compression =3D "none";
> +                                       cipher {
> +                                               algo =3D "aes256";
> +                                               key-name-hint =3D "aes256=
";
> +                                       };
> +                               };
> +                       };
> +
> +                       configurations {
> +                               default =3D "conf-1";
> +                               conf-1 {
> +                                       description =3D "Boot U-Boot with=
 FDT blob";
> +                                       firmware =3D "u-boot";
> +                                       fdt =3D "fdt-1";
> +                               };
> +                       };
> +               };
> +       };
> +};
> diff --git a/tools/binman/test/327_fit_encrypt_data_no_key.dts b/tools/bi=
nman/test/327_fit_encrypt_data_no_key.dts
> new file mode 100644
> index 00000000000..b92cd2e4bd6
> --- /dev/null
> +++ b/tools/binman/test/327_fit_encrypt_data_no_key.dts
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/dts-v1/;
> +
> +/ {
> +       #address-cells =3D <1>;
> +       #size-cells =3D <1>;
> +
> +       binman {
> +               fit {
> +                       fit,keys-directory =3D ".";
> +                       description =3D "Test a FIT with encrypted data";
> +                       #address-cells =3D <1>;
> +
> +                       images {
> +                               u-boot {
> +                                       description =3D "U-Boot";
> +                                       type =3D "firmware";
> +                                       arch =3D "arm64";
> +                                       os =3D "U-Boot";
> +                                       compression =3D "none";
> +                                       load =3D <00000000>;
> +                                       entry =3D <00000000>;
> +                                       cipher {
> +                                               algo =3D "aes256";
> +                                               key-name-hint =3D "aes256=
";
> +                                       };
> +                                       u-boot-nodtb {
> +                                       };
> +                               };
> +                               fdt-1 {
> +                                       description =3D "Flattened Device=
 Tree blob";
> +                                       type =3D "flat_dt";
> +                                       arch =3D "arm64";
> +                                       compression =3D "none";
> +                                       cipher {
> +                                               algo =3D "aes256";
> +                                               key-name-hint =3D "aes256=
";
> +                                       };
> +                               };
> +                       };
> +
> +                       configurations {
> +                               default =3D "conf-1";
> +                               conf-1 {
> +                                       description =3D "Boot U-Boot with=
 FDT blob";
> +                                       firmware =3D "u-boot";
> +                                       fdt =3D "fdt-1";
> +                               };
> +                       };
> +               };
> +       };
> +};
> diff --git a/tools/binman/test/aes256.bin b/tools/binman/test/aes256.bin
> new file mode 100644
> index 0000000000000000000000000000000000000000..09b8bf6254ada5c084039f329=
16bc7d30233bb2c
> GIT binary patch
> literal 32
> ncmXpsGBz<aGq<obNK8sjNli=3D7$jr*l$<50zC@d;2DJ=3Ds4pC}7U
>
> literal 0
> HcmV?d00001
>
> --
> 2.25.1
>
> -- This message and any attachments herein are confidential, intended sol=
ely for the addressees and are SoftAtHome=E2=80=99s ownership. Any unauthor=
ized use or dissemination is prohibited. If you are not the intended addres=
see of this message, please cancel it immediately and inform the sender.

Regards,
Simon
