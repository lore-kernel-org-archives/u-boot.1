Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB028CD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 15:35:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52929848FC;
	Mon, 25 May 2026 17:35:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l+Do64Ot";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38E9C84910; Mon, 25 May 2026 17:35:42 +0200 (CEST)
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com
 [IPv6:2607:f8b0:4864:20::933])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4382848BD
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 17:35:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-95d0476492bso7118144241.2
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:35:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779723338; cv=none;
 d=google.com; s=arc-20240605;
 b=Lg+POrD8ZHM7DWzvfAMihhMAshBrSr6ogmF03mL9LIPC42CCaiD3LU9KpabN4bC0C8
 w2w9dZKGP8KKlOV2OKGUR27+/PztDEGfbU60021VCq2mNxzqOEQWfINeRZwh6DnLWhpK
 u6okBxx+zw0sBHHFc/VMBvvpYElmnDYz50qaU6V2Kg6GpCjBU2wKjz6CafhdUcNEX3cV
 GXbsMZI3t1XoBNzYp36nZubdxiN+aoNXkXv/v3PbopFDusPyAN3yGvkIwgn4TP0aqDEs
 0+butVIxRlaMehqqyvQZ+fpHizBeJ6ks9xxVsETTuKLOkCQoNjjJVXMEY+HLNUddoQ+4
 6o0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nmxhGvM0TI7Z4OMOWLYa+16FAy2/1jMxy4/MisQyegw=;
 fh=/yITPosEv8dHdmF9q8hbG9QoPQ4wOXg56bku+S3ZPSY=;
 b=lCo9wxsX2NHT8PM6qd0g3EnWdw/rJ6BR7AVzsBpyPQXXrQkVL+5iSzUdNfJx6cOH63
 GtIivFogC/1k5+8EejZIEc34Bzr7mZC3+pzjRECpHopCe8Vn32rhA0BLkULG1EwvkTgJ
 KW03ZDMFr/mLRHFAz+YsrXTr2NrPaEEkzr+vlF382ldTETN0e5+3ticTHRhI/De18tMk
 JgVS+5kUbBqZETDEj4Zbaeq/2NcJ8Wuzu5uTD+Ws7fX+iIpXbMLyYciqEf+tGO0UQ5IH
 9FqRR9yegv+Jp7X4ATh4sy9g7I0hjoSv2qlSQCWRqliXCwfM51SBN2vYktaAewF23oQt
 9l8Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779723338; x=1780328138; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nmxhGvM0TI7Z4OMOWLYa+16FAy2/1jMxy4/MisQyegw=;
 b=l+Do64OtJYCpqMSI7YTxDLtppQQUoxH+w3nQGZaQVCrE+Re0ZnWrqlNtwm4nxjLE5S
 D67eCOw03nQv6hcc7oMKEc3CUF/NmLiN7/59PB3v2ciBefgaL1/IOybRWS+GLHzpwNwT
 mU0Dgwf8WeLhXdvYIPoDtz9zAM1t6IxjgilunJV+s2r5EFnWcaDtjpQiHw9LbbHSwB/B
 iNAV4lv9HexGHNyi4/kw5vtEauUbWhfOPfjeib/nDqQq/6RTMuDmKhCusrvqOpOY0VUL
 oQy1HlnbmhMSmrlEQW/jv2Y5wRXjumRUUfA8f50B/5/36ReOmHLDlME8zuFfCCUmnQVB
 PWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779723338; x=1780328138;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nmxhGvM0TI7Z4OMOWLYa+16FAy2/1jMxy4/MisQyegw=;
 b=YbmySI61XHBmg/1wk6y9yCQkcSwJF+CC75Z/Sn9BHXZ0+XRpnIx6DNeaVe+S66eOb8
 ITyPiRBvkq5IV3mIcLYW2S6Ub9PWpI3STJUQicy+pir3JnthDJo8zWcUwGAm4xX9yXyP
 8DnYg2BVF8H0qrYN3iWcVZhbJHajSJMLGp9xrOFnIqhk7O/SkppIP8+TAYa+EYU+4UsU
 sgh6/Qf7MyvMxysZ1bm6Cu4wZbh7ez3/WzNIbPTE4arXRsg7JVYYrshNoGlpfnGYCqxJ
 AfBjybeoN/A8SEqO1C2uJfATIZ8wcH2RSu/Nz2O+siRi1kaSEc3pO1Up9fmgLxg8+tZS
 paUg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8abdgKKss1hZ6vIHHNxVZflnVkgLyKCWYJWNZh8vhVb7HR5Bamqjpu9QAFmTqFzZGYTaDTSIs=@lists.denx.de
X-Gm-Message-State: AOJu0YyfUnPnlgzc2iMnHBogvyCgzqdlhBnuklpQNgQxrozk2lHFb5mr
 IKn+uxUwjvyDj47/eu8Gt4BqWYxl8t+LGjPtOIPUy+kul0ORQO0BmrbYYVqQW2RhJiQkaVPmZ0l
 /lMHMFWL/WUxlC71KkFP6ABeA6mjk3m9bCPHM5kE=
X-Gm-Gg: Acq92OHEu+Aux83yPtn3hfuZZYeCAzerdgDtlouRApS2HaDDd20p+OjUBGXkqp+IxGA
 QtJh0swRHaAcngz9QZ4MDINBo4OJdADzBDeT9juLmq8v21yPUKr9Lnt2C6mDQyY8NWBG4wFXTfg
 03WwLzxYDhZZlJQhFpovY42JC9WAh6G+lfD8QC1ZkoG3CQt9OCHBGM9IlaKIXbGRVZVyYm8qDah
 Oi2nmUzSgjh0z9j2/pDe4JxcWxK8HiClGTaONqcYfRYQvBNZybUTieC/sNGoupus1xVL1bpulYq
 +5koje6g
X-Received: by 2002:a05:6102:504f:b0:632:d8d5:2908 with SMTP id
 ada2fe7eead31-67c8b3aa864mr6916167137.26.1779723338490; Mon, 25 May 2026
 08:35:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260525135241.88348-1-philippe.reynes@softathome.com>
 <20260525135241.88348-12-philippe.reynes@softathome.com>
In-Reply-To: <20260525135241.88348-12-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Mon, 25 May 2026 11:35:26 -0400
X-Gm-Features: AVHnY4IwdUK5B7tut0tWqGWmW6yIFO1VHGIvyplXsveTJeG3l34J_T6CVvzOqws
Message-ID: <CAMDkj5x54pK+uQ9CYeODUFFzc8yxiS4gqE=upV+28arXGZ4Vfw@mail.gmail.com>
Subject: Re: [PATCH v6 11/15] tools: binman: pre-load: add support of ecdsa
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, trini@konsulko.com, 
 simon.glass@canonical.com, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>
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

Hi Philippe,

On Mon, May 25, 2026 at 9:52=E2=80=AFAM Philippe Reynes
<philippe.reynes@softathome.com> wrote:
>
> Right now, binman can only create pre-load header
> using rsa. We add the support of ecdsa.
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
> v3:
> - initial version
> v4:
> - merge patch 11 that was adding test for ecdsa pre-load
> - add key size check
> - use exc instead of simply e
> - rename dts filaneme
> - add a test to check key size
> v5:
> - compute ecdsa521 sig instead of using hardcoded value 132
> - fix english: don't -> doesn't
> - avoid line too long
> v6:
> - no change
>
>  tools/binman/etype/pre_load.py                | 78 ++++++++++++++++---
>  tools/binman/ftest.py                         | 50 ++++++++++++
>  tools/binman/test/ecdsa521.pem                |  7 ++
>  tools/binman/test/security/pre_load_ecdsa.dts | 22 ++++++
>  .../security/pre_load_ecdsa_invalid_algo.dts  | 22 ++++++
>  .../security/pre_load_ecdsa_invalid_key.dts   | 22 ++++++
>  .../security/pre_load_ecdsa_invalid_sha.dts   | 22 ++++++
>  7 files changed, 214 insertions(+), 9 deletions(-)
>  create mode 100644 tools/binman/test/ecdsa521.pem
>  create mode 100644 tools/binman/test/security/pre_load_ecdsa.dts
>  create mode 100644 tools/binman/test/security/pre_load_ecdsa_invalid_alg=
o.dts
>  create mode 100644 tools/binman/test/security/pre_load_ecdsa_invalid_key=
.dts
>  create mode 100644 tools/binman/test/security/pre_load_ecdsa_invalid_sha=
.dts
>

Looks good to me. Thanks!
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>


> diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load=
.py
> index 0d953cb258e..7890c1c62a8 100644
> --- a/tools/binman/etype/pre_load.py
> +++ b/tools/binman/etype/pre_load.py
> @@ -16,8 +16,10 @@ from binman.entry import EntryArg
>
>  from Cryptodome.Hash import SHA256, SHA384, SHA512
>  from Cryptodome.PublicKey import RSA
> +from Cryptodome.PublicKey import ECC
>  from Cryptodome.Signature import pkcs1_15
>  from Cryptodome.Signature import pss
> +from Cryptodome.Signature import DSS
>
>  PRE_LOAD_MAGIC =3D b'UBSH'
>
> @@ -27,6 +29,12 @@ RSAS =3D {
>      'rsa4096': 4096 / 8
>  }
>
> +ECDSAS =3D {
> +    'ecdsa256': 256 / 8 * 2,
> +    'ecdsa384': 384 / 8 * 2,
> +    'ecdsa521': (521 + 7) / 8 * 2
> +}
> +
>  SHAS =3D {
>      'sha256': SHA256,
>      'sha384': SHA384,
> @@ -86,24 +94,17 @@ class Entry_pre_load(Entry_collection):
>          if self.key_path is None:
>              self.key_path =3D ''
>
> -    def _CreateHeader(self):
> -        """Create a pre load header"""
> -        hash_name, sign_name =3D self.algo_name.split(',')
> -        padding_name =3D self.padding_name
> -        key_name =3D os.path.join(self.key_path, self.key_name)
> -
> +    def _CreateHeaderRsa(self, hash_name, sign_name, padding_name, key_n=
ame):
>          # Check hash and signature name/type
>          if hash_name not in SHAS:
>              self.Raise(hash_name + " is not supported")
> -        if sign_name not in RSAS:
> -            self.Raise(sign_name + " is not supported")
>
>          # Read the key
>          key =3D RSA.import_key(tools.read_file(key_name))
>
>          # Check if the key has the expected size
>          if key.size_in_bytes() !=3D RSAS[sign_name]:
> -            self.Raise("The key " + self.key_name + " don't have the exp=
ected size")
> +            self.Raise("The key " + self.key_name + " doesn't have the e=
xpected size")
>
>          # Compute the hash
>          hash_image =3D SHAS[hash_name].new()
> @@ -151,6 +152,65 @@ class Entry_pre_load(Entry_collection):
>
>          return data + pad
>
> +    def _CreateHeaderEcdsa(self, hash_name, sign_name, key_name):
> +        # Check hash and signature name/type
> +        if hash_name not in SHAS:
> +            self.Raise(hash_name + " is not supported")
> +
> +        # Read the key
> +        key =3D ECC.import_key(tools.read_file(key_name))
> +
> +        # Check if the key has the expected size
> +        if key.pointQ.size_in_bytes() * 2 !=3D ECDSAS[sign_name]:
> +            self.Raise("The key " + self.key_name + " doesn't have the e=
xpected size")
> +
> +        # Compute the hash
> +        hash_image =3D SHAS[hash_name].new()
> +        hash_image.update(self.image)
> +
> +        # Compute the signature
> +        signer =3D DSS.new(key, 'fips-186-3')
> +        sig =3D signer.sign(hash_image)
> +
> +        hash_sig =3D SHA256.new()
> +        hash_sig.update(sig)
> +
> +        version =3D self.version
> +        header_size =3D self.header_size
> +        image_size =3D len(self.image)
> +        ofs_img_sig =3D 64 + len(sig)
> +        flags =3D 0
> +        reserved0 =3D 0
> +        reserved1 =3D 0
> +
> +        first_header =3D struct.pack('>4sIIIIIII32s', PRE_LOAD_MAGIC,
> +                                   version, header_size, image_size,
> +                                   ofs_img_sig, flags, reserved0,
> +                                   reserved1, hash_sig.digest())
> +
> +        hash_first_header =3D SHAS[hash_name].new()
> +        hash_first_header.update(first_header)
> +        sig_first_header =3D signer.sign(hash_first_header)
> +
> +        data =3D first_header + sig_first_header + sig
> +        pad  =3D bytearray(self.header_size - len(data))
> +
> +        return data + pad
> +
> +    def _CreateHeader(self):
> +        """Create a pre load header"""
> +        hash_name, sign_name =3D self.algo_name.split(',')
> +        padding_name =3D self.padding_name
> +        key_name =3D os.path.join(self.key_path, self.key_name)
> +
> +        if sign_name in RSAS:
> +            return self._CreateHeaderRsa(hash_name, sign_name, padding_n=
ame, key_name)
> +
> +        if sign_name in ECDSAS:
> +            return self._CreateHeaderEcdsa(hash_name, sign_name, key_nam=
e)
> +
> +        self.Raise(sign_name + " is not supported")
> +
>      def ObtainContents(self):
>          """Create a placeholder for the header"""
>          self.SetContents(tools.get_bytes(0, self.header_size))
> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> index 9a3811c1732..5c88bec9b46 100644
> --- a/tools/binman/ftest.py
> +++ b/tools/binman/ftest.py
> @@ -5910,12 +5910,62 @@ fdt         fdtmap                Extract the dev=
icetree blob from the fdtmap
>
>          image_fname =3D tools.get_output_filename('image.bin')
>          is_signed =3D self._CheckPreload(image_fname, self.TestFile("dev=
.key"))
> +        self.assertEqual(PRE_LOAD_MAGIC, data[:len(PRE_LOAD_MAGIC)])
> +        self.assertEqual(PRE_LOAD_VERSION, data[4:4 + len(PRE_LOAD_VERSI=
ON)])
> +        self.assertEqual(PRE_LOAD_HDR_SIZE, data[8:8 + len(PRE_LOAD_HDR_=
SIZE)])
> +        self.assertEqual(is_signed, True)
>
> +    def testPreLoadEcdsa(self):
> +        """Test an image with a pre-load header using ecdsa key"""
> +        entry_args =3D {
> +            'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
> +        }
> +        data =3D self._DoReadFileDtb(
> +            'security/pre_load_ecdsa.dts', entry_args=3Dentry_args,
> +            extra_indirs=3D[os.path.join(self._binman_dir, 'test')])[0]
> +
> +        image_fname =3D tools.get_output_filename('image.bin')
> +        is_signed =3D self._CheckPreload(image_fname,
> +                                       self.TestFile('ecdsa521.pem'),
> +                                       'sha256,ecdsa521')
>          self.assertEqual(PRE_LOAD_MAGIC, data[:len(PRE_LOAD_MAGIC)])
>          self.assertEqual(PRE_LOAD_VERSION, data[4:4 + len(PRE_LOAD_VERSI=
ON)])
>          self.assertEqual(PRE_LOAD_HDR_SIZE, data[8:8 + len(PRE_LOAD_HDR_=
SIZE)])
>          self.assertEqual(is_signed, True)
>
> +    def testPreLoadEcdsaInvalidSha(self):
> +        """Test an image with a pre-load ecdsa header with an invalid ha=
sh"""
> +        entry_args =3D {
> +            'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
> +        }
> +        with self.assertRaises(ValueError) as exc:
> +            self._DoReadFileDtb('security/pre_load_ecdsa_invalid_sha.dts=
',
> +                                entry_args=3Dentry_args)
> +        self.assertIn("Node '/binman/pre-load': sha2560 is not supported=
",
> +                      str(exc.exception))
> +
> +    def testPreLoadEcdsaInvalidAlgo(self):
> +        """Test an image with a pre-load header with an invalid algo"""
> +        entry_args =3D {
> +            'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
> +        }
> +        with self.assertRaises(ValueError) as exc:
> +            data =3D self._DoReadFileDtb('security/pre_load_ecdsa_invali=
d_algo.dts',
> +                                       entry_args=3Dentry_args)
> +        self.assertIn("Node '/binman/pre-load': ecdsa5210 is not support=
ed",
> +                      str(exc.exception))
> +
> +    def testPreLoadEcdsaInvalidKey(self):
> +        """Test an image with a pre-load header with an invalid key size=
"""
> +        entry_args =3D {
> +            'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
> +        }
> +        with self.assertRaises(ValueError) as exc:
> +            data =3D self._DoReadFileDtb('security/pre_load_ecdsa_invali=
d_key.dts',
> +                                       entry_args=3Dentry_args)
> +        self.assertIn("Node '/binman/pre-load': The key ecdsa521.pem doe=
sn't have the expected size",
> +                      str(exc.exception))
> +
>      def _CheckSafeUniqueNames(self, *images):
>          """Check all entries of given images for unsafe unique names"""
>          for image in images:
> diff --git a/tools/binman/test/ecdsa521.pem b/tools/binman/test/ecdsa521.=
pem
> new file mode 100644
> index 00000000000..ac1904d3955
> --- /dev/null
> +++ b/tools/binman/test/ecdsa521.pem
> @@ -0,0 +1,7 @@
> +-----BEGIN EC PRIVATE KEY-----
> +MIHcAgEBBEIBM+CNnraGci2/mw1wPq44l2HccHnoBbdP3DiU6zqsBOq8IR8uegz2
> +FLzWsjxcW7hwROCdEm6tW99wqsyPE25RZ3egBwYFK4EEACOhgYkDgYYABABu5bWV
> +aQ4EgnXFjojX9df3gBEBipphEEFAoG87GuoWBdlimFC8UEEXiKNU37w0wlJn4bG0
> +8uOKwDqBk3uF+DrmZwB45lCSKkjdRWsJeDt+iEuFe2O/mbXoL4p5D8MM2OsDV5GT
> +srUbxhXq+T/i5lV7XXm2+tT/7zU8ZQce6WRufbd9KQ=3D=3D
> +-----END EC PRIVATE KEY-----
> diff --git a/tools/binman/test/security/pre_load_ecdsa.dts b/tools/binman=
/test/security/pre_load_ecdsa.dts
> new file mode 100644
> index 00000000000..247b85aad4c
> --- /dev/null
> +++ b/tools/binman/test/security/pre_load_ecdsa.dts
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/dts-v1/;
> +
> +/ {
> +       #address-cells =3D <1>;
> +       #size-cells =3D <1>;
> +
> +       binman {
> +               pre-load {
> +                       content =3D <&image>;
> +                       algo-name =3D "sha256,ecdsa521";
> +                       key-name =3D "ecdsa521.pem";
> +                       header-size =3D <4096>;
> +                       version =3D <0x11223344>;
> +               };
> +
> +               image: blob-ext {
> +                       filename =3D "refcode.bin";
> +               };
> +       };
> +};
> diff --git a/tools/binman/test/security/pre_load_ecdsa_invalid_algo.dts b=
/tools/binman/test/security/pre_load_ecdsa_invalid_algo.dts
> new file mode 100644
> index 00000000000..be71edbbdcd
> --- /dev/null
> +++ b/tools/binman/test/security/pre_load_ecdsa_invalid_algo.dts
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/dts-v1/;
> +
> +/ {
> +       #address-cells =3D <1>;
> +       #size-cells =3D <1>;
> +
> +       binman {
> +               pre-load {
> +                       content =3D <&image>;
> +                       algo-name =3D "sha256,ecdsa5210";
> +                       key-name =3D "ecdsa521.pem";
> +                       header-size =3D <4096>;
> +                       version =3D <0x11223344>;
> +               };
> +
> +               image: blob-ext {
> +                       filename =3D "refcode.bin";
> +               };
> +       };
> +};
> diff --git a/tools/binman/test/security/pre_load_ecdsa_invalid_key.dts b/=
tools/binman/test/security/pre_load_ecdsa_invalid_key.dts
> new file mode 100644
> index 00000000000..15d71cf0324
> --- /dev/null
> +++ b/tools/binman/test/security/pre_load_ecdsa_invalid_key.dts
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/dts-v1/;
> +
> +/ {
> +       #address-cells =3D <1>;
> +       #size-cells =3D <1>;
> +
> +       binman {
> +               pre-load {
> +                       content =3D <&image>;
> +                       algo-name =3D "sha256,ecdsa384";
> +                       key-name =3D "ecdsa521.pem";
> +                       header-size =3D <4096>;
> +                       version =3D <0x11223344>;
> +               };
> +
> +               image: blob-ext {
> +                       filename =3D "refcode.bin";
> +               };
> +       };
> +};
> diff --git a/tools/binman/test/security/pre_load_ecdsa_invalid_sha.dts b/=
tools/binman/test/security/pre_load_ecdsa_invalid_sha.dts
> new file mode 100644
> index 00000000000..1017707375e
> --- /dev/null
> +++ b/tools/binman/test/security/pre_load_ecdsa_invalid_sha.dts
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/dts-v1/;
> +
> +/ {
> +       #address-cells =3D <1>;
> +       #size-cells =3D <1>;
> +
> +       binman {
> +               pre-load {
> +                       content =3D <&image>;
> +                       algo-name =3D "sha2560,ecdsa521";
> +                       key-name =3D "ecdsa521.pem";
> +                       header-size =3D <4096>;
> +                       version =3D <0x11223344>;
> +               };
> +
> +               image: blob-ext {
> +                       filename =3D "refcode.bin";
> +               };
> +       };
> +};
> --
> 2.43.0
>
