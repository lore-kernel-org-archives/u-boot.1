Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC38C48BC3
	for <u-boot@archiver.kernel.org>; Wed, 14 Feb 2024 17:18:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F3708718A;
	Wed, 14 Feb 2024 18:17:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ClHwIxmf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A09A587DB9; Wed, 14 Feb 2024 18:17:56 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEF078796B
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 18:17:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-411de7c6b3dso9111995e9.3
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 09:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707931065; x=1708535865; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3JZUIxrGm5UANZb/t1mh+nQ3a6lqeplTEALK7eUMZH0=;
 b=ClHwIxmfLFu0wPvCbMT0umM7JrYYnQ6jUPWK+CjzI7qV4+i/BzDN67wFY2vabc7Bqj
 Huw9bfFubWYnDB58xmxvlrALfV7yEG7sxRYfyY1GnTpqRVy8015i0wcgQLPdBe3/5Qqx
 eJnQKloars2nIvNbTYjS7VYReol5tcf2jwPe5X/dt8yio3x7HyWShcFIDdtmvpYDspXr
 723gMjJH8l6QyuwJqgZsn6ErMKnZK/Bzkf2SVbYsEIhEXGhd4OV/xTu5ZxCFcubQ2kSQ
 +wXvkatwwYIg8U32XLA/afgyW6majTssBlaembupSIC93ffFIvobD+6l50L5cKavDOOy
 fpoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707931065; x=1708535865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3JZUIxrGm5UANZb/t1mh+nQ3a6lqeplTEALK7eUMZH0=;
 b=R/C+urOBpOm8EP8Vgg72eVuEO6pKhiOIEdWdeQatceJ0fpjyBKuSkHDwgWZdaYz4RJ
 tQ1MghchnRIfW4bKoAs3ZYX9mE1AC1dA04/mmb9tdIgsbaE0AswmCQeuyV1ij3DhLLAp
 NGM5jvuzOsT4gTs4r+IPxj0CFj+oaflWEcXQji087mIVwbFTtKEf5aotNH4AruHtckn/
 5/E9Elw3RuYeh30m9Mg72UvBJOrcytjI0sumlym+fhC6zMG3Zp8WZvFWoWPwzVoVLCQe
 GjWVdZHdFNK8mRuPuDLKJesOsscD0LNWecIAAPSEtBuBMtHxrZq7n2UC68YUmObSKncM
 XjtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmC9pvPE29Us+G8fzZBzGa8Vy9dw2hKDaScaeoKlSDNzyPaoNbCwMM5Wmrcpm8p9Ogs14OGxmLthqhRjzFsyXAiaIfBQ==
X-Gm-Message-State: AOJu0YzBisYY2Hg2rtdM4xwo39cP8nSmTLZtEeonRoDQ9hlcygV0/ko3
 +UZ4w/QxZyfczNz5ntQuBsVRGOux77Xg0qQi6me4lqKjCf4gOEfXW+Xvswevm68=
X-Google-Smtp-Source: AGHT+IHPovz30kTtKBHKdBBvYNagwrL2w4HHP2O5E1QHpRGbqlSk2ysWuJ5MPJBpiutaE++lStZ+iQ==
X-Received: by 2002:a05:600c:3ba8:b0:40f:e60f:438e with SMTP id
 n40-20020a05600c3ba800b0040fe60f438emr2824486wms.8.1707931064960; 
 Wed, 14 Feb 2024 09:17:44 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVHLcC/Bbkl19VKoJ3gV2gDzjWZViQfQIkm7nrWGahH2B3TtS661ZBWrl8mqGosOsj457cqHRykvi3Feno/28BlrXl7ucwe4iIsI1zHximFPCvAiJFCFB53Vd/0d/lAoW7sOVNOfbF11zcRuHK0uwytNr6detiVUzhqnFTo93C07HL4aqnE82Cli3rJbdIlORb+rSpH6MOo6c7+ZRQ=
Received: from lion.caleb.rex.connolly.tech (host-92-17-96-232.as13285.net.
 [92.17.96.232]) by smtp.gmail.com with ESMTPSA id
 fc10-20020a05600c524a00b00411e1782d33sm2538149wmb.23.2024.02.14.09.17.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 09:17:44 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] button: qcom-pmic: fix some error checking
Date: Wed, 14 Feb 2024 17:17:28 +0000
Message-ID: <170793103298.4095603.7903662755965755863.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <12e63b80-3c65-494c-94b4-bfd949232ef7@moroto.mountain>
References: <12e63b80-3c65-494c-94b4-bfd949232ef7@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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


On Wed, 31 Jan 2024 10:09:15 +0300, Dan Carpenter wrote:
> The pmic_reg_read() function can return errors.  Add a check for that.
> 
> 

Applied, thanks!

[1/1] button: qcom-pmic: fix some error checking
      commit: 6b929e9f3c16bbddeffb85351e93db13eaa9b57d

Best regards,
-- 
// Caleb (they/them)

