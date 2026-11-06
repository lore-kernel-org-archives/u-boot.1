Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91695606D819
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 21:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oiUZ8ZC+;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DHrsJH/u
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5176C608EB;
	Fri,  6 Nov 2026 21:04:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mp_iWorgz9sA; Fri,  6 Nov 2026 21:04:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 32FA760907
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793999068;
	b=laKucN87d6mI1F5uVR8ejoKpo2AkSy8OsSyzKms6wtrr1U/FPoUcQE06hsAjXNAcx1RV
	 wFQuQpn6PlouvTyVbVM+Y6P7AoT2c3gVDSz/MTiTJvQK3pA+jms8O0bAI76027qABt931
	 KcOEpangJJw4CW49EZaE225uhK1a4G9UN72P2SoV6Cz0EQzBNICruWEiUhG/z3yM3ZePX
	 YxpWNoPmfiyOOUaB1TZCcRlY2KihdiDmdhtbU48+c1JAWB90b6ntljEedEvDHF5KlUznA
	 dgIz0TfPOtgRomRKWNlVZLb8e7dr8sU20oviJe1u2JbpwFuLwXm9L3PdzP6nWy8CgTw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793999068;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RwetwJlFxw1H+bu3dhkZXlxfi4r3ZZoU3hqpdOxHvPg=;
	b=PQ4Ix5w579Ao3mEGomy4RKtlaNGzdTU+kHh0kyKFaoqf+ZzPTIKKsmEZvnPkTAV8rmlT
	 Fe6TyhN50VAZje1O1hHHOC1t9FNY3BIDX0PP0WYhOGX1PCPii8BhTt6g74b+n7e3L38ft
	 ylqUd87b59wNSkTuWfYbgzwbi42+BR39Hw7KsXeuB3y6LZLHPdEs9Uhth1zp6Mqa+zebn
	 4SkOlw8JjNUN+ePSvzKWFkT64UWMusIImqckX9P3o6RkIKfiyJYTAOUC+sGL5ogCYxjRS
	 +WeIHncLWc6xLnzD06wV+yTJ1ien7oBwgIk+DmQqMB3axUQUh7Reye+8zoI5BCc628A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793999068;
	bh=RwetwJlFxw1H+bu3dhkZXlxfi4r3ZZoU3hqpdOxHvPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oiUZ8ZC+/6ZDNcc5Cs3gVKMBcn93kKkWDhjFRSdK6nasvnbAlRFUklCbdUqjrVr4s
	 rOW7SYdMMWw/q79hjHL5TVkZtkRhIUZBq3YqYL0NdVmcrlraPa/e8tNelUjBiU7Bfl
	 YLF4ss5ohRCzCdNUy1l9ao1duZO3hrnFmomaBbTEnrKyFMfnd7fvjgkU+M98Pj+tRc
	 GR98UxX+nwhRkeBIWfZoIOaRWDxGiY/LEJmIsJs3iMlhxB3Qwp722cb51dwDkES3HW
	 SuKD2GPExSOYuNWn56D5wJbPTqClmq7aujTMHTMWdE/QcHHVyI4zyZlYy0pWbSg8nM
	 22TIgxEvqhKng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 32FA760907;
	Fri,  6 Nov 2026 21:04:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A984235
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:46:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7A69E40993
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:46:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4P8hpGeYAS0U for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 19:46:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C73C4408EE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::835"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::835; helo=mail-qt1-x835.google.com;
 envelope-from=oss.patchbox@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=DHrsJH/u
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C73C4408EE
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:46:35 +0000 (UTC)
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-533861a59b8so10925061cf.1
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 11:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793994394; x=1794599194;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RwetwJlFxw1H+bu3dhkZXlxfi4r3ZZoU3hqpdOxHvPg=;
 b=DHrsJH/umTj87k3rPHM1YCN1wdxFR7e+CYMigtkYtErfkGfISyqC/e6yZZoR4SKfCh
 I6Eo6B9m/xu6PXC1Nd0ibl0JN1yYxECu0KfvtNMphUHM7RocWNbRO2Vlb2zPOvOUSWAT
 qpD0ye2ITJUPhJ6MrkJESBZ1XaiPuhql6TqSIIuCDo7z/SQ4oAJTIlvDQapsWAPoFhBO
 nU9W1fMysfIyjQZoHEVqZf3y3eF0Mo0w69Eu4jQxqe4nQZ2VxZsFNTq3Mz1KOFRcH5sb
 /Y+uwcTQko2lrV9iuRQ19cSInHqbBVcp/jdWO7sXc9LPJDzEtBBHrSQfpWlZAKP9xu3/
 oetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793994394; x=1794599194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RwetwJlFxw1H+bu3dhkZXlxfi4r3ZZoU3hqpdOxHvPg=;
 b=H1Moa8uy+rcFtan0If73/YnE6wzKUXHGyE95MZUhNt7tnuaAZKuzcpg/KqNuQySUY9
 8ZXotEtzCN25bo1bfYy3ccRTx5imUnel7NhKQDRpeD9jRzi+fXS0HoWPSjlIFYHR+nhI
 y4/spJ4xuG4wCdIaSKjm5Z5FZ2ECQaRDkO8sNN9I82/tq9r22LiRTDWTxvn+TrWN9SJz
 nSMIyFD1a8lmzMQC1s230snHzWiCa9AW+JKBWUUz1UfDh8y2eR+2GtH6xuZ+eqsJJ+mI
 qWPIAUS9sl/hAh/rfiyQHiomgvgjtJXon1TlD0jWb3EI7mkJ8Agwp5KBv4ldG1jejAyS
 +Fng==
X-Forwarded-Encrypted: i=1;
 AKwUvBygr22otduRHiUfckQDLzqYH13I0iDV08i6LtfJbS4I3qPas69Xg7JlVd/YvPL7+RiYg91LWRw=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/XtSsURWY9m+uIppsFU7IwE3ZebF0tdUpBe+2u5zuP2tACgD1X
 6LqV2hmfQZN46fReJ3tzQk/Xw1SggwqE2wjrcYpiDs3sDAmjH7O2nEAd
X-Gm-Gg: AYBFou2BxEf4t85A2flbbV392LJYaVSFW/0bWlR0XEgCt58m92aLyyvvz4TiytT22ty
 xN7JnlR43bcGRETqde3kZfjCY8i92GrEA7Ut4PSRGAjdwBkyY0fF1PMThkW6Yb/MChznhqceSmj
 Ww9yuV3bWrktGadhtoJ5N3Mi7m0rc28RrtUOFMephGUJY0ZcMeLRgITKKCvVy2xgGCApk8tpRSt
 6biHwVA2O9xIi6LnPGZyQMxKiGLDthgMqQZkFMseRX8Jzepjh+Zeu4Wy01q8S79NVCBJQ42DRCC
 fyqiXhOwaTarIEDyJ7MgtRnOrQoXKm7JKQJE6vl6ECKTqkF0YpufCbQN/0Prn+WtiDX4h6K3ahC
 RK2CCSaVMqi0LKCZwp5tk/PMNZ1HiUrUSIUebO0ndv3+KakbpnlujpbXU1jLU3WvyBT3crZ9Zi7
 bHq0uk7KCYKqV1bypdcIbbpicGL/qyHEPCflSVCPl9LKPdK+j9bZtB6Tqi0d5YQu492YOF7uQD3
 e+l0YTbhFGvwJmMbrwm9dbgvdfc2LXVNu5yt0KXQxAT+aN48VufCIKnzpIAF/dzggazMEe+UKn8
 n4Mb2Rd5jiB3kylfYjki3AjKjvWbSMm4CSs2gJ9bVYgWa9bd84vCb5spmZokU3rd87FmYzlhKw=
 =
X-Received: by 2002:a05:622a:2995:b0:542:6a0a:eb7d with SMTP id
 d75a77b69052e-54e0cb68c5cmr58315931cf.0.1793994393771; 
 Fri, 06 Nov 2026 11:46:33 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ea867655esm25303246d6.37.2026.11.06.11.46.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 11:46:33 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Stephan Gerhold <stephan@gerhold.net>, Linus Walleij <linusw@kernel.org>,
 Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>, linux@analog.com,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH 4/6] usb: musb-new: omap2430: Free the controller if the host
 probe fails
Date: Fri,  6 Nov 2026 14:45:56 -0500
Message-ID: <20261106194621.510146-5-oss.patchbox@gmail.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In host mode, omap2430_musb_probe() allocates the struct musb with
musb_init_controller() and returns the error when musb_lowlevel_init()
fails, for example when no device is connected. The struct musb is not
freed on this path, and the driver core then frees the private data that
holds the only pointer to it. Each 'usb reset', or 'usb start' after
'usb stop', probes the controller again and leaks another one.

Free the struct musb when musb_lowlevel_init() fails.

Fixes: 1a35526e1d54 ("usb: musb-new: omap2430: Enable DM_USB and OF support")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
Build-tested only, with omap3_evm_defconfig and CONFIG_USB_MUSB_HOST=y.

omap2430_musb_remove() does not free the struct musb either; that is
not changed here.

 drivers/usb/musb-new/omap2430.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/musb-new/omap2430.c b/drivers/usb/musb-new/omap2430.c
index c8c6bf0c84f..c5607fd388e 100644
--- a/drivers/usb/musb-new/omap2430.c
+++ b/drivers/usb/musb-new/omap2430.c
@@ -229,7 +229,11 @@ static int omap2430_musb_probe(struct udevice *dev)
 		if (!host->host)
 			return -EIO;
 
-		return musb_lowlevel_init(host);
+		ret = musb_lowlevel_init(host);
+		if (ret)
+			free(host->host);
+
+		return ret;
 	} else if (CONFIG_IS_ENABLED(DM_USB_GADGET)) {
 		struct musb_host_data *host = dev_get_priv(dev);
 
-- 
2.43.0

