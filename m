Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68972606D821
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 21:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OU8T5RCW;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZB/N8AZD
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E190608CA;
	Fri,  6 Nov 2026 21:04:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Oguv5HOg-i69; Fri,  6 Nov 2026 21:04:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 92CDF608D2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793999072;
	b=tgT+ns7j9k3wH4aPkAZDHK23gGCPjznw3w5PZ+LUMdRcPQGSlihG16Rf0xcSG7zUSw11
	 eqDF/euvGInaiMnwEFd6goSgbLLYwGNqgoFIR9GyVRtV22K/48L1wLh+OTwUtbz01/ifw
	 HqIt8FgI3kA+CNpTOMzg4MWua/TR/6Uqc8n3O2d0sueF6HNclICBVp2o1vCVDYOlad05y
	 fqaBsTIQ3+tpL7E4Vtgpg23q+AstLNXh1QsajSjENm0NI+REp/vS3qRFvCfy5FogfkpCw
	 cDR+mmwTe/jdj9UQpv+yh6WrLaXGVSJMqk/Iwe18WSn3SmWVhHUP8AiqB3K9JNkiupg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793999072;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1TF+sh+BKCe81lsKG/Y8+tEGcyB1InUfEQDfoGwPC4o=;
	b=sNk1Hmqv4hddYYfZwjyjUl38EakLa0wLzPd0r73aUeKQlruR1hovuqykczKfbrmvy7g9
	 BM5ds5h+VZvrEbecvtE1YT0JYXU3YeIrlKrIwUxxEFgrdopwFq5l0H56FlAj0kHrprGZX
	 wb10vAfWiWEhsttdSdKLlKSGgIc8tnRvnmxOopDhoqLgbo+aVK56gUOQwAtFxOwoQP0CT
	 d0VKX8e6fTBXwcCeb1kco4YaRm0UbVAEX91k9Kw5RL5UrkwkEp7dmcQbBjy/jbVfjn4+t
	 gHeAYlh/uWdmM1hulPfAR3OtfT5oUNh4nyOgxXr4no+BUvqJjDRLCP+SoOxCSqP0Tww==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793999072;
	bh=1TF+sh+BKCe81lsKG/Y8+tEGcyB1InUfEQDfoGwPC4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OU8T5RCW2adwmO1d2Vn2Iuj3Ju7+jZAhNFvuErDryeGtAy+3uW+efCPJ+VJxyPsMv
	 FLlUdqLgmFYiQNgcHVMFRfdtiINiGUb9XgZRSfujSgABwKY/jHrDLIuNipRcfuqYfR
	 nIk7Id5C/tblsegXoVo1qkVRY4l1z7romu3YwfLQXWhlf1sDGHFG9Gwr3Ji2sWUnFb
	 XA+rysBSu2sw9fmib8bhYnduS546nwUxCFiMSlJUeHPdFK63NuWQbFHm3RjClvZE5F
	 lLta9vU0wYcDe/PF1eVLYMk5OdC6j0+ajbnXduygaKU3S66xUgbl1Fnunu4qwhJnTJ
	 b7/v4YUyoMCGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 92CDF608D2;
	Fri,  6 Nov 2026 21:04:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 625CB2AC
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:46:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 53DEB80CF2
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:46:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 53sKxi3j6VaG for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 19:46:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 889C4812EC
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f34"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f34; helo=mail-qv1-xf34.google.com;
 envelope-from=oss.patchbox@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=ZB/N8AZD
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 889C4812EC
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:46:37 +0000 (UTC)
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-91ccfb88e4dso11951396d6.0
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 11:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793994397; x=1794599197;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1TF+sh+BKCe81lsKG/Y8+tEGcyB1InUfEQDfoGwPC4o=;
 b=ZB/N8AZD4PrFGz4uR8NC9IcpbktThPjUwWwFveGOCrg/eydJrRsqX3JwvhGLAZgsj8
 LMNU3IObXQd+zS46MD4QjbsXRf3swVivkZwgJFLFBXbc8LDiloRxf9xgscNDTZNpYzc7
 NLJdP4MpdOIGF+qcdnn8ji7+/O5OPBJsY0kN13uUPBp2XszpwFwT+a9h2aNsXXuxjRSK
 bCov3277kwAuYIddN6aSudd09NWv9lkkfGtIP8v+3rc7DQhfUVshRu5a5aCTEfDBkjPs
 7DdTYHjv2dUXy1+gAbv9gpOA3mDLC24Nk2HRbuKNQijtDyu2cq3+wY7pOPbrQ72C7ieQ
 e3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793994397; x=1794599197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1TF+sh+BKCe81lsKG/Y8+tEGcyB1InUfEQDfoGwPC4o=;
 b=XyMTwvIVHgGIWMnYDNZcz1cYtHEI4PXI97n6pBoSI8daJ3fXRUVuA3LJl+F65W1Cvg
 9Gq5Wc76kscZeQPreSWV/H9w/41aixir9QQ67wRSQzjmefcWuq6CGS+FOECey0nBthnZ
 E7d91swHopG7OI8uwfiwQn4BUTi7RGCAR7EbbX0i3FCVkewrYhAyz4CR6SBnu833lBJ/
 qdLWoqnrE3dxo/2rn9OXt+tTnlXLp7GWYxJgP/NZkX6nKbg8z/c3Qpm9pb0sAxFeftsc
 BDrawA+uq2IcBvUq83DuCiJrChG58aw2g1PMqscLhay1rfhMjMjYkXlO4KKw1tK6MRDX
 itJg==
X-Forwarded-Encrypted: i=1;
 AL+hErG8xthfQ88qCGsztv3Y5CDP2pNKrds+ogFswDM0z68edHX/afoNMkOans/4fJ/DRnme3VJz4ws=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8ImGZ5UmtIbwHL15vhZuPLlnbEJE/Afdl5zhmuqHbMl8AwaBej
 MH65xUmxW2O+UsDBtqDw1+fKBLCdIoguEtmn4/VbZtr9QzNlOq2HlbyJ
X-Gm-Gg: AYBFou0nRMlc039eARWL3WAsc9JRHKMv85nrr7gbLNDl8LMKwnZjRjwkt0WfWKZB5+f
 JqS88UndD/OdT+cQIkMYaS7kn9C09HbnPnjrMBT3n5UtQ++G1OL71VtlQe77K44O9oZlcebo+9c
 ftTAGuHDlHaSV+egLeb/6ISQr0e0r0YXT/6cX4ILSpOuvINj8V8FqJ7WqmzzT7K/qwkfGpKz//T
 ow9cA41p12vVcD/ETNLStzFFlBka4vp1ghJnHMzascrZSf4V3UqbqXeTNsI/iaB0vLW+cwUFzLZ
 fnU6+zJbleXm9F1m8x/oENEtDmhymIartrLs6rE1eJuXIh/Gu9FiJPwdWJTcwYFrwSyryjFBKL+
 fZqOlptxLJUphmGdkwBgBpuh410+kMo5QA+Zeemm5Pne4+pQZnJZlYnlT6S3HUbWxIRIPoS9mSm
 6nNF1WbZh7+AvF67r2BmtNH9bEANooPC4+Mxz7Nf0tN8f387fsb1yEqGigPWEG3SdNrG9eABW0Y
 +JY82E+GXCMYXyaSiAMgD2GE2s2qbvxJqxL8i9kxNOAB0W9JXMb6jxheLLuhrPcCUisPq2IUliL
 AiWu39vDVCeYwzU9suoQbINVta+peljiDintBdG1dUQr0Y6h8W91vtuCuTPPmbZp37d1GTMSfg=
 =
X-Received: by 2002:a05:6214:4c8a:b0:91e:aa6d:d415 with SMTP id
 6a1803df08f44-91eaa6de7afmr43737916d6.5.1793994396690; 
 Fri, 06 Nov 2026 11:46:36 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ea867655esm25303246d6.37.2026.11.06.11.46.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 11:46:36 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Stephan Gerhold <stephan@gerhold.net>, Linus Walleij <linusw@kernel.org>,
 Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>, linux@analog.com,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH 6/6] usb: musb-new: da8xx: Free the controller if the host
 probe fails
Date: Fri,  6 Nov 2026 14:45:58 -0500
Message-ID: <20261106194621.510146-7-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106194621.510146-1-oss.patchbox@gmail.com>
References: <20261106194621.510146-1-oss.patchbox@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Nov 2026 21:04:15 +0000
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

da8xx_musb_probe() allocates the struct musb with musb_init_controller()
and returns the error when musb_lowlevel_init() fails, for example when
no device is connected. The error path turns off the PHY and the PSC but
does not free the struct musb, and the driver core then frees the
private data that holds the only pointer to it. Each 'usb reset', or
'usb start' after 'usb stop', probes the controller again and leaks
another one.

Free the struct musb when musb_lowlevel_init() fails.

Fixes: 5608331d8136 ("usb: musb-new: Add support for da8xx-musb")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
Build-tested only, with omapl138_lcdk_defconfig.

da8xx_musb_remove() does not free the struct musb either; that is not
changed here.

 drivers/usb/musb-new/da8xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/musb-new/da8xx.c b/drivers/usb/musb-new/da8xx.c
index 7caf03cc2e1..17a953c9744 100644
--- a/drivers/usb/musb-new/da8xx.c
+++ b/drivers/usb/musb-new/da8xx.c
@@ -319,6 +319,8 @@ static int da8xx_musb_probe(struct udevice *dev)
 
 	if (ret == 0)
 		return 0;
+
+	free(host->host);
 shutdown:
 	/* Turn off the phy if we fail */
 	generic_phy_power_off(&plat->phy);
-- 
2.43.0

