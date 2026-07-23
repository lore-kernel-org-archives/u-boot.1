Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A219C531D1
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 15:14:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4955940A21;
	Thu, 23 Jul 2026 15:14:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pr1aezWXhvWw; Thu, 23 Jul 2026 15:14:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9426D40A19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784819645;
	bh=856VvzafjL/IWDOa0t1aTORyvmJZjvdSx3z8497lEgU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GJ2giyfIz07nxxmUZdA3E7rVv0ABPtsFLPINb25QGvUSSW6POct15M28Vy6EUY4ce
	 uvSHbiSCsvDGEdm0et/RExa56wUzBUiWEjwW2lZhST4ve4B4cgEs0JhNkN/y82FFbL
	 9TmP5aZ+/IGbfQ86UXRDk8Ltrm/CQONDPouPRTwXh6UcB0EtwNUo9+I8U44cRVocts
	 CGU1PZWcrZ8ol9GKGK/ct3g5W3NW0zfULkjIROdUMJ7nXIVr5YHtbDvS9GZmN3nhqr
	 ss1AYrjS5UpwPRCGd5W6cnvsNpmLRdgp8YBOiSYWd2W7gIXx+Wg+OCfjNWl6jjaLkV
	 Utmj1jrG1cjDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9426D40A19;
	Thu, 23 Jul 2026 15:14:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 10CFA3B0
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 13:30:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 02D0E403E4
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 13:30:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lx-Dgq0x2hAq for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 13:30:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com;
 envelope-from=tan.siewert@9elements.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0EFF7403CD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0EFF7403CD
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0EFF7403CD
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 13:30:34 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-47f878135e0so399352f8f.2
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 06:30:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784813433; x=1785418233;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=856VvzafjL/IWDOa0t1aTORyvmJZjvdSx3z8497lEgU=;
 b=onjvOmm7yprXFrHq4806pz3/Xa6D7axeviY6fhmS7GoPPJPHe137nBlgfoPZn+puiK
 XbrnhkXlM1nMBb3XjR6WND5gblMbjFu9bQi0TcY8tm39t6TyknAS+5/VnsmYcCCjT8RT
 aXWnx0kuHYfn38m4Us5JpKQsHBdbBj8012hVp0ZUGRPD8UGIxJLs5T1gYfftRoxGvCyk
 7190g8ThmIT0XKqYaqlJOOH7dpnCo4w9tam1vHGVWdpb5SCCgbb8UcPoxmD5cefTrSUN
 KlDlZYnR+Lp8fCAY/2AlY/pUNtgyoJHcv93i3713DHF2G6ltmUxMGb6IsSDcB+gq/o21
 hP2g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrzoD1wjhuxYW49KerQj/D/fZiLnX16Dr1Cu1ZPGbBA9xtKU5YAuj2Q9m3q9g8SLAEjQxtnRvU=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyX0NiSzLRZH03NpOehwJpMJPnw4fG9sFgr34S+krFSQztTv2l/
 TQsRH2QtjgTDVGKD8UF3DBDKeiAfs9OXWh3SIpv9dyEwtDWWYEaBYQtSmTmPQzazxY4=
X-Gm-Gg: AR+sD13B3t7mg6AhmE4N/s/QHqcQx6SFEJnrtf/OJjAPXS9qHGvfixd9oh5/t5L3Nq8
 dgp5HxsMz63e3Jx6K0e8LcnzanBZpABgtgKrYmFqo5tK/e0zIJ83TggcE2+u8CONkO77yqGt6Vt
 yMcEeyfghmzvV4WAduspFVvGOrWju/8CC3kI/oHV8fC1jJmXKy4cjAuD2hqJ4ySkQfq0Frq0joN
 bZCxKxNgGwKR3Hb1/jMYXgqlOb7ddY9X8xwvo4ZySjnMKuBZ6twsodufL2PBDdWg32Dyyj/vnTT
 /vtGuCnP8kpsGgP2Zt3Wi5M5AyOFLdsb4M16dquW212Rc7vS1LlbRDUGHQbL0Veti6VdWqSI1pk
 SlHJFTgXVJm6rgEnS5ddws0lekzIFNCQpLS+oyaPpGh5zC+lJjmS4BnfqNMu4EV56MCj5H8Dy1z
 gDDujUO83erfBHyQ==
X-Received: by 2002:a05:600c:c05a:b0:495:49da:e15a with SMTP id
 5b1f17b1804b1-49573d083c6mr37661475e9.30.1784813432657; 
 Thu, 23 Jul 2026 06:30:32 -0700 (PDT)
Received: from [10.12.249.172] ([2a01:599:841:3b94:b6c8:2fa:40db:8ecf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b043727sm97075405e9.4.2026.07.23.06.30.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 06:30:31 -0700 (PDT)
From: Tan Siewert <tan.siewert@9elements.com>
Date: Thu, 23 Jul 2026 15:30:02 +0200
Subject: [PATCH 1/8] MAINTAINERS: GXP: Add Marcello and Tan
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-9e-gxp-v1-1-f86e5cea239f@9elements.com>
References: <20260723-9e-gxp-v1-0-f86e5cea239f@9elements.com>
In-Reply-To: <20260723-9e-gxp-v1-0-f86e5cea239f@9elements.com>
To: u-boot@lists.denx.de, Jean-Marie Verdun <verdun@hpe.com>, 
 Nick Hawkins <nick.hawkins@hpe.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>, 
 Tan Siewert <tan.siewert@9elements.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784813429; l=850;
 i=tan.siewert@9elements.com; s=20260527; h=from:subject:message-id;
 bh=cx2vOjGpkG8Ld8W/h9k0Syw7P8G7kx7/DOA4Ie8AnkU=;
 b=lyuMSFDKNCfN2LzmD0mZMe3xixdnEJymm2nZZzdMHTCAhzq57pk+8DPISIKANYU3r6ar95pWx
 gyGByIdHYMeC97LqmdYMnjEmRZA7sPthQ3G6KKDZWtHSxwMIXDmJZMU
X-Developer-Key: i=tan.siewert@9elements.com; a=ed25519;
 pk=ORQd/zQf+LsAvJGXP1CjQwVO6t6iEOGq/eGUsmRVTG4=
X-Mailman-Approved-At: Thu, 23 Jul 2026 15:13:57 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1784813433; x=1785418233;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=856VvzafjL/IWDOa0t1aTORyvmJZjvdSx3z8497lEgU=;
 b=QJbq/Kj/tntub+jKZ+hSx4+ATRMo+ELAyHJERfra1WBVeiKOdv/z5qnWha/eFb+bzk
 iSp55U9q/nbDDZ1kz4TWmpT8AlmDcbCSGJ2jZRjdpFpgLM+VwFIj33okPh8eydhl+0Rj
 zk+CCTyZcdSgWEPHBdt3r7kosdS0ukT2NxLTHcSxoPKdyhWRJPleRSnI+5TwlMG1slkz
 TxYibAI5037JDzz785x257OkUCrDLdpcXBdE9WBZSY8k5vuDVKIxVlYmi6XsXBSCD5Xq
 z1gTKEorFwFm2C6BTjnyMtZLiCEUZY+yaW3uiXx/hAdoIg/mqVIE6HXrYFaNWuZbKBT5
 aC4w==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=9elements.com header.i=@9elements.com
 header.a=rsa-sha256 header.s=google header.b=QJbq/Kj/
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

Add Marcello and myself as maintainers for the HPE GXP architecture,
alongside to Jean-Marie and Nick. Both of us work on this SoC in
cooperation with HPE and will help maintain it going forward. The
maintainership was acked by Jean-Marie in a private conversation.

Signed-off-by: Tan Siewert <tan.siewert@9elements.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 323b1b172b1..3ecbb50e03a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -335,6 +335,8 @@ F:	arch/arm/mach-histb
 ARM HPE GXP ARCHITECTURE
 M:	Jean-Marie Verdun <verdun@hpe.com>
 M:	Nick Hawkins <nick.hawkins@hpe.com>
+M:	Marcello Sylvester Bauer <marcello.bauer@9elements.com>
+M:	Tan Siewert <tan.siewert@9elements.com>
 S:	Maintained
 F:	arch/arm/dts/hpe-bmc*
 F:	arch/arm/dts/hpe-gxp*

-- 
2.53.0

