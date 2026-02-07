Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B320FEE0ADC
	for <u-boot@archiver.kernel.org>; Sat,  7 Feb 2026 14:19:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADE4083C14;
	Sat,  7 Feb 2026 15:18:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=rwahl@gmx.de header.b="lleu2F1Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C6C883A64; Sat,  7 Feb 2026 14:48:40 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2172383642
 for <u-boot@lists.denx.de>; Sat,  7 Feb 2026 14:48:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rwahl@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1770472114; x=1771076914; i=rwahl@gmx.de;
 bh=Hfe00Q3Y/piaaGVrDoyaVdouSFBLzTChLJ/Le3TwZro=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=lleu2F1Y5c+QLzlvkUceNDJSDi7pE9ycQIdkFSc8dd5zJA5bK38IfY4VGAI0K+q7
 d5C9K4jmoxfHMb7WaUqhnpmrerLMZgStaY0wffcwwqDkHQT0ijL7ttqoZQ1CoIG1m
 od3VM4yx3IJc0qIYRlpoVpWJ9C5wStuEsQBxJxd6kAE8NGuJRhgAiOQmYkdmr6afF
 gxyw6ymZslFIaq37i4C5hKNWSWj+o9eakz/OnzUB2mZHEF56ciHX2G9w7K7QR9itr
 iTDKqi3J58aIEZmmbwftZ8cnLM8cHNFWjMSK3ineBjBoWlFt5igU6o8Kck2YosuWD
 mP4S40UMHEqqYfzm0Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.24] ([84.156.147.204]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MStCe-1wFe0q1G50-00Jhvl; Sat, 07
 Feb 2026 14:48:34 +0100
Message-ID: <34910742-3f12-4470-9042-8f592252be67@gmx.de>
Date: Sat, 7 Feb 2026 14:48:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Confusing memory layout after spl_relocate_stack_gd()
Content-Language: en-US
From: Ronald Wahl <rwahl@gmx.de>
To: Nikhil M Jain <n-jain1@ti.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <85942c08-47ba-4874-870e-700d32a9356f@gmx.de>
In-Reply-To: <85942c08-47ba-4874-870e-700d32a9356f@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CU56HXCg1fzEKWT90nzfw4I6urXanBm8qhzB3UJtIHkVTyRsftA
 WH2Oy0rDlZulhDJUgjgt7rlcwetTGz0jLLxOi0eu10yTfX23g93f180XudWnJ/5iCe64DIG
 ykd1M9FQ22UNtL6KVr7dukw9HnrovM5ddgWZ0T4McW5pcmDC7TsnZ+RmQW4jLZN2RJLhDyL
 0Hqx/0+Xs4R5pGDOsLiwg==
UI-OutboundReport: notjunk:1;M01:P0:qK/4/zS6fcg=;+yfpVy+M5cVX+8Xv7//RAWqYZ2O
 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
X-Mailman-Approved-At: Sat, 07 Feb 2026 15:18:52 +0100
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

On 07.02.26 13:42, Ronald Wahl wrote:
> Hi,
>=20
> I'm a bit confused about the stack location after calling=20
> spl_relocate_stack_gd(). Looking at the code of this function I see that=
=20
> the stack pointer is in the simple_malloc heap before the global data.=
=20
> That means that the stack is growing downwards into the heap. Also the=
=20
> malloc_limit includes the global data memory. This looks quite odd.=20
> Wouldn't it be better to set the stack base the same address as=20
> malloc_base?

To be a bit more precise here: The global data must also be moved before
the heap because the caller expects the return value the stack pointer
and the global data pointer (at least on ARM and RISCV). The layout would
then also match the pre-relocation layout. The fix then is just a one-line=
r:

diff --git a/u-boot/common/spl/spl.c b/u-boot/common/spl/spl.c
index 3dd652e395a..44c16125fb6 100644
=2D-- a/u-boot/common/spl/spl.c
+++ b/u-boot/common/spl/spl.c
@@ -902,7 +902,7 @@ ulong spl_relocate_stack_gd(void)
         }
  #endif
         /* Get stack position: use 8-byte alignment for ABI compliance */
-       ptr =3D CONFIG_SPL_STACK_R_ADDR - roundup(sizeof(gd_t),16);
+       ptr -=3D roundup(sizeof(gd_t),16);
         gd->start_addr_sp =3D ptr;
         new_gd =3D (gd_t *)ptr;
         memcpy(new_gd, (void *)gd, sizeof(gd_t));

> In the documentation[1] there is also a picture (DRAM SPL after=20
> relocation) that illustrates this. The Stack region is just placed wrong=
=20
> there and never used as the stack grows downwards. It must be above=20
> malloc_base.
>=20
> If you think my thoughts are correct I can prepare a patch.
>=20
> thanks,
> ron
>=20
> [1] https://docs.u-boot.org/en/latest/develop/memory.html

