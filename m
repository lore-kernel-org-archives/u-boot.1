Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0A0606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 11:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=how0aH05;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m7zQanLC
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E50E460671;
	Fri, 23 Oct 2026 11:16:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lHSyfEYmqO2F; Fri, 23 Oct 2026 11:16:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 35DF06068A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792754182;
	b=dp1Hd+Cdb2m2qC5xvmwOyomk/IWHQ4y3JXWFYPY/FT2QTTOxYLPOC3Irv3Hrvo0uy3e4
	 qGF7BeHpzTiAoPwvFwqo0mf6LGb2Nda4rP2iusJVuZoTOudDrT3Me79djs9JtwBRePpkU
	 BW/VN8iJx+FHG1B0jImPnzWQ+kequ3ePChwVGRQ1eVI5tjF4RESCF9Wu4j9k6c3/Bqqxq
	 GfxyS9N0LCjO4Bw1GCyHaOWipT8k80nObpjQy4lerpGNTWfVKnHnpOBwv7KWvmhafhCU3
	 Cj7bYMieat6Q77IjEWaQQxX5bRlEjDPwtWzZepMy0qbAv/XlRB3TH22efExgq/lzd+w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792754182;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Qh8UQYAtPC02walzDFy3fFKJTST3njVv3aL+/VPVEMQ=;
	b=ikn6/gYHbdXDFefWCdI8gFQ5oy0f4Emb6HngVFmNPgg2LJxZMiQNutGOWmdavfCZMvaK
	 neBQyQXrJ8L4NABPjmgoZAQzfT/RaV+6XE+FAWikAvU8UwP3/gzAcOUlucXfZD15z0Dg5
	 0cuO4hwVaCVbbDIoxRtL1lb9ZG4UgpRSbPP8lej3Twb8J9DBNBXmyu37ocf71RYGwFW+p
	 k6mTx1lm1gSYtF7HaK6hrhu5tJ/cXHI5DOY4HcEbJpFrQQ1rsY3SfKl4i7MNIf5BTL+3n
	 lcaDLfcY5Y6D4N9xxfM5Jp6OkG9Rl+4qYvRmUG6uSYUQcBktvnKGswwjkeejCGf9fhA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m7zQanLC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792754182;
	bh=Qh8UQYAtPC02walzDFy3fFKJTST3njVv3aL+/VPVEMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=how0aH05pN5hTEMEI7Kwv2QoC/+GhMzPa0m9yk5tz7ilEpnQcq4WjDsEjq0CT8MfB
	 msSG2Gmde2RNS05UPmn8y1JJPmm9nG1yEZQq6WF7TqJwecGAvu/sFy8tygkUDej5+D
	 N+QaOdymhYt0Y3bSXgGtMBqBhvz5fZ+9iqonkw2L9gQcd/jvn8QN7PaiQOjoNoKc/Y
	 gdj4s+DJjXPhS+wwipPyuJW8hJPOrpkKb4uvFvoeYg5YgdvmUHW6KaKRnD7m7ZBfgn
	 H6sgR/ubJEcB1s8NNRVrLkvqAfVu5133IXX05Wvjn8dPR6+ShEbQHuWsAxFkGNqwfB
	 L2gBiCpKAq0Xw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 35DF06068A;
	Fri, 23 Oct 2026 11:16:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AAAD949D
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:16:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8ED6E60671
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:16:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hI2Ruw19Qipb for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 11:16:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6889160697
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792754169;
 b=WLOoYw3AqusjV+aIKO/LY4clx//jgwkwLw266n+elkfmWSHYnLE0u5iQG2PRA1TUaFoT
 Fqs6Frx1odyQ8nGBI8xlHYaucUK9VBwN0vUdrrjdkutrVmHVemqHXxn8cUU5YI2XpDw7K
 znoTqaANUGqgsFu0vePOQKHP0kpJwXafQy/AckvMRgV4ba7saQPhSi/bzb/GSBGfbDPSX
 scIcdvNnN6edaTTHB+6OBws/lP7AraDRJ283ldbEseV659QgyHsMpjhr6O+yx4GLHPS6N
 +S8iIjFjXYY5yNpMnYPHkNcuLvosxOQ25ML63yMSXaCjH/H/jO4hqzaVgbawXn3oIOg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792754169;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=Qh8UQYAtPC02walzDFy3fFKJTST3njVv3aL+/VPVEMQ=;
 b=SyzclzQ4AQMqB6YutsxmYpvLwGmG4Wzrcbg5I0v0z/lXo6UG82xxP6W6SxpljzLWa1+k
 1QzjEcL7WGIrDhZtRfjHaF3l30jcDc5YVyNEZ41zNte+BHt4cL3YWlysO4hUzAT5/wEfe
 I1+yYfYxh93ARL6Q3K5XfPwnpFhsMZXOiKnygiXzjb9Iykxi/RDb4OfkPYeCDDBIkHpsl
 hbsr7FPbipYFkTD/aXNmi3fQIZt4kBm7nc651L2FUCOSLN3Nq+dOMeTwtlfGH+1kE2XBN
 vaH/aaUDOihWvQY3gy88ZZ4nr9oXK+XQ/6USmr+BUYSKae+XNuare+T/UzuecVKDdTg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=m7zQanLC; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=m7zQanLC
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6889160697
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:16:08 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-48dc202a60eso399003f8f.3
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 04:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792754167; x=1793358967;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Qh8UQYAtPC02walzDFy3fFKJTST3njVv3aL+/VPVEMQ=;
 b=m7zQanLCmbJ3r5Twc5vT+3znpEhnyUfcWVFJSkQn97EN7H4HLoxQNaOuTsxuakU2y/
 wWrXUMCQ13vYbQ7wIwrnFAkmrO0kW3W/cnUob5f5ZeMRm7zKD7DrdkajvHLUGHTRot/6
 nOvAZqF4IAXfHTSpxcZkQeHY1gKaVG2s4wBzhCsEoy6d9jhFtIrFYk0RaNsfx61B00/6
 EVuFzqjwh0utcrlkuBH+z/XWZw7IHinQlyZsdYwu9oEyjfJE0XhZUSZIo7OcnyB0ivL3
 NJQft4DHZri/+k3uUt3DSdgggNH+vJVJrQENXNdhBG/AVFBnGeIWuoh8X1PGYkid5/yZ
 VjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792754167; x=1793358967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Qh8UQYAtPC02walzDFy3fFKJTST3njVv3aL+/VPVEMQ=;
 b=zyl4M3VJcenUhZ208Cqcr+dN04wmS8zEq1NcjnqPbgTpEvFieElwDjzofd1jYMmaLM
 +iFBqTiQXi/evQwMEU3SSUnJjD5AWkIx0fRh53t2Dt2Nxe5SQFyGAd3oINJn76tAgfPK
 4kOfRWdhz5lBFcjHmFbMYfiJbZCDhvyXBiJNr3JJ9DmTfKJYwLZxsNOmwMNe+P9tWSLo
 J0si8pBNQfRcSSPExo+n2fmJ1JUw1+188O0qj6OLEW4KWFVlTh61zK4E4yqu0osbDDAj
 gRFNFdpcg4lUkpWHzBYRy83pv6gj6dGQ3lWy3aGDp8DEo19jGmDR12UPt/6qY8KrGNcK
 276g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzOHKiDsflxwZO/1gue6Eyl4ZSsZWwzEbOL37uu+NBc3n5WFhBViNUD9Ubxo7guMP1dkyeDGhs=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKNVko7daqh63SDtxlLSsgiJdn+vYZHvRo4Bo/RAVuNWmnsYH0b
 QI+L7SOdNDD+Z6JZmwq3ndAjbJXDfYk80OeMQbEfR50KWyQlX3Pr70We
X-Gm-Gg: AYBFou3WtVuA7MW4vQk4SiUNT0s+W5fR3+BlcI5aYsJKubaTsCWRrG78KxKjAiwuX4F
 8vsLuEFukpJiZSTzsfoygvI4qLLZBVg69y4lKo/lea+CBAVnFtKG26r1z2HEEi8ZTC2sUlt3r6d
 S4+bSQFkz10WulS07zbap1/BC/bwjC/1DHB97DdBXlzxhHoJUbnqLVnLsptNCmSniTb/r4cwy91
 X+F0FZWDa72eVI1GWnkhsBM5zJYfyK54vhmF8/Yquy38vHBBid9bw6JUugBT7YN1jcQzE7W5+V1
 N2jGTBXoI8iM7BUQa94Y7Wj04IWtnYJXueTpIeZXT+VIWEjvJMPAqEQxd5Riuqipnvv7HJ/pf7x
 1Y3jK7LaDF/BUkYnMOIg0GGDz5N4HrV8knhW4oDeQtDosfB8B/4iyiENao7vZ1q/rsKNMorbBVz
 BPwMSVrwXsGe/gy8o43Hgi3RqZLdHV231uiroaUHgAQMxyncpNIoeVb+pksURUH7tE8NeSPwSda
 JM+RRWNRutlYtrb6ddnR//T25ZNCEiecPefwF2bKUtRebA8WrV5LA3egWT1UA==
X-Received: by 2002:a05:6000:2407:b0:488:89af:e95b with SMTP id
 ffacd0b85a97d-48e38546d09mr2880723f8f.8.1792754166887; 
 Fri, 23 Oct 2026 04:16:06 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e37edcf9csm4596141f8f.4.2026.10.23.04.16.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 04:16:06 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>,
 Krzysztof Kozlowski <krzk@kernel.org>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
Subject: [PATCH v9 4/9] usb: ehci-vf: drop the empty bind hook
Date: Fri, 23 Oct 2026 13:15:54 +0200
Message-ID: <20261023111559.4081795-5-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023111559.4081795-1-mehmet.fide@gmail.com>
References: <20261023111559.4081795-1-mehmet.fide@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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
    Changes in v9:
    - none, rebased on main
    
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

