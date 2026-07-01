Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69565C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 11:06:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBE4084B86;
	Wed,  1 Jul 2026 13:06:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mPbgXs6J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD2C984B96; Wed,  1 Jul 2026 13:06:19 +0200 (CEST)
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com
 [IPv6:2607:f8b0:4864:20::b12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B96EC84AE9
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 13:06:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-664d78637f8so619139d50.3
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 04:06:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782903975; cv=none;
 d=google.com; s=arc-20260327;
 b=VRwOOnywyHigseFzSD9eWnx9m5s/7r59HwuVr8J1CSQkh/LpzU8k3Hw/T3I68bbMLi
 D0kC3QrvUl3QmPPbhn8oq6OcAqteKWUerAEG+lne47TzMvlnjCxnv4VyXThrB3y864NT
 gzrrSUJmpzf/fIzOwQQu4rtMYEOA4sBS410lN6P0yYJ+6A/ibMzxS338Hy5JIkcsS59y
 tQgvbhUrHhUmH3HRrhVGPEp9as1dPF0UDbA/xJC/TrRdK1oGAUC/BklJy/s8mKUS+L/R
 VzDiOyJ42ZyFFmgs5vg0bilWQxK1xr+9FMhkAnoX9OW19eoKokuFKjc+Er03zy9GiVpC
 pcAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1h6qHOlIR0GRI9xV69SfzmmUSFgwGtQdTW9wX5iKFUg=;
 fh=j1tKzSCZ0ZChzaf6cThx3QTlEWoydHGdNJPRNF3nwt4=;
 b=FeZAPYv1BRuVqOpJErjSsB89GiyS+a+UdiCD0TCV+0Fg2tK9J8Nuskzm8fw4xjlB/G
 bC7lkVYjCZfkZCBVkacBiEFcrJ1QNLpKlEdLqzniMw4hL/Nos7F25CF6+aKhhgddIAf4
 y6Z+Iordstwa6F7Z2NhdSvSY5cqWzByCOTzfoEnJulqTeJTTP81oyCIjdhr4T2KSEwrS
 KC1Dm0EIHCo8Eq3eqgUBbxc4MeUybX/p66wMkVWaDcaa8W9TgBQDld81Bop0mbbJmI3i
 +4kh36v/ak2XZqIAZRuozhz0AadVdbg/h2+qVLNITZhRypQ9m3hvlgycnEarivBvy4N0
 poQQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782903975; x=1783508775; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1h6qHOlIR0GRI9xV69SfzmmUSFgwGtQdTW9wX5iKFUg=;
 b=mPbgXs6J7zrtQuBuF8rKbtL8npVsP6eo6lfWKdf53GMKSiKahuVsYP15BTJL5aq0Gt
 IzbmCKPAfNNhp/1/4eTB6CLPKZ6TUawScqTDDWBuv0WzUnoArjOIRh+ho/IQF/QEQn/u
 p22A5w2OKYyF0Bf3VEzsqVKP3t9kQDdlXaJRfpwhP5UtcBu/gdwJWHiYovGXpH8OzQB4
 qFbyIiaipXYqCTV1eIymvlg+9R/2VjiilcfTDVcmowE3/WObRtCjVL7kbrcoW56LKDw+
 w3a4s74N4KekeB64YZeDHxbl8DdWblgBwBjNZnh/RYOzglTSDp7zFci3kMyDBuVJdj4t
 8sbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782903975; x=1783508775;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1h6qHOlIR0GRI9xV69SfzmmUSFgwGtQdTW9wX5iKFUg=;
 b=edhs5TV629I4IN34CtfjYKfvb50qHTVYKNVn/nv6bP+rHOGNJrktSheSIotH6ecSgK
 Lr5MWa3Ry3R8sxfINbi2ZSv4JWIKas/U2oKpnvyTjBu2soUyqOI3dq44hM2m8jwDMdo+
 0ri8KO42cSlGIgPVdwE4T7BAJheTpwTajB3mk1GpEwEbcLTm17h7AHRvNvIXPtwdpRaz
 SICZQ+O+uXw0hOaJbTN6JhZhF9JwrEtAJQWTfHvW5HcPj7Puj731fZK/fYuZFCaos+sd
 FsMcMQVHKFT/cIoXzP3KvdO/lBXe9tcijbv65mk4qncXN7T2g8wvswWwlviOHtiTmMKc
 kq2Q==
X-Gm-Message-State: AOJu0Yx17WcJrgNs+ZLkOAjR5yGDNROIeISqCbMvl+37RltExAatDDqL
 PZZDE1o8H5OcIWTVw55TTLEFedp2RFNNSbBRPI5W5/mxzAgaKHGNnGrw2JL+/82l/Uv0hzg0hxS
 eSjUB0HjPWA3SvBp3o3aCXc2f7qOfHwEj9k4uCTayCA==
X-Gm-Gg: AfdE7cmaUmDBLwRaFv6rp0C8A9uYidU7Rf+LvQZdhVtj8N+kf4Ki4PviwCRVaQPy1fk
 bYRKHzkNGqr4q3Q6t+JK375GVOFeZL1Z1EngM2oO/1ZMSId7qe6NuFLTu97Vb7pqHhZVgdrKN/N
 Uai1fNz+svAIPZDPhnkLA82EL3IXmJjp+vNy4XGmIOWJCSIerPxwW1ODlfSs/10tIo3tdldzXMV
 C2EEkb/yRPiuvg3ybYD4KWJ6vm1rX9Q2ooPGcgeXqWZPksu+7DgLxPWHTcaTkUX9nL/UmZ3TCdS
 ksyUYFQiGezh4Ss62il2Q0kwD8I2YHacIewgtgw07Lt+Qdx8QJJDmZjfHeT8pEt43ex+w0m/mK9
 j/VsnRrwa1vK4yfGDeDBXeQJcQddDmgkmK5as7zhIALSjNW26pxvdtGhkMJC+5YSab9RAqOi8bA
 SGze2dXxDozhHPAoZSjNXM0PlcTzO7/lMIw9Og7eZUMBeMF1n929MO6Woe+bruTIVE3qkSRWu03
 hOTVocwFH2vA3Tl0twnuTaij0fiw7snCW3rjOiEO2n9ypQ1qSuhG2PVYfyOs59NZRjysijaQkg0
 0xui46ceS5m+kp6dmkiMBh0rDBALrbp/utN98mK+79opyUtw9nW/XqUpvmlsLywVrvE1fXU=
X-Received: by 2002:a05:690e:190a:b0:664:e0da:6ebc with SMTP id
 956f58d0204a3-66521ae0e0fmr1143915d50.29.1782903975468; Wed, 01 Jul 2026
 04:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260629080241.36311-1-ludwig.nussel@siemens.com>
 <20260629100104.v4.2.25391578ae16ae38c90974bea552726dbe0153aa@changeid>
In-Reply-To: <20260629100104.v4.2.25391578ae16ae38c90974bea552726dbe0153aa@changeid>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 1 Jul 2026 14:05:39 +0300
X-Gm-Features: AVVi8CdejYFDvINSEICLmRr1D0kWP26vq3sfwb25NvhLQJ5Woa7A8eaYpjYyXKE
Message-ID: <CAC_iWjJTZ6ppms0Vf3pBzoU32_-r4RDfaMgUxiAvKi6HSqZ6Mg@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] tpm: print all PCRs from pcr_read
To: Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>, Tom Rini <trini@konsulko.com>
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

On Mon, 29 Jun 2026 at 11:02, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
>
> Output is now more similar to the Linux userspace tool "tpm2_pcrread".
>
> The old semantics that require specifying one PCR number are
> retained. In addition with no arguments the command now prints
> contents of all PCR registers.
>
> Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
>
> ---

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> (no changes since v3)
>
> Changes in v3:
> - fix test failure
>
> Changes in v2:
> - fix return value handling
>
>  cmd/tpm-v2.c               | 69 +++++++++++++++++++++++++++-----------
>  test/py/tests/test_tpm2.py |  9 ++---
>  2 files changed, 53 insertions(+), 25 deletions(-)
>
> diff --git a/cmd/tpm-v2.c b/cmd/tpm-v2.c
> index 847b2691581..e9f4bc24e33 100644
> --- a/cmd/tpm-v2.c
> +++ b/cmd/tpm-v2.c
> @@ -8,6 +8,7 @@
>  #include <dm.h>
>  #include <log.h>
>  #include <mapmem.h>
> +#include <malloc.h>
>  #include <tpm-common.h>
>  #include <tpm-v2.h>
>  #include "tpm-user-utils.h"
> @@ -150,10 +151,11 @@ static int do_tpm_pcr_read(struct cmd_tbl *cmdtp, int flag, int argc,
>         u32 index, rc;
>         int algo_len;
>         unsigned int updates;
> -       void *data;
> +       u8 *data;
>         int ret;
> +       u32 pcr_start, pcr_end;
>
> -       if (argc < 3 || argc > 4)
> +       if (argc > 4)
>                 return CMD_RET_USAGE;
>         if (argc == 4) {
>                 algo = tpm2_name_to_algorithm(argv[3]);
> @@ -168,25 +170,51 @@ static int do_tpm_pcr_read(struct cmd_tbl *cmdtp, int flag, int argc,
>
>         priv = dev_get_uclass_priv(dev);
>         if (!priv)
> -               return -EINVAL;
> -
> -       index = simple_strtoul(argv[1], NULL, 0);
> -       if (index >= priv->pcr_count)
> -               return -EINVAL;
> +               return CMD_RET_FAILURE;
>
> -       data = map_sysmem(simple_strtoul(argv[2], NULL, 0), 0);
> +       if (argc >= 2) {
> +               pcr_start = simple_strtoul(argv[1], NULL, 0);
> +               if (pcr_start >= priv->pcr_count) {
> +                       log_err("Index %u out of range (max %u)\n", pcr_start, priv->pcr_count - 1);
> +                       return CMD_RET_FAILURE;
> +               }
> +               pcr_end = pcr_start + 1;
> +       } else {
> +               pcr_start = 0;
> +               pcr_end = priv->pcr_count;
> +       }
>
> -       rc = tpm2_pcr_read(dev, index, priv->pcr_select_min, algo,
> -                          data, algo_len, &updates);
> -       if (!rc) {
> -               printf("PCR #%u %s %d byte content (%u known updates):\n", index,
> -                      tpm2_algorithm_name(algo), algo_len, updates);
> -               print_byte_string(data, algo_len);
> +       if (argc >= 3) {
> +               data = map_sysmem(simple_strtoul(argv[2], NULL, 0), 0);
> +       } else {
> +               data = malloc(algo_len);
> +               if (!data) {
> +                       log_err("Failed to allocate %u bytes for PCR data\n", algo_len);
> +                       return CMD_RET_FAILURE;
> +               }
>         }
>
> -       unmap_sysmem(data);
> +       printf("%8s:\n", tpm2_algorithm_name(algo));
> +       for (index = pcr_start; index < pcr_end; ++index) {
> +               printf("%6u: ", index);
> +               rc = tpm2_pcr_read(dev, index, priv->pcr_select_min, algo,
> +                                  data, algo_len, &updates);
> +               if (rc == 0) {
> +                       printf("0x");
> +                       for (int i = 0; i < algo_len; ++i)
> +                               printf("%02X", data[i]);
> +                       printf(" (%u known updates)\n", updates);
> +               } else {
> +                       log_err("PCR #%u read failed: %d\n", index, rc);
> +                       ret = report_return_code(rc);
> +               }
> +       }
> +       if (argc >= 3)
> +               unmap_sysmem(data);
> +       else
> +               free(data);
>
> -       return report_return_code(rc);
> +       return ret;
>  }
>
>  static int do_tpm_get_capability(struct cmd_tbl *cmdtp, int flag, int argc,
> @@ -548,10 +576,13 @@ U_BOOT_CMD(tpm2, CONFIG_SYS_MAXARGS, 1, do_tpm, "Issue a TPMv2.x command",
>  "    Extend PCR #<pcr> with digest at <digest_addr> with digest_algo.\n"
>  "    <pcr>: index of the PCR\n"
>  "    <digest_addr>: address of digest of digest_algo type (defaults to SHA256)\n"
> -"pcr_read <pcr> <digest_addr> [<digest_algo>]\n"
> +"pcr_read [<pcr> [<digest_addr> [<digest_algo>]]]\n"
>  "    Read PCR #<pcr> to memory address <digest_addr> with <digest_algo>.\n"
> -"    <pcr>: index of the PCR\n"
> -"    <digest_addr>: address of digest of digest_algo type (defaults to SHA256)\n"
> +"    With no arguments, print all PCR registers.\n"
> +"    If only <pcr> is specified, a buffer is allocated internally.\n"
> +"    <pcr>: index of the PCR (optional, defaults to all PCRs)\n"
> +"    <digest_addr>: address of digest of digest_algo type (optional)\n"
> +"    <digest_algo>: digest algorithm type (defaults to SHA256)\n"
>  "get_capability <capability> <property> <addr> <count>\n"
>  "    Read and display <count> entries indexed by <capability>/<property>.\n"
>  "    Values are 4 bytes long and are written at <addr>.\n"
> diff --git a/test/py/tests/test_tpm2.py b/test/py/tests/test_tpm2.py
> index 9be85999d46..1baf86dd065 100644
> --- a/test/py/tests/test_tpm2.py
> +++ b/test/py/tests/test_tpm2.py
> @@ -198,8 +198,7 @@ def test_tpm2_pcr_read(ubman):
>      updates = int(re.findall(r'\d+', str)[0])
>
>      # Check the output value
> -    assert 'PCR #10 sha256 32 byte content' in read_pcr
> -    assert '00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00' in read_pcr
> +    assert 'sha256:\r\r\n    10: 0x0000000000000000000000000000000000000000000000000000000000000000' in read_pcr
>
>  @pytest.mark.buildconfigspec('cmd_tpm_v2')
>  @pytest.mark.notbuildconfigspec('target_chromebook_coral')
> @@ -230,8 +229,7 @@ def test_tpm2_pcr_extend(ubman):
>      read_pcr = ubman.run_command('tpm2 pcr_read 10 0x%x' % (ram + 0x20))
>      output = ubman.run_command('echo $?')
>      assert output.endswith('0')
> -    assert 'f5 a5 fd 42 d1 6a 20 30 27 98 ef 6e d3 09 97 9b' in read_pcr
> -    assert '43 00 3d 23 20 d9 f0 e8 ea 98 31 a9 27 59 fb 4b' in read_pcr
> +    assert 'sha256:\r\r\n    10: 0xF5A5FD42D16A20302798EF6ED309979B43003D2320D9F0E8EA9831A92759FB4B' in read_pcr
>
>      str = re.findall(r'\d+ known updates', read_pcr)[0]
>      new_updates = int(re.findall(r'\d+', str)[0])
> @@ -244,8 +242,7 @@ def test_tpm2_pcr_extend(ubman):
>      read_pcr = ubman.run_command('tpm2 pcr_read 10 0x%x' % (ram + 0x20))
>      output = ubman.run_command('echo $?')
>      assert output.endswith('0')
> -    assert '7a 05 01 f5 95 7b df 9c b3 a8 ff 49 66 f0 22 65' in read_pcr
> -    assert 'f9 68 65 8b 7a 9c 62 64 2c ba 11 65 e8 66 42 f5' in read_pcr
> +    assert '10: 0x7A0501F5957BDF9CB3A8FF4966F02265F968658B7A9C62642CBA1165E86642F5' in read_pcr
>
>      str = re.findall(r'\d+ known updates', read_pcr)[0]
>      new_updates = int(re.findall(r'\d+', str)[0])
> --
> 2.43.0
>
