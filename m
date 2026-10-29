Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00A3606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 22:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CEo3jjEx;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=UagXWKVU
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB1B740AA8;
	Thu, 29 Oct 2026 22:18:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Omm6VWJcMHnF; Thu, 29 Oct 2026 22:18:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 126B440A89
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793312294;
	b=sip9QjBllBtL2xSIHlVb6xWNyJLR4/TVlZ3T9gPW1ERH43LYhjjP8TY0vxCbNxH+LGvh
	 LXeG9lwD5iQrKICtb5gNOyZc7O4O80YLA5j2Qgl4AsWOgy28U0jDfgWl5IAZ+7z5fNlDO
	 4aQaMGw/FtWzkwijBypDdqE/YI0czUmXKu9Zp4DB93WnKdDGh2ow46khCc0zVSRBCpeik
	 e/QnqS8r1ccYLcQpTgLDiOvMzQ+HUXuXaRx6BCOC3q3RBhsRwe3nd/Ah2c0F6oovdn0J8
	 IceXwtGG/R+KPPJqb0X5fyy4/qsYU0cHXdkxBbkPlYXS44WP2r+RhzsBLZsAJ/JP1IQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793312294;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=AljBP2t7n2j7wlwBEKhulkWR973BwxPadI9yRjBhiqo=;
	b=mt1+wr+15A0tN+xe+BUy6bKG2DeKnTZQzBsSBGtJ0KI3V49Gemnt8iY0Xy9ZanMBC2Rg
	 SnyLjhaE2OaAyZhfB0P5MshiM5tYzhO/wlvb00rXm7tsvv/7kK5g3kP7flPFoojdLU3Ph
	 YwGKG0RHxsQ6ktcZjUAhZHp45/3gOVGEFnROf3GiFPjjv+HzPTM2pyx1+ZZml/cfGo5a8
	 mgftAkv4Y3pKiihZVYu4/tqE1antLUvxx/jloNkkkwQw+IFboq0Vu4V4Kb7gJfLeIAqTY
	 PUkHsEaOo7oggRVqOj3j3y1sUffeutnerjr15aAPSDXDCMmnpO4AhnU7K5PzjpkmzeA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=UagXWKVU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793312294;
	bh=AljBP2t7n2j7wlwBEKhulkWR973BwxPadI9yRjBhiqo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CEo3jjEx4IOa4OhBCbTIPAr1vQzMz6gEJSbKIMvXXb81BtUn5TXlw5ACDQ44QRMXZ
	 bQb2W2yfAzvmgD5lULZcgjDPfKPw+HX6KFkvoKRjVlgd5yqMSDCm0mbjk9Vg1A2Jo7
	 C8du9TfLzLXYIoupfTEHeZTQQ+DLd2nPyBnW6FRcuGycJTV9oXYo1GOw3Rf8PIWqpW
	 cM9ZF4sODYFeawvju0F5vbrW6LqqvIXpgNfmCVWZTyUktuXjJtxyBQK1yzvviPm7sl
	 zzkICWIp+QFw/8DnsCR0jdyMC9SztDxBQ5ZAqJQ4tj5Kg1vUFWNPiH3sahSxeer+vh
	 xsRMXSwO7Oppw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 126B440A89;
	Thu, 29 Oct 2026 22:18:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2FE062E5
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 22:17:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1572840A88
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 22:17:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t1HP11sCSZgJ for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 22:17:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 56B1740A82
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793312278;
 b=R/Lt2OqTdHmaKGqUXXVzMujayCf3c/UbTSjH7i3Hw2yekgHgEfTe2hmv43pM4VScruWh
 7qsZjBv7XX8TdbDUbxJU5Hw0RT7fPBmo8FbIYRaSLPlavtMm3UHDD1JbJKReahJ1UyYuj
 A1NVqyB1O5iTb0Ay2MlLmrblb6h9NwcEEEX6JOabMKpSHPBBFkiQqZqz59H+qBZXPoLYm
 HbF8EtiNNeLqKV54bpC7H+ar3S6qCbZB7eR48Veg0w0V7kE1K3STAAsitXBX/Tx1RGrGx
 RkJob6BgBblNA6H7YCnLTf3mHDghJvnsHYtRogt4XYt68/7p0/G14f5aHkeKefJhMLg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793312278;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=AljBP2t7n2j7wlwBEKhulkWR973BwxPadI9yRjBhiqo=;
 b=l8jwhmYOEjBVW8+qA5x5RucXLHozC9OGnSQcKeqbL+odTVU1SvJp8SH3OsUZ69n33po8
 Js+zfivsnNzQfU8Fxx/U8um5yyKzByGtQk1hpLdELO70FllBD/+LD31y1MIcdNvXf0fbg
 yJn3ui95CHA62fzzL7+BYbG54M1s8SOswk8ImTO+eEHPGTkP9+r1sFyWxay/dZa+xkuLf
 L8x/RdK3c5s3/hJaMgmWzhAhYvrsJY9j/nUQLS9r9C62zccIBRvLFqY+fcrLwaQ2d4q/t
 XaKfW47JOhumCQOfwrwztbHeik0NNn/8dZfBgJ10ghc00nISP5XvNLmjAWFbgRxGHYw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=UagXWKVU; 
 arc=none smtp.remote-ip="2001:4860:4864:20::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2a; helo=mail-oa1-x2a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=UagXWKVU
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 56B1740A82
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 22:17:57 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-43bf9548df4so95195fac.0
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793312277; x=1793917077;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AljBP2t7n2j7wlwBEKhulkWR973BwxPadI9yRjBhiqo=;
 b=UagXWKVUQ+qG2F9jeliA/XA8EYQzta6yu8PDLwk6IWDf4MfTojF2r5ey8nPJox9DpE
 QRo0iYZMtmdTkBogskEOo7K7G44ZZHJooylBoGaTAN3LTD+JUPWP5UvygFcMJVQraknz
 kSXiG7ZCcLvCznutmEe5iaQ+Xj+kWyoolI8n8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793312277; x=1793917077;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AljBP2t7n2j7wlwBEKhulkWR973BwxPadI9yRjBhiqo=;
 b=Q8WHgyQ6GCuDlYg8jDgEfZegLGQps6ARkpUhN+Tecik7cEi4IjRA4xisUi9UnDcaba
 +HmmGg6Q5ZuQybq1JNKthCqkCszgiDL/kc/uRk+TQGI/d03G30+GlYJqcRfS1sHsf8jg
 ML4iNA9VZrNFivYXhE4dxjCbGsKQ6yetWVXfxQqUsrmABqNBmFtlVqZwMslo2TEnWHEe
 SkokTooVKQFB/PaH+TqcuiQSjV7cq0uEgsxepB0XJ5MyFAFrNu3uyPC3EwSPOfvMBzCg
 iI0if1fAuajP/lCBcfHkcc9R5/2GqpuwbvLCfbadVMZHlttSYkuUgrORbxuyqs4d8OKX
 kQhQ==
X-Gm-Message-State: AFq9FYK+lRhcWC3no2zOi7beVzKdlrUvTTlw3s2+P6vHWGVcnqDMlNWs
 g5gWZh6O/zO2yeSQMcc4A3Sy/Cd0kQlGu1IPnAXuZxwq9Ap1rjqWh9mV2PAgIrOdQsXE+zfwWeJ
 eMIUO31YFXOhL
X-Gm-Gg: AYBFou2ZkJlWxN32u9pfxvmSMnhL/WmlmvFsplfEWztbl0gngrETGnsnG9iM6JDtKNL
 JYR7jRBhpYyKsbVfcPTTBwcgUyA7rjItqdkdH+GwMAtsOz7dA2ZjI/pSuso3cc89F3u5hDaOPVI
 N4RROyDsBwvYBySr8oBJRhmUzZeDmWqli+Qz0rV/kEXd850c9BtuPIMr80EEjt6sXZ47H1fHTbK
 X/Zdu/giiThiOcLncRqjPaCO+JTj6pYDkPEoab1qr+mehgxPIsOxrRhqS5Ir1klFrkYvn9GvTSx
 2PtPTMCrYgDDcuuLKJLqtOKRpIafYD0bgsf/7REgLFBL4/6TR6VDDrtH/bTyqT4vn2wL37B67Em
 w1XMf5poBaIxGk5qrEJ6O3OFcLRmvHGVEKF8kHO4iKYiym4uHx5fr7DIQOWwAdfC3tgyzJeRYof
 cS5JTOGW1JNgeRlpeILVv+chs5kwjpjBVBnsEzCK9w5Dwm308H3hXTC56L96AadcHH8xu55CPBF
 cbgbDQmRKkh6H5RXomwsLKADLLyV/ark43UEdUvrltjzNPsUY9YHA1GJMkMdSl6G+mZm+uwKU4T
 6OCbBM1oFG7v2bSSdVQmk7E9wWJaYMsxr1STwWQhHVMPEHbOVPZa8TzA/hADare7xyIsdwim95U
 cuRQrNLoFfTlE8Hk1KNlTEuMQG5QI9AFsbI0xw7OMdd8+yXvUMZmp5gpWax77fyOmUr12LZNxy+
 Vf9w8sHxfPzSBQdmqqzNExBVNDeBpFiuwEg4AKUoDG360NN5/UB94=
X-Received: by 2002:a05:6870:142c:b0:48f:e24e:6b6c with SMTP id
 586e51a60fabf-4a907867a85mr348424fac.61.1793312276455; 
 Thu, 29 Oct 2026 15:17:56 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a90ae4ea68sm119005fac.6.2026.10.29.15.17.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 15:17:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Dineshkumar Parameswaran <Dineshkumar.Parameswaran@synopsys.com>
Cc: dinesh.maniyam@altera.com
In-Reply-To: <20261015121030.5504-1-parame@synopsys.com>
References: <20261015121030.5504-1-parame@synopsys.com>
Subject: Re: [PATCH] drivers: i3c: master: Fix PID becomes zero after
 device init.
Message-Id: <179331227565.3078583.15080606324191852070.b4-ty@konsulko.com>
Date: Thu, 29 Oct 2026 16:17:55 -0600
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 15 Oct 2026 17:40:30 +0530, Dineshkumar Parameswaran wrote:

> During ENTDAA, a Transfer Error Status Interrupt may be raised while
> the Response Status Interrupt is being handled. It remains latched in
> the status register while waiting for GETPID, so clear the Transfer
> Error Status Interrupt after ENTDAA. Also, `polltimeout()` returns
> a negative value on timeout; update the comparison to account for this.
> 
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] drivers: i3c: master: Fix PID becomes zero after device init.
      commit: 602db032e07db04994420594febb464e1b59fe03
-- 
Tom


