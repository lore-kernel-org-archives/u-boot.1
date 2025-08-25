Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1208CA0FE7
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 22:46:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D3DC83102;
	Tue, 26 Aug 2025 00:46:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gL6sA47b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5B7C8311B; Tue, 26 Aug 2025 00:46:21 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B661D83102
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 00:46:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3c380aa1ad0so2417743f8f.3
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 15:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756161979; x=1756766779; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ETmWWDL9eEgNozDsUUZOhhKM9ai+flxm9ww6PhkHeHI=;
 b=gL6sA47bvGNfyYaDR6e6HC64NO49Z/P94xFG5MGgd1bST9xFe8P+YCs0+Vo45Rvx91
 ei1/K1JdGGruKtUau7CTEl4MEvx85Oc5YBqMy0RUWP5esENM4HA8UPT3tVfAvuoOiK2d
 is4QssCsJnPoB+UYLn8l3/Sk2jfs0vgEk2Ha2QJmK0xeUByL/+H93QFFhvV6mX4LcfLz
 NUyudF/tlywbGJWR0r0KziO0Z241LBVP4UAIZ0a0r6SI1Cw50IE61ucFr0K//XQZR1O6
 6DQ2PmSaF36rFsZVxz0KeJOMrKKF4+YFyqIIosAZbYCEvspWmk0dhZAd/HMtBil5Gqci
 86bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756161979; x=1756766779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ETmWWDL9eEgNozDsUUZOhhKM9ai+flxm9ww6PhkHeHI=;
 b=fDJ4L3DztIj+BW+YWpsyhowoMxOJzufMEhmDgCbZUZKTF9PmlebZnMONS8XnfWlcIB
 gD9SVSbhStKi1WgMUgOjEJWdV5ZIJ1OQURCGQtdgs8nz1cqqNglkIAGgS5IfK20STI52
 gvGZPWV0T4Ht9LnoSLPZq9dFlQ3YlamXnp9LiXtRdg9U7KCSOtSL0dwO/ncBNeMairQ2
 525cEA6KZTG+pDxByuE3bgRMX9qstltlzExjEQY28CkKOZa4kMqXBpTSvG6Nh+DR5Aph
 PcpAltynQFpQjkdBL5gcDAny35J69vUewcNtY+/MpY3Ir8nqYaJ1yy+9bNgpqnEU54Js
 lr5Q==
X-Gm-Message-State: AOJu0YwAxjLWKN99NLuIy01WTO3qtqpt8FiCiB+ZJYCvLinujRQ8sT4+
 UMRIHMkprpG/DrNSujU6nPqQbKN3rjoYEIYbBL8lYsBvqlg25fcvIaRnjbYMkt2VYZU=
X-Gm-Gg: ASbGncuhCmX/y0cuR5heBxCXnExI7mYdT6F1N2L+JsUYOIyibuDLYVK6wyLEHnlL6H0
 8Nh7IxhrSFozF/JmZPlikLyaQ+O5JWm+5KrkfVOx/7AvGMT/zvTFyZxlgVWfzn2N+8jmbVr2DGs
 WDoOU0aBabWwQA0ELgr5SR01St98Jlbbn0MKoQOhie+StB0BntuE1OAi9jazCO3DlE6unXYDt39
 +ODEOzPXOmQr8iRYpAZdjsoiHalbOIh0dXDxrpiP2mVguipHAfw6Gxd7HV00IonccQpw7INYi7+
 Q86OVzIIbjQx8SSmBmvyfpukj5g5BqiswLZu8YdCImJNduPPj+OIWkZBOjvttY0OpwItG8wmnNL
 ZeHkRt+Fi/dtdOL/eKT9hq2lScESow8kDnImzZi8=
X-Google-Smtp-Source: AGHT+IGpBeCI1MmL2ECzAdlyqq+imRpj7I83sEoXhDulmA8BTRj3aM5+Ym53hFOQkOpb5gTRDg7qww==
X-Received: by 2002:a05:6000:2411:b0:3c7:c594:232a with SMTP id
 ffacd0b85a97d-3c7c59427c6mr6555467f8f.19.1756161978806; 
 Mon, 25 Aug 2025 15:46:18 -0700 (PDT)
Received: from N580G.. ([2001:8a0:c46c:a000:ba6:baf1:694:9882])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c7116e1397sm13296086f8f.49.2025.08.25.15.46.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 15:46:18 -0700 (PDT)
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
To: u-boot@lists.denx.de
Cc: Adriano Carvalho <adrianocarvalho.pt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Neha Malcom Francis <n-francis@ti.com>
Subject: [PATCH 5/7] doc: make pdfdocs: Update empty SVG file to something,
 otherwise compilation of the *.tex files fails
Date: Mon, 25 Aug 2025 23:44:48 +0100
Message-ID: <20250825224459.682403-6-adrianocarvalho.pt@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250825224459.682403-1-adrianocarvalho.pt@gmail.com>
References: <20250825224459.682403-1-adrianocarvalho.pt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

There is one SVG file (doc/develop/pics/spl_before_reloc.svg) that is empty (0-byte) and because of that it is not translated to PDF leading to an error. See below.
This commit updates that file to something (i.e., an simple image with "TODO" written on it), solving the problem.

The error in docker.io/trini/u-boot-gitlab-ci-runner:jammy-20250714-25Jul2025:

uboot@35c89b9ab70e:~/u-boot$ make pdfdocs
[...]
WARNING: cannot copy image file '/home/uboot/u-boot/doc/output/.doctrees/images/spl_before_reloc.pdf': /home/uboot/u-boot/doc/output/.doctrees/images/spl_before_reloc.pdf does not exist
[...]
build finished with problems, 1 warning (with warnings treated as errors).
make[1]: *** [doc/Makefile:84: latexdocs] Error 1
make: *** [Makefile:2686: pdfdocs] Error 2

NOTE: This won't completely fix the pdfdocs target. See next commit(s).

Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
---
 doc/develop/pics/spl_before_reloc.svg | Bin 0 -> 239 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/doc/develop/pics/spl_before_reloc.svg b/doc/develop/pics/spl_before_reloc.svg
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..917170799187a43d09c129e0c735326ad4c4db6e 100644
GIT binary patch
literal 239
zcmXYrO%8%E5QX=gVlsPa(U=%RAsXY>4IZFMg^8s#w4vzf9TH|Y@8`=a>v^y+nK6)e
z3X5DK829uoxlZA|xo!>!A!^rZ>zz^PJl0iKhN%N?x}dO+@pBX+rIe>#?#E7SrIdmb
zn89+1+SoH&GP^g_^-<wouI5B0o&Bs(f&`8LI~DiJXyyouj_~F39^vI(+`RNamW9(u
h+OArlA1^Dm{F1c_A67r#ST(oHtrQD~2QPc7><^w5Mt}eS

literal 0
HcmV?d00001

-- 
2.48.1

