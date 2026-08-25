Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79775C5DF81
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 00:49:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3538D6068D;
	Tue, 25 Aug 2026 00:49:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ArcXoZoAi12e; Tue, 25 Aug 2026 00:49:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787618945;
	bh=/G5NDfZCq/z7P4c2+SBrzO7V3wNaJl8pb3HsDisJYiY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aSkNeBuTD85mrhNanTLQVD7xsEl5qfNTq1EPwJGuB407AUfHEbzrhrKh/8vN4BE+I
	 +Lofpgb1n/qN5EWZkYEOLyADf+WS8Yo/v+mgvYgApPXeuaVUEpOnm0s+AKR0YPvijb
	 tHTQRyjnAoZyxscQolE9Lkp39RfeB1Ay6s5ZgapxaN3E+f//5rt7RipI/BuJLytB73
	 I0Cve7HzjZjEswuQ46ZA6wQ+9SjJSOaV79otlJsGOxAnMVDANWTRybL6tI2iV0sn4P
	 A9PpTAS6E1jthTDfHD41OCYsEb12D0Vo1sZIo+LeNAOlJfuHqlXsPeBoopcJD4PyvE
	 OXFciavUfBuOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 68AFB60667;
	Tue, 25 Aug 2026 00:49:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 32F1729B
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 00:49:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2AC0760667
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 00:49:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id grHqp5TRUod6 for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 00:49:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=hM2y/yyM
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DFF136063A
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 00:49:01 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7f42ef0b693so2804988a34.2
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 17:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787618941; x=1788223741;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/G5NDfZCq/z7P4c2+SBrzO7V3wNaJl8pb3HsDisJYiY=;
 b=hM2y/yyMIeVZj5h2ikasgbj5PqSNP9q+3FoTlScHMJA5c5WA3YO5j7dxClQBSYE9c8
 ImdrPVaMntsxM6F//++c5ToAY4v5uVmFbGvlm9VKwQ+0OJ/+Xm+1sa6f/Bc/eV5rHHVe
 yMFMTSq8IeClKWgUxQtwiJ1Dn7kZQIckkE4GWD3PfhJ5NH8qpXifYChpezT1ffeYJK5b
 edxwGpjzkLFWdd+TpY84y4xxehVx5FGE9XMTWnaH5JOqT2Q+4Np+3j/fahmdGrL2Vck/
 qT4yqfBlafWZ9rhC0iFHTB6rL1XIyrlIyZMVogk6Dr3LJRmmmo55serJ58ufD4yExE6x
 5tyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787618941; x=1788223741;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/G5NDfZCq/z7P4c2+SBrzO7V3wNaJl8pb3HsDisJYiY=;
 b=agoTGpHQ9ORjp4FPPWhd07Q6oRkOGkF94EZ/0oDoo+KeaUytMzOGfCrbz+de4jRZ+I
 +sxqLR9BDbDLuoomCmPCBEFRjg/eeLbFxqzX6sfpDFIVjsxS67rhyjdVkZWhDtf/+IyZ
 AcGyQj4qB8qBdBf346rjBG7UHhd6gE34i1gRJDldgW6Aq6YsleGyGpTwY0VQgzJsb2S9
 1L9GS01Jj6UvLi4DqqUda6qiSKUUQdqXVJjGaUdUJIRO9f83eSQr6viFR8WjtneZCz5+
 l8FCDhhxOdUTRjdX0quVw941aBH0dxHmw2rvXUhcr/6TwHxn/+GaSY6DJPKhXbicgbMY
 JYzQ==
X-Gm-Message-State: AFuF++koszs50gjdYam+l2GDuOQB3Rfvse1z5mLSQ0kdu3QuFBGL0SO/
 fCkmCyIsd2/ub7hazOSH7E6nmyik8+JlHW922p9+CFRQk7KGWuD3uPCxl/o4c7wE7d8=
X-Gm-Gg: AR+sD13fJh9cMonnRhZ0pLpm3XA0pyMQivj3MFZts1XjyUX0Gjk6iVMGVykfDWOEIec
 LMlWVkPd1GYj5oPDu9Xj1mNeMBvWO5Z9GjIZj+7NGuFtiAVzy/Omdkum+uFoFEm3xsd0uyfonlt
 IrXvetIwLPAkncekvjLK8CLiHlTI80YIf3Trvr/nVsy3du6EL0KXP4fVoiHgpCxsM4YrwjfgdHU
 MnDzq/aqpbHv93C8WffVRBye9/w/lWXwTvyRIWVVzS/iJNC/0f27lEdEe0fLeFp7cxoc1+BkRnw
 LeJqzONLsqlcOZgzTum9/E2OWPeqD2btWTjk9Mufe/YjX3xMfsBGz3Y2HQhIdzhIGQW2H9G5fLt
 QQj223DjO0jgrfaS69QkRMIzNE5CK8p38Zkz3fYio3zOjFktHEoQjBNyAIGJGW6JJhxRYd2FaVJ
 PKpkz0hIEe7IntnUApsx9whB68+EncwKgeqdlOFZwOLAg67MdW39+yrP/ujd+XJcSNt1fMd/2F8
 cnDjg==
X-Received: by 2002:a05:6830:82e1:b0:7d7:4fc7:21a with SMTP id
 46e09a7af769-7f4765673b7mr25092174a34.13.1787618940796; 
 Mon, 24 Aug 2026 17:49:00 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:29ca:5dba:5fc1:6f13])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f48faeb6fbsm5555187a34.3.2026.08.24.17.48.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 17:49:00 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, Deep Pani <deep.pani@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <20260807-mtk-pinctrl-mt8366-v2-0-b7358bb31521@baylibre.com>
References: <20260807-mtk-pinctrl-mt8366-v2-0-b7358bb31521@baylibre.com>
Subject: Re: [PATCH v2 0/2] pinctrl: mediatek: add mt8366 support
Message-Id: <178761892991.2485046.7452916838726286599.b4-ty@b4>
Date: Mon, 24 Aug 2026 19:48:49 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=532; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=VwZj1iQvGWEBop6lF3M1RvaIlzfwrpmorr+w5rx8R0k=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqjOZzwwI7Xx3baq6DTZ7vAw+ObgI8vpvPL7iC7
 0z8+zRNdcOJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaozmcxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ADDkH/jaavQI3/x0Ont58R54wnRQkWKpfmYpqm/6WbJW
 duhnmDGWuDhNeU73KfYp2M6h65CfiNe9FvGsSPg8wPrhWTsqWSi8wqOXXTLPV3FBijycRZC7Y5p
 x80fPgNr5BY4Qe8rDNDSD+8/Hl+EV6UpgokrYK8Wv1yiLVC/WmzmB00RdVP2sO9R4hnD7lRtLAy
 6nfJbOHt9zEfzI+kLc0G5kdNr/GO8gi3cKryWQ3hIYIFWzf2UYhxNaM6RDnNeqUd2lCNktcI2gS
 wOL0gGp9R42UoVyC0ynRtq6xZwhSG9t3/ZsXSJV/0K/gHWdVDCz/Xx4mwUqqV2OIfb3oqJn2fw+
 fy+s=
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

On Fri, 07 Aug 2026 13:43:51 -0500, David Lechner wrote:
> pinctrl: mediatek: add mt8366 support
> 
> This will be used by Genio 360, which will be added in a separate series.
> Tested on Genio 360 EVK.

Applied to mediatek-for-next, thanks!

[1/2] pinctrl: mediatek: add new mt8366 driver
      commit: 0d3d1bb93ee68a494c684e22e78fa930744ecaae
[2/2] dt-bindings: pinctrl: add MT8366 pin function header
      commit: c026884d062a5711b07c93f728918144a8fb0936

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

