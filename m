Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96048C83F22
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 17:21:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 477B48312E;
	Tue, 15 Jul 2025 19:20:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mG4hWnBJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 128A083096; Tue, 15 Jul 2025 19:20:30 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 091CD8309D
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 19:20:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-73e5523ef8fso444745a34.1
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 10:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752600027; x=1753204827; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/nw5n8ngRQJR/u99rINFlAOxhmq2NYS9xGoV0Ght8UY=;
 b=mG4hWnBJEDGOxapxRgQCVDCvhLa5rZAhky4sNrP+a4lRq09tsXIPBH+JlziURV3TU1
 Cy5pJnHw768n+xdGm4cBGrZqPZzOrSR+3+1FTLFmMHd1H++pHhEznLVB7m9zc75xrl0P
 nWe1daPAwWR8WrRsmdOVtR0FxYuSvOkmEQLFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752600027; x=1753204827;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/nw5n8ngRQJR/u99rINFlAOxhmq2NYS9xGoV0Ght8UY=;
 b=D4fGXw6o2p0DONFCfLgu+67Pia4expXoHYz0auHTllovMobZdyI9LPN3qMC9cwJ1D9
 wjJxhP1gg/AxRbrcS0tDw/57EtxfKtFKcZntcuJpaZInh4JgxwabPR3xXZqGdpKuBBJm
 8UR1FKD1+7HxwiTV2+FV6xNov2g5XucXIBaSLmdgQk5JkhmdG9ji+QO6kMHiB6BUVNUC
 rmXnP0mj9MRUSgDxQ5ckAnj83K4sf9oNHRZ+wMQ6y0+8uqFtNrCAdKhGUHVKLcmT7QLI
 1YiBp9bup0fZycLiwycbNMKfol+byhSoRKSR5KhIc9MZNgW/5tDtbmtg+fJIG+uvciMw
 PKeQ==
X-Gm-Message-State: AOJu0YzMXa5DW8VHoDZzP2DXtnkxSRf+uNuFB2+N3lxRmbJ6+HXGWz7v
 b/HsVlTbNW+xXfmBS1Gb/PQzDgWa1bCn2d1W47SROp49btnrS2fJYYaeG4nezg51jt6I6hfmpkO
 nA2CXMCo=
X-Gm-Gg: ASbGncuR7BK3WIjDZkusKvJA9OP9LDRwVbx6I9LAKKIL8XyFbq3N4Da+QofjiPDxUQ4
 TizgLCmRz93GTEdCc7sHJZ10MOUghukWs1BDpz3QXgqICU+VLVQahNW+Rxt7HKSRaGd1QeMkNlQ
 F+FOYfsq7Ex7Bs99SWLBWXAJU083JjZUMCZK0c9ZLozIwgOcvZfsaugXZnQ2B3rnpLQ0c9Ui4wk
 QKP80s58MUkbd/dP1lAuloOUTdVSoL8JFcqRWAbaAvEnsY4uNBb4t9nIMdiabd9iImGyIIVIY6F
 /BXYJUFnqsCmzZr5l7laLp/msh2qh/smiYsb/MBWVojsmdbPfElx8IyeO7VRSBeuy7sCdtIiqvg
 iSUs04YykBNISQZl+66kzoQPF9JLjydLAAzZ7eh8CEdVk9T/PWDg7yk0=
X-Google-Smtp-Source: AGHT+IFUdpdKEnEfwgQYmZ+64rpBLO7HO+VXVeMoTyz8TO602FV709GsegRzlw4p6Yz+ontgrJ0YIQ==
X-Received: by 2002:a05:6830:4391:b0:727:3111:1416 with SMTP id
 46e09a7af769-73e64acde39mr209700a34.24.1752600026699; 
 Tue, 15 Jul 2025 10:20:26 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6142b0961fbsm988894eaf.35.2025.07.15.10.20.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 10:20:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20250710072345.3458823-1-stefan.roese@mailbox.org>
References: <20250710072345.3458823-1-stefan.roese@mailbox.org>
Subject: Re: [PATCH] MAINTAINERS: Update email of Stefan Roese
Message-Id: <175260002607.441891.15135250829804206404.b4-ty@konsulko.com>
Date: Tue, 15 Jul 2025 11:20:26 -0600
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

On Thu, 10 Jul 2025 09:23:44 +0200, Stefan Roese wrote:

> Use the @mailbox.org mail address also for community work.
> 
> 

Applied to u-boot/master, thanks!

[1/1] MAINTAINERS: Update email of Stefan Roese
      commit: bcc7bc69b92ab728790aea0d08b2ae5e22d3b09d
-- 
Tom


