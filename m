Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B96606A31A
	for <u-boot@archiver.kernel.org>; Sun, 25 Oct 2026 14:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=i2ynDxWn;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nxUlpAbo
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 672BE40FC0;
	Sun, 25 Oct 2026 14:30:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4W7RRA5cqttd; Sun, 25 Oct 2026 14:30:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6CE3E40FBC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792938634;
	b=AikedGTC3Muzscz5zXigYV0GuaGDkyPeyUC0DpkoRuqaX/3w8Lesw+k6kg/7Ms2SfWp2
	 F3AEFML4CPXogih3xG2bV+MTAe5mOxoSnJId4tjXpL+xHs9wyk3oDjn2g4basztEgZ41G
	 sk7J2Yn9CNDsSYqh29FuGCgItqOwtYvh9219/QaPbvJp2SWslrwCSaHZPEJjNJF0C3qhP
	 7MkFouwfxx5ejzfI3lRBl8hV2hsu5QKt90G2NwG8PJHeW2LcxW/yE5UzfZ3NVJYuGfrJr
	 Sy0fHwpTV9XAYJ/CvyvbjvgfUjtB7ILh0JaY1GvvU9l71fQE5no6Kda/DZaLylogctA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792938634;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=XBLk3spU8Bdro/GvU1/HbGdwtryMHUJMVpc2/iDm0rw=;
	b=X5zRfeRYhdxArcAVhps0+RkPj/9SDq8/9ICGkTI0zjuB8PpRGOo2Hoe74VfyRRDrq4An
	 mJj/0fUPbycefboipVinxXbZgrPLGTawmQ/RYFWUyu35ebsIie87gaMs+OFG30cSRoFv0
	 M4kYKpaJccLA0rh9WgX/GrVZAqGEgVV0a+dra8fXIPal/hHniptcakCQhq0fIJQbE8vbw
	 MGUXKpdZlu0Gya7sruD//gwvUiUXCi5tQJqg2Lcic2QdMcawapVKe8Ctmia7Mn7uMPeYq
	 adVoWTg7lid/fsAVFmt724dZiY2rPO3DgCeH+5FKVP8BohE4fjB3a4YEvaoIHPY8aTw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nxUlpAbo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792938634;
	bh=XBLk3spU8Bdro/GvU1/HbGdwtryMHUJMVpc2/iDm0rw=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=i2ynDxWnyr/9U3Ohrk2/kF4Fegehuvz4sdQBCmlkUgKkEBaTIYQO8I1F+0x5cy6wC
	 gz3h9jQaVlHbIlarsVGPBAPPx+7UP+KeyFhY5vddmzqSeeVb1HV3wy3SW9UHNHV+Eb
	 Qc1/KmOGrOvGeYMqwRzk4NrtwctC7WyfDgaIxlKHBE3JRafaQGahE9MZfFagYRHePx
	 7sqW/bpidGF/uD+cziIdJ2UiDF+U3KDKKQNsDu246BV2gvoI1S/svV2Y2pF66PL1wr
	 LMgsWrZpYM9TOLpjx35aTRNMz6UIFpWIyo2vxr3Gqm4Nq1kiP+hsUuMsPSzGuKxln0
	 tkPdn6HlHAMnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6CE3E40FBC;
	Sun, 25 Oct 2026 14:30:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 238A73AF
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 14:30:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 20FC740FBC
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 14:30:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GtTlUABgXgE1 for <u-boot@lists.u-boot-project.org>;
 Sun, 25 Oct 2026 14:30:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1E6AB40FB6
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::934"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792938632;
 b=XM2QVjmI4XMPLEHhoIYOQv1CeDP42VMhRskp1U7BVlflX7b4Y7ulYLvD0lKZkTnAG9YT
 yH4GRJYFxq7bD+80WlGVVgvn0qxbi6rsHPRYqnaktlIX8G6fCbT92ibyPANVyT1mIjbLb
 Bb+6uYH54R0wCTliGgXQT/VxVPeEs79IzE3W05DX13OnJ4agwUsHWvrvCvBYI7F+VH2lv
 R25QdKQLW0tJfsDgC9RWmO9jNBUYLdxGWvmJfQ9m74XMv0hrq+mnkWZgpuntTeX1HwJV4
 +B2sJiu6DpuczHd5m66yrWpd1I8U3ljYTu6f0LhJ7fEYIHv7vQ2Wn98J1BXtxmkcJUg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792938632;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=XBLk3spU8Bdro/GvU1/HbGdwtryMHUJMVpc2/iDm0rw=;
 b=lViDj2aXtcc/yrlgH7C+iwnJxOlW7Q2KvGD3N8iA67+KqAKqWE4NfCr6ajUrI8MuAfNT
 wpmCAYagwGoXtpBBdUFyp81+AA2PT4KPjlwWy5yYU8cZhcyT4TW0UjtJwjzZ28brkQVcW
 pO/7P9KmYqRtHngfhNVuhJ0wC2QmI1Dxxiq0j8fghYJXEXD7/xQiMLBsYmJOyrlIoYc56
 drF2Ur4GGcQH7facwbEyyS2a/wuy+bl7Te7jOIwBG5LE82yqCDYHsi82eKVgvQERT/uwc
 pd/QvfMzQoTojBvdcNjSFT1RN6mOYANeWCCgW4a0iJyQXRa+SNwo1FnnKLdfSEUJsqQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=nxUlpAbo; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::934"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::934; helo=mail-ua1-x934.google.com;
 envelope-from=jpaulo.silvagoncalves@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=nxUlpAbo
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com
 [IPv6:2607:f8b0:4864:20::934])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1E6AB40FB6
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 14:30:31 +0000 (UTC)
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-9828fee1b4bso714218241.3
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 07:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792938630; x=1793543430;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XBLk3spU8Bdro/GvU1/HbGdwtryMHUJMVpc2/iDm0rw=;
 b=nxUlpAbo8d5vcJrpa5a0MCxCB7xBHNEzXlbHJtAq9LUVLr6Y1FdnY9XtzsbbkevmJh
 RWNze5wEu72GM9leyRRsHd8sr+Wic4YNGOv9tj7UbzZBn0asz8/U89W1wKcgmZEGRNNu
 IL2xbOSgsMhUJfi1R4tuxHXxewZZ4GWwtd5qKG+AWMdu47b+N9cX+aQimQoUAERnYZOi
 OD+Pu1I4x14YDAPY9U6m/6HaI+IDEYTjMTZq7C4e6ie0JCOmQZQMs0L3Yj7jw7HnDvyX
 CbXXIFX2ie0QhOGZHucIEZaC5PUm0MKGqqmhG1IxGFoLVcaT0uu93/1ZgjVjGTT3yfNC
 lm6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792938630; x=1793543430;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XBLk3spU8Bdro/GvU1/HbGdwtryMHUJMVpc2/iDm0rw=;
 b=rcTdw5zrCUQ4JAL4NzdHCpWsO7S77B9NU/rrtvIy1EyvXTzRjQsjDXD2kf8muvBXor
 IUvNZsEKUXlR8Nwtfo33Z2FbIBoHfQBg39GCVuMV0k4OIcwKxvj55U7YpE9Dsat5oUOJ
 L4dK6WUn6W17hGv2plCIJrMXoXR+lqtIWo2tiGK5VpJ04hr3nw/Ky5WzW78dOPk3zqk2
 +7d0wzel+g9yGoJxLbmxN+dVWRO/y6Fd8GE/c97f43UXvY2XJG5dzwCUsgVTfCa3k7Gz
 vBoTQJmOYSUkyLPQDXfEvp55aiwwHQlC0TCWPEPyZ6nyBIk6TWMwtc1/XHnvl2sW7+Ux
 wcrQ==
X-Gm-Message-State: AFq9FYIilFmI7CFzPEM9DZy3IyA4KUMeblaWRbxE/Vtvmq7zVYhGDCQq
 bMCpTsFhgyKFNT0rJb6Lcby29etMBWWY0/6LE582ZSkfzl5X0SMq8Kxj
X-Gm-Gg: AYBFou1WDhAU5yAdkC5O5GUAS6ihJ2gFBs0LbQ52wrzcNySmqusvhKeVdK6Jd/suIhY
 AgFDlI58gRBLVZFasXscOg8f/+vhGQ5RbbTuLcbRoubu8g9cV0P1S7lJuZOV1Zlw+v2TL/IyD6I
 Oq5TIpsXMDQyuerGR1DIlrXhM6yrQq6EysO5crvugDr5vE1CalKVxSg1eeXAdiFXMFwQbwpCX78
 IPN5OkiWaZc15B+SRArW6FShmzRzEBT+Pk1P9O032YPJ3HTg8omR9mXa0bLy9v+cby1b0U07qL1
 6jwxJ2V3G5/dCQTTUt2zQ7+OGi4dvCbmGBF40lm3/MX9DoGabhHq6TE5v0LszHjqk5LOf2n7sNH
 1Dz7LjKLAvlK1NX2J72QhTg8lqY6u5aW5Y4Ts04fXH4Ek4vYfmnkST77FhLzis80iiulBkOswsc
 fmpL9+u94W/+BdckeaM80jqysNErzLanIo7APiQfLxcY0O9mlk2pmC78sC0Wmf9jAUGnw0bbhNm
 1Z7of4nv0o37LIHejG2Z0q9e9CYIfBimJqC1u2wSaQxYfvCQd7Lea/GpJIBmF7YDVMWRs4m
X-Received: by 2002:a05:6102:548e:b0:7cc:2946:7f69 with SMTP id
 ada2fe7eead31-7ce5cc8aa1emr1007862137.8.1792938630619; 
 Sun, 25 Oct 2026 07:30:30 -0700 (PDT)
Received: from [127.0.1.1] ([2804:14c:490:135b:b225:aaff:fe93:9186])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7ce5df73970sm4848621137.1.2026.10.25.07.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 07:30:30 -0700 (PDT)
From: =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>
Subject: [PATCH v2 0/2] board: sophgo: Add support for Milk-V Duo S
Date: Sun, 25 Oct 2026 11:30:22 -0300
Message-Id: <20261025-upstream-v1-milk-duo-s-v2-0-192b68915c92@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNwQ6CMBAFf4X07BpaKgFP/IfhUNsFNlKKLRAN4
 d+tGOPJ47zkzawsoCcM7JyszONCgdwQQRwSpjs1tAhkIjORipynXMI8hsmjsrBwsNTfwMwOAmh
 pRJmdtBRlweJ59NjQYxdf6g97vM/RP/3GjsLk/HOPL/y9fjv5v06kFFBem6zIEZUwVWsV9UftL
 Ku3bXsBrkToeNEAAAA=
X-Change-ID: 20261014-upstream-v1-milk-duo-s-c4d2935c4298
To: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Gui-Dong Han <hanguidong02@gmail.com>, Joshua Milas <josh.milas@gmail.com>, 
 Chen Wang <chen.wang@linux.dev>, Inochi Amaoto <inochiama@gmail.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Peng Fan <peng.fan@nxp.com>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Michal Simek <michal.simek@amd.com>, 
 Yixun Lan <dlan@kernel.org>, Andrei Lalaev <andrey.lalaev@gmail.com>, 
 E Shattow <e@freeshell.de>, Zhuxu Ran <zhuxu_ran@zohomail.com>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds support for the Milk-V Duo S, a development board based
on the Sophgo SG2000 SoC with 512 MiB of RAM. The board uses the
upstream Linux devicetree via OF_UPSTREAM.

The Duo S gets its own board directory, based on the Milk-V Duo 256M
one. Apart from the devicetree, the two boards share almost all of their
configuration. However, they use different SoCs (SG2000 vs. SG2002), so
the Duo S is not treated as a variant of the Duo 256M.

Hiago and Andrei reviewed these patches internally before submission,
hence their Acked-by tags. Since they already work with these boards,
they have agreed to maintain the Duo S support.

For now, the documentation improvements (boot flow, FSBL, fip.bin,
OpenSBI requirements) are in the Milk-V Duo S board doc. Since most of
this information is common to all CV18xx/SG200x boards, a follow-up
series will, following Yao Zi's suggestion, move the common parts into a
generic SoC document, referenced by the Milk-V Duo, Duo 256M and Duo S
board docs.

Tested on a Milk-V Duo S.

---
Changes in v2:
- Drop the two devicetree cherry-picks: dts/upstream is now synced to
  v7.3, which already includes the SG2000 dtsi and the Milk-V Duo S
  devicetree
- board: doc: Clarify the OpenSBI version requirement (v1.5 or later)
- board: doc: Describe the boot flow (FSBL, coprocessor firmware,
  OpenSBI, U-Boot) and the fip.bin contents
- board: doc: Fix the fiptool command: pass --text-base to match
  CONFIG_TEXT_BASE and add the required --rtos path
- clk: Drop E Shattow's Reviewed-by as requested
- Link to v1: https://patch.msgid.link/20261016-upstream-v1-milk-duo-s-v1-0-e4bf386eea2d@gmail.com

---
João Paulo Gonçalves (2):
      clk: sophgo: cv1800b: Add SG2000 compatible string
      board: sophgo: Add support for Milk-V Duo S

 arch/riscv/Kconfig                       |   4 +
 board/sophgo/milkv_duo_s/Kconfig         |  30 +++++++
 board/sophgo/milkv_duo_s/MAINTAINERS     |   8 ++
 board/sophgo/milkv_duo_s/Makefile        |   6 ++
 board/sophgo/milkv_duo_s/milkv_duo_s.env |   8 ++
 configs/milkv_duo_s_defconfig            |  43 ++++++++++
 doc/board/sophgo/index.rst               |   1 +
 doc/board/sophgo/milkv_duo_s.rst         | 131 +++++++++++++++++++++++++++++++
 drivers/clk/sophgo/clk-cv1800b.c         |   1 +
 include/configs/milkv_duo_s.h            |  12 +++
 10 files changed, 244 insertions(+)
---
base-commit: f97bb5c1ad78e95856917b92c7270c82d4b11e21
change-id: 20261014-upstream-v1-milk-duo-s-c4d2935c4298

Best regards,
-- 
João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>

