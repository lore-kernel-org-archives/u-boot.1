Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379CBC36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 22:59:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B498C81FC8;
	Wed,  2 Apr 2025 00:58:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZFAONh4X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F30D81F69; Wed,  2 Apr 2025 00:58:58 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F18C80584
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 00:58:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-72c1818c394so3566875a34.2
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 15:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743548334; x=1744153134; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=IM+zqVCUhG6N7kUYyw2uPxriS2rsoD53CczxbDvXT1g=;
 b=ZFAONh4X/ET7K4h9h3ksArUjnVo7buHMAsgIC1pGneZW+nX/I74mtkN3vC/OqR6iDs
 yVP5QdH7IEaM5I2XBYcqrGrcU0rQ8wHqqJCQHuvsPaPhGbJRHiwk9LA34ECaDbHbc9Pt
 CDpKWpa/yVwitjwccjdEXtMG1k/lS2Q7EeXj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743548334; x=1744153134;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IM+zqVCUhG6N7kUYyw2uPxriS2rsoD53CczxbDvXT1g=;
 b=bqkdMticM7bRGuARjx/IigkG+lFGz+aRNPaEj9WjmJXtSe18bGuoh5o/rIClRSynTZ
 UnXYmF/V4Ki9ev89ZKGWTQ6HnZRPTjEsohgAG8l0LPZjEyzvZd9+YIk73ZE6lq+4MhNd
 WyJ/MfEBo8JEoUUUHU6a6JHfzEruveOCG4aZ6QxZyzbqZ3W6ysvU2hL+EDlbOROHSIKt
 REO2Z7IkwMjiQcZj+PdnCPvQ9J/XDpjQ6f0++/Tjpi6R+Q8oMoGpakYAPv+BROFiqoQE
 1k31rVv6IsD9SzQc04keIlkw5N1CxQn/nMv2incN8xr1na7uQnENRM5TSGRdZuK4K3Qb
 TW6w==
X-Gm-Message-State: AOJu0YxzX5aArmsO/FuLhdoCWgZ3xNHRP9vSoak2NalAul45UYHqtSh6
 fV55R5HfLdZl/FAJ99i+ih4YyVastljUK4h56IRpFMnBGqp6ByeAdk6NZj2Dc/B/z1ehg2NyTrS
 Z
X-Gm-Gg: ASbGncul0YughdgTBBE9/kPdojqZ209QvYELL7AGdf9Q6bQJm28R/urcAmA1QWxYqAz
 lHO0iiEtFpoArEHPIHMYi91KfnxJW7e9NnLD3qHE45rnrndAGfAO79DYRbfMnjBkTaRzqHdmYk9
 9SfMrEsQkep0G8+IYDSMmJQpx1MyEj77w043iU3l3g4JKt70Oy7iQvmRJv9Bj/tiS7Zx8/CAhui
 7e8xuYZfV4FUlUkXJp3z3MEd7+OnagI17qaWEk115vMyvEB2FhMVFi/oDJh7MmQnOeNuhi5glMc
 O7QoUzVqQjgWhp+kcBjbqwWjaqXliFdOQ/moiZLX0jzuitoD85N4kDtw4dQOWRuPoqgDt95h3Gf
 FKK2qgvmH8HTZaf5rsS4=
X-Google-Smtp-Source: AGHT+IFc3dzOHxYDJQXv7p2YPdOCwB7fEQIRkXxO2GYenF+eC/LgQKM74cRt7ja1mGIfxP7TPd7H3g==
X-Received: by 2002:a05:6870:e311:b0:2b8:3e6b:605 with SMTP id
 586e51a60fabf-2cc60b82307mr171753fac.20.1743548334706; 
 Tue, 01 Apr 2025 15:58:54 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2c86a3f3e52sm2528791fac.6.2025.04.01.15.58.53
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 15:58:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH v3 0/0] Switch to using $(PHASE_) in Makefiles
Date: Tue,  1 Apr 2025 16:55:22 -0600
Message-ID: <20250401225851.1125678-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Hey all,

This series switches to always using $(PHASE_) in Makefiles when
building rather than $(PHASE_) or $(XPL_). It also starts on documenting
this part of the build, but as a follow-up we need to rename
doc/develop/spl.rst and expand on explaining things a bit.

-- 
Tom

