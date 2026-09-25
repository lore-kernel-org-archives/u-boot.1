Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40964C9830E
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 16:06:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8930140C04;
	Fri, 25 Sep 2026 16:06:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qy8Uq7ryb5ss; Fri, 25 Sep 2026 16:06:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C776840BF2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790352368;
	b=F2oujTVishkDOQAhBAuDxKH89EXaZUKiLVyJBBfUICwDcVjzsG36QTDgUAjz0KaRuVQz
	 BK0zbSnvsF+Aw+p7CU1xxKseMmvFdaJT5uyYQPAPfXqY8wDkUFucRYAcMME1oGF3fpr/E
	 3nT0kN2lGVxanH5pP2mGNeEzPkCNRrUhJt11j6Id9roXJQy9821VFom8b3IZM3FPQCpRT
	 v8i4G4qdO1LlNfzz+eK8Nf7f7ZkNXW7Fv+s0U9C+CIZ1BaRs4jhYiCdFgae9IB9ZTGIiu
	 P8oYgGcAdNUyNIgNlADllf5Yxbg2oZqDhUeJIWUl6d1Ec6g0E0hCigLB+MS3bSHkt+A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790352368;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=baGB+XmLcI/j/e0yAa0nQX+UNbVtGqN8dyKfHXJze+8=;
	b=shS5y/GvJd0YBLlehVHYJyBLcmJ/AWB/oYV+EpTUpff5nCl3tdeN/ZSDsarri/glXBYN
	 9IcBQfwjZPr0wKdaAYBPUxikDLOKDVPq7qaQWrOjsbR9Nil2L2GmPiKU2B/w2BDkbSg3w
	 iuKP2FgIosUDdIvpTN9IRB8Z82x7juW40WVgEV1KtcYcrv/QDpw+QiQ+obnfk+WyCEODg
	 Wdt+Ds9M6WDKhNUOoHjXcyuZ04tHdymNytUZWCHKF62JbrlF4lsm0HnV1QGmD1W8TMdQg
	 WVrZvqaipg0lYFOJnxb/ufjGhZf3KCau1FOZ+F/0pP78sKRSN0oni89Alm+LkCj/lyA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790352367;
	bh=baGB+XmLcI/j/e0yAa0nQX+UNbVtGqN8dyKfHXJze+8=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IE7ARRJNs2lqyz+4kdwHLu9pdukDuBToT5bV8N6h8lI4GCsVc9n1UOYbHUXoo0O0g
	 FUpKOElAdA5WOqMro6vPfQNj2cHBCjAA3LkB4nSOoh19S46lzhBQCjH0IldpmBYwbM
	 j18PjyoKxU+CwPB7NDxkRQMYUm3SxNvsKLXb/i5dszEA4+LZow37XxYL+V1Sv2x3NC
	 As4+YBtwx1iPMxiWYilpl4edBAxCCzg5CRjwiF+4qVgDSJwqzUkbSh2AqCKcB6kaER
	 8eNDXP8pO9hL5i9XnfN6TtYvwYnzuneFwHwtRThzwRQ6Ex/Y3NGLvpndVaHe4/2WFM
	 3NPl0MJF5Qe9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C776840BF2;
	Fri, 25 Sep 2026 16:06:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id ED3EFA33
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 16:06:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CAD92401E3
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 16:06:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4FKXfBdtGqaX for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 16:06:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org C9E004017A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790352365;
 b=swzVBjWyuLYPkYgvgyu3dEq6PXI0tyJ6+a1FMyHmeytOiGjb8D5U8UCXd7xJeyvJ7k1U
 UP1e4q+FrsQ+m1jFt/nStlyMZq4qClJSkp0aa/FhT8UDzg6I2d7SwcZJcjifmkOWwqA3O
 MaSsh5mGv4DxhCfjyc8gqVOMuAJW/SD4Y6uv818Su4pSw01LD660lJolrfYYBKGz4WAtk
 rdmrUJQvpc3B5UF55PIuh3LUHx1KunZWmk3Z85Iudh11E0c6qMPX4WhGxvYPEBlWA/kHS
 mlJ3Xf/RNxQlFiVOF2h8Ucn2jAs5CQipYx1O6JZ6FCbTur0cVNGeK/PGVd4q6trqlLw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790352365;
 h=Received-SPF:DKIM-Signature:Received:From:Subject:Date:Message-Id:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
 bh=baGB+XmLcI/j/e0yAa0nQX+UNbVtGqN8dyKfHXJze+8=;
 b=nrxB4b435VbYMbYRY4KprWLrsG3aN6pv+Ywjds1hTITPd6p/ZQLZ3izEZXsik9SELDji
 JMOVJH9tpah/Ay2EUJadNHM5KnjCLJaQdMD45m+5yWiQKoCoPJrdx5M2LJ5r5UHP/Yz3B
 KDUYQIWMHRsE7IbVjP4yrKyzLADWXoMfNjQqqsvidMZFkbU/tmPtcZViYubHXMl1GNfbI
 rO6sJygaletc8mURUNy/oKSOsuZaEjbgeBEoXETl4JjgpSXqIY2z5hYLOaOV5UlPuFNnl
 phDmDCW7KrtSqSUg3YMsI27UEng13hywnL7qX8eLDm9/Vij/XGd9LbSVJttesvFw4Ow==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=collabora.com; 
 dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256
 header.s=mail header.b=n6BOfETw; 
 arc=none smtp.remote-ip=148.251.105.195
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.251.105.195;
 helo=bali.collaboradmins.com; envelope-from=arnaud.ferraris@collabora.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=n6BOfETw
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C9E004017A
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 16:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1790352361;
 bh=jFEr9VTrlA+xw6hq2SfYMm5mLelFzpsTSxcXrRrSsWU=;
 h=From:Subject:Date:To:Cc:From;
 b=n6BOfETwM1XqBFsxkE0I4gSWc7VpN7Jo9jdInFX9s+zw2dg8XUP9wirnUPJFTrUUq
 51yEuMy0fHGW7K0PPjNxj2jSd2sii1LNd2NOPwSZj5ff3ufbW81ELTPjgNy5AVQBpJ
 akFfbQy+1pXGVXru7WlgOZjBly5WdR/0AL/JlZCjwPh1jleyrbSjV6HeGoN5atuQ0F
 f1EBo+t5ZthmZgvRTo7r06mMDuTKwiP7d5gHURSeAyVFG6JnRMqse1asWme9kYuPBa
 J1dXbgTSbOJdHI3MeBuk0aRwzEq9PfSZbNCSqamDIP+MIIHjcikX3XQSYp+1S9beVZ
 ISbT0i30tN/Pw==
Received: from johnny.home (unknown [100.64.1.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: aferraris)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 33ED217E006F;
 Fri, 25 Sep 2026 18:06:01 +0200 (CEST)
From: Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: [PATCH v2 0/2] pinctrl: mediatek: add support for MT8196
Date: Fri, 25 Sep 2026 18:05:51 +0200
Message-Id: <20260925-mt8196-pinctrl-v2-0-edf1aac8868f@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12NwQ6CMBAFf4Xs2ZpSmxY88R+GQ9kWWQOUtJVoC
 P8uYLx4nGTevAWiC+QiXLMFgpspkh83EKcMsDPj3TGyG4PgQvFSXNiQirxUbKIRU+iZtlrIEtG
 g1LCNpuBaeh3BW/3l+GweDtNe2Y2OYvLhfTzO+e794vI/PueMM2lbXiihjVWyQt/3pvHBnNEPU
 K/r+gFdnwNCwgAAAA==
X-Change-ID: 20260923-mt8196-pinctrl-7d7249ccac47
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Deep Pani <deep.pani@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1472;
 i=arnaud.ferraris@collabora.com; h=from:subject:message-id;
 bh=jFEr9VTrlA+xw6hq2SfYMm5mLelFzpsTSxcXrRrSsWU=;
 b=owEBbQKS/ZANAwAIAdPrtZZruZGWAcsmYgBqtpvoLt5vgE9PQzk2gGPo42zk7lNN+EPa2o4oV
 FypsuVUySeJAjMEAAEIAB0WIQR5bbOT3D/0AiK26iLT67WWa7mRlgUCarab6AAKCRDT67WWa7mR
 lotkEACQqGHbqV8SKS+QGNl02nfCvyNcXEqnnO9C+klLcrLPIC3gV2POEtyen9R3x9O3n/vXUZa
 iJagYXPWAMflk9PmljtuO/OZhyjNLkMD8hTlIQhS5DjeQmA7u8KBycGJrp/sn1uQnZNz97zddYl
 n6TqWz4iH+OXfjA+N8yE7VJWeOldvjq1K+0KuvpqMkWjNZAtwN0eExV40a1pe3jiQ8B0s+VvVIl
 42MJEPaqU78c7AUXk6OqHWgcKxEjQ2KmnaR/5l5x6zEQPAx5ygmIx5RhZym2LgErI+9R1ubDrpP
 NSqjrUB7gPLBE7fTcYgftxcf1yu8DrAcxxtUxNI+I7A6XEDScJUrMfaZBPnYf9yYLCIJufddkF5
 rj4KBm4tY4lLBws1QAC722BlvId5h7+RJYmuJagSmkqEhM2/ugR6ykuz5pH2s3GB1CQs3YLW7sY
 xIOPV8otbC7OwsCU4JPI5GJOJmOTftV8QGOjzy3bVRSUNIdTjBiaCitQmRlAwH/XWUWQLJDYnFQ
 pgHkPnzRxI5e+Mw5x9BJONlim/B1LnaqZFX4VYv9yfuY36Yg0S09ol5yE0YOnqaDhXiVqB3T0eN
 PmmBaf6TfqBjEU51/RPjvYIA+rnXfCYVMyJDVatihFRjEBDXB/Any15LtHQN19KUILPPGFvCDAf
 2LuMioTlR5qsuOg==
X-Developer-Key: i=arnaud.ferraris@collabora.com; a=openpgp;
 fpr=796DB393DC3FF40222B6EA22D3EBB5966BB99196
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

Add pinctrl driver for the MT8196 SoC, based on the corresponding
kernel implementation.

Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
---
Changes in v2:
- Re-order commits, extending max base addresses count first
- Use non-ambiguous SPDX license tag
- Rename pins using the ball name instead of the 1st alt function in
  order to avoid duplicates

To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
To: u-boot@lists.u-boot-project.org
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc: Deep Pani <deep.pani@mediatek.com>

---
Arnaud Ferraris (2):
      pinctrl: mediatek: further increase max number of base addresses
      pinctrl: mediatek: add pinctrl driver for MT8196

 drivers/pinctrl/mediatek/Makefile             |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt8196.c     | 1905 +++++++++++++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h |    2 +-
 3 files changed, 1907 insertions(+), 1 deletion(-)
---
base-commit: ca1c29c01bbd03f89cd86159b2959b4e72d41aa9
change-id: 20260923-mt8196-pinctrl-7d7249ccac47

Best regards,
--  
Arnaud Ferraris <arnaud.ferraris@collabora.com>

