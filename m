Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B105DD711A1
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 19:52:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 513FB836AC;
	Thu, 18 Dec 2025 20:52:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RRKNvgsT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71AAE80050; Thu, 18 Dec 2025 20:52:02 +0100 (CET)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 345DD8042F
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 20:52:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-657490df6f3so523938eaf.2
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 11:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766087519; x=1766692319; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ne0xpYoHq1G3ZMNGd/Lk+JZu0TJ7gPzoYuVl72Vttqc=;
 b=RRKNvgsTgAIs3DpXOhEO7G+7TkH4Z8YeSiH4hZv91ZexN34u6knP6VjYaXyxEJSBAv
 XGmF4rWIOP7eAYn7wF6P/9SzMJRyJu85Iwq8FC6QMQvPB4V8p99nREx746gBhnPIDHRo
 yTpThAHixig0jO98h2oP5GBqjS1HWISBxSOJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766087519; x=1766692319;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ne0xpYoHq1G3ZMNGd/Lk+JZu0TJ7gPzoYuVl72Vttqc=;
 b=MShXQ0KBZjwMJAZBGQf5FdqNSMDuceJTxppznrn7vMJWYGboUBTMIuksInkldf/mQl
 ECo9fbdhLGI08xos6g1mtTu0XkNcrjP21Pki4LF5/uMYcWIOZ5MiBd3TPynt8vQV2gqf
 jTBL9ax/7WEt06NVxJbDHxv/7aw4rh3t3ggqaINN7axJnkhH15LlcDGa+Vi90Pa/Kn9O
 Z2oGjJmZh4DV//ELvaBpDWWFNUqGZxokXXRzoBcQMgBDYzc8KnOTr5tY48rBpPBelLtJ
 g/7RwwnXecrew4C4375GAtEnZONEn8IJVGV2VZ6dB3K2siK0sw57mqcNzJ8g8N4U5kNo
 rXkA==
X-Gm-Message-State: AOJu0YxTdZL81uU9cUA8YeAHaVskHGru1mxuyDOyVPlvmIjqO044RudL
 piF3qTv7wV2Tg24qNHzacpeOs1+COQBjkGK9321K8pbvthwSPwrgM7rY4ud+/5SzyMM=
X-Gm-Gg: AY/fxX7Ltr9IEqWkWWCJWAoOUTcfXP7ssbdHz8eW03N+LKYkW14qf/jRkbvmacMlhx+
 zrRuDAS9WWt6moqryPhaE5Zcj9m2Hdiu5Ket8NpI8Mw4nSUCEan3574mkKeDz+c9AhwHgGxeYOn
 ktDjV4QTmI51oB1J3Xe1wDpgxG7wfICuCS1PPTOls7dKH+1e4a6SKQUxu/369duS21rJoKhE9cK
 7VVbED6m4vwIRXodnUVt6gMsTOpns3OsbDEj2CPKW/0J7sN+5AB3kAWsLCH2JPFedU/ZdGb8Don
 BJfbX3sVBDeSwMsaouBXVlZSCM1L0bH2wlze3cP5/O4EHNpXdiaFnqyNMaZon0kxA5bA1utO3tF
 BbvA9C5kZQIZL/N21SLBEZuFrKquGAwMV/jIjv/UJhC17nGc4HB8plBHDbGyQmFexQO1NATVI+/
 GtzEgUq4O0UdZqJ5SWnGG2U6zL3gShj3SQq8lwe0wyDFzKuRc8
X-Google-Smtp-Source: AGHT+IEwN3GJxe+r64u9ahgCkAlRP3OIFNkmgdKfhOEoCIViuDGZrqvQ3JfvCEKd1R+zAFKOMH3Okg==
X-Received: by 2002:a4a:ddd0:0:b0:659:9a49:9012 with SMTP id
 006d021491bc7-65d0eaa41bdmr248907eaf.63.1766087518997; 
 Thu, 18 Dec 2025 11:51:58 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65d0f710763sm181837eaf.16.2025.12.18.11.51.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 11:51:58 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251216221935.2230490-1-trini@konsulko.com>
References: <20251216221935.2230490-1-trini@konsulko.com>
Subject: Re: [PATCH] test/py, buildman: Update filelock package version
Message-Id: <176608751850.3734627.6535662415946132409.b4-ty@konsulko.com>
Date: Thu, 18 Dec 2025 13:51:58 -0600
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

On Tue, 16 Dec 2025 16:19:35 -0600, Tom Rini wrote:

> The GitHub dependabot tool has reported a "medium" priority bug
> CVE-2025-68146, with this package. Update to the patched version.
> 
> 

Applied to u-boot/master, thanks!

[1/1] test/py, buildman: Update filelock package version
      commit: d24f4ae65433aa7720c075a9f1d1aaf7e1985ced
-- 
Tom


