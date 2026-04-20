Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222B3F5A8C9
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 22:45:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0629842B7;
	Tue, 21 Apr 2026 00:45:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HiMfBQ9N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91CB4842CD; Tue, 21 Apr 2026 00:45:04 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B203A842B7
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 00:45:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7dcd689829eso284517a34.3
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 15:45:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776725100; cv=none;
 d=google.com; s=arc-20240605;
 b=TyerrUmmcyAXmuyqqCx03mGoEqHOnJSULuNgmeDmb9WkpRMPNzDZffvsoPrYwqlE8s
 ZBUNuKsfEIA+1S/Hwm8rxLbKyxjCkyLlyhzs+28jObk+a8pkZnik569m6JdWYrsBpsm2
 +YZGtRwrQwRL0JENWlYtiZSGl4Kfrzsw3YWWAibcH5DeQJ4t71XuzCxio6E55IYLN0xg
 2NET0LXD9KtNc7XP4BILCw3qCCRLU3UV4ecJnidK8Dk1kSDiqWZUzZlPeqmu+Vkxs6ss
 SuguvopLL9HuL45wfQjrTO/A2SdFXWzb8y2qR0Ptgea3MkJenguTPSwx+0bXcV+NR0lq
 070w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pF2Ti9RMLGgaAQJvOA0j9LgZ32pPSYhyzyY8eMXxhm8=;
 fh=9r7S9p3VRn7IEaRdmSc0Ybs7HmGN7dtMxEobdXEs+bg=;
 b=EN0vCNAxwnxCTf8GGqBXDhdjW4XlVYW5nCzVPT0KE58Ngys2WmSoY0gz/6ONymlPkY
 jPGPgKMm9UIMh/KYcmgQ96L+04s6Enaul/f3AYQvavoW+v8NOlHzQCKhnV+Abs3nipE2
 rsEK5tUSl6swOZqt8D8su+CcSsY8G+t3u3cPCjWeeKzyZ4vRjdRZFTznP0kbvX0jmyAf
 SukCTJwNpxNu4xu0cuoIeaGYx01gKejzjVK0Z5njFhPljhZcwgO/VpaETWJnoKVeRXhH
 WOlaOirkKB/3VQGAM947XL3aq/Vq4qJuRfVyxk5pLHhaZM1a04AJB9SIzB6EolYzlgTH
 Vcbg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776725100; x=1777329900; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pF2Ti9RMLGgaAQJvOA0j9LgZ32pPSYhyzyY8eMXxhm8=;
 b=HiMfBQ9N8+tNueRwNQm/t2ZpCcFC1/dvUTJYK1mn5i66xSL1JP4KPfGLbe7SUz63D5
 3paKLCRHpz3xiyiOuRN8kVM1kGGqBawUih53AfWuhfsbR2W6w9lzz4ArmDpDfuttYd4G
 d1d/pWVv6TTMmqJ9DHWFpW24Sp1Z2RXYY/W0uA5yv3wAJO95+0LA8RsSfJWKpaQqc2M6
 Vjpvqxpod8ujao+IG0VPZA0WJnFIBi3WzqeFiVf0zld+BW42NonmvzLNJJ5q4dKBrw+z
 BQdpLU/iO7tvRVGTQpExbtXEhTcQctyQdSded2KsWujsFi53pIlYOp/D/kiEvouiH0KH
 YJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776725100; x=1777329900;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pF2Ti9RMLGgaAQJvOA0j9LgZ32pPSYhyzyY8eMXxhm8=;
 b=Dosxc1tNkL2j3ihYz72E/8sZh9TPRKtb4+BrVcuxw7ow/mLtY+9IRTJGxZEsZs7E73
 GhKhFtVVW4GzxxtZeLP48HpF/K0ldjF0+KvAB5vchbG06CCznEQM+oSKHtwEzcdrtAFr
 aMbULigN2IJuTU5fe0aPGoxmMO70xGLd5AJLDKUTPhRYecqFnXn9b1rsr7yY0Vd1Sd9i
 BNa6UHGsfWVAboh0peKeH5MWeN5vO/cfwq8yd+LMasUFDFP1D2dH8BI8pZeYl96FkFvQ
 QjAXEK98qguCDe8tDRmIX03YBuP9cqN69W7wWOIsb6lsvpfIHgcuOnZFLssmn4NbD9AL
 baUw==
X-Gm-Message-State: AOJu0YxwR3qUvSqYuzpri8J3MBRrUoWgzk1nNwYcpAmWTLaqMm+30pw9
 H9zypwfiv6J/QPvqAwXgOoTjjJF9J+o9UAlzRYvRkO0ecnCTB7R4/xZWpOdKzap2Pb3JXtjeI7i
 6bDHr9b7iBM5CIRdlWBdaiJt2B6sL+yb/B+kocBY=
X-Gm-Gg: AeBDieuLJeTYF+dTu4nM+wYjnUrJ4EmAw8zWqKiS+48sWeFwirOK0YyFOzjyp1NlKq6
 5bf9Qht+Gw5fWwVvGy+oBHTGKlYdzAbjnqNzngrCew9kItvdbL0Uv864HdkpcdyaSqkToTKCp++
 2/3MFQM4QjKSrSExbEmtQKtuIeNmLK7vFWckMyUNcSTgK6m42EFfrGu1sNsol6bwvcsiQwBjir1
 bCCaOrN/DvpPx8VFu5yt7EhSI/NBS85K4WMK/S+zg8qYyoBBAXEkMtrIbLZbHbjYqS5ox/nqywh
 ZqfhGx+FwwK+aZzKYw==
X-Received: by 2002:a05:6830:82a4:b0:7d7:d504:cc6d with SMTP id
 46e09a7af769-7dc9521cf45mr10557903a34.21.1776725100355; Mon, 20 Apr 2026
 15:45:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260420074601.24988-1-briansune@gmail.com>
 <CAFLszThRNhVTMRpVPySFSComEhL_s0a1wY1BVnKKtV+K6OXnEQ@mail.gmail.com>
In-Reply-To: <CAFLszThRNhVTMRpVPySFSComEhL_s0a1wY1BVnKKtV+K6OXnEQ@mail.gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 21 Apr 2026 06:44:47 +0800
X-Gm-Features: AQROBzAL3g5wsE1Hy2V8dHhT3bXpd1q6DiksfAITN85lldQVglcoBmbvdNJEr9g
Message-ID: <CAN7C2SA_kuXD8_5N38iazcRbRYzWXdp4MwMb4XE8gWggPgb-RQ@mail.gmail.com>
Subject: Re: [PATCH v3] Improve handosff prepare on SoCFPGA
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On Tue, Apr 21, 2026 at 3:32=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Brian,
>
> On 2026-04-20T07:46:01, Brian Sune <briansune@gmail.com> wrote:
> > Improve handosff prepare on SoCFPGA
> >
> > There are some cases that the Python scripts
> > are run and the qts files are not replaced.
> > Make sure qts folder h files are removed before
> > handoff script runs.
> >
> > Signed-off-by: Brian Sune <briansune@gmail.com>
> >
> > arch/arm/mach-socfpga/config.mk | 29 ++++++++++++++++++++++++++---
> >  1 file changed, 26 insertions(+), 3 deletions(-)
>
> Typo in commit message: "handosff" should be "handoff".

Got it.

>
> > diff --git a/arch/arm/mach-socfpga/config.mk b/arch/arm/mach-socfpga/co=
nfig.mk
> > @@ -8,6 +8,8 @@ else ifeq ($(CONFIG_ARCH_SOCFPGA_ARRIA5),y)
> > +HANDOFF_KEEP ?=3D 0
>
> > diff --git a/arch/arm/mach-socfpga/config.mk b/arch/arm/mach-socfpga/co=
nfig.mk
> > @@ -43,6 +45,27 @@ socfpga_g5_handoff_prepare:
> > +             if [ -n "$$HANDOFF_KEEP" ]; then \
>

Hi Simon,

Thanks for the feedback.

Before the patch was pushed I personally tested all these cases and
found no issue.
make w/o HANDOFF_KEEP=3D1 will link to clean vice versa.
You can use make HANDOFF_KEEP without =3D1 it will report
No rule to make target 'HANDOFF_KEEP'
Sorry, cannot see issue on this section.
Maybe you can try and test if it is the case.
Pure "brain processes code" sometimes is a bit tricky.

> HANDOFF_KEEP defaults to "0", so -n "0" is always true. I suspect you wan=
t:
>
>     if [ "$$HANDOFF_KEEP" !=3D "0" ]; then \
>
> Otherwise the 'preserve' path is always taken and the 'clean' path is dea=
d code.
>
> You could also have an empty variable meaning don't keep.
>
> > diff --git a/arch/arm/mach-socfpga/config.mk b/arch/arm/mach-socfpga/co=
nfig.mk
> > @@ -43,6 +45,27 @@ socfpga_g5_handoff_prepare:
> > +             trap 'rm -rf "$$TEMP_DIR"' EXIT;
>
> The trap is set after TEMP_DIR has already been used. If the python
> script or mv fails partway through, the temporary directory won't be
> cleaned up. You could move the trap to immediately after mktemp

Sorry, again during the test I did not see any issue what you described.
The temp dir cleaned up w/o any issues.
Both condition branches keep and clean.
mv or python script will not break like exit 1

QUOTE --->
[INFO] Try BSP generator...
./board/altera/cyclone5-socdk/tmp.Z11PmKjAMg
Generating file: ./board/altera/cyclone5-socdk/tmp.Z11PmKjAMg/sdram_config.=
h...
Generating file: ./board/altera/cyclone5-socdk/tmp.Z11PmKjAMg/pinmux_config=
.h...
Generating file: ./board/altera/cyclone5-socdk/tmp.Z11PmKjAMg/pll_config.h
***Error: We don't handle more than one .hiof file yet
          Only the last .hiof file in the list will be converted
          hiof files found:
              /media/sf_shared/loader/hps_isw_handoff/pcie_rp_ed_5csxfc6_hp=
s_0/pcie_rp_ed_5csxfc6_hps_0
(copy).hiof
              /media/sf_shared/loader/hps_isw_handoff/pcie_rp_ed_5csxfc6_hp=
s_0/pcie_rp_ed_5csxfc6_hps_0.hiof
Reading file: /media/sf_shared/loader/hps_isw_handoff/pcie_rp_ed_5csxfc6_hp=
s_0/pcie_rp_ed_5csxfc6_hps_0
(copy).hiof...
Generating file: ./board/altera/cyclone5-socdk/tmp.Z11PmKjAMg/iocsr_config.=
h...
Traceback (most recent call last):
  File "/home/intel/u-boot_C5PRJ/./tools/cv_bsp_generator/cv_bsp_generator.=
py",
line 100, in <module>
    iocsr =3D iocsr.IOCSRGrokker(hps.getDeviceFamily(), inputDir,
outputDir, hiof_file)
AttributeError: 'IOCSRGrokker' object has no attribute 'IOCSRGrokker'
[WARN] BSP generator failed!

ll ./board/altera/cyclone5-socdk/tmp.Z11PmKjAMg
ls: cannot access './board/altera/cyclone5-socdk/tmp.Z11PmKjAMg': No
such file or directory
<--- END QUOTE

QUOTE--->
  UPD     include/generated/timestamp_autogenerated.h
[INFO] Using manually specified handoff folder:
/media/sf_shared/loader/hps_isw_handoff/pcie_rp_ed_5csxfc6_hps_0
[INFO] Found hiof file:
/media/sf_shared/loader/hps_isw_handoff/pcie_rp_ed_5csxfc6_hps_0/pcie_rp_ed=
_5csxfc6_hps_0.hiof
[INFO] Try BSP generator...
Generating file: ./board/altera/cyclone5-socdk/tmp.TvQv88TcsZ/sdram_config.=
h...
Generating file: ./board/altera/cyclone5-socdk/tmp.TvQv88TcsZ/pinmux_config=
.h...
Generating file: ./board/altera/cyclone5-socdk/tmp.TvQv88TcsZ/pll_config.h
Reading file: /media/sf_shared/loader/hps_isw_handoff/pcie_rp_ed_5csxfc6_hp=
s_0/pcie_rp_ed_5csxfc6_hps_0.hiof...
Generating file: ./board/altera/cyclone5-socdk/tmp.TvQv88TcsZ/iocsr_config.=
h...
[INFO] Clean old BSP files...
mv: target './board/altera/cyclone5-socdk/qts' is not a directory
[INFO] SoCFPGA QTS handoff conversion complete.

ll ./board/altera/cyclone5-socdk/tmp.TvQv88TcsZ
ls: cannot access './board/altera/cyclone5-socdk/tmp.TvQv88TcsZ': No
such file or directory
<--- END QUOTE

Thanks,
Brian

>
> Regards,
> Simon
