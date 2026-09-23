Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB338C982FA
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 13:07:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 15B2F4058A;
	Wed, 23 Sep 2026 13:07:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h_msRuD3K-i2; Wed, 23 Sep 2026 13:07:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 366B2404E0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790168841;
	b=LHVf5xnFMn3C+Fbjo1Ss4ETs6UFpHCmjoCjj8yFRh7IOQYHRSSNZhxAY9rfeKaFPebwo
	 dlf1lisqSFtZR1pOPznKXLwDB8NXSFeZtixMsUTRRhtCSE3YlJ/5BvF2oF2W1azLgltyj
	 QT4BroVH+V2xsLOHHoutWJ+S1ADhlcK/3HPf+2Ag+pYCtr/4Nq9GWG3iP6LdPxJXLlsju
	 lssztuAHqZ2fHup9/VtGOkYZade1KzQu120bfLoVyTzkbjXJHUrkNm+Bk803HiLxsyOxW
	 hnXDaGqaqmgbMjsR82hPmTioPMSrrNlPwZokX+VcEwvyNOZL3l7sOG65A+PFWPlrGwA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790168841;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Tz9hnrW9bnOphwjTO5BODYvV1JXzBvFhn10p0mhSG/o=;
	b=BLZh1CRReRhqOJlAw4baVrWiGS0Z7YNNiS2kO9U9uBT+uYds6ox3w/9un+hVutZ7strY
	 BxIthYggxAbIdzGzQSxVWyFhMh7/3Ckfi5lgIYGhaKg8Flhop+0HH3pQ/96UfQbLr9b88
	 ANodiFh+r2K/D8hKMu3J53Dljtv9Hi6+zrwlr53uyome0k8G7qq5q37HH20DHeaCqjI7e
	 emrqjKWL9m5gLmP5Rh988fGC7L6VzCSvIjL66k7DhUmOcC01pQTdve1x55d+bPIqFByOM
	 c9gbAt+Xoh3NTr2Akl0ZzYdNiWHq87vqSW8iu3C0poLbp87a3QJsfHKSYsZbLJ36c+g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790168841;
	bh=Tz9hnrW9bnOphwjTO5BODYvV1JXzBvFhn10p0mhSG/o=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=D2QmWdgV0w32U8i/tRsTaYMQYrhG+hfHGEIyKJPj2M+VuJ49NtbY3srmbyeCBmpoe
	 zYq5GypH30BQ5uKfRxFAhoWtmZgXs6TROp+NWCyKAoI/+zLRSlmJBUulJJ+Z2X0q05
	 iuwdAQDYcmnO27vu+wzLc69cGRYtznT/Qyq+s/W7ltiw6bloQyVuwfx+vHLsG+MM4W
	 ob5drsWb68Edq9qPM8Z/eHEjburasC3Wl4rLsNu7KUlVqEAq8C9/thxoYvohGjxnkK
	 kBKRy7XHzJ4qQQzzb5cR5+YA/bXdubUzxY9taoGVp29bm5aav8FlJfqKCw1nVE1a+s
	 8Ou59YDlBneZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 366B2404E0;
	Wed, 23 Sep 2026 13:07:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 062083A9
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 13:07:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EBFF74035E
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 13:07:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X_HmX_R2va22 for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 13:07:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 14B914035D
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790168839;
 b=iIaLIVy3zlvnf/pl+rLg05KATXfHlLzUfSWmjzW2+vNEn2Lxw4fu+K1Ci53Qjld4/OAO
 /08u95eFbeSZvAJFlukCvBe+5r3tC745rzZwpkuOCxcg5z9l7gyN1JobPnlIjCCt0uDNw
 O2A4FZUJ/JL/YfbWzMS45upXtUZnRV5htIbbzzEjuwITI4ztlV++4/0nEJFi291hwYLVH
 NscPkKQixieJ4/5pfioiV4Wn4/nLb/kvPTv7VMiNRycAeEWMBuAHtcvHjebnPX75O+Sji
 M9pnmNuiOdcFriCexssYBXx+w1PDQYyNQEo47edkCnIcIl62gAl51Oo3HyN9u4LBcow==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790168839;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=Tz9hnrW9bnOphwjTO5BODYvV1JXzBvFhn10p0mhSG/o=;
 b=ZlYylmKN3yjluDacQ83NGnb4lVdj+EiHVDGxfLdSDVOoU1RnMc4DzHpE3rIw1FuzAnMZ
 r+4rRTBNhfka9P5qZWkh5MtONLZa0zeJhIWlCxV1rDR99hf5uZKVY3/X1PkbBsNXvFoMy
 lz8BbQdZRQYMDaa9Lk6KU8uaoPXkn77P5T+unvmgITo9Pue2o05sWtc+FHhMpRx1FRUMV
 T+sskrq+TJ5MOvfKhDSF25lHp1f6BIZgqEg4d8ZNjUT7HvZcHsKQNh+1kOnFZ0hKHtZZD
 7pwuEpSvXZoI96idQptVxbcUEpkxHSgBglmKGutPyDW21jiIHKUUyR7hSsf2qDrB/LA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=IzfI9I4M; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=IzfI9I4M
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 14B914035D
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 13:07:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B0F7C60231;
 Wed, 23 Sep 2026 13:07:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3121F000FF;
 Wed, 23 Sep 2026 13:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790168837;
 bh=Tz9hnrW9bnOphwjTO5BODYvV1JXzBvFhn10p0mhSG/o=;
 h=From:Subject:Date:To:Cc;
 b=IzfI9I4Mm9TKI3UDiPO08x83tPexqHpkRt1Ft6s7eOPSz1WYqT/7MDuWciIx0f994
 lJlbVdjqMhjnjUjP0/q9O3geJDXdr0Gby23rU+CwXVfIEWPyLi1Jg+3Fji941DqPY/
 t5BQUvD782jEOZHJjXZ/keso1Kka7Ty/aQr1sLpv3J8HT8vbzCnokX0PRhMzQycOos
 aAC1rrY/1nLYKBttnjMd1iSVPbBG9snbcJErKoRLM/TJv2/yrXCnHiWXeMGCDQOMpW
 jT1EeH6a7BZtZW1vFQ0H58qVrQ19IfTEKc/MN3SiG5rezOplc1k0QStMCA92J5SqHv
 HbL3aVnsavNaQ==
From: Yixun Lan <dlan@kernel.org>
Subject: [PATCH v2 0/2] riscv: spacemit: add pinctrl support for K3 SoC
Date: Wed, 23 Sep 2026 13:06:51 +0000
Message-Id: <20260923-01-k3-pinctrl-support-v2-0-e76a917ee252@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ6CMBBFr0Jm7Zi2goAr72FYQB2gQtpmWoiGc
 HcBD+DyJe+/v0AgNhTglizANJtgnN1AnRLQfW07QvPcGJRQV1EogULicEFvrI48Ypi8dxwxz4l
 aXQpJaQ7b1jO15n10H9WPw9S8SMc9thu9CdHx5zie5e79+5glCmyytFZpJnRRZveB2NJ4dtxBt
 a7rFxlb5FTNAAAA
X-Change-ID: 20260820-01-k3-pinctrl-support-77eefc901e47
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org
Cc: Eric Chung <eric.chung@riscstar.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Tom Rini <trini@konsulko.com>, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1161; i=dlan@kernel.org;
 h=from:subject:message-id; bh=fujupztcJgwziW2DZYwK4y7RV3ncUGwCNNPa66RFwWQ=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqs875t/hBcvY/7h2TbzhbGjt3fwurunTPceH0Q
 u8RxQFmJnaJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCarPO+RsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+0izA/9Fbuii8gTNJEMuyIqPiunJZ230c81lwWvsynOESNVYqkvt5KOlFW/i
 dvVJ3TdcBjleEhV5r8ZpaG2ShXBxTZCvdOCnWK3CW3j3ULTInW5e3vppeCmnA0qjFKnCC8EXSoz
 4JUGc5T8XMi6c3ZknV1MPERO6m+YH5MKha/qe6wO8HlwKm+t7HUuVYQkHH6r6ScMkESo7SeFkkk
 5xAGwvsv5V+7tR144TSrnMmTiDreSmATquY73sqxsvCWZa5GBY4K2akBbRoKYRg9Z5/YMpfE+Ne
 /4nVC1T0ErpJfQ/0ix+lyVyAVzAL6AV2YAKSkQ+B+63hh6b/i54PPgmIL7rn8ExQxPDSWPkuAZh
 Gn0yG1GMFqNdDJRfvV9fp2JIfFfAIyghalLNa5gCSfvzV5u1V/vxuAml8Xsn5Ie8sKKvyyGwcpR
 HP+naMeXFhGxNWY/kBbPpz0rnF4sNIGwJYgdv9ZUMZ07DevM9eW+2yeFS2NO7jzyMdOZTTvCU3B
 yYAZc6EZ50usrwsd5x7SkGJJ1Ew2moT9mu8FB4DbYta9R1Gwpn/CuEUw0+fQv5Ukb1zHK9yZbMX
 bk0Y8yO4a10+9auS3n5OA5eRwIuo38pw6sbnfSUDdENjyi0n5RqFid1gXBshb+WrqUCjBz9VZoI
 Oz1mbVUImwBpk/JzdjdnRFFyXMytmk=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
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

The pinctrl controller of SpacemiT K3 SoC changed its register BIT
layout definition comparing to old K1 SoC, has different IO
power-domain tables, and extend drive strength bits to 4.

First patch fix drive strength configuration for external-voltage
IO pins.

Please note, this series is composed on top of K1 pinctrl patch which
sent to mailing list here [1]

Link: https://patch.msgid.link/20260906-pinctrl-v2-2-729da680092c@riscstar.com  [1]
Signed-off-by: Yixun Lan <dlan@kernel.org>
---
Changes in v2:
- rebase on top of k1's pinctrl patch
- Link to v1: https://patch.msgid.link/20260820-01-k3-pinctrl-support-v1-0-b54a2450c895@kernel.org

---
Yixun Lan (2):
      pinctrl: spacemit: configure drive strength based on power source
      pinctrl: spacemit: k3: add K3 pin support

 drivers/pinctrl/spacemit/Kconfig      |   4 +-
 drivers/pinctrl/spacemit/pinctrl-k1.c | 457 +++++++++++++++++++++++++++++-----
 2 files changed, 390 insertions(+), 71 deletions(-)
---
base-commit: d412c9b0db20ebf497bb2e97e8a727736a4d35a4
change-id: 20260820-01-k3-pinctrl-support-77eefc901e47

Best regards,
--  
Yixun Lan <dlan@kernel.org>

