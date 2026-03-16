Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A8CCF53D7E
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 18:08:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B67284159;
	Mon, 16 Mar 2026 19:07:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Wup22kg4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D680B8412F; Mon, 16 Mar 2026 19:07:41 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B596384127
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 19:07:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7d73e0e0a36so2141769a34.1
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 11:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773684458; x=1774289258; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XHJAokT6IXF1Z6fMwezaj0wNpXxdAg3NwM/Ji/rEwJw=;
 b=Wup22kg4+CKaLd8D04kjKQCmUOtYAEZHk8f5lqT0+PjAF5ka0v4YodtMSoHOJblM/A
 Jv7rwzZXiYWeO0aT6DCwZ0LrgeAtDuihQXmbPn+W/P8r+WrQ0VOoNphDiKhsWeBt2mD+
 yYBx3lcKoUBMdVa3FkB9dFEc4pMax6Grk+0+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773684458; x=1774289258;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XHJAokT6IXF1Z6fMwezaj0wNpXxdAg3NwM/Ji/rEwJw=;
 b=KBscnHHUIRXZ+/8ocmH3bgcXCn03A5EDjepO9pdAcEFGsgon7BmDsw+5cEg8KO73iN
 OHQqrShtIYugdZvspmMTZca71QrkvfB2pIy6r4LUDLgApx4OgtnNPBqPrknu0DrhgDsc
 PKosH82rxiEGPFV68kQDLIHIFWg1pn53sDBTTsOot8gG/EZS+nKHeuLg5XsVekAcrMC7
 Jfy3KCZ5yWtrI0B9a5DvQyMROLBVkMIk8JPguKFylti9dxL389i0Nc2H+ZDkXCdftR7M
 bE8LVGrJKdQUTncRU9VuFk7cfzXJg2jNVoGLg4PgIXWeRWNIAulybhNkpxnUL0jhy3A0
 mzsQ==
X-Gm-Message-State: AOJu0Yyeru9SgALm3olGPfXCndbV5gCAKhTA2AmKHALxf75oorTJ4qdK
 Hm5U3Aw/6gqS+g1XINjFPfhn9taRctYgDzNY8K1F4EMdMBrkRt5unbeEKxaCI4Ur6zE=
X-Gm-Gg: ATEYQzyPQLAHiy+vAQClnTtc8/mZn8sRnIk62Xl5zoKlDcBHqSZBwiYEv85Zz4vkN+U
 j3cqYmh+GaRDdRsTX0b8OvtM80/Sbb2nugoNEwMgicFLs+Aw6wlSGtgdmj3mk2sVCx8OluTd/HB
 HO5noVXmG6csbtCWXGkZj+9/Oh7GejO6njLEAI4Y0p/cC2e2HOdB1gndzw5mswwOWoQsPpYnzAy
 uDjyn8AqQaxd+7P1jg0xtZJVsMAPNNyn1gCC53bM3FgryYGO1z/asUvT0WEPzJUmk4qMHYGE6oo
 OwJrIoVHOE+3ahy7R5dJA1qkKHgqis2ZMWOfbWBgb6HsKxc0h5WkUU66tNmWt33TknLmlcQpdBu
 SBLZMCf0n1UiKuTo+aOndsPvFC37eIYGc+IpNQa1mAXLGEA4aMPI3uxBQQ+e623beBPaWCcTglP
 wtIgUYzAz0KCw5duq89g+LlyLN6wQiAaMdU7TmortibmWhi6Y0inqSS6SuatzDYPinwxn88b4qx
 B2XelTXNzES6WRDQ+6R/fnnK2e8mjsMkLpvG3Ef33yYutw=
X-Received: by 2002:a05:6830:6a9a:b0:7d7:b770:1682 with SMTP id
 46e09a7af769-7d7b77016damr1044471a34.19.1773684458313; 
 Mon, 16 Mar 2026 11:07:38 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ac32913sm13255393a34.5.2026.03.16.11.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 11:07:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Amjad Ouled-Ameur <aouledameur@baylibre.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Ryder Lee <Ryder.Lee@mediatek.com>, Sam Shih <sam.shih@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>, 
 Ramax Lo <ramax.lo@mediatek.com>, Macpaul Lin <macpaul@gmail.com>, 
 MediaTek Chromebook Upstream
 <Project_Global_Chrome_Upstream_Group@mediatek.com>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 "ht . lin" <ht.lin@mediatek.com>
In-Reply-To: <20260305102324.2797478-1-macpaul.lin@mediatek.com>
References: <20260305102324.2797478-1-macpaul.lin@mediatek.com>
Subject: Re: [PATCH v2] scsi: Adjust SCSI inquiry command data length
Message-Id: <177368445668.2276702.8683429061507538750.b4-ty@konsulko.com>
Date: Mon, 16 Mar 2026 12:07:36 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Thu, 05 Mar 2026 18:23:24 +0800, Macpaul Lin wrote:

> Per the SCSI SPC-4 specification, the standard inquiry data length
> should not be less than 36 bytes. The current implementation uses 512
> bytes, which causes detection failures on some UFS devices (e.g.,
> Longsys) that do not expect a transfer length exceeding the standard
> inquiry size.
> 
> Align the default standard inquiry length with the Linux kernel's
> implementation (see drivers/scsi/scsi_scan.c), which uses 36 bytes as
> the default. Devices requiring vendor-specific inquiry lengths should
> be handled through quirk settings in the future.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] scsi: Adjust SCSI inquiry command data length
      commit: 041364141b7daef8318a4b8495cac8570002773f
-- 
Tom


