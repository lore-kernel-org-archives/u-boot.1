Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67213C5AD55
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 20:53:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5C3DA406DB;
	Mon, 10 Aug 2026 20:53:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RTrf8MYqRM_P; Mon, 10 Aug 2026 20:53:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3645F406AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786395207;
	bh=zydmR+DUHjbpQle+hPXhzGo690FmZIhE38RDSAb6Hks=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G2XiF07jHo521qtCHOzTKOVef5a+hjgN6fLLpWiZIq2iVQwSeciiK/iEzxJgu4yEc
	 gRtEg7s3b8I9BatGj6mA7p0aOzOk+dhXbIWP3B73TrNAjP5VjDca4XspDVYqNEGzPB
	 1my5IMSiTqStxCDfQg7XBmTrWVbGyDnMzFrJgZ+ssm+81kgwzyxYhZ6J5SncdRwT2l
	 TSlu34DjnuKJduoWUK8Mo2J8s9JOs/v7TwoSulU54fRHpy0mOUV4YZORf22C1xDq6k
	 //lj9hWIiQnB0p8HoJ5yHJ/iSCVWwC546XrjypC9rXaFCh5qbYPTP8j2rw9f6JqBOI
	 r6AvC+tm8OjCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3645F406AF;
	Mon, 10 Aug 2026 20:53:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DA9BB1AF
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 20:53:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C062160765
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 20:53:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8eTOxLYF7eQo for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 20:53:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c34; helo=mail-oo1-xc34.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 05BDB6075F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 05BDB6075F
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 05BDB6075F
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 20:53:24 +0000 (UTC)
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-6b03e59a9b4so818176eaf.3
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 13:53:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786395203; x=1787000003;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zydmR+DUHjbpQle+hPXhzGo690FmZIhE38RDSAb6Hks=;
 b=dnqhLyvPhd8uFy31+F+rcTH6tBtsjzf9azmKeZpt5fezUy7o4qP+DJDgjF+i6e7eup
 drLIQTa2mnfehBD3t6vicrMmeYn8+JAIbdJSKpZudjj+nYERMZzKm3iYiUTuAuAsGDSn
 Ks6NzFaBj1c2HXx2dTSr4TnMEK6WOJas+jfxQluOe5HduVRehfsniZAnVM6hmhhR1oQ4
 86uoidaKdXjF63AHKW4pPeg+kVA3e01pUGPmh8JOB1bkvkr2ghtIhMXHuab/yucIzmkc
 jSNDl7g6Fmhnc7x1Gr1GROhG5Gvx877JAeNS6PEA6Dvtxn6sXMy3xVv34cv7K81chNx7
 gQvA==
X-Gm-Message-State: AOJu0YxCLw13csKHGzKvYJHoqI7uvA22s9XAb9yq2dBuvTEKVNpm8ZXu
 KMIse6TWmfNQ0eQe0BKB5rpZIPXoymyEFmFD/ZxsiiYpmiLhycZJVSdst5q9XunmHOQ=
X-Gm-Gg: AR+sD107dFtvu2OItauDNXMsuklhIxNTNnahDmgudArjyZOoqYBQWHUuDDr+/RjVxzl
 9pIdBCIhFjyLk2XORR3GbD8i5Q6FEl9twuydo1plvMXbdXv7Uhtoaqe1584h7IArIneAPZ9rcIi
 FWYHHoibxxPc5V5JNkoKvXfqOaPmYVXXuXDX/lK+RDlR1BE6BXcSv9kvPkvZC8gGw+TU+vrjqhQ
 X6xUnOPBqZZjZ4S48aF0rGRnvsRDgaQ0UfOQ9SJxpc7Di8zQZMyOu01UwyQwTKL54dIeMyNcePO
 k/6lwPhhH0C1/tDlLGZbxrJGndh7JgdkeSso0UHaebgWImfO6TzMY2p+XrsVT3xk9m5e4C0ZuBy
 seVBea5YbB6wJrGhVqpVniIkGJHp/JBLk3SvOKs/lA8VqN/QxJdazMzvuRnu68TRm2/moT/sUcp
 5jgI3jqTDud4ZfsH8Xv0eSth1p1U9BtiOXg0d43e4fuZOhx47fj2oZ9A1ZrtKosbxpcKJKSc9Ts
 AKGA3PkvUsF9bSqknDyH9jomVTcbTP0nWtxW9UBGByQ/4MgrvZ7gBOp4yQzAs0Qcr7QDaGcdEbP
 DOm2c7o7
X-Received: by 2002:a05:6820:188d:b0:6ac:a0db:1a78 with SMTP id
 006d021491bc7-6b041ee5ad3mr12179009eaf.5.1786395203599; 
 Mon, 10 Aug 2026 13:53:23 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-459f1a76701sm9061652fac.5.2026.08.10.13.53.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 13:53:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20260803231755.374057-1-marek.vasut+renesas@mailbox.org>
References: <20260803231755.374057-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] mtd: cfi: Replace env_get_f() with env_get_yesno()
Message-Id: <178639520275.1450255.15423523044503401285.b4-ty@konsulko.com>
Date: Mon, 10 Aug 2026 14:53:22 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786395203; x=1787000003;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zydmR+DUHjbpQle+hPXhzGo690FmZIhE38RDSAb6Hks=;
 b=ifvJkvIenre6HT69/EHcnXuRDEP6sgmADQTEPDRR6TL988aAOb8RzlhqugLqQDgzu/
 lxwQ1UvEoMVXIslisD4T1TpUqoNkMf8Zxl5oWscc07WcYwQMD4RbPPY9kLhUhqnVW+4L
 hNfFTpe0755qnjRpVLi4vddZ97XB9uQX553J0=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ifvJkvIe
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

On Tue, 04 Aug 2026 01:17:31 +0200, Marek Vasut via U-Boot wrote:

> Simplify the code, replace env_get_f() with env_get_yesno(). The
> env_get_yesno() internally calls env_get() which may fall back to
> env_get_f() if the environment access is not initialized yet.
> 
> 

Applied to u-boot/main, thanks!

[1/1] mtd: cfi: Replace env_get_f() with env_get_yesno()
      commit: c882fc0fe40e184e75035909aea2f3109cbe78bb
-- 
Tom


