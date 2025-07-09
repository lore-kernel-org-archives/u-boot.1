Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43602C83F03
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 17:50:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61A1883564;
	Wed,  9 Jul 2025 19:50:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="lDzk5Zt6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B78AE8354B; Wed,  9 Jul 2025 19:50:50 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE3C283535
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 19:50:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2efdd5c22dfso81244fac.3
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 10:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1752083446; x=1752688246; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=25oE+REDTl4thU7A3rjo8k/dFtwcqWj6MY0A78JL5SA=;
 b=lDzk5Zt6PFt9d8VgcYAZhibBJlQrUl+c2fmxso16CAz9mKnPEb8EoN8bIshhQll/wQ
 dgciScq2r9R10IuPiYvcUpFn5zKC+RojAGcqjoP82pn99Q/zQ0Mi9rVcolVxgPZ0/DrA
 LNQi72jaC4MacucSdDIPIBpPsOqtATTcEhVk+Zw6beb6Qn/gQ4IHYknlWWhGCQJoU1al
 +lxeVaIxJryuQg5uNAVIdRGlysx7GX2jcWfSxOznoqiPzbh18Zse5SSwhcZrG/v9zqtS
 siAXzWE/uTKbeGxHy0lFzlBGIHjAyngnGTVVfU6xGBBh8g+L3LFgW+jpkBPtYtnBjvES
 KtJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752083446; x=1752688246;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=25oE+REDTl4thU7A3rjo8k/dFtwcqWj6MY0A78JL5SA=;
 b=K5YQGVTknTUu6iCfKmfgXPol/DtLsHjT3FGMQ5FhAHNqJ1zB29HmM9iLX8XiNYx19y
 qX3LEwkj+xCXtnjuZH0Odbl0E4CFvsgpQsmBm8FUkTP3v6K33DWi1IBMRoS2+xlkxETI
 HWU92btk7O88QP+Y0lh+eFJWZmKNyO6p1469KXwrMuhxzVTCaJQI/yBdL9J4pZ7CqWbY
 DIfEJyvTk2GtDmvxKolUGCpk1sCjeVLximHgqZ9znq7N3Lic3SgYiMG8og7QPCnM+rIC
 0fZvMUagTu21iXI9fj8E9P7fuPdNIN7+/G8VQ4Hi22OjGPdlCfS4zRAlYuldRfBWfqmS
 R/qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWp4zP9/ujHldUla0MWuGhkBy2/nG+QKsHfPbyZFf3vzLYrhoAkpAergWGW3JyXkEbA4rIbalo=@lists.denx.de
X-Gm-Message-State: AOJu0YyaJ4o59JXTg6fYmX3nMQ8AHTKHbdO7G70NxdeyDru8Tu73J6/R
 dER7ltXviJTXG2Jk9UBKfqG4X9fkRV0XLvYm4MmPrl0SFisULNxAe5D07TXhAQsiK5Z5aT68xGT
 Rn+iSYJT/sNljQw0pNLoJDzcABeagMKFLn4HamP5/LQ==
X-Gm-Gg: ASbGnctjqmyiboti5TcstyAlvfOY49+vlnJXihhBVElgtXu7eDA2nQo4oh/O6Ps8J5a
 99fT713qb/CSCfCbhY2RzYH2hWz1ntsJiGGrp/A58pyamPBTvHxb5vPW3ZH8mAfpglj1ODLR3rz
 MjzA3iNVaM6uiVYnM5MwU4L3uJ1cbINDQGfNRJtBThBTc=
X-Google-Smtp-Source: AGHT+IGTMGvA9IlsBifGM4LTrZkPCim9pr+OPXz4TVEt+id2kk8+FeoHDmuW3jF7bv5HTl/I1apPKx4fPlXj3oaza7A=
X-Received: by 2002:a05:6870:ab85:b0:2ea:7e18:5838 with SMTP id
 586e51a60fabf-2fef84c4874mr2332088fac.13.1752083446231; Wed, 09 Jul 2025
 10:50:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250613-binman_faked_optional-v3-0-1e23dd7c41a2@phytec.de>
 <20250613-binman_faked_optional-v3-3-1e23dd7c41a2@phytec.de>
In-Reply-To: <20250613-binman_faked_optional-v3-3-1e23dd7c41a2@phytec.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 9 Jul 2025 10:50:34 -0700
X-Gm-Features: Ac12FXxJCNAgLmyDl43_1JtxzAE4Pks-3nVyo27Dc8yz23CT2boDXlrwQWqiYDA
Message-ID: <CAJ+vNU2o3jtSMaUTd_1xms7QeAdJwTyy8Q+UiKQC56rCwk2G6g@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] binman: rework dropping absent entries from
 packaged image
To: Yannic Moog <y.moog@phytec.de>
Cc: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Tom Rini <trini@konsulko.com>, upstream@lists.phytec.de, u-boot@lists.denx.de
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

On Fri, Jun 13, 2025 at 5:04=E2=80=AFAM Yannic Moog <y.moog@phytec.de> wrot=
e:
>
> When blobs are absent and are marked as optional, they can be safely
> dropped from the binman tree. Use the drop_absent function for that.
> Rename drop_absent to drop_absent_optional as we do not want to drop any
> entries that are absent; they should be reported by binman as errors
> when they are missing.
> We also reorder the processing of the image the following:
> - We call the CheckForProblems function before the image is built.
> - We drop entries after we checked for problems with the image.
> This is okay because CheckForProblems does not look at the file we have
> written but rather queries the data structure (image) built with binman.
> This also allows us to get all error and warning messages that we want
> to report while avoiding putting missing optional entries in the final
> image.
> As only the blobs are dropped, the sections still remain in the
> assembled image. Thus add them to the expected test case checks where
> necessary.
>
> In addition, a rework of testPackTeeOsOptional test case is necessary.
>
> The test did not really do what it was supposed to. The description said
> that optional binary is tested, but the binary is not marked as
> optional. Further, the tee.elf file, when included in the image
> properly, also shows up in the image data. This must be added as well.
>
> As there is no global variable for the elf data, set the pathname to the
> elf file that was created when setting up the test suite.
> For the test case get the filename and read the contents, comparing them
> to the contents of the created binman image.
>
> Signed-off-by: Yannic Moog <y.moog@phytec.de>
> ---
>  tools/binman/control.py       |  5 ++---
>  tools/binman/entry.py         |  6 +++++-
>  tools/binman/etype/cbfs.py    |  3 ++-
>  tools/binman/etype/mkimage.py |  2 +-
>  tools/binman/etype/section.py | 16 ++++++++++++----
>  tools/binman/ftest.py         | 14 ++++++++------
>  tools/binman/image.py         |  2 ++
>  7 files changed, 32 insertions(+), 16 deletions(-)
>
> diff --git a/tools/binman/control.py b/tools/binman/control.py
> index 1946656f7d368209df3299a0e7c833b93edf2120..5a66c06d346cc74dc3e0e037e=
b263b6ced64a9b4 100644
> --- a/tools/binman/control.py
> +++ b/tools/binman/control.py
> @@ -697,7 +697,6 @@ def ProcessImage(image, update_fdt, write_map, get_co=
ntents=3DTrue,
>          image.SetAllowMissing(allow_missing)
>          image.SetAllowFakeBlob(allow_fake_blobs)
>          image.GetEntryContents()
> -        image.drop_absent()
>      image.GetEntryOffsets()
>
>      # We need to pack the entries to figure out where everything
> @@ -736,12 +735,12 @@ def ProcessImage(image, update_fdt, write_map, get_=
contents=3DTrue,
>          image.Raise('Entries changed size after packing (tried %s passes=
)' %
>                      passes)
>
> +    has_problems =3D CheckForProblems(image)
> +
>      image.BuildImage()
>      if write_map:
>          image.WriteMap()
>
> -    has_problems =3D CheckForProblems(image)
> -
>      image.WriteAlternates()
>
>      return has_problems
> diff --git a/tools/binman/entry.py b/tools/binman/entry.py
> index 6390917e5083e40a4e3294e5d36ec300d2057fe9..ce7ef28e94b17e34954477607=
0c457d5882661b1 100644
> --- a/tools/binman/entry.py
> +++ b/tools/binman/entry.py
> @@ -760,7 +760,7 @@ class Entry(object):
>                            self.image_pos)
>
>      # pylint: disable=3Dassignment-from-none
> -    def GetEntries(self):
> +    def GetEntries(self) -> None:
>          """Return a list of entries contained by this entry
>
>          Returns:
> @@ -1351,6 +1351,10 @@ features to produce new behaviours.
>              os.mkdir(cls.fake_dir)
>          tout.notice(f"Fake-blob dir is '{cls.fake_dir}'")
>
> +    def drop_absent_optional(self) -> None:
> +        """Entries don't have any entries, do nothing"""
> +        pass
> +
>      def ensure_props(self):
>          """Raise an exception if properties are missing
>
> diff --git a/tools/binman/etype/cbfs.py b/tools/binman/etype/cbfs.py
> index 124fa1e4ffc7d0374b27c09d32ead8429567d304..5879f377231bf94697bea97c3=
cfc3a2515665b8f 100644
> --- a/tools/binman/etype/cbfs.py
> +++ b/tools/binman/etype/cbfs.py
> @@ -276,7 +276,8 @@ class Entry_cbfs(Entry):
>          for entry in self._entries.values():
>              entry.ListEntries(entries, indent + 1)
>
> -    def GetEntries(self):
> +    def GetEntries(self) -> dict[str, Entry]:
> +        """Returns the entries (tree children) of this section"""
>          return self._entries
>
>      def ReadData(self, decomp=3DTrue, alt_format=3DNone):
> diff --git a/tools/binman/etype/mkimage.py b/tools/binman/etype/mkimage.p=
y
> index 6ae5d0c8a4f3c54e1277a575b8e235cc1aba4e13..75e59c3d3a3104da7559982f6=
4968fdd99b7bd5f 100644
> --- a/tools/binman/etype/mkimage.py
> +++ b/tools/binman/etype/mkimage.py
> @@ -205,7 +205,7 @@ class Entry_mkimage(Entry_section):
>              self.record_missing_bintool(self.mkimage)
>              return data
>
> -    def GetEntries(self):
> +    def GetEntries(self) -> dict[str, Entry]:
>          # Make a copy so we don't change the original
>          entries =3D OrderedDict(self._entries)
>          if self._imagename:
> diff --git a/tools/binman/etype/section.py b/tools/binman/etype/section.p=
y
> index 1d50bb477534702019502d08f8648d4c9a367c0f..03c4f7c6ec74c6fa75c9362e2=
fecdb0e6ab568cb 100644
> --- a/tools/binman/etype/section.py
> +++ b/tools/binman/etype/section.py
> @@ -537,7 +537,7 @@ class Entry_section(Entry):
>          for entry in self._entries.values():
>              entry.WriteMap(fd, indent + 1)
>
> -    def GetEntries(self):
> +    def GetEntries(self) -> dict[str, Entry]:
>          return self._entries
>
>      def GetContentsByPhandle(self, phandle, source_entry, required):
> @@ -772,9 +772,17 @@ class Entry_section(Entry):
>                         todo)
>          return True
>
> -    def drop_absent(self):
> -        """Drop entries which are absent"""
> -        self._entries =3D {n: e for n, e in self._entries.items() if not=
 e.absent}
> +    def drop_absent_optional(self) -> None:
> +        """Drop entries which are absent.
> +        Call for all nodes in the tree. Leaf nodes will do nothing per
> +        definition. Sections however have _entries and should drop all c=
hildren
> +        which are absent.
> +        """
> +        self._entries =3D {n: e for n, e in self._entries.items() if not=
 (e.absent and e.optional)}
> +        # Drop nodes first before traversing children to avoid superfluo=
us calls
> +        # to children of absent nodes.
> +        for e in self.GetEntries().values():
> +            e.drop_absent_optional()
>
>      def _SetEntryOffsetSize(self, name, offset, size):
>          """Set the offset and size of an entry
> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> index 4a8d330c8f89adc3c248199760a936dd243158a2..d707e2aa555b39316d206a4c1=
70ebb83aa6daf72 100644
> --- a/tools/binman/ftest.py
> +++ b/tools/binman/ftest.py
> @@ -251,7 +251,7 @@ class TestFunctional(unittest.TestCase):
>          # ATF and OP_TEE
>          TestFunctional._MakeInputFile('bl31.elf',
>              tools.read_file(cls.ElfTestFile('elf_sections')))
> -        TestFunctional._MakeInputFile('tee.elf',
> +        TestFunctional.tee_elf_path =3D TestFunctional._MakeInputFile('t=
ee.elf',
>              tools.read_file(cls.ElfTestFile('elf_sections')))
>
>          # Newer OP_TEE file in v1 binary format
> @@ -6459,16 +6459,18 @@ fdt         fdtmap                Extract the dev=
icetree blob from the fdtmap
>      def testAbsent(self):
>          """Check handling of absent entries"""
>          data =3D self._DoReadFile('262_absent.dts')
> -        self.assertEqual(U_BOOT_DATA + U_BOOT_IMG_DATA, data)
> +        self.assertEqual(U_BOOT_DATA + b'aa' + U_BOOT_IMG_DATA, data)
>
> -    def testPackTeeOsOptional(self):
> -        """Test that an image with an optional TEE binary can be created=
"""
> +    def testPackTeeOsElf(self):
> +        """Test that an image with a TEE elf binary can be created"""
>          entry_args =3D {
>              'tee-os-path': 'tee.elf',
>          }
> +        tee_path =3D self.tee_elf_path
>          data =3D self._DoReadFileDtb('263_tee_os_opt.dts',
>                                     entry_args=3Dentry_args)[0]
> -        self.assertEqual(U_BOOT_DATA + U_BOOT_IMG_DATA, data)
> +        self.assertEqual(U_BOOT_DATA + tools.read_file(tee_path) +
> +                         U_BOOT_IMG_DATA, data)
>
>      def checkFitTee(self, dts, tee_fname):
>          """Check that a tee-os entry works and returns data
> @@ -6724,7 +6726,7 @@ fdt         fdtmap                Extract the devic=
etree blob from the fdtmap
>
>          node =3D dtb.GetNode('/configurations/conf-missing-tee-1')
>          self.assertEqual('atf-1', node.props['firmware'].value)
> -        self.assertEqual(['u-boot', 'atf-2'],
> +        self.assertEqual(['u-boot', 'tee', 'atf-2'],
>                           fdt_util.GetStringList(node, 'loadables'))
>
>      def testTooldir(self):
> diff --git a/tools/binman/image.py b/tools/binman/image.py
> index 24ce0af7c72b5256a9a71963a6d94c080ed8bdd4..698cfa4148e1a0f762d90d99e=
e3bc581cff5105a 100644
> --- a/tools/binman/image.py
> +++ b/tools/binman/image.py
> @@ -183,6 +183,8 @@ class Image(section.Entry_section):
>          fname =3D tools.get_output_filename(self._filename)
>          tout.info("Writing image to '%s'" % fname)
>          with open(fname, 'wb') as fd:
> +            # For final image, don't write absent blobs to file
> +            self.drop_absent_optional()
>              data =3D self.GetPaddedData()
>              fd.write(data)
>          tout.info("Wrote %#x bytes" % len(data))
>
> --
> 2.43.0
>

Hi Yannic,

This series just got merged to master and I noticed it failing
building imx8mm_venice on my Ubuntu 20.04 dev host which has Python
3.8.10.

make imx8mm_venice_defconfig
make
...
  BINMAN  .binman_stamp
binman: 'type' object is not subscriptable
make: *** [Makefile:1336: .binman_stamp] Error 1

Do you know what the minimum version of python required is or what
would need to be changed here to support the previous version of
python that worked?

Best Regards,

Tim
