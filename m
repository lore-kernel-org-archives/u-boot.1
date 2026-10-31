Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87485606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 08:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Kpt5YeCM;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=XcCTmDSQ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0831440B08;
	Sat, 31 Oct 2026 08:47:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v4SZ767zAO6j; Sat, 31 Oct 2026 08:47:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 30CE340AFE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793436475;
	b=Ci7NKr2lZxHaoACAZLocvxoMqUF+5jkqEnwlO6rVPwhc9Mn77JAWZN2FPqLIHsiboN4a
	 RQF47yqFXrrmhh7T5BGitUyRC/Af7AizPJstn89nz1S629rxUVdIjpl1xCK47dRMdRAvj
	 ERCGRwLM8dCLCTl72+DIg5mI1k0V4aV0ksDO9MjL5ee+hz3qmZE8RDdYFC+3e/cYLrMMl
	 Wh5iXwbRhuDULQ7ZfBtFUlqKVdiunDDNpeFDmKSUQqJqkuXguPmyonWdJTjMWxkI4f/kO
	 jY5oc4NIVDdr13hM5TXWXnW6WrEneWXBNIFmOmSQFKKl59Ga31Bi221Cv51qIMe/PBA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793436475;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=xIPMKAjO3Zjpj/CqO0e7TapVLM5jZRx723Ml4amj2B4=;
	b=ce316aaJYA5XVIRpDT98ccxDLjzHfSjL/j2nvI48x5xpMg2KFg9TTV0O0mk6cHBjPP13
	 S4UXk2r42iwNi1FzIBaiCZ1rCdkbswQml1zp79j6bqjEJcriNN1dZPt/C77d5W/juTtRV
	 SzN/mR3SQ043CFsYavmsD2nkXAYMFs5Cg/S8g29jVDGB4kRKBExIsK4y50y5NskkPCCry
	 eIILb7Wlda/M92y25B++NhYWUtJ1JeJR/n9nL0znZn/YgNT5trCNybJnS8stAaBTDKSOL
	 opsZowAMnm6ZaaN+6lIEiI0HN7aq18gL7IVmovC6+1oITur62b42Fv6HpWDlZnH6qLw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793436475;
	bh=xIPMKAjO3Zjpj/CqO0e7TapVLM5jZRx723Ml4amj2B4=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Kpt5YeCM2Nsr+obgZfrtTkKs2l+V1Pc2lurOk0zs51gjh6osSa8n3JkUAI26b7L2s
	 zgu/mqBftkTwJwhVqyKIv7HQrcbW6WrWm4oVQs5sqT2QFO9Gio6Yw4TIp9ESAhkYtR
	 TVmmcvMuu8Sm1NVX6ntZQsys9FJMKlSYSNgVfLTfMyeOFDrpUAuLkSmo/opUTuFvvJ
	 swEApFlIwkaj3mWf5zlx0N1bRE41a8gIVhZWl3PkNENuSH8Eey9VK/YYvcJ1tbUJ93
	 3fQPb9zjYbLYBGUEg0sEC+92p1SJOg0EVcQEAJRV0kQ+lHWeQ6kGdnWr9NV8g7byxo
	 q9sG73ePzmwMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 30CE340AFE;
	Sat, 31 Oct 2026 08:47:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CDB38529
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:47:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BD1A0810C2
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:47:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hcckNj_slrWq for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 08:47:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 18C76810DF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::52f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793436471;
 b=dmCfZEXhst0ijwU47uS/+d6x/nw4KIvnMSUsSjcekvDyVwuvITe8wfUQm29Q6zCeJ1Kv
 exXhOWRycEQJvJzBpvkOVm5witw4bvf8DY2B5QyhX3z/uqTiaowL3KVDyqAkMC0/ihRl6
 du/7myDn/8NzAxqwivWle2YRfgfPr/rIkkVWub2pr0bUSWQI7dN0VwgcxE+Ym81WXXHY/
 4Dae1Og3+dKoa6zNCmGVqzpLQD6L60taLbda5+S4C98ucKfVsXRuqymVGJPMclcn07538
 Hyk3gm70TP0ciUsmUuN5J3PKbl47Qe82WBIVypYIxArZgod+l9MO3XJnssulmo/Prqg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793436471;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=xIPMKAjO3Zjpj/CqO0e7TapVLM5jZRx723Ml4amj2B4=;
 b=bfbacF+KPeV+y0+NRSVIUAgLYARacxs63vFznJS1JMsBeOwEqsX589l4QW6Nn0RBkAWP
 e6yzEqX1231Vwl2cJ80h+uuGEo5hLpyVDo5Nwzs0RqZ3LK33johTzbM15EPKTvM8VpclH
 sXXautmhbewarQmvsOlHhWOhq3Yco8E1isWz2NvZROEMQy77xkfY15tKnNcqCvddWxJaG
 arlSqtEMC2KvH88nXksodns3ffX+L8G+8rKfuDDgzzt64/tcru4CYmyrD3Ve7w4eb8eEP
 QNTxqI4q0d9eI5UHoitaGX87qybaaCHFNlJ6XGh+lbcE2AHDoEYTohFvtRg5Q0ppT9w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=XcCTmDSQ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::52f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=XcCTmDSQ
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 18C76810DF
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:47:50 +0000 (UTC)
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-cd61cef87f1so604543a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 01:47:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793436470; cv=none;
 d=google.com; s=arc-20260327;
 b=bV9L3qk5JjaUTm39oeFQvyGy0ju4uPYvjQnG/WpxeVh8emyMghLheKEsMqajWaRoYX
 fiVEmj4+tLth2TuhR67oRrFPW6XmcqcyijU0764WfWEuo+Vk3gHFdqpzlKFJIphKBGXe
 WMwcVtAnXXMgVTBYS/ECPqmftF/EOhYcbMNwO6fYHGofs5JGaFGGoUO+LWqFL+yoSLVR
 8Ft5Z9Fe5d2tB28uFVYA288TtWyyVUs0Wi5u3whWSM6zPUpxqoxhmp6MnZFc+oKpZic+
 6VK5gDVfS5ZvKPyfcY9uA0ddIi2UyTUeyUiB+rrBRAmA34ZllEnfMVdHK7P8if+v445G
 tI8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=xIPMKAjO3Zjpj/CqO0e7TapVLM5jZRx723Ml4amj2B4=;
 fh=3OPxXwEfu7rysfHd0IYLLbD6TS1BzD/8YbaJf7oFczQ=;
 b=lOMxu22x6oLF6SZaejPwpMnKJi+WvWXkzADJ4G6e3c4wFcNIQqk7mRD2DDB90b9GOd
 Pw2mGsgW5qtO0CQ7fDWLYw0geUtK9bjkeaUxRYD8h0jPSXNgezIm7IewZ2CwdX4ImeRA
 Ed1t7h6+Zej/SYQOQoTEnI/sczTLW+8te30YxuzYieIOahSAjMYz38fLJ/nHUmdC/Bnn
 xpfdVs//IKep6VpUHrj4IYZ61zxMG6ljni+mecvZzW0FXIB199RDFkP3R3q1tDnnjuMi
 bM7gPZkWiW1kSyOoaXH1vpR0W5mn36PhJtDjcC3UKw/V5l1+Sl8jC1YqdCUmsQcNIPsN
 YO3w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793436470; x=1794041270;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xIPMKAjO3Zjpj/CqO0e7TapVLM5jZRx723Ml4amj2B4=;
 b=XcCTmDSQZSgHa3mvCL5pLXNmz6a8QFqk9LRbYcrOnjPXfLMYKisybQtkVNN93PbC3D
 xXXCsdVn/jMnRWUiRJDP1S7knzEr7werCBW4OLmkS5dK/ksPS/CfVtTFK9Ru+77X4RNJ
 q+m+POztwwdm6sgEpZORBr0NFbze3axAnM5nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793436470; x=1794041270;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xIPMKAjO3Zjpj/CqO0e7TapVLM5jZRx723Ml4amj2B4=;
 b=cP5uC4Voe2rE1b5ox1E/UykdORNCyiOJ5+tpz2xs93nYIeIYbZOfAt3VTW5lwgpqML
 grz1YaCPRsAUtfkTDMDAJm2R1OeIGvnbGfDSMwXUZj788NAUfS4FxwD/cNOBWM3rl0fl
 uNyvFgdMYfsMGzDfLhf0nILHmrmjLfRyDq7luXxZwgc0/dH6dcc5t7We5mi2qsXB+ifR
 x5AQhOCXN78/rEZxAgQNyAB6Vi4SY89NayLIXxKdy3UrYuM33h4UfWa3v/iXt6OPcWBv
 qSrkh89BCsa7tgDYDKCoAt6WGRDKR+4pjCs6BO37oNa419IapJcxHeaUBltPfTXp6jBk
 4I7w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwcTg46K60J6s1TYo51VsiOGSW7T1s0x8A5UnmVxb+vL5pGjWW7jTU2kQ93BYzeEttjGWns+BA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLwLh84hu/gl5CgTVbDPSBFRWbEsg8aiUPMijkTNUrbjRyb0m7p
 JeS19WaG9C0pZvQG1GhoCIjq2mZU+z+01L58b2xyQrUJmnKP8WaoGTfiBtfnigrvULPOH9je9wv
 0CVR24TGLCKvdcwe0xGfKde9X+/zAe2TFtCbmXRG0
X-Gm-Gg: AYBFou2AljiwKPzDWKEuH9RcMrkW6o4RxHe4u/vimA5GRndC1fJQw+6CprAzWIaPxaA
 /b4VAxVUpANUexr6aqbY5AXEL77z5RtGVcIPkiJz0byBYHHJZIx7hnAit1caoneJj6wIxuLGh7U
 0LHxVrL4tp1QTHLIrUlZGjg4cMFSAUmHCALB8XjgXODTRpJZPiACRTke3uYI172LF0UyGHY+tKr
 1SLJCujLfNuj/glLJ3nbXIhTeEyFm+kZ56S+ckl+1rHbokf5NapLsyFLFA+tOOFoCQGVaXGYayK
 CU+0Iy9ytek3eb7sYm8Qdig8sGtkCVfS4i/CRxvdvWnw//j6FRKXNj6Vv78EPWL7Kj48CW/cg1M
 SfAYjvhtifJEn1fnrJijLUsGRHkMrlpjOeV89p2lSFjE6Euo1zawUddhavYQiBx4jukC8TnpuE6
 dAXnSYo95cKMZ64Qk0
X-Received: by 2002:a17:90b:4a02:b0:3ac:6fcf:81a2 with SMTP id
 98e67ed59e1d1-3ae89821660mr3633482a91.57.1793436469982; Sat, 31 Oct 2026
 01:47:49 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:47:46 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 00:40:44 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261027-blk-part-unbind-v1-2-e44d2b48ced0@kontron.de>
References: <20261027-blk-part-unbind-v1-0-e44d2b48ced0@kontron.de>
 <20261027-blk-part-unbind-v1-2-e44d2b48ced0@kontron.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 01:47:46 -0700
X-Gm-Features: AclHuK9jZxliyqo8qsZ9dEzbKWd3_7Qwm9V9LhMfLoMlypr8ILBzo-qgzY6ydIc
Message-ID: <CAFLszThL2cpyFu=CH31jpG0RrgJFAADGVQW6qXK2Sj6+u2x93Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] test: blk: Check that partition devices are unbound
 on remove
To: frieder@fris.de
Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Daniel Golle <daniel@makrotopia.org>, Jan Kehren <jan.kehren@emteria.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Frieder,

On 2026-10-27T14:16:39+11:00, Frieder Schrempf <frieder@fris.de> wrote:
> test: blk: Check that partition devices are unbound on remove
>
> Add a test that removes and probes a block device with a GPT several
> times and checks that its partition devices are unbound on remove and
> bound again only once on probe. Also remove the block device with the
> flags used before booting an OS, which don't match the partition
> driver.
>
> Assisted-by: LLM
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>
>  test/dm/blk.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)

> diff --git a/test/dm/blk.c b/test/dm/blk.c
> @@ -291,3 +292,66 @@ static int dm_test_blk_foreach(struct unit_test_state *uts)
> +	/*
> +	 * Removing only the active devices, as done before booting an OS,
> +	 * removes the block device but doesn't match the partition driver
> +	 */
> +	ut_assertok(device_remove(blk, DM_REMOVE_ACTIVE_ALL));
> +	ut_assert(!device_active(blk));
> +	ut_asserteq(0, count_part_devs(blk));

The test passes on sandbox, but I'm not sure this part tests what the
comment says. As mentioned on patch 1, once 'mmc_blk' matches
DM_FLAG_OS_PREPARE, device_remove() calls device_chld_remove() with
'flags & ~DM_REMOVE_ACTIVE_ALL' (i.e. 0), so the partition devices are
removed before blk_pre_remove() runs. This part of the test would pass
without the device_chld_remove() call in patch 1. Please can you
update the comment and the commit message to match?

Regards,
Simon
