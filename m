Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C81F8E4AB
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 05:59:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A8B883EEF;
	Fri, 17 Apr 2026 07:59:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="KnfHX3NZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B178783FC0; Fri, 17 Apr 2026 07:59:43 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A04B3839D9
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 07:59:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1776405578; x=1777010378; i=xypron.glpk@gmx.de;
 bh=0OxRPsomln2E5sQmDofKgDYxtBj2gspOqsmVSJYc0cE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=KnfHX3NZrDI2n8a1uJ32SsRFsM6RTP55tSL75/D2y2BsOW76oRoBqtfQipoYND8c
 3grNogYWk7U7QFrw7veWuylvQ5W6v0saYVdfm0oE2lO/QWXmjNiGWHOTgn3CWZg1w
 VOpZq0mD8tWv1+N2B78Y9W1ChS2toARHOgwrztnEaSRI2FaDAf5CtkTF4n/FTFHye
 jgaNgxAKiHDfYc1e2c4DVNjYxKgJJZClhnQmo82kL65DXXZi1k6CqDN9a35k6NqA/
 Kg9UzCH4yoXJ+XAjg3Z39mNZsK3wUNI9GRNN34h6KWsQpEdv8IuGd+uBnilxFxswc
 hTwOHu7BYIrTfUZw0w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McY8d-1vhII83jvZ-00lHIR; Fri, 17
 Apr 2026 07:59:37 +0200
Message-ID: <76933f99-d73a-43e2-be5e-0b765e8679b2@gmx.de>
Date: Fri, 17 Apr 2026 07:59:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: support EFI_OS_INDICATIONS_BOOT_TO_FW_UI
To: Gary Guo <gary@garyguo.net>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 David Zang <davidzangcs@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Simon Glass <sjg@chromium.org>,
 Javier Tia <javier.tia@linaro.org>, Martyn Welch <martyn.welch@collabora.com>
References: <20260331191853.44549-1-gary@garyguo.net>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260331191853.44549-1-gary@garyguo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IK7h9ngkz+TRuFjo/oLaW75CF0SjG08Fhxsob9K4KJJ9leJqKGS
 b++FW2ECYBqweClnInnlpu13b7G1YRXmeKWfTJEBiOU7BsZ/ke1AfeAPfGzvhPJPhYhUHEK
 lu/OCQHNdnRDH426Gs1S3fx7mAtrkB35IirFwumd99MsDj/YJsoKmgEd4Cz1aw96zGRaihM
 Bc9KzW565ahRh2IRsoh8w==
UI-OutboundReport: notjunk:1;M01:P0:BbsiV87Kgvs=;8jXS715wZG7aVcyio82X4iCNvNK
 t+/ruHL0McXn9AUsD5jLrhBd271uuc/rEUyuKwUbj8V+10fn9beHZ1eLzFmPjD7fpZ+hIyxrX
 B8EkRMvIMo/dtgE7y6LMAgmF1SqP6zMmAVlURGUbfNMRl/u22W5lgavz0w3+qfdH8Ho/mLgxV
 T1WeqDPBRK6pe6eQM4klA6nSKHkAFLrDKOE7fRfwbJ+TN3QyL5D6H+qswz+1Vwdq9sLNN7JAe
 PaBXZfQ763c/2AKz1sbErf1uYtI3bP9U6KllJ7xSqo59AhM0R/0HwMwqVCHDHjvO8XpqCRLoY
 ZrxDJlUAB4b28Ug/Ij9DuNhzSayVWsJ6hU5JmoaMwqmocPXyhiRCZn9iAuP8Jx5quyYITO8W1
 lFtrUyaa2bk7oIlMfC77mtDzz1zVHkv/qcnTmXSVosH+C+lOpwTuqUxGGdaSL9hLLGGeeqxj8
 mAYF3tgB92Q+mCXKxCl5hg5Xpe6344ZHYQV1NHffX8EPso/eUmWPnVXlt8BQnhDnANM+YJtaY
 zy2LtX7nLatNt9pliBYOPjY2Thhn3GDySDmwYQvWWpBJPYQOrhUxibde0OYE1D5B0xbAgWCJW
 RI6K2vWpIsXQVk/QR723pb19L5n3euSmHX3GYXNuhU4/tlqPPPFU3aUJK5zEVLqzgDt1NxTJJ
 9+H/NeoIUhXfaXYcMVH9hxgnLn6LGXWy+uF8S5Pnx/1uRUfUJXw713NTcHkIXttfMhacI2ASV
 NzOZcWs294sm4tzx4+aN/CNk6ErdF7wOO/JUT+VCpG05pUY2fY97omT1k4qj+WUeA/azyHQlv
 AFI2tZQgdrI/dy6Z21eUZ1iO9g/vkz2kicR5OJFiLOmJmA8Onvovc52TTddHuFDJ+tn4QG3QU
 k/oiFqWnBU9p8ylZR61RO8yBzWIpfjnvEEsrWep45c55K8EcWFpgUnXWF2BHwa/7RBmao6J4v
 y+0qH1oHMBZPWiimR7dUL3JKLM8M/r89vNUo3asFaYtk37w6vbTThvuQVKYdjoDDEsJcr+n5e
 0BcO+wbkzmHaoPJXroVxE3RQkE6RxfwEQ5gstPOruHj/eo21tNgqzYpikFZSoCbc4hlj6TA46
 aZbuc/k2pevp6uw0AE+Wv3XtNsJ9sXkdkguypVuadoQY2kTTmyqFfc8qm8bIlbmTx+BDJ914J
 944D4gbN8Gpv3yuFmOVKpV+2dzch2VxjoTfGthugb6UAJZ0PcicOR3Q1QF9k+KSZm3xdo6TCM
 BIP9qhY8QWPtIWn/KS0HstimHqwZaTXS4SavM0YFSENlDeeBqeXTj4LFCKoBfQ+uYvgnAzCX6
 p2hCf/oZUkFNEuDy4jriOXU0NaJe/cboRvohooxursb/UpNb64grj5vMJk8YPdsKu3ehfIsuk
 mJ3+Xq5u38B8tgXQGstiJs6CJ/y3L85omTxkB46pPdRPoxyq+go21Ju+Zw9QvYAsdfEyd+2AD
 CfNCH/I1T3+TYoTrS9xLCKUEwmT12UaUDu45rwP0P87IQ7nnXhNflf1cvKgZatj1+qHNkTxV5
 10JF+SjS3THbXUSuCbgE4ipJ3ffBVaBRPd9kf9f/6M46frGNQ6Tp8ruSvTHeHXDcn1dDW4wnV
 hO7dwVUw24ms1coOKjm1vvprqRRXZ0BUG3qia0gCy2EfV2G60nKu86Yd4tNNmbcMQ0lXrgjJ5
 aw/Te7fZXldM1wPHT8uaK9DC2BCHEHsDEA+S95uuhlXoQH1tQ0YhNLHSmfSLjltyKdjmN/OSI
 YPwCkftFP87sbogs9crnMZNTbP5rE+dPr/PvOqcwSks/t39ht/zFSUg7LgqVJH0sEZebXIHfQ
 Liv/x9jOTNBAcxgZyIHHGtSs8fAMalfCY5ZhrHE7yMx/iDds73WZBCqZ3UUGuvC099q80Q1rS
 DbRbDDmpRhyAdBFLX516WeB7oN8vgblZ5jfY3eetYbKzQHR1/pqIpzaSo/oMOdMmo58qwH7ep
 7nCHXRpvbsmgYuHyviCO3CpX6ghqpcV2BebeILw/a3KQ0xDhLOZuQFSkQqx7pUabLnOaWWj0d
 cjEhG8Xxu8LBYM5FkZ7VOO7MAOf3GSwfd6Awyp8hOgyo8CjTCOBpl9aYJnBMJOtZAoEq+wRbK
 wYE6j2blRS+BonAiZyXB0OgSOYkmqZQ5295wkJRBm6KC/uUeHI6U1oF7NVlWoCY/P9gg54Wa1
 vhPoM8nZzvZ5ev10SlJpna/AOavALA0BPFY9trxxi9izK9P1THP2dPht61wIw7uKJ2J9EOaLL
 4pVVEKDQHsrT/6GROKiBW8nL4Pp0FXm379PshKgDnPdqf9qhB8SEb8fbC2brpU//ldCiIVnci
 CD6ywRw0cKvcHodWqQJxYESHlrEKBrNuYcuM740mzCPzqRVafU/mu1WvU8z2/D/3LykLzBrR6
 8grPX0IbBJugr5bMBatAmh64q16SftsyNCxLN5xxMIPLgiAs2apoABa/qEaxGerzkYm++Pi/C
 5QJIGVEtvuvx3jm8tOsbrtAVylydybsFqaNxSBIWXvkfxKwfLHUbeZc7UiEtrXkqYiDIdL0Xn
 QkAult5fpAYlt5kP5X4685o72rZL+pDwfY/IF7cDfV3bHqjTlP9B6c/gK4cw9iFJkZ7XZQfTz
 2Ex9vzcDNhr5BSDtlJwUkaB5v8dApxmh3lnEZpHHVoQH4sTHBjwsozNqYs2AbQxl4sUlZaCfn
 WWhRf4bqwo6aofXL+O3gsd/z2wxwH8H+3ktlOuyxIM0XySxNOf61xWrXpiVwthKs3TEPtKICE
 FX0CJ6BBDqfa7RTJYRUz/wjJDQZGW3jL02PFeOZS4gu2EvG24rg99PlIlmSRHAGdk5N2g3SHl
 iMCl6Yb5t4jG00fLKKCYsNXSZr3/Smoetdv0LkRwanJFNXCtydCsmAtVvcxT/BbxonXCkFkga
 dJqHKqX81Tw7siG/tGscoP4jNQrnRYJBw5om/G0HV7PQfxnFr5qeYcp/M69RveE1QubFoYwOT
 f4MC93fc3Ch4sP2TW8RAg14P2ZBgW3Sq+q6L1GRDtd+bVQaILNNOjBJruCh62+vx8c8flxhEd
 y9ia6x8GwBce6tWp9sVq0p2KcKQ5cK1dEPBgMx9ZDnpKpb0eFry33Mf9GlbR17uzBls6D3Ub3
 g8Rcz5snS3DeZPjUBgre9Lu6WvVdv+qGBT1GhULqgNuY/jid0YDyevgb/XBMoE8Q1NFBzUbsc
 IkBOdLOQFcYPScIPjZGLOGbc9zOA/uUqC7cW1UyRzkvrkUMBIVmW37MMa82cV5V5jXE89ZIFr
 d5I9RWuAMz32eemoF3syoSfHsn53q1+zGPzpMMpSLlQdzhOjSognQt1Gsk7kBUdoSrWaU7mYZ
 J2GJAJDccv8pECbsBLal5NtuQfpnCMb1jAkGSt9zxUak4LDyVkxiSr204XV1UPKjiN2Z1s1Dj
 UeEn61Sx1aX6kEhBqfsV6CAVFuuMcnB9iFjki/CSgCoC4AU9cKOYSzIYvG6rhXuBdhsMrFK1Y
 CmOR+02v/2Ycr6u3gL97MkuoFBUJVaZZCaW/Ojs6tBVTvnHbE3agOCavyCr6aocZgMz8bP7vD
 NdE96SB4ny3f8O+a+1V9fWGiZm53hcmV1BT7VDSHoqUcKzPKPH/xW+mTbdbLMERWLMwSjE4nF
 sgwF1fT2dM1fC/LVsZIwCOq/jb+UL77xER+lGg40hMilpYFRkuAjMWqIXvkgNVIflEc3gY+eK
 J5Q0m2O/NJzQljD6/LwMCqqsh9/maOneEa16R6NrKbzGsUAsr85sa2mMZpwcMk5jVfSCe/PC3
 j0lgHa4Ji6ViRMo+8C68VhijKr8EPX5l44BvA4PlSw571E2KHOlpr3tngLmUlOtv3gX7AL//5
 PUdJx/uaI/bKJy9vYhWAzR7ec9ANrr/f8GsiYx0dZNn0w4o7ZSCJTHEZKdjwXZFeDRyHiN/+o
 TT0REdcU2kZRLdEYXK3GMm9dYfHdxGFQpoY/E7BGPoVLd4uUERiumAq4zUUzQfHqNdXNduTYT
 GlWg22P92WrYCkI73YqWkTuNSkaEFJzVTWYDj4rAquzLCepyMherZOWa0TteH7brRCW0dJ9jB
 aDXu3r/S9cl3jtvJkmgMKgC+23LpTu9DWU93vjy0iOqefnmMJeCh6wl6AqEZwbO9WWDRWY4gw
 abKkOB9f7wX9m5doFrXETbbzg3fvPxEdOFanUF9uv6UAysnISBYcBKYkpc7CUl1I2OCueQ9yo
 LhmF3jImhh6VFJO9zexNuQY19dh+gXzESHfcnOkLDTxKtdOP97PcUVuHx+xCtwMjwAmhwyH2V
 e7AL7IuSCHHaAUJKGvKiJboIMiKn9Y8CQ/lA8ewl1rmL4gXwxQhyOPyo0vASvtdThcTWvONXf
 cFgkgWwdxgmbQO5NGSoFz0yh5rjBeMx9Ad0pDWn9jWOPU9xqOxhrlF3iPcSB+YURU3HNc+An3
 tzE1dxLFBnSsyyfbgcr6+TzYL3tSgf4M3TKx6uxKt46B78NG2lu5PcXWsSlPShuY80sVf2VHz
 t5lrGmlKdA2uHnlqXykLokjPxHPvLmF6RJhp1rwozitpVHpvaM4hvNg0MHMDZftyPYkk2op1b
 XtducsGJzstDbWtQIIM7ygIVs6a3ouZ0QDvZaSrIqPKCk2JrmiRQjRUBpDYYw+tS9k6zhpV7V
 fFM6Gt+h+84kEfsHpr33CdHnqZRYu0DBuXLmCjmNKAi9rQpBDGyFKjji6+14XsfaBOjn7xhDv
 0b+amoOMvDeqRNsz6j677fs9Rl1ph9XEB+ymx2zND6oqHnZGhy0Tozddjsq0SwA0tBq0qkMGG
 cQLN0Gytl69E3iQvx6i1QA4ij8JhIKQALkgce3TwPZY7UHVaol1X9Y74GNA1TfZELWoJ2Jl74
 NOYmcFwB/BFwu4EU9iQi9oPHSbsMtLiwQf6zMQ1mDBZkQ3+B700dHtTW1Qo04uKcGZcgFbkdT
 o0uaEiwoUTyuQCxpHY0IZn2JWpUwukisR5s/pR8yWPdxuoLGfRSMxqkzroOTdb4XXCNeiAbNL
 pQeH5ZWQ/TK6cQ9EAVsrcrIVuLQV7tgo2gUx+xSvAe5RbwbMCcrsUGeTKrx1l7Me1e4ZQaLqA
 bUfU+O5LVr965fZ3O1maw9+9npQfnHlZ7MvZikhtDOc2hM8Q+sAAsc+uGGqfR7mCzphrPOwY+
 cuMS4K0SifiLOBdaKdykO9PNfw3juulPyaSnRK3oVSlzWbfBpKljbBzqTjCJ0f4RUR3RAb8gh
 SjPONWbtL28UBsBAqo9QJICmW1BqvmB8FiRA+E2lRHQQBDqJW5vbf8Cmt7yps6ji05kCGZVUY
 1uM79E8YAqZev0XpkYfZAy1UhXS9LYvnke3aejYqVl5rIm8ChqVUsobUhahZ3p43wOSAgNN4u
 GdKIDufZr4n7+W0HTGErGnjbRsFu54a8dfmfpIL70D9gZkP4BzC1l3cuTCmfSYmEngr51XsNf
 Rr+ZPygGWAly9ibl+Oy0jjiE58mXEGMEchA3imY2iDMvWzzDQYwLTD27MMSZCSigPa2wgfFZJ
 5uLyhVtTD4fa3xj/YqfDyLm98SU8jnjcvzVDxAkkCAw9V6I2UMtJyUEwq
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

On 3/31/26 21:18, Gary Guo wrote:
> EFI variable OsIndications have a bit EFI_OS_INDICATIONS_BOOT_TO_FW_UI
> indicating that the OS (or next stage bootloader) requests booting into
> firmware UI instead of continuing autoboot process.
>=20
> Support it by having autoboot.c asking EFI bootmgr if boot should contin=
ue,
> which checks and clear the bit (so the next boot continue as normal).
>=20
> With this change, systemd-boot will show a "Reboot Into Firmware Interfa=
ce"
> option which will be able to drop back to u-boot. This can be useful if
> bootdelay is configured to be -2.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>   common/autoboot.c            |  4 +++-
>   include/efi_loader.h         |  2 ++
>   lib/efi_loader/efi_bootmgr.c | 45 ++++++++++++++++++++++++++++++++++++
>   lib/efi_loader/efi_setup.c   |  4 ++++
>   4 files changed, 54 insertions(+), 1 deletion(-)
>=20
> diff --git a/common/autoboot.c b/common/autoboot.c
> index 1783ef92c94c..b889407612dc 100644
> --- a/common/autoboot.c
> +++ b/common/autoboot.c
> @@ -11,6 +11,7 @@
>   #include <cli.h>
>   #include <command.h>
>   #include <console.h>
> +#include <efi_loader.h>
>   #include <env.h>
>   #include <errno.h>
>   #include <fdtdec.h>
> @@ -503,7 +504,8 @@ void autoboot_command(const char *s)
>   {
>   	debug("### main_loop: bootcmd=3D\"%s\"\n", s ? s : "<UNDEFINED>");
>  =20
> -	if (s && (stored_bootdelay =3D=3D -2 ||
> +	if (s && !(IS_ENABLED(CONFIG_EFI_BOOTMGR) && efi_should_abort_autoboot=
()) &&

I do not understand why the logic should depend on CONFIG_EFI_BOOTMGR=20
instead of CONFIG_EFI_LOADER. It seems applicable whenever we support UEFI=
.


> +	    (stored_bootdelay =3D=3D -2 ||
>   		 (stored_bootdelay !=3D -1 && !abortboot(stored_bootdelay)))) {
>   		bool lock;
>   		int prev;
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 3e70ac070550..449697ad13b3 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -583,6 +583,8 @@ efi_status_t efi_bootmgr_get_unused_bootoption(u16 *=
buf,
>   efi_status_t efi_bootmgr_update_media_device_boot_option(void);
>   /* Delete selected boot option */
>   efi_status_t efi_bootmgr_delete_boot_option(u16 boot_index);
> +/* Check if autoboot should be aborted based on EFI vars */
> +bool efi_should_abort_autoboot(void);
>   /* Invoke EFI boot manager */
>   efi_status_t efi_bootmgr_run(void *fdt);
>   /* search the boot option index in BootOrder */
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index a687f4d8e85c..39f255ac9de4 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -1290,6 +1290,51 @@ out:
>   	return ret;
>   }
>  =20
> +/**
> + * efi_should_abort_autoboot() - check if autoboot should be aborted pe=
r EFI vars

Please, mention the relevant flag.

> + *
> + * Return:	true if autoboot should abort
> + */
> +bool efi_should_abort_autoboot(void)
> +{
> +	efi_status_t ret;
> +	u64 os_indications =3D 0x0;
> +	efi_uintn_t size;
> +	efi_status_t r;
> +
> +	/* Initialize EFI drivers */
> +	ret =3D efi_init_obj_list();

@Ilias:

Essentially this ends up in always running  efi_init_obj_list() if we=20
have UEFI enabled.

Shouldn't we then replace all invocations of efi_init_obj_list() by a=20
single call after preboot but before EVT_POST_PREBOOT?

Best regards

Heinrich

> +	if (ret !=3D EFI_SUCCESS) {
> +		log_err("Error: Cannot initialize UEFI sub-system, r =3D %lu\n",
> +			ret & ~EFI_ERROR_MASK);
> +		return false;
> +	}
> +
> +	size =3D sizeof(os_indications);
> +	r =3D efi_get_variable_int(u"OsIndications", &efi_global_variable_guid=
,
> +				 NULL, &size, &os_indications, NULL);
> +	if (r !=3D EFI_SUCCESS || size !=3D sizeof(os_indications))
> +		return false;
> +
> +	if (!(os_indications & EFI_OS_INDICATIONS_BOOT_TO_FW_UI))
> +		return false;
> +
> +	/* Clear the BOOT_TO_FW_UI so next boot returns to normal */
> +	os_indications &=3D ~EFI_OS_INDICATIONS_BOOT_TO_FW_UI;
> +	r =3D efi_set_variable_int(u"OsIndications",
> +				 &efi_global_variable_guid,
> +				 EFI_VARIABLE_NON_VOLATILE |
> +				 EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +				 EFI_VARIABLE_RUNTIME_ACCESS,
> +				 sizeof(os_indications),
> +				 &os_indications, false);
> +
> +	if (r !=3D EFI_SUCCESS)
> +		log_err("Setting %ls failed\n", L"OsIndications");
> +
> +	return true;
> +}
> +
>   /**
>    * efi_bootmgr_run() - execute EFI boot manager
>    * @fdt:	Flat device tree
> diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> index f06cf49e4435..0ad02e9fe0dd 100644
> --- a/lib/efi_loader/efi_setup.c
> +++ b/lib/efi_loader/efi_setup.c
> @@ -156,6 +156,10 @@ static efi_status_t efi_init_os_indications(void)
>   {
>   	u64 os_indications_supported =3D 0;
>  =20
> +	if (IS_ENABLED(CONFIG_EFI_BOOTMGR))
> +		os_indications_supported |=3D
> +			EFI_OS_INDICATIONS_BOOT_TO_FW_UI;
> +
>   	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
>   		os_indications_supported |=3D
>   			EFI_OS_INDICATIONS_CAPSULE_RESULT_VAR_SUPPORTED;

