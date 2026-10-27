Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83605606A31B
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 16:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ucl14RB1;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=gJp6+5xd
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5DDC440763;
	Tue, 27 Oct 2026 16:02:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5jfCm68M8wZC; Tue, 27 Oct 2026 16:02:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C1F2E407C8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793116949;
	b=o4YQT8619yLZiZXm3tagTt4KHH8nLgU33S/vsYgsgAwXVZvbxwPH1sP4TrQ1Q4tTWpEB
	 4NVFDOJPiRcnYYLCiTBGgxZfgJnEnyNt5fBiB01eQGWHTakwckjYnQjvGbPI0erONj4nA
	 LEgJPH6MB5bY/XwcEviOwFybaHtKiAi2qHfftfFs95mZe1zdLPEQhkDbFv5IMrfirF0UE
	 APdRL4M1mF5GPETqFhIZMnh++d4xwplLDRJfuVvKhSqy/Fm78tCDqbtCAg69uLqkKoeB0
	 j78CbNlOdWZAlYRM2qdEz8aZqqjUhbePI2XOtnXhOoTAhHCIHNmgAacu3feNAgsgwfA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793116949;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=meoT4+2hDvtj9xXYaHSQel57mu2xl3rVj0NoYOFpsMY=;
	b=WAlQ61UuWsMBEKBOo287wySG0Zb8RcZTU62OlOCxDxL1unqpCzb8DJ4VPmNvGlI2hbJ2
	 qx00RbiQ2jVtpGmjwosWJQjCcMDhLNfLqAbb5oKGUUTOfAfPhAKtENwRCGKnsfuF3vmqG
	 2RbL+O1Nf0wdJMU4/+Vq/rn5foyLZN/J/k9+Q52eAIAfDD2lpXVbni9YznSSuaSBN0Sm1
	 HpwocOaSdRGQ/0SClhSDMfwmNGI/ezEZyXCdkAe7QBA5F/CggdiNGXn+t5zDW1ejIAaBo
	 lMi0Um9ccW7bW6ReKult8s9NEEVYBSGA9C/qctE2Ol1hKohXJhK4qbGCVjn8TOQthDw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793116949;
	bh=meoT4+2hDvtj9xXYaHSQel57mu2xl3rVj0NoYOFpsMY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ucl14RB1cbHUq8fVvhcfDhKDp1pEBbH7J7l8zis4UcQ2Yf5mRIemGqGz8sFNkgF4i
	 R0W+l6PrSQPRjAX/lIKGU0/tJPitRBqumM4bOT4aCeXXP6g/BakMzscCMKnYttE7HU
	 tqR+bXm5Sp2xGxK3cvbfrAtuwU5s0nBSUFENJGYAOVUvObLL6tNJvBqWyPCxTO9FS3
	 DF5Mi/KstWtWzFf1ap68QO2XbgWfPMQ8xWfHcHcSsLyKXDn7hFp3dkc2LhhJFpGS9f
	 2T3Z3+y/YVsGukKOkp4xcM4YvXe4nYcUOi9i+N53RaaM3sLVo8vIR0LiLwrJOYGNyA
	 aTcMUym5Sce0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C1F2E407C8;
	Tue, 27 Oct 2026 16:02:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7616F279
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 16:02:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6662780F9E
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 16:02:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id waiSscrYZyXt for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 16:02:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C5ABC80F5D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793116947;
 b=oW3ri5oSzg7dBEqUFyfGN5OeiwXDBKHp/n7BbmyhJaPfYMZH4/y8MxqwbXRX+Fsze3fG
 5qAwDOoMgL395nLa4bDti1aNDAzFQ/32mrrjdJjqYMWkGrMmTLZxgDav1LLRRrdwjv87l
 2ID4qWgS2LCq3lf1a4d7FJFFZK9mXKXG+mb84mC7CwFRbtAV9UI9TPlOrSdKc/CVIOQuv
 4uFoEzTO5dS7sfRQGq9wCViof7vuEFw9vHdE4ZjNoUfmf1u7/enpeCJSEFSyxOL+/4V4x
 uBKItmyLJ/Tqk3Jdf9KFKlry8OmXVowHeozUnXdBLxN1BsI0r31yBS0+8X8EvffsZZg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793116947;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=meoT4+2hDvtj9xXYaHSQel57mu2xl3rVj0NoYOFpsMY=;
 b=Za1oli9bbrqXpqXGCQVOvESGOfMU6enVMSg5qUINQmr3kSIfEX7vmQS2YW/vbUcpH5hF
 POBCRMfwawkenjpMjjj2kP4vNuoBYA2VCHJsKL4RKdOXruXh77Y71CnPw598h6urjqHKF
 3RlvJbev57X2P7TO7pmVORNP7pQE3y17G+tSmQ/3P/oxmzhcm602wCQqZ+LpnN+LJwZad
 QV7/Bj4AjU3n7HMDnON2W4CUlIAswaZb+31228prCyYogyhM+nni4vEmqM5YF7yPfgyts
 vWb3G2aoLyiworR6iyB3MD8z1DPDkitzuzn8Gup8qXo3NGRCN0gkD/fyo5OGKQbmJPw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=gJp6+5xd; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=gJp6+5xd
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C5ABC80F5D
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 16:02:26 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-85a5455bd3cso232342a34.3
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 09:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793116945; x=1793721745;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=meoT4+2hDvtj9xXYaHSQel57mu2xl3rVj0NoYOFpsMY=;
 b=gJp6+5xdqsSt+GIQO0PbsmVGsBMGfpxWMPCisTsh18dC2kDxxpO8xajJsrd03/uSYf
 P5EjECxGGDXvA3RvkKaKqzMk8af8nkHIqu56Va1zq3tYSjrv40f1zQlWU2EZPN0JytiX
 cmg/R2zwBRZwyIeHUl54br0chyZD1Zjd0Ra2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793116945; x=1793721745;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=meoT4+2hDvtj9xXYaHSQel57mu2xl3rVj0NoYOFpsMY=;
 b=bWAuTRGONxfj77TDEtiGEQ2NkoBvGesTp+TaTCdzfTirNxG9YbYw+m6PdvJ2CFSAvZ
 s7cZMgDynkNnfa50B1zcoXlDMFMrysBcgFiGZXf0UdjZgpGl6eqfDHDLSfLKdj6yV66Z
 tmJniKkpc0OwjlsaWmoUiZrKsBZDBSbZW/C/0Ga/QxXHqKB59YxJHidtV1nq4E+PcvLO
 C9gpxu3ExxjlUol2cAkDEqwn7hVK2rrPw53R2FnILH/Safleqhcj40d5tfH54//ggKol
 SpEc3+fDl0KusmHUOmfsiuxOSVywIi6wkWX3WAaLdJ+NgCou+zv7ClM2ueZGXkKI1ysH
 eYig==
X-Gm-Message-State: AFq9FYIDnvMa4CDY4tiGLAOac2kPN9N3Bf2bS2KVQIhyHNLWQutjR76w
 JyiFcnB405sa9AkIrJiM7vaNplW/zC1Tg/2+Tr7B8OXSlQ7vV0dX+fyYrYhj4vPFqvs=
X-Gm-Gg: AYBFou1nzXRtqhVgWxBYd3jnPHgCmOV8kx5+Jr5jUhXVpWAE+tcac4UwPHeNYt5Mgac
 CZLgAZs7k9dEsJRVI/MCyPWuUoiXah9L+NiENLe2Imv2hy103CMQg9ANL/+eVlAWC1ljmaAAmD9
 QtiI+1nrWBsIaH8r22atjS00tjkgw026i8WU+OuIrfbIIyJEuzyFBl0Rht9BHp6Jw7smwnPqk2d
 iU69sIMbm+M03M6PwMbPaThbXU6llFamoE6u0asOfbLgDH6mAURd0HUVdeU1JuIq6E+5BC0XW8d
 6f+xgwBBKnoMWMxPmvRlev48C+fg9GBNIlIMgAPJZe7M2CFUQuGhV97BepeLjBWhWuOuDe4AlWh
 47R6POZzH+U0EXPHxxErJZGCAlBITz1Mao+I24xzCQTtv+ueC7b39NjoFVNnBxNTIbEg7xLxMeT
 H4YF5W0+fMryVKYJM+DUufEFLf9rZ92fIEDjiz3LWgX04KHjoG1tTMqusdec8zZNZtOKtQ6e4id
 vSU+iUd0jZFZ3gdiLm9jY/4eZJ9J7f5uhMFFTBMBd8Y4b1/qA6NYmP2nTpQWN2VhTR6/V05+hru
 xiz6fDVTvv7C3NE0qVtnglHabU5INjElBBLhX81sUH1p5P5cC2w9obhrRllJrufoReEP5zl1Qwx
 eBEwqykENo2vf5W2NwQ4ErHqoxv8kwbxc9/aVvwu1pGWoPDZuH13vOQwpm0xkz9k4XnYO7GxDgr
 A7LQbynPmLBTmThWM+oQ5XDyuBYwunUw==
X-Received: by 2002:a05:6808:3084:b0:4d5:295c:a82c with SMTP id
 5614622812f47-55c0039f406mr7337168b6e.57.1793116945181; 
 Tue, 27 Oct 2026 09:02:25 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-55c0424973bsm8537548b6e.6.2026.10.27.09.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 09:02:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.u-boot-project.org, Bradley Morgan <brads@mainlining.org>, 
 Vincent Jardin <vjardin@free.fr>, Bryan Brattlof <bb@ti.com>, 
 Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
In-Reply-To: <auAG7y1hk1-bjt6C@nxa18884-linux-1.ap.freescale.net>
References: <auAG7y1hk1-bjt6C@nxa18884-linux-1.ap.freescale.net>
Subject: Re: [GIT PULL] Please pull fsl-qoriq-for-2027-01-rc2
Message-Id: <179311694200.2385664.9688315453865404008.b4-ty@konsulko.com>
Date: Tue, 27 Oct 2026 10:02:22 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 27 Oct 2026 10:05:35 +0800, Peng Fan wrote:

> Please pull fsl-qoriq-for-2027-01-rc2
> 
> I dropped the PPC changes which needs more time for response,
> only kept the change that Bradley as PPC maintainer.
> 
> ---------------------------------------------------
> Add Bradley as PPC maintainer
> Make BASE_DISCOVER_AGENT it optional following spec
> Various update for lx2160a serdes from Vincent
> Check LSB_FIRST for fsl_espi
> ---------------------------------------------------
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


