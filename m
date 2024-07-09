Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82DEFC2BD09
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 09:35:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC775885D4;
	Tue,  9 Jul 2024 11:34:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="l9tizOiQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEEAC87EBD; Tue,  9 Jul 2024 11:34:49 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D008888578
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 11:34:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a77c349bb81so426873566b.3
 for <u-boot@lists.denx.de>; Tue, 09 Jul 2024 02:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720517687; x=1721122487; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=r+mcYWt8+sQhaIBkehXrTtA0QTsl4oUPVhmedUpfBHU=;
 b=l9tizOiQtWOo9A7HqrirGYiWs8VtM6RSycFe7vWsSTOIeYzbuQ3pUZz888iSbyE4tX
 tHAUxK/XQcBef4Xqzh2sEF6PxNu7mJzzVPHxU0yj8nVJFcFxjSP4Ll4qzXoQf/jshAIW
 yV+QZSb3MteMmt0dazMsOt1SvPjrUavjweDjgCYY3p+7AmC+gC34xR47eWAPU9fsGP6e
 8DxwA1OTq9jDID3naPIyu3Q/8q/B+j2/tf1BrCcpqXYJsuE8NxX4awnb7Ed5GayCPF6E
 KUnePdeDbsXFS8F7yuLpIo1YWxK9/jhBuS/GpEJ0EXnZS2HoNKFyL97x4FjYot9YoMz/
 Qzdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720517687; x=1721122487;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r+mcYWt8+sQhaIBkehXrTtA0QTsl4oUPVhmedUpfBHU=;
 b=ce9EI84JuCv9FRFyYxo9b4/IRXwagrIm12ZMAr9+m5uT+zWLfnA6HHsr9EzBNW3Xfd
 kA8OZhNaJqxsJkMPzvEqQMMMZt1qaZIOLxjhKcxyBL3TwPDlfPPoRNJD5CVN1+eqwNyH
 dzNOVEMV1VbC2KqnKgbLjdG5F0xj897A0FxfZEaFTbFModKjDc6VTKDTsBwvv5nPqrK3
 dTl4KijCLsADVjMihwurUsO+RiprrEcOCm0EuhmiiXNfVwCHGwz10A8JRlcJlkFLzfF8
 kZbnTuscJgXYDvtv5broKTO3wpmIClFwkChWx7OQZmNOLe7Zb7SB5pSvfvWnmI5ONB/v
 NZkA==
X-Gm-Message-State: AOJu0YzqC9vkiyhBzkhG5Er0JI6i/uDnaTNut5Cuv2cRuYdQVQUH+NZv
 FiATrN9sMedwkav17XmWwdTkyxwjwwqnxc8ij5y2MOB2152WoZYs2XrzjzC0OxI=
X-Google-Smtp-Source: AGHT+IHhG30Lwytta9ah97yN3Fk5K9uWSn/Ri4UVErsMmaZ5XsqYh2lI8jhaHb1dJ7h4hq8tALZVZg==
X-Received: by 2002:a17:906:6cc:b0:a77:e2b2:8f2 with SMTP id
 a640c23a62f3a-a780b89f7e7mr116300066b.75.1720517687330; 
 Tue, 09 Jul 2024 02:34:47 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::18f8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a7fefaasm62884566b.140.2024.07.09.02.34.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 02:34:46 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 09 Jul 2024 11:34:29 +0200
Subject: [PATCH v4 01/21] linux/bitmap.h: add bitmap_empty helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-b4-qcom-rpmh-v4-1-c06d0a26644a@linaro.org>
References: <20240709-b4-qcom-rpmh-v4-0-c06d0a26644a@linaro.org>
In-Reply-To: <20240709-b4-qcom-rpmh-v4-0-c06d0a26644a@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=896;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=9SNcpWhUFEwEhQbcWwVjUgqQ9v4gpyhUD3UA/F89FMY=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmjQQyNIzT6ERopp5G7NicabZoDUi6P3afuJL7m
 C2Jt/Hsrk6JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZo0EMgAKCRAFgzErGV9k
 ts3uD/9oy+mey37A3nuPuIRHwIFKuysAuuPB68ncMDVIKJZx4wdGPZxLG4L4tK4W38GVdyjGZKB
 wxmdsMyKE9U855az/svDnuouEK8mT4hplMIPtaKPtzYQc19k6JhE6O/6Ulp4sJoy95g8eOpWitg
 gL05WY+aO5cmSI+zsIBBkNS3PPVnWbTlkRLkUHAYcMaTZs4dCPMhiGPcsl3PpNY0nHYk7JoQOwr
 lkfHvorGIh7beuTl1ugRl6fPTuhDYZyRGr5Bj50DqOevmX7TJUQYkLSlpCPGOz8wGJUjrYWqToI
 eNXqi1JPQvIOqYbRJe0Famt6aKhsHCDTIPYrX2sIkP0Xan8dzzRbM9ADTAydnlmTQWagtFIi6Wq
 g6zmlaE7dabz3ik6tZhXT8PFltV62kqZR/6wr0cdAbfHmTMZ9XvSA7Egwtpp8yuqrGHHr6+OiXo
 1JomLMQlyPjrh/LhJy8CcD/7+qvRCO069lkxn/a26R2llJqv4PITp6LXeomsg/cBjDo3eiTpBKT
 k8wPpRzay+4Fakpmpo/RA1pnyj1gt6c7cpip7eV74763rdKNA6eBfYN1AD2LK47zfwtaRpfWT++
 uTe1pL0+8fcce176UHTITl12vtPiDWe0uR3fWfOVPkkwGSUI0iVBqwp9uFFMrHjA9Iboq3/95NO
 yFo+32899lpCsTA==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Import this function from Linux as of 6.10-rc6

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 include/linux/bitmap.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 0a8503af9f14..40ca2212cb40 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -195,8 +195,16 @@ static inline void bitmap_fill(unsigned long *dst, unsigned int nbits)
 		memset(dst, 0xff, len);
 	}
 }
 
+static inline bool bitmap_empty(const unsigned long *src, unsigned int nbits)
+{
+	if (small_const_nbits(nbits))
+		return !(*src & BITMAP_LAST_WORD_MASK(nbits));
+
+	return find_first_bit(src, nbits) == nbits;
+}
+
 static inline void bitmap_or(unsigned long *dst, const unsigned long *src1,
 			     const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))

-- 
2.45.2

