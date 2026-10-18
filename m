Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2803ECCF2C9
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 08:35:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F21D860739;
	Sun, 18 Oct 2026 08:35:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZGvU1MHPzQSG; Sun, 18 Oct 2026 08:35:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3F0F36070A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792312550;
	b=bKm6UjT2+Ucy1NR+mtyeLUwSU/JRkpKLwOttpq4TneanRpC1pPX0OKOKAGsdwoBQfSpo
	 v3sqhmNwJOw7UFKI/M2kDGhkyccDeJlX/KLCfHqEpqkG8R26Lh5QAOUMWdCbVtQtgClGR
	 TvQ7U63H1w28zt7FEM7JwkL8rEkpl4UCKY5dB2FafomyukwY3q25Smd2i3LpSbP/7pSZZ
	 y6EllhKRoa5CFmSbQUWpwC6hdsNez8IbzftSEtFZlgmWmvye8rEMZqGSAEJxf+aoNSaDq
	 el/UgMth4PXEUHRpdaqTcWERxIgubmyBMADTh2WBwtlZv/Dp9GEx7jADn2BYQnrP2RA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792312550;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=iU8ntdiVoDP6n6G0tTuxPrLcvwtTqvKlGpcZvIvu8DU=;
	b=hq3A1WN4caYS3rfUJpfNw8c44Nh0EblU7MxcsXI4wVQK3yfg9WUtibbAEzze3r50Musy
	 wtkA0++RCLGk3w3XfQZtGe3MKBuDpKTjPXV0nUlAmZ4vGUY9wvJ4NSrtUD1jmFzS4iKw5
	 qrhHTQSKNfGmr+W98rZG8j4y9zck0VgxmZ1COjcTdfvLadlcUl87i/rLg+jNkV6sMf74T
	 I8l7ja7A0SV3aUKxbQTIhNCiUXK3SdJkoXK1688tFpYwUk7TCWCoob8GzTlUiA/FVFSMw
	 AqtT064x+P13UQz3b45Mb5xB/zmBcrPRkZWLWrG8hvaLWqKQWpfT7MkmTosoWI7i3iA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792312550;
	bh=iU8ntdiVoDP6n6G0tTuxPrLcvwtTqvKlGpcZvIvu8DU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=peftfcsqjs7ZIT5aYXIrdhDDgLi6VoMGzXKmDxKGHWTYk9bbl+dE8ca83UUeQ8MI0
	 RyIt9XajVlAhJ1wJ1mZ9Ja1yedBbpaS2/dLEJfId1M+fpt0XoZN6VzEDGS63XjhxZs
	 1dxy9TzKMiHk0hhA3lDLT6Ugg4lgvs936ZwyObqiewzh5qqnVB/2mPZRHOl/SmSuTj
	 6TLXuMj9c3UzgDs8fF7NQGFb2ATRsn5bvZTZ65oEk3pgYJ9oRcmN7ltOKsU/69NH+J
	 50y7oLRZSuvXEJmydPlYRzySIXVz+c3UhHfasSX/fG88c2aMuW1mQxcr9ngz3XurJQ
	 2u3AbByZYcnsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F0F36070A;
	Sun, 18 Oct 2026 08:35:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D0A0422B
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BEC4340996
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0DhNiTWAAIkh for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 08:35:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9C4E3409BA
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792312536;
 b=YxhiiIie43eRRBu/Cqtb/1rqjX0cxOdAO99o8hmpP6iGxWSwdophJfxj53WiKXS1jC2w
 +SXSfFOPnl/UVPnl0cBFwFZbrl286wItnaZUeb0obPcSEPLAqXuq1a9y8rI3a0pCRaA0v
 QcCf8DdF0gsksem8AvpTFjwh4bfuFQB9sdqNewbjhmT83Rqg1NpiiI7umt18FYD/5OcKC
 YTCKnbnXRCBrFsLf8QUn80dTquw52LMOkb9oBx1dImRRKg+Ojrq4npSDCwUMZOdpEBM6n
 BCVe9IymC0gSnxUfCj7cQtzfqcZRaDv9LHN+b53UfjfOeSvAPtk9RQr/EWOUnVaFQaA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792312536;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=iU8ntdiVoDP6n6G0tTuxPrLcvwtTqvKlGpcZvIvu8DU=;
 b=EKyJax33vmjuX4OyNHRK5VK3LBsrR7ZxGIyO0jGPjIMK1uXl7bq5kXHbBh6H/DRbTtd1
 SnYO9fzaKuFnYL7L9BLooqWKltRbuWv7P39ueu4MPxEjs/6YhKlQmWPNhgHhstjO+G0sA
 k2oHz6qh0lmDMpMXVKBF23QRyGGaBVu6K7y4AAhrbmb9MMWG7FA22ga9i9hT3wAQxAXu6
 mBGvYfudz+SHhTNpdB+VI7BUG7Gl2WZ+QtUrAIO5CtQVIb0WhJiPodTxWqFja8s9Ws2jF
 AoRHfBek2nE3h3iZNTY+M0kT6/g/e0qpOmmj4p0vPS9iyXWKDi7Wxb5sHJaJcf5S3vw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=crA2JJME; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=crA2JJME
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9C4E3409BA
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:35 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48df4e9d2d4so607594f8f.3
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 01:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792312533; x=1792917333;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iU8ntdiVoDP6n6G0tTuxPrLcvwtTqvKlGpcZvIvu8DU=;
 b=crA2JJME+qSZ2wP7vyvwBk6Y0sA3PnILZGE5Ebtz0WcEB/TGo6LR6K+P8Kg7Rl/OL4
 ha5eJUcqN7v5rm19De4vpWmZMdwtTfoXm3h+70OCfweERa03ViTl+B3HdXmssxl69zlL
 r2z9GAQf5wAgE2M5Y19jr2V1YvSELXwRu1ynem4rmVorNk1E3IxPbQp043vU7i44x49S
 wOFJRkXeEAyf3rPaXe5ER6ljItlTGyfQMWABPbeTi/f90CKWblYwgiR6tZ5NSo3ELL16
 lHrcWLGXDMkLQ5P0AkzUCNONxXt0zHWhg6eVUDpmpCaXJZZuxbRIV0k2wQBfqcPVcn3B
 trLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792312533; x=1792917333;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iU8ntdiVoDP6n6G0tTuxPrLcvwtTqvKlGpcZvIvu8DU=;
 b=j3Y8Wy88DHm3n4Fer/d+P05KuZhvk4EZcLmHbKtQM7mWcAeHcxD+u1MdVbXEajR9Rv
 RmLp9CC28WLEzn94PBHolmf9UKi3yxVb33bJAMPuQLrnXzHdPp0gsclpWFDGNn4Qci/0
 m7T29KnOR8p1ZyTQGcDEYqHMh347j/2PzojfBsCpkuuGot1oHV/iijIpPEZdlw438O4t
 kd77mkO7R76uCMkRTtndJbPf5wF5aWDnr4IO47+uM2S8Y55vEyW1XRczunfMzAP0oHVc
 eBTy/7WdEGcKt+f7PGTh0KJG4MNpdFB0sQS5NOPUows+gUPKcFVvHYPSAjLQayf+C6WU
 G5sw==
X-Gm-Message-State: AFq9FYIj5HKheARWEqXgsFlOsqZR4wVnsWgZYWBGINe/g2VnKrb1rVjQ
 o513dcFKEjn3lbNvPVKcj29K7Bzx4PeJzcM9NJASaaaLuIeNnxcqOmlPZZvQVpqo
X-Gm-Gg: AYBFou1jEoxPtZlSJtKfqjS/tPofrmTh5IIRsT13d8rsMFZfECYynWJvfUeekXicTh/
 RugslSCxRWp+0qd1WlwdvYgD6PShFN96iu65g+FY54Jm9t17SCtVr+7VFl6kGj7qWAWcO3KUKti
 yg/pZQC3wM62VhWANeMrylQmCbplIW+ly8Zii+1suw/Dgb6K87Dr8xnanER5b252LXsV96XvZ5o
 FSbDYlUifG6P4AAtgmTIcISxQPab/A9Anf5itPgfP98BHIRfg6vMzFK5CF9467iujFoNa59OIH5
 86GDal3tqvVhDUwee+9Qs7P0EwtJEMnKWVmDqrn5ROA3/6RGvUWHPeg+4OQJbL5/A1CmAP6xtPH
 NbI7lyOweKsBPLauO3xIyoQa/92uxZRmvelMFSKKj9jB4U/9xiOvjBJvhSSWzzbu38wyzQG8GYL
 EQ/y1nSw3xly6LehHaN5vt9GgyTkF2kK85Li/t8hSd1IOgohFtNYu1X/TSg9wdolqOcDmkuuCDa
 ZO4sDe5QT+X/2T7eiRXs7nUuHrWO9ZgIVexAf9uMFUcreoD3bqRmcis2+gNs5Ss/JWEjaNvU4Kl
 mmO/DYXfmb9zmTcHgc96yKs2oMMhczY3cWjCFmKXnxeC7R8waEGjcmNAqpmsNCDfbH35YU/CMhW
 Mkqp4njKq+rgi1ZejF40piFm5
X-Received: by 2002:a05:600c:5492:b0:4a1:d992:9476 with SMTP id
 5b1f17b1804b1-4a1d992951cmr77233705e9.23.1792312533059; 
 Sun, 18 Oct 2026 01:35:33 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-318a-f58b-5e43-a2b9.ipv6.o2.cz.
 [2a00:1028:8388:a84e:318a:f58b:5e43:a2b9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1e3ebb3aasm43589595e9.0.2026.10.18.01.35.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Oct 2026 01:35:32 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Christophe Leroy <chleroy@kernel.org>, Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 09/14] xpl: Pass the make jobserver to the xPL link
Date: Sun, 18 Oct 2026 10:35:11 +0200
Message-ID: <20261018083516.49229-10-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261018083516.49229-1-pepe.schlehofer@gmail.com>
References: <20261018083516.49229-1-pepe.schlehofer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

With LTO, SPL, TPL and VPL are linked through the compiler driver, and
GCC's lto-wrapper runs code generation through make. The link recipe
is not marked recursive, so make does not pass its jobserver to that
command.

With Debian's GCC 12.2 and make 4.3, the SPL link of turris_1x_sdcard,
which the next patch switches to LTO, therefore fails at -j8:

  make[3]: *** write jobserver: Bad file descriptor.  Stop.
  lto-wrapper: fatal error: make returned 2 exit status

Prefix the recipe with '+', as the top-level U-Boot link rule does.

Tested with Debian's GCC 12.2, where the link now succeeds, and GCC
14.2, where '+' does not change the images of three mpc85xx LTO
builds.

Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Marek Behún <kabel@kernel.org>
---
Changes in v2:
- shorter commit message

With Debian's GCC 14.2.0-19, the link also succeeds without '+' at
-j8. The LTO images of turris_1x_sdcard, P2020RDB-PC_NAND and
T2080RDB_NAND are identical with and without it.
---
 scripts/Makefile.xpl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
index dfd76b51a61..926d762108f 100644
--- a/scripts/Makefile.xpl
+++ b/scripts/Makefile.xpl
@@ -544,7 +544,7 @@ endif
 $(obj)/$(SPL_BIN): $(u-boot-spl-platdata) $(u-boot-spl-init) \
 		$(u-boot-spl-main) $(u-boot-spl-keep-syms-lto) \
 		$(obj)/u-boot-spl.lds FORCE
-	$(call if_changed,u-boot-spl)
+	+$(call if_changed,u-boot-spl)
 
 $(sort $(u-boot-spl-init) $(u-boot-spl-main)): $(u-boot-spl-dirs) ;
 
-- 
2.54.0 (Apple Git-157)

