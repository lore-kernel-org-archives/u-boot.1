Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D996C83F1A
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 19:46:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1015F83423;
	Tue, 22 Jul 2025 21:46:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PzuvxMqY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DA0883414; Tue, 22 Jul 2025 21:46:10 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A6DF833F8
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 21:46:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-72c09f8369cso2178543a34.3
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 12:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753213567; x=1753818367; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CECJlNRfZX+j2W8fyErJwVQhwkPufQLzE1JNXjsB/g4=;
 b=PzuvxMqY4erlI08V7tvDB3SSygcPnV38/nV7gJidK6kLbd6Ew9brhPXFKiOLN0VvIO
 E4WyaueRyStPFKB+N1N2fh4nxpWVQOAe4w/NavfSkMvEmDui394/mokKvAMx4ztrk0IZ
 eEzn07ViEg44M4G11ATxMHXvcr1nfHMh6mnCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753213567; x=1753818367;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CECJlNRfZX+j2W8fyErJwVQhwkPufQLzE1JNXjsB/g4=;
 b=qKZSWe4HtUDxb5hi8c2LnR/5RoDpkvHj3VolnoYiwNMgujYCX1w7KitEVtwd8fjSvK
 WPXGpDB/8KWqZ/zY0NPHTMpSVm/o0G2F3ztBAwTnl1GGDBY+SjWK6ibL6HO+MPmOlpeY
 Ol6WtW8IPiwI7e2QybnfPNHKvod22CAGOKhWFaqEUs21+uyWpW/30bwF/fDRxLb3EmVY
 5NQZCIQutRt64i4RlSFDxkcWDwouK6lGpF3fTF4jPHAq3z68Nnz8RmqcPHEmzNOY9k+6
 ehxu/TD3WrVqIzhlmqJFUA/49+trPdV6E11okgABOG8GqkYU+8qHhz4cD14dPWgC64Gj
 DIKw==
X-Gm-Message-State: AOJu0YxD5JDi9FFvZGUI30BmuunJ4HhzVkpPjoCHgRKHQQEikR7oH2bv
 iObjd0lMgZQsooG5MUTMIDgoQpLLrcygTSODrXcopTldVkbMsz5iwqh1Wgp8D6cRrxM=
X-Gm-Gg: ASbGncsw16jk/Mv85hlU/SadQXe05R55c2jsTKFIyP9UppXOPfhBrHEAKbJ6sJ2gAFj
 FYPI9QqTy/bVEncZ8+HR3wgBJR7I0RdqwKL24e2XV9usoLEkIVUZ+s3GYMQZtZqGwwTZaSlKN4b
 eMRvIPlh9t5J9k1J0E2X06tgKgAShfQoB3XHf83ZN4icf/rbUelOP4RhvzWXiPZKSUBzfFF0jwl
 /Bdvsv2hK+evDY4LlZ4kFMFu+ZOTve7wtk+XhGqEiY95ClzBtCpB0LeSN4xDvddsHfJPMn20WPV
 zMgvAqxpJkfQWsMgNd332k2dRQI/xW1UykCm233OnvbX34E7ITlV/J5dq678+trIhswQw/sLOu0
 f6qqthEs+7GOmGHw064MC9csglBaBWpdk2NuM1B0+GMwZVMpbb1s3Svo=
X-Google-Smtp-Source: AGHT+IG9cX1pQXF3x7xUksMkW2V8H3A1M4IKtzUuWthvfr2alj9FQmLJZiXD6SzJZ1TKGiy58dkolA==
X-Received: by 2002:a05:6830:348e:b0:73e:b9a3:699f with SMTP id
 46e09a7af769-74080520e87mr342881a34.6.1753213567091; 
 Tue, 22 Jul 2025 12:46:07 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73e83b0c3fbsm3749811a34.30.2025.07.22.12.46.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 12:46:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Francesco Dolcini <francesco@dolcini.it>
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@gmail.com>
In-Reply-To: <20250714084416.25920-1-francesco@dolcini.it>
References: <20250714084416.25920-1-francesco@dolcini.it>
Subject: Re: [PATCH v1] board: toradex: Fix variant (wifi/non-wifi) selection
Message-Id: <175321356625.77222.9894739725450122473.b4-ty@konsulko.com>
Date: Tue, 22 Jul 2025 13:46:06 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Mon, 14 Jul 2025 10:44:16 +0200, Francesco Dolcini wrote:

> Do not dereference NULL, when "variant" env variable is not present.
> 
> 

Applied to u-boot/master, thanks!

[1/1] board: toradex: Fix variant (wifi/non-wifi) selection
      commit: 50ef42c94858b3fa60f88ce56b767c721955804c
-- 
Tom


