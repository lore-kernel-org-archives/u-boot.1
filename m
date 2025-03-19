Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0ABFC35FFB
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 12:12:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1161F81A04;
	Wed, 19 Mar 2025 13:12:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="UrmXQb0h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFB2981A0C; Wed, 19 Mar 2025 13:12:34 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A82738141E
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 13:12:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1742386351; x=1742991151; i=xypron.glpk@gmx.de;
 bh=IepKDKHFnlddoRvSMAUZ5Oo83vyoZmESLk/0IZ6oVq4=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=UrmXQb0hbUfVrfiMynJEH5O7ouUW0dbToeCC+STAh6L/WfAYkEjhxgp08HniyJEg
 /5NMHi+gNOzNe9J3Wo5mgVly/69DDEtl/YhGc3cevUuT8l31UKX/+dKrlaNIal64h
 gllD8P2ypsM08cx4jxrcU6fVVjE3HKGGAvy7K1VGEwzjn2bixES47fxLLpy3rY91m
 KFENUz6FBeqiPK0VnyC6Jxv7zvDkOx/4t854Clbml+tOCqlcu2NIc7dIwc+tEhgF2
 Snpy3hpRAm79YKfU3UY/cgt/bj2lrXwOt+IlEgTcPsul7iiCOIeYfG7mOJyuY0QIn
 /045u6uu23gzVV4SUg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7sDg-1tpuTU3e2E-002bBf; Wed, 19
 Mar 2025 13:12:31 +0100
Date: Wed, 19 Mar 2025 13:12:30 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 6/6] lib: Provide a signed version of simple_itoa()
User-Agent: Thunderbird for Android
In-Reply-To: <20250319115911.2204045-7-sjg@chromium.org>
References: <20250319115911.2204045-1-sjg@chromium.org>
 <20250319115911.2204045-7-sjg@chromium.org>
Message-ID: <ABCF9413-6C51-4EBA-9907-95C5097A8D86@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IqcpGwqX1RVTCN23Cy7ZB1oX6Ztpt3/2ubpcn7Dru73wCwymp4C
 8VY1Sdg95A+svqDnM1fLRFZNBymYNL5+TUoQLLB4Ylf+m7tWC9Two6670qKAmaiDmGanTz0
 F93dQd3ShVCQdE+gLfqrjejLEuWRIZioMCuU5lhv7MaXA9ioDFM1Az0kPkDDxSQWERJpnfs
 1vRCsTgPCVN74DmYeW8hg==
UI-OutboundReport: notjunk:1;M01:P0:6GwFBf14F7I=;GIV7+GFbwmy6Wnlnb4FIwM35mIm
 METKhEJLH5k5uDrtRNH60ov74NcCE9hDvjUVbelZSEcPuusZlTcPa8036I6UzaSo1LnmwrOc3
 3pQG+e7T+gK3NHNd9x9FA0Z1iR4O+yswiLad2kvnmBFO3ycseJywlV7lHvK6CgZzTeq01hli9
 cMrOVali71PXAU3kGcx8l1Q/BkE9Evvi7fWSYXv0iHrxezbI9kC6OlDA5Flud20T91ejFGmkV
 Ajls+RShCfX8ctgDVo2yxXmvn4HTjTuFoaaI7WrPjwSq2Yq0r6hGPUsT/dSLZxKYOF0e2Z/WD
 lwQwW/vL45BgjPxTQsbQjJckUSvK5+GwyjnEWqjprQUOCrdqavihp4QxScKCCGbdioJoKRPMg
 gH3aIRW+zoorzP8zVmvPX5//QfT41LR5LJg/r19zGv6+FyS+qMBtv16Rxmg9uDg66bPyUt24V
 gsQjc8hI6xeP0mm11qw2MWnAeSWsP4lJU4bT52vB3tOzdvnpjaTcRplgqUcaD099FbkpDG17Z
 DIq5vemyfOnxofebeMJc28Jjg4el6UGJ0WKk+i2nIEEYBJArYF3mIFzIZPmLFsoXqE+zkzhqr
 Ah+sHDkFksH2n25ey6UV4+JDDsA28iSz9oMAwppSinxWHz/xJ5dsv5bXXP4DOP8TL1zPYftia
 dAb2sFAShlYhh+iFrG+Jj+G5yUD6lLiwScFrr6n9tXKct912jJTVI0V//B1MMSX0vStNH7Ck1
 YZYegvOgaZfyd5Dfg0uJdmJOb/GXBe2U4Zcl6CgSW1aKCRwytCB4l9nddFbrorQSCG/3uWfB3
 joO5/zV5gqjoZVeTQ+wuO2IY1Zyns53kOKFHBgWm1rReVIeRlSgFHqxuJLMWUMmDK7KFBUiJW
 dHeVdnd19FapmxmmHGxQ5W+NrZgrPh21n7L/ngRShyhMVT5LzUsQFc6ttQmzspgXg0dq7mOYr
 t235ETUejU/2K/PFNe2cyT4sy7LJ1QqEv0ScpSgdcBRHRG1jF6+3QUJdPomI8+bzj4ok5nnse
 Ui0T7JSGTxHiwStJLC3MqBotTjCNf7rcFSCqhKJHa3NRrZG1QJ/F8ov13p6K3Zx+LhEbjIq2f
 lNGPwe+g312t7O/BhSr3hzC95j0bxZ0gnaVI7Ihxe8FTj427GNpc7x8096jqjsBlGWnDdb5JT
 bdatUp2Y8WuKoDunZzfxRnNJsPAPo6fuuYzHHnixRRmoiiWI5FwAGXUIxP7ik4atVHP+MRWuz
 fl5nS06xLAAMdsmp+0lgpCnojzvcH9eii/7axXqhFCzsSRUghLBzcLn6psJnYtbuaVAiow4NJ
 CAFvYwyLz5szyTyXZC/a20nNoO1L8KlpHLpk+mF9SqHbkZDLcYA+0yg6usJ8zErwIilvouW3b
 mYbodgdj4otZxUtXbmZ+SpctXoGGhzMjxyzU+dNU90mLv/w8kUT+NYDfG5WFdIA31YIO9+3AT
 cIu0jq2JOHGhv2QASoCBWDAhGrZI=
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

Am 19=2E M=C3=A4rz 2025 12:59:08 MEZ schrieb Simon Glass <sjg@chromium=2Eor=
g>:
>In some cases we want to show a signed value to the user without needing
>to use the full printf() implementation=2E Add a new version of the
>simple_itoa() function to handle this=2E

Where will this be used?
Why can't printf be used?
Why would this fit into this series which is about test improvements and n=
ot about functional changes?

Best regards

Heinrich=20


>
>Update the existing function to use ulong instead of long, to avoid
>confusion about which it actually uses=2E
>
>Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>---
>
> include/vsprintf=2Eh | 14 ++++++++++++++
> lib/vsprintf=2Ec     | 29 +++++++++++++++++++++++++----
> test/lib/str=2Ec     | 17 ++++++++++++++++-
> 3 files changed, 55 insertions(+), 5 deletions(-)
>
>diff --git a/include/vsprintf=2Eh b/include/vsprintf=2Eh
>index 9da6ce7cc4d=2E=2Ecd079684572 100644
>--- a/include/vsprintf=2Eh
>+++ b/include/vsprintf=2Eh
>@@ -219,6 +219,20 @@ int vsprintf(char *buf, const char *fmt, va_list arg=
s);
>  */
> char *simple_itoa(ulong val);
>=20
>+/**
>+ * simple_itoa_signed() - convert a signed integer to a string
>+ *
>+ * This returns a static string containing the decimal representation of=
 the
>+ * given value=2E The returned value may be overwritten by other calls t=
o other
>+ * simple=2E=2E=2E functions, so should be used immediately
>+ *
>+ * If the value is negative, a minus sign ('-') is prepended
>+ *
>+ * @val: Value to convert
>+ * Return: string containing the signed decimal representation of @val
>+ */
>+char *simple_itoa_signed(long i);
>+
> /**
>  * simple_xtoa() - convert an unsigned integer to a hex string
>  *
>diff --git a/lib/vsprintf=2Ec b/lib/vsprintf=2Ec
>index c7340a047b2=2E=2E478d445a569 100644
>--- a/lib/vsprintf=2Ec
>+++ b/lib/vsprintf=2Ec
>@@ -845,21 +845,42 @@ int vprintf(const char *fmt, va_list args)
> }
> #endif
>=20
>-static char local_toa[22];
>+static char local_toa[23];
>=20
>-char *simple_itoa(ulong i)
>+char *simple_itoa_(ulong i, bool use_signed)
> {
>-	/* 21 digits plus null terminator, good for 64-bit or smaller ints */
>-	char *p =3D &local_toa[21];
>+	/*
>+	 * 21 digits plus sign and null terminator, good for 64-bit or smaller
>+	 * ints
>+	 */
>+	char *p =3D &local_toa[22];
>+	bool neg =3D false;
>=20
>+	if (use_signed && (long)i < 0) {
>+		i =3D -i;
>+		neg =3D true;
>+	}
> 	*p-- =3D '\0';
> 	do {
> 		*p-- =3D '0' + i % 10;
> 		i /=3D 10;
> 	} while (i > 0);
>+
>+	if (neg)
>+		*p-- =3D '-';
> 	return p + 1;
> }
>=20
>+char *simple_itoa(ulong i)
>+{
>+	return simple_itoa_(i, false);
>+}
>+
>+char *simple_itoa_signed(long i)
>+{
>+	return simple_itoa_(i, true);
>+}
>+
> char *simple_xtoa(ulong num)
> {
> 	/* 16 digits plus nul terminator, good for 64-bit or smaller ints */
>diff --git a/test/lib/str=2Ec b/test/lib/str=2Ec
>index e62045318c0=2E=2Ed6d29bbf3eb 100644
>--- a/test/lib/str=2Ec
>+++ b/test/lib/str=2Ec
>@@ -221,14 +221,29 @@ static int str_itoa(struct unit_test_state *uts)
> 	ut_asserteq_str("123", simple_itoa(123));
> 	ut_asserteq_str("0", simple_itoa(0));
> 	ut_asserteq_str("2147483647", simple_itoa(0x7fffffff));
>-	ut_asserteq_str("4294967295", simple_itoa(0xffffffff));
>+	ut_asserteq_str("2147483647", simple_itoa_signed(0x7fffffff));
>+	ut_asserteq_str("2147483648", simple_itoa(0x80000000));
>+	if (IS_ENABLED(CONFIG_PHYS_64BIT)) {
>+		ut_asserteq_str("2147483648", simple_itoa_signed(0x80000000));
>+		ut_asserteq_str("4294967295", simple_itoa_signed(0xffffffff));
>+	} else {
>+		ut_asserteq_str("-2147483648", simple_itoa_signed(0x80000000));
>+		ut_asserteq_str("-1", simple_itoa_signed(0xffffffff));
>+	}
>=20
> 	/* Use #ifdef here to avoid a compiler warning on 32-bit machines */
> #ifdef CONFIG_PHYS_64BIT
> 	if (sizeof(ulong) =3D=3D 8) {
> 		ut_asserteq_str("9223372036854775807",
> 				simple_itoa((1UL << 63) - 1));
>+		ut_asserteq_str("9223372036854775807",
>+				simple_itoa_signed((1UL << 63) - 1));
>+		ut_asserteq_str("9223372036854775808",
>+				simple_itoa((1UL << 63)));
>+		ut_asserteq_str("-9223372036854775808",
>+				simple_itoa_signed((1UL << 63)));
> 		ut_asserteq_str("18446744073709551615", simple_itoa(-1));
>+		ut_asserteq_str("-1", simple_itoa_signed(-1));
> 	}
> #endif /* CONFIG_PHYS_64BIT */
>=20

