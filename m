Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9838C02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 07:08:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4E3380586;
	Wed, 22 Jan 2025 08:08:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Lp2L9XTi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20B1180762; Wed, 22 Jan 2025 08:08:44 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F361980283
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 08:08:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1737529721; x=1738134521; i=xypron.glpk@gmx.de;
 bh=Zu6hh+WezcvXZYGotNBq/muKhTBCxYMCx8svApOONyw=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Lp2L9XTippEraETse/tPi4SJ+Y9wC0ULcaN4iIBKMeLkLB97r668F9+bd1bGR9Nn
 ypC7/ORjM4cYcC0f3n2P9chQu5fazvfUZClNKI737azc8GysJghXtPgC+XvX8lNBT
 HFw7iyaFGrTzbmEJOIlxK36h394XiDAQk7a1IJiqb/Mm7h/yc9SXTuIJEvEKn0CQz
 MqDCgG74UIiuLKddC3ucaVaOy46jErBVm+lv8W+MrrH69Pg7d1PKJ92SFUiyBZ+xl
 OEoegyiiTPBuRPcpjaeaz/03EmLx1lH93s4EER5eSzxdeLawMq4tbDnY5yfkNVi0A
 cl2TwQwSzibYa7M/xw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6UZl-1tYXq52LzF-007jyO; Wed, 22
 Jan 2025 08:08:40 +0100
Date: Wed, 22 Jan 2025 08:08:38 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>, u-boot@lists.denx.de
CC: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 1/6] fs: fat: factor out dentry link create/delete
User-Agent: Thunderbird for Android
In-Reply-To: <20250122053232.17365-2-gabriel.dalimonte@gmail.com>
References: <20250122053232.17365-1-gabriel.dalimonte@gmail.com>
 <20250122053232.17365-2-gabriel.dalimonte@gmail.com>
Message-ID: <5351D72E-5B9F-4161-9005-016A0910FB9D@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:r/ob105pX19AtcuKsVr1SSy8CVxldDTUI9EmoOCx4/MCtHeYg/N
 pGOe40cly28oBzkoJiWIcNg2EBkhvyLQB/9jleI3NXGWPsqI2lgHmFM2YWT9fndfYrRKNj2
 A78EMeD7Qe+G/lg9gsItDRYt8UarCM8ZkCv8Svbud1WCrS55Dlvch6LEINHruc6t64FMQr3
 6Kqk8eKuA1JY/XW/mozww==
UI-OutboundReport: notjunk:1;M01:P0:/8BUatsHnz8=;XdTWTOGqFYFvwl3ZfjbctkUF0p4
 NJVm0f+ljTHTBE1ClDCQEM1cBNjbp2iMpJTEh/m+ebq0Ql0TTImIrjpX7RvfmDUtB1BqIRXsT
 1Y3gDG8Qn10dfUsruyYoWMDPJVvU1XJzxBopnsC3TAnypAGZvb/VgTLFxXV4RzUykEzKadAWl
 g2+y/ZxI2nBr5VzoJixmGP3pC3nZwdgLuM+YjzlmF4jFrVZSd9AlnFbnyyz9DvDgDMwfv1mOL
 eaR+4NOr/7tdSw3uufud23KLKoX+4PbHD8UNBKIIjtn9aUSqEbPdfDava4HQ+GX/+qojbuG7P
 pDD7+4tiMitaJ2B2p7UQSV27SXonhxgzdxvcNKbuhawEPVyPSgCZFyRtsMoZruW4q4QWSc5D/
 f7pMB8GAmu36zgrpkcVoxxoQxeH1CnNygRa1MIXwHd5uCtez6XvBTiDbaOc5LR/w51JRZKBBx
 8vgWuWezdtGjPgjCYupSPd71R7w0E4aLM7dbK+Y/KAhzYt/8XRiPxPfpkLdEKS0QMCA3RUgWO
 0QeMYKSR9TtrYe9sa79+hVkVuR8YLmC/OH2qFqF/1zUhf8Q86Kr+OC5OzGmaoVMAKrpmXwpfJ
 emYyCPSuKIZsuwzNcXF/vusHsrs7B9c8yEIVa0t65CYRbVSUkHhRPbbQESGADHwmObrEfdIz1
 RV8OtU+J1Odr2VVNLK26ahjvLXXPYUz7e20cbZmx71ZMzP8bf6JmwebVnzEyDC4xLlC3zkh2J
 H7SU9qV4AgpJJrCOXzh0jnf9pKs/RTsUOapjmU6cnQki9yhYlEzKqTMWbH0Sfu6I0n1qkXTKi
 AHoOWkaUEh6Jvnv3rwLW4149Jf+zHkQHI+HHzeTzF+juYMPAP4o1b1ZxKfTTfNhJrzi5re8p6
 sIZI+cXHhTaEQ3f564fgBwQX3rpftR0qI5FH/0Ma71GJxSJxMDFnzwgim6aLOgGXXSDl+53F/
 /+XotMvE1AdrwNPpYZ6aTRsxRR3TvKxrQvEnJoqyE8HY2p0HuYGlouzkVsspnc00oeQQn170i
 W/nUPfU2haD1XQl1gOq5M1YXYCxCjDgSD7lqoH8SaNCS/JsIkpSn2AgyeS9Q1jaVTdXiee36S
 iAcWkijD3AnmcovireQP25pL33fcKFH6l7m1XJE2wG8/lNRsSNVyiHrngJlvwhtWHpvNG/wSL
 P+ISkJPRc1+8xnJosEiNAN9uJbn3Bwce/ZJtgK5kIfWejDTdkpXnQCdSbG/KeN1N4SuCh67WC
 IzYMNJusPdMqTNhO99qelPjgsG+XwDgDQzyhcze/11rtDjEOriyzVXKtayzzHXAuiziszi15s
 Boy/PeutV8tQZw1DTpQyXREFw==
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

Am 22=2E Januar 2025 06:32:26 MEZ schrieb Gabriel Dalimonte <gabriel=2Edali=
monte@gmail=2Ecom>:
>Signed-off-by: Gabriel Dalimonte <gabriel=2Edalimonte@gmail=2Ecom>

Hello Gabriel,

 Thank you for implementing this=2E

Please, add a commit message to each patch=2E


>---
>
> fs/fat/fat_write=2Ec | 122 ++++++++++++++++++++++++---------------------
> 1 file changed, 66 insertions(+), 56 deletions(-)
>
>diff --git a/fs/fat/fat_write=2Ec b/fs/fat/fat_write=2Ec
>index ea877ee917=2E=2Eb86e78abc0 100644
>--- a/fs/fat/fat_write=2Ec
>+++ b/fs/fat/fat_write=2Ec
>@@ -1215,6 +1215,44 @@ static void fill_dentry(fsdata *mydata, dir_entry =
*dentptr,
> 	memcpy(&dentptr->nameext, shortname, SHORT_NAME_SIZE);
> }
>=20
>+/**
>+ * create_link() - inserts a directory entry for a cluster

=2E=2E=2E for a file or directory

>+ *
>+ * @itr:	directory iterator
>+ * @basename:	name of the new entry

@basename: file name

>+ * @clust:	cluster number the new directory entry should point to

=2E=2E=2E point to=2E Use 0 if no cluster is assigned yet=2E

>+ * @size:	file size
>+ * @attr:	file attributes

Do we need to keep the creation timestamp when moving files? And only upda=
te the change timestamp?

Should the archive flag be set when moving files?

What does EDK II or Linux in these cases?

Maybe you could describe these design considerations in the commit message=
=2E

Please, document which fields and flags are implicitly set in the function=
 description=2E

>+ * Return:	0 for success
>+ */
>+static int create_link(fat_itr *itr, char *basename, __u32 clust, __u32 =
size,
>+		       __u8 attr)
>+{
>+	char shortname[SHORT_NAME_SIZE];
>+	int ndent;
>+	int ret;
>+
>+	/* Check if long name is needed */
>+	ndent =3D set_name(itr, basename, shortname);
>+	if (ndent < 0)
>+		return ndent;
>+	ret =3D fat_find_empty_dentries(itr, ndent);
>+	if (ret)
>+		return ret;
>+	if (ndent > 1) {
>+		/* Set long name entries */
>+		ret =3D fill_dir_slot(itr, basename, shortname);
>+		if (ret)
>+			return ret;
>+	}
>+
>+	/* Add attribute as archive */

Could this be changed to
"Add archive attribute"?=2E

>+	fill_dentry(itr->fsdata, itr->dent, shortname, clust, size,
>+		    attr | ATTR_ARCH);
>+
>+	return 0;
>+}
>+
> /**
>  * find_directory_entry() - find a directory entry by filename
>  *
>@@ -1420,35 +1458,15 @@ int file_fat_write_at(const char *filename, loff_=
t pos, void *buffer,
> 		/* Update change date */
> 		dentry_set_time(retdent);
> 	} else {
>-		/* Create a new file */
>-		char shortname[SHORT_NAME_SIZE];
>-		int ndent;
>-
> 		if (pos) {
> 			/* No hole allowed */

This is another deficiency of our FAT driver worth looking into in future=
=2E

Best regards

Heinrich

> 			ret =3D -EINVAL;
> 			goto exit;
> 		}
>=20
>-		/* Check if long name is needed */
>-		ndent =3D set_name(itr, basename, shortname);
>-		if (ndent < 0) {
>-			ret =3D ndent;
>-			goto exit;
>-		}
>-		ret =3D fat_find_empty_dentries(itr, ndent);
>+		ret =3D create_link(itr, basename, 0, size, 0);
> 		if (ret)
> 			goto exit;
>-		if (ndent > 1) {
>-			/* Set long name entries */
>-			ret =3D fill_dir_slot(itr, basename, shortname);
>-			if (ret)
>-				goto exit;
>-		}
>-
>-		/* Set short name entry */
>-		fill_dentry(itr->fsdata, itr->dent, shortname, 0, size,
>-			    ATTR_ARCH);
>=20
> 		retdent =3D itr->dent;
> 	}
>@@ -1564,6 +1582,31 @@ static int delete_long_name(fat_itr *itr)
> 	return 0;
> }
>=20
>+/**
>+ * delete_dentry_link() - deletes a directory entry, but not the cluster=
 chain
>+ * it points to
>+ *
>+ * @itr:	the first directory entry (if a longname) to remove
>+ * Return:	0 for success
>+ */
>+static int delete_dentry_link(fat_itr *itr)
>+{
>+	itr->dent =3D itr->dent_start;
>+	itr->remaining =3D itr->dent_rem;
>+	/* Delete long name */
>+	if ((itr->dent->attr & ATTR_VFAT) =3D=3D ATTR_VFAT &&
>+	    (itr->dent->nameext=2Ename[0] & LAST_LONG_ENTRY_MASK)) {
>+		int ret;
>+
>+		ret =3D delete_long_name(itr);
>+		if (ret)
>+			return ret;
>+	}
>+	/* Delete short name */
>+	delete_single_dentry(itr);
>+	return flush_dir(itr);
>+}
>+
> /**
>  * delete_dentry_long() - remove directory entry
>  *
>@@ -1589,21 +1632,7 @@ static int delete_dentry_long(fat_itr *itr)
> 		if (ret)
> 			return ret;
> 	}
>-	itr->dent =3D itr->dent_start;
>-	itr->remaining =3D itr->dent_rem;
>-	dent =3D itr->dent_start;
>-	/* Delete long name */
>-	if ((dent->attr & ATTR_VFAT) =3D=3D ATTR_VFAT &&
>-	    (dent->nameext=2Ename[0] & LAST_LONG_ENTRY_MASK)) {
>-		int ret;
>-
>-		ret =3D delete_long_name(itr);
>-		if (ret)
>-			return ret;
>-	}
>-	/* Delete short name */
>-	delete_single_dentry(itr);
>-	return flush_dir(itr);
>+	return delete_dentry_link(itr);
> }
>=20
> int fat_unlink(const char *filename)
>@@ -1725,9 +1754,6 @@ int fat_mkdir(const char *dirname)
> 		ret =3D -EEXIST;
> 		goto exit;
> 	} else {
>-		char shortname[SHORT_NAME_SIZE];
>-		int ndent;
>-
> 		if (itr->is_root) {
> 			/* root dir cannot have "=2E" or "=2E=2E" */
> 			if (!strcmp(l_dirname, "=2E") ||
>@@ -1737,25 +1763,9 @@ int fat_mkdir(const char *dirname)
> 			}
> 		}
>=20
>-		/* Check if long name is needed */
>-		ndent =3D set_name(itr, basename, shortname);
>-		if (ndent < 0) {
>-			ret =3D ndent;
>-			goto exit;
>-		}
>-		ret =3D fat_find_empty_dentries(itr, ndent);
>+		ret =3D create_link(itr, basename, 0, 0, ATTR_DIR);
> 		if (ret)
> 			goto exit;
>-		if (ndent > 1) {
>-			/* Set long name entries */
>-			ret =3D fill_dir_slot(itr, basename, shortname);
>-			if (ret)
>-				goto exit;
>-		}
>-
>-		/* Set attribute as archive for regular file */
>-		fill_dentry(itr->fsdata, itr->dent, shortname, 0, 0,
>-			    ATTR_DIR | ATTR_ARCH);
>=20
> 		retdent =3D itr->dent;
> 	}

