Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1371FEDA10
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 19:18:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C69F8840C1;
	Tue, 17 Mar 2026 20:18:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zQ0LxJ63";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AD1E84106; Tue, 17 Mar 2026 20:18:34 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8894384090
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 20:18:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d756f2a06dso206796a34.1
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 12:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773775110; x=1774379910;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NXBNY2zUhRmO8rirJ+XZte6mpmqWE2nckWb2JDs6FXM=;
 b=zQ0LxJ63XKA+5f1o5pJqrDH9ESNqNaObjgRpsAY5c+zRoZr6DtLID0lJXrjXz0WgpV
 LOsW3l0dhfffJfBBUTaKqEskDevbXVRuyBVCd1+AkU5UwN0JkeKowFkUIhnoWoM85Ek0
 Q5McTG4EM9wSmyuSoMVjlMa5gG8u4o1me84x0bS744DIyr0oPffg2EH05LjtOUshDmez
 pTioghQdmQqQQM5D18Mx4kIAVWNUTbDvBIxGiyPsyyXtT9ZKdV8JFRZZqZTUEXKwa76c
 p/2CBFyde1xKAZRlosngFmh9liuVjnSx8xBAR/5KHOdFGVlIKr1k3jnodr0zkPRxwtLq
 VfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773775110; x=1774379910;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NXBNY2zUhRmO8rirJ+XZte6mpmqWE2nckWb2JDs6FXM=;
 b=p5w2omwic6VFU+LTnDlEKpYuo4bV9qYM/Li3465Yhu29V3X+dj/MpqhIh08BXNuDm7
 Hf6M3gvNp1U/sG24rXouEfxlflBAnRkSIIKq0HXqaSCAZqhTfJ/CM1SQRQkVgfFK4/Lh
 u8E1afdeqVZsB8F/wTl8eQmDVx45rL2DZhqZU13RgCotwUXyo+ciIjNfZj/dpyUieBch
 vjLvO1tbZ0hIdCZxvNLswg166m84DnnxPVdmgBIpVIcaatXMKqg/IioBs/l/NuujRDEW
 KyvwzqoSNjWBYroBl+W4FRBkldvVejjx8ECCsw5qqvODU8FVnYKnjC0U0RvH1LUTlrXF
 D7yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWduI1t1etIEe1VZNhkVnJFwf4noDDKd6/HLBjzomTJMha5J/VRYQRzSFojnZxrJ8Vzw83g5zU=@lists.denx.de
X-Gm-Message-State: AOJu0YyGWJlFMlsxE7xES9GZL5sdRD8cTIA1dSqPU6HTwsFjJjfcd+UP
 J1etKTY8UYzIw/B4BJ+v7y1DIh0ihjzzSi9YOQZKVpdL9cemjEBiIh0earpRYQg85Kk=
X-Gm-Gg: ATEYQzyCvudSSuThu6ISYZIJE4AnIKK744z9A3Jkhdvpwre/b6VjglIvmoIu5jM62Pq
 pjryezx4rn5/lbvjcaf+M7t89afOpcOKkej28yNNeEUlnMh9gyjjgHv16ybxNQLSs+nDWqiuP61
 eneemVc2ITOH7+0NthuPetFigQbmGkDfKyEOPa/MUJXXqHVFIcVGYfFZUIb8C6W4yhHrKSyIUod
 JyrgCCXMwXHYJVwqB0E/D2GjPbn1TIuOY84uVFDrD6qqM590RT2WUwl/ODizGH+0Ytnmve+ejz7
 Evmxlf3bF2PZcv+d2Iwq8SDi2WViNYJjUKcd9YyPwDw/ZdZj8oT/KrJs2qG6crooYK2Mqx5kzZk
 odNxS6z8wsvRYoTJ8P3GY0NKXFf32Q4xT6cANyrpKMoMEIh9LsO0Ab/MUbi0pSJl7SsGqGNh7Cu
 2owcgxLP0p2utrZfOn24qz4+XFiqw=
X-Received: by 2002:a05:6830:4410:b0:7d7:664c:7110 with SMTP id
 46e09a7af769-7d7c97963d1mr614216a34.12.1773775110125; 
 Tue, 17 Mar 2026 12:18:30 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:6995:28aa:eeda:102])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7c9b39e11sm388535a34.18.2026.03.17.12.18.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 12:18:29 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Daniel Golle <daniel@makrotopia.org>
In-Reply-To: <a54fd4a7284da506020cb614919096067b195277.1772596281.git.daniel@makrotopia.org>
References: <a54fd4a7284da506020cb614919096067b195277.1772596281.git.daniel@makrotopia.org>
Subject: Re: [PATCH] clk: mediatek: mt7622: fix infracfg and pericfg clock
 operations
Message-Id: <177377502073.529399.1041467096327173124.b4-ty@b4>
Date: Tue, 17 Mar 2026 14:17:00 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=428; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=I7g/c2u43VY/J/F2Og5U0S67dPf/x77tQUHXxD7yaqI=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpuaj9W6U3ZmAOHEiQU+eNE+Cl3UYvPAI+C3dOa
 69WKFbCjNSJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabmo/RYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A1PIH/2wME0MdchoXWEKNRTkAO2YvP4Pjat/0tZMTOfV
 OYbQ6ZBIUVHG5V9Wj3J++E2vNH2tqRNTE7HNde29CwvhnnFD3PPSXFpHyqPyDpN5TsVaGP/qsFI
 6JU/+UX9xW5KwdTaguhEJT1qxGN1Fd35eXKCrOiZpc7wPInV5G34slReb+ZD8odQs7mv/WRJVtY
 pSvETr2O/xe6lqh+JdWkv7joZL36OF+Yew4kWbmUcp/rNQBq5dMWEL4ADdwk0pjoD6GJRoqrWOx
 /mzl+71etPkbmtY3+K1Wsfqx7biGmwPq1Q2nw2wBLTZFemYzDd00nShaXWlKeiilw1r6O0QHcEp
 4Ou4=
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

On Wed, 04 Mar 2026 03:53:38 +0000, Daniel Golle wrote:
> clk: mediatek: mt7622: fix infracfg and pericfg clock operations

Applied to mediatek-for-master, thanks!

[1/1] clk: mediatek: mt7622: fix infracfg and pericfg clock operations
      commit: bd5738fd6779cf9848ddd213ac9fb6e362af3967

P.S. still would be nice to see the output of `clk dump` command.

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

