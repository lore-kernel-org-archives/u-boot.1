Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E435EC87FC5
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 21:30:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F2928391E;
	Thu, 24 Jul 2025 23:30:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="m4Q0qnLu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 867E883927; Thu, 24 Jul 2025 23:30:37 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30BB38391E
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 23:30:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-2ff8d43619cso1082743fac.1
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 14:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753392634; x=1753997434; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bg+eaCjjR0lQgSkM49U+OehtpaF2OlcBDbGZIWivXp8=;
 b=m4Q0qnLuC/XWCNcrym0N64vXX6Z7hX2hDJUnghlYsiwmijHC1NoI0tWZPMzgdu/AH3
 Hh70k3y8PTudqwbRV+xWFSLPWfJULUc1lxyRVTV2Hz20zMhYsFnW51bE0cvCTCl43eeF
 3axWfO2yJ+lzlMXwl3kPO+k1nF5QjuZCmQP8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753392634; x=1753997434;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bg+eaCjjR0lQgSkM49U+OehtpaF2OlcBDbGZIWivXp8=;
 b=CC7GwDUOxue+UJAp2SFRWo0s2y8x36RhtynOQDL18F/8hI0Rf7ExAodxyB34m29o4d
 vSjORVUYGi/RsLmq2qRYj5wMUnm1twf669MBoZwI8ZdStz6hBEz0sQWLopd0gGpO34ry
 kYjd2PTGUmfT9iVplNP0y7TPKva+gVXck2+BAwzEOFQ0TA+aHCs0zZ3Vvb33OQf8gocK
 9u8YzlvvP+4+WQ5ySXXiNv/6Fcyr6SAV8eMT+jnyidPne9MUSbdJh4moFh70KDHUxCbH
 7ZP/qYI5JuAqXYZjLt0LgqRndHEZG6D19J18N6nlvnfSR+taQ2JejrYcDlsVPtNrHNJq
 56Ow==
X-Gm-Message-State: AOJu0YzGRcjoLlCTmnrsFio2NafZ/JxXoxo9+P5itYsEqDMN1zfE6OGC
 rm4bVoey+Psd7AH/G2S0dOnhK2gppewnZS7bkJGYftWjWgqbMUrzdJpao1CAEiNqxggwflQEz49
 NI14skww=
X-Gm-Gg: ASbGncshJkEoDF+eU1uPAMgCiO+Q0/DSYxYfOTlWlXFL22TX53EG/XWqmS7sPpTN6oy
 TWTMq2rkEMITiQoGZvFzrbWvtRO0QA1DZTJJAxcclxvHNbF5vJQs6Val1vPcXQ04tdOztLeNQ66
 G2aomc87IKa8vIpkJV9S3rmb5bCilVOrKyldzIF0O6hAonlnuu2yrKqtTwVUmQhVmzNq8vl7dQC
 qy4+0TSbXnZVHq2aMxcZaxQpI5QVJa57WkNejbQKcqygcSoCpF75R700oH03xuPo3KPjyZ5sVVr
 XP8rS/zORj+JudwkMsWRAPLju/S6EIWU0uBUhVxkViFP79IhO5ySijOET8QeqVoPEheYSfPabm7
 W1C4u0/Vx+9HzuzphTSm2MoMOnvfPo0uhkfjX309grzo193LPV9EJCt8=
X-Google-Smtp-Source: AGHT+IEBVesH4B6rBvX+18F/rvLA+0KFKAylwn+2aY192w7uIltzHuwAJXNPfTWV9PBppMzpTFlBtg==
X-Received: by 2002:a05:6870:7988:b0:2eb:a8fb:8622 with SMTP id
 586e51a60fabf-306c702784amr5487728fac.15.1753392633942; 
 Thu, 24 Jul 2025 14:30:33 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-306e1f8a7adsm660520fac.42.2025.07.24.14.30.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 14:30:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250717-exfat_label-v2-1-b012eacca67c@linaro.org>
References: <20250717-exfat_label-v2-1-b012eacca67c@linaro.org>
Subject: Re: [PATCH v2] fs: exfat: Remove unused label code
Message-Id: <175339263327.1899261.373446122723160915.b4-ty@konsulko.com>
Date: Thu, 24 Jul 2025 15:30:33 -0600
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

On Thu, 17 Jul 2025 16:29:21 +0100, Andrew Goodbody wrote:

> Smatch reported a possible buffer overflow in exfat_set_label but it
> turns out that this code is unused so just guard the function with
> '#ifndef __UBOOT__' as well as exfat_get_label that is also unused and
> the helper static find_label.
> 
> 

Applied to u-boot/master, thanks!

[1/1] fs: exfat: Remove unused label code
      commit: 8f3820dc3a262b0d11c261bf3c526159d8c771e3
-- 
Tom


