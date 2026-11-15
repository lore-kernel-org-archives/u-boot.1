Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6601606A32E
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 19:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=prnMcsxa;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KOpFkeP8
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B13CA406AC;
	Sun, 15 Nov 2026 19:00:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KlnQITPiTiZU; Sun, 15 Nov 2026 19:00:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 02469406A5
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794769244;
	b=m73M/GP17RK/Xs/U9CDYURu9re6Om/bmNo5NLeVx9E8sMf/lN3Nnjg8uhLQhkiPc9XKp
	 B5Rf2+nMHwLwybGcIfAmACz6BW9tfiAgxePBK+vOfyrAE5U3NyfxmTApoMaRGGdqjpDMT
	 ogMm/tuArfXmzRRa0jTtvIG7c23pCkcQ4bb7JFrpSf068Sg6buGoUjBYTf3vUJoHrhGGi
	 jCYiNrGXPJ1x73Jd3FsT1y+xsK0q1Xm8uqZz4slvKmHtzwtWXSHN666kwzzEWP9eDF1+u
	 VonViqatlgMvD2eMeN2pHHM7ux6tpK8Bt9G2WARLrL9VmqhDFB2sikx02cm1EKcZafQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794769244;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:MIME-Version:From:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YzytBYbJH+kvFVaW0VWgvVhB+lU8ttg97uvqSj1s5KI=;
	b=rzahndGrr/HhTaioMYPNPiSTcRC2y5atAVzurmUgA9/0YaZKmBOghDrwR56f2a6pD5S1
	 SMPPm25Kg3KrtDTCSmNHO1iA4JJ1YW6RaWaTQ/yI3wHbOEalKzZgcWyVwYUz6L1pzlNvl
	 ZUp3+Bd14YsqBPxufG+sF5Bb6Xwxtg04Vgxj/kLAvhLMy0pr0clTaCr2//uIKwjNRntTi
	 0PHDnJKYG9mZJ1XMEVZ1sBSc4hN4AYEhWDhQQ3E0nVH0udS+0tVyGD1k78dxyePLawOQb
	 iOYzMfd6amFsffl3MhG+IIplUq8TLvYr04qL0IgFCde6t1m8sD+Hw4FE6w3M2RQ2pnA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794769244;
	bh=YzytBYbJH+kvFVaW0VWgvVhB+lU8ttg97uvqSj1s5KI=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=prnMcsxab3arpqA9FGLJQwsidrUybiEJnMnKW5T7Ut9MYsrxViGK2T1yNO4SAjbPy
	 rAQfT7Cl63u9Tuwbyo4aSayY6X7wEQodcEDFjw6qYoivERcK5sexip4/FcRy+2D4Lb
	 3Q9SYZYKMChwFmmlWJI4yZWiR+aFDWXMdntftp49pCyZeF21aUYeHZRZnhfSlgqTWU
	 oiyWRgr4EHsXzUv2dfIN5+wM4dhIZMbrmSHlQjivbuekp7ZNVRRPtZ0DcTprB9o+If
	 E66XotyTpFiEqobBfml7l01XEy7w4JMMYMM4HvseS5RIx6s88VtnHKXaxhRP6abP0A
	 EP4EOIaXX31tg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 02469406A5;
	Sun, 15 Nov 2026 19:00:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9CD271A6
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 17:12:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8026B4008E
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 17:12:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XEPMX0noNjh9 for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 17:12:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A52B340061
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::931"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::931; helo=mail-ua1-x931.google.com;
 envelope-from=georgekola@google.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20260707 header.b=KOpFkeP8
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com
 [IPv6:2607:f8b0:4864:20::931])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A52B340061
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 17:12:26 +0000 (UTC)
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-99c042cee7dso2242802241.1
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 09:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794762745; x=1795367545;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YzytBYbJH+kvFVaW0VWgvVhB+lU8ttg97uvqSj1s5KI=;
 b=KOpFkeP82gXH2ADBzhTx8E2SPozdl5iZEnG5FEreCHswoEv+UMn+EQ3/aUBRgqGDxH
 a3ruQqE3B52GWLeRH75vkN+9XqdUjtQLZacauj8cPEI/Wko6RtCgc0eW/wADMF9qhaaG
 rBEeGAscFqwKUyHkSAvdRWPnhY7/YUii9ftlxouKvod7KMQO4Bb2smjLb9UrITiKTYvH
 Wk3iXh5NdHgHtjK/Ic+81vNeTLtslOVaYyCzKlOde07xe/5RJwknGu3RKzgGlljZFE+f
 Nad1aXz2/v++wd22oJ0U2KMBTRgPwHYHo/Xl8qsO+Bspl70yR5E6lEa+Sf6XNuEeYrhS
 o2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794762745; x=1795367545;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YzytBYbJH+kvFVaW0VWgvVhB+lU8ttg97uvqSj1s5KI=;
 b=Tm2DHDN619ltB20zNN1O0CKtEzZNh1W3wK/ukQPC8kVyhulb3Kn4GuE8QZTW8ro9Yq
 pt2A0SY13KIIsPPifGovaW76XEg70d+kOCZWLIr4T+XxAyh9wInkOqqNXQyE+88qCk9h
 c7v4cvCC8VIv+TiDzdKOzIsKosIDbZIuRMT2Ek9B2AWPUdUmTOmOdtTepnqhHE9TD9sL
 R0JoqClD08lTNxii95MYeuXoCpN1OC6h74n27xkSeFPt8xpbYstmhbdu8NscidQBCPgb
 ZxhiEi66MwcnVX1racTcIUO4rTdrKPpuCsTOf5B8RR4yU2t1/Pa292zd/uJd6AzxznNJ
 Hk0A==
X-Gm-Message-State: APuU4Z8h2/9oAYFoewri44QS2+Nhy+qz2u+FClnsVIRTJP/vUBfEexYS
 LZ/Tgok9b/1R+e7znguzNF2c1f1IXoUWJD3s5tyzvBUmwcIDfuaICPSGsmm/mkiN32U35+mpunI
 4v7VsBkk4l96WmQmm9d96T9w6d7EBFchLGdCT0Srt6AxiLtqm13AJtQ==
X-Gm-Gg: AYBFou30ZW0N+S1nMT53Kow+fVtn/e+MczRSrOHWXmkG2UmkGx4oYwcyoTCUnpoWDoS
 XqnkZQQGFpNe65QIfgz3joFni4fFijlVJpS+WIQYJ+Z7v876bkZxjXrLM9OFDuLPZU/vrZnNaFG
 4EhS5bhxvvdcYkkTegWVXBVy2Gm/PWbBD/ulnvBAO+K5oYmXPsqnw+gLnuoV0s75WDzAMOILl0/
 H6lOQ1Yex+7hgMrH9obqa2uUjfVdMhFZGkzYWKKO/vNsE2/6cOecqLxkuPHBrKkxG5njfH9PTMg
 yFHmgf2c0igneYTpHE+NJ213GmOadLVKegv4xFux97mI/pozc8CrOlG4++jFMA4OonDIMeUp+UR
 BNrdgi5xpuUxJbMyDRN+nZVGIjWhKCW5WfVQ5+5t2IBX+DC3RxCcMQckzerPoRqeXmXWCpfdFbL
 f6vES9kwfBtm1D
X-Received: by 2002:a05:6102:32d2:b0:7cc:56a:58d3 with SMTP id
 ada2fe7eead31-7d64d8b0045mr3215359137.31.1794762744225; Sun, 15 Nov 2026
 09:12:24 -0800 (PST)
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 15 Nov 2026 09:12:23 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: George Kola <georgekola@google.com>
Date: Sun, 15 Nov 2026 09:12:23 -0800
X-Gm-Features: AclHuK9PX1tXz4CMbXNU29b6E7vqdpuG9gOYqkX7eABsSHTyD2fK-wCG_9B_ubE
Message-ID: <CAOTQ16+AbF9iURWBrU6_NOM14KCq5-s1YFbbP9ULe0Ch0hhAZQ@mail.gmail.com>
Subject: [PATCH] configs: netspace_mini_v2: disable default netconsole
To: u-boot@lists.u-boot-project.org
Cc: Simon Guinot <simon.guinot@sequanux.org>, Tom Rini <trini@konsulko.com>, 
 George Kola <georgekola@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sun, 15 Nov 2026 19:00:33 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

netspace_mini_v2_defconfig runs dhcp and activates netconsole in
CONFIG_BOOTCOMMAND without setting ncip, exposing an unauthenticated
UDP port 6666 console that accepts broadcast packets and drops to an
interactive U-Boot shell over the local network.

Remove dhcp and netconsole activation from CONFIG_BOOTCOMMAND and drop
CONFIG_NETCONSOLE=y so the board boots directly from local USB or SATA
storage by default.

Fixes: 970bf8603b87 ("Convert CONFIG_USE_BOOTCOMMAND et al to Kconfig")
Signed-off-by: George Kola <georgekola@google.com>
---
 configs/netspace_mini_v2_defconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/configs/netspace_mini_v2_defconfig
b/configs/netspace_mini_v2_defconfig
index 86aa836125..42db356523 100644
--- a/configs/netspace_mini_v2_defconfig
+++ b/configs/netspace_mini_v2_defconfig
@@ -20,7 +20,7 @@ CONFIG_BOOTDELAY=3
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200"
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="dhcp && run netconsole; if run usbload || run
diskload; then bootm; fi"
+CONFIG_BOOTCOMMAND="if run usbload || run diskload; then bootm; fi"
 CONFIG_USE_PREBOOT=y
 CONFIG_SYS_PBSIZE=1046
 CONFIG_CONSOLE_MUX=y
@@ -46,7 +46,6 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_MAX_HZ=20000000
-CONFIG_NETCONSOLE=y
 CONFIG_SATA=y
 CONFIG_SATA_MV=y
 CONFIG_SYS_SATA_MAX_DEVICE=1
-- 
2.56.0.611.g1030f0b940-goog
