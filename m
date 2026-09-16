Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D65EC88E5C
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 14:18:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3CA694072B;
	Wed, 16 Sep 2026 14:18:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pMTQTXxws_gF; Wed, 16 Sep 2026 14:18:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8C69F4072F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789568327;
	b=emZrf6uyxmhEtqp7a5yF80Gl4z7F9Pkn8b5gljAn81mRBXMmsk4Bcxn+cmM84495McP4
	 p3ui6vRMuD9VNgcSzIwv4uTV4u0wJIarbyZYtyHpxpnR4R4GbElzCeHXBtBh5tgk1+bLb
	 4x3012jfawPZ/ZNJwr5wifNUKxcWtNnhALZqlpVpgjvmt96hbd76kO9dX5YWEau4rewqQ
	 OQr2XsvF2XNEVj1qgksPsDri//7iVy8CXNvUyi40ViqTiFh5azpK5aSAQToWTWPT2d7nb
	 CELmthIgn4N5yBCOXBlyAQBRwX1vRRyFMW7nbAfgfGtL8gajSM2JVrYhY5t+gnM9xnw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789568327;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=RhF9pR8+ZPFTcRrTz9E4uX246gE7Sz8Qs89CCdw0CcM=;
	b=o8H9UNoQak6vrJ7IcDfCGkOiGReyjNKkzVm7sAfcfGuHXYCi9VlCX8bL2UsoA2wcsLfS
	 Ciy6ipOI+Z66cFmUSugphljheDoLYESUPFlh2Ll9KHhaEg04dzlgICa7Y7Nfi5+SjMV27
	 6o0jVuMB8lAV4+u2zopkrNeOLSQU40UDRyQD1ewK+k1eaP1g7MriYKhhKn/lq4HBLLKzl
	 uNj/cRoyrdbPgexa1e5UcLXYh6xwiJCJWt7ggXSoabp89T9pO34c5vjcxGkbA2KlfU8Bg
	 6doMa6tA6ikh1+bt/2TX8cDHZCNmB/Lp+u2rctQYU2n4/6UbfU4oyXW8RxnO7Sbd/8Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789568327;
	bh=RhF9pR8+ZPFTcRrTz9E4uX246gE7Sz8Qs89CCdw0CcM=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L0nCPmkNA9/TIj/IKOHIueahNDEx7qR0bnSpK1hMjeVKkkRbFaiRSp4qpxeAvedzD
	 ZK5wkY3ATMHCmqS1CNZ4TdjqNqrphWXspF6iCNvwAVu2zPXUMFyMw43TN+WzuOS1+u
	 oFpBupOZ0m8mR6l3hjB5BLrrXoq29Bdc+/0/7eV9LP5iZRT6NUTTYReHnOsaOuEGBc
	 TKGpr6Cx9b+40UR1YI8zd+KoKL9drEHcaOb7FFBhiTxqUjQldSE7eSVgdcTozrQoow
	 0EeoJh1c4wXrdr4+8n3o1FEQuxdPfgwf4qmCoQh31EnJKGvK/73H0zy7dR5Xg/nLd/
	 XhpAfQKPqegGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8C69F4072F;
	Wed, 16 Sep 2026 14:18:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 10C3ADD7
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 14:18:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EB0896061B
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 14:18:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VBdwkZSsXxnf for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 14:18:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 648B56081F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789568325;
 b=rb0ZZh0Nsq6dJw5KDWwqn/mHZeJyWZ+UyuPDSREbQHXNXJMTP/fWbC6c2xFSboLJ7VpS
 zLz64JwdIRimOuh0Tepui8lQoS1nKKOQPT6MKEq4e5aX/F0MuBD2dtJgeNWbR43dGC+43
 QLjq5zi9BS+txpGJ1BiMfv5oDT4OIP3nnOC5fzL+nyYfwpXcCB0eSjdtTtjupEve+wUc5
 kl7ypQGfw74RJOfrHUaqO1nndKZj4eHIS27XzctdfuQOv2ofMvPog5k1dItIw42SKraS0
 KFt6EOWQyJs9ULtvejeL4sRX73MsTZyrs7PErtzKI5w4hTfsv0quEVKNMbzjAFifCaQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789568325;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=RhF9pR8+ZPFTcRrTz9E4uX246gE7Sz8Qs89CCdw0CcM=;
 b=talrVoVyTp/g/pYuZjcQK4aQcClH8NoZR/Xed6RESJhYUrE1hsm2z1ymkoYVAXcPM87M
 cHrdpISzlV4o/eET3ImrYPNeTJJYsHTvtjOgYuAcShSGmEnKlqjwzk91NJomVF1oCwfOc
 KRyfJC3sMN6zcKqKcbByav59euT6MeNkAf6ULFRGg0OIDubvgrqpmEgZbD0Z8GcI+wrBF
 SAv+TXqCrlZV7RlJbchHDB1+Xu9557F9yGcMqmPUMdGa6vPRVAXvmGELNJsouuRW5dte3
 GoRs79KCnXV+7ppO2zIO9P6IgtNONBku12foj4i+gD9HkCOt2/Q7f1GfddYFREEI3Xw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="lKft9/y0"; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=lKft9/y0
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 648B56081F
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 14:18:43 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-485933b2522so649211f8f.0
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 07:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789568321; x=1790173121;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RhF9pR8+ZPFTcRrTz9E4uX246gE7Sz8Qs89CCdw0CcM=;
 b=lKft9/y0UubWLIERAB6m+M9KtycLKqvJD/pWkfPtgYCOFzK57Hh7QKKg/L8gaDxQ8c
 8d1asLeIDzQOh2tEQLcmLC7Ue1SJRnzvxDsdCIHyiibx9T9tZmulqN+abwn/zjfGgg08
 H3PvAEt1yYyylzOhGeOzFNzs6XoW0B1Dtg5i530XKEeVfyblgRAtDhHb6ULi2jYCpGQI
 4HAP57ny1Y3R/7Zmypiih4RdATndeCMWWlYVbFvmkrV6zJEEbU7ysCAVCdJrmHJRET5a
 pX5Dhac9zlbon+vzvSsDNCmDc1GH5SFk07h5AdUBFQkWTlxYRL682pR6me39emNhPtXg
 utNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789568321; x=1790173121;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RhF9pR8+ZPFTcRrTz9E4uX246gE7Sz8Qs89CCdw0CcM=;
 b=CbbnNUyJpAuigTJV/ur2+H5lxW+d5umqdG422pl+ge15ohJDSLWobgRku51zaYbh1W
 3CBHx8bjUn5aU4C4GnUjcDlmzo1XcS9rtItz8bySikF0nN3oGB+UvZuFIssVaEnrwlmi
 6r+/EFlZh1/FEmOXH5znVqtnmB1RscBOKZerU7pI82/6WAh/+BOHmZPNuh0N3IMnQ+Ra
 6CgQFz7ryovqilNsc15TrYl48vCbyIZvx+eI3OybEmAeibzx92mYKBco5rMoCXY63tUD
 UTnq+6UnBvgSiC2z0Az86iQ3wsFSDw+czlfHQ12ftjRkOFLttLkTK1csWI7ZXnDA+fa9
 yopQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwz5UzUT1lxuHV5hNb2thAcV0cBHfSM1OT3rtF03vKs4glVhdaCAtvYnbTUyUJZipIEocbRZ7c=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nlq+Hm7zdItHinJqpcWbaaDhIdW2Bcp43Gr5qB+w8sV92ExB78
 g2nOpX9JUeOOTvgLzwje+2LQwmW5CWS2St3jxzvCQzJ+8SCTAdZzHY4Ig1oXxYBTIhQ=
X-Gm-Gg: AYBFou071qCZKMcUNwjzzvKHnJfKB6xUek2edwg9/KfuU6ih7kFjb7byigSREcBnJGj
 VDHIso1UHUZeRANyOBR7PEcOVUzZeR+wJQk7bl2jCMJxLANbPAv327OqiXROEWFAXFCRw6QdIuT
 qjBp2JIiuS5Aqu5Pyrj9UumW5sPA0qeBB8/SLoiP8WF9n+2jU3TeEVyguffJCM0lrjfoDUr/upI
 VnBOqmNHq4bF59cIT3j7+t55Kt0NE7oY9G5cI+WWCUZE4AoxaNGIdDy7UdjXEVYnHmOXxJQN4WY
 F4SampUlWJNWFzhFBQiomHF/5QZ0Gz+i1RBIWcbfM67DZpDHgFyIdzO1HK10BDwjOyr1Lr/M9mI
 ZrK7ToDrLgKqXZ+ipwcVh8+NRj/VzfxlICkAhqKvwL6h3+fwzFLyMfJkd5p1CmP90wdQOQBFrq2
 MAo5USltIukJIhTBs2pkBU9amBjU9WpBYu/3m4IWUkTARgme7ELfnV3OWmfh1QPm6EJ9aXPUvNk
 IlI7/gS1ddWBIe9GUyewFWh3H3UAxaoWvFvgEJpWRZxA0/qjDBaae/3HbWNfCltlN0Q07UpKRdl
 qnN7KcsvtIt9vslV5XaEJ7LOrm57UyosTFj4ci8ul8eOV6nU4YS3liE=
X-Received: by 2002:a05:6000:29da:b0:484:3314:eff6 with SMTP id
 ffacd0b85a97d-4870d26c12amr5720740f8f.28.1789568321323; 
 Wed, 16 Sep 2026 07:18:41 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bef7687sm8575291f8f.1.2026.09.16.07.18.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 07:18:40 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/6] power: domain: mtk: simplify Kconfig
From: Julien Stephan <jstephan@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Sam Shih <sam.shih@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, David Woodhouse <dwmw2@infradead.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20260904-mtk-power-domain-mt8189-v1-1-ab9d8cd0f01a@baylibre.com>
References: <20260904-mtk-power-domain-mt8189-v1-0-ab9d8cd0f01a@baylibre.com>
 <20260904-mtk-power-domain-mt8189-v1-1-ab9d8cd0f01a@baylibre.com>
Date: Wed, 16 Sep 2026 16:19:22 +0200
Message-Id: <178956836273.657813.11020351536962709825.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1789568379; l=587;
 i=jstephan@baylibre.com; h=from:subject:message-id;
 bh=IaBhwdoyqvAXAWIU1Jup/OdAehUmhDTwSYZFM4LvaqQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgphAWFBQbyQxHwqbCvwEwIl9NQxnNa
 Ewt+3w/AUXP10QAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEkjpDIbbPhaw/n7Qf8BASmLJXIC1zRKNecgMAECP0J2jTTtbYuj1r3J+M8Wvz2lBkHsWZQ0iH0
 YoMvYQgYweww=
X-Developer-Key: i=jstephan@baylibre.com; a=openssh;
 fpr=SHA256:PPc8djUi3lnQXuiRHH4CZ/icbEYOsksrEsOV7pDEmZg
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

On Fri, 04 Sep 2026 09:46:28 -0500, David Lechner <dlechner@baylibre.com> wrote:
> [...]
> Note that some drivers are named after the first SoC they supported
> rather than after a target, so mt2701-power-domain.c is selected by
> TARGET_MT7623 and mt7622-power-domain.c by either TARGET_MT7622 or
> TARGET_MT7629. Only one target can be selected at a time, so
> concatenating the two symbols is safe.
> 

Hello David,

Just a small notice: depending on which series gets in first, you may
have to also update the HDMI config.

-- 
Julien Stephan <jstephan@baylibre.com>
