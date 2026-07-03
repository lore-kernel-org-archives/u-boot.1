Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE397C44500
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 20:51:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 139CF84ACE;
	Fri,  3 Jul 2026 22:50:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ag/B+l3z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C6C184A95; Fri,  3 Jul 2026 22:50:56 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F089584A5B
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 22:50:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-43bf9548df4so549814fac.0
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 13:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783111853; x=1783716653; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9h9F+Gy4dslRSypJ6jiZ1lzu93wQJIE3XTnAynv/p/Q=;
 b=Ag/B+l3z0RKOczG7vL9opV4y/qzt5VJIg+2Opetj1ktn3y9wMBvmo7H3Vjm9bw52ld
 b1mPhBEKrIoOm+I5UUbGPFcqtywFzbKXTk9+ooC31bW2iSiCgwkl+mRGEQcNWXeRavuL
 DLYb0ZXtwqwYRaaEA1oq80dNMGQZTG2FkP4B8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783111853; x=1783716653;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9h9F+Gy4dslRSypJ6jiZ1lzu93wQJIE3XTnAynv/p/Q=;
 b=MaWGpkOuRQsNwFmToE9+F8HH/BX+Cdla9njN9gCa7H8EnFKGHxyr/JSC8Er93BsuwA
 /w6a4KdNx0id+vJhzuVtKrSyWHwZQBkBDSdG9mcYXIS+HVR6bWor3dXbco4upnIT/F2A
 ryS+5Re7nRyQGNYT++e15tthcI6GWOzrEmOWC41R1sh2nL05G3IeMS/bNTqKy89Ljcb0
 2FHP1s2k+7rjugPxfFtI1DpZlZ4eCYiDEMfvFeGYu3nyC3Ah41ce8ggAZBpVi2EVpgp+
 sOWvlJLeQLLv6l04CsiaXvFxe164h+NrNlAxE3srHABUhzm5reUxm/ZY2QTEm8EJWPTu
 DMJg==
X-Gm-Message-State: AOJu0YxgWKwhgQab6iwyqMLUUSpCbZmC6Uk9PJCqwR1CgjlxlyS7211D
 8uJ/uatvdN4OOs8vMf9C3UJt12XR9KtejBuohZfGvNEf1ANbr4ctURE2GMYFENboEHAfnDg772D
 E6Kftwu8=
X-Gm-Gg: AfdE7cnr6CaZdioBwHFCiDFWDjit5/HOhdWt5k6IwBqp6WRRcEDWhO9ZM+GQV3hxAQK
 8DOC7qyPKRW3YmgC/WuRlyZYfGcZQjwYs05Gl8+E8k2eXZSX9ICD4981qo8zSMdhR5ebt/ffRTi
 3v65ZOSDvqv+daoNo35Tke/qdIxql/BpCy0WKe4gjr5RqKQfPg0/4O9jwRA4E+YfVv1iwBKVeaJ
 Au5ZBvGMZVPBvFJA6FNfYtzJeJhIoGrGj2ZCXC4U6/ZMpjI1j10fneD6VIMt192B+Tg0JyM+xnp
 YSSjTsVj26CojcKNtL7N4k4CRCLxZV7lP3Y6yTe0V4HzqpHhA6ycqikaGwgtbsLgNOoZ55PsqZ7
 dspXaTg+VL/qO9x8zLio2kqG/VSNJ8I9EpBbwqjZdMoTVS4WAZ0O6GX4MkbyLwOjxfBl1Ee2Kg9
 dHbeqWbmwosqM4duEoFYNg6ez4tluMVRdWb4b14hMjcn3Nn/k8kN1ZlGLYZI4ZNA9LR2wlBHR8D
 StZ1YkRpb7UhGPSjbKa7ehv98GQVFo/DlBwEMUOXtFvS8U=
X-Received: by 2002:a05:6870:826d:b0:441:39e1:246d with SMTP id
 586e51a60fabf-44d17fe2cbdmr692378fac.11.1783111852522; 
 Fri, 03 Jul 2026 13:50:52 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb6691d1sm3088491fac.17.2026.07.03.13.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 13:50:52 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, git@amd.com, Michal Simek <michal.simek@amd.com>
Cc: Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Eugen Hristev <ehristev@kernel.org>, 
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>
In-Reply-To: <dc57b5048b5c64693b5347b811ffb8cd5107770a.1782747838.git.michal.simek@amd.com>
References: <dc57b5048b5c64693b5347b811ffb8cd5107770a.1782747838.git.michal.simek@amd.com>
Subject: Re: [PATCH 1/2] .mailmap: update e-mail address for Abbarapu
 Venkatesh Yadav
Message-Id: <178311185136.3143424.9800428890990532623.b4-ty@konsulko.com>
Date: Fri, 03 Jul 2026 14:50:51 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 29 Jun 2026 17:44:00 +0200, Michal Simek wrote:

> Name and email address has changed but format wasn't correct. Keep origin
> line which is doing conversion from xilinx.com to amd.com and then have
> conversion from AMD to Qualcomm. Also move name to proper location.
> 
> 

Applied to u-boot/master, thanks!

[1/2] .mailmap: update e-mail address for Abbarapu Venkatesh Yadav
      commit: 6da1278ee9c9054074950eb352a5bd5b11f2ff7f
[2/2] .mailmap: Run mailmapper and sync name locations
      commit: 2e184a1f24cb363ea2a4388e8c3e76d65c8bd12b
-- 
Tom


