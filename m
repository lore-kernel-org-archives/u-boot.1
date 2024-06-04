Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B84DC25B78
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 22:53:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 265A3881C3;
	Wed,  5 Jun 2024 00:53:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZFoYEY5D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AE78881A2; Wed,  5 Jun 2024 00:53:47 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DA8A8813F
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 00:53:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wjq.sec@gmail.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2507fa7f37aso867406fac.1
 for <u-boot@lists.denx.de>; Tue, 04 Jun 2024 15:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717541624; x=1718146424; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=dB4pnyncK9baApFbkeHwS2u8NHLADiR7JUjsQ+IkQ6k=;
 b=ZFoYEY5DPfki0qdQL8jDMxRis6XQVsfzqklZvoQw3dPasCM8oXcCyUc45c7+pA3m/r
 ZPQK0YzurY3TipKqKlvV1LSKeZBjmn8vQnsa2Gj9sC77pVw23bKXzF7f9qQyGsLHRsv0
 d6o/VeLEv5FrAu50UcHhTqR0Ht5WOZmd47uj0mYQhmAc4SzhdDDZzVVvVowaPlyaxVhY
 m/seJhI18/hQ7vbuMn6Eq5iBOob94pOBgNEgplaqdjZaF1sGmTTNKVAboKg6IwCteNcT
 H+EUquDeHn8DXo+1Etr3uQ8L9Fx+YzgZEpQsCE14F2+ymL0veuqvLfIQ8pyhjZ6mFlfp
 XrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717541624; x=1718146424;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dB4pnyncK9baApFbkeHwS2u8NHLADiR7JUjsQ+IkQ6k=;
 b=RpdYezC8gH3r0bhEZVwA17IzijlYfXP75mTLzn3OG8ihUAV+UmMgD85jYbrPzMjYq9
 M2aX/Z56h9DxvRetHVKvHItF9H2cW0R2HoK2mUyJz09W0uDKjeCFgWZGMrd/oGSQo5A8
 nGh7RbmCPAGQKhxpGAVI05rCogrBPRrHRjdnYAFun6rEXp+5YTLoKd+EfxFkpBVWJgOa
 qSlbbYb8QFmZO45yRR6sIQYDR4Zo4Zpvs2aD75ONOKurnxSpPfNRDXz/FhS9s3Hm3tRF
 Qj0VPMugUcQreqVV6uDZMdsIkf+9VCNqpI4frsFQxioB2lTzOvtPePJJv0P8/6DQgcrI
 Gbag==
X-Gm-Message-State: AOJu0Yzs4IKLPzmQ+Z2YLjfxYjQuYKEVtnRg+w0gbS4HbR3uXaibdLwC
 iEdyOvDSXDQD3yEUAq9oLPteOdh8uJZhA+rgbH3Uf/1LDgGgMjg2+bRcvflgG6zezUMcuuQ3eQz
 MItNvkzqgPO7psqpkaCkN4tw0UVPVBZX4
X-Google-Smtp-Source: AGHT+IF9E7qUfQRI9r/4P3aiM2RmapkwWuR0Llwu3V6d2/QZ8eO+ReAS2lzjeHk51ksZDbJg1VijxQBUW99rfyRnjPM=
X-Received: by 2002:a05:6871:5b0c:b0:24f:caa1:3515 with SMTP id
 586e51a60fabf-25121e65b47mr1071990fac.35.1717541623880; Tue, 04 Jun 2024
 15:53:43 -0700 (PDT)
MIME-Version: 1.0
From: jianqiang wang <wjq.sec@gmail.com>
Date: Wed, 5 Jun 2024 00:53:33 +0200
Message-ID: <CAMn3X6NjqGmCeVT-X_d_btDKQQJDzz7CnTzOb=62np75VumhDg@mail.gmail.com>
Subject: Several potential vulnerabilities in the filesystem
To: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Das U-Boot developers,

I found several vulnerabilities in the u-boot filesysetm implementation,

1. in file fs/squashfs/sqfs_inode.c function sqfs_inode_size. The
parameter blk_size is directly or indirectly from the storage data.
Howver, without a sanity check, this value is directly used in the
division operations, leading to a division-by-zero exception

2. in file fs/erofs/data.c, function z_erofs_read_one_data, the node
data is read from the storage, however, without a proper check, the
data can be corrupted. For example, the inode data is used in function
z_erofs_read_data, map.m_llen will be calculated to a very large
value, which means the length variable will be very large. It will
cause a large memory clear with memset(buffer + end - offset, 0,
length);

3. in file fs/squashfs/sqfs.c, function sqfs_frag_lookup, the header
variable is read/calculated from the storage data, however, without a
proper check, memcpy(entries, metadata, SQFS_METADATA_SIZE(header));
will cause a buffer over write when header cannot correctly clear the
higher bits (SQFS_METADATA_SIZE(header)).

Could you please confirmware these vulnerabilities?

Best regards
