Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B47606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 12:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0EfXhMs1;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QtFQv7fN
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0DAB81114;
	Fri, 30 Oct 2026 12:51:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tgJzjG7fwh7y; Fri, 30 Oct 2026 12:51:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 31B24810D9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793364704;
	b=kx+lx2zejKHSIGbbT3aR/o3XFd4Q/3aRr3piwDQYGyJg4Np01XCQNCssEzfvjp02pcT/
	 za3ph4dASqzR5FGW7OuUVkDfTCR/KrB0gf0RQj4ymMADf138OrqHhgfLDVTUHRirgM8/O
	 VYm7zrz5MWWnQb9Q82C3GiXJ4Z1Hl6SC45Jy8wnyh0fNOkTpJf02InT3hp7zdv/HQAxXq
	 iyEPjbTkZTCzIVKf5D6L76nT7/a1YXMuv5+35X2Cf2m+qkxihdKJnMLOL7rASp4Hbq3Aj
	 8kiqMsqudGZ0ZKhN6/DsyShaRB7UELVHFkE9xr9Da5cYj+jYQlftsqE0I8aRh0b+2jA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793364704;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
	 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/H5yGv1es4QG8vEQIQ7cN+TR1fr6/zNBXn6H/+kMMVY=;
	b=chx84+fE64hGQgQJZMXMFGEt9KW8c8LNwmWOzNZ1nxoQjLrUn0wZTINKV+ig6fTB4TA9
	 hg38MWAh4BVVQHdO9leV08BvbqiHx5IY8OiW5G924+pY/1zPEYnmGGYYAzzxeakP98iWM
	 EyTB0TbDpoSwh4mbpoE7za+5HmcvAduGHB0urgdY04kAfS9vhwJRVla/+BjDKhwrEA0Ni
	 qrJNv4bxwX1FbYJIq6aPYYCTT+wlHGYKyMYo+I4xU+lxTKXGFVFaUJO3989aTA8s9E8HK
	 mU/SebFxSIcktGHgntsI/TEok7EJh+k1/Pjf142wHFg+svA9b/rbrmMUlAKT7VFuPyQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793364704;
	bh=/H5yGv1es4QG8vEQIQ7cN+TR1fr6/zNBXn6H/+kMMVY=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0EfXhMs1N8xM3/SLaPJRSnk4m9lRKz37j+IeM9DMaoRws5yG9IVJ40ml6czZRNn/O
	 xmOFwQDiYUBc+gZ3iQTr5qzNYodqFbLZir7Y61o8ZM4OP/zvlqAHUogJsR10wOu35u
	 bRgeYu7msDK8aM1Yw9Gyk1lLbz8WST9oMXKLCI7MMGDev2Wxz8dqtSzxF1/8YNkhaj
	 zYBj2ZrT5IImXZ3sHojJExa3p+P+pQx/vKmOViImHG6IcM1qcLvEcrQu/w4ZiFNa7E
	 8tBihmrDFuc+68CnOgcnQ5JQCSJ/sDp7p6Vf0SNOUGyOiinuElG42VpkdtU39mv2fJ
	 Vh+rQm91HGIJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 31B24810D9;
	Fri, 30 Oct 2026 12:51:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 73639D38
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:51:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5947F4072F
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:51:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CX2A2K4dVChm for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 12:51:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AEF3640729
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::230"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793364701;
 b=sNjEQD+x/dQdJK35B1f8yyudKrslEw4wFVtlD1PJNmc9cszJtFWHlv1/9P0BFW1LbRqo
 3fwFEk/MKVrzBrA/W4atGGcwzFrACGei9cPdkV0PyCWgG0f+kQmqiuLJ3SMXvPQ4g+rwf
 /hdD4LRCx2XRZJtxCkzlt6+DAplcl0taPszMmJMe2mj7Rd0bM35XmC65LBq0299aTggJl
 2hSTlaWPyfx55DqKaJbmrHTAxe9PYoyh1JrpOzSDXQJLupG79MeGdBYIkb3WcOsvnN/We
 4LxDRXOyIOYNfa/U6jpjRV21HEadCQ9tX+HBfZNd9Qq2pWkGTl97McWQW33WVYX3mvA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793364701;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=/H5yGv1es4QG8vEQIQ7cN+TR1fr6/zNBXn6H/+kMMVY=;
 b=o7OHs/UMIB6wRB9UCCHgPRxdwsW3/GfYztjmfCaCJIlzhh6T+DD6v+dFQOszAhnO8Z9M
 7ulof3FQsl1D03bUqpc7nF2Aj0SDv/aLaGdEWFewOr7wnwNDCltRrmpxdaM5PA6yli8zX
 8diW0hUIYcznD4IljamxF+gBqTsfOtjYqqtzg1FHAhQgtsDKbbl74xLOEDBhzVxr4PtxD
 sBPykAooeZG4VAhNFfcAnZG16w7tm25tlosG4wm7WEMsAmp3p2FA1jnBoFbASYDzY3UFQ
 7QYB8sPJGw7+64TaqBLjrKmbJxGuXOCvkk4S6GQo2GbK1kmP8aD1/3rhyKxJK2TcrFw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=QtFQv7fN; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::230"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::230; helo=mail-oi1-x230.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=QtFQv7fN
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AEF3640729
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:51:40 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-4e4a4d77e5bso1212576b6e.0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:51:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793364699; cv=none;
 d=google.com; s=arc-20260327;
 b=TvY7PhpFMo+D+gF4yI260ledRL9xhACZNaD2t5DHg+iX8jYeKREz8UcSQmKggnHnzJ
 uZG0rJB17aLvjLs1q+a6EWdi+AywLslAi/3XXJwNzpC33UmxaYxFm3zX01WI8jCh918E
 WZmuNQCaQn4sJa14FyCeajpRzYKC4A2/pG3pBGG0dDqzGNzLVtncd0t5leT+hlbVLf/P
 IONwklVNRFSASQFUJtD1IWBfA7wldnjgFQ60rKnCCS8qOMJOQAna23QdzRjKwp6rSayr
 AFiTBJZzmw06qwi2mnkY24jPRnOtUSqswrAG5lRQFIfnn3NrARTgZw5Q8wden+In3Tng
 9msw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=/H5yGv1es4QG8vEQIQ7cN+TR1fr6/zNBXn6H/+kMMVY=;
 fh=6Z5R94kQWmzpBWubGeLUUQQv4dr6GcFVBZF1QZFVa3Q=;
 b=HXOK9N0t+n1EdFHKtAnaKbmivjLeirTry6dqmFsv6LFZj+cGWazewmAvT4haIB1ubO
 trEKi9Z5/98NiLY/p8sElIl8SnVoc6w5GaPdkQvMdnxiNfPf3vqQlG6yERq3A6AloCea
 Fl51bmz1z2CgtLd0I0dK+HQnWRInChzre69D8dDUglS68OuowYMAYKmgd+UrL/DQqTeb
 HD8n//leZaZ+K+Na0n14YOYzLy41Sk+tFz7hEddSSgNsnJRLhDbO5ofuRaaV4q9bOxtc
 HnjOIN2WxijhzMtV+TQhOH68JASjBt+kSx059Bdu3hngoa3NlyZ3L6PSs0M5Tz5/tpVL
 4H3A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793364699; x=1793969499;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/H5yGv1es4QG8vEQIQ7cN+TR1fr6/zNBXn6H/+kMMVY=;
 b=QtFQv7fNqjTPSQIdpTOYJ9HtuMTZ++Gd9EiqJ0MmFGj3mziutO/ZLs6WyK5sMQGwD2
 PW6HEmkqBVOkdctRPpyqaKendFyZeyM6IWNLRbgY5szPNXNpgyCCAvGZT+bxV4bjESBK
 KblSgMQsTNlmxkKb/2DROZUMGJ7HZRHt40mNXdm5PUxmPbRhd9Jqind3+2+zyJ0UsZCY
 Lcmk8UKHXDYjooUKitQVhDTAeMjUT34MXi6AAjHmM2S2/4CLrDKWhJYBg4dxm8K4ilV+
 G0oL4jMeJ6Q4wW2dVgW4FQFdJ7sGdFyL9EqM/1kAKJui/ii7vSamLuM5hoJQPiiS1DjN
 7HwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793364699; x=1793969499;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/H5yGv1es4QG8vEQIQ7cN+TR1fr6/zNBXn6H/+kMMVY=;
 b=EqGagrK1gaQc3PA1QIQekjEoKF7Zic2lLfZXNGuEk0wnnx1/FE3gntAeXIt/KHx1gd
 fTKbkMm8ob4NVfDtnxuImKB23aaIejbqANBn78xxTjnRZHbiF4fhJBpX1wSsHL9oTF1O
 hyR4ibkY12EuCNas3w9N0YQxinlWAzmOqk/HfMyCgm/RaNXWqK50MNCkxWwlHAtHLqT+
 p/O3mtceg/AqTBlxCkn1EgA6/jkaMt1l9jf52W7h5vFReRmmKJ+RP/4teuN/DWBiilNM
 XjKgTZ8U0qG5DF3UGO1DVHEQYyfTexwAEGHlszdam0GYRzprcGwX9MK790zAlolb3u2e
 7L7g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwf/dchvXg61tQU6Lge8PFr1AqBWqDdDxOie0cTDG0A/5XhFx5r3cGVZEKE6pLRJaNV+rKmx4c=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJrCkicmSJBwEjQhTEuRX0Bh9p1z8zPZfDvT4McCp/eC6+WCAPZ
 Jrd1d4WuT7pj6IKRkkH5kD8U8AKviPr1457uyQzRQsIRg/y88oHKTpQNf6HWqDbsxXmwHwRbI3z
 GLu34ChAXP5dGaN1RyPMrR4y+s+FKl/3JHs2P
X-Gm-Gg: AYBFou0SUY3QsLeW1OOG9EknniWtzDaNyBhHt2qxBkcYXk6xrXUk3zwdMdYe4nddlU3
 eDQTzY87ietoMmNwXIDAijA8SWH00JjuQV5+/iFxuy/ZdYOV2PfYSZOsX+5FBJ9UUn5uMPIykdT
 +PE21eNMF7YbIaVJM38mZvpn/zjKUVZ6q6fYQWXUXgSJgPrRYjcSFbWXPmj4bP7p5qTSL3YDLUw
 cRnVx504NmkplkLDFU6Sm5ry65VI2Wkv+YnOJ4gw6wJT/t/ahNCHNPRIyuUuWBGEZqeclg4BuQy
 tyihu24IsBizC4CKG/Ydu+th0M9d/B+GrZbdJ6r1AYA1koLbGVvlqehOBSq/F51cptzN7tBuYgl
 KsgJVzVJFsq+S8Ipi8kL55L9aYf0H/pjnvei0nA==
X-Received: by 2002:a05:6808:1304:b0:50d:26fc:e6d3 with SMTP id
 5614622812f47-563efbee16emr2885236b6e.43.1793364699520; Fri, 30 Oct 2026
 05:51:39 -0700 (PDT)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 30 Oct 2026 05:51:39 -0700
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 30 Oct 2026 05:51:39 -0700
From: Ana Bobillo <anabobillo3@gmail.com>
In-Reply-To: <9b5df6ed-a983-4f63-ab78-17f6d6e0a332@gmx.de>
References: <633dddd6-ee22-4cd6-a8b6-cb7df0650fae@gmail.com>
 <50414814-4aeb-48f1-8630-ab51c6eb9a9a@gmail.com>
 <9b5df6ed-a983-4f63-ab78-17f6d6e0a332@gmx.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Fri, 30 Oct 2026 05:51:39 -0700
X-Gm-Features: AclHuK-GhWa9iXjRrPqg2WivkTeqz9UlTTgs8hnl4ojKrxWuP-ATgzT7e0twgbM
Message-ID: <CAJnxHsiQNPZZ4_9x8nKxT8YQovMr+XPq7tfRVai_tNOOFnV05w@mail.gmail.com>
Subject: Re: [PATCH 04/10] efi_loader: check PE section raw data against the
 image size
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
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
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Heinrich,

On 10/30/26 13:45, Heinrich Schuchardt wrote:
>> +		/* The data copied for the section must lie within the image */
>> +		if (!pe_range_ok(efi_size, sec->PointerToRawData,
>> +				 min(section_size(sec), sec->SizeOfRawData))) {
>
> All of raw data should be inside the image even if VirtualSize <
> SizeOfRawData.

Agreed. efi_image_parse() already requires that after 02, so in v2 this
checks all of SizeOfRawData, with a test for a section whose VirtualSize
is smaller.

Thanks,
Ana
