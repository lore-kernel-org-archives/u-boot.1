Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15B9C5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 17:28:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6B075812D8;
	Thu, 13 Aug 2026 17:28:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oEq9WTEqpvGq; Thu, 13 Aug 2026 17:28:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B6D26812D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786642124;
	bh=k/djHR2krUxbpB4UroYG4b0QXOBs/Nknr6tQ0LYiRTo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Sx0FodY7TTXvx8T372rHhKR6e7Ik3swZarR9oM7t0ocBwoR8rFNhNkRw7vbhNZSxW
	 sZXHTibrSaU5wnBwNlkX0wOhZicI7nNtZS2Chrj+60LIEhGaySS8sypfqzpHDP1UIv
	 2M1UYwWd4X6jbvse+6IrGXb2ZCR5FbqrArjLY/+KBMSTddt8qIQAc2khhZF1Tg6B40
	 FtKmnpFWhYta4ncRmMntqQOQbOyZ6wi5bQX+Ov7r1cnjEFSFIVwPWaVeYM7SVhhTm/
	 Xdkw6TBkTtgtMKlVJd8h4DrCn9cPMrcneL/0qi1OZwP5+qKoEKDOazFEkpPcnKjX+t
	 HTVFuKMqyrdLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B6D26812D1;
	Thu, 13 Aug 2026 17:28:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C9040194
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 17:28:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AEED84098A
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 17:28:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9roL3WzBm1ot for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 17:28:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D2A2340808
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D2A2340808
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D2A2340808
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 17:28:42 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7ebd88be784so121856a34.2
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 10:28:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786642122; x=1787246922;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=k/djHR2krUxbpB4UroYG4b0QXOBs/Nknr6tQ0LYiRTo=;
 b=sHitzPD9tW9AItpf166l28p5unMsw7J8H6JWqLb3BrfLnti6FEdtuCd/4NTEHp/CxE
 Tm6mqNIC+G5guzBhAtrTt4BOLz58i92lKUQb7F8iOR0RPlVBmDuoUYkoo3ZZL9B5paD9
 QtDwEBkqkuiNfbY+0XC1Im0XwIkTEbiW3KJfX2phXzjhQuv3U9MC2dc9wVDMEkXCmmB/
 kzPaaCyvAtLhKRR1GQZzx1Z3uc13JZB17yFlwSo9Kp8oQJZItwuKBa+ed+13IRyNrKp4
 5nUeCD13CxZ3Ik1SFF2WX0Kyl6MZOfAVx8hMV03wTV8YUsaGMfz8/lbe3yJzoqwLG4Qa
 aqxQ==
X-Gm-Message-State: AOJu0Yz4NFvu0cRv1DMYyrY+9UVIO6lm4EiDDAy/Szub4DP2WMIFxbwg
 8e5xNREs/quxPG9yc0XocxjBDYMI7LLDwFIJ2IkWXbD77LLsVQteAWfx8ZPwqlH+E8w=
X-Gm-Gg: AR+sD13SQJ3pNDnyNsn/lcEsL109nwJH8TlPz3xUMnmgjdcXiXRTw2e43IRbuHiI14q
 Mfx2zteMAgv1jFUQkoYvpRtj17EU9JR0qyfXfdgaW5sg/KdkYRmByIJerZmQS1cfVhJR7BhY5/e
 Yvce7nK848hfunNCpIzMpYvS0TnwAseJdUmice0l5qI3jeZ/ILdOgwSRbAnlfjYXfKk5cB3no8W
 Bf5JVMnwTE8TI9o+Mh92Z2wsN2tIk0ky5KgJRonfkurLZmXsD41DFmaRuMg9Nx1907Gm8y40m6C
 xNnluJlo9VWPDubsGyyISRuu0j588znHm8ULd13B5i5U+J0oW/JQyiMwr8p58znjE/O0kkC36Um
 Ell8GzC9eL+/eIOCtsN6i2iy5KQwVJnl4bQldJeHfBldVJRuG/bDpOBv9ybxcIviBfoFJb/fmf2
 /frHKVbhEbKDvVzLi0y9zadrCXqFh6NwB6+YIZ6LggndWs6KKxsOGrzvip21aj2G8UgluDKOPdY
 SW7JMZvNmYjLfauT6Lk9rypJyNGsrt020aSZfc1ikJueP0lMDnVUoy4pvdFLbLTzDLAjiA15gmZ
 j/qw4/R3
X-Received: by 2002:a05:6820:1ca2:b0:6aa:f2f9:b3ee with SMTP id
 006d021491bc7-6b0d5fa51ccmr138609eaf.6.1786642121564; 
 Thu, 13 Aug 2026 10:28:41 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b0c42b7c97sm2962754eaf.5.2026.08.13.10.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 10:28:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: u-boot@lists.u-boot-project.org, nd <nd@arm.com>
In-Reply-To: <a1ff3456-ba21-476c-a2ba-8bc68b14691e@arm.com>
References: <a1ff3456-ba21-476c-a2ba-8bc68b14691e@arm.com>
Subject: Re: Please pull net-20260813
Message-Id: <178664212087.3617045.16779080092307518560.b4-ty@konsulko.com>
Date: Thu, 13 Aug 2026 11:28:40 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786642122; x=1787246922;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k/djHR2krUxbpB4UroYG4b0QXOBs/Nknr6tQ0LYiRTo=;
 b=V/ZoNLCjyOqvZfy3aJIWHqZaLNCe8uTri9ZmPjtVKb4FZ5ZqQIqH/V8ohCOnmsXqNC
 X8sSmEYMqpgKsc/YY3yg8eATRwhjG/lSWpNzwhG4oaq3l+9MAEPcDp0+aiMF2+0BHB1y
 kN+CsPADGHZe39OED8Qo0h5VMt0xN8pZuLk1E=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=V/ZoNLCj
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Thu, 13 Aug 2026 15:49:55 +0200, Jerome Forissier wrote:

> The following changes since commit de02bc0eccb76aec8272abed651c35ab120f4844:
> 
>   Merge patch series "i3c: dw: fix slave device setup and probe issues" (2026-07-22 13:10:22 -0600)
> 
> are available in the Git repository at:
> 
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-net.git/ tags/net-20260813
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


