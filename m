Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0522C9830E
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 13:42:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BDCF08115F;
	Fri, 25 Sep 2026 13:42:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X6zm_BMbN0y9; Fri, 25 Sep 2026 13:42:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CA9EC81182
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790343755;
	b=OEgiPIqIUkc72GLy5g1tvx9dyCWVOrw5S6pOpM7jlHWgQ6VISSEv5IcQ9xWNS8f58k4Z
	 2x9RGryzpRwKnjRV1doi2ltgJIWVHfe843I7E/pNH+CvyvLbMMxHu3XmEGVXNSxnLYcN5
	 LMMRAGRcnV+dZlIs7qaR4C/y6obTYL+gCN79Yq81q04YQroQS68a3e6iqObdGOSxOc20+
	 P09pq6pEY3SvblH2Jwiwn7Z6Ur42XDc/XcSrmZcdSU4lVg4TGkr39cchO34oKpsoryDa0
	 ounwUTcvdvBuTnfa+y6w8UP8QKcJQ2rn+Gtk9M6adD8RvVuO0es5K1vLuwl7PkjJMVA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790343755;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YVPuaE9IB66trLiFplA8Hb2+bW0yOvzf7m9HAxeHP0Y=;
	b=e4b2EN34aT2qLDaxDXDxSV+sramKiYtiHbfoEE5UXK/UprJ/Jw1a+C5sPR3p7eu+7K82
	 stq9HpXWvK0hAXk7PA6CdjCCgvX1z1+xzXxuJPkHkJLGmC7QgyhbnEt4hfjpwtvRAPGye
	 borZSbOtGNkwGLGTgyURjVLwwcXefft5e/jI0DBFI4VwuAlxJe3LIuEi9bVH+Uq8Pqxbb
	 zcXHAoHa8JCHr3zbVXPR5cIsBgwqmnIO/Vj6l5ATBRsFmOtxZ6GhWZq1Sw0dMl9/0QLAN
	 pyBoWWBxgPEMbvUtm1CHfuYayy4owvMARzwM86o81wQIAA7pFyROza8IBS6zVRTd46g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790343754;
	bh=YVPuaE9IB66trLiFplA8Hb2+bW0yOvzf7m9HAxeHP0Y=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XiIRfalGC+uscGdDEEHPJD8Ro04HzkA/bd4O8bLfrUT5Fbcu4UP0vgXLPGwDiYmeY
	 EVPJYM5G0qYkAS9jddeAxcnY8I8niKV5JtgY2xlXoHzL8Bwkn+KhuaYsuKDn4ftDJT
	 OMakURj18BYiZgOOD0nP2VIiHFbar0wbBsGkZYa4BdlnL/hV+x8J76U6UoVdAwRjhe
	 4cRGDlzVkdpjF40d9usE+JHShc1vwI64fXuSBJXuvO5lT1ctnnEXo1T50UQEnEeZpi
	 TnJtqcLNudpzq2PsCOH09a9kS+qS4Z22LOKFhxFJYFKKq8wEIokYoBUfDyOfAGAWWv
	 iHOMFkVUFESSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA9EC81182;
	Fri, 25 Sep 2026 13:42:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B9D02355
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:42:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AAACC4062F
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:42:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tew9_zICz2qJ for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 13:42:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A137F40600
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790343753;
 b=LkIwphqqn6Yr3Hv+n1JpIEy+529x7FPaQtEla26zMh1E0xTt+NN7wbNkGAho9QH98tAS
 uFVOeea5ck0SaQgINzW/XBlUfSHqEABDHNcMjz8C52qHhUijEIuGeSQ891+3pedE3/Kns
 3qfJH8Cs3fIMq7gHuWbs4wGSWYCiPkagY6g4oN0bIMffi1xWpTdPFKqkbyuLV+yvqY6P9
 b+hIh4xslh6pwEfBWyxGtXhNQ5RD3VtzUOkPkEk7i5vCcCiFBZ80LhhNQZFWtlAu44ctx
 E61coq/+URXA/evDKQqNYFdRp4ksCxxwPIICY3uKsCXCULcRu5/+x+GACi3W3uWBY2w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790343753;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=YVPuaE9IB66trLiFplA8Hb2+bW0yOvzf7m9HAxeHP0Y=;
 b=Z+PNfyYSB4Mo2eGpczOklbzCYcx0hzpCpQMAXvo81ECRy6e8NByzfWPMH7TMFaWfQYWS
 zeuARWo+SiWoZkPEChYEPlioYX5znK5rPM2qF7R2Q9f7wMhvGEpdsCU7FGr/7tF1Exjrk
 gerM4weQBm8rvyscbB5d5URBtH76eEx716Ccy0OeVOz8CJLSkOr+ZxRVM1GnKTKy/3ZyQ
 nRmeOtOo2AgbKpNwYubSPmwsmltVi0Kk2rePSYO7Nf3k7iTt/a1wjb4QH0SDbncZ7lvrF
 0VhPc3Z0nHbZu45Brj3nV9hbuI06QfcmSlEvn480+UKh5ROf8XuCcbwUzpAOEAm+qKg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="ceeALV/0"; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ceeALV/0
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A137F40600
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:42:32 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d37b6so5258015e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 06:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790343750; x=1790948550;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YVPuaE9IB66trLiFplA8Hb2+bW0yOvzf7m9HAxeHP0Y=;
 b=ceeALV/02iUz3MMk8Xo6QgC/I4RVpD4oLAbQscv0yr1yttiu1VNP5jAQGhAHNvMxnW
 3roR4Ee9Omk0Ajyc6R0v9pcjsmqg/hxXZnfc5/uoSItMIViPIdCkGwObuWnRGI3iAxFy
 zfY2yB4m2IsWsdJ50O0QyjgEExqIUCwhuOcXOAfw13iRYinZjaZ52EcOQV8V/zqKVnJU
 mcTF60qtIWSGQXh/FkmSXU1FOLFwgY/sM8F+wldQJ8wJtU858jdgTyom9J4jyI3wu7ly
 uucf/iuDVP6uAcWrN2LBkYZ6WOS4uOPXawijtN6wKp4PHw3YakPSqB+GKGSgqOLvAQNS
 x1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790343750; x=1790948550;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YVPuaE9IB66trLiFplA8Hb2+bW0yOvzf7m9HAxeHP0Y=;
 b=mw16uFyFp4huW2gKhjICJ6gnm7I9RBp9AoP/BiaS+eJsxC/6JulRwHWFb3deL1QWyV
 PYTCoOBHJRgA5eXCNwqIMR3WUAfyrN6MIZQkV6N1uS/PdaQaMYrWicGZByD6eEdXgmZq
 3c/YvieDP+7lrDk2DyDbptOBY3W572M1bmH9NmG6Z0oy31AY7mSf2YIQb0Id2Fz4EOEB
 a/5XJOobEo21mKXDPW8/TP5VImMtjI2VA5f/Sijld0DD8ZuwtnNrOIFPfFzOP5Mt6IpV
 H2bvy3hSxsD0jt35bWv79GjRQyBxoi/QEHySxQNwcIrwfB8OUpR3gfD1y960HYAkuIjZ
 CILg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzbRSFZbEQnekekjyJw1eP3l7GJ/M1u8UkRdDewBVuBySdWJjaLv6+tG3ghLyXIfshisTYHDGg=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mLoBYOMSShFp0M/htU6n6+Nr3BfjoMLhmisJKWAvMfbfSYnRcN
 SuvJj0ai+SoLP3MakOnfW+wYGK9FG1ELWkUQqgW8i22MoptasecdMQxmNDs3B8UX3UQ=
X-Gm-Gg: AYBFou2HXhNPdNWKEcVEzEPIm7qy229tvIlADEgq1mxTf9k+YPS4IN44DWmOE6s7NkC
 67t9KDwyUxDkWLl436WK9pocXoAfK9KNjyN0H2EHVoIasCj/RCpOBnhLUHABXqoOYtwUE22Lynw
 aXv7Y2rpVFaArA86EJ+rxm/5J343AlDgvc2zZ2h0wRQiD6z8GlTSHvfgW7TxsRw4SC7Qs+VA+gr
 JMlP91kTp8OuSVFtbvvPuKPSAdddUw2AYCXwSDkm567Ctw9aJgbWJQAl5nsHeUgNRSl+3KnUDF9
 q1vlJAylSCo2UnF10KOu3tBuTadmqC7E2j4v7UyRJOjkctXSqv5RnGbDYLjDiC8O0s+YhJA64tX
 P8rjkII9nFk8X0MbxLWYpoapaE9+3AtYi0VJ1h7yDzJkjst/5FjiOVtOirYF3h8qQ76VgVb8XE3
 u7mr7XvtYKX55Efo1ZLgC+dpcgiDDILSXa4fvpnn/wYxkk0lcC3yTMOZIQZbLU
X-Received: by 2002:a05:600c:354e:b0:49f:ce78:356f with SMTP id
 5b1f17b1804b1-49fe670b511mr100465885e9.32.1790343750017; 
 Fri, 25 Sep 2026 06:42:30 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::642d:5bda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff42b7074sm34738125e9.6.2026.09.25.06.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 06:42:29 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Subject: [PATCH 0/4] configs: khadas-vim3: refresh Android support
Date: Fri, 25 Sep 2026 15:42:23 +0200
Message-Id: <20260925-update_vim-v1-0-fddf7ba4dc34@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD96tmoC/yXMTQqAIBBA4avErBPURWZXiQjTqSboB60Iwrtnt
 fwW790Q0BMGqLIbPJ4UaF0SRJ6BHc0yICOXDJLLgmtesmNzZsf2pJlprZztpCi5UJCCzWNP1ze
 rm9/h6Ca0+3uAGB9TLPd0bgAAAA==
X-Change-ID: 20260908-update_vim-997dcb218017
To: u-boot-amlogic@groups.io, u-boot@lists.u-boot-project.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.16.0
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

Update VIM3 and VIM3L Android support to match the Android 16 AOSP
A/B images used by these Khadas development boards. Remove the unused
non-A/B defconfigs, increase the fastboot buffer to 512 MiB, update the
partition layout and correct the DTB indices in vendor_boot.

The layout follows the AOSP generic boot and vendor_boot model:
https://source.android.com/docs/core/architecture/partitions/generic-boot

Both Android A/B defconfigs were build-tested. Android boot will be
tested on both VIM3 and VIM3L.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
Guillaume La Roque (4):
      configs: khadas-vim3: drop non-A/B Android defconfigs
      configs: khadas-vim3: enlarge the fastboot buffer
      configs: khadas-vim3: update the Android partition layout
      configs: khadas-vim3: fix the Android DTB index

 board/amlogic/vim3/MAINTAINERS            |   2 -
 configs/khadas-vim3_android_ab_defconfig  |   1 +
 configs/khadas-vim3_android_defconfig     | 122 ------------------------------
 configs/khadas-vim3l_android_ab_defconfig |   1 +
 configs/khadas-vim3l_android_defconfig    | 122 ------------------------------
 include/configs/khadas-vim3_android.h     |  36 ++++-----
 include/configs/khadas-vim3l_android.h    |  36 ++++-----
 7 files changed, 34 insertions(+), 286 deletions(-)
---
base-commit: 951132236b9adc592c2e49faadd103c6a355cac3
change-id: 20260908-update_vim-997dcb218017

Best regards,
--  
Guillaume La Roque <glaroque@baylibre.com>

