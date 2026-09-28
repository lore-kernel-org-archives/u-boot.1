Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF73C9833F
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 13:42:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0DC8680CCB;
	Mon, 28 Sep 2026 13:42:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m6AFvvuVo9vP; Mon, 28 Sep 2026 13:42:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9E6A480BB2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790602934;
	b=BuSAtqIViaszvEzeX0ndtHy37VRv1yKW178ymTJCjRH4lrisrbjTEPKEi7HENQOU6Wtk
	 o6HrDCaz+YhnBDN22OUptWv10CntFs5J6h4WCKIPWcfmDBS0APh2foIQ1H8SAzrh+YgLk
	 8v//YI25tzWqXJ0B+DGZLy07sX8gmMNavRCTPBuxMZAuz+0M/9KumWvbVQSFrn7Z1dShT
	 IxM7BMHuZpi2foBFWsFE3IXblG3nOf/lvHaF4oWSTDChADgmaMtlNABeMJIbMI6iZ86Pl
	 6h+JVgvkkpMrdEQ6Mg/3N8aiVoFXX0Gr/xmXEbTf90Fiw1zSfNVAlrKrArCELCjzW6w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790602934;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wjAXp/9SwW0PDF81hYZdtpueqXiatWbbtJEJpiepP5Q=;
	b=lMP7kwzeXcAEu0hNvbDArVlHHiDG9lJjjXOwFfu4+DS1JlB36RUVW8lCwt4jOpX9EkXO
	 WUEGu6PVpndSat8925QZR1tBE028bodXByt45/AvNkcLOyh/D0HFDZsQhjf+36Mx9AV0K
	 5v07tm8AEMBtIZ1+et36HxChDV+j7ygG2r7UQ6RrHT6TEQ8OM6HO0oQZFd9jA1gbe8yau
	 vmox2mqWhWH+v075xlEARE6ZkgbaE3CHD3vwoHV+D+zOhbboiFNm5MEIXROC7vSzeeuh3
	 +IXtJfVjaT7j4YTKFnEK/Nw6fAASO1GRKFTo6flIw0C3tago3LbOaCthg0AWJRYeU3w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790602934;
	bh=wjAXp/9SwW0PDF81hYZdtpueqXiatWbbtJEJpiepP5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CMmRyeeprjpkohbMeVt9u16tHX2YMKs7tiKWBGr0fLF3XKXjU/HTNsYiJiABJrglT
	 jXb6NiaVlpGyVxOBgqoHRApB0ml6tPCFkPcmVYOhdaCTHjxZeb4DHnLHp9Jd3RCcjt
	 HFFIyURX2LnFiXkUlUE0Z22lsy8wG1ahb0i7onsUDjxpyVd7HWhesyzAqB6s6iv58Y
	 wE2puvVRfnR8WJG7Anmi74lQyk45nXWBSA8jnIg6lNqGP/ln4z2bnCvDlCmNQ1ywL2
	 /3NWHv8TGm3PCPKuVcILShUbcIjKSrifLHDTzEDFTMi8L+7Qjzul2/HMCbpVqqvnDj
	 CHazmGP5UlkZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E6A480BB2;
	Mon, 28 Sep 2026 13:42:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C082232F
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:04:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B2A11405DA
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:04:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 63cxiFMzcPs4 for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 11:04:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CD089405C5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790593491;
 b=dvY8yEfW1WXDZgMBsjEiK4CN6yvpPymThMcNUe0lkLtzFRn6dD4o8cHQmtI9JQWJ5yWG
 yTEHeggmPd0Xg77jdTtkGKdgLbpaJym4T4u+aOULjAZeHs2OsBo5QE33m66tWRFggy5tg
 mKlrKmsP1vAI+fwxfuGln02Cvm6cJzm9qRPVjOQMMCA2lqLsZgP+HNarFg4r2pUwf5kK5
 uAE31QWXZ0G1TO/Mcuo7equY9wcfZPDF7J3Vh/lGwjayB6fOqCRAm8EHlUrK++A9L9ZuW
 4G5n/n1+i7FZkvwjy5fDox7tzAJHp7BXR2tRzzlj+7o6LRw+RThkqCbLAJaffHMwFeA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790593491;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=wjAXp/9SwW0PDF81hYZdtpueqXiatWbbtJEJpiepP5Q=;
 b=Aqs+YO4uPsT0l8Nsm+ipdoFlEvrUmTMMabVVmh/z2LvaJjIlKlKoONvNfYCJv6eoSb2s
 LkGBCwcWJBUnnelwZ9MVJM0+0ubqmOKleKqy+N9bDOs3wTgFDJcq15ReM5rRhsgOLdKAN
 hiX3X4bCwf8m/3soYTPj5wOBgvCsrO8isShVgDcP62A5ENpNskIrKFxv4E87i8CEHHJkw
 zI+ch+JHYTrztQntbCVkAux++PUf4VpFkcIudP46jbicRIVvLpZRoODRdnFliyMV3eCRK
 UMq3cNer7HbYe32R9sDbjTgsCsurvR19Mhp7XrYioyiIVdFF3QQ+a+83645iC14KzZA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=JbyltYw9; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=JbyltYw9
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CD089405C5
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:04:50 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912e4b11so15998855e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 04:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790593488; x=1791198288;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wjAXp/9SwW0PDF81hYZdtpueqXiatWbbtJEJpiepP5Q=;
 b=JbyltYw9UNbFFy7MC9VzcIZ8pQE1ncweXtwWk8+R+HIpWFToySJegEbR4eEn9pbhJu
 E57/fU9v9+IadHs07pnfFnrWwzc96ZFLR/CI7XSEqhQoKJZp1CEf8VrUIh6mkQRe3H51
 0tc/h8AdntVKFDUzYbDFJpKSc0v7g6RHnjGAQslRgeTA3iEPdBJPC1RwnQmKocLWOSbd
 lZYNO4L847IfYXThk5gyp1cMganVwCiAIbvw7HNQbvYmDQX5rEx1KnZEGd502TJ4W0ls
 /wNZQkXK6Pte8Q5KNdCCr7ICLW6suQ8nMpvXGeONtse8M49aa/csvmt/CWo3le8e5DqH
 6x8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790593488; x=1791198288;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wjAXp/9SwW0PDF81hYZdtpueqXiatWbbtJEJpiepP5Q=;
 b=d+O1y4+MSJvkS6i+dFufN+vMAU8YEou7vNR+qW7OU0rMMgHHOhShLCvYdKLgACgWOs
 qWe3VWHwR3kuLPlZXhxTKAhz7DG0w2xyzBziD7cOXBagZVQQNzyW6ngT/JLX+qWe9qH9
 +TZFYOG7HIxt1EckUNIlXkSan34fSMzLcJJA477q546miZpZXyrGZ5W54cp26Pk6zdtb
 MvhCLKaIUgHaBqJQ9TSGoRZFxHA501EF/YhM4OJNnOVkf6FYy37zA2G1YWFlboIG+aOx
 fe9rl6Y10+5RqEyH7noHApoyHgb/v+khaJi3lrIBlgYDxQpomHSbjEarUxWoSjwx1VZs
 sTOg==
X-Gm-Message-State: AFuF++mg38qZNVnMArGXnXeVliDIwBk4U4W2KUxEtTUVoVJqX7FV3ALC
 u5oqjXKNRSseUxMvNKqq+osB6pfKeD89BreIOqrtBTKBs9I2PY/Kv8D7FxUDiQaLrNE=
X-Gm-Gg: AYBFou0M6rYxiOb5N+HJw9gc1XRpCMfISBkhflfnhUyGmegSZUgoJ2VJwhNLAqeqddJ
 FqVKoAsVUOGq9IoTnfz3IIrLCg0Q4KtSO47sq9wOy0OCiNytgMoas5PtaQ2hQ8T5QvUJEVjUa5r
 ++qomZon28Ky3EnZxsIN8cj9v6j9njO7UYvGSgNvxES82EFoqz1Iu+3K5iEJbV50NyMoOr2zIsU
 3KmatciCRfZ8INjgKsJ3mtOxc1f2syt7DAw4KfbLhWMDmaSIevYHog+ZO1bE0zy6WfGdtlWe/G0
 FkLJFJwlVptOPzj26d96H+lgmEdNvWFv0fIQDK+xvxKgk3Sbu3++k/KnGQR1/LsNnOGsHPs/PdS
 ZNwbya0x3cOwD9BM1V1Wyn6c8+DKda8ZuWU0sDo4rmNmyb9H5Dhrr+h3uS6yKw2x3ZQ3aQDoPxU
 1PYDM/BWnknp1mNeTb2jkg1IlUL7Xd5C717e/IPj7Xi05nVUl2T6cC1jiDWBXw1QkWFis5v78D2
 JEDv+eOUKZ6hcl8iE6YZLBpQ7Izl4Y3C/3rFulivXrRUAZguPEZ8PNgJ8vizk041u1egS12RFtS
 ZxYZGXa99/4OPr1yMq7UC8r05f9s2NG7taLi7wXj
X-Received: by 2002:a05:600c:4f88:b0:49f:ff32:8044 with SMTP id
 5b1f17b1804b1-49fff328452mr74841745e9.7.1790593488321; 
 Mon, 28 Sep 2026 04:04:48 -0700 (PDT)
Received: from localhost.localdomain (37-188-186-98.red.o2.cz. [37.188.186.98])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0017816efsm131458075e9.9.2026.09.28.04.04.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Sep 2026 04:04:47 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>,
 =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Priyanka Jain <priyanka.jain@nxp.com>, Qiang Zhao <qiang.zhao@nxp.com>,
 Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Christophe Leroy <chleroy@kernel.org>, Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: [PATCH next 01/13] Makefile: Skip undefined symbols in keep-syms-lto.c
Date: Mon, 28 Sep 2026 13:04:22 +0200
Message-ID: <20260928110434.70686-2-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260928110434.70686-1-pepe.schlehofer@gmail.com>
References: <20260928110434.70686-1-pepe.schlehofer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Sep 2026 13:41:44 +0000
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

The generated keep-syms-lto.c gets an __ADDRESSABLE() entry for every
linker list symbol that nm prints, including symbols the input objects
only reference and nothing defines. keep-syms-lto.c is compiled with
the LTO flags filtered out, so such an entry turns into a hard
reference that the link cannot resolve unless .discard.addressable is
dropped.

The turris_1x SD card SPL, for example, links
board/CZ.NIC/turris_atsha_otp.o, which references the ATSHA204 driver,
while the driver itself is not part of the SPL. With LTO, which mpc85xx
allows later in this series, and without the /DISCARD/ rule that
"powerpc: mpc85xx: Discard LTO keep-syms sections" adds, its link
fails:

  keep-syms-lto.c:5:(.discard.addressable+0xc):
    undefined reference to `_u_boot_list_2_driver_2_atsha204'

Pass --defined-only to nm, so that only symbols defined by the scanned
objects reach the generator.

Fixes: c1094987d1dc ("build: support building with Link Time Optimizations")
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Marek Behún <kabel@kernel.org>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
---
The option goes to the two callers rather than into the script, as the
script runs the command it is given, which can start with a wrapper
such as the ccache that buildman can put in front of the toolchain.
---
 Makefile             | 2 +-
 scripts/Makefile.xpl | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index c898f4b9df3..e8615c247bd 100644
--- a/Makefile
+++ b/Makefile
@@ -2076,7 +2076,7 @@ u-boot-keep-syms-lto_c := $(patsubst %.o,%.c,$(u-boot-keep-syms-lto))
 
 quiet_cmd_keep_syms_lto = KSL     $@
       cmd_keep_syms_lto = \
-	$(srctree)/scripts/gen_ll_addressable_symbols.sh $(NM) $^ > $@
+	$(srctree)/scripts/gen_ll_addressable_symbols.sh $(NM) --defined-only $^ > $@
 
 quiet_cmd_keep_syms_lto_cc = KSLCC   $@
       cmd_keep_syms_lto_cc = \
diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
index a3fd3e1375f..53522ced84b 100644
--- a/scripts/Makefile.xpl
+++ b/scripts/Makefile.xpl
@@ -491,7 +491,7 @@ u-boot-spl-keep-syms-lto_c := \
 
 quiet_cmd_keep_syms_lto = KSL     $@
       cmd_keep_syms_lto = \
-	$(srctree)/scripts/gen_ll_addressable_symbols.sh $(NM) $^ > $@
+	$(srctree)/scripts/gen_ll_addressable_symbols.sh $(NM) --defined-only $^ > $@
 
 quiet_cmd_keep_syms_lto_cc = KSLCC   $@
       cmd_keep_syms_lto_cc = \
-- 
2.54.0 (Apple Git-157)

