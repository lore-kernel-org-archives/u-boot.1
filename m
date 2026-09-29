Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8386CCA5FAD
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 22:45:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 929B081150;
	Tue, 29 Sep 2026 22:45:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1D2KdOafA7u5; Tue, 29 Sep 2026 22:45:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8C75381162
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790721946;
	b=hjDoOWeOwmNiLc4+moUI/SyJNFco0dgpTUQs027ZI77meB0TQ3OJ8kRuMK1hsadxK6KE
	 N+Y3O+byA45yj6w53sVBZHPUgU0LQPGTarhXk8vL4YNAqGXBQE+WPpmBN2bOY1grYHk8E
	 zQJT22VZ4Wau3pcPkfR1WxRoZ8dS9pTRINZURybgy/O9/tofTRBCQKHVGONqIQ/GKIFtN
	 NWMuDNPgCHVqUsFv6m9qqtA7IGdDudAkQaF4vjadBTo9lJ+aJKe5E1XulbE76hcK90nGI
	 yMlVXyVlyq4SXsT5t4lcfVW7PuOaPN30OaFNJht0wmrKwXk2zgrfkaxOQynE6x5nqMw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790721946;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ym5DbCV2cC6KQ4qk9KZBEALxwUxs1toMOr2iBr4i7eU=;
	b=N8Oq99lsKGhmW+1S13SrufdDyp1Hy1kNVR41q/AK6u1bmk3vu9vA/IIhlXPe8174gePP
	 k/PcC7e1ddMgum6G2VTyB+ms+BjJx+TAF9NIm86ER6ykDJNVzdUwv9WoJ96qOqW54EsRN
	 VR/8i2gboGAaz29ouBN+ZZe+cGnXkD3ERKRSAH9HxKEhts6HXpf/rnsvkkxm5FGgx+OCc
	 wInr5JJf4tHiD8PQFVQL6YNefTnsPRsnO5/dMxzZwzJYsL10+AIaNkb1hjmIzqC+UGS+O
	 WVtN4bNy8761wlg524gLRr5j60lT+m3ECLkexKpQUggWo3PSYxOdXTuTkxboi/6N6Ww==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=drXl562c;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790721946;
	bh=ym5DbCV2cC6KQ4qk9KZBEALxwUxs1toMOr2iBr4i7eU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=prHCRESkLIqo/BEoJb+FEALnVjMN/H72EUenSssrd6Ly5lqaCBJJy6keIrcxE77u7
	 KvDTY3jAlOH8+XLCMv4v2NvNcQb1mGGF8HpWI5hlcPE9vHYKA1G7T0yQSPb/EnubJz
	 r//kF1dXtp9vqF9lNJAIOoL4ZkDkUQc3OKYTE3yEbcFKwhwCZLZ3/W5L16Kmp7R60n
	 idl5aZg27jbj5sQfU7ATT4+aypM8T2+KMrHE+5FcUD/iH8Zx7D6ZeLrBwvIFuk6yfU
	 ymoEecx0nS1PQjc/BFki2Qj1mtWk27UHjZCX5nk16r89DvLn7MkDhzOZYM2j0kvaQ2
	 8Br/3HNtBlGxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C75381162;
	Tue, 29 Sep 2026 22:45:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3348E33B
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 22:45:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 21C7F81131
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 22:45:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wf5EvgwLMWVb for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 22:45:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 67D0581087
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790721939;
 b=maj10ponvfXhPyYfYhUYF2zMSU43o6Xy40jyboZoZYDfhsLzwcNdRwBIhqjYYNVVwtFe
 6TyuXawqnAs75DuX2vZXtnLM6fG19LaffEGH0fMDGtQUd4rRq9dst7AQ8i2QmOpsWF+KX
 w8PksEZqD5VGixQPCfm0jZ0PpnJQj3sk+d3kveSwl6C3VRoQxa8Y5zo0TPcE2bcpaIZ/4
 3KkGC2CyMAhL+0NnVjAzlUKQa8SXJb3kVF+DCgKK/yvbu2EVLo0DbSzm/tt+WytedYBuR
 bHcFUIAI9BmkVXJxJiw6rMPiAi5Fyf3Ay01gK21UcfcV6wIMKRqJvVssiQqU/jNr4Ig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790721939;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=ym5DbCV2cC6KQ4qk9KZBEALxwUxs1toMOr2iBr4i7eU=;
 b=AMCy4OXqhVPOGd0oq+fityWhctCYOlRF6XBZAaDWjasgVLpRjoiH3tiCSrMADOGvT6d2
 AHK05YgYGDBHbK33u1zbDnxRPTJCMfjVoEJgevH0N7wU7+cce/Zg66MMorfz8yk5BU2dQ
 a0pRUIPQVkqwWaJzb1a65+X6oOg+cz4JlwoxJU5UMkAqMhDgs7ZdFXAFXe6m5qri22VEz
 Kn7qZ3dPeoK6F5YwIpykTkNfA6e23ZaZE2H7MYGXBU9JJ0vYwsF2rPfOigR11De43nG7s
 DQJbyQsS4RMMPWZJhv7lbtFw5rNjZy667HnPiodad8e62bGGGkt6ISnsxaLqBw4hkjw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=drXl562c; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::d;
 helo=mail-oo2-x0d.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=drXl562c
Received: from mail-oo2-x0d.google.com (mail-oo2-x0d.google.com
 [IPv6:2607:f8b0:4864:31::d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 67D0581087
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 22:45:39 +0000 (UTC)
Received: by mail-oo2-x0d.google.com with SMTP id
 46e09a7af769-8177a7fc354so2507308a34.3
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 15:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790721938; x=1791326738;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ym5DbCV2cC6KQ4qk9KZBEALxwUxs1toMOr2iBr4i7eU=;
 b=drXl562cWDzFTmYPpPIycF+9An16w9WbY1zYAudQT3RTkgO3SI1LjT4Zt7JWvliWdT
 Iw8ODOTV4EdUESa9Vm83MgVG8ZYHNkqYqNpGZC/oMsMugut2RGhiIE4ku5oYft68pzGw
 +3UV/GSv2Ltufqdacb4DgwHl/ioaO25tBsSbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790721938; x=1791326738;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ym5DbCV2cC6KQ4qk9KZBEALxwUxs1toMOr2iBr4i7eU=;
 b=mAQyWtdLgBgrHb8WYQLlxxo/z0skE5U6AAZInN3xfm+kfePvOWXqrloM9qsh9331ha
 QCrHWWlDEg2R0fuS8113L80s+XMmBRhQmUbAnTi3Yi7TlyRnnmtwSHmnU+dosukxwSob
 B66d+Gb1SW0EG8drtGdU6HYdx3yhxg6FVemRjAborX6FS16fvH1yfvxaQT5vhThKCN+n
 wNis0jdWJ8EvmJ5NO2osQPIsI8PqC+9w6kTlAZyXkByytGKxlonYrQp7X75dxwB6mWaP
 OKFIUDEF4lGsSy82IrF61WqjzGFpwoaRA5bO80wRoAM5NLQ/6ZcqBAgGvqdtl78EkqLr
 Gk+w==
X-Gm-Message-State: AFuF++mRG3MJrkFbptlA0XOq3Jzn82/kp1/twLf3e0z3Di8qlGi9VUkt
 vvpl+x0BLIYo0OrdLnlQWgOmiOshJKoOtZATMTiyLd3sCQcc6jS4Lc30Za/x11aFB0IEPj2xnGG
 /iyB4dyb8MyjJ
X-Gm-Gg: AYBFou3eCgbwtaif4bFnqMBsnN1Ytk6oeNlJUUmzmC1pdkeh2SU45qfI525CG/WHXxH
 Ey8stJjeiXU/ZyKZr0qfqsqAeZlp+VfyJkhCMCvS2VkpKgi6+gJqbYQFJMgyaTxB16jeNPzH3ge
 9zxT0tABxORSsALXj5jwh2BUbxueXNnExgyaafkzu7oZFsfpm16U1MKczoHWluBTEpN9q20H+j6
 rdlprHKW7EmpXzo/hVdrL2e7Mq6ZfRydnTU7SsrrKNJSYZyYS+pVVbPCUq9oyE1bH6R+Owd0zRh
 nakpl5fyGhf8GITBE1YpgI8mHsaDm5mNQdmXKnqQiLt6hkMZ0DEVOF6aNg9Z8B3lL7l8HXLZlbu
 0t/R18CGE2/MsE17vY8bEuljQnIc5IC3kErMlSvbr/6fEHo2vx0HnTDjtJsECo1GxbIfE9/FUjE
 4HQA/PLvCd2YA9fBKejqTRLTEkSQVdwdApKJdpZIWlNb1eq6C6SYvMGs0FLONTJf3+wMtfwzz5x
 uVSUsz8K7/SVaFr5rGgr7EtOtHND0O3rqxliHmG5PPVEIZCgP0fcgP1QmOZBU1AE8jE2VYsTPlD
 DEjTj3iQV4lExbMuJw==
X-Received: by 2002:a05:6830:6412:b0:7fe:e653:9535 with SMTP id
 46e09a7af769-81fd5f4078bmr1088765a34.16.1790721938277; 
 Tue, 29 Sep 2026 15:45:38 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-81faf7eea80sm1159921a34.16.2026.09.29.15.45.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 15:45:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>
In-Reply-To: <20260908130800.1144691-1-Alexander.Feilke@ew.tq-group.com>
References: <20260908130800.1144691-1-Alexander.Feilke@ew.tq-group.com>
Subject: Re: [PATCH v2 1/2] rtc: ds1307: support register offsets
Message-Id: <179072193712.236406.9670311774006021755.b4-ty@konsulko.com>
Date: Tue, 29 Sep 2026 16:45:37 -0600
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

On Tue, 08 Sep 2026 15:07:58 +0200, Alexander Feilke wrote:

> Convert the scalar type data to a data struct that also
> contains a register offset for otherwise compatible RTCs.
> 
> 

Applied to u-boot/next, thanks!

[1/2] rtc: ds1307: support register offsets
      commit: 32a5245e97e114b354ae5ab41463471e52099db4
[2/2] rtc: ds1307: add initial support for EPSON RX8130
      commit: 9ae91ba55829201a851e0936e70bc5a369b0d0ff
-- 
Tom


