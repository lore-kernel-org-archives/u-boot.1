Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D90FCC5DF8A
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 17:03:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5AC0E80D7B;
	Wed, 19 Aug 2026 17:03:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1Uh5TpqZKpNC; Wed, 19 Aug 2026 17:03:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787158985;
	bh=SEyNppxhLc5tq+RmtTZI3e+FHBS9jJRM0DjLFlupTqY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=afvoGvwuQJGfFSmbtK5REqOhr50RGKE3zaKlAmRneBYGlE6ZvtRldAvGWICRczQE1
	 wDrjAw6Riu/vDg3awNJaw/05FirHMVAC8H0ytqsfJU5DJPXsrj1nidGIa6DqfSAFdQ
	 UVnVMAMOqMwSkUenLGYlq9ob3QobDbrYif3SibMk5HlX70OvjFm6xJWL9016d9nPle
	 16b2tG6X6sSfG0VGco3QG60KIeFKLU2Ivkc/yxxdw8ll3KzVH0qjnpVx5a4MiKbsIa
	 b+jcjmBr1/ExcobcoEwRv2VYrJK5mbsNFWneQOwYog5qcYnoI1C4cuMI8WvgsclGR8
	 wrbVh89OXTikg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A0B4E80D5C;
	Wed, 19 Aug 2026 17:03:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 84D581EA4
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 16:56:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6B477401EF
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 16:56:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pNyGgTCDWPBf for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 16:56:31 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=byteray.co.uk
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=DOXW6MNK
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3154D401A4
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 16:56:30 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-499acf0fb55so6154955e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 09:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1787158589; x=1787763389;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SEyNppxhLc5tq+RmtTZI3e+FHBS9jJRM0DjLFlupTqY=;
 b=DOXW6MNKXcjzFg+iaEZzrW0zwSgxjaFLbBL4wQrR4S+cxtUFqJ29sjuuMZlWYDHBdY
 iEfntBPtF3WUNwexabhMg9GZ65cEyp4Vpzlv/cT/hdoAVcltOuzk1Fq+VGNsKOGwtcoD
 D5CXIpzCar4rqS0/OC13Yuk8JhgI5wkdrw6G7KpTa/y7MJe19EXY1CzKBV2cwptMCsz5
 UMasBpEcH5KQUPlaeyBeNdGW/OXbvr3ArApklJs4K/tkf6l4Ct9k+L/zthSi0Ony8wtn
 7+ZbapwnJiM2v+t2lJMAFrDTMsIWOPn5CJ6N+jkJZA/Cekvv7ASsUcfCcKMOsqnrETUN
 mB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787158589; x=1787763389;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SEyNppxhLc5tq+RmtTZI3e+FHBS9jJRM0DjLFlupTqY=;
 b=rKljmpVMtpfFobs7wP6wsbJ4GK3YkjdcBC5WAaaR4/GbjyuNkl4frfiPzRGYf1e+Gv
 TZQtN0xILXA5eFIoPpdIHwp3nem7SsQWX/d0X4QyWrbWcjZGKo+XxbPshdHOR2qM4CUo
 c0H9S55eH3lkxG9PVcX1lx/QfL48GJdUF29rlnQGm3y2S7L85h6+vBKVrk61LccsGJlg
 Gipcvz5QBaWAuSgROmGKo438syv3XYo8wU2rcHe9O8mFeGpi1VaYhQ8Wv1T2H9QxNV0z
 OfHvqBnFrxSANfgwTvT1i2B+3boWez9WHiG+KEOBJw26tmqejCJ6k0iBE7BtBSQB00+Q
 DrqQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoeI+hq5elAJ3ie8MQv7p+N3WXcvs+THKHday1IyH/J5Es9YyFv8AvdyngOV2H5XzjtwN6ZJYY=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyIyGXupwOPHFHvI2i8oYYHvmK5tX0O1dZIJDo2UZH1pbv7PMU/
 mR9zFum9r5VMTaJWq08k8V+8IROSVU27BWTuAJIcz39j63QMXRfe3AhYbMWmMEVTjOs=
X-Gm-Gg: AR+sD11S9FRYWgUq3c6wukLGOyle5msmNZ2ilE1Rljei5CC3GSMTmeU7XIqZNFmUjbA
 79SGFhGemtnPXiFUEGkeRtoxcHkcj4s8ASt7NkGBg8FUjkBn82+3mSR3T9uFQorpNW6BKyHpFdq
 zsBKjYD1UUs8pXnLmeMgF93v9MRxwafExH/xkVNkMbSAtU5FjW3hdwnkb5MeXAjM+KmUCZ0hDtQ
 nXd44pFkb/T2yfQZgnxx3TNpC+QUceZcsJaKn+lt+5L9E344QPKuuyl+8HTS/pty0/URonCQ8Za
 Tsv/cjXM2DfabiyFuw2t8+kXyGyURNY41hL3GFakBCjP7R/k/F4lh4H52ci1OVc5bjhelG3YoOO
 vqJ+Tmr8FshOTqjP4R/XZL+Ih9rZ0GvlsH/6y3mx7NRglFod9Z+ooJaXSCWXIJ4RB9NpzzeS/Z7
 756ox9kvq003KKoHCpYgMUkHAYFfuQJavDQu0ohEe3GeUZzbHRojl2qBDCF9kjcOZGofx91B8Lf
 Dj3fi65Kdm35ztd0PM8rCimyoWIW4aChozhPNFjksdIiAK0zlRzRUgJ1luAAIwS52fsxBWFfpUN
 jDNsSze1u1UwpxrGp/K2NARHB7nPi0Ch9a9D4ZiJZrRs
X-Received: by 2002:a05:600c:37c6:b0:499:87f3:a2a3 with SMTP id
 5b1f17b1804b1-499aa1c7bafmr122552385e9.15.1787158588893; 
 Wed, 19 Aug 2026 09:56:28 -0700 (PDT)
Received: from ?IPV6:2003:ff:f03:8f00:35b2:2a54:afeb:8806?
 (p200300ff0f038f0035b22a54afeb8806.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:35b2:2a54:afeb:8806])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0fd7a9sm90297045e9.2.2026.08.19.09.56.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 09:56:28 -0700 (PDT)
Message-ID: <3a0281b2-2f73-4551-9692-1597ac99fa51@byteray.co.uk>
Date: Wed, 19 Aug 2026 18:56:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] net: lwip: wget: free the transfer context after
 an aborted request
To: Jerome Forissier <jerome.forissier@arm.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>,
 Argus <argus@byteray.co.uk>, nd <nd@arm.com>
References: <20260813-lwip-httpc-uaf-v2-0-1c3f0b3aa1eb@byteray.co.uk>
 <20260813-lwip-httpc-uaf-v2-2-1c3f0b3aa1eb@byteray.co.uk>
 <7d18b896-cf1b-4953-a513-b9ea53ec86e1@arm.com>
Content-Language: en-US
From: shj <shahriyar@byteray.co.uk>
In-Reply-To: <7d18b896-cf1b-4953-a513-b9ea53ec86e1@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 19 Aug 2026 17:02:59 +0000
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

Hi Jerome,

On 14.08.26 16:28, Jerome Forissier wrote:
> Hi Shahriyar,
>
> On 13/08/2026 18:28, Shahriyar Jalayeri wrote:
>> wget_do_request() keeps the transfer context on the stack and passes its
>> address to the lwIP httpc callbacks. If the user interrupts the transfer
>> with Ctrl-C while the host name is still resolving, wget_handle_request()
>> leaves its receive loop without tearing the connection down. The pending
>> DNS lookup (which lwIP cannot cancel) later resolves, the connection is
>> established, and httpc_recv_cb() runs against a stack frame that no longer
>> exists. It writes attacker-controlled TCP data through store_block() to
>> map_sysmem(ctx->daddr), with ctx read from reused stack.
>>
>> The httpc_connection_t passed to httpc_get_file_dns() has the same lifetime
>> problem. lwIP stores a pointer to it in httpc_state_t.conn_settings rather
>> than a copy, and dereferences that pointer later for the result and
>> headers-done callbacks, so an abandoned request reads its result_fn and
>> headers_done_fn from a stack frame that is gone.
>>
>> Allocate the context on the heap, move the connection settings into it
>> (along with the TLS allocator the settings point at, so nothing lwIP
>> retains points back at the stack), and add an 'abandoned' flag. On Ctrl-C
>> with a request still in flight, mark it abandoned and hand ownership to the
>> lwIP callback, which frees the context when the connection finally tears
>> down; the receive, headers-done and result callbacks return early so a
>> stale callback neither stores data nor touches wget_info.
> The problem I see is that this relies on a later callback to reclaim the
> heap context, but that callback is not guaranteed to run, especially once
> the command removes the netif and stops the device. That fixes the UAF by
> extending the lifetime, but can turn Ctrl-C into a leak.
>
> I suggest cancelling the in-flight lwIP operation before returning from
> wget, while the stack objects are still valid. That likely means adding a
> small DNS callback cancellation helper and an httpc_abort() helper, then
> calling it on Ctrl-C and freeing the TLS config before returning.
>
> Thanks,


Agreed, the heap can leak on Ctrl-C. I looked at cancelling, and from 
what I understand lwIP exposes no way to do it today, So both helpers 
are new lwIP API, and since lib/lwip/lwip is a vendored upstream import 
I'd like your call, upstream to lwIP first, or add them U-Boot-local?

Thanks,
Shah

