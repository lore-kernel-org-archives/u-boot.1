Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4144C98321
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 19:44:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7920160C11;
	Thu, 24 Sep 2026 19:44:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QdFwaDk8G-ip; Thu, 24 Sep 2026 19:44:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 71B1160C0E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790279042;
	b=ZEeJPuNgFf5nWLpYbqZrqXCUXuR5Utc7M8esS0dRDzjIKzl9WoBwRdOK8f6q9aGXXe1F
	 6bQ+7KP6MAd/+lXXRYpV+kRjXFku2iru8SBHb4hKIxiK//NEpiPDbZj934GW4PG/Cb28r
	 mUKjMSVy26JpPuwrp468DXpNCZvdMnpj/2CRAd115fmcCgr6oiXvH2OivJNDnp42hGtsK
	 RY8+vRXA/BZufipxXKsnvh7y8S2p9YKtFAXjWZs/eJpC/MDvoGNIFQoXI9eBvS51YBDy/
	 TLYz7g9BvieoFaSvwczyELgMQBOztHsKNqA6Y1BlgVRJhx6+E0BorPfxck5e+RHhGRQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790279042;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=37A5yJIfwD2N7m23k3m2uEyzXOVH1CXHr4sxbR17VSk=;
	b=jKAj9PCJ9Q8JDSdxzgVLyewxTbzv72YA7fonwCSPO5vG3SvaIUkxjI1OeUgVkbwjbDn5
	 F/DCU+KUO1+QFSK9E4CYIAE5SMt2rV955XV2Er7ErdRHYs6S7na9VhBEpapxDzOPecQd+
	 JQetjaXVZHr8xvR13l5hM0AcJpyvmM0QbTLxLxxE2GbPs7SVyzxvyaF8ZZnNska5DKMC/
	 Yt5gtNVnd42jMDMW6cW5a5f8cX5hE1zEJEbqLNYkPtFVPyozlUceburEiJDDln3kp8lG0
	 py/u7NqMnVYlPcPXSi57/D/H0RVUaDhUFQINzR0jZE02eec89Ta9QuwO4/DhUE7vXiw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790279042;
	bh=37A5yJIfwD2N7m23k3m2uEyzXOVH1CXHr4sxbR17VSk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rBZGdy0a95lNll7huEWJNNmoRFHnwggxm6XwDFArF5/66L8r7xeOzKD/NSuJvJdPC
	 nftyEg4OjFaAYDM1YuEuXEHaOsSm7vTOMEX0w8YWV5OrZgnLJw9R/WqofLgrKrJTt8
	 ev5jFRMk2ee7JMl7bSB1xIy2gD8lEovpK2c0XVbHZr+/qB4jHUc6sSFiejazpV1lsB
	 RmGymIj/R97VPGRrws3vO+zi8iG2KY84rpZ4W51MH9eV5CpcrpDJHRZZVvyrBcX3n2
	 EnGqJl0imdxQKw8ev71K6+DSE9F4yTO64DyKcELWbkOHcpTEC5ye+fm4T4+q/Qewr2
	 5E/kvNQvFQFzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 71B1160C0E;
	Thu, 24 Sep 2026 19:44:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 795CC2F5
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:43:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5FD6A4017A
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:43:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wio3kXgH8NBu for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 19:43:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org C0D8E400B5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790279034;
 b=tPHNus3z6kaeZ4peThxr7lWqZ08BFv67z3Dl0gfdFhT6QdoYK4Yxa/KDDGfP7L/u4EzL
 ol62bwIW57kHswmVTecLuOm1flFZbdP19/pDnLYC6nsjAcnKOccXEXT6Ov8JS/yLkay6Z
 34p+u3B+9AwHI1bs6+NNYK3JBnYNIgv7sJ4e2aSdbNXxjaGLrzFi3yviRJdIT5du5gW9B
 QJeZ1Sr7+8eNc4yiGxJydnukwR32bdIDEqeQMbWmLd/D/Fq3arp7Ru4Mv9DoeZPzJJK37
 NSZW92gr2iGsUzuGSIhtO5/64xw/RTkHBJX+oep5u3PFyYGkFUUHqTLUryy2MPFIjFw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790279034;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=37A5yJIfwD2N7m23k3m2uEyzXOVH1CXHr4sxbR17VSk=;
 b=WmUS0+mqs+3KWzeTKgdQ8N+BXbpn6oH0kfGPa5yQ3Ea9kGMZm+6APexx7d2krU4t21h5
 xRmxt4vn1cU/ThTSxx1L2umzfvK5Lz065mio2ssFYTwvShp2VAuDPZ3LbXGLMy3R+r2Io
 5VzwR1d8TRJAiFXpAC7QqKZRNAna5K88URQ3AZ+EEPvwnjBoPg5yQFGshM7shgTR8mzf6
 9MiLCmN8Ja+Lew3dE/BpPArmrc8tGa9h/NzbXHfL9UROhgqBOKThT/yb58k7QpJUVJXzc
 lc5ufrMQyijFLmk9rhGl5gKRqXoaLg1/JXsjfW3gein+2tbUr1GAjm+ldBvIZ6DhFcQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=c15E0odk; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::2b; helo=mail-oo2-x2b.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=c15E0odk
Received: from mail-oo2-x2b.google.com (mail-oo2-x2b.google.com
 [IPv6:2607:f8b0:4864:31::2b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C0D8E400B5
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 19:43:53 +0000 (UTC)
Received: by mail-oo2-x2b.google.com with SMTP id
 46e09a7af769-81201ed7d35so111760a34.0
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790279032; x=1790883832;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=37A5yJIfwD2N7m23k3m2uEyzXOVH1CXHr4sxbR17VSk=;
 b=c15E0odkuBrcTUcOm2406pmYpq1DIpZoOgTH0tIpMB4LzhAMs7UL2AdeCA0dt/bhfM
 UKk//NUk9NXl4Lfr1Ti90W226USEFdQFilu93zqWzW99foFvHuFsXYwvJX172sbsveu1
 t7vuJxAH14IFaVrfB+w9Fbo1AbKrogn78A7X4NLT4CLfZjuadY9309dy6PXlUKayMEQt
 VX3MEsLOqsbrexwHyaLcSFIYHJvn4bWpIEzg2x3+lRRe+r7qI7+UXlRluKmhOJ2X/8xA
 ZuGVPFRWGjjYIeOerxDSVG0jGVsC+Lor5t8c3H3LmEYE5jADB/5p2iBuTen7h/Dmw9kp
 QDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790279032; x=1790883832;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=37A5yJIfwD2N7m23k3m2uEyzXOVH1CXHr4sxbR17VSk=;
 b=oiOl5xFqFtlvExd93YyGkMlTBMDRRAr3wNov8Pyok3PYjJuEbTqMH2cZx9foGItVam
 sX7RhAhn9Q4xgQhVC0TfEjdm36uV+/h7qWhCGb527Gf8H2BDWWRT3hCLyGQX8RC0f9XS
 XBuZroSHE5qNdo/9aqWjkLqm3yhkil/8sEC4g46BaHjJnEryCpU56tThbriCfLeMCvWr
 Iyb3kq0133NQhvAQPR9JXII6Nc8pJrUOAeYMb8/3dknyCd3ExcmyGSjW7npkSuVzWflf
 BN4xiVTUWSMq3lERfIKFjLjCyNxejNBfeJoi21L+jMly1/y7ilq73x2TStTJMFYWLJTY
 4zuA==
X-Gm-Message-State: AFuF++lggug2ofVOEoa6knOV1Gu4vowayEHczvnW9fH9nm3FSz09HlAV
 9aWS6IEiBlwrF7hDWBHAjXs6j6mrL2HnYChA8m9iyBGQBJHFtuo2Evug7ZsOJKGtD1M=
X-Gm-Gg: AYBFou37jRIxSnGcOHVSgtPxd7EygWcVF2xR4NPk29YuDEnH82IXgn4wLY5PIX/WDrm
 /tmib2qTHHDnA80XtM1E2H/6aKqvXjiC4wtTcSmN4W/Sl4A3wZsB51JPmNGOWrDZ5yVKPUd39bv
 +FDK6fZAQuf9jDVAIBRyAAnL4OPvqq0HFkRlxUwrwsvvOGEL+p1yaAZibgXLvtX2uwtdzJ0dc6Z
 JsPJy8+0H6AZblRI+8v7IggThWBnJriWVfnAhmHs9EAWJdvVtHGUmJn2NTqG1lAr1cj54+4Qa4R
 fM5JN8Ld5xoCO5z2QQYpY79hnHOT216k3uG+tx9FPgUbGshz6qG+UX7elGgCZWlTkXgCFS88Z1t
 MY+yEm2vQD0aqsvxfbmoN2ckFplDJULpGLZY100SvRzCgqiuDujgB5+QP+0179T3PJF+v9CK9lW
 Qy7BPGp1W4oXdn2i1Dj/bMzy/FqIICmifLoyPK8Ue8YNrfW9VlS+c3uwJKAd/SoVTa+kQAFDPio
 W4=
X-Received: by 2002:a05:6830:2316:b0:806:75db:bb32 with SMTP id
 46e09a7af769-81781293aefmr3827161a34.9.1790279032234; 
 Thu, 24 Sep 2026 12:43:52 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7ded:edd5:63dd:4102])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-818e8054dbdsm230810a34.8.2026.09.24.12.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 12:43:51 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 24 Sep 2026 14:41:44 -0500
Subject: [PATCH 06/15] clk: mediatek: use a single clk_ops for all drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-clk-mtk-single-ops-v1-6-1c3b5d8744ba@baylibre.com>
References: <20260924-clk-mtk-single-ops-v1-0-1c3b5d8744ba@baylibre.com>
In-Reply-To: <20260924-clk-mtk-single-ops-v1-0-1c3b5d8744ba@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=22157;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=m6Yu84V7iFunMMqrTntzocskEGkyPO3uS248hUjSLn8=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqtX0kGduxqzlSrHBTtcdO5Uxer1eHjIqKE1rgI
 hWZhtZ+VEqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCarV9JBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Ah/4IAJvHL09C13E8d0zr8Nu8WSgCSy7ElKLJ8lsS5OE
 chlLi+FmTuH0qKbeOW1oVO+q7CqD6+TCw/57vE9ANctoK65NoaEZXRm2mOYWpaUDr9AjMbu62mX
 CTw574yUEg+1rYJnVjJ1CHg/RDQicPRgR/h6A3tWKlAqcCIT6vhCU0593GyyRd9D8y8OzS1doif
 SBWHr+c83Q7PVaKvtBLaqGPFm4kyvRckz/7ED2uSyZV6Q3IjU+UGoTob/4bpu3EOjrJcSnEU00v
 t1qS9ZSo61b1BnY/DYcLrGITkAL6CZ0B+6OzaLpRG5eOJRMNOFbfHa+WyfB7GXME8jWM/Ytfy1z
 gPF0=
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

Replace the apmixedsys, fixed PLL, topckgen and infrasys clk_ops with a
single mtk_clk_ops and use it in every MediaTek clock driver.

The previous patches left the four structs pointing at the same
callbacks, except for set_rate and set_parent, which each struct either
had or lacked. Every clock tree now gets both. The only visible change
is in the error code for a request that the clock cannot honor:
set_rate on a clock that is not a PLL returns -EINVAL instead of
-ENOSYS, and set_parent on a clock that is not a mux returns 0 instead
of -ENOSYS, as it already did for the topckgen and infrasys drivers.

With only one ops struct left, mtk_clk_tree_get_provider() can
recognize a MediaTek clock device with a single comparison.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mt7622.c | 10 ++++----
 drivers/clk/mediatek/clk-mt7623.c | 10 ++++----
 drivers/clk/mediatek/clk-mt7629.c | 10 ++++----
 drivers/clk/mediatek/clk-mt7981.c | 10 ++++----
 drivers/clk/mediatek/clk-mt7986.c |  8 +++----
 drivers/clk/mediatek/clk-mt7987.c |  8 +++----
 drivers/clk/mediatek/clk-mt7988.c | 12 +++++-----
 drivers/clk/mediatek/clk-mt8183.c |  4 ++--
 drivers/clk/mediatek/clk-mt8188.c |  4 ++--
 drivers/clk/mediatek/clk-mt8189.c |  6 ++---
 drivers/clk/mediatek/clk-mt8195.c |  4 ++--
 drivers/clk/mediatek/clk-mt8365.c |  4 ++--
 drivers/clk/mediatek/clk-mt8366.c |  4 ++--
 drivers/clk/mediatek/clk-mt8512.c |  4 ++--
 drivers/clk/mediatek/clk-mt8516.c |  4 ++--
 drivers/clk/mediatek/clk-mt8518.c |  4 ++--
 drivers/clk/mediatek/clk-mtk.c    | 48 ++++-----------------------------------
 drivers/clk/mediatek/clk-mtk.h    |  5 +---
 18 files changed, 59 insertions(+), 100 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index d66200f1938..7210a918174 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -799,7 +799,7 @@ U_BOOT_DRIVER(mt7622_clk_apmixedsys) = {
 	.of_match = mt7622_apmixed_compat,
 	.probe = mt7622_apmixedsys_probe,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_apmixedsys_ops,
+	.ops = &mtk_clk_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
@@ -809,7 +809,7 @@ U_BOOT_DRIVER(mt7622_clk_topckgen) = {
 	.of_match = mt7622_topckgen_compat,
 	.probe = mtk_clk_probe,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
+	.ops = &mtk_clk_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
@@ -819,7 +819,7 @@ U_BOOT_DRIVER(mt7622_clk_infracfg) = {
 	.of_match = of_match_mt7622_infracfg,
 	.probe = mtk_clk_probe,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_infrasys_ops,
+	.ops = &mtk_clk_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
@@ -830,7 +830,7 @@ U_BOOT_DRIVER(mt7622_clk_eth) = {
 	.probe = mtk_clk_probe,
 	.bind = mt7622_reset_bind,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
+	.ops = &mtk_clk_ops,
 };
 
 U_BOOT_DRIVER(mt7622_clk) = {
@@ -839,5 +839,5 @@ U_BOOT_DRIVER(mt7622_clk) = {
 	.of_match = of_match_mt7622_clk,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
+	.ops = &mtk_clk_ops,
 };
diff --git a/drivers/clk/mediatek/clk-mt7623.c b/drivers/clk/mediatek/clk-mt7623.c
index cc075495b09..be3fd94a1bc 100644
--- a/drivers/clk/mediatek/clk-mt7623.c
+++ b/drivers/clk/mediatek/clk-mt7623.c
@@ -1172,7 +1172,7 @@ U_BOOT_DRIVER(mt7623_clk_apmixedsys) = {
 	.of_match = mt7623_apmixed_compat,
 	.probe = mt7623_apmixedsys_probe,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_apmixedsys_ops,
+	.ops = &mtk_clk_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
@@ -1182,7 +1182,7 @@ U_BOOT_DRIVER(mt7623_clk_topckgen) = {
 	.of_match = mt7623_topckgen_compat,
 	.probe = mtk_clk_probe,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
+	.ops = &mtk_clk_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
@@ -1192,7 +1192,7 @@ U_BOOT_DRIVER(mt7623_clk_infracfg) = {
 	.of_match = mt7623_infracfg_compat,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
+	.ops = &mtk_clk_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
@@ -1202,7 +1202,7 @@ U_BOOT_DRIVER(mt7623_clk_pericfg) = {
 	.of_match = mt7623_pericfg_compat,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_infrasys_ops,
+	.ops = &mtk_clk_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
@@ -1213,5 +1213,5 @@ U_BOOT_DRIVER(mt7623_clk_eth) = {
 	.probe = mtk_clk_probe,
 	.bind = mt7623_ethsys_hifsys_bind,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
+	.ops = &mtk_clk_ops,
 };
diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index b271b96ebf3..2ee04c7b002 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -748,7 +748,7 @@ U_BOOT_DRIVER(mt7629_clk_apmixedsys) = {
 	.of_match = mt7629_apmixed_compat,
 	.probe = mt7629_apmixedsys_probe,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_apmixedsys_ops,
+	.ops = &mtk_clk_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
@@ -758,7 +758,7 @@ U_BOOT_DRIVER(mt7629_clk_topckgen) = {
 	.of_match = mt7629_topckgen_compat,
 	.probe = mtk_clk_probe,
 	.priv_auto	= sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
+	.ops = &mtk_clk_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
@@ -768,7 +768,7 @@ U_BOOT_DRIVER(mt7629_clk_infracfg) = {
 	.of_match = of_match_mt7629_infracfg,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
+	.ops = &mtk_clk_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
@@ -779,7 +779,7 @@ U_BOOT_DRIVER(mt7629_clk_ethsys) = {
 	.probe = mtk_clk_probe,
 	.bind = mt7629_ethsys_bind,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
+	.ops = &mtk_clk_ops,
 };
 
 U_BOOT_DRIVER(mt7629_clk) = {
@@ -788,5 +788,5 @@ U_BOOT_DRIVER(mt7629_clk) = {
 	.of_match = of_match_mt7629_clk,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
+	.ops = &mtk_clk_ops,
 };
diff --git a/drivers/clk/mediatek/clk-mt7981.c b/drivers/clk/mediatek/clk-mt7981.c
index 7e3e60477d9..6d5c967ea78 100644
--- a/drivers/clk/mediatek/clk-mt7981.c
+++ b/drivers/clk/mediatek/clk-mt7981.c
@@ -692,7 +692,7 @@ U_BOOT_DRIVER(mt7981_clk_apmixedsys) = {
 	.of_match = mt7981_fixed_pll_compat,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_fixed_pll_ops,
+	.ops = &mtk_clk_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
@@ -702,7 +702,7 @@ U_BOOT_DRIVER(mt7981_clk_topckgen) = {
 	.of_match = mt7981_topckgen_compat,
 	.probe = mt7981_topckgen_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
+	.ops = &mtk_clk_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
@@ -720,7 +720,7 @@ U_BOOT_DRIVER(mt7981_clk_infracfg) = {
 	.of_match = mt7981_infracfg_compat,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_infrasys_ops,
+	.ops = &mtk_clk_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
@@ -784,7 +784,7 @@ U_BOOT_DRIVER(mt7981_clk_sgmiisys) = {
 	.of_match = of_match_mt7981_sgmiisys,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
+	.ops = &mtk_clk_ops,
 };
 
 /* ethsys */
@@ -843,5 +843,5 @@ U_BOOT_DRIVER(mt7981_clk_ethsys) = {
 	.probe = mtk_clk_probe,
 	.bind = mt7981_ethsys_bind,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
+	.ops = &mtk_clk_ops,
 };
diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index e4abddbd515..1e54d8ed2cf 100644
--- a/drivers/clk/mediatek/clk-mt7986.c
+++ b/drivers/clk/mediatek/clk-mt7986.c
@@ -600,7 +600,7 @@ U_BOOT_DRIVER(mt7986_clk_apmixedsys) = {
 	.of_match = mt7986_fixed_pll_compat,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_fixed_pll_ops,
+	.ops = &mtk_clk_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
@@ -610,7 +610,7 @@ U_BOOT_DRIVER(mt7986_clk_topckgen) = {
 	.of_match = mt7986_topckgen_compat,
 	.probe = mt7986_topckgen_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
+	.ops = &mtk_clk_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
@@ -628,7 +628,7 @@ U_BOOT_DRIVER(mt7986_clk_infracfg) = {
 	.of_match = mt7986_infracfg_compat,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_infrasys_ops,
+	.ops = &mtk_clk_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
@@ -687,5 +687,5 @@ U_BOOT_DRIVER(mt7986_clk_ethsys) = {
 	.probe = mtk_clk_probe,
 	.bind = mt7986_ethsys_bind,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
+	.ops = &mtk_clk_ops,
 };
diff --git a/drivers/clk/mediatek/clk-mt7987.c b/drivers/clk/mediatek/clk-mt7987.c
index 6f2fe12a186..831fa7177a7 100644
--- a/drivers/clk/mediatek/clk-mt7987.c
+++ b/drivers/clk/mediatek/clk-mt7987.c
@@ -81,7 +81,7 @@ U_BOOT_DRIVER(mt7987_clk_apmixedsys) = {
 	.of_match = mt7987_fixed_pll_compat,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_fixed_pll_ops,
+	.ops = &mtk_clk_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
@@ -488,7 +488,7 @@ U_BOOT_DRIVER(mt7987_clk_topckgen) = {
 	.of_match = mt7987_topckgen_compat,
 	.probe = mt7987_topckgen_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
+	.ops = &mtk_clk_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
@@ -810,7 +810,7 @@ U_BOOT_DRIVER(mt7987_clk_infracfg) = {
 	.of_match = mt7987_infracfg_compat,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_infrasys_ops,
+	.ops = &mtk_clk_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
@@ -870,5 +870,5 @@ U_BOOT_DRIVER(mt7987_clk_ethsys) = {
 	.probe = mtk_clk_probe,
 	.bind = mt7987_ethsys_bind,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
+	.ops = &mtk_clk_ops,
 };
diff --git a/drivers/clk/mediatek/clk-mt7988.c b/drivers/clk/mediatek/clk-mt7988.c
index 4728ca3e25a..797274c59ca 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -876,7 +876,7 @@ U_BOOT_DRIVER(mt7988_clk_apmixedsys) = {
 	.of_match = mt7988_fixed_pll_compat,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_fixed_pll_ops,
+	.ops = &mtk_clk_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
@@ -886,7 +886,7 @@ U_BOOT_DRIVER(mt7988_clk_topckgen) = {
 	.of_match = mt7988_topckgen_compat,
 	.probe = mt7988_topckgen_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
+	.ops = &mtk_clk_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
@@ -904,7 +904,7 @@ U_BOOT_DRIVER(mt7988_clk_infracfg) = {
 	.of_match = mt7988_infracfg_compat,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_infrasys_ops,
+	.ops = &mtk_clk_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
@@ -962,7 +962,7 @@ U_BOOT_DRIVER(mt7988_clk_ethdma) = {
 	.probe = mtk_clk_probe,
 	.bind = mt7988_ethdma_bind,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
+	.ops = &mtk_clk_ops,
 };
 
 /* SGMIISYS_0 */
@@ -1041,7 +1041,7 @@ U_BOOT_DRIVER(mt7988_clk_sgmiisys) = {
 	.of_match = of_match_mt7988_sgmiisys,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
+	.ops = &mtk_clk_ops,
 };
 
 /* ETHWARP */
@@ -1103,5 +1103,5 @@ U_BOOT_DRIVER(mt7988_clk_ethwarp) = {
 	.probe = mtk_clk_probe,
 	.bind = mt7988_ethwarp_bind,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
+	.ops = &mtk_clk_ops,
 };
diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index aff5d629c30..c5e607aee80 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -829,7 +829,7 @@ U_BOOT_DRIVER(mt8183_clk_apmixedsys) = {
 	.of_match = mt8183_apmixed_compat,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_apmixedsys_ops,
+	.ops = &mtk_clk_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
@@ -839,6 +839,6 @@ U_BOOT_DRIVER(mt8183_clk) = {
 	.of_match = mt8183_clk_compat,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
+	.ops = &mtk_clk_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
diff --git a/drivers/clk/mediatek/clk-mt8188.c b/drivers/clk/mediatek/clk-mt8188.c
index 0f50757c97e..7db5194f0a7 100644
--- a/drivers/clk/mediatek/clk-mt8188.c
+++ b/drivers/clk/mediatek/clk-mt8188.c
@@ -2121,7 +2121,7 @@ U_BOOT_DRIVER(mt8188_clk_apmixedsys) = {
 	.of_match = mt8188_apmixed_compat,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_apmixedsys_ops,
+	.ops = &mtk_clk_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
@@ -2131,6 +2131,6 @@ U_BOOT_DRIVER(mt8188_clk) = {
 	.of_match = mt8188_clk_compat,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
+	.ops = &mtk_clk_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
diff --git a/drivers/clk/mediatek/clk-mt8189.c b/drivers/clk/mediatek/clk-mt8189.c
index ece7d739f86..a4880b98906 100644
--- a/drivers/clk/mediatek/clk-mt8189.c
+++ b/drivers/clk/mediatek/clk-mt8189.c
@@ -2036,7 +2036,7 @@ U_BOOT_DRIVER(mt8189_clk_apmixedsys) = {
 	.of_match = mt8189_apmixed,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_apmixedsys_ops,
+	.ops = &mtk_clk_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
@@ -2046,7 +2046,7 @@ U_BOOT_DRIVER(mt8189_clk) = {
 	.of_match = mt8189_clk_compat,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
+	.ops = &mtk_clk_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
@@ -2056,6 +2056,6 @@ U_BOOT_DRIVER(mt8189_clk_vlpckgen) = {
 	.of_match = mt8189_vlpckgen,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_infrasys_ops,
+	.ops = &mtk_clk_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
diff --git a/drivers/clk/mediatek/clk-mt8195.c b/drivers/clk/mediatek/clk-mt8195.c
index a8a4caf0fd6..aa46d1b451c 100644
--- a/drivers/clk/mediatek/clk-mt8195.c
+++ b/drivers/clk/mediatek/clk-mt8195.c
@@ -1624,7 +1624,7 @@ U_BOOT_DRIVER(mt8195_clk_apmixedsys) = {
 	.of_match = mt8195_apmixed,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_apmixedsys_ops,
+	.ops = &mtk_clk_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
@@ -1634,6 +1634,6 @@ U_BOOT_DRIVER(mt8195_clk) = {
 	.of_match = mt8195_clk_compat,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
+	.ops = &mtk_clk_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index 0d74561ace0..25f09a30db5 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -782,7 +782,7 @@ U_BOOT_DRIVER(mt8365_clk_apmixedsys) = {
 	.of_match = mt8365_apmixed_compat,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_apmixedsys_ops,
+	.ops = &mtk_clk_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
@@ -792,6 +792,6 @@ U_BOOT_DRIVER(mt8365_clk) = {
 	.of_match = mt8365_clk_compat,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
+	.ops = &mtk_clk_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
diff --git a/drivers/clk/mediatek/clk-mt8366.c b/drivers/clk/mediatek/clk-mt8366.c
index cc490641b3d..23b2920ef22 100644
--- a/drivers/clk/mediatek/clk-mt8366.c
+++ b/drivers/clk/mediatek/clk-mt8366.c
@@ -1502,7 +1502,7 @@ U_BOOT_DRIVER(mt8366_clk_apmixedsys) = {
 	.of_match = mt8366_apmixed_compat,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_apmixedsys_ops,
+	.ops = &mtk_clk_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
@@ -1512,6 +1512,6 @@ U_BOOT_DRIVER(mt8366_clk) = {
 	.of_match = mt8366_clk_compat,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
+	.ops = &mtk_clk_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
diff --git a/drivers/clk/mediatek/clk-mt8512.c b/drivers/clk/mediatek/clk-mt8512.c
index 6288aca9e22..0b763876f17 100644
--- a/drivers/clk/mediatek/clk-mt8512.c
+++ b/drivers/clk/mediatek/clk-mt8512.c
@@ -849,7 +849,7 @@ U_BOOT_DRIVER(mt8512_clk_apmixedsys) = {
 	.of_match = mt8512_apmixed_compat,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_apmixedsys_ops,
+	.ops = &mtk_clk_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
@@ -859,6 +859,6 @@ U_BOOT_DRIVER(mt8512_clk) = {
 	.of_match = mt8512_clk_compat,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
+	.ops = &mtk_clk_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
index 068327783c6..6402fbb80f8 100644
--- a/drivers/clk/mediatek/clk-mt8516.c
+++ b/drivers/clk/mediatek/clk-mt8516.c
@@ -795,7 +795,7 @@ U_BOOT_DRIVER(mt8516_clk_apmixedsys) = {
 	.of_match = mt8516_apmixed_compat,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_apmixedsys_ops,
+	.ops = &mtk_clk_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
@@ -805,6 +805,6 @@ U_BOOT_DRIVER(mt8516_clk) = {
 	.of_match = mt8516_clk_compat,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
+	.ops = &mtk_clk_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
diff --git a/drivers/clk/mediatek/clk-mt8518.c b/drivers/clk/mediatek/clk-mt8518.c
index f875d4fcdd5..b6b61248f5c 100644
--- a/drivers/clk/mediatek/clk-mt8518.c
+++ b/drivers/clk/mediatek/clk-mt8518.c
@@ -1551,7 +1551,7 @@ U_BOOT_DRIVER(mt8518_clk_apmixedsys) = {
 	.of_match = mt8518_apmixed_compat,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_apmixedsys_ops,
+	.ops = &mtk_clk_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
 
@@ -1561,6 +1561,6 @@ U_BOOT_DRIVER(mt8518_clk) = {
 	.of_match = mt8518_clk_compat,
 	.probe = mtk_clk_probe,
 	.priv_auto = sizeof(struct mtk_clk_priv),
-	.ops = &mtk_clk_topckgen_ops,
+	.ops = &mtk_clk_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index a18512287c2..af5a210073a 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -69,13 +69,8 @@ static struct udevice *mtk_clk_tree_get_provider(enum mtk_clk_tree_type type)
 
 	uclass_foreach_dev(dev, uc) {
 		const struct mtk_clk_tree *tree;
-		const void *ops;
 
-		ops = dev_get_driver_ops(dev);
-		if (ops != &mtk_clk_apmixedsys_ops &&
-		    ops != &mtk_clk_fixed_pll_ops &&
-		    ops != &mtk_clk_topckgen_ops &&
-		    ops != &mtk_clk_infrasys_ops)
+		if (dev_get_driver_ops(dev) != &mtk_clk_ops)
 			continue;
 
 		tree = (const void *)dev_get_driver_data(dev);
@@ -438,7 +433,7 @@ static void mtk_clk_print_mux_parents(struct mtk_clk_priv *priv,
 }
 #endif
 
-/* apmixedsys functions */
+/* PLL functions */
 
 static unsigned long __mtk_pll_recalc_rate(const struct mtk_pll_data *pll,
 					   u32 fin, u32 pcw, int postdiv)
@@ -552,7 +547,7 @@ static int mtk_pll_calc_values(struct mtk_clk_priv *priv, struct clk *clk,
 	return 0;
 }
 
-static ulong mtk_apmixedsys_set_rate(struct clk *clk, ulong rate)
+static ulong mtk_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
 	u32 pcw = 0;
@@ -649,8 +644,6 @@ static int mtk_pll_disable(struct mtk_clk_priv *priv,
 	return 0;
 }
 
-/* topckgen functions */
-
 static ulong mtk_factor_recalc_rate(const struct mtk_fixed_factor *fdiv,
 				    ulong parent_rate)
 {
@@ -869,42 +862,11 @@ static void mtk_clk_dump(struct udevice *dev)
 }
 #endif
 
-const struct clk_ops mtk_clk_apmixedsys_ops = {
-	.of_xlate = mtk_clk_of_xlate,
-	.enable = mtk_clk_enable,
-	.disable = mtk_clk_disable,
-	.set_rate = mtk_apmixedsys_set_rate,
-	.get_rate = mtk_clk_get_rate,
-#if CONFIG_IS_ENABLED(CMD_CLK)
-	.dump = mtk_clk_dump,
-#endif
-};
-
-const struct clk_ops mtk_clk_fixed_pll_ops = {
-	.of_xlate = mtk_clk_of_xlate,
-	.enable = mtk_clk_enable,
-	.disable = mtk_clk_disable,
-	.get_rate = mtk_clk_get_rate,
-#if CONFIG_IS_ENABLED(CMD_CLK)
-	.dump = mtk_clk_dump,
-#endif
-};
-
-const struct clk_ops mtk_clk_topckgen_ops = {
-	.of_xlate = mtk_clk_of_xlate,
-	.enable = mtk_clk_enable,
-	.disable = mtk_clk_disable,
-	.get_rate = mtk_clk_get_rate,
-	.set_parent = mtk_common_clk_set_parent,
-#if CONFIG_IS_ENABLED(CMD_CLK)
-	.dump = mtk_clk_dump,
-#endif
-};
-
-const struct clk_ops mtk_clk_infrasys_ops = {
+const struct clk_ops mtk_clk_ops = {
 	.of_xlate = mtk_clk_of_xlate,
 	.enable = mtk_clk_enable,
 	.disable = mtk_clk_disable,
+	.set_rate = mtk_clk_set_rate,
 	.get_rate = mtk_clk_get_rate,
 	.set_parent = mtk_common_clk_set_parent,
 #if CONFIG_IS_ENABLED(CMD_CLK)
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 1c840d9f6d3..2a122a80dfd 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -306,10 +306,7 @@ struct mtk_clk_priv {
 	const struct mtk_clk_tree *tree;
 };
 
-extern const struct clk_ops mtk_clk_apmixedsys_ops;
-extern const struct clk_ops mtk_clk_fixed_pll_ops;
-extern const struct clk_ops mtk_clk_topckgen_ops;
-extern const struct clk_ops mtk_clk_infrasys_ops;
+extern const struct clk_ops mtk_clk_ops;
 
 int mtk_clk_probe(struct udevice *dev);
 

-- 
2.43.0

