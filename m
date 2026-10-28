Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2412E606A31D
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GS0T28sQ;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kZXrlH4j
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 83C5380F39;
	Wed, 28 Oct 2026 14:45:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U05K4UYTIB_r; Wed, 28 Oct 2026 14:45:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A9D7880F36
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198756;
	b=YZe22JT/VPkUClerBGKNBDLTHjd2FAn66BQFxboEX5jiaPy3buIyaYCxoKMk4KnzANpX
	 Aff7pn7GxWLYiQ9on2VnhC766r3RCGiTORpw5TY2hVLfxRySTds+fULoCCGqIBUx/bFHW
	 vkLTXOoI19U+nacW/JvgQ3bZ0xf7bS/rk1MoDE9LaVMHvP1Hy0OlfF3kPPftgT8ZnhLYu
	 QZwSVysx5FP1hHVPtYC/mhlnFjUC9zDRo1iBBQvmJ9Sjsi/4THRSoCnBnKI4K4a/rYt53
	 zMpmwfPAOBkQo52j/OM2TERTAkD1w7xtFWGTqYYK7hV6e3a1d8gxBrzcqevY6sfyKAQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198756;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+EVoh8XxOEFKgm1TTfgZtymBd7LymCMMMb5c9KyxQVE=;
	b=Gj7HD23PW269ePnMKFI5Mb5UapAEpWMZp28Gxyw/n6lKFAEattfaBrofZ2IV7bBmso6P
	 Yn3ud5PeT2hE03E0gmeMTdLpbkySshxEM5THuU6zieyAl2AP8euOrTlFSASvoGA0G5HEj
	 Daqkz8aCURfNqp+9TX3LcH7GVnvcLknguEaPkeWHBTH+k4fZMmBqnZIZjyWMUxy1V/gcs
	 qw1h1DvLyEbKlUbA74v8zQ/JkdEDsvuaFClrIA4SayfrxMFs1relUWNtK17z9E0NMa1l1
	 tAtjAh6tKSIIacQI9l+i2FvmqtAONiAQRidVfEoYcJW1DQlD7m+34bElA0/PESF5IPQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198756;
	bh=+EVoh8XxOEFKgm1TTfgZtymBd7LymCMMMb5c9KyxQVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GS0T28sQBRXYMmreGyY/eFbkSLmzu2Px1dvgQsytA0uHTCKfobmdfJ4WDgOmWpeoZ
	 PctPOBwch3hMIRGF+v8GoubKWTAcbJSUqySOMAGurhXTDqEWsxNZo4tw9b5p83EHqf
	 O8Xi/FhbKQl6Kd9dZxW+pVghxBqUrL0ZP62FQAPEwZ3+lBNj/BWDZeUCS+ut2Ci9tQ
	 uH7iMOkNRh4lkln+HhBp7MqeF/gnnU2T3NuPlDHW33xKcuZIWo2UKdg+9sgvO5oI/a
	 c8Vn7wqUeVBm6NlnOzXTj3Qk5X7Fi+UCIHf02Jx3SycxOnU4eGxRBHyo8vSEmStDEA
	 7z1kerW0qQWZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A9D7880F36;
	Wed, 28 Oct 2026 14:45:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D4359F8
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:09:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E79F5400D6
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:09:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0AoR63bUvrMj for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:09:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D18CA4008A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::52e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196593;
 b=maoymj+FIzm0JuO1NPJNAx6TXbMYtc7n/GsXZ6G1zO/BRZ+WW6A+Ogubq+WJuLi9BuWT
 CPsQyAebTzgsDGEahAKTmsrjdhL2VwDe1WZg/5wizadpWH9LpdWflR3xMkJRra+E0DW0e
 NvNH4MM1t3QLqYdp68coywjeqhVH8EYg3Hizr06/pKlaxv5mNWwRFXpMYKfAN4hDXzTFv
 FqHtxezhtFIesK3/ZS3bBGtHp+bGbsjM8LLx6eG7it6UCuO4AoVXrAXtDhI2n8eUKjxsC
 a6D9L0kDAsMK29pDXmtMYy7ZO2oUUCs1pHuBPvDAcxWHvhv0abWYWmxzwN0DAncPwzA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196593;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=+EVoh8XxOEFKgm1TTfgZtymBd7LymCMMMb5c9KyxQVE=;
 b=Gd7K1skfPG6kyNIwuFKqqMMGEh5IqL41QVWXDpnijU+AhSbQb+GcAOPpSIt+LjgVmETE
 gqchjfnUYm6bHeC5AgjB8Fx9e/kIvxt9EFppTHfdZtgJ138RZhE3ELwpRDw4QdgFCV/am
 aYTqzDzngoapYhp10V2SziPjAQ4DfW1hZtKh98tF5LY/u2I//YpOM+rTqLs91HcWwPxUO
 7K0yjbVMx2uWZcAk2U7b4Ugq700nEZJkJfAlcROE7DoeWYglrQFfUHgadEFSTZDIkEZD4
 s4e/S7glAnMgQRP95lC6uGZAZQEd48piKz2jOJLvMa++OQaCbPj84IOywVdboTlVgFA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=kZXrlH4j; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=kZXrlH4j
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D18CA4008A
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:09:52 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6acbdf8e70dso191496a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196590; x=1793801390;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+EVoh8XxOEFKgm1TTfgZtymBd7LymCMMMb5c9KyxQVE=;
 b=kZXrlH4jhTvfyBXNDaMOiuv05nneMVkY7ogGTuT7zly+mifayX5xNM7Pm4AukEWNs0
 mdzAN+FFoCGYk7WInEUuUJ9QqmGjqKLoOVzJ4heBQC7k7UGTQJZ044h3vKi7sDTeiEow
 X9wPUNJNTgXy570GRBa2q7nMlbCHZvYQTaZv/SiZesGIzujtKCaSdflYTIlMBkshQkZt
 kTjd3ZzwR0uXsVnYT10tGF3xKjjDsSPnLVhbACBrwnPwvQrDcx/BwDrVOGN16saaWRJm
 hOXCsURk/IJYD9FcoCzZ6Tuye+50S2a7F3YUu+vOTnfIy+6tO4r5FJQ5c1OGLtHkfaAO
 gXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196590; x=1793801390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+EVoh8XxOEFKgm1TTfgZtymBd7LymCMMMb5c9KyxQVE=;
 b=bZMmQyoWZJNOqTCwcOg1tCXxy56AtIB+guhacgGMAjbVagB6aZ/sKRrjx+eMXyydUy
 TG6xCM6ocsUJnsBMzXz2gcAY+jKSYrUHtsGzazMPdoXa5J6kb1yi2vKINBfLvO31qAUc
 AcfF5KgpdsDn0IDVtAL9DfxIpgqSPwN2RzDLwuj+Vzu8arvx5E3/vvWjZKw7qRIf6t2L
 aG/SMAcjJUjrkRjMxmxlhxr2GBBPQ5P02zxBbZVY98v/2Be4n2/vxkccyTKHUH046vcO
 2K93oibT+c/t48wCnl0LHSd2Z6wUNYjgzjjmVQqhCX4I/JNOqrHeVZUB3QbNSyDGsOYi
 k1Tw==
X-Gm-Message-State: AFq9FYL5t4ODwg4q8dVKkIOZXr9UZtLbytMPW/JjS/yENhzcd9zR1kp9
 m9/Ue65rtYdS+rqXjYnX/vrtv+758+aVUp+zI7JFg5TepsaJBGbCei5nGrTA+XB0KK6xufiXQ52
 xI3Fd
X-Gm-Gg: AYBFou050hElBBq9lpyuAGQFF9hoKlUfkpWPh4jESY9jpkmwMv/iHYnKWNn1PDQjpTD
 n/6hWxa4Ms5drBhSHGmVKTkWMW35sC/v5gTq+nYQd8BMeRLB4ACfrngR4uBxgTV2jnHdDkMsGED
 J6I5EoDTwrqAaHfgke18uaVmRV1y8Zh8cfekhofuoIA/w0E0zewAyiU4bhGoTKOc1pFYy6CylgH
 sC+XcYtG3+QukiZ3OOsv24BDy99iBmkcLZZRYkHFSYhQFCy/2VwKh5FxPdqMJ5ORACLRXz83cp1
 1mMfoO+P9PpHf1EmJYjBfqDYURYjLmURYyPFN8FfmO0elkI+q39XMreXyrERrLgP2GLZpMRb/RR
 d1/aUADWD80I0LwvxnhR9E/v9LaiTHebTLh8lY9yboEzmK/F+YllK2CWkFUwgGMUO80Azol1v/q
 QmFo1cb+nJhUvgu4tykFopA75A/54xgEGeXTKLW08QxRv8qRA3O7V8knjqGyc4YEBd/6nhV0QWA
 eksPZcWNUWnugL9rUj/PVX50XpGsmNK8m/KSax1i0Hi0q8em2ptiRe4moEnIDmevPDi5uIZOu+v
 +fzWVigTrAbWzciuZOCf87XlklC2yJKai8iOEsj+Z0haF0nY4ivMLwVGCrJKK+mrHCdcxvM5rjz
 rwYk80VZ6dA==
X-Received: by 2002:a17:906:d932:b0:c43:f1ab:167c with SMTP id
 a640c23a62f3a-c49bdd9ab19mr227721466b.1.1793196590269; 
 Wed, 28 Oct 2026 07:09:50 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd790afasm607807266b.68.2026.10.28.07.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:09:49 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 03/63] usb: dwc3: import from kernel v3.19
Date: Wed, 28 Oct 2026 15:08:29 +0100
Message-ID: <20261028140930.3025368-4-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028140930.3025368-1-anders.roxell@linaro.org>
References: <20261028140930.3025368-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 14:45:46 +0000
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

From: Jens Wiklander <jens.wiklander@linaro.org>

Sync Linux kernel dwc3 changes from v3.19-rc1 to v3.19.

The following files are preserved across the import:
Makefile Kconfig dwc3-meson-g12a.c dwc3-meson-gxl.c dwc3-omap.c
dwc3-uniphier.c dwc3-generic.h dwc3-generic.c dwc3-generic-sti.c
dwc3-layerscape.c ti_usb_phy.c

Skipping unused files:
debugfs.c drd.c dwc3-exynos.c dwc3-haps.c dwc3-imx8mp.c dwc3-keystone.c
dwc3-octeon.c dwc3-of-simple.c dwc3-pci.c dwc3-qcom.c dwc3-qcom-legacy.c
dwc3-rtk.c dwc3-st.c dwc3-xilinx.c host.c trace.c trace.h ulpi.c

Note that this is a raw import and doesn't build.
A fixup commit at the end of the series fixes that.

List of commits: git log --oneline v3.19-rc1..v3.19
Commits imported:
39e60635a015 usb: dwc3: gadget: Stop TRB preparation after limit is reached
ec512fb8e561 usb: dwc3: gadget: Fix TRB preparation during SG

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/gadget.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index f03b136ecfce..8f65ab3a3b92 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -882,8 +882,7 @@ static void dwc3_prepare_trbs(struct dwc3_ep *dep, bool starting)
 
 				if (i == (request->num_mapped_sgs - 1) ||
 						sg_is_last(s)) {
-					if (list_is_last(&req->list,
-							&dep->request_list))
+					if (list_empty(&dep->request_list))
 						last_one = true;
 					chain = false;
 				}
@@ -901,6 +900,9 @@ static void dwc3_prepare_trbs(struct dwc3_ep *dep, bool starting)
 				if (last_one)
 					break;
 			}
+
+			if (last_one)
+				break;
 		} else {
 			dma = req->request.dma;
 			length = req->request.length;
-- 
2.53.0

