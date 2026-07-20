Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFD4C44520
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:17:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8EEA840737;
	Mon, 20 Jul 2026 18:17:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IGXiYNxsz5vF; Mon, 20 Jul 2026 18:17:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 916B44072B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784571436;
	bh=Qj0oL1CeXTpVer4whbAlj18kQ6aAJKgUlSGV0W74olk=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=JjbV8eOgX/DtRn7f+sRnGhNFPXOq+Z+a5aBNm5xm4OjLvUKCmYaa2+fcwZN14CRtW
	 5HeBZXN9Uoo/p7ahS6rysfqUOmtIq+tng/1piM+YE6/8VcBoSCaN+Zl5mgqrA1neQt
	 pT8tWJKsqa/FBlTh1a6PUDjNaVqtGE19tOX9UDj1Mo1NsLBNnxyrHOe97LvrdO89XT
	 yshUyry1yB4qhGIvHwsZE9RjhhXWXaYzu6Xav7MB/abI+hqveicxfYZBxPgFjkQ1GC
	 lw5DSTBx9FrbJ1PddA+/yK5ae1gYODXG5jvNklleYEGV72rXMOczXOtO/JxiRWY99Y
	 1gjEuJqTGWpRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 916B44072B;
	Mon, 20 Jul 2026 18:17:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C254E42A
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:17:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B3EA780AC7
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:17:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LXP4mTGWZsZo for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 18:17:13 +0000 (UTC)
Received-SPF: Neutral (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 722F080AAB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 722F080AAB
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 722F080AAB
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:17:13 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5280844F6; Mon, 20 Jul 2026 20:17:11 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A75AF80433
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 20:17:09 +0200 (CEST)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-697bd21fdc2so9505133a12.1
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 11:17:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784571429; cv=none;
 d=google.com; s=arc-20260327;
 b=bw0nbl7WCnPQkLM/qC479JFoWC3J2NwgBSqKorGJruqwZanEHtCLO13DvYI8y34EQe
 PK0sFTaq96hwZ0TnPfONw3Uoz3dhZ13E82MPfVluEMqRYEvQsJFcMhu7GLB94y6sCZnT
 uUDVmnsh+F62BXlEj1GNk5Z4mQt2oVhsAWBW2fhOvWt8TT/q9j+QvrLuv11w+C8HKF3z
 zxOaUt7v7IOCMR6XTFsK0oXFwDlrLsPlkj7gzMse0fFYjdG+QsDhwXGRIWrdX06Kw2tE
 zRq/rdfVCFXQmhEOhTriF1lXqtvCtVuVl93v4RYZGntYU/5HYJ/SauqLYpY+K24VEkwp
 YpUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Qj0oL1CeXTpVer4whbAlj18kQ6aAJKgUlSGV0W74olk=;
 fh=HGFxqjW7EmEVgkuAAKalGIiLGTacmvL3ctiAmCo/d5o=;
 b=Yj806HGSzx13JnFh9oaeIMXVqKEhK0RhOYSv2Lb3dSJXY54i/1VJmEuHfuR3idL5up
 mLc2zInIntgpzQNjdoVRXCio9LdtH7so0kw0CXuT6v8Tfbz5nM8g97wOcRljfuJLXYGL
 V5GwM9VeTM6x9T//wDIdC7mialZTY/UUkjAYFQoaTXdKq7LYqTspCj3T7tcuJzzIQzXZ
 syYRp6KkKEF9WK6FwNV0M9Ea2U22mQzjQmCtGjIO0BldBucK4oug7Y9dhH9ciHz/hRen
 xzXHnSW1+Da4cgYwzTjfdP5O+9fLPhoE4ejHHxc76wamchfqwa9ZV4CkIsAKJ+T4Syq1
 6ekg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784571429; x=1785176229;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Qj0oL1CeXTpVer4whbAlj18kQ6aAJKgUlSGV0W74olk=;
 b=lFjL7vK6Ns7mrvQ1faa+K0atzR5bJkCgE3rijM8lyc2qOy2qrjZztRAetHL4yRple6
 RdM66gAgwwpiZ95PjbyifRW+WasRQHf9Tf1kqJwamagJpN+LcmAdXGhmRq8zJEZdczzf
 DWMu+xP3IJPeHNKcy4doSaTs+IbD32PVWGklzZCiDP40pd643guPeIP8NMZ/YGCE6o5G
 2DZ5XI4GE5Mb5IMzLqJnRhbZMX5mfF/VeVdI6WGErNzCbnM5o+GzXQXmoI0EsI2uGv9O
 2IXieVqqvI27swhFnSHBxxYCREqt81n4NYgY1/ZPWlSeoRJNl5j2I0UaTvMTuSTOT+vs
 /EfA==
X-Gm-Message-State: AOJu0YyE+wUDL1wvisDNl8ZPcqPO4xaX0hL5JMiIKs7qobkk87j3E4Nr
 B39MC8LTKHBMmGwdWz3gRSGeg7eJjqHJeIEz3RCQbDCO2gymRQoJsd0jljDYH1kR/CyL3XD3xcw
 WDPSSCiHzQXQ58fNDLpMzi29CeltMaLMFV3P66kU3
X-Gm-Gg: AR+sD10SeE/xS7SOG2KBYmMjHJcdFsBu64LfAjeKeuEOK8MOeqc2IvTTL1yHiPp2jnW
 B8eWU94dLbfdSHhCkbeg3WNr1EdqrQ5i1lSvv+8IXMsw8MhyGWk0m9ffSnQA/kqMtas59xfRros
 9Z4M5thtTDrsXvTzTJ/dNLrLSlVzqEV36OeHaBSLM7dgvesILpr2DZO0ukAO01my1nt4EZZlJ0M
 hbbzgNuioeH4+KzOWzDx+WX91SE2Krmu0bxN0SU3qM5cbtq59zmfLBv2l9m
X-Received: by 2002:a05:6402:2394:b0:69e:95c9:14c1 with SMTP id
 4fb4d7f45d1cf-69e95c9180cmr2256224a12.17.1784571429149; Mon, 20 Jul 2026
 11:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260719-aspeed_vbios_fixes-v1-0-c94026f28250@oss.tenstorrent.com>
 <20260719-aspeed_vbios_fixes-v1-5-c94026f28250@oss.tenstorrent.com>
In-Reply-To: <20260719-aspeed_vbios_fixes-v1-5-c94026f28250@oss.tenstorrent.com>
Date: Mon, 20 Jul 2026 12:16:29 -0600
X-Gm-Features: AUfX_mwywhvEvlzHpwq-L19uX0f_DfXPxGIBZu_qGzGgtT95s4-DSHjYAwqP528
Message-ID: <CAFLszTg5Q0cjN2G7GhOg8SVoOim1D6ZF79-Rksqdrnr1FjvPww@mail.gmail.com>
Subject: Re: [PATCH 5/8] bios_emulator: extend VGA I/O ports to include ports
 0x3B4-0x3DA
To: asrinivasan@oss.tenstorrent.com
Cc: u-boot@lists.denx.de, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Rasmus Villemoes <ravi@prevas.dk>,
 Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, Yao Zi <me@ziyao.cc>, 
 Conor Dooley <conor.dooley@microchip.com>,
 Martin Herren <sputnik@on-the-web.ch>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784571429; x=1785176229; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Qj0oL1CeXTpVer4whbAlj18kQ6aAJKgUlSGV0W74olk=;
 b=VWAQVlEDdbBPq0Q4drg5QQe2U6HH2k61Ys7PgITJE+eGKbu2AY9x31RBV8ftWenNOT
 rbLBVn9skgXGbgb+Ic51YdYjlMkH7t8b/DymBEixYRYupoZ0awqupTYTTH+WKs3oy+FM
 CmtVut6x19jyHkWMf3yKOtqjfPtxCdZL9jf8g=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=VWAQVlED
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sjg@chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="VWAQVlED";
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Simon Glass via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Simon Glass <sjg@chromium.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Anirudh,

On 2026-07-19T18:03:31, Anirudh Srinivasan
<asrinivasan@oss.tenstorrent.com> wrote:
> bios_emulator: extend VGA I/O ports to include ports 0x3B4-0x3DA
>
> The IS_VGA_PORT macro currently doesn't cover the 0x3B4, 0x3B5 and 0x3BA
> I/O ports. Reads/writes to this currently fall through to LOG_inpb/outb
> which are unimplemented on non x86 architectures (which don't support
> I/O ports).
>
> Add these ports to the IS_VGA_PORT macro, and implement reads/writes to
> these ports. 0x3B4 and 0x3B5 are mirrors of 0x3D4 and 0x3D5 that are
> used in monochrome mode (bit 0 of 0x3C2 is not set). Implement these
> with the same logic and env state as 0x3D4/0x3D5, but with the bit check
> condition for 0x3C2 flipped. 0x3BA is a mirror of 0x3DA, so the
> implementation for this falls back to the same logic as 0x3DA.
>
> The Aspeed AST2600's VBIOS uses these I/O ports, and these changes are
> needed for it's VBIOS to run.
>
> Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
>
> drivers/bios_emulator/besys.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)

> diff --git a/drivers/bios_emulator/besys.c b/drivers/bios_emulator/besys.c
> @@ -249,7 +249,7 @@ void X86API BE_wrl(u32 addr, u32 val)
>  #define IS_TIMER_PORT(port) (0x40 <= port && port <= 0x43)
>  #define IS_CMOS_PORT(port)  (0x70 <= port && port <= 0x71)
>  /*#define IS_VGA_PORT(port)   (_BE_env.emulateVGA && 0x3C0 <= port && port <= 0x3DA)*/
> -#define IS_VGA_PORT(port)   (0x3C0 <= port && port <= 0x3DA)
> +#define IS_VGA_PORT(port)   (0x3B4 <= port && port <= 0x3DA)

This also swallows 0x3b6..0x3b9 and 0x3bb..0x3bf, which are not VGA
ports (0x3bc-0x3bf is the LPT1 range on legacy PCs). Any access to
those from the VBIOS will silently return 0xff from VGA_inpb() rather
than falling through to the real inpb/outb path. Probably harmless
here, but please mention it in the commit message. Also update or
remove the stale commented-out line just above.

> diff --git a/drivers/bios_emulator/besys.c b/drivers/bios_emulator/besys.c
> @@ -270,6 +270,18 @@ static u8 VGA_inpb (const int port)
> +     /*
> +      * 3B4 and 3B5 are mirrors of 3D4 and 3D5 that are used in
> +      * monochrome mode (i.e bit 0 of 3C2 is not set)
> +      */
> +     case 0x3B4:
> +             if (!(_BE_env.emu3C2 & 0x1))
> +                     return _BE_env.emu3D4;
> +             break;
> +     case 0x3B5:
> +             if (!(_BE_env.emu3C2 & 0x1) && (_BE_env.emu3D4 < CRT_C))
> +                     return _BE_env.emu3D5[_BE_env.emu3D4];
> +             break;

Please use 'i.e.' with a trailing period and a comma after it. Also,
the outpb() side adds 0x3b4/0x3b5 but not 0x3ba - consistent with the
existing code (no 0x3da write handler), so no change needed, but
please call this out in the commit message.

Regards,
Simon
