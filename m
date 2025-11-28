Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C36ADD116EA
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 22:32:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C104D83B82;
	Fri, 28 Nov 2025 23:32:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y8ZyeG53";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 609FB83B82; Fri, 28 Nov 2025 20:24:55 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BB6C83B5E
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 20:24:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ernestvanhoecke@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-477563e28a3so15166345e9.1
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 11:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764357893; x=1764962693; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YLtbRn0rl4nw1yOcFD/AjkqqflLZkz6rxqdlaSmNomI=;
 b=Y8ZyeG53yTYHbaI4eK1jwnxQOQq++gM1gHic55kq9JztCKw6GEC6AetatQuYMt6lEn
 iHlfLKuJTGqqegpiQM6l8Oc8eiMOJC/ORNcm+Z4atOTsM5Pm9REvJXZryIYYiFPyG/Vm
 9aBtGI22Wxk/aiPQv+nzskUwwDPPnMGcbKs/mFgWuhDO83UNJiEyXEISUil70AfBRIcR
 wjzaty897hDU0zyh4dqaS15MfuisgR+/LCVpHBJNjoEHc5t/jMumDdfOESdBpTyO7w2Q
 u0YRi8k0bPd31a2Wo/vTjbw2baM2KrFS6lTaarIyAWGCTjDG44uUoyuwW4IAEzUKkWT7
 Bklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764357893; x=1764962693;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YLtbRn0rl4nw1yOcFD/AjkqqflLZkz6rxqdlaSmNomI=;
 b=Fx13MsD4yfF4r1Es0o/IrL7pkpPibVf56CdPqiFM8WrmX1ezkJaO5VVpN5YnyK/7Tu
 YX0mg3kxRFmKUET63Urj6tZQwSzXXjQ5waOG3q1vJsR9pOxjBOr3glg/1hJp/mp9KzSY
 7psobeleg5fRqtPVY6Ln5tAnl8DOkOzsSL3csXUFYqOBSnoOKMJ4ubWOR17+jKFLYaCE
 Fx5v1cbKzFzBY7s47Yp1TLLZasBMIz74N+IpJpHYPa3cElIWzCSYTOCqgzJMpXYEJDQ1
 27+2I14Pqzi87Ya94s0AASSOjiEv9N21Y7ddXBijvL+5BGQeC1TmFYH8ThE+iEALJJRd
 ChEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7vZagTVPi5DFjFgMycT3fjSE9kQ+YIPYKA56FdxD91LjuVhIZkB05ialBe9BY0n5Nhxw7jj0=@lists.denx.de
X-Gm-Message-State: AOJu0YxXN5YJM1WuE2+RpjTcRrFGI0ypK2eDIDIWX65xuRXXhtdI1Cia
 KHwhF7BOJHenJjEkwnq+eAvo56mtDtkyKa2Y/Mv31P7AcdSouz6TCSTI
X-Gm-Gg: ASbGncvW1z6TrOqmHDyhnQHRH1jtkkAFIFCmaWS4EEEMEqxMtaRAvJzdTCIC7VaQ5V6
 gYUeQb5IaFv49xJckr5/QYfSU39WiXq44ce5XzlcetLs4Ut7kW1QmA7io+/IPChhIifAIR3jWdg
 IXHmZWBbjydzy8bKzWEm9UwNIZkphOQcOv0cITmsJYGyd5q5BDH7GK32JKJLMXqrq/LD3qaB0sy
 nOIMbdq8sTg5A+s6nnJnzCMgHqpPIV3AVP/8vnzCZiSRhI/bpDul9PxRlM/FK9bspgVuJkd0T82
 SjCJq6t2ILbASlQV7yYAT1R81UtJKRCwgKkosA0nWlEktA36aEqLzpPRoLiMq8ATw5B/NZjZIok
 DVt7nnVOlUgRYHEmtJmwQlt+odGlTE2kexXcxMZshZ/Bg/mSjJbVpSAItfPcR0ajurxul9TzFr4
 kRIKjLIO3YXC6hWDZnxZ7Agy332wl+Xx5Hz+MeBoZdMSNV3ROASEBHt+V49phLs3B92XxVJ+ioX
 j6bN3FiWK7iCQ==
X-Google-Smtp-Source: AGHT+IFVNE4TWLg6Kl8gage9Z3AZ2amSfvSWtTJ9e3jef8S/1BLpZnvklGk6qmW6O3TyjosOk5Rkbg==
X-Received: by 2002:a05:600c:12c9:b0:479:13e9:3d64 with SMTP id
 5b1f17b1804b1-47913e93d6emr44071255e9.15.1764357892571; 
 Fri, 28 Nov 2025 11:24:52 -0800 (PST)
Received: from ernest.hoecke-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790adc6f7bsm174892905e9.2.2025.11.28.11.24.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 11:24:51 -0800 (PST)
Date: Fri, 28 Nov 2025 20:24:51 +0100
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
Cc: Prasanth Mantena <p-mantena@ti.com>, Tom Rini <trini@konsulko.com>, 
 sjg@chromium.org, alpernebiyasak@gmail.com, u-boot@lists.denx.de,
 vigneshr@ti.com, n-francis@ti.com
Subject: Re: [PATCH] common: spl: Enable Instruction cache after relocation
 in board_init_r
Message-ID: <hkcauyeizj56liomndagywfj54u3qpm2i3ameo5oyt2ja2mnrq@kluwp7dalbma>
References: <20250317064507.1702120-1-p-mantena@ti.com>
 <20250317151318.GR2640854@bill-the-cat>
 <20250325053420.4wuenxmlnqsojuyt@prasanth-server>
 <n57czo3z2lzyarh22y7oien3b6vgyum5lt5z7xe2p3rrcktxpp@qmdmk65aagng>
 <4684aa54-db50-47de-a565-e529bde793d3@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4684aa54-db50-47de-a565-e529bde793d3@ti.com>
X-Mailman-Approved-At: Fri, 28 Nov 2025 23:32:55 +0100
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

On Wed, Nov 26, 2025 at 06:34:15PM +0530, Kumar, Udit wrote:
> Thanks Ernest for reviving this patch ,
> 
> Changes in arch/arm/mach-k3/common.c seems good to me.
> 
> but common/spl/spl.c can not pushed in generic way, I can think of few
> platforms running SPL w/o caches on.
> 

Hi Udit,

Thanks for your prompt reply and input. I have now tested this patch but
with the enable_caches in common/spl/spl.c dropped, and everything looks
great to me. I will continue running the tests over the weekend, but can
confirm that this change seems unnecessary to fix the issue we saw with
sporadic boot failures.

A v2 that only touches mach-k3/common.c would be suitable. If you
prefer, I have a patch ready that we can send. I don't believe much
functionality is lost by simply dropping the spl.c line, platforms can
enable caches themselves as they want.

Kind regards,
Ernest
