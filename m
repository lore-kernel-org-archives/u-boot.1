Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E38C79FBE
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 12:46:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 73F644079A;
	Wed,  9 Sep 2026 12:46:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fdNcNF2qG9rv; Wed,  9 Sep 2026 12:46:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9A0D840780
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788957971;
	b=QfsqtesJDEd9nj2QeSB42O+eXG+7v0RuPc7rZxrDX2NE/GcTYXHGd5j6ukurI62t122o
	 RiZ4bNGhJ43xHa0S37cWwsOKbSbEhrlo40tHJnqP6/X3q1VR0qAOKTE8BNvI1/9QnteTr
	 EyZ6q/2ZTfRgAS7IlOOZcjmX4BZ6fpW2oO7q4p85k/soP3vgr9Qq/hSs37oUB+aF7bT1V
	 DW0QmkS/ee9faWCq9po9scUG2XtK9IPiFapIwe2nE9wNuBNcxfA2RDsnNTSIIkVQIi5MQ
	 ASFKgThLb4EOtB9kNy3P0229pElGlB9o/6BvxR0p1SgCvyY0XLTOCuHPrykXB1ospvQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788957971;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Tg0wtztqH0CEUcdnHWCb3a2BBWmInfIPFEEYP/Jr71A=;
	b=PRt6K5p1GgSKlpo94ZCPPTVlSF3XjGYQdjVEpjZzkKhdK2dlSISaOX+5I0nC3bEEeX57
	 nYPl2xkd0NWq2HzW0XSwbFzZMcKeHJnN2BcM7KCvkIy3FzqkxZG/yhxMUIKshQLhbpgLe
	 n9rrCDLtCbU2l5OtBefrQRG7qRNs9bsOgBStbqhShVxkNhxWNabPwG+U6HegXw8AoHqUl
	 g2oRhnK4+G7P09V06cKJXPHxiOtOa6eBzk7dx/cclx0kLfHgizfgwRenUT+CENAzQWEn2
	 J363QiRi1MESYHtwd7/pun5oc1zMVs+QInK8OTjW+VBJVfsGhB0f4dzy2z/MftHG3Aw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=iPaLgvCY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788957971;
	bh=Tg0wtztqH0CEUcdnHWCb3a2BBWmInfIPFEEYP/Jr71A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vYVoQGZ5zUZ9iI7V2E2fV7nVzVcgMhwnmWhbauX9qKt6zItlDtW4fFZxIoozzjKDN
	 7D3sqp3rmLkit1XJofqjujCh/9jTqixvUFge6CIiupdoLjb0KoSiNeclgLZM8EdN+G
	 vzTJBojjc655ZnmD6yAXTkuebesIlFwHbSRznkaP7rNtRetT3a7MH723S/+UIQjh6V
	 I5Xhoh8suDBX2FKLHkd0ynnG56UbWPhLzXbl4sYSoCVTcDCIZUh+/5IDgzF7FLReRz
	 r06JAHYNCc+chDX5SHa+cHC1R1Ak8PRWsm4VYnIekFHPqOzGF9TT9Fhi4KD/VzdDLp
	 +rI3L4CvyDZuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A0D840780;
	Wed,  9 Sep 2026 12:46:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3D02A3AF
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:52:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2E921406D0
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:52:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AfeHo3ri-cw4 for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 08:52:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 228D3406AF
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788943942;
 b=UKGN1ZsvvEisdCUkfE7RVL21LcWK0r5x7gaW465JKYPj0LXz/fvmRYPEOZ48eIQyn7t+
 VepcM7Ee4FIQHUxt8mVLA4GVwbfyyauua7J8wAJUXlHS9YaFW443iqlgK+hjXSyaxcY6E
 uep/+rdQy/Jl+yMRWMAGjgonxwz1TzxJhySzcwCPcemx2kS5OeS17VYaZ6GwNB4N+rOK1
 wrJEExtI0sighqqNseo6SHqoX3xtciWcKbPfAIofcb6hGbc5OK+7YWG/QGP4d+bXM7kEe
 hq+aWUfdP9plidOwzEwhOjr83UtsvmrXp6z144/o9l4sB0uyjmC7j+lxxZ/RGE6Bstg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788943942;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Tg0wtztqH0CEUcdnHWCb3a2BBWmInfIPFEEYP/Jr71A=;
 b=HT15i0MU48dz12VMZCrewuaLuWGYMA41oZN5RZlHtlBSFru/v0IhVKg58TxWlpDe6/yP
 Ltoi76jydsH6idmlklEkWaBzij5dNd58HQLNq5Nn++ETxDA2FIx/NuKFLPMOOm/BiN2cq
 9+JMGOz8OnZ/uM0JHTw9IkrJeMH+OE+C2bdf9rH04H6RD+WrQOICVuJJVxBW7PlLvz4Ml
 U3edfq2WiPjD8AaMZ8VuqdsT1aES8HA9AJOrv0S2kfaOgJayqnukpG514W8s9TaE0an/D
 yVPKlDF1RFZ1L++v5N1oyP1r9UmRohiY81rjaRLHw1/6vO2ktk4aEnovi7c5uQ+uj4w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=iPaLgvCY; 
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=iPaLgvCY
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 228D3406AF
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:52:21 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c254c50ff6fso68907966b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 01:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788943940; x=1789548740;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Tg0wtztqH0CEUcdnHWCb3a2BBWmInfIPFEEYP/Jr71A=;
 b=iPaLgvCYnGxFOTuWJQANZsNqw/pJ7xFdaiqw7l+MP+0LceST6oBNigGbsnT57D6s13
 As/6mGaFlaY8y4i52844NnKo2mij9JTPHei/KOAHig/MpevKpjG8g0hNz1wjTOgAtRUL
 8XJ039IUn33JB6mWWxkuqFKFox2YOP0i7KibmPS10Z8SU1NsRg7WSq1dACPL0ntCT6EO
 CiqTtSE5p+SyklIlU+bAbpzQhATKYHecK4kMWTg871WVz/FPlI6kh0ZO0w8dEdJiqL7B
 QNNJ620SRaSF8OH9hATE910/W1WLQUqXEM9D35eWYAepHEmtCgtoMzSm94KKakvW6f5t
 g7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788943940; x=1789548740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Tg0wtztqH0CEUcdnHWCb3a2BBWmInfIPFEEYP/Jr71A=;
 b=g4MDvuiJg0j7c1Sd+7rxAp654YRYZWQQaHsd7//Fhc/yJm00EBVR6QSpR563T4CzOx
 4kmWdIOrCJHqYlu8Y0sU72TZezevpYqEMiuQ/nEJEuexilCk8dVlTsnCYqWvK5o2kZDI
 lcU2xWd0GcPIy183xqRe1+pMxe+U9m25C09JKUjRy3PpLlkX06b80Zr0eUmEEulyfdwn
 PoU1JEK+5dup26fifScBGhFcGgq9D8PS0kiE5ncBeHzJ5RoIcp5n/8il5JGVYueX+W96
 I4DQLrdsXAepAF4aasM8smYSvFn2LCphla+B42TyyXYsrvjZPiyNvkW2BaIKK0sW55Xt
 5yeQ==
X-Gm-Message-State: AFuF++lCh2viZ1tRA+ecCJWynAImwM51+D0E9OUZK1RvdgoplURfHi1M
 nJTT1XRtJoi7ZRwyUUjkMaFwqt12O2LeiKE3xpKd/3M52OdZHbeGY9e4GNw46XDexGJEv9cYtCZ
 asPK2
X-Gm-Gg: AYBFou3opQ/Ytvj9rO2DpGhdNXVKZKvRMFOKkRQZ+vh02xyuIQM4SoAAijlYLbwr/wW
 JXukhMZRfyU8lqmlg21gUKPPWj6jokTL8n9D+aUtdgyXGIhWa50mpR0GpfJepBqlWjxH+h8GbBN
 gAoJNKfpjsB5NvV6TlDoFgiCZCEWE1SB724RK/Mb6ayEKN8WcHPLa4YuKsCPtdqPwtgTWrAAiRY
 2z/3Vn0Ig/O85+zi1LdXeuWyQgxdUVnMZmJ125gVvhmgzFAIS2dlWPAYZo+lHjW9/X4aeq4BBB0
 JrwG3WUTsmFO1KSf6WzFJJhy7S4IheE5WQSAwQS6gQugWHAPVbjjlyfkymHMXg23ksYhru8esZV
 OXYNHtLXLl7IJ50m1wMLxA/DgJ58oBVn0CCJorDaChrrZRD4oYI5/UVokGBQ+egAzNZYEwIyBy1
 jLffkp3wJJkSzzPTuSEaQkyI2wpx7bRJsp4kL+9A5KJblo4IcNGMHz9ohs1TBVpWngm6TLGAfiD
 fy/d4N4c8VptyvEY6SSOn+p6uJSd2RS
X-Received: by 2002:a17:907:7209:b0:c16:604a:b2bd with SMTP id
 a640c23a62f3a-c261277db4fmr1264444466b.3.1788943939807; 
 Wed, 09 Sep 2026 01:52:19 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c260d5b371esm730398266b.54.2026.09.09.01.52.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 01:52:19 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v8 10/25] usb: dwc3: gadget: flush and invalidate cache around
 transfers
Date: Wed,  9 Sep 2026 10:50:00 +0200
Message-ID: <20260909085015.2480097-11-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909085015.2480097-1-anders.roxell@linaro.org>
References: <20260909085015.2480097-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 09 Sep 2026 12:45:47 +0000
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

Same problem as ep0, but for the normal endpoints. In u-boot the trb
pool and the request buffers are plain cached memory, so the controller
and the CPU do not see the same data. The resync dropped the cache
maintenance u-boot had here.

Without it the controller reads a stale trb and no data moves. DFU still
works because it goes over ep0, but ums does not. The device enumerates
and usb-storage binds, but no disk shows up and the host gives up after
20 seconds.

Flush the data buffer and the trb once the trb is set up. Invalidate the
trb before reading it back, and the request buffer before handing it to
the gadget driver.

Tested on BeagleBoard-X15 with ums.

Reported-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/dwc3/gadget.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index b3a371df3749..fd0ae9e3e092 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -228,6 +228,10 @@ void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
 	dwc3_gadget_del_and_unmap_request(dep, req, status);
 	req->status = DWC3_REQUEST_STATUS_COMPLETED;
 
+	if (req->request.dma && req->request.length)
+		dwc3_invalidate_cache((uintptr_t)req->request.dma,
+				      req->request.length);
+
 	spin_unlock(&dwc->lock);
 	usb_gadget_giveback_request(&dep->endpoint, &req->request);
 	spin_lock(&dwc->lock);
@@ -1385,6 +1389,9 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 	wmb();
 	trb->ctrl |= DWC3_TRB_CTRL_HWO;
 
+	dwc3_flush_cache((uintptr_t)dma, trb_length);
+	dwc3_flush_cache((uintptr_t)trb, sizeof(*trb));
+
 	dwc3_ep_inc_enq(dep);
 }
 
@@ -3153,6 +3160,8 @@ static int dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
 {
 	unsigned int		count;
 
+	dwc3_invalidate_cache((uintptr_t)trb, sizeof(*trb));
+
 	dwc3_ep_inc_deq(dep);
 
 	req->num_trbs--;
-- 
2.53.0

