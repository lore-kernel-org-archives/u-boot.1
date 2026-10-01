Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D264CA5FC5
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 01:11:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6555781221;
	Thu,  1 Oct 2026 01:11:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XHAHKJUb6uFb; Thu,  1 Oct 2026 01:11:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 991E981215
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790817104;
	b=eR3dUugSOic3Z/kuZeNQfboIjx4+iRzMaOXRt2cJEz2eRj7y0HdNPhFElLCZbpqed8Ym
	 3FCJRJzuQbKGrnf7FU9l9OcAHQl8iLSHR0K95/O/R7lXg+/90UGmWAVScUN0OEhnrUcFy
	 7t10MDYd3vPqrkIQmoVdWzZ+YmA3d4QVkVl8kkY1BVA+Owh/KMJ1aERxgsWYMQcIo9Q5k
	 VcsWY1Vmoc3Up0nFpC8G8/M1vZDdGtnXDG82Ptc3A/WIKd7utkKZFOzzk14uPRCU/SN9Q
	 TLkTm7O7B/BswcrER03JgXk5mmDeX/ROyPEn5+p+nyjkWUSPmcUzriYuybB+Zu+Ch7g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790817104;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DowJTzV/C45pu1ecg+WIUsS8VtbzeRkFMfyV1VqgTr4=;
	b=eXW/a5WKbMVJgQA6y29GXFaW4vwew02913Kq/m9p3MJjkdJA+B2k+y0KUY8+c8CRvQbf
	 40wAzRqs6DHzXHvarmluCt6CeXlDj0osZGzar8iHYeX3DMJ7GOu3nhlFkyrGmtvtnUv25
	 GJ41T9DZvKAtp834va746RToQD+JaTbWl6YUxj3R4j+Bvao4TuIZx/d9VAARQK+9Nv4B1
	 dBF22LgKf8Qd7DO6HLQKcqYRZfNerLCAPSLM97eOOTRDMRV6PHbdWnOWNwBljgtxtEDCI
	 75NJq1VYozgIFbg9C17yH4edO3W4lXFvWJDJrKr7nvsQF23bHMqi00yc9b70OfbbMbg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790817104;
	bh=DowJTzV/C45pu1ecg+WIUsS8VtbzeRkFMfyV1VqgTr4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kpFFhdzzeKvJcA7HBKrgm98WDJCoW07UnrRzEkAkHDe85Ezgi5XxZDwkOgpyFyuH2
	 aTxbi3eWO7dLM3jzb33HB08g1MhTdGmB5/z4EJDsZdfbxyxUkEb82/nWIFb+86o6av
	 ENux8ri1FdaP1vuKvmhrJ9rusFhCDJab/8ey5o8wXq1YghyAnwfMS10y9KD98FQBrX
	 wBMdkF6l4peYkpSego8r8L1nYRl2fNYKxT1C/p3/Wf0U80f0avPM6D4u+xnBa0Ms1u
	 Ycf2JjjO4kEKrrWOzbuhqRUMbGyueh76AFx0uadSf90YfEcKx1WUWYu/XavvR4Vcyy
	 L12WSWdszBIzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 991E981215;
	Thu,  1 Oct 2026 01:11:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2C1B21FE4
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:11:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1DB8860B74
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:11:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a4mavvx6YK0N for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 01:11:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 833EB60B62
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790817102;
 b=NTOnoqBSxFcL9JOnFKbuYQNbEnK9V6p6P9Es44z70uP5wi9kCV63zGqyY2v+y+rua3Vj
 3ZwHXYl8wKFtU57qZLvwlJxy9Acxwgig/hpr7/btKvgHi1AM1vcGDh53NXV0eR0SHlpe6
 6/87rKgKSjlbNgrb58z03KAB75A14dWZ5A69zh/4rmaNjB27U+U7NxzZvzHJ0iZrffP3r
 D/acQLuRASq9e4DS5kfVr0kCPqvr18SVXMfwQvZINL+f3vn+bE6cDqEcW/g2PUYrV++YW
 U8hH4IonLUk+HhdFe6CqegLJ5OwZ40MzcZxfQcK3TPnkXU4vx8kX5OEF02d5dbbC9Fg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790817102;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=DowJTzV/C45pu1ecg+WIUsS8VtbzeRkFMfyV1VqgTr4=;
 b=K3pbVBM66Qh7Wlv1yda9b0JSjOYfmwKGzV19SwZ4goq/eOnzGyMH2X781Et+oxtTGKeR
 gqQdi8eM9FxJLP9wfigmD5ZplcrSem4fK4ePmLxfR0s66F8rJuhCVTds8qP6Rhlk6X5jm
 G3qDEUQNpd37+EMFuzLoREqz3BTGwnTPwo9pjU6d9VS/yGd8ZBe0c3WpTVxKro4M2QwkB
 uB5ehxaWsg0tUVQ9Z0AoRACIerN/F7aLk9BTtGQXfS1SOyuobkCbJI73/Xp38oAVLgQqj
 PWWh4/Ctj8oJvFq0m5oAeE1gbqGC48dnlfh0ojKocyu5OVlsTY4D1EhFCsU3U04lBfg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=nNn93ULZ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::631"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=nNn93ULZ
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 833EB60B62
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:11:42 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2dd1dcdcf95so1174315ad.1
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 18:11:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790817101; cv=none;
 d=google.com; s=arc-20260327;
 b=liK/rZoE0tuon2+EZWfwKttWJz/ZRnLf7NSvmH+CEirdasP168xkmuhlMf6XX40DtF
 p2ooD2ih6zZlfYL5ZNV2dcKYzO48oiOUS/6boG7Wm9bS4b0GR8VQn8nqyXla3QHM0ABb
 vzbyG4dyZDZSa8LXVz1fQ5wUqLuHfHGWNqzduBvSAolX1ZcwHoaskNtT9QfGOOjoyec7
 CcwCvFgk6JkZCaObzwuwZKSIiFu36aeULqFaCrtIi8UYaSlmQFH9JccWSynOvlKsnYbn
 fOK/rd39c6HmAC0+3yduCGEgdiCB/G366BEzfJ5XowSoZk2yR9tfart3/p5UmQMuBIdR
 75Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DowJTzV/C45pu1ecg+WIUsS8VtbzeRkFMfyV1VqgTr4=;
 fh=dZ0tJMEGsIVFUzoIG+XzQP0n93LR20+4J2Xk227cWpM=;
 b=O84+RvprZlUD7QhruE+zDiBO1Cf9+RL53HJD2R8CB6pW9OBArVFL9nKDn3kPIw0qgr
 sT8QsJNik23YNcay6j0jZgV5KNkTF2zIdzuDv0x/4nT2jYdcecDdoJjH6pqGudnCpBBH
 feaMEFnLF5++B9Iyioo+yZDoxnNZCYPPBh5nGFX8xaKoaW7DcsrJaBwk+FhnX9iRVoy4
 IeZpYgkwM1AYtzUBiB4AfEgIPf3nvfMQwS9bRL9oajq+bgWgbxHvOx+Lf8eRWGCy06dk
 FUNQPTWdeshm2JNBPbcuGn2EJXQ7CBiiWHNqyr0SUili1IHtfYmlfO0USj+mqP2r2O3J
 MDUA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790817101; x=1791421901;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DowJTzV/C45pu1ecg+WIUsS8VtbzeRkFMfyV1VqgTr4=;
 b=nNn93ULZPIDWP5e3/rX/c6/pv4rdo01xStRNmF00nbF0Pg/adxlXioo52mM1NCMw9s
 63XDkgcSM4v03Zw/R50QbOCfGOJAPRFYpHoRKOmxl1YZuH+//oEycFqX7c/bGfuX5H3d
 XhJIEmwdEPcV2h0B7TSxLefkoH08Os5jXC1so=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790817101; x=1791421901;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DowJTzV/C45pu1ecg+WIUsS8VtbzeRkFMfyV1VqgTr4=;
 b=y7nxEV12P1wv2C7S2pU9W7fvBzBpXVn0xMyz4MQV4kqO6OgwvZrvCmdf/SE7ggBkbJ
 zzV6G8TFpAfHbpc24eAhwBA+sVtoY3TeRgYatfJFPE2QTRw/49UET69kYD+9TLFan4aC
 BPkrFkrYB67Tm9RSOHH2QcSw9muRwyK2pdBM3419XzH1bH2vYAEuyorkPP6D0k532J70
 Zi/guVbXTztkTm3Gw0TsyuZGr1MJ8pE3Fz5vwNQ2DVdWub8RYHkwJllZ/E/EksuxcUoY
 OJ8ESO4QJXTfbfUU5L8mfUl+KA3ckIorpRolg7MrqNviya/dczzdaw9YI74pLkp3w1lO
 fV4Q==
X-Gm-Message-State: AFq9FYKcz1SPMFfMW5Jyrr/Sr95H8ADYEjec26i80w75MBc4Sq7NYJq6
 57X1JBu/sr7HMiWy0HNLzNYqvOyUyZofYACr7pfrP4UvLAxagZQfYJbBywtl2+UWxqx7ijE8M8z
 HrVXblwMJjX8WKFmOampKLMoulMcscQmxNYK2SBpb922ETIkOkxaTAw==
X-Gm-Gg: AYBFou2WZfScZ5ZgyQYNdGMn53qYTRnz9U7vrZmky/9oLnvUUdPT62NOKdhaQGjhvkf
 OdQFaRreJIDb/zmafag4TxMk0mKlMNRviNOL6EYubTg2+7VB2xkUX2R11j5JrZD2Bwv/peW/CPO
 eqCYGxvF6g8DAVFLryfFobB5CqIuEcgAyzwcV/DqmmRGItGAT/d8FyCyZcDdzat6DLi9UF69qZQ
 sbzzo6iZw+G2eg98Zo6UahWQIXnIvjJeXMwbj1SGvCUU497sgRjwDJAGeHofUOhR6ucoYLa/mT9
 +OyjlPvTKfoOwVMKla20kdEbYhszFpEQwQoHRkGZdQe/KZjdsr6pD+oZ
X-Received: by 2002:a17:902:f78d:b0:2e2:e336:f071 with SMTP id
 d9443c01a7336-2e2ff909d75mr7012055ad.1.1790817101577; Wed, 30 Sep 2026
 18:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260930085220.3226707-1-suraj.hanumantkakade@amd.com>
In-Reply-To: <20260930085220.3226707-1-suraj.hanumantkakade@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 02:11:25 +0100
X-Gm-Features: AclHuK88LtNC9WdO91Q9OC7slqm-i8g2moXw73dUuTwQFnzFMHejXrRhxjaouhw
Message-ID: <CAFLszTjjsyG-UP58S_sQjz62otUQ7ZYM3xueyxNPRTTP-1zspQ@mail.gmail.com>
Subject: Re: [PATCH] boot: pxe_utils: Fix leak and double free when using
 fallback
To: suraj.hanumantkakade@amd.com
Cc: u-boot@lists.u-boot-project.org, michal.simek@amd.com
Content-Type: text/plain; charset="UTF-8"
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

On 2026-09-30T08:52:14, Suraj Kakade <suraj.hanumantkakade@amd.com> wrote:
> boot: pxe_utils: Fix leak and double free when using fallback
>
> When use_fallback is set and the config defines a fallback label,
> parse_pxefile() assigns fallback_label to default_label. The previous
> default_label allocation is not freed, so that string is leaked. Both
> members then point at the same buffer, and destroy_pxe_menu() frees it
> twice.
>
> Free the previous default_label and clear fallback_label so only one
> member owns the string.
>
> Fixes: 8ba82a91b3aa ("boot: Add logic to enable booting from fallback option")
> Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>
>
> boot/pxe_utils.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
