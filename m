Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B6FCCD194
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 15:53:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EDD683303;
	Wed, 15 Oct 2025 17:53:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VtGvJQxH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 800E9833F6; Wed, 15 Oct 2025 17:53:22 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31B848323A
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 17:53:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e42fa08e4so54407895e9.3
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 08:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760543599; x=1761148399; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z0BQwgEF4XEtOTudZDkMK+bOpDJJTZkii24fJS7o10s=;
 b=VtGvJQxH/Oh6jmb0UeQOli1J6Jb0sqjigvtILmka4BkM9YVy8EU95z+QhEL2Ybui6+
 1rIvGsl4SK9wp0l8YFJZvOXarL8rkfIrzDjsZ5vQsVBgZDzA0tM2F8M0AFUiXggb5fvl
 7FcgPHAgAPs+pQjFL4hT2ZFzdqZBUbRCL/ApbmT8j5xodmvnhExVLJWPwMXo1kAtcVhA
 fK81HkUkoS2FYfrtU8JXY6VQ3+M5cL0EKKJEE/zNPQnhWgkYW9howhJZWirg01NOv8TI
 3JK0b3SS5dR+uv+kVHGtu0qQ91LZsa3LVmAQ/ChpSpMN78Br+sQIPracfD9I2SEVGXuS
 aoCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760543599; x=1761148399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z0BQwgEF4XEtOTudZDkMK+bOpDJJTZkii24fJS7o10s=;
 b=YHn0cT908YLdRiTEariPYDQoomQh2Mu3WWIEMmnpJZX+kbMgb4n8kDHWvgZb9FynJL
 DUCBE6HoQXqEvO+0SLAcGcah27CmDR816rE65Jt/FeE0xc1CnYB76OtZeYKzESXvXils
 A3ZMqWxhjnBcOMFxdHZzLHoArK6ft1/DXtlZhWHXxKMzD4EsIrMHKL8wyDrzVT2LaCnU
 liGSiyWMxImwSWf7ntcj2kFVSMtFzNms8bBn0WHE5AgRdb7cSI3hZnCA6hVle94Txi9X
 1s1lfM4f/U0pJqioYk4GbpAZFspKFTOhEKUZ5l8rdmLhMDQeGAI+tFblhvFwcg0RzapE
 1Qvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWD4A0h+jI25wbuNFTD+uCxm9H2zrKcFecAlKg3Fn2sioT0adMmwX8FNTou/oacPqNRbjP2u98=@lists.denx.de
X-Gm-Message-State: AOJu0YyoCYyehStOYhxu8/MMKUWLuBDTANpjCwX2QDTZuV5Q+J/oU0Y5
 xyWvTZrZnwcxXP1rj0ACxwTVqySK7AgSZmCptgf37WkyIGJpYajLUZTCsNYL+lHZ6Ph2/SsIJ//
 6DM59f2s=
X-Gm-Gg: ASbGncuDMYDobvqSfH9DtD/ry/5vtfVz7TLrlSMVTh0UmE+m6bdeQc2MHdA54cWcFAo
 05AHyH1zHGg6ZRz/cz3Wy6GPt0Jkj0hpa8WbcJPn9BHJVEPHn2ZVpZGfgPIdkDW4bbgJ6dlcllu
 wJBUYGMkO7WCIrLQHGU39mw80MKfebcKlXNUeFU/LzhvvoRbqizISXP+2eKJNR2spK9/RsEtv1e
 PuFUS8bGpZJJUuIpCwf17nRqiHw1cj0K8Mh66M+ma5AOTUZPIe95e/0UFMRU76pEVe/zxGcSKW7
 STcgmKW8UC6G6zCA4lJ2DBYahiTWnJ8Cvmjk9Hmbezc+xvLwwRzRDqrK46rmB+FINc6ybOlISDA
 b8SvyEiRfySITG2yPxuBWl/weGw5u0kWsbIz3VV1Irw8mb0xW5GoQ2wgbfuV1FQvwfsFPvUnjF0
 w=
X-Google-Smtp-Source: AGHT+IHLmhBXlh6tQZ3Ju3fKFTfdJ6ZrGdYg/tZn9IeNaurHxdFztmesRHBLHmj5yDgztabg0i2jUg==
X-Received: by 2002:a05:600c:3d87:b0:45b:7d77:b592 with SMTP id
 5b1f17b1804b1-46fa9a9ede8mr206265015e9.12.1760543599574; 
 Wed, 15 Oct 2025 08:53:19 -0700 (PDT)
Received: from artemis2.broadband ([2a0a:ef40:fed:4601:4b30:fdb5:8c7d:59b5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e0a03sm30106894f8f.37.2025.10.15.08.53.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 08:53:18 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
To: andrew.goodbody@linaro.org
Cc: msuchanek@suse.de, quentin.schulz@cherry.de, trini@konsulko.com,
 u-boot@lists.denx.de
Subject: Re: Seeking advice on API return type inconsistency
Date: Wed, 15 Oct 2025 16:53:18 +0100
Message-ID: <20251015155318.20628-1-andrew.goodbody@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <50055473-7684-4a61-bce2-c61f19d754cb@linaro.org>
References: <50055473-7684-4a61-bce2-c61f19d754cb@linaro.org>
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

That 1st series ended up in list moderation as there were too many on the Cc: list.

Can someone release it please?

Andrew
