Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCA3D3F077
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 14:49:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED41283F4C;
	Wed, 28 Jan 2026 15:49:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AiZavypW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C04783FAA; Wed, 28 Jan 2026 15:49:54 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E61483F2E
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 15:49:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7d18f80b5c2so519283a34.3
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 06:49:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769611790; cv=none;
 d=google.com; s=arc-20240605;
 b=Efs59ZIrfuWnAHcoX2Inqz4ELtumstToG5E2SR9uw9WS2BuFJC6tUXfeLh0bcsHWxP
 h0HSuqOIYX66noXamaj9gEC2xN9IMQgOs4D1YzbMAYipspXCwWVC1XQ53SWyRInK7FQD
 nuB65UDdGbapvijzA/8ujzL8eo3Zc14H8KNk90JU33waV6p3c4M48Uc91f+sz3/Efje+
 311nMkTweTMzKboeTHFRauk7YVrUs/F4OgaO1mkuro28eBnnO/Q5dbkHPQiEgLN3LVuS
 VegTgPC2XOvfxJDQm6jv5A1ZxOyS3aaPRZO0Gq/pCsGb8QHNid2KdAwSXbpn3e7HxTy3
 UReA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=8SVVJoivuJ+YkU7opG609OAWcqSdLeenuDPWoV1VVOc=;
 fh=AoVEW340XNpvidYYnA4aNiS4cNS3eTFSgS3pBmJ/70w=;
 b=OEgspMwRTUJ1x/WNC+h38oHnpOBNU+BZfHgGCGm4amPBHjREqKDib28drdzfxJwSbc
 PtaCLFIoJiTDIVn8ZqGJtu53jNhGaNYl9kglB5a4Wuc9zS+yrrhzCgOowk7gwsFwRc9F
 jK0X1Wj4nsXs/qi7/Jryp5m1J/ai6gKek9i6RCqUVwxIlGFQIHmMwy+VacQyxAGLjH0T
 ifWhbN5o4HosZzCx+BTZVWzEiWIjqNjl9eYLsAgZmM/wuXsY3Om7axkVi7adSacZTF9/
 TZVnvpDq274Oc5nbM1Chk7LseL/5bpVWVC8jysomAlB/Yh5blsi0ZxaxKVwEqZakaKVe
 ZWVA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769611790; x=1770216590; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=8SVVJoivuJ+YkU7opG609OAWcqSdLeenuDPWoV1VVOc=;
 b=AiZavypWJMSrv0rfLAgp2DPM7Uy5JEDRBKLdfjQuqsIO+TfYMdPHmI5e9E+iVhz0RL
 zN6Tclu+eHgKEW0ywhlrm5tb/5VmUkYbwtgRq6q9hNsul2QVSnMnUYnic1tWN2sCNNiG
 RMNHv656nppkOjPUr/xXJHAdYjd+345Hp8zOY9NlVzHoqZY6D8BtLNOiYpMGEJf0ZzEz
 ph+RJeqxk4OURrV/PaVfozB0+TdiiexI0e/abJ+xZ85ABfdxznDzy/KPW9vgyqB9ToKe
 sjfkq3UhEjQzmyCa+E4QqR7MnYa4CP/+nWzPca+DJoCHTHARRCWdbRX/1zQEHTp4jqSf
 uSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769611790; x=1770216590;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8SVVJoivuJ+YkU7opG609OAWcqSdLeenuDPWoV1VVOc=;
 b=JbRZ2CCp+CaWmrkvw31jBzeJE3pOF37xj1M70Fu1/tF4tmjUACptMRSzvMhe+XnLa7
 rQbIdZpkFO7McXJghPGDXpeZa6Vk4/LyFzMBpdmETozRaZNHJxYXJMCE63qI8NK9XaXg
 Jc5Q9R6Mm6IKkyYvIvg/OWCPeWGM47cS6Y9R3yTUWb6bmDFG/mWPH0kZywxGPKqJa4gP
 mL5ihP5U0v9G8J+Wo+dn1tYQdq05bMiGvg4glsoW2HKlNQdfy38xtuW33HvWvTGsvkSa
 phlObBrEw4jipsXoBwH/6hZDDcReI7g54y14EIBdn6kLG+I/4JMq5pXBSkUnqtruIY+m
 u27A==
X-Gm-Message-State: AOJu0Ywx56N56IVyhd/WUJ4B9L2Rxt4SmwVmRf//9MCuY3VFc0hi2yrQ
 6B/NuIPkzSmpK+JBIW7OUenPGD1p3c7tp1FLZVDHp9PqlqtiZecJFwnyt8TlANo/c9rjgkvIVY6
 wRk5TToqPeQ/K+0bBmL7WCpXUAS9RU00OrlDXLyBgFw==
X-Gm-Gg: AZuq6aKoAfO2bbungV3ZIKL6IggNEwMaZF9prhjY2eYNuHuRRGKhe/dsaD+EpHdtoLp
 p57Of1T1PXbmwZ7unOUAT56IQt13lQggVtES7Io/s/nDSdb7ltnReusHbGxmfpfDgu2yHLZ7726
 SKWRv1vCtChq4DmyObzDibAL0FYGSnDLKF1GGxg9uihloCOAiC2bPHAS1A4YDU8/NZx11aZ4CXo
 k5KHN3UV8+PMiHyu/xpJPr/5OsawVCT9y+NcWp9X3wbyyzkmv06t4W1CPqfxMC8BpcxBfzZ
X-Received: by 2002:a05:6830:2119:b0:7cf:db63:e3dd with SMTP id
 46e09a7af769-7d1850e6218mr4313417a34.17.1769611790117; Wed, 28 Jan 2026
 06:49:50 -0800 (PST)
MIME-Version: 1.0
From: Sune Brian <briansune@gmail.com>
Date: Wed, 28 Jan 2026 22:49:37 +0800
X-Gm-Features: AZwV_QgD86Bva8n51jXJkSyL6d34lVoUoM3WKZNgaBWLyP00S_rbRkUrcaOEfRs
Message-ID: <CAN7C2SA4gFg8zxqs8aT4_ng9wTFLHdMO=C9b8LdtszMkcp0aWw@mail.gmail.com>
Subject: Re: [PATCH] arm: Remove rel.dyn from SPL linker scripts
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
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

Hi Tom,

The commits after c08da5d03c2a0b72e81a11ff7ca507e3a6414db3
All Cyclone V boards are unable to boot, not sure this patch is the fix?

Thanks,
Brian
