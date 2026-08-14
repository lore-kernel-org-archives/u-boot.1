Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF9EC5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 13:51:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C36E140DBF;
	Fri, 14 Aug 2026 13:51:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sj5R0H9A-S19; Fri, 14 Aug 2026 13:51:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E786140DA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786715479;
	bh=mr3zFi7r8Fc3VNVqeDTWqIBq0B/lqOhkhiXVmRxFAM4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bPVoFm1LmZrc6YYThZiuC5pbdNlQSNyGDCCDOmaJW0zxE+0hBxM98OZrLGtvM0XIt
	 b4d6hYeJFYba/BfxLd/pDRS0aM+yRBCGQuHeu8FWwkCkDMlSOYdfK29QDOcj0FvUbY
	 dIiIZw6U1NcRwjvlXbhV+8RHayBfRy38kTXAOpoHa5sMVXm+c/1MHIX0VVHTCb4P98
	 C98gCIzk3zctBpi83fl2II/rBJW36s+WY5pWezXpTaBckkjA85OAnHqZfnENwocgsG
	 LsPmsw6/o5QHBhinlc47TXSrZu0GnDU0DydRf6QV2d6BBAWacsSs6t5cEbUhYtshm6
	 ZcF8wdOCdp7XQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E786140DA9;
	Fri, 14 Aug 2026 13:51:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F3EE2361
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 13:51:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F172B40D4D
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 13:51:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b7YzrhK1OHnr for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 13:51:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32b; helo=mail-ot1-x32b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2CC0A40D31
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2CC0A40D31
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=U6NILWGx
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2CC0A40D31
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 13:51:12 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7e9eaf04bfaso446513a34.1
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 06:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786715471; x=1787320271;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mr3zFi7r8Fc3VNVqeDTWqIBq0B/lqOhkhiXVmRxFAM4=;
 b=U6NILWGxB1kNn03DxYU8lpJjwiPOmcusQEY0KkUoRiDIJmMG2xrZN73nfZRzC5QS3M
 h0ZvU+ZPEjOOSbVO/ThwdEAMFUBgZGc+KtLC/BF6/lWyiXpCcglbdMsgeQlilsN/VM35
 SIfZjbg5fhxal/0IX4iN8fKtnO6FH517cMdKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786715471; x=1787320271;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mr3zFi7r8Fc3VNVqeDTWqIBq0B/lqOhkhiXVmRxFAM4=;
 b=lcTfFmwdgwAiHzWlD89omDzAQe8yS4qPdg05VQflCDKV++doziakrAio3l0AbtL8nU
 9i0Y1P4oJJMCaoDeH05/JotKU8qsDyhPuXq9/IWfdzwrou40On0itjUIxg9e7EDuM6eL
 7aLX0MCl2zygYLtLq6svq3wzkcdTMdnya+swSKQ3YtDDv5+iixPZozTB5lv0BDbvDU3Q
 PXRXo+s5mi2IayQz5rgRpw84t3VrJUUW/6DR0adt+rQSgE1IxAqmVsQCecvUjlXvEBw0
 mN127vg5aFKRItSZFLX9Scwyl66lsYqD0UaVU82aG/4qsj/NwUCQFjy011cumYmVnRJi
 Ilow==
X-Forwarded-Encrypted: i=1;
 AHgh+RofTqB++MuM0oK7jYIdjzq9G/aJGMXtT+93Bi1q88vF57FXAfjMKNw6PwnwXg/2YWm+kB9bQ/g=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzoYZhPtJwavGr8TASizOoDgeiW1boRsYOxAAtDHzql04gFcUw1
 7H8EkvVDmk5K9qjRpvPVwo5p4MPgr4qDGfG48Y1qKkklOl4S4PorSIKI3sNKotfTKrTOlHqkVlV
 HdkLI+dE=
X-Gm-Gg: AR+sD10hCu0rEhl7c33wjkXreJqhFcEjZPJ8oUD1XINNnuycrDB1H2Cty9kkkyjIcf/
 1y08ot04ecjQkPoHD6c1xYvjGePs1SrbCeBifL2vpTaTQmEZOA3dT7v02TrC83bkjntQQziLvmm
 BrHtovar0uvPri3dFkR54duXfqfvIsdzBN4k5+9MHo1h2iexXtxKrYflXaUdrnwQ1sqgE6zHztG
 UtHlztJ0nKFxm+b9evkwp04ZbPJP945vTiqi2sPZ1aGA8q01nVCZNU+5AQbNo99r43FXJVGsyZU
 /fYY5txLq7w9KBtm+WrsRzXCw4x6uOILrwYgrTiz0QPP1shC0IP3bJ3H0yY03jgak75KRZtQJcg
 iOoPOmAD86BqhT+bP6OT99E4o/L2uUfxWozruk2IAS+acyAtDS2I/2LTXcVXAMjilnht1CJ5KJn
 azyCPxWCpDmO6i3qc1HOrsWXwYTvFcZrMyeSv1QVGaU7uNmO3gcaxxPHeELmNszNxboe1ntITwk
 0t7JLk7VbLtrO3wRP6+z5K5jpd9b0r+JlhHmluoivMFXp40ne2Mwjmw1TSTmb8xQdKHyFAhjg6x
 FwOlANkcJDFUbg==
X-Received: by 2002:a05:6830:348a:b0:7f3:a8ac:45f7 with SMTP id
 46e09a7af769-7f3de565798mr4057400a34.3.1786715470968; 
 Fri, 14 Aug 2026 06:51:10 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f3e86a2271sm977086a34.27.2026.08.14.06.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 06:51:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>, Aswath Govindraju <a-govindraju@ti.com>, 
 u-boot@lists.u-boot-project.org, Alexey Charkov <alchark@flipper.net>
Cc: Francesco Valla <francesco@valla.it>, 
 Aristo Chen <aristo.chen@canonical.com>
In-Reply-To: <20260730-b4-spl-fit-clear-loadable-v1-1-6f10c724f2b5@flipper.net>
References: <20260730-b4-spl-fit-clear-loadable-v1-1-6f10c724f2b5@flipper.net>
Subject: Re: [PATCH] spl: fit: Fill in the image descriptor when skipping a
 zero-size image
Message-Id: <178671547017.3828101.2340706918392659513.b4-ty@konsulko.com>
Date: Fri, 14 Aug 2026 07:51:10 -0600
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Thu, 30 Jul 2026 17:24:10 +0400, Alexey Charkov wrote:

> load_simple_fit() is expected to fill in the image_info structure it
> receives upon successful return, but the path which skips a zero-sized
> image returns success without touching it. The result is that
> spl_fit_record_loadable() then publishes whatever else the descriptor
> happened to hold in /fit-images under the skipped image's name: the size
> and entry point of the previous loadable, or - for the first one, since
> image_info is declared without an initialiser - uninitialised stack.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] spl: fit: Fill in the image descriptor when skipping a zero-size image
      commit: b152f193fe10444c151b1e78afa582780af0e7bb
-- 
Tom


