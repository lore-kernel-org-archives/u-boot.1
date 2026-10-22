Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B7B606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 14:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QoBwqudO;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=jcBHLhK0
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C194C6072E;
	Thu, 22 Oct 2026 14:19:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jGiZe58G9S7E; Thu, 22 Oct 2026 14:19:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EDA5C60821
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792678779;
	b=HpBINStn0y83DkmOgRnEHRYA70JZ7PFb6q0GJx6NRm/yl5lxhlyLF+BZrIojOoKEQS+o
	 5SGcHB9woRCTJuWcFmWf7MQB72yXF9V1GdY0aX2oTj3N0XTM2/zhIZcrYoAJKGmvK+o1A
	 wOcoWOzYOrbMJy8KRSuMOsy3xIpuMQWdkOfgAG5cTw3wzutxDdvMJvGhqAI41oS/jbIyx
	 Ev0dois+9xaJBhxNru9JuEx4OjZh8hf7P8PSSL+nZQ0bCDxMEkApX2WhfVAhacdPCBDNS
	 jYQ2CXciwRTEXDbbZLGT1HfEko1ldB7bijzVgsikeiAb/TGQ0I7eL2xhNS79Vq31FYw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792678779;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=abtIRIk01z4bdSJA3fEY++O3eDDRw8SoYqcyv/6Hrcc=;
	b=nPU37RyusDLPkgL5qAYLC91A8QEKms39KACbVZu0QfgkqFTRWjk/TN6HG1+GqHoyqVjA
	 6JD9okV093bAmOrBAFNyPl6+v7N+mojSEYNhMfyNOGCAKOMWajUtVuIPRpJuG691Rp/ms
	 bgd7JWHRPp6JxYa/O5/R5JFQlasKVzX8Rf8UtCMFLXgakTtjAjR2vAt1mUp7916vZXaN1
	 B0qG4rsV+S7DGnc0vzpRJwialmqA6knybzm8wDOmnBHitB3wG0XpSH/aUqeeBCLlEQZI7
	 8x9yAjP7f1tCim6t7qh+02vL7T2wyd6LHzJ6R3dx9swI4v5cSCtSbBquKmDAsP8+3OQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=jcBHLhK0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792678779;
	bh=abtIRIk01z4bdSJA3fEY++O3eDDRw8SoYqcyv/6Hrcc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QoBwqudOqt6I+h8x4OzTCLe0ap17FUQ5nlKcWsFQNdyE08zBwF+KOfYJ1hCaUOVQ6
	 fwmqeD6Eird1YkVYqKqWminDZ8ulmKuWFXeenbLnoDhij3AeQKpC8r39Zu59mvUxjZ
	 iUqTmY4riefuk3uMK21ikrsVQ+mHzMDiwrR8xHyp4LbF82x5JwTi6RyMDXmxG0MueK
	 pOWL9blQIStrSR9ZOE1fggjQbsPxDHg55Ue8q+pOWZa3CO6kgqCwv4kp3SAqGFhp+3
	 liQYtmJfwC5dei64rxAzDsxFCw1BkRgTdznQ4rRtLVqHoKVooCm6qkcMYQ2MAq+gd3
	 FnU9Tw0VYUXww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EDA5C60821;
	Thu, 22 Oct 2026 14:19:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A9D6D2A8
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:19:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9C1546066C
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:19:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9HMDfgr_pDjJ for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 14:19:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E4EB06063A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792678766;
 b=TiwJKSnWayJFfjP864/3wodq0/mZLX8pP0f5XRXZLgmc5ahS3Pm0gIdLcOMo2EpiP2ek
 n7PuiBD12F9EuYI/UydtN3w5bstWr9MSzAq3QuNUWKEUCCUZu5Sj3wpe7fuc5pnkkipRN
 by/v/Qb2xwnQ61vTAnTaiTSrrDfC2U0dczGSYgtAf+TOt1nh5JAds4QyNRNiAhYIvL5hT
 8utQT+BZ6ZnhdiUHchlZ/ZXVuDihEud2jB1rY0ez8JJpjJcnailIFJ6ijThU7c+k8Adv+
 vnvRa/ixkE5X/l5kuJb8cgtxjBLsXR6WA0oIVy6UV7V+f+7GIKWMlzNMSlW9/Iol+1g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792678766;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=abtIRIk01z4bdSJA3fEY++O3eDDRw8SoYqcyv/6Hrcc=;
 b=V+ezxo0N8U8WfQsY9RU1Rr2pKwDBYjOKBAJcTzDGqacpuHDkm6LuREbVNyM0neIyJkE5
 1FPcecgf0uItLS8RpVNshL9i0I4bhPts3YhTx/qzAwnPsAnorbaj24efdxKUBXij+l29C
 Usmu5iw+mfdU3Q9oZ2+jc9A4msup0+V4HFPgxGxjNsnLbfeG/KiAGnts0O8RVWArU6TXr
 81Jv2SO+8hshmrdnxxYomoFpaQA2/4cELMYvAfeKOVSbqIbad5r87t3VSe775lgZX7Knu
 KebW9Mn91lclys/c6OIhyQHEJCQTdtQ06NkV4e0eJvUseohNzhfU6aLJ90L1SttZhqw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=jcBHLhK0; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2f; helo=mail-oo1-xc2f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=jcBHLhK0
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E4EB06063A
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:19:25 +0000 (UTC)
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-6d290b10a35so849831eaf.2
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792678764; x=1793283564;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=abtIRIk01z4bdSJA3fEY++O3eDDRw8SoYqcyv/6Hrcc=;
 b=jcBHLhK0Fz/rOhaoOQpupnjtUp8d+B0Ei0EjZpaqqo1LLux3Fu9uDNWCg+rbA2RmK/
 NpuGPNMnL/VZ/5bM73p7Ti+4bluO99eOgvr87p+N5JcDoOePIWFWMyG+4cQjjcKnUf4s
 k4dp/q/Y/tpnY7edvGNwlHDzzj//hQoTpj+M0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792678764; x=1793283564;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=abtIRIk01z4bdSJA3fEY++O3eDDRw8SoYqcyv/6Hrcc=;
 b=SHgLfyYL1jW5pQFdHe+Kz36tyH091snkbP5YQk2ilCXdkbRlwPcwWMxVCJsGkUqbFK
 ybO2PMOAGXE7N+h8dZqCmzOZbC6FwLHuDnxSti2Y1i5S8GTEJT5hAIz1z0CQutTMvjuH
 GEH3YqgKGt4jMGciSkB0FhECo8vSl/qkfsX4r3R+voB/5Gub3xhOTvBryW83xXPA+F7l
 I1D5oBN/vkx1DkM3JCICqDB/TDIKGJkKkYZsSGIJAA7qV7LN9CUVzDTg5FltV1ZAW5j7
 Qm3Cyt8peUgoARFikP6TdCh1qF6/HvXht8EYdN/W+x+aAfBny+JL9Ex+x4myGSEpgVov
 3sEQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBysaKMfftekP5ZBt53gkJdjKqLaNxPa/fgB/YR4Mi+QGZoRHhewuFx9ojxs5aLfNRcFxfS6C6g=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKJMLByL4Htw/tJ4veRzl3fXG3A65yIsWTsqAWDHJscPx5M43x6
 6K+cWUjHSG3RR+PUH+Ef0MMZ/dHlaq2m8cfEIdP/QR3KTFJDW23h8VBFCsLVSU+xruA=
X-Gm-Gg: AYBFou14vsgr8tfetMLhZ/A2o98aioysUMwEnU9IbE8sZMr/qF5nOarQrBeSYPeHeIa
 hKszVoYwPHNMTz6RLvGmMLcKpQRaeEnEKpa0HbIDl7Ot4qnJV25x4+R2vGKcRG4nXenZkXlz6U6
 bSF3Bh+j0uGE0d3351qNtJ6VeD/jbR5gvhoi8GR6rnZ4RVqhlMgDum0VMVLGOqTNiAL0rjhtjVT
 SF2zkUiquWtKQgM3PO5w32dpzI2tPxZ8YbxRDYeI03APq6if89GRcKSwG2ppK6dDH1eTZ4ScE0S
 jxRJN7JAILIJLjGopXfwPQC7UxLLO1Nv3wKSoAl6sJaBzQpOCb8XD4PbYHfPu2G/CPiODEXC357
 nAhAo0j381uwSHxcZN3m+RDTROT438Yzmhqy6hfSND84L+Ra0DkEedwKMLere/U+BlgyAe9yZOw
 CXNsQ3u83Htusj9TwPSWLmy1ZqwJC1SUZJ+t0x7lqWJDbLTWgHhdu4pDYe3CLnsvU4d0oQIo1xu
 m7kRkXH3akvhi9CBACGnyXHv0SdEQgUWUttyLFRZUU4PLESRPW6crvekhH1PJDkGRbK0ICHNGF/
 p6v2BBPWEnU7gAiqDZAnQSR/2gcmWu/nzv8U9aL4reuduOaeOcTd53axLHTC0FEY5IqJ2qdeRwg
 =
X-Received: by 2002:a05:6820:3515:20b0:70a:4053:52cf with SMTP id
 006d021491bc7-70a40535f1cmr1651795eaf.5.1792678764252; 
 Thu, 22 Oct 2026 07:19:24 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-84cbd2d2a76sm5506744a34.18.2026.10.22.07.19.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 07:19:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Rob Clark <robdclark@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.u-boot-project.org, 
 Sam Day <me@samcday.com>
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>
In-Reply-To: <20260601-simplefb-rot-fix-v1-1-eb65d41ffffd@samcday.com>
References: <20260601-simplefb-rot-fix-v1-1-eb65d41ffffd@samcday.com>
Subject: Re: [PATCH] video: simplefb: fix rot prop handling
Message-Id: <179267876348.3588521.8147540699749893135.b4-ty@konsulko.com>
Date: Thu, 22 Oct 2026 08:19:23 -0600
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 01 Jun 2026 06:05:33 +0000, Sam Day wrote:

> If the simplefb node lacks a rot property (which would be most of them
> nowadays - it's not actually a valid prop according to kernel's
> simple-framebuffer schema), then the rot local is left uninitialized.
> This causes video_post_probe to fail to locate the vidconsoleN device
> later.
> 
> Strangely enough, simplefb has been working fine on arm64 targets. It
> wasn't until I tried simplefb on my arm32 device (samsung-expressltexx)
> that this issue manifested. AFAICT, ARM64 doesn't have something like
> -ftrivial-auto-var-init=zero enabled, so I suspect this has just been
> working entirely by coincidence until now. Computers are fun.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] video: simplefb: fix rot prop handling
      commit: 50a15eee8b100126ebe07c79af0aa22da1206fd0
-- 
Tom


