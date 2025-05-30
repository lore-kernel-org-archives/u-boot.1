Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF448C5B549
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 11:18:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 626C182E0A;
	Fri, 30 May 2025 13:18:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LjVDRLhZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7CF682B8E; Fri, 30 May 2025 13:18:51 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B447483252
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 13:18:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-604b9c53f6fso3642911a12.2
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 04:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748603929; x=1749208729; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YFswiilUWcpEbWtuD7kN0SjJ21PzO2fmcdGr6Y93X/g=;
 b=LjVDRLhZkDFp20nG/KIwUlvE++3bgvaL6xkPjYxA6yRbHTWao08V8lUI0zYyrbEgrX
 86tv/5/tSAY8PuhMgnWa1JfNEJb2BK5OtPbJCTXkqvv9RrNlWfeg/06LIjzMc01dN39s
 Nq/xnRlNwzjkzYnW0QthzormAWUX1iRh4+zcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748603929; x=1749208729;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YFswiilUWcpEbWtuD7kN0SjJ21PzO2fmcdGr6Y93X/g=;
 b=YEfCfGbFXIp9ciM02U7T7WRgt6+1C5rVOtyK2YoLZhNMZKYWZR/GuPvZnul2mQzujN
 gheB/U5nEI2B+ClhfOB70zu/fRxK8JLhWjVd3xR7g9sjtVemvhBlJE4R5c3MAXxyL2ju
 725tLlPz1Fyi1kfYIQqHNd6/FzYXPKrMGC4jcKow+P3j3N+Ss5Du6g7OLoMUFVF2wNjg
 hinkzlYMCcL1QriHjvE453ZJikgUU2QqFyeIgr7XIU090Wd9OJ6dmkjQOX4M0JDjo03Q
 rrisOLdJ+aeNkHvs3WvkXLa/7Gd88gCbsepdQyJMgTZAqmMhlznrghL9G9DTBPAir6GY
 8BBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSt7PPvXVJtHkOjxnQr20g6D/0H8ssB8+2wkZwWACrG+yvIdy0VOqXVPy6+ktZJgax3bK/pro=@lists.denx.de
X-Gm-Message-State: AOJu0Yz95NKxQT9KVc2j4PRxObRvNKNlgptR3A5v7juCtyx4YwRVS2RY
 Dxn0+W7QqYPtUbbSbLdqrKsz0tbNY+Oj+uK30K/Svy6i/U+D2Xk+gY5itawLP+rznZcJJRh8XnA
 iYrfgeW/D0JdXkel94wtzOCJS7S6EHeD/eHaJiHBi
X-Gm-Gg: ASbGncsrFMVhaYAuNhlQ/MjrjcvqJvINUI+969LwH33cpvSnZ3I2UIcXfGNGUnfPjCS
 s4Xtf+LuGVGkmxAbERbp3N2Sd2Ga8QPwvG4Uia2sHCbMXXLPI+Ww6uF0185dlC8/byO1joZr56n
 k8BPh5mouscFx2kmwWq8IbZGp3pE9uWKg=
X-Google-Smtp-Source: AGHT+IHakm6w576mtp/nKbsL2tvov/6uw7jPwyC9A8UGMnGY6oJrggboeOH56loJZ7keL61CA7HrcWCj4RJoJbsB2G4=
X-Received: by 2002:a05:6402:13d1:b0:605:38d2:f2f1 with SMTP id
 4fb4d7f45d1cf-6056ece9cd9mr2489256a12.32.1748603929020; Fri, 30 May 2025
 04:18:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250527-binman_faked_optional-v2-0-3362ab897581@phytec.de>
 <20250527-binman_faked_optional-v2-5-3362ab897581@phytec.de>
In-Reply-To: <20250527-binman_faked_optional-v2-5-3362ab897581@phytec.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 30 May 2025 12:18:32 +0100
X-Gm-Features: AX0GCFsNgpAXUqbSChQje-Tr-f8fByJidHoGAzcYUBSERfKSHAwtzbeXPHPtPQw
Message-ID: <CAFLszTgTdjza2FMAfzRu09Bof+t0n4-2OCm1Cwj0xggExA_JVA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 5/8] binman: rework dropping absent entries from
 packaged image
To: Yannic Moog <y.moog@phytec.de>
Cc: upstream@lists.phytec.de, u-boot@lists.denx.de
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

Hi Yannic,

On Tue, 27 May 2025 at 14:24, Yannic Moog <y.moog@phytec.de> wrote:
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
>
> Signed-off-by: Yannic Moog <y.moog@phytec.de>
> ---
>  tools/binman/control.py       |  8 ++++----
>  tools/binman/entry.py         |  6 +++++-
>  tools/binman/etype/cbfs.py    |  3 ++-
>  tools/binman/etype/mkimage.py |  2 +-
>  tools/binman/etype/section.py | 18 +++++++++++++-----
>  tools/binman/image.py         |  4 +++-
>  6 files changed, 28 insertions(+), 13 deletions(-)
>
> diff --git a/tools/binman/control.py b/tools/binman/control.py
> index 81f61e3e152a9eab558cfc9667131a38082b61a1..c2a4d3eae9d4e8f4a3c5be1abfb1469ba1c0ed93 100644
> --- a/tools/binman/control.py
> +++ b/tools/binman/control.py
> @@ -18,6 +18,7 @@ import re
>
>  import sys
>
> +import image

This is done later in this file, to avoid warnings about missing
modules when trying to get help ('binman -h'). I am guessing you need
it for the type declaration below.

It may be that this is not necessary anymore though, in which case
could you put this in a separate patch, use the 'from binman import'
syntax and drop the other 'imports' from below?

>  from binman import bintool
>  from binman import cbfs_util
>  from binman import elf
> @@ -669,7 +670,7 @@ def CheckForProblems(image):
>                                     for bintool in missing_bintool_list])))
>      return any([missing_list, faked_list, missing_bintool_list])
>
> -def ProcessImage(image, update_fdt, write_map, get_contents=True,
> +def ProcessImage(image: image.Image, update_fdt, write_map, get_contents=True,
>                   allow_resize=True, allow_missing=False,
>                   allow_fake_blobs=False):
>      """Perform all steps for this image, including checking and # writing it.
> @@ -697,7 +698,6 @@ def ProcessImage(image, update_fdt, write_map, get_contents=True,
>          image.SetAllowMissing(allow_missing)
>          image.SetAllowFakeBlob(allow_fake_blobs)
>          image.GetEntryContents()
> -        image.drop_absent()
>      image.GetEntryOffsets()
>
>      # We need to pack the entries to figure out where everything
> @@ -736,12 +736,12 @@ def ProcessImage(image, update_fdt, write_map, get_contents=True,
>          image.Raise('Entries changed size after packing (tried %s passes)' %
>                      passes)
>
> +    has_problems = CheckForProblems(image)
> +
>      image.BuildImage()
>      if write_map:
>          image.WriteMap()
>
> -    has_problems = CheckForProblems(image)
> -
>      image.WriteAlternates()
>
>      return has_problems
> diff --git a/tools/binman/entry.py b/tools/binman/entry.py
> index 6390917e5083e40a4e3294e5d36ec300d2057fe9..ce7ef28e94b17e349544776070c457d5882661b1 100644
> --- a/tools/binman/entry.py
> +++ b/tools/binman/entry.py
> @@ -760,7 +760,7 @@ class Entry(object):
>                            self.image_pos)
>
>      # pylint: disable=assignment-from-none
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
> index 886e34ef8221ad50e9f881e8abad16015c9790b5..bb97b227ef78356b08b5cc31b04d98c6fa0633ef 100644
> --- a/tools/binman/etype/cbfs.py
> +++ b/tools/binman/etype/cbfs.py
> @@ -276,7 +276,8 @@ class Entry_cbfs(Entry):
>          for entry in self.GetEntries().values():
>              entry.ListEntries(entries, indent + 1)
>
> -    def GetEntries(self):
> +    def GetEntries(self) -> dict[str, Entry]:
> +        """Returns the entries (tree children) of this section"""
>          return self._entries
>
>      def ReadData(self, decomp=True, alt_format=None):
> diff --git a/tools/binman/etype/mkimage.py b/tools/binman/etype/mkimage.py
> index 19ee30a13ca75a5d05a17d4c26424e84934b6ea2..c9362c6bbf740da946abe2fadefe35ebfc89fced 100644
> --- a/tools/binman/etype/mkimage.py
> +++ b/tools/binman/etype/mkimage.py
> @@ -205,7 +205,7 @@ class Entry_mkimage(Entry_section):
>              self.record_missing_bintool(self.mkimage)
>              return data
>
> -    def GetEntries(self):
> +    def GetEntries(self) -> dict[str, Entry]:
>          # Make a copy so we don't change the original
>          entries = OrderedDict(self._entries)
>          if self._imagename:
> diff --git a/tools/binman/etype/section.py b/tools/binman/etype/section.py
> index 44b1b85e93496d0ca114907f42a98da1f0af09b9..8e5c20e3017c9b320ebfdfd3bf82489ed6161c98 100644
> --- a/tools/binman/etype/section.py
> +++ b/tools/binman/etype/section.py
> @@ -450,7 +450,7 @@ class Entry_section(Entry):
>      def _PackEntries(self):
>          """Pack all entries into the section"""
>          offset = self._skip_at_start
> -        for entry in self._entries.values():
> +        for entry in self.GetEntries().values():

As per previous patch, this should not be needed.

>              offset = entry.Pack(offset)
>          return offset
>
> @@ -533,7 +533,7 @@ class Entry_section(Entry):
>          for entry in self.GetEntries().values():
>              entry.WriteMap(fd, indent + 1)
>
> -    def GetEntries(self):
> +    def GetEntries(self) -> dict[str, Entry]:
>          return self._entries
>
>      def GetContentsByPhandle(self, phandle, source_entry, required):
> @@ -768,9 +768,17 @@ class Entry_section(Entry):
>                         todo)
>          return True
>
> -    def drop_absent(self):
> -        """Drop entries which are absent"""
> -        self._entries = {n: e for n, e in self._entries.items() if not e.absent}
> +    def drop_absent_optional(self) -> None:
> +        """Drop entries which are absent.
> +        Call for all nodes in the tree. Leaf nodes will do nothing per
> +        definition. Sections however have _entries and should drop all children

should this be: all optional children ?

> +        which are absent.
> +        """
> +        self._entries = {n: e for n, e in self._entries.items() if not (e.absent and e.optional)}
> +        # Drop nodes first before traversing children to avoid superfluous calls
> +        # to children of absent nodes.
> +        for e in self.GetEntries().values():

As above, I think self._entries is correct

> +            e.drop_absent_optional()
>
>      def _SetEntryOffsetSize(self, name, offset, size):
>          """Set the offset and size of an entry
> diff --git a/tools/binman/image.py b/tools/binman/image.py
> index 24ce0af7c72b5256a9a71963a6d94c080ed8bdd4..86543ad8db36b38afc1957fde7e20152067b79aa 100644
> --- a/tools/binman/image.py
> +++ b/tools/binman/image.py
> @@ -15,7 +15,7 @@ import sys
>  from binman.entry import Entry
>  from binman.etype import fdtmap
>  from binman.etype import image_header
> -from binman.etype import section
> +from etype import section

Why this change? I suspect it will break when installed with 'pip
install binary-manager'

>  from dtoc import fdt
>  from dtoc import fdt_util
>  from u_boot_pylib import tools
> @@ -183,6 +183,8 @@ class Image(section.Entry_section):
>          fname = tools.get_output_filename(self._filename)
>          tout.info("Writing image to '%s'" % fname)
>          with open(fname, 'wb') as fd:
> +            # For final image, don't write absent blobs to file
> +            self.drop_absent_optional()
>              data = self.GetPaddedData()
>              fd.write(data)
>          tout.info("Wrote %#x bytes" % len(data))
>
> --
> 2.43.0
>

Regards,
Simon
