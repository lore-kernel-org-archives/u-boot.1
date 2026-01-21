Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C651C4450D
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 12:16:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55B8083B27;
	Wed, 21 Jan 2026 13:15:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XYrLvZ3r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0B0E8397D; Wed, 21 Jan 2026 09:50:46 +0100 (CET)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C587682A9E
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 09:50:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=anandhakrishnansasidharan@gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-81ed3e6b8e3so3046400b3a.2
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 00:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768985443; x=1769590243; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yB0wUuaq0RWtLgJ8qgjk98fkfDQWfm9o/LL02HvdE4s=;
 b=XYrLvZ3r70giZ+L7szK/NcbiVTb722bEokZjwbprB5J9Srx2UAYwzddSqk8RSL41oz
 97aqc4SSBCqcwuiazEBOSkvV7Mx2tGZgz2f+UwLKDFIFWoL0xmzefKorrxvd0WIFIhw4
 z9ktrOr6dLb2RddAyZ4+Rt7gb4XEVpop9HM0yPBEoSI9LHSAoMR6DXtro+099a39SWyT
 c1JYGh2SH+2fQaPl0TDdAzXguUJ+TrWW6ll6kCsigntBfOwMSBPSreYlycGS+2he69C7
 JdRKabkuUeWesPRxu0eW++CrOAfqcbCveXQqCZz2nXDEQDtxGu38SlXSZB/qeiSt+XvR
 SqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768985443; x=1769590243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yB0wUuaq0RWtLgJ8qgjk98fkfDQWfm9o/LL02HvdE4s=;
 b=UKgx/RC7RYp0zqqVbRwFtEeGLuJg36iZwK8TX4prX501vBC/3S/lbljBlE0feBHybv
 jE5EPHYSxw8GgbSPHPW0tHLED2McC1GzpYp8wlKftCi0eDEBg6Azlt31KEUMUY0ZeQqd
 +aGHfh7f9IVUHaTYh4NAK+13yewpNF/mToxIaCaAqzVIgrEhu95/yCKxkejJ2d/DRo5q
 663dWEJrdEZB3LH3Oeu7PjIXfoGiG2zJMwLvMKSot+s0dWS+5+V39/6fFP3k61JfpA/f
 +kFeF33PauTJEByEUwnZE6i7+yyxhjTYVrIM06SxB4h2r9KridnEA5/Rf0P8PyNNXA//
 ui3g==
X-Gm-Message-State: AOJu0YxKNtGffKJ/GoeK4wCe6N7lSh304r01sradnnOn1HIF4PyqyZuj
 x9Qg6nbGmzrzO3umzlsoxZ4XjkiqmlrnOg8zsy3r2f6GmoVk+CY6xgGK24sWSw==
X-Gm-Gg: AZuq6aLc6OrCcUIjJq20PJAtCtX/pwy/x2aBs7Fr1V7UweYdpfH1J/lDyPSP8eGZM7J
 1NO4lIeUEp5hp57T19AQi2j7Kt3mc92LTERpwIpcQqiBrbb26gvA1yAUcVaOhUmtt5wwMzEuE05
 6JM2aeMe6IJTt2pUcHN/WnTAGMnM1G1BScmWHd6uhRqC+uhKckzoUCd/OWjrHZu3s2uDVt/OeJs
 pGCu6XTJuBc8ACvmgc+toROC/gMgj9Ir6pACoAF8UQBwhvkwhWhG6f/2JRBe4/m74sSF/s8jONf
 +006W/ck15BGqcbFmzBXOMe9O01Keig61bo5B9PYnG7xzaSCUuhd99xMGw69TgC66KceUZUYh4v
 hdNnC39Az3/LsjQryXYOBVlL3kS/9h/xhdeH2LaB+VzpVSm1AL+s8b4zlb25/ESK69DDEmJQLSM
 v009/8cixXmTDjbnFJEufiEhxxAqV+rPiEuK/PAdy5
X-Received: by 2002:a05:6a20:3c89:b0:38d:ebdc:3546 with SMTP id
 adf61e73a8af0-38e00bba1f6mr15551663637.6.1768985443070; 
 Wed, 21 Jan 2026 00:50:43 -0800 (PST)
Received: from localhost.localdomain ([115.245.213.202])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c5edf264b9csm13631794a12.15.2026.01.21.00.50.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 00:50:42 -0800 (PST)
From: ANANDHAKRISHNAN S <anandhakrishnansasidharan@gmail.com>
X-Google-Original-From: ANANDHAKRISHNAN S <anandhakrishnan.s@dicortech.com>
To: u-boot@lists.denx.de
Cc: bmeng.cn@gmail.com, marex@denx.de, trini@konsulko.com,
 ANANDHAKRISHNAN S <anandhakrishnan.s@dicortech.com>
Subject: Re: [PATCH] usb: xhci: fix DMA address corruption in abort_td
Date: Wed, 21 Jan 2026 14:20:01 +0530
Message-Id: <20260121085001.405127-1-anandhakrishnan.s@dicortech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260120145055.233298-1-anandhakrishnan.s@dicortech.com>
References: <20260120145055.233298-1-anandhakrishnan.s@dicortech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 21 Jan 2026 13:15:54 +0100
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

On Tue, Jan 20, 2026 at 23:43:46 +0100, Marek Vasut wrote:

> reset_ep() seems to have the same problem ?

Yes,it follows the same pattern of OR-ing the cycle state into the virtual 
enqueue pointer before translation. I’ll audit that path and include a 
corresponding fix so the cycle bit is applied only after converting to 
a DMA address, consistent with the change here.

> cycle_state is already either 0 or 1, isn't it ?

Yes, `ring->cycle_state` is indeed either 0 or 1. The intent of the explicit
masking was to make it clear that the cycle bit is applied only to the
*physical* address returned by xhci_trb_virt_to_dma(), and not to the
virtual TRB pointer itself, which was the root cause of the corruption.
I agree this can be simplified stylistically, and I can fold it into a
more compact expression in a v2.

I’m happy to change this to:

    addr = (addr & ~0x1ULL) | ring->cycle_state;

I’ll send a v2 addressing both points.

Thanks,
Anandhakrishnan S

