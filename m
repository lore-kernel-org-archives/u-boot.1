Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A817C88E41
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 22:08:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD51260BF1;
	Thu, 10 Sep 2026 22:08:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i45cwWmhRwDP; Thu, 10 Sep 2026 22:08:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E3D8060BED
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789078113;
	b=XcgEVf3w03ZA0zM6LHRkMTsiAYU4Dszr/5IsmYLRAp2gWk9+0zobALUiGM+hQw1zeVau
	 SURTL6iblnt6BRR48yQc5oG9QdaTZjNVyg+vehThlwKV2WLsBlxJKWVEnxMe1BvGilhkP
	 3+IzKhc4og5h8BqInV6R34q2qNx7whhMUf4Ns21M9GDR+wbuh8bHyzORixzd9RSbiHCCr
	 ZMnY6k+p8eTOSoiiJa8JBJdOtWapVA9ur8J1pE89VfTOJIAZwNZEZyJYgi65j985WbezZ
	 f0WqR2qKihMYhcLv/BT1Xrud4n0Ibubtzjknw01F0IgoZMojnyw2oEXrvfScQ/7jPMQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789078113;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=y3tyXAaVQlHvJl1VdxCRPwWUuFNecZU8JYfJ89Yr8kY=;
	b=HohwxtjZ1WHmhhNxUTY9THe+xwvJbSqVnX9NUg2O2tIEmsF47q10ekS9qiv/vomuaZJ1
	 2GFMJQLy9MJVHkCWZYk4/U4pVQoWKsbX5UrwNKlTvKGMhtDiYcupuiahJzuGNJ63LYhB1
	 kLMS4fL4ypDaFaRK+mqQbSE4OYu3xoCdr+O941N4NRodwze3qbYtEMZJRBiPzdNPqTUVN
	 l5nqVQXybPXV7yvH2GtZxwzHjxBo1ObZTLPXFda9BX5l0aAjeHUyTnvx7jKCCqK/fKyek
	 fi+CA9L2sRDrTq+bqN0MLgUmAC11iqsnm+EapNr8xL4u93XX3vloGckVMHlKOOttG/A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hWLQSYIg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789078113;
	bh=y3tyXAaVQlHvJl1VdxCRPwWUuFNecZU8JYfJ89Yr8kY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tsLwrDfkqgpHEj9FLooBL1RF7ojDDdH3UiF92aAS4vb2vu5KLXG5jjwTaBrWfRliL
	 ZAdZgUxX85O4fGE+S7LzZhGSVnjRYUligvf6J93rdSLBtbZ670IRWuYaM8D295EMyh
	 pGdqZPdyu1Tt+/HwiYQXY/RZ8J6EEFtUhbIQbjF6huvKJPhheCTB7SUi4b3AJlb58X
	 H7Vg0F86B/mHim6RgxRuLzZXSxnz/UEgjKQZNCi43CVt5E+ZaxWv104g2kGKL5zaPK
	 YR2eSDIlMZQCL3DL0bEHOGWyRV3SgJ1IB2wCP0mhzi+XUDlxToGDe/9sXssNYKS3LR
	 RFUx7/yRHLJ9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E3D8060BED;
	Thu, 10 Sep 2026 22:08:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4357429B
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 22:08:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 254A960B83
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 22:08:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bB7NJ653kAyl for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 22:08:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 22B7360BBB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789078107;
 b=BNNKEtFWSq1r/fjRdS+sSb0pog0wy2FulFp6ca9Bpv8qX320/4OVcy8EkLcms9uznplF
 4U+ZitYvfL+EwW/QeJsUp8P4mnH14Pft60ZfucHbcQja/dkzAvXtf72w83gk0Nc+aBfFZ
 zok8GXTQVRWsgAed2QEzD9JaDrVD1mCMyZilSGzuo94BT/hK1dBrGUylVBODwGF9pjbVx
 5AfLmzyA5MfTY/nmlkwsSUuN2ST8S/Y5dIqzmCmbU5OkxoGNtLn5bkxX4pk2XqonX6kUd
 ci3Ui3ovmzwhzoPQBDgouXGUqAALvp6peb+IcPyucY28l6TQcC5BDMogxu2JFgAxzTQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789078107;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=y3tyXAaVQlHvJl1VdxCRPwWUuFNecZU8JYfJ89Yr8kY=;
 b=lHqBQWphYKqn8KAkFcJroyr0uJAdpJBsQFX1jnAlJQtK/yERc1QZ8CJ/2F2Ie+8+Tn+S
 p90DaMcOZVm5nuyjAQOMz9SNKECRbYdHvADVgdzcJRmXlQFjFNBbxNGC/6cWVQLiVunIC
 qsyF1/ixLk4ZB8OEqom5IkgP6GNwLKjkPpqemf5bsTOexgmul1Wr5gVf+0gg4elkmYS/D
 Bsd7ZjewLaHqDlGQJEIPY9mBw1biYtQhu1CmUN1WhRk79YsHWf2G2YHeR0AL44Stf2tI+
 BvghjTgUKgAuSnOc1QMf+9Js3GL7sEBlT90GQ+fJtoA4wHdmdVNfrFw9SfJl8I+hzDA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=hWLQSYIg; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=hWLQSYIg
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 22B7360BBB
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 22:08:26 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4957eefd361so2231615e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 15:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789078104; x=1789682904;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y3tyXAaVQlHvJl1VdxCRPwWUuFNecZU8JYfJ89Yr8kY=;
 b=hWLQSYIg9RH1eBc3vIbsYRBBbW0emY/uNUkH6N6ioUXdvI7pP7N1n8n/e+6ZHsGv8a
 VjhXm51w86z/XhhnTMKU+WMKm7oSFM5jUolmRcPKoi4d9V63VpwYHC+UxGTjdD4PA2pg
 wYc5M0oZ2RJBFoGuA32QpynGMNDA0ehg4+SL8xxaNCnofoVsytuoRbu1gO27GtnpEsRk
 sycuSFtgsG+7FzoE1YdtMBRuho4kcjkkZ+3Qta47QiPT7sONRz74Ar7erG8eD+PAdtPP
 U2iT8Q+Xsf7u0DiDdRiSzgPLjdLQVwwWjdNWNAEfqICNdcTa8jVP/lvYP5NdJ389Kp2A
 h1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789078104; x=1789682904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=y3tyXAaVQlHvJl1VdxCRPwWUuFNecZU8JYfJ89Yr8kY=;
 b=Etn8SIb0KzGb7iqbvXcg1ACNTctmFHJCH7gwcS6m+6IdBIG5ftChT9rFgx5KONRZhs
 A34ineQuWE4fpJfZ448tpTlD+FGvgx2yQJYmLZKd6Nrcj7SZWIRj2Esdsj5Rw/U6YOOy
 44sbkMBtB0DRVA8DIPPB5GncfY7dIWRyHUbiCshADxQrKY51eBWyCVasgtdlqHz4yp5N
 eM+KBSKinKcoup8LxpMcunkhisFbgzTnnBS6ZgqdOnxEK2mA8mldJU9plSqnKsJSQLxr
 xIwqEiEP8jwL1C8KH3sSMSzfaxd0koF2db9ZmA8yBxV9rqVUAEq8JH+VPYE1OP407KwO
 FuZQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzi+X4rwhmqN9n8ymM1nnZIa4P2+HtioFvmkdwpCpb1B8++xCYmizV8VKotuZpJqy7yKEN+4Fs=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mw830PDpL7E/B9WZMWo8Sl+GnTXUQoTyUN7U2OiUsDIDT3cLn4
 scnqxQr3ZeTQfUjaFN4HTb6Sqehp+cbHPNNpArXPx/gshHx30km9LVtf
X-Gm-Gg: AYBFou1r5MLsGsMdjwhIY7qN7+eX5GRHjGp6xAZPkK5BjGzQj8iUFZJVNs4DvO1Ou2d
 UMX+CqGzF7bDFeCo3gaQ6YlkzUnwhuRichBi8WFewIiqtrAPRK4IBGJZk+5vG3NfMRw9q7Dy1Dw
 BpBGoaD+NvGrK3KbDWn9pYBJWK49JfOsQR4QvTzh2dIVy7uics3FWZKmi5TVVCLy1NR7n0XpB1P
 ZmIgjlK1rjp4rNDgtT/11mDbFb1OrOfB+U6v8WkjwTqXH8Wzxcgzb+JA2w34H7C66DQR9Z5ZcMY
 H/c8gFUayiFVVcWibiw0VfTwupcP2+30lDrQVPKyu09vuTskwzsWArOZerq7Qo113z4yzz//o3x
 pUuYHdkcHhZZudTTs00d+t5z0dCukDc5oIcvi/pqP59amBln0+vya9vQ9qULiaaqp0kUiNespwZ
 qOLecFJ8QyhlzF9lGq/Y+v4Quu8b1P98tvqFi7k+pe3pTZWBDSma4aE43rSaq/9ScC7AWZmxQpy
 siTZT6GMCInhI0=
X-Received: by 2002:a05:600c:6296:b0:49d:191b:88be with SMTP id
 5b1f17b1804b1-49e6164a26dmr11682925e9.0.1789078104216; 
 Thu, 10 Sep 2026 15:08:24 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62231360sm4795595e9.4.2026.09.10.15.08.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 15:08:23 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>,
 Ye Li <ye.li@nxp.com>, Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH v2 3/4] doc: driver-model: state that of_to_plat() must not
 probe or claim
Date: Fri, 11 Sep 2026 00:08:17 +0200
Message-ID: <20260910220818.3093364-4-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910220818.3093364-1-mehmet.fide@gmail.com>
References: <20260910220818.3093364-1-mehmet.fide@gmail.com>
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

The design document says decoding the devicetree belongs in
of_to_plat(), but not what the method must not do. Spell out the rule
that has always been implied by the phase separation: no probing of
other devices and no claiming of resources, and point at the
parse-now-request-later GPIO helpers as the pattern to follow, the
same shape clocks, resets and phys will want.

The paragraph a few lines further down allowed exactly the opposite,
probing GPIO, clock and reset providers from of_to_plat() to select a
resource. That is the pattern the helpers exist to remove, so drop it;
only its first sentence, that of_to_plat() must not probe the device
itself, is still true and stays.

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---

Notes:
    Changes in v2:
    - reword the sentence about the GPIO helpers, mention clocks, resets and
      phys (Simon Glass)
    - remove the paragraph that allowed probing providers from of_to_plat()
      (Simon Glass)

 doc/develop/driver-model/design.rst | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/doc/develop/driver-model/design.rst b/doc/develop/driver-model/design.rst
index 633545944d1..4b1fe0839a7 100644
--- a/doc/develop/driver-model/design.rst
+++ b/doc/develop/driver-model/design.rst
@@ -759,6 +759,16 @@ The steps are:
 
    6. The device is marked 'plat valid'.
 
+The of_to_plat() method must only read the devicetree. It must not probe
+other devices or claim resources such as GPIOs or clocks: ofdata is read
+before the device's pinctrl state is applied, so a pin claimed here can have
+its configuration undone a moment later, and probing another device from this
+method defeats the lazy-probing model. When a resource is named in the
+devicetree, read its description into the platform data here with
+gpio_parse_by_name() and claim it in probe() with gpio_request_parsed(). The
+same 'parse now, request later' shape applies to clocks, resets and phys,
+even though those helpers do not exist yet.
+
 Note that ofdata reading is always done (for a child and all its parents)
 before probing starts. Thus devices go through two distinct states when
 probing: reading platform data and actually touching the hardware to bring
@@ -778,11 +788,7 @@ present will cause an error on probe, yet we still must tell Linux about
 the SD card connector in case it is used while Linux is running.
 
 It is important that the of_to_plat() method does not actually probe
-the device itself. However there are cases where other devices must be probed
-in the of_to_plat() method. An example is where a device requires a
-GPIO for it to operate. To select a GPIO obviously requires that the GPIO
-device is probed. This is OK when used by common, core devices such as GPIO,
-clock, interrupts, reset and the like.
+the device itself.
 
 If your device relies on its parent setting up a suitable address space, so
 that dev_read_addr() works correctly, then make sure that the parent device
-- 
2.55.0

