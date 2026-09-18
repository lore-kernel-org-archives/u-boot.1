Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B181C982D8
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 16:22:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 55CE840B4B;
	Fri, 18 Sep 2026 16:22:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qm1q_fsAQ2Iq; Fri, 18 Sep 2026 16:22:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7744140B02
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789748559;
	b=GRrN10pzDl810jTX6aaS5IGt90SCO2ltLJqvqFjDdMGis34L+VCvGU24EkVABDcW4CCd
	 IfgQGh1aaV1PYp95XviUnub6QPESMp6RAuBDRIDiKOvMwgGsUVEeT1vUsRpQwPPAZe2h8
	 o3s6ouafeJ45+scSMrZVjmULnRZYaQ1+FIVDWHLf/VmMY+aEiVWQdyBcMIAd2MoUML+4p
	 Fg7zfUs6OCplR5YCsew+8pBHhwtrbVgL7kwNIag1XC8BNGtlpY4TXeEv4r6YCAVXn2M7S
	 obk5KVZCQxzX79xbO3q5H/Nix06GeuBMmtnbrL5M4NF56XBuIAzKGEsQDNsj7TXLRnQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789748559;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Date:From:To:CC:Subject:
	 User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:UI-OutboundReport:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+vW/Lptj/tsyYQPLDPFpzzAbuD46832mKCK9uol7W34=;
	b=IXNxc1RYOXfGJ02N82wUOl2vvgaSFYJLooTI/QDiVgn7NGFYacggQ9nQlcZUhebCqF59
	 50v7OjHK9VoqT8JE/2fK9Z/HM6tFfmXJzv4c1GXfODBeH7JgPXPly8ET1zAjfCWF3jxzZ
	 vyPI9pHCG/xuLxhNzsvRIrVjsSEDHJQq31zd3PJbBB5iJ4QHZiSiZx2RyQaXhtpxaITIG
	 vEOWAFnnNEvZbuB2L8r7s5x20ZnB1HYv7dH5D/XwvCxMGa0X1V/Izba9CvWYUiFBFPXFM
	 NV8eWoaiBDlOOKU33GonZqrfus9bxmwOeCzvkp5yLey3JWmQdJZIQpPCE0pOd0FPZFg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789748559;
	bh=+vW/Lptj/tsyYQPLDPFpzzAbuD46832mKCK9uol7W34=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tAtS/6hdZIwo/J7b78Yah1T1r2yefbNQvpzf/Xd6KS2rzDoLfI9i6qcbny2bIpctE
	 cD7yJFW2hm2cgpa7gzCKCUb3gRDL9l4KLDqNnXl0nnAGWBEy4dhZluEUavUvNdkvv1
	 mDFgLoNjcHIK7FLeD8tf/Hv7k6RnQbYfDG+zuRjvKWDI/7NTh2ng/juKZr4bO+X/xF
	 jbawVqiIvQPRyW7ynQHe05PbR0KtPyDb8fTTwPYiZF92/1NFEBasov8QWpmM0gP3dp
	 ucvigrNOISirN7Jt3oHq+5KjiXDG2lAiyelHC9IaeWPvarGuYXxgyUMXami44vDRuv
	 wTK7GMtSkRAEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7744140B02;
	Fri, 18 Sep 2026 16:22:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 911F313D
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 16:22:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 81D4960D62
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 16:22:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MQPnXB1rFddV for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 16:22:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2304460D56
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789748557;
 b=EnjV7t8lJMrkLBmHHFstsHTNdJPZx77PAJuZqGpYM8cTu1nfsP97pP/pKa2rlTGo4Mrw
 IbH9euLmso49g28eo1XLEq2YPpHKZspBl7M+DTaLp+/22j3Z3Mo8up6yZif+LntpHrep/
 PTvwQpntd6fCgZldbWiwd8qGFL3R0Lh22oVzeX/78vijx8yul63bfUA19cVSBkRj8ryc9
 +8EeRChC0RyypxBA9C5Ox3JxfAG6Zz8YecolzQRh9Kwx8BHeCqecJTlCw4VOs7lpfpil8
 8fIxi/Dz6shwze2iS+QGu/iEWlGyqpCQxxg0jRAh0Rgqvw+KCOFdmRERoJ4o5sA1VjA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789748557;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:Date:From:To:
 CC:Subject:User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
 UI-OutboundReport;
 bh=+vW/Lptj/tsyYQPLDPFpzzAbuD46832mKCK9uol7W34=;
 b=aWfiQ/kYgbji2FPeZe7QF0mzs7JqPyTOKSEpJh63ZklL5gVTE8oConul4RizlD9Am8q5
 HpACWwDeaw9/8Spc61JDgLNLkEdKhjkV9OMXvr80tNJaqBwEHvlYMAOtYjmZ0P/YVkhZX
 6gu8Scp/vkv8156AubyC2rn2iz7iEv7TH4FFbCJlEXhdPHSQpAG0XbkHUdXTjcata/1k+
 QRKWMs1dp9ECaIAOqy/PXo64/7RJzhnMCwuDyjaApKjPcg1YewpjSTEMZKVVinclGHFUC
 mG6ErrfAEBfeABuGKVe3DofqD7O3WTWWl3M1yze40a/4WMYqQ8iq87Si/q56GSsu6wQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmx.de; 
 dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b="ikzPA/Qp"; 
 arc=none smtp.remote-ip=212.227.15.19
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.19;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de
 header.a=rsa-sha256 header.s=s31663417 header.b=ikzPA/Qp
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2304460D56
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 16:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1789748546; x=1790353346; i=xypron.glpk@gmx.de;
 bh=+vW/Lptj/tsyYQPLDPFpzzAbuD46832mKCK9uol7W34=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ikzPA/Qpot+zoKpO6tjOd5k5SiX+1lXZKvznvsDfN+TkpLEXbA5zJe2LSeQ8z7u4
 ZaCkUNL+oEdGwB/LEvopG/KQG2giLTBY7/mwLJF8KsSETmXaqoAdW9M8CcAm1/xi8
 Lhd7NSbhRXrBLWLY29zRD7Ne3ydJ04ar3Giiyy7ujOF2PpOuIEAyhZmnQOQb6vKpX
 OUqb3tzNijcFuNMjv2Gi7q++eXcxaozHu87wg9KBCSpHtfesqyHhgq9MWudMKu8qj
 +1S24XnuzDmnMA5yJ6EHx84t9BJxcQpXztu9m9q6cysyRa4CL8aEm9PbA595ignpH
 1xKnHOVtx7cSNGxtkA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5QF5-1x6DmG3RNV-003f6k; Fri, 18
 Sep 2026 18:22:26 +0200
Date: Fri, 18 Sep 2026 18:22:23 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: =?ISO-8859-1?Q?Vincent_Stehl=E9?= <vincent.stehle@arm.com>
CC: u-boot@lists.u-boot-project.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Alexander Graf <agraf@csgraf.de>
Subject: Re: [PATCH] efi_loader: fix string table reallocations
User-Agent: Thunderbird for Android
In-Reply-To: <aqz7nmtoJPGdjwdC@debian>
References: <20260917-ptr-v1-1-7d60d07b849e@arm.com>
 <BC138B74-47B8-4DC2-9EB9-5FE389909AB5@gmx.de> <aqz7nmtoJPGdjwdC@debian>
Message-ID: <FA1BF842-7E1D-4CF3-B744-681CEEE150AD@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q+/ab/4+7pqK9gfM1xS/Q50b/ofnMJ6I/HDTVN3kzhiI3YiOCGD
 zuP4L6CUFqqp6NZ4oPYouMr0jamlTR+nwUDRlPorrCX1AhZSXAm5clZVEV1kaXp1TBJn3Af
 29XQYUwg98dm0cMlkuf6JVBgNMYf2+k4qkK0IDMQOpwSze+GtV5bY9VXOl2nsEw9E4iO7Tw
 d6btYDKZqNnB2TZer8D5w==
UI-OutboundReport: notjunk:1;M01:P0:5KnkK6alMko=;IbhET04YoP+a73OssXFq0ZEnAQI
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

Am 18=2E September 2026 10:51:42 MESZ schrieb "Vincent Stehl=C3=A9" <vincen=
t=2Estehle@arm=2Ecom>:
>On Thu, Sep 17, 2026 at 06:23:11PM +0200, Heinrich Schuchardt wrote:
>> Am 17=2E September 2026 11:45:31 MESZ schrieb "Vincent Stehl=C3=A9" <vi=
ncent=2Estehle@arm=2Ecom>:
>> >The new_string() and set_string() HII string protocol functions keep
>> >using old pointers after calling realloc(), which may have moved=2E
>> >
>> >The set_string() function also assumes that reallocation only grew the
>> >array by one element when computing the start of the memory to clear,
>> >and forgets to update nstrings to the new table size after reallocatio=
n=2E
>> >
>> >Repair and factorize the reallocation code in a new grow_string_table(=
)
>> >function to fix those issues=2E
>>=20
>>=20
>> Should we add a test in U-Boot and possibly in SCT?
>
>Hi Heinrich,
>
>Thanks for having a look=2E
>
>I think the existing "HII database protocols" self-test is sufficient, th=
anks to
>the change=2E
>
>With this test, before the patch, the code coverage is fairly good in
>new_string() but is poor in set_string()=2E
>
>After the patch, the code coverage of grow_string_table() is fairly good =
as
>expected, and the poor code coverage of set_string() is "gone"=2E
>
>Best regards,
>Vincent=2E

If the test did not fail before your code was added, there must be some te=
st case missing=2E

Best regards

Heinrich


>
>>=20
>> Best regards
>>=20
>> Heinrich
>>=20
>> >
>> >Fixes: c9bfb22296b0 ("efi_loader: Initial HII database protocols")
>> >Signed-off-by: Vincent Stehl=C3=A9 <vincent=2Estehle@arm=2Ecom>
>> >Cc: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>
>> >Cc: Ilias Apalodimas <ilias=2Eapalodimas@linaro=2Eorg>
>> >Cc: Tom Rini <trini@konsulko=2Ecom>
>> >---
>> >This can be tested on the sandbox with the following command:
>> >
>> >  =2E/u-boot -T -c 'setenv efi_selftest HII database protocols; bootef=
i selftest'
>> >
>> >While the unit test does cause reallocation with new_string(), it does=
 not
>> >with set_string()=2E
>> >
>> >Further testing can be done by forcing stbl->strings =3D NULL, just af=
ter
>> >calling realloc(stbl->strings, =2E=2E=2E)=2E
>> >---
>> > lib/efi_loader/efi_hii=2Ec | 64 +++++++++++++++++++++++++++----------=
-----------
>> > 1 file changed, 36 insertions(+), 28 deletions(-)
>> >
>> >diff --git a/lib/efi_loader/efi_hii=2Ec b/lib/efi_loader/efi_hii=2Ec
>> >index 7bf51ad43d1=2E=2E90dff91e5d4 100644
>> >--- a/lib/efi_loader/efi_hii=2Ec
>> >+++ b/lib/efi_loader/efi_hii=2Ec
>> >@@ -822,6 +822,37 @@ static bool language_match(char *language, char *=
languages)
>> > 	return false;
>> > }
>> >=20
>> >+/**
>> >+ * grow_string_table() - Grow a string table if necessary=2E
>> >+ * @stbl: String table to grow=2E
>> >+ * @n:    Minimum table size desired=2E
>> >+ *
>> >+ * Make sure a string table can contain at least n elements=2E
>> >+ * If the table is too small, reallocate the memory and clear the new=
 elements=2E
>> >+ *
>> >+ * Return: false in case of reallocation error, true otherwise=2E
>> >+ * In case of error, the original string table is left untouched=2E
>> >+ * In case of success, stbl->strings and stbl->nstrings may have been=
 updated=2E
>> >+ */
>> >+static bool grow_string_table(struct efi_string_table *stbl, u32 n)
>> >+{
>> >+	void *buf;
>> >+	u32 old_n =3D stbl->nstrings;
>> >+
>> >+	if (old_n >=3D n)
>> >+		return true;
>> >+
>> >+	buf =3D realloc(stbl->strings, sizeof(stbl->strings[0]) * n);
>> >+	if (!buf)
>> >+		return false;
>> >+
>> >+	stbl->strings =3D buf;
>> >+	stbl->nstrings =3D n;
>> >+	memset(&stbl->strings[old_n], 0, sizeof(stbl->strings[0]) * (n - old=
_n));
>> >+
>> >+	return true;
>> >+}
>> >+
>> > static efi_status_t EFIAPI
>> > new_string(const struct efi_hii_string_protocol *this,
>> > 	   efi_hii_handle_t package_list,
>> >@@ -847,23 +878,12 @@ new_string(const struct efi_hii_string_protocol =
*this,
>> > 	list_for_each_entry(stbl, &hii->string_tables, link) {
>> > 		if (language_match((char *)language, stbl->language)) {
>> > 			efi_string_id_t new_id;
>> >-			void *buf;
>> > 			efi_string_t str;
>> >=20
>> > 			new_id =3D ++hii->max_string_id;
>> >-			if (stbl->nstrings < new_id) {
>> >-				buf =3D realloc(stbl->strings,
>> >-					      sizeof(stbl->strings[0])
>> >-						* new_id);
>> >-				if (!buf)
>> >-					return EFI_EXIT(EFI_OUT_OF_RESOURCES);
>> >-
>> >-				memset(&stbl->strings[stbl->nstrings], 0,
>> >-				       (new_id - stbl->nstrings)
>> >-					 * sizeof(stbl->strings[0]));
>> >-				stbl->strings =3D buf;
>> >-				stbl->nstrings =3D new_id;
>> >-			}
>> >+
>> >+			if (!grow_string_table(stbl, new_id))
>> >+				return EFI_EXIT(EFI_OUT_OF_RESOURCES);
>> >=20
>> > 			str =3D u16_strdup(string);
>> > 			if (!str)
>> >@@ -957,20 +977,8 @@ set_string(const struct efi_hii_string_protocol *=
this,
>> > 			if (hii->max_string_id < string_id)
>> > 				return EFI_EXIT(EFI_NOT_FOUND);
>> >=20
>> >-			if (stbl->nstrings < string_id) {
>> >-				void *buf;
>> >-
>> >-				buf =3D realloc(stbl->strings,
>> >-					      string_id
>> >-						* sizeof(stbl->strings[0]));
>> >-				if (!buf)
>> >-					return EFI_EXIT(EFI_OUT_OF_RESOURCES);
>> >-
>> >-				memset(&stbl->strings[string_id - 1], 0,
>> >-				       (string_id - stbl->nstrings)
>> >-					 * sizeof(stbl->strings[0]));
>> >-				stbl->strings =3D buf;
>> >-			}
>> >+			if (!grow_string_table(stbl, string_id))
>> >+				return EFI_EXIT(EFI_OUT_OF_RESOURCES);
>> >=20
>> > 			str =3D u16_strdup(string);
>> > 			if (!str)
>> >
>> >---
>> >base-commit: 2c7eaee7b3422ce7c84e892abfe16e1afce42e83
>> >change-id: 20260916-ptr-670be74dcbd3
>> >
>> >Best regards,
>> >-- =20
>> >Vincent=2E
>> >
>>=20
>

