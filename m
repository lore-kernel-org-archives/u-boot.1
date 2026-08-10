Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC74C5AE49
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 13:09:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7EC2F80D2B;
	Mon, 10 Aug 2026 13:09:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bGLgGnhJ9rPn; Mon, 10 Aug 2026 13:09:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9F7F080D1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786367358;
	bh=ffDbxzBrs0CFa0wpYl1eh6IzOqXIOe1RideM1Of6OiI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jxs+gW4zmXIX0P1pP7EmdfaSXGpl44syx9/ucyd0JihZ//9VlA8NQ4tTbz5/Th6TK
	 pv5OpVoHRTghCg/akUBn+Rm/T15jYQdawEGc1pPSCOiNFBYAttoUGpW50R2NlOJ/AL
	 8+s+7TpDN7MSkhNK0abxHqEofbUuDqEoSllQ0cdeNOdQAR7I2DX+rg0XozOqb/I846
	 NE8lLwGElwjzSfldvS/zvOj/pzfyk7Zf2twETzmVcg8ZTnenaD2kRb2KdGKTTdUu/y
	 U8u1jMOgR8gTnkob3X6gGrW5hG+BTJGTngeELtHyasFrkiDs4KJbSe9QVyUax4EyOq
	 2UcDdcHMMXtsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F7F080D1D;
	Mon, 10 Aug 2026 13:09:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4642C1AF
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 13:09:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2FE3F4008A
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 13:09:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V358nkLj8LB4 for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 13:09:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 3D0C24004D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3D0C24004D
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3D0C24004D
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 13:09:16 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6a10d02ff43so2945423a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 06:09:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786367354; cv=none;
 d=google.com; s=arc-20260327;
 b=paXrfKjk4fqkAnhO8XmAP3Vs2lBC/7R2t8WKzx+9EYbhLzCdRWbs3mgeLyQKpqsP8j
 gIRXSTPAnL5tPHytmeFH329/5tBu1tHWWtANTsVNkIzCuHtkBVkDB1mmOhiDvUjqrGxw
 KheHVzzsb4rHChAQNDIE5QJoQq8uPfFjs2m6I+DDCkxiTE5FPEO8gu2PVjv+hMxo7pEo
 tlgYRarzyr7I57c8wiaMXIsp19mYLn9A5WyBfjKsV8IMUui9HhF3NjtZ8plUzMsrFOpo
 2qj0JvAUwnpMjJUi+xI4UFiZ5Hs9L+CRE6ZojyRUBB5zGUjYh8+UTPP7tQitdieQOUtg
 kpMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ffDbxzBrs0CFa0wpYl1eh6IzOqXIOe1RideM1Of6OiI=;
 fh=qxRTI2eznDO0d8MKW+TLwweekasumpusiPljJjfe7Zo=;
 b=mdYL7WBmWUbnyKOCoMnO90/9EC0B+Q71B0mz6BTYqOYBA++Ycpf+JhvpZKFpilGkjd
 tywYJgnfDVaDM1seSOHCkwOn4VQ628GRvyvP2yrM/Cak3VQzDyP5vmaqA437lmFBAlEJ
 fkCTWEYutKN6s2uhlsXPFY6qYPHiMun6LeHzXNA4Lh9tuaCP4Lu78xs6sVh3U5O0Cxor
 u9RTEOJTXkVtu46IauSLMgpTcq8MqXD1VzCduWzzCeybwe3tHVudaKzZsHnuf1ZevKra
 70NKkDU6/e8pYvzwiZMTfF2NLGQio5cBIXyjUyvNxPj/9cVv31Y79mVT9KJ1mBBWe1ZA
 PRFA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786367354; x=1786972154;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ffDbxzBrs0CFa0wpYl1eh6IzOqXIOe1RideM1Of6OiI=;
 b=RDCsZnJEFZM7Ohjg7hc6yA8mmR/RFVwVNPjcNW5eCf/s6DqW4h15QI5F0zCvIf3T7G
 u0bL8mpFl/zZNyDgnH9e9e3vNzqKhARDs/7OR7YOKT5yvthESSVaz0xEpd175nWPD/2k
 1OLT3tDLTbFUIqGZ5mhE65wfIZWKDeIZSa54ud+Ar192fMk6VD9g0r6rbfh4WHAw0F0e
 ybznMiAMFTlP4VI5YG6ntjfYOgLEQsHlD86vFeAQSlHtWLRAJuqI3kjGwz+w0zdy1x10
 oFYbZxelnDJ/5y2VI4ay22mDsMpIY/iifh9JS0mClX8IvRxRslIkOV+2EX7+1i/2dV30
 btsA==
X-Gm-Message-State: AOJu0YwNS4X7Sm/pP2ypyD779fekl6HU0SryfXCvzS6RaLF0k46rrhN0
 uWWQRDR9FzGbn9vc+bT55XtrWpvt0VD3RmwtXhfPg2RxUmMeubMd2H/SsrkfFw3bqBKVyowFi/m
 tTy/1etTFIr62AW7DnqyWGnsbPCUfy2+ReGHj+wmn
X-Gm-Gg: AR+sD13RRX2dA6HpfjLJD1SNrjc1PQ+KzFzgdTVIOL+1HNbbJNjMNWLysSlYaLv+VW5
 lFiSOsN82xvcUzoYlfkyDzXAVTUdIDF/EfoYJGJn6b9Al6acV6jDi6/DxCj4nuJVFC0Obm4YcD3
 Lv/YqWTGd+3XZCdQYNq6raFPYwMxZFcMWumtdLmoJfWcEmkfHiJ4XNHrH/yPnBXMwk4GUNVRJHM
 ShUnJVacO/IYKUQEog6jBxLdrtB9/a+BNWakNGmhVeHXv7H5q0acZQuOGXszMe0D2jFZ/l53ufr
 3ptXUqAaAQq1a1ZkAqeG33wcEXD8nwPjwip1UkiNu/0=
X-Received: by 2002:a05:6402:21d8:b0:6a1:e59c:62bd with SMTP id
 4fb4d7f45d1cf-6a1e59c6678mr10430880a12.3.1786367354037; Mon, 10 Aug 2026
 06:09:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260721194828.398524-1-marek.vasut+renesas@mailbox.org>
 <CAFLszThbzKZWctdWh8B1j2cqACr+9dNVaX_FMkvbHtXkMDnsTg@mail.gmail.com>
 <2eb8a15b-c9d1-47d2-b8b6-da27d711ddb4@mailbox.org>
 <CAFLszTjUGsM99ffVV+YryDGjB5+YV+T9pnegmbko7vpRySaD2w@mail.gmail.com>
 <58052961-ee1b-4ace-809e-e15378bab54b@mailbox.org>
In-Reply-To: <58052961-ee1b-4ace-809e-e15378bab54b@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 10 Aug 2026 07:09:02 -0600
X-Gm-Features: AUfX_mxHDdBcS2czfIREg8CjocA7SsgLuq3H8t1lSYppnOh7p-m66CVaNU-r3uo
Message-ID: <CAFLszTgrxSA_0pUnau2w78jV2LEU+hWrmO0ELPNG5sR8htHoqg@mail.gmail.com>
Subject: Re: [PATCH] board_f: Call initf_malloc() before fdtdec_setup()
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786367354; x=1786972154;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ffDbxzBrs0CFa0wpYl1eh6IzOqXIOe1RideM1Of6OiI=;
 b=BZJVRJ1hoIabX8E8xODF5rIdrU0NBKTTCycDRZyphENdcj4ZkzIpqKjHE0ovfzaynf
 defNQ0lRPRgKtj4gd99ybyGgqtdxlsIEccR+RZGTdVro7oVGsa6iGw+Xo8VDeKJwfjuS
 ORpmK/Bvs/eHthK508l/8A5yJBT2356mbZCoQ=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=BZJVRJ1h
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Marek,

On Sun, 9 Aug 2026 at 22:42, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 8/9/26 6:33 PM, Simon Glass wrote:
>
> Hello Simon,
>
> >>> On Tue, 21 Jul 2026 at 13:48, Marek Vasut
> >>> <marek.vasut+renesas@mailbox.org> wrote:
> >>>>
> >>>> In case MULTI_DTB_FIT_GZIP is enabled, fdtdec_setup() does uncompress
> >>>> the compressed DTs in uncompress_blob() using gunzip(), which invokes
> >>>> malloc() internally. The early simple malloc is initialized in board_f
> >>>> initf_malloc() call, which sets up the early simple malloc limit and
> >>>> offset pointer in global data. Currently, the initf_malloc() is called
> >>>> after fdtdec_setup(), which leads to malloc failure in fdtdec_setup()
> >>>> during the gzip decompression, because the early simple malloc is not
> >>>> initialized yet.
> >>>>
> >>>> Call initf_malloc() before fdtdec_setup() to assure fdtdec_setup() can
> >>>> use malloc() during gzip decompression of the DTs.
> >>>>
> >>>> The impact of this change on boot time is negligible, because the
> >>>> initf_malloc() only assigns two fields in global data.
> >>>>
> >>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >>>> ---
> >>>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >>>> Cc: Simon Glass <sjg@chromium.org>
> >>>> Cc: Tom Rini <trini@konsulko.com>
> >>>> Cc: u-boot@lists.u-boot-project.org
> >>>> ---
> >>>>    common/board_f.c | 2 +-
> >>>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> I'm not keen on reordering this list...
> >>>
> >>> The offending call is inside uncompress_blob(), which already has a
> >>> non-malloc path - MULTI_DTB_FIT_USER_DEFINED_AREA with
> >>> MULTI_DTB_FIT_USER_DEF_ADDR.
> >>
> >> It isn't the allocation of the decompress target that is the problem, it
> >> is the gunzip() call which internally calls malloc(), cf. commit message
> >> and lib/gunzip.c gzalloc() usage.
> >>
> >>> That is the pattern most boards using
> >>> compressed multi-DTB FIT already use, and it avoids early malloc
> >>> altogether. Could the BTT config not just switch to that and drop the
> >>> board-local initf_malloc() workaround at the same time?
> >>
> >> This is unrelated to BTT config.
> >>
> >>> Failing that, the per-board workaround in board/liebherr/btt/btt.c is
> >>> ugly but localised. If we really want a generic fix, I would rather
> >>> see uncompress_blob() call initf_malloc() itself when it needs the
> >>> heap, so the ordering constraint stays local to the code that needs
> >>> it. We would need to ensure that malloc() isn't then inited a second
> >>> time. We could always add a flag to gd->boardf, I suppose.
> >>>
> >>> The reordering also means that malloc cannot be traced - the idea with
> >>> trace is that it is enabled as early as possible. Finally (that I can
> >>> think of), it means that early malloc can never be configured by the
> >>> devicetree (although that is not something we have needed yet).
> >> [...]
> >
> > Ah OK, I see. So in U-Boot proper, before relocation, you have a FIT
> > containing multiple gzip-compressed DTBs and you want to select the
> > correct one (presumably with a compatible string), then decompress and
> > use it.
> >
> > Is it possible to do this in SPL instead?
>
> No, there is no SPL on the device I have here.
>
> > If not, it looks like there are two allocations in gzip. One is just
> > its state (fixed size so we could pass it in or pass a pointer to a
> > local var). The other is its context buffer, which might be 64K or
> > more. Did you see my suggested workaround above (call initf_malloc()
> > itself)?
> I believe there are more than 2 mallocs in the gzip code. Search for
> ZALLOC() macro, that is invoked during decompression, that invokes the
> gzalloc() function from lib/gunzip.c which invokes malloc() too.

Yes you're right.

Anyway, I've spent an hour or so digging through this and looking at
the various board-specific implementations of board_fdt_blob_setup()
and I believe your change is safe. In fact board/liebherr/btt/btt.c
does something similar and with your change we can remove that
workaround. Since, as you say, initf_malloc() really only writes a few
things to gd, tracing is no great loss (really tracing should go above
fdtdec_setup() but I suspect I found that too hard when I tried). So I
agree with what Tom said too - this is a reasonable tradeoff.

I suggest adding a tag for this, or at least a link to the commit
which makes this change necessary, e.g.:

Fixes: 95f4bbd581cf ("lib: fdt: Allow LZO and GZIP DT compression in U-Boot")

Reviewed-by: Simon Glass <sjg@chromium.org>

I'm sure we could create a sandbox_noinst test for all this logic, BTW.

Regards,
Simon
