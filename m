Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BA0606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KE0aJEmc;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=IJNtzQKL
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F02D981749;
	Sat,  7 Nov 2026 12:50:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vLrBZ7y52Bup; Sat,  7 Nov 2026 12:50:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5697B81675
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055842;
	b=A2kTZkhJJCIt09fZIVB3XrTvHWTZT2UPeEPZmA2z6fWczbCrIubZKIao/mvMby9vSYk3
	 MjU/KU/9zts+vjh7KnWkEHu6kS0v1NsBOTym5pop9NREn0mcoBxhCwf7EFn1XYUmh1dqv
	 vRDE87wWNlropdkITpTprIy0Dz5h6xZI/WbPHkojmNMnhS67J06oWiQRf4MYDS2vH1cup
	 viD1HLFW2py6D+w5n7c7+ST3ax6FhhXWZh/4SCNZiP9LeepMHgrWsxhqqjwfcCTJBK1gf
	 SA4ECYRUjnqSy9ix6HMvgtxmaQ7pka67P8Mv3qhPwX7jeJxwSKAjAUVFaUqrJ5zLtTQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055842;
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
	b=bDoHeGFyUez2fjf48yW+Ban1/4zgSsnAN60f3aGqJAmhpTNVmdodK1ahLXWKMq3qUc4W
	 bU5Wy1P9gES5kfZxlh06peecFndwn0KHJrPAdOPm3adD+5d1Fz3ke64ZZW7JbAoH1j9mN
	 ATnxOQVzhdQ3VA8rWtsGClPfKU9yyjF8vUfbpYqLkFehOYdFI29iqOaoC2MpAPh/iNI+K
	 4zoHau9Beset4dBnbnFy4Dz6afpqgboufbk9XwfrwSFlE5wuM8o6SGW7d3oCtTpyaQK7m
	 mabJxb2OXszuslm2sP3gzTqE3xzHW7OF/x3iU+DJgjWbRUgG7Nm+Fgt2S7ryHY416ug==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055841;
	bh=fMwwX0wjaGbPfILTlAay1EU0VhwLuv+VN3wxeP/afWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KE0aJEmcK5Xxsq2B9d9u6wb+6f//X5ITlMcF6twgrySCnMiC0hyMd+wI+c/qS2OyN
	 8AxU9ZVs4/W1Gxx0s33GawK7KzJ82hbiAyK0FC920BADjOwIeBS7sKT9qUWTbC5rJ4
	 x9F/9X0zYYwC4tvuIMNS/SaNPPI0BZ0VFTvLl3fmqdtXPOltU2zMwFyyARrjOUmKsQ
	 ViwftgZO4du8nKqVvlA7sVn9uzTrLSSnUJOmOtqre1bv6Oi8SP2WnDZXMVqUNALqPO
	 arEn/dFlm0bWMguZQ4ZYiWCPRosDdft3s6Jb7nF5MLMCKrSbOcAjLqhn+NVeCVwqGt
	 5XXEigp2d6cwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5697B81675;
	Sat,  7 Nov 2026 12:50:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 07DD734D
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:24:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 04DC240800
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:24:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z4s7U-wiaxM9 for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 07:24:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0679A407EE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::633"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=IJNtzQKL
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0679A407EE
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:24:11 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c2af2ae1258so14633366b.0
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 23:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794036250; x=1794641050;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fMwwX0wjaGbPfILTlAay1EU0VhwLuv+VN3wxeP/afWY=;
 b=IJNtzQKLEjlYXQ1MhOuDcWH5sORVRmoCtjnGysAAPbOjRvUjunP7U5fZFeqgaP8x8q
 go1w48SS8f8VPVlI9mNWo21hOdhfgFLE4iWfBsbO/Ike2q5io7d4Cv3NaDM8le4ZEZ00
 fOwMuPyAnFufzJXOIoLvj3ERyF46Ebf1LlvKkLw9MwFUTZnXBYqunszSOQp670Lvym0k
 CRboftgFp1S+xnfmayE6cKnZLGEJJmpQ5TP1DK3n+NIp2FJPr6DEJczyCZm1r/uOnTTb
 hK/m4O+iRVO+LKH2D5wBKoUmiebOUT/eebFEvtxjWBSA1jX7h37U3koZT77OFT0kplPE
 4ScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794036250; x=1794641050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fMwwX0wjaGbPfILTlAay1EU0VhwLuv+VN3wxeP/afWY=;
 b=IZ5gfqTFn/+CIIjuezQcCJWMpjhEMNqr7rWby1k0lticb6Un8WWR25yOVlSmrGWWpu
 DW3fhzNHhS3tfIxSYVsiUjRG63d/rgeM6EmGyVdCGnlK75HBYDtaGCwNOkFdJO33Mx25
 Q+5cWGY2KEvdgH5dw5xxi8ijT/ynZoRYT/ndZvGPLki7v2mv+uP1J+IE1gBISSjGyhZt
 OTlaYgDagP896dY7EU+4g9j0Oxe3x9urbjEo2LJY3GRR+8tGqf30NlfaPh+5g1a/P00Q
 B28AwNm267/Ce81R9YuLPBFZauA4YPIxdBDkwyG4YRLY+Z7W46MyHGd7CXZ2gtzNtsg6
 a+9w==
X-Gm-Message-State: APuU4Z+bVW6QjuiJTJc9Y98lQztfUoYz6m4LGczyZ3yY8vaKVgwIRzJp
 1Z3fWmbxzyihw2I2Lv+3ob02XlU7DcCqB2wDLQWTnar6TQC1y68le6Gh0G2IIuAoolUnxBoes0x
 IWSKp
X-Gm-Gg: AYBFou3MyeyuTMJ4iNM1/vaXr7xcGwfD4tG3Zsds3bRV3jvW/y6lTKuq3Dl+XsrdwGN
 0hhf201e6Zp6WwLmC61S9Vp1tkWYSphf40ksasbolagSBkhYK9yID3eR/8ilqwKfl/XPXCwbM1C
 oL7ujrVO5eMqDG/jLHRIRIQ7TdjJOASVBmYCpdhsTFL7CVajKWjfIbRfizJzqqJZbfYgA+jyNz9
 Ju8JXmm4z8seXB82sJV/HT0En4KvFYbKrw7cxdz/k1nhqrvlm9EzNZ/5bmN8MA9DGnPvda+K7EE
 oOgdwVuqWg9wGFtjT/wgp9Pnbq7xLkMawPXXqp6dE+u2t8P7FoeHggdBJdNjUfd6gw4N+XvxdLT
 P6WFrSPYfbHATgWOhERgzmiFxjaxddTuvcuwVLA9xd/yTrflz/sbT+npgmQkNmVR/PNJYRMBfHq
 pd+Q3QTeKgTuY08RzoV8UtJYNMkCNf+ioPg+epuHa4akmS4KtS3/LKM7wCN7hw09UcfQZFYYDL/
 uhz5Nba6D/mPwyQxoszXc1n76pmwjS7/L3b+ekSQuYtuPb9+OhJv9Edx4tyX5h2hF6AL4oX0ejc
 ZSeX1hgrJ9GJPOeYUJ/Ye+QZSgBFPgvKHYBduX97twV8BaHs0DBTkkOJo5KkhZEo7U6d+vEcMu/
 EwY+CmbeaKOYf8WbLJuLNBoaYUCfT0A1V
X-Received: by 2002:a17:906:f158:b0:c25:3ec4:9e43 with SMTP id
 a640c23a62f3a-c4d342fad94mr376176866b.0.1794036249662; 
 Fri, 06 Nov 2026 23:24:09 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d3562ea8csm130129166b.22.2026.11.06.23.24.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 23:24:09 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v11 26/30] usb: musb-new: set endpoint capabilities
Date: Sat,  7 Nov 2026 08:22:20 +0100
Message-ID: <20261107072224.3492260-27-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107072224.3492260-1-anders.roxell@linaro.org>
References: <20261107072224.3492260-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Nov 2026 12:49:49 +0000
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

