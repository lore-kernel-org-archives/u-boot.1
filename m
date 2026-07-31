Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DDB9C55173
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 19:40:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 37674411D4;
	Fri, 31 Jul 2026 19:40:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7AGVqM1fBl2U; Fri, 31 Jul 2026 19:40:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 32D01411B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785526852;
	bh=PletG0Pa4/XnUZKuztbWBFWkrxviObkAHKjTSwub9aM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WQyW22kAlNJIY2O4Lau0gAVq7GIybetmMm2/LKrHYGipHLw9i5Y0RCPYnFZ1xUdrp
	 AmDAeyi7fVr/+LohdfM2oIvL6urYkO6qXhQsVwh8RMxTR94OfJ3ZOGMFQ3b4//NDFV
	 Q3VNzJxxKk5iACSlC/wfsCVUOKiwFfj/vrPKXHqUC8+3tGuZhEHK5UHG0ysKg/ktMK
	 uUdGN6an/h87ifa1weV/GkoVVnoEJx9YaV4OWgxuDCFAxfEKhTfCas+1T89mcEvEk0
	 3xuBl/PkatgXjfquof/q+rEXBh2UdiBIak3rRsMoYvnNf4D18oCMsx+dybsT4/pJGb
	 uMEWd9NLGqoRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 32D01411B4;
	Fri, 31 Jul 2026 19:40:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0191F36E
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 19:40:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DBDC180D56
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 19:40:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FHRXmLAPVjER for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 19:40:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D9F4780BEA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D9F4780BEA
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D9F4780BEA
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 19:40:47 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7e9f1f24cbcso1299820a34.0
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 12:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785526847; x=1786131647;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PletG0Pa4/XnUZKuztbWBFWkrxviObkAHKjTSwub9aM=;
 b=Cba+zIZ7s7sUdrS3TF3AD6S9aFBDgMtSPwrEx0Jr4Q/4VQQIgiaKVC4pLmph+zLpc5
 9eNFs1a8KOOi9ZoSteir2ESZKDVdsJRJKABlxXoUco4+1KzXIxTMbyE4ThcRaLq/mHR0
 8zGbl4KVTiWJI6+pgsDiK7OHpL+zfBwPRIp+5W3MPw9DCyhEca0UJKfjIUuKZEvq5H0y
 IOoeREf4SLAYALF6upyEvHgfLIejzNrACiOfOmqtjdwlXu42uBx+mBN/D42ZjPHI2SZh
 6RTNhZJxmFdSe1cWDK/bxNarGsJuqgDPOqzo4a2VOf07o9SvSZUXq0ZfOTe3pa6bQ2F+
 wPyA==
X-Gm-Message-State: AOJu0Yyb0y8jLHRaaJzx4CLyTKJmDX3SUVmxhxSEeo+eCA6iuERjTsOu
 IOusL5z2eP3tDZnfm//7udiIfrbyndn4Kl1byB63HgUGC/bVpKD/+b8Si9dvsRHEqhJEsCHBy8H
 G8V+pyfM=
X-Gm-Gg: AR+sD13PI4Z9gxnG2ci/YBHjPY+qqAYMrbeN2hZGn7WO5kar42khRf+27DvRiMuimzw
 v5RNtZxFVz7WpvWwNrlJDh/Jqv5aGlcLeqF3uAJSV9XDGEmTMaLL8WfYp2xQGzBfT6CKHgCpg11
 2J8h30HXpGQO7rsrDzlB8Q6DzRCu1PBNsK/ii2a1/ED5GWiOXuWjoAxC9kZs03/Dd0LlPQRy8F6
 qYVLhpymNnT9S9q9oeqj0SJqovDlYpIoLKrtpxN3v23Sn8njApgaD4+QF4rWVV3lH+SeFskn4NZ
 Lip11QpLwbaMXc5Lnh/ymmSgoTO+ofWfmXt8zEmXFojESul6itxlIbU0KAasRQe2CFXj1qLwZCh
 /BjDrTtWIHBrWztd8zUiqlHGAP9Ejmb92XzTgzBr7+ZjO35NFB5p74mWCh50gS5mO5RUDW/P1Nz
 XVVzoGfyPWsWC9VL3kJyx+BmCmOIB5Ki+uEZ4JkjQ0LVVqxKbBtBguCNQPZ2kul3XboeR4Qn4Ac
 pg3jhFU7rwr/mJgmGv4ZNsvHVM6QyMq5QEbtkqcx+Rs67Kdb5zGbXIjlTTQkCF6m/gl249OnCX7
 gS/tYtxd
X-Received: by 2002:a05:6830:7107:b0:7e9:b4ea:2ef3 with SMTP id
 46e09a7af769-7f1973ad4a9mr926387a34.13.1785526846886; 
 Fri, 31 Jul 2026 12:40:46 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f18eda635bsm1465662a34.12.2026.07.31.12.40.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 12:40:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Eugen Hristev <ehristev@kernel.org>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <fd29bb79-5f7e-492e-b460-68f0ec8a1dd8@kernel.org>
References: <fd29bb79-5f7e-492e-b460-68f0ec8a1dd8@kernel.org>
Subject: Re: [PULL] u-boot-at91-fixes-2026.10-a
Message-Id: <178552684635.2534773.2388902479927986634.b4-ty@konsulko.com>
Date: Fri, 31 Jul 2026 13:40:46 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785526847; x=1786131647;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PletG0Pa4/XnUZKuztbWBFWkrxviObkAHKjTSwub9aM=;
 b=YNV8ux79vmU/Pe5JiO0HvoeDZPDBmSRr/3p7QzS80qA0ZazYb0TiTG8b6ifgujAwZh
 0RVa3ABp2DnB3IijROZd8TzrwczvNYeIiP8DjxIDs35JZw4bZUVcAAqRoe2wBAA93f8y
 PBoh0UhCS7naroBqXFJff+AHijsAo4GsYtYc4=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=YNV8ux79
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

On Fri, 31 Jul 2026 12:46:30 +0300, Eugen Hristev wrote:

> (resending from the correct email address)
> 
> Hello Tom,
> 
> Please pull tag u-boot-at91-fixes-2026.10-a , the first set of at91
> fixes for the 2026.10 cycle.
> 
> This is just one MAINTAINERS cleanup
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


