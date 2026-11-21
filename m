Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC60606A32A
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 12:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HtVrl7ZS;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=T8peAXd7
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C8E8E40C66;
	Sat, 21 Nov 2026 12:35:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5Ng63MIcUrEJ; Sat, 21 Nov 2026 12:35:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B98E94070A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795264548;
	b=CI/T0Sk/pFRtNGOGiZePosPcH2S+1/htKq5Gr+2MJy0rWRkcl//4/GIieIJ8rap05+dD
	 iGniI8hb/Sa8gmHN4ZVBKyP3TbK9gqr6pAJGDKdVcyPqSTNdPKS1a929iUWi6qn4bAOII
	 7MSO5Pl+mcosquq/XTw6rU/38iUd20xLLsF6eRxaEJBFufRdvlmYIrTujx730+dIFzAdv
	 /sPUTySoQjMFahWE7clQXlZ4ZA7CtDSgM3Ez5clyTfhhrDNQMiVZXycIlROuoJjPh3OuV
	 CgOS+B6hEDKtFIwptd2CyMld/DofUc5p2ngVXQpolwjFLU4KPW4LEea0T+Vm7n6UWTw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795264548;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bqp7cVRQOlqZV2EatoNLIDs4Due2Ehr/JIKLwVQ6Gok=;
	b=inyws7abeVlRwYNR7oNCm6qsg+bPEXoa3vIPL25NNntjBBHTgDjTIASctyrZcUMdjBiu
	 dpyrn0ycM6xjvPa2/UWWqJrIVqNDvGMZpNn1KtQSmaQyb8Yq6c88bqUNLO7powDqrOIqt
	 wzNkR94tfrRxIWIRLd+K1QXxrqJar5w6B87q9u7A4Ah9cKv4OVb00qlnhTxJbrGE5CmpY
	 WHSCjTrGC+JvfNehey0NM91fbuk8EedYOklCzefKLiB1ahQ5uY7VQrNFStWuAo9SIpELw
	 3ogM24l8bWSkdW8jOqRxpqkm34/YuP8bytd89benhTa6SCk3Ebf3FQVzR8G8+i9YznA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795264548;
	bh=bqp7cVRQOlqZV2EatoNLIDs4Due2Ehr/JIKLwVQ6Gok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HtVrl7ZSeGpvFr86fCeZWK/uoVQxtuwila3Vc1TeVqjY+JJGBsclCutHOfQ31ksAa
	 vqP5yLsJm8yTJsLtQXIUlqcxbXrWhrk5Mj/j70IVdHaQsVmp90CphlM2vmrcHJEFrg
	 bBgQjsVFxiT9nTBRC6buhww4dWt7WDFwNF43vmpzQQQETDKs7DJL/UjRvQyvOVUA/q
	 AdTmTIBgoUfIgP5BpVd+4183l7YtFC7Jy+/PoD7ReK0fXQSqAxmH1Ffumia4csX0pN
	 vEeyZu4J6+dJ1lJgsFdqTjWaGPw+34DNCwc55rPoeA/JUiZEwVwDnaZHINHQHfrd7v
	 IA8Cs0XE0TnBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B98E94070A;
	Sat, 21 Nov 2026 12:35:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 81AFA3A8
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6863080E8C
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5N-F2Kg2vmAz for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 12:35:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7EA6080E22
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=T8peAXd7
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7EA6080E22
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:41 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso13989005e9.0
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 04:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795264539; x=1795869339;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bqp7cVRQOlqZV2EatoNLIDs4Due2Ehr/JIKLwVQ6Gok=;
 b=T8peAXd7CHBvFkjYMAYJaWHoSMxS4oh7/sFRiJY9hVh7SGDHjhkXTJA4uvIvYPhWgO
 j1JRGntxAXKB+yKc8wiXqXV8oKWFLliLDXT/Rd2C3Qh+7NcBK7/jzFYBq3+RreJDNrLs
 FDIAfvZMaRGXAM7RogyQBqtoHXXDHp00krfLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795264539; x=1795869339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bqp7cVRQOlqZV2EatoNLIDs4Due2Ehr/JIKLwVQ6Gok=;
 b=aJY65mYKP1FKhQlG+SkEJIK715z08M1LKn9tF/xRoEyMqyagitOBMmO8bcvdd6gf9b
 73HRPCUQ5/jfcxn7lMFZl3TzG80KJM709YyGmLHH4qfVKtcSD49wPZd+ItzDtOZVjQnd
 MN7lVzt5tTaidNrBGi0/odx0beoAYve1NqZq4DPSjr+cfdttvqFyvJASUT5gKnX+nHYX
 O1Vv7VdBny0oxafQgQ8QdeVzLCjT7BOjkBSexPUePZvjj17eDqtz2zNS2kRPtbysVpiy
 G9WBmhxEiznAUE24B646zR6nzTEjxDsComd+kEHqegpUNiSXRDK5cJKHJnKjFZuwNURz
 u94A==
X-Gm-Message-State: APuU4Z80boA4v3yKnghLJbp+jt5JDkeHCc8/w2E6xKzPeSq+0W27+TMg
 ih0hqIwPusbWSMAi11UUqbD6VP/yrmI/3XD/fAB6s8ru6xSF1sLJcilab/H96iHcSP1K9WaS+Np
 1jyIM
X-Gm-Gg: AZFdTZcsvdYa67mcJwDVJ90EnsmdFLDH8FhINHmDdyhDK2oSj+PFp/80n4VjSrP/vUL
 ZDf556XVtFYMUojnhGWIWYrShWdyl9LLPZ8gM4vsnRDCd2jjis7/X+hmNbCaXprZasREzwVYkcx
 IEuKnS4FXTHYWTKQRkYFqU5mGA6a5MiEH0IaB1mUvZ1CuzsgUxwDrHl8ZTYYILTj3PclPHDcrgb
 TIPeXlBTa9fp9qXFGBjfl37AlsdWGlSo/UghS9Ejbazox0EON+YoCyiVTJn8IDD2/80/kq70WTu
 w8LcqS9X7X89Lyq4ciPSFqPI6pUH/O/17kf+eZWagzNd66AxHaX4snKxwS8zZXOOIlqEr2Xg1Z0
 DBxAnA3j6EhhiJllvHgpCaFd+nvgTrUfWth9f0JFfOI//z6DcBeFCxEkibTVNyKEZUVIwJCZBvd
 UaJgR1F8uQocgpsbmf+1clemPJG3ApBg1avmS2uQJZUckM73QDxXWKDuuz3x/eIi4NkAPrBXQew
 GjB25fEsFRPPUI+ORQOWgRQplaXhNmDAN0W88zfC5xFerYtLmP7fiP0ERYO7jVvb8/c8uJ6WEFB
 2Y9z3nbSWDsN0T0vykhtfbBxriabhWMRNOB7HeM43DtvJ/KzJcZJZOmUg3V1Lxuq3jIWm3OS4aW
 i0nJbi7CTvzSAIHwIRq0qb32W1JjBnaXEoKA+s5HaffqmzBkZ94xg8gNvpeFqPHjVdf8Fi+BMs4
 DSit9xQTzEk1Wns/zztPLpaN0fqA==
X-Received: by 2002:a05:600c:64c8:b0:4a4:fc8c:cfd9 with SMTP id
 5b1f17b1804b1-4bb8881de62mr129309235e9.25.1795264539321; 
 Sat, 21 Nov 2026 04:35:39 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d1bsm11720564f8f.8.2026.11.21.04.35.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 04:35:38 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heiko Schocher <hs@nabladev.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 21/25] video: mxsfb: support simple frame-buffer
Date: Sat, 21 Nov 2026 13:34:11 +0100
Message-ID: <20261121123451.2471185-22-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
References: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

If you want to pass the frame-buffer to the kernel, the video output is
initialized by U-Boot, and kept by the kernel. The patch does not turn
off the power domains or reset the peripheral if you want to support
such feature.

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/video/mxsfb.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index 55ac99bbbf70..f7e8947c5509 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -421,7 +421,8 @@ static int mxs_video_remove(struct udevice *dev)
 	if (priv->disp_dev)
 		device_remove(priv->disp_dev, DM_REMOVE_NORMAL);
 
-	mxs_remove_common(priv->reg_base, plat->base);
+	if (!IS_ENABLED(CONFIG_VIDEO_DT_SIMPLEFB))
+		mxs_remove_common(priv->reg_base, plat->base);
 
 	return 0;
 }
@@ -444,6 +445,10 @@ U_BOOT_DRIVER(mxs_video) = {
 	.bind	= mxs_video_bind,
 	.probe	= mxs_video_probe,
 	.remove = mxs_video_remove,
+#if !IS_ENABLED(CONFIG_VIDEO_DT_SIMPLEFB)
 	.flags	= DM_FLAG_PRE_RELOC | DM_FLAG_OS_PREPARE,
+#else
+	.flags	= DM_FLAG_PRE_RELOC | DM_FLAG_OS_PREPARE | DM_FLAG_LEAVE_PD_ON,
+#endif
 	.priv_auto   = sizeof(struct mxsfb_priv),
 };
-- 
2.43.0

