Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5358C87FCE
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 12:46:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90CCA8396E;
	Fri, 25 Jul 2025 14:46:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ZEJPGL2h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 112E683970; Fri, 25 Jul 2025 14:46:17 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2D4E838C2
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 14:46:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1753447569; x=1754052369; i=xypron.glpk@gmx.de;
 bh=zn8NWYE6vjuAY3R+x325YrSrDCoQORf0G5o1m8YcAr0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ZEJPGL2hV+pE6XBJnb7ES4ryQ9kCC6P/qxrdOTxs5v5lgBh7IOMWzzTKAWNnkbmB
 LTynkX5dVj5oIHDhCqtSiaz+fORx9a5ekMVAjj3rVEcUteZJm7gn5YjJqXIuevwjn
 1czXLn1hiPyOAVVrHBvc3OVUW6lpT4Zn1kiW2b7TCCrSN5+F6YGCrGKUQhYL8Hdv/
 18Kiht7n9fXG0Y1/0S94ewF3dn3Cb+xfvBc8SfzY902022YHIf/9mwFrRSnJA9miI
 ZNVbUTwER6hQEb/dJbwjSJOkrpJ8GM+taywOa2yz/0CxMV7wioay0XGq4DW7CE3Xo
 6QY2UhS1kT2GJZTIKg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([46.114.110.103]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFbRm-1uvAnH1bNW-00D4Ac; Fri, 25
 Jul 2025 14:46:09 +0200
Message-ID: <a745fa32-44cc-4671-811f-c9eae8a092e7@gmx.de>
Date: Fri, 25 Jul 2025 14:46:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] exception: Add missing string.h
To: Michal Simek <michal.simek@amd.com>
Cc: Tom Rini <trini@konsulko.com>, git@xilinx.com, u-boot@lists.denx.de
References: <e9b3fd74e233ea783e64fe1d1c3de5d4f3c6610c.1753447310.git.michal.simek@amd.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <e9b3fd74e233ea783e64fe1d1c3de5d4f3c6610c.1753447310.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yQfycruKbd0SHcIjBI0SPbqG119PB5oSUXbkVwH0fdCcuAz+JE2
 idtLpp3h4nFrEsV8uxdSHWGOdFiIVxEThF9Fa1BO9RtyMLiYslOvYzERwAFlbj8xNatSgNr
 pVR/tSbbqEMCWXlkRs5o+Q8/sJVVABJ+L9XhpBHan+M9E7zFucluHF8eo0Yjn3fUUfBD642
 GUVdpFjY/H10z93Xb3kPA==
UI-OutboundReport: notjunk:1;M01:P0:DEFSgoXg6HU=;M15T5gajgC7+onvK5CpFCeFPvkv
 RxS7XZCD7A4k/6rIDtOYe4BMwT3aJUWK/fZ/GTeXvI0o/dpisAwWwBWyS6Lklcq4RqyEhNGCG
 PMG3Mmf3FaUzumyixy85aXv6TQ+DNsSuoG6Ztzx0oSEpH8PgaYnvNKMYfikVN8I2TYmoIkzlq
 qzURcPEp2lmnJ4Ko15nJY+Cb7ZpHsGnyy5pIABULkGd9RF4HduO4XkXDoAM45AchD/fVbqH7C
 d4xW852WqrkRD7JC2pq5a/w3ArppXwcbLcIOabl2SvCaWYl6kksJQANhp715JWt62Edw2JxGc
 7o8U9fDdrNGDhNs6X9FiYJH3IcfudSRVdeAGPt9Soo0M1Xm0VFmkxqCO3bVJjhy+ecwJNfIG7
 Gp74uOM6ihnFex5fx3ESG5eQNnbqOXuSfu4f2Qc1asLiGr33Ha7d9oRxjp+RWBtBIuIMsU547
 MP0QoYLnoQOUEXhXyt0JBQM1lI1IHdQd/f5IrTdhyy/dyBbgiNeRXGvuRCiPMCHtk8sVsMr/j
 nApCWhbsVbnPQ5AX3xC6hijxzG9St74HRJzV+1vcpghWb2ARYUm3mcx6FLyhl7TcXWrbkpO9o
 HDycr0FWBkRp9fL9nxVcaQxeHDYLegWE2Ij/K8nZvb/+9J735ZVCliLVbAkk/EbYXX4oA68oz
 KSmMmeLtuXnapVnKK/o//L9M01uKe9jwIUBmewNxO5A4qVK66uT+Kq6xvfDYk8tvREeP4tH6P
 Zb5lVmaBcT6qL7UoNxkH7htPuYcMO6YZlpJnUJ05Yb6STDmdtrg7H7EyhqWc7536hJQtNH0D/
 C+AGDjusMp86T5WAGfI+mtpMQmK8/uatYq0DepYiHBKvQdjvJOfA9nKA5JkUaJnFTkLP5FnHY
 r2N4hFAJ82MuKcnD87jvGQikwFBCDpEaA0TiqOP7NzYXXZl9xEyatf7hgFor+8c09BXySqvtJ
 hf76HtzxkXFPf/v+nwyN6sHC8g4URh9d6XrdrB5QD8qnojEnGijE1o5WAKfFsK+MxfPAHnNg1
 58CQ/dbwMS/IZ7G9yBqJNdS7NAaNcWJy6Ooq5U+kMZ4GiWKWDvnRGs04xWqgLQh0sh0oqAA/9
 n5pWHMxBU+bRMpEQ7AHC5tB/i2NWQW9SRiZPUvggwyWA9FzG63X/eMXw2+gGIQ17xggajNNfP
 qXyMPBt1S12zaROYh9rLWN+wkdGl7nPoOxS1QseUdqB4E3SyxTS+RTttxBIn/Rx9S51LxOeZ6
 /2pKf1/V/kmb9CHA+839+vMp4NszRg2NafD3tQViaQmIfuwTRAHUT55Yeq0NpKeFWENuKAfFC
 Nt2oiaP3O5C8nR6/3CLtKASw27bzT6Ta8BQyuUWuLNeFiCH/tFYBAIIwed57teBFcxzHyzUYK
 Ji4SGdo15fdJJQZeKgKqB8UWHk+t2Iu9JwELH5ekBuD7Ts/nX7bnsmJazYNqScOMwPM77ddHL
 FCGomIaR3i7k6Ejm9dQeORjgXwCb0rrpqccKFc5ocBTxBvvhdYLpD1/p+LIBlEEwu74ElL/ka
 lLiHLhs1eR5v52mbbar3UxyUBn69q4+lAs2x18cZgL6yV2CCUimxsxYkHUm7+rERm+enBb1jq
 tOZ0a3mfekP1b6HhReMvemg0f6pC0Sq7QfiUqKGJH9LZk7QTibJTT9bchW/wsseXZy/leIuFN
 hUJD2qGqkYJkcYUNcaA8tA2nJgFKSHn1ohS4lVfgTPXhTbcRU1Qw7T0RMNWK7bRL2EWx/urp2
 yQTPmiyfue1Wob2pVZlPoDqYfI3N0TAhSS4DUWc0ov3acpHAlAOVPS7W3a/Fudz8sToFopwAZ
 qylgP6PSsEYbtPehbezH3kNCcokcGSm5pT052f+ia4atCgYKZVv7esN3qqhH+fMV4EqKgcvwS
 mMTrMx+mc6oO1l7nXhwPqQkbaohTmnjR/c3t28/eTdPujFStJ4aEnLnM3magkZ+FBA+lu2OZ6
 zKj9v4F1OFAA7l5kuy5Fuc551VsDk1gDNXKRoK4icrsx0eSE3EcWPTpDnA077R6xDYUVzpY36
 rrWiIzv0gpDMRAl2rHGqPgg+R19YVLrOHV5rrhQ7hGKSHVagKpln26qd1DiTKEzX3ox58W4sw
 a2i7B4JNe3HdqaEUxirybWh2xqwFMnoBPKtmu5rBGrMVq9CQ6QdCDGLMvd4BYqNvxQaUZOqz6
 NRQU90XSs/95lprEaQAqTijhDU/cnL0z0j3U1IQjAoW8VVhPFzhcfipcuGJFtsIOENBxmS4Y2
 dWhR4BSzIAFLqCpV4tMhhpWrD33DVJo3CdPY61NRzaw5Id3iIBddUf2OBm87FVjJNzK1QjraF
 FY0Ar+49PFRmE4Th7b9F5UxIrPKCRHx539FG2tb9dn0r0AFDzD0hiH/O3uCh4QkvyilKKCKYF
 UVHHwu/x3qa08vV5Zo/Kl9pxyP75Hpi5f1kygMetGjIGl8d7tejPbAyJ7+z3EXtnFgbWyQ63E
 3eWlr8Q9I96ozypKhCNyuqRtSxxcOjUIn6ROADUQ0sIDrhJlOhDG6L9G0adg/Ih4+LkO/aEwR
 YW5VKKiQXpDULwrYSVX4tKYENEB403c8G1lfqZNFgboFaQqCnnCwz4BGSugHSDqhZUnMIfWE7
 t8i66rf0pGAs6jyvBla4S3WLuIwREFFDNKwT9xnLV5uHtW8AcpG2c7iQRCAlK24/0EIFFCXFD
 89yQsLmRcQdOlfg+l9uO8zKsX5eT1cH+6ZhamS84yZ7eyJ1nN8mLnzui5fbVA5wghFCMOIPTN
 khF8jH7Rakttu9lmQxq0rl5R2ksW4LPgrQNuOvbXJCws6ev6dJoJcPf3eFiFTUTQ9eqxSuHTU
 PSXG1XPREu5QCQ2iC2f5WbjClmYh8gcIAL6oV29zAp0SxzWc1U80Z1YRlFh3nYI9d8R2372gU
 HXzPxuBQpcS5byeFSIi2VwHPHJZBwq7S8ld88QNIlxxlyqKlS0WnzskXfrrt6SYBQ7XeZVK5x
 /tO2OUFQpuvpNuRubkdlCHoRPyrTj3bqPMGcrcr9XGoNn7kGY75SNDq84cgImPu1wF9zjMIEn
 pLpnlkfyawLxNmoaS2AYNzg3VYmDnrtYLGZZKTilLiL6BoLMQXqLr1qL3r3M5lDXsysrrWfg0
 xPhZ/JhuPxKexTmTwosdnn8aWJVuITq05divg+4DvDYkCMwbG53TzMSyaC5GnUQ3UbtuyivmK
 rrOOayXP8DFIJnGOkIQAUUfeCgRmFUE9tX64R+9ijfbDfSPUAZt+8EZTpo+YsdTyEblg62q9L
 eRjfQxsOsJzB7fK+ntTSHW2EnF/gQI/fdAZoOE0zp4IioH3J/4yEwmUvWzDNo9GsYyIOT2kcd
 d+IqAJ80DEX7iLY2GyZIfmXFHV4rnDksRsPGjXcHmeWywzsUu7Hf9Fu8IxM6BVT6S0oFTfYx5
 MW6E7x2kpemUf90T9qvmVGoQXfooOhjzjQWK0jYNpXbp3brpP6/E2GvBqrrs4NQPBPWfy0MRS
 nVfteiPdh70wC/CsQ6uD2/dIknph+oLMhg7wb+OknE8ba4mb0I/2MIkD+lwmB1kym6UpvYr4C
 9Q==
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

On 25.07.25 14:41, Michal Simek wrote:
> The commit 1e50f7457fca ("include/command.h: Drop <env.h>") removed env.=
h
> which also included string.h which generate compilation error.
> But because none is enabling CMD_EXCEPTION it by default it hasn't been
> spot.
>=20
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>=20
>    CC      drivers/mtd/mtd-uclass.o
> In file included from cmd/riscv/exception.c:91:
> include/exception.h: In function 'exception_complete':
> include/exception.h:41:23: error: implicit declaration of function 'strl=
en' [-Wimplicit-function-declaration]
>     41 |                 len =3D strlen(argv[1]);
>        |                       ^~~~~~
> include/exception.h:1:1: note: 'strlen' is defined in header '<string.h>=
'; this is probably fixable by adding '#include <string.h>'
>    +++ |+#include <string.h>
>      1 | /* SPDX-License-Identifier: GPL-2.0+ */
> include/exception.h:49:22: error: implicit declaration of function 'strn=
cmp' [-Wimplicit-function-declaration]
>     49 |                 if (!strncmp(argv[1], cmdtp->name, len))
>        |                      ^~~~~~~
> include/exception.h:49:22: note: 'strncmp' is defined in header '<string=
.h>'; this is probably fixable by adding '#include <string.h>'
> make[2]: *** [scripts/Makefile.build:297: cmd/riscv/exception.o] Error 1
> make[2]: *** Waiting for unfinished jobs....
>    CC      drivers/serial/serial-uclass.o
>=20
> ---
>   include/exception.h | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/include/exception.h b/include/exception.h
> index a7f21e73d753..0d4dff49954b 100644
> --- a/include/exception.h
> +++ b/include/exception.h
> @@ -6,6 +6,7 @@
>    */
>  =20
>   #include <command.h>
> +#include <string.h>
>  =20
>   static int do_exception(struct cmd_tbl *cmdtp, int flag, int argc,
>   			char *const argv[])

This patch just looks like
https://patchwork.ozlabs.org/project/uboot/patch/20250702205818.44188-1-he=
inrich.schuchardt@canonical.com/
and
https://patchwork.ozlabs.org/project/uboot/patch/20250703051951.43372-2-he=
inrich.schuchardt@canonical.com/
which were positively reviewed.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
