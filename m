Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCE1D63936
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 13:36:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDDF5892B8;
	Wed, 20 Nov 2024 14:36:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EoudsiAR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96F8789270; Wed, 20 Nov 2024 14:36:52 +0100 (CET)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35410892DE
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 14:36:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7fb632bfc0eso2996946a12.0
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 05:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732109809; x=1732714609; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BcRkBM+ZAVTWJdMGAvTEutkeUPAHMXNogZHiWnsh+3Q=;
 b=EoudsiARZfwNaxO93UD4UMaE+8+9wJZtV29lGlrK2GifQ8IWUTkUdqbpFcnZoLskXz
 2WvYIJBp28gvw6bM2sOohx2v3FeUFDqscMfd7fNyw3ukJx6RZll5fj/9oEzzjmV/6bsT
 kDX3B7Zxo4Ha637/TfaaZOtS6ThB9aq6n+vww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732109809; x=1732714609;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BcRkBM+ZAVTWJdMGAvTEutkeUPAHMXNogZHiWnsh+3Q=;
 b=ZyqAjRWu18JdkzwUCEjJldMKrVQte95tDnuIc4TVuZNbojffXsRuAPfZa8JANRuTR5
 3lmpRIM3Bna7Ou6rcYNcPJWcCQ+47YP3fQ5b26L+XFhEdT4Bx9aBMc2Ub/44EWDvoAmM
 Q3OxNC6gduerAuwjtUV635KmFQH7zqQ2OFQy8aRllXVPpZWk1D/UZoiUFODlwXuVwzbw
 BFIr2oKwiUiSLa0q7NCVtZVdwv4mdbdXjrenn1voFfDCuOklBzddeE6jXTXlRX1YvAGr
 H7iaSaoVDvp9oou0oMrdkVam1DGuS2/FwxrIv22iTwXKH+4rEUr/x9/bE+Tnq8TTkh78
 /ghQ==
X-Gm-Message-State: AOJu0YyErUnuWbr35LdgpXhpU18qBW7DA3uBcRr/nhIubf4SReVTVMVE
 Afc6OQ1kB1gcpXIGuTl/pBqwrEEYcvvNRrvflL8Qkbcuzh+99jToFdgIcbVBR3c+NtqG/Iopea+
 +Wk726+60H4zLmXlA7SxznzkTim4V5SZ/ZPtT
X-Google-Smtp-Source: AGHT+IEof3jFPnT+FgXFwt+qWbPU/YxvZGvT4jdyJPD2qF8kMSoOmhvR6WPyqVSyQriTuCC3EAOxJs2+tnboDVv3c1M=
X-Received: by 2002:a05:6a20:12c2:b0:1dc:c1c9:fc0a with SMTP id
 adf61e73a8af0-1ddaefbfcecmr3687523637.27.1732109808740; Wed, 20 Nov 2024
 05:36:48 -0800 (PST)
MIME-Version: 1.0
References: <20241120100911.885418-1-paul.henrys_ext@softathome.com>
 <20241120100911.885418-3-paul.henrys_ext@softathome.com>
In-Reply-To: <20241120100911.885418-3-paul.henrys_ext@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Nov 2024 06:35:49 -0700
Message-ID: <CAFLszTj4a-e9y31nSXxMEEm2tdh+sccpqZiEHVNT159U0AQyww@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] tools: binman: Add tests for FIT with data
 encrypted by mkimage
To: Paul HENRYS <paul.henrys_ext@softathome.com>
Cc: u-boot@lists.denx.de, al.kochet@gmail.com, paul.henrysd@gmail.com
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 20 Nov 2024 at 03:09, Paul HENRYS
<paul.henrys_ext@softathome.com> wrote:
>
> Test the property 'fit,keys-directory' which, when a cipher node is
> present, encrypts the data stored in the FIT.
>
> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
> ---
> Changes for v3:
>  - Write out IV in full for clarity as requested
>  - Do not replace the null byte but use fdt_util.GetString() instead
>  - Adapt the tests for the FIT data encryption to create a file with the content
>    of the AES key in the working directory and pass the path to binman
>
>  tools/binman/ftest.py                         |  45 +++++++++++++++
>  tools/binman/test/343_fit_encrypt_data.dts    |  53 ++++++++++++++++++
>  .../test/344_fit_encrypt_data_no_key.dts      |  53 ++++++++++++++++++
>  tools/binman/test/aes256.bin                  | Bin 0 -> 32 bytes
>  4 files changed, 151 insertions(+)
>  create mode 100644 tools/binman/test/343_fit_encrypt_data.dts
>  create mode 100644 tools/binman/test/344_fit_encrypt_data_no_key.dts
>  create mode 100644 tools/binman/test/aes256.bin

Reviewed-by: Simon Glass <sjg@chromium.org>

>
> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> index adab65e579..b19b0cc5b3 100644
> --- a/tools/binman/ftest.py
> +++ b/tools/binman/ftest.py
> @@ -7900,5 +7900,50 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
>              extra_indirs=[test_subdir])[0]
>
>
> +    def testSimpleFitEncryptedData(self):
> +        """Test an image with a FIT containing data to be encrypted"""
> +        data = tools.read_file(self.TestFile("aes256.bin"))
> +        self._MakeInputFile("keys/aes256.bin", data)
> +
> +        keys_subdir = os.path.join(self._indir, "keys")
> +        data = self._DoReadFileDtb(
> +            '343_fit_encrypt_data.dts',
> +            extra_indirs=[keys_subdir])[0]
> +
> +        fit = fdt.Fdt.FromData(data)
> +        fit.Scan()
> +
> +        # Extract the encrypted data and the Initialization Vector from the FIT
> +        node = fit.GetNode('/images/u-boot')
> +        subnode = fit.GetNode('/images/u-boot/cipher')
> +        data_size_unciphered = int.from_bytes(fit.GetProps(node)['data-size-unciphered'].bytes,
> +                                              byteorder='big')
> +        self.assertEqual(data_size_unciphered, len(U_BOOT_NODTB_DATA))
> +
> +        # Retrieve the key name from the FIT removing any null byte
> +        key_name = fit.GetProps(subnode)['key-name-hint'].bytes.replace(b'\x00', b'')
> +        with open(self.TestFile(key_name.decode('ascii') + '.bin'), 'rb') as file:
> +            key = file.read()
> +        iv = fit.GetProps(subnode)['iv'].bytes.hex()
> +        enc_data = fit.GetProps(node)['data'].bytes
> +        outdir = tools.get_output_dir()
> +        enc_data_file = os.path.join(outdir, 'encrypted_data.bin')
> +        tools.write_file(enc_data_file, enc_data)
> +        data_file = os.path.join(outdir, 'data.bin')
> +
> +        # Decrypt the encrypted data from the FIT and compare the data
> +        tools.run('openssl', 'enc', '-aes-256-cbc', '-nosalt', '-d', '-in',
> +                  enc_data_file, '-out', data_file, '-K', key.hex(), '-iv', iv)
> +        with open(data_file, 'r') as file:
> +            dec_data = file.read()
> +        self.assertEqual(U_BOOT_NODTB_DATA, dec_data.encode('ascii'))
> +
> +    def testSimpleFitEncryptedDataMissingKey(self):
> +        """Test an image with a FIT containing data to be encrypted but with a missing key"""
> +        with self.assertRaises(ValueError) as e:
> +            self._DoReadFile('344_fit_encrypt_data_no_key.dts')
> +
> +        self.assertIn("Filename 'aes256.bin' not found in input path", str(e.exception))
> +
>  if __name__ == "__main__":
>      unittest.main()
> diff --git a/tools/binman/test/343_fit_encrypt_data.dts b/tools/binman/test/343_fit_encrypt_data.dts
> new file mode 100644
> index 0000000000..90e504979b
> --- /dev/null
> +++ b/tools/binman/test/343_fit_encrypt_data.dts
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/dts-v1/;
> +
> +/ {
> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +
> +       binman {
> +               fit {
> +                       fit,keys-directory;
> +                       description = "Test a FIT with encrypted data";
> +                       #address-cells = <1>;
> +
> +                       images {
> +                               u-boot {
> +                                       description = "U-Boot";
> +                                       type = "firmware";
> +                                       arch = "arm64";
> +                                       os = "U-Boot";
> +                                       compression = "none";
> +                                       load = <00000000>;
> +                                       entry = <00000000>;
> +                                       cipher {
> +                                               algo = "aes256";
> +                                               key-name-hint = "aes256";
> +                                       };
> +                                       u-boot-nodtb {
> +                                       };
> +                               };
> +                               fdt-1 {
> +                                       description = "Flattened Device Tree blob";
> +                                       type = "flat_dt";
> +                                       arch = "arm64";
> +                                       compression = "none";
> +                                       cipher {
> +                                               algo = "aes256";
> +                                               key-name-hint = "aes256";
> +                                       };
> +                               };
> +                       };
> +
> +                       configurations {
> +                               default = "conf-1";
> +                               conf-1 {
> +                                       description = "Boot U-Boot with FDT blob";
> +                                       firmware = "u-boot";
> +                                       fdt = "fdt-1";
> +                               };
> +                       };
> +               };
> +       };
> +};
> diff --git a/tools/binman/test/344_fit_encrypt_data_no_key.dts b/tools/binman/test/344_fit_encrypt_data_no_key.dts
> new file mode 100644
> index 0000000000..90e504979b
> --- /dev/null
> +++ b/tools/binman/test/344_fit_encrypt_data_no_key.dts
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/dts-v1/;
> +
> +/ {
> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +
> +       binman {
> +               fit {
> +                       fit,keys-directory;
> +                       description = "Test a FIT with encrypted data";
> +                       #address-cells = <1>;
> +
> +                       images {
> +                               u-boot {
> +                                       description = "U-Boot";
> +                                       type = "firmware";
> +                                       arch = "arm64";
> +                                       os = "U-Boot";
> +                                       compression = "none";
> +                                       load = <00000000>;
> +                                       entry = <00000000>;
> +                                       cipher {
> +                                               algo = "aes256";
> +                                               key-name-hint = "aes256";
> +                                       };
> +                                       u-boot-nodtb {
> +                                       };
> +                               };
> +                               fdt-1 {
> +                                       description = "Flattened Device Tree blob";
> +                                       type = "flat_dt";
> +                                       arch = "arm64";
> +                                       compression = "none";
> +                                       cipher {
> +                                               algo = "aes256";
> +                                               key-name-hint = "aes256";
> +                                       };
> +                               };
> +                       };
> +
> +                       configurations {
> +                               default = "conf-1";
> +                               conf-1 {
> +                                       description = "Boot U-Boot with FDT blob";
> +                                       firmware = "u-boot";
> +                                       fdt = "fdt-1";
> +                               };
> +                       };
> +               };
> +       };
> +};
> diff --git a/tools/binman/test/aes256.bin b/tools/binman/test/aes256.bin
> new file mode 100644
> index 0000000000000000000000000000000000000000..09b8bf6254ada5c084039f32916bc7d30233bb2c
> GIT binary patch
> literal 32
> ncmXpsGBz<aGq<obNK8sjNli=7$jr*l$<50zC@d;2DJ=s4pC}7U
>
> literal 0
> HcmV?d00001
>
> --
> 2.43.0

[..]
