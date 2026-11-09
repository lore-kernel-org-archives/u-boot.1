Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B68606A32A
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 17:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=B2F4b/mp;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=gDCKd/MW
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 52466810CF;
	Mon,  9 Nov 2026 17:30:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tGAAXwzw8r65; Mon,  9 Nov 2026 17:29:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 85576810D7
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794245399;
	b=frR4Xq2tZz8k208XnskkZjE1xfppPfHeG0NVKSJ2i50O2nhecIZSPdmudtQCq1dkDdRC
	 Xit821TYmhXgQjrMpbG25sl1jZnMmu5w+6yh9P8YEmaWo/3RGg9nTOnNBxZoBjeS2oEG4
	 g+rjyVJmULqyV2MI/jUaVPzwvQlHO+EtE07UfecoScXe3RqZL8b84GRqkq96j6w4Hogon
	 alNZdnNeq1bxACxz9vTYrznf4+7NUJP/kuymxP7iMKHsCBbHOi53ELnqNqV2DLNJh75f/
	 Kj9nwFPlr8x2+7T1aXmmQtTedY1FVqcW/hONfNs9w/Ey54E1bLYe7y43H2/H9G0bv5Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794245399;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=fgcaDufdwozVFG/WNlO+vDro9+7q6VMOMkkeE0Q5PI8=;
	b=S9imrqY01oCuSC1hQ68lTnFS79JQn1F92PR0Xs0pfrIxDTl06wYIGYf/7EL2j4iytdYr
	 G/pvyGfS18lWoRBoldDT4vdcJXaHMHB44lmc27oCQYLATjZh5YfiJ9IJvcYnRO69Pv3rF
	 htXaCRFXBJ/pg5W2qnMCLu1N9QS8ERW2E0wU8mnQXvYgkCEM6IhN/tWCccMyU73XMm573
	 YiAF+tqGsCbEzbqwil+U43Lz/wxzn8kYQlN3bgGmOr32Om1OUNuAf6Ls1H6OweI1g1PJC
	 hBaHQYNdansRzFKcYVhduNtELNoBjgRY1NkZkrL3OP6/VCRxvr+lIpM3jysMxfyKxtg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794245399;
	bh=fgcaDufdwozVFG/WNlO+vDro9+7q6VMOMkkeE0Q5PI8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B2F4b/mpFr+NKSKcm717N5WNxmFWm297dEcwE1o2ByM1sdQ+dgUEg6HylNIlgwIdJ
	 9U9xlot1ZgFn6U5WImYzo74Fdgrgv1rYt2XL6uL/zZKlLFU0WojkTNlbbuFE8GlVv5
	 6N7ZcZ5MB+SZ65S9UvzOn2vWi8hSw69K7SjIUikj2vmw4PTbk5hsnP8LC0Brs5doDP
	 xPYS6lsqwOxpzM5t/81wqy7Xoh8nM40iBN37YO+ListyyZ1EYAf91ozzXc4rVZyHVl
	 n8uzARfzpc4B48BKPxeWpZFt3ZHe0kSEXXPgZcX9vi25hVEjzUG3S3hm8PG30P9fYe
	 NroXiAv+GH2HA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 85576810D7;
	Mon,  9 Nov 2026 17:29:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E79E228C
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:29:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CDACA40769
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:29:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fjbhrivZnVGE for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 17:29:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 04F5740756
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::;
 helo=mail-oo2-x00.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=gDCKd/MW
Received: from mail-oo2-x00.google.com (mail-oo2-x00.google.com
 [IPv6:2607:f8b0:4864:31::])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 04F5740756
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:29:53 +0000 (UTC)
Received: by mail-oo2-x00.google.com with SMTP id
 46e09a7af769-847bb37911fso31624a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 09:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794245392; x=1794850192;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fgcaDufdwozVFG/WNlO+vDro9+7q6VMOMkkeE0Q5PI8=;
 b=gDCKd/MWD3uZvdiNLIIZFhfwoXOGbrtdTZ4K4EJ45qS+lT40v+Dy69O9PROryobsAw
 hEKESEj5BiVuT+OovtxiIyDvY2TyUslDCiPK0++lztWqsZg0RfzeWDGO3H8H20O3YZBB
 /tCT+HN9TzCKjOLKqauXJ2Oi0mge3A0POHvIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794245392; x=1794850192;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fgcaDufdwozVFG/WNlO+vDro9+7q6VMOMkkeE0Q5PI8=;
 b=SEu7QhKQROnMPLxKWSwmuzeI9xDjjd03/7Tzjj+EiRY+A/cGU6hfyZeqRLMq5l5443
 02NJzuayfI/F8ruBDzsDwB8uN1SZeMhQyV7vuExfqLveE0UNnmByWspOZg8BZh0IHGhX
 OiaxmT38iUV5cDIxrgIu3zmtF+XY0dvCznG2a1TMHsJyH8Pfd+S7H3HEHTrRhcoLejuj
 luaUCLJVfmXA82akLXu7k+wrct/FtSSrnI3GZdTlI9wkya9DFJ4EGU8170sbSr0waDJ3
 zsuRT3ZTP0BpqJdUOH2ewhred0O/C8AXuf9h3emZFTOkFVOhppRhPHIHCnsD+it1T6/5
 kVEQ==
X-Gm-Message-State: APuU4Z81InJrq8LSdHpmSh1hZC3F70B0eKKgsna6n1FKE/ZAiqQYXgi3
 eJ2BH17LVDHUV6/WWVYjdqXjPTdc66r87+32YNqYJ1AZZBgTFH54wZoT8WF0Nm6lHY7Xx/462nk
 ZylLOgB/yLjuUnnM=
X-Gm-Gg: AYBFou3mGdTJl9xaMRys4PFm0D/c66lrx+sfq8DCos2e2sdSQWLi0Pe1NEDcwrPHNiG
 gT+lPiEOJ8h7jJbDTMNcKujWkgy5tKDGpPRt8ITCX7BY5D6fxoFAbgvUs739Q+1Z7hG6+cLqNN3
 1R3GI+u9wDBqQsgdV9dd+b9dCmcnBKc3v2x//CQbVgqq4RP8ZwIhLsNOrKlbBYyqV8Muz2PFDEE
 vGbQk4wLlXvjbBAhCCMH4qLouADddw8nq9wBn92nWQh7TH36fziTZdOAx9Is6fo050fHMVFOPbt
 pO6IV2Bw+A3HFS39Y4qqQJG5ZPKOcOdFjBpwU1timOxE72MM62UhBvmHgw50x2BG5vnCEtpQcLA
 HF77aXAta8HGjDi04x9Znz41XUZ9DUcab1ZwGmStIUIaxv/8b8tTRYAISIIS2oWebmt1p5RjANy
 GZzyQCpGytMZTWqI6AfcZ0HwUC7bBWQuD0uiLQfF4nQ9Shjyc/FXdWYVNP7js4kDsBNhE+Fx/lv
 0s0hm336lIO6bnElgFTiIHMdynNY23G6f6FS8AVTaFxwnIcnrS596u+M+N1A5LZHC6ocVinKQLs
 BHE5eE2iW6mqBj3dZ3flQRxxEleizMBy/epEjD/Q2O0Ik+jtQ39NblMc8bwmpcaMr8L1oT9r+bT
 Ei5IQ+as6otbQi/zOrPUvlMA5HUYEJCnxrq6ncqmBY6ypoA2lgSyW7MNtIBuaJlt76ULEiQy0ZS
 j9+ZAi3w7fw6TinPsd6Z8KwxC5ASchhqY=
X-Received: by 2002:a05:6830:681c:b0:81c:9abc:974b with SMTP id
 46e09a7af769-860dbf46bf9mr112007a34.17.1794245392478; 
 Mon, 09 Nov 2026 09:29:52 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-860db8481d7sm200546a34.15.2026.11.09.09.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 09:29:52 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: u-boot@lists.u-boot-project.org, nd@arm.com
In-Reply-To: <cd59a085-803d-46c1-b05c-ba1fe003a571@arm.com>
References: <cd59a085-803d-46c1-b05c-ba1fe003a571@arm.com>
Subject: Re: Please pull net-20261109
Message-Id: <179424539194.2040456.1563368000274666505.b4-ty@konsulko.com>
Date: Mon, 09 Nov 2026 11:29:51 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 9 Nov 2026 11:58:16 +0100, Jerome Forissier wrote:

> The following changes since commit 709a97a05df66e394f40d249105d0baade46f107:
> 
>   Merge tag 'efi-2027-01-rc2' of https://git.u-boot-project.org/u-boot/custodians/u-boot-efi (2026-11-05 07:58:42 -0600)
> 
> are available in the Git repository at:
> 
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-net tags/net-20261109
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


