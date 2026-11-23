Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18355606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 18:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YZknQhcb;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SIPlT7aT
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E021D405CC;
	Mon, 23 Nov 2026 18:00:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dKtHSsAt5Y7O; Mon, 23 Nov 2026 18:00:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0CBE0405CE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795456812;
	b=J1NABWXVWltuzMzvg3PZ8D3oEQnIzNegV308+F6eI/nJTrJOPCo+KMc20l2gh9jzkO42
	 NH+iBASaECx0Ep/r+gZh/5+DpGmqfHjfFBmpkEKoPjdj+vu0rqn+M/mqhS8N5KhSVQlkW
	 kve/YzExeFAqyqo11RB6Fnpjx02qxmm+O02wJGyBNXGGwcx/hgtoTIMMtoXESOQmvWz8q
	 AKlOKHln3/u+I3VuIXGkCHdgIyHlMxbpFKGjYLZr7ycs8TdxHGWJzsp07dbXobKZ9jLzP
	 kBmwREvxdgXFxLjJUDswMbsQOGceMmfi0b8LpCvxY2kSW6aVwfY0ff5+X3W8Tup7VlQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795456812;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Sender:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=bNGCj6Ipw2zwiM5q+yIpJ9weBohjOncX4J9Bevyleuo=;
	b=ik+PNqVMi1tra4nu3MFWVlAR1ozXhyoRU+c+vSK0uOHiM1cmwmJXUMNe1brx7xTxiQCe
	 4f46+EY7b8S1WYw+6HD+Wtp69MUHiTDlqyFZJ0FZOsezvBpgZBmiQpIvpvEXa8HnePTjU
	 VUhffhzSKeZQd5dgyGnjdd4mEnj6kMBX/JIIUeowlR/2NlV1wrF7Dva0p0kVUqc5cqNuZ
	 dfYzfkI6NrU2jR7GLsFuYsehVtrALv53peh3C3noNJU8t73juPoNF82JiTKu7aJY6bxva
	 WJ3c0/X2ymZn87fKRZlIr0vVOax5L0rHClHeMHeGlkUmXnyKjJ7WFpgAaYuXO85stfg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795456812;
	bh=bNGCj6Ipw2zwiM5q+yIpJ9weBohjOncX4J9Bevyleuo=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YZknQhcb2CoKFtW+suQOuT4OoOLE91uM7675uy6Pj8CW53U47NUzE1HOnfR9WV2DN
	 mild1GMNhuoYLFTeQH4z6KPiXIpDjaXAYBqXBsoP8t2OiXB89yASjVYzKwzSVbYW15
	 9ISLEKG/fVT7Hka8AkEf9ibhnPGybOKzeyEUl6wBH4WMnkJC7ad/YeCzuiXG4t1TNT
	 oIlm81KO8mfWhww79Fq7XNmvTeRooQeEHZ5c/Xmd8KaJCNCQVYlDfgI6f2XmpSwfE+
	 ak7iDMlP1CQeJvbL7Dy9yQurni/7T/eAMT7ZW6mqNpkxijdzRxFmi6aHiDM043neNg
	 MDsiUSvz63fcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0CBE0405CE;
	Mon, 23 Nov 2026 18:00:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 916B215D
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 18:00:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7666A80DD7
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 18:00:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NRHW0LM3tGf5 for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 18:00:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5F70E80BD6
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=SIPlT7aT
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5F70E80BD6
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 18:00:08 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4bb6adaf0f1so31779305e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795456807; x=1796061607;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bNGCj6Ipw2zwiM5q+yIpJ9weBohjOncX4J9Bevyleuo=;
 b=SIPlT7aTmhE2nQ33HZPOy1ELFwMfBjOo/XHr8EEs+7tV3WRkJP+NeILZlnOu6PIWWf
 4DE95sUmsYzExD1FwClHiO1+mtEyBfj+0+BsnaaBy6NQ+iPZuv7i/PIWqlnsKJCafFXo
 Ovgk1i4YSosi75o2Odh2nZLneKODLQcn+5SFZBhx6+39832dfaoHiAVZD6UtXVNrN5Ff
 dt1IVNFxjbqafOdVRpcqO/b9RpmCDzYgjg5B3n5iJz6tSRxIx0SNuUuDVDOohXmZ76v2
 1MMIk12Oxpo3ULVkwXAGc8moHZB5JItTOQd9gjfrvCL46kzw04JF/+rtmaTTCobj6M/0
 08Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795456807; x=1796061607;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:sender:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bNGCj6Ipw2zwiM5q+yIpJ9weBohjOncX4J9Bevyleuo=;
 b=VWUIgmmDiBjgpHItH3Ms3jEvD7L+R8P2QH3wTkEUj2jPJV+dvE5z42ANhkRlrEorc2
 LLxeaMfkHClCbdgMVoCgSa80hxPKCmtcZB8pMKfAadsh6DR9pCDHP0FnEcKHcqubW5sk
 4F9kNGiESjCNkfxCKf71+Mz6YFAzJ3+kRZvtOV8AKXFsDHrTn70mXnJNDx9m5bNC4HXC
 n6Kj9ZeCoH1SnNPwQNgMdB9HPk1PgmjmDOUTrW68pJh0rQQU6J53kXZ5rN4nuENSMl5d
 dYHnzF3v+fV+HLSzrjuSM/G0097l9czkKucXWYnloLBOCf5m/lbNM4mnVFnlYZ3//K+4
 2mPA==
X-Gm-Message-State: APuU4Z8jGnU7kFVlJaag3uNj5x5Z/rChab9Dn1CrL0MpI3CHE0ThJJJX
 dVSkSz4bpcbcLurm9UFFctBQeUCASpMEQMRA+4URsiYTCgsbzKIddam/
X-Gm-Gg: AZFdTZeoiWuvmzSOEBfFjfD5tx3Xp3uc2R2ABgrxP1F7/ZbB8AAyLRo/cG9hW2Fgalz
 a4TZEtUsU1ZRwByxGmE6X70bgm4r+2/I2W41zDNrT3Nsu+BRMFp4TijJQxc4uwa62v0wm2jClhm
 6mxLaK2dAdEyV1qtOoJur0WiYr45lMop4xceg3kpWsHXW7tAX09pOXc5Ztv3Q0qGgFTCtIlst//
 pKDOw2roMGBRBfPUuCR6gk5nglP/rH3ocLuXWw7tUu1VL41dHfqGHCp3/mGIO4W+WNNHIKBoC/C
 IXMr5GbUCwisHFEJDQqkkH5g8rLYMY8THGFZjRIJMuVQ4+2qVtgxP0Iaw2O8yvvz0nuMYe0yzYn
 N4RBmOyeC7GBnfFPxiZij6wT8xRsucKy6U4wIIgNajpq+hUmXg+5DtUl/oZHYahJlmJE9U8kOaE
 u0MESoO9voSNcgEiyo5Ayn43g7S2AElbEsFJM/uHAltjCI0rCRDPKEaK0kS8n/LRlvAwyjqJF2D
 FBstRmR3RGmWUneQOrEe1DcxZPG7HTKoWlwtzumw2xakAbS0BRkmY4liYn7GQ4BsG8p1uTsFGK6
 /iIBLuDDJLCKLgfLmsvzVHE+sIPmZ/y6+0ER+uc=
X-Received: by 2002:a05:600c:1546:b0:4a1:fc98:1cb1 with SMTP id
 5b1f17b1804b1-4bb887c2cb0mr278527915e9.2.1795456806844; 
 Mon, 23 Nov 2026 10:00:06 -0800 (PST)
Received: from [127.0.1.1] ([151.51.12.187]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm543353365e9.13.2026.11.23.10.00.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 10:00:06 -0800 (PST)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Subject: [PATCH v2 0/5] arm: rockchip: TPL/SPL config options minor fixes
Date: Mon, 23 Nov 2026 19:00:03 +0100
Message-Id: <20261123-config-v2-0-be23de2a81f5@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACN/BGsC/2WNQQ6CMBBFr0Jmbc100BZdeQ/DAmopY4SaFhsN4
 e5SXLp8yfvvzxBtYBvhXMwQbOLIflyBdgWYvhmdFXxbGQhJSUQSxo8dO1GqIx2U1o1GglV+Btv
 xewtd6x/HV3u3ZsrrbPQcJx8+21OS2fuLJilQSNm2hKeqVBVd3NDwY2/8APWyLF8+JQ5irgAAA
 A==
X-Change-ID: 20261002-config-36524677a702
To: u-boot@lists.u-boot-project.org, Quentin Schulz <u-boot@0leil.net>, 
 Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15.2
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

The series fixes some minor issues in TPL and SPL configuration options
handling, improving configurations consistency. Neither functional nor
binary changes intended.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
Changes in v2:
- new patch [3/5] related to SPL_BSS_MAX_SIZE case
- simplify SPL_BSS_MAX_SIZE case solution
- update and reword commit messages
- collect tags
- rebase on next
- Link to v1: https://patch.msgid.link/20261002-config-v1-0-11bb20983682@gmail.com

---
Massimo Pegorer (5):
      arm: rockchip: rv1126: Remove unneeded TPL_LDSCRIPT default
      arm: rockchip: Avoid TPL_LDSCRIPT configuration when unneeded
      arm: rockchip: Move SPL_BSS_MAX_SIZE default value defintion
      arm: rockchip: Avoid SPL_BSS_START_ADDR definition if unneeded
      arm: rockchip: Remove unneeded SPL_SHARES_INIT_SP_ADDR check

 arch/arm/mach-rockchip/Kconfig        | 8 ++------
 arch/arm/mach-rockchip/px30/Kconfig   | 2 +-
 arch/arm/mach-rockchip/rk3328/Kconfig | 2 +-
 arch/arm/mach-rockchip/rk3399/Kconfig | 2 +-
 arch/arm/mach-rockchip/rv1126/Kconfig | 3 ---
 common/spl/Kconfig                    | 1 +
 6 files changed, 6 insertions(+), 12 deletions(-)
---
base-commit: d22f61a39fb68bc697e67df45f2e3103378bc7cd
change-id: 20261002-config-36524677a702

Best regards,
--  
Massimo Pegorer <massimo.pegorer+oss@gmail.com>

