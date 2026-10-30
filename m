Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92715606A335
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 12:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=d1o73nfq;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wdOVf/JK
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F2A3A60668;
	Fri, 30 Oct 2026 12:59:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hCbzM9liIyQv; Fri, 30 Oct 2026 12:59:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EE73860ABA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793365185;
	b=gBXXlpurh1F6Oa1YAro4inMuNvO1F40E3pu6hHhVD9W+CYbzK/bFKcM0gB4a3DkC9//9
	 IrxVfR/PoEWVs3LW8TiGm/JkNUWmH8MQ/37VWgtDw4fW3dR2bmdgwZzaChU3YVxBmjxnG
	 Uo1wFZ5WOljBYzk+LlhUCxSf+9uinw1Us/WiQCfzHTsax1LPwn+PixB3RZOLTNMvBaNh1
	 ifPJ+40xr8nDhl6g9EKWNV+ZOAXFizpT1BnV1csm7wcpz4XtQKAxFtqXARzl2uKEmk4wZ
	 y4TF+pUf5peD34R/Cbfw8PLY7WEG+jb8zOn9m5C7HXmzYAznOoQXesJ0jJWSPJgRbOA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793365185;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GcJuxTvnNkJygq2Abl2NL5YQ6B8YJO1JHQJFmb8MaeQ=;
	b=Hr3H57UfN64lwgFkJ2f9VlfJDOUydQwGonaAcuXwiH1qJnPeKO0nxtoOPBiUFZe1O/8/
	 ifk4F9fy7ZwtKCFh4u0OGAu2sagCdyEchmOwc7YYrIHy7s2GZdtgThYGyD008ZGYG3VAj
	 2XyePAJL0JjrTJYm3pWO+weYEREHNWbOnzjS9bcAUv+P9jonZSOUCx/Yt9FmJg7fOZbd9
	 iQzfujgYWMcuIQ2Vp/IHGhvO4/+9tLsiWjtbiZdU2tMtXdkDx6WyTZtEww30+wujhX6b4
	 xklVdd69gDIiZ+vh5Qf2/z3PVXUk0QqF/XCS9K49BdQS1JF0PYUXNimmrhZnh2RiDuw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="wdOVf/JK";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793365185;
	bh=GcJuxTvnNkJygq2Abl2NL5YQ6B8YJO1JHQJFmb8MaeQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=d1o73nfq8NOkc50J0T2R9piBXmEvQFcOYu7kTBQMVXTqu4uJcKGdFnjC4MXfFPpM5
	 gdBxh9VsyNmz5g665E4MsOCznMDkUz42OERG2Sc5YrYkFpgSOPgixNcFfekgmuXF+u
	 DAxJ8K9v4GjTt2+YW3CDaXSyDze0eht6/a/ot1JhurFFUIV79+GtlFoHpThtErmASw
	 FHpnl+MfBgmMGNvrmMjq41NUqpX0Lo5N3P79OTMllL5O3xx34XzU6mEcuTdEQG+Maf
	 oq30XB5f0y4p6/rEx5VdWO+uZycTuunJjx2Gia7JV9r9nD5W6DxDnX+EvTdtyvkQLD
	 cFvFLlw6doIfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE73860ABA;
	Fri, 30 Oct 2026 12:59:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A9F0D712
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:37:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8E7C7606B0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:37:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WduQQZaupoH1 for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 07:37:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A8E8D60667
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793345836;
 b=X6+da5436Vf4Pdf6xv9wp0nTLjbKu6qOf8FUChMH2OlyvkEoS9mf4zV0sGtUG9lSYq+O
 5Dxcadgxb8AONdhaHsjzN7DghPfq+zP+v2iqnVnbIrxmWMPaE5kEltTMolZv6ca/dO8Ox
 Y9X+DqOSYQaM7VIW4HO3/DLCQeknbauArZ9BFs6pYfnT7OsxG+uyTlRFBlU+x0UG7Rxsx
 5e37cCW2dJsdzqZdNbfOhNzYyiv5h4srcWcZUlfHqhBNTcItWDfoAO+2dS4rcuEcOv+CC
 +xIxS3hwcVgIqA/szwjLsu3YSZe0HefKZbkPGkuCvh8M46gigXBjE3v9ZLxpC9RszDw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793345836;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=GcJuxTvnNkJygq2Abl2NL5YQ6B8YJO1JHQJFmb8MaeQ=;
 b=MBxM/FLO3zH7rbjXtmq/iBYk2KUHb40JJ9l1ohcKcqrkJyMQlPIkA3PSW5ZztMI47Ywe
 bIwSj2CJupLqsTlTaJ8EAdwpJU1CELCPez3/UNcK1z+aI3iG1YXzAZjQz7kZTamA7ZGc6
 tG+dsrwW3BsFxiAnSGxQf4tDdgyctQUMwVMF+rTTMuejY+Q1EUvucz3s4aYANQwuN16PK
 83JdKVWAd/A12JE39PMepOfbxn7Z/7Ox6tAq4IMRZ7MuV3hO4PBjBLFVFYYzV3HyrlOU0
 nEQ7Url+1ervJRrCWhN8WOHXs+/m7Mqfcu6HJz2quJBTtYE5ugW4YofWcpiivl0GjiA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b="wdOVf/JK"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com;
 envelope-from=ylcncn@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=wdOVf/JK
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A8E8D60667
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:37:14 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48b001cd92bso203573f8f.2
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 00:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793345833; x=1793950633;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GcJuxTvnNkJygq2Abl2NL5YQ6B8YJO1JHQJFmb8MaeQ=;
 b=wdOVf/JK9FKEHHqU3MQPxvuInyzz8NTvqVjgpjYqtZcPpokyeqceovr0XYfUeeMYwJ
 gEwPQSEbzN8lig4fkGTgBv9swzmh7mRjxchmpyk1ftqrd8bPREVqqu++mHlYVWesdy5+
 e1SI1XrDmKoawltULqG1oPByaDjWEy4rwCK2WWrP3sfzCWifkCey6U2LYDtdwIQ4Y08j
 iFgrjILvwnG/k8g//S2LtH6GYXEi7UnXvj446/kOkLEqdSRN/RF5Id5ZF5wl0NTUokdc
 ftLmbPLZWFFUvB4CyT3T42jT6yWbOaIF7JNLD8GJdQQnMbwXNz3SOVMGBEVfTyswLCvz
 dKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793345833; x=1793950633;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GcJuxTvnNkJygq2Abl2NL5YQ6B8YJO1JHQJFmb8MaeQ=;
 b=fwqcXXk2cQZgeZtQtmas3UyGVX7o/eG4wfVMadvlGxLlm0quC4RwumJdA8sLohLWaT
 PqF8dpMbk4rl+P0fvVCI9DSpssZkkv7WtSACxyfsED5SVz9NubTQoHGWrYHJ6ZacckUz
 AGJHwn1IMkJCyePUZO8bpV0Q29zovp2mejjaFmLJBtrhl/5l4V9+Vm9u36SfUw5IVt/J
 HuyBMr+Fvt7jT5G3QAVeVuhVrCVXeasCUQ6Z152yLtJoNKqq99P0rV4sqElG2mG4pH2v
 Fdk4EhBYUuEEEhAqeuaXO9/8yuDha+Oru1YY9A9GwD3VjR0JYQbsavdV/wgR5xUJHxQ5
 HKfw==
X-Gm-Message-State: AFq9FYLnibMrOGn8eomZKwntAV5be+kLWANajQpd4xQyLgE+E608PZqF
 6XQMcyOtC+SQ93n6ao981zuUpeaEIt1zj7kGFDzhl3IPCEvlcDVm7xsYvVD3xT9naVc=
X-Gm-Gg: AYBFou20baS5tX5zu/sw//5/6gkkIiw1Wb0C/iDcaHVSPR84EtRmsV4UVLJte49CLDI
 WKYn/nzcrqIjuYgDO58DvAHY3wwmL0fIqGYJAF4NfV98JTYaGuTuTDkllpztzvLTKSlsNV1fuBF
 b2Mej3+BNHpR+Fs0ACPhHYC73h0YMR115wR8Ie37kwPlowmMFvy+5XR/GuaZPJCNw/zrs7IXaEV
 6p1oRaig2SLKNbuUAE1HJBgnsNhqvkIGboBEs+AQQbtJbwfUZSiKy3hLs9m+WZW2oY9c2l0ONL3
 g+e+JMcareR6xBf7+RS0W8w5LWpNWPXGkrqkdMgieQMB3jRm3GEA3aMvVR10DBkVNrZF7QX021Y
 X3ziXNLpCEohG4qco6LHiSAUAvak4A3fw+fplc0/adYhEpMr5t+n5RPbgKiyAySfA/CxYlbjTsl
 hkrtLW2IXhYlhSajjDxClr278hqR344ATryOrt6Ekbya8N0b1xCUQp0FSLSXO6ptks0ayoLwDS7
 GcWhGxNFdWhdklxJG8h4IlpbU6bUMOVjiUaB55mDVswJvvTgIxxFzqYwv0sNDVcXC+TbtyW0hw9
 vMgwoIQcayeU6wufXTflBE+yH2IBpqAvrCRrF7Qwh8udv7573p/SD5k=
X-Received: by 2002:a05:6000:2c0f:b0:48b:68:594a with SMTP id
 ffacd0b85a97d-48e6e2e7798mr3357532f8f.12.1793345832914; 
 Fri, 30 Oct 2026 00:37:12 -0700 (PDT)
Received: from thinkpad.hgw.local ([159.146.110.109])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71baa1b3sm1668000f8f.56.2026.10.30.00.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 00:37:12 -0700 (PDT)
From: =?UTF-8?q?Yal=C3=A7=C4=B1n=20Can?= <ylcncn@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Kever Yang <kever.yang@rock-chips.com>, Quentin Schulz <u-boot@0leil.net>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] mtd: rawnand: rockchip_nfc: set mtd->dev instead of writing
 through NULL
Date: Fri, 30 Oct 2026 10:37:05 +0300
Message-ID: <20261030073705.164572-1-ylcncn@gmail.com>
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

rk_nfc_nand_chip_init() does `mtd->dev->parent = dev`, taken from Linux,
where the device is embedded in struct mtd_info. In U-Boot mtd->dev is a
pointer and still NULL at this point, so this writes dev to address 0x18.

Harmless while address 0 is RAM; on the RK3066 started from the boot ROM it
is the ROM, and the write ends in an asynchronous external abort.

Set mtd->dev to the controller device instead, as other raw NAND drivers
do.

Tested on an MK808B (RK3066) from the NAND ID blocks (H27UCG8T2BTR).

Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>
Signed-off-by: Yalçın Can <ylcncn@gmail.com>
---
 drivers/mtd/nand/raw/rockchip_nfc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/rockchip_nfc.c b/drivers/mtd/nand/raw/rockchip_nfc.c
index d23a651f..c134045d 100644
--- a/drivers/mtd/nand/raw/rockchip_nfc.c
+++ b/drivers/mtd/nand/raw/rockchip_nfc.c
@@ -948,7 +948,12 @@ static int rk_nfc_nand_chip_init(ofnode node, struct rk_nfc *nfc, int devnum)
 
 	mtd = nand_to_mtd(chip);
 	mtd->owner = THIS_MODULE;
-	mtd->dev->parent = dev;
+	/*
+	 * mtd->dev is still NULL here: `mtd->dev->parent = dev` (from Linux, where dev is embedded)
+	 * wrote to address 0x18. Harmless only while 0 is RAM; on RK3066 started from the boot ROM
+	 * (soc_remap = 0) it is the ROM, and the write ends in an asynchronous external abort.
+	 */
+	mtd->dev = dev;
 
 	nand_set_controller_data(chip, nfc);
 
-- 
2.47.3

