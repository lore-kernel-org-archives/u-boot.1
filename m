Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF51C5472F
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 18:35:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2D9288A32;
	Tue, 27 Aug 2024 20:35:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rq/b5mgX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F52288A47; Tue, 27 Aug 2024 20:35:43 +0200 (CEST)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35424885A0
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 20:35:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-44fdcd7a622so33463331cf.0
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 11:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724783740; x=1725388540; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ydkwjCoxMLSD3Y0lh6D+Re0voUKxvfw7u6fnm+evDEQ=;
 b=rq/b5mgX3zouP7LSNWwYC7tgsEhsr8pJAvMIn9PaeUYt8LNiOJUTplTzT7G227o+JU
 bzg/D5abJXdODAClCEmTFss19BwFzaUkhnfae/G0vnfQGYq3mfnQUAnW+MgJ3a03uqN8
 RedKXENaiT2zV9SOezNEN+eWTADJWWz00MREg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724783740; x=1725388540;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ydkwjCoxMLSD3Y0lh6D+Re0voUKxvfw7u6fnm+evDEQ=;
 b=OdG/tx2XKl+93GbfohEMdiECQpcjFvvBKmclHMMAiem070tNdPDsj8SEsUPAJHTInr
 7AFA0njJb+m4KMtwjt5sB4dbxsd0TzlG5Y8iRRIhxArcTJC4/e3ZnFULTkfTkYZ3g11a
 8AacUaT90KTVCIK3ORtj57jgYK0cL7SfK7LTb7Pga5Mrli3v+qYEOH3tuESlFWqQWxn7
 PF+r/XY3Lchd5HqX6/uEOqOkGTuxZSWSoCMpVsaqQ26tZ1mOHajHe3tZQkMKn7CrLd9E
 06ToK61tiLdsUppPMlPqEfu6fI8aj3VKUa1qarZR4TDdE0p+sbPJ8RDhOasQ5qTMpQSF
 7OdA==
X-Gm-Message-State: AOJu0YwnKALQJjImVQy7EEi3ddrRFOUKmxK+9kwWBXYiHSVPsSMaM2Da
 ybyrtIq+TaLoMj2QKPMXP8XWeLZTU/EdJF8o3iwJ5K9vCZ+4hZ4eWyJTQpV0wqU=
X-Google-Smtp-Source: AGHT+IGIEBttxczo/2+NO+yK+G46NOUMQpqzEsjdcAAN3Mzlq58KQ++UJkxF4QXpHqFBUAx+1rYCKw==
X-Received: by 2002:a05:622a:2b07:b0:44f:e2fb:b289 with SMTP id
 d75a77b69052e-45660976fb9mr40885851cf.61.1724783739910; 
 Tue, 27 Aug 2024 11:35:39 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-454fe1c9c9asm54635271cf.89.2024.08.27.11.35.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 11:35:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>, Reid Tonking <reidt@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Aniket Limaye <a-limaye@ti.com>, 
 Hari Nagalla <hnagalla@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 Dasnavis Sabiya <sabiya.d@ti.com>, Neha Malcom Francis <n-francis@ti.com>, 
 Sumit Garg <sumit.garg@linaro.org>, afd@ti.com, eballetb@redhat.com, 
 Jonathan Humphreys <j-humphreys@ti.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240809230157.3935118-1-j-humphreys@ti.com>
References: <20240809230157.3935118-1-j-humphreys@ti.com>
Subject: Re: [PATCH v3 0/5] arch: arm: dts: ti: Add missing fss range
Message-Id: <172478373808.2927671.16643866114574639411.b4-ty@konsulko.com>
Date: Tue, 27 Aug 2024 12:35:38 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Fri, 09 Aug 2024 18:01:52 -0500, Jonathan Humphreys wrote:

> Upstream DTS added explicit ranges to the fss node. It did not include
> the 32 bit memory space needed by the R5 to access OSPI. With the
> upstream DTS sync, OSPI boot no longer works.
> 
> Adding the missing range here. It is also being added in the upstream DTS,
> so after the next upstream DTS sync, these patches can be removed.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


