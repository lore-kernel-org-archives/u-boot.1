Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D3FBCA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 05:36:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E845F60640;
	Mon, 12 Oct 2026 05:36:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7tufMOYGwRim; Mon, 12 Oct 2026 05:36:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3CCA06061D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791783418;
	b=YYY4DQ42yRjqFn3imiwOs8NP2hRKEa+ga6nR1dustTgz/UE4wJIXRnBXNPw2VMR6AOwP
	 9uYuFAGZi7xnZa9PETvrNubIo23SOdlDl8Sp+BSvTA/qynOae2nVlVNDlAgaCnqYC0NT5
	 UCi7aLRQma0F4EL9L9MimIT8oBV/UR6ZPh63PAlOR4Hm+VzHm9uUAIHzJw+CK00XsaAL/
	 aYkbassWz9c1uASK1yBmNa+QdoneFqF/TwBQTWra47tCq8pZiWUYI7t2NI01jDV8zzvDF
	 uHE1qlGTFAbySOnGUT7CU6ayHLqF5r48Qn0UPgl/A52YqHGY/fvho5pUulGlTFwq3FQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791783418;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7Lrwn5R0krGvnsgh8TS2EVcdIUUDxWntoEyK18FpdJo=;
	b=n1oWKY/4FWskUvRdRDqXiHuFCI/TXGmr0gP+IKoKpXTxIDh3ckOnNpNTJdgdUTH0YA92
	 iN5Nb6Xr8CE6pFuxpsh2Qt58eOSLxS+P4jXLZrI3iPUArQylbHl39cCWAq/2I8wQ7RyAS
	 QXkWv9savlH5XzqYo0iHgmFlQ2vRIi/Aht6NXlQzhZ3bbROJXa10iIJ0Y4T+RDLSji3Qw
	 1AopEMct6KfKXLdnSGpvDgPylKpRi26gmQhejQJ9vDZ+X7H/IHvFX9WYp2WPMYqqNwOzO
	 1/VSs2QgY3u5g7HzNCO2SHL8j9xZq2BSZorkmnGqpAmiLUKTA5PtoXgrSSlEYZLn3/A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bOYbbDRm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791783418;
	bh=7Lrwn5R0krGvnsgh8TS2EVcdIUUDxWntoEyK18FpdJo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qMy3Nz1ppSJMc71ebVlcAM1BbRmiKGPjYedRHWWz4/sMdH1gib4rUaC1XrHNWhp/p
	 HRbCEewvlo5/Jr6sRbRUteAVLwZKgcwYAaJbtQqE9A7rRczZYLIPjDBcpJ+4sUr2If
	 /l7/wxwu8wMKoSNlaIfMsCstW8SvkA67YUlN8fw+7A5JSBDWd1m48G7kfkK3OURI4Z
	 WNnoMdoGAYh2ahGVK4yJBUMWqzb2gbzrOKdwM/agKrJyvylw1RYGwVZd6zq/6o8KFm
	 JMu9p2q1rxmzf5ZuCWiBjE98Y0bCNQBeXImUq0cjXMpsMzYZ4doSkn/jLbHu1zxlTi
	 A9or2F/1SL6pw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3CCA06061D;
	Mon, 12 Oct 2026 05:36:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BADF7194
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 01:57:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A0A94605E1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 01:57:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v8n00utIBj8P for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 01:57:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BFF2A600C4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a32"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791770241;
 b=sE8Zra/E2J0XniEWdUjuPdYp2gPHt805IyySuDV0SNbP1VOrhPHFbthM5nAm3/sc5K+3
 s97QIKFBRqJIEjxmV57NkhhhECTALoYy4OzNIYxLiGx3u0bm/vSi731oRW1cZrF8bmgYg
 EE8AhJt7HKAUdBGX8YodnhlYYFQqrlciKfAwVGWhgNPGl6MI1fsFT9tJiiLpP23zW+WRQ
 XjlrJ0M0Qu79fWjeFmDlX17U/mnszh+zclk5MRoe8VnNtVyHlMXCY68mtWJPTW3ANZH4o
 jCc6+0iFYBoPYl42DZMrFIvahKpSr+YL9vFXUdbyqhITHmcSB6TVsXYvBOvsF3eYkcA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791770241;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=7Lrwn5R0krGvnsgh8TS2EVcdIUUDxWntoEyK18FpdJo=;
 b=fm/HKzcBWSzrIgJPNKLR04pR187jssLlliVyIOf7x6A44vmfZrCQIUMNd7suBWmAzzGn
 KVFEz/S8uVo7keVOGyzILgdY3RYuHdpYaXBeQd1oVoBemiHJq/nPOJB+MGwo5SkGwlAG+
 jYIxG+rcK9FoRoY0S4r2W0thYRxTq1SUEG+L1Depjd9ySaC9HsQb6xpryXapWucyz9hnV
 wt5e+IBYB/XoEQnqIgNO6wteORV7rd5G8uuwt+3IL3UaF1b11zlTxs0/7K8f5FaX3NPt+
 He897zemw6xmK7blRti1aNz4WzQk8AaQTxupx1nzU2LIYJzxwl2BEDb5BaMtuTZ+rjA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=bOYbbDRm; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a32"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a32; helo=mail-vk1-xa32.google.com;
 envelope-from=sebasjosue84@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=bOYbbDRm
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com
 [IPv6:2607:f8b0:4864:20::a32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BFF2A600C4
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 01:57:20 +0000 (UTC)
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-5e94120191cso800453e0c.0
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 18:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791770239; x=1792375039;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7Lrwn5R0krGvnsgh8TS2EVcdIUUDxWntoEyK18FpdJo=;
 b=bOYbbDRmXfQKyHzSW483W16Eg0hDtJWNcHIHa07lv9jB+9VcZ9bXUNJ7so48rTBD+V
 jbCu1PRZ2xE/4t6b26YUPwu+E+qrwA8J31xgu3hyw4z8LruWPEBEHvDT0gYOqDNQdKCB
 3GcsVVc5OaImCMd1IN0DwGQBlr/ywqbL/+OUZcxuDHx2VEd2rHDxo+u8cuZBhThBJFjl
 TypiwBrV3P9dxhKBRpselAJKI8WboAAMFeZQBRihEqlLLCNnUKdpQ2vWuuFJCBlWdr9A
 sdWLyiATXKI+luYK5x2+fzib1MozcY/xebxdmk/OGspdQ9OLp1CHpjYZPkFGm+ufvyUM
 Hd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791770239; x=1792375039;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7Lrwn5R0krGvnsgh8TS2EVcdIUUDxWntoEyK18FpdJo=;
 b=qaxCr6pbMYn21hZFvnzzVI6QTWqZF+1EIvR115IDbNbhVNof8Khyht6ybHZ77iJC8J
 2cqo03WfRTep3c+5fiCAbsvncnIAA+k8UoeKiYPTR0HCpXSHMJQKMWjqOdPBgehmGmoS
 jxqms6Zdy8tkgSRhojIMiAUBmJuUttPSb+tG9N5kr7ki05sW04HLFgK0KMgIsBQQazrd
 Wo9SbdO2i2o4n63V0E5HYzR3hcq/4IXv6YZ2otTpglquJPyWi7GdlILUie5glCV4eP95
 7Db+KORK2ux4OB3QliBeNiD65YFRjD1FNvAJaq8rDuMcpJ/KKlkF6xD3Fckwg/RmZl1o
 MljA==
X-Gm-Message-State: AFq9FYK9uq1HxUx0iapPpfkYV61nS/gazwIp59eCGiV87/fTgd3Al1ZE
 rSU0W7R+67jxplQ414Pye3DNVxVLFi0CkYkm5cZT3wGmeX6bhxggVWeBzEX0N7vMEuxPqA==
X-Gm-Gg: AYBFou0TzFmMbTsweWZJtRY1bE2CWBbxGZxWcIoL0qH9xGmN5+9SsLTFAyMGhFtzk7v
 DK6mwUkGtfX9XIx5Wo1gaEyY2kO7YR5XIS5YnKPKiXBQJ00RYOkHvCcLEWHTwNAjPCKMfpY2cY+
 dwAgX8X/DBCoPGaVJgzL086qnzxo7fk4VYNTst+Ka7mbhGZiT4A1wKFA726LXoUbjUx80DJMyHz
 a6MlzLijstzXYTDuPTJio+Kg2ZBhUIDet5DsNfA3N0BuFNCOUEiQRPeWDse+KMTDKkGfmBQGksB
 1sVodxMuNHSackUw5809Pg9OgQlfiIqAKXbbKvfLDTxeUAYH40FLo7/amklcEAh5JiYaUB/l0tD
 0TJ4D7uzjhr74KGreZQFkabTOdyZgNUhhgdCtiaMeL/qSilYJm9qtUxUTT5KLDw4YFd0o7wxcdu
 ZMPxStRHdy6DpgUb7yu21Ja4/tzAbGByTwuvCocLnJl7iMWKJlfU2COO1ub8Y63uL1Kml9VJfTi
 RNsNkmOZ64tQeBStcTOfUbXUvc6xLsaWVNM0iT6t/SInTJGCznbKz9W1a0SsVY=
X-Received: by 2002:a05:6122:134e:b0:5d9:82c1:b360 with SMTP id
 71dfb90a1353d-5e91f240beemr2732398e0c.2.1791770239127; 
 Sun, 11 Oct 2026 18:57:19 -0700 (PDT)
Received: from localhost.localdomain ([186.151.100.62])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5e93683455csm3457882e0c.13.2026.10.11.18.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 18:57:17 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, michal.simek@amd.com,
 Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH 0/2] spl: Check the return of the /fit-images entry/load lookup
Date: Sun, 11 Oct 2026 19:55:40 -0600
Message-ID: <20261012015542.1156811-1-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 12 Oct 2026 05:36:56 +0000
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

Both the ATF and the OpenSBI hand-off paths look up the next stage's entry
point in a /fit-images node, trying fit_image_get_entry() and falling back
to fit_image_get_load(). Neither site tests the result of the fallback.

fit_image_get_address() returns -1 before it reaches the assignment to
*load in two cases: the property is absent, and the value does not fit in
a target ulong. The caller's ulong is left untouched in both, so a node
with neither property leaves the entry point uninitialised. It reaches
bl31_entry() as the BL33 entry point on ARM, and opensbi_info.next_addr,
the S-mode entry point, on RISC-V.

Both sites came from the same conversion in commit caa7fc2c5775 ("spl: Use
standard FIT entries"). fdt_getprop_u32() returned the value and yielded
FDT_ERROR on failure, so the variable was always assigned; the
fit_image_get_*() accessors moved the failure signal into a return value
that was then ignored.

Build-tested with no new warnings:
  sifive_unmatched_defconfig   (riscv64, spl/u-boot-spl)
  cm3588-nas-rk3588_defconfig  (aarch64, spl/u-boot-spl, covers spl_atf.c)

Sebastian Alba Vives (2):
  spl: atf: Check the return of the entry/load lookup
  spl: opensbi: Check the return of the entry/load lookup

 common/spl/spl_atf.c     | 20 ++++++++++++--------
 common/spl/spl_opensbi.c |  5 +++++
 2 files changed, 17 insertions(+), 8 deletions(-)

-- 
2.43.0
