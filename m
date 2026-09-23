Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F35C982FA
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 07:22:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 24608406C5;
	Wed, 23 Sep 2026 07:22:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZkShZRduPGG5; Wed, 23 Sep 2026 07:22:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 18216406AF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790148136;
	b=gYNIiZKbCSVqKD9LFoGEgLrLR+PAY1uGWhIwfAu6k4/vbyFmuPSSX3Y4YsG6mI3X0GC+
	 jAtmgCcXucoipSPkf8SVJaW0P1E3WuCKsdmyuEdchIAhiDfKhB+vVMCeD1DcLXmHLwWw3
	 M2//RS6RiimdGI7d59zH4GYLIsX27yosyMMOgdI5UsyfIp4PrBiSwS8cPwI8YOg+GEF4W
	 IlpOvTVXTRj4Wz+9SQDf9Hjtxa1sqmvORtp8PM62LUaydGwOxMVjHn0/fOuYY0BsUYpg4
	 i2LlpJb5C6HwF2TR9SaLqvREuoakuGy2ZZyeqlj0GFCDz6J7fCcZl3TWG0xfnXP/63w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790148136;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=AFkKbG5PHMQk27MMVKfudm/3r77AGUn+lCi2H/geak4=;
	b=Tclg6XiDwPhlVWk+H6VmBG11h5UdTJfEKW2X1rbdxhwLiFp36s8YdXlpoUAY5MkeBTJD
	 NcClhyI9iUkMhFcK+p9Ih2sjq7YBPKd1HOqHyDvkLi7BQQVNhTlV3rupbhDBxKkbiLr4U
	 lrN0v1pwjBtj/f/9rOaShCoPu6K+MjO8mqgZGg+XrLaEaF9AsEbIeLUrgxx9U7C2736ma
	 GZAkr1UTEX24X0k/JNCYx/FAefDm0b78bSFZgJ05WXTh68mcmUmmCjK772/r9A7zvD2Ea
	 NZiUeMTO7RdDABnebg4wm+DsTCOxOFJcL3kgArTP3EuUujuZ0AcSbD4+CjQ5vmNhW3Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790148136;
	bh=AFkKbG5PHMQk27MMVKfudm/3r77AGUn+lCi2H/geak4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G7lvC+aunaIayc6Do1oiDR37eGNroxK9O+hubO+gVKGBuOEaS1j2FzUei0QjZ8Gv2
	 RPkXctyNfPgeSEcKpB3qAyrNYM5EMuQsQYUW0Mc0adwLYgDM4t+4pwEd/G1EEe2/el
	 mFhMIp3vHhR04vzFvhRexkCn2Abk0Gg3r3I6M8jMRGpWTKtSxw0OoXpkDPNkIFnXa0
	 ZNMLZJBvnuODOLYiLJXMhSHwrMxnX2IHR/7XfXko13OOl8dhhGd0lpyDUHVvuEPXM3
	 1as9AAKducomG4ONezDwqgoLh+g5SzTa532x+NIlUqL1MWDYWv6pFC0CVvJKdo6m3M
	 f+NfD7JQeyNbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 18216406AF;
	Wed, 23 Sep 2026 07:22:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F2DEA498
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 07:22:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D94E560641
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 07:22:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G0Zh2dVm7_XY for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 07:22:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8195E60631
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790148133;
 b=i2gBi+L8wcLJzckdtCCosD4gyIpDAmdW4E14SfsW5vowR2koRmUXyIqnfdYZb1HY73/k
 5rpBrGk0QSqX8jkxHX27E7kDjP+1q9k+2h0mSnxpe5BYAdkqgTiK9VkrnKZUPhchp2gfT
 Q502x2U1QN3Wdnk6o4yiaiunSB6OkazGB+Rj4i8SfqJviEWJPl/DzcLjUMnjxe/NxhXyA
 4LJo4N1/2nOQbc2AEvKEvJndWG84CEYxNvxvPxA+vCrIGqrx3/y7yvmBI4x2C5BAh+p/n
 U4KSYIR/BoFTc6PbCGjOa8l+uthUiBtQIeNr+8aWSXiHK+CrojItZvs1AHq0BkHlFRg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790148133;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=AFkKbG5PHMQk27MMVKfudm/3r77AGUn+lCi2H/geak4=;
 b=fDUWlbApHcj+zUS2CKcYzJ0iJynC2+wS4L8Zojj2pRQvKq5NAJOg0UXqvGu+3+S2zVoK
 WXZeLXJzzfGbnDsPzDp+sdGcPaEi6aVi+HBBsi+M886guBfvypzndQ9Pn4GPoT28wjpBX
 2ue9qpNhP4/4wwKF7ebqqjueRFXFgKKT+o+RfkNohkjwrWYIbVTNQ+AballNfHO+yuJe/
 hNkHvvtlD5Ys/MLhfaT7zYWaBx4FWWv8rUPwjqdCX6K+mqK3PvQnnvNvQT+LRIl++Jknv
 lHTF7mLgo14RMzcl3Jtqk8fQzeBwlcndsHlMUuG4O6i+O/srlBDNpIzbv/mxUdXYonQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=lex.la; 
 dkim=pass header.d=lex.la header.i=@lex.la header.a=rsa-sha256 header.s=google
 header.b=S4oUfqEp; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=f@lex.la; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=lex.la header.i=@lex.la header.a=rsa-sha256
 header.s=google header.b=S4oUfqEp
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8195E60631
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 07:22:11 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d37b5so3167205e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 00:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lex.la; s=google; t=1790148130; x=1790752930; darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AFkKbG5PHMQk27MMVKfudm/3r77AGUn+lCi2H/geak4=;
 b=S4oUfqEp5QcuLjyEJzrEAwLzRHxJY8Q+bE1fXT3wLPRcUKniWPovh8X/yorCKxqm9H
 HwiubMXe39HW0AYeGUp8qcGoPa//2d6ydQ4ch1dLa5fYBBxjRPynZ2y7Yl1d8bo1rxdA
 FZqFJDYSwy1iyqfGsSHYXrYc2/vqNCFmEEJFiM5S/A4rCVd0a5AI+m9tChX4NMw3ZJ2q
 g8lx4gW0FE9/chm+S06cEbDeLEJ7tHJNoi/tqVNWPTwMr1qJtxvyBeh4FUhbOlDiAKIk
 NSMkUZvvPhYBwAoXfUDGa+exAoAUhbqX3x0Zy5TeOmBB/+WQxmS20vXD8O/VyRGYM4nj
 dYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790148130; x=1790752930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AFkKbG5PHMQk27MMVKfudm/3r77AGUn+lCi2H/geak4=;
 b=Z5H0JfxXRsBTPVmOI3zK37d1za14cbL05HDPmfIS3+ic+K6j+AQEeNLINRZTNCohay
 KgKO97a/6ciS0835//2bfDoxswB/Tya7tTNCsjohefmGApyT3pCGVhlka7n3DIKvuBpp
 oZYcehwSW92cHf3e190Ij31S+hkhvidCsrLMslcwbHztEBJv3WTLisyTcuwLgH72OAdi
 jkVWzQ6+/39du60xry1OZAwR84KgfiNS/8BDheJgnQesnJDoRcmzBGPVRkbiELA8GtwQ
 jxcMAl4N8pU78Hv9oGzjUpPgacTDLGK5w97yE1KlBHUc1InyVSVfAtR3X5ujZ4V4veEF
 RsYA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwPkTYJ6gAVO0U5ILwXR02QmgIOIYHoL3ldrQ+VUNN55/DbANowyuayILXRAJOxC8vNRBje4RI=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nLeksfxH6RiBTJwZu+fnX1t2kqrUhixsXTN0InZh7SmTRMbzkV
 uxiQ49JTfnuKH2GSjK+Tu0l3REsOfT7kk1989db3zIifiJpljHjmHOu34PQr7gQato0=
X-Gm-Gg: AYBFou0eEbUA71HhQqfH0VnYM5bRpTn9QNxQJcnSGhGMbuZcXrD4cDKpZI8hhBLIdiH
 fRIFt2whVgUuWP3kjnvwJE6Ino+Xm7dqccsSgVccjzuJQHURxKBmQ/BCLzO1jbKq9wIYj+6vtbB
 hJPH+G+JfLGs08TnmbpHS7pZv9fnzfriX3p6qKm+FTE73mbkcK/So4ZR+YHi3F2ZWeGhCwwo818
 LGwJqFCgh1P1chIfYbE1zuyUMrzlmrUFJp8ludVC4Awk4HOcA9MtzNGPUfKZdPOKJY1CprFjUfH
 UErSve/yuyhC9ufD2KtmNjl889Vef5Ic2q9Wjm407AFsoEwRbtKDhEI1EXTJiINqnsln1IACFTr
 TE9zsEi5+DafbTmdtKYJv9zedwPXdbdGTI34tf9RSAoKsxjX0Jlg5T9Rhv3L7L06xlh6cDm5ZLl
 apZZstuz4Qw/7h/6wqr8KFoURKxsOe0FRAJirfkRaj6I8YUU8Npg==
X-Received: by 2002:a05:600c:c493:b0:49f:ce78:3564 with SMTP id
 5b1f17b1804b1-49fdee0a323mr17683335e9.21.1790148129608; 
 Wed, 23 Sep 2026 00:22:09 -0700 (PDT)
Received: from remote-01 ([84.17.55.230]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe0c4b51bsm29888835e9.4.2026.09.23.00.22.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 00:22:09 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: David Lechner <dlechner@baylibre.com>,
	u-boot@lists.u-boot-project.org
Cc: Aleksei Sviridkin <f@lex.la>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>
Subject: Re: [PATCH v2] arm: mediatek: allow a board to carry the arm64 kernel
 image header
Date: Wed, 23 Sep 2026 10:22:04 +0300
Message-ID: <20260923072204.1248855-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <8edbca32-851f-4694-965b-677af74e59e6@baylibre.com>
References: <20260922193031.785941-1-f@lex.la>
 <8edbca32-851f-4694-965b-677af74e59e6@baylibre.com>
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

On 9/22/26 3:48 PM, David Lechner wrote:
> We don't want to add an option that is only used by downstream (code
> janitors tend to like to remove things that aren't being used). But I think
> what Tom meant is that you should add a defconfig for this board so that it
> isn't downstream anymore. :-)
>
> Then we could do something more like board/armltd/vexpress64/Kconfig where
> we just select LINUX_KERNEL_IMAGE_HEADER on a symbol that only applies to
> that board (so no MTK_KERNEL_IMAGE_HEADER and no config prompts needed).

Adding the board works for me. One thing to check before I do it.

Upstream would get the board itself: the device tree, the defconfig, and
a board symbol that selects the header and carries the offset base, the
way vexpress64 does it. The OS on this board sits behind NMBM,
MediaTek's bad-block layer for SPI-NAND, and U-Boot has no NMBM. OpenWrt
carries it for all its filogic boards, together with this board's boot
flow: reading the kernel through NMBM and picking the copper or SFP
device tree for the shared port on each boot. So upstream U-Boot on this
board would not load the OS from flash by itself.

Reading flash on my unit also needs support for its FM25G02B SPI-NAND,
which is still waiting:
https://lore.kernel.org/u-boot/20260822205540.1223-1-f@lex.la/

Is a board in that shape fine, or do you want a board to boot its OS
from upstream alone before it goes in?
