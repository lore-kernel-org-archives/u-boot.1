Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42434606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 21:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Zn6zvGj4;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dvb32g+F
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 21E1F40A4D;
	Wed, 28 Oct 2026 21:40:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jDc9ksEdrvGc; Wed, 28 Oct 2026 21:40:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2B4C840A59
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793223604;
	b=aT4pc4wmykJsuRPumhiOHTUa9KixuduA4Ur1/zEyUXaErDjLrJzWBVhFBZSQPaTAyPUE
	 khIz7SMPhByUs7jHcQCjgUy3+FgDUBU5tFL8HEwkc5LKUk4D2njyZgcI9YPcyKsT0x1v2
	 14Ms+wTfsJZ0dpI0PqDFtTkcdYYZFYr95sAvbW4SYnhYTRTVhi711nvAtCV4VBiJGBaeg
	 YOPxTHXtwoV35l0/cG2tkkBQSHsL5xAY7SVNES9p84SRbZ2FvaeJD4SSSVGIWauUObhXb
	 qK89WkAuA4h9ngUTvuWbK3IJjHBLB13KVTFvTQOmgWC7jOpUuDbrtHrzXsC0AQreb5A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793223604;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+jswFALWlvsrae/GTnTySREwLbPlY23VIyXuNwIcYbY=;
	b=AtSCDnXbfmidWAf5rKNbM1i57fPZtOfo0AcODPycCO8ZxvzS7lza1VgvyjPraJ7RzHHf
	 wK963a0uHh+fq0IdDqbAb2x8gZ76fUz/k07cVbnneBrVihDIPE7OrZhNsWL09+ATOAqmP
	 JD24QwZQ11ym3/F2t83hxV7zmcXqb1US0vO6GXfcoNrwtFu4Df+V3fiyw8W0cMHStyBx/
	 3REjUP+re1aGmwXITpb7NvquiC3YiJuyKl8gjD85EEp619nDSC5Ye+AECI1bd/TKHfaMO
	 1iPvRa3nduyxIvAVReco5Nc3qnOED3fM+RMyiMiycaKoTo2LMr51wUJ1u+bCvrQiv/A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dvb32g+F;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793223604;
	bh=+jswFALWlvsrae/GTnTySREwLbPlY23VIyXuNwIcYbY=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Zn6zvGj4lXxXADYzKx+c7Or6cD95WR8FcqOuozQthe5JLvvaYh71XqbjU1DUhHCdn
	 ehUn908maYtLCkEe2J8IgS7gaSZiG4MraN1BFwUm+W0IeYdsDU0bTWApbjO0YBYYfY
	 irqj+BHs2CNQYKkG8eknxuu1DNRbUu4oe4HEvqNQNkr3TwM3mGypPhF3IqrgSh6hqv
	 5R7sKjhRu/jO283ko0yWaonkWXiPfAfnGbcXoUYoOE/Ffa+z4dBdhc/X7xw8x2jLWX
	 9KMnf1jhBNK9J2oEISHZrNQnPUTscgdNWB6DuCulmcu8bAziX55R8U7sAuW0lKQkCV
	 CwmSl5Bm36lcg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2B4C840A59;
	Wed, 28 Oct 2026 21:40:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 818CB3AF
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 21:02:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7EFE44080E
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 21:02:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LuiJ8W_2j5DF for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 21:02:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6DDB7407F8
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793221323;
 b=GtGYtWXM0nla9fQZfH3Z5zn/XgwsuoXrFVF4qpvB3fGHPIEJCzsFni2Gj6H12FtV9S2Z
 9HDZ3UHxC5cH6OFFoRCHVzPETaSHifay8+Gdf4kO1aDc/zcUuiUm1ona37+tyk9SB+fnT
 hLoo2DLO4Ue57LdEokTthbAiJoCXstfR/wpuWGN5fnLLAPnAk3Xc9lT/BTEBPO/IS9uar
 v05X/1Vu+heLL9RAqRxV843UGY15lUg69vVh60R/6Yccw+7xWAmMXBleY8gFvuejgyuBd
 Nd4ABR23PZl2s4g7VFWbyN2HRgxPESOShJVTqt3nSyneqed05ELG2GcSW2IWlExVgYw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793221323;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:To:Cc:
 X-Mailer:X-Developer-Signature:X-Developer-Key;
 bh=+jswFALWlvsrae/GTnTySREwLbPlY23VIyXuNwIcYbY=;
 b=VyatpmeDyqR5RsiK9wYVBhoYjjHQ4TuRws0JJsHdQpsMbH9fLHCiGoiR29ku2foGrTXO
 4JmQqiIAvzoBg4wv1jsakZniIvm3si9OmKLhfzNlJF7RHI6ndv24MJXCrwcPQs8Shh30o
 c/H65W0PKOgkdnrismbfA2rcMQYeU5iEY2mf5hy/EnDVAihgFm9C4MXwHTQIIlNYkgnYQ
 AGnCL6md/dM8j+oCRX4Cc0K19n/gTJouhmoLcuUJm0J/oWh7rTucM4vTg9bVEe7BC7XuE
 FDxBuaI86q2peqWhTkdoXzolne2U8Rydg41f7YF+PvcihxC8Lblbu/WgcDcxU7wL3UQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=dvb32g+F; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::a"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::a;
 helo=mail-oo2-x0a.google.com; envelope-from=ryanbrue.dev@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=dvb32g+F
Received: from mail-oo2-x0a.google.com (mail-oo2-x0a.google.com
 [IPv6:2607:f8b0:4864:31::a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6DDB7407F8
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 21:02:02 +0000 (UTC)
Received: by mail-oo2-x0a.google.com with SMTP id
 006d021491bc7-6f9b24c99b6so545711eaf.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793221322; x=1793826122;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+jswFALWlvsrae/GTnTySREwLbPlY23VIyXuNwIcYbY=;
 b=dvb32g+FYlquSi1VGw5GU6CfdK5ZrTAvYUFc1CKCc+bW+lDp0Tvw87q6Hqkzq0p3+q
 mAPAfNT9vK637Q6AHaB3PIq+QJmeTgEPy4RXkUhIP+bGAzA2vlUNhNr3MlHP4nA8z4FY
 BOQKPBlcJ3k958/UMT8BGOLfZhpAa4avupSsZ3m1SpRr7aVqXSOgIXOVdZvUssIMIld2
 YcWeeWl82IC4rvrg9nT6sXpTAmYI/tyRwmqdO/gm39SBKbsvu0a2ngvESMxIgFjb7bLk
 fX5HKxb7UJwCRzogpq3izn6voi+V6TROnAhjO6IeCzNifOeS9RC49FmOeX2d87nttWVs
 fpkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793221322; x=1793826122;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+jswFALWlvsrae/GTnTySREwLbPlY23VIyXuNwIcYbY=;
 b=ddNF/nqxhdV4dVICxST2EOuxZ1hcHz1qneVZxXJ+zA9lk95bYTfJO5hGrYBqF3BcwL
 XSG2YwVq0RtCc5tDaR7QZuPoObFsuWKxlXMul4iBtwGalBMaeSTLCdwohtmGGAV3JnAC
 3NuU5HG6uhAjp0mJO5KyPc6n2C8FCowphA8PTwMqxCtXEkERnry44lVahmSMkOy43o3I
 IsNxGUMY8WtxL2geGEtQkunzsFCL1bAp9tavKd+pqk8HWr7moKduxAMNOpxN9erHvUFF
 o0tBcdzj1nNUIxJpa7IUP64IcnewI1MMsW5bLNgzUgh+avhVo6X6i0dOLih0ttPuRebH
 zQ2g==
X-Gm-Message-State: AFq9FYI4yI7DrTkLLLwGhFWkHAOTcGDAC926fXU/Po2ofhKoRDDh7mEQ
 SLf3Jf4J+/LRCjkOnwkDqP/K6GXZ3HXOZPIsA0fABNKhkXi/0IyG6/8B
X-Gm-Gg: AYBFou1vAV0m5rAgxHgtSMKtv0wf1CBxMh85LPs1cCGnVBKPLkeigMnS3fVC5f7A5Yn
 THRjeY7QI8QYaLZbbqza1CPprJ+eAMOprEmOoiREjDMvZTeAvntKll53zgRWpD+o070t8eUTb1B
 zL/eMd+PTY/laRVDmXh+7gmOatMo4OMGnQCeuYlJFjYiujNWkVjtXcH/wQnpLiGGuX0GxgmKIes
 RmIg+2JJPpqeAW2BMnCIeYXY74FjCZRKDZEayXX1yUHDFr87fppgp4yuAotwGFqo3EZSJglr+pZ
 iuA1zj5XdYm4GxhL2mHjW29smw9Je0Oao7m1t3NCfAWoL0omXkpGXGS1W7BQPG2VubXZLGDnzl5
 Zjh6xkpO4ELuU7A0A9CbilhqWXzMbZKE550Gov+nbttPzwO/9TBHzbAAt+9AIgZApVIjYeHaA+z
 T3ZMxryA9FJCOvw+BfB4k5co3BAn2WEfgtvi987p5KwvfAmDRPb0VuAn7w9Nw/m6AelZStJTjXG
 UugRbOHBYmB58G+8vTB2CS9hkUQPijnGXHzNBIwQe2v+FRZUCWMtge/mrRgvr3zrz8d3xupamxq
 pK0bqi8GKJxVGKlbDz04nmMP//L8akl7qPDXXdfERrz8AiaH4KBxXadwgSLFtMlNkDoT9mnQrRV
 IGVSpHybvUElze35E6P4=
X-Received: by 2002:a05:6820:338b:20b0:713:3290:1350 with SMTP id
 006d021491bc7-713eed47cb1mr1443147eaf.21.1793221321676; 
 Wed, 28 Oct 2026 14:02:01 -0700 (PDT)
Received: from [10.10.18.223] (wsip-64-207-253-118.tu.ok.cox.net.
 [64.207.253.118]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a8b785d108sm3272509fac.9.2026.10.28.14.02.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 14:02:01 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Wed, 28 Oct 2026 16:01:55 -0500
Subject: [PATCH RESEND] misc: Provide stubs when MISC is disabled
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261028-b4-rbrue-suez-upstreaming-misc-stubs-v1-1-9a88ac233299@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793221320; l=2336;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=IgWOtI9j8/dn9zvOVTYYPpRdyGVipkE/nxbQQc7Cong=;
 b=ZFa8Lkpvdzekij0Q9n9SkXiRMgPQX7MVECpRhrUicjbt6bE6dQvDgE1zvnv3jFQOd1upCttg7
 ogsTBBQWxmdDzRNdkCOVhxq59DCB8IfrqCG/khVChJmBk04AGiEcZN8
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=
X-Mailman-Approved-At: Wed, 28 Oct 2026 21:39:59 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

nvmem.c reads and writes cells on UCLASS_MISC devices with misc_read() and
misc_write(), so a build with NVMEM but without MISC fails to link, even
when every cell it uses is on an RTC or an I2C EEPROM. The headers of
those two providers have stubs for this case; give misc.h the same.

Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
Ran into this while working on the Amazon Fire HD 10 (2017, MediaTek
MT8173), whose U-Boot port is not upstream yet: it keeps its reboot mode
in an RTC spare byte through nvmem-reboot-mode and has no misc devices,
and with NVMEM and DM_RTC but no MISC, the link fails on misc_read() and
misc_write() from nvmem.c. With this patch it links and the mode is read
and cleared on the board.

Developed this patch with the help of an LLM.
---
 include/misc.h | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/include/misc.h b/include/misc.h
index 6f042625c9f..78cde11c38d 100644
--- a/include/misc.h
+++ b/include/misc.h
@@ -6,8 +6,12 @@
 #ifndef _MISC_H_
 #define _MISC_H_
 
+#include <linux/errno.h>
+
 struct udevice;
 
+#if CONFIG_IS_ENABLED(MISC)
+
 /**
  * misc_read() - Read the device to buffer, optional.
  * @dev: the device
@@ -78,6 +82,39 @@ int misc_call(struct udevice *dev, int msgid, void *tx_msg, int tx_size,
  */
 int misc_set_enabled(struct udevice *dev, bool val);
 
+#else /* !MISC */
+
+static inline int misc_read(struct udevice *dev, int offset, void *buf,
+			    int size)
+{
+	return -ENOSYS;
+}
+
+static inline int misc_write(struct udevice *dev, int offset,
+			     const void *buf, int size)
+{
+	return -ENOSYS;
+}
+
+static inline int misc_ioctl(struct udevice *dev, unsigned long request,
+			     void *buf)
+{
+	return -ENOSYS;
+}
+
+static inline int misc_call(struct udevice *dev, int msgid, void *tx_msg,
+			    int tx_size, void *rx_msg, int rx_size)
+{
+	return -ENOSYS;
+}
+
+static inline int misc_set_enabled(struct udevice *dev, bool val)
+{
+	return -ENOSYS;
+}
+
+#endif /* MISC */
+
 /*
  * struct misc_ops - Driver model Misc operations
  *

---
base-commit: 8649a54d301a4d0ac526324c7a7ad2574939ff27
change-id: 20261024-b4-rbrue-suez-upstreaming-misc-stubs-d8f9b8f0079f

Best regards,
-- 
Ryan Brue <ryanbrue.dev@gmail.com>

