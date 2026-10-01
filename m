Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89342CA5FD2
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 22:05:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A63A40A91;
	Thu,  1 Oct 2026 22:05:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FLmz4k4mVz3L; Thu,  1 Oct 2026 22:05:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 432C440A59
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790892351;
	b=XxjtwxlmyWU1W0pDH8TtGSVZgwtbJ1p/H1Cxi9YMfmDFFCRJahSQJ1Y6P46nsemTekjM
	 3Z2fxssiGFMKFfILTyhRAFOErITh2bhQrWKmLSnm7Y96+56b81wFsbh4ZW6U1p3rRYZwd
	 jvdSDNjR5jX4d58JeW2simHi6L6ttQJyx+GegWTm5hBMx33ivb/hbqX3NlyidaJVDip8S
	 n6ntf+eh0HS0T8p1mwNd8aih6dLOj3TzxD8DcGdJoArK4UbcSVyeWMdmkOlO0rLyANJIL
	 w+poFhcaeGjtnmMhANVk01snim8YWaNvbiySotWarqJeYEfn8Wgysbhoze5R6nIpmPg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790892351;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FTQMWVIJbKsCu86OWrrzxgmUxVfsqhBefh2DEF5MplQ=;
	b=lXQWplmscIWKo3KLHClTs9VRjjuQcEEohrCzYtq+0YG88JvqZYUmzBWjss6w6tf79G6/
	 lzdciY4JnHY7G3Z3/nl4Wbcq4l7N87IPdqKJDu55L8CYTqqwNKkKe+2N4BFv0SFP1L78N
	 GFzKc3Qi0If6Ie7DtGMqD1uj82ah8R3Q2zFgzE1AfATUTq9W+uwvxdXYGuxoQ/59lPQn8
	 9BFSf/9qz8HObUUxLKtsudGshaNWpD1AguPfSfWPC01+BJ+U+iXiOigMsoCt5hcLg9Ssk
	 1fgv9Rvn0vWmlCD+ED8skd7O7PNSjsPxb22hQsiXvzDRv+sWmqR2H237NJhfa8IT3QA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790892351;
	bh=FTQMWVIJbKsCu86OWrrzxgmUxVfsqhBefh2DEF5MplQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fVPG2Q7xfAGdHuQFh5eRHrN+2BYQlCr9WliQ4QNSIbAumGYuaH24C5x15HXj0Y30i
	 o2qD2vk+kzGH+0f2KCxUPEA/rZwbIv5wdkTgbs+kXuG9gOz6hrP2aGJ08VJaZAvmI6
	 N36I0yV1EbekRLlv4UO8eWMPAeccS+2a8Kqty5Os807xci+eX/79QZHkZl9ARtHBIi
	 Z5oisYBItYqxMUc9ETyBAsq3qpiDUSu1IoYwGr+odehhstLaefqRgbbpPwvjcPownm
	 pneEK3tBkkKx7DBt56dVfTl9FBvE4zaV7ses/4dE+4/uTUuL0GeHmA4gkrzwUUb2uD
	 nv2TM9AZmp8+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 432C440A59;
	Thu,  1 Oct 2026 22:05:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B3E9632F
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 22:05:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A5FFB40022
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 22:05:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ENZwQCC_Ts2f for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 22:05:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org F0E7640062
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790892349;
 b=A9qLMf/l19kZjYFepIQEjij1Cf5sXWuJXtVRAr2RRB8sDVImOV0pXH058Rx7h0zgdcip
 ZQ7I8FHl+/pw1M/VtDhxwBdvXJboQG/OJz/hDQd2tYXEiPFOBx9s0PhdUB9A2yIYgyvbj
 DnnLKxh7zQ6DL/cYrbT0qbf7ISKInkBRMqmJ8SSjGkB3smZtfL+uql24bQ0NBIwWKXVq5
 xiScOi9b3D4S/6IOUl1IoFvkvjCCxyZpYoCtXRu5v9+fKEunKC8uzxIo4zHXgLb5eqbVo
 olpv7WNcp6hU3mb49csmlNt1goEfFLWY9QBM1HlbycglQyOvrDrITK6GEuW1eBZAfIw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790892349;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=FTQMWVIJbKsCu86OWrrzxgmUxVfsqhBefh2DEF5MplQ=;
 b=Yup5bMEW9YqJgW1+ul7GxM7SJcfj1s5Wa5oXgOhGdQ7w4ACuODZ53vG3m0mMQhO1kiqX
 IT8qmf2ZA1d7mFOKfnlx4/OycWA68d1vMC5WQHdUqyeJTqO6YkBPVcqMntRB3nwkw0r4k
 Z8JaHl/OxPGq7izszLInB8yZAz/4kcMM4CVihyF+511FEDmhLK8TdLW8SUV81zt8tWn6f
 BNr1gw8YrNEDyx4W8X/AeCzKVxmWPH5on2l1YCaXbeNOQ1WWE2PhvjTMgal2WO1IuL5/G
 Ys3dvaBhWTken1wLeFi7IzwJBHpVQ4rBB4RfpVZVtakNjU4dkCcZ20QRXxfyJK+TDUg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=OPPZW3gb; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=OPPZW3gb
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F0E7640062
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 22:05:47 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-8198a3a54d7so2994721a34.1
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 15:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790892347; x=1791497147;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FTQMWVIJbKsCu86OWrrzxgmUxVfsqhBefh2DEF5MplQ=;
 b=OPPZW3gbadru5LwfaA6IXsgpP0v3CHQ9fBPKm9EkkLDEBKCOOahxBzaWPuFSynMrC2
 kscxOWioH2WbnCkXUm+UaD1A02tIqlLXJaH7EalbdJWgC/hf/zcKxJNPTbgxJfEOty8F
 ZDzYbUwhTiDy8oKtgLFDa/49eRmgbql6bes5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790892347; x=1791497147;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FTQMWVIJbKsCu86OWrrzxgmUxVfsqhBefh2DEF5MplQ=;
 b=E8T5XJ6x99FHS3KUyRPN29bguZl7tO0Cc9ToB2yAm0IOnPMkD+62k4yUSUtOky0M5u
 2BvQAwQ6IbU5nU5/0OX8WS4zFswO/ZaoVwRHPr8HM+yW4bKj+QQxD5FxfccbOH6BjtiU
 BleKCh/GdVVrRk7+Bdan3WjzDwBjiKmPNVzZNEJGHGrgxbFzyW07aB/J9wT68rVGIpUS
 UJxccodpaOYQxh8JwBZwmrJJdLmn6QAAl861WC+G/d/hFqnofgPbKijIgIvF0j5zKRYN
 y7uZF6CSeRHEm2fdi7dNI2PrAQp59ijvfvZg5QKVFUeoh07PeXL1R0v2F3khanJKIn+I
 EMng==
X-Gm-Message-State: AFuF++nsYHPZ31Ghh98uwzuFnZ8I8pLhuj2DP6ILqqhJdsglkObmQ2qX
 eOBLG0GHTsCDl5UkUQ9ajJ6oLNpPUs9nkouUyFvv04sXec42AlJ7IxP3+bl4KwqmE2448c5Qmk8
 HhPcqr5MSuNKN
X-Gm-Gg: AYBFou1Qf3CncAuSTlnL2YH8xRhfURvH8cgxhA6PMRlxaMRmZhyW9KP8+PI3VkenCDu
 JC/d7mLfK73uOT08rBx/TsBA2M649m9EPgEOmhRQ2eOH83Svegx0Y0kzJWY6IBJ7jV0gsKmSlpq
 3iXGn7mkXuJQUYPTlmYat5WrpDjxO2sAFV4LpeKG8LJDv8W1BSrYO7F2hSHaajbc77fI2QHvVH6
 +U5gdJ5dnkWTo7Pg8tka9FoV9oG0MrOXYO9+Dd3xORWSwtXiLLwSSlwlaZTPZt4L+efSN+CbVWr
 H735We5ZrybH39HTpthdBHF9CAzq7zdag1kwjrQYtupZACWmH7m4GbGSKWlZyMcyJd7mi0md/zI
 Ro7rd1k8SByGDGDpQM13O/rV2vszPcwzPKFK5cZLuMNCux9Q0kZdorwBwvYqoyzc6SoSsMqXx5Q
 /HWGSrAG/BPknCNi1jLDYKyXtPCLk3ch4YL5TN5LFyiBCwQX7k4Eglmz7bBYtbAo3Xvc2UKtiLe
 QRUMJpshleR8NP35rUt+/gIVJzNbmgpsVzx868DjRZC5wn9xKrQnuFScoSMhKK6esDGcJYmwR3I
 qN6sCDQ5hK31jFBr3IYiKr9WHBT+oC6meFw3fawOhDQ=
X-Received: by 2002:a05:6808:1717:b0:4c2:e32c:1ee2 with SMTP id
 5614622812f47-4f30949a181mr3639988b6e.22.1790892346765; 
 Thu, 01 Oct 2026 15:05:46 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4f5243d47absm484897b6e.8.2026.10.01.15.05.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 15:05:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io,
 Casey Connolly <casey.connolly@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>, neil.armstrong@linaro.org,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Royyan Zahir <royzah@gmail.com>, Vivek Ray <vk092kumar@gmail.com>,
 William Bright <william.bright@imd-tec.com>
Subject: Re: [PULL] Please pull qcom-next
Date: Thu,  1 Oct 2026 16:05:43 -0600
Message-ID: <179088838664.888564.1570580444733552353.b4-ty@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001103822.11971-1-casey.connolly@linaro.org>
References: <20261001103822.11971-1-casey.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Thu, 1 Oct 2026 12:20:32 +0200, Casey Connolly wrote:

> A small addition for -next:
> 
> * Improvements and fixes for some Qualcomm clock drivers, particularly
>   for sdcard
> * Fix dtbfile env var being truncated
> * Work around rpmh issues with bulk writes
> * Teach the rpmh regulator driver to enable parents for regulators
> * Correctly set the blk_desc removable flag for Qualcomm mmc devices
> * New defconfig for SM8550
> 
> [...]

After fixing up the few cases where Balaji Selvanathan had their email
rewritten due to now-fixed mailing list issues, merged into u-boot/next,
thanks!

-- 
Tom

