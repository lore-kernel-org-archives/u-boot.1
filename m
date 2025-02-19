Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A37C021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 00:04:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5796980F7D;
	Wed, 19 Feb 2025 01:04:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kmjuC58Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED04880F7A; Wed, 19 Feb 2025 01:04:32 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9BEE80F18
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 01:04:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ab7483b9bf7so790141066b.3
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 16:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739923470; x=1740528270; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pRT7PscJrZepxCw8ksj4KtyloAaEiSFaWCqeL7tTuEI=;
 b=kmjuC58QffBRSPCcs6ZBMRMaAZ7Tlb3H94/YToUwwKeOsh65cC42nrf10yqrU29Q3C
 VYoulAaGYkXAbcwH4k4X7fBnU6bm/J7mDV3NxCLXcLB56vIeGTadSNFXz8paruynlIt4
 JWRlzip9Gg2ao2sxhCgHiZjOIVvivIWTXjlfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739923470; x=1740528270;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pRT7PscJrZepxCw8ksj4KtyloAaEiSFaWCqeL7tTuEI=;
 b=fRY9j/9jwxky5JNQZi+eiaZTBbWwyI/lp2TFMhKO1uJbrFfSgiWV5uHqBR7wx/AuHV
 +L+0pUXsxyY31R55Ds2ORxLW42Ez6g2szSzPX2dHV1B9Etfk1P4QLMqOQpdDKjuupJrS
 LCfVBQns2wbDS+Jq3d3qgDi2izhn8A+0q+RQaSVufN2nPqhcjc+P7WVHyrf4QqDH34Nm
 oDGblgWjDiSI9J9dYq69lrXgCq4U8aiHKPw0V9EI4/PgCCZYJwfdKzAxd4akF0pMJCFr
 eJxL27bbh4n1Gy+GXApwd26PkcHgJ4OPobVIM7lN0MnIcnXMUYsU8o3MFWctywKEAIHF
 +e4w==
X-Gm-Message-State: AOJu0YxfvpHaEHn5YRLQJTAQo0cNeSqzQOYxkQ1cjNtfUinxSE98zF+T
 txCWvci+i9kG13mecTBCc3lUFUk0/rtu7Rr0AmzP01NcyF2LJ68ORc82HX3BMiRLGdIzG25I0U3
 7yp+FAprITH1AsCcWODRqRCMciaqgAHAn6dx+
X-Gm-Gg: ASbGncs94JmsDLEGo5HrXxaRkc4+akXdU/UYwIScfECtl+NYaR10HnQ+UDI5cjB0zpU
 wlhSC9ncPAcCiosUK3760aabA6ftZjyoMXXSviNTQ92DxF8N4FzFrkDa0afPQlFEPz0GFgQcyrw
 ==
X-Google-Smtp-Source: AGHT+IG28N2pbukSF6N92PcuJfemYDj9rjkw/o2xZm3iIwh7J1ssotDhA18n2kJQr7nWste1I7nXkRKy+TC9/JWvJeE=
X-Received: by 2002:a17:907:34c7:b0:abb:cdca:1c08 with SMTP id
 a640c23a62f3a-abbcdca498fmr103787166b.16.1739923470091; Tue, 18 Feb 2025
 16:04:30 -0800 (PST)
MIME-Version: 1.0
References: <20250212222259.684336-1-trini@konsulko.com>
 <20250218192524.GH1233568@bill-the-cat>
In-Reply-To: <20250218192524.GH1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 18 Feb 2025 17:04:18 -0700
X-Gm-Features: AWEUYZmMI3LKKY6Ju8TRdeeZk9PXF5SKNH2Sz_f1UiMAvc6tmjhW13q6fpYXx4g
Message-ID: <CAFLszTgErKoqM1t+WrguW1hpMpQdeF=CmZ7RqVeYEYNUiquaJg@mail.gmail.com>
Subject: Re: [PATCH RFC] binman: Handle some newer pylint warnings
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

Hi Tom,

On Tue, 18 Feb 2025 at 12:25, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Feb 12, 2025 at 04:22:59PM -0600, Tom Rini wrote:
>
> > With a newer pylint we have a few warnings show up now that are harder
> > to handle. The first problem is that when we call self.Raise(...) this
> > is no longer enough to have pylint see that we're now bailing out and
> > won't attempt to reference an unassigned variable. This is all of the
> > pylint disabling, with the exception of _AddNode.
> >
> > The problem with _AddNode is that before we call this function we set
> > fsw as libfdt.FdtSw() and I'm unsure how best to rework the code.
> >
> > The final problem is in CheckSetHashValue() where the function only
> > handles one algorithm but the intention is to handle others as well.
> > Once another algorithm is added and then also error handling for no
> > algorithm is added, we would not attempt to use data before it's been
> > assigned.
> >
> > As I'm not confident all of these are the right way to handle the
> > problem I've marked this as RFC and not split the changes up more.
> >
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Cc: Simon Glass <sjg@chromium.org>
> > ---
> >  tools/binman/etype/fdtmap.py       | 1 +
> >  tools/binman/etype/image_header.py | 1 +
> >  tools/binman/etype/pre_load.py     | 1 +
> >  tools/binman/etype/x509_cert.py    | 1 +
> >  tools/binman/ftest.py              | 1 +
> >  tools/binman/state.py              | 4 ++--
> >  6 files changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/binman/etype/fdtmap.py b/tools/binman/etype/fdtmap.py
> > index f1f6217940f2..a2b0d27fcc5f 100644
> > --- a/tools/binman/etype/fdtmap.py
> > +++ b/tools/binman/etype/fdtmap.py
> > @@ -109,6 +109,7 @@ class Entry_fdtmap(Entry):
> >          def _AddNode(node):
> >              """Add a node to the FDT map"""
> >              for pname, prop in node.props.items():
> > +                # pylint: disable=locally-disabled, possibly-used-before-assignment
> >                  fsw.property(pname, prop.bytes)
> >              for subnode in node.subnodes:
> >                  with fsw.add_node(subnode.name):
> > diff --git a/tools/binman/etype/image_header.py b/tools/binman/etype/image_header.py
> > index 240118849580..6d8db9eed564 100644
> > --- a/tools/binman/etype/image_header.py
> > +++ b/tools/binman/etype/image_header.py
> > @@ -72,6 +72,7 @@ class Entry_image_header(Entry):
> >              image_size = self.section.GetImageSize() or 0
> >              base = (0 if self.location != 'end' else image_size)
> >              offset = (image_pos - base) & 0xffffffff
> > +        # pylint: disable=locally-disabled, possibly-used-before-assignment
> >          data = IMAGE_HEADER_MAGIC + struct.pack('<I', offset)
> >          return data
> >
> > diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
> > index 2e4c72359ff3..e2615e1c7d1b 100644
> > --- a/tools/binman/etype/pre_load.py
> > +++ b/tools/binman/etype/pre_load.py
> > @@ -122,6 +122,7 @@ class Entry_pre_load(Entry_collection):
> >          else:
> >              self.Raise(padding_name + " is not supported")
> >
> > +        # pylint: disable=locally-disabled, possibly-used-before-assignment
> >          sig = padding.new(key, **padding_args).sign(hash_image)
> >
> >          hash_sig = SHA256.new()
> > diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x509_cert.py
> > index 29630d1b86c8..15d0766051c2 100644
> > --- a/tools/binman/etype/x509_cert.py
> > +++ b/tools/binman/etype/x509_cert.py
> > @@ -141,6 +141,7 @@ class Entry_x509_cert(Entry_collection):
> >                  dm_data_ext_boot_block=self.dm_data_ext_boot_block,
> >                  bootcore_opts=self.bootcore_opts
> >              )
> > +        # pylint: disable=locally-disabled, possibly-used-before-assignment
> >          if stdout is not None:
> >              data = tools.read_file(output_fname)
> >          else:
> > diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> > index a553ca9e5642..b6e58decb008 100644
> > --- a/tools/binman/ftest.py
> > +++ b/tools/binman/ftest.py
> > @@ -6387,6 +6387,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> >                      expect_val = entry.image_pos
> >                  elif prop_name == 'size':
> >                      expect_val = entry.size
> > +                # pylint: disable=locally-disabled, possibly-used-before-assignment
> >                  self.assertEqual(expect_val, val)
> >
> >      def testSymbolsElfBad(self):
> > diff --git a/tools/binman/state.py b/tools/binman/state.py
> > index 45bae40c525a..ca3f857f1943 100644
> > --- a/tools/binman/state.py
> > +++ b/tools/binman/state.py
> > @@ -410,8 +410,8 @@ def CheckSetHashValue(node, get_data_func):
> >              m = hashlib.sha256()
> >              m.update(get_data_func())
> >              data = m.digest()
> > -        for n in GetUpdateNodes(hash_node):
> > -            n.SetData('value', data)
> > +            for n in GetUpdateNodes(hash_node):
> > +                n.SetData('value', data)
> >
> >  def SetAllowEntryExpansion(allow):
> >      """Set whether post-pack expansion of entries is allowed
>
> Any thoughts on this Simon? Moving to a newer Ubuntu host for CI is
> blocked on moving to a newer pylint. Thanks.

There is no need to disable these warnings so far as I can tell and it
sets a bad precedent. We should just fix the code. I can send a patch
for this if you like?

Regards,
Simon
