Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A19DC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 09:10:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7669686F5C;
	Mon,  6 Nov 2023 10:09:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="kcCIrLUq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3112386E09; Mon,  6 Nov 2023 10:09:57 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46B24868BF
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 10:09:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1699261791; x=1699866591; i=xypron.glpk@gmx.de;
 bh=GBzH0mS2h4AKS1ExcyImsftq553YMv+oKBzUn+HlwXI=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=kcCIrLUqh8HeG4d/H7GryaBSXjwlE2y4Idu6wp1U62Up4SiOsXPWSufjUzPPK/bY
 xiM3C6dpJi9FHwDRQVvg5J0nSHET2tyJhTzVTvzqW8TcKZCSK786mUZbR3oRhLta1
 IpY+TPbIKX3W5KlOqVGpg1iZP+GfFEzicvvBxX0eL29OrafOMx+k2LoGWAdwBzJjN
 z0lXzt27TN5I+iQpuh1hvQEDkZsnElB/OiBllscccOZmo8XhwM/uhFsg1zE5iPJdY
 M5sVdl4Bd/Aazoc4fiWc2tCWAtYDkv7O6STxs8TVOpDzH0X6IJpuE4NXRX6YhQZ3L
 Hkivl7kKG/AyXC8QaQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from LT2ubnt ([4.28.11.157]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmlXK-1rjOzA2QYI-00jolx; Mon, 06
 Nov 2023 10:09:51 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] =?UTF-8?q?.mailmap:=20map=20Pali=20Roh=C3=A1r?=
Date: Mon,  6 Nov 2023 01:09:08 -0800
Message-Id: <20231106090908.7938-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WBjozN8wQEeazo1yzQEZxHifpfdqFh0M5sBrdT744GCD3iv5mU4
 lI08DiKrn4GB2Z/Q2OUVPERRfda+2iG3asGcD7HQUTUWgjpUptirGsfhO0VJVekocKvyk0x
 XtNIf6faFlLmpJ6H4taJYMeHuN/dzuJCsGP6nK4wLgweU1Zx3QCxSRreMWreVprdXnA2Uwt
 aMdVsnGsybQQQ8/dOMmBg==
UI-OutboundReport: notjunk:1;M01:P0:lF754ABEoII=;cKUekG1jYp1Le7W1vqA3KPVPaTF
 EN3XT/PLhaAGf1yuMrJRcblhEDBXdnpHYoNtODtYtek+C7DPIeLDxKRcJvPWXpAH2HpVUK9Zh
 JPbZOjK+WyKUpLL3sbKeht78VKf1OO+A6TEv4lsXaaqubVwf1IY6DaHOlgrumCx7NIUNWOZi5
 9+ZZDNC1pxQNYYnYZGpWH84pJ5VwEuKKqm9JDZky688vbGYeGS5ocVDdtveOh6EjQKcDvUraD
 EhZuyMusil1lLmYb+Ef3vG5Q8wFN9FtZBkJK4dtWCI3WPnEG5b6xVXFDokci7Z2rWi0z52OG2
 deALlxepXnY8ewCdgXIPa+dpFSKeLl43Gdfp+J3Wd1t0L0E6o7jBfYs0pu6afSsVoazWzSqdW
 IGqnfilLxcHnwKLkAc6Wz6oa5b0hNYWNbgrzoBsi6zxXVz3KW93q1nk/tiwl5WdRimraA4gbR
 iSs6SnU5Awv7NZokAA3IHe58ujuzyv1I9D0bgFhkb5UGJNqbJRNP1gWKabjHaZR9kDl5B2ZGQ
 ZgH4rIyRmt8z/bsaU/c0u5Mesl4bJAXBdC5FeXdG+o55AfsstpR+o4o9uNdzSTrXd3C6Pso3i
 35+9gN60ls/4FuoyxmowG8AAb+tJESrXu69zj/7Lz4SwsR5hM2MIcCmvKwK7SzLjo8iLhVGF5
 PQJREVA+MvHQA4GgYzTgRGQE0hqzVVnNCA0NTC4U6WfmbpqRHjgWjmgxZc0eNEJ3/m+qJiZ/9
 ceoe9WgcaZSDb8GC3CpK4QrzcKLzuDlxBP8m2Smgg7AqCAYzuP2i/3t0ZLoFagEy7Uy+WYspf
 P2ozW6tV4OJRTE5yENygmStcYhhtrPdsa6Edwb39MfqSGWCFaasgvpb5cnkRr0zJe5Ysip4UK
 DM94RjgFoO5g0LoM8cQJ+DP7/NySf31DNmG8waJW1I4XfwIAEYtNelP/Oy7W1L599p+d8uBci
 pap+Pw==
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

Pali expressed that he does not want to receive mails relating to his past
contributions.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index 05cb310e41..4c0b922488 100644
=2D-- a/.mailmap
+++ b/.mailmap
@@ -80,6 +80,8 @@ Nava kishore Manne <nava.kishore.manne@amd.com> <nava.ma=
nne@xilinx.com>
 Neal Frager <neal.frager@amd.com> <neal.frager@xilinx.com>
 Neil Armstrong <neil.armstrong@linaro.org> <narmstrong@baylibre.com>
 Nicolas Saenz Julienne <nsaenz@kernel.org> <nsaenzjulienne@suse.de>
+This contributor prefers not to receive mails <noreply@example.com> <pali=
@kernel.org>
+This contributor prefers not to receive mails <noreply@example.com> <pali=
.rohar@gmail.com>
 Patrice Chotard <patrice.chotard@foss.st.com> <patrice.chotard@st.com>
 Patrick Delaunay <patrick.delaunay@foss.st.com> <patrick.delaunay@st.com>
 Paul Burton <paul.burton@mips.com> <paul.burton@imgtec.com>
=2D-
2.40.1

