Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4EC1109E522
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 23:06:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63F5183FD9;
	Thu, 26 Mar 2026 00:06:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BYC8E3K1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55E2F83FBC; Thu, 26 Mar 2026 00:05:55 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F71783EAC
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 00:05:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-467fd082ffeso222611b6e.1
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 16:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774479952; x=1775084752; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9QUiKUhiThVLFRzC34L8qOwINhNEIVh/8r6XlP/gky8=;
 b=BYC8E3K1TEuPO47c8luaVVR8CQTtefx/pmDVYW8ggSAAMgq00gATzABKlR67tmIa+a
 U2HtpEDi6AtseZoElQ8PgrWmBUzXWJooPgfAIDlJS777/iDNcNrvAuedfvLCsV9xisvs
 QHlPkn5CaVYmZAYYBWsurtrlEYJYf0QExuPX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774479952; x=1775084752;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9QUiKUhiThVLFRzC34L8qOwINhNEIVh/8r6XlP/gky8=;
 b=EJVMTTpRAvxbXyhpnKAT7iewLkmz6IyVjTZZvf14dsRJESWsu9w/soiXKDeYCtrWXI
 VlAVXR1V73lCLYcXN5L9hBOveiCi/1ox+AQq7rVcSC0NiGX9z8b3vrbGtuBVU58NNNlZ
 ucoPIKJIB/KnOEMHgsWfoi2Z118m0oW6yA2hMKlkqZk/apkC8F5B1f9hgRxhCRTNffms
 IFgmUK2Vys66XC6GSLZw1q3qaZs6zHutR+vcyc9zbkR/yTrhicN+tRE17LF8T5kNbl2b
 ethFADWsn0A3oFfd0WPVuwBvAte6OY09nbNLiTM5VUinTVny6GApxfJ3eYT8WUO0b3Dj
 LP9g==
X-Gm-Message-State: AOJu0Ywh33cqMJkZpwRCPln0fj8TELPcVl8UdTekfDpaRav5morJCumX
 9VeOejxv586AiIJFGL25Yae4Gd18AIS7fghUw8d6tsFDxREIWsFQkIk1dmEQTHsW3TNw4UgL29T
 opf8PMxg=
X-Gm-Gg: ATEYQzxzMGORCdZTL8PJNKlCtph+rIIWKzd/U+o1oExJ/zYgEcOtS+Qy+CPmrDSIdTD
 LyolMoiW+MpQ6yRjKjoIffQOFIBhCdQLsH6GvudiOrRKm7L6G87q9JzpfNGzgzDxILLvmLwp+o1
 MTwy4bbPm2zE6ggsk+9XccvAOLsIPzPWAX8HmNHNFA9LgJeUrz8Kgs7QVU4r8bj8PhOTyflVy7e
 iR323/XhTWSM0NIhU6liz3xNOjsLZaSkDID2krXGa1OVBXoWW3W2DaWdlP+M+nNUIF/ectu2q4C
 6rrYCO8o5VKoXokdvbuAzZlXJRqmGN8o41ShrZJ6tgBPQaVW9eGN/OYAcnRBSZUoonYrp3lw1oD
 lAtnvZRk8RoYNo7ZTpn0Xlwday0tqKxPPWt/hsO+nhB5EKHg3McjpLM9ZFmtasFdHGXQZ43I5ax
 tdQjaSa5oa0LWbW2s0HRt9ZDLpzwjtgLdZ6JX8RPRxPc9uWDrgL9ItBIYTx7IZs89kgBUdHQ5yP
 BkxkEQlG51/3bU/Cn1Lcx2L++DdmaS7H7PiXu1p0LSi/7k=
X-Received: by 2002:a05:6808:152b:b0:467:1376:1cde with SMTP id
 5614622812f47-46a5c69ba0fmr2373686b6e.17.1774479951926; 
 Wed, 25 Mar 2026 16:05:51 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46a7099df08sm581446b6e.15.2026.03.25.16.05.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 16:05:51 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: =?utf-8?q?Christian_P=C3=B6tzsch?= <christian.poetzsch@kernkonzept.com>, 
 Adam Lackorzynski <adam@l4re.org>
In-Reply-To: <20260310141642.1122025-1-trini@konsulko.com>
References: <aZR0WCHAC6KaJfH1@kernkonzept.com>
 <20260310141642.1122025-1-trini@konsulko.com>
Subject: Re: [PATCH v2] virtio: Fix virtio initialization sequence
Message-Id: <177447995084.3508238.16173778567676335155.b4-ty@konsulko.com>
Date: Wed, 25 Mar 2026 17:05:50 -0600
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

On Tue, 10 Mar 2026 08:16:42 -0600, Tom Rini wrote:

> The virtio spec clearly states in "3.1.1 Driver Requirements: Device
> Initialization" the sequence a client has to follow after device reset.
> Because u-boot resets here again, it also needs to set the "acknowledge"
> bit again even if this was done in virtio_uclass_child_post_bind already
> once before.
> 
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] virtio: Fix virtio initialization sequence
      commit: 30e1733297ac7d9703bd0950bd237648dcb41850
-- 
Tom


