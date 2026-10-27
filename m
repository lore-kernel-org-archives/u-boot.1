Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68194606A31B
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 12:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ULaicM7n;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=OgAbHBH1
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E13AC80D88;
	Tue, 27 Oct 2026 12:12:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1A1a7rR00gdb; Tue, 27 Oct 2026 12:12:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5470880D93
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793103165;
	b=qs/tUAdbEeuNbeif+8DOMyASoMEkJabXuxolCuWpT9gAU7jXtzoLxdVn3bBJRYM7vV1T
	 QX3q3ert2lirKnVqZVYtz92199khul5Pei13jmcX+HLa6c+RTLOMomKPh+yUXMncOGIQ6
	 hdvr/0Bz/Jzr0xwFAw5qK7ts1A5CSkvNOds1IZwQJWYY7WJDeZv5BEaUPun2eCkBzLlnb
	 HOd2pg2nfWy2v9erCWp/v6mPXPLYek9cnTKvH/gwJAVW7wHjVxYF5k3l7l8zADT+v+7ru
	 VO/JnHloArzr/+GojWUReB0PNdMLbKnqrn3kV8sFK9Efo+ciB81Sl+f3/LIru00ejSw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793103165;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Yf6Eph3BwidM36287adCnglfS8X8Cj2gwYdp43jw3xg=;
	b=CQFP2hxeRcUnvi7JLYFmTXDO2sGkfC2FHSW1zjAB0wk12MeX88GNTh+2SdjzpNrxdfOk
	 x3e3nJbGgK6lBJ+r/H0SduHrOuKxPCrLgSmNY794S0hmLrlEh67h9OtYU+z/B6+g1/E+b
	 q2uMjgMKpZGWMmclHOmHvw0gw99xIPn/GFfYWo8oAi3mntsGdAYWD1WpkikSskGQBJVnO
	 qcq0ZHxC9iz2EA/RIPrZL+WwUTxuDahQNZkTqnwJOdLmpTgc3a8XHKWSw2nWK4sMy/+84
	 kcWkBMO+5UgtCJ+tpGDYtsGU3u+cvxedffSWusXOJ/e5WBjr1HO/7D5X+KbB2jweuqw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793103165;
	bh=Yf6Eph3BwidM36287adCnglfS8X8Cj2gwYdp43jw3xg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ULaicM7nc6lPryS7RQIcpD9pIqMsacFMQcq+2bCnuQQJ0DoRGGZv1+p1JKbsuBv/1
	 U5hs06NedmxRh6snXS5AD2XiFA/GBJZXAHkwIiaTBtuTeARI3EwraKLFtuNBmNzfPE
	 bHPrSxkkqnnD1W8kuxNSgm2fHvuuj+5ZVWkhRqd3dAEXrtiKv/ItGz5VyrrmXb84go
	 r8WU8cfC6b8SbHivbW4iKxImOD0vGGIbniH3c7xaackIuDIbTSAMRW54a0St2usJI/
	 SAag7FBmTBPOTCjN7nI0Mq56Q32fKchvqL4H0wL18tFw6mq5xhl5UW3wuFVDfuofB1
	 vVnSWLUW4GnRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5470880D93;
	Tue, 27 Oct 2026 12:12:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 66C863D9
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:12:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4C659406FD
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:12:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G2qHSiQ4IeSv for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 12:12:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CBEE9406FC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::112a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793103162;
 b=Rv+qxtx+aa4Dvrw8EuY8mW09OBW0BAL5grbLdMBFVUN6YMvT9aCrVTqQLFa2SJ3fzkog
 sFjYMv94gzQFmn5BOMQe5MOHJZxjtxsdAU5bpRw6jZBb2+VMaIWTpokGPIUZ/2td8jw8M
 cf+pLd597BwyydKrp3fkEOCj5YRgBPKjspsEXpoxCwx9Dg4eU/EAgYuEbUNfVmZgMW1/t
 0DKCZ5PE3aFNKh2n5J2T4zWj2/zFtRWG+igyrXauaKp60aQin0J47PB6AyXMAwgfs/aSy
 ZiniGjN4hl+IFGqYCXASnH+YkBMhrxkrU7l9JR9RlNzb0OtAKEAfWDHirYeI/OVpAUA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793103162;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=Yf6Eph3BwidM36287adCnglfS8X8Cj2gwYdp43jw3xg=;
 b=hJFHRxZb+cO1AoyUTa053/5PHgA73eolj/syGvvAgRUzJuwfcbvOXBW74TckZiTdyDNT
 PVvKsIPspd31YbqYfHWyhcTH4mOXWSlUhJp9FMgcdE49FWzTM6b4YN7zOWrlcNBjppLR9
 +fdvpXbq9RRINLcDtcpRXwKC+pfTjeYygWsKsFY+5Lc+nEJH+KpBLOMvfrBUgLUwde/Jx
 Kq0ZS6iaNNn/zYO+E5j+moGgQSDrru1ntYb1CzUSpu73GzfL9erx0RHJ35P68gSTaK9YS
 2h9IPlnRLKjZta3GxXJs/Qv0WNyOrD9rSU9iVJN4oZQ7cJKZ0svDxwykRLbcQo742NA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=OgAbHBH1; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::112a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112a; helo=mail-yw1-x112a.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=OgAbHBH1
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CBEE9406FC
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:12:41 +0000 (UTC)
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-8b0f59a5fdeso33553197b3.1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 05:12:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793103160; cv=none;
 d=google.com; s=arc-20260327;
 b=opygwA1Opx/lg49DVUvcIg1J5KqEDQclcOh0RvsB6rxmuS73FtVMTX52pkH4QC6/8z
 soeV18lX1pJgHPeWP0iw3jesY8ztk1yNe4TxfBmDhOJL5RQriMyXioTt3dzjZbdR/eNL
 P5tMieuuxfH7cHlfQCV/IQGkO9Ew9BRV5leAlADjIkEIoSp0SaBEdYfZHN0LtWJinZ4M
 UclV8GvMThy0VI7UHsP6PwbBGVRY+TMYjFnh1oNgUomF459UciEJga9qAjlMYQSTKKxN
 JOJti5BbPfmqVoMh+d8BGBsAmW4UQzJMG+luyEMJYB1PIbnzZ8nQaei6rhmENxVJzCig
 uS2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Yf6Eph3BwidM36287adCnglfS8X8Cj2gwYdp43jw3xg=;
 fh=HoQOqoP1EElHLqTNFQEVgIm8ODsXPv+6ZxrYdXhxj/0=;
 b=ObE42VWydbUhYtV+Y2k3zuwJSMvdt3GYgeGGffRfX9yyXTxKhWAQXZmi47R7HMbokb
 jJIQaPjtkQE+4UAVqStRL8TItj+MiBLVqsSavrSElC390upasnr3nDUaHEQRnncJ++bd
 pPVmoiab0gC9npW4HIWooeYJIk86uid0izlZrX1nMKUC0mF/C0O4Q2DtqAqtOH6QOC49
 3bP428ehhcpVKDREgBvPnZsz9NVWh8RXLoIQf4mCIHKCmjNrOMTsWfqFSvDmdQVGjd8E
 s0PbO2wbXPLXe1pl8wSHgCVv/r08G5IBvRV7IJwmTlK+FqIOVEuLef1isIPMY9Vc3Lkb
 E1+Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793103160; x=1793707960;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Yf6Eph3BwidM36287adCnglfS8X8Cj2gwYdp43jw3xg=;
 b=OgAbHBH1iaSrQUuD7bruiIBQnuX1dBqH3Dt3G9ZBSz+R6VcJi9OmcdEG/CIkBv9fVX
 T/KoPPBzROktBQprGIgu7jjX7Ssa658pmaDZpn+YYczrk2PH2Ya+ot21yVLuxnENaNGT
 GRrvN1AsX3os82bjr/iVxIaGTUf/mHA6suEy8PtzX7e2qwGFhjo7if6PS7eecsYeBb7l
 HIVmRO1MJW/Mqo2EBIWfBYF+P7X92DVz4ct637QnneCzSX05XerBijK5IykZPBc08F/d
 jys+ffeHOffLGYbEGcNv65NBK2Bax3aEe7516fhxjkGXGR89XGPy3DGeCVIu+ECf3WiP
 b5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793103160; x=1793707960;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Yf6Eph3BwidM36287adCnglfS8X8Cj2gwYdp43jw3xg=;
 b=xmAljHOh0n5iTuzA2asHQRcHo/jCwb/ueTKu+Y+PeQGYBWegqGTHFsl5I38Q9zzquO
 Ui85lz+NiLL0W3mcpUv7ABiJ+9dlGsaEbUfghPu6ybdLU+iQvwj08UOavqZC8Qth6Bym
 YKP7V9ngJ5DPE833bK9YCbzV3Bx5S7+nxajyhykFUCNjTzAVBnUqDV+QAqDQKMVTtXzr
 P/GZgBhOctBd4mrbt+ihgm1xSKxbgJ5tmYSWR2Sp7bzpnR8C9uxah0HIxPxcDw1N+/vQ
 yQwueb4j8q0DnP7GU5Zvjkr+h0CQhAMsLOucSsdsk/WVN6T7QfMjBzB4XnvkQS3ANU8D
 dhKw==
X-Gm-Message-State: AFq9FYLEtQX7NUqGwgdu8puz1KGuxdcc13z4q6PFyDACFaKQPacGcs6J
 R7IMH5W4Q5NrJdMsx4vKJtuVJhbYIjlFComZ+XbZvj6cstSgSSjP2q2zNN87pO42jqaHjcFjgC5
 LTekX6BxF4u/gcdMjYMbKvQZbWwpHOYUsg1BGikSYOw==
X-Gm-Gg: AYBFou1aBd8wsz8KF5y625FgVEfxsuhUefFhJhdsVTw6RrnzBLVNS3pHsXxPJ2V+t0A
 ccH9BoBxmvg4t38pPMEtpiVnob6dHBqfL0JpGl6+QckKG3Op7wpFjfz+svSOY9eLd4ExlhIyX/x
 cbEZ4ou+9oRMApJgDgnJZHEzNluOUwKSfBEwESc/ShROyRo5kjVFSsG8/QL3Pi/QNZIzzanNjIN
 WCp5shbMdEaKeM4oqi04htQdLUR1QApz3KxOndzStD3wnK2vw8K6GOoltIPcfFGVSoJPXZVEzwF
 Ju/7Oj+3K4l5k6eDn3CpI97h2U5XVGaVxIq4DBNs/042E+dUfLJsod0xawPNK9gMBQ6ruuo1GQ3
 6ehv6oJ5SzbifYcfvuMQnJg56Qs1vemK2wLNCuhqSxDs5C+r80371h3YmXavpv0tLJyJIQ/UM8G
 UxSAHu0xMWkhPPepc+rJOFhg9wwJY2kyXoUrnC6mhAnhhpwwX2VffacBMlEAvGwFLANx4Hx2tHZ
 B+51z9sXt/Ql/CQEcdAlJ1Z2AJx6ygxg6nJ++HuPd4OdzhKcGWScerlGIZLv+kVAMOMrLj9e4VW
 AFTG4TMtAfPxEomWm0z+LzOqHF1ptqmy7U8TjMx+NUOEhM1CajiJbqGVfuWP/0ZOgOuIr0lz6hy
 HP687LswP0BQpvFfYOHFQvu6YuQ7th74ArwtwnSaCNw9YyFS2LeS2tdluf9UdmkhvVICNnDyjOe
 IUbcsN3UmRX32a0W/mK5pekwZbCzYbd16Jt18=
X-Received: by 2002:a05:690c:a:b0:8b0:ebc7:2233 with SMTP id
 00721157ae682-8b166c41c1cmr83780427b3.42.1793103159742; Tue, 27 Oct 2026
 05:12:39 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <08c6c3f7-4241-40ab-8a60-383b9408b6b3@gmail.com>
 <e7aa5f28-e3b6-4b52-9019-1136d4ef7a82@gmail.com>
In-Reply-To: <e7aa5f28-e3b6-4b52-9019-1136d4ef7a82@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 27 Oct 2026 14:12:03 +0200
X-Gm-Features: AclHuK-3G00xXr7ZDf_lJ860NsazHd8gSl250CWPtP2-7d3fyYoIyV5sef-x71o
Message-ID: <CAC_iWjKF3G4b_=LxsD8AHxQt_pm7ZK1E0JantZ__e_EwDDTEhg@mail.gmail.com>
Subject: Re: [PATCH RESEND 9/9] efi_loader: Check the GPT header before
 measuring it
To: Ana Bobillo <anabobillo3@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Bin Meng <bmeng.cn@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Alexey Charkov <alchark@flipper.net>,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ana,

On Sat, 24 Oct 2026 at 15:17, Ana Bobillo <anabobillo3@gmail.com> wrote:
>
> From: Ana Bobillo <anabobillo3@gmail.com>
>
> tcg2_measure_gpt_data() reads the primary GPT header of the disk an EFI
> application is started from, and uses num_partition_entries and
> sizeof_partition_entry as the header gives them: the entries are read
> into a buffer whose size is their product, worked out in 32 bits, and
> then walked num_partition_entries times with sizeof_partition_entry as
> the stride. Nothing checks the header first, not even its signature or
> CRC, so a product that wraps, or an entry size smaller than the GUID
> read from each entry, makes the walks read past the end of the buffer.
>

Is this an actual security issue though? IOW the measurements on PCR5
will be invalid wrt to what remote attestation or secret unsealing
expects, right?
I still think we should fix it, but a more accurate commit message would help

> The partition driver does check the header, in validate_gpt_header(),
> but when the primary header is not valid it uses the backup one. The
> partitions of a disk whose primary header it refuses can then still be
> found, and an application started from one of them gets that refused
> header used here.

Same as above.

>
> Export validate_gpt_header() and check the header with it before using
> its sizes. When the header is not valid, measure no GPT event but return
> success, as an error would make efi_tcg2_measure_efi_app_invocation()
> skip the separators. EDK2 likewise measures no GPT event when it finds
> no valid header (the checks added for CVE-2022-36763) and still measures
> the image. Its partition driver restores a primary header that is not
> valid from the backup, so that the restored header is measured; U-Boot
> leaves the disk alone, so no GPT event is measured for such a disk.

Shouldn't we do the same thing here before measuring?

Thanks
/Ilias
>
> Add a test that starts an EFI application from a GPT disk on sandbox
> and checks PCR 5: with a valid GPT it holds the GPT event and the
> separator, and with a primary header whose entry array comes to one
> block in 32 bits, only the separator. Without this change sandbox
> crashes in the second case. Call validate_gpt_header() directly in
> lib_test_gpt_sizes too.
>
> Fixes: ce3dbc5d080d ("efi_loader: add UEFI GPT measurement")
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
> ---
>  disk/part_efi.c                |   4 +-
>  include/part.h                 |  23 +++++
>  lib/efi_loader/efi_tcg2.c      |  16 ++++
>  test/lib/part_efi.c            |   6 ++
>  test/py/tests/test_efi_tcg2.py | 170 +++++++++++++++++++++++++++++++++
>  5 files changed, 217 insertions(+), 2 deletions(-)
>  create mode 100644 test/py/tests/test_efi_tcg2.py
>
> diff --git a/disk/part_efi.c b/disk/part_efi.c
> index efb6756cf2c..dc379559b4c 100644
> --- a/disk/part_efi.c
> +++ b/disk/part_efi.c
> @@ -94,8 +94,8 @@ static int get_bootable(gpt_entry *p)
>         return ret;
>  }
>
> -static int validate_gpt_header(gpt_header *gpt_h, lbaint_t lba,
> -               lbaint_t lastlba, unsigned long blksz)
> +int validate_gpt_header(gpt_header *gpt_h, lbaint_t lba,
> +                       lbaint_t lastlba, unsigned long blksz)
>  {
>         uint32_t crc32_backup = 0;
>         uint32_t calc_crc32;
> diff --git a/include/part.h b/include/part.h
> index 1dc510cb6b1..a886a46ae18 100644
> --- a/include/part.h
> +++ b/include/part.h
> @@ -680,6 +680,29 @@ int get_disk_guid(struct blk_desc *desc, char *guid);
>   */
>  int part_get_gpt_pte(struct blk_desc *desc, int part, gpt_entry *gpt_e);
>
> +/**
> + * validate_gpt_header() - Check a GPT header read from a disk
> + *
> + * Check the signature, size and CRC of the header, its own LBA, its usable
> + * LBAs and the size of its partition entries. The CRC field is zeroed while
> + * the CRC is computed, and then put back.
> + *
> + * @gpt_h:     GPT header, at the start of a buffer of @blksz bytes
> + * @lba:       LBA the header was read from
> + * @lastlba:   number of blocks of the disk, which no usable LBA may be past
> + * @blksz:     block size of the disk
> + *
> + * Return:     0 if the header is valid, -1 if not
> + */
> +int validate_gpt_header(gpt_header *gpt_h, lbaint_t lba, lbaint_t lastlba,
> +                       unsigned long blksz);
> +
> +#else
> +static inline int validate_gpt_header(gpt_header *gpt_h, lbaint_t lba,
> +                                     lbaint_t lastlba, unsigned long blksz)
> +{
> +       return -1;
> +}
>  #endif
>
>  #if CONFIG_IS_ENABLED(DOS_PARTITION)
> diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
> index 5f9bbe97455..c858e8df6d7 100644
> --- a/lib/efi_loader/efi_tcg2.c
> +++ b/lib/efi_loader/efi_tcg2.c
> @@ -16,6 +16,7 @@
>  #include <efi_tcg2.h>
>  #include <log.h>
>  #include <malloc.h>
> +#include <part.h>
>  #include <smbios.h>
>  #include <version_string.h>
>  #include <tpm_api.h>
> @@ -1220,6 +1221,21 @@ tcg2_measure_gpt_data(struct udevice *dev,
>         if (ret != EFI_SUCCESS)
>                 goto out2;
>
> +       /*
> +        * The header gives the number and the size of the entries read and
> +        * walked below, so check it with the partition driver's header check,
> +        * which takes the number of blocks of the disk. If it is not valid, the
> +        * partitions may have been found through the backup header: measure no
> +        * GPT then, but return success, as an error would skip the separators.
> +        */
> +       if (validate_gpt_header(gpt_h, GPT_PRIMARY_PARTITION_TABLE_LBA,
> +                               block_io->media->last_block + 1,
> +                               block_io->media->block_size)) {
> +               log_warning("Primary GPT header is not valid, not measured\n");
> +               ret = EFI_SUCCESS;
> +               goto out2;
> +       }
> +
>         /* read GPT entry */
>         total_gpt_entry_size = gpt_h->num_partition_entries *
>                                gpt_h->sizeof_partition_entry;
> diff --git a/test/lib/part_efi.c b/test/lib/part_efi.c
> index c8fdfe2f41c..e2990bdb0b5 100644
> --- a/test/lib/part_efi.c
> +++ b/test/lib/part_efi.c
> @@ -366,6 +366,12 @@ static int gpt_sizes_check(struct unit_test_state *uts, struct udevice *dev,
>                 ut_asserteq(1, blk_dwrite(desc, GPT_PRIMARY_PARTITION_TABLE_LBA,
>                                           1, hdr));
>
> +               /* efi_tcg2 reads the header itself and checks it with this */
> +               ret = validate_gpt_header(hdr, GPT_PRIMARY_PARTITION_TABLE_LBA,
> +                                         desc->lba, blksz);
> +               ut_assertf(ret == cases[i].ret, "case %d: header check %d\n", i,
> +                          ret);
> +
>                 /*
>                  * Read it back into a buffer as large as the one above, so
>                  * that a header longer than its block is refused by the size
> diff --git a/test/py/tests/test_efi_tcg2.py b/test/py/tests/test_efi_tcg2.py
> new file mode 100644
> index 00000000000..ae21ff76da8
> --- /dev/null
> +++ b/test/py/tests/test_efi_tcg2.py
> @@ -0,0 +1,170 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +
> +"""Test the measurements made by the EFI_TCG2_PROTOCOL on sandbox
> +
> +The sandbox TPM starts with every PCR clear, and the events measured when an
> +EFI application is started (boot variables, GPT, separators) are only measured
> +the first time one is. So each case restarts U-Boot, starts one application
> +and checks PCR 5 against the events it should then hold.
> +"""
> +
> +import hashlib
> +import os
> +import re
> +import shutil
> +import struct
> +import zlib
> +
> +import pytest
> +
> +import utils
> +from tests.fs_helper import FsHelper
> +
> +# EFI System Partition
> +ESP_TYPE = 'C12A7328-F81F-11D2-BA4B-00A0C93EC93B'
> +SECTOR = 512
> +
> +# Fields of the GPT header, by offset
> +GPT_HEADER_SIZE = 92
> +GPT_HDR_SIZE_OFF = 12
> +GPT_HDR_CRC_OFF = 16
> +GPT_ENTRIES_OFF = 72    # partition_entry_lba, num_partition_entries, ...
> +GPT_NUM_ENTRIES_OFF = 80
> +GPT_ENTRY_SIZE = 128
> +
> +
> +def extend(pcr, data):
> +    """Extend a SHA256 PCR value with the digest of some data
> +
> +    Args:
> +        pcr (bytes): PCR value before
> +        data (bytes): Event data
> +
> +    Returns:
> +        bytes: PCR value after
> +    """
> +    return hashlib.sha256(pcr + hashlib.sha256(data).digest()).digest()
> +
> +
> +def make_gpt_disk(ubman, fname):
> +    """Write a GPT disk image with helloworld.efi on its only partition
> +
> +    Args:
> +        ubman (ConsoleBase): U-Boot console
> +        fname (str): Filename of the disk image
> +    """
> +    with FsHelper(ubman.config, 'vfat', 1, 'tcg2') as fsh:
> +        shutil.copy(os.path.join(ubman.config.build_dir,
> +                                 'lib/efi_loader/helloworld.efi'),
> +                    fsh.srcdir)
> +        fsh.mk_fs()
> +        with open(fsh.fs_img, 'rb') as inf:
> +            fs_data = inf.read()
> +
> +    # 1MiB for the primary GPT, the partition, 1MiB for the backup GPT
> +    with open(fname, 'wb') as outf:
> +        outf.truncate((2 << 20) + len(fs_data))
> +    utils.run_and_log(ubman, f'sfdisk {fname}',
> +                      stdin=(f'label: gpt\nstart=2048, '
> +                             f'size={len(fs_data) // SECTOR}, '
> +                             f'type={ESP_TYPE}\n').encode())
> +    with open(fname, 'r+b') as outf:
> +        outf.seek(1 << 20)
> +        outf.write(fs_data)
> +
> +
> +def gpt_event(fname):
> +    """Get the EV_EFI_GPT_EVENT data for the primary GPT of a disk image
> +
> +    Args:
> +        fname (str): Filename of the disk image
> +
> +    Returns:
> +        bytes: The header, the number of partitions, then their entries
> +    """
> +    with open(fname, 'rb') as inf:
> +        disk = inf.read()
> +    hdr = disk[SECTOR:SECTOR + GPT_HEADER_SIZE]
> +    entry_lba, num, size = struct.unpack_from('<QII', hdr, GPT_ENTRIES_OFF)
> +    entries = []
> +    for i in range(num):
> +        start = entry_lba * SECTOR + i * size
> +        entry = disk[start:start + size]
> +        if any(entry[:16]):
> +            entries.append(entry)
> +    return hdr + struct.pack('<Q', len(entries)) + b''.join(entries)
> +
> +
> +def set_num_entries(fname, num):
> +    """Set num_partition_entries in the primary GPT header and fix its CRC
> +
> +    Args:
> +        fname (str): Filename of the disk image
> +        num (int): Number of partition entries
> +    """
> +    with open(fname, 'r+b') as outf:
> +        outf.seek(SECTOR)
> +        hdr = bytearray(outf.read(SECTOR))
> +        struct.pack_into('<I', hdr, GPT_NUM_ENTRIES_OFF, num)
> +        struct.pack_into('<I', hdr, GPT_HDR_CRC_OFF, 0)
> +        hdr_size = struct.unpack_from('<I', hdr, GPT_HDR_SIZE_OFF)[0]
> +        struct.pack_into('<I', hdr, GPT_HDR_CRC_OFF,
> +                         zlib.crc32(hdr[:hdr_size]))
> +        outf.seek(SECTOR)
> +        outf.write(hdr)
> +
> +
> +def boot_and_read_pcr5(ubman, fname):
> +    """Start helloworld.efi from a disk image on a fresh U-Boot
> +
> +    Args:
> +        ubman (ConsoleBase): U-Boot console
> +        fname (str): Filename of the disk image
> +
> +    Returns:
> +        bytes: PCR 5 after the application has run
> +    """
> +    addr = utils.find_ram_base(ubman) + (4 << 20)
> +    ubman.restart_uboot()
> +    ubman.run_command(f'host bind 0 {fname}')
> +    output = ubman.run_command(f'load host 0:1 {addr:x} helloworld.efi')
> +    assert 'bytes read' in output
> +    output = ubman.run_command(f'bootefi {addr:x}')
> +    assert 'Hello, world!' in output
> +    output = ubman.run_command(f'tpm2 pcr_read 5 {addr:x}')
> +    assert 'PCR #5 sha256 32 byte content' in output
> +    digest = output.split('content', 1)[1].split('\n', 1)[1]
> +    return bytes.fromhex(''.join(re.findall(r'\b[0-9a-f]{2}\b', digest)))
> +
> +
> +@pytest.mark.boardspec('sandbox')
> +# EFI applications are built with the sanitizer but cannot run with it
> +@pytest.mark.notbuildconfigspec('asan')
> +@pytest.mark.buildconfigspec('efi_tcg2_protocol')
> +@pytest.mark.buildconfigspec('efi_partition')
> +@pytest.mark.buildconfigspec('cmd_tpm_v2')
> +@pytest.mark.buildconfigspec('bootefi_hello_compile')
> +def test_efi_tcg2_gpt_header(ubman):
> +    """Check that the GPT is measured only when its header is valid
> +
> +    PCR 5 holds the GPT event and then the separator. A primary header that
> +    the partition driver refuses gives no GPT event, though the partitions
> +    are still found through the backup header, and the separator is still
> +    measured.
> +    """
> +    fname = os.path.join(ubman.config.persistent_data_dir, 'tcg2_gpt.img')
> +    separator = struct.pack('<I', 0)
> +    try:
> +        make_gpt_disk(ubman, fname)
> +        expect = extend(extend(bytes(32), gpt_event(fname)), separator)
> +        assert boot_and_read_pcr5(ubman, fname) == expect
> +
> +        # an entry array whose size comes to one block in 32 bits
> +        set_num_entries(fname, (1 << 32) // GPT_ENTRY_SIZE +
> +                        SECTOR // GPT_ENTRY_SIZE)
> +        expect = extend(bytes(32), separator)
> +        assert boot_and_read_pcr5(ubman, fname) == expect
> +    finally:
> +        if os.path.exists(fname):
> +            os.remove(fname)
> +        ubman.restart_uboot()
