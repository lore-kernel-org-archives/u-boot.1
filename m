Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBB4C9832A
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 13:43:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4C2C6406A2;
	Tue, 29 Sep 2026 13:43:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EzKZ8qrUE7lE; Tue, 29 Sep 2026 13:43:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9A555406CC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790689406;
	b=TEq9MqmtD/L0x0yKkioRp2gIBGppSiW1P6g4rbPnBh+lH2HIIaIz/q8ctfNroiecbuFG
	 qIrkIBpzWHzSagQCUtn2XPkYJJZRkN2QmrsZ862gZYIQOf6CBZashwaWNupHRvfcQdD3k
	 0yuIlYQTXcWKWN+H67NENLahyVOpiXkDBHFIw4NeowAsGHcf179qy7FkF3Vfyi0TpghLO
	 Efzx2DG1Q0RZssgwFmj21/eQDA1vePGH+NI+pusgPIr605yKmfQ8uqgDls3iRc6jzAy3Z
	 m8fb4l+ZDK0oCRQ+8X0uzD4KLAbHTm4CWkew0Syrchr2uICQp2UlMdek+7cvdZNRg6w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790689406;
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
	bh=f/8y4Po3IJW4GbSkaVXfR0jswNQleEm8WRN8cNohfYY=;
	b=F7ZD9nMam82LzqRf6WrMuKgcA5oeV5mK8I7oBNs4g7whI0mN0DU2zJc5dZzxZ0gF7RnJ
	 TXOi20re7z/tjYMxidFZxyeVZtRBG/FaEsIKLDXIZ4unYWf9jaAsidIhGKEA/j9p7+sJR
	 DhWMeggrlDGLkcFBN00kpjmxfwxsNxPCE4/kkozVR1m3iCeLFLrexHwJ4C/sBP4oZ+0nj
	 RXnRXSEuY5BnroXkWpkFp4FbjRXXnjOM3Bjqf3W1rmouXwjzV6Yq+RBW0muneR5TOb3DK
	 pgSrQGp/DKYXEh7KKcmTkHONgcAOwqpV0mkr3S9M8D+MYvzWkMhWIcwmdEzIGpfvrvA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790689406;
	bh=f/8y4Po3IJW4GbSkaVXfR0jswNQleEm8WRN8cNohfYY=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D9I8K+3NauepLvw8xMW3+CHC3CNv64v5NXMXgZx1OSYATXxPTRxKzSW2Pq5ipz6j7
	 aoARR83Vg2RAD9LmO7TJMhknfMw15CjPE9binVEGudhWlQP3ujo1nDxoQZOAzu45rW
	 p4H8A609WZ7tO6epGDmTlnZ0X73LRu6tHSWtnneyVlDdqHzj0a4v0RdBbctcLPGR0i
	 wYywhm6C9V0hrLv982IZSz/XJim01xuM3NCp0ZZi2QPddsVJNr5NSufkRqw5/bRPuw
	 OQ8yR1MjFxs2IaUOjKYVcfjw32xPsMzdG6Z1OCxi50Hay8oQANgJDusutW9wuqS44F
	 /ktmwU3VT2C4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A555406CC;
	Tue, 29 Sep 2026 13:43:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 123B32E5
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 13:43:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0F70860782
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 13:43:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a_z_bkvCnLap for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 13:43:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org ADF286071D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790689404;
 b=Qq3WZ4wnLTQ4z1dFBFH+x+fxxHYS7sfsf3bko2TmEae3lD+VMNwakgEpYowKkJSwDb40
 TCSDGGCJSOvHD3qWDXt8t9Bv+FYM/o8ADppX4LHVDsJRV80EWAaTQ8fU+TSM04SZ9s3G7
 LuAv7S2MRvKLZs1sJgrde8UfXAT/KxMsc6mculJBUABOCFsnffWwIo9EZUkpLetleBoLd
 pF1njapMLxS2EWuWuO8w/rdjLwBT58WFFH9rjXEaY4srdtmMwW7PUdbGepBANERu7OTaU
 x4q0oXT5NohI782F4IeAdp2Wt0+/0xb/vtd0yNFnqmPgb/CXIaQgrRWg/33FYc9OkZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790689404;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=f/8y4Po3IJW4GbSkaVXfR0jswNQleEm8WRN8cNohfYY=;
 b=QdFYWVq1FbuXKj9PdfCBgxJiSWDC8+VrgrD/pcPjHCuURrRTbUQNWkNUuD+MmNcSBn6h
 GRbtCY3XnUG88BziwNu2K49q+yZhI15l8hyvNb4zwk8oUz50SPm6cBiN2DoNCf/fYZNVD
 HcTQ61+sPu3i4GDpX1qSZ2MuBoHJMwmjOgIosuxyg4e6chSr39R4+4taxpHAnK2Mgnu13
 GmdVFnCfsXKMhcuVG+/JT2bbSm4goFsY8f3IwWK50fmN9fbWzdD7vPYdCd7VIgwi51gp+
 INj++aGum/ET9ANIeaRxP62hALTU9axx0lvnQ4A70zK4sxU9HNV1JH9FnmH5rrJPQsg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="egby/1JI"; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=egby/1JI
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ADF286071D
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 13:43:22 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e6b885ef8so24084515e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 06:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790689401; x=1791294201;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=f/8y4Po3IJW4GbSkaVXfR0jswNQleEm8WRN8cNohfYY=;
 b=egby/1JIN+2uFl1adRnJVexvjFoHH9dM50eMsVf0x9Uetnph1nF9nB/ET/n8iOfNmY
 JzuNli78lw3u7Prf9sD1mfew9JGTVh9gwIOwcwHjK9UCMlidgCUUi1uwrUFJlhh2DjGS
 95awXN6tkBeAm3B0t0IY1CYO+P5SC9K0O2PxdtMnEjkW1MMzohi37ReyDsc0pow05mtl
 sNdVIs10pdQTAlmqaS6yZsKJ1wf/1WlnCmBGAa47DNlmm3frLMG9o+cOpQGOvJI3/NR7
 51nHhrKd0C2r2nlwPIFbORQY8U0UCUSWOnzNZKcEHJBXBTyi00i59smle7U8yJrtRhV2
 RirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790689401; x=1791294201;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f/8y4Po3IJW4GbSkaVXfR0jswNQleEm8WRN8cNohfYY=;
 b=LohKRyOXhSYgOruZG8X+cOaOC4BiRQPnj0g0XkP90bDiH9eQl1hgT4wG/Xzf38dX5h
 MNYuskQ0EOhIniOH3zAui5IE/VminVhP6/gcj5Kh5Z5pyyNhhhBB/zBbcdc+VkBmtSSC
 PBYhFajZXrlVl29kEm8mbBPnTB41xoq3C9nHCsPuVIprXsYrp9Or0Y0Z7nu2nmjigFaO
 IWWiENWKyHGNhEeWRb+C2w9Q+sErlbgHsJHRKOR97IsfkxnhBU3TaBHf4axedfoCKaZN
 iA6Gpz6zunfqcYU7dGaFuvp39MNajKnTWb7a/R5F7dw6kxQObQnjbtXd8BdIiI3BNC8S
 PCwA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwNXJXiUPCmOQ+jJObcQ6SQkcO5CQFEMPeszGnLt1wR6JK4guVWETHNsR4cTQXVK+EwHxnHKKQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nwaE/rxDJXE7T1PeyfvwrvomHvn8pUGdf6C9jUtlUzMMnfpw6Y
 JsKs20c/nkg2HVLkU2+lBwdJ9XmRVZMN750Wn3uMQPAVI3XfAZGLtbkgB4BvoZXcxVY=
X-Gm-Gg: AYBFou1tix16cfRc02sT2epUV1VAJX1ER5PZ+sfqwKD4fE3cJhcAymKHziSK4yY/luZ
 +LoOllQl9zTGtjDtDEGTe8vqCzaPWXeD/KyRn4g8uvdDNcz3VwYMl8EGXbF2fr2mAHzbC3vXMsc
 s1eqNl/CzyTXqebaam6C1QDD8cKshBd1duYlfkYr/4ps4QysnnLRB7UDr0dHoaovZicyG4R+iLx
 nftq5+OVh/0pZToXdObjRRRY6cH6IeShRph6FkvAAqdc+LkGrFNoExGSQ93/T+RKgwA/w2i8Vhu
 JRjBldesllOwgHaginVGOrU0iIcEhXgr9CRGa9WFFLdml053SPN+h188KI0mjOhpJUpy44PqBmo
 ihrFDhlqF2beA7DKkCXMSqi2ZeQPUl1yu4Z7dtlYScYprNgNWLcoi/Pbfc9T565pcjMm01JLNGm
 oF+Tx2cQv86xYLUL6U6M8eAAVudfNyNvVPfK7wGL3zW0kYmzQAY36Ectz9OiYHyBSFZXQeE4U+l
 kGuy2V17ZBQ11tRHUuTZeT5pmFWahMRZVBPDrZjrH/0UqANO45cKwvVFBVS6xOf3vJpmZaIGDIa
 F5FPbJnEdfrIWmIt7Ao1PEMGes7alMZqR8oyQhjmFqp8qsoKMZ+J0MU=
X-Received: by 2002:a05:600c:1d19:b0:49f:e427:e88f with SMTP id
 5b1f17b1804b1-49fe66f1486mr275585095e9.21.1790689400730; 
 Tue, 29 Sep 2026 06:43:20 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af50513c7sm4216022f8f.16.2026.09.29.06.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 06:43:20 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] clk: mediatek: mt8189: match the mmsys compatible
From: Julien Stephan <jstephan@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, u-boot@lists.u-boot-project.org
In-Reply-To: <20260924-mtk-clk-mt8189-mmsys-v1-1-cb4abe521454@baylibre.com>
References: <20260924-mtk-clk-mt8189-mmsys-v1-1-cb4abe521454@baylibre.com>
Date: Tue, 29 Sep 2026 15:45:32 +0200
Message-Id: <179068953203.1887049.498679349097543602.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1790689535; l=234;
 i=jstephan@baylibre.com; h=from:subject:message-id;
 bh=DkLgkAr7fv2ZPAA8Zc3ZHZdsH9F6vq3WDZW+k6kot3U=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgphAWFBQbyQxHwqbCvwEwIl9NQxnNa
 Ewt+3w/AUXP10QAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKR34Q8MtsNESSgR0iAWLFtLQ3s0WTxS+AsGV8BhsG7TiWJKhdVEr8MuDeX25yjVzeaWt9nMjAM
 pEI2lBAM7MQU=
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

On Thu, 24 Sep 2026 07:54:12 -0500, David Lechner <dlechner@baylibre.com> wrote:
> clk: mediatek: mt8189: match the mmsys compatible

Acked-by: Julien Stephan <jstephan@baylibre.com>

-- 
Julien Stephan <jstephan@baylibre.com>
