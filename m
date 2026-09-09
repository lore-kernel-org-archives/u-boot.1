Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABDF9C79F82
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 00:03:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BCA1E80D2D;
	Wed,  9 Sep 2026 00:03:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LuPtH2VltXaO; Wed,  9 Sep 2026 00:03:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E793C80D1D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788912202;
	b=k/wxXBxNFTU2iKcqvHRy0hS9PEb5mjjC7UHsEzG/vom3QD1LGp4KqhiuvP7YLnoMGyjE
	 k1IPRiAseDQL07ODm3qP+Lbm7ZQkpvF4KMLjuU9p4csWRTyzKA9pgOv8aWzTUdOO0u2Kv
	 rxYKynQEsE5Wrwclno0DgJbGJm3lsiyMYOBlhXzTMhhxRnlWE6EqF2VG6ZjYfkK9ma07D
	 ZjKpYl3OuTpS9YXU6WifFWpRO8FyMQHzQQ4UWns+vddq1maP1bGhsywJvCw1Cm9YH0W23
	 dwCOnpJ2uN+BUlQIFD7hDHpTcrAabXIPYxrGN/nfKSJ/PTrd9UGd1cR+xyv24LlkP2Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788912202;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=va7OXX2xbuPt19JoksAV2Fnnt1HfQ2qwsfnZ48bwqXI=;
	b=Lsi6eLJToxvxDZkjK6Z7Gge128fly0HVj/YO+mr9Pef1lBhq3RkKYI4pzUsVCpsTcfF7
	 un6/x85nhgFRrdZ4fK6rReEYF3hj7tUH6T90xuBqRRvyawlIdpXOtZ9p41SbU0GT3EZD9
	 GHFunpx8goWpRCsee8OQq///IKKo7Meb3ONm2av1Gf0nYRPfZh+9AFjoTJuishjkaqAt2
	 ICGvvvv43SfHxOBSgLb8gMvvaLAmBA7f6SbhbJkMNXVm0u0DSMOb4cEk+tXBBEDMNv/AO
	 pUq9YdNquRQnB9q6brw19CG94jnC/XMFLMqbLAc0L7IkS+koTabMKpDABqHGP3cgO7A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788912202;
	bh=va7OXX2xbuPt19JoksAV2Fnnt1HfQ2qwsfnZ48bwqXI=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DbSQHTPhjkt/Feq8OIoPDEHwJD5R+qi2jGNzNFKnwJRMnGwgv/uSqgXiCxHZi/V7W
	 XuNyDPZ8hn08fVtdLmUyX7Nu1x/JEU6X2iueeZAjyx2SDxmHwPIurdVzXjCyO+XW3H
	 gsespGNdA+OI3niyAJdC27WZJlasWIS9fWcQn5k16g2UTIdb1ncZrcCc154ZGXmYz4
	 9zQoDrOYatrIcDc7jqr05czbhiuesF6oHswmSFYLyi4vPlkh8Ct0EFrH6VtM7/pzkO
	 Zl2oUMTviXTNcka6gNjgrQu/X20OGbMcKnS6e4sjhSKcPFbxh05ablmMS3xsRcb6Vn
	 8xSVl0cUnHFiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E793C80D1D;
	Wed,  9 Sep 2026 00:03:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 798CB701
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 00:03:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5FC38401E9
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 00:03:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OjZeXrn9trCy for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 00:03:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A626E400AA
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788912199;
 b=Es2NSWS2A2plh8+xh0abLexAY/10x39xPcbzEFvDGxPwm8SKlkMD52BawyPKaYXkLmS2
 5jrKOfOKglAMU0jLD233Is5NMyw9N8EzJAILU16qYtRtJPg4TU3ALxloBuOYuBPtPAR34
 +/Q9epE3UqbJj453VKpKaxQ9tPkUTur4vcKnyrnhPQccf0a1UBHJekAJseKlXJHbDNDPW
 wYzgZlo+b0IPq6yOLxQFMn6dFobtN261SuqcTH3Rn0odS27TZyF+etETK4Zf6qC1M/wN1
 UyIb7agHAVnPLkqppkC1v5NXg4YbRnpZN2V7XlzBP+IFvb7Qrs+5yA0Cguq1/CFqGug==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788912199;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=va7OXX2xbuPt19JoksAV2Fnnt1HfQ2qwsfnZ48bwqXI=;
 b=qI8bIteVW/YqI6waeZy2ZpdRY3f6mM/dohii/hMOp09+FRS8sDrRyyPdB0zkRzHu/PxU
 rTmY5o1QJWCzbtfK1Kc6c6zRx+QbOiMIl9NhX5eFRNHJAmLMMtXww64CVMLFcAUl5g397
 U5S+HjOSw9DpbPDnyCrv1XCWn0igptC0Qb5uflgrD2ytTkzKoTrzZ9KxXsR/fwAcu0lc7
 X9ZWsw6NhLJmzePonBbTKUi0zRId3Ge9DOsykRR5Gl0dkbBIKFGb7ZplDvBiXYaixJIbK
 ljVkLXKiTNrRCbnAmJNvW0zj8JExsy5io/tQr/wSHLGQqhdZ13DJ1sQx1o2BCxJzatQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=RyhLhxIK; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=RyhLhxIK
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A626E400AA
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 00:03:17 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7f5a781972fso3521138a34.3
 for <u-boot@lists.u-boot-project.org>; Tue, 08 Sep 2026 17:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788912197; x=1789516997;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=va7OXX2xbuPt19JoksAV2Fnnt1HfQ2qwsfnZ48bwqXI=;
 b=RyhLhxIKgWO2LemAtOqS563X2+P0jkC+Ow790ae4w7A9lSmtLSp5yOai2ajMYBMjSx
 6QY3iVXwp8dyEV4rqJ22YgLzp43pur6lNTTIgltnA9ii89BQDF6KKqSaDfgJxmo+wCoQ
 p2ettNzesgVZUKp4ZtBdP8CPGwJHZMpO3ACbNi6w18qYNatRZl/kkQMgK+qjwrfgxeC0
 G1UHdLFkucrNeAxT/OyAjdCqWPd4E3biSqZHPVmDWMkFH7+Wi9bxesfD8N05EA4ciCPt
 +X5rtg+2SzcX6JbskGxXA3UfaHHDJrMZSv0TQyxjqK/AOQeQPpXOoHwAcJ7Cs2VaQb8r
 2oAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788912197; x=1789516997;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=va7OXX2xbuPt19JoksAV2Fnnt1HfQ2qwsfnZ48bwqXI=;
 b=QPyNSZZ3/WdXO+A9hGbAng9szmmCpSlYdBtt4M2r5HYBP/8X26urZICpa+OmX0AwBM
 MCp9ncGdpsq45hLYH9YhAiyEj0drB9y5hrQ5ah+QrlP9B2yLG0aC1Z+IH1laYPgN9l0f
 OUC5x1WQ08Xfna2uF92TZgU2p5Fxl/n1wkKqqLAif7CnO0Jq5Po8ZXC1LNGD8EIqEdPX
 xv1daXRjDZbB2lCMyLmO5eULFWePffTEsLizu5OPWkUNDUGJwA3/NyD46dT3Xi7W82xV
 mSDjFhdXtTVVDRr6eo5uVUPjUytnV8iY4GxJ/QQIPxBRmcuCBQFDwtd6s3J6OaH8o4qm
 0TRA==
X-Gm-Message-State: AFuF++lamlaYGysPNG9SFQnJPc6DgCxUfahLNJR7kJcBE8UplIRN5UVy
 TEJNIumlkawAeGGgw18M718fzUOnJ3ABcwz/3neR4KYKsSU+jWQtcE6bqOdNunch3wI=
X-Gm-Gg: AYBFou0Ivvh1i2hWfC1UyxNGEPg4lFlnhHsemY1S/JpZ2xh+WqoHdbu74f7R+bsGqAB
 NrhoH4S3LgM1V8jSx2MVJ9zqUuRNbNWN4INd/mpoRmOXqkvU00TvTNBbhypbkWwH7ZleEvrN9M8
 Ihqqcq8U1WCRHO0+sBjzugIQ7Qc9Ud8zYtLrr4G9EFHQyJ9yT3Cmer4Wjp71bkEyF1RgogWlqch
 SsBk836QbaLo7vvB40f8ApXwSIYSi4Vomnp3Qm59dTFmtR2hniK/6HpQd2QumZmn06yw+0rNRDM
 0aW6lr6qQTM8XWJ0WGWjJE0hoIymDtmy3GShpl+mRKkqnlqBn2pXzv8tHy5s7YJWzunHZRiKCNP
 ZAcXGQWwWzah0XaxdsNbQr2AAJegCVJHTcDwz/mBrqdfcbYIxoppyXceUfPSb5wX1l/qjeNKvje
 THDevD/rIsE3asBLac6AoYM9oy//EV0gIwua80bHEOBvyTuSZuS64+F1rJ8XzYp6AaHQ==
X-Received: by 2002:a05:6820:1987:b0:6b1:2f12:6c0c with SMTP id
 006d021491bc7-6b6ff164422mr31446908eaf.34.1788912196742; 
 Tue, 08 Sep 2026 17:03:16 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:ef9f:81b6:a41e:b9b3])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b6deb11957sm16609908eaf.15.2026.09.08.17.03.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 17:03:15 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/5] splash: documentation and more storage support
Date: Tue, 08 Sep 2026 19:02:29 -0500
Message-Id: <20260908-splash-doc-and-scsi-v1-0-2345f5c4617f@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrB1IYivaq0gXcTLqlBIlU0UQ7
 27aLt/i/wOUk7DCozgg8SYqc8ywZQE0+TgySsgGZ1xtWtOgLm+vE4aZ0MeASipoq5Z4cLfG3C3
 kckk8yP67ds+/de1fTJ/vCs7zAv+T2Nd3AAAA
X-Change-ID: 20260908-splash-doc-and-scsi-139cef248051
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1445; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=wq5G6n5Kd56jJnNdR2bsBuG8JEuZ3tP0jl3f94EOrgk=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqoKIYC4/DxszX7zDG38V2ERZDIbm/VpZEM1vnq
 MR8v4vYnP+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaqCiGBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AskkIAJxD8Uh8hmUZTE8Jhza9y2aHk3RhCXOoKS3HEXQ
 BgBBrKXqhjy52tIAbsU+FRk2iQjPStS9YdWK2jfKx+3r0uWSUIa5azZyhOP5HHLsn52qADaLq4B
 6C7j/DOo+l+PADZgbYc/d18AtGahdJDUtkQ5C1FkSoS5sBgDSu3bpoP7Qw93XH1g+hyrz7I+4PL
 DGvpuGNjif4Hb2Lgd+v0xo/soKx5c3s7vFvJ2ufUyESN+51sub4xacvYBVzEkMDkYdDIwD2cHCn
 Z44Z6mE99TzijSbzKDdjJnh4+qK2bVVtrRdbS11zQ3UoSLbuq2q1ScE3F6ZQFEbFfao9dNLus+v
 HOo4=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

For the MediaTek Genio boards that we are working on, we want to be able
to use a boot splash logo. There are two cases that were not covered by
the existing splash source support. Loading the splash image from UFS
and loading the splash image from an offset in a raw partition.

While here, we noticed that the documentation was out of date, so there
are a few patches updating that first and then adding the two features
that we need.

---
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Cc: Julien Stephan <jstephan@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>

---
David Lechner (5):
      doc: splash: convert README.splashprepare to reStructuredText
      doc: splash: document the features added since 2013
      splash: use u32 for the raw storage offset
      splash: add a splashoffset environment variable
      splash: add SCSI storage support

 common/splash.c          |   8 ++-
 common/splash_source.c   |  30 +++++++++--
 doc/README.splashprepare |  34 ------------
 doc/develop/index.rst    |   1 +
 doc/develop/splash.rst   | 134 +++++++++++++++++++++++++++++++++++++++++++++++
 include/splash.h         |   1 +
 6 files changed, 169 insertions(+), 39 deletions(-)
---
base-commit: d4152edb50356338af994d1c0483f65b717b4c15
change-id: 20260908-splash-doc-and-scsi-139cef248051

Best regards,
--  
David Lechner <dlechner@baylibre.com>

