Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7954E7718A
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:08:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 156D68046C;
	Fri, 20 Dec 2024 05:05:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D0thQpHG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53A5D80087; Fri, 20 Dec 2024 05:05:51 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06D63804FA
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:05:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aa696d3901bso262289666b.1
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667548; x=1735272348; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4oK2eR0tzimBSXQ/02HgzSThhtpeIBftCEHi0FDQzjk=;
 b=D0thQpHGmu+QXjRfVYOkbTt1DU7NiOWxbVJLRzcz3eWrOZPe65oiNoi9q3stuCXgOL
 HleBEZEGqCM/O4cIQpqmxChsNflA8YxbiuXJm0yet6aoWswQw6WJyga3xfHkrMYTX6f0
 bNhP1bA6oN/upVx9x1F1xZzOQAjHKsz2VDFVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667548; x=1735272348;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4oK2eR0tzimBSXQ/02HgzSThhtpeIBftCEHi0FDQzjk=;
 b=aiOdCmcemrRFzOjJmK5m7jexV2W3j57F79XgMF52rDARsVdXRlGSs61kCIuyE25qAR
 ixkLk4X3qE87hLVdT/LQEt6H6pk+FKA9aBvjETaV7zuX2RKIaHPHOPO1hwn5l9y1vIyz
 v8uEOdskXqD5/3+o8rQMnroDznPJsAihPMuSTo6yJmAFNx3XxD1493A6VPSy1RYOy3j7
 vLrorZ+RR6qHkWi3uKUYP8IrOShWVnV0Ir1ZRua76jCtHuQ7c09PYCxBFgol2gCN0YSm
 65Qk54suebGax4F04RI/3Y1lLl2zXFMghpOvbnzWrPlaKC/s0CcqJ+BPBFghss0yofJu
 GgHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfC7nFIiP7AS4OcNMnWO+nES2J8snKiorRUuy3RLYNuYyG+1y37mS0KW4be91K8T3WYm1Pk4Q=@lists.denx.de
X-Gm-Message-State: AOJu0YzVy6a3cK2NGjB/odrFWRZF9fYSunajmsmHymL/maMs92C3f6bm
 JWfkFexroNQXRG9sPxyZdf5DBdsX5MOwu7cMHYAu9mcgDNk1UpRcFR/cQDx5nR+Gva4ss9LE3TM
 WWdZ39JNTDDl9NtHmwDF+8wMOvi7odrcqfucj
X-Gm-Gg: ASbGncu2sMqSgl0MT3vhhW2rCFrAZ1f/6zW8EiI2dJAjCdRbUIkdPCWhN9NKttRw6pw
 gX1OVBa3Md5PUFoqiHg8roJTGfz+YkXW/+haVDIg=
X-Google-Smtp-Source: AGHT+IF2H7h9kpGQJZu1rXflIn0GNPvQEdDubfE1X9gJQQ8AbciS5+AAbS7h8JfWKJicvjAfRLuakRwfAXPZh450RZs=
X-Received: by 2002:a17:906:6a10:b0:aa6:5e35:d72d with SMTP id
 a640c23a62f3a-aac2b0a5b72mr95723666b.24.1734667548522; Thu, 19 Dec 2024
 20:05:48 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Dec 2024 20:05:47 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-28-sjg@chromium.org>
References: <20241206023626.2456858-28-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Thu, 19 Dec 2024 20:05:47 -0800
X-Google-Sender-Auth: wtxUlRXNwgJKKA78WFwVmv5PrO8
Message-ID: <CAFLszTjbNcV=8-4TvFOMDL2vMD+b+GUbCenpc1=XnC31LutiQQ@mail.gmail.com>
Subject: Re: [PATCH v3 27/46] net: Refactor part of netboot_common() into a
 function
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Adriano Cordova <adrianox@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Move the core code for starting an netboot operation into a separate
function, so that we can (with additional work) move towards calling it
from outside the file.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/net.c | 62 +++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 16 deletions(-)

Applied to sjg/master, thanks!
