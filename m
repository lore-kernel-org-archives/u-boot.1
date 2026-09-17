Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D806C982D6
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 15:07:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 47A4360A41;
	Thu, 17 Sep 2026 15:07:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TGbj0nkftfqG; Thu, 17 Sep 2026 15:07:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 32E0160B26
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789657631;
	b=bnJJ/pUQqw08Vt99246o9XLueEzmLOfxXHsomPk8yJA7xGyWv+l0wuqCEVYpaLI3WUqc
	 sCJYegHTCd+V4AsEkXftWVBaDfEhW1AbJ3FD1+r4jytJVLnw33UOZoOlDFPYBa7H3bit/
	 RrC9rorlqNXXUgxdFj8Wp2X+2BpsvgCWXVPaIi+I8fGOPHf+KUuA9LydgHOCkp55vzwJW
	 Y7851QbW2qjRuxhSDxgnw14zE5EoBHplTTrULO7owxNIag8rVrsET21WoPhRuYj4COWNC
	 GdC9z+K2h0c9NswOElFKwS/6FFfgQPer5iIw5Vv7yL8zHadQL5b1Z9/VyadvaClDVKQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789657631;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Xoz8IYHYZ5c56N5++uttGieOxxsCFZ8Mj7LrJoTgvxE=;
	b=qo33CH2dbGywd7AKE/NaRybyZZfKy3WEXFIgEWGncFeWderrXJtSQq2QB8CiqMuxkw6K
	 KI3g8+s9RgruXJI0wl2SOkpc8bka3wzpwueQMWoe8rm1aN9T8Bv92g6CFrMJL4Y6WE35n
	 zEx8c87Crf+rOZTfrOwgZi7Fpl04WwgYqdeuLsr250w8jLner6fvHYe+vgI99Xz8qPbv4
	 amrKVqiRmMM0GZdBfAMaFpFQIS/BMN4j8+3Se8BnUSJ4r0liFnF3O1g0h/T+Fd07IZtD/
	 JzYRQfXjfWpRI9sYREZ4Ije0BlSBZQ9biuSRA1TeCOqLajQem6qYleW+cIA+Rj/B2+g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789657631;
	bh=Xoz8IYHYZ5c56N5++uttGieOxxsCFZ8Mj7LrJoTgvxE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fsuiUy32kcNZRKM5F5by10jZhRkM1fkMkoUYwaK0xJBWFWuq9bXXGWnrtrJYUu4q/
	 7c2DAyp2dC7UKdEGyCF9QBEXyjdh6XGg/lP17G//5EMNhBT7g2O1MYuFq9FekdxC8k
	 b7/kztTZAY8AJ+NcCCms++/Tx0FOok1IbgikTkLdqFDv7X425Qv64rr+gElCAZOqbp
	 m/aGnv0tiSuh3FALmBKMDiGYrCv7uoBNvOJoOjPqmogsjQhvHBQc6ZLnbgnEYlAw1k
	 MBBeNw85VsgSJByBsKukunGzvQFvAzQNmP2dOyPTq8NcQwycr5bC6BczWHhNYJrBHK
	 bpSIA1825tNKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 32E0160B26;
	Thu, 17 Sep 2026 15:07:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0C110362
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:04:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E63844051F
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:04:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MY07rhXuXg6o for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 14:04:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0CA23404F4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789653889;
 b=Uj0zAFiMKahbLH7IBNIazqjWAy+YPAYVf7wOCUdw4BKTM91MbkrAKh4f/Axq5flsPAVS
 2hggbgHL6ZdO4SJ3cX1WmD219ZVOmZfJa1WapVDDypLjck+BpLg/gOwGJGI341HU5YOwy
 Zg2C2YjbN3T9sxXqigLpMcjUwbB8RGIVCf7c3z35fDp5DE1iyVOMANm9omZoaG23XN+7a
 hltU5/0jA1qrH9ItMg6GImF8lcJfuRpTa7ntwkVcMZtimz7xT0nMZecn9kXD+pWjZL4Vz
 whz5mMwI0rO9AB04f5/gLtw+Ek7t/zYDNOLVc4LCnEccxHQpWDFdLqB1ap34AGt8mjw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789653889;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=Xoz8IYHYZ5c56N5++uttGieOxxsCFZ8Mj7LrJoTgvxE=;
 b=SFemv7gbnAjGEvFNc0RunUzT3FQBSkOyS06BPQ0r8xY2OCWWcPLqRfKNhToRK9cRULRJ
 bmoVsIPMpc6qjBWOL0PYSIsESFDI9gEOynOoGYt9exYp2Xl/vmlQXn1dfGzi3SoIgicnp
 RVGyzM8JCZ3CAsFUUsD3yTyj3g/okRRzJvC+Hz0Oo41T32H66kTgAL9vWmzqnDgKur/sZ
 65apbU/iHEVMfAo3tBNcE6DdN87A5J8BFelhen4ntlQIBb3HcaFzczn/MBnowvJI6zNA6
 6mLq0FFWMHZykg3pG0NjOf34OOYK84w6T2ma1bFiGNH5etjMO5OKSQUSJSPZG10QgaA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=VWiR7sSa; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=fractalclone@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=VWiR7sSa
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0CA23404F4
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:04:48 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e7bcb94d3so6278655e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789653886; x=1790258686;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xoz8IYHYZ5c56N5++uttGieOxxsCFZ8Mj7LrJoTgvxE=;
 b=VWiR7sSaSGbwcQ/GcrlNc0HvV0YIGCC3rPT15Kn17IkmGMw5T7pY/VfbULbh6r82CF
 f4OJlPBJnWfzOuzyE1oBAWpcLyIwS/qFZ+hIEi3JDjcfCbcVQJG4r1vTU815j5R5sB6X
 nqbzfbuKl3kDUqTbTdMh17rTuncHnBQihakOp/f2hhS9ChTqBZDgqaBiARy2AXLR4mUU
 reIbkf0eTeemfdzO+Cq+6+goHYxycJYizHGrKl7msAWoV/oGT9wzNdbCA6x3rXhqhfoU
 3Rl7pjwMlGuigar5cLWmnbD+AAGg8b1sRqFrhX8wX0kdcWqT+ShoRdcV4ADq05fE5+vx
 9uiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789653886; x=1790258686;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Xoz8IYHYZ5c56N5++uttGieOxxsCFZ8Mj7LrJoTgvxE=;
 b=ihWbEF35vFhRnOswzWjWQTK3Lpvmr6Y4sVzWe4DTNEPeDf43lRcuKIyBnkOAZxAWjV
 e83kbAeSE2KS1bTWXo9E3H2yqfaaw7jR3IdeIL4cvdJmXbwv8NmGhxDvO1PvxlyUTGEj
 tEqF9PmsryG7Bd+JWlGnLXkdi9EDVA3hwq+qBk6YpiVc1iWJITQBP1EhEoHVo0iV+a6e
 7LAKLJl/qN2LTa0DicyNSFgOK0uXFQ3D7LJV2ZhDaFb78Nw4WdRJLa/6zusNNVn8+sjm
 WcgLOeOCPEu2kNpls9ISet1PzSo6DFhWXj+5EJBlR2Osq9VikWSSdhC4NYskpzEwCoVK
 Q7tw==
X-Forwarded-Encrypted: i=1;
 AKwUvBysFipGnHLW3ZHhUJTTYOPb/SHLBdQPOm6XK8fpvQua4Rl5067ieZn8kup6TTSG3yyxOHGcQPw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mE3RYno8h2EfQUpwL1J8e+3GUGETAlHnA/UVrr9oN9Zs4z5kMe
 z1j2oU2eKdPqPcj2uKmHmML2er++EbaDDy2JebLhZtmyeh028wMzLQ2x
X-Gm-Gg: AYBFou3Ns4sF7u/YFbzO8M0tWvBG0g4SoXGPPug/lh7v+JdfS1W9KLq8Dtn06//h9dX
 GIKcPiWCZr3t3ZD/pt3MEx/AWQIl9vV3WVjkycw82z7eMCEDbNfrvGG7NKKLsGhGCpYFn/D4Np4
 oiiUYi1pZ5FkfB4Yejerm79TNYj+6WWkJ/ZnRVt+zG1HoaGAD1k9K4bXgPLAaBV2Yp3Ce5gRbZS
 2xLWGFze03BYD2KxsG8/EbsqTLnNlkfek+RlNrCO/LQrv96D0FGqIwnd78Ii44YWbrJ9F88nkEy
 R6tyrC/wqfMB2AVUNPf5Ozz4VkyceaiCPR42SdqtYXnEI7cF/hR+PVwmjJB4tKwrFn3MywuVQlo
 /8uzcS8yC+JrPqbVEWmJx6BNiAXQfyVEokvHwXB+QF0pAApSF8O5NaEqW46ajFWBVjmbcueQR3G
 xQj99GyeqL1l+1EKDovo/2ASFDyTaPLhWuIsTTkxbRdA2isv3/G9k+jkc3mla+amxAKkLG4shIC
 9iqsN7qrRP9LTqW
X-Received: by 2002:a05:600c:4e48:b0:49e:663c:c67e with SMTP id
 5b1f17b1804b1-49ebe991792mr85805365e9.25.1789653886054; 
 Thu, 17 Sep 2026 07:04:46 -0700 (PDT)
Received: from [192.168.1.138] ([139.47.34.204])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf34440sm15600634f8f.25.2026.09.17.07.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 07:04:45 -0700 (PDT)
From: Jean-Paul Etienne <fractalclone@gmail.com>
Date: Thu, 17 Sep 2026 16:04:33 +0200
Subject: [PATCH 2/2] dts: rk3399-rock-pi-4b: account for SDRAM LPDDR4
 params
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-rock-pi-4b-fix-v1-2-1b3b52c38ed2@gmail.com>
References: <20260917-rock-pi-4b-fix-v1-0-1b3b52c38ed2@gmail.com>
In-Reply-To: <20260917-rock-pi-4b-fix-v1-0-1b3b52c38ed2@gmail.com>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Jean-Paul Etienne <fractalclone@gmail.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Thu, 17 Sep 2026 15:07:06 +0000
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

It will allow U-boot TPL to automatically
detect LPDDR4 SDRAM on ROCK-PI 4B on boot.
Without this, the board will fail to boot
with the following error:

rk3399_dmc_of_to_plat: Cannot read rockchip,sdram-params -1
DRAM init failed: -1

Signed-off-by: Jean-Paul Etienne <fractalclone@gmail.com>
---
 dts/upstream/src/arm64/rockchip/rk3399-rock-pi-4b.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3399-rock-pi-4b.dts b/dts/upstream/src/arm64/rockchip/rk3399-rock-pi-4b.dts
index 55285c7c6e5..cf36491d0ff 100644
--- a/dts/upstream/src/arm64/rockchip/rk3399-rock-pi-4b.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3399-rock-pi-4b.dts
@@ -7,6 +7,7 @@
 /dts-v1/;
 #include "rk3399.dtsi"
 #include "rk3399-rock-pi-4.dtsi"
+#include "rk3399-sdram-lpddr4-100.dtsi"
 
 / {
 	model = "Radxa ROCK Pi 4B";
@@ -17,6 +18,10 @@
 	};
 };
 
+&dmc {
+	status = "okay";
+};
+
 &sdio0 {
 	status = "okay";
 

-- 
2.55.0

