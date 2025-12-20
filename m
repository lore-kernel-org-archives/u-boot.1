Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E50D637B2
	for <u-boot@archiver.kernel.org>; Sat, 20 Dec 2025 08:39:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED86680325;
	Sat, 20 Dec 2025 09:39:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="RPi44oIq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32532835B3; Sat, 20 Dec 2025 09:39:54 +0100 (CET)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1FA980050
 for <u-boot@lists.denx.de>; Sat, 20 Dec 2025 09:39:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c13771b2cf9so2207954a12.1
 for <u-boot@lists.denx.de>; Sat, 20 Dec 2025 00:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1766219990; x=1766824790;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ea4M7mdJKHEHKhA0y7GYaQREANtflREWES/5p2hQehI=;
 b=RPi44oIq9FCD9HT39xiWbQ35dFEdjMF1dVLGjvZD6xhFmeNscbm2xT6+ozrgpBYgiA
 WoTha6Dr2HAJiuIQ+l76jMmQDZesIuH6cFAO3tOeFt+w4DQ8ckW52aU0tgP2RN2lcYFz
 1VlQL6yUke+Nzv5NyHUQd1JbNGdfi2sR1voUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766219990; x=1766824790;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ea4M7mdJKHEHKhA0y7GYaQREANtflREWES/5p2hQehI=;
 b=VzcHW0aKNVIuiDnsPrq65LwQAGdeWLao2tKwhE31N0g0wHJS77Hkeq/sDwrTT7PkLR
 O/S7jDM2zwVgCvfcLEa+5GzkfrROodKfXHumW/zfLfXhumLZxWoxz2dUCKNI3z929ans
 9lykNzEJZBGTpsul2fCkhC20Ec9uxFi+qeSxnIwWIXRVlSNN8NyUQ0xaZ3sYwR//awwx
 sAM4bVF0wTZ3X3zXAsK6cIaTz2sUvbWwOXKOd1YFOXhkjv00x/hhOMHIITzA6aiuYWwx
 8bw7kgax97iVu9iZrLBsIWOoyvk4PdL6eiWQWqJKuN2JLgktsjzGELiwjH43jD8XCjPZ
 qvVQ==
X-Gm-Message-State: AOJu0Yzr491oIDGRGBcjwrInhak5fyYbYmm30iHIhH/UtOpdM1Yc6eIZ
 d2U3RCUQrneUNQrnm/l4wPlzVvDlMUbVZeU3MTxBQ1N+zC5HrzEjRt0gODG0Buk8r9uqHrHWnL8
 U6rnxRC9eYUdW/Sva3fYQKY4DuQesl6BRWYXnEAXEcg==
X-Gm-Gg: AY/fxX6U/+tCGzMRQ023vEbTL2Hpi3aZexlGv4BJFn2uJbIhitA8PbYiuYmbO+b6crC
 btzKQWjLuem8XDbYw27RqdCFWLyYOf9IopPRkmvaTGOFcIvE3TQmKbjQ5zIcSmbHzGXz2PeeoKX
 7Num5L3bRhbHcHz9O2f5FzwGNCfVi+UqZFujD3HAcUzlqoUmSxvlD99uLKHee+pLKzflhvierMk
 MHuoyGf0u1wB8gQOXVoVZptvB3xGfOLnF/AxTMRtUQZc0UafTyhfmSBE4s2dD5FYBYzNFrkVm4G
 oLczIuDNlKPEXcyyHcQsV0+bug==
X-Google-Smtp-Source: AGHT+IH9YOTQW3J1CyUc/NRuGJ1nPU/LAiTeW1DU+w/klR29WF+4V/wMPdEIV2k/5RQJhcPadvDKV4jqMRSTPLIGrhI=
X-Received: by 2002:a05:7300:d208:b0:2af:7427:2ff with SMTP id
 5a478bee46e88-2b05ec468f5mr5060120eec.29.1766219989935; Sat, 20 Dec 2025
 00:39:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1765892031.git.peter.suti@streamunlimited.com>
 <722abb2d211a68f8a6867b2e03186245a443fbb9.1765892031.git.peter.suti@streamunlimited.com>
In-Reply-To: <722abb2d211a68f8a6867b2e03186245a443fbb9.1765892031.git.peter.suti@streamunlimited.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sat, 20 Dec 2025 09:39:37 +0100
X-Gm-Features: AQt7F2qa-h0Ly-A4d1VNfT3LY6G3DiWFD7jvJAfW-B56arv8cfKZN9XKNwQcFeQ
Message-ID: <CAOf5uwkGN07wjgMPjpRCByUFKU2Wf0H9dm6q966GGkO3FBT9nw@mail.gmail.com>
Subject: Re: [PATCH 1/2] cmd: mtd: fix read failure on default full partition
 read with bad blocks
To: Peter Suti <peter.suti@streamunlimited.com>
Cc: u-boot@lists.denx.de,
 =?UTF-8?Q?Radek_Dost=C3=A1l?= <radek.dostal@streamunlimited.com>, 
 Tom Rini <trini@konsulko.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
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

HI Peter


On Tue, Dec 16, 2025 at 2:41=E2=80=AFPM Peter Suti
<peter.suti@streamunlimited.com> wrote:
>
> When performing an 'mtd read' on a NAND partition, the presence of bad
> blocks can cause the command to fail with error -22 (EINVAL) if the
> requested size is equal to (or close to) the partition size.
> When size is not provided, the whole partition is read by default.
>
> This issue occurs because the bad block skipping logic increments the
> physical read offset ('off') without decrementing the 'remaining' byte
> count. If enough bad blocks are skipped, the 'off' pointer eventually
> slides past the end of the partition boundary ('mtd->size') while
> 'remaining' is still non-zero. The subsequent call to 'mtd_read_oob'
> then fails its internal boundary checks.
>
> The Scenario:
>   Partition Size: 0x1200000
>   Bad Blocks:     1
>   Command:        mtd read swufit ${loadaddr}
>                   (Defaults to reading full 0x1200000 bytes)
>
>   1. U-Boot attempts to read 0x1200000 valid bytes.
>   2. It encounters the bad block and skips it (off +=3D mtd->erasesize).
>   3. To satisfy the full request, it must read
>      (0x1200000 + mtd->erasesize) physical bytes.
>   4. The read pointer 'off' exceeds 'mtd->size'.
>   5. Command aborts with: "Read on swufit failed with error -22".
>
> Add a boundary check at the start of the read loop. If the read pointer
> 'off' reaches the end of the physical device, check if the user explicitl=
y
> requested a size (argc >=3D 2).
>
> * If no size was specified (default read): Stop the read gracefully,
>   print a notice, and return success. We assume the user wants "all
>   available data" up to the physical limit.
> * If a size was explicitly specified: Continue standard execution. This
>   will result in an error (-22) as expected, since the specific requireme=
nt
>   cannot be met.
>
> It is physically impossible to read the full logical size of a partition
> if it contains bad blocks (as the bad blocks consume physical space
> required for the data). In this case, truncating the read is reasonable.
> For common use cases like loading FIT images (which often
> contain padding at the end), missing the trailing 0xFF data is acceptable=
,
> whereas failing the entire load operation is not.
>
> Also add some logging when bad blocks are encountered.
>
> NOTE: This changes the behavior of 'mtd read' when no size is provided.
>       Previously, it failed if the full read was impossible. Now, it
>       succeeds with a truncated buffer. The caller is responsible for
>       verifying data integrity (e.g., via fitImage hash verification).
>
> Signed-off-by: Peter Suti <peter.suti@streamunlimited.com>
> [polished the comment and commit message]
> Signed-off-by: Radek Dost=C3=A1l <radek.dostal@streamunlimited.com>
> ---
>  cmd/mtd.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/cmd/mtd.c b/cmd/mtd.c
> index 7f25144098b..1d1845bce44 100644
> --- a/cmd/mtd.c
> +++ b/cmd/mtd.c
> @@ -559,8 +559,10 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag=
, int argc,
>
>         /* Search for the first good block after the given offset */
>         off =3D start_off;
> -       while (mtd_block_isbad(mtd, off))
> +       while (mtd_block_isbad(mtd, off)) {
> +               printf("Bad block: failed to read at offset 0x%llx, skipp=
ing.\n", off);
>                 off +=3D mtd->erasesize;
> +       }

Would like to avoid adding more debug stuff or printing here.

>
>         led_activity_blink();
>
> @@ -569,9 +571,32 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag=
, int argc,
>
>         /* Loop over the pages to do the actual read/write */
>         while (remaining) {
> +               /*
> +                * Boundary Check: Bad block skipping may push the physic=
al read offset
> +                * past the partition end (mtd->size).
> +                * If the read pointer 'off' has reached the end of the p=
hysical flash,
> +                * we physically cannot read more.
> +                *
> +                * Check 'argc' to see if the user explicitly requested a=
 specific size.
> +                * * If argc < 2, the user did NOT specify a size (defaul=
ted to partition size).
> +                *   In this case, we treat "end of flash" as a natural s=
topping point
> +                *   and truncate the read gracefully.
> +                * * If argc >=3D 2, the user explicitly asked for N byte=
s.
> +                *   In this case, we do NOT truncate. We let the loop co=
ntinue, which
> +                *   will trigger the standard error (-22) because the re=
quest cannot be met.
> +                */
> +               if (argc < 2 && off >=3D mtd->size) {
> +                       printf("Notice: Reached end of partition with %ll=
d bytes remaining. "
> +                              "Truncating read.\n", remaining);

This is ok as print, to inform about the boundary check

> +                       remaining =3D 0;
> +                       ret =3D CMD_RET_SUCCESS;

What is the drawback to failing here, I mean you can still verify the
integrity. GIve a script example
where this is needed in the commit message

> +                       break;
> +               }
> +
>                 /* Skip the block if it is bad */
>                 if (mtd_is_aligned_with_block_size(mtd, off) &&
>                     mtd_block_isbad(mtd, off)) {
> +                       printf("Bad block: failed to read at offset 0x%ll=
x, skipping.\n", off);
>                         off +=3D mtd->erasesize;

This is an extra print for now, you can propose it on a separated patch

Michael

>                         continue;
>                 }
> --
> 2.43.0
>


--
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
