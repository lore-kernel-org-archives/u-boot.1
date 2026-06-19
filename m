Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A797CCD98F2
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 16:32:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66200849EE;
	Fri, 19 Jun 2026 18:31:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MFmNI/mA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 074CF849EE; Fri, 19 Jun 2026 14:13:08 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36D51849E4
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 14:13:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-687ed9aabb3so3625772a12.1
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 05:13:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781871184; cv=none;
 d=google.com; s=arc-20240605;
 b=Coxxw+hVRwvtpf1wn0ipRDrsQz9sB4rDLmBhVV6562gRveZALBVgVUoUqGEyqz4+TI
 ZaB7ySyDT5BXd1bv3ZNMfo0BmyoCpkkze1YMgLJYeUi95I/pkBpmumwZ3LLMd59d40+y
 JSV1ha4jAVRS31nLkNYHvLVb1l0Rdk/MRtLCE44ulEidEInl12v9rUn5Kur7Thxhuz4/
 2fig0fbRAXSdUpCgfUHDAhqvJ3AOYLAHV5OUpiXibGoMlY7z4w44Y7w/LwuX+USAvqVD
 UdX8szXsoqrBWr4Rk1D49ajsEhx0eqxe4SVStmMXX2T5mMLacHRkN+X2oyDLqzZx1wME
 oNtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1PGiYonDpp1j3UE3mcz1qA0zs801oVw02qiXwx1WIqY=;
 fh=6BofvcUmIiQeHzHIX2MbnlBB2XYmbzLlXbfWHMVTWAg=;
 b=iz7fpm1hOFPuY2f+rE/rOdbVy42czVI1RD/4od0tVbTK2tkFlHU2CFS0YBnptJ9WOR
 pCe5W0442Rcef7TFPwJ7gX5hlnILw1y6oue/lYs3K2DgKoP1qyj83MyM5d+eQy9TswE3
 maSdFC7VfJekaptE2p1Cl3B7gKEwheG4pJDjcL2knhEGVU+JGUepY2D27fpAD52EXmrP
 vaKKX5QdAVyNtvmj8jMJ0q3Su7I4+5stqi1PntsNZ4hEvLkkEo3NLMJUACrD1ahdn8VV
 kf2Eb/lm/dYGoybwfAueNbOImc7pwL7t6hOTisd0CKnoenF8IwHBUHdP9P3vfj7W7ayR
 oxRw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781871184; x=1782475984; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1PGiYonDpp1j3UE3mcz1qA0zs801oVw02qiXwx1WIqY=;
 b=MFmNI/mA1gv6BfDtRtnZaFtVLUfxC3QGlpNjgkUNBzHG4T8bgVt8PmA43O28yttu8/
 BrzwsmxZlYXW+TJE62H2/GtWROfquk/MNbfgdCddJZa0qV4yfMXiJnRtsFJ3MdegSUER
 F5+gqxg3yPCPede/GyZVPpqiFuGwm7M714/D4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781871184; x=1782475984;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1PGiYonDpp1j3UE3mcz1qA0zs801oVw02qiXwx1WIqY=;
 b=ic/+kW5CtbgVE+OAcMEhvILOwQAkeOLxCSy60DKrtDoCC4iSq4B3BkNEyJWhRMWTcU
 S9QfyLrxlmGSVg8AvbG5M7jAt+xwTlqzfKcrdR71N82DHM9OncVqOOh/GXAwdhPbByT+
 SFcYOMmR/33JuNTZTha2wR0Z3YXw4ypoQ9jb4/FMSOl341zwTDnt4VlTCqJ5YWpweIsg
 bRatoG4omB0Grs77P80naHt0UaOk5YbHmr2OnRjUz1OyvE8UJg4FAM6pJhZzx87OURJK
 IUvNl+KCOH5aTTDpW2XQRRE86w7/I4u7aNFRk9MRR8TCMNui+Q49ENbpAf+/egIzOxXo
 jXnw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Qt8WDRysGaJNUgN4/Hewg8tWb8s57NTAqYlyMj5Ica5tVea/EMC5SIIV7jnrkX6pxWLObmiA=@lists.denx.de
X-Gm-Message-State: AOJu0Yzlzsk9pY5KIJU/5MJ7sQ4Xt5I7Qw0sFQtIuul2DNaiBSapxwzv
 Gs58tiN6Bx4+gAxc8bFlvbgQeOyaOIuoiE5zbZoCKAJ45y+FXXIJiGQfwsISBRsG5gQz7Q1zdL6
 4HHm47w4PGXEPrOC0vTzHj7FAbqHR717fIdxKFVNI
X-Gm-Gg: AfdE7cndTqDXoyJfBVcSqp41oY3qyuEf5jp/8YVc0qbM9O59ZSv4W29iDLpHeHAFw7p
 AstJsjjOsxNW/fh1SwTeW12BkVgKy8Owrivpqf9oOzjre7a4GDoBtYYkbQSJqR6HQBZZ5wCcd+G
 hybdOnBvKeKP8onUkQX0YjnZtDsnapp5PevAwjWKtpsRXJI0mICFeTzCBXWBe943okL6thEm5pa
 vlrpAdIyRt4XOZDNMH2HhXxzpzuNcMaFxVMvFQBvEybhWvbsDJyluLn1/0tm15bpYe/JobBDg==
X-Received: by 2002:a05:6402:c44:b0:695:4649:ca62 with SMTP id
 4fb4d7f45d1cf-696e521d8a6mr1612071a12.21.1781871183531; Fri, 19 Jun 2026
 05:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260617101812.299586-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260617101812.299586-2-varadarajan.narayanan@oss.qualcomm.com>
In-Reply-To: <20260617101812.299586-2-varadarajan.narayanan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 19 Jun 2026 13:12:51 +0100
X-Gm-Features: AVVi8Cf_UP2Si1QDlf79IvJHv18X_r77DoeNPvEzM9SzoXLEf9A54g4O8cxaYHw
Message-ID: <CAFLszTgkDHA+c4ayPo4kcAxanPsOWU3x7jDU1H6HEQpd9doNrQ@mail.gmail.com>
Subject: Re: [PATCH v5 01/13] binman: Ignore noload segments for image
 numbering
To: varadarajan.narayanan@oss.qualcomm.com
Cc: rayagonda.kokatanur@broadcom.com, trini@konsulko.com, 
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 peng.fan@nxp.com, jh80.chung@samsung.com, lukma@denx.de, sjg@chromium.org, 
 alpernebiyasak@gmail.com, tien.fong.chee@altera.com, anshuld@ti.com, 
 alif.zakuan.yuslaimi@altera.com, tingting.meng@altera.com, 
 marek.vasut+renesas@mailbox.org, alice.guo@nxp.com, quentin.schulz@cherry.de, 
 ilias.apalodimas@linaro.org, mkorpershoek@kernel.org, andre.przywara@arm.com, 
 afd@ti.com, h-salunke@ti.com, alchark@gmail.com, dinesh.maniyam@altera.com, 
 luca.weiss@fairphone.com, adrian@mainlining.org, danila@jiaxyga.com, 
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com, 
 ycliang@andestech.com, mateuslima.ti@gmail.com, jamie.gibbons@microchip.com, 
 n-francis@ti.com, david.wronek@mainlining.org, james.hilliard1@gmail.com, 
 bdklingerman@gmail.com, richard.genoud@bootlin.com, sughosh.ganu@arm.com, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 19 Jun 2026 18:31:25 +0200
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

Hi Varadarajan,

On 2026-06-17T10:17:59, Varadarajan Narayanan
<varadarajan.narayanan@oss.qualcomm.com> wrote:
> binman: Ignore noload segments for image numbering
>
> While including the partial images of a split-elf, binman gives the
> segment number as found in the input ELF. However this results in 'gaps'
> if the NOLOAD segments appear in between LOAD segments. Hence track the
> LOAD segments separately and number the partial images accordingly.
>
> Update the read segments test to verify this.
>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.=
com>
>
> tools/binman/elf.py      | 4 +++-
>  tools/binman/elf_test.py | 4 ++++
>  2 files changed, 7 insertions(+), 1 deletion(-)

> diff --git a/tools/binman/elf_test.py b/tools/binman/elf_test.py
> @@ -288,6 +288,10 @@ class TestElf(unittest.TestCase):
>              self.skipTest('Python elftools not available')
>          fname =3D self.ElfTestFile('embed_data')
>          segments, entry =3D elf.read_loadable_segments(tools.read_file(f=
name))
> +        n =3D 0
> +        for (i, start, data) in segments:
> +            self.assertEqual(i, n)
> +            n =3D n + 1

This doesn't exercise the change. The embed_data ELF has a single
PT_LOAD segment (see test/embed_data.lds), so the old code already
returns 0, 1, 2, ... =E2=80=94 the loop index i and the LOAD count coincide=
.
To regression-test the fix you need an ELF with a non-PT_LOAD program
header between two PT_LOAD ones, so the old code produces a gap and
the new code does not. Please add a fixture (or extend embed_data.lds
with a NOTE/NOLOAD segment) that demonstrates the previous behaviour
was wrong.

> diff --git a/tools/binman/elf.py b/tools/binman/elf.py
> @@ -551,6 +551,7 @@ def read_loadable_segments(data):
>              raise ValueError(err)
>          entry =3D elf.header['e_entry']
>          segments =3D []
> +        n =3D 0
>          for i in range(elf.num_segments()):
>              segment =3D elf.get_segment(i)
>              if segment['p_type'] !=3D 'PT_LOAD' or not segment['p_memsz'=
]:
> @@ -558,7 +559,8 @@ def read_loadable_segments(data):
>                  continue
>              start =3D segment['p_offset']
>              rend =3D start + segment['p_filesz']
> -            segments.append((i, segment['p_paddr'], data[start:rend]))
> +            segments.append((n, segment['p_paddr'], data[start:rend]))
> +            n =3D n + 1

The docstring (lines 534-540) describes the first tuple element as
'Segment number (0 =3D first)', which is ambiguous on whether gaps are
allowed. Please update it to make clear this is the index into the
returned LOAD segments, not the program-header index. Also,
enumerate() over the filtered iteration would read more naturally;
drop n and use enumerate at the append point. Minor: n +=3D 1 is the
usual style.

I also suggest a sentence in the commit message noting this is a
behaviour change for split-elf FIT nodes (SEQ substitution now
produces contiguous numbers when NOLOAD segments are present).

Regards,
Simon
