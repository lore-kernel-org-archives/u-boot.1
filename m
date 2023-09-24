Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75203CE7A88
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 13:51:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 205F586199;
	Sun, 24 Sep 2023 15:51:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="i/wm59Gm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72C3E8620C; Sun, 24 Sep 2023 15:51:52 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 472F985DFA
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 15:51:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695563503; x=1696168303; i=xypron.glpk@gmx.de;
 bh=/54q33m5j76NmAO4tXvd3TJbfEiA23gmoFO4LHlg+ns=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References;
 b=i/wm59Gmd8L0Z88zKwuzvwIn+CyH4taKkJVCE++fuRyl0t6IFn4OxCvLvMlCTusk+Cu5p3X7lgv
 g8Guy2NJxHN7FxCzfYIdTNIe2qcGIBsI8kYBybYSaJMwsLS19FhWAJrtz07qmCDuaB6/ROwpigqnt
 xQesdU8dAyjECRS7JxOu1/xaCjWm7Gq2LbTIO+6V7VB/5wV4XROzZcQ+sZxF3vy3wb8PttaoK8IIe
 jJ2LFk07D1Qe2bHaiiFDIzR/31CKwZLKETMirGIq8Z+dwKXFiWyGLobm0DUQkTyuIoKjbnv+ie193
 /r5+Sv0XT9QqOUA3ZGayq9bm1ZoTfslOXdKg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mi2O1-1rFbXq0jOD-00e19b; Sun, 24
 Sep 2023 15:51:43 +0200
Date: Sun, 24 Sep 2023 15:51:41 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Udit Kumar <u-kumar1@ti.com>, nm@ti.com, vigneshr@ti.com,
 patrick.delaunay@foss.st.com, sjoerd@collabora.com
CC: u-boot@lists.denx.de, michal.simek@amd.com, Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH] lmb: remove overlapping region with next range
User-Agent: K-9 Mail for Android
In-Reply-To: <20230924111832.3741245-1-u-kumar1@ti.com>
References: <20230924111832.3741245-1-u-kumar1@ti.com>
Message-ID: <57F0DE54-C8BF-4B48-9075-2D267DBA4924@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nrm60b+cBsUHGEIttNMQKD9AjgNJIHxS6eKK969ij5TUJ6khZQR
 G7sxsZMyGuODfSsb21hRok/ufzJPkjORRnfZjU6urEvArDYqZB8BVl1YcUNykwGR3EQNHmY
 vDnNtfpxjvjfXhka95dHrRUiV5Cfz7ZWzONNoqTnMP83KoNMrLE1otbQivl52wPXdvCSndM
 rseO5K2k/2WAbBR743rJw==
UI-OutboundReport: notjunk:1;M01:P0:o330aQxnO/Q=;Olqsn778m1mrAEE8lE1zdrcYXkR
 MSOBG0sW81297fo94kTwSeZfZnZeblV7EkoahoVdCV1riH/8anA7G8jICGbOdU/sWDlMJVqKb
 2wnpjl4yfJNbM/eTRxk0znt+0JgXh90eKHY2WYj5j9Zgy33AdvZkFAgY4K921Hosn5i/ovSsp
 SNQNfYvEnqREulszDhtv1nXJmw7MBnZ2g8BTb2kcfiFzogc2LVx0NexETLwhXKpcolmwj9mgG
 KZxtT5soLrrRHknDJh/ltLaEKj022QPnhvdes7LCUQYKW0TCWj7HDER25q8+kgT6nW0cULkY4
 I4Iz6JY7DVq/Goqkf4RV5j9iHwVFS8N1HciP8CdPlioEi8+V57CGf6eTNQa9WGe5mC6x0cmcy
 SDYCZZGEIkCPRaaovgccNjkaYHZA/zqNT4vM1jnif0MhQaK2NfysD3JwQRa17bmH8PrpW/1W8
 wpNPfesTDNYudDCe3zKLGg1QgJDM37gTWis/HX0fDaNoY6KqiY/BgQknPkI7OQCP+PUXcLoJp
 X5+EI4+ZpOh/GGWvkO+1pro10G3dQaNX+9zcOqtrVL3gkeI7jac8nOqvSCwONjixSjL/LAHUc
 udCEzWkGbe2EhxWKoqgKbSP3QMRMMg9RcACLE2YfZW5frFeir83qGM89hIOF77urB/PIIGRrg
 INeoldd6VSiOiPm7yRHbcxctLy+TIoKeWXQvehKAA6qPYDOwnYS6hMb4dLcomj2tGh1YFd7L4
 p/19v4xLhuWR596vTL1IdkvEhS0Am4KToUsIkAUnCq8conEQmE+pDAgUKaB3rkP/i0BsPMcSz
 Z+SMmEJbD/ji48ECmHJXEgJt82MqFzdan2F1Zbv5sjAKNZ5Ab+2v3GPu4TIbXiUZwHny6gtq+
 TBiJePcy7XDfHQuhMeY4G+k92SEXbOnqb99rmrRCu345FCTjHwtws9ZynZRazZJHZBvpMFOqg
 xj2kxBEC6G8YcgAH+zYxZ7KxUww=
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



Am 24=2E September 2023 13:18:32 MESZ schrieb Udit Kumar <u-kumar1@ti=2Eco=
m>:
>In case of new memory range to be added is coalesced
>with any already added non last lmb region=2E
>
>And there is possibility that, then region in which new memory
>range added is not adjacent to next region=2E But have some
>sections are overlapping=2E
>
>So along with adjacency check with next lmb region,
>check for overlap should be done=2E
>
>In case overlap  is found, adjust and merge these two lmb
>region into one=2E
>
>Reported-by: Suman Anna <s-anna@ti=2Ecom>
>Signed-off-by: Udit Kumar <u-kumar1@ti=2Ecom>
>---
>logs
>https://gist=2Egithub=2Ecom/uditkumarti/5d08c34442235ad270cfa863792ebcdc
>seqeunce : line 1 to 13
>without fix : line 96-100
>with fix : line 199-202
>
> lib/lmb=2Ec | 37 +++++++++++++++++++++++++++++++++----
> 1 file changed, 33 insertions(+), 4 deletions(-)
>
>diff --git a/lib/lmb=2Ec b/lib/lmb=2Ec
>index b2c233edb6=2E=2E2580d01d90 100644
>--- a/lib/lmb=2Ec
>+++ b/lib/lmb=2Ec
>@@ -74,6 +74,16 @@ static long lmb_addrs_adjacent(phys_addr_t base1, phys=
_size_t size1,
> 	return 0;
> }
>=20
>+static long lmb_regions_overlap(struct lmb_region *rgn, unsigned long r1=
,
>+				unsigned long r2)
>+{
>+	phys_addr_t base1 =3D rgn->region[r1]=2Ebase;
>+	phys_size_t size1 =3D rgn->region[r1]=2Esize;
>+	phys_addr_t base2 =3D rgn->region[r2]=2Ebase;
>+	phys_size_t size2 =3D rgn->region[r2]=2Esize;
>+
>+	return lmb_addrs_overlap(base1, size1, base2, size2);
>+}
> static long lmb_regions_adjacent(struct lmb_region *rgn, unsigned long r=
1,
> 				 unsigned long r2)
> {
>@@ -81,7 +91,6 @@ static long lmb_regions_adjacent(struct lmb_region *rgn=
, unsigned long r1,
> 	phys_size_t size1 =3D rgn->region[r1]=2Esize;
> 	phys_addr_t base2 =3D rgn->region[r2]=2Ebase;
> 	phys_size_t size2 =3D rgn->region[r2]=2Esize;
>-
> 	return lmb_addrs_adjacent(base1, size1, base2, size2);
> }
>=20
>@@ -105,6 +114,23 @@ static void lmb_coalesce_regions(struct lmb_region *=
rgn, unsigned long r1,
> 	lmb_remove_region(rgn, r2);
> }
>=20
>+/*Assmptuon : base addr of region 1 < base addr of region 2*/

Assumption

Regards Heinrich

>+static void lmb_fix_over_lap_regions(struct lmb_region *rgn, unsigned lo=
ng r1,
>+				     unsigned long r2)
>+{
>+	phys_addr_t base1 =3D rgn->region[r1]=2Ebase;
>+	phys_size_t size1 =3D rgn->region[r1]=2Esize;
>+	phys_addr_t base2 =3D rgn->region[r2]=2Ebase;
>+	phys_size_t size2 =3D rgn->region[r2]=2Esize;
>+
>+	if (base1 + size1 > base2 + size2) {
>+		printf("This will not be a case any time\n");
>+		return;
>+	}
>+	rgn->region[r1]=2Esize =3D base2 + size2 - base1;
>+	lmb_remove_region(rgn, r2);
>+}
>+
> void lmb_init(struct lmb *lmb)
> {
> #if IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)
>@@ -249,7 +275,6 @@ static long lmb_add_region_flags(struct lmb_region *r=
gn, phys_addr_t base,
> 		phys_size_t rgnflags =3D rgn->region[i]=2Eflags;
> 		phys_addr_t end =3D base + size - 1;
> 		phys_addr_t rgnend =3D rgnbase + rgnsize - 1;
>-
> 		if (rgnbase <=3D base && end <=3D rgnend) {
> 			if (flags =3D=3D rgnflags)
> 				/* Already have this region, so we're done */
>@@ -278,10 +303,14 @@ static long lmb_add_region_flags(struct lmb_region =
*rgn, phys_addr_t base,
> 		}
> 	}
>=20
>-	if ((i < rgn->cnt - 1) && lmb_regions_adjacent(rgn, i, i + 1)) {
>-		if (rgn->region[i]=2Eflags =3D=3D rgn->region[i + 1]=2Eflags) {
>+	if (i < rgn->cnt - 1 && rgn->region[i]=2Eflags =3D=3D rgn->region[i + 1=
]=2Eflags)  {
>+		if (lmb_regions_adjacent(rgn, i, i + 1)) {
> 			lmb_coalesce_regions(rgn, i, i + 1);
> 			coalesced++;
>+		} else if (lmb_regions_overlap(rgn, i, i + 1)) {
>+			/* fix overlapping area */
>+			lmb_fix_over_lap_regions(rgn, i, i + 1);
>+			coalesced++;
> 		}
> 	}
>=20
