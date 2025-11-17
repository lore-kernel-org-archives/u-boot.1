Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 678F3CE8D6B
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 10:49:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFC0183A79;
	Mon, 17 Nov 2025 11:49:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cV7CtOGC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AC6D83B43; Mon, 17 Nov 2025 11:49:47 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A4E58397A
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 11:49:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-429c82bf86bso2320666f8f.1
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 02:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763376583; x=1763981383; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NMl0TKG/R59XYqrbFqGR2atFb3oteqxzXaweAtZlps8=;
 b=cV7CtOGCurQop0VscBwyRlhbr/PCThPFoFnLYeLZNchpOn0x/fJc7hh3eZ56HI9bxC
 ijtIJ5VKbFbVFPaiAO3zSyIH7Du3Y0ggul1YhmLiqMWEviRKdSXe7+GR+LUI+XmDbBqb
 rsWxwdR7R9AfJ7vd2HfSUp0aSYwbBpQdo2xCKfFdRIJVbhPVD/ZBkxBcE36PeJ8l+yK+
 32yOciOokHsNYwezBG/Z/T9fSIFj2KrU4agStXpUhwdMIRapKz2VTxY29y4/ACPWOaxi
 UilCg36gcv/2dpVDHuLah8fV1uVNNaZlPvu/lq33NhoICOrXLdmtYI5CXOj2/L5TBVmU
 ttiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763376583; x=1763981383;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NMl0TKG/R59XYqrbFqGR2atFb3oteqxzXaweAtZlps8=;
 b=WrrKt5g5bnrEI3EjN6C7sptRnNjjSjByggWoMcM1dAwpao9LvnISMfs77HCD8hjVOo
 4AoITK6qU85wVHnnIew0oicQgcugZopgdH7o/SJ7vHJP2b/fLPlsej5AiyASt/BAFQyI
 X0l+4PN8ZxvJvJpUcwb8iCwqgnrpMGBHHqtppuoh81wNZ5958C0as+hJkag9nvOR9NCc
 qsQfo3qU/7mf1Rw3b9uWEOFKttPXnABVbQ0jSX5ZfKEA31dGCQDYU89wIM0IGL8jehxR
 xKHm9cat2lRt5ji6IHiJrzAy3CWssvDuj4bIzncwg9l1Je5MDY2SbyOhUESaTSCYcoBn
 22xg==
X-Gm-Message-State: AOJu0YyQQ1GClW5SFJKwRdWy1BfgfEm/01KT8MFHfLuCxqf0JsZX/SnG
 nLvCm0Jq5ZKANsHbj9ofqtYtBuaSJe0E63jYDun+Yw/9+5bZmvYqFNCU41f77HidCWk=
X-Gm-Gg: ASbGnctSlXuk4UruqzuYa8Cs0ZPQ7H3KEgYnt+pMyTh2rZxXXpEU0rRrFCBfStdgx7K
 FJtAKQw34+7WojnBRXOtct3w95BPTaEJDEmAwPPFhny4ruDFhEwRyu3BCIfoYBacRcDcfzQV5TK
 9LjRWYBzoPCLSVooXCWGbgU2+w8cp+vlQoD6aTvMZ2Yto/BHjWsXXGpKCIIEMQEhZqKPy+E7F6B
 1+/XHNBa0n0cZLy7VwCajvX+SHC9llTU74/Hy+NNzIEfF8hNEWr9UWGk7UgiG49OzoHlM7ZKMT5
 DA1dYvrpkb5GhNA9U0ZTLXGj0iuP2rn7fVQSAML/el2TrEoV2ozYGNV05sBHxfF8JoAs3fSmlJl
 mH8c2dP9HQdREtFS1Ln2iMMiCR6nM+pk1JxhEELaFjpd9zT1vCGWFZfTjBXRAMpwSEX2/RZdu7+
 den4tPcOldI9ZnH2AAW8kY
X-Google-Smtp-Source: AGHT+IGzcyt8SwFZ4scWDWsqn7FOxZV1hAqsZJuqi0WJbI6oUYRkF2ikA9EtpLs6ryRWIg1jxZf7Tg==
X-Received: by 2002:a05:6000:2893:b0:42b:3806:2bb5 with SMTP id
 ffacd0b85a97d-42b5933915amr11819491f8f.12.1763376583465; 
 Mon, 17 Nov 2025 02:49:43 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42c97745f79sm11422514f8f.23.2025.11.17.02.49.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 02:49:42 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Tuyen Dang <tuyen.dang.xa@renesas.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20251029201435.215966-1-marek.vasut+renesas@mailbox.org>
References: <20251029201435.215966-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] ufs: Keep Makefile and Kconfig sorted one more time
Message-Id: <176337658261.3830363.8241027223111268361.b4-ty@linaro.org>
Date: Mon, 17 Nov 2025 11:49:42 +0100
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

Hi,

On Wed, 29 Oct 2025 21:14:10 +0100, Marek Vasut wrote:
> Sort the Makefile and Kconfig alphabetically again. No functional change.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-ufs (master)

[1/1] ufs: Keep Makefile and Kconfig sorted one more time
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/65c843ebe515aa56f4526f91c37268e07a42b00c

-- 
Neil

