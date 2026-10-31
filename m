Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6572C606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 11:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sDVUyR/e
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3B8D08110C;
	Sat, 31 Oct 2026 11:11:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PJlwz25t6vVN; Sat, 31 Oct 2026 11:11:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7665F8111D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793445094;
	b=ngqNh5w2VEn4BT2CCME5uJbr/3MEdkiYvhe0joWDfNmOMzTHZuZfgWb9EK2CBLcaOsCm
	 xzwvqJRvWbalXsj7BYd8vefd67xRM1Fi9SsClUQEMTWd6bt96BvaStSzGQLnBgYTlAC05
	 e3LRpbCF4DROhHcnqmwC8y4vDgEaBOu++T7XpGZctdS0DcwnRgfHGhnlZLdcKm83TJqGA
	 Dj7dtbP81YyhgJwYx7eCRmLs+vuVcInA1zWJigLJzfryzTOpqsI6RzAK8Bk+DSZG4yWZo
	 zeNMy5z/yUEvZXBL0cAe4qdEyplNM248uISSEwjuPubKqTr3HfErvpyNbHBmhUpuuvg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793445094;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1YeMqLkTjEXVSVLldHEuWQ7yBoAS/QfwJGqsrMC1VEE=;
	b=U+KhdxM7R9mKeYZ7hFe+53pGQn851rcYl/Qdk0t1R6JhqdwG73T4toGP+IENw2qG26SM
	 dU7Ck1OVaNhRV6yHycAXB04UzdXjCP4MLXf3zY/9WEWfkxicFXojmNvps436vIhE+j5TQ
	 ZXB8xPhDCpp/SITXsA8biB/tbqxtgVIA/PgsWxEY1a2qoA4mA86rrocyAgodaYVW53yH3
	 9El2igeUkPbrDJCAakwWiAl/OtYnYXWqWhvK2lT/wKjmqJTuWhSCAxAf+5QYglr0dx+oi
	 XgA89B9YsB+qsBdlqIa1BKugNSjxb7IyhnblXw0bg0edlL/fAK0stnLkH9u35PpKxYg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793445094;
	bh=1YeMqLkTjEXVSVLldHEuWQ7yBoAS/QfwJGqsrMC1VEE=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sDVUyR/eZWTSIKoh/+MA4YEILcY+0Pz28vbVDjYVUZeOy66Cbg15JhLtXQmtBvvcv
	 xZ/GhF5V2DmcJ+PEa5Zw9j4eV8vMMfllS9kf2+fiKqaK89izOeFIuAFsq185GpR48V
	 MXopZlTJmYXcTGrPiVuMHibI3CTBAf3pdczhFI7Dglg8e5PlrPvGqCGW5J9KOAFefF
	 2k/qm2C2wZmfDbJPSNhoAFEWPfZnPfpg1Ule+hq2UY2RYc/iXNF5a3uk3nhHGabxKB
	 Tg1tbTmb+i7wWh6Z6t0gdPEkZpmdy0Gc25XBOR4j8/49+6PQe+a/6Sk0h7U/ZCsRNu
	 F3bS4urJzlc8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7665F8111D;
	Sat, 31 Oct 2026 11:11:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id EABCE2C7
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:11:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D0D5F40057
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:11:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dgn-hRhgOn-Q for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 11:11:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EE5544004D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793445092;
 b=hpP2xJICM0NEw2P0GCMtawJHwZsLvjRp3hC8ae101G0oolzjF+tyeufARfIQ2SDEEYDT
 ICCldbKjG5Nk0Itfou1XkyMGcTc2iGeL2fwiWDGJD7GKwJUQ6rf7UN7V2PtttwMDMSdCc
 vqzPjysQCHlOJVfS8LHiV7GAQyEMOxRNmpHbx5XgDvDgCrIe+8aa0aH4GZIA4+WY/Qyo8
 hxt/Np2zweRRWLaEb7VbPhekSq22pg1tkXW95q/Bs0ZrDXAsprHoEqbo/Mj9g19zNuWA7
 ere3W2W56aa9yvzUAUHRUpS5SgGYmylqIlznQ2igZaVWURFKYFmiC+zLUKENFFQOIfw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793445092;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=1YeMqLkTjEXVSVLldHEuWQ7yBoAS/QfwJGqsrMC1VEE=;
 b=TFDtE5SWSRXq/2PjJoKC4XoNW1Z1MmiXRkXeoRV5BoKo37DU7AXFxdPRrea6wv8f/liz
 nbgfYnwwqU6DchjPZmEApF3gNRGS5T0ga2fBn3unmwHFHgO/BhfclyiPZlcjR9HJHxTXO
 /I1Cpa08+rno1bHgcwfZdFO0lU6TiVWFF9+3w3hjLxXK13fPMrPurzZueTrojSBYnQanx
 Uqx+Xlr3H7Z3PJGH8AtACaMMEbQHft/XTQ39dr2PEbkE4kdbqzZPo3Bxg8ezgj69wnsra
 4q0LJoPWz0hAQOP+fnGBlKaba6FtwwA6RLxzLAu2PbdbFs5SGVMpp+pOpx1eyvneBmg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=makrotopia.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EE5544004D
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:11:31 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xN6wY-000000003Pq-2wSf;
 Sat, 31 Oct 2026 11:11:28 +0000
Date: Sat, 31 Oct 2026 11:11:25 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Vincent Jardin <vjardin@free.fr>, Anton Ivanov <anton@binarly.io>,
 Randolph Sapp <rs@ti.com>, Anders Roxell <anders.roxell@linaro.org>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH v3 07/11] boot: imagemap: name the device after its partition
Message-ID: <c106385f2a8a2dd8e39960e4300c21346a159748.1793384548.git.daniel@makrotopia.org>
References: <cover.1793384548.git.daniel@makrotopia.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793384548.git.daniel@makrotopia.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

imagemap_create() names every device it binds by index "imagemap", so
two mappings taken on one block device appear as two identically named
children and the device tree does not say which partition each covers.
The name also comes straight from the caller, whose string has to outlive
the device for the driver-model pointer to stay valid.

Derive the name from the partition, by name where one was given and by
index otherwise, and hand driver model an allocated copy it releases on
unbind.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v3: No changes since v2.
v2: - The named path no longer copies the caller's name through a
      fixed-size buffer, which truncated it at 31 characters; the name is
      duplicated directly and the buffer is only used for the
      "imagemap%d" index spelling.

 boot/imagemap.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/boot/imagemap.c b/boot/imagemap.c
index 0a156e010ec..d46c1430fb7 100644
--- a/boot/imagemap.c
+++ b/boot/imagemap.c
@@ -11,6 +11,7 @@
 #include <dm.h>
 #include <imagemap.h>
 #include <lmb.h>
+#include <malloc.h>
 #include <mapmem.h>
 #include <memalign.h>
 #include <part.h>
@@ -442,6 +443,9 @@ int imagemap_create(struct udevice *dev, const char *name,
 	struct imagemap_plat *plat;
 	struct disk_partition info;
 	struct udevice *imdev;
+	char buf[32];
+	char *devname;
+	const char *base;
 	int ret;
 
 	if (name && *name)
@@ -451,10 +455,28 @@ int imagemap_create(struct udevice *dev, const char *name,
 	if (ret < 0)
 		return ret;
 
-	ret = device_bind_driver(desc->bdev, "imagemap",
-				 name && *name ? name : "imagemap", &imdev);
-	if (ret)
+	/*
+	 * Name the device after the partition it covers, so that two mappings
+	 * on one block device stay distinct in the device tree.
+	 */
+	if (name && *name) {
+		base = name;
+	} else {
+		snprintf(buf, sizeof(buf), "imagemap%d", part);
+		base = buf;
+	}
+
+	/* device_bind_driver() keeps the pointer, so hand it one DM can own */
+	devname = strdup(base);
+	if (!devname)
+		return -ENOMEM;
+
+	ret = device_bind_driver(desc->bdev, "imagemap", devname, &imdev);
+	if (ret) {
+		free(devname);
 		return ret;
+	}
+	device_set_name_alloced(imdev);
 
 	plat = dev_get_plat(imdev);
 	plat->part_start = info.start;
-- 
2.56.0
