Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F906C5DF97
	for <u-boot@archiver.kernel.org>; Sat, 22 Aug 2026 15:21:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C186960730;
	Sat, 22 Aug 2026 15:21:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xHMzD-0xfB6G; Sat, 22 Aug 2026 15:21:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787412113;
	bh=OBOdP9h6Nw0Rhfn2zPEg4oODKOWH61I0LLb0KE+VvAY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y91DFoK0svmPY92d4KXzOzYJyKuMO+lY4h6PhPDiPMJ11yh7T8l0PppYDXKVAQVuF
	 NsTYbHANwTReLDc6T65omPRlbGGDmgmb4q/KNrZKQMmjv3TBEE/Sr7YOzDPaWAN5Vj
	 j2AnqAYqF4sz739enMbCMgXXFMCheQourzAdCr8Wq5uZyvfBNRNoyHh2/hcckxUQzj
	 Svdhqxbi3ljsPR7E9rwqjlPw08/V2/zRnx3g1l1poTDDRxLC1SPpgXf1fdOxImJov9
	 PcczkbagEMTCIhOilcI13hSBKXN+TSqcCl2bOBsXm0FBrtxkjuASPosYJ+YdS7uZFZ
	 UetB/V7QfAa8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0A9EA6069A;
	Sat, 22 Aug 2026 15:21:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8AF40336
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 15:21:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7CFFF80F68
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 15:21:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9lPcS2XthFgN for <u-boot@lists.u-boot-project.org>;
 Sat, 22 Aug 2026 15:21:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2c; helo=mail-oa1-x2c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=D8vBkwB+
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 925F180F70
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 15:21:47 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-448b0ff4a57so2762383fac.2
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 08:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787412106; x=1788016906;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OBOdP9h6Nw0Rhfn2zPEg4oODKOWH61I0LLb0KE+VvAY=;
 b=D8vBkwB+DdWllfm44iyX8olTxsrCizD2I+7GsSOKv5isJFHQOM3hoQMy1SNxnWyPwG
 +te379RHHJ3Rbkaz9U0mrBtecYLX6/laFrwXd+5HZE1DmjIFASKw1CpbJijT1ahJb1RJ
 Of2eoET+dW0mYrN7iBrVPiScGwz8TQ/C1U13s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787412106; x=1788016906;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OBOdP9h6Nw0Rhfn2zPEg4oODKOWH61I0LLb0KE+VvAY=;
 b=akgksd/YxTx8O31y486ezgPdaLoDQSK3nBRNWoCaeq1y9x1uzR/8wboRV0JFDSDFwm
 kNI88AO5aXHDNp4iPT2Vr9rHGslWZXFsoQyu6TSxn8G9A4mbrPSMJnHrga4foCxvmOww
 bE3MmaXMCiUWAK7pFe9pcGORS2f8yOUyNx6bvKIDrwWYI3iegRkC11XstJK/2GNZIcGu
 SmE4Q2KgbRluMtu1YB8yvg10/OoOyloip5OzM/b/6D229Zp/0YcqfIttN3dpsYm6wdtW
 4y1g6aPyM+7Bn3Sc8yHX/gVsgLZn0Nd1vkiw9c2P7Q0Vfd9H4iU95ye5A2w+o5HRZEbG
 irkw==
X-Gm-Message-State: AFuF++kg86cd8HOGaRKAO1i5gvH1QDcUKdgRABtFV7+es6VXCF17tAKi
 apP/mREWVzJmHSZ3m6/64uSO1CHmXhS2667qG6TgwSA23tqRMh56Q0VlTlSOYphxXgYRWPXKSF1
 IFnU/UJeFlUlp
X-Gm-Gg: AR+sD12gO8wnqPvVNZB7BtfG21QAO/jUXByRx2uAF3O4Atu0ofHW/Nkk11kb0aZco2K
 TeASXibkNKGI6qo1YtSPnGDaD0/X42HWeDbV0c995RES7c9+nNaIUtv7ZHUptH6ovrjICDgvASD
 Z2rvfOEmoeLyFKzrvFatMUFSpOtHdNuHZ4DcsrnR2Tavu41DOoMyt9qHSjV9QdH9gqnNMQ9Nlab
 rvVc47UgWqolH0bToqHEgO9dvLY9liBu2GioaaT+f4PjZ1ZoewBn7FJbzSu4XhZVWsEKvB85jFN
 AslIIAFlXlOwElEmhS0Eh2jj8ZiPYZxWlVxd7O4mG0M1LpWu5lv1aR79LlvvAiNpBO5MPfkWAjH
 BW8qHdlcmuUTas5PnAlY7Zu0LUJrTT6k+uUu1FV+rZpml399+t25PBtNSQ6J1t0mfna7I/Rstje
 Qz4Kh3ismlwgTojRFsW5ocjUMHt46d35l/JlwAfRlqD5IMQd47tYGMGC1MwRbpvyxbrmI81eOT8
 RTxZAta+wX2rcRxdq9YcQNxSKeytRetqPwu9w4dL7eEFM5vnlgFaTEKyIG10bm/Zr9BtZFuLSmC
 1zsuTpaHmn4DKpyLiB/O
X-Received: by 2002:a05:6808:4f4f:b0:4b2:e95f:380d with SMTP id
 5614622812f47-4b2ef1f94a0mr15876591b6e.6.1787412106248; 
 Sat, 22 Aug 2026 08:21:46 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2d6cdd6cbsm7345983b6e.10.2026.08.22.08.21.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 08:21:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260821200726.3903737-1-trini@konsulko.com>
References: <20260821200726.3903737-1-trini@konsulko.com>
Subject: Re: [PATCH] MAINTAINERS: Drop reference to non-existent
 drivers/sysinfo/gxp.h
Message-Id: <178741210546.4158046.13098847819620968525.b4-ty@konsulko.com>
Date: Sat, 22 Aug 2026 09:21:45 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 21 Aug 2026 14:07:26 -0600, Tom Rini wrote:

> The file in question was never added when the driver was added, and
> isn't required. Remove this line.
> 
> 

Applied to u-boot/next, thanks!

[1/1] MAINTAINERS: Drop reference to non-existent drivers/sysinfo/gxp.h
      commit: 1454960a7f3e836794dd9bd2e9e52361ce6fd682
-- 
Tom


