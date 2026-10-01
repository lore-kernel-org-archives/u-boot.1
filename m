Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 274BECA5FB3
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 08:21:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4840D812BB;
	Thu,  1 Oct 2026 08:21:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xv0TaVFXwKni; Thu,  1 Oct 2026 08:21:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8FF55812AE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790842898;
	b=hCtZIiijtp2yW3W4i13v7V+5EXzDhmsk4VNIVYpq9ciNXa1bxr/B7dyhH++iH3kfCzSc
	 Uurz60Z7+LNOAgAGK4jg2/Rj2VEozgV96/XSDzzQTKJTq10DOkv+HSF8yl14fvZ7aC2u+
	 3/CprpiCC4+cB7iKpOnOG6OvtyPFw0OxFM+4y8+ziGzgktGqJCF9fW8snC74nrK/b2fqU
	 rXBVW+SNKagaEY+CwuMjYHfGZ1foi1vRK6/qNpYgJqPLLjbqB5lL1ZeG3pkh7zU07x+d4
	 xrh+S5G5Ytvejar0UGMPz0pEiAjs0VRVrPhy62W/ck7CPOWFBvA33tsQg2dd31E4DWQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790842898;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=t0h/gAZhbxrxRkRfGPBqHOo6eAdXwmcdXZCwselokjY=;
	b=UCMIqJdL4NpqwuUTm99cbVhlEWwgjPH9YauFPf8CVJKA279F3oMXe1Y/U9MdslJTicEQ
	 kvQaDr3miAQww5Evch5avFNRws/EA/KQRD8CunhEcHzN80+ppdSQbcb5YDat70TYN5liG
	 69qDHLBaUofGwzZc9tdDrpYmAtZvnvyxO3gMatRH9xV8pOFbj7cixqMxUm/Bur1wM4P7l
	 +wnhOnxqPknU65qebAh9/7mLSsQRQKsxQi8emnTwDyiYXS5wwshOuevMikvRZHn0PTbI5
	 i3R3yq+e1NkqFA90RDj7b5qJb4JMpK1jqN4dLR/LDEXOSKI4IG3RzZQ7w21tnnulzog==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790842898;
	bh=t0h/gAZhbxrxRkRfGPBqHOo6eAdXwmcdXZCwselokjY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EVLbwwRyORMLpLBvJynlehbkNrb/7LPqzcWLyg5qFnKOObaMMMmFYESHssPjnPpK3
	 v6gg9i7YCYLVXQ+REcCbgL2k67wsK+muH4vx3Xhjx6Xs+HckZ/P/O9hZybofMBnNzT
	 tyxNq9jdUr5gLtd4DK0f+mEu/3YnuLu1eOFeUkLkQoYNsPTrhgUwioIZywRHN/s94O
	 cDJl1ZFklCZSES4ySL3UEolUXes7Pjc4aMZ8k5GTfnNqhfDAdz2US1XQWj6KmMfcmX
	 Y689tFVESvxR/1t8O1afHc32vz0QG6A7UmiDxUbrEV1FaSGmOclx+D8cCHdMDcdYex
	 cQxhHhgBmWNyg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8FF55812AE;
	Thu,  1 Oct 2026 08:21:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id ED53933B
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 08:21:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D2907404EE
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 08:21:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tI4dZkLVVSnB for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 08:21:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org D5C47404DE
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:34::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790842896;
 b=DDKwK6CHkJEd0deF4msfHNMN9j7XSh8CHEccea9ToQP5yjdHiMFGlIz+sy5nR6a3pvvU
 bG8dtXTJljhu41jcu5QBVLywG7wc+XBW1TYOHAUj08mL/voxtUO96DcC1vX+KmKAZonCF
 J5MwvY9KJvo4m4OXIk5pgpyKwq9o/SiITAspS0lZXDtNNJCQDCp0DHTPnGndV7cSZHKDM
 ysNQP+LVPtdaCbfHPnlQJjAze77BGL3tQeCHdUvNW1XzKrjB4Et4gRMC1UOJMr/Eogfqk
 +kNTnZrNc3tr02hmIRRsEDrD1KZ3N+hAeEY86untT/3CPvRF3tB1U+jH8DUqWPdmCdQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790842896;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=t0h/gAZhbxrxRkRfGPBqHOo6eAdXwmcdXZCwselokjY=;
 b=YlqYvkED8DgxVhzAo2KPmwE6aVWRbr1/HKYHqBdmAwMqn9smVRcaXjSQFT/IQhMu72rB
 7wmWBu1qgN0ghqYJDZrCj+GZZusYLng3tvx2N01coy0CwG9pdRIWSxOySYwLJYqTvWR1o
 s9zM91PhLF7mUgO5n9NO+uM+WdyOGC4GVPr5HS5kuu5NVMlFUYn27fgWb0Ls8vySUd2e9
 ImMHR2GDB35NDS2m3PHGH0rSk6KAELn3NKVDcJaFq1EhyBVnPoDJS6/47vSp1QI0SaU7S
 y5+VVYcE8RuYMWH700pJDZ94ufXzBJ+j1Ds+C5+97boypuamRoGy66OJUvzXQObZ2cQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=mKYciDLo; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:34::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:34::f;
 helo=mail-ej2-x0f.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=mKYciDLo
Received: from mail-ej2-x0f.google.com (mail-ej2-x0f.google.com
 [IPv6:2a00:1450:4864:34::f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D5C47404DE
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 08:21:33 +0000 (UTC)
Received: by mail-ej2-x0f.google.com with SMTP id
 a640c23a62f3a-c2e20bb4583so223686766b.3
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 01:21:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790842891; cv=none;
 d=google.com; s=arc-20260327;
 b=L0J9f3iaGnvONyZ+yZHXWH/Xuj64KghVbsmfrCAX6V3XiAd7524EWClxF3CxgknYDh
 vvMnC/x8l7M6FxL+iO6qa6bzQeHjE6KaguYthJzefLwPJf3RxB5cy6lBasuw1Rko6nZg
 VRBBWUtw57ROnLnpZAp9D9g+ITkkZiwOXush71TLopNGoXbi8FdeqasSD2hwbJCjB8UZ
 GNC8+t7POWza16/iUiWMY9D/MGh0/JKxQWeAysmUsblr/s8mEEHsIo7fZ6TjsicZ7Mtk
 7k30Pd0D7eEisdOov38KeUrfzhOsM4Wa2tRc5AhXryxeRvABdQajFTaGdRyyXpHAI2J2
 p9NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=t0h/gAZhbxrxRkRfGPBqHOo6eAdXwmcdXZCwselokjY=;
 fh=dZ0tJMEGsIVFUzoIG+XzQP0n93LR20+4J2Xk227cWpM=;
 b=OU55LZ5NzYiCwXi1m6RSoAUabNIE8pumf4ePsqZvOkTTnj6uuqMpyZdkmNVuClCM8O
 LlnBdrOCHmweiXaRWzDKtAktr2zTHtrR+2Jf8SVdEZiprrrk9ZPYqd0aXfsPnLXzeTHH
 G7fEI50oR9pcZM/2lKYnQknAGzAWb+uHJ9c6/fxpv16ajjxIQOYL3FwdAqhf773EDt1r
 j4zenFZSJPTYHsjeHU7jr0KYPsL0xWriZqmL8uUQeRpUMMZck3pDZ8mIS7yxNcL9Q7nf
 OxAYBVtNuqtY+a+hzRl8To4wGmpd9B1PuUqlUQ7M8cgAZKB4HLIpSrTpr1PoZ8ejY2+q
 rJPw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790842891; x=1791447691;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=t0h/gAZhbxrxRkRfGPBqHOo6eAdXwmcdXZCwselokjY=;
 b=mKYciDLoIiLwEoqkCa/8bDPM3m4PCwbWSHdLUnhHAoVdx7ymd/zGx7gO04TZhK3uR7
 6afPr6c9mAHbdaPyz1Xlugy3V9IYRTp2H3lloEurqJ5dsJOGMoR53IYJb0IHrpvmfo0z
 1pvAoLsObHu9IY/q4mqnSahpx1lmeuZuJkOIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790842891; x=1791447691;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=t0h/gAZhbxrxRkRfGPBqHOo6eAdXwmcdXZCwselokjY=;
 b=ZMXteL8dvFBgOPz2r/V/1vXMwlLUucAJ1OsNfjkoL4SFVU07dwBTxYgPKGSrDcj3kV
 vzdPkK0Ll6lE9Q+hqtK+ZszGV3MrvFaPx/N1HXoItaxK38+JDQcyDe0L7WWGmK8LMtUE
 7AIKrKtu1m+z/GAuLa3UB3qFdBcIMhUgHvTsyvxrKWog5dprQ9M/FZPGUlbKrP/rMXTv
 RZuvPUNASovACa25DWLaqkGezZP+BgAxaPDb0M5R39yG7Ndiu7uqRCfblCEQHnVGY23T
 x+eG4qYwEMktCmiMmOkfJamjPC3u1Cmhf4gYnneVF4xHQkTC+D365N1b2wT2Urhs7Qww
 mNdQ==
X-Gm-Message-State: AFuF++kwIhRU1rpiVvPEvx6T98UNZ48TKDWs47XeeBALxi0HyC/dEfnk
 660lGpMe3NqtHuH9NX3Pzk2P7HJNPMDuJpVxP3SnTiTXQKwR0RLUaR6mnh6mFiXVi/C/bjpt6bJ
 sika4lcK6rCYr7Mfi9Ve2tYvBAEyEYFRgFe3GmcRi
X-Gm-Gg: AYBFou3B7vD4aiUHkgH0USatPGAKzeaMDJ8jDNNLZatENi0qwd9wMo2IA3PMJIzjsDC
 IMCh2XW9Hn+erWoRWQHvAZg2TznxnxtTnPlo1iFJ5NA2Q2o05XUwT+wnaiWAksh4GwBUOFTKJIK
 TL7/oqNoCwx0nx7HioahvcJ/vlQxkkD2XeSaM4WlTBexb9xknG64SW5vHULLVT/E4BfdTev8mmI
 H3x04ZZz1+n6w8qFWt3BlIlq2+SWyzzSYRCqe+fsWiB2W4xMpfbWSJ3Sewn1JGmHs2TLS58iL3G
 XnaPURK0o8EdQoLAVXUGmjUzLv4D9eXjiB96TiVdfw7+tYDOJO1OTWEKe8hJuiorv4w=
X-Received: by 2002:a17:907:1c85:b0:c26:1691:b369 with SMTP id
 a640c23a62f3a-c2e23dd058emr350646266b.34.1790842891353; Thu, 01 Oct 2026
 01:21:31 -0700 (PDT)
MIME-Version: 1.0
References: <20261001040012.3491713-1-suraj.hanumantkakade@amd.com>
In-Reply-To: <20261001040012.3491713-1-suraj.hanumantkakade@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 09:21:14 +0100
X-Gm-Features: AclHuK8yvq8zHlANj6bnT7OJTziDxeQkiCAhWW6Itn128O3WH_EyQrrD8WbggGk
Message-ID: <CAFLszTiUKwXyJUsi9tqdJPD_e+EzANhyFX8aBVvnmWp_tV5n5A@mail.gmail.com>
Subject: Re: [PATCH] boot: pxe_utils: Fix buffer overflow in pxe_label.num
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

On 2026-10-01T03:59:57, Suraj Kakade <suraj.hanumantkakade@amd.com> wrote:
> boot: pxe_utils: Fix buffer overflow in pxe_label.num
>
> pxe_menu_to_menu() numbers each extlinux/PXE label with sprintf() into
> char num[4]. That buffer holds at most three digits plus NUL, so the
> 1000th label writes one byte past num. On 32-bit, name sits immediately
> after num, so the overflow corrupts the name pointer and the menu prints
> a corrupted label. On 64-bit, alignment padding absorbs that extra byte,
> so the overflow is not visible in the printed name.
>
> Enlarge num to 12 bytes so a full decimal int fits, and use snprintf()
> with sizeof(num) so the write cannot overflow if the count grows
> further.
>
> Fixes: 32d2ffe7316b ("pxe: simplify menu display and selection")
> Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>
>
> boot/pxe_utils.c    | 2 +-
>  include/pxe_utils.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
