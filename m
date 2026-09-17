Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5519C982D6
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 16:23:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0FBD060B63;
	Thu, 17 Sep 2026 16:23:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Eg-mA8JjLqol; Thu, 17 Sep 2026 16:23:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2556C60B49
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789662205;
	b=S6DlZhV1Qk2uMGW2cdUT7MRkBx69UKHWiI4oyuwHm2UvWl60tUhXcrhCjwdbVezCWmhI
	 RTVgBrzArUQFvSoJmOkHeB5Km4/Md7kD6zmShsQ/h/oA096zu1ltuii644nDv0Rol0xIo
	 V3JpyDaUemJetqoiuUVabGMLto6bnfPSUinvEfEPLaUb6MBTBthvF96KbLTzljA2QxrDH
	 azTrpSQLWTyeIort19v5DIDnwtXhlZJNj8wVxLR7nfTMTCBWVzIrKeLv9sED77folcOmZ
	 avADtUj1bPrBBbq3QVz7v8oUzF/RdYceEqrUSI6vwbi8rakcUXlJhVbunJEbt/Kpi8w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789662205;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Date:From:To:CC:Subject:
	 User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:UI-OutboundReport:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DJV84hu6S4agnwkDV+UM1UdXQEVMJqfriyfBNJWZ9Es=;
	b=QoAsTKKSYhxoq3oNypXaBa3mfs3h+MVmW1lJdFzEU6PzU5tqt5LXdHo60P4EfnOJyDuw
	 jr/dKRngLy4uOUrdEfjikkdBuHfZbBvJ/njpLRPxD85pFQT9kzFmvA3nDVgVQDrlaT0J3
	 rxZBHzrMnxqAD/IiQD4Jn/1jCsrJXVxxNG/6CG1j0aTqYTxIDzQ23pLVTnYgHEgy46iDO
	 zxip9Wkc/72DQyis6vQwMX+SrMSKtOsNYcnxBTLy3Kh8poyyVwpgITl5qFwZ4gX2e6Doz
	 QyiqQ3/5r5rvP3i20Es7X2ImIqTOicQ4xb3CRMyFBW6rY18UcIV8AHSjPRXEyBVXG+A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789662205;
	bh=DJV84hu6S4agnwkDV+UM1UdXQEVMJqfriyfBNJWZ9Es=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k0dcdGHGo6r243X1L9qB1DSPAAFuJfDjAqCSm9MWycqmKN1bBav7Ej4N9ZOMCFFUM
	 ixVPasqXvw5egbrLRnnF/la3GpHXtTk+kngnnSZ9sZCDwjeF9UrnIX/OZKql3EZOOS
	 QJ+nOIecZrlUfGV/zUwaJUy5iGBC+zTz5qqQIRrsJZA8Sb3ccvBpwdUub2sGqnmX5C
	 DIW7fwpZ1KSt4uRk8ixhsmv1ABvkuSH4tcgNS616ZCAbDDk+tj4gwTYwr2zGX7AXe0
	 yrVuG7W08o2WLSeMt5wipC9s4mcpiNKgNtcgO/r5avH+58sot+a42r92MyeTTWA8Vz
	 qF+KW2m2jI7kQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2556C60B49;
	Thu, 17 Sep 2026 16:23:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2BA38422
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 16:23:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 11B9780FB0
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 16:23:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I-fXi_EYD5kJ for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 16:23:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6D02E80FA3
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789662203;
 b=EBNdGS/yhitmy1GCuu1BUWbZnJByZopahyJWwvnUua4ujH7SvLWLbYHxQ91+chVehUqa
 YfoEFKdtZVaG6Z94i7KCFHF4EPmQ8O6jtLP8hPlGDwJ7B6cSFvGy7PiCzh/kb3eGOoQB7
 tvSuBZXBfRKcaPpCLpH64Fa5v3ZW0OrUJC7vSYRyPmfxGNeuAfXFqFuChnzgicQnW0nqb
 42kIT74j8Cq1xaTxzxa9ZmeNMXUdBv9Nby6JSWlky6g9X4m3mRoCHApdX4peCYLp05aYr
 JMSuFQDtrLt+WnWolQ62DLcYaAjmH6JR920BLSVtD6YN079ZqWjAvk+RZep5/fm6Mbg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789662203;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:Date:From:To:
 CC:Subject:User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
 UI-OutboundReport;
 bh=DJV84hu6S4agnwkDV+UM1UdXQEVMJqfriyfBNJWZ9Es=;
 b=l+LnhVd0fGgGQoMSSXTYug5kyDPkRLaf+Z4eqDpLdg3osYVKerWfhftc+5/XD4Kbn+Dj
 Al/ehez3fa4FSXMfuPqj4VRih7Mybil304XQBsJ6AZCiiHRqH80ud2IiNtMaM+CkXI7BA
 6lbza3oH9VJv636f7uE6nYl/QhlCN6petXeNp4GPu3x2V+m+yVqS53gpiJIBLhSW2SJGu
 5GDKFpIBV7IUReSwb4lUWXSc0j7xArvUqP2ho5BtvnHYdueHy9YIl2If/xGlNUFt59U9r
 jCMpPTSEhEoLd+R07NZNidGY9jowdydKRQzdeycyfMKPT2UD/WjAvxuUYgjVGPwJ6Cg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmx.de; 
 dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=Sgpj83Bc; 
 arc=none smtp.remote-ip=212.227.17.20
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.17.20;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=Sgpj83Bc
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6D02E80FA3
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 16:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1789662195; x=1790266995; i=xypron.glpk@gmx.de;
 bh=DJV84hu6S4agnwkDV+UM1UdXQEVMJqfriyfBNJWZ9Es=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Sgpj83BcSlF2g0xiAE4geLFuPBEw0lCeeLJqqQW2NL3XpVmTdHzLB46EZIll7XiJ
 6hSmwdDSHEDEJ49qEVUJsNsLrVIdWHTBjg534ZEE19OC9HlUkcWN5DOpuDr5Hxn/1
 i1I6r9zrWebUZtjXPe+iXquuWKo0Nh+d+ZZJJmUwqudgUee/3O5XwXdKSRGfu2e0x
 kvGLcYZ/W7BB0bRFj1ZCfn3KKpwo+QquQZAlK4okFPawd8Pnex35x/J+54FzEXH3Y
 /qUIuMHPpVyP/eDVCYGkoe4r9y94U/J+I2FFR6wudwY7SdAYwrW16xnEVtdpUwxKu
 tg7XHzTd9qEpOyFlIQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJmGP-1xMzON2ea1-00QZbD; Thu, 17
 Sep 2026 18:23:14 +0200
Date: Thu, 17 Sep 2026 18:23:11 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: =?ISO-8859-1?Q?Vincent_Stehl=E9?= <vincent.stehle@arm.com>,
 u-boot@lists.u-boot-project.org
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Alexander Graf <agraf@csgraf.de>
Subject: Re: [PATCH] efi_loader: fix string table reallocations
User-Agent: Thunderbird for Android
In-Reply-To: <20260917-ptr-v1-1-7d60d07b849e@arm.com>
References: <20260917-ptr-v1-1-7d60d07b849e@arm.com>
Message-ID: <BC138B74-47B8-4DC2-9EB9-5FE389909AB5@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cVFUarC2wvNupPRjQ0Jg7pzqSeYvaJX8D3b2NWxPFXEulp2ImC8
 T+h4Iya98pjE8AifCKgh4fusbc7wG45a7KH3odAV/2NoY0X4x6NBnlNhfJe0Z+J6aUdpzte
 IXS3i3LkGMbIzbwNGYgWsREbww248FbSxGeqm22F09xMlEoABqqKshGIFN7z+oX/sbk0r/T
 UL29xFEtyapQY166gNF0g==
UI-OutboundReport: notjunk:1;M01:P0:+VsWEniXFvM=;BcU30tY7gZTIit6Eg20eUCD6F9A
 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
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Am 17=2E September 2026 11:45:31 MESZ schrieb "Vincent Stehl=C3=A9" <vincen=
t=2Estehle@arm=2Ecom>:
>The new_string() and set_string() HII string protocol functions keep
>using old pointers after calling realloc(), which may have moved=2E
>
>The set_string() function also assumes that reallocation only grew the
>array by one element when computing the start of the memory to clear,
>and forgets to update nstrings to the new table size after reallocation=
=2E
>
>Repair and factorize the reallocation code in a new grow_string_table()
>function to fix those issues=2E


Should we add a test in U-Boot and possibly in SCT?

Best regards

Heinrich

>
>Fixes: c9bfb22296b0 ("efi_loader: Initial HII database protocols")
>Signed-off-by: Vincent Stehl=C3=A9 <vincent=2Estehle@arm=2Ecom>
>Cc: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>
>Cc: Ilias Apalodimas <ilias=2Eapalodimas@linaro=2Eorg>
>Cc: Tom Rini <trini@konsulko=2Ecom>
>---
>This can be tested on the sandbox with the following command:
>
>  =2E/u-boot -T -c 'setenv efi_selftest HII database protocols; bootefi s=
elftest'
>
>While the unit test does cause reallocation with new_string(), it does no=
t
>with set_string()=2E
>
>Further testing can be done by forcing stbl->strings =3D NULL, just after
>calling realloc(stbl->strings, =2E=2E=2E)=2E
>---
> lib/efi_loader/efi_hii=2Ec | 64 +++++++++++++++++++++++++++-------------=
--------
> 1 file changed, 36 insertions(+), 28 deletions(-)
>
>diff --git a/lib/efi_loader/efi_hii=2Ec b/lib/efi_loader/efi_hii=2Ec
>index 7bf51ad43d1=2E=2E90dff91e5d4 100644
>--- a/lib/efi_loader/efi_hii=2Ec
>+++ b/lib/efi_loader/efi_hii=2Ec
>@@ -822,6 +822,37 @@ static bool language_match(char *language, char *lan=
guages)
> 	return false;
> }
>=20
>+/**
>+ * grow_string_table() - Grow a string table if necessary=2E
>+ * @stbl: String table to grow=2E
>+ * @n:    Minimum table size desired=2E
>+ *
>+ * Make sure a string table can contain at least n elements=2E
>+ * If the table is too small, reallocate the memory and clear the new el=
ements=2E
>+ *
>+ * Return: false in case of reallocation error, true otherwise=2E
>+ * In case of error, the original string table is left untouched=2E
>+ * In case of success, stbl->strings and stbl->nstrings may have been up=
dated=2E
>+ */
>+static bool grow_string_table(struct efi_string_table *stbl, u32 n)
>+{
>+	void *buf;
>+	u32 old_n =3D stbl->nstrings;
>+
>+	if (old_n >=3D n)
>+		return true;
>+
>+	buf =3D realloc(stbl->strings, sizeof(stbl->strings[0]) * n);
>+	if (!buf)
>+		return false;
>+
>+	stbl->strings =3D buf;
>+	stbl->nstrings =3D n;
>+	memset(&stbl->strings[old_n], 0, sizeof(stbl->strings[0]) * (n - old_n)=
);
>+
>+	return true;
>+}
>+
> static efi_status_t EFIAPI
> new_string(const struct efi_hii_string_protocol *this,
> 	   efi_hii_handle_t package_list,
>@@ -847,23 +878,12 @@ new_string(const struct efi_hii_string_protocol *th=
is,
> 	list_for_each_entry(stbl, &hii->string_tables, link) {
> 		if (language_match((char *)language, stbl->language)) {
> 			efi_string_id_t new_id;
>-			void *buf;
> 			efi_string_t str;
>=20
> 			new_id =3D ++hii->max_string_id;
>-			if (stbl->nstrings < new_id) {
>-				buf =3D realloc(stbl->strings,
>-					      sizeof(stbl->strings[0])
>-						* new_id);
>-				if (!buf)
>-					return EFI_EXIT(EFI_OUT_OF_RESOURCES);
>-
>-				memset(&stbl->strings[stbl->nstrings], 0,
>-				       (new_id - stbl->nstrings)
>-					 * sizeof(stbl->strings[0]));
>-				stbl->strings =3D buf;
>-				stbl->nstrings =3D new_id;
>-			}
>+
>+			if (!grow_string_table(stbl, new_id))
>+				return EFI_EXIT(EFI_OUT_OF_RESOURCES);
>=20
> 			str =3D u16_strdup(string);
> 			if (!str)
>@@ -957,20 +977,8 @@ set_string(const struct efi_hii_string_protocol *thi=
s,
> 			if (hii->max_string_id < string_id)
> 				return EFI_EXIT(EFI_NOT_FOUND);
>=20
>-			if (stbl->nstrings < string_id) {
>-				void *buf;
>-
>-				buf =3D realloc(stbl->strings,
>-					      string_id
>-						* sizeof(stbl->strings[0]));
>-				if (!buf)
>-					return EFI_EXIT(EFI_OUT_OF_RESOURCES);
>-
>-				memset(&stbl->strings[string_id - 1], 0,
>-				       (string_id - stbl->nstrings)
>-					 * sizeof(stbl->strings[0]));
>-				stbl->strings =3D buf;
>-			}
>+			if (!grow_string_table(stbl, string_id))
>+				return EFI_EXIT(EFI_OUT_OF_RESOURCES);
>=20
> 			str =3D u16_strdup(string);
> 			if (!str)
>
>---
>base-commit: 2c7eaee7b3422ce7c84e892abfe16e1afce42e83
>change-id: 20260916-ptr-670be74dcbd3
>
>Best regards,
>-- =20
>Vincent=2E
>

