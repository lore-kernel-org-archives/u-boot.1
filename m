Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47B7606A31D
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 01:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fTn3fGG/;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=qpntqEVx
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 26CA3810BB;
	Tue, 20 Oct 2026 01:07:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BozfrVYmMldw; Tue, 20 Oct 2026 01:07:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C2E65810A1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792458424;
	b=Gh/smtgX46JxKyI2uosJQdhxHtT23FzX9Ym/8SI50B2oqq5tJwPHQ2f3FS+QJmk9yDN7
	 UwI3gVIpAo/28ZsCpfl6HB2Ev7V2r15n6CTnvBIGG6dHphkvmw9pkXdZP7FrhWH6kI1C4
	 K0h10HIxamVrI1PhybFAaEtcFqU0cFWfV6WjNCQ8deygfzGff6KCcUz7/bnkaF05wxVEm
	 aadlieni0yf+pxhJNA+KayhjflV96N5NNy+Aic74nXvrbcjGQygBLuaV24fXCuxn/L6T1
	 W62DoBRoEzhUtJ90uBZUCUlHmvn/6QhEEqiDfxK5qKslTRlFseAP+xOWkTabyW7JDtw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792458424;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=q//8xDjlENODqmy+3h7rAaUGufWGUnVeOCqFQCmJ4KU=;
	b=Nlkf1Rj1bqFIgqg18aZIgNal8iThmgvoUfoPEr+S/BiKqYTHWXpfaV+bO7wAXiulOz/9
	 Ma+bWzXX2vZ2XuMKWT7rgZ+8LMm8veL4JrUgMdpnHjGS6hsUdT00YBOjj9cbhjM9idO2/
	 8XbCu6xwBHVvACmbwHOipbDqxY+R88gWDwdxjJS9/S4bkSFmYRPTJ5klCnUmhuJ1JmswF
	 OFu1w85/f+xcPGyYKospBdidp5B77H5/klvrfEZIy9qvd4iJSMkx2GsdN/eSowtMyp5Cg
	 eAjv8tHY0LrfaPsCHzdCQlb3ganjUQT1e9wiX8Qx8gi3lOWylRx4W8glLg9Cavw4KWw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792458424;
	bh=q//8xDjlENODqmy+3h7rAaUGufWGUnVeOCqFQCmJ4KU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fTn3fGG/jeqDv0pvvglNwahCg7kUz7884Y31I2hXLuHQrEFMVr73QiTy+MZgrtB7/
	 ztTZLY1eq9Lfeo/0Szgke98irbd2SiyXXV8Tw5++yp/4Mm58zHfnz8xHprjX36n/eq
	 nY5kbg+1zOEs4knhY+Sjc5R/9VHrsD3HMtemmbFnxzsPbkMPRjE/yepxucJDEPrzmo
	 hyq/rFOAPWuu1vHxe4uW5mIbbucmYC665iDdjSPOSx7rPA5dhN6AlqQ3KswlqYcoM2
	 GFhKbidvaMQQwZC7L6E9n48jrzSL+BM/nwILpVCrYc7ge+OHlU8zlD134n3fXGhVPT
	 3gUKGfmXnBOyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C2E65810A1;
	Tue, 20 Oct 2026 01:07:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8710523A
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 01:06:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6D0D240313
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 01:06:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PuSLmqRUW0m0 for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 01:06:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C3EFD40312
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792458417;
 b=n35MmiU+1wdrAQlAEIQnuYk/MPQA5XoXWVe4Kfq7gTKZkIIjsFcHx/Je1QfjxUup1oSZ
 ZnUEI7iY4ZCo2R7j+ilaIWZagjr0AqT+FrRgfH/7Erh+A2SDWjVLZRw7Y8Ew1TGW/kfVn
 ntmKrbc2j2A+r3a0c8W5hs2h2lOceaywlcB4xeUDxVPXlvucG0pCwpDdwtQZGU86MdGhw
 t/6Tu2YaAEmH8dz55dF6KvrPxOBVyOo2704ZX91EjwhsEeByIL+brX/VPakLbnlDPQXxN
 uCeuMFM0UN3HN/2x9Mzwjs1UC6Wci8bjg7rXGM37m2U649S15GHJmQe1L7ls3cK57SA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792458417;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=q//8xDjlENODqmy+3h7rAaUGufWGUnVeOCqFQCmJ4KU=;
 b=Zc98bjgXVLeGRHQo7sXjFJ5LqOVY00FVFXe9go5iS1+E+Q9t6USky1JdzgXIHXEeREjg
 NtKIYjgRo4fL07K8EqCCJ8iJbsenjXQ2AR4zs6QYdsQUTWFJZV3ed1vEVQMgfIZvuhkbP
 Q/eS/BER1oOaKoiR7NCIguzvEdzosilOBh/dBWP7UA1tHH8KT0Sk6PVIEEqMSwK/ksArY
 kFt3FhkieOdQrctM8jk1BLXQCsF4HCA2WC0jRT5+QEG0f4UzWT4oBXpUtqWweqKuob18k
 Qn3zvthRGeQYy0rXFMe13Cj8UmmUDDEIMDx/VskqzXkfTSzBsJBy9lJnIvkAQfEDw5g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=qpntqEVx; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=qpntqEVx
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C3EFD40312
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 01:06:56 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7f48c750afcso1376914a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 18:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792458415; x=1793063215;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q//8xDjlENODqmy+3h7rAaUGufWGUnVeOCqFQCmJ4KU=;
 b=qpntqEVxFV9LIUkid5mXA5RrfAD6FuM+ZAxjALkZT7pXtwUQuK2H3TQDJdahFu+9X6
 a/bcmGVX1SKz9eUwTuXMyTM/ts90woYk8S7iqwolugaS5jda4CmaIz1sCorTBSTr5W1v
 CrBe4iMbsp+JJAFfMTVtzRCdH+3HPVxY/xX+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792458415; x=1793063215;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=q//8xDjlENODqmy+3h7rAaUGufWGUnVeOCqFQCmJ4KU=;
 b=EgzFxRUkSwps9DXTfxK2aKIvUsmYQd0O+dJN/NtMlff8FIrK9cNJzhqYqClHxxwy9K
 SNq4CC0MaoQRZ1PzLf1g63e9m8vVk4Ta4L2He1DgNCJwYOhJuNyabeKtsBERx3W4PNxG
 OSX5Cw4bvF0Xvi5p4dYZsncFAQmXsxahwhcCqT0LnmmuMCI+QHBw1YJouVVYIvgs1/MP
 yaf/9XKkieph+FHRQQezKng+JbI+swIovdFoRJIt+Wh4JBYP714PI5o2WkdErkaql7Xx
 a7SmusfRNALoz+vCT7aplzRfPTk2rRnNC+O/mSp/e5xiiiTbtTRCRm7WmHRFSKpkSFU9
 7fmQ==
X-Gm-Message-State: AFq9FYIY+73lA8xEYlRHLpypi8uhthYpfr7nFEJasq0YhsYlkKizl6Th
 84UwnK48UDIBzdCGMCQyEAw5QsEF+pnX//bL0OJtYMwtcQyoYrOczR2/ig7vVzxQA11ORZ7Utlk
 QdA5vcNwsKrOg
X-Gm-Gg: AYBFou37jJZParZHoiDbS0RMzU4c+Ss0u/ProdeI6qwKF0jr+f4eEtHqCIdB78XottB
 ePmXarcqq6FlBX+D+z1jdWr8nkaizqmtHQLERbeUiUgAgQKNVbDfien/7dsSW1Vohud+57gJk9/
 aibvwfEzWGqL1tC3HOZHonMxnTpslWljN/kj7v2sKK2hu6UqtLju3lR/zQln1TdloPPOrLxICuq
 K0835Et9ARznRSE5aoyUyRgngTCrQM1tHWI/NAl2HoHfRSkwH0c1w9aBSOyQhaOVijHB77gxi/Q
 TXPuUUUNsNfIpFbNfg62KdwpZtStWmaR3Mnd65wZ2edJ4Pp6pkNXV7snpFF29oPknB77oOyOXdK
 k8Uy+znDM+hW/TxTUOiMD5pna3A08QZQqIeJBJXjeQH4C1pggVTW03cjMUeTiq0qv7BB4NAnByV
 XBUCJQ/bWCFzpsHEg8W6ycQTBgce+GPiO0NAcbDNWtCK+Kiojma6Qj642deJrrt/bbgvx/50TRO
 IYpr08w3xDqsuZdEbD7u6bk3k+LMrfmv7ADFdgure9f/2EJo++wobJD3ffMh99Rv7lHIlzEr01i
 BFnrhLL6Y0V1rGmHSA==
X-Received: by 2002:a05:6830:f87:b0:81d:6a2a:7db0 with SMTP id
 46e09a7af769-84500b76c4amr8102928a34.23.1792458415346; 
 Mon, 19 Oct 2026 18:06:55 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-845b9e280dbsm7868871a34.19.2026.10.19.18.06.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 18:06:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, git@amd.com, sjg@chromium.org, 
 Prasad Kummari <prasad.kummari@amd.com>
Cc: michal.simek@amd.com, padmarao.begari@amd.com, akshay.belsare@amd.com
In-Reply-To: <20261006110919.396293-1-prasad.kummari@amd.com>
References: <20261006110919.396293-1-prasad.kummari@amd.com>
Subject: Re: [PATCH v2 0/2] rsa: fix rsa_gen_key_prop() buffer-sizing and
 zero-modulus handling
Message-Id: <179245841409.885845.3932414530861951582.b4-ty@konsulko.com>
Date: Mon, 19 Oct 2026 19:06:54 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 06 Oct 2026 16:39:17 +0530, Prasad Kummari wrote:

> Fix two memory issues in rsa_gen_key_prop():
> - Correct n[]/rr[] sizing to prevent out-of-bounds writes.
> - Reject all-zero modulus to prevent out-of-bounds reads.
> 
> Changes in v2:
>  - Patch 1: use DIV_ROUND_UP() instead of open-coded rounding for the
>    n[]/rr[] allocation sizes.
>  - Patch 2: new, addressing the num_bits == 0 case.
> 
> [...]

Applied to u-boot/main, thanks!

[1/2] rsa: fix undersized modulus buffers in rsa_gen_key_prop()
      commit: 0745fe3426e5c22e2a81257985982a129a891800
[2/2] rsa: reject zero-bit modulus in rsa_gen_key_prop()
      commit: d29cc201be9bfba3db5b18a71abb0b7052eaedb5
-- 
Tom


