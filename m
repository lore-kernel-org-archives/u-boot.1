Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E15660A260E
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 12:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kuCl/+BQ;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UivIm5Ff
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D0BBB6077A;
	Tue, 27 Oct 2026 12:39:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id doKVL54DhML3; Tue, 27 Oct 2026 12:39:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E5CF760773
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793104763;
	b=eoH4p/ELKEVH6C/T2f29T03YbDkTOQ9Ujcpy0nCC2vn7ccYgPOHswReVaLC/dJHBdlfT
	 8WilFaQ1Ca+9AY3voJvEShgQJWMfOYdFU6zWAniVuHw5FWqNmPXvvsBLLcAJL0FsrO+8r
	 imwceTlz9u/X+uBUXfdlkFpwxMC/D7jdfRitBSsCN4YDHEW1bY76u2Sjl0Z/slaVtZZQ9
	 TWfxK9uByMRvmoSoD0f9WNNDpeG0y0iethiFKp09zUdiSaR5OoCtUMY8PhOAEX1zcJmS6
	 SVsKj0RQJbzGumgy6UoKwcWVMmdXJRj3RW8QVRqK//+XZwvLPWd0ieMbIcIswjgbQkQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793104763;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=49z1Af228wUJfE72u/4TpY9HRj2zeaMGbeN36e0kTe0=;
	b=gnvrirMrwTLcRekpo4Vt1T8N2PPf9Ec0bpy3YNKevMm5FPELLezBnmgkUnn4ZzfoT48+
	 4nnEQSinKBxDJYI7JrnN0dxZYOycsYM+yMWFyGOdlgS91z/9qD7b+K349gb5aMFGKDoxV
	 ZsUCuOv680dPEnPNKBnuEiMB58+J25aYsvbmewOrSfMz+mGyzeQNph6rEkgThFm+RFwZ3
	 Ye3e8T7y6kMH8fkAuJ0rx7ukfIFyoG/lKmNjHaO7+6x9sP9Gxzni/Z0JqyXAIBMDD1xgi
	 4wMcO4TGQ2BokdOWG+wH+/4/mSiwOqprebQTUrqSkLAQaJSpwslP0dxE8rmXbXv27Rw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793104763;
	bh=49z1Af228wUJfE72u/4TpY9HRj2zeaMGbeN36e0kTe0=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kuCl/+BQ2TRua2ufBpIjUZyHnfv0o8QZe03bYwDB75g/sgYoR5gyfJ1DpE2vKZw5O
	 1EFwoct6CNchU/GNWBFKT73h2fzeC8r1jqFUAth8HDKoIOmV60QX08V4VEb/yRJulE
	 ZDYxIqs6315jqaVP+F8DusQn/0cZYfldfNZgXv0OSraHx9+Nyvroe9hPIykUFLjoNe
	 jsv/7fJFpNoxSTgVLBmyUrMOLfYnMotFCmFInSqtL7pIh55E5pGs2/7r7IYJC5m9QR
	 /TNPMp2h5esX4iYjmu5HzZ5OHwloS5gnI75VNr1u0RxrcyoJzADx6O8cDgw5WmXet9
	 NhjjP9r8qzFsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E5CF760773;
	Tue, 27 Oct 2026 12:39:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CA8204BC
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:39:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BCEB44060C
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:39:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ju4iaapvVGR5 for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 12:39:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D7E414059B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793104759;
 b=eMVEIMeynmjcc6kXah1b3YmRdXgJpk78OevgR7qO20VQX9h0UjvXlCzaK86Ad2vkkwi2
 vu2uQPFfJXySFeYyUJFlGH2nab7RBw/qO63GppxORzK/P6yMyDjSoPUBFF1DwVBwNOemL
 YfxEJhqXuoM5VUAvFVwJ1z6PPPMIKQ4c4T7U5lphbvAxoIuF0h4r8tgP81MYouuytpaJ5
 ttp/W2GUpcfhuP/Bb2+BFVs3oL6Hp/HgM6QmAQTDfGSIe/mgDcW5BecohMnULLXrk4Q9z
 vwOnSnCBqNh9S3C/FhG2xZnp1SWHnYLM8C/1/VIA5EK1KDPFGIQI6faSkbei8gOJZew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793104759;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=49z1Af228wUJfE72u/4TpY9HRj2zeaMGbeN36e0kTe0=;
 b=UMz3eiiXA5Jw7ZRrHawVa0KV5XKDGU0zF0yFA/ijH29jFcTJStAzD0iLpAyvtAlT3+6p
 GobeSOIdvkSLd+aOyegCCel1637/2W/zhEsW8Xk1P5jdsRUpeqf5pm8eJZDEzdESy2fhv
 DyDedc0PXNWOQgJp18t37OUBF91Yl7RAVKkOIfHyVrbAgoCaWAhGvCPqAKgvqZT3MXf4A
 zCS5HgVqtQOJkTrzOgj+cDJkF/tbYxgv6hCI9wH/a+ZOTtNWqDqaJie/KxLhqoyrfD+bl
 5tTZgc1Y9SFvBmeZCR4eGtp+YR8031eC1jKn9BXdQCMHEsgapu9wbJi925q1um9+UoA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=UivIm5Ff; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=UivIm5Ff
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D7E414059B
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:39:18 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48e00eee27dso2632880f8f.0
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 05:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793104756; x=1793709556;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=49z1Af228wUJfE72u/4TpY9HRj2zeaMGbeN36e0kTe0=;
 b=UivIm5Ff3IrH93C6aBV1wgs+zOHXmolt7j0qmhLaQ7DZB7H4bMF7GZ2DiHbQYFLQ3g
 tS7uWklNbTwRYqG/GWOjuzxDI4E5Q5Az3ipXslMbpw4/Z6W8ju4NNWy4hN6kJ3ecVhLR
 cugZDgUFlMUgqQtZ2hTYV4VvO7mnVIwqh+9KvmqGasYQ0MzWVgIyvvaVFoMs76YacBKd
 +rjGLNk5W+R9crYB1hIbrXvyMmOJro9FKsdfjWr75toxum/h6jwQx7fSMHM+iuM7X2xq
 d4Cr3yhh/M9V9zICLlNr+nrn/ABDCndhrzOKCAtXv7hldIEObH37nGvITazx1z7WYZs7
 YcAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793104756; x=1793709556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=49z1Af228wUJfE72u/4TpY9HRj2zeaMGbeN36e0kTe0=;
 b=zj1uEVwZUEa1/Zz4QkMk1XTkPGQg3cv3yHunLfaPhqeA1kLi0McROiN5AEx4g9fdeI
 FJSLMw4NTi1gm7Nvf2fxXtZpWSTg9y6WzOfLqNj39PlhOcLBIfgllqa7QRA9l9cBpJe7
 OoTME9zXGVgW5VCOUCvuTkmIIFB9K4fFsJAPjyGNilkEfPiFLjDPmXF1cwV/Ms/8CeYE
 dHQcuMBUUKg1PtmDfDA7zDSkF457AyDX/m1LjwxOCYUGyiTRalOSjPAqQdhHh8fCVsXf
 zew0Iq7kYvu4PLNc5BPsH0cA//tha1xhE9y7fi4hfrmJ1T74SX2TmxROhTGFolSmmk5E
 F/AA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx2I3vBlJVz9NqlAF3WjPvX5/WnwhqV/Uk0SamV9Z1gpWs5HozEYFVdf3tf8kM9pPlWedu3jSE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL9QbJCv2jrWXv4UKEOaPIqpxdOPqA6gAbWKocWPjW2xaqh+v9m
 Smh5A67c/59Sgli0XQ/tMLdWWSoem5qYsRbxTZcjc5TsXa2lg5ZotSEG
X-Gm-Gg: AYBFou3yA1DeJ2B+9jjwux9PSlnmwNFsFHJ4wlkfe4IQ3Nzjr0we2b7ocKxQ7UWtdBx
 nRciQ8PgzjcrEAy7kS3Mde37hL5nj7ZhnQmepIFxGTpbfauprOGcz76pk8HEdFeVzauowX6koic
 ujO/G6yUs961Nq/c6CCHheXjjudBThZ6WxK6RlsdIPa5Gds5Kkq0TZmDFlrWuXydxfl2qzo+EZl
 PG0V3KQMNettWAC7NZ2vl6oS+8nU+JaErj7h6WR8GwG/E3D2zawiqqSV4vwH6DvrzlTJX2COROZ
 GmtQjQbnjjthOnCRUiI4yZwd9QyeoNuZP2k19q6hfju6v8CeA7jf1U9czBVFrFiAs8jPrFWMSgW
 lJlFHfXvr5VOXlcySdawpWbJh7i03jhnzshSFDOFDiZNva5BEow500B9nnKUfXreUd4j1YoQ8NL
 Hd8XGygCXOAcnxAQ54Sljs5/IDdSQSs1jcqf+x6pfmp/zyIPIcrlF5hUoFSFvg7r+FnWcm7Xt2L
 ITp2oS//uI96RwT5OnvzKwdWedg0KUagwLzC6iVEHa8LNzDPc09W/9EEuE7c4s8J59SSrD7fcUT
 lyEpVWU3XzQQ3N8xvbzjVI3x+5Lrj+VYtmOVdKq/PHdedAHlTI0Smb0kEM71
X-Received: by 2002:a05:6000:46c3:b0:48d:fed0:ccbd with SMTP id
 ffacd0b85a97d-48e3eb93719mr11523266f8f.34.1793104756276; 
 Tue, 27 Oct 2026 05:39:16 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd8c05sm29142078f8f.49.2026.10.27.05.39.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 05:39:15 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>, Alexey Charkov <alchark@flipper.net>,
 Rasmus Villemoes <ravi@prevas.dk>, "Lucien.Jheng" <lucienzx159@gmail.com>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Neha Malcom Francis <n-francis@ti.com>, Yao Zi <me@ziyao.cc>,
 Peng Fan <peng.fan@nxp.com>, Martin Schwan <m.schwan@phytec.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org
Subject: [PATCH v11 1/8] misc: fs_loader: fix ubifs not unmounted on
 dev_get_priv error
Date: Tue, 27 Oct 2026 13:38:56 +0100
Message-ID: <20261027123905.839-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027123905.839-1-ansuelsmth@gmail.com>
References: <20261027123905.839-1-ansuelsmth@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When dev_get_priv errors out, the ubifs is not umounted (if used).

Correctly handle this handle condition and while at it also return -EINVAL
instead of -ENOMEM as a better error since no memory is allocated but is
actually an invalid scenario for fw_get_filesystem_firmware().

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
---
 drivers/misc/fs_loader.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
index 6af4c7f15e7b..cd4695b08eea 100644
--- a/drivers/misc/fs_loader.c
+++ b/drivers/misc/fs_loader.c
@@ -175,8 +175,10 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
 
 	struct firmware *firmwarep = dev_get_priv(dev);
 
-	if (!firmwarep)
-		return -ENOMEM;
+	if (!firmwarep) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	ret = fs_read(firmwarep->name, (ulong)map_to_sysmem(firmwarep->data),
 			firmwarep->offset, firmwarep->size, &actread);
-- 
2.55.0

