Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1C8C98328
	for <u-boot@archiver.kernel.org>; Sat, 26 Sep 2026 08:44:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AE1ED8132C;
	Sat, 26 Sep 2026 08:44:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mwIV4VtTMFnp; Sat, 26 Sep 2026 08:44:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E9BF98132B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790412280;
	b=INXyyZ+RcYFx508zVHBt9V28eKDRU97g/O0KpnFshcQ52zemtxbcPhpKTnXvM563XyJc
	 h/nS8p+nnJYHbzc9FSWCOphRp16RvcB6TsQf7MMSxhM8nNhVe0hzuXkOOKFsQeLJevU4Q
	 cOq5oY1BGxmFn5MJ0dQ4WpHGWE6cefF8k7fFGhF0HG1egzLDzs+5tpzXC7VnU/h5T+gsN
	 OyIWOXBtnYNPC+RRDlJ/sFYMR/5uAaBwLObuTkuUo3ieQEQHaZajSe0JiCIeSuHbVhNvp
	 GqHd4CFRg62QhwQ+sIsAPkgrzP/bl6lqJxaQdHEVYF7t2GgiB3mdooTABxBXopgxATw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790412280;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zw015BnOH41/Q4G50EocZYMOvo+tTwjD3NQceTH1yUk=;
	b=p4v7ZQP7V6O+7qjP+WLfsWSpWMTY+xdUm1H1uoLve1N6P/PUODx00J5JKEBQK4SZv97z
	 gwjSPdPIBGZ2jpDsPYLitQ+MgoRjEQGEE7IPZ3AqLboIOQX5o8RLXm9vfYq/EswknATeN
	 XwhN8q7EGSi6fHq0c8pqsCGD88FsBmlPAUyNGT+gsDkRfqZsiGBU53SNll9zMIlvRi4IC
	 LG4ckBmvJjgPutXgc2p+l+2ZrpdriclGCrpkDOiBmcYPPd1GJxf5+kglFuCmAYVp5BDie
	 l05+wEoOFzOjMN5WunNOJAwkBF3yGqnFZL8zkUaqY3Do/D8z17GsbILpj58L82ifmfg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790412280;
	bh=zw015BnOH41/Q4G50EocZYMOvo+tTwjD3NQceTH1yUk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sgihRqhHJ//1zGNbrpu4PXSbFAD1bkcSm9xTCRRuxNXTfeJssIMun7I4fZxxXu1k6
	 uo20a7JWCy9FgOAkaJyoaj/rv23ux41vhlaDd8sAu24cfLEkDGHBwz/wvnBStZT6P+
	 vwWq3+17ZFN1oZ1SXSFCZT+/MRgBdwoIjZVTZmaLmQVY+1DXdyripDs+0x9uU2jtPS
	 aR+i1M0cJSBygUWpXnoCDkB96kR09z5hNJ+U1YQOP2llyak72wPH9P1jXuWHjxlWuc
	 sYHQxOAUkVS4Cl42E1yglK7SLTLUovCGhzkq9nxAZncLoAuzm6mX1qT/kf01HuqLnt
	 7cr6pOfN8inLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E9BF98132B;
	Sat, 26 Sep 2026 08:44:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C199772
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 00:59:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A7488404C8
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 00:59:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ql1BH3wguTVG for <u-boot@lists.u-boot-project.org>;
 Sat, 26 Sep 2026 00:59:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org CCC394016B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790384379;
 b=VOrquaT4ahAucOaIO1yBBej+Ue7ftsLFv0cCRtaI794Vpp5ozWejS+8ce11j6Y3aDbW9
 ev4Xc95hMmCofQu1BxPRZqomAze7q4fPFhofX4LP67tDAW3HcKVCVKw7LsYLtojCQBFWM
 uECYez38zE3mgVDYaDw8IIxS0wCeKWNKSE3u2lDyF+isMVDdekU3tBatIodAytPUMHTii
 nZJyZjq2VEpe6qu7jC5AefnRjvkO6IRET09uOcqDdzxLvKKUSlztHq9ZcQTrvReZn0Z9Z
 fpHtvDOVTCaXNwejvTWmT1s0FS/yV8ln5r2Y6p8ByDb32RMqvLIBhU/fPqEkO6TQEVw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790384379;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=zw015BnOH41/Q4G50EocZYMOvo+tTwjD3NQceTH1yUk=;
 b=DncfB2gS3zQ13Vj0xHGzILiZ7Dac5qEBVkuSBTxFcBN5jJHVJxXykmq4RaY7J0Mxxxkx
 cek+LyIVUdUDq49QzZEoZ36O5+B4lsCTgt3ykT5GaUw0lc5A7IHH5gPf3a1sf7rqFfcsW
 moc9jTvdCm8mlZ9E1Lx2HdhNagzKrecEmPCfRD4pmEdJ5vtjpLhQGACtaxyEqHMIvaj8s
 vN6bXNLtCRvjTVtbxANrFzhe7m9cOmJ5RqKiusbLUTt1Xo7AhqqDgSYdXXvP0ZQOsvUFz
 aGvd1sYh6TV6mT0Jj97p2klbW9C+bnHF4gzWwCuSJR+6iqKu0XjGBxSYReDwpaAjflA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="hayFBT/R"; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=m.legenovic@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=hayFBT/R
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CCC394016B
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 00:59:38 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ff23af865so9930375e9.2
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 17:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790384376; x=1790989176;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zw015BnOH41/Q4G50EocZYMOvo+tTwjD3NQceTH1yUk=;
 b=hayFBT/RQg65Id3ZXabxhs/7yZKy+fRfha+HojIa14u78MUIuR4O9loar8owTh6JN9
 cTf/w5yw6YDNtSNJPVn/wzrqU3tRtOsOI0mZggmA5RQvaRNOHYg7pcsvrfKYvgrMCIwD
 e5OMpZiEi1d9ajZ5XFSPL8+EYpBKRLBTmjS9t+TqXU7xvwtOFybEJVG7X1/kyO3955qi
 jwTK4mQx9WhW3lIefxkDru2jT4r2hQ8KewowZA7jehJuwR8yYDRRv2m6HTmUyB6/JiN5
 T1K+AwNAABbqvOnEs1lTO+Xudjqr7IP/3o3gepD6arRXHmpqrILNGVG3xjFFrO+lbzgL
 6wOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790384376; x=1790989176;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zw015BnOH41/Q4G50EocZYMOvo+tTwjD3NQceTH1yUk=;
 b=v0ySc55QMOuwQTiMCmrGqNY3TJw9V3YOmvwMQzj4Fz1d6BOSdhgyIPEz4zngtPZsai
 p9uYBFgbnRrdiwQqGk8lWiMCklBiwJKiNz+svM5b3pLlut+w/UmwMOzH0CrdRdkCn1rQ
 3tI78w+nBD3uUHdbxECXHuVwog9f8kYSncAIU3LlOnCgx71QFxtIUsHWX4n70B+6+Y+h
 WtRjlFYxXiroIipuT03EshfnAEdQRL+TaMMf+5Kr4oUgrrOH9TyY0siHmVuhvzctegYI
 5ORTXyJyWIP+bBP0ww/nzCskSFIXfv1gDqi378gs8YF8YWTyBRUM6slJCQAV5eZQ8Y9y
 5iSw==
X-Gm-Message-State: AFuF++llOX/7nmF/I3zrksMT4BfmwhPeo+fhgq3ZG/pvKELwFrGERPhv
 hMFi0rHLloiyUcOB+Nxdc1aRu+QJ1vRlfIg7ynbCLvBgn+9TSBOVZQCp/BfQId8r
X-Gm-Gg: AYBFou1rsY8VEbZn+HgybE/D1kzMUKfzbSMKhhR7RYEGLoKlSglnMgJMkZPJRYeWb6N
 y2xT83/gpyK+DQgXFJT8wCnygxlGHgk7IKgEYF8xjaHrvqdzTjPFEltW1ER+zMGbGv7xtrk42Zw
 vqFDiWymmO1znn2Aro8kknL0nOBoteCEXZMH46JAEw/4jgIWgLEzZ1Im8/ScKR3B8WfHJy7va9f
 QyVl5t26ZKpJDrykAl67oM8H4Of98xFJ+SdQDWzSm+quCwBGAnoxcKpJB6ofxbNshvpL+nsWDnK
 FidyKNbSut7NH77JwuUz4dG5FmC/SGiVUWQAB8hLC6qMpWTQIypdbGINYak8oGHPxBYUtr2R5Jk
 52mf0qZQNeeKSI99gnMKkRjvbKYES7f62dQO/WycFiHw2bg8k5NO+KccnulVxPFWcKbYmPF0hDA
 fEBlzX7cArfmyzAAmICJ7Cr15KKFtWDdSPgrZ0p+GSRTbzIYeush7bm1IQPOTAb6BQLfGu52HaU
 LJ9khv48VIcuvHqvg+XXNbb55iZ++Gme2y8CjdVzk+HbY25hD2RdXU=
X-Received: by 2002:a05:600c:4ec8:b0:49f:dd10:3c71 with SMTP id
 5b1f17b1804b1-49fe66c61c4mr132388075e9.11.1790384376004; 
 Fri, 25 Sep 2026 17:59:36 -0700 (PDT)
Received: from armbian.default (46.217.76.83.dynamic.cust.swisscom.net.
 [83.76.217.46]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5de187asm182364865e9.7.2026.09.25.17.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 17:59:34 -0700 (PDT)
From: Milivoje Legenovic <m.legenovic@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Milivoje Legenovic <m.legenovic@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <u-boot@0leil.net>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] Disable SMBIOS table creation for Odroid M2
Date: Sat, 26 Sep 2026 02:58:52 +0200
Message-ID: <20260926005853.1727-1-m.legenovic@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 26 Sep 2026 08:44:30 +0000
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

After upgrading u-boot in Armbian for the Odroid M2 board from
version v2025.10 to a higher version (it doesn’t matter which one),
the board does boot, but the boot process halts for 60 seconds,
and only continues once this time has elapsed. Debugging via a
UART cable showed that u-boot hands control over to the kernel,
and then freezes there. The only difference compared to v2025.10
was the SMBIOS table. After disabling this configuration option
everything worked perfectly.

Signed-off-by: Milivoje Legenovic <m.legenovic@gmail.com>
---
 configs/odroid-m2-rk3588s_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/odroid-m2-rk3588s_defconfig b/configs/odroid-m2-rk3588s_defconfig
index e71e61ddb0b..fc8adc7d047 100644
--- a/configs/odroid-m2-rk3588s_defconfig
+++ b/configs/odroid-m2-rk3588s_defconfig
@@ -79,6 +79,7 @@ CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_ROCKCHIP_SPI=y
 CONFIG_SYSRESET=y
+# CONFIG_GENERATE_SMBIOS_TABLE is not set
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_EHCI_HCD=y
-- 
2.47.3

