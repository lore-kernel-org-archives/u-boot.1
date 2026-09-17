Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E6DC982D6
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 15:07:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5ECAB80FF3;
	Thu, 17 Sep 2026 15:07:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qXnaqE11fycb; Thu, 17 Sep 2026 15:07:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C42AB81006
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789657627;
	b=ZSes1enIgvBt7GaiSHOXIGeGaA4G768SNOI05szMMUYdlgkbxEZZUPiGjqhE/tGKdmfT
	 QDnK1s0mekJXdnGnNQu0SenhfQFu1HqqOp1VmxY3jnCdSJ+qivp0oB5/839VKzU+KN6bc
	 v/WzdppaboQql6cKp4kd5uRnjDAYghiOg08kx8ffPgbCg+amUklWLVQ3tC1nM6eVgZnX6
	 hImZQu7E7o5O21agZoWpZNaxp+Tzp34/XHU/IM6jsW9pugpegjMLldZ1Rzffc+7hhfutE
	 wCptXMAZf74saZlflbgQy1UoXO9ouwmvfE1AY2RwWDBX6XMosMw4hO+0pGnzgBELdGA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789657627;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=h1LzJVi9DQp7hCfD2+5aYKa8ZTMtmQ5OxXMhDvyMoJk=;
	b=nuIpE0OGlAXkDBBdMkO1lR5ZzAH6CpLUN4x3ms5sgrJ46NApBQu+jGKQpg5m8ARpCYny
	 ByGHffrZmAcHbBIrJ1+H5YXbI9MpuldjBJs01DGebEnO2HYlX7Zh/4kWoFWqmxvK3mblm
	 KfqjUet8bGoAkLLMeakgfScMdqblPIne2ySaevKJ0U9oBhgzwo/d9iFEpnAAJfW+GD3JY
	 Dupvb+OBmSMPNhgHYyUlvmAz8rkJndWccvbJLnPfbwb2p9Y20nwrb4C6/niu60tsgg0OR
	 lce59jefSBowMHtgq0dZ9FoCC3iLfeWO7WEsyJ20EoNc2iO5ls20vP+2FsKgkCBCSDQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="CdBEI/k0";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789657627;
	bh=h1LzJVi9DQp7hCfD2+5aYKa8ZTMtmQ5OxXMhDvyMoJk=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Dh4Y/n7p6COKdnEK5k2ZIfQtbPTHpoiWKZ0UbMh9B6wx7qgoaBxojEg1+v8m65ST0
	 afZznp0G1Ua2RqSrGJVoMxoNvgLo3E9S/lDgfrH+uf404lzXj8ZE3fMVhzRZkifYy5
	 cE6Ib7H9C6VVsoJupGPsiFO5gbTeR1by5rfQCMgQL77f0X9a0o8R+Oy9/A0/BY2o/b
	 ZbQaYRUetGtbNagJVoLrEailtMkcVlrAD0wBsixNdd1moY+MW46vUcROveJGGWlL7l
	 RxxMtoXeoX45/Mo4U6XSlhF1SkC90cTfeI8GcRo7eKtGxyWSzn0VZOj37xsZY54mmf
	 je5/dJufBq41A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C42AB81006;
	Thu, 17 Sep 2026 15:07:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C0CB13D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:04:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5E3E980FB9
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:04:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M7gXHNRhOj8g for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 14:04:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 72B5580A54
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::21"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789653886;
 b=ppAzeDtFTaTDXZS2e813SnNdrWZJMxzHeo2UPpPbv8rdryFEn9jGMX6q7Eb1/4GJRzWG
 /jzpyotW3Qm3O3uK7D790OADAFh+Q436WuDxfZVlRKcZmE08GDENFieJMROI7bCrGYOWh
 MpU7z5YkkWG3kTToFXXlznIfFeIHPqtBDC3sXb4Jh2sMoKPJ+O4QuDl74l5ywZkMGoulc
 +40NjugyXB4ePzrib9Tsb3E4UAKEtvflfojApFf0KjflpUN1nEqs4k5YN8x93SxUZixvT
 X16O2GM0ua3V6dNnz8t4C4RSE14VYs96Q2Gyv3N8SEk5BvNTQOhu/OUFgyN9fcchtMA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789653886;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=h1LzJVi9DQp7hCfD2+5aYKa8ZTMtmQ5OxXMhDvyMoJk=;
 b=qgNsHxVId8ctUDRCOnvQ8V+Rh0YU44ckGf+hdXzjaNxHcsbX0gZxnW1LrhNIr/yD8Hp8
 S9lHg8IKXZG2CH+njJVJR1zdL4ATvnc4KYS3y8t4xWOYCGPRTmlLIH6NGfBHBLvR4nu99
 Txb+miqJ6Q7E5/j/+whhAAXLeKJRzCpk+yar5jZIqhLa1ow0J9tmNiHi9F6p6PQPwKIAl
 0JvftZmDYnFc6GmQXnTqeKY3W415uhSHDffTBeF5JUWXLXXj2ilc3IHk5gVHQzwEPOcni
 rMlq/JOVRpKogStsC2cQH1iilKzBUn32hIAAxf61ZDRFMEUpYE0hTqd81DkcbIYAhqg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="CdBEI/k0"; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::21"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::21; helo=mail-wr2-x21.google.com;
 envelope-from=fractalclone@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=CdBEI/k0
Received: from mail-wr2-x21.google.com (mail-wr2-x21.google.com
 [IPv6:2a00:1450:4864:30::21])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 72B5580A54
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:04:45 +0000 (UTC)
Received: by mail-wr2-x21.google.com with SMTP id
 ffacd0b85a97d-482f633cd80so496347f8f.2
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789653884; x=1790258684;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=h1LzJVi9DQp7hCfD2+5aYKa8ZTMtmQ5OxXMhDvyMoJk=;
 b=CdBEI/k0zGTI2MmmZ8TdvE7RQhHBFSe62L81Oc39Dd98fYZYXEpDPdCz7cbnD98rS+
 b1kDp4rmDHN7oLczvg/xXuwjaJVDoD1VPZeaZWPWk6yIs/X2kg+BwXqBI1wyG5pdCJ00
 CyBZmKfrWB3kDY7FoO1GEn1esBH/BfMXaik6VbEI9gzg31kuR0GjI1XAQcBo/GsGxTl6
 o7u9yKmvdUALX4R8fXMc5Emg+mM5d7/hRcmj6CjhVtxzli4vWd8dI61rSEQW+0DZsI10
 cE44UW2Ih5H3s+caKxdoUFI8owRwKOY+oyyORXH6s/NlhwkExtc+tuAOY9sLKdVJhb8I
 +NUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789653884; x=1790258684;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=h1LzJVi9DQp7hCfD2+5aYKa8ZTMtmQ5OxXMhDvyMoJk=;
 b=CcSav9hoc1M0nlXoTk/WV+qa21KGb91514rj5FlQYX5wnG43m9jypegnUeSVDgrnsX
 Pkzyyj9IEQDkTQ4FoFyBR8SQ3SQwLxQJvXtYJzI4x6E+E5lquF8XByvYXFSwBKu4fmzX
 nBu4FtzYV+/T8ve05YsyQ+OvVl4B0LZaec2K8M3OvZCrJ2uhLfTwiq04gq1YXPW0Zj+i
 Rvjf7ZchzO2GZ1grPHyFs3xSkzg+3uMdq9sQMXCmyNaotdoUMP0vKTKSuVxAKy+g0t9M
 Qq74HVte5hg+I4tZZ1oCD8nBJqnjN7Q+cFd6lm0eCXqw37EG4Xor2UbM4xguRLY8Do6m
 wsqQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx8RCQI4IgHbUnIVo4ZteNv0X7/k6Svk9moJ/UDUiiBGS4G19Se3dvCSU87c+H9sR72HFZ/r68=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++knC8EoUEK3bJbXA4nrmoLul80k1ouBqnG7knXP88fHNTcBy/NS
 4lu+nKnYkwhVDewNGrPxRoUh8JKiuDoifgERhZ50wAoXcOoR5zDh4U5n
X-Gm-Gg: AYBFou3AO/CAyg4RbVV59jzMmr8xnbjycnLTPwTtsQZXKIL4C8uz4VCCaNdmBrEtMc7
 bMbezpHVyoyjJN9zK8VL1sJrShoslU11iFYJ97oOE7hMWnzzcmOovt4bqLmxIaCNJILoD8Fsw72
 /BpGj/Wu8p1E1023dHfukqA8ymzIJYXILTFA8xbPU/ez/umU0S99t4qea90qwQQ31DuCBRS5lXD
 qw74uS910OBrKEDQl1wMlrnMMFDd+SZ0Jrq0e12ACeW6EFhrw1lii0TLtv/TlBVROIPgmK31nZb
 NbtxU0j1WFH8B5RZuoAhM7WCxNPvvjlw98gpppG1RbCdDP9YT1+kRgEWE1PwxRxt3Pw2FVS0/R4
 ZFfUGwCMgeuymDC4MxDzjFcG2BxK1N1IYOWClkooiZQiM5NKSltWP7CThwxwlYW0pvBNVDUQXXw
 ARCzQgD14yP5/iIBp3Y8nmzzdLnz1dt38a5Frb+ZZ4Oribfv93lJZU3H/4KIGenky+cc/r5Rfns
 bMTQw==
X-Received: by 2002:a05:6000:188e:b0:487:6f6:29a6 with SMTP id
 ffacd0b85a97d-4870cf36c1dmr8743876f8f.35.1789653883855; 
 Thu, 17 Sep 2026 07:04:43 -0700 (PDT)
Received: from [192.168.1.138] ([139.47.34.204])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf34440sm15600634f8f.25.2026.09.17.07.04.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 07:04:43 -0700 (PDT)
From: Jean-Paul Etienne <fractalclone@gmail.com>
Subject: [PATCH 0/2] rock-pi-4b: add config and fix dt
Date: Thu, 17 Sep 2026 16:04:31 +0200
Message-Id: <20260917-rock-pi-4b-fix-v1-0-1b3b52c38ed2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MWwqAIBAAryL73YLaw+oq0UfmVkugoRBBePekz
 xmYeSFRZEowihci3Zw4+AKqErAei98J2RUGLXUnB2UwhvXEi7GxuPGD1hD1gzXGtTWU6IpU9D+
 c5pw/SQYKgmAAAAA=
X-Change-ID: 20260917-rock-pi-4b-fix-b7ee89b77d53
To: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Jean-Paul Etienne <fractalclone@gmail.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Thu, 17 Sep 2026 15:07:06 +0000
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

This series add a defconfig for rock-pi-4b and
fix rk3399-rock-pi-4b.dts to account for SDRAM LPDDR4 params.

Signed-off-by: Jean-Paul Etienne <fractalclone@gmail.com>
---
Jean-Paul Etienne (2):
      configs: add config for rock-pi-4b
      dts: rk3399-rock-pi-4b: account for SDRAM LPDDR4 params

 configs/rock-pi-4b-rk3399_defconfig                | 103 +++++++++++++++++++++
 .../src/arm64/rockchip/rk3399-rock-pi-4b.dts       |   5 +
 2 files changed, 108 insertions(+)
---
base-commit: 444aca6d1439e4c4b9955171a7f45c053b540f69
change-id: 20260917-rock-pi-4b-fix-b7ee89b77d53

Best regards,
-- 
Jean-Paul Etienne <fractalclone@gmail.com>

