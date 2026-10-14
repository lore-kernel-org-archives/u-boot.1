Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47613CC6B2C
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 19:06:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0ED4740764;
	Wed, 14 Oct 2026 19:06:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cFtqnM8sbm5z; Wed, 14 Oct 2026 19:06:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5517F40805
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792004803;
	b=DlF+fhGfZG8mSsHzsEEQjF6OXMv+6eh+x7HfAc9OH2TeqctEXzgXB02QqeXT8waBvxav
	 MceYGdUQKtGZC+M/Kwxq3/3vg9/jcBDRmcWAAHNtpVSlLQmFl77sVC1KgzAKYebOwSUSE
	 cSEqG80p/gxQpf1EucLZpKGmvvPltOZ97wW0vM9T9PXtreBA3FVdnwSg+vwMpDQcczZqu
	 fR4xhsTXV4K5A7Izi7ZDOXbkO+aFJZnqQk+8KLZ2b7EFzmInDWnvv9QNkmg66r5CDLFD+
	 vkpQwCf2fO55Dnt8Ndyt437TC1R/Wdn4mgVO6loTFU9rdVodapp/S2xU9kvwBmz91og==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792004803;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6ozAOrz9k8ljCgwxUGQDaAciADIr5c7pjkvDiZGTjbY=;
	b=Qsr/y+XOl7kBNHdNzPNgolgyEe1RiSMw8Pk8m7keIZV38/j37e3sIuhOXGnF8RlGgxDv
	 hsq5iy/PJhZx/swdYHkR2C84XBiXrvBZzFWVl+YST09nLqHv5DnOIpQyynjLxKcFliUa5
	 dLl0zRXD4J37wqyKFz3dyfD/enzha0ipkpemlz6Wa4fgErtqa0jrEVy2fvkN1tVkTD/sV
	 fHa3rYP0hBRb3s1rDPi16aroPa/sHci6OayZr9jPlJciWpap5Upv7ZlV6Qtp9MY83ojTD
	 8o4t86my0wcuLVITRLfaRMXhuB08u2Okbu3N6e3Jj8P0PLaqGe+zYoOmm/kU25oOpYg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IrKIGNbs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792004803;
	bh=6ozAOrz9k8ljCgwxUGQDaAciADIr5c7pjkvDiZGTjbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZVUgAk5A9WSReFHoNnd+UqEFXj5IwRVq3XuNcNXUSaCqC5bqyIA2GKV87Jxx4JSaH
	 J1V2/W6/cLk4j21v2950Ld/n8aH2lXsmRlbEQ0w0yjqwf4+LWkZBrjgsrCmc0MfqJ6
	 afsB7yNZijbPUpjzaTAF2lAp4BrdVqVZGVPDGS/n4byIgcpr5a/XuJqgW1yV/D0U1B
	 cqTtuvSrAKXfghcKLFc/YmgmTHKMf9K5mJd0Z25Rz4JYlkDD7RG+CBTp7s6MbgtGPt
	 YC4HwcdqlScKK9lcZoR/mNJP19SQD9cSxsMTBISLDsC7lF0bou3qEykFyOVWMSdjqs
	 Eyq1DKzoM60KA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5517F40805;
	Wed, 14 Oct 2026 19:06:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8E9FD2AC
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 19:06:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6DF2E40805
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 19:06:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k13luZi3_FJa for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 19:06:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CD3AC40764
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792004800;
 b=CzF9Koq1hxjjcz+Cb+4/kAM+zXvQGwcn0KI6f+m3f9frKjNooWKN8XCZ36t0iIXAykau
 RLQJemTHQoHavGV7jfTCsNZ3oDKi8rLU6jGprwTKiX5K2DXMDQtySHDbi0+habQLCOrBS
 ZekYYJeaFknfUfPdijf7ltCf0gXaEv4aiFhHMMmzacdu1FjTPncq1A5YQnSAUi8bLj20P
 uXuPF+gm+Tsj00/T6LXSgaozu8Tci4ji8W826jaK/Hsfgx7xolpQG9kxTIgF0TplFJ5/P
 iJr2p5u+ovGZeXzOZjjola0Aq+SLlX9r6bte+qveloTJM7Srvp0H/PHhRjPbxQpsJGA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792004800;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=6ozAOrz9k8ljCgwxUGQDaAciADIr5c7pjkvDiZGTjbY=;
 b=hmem7gjPgNO7bXpcZEJ4tUz8rJ8puVokG/MwTBj9gB1Bm6S3M2dNXlQaqrFwElh74cox
 DudTN71/Bf1O0Lk0Yz6BAqlmtwQf2r8xsDtVqoVmwLeqPZZVwlr+NstIUmlgN0AETuLj8
 5f7X9KK6URTxYyPNZKcStfWDmikhY87H5l4hkRpp6vOxF9xM3kzSfG+cfFZZD1AOm8sG1
 VedTK92e5/Z8Rn2u5ldVk/f9s2N00NMMgZ6Y4YKYS4N8pCT7hpa3LyhrJRVcoIps859FH
 5ABDGVJKVl5zyLGKqUYG79xztS196e3GwGKTMt4q82qQDXwudgkw4s/AUyeL4mFcyNQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=IrKIGNbs; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=IrKIGNbs
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CD3AC40764
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 19:06:40 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3ab2cb8d577so645673a91.1
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792004800; x=1792609600;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6ozAOrz9k8ljCgwxUGQDaAciADIr5c7pjkvDiZGTjbY=;
 b=IrKIGNbsipfE69t3c3ZoyNYj74i+JThGbiHEq2oMa2+3soyzMOAqWgGUsrH5LBF9sR
 dPsdKzROgnvLvnEg5s57HboBA2SEZa5njyorccMFshPdECxui1zGXAua2tg/jSU4Sp3g
 H1QjUVFi2AbNEeHrLDW2ekjyW91Zn/clX7xHzV65TsGsL9PdIr30UnMyI1aeRGqNymTu
 cjKrDlWxor87rVzcQC1BTJLlBZIzNHNBmeer/qCVpRVKe/JMRpgZu8wOKNIOeeNQF03+
 6anuMPHZdCpaS0OenEUsDSNMtZAq7/0n+HNS3yxMJSGiD6YjxyOKaGuELPrYRGFtcLtK
 k8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792004800; x=1792609600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6ozAOrz9k8ljCgwxUGQDaAciADIr5c7pjkvDiZGTjbY=;
 b=KyAy8lkd2WML3O3lndWtdUoGvfdZf8PgSkPB8doFTlsljql+lkpGitXe5zNR6yIWFT
 5C2p9crrfq1wg5YaS1dO2Pw4Ldy4l037sp/GTUd3So3geiEb0UfsGVTRz8cwqiZJt5y1
 6cozmipIjM3lOT47C291wd26iAv1dAwZBn0YsyJ7iiO0lHWAmuTx6jo/2/pNXyn+LxT3
 KSfLpDJkuuClrkAr15keTcE/ShwJ8G76Kn0qvzIICbD700Jg+b4bfNBNdQ8ac218qIfy
 PrBOsMbxi68qeiM4FLAKKDnu5JAO6D8bUa4+lW+RNQD3RYYEZb8D//Aqkns34qblfs1J
 SzBw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzXq6X7K6dDMP6l1W+iUlr9fWvd4NQtBlGh47mOKbwufs5C+Hb82o3YS3veiCzVhc8zseZ7xRY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKRed0NcD2LR4C+bZxunt/20MNTYCZMhPBPmjCdGvo3PHS/Trev
 yXupMPz6879uImLWBkh1E8yid7a9T3P/Xx0vSIF948pf9Qz4yLTgtVaz
X-Gm-Gg: AYBFou0LccXbL+7kK9HarqJ/zrdyOMF9ZZDc0igDMzN+sp8tfBdoZYB0lFOd2jEqjcR
 J2Oau1+qgWRulHHcdQGXvrPLJWI02jv9gAITfPWXwT27NrQxomqfW1rdHD4AKHmKDdSYfK+Y5Oo
 +c9AmW5Ky+dVL+H564CsWcf4hBuiXMUElXzBRJt+XIon895he3eGL6rd4GBu5DAQZBExkNisyOz
 2952uD4UaHonkrAgBAF+6MDyznSHWvIXFa0MWdTenaqOJOYsSThzWdViZ4OIySb7ES7Eob2ebsY
 1JB5tBZ4mzPfS0A3XDRQvWbBxW5Je2y5+BmL27CCHAq5T+/tiPxf6+xqRARDGtdpYPSh3Jd/iOI
 3htdhio5eUBrZnawPHrDj/c9ZcOnE0bCzWp7rSnul3NHm1h9rrCzshCSXyx0SoXie03oHNKBsML
 rNmvzvz5mr9ulzBm1oexzWufjUQY4TmfIDqS4LmGT1j6AC9KyJmanycP5DIKJtvIB5BG/6IR4Oz
 wsKbF9Nagg2wcZhypCyP5iiUZ+X0anJFQYn74JBzOETmVl0FwpvY5MetoZ63t2YKHVzk/SGvIPJ
 V9P9VE9904FHy4InmxXfVcZT0CnZYV62y63xnIT6CtjtZAJ/jSr2pQ==
X-Received: by 2002:a17:90a:ec8c:b0:3ab:24b2:9016 with SMTP id
 98e67ed59e1d1-3ab3a9a8d8dmr15862747a91.25.1792004799669; 
 Wed, 14 Oct 2026 12:06:39 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac92a1f906sm624938a91.0.2026.10.14.12.06.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 12:06:39 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>,
	Tom Rini <trini@konsulko.com>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org
Subject: [PATCH v2 2/3] doc: virtio: Mention the RTC device
Date: Thu, 15 Oct 2026 03:06:30 +0800
Message-ID: <20261014190631.2232208-3-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014190631.2232208-1-alan.tseng.cs@gmail.com>
References: <20261014190631.2232208-1-alan.tseng.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The list of supported device types still only named network and block
devices. Add the entropy, 9P and RTC devices, and note that the virtio
RTC device needs QEMU v11.1.0 or later.

Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
---
 doc/develop/driver-model/virtio.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/doc/develop/driver-model/virtio.rst b/doc/develop/driver-model/virtio.rst
index e5da9f430..211304706 100644
--- a/doc/develop/driver-model/virtio.rst
+++ b/doc/develop/driver-model/virtio.rst
@@ -28,7 +28,7 @@ queues configuration and buffer transfers are nearly identical. Both MMIO
 and PCI transport options are supported in U-Boot.
 
 The VirtIO spec defines a lots of VirtIO device types, however at present only
-network and block device, the most two commonly used devices, are supported.
+network, block, entropy (rng), 9P transport and RTC devices are supported.
 
 The following QEMU targets are supported.
 
@@ -72,6 +72,8 @@ Requirements
 ------------
 It is required that QEMU v2.5.0+ should be used to test U-Boot VirtIO support
 on QEMU ARM and x86, and v2.12.0+ on QEMU RISC-V.
+The VirtIO RTC device (``-device virtio-rtc-pci`` or
+``-device virtio-rtc-device``) requires QEMU v11.1.0+.
 
 Testing
 -------
-- 
2.43.0

