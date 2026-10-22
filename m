Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9BA606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 07:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DADrhJ6p;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZkT72mUc
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9715F607F6;
	Thu, 22 Oct 2026 07:09:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WAAzxXKdMdAz; Thu, 22 Oct 2026 07:09:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D90B960846
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792652959;
	b=MwGFn2lhC3HAGz/gT0TLnfpJ8KFq/gyJcUIg4RPDHTM3Jyq4Z0zpU6FRS0zN1qLe1Y3K
	 toG2k/psFTVUt1FlegJ2X84UNwBq+5ax2u0sUiivaID4cQksV0pWBhp5XVi6DNGkF78/R
	 txNF7GOrvIZvHVxxf9XtmZVyopOT27HpVESjBvt9yMuD9HGb8vLzhHjksgKCTLpEZ8T+1
	 mbvX7qmKGqQhCrM6ODA27iKfygYD3F1nVHsjMnzfid/Xjt/yADvmoBsXckdeV5Znj9yfF
	 FFYeYCm6uu60S17a3AtgNRYwNsjLbFB+rKFud+8YdYnXWIGcXHKxOubiX6foq/j6Tuw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792652959;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Ei8jBrS8xzsa86/y1464G+9OMP1rVVKdnHD20kfaZWU=;
	b=POsSvjJe2jvJo6SPyoYOa1vemxjPlUeW/9SiS+q2psiLbfcV5GPD103NA+mRdvvUrisO
	 mI6jxtGf6iRq8ZQY5kENiBYQne4QVtDSGTUIbnSIZ/4qn0/Oy3smpKkpZq7KIVAYZiF6X
	 JXnOF1F774TZkZtcpn9k4utmz5HnjOR7gCcDFB7ty9Sa//bc8+exiENsrXOvEOJJqJl0Y
	 BA8FxY2C/MK8UTSfmNyasr4hXh2VGlbsGg+HHQx2q89zzg4wNpl2ZkRdu7xbhJMy8Y6lx
	 kpqrep1J/Tme9k6CMjiGz4/jzAbCNUqmMAwOaQWoPIp5lip/SBDxIv6wUhwTNWJ1NoQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZkT72mUc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792652959;
	bh=Ei8jBrS8xzsa86/y1464G+9OMP1rVVKdnHD20kfaZWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DADrhJ6ptHNzD0Z1Kqtm44qwjEPXGbt+z7HaFQFApzuGXdom8unJNWyMRzKn7FAjL
	 +RIY1uB5iZsNaYfGQaZ2cjCxCc1gBgDrzVjQb7jUYbUTTI9/DD3JX1BagoX6HMI3Ia
	 u+eIOHJkEYsaA9Dci5HOzDHEZ91DJCOIwqtYx81j9t9gapNzAKciEPax+z5LN+MSSM
	 w0IVzezCjs3/f7LRlHy3TJEc7PnnS2ZM+9ZUS77hhf0R3+S1Ev1+4mekzUYRw1qpzB
	 5q6399rgNErN4LzreQR32jPnU9QYE/ZvdIVBnSNplAfL+sK3zU39TvoOlEVo4UBj56
	 PKuJqcdaE7QPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D90B960846;
	Thu, 22 Oct 2026 07:09:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B4DD4371
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:09:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 97F3F606C2
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:09:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 62rS3m2pyOp0 for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 07:09:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 568B16079B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792652948;
 b=nnQHWQS302x0om4ACvOXPwNIYLuV8AynsZ3s7mL7PCQrNL80fzREmYi0XTiS4lNGKs4L
 07tBxLS6jskSnC58Ufv1eiSvQ2bndDLpYM4oPaL5uUqCqGQDrfgU62x13n+Qzv1UNAewQ
 ITB67DRv22tVBlfBdtwG26cEDklHVQU5ACa8SmxrHjtlZrZRKKtl41dSnWjmTGF4h76zi
 V7Pa5GDDytdv6nxhdIWG5QoJwIgTGjcnGUE9RzRfSYWjq1jNHLoYku8v/9JonyVU5YKQ7
 j09mcymA3FZdMqNWFNAPUBGWgrZuAmnIeOZcEwpmm+0DoA6unLQJRZx+TS82LrPTdAw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792652948;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=Ei8jBrS8xzsa86/y1464G+9OMP1rVVKdnHD20kfaZWU=;
 b=rZnJs4xqKLW9LsLGjkgx/MhsSOWgu+LCq2+H5tvQC8VNc6vhXP2vLyKi5VELrLIrsRFn
 apNGvwWaTFYYcXuRQDtbTyLYz3uqki70oIXVRObHcU9uNLTd4e+7kLITuhURMVGiMSKIs
 UzAjd4f2EatKccnBD4dAD2//rosgctOJFkwmj/RvKDjpc9Ad0eVq8GWWrxZ0qEZVRB5FS
 DEkiOw00m8QHKRi1BAPnoi1AXBp5ZSkCLPek5Tp34JOmZTLLNQ15m56jFYG4+6EtpYIM8
 RAgVRx+RFxLjRn3pKQFv648Z4h0F02AxvBqAMPFFmQ10R6L7d1T/TEP/s8OI91iEsaw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ZkT72mUc; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=ZkT72mUc
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 568B16079B
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:09:07 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48df4f540ebso932662f8f.3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 00:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792652946; x=1793257746;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ei8jBrS8xzsa86/y1464G+9OMP1rVVKdnHD20kfaZWU=;
 b=ZkT72mUcoq91Rz1tIc5r/qeYNAKwgZ7Gu1oEwTWkzW2EG9ciwA+3xNfpWVqLGwbu5g
 qLslHjMmlaKsBMnW1/82E/rj0TNMODWwMCJNn5EWjJzeXKfg8BAmE2FJT4YJ2Jy+JSzm
 Gxe1JHCJJTTBxH44Dga2BAp56jTkLRFlSAt9IrpiwYuK8zNwJQiaDDGQKvOzRuO9dbyf
 NORNH2CqjY5lBC4FTGj5t/QIzZBT01Yh8p5wSHiRczXhN7kki7IgUzw75mzrDpCZhZXE
 3FKxDiUd6/qrt8Sj7zqr7FxMIDleL0cHgppC6FR/uAiLyrX1bECzF94+aGpczc69LC07
 dUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792652946; x=1793257746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ei8jBrS8xzsa86/y1464G+9OMP1rVVKdnHD20kfaZWU=;
 b=jkR1hy5x7MCitGL8L62D09bXF7jfLfDWHdDbTPVbi+KVJqHcHEUybC7wRe3moirCxa
 6YRrrcf0qg2dvylvVrE2vZilxHbNy+CPIlJcWUrm6uP6VHSmJzf+XRB0a6urBkgY9nUB
 +Et+hKm5dHhCkFwz83LYBkttLmjJVKFZbdP9MY3ps39et3p20CTVH89asIkBDbylsZ9Z
 HNX9Ycf6km+4IvPR6nKylFcUdXUBvfNT9KuGT2Vf/cO1CitEd7OHDWK8kkr6T/pT4Uvh
 BY0vcYR63gfz7CUJ5ZK4BNVr6C9tiCAioyeddiipVFTTgInYFkgmhJ2BQFA3H0ZkgXlZ
 dcgA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwxOw6a1kaa+di5iPIxifSvkmWSmwdBoF7tTq0/8CsplNDzEnbVV1y1/m0Bz8Bp0UObSp6eGlw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKMebcr8+M4mcZTIDNrRjtdS16i6ei0ibnNPSV9e6ckqwscux+J
 AkxqKxpngHZjI28/9BB1lxn2sqvqbMdfrZY+P6uL7WsxUsww386H619tt/AnQgiwZwg=
X-Gm-Gg: AYBFou1qSMqOFEI+qPfN7UIZhJEMWtsBi7WfFjLmx4mt+gQG7fPGPTvYzmrrL+d5Y4U
 0vfz9ILqWp2oJdiL79GYUyl1lR4K7wQXX6RlOeJ+acq72cIofWEtzhfxPoAQ075/W3Oor1ifvvK
 fOSCssQ0ahyJfwpXgJzrNPt4gvl9SB1SX0SmIyeNUGNY242eV78ZFah0QD/c1xfo2Vnp4NJ25lo
 76nu7/XGU7RvIgtdPXdyJL4IHDegPhhHy+pYpboj+plIVukB8ezEI9MPwjGHSE4RFEkk+JKVkbj
 5DHbD6NEX+CjduOCMxB3TDlaiwDToML7uyaWTJ7uq34BKlEL5qenOtQMOecxBTPxOLVNMWwCDMg
 ODva8D5UEhdBfEUlL1cCDjTtTjb47/1GJnwHSzSwut7oaklJJksuz3yc1D6Bndv7o+jnC3ScNiA
 DnKlVwCtGkGw8ccZy6oVfScA/I+zlqsFx5LAL2ImJ6PIlOu8pf3XlTXFLy+Pjn5BOQ15VYEcSOK
 m7RhlDbkzVM3y3VSbNMWVc5rPzGWxmdunwstn9J5jdc9Ft1dleI9JqaPcKVq5w=
X-Received: by 2002:a05:6000:400a:b0:48d:f9dd:e3de with SMTP id
 ffacd0b85a97d-48e264de87cmr8120617f8f.45.1792652945930; 
 Thu, 22 Oct 2026 00:09:05 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25835247sm10347613f8f.41.2026.10.22.00.09.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 00:09:05 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
Subject: [PATCH v8 04/10] usb: ehci-vf: drop the empty bind hook
Date: Thu, 22 Oct 2026 09:08:54 +0200
Message-ID: <20261022070900.616265-5-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022070900.616265-1-mehmet.fide@gmail.com>
References: <20261022070900.616265-1-mehmet.fide@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

vf_usb_bind() only returns 0. Its comment describes a hack that keeps
the second controller from taking sequence number 0, but no such code
is there, and an empty .bind cannot influence the numbering the uclass
does. Remove it.

Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---

Notes:
    Changes in v8:
    - none, rebased on main
    
    Changes in v7:
    - the Reviewed-by moved above the Signed-off-by
    
    Changes in v6:
    - dropped the two Fixes tags, the hook was not empty at those commits
    - Reviewed-by from Marek and Simon
    
    Changes in v5:
    - none
    
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

