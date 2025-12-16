Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB69ED637D6
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 21:53:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14787839FA;
	Tue, 16 Dec 2025 22:53:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bl/Vyf2F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F067F83A24; Tue, 16 Dec 2025 22:53:34 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D34A98334F
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 22:53:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-4507605e19aso3264890b6e.2
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 13:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765922011; x=1766526811; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pc6f4jIArSVY5iafk3D8HrlM5IQD8WcxzTSLoSjbkTM=;
 b=bl/Vyf2FKE4Q0s9YT9Cz4KYZos9pe1sTxkg/izsa9YloqckxLy9CsG+TOlJ9wsOwly
 WSL3PLBL7r1gJHEESEp6KVxFVKoqpR88RsnTUugONFx1DrEdolH8kxZ4Kc2Yfyk7lflt
 qLbA96cDwa4Ujs/LJ9pK3f2zQ1NHEEt8a5IoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765922011; x=1766526811;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pc6f4jIArSVY5iafk3D8HrlM5IQD8WcxzTSLoSjbkTM=;
 b=ZLBKt0hfDS/z/2GvSDUUl7hRKDlcm+WonUsWmDiUp/cJ/z8KFaKwoeo8M18rm70vA5
 SuHtYOf+h2ozezf9GU7u47ArCBCX5CFwQ7HMfxBuPjyKcB/cLoFUk042aLTAEcxtjnjt
 SLDOee2R6DtwK09Gx+rfgrURhydXUDt+MC85juGZfDnWB2hNCiMvrg/6R+u95bG8hXfi
 +VjegKhCnB+SCtWAmXdknmDctcuYqdMEaTKGzwvvIpytjHTRaPUevxxzV6fwE+62Ew0N
 MbWX82r53WejugEe8n+Vu/eh97Kdd9CEZWrAp5Xf5jZwp0sWt8ULwmEaEsPBmKrN/Uoc
 TOwA==
X-Gm-Message-State: AOJu0Ywg2E4g5nbCFdv4BagslLf8DM2Wur0daqC4vc6NuYRrX6sdktDt
 kyxn7o4Oo5R9sxLu17e+XkHc2qXWkXo1w4n4x67C6xf1DavUoibAhgJAkD2zQ7vlJVI=
X-Gm-Gg: AY/fxX7Ha6CltrqlT2Ijk+oIj/vpR0OpRrwD+5UADl9ppr0NDxXuemvs/8Hy+Onwu9h
 ReMMTdBMG78ySLqTbmeFoQYnQ923dMnLH5jRm28xJ3ngtpp9Gq9fJi155UCazaxgwo6l627OjBx
 ACa6izsrzJ3weeKPVh7E0x3+ilZO4Yei3CUHjdTeHQl14IlOz+RLaPbcet4rdwJPzPjq58oSsES
 TbVFKCtw9jFkjyofVUU2cUIwvAnQnASgvzX8c05jxDq5lBT4UTUOeUm7VN98sO7ZuAdV/gsHSFt
 u9QiXIPsufNjWG24s5WDUKeRb+qqQC4CrLNsMWZS31pJvKg2awbWaqIZ1z3GxaMy0C1CA7oKxjr
 UC6neH1Lp5RTw3Lu84xiLmQahj8b/CA66TLGzGYYm+8rctfkn9qXjTTjjedVRKPPwWW3Ijj1rr+
 n0zLv02aKMuE5DBx4F5mWXvPNzTBs8vP5yDBoUm2qLWWAKcTci
X-Google-Smtp-Source: AGHT+IHRARvFGHEztgZCNq0kibOBwu7pomMMbH/2YFtSi5Bo86ITRdqw51TKnwDqah8RBUnuHKk1Fw==
X-Received: by 2002:a05:6808:2128:b0:450:ac57:48a7 with SMTP id
 5614622812f47-455ac98ae3bmr7620308b6e.59.1765922011624; 
 Tue, 16 Dec 2025 13:53:31 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45598b9966dsm8814255b6e.9.2025.12.16.13.53.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 13:53:31 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Paresh Bhagat <p-bhagat@ti.com>
Cc: praneeth@ti.com, vigneshr@ti.com, v-singh1@ti.com, khasim@ti.com, 
 afd@ti.com, anshuld@ti.com
In-Reply-To: <20251128110210.4143342-1-p-bhagat@ti.com>
References: <20251128110210.4143342-1-p-bhagat@ti.com>
Subject: Re: [PATCH] arm: dts: k3-am62d-evm-binman: Update DM
Message-Id: <176592201046.2225391.10482039167593181332.b4-ty@konsulko.com>
Date: Tue, 16 Dec 2025 15:53:30 -0600
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

On Fri, 28 Nov 2025 16:32:10 +0530, Paresh Bhagat wrote:

> AM62d previously reused the AM62a DM. Since a dedicated DM is now
> available, migrate to device specific DM.
> 
> 

Applied to u-boot/next, thanks!

[1/1] arm: dts: k3-am62d-evm-binman: Update DM
      commit: 87c0e413eb4077766eb9205fd73fa2e14ac0e053
-- 
Tom


