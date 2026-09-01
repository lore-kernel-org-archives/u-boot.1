Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F07C61DD6
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 21:21:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C354F40A24;
	Tue,  1 Sep 2026 21:20:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PAabh0KG9mSA; Tue,  1 Sep 2026 21:20:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788297656;
	bh=up5GJjUvNgAE+G1gwkNTFRc8uhPyGx2IBnC0lBdiLms=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vjfnpKuYGFc2Y9lUd2Wkn8yr2UZ6NRatSdzUuPGa1PWAMMzIQ3EGe1/JO4kjC+R2T
	 vcgyN8e5qqpKGH5vr1r4PO/uX4x0P0AM1sDqrcJ8LW7s0WsujVwd+cDZ69IGpC53jl
	 DWI0rh51DrJTv8Bwn+9nUMOjMT7JN2Yj5JdRjVsb+z1cRcgH7sVyYeZLx9FOXmEobt
	 IwE6GINjrDViGmymIL5z1ffU06PKXwO2+3yRWRVbbgWDcnlB/I/PFfCbTKTlXepoQG
	 V37BFmmhtgI9RVNQJl8O46RQC+J7JNCFA3dWZWS9vOnYjn+jEak1LPyBj07MKZghzH
	 Kodke2lJICdrg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B93E440A21;
	Tue,  1 Sep 2026 21:20:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 728552FE
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 21:20:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 642B86080E
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 21:20:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pxx1okmri3Tk for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 21:20:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::34; helo=mail-oa1-x34.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=kYWLL1tZ
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1E24B60802
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 21:20:53 +0000 (UTC)
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-45eb2e6402aso260372fac.0
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 14:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788297652; x=1788902452;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=up5GJjUvNgAE+G1gwkNTFRc8uhPyGx2IBnC0lBdiLms=;
 b=kYWLL1tZKkIxZ7EEA7rV6HcGF4e8pJV8AXbQN5Q4ljvKlfMT1jD3xIgurLvFDahgkU
 kTM4J0fIjHICkH+kHwp9R9FUE/BKmBBp6QYWOKvRyyRDlhqCHF+yqFxk8jG8MUkx3ecr
 vqknD6Q4bsmfIP1Rh3xMYgGD/1LB7xiomn7a0svJOHZuCJjRFcPpIjftdqOuthQ6rwDx
 W+gUNsDdQkbTgnu3WFiDMq0xEjQMTyf5GCwh29JSt74Jaq6Z6mEOgabzQf46deJKm8+A
 a+EuAjzZtlBKtWjGcN6KroEWARFVxmkA9oqLVtvG7+9ENRfQmxbYso/AxOcWDzCjTIHG
 aABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788297652; x=1788902452;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=up5GJjUvNgAE+G1gwkNTFRc8uhPyGx2IBnC0lBdiLms=;
 b=ptNlf5JSqAk+Vuc/fFwgkkND1r2oplnQHK4lTyLl2aqcvT75ewYFwY5djTSv/PUOt4
 0y7sZd6CjZFGCoQqYkpY40STdS/1mbMxYhIAc5cKqiCMYC5rcmT1LYA0++Hc2NZcRdHi
 HRgm9A01vS6wl+CKlKDf1memj6DRkW0fs8Cb4W5HUhLhDl231o46RSjYk6Fh+Ql4wMh5
 IEWS0Y9hPnA9PkyGQXeqOd2ueI04z82tUMFUGwYOFazk+aVoguFGv4FkP+5qQGwQ/B5f
 icpO2eyxFAKn6of8JssBk1niz5BJDknMzfU88V8oehg0qi6CVh6O9XKH+KC8BSvKc7k4
 g54w==
X-Gm-Message-State: AFuF++nUimaEYG3Zbja4rkvx+rSaL1A7nYbVnngwgT2gFN3Hh8GjKwV9
 Ze6MoHFDMDN49lCT0S3pn6y8yAXuqWUbTjBMYFVe6PrnBDiQULAyAjghTfD0SFG8BeA=
X-Gm-Gg: AR+sD13L7i/WCBUAtx338Q97l4Q7v9i/byzBXobGgHzgSEMOCkD3nSdsLQconQ6TRtQ
 CJKf6Z4qKgzjvBU5V3EiD2TwLijNBds5rxmsN0N8Xzq7AHj+Z+Z5UqvgzXqExgct5i98botmZcW
 CGHDLCOWfreL0ZP3ThelAShNL3DgGrU2R8uTPW4s5z9MgDPS9fwnkQZ3L5UH3yV8ck5D85FEpTA
 XqIa/q0uukeCywpgXp8IxgXpao641S7dgINYpDa6urJs3yWpDWg6b9AadzzcnzmiwtbbMI2xXxQ
 8TEP5JoUWc11rpamuwx5yFSJcRpvzZNy10G2z46y0nK//t3oTWuKikoaY/UzcF/iunmJZrB+z4p
 CBYa0ckXFfTUa1DvwqsEwUw/NHgVwtTQSwAR949T9xaR+0xCSIzaYAIR27H4hzDmQ3r73IU7/uP
 z2zztT0ryc6yKRPERLSLeRbI09ti4lOotVKNKwHY5px9MxJiWQILe6cZazbclkXPmnOcid/Fitv
 yzQ
X-Received: by 2002:a05:6870:89a1:b0:447:a816:9328 with SMTP id
 586e51a60fabf-46835c223c1mr36418622fac.6.1788297652459; 
 Tue, 01 Sep 2026 14:20:52 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:523f:532b:33f7:89e5])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-46f3046b24bsm1058120fac.4.2026.09.01.14.20.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 14:20:50 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20260813-mtk-mt8188-drop-tphy-compat-v1-1-9e28ce95ed75@baylibre.com>
References: <20260813-mtk-mt8188-drop-tphy-compat-v1-1-9e28ce95ed75@baylibre.com>
Subject: Re: [PATCH] arm: dts: mediatek: remove mt8188 tphy fallback
Message-Id: <178829756586.2485046.18155221545391986232.b4-ty@b4>
Date: Tue, 01 Sep 2026 16:19:25 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=451; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=VslLnvpRTGoIfvH/sqI7iaRn1mQAZ/nKOPghiYu/y9g=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBql0GpMXr6lNeSfWveFoZxebt06hyXGR2yY7WbK
 DjV7F8m2B+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCapdBqRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AzDEH/353AgzrxERahjP9NEfXPW+ecyhIAbOnqrh7BWr
 sgdVg8mRQY0yw0tQ6SpiZw1bw2WGwc9c5vEaq5fQArIm29NuYY8YWXd/G9bQig9ajXfpGsCMSTD
 /m5jsFCaj6cdYrEKS5awlyfX/JG5SlerzWBEHBEwtoABD/0CDUQG551PY6VCFYsImjGSvNx8sac
 z7DoPWhyktKsc4EtwluxRuA64qev2BqHGwyI/YNO33J4cO7XActQwiF9VY2/b1IbWFkauCpPwIL
 GU6gKrkZpxQyjoXHutwnDFF99+N+as0/pnsy+pdfF2LjszA70am7QOJ7fBOZPjdejN7wfemeYJj
 +WK8=
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

On Thu, 13 Aug 2026 11:21:52 -0500, David Lechner wrote:
> arm: dts: mediatek: remove mt8188 tphy fallback

Had to make a tweak to remove additional files that were referencing the removed
.dtsi file in order to get a clean build.

Applied to mediatek-for-next, thanks!

[1/1] arm: dts: mediatek: remove mt8188 tphy fallback
      commit: 5ce8be614d9e545a595fd15f8be1102b0d681a11

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

