Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64923CC6B38
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 20:16:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 361574089E;
	Thu, 15 Oct 2026 20:16:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 12LURaErZ8Ui; Thu, 15 Oct 2026 20:16:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 73DE1408BE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792095377;
	b=lcoig1tTzKyXCyRl8LyCSTwrVMpeR57jI2vsPEt/Cn/MfN9FcA2OXIEg/nr3vnKHXkuE
	 5FmiSRQZk1zC7eGAmwYM2c3M1j7B2ICPT4eSdzv6z/PLH6bHLRjYbGwyO3cP8ABd6M86/
	 QkqX+OEAaBmyrik/oEIIHIySWBWQpGg5kltE+HtaNI6hT4EckSHdPXoou3m6WGW40pEba
	 uI2I+8upcAdI5PSSXTQLNlUbwSFOIEVm4PGERKlJSlxDdHgI6+HC/ElDaSDCqGhSupgqM
	 rCNY+iMdcF+fcztJf2QO47I+kc/LumgZfZs/gk0tzNqEHPyQ/CQIr45fO2uMqoiwmAQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792095377;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UxTZHlb0FZD0LQhBs/tSad3BmJnPewJFLi6g0V+rERc=;
	b=cd539DPJT5qU+iSKvIIMhTInaaiBNZI6Pmp1tGgPn1NpltznEfX9oqNHOb/qrcHYnopz
	 mF28Q7nSwbcXm/yQiD3dNwokgtIGWTRtdUV3FEeN6tCc1CThS3OuPcL1qr9CahsHXASNV
	 /QT/DS8Kd/MZtbM9oXpvGOi1DER/q4DfduRM45EKeyjGI4deSQ+7Zn2kdXTIs0+oMMztK
	 z9gW/KasA1nuBOMyoKXfTYL3Sq81GNNwEFbuXl8WQ5msWQM34Zz6uU1XPfEzLR/7d+TS/
	 CBnUKWtfmyNxQ0Ns0nS0v8piTn5/gTcUoayk5EFTbpe+PioF9BXkzX52P9OkmmV9xNw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792095377;
	bh=UxTZHlb0FZD0LQhBs/tSad3BmJnPewJFLi6g0V+rERc=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=EL2jOHb47WiUU2uemHXEa+Wj8H3w35zVmOO0K3pOv8vnaViNBHQ8pak/5t7FtO3q0
	 Nx1lOy5Bnk/7E2LmkPTC9eIuWnHGRmSn2TPVpkGKnp/3RP7GyH9ugqKHnB0QG5WC2C
	 WJUbkSpwaxRj3kBQhg20DTk4lBt/xOvVhXFo/hpNBbN+tU0sD/ZHqsUSKRwzpZ1FCb
	 pwGLbT2eLaO3dBWZTXqQEcKS9r5ibtYkmREUKL+SJ/u0qy2yxxYW1Sg5OksAxx6rd4
	 QFjwuSPyZCAd9XjKdWbgx//dM76bEhQbZd2RskCF1es06wlFrlyrD8wZa67niBDTak
	 UzgIa7qOeycTg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 73DE1408BE;
	Thu, 15 Oct 2026 20:16:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D622228C
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 19:58:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C8BF3811F1
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 19:58:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 25z41CLYv9xj for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 19:58:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 86995810F8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792094285;
 b=apGSAv5dSAw38JzIgi4cvPwJlRtgX0JD6TXWFDgyBLsBOw1O0wgYjPB8Ceod7YHRt7YJ
 Noggx87o5A/e1bLs4QjafDomqExNaKB+18gW1WSIhWqWdEWEhimvsHPMao9ZRXbVe9IXr
 5lYcl7No+bwmE2ZCM43QCSCuQCs6MyfM6uKprWeBADsDBgQCu8R0bMw1ZablUsaRQwMMk
 r0xdUUKoggfZfAkMvnUBl6suIao81I/e6NsIr1k6EiQuDAwLebgIVPycPSmoB9KteN4en
 noGczP4tEHfoP0EFYWQA7cMq6stauEUR3m39DEEpVyFuouf+AsarTX9+9fBiQI3DVgg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792094285;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=UxTZHlb0FZD0LQhBs/tSad3BmJnPewJFLi6g0V+rERc=;
 b=Ptuj3ym75daO6sl771LpfT8gLf2kCam3C6Cpm8KJCfFViVQxQj7u1B+psgYMhr0CBoyq
 6iodijGyWDY+lrJiV+YUcc6zUYSCPHKlMjny9ocPMsweDogkIkwLFDuiBxWn40dJsXzVQ
 Zxt+qPNZdLYtzPbnW4QXrqhjp9tsJvScdXhXsgA05Sqw/dERSs9dVHdBPLBU1uXMuaeVO
 A2hRAYKOyb8ygWR1z4JUzmWJKQH27Cr1TTgyOcrw7LKc6y8/6WMp8slOnqU/vZnSrd0tz
 LZyoj0ZFTHb7zqGaSUQiWgvygk9GviVZjkrwOlyMWH36eRtSe/NqUQzTNO9WhPx8kZw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=9elements.com;
 dkim=pass header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256
 header.s=google header.b=Pt5VycGS; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=tan.siewert@9elements.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=9elements.com header.i=@9elements.com
 header.a=rsa-sha256 header.s=google header.b=Pt5VycGS
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 86995810F8
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 19:58:04 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48c45111bebso3642296f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 12:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1792094282; x=1792699082;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UxTZHlb0FZD0LQhBs/tSad3BmJnPewJFLi6g0V+rERc=;
 b=Pt5VycGSdgBHCT1EuhARyyRTM0mboJjgD48Y4hKa5cTutwkcEkAOVXyx0jNKI2p/P8
 4Y48rEjGIQQUMvgZ5dHtRPEOK6a4DzWOCCVD+42sC4o8mliCTHtZ0P6anSChAkZSigAH
 LMu6pa4QWrpuUe/Aj8d4BTCPLhc7ZgvrZISqkG5PIrzebCpNkM4wAAJaXAeeO7JjLA+4
 7bWmVuklnSFCYIDeFvNt2jrrbTbbvUTtvCdrl/4Le1yUtJrH28YQorZzaLVA6U0iJvyD
 5wEyDpeChstCTX2L7yg9aZHaBpv0hJ+8c5hv25IyEBJ8CtyEl+brzEgy+0tsQbpvCqV8
 K0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792094282; x=1792699082;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UxTZHlb0FZD0LQhBs/tSad3BmJnPewJFLi6g0V+rERc=;
 b=pxaZUfBvpXj6NxsUX7rOczwBNH5SDRaHw8B7+ojsSMXr0T4idyldpKOgz7s5iScNsg
 XM1P+Ma2wtZcfJJPAjuObykJ24GVfwETljiiUTiLm+QlVpHnfV3nK6zH73mqwkm/jHPL
 wz644Cr5BNQgJYjRPzYKpv+JiafFbMb4Zt3/xB/s+hrsVTzISzU7qPh0CkbZNj3G/AFG
 BQVFcJKVTYRhd3fIXa+QoFyDjg/9wFGMYhljcuqMpmck5nLmjjLyL7RmViQoFgYlfoZl
 LWxDn1EkQg/Vw+XUYDoLjKN3YiFpdFjoVeAm2ThoqaOiZ36rZBYAaH4x71h3vqSSfM0n
 GJng==
X-Gm-Message-State: AFq9FYI/HOn/U6XkQa3IVo3AbtjqypiAbb1ml7aDLzTjo2tr7uZV4MRS
 s4ksKHKnMNQ4KLZqHVZXE3Hl/Ax3LzfXS+iFseB4/Fdg7W94zoUAkynS8jFXKBXTc2Y=
X-Gm-Gg: AYBFou3VwTfKPXTmqqMssi+gvuBySjQcN/2qprxeOtJ3mf+XEFSkflO/cHf2ROU63NU
 0/TAWieYlp/aS/3NgK/VB2dG2lBp4AGqG21F9ZKi8jfNN1/GJSW11L5bFHoLNnrL4jNef93Twsv
 iv8ii9mKsqMOTYO4KuSTzOSbHST22zUd6tOjPyOjsCAwZ1WcQk3FSALPyBXnnzkA/ajzqIrm3QW
 8oJPM8YdsusMrqNTbj73S0yAnGzxwuE0TIUYbCqjMgasGjIX9ePMdXOg+BYgQh1XkfDPzO02LjD
 2ImOofS2532zM5R9ZJ3EQPUcDHFzkHU3aNktSQDPdQEGmqgLSQGh0Gf75Epf6RIoYZrrHLOIdot
 PsNm3X1VNj6xoq2i3rVfrnaFNAydCpwFvX1WdWvSK6qRwXRnAWQeJ/W/27fA0F3LwZe3xQKQpwJ
 epIUWiuhOQzlsYwQzZTV+omEWUjCAf/Dm/b7g7AZvHriIoB+nFY/vog1ZnzgGaz54L3uawfuksy
 FgUwcDbkJWnLdc=
X-Received: by 2002:a05:6000:298d:20b0:48c:43e1:a332 with SMTP id
 ffacd0b85a97d-48dba7828c9mr31022242f8f.7.1792094282220; 
 Thu, 15 Oct 2026 12:58:02 -0700 (PDT)
Received: from white-mocha.local ([2001:9e8:2f4:b401:e5a6:e075:4922:88e8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4ecac3sm189824f8f.27.2026.10.15.12.58.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 12:58:01 -0700 (PDT)
From: Tan Siewert <tan.siewert@9elements.com>
Date: Thu, 15 Oct 2026 21:57:42 +0200
Subject: [PATCH] board: hpe: gxp: expose server id via device tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-gxp-pca-id-v1-1-11857901aad9@9elements.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqAIBCF4avIrBPMQLCrRAudppoWJloRRHfPa
 vk9eP8FmRJThlZckOjgzGsoqCsBOLswkeShGLTSRlndyOmMMqIrs7SDt2Qag6gslENMNPL5xbr
 +d979Qri9BbjvB8e09vJuAAAA
X-Change-ID: 20260923-gxp-pca-id-9db9e636cc09
To: u-boot@lists.u-boot-project.org
Cc: Jean-Marie Verdun <verdun@hpe.com>, Nick Hawkins <nick.hawkins@hpe.com>, 
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>, 
 Michal Gorlas <michal.gorlas@9elements.com>, Tom Rini <trini@konsulko.com>, 
 Tan Siewert <tan.siewert@9elements.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792094271; l=1031;
 i=tan.siewert@9elements.com; s=20260527; h=from:subject:message-id;
 bh=TAIdXrFDhuW7FigG/9FLkg9yaUB6qnvSCYnMUtK/OiM=;
 b=KO5keSMiOgV/vvkedE69NDp3PhJ2UHtQNF2jwA/Hm1O3QlGTRzJORtcyyjGx9bRgDFbT33AOj
 AfitSkFw+goAJUwTbajNZGZS2fEK8HSjFIop5w+rBs70U4XMUtSzSeU
X-Developer-Key: i=tan.siewert@9elements.com; a=ed25519;
 pk=ORQd/zQf+LsAvJGXP1CjQwVO6t6iEOGq/eGUsmRVTG4=
X-Mailman-Approved-At: Thu, 15 Oct 2026 20:16:13 +0000
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

Some HPE-specific applications require the server id which is only
available via a register read.
Although it is a u16, the device tree spec only allows either u32 or
u64, thus expose it as u32.

Signed-off-by: Tan Siewert <tan.siewert@9elements.com>
---
 board/hpe/gxp/gxp_board.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/board/hpe/gxp/gxp_board.c b/board/hpe/gxp/gxp_board.c
index 032554649b2..b7c9499eac3 100644
--- a/board/hpe/gxp/gxp_board.c
+++ b/board/hpe/gxp/gxp_board.c
@@ -92,6 +92,11 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	char str[64];
 	int ret;
 
+	ret = fdt_setprop_u32(blob, 0, "hpe,server-id", gxp_get_server_id());
+	if (ret < 0)
+		printf("WARNING: could not set server id property: %s\n",
+		       fdt_strerror(ret));
+
 	ret = sysinfo_get(&dev);
 	if (ret)
 		goto skip_sysinfo;

---
base-commit: 8d7bc8add17bbc69a58dfe0002eea039dd2dc1bc
change-id: 20260923-gxp-pca-id-9db9e636cc09

Best regards,
--  
Tan Siewert <tan.siewert@9elements.com>

