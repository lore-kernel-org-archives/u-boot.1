Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2516DE8B365
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 21:12:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A75F83DCB;
	Tue,  3 Feb 2026 22:12:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YknVaxt6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8409683DC9; Tue,  3 Feb 2026 22:12:34 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A1A183DA7
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 22:12:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-408199852c5so5098407fac.0
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 13:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770153151; x=1770757951; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x3T4Lx0A0bbXcK60ZoTdwFVO3KcN+6osq0lochLSS6w=;
 b=YknVaxt6Ma18QLTejts7495fzlOV3ZRM93Ars3i1dPxg+VR9f8O0ObDxWcs6tvAAAp
 xziSWqcbazBrdYP9YLNyu5ZvKA+XMpFXfT1AV9pl36IDd0qwxluOyJ3jByl/kF6M66Rm
 Qospis5f5IjgCjF7XvWmWdbcdjYaEdCGrS4nY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770153151; x=1770757951;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x3T4Lx0A0bbXcK60ZoTdwFVO3KcN+6osq0lochLSS6w=;
 b=ITh11h+VfnjTsZGj2crxe6y4adrRT3hlgrKZyWKK2UuPezRM0ExAkBymcYATtqaNNu
 e7u+4nGV5o4v5He4kluX8tima9FUz+ciZEYuDA5DjKAkiZd6UG6PhiCmzXqQjMPaf1S/
 wqjxW+wi46tf8UlH7CyCGbHmV9bzds2eS4AQ9+hIegSXc0IAVJoQIAbCtDPQiDOLB4pM
 5NhbBgo4HLlGDHrYiIpxHcW5Iq29t+vuPmOPWc8txnVDCgoISJbOaDi0iM3Qa5uwu1DM
 xCCrEKdcJfSicFaRFRSdl6xOuxo/XXUdAl6jv/ToRFCyvPR8MIjJ+o4Iqqq5jtnsSkeX
 FYOg==
X-Gm-Message-State: AOJu0Yzx7qubT+aIMTo6h+2Rdf+tLu8nlTcnc1knZ0YNbtO1SdM2o19Q
 jJOBBIaKcFrW6N6WxwPy5lmGFexEv06aZeg6MBDVujyhwozp4XR3MTopqHXq6QG1jng=
X-Gm-Gg: AZuq6aKg8E/B0IfYv8BLezzDKsHH7FBci0GItO3vmKHlg8z5MjeArg7U+PMqZl4ophG
 Vfroo2OWSKTbHrY25jwjk037QRHk8pyaFIrTkSOYTxwjT52InvofF7gMWmLZs3ocSrQR0U3uLRy
 nmwKzxU2oLWcYCMZNEZRYJIXR2c9+jwYX2Y21aNxtWUJ2U5OnURowLiGfvaDVhr0zCyUwdtemFp
 h32EwihYkv3Wqe2+YX5TQSJ8K2YEVrxYEUab3SlaeAJON4ltSMpM3nve0FI/nvb+PyU0CPCbixs
 8Wd+tZvHedo649fKxRZSmXK/p5WuFAURWyyITQzPrQiRnFsMwO6VAfzWWX6XCu33wbZdhKQXrVR
 bfGO/25FPYi4XxYKEO1LbVC7Lpqb7WuN9Bi0izNo/jpEO/8vHMy5DtFSITHLQyEfqWdHGrzXlO+
 qCwzpYctYn/zeGysP80poBuzKRmRXBaozgE3Qi7bLlNCWfgZgKnqSJjcqy/s/QrjSCUYMv2Pc08
 RST7xUfYLi2M1MNCgojaQH1OmRZpvej7TZwyg==
X-Received: by 2002:a05:6820:8188:b0:65d:22b:416f with SMTP id
 006d021491bc7-66a2371c3f1mr516818eaf.65.1770153151155; 
 Tue, 03 Feb 2026 13:12:31 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66a35f7a4besm324630eaf.17.2026.02.03.13.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 13:12:30 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Shiji Yang <yangshiji66@outlook.com>
Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
In-Reply-To: <OSBPR01MB167018BE339065B656265691BC59A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
References: <OSBPR01MB167018BE339065B656265691BC59A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
Subject: Re: [PATCH] mips: mtmips: do not select PINCONF Kconfig symbol for
 MT7620
Message-Id: <177015315040.1503561.15738564559356010999.b4-ty@konsulko.com>
Date: Tue, 03 Feb 2026 15:12:30 -0600
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

On Fri, 25 Jul 2025 08:37:42 +0800, Shiji Yang wrote:

> Mediatek MT7620 u-boot does not have PINCONF implementation.
> 
> 

Applied to u-boot/master, thanks!

[1/1] mips: mtmips: do not select PINCONF Kconfig symbol for MT7620
      commit: 00618f72126eace8f291eb3d15b337b891be4055
-- 
Tom


