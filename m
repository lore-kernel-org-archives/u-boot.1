Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391C2C79F82
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 13:44:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 53CE640B04;
	Thu,  3 Sep 2026 13:44:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VcgaRu4wfdLK; Thu,  3 Sep 2026 13:44:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DDC7140AC0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788443057;
	b=PQE5h3CnoCyksi+z7oFXD+RUohnt1JB+UweF34Gk5hh3W/G7pKJLpOmP1xZoV0OjDMtc
	 k9/U68kXSkoG3GOXe1wqha3/ORgWskBeAsMZC9Tu2qzSEOdCo8p47nmZdHLQwLE+xU2kc
	 PsbdD0bGBcotfSO1VZhE4QZeEWM/UQYTG/y5gYJ7SDdsP4Iy2YY7edDxfsHnWYqAmq0jr
	 nKLFiwlb8Rq/YnTT/sc44eqdd7Jj5NJgkF48J3F9rpgEMj+fQ/ZR0MNmyWhCpBuBv2ra2
	 Cc8jBu1EFikGHeBbH01z+/7sHeNSr/wke+8Z317NrucfeI6qs6Hs4ktvCIgNxrrenHA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788443057;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5rDjxfJfoVFLLMs7oRm8AEpZm50JXaqeYxP9VMcqLwc=;
	b=QVDWYUy+xBxvUiHURHBh/yGeAob1N5iXbcbPWp/AFgKSVGXrRG2pDYbML1OjQRMyIEOz
	 WzZ1hRezFLT1iX918Z34iUk1dK1aA5UqUgZ+VOmObe0kmEg+P/BUZQKyM4sr9Nqxjf9BS
	 O07zf1AdaOG6RNVWGzT04lDqssMdEcWTFn/YdK+B3pqANR25TxkTsVkqs0ZTzivC0RLuz
	 JolDVK76IRxtF5B/piWKtML/VL5RERNQ+LyU4rG+NDRq23T//zchILQxgGeg1icAK3KyA
	 DUqI006zTDFYImb7gkmSEeVp46nChSnUoufLIONcHNTw32ACg3r4+xbXIniD6TG+QZA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=akesIhZi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788443057;
	bh=5rDjxfJfoVFLLMs7oRm8AEpZm50JXaqeYxP9VMcqLwc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NtCr8d3HRJeHUvJoQUzhUhNdeYkNMIoGEH7FkUV0S3alLF4PEgmdNINeJ358Vk/bZ
	 KG2drbqB5wKs+uZB4Hkm41DjVZO4gv5LBiMMkacTO6h7D9FzYe/9Xq1lO0I61Y0i+e
	 jW6EQNG8xb85v8XtXA28q/Dwxvs55oAJjLhKIfOBP8kYlby8V4WcTZGA1SVnwT711U
	 IfsB/DcGiNtNYijKr6I5DOCN8i4xwQjxLcuSjrAZg6zcxywtgoWTc+x+rlTB6UR9qd
	 PgJ/BiyKdCxMWqSnGoTD7NtbmPUxQoBW1V0shNBVMKmPgGG0LxHTUjUyumUF12bvhw
	 uULB448lxAufg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DDC7140AC0;
	Thu,  3 Sep 2026 13:44:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C7DD22F
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 13:44:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5E81A40AC0
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 13:44:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tfJXfRDeSD5T for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 13:44:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 58A7F40ABC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788443054;
 b=M6/BkPNboAuzFAAZ2PzEy20qDNEIf3H+i11YqUlxqIJQA7BHjkQRyQAuWFuG2tu8+VCt
 advQuCY3/78/DuqPWcw80k/1phGxzFcVbABkxZYED5KfKV8vyoQT0s2+3EEV1U6xt6CBE
 CA5+Sfujuq02JMJVfAq58A9l/sLKrHWF7rc29C5CM24uUswWmtsWfInn7gPd8Qr646gRh
 jXEX8cRnTP2hkTOlOyNPWLhC0d3Ll4gmPY1glE4ATzvxJ2fvqT1WsgzxZDQeqlOoZdAOo
 ptLhSbnUQThlhZ/ULJp37f/eqh9LFJy/Z4mhZe9wg3gO++Bkz1kNssOqojo8OLCq1AA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788443054;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=5rDjxfJfoVFLLMs7oRm8AEpZm50JXaqeYxP9VMcqLwc=;
 b=OqoBaTXYHtdjsACgFHTNhRAW2ua+rXD0j5S2sbnxF5tUwZuci3dKGpNLcvMIzSKtS0s1
 iTDhdsSB8p9989tXL8yAW3s/38zLVOYQMRPHz2A5wwAs0W3w/eHluxfO0fpHlkp1ARf7A
 HVYw9TPC/pZ4iNL0lXpoYkSSJZ80hPWC4YFbvP3Cc7pZJ4bkG9wO89AOQXbmB7lDrXuwu
 PZ6ie4sNYkMzt0aL1eLIgrLHDlHrTRhF/m5BJcO8tvgwsbtTi+nccpXuWgvZ76i7tocMh
 QbE+2IHdGY+djwj8QRV/XORAIn8gNPLE1tcvThiq1sjjQQtswbPWp8mupMqxFVdApOw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=akesIhZi; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::435"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=akesIhZi
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 58A7F40ABC
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 13:44:13 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-482f9309813so2253622f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 06:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788443052; x=1789047852;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5rDjxfJfoVFLLMs7oRm8AEpZm50JXaqeYxP9VMcqLwc=;
 b=akesIhZi/MtCVAmu684zxfWXCKMf7Jc4EV286LGpWpmICAkZpROIF8l+Bkwqjyk+8a
 0Cp/+qkSh9fgM/PsdcaLSp3jSPwJQSAkUFtqd2/mJnSasrU2rZvjSEo5eks2xlkQi52D
 YwwD/k8ou6Hx3wxywBwpDyEm+iU7xyOEg8OLm1yU52938kHhNB1vvwCUB6ITfpoWeOaY
 9jIvI9wQ4YwSiogKLnUAdf6R5EoYMLB/WnOi4+iMzxnS51D0DK8uUkSnYrmqLVBmupij
 WI35NPlNpB5oJXDeMU8xd1pGLeICLG2i7/TTlkpqQj4186WhM2XexpjCJ+mBN9xAzacb
 0piQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788443052; x=1789047852;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5rDjxfJfoVFLLMs7oRm8AEpZm50JXaqeYxP9VMcqLwc=;
 b=jig1y0+YsUgKfIAvwY8XkcRUOTswFYtRJ2NY/WykZ7IhpGtUpwMRwDz2LAtbHx6pPV
 CxaAWjBu44EWbW4RthI5kMRCSe7VGXwLplkTZ/CDgWoVEBZ0to71cJ41djbHZD0om1iq
 onGrXi3+FliVCbcWKgoBdoNd93U3sTuiV6CsiLTbz20BO1JuboLygt+ZgSw3M4wT+Ya7
 jrNCHpcGB6v1TSvJYFesu0rAxbvLFmn9ha4Nm/TzhuvVRIsQQAT1agDnzALg45CzUklH
 LhE/pEl0uEdrayWbBYH28i4bPc1tho29Tsq9ZrR6JjheidZPjSyErL7RV5Pg/lyEhIRL
 yDUA==
X-Gm-Message-State: AFuF++kL73UdWymYRHa49IcpPms44W1OJHOY1zZHrxrHmdrgWkQRu37w
 uo4GFV1ihqkkF0yJqM6+gro5nDKd8blZvTXDczyW8WwB7FT6V/dSSwyJeVYp6Ywnl5s=
X-Gm-Gg: AYBFou1O0MAK/5Oo/jAO+hfXWRIXEc/euNBbtqpZrLYVs/9PzaRkaz5ZUFjbDwCnhbg
 on2rAVbYkF76Gwwgk7TnJ7q+i2mVIf0I36HV5EIO8Eu5y9/jO4hZD2obJi/0sab9pVbO/WMb/of
 9dQ0byocRW9yKsLKwsrrF8Bb7vFmF5QVZpZD+xQX5rfubYSRvcU1YPMVFee/l6Q++ICKZqjYG+H
 yJuhTbwd+lIWuos1lcDlG3iuZ+yZIfeLaY0TEl0G9cFK1gJ4YRvY7kFV8rIg61SLdQ1Ea1yBEqm
 bY7Q9NPLJ2vz9XVB2Qj6sBWRCrLUite63s4oBw9FOPGixtiQuFzdrsfE9VDl18CtAkxWwdWVk9E
 kpuomflvPY/H25Xwd3PIlBgwD6RgMSSNGa251MK++PZ/c6AgRKalN3y4r3W4RV5rI3XQ4VWitUS
 /B9LtxVwfYrQYvewN66YWKXQ0zJD7u84gqPeez8yD6xy6VMVOeGh0JSN5oDQ==
X-Received: by 2002:a05:6000:2086:b0:47f:96e3:530e with SMTP id
 ffacd0b85a97d-4858605d13dmr630025f8f.8.1788443051672; 
 Thu, 03 Sep 2026 06:44:11 -0700 (PDT)
Received: from localhost ([2001:4090:a244:80d4:4373:6c2f:4372:b8ac])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e72f02sm13697050f8f.3.2026.09.03.06.44.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:44:11 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Thu, 03 Sep 2026 15:43:12 +0200
Subject: [PATCH 1/4] arm: dts: am43xx: Add missing board u-boot.dtsi files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v1-1-47e1c63d188c@baylibre.com>
References: <20260903-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v1-0-47e1c63d188c@baylibre.com>
In-Reply-To: <20260903-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v1-0-47e1c63d188c@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, "Andrew F. Davis" <afd@ti.com>, 
 Nikita Kiryanov <nikita@compulab.co.il>, Peng Fan <peng.fan@nxp.com>, 
 David Lechner <dlechner@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1353; i=msp@baylibre.com;
 h=from:subject:message-id; bh=bqp7eHMhNkEmF+dhazdBl+IDmLa7/r8ylqOTI7Ox64Y=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqyZleVOW4yLf9zd1SAjIl8yRbfqSEG7aL/cuh+9p0IUZ
 2Ws/8LXUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABPJYmVk6Fp8g+/J1Q28rkX5
 Js8ad7eq7Dv08+fpCw2lf4++uXT8YAMjw43FjTvcZx9YINrScm/udCZT+zkXK7pOTZZ2C8uxOxX
 KxwYA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

am437x-cm-t43 and am43x-epos-evm are currently missing a u-boot.dtsi
overlay file. Add these in preparation for OF_UPSTREAM to include
am4372-u-boot.dtsi.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 arch/arm/dts/am437x-cm-t43-u-boot.dtsi  | 21 +++++++++++++++++++++
 arch/arm/dts/am43x-epos-evm-u-boot.dtsi | 21 +++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/arch/arm/dts/am437x-cm-t43-u-boot.dtsi b/arch/arm/dts/am437x-cm-t43-u-boot.dtsi
new file mode 100644
index 000000000000..bb40317cb28c
--- /dev/null
+++ b/arch/arm/dts/am437x-cm-t43-u-boot.dtsi
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "am4372-u-boot.dtsi"
+
+/ {
+	ocp {
+		bootph-pre-ram;
+	};
+};
+
+&uart0 {
+	bootph-pre-ram;
+};
+
+&i2c0 {
+	bootph-pre-ram;
+};
+
+&mmc1 {
+	bootph-pre-ram;
+};
diff --git a/arch/arm/dts/am43x-epos-evm-u-boot.dtsi b/arch/arm/dts/am43x-epos-evm-u-boot.dtsi
new file mode 100644
index 000000000000..bb40317cb28c
--- /dev/null
+++ b/arch/arm/dts/am43x-epos-evm-u-boot.dtsi
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "am4372-u-boot.dtsi"
+
+/ {
+	ocp {
+		bootph-pre-ram;
+	};
+};
+
+&uart0 {
+	bootph-pre-ram;
+};
+
+&i2c0 {
+	bootph-pre-ram;
+};
+
+&mmc1 {
+	bootph-pre-ram;
+};

-- 
2.55.0

