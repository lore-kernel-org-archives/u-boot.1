Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0503EFF8850
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 04:33:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F124A80433;
	Mon, 27 Apr 2026 06:33:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mzFXYziW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C16CD83693; Mon, 27 Apr 2026 06:33:17 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31C1380077
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 06:33:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7de46b8e432so3934248a34.1
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 21:33:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777264393; cv=none;
 d=google.com; s=arc-20240605;
 b=CvFLpslZl/ROHNiHoemYaiv3whwmQY28NDeyTeS7GvpixmtFg9TegTNLxGTniDgcYT
 QnozPV264v7qqt/8PbYsAaRZoOksrH/j3GdFxrlQBOIC3b8zqBOFXeRWRffcGeDHCTmW
 JYdSUH+BZJpIuXkdrzg810NXuhXfNehkbYlRdjTxaA9Cl+Miw5wZdEIcClLHgXZnlyQa
 QS/cNjtBzzGsapP6J4PmHwxpm9yNH2v0/6OF9O+hbB6qr0MjQud2AZCvkecnySPe6Ocf
 dLWlsomOeHwElLzqLQp7xgKQcwOFVoVHI4cqou77D2QOHImkGtdflwIyFIWy93Syc2f6
 4ugQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tabp2C/uW35/XdD6T+gd+rLHhQpqyaB+V3gBT26KqWY=;
 fh=DFrvjkYae3Jq40RhUx4J9+lntH6NSaSi7QcpJxmZ6iw=;
 b=K6l4O8OY+Q1A5kzZDlij9DRucEAlfnm1HcOXxK1XzDG5gWqq+N7rKR0Hp5TIUuSs84
 h+vlt63KKeM8CtLNXgC01mWaHyT3mu+Clmnygaqv2Rn/bf84sGhsdDyqjHwNkz1Chg0T
 +1mGeXdxGWtqh/Q6gWKE95D04h3nMrgb4MgNIJMVemR9LYcTYOlpuvfOgWOAPT8ZeEkl
 lw1M2qv0HRvRvpjvo3BMOBLeASTMOVbxO7FhgOyiT1jMJGzSp67OiCS5pGMCbmtazabm
 ha/WpVlEBiS9mXW3JcL1ztABJidVOSQP610NOGuyndFw9Fn81MYVoXf34zF3lfHyyezC
 +7bQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777264393; x=1777869193; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tabp2C/uW35/XdD6T+gd+rLHhQpqyaB+V3gBT26KqWY=;
 b=mzFXYziW9WMlWqiu4c3JlX8C87G2Zvg1XADtr+aHoDqGdAJF3mH+6DFV2SrIBthsNQ
 nmqsg6ip0h0USZLNfxQfbq5g268GlZUfHMAQ0r4sMk/Sc4t6N8UiTmYRHlTz7lbCBrjm
 UXeJn0weWCv65+Rk0D00Jcs1wkyBTh/wzHA7K9WQa6OnaaXnPQ1rjPxrgxbCVzbUMFOP
 s4LSVi5Q6V1C9pPYbFCNkXPKI8Ro/5dTKTBGWs5OoQA1PBGrr0GwXQ4KRQhOqJEQrdwP
 UlHMsBT2+Chv/gssxUSdkeTkIyAYd2cPd4xmspWJ1MBmZndBZtyvYTdwr5iRtd833aAS
 kPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777264393; x=1777869193;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tabp2C/uW35/XdD6T+gd+rLHhQpqyaB+V3gBT26KqWY=;
 b=fSXbH1cW3v3XpZNv3UUc9w+UUM2AZNwB7LHgQ/42wcK2GwtvShmlVTfCuAGATQJPs1
 fiiOHlz7o+aCHtDSQPNo+C6f8ltBHQNANyC0FMYYYnvAWzFGsZfaqULdUqSFNg9Lxf4t
 Ol3wKFZSH4yTLwrcLSX0DIo4u/d3prQ9y9ibKSrAo574FYMcQPZu3MmEylDtTkFdtcCX
 xN/mFCtguRNjHv6rDa9TlBWw/MsfvlRgtPcGAdIq1YZqyXzKSxl4kBYAJqh8rJReNDIb
 y+GY1qjuDE7IpyG18LbOBB2ZBJ/eWZInAfQTFRCc9zhzartykzz39gwRngXV4lN4BLWf
 ok2A==
X-Gm-Message-State: AOJu0YxyrkZMHyJ7yw14jztM9k093AyqP8iIMGFPL5gqCJnly+e1Kony
 g6d0MlRFDaojmg7tBO+daazMUCka8iGOpjWxIPzfqjvUjBFZ3uuf2VbyjSp9+QzGWnR3Ip+9YMJ
 4BYeDRWfPjn4DEw6F88Fw44zEglzAUZg=
X-Gm-Gg: AeBDieuixm+6w0Vmd9SI1gfBn3JH10mQwlQgyzpcWo1pgrWPVt3zWoJVdppQGjpd6qO
 Uv9mC2TFX/IIXmy/3KzIRDItvVjdDugatFoKrkBlLQxTKzhWsuLLwdLZ0iZv0VFBfTocJZPdVPR
 QNf6TEHwjDv+IK0GN+CULArJrrBO6hl+nRqmrsHPL+IL3CsOLX3reOzlOp+/sjtBCyuC/n24w9g
 f6VYOujSDZfBpHdWb/wUq/BtWadMyx55GGR6gWpaQZEt149Gko73uBUkrQ81GQQtU5xJhLbH+Dm
 jyb+DV/j3KqIc3EBkg4i2lXCJi7jog==
X-Received: by 2002:a05:6830:6d05:b0:7dd:72f:7fb6 with SMTP id
 46e09a7af769-7dd072f8384mr13757056a34.17.1777264392765; Sun, 26 Apr 2026
 21:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260422065910.5398-1-briansune@gmail.com>
 <870316ea-6fbb-4923-b772-58528eadaf10@altera.com>
 <CAN7C2SDD2p89v=haRMt4Fj=xypRcWP4PGTQ17WSJA1ysp2n+CA@mail.gmail.com>
 <c63a73eb-3c5c-439c-924e-e5a9c0baabf0@altera.com>
In-Reply-To: <c63a73eb-3c5c-439c-924e-e5a9c0baabf0@altera.com>
From: Sune Brian <briansune@gmail.com>
Date: Mon, 27 Apr 2026 12:33:00 +0800
X-Gm-Features: AQROBzCIRghS75F4oDWmRpYYmYhjNUWDJd1BV46WlgcBldjHZ9tkh8TaFsH9c34
Message-ID: <CAN7C2SCUXsVvjazwA2ri==GOfpew3T=3aNL+dyuAFT44qDk66g@mail.gmail.com>
Subject: Re: [PATCH v5] Improve handoff prepare on SoCFPGA
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
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

On Mon, Apr 27, 2026 at 11:09=E2=80=AFAM Chee, Tien Fong
<tien.fong.chee@altera.com> wrote:
>
> Hi Brian,
>
> On 23/4/2026 11:23 am, Sune Brian wrote:
> > [CAUTION: This email is from outside your organization. Unless you trus=
t the sender, do not click on links or open attachments as it may be a frau=
dulent email attempting to steal your information and/or compromise your co=
mputer.]
> >
> > On Thu, Apr 23, 2026 at 10:20=E2=80=AFAM Chee, Tien Fong
> > <tien.fong.chee@altera.com> wrote:
> >> Hi Brian,
> >>
> >>
> >> On 22/4/2026 2:59 pm, Brian Sune wrote:
> >>> [CAUTION: This email is from outside your organization. Unless you tr=
ust the sender, do not click on links or open attachments as it may be a fr=
audulent email attempting to steal your information and/or compromise your =
computer.]
> >>>
> >>> Ensure qts folder header files are properly updated by isolating
> >>> the Python execution environment. This prevents partial or failed
> >>> script runs from corrupting the target directory.
> >>>
> >>> Changelog v4 -> v5:
> >>> - Change HANDOFF_KEEP condition to if [ 2501{HANDOFF_KEEP:-0} !=3D 0 =
]
> >>
> >> appears corrupted in the commit message, e.g.:
> >>        if [ 2501{HANDOFF_KEEP:-0} !=3D 0 ]
> >>
> >>
> >>      Please correct this to the actual test (e.g. reference to
> >>      "${HANDOFF_KEEP:-0}" and proper quoting) so 'git log' is accurate=
.
> >>
> >>
> >>> - Add HANDOFF_KEEP and HANDOFF_PATH comments in config.mk
> >>>
> >>> Changes:
> >>> - Implement a temp folder for Python script execution.
> >>> - Clean temp folder automatically despite execution failures.
> >>> - Gate the file replacement process on the successful exit of
> >>>     the Python scripts.
> >>> - Execute the replacement (with or without keep) only upon script
> >>>     success via the NEW HANDOFF_KEEP=3Dxxx variable.
> >>> - Rename old files to .h.handoff_backup.<timestamp> when the
> >>>     keep option is selected.
> >>>
> >>> Signed-off-by: Brian Sune <briansune@gmail.com>
> >>> ---
> >>>    arch/arm/mach-socfpga/config.mk | 38 +++++++++++++++++++++++++++++=
+---
> >>>    1 file changed, 35 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/arch/arm/mach-socfpga/config.mk b/arch/arm/mach-socfpga/=
config.mk
> >>> index 1ca1d33cb16..e777b95b528 100644
> >>> --- a/arch/arm/mach-socfpga/config.mk
> >>> +++ b/arch/arm/mach-socfpga/config.mk
> >>> @@ -1,6 +1,17 @@
> >>>    # SPDX-License-Identifier: GPL-2.0+
> >>>    #
> >>>    # Brian Sune <briansune@gmail.com>
> >>> +#
> >>> +# HANDOFF_PATH
> >>> +# ------------
> >>> +# Unset - Board path where qts locates and "hps_isw_handoff" should =
be placed.
> >>> +# Set   - Custom path points to "hps_isw_handoff" folder.
> >>> +#
> >>> +# HANDOFF_KEEP
> >>> +# ------------
> >>> +# Unset - HANDOFF_KEEP=3D , Clean header files.
> >>> +# Set   - HANDOFF_KEEP=3D0, Clean header files.
> >>> +#         HANDOFF_KEEP=3D1, Backup header files and rename to ".h.ha=
ndoff_backup.<timestamp>".
> >>
> >> Should be tightened to match the real behaviour:
> >>      - For HANDOFF_KEEP, avoid lines that mix "Unset" and "HANDOFF_KEE=
P=3D " in
> >>        a way that is easy to misread. Document:
> >>          unset, empty, or =3D0  =3D> clean old .h in qts, then install=
 new
> >>          =3D1 (or any non-0)     =3D> rename old *.h to .h.handoff_bac=
kup.<ts>
> >>
> >>
> >>      - For HANDOFF_PATH, a short "unset: auto hps_isw_handoff; set: cu=
stom
> >>        handoff path" style note reads clearer than the current phrasin=
g.
> >>
> >>>    ifeq ($(CONFIG_ARCH_SOCFPGA_CYCLONE5),y)
> >>>    archprepare: socfpga_g5_handoff_prepare
> >>> @@ -43,6 +54,27 @@ socfpga_g5_handoff_prepare:
> >>>                           exit 0; \
> >>>                   fi; \
> >>>                   echo "[INFO] Found hiof file: $$HIOF_FILE"; \
> >>> -               echo "[INFO] Running BSP generator..."; \
> >>> -               python3 $(srctree)/tools/cv_bsp_generator/cv_bsp_gene=
rator.py -i "$$HANDOFF_PATH" -o "$$BOARD_DIR/qts" || echo "[WARN] BSP gener=
ator failed, continuing..."; \
> >>> -               echo "[DONE] SoCFPGA QTS handoff conversion complete.=
"
> >>> +               echo "[INFO] Try BSP generator..."; \
> >>> +               TEMP_DIR=3D$$(mktemp -dp "$$BOARD_DIR/"); \
> >>> +               trap 'rm -rf "$$TEMP_DIR"' EXIT; \
> >>> +               if python3 $(srctree)/tools/cv_bsp_generator/cv_bsp_g=
enerator.py -i "$$HANDOFF_PATH" -o "$$TEMP_DIR"; then \
> >>> +                       if [ "$${HANDOFF_KEEP:-0}" !=3D "0" ]; then \
> >>> +                               echo "[INFO] Preserving old BSP files=
..."; \
> >>> +                               TIMESTAMP=3D$$(date +%Y%m%d_%H%M%S); =
\
> >>> +                               for f in "$$BOARD_DIR"/qts/*.h; do \
> >>> +                                       [ -e "$$f" ] || continue; \
> >>> +                                       echo "[INFO] $$f -> $${f%.h}.=
h.handoff_backup.$$TIMESTAMP"; \
> >>> +                                       mv "$$f" "$${f%.h}.h.handoff_=
backup.$$TIMESTAMP"; \
> >>> +                               done; \
> >>> +                       else \
> >>> +                               echo "[INFO] Clean old BSP files...";=
 \
> >>> +                               if ls "$$BOARD_DIR/qts"/*.h >/dev/nul=
l 2>&1; then \
> >>> +                                       rm "$$BOARD_DIR/qts"/*.h; \
> >>> +                                       echo "[INFO] Removed old BSP =
files..."; \
> >>> +                               fi; \
> >>> +                       fi; \
> >>> +                       mv "$$TEMP_DIR"/*.h "$$BOARD_DIR"/qts; \
> >>> +                       echo "[INFO] SoCFPGA QTS handoff conversion c=
omplete."; \
> >>> +               else \
> >>> +                       echo "[WARN] BSP generator failed!"; \
> >>> +               fi;
> >>> --
> >>> 2.34.1
> >>
> >> You can add Simon and my review tag to a new version.
> >>
> >> I=E2=80=99m fine to proceed with v5 as posted. If you prefer a differe=
nt
> >> implementation,
> >>
> >> feel free to propose it in a follow=E2=80=91up patch and we can review=
 it there.
> > Hi T.F.,
> >
> > I committed a new v6 patch just to replace the corrupted " symbol.
> >
> > The version control placing v5 with v5 is not allowed so v6 is used.
> > While the change log kept v4->v5 because code changes are not
> > done under v6.
> > So v6 is a git commit text fix only.
>
>
> I=E2=80=99ve received a few v6 patches on my end. Is this the one you=E2=
=80=99re
> referring to?
>
> https://patchwork.ozlabs.org/project/uboot/patch/20260423042538.3367-1-br=
iansune@gmail.com/
>
> Thanks.

Please only keep this thank you.
Sorry for the trouble:

Message ID20260423033551.15109-1-briansune@gmail.com

Thanks,
Brian

>
>
> Best regards,
>
> Tien Fong
>
>
>
