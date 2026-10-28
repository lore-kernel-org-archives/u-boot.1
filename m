Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C27606A32D
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=E7vuSlzY;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=TxfiZw7x
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6AF4E810E5;
	Wed, 28 Oct 2026 14:54:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PZdOfX_nt95H; Wed, 28 Oct 2026 14:54:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A649B81027
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793199281;
	b=Z+XLx+wfChw43KUmvl57+SoEg7HXHdMOh8+OE/1OBpiiVBkK6RNVa6VmOhKQEG30Khby
	 jLQY48DcdRlTefSkl38xcDhn7t6zKAj8HCMv44z/FY+j46ik4h1hM924EJmEYgYtpBK5p
	 JvoglwIQl9NjkGTjFKOAXAKNzfzH9AjCmmrH9Zjz+fkmrEjUP+E+q1Dkc6Y5ExPWw9/Da
	 o4xD1GrrPdhZ+VlmSSwh3FZBYN1T1WnGuT3VuVx/7p60fGee6I6NJPVwrScLQlpUDk/E8
	 mMPvk3sNg0Bl+MI20/pd8jpP2xu9jILGYoG4YMlmTWqjnl08dbt47XFx4rxDKnaYTzQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793199281;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=SvL3AzC+qiORsBrXuY34wQaJwWmpD2WaZgYjFX+4DzI=;
	b=SKB9ldVrhfFA0TFTDzMWvDNyqUsVf7sK1PdzLHsuy4h96YCQXj76Yl+dlx8dCZAiPDcP
	 4yl8wzu8ZVbBitTi0cmHiJtHWwR9wjK60WM3avBTcLOTeam4JNSny5cS1bQinq+T0rcy7
	 MZi02x5iiXzn+ZzVUYsZj9U4nkdZqYOuo/uaXbTRT1rIIXSsbRYuuAO0wv8aRCBRC8DbI
	 JXnXAMJiU4Zp2hFwXdL2vfwkBSw4z5yMY7TovWbOjdGVrTD4ywpD8HHJz6KN5JpWPRdas
	 Mg/XQ9JlHp4N/Y6rjJkhMvkej+EmqFclMA5Goo3qBBjaxt9JCAi4cjNqVRSFMHCbCeA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793199281;
	bh=SvL3AzC+qiORsBrXuY34wQaJwWmpD2WaZgYjFX+4DzI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E7vuSlzYD5jalD519B+Hz55KYc+FN10HmoKX2FE8i8SUqrOzoaDR3FkR6HGhbJwRJ
	 zoYXQw9twrQYE2E/hGLYoUbeW2VDpqtLi/sub5Py0nxedbP9uf01ZAXIQbfAIsh1vI
	 8Z2OqtJVt5eB5ZTvVqmuHh32/1PIXW6pJPNNlVZKwBCEgdjtZcWyv19sJn9b2/byEr
	 JNHYNXI7KUq4IhkKVKwlFd/BcvAvVfGwQ3/0LzWj3BWymPEKW1LI28r1p6/imoM0El
	 vQ26spXw2o4AXloQfXaoNHQQkigW24Bd2q5SHitGgcoAx1RP2t7BLCO3xrqoimNUCz
	 RAbycKHQUtttw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A649B81027;
	Wed, 28 Oct 2026 14:54:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D9A8E380
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:54:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BF69060633
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:54:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I7Cj92aRfbHr for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:54:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1E554605DF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793199280;
 b=YC3dDgbWW5Vbxy25jHUD9jTowyQoItXeRly8C0oHeGzaAipS++zdmT5btDp3xi5rZ6zU
 YbXqfCR4BK1SLgvuRBXrYmOnNO67M4V1nbYlq7zR3nL1w5ieHeqmW5CUlXneCXsiTbRex
 SiP9KwfBeuQBut8KzxmZQ9Zh0pPUqqToXOUIJzzmf75WyWUCM3l/ayLfNkwUK7ivIG78n
 solmx88Bj7dw8LZge1phzv9QczaDFjYkccurJv25Pw6sjI533sLKoi5e5NwD5TWVVVt80
 XRhY66FOaLAXyOxfwbEFBT2C57AfmYFi81Xl3wk9SKp/Fn8den2HYqquxXtNgoZ2Pkw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793199280;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=SvL3AzC+qiORsBrXuY34wQaJwWmpD2WaZgYjFX+4DzI=;
 b=tYHv1pacWJ+6QWjhVUoOiXequAORN3OZzzh1koSYd743ITVn5CySJVZj9RY4a616rUXK
 ksoWRybrQ6gA5J3bdA3/xfqQmHa9pnMoVfZn1T0u1cTUgMLDFY+SO1uDRQvbXmj64fa8b
 xQHoPypTn+fiAE1lSz3E0Pv/tVI0TnHbopoSwk633C8TiPLtDcdj54jkt6beNb83E/Qd7
 7gXspSApYRgt9ASKv8s49V1TWLBcYGC9E9kqHKmruzvFTUiiGUk4b1dLV7lymEIsHuC2A
 1pHJaY3X4/RbrWpuvsqicV15AubTth7EaqAIu6NEddFzd8fSPDzCOP71h/esM3bwjHA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=TxfiZw7x; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=TxfiZw7x
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1E554605DF
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:54:39 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-84a2bea315dso728199a34.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793199279; x=1793804079;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SvL3AzC+qiORsBrXuY34wQaJwWmpD2WaZgYjFX+4DzI=;
 b=TxfiZw7xPPDpJDDrN+svinLc6x/C/GtZF+29kDmE6PIAOXJRsZgPRZkG3ZC3btWqIZ
 5+c/epQos4Isu5U/2U7W2NYtvbi29W0OvRfQ5XrI8mH0EuT1GygvLNaEULbJRHNwGKPi
 H7A36Hf8aZeVK3R9IvPt4ncK5D6stFmr3m1BQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793199279; x=1793804079;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SvL3AzC+qiORsBrXuY34wQaJwWmpD2WaZgYjFX+4DzI=;
 b=a1O2GqcHRoKpEYEj10CJulK+SjKShTyrujrvDKr/fjGgN1kUKZN7ELoQKppRrYUIUH
 hmkisJsZdNsi6yykABczei5ykKknfddX6MQtCN243qRpbHM8JbzuzkPevZTZrAhPnTmH
 0+wAHjZ9lde5PlFhLPz9Q+eGBR6pv4Ff2wM8AOaY5rOz0BBAq49XC9QiTmRMMol3jipo
 1exYccosoHOWy41NymfAve8HlUJnsndQPn/144niZcmbawuCVwG8zoSaElVmhJFx9u4p
 Kl+uyMIfyA5WDIIvUlFv0hhwKJEdmer3LxgC288fCBXNyr2RVttagdvPqBDmuyWzPyPq
 dGDg==
X-Gm-Message-State: AFq9FYLp9NJFopsmySWKEqINFlT58ZalHpU94hjEdt+B56Ta9m6kVmwN
 qrlKvjcPQ/UKJ1jjHrD+xYd/w7QwILGewEJrTjCQtnta8K0khaoJ9sH3yKg/SFJ7YQ7dVkVbJJo
 Apt/Pry3vWYfE
X-Gm-Gg: AYBFou070h9rRYGaOo41gjypo+QIxFhkG4jxhH7mSgasX3TfpRJ9vcoqZkdDBfR3oBo
 kG6kmSPt0opAGsT9eLqkrn52zXT8q22Gd0I1OjRDEJBM8J65RO/5VNDJ0uorGf4D+rtUR9hQ82g
 7EGbxejYMWYVgxIGiwWZvVS0jBEBHwGmoj7rEYHynM2gNG3Si84+UY4ui+xIF1S99hPGEyBSGxx
 id6DSMcxvaDJpdyAT6zjKv1tg92cJTsD1TVgl8myumb4bxORQhjC9tptU34LqKrSuraB7/q24X5
 gdw0OVg7TVEp4i9/cnTcaWWg/btZg6C2J3sFY+zSK7BbULw+VLYddETfzTpzncqt9DTeG7Zj0jc
 pMCfF8Cl+ZVYObqq76irDZ9cfcFXr6ksdCGP48kQaNjjaH2Js9dSX6Yuy0v/+eCnRncStFbplv2
 xA8DbVSWzGeNs9L30aA8Bvta8+lcwq51izHIrYDBOG0ML2GewNAPAxGScwbvdjcaAp35mpozw8k
 HGUIbBHcLuFHGp1HRoJdpUE/bVTg+9hcnhUBi7MkFhwOevEeZBR3/WipTS2j+u0TKv7UPuaILeq
 /veozOv/fFzRddHpE11+9C0+4Bhf0ISR1WP2aXxxpzS/pXDOqJFcRK341ouJNBSQjJmvFlL+XIO
 Jzxqa+YlwWAsuxfQwzRSA0Ve5HZxcp4JAepwz35v0cqZUNd5PR/bdN4AO9OiNvlZuCHj7QDJ9WC
 5xCj+6S1B9jyn8pw+L9bswutUvGqURffXsgN5qTfJo50tbvxCp3DE=
X-Received: by 2002:a05:6830:2406:b0:805:8b7d:d8d7 with SMTP id
 46e09a7af769-85abf964f20mr2306762a34.7.1793199278753; 
 Wed, 28 Oct 2026 07:54:38 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85b20217c77sm1871528a34.21.2026.10.28.07.54.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:54:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Udit Kumar <u-kumar1@ti.com>
Cc: vigneshr@ti.com
In-Reply-To: <20261014041307.2016965-1-u-kumar1@ti.com>
References: <20261014041307.2016965-1-u-kumar1@ti.com>
Subject: Re: [PATCH] mtd: HBMC-AM654: Increase calibration count
Message-Id: <179319927795.2677777.8969826461737276378.b4-ty@konsulko.com>
Date: Wed, 28 Oct 2026 08:54:37 -0600
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

On Wed, 14 Oct 2026 09:43:07 +0530, Udit Kumar wrote:

> Increase calibration count to achieve better reliability when booting
> from hyperflash
> 
> 

Applied to u-boot/main, thanks!

[1/1] mtd: HBMC-AM654: Increase calibration count
      commit: 03970827ab5e24730efa85d15cc84397d5d4d79f
-- 
Tom


