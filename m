Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D705606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CWM4zXrf;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=mtNEWMHg
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DEEDB80F2C;
	Wed, 28 Oct 2026 08:56:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vDhQQHR7ltau; Wed, 28 Oct 2026 08:56:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A498880E50
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793177809;
	b=ZNDAowkux1xsOox6fwwq6wbL01DM2bzR38BBKQdPLw5MJdrhtuUvuRVriYHCINIOaRDo
	 F+s/nrhYVv6v9K+x4ki0PfEIm9rCDvpNy744QDHMJ9ms+67NhBE+Y7UpxV3mIvKndpnhV
	 m3X4lSPcCQogzKejalTUn+SYfIzl9lXsMB2hKW+P2r2f7LVFWQYDYAZbcmlIpwJJEMeCm
	 ur9Ty5jQ7g1pCXgYkjFxpwGUvU5n318/JuV5xVRRGVxTDQhlT5CXBivGVF0I+YlWavNKt
	 7Snmr5McQBOHE8vx0e0k9SjqnZCV/sOU3EpQY2XGExcJ39IoWFcq7o1E6ujeR1cmcwg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793177809;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=jrHjy8LQEgZvnMll/pHmxTjNarSDnxEQY6oV7+Zxn5o=;
	b=T4nThuHh23bMkqwv0QYpEZqyOdrSLFtR+2bvoy62qF3t96i0JCtkBJmlFEeHpqZsWEYl
	 TinJBIp5xxf0p64Var/vXWeqxnFsrnNIhBbzrIpgU7ZGwmXW0C6G584LszhGXLEA/gJjq
	 BfIPCqzWyL4xfj1/OcfkU0QKDe86utNBnXqEQsHbPqPkVmXX99ceBIwXp3QgEMd9wVoKC
	 G4g5sCafXQWA+SPLg/ZGDyCEdK9Nmjxlyj4JL2xGFJiIsPLvHKfiF6vDVms/b/iZIzZ5k
	 NU7wedqCaJXFhyzJfvwh6j5d0enFWIVhB+SZM8gff4KNlNv+zrdjaN75QEin/4x/hhw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793177809;
	bh=jrHjy8LQEgZvnMll/pHmxTjNarSDnxEQY6oV7+Zxn5o=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CWM4zXrfbaKZD1tGbxTipyaqD0MbpZIT2V8C70ebq2pFT8H4BIV48sw11fCihKMTb
	 87GzURXg1NKRN9s1KcxZv7BuT0HLfcgKeCHSWj4NbrobwVDUDcuOTXMLkHSvpsAu4t
	 nW4Qf2xbW1oTarhWGmfS85zEpDCdbAnZ41UsNUYaBhR/rpvSQxpC3SsyHrvQZXxfF+
	 r2dpuOCD4pmX6goL51M+yyAAMbzOtdvXUT8n3n7+54jr9PNJicOT5AfSVE9qVHinqF
	 ISjsBod4hdCFNksUeBnhXlQr7BPqPus7F09cJtaiajwyt3L5hwEAt2ICiTrGwja2zL
	 8rlSAG/NhbV0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A498880E50;
	Wed, 28 Oct 2026 08:56:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D2AC5972
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:56:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B84274006F
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:56:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id algDfTVctnkm for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 08:56:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EF1994004A
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::52e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793177807;
 b=L/CUknx3U23mWzitGfPBMVHOf7JrLe3oFfv8EEEtq1HGK/EUgSOQdfT/OhAheuBbiCvh
 OP0QbpRK7gkSbR0pO7W6JcRaicBlwdHuqSNqC40dl/KBNklZ7nx1CxF7DA9YFNe9d2vWA
 fBWrS6wJMJuZ5FENzbAIKwOA9cEKpCMwdnD+SkoEqND8QqYpDCthtnCogGjpfKxB6L30r
 U4aQ4VkWVh8w1JYDjgcwWwKcI3iXtZaOFU20zdj2J/a4ftqee2O6z97lyaVUKK0omipbM
 LyGXGovAz5lrDMlOQqb6NxHadsiNIOLQl/otF0J2u5iJmD/3fo1ji9ffuf7agvfefNQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793177807;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=jrHjy8LQEgZvnMll/pHmxTjNarSDnxEQY6oV7+Zxn5o=;
 b=JGUnexJz4EYbAvLC4AN0h0VDbzHxiyo/oTeoePukcYMrn+Bj0MWOU1ObosqvxvyQh6KM
 L1+AGM9P6OtYmFGTC0JL24BCL/FfEc3z/XALoVnG4yBOPVBx19ZjkWNYbzobmXjRzhKUe
 hBgpPUK6aMZUu1OIjJn1ADP5dtjUmII2a10Sj7A3rdHMTKgtbU1DjrDOntoOOdWn2SQXY
 jQMZfXDl24wWCbDIQiJ+VOdWNZJ4Y/OZMLDb9l5LutD93gTA4Bo6MRyUqx5jmxO8AIACh
 Q3i0WhirROhTFSgNd7fhR9Al4P7M17X4ejaW8eyTelvuWFAWvk0aBsku96ZzY84KxNw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=mtNEWMHg; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=mtNEWMHg
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EF1994004A
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:56:46 +0000 (UTC)
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-cc502d509c0so300695a12.2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 01:56:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793177806; cv=none;
 d=google.com; s=arc-20260327;
 b=ciIYbNpxGZpIrKKsam4v1i3DINszEiHFkglVM5j8EzRoK0ymgiAhwmJUCNGeEfkv6M
 yQvfwtg0IaF0VsSt4douYuqJGI9A+2AxzWsfjgl+Dq/9x22D+Ugqtf+GALB9RSSW6CMv
 cbmxx/T4dKJUB88AmGNVtw94MYx6sRNjybwB048cA4OPVTEqJ/YQJP3l4Y7izBuELg0C
 pLZJvNtyE5AQOnvgCHphJ8r80pdWTV7bS6c8/QDYDrsxnDD69t3xbUhQ9AGkPhSECshF
 MH5zmJ+2ygANkkRZIN8NE/EbC4s6rYAsKrH/lTOfQdLzoT6iRTKjB77DZ5phw0MWuO4B
 fzOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=jrHjy8LQEgZvnMll/pHmxTjNarSDnxEQY6oV7+Zxn5o=;
 fh=nXfdtx6KaZXoOOnJ/bcbCmssJjaFuBlWGa6R1gOcoKc=;
 b=PkqHcq05KxlAMR18JjiE3kz6g3+ltOt6ZmFOUZvfRr1w4ZVgxDaR+UZlvnjGqzi/z7
 7WjHwlWI67ic/plCJ1EV4qjzY5jfXgLjTL1HbZkbLov61p8l2mgL0KPKr9ukiZrcpdsR
 98VGdx1KcecdHzpmPyDw00B1WgIcLyjHujZgnW1nrKyGvOj/cBcxolB7L+K55WsG+H6Y
 WThVhImR/dOeoCJFBT8VnJ9SyMAsHdjt05g+l71vB9wOOAsq8ZKEvwuLgOOjlnQBcq/+
 JOZHb6VhM7XUIZnysi2W19mRYnPweuqsobRC/l+CVUNA2QV3wuKKfP4IrvPJA1wd5m9M
 9waw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793177806; x=1793782606;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jrHjy8LQEgZvnMll/pHmxTjNarSDnxEQY6oV7+Zxn5o=;
 b=mtNEWMHgNT5I/wZaRu4ShyY5X+eUYRDY5M5KOBc1XmaxW3Pdq5GVCzgPHEm07EYBvs
 vGsQBraIKHIfjfs3P3O3c0K+0zNnfGg6QIo5yzn/x5q3BlbOf+K3xm9ehIOQ+a726PK3
 pVdUkkacijV3hnw8XHzobpGDiqVjSYhg3azGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793177806; x=1793782606;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jrHjy8LQEgZvnMll/pHmxTjNarSDnxEQY6oV7+Zxn5o=;
 b=qM/bvYRESs/CHo/Av3/5LtJyKgZoDxBEs21m0wOT4PPftiKOAkqFCp2zovvtpjj+/C
 6rdBj3IOyowaUYeBAM7nHuGQwF1+4jg7opCyU6BkWZpEC/7+inbmhJiqFU52jLdj92ja
 CoPOf10KvLebR7UOLq8n/Cp0jMgAEYPo9RtysM7hWxb9QXDuGv/cbMiVAmiYsJWniWav
 e7daMs6ONYxA4HrK8/1ikYsLQegLEt/TGt8bqhtF/uAbTJn+EPu0dlYcxUAEPXTVAnJh
 5nH6oPB/9wqsxJUHioJ25ROpBAPa6ECu0sQZG3E8P+sSOeWbDm46ddp6gZCqMfSPX69N
 xenA==
X-Forwarded-Encrypted: i=1;
 AKwUvByiWFgx6hKamUsEuaMcpVUbrFtqzJRDhqTf9rVYE+0XStCfxVOjxm6aYmMvBbZiRJYlbDb+i8U=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ2sRvo0Za5FLZHcGnMCBn/02o++nkyWWbgRmuXFZR08pvlSdNX
 ylMajaNq3pcC6lNluuu2PYb27bep68tIuszx8xJiqPDCpxHySjTP+QAX0Ir9IahD/0UXopQ8cuc
 SNJa+r2avfAlHSecxpRyziSDiRpeeYE27ljngdzVI
X-Gm-Gg: AYBFou2uIb+D6tT0cK5FHDx+pX2doL0KA+UcouiSGAfDmkthnSuDmHFbIrq1awrYw0A
 CuCIuicsIR+kaGfpnNffrf4PN6HYir38/mO9EYEaJ/CScjZOw4v18sF8SsTXFCSlOSZxC8j1Cyd
 31OAgezEQ6aN6W7YYR242YgnZyC8KP+UuuE9m5oKvj+MNYxjvcCgLLRdHm1fFYdWRDE9fe4rOrK
 DZNN0nXiDt5jkEsCqOHaAWe0KhSYOXyFTHo15ULnPf2W1C0twun/cJAOlORF6AF5Vxb5FUYOtKR
 NgcAXFKXVBZNl0z0w5FNwc4XG0Jn/bwJ3Hy6Ls8MpADpNce2KPynu43xukNwRiuf+ICDnrG2ycM
 onXjry1Hg/Rs30WvXqunF01oHXg2qzA78DmI=
X-Received: by 2002:a17:90b:5345:b0:3ac:a7ee:6780 with SMTP id
 98e67ed59e1d1-3ae58316552mr1290882a91.66.1793177805846; Wed, 28 Oct 2026
 01:56:45 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 03:56:39 -0500
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 00:29:42 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a1bf0bae-f3b9-431d-9ebb-cd82fc1f294b@gmail.com>
References: <01ba3f81-06b7-428b-9224-bd887c35e1c3@gmail.com>
 <a1bf0bae-f3b9-431d-9ebb-cd82fc1f294b@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 Oct 2026 03:56:39 -0500
X-Gm-Features: AclHuK8I2LYRO9Mm-ZkVYMSZj_Wy8GrM9Np9SH22xLEz4CfxYyZi0CzmEI2JTI0
Message-ID: <CAFLszTh8g=XGbk7SYaO85g=RpazEzVVEbLTpEzQ3dWRo0ALYnw@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] ide: Refuse an ATAPI block size atapi_read()
 cannot read
To: anabobillo3@gmail.com
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org, 
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-28T05:50:48, Ana Bobillo <anabobillo3@gmail.com> wrote:
> ide: Refuse an ATAPI block size atapi_read() cannot read
>
> atapi_inquiry() takes the block size from the READ CAPACITY reply of an
> ATAPI device as it is, while atapi_read() asks the device for, and moves
> the buffer on by, ATAPI_READ_BLOCK_SIZE (2048) bytes for every block.
> With any other block size the callers' buffers, which are sized by
> blksz, do not match what atapi_read() writes into them: a 512-byte block
> size makes a read of several blocks write past the end of the buffer.
>
> Some CD drives report another block size although they read 2048-byte
> blocks: 2340 (HP 4020i CD-Recorder), 2352 (Philips CD-Writers) or 0.
> Take these as ATAPI_READ_BLOCK_SIZE, as Linux does in get_sectorsize(),
> so that a drive reporting 0, which ide_probe() skipped until now, is
> read with 2048-byte blocks too. Refuse any other value: a device
> reporting one is left with a zero block size, which ide_probe() skips,
> as for a drive without a medium. This refuses drives with 512-byte
> blocks, such as ZIP drives, whose reads of more than one block already
> overran the buffer; supporting them needs atapi_read() to use the block
> size of the device.
>
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
>
>  drivers/block/ide.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
