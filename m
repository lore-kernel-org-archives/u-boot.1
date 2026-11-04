Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA08606A32D
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 09:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uAqP14lz;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=E5XglomK
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3631C80C55;
	Wed,  4 Nov 2026 09:48:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WFWP92Y0JY0K; Wed,  4 Nov 2026 09:48:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 33F1D80C3B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793785719;
	b=gQTGlv/pWqw3q3Zg+Ue6iwJcNI4uPtKHHo7JOeINXAfgQ2Tj2OFqI4OhcO54hz419Z61
	 O1b8NRX+qg7QG2MkYyRwZw23xNp7eyOQI149IsSGBDBq5y0PODMRETbrZ8PCiYrnCyNGq
	 i6PmPwJH5ar5z4o9nOzRlVTqLgeoEne+yy5BadpHgbJdzXBV66ktueC3JKjVcqwPI7yRp
	 5xBprCysVk+5Mb4ghiBUKYiww5P19H3OqTZ28VXSWMdAlq8C+WFPAa6fhnOfZkYP++bss
	 EsycjdxQePo6Qmc0+pXv5s/YuEa6Pr8335q9Meg8SfiIIbry16RWFKRfiLGmUVJbjhA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793785719;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LS88UF96aS/1GKJNmSJNPtrzPpqiD3bq+Is3yX/VPU8=;
	b=aJbX4Sgvye72cgs4PBO8tsdripp7XRXzkwuMONAbtGyEWq7xPPcnJrqcN0CdN+yM+abW
	 5E0ad9AcQXsmYSVegAGNEskUQbpSEFIYDVI0TPq1pkPbKh90nH3TmcAHguL/cqoNOC+C3
	 7gTP/mC93kMn7NhjVu4dC+1I3jCZyNwRaXb/lAWwZn2ZS9PA5nSOiownraIXgiG2YuNqZ
	 qiKMm2TEJAUAvnWFAHDPbZmtnAMZdRQAJlvn1vehxovViXeXqcx0qheCRLScVQ9CDHt5m
	 VbrExmETPMLMYHM32FM4eI7DvLCaHzdMJsZMkXZz4CkNEzNGOHzRhVtyGC4YHw9rnvA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793785719;
	bh=LS88UF96aS/1GKJNmSJNPtrzPpqiD3bq+Is3yX/VPU8=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uAqP14lzYp4JROAJj8EpMcalofr/4YzSDsIciAIumNH/W9dWJVHslww9+FR52okw0
	 hhXBt7cbBPBmRWgVXjpZ4MtdpoFJQ0Dbi1Lq4xaXkgnoDGue08dSlExwKlBF2TJBB+
	 q2PGhQvvgbyNwGnJF8vM4fLs+8xzp34//d8QVbPdd8bNoWr2vUEBonXo3w6jwSL/uZ
	 6V87riFI87CTulTQ772z8ITlSX0MPKV8e8U4nUI2qsqhsedMgJob4L87A7yoadLw0u
	 zI/6vwXn9rQnXTGRCdDIWZQfPTktzZr/WbGNHuX1CfFVYvcZ1nh7PzxMlrEHAzPKzq
	 DJyEa8UcPsDmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 33F1D80C3B;
	Wed,  4 Nov 2026 09:48:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D9DA9C4
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:48:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1E77E60768
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:48:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id boBAn_hTKNOp for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 09:48:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 28AA3606FA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793785717;
 b=GKSRn8CbMt9Vj0V5VTCtTA8ed1QIQMY10/yk5xfzZZ4bIgA1XYGAJbKZywcuv7P9MVxt
 hj125tPTOzwIzSGRe4O9AGHq5drm9pti87LwoWdctZmiZkenV0LnGyHynUEcgc0Vmcek7
 bw8Hox57FbcbqUqQ/0cv4u6ih789cN6tU2O6aQ7aLmu7U8vWK4DXXNmOnQYVvfWUi696N
 tS6OAsUBr93IMzrp+nVg35iXzfTvs6WnyR93N3AnBGVEpPOgcnve99I2flxXVD4Kbuuth
 qSJnaoHOxcTVpcam6gqxxttbTxWLKwvGG7iDn2jHcZ78zsAKFwWiiSbEuYnYUQE632w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793785717;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=LS88UF96aS/1GKJNmSJNPtrzPpqiD3bq+Is3yX/VPU8=;
 b=E/IHT2Oj35npJ0XTFgVXyaQovZiGX4UkDHoeEGQIlh9aM19Djgm2AMN0ue1iE8A8VsDN
 fWT7TFsV5GAdrtprgDhveXd/oxiWkHAd10mBSQyObfWlFX6M/pxyFF6iTAUTHb5YwGxfd
 JhVmiXkb7lkioBmnZdHM7Cj2WX0l4w4zQVOt3PGDgrcp0E+bWb6FNo8sRZWdMMAaEgjfc
 TGKwdnGqUfSlq6PzHRhkhGjGVPlm7KjHYazuM/MIh1MPDfgU/LrVn6MMXjZl0hdi+zDjZ
 egkhU0Y9b6XdKcvNMiQPAb+aub4EFKjhwFZuA7ijAqVfLQbaP47fBySl3oVdsTlblYQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=E5XglomK; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=E5XglomK
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 28AA3606FA
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:48:34 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48dfdd0678dso381582f8f.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 01:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793785713; x=1794390513;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LS88UF96aS/1GKJNmSJNPtrzPpqiD3bq+Is3yX/VPU8=;
 b=E5XglomKblOdtSZvh+kZEAS+hn6/1nip1sQbcAcqNwKn1RsDJ/4Npqc19M4wCUkiSk
 dhenJPT/UHOJnxj2W8d48oL1EsCsmkx2d3pqaUuQW8OwmjgHGm8Ko2jpsmA3LfWzRYwJ
 qLnyURTogKIzSGbntHzO7L6VVqXzRba89w8GdOa5rWh+9mi+hBUgqbPnaH7kDWTjTJzt
 NIhgCTurll2+tC645ZyGRrlIHhe+5e3fgyTgwb+QYetRzQcqVqHFerXkp57CaxDp+bcO
 Cz5h/y/hWvEQpEp/vE/uUMVySr8poHqtW7mG5rO6+1oJILA6pmEIlw/eoKCiSGFDGt04
 CKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793785713; x=1794390513;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LS88UF96aS/1GKJNmSJNPtrzPpqiD3bq+Is3yX/VPU8=;
 b=qtZzFSVB6ksmoSxeXxJn1z6dpkbkTgoHNc5LeGueWioBE+dpW2CEuUsdqWpussmDwu
 spZ2sL+ow636G9s8T5TvQ3q4DCOPY4WvWJa/hnqiCrLQ5bjeFlLuyYGWRoCO7DekayC/
 +Ko7gGnRl3dMqdac5SNUSxIPQuZCdEnfJH6tPOUaOG6YUSGRl1aOzSu5ccnkorKhWohm
 2GnL01MMOVeuZz0d5MIVfPzwJu+8fuv5Z+0tk/sYlOF/K6uUtNh+tJN9CdlbJxm70aiD
 xfQK9FNKKG3AFJzzIvcc+ObJc7JWsqeDTgI+t/kPZgp25LFnBvzZClsxl7o/ezPGdYjB
 Tncg==
X-Gm-Message-State: APuU4Z+gTuEP2vGUnXNEKFKpJ5UjvObmf5hhUC8GtjFSYqOMQrCWBLDt
 sBZH7S5IPtipAayGFoK/f34EVU+Yl4O4ue2qDpSmk3ag5y9a+VHvq7zYgfIuuR+VKKw=
X-Gm-Gg: AYBFou15iugTjibjW3Gf66aaHiLBodPrDCytVb8hbcrqfo1SPBZovv/GN7fhDQ0x40x
 Q29K7nKeGoZkvmSoYOGWUkKSi77E5dPsL+5n8raMXIy0Bac7La3Xz6rXK6CZLEjLXbRgHTrxDIX
 7nLa+pQA1nd5MC0f2KU56eQYEzrNX/55P6P2L9oPE5a9KDh03jKfKehipgiUo+C5Dag/EVkuzv5
 19G2hkEEhBoSe4ummsFzpEmOUBD77NMkxwi2o2hi5zsLO9TjSzOjJ1MVj9EZy6qVOvLGxNJfemR
 X+5sRSQp3FckkSD88sI56uEhWJTnc4Z6eR7ug853FVOOoHRC4Ap5ORV0+bzF0dylAvEEUtBvq5b
 jx+O3GVXpKrRCRuZlm12ljzf1gd3Bc006OYrWRSdhgjn6KQTAnP58qOI1TDYDhkmOYJO3D4gCn/
 K8OTvfdiOVOnxZmoFGuQtKAYyWGS80lTg9OZLE6WFZjcgJBXTM6KaVq4RSy/8m/QvAL/pd6UCjh
 THzd7+8b6k8RAUqFEuvJY+j60z2o6yBZ8TWIZ7EcRRUyu7HWmHQ3IDOymSGgl4CgKA1liZj/Tbv
 h1VD5qA9Ck6VYDiJvD0tPu1JICo8XeEXABFNRKY9MQp1v6O6
X-Received: by 2002:a5d:5d06:0:b0:48d:ff71:dd87 with SMTP id
 ffacd0b85a97d-48e6e303f29mr34909405f8f.17.1793785712887; 
 Wed, 04 Nov 2026 01:48:32 -0800 (PST)
Received: from localhost ([2001:4090:a244:81d0:2c16:1c4d:8a04:e0bf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fece99d67sm2909809f8f.24.2026.11.04.01.48.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 01:48:32 -0800 (PST)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Subject: [PATCH v2 0/7] arm: dts: am43xx: Switch to OF_UPSTREAM
Date: Wed, 04 Nov 2026 10:47:47 +0100
Message-Id: <20261104-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v2-0-6091edbb51fa@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEP/6moC/52OQQ6CMBBFr2K6dkyLIOjKexgW7TBqjVBsSwMh3
 N1Wje7dzZv8/P9m5shqcuywmpmloJ02XYRsvWJ4ld2FQDeRWcazHa+yEkK6QHDoaPTgTa8RZJs
 XYM5D77wl2SaOCF8uFRZClTlKJBabe0tnPb5WT/Wb3aBuhD5NfRKWHkPU8b/YVTtv7PRyDSJ93
 1p7vv1LKwjgkJckcLdtRFXhUcnprpWlDZqW1cuyPAHbRw3hIAEAAA==
X-Change-ID: 20260827-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-7bc51b74cace
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, "Andrew F. Davis" <afd@ti.com>, 
 Nikita Kiryanov <nikita@compulab.co.il>, Peng Fan <peng.fan@nxp.com>, 
 David Lechner <dlechner@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Julien Panis <jpanis@baylibre.com>, "Mendez, Judith" <jm@ti.com>, 
 "Francis, Sebin" <sebin.francis@ti.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3354; i=msp@baylibre.com;
 h=from:subject:message-id; bh=FoObyVODtbwwhAsVaSRWtDg1vb25DqQB84zZOp7t+c8=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqxX/13XHmRx/7P12dwbF9fsNE/etuq+oeqEzDsKIb/Ws
 EhfvFJn1VHKwiDGxSArpsjSmRia9l9+57HkRcs2w8xhZQIZwsDFKQAT+T6R4b9zgIlhsPvsVVez
 Pi+zsomYqPau3zs/IzA2qF28XvIspzrDP9MNa4oMC63Xf7ilHjVb11PFQOi10lPFUOHPgZUxCT/
 nMAAA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

this series does the final changes to switch on OF_UPSTREAM on am43xx.
Mainly it adds some -u-boot.dtsi files to define tick-timer and other
necessary pieces. It changes the defconfigs and removes the old
devicetrees.

This series does not have any dependencies that are not merged.

It was tested on am437x industrial EVM with mmc. Help testing is
appreciated.

Best,
Markus

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
Changes in v2:
- Rebased, all dependencies were merged
- Add patch to remove the generic devicetree because of a missing
  upstream one. This broke the build in v1 as I had a temporary
  workaround still in place uncommitted.
- Add patch enabling PHANDLE_CHECK_SEQ
- Add patch to use usb aliases
- Add bootph-some-ram to device nodes to be able to read EEPROM early
- Link to v1: https://patch.msgid.link/20260903-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v1-0-47e1c63d188c@baylibre.com

To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: "Andrew F. Davis" <afd@ti.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Nikita Kiryanov <nikita@compulab.co.il>

---
Markus Schneider-Pargmann (TI) (7):
      board: ti: am43xx: Remove am4372-generic devicetree
      arm: dts: am43xx: Add missing board u-boot.dtsi files
      arm: dts: am4372-u-boot.dtsi: Add tick-timer
      configs: am43xx: Enable PHANDLE_CHECK_SEQ
      board: ti: am43xx: Use aliases for USB controllers
      configs: am43xx: Switch to upstream devicetree
      arm: dts: am43xx: Remove local devicetrees for migrated boards

 arch/arm/dts/Makefile                     |    5 -
 arch/arm/dts/am4372-generic-u-boot.dtsi   |   16 -
 arch/arm/dts/am4372-generic.dts           |   23 -
 arch/arm/dts/am4372-u-boot.dtsi           |   76 ++-
 arch/arm/dts/am4372.dtsi                  | 1006 -----------------------------
 arch/arm/dts/am437x-cm-t43-u-boot.dtsi    |   21 +
 arch/arm/dts/am437x-cm-t43.dts            |  420 ------------
 arch/arm/dts/am437x-gp-evm-u-boot.dtsi    |    8 +-
 arch/arm/dts/am437x-gp-evm.dts            |  798 -----------------------
 arch/arm/dts/am437x-idk-evm.dts           |  420 ------------
 arch/arm/dts/am437x-sk-evm.dts            |  710 --------------------
 arch/arm/dts/am43x-epos-evm-u-boot.dtsi   |   21 +
 arch/arm/dts/am43x-epos-evm.dts           |  803 -----------------------
 arch/arm/dts/am43xx-clocks.dtsi           |  754 ---------------------
 board/ti/am43xx/board.c                   |   10 +-
 configs/am43xx_evm_defconfig              |   23 +-
 configs/am43xx_evm_qspiboot_defconfig     |   15 +-
 configs/am43xx_evm_rtconly_defconfig      |   23 +-
 configs/am43xx_evm_usbhost_boot_defconfig |   23 +-
 configs/am43xx_hs_evm_defconfig           |   23 +-
 configs/am43xx_hs_evm_qspi_defconfig      |   15 +-
 configs/cm_t43_defconfig                  |   17 +-
 22 files changed, 234 insertions(+), 4996 deletions(-)
---
base-commit: 903c9578eeb36d72f087082da494c605ddaed3b2
change-id: 20260827-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-7bc51b74cace

Best regards,
--  
Markus Schneider-Pargmann (TI) <msp@baylibre.com>

