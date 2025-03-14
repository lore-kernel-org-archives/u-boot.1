Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD851C35FF1
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 17:54:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A46B80F16;
	Fri, 14 Mar 2025 18:54:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=bens.haus
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bens.haus header.i=@bens.haus header.b="Jmu7tK8L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09A3581EC0; Fri, 14 Mar 2025 18:35:28 +0100 (CET)
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D87E81E6C
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 18:35:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=bens.haus
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ben@bens.haus
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bens.haus;
 s=protonmail; t=1741973724; x=1742232924;
 bh=9bqLg0nXSrXdMsD0UXh0l+7J/Mqxsg42Xnz0ehI9IM8=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=Jmu7tK8LDzIFcNJQXIWqk2eaICzG7rymi16VoPUbN8B6fOflzoKwRt8ohKNmfknlE
 lxzjPB5MU9adHLD6+MnF4QqbbXp/uSx1l5kJwLCDKWieHCMrM5eepH4R7LIW2MpzS/
 OyY+l9z5Roy5DRQUu/kcxmZe/1xv8H9e+x32xY4Z1gR1h+rZ6lpaGyNKHmd2u268SW
 5OWVnIZidhOSzS5iCnvH16Lnx0PcMbAV+WQa4o7fAe841PomcL6Hh2SI+sI5y4OjGS
 HSi2Hrv5LIZR2f+ePMaTQvejUqRPJRdF2yJAyoh9f7KXtTnzLwbfwwoT7fr6tpCw1Z
 uI24LxT67qCiQ==
Date: Fri, 14 Mar 2025 17:35:17 +0000
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
From: Ben Schneider <ben@bens.haus>
Cc: xypron.glpk@gmx.de, ardb@kernel.org, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Baruch Siach <baruch@tkos.co.il>,
 Sam Protsenko <semen.protsenko@linaro.org>, Janne Grunau <j@jannau.net>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] lmb: change the return code on lmb_alloc_addr()
Message-ID: <at3MKdVWObOe2t0ulEO_390BtudxQ52-_iW2VGgpz0spI-UhNxRfC9TCtcUduXUIHSuBPt7vTR3iC4bOhT1IZTyI9hKIrHhBt8-82P4PIqM=@bens.haus>
In-Reply-To: <20250314105703.277315-1-ilias.apalodimas@linaro.org>
References: <20250314105703.277315-1-ilias.apalodimas@linaro.org>
Feedback-ID: 124562356:user:proton
X-Pm-Message-ID: ce6ce8880229ce3d99ca382cc17cf6ee34b4993f
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 14 Mar 2025 18:54:54 +0100
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

On Friday, March 14th, 2025 at 3:57 AM, Ilias Apalodimas <ilias.apalodimas@=
linaro.org> wrote:

>=20
>=20
> Ben reports a failure to boot the kernel on hardware that starts its
> physical memory from 0x0.
> The reason is that lmb_alloc_addr(), which is supposed to reserve a
> specific address, takes the address as the first argument, but then also
> returns the address for success or failure and treats 0 as a failure.
>=20
> Since we already know the address change the prototype to return an int.
>=20
> Reported-by: Ben Schneider ben@bens.haus
>=20
> Signed-off-by: Ilias Apalodimas ilias.apalodimas@linaro.org
>=20
> ---
> fs/fs.c | 2 +-
> include/lmb.h | 6 ++---
> lib/efi_loader/efi_memory.c | 3 +--
> lib/lmb.c | 6 ++---
> test/lib/lmb.c | 53 +++++++++++++++++++------------------
> 5 files changed, 35 insertions(+), 35 deletions(-)
>=20
> diff --git a/fs/fs.c b/fs/fs.c
> index 99ddcc5e37be..1ed7c0f2d2c7 100644
> --- a/fs/fs.c
> +++ b/fs/fs.c
> @@ -554,7 +554,7 @@ static int fs_read_lmb_check(const char filename, ulo=
ng addr, loff_t offset,
>=20
> lmb_dump_all();
>=20
> - if (lmb_alloc_addr(addr, read_len, LMB_NONE) =3D=3D addr)
> + if (!lmb_alloc_addr(addr, read_len, LMB_NONE))
> return 0;
>=20
> log_err("* Reading file would overwrite reserved memory \n");
> diff --git a/include/lmb.h b/include/lmb.h
> index 09297a4f530a..0d316c64c0a3 100644
> --- a/include/lmb.h
> +++ b/include/lmb.h
> @@ -135,9 +135,9 @@ phys_addr_t lmb_alloc_base(phys_size_t size, ulong al=
ign, phys_addr_t max_addr,
> * parameter. The base parameter is used to specify the base address
> * of the requested region.
> *
> - * Return: Base address on success, 0 on error.
> + * Return: 0 on success -1 on error
> /
> -phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size, u32 flags=
);
> +int lmb_alloc_addr(phys_addr_t base, phys_size_t size, u32 flags);
>=20
> /
> * lmb_is_reserved_flags() - Test if address is in reserved region with fl=
ag
> @@ -175,7 +175,7 @@ void lmb_pop(struct lmb store);
>=20
> static inline int lmb_read_check(phys_addr_t addr, phys_size_t len)
> {
> - return lmb_alloc_addr(addr, len, LMB_NONE) =3D=3D addr ? 0 : -1;
> + return lmb_alloc_addr(addr, len, LMB_NONE);
> }
>=20
> /
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 6d00b1862505..c39b53922bb4 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -491,8 +491,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_typ=
e type,
> return EFI_NOT_FOUND;
>=20
> addr =3D map_to_sysmem((void *)(uintptr_t)*memory);
> - addr =3D (u64)lmb_alloc_addr(addr, len, flags);
> - if (!addr)
> + if (lmb_alloc_addr(addr, len, flags))
> return EFI_NOT_FOUND;
> break;
> default:
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 93fc1bea07cd..61bb13dc4e24 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -714,7 +714,7 @@ phys_addr_t lmb_alloc_base(phys_size_t size, ulong al=
ign, phys_addr_t max_addr,
> return alloc;
> }
>=20
> -phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size, u32 flags=
)
> +int lmb_alloc_addr(phys_addr_t base, phys_size_t size, u32 flags)
> {
> long rgn;
> struct lmb_region lmb_memory =3D lmb.available_mem.data;
> @@ -731,11 +731,11 @@ phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_s=
ize_t size, u32 flags)
> base + size - 1, 1)) {
> / ok, reserve the memory /
> if (!lmb_reserve(base, size, flags))
> - return base;
> + return 0;
> }
> }
>=20
> - return 0;
> + return -1;
> }
>=20
> / Return number of bytes from a given address that are free */
> diff --git a/test/lib/lmb.c b/test/lib/lmb.c
> index fcb5f1af532a..01b1c7fdedd0 100644
> --- a/test/lib/lmb.c
> +++ b/test/lib/lmb.c
> @@ -531,21 +531,21 @@ static int test_alloc_addr(struct unit_test_state u=
ts, const phys_addr_t ram)
>=20
> / Try to allocate a page twice */
> b =3D lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NONE);
> - ut_asserteq(b, alloc_addr_a);
> - b =3D lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NOOVERWRITE);
> ut_asserteq(b, 0);
> + b =3D lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NOOVERWRITE);
> + ut_asserteq(b, -1);
> b =3D lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NONE);
> - ut_asserteq(b, alloc_addr_a);
> + ut_asserteq(b, 0);
> b =3D lmb_alloc_addr(alloc_addr_a, 0x2000, LMB_NONE);
> - ut_asserteq(b, alloc_addr_a);
> + ut_asserteq(b, 0);
> ret =3D lmb_free(alloc_addr_a, 0x2000);
> ut_asserteq(ret, 0);
> b =3D lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NOOVERWRITE);
> - ut_asserteq(b, alloc_addr_a);
> - b =3D lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NONE);
> ut_asserteq(b, 0);
> + b =3D lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NONE);
> + ut_asserteq(b, -1);
> b =3D lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NOOVERWRITE);
> - ut_asserteq(b, 0);
> + ut_asserteq(b, -1);
> ret =3D lmb_free(alloc_addr_a, 0x1000);
> ut_asserteq(ret, 0);
>=20
> @@ -561,22 +561,22 @@ static int test_alloc_addr(struct unit_test_state u=
ts, const phys_addr_t ram)
>=20
> / allocate blocks */
> a =3D lmb_alloc_addr(ram, alloc_addr_a - ram, LMB_NONE);
> - ut_asserteq(a, ram);
> + ut_asserteq(a, 0);
> ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 3, ram, 0x8010000,
> alloc_addr_b, 0x10000, alloc_addr_c, 0x10000);
> b =3D lmb_alloc_addr(alloc_addr_a + 0x10000,
> alloc_addr_b - alloc_addr_a - 0x10000, LMB_NONE);
> - ut_asserteq(b, alloc_addr_a + 0x10000);
> + ut_asserteq(b, 0);
> ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, ram, 0x10010000,
> alloc_addr_c, 0x10000, 0, 0);
> c =3D lmb_alloc_addr(alloc_addr_b + 0x10000,
> alloc_addr_c - alloc_addr_b - 0x10000, LMB_NONE);
> - ut_asserteq(c, alloc_addr_b + 0x10000);
> + ut_asserteq(c, 0);
> ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, 0x18010000,
> 0, 0, 0, 0);
> d =3D lmb_alloc_addr(alloc_addr_c + 0x10000,
> ram_end - alloc_addr_c - 0x10000, LMB_NONE);
> - ut_asserteq(d, alloc_addr_c + 0x10000);
> + ut_asserteq(d, 0);
> ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, ram_size,
> 0, 0, 0, 0);
>=20
> @@ -586,57 +586,58 @@ static int test_alloc_addr(struct unit_test_state u=
ts, const phys_addr_t ram)
> ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, ram_size,
> 0, 0, 0, 0);
>=20
> - ret =3D lmb_free(d, ram_end - alloc_addr_c - 0x10000);
> + / free thge allocation from d /
> + ret =3D lmb_free(alloc_addr_c + 0x10000, ram_end - alloc_addr_c - 0x100=
00);
> ut_asserteq(ret, 0);
>=20
> / allocate at 3 points in free range /
>=20
> d =3D lmb_alloc_addr(ram_end - 4, 4, LMB_NONE);
> - ut_asserteq(d, ram_end - 4);
> + ut_asserteq(d, 0);
> ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, ram, 0x18010000,
> - d, 4, 0, 0);
> - ret =3D lmb_free(d, 4);
> + ram_end - 4, 4, 0, 0);
> + ret =3D lmb_free(ram_end - 4, 4);
> ut_asserteq(ret, 0);
> ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, 0x18010000,
> 0, 0, 0, 0);
>=20
> d =3D lmb_alloc_addr(ram_end - 128, 4, LMB_NONE);
> - ut_asserteq(d, ram_end - 128);
> + ut_asserteq(d, 0);
> ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, ram, 0x18010000,
> - d, 4, 0, 0);
> - ret =3D lmb_free(d, 4);
> + ram_end - 128, 4, 0, 0);
> + ret =3D lmb_free(ram_end - 128, 4);
> ut_asserteq(ret, 0);
> ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, 0x18010000,
> 0, 0, 0, 0);
>=20
> d =3D lmb_alloc_addr(alloc_addr_c + 0x10000, 4, LMB_NONE);
> - ut_asserteq(d, alloc_addr_c + 0x10000);
> + ut_asserteq(d, 0);
> ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, 0x18010004,
> 0, 0, 0, 0);
> - ret =3D lmb_free(d, 4);
> + ret =3D lmb_free(alloc_addr_c + 0x10000, 4);
> ut_asserteq(ret, 0);
> ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, 0x18010000,
> 0, 0, 0, 0);
>=20
> - / allocate at the bottom /
> - ret =3D lmb_free(a, alloc_addr_a - ram);
> + / allocate at the bottom a was assigned to ram at the top /
> + ret =3D lmb_free(ram, alloc_addr_a - ram);
> ut_asserteq(ret, 0);
> ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram + 0x8000000,
> 0x10010000, 0, 0, 0, 0);
>=20
> d =3D lmb_alloc_addr(ram, 4, LMB_NONE);
> - ut_asserteq(d, ram);
> - ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, d, 4,
> + ut_asserteq(d, 0);
> + ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, ram, 4,
> ram + 0x8000000, 0x10010000, 0, 0);
>=20
> / check that allocating outside memory fails */
> if (ram_end !=3D 0) {
> ret =3D lmb_alloc_addr(ram_end, 1, LMB_NONE);
> - ut_asserteq(ret, 0);
> + ut_asserteq(ret, -1);
> }
> if (ram !=3D 0) {
> ret =3D lmb_alloc_addr(ram - 1, 1, LMB_NONE);
> - ut_asserteq(ret, 0);
> + ut_asserteq(ret, -1);
> }
>=20
> lmb_pop(&store);
> --
> 2.47.2

Tested-by: Ben Schneider <ben@bens.haus>
