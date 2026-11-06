Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C31F606A329
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 21:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0S4+mD8B;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OMK5SUzh
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E341608A5;
	Fri,  6 Nov 2026 21:04:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kz14BeLg9alv; Fri,  6 Nov 2026 21:04:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F3B99608B7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793999060;
	b=jYZVCFTlnZrY+ufZHZtz+tjnzxwtTRToXWh0uQqw/9HvGyHJzKqZrfAs+NhkliReDhyp
	 U7nggjVG+CKZYNx7SyHoJvlxIw2GagvLuBGopphSulOGnsjUHT3AKR5/Q7ExdcYO6mdoC
	 43PZDvVgwOC+ZRTFf9ry7TG6RGbpfW4S0wcaZ7ajpDm9uE4hF0Q2KGdT4i04ETgeYfwY2
	 GxXunZqpmQenOIF1ai1Xm33erizNeYhZb5mzA1drEoownuNSdjCiYD4wA5t86j1rgU5EX
	 G2A8vxwcKutu9XCDXPAXcd+ZH6jAy214cFICUeevZyQBluuvf8Ii6blDlBmypVTQQmA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793999060;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cExLYqKV/EOAw53PzPWrXJjMbSWPzpKuChYVRLl/JmE=;
	b=jJiq9/NtAESzpYDrpf58fL477MTn79niVz+ZBsCfxfDH4UtQ894bhPQvVaD8AHY7T+lM
	 LNIzMYWrn6nTgz/+ZwXq82zDC2zMOc1dNTn4AHZHw7TO7gBYTOmlXOFll//Zzv+dbz+uW
	 t9zO0TCG7Fj6+JHrib+CD4teG29iYUfJn3ZLteAjlC5H06rBgbICA3HXVImKNmAI14y5B
	 8wRBu0qwU5CFV78V6JiZr2hL/RLfPrp+lqPmESizno6Z1GMUjUCTiI51ugoOu+yDdidJb
	 lX3LsQ9E6XofdQtZubsEqvo9trfb9mZ5DQUy4PsERIMJEtH19AJEfPq3TLlOmFALSiQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793999060;
	bh=cExLYqKV/EOAw53PzPWrXJjMbSWPzpKuChYVRLl/JmE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=0S4+mD8BgU9oFew01ILHuSbp4vhCGuAAtmtoCWcnqyKiCQ9qr5v5VrHdL9e7vFH7P
	 mRjRFrNt6ge/IBa28vXV9AxilLGRjCyEULb7+c1fYnk3JtLgiuYz6uyNhvkqQ/sK9I
	 Iz1hY7b7cCuWBgO5dcg0U0hiiSeydYZAqvOE2S4eu4u9l1kvDgBQv/mVJo226Cry42
	 hfrOqdCt+hZ645KPyY1NzrRBvbUCr31BNqwWu0g6KY2n25QFpeH9r6rO+Z345MEK2N
	 GpiP71hfdJLaQYCw/skkkcZWKqd4QvD4adsPSczAPlwHUGl8WztYYm3UO2BcygK5MA
	 X+Qu6cv38BJeg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F3B99608B7;
	Fri,  6 Nov 2026 21:04:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F13392AC
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:46:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E2A13407D0
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:46:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ycD0XInWw1pi for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 19:46:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2D8C940786
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f2c; helo=mail-qv1-xf2c.google.com;
 envelope-from=oss.patchbox@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=OMK5SUzh
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2D8C940786
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:46:27 +0000 (UTC)
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-91e7fc8265aso13924586d6.0
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 11:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793994386; x=1794599186;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cExLYqKV/EOAw53PzPWrXJjMbSWPzpKuChYVRLl/JmE=;
 b=OMK5SUzhFzjWjJsRgau3krdfQXrTMzRqOP2e42yTjJHoWvXD+aiufcrXoX2dEYAEuS
 61+MAn5bWqOLAxZhWFVWUWx4tday0h/Bf7w2W/UNSnFB01+Ir2Nqvo0yrZj6N4sXi2VY
 W2o5icMm4P9mPlbC7XCV2YTBKl/XZLmqBHy+76BDKwn0k1NyG1g1YDUXV3rCYCeiR26A
 z8cgeA1j/g9RpMskXjwnrnNyhYPlmI3xND6h4eikljXVTK5aHukuTiCMuKD7y+nLf9TV
 BIVmo8NNIto1CHjZJZdx6koSc1I3OaqlEZYNS2HjUDB+rvorVUEVryURU3kcBkrFyd6T
 A/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793994386; x=1794599186;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cExLYqKV/EOAw53PzPWrXJjMbSWPzpKuChYVRLl/JmE=;
 b=aBot69Q0aLFrssYZinkGzUjV4xBz9aAFNj/avkOgDCfpQtoG+0mH1JUedCA1lMHShU
 6jnzmMzDYGu1lGm0erkYC3fZbpQHpuM+tKtWACUqH5NdkK1P3VagunSihmLMxgd2BUos
 B49YImjNkU6IU4Eu3iNjX8xsSnGqLW6DJIWyRK89+eux4cXsHDfhZReNsEcRsVwLze/q
 NLNkv9p+9kdVOybKFfONZ+Or6pB8WgqACpFSY7Pnw3XNu3P+iMR/Cwanp0r5Tp3HSsOk
 DSY7SynQ4m1Y6xW1l3GVXc5paVDRSbetbMzmNAnpN7V+KGaKfKjigy3imH1knx+XYyPF
 vPWw==
X-Forwarded-Encrypted: i=1;
 AL+hErF+s3/MzqizsiuPPtySJGnHfpFg8RdmlW75P0thAUEfY8G4XeuJRTWTWqW5s5uzRe/hjWRIbNE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9geed1gtegr/yrouZE9gcSzzZ8wOgz+MlvTTcqST9WNZMha2XF
 49ZtIfwERaH+YoL9g+QD5648cG4hxjwyDQyP2NzesqYhB2X1W7c/py8j
X-Gm-Gg: AYBFou3eX8ye+C4NRCd9xHhaDDBYq8ALA4C1TamUfj8fm2tg9tFJm0CQE2rn2p+F/ce
 56ePgF4lgNOHvyFpOw9Los9Xa84MotU6GZKRDJT6FOgsAbAo2Fh4pcLDHu9OeaoUIw+oO7a/6AY
 qBUPzyKDmqO+lgiAjt4b/wxUBGegXDfMpk4xBkAyLYC1KqMmdBRDVbWul46o+diNGwGeB0A3oOy
 7eSSBbP9MFlCJiChPDqLYgns2KBGo0JxlO32HwLvi+S6FYYmQEhDdq/OYU3jaYr2JZShQ8NEfdA
 KtMeyisSxUsE1VvjVVSkAzLXCRk53vRDkIOxmIEZC/4z5wORkItyGqSBZ8Xb1W6rF4v1XUtSnsb
 dL+/haAtZ7Tr/0cSBlXez1Ae63/02R9n6gm0FYSkUfcxvS9I61XoBnYqdXYP6rYssaEor3D4aIY
 vEQNB01zAWDmJ29V57JHtuVaq8e+BcoU9ZdjD27pCiGt5NqM25utEjrkjlNy270CvXBMNQMzPnC
 iDf+HGfQceDqWu6xgPDdbsTgM6TCJtJK/k8OqQdmu85oYerNFyZU7FsQOjcItuhTx1ouBhsQ+LN
 tQ9QHqbDgT+Ef2tXz0e+AyS/MMH2L86ODsqUv0fMpVdaaumULAub
X-Received: by 2002:a05:6214:4187:b0:91e:86d8:a3f3 with SMTP id
 6a1803df08f44-91ea986445cmr51622956d6.52.1793994386187; 
 Fri, 06 Nov 2026 11:46:26 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ea867655esm25303246d6.37.2026.11.06.11.46.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 11:46:25 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Stephan Gerhold <stephan@gerhold.net>, Linus Walleij <linusw@kernel.org>,
 Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>, linux@analog.com,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH 0/6] usb: musb-new: Free the controller if the host probe fails
Date: Fri,  6 Nov 2026 14:45:52 -0500
Message-ID: <20261106194621.510146-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The MUSB glue drivers below allocate the struct musb with
musb_init_controller() in their host probe and return the error when
musb_lowlevel_init() fails, for example when no device is connected.
None of them frees the struct musb on that path, and the driver core
then frees the private data that holds the only pointer to it, so each
'usb reset', or 'usb start' after 'usb stop', leaks another one. This
series frees it in ux500, sc5xx, pic32, omap2430, ti-musb and da8xx.

The same fix for sunxi and mt85xx was sent as separate patches:
"usb: musb-new: sunxi: Free the controller if the host probe fails"
"usb: musb-new: mt85xx: Free the controller if the host probe fails"

The patches are independent of each other. They are build-tested only,
as noted in each patch, and pic32 is not built at all. None was tested
on hardware.

Yuho Choi (6):
  usb: musb-new: ux500: Free the controller if the host probe fails
  usb: musb-new: sc5xx: Free the controller if the host probe fails
  usb: musb-new: pic32: Free the controller if the host probe fails
  usb: musb-new: omap2430: Free the controller if the host probe fails
  usb: musb-new: ti-musb: Free the controller if the host probe fails
  usb: musb-new: da8xx: Free the controller if the host probe fails

 drivers/usb/musb-new/da8xx.c    | 2 ++
 drivers/usb/musb-new/omap2430.c | 6 +++++-
 drivers/usb/musb-new/pic32.c    | 2 ++
 drivers/usb/musb-new/sc5xx.c    | 2 ++
 drivers/usb/musb-new/ti-musb.c  | 2 ++
 drivers/usb/musb-new/ux500.c    | 6 +++++-
 6 files changed, 18 insertions(+), 2 deletions(-)


base-commit: feb8913982e4462c01fd914271f92254a25dc101
-- 
2.43.0

