Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4DA606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 21:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IZM41Rns;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=mRU6jU6I
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5D5A26064A;
	Wed, 18 Nov 2026 21:44:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k9LQQLrKxk32; Wed, 18 Nov 2026 21:44:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AC31B60733
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795038254;
	b=JgCWxx9HWRrA/KH+6yCKevyPwETlVWU5UKvVS4Fsjaw2VS/d0GvbL9DoFuYIjX/rfkXv
	 vcfbbZhJ56lTo2PTl4z6bwSoz/Dy3X3dRHDa34Acis/NuQzTC6AK8w21D04TWjl4J6C+C
	 RNRURpuNpyOwX90hJcAcsMG0WoWaEHnyO7zpjBs05kGeIPil2yvMc0ONC3cMUXkoZCbLQ
	 8EKY47FeMbGLAa7R8ZLyYly2PoJlnEwTp51z/HgnPDUNAamvlA8vRi7yH4DM6/ZliyICz
	 tM2zxjyL4E2mj1Z/G+gWuhCGGPdxEGtIfywak0i07A5dmincLpc+/sy+CZQHL1Lr8vA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795038254;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=dlKFnhZA1H6mNUgErYifZxme1zb2N98MmEMpKJEnbE4=;
	b=de7HPSjX3itIWkNeF4/ALco8q8rvzzNgvLy98Ujn6mPbyZtXYPVOOiug5gizQLp7gZXW
	 xYdYrHJsYF85khEO94huasZ/VeVvblWCiZAbPUqk8TEuBlx4Z7qVtoNsdlF26J58yj8E4
	 Z9tVkG31FJm3sFmoFoD6GVonQr+tEtUUW9AP1YF1/g3Z6dBcbwaFd38K+dCfcmApBl4LR
	 OrD5uGzsUNzPcROpmUYZb45nFnxlMMLMy2eMAwsV6znXie7jeNNwmW6VPzvKBFPIHGtyY
	 yRXrvoknR/mK7eqIRL4DnQeQ7Zs06sF3zQAWi0XMEBVzSa81GDB3yHYQbj/5r+0o2sg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=mRU6jU6I;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795038254;
	bh=dlKFnhZA1H6mNUgErYifZxme1zb2N98MmEMpKJEnbE4=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IZM41RnsTxo0MpIruiOEhTO1k+Jl7XgyZluPcvfVgp8AatVSKLz1+S9CGA1Idyj3v
	 YfCFtlE1rZ6Ecb0CK2R4ulztlu9HF5OubuPNIeVuwZTM1Brf7QEePu5323QjgtWa0s
	 OHnvmewnUO7mGlUl7oQVQgberKud6QnJWo6LMQrtfzR65Vqz8s9B+f4L9rjlJqRIw1
	 yEUXFPcoy8nAQHh654ZVFtkGh4wlGAT+ULEXXrAp/Sp/oSp+a2TnBflLZbU4x5DD//
	 cW79aQkILPrsL/93zKZCu+gPKzFrYYgmrt4y54n9ewsu+st59ft2bWuGzDVqvErZKv
	 zRwI+u1I+vh2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AC31B60733;
	Wed, 18 Nov 2026 21:44:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4FD899F8
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 21:44:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 36F0F60A94
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 21:44:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZBL3_ZI3cb4e for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 21:44:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5D7456064A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=mRU6jU6I
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5D7456064A
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 21:44:11 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4ac95761c85so12477335e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795038250; x=1795643050;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dlKFnhZA1H6mNUgErYifZxme1zb2N98MmEMpKJEnbE4=;
 b=mRU6jU6ICTlghdAW/VBu56nhojtcgtHKBu+VSFDBlftdYPUTEcpQgy8NMsuaW+gVhR
 DTfhrWQvMY8iZSOd2EYG9iUgIJLEG6ScvmXbzSqS5caOJpO24l52PYSygMgIYeTV4msL
 MRUbSNCtOnooh8dSwTJgVGXGl5Lk4Hh4UKEcpMuXNyF7EjB+qS8ZYsgBMxSDpu6JLjhd
 CTJhEJCO2WpuN5T+4O/hknBuQUovIS/ftEA38Ypr4qFNMQUP6SfIqOqvoJluPryusWvm
 L/GS9LXAonfUCzhefB2ZFuN3cL8WBZDQ2KrIg5P+Oau75aSKWfNDY+WYMeWyLdLK6lRd
 1DqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795038250; x=1795643050;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dlKFnhZA1H6mNUgErYifZxme1zb2N98MmEMpKJEnbE4=;
 b=kzPW/hrkvkQtXLI2yrtLtSfjJoa2TL/mcAePgiNTk31Vy4+vJs1e/Ha8+84tOlyaz8
 oZk81ZiffQGgAjCmUxrm9wwCSb3isc7+L9370bQZYCaCjY0JYhPj2E3Pg/yclYj1+fwA
 74o6XGEWmAK4Axwmy4+pFPJC/hvXxaAK3hC7U4eRS2+c0ei5sAx/7uw9RvVsaLokEIYR
 9eTJemG6aGkRagCMQkhvr7n8quBziJc+OsY8Vtwz3kJQfxu1eAYqhVLYTMpPj7f77rjE
 lobdVQdToiDwugP55lRsBeruXJA3oaJSqaiql/1GcsMMF/ZwnG4R7rYdW1VMDGaOm/z5
 fcSQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFAr9TGh/UlU+eedi0Zs+KElJNwJ6c+iawzb8AQrUcbranEF3+SIFixucPzYfLRPkwnp+3IDy8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9Xq0uFQapuuPohDuwsHjWkhgBznvZ8eteftKigzoNAfwOpPT5a
 ZQk0UBMcsN05DFWs10CKzbZLKy5dHqRyTCEXorSZcJsEPi/AZyh9mSoacNgH2dWpwks=
X-Gm-Gg: AYBFou07mEgh9IZyk/e4RWCkfSNVlhC4F38NzUi8Jv9N26KEsueDeUbj889eb+8FKO8
 W1qkOPc38Qvhg5xE5CyaB4ygSKvg/Cd6ZtxOaeSKWylvo1IuyiBK6mJ5Q5YyaSknqLCkTY++kG9
 K3oLXiQspQDoLbbCoU1Wabz0jI4fq6A/9ICQy5l870iwARdaUULJzFbvnEfbl3uQm5KZ/ghkPSN
 7l4Ch+ZcnsBhsX76v9Afhvzc78XmRdH4fW4iyzQ5t5YFo634SQfi6H63dTiRBMPvNRXKHCXF48K
 BEiWS7yJwrt62ysNgXr1w/ZNZciMXLDD3CQsf20gnmPnFQJaFiMUcEKXzO1AAheU9ADevO2X5mI
 waPcdtXStNiGrhGwEHkz27IPTHQgEnJvp7qUb465C9Jr/PAzv1dX8KzWglFKF4UC2yeLX8tEQoT
 WqiH6jZffXgF9NHZZygSuzTcvHG1VTS8zS7dvESIXUMJCODKL/dCLuEyYN0YvYkgjssyLldPmb8
 zMfmo/D7CJu6ea1q/GO9u7SGshDtclnYB3dXhGhMNnjrYBhbL0ltnJoxBYJWLFw4jibniRyS/hU
 6xoG1wVTICfaUUesMQGa9SRI47xcNRLXVkqjyGh1w8/8IcWD8HXelJ3Q3cTKjc0CGPT5wqhjzA=
 =
X-Received: by 2002:a05:600c:3b94:b0:4a1:efba:511 with SMTP id
 5b1f17b1804b1-4bb7da440e4mr87602265e9.35.1795038250034; 
 Wed, 18 Nov 2026 13:44:10 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8450fce4sm700095e9.8.2026.11.18.13.44.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 13:44:09 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/5] test: cover the AVB lock state and preloaded
 verification
From: Guillaume La Roque <glaroque@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>, 
 Jens Wiklander <jenswi@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20261107-upstream-avb_tests_b4-v1-0-9177277458f9@oss.qualcomm.com>
References: <20261107-upstream-avb_tests_b4-v1-0-9177277458f9@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 22:44:05 +0100
Message-Id: <179503824596.2286122.17270238433128214345.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795038249; l=530;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=C3+lTv7n5ch0EKDZ7K0ip59EK5k2VpEu2NOzvIyl9PM=;
 b=D/7rPiZx0D33+lJP1I0aE862dnbBWCuTBOurLleQoQ7irSq64qpsKamFQBxFJBGl0dzJ/ZPRu
 sI/CpZTv8CaCHUt1Tiaco3QrbF4ev1bbX646uGnaRlfVbWV8BAT7HX/
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 07 Nov 2026 13:52:48 +0100, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrote:
> test: cover the AVB lock state and preloaded verification
> 
> The AVB lock/unlock series [1] came without tests. Add them for the hex
> persistent value commands, avb lock/unlock, the verification of
> preloaded partitions used by the Android bootmeth, and fastboot's
> flashing lock/unlock/get_unlock_ability.
> 
> [...]

Tested-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
