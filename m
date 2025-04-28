Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF6AC369DC
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 21:34:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CAB88219D;
	Mon, 28 Apr 2025 23:34:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kVRr9eB1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B14D6826AA; Mon, 28 Apr 2025 23:34:05 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D8B082161
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 23:34:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-72c173211feso1399574a34.1
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 14:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745876042; x=1746480842; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O3u+CYQX9DZh2k1qvmvRmj3Yc+2qQdyZtcT6YJsuB1I=;
 b=kVRr9eB1gKL3qWOcTU/wXNqwfh8L+h/eFL3we4Cse+7arnvjvKYAinfW0z9Xaq2CuX
 e218jxzCKFmzNEwzW30q63Tkzgpb/r4n7cO+qZ4t/Mo5HgnmbpMOHBtbbHm7UEAOpjWw
 hewMrgXO49VqkCqENPQr8Sr+j7wZadTbKoKqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745876042; x=1746480842;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O3u+CYQX9DZh2k1qvmvRmj3Yc+2qQdyZtcT6YJsuB1I=;
 b=maAkj4NbeNx8Q4dzcQ7I8kOC3wzJ7vNGOiZOCIMth8gDqBpuZPAyyTc3a9HA9JFuwb
 AO6myVXFVtrCM1PdHF1k6+8PQwQX1I6JzPl+tWRksiEV/mcTVVGzKn3jBYc71haqPLYw
 VtaH4gJsK/A3/WcujM/5S35MECXz1vHr9iPvGU9COD9YLRsVtmnRf9TVnd5ffHdhSSQ8
 H0I3LNceelNoTq6JFj7usqssoJnfIvx0DDWKkyUSAmTe9MHZswJAAX4BtfckTX2LJYRT
 CAa1g2dHGoc+J0rGdubvM7n5/EqkaBTL6buYuTfG9kJazX0QpsOkYVw8tdR0kwHu9k5T
 2N8A==
X-Gm-Message-State: AOJu0YxmiZmOZbprOMCiTneMtsvQ7M5ZW9d4H9f88B+DnMOZpC0GYgKH
 PXlkbIof7oPQBKYvfOvSv2DPu4LJ9+UOlhn5NrA8QMlgisZyfnshAHTe/PCeK04eA4HbX9kQauk
 o
X-Gm-Gg: ASbGnctzvUdQpN5ZST/oqbI5WGVk83w40h4w+4I5BObSVl95VpxXbIMhFdgIb8yf/Ls
 UC1oOhapgK70S4ykQw9xUkzT/Geyt/RhMOtogHQ67fKyU6eDGY9O4GlRXYnLemEoJBBA2aR87dx
 A11EOL5e+3MvTdlseDsLV348OX+V9uFYA/raykD06H2I7kW8+FH4Q+aHqpddFBLrT/fowY30iVV
 vVP5H16dQGpXcU+ikb5taKu9QuuMC4csMeMFjftc0eoOUs2nXumekT8AkM18OQTf5AEJlWA9QnK
 dlgRHc75C362L2qI9PzyTOHy4bXzGwpF/VeZCr4APF5nmJwXoSPVNmwNXATcW4kvvrVICfYT/G1
 9
X-Google-Smtp-Source: AGHT+IGDPDAklsz9XUREZdSxtHv9Ns3S/xNsqlMMZxxCFbzTB1VZsaHnbcuIUdOdGISOBkN9Ks7uXw==
X-Received: by 2002:a05:6830:6817:b0:72b:9724:6a82 with SMTP id
 46e09a7af769-7306523084cmr6596278a34.17.1745876042277; 
 Mon, 28 Apr 2025 14:34:02 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b139000sm3108a34.40.2025.04.28.14.34.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 14:34:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20250423113123.888700-1-sughosh.ganu@linaro.org>
References: <20250423113123.888700-1-sughosh.ganu@linaro.org>
Subject: Re: [PATCH] lmb: use a different bit position for LMB_NOMAP
Message-Id: <174587604149.1121500.14501976516955187223.b4-ty@konsulko.com>
Date: Mon, 28 Apr 2025 15:34:01 -0600
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

On Wed, 23 Apr 2025 17:01:23 +0530, Sughosh Ganu wrote:

> The LMB memory region attributes flags are used to specify the
> behaviour of the memory regions with respect to allocations -- for
> e.g. it is allowed to re-allocate a memory region already reserved
> with the LMB_NONE flag. The flags use values with different bit
> positions through the BIT() macro. Move the LMB_NOMAP value to bit
> position 1, and also move the other flags accordingly. Using bit
> position 0 for LMB_NOMAP results in the logic in
> lmb_print_region_flags() to break, which prints an incorrect value for
> the regions with LMB_NOMAP atribute.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] lmb: use a different bit position for LMB_NOMAP
      commit: 23e7088dde1a182bbc6b75bc642ee789f23429b2
-- 
Tom


