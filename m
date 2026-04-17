Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 880BBF99C63
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 20:12:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D97A28420C;
	Fri, 17 Apr 2026 22:12:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="suBSESt3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F29B584214; Fri, 17 Apr 2026 22:12:24 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C207A841C2
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 22:12:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-40f0e14b9f9so749496fac.1
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 13:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776456741; x=1777061541;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X9vA9L1YXz4jtzAxh1X2NdL7Wg2YOud3blXYAFGxILU=;
 b=suBSESt3SbbvPsGIeq1v36cvVdGJW2tCfpcK2apy0L/hfzP8zxBdqopvPgieaWXcHg
 cPX3i4phnCpVYkirLxPl/d9ctHpp0aOF6wvvaSkDBptU9NpKI/W6Agv4drHubczkPyFT
 iQ9/4ScnpOBlVZS13y8lmMRoMlz2Tj2zkM6wWigZYIrfUXJ6YQlbjQ0te2pED8l0g4qv
 iiqikgF8TS4sfdv3RHRB1l2GSHO9KR4IJq79chJ8F7UQY0ndkOZJE9NBSD0nGjx3EkZU
 fK6ScXx94IA4anYiBQ7tXRjQh+4pT6ob7D2GR4rUySpWG1cNYQAzx7trqEPcd+5PGSOt
 qg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776456741; x=1777061541;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X9vA9L1YXz4jtzAxh1X2NdL7Wg2YOud3blXYAFGxILU=;
 b=VnmQaLqGh64m4mO/kgDHOzy0zLHuFJCsH5OOpNmcZLfQccWDTyW0+DFLY7oTKr0Av9
 NmqD5yCIqoztbOxEf1h7Pkhh7du/Pd5Gm+LDriksgDTG9+KzmKhkClBCouLxnPBnVK55
 M9A/NS3mODsWUH2mxdGc9tnG0DrjY9w/B2UgIjsVbWRemf2eZBS6IImgkrsjHDKC8kND
 ZBlhX5pqbpsDJHZeEooK5Y2o8qaSzlTnQBAxUe+FJXaUCewHvg2AD5HUr9wtZRccCtDo
 Yz0LCNWmN10SQuoOCrzDf4eE/CEG3ei70t52kGLtiT2oe2lwxTg/fPqtmXVpVEi3Acq2
 /M2A==
X-Gm-Message-State: AOJu0Yx8tpgGCKKaz8LQB1p07C9IhcYnktQWsl4OTd3G9RpJDcQrMUMn
 fX3HbCngfRJZC7m48+bLSx8AW73oCtghL1ZkfnH9DoZPtbnohjb0wTAl1uTL2bWbRhA=
X-Gm-Gg: AeBDietieFEAsGOo0ndRseuxI/g60apzBx+7teNFX1hs4kEkvAnzQb2a6HlfPel7XwP
 ppARZpnGezGnmSCxctJsaRWbBLwmlsUJmOcGtBjtGe6f8MYlkdOuvXuI0VM5mCR5ASm8c0H75z/
 fBNTjqI6kGWx1h3JyhBUwu8G/bj347NTEJDHxpThweW79gz/8NUjMoYc2Lq4Pst5bZHc2scpGZx
 e0dmLPORrxC3b60lshT6Np0a3nGbEr8NiraiQZek0Bh1rZPt3s0jiWd2zCuQKSFTqcQHVD1P/2f
 jT/wn2y65u3dTvbF3NkKUDdWXxXXlu3iJi9mD0q+r7c+DeeV1gquVQvHSeEEoVyf2YXahDotLKK
 iKLKZPLPH9rhrb90ncsdYPiJfQwKOGzxJ10lCZn8FZb42TRb7IQn38ks/DiE7byIxZhl6kw45iA
 2z3HQe+01NWUh86c7HXuBRKu1/5MHqg1wvKoLo4pZgZPNRLnbO
X-Received: by 2002:a05:6870:c262:b0:423:b5a9:888d with SMTP id
 586e51a60fabf-42adedb8fadmr2659954fac.37.1776456741422; 
 Fri, 17 Apr 2026 13:12:21 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:ef27:3314:b886:cd3])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b93046dcesm2297218fac.3.2026.04.17.13.12.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 13:12:20 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: u-boot@lists.denx.de, Weijie Gao <weijie.gao@mediatek.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
In-Reply-To: <20260410082332.102522-1-weijie.gao@mediatek.com>
References: <20260410082332.102522-1-weijie.gao@mediatek.com>
Subject: Re: [PATCH] pinctrl: mediatek: mt7981: fix some register offsets
 and fields
Message-Id: <177645672728.59267.9743943375579286397.b4-ty@b4>
Date: Fri, 17 Apr 2026 15:12:07 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=355; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=9lXnmWEb6Mk9vW3tekhOXldSXsb1nWNEsimWHp2y8xM=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp4pQdxQbOjIUARnbhPl30G4v0VinIruk8gJ1Rw
 N+FdWekDLCJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaeKUHRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A5F4H/RubxssGRRqDzhXXlaRod519jj3lfBhmDjya7gD
 +IbyB3wF/TDYzArwJGsBNcmHrPFyXjVjuuVV7zDfsTknlORQocTdhDiHNf3W1qm56ECFAXK9ApF
 3fYSQyUfVJdw7XIGZsbC+wrOhMRkfmX5drLQUlv9u2bcrI85Vt8oCXtmbWQR+YvILPW5aVEXEc8
 j7ipmq56p41WVO4nf6eeCM1vvqJjXarcGE0Z1j7fE0zE1P6f4V+KDWxWVL/2oU+RaSjUrrH2hlm
 QuQjrHoQ7DEVSIjyYAFNGNAQUg5FKIgfd0SUDJeSI2+fLwNvKBcXlJT7tM9xkfKizszj+77b76T
 3XAI=
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

On Fri, 10 Apr 2026 16:23:32 +0800, Weijie Gao wrote:
> pinctrl: mediatek: mt7981: fix some register offsets and fields

Applied to mediatek-for-master, thanks!

[1/1] pinctrl: mediatek: mt7981: fix some register offsets and fields
      commit: 5576522219d40ffeb7918dd04263f5d925df9d1d

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

