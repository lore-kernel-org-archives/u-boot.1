Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 468ECC27C5F
	for <u-boot@archiver.kernel.org>; Sat,  8 Jun 2024 04:39:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6886C87F8D;
	Sat,  8 Jun 2024 06:39:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="PoIqPQvW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BDA08839C; Sat,  8 Jun 2024 06:39:24 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F51C87F68
 for <u-boot@lists.denx.de>; Sat,  8 Jun 2024 06:39:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1717821560; x=1718426360; i=xypron.glpk@gmx.de;
 bh=MCLnYWhr8RIGZfErzNn7zSdK4Spz8T+TaWJ6Zj8Y6CE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=PoIqPQvWEwP48PA56TP97Cx9CKoLhWlGKXBxBMStR92/27SxJuBRLAzzVSmE3wi5
 QG8LwXlcjl21AlUAQZT6RDmv5zp0tpENdx13M9qBxj+EPJSGrJU3fyRlA4++S1EuN
 ZPFWjzeV/3lEfq3I3hn0ccTh6jBIc3SihPT5UaLi0F7bfj09TGAfDbF3he10vS51b
 NqsMevPb7fUKWA8KD+0S9rueo4+jdXwZmvZr9+ZP1b5wXD0K5lHKZZiUNyH5YqyC/
 aUaLlj7Y78WQRjafjdkG2Rp4VZ+4a6ip6PjjQF94Nyir3t1QxMM0EQOLRljIr+i1R
 AscaaNsmIcavuz5cwg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.107] ([109.42.178.114]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N17UQ-1sQ1TO0n4k-00zunO; Sat, 08
 Jun 2024 06:39:20 +0200
Message-ID: <6098d0ed-f641-483a-8cf7-6711e2ab663d@gmx.de>
Date: Sat, 8 Jun 2024 06:39:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 26/31] test: lmb: run lmb tests only manually
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>,
 u-boot@lists.denx.de
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-27-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240607185240.1892031-27-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sevpkSQPBedoN3U3P3UkxNRkdnTlDr//nBeUZ+FHwTaQT1R5UNP
 BRw6ZF6/Ejd5JOOmf+xi26ZivfaEQ/kGrTHj+WbwYce1MMIlCNU9fDtz63/gTb/gxWUVxji
 Dt8oNaKXSx8fWDCh+VfBeojlMovayam9eOmqPuE+XUEjwynbVcwrWr2NSyFyuNuThtW/Ho3
 cJF469IT4EwQPW1sCF4RQ==
UI-OutboundReport: notjunk:1;M01:P0:Rr8I2TqmodU=;Nr8qiW2mlP437DXDoq7ewTqLlEi
 HGY+TNNPVL/GLCfKAee4jh6RBafGELl3AG4p3kQKsvRpXI2SRrLq5BBs6KhN6fsmcAdP82mdG
 avUC43Y7FdXp7MfOq0ma/c/rzpqePFbnqGM3qxrjZ7YqBeltG/uXY/x6Yqj+HvvJNfuJJtx7P
 kTCjF+cgJGZ1+C6ZNarXa2CHo0Cna/p05qScvNHrH+oLp+aE1bjOACCvbh679Nb0QJUrlLvUY
 iBGr7tQnYLDwyKMDipmZfID8PYvResSVerKHh8r/QWhNBMf1zYl6rMGpk0wJzvYxIPCeQTWwS
 0qXe8CSAWVeRNOhRfM02XIugQuIo47nN4Ujqnti8ozxWrKVZiYP3q8RZBneiQKMQO0eaVSYKf
 ZILcMZ1YAIaSLUFzV4yRhJnofpulO427NMxCkv+kvQdu6EPCHr1XB+x6OMLwCkZHBl6L0QL4m
 felpUFvQ7RtHMRcZTs3dKGYxNmt8qhrYZnrEJvCumF+NYJVTmfKoKKHPabYFppGTgFaepi1mG
 0Nswc53vyIX2+UQmTuGg4C4UqKSyybrY0U06Vsx6pC5/mA+bqYVbmh15Gb/EOvZdbxYRPUq4D
 dSpPubsMujAwOgeMqnl23AfMBdXg0HcRYtTkYiq4lPrzh8gyGqv4bAU6COWt0oOjE0njZ8dfp
 EWuCQLeRD2s4KDsEYL1OAgRfOKgXNxz+Cr+3hPvX64ir/CBU1YzXKeAgOCLO2ssjHFRfr/G47
 tjH93B28ozf2QWc3IG5KjsaZFjQlc/fuSkLoNPgWB3t9v3CDlnanwPuwk5oSR9AtmPi3omIaY
 IZ6WkvWawCLk/aTpNNsHXBBo6zATcylc+5eJAomCZ4klc=
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

On 6/7/24 20:52, Sughosh Ganu wrote:
> The LMB code has been changed so that the memory reservations and
> allocations are now persistent and global. With this change, the
> design of the LMB tests needs to be changed accordingly. For now, mark
> the LMB tests to be run only manually. The tests won't be run as part
> of the unit test suite, and thus would not interfere with the running
> of the rest of the tests.

We should run important tests in the CI.

You could trigger the 'manual' test from a Python test and reboot the
system to get into an initial state.

Best regards

Heinrich

>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>   test/lib/lmb.c | 49 ++++++++++++++++++++++++-------------------------
>   1 file changed, 24 insertions(+), 25 deletions(-)
>
> diff --git a/test/lib/lmb.c b/test/lib/lmb.c
> index 67a6be5bc3..813f7e3100 100644
> --- a/test/lib/lmb.c
> +++ b/test/lib/lmb.c
> @@ -195,7 +195,7 @@ static int test_multi_alloc_512mb_x2(struct unit_tes=
t_state *uts,
>   }
>
>   /* Create a memory region with one reserved region and allocate */
> -static int lib_test_lmb_simple(struct unit_test_state *uts)
> +static int lib_test_lmb_simple_norun(struct unit_test_state *uts)
>   {
>   	int ret;
>
> @@ -207,10 +207,10 @@ static int lib_test_lmb_simple(struct unit_test_st=
ate *uts)
>   	/* simulate 512 MiB RAM beginning at 1.5GiB */
>   	return test_multi_alloc_512mb(uts, 0xE0000000);
>   }
> -LIB_TEST(lib_test_lmb_simple, 0);
> +LIB_TEST(lib_test_lmb_simple_norun, UT_TESTF_MANUAL);
>
>   /* Create two memory regions with one reserved region and allocate */
> -static int lib_test_lmb_simple_x2(struct unit_test_state *uts)
> +static int lib_test_lmb_simple_x2_norun(struct unit_test_state *uts)
>   {
>   	int ret;
>
> @@ -222,7 +222,7 @@ static int lib_test_lmb_simple_x2(struct unit_test_s=
tate *uts)
>   	/* simulate 512 MiB RAM beginning at 3.5GiB and 1 GiB */
>   	return test_multi_alloc_512mb_x2(uts, 0xE0000000, 0x40000000);
>   }
> -LIB_TEST(lib_test_lmb_simple_x2, 0);
> +LIB_TEST(lib_test_lmb_simple_x2_norun, UT_TESTF_MANUAL);
>
>   /* Simulate 512 MiB RAM, allocate some blocks that fit/don't fit */
>   static int test_bigblock(struct unit_test_state *uts, const phys_addr_=
t ram)
> @@ -275,7 +275,7 @@ static int test_bigblock(struct unit_test_state *uts=
, const phys_addr_t ram)
>   	return 0;
>   }
>
> -static int lib_test_lmb_big(struct unit_test_state *uts)
> +static int lib_test_lmb_big_norun(struct unit_test_state *uts)
>   {
>   	int ret;
>
> @@ -287,7 +287,7 @@ static int lib_test_lmb_big(struct unit_test_state *=
uts)
>   	/* simulate 512 MiB RAM beginning at 1.5GiB */
>   	return test_bigblock(uts, 0xE0000000);
>   }
> -LIB_TEST(lib_test_lmb_big, 0);
> +LIB_TEST(lib_test_lmb_big_norun, UT_TESTF_MANUAL);
>
>   /* Simulate 512 MiB RAM, allocate a block without previous reservation=
 */
>   static int test_noreserved(struct unit_test_state *uts, const phys_add=
r_t ram,
> @@ -348,7 +348,7 @@ static int test_noreserved(struct unit_test_state *u=
ts, const phys_addr_t ram,
>   	return 0;
>   }
>
> -static int lib_test_lmb_noreserved(struct unit_test_state *uts)
> +static int lib_test_lmb_noreserved_norun(struct unit_test_state *uts)
>   {
>   	int ret;
>
> @@ -360,10 +360,9 @@ static int lib_test_lmb_noreserved(struct unit_test=
_state *uts)
>   	/* simulate 512 MiB RAM beginning at 1.5GiB */
>   	return test_noreserved(uts, 0xE0000000, 4, 1);
>   }
> +LIB_TEST(lib_test_lmb_noreserved_norun, UT_TESTF_MANUAL);
>
> -LIB_TEST(lib_test_lmb_noreserved, 0);
> -
> -static int lib_test_lmb_unaligned_size(struct unit_test_state *uts)
> +static int lib_test_lmb_unaligned_size_norun(struct unit_test_state *ut=
s)
>   {
>   	int ret;
>
> @@ -375,13 +374,13 @@ static int lib_test_lmb_unaligned_size(struct unit=
_test_state *uts)
>   	/* simulate 512 MiB RAM beginning at 1.5GiB */
>   	return test_noreserved(uts, 0xE0000000, 5, 8);
>   }
> -LIB_TEST(lib_test_lmb_unaligned_size, 0);
> +LIB_TEST(lib_test_lmb_unaligned_size_norun, UT_TESTF_MANUAL);
>
>   /*
>    * Simulate a RAM that starts at 0 and allocate down to address 0, whi=
ch must
>    * fail as '0' means failure for the lmb_alloc functions.
>    */
> -static int lib_test_lmb_at_0(struct unit_test_state *uts)
> +static int lib_test_lmb_at_0_norun(struct unit_test_state *uts)
>   {
>   	const phys_addr_t ram =3D 0;
>   	const phys_size_t ram_size =3D 0x20000000;
> @@ -417,9 +416,9 @@ static int lib_test_lmb_at_0(struct unit_test_state =
*uts)
>
>   	return 0;
>   }
> -LIB_TEST(lib_test_lmb_at_0, 0);
> +LIB_TEST(lib_test_lmb_at_0_norun, UT_TESTF_MANUAL);
>
> -static int lib_test_lmb_overlapping_add(struct unit_test_state *uts)
> +static int lib_test_lmb_overlapping_add_norun(struct unit_test_state *u=
ts)
>   {
>   	const phys_addr_t ram =3D 0x40000000;
>   	const phys_size_t ram_size =3D 0x20000000;
> @@ -433,10 +432,10 @@ static int lib_test_lmb_overlapping_add(struct uni=
t_test_state *uts)
>
>   	return 0;
>   }
> -LIB_TEST(lib_test_lmb_overlapping_add, 0);
> +LIB_TEST(lib_test_lmb_overlapping_add_norun, UT_TESTF_MANUAL);
>
>   /* Check that calling lmb_reserve with overlapping regions fails. */
> -static int lib_test_lmb_overlapping_reserve(struct unit_test_state *uts=
)
> +static int lib_test_lmb_overlapping_reserve_norun(struct unit_test_stat=
e *uts)
>   {
>   	const phys_addr_t ram =3D 0x40000000;
>   	const phys_size_t ram_size =3D 0x20000000;
> @@ -480,7 +479,7 @@ static int lib_test_lmb_overlapping_reserve(struct u=
nit_test_state *uts)
>   		   0, 0, 0, 0);
>   	return 0;
>   }
> -LIB_TEST(lib_test_lmb_overlapping_reserve, 0);
> +LIB_TEST(lib_test_lmb_overlapping_reserve_norun, UT_TESTF_MANUAL);
>
>   /*
>    * Simulate 512 MiB RAM, reserve 3 blocks, allocate addresses in betwe=
en.
> @@ -596,7 +595,7 @@ static int test_alloc_addr(struct unit_test_state *u=
ts, const phys_addr_t ram)
>   	return 0;
>   }
>
> -static int lib_test_lmb_alloc_addr(struct unit_test_state *uts)
> +static int lib_test_lmb_alloc_addr_norun(struct unit_test_state *uts)
>   {
>   	int ret;
>
> @@ -608,7 +607,7 @@ static int lib_test_lmb_alloc_addr(struct unit_test_=
state *uts)
>   	/* simulate 512 MiB RAM beginning at 1.5GiB */
>   	return test_alloc_addr(uts, 0xE0000000);
>   }
> -LIB_TEST(lib_test_lmb_alloc_addr, 0);
> +LIB_TEST(lib_test_lmb_alloc_addr_norun, UT_TESTF_MANUAL);
>
>   /* Simulate 512 MiB RAM, reserve 3 blocks, check addresses in between =
*/
>   static int test_get_unreserved_size(struct unit_test_state *uts,
> @@ -665,7 +664,7 @@ static int test_get_unreserved_size(struct unit_test=
_state *uts,
>   	return 0;
>   }
>
> -static int lib_test_lmb_get_free_size(struct unit_test_state *uts)
> +static int lib_test_lmb_get_free_size_norun(struct unit_test_state *uts=
)
>   {
>   	int ret;
>
> @@ -677,10 +676,10 @@ static int lib_test_lmb_get_free_size(struct unit_=
test_state *uts)
>   	/* simulate 512 MiB RAM beginning at 1.5GiB */
>   	return test_get_unreserved_size(uts, 0xE0000000);
>   }
> -LIB_TEST(lib_test_lmb_get_free_size, 0);
> +LIB_TEST(lib_test_lmb_get_free_size_norun, UT_TESTF_MANUAL);
>
>   #ifdef CONFIG_LMB_USE_MAX_REGIONS
> -static int lib_test_lmb_max_regions(struct unit_test_state *uts)
> +static int lib_test_lmb_max_regions_norun(struct unit_test_state *uts)
>   {
>   	const phys_addr_t ram =3D 0x00000000;
>   	/*
> @@ -745,10 +744,10 @@ static int lib_test_lmb_max_regions(struct unit_te=
st_state *uts)
>
>   	return 0;
>   }
> -LIB_TEST(lib_test_lmb_max_regions, 0);
> +LIB_TEST(lib_test_lmb_max_regions_norun, UT_TESTF_MANUAL);
>   #endif
>
> -static int lib_test_lmb_flags(struct unit_test_state *uts)
> +static int lib_test_lmb_flags_norun(struct unit_test_state *uts)
>   {
>   	const phys_addr_t ram =3D 0x40000000;
>   	const phys_size_t ram_size =3D 0x20000000;
> @@ -832,4 +831,4 @@ static int lib_test_lmb_flags(struct unit_test_state=
 *uts)
>
>   	return 0;
>   }
> -LIB_TEST(lib_test_lmb_flags, 0);
> +LIB_TEST(lib_test_lmb_flags_norun, UT_TESTF_MANUAL);

