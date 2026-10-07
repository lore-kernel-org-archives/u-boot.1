Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64AA2CA6002
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 16:07:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 29AC540383;
	Wed,  7 Oct 2026 16:07:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6-gqYuQX_bLs; Wed,  7 Oct 2026 16:07:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6A072401F1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791389241;
	b=iamlHIYDrNtK6nnSfbXm1+GhZywiGB0Id++i96jgcXdLY90tIWTNouDuJAEJjHcR7WyH
	 aRl+1iV5bpQ/NGj0W5OibbF9GuEiHdSZhylF9YvCMGmkw6N8RkX6JBGkSiTAvPmtF0MPb
	 XqpVwn5S44LmpOuxOiqEJuN+wyAaC+vS7VxWgOmFZjGn7wGwN8Vs2ZXcXbXHUa6RE87g3
	 hd0y8wMrBDW9S9igEXm1+/+zEma62ItjCDTPuRmB4d4ibuDBfJE2XJv3nNMDcStVH6D2x
	 Vuexgm15MmPEu0v2HNwLcXSRRtjFiQ/RHp0qJ1TpASvu8OhzBKr3bujFAhFBoQvXwnA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791389241;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HNtN00SMoQ7aI4PxullC/dGL6VndlW4ZJK0xLnIG/b8=;
	b=qMDSQvQMVB4KUYRNYWKnO+hVOC7QwhccQV2qjNi1kof5cOBwoIcaeJKMhPaX2PgsFK/e
	 p8SsJhCA+rYhVpP9TFENYyY/a7/zgSklzgOilLZ6jSAB98XH74YvVmx4fX6h+UO86X4oX
	 Vvkm68zwDSvgJJZ09KkaapZJitlNQISxw8FTQWBigUu0guWlhoRvmzOYshlbz04i5R3Bu
	 qAKUSRXkOH4QE1A4Ox8ySgz0x3zojTskgRWkHpZpX5u5BWVYXYJQbdf5/1pv8oFJMqONF
	 XkPt+YyZ2rdoR3LiHL83FLnKF2G+mjK8qz+EtfRFF1rhfU3hCaOItQ/nnP5a3HhDxpg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791389241;
	bh=HNtN00SMoQ7aI4PxullC/dGL6VndlW4ZJK0xLnIG/b8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fn397jWdcR1+w3HJbXNaZlcfnKAnydF2EdUzVku0Q/1fKNyqSL1Y8nk+MkNFXBT+n
	 yG1aqp8edZyPG8V8PM4P8R+ZokDMIavXOYoVgsL4nqlj9bIWBhGY8fwBStlrOw/ahr
	 ZEtSP9NFPh+f8veaLhKxM40SezHS7q4lQAEi0uq3L9PsuWPkYLmedHgbF/hDm7Y4Bv
	 6p+Ol55WOJN58MV7blglgaPAfEOXNHzHalTPY72N/U9Nnuye3eBFrsPsxI/ByEBrHK
	 4q3AYtHyAyBj8EqvbThE6fmBVbmcwVyIhtgiYGL8aXvNrc/ubWksRm1INAgshyUWXY
	 vusISNvOBTeHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6A072401F1;
	Wed,  7 Oct 2026 16:07:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EEBD132F
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 14:45:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D54FB4031A
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 14:45:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sv9LZdspm6QY for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 14:45:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E682E400B8
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791384354;
 b=pXku6jbWAujEG7an1qZ6c6rzK4tgxwA490YEwm2RewwMbR3W2xepGVNmwp+WWJuUYGHi
 4cdji5eof37Pr/EGYaH99IkC6flYNxeI8cwjFr8sj/oc8jBu2CT86v4eqCmRfaPPyTHUe
 oA23P6GY7K+nkXrwglPSjA2Qd1qPwdD5Rj3k8vI9D1rmx0L9ONQtOegrZ8XCGekJwnRTI
 WWMM8uy9ogKp+RP38UNpS2qAJrgwYnABcSjOzP9ue2AN6l+ctXjuCFcL3mLlhhIR0J+sj
 KNk+y6qXqgI0p5m+mEQggaiYiXyLteGgVizs5d08FTLBZrk31dg9y5LbA2+TNplK4pw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791384354;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=HNtN00SMoQ7aI4PxullC/dGL6VndlW4ZJK0xLnIG/b8=;
 b=VPeH09Qcg8P/e7n7ON/a8VRlmRZR1A7v6gQsGKopOEtW0YJnOVzRFUQ4ou3Oirc1FqIm
 NqhKyBYZDbazOu61y525pCFJfzoQyCqteauN1Taz2NkI2BqEP3BftaKq1879in7hlXkq+
 C9qJWRtSkxcdaNWUqLTxywyY7LNDlGnElVVNqZqnJBn6zT8P5W2c+rW18YhQgzCObzPVI
 7w3qfhxbC/Bj7iim1ZP6lLTVPPU5bIkJuvTp9gmcPWupEbfrc+cqk3PMPV4oVM9DrTEhW
 RySLuJfNAwf+imCrBLuG/Ndgo4ZSz3mcCrv0ffnfzSxQHlEnzc0f4LqW9ma8FGSSgHA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=i1G5rGjb; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=i1G5rGjb
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E682E400B8
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 14:45:53 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a16aaf2067so47775225e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 07:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791384351; x=1791989151;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HNtN00SMoQ7aI4PxullC/dGL6VndlW4ZJK0xLnIG/b8=;
 b=i1G5rGjbEga1xX+8feqUaHPJaIIuLaqrUICRWkL0RLGSUmqYHXmTV4kol0dPsuLkwS
 1CwnQKXiqcfkS6a4Dh0+71da/EEgWnE44YOcEIWCdf/xYZgeE4IJl6MKcqMJtovVHn4+
 yzuTuwhq8YViKlIvRspL+bOJmUTBXgjW8in5rca9Pbx0Q22G9zhl+ok0rRAobuefxknY
 VIlMWf1wNRjcPQ0ua0TxfXxwReM+dr4tWRbeQAU6E2h8xXCxSsi4czH3sj7jlByLtrnh
 Es3RJFfbs0A1dz4E+lGSA7AgOJ3JpovDggLZ1AJYHFGg9KHQVL508h0LKngKIUitpPXz
 B0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791384351; x=1791989151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HNtN00SMoQ7aI4PxullC/dGL6VndlW4ZJK0xLnIG/b8=;
 b=pf54ttez91FPWp3Y5qWQjX0q2W2Cr5rAXpqJJH2kCgEoqvCSHATzygaU08nkj1O4K2
 r39YpRdPS2NA5pOIvJpS4dKt0BpaERmrSDWXJDRvNmHYtRY2MSkF4dLF9TyrtYq24nzu
 5B5d5l507qw3Vj4DeCpkn/Rze7knpmMh9WO2v44EGmflMTyHr/ICkU7C42IwO40T36zY
 9hdhhEeYSCScd0urXdKQ8GAqxIl09hB2PTYFwF4WjutoG8HlgGlg4P4H/ak9XNI/TwMF
 3jFfFa3wOeXfvNySHjLyFj1SiV2In/PRI9GFdI0sMyVWEmXK+19V0TQfZXSyH2ZXIsyT
 p1zQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzqhhoskxbbQohdTwJsOEnvk5YkeabKEYlKEl4GZjroe64z5AymaI6O8kRzC+tM6Zqzs7b4euA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++m6P/zXW6MCsL0ZydbNUko2GLjWoL33zHGGEPnAa/N2yzBBC93p
 5renaqa6riZitVT/wGcG0ua+zB35DkvlXZS6rTTDuH43dppOPkhtzTiU8nZQdLbQ380=
X-Gm-Gg: AYBFou0xHAYWm3cFUnOYyrbfLUjPQ/bCOyq5Sh5LVidsQz2HaFiOXuADtF/CkblaCt7
 vewbXGxPnZuESbVgTvv41g+0EEcKcEgbtB/lu/+JqPAo7tWVZ560xElutyPgMSqiaXDNpqTR1WT
 Q+xTqvxJg669ja4r1TJKGA0rWm6WAh/cy/SRIhdACX3/HkylRsh9hjVhi1TYBlzk+Ifcrfa5pgp
 bzHVntbQUITjyBHo8ypeD0k3p2QFk6LX5roeAHOvImlRsHr9LULuGmxY12VI/Bbf3iqgIRuw/wp
 UgrpxaaEV6I1h6EJzNAOU/BA9LW3oEWl0YZuyv62JwUaj4W1VmPQMdmePwVkNQkvoLuUoHe8FIE
 YOEsanJCPkpnR79mQ8HqyvAF3zhu5g8Le+JWpylCyU1lDWnd8enbeyrEdB3omFyjwh8Witja5Cf
 kpfqrgH3oyqoY5HRDQnGRh9vz1FyOnxYavVc1eM3ebIlGwEckckbjolG2UZEdrGXDzCdj7esJ0f
 19Q
X-Received: by 2002:a05:600c:810a:b0:4a1:6f41:9102 with SMTP id
 5b1f17b1804b1-4a1802eb276mr43332505e9.9.1791384351069; 
 Wed, 07 Oct 2026 07:45:51 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f557bcbsm111620105e9.9.2026.10.07.07.45.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 07:45:50 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 Stefan Agner <stefan@agner.ch>, Francesco Dolcini <francesco@dolcini.it>,
 u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH v4 3/6] usb: ehci-vf: drop the empty bind hook
Date: Wed,  7 Oct 2026 16:45:41 +0200
Message-ID: <aa075df3fb1c0e510818aeb41b0ff68dabc398c9.1791381507.git.mehmet.fide@screeningeagle.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791381507.git.mehmet.fide@screeningeagle.com>
References: <cover.1791381507.git.mehmet.fide@screeningeagle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

vf_usb_bind() only returns 0. Its comment describes a hack that keeps
the second controller from taking sequence number 0, but no such code
is there, and an empty .bind cannot influence the numbering the uclass
does. Remove it.

Fixes: 0885cdb9d154 ("usb: host: ehci-vf: Migrate Vybrid USB to driver model")
Fixes: b27347f425f7 ("usb: Update for new sequence numbers")
Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
Changes in v4:
- none, rebased on next

 drivers/usb/host/ehci-vf.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/usb/host/ehci-vf.c b/drivers/usb/host/ehci-vf.c
index 5d27318de62..e5f9ec0fdbb 100644
--- a/drivers/usb/host/ehci-vf.c
+++ b/drivers/usb/host/ehci-vf.c
@@ -261,20 +261,6 @@ static const struct ehci_ops vf_ehci_ops = {
 	.init_after_reset = vf_init_after_reset
 };
 
-static int vf_usb_bind(struct udevice *dev)
-{
-	/*
-	 * Without this hack, if we return ENODEV for USB Controller 0, on
-	 * probe for the next controller, USB Controller 1 will be given a
-	 * sequence number of 0. This conflicts with our requirement of
-	 * sequence numbers while initialising the peripherals.
-	 *
-	 * FIXME: Check that this still works OK with the new sequence numbers
-	 */
-
-	return 0;
-}
-
 static int ehci_usb_probe(struct udevice *dev)
 {
 	struct usb_plat *plat = dev_get_plat(dev);
@@ -315,7 +301,6 @@ U_BOOT_DRIVER(ehci_vf) = {
 	.name = "ehci_vf",
 	.id = UCLASS_USB,
 	.of_match = vf_usb_ids,
-	.bind = vf_usb_bind,
 	.probe = ehci_usb_probe,
 	.remove = ehci_deregister,
 	.ops = &ehci_usb_ops,
-- 
2.55.0

