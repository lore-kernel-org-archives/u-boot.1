Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F05C531F9
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 02:53:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 07F4D60648;
	Mon, 27 Jul 2026 02:53:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C5OdvA3JPTNx; Mon, 27 Jul 2026 02:52:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C1549605FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785120779;
	bh=ISQxPelVjBsL9zyAnT99Nj4VjpcWl/HTGDpc9IOqKYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mTOjI4lyEmRVPnqee8ZE0GVqatSjqDKss37Uv4l+v/9nyfC8QOT1pauhVGJ1VW28U
	 nV1u2Hd259GbsEShp02U38eC/nnM+fNHd9tvs5CRtLtfNLRMwUgbXtYRvbgJJDBFCY
	 UEttKyrZcMfqVkIQpRrfuIHmmzaC6CDVAeB3Huj5JCKr8bUpsFsWZyqs1pEcIuRE4M
	 TbxHfaAXf0+31JkdLozwalZ0x1Ix/FiQREMvlkqfc55TY9PDkjfGKQasMKcJ6Thegt
	 Hz+ArplTtPxsCTWDRFLNIB0lSg0PtsSMLQa0GGsbtHwRQ5VDjDKrmrl9xKlDfUCFCn
	 lFDX22Jp2s/Mg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C1549605FD;
	Mon, 27 Jul 2026 02:52:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C36004C4
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 00:33:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A907340042
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 00:33:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2xq6j_Otyxl9 for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 00:33:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=fugininsane@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org BA78C40015
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BA78C40015
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BA78C40015
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 00:33:44 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-47de008b020so1152774f8f.1
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 17:33:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785112422; x=1785717222;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ISQxPelVjBsL9zyAnT99Nj4VjpcWl/HTGDpc9IOqKYs=;
 b=oq2dsuJ68HGCMFENmAs2GHq7Yqq4YiP2NJHw/Ak3DCM0xF/0fLEtY8N9BG5F8Wz1or
 c0XWYH9RRa2Q+c2jYi06UkAPbwChfvgoXPvtxzCsd6wY4VHNtKZGzjwM0Kuz46tF9qTl
 Qlcb1oGvht4UUvHBjzjaLAV1TwSnA9KCQ/samViDg8LlgiLmLLiH/fBmoolcRi4ShvkP
 Ni5v4gvzDGt/WnwwvfYYQxkbxYvCRe+SEECfBR3CcUwGzjJEzM7B1lGEIFz0iEghVMR/
 3SByaf4Yc39Zeo+aMkjx70jjR4j+4HBZnzK3Y3gsvBpUcsO5csGg6YjTEprO/sPBjD9k
 wrUg==
X-Gm-Message-State: AOJu0YwdtwsGeKco8kdEWSESLU/mOxbkqaVIdKgNiTgba5Qr8YPHA5gK
 NMDqCpZBXeRimxcppegf+5oJGd00kzk/mVN6Lc3x9w3T49DwMIqrd6ce
X-Gm-Gg: AR+sD121GkgNHWyVquvLfGQsUIjC+6NCSZeDe859Df7cDLVG9DlY4e9rRd6P9dlhVGB
 WxsBKqCUAZDSfUM5SAf60eAcOSdXJF1G5dQuqrAvzGmenQP3Ptlg9yfWcbyKcJFdHJ3UeIOHPFy
 Eoi5eEYzkR8/Wfd4ERhowo10Tn2PzAAEQTakiS5J4nTpMN6KBNdDaREQ6ZSSN7gxEWAzz+QQSFn
 f3m+8SJ7RCR4201hYGy0eOV9NfcRCjKZvtrrG1KXhM0p/Og31cU7EzrEirgyWZPbru3enBmnvd4
 JQuDCFmGXUQK1OAQhAZNr6MSCvVRsKJVpxJfqHYZg4d17JaOMkxJaqUfOL2+Wjk2au4Dpo27Jo7
 Zg8TI4ujVKXm7hCdIYdJ0f56kguFGckDMi4nTNX1S5Qhcf25sKKiMFU6ff57T+zNMResrh8Z7Ie
 b9DlIh+UuIJ0YxE6ySDRNK5MDV
X-Received: by 2002:a05:6000:24c9:b0:47f:6fa4:58e6 with SMTP id
 ffacd0b85a97d-47f9d013c7fmr10821765f8f.28.1785112422271; 
 Sun, 26 Jul 2026 17:33:42 -0700 (PDT)
Received: from coolemuke.fritz.box ([2a00:6020:b320:1a00:af3e:e187:e9eb:2f12])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c66cebsm44707187f8f.30.2026.07.26.17.33.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 17:33:40 -0700 (PDT)
From: "=?UTF-8?q?S=C3=B6ren=20Hantel?=" <fugininsane@gmail.com>
X-Google-Original-From: =?UTF-8?q?S=C3=B6ren=20Hantel?=
 <fugininsane@googlemail.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.u-boot-project.org,
 Omar Ivan Fardjoume <ivan.fardjoume@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 =?UTF-8?q?S=C3=B6ren=20Hantel?= <fugininsane@googlemail.com>
Subject: Re: [PATCH] mmc: sunxi: Fix mod clock register offset for the A80
Date: Mon, 27 Jul 2026 02:32:27 +0200
Message-ID: <20260727003305.3347466-1-fugininsane@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727004106.47219647@ryzen.lan>
References: <20260722162126.2790195-1-fugininsane@googlemail.com>
 <20260727004106.47219647@ryzen.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 27 Jul 2026 02:52:58 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785112422; x=1785717222;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ISQxPelVjBsL9zyAnT99Nj4VjpcWl/HTGDpc9IOqKYs=;
 b=MUuPVz561XHClX3PunNXnV17+EY5BO+6o4uaMdarCTzIEdxItXduyVn863Shb3VmLw
 3i6sGrPNG+uQSo3LXisrAxqEkxy8OdJVEXl5u9T+7bMzj+L/DPfUYL54RBBIYvUV/P0m
 Zv78yYzyxMSvSW7ZbeJ3MpwZVytf/N9iqBpOpTxmkhE2GZOdkThC7uAFUUDXGI3dUKGH
 FTSMe+x0C8aGfyGBYU1TNoqpzyz5xGYrcRjfPwrcayOnA7zfRA7a0tLAgOn8INMwlyIZ
 FtqZ+MOkyaLVKz8+2hZEgLbqTSqv+jeNRg+Kk5n1+YG8T0RLQsD3IIDZYTdZPHCSKYM/
 5bKA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=MUuPVz56
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Andre,

no worries at all - what matters is that the fix is queued, the A80
users won't care whose patch it was. And nice to see the bug was
independently found twice, that's a good sign for the report.

Thanks for taking the time to look at it, and for the pointer to
Omar's patch.

There is indeed plenty left on the A80, so I will keep poking around.

Cheers,
Sören
