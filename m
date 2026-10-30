Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9E8606A323
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 12:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XRTcG5Em;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VwwElt3D
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D1BF460634;
	Fri, 30 Oct 2026 12:59:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xdxbbb1uc50i; Fri, 30 Oct 2026 12:59:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1DEBD60668
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793365183;
	b=rIUmupHoC3wOq0+sS+Rs6Ufaajd0NQaWCNAHFGjwnQF4lfJKKMqD9l+9Cm1RROsldyxM
	 rYLaWhj6rQ+ElulGKn1FTOkKtrBjno1/UDyEJ7kC0jWz4El7R5usXFLbin2tIkZDZPsJW
	 PQrfIZjhIE6KTOqUb4pnPs4KnC2lCYaWozNHBk/7tpZ8mu8Rkm7PifONfYCML6egU8N4l
	 FTq4zWbeuoc7lqp9AmbBAFcXcEh23erQf1rm4m3xGqJ+ia3U7tf2hcVoBwqwvnr+ioScI
	 gLnZUeD/wWhwpM9PHdOz6RwsfoOkUcQXtCaAO+pK9FftoV0RabFp6dIAHWGY6mawJrA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793365183;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=mEPnWQQR51+8jPv/dirFnvOz42yg2m1zNCSu/aGmVLA=;
	b=dRSGFZm5kLmC2UYY7YLMH0YYvFqlzYn+tXCXzWqXUUauXXEEShM31vIX3R+Rg5yWLy3K
	 7AI7qAh/ZCJHu3bldR0EGZY25RILkqGbsqDWEgAeMxOjGuNe4PxPDMQVxWpt+0Xsunau+
	 ry+mZRf7DTT7bI8QFf9RdQu5YrOBKT/nHRTnvS2LQZdGDME9s1buvL6f6M3YMJ0lBCqPK
	 uTjAlOs7E03zZZhK7bLaIX2hTNdS1npzWej8agt6+w343hnKkHj2syuZT+NcpGPs3XbKj
	 U6tCYyuxv/YwgrqQs4GezgTrtrtyQtt/9bcNDj/4kLXjelt2zR0ZA5CvxAlvFCmVs1w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793365183;
	bh=mEPnWQQR51+8jPv/dirFnvOz42yg2m1zNCSu/aGmVLA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XRTcG5EmAEGCLLAGBqHFXEhYvT9/tdnCZ55t1ZLp+Sxbqxi2aIk5n1uwsQbiFg1Vy
	 Q0WXarmZZu1ZpoNX+cGiUkZTEgjmZo4Mp+tIBCX/yKiQqgu3jAFPq2ky4yIVCxko31
	 ALobfJCl0RrO+wX5bhyujpUQy6T1NBiiTji8sexDUx6dz7wVu70cPAvWPgqvqCongl
	 7iXlK+V8kCmv8RoEx3Vv01bWDsaQflWtCJdJDUuCm8J/2BjwM5oMpBgvFtfaDPliwQ
	 69D/pvKHsTb8bCsSFyz0CDkXZk7QGwUSt5qx+r5k7Qwgr15SX3GIiG5RuYhz4q5fcb
	 MCSuOIz1s2oKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1DEBD60668;
	Fri, 30 Oct 2026 12:59:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 442BF3AF
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:37:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 29B93810C5
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:37:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m780-jiQ7sxn for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 07:37:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3B125810B5
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793345827;
 b=dSXtAbWp9lKTRgY1zuKA5+4eqA80Q3R5xUDSYCKetuJvRlcndFdYa6MAlOziDMo+CSJO
 jLE9ZdupyShhqRLAvigYs9cu3c85ZemYD2mW4M2cwV+FemI3Y+ukyxt61/A6zhjOZ9RyN
 G597vW3/z9CKZOHgQhvCe8EKGQhrhJTl5HMW81n36Rvw7kXx/1ytdxayqJum9Hy01bioo
 2tXqL+eHt5QYJ+H80hMoQM6rLwMAe3nWDX0f/20CKgfypMse+b/GUp/nBQa9I5zB/q+fd
 /5szsjPx76TNtfBUxmavCt2ED0HuwOYwDzH8pj3XF/peJtEEpOMy8Cmz/zG+IyiJL7w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793345827;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=mEPnWQQR51+8jPv/dirFnvOz42yg2m1zNCSu/aGmVLA=;
 b=SX7ahfrh/DaImYjPVL8bbUM+OjtEJzQzQJHofr+TTvyGiwUFTlsqHbsgAvxahMOp6hi7
 v/sE4g2oOH+v76fQEv0XF4MgkyPUFG61QDImXshvmZYns4aczeY4oDUHv2Eagwz3MJTNy
 iOKpLfNzahyaYBjFJJ5dilN+6cy5hSSc1Tmc2MbRjhbWT6PAmLuXvpFEHWqsnqWsHGjy/
 hHb0iOaQ4MvAgO5kBHpNyrGxYwlg2CxqbMrwX+zWNtV51YJmFdjuatgHN46bwzB+DypP1
 nhQufoozuvnzI4yYLuqSlVLLnu7y2fUL9m+6lyrER5puAPXmN3bKnr5oI34G5hIcH0Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=VwwElt3D; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=ylcncn@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=VwwElt3D
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3B125810B5
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:37:06 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48e0d1da913so271494f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 00:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793345825; x=1793950625;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mEPnWQQR51+8jPv/dirFnvOz42yg2m1zNCSu/aGmVLA=;
 b=VwwElt3D3jRxE3l7PBbhS7jpp7ieFfN+piH9mwm3RBj38vBydibTAlxMunjw4ufU9N
 dXseRN8N6a8tJi30jPMzE29ai0rZZHVeVdG9QdBkVq6y2GkEHsLkhFm+8ESiDx0UI5SR
 lPt0lV2vSLK6G7KG5pCpTDxRIuaKhMoD4uGxSZqpdQFAoIzBCHtOm6eyXFBzsy1LuhnA
 lvc5Yu2x08SVz9prb8YkbYv6Cbllih2/gX63A9s38QrXv22akoGRXvVP9cSyvl4L/w7g
 ChyDVM4EuW3m11sZq6pgSlmQSYWjKcXIz+IBgyUvT2ShyjjyB7GYzm00vOOQW0N6OV7H
 dUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793345825; x=1793950625;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mEPnWQQR51+8jPv/dirFnvOz42yg2m1zNCSu/aGmVLA=;
 b=zRldrrHtIZX1IAPa7/ihuplLUD+zBbCMieLXQ1iO8FGVjR/0GgPXtNLY8xItG7s09h
 bC/CiGKdw6ccgFuzMgnYSns0+RF6UatEdQbFsRQopB4Q1CYwAZs7z7ezdaOIjTV6Zmtz
 MY5byJ6YvHvmz/9HCpLKRf/AW5kbW2u/54beT5UCQqk3H+xyg+I8eiNfdWlCa4ZOyv4j
 +Y3xJngxTD5jlfZ+WQyHlOJBuUssidV3jQnlF6S1VzFtA6Jn3MsoqDcb3g3RJxtDhvve
 Q/zwCyK+ONSxk6tO3pzr2rkkho8QolaR9EUy5SbVCm6mcCUk+nF/gN3EmaLser20ocaa
 L3CQ==
X-Gm-Message-State: AFq9FYL6SmThl3ugpo2LdpDo6KKNJ8jtX9KdTu2NoOgMbtd1dzdkEpWL
 jGPdE4JRBL54PxgBPC+dk/SawdrZ9mEddh8L4vnfA7yVmiJnRRag23DUjYK5T5OszrA=
X-Gm-Gg: AYBFou2jmy3X0dxY30AwQgw/Vg8toZFKYVMuO/FPy0RXVbC8qsevOKmGD2ga/rrbAvt
 6xPXkI8y0mE0l4ci8NG0XaZcOLFSdLuyshxlnk+tVNH2ecsnrCE4L8CVzx3hUxmc2Z4uGVDbslM
 QoFSNDKJDmW/xKgy3UHD2PhxbG1MfZ2oZZSzYDl5scpSusUInIl3wc8QiftmqPTWYNH/9t5Rvzo
 r2fzRrsgEQtXp4Ji79U7NN5PCdKIPK2gt+SZ0Il2z9tpoe3YbEt8jHb0ZPwa1uddfZ1eIIFmLIt
 aElN+cMeGXj+ZX2kKpXFNINt2Bt5v2SEEK4CYoPRiTW29hH4GPcH85F/Nqbgd/GZ0YAMzjVAkp7
 e1o7BnTZvWyEAPuufsm2d9x8TsZj6tYCeeCFbeOZXOmFHR62p+4poRIdpSfajo/QIIApK6FaISy
 BI1JE0y07Y21UpmSrEy4e0DV4FYwormlxPlZkwVLqhZnbG4Rc8z8+Rw/CTHin7aFVgAJER1ONAX
 kLzfv7uyk8b7w9ZUlHWGb5oCG27BVrjPJl5DtRIeMY5f0TlMKdxulpvitq0NskIRdYDLHWhWXUp
 bEWlq1zf2jUmvyYJ13rl6oXd89hcGjV/GyE=
X-Received: by 2002:a05:6000:2007:b0:48e:5e63:27fb with SMTP id
 ffacd0b85a97d-48e6e2dd32fmr3880072f8f.20.1793345824446; 
 Fri, 30 Oct 2026 00:37:04 -0700 (PDT)
Received: from thinkpad.hgw.local ([159.146.110.109])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b72715sm1645465f8f.18.2026.10.30.00.37.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 00:37:03 -0700 (PDT)
From: =?UTF-8?q?Yal=C3=A7=C4=B1n=20Can?= <ylcncn@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
Subject: [PATCH] console: allocate the device list when SYS_CONSOLE_IS_IN_ENV
 is off
Date: Fri, 30 Oct 2026 10:36:55 +0300
Message-ID: <20261030073655.164481-1-ylcncn@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 30 Oct 2026 12:59:41 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With CONSOLE_MUX but without SYS_CONSOLE_IS_IN_ENV, console_init_r() calls
console_devices_set() before anything has allocated console_devices[file]
(only iomux_doenv() does). The stdout device pointer is then written to
address 0 and read back from there by console_puts_select().

That goes unnoticed while address 0 is RAM. On the RK3066 started from
the boot ROM, address 0 is the ROM (GRF soc_remap = 0): the write is
lost and the console calls ROM words as a stdio_dev, hanging in
console_announce_r().

Allocate the one-entry list when it is missing.

Tested on an MK808B (RK3066) with U-Boot started from the NAND ID blocks:
boots to autoboot with the USB ACM console; before, it hung at the banner.

Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>
Signed-off-by: Yalçın Can <ylcncn@gmail.com>
---
 common/console.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/common/console.c b/common/console.c
index 54d12494..b436868f 100644
--- a/common/console.c
+++ b/common/console.c
@@ -248,6 +248,19 @@ int cd_count[MAX_FILES];
 
 static void console_devices_set(int file, struct stdio_dev *dev)
 {
+	/*
+	 * Only iomux_doenv() allocates the device list. Without SYS_CONSOLE_IS_IN_ENV,
+	 * console_init_r() gets here first and the list is still NULL: the device went to address 0
+	 * and was read back from there. That only works while 0 is RAM (MK808B: after the vendor
+	 * loader's soc_remap); from the boot ROM, 0 is the ROM and the console calls garbage.
+	 */
+	if (!console_devices[file]) {
+		console_devices[file] = calloc(1, sizeof(struct stdio_dev *));
+		if (!console_devices[file]) {
+			cd_count[file] = 0;
+			return;
+		}
+	}
 	console_devices[file][0] = dev;
 	cd_count[file] = 1;
 }
-- 
2.47.3

