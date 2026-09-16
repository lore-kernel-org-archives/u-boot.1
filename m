Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34844C88E77
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 13:09:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E60B660887;
	Wed, 16 Sep 2026 13:09:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id atG2IwSjDg44; Wed, 16 Sep 2026 13:09:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org F27AB60858
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789564156;
	b=NPrskvoAFmqJDzpr15wN+YmC2ToAPEfieazsWY3DnhRu3oyJvSCVNfudgnjYSVL1bQ29
	 kM3qD4JlHT2F5tzDp0Dmqa43IJBNxcyMtp3Onkys8B0SDxnGbaB8VP4PfaMBWYZsSNNj7
	 YUj5y/Yy/w/HA9eV0Pxg99pw8P6udV7BTKzIq+uZWn32BNyD+aH2/1WacdMiL0lABP1Sy
	 IpHCW9cdUGf/ce7TGVqA/dPLFB1FDjh0ggD5AxgfDXT6VHLyPRdaqcQA6ukVJu8k7EVa0
	 xWvSUWubdVy86rhicrXhiuM2g7SUEfXMyPeKI0wzok6tRWObDQd1HVHPqhR2bzWw6QA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789564156;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=fMwwX0wjaGbPfILTlAay1EU0VhwLuv+VN3wxeP/afWY=;
	b=Qv7+0FRS+rWyD4UcArT88Jy8ROZURLFGYowWNTzbxHd6phLWkhu+hp0tgTWVNTlpvqNf
	 IWxyasrfmEZXzNixAgoi4BvcUJ/XQL17Z6R44XAPgVs4uiyXPqg8A3G+rOYxv/JGswnPN
	 TTlv35PHDFa9CKmBd2ROEeHe4Olz2S62f+4oTEtk3lsW2N69szwn+BmbonsK+yYwbprOC
	 9kp7Z4tJ6sNB9AH1MVF4DA5qkcB75wg1Ef/MMqdT2UB6daBcsdSZeg819JSZHeMStlOpv
	 aHcLnKRZ/ZfiuQMmorHb2RXKo6DxaJ95neFV+HExQHsoiBzewwO5fty2Yp8g1noUClQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789564156;
	bh=fMwwX0wjaGbPfILTlAay1EU0VhwLuv+VN3wxeP/afWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Po+xNG3PK8+zx0dOucDgtNiiNqoVQp56szFGGKRdZOTmVK/8VwgO/BoUwO1/NL9jE
	 DrZYmCqPzYPK8uCBrGRvi+L0nZor93RUsjimOY3dgkK1xdkKWr1BB2hnY8Zazw4EiO
	 nwt/CcSf6JF7kVClfCXIB4Afw90sF1HNUDXIe8VSJrDI5IdI7IxNjEKqtvTfRmEvQy
	 Kz2d9m/GkU/bUC6tH2GbCqxyfsh+lB+x8ZpcY9Ui+yt8rKbyuND2cTIGmPRfNhVruS
	 EHz2hB5Z0Yk0SzexzmoI/AaA1hfa1LVRDStylN85to/PnHrXWxKq0iisLfF29ZVaj3
	 wh9nvcExOP6NQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F27AB60858;
	Wed, 16 Sep 2026 13:09:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 08298DD7
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:41:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E210C402DF
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:41:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vze6e1VFRslb for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 12:41:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org B831B40093
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:33::19"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789562489;
 b=OWXktqXQIKuGG1G4JwH/qyZPhONLqt7KEaENTPoB4gXyvxy19C/OPUJqjoq5DM+TbqDA
 KmYYUu07yEABk+uVYQj3Ks0Kmk6SF7bPRT+aSY7AVi9QFO8XLIFHLEzwV/4QUnZn7m7+C
 +LI+zGk1gHeV2t80eooNWIxMO7wDguwktfTx+DSpv4u1rm0tlW4piJng2nTl66y5hg5T5
 OloN9u8eglEz8PCdzN6LqdHQLlolgEHhowu8NFUkyPhsyRJxi2jr9M5Dn93hUdFR/FeVP
 K8Je9NnJ7Q/wUGztHK+I5NjD2F9kjJcqsTdSFEuX2bnHEzHrVoY14fPuiLXO/0lVnZg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789562489;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=fMwwX0wjaGbPfILTlAay1EU0VhwLuv+VN3wxeP/afWY=;
 b=ahq06ogdhkk5vvOMMdHmKLj8usk4ETAldp6WmwyQtT/YeeXWFNqzftNHPvHjM6PpVcEa
 tXkaxz8ONzZG4wpFz2lMrND+U51GwfiHKHH49PrpDCLiJ5QdHktVMe1Gk/DYtwyIidy/2
 pp66u2vi/lnD/cY5g0PFxC1p9TYbqEMOlhCyIonGoaE4LxLXlQ36PAmvEYXsik7KQu3RF
 SfS0ZK0JS/c2BB1NU7CzN4eo9gbXC5rE/MHaO5PjSG63iA9uhb0scvyiN+/03jg+Cqpl5
 h/QRHEbgQSQgJPXubri66Ga4G7juuNQ0P3DVrwrYVIsbjPdMQggCuCubrnGCRb6ljXw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=xMrj6pHn; 
 arc=none smtp.remote-ip="2a00:1450:4864:33::19"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::19; helo=mail-ed2-x19.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=xMrj6pHn
Received: from mail-ed2-x19.google.com (mail-ed2-x19.google.com
 [IPv6:2a00:1450:4864:33::19])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B831B40093
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:41:28 +0000 (UTC)
Received: by mail-ed2-x19.google.com with SMTP id
 4fb4d7f45d1cf-6a9c0e04b34so174539a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 05:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789562486; x=1790167286;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fMwwX0wjaGbPfILTlAay1EU0VhwLuv+VN3wxeP/afWY=;
 b=xMrj6pHne5hvdLaDCiLo0PZQqwonx9y7bBDsyItWCcLonDjJHKSNP3dnQ/L28JqM5n
 vkWQJX+pHkKzs7CYIfzxvFCmT2D4BQ0BfOe5jQqMArkgh8kTad3WK4ynaPmRm6WEYgJG
 AF9/fBAB9Pg6qaB+CLC6U6y4VIDWtREXKZioh0Q3QS10dzDEhiAUuGqex63zRU/HQsOz
 OcWOhbD5BhLLwa8arQAKF6EwMUAkfp6oqXgnOeDhvfkrS/0IOHiuT61US56YubgHnOFd
 uEVdBwQXFUaR8LZL6UuU5Uu5DkLhy0QqfSCFjAOT7sFK4nYhLRuvH/yJDFD7iCHljlu7
 z+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789562486; x=1790167286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fMwwX0wjaGbPfILTlAay1EU0VhwLuv+VN3wxeP/afWY=;
 b=CKmNQjJXDqTUs9ubVkQ2KzG+MrO3QjQg4YOjJzZLodN5GgiYPAuWbJ77GVred9M7UL
 wmxW5rOcl6Rrq1CamlVn7luEwtLZCcaMFaUq7/jOkcjEEY0wgBiYWTUmjdw3VdRtSr52
 XmzH0O/O9YrE5cEwTrGnWzrIJCUqijnk+cflxckB9Qb0f8Tty7WRn0wWQnnfkPAjUIWx
 VIufr+QLpAiOZIm434AHYYCX+BjHb38MChCyL6d1ksXHUTaFj6WK65qVIAIeVThx+k+I
 dV9iIOCeY4EnfFaTU/L1AdHrxuIm4SVosgbwJdSWYdRjVDScK0oWP7pax9BsLi6OTUm1
 4VjQ==
X-Gm-Message-State: AFuF++m9kyfw2T7QkoDrertlSJHUYMlSAFFEoLqMkm36FA88Lql7o82Q
 UUxXGnTyGv8yIzM4FXlXn3Wn0IZ8K81ojtDbprbf2jd9Qm0muNNi9AODRbMT7iXmkQMdb+8+xkJ
 XBzkk
X-Gm-Gg: AYBFou2/+b3Aus7P9RiFRmXRx01/AF5Hrl/arEKk/q7SpiiCoWLkUkeeuuJMimdMhAh
 HScr3Gj1foaY2jjkiAoJCbJ6yHRUj9SfQwEdAV66MjeLy85EjgUv1u7KmTmRiwCxqeRItMZQLQb
 T1318Te5tMM+g0EobZQ0i37iZHh1Zi15JnZqvCbnVmaaUh0yfwrIJlvitDUSSglFfz01hn9BDr+
 32/rFSSxXG9qwveGXkRBkdvBLk+nvqdzr9gzrS9DelHIxWDxXbaGjE7SoFzZatJvsmEpJTUX0S9
 +oiWFr+ayb4BSGb4G3pJ3ab2TKdgXFK4eHdc9e3/GZHxr2iVR8xeupsxm04RjS0bFPlPUHKqf47
 LQw9eNErhZ6uMKAv/tEXnDoSIDqrVETRYcaRAuOf99wlPRhrEiB9p0vKL3v1t1xOOiovNa8uhtj
 n2qwx/DZ9Hbz8BLCDaIIrORIDnVnILzNiZJw5Mi+FSYfyxXOY9LXhrUfgDj9aP5+RAGyXeSBPg6
 /ZwwdB73yXL9V7K74UottmbqUxMgYAhpV+Q9fhXYljKQoJfm5eH/bT3
X-Received: by 2002:a05:6402:5d4:b0:6aa:12e8:13a0 with SMTP id
 4fb4d7f45d1cf-6aa22241932mr2008732a12.1.1789562486563; 
 Wed, 16 Sep 2026 05:41:26 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aa1d2a1289sm1487519a12.27.2026.09.16.05.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 05:41:26 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v9 22/26] usb: musb-new: set endpoint capabilities
Date: Wed, 16 Sep 2026 14:38:22 +0200
Message-ID: <20260916123826.517181-23-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916123826.517181-1-anders.roxell@linaro.org>
References: <20260916123826.517181-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 16 Sep 2026 13:08:33 +0000
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

musb-new sets maxpacket directly and leaves caps empty, so
usb_gadget_ep_match_desc() rejects every endpoint once epautoconf.c comes
from the kernel.

The shared fifo endpoints need both directions, the others only the one
they are wired for. The kernel driver already gets this right.

Take the caps and the usb_ep_set_maxpacket_limit() calls from the kernel
driver.

Compile tested only.

Suggested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Link: https://lore.kernel.org/u-boot/87v7az6l03.fsf@kernel.org/
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/musb-new/musb_gadget.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/musb-new/musb_gadget.c b/drivers/usb/musb-new/musb_gadget.c
index 7daff5850f19..cb55f9ab458e 100644
--- a/drivers/usb/musb-new/musb_gadget.c
+++ b/drivers/usb/musb-new/musb_gadget.c
@@ -1841,17 +1841,32 @@ init_peripheral_ep(struct musb *musb, struct musb_ep *ep, u8 epnum, int is_in)
 	ep->end_point.name = ep->name;
 	INIT_LIST_HEAD(&ep->end_point.ep_list);
 	if (!epnum) {
-		ep->end_point.maxpacket = 64;
+		usb_ep_set_maxpacket_limit(&ep->end_point, 64);
+		ep->end_point.caps.type_control = 1;
 		ep->end_point.ops = &musb_g_ep0_ops;
 		musb->g.ep0 = &ep->end_point;
 	} else {
 		if (is_in)
-			ep->end_point.maxpacket = hw_ep->max_packet_sz_tx;
+			usb_ep_set_maxpacket_limit(&ep->end_point,
+						   hw_ep->max_packet_sz_tx);
 		else
-			ep->end_point.maxpacket = hw_ep->max_packet_sz_rx;
+			usb_ep_set_maxpacket_limit(&ep->end_point,
+						   hw_ep->max_packet_sz_rx);
+		ep->end_point.caps.type_iso = 1;
+		ep->end_point.caps.type_bulk = 1;
+		ep->end_point.caps.type_int = 1;
 		ep->end_point.ops = &musb_ep_ops;
 		list_add_tail(&ep->end_point.ep_list, &musb->g.ep_list);
 	}
+
+	if (!epnum || hw_ep->is_shared_fifo) {
+		ep->end_point.caps.dir_in = 1;
+		ep->end_point.caps.dir_out = 1;
+	} else if (is_in) {
+		ep->end_point.caps.dir_in = 1;
+	} else {
+		ep->end_point.caps.dir_out = 1;
+	}
 }
 
 /*
-- 
2.53.0

