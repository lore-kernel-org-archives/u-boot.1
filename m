Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFC9606A326
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 12:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0VkLxjS8;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=T8eONa3J
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D1971606E1;
	Tue,  3 Nov 2026 12:40:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gYHyVxBOO0fO; Tue,  3 Nov 2026 12:40:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1838460663
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793709629;
	b=U0OFTNKJGl4ibLglvG098eSV2zPITvuglM82P6YdOl1LG60OlX5q4hWMpZXaq2DG2pFG
	 UrmNJm0hsjhDRXVYdGr73scyUHEJnS2kzwqiz54u3YOcq7RfQYDwTvSo38HUAgwYUtnRt
	 p3KEMFkga3AIL2QrrNF+CTKxtCdVWn3j1jxGoksWFCHhuVnSC71+4f+64Nv/8nEjKezY3
	 T4D7gBrPF0pugOxUBH+SzuyN9KZmob4B7kZ1l9pRv8jx+FhmDWZivbZ2FeucUBPws4jxw
	 3QwxjPv1qK8MtQ4fpwykkCpbtnVcdFbdP/UQyU6GZF3AtUHFqJ1O6dudjr8kbACJzdw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793709629;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vHR8V6CZRYqcH7g0IlOCY63al0SM5IaKy6KM6vDicv4=;
	b=ib1j+DdMTJW9Pbh/0K3d7uCM7x+4TUSwPZX373pDa58l3ClIUWV2GfK5KVnWd5d4K6iz
	 X8fRLpbaT0BcBSOxp02LFXtAEd965mrklxzSwmpSLTSCWCCluzqxGCDWk93lGPQ0LyBV6
	 w/aWLxT382vti9WOUUilw/TnK/pGarTP4XBLv5ETregPhEJS58rXPMSFiqfCPn4k7+Exr
	 2UzzhqBr8paNWU2kytVM+EDyjQ7L0z8CV2GFOssxr8SExGsA4wuktNRYN4mM04XZitO9G
	 C3lRi0yoEKDoVEMD6c6WQyd5p6o170QEM5usxLpOiY15Mts6f9O5/KpDtrgWbFhHxYQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793709629;
	bh=vHR8V6CZRYqcH7g0IlOCY63al0SM5IaKy6KM6vDicv4=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=0VkLxjS8CEU/qhYLRZ6LQeylURmmFH/ywK1Yoo4Cm8tDqx+tu093BIg77aZGgIakj
	 SeuDn00ORZ/DDs4j5Dl003HG3Fh8nl9vDsVnkeXHoX9t+Ywbtq6wwaEHOGs4RUMt6e
	 1RuYXGEem1o5MnkzJKMxyt4VNCb0E0slo1ICG27nAhcH1sXDfdcEu+Guz9S0SqDZgr
	 MU7Oz33Y4B/UU0TbepofKYPPa8ImXAduuoOu4QAQFPkzewHo7j/PmXTL6pY6B8czUN
	 I+kzASDV++SRhgLrDkDhf9934zRKMYNHk6kcWQeE/kW6oBb4LqWIPeb8xOm84ybYt4
	 7DSz5WToiVL7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1838460663;
	Tue,  3 Nov 2026 12:40:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9076C235
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 12:40:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 769034064F
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 12:40:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a3iruzkty1C5 for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 12:40:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CDAEC4064B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793709626;
 b=APyFR4Nec4muVABG8xM598ApRLUsbiDoD5mAxFh3+y1eA2zZVwWPmU6UqcROiIobYp9f
 Pu/kIWEsruobz5tQ+t8H3pvlo7k2eNBPMj0+wBgxRygydo7K+edoRh45IYhei5XQGKCiZ
 quaEnFO7+EkfHMVeJhG5lHEJbn88xtmyev9J9QDAZkixhyBHYzAkrmPqzLMuVLyDk1LMq
 lIbpcp5LrnF1UX/Sx0n2HEFa2q1fhVOfo7vjFHud1DowlAD8z1rO7et6Tz1eJZ3aK0Z8l
 7A5GAOiXn+aIRHysYQutJseIrnVFvRvP7sNBTRiCnfyAV3kXpieKNcrRiQ69dGzkS0g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793709626;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=vHR8V6CZRYqcH7g0IlOCY63al0SM5IaKy6KM6vDicv4=;
 b=N3Xk8xtCSjYEMB93fQzMtwTfs6muBLfmo4jT+vR1p6jQXy7ob7PTOdGVB6iqu4A25u7m
 up8P2yBQSJRl29b4OZv91uwDnwEn46bvaxZtpAjUvCSDhDrYGFDjp6OxysVzgL2d3tCQm
 EgrSSKvq0NQ9imB9doPiQRx447FGkCeb65DX82OHh7oqvgHzcr0QUYoNPzA+YyYCBNcsm
 wPOvRocJDoO/y504A2ej/6aEcf9HVtw+zb+RH++sRlcvZIXQUrs2CfvwbPI0VeIoSwY7/
 ovqKkWSZG55rx39a9V18hni51WgTttP6sRNmHPlHGiFuch6x4C8qtuYsqASEyRNEJsA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=T8eONa3J; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=ddrake@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=T8eONa3J
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CDAEC4064B
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 12:40:24 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a4dc547987so21116345e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 04:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793709623; x=1794314423;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vHR8V6CZRYqcH7g0IlOCY63al0SM5IaKy6KM6vDicv4=;
 b=T8eONa3JsPb8YPOEpHGOpQiPFErn2mUeePjQLX6BC2HNdBqZZ3+Rww4SUuvp5yLul2
 n6D1NCtc5tU8ES0jP81WWE5jP2LsYfpw8eDeKjrqZcYxvjA7ZbVlljf1NDdSge4/LGTl
 2X/dWW+3W1oHmfpsNN9Q774K601swkDKyHdEpxR8Zz/6gDqMUROE2QY7aOIlQ2fX7oW/
 JVDlNPFZsPQu7ey9p4SlSqmKv2iNAGj4DGwoZobMQKCY7xPITNwpOz6D4bAnkaECMeu8
 xpm9YaHnQPBaEpqoIOtWJ8Jaa+jOUGuZ7kf3OXeO8UhLcjG5v5Q/a8lsLc7CYPofx+hC
 xdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793709623; x=1794314423;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vHR8V6CZRYqcH7g0IlOCY63al0SM5IaKy6KM6vDicv4=;
 b=1DGucYVJyEp0kS8GBKUtSFNVHaqOYjqHFXSLLn2sw9XMVvhm1ufFtB5Ltuwb39byjE
 6Ap2ViYWCIGozxE55VapTc0Q/LdejGWdUcSHNQEk6rybOMklLND3mfsWWVWaeZWYqP0P
 lvI40dSZXv1HveoFDcFkQhLY3omz3dmjeqLu1DICFOQBG4eOSwHM6BXDt2I46bmz3wEK
 GvZjphUmO9lFNGbPcG5XapKIjpqiztkY7Ae3pWs9C9728zx+3q0JwT5AfeRVxkLn9p8v
 aTm3tM0DGNuOb16Ga2fPThZfYZVQXOZWvmEdUyLljlzxmb1vqoXUnMHNVNYyOEC7z4FW
 HV3Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxDtPDj/gE0ZbjeH8+OkOg0XVDQYIc0cyZHhM2ILLCS92MAjcSQ64PaS68YHtsrdzUyFHx1fo0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+mSskk+aTNwFgchpBPThBwpw5VU0kBZf7omNsDAfyX/Cj4qKNS
 a++8qL/jtU8kb0ocIGNxC1UBFxoZ+YvlbrZ26xmK3SVnVIGMr6vpwnVWkELogyDXVt1TYmCxsj+
 yH7uaWlrhuQ==
X-Gm-Gg: AYBFou0K/wxqRKR8iSq+yMZ6ZPn6XYn2vpwGq4lcRN19/MIhCI79rs+SHYhbV/TRqJ8
 PnowqldgoqGP6OFlRAJ4J4yxPVG51j7+2/elZr5sa9vjcm2vhEa+2iN/sbkA+8Gy1Ycqp7SolGq
 aLwLcG6Ta9Gm4cfDc5EezUlefToVP1PdRIDAiQMzw9or0XOD4QzOJ+C9qGCJXSEuOOluXnKgTke
 MECsiQD7L+2rNcej5c8KZfaMRkvNq/VVL4LG7/G8mr3e3RLoYI52/Dq1Lc7Y4wQmK+wRPIGiiUC
 /UF7STrikwjydVfT5j+qQPJCVIbA34ARALVethJAoKOB4seK6IX0AXpMjtowPRxlaqYFbdB0c1a
 ikNfnFXJR3EkMt2HRIXeQ1b629sytIF5u1jQGyeipdmC4rK4avqd0fy7HVd7X1oDneGh3rZlzBQ
 DTWH02DZ0Yp0y7+5DBKOcnfcSFh2n5gx6dA2lQxf+31gylZXWspArle9aqgtb6TlaVnKTjKHk2R
 WVAjhiN2JEshd4HaMYPG2qLSSYzgP2tiGQ1K4juuJB19RwxYMQnjMycjqTC25CjF0grL+lYcvDU
 ocYGO9I3AqGRqB4I1H1kstteGOsva4/0fVzXeA==
X-Received: by 2002:a05:600c:468c:b0:4a3:59c9:a750 with SMTP id
 5b1f17b1804b1-4ac17d168bcmr300981435e9.9.1793709623029; 
 Tue, 03 Nov 2026 04:40:23 -0800 (PST)
Received: from [192.168.1.123] ([2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a555e59dsm60369835e9.0.2026.11.03.04.40.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 04:40:22 -0800 (PST)
From: Daniel Drake <ddrake@baylibre.com>
Subject: [PATCH 0/4] imx: consistently enter fastboot on USB serial
 download boot
Date: Tue, 03 Nov 2026 12:39:21 +0000
Message-Id: <20261103-imx-usb-boot-fastboot-v1-0-f3a918d55a20@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQ5AMBAAvyJ7tokSDb4iDqVb9kClizRp/F3jN
 nOYSSAUmASGIkGgh4X9kUWVBSybOVZCttmhrmqtVNUg7xFvmXH2/kJn5PpB6V63znTUWg25PQM
 5jv93nN73A4VJQqBnAAAA
X-Change-ID: 20261103-imx-usb-boot-fastboot-16965fa8e5d6
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org, Christoph Stoidner <c.stoidner@phytec.de>, 
 upstream@lists.phytec.de
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Daniel Drake <ddrake@baylibre.com>, Ye Li <ye.li@nxp.com>, 
 Simona Toaca <simona.toaca@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Mathieu Othacehe <m.othacehe@gmail.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Torsten Rupp <torsten.rupp@8tronix.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Marek Vasut <marex@nabladev.com>, u-boot@dh-electronics.com
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When an i.MX board is booted in USB serial download mode, the host
(typically uuu) expects U-Boot to enter fastboot so that it can go on
to flash the board. Support for this is duplicated and inconsistent
across different boards.

This series adds a common handler to introduce consistent behaviour:
when booting over USB, launch fastboot mode (after the usual
interruptible timeout) without checking if bootable devices are
available. After the fastboot session ends, continue the usual boot
flow, which will result in any newly flashed OS being booted. The
handler acts as a soft-default: it will not take effect if bootcmd was
customised by the user or the board code.

In addition to standardising behaviour over existing boards with
fastboot behaviour, this generic handler will introduce this automatic
fastboot behaviour on boards that enable USB fastboot but have no USB
boot handling of their own:

  i.MX9:  Variscite i.MX93 VAR-SOM, Toradex Aquila, SMARC and Verdin
          i.MX95
  i.MX8M: NXP i.MX8MP EVK, Toradex Verdin i.MX8MM/i.MX8MP and SMARC
          i.MX8MP, Variscite i.MX8MN VAR-SOM, DH i.MX8MP, Data Modul
          i.MX8M

I also remove now-redundant board specific code from the i.MX9 family of
boards. If this is accepted I'll follow up with similar cleanup of the
i.MX8 boards.

Tested on FRDM-IMX93 (I don't have any other affected hardware
available).
 

---
Daniel Drake (4):
      imx: enter fastboot on USB serial download boot
      imx93_frdm: drop board-specific USB boot fastboot handling
      board: phytec: phycore-imx91-93: use common USB boot fastboot handling
      board: kontron: osm-s-mx93: use common USB boot fastboot handling

 arch/arm/mach-imx/Makefile                       |  6 ++++
 arch/arm/mach-imx/usb_boot.c                     | 45 ++++++++++++++++++++++++
 board/kontron/osm-s-mx93/osm-s-mx93.c            |  5 ---
 board/nxp/imx93_frdm/imx93_frdm.c                |  5 ---
 board/nxp/imx93_frdm/imx93_frdm.env              |  4 ---
 board/phytec/phycore_imx91_93/phycore-imx91-93.c |  5 ---
 6 files changed, 51 insertions(+), 19 deletions(-)
---
base-commit: ab4dc5aacf957835c295b59ef2dd28281839cb20
change-id: 20261103-imx-usb-boot-fastboot-16965fa8e5d6

Best regards,
-- 
Daniel Drake <ddrake@baylibre.com>

