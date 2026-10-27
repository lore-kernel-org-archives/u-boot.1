Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EA3606A31D
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 08:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UWPlF7fc;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=CwnuWy+4
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D25264075D;
	Tue, 27 Oct 2026 08:59:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xNgVbnIAUXOE; Tue, 27 Oct 2026 08:59:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B122F4074F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793091583;
	b=HHERBEnKA6PuHGfD+35GE74Aj7Xt1Q0nvkdvwSOtQTc8zk69/9CNcvVGNSIC3hsQp28x
	 G6YfnEirNJB02UAAiJn8RNqSREizrFjMxFg7itMjBkGStotorDKvp3HAWdm1vyKWnVbnu
	 C9ykUnWOIDSbm3NE1++xZf+74Kmp15k0zTK3J5cOhC5vZUU7MHy1vPhxkDujRgqg7nmWj
	 RSYaLbtlb22n1tMcP1YGCeLFsIOk+ujlRKvBn21XKC5TI/0E2bAfcgD/5Ucq0zTv6JwvF
	 uCqsL1FsJi069CyXIrY1g82OcXZkdquzDF0wxkLnJnAetLBFplEd59v3hnwnYiv356w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793091583;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=k8Sf48FbNSBOv9ZBpo+LA3K/8ZUPCUMiVjeEZAKRgIs=;
	b=K0b5Ce37Mp+81l30nDbBZNAHao+CZBny/1QAjnf3wBqlNXDckUI0ABBV4jMS9CB6yEAt
	 Xe3tugIbU33O7U5VVUD6c1MMi9mykhmlSYSyzsCZJCdn43OTMhoB4wYLlF04/ecMb8/HZ
	 dtPo4AhcksGe+u+cHPN7/4/eJHk4ITGrYnw0QUxFQARsGtQZQP6GNerZHU3ugChDTms71
	 39tYwQHJH45Kwmb1VH7+0C85gZTcru/JfA6wiqrj5SKY9JRinEtMKPaK2XXRMLK5lg/HN
	 7dehTb874gb+l/MBENKXf+7Tvxpr1vuXlBJMvGs2x6C5YSj68HznPE8+wtls/ZWcdSA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793091583;
	bh=k8Sf48FbNSBOv9ZBpo+LA3K/8ZUPCUMiVjeEZAKRgIs=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UWPlF7fcP1HZ/KA8zZwRJfYHm+YjixPzTtOQb0Ksoe3GMseA49QbnqIt/ESBrOHXB
	 gSLsMcbn9ZXvPj6/fbzlRfeSmI8uqU/jyQky+ogV8S9nqFrMOL52jnF1n/9qlNZzfr
	 BzlNnxr7VN4SttA5SyVi8Qu0ChTq6SvziiPckfrHxCiwfNCYf82buSTEVxoAQvbcOi
	 tTjSFPtjLnxZ2+i611ykjcBTGlN1LntBC5AcBd9MgB+d3pWQOEASqmYIsE3/XFLt/d
	 8yaJPGt5Xf8/HetFygijfbrDP1GKdoKEGkUh0mvdPI6sb6fl3MvKjugzEmQKdORO0k
	 yXFbw5fy071eQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B122F4074F;
	Tue, 27 Oct 2026 08:59:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 129514BC
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 08:59:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 04646605EF
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 08:59:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qK4WvI_1buVC for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 08:59:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 322F0605EB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793091578;
 b=VNum83blVTtzfmw1zfGXfTp3p2G9aZIV1oTCP/j+DhIMo25d3N5O2wI/VUypXY8p0QYf
 IvLPjNF2uNKoGXorfCZx0AK6UyLyzUScWoQ9ptg9GZzGhkGFBuwBA+8mQi1cV/wLoGS+/
 /GCWeRkLLtQibikZUFdy0PG+sc3homsVOuVfl2WKyvqJ6E+r22fDry7NnSsxPhuF+Jd9t
 igvAzfh+28hriUp/7xLHVrBLceQWzz2MybTZCTmh7S8RKGKIisoXCsPCNAaNOGRSQMtxn
 qAOyPAVuWeYc6qjQVGEMK2bjGaTp0qwixeEygdQJiWA0XxEJNrldS0unUCXEtLrPHhw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793091578;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=k8Sf48FbNSBOv9ZBpo+LA3K/8ZUPCUMiVjeEZAKRgIs=;
 b=fUWUSN1N6wTeRbqC6czH3VjuGYCb7F32feRgH6uZFXEguB2KvENY6ipq7hRyepwyVkn2
 4aP6PLNPvxPG6AMPR7UcEjd+IB56GQ8CWhcI1bsOGhKn6ZuTWGrTCxDXOrlhWBHjIOOzt
 YgTtM/uQlGEeSE5be2ANXA/K9IZOsoW/Ckb2O05B9pySBeIPl6n6iXZHpXxpfjms2vinI
 vgCCuh+bb6+KXHRbhNAgsn5pmhp+FfmzemuNHWJsXLXjD3BSmFcOFjaZbN77srQ9my0dB
 iL+qsfz9Q4fe21tQsdvRdDhSyXr/NoinUTgg0KGOsIuCy/NjeGeSCjy0eU3X8GigeuA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=CwnuWy+4; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=CwnuWy+4
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 322F0605EB
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 08:59:37 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa2848d2so6369792a12.3
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 01:59:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793091576; cv=none;
 d=google.com; s=arc-20260327;
 b=QfMzZcKP1AG2p+ArQ8iSq0QD2CDnXiLLWNp2xwBe5NZhgcNRikvwdrDt8lZsGGiIPj
 87esragLxvay6GKA5T92dEs3Zy8VEx32V7cJ72HTCW2hrYkLRBqiNxwGA4YZWd0CFQ4s
 vfprvZDJe15IfZBD3GXiykIFMVWLDYP3orPf1L6OYRJOj0YNID53Rsz3a0/pIRSZCSKt
 9OycIyjfNoAvnqDI2L8vZgt9pXozM2FeCIAm/B6kO30UPXyciw+t90HXeL+SQ6Km3Ej6
 vtKO2AtXLIzKq5bI4ru+9pggi47vaWTFiGegpVLgzpRb66AcpbazzMZ88p57cu7/ejXT
 /jdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=k8Sf48FbNSBOv9ZBpo+LA3K/8ZUPCUMiVjeEZAKRgIs=;
 fh=/rdnnAgt/z8Y/gO/kkwLsOp9dS2eruYSp+dyjwHJTc8=;
 b=kPeJUlDixPNhpDvaTcb/Jq/pJhewXQIzEf6Qet+C8dAmfS5ygq7QedvwmLIlQSZ5EU
 ic15C+PaPls+zJaetmyoYT3guNdVD0Om/XdTI1ri3Pls4gF1GncN6Xsw+wLwgkHREZ79
 HMBN9sAMaSjDcGJpJ/3VG8sJT6pN5J49VSeWLqgguA5Ow2Y+5hTK7LXkVFWMkVmrE8uh
 +pr2jPwTv+YmVSspDbgXQJ1xIFv0y139aURd4YeSw+FdEQa8N26yd1PACwiTm4x+FuD7
 2A9UTh8Ar0jWGCvSy6WX7tw54q8tC+UWXe+qZZ1aCI+VENGYx6ICQoeojv3XyqB9245I
 j/cw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793091576; x=1793696376;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=k8Sf48FbNSBOv9ZBpo+LA3K/8ZUPCUMiVjeEZAKRgIs=;
 b=CwnuWy+4aidyhXT+LVZGI8Zw4CFeFmLaypgjgac5yiWBL5RlSZVKiIAsbBjofgSDUa
 aMh7k/USNIqg3hq9ZjAeATLybHdajM8BtwcS2hyRnLnISl7Y8tcCMRic3i3PNxq3RlW0
 ih3MFLzQ4XcwNbC/VTewnSGYi/VyAZA8sLWYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793091576; x=1793696376;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=k8Sf48FbNSBOv9ZBpo+LA3K/8ZUPCUMiVjeEZAKRgIs=;
 b=y3SI9ruDDjsneVO/nzhVOJvRINdV16xc9Lrde/3rxnsm/2wcHpR18x8B29EhMqArzs
 nSblXQxpEAJOxwYYyp3XXiSf+MC43Ext+gN/FApJUb+4ltatkXHyw31jTZIl+4XghLFM
 ADDKh55IxXiO96Go7LdesSNfd2FHpB+0vNiv7uZ5iC8HuiKUN1s9R66h6pnGfhRP2gZy
 9D8r9T44ZG/dcIOSMPHcYfVhMDZjQqwiOzY31M10kWEFAk65ePdsXKdbiWPnjDeJNAKj
 9sr4+5J9RYOzbOr+Wbe2i7GW++9A6a6evGvLQ/z/zD4GCPhdJJlrLrkSdtuMDtXZvGEo
 GRxg==
X-Gm-Message-State: AFq9FYIdgWT3hzePH3u/zqqrzfdWMYO/Fqh+1ZsxRvcNZu9NFCcVUS3I
 BT8v559CZ6i6CG0tFAI3dBMaWB8ecKeBzXm+ov4NxAqxYWzLKGge9k0ooFmm+4Rspb272UccI8k
 24XxqNIad95gx1H5jl/5YDyn87VehkoOxX+B28xAI
X-Gm-Gg: AYBFou01jvj8AfxL6f6VxHix5kQmmxDjY0EyEsKKF80995hobQ58qQuIWRFFe5OvoY5
 WWlx/SqnG8IVYWp5rkhwR94OUxjp/JLuNET6egfRpFXLqjwy0veAyYFsYakRQkByoHjLi+xWUEc
 99kEkZJhdmip5HLnguI/icxV+BsP4lx0sO04LyxpkogHyrTdhrqghHCZQ5I8RrMLXisT+3h8eh4
 rN3JxrGDzhpoC7+6UTAEcuaSlrD209cvFNvh1bYhFCBgxCrsKtjGijgoZtjlh39Xw/E2fR9tsCW
 CQZcpxDTfbFKmmuoKL6MdFzmkhq7xrgbGFihmHbjxCVd7cVtiH8pMvwBk4EZtecSkjVkX9Me9wk
 locmlhRBsMUKF0Wa6J8LIGf3qrLBJQi/ZDJY=
X-Received: by 2002:a05:6402:42d4:b0:6b4:77ca:222c with SMTP id
 4fb4d7f45d1cf-6b477ca25b5mr2557298a12.42.1793091575764; Tue, 27 Oct 2026
 01:59:35 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 01:59:34 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 00:14:41 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <e6e3595f-6d68-4162-8df2-ef100d952749@gmail.com>
References: <08c6c3f7-4241-40ab-8a60-383b9408b6b3@gmail.com>
 <e6e3595f-6d68-4162-8df2-ef100d952749@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 27 Oct 2026 01:59:34 -0700
X-Gm-Features: AclHuK8jspnm3aCMmxts_8T37MmC_1tCU5hYWoNjXNe9QnnlQ0AyQxPBHhX_80Y
Message-ID: <CAFLszTip9eA1+=DSMQp5ZVr2-HruD-gjACgzoUODXjWu++6s_A@mail.gmail.com>
Subject: Re: [PATCH RESEND 8/9] disk: part_dos: Make room for a three-digit
 partition number in the UUID
To: anabobillo3@gmail.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Bin Meng <bmeng.cn@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-24T12:16:28, Ana Bobillo <anabobillo3@gmail.com> wrote:
> disk: part_dos: Make room for a three-digit partition number in the UUID
>
> part_get_info_extended() makes up the UUID of a DOS partition as
> "%08x-%02x" from the disk signature and the partition number, into a
> buffer of 12 bytes. That is enough up to partition 255, but
> MAX_EXT_PARTS lets the number reach 256, whose three digits make
> sprintf() write the terminating NUL past the end of the buffer.
>
> Size the buffer like the UUID it is copied into, and use snprintf().
>
> Add a test with 256 partitions, which catches the overflow on sandbox
> with CONFIG_ASAN.
>
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
>
>  disk/part_dos.c |  6 ++++--
>  test/dm/part.c  | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
