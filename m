Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ACB2CA9EC7
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 14:42:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CF46C80DDF;
	Sun, 11 Oct 2026 14:42:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id teAeSlilVXvh; Sun, 11 Oct 2026 14:42:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A747F80A98
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791729745;
	b=FC1wV7qO8hKeaV02P8EGJXhY+arEzsBjWUoAEluQ0OeV9wDqAAgWNpU+01/Qe18FB8d6
	 BqTMU2FM3bVmREAl8gjQK3hf/vS3la/xOCeHUxk3FsqEQttf3bTG59nVX82Pqivj4Egk8
	 /BPyMG5VEfA6WyJPeBH0nz+998FtmJUit1KQphr5n5DlsXUZsRDN1m0JWSGbZgfvSkVjd
	 LpMCP0JHSnqT52Pt+n7Opb9uSt11xhmK2Fr8aYEYPhiw+A2L8UtY1yVVBVgkXbR5hYf6m
	 9Nr9zkju//OQXP6kAE1v7lpxC05zgoHJ5nhfI+OeIJiSEdeGsYKQev3pOkjwSgYSeoA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791729745;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/z6j1V/FHreWUZKQ5kyLBXVEI6HWPAPp8M4AT8QJp04=;
	b=kkmMVGVUkG+4je5cIfz6vvX8X51fOQIxREnGtZq+SYYzdoJAf9mHuk3vp5wWwlbjfKRg
	 gBi1VlUWxkUE+Xd7hl8CDuIs9t/ioTNtNcWRqUdmVW/k4bIfIX9NJvmERTg7TAV1Zn6ur
	 ixpW0e/pu5EgD0zH6cRKPXMAdm8h78PrtokNZxPddJeVKjjburEXX9jD/c3eFG3SXJ9MJ
	 ibzuksS1jdWVpp4b2TQN2FUZbBHnVoj8h03QGQRDftmE1TZx5s1IprD1en7aFTtFUlLqY
	 tgbgLhlHWIv5uNPWoZ0dcIyLA+tOOTEjX4sXiRqwCc8ixNpRWogNIRv5Uevlx6vR/PQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791729745;
	bh=/z6j1V/FHreWUZKQ5kyLBXVEI6HWPAPp8M4AT8QJp04=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Cn5jAmN8yeVjLSCgdbckwOFZXTtNH3g0eML6l3e6oGfaLSKALSNLOcMugHpK52xRq
	 aQcp2RTGwurDWKJPqyjroZi+WQ6mzC+HeLfTEe8LxTt2ffPnZLNTBkBPLBDkilpdZp
	 2Q7VsbZcsRNq3oOMxicxkkS0Z2rWuET/fgQs7ds9KSfd597uBXtlQ9G6LB3DPsYT1V
	 ycyubKTLDLDVSG2an+1UvNHTSrDseoQ8l0ZAAnH5ISXirE+hAlFCryh7zeh2yxVdBz
	 HeuPKFrxvc3YeWutnPKKB6ocxQxCdXKQn9z33nrTBjSwiS6RbKsZZ6hzhv+FK1OUYY
	 D9J9+0BqXV1wA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A747F80A98;
	Sun, 11 Oct 2026 14:42:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C30E111
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 14:42:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6256140426
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 14:42:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MmJgQJJY692E for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 14:42:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 79B39403F4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791729743;
 b=KXchJPUFk2nbJGhhbUv3hmdeUYfpWsTRjMIjiUhrm83nSbgRsVqQ7Nk/H6iqI8LwMbQv
 4kytWK61Ejwu2W7xQ0QroscxjmFBoOcFP8fMtUhhh5Ck0Wdz7x5vrCPk7C3mvuJS+rdYI
 l34Ul9wHsyEj+DDxxkLEduWfDqLLE1WXONW/DuEINZCdk1xyo9H4tKWaHJVtUnMqfKtSZ
 aFe0FR6gM2kAx7ZCA1hU1+JH6ifRWrCyNqhC/GzmL/+1VPNeXEpOVSw9xlXEMTFCt3afJ
 UBEn5Yris//WmNiJXNoYtTubHKr7uTEB93Yz+FjcXaon/42lxkfM3kh3NLD5qfZIJVg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791729743;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=/z6j1V/FHreWUZKQ5kyLBXVEI6HWPAPp8M4AT8QJp04=;
 b=VALQq0rlarTgkS8EbSct+eqIntfjaD9DsJX6Q1hZrq74uz2y2GS3+oHcz9W2OJOKCCo0
 Eu7kAuWU5pDdNn64Rr+2MMmaNY50Q5htktkRkBwf+/4zFyKT+wqJgsNB37owXGU2Y26Xn
 qD8r74DQGDypwxeMO7yCenNG2oKPlXvA8FWjkr8nKqh+n/cu47KdSYPVXFKEfBzSdhExN
 MQc6YIW5iN9+oQhfIh5CMJZtid5QXF0UvhvJUNUajEQDdHGbWIAuVYAB0udZpXIebVfo7
 T1EPdBu4TF2p5bxkBlnCN9zrt1cC3VLEXIA0KQb6xKPOiWR+VYnLNZdb2jUEBYRY8GA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=PmTbXCwW; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="ct85+q/y"; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=PmTbXCwW; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ct85+q/y
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 79B39403F4
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 14:42:23 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69B857KP2381406
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 14:42:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /z6j1V/FHreWUZKQ5kyLBXVEI6HWPAPp8M4AT8QJp04=; b=PmTbXCwWTiCld49b
 D4hD69QusGAQ1BoDl622Z/+7oCjRqT1kG3K2eHDbK0fFeYmyp+GuKcYTsOOEgv1I
 r99BS8g+u3W+5bhUPapH7xHfNkFQlTiQ6fXXKEDl9twtfG6LwxiSVqqOs7TH0vh8
 xRf3CA3ld0XG2669hiLnlRboMK9PwXHyM41DoLucCdnsiVKRnxFBBmRpvqpH0SWO
 4UMCgahNhbQ1h2fuodNwMI/fpBCripemtUMbTv3uHJuMqnsGapJ2fkLLzkRWuVWc
 9KBQEDdxHL8RZT7p6oiZcbZv6XYsZ7rVLrqP+3tz9fQck7sj1IpMO/KPUxsBplI1
 cJvJUw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7e4eb2gn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 14:42:22 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cc40759b2so289985685a.1
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 07:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791729742; x=1792334542;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/z6j1V/FHreWUZKQ5kyLBXVEI6HWPAPp8M4AT8QJp04=;
 b=ct85+q/y4fuXyjYvhuQATk0S8Mc9A8N6m7i2PvF5J2zyjqAibYWlFkyXNP+2nFUX9k
 dswEaUiAqnqCev4ckN1jFjhv3DK1p7TxQEWGhZ9lCOFSJLC9cTC12hCyuaY844P+ierL
 bgRXyhfcvPTYZgICAk52tIFrj0iBSZyxDnI7c8RAIoIswoUYbQaVZ8vGCMSJEw+4dadv
 dU2zL6pqRPVKFJly2Hk3CaTWV+ITcz+2lTYnRAgfxLDt34mOF+zlDbFfKBVTd9Od5qrl
 uAgvWCA/yhw/Y2fMRLkijK5OXnnOPjEkZ7qz95gZGBUQJvi61qyxb2PoBxGcOIO2bAlP
 CFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791729742; x=1792334542;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/z6j1V/FHreWUZKQ5kyLBXVEI6HWPAPp8M4AT8QJp04=;
 b=B/ZdxoAKv2aDYs+xRDjO2F3rgNcaB9mHbd4uY/2HTq60NTbkKqx8ceaxb79Qx8tKIS
 sg57dH820nf4+nsYwgRGuzcIfNXCVy8GppgTPYk/qeE4we7M62blcATCc76j6cuM9it2
 eMFn716gcg6FbIKVanTiZ3JUhypQPbZrXpfKdic30jk9UP1MTMIoD7XSqLTve441lNX7
 vJj4xT5LvfLbW1/s+CYP3qR+uDGBKBCojLVJ1dM4XrjZnWMEYA4e3idLgCW57CsoxTu6
 nVk+gQ/oRraCKttQo++l4i0gTfBILLdcT1zCEv7XqIlCt5W+P2VcyTYTkcbj7rUL2Z/S
 Hozg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxOFgbb+wAcp0Rx2D63v8TAgCvhJ6X7MMd6UIZnGDR3raKjdeJY8zFd6DOacwr7K0xRJPBJkTI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLNp/K2pAF6zVNHj5qJ16+qK0iC4/XaxZ/OU294LSodbajp6DmK
 zUM4fKkHzKZx0Mat3Pqx1YMnRCupTR3/vOpQii6NCybZhrQgEcy+cRAt6TT3sidXBEQzFGnP/18
 rh5ZNXh9QAFEHXfHyMRvGGDG/gw+nRhZu9PUN1UJg8WGQpId4Jt8IUP3unjiM8Uywbew8Mf8=
X-Gm-Gg: AYBFou10EGqWDdDY2K+mJFGRv4fjti6zTNo/2WvtvBex/T6UvyTYoADHMIjrxjIFA1o
 8uigJs5ZYyh8vvA86ejX5YedM+TLbZjeSgy9jk5rlNX7hPGbEZOQRaTt+bU/sCH5rSbC/Q3IFLq
 6uiUpirkuQqapyOGO5TJucvvJmCvsxWwP9q8C+fKLGhM92EeKOY54QCctqGxk/mjoyXfc509YWV
 vZbiG94vaivgjsYn3MLajYNckjDq/CKdJVAnIn8HnJebvk8BRmcwLxBZOvUbLntMGjLodAJe+jc
 PHD2BIvIVdUMzAMKg0S4WdRwETfylc0vTHOOsQjvm/4kNVVjnp5YOmCHrS0f9VMxqGv4wtyOS+H
 HcJqUUsLfSsR6hBL3cHyxp0E16P9tBH0XEeeFxORCG/0a
X-Received: by 2002:a05:620a:198d:b0:93e:66db:69b9 with SMTP id
 af79cd13be357-93ebd23ab8emr1131117685a.55.1791729741643; 
 Sun, 11 Oct 2026 07:42:21 -0700 (PDT)
X-Received: by 2002:a05:620a:198d:b0:93e:66db:69b9 with SMTP id
 af79cd13be357-93ebd23ab8emr1131114885a.55.1791729741118; 
 Sun, 11 Oct 2026 07:42:21 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b179dc0c8asm3854326a12.13.2026.10.11.07.42.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 07:42:19 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Sun, 11 Oct 2026 16:41:59 +0200
Subject: [PATCH 4/5] fastboot: add flashing lock/unlock/get_unlock_ability
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-upstream-avb_lock_unlock_b4-v1-4-a45aeca54016@oss.qualcomm.com>
References: <20261011-upstream-avb_lock_unlock_b4-v1-0-a45aeca54016@oss.qualcomm.com>
In-Reply-To: <20261011-upstream-avb_lock_unlock_b4-v1-0-a45aeca54016@oss.qualcomm.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDExMDA1OCBTYWx0ZWRfXyvyRjVWxO+t8
 ldhff/CZexh3JljFpsWOmN/BbNZyWFocVkpPbrWxhDuntGQ6EBFKQkj6imR4pUzkzoa7IF6L0On
 tJ9093p56Fn97oEszhY0TtlwoM9CytEZOJDjFRtQRV1z8CEJnnCZC4khrJECM0SDtXc3T7nZrWu
 7TFrBm0V/uDoYAFUt2OFlNWcnfYCnkiena/aH2eJbJQCblyRljRmr0sUdAk7HmJdygSCDBlpIB4
 HKjyZahA265V7wqiYC6rLi07AdGJMGrgexgBuaEUtIo4ZMS4UY61uDC7rbk58rbEUyOss8h7A9a
 BtY1eYjjyJWV6AgGDYnaKUasl2K/JX63kukxxEM8KcUBn6bnEZkCpo2KUkP7QbAKW1Qlj+6LPSO
 EoCX9W9C5Q5ngGAS20ji6jeg5ttURTuAtKqV7O5SxJf7fikc2wkUG7arpHuMw5NOwrlKZC5oNuF
 Ln7PiXNccxyAPcC4F0g==
X-Proofpoint-ORIG-GUID: 4pfK1MhnmDaGufs8JsobLYJCIe5DjNwm
X-Proofpoint-GUID: 4pfK1MhnmDaGufs8JsobLYJCIe5DjNwm
X-Authority-Analysis: v=2.4 cv=W5utxhWk c=1 sm=1 tr=0 ts=6acba04e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=JsdSkJyxCPcZmfxNhm0PvA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=YdF6uEpPCKYSNo6gykMA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDExMDA1OCBTYWx0ZWRfXwnvml7xwjt1o
 ADphB9GqqTj5YwwYIcjKWgPtrB3WcbRsdOker2QOELfalZaBLnp2E4ghzfUEhhTATmFJirPLlh0
 LwbI5JO7NlLoQ6ldZ3zmDHm9ngRHaFY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-11_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610110058
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

Android's fastboot client changes the device lock state with
"fastboot flashing lock|unlock" and asks "flashing get_unlock_ability"
first. U-Boot has the state in the AVB TA (avb_write_lock_state(), used by
the "avb lock/unlock" shell commands) but no fastboot front end for it, so
a device could only be unlocked from the serial console.

Add the three commands and the "unlocked" variable behind
CONFIG_FASTBOOT_CMD_FLASHING. As AVB requires, both transitions erase
userdata (and metadata, which holds the file based encryption keys) before
the state changes and are refused when userdata cannot be erased; the TA
resets the rollback indexes on a state change. get_unlock_ability always
reports 1 since U-Boot does not evaluate the "OEM unlocking" setting
Android keeps in the frp partition.

Tested on QEMU virt with OP-TEE over "fastboot tcp": unlock and lock
erase the partitions and flip the state reported by getvar unlocked and
"avb is_unlocked".

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 drivers/fastboot/Kconfig      |  11 ++++
 drivers/fastboot/fb_command.c | 115 ++++++++++++++++++++++++++++++++++++++++++
 drivers/fastboot/fb_getvar.c  |  34 +++++++++++++
 include/fastboot.h            |   3 ++
 4 files changed, 163 insertions(+)

diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index 1887f78bcec..b5ca8c8dcb5 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -248,6 +248,17 @@ config FASTBOOT_MBR_NAME
 	  specified on the "fastboot flash" command line matches the value
 	  defined here. The default target name for updating MBR is "mbr".
 
+config FASTBOOT_CMD_FLASHING
+	bool "Enable the 'flashing lock/unlock/get_unlock_ability' commands"
+	depends on FASTBOOT_FLASH_MMC && AVB_VERIFY && OPTEE_TA_AVB
+	help
+	  Add the Android "flashing lock", "flashing unlock" and "flashing
+	  get_unlock_ability" commands and the "unlocked" variable. The device
+	  lock state is the one AVB enforces, kept by the OP-TEE AVB TA. As
+	  required by AVB, the userdata (and metadata) partition is erased
+	  before the state changes in either direction, and the TA resets the
+	  rollback indexes on a state change.
+
 config FASTBOOT_CMD_OEM_FORMAT
 	bool "Enable the 'oem format' command"
 	depends on FASTBOOT_FLASH_MMC && CMD_GPT
diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
index 18d86988f4c..2e5ce981aff 100644
--- a/drivers/fastboot/fb_command.c
+++ b/drivers/fastboot/fb_command.c
@@ -16,6 +16,9 @@
 #include <stdlib.h>
 #include <vsprintf.h>
 #include <linux/printk.h>
+#if CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING)
+#include <avb_verify.h>
+#endif
 
 /**
  * image_size - final fastboot image size
@@ -47,6 +50,9 @@ static void oem_console(char *, char *);
 static void oem_board(char *, char *);
 static void run_ucmd(char *, char *);
 static void run_acmd(char *, char *);
+static void flashing_lock(char *, char *);
+static void flashing_unlock(char *, char *);
+static void flashing_get_unlock_ability(char *, char *);
 
 static const struct {
 	const char *command;
@@ -128,6 +134,18 @@ static const struct {
 		.command = "ACmd",
 		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_UUU_SUPPORT, (run_acmd), (NULL))
 	},
+	[FASTBOOT_COMMAND_FLASHING_LOCK] = {
+		.command = "flashing lock",
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING, (flashing_lock), (NULL))
+	},
+	[FASTBOOT_COMMAND_FLASHING_UNLOCK] = {
+		.command = "flashing unlock",
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING, (flashing_unlock), (NULL))
+	},
+	[FASTBOOT_COMMAND_FLASHING_GET_UNLOCK_ABILITY] = {
+		.command = "flashing get_unlock_ability",
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING, (flashing_get_unlock_ability), (NULL))
+	},
 };
 
 /**
@@ -589,3 +607,100 @@ static void __maybe_unused oem_board(char *cmd_parameter, char *response)
 {
 	fastboot_oem_board(cmd_parameter, (void *)fastboot_buf_addr, image_size, response);
 }
+
+#if CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING)
+/**
+ * flashing_set_lock() - set the AVB device lock state through the AVB TA
+ *
+ * @locked: new state
+ * @response: fastboot response buffer, filled on failure
+ * Return: 0 on success, -1 otherwise
+ */
+static int flashing_set_lock(bool locked, char *response)
+{
+	AvbOps *ops;
+	AvbIOResult rc;
+
+	ops = avb_ops_alloc(CONFIG_FASTBOOT_FLASH_MMC_DEV);
+	if (!ops) {
+		fastboot_fail("cannot allocate AVB ops", response);
+		return -1;
+	}
+
+	rc = avb_write_lock_state(ops, locked);
+	avb_ops_free(ops);
+	if (rc != AVB_IO_RESULT_OK) {
+		fastboot_fail("cannot change the device lock state", response);
+		return -1;
+	}
+
+	return 0;
+}
+
+/**
+ * flashing_wipe_userdata() - erase userdata and metadata
+ *
+ * AVB requires user data to be wiped on every change of the device state,
+ * in either direction, so userdata (and metadata, which holds the file
+ * based encryption keys) are erased before the state changes.
+ *
+ * @response: fastboot response buffer, filled on failure
+ * Return: 0 on success, -1 when userdata could not be erased
+ */
+static int flashing_wipe_userdata(char *response)
+{
+	fastboot_mmc_erase("userdata", response);
+	if (!strncmp(response, "FAIL", 4))
+		return -1;
+
+	/* metadata is optional on older layouts */
+	fastboot_mmc_erase("metadata", response);
+
+	return 0;
+}
+
+/**
+ * flashing_lock() - lock the device
+ *
+ * Verification errors stop the boot afterwards. The AVB TA resets the
+ * rollback indexes on a state change.
+ */
+static void flashing_lock(char *cmd_parameter, char *response)
+{
+	if (flashing_wipe_userdata(response))
+		return;
+
+	if (flashing_set_lock(true, response))
+		return;
+
+	fastboot_okay(NULL, response);
+}
+
+/**
+ * flashing_unlock() - unlock the device
+ *
+ * The unlock is refused if userdata cannot be erased.
+ */
+static void flashing_unlock(char *cmd_parameter, char *response)
+{
+	if (flashing_wipe_userdata(response))
+		return;
+
+	if (flashing_set_lock(false, response))
+		return;
+
+	fastboot_okay(NULL, response);
+}
+
+/**
+ * flashing_get_unlock_ability() - report whether unlocking is allowed
+ *
+ * Android gates this on the "OEM unlocking" developer setting, stored by
+ * the OS in the frp partition; there is no policy for it in U-Boot, so
+ * unlocking is always possible.
+ */
+static void flashing_get_unlock_ability(char *cmd_parameter, char *response)
+{
+	fastboot_okay("1", response);
+}
+#endif /* FASTBOOT_CMD_FLASHING */
diff --git a/drivers/fastboot/fb_getvar.c b/drivers/fastboot/fb_getvar.c
index e8aa0e09aa6..92c8e702a0b 100644
--- a/drivers/fastboot/fb_getvar.c
+++ b/drivers/fastboot/fb_getvar.c
@@ -28,6 +28,7 @@ static void getvar_has_slot(char *var_parameter, char *response);
 static void getvar_partition_type(char *part_name, char *response);
 static void getvar_partition_size(char *part_name, char *response);
 static void getvar_is_userspace(char *var_parameter, char *response);
+static void getvar_unlocked(char *var_parameter, char *response);
 
 static const struct {
 	const char *variable;
@@ -88,6 +89,10 @@ static const struct {
 		.dispatch = getvar_partition_size,
 		.list = false
 #endif
+	}, {
+		.variable = "unlocked",
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING, (getvar_unlocked), (NULL)),
+		.list = CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING)
 	}, {
 		.variable = "is-userspace",
 		.dispatch = getvar_is_userspace,
@@ -346,3 +351,32 @@ void fastboot_getvar(char *cmd_parameter, char *response)
 		fastboot_fail("Variable not implemented", response);
 	}
 }
+
+#if CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING)
+#include <avb_verify.h>
+
+/* "yes" when the device is unlocked according to the AVB TA, else "no" */
+static void getvar_unlocked(char *var_parameter, char *response)
+{
+	AvbOps *ops;
+	bool unlocked = false;
+	AvbIOResult rc;
+
+	ops = avb_ops_alloc(CONFIG_FASTBOOT_FLASH_MMC_DEV);
+	if (!ops) {
+		fastboot_fail("cannot allocate AVB ops", response);
+		return;
+	}
+	rc = ops->read_is_device_unlocked(ops, &unlocked);
+	avb_ops_free(ops);
+	if (rc != AVB_IO_RESULT_OK) {
+		fastboot_fail("cannot read the device lock state", response);
+		return;
+	}
+	fastboot_okay(unlocked ? "yes" : "no", response);
+}
+#else
+static void __maybe_unused getvar_unlocked(char *var_parameter, char *response)
+{
+}
+#endif
diff --git a/include/fastboot.h b/include/fastboot.h
index b106d617749..e8b6e293173 100644
--- a/include/fastboot.h
+++ b/include/fastboot.h
@@ -53,6 +53,9 @@ enum {
 	FASTBOOT_COMMAND_OEM_BOARD,
 	FASTBOOT_COMMAND_ACMD,
 	FASTBOOT_COMMAND_UCMD,
+	FASTBOOT_COMMAND_FLASHING_LOCK,
+	FASTBOOT_COMMAND_FLASHING_UNLOCK,
+	FASTBOOT_COMMAND_FLASHING_GET_UNLOCK_ABILITY,
 	FASTBOOT_COMMAND_COUNT
 };
 

-- 
2.53.0

