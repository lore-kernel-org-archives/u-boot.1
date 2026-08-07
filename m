Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8E7C5AC9F
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 16:16:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B2D880F6E;
	Fri,  7 Aug 2026 16:16:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wYigARZhe0Jy; Fri,  7 Aug 2026 16:16:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BB148812BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786119397;
	bh=bxg6Bk0bBtEJ9QA8Vea8dVRbbCUaztMlL313wbd5Cbg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OkjvfF8r7vsGSIB0jj4cP6C4eWj/vI6qWvXTHjOwo/LiaSiVaQ7IJ3A7lazRU3QnI
	 2f1Cy7ALvH/0utRTMcn9i5igOL2HLluUYK1pmlCsGu5R1U8j/fOeHPI6xHwH38q9GG
	 NTPWpCAdzifG0gT3hzBErJr70lKz9ifrkG3E2SBlGK5RHv0yTyypwaCAX7g0nUp2xn
	 u6oj0xqhM/JmjVxCXwqy537X+cUJ3MrrtrN533Wbi5BckZkRHi9dsufc4JHqz+VUkJ
	 V3UmwXkmQ4APIoFUShc7bBwseO0+uwia40JSzLUjKI+5r1QjwP142VYsuwIUwQ6PDQ
	 c0PMIQDzuXgTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB148812BA;
	Fri,  7 Aug 2026 16:16:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1BA2AD3
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:16:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 024B74010A
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:16:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U66vm-rNDLJG for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 16:16:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::33; helo=mail-oa1-x33.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 352214008E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 352214008E
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 352214008E
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:16:34 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-459281bc13bso2275020fac.2
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 09:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786119393; x=1786724193;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bxg6Bk0bBtEJ9QA8Vea8dVRbbCUaztMlL313wbd5Cbg=;
 b=oHjdbX9agwucTryY/rQc44G9FzRJ/LhzjMPwehbwrq4guer2uC3ly4iiA9W3dhZ97b
 eAFGa2leOKIqGXk7notqMusOoxss3i/BiL6P+b8sBD9WXkFKgRjWQEJ02f6k0eJrU6ff
 u0GcueYAUimE2E2+1WcCkfHpt7d2GZmgEbBHW3/LZ7NoEikSOcSSic2J4sLbZ+bLjxNI
 WjVKrryEY/0Xs2nFkI69Da9Q4CkbgN7PUzcJ/1EhmFT4vGhZvF1sBx0xArJ0ADmpI0tY
 K90vWIva96jZ4srAIKu+Dot9httRUWNWbP9GkLTH7qe1tgMlUqvmj1vGMM0gkHXi7qnH
 U9Tw==
X-Gm-Message-State: AOJu0YyeKGQYQOeTIFQNA7txf3vXBFoUINEwC5v7Ic1RQcNRtINzXQYF
 xDvdD1qSCManbHDpKs7peNLzmXWfg8fWNH9msml5pkCi0rMPx6DEYDqRymBuC0GoPws=
X-Gm-Gg: AR+sD10L6pqGxiUDoVseuJSm00zRJFrVD2iIfbioTDorE4N8+fjPnYnDqpMfhjKPzod
 ZT5Cb5900CoxAWh4toIpy2agH3RqzIujlfttpjtyxWyCdKBJXrjvE3i80RW+k1yD3UBrrds9O63
 xC2WUp2bn6QRg8Pm6dRXCClvQs9+cyCH8vghZ2W/iKWfRf2bbIPerozmcwx6nLTQ0QQI6Cla+kH
 zl8E0m7yGSteYP2g99IB1IDOu1t1gMhMWJoNXU4ykl4kSXEXatufoZepnqO7dG4aDBuQYDgwFWy
 XhoD6YV9TPRa9k9GUtD/VqmqhvYSrm5u6ub27zEXq+lrUNVwH3iomvRVRHdKC5gRucPHit/wwEk
 HLEi7oHydQuDtZ9BeoGeUFP8QoOlPAHdjB0eoyBqsfGS+zvFMQNeRVuu43RWkJE4WbRMe9EDd4U
 Fj81F0IfrqO9cja1RMmSNPSiBHq+pVaPZC9bL+KsExnU0q0Y0WABC5uR0JoeaxJX2lq1O/mBSUp
 8yb/WztgQpVjLM3qhxdM4TQe2LoKcHv7xqGq8viG09sZqfNHm9m5Bl7NQGVOiwGyQ3diSPfVKZq
 gD86hciu
X-Received: by 2002:a05:6820:61b:b0:6af:eac8:3d92 with SMTP id
 006d021491bc7-6b020d07120mr5677861eaf.0.1786119392994; 
 Fri, 07 Aug 2026 09:16:32 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b02bc25c74sm2712445eaf.5.2026.08.07.09.16.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 09:16:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260803000610.226554-1-marek.vasut+renesas@mailbox.org>
References: <20260803000610.226554-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/main
Message-Id: <178611939246.381449.2454130223933659257.b4-ty@konsulko.com>
Date: Fri, 07 Aug 2026 10:16:32 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786119393; x=1786724193;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bxg6Bk0bBtEJ9QA8Vea8dVRbbCUaztMlL313wbd5Cbg=;
 b=TP9l1LA0NDHxZ2inuaeRgsoU/K9dYeT/Yw9XvqNcIoYRaD4MD4eAX5hYBncSRTqfdz
 moQZ5Nru8hz5nQmTKLjf+Gt24jfg0l4CvZzm7WX93LJD1CFqxz/6JHb5c5ALlnNyiNQH
 fYuVjsKDZnMRFe5Y8uEJKukgfpgIpfd/uYiiQ=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=TP9l1LA0
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

On Mon, 3 Aug 2026 02:04:33 +0200, Marek Vasut wrote:

> R-Car Gen3 clean ups and size optimization.
> R-Car Gen4 proper PCIe clock generator driver.
> R-Car Gen5 support for newer SCP firmware version.
> 
> The following changes since commit baa64b2f892890f00a377eac4a3e685472bb56b5:
> 
>   Merge tag 'efi-2026-10-rc2-2' of https://git.u-boot-project.org/u-boot/custodians/u-boot-efi (2026-07-31 08:55:30 -0600)
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


