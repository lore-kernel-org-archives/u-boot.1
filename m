Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08621606A329
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 07:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YFGYC+J3;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pNA7qY8f
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CAA4E80DC1;
	Mon, 16 Nov 2026 07:13:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HIhT4Xfnl1W9; Mon, 16 Nov 2026 07:13:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 247D780DDC
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794813221;
	b=PYpyCSzipijNrCrTiBiqCqkv+REuF5vm9yjSCnY5uggwLC10WQwjMRqFPdgZYIi3Stqc
	 wyyOZWKg/poimP1mPkaUOHIerxSzTRPI6253RbdUPIUCovhWVx7ydym5hJcRymHVIt0q8
	 tg0WhF9F5QtyM8BamMbldP5hd6w9343sTzK+xQKmpThZdKQxt9vPTpvTNxh6DhVEGgfiP
	 g+ENxcseSpyeDXyfFkw5RbCk0FrMv783vwDH4phPqEvpFY4FViAx4Ci5/YxAC8TPlAR9A
	 6C0k4lKBgAtE1Mg2hv2pozAVJ2OJjvoLL58VKceqykwUN07LdVfoQ5zdcwGxAjj+wRg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794813221;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=s25LFVyKr0qj7YS3fB3Kdijhcfv8rES7sloaw31chVA=;
	b=QCYt4c0jUVxXNxoGvqwQoYVxeJ7fDTBKtAzYkm2YadBc/D6K88bnI5Tw3Jo6NORXQqCj
	 YhCU+NmDsATD9nQj0Mag87jzaFoFGfi+tShMzUy27YOcMVc1nd25jX237Ofpj3zjo0N0c
	 Q4hGkLyQ7xNQqWHdJDy7Td+tp3tI1PnDyIdN8DLZZEvkCoLjTwRtJgu2YwqUpoWCwNlh0
	 hfUIcC9FrNxHmYBpdlRant5SDN1PyKMwUeXM50D9kBdFW0sw/Yg8dAw96SK+B5L05u+FK
	 Wte7xCd9azoPfVa5F3tSG8xf6yd4JyShCvpN66bVRAd28mKprKQ6F0duganDsf2GK3w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794813221;
	bh=s25LFVyKr0qj7YS3fB3Kdijhcfv8rES7sloaw31chVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YFGYC+J3At6Hi25TjvXDKKMmIb9Y7PJYLEu7tOF0BO3PqkTgaTWeZxPpbHUad5zPf
	 Yg9WaMByVW05zn3UcwaTKWlxmwoDaJzPFDTbHkq5TeJw5De4ALzqdrOeZWxIoMtLn/
	 kV/03EXDHcgmfkc9GJ5DUKeHUj6Db8oaeLHYL1FAnTutRbM226UdaAnmrZ9ih9rjQx
	 CcZwy+6HTZaiKztZI6phRud/08DQ3iYu1ZF3h9Se5Ms0/LEsuD2C/aBZNZOpb2bM4m
	 adkJtQbcWcs8kGATH19+CDmFqAmq+tw8QFac+TkJQQQpd88tnYK22YsiU2c/q14g2z
	 dqF87NqcJLZnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 247D780DDC;
	Mon, 16 Nov 2026 07:13:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D4C8A28C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 07:13:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9B16E4062C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 07:13:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zoxY6rab9cT8 for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 07:13:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F3FE840549
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::531"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=pNA7qY8f
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F3FE840549
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 07:13:38 +0000 (UTC)
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-cc758830601so3063057a12.2
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 23:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794813218; x=1795418018;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s25LFVyKr0qj7YS3fB3Kdijhcfv8rES7sloaw31chVA=;
 b=pNA7qY8ffKsGtfhUs60TIBSDlgBMyQGIHj+lUIz3DmsJgT0p3jn7G+vpfpIqdtC/YH
 /vxUGo+gsTxiypEseSZWm4m0msOua2icbW+vhm3ZuON6/hl3wk4fgiCbnGEuDV3gq0OD
 DiF22on4+3WRj44xq4U7H+ZD1V5PvrriZrg6IYoHd4eAfqiaL9fXncba00OyDPhjRvzS
 +FBRdreBEpdq3G5bjoFxuTmQ4BA8sZ0fYJdk/N08l2Bz+bl4AwB3z5RVstgc0uL2vLcb
 K5T/ef9CJLYCI3tW+iZ96LatBBSYZBcJsS6zy0vIyFUySDS2lerJ1mtw7dzZL79hOBTS
 iF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794813218; x=1795418018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=s25LFVyKr0qj7YS3fB3Kdijhcfv8rES7sloaw31chVA=;
 b=P8l/SasRYgi0eyI42zEJFB6qwVNLLf41a+FunHaMZQgNm4Bnr6I9NTcbrwFTDtZOQC
 dPYiL+qHvOpFuOjPTxKbfqQp5fYGBSOYrJp/iGnL6d/O5mWaU+eN2g+MfGM0PsJ/ELKA
 LLzHLVJT9ptCEiQwMFGt8yydbbB7ZBbLYMAmHCNtXAYTCYiQ7bPSwvwaHc35DIilGpox
 dniKk6VbaeQ1Gs4Ihd0wb8/xrSdAfVOpe+pi9qKpQuoACVk4FzCO3ypjMjo2ZUV1woCO
 ex5ROrW/MlvucnNQ0tuNIaNz2XrIU0v0hkkW5/0lfemXIcHvq+RP70T9HlbMq1ln2ZFF
 3ibw==
X-Forwarded-Encrypted: i=1;
 AL+hErEs8dqVzZYcRY5RDJKFC4e6U+zHKRkM2b/IgRMyC44X/tN3DQEu2v7Qval0UFOh3TWx+ZhDk3A=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+Iaas8zGoy3nmIx+IQ9wdCpgncPiHOsnpuj87+8359tO05/K4l
 PnS8wPNNYSyHy6VzarIFY0Nnh2s6Qe0M5sjJJA2OylhNTEbwJvIgahzH
X-Gm-Gg: AZFdTZcUcWbMBeDh2v2I71tFGiA8LrIzwqEu1g2hN7eOJlNsBjPMisA1x3uPO444ko+
 nRiEEVP1USjQ2Esi83j2ShLDqUkR+lV3jlzkNiU3O7qCFVLttzkbo0UZCoonhHxVSrsJVMSggtB
 tIvSQ5xNPpQPc4ETaT0yvaPgRdQelKjtZdzkRKtjTTCDuAcme0HwiZv/n01bYC7tavQPOUt8c8B
 RYcqQ6sr7AhM/Ibc7erx6sApv0J6nz0qQeY+WrbgeKyzT4NcANeoX4DPRPrbwt+ylF+YND4UdqW
 I9qtOT7pTYW3XO/mPh0F7kSK52x0p/UX4NyItK4JV52hA8d2uRSea76QVH/EkEGPjjLFd+IwZXn
 RJQAIC2giF5OyQ3j2TzdWwnPKkwhxchZGPc22cWDigeOpmrMISZnIclByFoZd6oF892oRNcptAo
 ivo+7h6jticPEqKUtZWJqF85gZeKjNE2eTjlpxdF+OMR7aBNVyrrFlhmgNg1zkboEGnaUOCGhTn
 tfoPe0hJAeK3HRTuknpaDs8Ysl7cMeGPKSMm5xtJ28bbuShmWynQFGMfWO3VlLE1lgtJtj4sLbT
 CgE8CnFxbsJ0wuPMbxRWXwzjqyEDP7JHxzrmtrjro+lFF/GujA9tLrOyMX62Y7u4QG0u4uk+KyI
 CsqUR5eWG3+DNVuo8M7krf3bulbhB+0QSY71vfCMWb99oY859iUZVO847xMMTBgOI/DpcMrFucd
 Y7jxDZ6JDT
X-Received: by 2002:a17:90a:ec90:b0:3b0:a757:4f85 with SMTP id
 98e67ed59e1d1-3b1b089e3e3mr8908260a91.2.1794813217759; 
 Sun, 15 Nov 2026 23:13:37 -0800 (PST)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1b39fb9a3sm8423254a91.3.2026.11.15.23.13.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 23:13:37 -0800 (PST)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Yixun Lan <dlan@kernel.org>
Cc: Bruno Banelli <bbanelli@gmail.com>, Eric Chung <eric.chung@riscstar.com>,
 Tom Rini <trini@konsulko.com>, Guodong Xu <docular.xu@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Dave Klotz <DaveWK225@protonmail.com>, u-boot@lists.u-boot-project.org,
 u-boot-spacemit@groups.io
Subject: Re: [PATCH v2] board: spacemit: k1: accept the "m1-x_" TLV product
 name prefix
Date: Mon, 16 Nov 2026 15:13:32 +0800
Message-ID: <20261116071332.2637068-1-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261111-04-k1-milkv-m1-prefix-v2-1-3dae0c911965@kernel.org>
References: <20261111-04-k1-milkv-m1-prefix-v2-1-3dae0c911965@kernel.org>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Yixun,

On Wed, 11 Nov 2026 21:36:41 +0000, Yixun Lan wrote:
> board_fit_config_name_match() derives the device tree name from the TLV
> product name held in the board EEPROM, and only recognises boards whose
> product name starts with "k1-x_".

After the rework this no longer matches the code: the mapping is now
done in fixup_product_name() through k1_board_map, which matches full
product names, not a "k1-x_" prefix.

> The device trees are named for the K1 in both cases, so accept either
> prefix and keep deriving a "k1-" name.

The diff adds one entry for the Jupiter only, so an M1 MUSE Pi Pro or
BPI-F3 would still fall back to the default. Maybe something like "Add
the M1 Jupiter's product name to k1_board_map" for the subject and last
paragraph?

Also, spacemit/k1-milkv-jupiter is not in CONFIG_OF_LIST on main, so
neither Jupiter entry can find its device tree in the FIT yet. My
Jupiter board patch adds it there.

The change itself looks fine to me.

Thanks,
Hung-Chun
