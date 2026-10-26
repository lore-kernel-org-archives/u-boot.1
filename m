Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE862606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 05:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rZuP+AIZ;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UGpTIyUr
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A25FB40566;
	Mon, 26 Oct 2026 05:34:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PHkoI5Vbblwm; Mon, 26 Oct 2026 05:34:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D406340555
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792992882;
	b=aoor1cRTBU6OcXmoqR+IjGS0XtjhWxdjOypCTNHJnHcmpWqKalQ2boNapwlzBCCXmqA7
	 hpfMtjV4xjo9VaWaRcDay/Tp94isWUNAL2TN8MxAL1z4h2jp9YgNekbzmKv3+Gb4l3FQw
	 ru7Zlm8r3m1+6hD98qvwoLXV+NMIAWiYHTqXVkm118tB0lNUjgxxtnCzgRfvyz4oqJAO0
	 vGcTd9FlstlkrLR2ao2R2B8ne5nvkGu8C7IS29D30xYT6Lxtv6SpJE75/4c2cWVjhRn2j
	 xGuG7neFm08AJqpAQE0zR4WQmRUGb17Ov87ikJnNXOZYgcQRrjw0tau3BoIuSO/ZHdw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792992882;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9fz7magidgV4GfXt5hn4+ktyOsMx6uieKRS63gz8XIs=;
	b=WVEp0NUtWvlyKQ24tsR6muroOghF4RAEXQwo8NsqFHbBYHBvG5pxXcnectxl87Y8cEPL
	 Z2eu5CAw9VNPhS314Wh3VIuSeDGbL777eLixRe/T64GM9SYqYM96NuqdVNJAeYYB2IdrC
	 6Gkb/SgwBAk8QaVtDuCZS30pjFr/VSk6ijSuDqCvk3udFMe/nee9b356hRHADSsW+/kJs
	 hjQcAkjMgdkunmFHyPqbv2dTInlZ+cDtBvIZNyEUIQ95gMMtoquZbHFIU7jjATKifPShs
	 vwYYKatQqSRZS1mb2DlKSUA8r+Kiz9Xk+cCLSLHdQIkvZkJC+Wk14iO717J7O9p8MuA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UGpTIyUr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792992882;
	bh=9fz7magidgV4GfXt5hn4+ktyOsMx6uieKRS63gz8XIs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rZuP+AIZhkIOuAh0hEvT6O8YwEH91+CTdRff3p/zEuVQvXZmwtvMjtnm3PbyqBzwv
	 8sFNiBRXBeYxeiLQEt3Q3KQfZ5US0grC7cAuhpq4FGxluVuRqK1Qbm5PRkKGEmBedT
	 LA9pwVgfSG2GseiJYKvaIehOImQvBrTZ+7njvXHrwRiq4HFgmau8QUqdIKRlq8/03q
	 SyxDGG30P/DQ6JnWezwZxgdXE9n6VoAIzOdXPtduooK/TFYpJKZnDW9c//7tit/IX8
	 9jyi25emDd4277NBSvbaT7j/PElS6pb0G81GmBLzAQuxJJ5R0cblUABjERmBcUVHZt
	 YgeJja2UM1yjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D406340555;
	Mon, 26 Oct 2026 05:34:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 08C6F4D1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 03:09:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D99B540566
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 03:09:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id drq6-8och1Ao for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 03:09:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2581040565
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::82a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792984174;
 b=XmAt/xWiZvp5VmbI4baO6nYc2PD5+oYR4SFfc8M/3seqY7N49i6WaliHLI7BorHn1jA/
 BzbumuRfFrgg5XBjbJj1eVzpZXifasSCXp5FrlKfaKZtjHf32Mih1aXqmpL9ifeLDKsJk
 6NWCURuCFQpqY/5qtU+2Om0bd8L+/Lu4ihiGXvzBibrXgmCSMPxrN7lck+SOH9pqsud1l
 QXQE1TsixYz5D12pdN8MD/Ntv7I97pWuB6NLSdLEM7HgtJ6bgVpoN5TGZTVPZv5NsL1Fl
 5D34Oqzqk2fIvDj56oU6w8PeupQbkVDJ8xYEKSwbD48ioszcVgtYEDp2xcxGXEoxAgA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792984174;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=9fz7magidgV4GfXt5hn4+ktyOsMx6uieKRS63gz8XIs=;
 b=Y5ZFaroH6i4uCvlObSAc0neLFeE39RkUAn2qBdCKSSO1nqd5pnOOD3bLJBFkMgNTdDGU
 AVwNm5qg578P2iSbihZ8McyVMhJmSBke77EbdQ4U9/VdmsR830D/fYKjvGbvMPb0mC474
 VqnPMcet56FviKvXUXfdfKyOXfhVLNaJzTMs5VcJT7N2Dleoxnhllis/9jkJrXPARq+2J
 IuzoCDYMRIiEb+OYkyhzJoo56FrD/HVeVV8mvRcZhhuwiHts3njKxe3DKoKRdRZcR54DC
 vHWUBYEBZ/LVfXl15Lryufpb3mq6WiIlm6oxM4zrf0WhtMZxaP2tEZHC7EMdWZ3xMhw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=UGpTIyUr; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::82a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::82a; helo=mail-qt1-x82a.google.com;
 envelope-from=oss.patchbox@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=UGpTIyUr
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2581040565
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 03:09:32 +0000 (UTC)
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-53667180af3so32605511cf.2
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 20:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792984172; x=1793588972;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9fz7magidgV4GfXt5hn4+ktyOsMx6uieKRS63gz8XIs=;
 b=UGpTIyUrqyTAuGgl4B1iydBXRXAm948P9khJIhVA7IEwpegktU3SwAnl8+vRN52Qmk
 z3Cw44Yrnf8tqgVTTAIE7TUtbb5OJhv8RU0CcuylS05zI6UgmeNmbzhHVsEI443GkKoy
 UldgOaP5YkqTrPVuqWInkPG8FOVeSRaFfK0GEALJdM7Rvze2evQaWMYpZbjdfDrfx68s
 e5C0pLpNpu2fnC/nOhORrT2p8TmR5m4nn2bgZaE2uWpZdPAiZvzxDfs52GLPO2ZuXvI+
 s/hxAJqxxA63WKbtVc1GSKcVHKsbvK+RJdAbAXBRGxgKWmqB3rFWnCJmP5WIzDvOFFRg
 tiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792984172; x=1793588972;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9fz7magidgV4GfXt5hn4+ktyOsMx6uieKRS63gz8XIs=;
 b=gAh9XToS79oix9PlcoekjRIa07TWXSlVtikC3OENAZSTNIUk3uqiqzGK5QPKWkGxY3
 aR1z25KgQ7uBGLP3+hpql13UsHvQczhmDZgXq9NahXMtluPAvCXYqAvSxImd2Le6G1v0
 J5jQHeBVYDIDFKIq2cplZ2bzcW75z80/9wyeRqnosaXMBUn4HRKGWru+n0eXKf5/aAbl
 W7tWzv/0gL0maSTTIFrkTdKhkG7ZWC7wlZinUK7+SFmRz18Xm7cE+8QMDDV4RsYf3Nnz
 8m24o4LwYNOn++g37qssgVMreSQX9H06mb7bJu9CWTvnNKTRLEiZNuBP5M32/khKa334
 55+Q==
X-Gm-Message-State: AFq9FYKcgDAo2mdiybhFRHXoSc2GShpcCfsb4w1OoeBHaMdlUC1jUtwL
 iwO/+HY9tWjrIw53N/Z55SJgX1csPhc8P6Un33yAcAnJzRL10vVi1GoZOqP3VQ==
X-Gm-Gg: AYBFou1mBwy1pxYvIfn+OoyyqslXXMzsHW6qkE0h2nb14SQ6ONwoaeiQZx71i98xVlT
 btP7kILJrPTa95IjTeB7mP90DM6JoJCROWbBeTErMA2lPeRaWxK6rOBuSURix3k6x0GgZFd5bXo
 X6OiHXF1TdFTBqwR9eFFReNwwqJ72VEd5M5JWHAwAWaisKSglbZ34/KcSaOkp1wcKr4T2HQRsQf
 Ln8lTFCB+MkYPBMN04x/kr6gWnD1JSAmF1UIZ3VVWBH04dEKEtHz7blg5cHJFBXXaz7R1oqn2ZW
 ErXvtcI9KB8jvdu4GkeQjBoTsv4JDR7LqKcjV/fncoENlfXbwDpwEHnZDVZH9n69hil3LiZsMFW
 IuUqrUC2vOX7qiq3NYPj36i3dkbt7RWKFmg0rCr0oTIpC5KkiWSZse8ZfTXZK6RnmS2liCvRSXe
 Qzjj+30IXADeoVRlbGnsoJw42rcTQDlfpqiPMZxppSRmieYuQeQa6gROMT0/Z0/frMitcHSG3Lp
 it5fg5n2xgl5L3guzKyqNzsPi/Eeam/JSK0MDGk33qQZN3hs0UboZ3LRi248DbxLNr5etxZ1j2U
 aWo=
X-Received: by 2002:a05:622a:4819:b0:536:6116:6749 with SMTP id
 d75a77b69052e-5383b69e35cmr88308191cf.66.1792984171698; 
 Sun, 25 Oct 2026 20:09:31 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-538394f7e49sm45400861cf.15.2026.10.25.20.09.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 20:09:30 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: sjg@chromium.org, trini@konsulko.com, peng.fan@nxp.com,
 Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH] dm: core: Unlink the device when bind fails without
 DM_DEVICE_REMOVE
Date: Sun, 25 Oct 2026 23:09:22 -0400
Message-ID: <20261026030925.1002846-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 26 Oct 2026 05:34:40 +0000
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

device_bind_common() adds the new device to its parent's list of
children and to its uclass before it calls the bind methods. If one of
them fails, the error path takes the device off both lists again, but
only when DM_DEVICE_REMOVE is enabled. The free(dev) at the end of the
error path is unconditional, so without DM_DEVICE_REMOVE the freed
device stays on both lists.

DM_DEVICE_REMOVE is disabled by default in SPL, and a failing bind is
not unusual there: lists_bind_fdt() takes -ENODEV from a bind method as
the driver refusing the node and goes on with the next driver. For
example cadence_ttc_bind() refuses TTC nodes that have a #pwm-cells
property so that the PWM driver binds them instead. Any later walk of
the parent's children or of the uclass then finds a device that was
freed. With the simple malloc() the memory is not reused, but the
refused device can still be found and probed through its uclass; with
a full malloc() the memory is handed out again.

Taking the device off the two lists only needs two list_del() calls, so
do it regardless of DM_DEVICE_REMOVE. The remaining clean-up, which only
frees memory, stays conditional as before.

Fixes: 5a87c4174d18 ("dm: core: Drop device removal error path when not supported")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
 drivers/core/device.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/core/device.c b/drivers/core/device.c
index 6024534ff93..ea7beeb662d 100644
--- a/drivers/core/device.c
+++ b/drivers/core/device.c
@@ -206,10 +206,13 @@ fail_bind:
 			dm_warn("Failed to unbind dev '%s' on error path\n",
 				dev->name);
 		}
+	} else {
+		/* dev is freed below, so it must not stay in the uclass */
+		list_del(&dev->uclass_node);
 	}
 fail_uclass_bind:
+	list_del(&dev->sibling_node);
 	if (CONFIG_IS_ENABLED(DM_DEVICE_REMOVE)) {
-		list_del(&dev->sibling_node);
 		if (dev_get_flags(dev) & DM_FLAG_ALLOC_PARENT_PDATA) {
 			free(dev_get_parent_plat(dev));
 			dev_set_parent_plat(dev, NULL);
-- 
2.43.0

