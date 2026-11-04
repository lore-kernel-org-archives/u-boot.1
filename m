Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B8A606A326
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 09:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BQg+GnC0;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=L4Kx9SpV
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BC83A81083;
	Wed,  4 Nov 2026 09:41:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EBWuWk2CN3Sw; Wed,  4 Nov 2026 09:41:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 09D478104C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793785267;
	b=GTlNzOE1sXOuzzNHDPHV/Q1tnWYyutORjgQ1HrqVNPcN3jWIFiXZqnDuMZYqocgfxnln
	 D6BbYuIGZQrSiuTpG5OmXkpD83A2/YcNoNTWqNAbe30gx5GVAyZQXq9TZ0q/G8SHUJXUG
	 6xCJFRJ4asI4mgvSFydxCmfIdFgW53jVA5KXR0uPDb5/Ynlo6np4XpwYiTHzJ0okiLVHt
	 B6Yedr2aJjCfRdJPf7Cx9Bh6kwWS+8ofo5qAsmkaoQw4lkGirBIcG2Y8aop9TAptNb5Xu
	 XEbuXElLIux3L+sVdKZNg70BpI2J71ZGSJAh03bfilVYzKQQVoNvMDrETB2f2HxI1mA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793785267;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nW+8tuv8EyCjaefTLnfKRDUittHB7/mYc6xiPw4AXnw=;
	b=AnAOcqeFmOH69ZsuVPaqGKs+CqtZNqSiHmkjOx1QJ6EQdOPKE5veaTWRC/gjHh/reaHw
	 KNG1seA71ZWrYrcrVxcXdzHMcLjxHCqI84yUmLhT4PzRFlb4d0iBSaYp250DAAFPMad5o
	 lEuXkQoaQ16h38ruiFKQy4VmqgF3NwUP/rf4MbZwWzkLjZ3z1/Tqz3Ozj+VsS5R1jV0kv
	 Z9MAKn39xSlPD8rZyoztA/BwTCvR0XGVlOJXaFOf5NR0LZc/CNlMl4qKSVhUFrlHjMYG+
	 Jr3x7wAdvzHWbO2q2iCWAIAfRO9d0yrS/ySyq2u0SKtsmVprO4OFdyjPa+r56ylry8g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793785267;
	bh=nW+8tuv8EyCjaefTLnfKRDUittHB7/mYc6xiPw4AXnw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BQg+GnC0QpKyX5a9DqQBBPSWpK6aNdeclcyJYq4pPN6cLav/g3vb7vUIlwqKiPy2S
	 ZY5muZ2UyCHi6pbZVu1rzy4wvUgwOW3FY3fTtITINH/hWzZC8VJcIjcR6tDn3Ymdm7
	 ay7P2hOwULlWy/U04VYDkHc4uMUp7hhqSE5sz/1MbWmZegrfeBZmJCjgXNlJB6nM0W
	 K32ZT48Z1Qvfdgumy8PHijA6OosDOLEynfcbzczOqGor5mstbzhFPpvRrJkhC3iQP9
	 iOBGls2LWsTvhxxGMkK4mIpEQ3EroLaSuj0p+/GAb+PxNU6bC9E49NQYOK4RRNm4o/
	 7tSp0yAxmtu6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 09D478104C;
	Wed,  4 Nov 2026 09:41:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8DAE437B
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:41:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7FF8C40520
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:41:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uLXqqXfXyWp2 for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 09:40:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7EAE840478
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793785259;
 b=YDyuECf95mG8xdYBPI3pueEq6fTU+5wn4bVh8TS2/TuLwvV42++cHd7zRG8ABNS6i0k6
 ezhNR7amVk3VJgoh+gFmPtsiMQNvkxK9xubRVsum8bzYJINaXPOLNNgtMQkT9vsrLV4Qx
 hTR+6gSm7dhyUug/x64qvxkxAhMMdaH1tGbFvfaz3cQv4u8Uny8tHfPddYeUPKPK1F9Oo
 KvKHp2F/86rnX7azM7HFN1qg3gQ5XvYuHLnbh9y39zOwva75KpwZ6rlvLb3bp2+PKum9t
 vVpDa4jRucIQjdeMePZUJ+d7bB0SoaMJVrea0OAUsFFRzXNGtX3F9ZOI093tkC2f8+Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793785259;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=nW+8tuv8EyCjaefTLnfKRDUittHB7/mYc6xiPw4AXnw=;
 b=p8UVH6M/8yC+fXN/7O3MYdwaCakzBmFpjyypF8fHnOzzvgk2JWza9sGtNyxzbe15uvM2
 H8wB/CEZTI6KmdjwxWepWziPgF6TmBX+0hLMcfmGwegLwMzFZIUfOhwdZGX97CbRZVKaX
 6HFmRV2q3PiAFpkgKwSCqZSkd9yUhqsTQMBY0+hAkG4hp0hOTNkCGr8sxynQ7BXK3nz4L
 7M3dZW/Owpsndz+GqBDiV0jzaGG6Qz/ZTs5IYgs2iyOMLkG/rUMM1e66j5z3uCYi91g42
 IxGrMNUs6K46vKjmoMTqlGtSN29Wg2WqqAmROSw7hQ8G98Jrw7Xo7KU2NyDd5ugAo3g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=L4Kx9SpV; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=L4Kx9SpV
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7EAE840478
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:40:58 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a2069b9710so3748865e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 01:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793785257; x=1794390057;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nW+8tuv8EyCjaefTLnfKRDUittHB7/mYc6xiPw4AXnw=;
 b=L4Kx9SpVM2IgCNokpDzQkjrFl4iRK1vM7em1oIooRFIjmnrG7FbafyUY6Dswb2bXfA
 dj58H5qtFxayRj+dNF+//A6TQyMHkYGfysDAQ2tfQt0HtHmS50bvIdiL1EipuO8NyRtv
 F5CkboLq9hVKFf/FItFtijTqOU57cAVOYwZDyRC0hY1LAIHxy4kojJx+VFySJd9X+3rG
 JswdrIx3stl2Y5GDi8sY8Gkkec0mgsrTim4GMrbjxl1+gyo16H/QiHPVj3IuU/AREh/l
 IZS+NaMvl8mXCAC9JvEQ1F1Zv4iX+2S737WK5PuT4AIEiGdc6n6Y9ndRgptR/GNq9wKd
 5Vdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793785257; x=1794390057;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nW+8tuv8EyCjaefTLnfKRDUittHB7/mYc6xiPw4AXnw=;
 b=qwdUXGLizKG4NrP9sBiCEWN2xRCNOyHYBC6XL1wo80U1fj7eNOId4//KZqG8WkEZIY
 xDMVJu4xphw7sg2bkV1bpmyYKZ4EAQ6OEIXZphgNWSTdIvA3ekJz9Z49gS36o1yOb41Z
 LXYQXHA4m4rlB+1dIjOD4FN/hAkE2ovXGjEzNaLxRFGnJYlj/Fr0KU24Cw2SebVAixgo
 zTvRq15Mq0xlNQPgwqBFGWG1CX1Ccg+yiQ3wdHq3HDgFJsCQpl2iHn5pAi7PnTvOpOkS
 jfPhAHWpZsLorDVCi6TV5o5Z4cATAeHXJlQcABT3pIU4mx/N8QCBwt4XDHSLmnn19wTN
 f/1g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwSpycxZhWBW/bc1g9On5G41glQlHZGqSNobpOyyDNnqjG8Jlcja8ItLCEROPVn/0QtBhir1AM=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z84iHQMDpuLkER56spZXeuCPmkssNC/BL7zQdFleO8qrvdudbeB
 U3KJcGpURz0YCd/C5RRbYQct6eCs+CdOsTPY7mPiAq8B6Q6hLRU7JFLhxScggy9+Vmk=
X-Gm-Gg: AYBFou1cRSXEvhlCyGD6YrgEMb+2MJWo3hrp0PMrGNgOOCUZvwj56BG6rugmTplLb67
 n9MXmHwlr7T5s/gWvitxXkXSp4WSoTiwF3XFW0hvBHrCLTWSKzHKs1OZ7A/XlybAmKb/4gYtExp
 OoPrevrL/KM7IaS1cFo0p3pw2ziddY8nI+Ml1BjUbuuq2VdGkQTv1JW2orM/E9csr2dqaCRU497
 SGGJMNDqqBpgdIjbtcsG8dQaeFFQCZt2VwohdBrxucxhZJZMH+oRe2Mei8FRHTzsGFwp0mWTmCG
 34gs9phcZDO480I7vOCEtwXQn4/mGcJmylvoUJE70SqakSKkmfE0kkisuj1KOLxXpxiJVZ3Kq40
 e2yDCGvZbuusqa/BGVqS9ZuPKqz5trEr3bR8n8rIHoAKEPSk5IaAzwIYJkzEMr6aPBPdpS5Icvp
 Fj+ltRs8ZgzoS9n+Bk1yaCVScgBg8FDWQcNRKxeoFEAjUHqFLzhQL7la81QdBCm48i8PwA/wOxU
 324lVdxlHyS6ssjtI2690i+gmlgSfCJwwaj+ZVTrF2XqYb0kowuj3fc+33dkc8Zz2K7F4cUIdaX
 zOjFfXH9Uvtt1vbUdx/QC6EUzQhQZZCIZcNbmVkDg0ZBGrwXqoTvPeWumL/8Dsbq0JwSHnGfqcO
 TGnx4C12Lt2G6DXeFqSPgrTzacPUlI/vOZwNPC4bHHTM8NA==
X-Received: by 2002:a05:600c:19d3:b0:4a2:a3b:7aa8 with SMTP id
 5b1f17b1804b1-4ac14fbdd29mr353265705e9.3.1793785257114; 
 Wed, 04 Nov 2026 01:40:57 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b4527fed5bsm49856945e9.3.2026.11.04.01.40.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 01:40:56 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Wed, 04 Nov 2026 10:40:23 +0100
Subject: [PATCH v2 3/7] usb: gadget: fastboot: do not boot after a failed
 acknowledgment
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-ccaione-upstream-spl-fastboot-boot-v2-3-cf9781441ed5@baylibre.com>
References: <20261104-ccaione-upstream-spl-fastboot-boot-v2-0-cf9781441ed5@baylibre.com>
In-Reply-To: <20261104-ccaione-upstream-spl-fastboot-boot-v2-0-cf9781441ed5@baylibre.com>
To: York Sun <york.sun@nxp.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 u-boot@lists.u-boot-project.org, Sebastian Siewior <bigeasy@linutronix.de>,
 Rob Herring <robh@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Daniel Golle <daniel@makrotopia.org>, Sam Day <me@samcday.com>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A failed transfer of the boot acknowledgment must not start the image
or leave a boot callback attached to subsequent responses. Keep the
session usable so the host can retry the command.

Fixes: 3aab70afc531 ("usb/gadget: add the fastboot gadget")
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/usb/gadget/f_fastboot.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/gadget/f_fastboot.c b/drivers/usb/gadget/f_fastboot.c
index 9a2e9850112..68fe657f891 100644
--- a/drivers/usb/gadget/f_fastboot.c
+++ b/drivers/usb/gadget/f_fastboot.c
@@ -492,6 +492,11 @@ static void do_exit_on_complete(struct usb_ep *ep, struct usb_request *req)
 #ifndef CONFIG_XPL_BUILD
 static void do_bootm_on_complete(struct usb_ep *ep, struct usb_request *req)
 {
+	req->complete = fastboot_complete;
+	/* Do not boot if the acknowledgment transfer failed. */
+	if (req->status)
+		return;
+
 	fastboot_boot();
 	do_exit_on_complete(ep, req);
 }

-- 
2.56.0

