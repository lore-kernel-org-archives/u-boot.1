Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 181ECFEE4F7
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 20:22:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D05D83F8F;
	Sat, 28 Feb 2026 21:20:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="F8WG2K1K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A72183F9B; Sat, 28 Feb 2026 21:20:52 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C86F83CDF
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 21:20:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d596ab0917so1355325a34.1
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 12:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772310048; x=1772914848; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B06FIsJ0OkggQ7iQ0jXWlVAKo2U8JetevJa6foi79nM=;
 b=F8WG2K1KNsxVFCIPTLTJ7JsK0/fGJM5mfBi4y1HF1zldLqP/pty0+d/Zhv6KjtQjT/
 7eUXfvntxi7emLZst1BwbTadPCmQShR/JSYPmsOx+pUWXU60dyr/tjybotPqsXaKt08B
 NizlFUB3B4774MMBAzTzM0FrYLhVZS4Kl7Xxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772310048; x=1772914848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B06FIsJ0OkggQ7iQ0jXWlVAKo2U8JetevJa6foi79nM=;
 b=xQ2BvgEeCZiULxvjanijvsVdAj8LIntAbB2vNValhwnCuojrF++mMT6MPF7Y19iPw+
 Wqs09v9EzoX8GEVduRjKrkv/ZyjkXR8Tu1y774u/cZvUNvodIMOJ+ljEjVht9xH0NoBh
 eQSwRVu4aEwktRLUelzAJwMN9pu5PhniycTFQrrQDU8m8zk4fs++bW8gL2LUmO8XOXxW
 OFrsJk4S0hbkBYIDvNf6/0HeBdAlIAJGjWT5JCQW7mE3d1fFKyZQdHA1+JbTZGROyi6W
 TCpF3y8Ymz5ZWNL96uimNzKn9A+KSCkx6P/6cdb5iede57wldsV++K/iI1yqmIVqADgm
 Gm4g==
X-Gm-Message-State: AOJu0YzUisqXXA2VmQem//78xVSI06k5YxplH3d9ZEgixDoLKREwAatw
 gCZjM2JY80g2a0ZwPFnqUuzQn2RFFPgkE9Fdrd0accbxKGxYBXYVTlympjjRUnHuah/pC6rhdch
 Hup0=
X-Gm-Gg: ATEYQzx9TK2oTSBF2w6s6n9u0/AzW1mAbvuWHOQWWQzwiGqeI2EwZiVuYG6axxOKd4O
 IV8XqhkS4ipYAvhffW+JB+s20je8KsL+gVowfurkkwSGYragv0du0HKXz0SQRe01KD/5wsXRIur
 6leo2pmFWXzwLoOTfa5nRrYSKo53rJ5AjDdygWlRVTje3qKhljOB59I+gLXdsOBvNhq1MPrsGCr
 27EH+MZJhv6Tmv/xXM7S9MHuuXGo3oaXGbu9W6nxAyEPWnIqThqzwMmP/6a0SlvQX0seqBA/iy9
 06kR/s7sBYOJddDSNVVDia+WAnh2rW3au2xbHTBewhsoG3dzUW5+BSsV0Wtqp7gH15OrMgW5x0G
 +j6IFkyZkRDV6VLYFEe5J6KeXEHcgysk+vVfSiBKa2tDdkr1n3R5DDJ83XYA3iTSsCm71snw3WC
 9LCaW/HPPfuetHcrhocg==
X-Received: by 2002:a05:6830:264f:b0:7d1:89b9:9205 with SMTP id
 46e09a7af769-7d5856c012fmr7240176a34.3.1772310047770; 
 Sat, 28 Feb 2026 12:20:47 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d58644edfbsm6978361a34.6.2026.02.28.12.20.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 12:20:46 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Scott McNutt <smcnutt@psyent.com>, Thomas Chou <thomas@wytron.com.tw>,
 Yao Zi <me@ziyao.cc>
Subject: [PATCH v3 14/17] nios2: Call bootm_final()
Date: Sat, 28 Feb 2026 13:20:02 -0700
Message-ID: <20260228202011.1834493-15-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260228202011.1834493-1-sjg@chromium.org>
References: <20260228202011.1834493-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Simon Glass <simon.glass@canonical.com>

Add a call to bootm_final() before jumping to the kernel. This adds
the "Starting kernel" message, bootstage tracking,
board_quiesce_devices() and dm_remove_devices_active() which were not
previously called on Nios2.

Signed-off-by: Simon Glass <simon.glass@canonical.com>

---

Changes in v3:
- Add new patch for Nios2 conversion

 arch/nios2/lib/bootm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/nios2/lib/bootm.c b/arch/nios2/lib/bootm.c
index 294ebfb508b..6004e83bf0c 100644
--- a/arch/nios2/lib/bootm.c
+++ b/arch/nios2/lib/bootm.c
@@ -41,6 +41,8 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 	if ((flag != 0) && (flag != BOOTM_STATE_OS_GO))
 		return 1;
 
+	bootm_final(0);
+
 	/* flushes data and instruction caches before calling the kernel */
 	disable_interrupts();
 	flush_dcache_all();
-- 
2.43.0

