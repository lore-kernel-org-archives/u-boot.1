Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0E0C79FAD
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 12:46:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9142D607B9;
	Wed,  9 Sep 2026 12:46:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c1rMYNGvhv1P; Wed,  9 Sep 2026 12:46:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B622760756
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788957994;
	b=DsbpxvMnhNuPcFIn101+CXmY1c/Q8I26vh98TQh67opI5BBiEWz0Vu/+K6iBS+22k/MX
	 jv3YAHqSVR7DstvI2yjBzPdBxcT5+8Z7Fgmmjit912ZU6EtMnl7syPvusazDw5ijaHZEr
	 wLywUaCF+NQA6Lxp/6mpXitJvsOgS2tqgcBFPmx8fCHNjzW06DyBIiciuhQ05VtQ5KPBy
	 yimM2Jb8WT4xHpomAJASWFbtWuaO5OxwQSYBUJYOGchYQoZQ8nuFEmQJyedYNl3VtAqzc
	 lXSWolH7TPbcWalbS42UKKkEKO4lH5co2F/l3+GpWAhErlzgLyN/FKjsTtTxXjfhkhg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788957994;
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
	b=an1xQ7GHpDpQVg8D9RZs58LZVpSIvD0Me83GjVm7VJ2Fnj2/UN6E3BzqiHEfAzsaeb8O
	 QW4ufvlgMS922sj24EJRXi4qbKprqkY+D+aSArEJkHDfkM/U8ukmkB/Sjqa4AVbDroeys
	 WFcjqbffZA51cokuJi0HpK1EwvGRAvzNEk2xhx+w1P9PWYDmqx5EKQjDMUcFXMnP9lUe7
	 NByqwV71cc77CbHrIUCMHpLmFtSaOz58kh4ZrVMBemAl+7z0wdPSPOH8MhazKg0WSszrr
	 90vR29aGew9y7drAG6rTLPOUXYYcxqHUfpRwJwyWzSZcW0QpQNYn9MsksPoIzNXkgdg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788957994;
	bh=fMwwX0wjaGbPfILTlAay1EU0VhwLuv+VN3wxeP/afWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UuxaKLdB7v7eOjN2LGv/Z3f4YyE/Q8SPwkdcyJzBXZSru67iblTGaI3b+WzjzTufu
	 FMfExk5dtJQENbIVxYWHsVmGsFGtmmPUwszp05tMUqZcfRy8Sx5FUYcPX8sBA+czPv
	 fhHKNiRkgjDgHAZ6bWP16vdD/Fbkl8uMnnqhzw48esPFKPr39og21caGP9JpnojoBH
	 +lxaNgOdTqSf3nsHJYy2eYSpTkrDMOeyfhNGOCyIOcsRbDm/7fK3BFaornOx5kkrNe
	 ulH4ZFd6Dpzg+c452WWd98QBZB5Gggp2pdsVKEOCtAdRjdbgiZJCF4+OZ45fKYSATp
	 D/iSFvtoFRylQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B622760756;
	Wed,  9 Sep 2026 12:46:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 26FAF3AF
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:53:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0CB99406D0
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:53:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bW8UngaZLjPi for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 08:53:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org F14C7406AF
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788944005;
 b=A+a5rLh5b/V87kZBjwK8BKozbYwZPep3JbxOUt1BqXf+83GyQNP7gQWkjhqMGnwN6xZB
 0avzJMW93CObwQx+L9v3QtL8VIsbQBUr6hT0pQE8XwuP+bJcTzLbiqtFkWC8FYLZlBfCK
 N16IWyGMowqWyHydso++tXU8nevwKkE+8bioVpEpuIwiPNxaHwjeW+D5i9bZ93k8lntHk
 h9yQGWME79P2A5UaOHD7PrgXHd7SNP7Yl0zU16YA4X2ZKVMVIdvVc5fLILnajwGEHgRwR
 Z1yUJj1jHxF7d29+qPeOgWRvUnB0OuNyHFXDNoQ9JeJ30KODqHWpHODMs83Sp9NQCwg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788944005;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=fMwwX0wjaGbPfILTlAay1EU0VhwLuv+VN3wxeP/afWY=;
 b=JNgYsC3pm6WiePrMIrN2AMMXIVhP51xG4V3GcAqcVzSE4yxqXhc8HW7cmol7Rdx2OPdN
 0gqHCJUorO2lxrLmX2HNwRAy7fXqVWjT6cglLIa0T9rKjmPiD+Aa//Xe0v3eBzRvMEOOb
 pB1H4QtmGS/4k4C8N6OEp2kzHy3VvjwDYlBvenHQ5fUqQTSZJpezKqNsRLpKtdhUoxBfr
 8Gp3zjFkR1Xl37n3C+O7vth0Ro2KC01BqehybJCpuCPvGi8Mnah5Wl8oFvAp1JMgfXoSe
 TqQ9XlILYM1UtgtTxP6tXTpOEgFjHl1E3ogPEvAq3Yqxs0BlTQorwa9VKv4CJKKVVYA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=xSIwaHXD; 
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=xSIwaHXD
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F14C7406AF
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:53:24 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c250848d11cso74847366b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 01:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788944003; x=1789548803;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fMwwX0wjaGbPfILTlAay1EU0VhwLuv+VN3wxeP/afWY=;
 b=xSIwaHXDTqVMACeeQIp/C6bGRTxZQ+dE51bAoNHVCbidSkQ42kx3PnVVyVupbiH6Rc
 U9qp0NFC6Zik3Bw0nJa14poX+aVr553FhSUThLzSC2eGTWAeO00RSB03vQ6R2iqw9DWt
 MUrQCQWwXUAKXMbrp7zbqhNI5hjCXh9IioQUVE3sOyH1RX2k21EvCLGZgS3s+fgepLFB
 hIIxtA6dMTA+qqy+zPhDtsU2LuRWm34uoLNJj56SJpgV4w4QI/odO8QxBpNehlEY0N3w
 r85nieB02luOwj0+kjQz1LfLbFeANF6AiLc25F/qbWNmkrPcxRxLwyZ12vwmEkWlK5nW
 SqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788944003; x=1789548803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fMwwX0wjaGbPfILTlAay1EU0VhwLuv+VN3wxeP/afWY=;
 b=s07W26yL9Aofq5P3cmKlgRXvNWHy3BAO/RpOZPe8RVksr0TgxBAAx5JW8Jtdw813EN
 dTtHtnh25BJCNXbqCl+hp+J/erU/28I6aQp8QahbmxIKEUfkRd7g+YAm2dMshzw/EErm
 tz/C9WLlq4v7CPToscA8EdF0sk3723UWmF7t1TfHmVEIx5fksEssEviP5coErc2tfwKy
 POLEUKEquMu5u+lWN+e9pedat20QFNk0AHsH3kzXilkDzjkGAZYUkOF7bIXAYE109+7S
 fJc1KruxuWj/8x5ZtyG8xQlCxJ8PBHWwNmStsZBl4qa+qWSzu0g/DkgLt0iwkmimMnvN
 iY4A==
X-Gm-Message-State: AFuF++kCt4J7JlJr2RUTbqSHDu/t8EMPCyQZgpMCO8SauZuDLDn2Fgft
 DwOEekEiWypvoo+i+yCH8ndbU0CYEwExXDitdPSekkSGIyooUvJhn+6Jnq3YoieCt7O/fkvP5F3
 z4tcm
X-Gm-Gg: AYBFou1HTSR0mzLzlh1dTdA3oYNUwB2Z54Oa3wHaalhGWuz7tiG+mXYtFjTJBOE3nI+
 HsP2E76GOv5v99/csY0BoM6JaQD4PDxA/fyGCqHuEhiw4crNuZI/egTd2UcbHlXkTZsrhBOCPR5
 3DDB/YbcY/EVTv2BGXnJTBLjf+37mewnEDJ8exTtyQomdm5WApYGpi/yyBUqGK7a/6FAA6eUpSD
 R42SIoMHwpIpXH41aUvkKoIW6a8KaWkboO6x1plT23ZlRUwDK9UciI9PZREXg8faYXtZIf4Zp3T
 DbHidy+JM8jOgVp2cOJxYXY0KKedJW/feims3HCTZsFL7XjmKJYNXpHffxC3AZTNR981Ef/KLPR
 Hr9tCOSj8ZngoFJYWY4p6FMUdaAhUPbhSRtr89AZhROLks4Q2sSlSpZVXvTDYfQY6tO5VcDSWUH
 aDL6KKIcygtNWslqiQoCaev24gxiA2h4lk38n+ZdHr7zVWl9NyWylrF57jPEk2ryt0ffxLoLThS
 opeQj0j331DqAHyRtTeFOGoScVV4Zxw
X-Received: by 2002:a17:906:c115:b0:c25:3ec4:9e43 with SMTP id
 a640c23a62f3a-c2624d2422emr996651066b.0.1788944002987; 
 Wed, 09 Sep 2026 01:53:22 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c262f97f1a3sm557381266b.19.2026.09.09.01.53.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 01:53:22 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v8 21/25] usb: musb-new: set endpoint capabilities
Date: Wed,  9 Sep 2026 10:50:11 +0200
Message-ID: <20260909085015.2480097-22-anders.roxell@linaro.org>
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

