Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC324C87FCA
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 11:49:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 562B783A48;
	Fri,  1 Aug 2025 13:49:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="c7zwnP3v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0648983A61; Fri,  1 Aug 2025 13:49:52 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4EE883A3B
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 13:49:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4561ed868b5so11874285e9.0
 for <u-boot@lists.denx.de>; Fri, 01 Aug 2025 04:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754048989; x=1754653789; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=X71q8BpCsBVmFUMa5Rve6V8vVBax6wp4pywqer/2wo8=;
 b=c7zwnP3vnJnVrJceK/HGcHkWCGvcjsjSoNwZF0SRmitK9U9QvPbNc4cPlFqVvUj4e2
 KV5faGSUXLcv5x578YnA+9RCbobp/ddGr1Hsbh8KPEtEuDL8exYsW48MWiu0B951RvOD
 W98NYdJXRzVFum4eBrJaWccncFs2FxJnZPQ3tFLjNj8/WIEaV8jXMQTL7FkOc8Isf3z9
 AUo5tCT1dOT+KCmgWlXTQQ5zH/WYko1sLHspqg1bYovf0Cz0VbLNzbqw9KADLy5KC5J3
 NzUSmDRAL8yAvTP5coqusCnYJoF5MSldXEEaBZV43jqO64tQPx+tIKK5w8+wtagmDBr2
 w8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754048989; x=1754653789;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X71q8BpCsBVmFUMa5Rve6V8vVBax6wp4pywqer/2wo8=;
 b=i9omfqvkZoBEoG/O2Zqplr4kVjiUVkhrlfThfhZg+cF7tUoWV+/uw7jlJEp3Bar61a
 Vsc88fMhSDKW+/u9rbvoCyQwebnshBpMlXTxBEwpIk9SGVEFxdGPCh1aq14/MC4Jeugs
 si68ojXu9sf5VdRVBJDIs7bTCZYTRce/jyhAF1BC9EM7DqDiqxCItg5RQYhsVSYOWgTV
 QvpL8abB6oLEXMgMJfsCerrLSemuNze6NlB1hlLOICtKW2LtbblKbGqPnN7bSF7dVL1h
 maYlavTlgju8DoWdDgdOFCm9p90Q53NH7ENK3uEkwAamcFnDxzATGPRoBfegc4ZjW92G
 JJhw==
X-Gm-Message-State: AOJu0YzmxV+QCYuuJniCVj2mTYH5kSVwcc63hn047GFFcypTlvEo9Bzj
 hK18yUlZ3VT3/pMD6xWUk2evEoeV9RGzfic6x6l/VToVc8rqGFmmIjUBP0un2QIWUww=
X-Gm-Gg: ASbGncsVaWXY7UPWmfrOqXpsre+UQaOj0f6a8607aMgBXbc8kJvCGaudMhWJQ5BIGve
 eMdBKE17MvUaZ0GFq1avUFYNDwsr1vskmOVN+dNtDZwmnbKB7RI510X6WuXYFM8vFjnmjVSdO5F
 luD12zpOtjnsbtefhBwZ0d+IaGnKynG25l8qjL3DumPdifj4yeRXPEq875Y2gKurn3I8y/Pl+ZA
 PNzsCi6Z1nv8HKhebRWCWnRWlfrEKyZrv1GBlKNsSHN0daBWJQ/pM2xbh3ZekPqr5p39CwO6mxT
 M0/EBBG0vLtRDTfQSWtNLG3nIpa+rYsRPmwnYaMUDgdVoDaK/iGL4njLyke8gbcQFTtFMKawFVv
 PlGYslqB9GrM5xYJ6azqG6NoDVFeJKI3dJB8ZwlG6MEuu1Yn5IBE=
X-Google-Smtp-Source: AGHT+IFq58+rE6SjIyQrjO2nHp2C5JESjSvum3JhU39I1YVnkiEICuCqSGmo98seg97uH3YHA10XyQ==
X-Received: by 2002:a05:600c:c4a2:b0:450:ceb2:67dd with SMTP id
 5b1f17b1804b1-458aa4636cdmr18046775e9.33.1754048989188; 
 Fri, 01 Aug 2025 04:49:49 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:cc6e:5422:ab75:92e8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458953cfeaesm109631565e9.16.2025.08.01.04.49.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 04:49:48 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Fri, 01 Aug 2025 12:49:48 +0100
Subject: [PATCH] mtd: ubi: Remove test that always fails
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-mtd_ubi-v1-1-496e6ff7d287@linaro.org>
X-B4-Tracking: v=1; b=H4sIANupjGgC/x2NzQqDMBAGX0X2bCD+VLSvIiJJ/Fr3YCy7tgjiu
 xt7HGZgDlIIQ+mZHST4sfIaExR5RmF28Q3DU2IqbfmwrS3Msk3j17PpgNDUTRXq1lOqvVMYLy6
 G+e4XpxvkFh/Bi/f/oh/O8wJYCDPlcgAAAA==
To: Kyungmin Park <kmpark@infradead.org>, Heiko Schocher <hs@denx.de>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

When checking the VID header of a static volume there is an early test
for data_size == 0 so testing for that condition again is guaranteed to
fail. Just remove this piece of code.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/mtd/ubi/io.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/mtd/ubi/io.c b/drivers/mtd/ubi/io.c
index 45699b4a477..2ec968c85ff 100644
--- a/drivers/mtd/ubi/io.c
+++ b/drivers/mtd/ubi/io.c
@@ -936,12 +936,7 @@ static int validate_vid_hdr(const struct ubi_device *ubi,
 				ubi_err(ubi, "bad data_size");
 				goto bad;
 			}
-		} else if (lnum == used_ebs - 1) {
-			if (data_size == 0) {
-				ubi_err(ubi, "bad data_size at last LEB");
-				goto bad;
-			}
-		} else {
+		} else if (lnum != used_ebs - 1) {
 			ubi_err(ubi, "too high lnum");
 			goto bad;
 		}

---
base-commit: f5e968a28e7cdc2c4365f5a382e02f074ee03fac
change-id: 20250801-mtd_ubi-9eec6463c48b

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

