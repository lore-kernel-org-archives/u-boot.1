Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E78EC982D7
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 13:41:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 63C4160B31;
	Thu, 17 Sep 2026 13:41:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5OGQwkDHnwnj; Thu, 17 Sep 2026 13:41:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2511D60B57
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789652488;
	b=dl279GknDTVMtNwL4M3k8yYeiIAIcQQ+yRL9RGISzb9RoXb1UlJ8LoKjkppb24J7riUt
	 3GuGDJiiKr+cTI3GBfIS3sX3nibVLqXZOC0NfV1Nu449Ujsz3wGuzEIHAJbhlbTAExGqB
	 Fo4mM/3npb2t/CoyuHduP2k6zGqEN7dnT/LotHARrJu4gX9UG6/j9fLH8vQSJ81ph1nPW
	 zPF7I8Ilryeza/nBYhkMKewdpQu/ICOGoUk0XDGMBmZ9khuqRCJg+ZmcLEXFPbBEs9xe9
	 cM3Kcfn7iU4lp5jLthdq4n78wHQZvaHaLYE8KgecvCsO/gWaJf4uuUkO4n/mlxFbvcg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789652488;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:X-Change-ID:X-Mailer:
	 Content-Transfer-Encoding:X-Envelope-From:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7RfVpkn6a3CXQSjAQ+dxgRH5fNluxPrBSWEE074xie8=;
	b=Wqb2CkrPevbTvG0T3WiTbSpv4zZNWpGyopNV4IFdzYrZmPtSVxJ9/4AkhO2s6xsmLEdc
	 BpORp9TDiGRKNLhixqifTnNvUnf+WcQZQIObfbOCYHr4GcPDugVIh455m9rg+qBsu280B
	 4vxZND0Ygj+YlnNsSLNcRow5GwzjrdtHrpUoM9c3AN4Xem4BD1/ov/2cz6T1tbgyL5y6Z
	 SatzbZsITHS+I0Hji51JtXrkaO/d97OE0TTEe9qLCnoe8H8SLt7IQQk8JMr51XuWRE+sb
	 SdNefvIu2bCndjk0ntYsB6obrnBD9WHRIOtsrvXjotM9lhz2imM8I6crf2UBnqYC2Ww==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789652488;
	bh=7RfVpkn6a3CXQSjAQ+dxgRH5fNluxPrBSWEE074xie8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=I76paAdyMVk8ylBOEWgi69rkOX6NaVhYsOq2rM9T3/Qe4yaBvDCeqkw2H19S6fbl6
	 k5sh6gVoU9nc3SOtxgLldnu1wpBrns6tWByMSwp9CgYw0po+moG55PxX9k8bxikW5t
	 XkZ5w3z5ms+E5RKdRKP+gXJjyvq49jqAzOw61LFakI9UBd4X9LC1vzhnArSpyrM0FF
	 uIhHqDuKswAE1nu+Wy2Me6z+i9CvCyALTd9pZ5GjfA+0Aapb+nmHmSXBt1DKMStxZ/
	 SEJ6Bj8qlviBxY6xB1a3Kob+qwPhLLNzfZyoY6Nyqbs2884+VAQGmdrjq+Zwbg2QG/
	 SSya9jObd/3wg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2511D60B57;
	Thu, 17 Sep 2026 13:41:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A388342D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 11:00:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 88D7C400B0
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 11:00:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b1RuGt1h7H9l for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 11:00:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 272C240050
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=104.207.68.11
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789642811;
 b=TkQcJmQyLLkhFMgpjyOgqjzHXM4ruApdKJRTys+tNzW8MfXY6O4hPj+eUPYNkWmUyscT
 BdoIfUee1V1ysQzkBFPLwK0qbLGdrSoP085QnT3b99YtVIDaW4s/biwGH+eI+Z/LYDvdW
 kRZAS46unRcjepiDqJhQJRqPViSKw7Pnd/k9J+FEdGuro4uEyPtNl0k5uYZB6xYjw9NT7
 O4Gt3G7Kg3ympwJhOM15iya/QfFDnClIyfYE19exTss66b2xXP2AZjUp13Z22eY46cMfi
 xke5S5dq+jbB1Kqw/n0Q20FBX6l/IIXbYG9YmH/sv34n4IsadIepDdzESBXFJfmU4Ig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789642811;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Type:X-Change-ID:X-Mailer:
 Content-Transfer-Encoding:X-Envelope-From;
 bh=7RfVpkn6a3CXQSjAQ+dxgRH5fNluxPrBSWEE074xie8=;
 b=EpT+OilBQIdL1F4rtWXWERa8DO8f5Z+oGZC15bD+R7cCoIBB4U4QKmOlxiNv2Fhb7VZ5
 UutE9k7WoOQSfZWkXgYDMK1/4S+y/T5llJXaYLGzRmbkfiyTU3boN73UGSL3YXr0JZa/N
 4fWLlaGcc7bv9M0KrUwkhxvTXDGtn5K+x/HEJVAgdN9Adampyyx8+uEQVJGk0vdXgVNgs
 crDgkaicMiTj/Q51E2QDwmb6E3zQvVB5e/aLXgrRbtILKSJWktXXhXo3qj2nGhPf6ri6I
 qz0EE/I2vztcKlaScyzUCVVMiRcgBG+LrEpr0S1GTSqBUI6Jah1a9p6FH6qXu9/UtMg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=machinesoul.in; 
 dkim=pass header.d=machinesoul.in header.i=@machinesoul.in header.a=rsa-sha256
 header.s=spacemail header.b=WJctKCYE; 
 arc=none smtp.remote-ip=104.207.68.11
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=104.207.68.11;
 helo=out-93wp-a11.jellyfish.systems;
 envelope-from=siddharth.menon@machinesoul.in; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=machinesoul.in
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=machinesoul.in header.i=@machinesoul.in
 header.a=rsa-sha256 header.s=spacemail header.b=WJctKCYE
Received: from out-93wp-a11.jellyfish.systems (out-93wp-a11.jellyfish.systems
 [104.207.68.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 272C240050
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 11:00:10 +0000 (UTC)
Received: from localhost.localdomain (unknown [223.181.11.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.spacemail.com (Postfix) with ESMTPSA id 4hlt7Z5lv2z8sWN;
 Thu, 17 Sep 2026 10:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=machinesoul.in;
 s=spacemail; t=1789642797;
 bh=7RfVpkn6a3CXQSjAQ+dxgRH5fNluxPrBSWEE074xie8=;
 h=From:To:Cc:Subject:Date:From;
 b=WJctKCYEXSXqhXdM+lOkOfF0JglrQaQZjxN+HO312o5GX4VcZUhrf2UPtL3nwW2hq
 8BH3pCQS4aCLLjHXIUXCEJlMbZI/mMnkSi2SJCYBTLATcCiA9n3yguNyd0rRpRU2WE
 r/H0vUr5hjcEwimSdN49uBcn8+3OHU85JSJi8WP3YSEmuRZ7dZCGxa4k5pL/CQ/EUN
 HKs6vmOjm6TeQBcg469iQafuCgYNksb9DtETNqNtFn9vlMjkRn91Zt0KWqIIl42lwT
 2GPv5RhKwAov0IW/rReyXI4TFL9IAQA3v3th5vds3Jy5Quhgj13/iDeAV905rs8hNZ
 FLpKS9eWbxhWQ==
From: Siddharth Menon <siddharth.menon@machinesoul.in>
To: u-boot@lists.u-boot-project.org, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Siddharth Menon <siddharth.menon@machinesoul.in>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Stefano Babic <sbabic@nabladev.com>
Subject: [PATCH v2 0/2] button: imx: port snvs_pwrkey driver to u-boot
Date: Thu, 17 Sep 2026 16:29:19 +0530
Message-ID: <20260917-snvs-pwrkey-v2-0-15b41002385f@machinesoul.in>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260917-snvs-pwrkey-d6f4e64cb91f
X-Mailer: b4 0.14.2
Content-Transfer-Encoding: 8bit
X-Envelope-From: siddharth.menon@machinesoul.in
X-Mailman-Approved-At: Thu, 17 Sep 2026 13:41:10 +0000
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

This is a revision of my earlier patch based on feedback from Tom Rini,
porting the SNVS power key driver from the Kernel to u-boot.

The driver was tested out on an imx8mp.

changes from v1 -> v2:
- Update imx8mp_evk and imx8mq_evk defconfigs to enable the SNVS driver
- Correct the Makefile entry. I had missed amending the Makefile after
  renaming the driver to match the naming convention.

v1: https://lore.kernel.org/u-boot/20260913202303.2583287-1-siddharth.menon@machinesoul.in

Signed-off-by: Siddharth Menon <siddharth.menon@machinesoul.in>
---
Siddharth Menon (2):
      button: imx: add SNVS ON/OFF power key driver
      imx8mp/mq_evk: enable SNVS power button

 configs/imx8mp_evk_defconfig        |   2 +
 configs/imx8mq_evk_defconfig        |   2 +
 drivers/button/Kconfig              |   8 ++
 drivers/button/Makefile             |   3 +-
 drivers/button/button-snvs-pwrkey.c | 154 ++++++++++++++++++++++++++++++++++++
 5 files changed, 168 insertions(+), 1 deletion(-)
---
base-commit: 37bbe6e3ed205037fbca390f239eff9899639e39
change-id: 20260917-snvs-pwrkey-d6f4e64cb91f

Best regards,
-- 
Siddharth Menon <siddharth.menon@machinesoul.in>

