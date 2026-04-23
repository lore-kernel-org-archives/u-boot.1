Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DAB9FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 21:20:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C61B584353;
	Sat, 25 Apr 2026 23:20:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N0rWX3WR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B3B38435C; Sat, 25 Apr 2026 23:20:55 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E10884178
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 23:20:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-68470763896so4800684eaf.1
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 14:20:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777152052; cv=none;
 d=google.com; s=arc-20240605;
 b=jkf7M/zmyvK6ArXM9xqmtK04/svHTQBmDjaKmhS7czXmKJ2ESBX/p7oI5jsYRhTfqg
 v+mHAeqkMFms0w4WeRGg56vkqwWOftt3tMBuvyzkEL5VPC9CMM754tSTdir7RsjPGj4p
 Ofia7wRU3CSSK9W0IJiov/kLQwNr+J99P1Tz9buzXLPF9SQXGehDeShGr4UxJoJEziwz
 yRNHajf2IJD1LOFoSQfU+gqrulHAeWkC5ZTwTzZEr5kKveCWne1hrNqBa/dPVzcmEkbs
 8LSi/4h2aBKsddkW2n7Cs24MX98yuec3+/eHhJXm2pJdaIQ/72whUGs6IajgNpiRcLnc
 AjdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nD4Vw9P7JilS8K7XT0SNTlErvZ8TbXVwzvAI5v3hYTc=;
 fh=DFrvjkYae3Jq40RhUx4J9+lntH6NSaSi7QcpJxmZ6iw=;
 b=ae9af36I7hYzgOmRFneUlCMh0x05LsddSzW8n4sHSh5PiKWEWXSgVHwhxvSowmzKZ5
 iPJQbNt+3OmLZEL4/XemA3jEo2aQuzwNNkVaGXr6cxXNjcHUZI1MpojpNudweFtBLuUU
 8TF9XQ3oSuaAO9CSoM/SAA4jlzNr7q1tbBYcWudPoyyDASudW916H4VinPhRj+Ka1+Vo
 8W5ghbSerxGbpM3gFBoIlaRVsu7LMHteRt2Viu/b+aM9XXJoexoTjXHF2NlXBorXqqCU
 YmB/8MLLnMVn+Ey8BRTrbgZ0bjc/q87QjlEHpyOzgokt/5Sd6mBNtzUVMOOI8zrfSLYz
 g3VA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777152052; x=1777756852; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nD4Vw9P7JilS8K7XT0SNTlErvZ8TbXVwzvAI5v3hYTc=;
 b=N0rWX3WRXnw5YmSZxWiVOTtksOzL+lSvUBngUhH4ZK0nVEtvHyj2JV/M7hafKPyDX8
 Prv6yModZreXPl6Iv0snXFeJoGr6Gu91AHwca8dbs91kKbOaDRNyk/yB4lTEPw1c+E1m
 kZYApbDyTsHthm8mNPeQxE7blaZTfhuxE0iqlWcxO5bl7/ugM9VMse5FKE2o+r64GpcA
 P7qkt9c7KP5v42827hE5OgvYQ8mB+nNa/Q9NdHSWDme86qx0i9otc6cvh+46kjE1Gwea
 rarAu9OKYLfIjFivoO0GEki0IaktBIt1DlTPiDl9/pJur1UN5tCHiYdT/iBZS28DhJ65
 RImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777152052; x=1777756852;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nD4Vw9P7JilS8K7XT0SNTlErvZ8TbXVwzvAI5v3hYTc=;
 b=AbpwFBPhhlIlCBgH4WgT8w58aeo6dgMNsuonxcye1/Apdbz6UHawAmk6W+6O9ftt0r
 wG+xZRx5sXk23/UaN34HQ8KUTCTtnfm9taMhgZh1SqEOg+7jb0G65xoLVWTIimfVZbY9
 YMF0kVdGYOMi7IkRTaSoAj6j9X+LAE0+YeTH0joldsI9ROXGPjenVC5N1x3rW/XoPL0r
 rx2/aHH848haBa+9Kqr9vhmPWh2BWzMvl8Nf33UT9MJKSOk6fAkgvvY+0E7/oGL5pOM0
 fKEi2rfwUyxNtNFDiVQGhPLILb3Js7q17BxCuYGNUtLAGAkKBjYoXiDxDYN7LbRI4Z40
 AJoA==
X-Gm-Message-State: AOJu0Yz5crbSyRyX/1jjJqdXCnt7+XTBycFx7EGonutJXmSBfSsoWWgT
 i1rujTbwF5xH9bF6XFuwUUzIhT0evM/79BLq564Ad7QZbBGjx4mg9WhYnCobeWQPLO6yYS3Pqmt
 wyXdsFCNVokHkc9OsHM4mxg42OLFkGBWiTuj7swuE66Mb
X-Gm-Gg: AeBDiesTWfgi9mRuPfc5Il+m4DlnjAUIBjh5qPVoLCpBl/rbXsJEOpvtswuBezAkYNy
 SVvNWGu9i075x9TYkqkwIuZP5Km8oANVKLqO2hUaoyQ0IjLzdqXBYvxzvdasBqfDEwhYECnjdls
 EFPswfFubaGhe1rLT/McrTD5n+NB0dgwd7L0q5XJp4hJgeksHmAeSLJ4HP6gAjkKY0tFYe4uqqq
 rIGDranaaTu35ZTqWj1cesBeUKkrKzW7D89nOnjuPullGV4E5P5MnZ53tlm72qElHR5glA5gReu
 fLlWerFWzu1SULDgz8I=
X-Received: by 2002:a05:6830:3103:b0:7d7:f5d4:ef5b with SMTP id
 46e09a7af769-7dc94fdae02mr18657234a34.7.1776914628871; Wed, 22 Apr 2026
 20:23:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260422065910.5398-1-briansune@gmail.com>
 <870316ea-6fbb-4923-b772-58528eadaf10@altera.com>
In-Reply-To: <870316ea-6fbb-4923-b772-58528eadaf10@altera.com>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 23 Apr 2026 11:23:36 +0800
X-Gm-Features: AQROBzBhANm5SxYzmVoB11BBrMYqzjaL7W5bSKio3xF4GfglUca5iSgJkMEEzxA
Message-ID: <CAN7C2SDD2p89v=haRMt4Fj=xypRcWP4PGTQ17WSJA1ysp2n+CA@mail.gmail.com>
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

On Thu, Apr 23, 2026 at 10:20=E2=80=AFAM Chee, Tien Fong
<tien.fong.chee@altera.com> wrote:
>
> Hi Brian,
>
>
> On 22/4/2026 2:59 pm, Brian Sune wrote:
> > [CAUTION: This email is from outside your organization. Unless you trus=
t the sender, do not click on links or open attachments as it may be a frau=
dulent email attempting to steal your information and/or compromise your co=
mputer.]
> >
> > Ensure qts folder header files are properly updated by isolating
> > the Python execution environment. This prevents partial or failed
> > script runs from corrupting the target directory.
> >
> > Changelog v4 -> v5:
> > - Change HANDOFF_KEEP condition to if [ 2501{HANDOFF_KEEP:-0} !=3D 0 ]
>
>
> appears corrupted in the commit message, e.g.:
>       if [ 2501{HANDOFF_KEEP:-0} !=3D 0 ]
>
>
>     Please correct this to the actual test (e.g. reference to
>     "${HANDOFF_KEEP:-0}" and proper quoting) so 'git log' is accurate.
>
>
> > - Add HANDOFF_KEEP and HANDOFF_PATH comments in config.mk
> >
> > Changes:
> > - Implement a temp folder for Python script execution.
> > - Clean temp folder automatically despite execution failures.
> > - Gate the file replacement process on the successful exit of
> >    the Python scripts.
> > - Execute the replacement (with or without keep) only upon script
> >    success via the NEW HANDOFF_KEEP=3Dxxx variable.
> > - Rename old files to .h.handoff_backup.<timestamp> when the
> >    keep option is selected.
> >
> > Signed-off-by: Brian Sune <briansune@gmail.com>
> > ---
> >   arch/arm/mach-socfpga/config.mk | 38 ++++++++++++++++++++++++++++++--=
-
> >   1 file changed, 35 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/mach-socfpga/config.mk b/arch/arm/mach-socfpga/co=
nfig.mk
> > index 1ca1d33cb16..e777b95b528 100644
> > --- a/arch/arm/mach-socfpga/config.mk
> > +++ b/arch/arm/mach-socfpga/config.mk
> > @@ -1,6 +1,17 @@
> >   # SPDX-License-Identifier: GPL-2.0+
> >   #
> >   # Brian Sune <briansune@gmail.com>
> > +#
> > +# HANDOFF_PATH
> > +# ------------
> > +# Unset - Board path where qts locates and "hps_isw_handoff" should be=
 placed.
> > +# Set   - Custom path points to "hps_isw_handoff" folder.
> > +#
> > +# HANDOFF_KEEP
> > +# ------------
> > +# Unset - HANDOFF_KEEP=3D , Clean header files.
> > +# Set   - HANDOFF_KEEP=3D0, Clean header files.
> > +#         HANDOFF_KEEP=3D1, Backup header files and rename to ".h.hand=
off_backup.<timestamp>".
>
>
> Should be tightened to match the real behaviour:
>     - For HANDOFF_KEEP, avoid lines that mix "Unset" and "HANDOFF_KEEP=3D=
 " in
>       a way that is easy to misread. Document:
>         unset, empty, or =3D0  =3D> clean old .h in qts, then install new
>         =3D1 (or any non-0)     =3D> rename old *.h to .h.handoff_backup.=
<ts>
>
>
>     - For HANDOFF_PATH, a short "unset: auto hps_isw_handoff; set: custom
>       handoff path" style note reads clearer than the current phrasing.
>
> >
> >   ifeq ($(CONFIG_ARCH_SOCFPGA_CYCLONE5),y)
> >   archprepare: socfpga_g5_handoff_prepare
> > @@ -43,6 +54,27 @@ socfpga_g5_handoff_prepare:
> >                          exit 0; \
> >                  fi; \
> >                  echo "[INFO] Found hiof file: $$HIOF_FILE"; \
> > -               echo "[INFO] Running BSP generator..."; \
> > -               python3 $(srctree)/tools/cv_bsp_generator/cv_bsp_genera=
tor.py -i "$$HANDOFF_PATH" -o "$$BOARD_DIR/qts" || echo "[WARN] BSP generat=
or failed, continuing..."; \
> > -               echo "[DONE] SoCFPGA QTS handoff conversion complete."
> > +               echo "[INFO] Try BSP generator..."; \
> > +               TEMP_DIR=3D$$(mktemp -dp "$$BOARD_DIR/"); \
> > +               trap 'rm -rf "$$TEMP_DIR"' EXIT; \
> > +               if python3 $(srctree)/tools/cv_bsp_generator/cv_bsp_gen=
erator.py -i "$$HANDOFF_PATH" -o "$$TEMP_DIR"; then \
> > +                       if [ "$${HANDOFF_KEEP:-0}" !=3D "0" ]; then \
> > +                               echo "[INFO] Preserving old BSP files..=
."; \
> > +                               TIMESTAMP=3D$$(date +%Y%m%d_%H%M%S); \
> > +                               for f in "$$BOARD_DIR"/qts/*.h; do \
> > +                                       [ -e "$$f" ] || continue; \
> > +                                       echo "[INFO] $$f -> $${f%.h}.h.=
handoff_backup.$$TIMESTAMP"; \
> > +                                       mv "$$f" "$${f%.h}.h.handoff_ba=
ckup.$$TIMESTAMP"; \
> > +                               done; \
> > +                       else \
> > +                               echo "[INFO] Clean old BSP files..."; \
> > +                               if ls "$$BOARD_DIR/qts"/*.h >/dev/null =
2>&1; then \
> > +                                       rm "$$BOARD_DIR/qts"/*.h; \
> > +                                       echo "[INFO] Removed old BSP fi=
les..."; \
> > +                               fi; \
> > +                       fi; \
> > +                       mv "$$TEMP_DIR"/*.h "$$BOARD_DIR"/qts; \
> > +                       echo "[INFO] SoCFPGA QTS handoff conversion com=
plete."; \
> > +               else \
> > +                       echo "[WARN] BSP generator failed!"; \
> > +               fi;
> > --
> > 2.34.1
>
>
> You can add Simon and my review tag to a new version.
>
> I=E2=80=99m fine to proceed with v5 as posted. If you prefer a different
> implementation,
>
> feel free to propose it in a follow=E2=80=91up patch and we can review it=
 there.

Hi T.F.,

I committed a new v6 patch just to replace the corrupted " symbol.

The version control placing v5 with v5 is not allowed so v6 is used.
While the change log kept v4->v5 because code changes are not
done under v6.
So v6 is a git commit text fix only.

Thanks,
Brian

>
>
> Best regards,
>
> Tien Fong
>
