Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4954CA5FDE
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 21:24:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 70F93607D4;
	Thu,  1 Oct 2026 21:24:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RW_FneBuyuoB; Thu,  1 Oct 2026 21:24:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BC04660B5E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790889893;
	b=ei+xu6S+MkqQ0QoEytq6rhYFdsCdlcGakEbTstxmhewWiAfNarqbZDedaWuuGxfL55Yo
	 G6P566IqWrDcoFZtStXWL8hc0sCwvJpq4Kd0Owa3avhM9RWi+HVLfSIxK1jCREuV+jjqt
	 lUye+7ov3aYxldOQC4AgUcXFqTm1YkbygSZ+V4gUWPHwgWSaWCoZ1yLy54gSnZyUmZ6zN
	 npFLhLXXK1fLGQdQjFkcvaiW1Kf2mcWqJ23jKepPSAJfcrv/OD7gWA9P8QZ4zdYTy0eE4
	 F7tk3PJNMe2DLDBwJBLgfMmWUSeyu5b9+uBpYt0YmgaoivaWnTI3PavF8VFGFMRZnjA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790889893;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GaXuf9Ip5IEWh0KBIrV4oDCTNCSSY+kz/Qmq0scsDlY=;
	b=M9BsBLb4OIIzyL1zGym/3bBdZVR/ZHdM7CCISI8XzA/8HXc0KMoCzq92HlQSgK/nEoem
	 aEsIiOXhODlW/zWINt93fsyd8VMT7558lkyxEbRbWTPXdJIrh/QgeEvuwl9UmCWrPRHOK
	 2HV7a3ijPbkqaSumeKho33Bh0J+Y/GKmU7+X5Xt7lSx31Ic2ZGxOHDgULw6+VN0Nu3ayL
	 igH7ZIg1EsG83Dpq6CyLcAntuapBxu7XUKwbWimAkzntHRwNx80BUCjWG6wDKbweZ5Uxj
	 PTPS3z+VmSTARx9zBeuSqoe19KMLSztIcHYIM96fIXM1ktPzNlr0lZo7yBvCx2tiGMw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790889893;
	bh=GaXuf9Ip5IEWh0KBIrV4oDCTNCSSY+kz/Qmq0scsDlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AqpQQcf6TDapvUjjxGkpt7+08NQV14Hap0GRQSvbdxYHCBws7WBiahW80kIsv7Ibn
	 cmLrs284pniK7Ow1JbGGb8p3ViRwFgE3VqYWdCNavc+pg7n9+k5dycuDyDMm4qhp0t
	 P3C6o8pv61cb4lhZo0GoqKZ9UxVO8IDWMltJvbBL9IC0MjiiQeNrzXjGdlsZAdDhzq
	 jScz4Vr+0gYMPOo6kFYCiQMS0ZrLOoRBvy1Zv991V61nD42Qe39QfS6fiKr2CLnhLJ
	 /zmDRNXBwmqg1h41HDp5zbaIr8ZZNgYJooxcZL/auwAdS4FqdJE92wy4/qj5FktwNS
	 0XBTAKXt6k9Ag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BC04660B5E;
	Thu,  1 Oct 2026 21:24:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D891322B
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:45:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BEB46810B8
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:45:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DAtncKdKjGKt for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 20:45:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 106D5811CE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:3b::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790887524;
 b=gizjaVlywYtYZ+xJQZgKEEmWxUVLfDHDzGoOmFYj+eS7YAXlGbo0GHaEMJ8iFHG0EdZi
 5l6pp+buDzH9Fs6W7kN+oHANq+1gYqnFlPc0oQ9OTvLBDTBL4q2h/+EgJj3NVU0asyDEA
 Xg8IzHC9+88tNuK9mkx++D3tgN9o+BVENmQ25zXsiwaMtw+RhYgOMDRak+wESv/Iy+9aI
 75l48wvp4No9s1cLg3wvD0r88W1h6gwZ05WeS0ZhPr7qvzRieBSF62SgZC2ugJJfQLzsn
 bnLsCcFs1cev+/UzVyARAosoJsOGWg/TEeB1HgwfroSKfypI/lHq23XlQwlbY8Gj2xw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790887524;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=GaXuf9Ip5IEWh0KBIrV4oDCTNCSSY+kz/Qmq0scsDlY=;
 b=oIAb9wCbkcwGgzLJmgvebOHv6wtWh41msDw6pCCfvIvkb/B0T9Raw2bprZub1XJpTYQE
 I2sW8v7TT0LZwaLqH/4cHTuIbWyY95LUJ4u3BJnd5EERrJ4FACQWct0vruCTj79zCZJbd
 9rhhMHo2jCywK1m7VjDEWw/wJwRhDUcwISIoDd0GNEUtMWN4M96Bk1neXsO1aQ2FnUiy0
 d5n2ElbSSdmNpVgFcgmGyoPlzoYsUPwiYBbfauegWUxmpgtsy7KMk+CcUV3liU8USyEnc
 QzQWnOAhAwsXLeRG9IQAarPLJ9kZ+OjXDGRweHmhJgn/8yr9LXbQ/k9UVGDIKWv7GzA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Uo7V+smC; 
 arc=none smtp.remote-ip="2607:f8b0:4864:3b::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:3b::e;
 helo=mail-pz2-x0e.google.com; envelope-from=lqing2013@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Uo7V+smC
Received: from mail-pz2-x0e.google.com (mail-pz2-x0e.google.com
 [IPv6:2607:f8b0:4864:3b::e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 106D5811CE
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:45:22 +0000 (UTC)
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc4c08393b0so3203076a12.0
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 13:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790887522; x=1791492322;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GaXuf9Ip5IEWh0KBIrV4oDCTNCSSY+kz/Qmq0scsDlY=;
 b=Uo7V+smCbkDIOTy3dkD12luaxvFQHdJfmE/DUA8NAnVldeSqVKv2pWc6KwDcmEytFz
 XFox8jW8e3lEboRzYz5PXK5z4CcdxUQ5+ptiQj6NJiM5phv5HbcvD3g+hnPbcpPCHYWJ
 2YxXcE9w3dp8TE6LE0s4bYe3RCMMm2ii1Mka6YOSGcjOYTz+n62B1E9ZXENnKmN/tpOq
 vLtD4JJmX+qAQqx9WfaBvESpYw44yVW9h8dvZIA2vNRfd/dX5oo4y/ZPddwzCV3RjTWj
 S04meUgkbmMthv96U7sknvFUni3iMBSehpN/qp/0fYq2ymgXraCxfmeo3rx0E6F/olH7
 +idQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790887522; x=1791492322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GaXuf9Ip5IEWh0KBIrV4oDCTNCSSY+kz/Qmq0scsDlY=;
 b=CK5Nz6MecJJ0lhjx6H0KDNbIHITI8OS+agJ0EW/f+wNCq/Tq1O4vcdvZuGHhhzSa01
 IwiDczBCnjeOZ14zUsZ2OT3RnJsex8jjPLSfEnQsRSgPN8rG+UxJc7UPcET4X+Zp2T6X
 VKLLk5Bmm98T/F8pbCH/pc52JbnShygsm7y7XMsUUuzPAqvvPM20zBkgWUQ+3RcSksdE
 hRw6964opHeewpcwMAmXxhqwe2mI8V+F3mx4L00xcvzoDa91tAlC7wgURedCHaZSclyA
 HhlctU7XDVA6FcQCmlVK/Si+CVX75kT7USuMtBAoxLp3ZRO3+SzuUxpD2Yv5TF7MzlnI
 KxuA==
X-Forwarded-Encrypted: i=1;
 AKwUvByujhj1LC53kp585/qMPOM1bsmqTpqJ5WWfYwTKUBYtiV7EbXWADc8Cl6XMKz8eq9ORjMCCZzk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJki3MTlqQ1gi4EdZGLCQY8Zd4PvHZ5dBdXRBZxtEscGeqCGoq8
 YcXndjWA2gljeB8hn9k/ghCW1e89X8tNJUy0MhGkIqRkQw927oumZdX/
X-Gm-Gg: AYBFou26VxjQ0UtOue9ANuE1m48e1qfFypOK1yNR89Ro+TcEJywJ2WOcMabeBZQ281T
 sRP0WDGRfxK+eE0AZRlgVJoY5WtnBYqSy8krQcoX4BH5SC21MuMLcsj6SfBPGu4oqnJK3RrhS9x
 GuVguU42yAnW8fUy99dY+BdeqSh5yedBmXSMNxfwp0QAriovwfVHKBT7/T+DdIb9dQ/VbZTh2DR
 OG93DMk0gd6lMXbMEY89MWAaQBlogQZbke8hZQO8KBiw5NM2f9Dmv2sHeDH2f1gof9AtbV4wJKs
 S6LP7cYqlq5nWOUFWIXt0rJaoF9EZ13JCRFyaqvHFpBrvoQO9xY7PgDfAZ0qVQkku719J6scKT1
 A0MXTpnkT4gjrVXO3Jp4H6cYCjLWpieLxEAPchlkHu+FQrPPi7x8++B43nfT96CwEt+x9OSZIT6
 //LV9NI81FHLUNMV09h5NKIFn7bGuHPXsGK1cGLNacqZwkUwz3a5JlTFWskQvIKv47JgSkpdU6I
 GrIEB787VxCurwFDC+s0TI95Nfv9Cd+RwJlyA==
X-Received: by 2002:a17:90b:3846:b0:3a0:a4fb:e738 with SMTP id
 98e67ed59e1d1-3a6ce851dbfmr668192a91.54.1790887521935; 
 Thu, 01 Oct 2026 13:45:21 -0700 (PDT)
Received: from localhost.localdomain
 ([2409:8a30:2e86:1710:20ae:2ce4:794c:d830])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a6cd634734sm883877a91.17.2026.10.01.13.45.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 Oct 2026 13:45:21 -0700 (PDT)
From: Qing Li <lqing2013@gmail.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Qing Li <lqing2013@gmail.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 7/9] soc: qcom: smem: expose SoC identification in the
 environment
Date: Fri,  2 Oct 2026 04:44:50 +0800
Message-ID: <cf7f290393c41e0c0afc0be2af9e1fd51876f3e0.1790887323.git.lqing2013@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1790887323.git.lqing2013@gmail.com>
References: <cover.1790887323.git.lqing2013@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 01 Oct 2026 21:24:42 +0000
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

qcom_socinfo_init() already exports the serial number. Also export the
socinfo id, version, raw id/version and the chip name so board scripts
can distinguish SoC revisions and select the matching device tree
without decoding SMEM themselves.

Signed-off-by: Qing Li <lqing2013@gmail.com>
---
 drivers/soc/qcom/smem.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index e20523e2cec..cf433957bc2 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -1014,6 +1014,16 @@ int qcom_socinfo_init(void)
 		return -ENOENT;
 	}
 
+	/* Expose the SoC identification for board scripts and diagnostics */
+	env_set_ulong("socinfo_id", le32_to_cpu(info->id));
+	env_set_ulong("socinfo_ver", le32_to_cpu(info->ver));
+	if (offsetof(struct socinfo, raw_id) + sizeof(info->raw_id) <= item_size) {
+		env_set_ulong("socinfo_raw_id", le32_to_cpu(info->raw_id));
+		env_set_ulong("socinfo_raw_ver", le32_to_cpu(info->raw_ver));
+	}
+	if (offsetof(struct socinfo, chip_id) + SMEM_SOCINFO_CHIP_ID_LENGTH <= item_size)
+		env_set("socinfo_chip", info->chip_id);
+
 	return 0;
 }
 
-- 
2.50.1 (Apple Git-155)

