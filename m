Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38360CD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 12:56:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C84978465D;
	Fri, 15 May 2026 14:56:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iq65UuNk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B27984683; Fri, 15 May 2026 14:56:16 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 204158464D
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 14:56:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-bcda7765d64so161256666b.1
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 05:56:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778849773; cv=none;
 d=google.com; s=arc-20240605;
 b=O3k1m1YXRqiMziRy8llOLVZkncqiLQJmBAK3Vz88XoKN3Jz9ay+HQytrw089rPdj8T
 Jn0eOxTLt1NOhloP1EzIS0fjiJ/k4/OejsOTV8XuTY42LJT0ZSa5NHsQBCf6MEQn3Pdf
 ry3B7Yo8xcCaibOOPa4nCKKL1MiYB0tV4nXBGPyqSwcKB5QIjVcNljRGseFQEwQ/bDW0
 Vqt7WhwwPFa6ppmFzhnG7pxK6AJIbRJJi6DiKVcTyD+pKYvKgdEwlBaQ/lJTk+Zl+l3F
 bLRnmiLqxFoOPiVj9ZaXxBJq30BhedKIT7iQj9G1ylIILgGWPytosdpqqo+5I7KJ0RFA
 kFbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9roG3peWzpDmDx583gN2fczOIXNg1GMqnT2JyCi7Lms=;
 fh=fJAGB8LvxCJalDRE+ziaXIW21+gD5jSCb0B1QEwHsvE=;
 b=SRmKUp1yOLsZCgncuLM65ocDlHTi2q/lGDWpwKAn6l0Mm07RhHmyl9fnKZDQ45CXtB
 zlocwa1YRjvqZMhuGul8TyA8QeIahDm01xSzQct8UuCVeQ5vSDdb88cKqe4Rf10/TUVZ
 cFLwx0ctvU+y+6C73NSToaaHrC2FaYY831OGM5dErGFinP7N5yl54sxnb6vSH4S11eVR
 aa0MBTwipKnhpfMTF54/XmpqoJblWhlHWyYge4gB5L+XIDr2f0BV4GlG7Qm5SLZNjcbT
 eZghuRGwwcj4gXx7cDi2M3+mjm0ips9abBPodg+s9Bp1Xyo7bZX91kB1ikh9vO9wzvHh
 WbcQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778849773; x=1779454573; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9roG3peWzpDmDx583gN2fczOIXNg1GMqnT2JyCi7Lms=;
 b=iq65UuNkAkgURB2csIVRT1QaOXF3bAz0nWM/1+iH8wuLUVTbwmsXciXbiKEuehyHnM
 eraDNgOEo/+f1IYr5ZdJryH29w64I9gqH3+vlU2wL0TLFfEPpkq+nue0mmxmMHugC7ex
 +uMujnLHruUArsew6C8pWS4K3P7x5uOqfXZPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778849773; x=1779454573;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9roG3peWzpDmDx583gN2fczOIXNg1GMqnT2JyCi7Lms=;
 b=XL+HhofDN/uQaJP4/uoL9sOQGP2yeudJuXb1F2svRybU1whGvff5FkMeu8abeXAEuz
 is7fpq6lWAVwd37X/kg+YhAJ9PDbo0CpRpAKiclIWtr8GGFxwj+8kS0u7hfDGBOi6IF/
 a3V3WLdX52ExEeJhTsh7jMyZkM2h+9dByTisEZcgGOwTJh1K6fK1Z2lzmDs//quhY0C5
 Ipt3eRsiT39esdblrJzFVPCy3TW4ZhkqJvA7u7cxpuENp/krOhc1frS7IqpOUv8ljNzD
 nholk4a1bciM99uZBEEmQaKt4gCSkPfYhQg0V5Cws2rHqcBeTr4QG6DuxQSwVjudGoNz
 JCvA==
X-Gm-Message-State: AOJu0YzdHf6RH+iiVFDcXix8IvcdOJ1A806s+Vl4M3EogrYikmfZVKO4
 Ctt+59mcKeaunMICHSjQg8/DOvQQi8sCRIWRGXJnl7sPznWiE+liHJh8DH4uYSd89bF7Gl2V3d2
 r2cbRU6OC77ET02ERLWMl8eqi2RGcx1E5frvOTprnc4gA8GrllrGuTw==
X-Gm-Gg: Acq92OGgiMfWY5ex3kHwPiwsEyzN+okCvrwDL7WQMdRQyBjwe5r/j/pJ7KEQYjAxvev
 awKVROf/IKcwFjcpx87kcRtCdCqHi9wgFmK3NPSKqMe6FmuxULAZfWRbtkHDS11lvNZv1pVMsea
 52xKvsNtfM+DP/bap2XMxB/GcJ15TGzpkSpxOG/t12r6q5GaIru0r7V8pUySEBLm42kEiPxvgdQ
 YJciCuoKAekoDRkbMu6b7F2tuRpno2cr4WGopfXf54d7Rsh+NNF5lS18KWvMSic+V3ZL26d9SMh
 UYCc4Q==
X-Received: by 2002:a17:907:2d92:b0:bd2:44de:d698 with SMTP id
 a640c23a62f3a-bd4f346141dmr484801766b.17.1778849773472; Fri, 15 May 2026
 05:56:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1778657347.git.weijie.gao@mediatek.com>
 <8a1af52cc1bccfc0e98255118da9b2df0b420a9f.1778657347.git.weijie.gao@mediatek.com>
In-Reply-To: <8a1af52cc1bccfc0e98255118da9b2df0b420a9f.1778657347.git.weijie.gao@mediatek.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 06:56:01 -0600
X-Gm-Features: AVHnY4JrCvbYK3hrVTjC0DhUE8-Y5uWHVZpw5E7ACNeaGOxUGknvk2XtT6y20Cg
Message-ID: <CAFLszTjNQr71HkgTFf6vtc7z7VnUt-EtCx2OCgCvC=aG4mPSMg@mail.gmail.com>
Subject: Re: [PATCH v4 06/10] cmd: ubi: change all positive error return value
 to negative
To: weijie.gao@mediatek.com
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

Hi Weijie,

On 2026-05-13T08:02:45, Weijie Gao <weijie.gao@mediatek.com> wrote:
> cmd: ubi: change all positive error return value to negative
>
> Change all return value using errno codes to negative. This makes it
> consistent with the linux ubi layer.
>
> Also, to follow the standard definition of U-Boot command, in the do_ubi()
> command handler, the return value is converted to CMD_RET_FAILURE for error
> returning, and CMD_RET_USAGE for incorrect usage.
>
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
>
> cmd/ubi.c | 106 ++++++++++++++++++++++++++++++++++++--------------------------
>  1 file changed, 62 insertions(+), 44 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/cmd/ubi.c b/cmd/ubi.c
> @@ -761,7 +762,7 @@ static int do_ubi(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>                       return ubi_check(argv[2]);
>
>               printf("Error, no volume name passed\n");
> -             return 1;
> +             return CMD_RET_FAILURE;

A missing argument is a usage error, not a runtime failure. Please use
CMD_RET_USAGE here, and likewise for the 'Incorrect type' and 'no
volume name passed' paths in the create handler, so the user sees the
help text.

> diff --git a/cmd/ubi.c b/cmd/ubi.c
> @@ -677,7 +674,7 @@ int ubi_part(const char *part_name, const char *vid_header_offset)
>       mtd = get_mtd_device_nm(part_name);
>       if (IS_ERR(mtd)) {
>               printf("Partition %s not found!\n", part_name);
> -             return 1;
> +             return PTR_ERR(mtd);
>       }

PTR_ERR() returns long but ubi_part() returns int. Please cast, or
just return a specific errno like -ENODEV

> diff --git a/cmd/ubi.c b/cmd/ubi.c
> @@ -806,34 +807,46 @@ static int do_ubi(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>               }
>               /* E.g., create volume */
>               if (argc == 3) {
> -                     return ubi_create_vol(argv[2], size, dynamic, id,
> -                                           skipcheck);
> +                     ret = ubi_create_vol(argv[2], size, dynamic, id,
> +                                          skipcheck);
> +                     if (ret)
> +                             return CMD_RET_FAILURE;
> +                     return 0;
>               }

This three-line conversion is repeated about seven times in do_ubi().
Since the called functions already print their own errors, a helper or
just 'return ret ? CMD_RET_FAILURE : 0;' would cut the duplication.
What do you think?

Regards,
Simon
