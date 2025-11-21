Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3637ECFC28C
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 16:59:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61FE7839DF;
	Fri, 21 Nov 2025 17:59:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="L1eczk0j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FE618398D; Fri, 21 Nov 2025 15:36:46 +0100 (CET)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28EFB8394E
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 15:36:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-3e84d56c4b8so1382678fac.2
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 06:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763735803; x=1764340603;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uZ34Ll4B2WaAx8rmMMx9Oqf8XXY7JvGifYLy/eSWiUA=;
 b=L1eczk0jCsuKO6ktiRFghnSFiHOGvmPee+sN09YHq1VFkdCr/YS1UgDwPx8SglwdI9
 YI8UNtLOeTb3P+WbJqIZf5bk9686/IAcmzz+3/sWT2Ko1KlxTDJFc2QNIm5B5sF7KgmD
 x2cec9smHRdaOqnq8rH4zAUcEobSX3fbceayVyd+HFTnCP6oK04hYq8YsxlZVovVORS2
 +i4lDSGtHvqmtHrr0Itsiic4M7iCK525rAsGAYfTLyk941g6d5te1pl4EeZI+Ck4drd6
 Imeo7tKXxusjDs+ARb6ll+ey2RpBYgTsyt8iIT25hnXV6Fm4dy8x9Rlp8+txXwCJ6ef2
 bitw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763735803; x=1764340603;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uZ34Ll4B2WaAx8rmMMx9Oqf8XXY7JvGifYLy/eSWiUA=;
 b=QbOJJLu0sXjD07mYn52uwK81Y5p+J5UN4Yrp3OHzBiLT+BkwiShF49lNUcvnSWKN43
 PLRXqC0/SS/wjptInqoMUVZWNC/wy19P+EHK+xH5J5sOMaKgNNtZVJ8yg2Yi2zsLTwh/
 aGVK3FRIGC/L6+gLyW6lRT2U/pwWYW1Iin7Tkv3rQjt8a14heFpVUt050hH/id2tFUz4
 kV9ANXm5jl1lE0CcEj5IX5o/UP6oKs4+4npgxNTrnzNRqEtStmq14080fdpkPyPwyT47
 3W/f/3tDBotTIVN4iGUrsgiIfpQyDqnvZqAMrYT34FG/jYETv53UwKPbix/jBmRDgUNn
 Xz6Q==
X-Gm-Message-State: AOJu0YwNRL/QsapyuzCTKQSeTZmUxumo3YimQQPYk43AnmhSZA0AQs02
 6ieoFKCtgw8KeaVNFhAKJjr6nZ7MlThk7MLvfGxFyu3kF5vDfYyxenGHhwn6Gzs6iWHErgo6ffi
 cmfCO
X-Gm-Gg: ASbGncsRf5tTbfBZ+b1zWoVcvfR28VhFIH5sAcIhOBdA3jUNzDoh8r8x4BPHTfoVyTC
 iRq310ixM6nvKe+FXTO3td31nE1OrCp2x4YXqMczUwuDzYrdjPnCk4aFI5IUiQZ5Aa7em1Ir8Pu
 acbK5lsjRYfInjJ1D6mLOmx7MKnC1ipAJ8VgHd8BuwkT0SKIcXrEsRolzvrCLnvZsjZYm6UpW2N
 3ib/GdeIbwx3Qk5XlzYgtVqWDQVWDdsh69IaFLOAYAH+evTm3ccfhuyEjgKDdnZFVGf+28bpmQu
 ySdwVX14/V/jF7R10Hqx9gtVQZL1YmQHAJjKTuwnEe4MzfqtjcvhfJyInA4oK6GjQJW7mJyg4o9
 8qgVIMyW1xKqBuu8/dC4ou4y4X5pWm24g/jua8JTXYzvqlAVdRuXwMQA+Rp/5efA01xD0e32qag
 CscEq4vC+jPTOXeg==
X-Google-Smtp-Source: AGHT+IFnzu6Z/ClO5L0F/016bsmGn6PQHqJgrYKzMpq4d/fOuAY2EpaZWZ2aiPOQGBESpPXgjF8a3Q==
X-Received: by 2002:a05:6871:5b0f:b0:3ec:48ba:8f3e with SMTP id
 586e51a60fabf-3ecbe5cf001mr958530fac.49.1763735802947; 
 Fri, 21 Nov 2025 06:36:42 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d761:af7:26f5:f16e])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ec9dc2171csm2730064fac.10.2025.11.21.06.36.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 06:36:41 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/2] a few test.py improvements
Date: Fri, 21 Nov 2025 08:36:13 -0600
Message-Id: <20251121-a-few-test-py-improvements-v1-0-bacb4148fb0d@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN14IGkC/x3MMQ6DMAwF0Ksgz7WEUzHAVRBDQn9aD4Qojmgrx
 N0bdXzLO8lQFEZTd1LBoaZ7apBbR+vLpydYH83kejeIOGHPEW+usMr5y7rlsh/YkKpxGCX4ENc
 7+oFakAuifv75vFzXDy9MnxBsAAAA
X-Change-ID: 20251121-a-few-test-py-improvements-b91babfc3e05
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=561; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=ReI/6T8VdWmMQYDubjo4Kmj6SFCwDi3r/nrJBpHscUo=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpIHjh6ynMc8LMuXySXOUk87NfqBxG1bLDkmAWd
 zmNi7p0z8OJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaSB44RYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ABVUH/2sjKrM3HoZOUmuwofKLIrm+lXUVj9a+4vX9o1W
 TMQRRTTF7nTtPTGvIchSdK1dLbBOlyOrSzSzVF5J43exvnf4FI2YzwX2irxRWsNhJYDEcJvzY4R
 ck9iaUJUZewg77YYK4tQXh++focT7yV7MdBgpTveUozkKwl9716dR86737CDlKXn62piUCrlEUA
 GCXkx0rxkd6/sf3DLJaKaPsTix4zB9LA8mcnvRwzqCTCdje4h5rtlzjUr6bkc4Ucxl1i6aBHHBh
 4hyrA5K7BwkGphMWXjU+n325mcJ7fND+4xTGBHVB3rXrqWbsHj1hpk51hZZD09ykNmU5RoGbrn+
 JLXQ=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Fri, 21 Nov 2025 17:59:15 +0100
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

While trying to run the test suite for the first time, I encountered a
few minor issues. Here are a few patches to address them.

---
David Lechner (2):
      test/py/requirements.txt: add setuptools
      test.py: check ubconfig exists before using it

 test/py/conftest.py      | 2 +-
 test/py/requirements.txt | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)
---
base-commit: 2bc0715b558fa1ac5c88b11e250740b16a905837
change-id: 20251121-a-few-test-py-improvements-b91babfc3e05

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

