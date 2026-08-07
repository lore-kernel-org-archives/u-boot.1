Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F43DC5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 16:16:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 77A8081238;
	Fri,  7 Aug 2026 16:16:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IPWWCFtBa3NF; Fri,  7 Aug 2026 16:16:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7512D80F84
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786119396;
	bh=HtH3buo3OCzGT9X666mrmFGwmOsVoZzZHTM06fkmsGs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tQ6d3a66+7rAoixHJ8oSpBDBjMyvlPlyswp0WZ0x+eCM+COoclo1jyZhVtXxnM8Rh
	 lixD0qMgB19/CVRIyFtT/m+o2EaOuKzffiV/h1yQ8LMFZb4H7j3rPLfu99Y4VvfNYQ
	 vakjpoy4qTHMbAW6E8GD5qSOBuEv33EDRhrKyE9Tz6IaUgN5oLL5UwBA82MDGY32ZK
	 ah0IkhjbFaaW9kXjZkjpr7oYJUSDRCGV7jkR7jTYKFNZeXFUj5Ug/ygz/XRh1Y6cUZ
	 WmquWz7ymziI09K5xp37JE2JO7uWKKRjkr9yevlOhsn3cugVvidBGRkCiGXuaFLXnY
	 3p9fPaweOeuPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7512D80F84;
	Fri,  7 Aug 2026 16:16:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DD569D3
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:16:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C27A280F6E
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:16:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gWUfpAGzHV2a for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 16:16:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c30; helo=mail-oo1-xc30.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 62CD380F22
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 62CD380F22
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 62CD380F22
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:16:33 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-6b03e59a9b4so168908eaf.3
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 09:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786119392; x=1786724192;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HtH3buo3OCzGT9X666mrmFGwmOsVoZzZHTM06fkmsGs=;
 b=EIjhoeFypKkjXxOYfH4BuIK7r4EwalWomJUQfFzcKgJ/co7g5SZ8fnQHnWugd+hdJo
 SLpRjxBen0dTfM5HPjGuQ+HkF6BpOFuZImNG+EBUCJcsFOLPaAtrbwniaAmvf715kvbR
 oZUwf5cjdsGmpp9tvucSBA6zmdAzg2O94IdG5JBgflKLlZ9faH0Z7kUyW3Lzuy5QVxvq
 Q4KR/Ta/5KlULoQZ3+H2w7qi5nhF2yiB+vODVze26HIvryisi9kJEeD+x7fnpIEWkLO+
 kKRdwcoolP8Pguu0NRCsjYiElp3z74PWseWWbfxCE4M4rnwIAbF49Msg5IPDMVzRzEod
 mkGA==
X-Gm-Message-State: AOJu0YzYRnzu29UDkbRORg7o2Ra4IBGO+y4QE8JOXdgecnp3yVwLW/W4
 WD2cHSTeHZ9K3UW4y1NuOBfslJXLpC8HO6TwvU3quxs7nk5ldvsA0gA+NgCVPSTSSGg=
X-Gm-Gg: AR+sD123YVt1qsKJ5JmHOqHsSBPUNXEQcKEOnT4dECvV25hLZf3pOBYKH1EI4NwVaRe
 gYP1jq4OfRrnEvTQrmu84RUmqgUx9zN/JTN/6gGr6lgv8Ii0tmT2JjbOsXwa/crLwZp4luLRJMD
 J6mMV2Cu2TqvLz7v0qjAo3/Azu9scSb4Y5d6ydAYpuZxyIxJxeozTarcHRqDS23x4TWvEEXdANZ
 uOFiEsMxfmg9SQoJtepZEE+0VvZOQ1DMeW3snWs9Tvk79ShadW03Rle8IDsUhGjaZvpzF+Wwena
 aJvWNW0Qf6cGjpUemd6ve80MzJ1Fwqb5zN4XAddGh0kBwWIjLB2HOwmVJlWfZH3QhnRw8JGQup5
 0SIrdt3qGqPjwTF+PE/HaFZxGTf3GlaVUwFnUTdfDl0eRkYjd9CqxEa98Kw367HqFticCK9qdXL
 bdjJkCUI5s/ERmZCJQU4QHTl00vdOzA7GECkBcj7AGpBX1Dvm0m6mXZP1vwfK+ZEcygLRAYErGo
 NbVf5Z/QHhWgt9r5nR1S9sQtf+rBk0K9Iz8r0V4uw+CeLu4S9BrHq4CmaKurT0SpAaMz/FD0/sU
 77I0xqch
X-Received: by 2002:a05:6820:f005:b0:6aa:ed21:6c95 with SMTP id
 006d021491bc7-6b041bae061mr743193eaf.0.1786119392336; 
 Fri, 07 Aug 2026 09:16:32 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b02bc25c74sm2712445eaf.5.2026.08.07.09.16.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 09:16:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Carlo Caione <ccaione@baylibre.com>
In-Reply-To: <20260802214510.158272-1-marek.vasut+usb@mailbox.org>
References: <20260802214510.158272-1-marek.vasut+usb@mailbox.org>
Subject: Re: [PULL] u-boot-usb/main
Message-Id: <178611939166.381449.12221104116750990952.b4-ty@konsulko.com>
Date: Fri, 07 Aug 2026 10:16:31 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786119392; x=1786724192;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HtH3buo3OCzGT9X666mrmFGwmOsVoZzZHTM06fkmsGs=;
 b=HX2YTEIVerafDiTjbJ7JDFarkTMHN1rh9THkKQ2HjYkVA/1lnA/Ppwp7+BdPBmKabF
 eRA5iQ8OIwi+d5G5G7gBfCTnKU8okiYekLcASzXy5Zrq7D+BJeuQbcRN2SeOAqcFS26x
 XMm3pceg0yu0LDJ9tqyGREwBU8VVPMiYUe1sY=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=HX2YTEIV
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

On Sun, 2 Aug 2026 23:44:40 +0200, Marek Vasut wrote:

> Singular Cadence controller bugfix.
> 
> The following changes since commit baa64b2f892890f00a377eac4a3e685472bb56b5:
> 
>   Merge tag 'efi-2026-10-rc2-2' of https://git.u-boot-project.org/u-boot/custodians/u-boot-efi (2026-07-31 08:55:30 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


