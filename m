Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C6CCA5FF1
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 12:07:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 25350605D2;
	Wed,  7 Oct 2026 12:07:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ien1ddhWRs9Y; Wed,  7 Oct 2026 12:07:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 71DF2605D5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791374851;
	b=tHVN7OYN0J7GgvuJCP2RlPqliyAke4yS0O51k80S7iXK3hQLjjxEX+XihIFf4422iVMa
	 J+D3hJZZR3PfRt4TbVnMxH7rtNvIxvgKGQGiH4LoL5nW+hCTA/yLsWTb2BamyUcjnlgai
	 ahy4zqYR129Wxb+13hkheO4YrE98q3ixi9MU3wrkik8tBl11pQRaUzebkL98qWzzDsItP
	 zxt7Gesk2sAgPr1rHoa1jPOMqjMGcSVZ832K+990qg55lbZK9STT1ospwT4KugAq1Gc2O
	 My9Tdp8MKqz9q4uxjPe12GJhtgJaR7gkACHrxp2G3WKo3hs6+nWTV9mw30Fsmn2wfOA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791374851;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IcMmTaQDsxef8SV3SA2RfaBghS3jTxAUqS/2ifn9vdA=;
	b=Th7GYJFT43aqIVlVPItu6lls+gI0okEzU4BIh1+rBriG6QFdE29IoK3pAamMiR4ZU0BU
	 bBCR7ygAQhOzw8pBCpHTWuHrZ+CtJciDBVsVL6AoqM9a1e+9u6OY21MYX1TSHnRoPqUJT
	 TJ0pMzbZ53c7vOkV1XLl70rcu+HPkw/IBTGubF2c4I2FGNiowwm6w9MiRhjgD5mb3YYQx
	 rAXrhZGe6XB9ehghCTQBjmuCeUOLJ7ggtT1aBTfR78hI3gElEoor+AzmJs6JnKvUMH8Do
	 qNw93xHqPMMKtWpM9oaHh8XIDSX3PjvVttHAa78Td1qBnIDd9Bn7VRushq0Px/aDLFg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791374851;
	bh=IcMmTaQDsxef8SV3SA2RfaBghS3jTxAUqS/2ifn9vdA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=boxLiLzzey2HJ4xLU+91Gru1RkHWzsN4KQbpCL8343z/VM/tPvxva1JP9S7q4tH5Y
	 9xeGymb40gIN96+BYnU01SLY9DTmVjwi1JzYGTdchBitcxcF4v2XwqjYTfhlQL0X56
	 Gc0OQXboTvgf71n2jXW2gZ5JxdVugeFiOhH/SfP7oSH3LCmvPMVjU8BDeW70T+sCZu
	 tjHgwnbVYAzEKm4ItHy48TQyeuwl5rIVKTL472wSq35ooHVFxhhN0UlZZu36rORs0C
	 PGhPlWklz7UxRZ8QAZ5XCdyDQn6+gKDxAonUHydOVOZwQO9k0srUvQ+a9dOvO02K5E
	 TCQgVSewmhJ7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 71DF2605D5;
	Wed,  7 Oct 2026 12:07:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 09DAC1A6
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 11:59:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E377940655
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 11:59:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ukIFtEHbQx17 for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 11:59:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 836EA4064E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791374362;
 b=OZl3t4L8qHitU3GKZK9U3+2XGMxuLJLpmknm7Dd1dw/dwJMD8/oxgvCg6se1k/BHGB5A
 xMDv28dkgNbsohIpaqnG7ERI+cy7oRBl8kiybon9d4lWE7/8wBblvPhc+wLhXVSS6Hdo5
 y/9V0or0Eka1Rkwun1qjaKlZvc2dI0T3NOI4WcT3zDEm14IW+1R4PrwnX0LTzGIr+CDGz
 L2HKOdfoPojpHeyuO+SCbHH4FKSXphpwoATzo4SO25TslFh1KksUYYf1o79HQAIGv3un/
 588SJ7hI/jNWswPVhZ+2SWk1NjW2u1f/vnB2HWURuV836osLIlaWO94Y0SWcitRB0VA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791374362;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=IcMmTaQDsxef8SV3SA2RfaBghS3jTxAUqS/2ifn9vdA=;
 b=EbLO2xFRlEmOB61JGs4XkVANh0x0Uttr/O5H2dmg4TxVMGhuaSe2vJMntdKc0dTKa9c+
 Wcx3FqwB6W2VuEZ1cUjtjSYobmop6USmtloShXlg9Fg0DLhhBcWVR9M6lv9+dd6l18RzD
 wYluH2lUGzaK7yA73UfgUxt/nptNROu3+wOP6bo07AGhptV9CZPwhkyTXbv+nQukF8q93
 rZtxAQJbS7WLsb51f3o5w7hw9X1gZljlkvGHn609XvLczHE9j5Isr6qZpSO7DFM9saf+L
 Wvo63lkDZUBiMOhfJAgDYLIc9OlWtRtgamRslQ7XduoOCRcr/IoK0D46v4/8y4SuDBg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=NbCiJgv3; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=NbCiJgv3
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 836EA4064E
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 11:59:22 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-49ff680331aso41611605e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 04:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791374360; x=1791979160;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IcMmTaQDsxef8SV3SA2RfaBghS3jTxAUqS/2ifn9vdA=;
 b=NbCiJgv38Ca/8OkplBuOm6rojjLay1l9yrS7pG0DmXwPHA2u7eNmzCjv0WYhNRPD28
 bEFpMCXwXjrKy63cgV05b3sUTJcw9KZno/+WrwG1r4ITaJes+BlsdzLfJ//dUcgz8MCK
 ZgZfrowzX9A16aNPJaK7dKasxLD3zfebruhFa1XcB2WYEEpg+vxoiyk9Srw0d3VKK9WX
 Zj4LWSY9wnpNHmjERKGIlc/+rbge+shSdypTBaSNST0Bobl/orCU99a4kie87iNJI5NP
 1K5lxSs0hVXEwurTZZNO+zfzSz2M2xRf92XDxqXETOP3SsghimGEuFDufkHARnc5rnEK
 m3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791374360; x=1791979160;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IcMmTaQDsxef8SV3SA2RfaBghS3jTxAUqS/2ifn9vdA=;
 b=kqjs5tcqcTr4Nrsb0bnOdKa9JBmHFEWfiyTBU4YoI0eVIIaKeXYms9VTTdQ9Wpg9bR
 FeU1vmHTJxWsJCHWdm3lc3PUhATWF6JfiuBY9zbM5I5tje5dJmX3LxxZLqZkacdpWrEC
 fjxS11Cx6juF5NmG7JSJipje23I69tiVmMMRluJI/4p34ahQ0xDJv64W1cySiYpXfFuh
 GwwAmge24vkma4I8YKiLRBAm6yDaSAkR8mY1jH43kET9J89z/Uu+CrIz3wOhy/IfBi83
 HDCS6hChq7HQhhtgQKU8KxRe1rey9n+JUgWHOCLtx/Pxij5eo3AuYJnxWzw+uocVaBNb
 BV8w==
X-Forwarded-Encrypted: i=1;
 AKwUvBx0b3LAspMziPD76ddnugYzvON8Yvu5VRIitzJpUwvksoy/Ajyh29t79+NDcqR3Cu7xM2/XtD8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nmw/RVM3TKa5R78/Qpqct/ujMpHE1quii/BnxDig5iptg85tSL
 8cB1hLkHWZlUHjqHOC8QcZ11Mbw1d2tDl+EKs96DtEo8C3tcisWu04hF
X-Gm-Gg: AYBFou2XM/c403IHRjOr3AG2ENKdFgvxe+71qMMM9EKjy+e5sqzfFdNYLxI5bFzQJgJ
 31sUGnAnyW9tqSXrCKbAkoFQAe3Gdl3r+J0WmCmdN5/6khc7z7qe2M8jCN21Pwq4BHcEfJrpdsR
 CTEz2QOBoXXuQrwuwGp7Hz4PCyD4vaPbX0qB+z9ZC7gPpcXGA1T1wniUTA7ImD35iqO0wxp9auq
 MIp/C0SR78nzBDJrK5sgJezsWw4YnVBXQlHeZ7NMzseUOQ/GehToGqRwqoUzEsjawMO5MbZTOQv
 DYMXtPEaJy3c8XBB3c/sEnIsF4XljBIrFZxfRnECatdEtAK5/xrFi6we+IFc7FtFRNclJqCzPsV
 VJU58C0/5g0QWPcSd+xRs7BiQyQ4Qvkb9eV2x2HzchnN9AY1XPgdGt9cv7txcnXptG9r/Um2ln8
 c7bwRojQezPR6Z6E+OsBHENryNt8vpEu3L99/x4kNCCBxYg950vh21kLCoVwX/Eto2lL5Hm/8/P
 2DK
X-Received: by 2002:a05:600c:c0c1:b0:4a1:811c:8078 with SMTP id
 5b1f17b1804b1-4a1811c81b8mr19092935e9.26.1791374360023; 
 Wed, 07 Oct 2026 04:59:20 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a178c4927esm213065255e9.8.2026.10.07.04.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 04:59:19 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: jk@ozlabs.org
Cc: patchwork@lists.ozlabs.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, mehmet.fide@screeningeagle.com
Subject: patchwork.ozlabs.org: slow responses and timeouts
Date: Wed,  7 Oct 2026 13:59:18 +0200
Message-ID: <20261007115918.2553308-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Hi Jeremy,

patchwork.ozlabs.org has been slow for us for some weeks, in a browser
and through the REST API, and requests often time out. I measured it
today: between 10:58 and 11:40 UTC I fetched three U-Boot URLs 30 times
each with curl and a 60 s limit, from a host in Europe, and one
patchwork.kernel.org page from the same host for comparison:

                                    median   p90     max    >10 s  timeouts
  /project/uboot/list/               4.7 s  18.1 s  37.5 s   9/30   2/30
  /api/1.2/patches/?project=uboot    4.7 s  17.0 s  34.3 s   9/30   2/30
  /api/1.2/patches/2294003/          4.7 s  18.0 s  35.5 s   6/30   2/30
  patchwork.kernel.org list page     0.9 s   0.9 s   4.9 s   0/30   0/30

The TCP connect takes 0.3 s and the rest is the wait for the first
byte, so the time goes in the server. The six timeouts came in two
groups, 11:01-11:02 and 11:16-11:21 UTC, where every URL failed.

Is this a known load problem on the machine, and is there anything
users can do to lighten it, for example in how often they poll the API?
I can send the raw timings if they help.

Thanks,
Mehmet
