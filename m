Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C68CE77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 11:48:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87F5C894E5;
	Sun,  8 Dec 2024 12:48:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="qePiE2jd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49E1489515; Sun,  8 Dec 2024 12:48:02 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18E3C894B7
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 12:48:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1733658473; x=1734263273; i=xypron.glpk@gmx.de;
 bh=OBNuEVNa9lqAflI/m8PtOaeA2przcl/YCbnnk6/bL3s=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=qePiE2jdz4eGHsknOlpKGjI8PXFMzMyf5BraZpcM95gvDr1UMpVxs5MO5ag2xVrb
 gPyHds2jIgvJtrxoZnmgfmNK+HZI36KXtHu/UjLnADn73VKVDYbES3Zjdxvf0l+Dk
 qfjm2zLWAlG0FmiDgIzu2mNX6ZXRm9uL0ShlY11/M70Axq6/Z6SYZhBpf0J1vcebX
 zF0xj5JdedWBNGC4+MutUEqL/nuLnzIGWl/ZsUHLrF91QjfrXRJmKNaJvbSUB37yY
 ukHeeAXaz76xpOvYbWSkBzECkP1LEon18gq6VYpkkYG946MvM9VhQ++cChx5FcbQQ
 Po2YYW5eqzII9YEfIA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhlKs-1tovov1mWO-00iZaJ; Sun, 08
 Dec 2024 12:47:53 +0100
Date: Sun, 08 Dec 2024 12:47:48 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, trini@konsulko.com
CC: =?ISO-8859-1?Q?Marek_Beh=FAn?= <kabel@kernel.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Baruch Siach <baruch@tkos.co.il>, Nam Cao <namcao@linutronix.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Janne Grunau <j@jannau.net>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
Subject: Re: [RFC PATCH 3/7] lmb: Rename free_mem to available_mem
User-Agent: Thunderbird for Android
In-Reply-To: <20241208105223.2821049-4-ilias.apalodimas@linaro.org>
References: <20241208105223.2821049-1-ilias.apalodimas@linaro.org>
 <20241208105223.2821049-4-ilias.apalodimas@linaro.org>
Message-ID: <64AE6019-539C-4917-B6B1-96C65843F326@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z437tbD8KMZivL/A34dkzN9uRlpQ1MfLxskZPVpk6ZneURN5Lgl
 7y+ePAKwQyCMQCmypOaMo8AXKZtAPVHk7rJcdp6lR12Lqa2DT/dD8q7ZvmkBMYPbOnINjeU
 jUAbMrPfjU0kF1G3RtWTirQ5z+NTpuBX9XDHtyIjH2ykMMlRL25e8BztH4zA1aLcYh+TQTI
 T9bz90HQQKXmtz1nCvZdQ==
UI-OutboundReport: notjunk:1;M01:P0:A0OdcmRUU2k=;4pI5HveiQTmOi9rpCReALGxg3Ou
 P6hDCcKh/ttYgIa8uzlMmRERKuGr/uqXU3ocE2NAAHCyjX7atxqqXMAjA5L2xTpCTsxbyt8qI
 DelA1dVyO9ujhhLu5Joke6CN/8yexLGJy1TmpN1URLDcrVQxHi4sckSJRu5eECQ7OMn4LsWXS
 A0V42o22vH50BiCoAK6BpfpWuQKfnYop6lme6Mcvod+eTlhSbgrSAGRojAmpF7UA9qaNnASwu
 w1JBmwxag4lxNs5+NzPG8PGYp6us28l1ZVfJ5Ed10Ol84/aEB494cq1bgocDDH8aEQacykzfe
 wGLCp4YI4EsjszRh12bh4Ccs4eBfbAFc6NPkeZYpjEnXPGICpVVXIDELeJn3IwFa/0q+78/j/
 I/9uytANkwfcCDKUxxCw6EB/Xid9d2+CzF885PmEPdN0nbjiHBrHVAFmf7Ct6hxkqNWMqcreQ
 0VosrBKrUrpQu5GM9REq1friumv4qYoWiyxLdq5e1B77FEEjGrIeFeuGCTBJ9SUxSwlvMEET/
 W3r0rLtXRXsA09NxS4NoncZybmYoTk1clYLxPJSUQmOc7JQFmGJRpeMBo+qtLxmh1PGAp24ug
 aTtHhp9IKvNQkGxPNPCC/AA+TkNpHKhFWIwl/4t5A4LmiHc5JejYlWargep6Q8HodI7ZSKQTx
 q+Scf04rNx2o1rP8cbmCDupAFRoL+p9DCVZUyfew1hoCpzUBepJ1Fpu6rSvobm9sT4neueXNL
 FKryOo8hpORcr3GOAWEfKE1/vrmmjbB/B5bqxri0AilMYcpaBV3B//iq+PzxaL2jpReo9Ki4w
 odywFyQPyBeuDz8UcybqVY/ybJyw21ZgU+kEI3NwYkYpyTXOpVKPMr8oZknXjW8s5eYp7ekPU
 Pnc8NNoRmTGk/toU3egxrZTJAwhVGx7U2GVhe6b4bpsqgXHjW+AX3+vlQ3X/6aIl1vdzoH2nP
 uczIxtSnMu4sUv5+LP/gSlKuGgwsIUoesk0wNot8ti+Xa4SIwvsL9a+uCXar6xOzOtdaCwMsl
 NB1mfoEMFlfXwCotK/9MtFRf+aqwOd1pc46mtkXTFgH5bWz1K2NuAcRuJPIAMzwKqKt975N10
 fPeVVGAuoAJ591WkbpkGjUyZxGRL+1
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

Am 8=2E Dezember 2024 11:52:06 MEZ schrieb Ilias Apalodimas <ilias=2Eapalod=
imas@linaro=2Eorg>:
>free_mem is a misnomer=2E We never update that with the actual free
>memory=2E Instead this field describes all available memory and it's
>checked against used_mem to decide if a memory area is free or not=2E
>So rename it to something that better describes its usage=2E
>
>Signed-off-by: Ilias Apalodimas <ilias=2Eapalodimas@linaro=2Eorg>
>---
> include/lmb=2Eh     |  4 ++--
> lib/lmb=2Ec         | 34 +++++++++++++++++-----------------
> test/cmd/bdinfo=2Ec |  2 +-
> test/lib/lmb=2Ec    |  2 +-
> 4 files changed, 21 insertions(+), 21 deletions(-)
>
>diff --git a/include/lmb=2Eh b/include/lmb=2Eh
>index 62882464f866=2E=2E54af5b0e4b44 100644
>--- a/include/lmb=2Eh
>+++ b/include/lmb=2Eh
>@@ -47,12 +47,12 @@ struct lmb_region {
> /**
>  * struct lmb - The LMB structure
>  *
>- * @free_mem:	List of free memory regions
>+ * @free_mem:	List of all available memory

%s/free/available/

>  * @used_mem:	List of used/reserved memory regions
>  * @test:	Is structure being used for LMB tests
>  */
> struct lmb {
>-	struct alist free_mem;
>+	struct alist available_mem;
> 	struct alist used_mem;
> 	bool test;
> };
>diff --git a/lib/lmb=2Ec b/lib/lmb=2Ec
>index c7bf5120696f=2E=2Effdd23d87b9b 100644
>--- a/lib/lmb=2Ec
>+++ b/lib/lmb=2Ec
>@@ -350,7 +350,7 @@ int io_lmb_setup(struct lmb *io_lmb)
> {
> 	int ret;
>
>-	ret =3D alist_init(&io_lmb->free_mem, sizeof(struct lmb_region),
>+	ret =3D alist_init(&io_lmb->available_mem, sizeof(struct lmb_region),
> 			 (uint)LMB_ALIST_INITIAL_SIZE);
> 	if (!ret) {
> 		log_debug("Unable to initialise the list for LMB free IOVA\n");
>@@ -371,13 +371,13 @@ int io_lmb_setup(struct lmb *io_lmb)
>
> void io_lmb_teardown(struct lmb *io_lmb)
> {
>-	alist_uninit(&io_lmb->free_mem);
>+	alist_uninit(&io_lmb->available_mem);
> 	alist_uninit(&io_lmb->used_mem);
> }
>
> long io_lmb_add(struct lmb *io_lmb, phys_addr_t base, phys_size_t size)
> {
>-	return lmb_add_region_flags(&io_lmb->free_mem, base, size, LMB_NONE);
>+	return lmb_add_region_flags(&io_lmb->available_mem, base, size, LMB_NON=
E);
> }
>
> /* derived and simplified from _lmb_alloc_base() */
>@@ -387,9 +387,9 @@ phys_addr_t io_lmb_alloc(struct lmb *io_lmb, phys_siz=
e_t size, ulong align)
> 	phys_addr_t base =3D 0;
> 	phys_addr_t res_base;
> 	struct lmb_region *lmb_used =3D io_lmb->used_mem=2Edata;
>-	struct lmb_region *lmb_memory =3D io_lmb->free_mem=2Edata;
>+	struct lmb_region *lmb_memory =3D io_lmb->available_mem=2Edata;
>
>-	for (i =3D io_lmb->free_mem=2Ecount - 1; i >=3D 0; i--) {
>+	for (i =3D io_lmb->available_mem=2Ecount - 1; i >=3D 0; i--) {
> 		phys_addr_t lmbbase =3D lmb_memory[i]=2Ebase;
> 		phys_size_t lmbsize =3D lmb_memory[i]=2Esize;
>
>@@ -514,7 +514,7 @@ static void lmb_dump_region(struct alist *lmb_rgn_lst=
, char *name)
> void lmb_dump_all_force(void)
> {
> 	printf("lmb_dump_all:\n");
>-	lmb_dump_region(&lmb=2Efree_mem, "memory");
>+	lmb_dump_region(&lmb=2Eavailable_mem, "memory");
> 	lmb_dump_region(&lmb=2Eused_mem, "reserved");
> }
>
>@@ -650,7 +650,7 @@ static long lmb_add_region(struct alist *lmb_rgn_lst,=
 phys_addr_t base,
> long lmb_add(phys_addr_t base, phys_size_t size)
> {
> 	long ret;
>-	struct alist *lmb_rgn_lst =3D &lmb=2Efree_mem;
>+	struct alist *lmb_rgn_lst =3D &lmb=2Eavailable_mem;
>
> 	ret =3D lmb_add_region(lmb_rgn_lst, base, size);
> 	if (ret)
>@@ -706,9 +706,9 @@ static phys_addr_t _lmb_alloc_base(phys_size_t size, =
ulong align,
> 	phys_addr_t base =3D 0;
> 	phys_addr_t res_base;
> 	struct lmb_region *lmb_used =3D lmb=2Eused_mem=2Edata;
>-	struct lmb_region *lmb_memory =3D lmb=2Efree_mem=2Edata;
>+	struct lmb_region *lmb_memory =3D lmb=2Eavailable_mem=2Edata;
>
>-	for (i =3D lmb=2Efree_mem=2Ecount - 1; i >=3D 0; i--) {
>+	for (i =3D lmb=2Eavailable_mem=2Ecount - 1; i >=3D 0; i--) {
> 		phys_addr_t lmbbase =3D lmb_memory[i]=2Ebase;
> 		phys_size_t lmbsize =3D lmb_memory[i]=2Esize;
>
>@@ -800,10 +800,10 @@ static phys_addr_t _lmb_alloc_addr(phys_addr_t base=
, phys_size_t size,
> 				    enum lmb_flags flags)
> {
> 	long rgn;
>-	struct lmb_region *lmb_memory =3D lmb=2Efree_mem=2Edata;
>+	struct lmb_region *lmb_memory =3D lmb=2Eavailable_mem=2Edata;
>
> 	/* Check if the requested address is in one of the memory regions */
>-	rgn =3D lmb_overlaps_region(&lmb=2Efree_mem, base, size);
>+	rgn =3D lmb_overlaps_region(&lmb=2Eavailable_mem, base, size);
> 	if (rgn >=3D 0) {
> 		/*
> 		 * Check if the requested end address is in the same memory
>@@ -854,10 +854,10 @@ phys_size_t lmb_get_free_size(phys_addr_t addr)
> 	int i;
> 	long rgn;
> 	struct lmb_region *lmb_used =3D lmb=2Eused_mem=2Edata;
>-	struct lmb_region *lmb_memory =3D lmb=2Efree_mem=2Edata;
>+	struct lmb_region *lmb_memory =3D lmb=2Eavailable_mem=2Edata;
>
> 	/* check if the requested address is in the memory regions */
>-	rgn =3D lmb_overlaps_region(&lmb=2Efree_mem, addr, 1);
>+	rgn =3D lmb_overlaps_region(&lmb=2Eavailable_mem, addr, 1);
> 	if (rgn >=3D 0) {
> 		for (i =3D 0; i < lmb=2Eused_mem=2Ecount; i++) {
> 			if (addr < lmb_used[i]=2Ebase) {
>@@ -871,8 +871,8 @@ phys_size_t lmb_get_free_size(phys_addr_t addr)
> 			}
> 		}
> 		/* if we come here: no reserved ranges above requested addr */
>-		return lmb_memory[lmb=2Efree_mem=2Ecount - 1]=2Ebase +
>-		       lmb_memory[lmb=2Efree_mem=2Ecount - 1]=2Esize - addr;
>+		return lmb_memory[lmb=2Eavailable_mem=2Ecount - 1]=2Ebase +
>+		       lmb_memory[lmb=2Eavailable_mem=2Ecount - 1]=2Esize - addr;
> 	}
> 	return 0;
> }
>@@ -895,7 +895,7 @@ static int lmb_setup(bool test)
> {
> 	bool ret;
>
>-	ret =3D alist_init(&lmb=2Efree_mem, sizeof(struct lmb_region),
>+	ret =3D alist_init(&lmb=2Eavailable_mem, sizeof(struct lmb_region),
> 			 (uint)LMB_ALIST_INITIAL_SIZE);
> 	if (!ret) {
> 		log_debug("Unable to initialise the list for LMB free memory\n");
>@@ -967,7 +967,7 @@ int lmb_push(struct lmb *store)
>
> void lmb_pop(struct lmb *store)
> {
>-	alist_uninit(&lmb=2Efree_mem);
>+	alist_uninit(&lmb=2Eavailable_mem);
> 	alist_uninit(&lmb=2Eused_mem);
> 	lmb =3D *store;
> }
>diff --git a/test/cmd/bdinfo=2Ec b/test/cmd/bdinfo=2Ec
>index bb419ab2394e=2E=2Ee5b422ab2ba8 100644
>--- a/test/cmd/bdinfo=2Ec
>+++ b/test/cmd/bdinfo=2Ec
>@@ -131,7 +131,7 @@ static int lmb_test_dump_all(struct unit_test_state *=
uts)
> 	struct lmb *lmb =3D lmb_get();
>
> 	ut_assert_nextline("lmb_dump_all:");
>-	ut_assertok(lmb_test_dump_region(uts, &lmb->free_mem, "memory"));
>+	ut_assertok(lmb_test_dump_region(uts, &lmb->available_mem, "memory"));
> 	ut_assertok(lmb_test_dump_region(uts, &lmb->used_mem, "reserved"));
>
> 	return 0;
>diff --git a/test/lib/lmb=2Ec b/test/lib/lmb=2Ec
>index 8af5dcad2ecc=2E=2E0f7052224c10 100644
>--- a/test/lib/lmb=2Ec
>+++ b/test/lib/lmb=2Ec
>@@ -65,7 +65,7 @@ static int setup_lmb_test(struct unit_test_state *uts, =
struct lmb *store,
>
> 	ut_assertok(lmb_push(store));
> 	lmb =3D lmb_get();
>-	*mem_lstp =3D &lmb->free_mem;
>+	*mem_lstp =3D &lmb->available_mem;
> 	*used_lstp =3D &lmb->used_mem;
>
> 	return 0;
>--
>2=2E45=2E2
>

