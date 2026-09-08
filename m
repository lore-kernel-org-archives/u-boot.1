Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C47A9C79FA1
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 11:55:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A92A606CA;
	Tue,  8 Sep 2026 11:55:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OkDofVNO-f8F; Tue,  8 Sep 2026 11:55:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 957CD606DF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788868523;
	b=llRkeBuPmzdqjRt3MkSTmTPtURztw6Li3G//j966Pq+5EoG988p7bbxIqfDrx4urTj/k
	 nuInUVHMmat3OtQPKjbocTOGsu10DzW0CW35d+CbmgqTVRuQVmMNDSSdFtn+2x4k2zx/V
	 BbaYv2YOpidjnCHh3vWJqaz0DtbIFdYHDMn7X90RFCt4pWNK9UwKg6wdt+g+8BO1TXhg3
	 HHQ7g7miYbYZTmG6wJCOgjlZGKvaQctj7w6YHqKH9lY7g6Y1je1pE+Q0fpFY4DOaJYh27
	 TUeFLHkuXkvy8cCFYszOMTTjAVDSYsbIsowiTVv8cx/OA6GheLrh3QryrYAeBVBtaoQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788868523;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MM6dzUHq6qw0ysgwniz5t4lyqPOyIc9cG20fQtKvBX8=;
	b=ZOpDwfqWFYuQ6+qFbhHNpRTTdjrJYF2g6dVPmWZyP67+QOyllTFS+VEdIZxBRGRciwoq
	 LDcpBIlZS3I70pCZsqZ2tInqiLkQFj8ehY3/ctz+OTzhpsX6aGlu6LjsnXrkuIUsj5MWl
	 VqIHYYZ2gDsLupExeWo4mXP5+3lZngRM4zkjMyJzpqGZiVVLN+qR0BZzwCdzgwIpDd+5/
	 jrO/xO3UKj7eeqh3wZGayawzNGLzwx2T+JFYkouDPZ8aXc77XL0yrz3P44EXNCLlfL90K
	 iSmG7yuLk7RiWD6YltmHHwJ89G68iTVT8OUiNOEIoBKvVqTV99zdbBMz0PoeobipAQQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=P132wDuB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788868523;
	bh=MM6dzUHq6qw0ysgwniz5t4lyqPOyIc9cG20fQtKvBX8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YWnpUgJ5v9GO3IMZQnSgILU4NbfuKEYPQufJEJ+i9JJtWyvBvMm8O2Ww38Crm4mG0
	 IeGIdRu36FOQI5M/dktNAVjeTcxsg2vH/p1sK5VJ+kfWpOCxwKy353bdTqH5J6E1+7
	 GHW3ZiOXcWuQMRL8kWTJupEk9SqUWr6i5XdSXh64SrTjuxOpXeoRtE3kzDhIRHSQBe
	 ztX3kovpyA2BT/hagiGus5evZTqLMLbW01iv8Sk90HXDW7sVAgaYLy4BGHbjlcX0JG
	 SoX0dSB0aZe27HSqM452JPrXFTYXLsoF8gADFTbSL7lxAr0NDYTy88I0EenPk4sjSJ
	 kDuN0rIph84eA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 957CD606DF;
	Tue,  8 Sep 2026 11:55:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B2DE272C
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 11:55:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 98A6A606CA
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 11:55:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hhN0YNbuM73R for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 11:55:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7FC8E606E7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1136"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788868520;
 b=n2V3zIZUoaINhV1rNwAfEVylYoWUc1unuc0kX+onXKMRWJqEpK0DC374EvjZ9Ljh+h69
 9XJqwVf8jCXCSpGiorwCiI6Ns8oui6a1r9LU5UXN2dzlNnMExr/oZJFpuDMPCCJObKJEI
 ZffAeuixtnfrn3kYuDF9PV6FpK30GZrS2fc0C9eSpHug7loQ39xMNtyxOWYh+hAfS9Xr8
 0dKS+j39Rp0xdgCZc9jYmXXheoqsRw8UmJVYJCccrDWAo0w/EcNZVhyHokpTxg1g1OCB5
 PAPKJoXxljKY1YmK0ZbPi7gDRXxa1RysvcsCT472eLztk1OvgAScISCfj+KH/+hjzEw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788868520;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=MM6dzUHq6qw0ysgwniz5t4lyqPOyIc9cG20fQtKvBX8=;
 b=gfLbY8AHfA1YPj5o7S292Pt2oIDd9FQsXAmniMm3TKEkx1FNC7e8EEt4wKLupwEB0YeF
 6Q27CxdSx2eIg3i8rAaiR2LtErbub7eWfJ/EoWQDA81jnI7RE7A7ebkUqYMhyqDgYESWg
 LPyzy4jEQUCXE7pww2tqaK3ZkP3Yx2o3Qf+7bZToBSNOYvqnTdJB1iDEt2zgSdyGk7/NF
 6G55k8M9yUsqie7Co/FXrNGMU4xvP8V1KVzAmiIrGwFHbuo2ao5GLzxjKc51kmH5FZT3q
 nk2zpBc4+SVLk22een6mmVh6lar+4nhcWkLA8tgx6qt3rdwyUoETFFEwyZ91CutyaIg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=P132wDuB; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1136"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1136; helo=mail-yw1-x1136.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=P132wDuB
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7FC8E606E7
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 11:55:19 +0000 (UTC)
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-836c4474028so39898757b3.0
 for <u-boot@lists.u-boot-project.org>; Tue, 08 Sep 2026 04:55:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788868519; cv=none;
 d=google.com; s=arc-20260327;
 b=UyIwlPl4SxKBZgQZ9ZlPW/pvGFo7V7T4WdXtS2gcVX0gXKCvm/AoMxstPPMTyKXUh3
 2htNJgtakBBXibUjHBMPGDbno/2Tiecivt/JmNApaGBWrv9xktOZCyEAd6qB6zqwpnpS
 8VnjxR4elO7ka8lQbYO3+hUE5OiMwKNEeS9Fs7nMUDeqgHBCmDfj8dwXl0cLavoGmoMa
 gIvjiHiDnMNZp9r8k8xywKxDTWO5l507EcL8uo/7N4kwsmrnPS47/P3kVrqFqkH2WIqw
 TKDucCiX5QtsJbLmprWfWqUNiVdpnpcAMMfTtAO5Xx566+t1KKk+BWF7uVl1r0vdSrew
 Wfjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MM6dzUHq6qw0ysgwniz5t4lyqPOyIc9cG20fQtKvBX8=;
 fh=tNLf/+MrBZDRr7Ng5fSui9q2ZXbx1IfYZXPMDuKbLt4=;
 b=DYuFZxT3NdLNvlo654b8b5JER4rWtSkxBbg8NIwfTPP6Dki9ehzGRRkxr3zPCXNRq9
 KwMOwRiiKJgUngM3YFOkMfzVoIBccWC2H6TvySmAwvOhEgW2bAS2+SvTUC6eQnLoBN8v
 KfzGt1Ocg33K53T52N34Jyouke8ZvkLCRe0/bZD9KTV3TNoF0JaFQUrQkpbVyngtW8NW
 CjnGIe8yhszx7GifO2/nDVu1Iz4lXyXatHl2ytK4cBcXcRZeVq0MCpjvzFhhLSasdJNQ
 svXX2udVno/YEC4tGfOEfI3v3d7b9qIOfVkk19UMQSM9DuGDUyC00O2lnJ9uxIG4j2r1
 0h2g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788868519; x=1789473319;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MM6dzUHq6qw0ysgwniz5t4lyqPOyIc9cG20fQtKvBX8=;
 b=P132wDuBvA7QLU8Ocd9dizdb0E4DaW9SLWGb8/nquNMsehkcluNtvGAzpuPnT3NkHE
 in1kGwMTBYbnwNCvjhuCQhDzn+j+WagGVdQRndJK0gjX5BH13p0sCz8SOHY9KVyhGJzG
 Bf9lUdNvBEd0ub4fgMOGShuAviXfoBufAOcSbDfgUgFn8ZJisVOGllJpt4udELpiYX40
 oIuzr8TRJeEPdoffLwAf6J1CFED88Bx24/hon0WJmSPQdmebXPjlrqThsM4e7iHUv+A4
 /Dq1H+cF7miO6aQJrgj6fHmpaREr3/kPngOGo9+Nr0B0TlAkpfZuwe63gd9jnGpfYlVZ
 278w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788868519; x=1789473319;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MM6dzUHq6qw0ysgwniz5t4lyqPOyIc9cG20fQtKvBX8=;
 b=l6vZau3b100KuseQboG1tM6S44Dq1PNzEU6Fa+j8m3PqI+/ja/Dc3T2AT20abQTLnx
 oI2S5/KxRL7o/btddWGi9OgnAWdFrxyW9NwyLbp6AA+9+8bUihumsugqsEgSyntt3r4X
 1pzC/Aud9hftCELu8htzlj699gEFFrcC+4GGMP0oo07MyCp91j9zGM4p2Ke0yQNHNF/7
 Tt+ioNSp+wumlbKSHNJjC4B9q4NWyNV61ke0CWlN6w462roU/vOVZC/etB0QI0VODG5U
 AmOZfjVcSSFOWGliicLPtXsEuPaiZx1tKW+j2qazmICOa9MEDLa06D6gH/Cd9dNLg+pi
 Pcqw==
X-Gm-Message-State: AFuF++nYfGm/wj+C+B5dr470kLmrQt7FqNuqwKnIx9eB/Zl5NRAqK5Vh
 Mtw07JSBURrEts8CvY2l0NtxMLii9k34uFjID5Gj5SaLobf6OsqfBMxs8Wy8zEy0iUXODXylXCK
 mpUTO7D8dAHR/xxpKGqPgF3PJTDE7rXv2GKX951Usyw==
X-Gm-Gg: AYBFou3Nraeiv80LJ41qb+CGhu3LUgRxXDYfJ6eoFizWjz6YFqIGLOB5OE9+O2BVmh0
 pvr935XhWrvMiJyekJzITxRqJ2SCEwdBJAjraKyuLFoy5lzXyWjNQei9BYUVC80WqUhPNOwDjgF
 1r34PvlvP9UCx+aZtbaeVRd/gftkk0seZgjRYqJqGOEtFxn55vsqBZB0hTZw05NOjbaLhRatpQy
 LPoo5Dz3FC4KkNO7jFPsiYEOt8h6rspftlf/ymmlwV47z0d1Ou2kc4Uj97BeXWLc74tSNHYnack
 tC8ekiPjhH0In6RxX3K74/HoMcna1VzWl81FDeLQtV15F0WAdKvgBRVv71O0v8Ci7wjtlaK9whg
 gVa5XI5NK8oR+1Z8FRPcz297P9J8PA2DVPJWM3prI84Siv4Uk50eOVEf55DYTHN3wZ0EL3cHzC4
 4Uy7YmYL5r4FSiR8YBIlnSOEAoPmRdBZ1SjIR6doMQRvJxoK7X74aD/wnWze8piF1xDnx3fEBFI
 GMbruw6LPrCTtGJKPQZHEC3c9LxDj0H2ARfiDQSQft/HjMZTnsaaCf7aRr0eqSzFIY052/mQe5O
 HVtJPzeJJc0Ye76tduJGfnuZ4wpd9ar1CrTLg3b16S2yZfHk1ZvyDl+AmfLxJva0FovX/BvTbED
 67r6Nco7f2B/7Haqkm28evP7r/wI/Ey1BkJwj2ciTEYKt
X-Received: by 2002:a05:690c:f14:b0:870:107b:6359 with SMTP id
 00721157ae682-871246a70e1mr101870037b3.15.1788868518527; Tue, 08 Sep 2026
 04:55:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1787514446.git.jan.kiszka@siemens.com>
 <13fc430cf440cdbc490bce630031ca49e81e1e13.1787514446.git.jan.kiszka@siemens.com>
 <DL9R0HDE15M7.1NFT7IXOOHCZ4@linaro.org>
 <d62b282c-942a-48dc-b595-365852575691@siemens.com>
In-Reply-To: <d62b282c-942a-48dc-b595-365852575691@siemens.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 8 Sep 2026 14:54:41 +0300
X-Gm-Features: AcwNN1UF1hRTiJsKGXfezLB3JSKBYccCILAFqNssgn2cuqzjPw2oYSoTJAbw_ZQ
Message-ID: <CAC_iWjJL+LLsBFS-RqaC5wVvSXZWcwwdMdU3AkHvBh_y+NiDGw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] tee: optee: Do not warn about
 TEE_ERROR_STORAGE_NOT_AVAILABLE
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>, 
 Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>, 
 Alexander Heinisch <alexander.heinisch@siemens.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
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

On Tue, 8 Sept 2026 at 14:01, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 08.09.26 09:15, Ilias Apalodimas wrote:
> > Hi Jan
> >
> > On Sun Aug 23, 2026 at 10:47 PM EEST, Jan Kiszka wrote:
> >> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>
> >> This is a transitional error that is resolved once an RPMB becomes
> >> available. Keep it as debug output only.
> >>
> >> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >> ---
> >>  drivers/tee/optee/core.c | 5 ++++-
> >>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> >> index ed8f2b6ec74..d3b5811afb8 100644
> >> --- a/drivers/tee/optee/core.c
> >> +++ b/drivers/tee/optee/core.c
> >> @@ -106,7 +106,10 @@ static int __enum_services(struct udevice *dev, struct tee_shm *shm, size_t *shm
> >>
> >>      ret = tee_invoke_func(dev, &arg, 1, &param);
> >>      if (ret || (arg.ret && arg.ret != TEE_ERROR_SHORT_BUFFER)) {
> >> -            dev_err(dev, "Enumeration command 0x%x failed: 0x%x\n", pta_cmd, arg.ret);
> >> +            if (arg.ret != TEE_ERROR_STORAGE_NOT_AVAILABLE)
> >> +                    dev_err(dev, "Enumeration command 0x%x failed: 0x%x\n", pta_cmd, arg.ret);
> >> +            else
> >> +                    dev_dbg(dev, "Enumeration command 0x%x failed due to unavailable storage\n", pta_cmd);
> >
> > I don't mind changing this and I like the different error messages. Isn't the dgb message useful for
> > users though? Or it is something that's not expected to happen in production systems so we can hide
> > it?
>
> First of all, it's now something that will always happen due to probing
> of services that need RPMB when there is none yet. And, as explained
> above, it will be resolved later on. If you user misconfigured the
> firmware, though, there will be no resolution - but that is a debugging
> case.

Fair enough

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> Jan
>
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center
