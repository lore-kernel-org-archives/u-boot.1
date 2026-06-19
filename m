Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C295BCD98F2
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 16:46:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E65784874;
	Fri, 19 Jun 2026 18:46:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="MwlVYxrJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31627848EB; Fri, 19 Jun 2026 18:46:24 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 241E184873
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 18:46:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1781887581; x=1782492381; i=xypron.glpk@gmx.de;
 bh=GaLxedKd0wXSnxlpWHbZaB71n5Xx2kYr1+SSKJXY1w8=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=MwlVYxrJGXMNQRXb6DFy+1/kvyNVMwcpOu+xhj+6zfsWSKqlRQSr7HQMzxWXz/NC
 bX4kNdMXv8drpd7D098IRqXYpWfi0tCJAYCNiNqBc4tm/9kKsiaXfOspnjBe2NBIZ
 Qh2CS9NC+9O9cpsnHDCgahQIOfAjp4EbS4ZYCfn83u51QKPehz/rGuzh+5zkXlGvn
 r0GM0XmhQgfl+fWeZF9hgYGzp2B8nyZVKBqRvsoL4i7/I3v+cDosiF6gjFkXmIe3F
 ryBYH3Bb2uOcWd7E4IFtWBGVc1He0M7YiTWEO8gqUOD3aRr0iDQPREvEhc6nWP1s+
 SYTVzWfOA1T+BCVSIQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mgeo8-1x6eJc36uC-00qMQy; Fri, 19
 Jun 2026 18:46:20 +0200
Date: Fri, 19 Jun 2026 18:46:06 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Jon Mason <jon.mason@arm.com>, u-boot@lists.denx.de
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] efi_loader: move efi_var_seed.o to objtree
User-Agent: Thunderbird for Android
In-Reply-To: <20260619155857.9665-1-jon.mason@arm.com>
References: <20260619155857.9665-1-jon.mason@arm.com>
Message-ID: <FC600559-0FE9-4EA3-B047-F69CEAB64795@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:68M/oBxfaxQoMPb4rNIu0Un1dYzoWQm7qeTQsyA+4i4WPLHYvTl
 y7VQWbmiLnEQQsv3YVwfjJSz3nOYmDjMtMHARn1uvC+ZvUx0YcKEbwtclXTjB01zL05itzi
 x2EGrL5mlIvGriizJkUphSWJLzBGdjcj+nOnjh5SAgozD+o99zsCLkPxjt+ZkzTcmDi5A7B
 bwnkcF2uk6iD9rMzxc2SA==
UI-OutboundReport: notjunk:1;M01:P0:ZCgAscyltwM=;jjskHwfFJubDrZjlW+8thZ0UyOB
 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
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

Am 19=2E Juni 2026 17:58:57 MESZ schrieb Jon Mason <jon=2Emason@arm=2Ecom>:
>With commit bd3f9ee679b4d1456d0d3c261ab76788950e6096
>(kbuild: Bump the build system to 6=2E1), there is an issue when trying t=
o
>build out of tree, where efi_var_seed=2ES wants ubootefi=2Evar to be in t=
he
>object tree, but lib/efi_loader/efi_var_seed=2Eo wants ubootefi=2Evar to =
be
>in the source tree=2E

Ubootefi=2Evar is an optional file with the EFI security database=2E Why w=
ould you ever put it into the build directory?

Heinrich

>
>If we change efi_var_seed=2Eo to look in the objtree, then it should work
>in both local and out-of-tree=2E  However, it would require anything
>previously working to put ubootefi=2Evars to the objtree, but it's broken
>now anyway=2E
>
>Signed-off-by: Jon Mason <jon=2Emason@arm=2Ecom>
>---
> lib/efi_loader/Makefile | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
>index f490081f6542=2E=2E9c836f6ee237 100644
>--- a/lib/efi_loader/Makefile
>+++ b/lib/efi_loader/Makefile
>@@ -74,7 +74,7 @@ obj-$(CONFIG_EFI_ECPT) +=3D efi_conformance=2Eo
> obj-$(CONFIG_EFI_DEBUG_SUPPORT) +=3D efi_debug_support=2Eo
>=20
> EFI_VAR_SEED_FILE :=3D $(subst $\",,$(CONFIG_EFI_VAR_SEED_FILE))
>-$(obj)/efi_var_seed=2Eo: $(srctree)/$(EFI_VAR_SEED_FILE)
>+$(obj)/efi_var_seed=2Eo: $(objtree)/$(EFI_VAR_SEED_FILE)
>=20
> ifeq ($(CONFIG_EFI_CAPSULE_AUTHENTICATE),y)
> capsule_crt_path=3D($(subst $(quote),,$(CONFIG_EFI_CAPSULE_CRT_FILE)))

