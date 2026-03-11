Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF7C112584E
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 16:01:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 814CB8407E;
	Wed, 11 Mar 2026 17:01:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LA5iAgqx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74684840A9; Wed, 11 Mar 2026 17:01:28 +0100 (CET)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 370C08404A
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 17:01:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-40974bf7781so946320fac.0
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 09:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773244885; x=1773849685;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/0PIsMM4FNkEYd0ksYURIHtPKlHmL+1b80CP7uoOPRo=;
 b=LA5iAgqxKgx8IaEfCNJ+ivZSgdit8U3AellYjwd80o2nV4hLfRGuc2vCiy66ofQzf7
 dGr2Hnyzc2AWkzgBqm3aLmW8i4lKgebekg6bLGtaqmtkdzFkxpiQGRgIvYC7PwTTk3JG
 kXo5mi0ns8StcdlbAT83D+z0+crymkP+oee56zeBRirSdHlw47Hv4GnnZzask8ZtbnZU
 vYB3+4Ob+ug2QifvXYOJzChzhN5Q+4VK8MH1QfRBjjOAGiMlMeu+dO54WIFUP65kYMVJ
 BW7xN8NFsU9S9jgakHPfeXkWmdwN0M3jfRw3GT+WvZh0yJ+OzQJYXeV8+OC0bJ3KNC4j
 +l4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773244885; x=1773849685;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/0PIsMM4FNkEYd0ksYURIHtPKlHmL+1b80CP7uoOPRo=;
 b=XXZP/GXaMAFGPacA6cnadjjPdAh3Py3eC5k+KUM8NhqUSpbdxaODugUXe9JlwBgjAl
 joCRr3XW+Gl4ijgvL416nuvPTkaSXFnpWjJlKCPGGEWTXeX4NSwpi8BFYPGA/tid/g7L
 dyLwRDiLsgeOpKZIaec/7ebLTrqqxJZT06i0hBpafLbwlBKZhhNJxabnPaJ5b+it0UYE
 KmGGRb/r8zC4ijCo3MZETM0NycHyDwKUNd4ZvLHWRiO+fldpTl13Spo44inqAQ0kQC7Z
 T6h0vuyG6apqhCZFteKf58Jqc7pMqiUoFFSZS52EVZaBp8oywOz7A+hQ0InHlcTdI0I3
 Gr+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtmq2s/X8aaePjWOFLT8KbH35D3g8ercb1OhfhD/L5C5ryrq4Q2BjlnxI8Uvj/5rvRd65o5kM=@lists.denx.de
X-Gm-Message-State: AOJu0Yz3w+0GwlrPxeorzP0InMnF4ct+3pkt69kEWpbiu22aM+0bLmyt
 GQ/XvuDnG3+hWxJA/+vfo++OXQkotk+iXsUhYuNCtSsTfoFtD0I+w2k6i52yc/tfnNU=
X-Gm-Gg: ATEYQzzvZO5/bLjkKOjAinl7h+XpvhLXb/HlbET6l/tKAMyk2oHhmOFrxriJUN80lUl
 ZqGJmblKybCXgKtLk/8so5hjLtyzVKsqUCT0StsPvWcOTFo76JNDRdB6yP3TIwQhZf1RvOUWvp+
 zNoCbAh31ESUf5Oiowr7GsVU4xqlL0ASXm3IP+hU22jVvH5xoSskY1IqfhV3eVWZ1NNsORk0zku
 hoMgZOPJ4F4pQxmKXG7KUCZ5AHrU4L8tQEBXII10HdWtULU1BZ/+a6HSZxvBlLUtSW65eatjsm6
 a7UNXy0IafHMbHDwpp+axuFeP9RWwCOLscm3Jv9FF2q80VsGMLIqTitstKa31MHa0sjVeFJYB7j
 rD3rYtc2ezQzzlITriUtxGcNl9Sc2g0HqaiJTU4pAdLEQkr+ezUFk3AkdQpP8IQKl1W4Wx5IPqL
 EFuNpwO35AYGTX1F1d6AR0qziJelbY
X-Received: by 2002:a05:6871:9e13:b0:417:37c1:c990 with SMTP id
 586e51a60fabf-41798a94522mr89441fac.0.1773244884503; 
 Wed, 11 Mar 2026 09:01:24 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:82ac:f3fe:2e5f:ec03])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e2a17f1sm2646487fac.8.2026.03.11.09.01.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 09:01:23 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 Bo-Chen Chen <rex-bc.chen@mediatek.com>
In-Reply-To: <20260209-mtk-pinctl-mt8189-v1-0-a7a3069eda6c@baylibre.com>
References: <20260209-mtk-pinctl-mt8189-v1-0-a7a3069eda6c@baylibre.com>
Subject: Re: [PATCH 0/3] pinctrl: mediatek: support for mt8189
Message-Id: <177324483178.1879070.15806367491101457751.b4-ty@baylibre.com>
Date: Wed, 11 Mar 2026 11:00:31 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=849; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=BiTnVDYc+L+fxNOELOLlVcy2dMbwbyRNxfFQq7VU9H4=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpsZHMGpl1Yg6e4vQ2eZItmHuujttP6tnGEqRmn
 5mlh+C4muCJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabGRzBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ARa8H/inX6EJiqiLrOX/9HiDFWrp3CnWOT1m+nL+sMT5
 epXOvYiamZCFCAGW/y9yqbsfLOm/sRcnbiUu/Jc0dkfEgzoRbZUs3DhQXFvRjklpOYltKeOyxUy
 Ji6kqSehseGy9OwZPcA7CgH6oGsepUF6VLCcAlS1AwgFshEXuTKwxr+IMlU6lT/b527c6hvcrYW
 BjJS7ERd+tDv9NqXHVGdh62oY9WhDeQMJq2wyGDGRCM9mdatMcImOxlSad0RgZPGhXA6KUiCSw6
 XBbN71M8svyYTEEH+C9gTgxmFDkU745vs5nfYjm7EUXXhLCtSceUwI+y/uca4TgF/nDBwgAXXw0
 TLYI=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

On Mon, 09 Feb 2026 17:34:16 -0600, David Lechner wrote:
> pinctrl: mediatek: support for mt8189
> 
> This series adds initial pinctrl support for the MediaTek mt8189 SoC.
> This one has more register maps that any existing one, so there are a
> couple of preparatory patches to handle that. Then adding support is
> just a matter of adding all of the pin definition tables.
> 
> [...]

Applied to mediatek-for-next, thanks!

[1/3] pinctl: mediatek: add bounds check on number of base addresses
      commit: d5ca34d6386a645f721308c2e096cf5307e7837e
[2/3] pinctl: mediatek: increase max number of base addresses
      commit: ebc502533367d4f64823d3c8e96173bc6e90e584
[3/3] pinctrl: mediatek: add support for mt8189
      commit: 43172a596604757bf229bea575c1da304b51e989

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

