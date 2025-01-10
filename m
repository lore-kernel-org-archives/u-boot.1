Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B33E7719C
	for <u-boot@archiver.kernel.org>; Sat, 11 Jan 2025 00:05:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FA46800D0;
	Sat, 11 Jan 2025 01:04:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="P2v5klXK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F34BF805E9; Sat, 11 Jan 2025 01:04:05 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D238C80050
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 01:04:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1736553843; x=1737158643; i=xypron.glpk@gmx.de;
 bh=29uIaByZmZtcRMURyfwExS5+uu0DE8jR3ED6PAKr0tw=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=P2v5klXKfvxWQnNZtWhTCTLhSUs+iJIg5gR+NBqIKgqgYjCRjX+1eHUyY6QtodNv
 rMBl5jR41dJtZltFAMJyHG90S715LBXcjZPQZbLiHVbP/EV5lcRp9MKmWSx1ZoB/y
 WdrmnL8XilM1Hc40qwN3jOqgmss8Stm3tMIC8KpIv7PdrCPcBAq7Ob0ORg6bPsac3
 is5AWlnyZOKPxHzHTqFSBsjqpBCte2PHPRmGrA0HexxpRmG2UMH8jUGjeQoFpcVDw
 qhzIf5p3A8vNZa6qQaTlBoTjfk3V3/o6LJaUT4jro+axjDg0fHdI8hFWIsuFQHbzr
 FWn3dPA86PsApB0vXQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhU5R-1t1j3h31hz-00iIJF; Sat, 11
 Jan 2025 01:04:02 +0100
Date: Sat, 11 Jan 2025 00:59:41 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de
CC: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>
Subject: Re: [PATCH v4 1/3] bloblist: add api to get blob with size
User-Agent: Thunderbird for Android
In-Reply-To: <20250110215640.892539-1-raymond.mao@linaro.org>
References: <20250110215640.892539-1-raymond.mao@linaro.org>
Message-ID: <7DADDD00-D471-46D9-B143-00FBA1171ECB@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EhSLWO265ObRqy95OUNvqIAQBXmcox3HqqihivBi3BLY+0zOVC1
 PiV4vZweLZ8HirxxLWWZ1UEc1VM+E5AXDjXYH5lufsZWSzT7SV6/5ymJexkVpVA7Hqgj9K8
 jgaebYyB+c/GmaZ1q7fjK3kqIE2xheS7WAhUyrAG5Q19yWiuPwfJHNgjZmU5TKf3F7GYYqf
 wmfBbXG2mjduuhNtj5PJw==
UI-OutboundReport: notjunk:1;M01:P0:uTYYfL6IEmM=;7ArPD0KnzHuEMnR9Ks9D2IEaRqr
 yYoQ3FzazF0jndHEG6Ee5OIj2OhkuLD2e8XmXCpd+DM3onHLCrplkFTLIY/upS+t1ARitorgd
 qzMXVkPaqbNet9z7P6PzYdaimr3B5Q2EKSpyvxg448GngVagyZYpdOkoQYb09JhYS7O5DlTfW
 VreDqpmz9n2rJms683+HeYQ7K+86WPoBPEUuwys8EqJecnO7AVqs8KlTQ8WVVLf/mAWbT2W4Y
 lnm6/ueR/1xbwa0cuZE8P/qjm1bbgAbZznYnt3FDWbxZO5XIBczPt3bfG0FheOkGc76+e05wJ
 ClN319vQ0i87Qb0YPuJuJ1Q9vMYHSRyla4/lLKHyyg6fOVhU5s5lCcAErKfgb/vngyA8y5jgr
 yy89U1Ndl4pwmfZPtUESTXoSvdUcPQJsjwpElqhgAPOeHfaCYcFHsTO1YzPaSoAowpgFxGGz+
 C/2dOLYqnO33xITGQJ5lIbgvBcmUQU+G4bn8gJhaP3hYnV77egQwF23mrJ8pp7LYaeFDlz50F
 CwJLtCyE0hxwJkeMpohnU2sraDR4nig3mfgrLByIquGAAbN+PvvbcL3p79HEsUeqAjZNPdPUz
 LL9TN2mqiWUqd2mzdUV8u8JAc4r/jW16csKT7T/vnTy3PGIqg1hfmhtRZavaz7kN2aW9hwr5q
 +6x9GXvzuD8r8UZg6Jv1biEdOHqYVjRmGrseqvM1WyOfYz6Uw5pkFCXLj5Tb1DNWoSpUT5uta
 RWtNNb1aBzcjeImS1YPlgX3ToDxuyhUu1fAh4UX4tscSOFUHSYO8G24tFkVlpAEvpngXisHw6
 Ti7T1Zi6NvDWv2t0sJpyS4PNQCpFxixXyk2mn6Dsfy5Z7rTK64GKeVCMz6wF5Sv+COlgbCb/B
 JQU77ghQQt94q6FCLeNVWIZGsvHQw0WUvG21Eg27Hly7PVjxrqCOn0VP4H5wJKZHxxCpkatHK
 EIhWzPjjZfQ1ZX1qrYFYoDbeqrTVIXuLBdUnm+f0SFXvUTwB19+TX7/BQf9TlU1mivuqbF4mR
 fCoPvaYC9wnP+gh8198BHUFSItH33cIKjRwot1EQjYCs6EWM6/oVxrmBqkMe9IllU911b5TEM
 09kKox23E=
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

Am 10=2E Januar 2025 22:56:33 MEZ schrieb Raymond Mao <raymond=2Emao@linaro=
=2Eorg>:
>bloblist_find function only returns the pointer of blob data,
>which is fine for those self-describing data like FDT=2E
>But as a common scenario, an interface is needed to retrieve both
>the pointer and the size of the blob data=2E
>
>Add a few ut test cases for the new api=2E
>
>Signed-off-by: Raymond Mao <raymond=2Emao@linaro=2Eorg>
>Reviewed-by: Simon Glass <sjg@chromium=2Eorg>
>Reviewed-by: Ilias Apalodimas <ilias=2Eapalodimas@linaro=2Eorg>
>---
>Changes in v2
>- Rename function argument=2E
>- Add ut tests=2E
>Changes in v3
>- None=2E
>Changes in v4
>- None=2E
>
> common/bloblist=2Ec      | 17 +++++++++++++++--
> include/bloblist=2Eh     | 18 ++++++++++++++++++
> test/common/bloblist=2Ec |  4 ++++
> 3 files changed, 37 insertions(+), 2 deletions(-)
>
>diff --git a/common/bloblist=2Ec b/common/bloblist=2Ec
>index 110bb9dc44=2E=2Eab48a3cdb9 100644
>--- a/common/bloblist=2Ec
>+++ b/common/bloblist=2Ec
>@@ -222,14 +222,27 @@ static int bloblist_ensurerec(uint tag, struct blob=
list_rec **recp, int size,
> }
>=20
> void *bloblist_find(uint tag, int size)
>+{
>+	void *blob =3D NULL;
>+	int blob_size;
>+
>+	blob =3D bloblist_get_blob(tag, &blob_size);
>+
>+	if (size && size !=3D blob_size)
>+		return NULL;
>+
>+	return blob;
>+}
>+
>+void *bloblist_get_blob(uint tag, int *sizep)
> {
> 	struct bloblist_rec *rec;
>=20
> 	rec =3D bloblist_findrec(tag);
> 	if (!rec)
> 		return NULL;
>-	if (size && size !=3D rec->size)
>-		return NULL;
>+
>+	*sizep =3D rec->size;
>=20
> 	return (void *)rec + rec_hdr_size(rec);
> }
>diff --git a/include/bloblist=2Eh b/include/bloblist=2Eh
>index f999391f74=2E=2E52ba0ddcf8 100644
>--- a/include/bloblist=2Eh
>+++ b/include/bloblist=2Eh
>@@ -250,6 +250,24 @@ static inline void *bloblist_check_magic(ulong addr)
> 	return ptr;
> }
>=20
>+#if CONFIG_IS_ENABLED(BLOBLIST)

Why should we use an #ifdef here?
Why would a caller invoke the function if the configuration is disabled?

>+/**
>+ * bloblist_get_blob() - Find a blob and get the size of it
>+ *
>+ * Searches the bloblist and returns the blob with the matching tag
>+ *
>+ * @tag:	Tag to search for (enum bloblist_tag_t)
>+ * @sizep:	Size of the blob found
>+ * Return: pointer to bloblist if found, or NULL if not found
>+ */
>+void *bloblist_get_blob(uint tag, int *sizep);

If tag is expected to be a value from the enum, we should not use uint her=
e=2E

Best regards

Heinrich

>+#else
>+static inline void *bloblist_get_blob(uint tag, int *sizep)
>+{
>+	return NULL;
>+}
>+#endif
>+
> /**
>  * bloblist_find() - Find a blob
>  *
>diff --git a/test/common/bloblist=2Ec b/test/common/bloblist=2Ec
>index 4bca62110a=2E=2E324127596f 100644
>--- a/test/common/bloblist=2Ec
>+++ b/test/common/bloblist=2Ec
>@@ -98,10 +98,12 @@ static int bloblist_test_blob(struct unit_test_state =
*uts)
> 	struct bloblist_hdr *hdr;
> 	struct bloblist_rec *rec, *rec2;
> 	char *data;
>+	int size =3D 0;
>=20
> 	/* At the start there should be no records */
> 	hdr =3D clear_bloblist();
> 	ut_assertnull(bloblist_find(TEST_TAG, TEST_BLOBLIST_SIZE));
>+	ut_assertnull(bloblist_get_blob(TEST_TAG, &size));
> 	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0, 0));
> 	ut_asserteq(sizeof(struct bloblist_hdr), bloblist_get_size());
> 	ut_asserteq(TEST_BLOBLIST_SIZE, bloblist_get_total_size());
>@@ -114,6 +116,8 @@ static int bloblist_test_blob(struct unit_test_state =
*uts)
> 	ut_asserteq_addr(rec + 1, data);
> 	data =3D bloblist_find(TEST_TAG, TEST_SIZE);
> 	ut_asserteq_addr(rec + 1, data);
>+	ut_asserteq_addr(bloblist_get_blob(TEST_TAG, &size), data);
>+	ut_asserteq(size, TEST_SIZE);
>=20
> 	/* Check the data is zeroed */
> 	ut_assertok(check_zero(data, TEST_SIZE));

