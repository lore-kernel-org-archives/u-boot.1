Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAEBC624D6
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 01:30:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A2DEA40B58;
	Fri,  4 Sep 2026 01:30:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ADz2Kyp4JcDc; Fri,  4 Sep 2026 01:30:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 498B240A8C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788485426;
	b=qsO0IvfPu3U6orFBerGUTfEi4TOOtRhN9hvcehQ8hV0745DnY928o3XXTim5sC9ZDSIP
	 6jKwuQl0t0+Sh9BIOnZEgoOHGW6b7KM+2sW989z8KjK9SWq5kdTcfElgTMTxMq2u5Kluk
	 mYzKPOwxfFyNkqV0bZKbTj9NPabelz4bJAUeBupQZUBsOCLoibxGh9+3KG5eWKslft1Z1
	 uBfgycxiCSXbZeIOXCRWPal/h4k8GcI5uaWs0jrOWvpPBHYRKV9ubsG7GIiO1PwIj57uH
	 TEsD6XatUr8Oe6wf6+fFivIVbRzgolYXfuYv5GUZcXs0fEPfGfZgufWTlZB/+jdaMkg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788485426;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:In-Reply-To:References:Subject:Message-Id:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zkNTDMK74JljZU3cdyMrlUy5DNByhRd2VxQp+evlk3U=;
	b=hERBgz6nk33frY7pCTxmAeZcsOWy1Ml7tqCzXy8KFbxvLaFNglSHQJEmaGazorlBEoAp
	 RRaDuwbEN4+eecWlO7zaiRoz62THyLPKEXYGr5tS5UZi9FV+HWVTcytYtmUHKxoRuVdsO
	 dBC9bSrlr+Xj0OHalmU5hxu+S1HRFf72XoE25W8npyUdHPKQMNcd8174rE6uE4J2/dsdn
	 fFn51R3lK9l9ka06Wvr1E+telNcf8fZXb5ggYiJxpBQ0COLFg8qO7UICiftc2P0CjW5cR
	 S+orC6EVaqWM2wdiuVh+cWarSj8lItpiE0rWwWPaKvjfvGGwzY60GKvYhptK51ml3SQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b="Z0NBhm/H";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788485426;
	bh=zkNTDMK74JljZU3cdyMrlUy5DNByhRd2VxQp+evlk3U=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wZgVLTVsfMjV5gJEnZfKMun8QBxm6HhJiOrBMiYdZAgul+s5ovyR7XvzHAXXg4GdJ
	 rl5W0gHZJhHJFp0+VMOlPJHImG3WJNyonViVpVFBroSbBs0ryaWD5QXqs2abQy4Qk3
	 EIGootsQ352AGBByWeaZZZO5nPGc4bRB8XhIgHSRyZVkDBoJVbXivTEv4D4LA2dJQZ
	 Da7ADkdFVw0iQCIP9Z10kPkeVwGj8IU0ueBSbRGH9/B65WnttvSm2ouSZGUwKnoKXE
	 wJcIhbODiJSeT/xEkSKVIp5uLpiieCk73IPpYUf5DqvCj1wt9vP+QU/4+xUY/K6mVK
	 ScHLj1Yu36hJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 498B240A8C;
	Fri,  4 Sep 2026 01:30:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7EBCE10E
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 01:30:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 650F840A8C
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 01:30:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1skLO52j98vk for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 01:30:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7ACCD40A57
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::3"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788485423;
 b=NyjLVxDkzGhKYkduQJq1t4RPs+nUFnnggw6ZBZ4GHcUbv9Q/g0poCbJ0zCAfj6a6cyhA
 dDYEvqxpYl0men+7D+jJFWp+Uenmj0l9RuSZ7S+rNH+62CPF5lwiKQjtHcs5uGI66jMje
 5TX/M+a3BgRKV2AP9Pt6zfbK2Vj2u/UZKjchwHS4IpLLerXqd2Yhxkhdx2vGqxTYocttk
 kM6fK0zKLhyJ8f0QvjOrRRY0Z4KMx2/IOISz+bqkvfzW9PKOP98KZ50CmkP86hhX938Ig
 wv66vdXKsGvZUIgOe2Kt6mfVzdmrqCa5LQKzv98RKpw7cXafziDhcY1oSyNuvAF6wIQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788485423;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=zkNTDMK74JljZU3cdyMrlUy5DNByhRd2VxQp+evlk3U=;
 b=RiAxOWSSqRw+R/HVXp/lAQ15VNuBzqmzw/SZchQPigCsnH7lSVkMhsZLB4Hrw6oWO7XC
 nXcmFehTuF0ImgFCL8mdioncUPqTxYlef9+zJy7SXwp6GnryVN3brMCj1EpC3H3mI9RzK
 QNEaq4VlLQHj/OJjUkwpi3bXd5jsqBqcEc7BmG/VVYM6oTujTmEKM71EWI6rFazC0H4Oo
 fD6/HDZlL7RezJnWO2WwqwJP4zZdHo4pK9aBym74m4HonJfUGQi/rFJBgRuqFvDHGm9CT
 MhSTkhizwTvzwECvBvKs5zcC1ONI7bbfhY71IHWLuKKxQ2ime1qeS8TW5WBgeIAptsg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="Z0NBhm/H"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::3"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::3;
 helo=mail-oo2-x03.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Z0NBhm/H
Received: from mail-oo2-x03.google.com (mail-oo2-x03.google.com
 [IPv6:2607:f8b0:4864:31::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7ACCD40A57
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 01:30:22 +0000 (UTC)
Received: by mail-oo2-x03.google.com with SMTP id
 46e09a7af769-7f4e854ef3eso144614a34.1
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 18:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788485422; x=1789090222;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zkNTDMK74JljZU3cdyMrlUy5DNByhRd2VxQp+evlk3U=;
 b=Z0NBhm/Hh7u4hmKED+v3jlqU+culAl7dot/eq5FtCKHBzW8VweD7F0va9CeDRK+a50
 AiV1tP4tHcfG4LBwiewhZfRWWGUCGFvNUYyh6DxLg01xtLWufE0WnMCkjXfuau/f2V1j
 rNfhqlo4eidlgb/LgU+/9ePzjo2oWL+k9j3+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788485422; x=1789090222;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zkNTDMK74JljZU3cdyMrlUy5DNByhRd2VxQp+evlk3U=;
 b=YGTCK+jJpFMnd4SOpCUkgiWYCseFQDgcOzMRkUDAhELPUw7vdMxDUTuZU8xXFL7jYj
 kBExUmgs3MejbZ1zmYdSXsw9Ch82iOmFP6iuJF8jU9++taIoKsRB/OI49oqkpK/CjEfQ
 JLFj0sT0vTc6cd/xhdZ5GpesKFxmz11Pj6JyfEbp/vnlWboNIIq94hh3w8UI4dYax0Pf
 chFMUtl9qSVln+XcYe3nPBMYtuuL9POJ5CMupuyQYB/iV1JAnu6zlE7NUOyuvMv0m9Av
 +otgiSG5qRHnyqC9Fr5XUrn4mFD1KkOG+sZXJAZxTKYLir+BfBhBTJ1alfg2hNQjCO8h
 KWkA==
X-Gm-Message-State: AFuF++m+K8vqg1eGte+/qD8Esk8QqP+IUDYBFrGWJEXRr6IfIOYOjyqb
 pZgeXAaMEJ0uYmixdieUwWJJYESKywniEgMqKTb1DT85uTDuf3dvhXXKx9EiH8UjJsxuXigbgBj
 IFUe3Qz+XoLj5HEM=
X-Gm-Gg: AYBFou2jqo4AUjToJyh85nIniuvG7tBe4iHDzohvMQp5mxjn26c3g+4svvEbjtJUJoE
 wW/iqD6I1vPdj2VDsUXh+67KJnsmfvO/Fe2ykKn+kWdVrpcMPvd6cgekUTZbh4xENT6OD4YZz6t
 KeVSqDOmGch9YcxcjtDMmOpvKny31xUYo/ko9Wc6DRzlZ7af5cfSPAPLABuo1e+E+nqlaznMDvk
 V72U6PqZ2oDA06IXhRS30tg+gTHzW6FuGs/RtGFQh1VhekHulV8hhYRS8v8xeQh61ejZowKFy9Z
 mqHp7Es/iQNGCZ22afNcYT12beA3ggdUUNeoLYo3pO5g2BtK2cb2iC6A+mX+0jwS4Ruay2hVodr
 vXfIVGw8Fn08z0ukYx/wUU8+xcls0ZTkTlYam+F+DocUcTpkXwjutmV2baPZsf3EVx4Drb16ii0
 pcxY1uvuBZgBkGqjXaj7EapNqlieyyxXaaIlbLi45zn94ito9UbICUk1qdiplbHL827uD9IfcQ5
 7XyVTMo6jx534SnNdIH5F88F4W5AwLiua8415t01oP8Inb6FvEIO7qnoTGDlO28CHT47l/9vhtk
 LyjDFjtf
X-Received: by 2002:a05:6820:81c9:b0:6b0:4d2c:1bf1 with SMTP id
 006d021491bc7-6b6fb0d6007mr2316844eaf.11.1788485421797; 
 Thu, 03 Sep 2026 18:30:21 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f9f7aeac18sm1607634a34.25.2026.09.03.18.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 18:30:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260824194814.555634-1-trini@konsulko.com>
References: <20260708013019.288985-1-trini@konsulko.com>
 <20260824194814.555634-1-trini@konsulko.com>
Subject: Re: [PATCH v2 0/2] Correct behavior of BLOBLIST_PASSAGE_MANDATORY
Message-Id: <178848542114.2694560.16093674406512425716.b4-ty@konsulko.com>
Date: Thu, 03 Sep 2026 19:30:21 -0600
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

On Mon, 24 Aug 2026 13:44:00 -0600, Tom Rini wrote:

> Hey all,
> 
> This is v2 of
> https://lore.kernel.org/u-boot/20260708013019.288985-1-trini@konsulko.com/
> which I've also split in to two series, with the second depending on
> this.
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] lib/fdtdec.c: Disallow overriding BLOBLIST_PASSAGE_MANDATORY
      commit: 179010694b30eaf3f048db66e43d10c7d9c4f994
[2/2] vexpress64: Correct CONFIG symbol logic around device tree passage
      commit: 2457d1d0fc871e25e32629a8bf4b4f54ff5793d7
-- 
Tom


