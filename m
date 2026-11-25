Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4C1606A330
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 17:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YbrLu8Xh;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=p+un53YK
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5B95A40573;
	Wed, 25 Nov 2026 17:11:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OfdxBI7G6-A9; Wed, 25 Nov 2026 17:11:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AE29B40588
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795626714;
	b=QZb37BIZ6S8BHK4FxYXAj5BJh/f56zToD9R6bBCGorDLpfXY9q7Ow49tDkLBLZ5VVSKT
	 Pp5Z/8yofIfPiQg7CCoc8InyG/YGtyXjrVLGCrRjp/wC+CLL/93/SWWf1KK/vvN9hhLh2
	 jzV1r4aa+RLd9CUPRkuRtNr0szPMA2lXvWMUzbxSYLzSF30zHsf7UI7p+/3SNs04h6SCZ
	 EOcRIc/08y8seOyoHPJg3aNxPCMJGbkx22vm4L/u/zpbSEcER4ttUqGZDtPy0P0VbgvXI
	 WTcT+tl2BCv5/KCmZ0G1+IOZUM8W8P9FCKNtBGt5GBg8kyXCKbchOuX6XRK4wRT8aiQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795626714;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=45oJwn5Mmf3w653I/JtXAQNmAj+5qez6CRhcYwBmeLc=;
	b=YrH6TKnZe8fgZ+J3jJgloSMw8yza9fK1fGezp2KIovoJ+o9ciCVHRKbTkTm6oLZX5bwx
	 vUcaaS+FEGel8WFVm1L20V1bINA9Yk3VLd2OvcdT0hTbHKp7o52JvU70ZFM5ARFn9MGpi
	 cK12Jz7SQq6Q1J9KFFHIgtID/zoRRPAoa8v1ypMhUzvFrLObxKaY8LjjlGDUxjMejW2hq
	 /+uMdWL/jRLcRJTyTsTEtGlOjY9QvzseRbvAg58aZJVDYtWdG5XCHcw2DO3xl5BrD4Xdx
	 6hs35a5TEYB62CZ8/x7O/jyb3LKRSbRt18IlyD941tZQZYYcTq/DNLpmcXtMdRVQRFw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795626714;
	bh=45oJwn5Mmf3w653I/JtXAQNmAj+5qez6CRhcYwBmeLc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YbrLu8XhBGHbo2pUqMpy7WPYxM8U3g4eCQkeKUH1UiicLXLHd9Lya5OMJ0Tza13EW
	 RTJT1cUq0kyY8QY0uksYYPXFvUzLv6LNSjVsHk/hQlGT0Qn5zeSJOHciJqmMIdSEEw
	 uJyJ0byQw91T2V5s4Ft03oEmLSqo51xZswdwEW6fpRuSt+ncqL8u81L/aOis9dAMPM
	 UM6NNZZGJ0DB1/eRm5F+JweimpFoir0xkvuF8n8H9447iWuKCFmwqu4XVwBW+A5Dge
	 +zY0iMeGcafhuhWW+7xwUnNle2D3k4bNic9vlMeSO5nzUDvh1v8jHeagxABGCgeGdV
	 VbNzSDbwxR4EQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE29B40588;
	Wed, 25 Nov 2026 17:11:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C0B621C9
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 17:11:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A6DEC80C9A
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 17:11:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rIoXlyabxiW2 for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 17:11:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5EA8080C23
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b131"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b131; helo=mail-yx1-xb131.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=p+un53YK
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com
 [IPv6:2607:f8b0:4864:20::b131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5EA8080C23
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 17:11:51 +0000 (UTC)
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-67583c777abso6361490d50.1
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 09:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795626711; x=1796231511;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=45oJwn5Mmf3w653I/JtXAQNmAj+5qez6CRhcYwBmeLc=;
 b=p+un53YKtfx0YJIYP0rI3xmN+14fhg2/iaNF0aJwRMU/nmy+18FrVckMvVwCx8CFW6
 jmQtw9xEkYdf0ZEOpjH2Wkmgo5t77+1YSgLEVt/T+aLC0P7yH8/VAV3N9oy61vgqMQhA
 AdJwY/ERpl6VUeTH9xXFAYcAL52z8m1CA691yjrsSFw55mYAEZmLGx+hNX70Q0+ldEFZ
 cvTDCANTR8bVt5IDFymytLkwS2+avGzEjCUeNTDs64yere0WSv5YRM5Fks7/Tcf1IJil
 renSGAN8OqmISDZwGzw83vGJLzD4l9NFraFe+hGn/RjzkgI6jP+ry9xQK1Vw61VRTDyd
 +DdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795626711; x=1796231511;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=45oJwn5Mmf3w653I/JtXAQNmAj+5qez6CRhcYwBmeLc=;
 b=F8d1bYRj2jBBIOETDlHNCoOwHkVs6AayQZc+3+mclGX7J7rZZd2+oRTl+VMe01+yla
 z6DpUojvv9+lWwBxFhXLudgUaJha3qrqB+S0Lp6MwrCltDvMCkgwPVZImGvB+MsfSD0g
 R7Bv7wK4FPfzFhXfBVs2jFupKwRg7iawwo7DmdC58ZhHEeEyHCYRnmAv2+KkUxAyZyBe
 +ui+PaDZPijtVKXJu9HXEe+SnZGr8aNbR3xhgNXwD2Fo0/O4wQ5op/dnmXRji0XIXVtt
 RSfxsQ03u8MCAVzDCfK1uXzfGclDv71HfQsD23+QDZ3r5zJhn8hTmgUV0sVtJhwz8uxg
 ApVw==
X-Forwarded-Encrypted: i=1;
 AL+hErHbrrt/5TfZL3hSOqd9R92NGo8yba95xK1sCky007PCDKhjplbpRQ6ajxoW+oImvBFNbJ7uF+c=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8nJ4JpjL4YZn57XiZHeRajATDyLaQfQU6dkfZgm5aKfKMoY+K3
 vp3jHorj60JXK8OfAE8mLRDoL5x1evc7HUg8l1h2Gpq+vYVnOnwfKSuk0iVd5Mh9JtiS6U1WLdb
 fNrAPS73w0g7on5H+4WEP2Jg3qsdmL1KjMr6hqYDmXpSgOLFRHa619XY=
X-Gm-Gg: AZFdTZd/akAAHH/MAAZXoSvxjMP8xM3W85Mcn9RMOBH00kVa75/dqZqETqGNqnYUgYo
 AZttnMZO+Ru4i0z/H2STYtsa3GStIg7sOnMIX+CwM3vvwc+UhZRWaMCYynm3PRZgeAFgO8LImKw
 BNWfsH7+umA/dTHQE83NmDkLHWyDpkfRB89KhwNvlALXuFVFS7xPP62t07oGu+TdhjABts5KsKE
 xhDu4bMFDER082nd7ouwgpVg7zvwjtvSGXe94mtAT6q8QWQKow0hy4vzC0Zqu26Q9Z6VxPAUXSt
 QpNeN9sdhFdVY2CTMbpzXVyum8cvJ27XAn3saBrec9CPV92qIajvfOJHqYu3wy2StgrvnLaGNUQ
 4yJDoCYblTyUpnhDVrSwE9JUtPfJBrscEEpk1gy33tn0FB/ab6v7UmGsR0nglk3P1QfWOj6e5uy
 /YT5b7hlthf9rzLPa7WAAwrj7i+6biKYKgen4/wVXjHprfdI79ih48nWUTdpXgN4cYeC0wK4TkZ
 mediNlZp0i+AccI9qe5PJXYk2VB2pR8litJIFl8q4YAvfMm2kZHD+AGtPCyZ3ARZJ+NzbTLv0Ck
 IFZ7jBKwlgelXlN+1/2tkypIG1w8oJLp0xmQ3PGP2sdnTCPoxa0ewc4UEg2ctE1YR/An0l9XuNp
 Lmp+q3wBtOamjxAtfkIz6x4eAHO6QJa6adN0r3KESPIBJ1HsnucTSKQ9XmIpQvczcZXR+QN8RTD
 +OMfDPzN7eBD7d3/nqPQSj6laPe2lId6//OHh+KPPg7ugcza+F/qi5s7duiQUF5fJNULf/5hjnL
 sAxvl/GqMJ1MIINnw==
X-Received: by 2002:a05:690e:4810:b0:67d:ac2c:400b with SMTP id
 956f58d0204a3-67dec442341mr5261041d50.22.1795626710454; Wed, 25 Nov 2026
 09:11:50 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261125074122.1965495-1-ilias.apalodimas@linaro.org>
 <ddbf51b3-7b66-490f-ba99-88209bced490@cherry.de>
In-Reply-To: <ddbf51b3-7b66-490f-ba99-88209bced490@cherry.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 25 Nov 2026 19:11:13 +0200
X-Gm-Features: Aa3M54qz0KoZAiAANX6_hVAcLJluBm27opKT1HIf4vPNLLDxtfDUK-8tlL2W4eM
Message-ID: <CAC_iWjKfbu1JTCeWDwOG36DkvCTdc0hE_YFWKDgkdhSCmsWZHA@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: relocate: convert relocate_code to C
To: Quentin Schulz <quentin.schulz@cherry.de>, trini@konsulko.com
Cc: richard.henderson@linaro.org, casey.connolly@linaro.org, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 25 Nov 2026 at 19:07, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Ilias,
>
> On 11/25/26 8:41 AM, Ilias Apalodimas wrote:
> > relocate_code() on arm64 is called from _main with sp and gd already
> > pointing at the relocated area and lr pointing to the relocated copy of
> > relocation_return. By that time pie_fixup has already run, if
> > POSITION_INDEPENDENT is enabled, the image is fixed up and plain C works
> > fine, like the rest of board_init_f(). So let's convert it to C which is
> > much easier to read and maintain.
> >
> > While at it change the behaviour and order of cache maintenance.
> > Invalidate the I-cache after the D-cache clean instead of before
> > and add a 'dsb' between 'ic iallu' and the 'isb', which is the
> > architecturally required sequence.
> >
>
> suggestion: can you please make those separate commits?
>
> That should help us if we ever need to bisect this change. If it was
> only in the conversion from ASM to C, or if it's related to the cache
> changes?

Yea I don't mind. But given that the older version was wrong and this
is the sequence defined by the architecture, I was aiming to have it
correct from the original commit.

Tom any preference?

Cheers
/Ilias
>
> Thanks!
> Quentin
