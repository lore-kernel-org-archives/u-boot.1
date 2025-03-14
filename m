Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB60C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 20:39:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB17781FAA;
	Fri, 14 Mar 2025 21:39:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iM8mSfE/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FE9481F7E; Fri, 14 Mar 2025 21:39:36 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54C3081E8C
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 21:39:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7c55b53a459so246894785a.3
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 13:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741984773; x=1742589573; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U/uj0vnG3dg4Lw2ckqDrWdQ4f4xzrGf6pn0KuTyTc2k=;
 b=iM8mSfE/71XFnfUJQMDbF9NjmwAoepy72mze//UWaZw7XhNV3VQgZ6F4Phb5KlI+h6
 EQ7pJwxiE16MItURWNUhg2FhB/1KZHjeEFEd22h82NhJfx8HssMbbDFmG1HOeiLVgmRr
 AWffXLC09ylEoZEF+Gpvx5+mtE40OFfrKFdZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741984773; x=1742589573;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U/uj0vnG3dg4Lw2ckqDrWdQ4f4xzrGf6pn0KuTyTc2k=;
 b=vAw9wLjDgXYNSnJSAzNNPPoBslZVpsZWx19Z8oD4F7tQqqodzxtzXxGRotjhm0ZOti
 RB9xzCohgA9s5xZskL15YaDqzkoBIn4SeZ4FFnY0/58afgLCavSAlLPa8vW/eBpkeohH
 FLjm3u5CYAROqnu1MTaRCPjyLkURh/8q7KJ0cS76WYTXt4+AB865hXDxR0gyE2CZiXj9
 ez81010dvbHfWwp4Q6BUeHRBZpLr18k+apjA7MP07IP5ZHeQ8u75uAJJXjXP1daNIQ/S
 qiadedabuL8Gn4MOFq1XEE4V6cQM6nLV0wRJfjQyl2uZD5v77jUlr+3208XksI0IItJT
 cdJw==
X-Gm-Message-State: AOJu0YzD4fQ2N3p4mQO7rWG05aOWDGtifsG68uxlqAkuabF8Z2ygvY1v
 9DwnSIgp1GRI4l2yOHnoVPXLmWlCkWne1+CwBqjShjzGYg4azLVQzIf940OlSEszwCEniPlO4Da
 N
X-Gm-Gg: ASbGncu1YokOEtBQ6yVlhVVVZ+BFMfnCgMxgM3gKw1kGB41evS3NZtDz1RcyBrQqf6d
 3wWghA3AZRcxYJWAQNnzj2pgLRkb9o0sbSRtM458H5gse9ChlXqk/GIltaQ8sbWEZry+V2FkhDd
 PRpgeLcvkPkTJbZopvPz91PYcAMUPQsv2GBdBKX45chw3kTZ5lSdXG6dGa0McWdd5fh3pKg8zTq
 947hgqbrMlXpix6jpsq1MntISk8bndGH4swZAs4wqoP1fv6n3BTqZfuseRCj/lELPJbQufCCqD/
 OVFdeePlp0o4OxouU2b3exihM3QLvuSPFFkNnQEKWb1e
X-Google-Smtp-Source: AGHT+IFrbeTwx8jfKcEYhByLAsFX7OL20lH3LreXDiJXOHCkwwhuQE5R7moymLbYES5vnjYt0TqQFA==
X-Received: by 2002:a05:620a:2948:b0:7c5:55be:7bff with SMTP id
 af79cd13be357-7c57c90a724mr498923885a.43.1741984773167; 
 Fri, 14 Mar 2025 13:39:33 -0700 (PDT)
Received: from [127.0.1.1] ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573d72b94sm298787485a.77.2025.03.14.13.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 13:39:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: JJLIU0@nuvoton.com, Jim Liu <jim.t90615@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250225014505.1913214-1-JJLIU0@nuvoton.com>
References: <20250225014505.1913214-1-JJLIU0@nuvoton.com>
Subject: Re: [PATCH v1] arm: dts: npcm7xx: correct the timer node
Message-Id: <174198477160.2277875.11778400590570965683.b4-ty@konsulko.com>
Date: Fri, 14 Mar 2025 14:39:31 -0600
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

On Tue, 25 Feb 2025 09:45:05 +0800, Jim Liu wrote:

> Correct the timer node of dts
> 
> 

Applied to u-boot/next, thanks!

[1/1] arm: dts: npcm7xx: correct the timer node
      commit: ef254ccf37dbe6419e797acf5969a0ae66f4629f
-- 
Tom


