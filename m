Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E82260A380E
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 12:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=H51d/SEK;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=DmSyB3St
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D434081D68;
	Fri, 13 Nov 2026 12:00:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RpA2giJ4peAu; Fri, 13 Nov 2026 12:00:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D08E781C26
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794571243;
	b=QEAdJgjybmMx72jDSQaSCyR6VHiUoP+qv9rPe4e7yJOnLs/vnwoearLNmeN/qOrz/d3l
	 Yx3SxNRunLtxz4O8HrR5iUsru0dkeF1mp8RySzOLb0Gm08eHuis4AOpHi4NhDuHXlwd7V
	 ji85jO+3j4+yesQKR+DQp9PMPbG1KoLBOgF3zlt+6r/YDZ8Ge7jb1Vs4WjrIbFBimJ060
	 vJig7arcvNC1dVvZhDJ9rzJUXbZlcP44qiifn4xcK9TowekUmbxTUXzOMF8EboZl4kQq8
	 S/euR3SkXYeED3oB3Muf644X0IzhV8k166p+4ezE2Ac4BeACidkdTLjHBUIu9gw7Ojg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794571243;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=DoGfTr+UWdJEkdLQDc1Ow8K9m7YRuaANuSKjJPWSWR0=;
	b=ZH3xlboes27BHbfUoZ2Ytv+EfGgmJfqAmlQVzkAlQ5adzqCC/NYJsSFv57hM1mRrkeb/
	 zxDGrBtk2PWJoEXVYr8j+hVPfiOfRqR48cHazckoOrFNzbj8/PaVLqy3bnT3hoD4z4X9r
	 509sepp+21/hv7h+s5tyJ74N/oWgubc4DdS3PzJApeQDXhda7aSIm4u8t4ycFlvg7W5MG
	 WuMkg9aTpX/M1VP+KO6XJpwS+ekIsc+2D1SwmeUrpZc5qq0gVr0splqZ+M+K2B+7aVJ8k
	 Sy0XTpGD0Pj0ZATZwrB5iiyHFmaMqtskXciw+kCJV7MWXO/NvbrVt8UvezyghacEsYw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794571243;
	bh=DoGfTr+UWdJEkdLQDc1Ow8K9m7YRuaANuSKjJPWSWR0=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=H51d/SEKOR5pxs4lXzxudY/gaSZo0CYKjVS7oy7G5Ya2E/FLdesJ7d5t2KFRftDwD
	 bSPXdi/FEMMFQEQgPEkyLjwfXT2OovcidOR6KblpiM8rydbqppl6HzonPcxgB+KTQC
	 5FfqEN9oiuJmpz4WUS19R5+BJGbyrvd8TceZcGhFxhYsbqtvP9TCDLBpny2P8Bwoxi
	 ffzKRvBVkCXGDkm31g+kS7ZPf36cAnb6Lg+a2oqQVXnt8aoNnoAdaejSWyELppucWe
	 igUbGI02yGMcy9+XLQzdMfMBSRaFenqBmwFSgQbaYpA4d/5DsWuW2FGyxqt3TTqgcN
	 jFlK0aFBWm7Zg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D08E781C26;
	Fri, 13 Nov 2026 12:00:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2C2A02FE
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 12:00:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1E0D7404FF
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 12:00:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pJy6kxmxOMMb for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 12:00:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0F3A340519
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=DmSyB3St
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0F3A340519
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 12:00:39 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a2167bd087so5810285e9.3
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 04:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1794571237; x=1795176037;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DoGfTr+UWdJEkdLQDc1Ow8K9m7YRuaANuSKjJPWSWR0=;
 b=DmSyB3Stgu0fjoYagJmzIY03iSRSshYbSBmN8ANy++1Dsk55AlVv5fTN/X7ED0lrdS
 gVEk7uMcuhE9zqmwsxdftbNZjMrdVozKFp0EVn6kYW/Whk8ZSDe60+/mFj4juP8aqmkh
 fi2iGs8MlDU/7g3fA3NGezwEI8ygiPlITK1xxDdpsgiltI8byfwiLWEVsaQaFAwdceUm
 370raAEtxY5LJ6mxU0B3p7tMwwh47nstsy60KZF+WfvOTpFJYC3kKJ+l0FvDadd9+Wky
 qEpvq+1ZYzEyWRGWpC5nlgZNiM9hS4YpD098WHC/AC/JsDAOqKvsgG9vwfzc5Kb+teLq
 iH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794571237; x=1795176037;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DoGfTr+UWdJEkdLQDc1Ow8K9m7YRuaANuSKjJPWSWR0=;
 b=yaZxOnjvnRJc4qRiJjq0ogSqV0kC6fWdtsp3RlMamqKwMOrcOYMWEabX6OZ0u2jvs1
 AgbSc36R++zcQumUaQNQ4lIoNYOqaObdUJo3ihQARx8UEezh9meN0Cqz14ZQZPGJLiKE
 6bKkfyTfvmwGWgEh8kxt2AtwNIRsV1nBm9nux6nL5tx2eySxq5WXOjhh2EdA66Qn144p
 aEka/FEFFOkAyLMg4cSSPEmNh+gz+hpfRV0OV2YImG4YmBJgTTzYrTRHFcSf4RFWGbFw
 UvJzhYGUfVPe9dxc/OBExXIycEP0eX1+fQkuYFoHSeNOCvso5zF4vxROM7uESAHgwnaO
 0hNQ==
X-Forwarded-Encrypted: i=1;
 AL+hErE6sWEbLMeXnt3ZpRhiqOWXb+e/qxq2sOkcIAiMPDDYSWlQDvTDuMI3idTjp7RtbehPZ/X91QI=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+Ag61Y6N5oFXp96TsYk91WJH7fGaYxLaWRm4xUrlIOTzwnI3L5
 XdWKYmcQaYyS/g3s1hnF2YyTLgVENB0F83LtOsHaYvNIIxq6NffA6IJBWtFLqVU017Y=
X-Gm-Gg: AYBFou2Cv0PPw2aOMOS9yuQOIlOnOUhGV6sfiFeALx2A+UzUhU0iq3de3UQDXuJec0V
 duYZczfk72mk9YuynIbjJduHaPoVmme6TVJ0I6OBG3VnjIKabjwPV+nU9Zbe+BySrKpXoFNcky5
 p2De2LUr6lze5HGcENE3K4DOH42XDelXe0gtNnCmZQyWn8dvK1srcK6CGPuZoAUXXTqV0r6Ff1b
 VQQB8yw4g13SuhyyEOV1yIlqsLZNkCGlm8zjBa/J5Owi+5rsgRum+Xy3fEHepsoyxEfHZgnA7m9
 dZtA0AdPSxK3hU84urAPCRVSbk+5XaivOUnjwOo0RMCatJiUKE1Pl9luVM+9tmKapmLfSl6rT8w
 FoKiEPWPZkWjJd5T8gcO9D61ecXNOq/VnqqLe/jf7Fm1GiKQnPdMVF4jWc0c8hzm3E+EckesSwp
 QZobvy4gzezSiXnubHXJ7+cRdZCOlcz5IANQ8uMij1MHi3z5S2F61m2K6S+tcNfo3J3K1gqu9/P
 fmcXaC15/960X6RfSeFietqJFa5uOgOZafjwNM4molemaSzPtBy8qAVDsBVlqIfLv+EjvK/on2q
 +U2PsW2agIFGagP0NG2KFSkXbYgRACC8hV0SBf7sCY6U8XjaESRFHWgG0QVb0c/JVbZXoUQ=
X-Received: by 2002:a05:600c:890d:b0:4bb:5c97:f4b1 with SMTP id
 5b1f17b1804b1-4bb5c97f545mr8723985e9.24.1794571236869; 
 Fri, 13 Nov 2026 04:00:36 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae.
 [86.98.194.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55ac1159sm52314195e9.4.2026.11.13.04.00.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 04:00:35 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH 0/3] nvme: Fix command timeouts
Date: Fri, 13 Nov 2026 16:00:14 +0400
Message-Id: <20261113-nvme-fixes-v1-0-a181c72f40e7@flipper.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0Nj3byy3FTdtMyK1GJdSyODFIO0lLRUIwtLJaCGgqJUsARQfXQshF9
 cmpSVmlwCMkGpthYAgCbTaG4AAAA=
X-Change-ID: 20261113-nvme-fixes-920d0fdfe289
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.u-boot-project.org, 
 Zhikang Zhang <zhikang.zhang@nxp.com>, Wenbin Song <wenbin.song@nxp.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Prashant Kamble <prashant.kamble223@gmail.com>, Torsten Duwe <duwe@suse.de>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1710; i=alchark@flipper.net;
 h=from:subject:message-id; bh=poL9PA3Xg0dc07nCnQGydJTBrikxBPF7ByiGAJRe+XI=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWR9+33zfMu3Lo34wO92DPbdW+ZfneU854Ll4pcnjG5ti
 Ll0yOG5dMdEFgYxLgZLMUWWud+W2E414pu1y8PjK8wcViaQIdIiDQxAwMLAl5uYV2qkY6Rnqm2o
 Z2ikY6xjxMDFKQBTfa+YkaFxlbuF8S6Ryokf+HbYd705G3b5W3Rs9pI1L0omvIr7sIOf4a/o5f7
 9jUeZz5tcnV721Hfzp4h3f2d9f7MzZkqJebMdJwcPAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A Rock 5B with a Kingston NV-series disk does not boot from it, because
the disk takes up to 3.2s to complete its first read after power-on.

The driver means to wait 30s for I/O commands, as Linux does, but
scales the timeout by tenths of a second, so it gives up after 3s and
the GPT probe fails. The completion then posted for the timed-out read
is mistaken for the completion of the next command, the DOS probe of the
same sector, which then sees the protective MBR and records the disk as
a single DOS partition of type 0xee. From then on, every command gets the
completion of the one before it.

The first patch makes the timeouts the seconds they were meant to be.
The second moves consuming a completion queue entry into a helper,
which the third then uses to discard a late completion instead of
handing it to the next command, so a command that does time out no
longer desynchronises the queue.

Tested on a Rock 5B: with this series applied, the disk is detected as
GPT and the EFI bootflow boots from it.

CI for this series: https://git.u-boot-project.org/u-boot/contributors/alchark/u-boot/-/pipelines/2016

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Alexey Charkov (3):
      nvme: Wait for commands in seconds, not tenths of seconds
      nvme: Consume completion queue entries in one place
      nvme: Drop late completions of commands that timed out

 drivers/nvme/nvme.c | 59 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 24 deletions(-)
---
base-commit: ff8a9bc41e4e5bdd3406932af5abb4c18064e539
change-id: 20261113-nvme-fixes-920d0fdfe289

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

